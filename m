Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344F2C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A7F82162;
	Fri,  9 May 2025 20:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QViYYg+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBAC82A4D; Fri,  9 May 2025 20:57:53 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522EF8269F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso581293fac.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817070; x=1747421870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2IKCX2E8wV9oHBUtwlwVCDaAeRuGeIg0weaN/y6h4Go=;
 b=QViYYg+h/1jjN7+dgHqlK2LpbV4H+KXah/E326oa/1Uq/ZQaVbbUYEfzMyuGxGT4pv
 8t0R3p+ZEWk0CS3fi970wP028x+4Vlrj1I7baLXiUXt/YtoF9UxdqJ8affx9LMveug9+
 totD9Q6fjQRkDNBrjVfj6FxavGVYL+MRlkB8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817070; x=1747421870;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IKCX2E8wV9oHBUtwlwVCDaAeRuGeIg0weaN/y6h4Go=;
 b=rdZmVrUqTpb4K+toUuOmkoaYaKH60lpXi8S1iVQ71pVOBGoqkdb1WJDtqimyg7doSh
 h4tl5POpFJRXdv2jfNmyHHPAGJ1EK7zjuft5Lrzi/AmeNBsMOozAMnQ5qtuPyLMd81jM
 XNzG5ay8xp7w4ARVL3MWZrIHGKQvMGQh4v0RvNU1rrzf9BpbkOjZNGSmrRxZp8bx/oQS
 BxZoCRHnJ0jaAiaI5io/7YyUFQY8hnKMzi3jQMF6Dc2yD36ZHkeYXUB6/cq3T4aZG1zl
 K8h1DItUzJiLYSNkn+JBQ0IHZSP7aDtOg07apZaGoWSGkEzyJg6aT6RNuYwFueY7il66
 QFmQ==
X-Gm-Message-State: AOJu0YzOZCck0KNz/LIiFXI8e9JfHwih5g+elVYbgGAjTtT2t5M5vm+b
 XqDxDPajDjiqqnar+g+n4lyq0y8tHWwP/Aj/eMTCJMzwmH21Dxe9cslhXNvdf3Y=
X-Gm-Gg: ASbGncu08976kNuZcpAAO6obT2b3H9Oj57yIubFP6m/eQzxN/WykncRKKzyxSGkAdSo
 0zW8hM01JYv1OW5stOkhSYIwTfZM7+t9TrTL4u868nvfSk4pYNvUONhSmxN6xkAZP48/xl3W4I7
 uGXbQUlt5oLqH72aN6l3Summ1MsIjRc6LVJm+O9r3+hN+ZN4HKwvefNuxV7BD+fFATiXLc/4Iqg
 Km3DI6/ye353LJ4RBG0f/S7Bs4ZYvDwVNMD4FmlLBrJtfAyfDfn5AZwsDJuZXf8Lityz1TKFweV
 tmrwVXfWx3Qr5sIp+gESFB1bMLkbLJPdWC/OmauFP1mACmsGDHVvdu1O0bnQ7WI0gThLTJSZm2h
 95+CZOGqepFc=
X-Google-Smtp-Source: AGHT+IETM7mRLfcNKu9NDItbqPaloo6KR+9taKAufS/CX5w2HJg7ULr1C97ujNUM8/rrIJIJ2FJ16w==
X-Received: by 2002:a05:6870:958b:b0:2c1:62e9:584b with SMTP id
 586e51a60fabf-2dba454dbafmr2371854fac.39.1746817070103; 
 Fri, 09 May 2025 11:57:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06e7a10sm721707fac.18.2025.05.09.11.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20250312090130.2951848-1-naresh.solanki@9elements.com>
References: <20250312090130.2951848-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH] x86: spl: Add support for NVMe boot device
Message-Id: <174681706881.750074.1021050176494553325.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 12:57:48 -0600
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

On Wed, 12 Mar 2025 14:31:15 +0530, Naresh Solanki wrote:

> This change adds `BOOT_DEVICE_NVME` to the `enum` list in
> `arch/x86/include/asm/spl.h`,
> enabling NVMe as a recognized boot device for SPL (Secondary Program
> Loader).
> 
> Tested x86 hardware with Coreboot + uboot payload.
> Verified successful boot to NVMe drive.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] x86: spl: Add support for NVMe boot device
      commit: c73acdb392a581ea489001f8da09c43c730b7b98
-- 
Tom


