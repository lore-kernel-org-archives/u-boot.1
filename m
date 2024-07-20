Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308BC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EFB88860;
	Sat, 20 Jul 2024 19:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lCa0IKqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03266888AE; Sat, 20 Jul 2024 19:10:22 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5E58887B
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-704473c0698so1303163a34.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495418; x=1722100218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3vr3eHdi73C8BTYlz+4EJmILvaxk+Cp2R0RkYcERIw=;
 b=lCa0IKqbNOLCrolbj15A0RUzogKZbSlR0rTZhuBZFoWwtzf4ubHtCAyYFIK0gWylqt
 6xCczzNl5isr4Yr1FUWCrzShR55BlZTW6hYacx+BMv3Oqjz+wN9fFf/eR2Hx3NGFQ8ws
 dbzejxkTAZc8RXjok8mM9FwUYFEcQUR6DE2t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495418; x=1722100218;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3vr3eHdi73C8BTYlz+4EJmILvaxk+Cp2R0RkYcERIw=;
 b=r1RwY3fe1B1lziyIlWduInGTFZwA+70VM5qCQvIzZnVrl3ZYgsIq7CMSzOqMOuE2pF
 cdDdYRJZ6S+NdmXcJFE3Jg43vsMs7FuDYQY4k3ldaJzG+8dZlpF6K/Jb2OT1zX85a5/A
 b2omXolg71BIDrI4pC6YtzxmsUr1qtmGeVwn0n+QdFLs+xZy40K5oByfvR3f5DqqyW38
 TdVKBdjXm1PqJlVmAJh92aeu0X/udM1Lv1Z3aGsEB/SB7HxX16LfGjLFKgEL4IJBKSyD
 LJSJdOm79Nc4iAP21xXvVCeELxvuRbPcCOEEgOHeWvuHV9Q4ZJF54sLE0CFWeCkmph82
 uDxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVER+aUyQJHk3We/bmwS21bvXsTKgC3tjDWeTM4eY903nZcIDqLDWcNPJ/pbqMo4qvPtwgYejkVjO0iu/lqLqrRism9KQ==
X-Gm-Message-State: AOJu0YwCFVh3eoOK+Xg+NXA57mbQOdvJp7pWg5Vnjn5btt/7793Af2pg
 rv2LGN5WJ5rxdztiLWdJP0ypbnQgSLXsQ+zKhfoDFIf0N7S8erny/G0bnosWScs=
X-Google-Smtp-Source: AGHT+IH42AJhNRGhlxz3pNwFHeiEJ1GmKIRKp4+FdhojY7YFoQpRlj2la8gAaOP4VkWMh1Ux+xGvww==
X-Received: by 2002:a05:6830:621a:b0:708:e969:e0d9 with SMTP id
 46e09a7af769-709009258edmr2132617a34.17.1721495418327; 
 Sat, 20 Jul 2024 10:10:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240716083534.19062-1-heinrich.schuchardt@canonical.com>
References: <20240716083534.19062-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
Message-Id: <172149541637.3268377.14612368110922999750.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:16 -0600
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

On Tue, 16 Jul 2024 10:35:34 +0200, Heinrich Schuchardt wrote:

> U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
> Here the QFW boot method is not needed.
> 
> At least for qemu-riscv64_smode_defconfig the kernel parameter is used
> to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
> no sense.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


