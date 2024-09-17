Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C71CAC590
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F096288DF1;
	Wed, 18 Sep 2024 01:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aSeNlnjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF4F88E06; Wed, 18 Sep 2024 01:48:11 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457C988DEC
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4581d15c3e3so43893701cf.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616888; x=1727221688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QHWWEuHQYmmfHnHDxnRn0yQ4q4C/P605HvqbCRjMURE=;
 b=aSeNlnjP1rUjSBCplqFH1BsNzO/im2aLSGKP+HloliS8MRDsrRn79C9xQeW8u1Xdls
 EYooPP6rUcGJVwB55st+FF4/arwQnkGpy38OsP5gYTnQsHOS/iWeM87viQ9y+5CZ2gHg
 /5S1A6B+gZP+zdZCM/ft/7I5Qm7HCLqYviO9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616888; x=1727221688;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHWWEuHQYmmfHnHDxnRn0yQ4q4C/P605HvqbCRjMURE=;
 b=n29T400S0rqzWNdDIYJcmrNb+NKyadZoEHXonRd2kDhtjVQK0y63l509iOmh2gAMat
 BAp047O0iMdOYmBeSF/JkJjwGHH1rIZtkUnO2sNQ8BBfYZeuQGzBRciTpzPl0JchwNBc
 bH8wpzJzjtDzlZCE7qCXH2nMmDNYbUfAcoAOll3uIFJ1G/piQStqdRs9qqxbj+9xAd22
 kleebXk21kxNrSoCuYKIKsBgKnyrybPqTZq6OhYgYpmFz25SLBcdtYOhjgk4OgTiLnZy
 QSg02eFX1LOyiXdUxAtfLd4fVo9GtQQE9CJ1V3QlSncmIG2W3Tv759XcRH/p2UQ7vOYb
 pNiA==
X-Gm-Message-State: AOJu0Yy9BIo9tD+1mx2xHhUJmbQUnpz1fP5eSa4aCBzpPvdUpZOOr1cX
 APK+H1xG9HzoR+9pR8OkBo45wEl/TddmwU7tEvbUo1GAzpkAVQJGzonF6T0Y34HbG4RD558gCRJ
 1rus=
X-Google-Smtp-Source: AGHT+IE2auB5se1ICK4IeofBFp5ihSx/xlgWs8J2qF8xra7YFHN7ufJLvO1nWQTqWin+Sr9eNlB3aA==
X-Received: by 2002:a05:622a:2a05:b0:458:3735:da3c with SMTP id
 d75a77b69052e-4599d2d13e7mr272366631cf.50.1726616888075; 
 Tue, 17 Sep 2024 16:48:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2336esm43264901cf.90.2024.09.17.16.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
In-Reply-To: <20240830072334.2916897-1-chiawei_wang@aspeedtech.com>
References: <20240830072334.2916897-1-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH] drivers/crypto: aspeed: Add Caliptra SHA ACC support
Message-Id: <172661688638.2128296.11054124128483958060.b4-ty@konsulko.com>
Date: Tue, 17 Sep 2024 17:48:06 -0600
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

On Fri, 30 Aug 2024 15:23:34 +0800, Chia-Wei Wang wrote:

> Aspeed AST27xx SoCs integrate the CPTRA 1.0 secure IP, which
> export a SHA accelerator interface for SoC to use.
> 
> Note that CPTRA 1.0 supports only SHA384 and SHA512 and this
> patch is verified by the 'hash test sha384/sha512' commands.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


