Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97AC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB2A81273;
	Tue, 22 Apr 2025 19:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L5q3klKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE49A812BC; Tue, 22 Apr 2025 19:32:24 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7873810F4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 19:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3f8ae3ed8adso3241369b6e.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745343141; x=1745947941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqBbHqvSESnKuJt+YSzRuNRsB8hVHahh+ZqDJD2cVeY=;
 b=L5q3klKQMghK1i9Zx+gbqfa+hY6U/F6/EOyu5Z2KvDUPGut+v4lwNdTE70PawruTo9
 ttRV4Xlsh1n/rPR80pGj/gDdHGkb+neI8B9nnzmD2uMvL2CSf1WaAx/Wo4EU06OjflTq
 8N3Bb3JfKaChrBNT+78snkVRx5C/NT9GRetwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343141; x=1745947941;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqBbHqvSESnKuJt+YSzRuNRsB8hVHahh+ZqDJD2cVeY=;
 b=rPIJgLcchCg/JXVMjeqvlEOQpvC9bjum1Aic0M+vY2adMEnWRpPNNw2FamsQ/oOnb8
 k+eOTDXrJtC9IqGYy4wLql+HLEUkM6TdLNh3qh6StkppdtDeB4O6x8T0yjYVb5AV8cOC
 wapbJmTXhlepZgusNaBQBQ8Nq8d4CeVhEMFZ0wNPGAaL8rrCC59Ph1FaSGnTsxtSLrvF
 qmbvOKoUNfNmBdajbwor93GJ5k9ezkLDPWT0uo4CMnPPvnJZHbJ/e90Zmh1FpkD2BL5b
 OYom2z3p5tf6LAvOGbcB+9YA5jp6MOk7UJuSlYCa6kV/WoEsExHo/oKAaGmT/GyhBLc9
 UATA==
X-Gm-Message-State: AOJu0YzsdwS3j4NLmbcgw2HI/6/XG6YXZvpjkDi3SitTCID37wSVhgP9
 OUSFI3dqnrKBNwxju3LWqOh5Fq54hPkvZc3EFxFl1ieOguBdmBMv0C98HulvDhU=
X-Gm-Gg: ASbGncsCWCJeAWU5rl7+0k4BqJf5q/g/vGaGsaE5nkGHp0m+ghWCk9GZcwBcB/l154U
 QuQeR+QETsQKAvp3/OUOhHlJ2QjcOtfd2G0XnTIxcIe1ndXU5JoKp+wocxfQFnsMFmw+3rd4MbF
 SM4vMDfAmjYiABWHCHYSQb2jAjcnf+LmiZfJjjx/eweT0Gqv5nvHQh3MkPPMqorC8KdO7m1G126
 Gf6R64np46SvJRMCiFeVadcxDynuC0FHzDrMbr+2u1+nHtOmo2DrrhL1ghUfI5xMtoMAyEakfN6
 dwjC8ryeaef0+GPsXXwRHzmqjRQJUlx2RQYOubskZV/Omki7eNHy/NcAQAu1ACk+arxrUVaiQJ8
 B
X-Google-Smtp-Source: AGHT+IG/jnjWGRlMYLWyvXp7D2wjQwhlDgJRspZFSBmW+XPn8naT3hyIXrZYZK1Of2Z5Ma+16PLSoQ==
X-Received: by 2002:a05:6808:8609:b0:3f6:76f6:b5ca with SMTP id
 5614622812f47-401c0a977dcmr7982626b6e.18.1745343141514; 
 Tue, 22 Apr 2025 10:32:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf081ec5sm2110493b6e.40.2025.04.22.10.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 10:32:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250415091159.36204-1-heinrich.schuchardt@canonical.com>
References: <20250415091159.36204-1-heinrich.schuchardt@canonical.com>
Subject: Re: [u-boot-test-hooks PATCH 1/1] travis-ci: qemu-riscv64_na: add
 a second network interface
Message-Id: <174534314083.500162.6800946282619466537.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 11:32:20 -0600
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

On Tue, 15 Apr 2025 11:11:59 +0200, Heinrich Schuchardt wrote:

> U-Boot allows to have multiple network interfaces and switching between
> these. This functionality cannot be tested if QEMU only emulates a single
> NIC.
> 
> Provide a QEMU configuration with multiple network interfaces.
> 
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] travis-ci: qemu-riscv64_na: add a second network interface
      commit: a7bd2dc1f6fa4f9f2adecd983ca283df1bc48792
-- 
Tom


