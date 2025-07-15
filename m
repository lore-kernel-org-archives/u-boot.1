Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE29FC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EB782F8F;
	Tue, 15 Jul 2025 11:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nKzO/z+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4E183096; Tue, 15 Jul 2025 11:37:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0355582F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752572218;
 bh=qkg7cVlnGlzfAgwbcccF1xFQPwv4Vx21L+eZBem5O24=;
 b=nKzO/z+9SJ8la9tP5k+7Na+tGqWY4bohTyKODd8EtMwK5Es9fLMQ9FbOsJjhE9GcOKl2WgSgg
 IJLAEOLnr19ihHSiippdnnFA2Abvl7CtJf+RaQVewpsTaMqLj34x5vw56Dv5nySvdnj+MR4vUIT
 PkUZ6COs0Zn/Yi3l8GgFJqiqALVH+5DB5VMmca7SpSo6E3PJrfbwcctUAWXutJpIWw9AeC3s9Fd
 ViCKoWEmPHfaAz8y7s8v/yGyDkJsu1xKueR/IBp1PZbPBXuVNftZ5aDwe3SA+ZltHFsUBqvBzFR
 aLl4O3LunUfLPd9OkYDL0MH7yWlei7qOjho29/qTMaRQ==
X-Forward-Email-ID: 6876213602da433925ac4a94
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <13913124-c2b9-4072-b57e-7012b2a222ec@kwiboo.se>
Date: Tue, 15 Jul 2025 11:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.denx.de
References: <20250712211232.680047-1-jonas@kwiboo.se>
 <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
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

Hi Quentin,

On 7/15/2025 11:07 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/12/25 11:12 PM, Jonas Karlman wrote:
>> Boot devices are being probed when SPL boot order is determined. This
>> may delay boot slightly and can prevent booting from SPI Flash on boards
>> that use same pins for SPI Flash and eMMC due to pinctrl being applied
>> prior to booting.
>>
> 
> How would that be possible? One cannot have the same pins used for SPI 
> flash and eMMC at the same time? So that would be an issue in the DT or 
> a misconfigured DT for the board?

Correct, basically there are SoCs, RK3576 and RK3588S comes to mind,
that share/mux pins for FSPI and EMMC. And some devices with those SoCs
have options to mount a SPI flash or eMMC module using same connector.

E.g. Radxa has a SPI flash module for ROCK 5A/5C that can be mounted on
the eMMC connector. And ROCK 4D has a shared eMMC/UFS connector with a
SPI flash mounted onboard (in some configurations).

When I tried to boot from SPI flash on my ROCK 4D and was trying to
describe the eMMC module, SPL would instead first probe the SPI flash
module and apply the pinctrl for FSPI func, and then when it tries to
lookup more boot options, it instead probed the sdhci controller and
applied pinctrl for emmc so loading FIT from SPI flash then failed.

With probe and thus apply of pinctrl happening later when images are
loaded we should be able to create a single boot image that dynamically
can apply correct FDT/DTBO depending if it was booted from SPI flash or
eMMC. Or for the ROCK 4D case (can only boot from FSPI->UFS->USB) being
able to boot from SPI flash and then switch to use eMMC for storage.

Something to investigate more in a follow up series.

> 
> On paper otherwise, it makes sense to me not to probe the device until 
> it's used.
> 
> Is it guaranteed the devices are actually probed before being used from 
> the SPL loader code? (common/spl/*) I guess if it's not it would be an 
> issue in the SPL loader code making assumptions it shouldn't.

Yes, from what I could test all SPL loaders initialized a proper probe of
the device at the later stage, prior to reading the FIT/image.

Regards,
Jonas

> 
> Cheers,
> Quentin

