Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07877C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8893F8764C;
	Sat,  9 Dec 2023 19:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a7kFHRSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3357A8764C; Sat,  9 Dec 2023 19:16:46 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1035B8744F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db54ec0c7b8so2741802276.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702145802; x=1702750602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MgfYEAqBYFdzhhhSgnUS7RJvqC7OKwna1LZV13rrKs=;
 b=a7kFHRSQNZQ9JeYFARyU3ZgnlmYSOV4P7w3Sfvtb384DjzL1B7HUM85RQK1cIhPhM9
 O2EaCMkZUV4F3UlaXldF8TfM0j+ZNRanpBwV/HaMemt1Z0WAjfyFy+8jDDhgveVR0h6R
 tMFpz8oXjHB+Tk8++Y5rN2O0HkMi0azfAdoMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702145802; x=1702750602;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MgfYEAqBYFdzhhhSgnUS7RJvqC7OKwna1LZV13rrKs=;
 b=Zbeh0UQU7yiFyBaP6xx6wSELHlxo+pmLnDL3sqdFgez5TN9PoU0CXmX4MpqQ3E9wNv
 zSQl61rE4kTOOm2KejN4qh5BkG6SKdUDP0xnXsdPnr8mlbKgWQSXueMDxocQ0PV1CV4O
 jXiaJnWyBENNEeDbaoUSoG9xJO9kGOPTFq50S2au+ophuaZKD84cEdu3tH3lzX9sQqSB
 u8NltB+Exr9h2qgAlxb/G8O41hTjH4L/ZKalENWvz5OvGlHwjNZ44C5UAaT070V534Q/
 DQryhJRPWkh6zDmgcj0WA6+Z82P2L4Lm4sS7d4Nvq5ALnKHFuNFYb6Jd+uSQ+hwpL/J8
 nFKQ==
X-Gm-Message-State: AOJu0Yw11oeCNEEGwON5VCM8n8nyqjQi9Gc7tjDLsk0F8oC13XvohoHM
 n0DPScG2MI9Xn64SeRnZYIcQYhikKyrdMJ6WWno5dg==
X-Google-Smtp-Source: AGHT+IGUy4ToVdRpOkh/WTsm/0v2EFVnxhSLbI/2z9HfpeExq0g5/0NOjsQyli+MmLXr8dSkUFd25g==
X-Received: by 2002:a25:2b07:0:b0:db9:87bb:7235 with SMTP id
 r7-20020a252b07000000b00db987bb7235mr1901732ybr.38.1702145802428; 
 Sat, 09 Dec 2023 10:16:42 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 x194-20020a25cecb000000b00daf198ef6fbsm1421072ybe.21.2023.12.09.10.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:16:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shantur Rathore <i@shantur.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
References: <20231119165501.1305136-1-i@shantur.com>
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
Message-Id: <170214580181.3428762.11947462775063922996.b4-ty@konsulko.com>
Date: Sat, 09 Dec 2023 13:16:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sun, 19 Nov 2023 16:54:57 +0000, Shantur Rathore wrote:

> Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> This patch series fixes issues and both network and disk boot works.
> 
> Shantur Rathore (4):
>   bootflow: bootmeth_efi: Set bootp_arch as hex
>   bootflow: bootmeth_efi: set bflow->fname from bootfile name
>   bootflow: bootmeth_efi: Handle fdt not available.
>   bootflow: bootmeth_efi: don't free buffer
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


