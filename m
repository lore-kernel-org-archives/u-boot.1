Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F8C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9CA88645;
	Mon, 10 Jun 2024 18:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h7Z2tJsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF16388651; Mon, 10 Jun 2024 18:51:08 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C719F885E7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d21f7cc6c0so1187062b6e.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038265; x=1718643065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmAc/ZZNOIwd1lQy64y3lgWrAGPFb6/Yis2C7GND2c4=;
 b=h7Z2tJsTZyT7noi5EpBaLXeaI5xVjYEcvRefExC8XsjCtjvzrXH1lSPBCfgrf2b07f
 xpeRCgYmGG/JFBidcJRod/NAkrIMlCkzpr0FALiHZwo/BneSNVoMD8C8f93ENNCp0tfT
 kX9E5SsJo3sonWQo/f8LTcwxxRI02s+epI9ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038265; x=1718643065;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmAc/ZZNOIwd1lQy64y3lgWrAGPFb6/Yis2C7GND2c4=;
 b=MNMZNZfdo6LxZW6RFr1vhapPbJ7fMEIwaDkppCUsHlKi4J+dP3z9JiN4mDsxpbGZQD
 aE/5CwIlmTPTdXn0n8XJeFsZaOWjex/HhJzddiGVktdl9WP5ds1wqKH6EqyxNjhLiw2j
 s+c8SbkUjgY4sK24rz1UG0K+loD8wkSg5yypt4HnRy40OSm3nry68kPMIFMyulrdfdTI
 RZ/7O6m2jiYcVPCYGqy0IikuisskO7Mb2c/I1P1IM5y0RU1rwZg4+MBjKC28PpVIdc+W
 K2RSPJAarBc1TYIPdbIyLa2qyLPMkK3mQNewnvHKsZo1FdZYCbrwX/pfeT7BLbyA2llx
 XHxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUofmMHwLts1pCHCOD1qSryvusNUVNNXEomPsEUcnxvaHe/RzeaW8U37az6mvW4jCBrXGS2ObznSD5UylgNU/Fl4rxo2w==
X-Gm-Message-State: AOJu0Yy1sSAm5bUY6s8DEiOtNl2YOlTlHhiRe8nHplfIqRcMnThbiY6Y
 lrIStO9xvXGybjAnWIjE1Ebmk0H5108XaCic1FKQmDrMg3QsrA0vSCOZhPFAVLdz9w4edA8ShIm
 o
X-Google-Smtp-Source: AGHT+IHRyyVMybwJecplhMNWfwXsbLIJz8nlymEUlKiCDBPKJppA4kF73U2mGGzCU1EDIoJjzBnE5A==
X-Received: by 2002:a05:6808:2126:b0:3d1:fc44:2116 with SMTP id
 5614622812f47-3d210da5bc0mr12619932b6e.35.1718038265382; 
 Mon, 10 Jun 2024 09:51:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, u-boot@lists.denx.de, 
 Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240515201330.28015-1-Maxim.Moskalets@kaspersky.com>
References: <20240515201330.28015-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] dm: use newly added linux/compat alloc functions
Message-Id: <171803826471.2405130.8264712247875897556.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:04 -0600
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

On Wed, 15 May 2024 23:13:30 +0300, Maxim Moskalets wrote:

> 


Applied to u-boot/next, thanks!

-- 
Tom


