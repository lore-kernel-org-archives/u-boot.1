Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DBDC02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A5480EE5;
	Thu, 30 Jan 2025 15:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FSDh8H4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38DE381219; Thu, 30 Jan 2025 15:48:38 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7960680EC1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2b199bb8af9so955589fac.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738248514; x=1738853314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AJNkrJ5PXh/Rg4QnjEHTJEnSY03fKUpSOwh7mKk4TQ4=;
 b=FSDh8H4oph/gf2nCl00QdaHe39twG8Llgi7vrmkTOBhVr8PlYXu0ms1XUf3cUGehNX
 E1SqvEzyhc6ACIoF//kfB+Dex+Xb3TznDyzGwonEdwX44C7DTdR8vWEI9Xz+EuMmap+X
 9XI4PZYcAUj4BMel7fzkPvCL/xpAmJU9CRQTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738248514; x=1738853314;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJNkrJ5PXh/Rg4QnjEHTJEnSY03fKUpSOwh7mKk4TQ4=;
 b=hAjgicR4jtwAefYjgw9KkSYVJiYjQ9/RNUrI1p9OvlKRg7Ba1UiYRW7BAgqqgmkVhf
 JmLW52spQ1jfKBs6T5xXEeteY77Qd7Y+1z5+zlPJCmgu4pL2arWfWexIWAlxTwQyI+FF
 47+hrav/02iwdJ5+h8YYGgHDV8BdaVGua/JTbNtgiKVVASkXAicXhhLaCxWq5ujr7YTe
 jTmrrtn7CoDN9NLS94tgT479yyannZl7H+tQ4O+TtBQsDo6ywKezvTKSyxGCk4n2g/Ul
 dZXX6YnF+UEHRAQT9jJ+br0lI7YVBvb4qoelU3XgTZVDzUFs4rxHtY9LTi0xglmvtsAD
 Ai+A==
X-Gm-Message-State: AOJu0Ywo0DOdnZYHcsuvBcoemBF004BNrjAOO6ML2+Edw1NxlZ/GzWvV
 haLw1sePEQ3R0bpvdkjLHsIvL3sRnI0nakQXB+rcWthf5w9+RMgr6WwoB7dx6Pvah2iRQRmHwJN
 f
X-Gm-Gg: ASbGncu8gy97y9A/lGiuPqsurMd/K7pERpJUpdryo06foLRJOGzxI/tBhA3OcxkTJaT
 F0ApqzhgASp8Wkm7uUOUjDM3stW1ffLIW52Xv1aJRqaXR4QfvSXUcRbz9c0H7eL/cKwu8J/j1I8
 5gRsYnKK1XZtBEZuHNAkxETsVBEQ6lPUmyP9+sqgdaSHatutZGqpVoaNCYfvbJvFqkZahXzgkDl
 wKSx2/aCp1RDCJ762lPM3ESgVEN38xrNv8V9UiCtIUv7BdpevCzIcuST6MWCvoN/euDWfdGB3vk
 YyzQV5aWpm/vgQ==
X-Google-Smtp-Source: AGHT+IEFEHTdbTHOaoarjqvY7s51/62NOhr10bpsADR2l6rCzN1Kz0ZFPcThp9emhrP8amIfSkvtrg==
X-Received: by 2002:a05:6870:e2d0:b0:29f:bdf0:f0f5 with SMTP id
 586e51a60fabf-2b3501da6a8mr2418755fac.17.1738248514166; 
 Thu, 30 Jan 2025 06:48:34 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3562131c6sm434712fac.19.2025.01.30.06.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 06:48:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250130001920.335898-1-marek.vasut+renesas@mailbox.org>
References: <20250130001920.335898-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <173824851287.2441015.15392562763950822864.b4-ty@konsulko.com>
Date: Thu, 30 Jan 2025 08:48:32 -0600
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

On Thu, 30 Jan 2025 01:18:42 +0100, Marek Vasut wrote:

> The following changes since commit 021baf7b08cceb58bb850859dba1614424e16a83:
> 
>   Merge tag 'tpm-master-28012025' of https://source.denx.de/u-boot/custodians/u-boot-tpm (2025-01-29 08:12:21 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


