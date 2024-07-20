Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB77C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABF28888E;
	Sat, 20 Jul 2024 19:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oHx45LJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4223788872; Sat, 20 Jul 2024 19:10:23 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13DA688892
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-706dea920f3so1376970a34.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495420; x=1722100220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5mE6+8CxDDVy4Blu3o17H0/Ys/UnbiHa8HYjinBQ3c=;
 b=oHx45LJgTF8FZGhyIdhcwk/pjNLktyzIgGJRrXPSOI2aY/AE38j5EwLIA8nDxYhdm5
 LOxN90JLaKk3qnCg/Zg0Ndxa6j0zxyCgp+OpuoCvEbmVS49d0oJ+BHAdloiginEUlFHk
 sAPDp883rCRvJ28AmXjvhjNyy311EqL5q10NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495420; x=1722100220;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5mE6+8CxDDVy4Blu3o17H0/Ys/UnbiHa8HYjinBQ3c=;
 b=GwyS5Osu3PAbFQjOgf4rLT90P1uHQ5kG4//VrRc0orYvjyJA2sBhGPvStuL3uR011J
 0RzXnzGvleFj+29te5NozOw2Ihjb+EJlPdwOsXURlpk74CPZrmH2HcLWE0Uhkm+6F8ui
 NT5rRIYi6ulBOD4R7SKNQbHtFUgjY6TQQOvL1mSuNYvOLhmcJy/mQy7nnzsPv5zzmyQu
 5Xz7V6MNNonvMqx6qoHpfYQ+HGyjnc9MjB0j8H8ono64Ij8yIwQldShjPO3zaB6KKwvK
 Ya6KS6Z2gXC37BvKZ0biLU5uvEh7BUM7aIXTyGgWZmYiQMvnQH8FaAThKiLa7ZTSJBjY
 xClg==
X-Gm-Message-State: AOJu0YwN1kgSMpQl/rewoMcCBkJEJmNmj4GVJivYsIKizUZmL8yQ6/rb
 xP/2F4qt302jKfzZ2z4Ocn21Eij2Vn2z8isybiAwWGrynAl8GeNzv4ko96zIXuM=
X-Google-Smtp-Source: AGHT+IHuEZeMHlKTG7IdRkAS0eq26fwdVWMH+INiKlf2CRCGiwBkTeT7E23+mkND61UvnlpNLymfvg==
X-Received: by 2002:a05:6830:348e:b0:703:5ac2:994 with SMTP id
 46e09a7af769-708ea089248mr4845691a34.6.1721495419812; 
 Sat, 20 Jul 2024 10:10:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240716143546.647604-1-trini@konsulko.com>
References: <20240716143546.647604-1-trini@konsulko.com>
Subject: Re: [v2] zlib: Fix big performance regression
Message-Id: <172149541845.3268377.11976244994160308402.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:18 -0600
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

On Tue, 16 Jul 2024 08:35:46 -0600, Tom Rini wrote:

> Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> brings a big performance regression in inflate_fast(), which leads
> to watchdog timer reset on powerpc 8xx.
> 
> It looks like that commit does more than what it describe, it
> especially removed an important optimisation that was doing copies
> using halfwords instead of bytes. That unexpected change multiplied
> by almost 4 the time spent in inflate_fast() and increased by 40%
> the overall time needed to uncompress linux kernel image.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


