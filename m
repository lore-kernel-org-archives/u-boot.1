Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8568FE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4FE8022F;
	Tue, 17 Dec 2024 05:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tjYWe3AD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F89801A0; Tue, 17 Dec 2024 05:04:13 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB9D801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso34548786d6.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408250; x=1735013050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IdDfJzdR572+NgYBIK1DF+JqNSMWZnxXYoS29vlefiA=;
 b=tjYWe3ADH/TBcuOttTcVb1VZVyP5kEOFHrr6nvfHnmirHagDZnDT4HwdPP0e7NGU26
 6UkUpolnHONhaQ3RLwNa8r0+2R8G6QRY5M+Ism0ZPNZafOf5IL+LikNJcgDPbifParv2
 Ddiq7bkfx+VWLuT5Jb066nWfab/yp3YO+I9xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408250; x=1735013050;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdDfJzdR572+NgYBIK1DF+JqNSMWZnxXYoS29vlefiA=;
 b=U3w0Bx8vcgWaeMVT/c/N78WyJCI/qRZdIwHzvJUra9Cd0Wid11+VSzA+v144nV5qL2
 BEbQkQQlKZsCY4Dkyg/uDocClxp2h8UshxsQNGOcVO6aySt7TSIFRt554DPx2l13UoHz
 KzYVQRnAUm/unLWxHVOMLXL6UEcAeMh0/twX+L0TVHXGAvQaJu1Wxf0vieu5CCQhP6DN
 s9uZ8mI/v4XFI/2iYxoOmpuDk4RB5ORSX1fsGti1GAUt2SQWyy9jyOzEecj/wma2OCTV
 FUshplmPJQnAqXUYlFreS6NtgqcNg3CDuKBayH6UFj9v/f0D/6uZ4Ati/SlZDU4wpcud
 Ppcg==
X-Gm-Message-State: AOJu0YzJwUDDaonax2wHwIUgM5voSNyIEg4eKbmuU/savstGuFuVEj7B
 ISKevpt4n28YgIxmmeqoqxccUuaXBC6jrfm9WTP3eRY7Xk045pyhMG+ezSC5503Hlh0eANaYZVA
 VfDg=
X-Gm-Gg: ASbGncuJ2v2RiYCyWARI36D/8j5cnKPsqd8Lxz2s6YMuBWVOwSvVAHywXNsILDZcuGI
 SGoRmTZyuJcn7agKgHnqTGw/Sk+KYVGP02dTwy6IAxElvEergKGGcjnkvOAe3l5ySqKjXZGrVLt
 K1odWdmMdQ94JpDv5Mer1HpquV3I+3W5MPkewwVK+WSZb1XdQXoP5fy3BX8kWpC2nc9nML0QfVv
 2NH7ZGxOWJmgolDDgcve2i1Yb41uR1lzbHbsJwBMD+QSejUUyHkB1U=
X-Google-Smtp-Source: AGHT+IFmTXIUjNGDn8KbafqKZuGmDg+H7rR7g4yW0Sx6W7dO4f45BFE/H7WU/BBEwOZLG7zSCtTQYg==
X-Received: by 2002:a05:6214:f2d:b0:6d8:838f:8b54 with SMTP id
 6a1803df08f44-6dcf44e14camr40848916d6.39.1734408249861; 
 Mon, 16 Dec 2024 20:04:09 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241126232953.20860-1-yuriz@qrv-systems.net>
References: <20241126232953.20860-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: fix garbled printing of disassembled
 SET* instructions
Message-Id: <173440824810.3115242.4767148814895688785.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:08 -0600
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

On Wed, 27 Nov 2024 00:29:53 +0100, Yuri Zaporozhets wrote:

> When DEBUG_DECODE_F is enabled in bios_emulator, the printing of
> SET{O,NO,B,NB,Z,NZ,BE,NBE,S,NS,P,TP,L,NL,LE,NLE} instructions
> is not followed by newline and is, therefore, immediately followed
> by the printed address of a new instruction. This garbles the output
> and makes it very difficult to read.
> 
> This patch adds missing DECODE_PRINTF("\n") calls to print newlines.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


