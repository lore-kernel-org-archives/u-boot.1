Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C08C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8526F80BB0;
	Tue, 11 Feb 2025 15:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DJiabdGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91CA80AE5; Tue, 11 Feb 2025 15:18:03 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F428043C
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f5660c2fdso77494475ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283480; x=1739888280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Ki7I8wEKYL4Hzb6GApERZE8n4DCu+IUYCXLDQWmZAU=;
 b=DJiabdGEKkasVU2FXCC0NNwA9Y2bUa3iGGH4Pcth8iX/RbTBuoOco3mCcjoKjTMz4G
 Y2putEr90fY9O44kchpCwDtZs4UC2aOprLy4/SGDN2xhL2Pgq8uT3rkM1i1VF8+39xQN
 7UtmXSqRGi3jgTmfJFyzJoxz/v3ZAo2VOP/40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283480; x=1739888280;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ki7I8wEKYL4Hzb6GApERZE8n4DCu+IUYCXLDQWmZAU=;
 b=HUf7qP/HscJ1wMody75p1aRN/pOzLcItJuoU3ygGHtvHbenUEJHQgvHq20aamsFe3b
 Rqqe9+0vTsVTc3+RZeTghjqgCZ9Ajrtne1ZNZiswcC1fosghn4+l01BfeZLuqskkWx/j
 cTmdn/JQNinKT+40HyAu61/+mhZkuCea7n15xls+3QSeXmE3ZorOpcGDpmY3KOtKenNM
 VhH+489Q/Ae0yArqTa22Ec5x1VxtymNZbteQrwl9k+artxX1vUTQn6nCgnj2ztGoHR8K
 B5tGmlkU9E88p+D6PKVIsGY98hAqORZUe0ENQcvfQEDAwf3g6G4VRkygyp9nQe29whv5
 iNNA==
X-Gm-Message-State: AOJu0YwgwmFdKTS3Enup5QeRgL7hITygxY3TNBX4HWRgseQ3fsfqXcOO
 YbRk1Rzr9DUDhL/yTv7mDib5OSA4KmnVlF0Q6AB/6hOsXRttH3epctEZb+PRP0M=
X-Gm-Gg: ASbGncvrj4MJx2070saflNkAJ2n1ayujZEQeJPw2P38mGBMH6rIEwOLjoyjNCbqBHgZ
 5Mu+wwf6uEyp125CGowqeX6//gvL4EKwNRXLcb7YBOxC78XQmzg4OO/XbHwAvX1wQsUwdgfcoJ7
 RNRFFHY87rsbeTbMOIY3RNH6Y9HUqBQ4qYCWTBFLOa4kKLq8VZyIU/Fq9IrxaA3H+cRP2J8d9n9
 +uRIhaScdTpvN28QtT0gilfOfJe1tUogZKi7ve3eD02K8PS8JcadYYBlUJTXoRpq3+Iu7p6XS93
 GT3H/Sx5AbzcvQ==
X-Google-Smtp-Source: AGHT+IH1hJ1C2PKVvPMUqTxeyqBjVsDThnJpid/nEq+FJinLOCia1JKvC8t4ta24ZFWOmkGUxPHg/A==
X-Received: by 2002:a17:902:f60a:b0:215:8270:77e2 with SMTP id
 d9443c01a7336-21f4e10dbd6mr307688535ad.0.1739283480031; 
 Tue, 11 Feb 2025 06:18:00 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:17:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20250130134258.271298-1-ant.v.moryakov@gmail.com>
References: <20250130134258.271298-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] tools: fix NULL_AFTER_DEREF in image-host.c
Message-Id: <173928347933.3071479.3511975622058013364.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:17:59 -0600
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

On Thu, 30 Jan 2025 16:42:43 +0300, Anton Moryakov wrote:

> Report of the static analyzer:
> 1. NULL_AFTER_DEREF Pointer 'str', which is dereferenced at image-host.c:688 by calling function 'strdup', is compared to a NULL value at image-host.c:691.
> 2. NULL_AFTER_DEREF Pointer 'list', which is dereferenced at image-host.c:689, is compared to a NULL value at image-host.c:691.
> 
> Corrections explained:
> 1. Checking for NULL before using pointers: The if (!list || !str) check is now performed before calling strdup and realloc, which prevents null pointer dereferences.
> 2. Checking the result of strdup: strdup can return NULL if memory allocation fails. This also needs to be checked.
> 3. Checking the result of realloc: If realloc returns NULL, then memory has not been allocated and dup must be freed to avoid memory leaks.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


