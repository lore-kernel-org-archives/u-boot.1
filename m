Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB27C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF3180F70;
	Sat, 15 Mar 2025 15:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TqbTwfqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B244680F9A; Sat, 15 Mar 2025 15:48:31 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E2580ECC
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so588410766b.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742050108; x=1742654908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yucmc3HqGk/nN/gw/nmYe7VT7xePafI571CnyWAiFO8=;
 b=TqbTwfqMcHtklyHJyfOsgMy4ufLVW1ovQSSOLjG0sHmpP5EguIX8H+v92YVHWjxxQa
 HmcvEK49A9I76XXfi174PoPmcl0eHRu9nTRC33E8EYElz2XipnhbeiX7mgjq6hDa3mmI
 wREzxhgZKpScApOMmzvkSqJpnVVYwbe0BInyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742050108; x=1742654908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yucmc3HqGk/nN/gw/nmYe7VT7xePafI571CnyWAiFO8=;
 b=rqgMBG0IxpQmpTJbfJcjFMRzAgo7WWpOywHpE3W70mpC8oi61rX9Pc0KHdtPhPcvnU
 PT+lJYUuGJk5nyF++nyxFcrhQc85M1DlqmquntuuopT72ahFCpUH2zQlHwX9WnPtrmrF
 voDMBBEbcUjHzsnae/HF6sX+4zf7m029Up2ZRlGIjNb/rXPhXDlQRS+3bTMzfRHHENJX
 Xlg/0wPCnTF+oKCMCDKnB7/XNezgRJ6dEJaJ3flfiJ+hmqEspV0uhFxyPjV5OildcYk4
 tout4RnPc5tQOHvczexRO3yUU/9KRbbLNVZnv/f6P4shXSBO8mEw03WGbi6YkEXnuyMI
 GBIw==
X-Gm-Message-State: AOJu0YxR4pqMp+r3cvCBItlNS6tyUC4oOK0V9oDQWV/Vg8CcA6yF6UIM
 PHM880MFwBXOHXoRyXPTPc9/wYY9YVHL+nZ/XddhFQCsfV1zzqPQx0EXxS2QlfdXzL+I4eTG32z
 QL62nSIbbdiJjcCe6+FRErGf+mJJ3EQryDWhD
X-Gm-Gg: ASbGnctex3OVIFt5Naw1kVI7ZQfzuJ0qlTy1KOmGsXa8O1wL1OKaWvgqjZvaWxdDOno
 mRzZPkqBcq5kG3klG+7it0GV4sM41JSYrsTn9TyvYHN1j8/btH0yv5KBjWO2OvT/pg/jeCJMyOK
 sjIj54XoZ8TnNRLKb8e+rvyOr/I3SUc/2fZmZdaw==
X-Google-Smtp-Source: AGHT+IFGIMWeGPPgIzif9O5N3upux4kOwR4WSsxXit577UpeD8Wy09dULxGDft0L8hC6GDJ/+BfIUuWt2if3hZuvBLU=
X-Received: by 2002:a17:907:9713:b0:abf:68b5:f78b with SMTP id
 a640c23a62f3a-ac3314ebabfmr579253466b.24.1742050108398; Sat, 15 Mar 2025
 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
 <20250217192316.GW1233568@bill-the-cat>
 <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
 <20250314153615.GR2640854@bill-the-cat>
In-Reply-To: <20250314153615.GR2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 14:48:18 +0000
X-Gm-Features: AQ5f1Jrn8WHAucu19t2IBBkuJCuGPK4-qy9ChGcPzXJRQIPQMqo_VwLtaC8J2HU
Message-ID: <CAFLszThguOxcC2nR467Qc9U+VdO91F48mhPuv7d6DDF7WKbyqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
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

On Fri, 14 Mar 2025 at 15:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 14, 2025 at 02:45:27PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Feb 2025 at 19:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:
> > >
> > > > Reduce the number of warnings in this file.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  tools/buildman/func_test.py   |   4 +-
> > > >  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++----------------
> > > >  2 files changed, 128 insertions(+), 116 deletions(-)
> > >
> > > As I think these all were warnings from whatever other linting you had
> > > mentioned in another thread, I deferred this patch as it also doesn't
> > > cleanly apply.
> >
> > Some of it, yes. But most of it is fixing things that we should fix.
>
> To be clear, to the extent any of it was pylint problems, they've now
> been addressed as we've moved to pylint 3.3.4.

