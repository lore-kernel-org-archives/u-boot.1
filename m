Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9687EC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AC9807F1;
	Tue, 18 Feb 2025 10:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WC4lKHHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B13C809A4; Tue, 18 Feb 2025 10:02:47 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3EC8043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739869363;
 bh=/LtXVpeTojj/lTPirblsaTM+LQLf2zyx3D6bFl1Sy+Q=;
 b=WC4lKHHyUpMRBAEClv+IPlvXOQ3LkZ96ME5WfHVm04d4NuuPsYHyqYxEzF9uMNdEJqoHLjkat
 K7VZGq/08Bu7JuNy3ffRSlgW8e5mC9tudgPSg8gJt4eHNR9zo6IjbXeAWOHasXtRPvMhuyBfBlj
 O6cnWEkz9uKUP2+m1MX1ILPZJ825NDaBEl0Vdoufb7g0tVgFi/4zJ0D7liU/lFUV+rpMoL7hk6Z
 8q/wICM+sdG6sVqN402TgKbvcLBqETXwxRwuQFVOWYOEQNPcLjkWCDXBpMnlcUhfxfhZeF2YO9w
 nk994xcpA7s5t3gPYHIDP5nZFngMrZS6JvrFrwFmDGRQ==
X-Forward-Email-ID: 67b44cb0cd3a6fa316667bec
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0c14e60c-8430-4bb2-9501-f547a1fab954@kwiboo.se>
Date: Tue, 18 Feb 2025 10:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/35] rockchip: dts: Use the new binman template for
 the SPI image too
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-15-sjg@chromium.org>
 <020e69f7-4428-4bcd-8a78-4af819d5d0fe@kwiboo.se>
 <CAFLszTi0p4wfB+m91KGjdSTLbZjAHJ+54rw5jQdLMAUYU__tNA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTi0p4wfB+m91KGjdSTLbZjAHJ+54rw5jQdLMAUYU__tNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 2025-02-15 13:17, Simon Glass wrote:
> Hi Jonas,
> 
> On Mon, 10 Feb 2025 at 15:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 2025-02-09 22:14, Simon Glass wrote:
>>> At present simple-bin-spi relies on the u-boot.itb file created by the
>>> simple-bin image. Use the template to avoid this, since Binman may
>>> change to process images in parallel in the future.
>>>
>>> Drop the filename to prevent another image being created which uses the
>>> u-boot.itb file.
>>
>> As mentioned in "rockchip: dts: Create a template for the FIT",
>> we should keep the u-boot.itb file a few more releases.
>>
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>  arch/arm/dts/rockchip-u-boot.dtsi | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>> index 281119a53d3..79f4188b76b 100644
>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>> @@ -41,7 +41,6 @@
>>>  #endif
>>>               #address-cells = <1>;
>>>               fit,fdt-list = "of-list";
>>> -             filename = "u-boot.itb";
>>>               fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>>>               fit,align = <512>;
>>>               images {
>>> @@ -208,8 +207,7 @@
>>>
>>>  #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>>
>> As mentioned in "rockchip: dts: Create a template for the FIT", this
>> should be changed to "#ifdef HAS_FIT".
>>
>>>               fit {
>>> -                     type = "blob";
>>> -                     filename = "u-boot.itb";
>>> +                     insert-template = <&common_part>;
>>>  #else
>>>               u-boot-img {
>>>  #endif
>>
>> Please also update u-boot.rom in rk3399-u-boot.dtsi to use this template.
>>
>> With that included this is,
>>
>> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>>
>>
>> I also strongly recommend you break out following rockchip-u-boot.dtsi
>> related patches into its own separate series:
>> - rockchip: dts: Correct the OS for U-Boot
>> - rockchip: dts: Factor out arch and compression
>> - rockchip: dts: Add an fdtmap
>> - rockchip: dts: Create a template for the FIT
>> - rockchip: dts: Un-indent the FIT template
>> - rockchip: dts: Use the new binman template for the SPI image too
>>
>> Those patches stand on their own and help solve the "Entry 'u-boot-any'
>> not found in list"-issue in "rockchip: Fix binman error" [1].
> 
> I'm pleased that this has some potential use outside of VBE. But this
> is the final VBE series and I really want VBE to work on a real board
> once this is applied. If you like, you could apply these patches
> separately, but your comments on the whole series have been very
> helpful.

Yes, I would prefer to see these rockchip: dts: patches applied
separately before remaining patches in this VBE series, mostly because
these are fixing issues affecting others such as [1][2] and I also have
a pending maskrom RAM-boot series that will depend on the common_part
template added here or use a similar approach as in [2].

However, the remaining VBE patches in this series has not yet been fully
reviewed or tested and may need further work and/or rebasing before
being fully ready. So to not block others I think the best approach will
be to split this VBE series into smaller parts.

[2] https://patchwork.ozlabs.org/patch/2045541/

Regards,
Jonas

> 
>>
>> [1] https://patchwork.ozlabs.org/patch/2040246/
> 
> Regards,
> Simon

