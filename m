Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F1C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 18:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B8D81760;
	Tue, 17 Jun 2025 20:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEcomnbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7723E81FEE; Tue, 17 Jun 2025 20:49:38 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571C180E9A
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 20:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-408d7e2ad03so3875936b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750186175; x=1750790975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2UBR5dX6M59IVHe7YXPimffDFSFoV6pTNynxw7LApc=;
 b=QEcomnbYAjvLpSoA2RD5B/xPy7MqlxzkRy/nRqbd+14fh3k7uuErbprP/Nr2iEhcbU
 KTGckhmiolIIusoOMselmRznGYofx+lqoIWbZSPuZy9D/f8x8gRVYhidkrN4WQQb79RO
 YQ47e6ziORfrVpoa0stqxFz/Nj69O1pHUaqL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750186175; x=1750790975;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2UBR5dX6M59IVHe7YXPimffDFSFoV6pTNynxw7LApc=;
 b=gj6LXtvIdMFD66pYCR3Ij9CriohmZhRIt2/iPvJH60GEkfsxzvWTlj6PfOi3CkM2GM
 Ph7++mzzK/sXfcJeflqfKAvfkIhlbPxzgPS7CVNG0BRINtzACKHzieLfynARGe3tYOGE
 ZZRAKCOCBAP3J9f+MXYz3F5AH8Wc0mzFIpH7MruDXvRz1181ZVVsf2mnx58BhOjBHGgK
 qYY3P2G0uY1EUvWP9mLUGnsAK4s/zALsuOFKnBNIARUbKr86oCLVI8Ua6G2I5iTswOo3
 E9hF35e6yQMa7HB+e6o85oEm05dATjIToXiBkJGXpzwiS9BIyfX1MlrWRAXKebqjI+0A
 3ofg==
X-Gm-Message-State: AOJu0Ywndt9pi2xBi+jds/u+XM89UGivKDpna2mrIN6BymWrOELdw85u
 Aw990O7mTsYuvAE/m4xwX36LqjxBZEv6R178bDYzG657PgAzqbylpSs7e4X8RsjwWbQ=
X-Gm-Gg: ASbGncu3ekL5JeTbFG6LLyhJo68H2mV5JBW+U2vmrAoHPBdzOXbidK54vqk9otuO9FQ
 cRq3NlhDshWceCZ896x+QI9Hi+t8a8wm9ObParao/LlzGGBeC1p51/ioh6f2/Jjt48nIApRxtLr
 LxRigQZzO9rt7s21bkR8h52Fi5M5EjPgsyfCPsQIuGZDy1FRfUbG+OklrvQZwhcqn7OFJsMwCqj
 aGR5Lr6j2gX24S+oPXG4WbsRyCPduE1GteEUghtXSpQPPTWmyv5SqMJoVUMt1cigaZnkLHotVh8
 mD8P4gskdp+kkM5ZZ9ep5ZLsd/pM2tGRMz1LkFw3sBaFJGKZmy0EI0Iy1G6+Ef+T+l7Nx5BcqsF
 lhS/ftZCF6cf63WrRGzju1w==
X-Google-Smtp-Source: AGHT+IFsSglvfPyj7eqMmCPP8uO2gn5G/j5+Z9U/o+EGY+/cSjHxWjdlIZjBRo662Ft5mGerBUhkaQ==
X-Received: by 2002:a05:6808:218a:b0:406:7704:b2e9 with SMTP id
 5614622812f47-40a7c14f840mr9020328b6e.9.1750186175021; 
 Tue, 17 Jun 2025 11:49:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d73d80sm1161220eaf.4.2025.06.17.11.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 11:49:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250617123322.1020714-1-festevam@gmail.com>
References: <20250617123322.1020714-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250617
Message-Id: <175018617397.1660605.10482977389985235419.b4-ty@konsulko.com>
Date: Tue, 17 Jun 2025 12:49:33 -0600
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

On Tue, 17 Jun 2025 09:33:22 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 9de873b4c3098c0662d4adaeb1cc31be4e6d2688:
> 
>   Merge patch series "linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15 + winbond" (2025-06-14 09:13:39 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