Actually, I don't know about those problems, but that's fine.

>
> > This is going to open up a significant diff for patman, unfortunately,
> > just as I am adding new features for series management. So please
> > consider applying it. I can rebase if you like?
>
> Yes, that's fine, please just explain what's showing the warnings or
> otherwise update the commit message.

Before:

************* Module u_boot_pylib.gitutil
tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
(missing-module-docstring)
tools/u_boot_pylib/gitutil.py:13:0: C0103: Constant name
"use_no_decorate" doesn't conform to UPPER_CASE naming style
(invalid-name)
tools/u_boot_pylib/gitutil.py:40:19: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:65:20: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:72:25: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:64:12: W0612: Unused variable 'msg'
(unused-variable)
tools/u_boot_pylib/gitutil.py:114:21: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:121:25: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:122:17: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:139:41: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:141:40: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:146:4: R1705: Unnecessary "elif" after
"return", remove the leading "el" from "elif" (no-else-return)
tools/u_boot_pylib/gitutil.py:151:15: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:153:25: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:171:11: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:189:21: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:243:22: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:255:22: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:272:22: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:305:22: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:317:22: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:320:0: R0913: Too many arguments (6/5)
(too-many-arguments)
tools/u_boot_pylib/gitutil.py:320:0: R0917: Too many positional
arguments (6/5) (too-many-positional-arguments)
tools/u_boot_pylib/gitutil.py:345:16: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:347:12: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:353:4: R1705: Unnecessary "else" after
"return", remove the "else" and de-indent the code inside it
(no-else-return)
tools/u_boot_pylib/gitutil.py:402:16: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:416:7: R1714: Consider merging these
comparisons with 'in' by using 'suppresscc in ('all', 'cccmd')'. Use a
set instead if elements are hashable. (consider-using-in)
tools/u_boot_pylib/gitutil.py:420:15: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:433:0: R0913: Too many arguments (12/5)
(too-many-arguments)
tools/u_boot_pylib/gitutil.py:433:0: R0917: Too many positional
arguments (12/5) (too-many-positional-arguments)
tools/u_boot_pylib/gitutil.py:433:0: R0914: Too many local variables
(17/15) (too-many-locals)
tools/u_boot_pylib/gitutil.py:512:19: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:514:19: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:520:24: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:433:0: R1710: Either all return
statements in a function should return an expression, or none of them
should. (inconsistent-return-statements)
tools/u_boot_pylib/gitutil.py:435:36: W0613: Unused argument
'get_maintainer_script' (unused-argument)
tools/u_boot_pylib/gitutil.py:592:14: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:593:8: R1720: Unnecessary "else" after
"raise", remove the "else" and de-indent the code inside it
(no-else-raise)
tools/u_boot_pylib/gitutil.py:601:18: C0209: Formatting a regular
string which could be an f-string (consider-using-f-string)
tools/u_boot_pylib/gitutil.py:682:4: W0603: Using the global statement
(global-statement)

------------------------------------------------------------------
Your code has been rated at 8.41/10 (previous run: 8.37/10, +0.04)


After:

************* Module u_boot_pylib.gitutil
tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
(missing-module-docstring)
tools/u_boot_pylib/gitutil.py:325:0: R0913: Too many arguments (6/5)
(too-many-arguments)
tools/u_boot_pylib/gitutil.py:325:0: R0917: Too many positional
arguments (6/5) (too-many-positional-arguments)
tools/u_boot_pylib/gitutil.py:439:0: R0913: Too many arguments (11/5)
(too-many-arguments)
tools/u_boot_pylib/gitutil.py:439:0: R0917: Too many positional
arguments (11/5) (too-many-positional-arguments)
tools/u_boot_pylib/gitutil.py:439:0: R0914: Too many local variables
(16/15) (too-many-locals)
tools/u_boot_pylib/gitutil.py:694:4: W0603: Using the global statement
(global-statement)

------------------------------------------------------------------
Your code has been rated at 9.73/10 (previous run: 8.41/10, +1.32)

The patch is here:

https://patchwork.ozlabs.org/project/uboot/patch/20250209212714.2317040-2-sjg@chromium.org/

It looks like it will apply for you, if first you accept my PR.

Regards,
Simon
