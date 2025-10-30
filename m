Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEEACCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4BD83642;
	Thu, 30 Oct 2025 17:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2NR+5zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F22C836D1; Thu, 30 Oct 2025 17:35:49 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF538334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-378e8d10494so12341711fa.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761842146; x=1762446946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RY5LTGBk6ogjS5N7qgEe+Eq96zHtjQipbMyaUYL17xo=;
 b=d2NR+5zhj4xqg01xk8r+4OiVvFdXWo/NQ88sZc5E8Jf6PSf4Qz98+PlGS7Lxvu7C1a
 y4SzgTJpDJ+PWQ4KZJ22GEO6vWJ4DRwVyV7DMkXnP+KeM4g62BCUB6DN154m8r30x9XC
 mTOL2FS/reGZX5YsIWkyX3E2NnDghgF0zYEdJFTzTMgrmZvmEgcCXea4TOwyFLk1SkCa
 hcaB33YPOHfYxzk5wE6FxiuHzc6UMUR4wVECyiYjH9nYSu5duQTej659/UlFdwXrjJJe
 ffu+m8ZqunHpb38Ygkl3ZQ+JPcXKwSpArPnMX/qs1Au8895C9t/t8lQxbC9xXGHuQVgQ
 PbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842146; x=1762446946;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RY5LTGBk6ogjS5N7qgEe+Eq96zHtjQipbMyaUYL17xo=;
 b=r1bODWzX44tSZXJI28blUEKqE2r2DpEY85oa0J/bxbs8PvPri2L39nqWbf7tmwkayB
 ZqwJotscamMoWJmi/C0PrlERcAWgl84Si2nvXvFcTgXPi+ygpr7+s7gAxTGSdJFNfc4X
 cgkjCmlL6wmiC2x0kjCaYtoSIEWEn//nMjA8QuFq/3K8sJ4I5ZKrZjOte1M5pUKMIpt8
 XXSL3ClzinH7Z4CfTz1fKUagzXuTzErPjJJj2AluxUD6eOfLX8eao9EJCFguKYsVq6fs
 992NUguXx009To7N1t2Bg+mv2+ClswO2su+gGzjwc/44r0lp6V56L2kCV1RSaBeh1N+A
 q6TA==
X-Gm-Message-State: AOJu0Yyk1tlimwa34OLSb6KtK1nDBX/MYX0ec8UE/+0UiKR+X1K5gT7+
 XMKofXF/B+ldJElb1Rh3WPM25u23fRxulWqvQTdmfjpM+M8gZYo2XDD1JtI4SZQDsfYUhs39E3F
 J0H0VzmTmZLXEA13exkxULKakO7P4I5Q=
X-Gm-Gg: ASbGnctyfm62NRmDq95gO1wHnlFnAy1G+HzyFcxQvSAnSh416i/FtFsNKZPnKGCHYxP
 Z9Ad6ftK5+EmkYEO8YxQj/oVIWMZXKgWX+LUDcxwv5YPuErxv9cQfSGUmSDxiNZIN+KsjGV1/tG
 lUm2jL8SFEQFpe+rqqiveh3gb45+x95BmHL8Ui2JccC/KxSu5HSCYJmqPY6Qy6BQLqtx9xGoDsZ
 XFWFh47ve7ipQ9YdQ2CFkUDbMjgE36gXnfv1ym1/tgmrzVgGGXjYeQRE7xYFBbAmOWaCUKmag==
X-Google-Smtp-Source: AGHT+IHmi+DcvGkA9O6w7VYDWEtsMYWZqRTa1knNi8i3d0hdEQBJxbvQbMcNxrrLAFWfBHr1wdoTbc/pNOKIi0H4R+s=
X-Received: by 2002:a2e:9a0c:0:b0:378:f07e:7fc3 with SMTP id
 38308e7fff4ca-37a18e1398emr1520881fa.34.1761842145995; Thu, 30 Oct 2025
 09:35:45 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 13:35:33 -0300
X-Gm-Features: AWmQ_bm8CpmXIGHHFuE7y1ERBWWtz9FOSnSgX26-z1-lzYDOoyESZVLOMhWiURc
Message-ID: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
Subject: vexpress_fvp test.py CI errors
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

I'm getting the following vexpress_fvp test.py CI error, which seems
unrelated to the master-next tree I'm building:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/commits/master-next?ref_type=heads

Please take a look.

Regards,

Fabio Estevam
