Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9EDC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8B782EA2;
	Sun, 29 Jun 2025 00:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FT9jUpwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F83180B9B; Sun, 29 Jun 2025 00:44:21 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD7482F03
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2e999729ccbso540611fac.2
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150655; x=1751755455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyJaoSChQnigXqJG+bRsDmC22ujYK/3XCJEaeLWJB+0=;
 b=FT9jUpweYhQyIT2HrQBVN7bZTZlpW9iJgWxGjqQwnvJqMejPoU7MMFB960mVdyGSZ6
 ckzVH+JDDLco9FM8gfi2zoK/3wHdHp1OME+iqxELA7MidnF79I6phS0exlmBRtlC/WKx
 ymhXKnTNuQQkX9HtOfAFJ9rlpSRwlf29mqtK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150655; x=1751755455;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyJaoSChQnigXqJG+bRsDmC22ujYK/3XCJEaeLWJB+0=;
 b=wZXL4Ybtq9d18wGPlRJtk3KZagaAQ01mqqq2+rALVfCnO9+eJmahXflIJzzE8cjWU5
 tkQdBSmxzcRKMM5idMvbyPn0umlU0K1DA0UmAnxOrSXXiklzVYa9p3b10m5PXrw9A83e
 m3ydA7zweNEfdvSCcOnY5YW/MiQNIKae+6wMlDHAM9pn8T/WeT4Y2UpoZeZBUotl2BOe
 tiKPS5q7n/DqoanZKCauOxLEkKt/lB645kOjJ+ZwSQbWEIYF05edNfqbdUb/V6qh0ZEO
 8HENb/YOBpW6WHoe9RC7DbdBl0+c7A5MkCihWJCeCogCEyVcJHpWo02A5CFPn0CbFL2J
 ylRQ==
X-Gm-Message-State: AOJu0Yw5BInsbOP6NwG7glHlPbbZmOSwI/qC3VgI/PcrNCbuPVcVzHIo
 RIleqSqcNUxKxKpwfGbbVTYHZ3NMiy4z1RE4ob9q7iX5tAefePHAjDbCavPAc6U81OmoEjEl4Rc
 wjzSV3aA=
X-Gm-Gg: ASbGncuafCNFUjBur0yIBkma54sshtMuBzTZ9INa+dxdyz/J85gH/HRi3AgSIQ1C0JV
 7pKean6aA1vR8Wo41P/5FyT5QOF/wwGOrBRdiZLvFzm9ULOpNzgcZI6fMvJh0MLIuve7Z0zjeJL
 bKSAi8tEwS/DxEaZFEanvn1A6dy2niVfja2GHIU7QUml7Qi4Ea5UcxM5yZMvBECu0Fv5NHw6A0I
 ELjV6Dxb21uR+4QbquSLBcjJ+Q89Ec9XSnhZTdbBEJ9mi8coC3X1g0o9WglCpLmQPTpEcxUJveQ
 4Uy/TLZgGvauJAdnTs3rg8dPSqwZWBsDcdTBajj/MU4EHm9PM2xpf4gEa1Ta9fhT+C2P1Edz0NR
 v8d3MTVQAmAZnPRZtpPa3FP/94+sNH6+J
X-Google-Smtp-Source: AGHT+IG5UAgHeipdWWzsDPNp6qvgWOGyPZyGuRZGquSlxXmjJQIeREHfj8ls7CrPYvd5E/wn7bVaSg==
X-Received: by 2002:a05:6870:f70b:b0:2e9:7e3:933f with SMTP id
 586e51a60fabf-2efed42c176mr4890549fac.3.1751150655148; 
 Sat, 28 Jun 2025 15:44:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eeee85sm1747428fac.12.2025.06.28.15.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:44:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Fiona Klute <fiona.klute@gmx.de>
In-Reply-To: <bccb18d8-d46e-4aaf-b69f-87ddd3701f88@gmx.de>
References: <bccb18d8-d46e-4aaf-b69f-87ddd3701f88@gmx.de>
Subject: Re: Pull request efi-2025-07-rc6
Message-Id: <175115065375.85805.3825747394144767578.b4-ty@konsulko.com>
Date: Sat, 28 Jun 2025 16:44:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 28 Jun 2025 15:11:51 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 359e3012921f2fc2d43f3c4e320a752173f82b82:
> 
>    mailmap: Update email for Duje Mihanović (2025-06-26 14:22:39 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-07-rc6
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


