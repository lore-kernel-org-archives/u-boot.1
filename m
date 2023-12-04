Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D184C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F288721A;
	Mon,  4 Dec 2023 02:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KVq627O4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8A8875C8; Mon,  4 Dec 2023 02:58:49 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B068870A0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-51f64817809so707129a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 17:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701655124; x=1702259924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swWdlh68zfgl9ZitkQmdeI/Nurl0AsVp8VWDHYx2+JU=;
 b=KVq627O4C6Je23kSYo6h7jqqCQe+C+bx71LTpxLg0oyUU8Sn7uIoLBu4ikIeRjkCwq
 qm0zV6G+5Nru2qRhYgKQ1jZ5I0LrJGAk6aaHf4OytUeTPyOmG1cJIqYxAfio0FNaKNZk
 8EpP6Qc/iqUjdYxCbXLDje9FKuv2NKbQd0EDNmq0EKPEq/C7/Opsz6YL67qvPRT3cyfb
 wlmPZUBnbKNOaQW6UyqZnY69OUFbn/5vkIHe+ckmgJfpw272tyKOb3OJN70jWxDkC4wi
 vjRLX6t8AMOeVSe7ivNodg4Wzg84d8xaD6oYgQm0a0RKyLipgapdsEq9kyk8X3hPWzio
 DEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701655124; x=1702259924;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=swWdlh68zfgl9ZitkQmdeI/Nurl0AsVp8VWDHYx2+JU=;
 b=pSq7/7LC4k2feaRu3Foc/ql55+2ztHPiZ9FqE85Wkb30z7J39f6wRN47NFNEq9LOjg
 ufbdcSJ2a2KDl/bPQAv4tY76k6XtwuSH0ZvTtqBvxWyqPRjevJuC74pyEThHqdCpkKSF
 q9YSZV+/WuIClK2Gv7iCf85T7vz8l3H5dvn23gugSAK0JziDEqsUwJkmohOwgfeRTTiJ
 LfKYIp44iEmLE3n34vSqruK/HvSie7Ht5iIhC4qKdgGAQvHqixUaDnirYsTk6DwbRi4A
 qVvHkYqotfFi7BLON8fyCVWGWEbhIBIIDKH3KSVtZll3H0PgWl6mMcPLUE4I2UIvGH+a
 iexA==
X-Gm-Message-State: AOJu0Yzxzl5RvHC4rkxnyTnkIhVMyB6Iv2QKxdmL580TkMLcjFQb11HA
 W6UTy1Le3Wkw6geBFfBkXhx/Bw==
X-Google-Smtp-Source: AGHT+IGRV2LV1WtZuE6ZZvBXXtd+dzys6Bu5ShMQJUUzDwKpeh7eWvZ1abZOKTil9YIVnHFOh5pzsg==
X-Received: by 2002:a05:6a21:78aa:b0:189:f553:6cd2 with SMTP id
 bf42-20020a056a2178aa00b00189f5536cd2mr15655678pzc.3.1701655124130; 
 Sun, 03 Dec 2023 17:58:44 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:bdd5:713b:14e0:aaa6])
 by smtp.gmail.com with ESMTPSA id
 h5-20020aa786c5000000b006ce4965fdbdsm1276733pfo.116.2023.12.03.17.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 17:58:43 -0800 (PST)
Date: Mon, 4 Dec 2023 10:58:40 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/12] cmd: bootefi: refactor the code for bootmgr
Message-ID: <ZW0yUHaTiPA8xxpD@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Hi Heinrich, Ilias

On Tue, Nov 21, 2023 at 10:29:38AM +0900, AKASHI Takahiro wrote:
> This patch set is motivated by the discussion[1] regarding
> CONFIG_BOOTEFI_BOOTMGR option.
> 
> At the end, bootefi.c will be decomposed into two parts, one for
> providing the command itself and one for implementing helper functions.
> EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
> CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.
> 
> Then, EFI_LOADER library side will be further split into two options
> for fine-grain control:
> CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
>     loaded by U-Boot's load commands/functions or other methods
>     (like a jtag debugger?)
>     It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"?).
> 
> CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
>     It supports bootmeth_efi_mgr as well as "bootefi bootmgr".
> 
> As such, We will no longer need CONFIG_EFI_BINARY_EXEC if we want to only
> make use of the UEFI boot manger for booting a next stage OS.

Any other comments?
I think the changes are no doubt trivial.

-Takahiro Akashi


> Prerequisite
> ============
> This patch set is based on top of Tom's "next" branch.
> 
> Patches
> =======
> Patch#1-#12: I hope that those commits show step-by-step refactoring
>     without introducing degradation.
> 
> Tests
> =====
> * run UT efi_selftest on sandbox locally
> * run test_efi_bootmgr on sandbox locally
> 
> Unfortunately, I could not submit a pull request for CI test.
> 
> Changes
> =======
> v2 (Nov 21, 2023)
> * rebased onto Tom's next branch
> * remove already merged commits
> * revise commit messages
> * add patch #5 which was split from ex-patch#5
> RFC (Oct 26, 2023)
> 
> [1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html
> 
> AKASHI Takahiro (12):
>   cmd: bootefi: unfold do_bootefi_image()
>   cmd: bootefi: re-organize do_bootefi()
>   cmd: bootefi: carve out EFI boot manager interface
>   cmd: bootefi: carve out binary execution interface
>   cmd: bootefi: localize global device paths for efi_selftest
>   cmd: bootefi: move library interfaces under lib/efi_loader
>   cmd: efidebug: ease efi configuration dependency
>   bootmeth: use efi_loader interfaces instead of bootefi command
>   efi_loader: split unrelated code from efi_bootmgr.c
>   efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
>   net: tftp: remove explicit efi configuration dependency
>   fs: remove explicit efi configuration dependency
> 
>  boot/Kconfig                     |   4 +-
>  boot/Makefile                    |   2 +-
>  boot/bootm_os.c                  |  31 +-
>  boot/bootmeth_efi.c              |   8 +-
>  boot/bootmeth_efi_mgr.c          |   2 +-
>  cmd/Kconfig                      |  21 +-
>  cmd/bootefi.c                    | 670 +++++--------------------------
>  cmd/efidebug.c                   |   4 +-
>  fs/fs.c                          |   7 +-
>  include/efi_loader.h             |  34 +-
>  lib/efi_loader/Kconfig           |  11 +-
>  lib/efi_loader/Makefile          |   2 +-
>  lib/efi_loader/efi_bootmgr.c     |  37 ++
>  lib/efi_loader/efi_device_path.c |   3 +-
>  lib/efi_loader/efi_helper.c      | 498 ++++++++++++++++++++++-
>  net/tftp.c                       |  10 +-
>  test/boot/bootflow.c             |   2 +-
>  17 files changed, 700 insertions(+), 646 deletions(-)
> 
> -- 
> 2.34.1
> 
