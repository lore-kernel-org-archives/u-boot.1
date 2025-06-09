Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E2BC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F5282B33;
	Mon,  9 Jun 2025 22:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BZGWVtZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5E182B95; Mon,  9 Jun 2025 22:13:59 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D2080E9A
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 22:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40a4bf1ebb7so732364b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749500036; x=1750104836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D788lI2qf1TugGf2r6lit2pJWjAvhuaiW7bnvNC9Iho=;
 b=BZGWVtZMkz9KS/swFt8bsT/V69Pycd15OYsIAGGhjLRJl/wx3tGKa1PBVSPAeU+eYN
 dIhgqBp3kYiibFLqHVwcAck+MTZcSv4yaJoHOuna+m0FeNLE+SttXL0B/HGOPvGCs1VI
 uxNDjGobc9xyH+07cG86GxvHygNIITJDFIvQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749500036; x=1750104836;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D788lI2qf1TugGf2r6lit2pJWjAvhuaiW7bnvNC9Iho=;
 b=hGBzpgDQiZYXN35fOJUJrJa9b1POhW7SPNGxGyPYuspQC3yHYD2vj+r8LfwR+9KgM1
 uPYnRnBL8lExiM1H6TJk37uuUXE3xdPd9Bns9oRv4FzQ4XD+at5DH/EnTiqMPZsNIP7f
 ngdcAHi00vO/iVY4aXsMgJypiTdE0vz4g/PBqJ1KoUl13urHCFaQqHDylgB4BYU80hDr
 rX7CpMdHsv2l1+WhZu2SbLjvuqxofoH4+BiqOgtuggkyjK/Cg2yL2/vGSDc1ZUPDkhqS
 Hpqqcb2lIdBjnDqhjwWpwGRvVxCiF1oFH7j0J3Wym+n2lmYQqHDrAyyqKCElTekDOPeR
 sxyg==
X-Gm-Message-State: AOJu0YxtZ7yGdwsadMClcb0ZRJlU3FxpS+f7zhux/1Ts98xR+DZ+Jak2
 PN9l2VCHJNLpW61Z+faVXbklLbnqRGeXY1c9Ku9eZYiDWNWuzd+acF64Wfqvx5rvDpDOpvV3x+F
 na25J1oM=
X-Gm-Gg: ASbGncuQdSwp/eCgUBRvw+iYA27Xcugpib4wQ1A2Cxo5D5aPJlXDuxNhugkQJVb2jOX
 lrrCoQy9rt5Cmddx8o4ZTFk9qDIwPEPdBPSXDBNLQisZczw76TuYr7daP1f+ipn25tXo/Okev0n
 B+Mp27ULK5qgSFsyGEwj/TPKee+RE4/PqunIErewGwJoIYze3dvYPrLGgUpP8sQ4h5P0GAojkGK
 +7EwCELUleUK3Y3MwCwa1OraUJSfB2JjZ1Q5F+kI0vcaWCNNbxZTyHkzM59k0c+V3n0D2cZR+OJ
 iTDkeGA27UcbW5gmxyECARpv9fF8jT6B+Y5evGTkTFINRJ4XLR4fattsZrfFa4nl1VGMMsIgTzj
 u0TwbMk/se9f+T6TgUptdWA==
X-Google-Smtp-Source: AGHT+IGx4WgvbwKgnEVPvFLm/oXsySUl5wE3FlkI5Esw9yH2H9vWYKAlmq1Kjy3GUdg5TGmOofodAw==
X-Received: by 2002:a05:6830:2a05:b0:72b:9993:11a5 with SMTP id
 46e09a7af769-73888e0f898mr9819110a34.9.1749500024587; 
 Mon, 09 Jun 2025 13:13:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f2d03csm1715665a34.9.2025.06.09.13.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 13:13:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ziyao@disroot.org
In-Reply-To: <aEaWEeJ0WQPMJfGP@swlinux02>
References: <aEaWEeJ0WQPMJfGP@swlinux02>
Subject: Re: [v2 PULL] u-boot-riscv/next
Message-Id: <174950002380.721272.9031144337554586705.b4-ty@konsulko.com>
Date: Mon, 09 Jun 2025 14:13:43 -0600
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

On Mon, 09 Jun 2025 16:06:41 +0800, Leo Liang wrote:

> The following changes since commit e96b6c0c18c29fba63a1ceb21dc29afb9d9b2910:
> 
>   Merge patch series "Remove as much arch/arm/dts/*.h as possible" (2025-06-06 13:54:42 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


