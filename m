Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9223CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F77388356;
	Sat, 21 Sep 2024 04:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kk0v4CZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4A487E30; Sat, 21 Sep 2024 04:39:39 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC36A8878A
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a9b72749bcso231921885a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726886376; x=1727491176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKabKiMb+zVH3pOMnl0opKLsdZPSZ0NIfuTQODCdVF0=;
 b=kk0v4CZn3e2XoghqxYqQgHRSegh2YUO3UEWAQVTzjHH3Ir/TAyhEOQnOPakQ10/GGN
 IBO988JzKDrTruYfGUmF+D9B8AXBLF38d4LCEzxZ54pU2QS6Vir7O6ah27LA0NODKRY/
 b37KJKhkjR81qzBt/a8Fu0D8Od+pJFMF199h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726886376; x=1727491176;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKabKiMb+zVH3pOMnl0opKLsdZPSZ0NIfuTQODCdVF0=;
 b=ofyR/CadBk7GjQskisIdexf8yvtYkFNPfE85emHMuZ2DaFFbStz/Ed883pSY8Pqi/r
 HgEnEd8cFMRtih+cTWO7B4dlBGF+V171ysvnGuxi4EfbYLLDV6ecPxuHv6Wi40+eJbrC
 VicRBIppA1PFdeqF1ZLnazHj+lwFzYedIJZAU6DaYrhbWrU0ZM/RzrDkiaTYtnlR3wIl
 y2EistTV3oURRe235M7GGklMW1uCpNFbpVUWtAMSXODHGTJTV2+y2mKGNVaKzenGB1FY
 LkEjTiCQe9WEupKf6l8al1+3NHa37KnL9PCdjn0JQo+KoKbRrXPkkbNomIs7AyO7iWkd
 Kz/w==
X-Gm-Message-State: AOJu0Yy99jAUPi+9BrDCYy7spSwEQKiKTbM1kYR7uq7PB5DZcXKUBeTa
 WWHlVa8eOSLmWtnlMd1q9GAPCTix3NW3bndgUUwe5O4x3EBKv2wsVMFY+laxvo0=
X-Google-Smtp-Source: AGHT+IFEB6gKEjZfOorX55EqV5180/6YoW4Qwnv4SLKfPXAyt04o7y5XuvBsOsqnt+bFgJDtxNBrMg==
X-Received: by 2002:a05:620a:4408:b0:7a9:baa5:54d with SMTP id
 af79cd13be357-7acb80aaf0dmr835498085a.20.1726886376579; 
 Fri, 20 Sep 2024 19:39:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb082a3cfsm251414885a.70.2024.09.20.19.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 19:39:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 padmarao.begari@amd.com, git@xilinx.com, jagan@amarulasolutions.com, 
 n-francis@ti.com, d-gole@ti.com
In-Reply-To: <20240913073251.2286529-2-prasad.kummari@amd.com>
References: <20240913073251.2286529-2-prasad.kummari@amd.com>
Subject: Re: [PATCH v4] cmd: sf: prevent overwriting the reserved memory
Message-Id: <172688637406.2451825.15512304723099878421.b4-ty@konsulko.com>
Date: Fri, 20 Sep 2024 20:39:34 -0600
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

On Fri, 13 Sep 2024 13:02:52 +0530, Prasad Kummari wrote:

> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


