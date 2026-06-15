Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5381CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8A384910;
	Mon, 15 Jun 2026 23:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e6r4CCEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3429784910; Mon, 15 Jun 2026 23:09:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC1B84884
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68cebf2657cso600100a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557755; x=1782162555; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zpsEQ6hVXm0/T/c9p2ODebamIXxnXUlyVKUiGIK7vMo=;
 b=e6r4CCEJhrN0J4LDAiCPu/TFJ7amF74RnG7/6MqiSd5j8nKtlq23XkKd166k8O5w1c
 YAM8uBICAorzMJnrd6RWE/i9So9eY0aSpxE2USVv1ZGI/fBLJbWuUkztLRUjeY2TnUKl
 Mci5pcKj9Uqrenyp2PllUg6euQDaEQ5vzdmgYyoLpcEsMMnGNPfVK0gNhy+zKYZ2eeSy
 sD/YRAcmNnCRYs1dIEMXgVP3LL7OIZrDa7uRuXUNrvdHVf4NOxVBRbjDr5bP5+3BtgDZ
 6c54WoHjOGkCvjl/OCmLxfRv3MBOioGt3+mavBiLIbWybVa/4/6es7e4DqQ3M3ITTVT4
 D/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557755; x=1782162555;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpsEQ6hVXm0/T/c9p2ODebamIXxnXUlyVKUiGIK7vMo=;
 b=T1RuWJfag2ZIL6cZ1xjd52tyWCioGOsRKQ+EUWCPNiw91sGzORAuD2P4nWoBgDQZ9j
 Ufol6CcF8/dPNGygYEcu7JePdCNDYW50KbL5XcbddIW6L5e2x8DJqf0k4dw+wJsRCQoK
 eCWdEjl/1RcVayGCAqEt9gq+l2ghFE5CFc9kXjyGOPVkey0mXyw9gwh6f7optP3iEQ8G
 Z10HMiCSewjms+ojrO7sh02OGdoDdyygBGFZPFFEnKnytUuFANAQ3SZuxZ9QmBb+5GsA
 XW3RrdrGw17WIq0mxThPcaaE1ZSEbsxAY2XIhw5LtSqX1NEQ+dBt8J3Va8vGGABEoArO
 yCRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9K0DjAwEkQbYtrWXemQPa63v6QsffjWMdV6SR1If0oE7tMMMm9JZW2GMGkyY/N8N1DD+Ab6/U=@lists.denx.de
X-Gm-Message-State: AOJu0YwclKoSRSH/45lV6rTtnzqq6/QLS/bOL7yNCHZBZDP2JKBQx2e/
 d4fMdlMD9IdKZby+lydKVwqknUDIhwx1XTVvQLnXxptRNWPAfR363nPz
X-Gm-Gg: Acq92OFq7EYlUoUT775ksA5L9VOIkV5bKuDWvOb9s82gHYck7W/wPXawJqaNSCHIy53
 tpFwejdLNcSmj9uoamMCmWLmUbwu/A8LrcmgelUwhwKRQexO7QOhLknHArtCHwdUT20er7FQK1f
 aiQu1v5JcfINTBnfpH4sveRIGKHKnQevHWEls+jhkwlCPKa7ala2E5B15JW3HtBFHGC/gmXElff
 a8L8ZajrmJ44djc1Kyl7PT5SRzzM6VKK8JUgOt7FSv5zqmUW/8Ta/3/29hIpzpIbfZiiOqbPiYC
 XAAWnIDJEfjM1EU5hBMlKrnsunQsfmo1ty39gjama7gqk63Kw5dwmIEbQMqdBwfbzV8k0agqCL4
 89WT70ClXY32LLSFMoMbNfNp6A0IX4rBdlnQzhElYkB8vCjV8RtnjIpTdBMe4e/fKNkJuVoTX47
 4hnQGoHf/mCIjprTczqWb1BDTNhapYUPz3uwFohdLHI5Wym/GtYA7LredIr+sF5A==
X-Received: by 2002:a17:906:319a:b0:c01:dc31:2d40 with SMTP id
 a640c23a62f3a-c01dc312f16mr99384366b.8.1781557754576; 
 Mon, 15 Jun 2026 14:09:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8341840sm534676766b.43.2026.06.15.14.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:09:13 -0700 (PDT)
Message-ID: <cf4efdf1-5e0b-48dc-a4ce-a7b4165719fb@gmail.com>
Date: Mon, 15 Jun 2026 23:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 10/10] rockchip: configs: enable USB in SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

Enable USB in SPL support for mk808.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
remove SPL_DM_RESET
---
 configs/mk808_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b8c6f516591a..97246dacff3e 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -87,6 +87,7 @@ CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_USB2=y
+CONFIG_SPL_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -106,6 +107,8 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
+CONFIG_SPL_USB_DWC2=y
+CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
--
2.39.5

