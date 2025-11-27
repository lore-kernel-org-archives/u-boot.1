Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49CED111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6688439C;
	Thu, 27 Nov 2025 17:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XmYk19Gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943508438A; Thu, 27 Nov 2025 17:55:46 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7636D83B27
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec3e769759so219657fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262543; x=1764867343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qojHB7cBDCTpn83cTlz7ZmR/Yx/r2ik/g+JG/PgekJY=;
 b=XmYk19GuYyOxQGjl7ao2woWVma0bBhLviyqDefvDmTk8J/JaCUNkJ4f3UjD7UTFXd3
 A6aGWEPYUjJSpFKabaRz31wGubjsJbUnPO8hAVOG8LfujRmHony/RVtwSlqg0ntRhiOj
 mnAlNn+lcvv9y61bjZNZOBX/+mXZ8o/TO1wMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262543; x=1764867343;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qojHB7cBDCTpn83cTlz7ZmR/Yx/r2ik/g+JG/PgekJY=;
 b=obAXe1MsCJyl7sgfivnRfkIVGJGNbCzuSUN/Nve1XXPfTXwdxM2RCUut2rMH2jfDbG
 wiMN1fyjwh/HOV51Jj4LQJLReXr/iC4GCsLOLE8L75D/KbaJEJjT6W56t6Y7Xcv59BhX
 DnTWEWfJzbQ1pFF2qRdb9MtTusBYg1HA6zsTU5NndSJJE1urMq6BA10Trj+b0HN73J5s
 IN9vM5gPJtDv2rTgT+qoDVL/QMhA8qfmiCFRjdERBw56F1qSwpWYHPjTlsw+WBiiwxPy
 fRlWkadtykGmE40EjAwOw4rU3DLKk3A19TWBU+FAnNrwBabxZJlO8xTr/924JDUD95c8
 N2mA==
X-Gm-Message-State: AOJu0YxMAYjIx8nTGX/BNb1wCQlW8kppb/mwfJLEEfU1OIAJmsuH4zfF
 X2a2bzVTu5hQtpndTYE5FX67IeOw24qy1DAR68F0A4E5Fd1jW4kk5rgv35n+CIeZN51C1GAc4ld
 Ks4Jj45o=
X-Gm-Gg: ASbGncvBYmZw/CteNQREy9rSYM+0kl5kOC8BvxwXqAO5zUZlb40W/hwX5g/etAF5v11
 WDbCfvgLCH9fpqrFUbhUS9Cr3234OP6BtF469CXCAdHrqIz265kdcM9Wy6+GGKqnp1hMhOV7RJb
 IZFtwx+T2pPHkpl6XmlWwdbxtblAZx3un3qSKo4GEMNtdU1BUtp93YRCgG9o/ReDy/yCxmKWye2
 eoTxaFe4eSaSa/FHb7iVeRQAyxxywJCT4E1cQQRTyCD2Kn+0IXWcySIk4lKimyUL1w7hPjJjhr8
 WtnymI8lXKW/MoHC4LQCfhELfmvGaRXDfufy/1frMJxYQypSjC7H2fbolrh1C2YnjSUiaCzmqS9
 UCoeLbPoep1gCcBSg2yR2W3CBI3K+vq/gM1adIs+bw62cdsPh9HlmiXUylxg0G+dsoAQq8L+wJx
 ojofG2+qEN9QDmrN50ZXOOUq52pC7MoHypL2bks1ZOwyo/J2U4
X-Google-Smtp-Source: AGHT+IGFQevnTmoE5Wq1Oi0zOigF5eI44O1kbUttKZNs24Rg1gxC3gtb/eQUhJz0u3NEbFPzwzvMJQ==
X-Received: by 2002:a05:6870:d0d2:b0:3ec:3dc5:52c8 with SMTP id
 586e51a60fabf-3ecbe289412mr10490501fac.10.1764262543199; 
 Thu, 27 Nov 2025 08:55:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251126110531.2307363-1-festevam@gmail.com>
References: <20251126110531.2307363-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20251126
Message-Id: <176426254253.4117678.12092956376802001825.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:42 -0600
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

On Wed, 26 Nov 2025 08:05:31 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9:
> 
>   Prepare v2026.01-rc3 (2025-11-24 09:27:35 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


