Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D9EC35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 00:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33B78701D;
	Tue, 19 Dec 2023 01:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OqQ5nJMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B4087495; Tue, 19 Dec 2023 01:39:34 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6F486FD8
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so3878885ad.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702946371; x=1703551171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNa3LKAe0nXsw3TL923bEv9Ciogj9g/m4ylBhVwzevo=;
 b=OqQ5nJMo4c88HRZE/h1aNVSuYgKgF0vkjws7zfhyZ+XMMU3raX6yBpZumFTSBf4Ypu
 tFJNNoIKECWmJS3BQoHiDj0veILk1OXbYGuDXEAYO1GYA+1YK5mpGUVHgtq5bApSYbOr
 javoOx9CQmTa9cAmetWzyNTW9B1+vhpNmfKz9e3Aloq4xFvcV/xryZ4URCA2522FSP+i
 f8MhGrjdHA0wMg6y5RBOp8e7nL+I+5Z4Oj2y6S+36OPXviA5dGunl6F/sQl0SZ+s7uEP
 JvBHiteuIB2K4eXRqURtBUQ+zMpnmIJcgW26P+5PS2ITjd5OjxkRs6xKOof/g+G1qDR6
 m2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702946371; x=1703551171;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNa3LKAe0nXsw3TL923bEv9Ciogj9g/m4ylBhVwzevo=;
 b=OrwoiTW9JqDNl2LVXFWJxAq7TdEEA2QmNHvpB7Rv813pSwnbULHs7k+oisdDl4RgLz
 8fsXXFqOgSfJSAHQxBhZHA5GF/IXtO/1c67g/jOtvE3uNPITfkj7zRuTlxI9nqUBTULE
 arFNeaGB4PmKgZpzfKhcYxasRPYZHXc2W5eUhCKBIgHa91L3DWb1yYOtzq9hrOoSWw7J
 SQzzhRLoQBAC0vCsYZOMQF2bU+Vjysu6+LfYrtVzeAT3d/crXBxLOQ/AzVjIsQWUaAUG
 n1rQjYnf9xgsyuzxih5iITcG7xIZkz6bxaH6g6sOBbAlhSCMBfTueidjpZ+vZ2+GErIK
 8lPg==
X-Gm-Message-State: AOJu0Yx+JxpRdMJu2KYXLt+m7JfjxCgLpjl7gI/BDX8G7DUZKyY828Oh
 wsDsfHixDAqsPdkepm+j6Lo4Tw==
X-Google-Smtp-Source: AGHT+IFYpjWVRc9BD9yqTfGah0BOpAZWxtyLhxzhUGGQYkY7PH/GhybTaTvBCBHZNh43yOJrCWG8wQ==
X-Received: by 2002:a17:902:d48b:b0:1d0:73ca:660 with SMTP id
 c11-20020a170902d48b00b001d073ca0660mr34900612plg.4.1702946370688; 
 Mon, 18 Dec 2023 16:39:30 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:3aac:5efb:223c:7d9c])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902fe8300b001d3b7c5776asm2753278plm.160.2023.12.18.16.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 16:39:30 -0800 (PST)
Date: Tue, 19 Dec 2023 09:39:27 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/4] efi_loader: split unrelated code from efi_bootmgr.c
Message-ID: <ZYDmP6KyENmx7VVg@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-2-takahiro.akashi@linaro.org>
 <CAPnjgZ3SyOqUWYJSRH878Z=J=_ez6pO59AneZ8P-FOo4sjc_OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3SyOqUWYJSRH878Z=J=_ez6pO59AneZ8P-FOo4sjc_OA@mail.gmail.com>
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

On Mon, Dec 18, 2023 at 08:01:51AM -0700, Simon Glass wrote:
> Hi AKASHI,
> 
> On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Some code moved from cmd/bootefi.c is actually necessary only for "bootefi
> > <addr>" command (starting an image manually loaded by a user using U-Boot
> > load commands or other methods (like JTAG debugger).
> >
> > The code will never been opted out as unused code by a compiler which
> > doesn't know how EFI boot manager is implemented. So introduce a new
> > configuration, CONFIG_EFI_BINARY_EXEC, to enforce theem opted out
> > explicitly.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  boot/Kconfig                     |   4 +-
> >  cmd/Kconfig                      |   6 +-
> >  include/efi_loader.h             |  28 +-
> >  lib/efi_loader/Kconfig           |   9 +
> >  lib/efi_loader/efi_bootmgr.c     | 493 ------------------------------
> >  lib/efi_loader/efi_device_path.c |   3 +-
> >  lib/efi_loader/efi_helper.c      | 499 ++++++++++++++++++++++++++++++-
> >  7 files changed, 529 insertions(+), 513 deletions(-)
> 
> 'helper' seems a bit vague to me. How about efi_boot.c ?

Although I hesitated to add one more new file as we already have
efi_boottime.c and efi_bootmgr.c, then efi_boot.c?, okay I will do that.

-Takahiro Akashi


> REgards,
> Simon
