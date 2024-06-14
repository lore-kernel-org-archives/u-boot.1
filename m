Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCDC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C2588989;
	Fri, 14 Jun 2024 16:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tc0tMOG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924DE88A0C; Fri, 14 Jun 2024 16:54:27 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF11883F6
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-254c56efe06so1084039fac.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376864; x=1718981664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GUWOzMpTBjK6/DxEhGwz+10XUYxxapRHiEbt1X1ImM=;
 b=Tc0tMOG3DsioCab4PqdjNXGRJlYvZE8oFOAtsMre7de2LGnZChZvpZGNZEej++YDeM
 7O4kvgNgfbEVvor2IO6WOqaoWsWMMWcMaHic9jutz9/MPP10Kvyacb0Sbn2C1PFP/Ptv
 4d5OOmzdEH/jtFgvqyKf1ymzG6m7AqzZ2PfYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376864; x=1718981664;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GUWOzMpTBjK6/DxEhGwz+10XUYxxapRHiEbt1X1ImM=;
 b=rLb3AcgU2GCP2Pz2oPtCOcJ0XeUQoF6XI8u7yb5ICbUrceCA+y5sDixss0+FCg4h+b
 WLrSWUfOR4aXfu6W4yeRSkJ7VCjN09eBLaA2VjNb5OM3FQ9ZFQU7ZDxng1O22ECl4ADO
 ypbTJC9AChWT7/moPGVt/9mYVe3qv1F3yNLN+8Ge8j4oJmHB7jyn18ozD8xlMDrGEc38
 vQgw2OuFQMGZIGeVlRxi+7ICsZAlpDFTrOGgBRHSu5YIfK7MJOe4WWQDVx6HW3fcUX8r
 Ga+Pui2N01vCGFEsxdjSH28hFxoXP8/x5ABVIGeni4aP7Qm4OBvP4236IbZjEjhTOEne
 fPGQ==
X-Gm-Message-State: AOJu0Yy4aBphzWly4EB9J3sjlyruCiieR6+l5Ms3wMafcA5lgCW04Chy
 e66jOFC7JJI5wZ6g0oaLSk1lrTZ2uvkXw+QhvPUIF85OPmLK6PXia4moa6oU80Y=
X-Google-Smtp-Source: AGHT+IGE5CF0qZU2N9SI54jXl8CQHEpDnf5NxIu0l4KDov9/qjQkzb1kCRZXv22qc9g2/7yrhalEuA==
X-Received: by 2002:a05:6870:e243:b0:254:bb5d:468c with SMTP id
 586e51a60fabf-258428c33fbmr3042564fac.21.1718376862068; 
 Fri, 14 Jun 2024 07:54:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: m-chawdhry@ti.com, Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, afd@ti.com, sjg@chromium.org, nm@ti.com
In-Reply-To: <20240528094954.4135421-1-n-francis@ti.com>
References: <20240528094954.4135421-1-n-francis@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721s2-r5: Change GTC clock parent
Message-Id: <171837686141.2655592.12990031642708776731.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 28 May 2024 15:19:54 +0530, Neha Malcom Francis wrote:

> MAIN_PLL0 has a flag set in DM (Device Manager) that removes its
> capability to re-initialise clock frequencies. A72 CPU clock (GTC) and
> RGMII has MAIN_PLL3 as their parent which does not have this flag. While
> RGMII needs re-initialization to default frequency to be able to get
> 250MHz with its divider, GTC can not get its required 200MHz with its
> dividers. Thus move GTC clock parent on J721S2 from MAIN_PLL3_HSDIV1 to
> MAIN_PLL0_HSDIV6. This was already done on CPTS node in kernel which was
> similarly affected (linked).
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


