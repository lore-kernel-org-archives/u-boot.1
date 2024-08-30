Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00885CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A94B88AB2;
	Fri, 30 Aug 2024 13:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOIrkLXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94CE88B94; Fri, 30 Aug 2024 13:58:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C7D88A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so1798801a12.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725019116; x=1725623916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cMsQxmx0RVhHG7lbtpkSdrstlJ4z94gkbdrPC5hAM6U=;
 b=bOIrkLXBA1MNNUCEtf5/7Z387RDa2HywK4XgkuAsX8K9SRzo338DRPC7UxtWd9Aewo
 OAGSNtBDNRGHH11Nxd3AijlSMXdTvrNMDaTYEDgm5MWs5w6OCy3SSyBkFUUAhARApwjA
 X3BkZWibOQX2eWZ5t9qiaCuB+QrM4nqpPl5CTBDYrsmErB3PBDpHRcaqY58NBKiveT8W
 z9Q2I9N7cVMcobajQmOtAOxvPK4Dfh7TIDGv/KPIi19GWt6mMydNNMq9FRcFq8OipFO1
 VrKjnDOiAoq1+B3mJmKWC0JDH1ponMpSAe6upm7toM9U7ovcHGu9mXFp6PQwfU/zD5i/
 PtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019116; x=1725623916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMsQxmx0RVhHG7lbtpkSdrstlJ4z94gkbdrPC5hAM6U=;
 b=OX0DVriEvcK4ojUxSIoN3c20sppwWComOmb6pisJ9vq864qhJKFJhwVHYWru9mUQfN
 +9juEP9UCGglVJ8aotDczH+xa8nFRGkxXyvktmgDuepKxM6tgR2zsbjBbXQwn4InxAvX
 Zcw31n1pqHTt+OD2cujZOb3YseO3jMOQMu99Gq0dVBFWuL/oaZT+P4eqjXySHI/cIpJQ
 ze09TCQ329Np16CXMzkURUkJeKlzkD7dbHrpK1YowUcU7kGQ2CyXDwS6JWGUF3CjkWDX
 wdFl8xZsSLAQfmogD4Ef0PwXtGYtTkyGEq7cdwIGBibfq28/FkRQkr5mKUd+nzNAR/Gh
 97+A==
X-Gm-Message-State: AOJu0Yw4YNuZaP68QjPzwrOE2sPQ9wo0hD2127Wrrmn5MCiwwpNCmiJl
 0G4jAca+x3HWA2vcQgC0wtHcSU2oOwsDiW0ed5XL9T+zI7wj+hIN3vcaSw6MvwjSQbgDBzW4X24
 2P83mddDLW6/6SpAsV25JTQXYE7i8JAOM
X-Google-Smtp-Source: AGHT+IGjfGTMA808VtTmkjek6O4cNacAnwJ5EIEwNqhiI8OsIXe57Pp4EkCL3Jvj7y8hjOn0VltdWr+O/FbWDJoH0vs=
X-Received: by 2002:a05:6402:5288:b0:5c0:b639:ddf3 with SMTP id
 4fb4d7f45d1cf-5c21ed52c23mr4812565a12.19.1725019115545; Fri, 30 Aug 2024
 04:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 30 Aug 2024 12:58:24 +0100
Message-ID: <CALeDE9MVBH4AJUnc-KvXJeXfDq64F0E39JJ9UpjFC4gCLGGfFQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] buildman/toolchain.py: set CROSS_COMPILE only if
 self.cross is set
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Fri, 30 Aug 2024 at 11:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
> or without a full path), optionally prefixed by the toolchain wrapper
> defined in ~/.buildman. This is fine when self.cross is not empty, but
> it doesn't make sense when it is:
> - Either there is no wrapper and we end up with an empty CROSS_COMPILE
> which is the same as not defining it (the host compiler will be used),
> - Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
> which obviously is not a valid compiler, hence an error.
>
> Test case:
>
>  $ sudo apt install ccache
>  $ grep -q toolchain-wrapper ~/.buildman || \
>      printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
>  $ make mrproper
>  $ ./tools/buildman/buildman sandbox_noinst
>  $ ./tools/buildman/buildman sandbox_noinst
>  Building current source for 1 boards (1 thread, 24 jobs per thread)
>     sandbox:  +   sandbox_noinst
>  +In file included from boot/bootmeth_efi.c:16:
>  +include/efi_default_filename.h:20:15: error: operator '==' has no left operand
>  +   20 | #if HOST_ARCH == HOST_ARCH_X86_64
>  +      |               ^~
>  [...]
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  tools/buildman/toolchain.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
> index 324ad0e082..ff987a9eea 100644
> --- a/tools/buildman/toolchain.py
> +++ b/tools/buildman/toolchain.py
> @@ -201,10 +201,10 @@ class Toolchain:
>          if self.override_toolchain:
>              # We'll use MakeArgs() to provide this
>              pass
> -        elif full_path:
> +        elif full_path and self.cross:
>              env[b'CROSS_COMPILE'] = tools.to_bytes(
>                  wrapper + os.path.join(self.path, self.cross))
> -        else:
> +        elif self.cross:
>              env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
>              env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
>
> --
> 2.40.1
>
