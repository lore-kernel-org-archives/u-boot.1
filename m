Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E22CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 19:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86D680104;
	Wed,  5 Feb 2025 20:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t68c2Jxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E38807A7; Wed,  5 Feb 2025 20:55:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B7E800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738785303;
 bh=1CT47PnfMMKc+DzaVGAUQ0+6KeReTy3BxC8A+QYdJy8=;
 b=t68c2JxsIgDLtpN2sjdYipa1MXyZV5aiDfPDNQ75ut3zl6pk7cS+ca41SPNO1Y1xMUevF75Ww
 spWu9NOZadH9xMGUlvdDeuxftyhqcvWAVKMBVcjYoW4Ba3TrH1ukEuw+So+9YCYynQdtkVwC0If
 /6IU/UER7NhxKKnnHxRtdxYSh0u9E0aeWDfz1N+O7/5C3qEWwFmQOO34YBQTyW9u+oOLiSKL7K9
 JG+2DZ+nJruYzKysWQNFXoVR69WlzMgp1q0DtuCvPM5yn0NbgQC5PZ7yEGsGJLaJLb3dhkIagqJ
 18Cd+bwfm3HA58qGLKEJbWgW2Oy3K6G3v/CQfOR8txhg==
X-Forward-Email-ID: 67a3c2124f7eea50c61f389f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fc174546-e071-4ca6-939a-c9e1bfceffc2@kwiboo.se>
Date: Wed, 5 Feb 2025 20:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: mkimage: Add option for image load address
 and flag
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-7-jonas@kwiboo.se>
 <35d4ce24-ffc8-4500-97d7-d1da8791e435@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <35d4ce24-ffc8-4500-97d7-d1da8791e435@cherry.de>
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

On 2025-02-05 17:51, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> The v2 image format supports defining a load address and flag for each
>> embedded image.
>>
>> Add initial support for writing the image load address and flag to the
>> v2 image format header.
>>
>> This may later be used for RK3576 to embed a minimal initial image that
>> if required to fix booting from SD-card due to a BootROM issue.
>>
> 
> Would have been better with RK3576 support so we can see how it will be 
> used. Especially, the flag member is very obscure. If we do nothing with 
> it and document it as "no use", should we really add code for it?

I fully agree that this patch should possible be dropped from this
series and instead be included in a future rk3576 sd-card workaround
series.

I can only find FLAG=0x10007 for RV1106 in rkbin/RKBOOT, i.e. "no use"
in current state for mainline. However, a few SoCs seem to have use for
a LOAD_ADDR= different from the BootROM default.

Below is what I am playing with. I am not happy with current state and
would instead like to embed the binary code in some way, similar to [1].
See my rk3576-2025.04-wip branch at [2] for the full commit.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250103215904.2590769-3-jonas@kwiboo.se/
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/

commit e431562260a6313f765dbea9ed4f696fa97c5abc
Author: Jonas Karlman <jonas@kwiboo.se>
Date:   Tue Jan 28 01:30:12 2025 +0000

    WIP: rockchip: mkimage: Add rk3576 align and sd-card workaround
    
    The BootROM on RK3576 has an issue loading boot images from an SD-card.
    This issue can be worked around by injecting an initial boot image
    before TPL that:
    
      writel(0x3ffff800, 0x3ff803b0)
    
    Prepend an image containing binary code that does this and return to
    BootROM to load next image, TPL.
    
    TODO: embed the binary code into rkcommon.c
    
    Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 8b57ba69cde6..7125b1de9fe9 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -143,7 +143,7 @@ static struct spl_info spl_infos[] = {
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
-	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2, 8 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
 };
 
@@ -271,6 +271,22 @@ int rkcommon_check_params(struct image_tool_params *params)
 		return EXIT_FAILURE;
 	}
 
+	if (!strcmp(params->imagename, "rk3576")) {
+		size = rkcommon_get_aligned_filesize(params, "rk3576-boost.bin");
+		if (size < 0)
+			return EXIT_SUCCESS;
+
+		for (i = ARRAY_SIZE(spl_params.images) - 1; i > 0; i--) {
+			spl_params.images[i] = spl_params.images[i - 1];
+		}
+
+		spl_params.images[0].file = "rk3576-boost.bin";
+		spl_params.images[0].size = size;
+
+		spl_params.images[0].address = 0x3ffc0000;
+		spl_params.images[1].address = 0x3ff81000;
+	}
+
 	return EXIT_SUCCESS;
 
 err_spl_info:

Regards,
Jonas

> 
> The change itself seems fine though.
> 
> Cheers,
> Quentin

