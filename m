Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD32CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94ED836D1;
	Tue,  4 Nov 2025 17:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SoBbnmco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B6F835B3; Tue,  4 Nov 2025 17:39:49 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89536835B3
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-654ecc2af8eso1541520eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762274386; x=1762879186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3x/DNI6clNyPpWisw0ga7dLQKYXkO9PbM/QSPlUlnPU=;
 b=SoBbnmco3MXxp7r476xtNN9MD6SfbvTo03gUscgE+HVSiGr/ayqjd4aWHMRNFd344p
 PZfV4WlTWiX/KIk0G6DR5o0sA4kNDg3mf6iDkaCzacd43bYZYhkZzTV/WZjgCntAJxpZ
 PKs7cFe+zewG48mnFmBAm1tjf5tKvg/sA6An4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274386; x=1762879186;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3x/DNI6clNyPpWisw0ga7dLQKYXkO9PbM/QSPlUlnPU=;
 b=kbgfkKM3LVWHHsbeiOBsc3s04tu388T4CB/y1OkS2R8GCdkzJMSRZEvRCH581agwk+
 fuNX0vEZkzy6TuRJHxLKKrwCopx/9qP1aC7q+EIPRy2iEVedkD7xt1V42SVs85TpDcao
 6Kdxjg8APRCr1t4TIyYq6AxGT0wKG0pwrkg/6PgEeRbDfQyFBvR1dbVKKazlE34Bt0YZ
 3zjQvAnhiW+zWOjT8xVo02QXiTs3kRJiJMn5Ae6Fl1uszFH+NALGW3swAVKU5Xlb8VSA
 ovcc+XOziiwB/So28RDZJCrS8qjnkUDlgJxVt2BDubNCYjxlVr3vcMyV+QQ7DI7uR1m7
 nVrw==
X-Gm-Message-State: AOJu0Yx4djfqnj6aY56PLDAxNXmQdYuAFN0uG5HYzDSJ4sbz3C48DDrb
 d+ywU4ADjHn0KobzdA08MwKz6NAQtNbEccchgik+cNw962N+LPM83LSDkWw+8uXqPFQ=
X-Gm-Gg: ASbGncsKlnaKamizg+BGi21NUl7reeNO69a3nG0cumKffygom9qq/gjdVf3qyebnFJN
 FwxkK37ENIGo/Oq753ndmeAR3CY7FhZdR3ziTlWQnbADhYN51cQdaO1rUS5kjsMpOK7iYPfZDc4
 7wzBSy+NQd3N8Lf6C+ndmG1ZlX9n8pJ0o0sbpiS6eCtXsTxL0wgtHCL6vzVUm1racVQZtNvSsmF
 zurYdqBoZ72pbNuhgC0Ki5eekyjOIpzRQFVuq1kntRHiERoyoQlWe97Lo6ac4oWDmU21dap/Ngd
 HjUrXQ9C2U78Qcw6IX0GcT6tQq46msvTbb2OpP+gHH/+1lyGB0mhyWnNJCOc5ze8X8+tdqnsjzc
 lPoWYWmdyNPb6oWXf6BDhbZ7nVuG9vYgZecHpfQiPPMAJeBNnbQyWGLvYPHPpJyc3t9jGrvGSiV
 HYJMabTtbcWLlT3jcj0DuMv82cHdTDlxL0rYJvqQ==
X-Google-Smtp-Source: AGHT+IF9pu3gXg9T94/jMmNP+XZZb3F+xS4kAKCGDP58GrcTP2NnOVQG0Y7mkX8ym9F8rbyLxa6P+w==
X-Received: by 2002:a05:6808:ec5:b0:44d:ba18:2d26 with SMTP id
 5614622812f47-44fed30abeemr15124b6e.43.1762274386290; 
 Tue, 04 Nov 2025 08:39:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad43a2b4sm936601eaf.18.2025.11.04.08.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:39:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
In-Reply-To: <20251104133611.11009-1-marek.vasut+usb@mailbox.org>
References: <20251104133611.11009-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176227438454.3616625.6638754809353909191.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 10:39:44 -0600
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

On Tue, 04 Nov 2025 14:35:58 +0100, Marek Vasut wrote:

> The following changes since commit c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5:
> 
>   Merge patch series "Allow falcon boot from A-core SPL on K3 devices" (2025-11-03 13:18:26 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


