Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493E5E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 20:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD1C802EF;
	Fri,  3 Jan 2025 21:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nDFq/OnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CFA8035E; Fri,  3 Jan 2025 21:11:13 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D0B80295
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 21:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so391330766b.3
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735935071; x=1736539871; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=15Y/q7o9nN/kx0JTN6szoU+7LBWsR74XCRq933rHtNM=;
 b=nDFq/OnHf001yyKRr1CjpmiOw3RhdjVHZxIu+uykKqWPyDRrk1xKQNJBrfrc7yVxw3
 iUYT6WOf4Cfy0/dSddjFufoQVJz83+BTYSb+/7rlGiTP8TG0ZqsFZr93Xwagxi6o8sTf
 vQMjtGTckanbRplXU5002/jVRK0EQ+eDYaeoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735935071; x=1736539871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15Y/q7o9nN/kx0JTN6szoU+7LBWsR74XCRq933rHtNM=;
 b=Sa1tP827PW0/MoYw5mdlY8Dx8S5czmb2SwvI0z3h6jWuEbiV6vnDknzNaBQxIa37Fx
 VSa3/4Yupi+ciL4gUPdEytuoEHg1Qcf4sPBeya/gQATb5Cut4eBE8AWX8dPPWFCC1egS
 LsXy9cEtl9zif5QAwzZHB8gDXz8Vjxd+kAJVvD7rotlGPy2IwNu2Oy0Yp5aQc2amsG/+
 QRO8o/nihYAFG/TYHZxxo+xbjW4JY0vo6nPZULdUs1osIb30fKH+ISIa30CuOefHJzVO
 CbbBwtYqHYJxueAGvPWm5ZaHmSctvTDbjV3/lzS7hwMhMPIpIXwtrZeggLb939s4NidF
 VJBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWNL0h9bNm8L9kf2dhWRXQw2sqw0WtIn78+5i4tk2P5ANwr/7KeyGnvmbth7YUnsFqaTQEhds=@lists.denx.de
X-Gm-Message-State: AOJu0YyJTuXjCilJNfO2zdCciG0jCBAlcDPg5f9rYcx+0T9plxCllHZE
 KbHo9QrGAbEjXf8prV5Si0TUbKiTaJbTesQhAOYQIaJINokhzLAdeIsbIH9cXze7EIblFWWwO2V
 IAj9TThJo7i+ajC1GOLWbFyNcSsxKpaTmOCUl
X-Gm-Gg: ASbGncvO1svZf6vESk2HkviCordfqjhHI/xJWW9jv8UnK7NktFtn5pw0mYZbYd/BYKD
 DgYK4+bao2sKqYQ5kncRMTrn9XWgtMiZ3U8Y4prCa
X-Google-Smtp-Source: AGHT+IE0fdl9/Un4RaO6isOhfXd+QJKViQKXgxJggTw2SjJZiXgFBxWhuRpOk+otst4G6i/MfTTFDUB9dRBHKrguT00=
X-Received: by 2002:a17:907:96a0:b0:aa6:7feb:193f with SMTP id
 a640c23a62f3a-aac2ad81a25mr4860879766b.20.1735935070725; Fri, 03 Jan 2025
 12:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <CAFLszTggvw3ioB=r3yNcjFCZxU612AOtS2B+tBNE1Lf+TABQQw@mail.gmail.com>
 <CAM=mAOm9pXOuhZTyDVWUjTToghRdxRh60ainuaHfZJQNjy6pYg@mail.gmail.com>
In-Reply-To: <CAM=mAOm9pXOuhZTyDVWUjTToghRdxRh60ainuaHfZJQNjy6pYg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Jan 2025 09:11:02 +1300
Message-ID: <CAFLszTjZPSGQpj1kcY0D=4=x=9uAa5A2keV1r2nkCG2SUTFXOA@mail.gmail.com>
Subject: Re: [PATCH 0/4] efi_loader: enable running the debug UEFI shell
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Fri, 3 Jan 2025 at 16:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Fr., 3. Jan. 2025, 02:40:
>>
>> Hi Heinrich,
>>
>> On Fri, 3 Jan 2025 at 07:11, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > Currently running the SCT fails on x86. The EFI shell overrides U-Boot's
>> > Simple Text Output Protocol. When ConsoleLoggerPrintWithPageBreak() is
>> > invoked with ConsoleInfo == NULL a crash occurs.
>> >
>> > Debugging requires running the debug version of the UEFI shell.
>> > We can use `add-symbol-file` in gdb to point to
>> > Build/Shell/DEBUG_GCC/X64/ShellPkg/Application/Shell/Shell/DEBUG/Shell.dll
>> > and the load address of Shell.efi.
>> >
>> > The debug version of the UEFI shell checks several requirements and
>> > fails to run without them:
>> >
>> > * HOB list (only on x86)
>> > * HII configuration protocol
>> > * DXE services table
>> >
>> > Implement the missing requirements.
>> >
>> > When starting image add the image load address to the debug output.
>> >
>> > Heinrich Schuchardt (4):
>> >   efi_loader: implement a HOB list
>> >   efi_loader: build with HII configuration protocol
>> >   efi_loader: install DXE services table
>> >   efi_loader: print image load address in StartImage
>> >
>> >  include/efi_dxe.h               |  54 ++++++++++
>> >  include/efi_hob.h               |  32 ++++++
>> >  include/efi_loader.h            |  16 +++
>> >  lib/efi_loader/Kconfig          |  15 +++
>> >  lib/efi_loader/Makefile         |   4 +-
>> >  lib/efi_loader/efi_boottime.c   |   7 +-
>> >  lib/efi_loader/efi_dxe.c        | 176 ++++++++++++++++++++++++++++++++
>> >  lib/efi_loader/efi_hii_config.c |   4 -
>> >  lib/efi_loader/efi_hob.c        |  33 ++++++
>> >  lib/efi_loader/efi_root_node.c  |   3 +
>> >  lib/efi_loader/efi_setup.c      |  13 +++
>> >  11 files changed, 349 insertions(+), 8 deletions(-)
>> >  create mode 100644 include/efi_dxe.h
>> >  create mode 100644 include/efi_hob.h
>> >  create mode 100644 lib/efi_loader/efi_dxe.c
>> >  create mode 100644 lib/efi_loader/efi_hob.c
>>
>> Please can you document how to actually run UEFI like this? Also, is
>> it possible to add a test for this new code?
>
>
> Building the EFI Shell is documented in the EDK II project. U-Boot's bootefi command is already documented. What documentation are you missing?

How about this:

Mention ACTIVE_PLATFORM       = ShellPkg/ShellPkg.dsc

How to run U-Boot (presumably with gdb?)

How to figure out the load address when the .dll is loaded

Perhaps where to set a breakpoint, etc?

I think it could take the form of an example showing the commands to
do the debugging would be helpful. Probably 'history' will do some of
the work for you.

>
> The HII config protocol just returns EFI_OUT_OF_RESOURCES in each function. So there is not much functionality to be tested. We could verify that the protocol as well as the HOB and DXE tables are available.

Yes I think that would be good.

Regards,
Simon
