Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F07FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C615284106;
	Tue, 28 Apr 2026 05:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DxjsheUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AB78421D; Tue, 28 Apr 2026 05:52:04 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE4784099
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-953ac1602f8so7106050241.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777348320; x=1777953120;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjXhlW+fG26C+HNtYE/O0M8k1B9AXo2rDdqVlTSnSws=;
 b=DxjsheUkgn6FqLQBOhX/gclnI/Vz++9Dshav7kmn9LnsLk8o/9YvKU6MqOSwCCBO0m
 ZlugxtHz+yOCqoSXQg2VmCWBp6hLGrqqa/Zxre4iut0ZPu4L9CKug8EMCG59SO1USNCR
 by3yASfutkGVPwErOA+p72YoZJVoNIOk7h+QtjgibCL8Vn+/Zp9RImXIZ7DdZtwGW4Qg
 KTCao+1ViQVlKYz4qYojo8h8JuvSKPhjx/vl3gpcwkw1zZE12IoZEWM57cNViJkzIWcR
 ogVTjdumskrNiGVN6MLAUhLP0jsx/4K7pR7BfMGVnTjI+1A8Vh4hdOcjXE1mSxt8a3yI
 8RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777348320; x=1777953120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjXhlW+fG26C+HNtYE/O0M8k1B9AXo2rDdqVlTSnSws=;
 b=Nea2ZAJVV0SLRMCg1g+I4B6BMg3QgCoqI8LrFi9WtiFps1K6bfEv0i6fTxEBPurIj9
 LRXMcB7XI4LujvRGvtLkUHZEmszoV9Mz8rMn30pzI35U3Oj1bgICG3qvgPjuxd/kVQub
 YK6dmIH0ZgWRG7MydiM8/LBlfVXqA0ZBuDh6+5gZjZTGykSApwmaLXoNHaECMf+RKGlD
 HsaoXNbpCdRM0InvC0zO821U6zQNlD/Lc3Q+tUKFigZKz6NzGB67h57dzN0d+BtN2iah
 6gZ4YLX9My7fUmifee9zyvBcIQOWPxGemF8rHMyeSu6JmPdCflbsvI3WwH2AzZg3mAPD
 rSTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wEfyjh+XAqUv8r+6p9xoDJx8YV4TolYSLduFdW8AG8NJIzdi69w08nfwRe9C4FZXHWCHSNxU=@lists.denx.de
X-Gm-Message-State: AOJu0YzWpjL1MIK+HpPXzraHyGUbuJrwA0WTFfCp+NGUACWdlf19zdlu
 kZ4qNxKu8k1fmIJmJla80YoFwNnuSxeOZs6BgRTTAG86Av2c0k89ZWYKFQI1b52O+dp8a26T3rM
 BFqwi
X-Gm-Gg: AeBDieuuDhOesUESM+mUhRTWSzyh9pYpzBkLSOxcHzUoBTfcqKKkooHV1QOCs0TYl5v
 JVl9MuVr+N2RPpX1AXZmKscoKbTSsg8orp5kekuV2Shf+ZLc6gigtzvGV/AamfXELcDGPxlYxf1
 t0BSJ6nxJ5E1IV5p1RY9Qhfk7qMC/ETvFmoxfh1nskPtPVWvZUoddvkThlAJq7Ik+dhAN0ttsaa
 rHd+pl8ZHS0BpvTo0i7qyGKSAyEtf7i5zd+OHkSAyvOP/44TB6dZnJN2Z7F1atDy8NqyTmMuliQ
 G3/E5QFSpnOvAsqb2Jp5spc4cc0yOl9PWyefh6SGNpS0KEbLq6xigoZBm0JFIFZ/GwIl2Xu3SYP
 BoNANZCBpScqngCpt8C+MVPs9+/rBkDPMg5nlcXg2lxi0nmc095eZ3Dv1GD+MF8ibpzU8WJ3cX6
 61N5aj5undbz85Fg/OASFZb3lc0FEzj0PrmrfX8GpeNUw1qlBzh3iC+OXlrEy4FDGUoZCbR+d7X
 IjZsqHIVe38
X-Received: by 2002:a05:6870:519:b0:42d:8229:ba3d with SMTP id
 586e51a60fabf-433f1eaae90mr381891fac.11.1777331756630; 
 Mon, 27 Apr 2026 16:15:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f?
 ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433ef7d122esm670149fac.0.2026.04.27.16.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 16:15:56 -0700 (PDT)
Message-ID: <16a5c572-ba55-4481-82a3-013e4dd0b772@baylibre.com>
Date: Mon, 27 Apr 2026 18:15:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] power: pmic: mtk-pwrap: add more capability flags
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Macpaul Lin <macpaul.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
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

On 4/9/26 3:30 PM, David Lechner wrote:
> After using the mtk-pwrap driver a bit, we noticed that there were a few
> places where it was writing to registers that were not defined on all
> platforms. The undefined registers are treated as 0, which is the DONE2
> register on the affected platforms. This could cause the DONE2 register
> to have an incorrect value, which could cause Linux to re-initialize the
> PMIC unnecessarily.
> 
> To avoid this issue and ensure that we only write to registers that are
> defined on a given platform, we can add some more capability flags to
> conditionally call any register writes that aren't common to all
> platforms.
> 
> There are also a couple of other cleanups that we do along the way. And
> in v2, I've picked up Julien's patch to add support for MT8195 and
> rebased on top of this.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Use EOPNOTSUPP.
> - Reorder patches to reduce churn.
> - Added new patch to fix driver description comment.
> - Added new patch to drop chip type enum.
> - Picked up Julien's patches from [1] and rebased on these changes.
> - Link to [1]: https://lore.kernel.org/u-boot/20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com/
> - Link to v1: https://patch.msgid.link/20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com
> 
> ---
> David Lechner (6):
>       power: pmic: mtk-pwrap: fix file description
>       power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
>       power: pmic: mtk-pwrap: add init capability flag
>       power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
>       power: pmic: mtk-pwrap: remove interrupt related code
>       power: pmic: mtk-pwrap: use pmic compatible to select child info
> 
> Julien Stephan (2):
>       power: pmic: mtk-pwrap: use tabs for alignment
>       power: pmic: mtk-pwrap: add MT8195 support
> 
>  drivers/power/pmic/mtk-pwrap.c | 115 +++++++++++++++++++++--------------------
>  1 file changed, 60 insertions(+), 55 deletions(-)
> ---
> base-commit: 2a1bcefce835b827bbf88a9e112d646c5c4af9c1
> change-id: 20260317-mtk-pmic-fixes-c1523b1b0dad
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

Hi Jaehoon,

Is it OK if I take this through the MediaTek tree? We need to
pick this up for v2026.07 to make sure the boards we added recently
are working correctly.

