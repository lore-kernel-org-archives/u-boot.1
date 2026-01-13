Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC9FD2F33D
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F4C80B98;
	Tue, 13 Jan 2026 17:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XW3t4wiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FFA803F5; Tue, 13 Jan 2026 17:13:25 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B984880433
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65d132240acso4721680eaf.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768320801; x=1768925601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rV+30G+m+QGZJiE8qL5xyzjpid/BZx09Db4YB8er4VI=;
 b=XW3t4wiL9bx1jhfS7kXeS9UBdpj5ZNlnNtGf9IagZGo0PRloQ5kPL81Iu571lERRck
 vhkw0KyyVGc/5cS/MPhCvdRkBhCU3eMlUIT6yPW7+PVVn+30dwA1SoGjrJplmJHFjbhb
 X7P0CAuIorQ8xzpmj7JMVX+2kuIznQ4JDlXfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320801; x=1768925601;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rV+30G+m+QGZJiE8qL5xyzjpid/BZx09Db4YB8er4VI=;
 b=fLGc2TGJy9yWniCuw7ovpAINuzxKx0xU21ML459Xt6hC6cPnHjsnPXnYdSKaZ5TMok
 tWm5uZw4xLdPNP8isAZECypw4AYmU+gPD1MnaNDb7rrU5KRC0DhlEPwgIqPynx5Mce5f
 5neu2ka8JYrxhSf9sQyYKr4Atk2ULWpGt8zXsouHC/6yLkP4uXf4daZ9yo7jeZtMiQNf
 nui8hV1WPu1X6IfpeLFIhTIR2K5F+WWRp+eshiaQn8hDJPfiGN/1dEIqr3UCCvLiGXRS
 U6vA5ZIQDFUn7kPmfCYMxTIiOhP6VS8Lgb9RooVS7cJfMGIMASHkI/vQhbHFjCefqt7C
 JEzg==
X-Gm-Message-State: AOJu0YxeFTbITS3wBzd1tXvNCPjoftYbUQ/xNfRVgtr+EvJrvHPGD2sH
 id6F4l8q4yxQUlNudfaAvZR/KHw8Aq1cphvGRsrZnZ74Nh/nL+OfN27r/5V2aDUzzoANo9abalq
 g0TC2Oas=
X-Gm-Gg: AY/fxX5ZyKv2mXNMGlc/LzbErm9kK5uu2p3Dbf0HslyjGfXnX8JcyLCBc/jI83PRWD7
 y/ysSCmKGo3+X+UzekMrT7YmrVghDyFatiWcaDFlLViodI4x1SRsi/pZybO9zvoYRtzRJhaTStG
 PNR5mk5GO/FUIcfOlyBxFje1JfOKe9J79G055z+LeKs5pUnQ/1oVrwve0bgHYGZb491AsDoqa/w
 OD23UbFLPLLCz/WsuNe+vEv9TBsIEOG21BsV5JFey4D69yW71A9ALGmcK0xq9TZnHju7vHxJGle
 MFYpN0bNDFi6I4uL465fCSf//e+ijq9ZouxMbk0IA3xG0K3prFWgJiD0GVqwwTvrW8NfyhAbNou
 k1r/dWeWGj3/KbyHfF7bWEhSkQOWdhwgU05IP9Ei9r47JRBoX4UtQRanxFQsmaO7D6UIEFTsiMi
 IEJkZnN0mvGOdHqkrNFzekDsU8ayvFoHQbEKwKvW8ubX2sSnSIe6s+PqEOuQSf+zJay4ZDUiFxF
 k+b7V9V8wS2CSHqfZmdJe9JsyWaFo3UYc7i+w==
X-Google-Smtp-Source: AGHT+IFktfAw7XZ4fKJR0iq/2DxGb+eLvCleRm1qzIfoS/EkC3C4aCJ9gBbtNmWjSbx/ynVC1yUyrw==
X-Received: by 2002:a4a:c311:0:b0:65d:1e7:9527 with SMTP id
 006d021491bc7-65f54f52631mr8528717eaf.51.1768320801365; 
 Tue, 13 Jan 2026 08:13:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm8575162eaf.16.2026.01.13.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:13:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20260101-immap-size-v2-1-31f15acea735@posteo.net>
References: <20260101-immap-size-v2-1-31f15acea735@posteo.net>
Subject: Re: [PATCH v2] powerpc: mpc83xx: Check the size of peripheral structs
Message-Id: <176832080050.2039494.16292650485288619048.b4-ty@konsulko.com>
Date: Tue, 13 Jan 2026 10:13:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Thu, 01 Jan 2026 17:41:55 +0100, J. Neuschäfer wrote:

> Peripheral registers on MPC83xx-series chips are declared in
> immap_83xx.h as a set of structs that ultimately fill the entire MMIO
> space of 1 MiB. This patch introduces a compile-time check of the size
> of each peripheral struct. The purpose of these checks is two-fold:
> 
> 1. To quickly tell readers of the code the total size of each struct
> 2. To verify that the size does not change when a struct is edited
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] powerpc: mpc83xx: Check the size of peripheral structs
      commit: 0b97991fa0e706ca4d9ba274ba9d06f43e4ee9ad
-- 
Tom


