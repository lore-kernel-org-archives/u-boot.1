Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E66CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B988584981;
	Thu,  4 Jun 2026 17:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xrx9/hUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4638497F; Thu,  4 Jun 2026 17:35:33 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E683D8484F
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-48611862583so367430b6e.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780587330; x=1781192130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bF2zrxLroxs2UY2mp3AEwQlAI0TmyW7FdWZSXspAh9Q=;
 b=Xrx9/hUcE1jIjo2Fl9i7mg/F46LHSgTByTw5sM8KpfM6nyodK+yzSxgYL50N4qrdXe
 7xzsVM2doCMYXhwS9XiZLsBHd1qsG7lTX6TkkPL46RYS5g+aglmduOe/MXNwXh/7wgdv
 Fk/aIMsuXPuROrhwim/6ndPwkw0Cnf4JCVigM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587330; x=1781192130;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bF2zrxLroxs2UY2mp3AEwQlAI0TmyW7FdWZSXspAh9Q=;
 b=b7VuAUJf7shlUsmNsQ6Z299g2LRo5k1x0LJ417ci9JlXqn9QMo1DJgEaHmgvkits99
 ueXyfnOmpQb/x4MbQqbVJz8ZkpYxjZ/dpySG1WBkt6E5TrXxD6g3o3Wdg1ZP280CLv+/
 6vFXC8ggLpJZC67OelYrGcNTiLsD7gAmEWgpC5iQOKbSehyKG95nd/vh7rejq/cKcn7T
 1K+esWmd5/Q0wFAtBNgdZloJ7SqN8O0Lf8cwjAUhl0baEP9egGL3g55T6kXfn4uOj8eb
 U4ooDBOCjDDm4ck2m/JBerXqZDflHQ0e3Ez0brY1Qf2UOrfUkuLL3vR0Ra2I90UqBzOG
 ACrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yLoobDUiDG8Po/8yj3xFiQEb31s5RadJgQZ16IwNRIXuDo9e3he8kA1aCgHxhWnPNCXJv9Vc=@lists.denx.de
X-Gm-Message-State: AOJu0YwWyL9oniir/+yEqFfqc1hZBhmcJ6JhhRGzvgGrS8hXTd+IJ/CP
 SIshVroBjl1gadHRL4dd+tcsrInim/ufMSScMvUrGTOJUManJpuYnjSJ0xdCFzSmt+vSvnAtLWR
 0eZcn0OM=
X-Gm-Gg: Acq92OHj247O8Ecf4mQUKEZqOoN9437535XZq/UkkfCZTPu6dZNdFnRywWjagEgPEqh
 IhgHJdjdxuiyrnyYHjw75JsDkbLcX7mCHDKUZk5pM2q7LKSnC8qaqGNSJ5SrU+Sz3zxUEgY6zPe
 YhGVUiBNIeUrmWz+kxOBJxDMteetnOa3m2VGycyCtUWch0v38U/hUsOXwe++RZnKolNBDRI8LLi
 n/i6w68dpr7r9abQvL9/u6i+h/4Pr8XER+l2LOkD8WpyswiHh1JgnUlKtwloq22LYoX949yBonp
 MI1O+5BbMZEs9AUPQbdhhyWAvs9ZWNYqKFBNqK3QD2bLW4S+O1uEsG2ndexsQliebKgeKdCFPky
 N2hWAC4jnXxyfJ3VxIYZ6QGQUF6PUpj2sAmrIavicOcemPSGJYqQrC1KjiN2kg3OCY5f4sj3lWo
 4vLXKxDDVh2J/meGOpeOMQ50gVyW/GQjoWHQ4l9MiDBWyXhTLnTy+/nTWY0rKJpfk19rjN52u4l
 eREgBmw0ZXV8iY1yPkF3IODFOC7Bp83qDS7irUZTQTAARJSHfJrKNzx93zN
X-Received: by 2002:a05:6808:4fd0:b0:486:2ff7:d63d with SMTP id
 5614622812f47-4865aa99d7dmr4612634b6e.16.1780587329622; 
 Thu, 04 Jun 2026 08:35:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e71fe69esm4272283a34.0.2026.06.04.08.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:35:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: tom.rini@konsulko.com, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9Oj2nfe5PLpjyCpOPr4vOrJTXCnRZgZFD39RinA69C-tQ@mail.gmail.com>
References: <CALeDE9Oj2nfe5PLpjyCpOPr4vOrJTXCnRZgZFD39RinA69C-tQ@mail.gmail.com>
Subject: Re: Pull request: rpi-2026.07 rc4
Message-Id: <178058732882.2488090.4263924805627886894.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 09:35:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Thu, 4 Jun 2026 10:59:25 +0100, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
> 
> Updates for RPi for 2026.07-rc4:
> 
> - pci: bcmstb: Support for bcm271
> 
> The following changes since commit:
> 76d62273bc8a5dc126ed79ed0fb65e5a97359577
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


