Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542C2CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 18:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E24083968;
	Tue, 28 Oct 2025 18:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bcEBv9js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9028838BB; Tue, 28 Oct 2025 18:59:16 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17D883956
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-44588e94decso82876b6e.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674353; x=1762279153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pACPPyMcnfC3Da+xVHU24+CLXgezQjGz1du9zs0yBrw=;
 b=bcEBv9jsX7suedaOXiNJGaAT//YIt/CdpgS1BH6cd58s/C4oFPKchaR+FSHHYJFfvc
 BVjg/9vhzmRAwajxANiYtJqYX2/Hjz0uZHrtpkyRm61OyRLS+FVsCrjuzhOjJOR4t6FM
 1O3Tqbbg9GVGZzuNuMPo4KUUzmQHYvirldmpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674353; x=1762279153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pACPPyMcnfC3Da+xVHU24+CLXgezQjGz1du9zs0yBrw=;
 b=wJM28z2DSgXOIoMs3qtKC62xW7WNMeiQgY4KfuxUMqWE3wFTkzQ7qrhV2sYSBSWSc/
 TC4Wtvlm/4NwSI4P2z0FU68p9lATvkn0deyu/5mmMPDq93zxZAs8tf1v4MOvix5Kfo+b
 E0WEiQ/Y+dDNAOS0IBXSvuhkbNrXQVGpvrNk3UJ/ET51fElIJQac/F9S7IdSceYn0865
 rkQp1gs8VLDwp5heiNkLnNpmWwjeJZntSnTiI9L/QBWZT3XRkeJh946DHQnLnkgDYOid
 9NFIdEYS3e15Nfjzt4X5liKFIx852mQxkjyW3iPKmUDtrc1IkHhI2cVU2jjzA2x5OEJk
 cI5w==
X-Gm-Message-State: AOJu0YxQftSlP21TktpSzIKY27GkUWBL0FrJU27Wpm2xdQ3JP/5/tnoh
 07dqnfWwo4pRwB9QkoNxlrR6FS8VJ6xBDWCfiAojkVBfp/mnS2rR6+2ocpr+jNK7J3Y=
X-Gm-Gg: ASbGnct6xgTds1qSmaLtQH08vmFoACZlZRaJzF08BL9USGv//2aKDbnqNllBEqlhO4D
 h5oo+APhU7FDWoqgGHkBalgGZu8ObtqXzNFWNqau0LW+FyOGa2c4CK+PPxM7Vty5fZDE4CAKrMU
 B4KTUo2z1y8O05xwEv0q4eeXbtJ52uqRTRjEMXu4Zakc33BCEZgySQmP726v5yvtcbYKJpOWMW5
 8wD0b1ykNeSxZw5dZCSJ7pBLfUMnuD8mj5q3k9lk+fnRmArQJp5371v7utKKN/1d+qHqulxe278
 miWAP9rYjiSosmtsEc15O4MFeaA4jfirmVttejBE/VO+7layqcogdoE3kEvxx9YVBtSXFuac4An
 L07uS+hRCXBMjYNJ1h/B95SWb1t6sSg3hV2hTE62HxLwCkgZgdeBxbJhiQQgLR5b/XoEHbDT+Av
 YFiKz2Xvpd1ryRUy2w87IPyNCGhqJPiTilnL4hdA==
X-Google-Smtp-Source: AGHT+IHSO5GlRZHbQNTgIbs6WeY8JEml4g4uYlyIBx9RQQ2grFkhhjSBdg47TR5azQMG7bM+h2FyLQ==
X-Received: by 2002:a05:6808:2122:b0:44d:b760:f1da with SMTP id
 5614622812f47-44f6c6ee7c8mr1875290b6e.14.1761674353519; 
 Tue, 28 Oct 2025 10:59:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-nxp_fspi-v1-1-4191caad372b@linaro.org>
References: <20250812-nxp_fspi-v1-1-4191caad372b@linaro.org>
Subject: Re: [PATCH] spi: fspi: Logical or used instead of logical and
Message-Id: <176167435265.2025892.10710972467456758762.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:12 -0600
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

On Tue, 12 Aug 2025 17:42:59 +0100, Andrew Goodbody wrote:

> In erratum_err050568 the test for apllicability uses logical or to check
> multiple chip IDs but this means the test will always evaluate to true
> as at least 1 term will always be true. Logical and should have been
> used so that the expression evaluates to true if all terms are true
> which would mean that no chip ID of interest was in use.
> 
> This issue was found by Smatch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: fspi: Logical or used instead of logical and
      commit: 1e2de3ce615e5cd2bd89d6bd601ed3709059318b
-- 
Tom


