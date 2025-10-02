Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D5CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7B4828A2;
	Thu,  2 Oct 2025 13:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IF8Kz78N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C172E83526; Thu,  2 Oct 2025 13:43:19 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0882B81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ccqg65D4yz9sr5;
 Thu,  2 Oct 2025 13:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759405394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fhJ5IbZ4Gvlh+QXlAJtyNFR7SUaLllFs4QZZ1KABFc=;
 b=IF8Kz78N2+CwpST09JcrfIbT3SfWNlvtrqS7YODXtJiUzvKTEpOmuiSdNjbO1l90iZkC/Z
 KxMVW+TXXapiPDVeM3a2sbpwGrAoo/dhbOemkixeuTuiRRqePh91F4mXa4ZRqxdwropz60
 2hnNEJRB6c8mzBVLYXXEce5dGcqxVsjJJSny6YvWtlqYHo1o2QCR6AKWEYI3e7Apr3uykI
 rH9Ksj9HqPaxMBRIclO9rrNpjc0fldpk7sVkjCfhdHTEp16HUI7yazVAP/o0paHK3n0+8Y
 hirtUBu7fIE5z8jCWb6sbAKQxqJUXWrTdWrOWXhgtyEeglh1eA70/FSxqSAF6A==
Message-ID: <7dd7a6bb-566e-4402-be15-256e76bf7159@mailbox.org>
Date: Thu, 2 Oct 2025 13:22:24 +0200
MIME-Version: 1.0
Subject: Re: activity-led usage
To: Yegor Yefremov <yegorslists@googlemail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
 <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
 <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zgw7z8ogkre8mff69x8u8xq8fnuxazxd
X-MBO-RS-ID: c04261bec95f5c69152
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/2/25 10:22 AM, Yegor Yefremov wrote:
> Hi Simon and Marek,
> 
> On Wed, Oct 1, 2025 at 1:09 AM Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Yegor,
>>
>> On Tue, 30 Sept 2025 at 08:48, Yegor Yefremov
>> <yegorslists@googlemail.com> wrote:
>>>
>>> Hi Simon,
>>>
>>> On Tue, Sep 30, 2025 at 4:13 PM Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> Hi Yegor,
>>>>
>>>> On Tue, 30 Sept 2025 at 06:35, Yegor Yefremov
>>>> <yegorslists@googlemail.com> wrote:
>>>>>
>>>>> On Tue, Sep 30, 2025 at 12:29 PM Yegor Yefremov
>>>>> <yegorslists@googlemail.com> wrote:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> I added the following LED definition to the am335x-baltos.dts:
>>>>>>
>>>>>>          leds {
>>>>>>                  pinctrl-names = "default";
>>>>>>                  pinctrl-0 = <&user_leds>;
>>>>>>
>>>>>>                  compatible = "gpio-leds";
>>>>>>
>>>>>>                  led-power {
>>>>>>                          label = "led-red";
>>>>>>                          gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
>>>>>>                          default-state = "on";
>>>>>>                  };
>>>>>>          };
>>>>>>          user_leds: user-leds-pins {
>>>>>>                  pinctrl-single,pins = <
>>>>>>                          AM33XX_PADCONF(AM335X_PIN_MII1_COL,
>>>>>> PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
>>>>>>                  >;
>>>>>>          };
>>>>>>
>>>>>> The gpio-leds driver is working and I can toggle the led-red via the
>>>>>> led command.
>>>>>>
>>>>>> Then, I created an am335x-baltos-u-boot.dtsi file with the following content:
>>>>>>
>>>>>> / {
>>>>>>      config {
>>>>>>          u-boot,activity-led = "led-red";
>>>>>>      };
>>>>>> };
>>>>>>
>>>>>> I have also tried "led-power" instead of "led-red".
>>>>>>
>>>>>> In my final DTS files I have the following nodes:
>>>>>>
>>>>>>          leds {
>>>>>>                  pinctrl-names = "default";
>>>>>>                  pinctrl-0 = <0x56>;
>>>>>>                  compatible = "gpio-leds";
>>>>>>
>>>>>>                  led-power {
>>>>>>                          label = "led-red";
>>>>>>                          gpios = <0x57 0x00 0x01>;
>>>>>>                          default-state = "on";
>>>>>>                  };
>>>>>>          };
>>>>>>
>>>>>>          config {
>>>>>>                  u-boot,activity-led = "led-red";
>>>>>>          };
>>>>>>
>>>>>> U-Boot cannot find the activity-led node.
>>>>>> ofnode_options_get_by_phandle("activity-led", &led_node); returns -22,
>>>>>> because ofnode_path("/options/u-boot") fails.
>>>>>>
>>>>>> When driver debug is enabled, I also see the following messages:
>>>>>>
>>>>>> bind node config
>>>>>> Device 'config' has no compatible string
>>>>>>
>>>>>> My am335x-baltos-u-boot.dtsi code is similar to what I could find in
>>>>>> arch/arm/dts for the boot-led usage.
>>>>>>
>>>>>> Where should I debug further?
>>>>
>>>> It is a bit confusing as there is still 'legacy' LED stuff in the
>>>> tree. For your problem I would suggest checking that the LED device is
>>>> configured correctly.
>>>>
>>>> For sandbox in test.dts you can see:
>>>>
>>>>      options {
>>>>          u-boot {
>>>>              compatible = "u-boot,config";
>>>>              boot-led = <&sandbox_led_green>;
>>>>              activity-led = <&sandbox_led_red>;
>>>> ...
>>>>          };
>>>>      };
>>>>
>>>> Check that led_init() is being called in the LED uclass.
>>>
>>> It is working now using your suggestion. Thanks.
>>>
>>>>>
>>>>> Should activity-led be also mentioned in doc/device-tree-bindings/config.txt?
>>>>
>>>> We should be using /options/u-boot for this[1]
>>>
>>> This means, everything that can be found via the following command
>>> won't work and should be removed?
>>>
>>> grep -r --include='*.dts[i]' boot-led arch/arm/dts
>>
>> Yes. I did a series to remove the legacy LED stuff last year but it
>> wasn't applied because people wanted me to do more, probably what you
>> are looking at doing now :-)
> 
> This would be great if this patch series could be merged. Marek has a
> board (arch/arm/dts/stm32mp157a-dhcor-avenger96-u-boot.dtsi) that can
> be reworked too.
> 
> AFAIK, led_activity_blink() is used very seldom. For example, in
> cmd/ubi.c it is only used for writing [1]. mmc is omitted completely.
> Is this intentional or is this functionality just missing?
> 
> [1] https://github.com/u-boot/u-boot/blob/master/cmd/ubi.c#L494
As far as I understand it, the series was incomplete ?
-- 
Best regards,
Marek Vasut

