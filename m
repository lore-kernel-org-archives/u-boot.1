Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41068C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 21:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2639F833C0;
	Tue,  8 Apr 2025 23:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IWi3FRFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7881882F7C; Tue,  8 Apr 2025 23:07:38 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C42833C0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 23:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-603fd257386so1384059eaf.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744146455; x=1744751255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RaKEFVZam/OiFfKG667AjntkOrlBIngbRkhW0T+raUE=;
 b=IWi3FRFDzjjLi2eYCMazc/oTwyhS9enHdA24C8683YeXuGfZWqexNUWoXEbQ13R1SO
 /UL7qy33xZa8F+Xz41n3M7eweZKQlMF4bHGsQ99+ZFODKQTNAnRbAAoWhXh82R9gKTVn
 bylZSDMUDCS1gWLVAbcddCTCWhndoDQrhrozo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744146455; x=1744751255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaKEFVZam/OiFfKG667AjntkOrlBIngbRkhW0T+raUE=;
 b=CoP85cxwlfTW+1LCTpq2Re1dRVC1wviagIlTiQuBKBxx9N72W9HASE+XRj2SQVX27e
 zYj6t5z35MNq3yQy5Yc344qz7NDvTwGhUra8N8XZrcHITyQdnHLgZaCNP06zZUPy2Rqg
 HjxRGIA4UHz50twtolWijdat/lN+nwLccduuim1XJ2ceswRMbwiZjccka6GA1nuwkcNP
 LYIAOVY4YT7bnBEn2aSc6rrowSG6tKj1YCZf7p9dPLqngu5cv6F1GN9UO35Gk5PK/A9F
 TX4cgAFjMZTUy7TJGlU43iz7fyETAiGiuK3w/oKTV2wUvrUd2HES2x1IYSblgWLwwUUx
 cR9A==
X-Gm-Message-State: AOJu0YwQYwiwsI3QN0H0MRbYOZhh9v8oL35VohrsGBZp/qCoWzsC/+6K
 dMce7pfH8qp0RuyOEnRBOB5t0ncyJ8THFGNvVKgDGyHmEHEVUZxBA/KGk/96/5s3HXDd94PaMVr
 b
X-Gm-Gg: ASbGncsmKoC+QjZ2A14YPVvGejh39qSR9K3HaAw78+FjK8G2QfqhYItT5q+PfwfaWQK
 6qSSJ0Lpf0QhTKCTj1rCM9cF+6nbU3gMQOMu2BerZswSciknGdbewYBbB0N45/AadzbcGl9K5SZ
 tPCWx/5z+U2yChzLbjaXesNE+IDw4P9sHRzDYEvSul1MEGIS0X3Nwi6OKk55AB5CyaRWZqxEvf1
 XeBZf0N7BWYOT4mdTZ++j/V4l8GdpYt+1bt+xdjHO+LfAWTD7efFvDwPDN+vptXM/K86BcN2jtM
 NUpoU/3MjAojvIjS4l1AE4onJYKJXg0NAhCh7BfTx9D/c9rV4ZD3BgGC5wrvixWT/4r6izm+CKF
 0Qpt7
X-Google-Smtp-Source: AGHT+IEk2aGHcbwvxC6Wjg+uNmby2x9daFa6wwPYJRz2RnlccynXgURO6TqKbjNcBE6ezgkcYOPhFQ==
X-Received: by 2002:a05:6871:a987:b0:297:2376:9b17 with SMTP id
 586e51a60fabf-2d0917e5355mr31089fac.19.1744146454766; 
 Tue, 08 Apr 2025 14:07:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845ca326sm2736321fac.15.2025.04.08.14.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 14:07:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
Subject: Re: [PATCH v2 00/10] Improve pytest runtime
Message-Id: <174414645402.1438641.14845245817289600818.b4-ty@konsulko.com>
Date: Tue, 08 Apr 2025 15:07:34 -0600
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

On Thu, 20 Mar 2025 07:59:21 -0600, Tom Rini wrote:

> Hey all,
> 
> One thing that Simon Glass has noted is that our pytest run time keeps
> getting longer. Looking at:
> https://source.denx.de/u-boot/u-boot/-/pipelines/25011/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
> we can see that some of the longest running tests are a little puzzling.
> It turns out that we have two ways of making filesystem images without
> requiring root access and one of them is significantly slower than the
> other. This series changes us from using virt-make-fs to only using the
> mk_fs helper that currently resides in test_ut.py which uses standard
> userspace tools. The final result can be seen at:
> https://source.denx.de/u-boot/u-boot/-/pipelines/25015/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
> and the tests changed here now run much quicker.
> 
> [...]

Applied to u-boot/master, thanks!

[01/10] test/py: Rework test_cat to not use virt-make-fs
        commit: 47ceaf8816aa1eb1d8a924b3d31c93a852de029d
[02/10] test/py: Rework test_xxd to not use virt-make-fs
        commit: f98d2a31271dd3357e4f13a77b62cd383bd3f09d
[03/10] test/py/tests: Move "setup_image" from test_ut.py to fs_helper.py
        commit: fce92e304fcd8bdba522a43aeef12cc3b0b2df56
[04/10] test/py: Fix a problem with setup_image
        commit: 2c092875abfd9269a34b3cc03930066fda53a476
[05/10] test/py: Rework test_efi_bootmgr to not use virt-make-fs
        commit: 4b33810511445dfd5466223f8fad2961b0732abe
[06/10] test/py: Rework test_eficonfig to not use virt-make-fs
        commit: 397fc80b9fc2c6831beaaf92d66d725ca33837e6
[07/10] test/py: Rework test_efi_capsule to not use virt-make-fs
        commit: 27cca9e5d3a09d234db1a289cc1d19aec71b6910
[08/10] test/py: Rework test_efi_secboot to not use virt-make-fs
        commit: 7bf75f3e36d0907e83c84ed252c8f24b1659985c
[09/10] doc/develop/py_testing.rst: Update section on filesystem images
        commit: 6df302c17881d47abaceefb9a13c5723c15110c3
[10/10] Dockerfile: Update to drop virt-make-fs packages
        commit: eb1b90ec57a43ff4799d9626a1481acd01a4adb4
-- 
Tom


