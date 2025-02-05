Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E47C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 23:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFEE4807D9;
	Thu,  6 Feb 2025 00:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CxZ58XY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDDD8033D; Thu,  6 Feb 2025 00:15:23 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4A98033D
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 00:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9bac7699aso340384a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738797318; x=1739402118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z+ydm8m8tzgzgahPTq2hPFcA2H/p71CI5vFal2L9wSc=;
 b=CxZ58XY53lnhTrN5cC/T7dHmne2P+HFVrQBjuOR3oyN7U/ynmbIP6xyFcq0pxARGte
 eTq59lZ9wtH5OKPxw5AmLVjbp9FSvtUHhxlsWPOx3QSndnz/mEQliD/GM565wIJgsqao
 Nm2Nu/aLFm/IJacsjFVTB1BABED8Xazrx0DB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738797318; x=1739402118;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+ydm8m8tzgzgahPTq2hPFcA2H/p71CI5vFal2L9wSc=;
 b=nAhV13xgfzmJmygaBTGYidVa/NaDJLVMLKdlhuA5ATwHcRZreEOlUNc/xbPMhuuvxL
 rdZ5YcWTfV6Kk+2CjTYGDtAdlRdpfZNbUaJGkHC0wJB4yNMiwdVsHSqfJA0l+t4CgXE9
 CNY7XUpEMYHK3gio5d+b/ACuTNOyUWvSHl8dwUCTIcdVYcV8ELEKwYmuGw58SyegjT5K
 hN+p43WowYwohJ3Idb0Vw6okKgqif3w9T2KXyUzi9qJYnHQdMYH30XkKc5F/4fwTsm6n
 XRUBWHo5HMte07XXlUmIWgg4vHDosSKOVJ03zq5nTJfT7raKxXGSWbLY0dTJ38+TbQOu
 ln6A==
X-Gm-Message-State: AOJu0Yw3UC0BwuL+IDUk2WZLNn1Vzk9gcGpADMGcperCWwlIjhfwGxGV
 w7MAm8qqCpx41S3fHLE83UvRcJgymns0XuGPQncHVntJeTb1JNqSKx19W6YH5ZJcAqQWfUrjMCr
 z
X-Gm-Gg: ASbGncubsrRLibm5qVer+EJ6ty73uCh7yCeS8CJ/gQlG+D4ivsKThUZ3Ykbid8zQlxd
 3xn3xOVtBgrSjJdFY59Sb2b9L+pYCKselPYzELBrQY5drq4FhBKWblF+izfSf9yKh54mL4lWse3
 9TaMCoY/S2zQka0LJ6SWJvgqBrTWVMz4IB+KsiB+83sbLQLdqZ2prbe1me2Wn3mRNBWIoabLBZM
 BIeRZh7nFXByBXLHyWBmNeSqWhqm+TzmoVPjLAOpGgZw6DgJlYhobV1+rpoCGgQhnNRs5ajilwb
 Vz7JWAjHTFXh3g==
X-Google-Smtp-Source: AGHT+IHI/Z9dQqxvee9mAhZ5YmXM4FOOl8Wf008im8AkqPELODmVkHRGDyg3etk/4wSWMUU5dO+IGw==
X-Received: by 2002:a17:90b:3e8e:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2f9e080f2f3mr7007891a91.25.1738797318437; 
 Wed, 05 Feb 2025 15:15:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f26e5sm2622901a91.0.2025.02.05.15.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 15:15:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250205174902.140131-1-marek.vasut+renesas@mailbox.org>
References: <20250205174902.140131-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <173879731755.2019786.10376661880160894572.b4-ty@konsulko.com>
Date: Wed, 05 Feb 2025 17:15:17 -0600
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

On Wed, 05 Feb 2025 18:48:45 +0100, Marek Vasut wrote:

> The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1224416:
> 
>   Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04 11:57:36 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


