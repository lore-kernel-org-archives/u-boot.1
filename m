Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E95E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F14283E1E;
	Wed, 18 Feb 2026 20:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QU8qB/ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064AE83B99; Wed, 18 Feb 2026 20:26:53 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E596583A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40423dbe98bso66530fac.2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442809; x=1772047609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiCUrmNPY61iiKMx5QHCILt5vtN5H+IoiF55wvIWk/w=;
 b=QU8qB/ss/cNBQXDRFhOtby2iGld6mOXKczUzkBVPQtIH27e2zl6ySOTS9yi+B5z5hD
 +uPKwZ9EutmMlksb/ExR/5KntvJprK8izruyGq9ocsXBl03dl3rvoZeRd+0pYYgQsot7
 AlYQtVFRaaOotgCsPt8yXUqx7LJ6cGVkB5lZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442809; x=1772047609;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aiCUrmNPY61iiKMx5QHCILt5vtN5H+IoiF55wvIWk/w=;
 b=trcFJbcJFFu0xiXNN9toxpuI0VeBr4IjNbFbkzfxjMrDgBBvJ6wqpW4Gn+txH67CoR
 TIirtcbiEsfOd0Ex8HfWIgTo2kdHj2V9whJH+oGE/2H/OaQzfo3CFZFcPWO9cvm2Puvg
 RoDigJRNzwcOOzTQtMJUOBvUp6DT/m4s+DxadnieKhKN9zOfIULGM/0iAecz95tPgIxe
 cX11KSrpuZPHodJkNEYMAziW7QaLbJ0C2MU3/QSFSrHUjt3yJ5icDDB8oi4cvAMTTxFW
 AWm6rPA/z7k35HvavPCoIGqWaQxEnaWTzVwy09h4psP5K/GG8Dgy6FchLH0n+lNZSQfU
 IV/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYXrdZhE9f8g7pTk0+tVBrH5J4it9NKFh3DN6zRweqsBI9n8E7IBQlUf+EvgI1NXyvDTo3nc=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ7kw4bymEs/8u+qL0L1l0LqYMd/RzJDxWTbHydlDLSoFmjnIr
 7uVZ5ahdRxbfuua7+ewGHLc7w02pS24Ml9YKDB5uYQRe7//v9/EW4QiRgrMVXj6R+PE=
X-Gm-Gg: AZuq6aIJySKDKV6uyN1E0RgK9E2Bk+2DR85E4GUaH0a/5fsgf51HO7of/xN+JrQDzoB
 fX02hyhhAzhKxCVfXNp2tBi+qfXxNUI47o1g1ioYat7eV96HXGdmI6WPiqHHJD3UkSH45TX3g2y
 LKEmjfSRFlgqhymr2SHpdN81+o2rjj14GQul2PhFXiLNmLHEoEEK+5mDZChOkMwPejOgSLGPNeX
 HnuhJvFff+DRkLtlHwKPr1md3ZWvvHRZA/FHXFxmfjQB+0KxjbIR8bDlZXVV0DP1ivYt0LZf1ba
 YxUtYY9xqcUdkGLDHDrtGyg0EkcezFyq3DHjz8egsZGfv6Pmnymx9VE24prmYHx6ZcNYZvXGrB8
 mIZmdCI63kj3qzYl7D9oqHf29M9biWwfSHSv8H90sLcb9CqVJXFaBnHp0vC/K5xkLQr85lJH5U5
 7BCwD4IJ2mPzyVIKGV30PHB5Gyc3UQVcI6vX0YlZXEiE1sv3l6JHYwKRUnY9ULG3SBx3QJFMmWA
 n/46QT4DjusHuPyDa6qpNCz0/OuSbWYEnC8GdBaKJOQdX7qGg==
X-Received: by 2002:a05:6871:7291:b0:3ec:3685:34a1 with SMTP id
 586e51a60fabf-40f0d62d67fmr7731506fac.25.1771442809566; 
 Wed, 18 Feb 2026 11:26:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
References: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
Subject: Re: [PATCH 0/2] arm: dts: mt7622: use generic node names
Message-Id: <177144280873.3629982.14047730864113589036.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 09 Feb 2026 11:26:54 -0600, David Lechner wrote:

> While compile-testing things to make sure I wasn't breaking other
> platforms when making mach-wide changes for mediatek, I kept getting
> a warning about a a SPI controller node with the wrong name in
> mt7622.dtsi. The first patch addresses this. And since we are here,
> I added a second patch to generic names in general in that file even
> if they aren't causing warnings.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: dts: mt7622: Fix SPI bus bridge warning
      commit: a1edc0b7d641d788459191123354b84853b0560a
[2/2] arm: dts: mt7622: Use generic node names
      commit: 08b379f9cfd8353ffd66b91933923386715970e5
-- 
Tom


