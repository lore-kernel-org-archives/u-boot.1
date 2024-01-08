Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD12C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E9087A18;
	Mon,  8 Jan 2024 15:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="aOKz43wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7CC87A65; Mon,  8 Jan 2024 15:24:40 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8802086C72
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-557e76e1bd6so98305a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1704723878; x=1705328678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuM2M/najQM/aiJDosPa0QQ9of4V8+lNsQRjFlE/ads=;
 b=aOKz43wuS306QK336H1h3mMts/N/2V/p9fkn0tbBwkGTfOteHhT39wafXN2zSqrgXC
 loHTWtGBMLxLFd6x4URH2/nQAT+hWsYM0835xqRBE92gyb60jojsb+M5K7ArPKRdJc5U
 FnBFjj/I/gQN3rgkJ8ucHatPPhxdn7tTrY5bRtmaOI3lN2yaxs7OPyTJrWayFVpuefm0
 rJbb4uQW50ZMorIu7k+o2lptfIAYiOYdX8G6ZzJ0XtUKOQO/yGU4JdaUG2CbA7hRCdGo
 NOt1rKfrs1P/DOY5eRz13YSKs53HMPtw/GPTPMWuHAW8ISY2GxEshaEbuYhGBr83XPLY
 Rhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704723878; x=1705328678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuM2M/najQM/aiJDosPa0QQ9of4V8+lNsQRjFlE/ads=;
 b=Y1KaUcaqZ7TqEEcjAy8chBu5PqdILnYHloUP89sATtzA+5gHBHqEewrJ0k77y+khnK
 bgLXu2Np2FAOMVAAFOOk+AFCKT0bVDiD3DOShSOGRBqWFmL0D1d8gL9S5BeqxFlQtqlb
 SxPdKBzBiNtc4Z5yt6FP5ggGaXTdeZYULDRqbnDmFkewdQ1C6lXNLf+0QBb25LhHn9Nz
 Svex4bNbVlKUd+xxJ7grsllPvpTviBp3YBsJdbqfEAw8kU0wQ/9EWyGA4RzACx4uHGUm
 0/VwAJLI7mLD77VvWXkFH3dSYpcTRCynBctkFerhaBzWy86pE/t2DMTWViIxwjXpdbv7
 riKQ==
X-Gm-Message-State: AOJu0YyJoa8oV3z4HE6znV2vO8uAqooKfeubGWgknuUZ+8cjFU2GIMMS
 IQJBgvL3fjoLL3ey0SIY0fkuvAdidPednnB6H7x9Eo4/96A=
X-Google-Smtp-Source: AGHT+IH6Eh3DNCz9ezMNAGuoID/zxshQL6KDIZP4I87LgLnIhtFX6XZ2c/PWitcaP6SEr8CAGoTXAg==
X-Received: by 2002:aa7:d6da:0:b0:556:a28e:7cc1 with SMTP id
 x26-20020aa7d6da000000b00556a28e7cc1mr1955914edr.81.1704723877863; 
 Mon, 08 Jan 2024 06:24:37 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.. (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185]) by smtp.gmail.com with ESMTPSA id
 u15-20020aa7d54f000000b0055678085e27sm4298471edr.20.2024.01.08.06.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 06:24:37 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>
Subject: Re: [PATCH 1/2] image-host: add a check of the return value of
 snprintf.
Date: Mon,  8 Jan 2024 15:24:29 +0100
Message-Id: <20240108142430.301659-1-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTgUwDUWSRwJZ0Jk8Bw6UUXDt72vnaj4rB72bLFoo3Lozw@mail.gmail.com>
References: <CAFLszTgUwDUWSRwJZ0Jk8Bw6UUXDt72vnaj4rB72bLFoo3Lozw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon, thanks for the feedback.

Yes, you were right.  I have split the function into two functions.
The patched is attached below (inline).

Some of the calls can be further 'logically' reordered, I believe, but
I don't know the program flow well enough to be sure.

One other 'inconsistency' is the occurence of a lookup based on the
string literal "iv-name-hint" while a few lines further in the source
code a lookup is performed based on a pre-processor define rather than
a string literal.  I have no clue about the reason of this difference.

Further comments are welcome.

Thanks, Hugo

