Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E961091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C48783FD9;
	Thu, 19 Mar 2026 22:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XQJfx/V9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1390783FDE; Thu, 19 Mar 2026 22:53:24 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBFE83FC5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-463a0e14abfso713620b6e.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773957197; x=1774561997;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+IPCbWAr42D/URPnR4vsfl+4N3uNPFJW9X1ma6fJg4=;
 b=XQJfx/V9ctZLPInV0yrVtV6htnafMKuu3guK0744kcaI9aLCVa36OQEexnBYvIShb4
 Y6T2C0BV239VAWjLPRZDPtsLKhiJ11zIQSb5YI30zUMNfJq64/MDDZk/j8V9Pl6W+ZHv
 F2+K1jzCK489BH3IQ6YyvUwQgc691b9N+vL2xjuiMq5F/ttgFhPL0i7qeh7BAxUZGLTX
 SPAsNRydizbM2uwgZ3nQXp7/k+Yef4vynijaNm1arczgDKK3b/LdmYtgNMYw/bqY2NJm
 pDdyCtBQdaYTrRI3j3j9Tx5a2rpzS+925vy47JknHQ9BY74FmUpL1a6ZBpB4OnFXLli9
 rlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773957197; x=1774561997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+IPCbWAr42D/URPnR4vsfl+4N3uNPFJW9X1ma6fJg4=;
 b=s3bh6b7GO8DzhzaMuq5FhdF1QeBDtx3w2YWPNWeHpeJcHoWn1TrWHI3mlrI1om0dLM
 uD1pBLKRDT4J0ZZ7Ze8/mRHNhziV7MBTgbjtqKBaN6uJ0L3uY116vDf3C6rW0MC7p7my
 XrZKL3QYUY14OjY09tCYMWmmVKc2DMLUKhaisxwL4Gjy+7s9sqZPncU/KCK2WGSU1jrf
 4MRmp8gyNVnNZ3I0MWYVZ/emSraRr6djSq7PT8FWgmN/cjMwkeXG4Uus4pTfTFX14ku9
 TJAA/IJXdBCtjX7j43CqKUNO0812y+eEt6RSotldFWPm1+w7gfkWGyZDEX+7fW4K6LEp
 THZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFJ8bSteEXdzAzggoCyfphw3UZF4QB2u5E+FYSttvRvF2Yed4+ASXvmuYOUt9hwuDRgjTVNCo=@lists.denx.de
X-Gm-Message-State: AOJu0YxhVJMeUtnIh7Wazz92xjunlX6+2m2nyvqBrSCe2M7IeJaH3utI
 3Wr51P8q/l92sdodINukUZFKSiBNPl86sn5jffrr3tMmeUsxTFC4bzyo1UbMR+rJjDY=
X-Gm-Gg: ATEYQzxUhqVee1dyYvHw37oj7iRj/NWTb6tynVyRrzPnpQj1qOFvDY+Iq64P6Gla5qE
 la5ZQ+lPpcQPjNWCZH57egnw3SG4BP3Ajbd07k+FfravlNF7xmwwNrO86Jpull9TgXKAoFQEfQv
 /aSWR5b6cRUNzR/6Wno736kCmNDGqgIzwQ2cJ+soWxl34cxbJL08DPEsWAC9D5dp16FMUXXtBAb
 FB1MHzo5UzrhD09Nv10CAXX96eMot8Hl3A1IqIsXu53ocOSMZgdhcbd9n0MOi4Z6CPYb3ZPchM1
 SI8n1xaIjBYKNoqOun5x6dioVY2RWzWcOz8U7/A+7gKp+EMALelx6A87SoiAl3EDo8sAFp74uir
 zgZb9Qsk3+k1c8kPKDotM9VkeGRF3bZw0dtoapHbgtCXdHtQoOyne3SoErc0KVrqb2bPBwfyYo3
 l/X9aKm6eOWWEofdmtFAPy0uoD89m3KtgRyceGD3z9zEuJmvOt5ZDVfKyRWFW8srWUOMOkptA=
X-Received: by 2002:a05:6808:6551:20b0:467:e5a2:a9ef with SMTP id
 5614622812f47-467e5f62dfamr328436b6e.38.1773957196714; 
 Thu, 19 Mar 2026 14:53:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a3c:6fc:3be2:208d?
 ([2600:8803:e7e4:500:6a3c:6fc:3be2:208d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7d1a68fsm156531b6e.3.2026.03.19.14.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 14:53:15 -0700 (PDT)
Message-ID: <78ade2f9-57e5-449a-b57d-89982b1449d5@baylibre.com>
Date: Thu, 19 Mar 2026 16:53:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] configs: add new defconfig for
 mt8395_genio_1200_evk_ufs
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
 <20260318-mt8195-add-ufs-support-v2-9-f18eeeeb0e72@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-9-f18eeeeb0e72@baylibre.com>
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

On 3/18/26 11:51 AM, Julien Stephan wrote:
> This new defconfig is based on mt8395_genio_1200_evk_defconfig, with
> additional configs for UFS.  In order to avoid duplicating defconfig, we
> introduce configs/mt8195.config.
> 

...

> diff --git a/configs/mt8395_genio_1200_evk_ufs_defconfig b/configs/mt8395_genio_1200_evk_ufs_defconfig
> new file mode 100644
> index 00000000000..c18d7de4df2
> --- /dev/null
> +++ b/configs/mt8395_genio_1200_evk_ufs_defconfig
> @@ -0,0 +1,13 @@
> +#include <configs/mt8195.config>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
> +CONFIG_IDENT_STRING=" mt8395-genio-1200-evk-ufs"
> +CONFIG_CMD_UFS=y
> +CONFIG_PHY=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_MTK_PWRAP=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_MT6359=y

I thing PMIC and regulator should be in the commmon .config.
It is used by more than just UFS.

> +CONFIG_SCSI=y
> +CONFIG_UFS=y
> +CONFIG_UFS_MEDIATEK=y
> 

