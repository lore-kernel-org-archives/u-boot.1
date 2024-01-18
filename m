Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0356DC47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B7287B8C;
	Thu, 18 Jan 2024 13:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz6s9SNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B9487837; Thu, 18 Jan 2024 12:04:34 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C306E87B50
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cddb2c2b54so30994751fa.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705575872; x=1706180672; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3rsZFWziCmcK4K2TlY5xgQ+QRwz0BWpUWIWvIGDJvM=;
 b=Dz6s9SNXXTk+FFwHSpqIfPHYCvbwrPkKzt/GRsC2iEP2C7s25W/5efT5MQAxt8VDpl
 esZKEMAh6wa1ybvNTNV8DEeYQag7YTxzDM2nSiKDC+SzkwyEmzg50g2qpKLMpgtzuBA7
 xKV3TKUCt+jWfgrCtVyLZSJ+TDK1pkFgYeetnSnCgdN8qX/PxxYqKHDu2QKxVfBzVe1Z
 Sn5BdI8xD+T1nW813K6cykhYGUFY/bfByDC4Dj/xe7ksh2HQ39A5SxSFpY1snK0V+E6z
 EjMt+ifCntE+YEsrdwoYeniC+R5XdoSwHiy1KMn2coODnA06kKEj89NbojsS7uuYlBKM
 c5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705575872; x=1706180672;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3rsZFWziCmcK4K2TlY5xgQ+QRwz0BWpUWIWvIGDJvM=;
 b=W99yNTIyHXteL7UGSsM9cz5ITLNB0SoI5MqSqCTYt5KjYzcLUjkFjkAkCVjI4LpFvi
 zEWWTs3238t+lhRUs4B80WDwB/Q6c3iqyB1FVBFAldRcwcdiVvqwwdyvxWrAJBOmcY15
 fJR6srW2gc9soNontk20TDL9YFw0bR+nHTITEoomYnw1PQNNY/JOq6gBPtC5JEPx1aPe
 PYoPvqbEXrdn+HNjEw/rZCRR/YndPqoLG+3iU0GuWOPCclipcS6EQTztT+cAHX9kxKPh
 f82iNDYRuPb4U/UBzERdcQaJJFxOhhgzY4B8mdpgfR+3EPJ4zP5zneXVbE3xDJNS6+ZD
 FinQ==
X-Gm-Message-State: AOJu0Yy6L/IuY2OumU/lIb49QCHuuqVFTiKfxQ4TNWDKyjTHe5TC33p0
 PsglC5OVB/Z2u1fA31p/AV0vKyeWOXkHbk9+YYPVwdD8QgHlNh7E
X-Google-Smtp-Source: AGHT+IHs8+UMDiW+KRIsS1Zfl+ctWbP0MxXSukE7CNA79SdVPr8dgMipEoCCt1s5novLSHRSVCjcpA==
X-Received: by 2002:a2e:9116:0:b0:2cc:77a3:62fa with SMTP id
 m22-20020a2e9116000000b002cc77a362famr427710ljg.16.1705575871696; 
 Thu, 18 Jan 2024 03:04:31 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:2d72:bfc1:4136:432c])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a056402091600b00559e6a4f4d9sm1717972edz.35.2024.01.18.03.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 03:04:31 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,
 u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH] Add Phytec i.MX93 support
In-Reply-To: <9add814d-540b-4ddb-8cfc-261e62049d7e@norik.com> (Primoz Fiser's
 message of "Thu, 18 Jan 2024 11:47:52 +0100")
References: <20240117075254.8520-1-othacehe@gnu.org>
 <9add814d-540b-4ddb-8cfc-261e62049d7e@norik.com>
Date: Thu, 18 Jan 2024 12:04:29 +0100
Message-ID: <87ttnavr5u.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 18 Jan 2024 13:45:03 +0100
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


Hi,

Thanks for the review!

> s/imx93_phycore/phycore_imx93
>
> To fit into existing PHYTEC boards already in tree.

I deliberately picked that order so that it is aligned with most imx
boards already supported by u-boot.

The supported imx93 boards follow that pattern:

- imx93_var_som
- imx93_evk

So it felt natural to have:

- imx93_phycore

Plus the kernel device-trees are also following that order:

- imx93-phycore-xxx

On the other hand, it is true that the existing phycore boards use the
phytec_* pattern:

- phycore_am335x_r2
- phycore_imx8mm
- phycore_imx8mp
- phycore_rk3288/

So that will be confusing no matter the option that we choose.

I will come up with a v2 fixing your other remarks, but I think that
this should be addressed beforehand.

Thanks,

Mathieu
