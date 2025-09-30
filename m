Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6174CCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77437832AD;
	Tue, 30 Sep 2025 18:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RXGlgDcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7154832AD; Tue, 30 Sep 2025 18:26:30 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6945B802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-425911e5661so24549725ab.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759249587; x=1759854387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nz+/AihihUtxJeMISnuERZOQa2k4BBYHDoGtgTMrZwc=;
 b=RXGlgDcr2rg08JkhlTtL5V3WXR7rJvkbeDmg866aWESDgYpVzdMC06hZn6S6TacLkV
 A+rCu0U9fln4l5C1aHh39JFlgnTFpCa/7b/IsQCGN7AFAwNOxtpfAXm9ffYZW1ROTf9I
 Bsef4YxFo6z8/qLkK5atEfxPab6Kq6yxgWWXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759249587; x=1759854387;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nz+/AihihUtxJeMISnuERZOQa2k4BBYHDoGtgTMrZwc=;
 b=NmTvCdYl4X9rBUnEqlNnwjma+QInXkWJv+LzBhaAyuh4uBiIRwJgPLxsLHDimFRyVX
 20Kk+8zgrbPmKzNo43IjjB41jcNEKki+AmsrOTnOb5Oiws81alkJGEjxerw8veIu3m6C
 zzLp1RJx6CtNewX4W100ah/bzl1oZEPVW2dA2frtAcvecVyMh+xgmw8rPxFsDU6u5wkl
 6Wva9wCkTxP/i5lSNJb7N4L3C1eDNx5h/QPvdmmAmO71XswJmrQntUHDjMpnMOp1fLgR
 ohZou1HCGmNGg2/JaRtGiytTlHiXGsD2ZUVCy/K/btJd6EXLJ7ZifZScxZdv1SoTfWMU
 FCCA==
X-Gm-Message-State: AOJu0YzE7njuJ/6vbZkyFsOSDEBTL6GGlNwqbcYnm+DnNLztX+2JvG9i
 0rhnsXoKgqNnxPFHTBhXMjFYC5iwi2PfGkTYYo0NmS4I/R+jbZsMTAadeiluzu/qg6Q=
X-Gm-Gg: ASbGncscmSbUEumMkwNdUZDbkUf3jj9JRdcRMvaKtir+3FV7h3PycAuNuROPlmy7PlN
 AOuDUXDj4Ifa0dCpwYqGIv9lRByT9AZPdNswePy9kNtfKylOYRnGKI/IRdxYDrSgXTyDR3et9aB
 8/DdANx/fhm52WXIEcb5W8MZOgQWUKh1S3QdGTtwA71o1mTHjnceGQSnyKBEfyrWDbi6blRc21M
 oAUM1jp/jdEkasmcdg/Mm1cNw6kkl3GKAV9i/Kx71tixSwssJaCS85RrLxndRP6X5V+Cioxtxnw
 jovewuCGGRQGzHq30y/6qYBS5kNFdubVzyp/y80afdFRZaJGuWFjgbVISatOmcTkumPE+K4UQw5
 1PDfaoGUjT0TE0WqVISax45IdNUXpXnud6J9Y4Y5eEQSSZKQpCednRtKe9hgQWvILqeeB9ZAQQ+
 5H08I=
X-Google-Smtp-Source: AGHT+IH5SKitjwzKGqXL94jD8iFF/Qh6OMTHuOkhVIWnj/A1lSKr9sUVthw+EWrIrjwa+EYNBNTikA==
X-Received: by 2002:a05:6e02:194e:b0:42d:808b:aaec with SMTP id
 e9e14a558f8ab-42d81624423mr8299185ab.26.1759249587051; 
 Tue, 30 Sep 2025 09:26:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425b9133085sm70159935ab.0.2025.09.30.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:26:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <8030c76a-e70b-4be6-aba9-86fc93c26e9f@linaro.org>
References: <8030c76a-e70b-4be6-aba9-86fc93c26e9f@linaro.org>
Subject: Re: Please pull net-20250930
Message-Id: <175924958612.1117195.15460456128609638814.b4-ty@konsulko.com>
Date: Tue, 30 Sep 2025 10:26:26 -0600
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

On Tue, 30 Sep 2025 14:47:59 +0200, Jerome Forissier wrote:

> The following changes since commit a239b0b0b6dbe6a168969b8cd6e600cf85db278d:
> 
>   Add symlink from gpl-2.0.txt to a COPYING file (2025-09-29 11:56:16 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250930
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


