Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ACBD46604
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 18:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C039680325;
	Thu, 15 Jan 2026 19:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zcG3OICd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BAE830E4; Thu, 15 Jan 2026 19:46:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558DE80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 19:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf5=7V=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768502810;
 bh=s0PXJUSIWA0g+v8kKN6RMAWp94usVnswKkqtASbLQ08=;
 b=zcG3OICddhHIIJ7gwf0LWPkU6NjnqtGw7LHHdT3Ah3WMJnXb1XF1Q+DBQPvgekOVuhIW9inzY
 obBgVZpLGicD0vohrwFmaBY/iKMml5xzBzXgvFQtI1YbaaYDl4/H6k9MJf+PGbCVb5fIX3BrQOr
 8GjTH/vXdbfcYYvUjlTccI1H0T22utJxXNcuUyQhF5jOmg5ZnFOt/YIfgC7GfmSlIwXHGzIE/Y6
 tpT0bPIb/+RO4qYyBgpxkeBh9mIUzlMbA7BdkBLSpKe5Y4qNSyEVxZlt9w2vHaTRzEybMhVpi1W
 ql19O3SdoeJ1QIGivTyN2hZQ2PSGIRki/wedIPaQgh7w==
X-Forward-Email-ID: 69693616e6e309b30d461fe4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <64c4723c-c5af-4800-8886-b06c1fa8bb8e@kwiboo.se>
Date: Thu, 15 Jan 2026 19:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] rockchip: Add initial RK3582 support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <cd629f5c-f69d-4b87-908b-aa323c78792e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cd629f5c-f69d-4b87-908b-aa323c78792e@cherry.de>
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

On 1/15/2026 11:34 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/8/26 12:07 AM, Jonas Karlman wrote:
>> This series add initial support for RK3582 support. The RK3582 is a
>> variant of the RK3588S with a few ip blocks disabled. What blocks are
>> disabled/non-working is indicated by the ip-state in OTP.
>>
>> Compared to the vendor U-Boot variant, this mark cpu, the gpu and
>> vdec/venc with status=fail instead of removing nodes during DT fixup.
>> Linux skip cpu cores marked as failed staring from v5.17-rc1, however
>> the GIC driver will generate a harmless WARN_ON that safely can be
>> ignored. A patch for Linux will be sent to skip the WARN_ON for
>> failed/disabled cpu cores once this lands.
>>
>> It is recommended to use rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
>> as DRAM init blob RK3582, listed in latest RKBOOT/RK3582MINIALL.ini.
>>
> 
> As opposed to what?

The release note for rk3588 rkbin blobs [1] list this DRAM init blob
version with:

  New
  - Add RK3582 support.

So this remark was a hint that users should use a DRAM init blob that
has proper support for RK3582 when testing this series.

[1] https://github.com/rockchip-linux/rkbin/blob/master/doc/release/RK3588_EN.md

> I see there are 2 DDR bin and 2 eyescan DDR bin in rkbin, but I'm 
> assuming at some point there'll be a newer release so we need to know 
> which to use.
> 
> I'm assuming what matters is to match what's inside 
> RKBOOT/RK3582MINIALL.ini? Can you add this to 
> doc/board/rockchip/rockchip.rst maybe?

That is something that is true for all SoCs using BL31 or ROCKCHIP_TPL
blobs from rkbin repo and a topic I think is better suited for a
separate documentation improvement series.

Something like following could possible be added.

  When BL31 and ROCKCHIP_TPL blobs from rkbin is used it is recommended to select
  the blob referenced in RKTRUST/<soc>TRUST.ini and RKBOOT/<soc>MINIALL.ini.

  Something like following can be used to set the environment variables:

  .. code-block:: bash

        export BL31=../rkbin/$(confget -f ../rkbin/RKTRUST/<soc>TRUST.ini -s BL31_OPTION PATH)
        export ROCKCHIP_TPL=../rkbin/$(confget -f ../rkbin/RKBOOT/<soc>MINIALL.ini -s LOADER_OPTION FlashData)

That is similar to what I use in my build scripts :-)

For this series I will however include something like below in a v5.

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 217694de0c92..022f8f2f20c0 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -329,13 +329,15 @@ To build rk3576 boards:
         make roc-pc-rk3576_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

-To build rk3588 boards:
+To build rk3588 (or rk3582) boards:

 .. code-block:: bash

-        export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.33.elf
-        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.09.bin
-        make evb-rk3588_defconfig
+        export BL31=../trusted-firmware-a/build/rk3588/release/bl31/bl31.elf
+        [or]export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.51.elf
+        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
+        [or]export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
+        make generic-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

 Flashing
---

Regards,
Jonas

> Cheers,
> Quentin

