Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98712C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F7487FA3;
	Fri, 22 Mar 2024 20:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DWbBNkZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5422588178; Fri, 22 Mar 2024 20:26:11 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3DD87964
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-ddaad2aeab1so1039298276.3
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711135568; x=1711740368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVpcjXl570lx35yt1ndqpUAI80x28VD1qCKcvcsahFE=;
 b=DWbBNkZ3yxWsJAH/Ik1QMyfue4ER4hiJwJYyybzopPFcjqeYxO1IgLo9rUiphX1gdS
 f9buRJoRgCX8xoCC2698jp43p8CI9glazPWEB/LXpBSSgO95viwt+yXjkfcsEDYa5Upb
 SYJeRPPoY+HP+MQw9uZ6cbiWKQ2HHs8FgoN1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135568; x=1711740368;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVpcjXl570lx35yt1ndqpUAI80x28VD1qCKcvcsahFE=;
 b=etNFJ+X5ra1O23JGFG98Wi8xhsbo9acnAOVAJZgrVIvkwB9GpqJqyKSEJvbYceQu5W
 jkFHknd+V8X6oyHzbvk9payTYlCP12/DTde8lmiGBS8dLEVKCRggrxhxcLBqk8F4pnMX
 dL2j0VyqieRLXmLGXTnjAd7gxnZdbU5dav3VGnfV2rakmVXz2AAt5T8EHaiUasMsl8YR
 3fDRqZP4GotWOl5DprM/ndZlF0p1F/jLhI0OWKDvtYXBiyGMeg/EiV14vZU4RqxE5XIr
 WksTNOdINHG/z3SZWCsBb+6qOs8XusFYDCZr+HM0UifHwJDrAI30z+M13/eH7f6Pz8fe
 srIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/VwyxbbeAFLuBAUAhwjZUsgjbxGOhvcAEUc9g00HDAI4VdKA3au8GHkgHMPJVsstxkihF9RP/wS15owYseSFTb9LZKQ==
X-Gm-Message-State: AOJu0YwnYYsBC6sw6f27M0Uh3z6y2QOF39nvqmnWgJcM2vd7oXpj9SNS
 QOuFOF+PRzJPt2UYFh8Jx6+9xL1Ek98EHVtKclVYyJgTiNkGlXX6rJGdgX1tGdA=
X-Google-Smtp-Source: AGHT+IEyYltOigVmzRfZvhljsgJq4wfwLT16yDKyIPja7QJ+8tw3yyIGrbsW6WvTqmtxaOTdm2UtXA==
X-Received: by 2002:a25:9a02:0:b0:dcc:9d30:58a0 with SMTP id
 x2-20020a259a02000000b00dcc9d3058a0mr278633ybn.64.1711135567806; 
 Fri, 22 Mar 2024 12:26:07 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1362309qvb.97.2024.03.22.12.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 12:26:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: seanga2@gmail.com, Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de, 
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com, 
 hiago.franco@toradex.com, joao.goncalves@toradex.com
In-Reply-To: <20240308201316.1721909-1-festevam@gmail.com>
References: <20240308201316.1721909-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Message-Id: <171113556673.2191577.1419243975260990823.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 15:26:06 -0400
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

On Fri, 08 Mar 2024 17:13:15 -0300, Fabio Estevam wrote:

> Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> the colibri-imx8qxp board no longer boots.
> 
> The reason is that the imx8qxp clock driver does not handle the
> LPUART IPG clocks inside get_rate(), set_rate() and enable() functions.
> 
> Fix the boot regression by adding the LPUART IPG entries.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


