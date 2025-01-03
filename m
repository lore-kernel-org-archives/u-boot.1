Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397ABE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F68880107;
	Fri,  3 Jan 2025 04:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ENURLuA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D331780107; Fri,  3 Jan 2025 04:35:23 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636C9800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87A8F40FAA
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735875320;
 bh=ZHkLKNRArVSPuMJeozWfXFCRIWwuRCV6+3y00hWfvEc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ENURLuA2RijmW+4dZXAmQS0gOa7ciBgzUnFTZa7SZO34Yudn3P+BI6M6hT4FsVRJy
 3i/dVyMjZRqswhUbw3l4QFYesYdIbp+HDUnw2Bgc/hQWeJwJAfhC//856b9ixGYBfn
 6ycJ8kfCW7hP3/hPqGEwXwiqa6mQpezV2PUx2eJ/sXbMJbyJItRGAoNw8O5N7d/R1x
 46GhS58JarMF8Y+Mx7DJ3IGLl0Q93K2B7KvXPS9Fa3f+iUxNltg35NeIcB74DJQJC2
 w+fw3RnfdeO16iwbb3rT7y8sHSKfeBZzC9tdPLSDCaIjdkapwcMNWNrOos+5CI97Ho
 Th2bIWNpNBobg==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so16598050a91.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 19:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735875319; x=1736480119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHkLKNRArVSPuMJeozWfXFCRIWwuRCV6+3y00hWfvEc=;
 b=tNO8HPX3IX1N3b8X1MXSviHZgjIUk/8ZeTWNEupW+oFIFclayE2pyqX+UnyyRFjfw4
 v4rIGNVSAW8z8CnX1Z2bJ2zIfFimlDXICRYo3yc85zWcPjLq+kT3Y6JtX/FKzhkL4JTy
 W+FOiWH6c2KAHxP+hjLlj+UfH9cb4Glb9/ijyDz9+jzh7FPLPL2VI1axkz8G/HnKN/VH
 Mnbyb2whxQPbIFuNTNbHx+LQudDT7Ts5vCZFtQIYuWoFtFgWH/zQJRWDW/IoLyfGhgp7
 8n1e/JrHVOt+Hwfb9j7NwSsrwYPf3tx9YuvvhBr5ljz6iLnvSteq4z7LpEmmbwNKtpZJ
 5J7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMpwdqyn2OsrhcJpUxQyHZ58E6zWfmcUJjljqe3fqol8gNFOZn2ktIYIQFjKiEVPtZH+hJiGM=@lists.denx.de
X-Gm-Message-State: AOJu0YwANmU6Vt3RxOyFR+5mXeYIThrj9lukEM95uagFSjRhVyUONj7K
 NOU4RS1hdLEqYR3pS2o2LXKiSAwuv3Y8nbX0Mhr0q0Bc/3WluICRDXPWiuhx+xvnJScX+l9nSQO
 W/cXW4xNNGV6o2iI1IiwRwrwUOt24bZg3GuwrzpOrmFsQCbTdzwdPLQ3okuQ6lGFJDqZnZ8qXW7
 GQv5EhE4eJ/YxWO9s+xsix0n0M3YOtL4EFUd9qJB24gQ==
X-Gm-Gg: ASbGncsDtfzMAz8IgHxNI9wASCxVE4Ju7dQA1oELxyv2YCdVD5EmxWLrzTfYGAHZ3XZ
 1/PTzU8bWXiv22WpsR1o8ujJ2Oj9XlD21w2rfLTQ=
X-Received: by 2002:a17:90b:53c7:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f452ee7147mr60016227a91.26.1735875319167; 
 Thu, 02 Jan 2025 19:35:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaG3ilZUZTuTj0hqfkqLto60wvsJ/k+FzkoELgK2i6vtg2w9DZnI89H55oNLDr7xhNZlXnK//oxkapzngHwKs=
X-Received: by 2002:a17:90b:53c7:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f452ee7147mr60016212a91.26.1735875318795; Thu, 02 Jan 2025
 19:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <CAFLszTggvw3ioB=r3yNcjFCZxU612AOtS2B+tBNE1Lf+TABQQw@mail.gmail.com>
In-Reply-To: <CAFLszTggvw3ioB=r3yNcjFCZxU612AOtS2B+tBNE1Lf+TABQQw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 3 Jan 2025 04:35:07 +0100
Message-ID: <CAM=mAOm9pXOuhZTyDVWUjTToghRdxRh60ainuaHfZJQNjy6pYg@mail.gmail.com>
Subject: Re: [PATCH 0/4] efi_loader: enable running the debug UEFI shell
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Simon Glass <sjg@chromium.org> schrieb am Fr., 3. Jan. 2025, 02:40:

> Hi Heinrich,
>
> On Fri, 3 Jan 2025 at 07:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Currently running the SCT fails on x86. The EFI shell overrides U-Boot's
> > Simple Text Output Protocol. When ConsoleLoggerPrintWithPageBreak() is
> > invoked with ConsoleInfo == NULL a crash occurs.
> >
> > Debugging requires running the debug version of the UEFI shell.
> > We can use `add-symbol-file` in gdb to point to
> >
> Build/Shell/DEBUG_GCC/X64/ShellPkg/Application/Shell/Shell/DEBUG/Shell.dll
> > and the load address of Shell.efi.
> >
> > The debug version of the UEFI shell checks several requirements and
> > fails to run without them:
> >
> > * HOB list (only on x86)
> > * HII configuration protocol
> > * DXE services table
> >
> > Implement the missing requirements.
> >
> > When starting image add the image load address to the debug output.
> >
> > Heinrich Schuchardt (4):
> >   efi_loader: implement a HOB list
> >   efi_loader: build with HII configuration protocol
> >   efi_loader: install DXE services table
> >   efi_loader: print image load address in StartImage
> >
> >  include/efi_dxe.h               |  54 ++++++++++
> >  include/efi_hob.h               |  32 ++++++
> >  include/efi_loader.h            |  16 +++
> >  lib/efi_loader/Kconfig          |  15 +++
> >  lib/efi_loader/Makefile         |   4 +-
> >  lib/efi_loader/efi_boottime.c   |   7 +-
> >  lib/efi_loader/efi_dxe.c        | 176 ++++++++++++++++++++++++++++++++
> >  lib/efi_loader/efi_hii_config.c |   4 -
> >  lib/efi_loader/efi_hob.c        |  33 ++++++
> >  lib/efi_loader/efi_root_node.c  |   3 +
> >  lib/efi_loader/efi_setup.c      |  13 +++
> >  11 files changed, 349 insertions(+), 8 deletions(-)
> >  create mode 100644 include/efi_dxe.h
> >  create mode 100644 include/efi_hob.h
> >  create mode 100644 lib/efi_loader/efi_dxe.c
> >  create mode 100644 lib/efi_loader/efi_hob.c
>
> Please can you document how to actually run UEFI like this? Also, is
> it possible to add a test for this new code?
>

Building the EFI Shell is documented in the EDK II project. U-Boot's
bootefi command is already documented. What documentation are you missing?

The HII config protocol just returns EFI_OUT_OF_RESOURCES in each function.
So there is not much functionality to be tested. We could verify that the
protocol as well as the HOB and DXE tables are available.

Best regards

Heinrich


>
