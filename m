Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F0C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 23:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742F2807F3;
	Fri, 24 Jan 2025 00:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PEQExcRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94BD0808E6; Fri, 24 Jan 2025 00:14:14 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9B8807FE
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 00:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467a37a2a53so15849511cf.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737674050; x=1738278850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYkcsXDgEtCBk409f9NfuR9L/zUK7F1khoXEqWafqqE=;
 b=PEQExcRMRtTM0PNc4H1KreZaMvmYkOKyZWmwXt92gJ+oq7gW8GtGPBvPw3YcEQ3pwk
 EQTRakHqgMzXxDXkyXld6vBweJ5xz4cQ9VgV8zLLjxrHECh+IEvrdd+30zo9fSWJPqCj
 VHgg4ifxaNmgl+uuOU8oucMTNQ9YQfWMnC/qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737674050; x=1738278850;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYkcsXDgEtCBk409f9NfuR9L/zUK7F1khoXEqWafqqE=;
 b=atu2Md8zycw91ZIsPxOksj6BL1fPC01U/cPq4cY38EOzS94aDSKH+4C2KO+tV5h78B
 mB3xOyVflkSZcXFxCyahOO7Dg7BXTmvR00R8arWgMNmjpOkl8xW1lIviYG9Ji+y01O9K
 zsp2ceZkPIrB48AMawhLnImlA++JwYfmKMuSNW2ZySFNVsY1CmmM/rnOcJkzvKJdmIg/
 855C81EDP25M3yr39vXjjuda9SmU5gyQBuJeUNrcaR+UYCaYsbm2Mu3A9Jy7JtON0XYd
 EZz71Po6OOq7vWK1SYV5ZElOGgLs+JIs9CmEmG+ZFFLa8+Oub3WXTIr0gpHJE65XJdC9
 eYrw==
X-Gm-Message-State: AOJu0YwH61NarWmGiCfzp0xSXaabfXZWQiWA2Kd66EUaujHlaRokCVRC
 aNTuEVP/2imm3ruTNiY3ffpqCj4RRCsUcy8MUbuKMIldBo7ajvJ3Gupu//pQR6hsn9oUoUZlgLa
 QG+Y=
X-Gm-Gg: ASbGnctosgl5Rx4tEcMxsFFmUWVE/G6Or5L6zLYaVUYnAbMm0dUkodyiF6UIrJIrRFe
 KHNbaOwCxobVoN1rRG3YiIcVsBtVwm1o3B1o7Io0JjqdpmJK3fT/HgWOvqP4VAxN46qaPl+Xvbu
 9/CFYeE084hgE1PA478TIZUusIyhISKQir90K4g4ktv0x4kbr/4ut51uK9tfsZGeBQQR39M7qsM
 9mgCS2n7LJ8PSNdyEX9J+GqNRWFoE05L0JEHJb6n1i1cvmDA4rSHmhP8h8UTvF7TnrXfW9HUl41
 Xqc=
X-Google-Smtp-Source: AGHT+IHcWaMBzqQi7DOP7CA+aMGgSki/AzUtx9k+vAWatNH398weaNdJ5v+a5C6Ldh6LYi9WLjD2kQ==
X-Received: by 2002:ac8:57d1:0:b0:467:5082:74bd with SMTP id
 d75a77b69052e-46e12b5d0d0mr392570771cf.34.1737674050498; 
 Thu, 23 Jan 2025 15:14:10 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b89811sm3753441cf.77.2025.01.23.15.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 15:14:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 00/15] Cumulative fixes and updates for MediaTek platform
Message-Id: <173767404947.3025404.13299286410468667375.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 17:14:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 17 Jan 2025 17:16:27 +0800, Weijie Gao wrote:

> This patch series contains fixes and updates for MediaTek platform,
> including drivers, board and arch files.
> 
> Weijie Gao (15):
>   board: mediatek: mt7622: remove board_late_init
>   clk: mediatek: fix uninitialized fields issue in INFRA_MUX struct
>   configs: mt7629: move image load address to 0x42000000
>   configs: mt7988: move image load address to 0x44000000
>   spi: mtk_spim: add support to use DT live tree
>   spi: mtk_spim: check slave device mode in spi-mem's supports_op
>   arm: dts: mediatek: add quad mode capabilities for SPI flashes
>   pwm: mediatek: add pwm3 support for mt7981
>   pci: mediatek: add support for multiple ports in mediatek pcie gen3
>     driver
>   arm: dts: mediatek: add pcie support for mt7988
>   arm: dts: medaitek: fix internal switch link speed of mt7988
>   arm: dts: mediatek: add support for all three GMACs for mt7988
>   arm: dts: medaitek: add flash interface driving settings for mt7988
>   arm: dts: mediatek: update mt7981 mmc node
>   MAINTAINERS: update file list for MediaTek ARM platform
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


