Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D20FD6AB10
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 22:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2FD839DF;
	Fri,  3 Apr 2026 00:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pF8G5T8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD3483D8A; Fri,  3 Apr 2026 00:27:18 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483A383693
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 00:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-89fc349b5c2so13396296d6.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775168835; x=1775773635;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIJ9bNZn/uPyq9eMP/yUtkSEqaZPfa/Xw2X5QGfA2O0=;
 b=pF8G5T8teLJdlBTKKAfjz0h3+nEAac54mbal+4mgu4XcMVMAu42cbdCZz+0lb9PoPA
 WHHJjGdUvm2rP99xKkQfXQrqfDXH1a7NcPcqzQZfpfK+19qie87h8VJ8VpoIJHv1snBT
 XYAXKuI3Ie61DLa9o7UnUJoKowp/ksadYcHHCBSDEVHaDmiVhUpl4jyqNEihOuLC+bL/
 DiGqK4X0ZG5eI/gFiSJQK1exVaa2dIa6GLB9cpZPFOIQanCjDCEr8MbZtqVEG804KVJd
 NtFc1TpzGD7+l7Izd/sMjSgDR3DaO6ypOFXGsjUiDqzgCo1eKl2OFr7Je2DPK0ZsIO8n
 nMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775168835; x=1775773635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LIJ9bNZn/uPyq9eMP/yUtkSEqaZPfa/Xw2X5QGfA2O0=;
 b=HJb4WxElQoY0lrtOgviVS3AQG9eYwoF95k/J30NOCRqbIb8t2VD/yLIgeO4tXJpwAV
 dn0cecyaK95zJ5djewCEad6SqZWpKVCGTPDZKCC2j5AedsBZdwHARzI7rFxYNxdYb3VB
 79sF2QLi7uURT2gM4HACjM/zD8dFFht1Ka+NInh9jpTFOyccNoqMjHbTOxMp/JeJtVMX
 Cy7R1ChP5XKMBLdtAnwO61L+tPyI9Qb+sw+GRHOe3S/R7g5Tyg9AfZKTw6GTV5eWKHkS
 BK/WnytvnHsRQwekfjRfFuGd86CiluX1Hn1Yi/em3AhnkldOYrFX/WBgtpnRrhFqEZUH
 lB5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGeeArsMGVpyuasx3w7fqsKxRfsHivJgTbxPFk/v9iCBgX4DbTHdGR6WK3GMKxJjKv9IZJpMQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwyyhNAEbbK4GwkXV8DbMua8eULAJ5R+GtTStkBd0DbkOWYaV/h
 MHUQPhBrwuLbe7C2KCgoC9zEaQM9St9dmwmJZi5OZm93bcR22GZjxnY4E9FZhpVK79U=
X-Gm-Gg: AeBDievwLeHIL//smJLiu9loNKe7vcXsVEbOFL91XMRmMxLoXvAfDIIj4VVw90SkOfz
 6A/LA5kJhXgTSZKgHReJArHQNhziUSOydwdE3pXSj2BxiDOpihpZ0HbcY50t2uRme3gO53IPmiS
 3qgVJ+eeGH7mcdUiDaYn985LPAbjfi4LVmd6/APCtTZ/HtDl4jfppOpCttYrheR7T2cg8mgMYfZ
 7icVYzofbkMtQUiZGFyYuSuK5EFO4zGQESZngSY15X6QZNwxyLREsWaRmYZl5gcQAjBRsWDxt8a
 oArWtVabC/Nb6DcUI1utwfSYKdJ1RJ+iiqF5rm1dKrx50r9gCwmm5s9tuE0hH0I54CTjazUQec6
 hZJFf/H1N0Uk6xoDADKmk3fBjLU7UE9YvCXHDKxyPEopsMFOfLvBQqegFwclW1I8UOOdZMNBciV
 ed7I0fOQFohYthABv66VRjKb0Ms135A5jRs0rHj7tnLtp0dPTQyav33GjMxp5mUPgbcxTRmacgq
 g==
X-Received: by 2002:ad4:5962:0:b0:8a6:2d77:770 with SMTP id
 6a1803df08f44-8a7025b8277mr17131186d6.22.1775168835004; 
 Thu, 02 Apr 2026 15:27:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c815:fab5:7fb3:5a56?
 ([2600:8803:e7e4:500:c815:fab5:7fb3:5a56])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a593bf4b0fsm34052686d6.15.2026.04.02.15.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 15:27:14 -0700 (PDT)
Message-ID: <8c016bc9-342a-4148-8a0b-afb7ac03ab80@baylibre.com>
Date: Thu, 2 Apr 2026 17:27:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] MT8195: add ufs support
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
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

On 3/18/26 11:50 AM, Julien Stephan wrote:
> This series adds ufs support MT8195.
> I also include in this series some cleanup on phy-mtk-ufs.c phy driver
> and ufs-mediatek.c mediatek ufs driver, and pmic support for MT8195.
> 

...

> Julien Stephan (9):
>       drivers: phy: phy-mtk-ufs: cleanup headers
>       drivers: phy: phy-mtk-ufs: use tab to indent defines
>       drivers: phy: phy-mtk-ufs: use clk_bulk functions
>       drivers: phy: phy-mtk-ufs: disable clk in power_off
>       drivers: phy: phy-mtk-ufs: do not alloc priv with priv_auto
>       drivers: ufs: ufs-mediatek: fix phy handling
>       drivers: ufs: ufs-mediatek: implement clocking
>       drivers: ufs: ufs-mediatek: add MT8195 compatible
>       configs: add new defconfig for mt8395_genio_1200_evk_ufs
> 
>  board/mediatek/MAINTAINERS                  |   4 +-
>  configs/mt8195.config                       |  24 ++++++
>  configs/mt8395_genio_1200_evk_defconfig     |  26 +-----
>  configs/mt8395_genio_1200_evk_ufs_defconfig |  13 +++
>  drivers/phy/phy-mtk-ufs.c                   | 128 ++++++++++++----------------
>  drivers/ufs/ufs-mediatek.c                  |  40 ++++++---
>  drivers/ufs/ufs-mediatek.h                  |   2 +-
>  7 files changed, 123 insertions(+), 114 deletions(-)
> ---
> base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
> change-id: 20260311-mt8195-add-ufs-support-535ebedbb323
> prerequisite-message-id: <20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com>
> prerequisite-patch-id: 76f64e540256592f97d1b274e6072dde36fee2f9
> 
> Best regards,

Hi Neil,

Is it OK if we take this one through the MediaTek tree?

