Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A61ECD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C738464D;
	Tue, 12 May 2026 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YKb+cw43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5863F8341A; Tue, 12 May 2026 21:31:51 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FB283EF9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso5146403a34.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614308; x=1779219108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slEoWu/rO8R46qLOwZcdHkoXiUI3hENt1pnQGt0dg0A=;
 b=YKb+cw430vkwkdxQTopU8NVOo0V3FRIjw7IZ6oXy1hGIrv/FKM83R4SnaykickYC1f
 7IRcJl4I4muxUBejkVqyD0QFITkMuKKOEEcke1hpmKJiVsDGofc3BwUF+qyWJlXfLJf/
 +SVJL8XUz30+KtZqIOMyHKve/oRl9NY9rnmxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614308; x=1779219108;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slEoWu/rO8R46qLOwZcdHkoXiUI3hENt1pnQGt0dg0A=;
 b=SY1pHCdmjH8HG+4bkyIRzylwsIqxc8m+6KzxkrXkGh0rx2fpBsxyYPioOReeZ7kRvG
 vOsRUWRi6Q18nqCBx4biJGUOal/EKc75IuH3FSNLxyAseRZ41qnTsk/sjkmIDY1dabcM
 I03qUkyaUNHhpbvulgcZWBioCMzRnMznBbX32h4aHjdc9zIqmgRpxsML2fFwwINkEfXb
 cSdyqfHjOnMXtvMZYulbdxHyof8Xs6is5tOHUio5TzA6BG0UnY+GmMP76X0Z10T8fbCd
 sKy8VRdRiQkphp1GraXToUj1+ZXoCLMIs/Qqubenyx9HC46jDEeSrmFcu132GZTbg+qg
 gGpA==
X-Gm-Message-State: AOJu0YxBOgYL5lsDm740Enqz09R98H+J6khexMtY4dBM9L/aV7VUsIW2
 BDk2iJ/Lhx0pZLzDFTPxq/8fm03z2DpyMTcfl5EiNLaUoZ34e+JSzPp/MTxYRLDsTVI=
X-Gm-Gg: Acq92OHD0JpWRr7HTAbKwZSscPLyaaDpo3OwTULdGJh/+OPSG2gKW6RhhhU+kdKh9F/
 W8hyd/pE0P9pOrOZNLnO2z44Ib2pYgc2vF/Fjua/eTX2pcPX2Y1n7GJfRsSQyWPZLbMMxL84H5O
 W2n1DeBFBxmQRcbw9fryag+u1+AINgLkf9iObjsyUq005PF+U/uCrbuevoS9KuWk70CJPJjf0Pt
 7Dr0BraUDmUEaE7kMyOmHQUJD4WVr6C7TvNoqmKXTNS6y4ntaFmeQSE3XKV+jEBffisTo4dfNBB
 nwL2b1lpipfaHaQrtdnkO87Dv/ViA4uLhC5H4of2fShbJlkS5t//0M4Mg8nZTYp/vQGfO7Q6mlf
 AmK088QOhAJ7vfy2eZu9+pllSYfKuIT172pLSd/Cpec/t/hugwAM7OE2awv79IizTo6L1JhYWNL
 ZLkRlyNMr+Z4nXVrbbAtHFOeR3faSZcrjNbD1Vrc8odTbVNd2vJTXbr1dPl8c9zm6My2N7LZTpA
 FrRG4Xe9MALeovSEroQQU4U6BkMCabY1P3w4CQRKYCTwa8/SA==
X-Received: by 2002:a05:6830:81c7:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e3d9cf091cmr98421a34.0.1778614308014; 
 Tue, 12 May 2026 12:31:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20260430-apple-compat-spi-v1-1-6fb3a6fc499c@jannau.net>
References: <20260430-apple-compat-spi-v1-1-6fb3a6fc499c@jannau.net>
Subject: Re: [PATCH] spi: apple: Add "apple,t8103-spi" compatible
Message-Id: <177861430742.3279584.17640146570757906498.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:47 -0600
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

On Thu, 30 Apr 2026 23:33:25 +0200, Janne Grunau wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,spi" anymore [1]. Use
> "apple,t8103-spi" as base compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,spi".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: apple: Add "apple,t8103-spi" compatible
      commit: 6df6f974312f0d92394d2e6465705ccc4e0576da
-- 
Tom


