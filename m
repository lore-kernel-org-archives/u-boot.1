Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D13C021AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B2580F7D;
	Wed, 19 Feb 2025 03:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kuVpN8k1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D7B80F53; Wed, 19 Feb 2025 03:04:57 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81BC80F68
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so127327665ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930693; x=1740535493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81eymKinqvC5vWWBSXSeTOQiBPrGFGmTwXNJdZSSx/k=;
 b=kuVpN8k1wqBon31dc8mrRyu3rEY55Fiyh8b1LV5j/U2bCtRWT9gBsw19XfF06+oQxZ
 xGoHQiODs8cYjp4Smsm5w8Xj1uFkCODJxPfDn5U0haySrifiFBk7ZRvMrIlYihAATYMW
 oPiBTE7O30+zn1+chfKSmpU9m1Fq8lYBKEDHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930693; x=1740535493;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81eymKinqvC5vWWBSXSeTOQiBPrGFGmTwXNJdZSSx/k=;
 b=kEX1KPFfyrWfaZyT0nmNA3gqyLtjoRJ6gESPBYxPr9Nkv818Rq/3fyJgJ47qN6CJg/
 Jr+ro9YCOmHl06Xc1uXSqB2iiqPTx1OZXB+uTYGNbHgX8HMMD4REGPayxxIg8CFIFYSZ
 8pm/PRYEa/6AIulYzXq07uEtEAJQGUawJJx/LxwNHZRyrXM6mzULVyxwkg7vVgLCnIvW
 PFCGJwGFC75XNtL0VrcZx14MynQjjNDTRUR+HTAC5NeLJGonkOMHXEmFZlXEZ7A42zvm
 niVn7z/kzb5AWT2GUnGpJ8eRniGpjZsvZqNTaaL03sPA/+U5JDhhY4M9/49WE4PEUY8a
 NayA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhrvKNAmXYTDRXkTKK+Fyl/TucvlgX8djn9L4nSE2uJzkUpMhPRXEAr5uV2C3pTGAzXne2QHE=@lists.denx.de
X-Gm-Message-State: AOJu0YwtVX2DFBuxY+dFy5OzyAn4pMy99L+O8WfF3kxf9WzkhrbqzclX
 cmeCg7nPYcfvOzz7Yw+OQHJPSWVTuLjGCKHGZ6Pe5u2STt3Aj7vEjY/Iw5sAjq4=
X-Gm-Gg: ASbGnctcRHZBO2oLzZStt9x6x27RjABZDxs9s4tT6Q1Mke7r4F8D9zLQrOShs74wBB7
 dc5fxVkW6t7qDhFfNuAMcFI5rPbvLwn0QUBJxW41ShtyylSruWGWVH7g6lCqHSBKCkt7Wzt5vC8
 tpdafCF6y6khqfRifqlGYzxMJO5192pqO+6DU6QLKzeEmZqjl97HopCqaAtcT4rJAPFy2MqXIMX
 a83mDNhCReOpiuwD/5OUuAVmVBXeE7knkZu43LhUkeZeJUXu251xIxo/qWJxCyTFkeqRzbkDrLy
 MDQ3sy+1bjYC
X-Google-Smtp-Source: AGHT+IFi0DwvJd46Q+KIEZ7w7z2ulJbqbvjMNW/sxcXT0I3CI5srpITONgU/Jliv9EB0+sH2ygxajA==
X-Received: by 2002:a05:6a21:6186:b0:1ee:7f20:e456 with SMTP id
 adf61e73a8af0-1ee8cb0e8admr31924237637.8.1739930693275; 
 Tue, 18 Feb 2025 18:04:53 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20250211210600.277504-1-francesco@dolcini.it>
References: <20250211210600.277504-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] gpio: pca953x: support pcal6408 and pcal6416
Message-Id: <173993069225.1662848.5984705485333034250.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:52 -0600
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

On Tue, 11 Feb 2025 22:06:00 +0100, Francesco Dolcini wrote:

> Add support to NXP GPIO expanders pcal6408, documented at [1], and
> pcal6416, documented at [2].
> 
> [1] https://www.nxp.com/docs/en/data-sheet/PCAL6408A.pdf
> [2] https://www.nxp.com/docs/en/data-sheet/PCAL6416A.pdf
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


