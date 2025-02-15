Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA79C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 21:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE5C80C83;
	Sat, 15 Feb 2025 22:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aawtg9RV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7BA80EE5; Sat, 15 Feb 2025 22:28:58 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCFF80141
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 22:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso64465805ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739654934; x=1740259734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJwIH1RcFR9fdQsdZhi5kfzYHAsT0tooRA8Qe83ZGoI=;
 b=aawtg9RVXd5jk/igv+JVKmlkPUsCGsciDcbGlDMh7l6iiSYTcBn00RdbG3fT5yvIuu
 C4FSqTrgFw/T6v75NQNgX0ThCK/PLYuxdd2f79RgXksqxMdhNO0Zt1lu/2M2j8GM6dgU
 LgXUtNRdknaeUN2tk/iMdAV12Xm2Qo0FxBFkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739654934; x=1740259734;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJwIH1RcFR9fdQsdZhi5kfzYHAsT0tooRA8Qe83ZGoI=;
 b=nFNiATsvwEy95vujawMLSOCdf1qAjxkJVFxzCUna15pFVGi2alrtVCnX3bVByNZhWJ
 XGPZbeduIaFAM8uZJRp9KC2mDQu1WTTOFBGl5iFm9ayULjZ6490TUUlNr0fanZGOUxTT
 MByDihLZ9BXxHc66K6pZFPMPUzIijO+VECGyLIx11NzKL6ByPhRPp5xApkwzP3FHbXxn
 FNH9WvTLvRzia0+nNKzQ3NQpW36JQamyfNtPhDby9QG4x6qfAw39Ab+ExTwCIFTHIquE
 j0eJhIqfpK2nxd589DWiPQQu75sO2tLiotu6HpAjoN71eMM1M1Ep90aLQGDla4UG9Vsc
 AnQg==
X-Gm-Message-State: AOJu0YwcafWIloT/efxLNCO67rSO9dSWJq5kol35CHcgM0q/BzEnNBdU
 C/R62NnzdUgw4jjPvXG9g1uz5Ucp6Wz7oeI9Uq83+OcQVi9O0z9jpIVydQcmrXifKvOB2j9mhcq
 6
X-Gm-Gg: ASbGncv15BalCDNxi3At9bOPKy49NIxk4OMd8LXAEL1eFP/ErjRtaa443uL6tJ4RjsP
 l4xof20gq5M/7mpkqo1mbmeqBgRdmSl184PrE0edNQlkPL4BHriAFGeqwKDgPfmnYvFUpJhdiGg
 usU8Lq30yS79K/qTh0bbiqr4GlN9HOg6JjaKcll25jZNayH45uozgxPvCkLP6j/e2BDIUpvXadc
 90g4kQRc5afPmVqe8+9JFdvsfYdoZktFwlOg89L2GZ8W6cz1IJkBmtK0M2Q27DgtNqfTsMWc/qQ
 wrJcnd5ROOIE
X-Google-Smtp-Source: AGHT+IGjHxm4U6+DSmPpY6tftBKWAS8gfQszEUZMBVKlouNuL559zvrv1U5GGwwF2tYu7XUTz3H7OA==
X-Received: by 2002:a05:6a00:198c:b0:730:8a0a:9ef9 with SMTP id
 d2e1a72fcca58-7326190d9edmr6382922b3a.22.1739654934484; 
 Sat, 15 Feb 2025 13:28:54 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732521b82b3sm3532985b3a.92.2025.02.15.13.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 13:28:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, hnagalla@ti.com, vishalm@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250205131443.426635-1-s-vadapalli@ti.com>
References: <20250205131443.426635-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] board: ti: am62px: tifs-rm-cfg/rm-cfg: Update DMA
 resource sharing for CPSW
Message-Id: <173965493265.125355.14265897354428137287.b4-ty@konsulko.com>
Date: Sat, 15 Feb 2025 15:28:52 -0600
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

On Wed, 05 Feb 2025 18:44:40 +0530, Siddharth Vadapalli wrote:

> The CPSW3G instance of CPSW on AM62PX SoC provides Ethernet functionality.
> Currently, Ethernet is supported on Linux which runs on the A53 core on the
> SoC, by allocating all of the DMA resources associated with CPSW to A53_2.
> 
> In order to enable use-cases where the Ethernet traffic is sent from or
> consumed by various CPU cores on the SoC simultaneously, while at the
> same time, maintaining backward compatibility with the existing use-case
> of A53 being the sole entity that exchanges traffic with CPSW via DMA,
> update the DMA resource sharing scheme on AM62PX SoC to the following:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


