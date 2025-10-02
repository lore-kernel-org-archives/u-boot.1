Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1696ACAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D8F828A2;
	Thu,  2 Oct 2025 10:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="I0IpR8Fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C3C8352B; Thu,  2 Oct 2025 10:26:55 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6C880107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8EE1106482; Thu,  2 Oct 2025 10:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759393608;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rsVBLLN6Dt2ClB9Jb4gbxA4EudsPEi0zGXHkAdLR/xU=;
 b=I0IpR8FyjuGBhSs57BNu/FPSs/L3xhOMdW7SngVr/59jk4+KfNp3Wo40sEzvEkbkpUGSwL
 qTgN0wti3Y1kXwcEZYSGxjQ8KCvH150SSInGMMy6g9Oc3LZtKdAiWTZCCFBK14Yz7DpWbj
 X9XcxtBZD1oOcmralSjrjXV4ReokMT+r5UgbKuZFkk8thUWti4+7X7gO9glPan4BDuBtx5
 9MDlNNRWrBniiRjk2rA6sDBje+8Yh4VYgenVUGu1kaiC5XR+NzTrYmtjBIoS6dGfwcUb0b
 JniGRe5lhmklkNClSRnDrRHP8/7Q6p3lPlQHiac7DqkM6J/MXbIbgftfGQOMpQ==
Message-ID: <afc99b8a-b50f-95ac-a763-8487e68f8c73@nabladev.com>
Date: Thu, 2 Oct 2025 10:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: activity-led usage
Content-Language: en-US
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marex@denx.de>
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
 <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
 <CAFLszTg59pV0o34LVjuo7vcJSsFYzCgtu8MouHPy3F-DwW=G4Q@mail.gmail.com>
 <CAGm1_kvnxrAHMRwffYki6Zr8g11G2Bmr1GKRPcFfFL1T7xa8-Q@mail.gmail.com>
 <CAFLszTjxyRknzscS1cG-=0jOnpzrTmn7LkHZsXknk5X+4v23gw@mail.gmail.com>
 <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAGm1_ksvdRh+9uEBiYDYKUzYmJUSdwhsMnG_GLHaAMrbET_CGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Yegor,

On 02.10.25 10:22, Yegor Yefremov wrote:
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

The commit which introduced this says:
"""
commit 990f726ce797c040adda6d1e1bc6a21bd2b28657
Author: Christian Marangi <ansuelsmth@gmail.com>
Date:   Tue Oct 1 14:24:41 2024 +0200

     ubi: implement support for LED activity

     Implement support for LED activity. If the feature is enabled,
     make the defined ACTIVITY LED to signal ubi write operation.

     Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
     Reviewed-by: Simon Glass <sjg@chromium.org>
"""

So, at that time it was intentional ... yes ... but I ask me, why
we do not use this LED also on read operations...

bye,
Heiko
> 
> Regards,
> Yegor
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
