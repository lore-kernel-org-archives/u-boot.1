Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA59C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A4584CF9;
	Wed, 15 Jul 2026 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gH1MDIjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C776D84CFA; Wed, 15 Jul 2026 20:42:29 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F4684CC7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c5eb6dfd3so7605833a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140947; cv=none;
 d=google.com; s=arc-20260327;
 b=T7gCXi26WsE66CnuiEEDdThDyPuOY3QKNBl9uh454i/5663oWp9rtm6/rLoYEQYw8O
 FJea4HsXuU/1ZY2S5SCuW7j3UhUU5tpBaUgM0Fbj4AAgm2G4S+3fImKuG9UWvGUktt7m
 Ns3a4YEs49Ino8rb+nkpT+zTN7lnPkCn5i2hKK2tvZuYItPTyOhwFIcttUV7x6A4PeZS
 EZGLDJ28tDEVNbykJedLj8kmjBX+k8dfC+RDAl4z+U5zZklvLG1GHm44NCEWHPJ7V6Gt
 bhzdowxHU3HJg08EMSbhU8q6jHjOddmRxykO7WgoJnYAXMSHpa9PnR5qDAbFXLq8rttS
 QMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nGClcAY5U3URaPUvm+uOavwGpt6lBZw6+jPZa5G928c=;
 fh=jL+MMem31CGGOM/2K4pRkbzUxU2RsM7OFZeySLQhNMw=;
 b=hcO75ALv0ANZBnN13oE3jABgP3O5xtJD3Uer8dyyTv8FW/MwVgzHyDn6HL0aq9bgoW
 03TTshZtpqd987L3jl67Y9r6NP0z2jvK5mZcGMEvfS958DNhRdYwtdOjpR5KExPi3Q59
 eXzNX0TOMwCAKv3Sld21YwsHyJ2wpyqInlV7TSPtQdRo8sTis3xVQkWfvf+REkmicsuR
 Qpfc1YGJk0uMIN4UL7mpVtQaHkzJRYhczKFBnO/lV2nsNqG6cXTCATKclnxrEdNlYn78
 0Y55W9f/G7OydhPIwvm1p7oQYGO+TOwfjYj8ena5S2JW12LhS24UkhAZj3mZnSDb16Uy
 apXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140947; x=1784745747; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nGClcAY5U3URaPUvm+uOavwGpt6lBZw6+jPZa5G928c=;
 b=gH1MDIjSes/VnKYKKB8pOmrXAO/zUNM+7Eigb+cw4A0Eo17O68i8iUGvtO+SEcUBs7
 KMz4k+qUsatUDS6XH5OR4zyNYDDD4ypyGZkIik4rD4Y0+MK/0s4dWqoEmRiP+5iUWIuk
 Jydr0WTcbqtOTxyc1AF8nWaEyifDKdf08HJRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140947; x=1784745747;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nGClcAY5U3URaPUvm+uOavwGpt6lBZw6+jPZa5G928c=;
 b=tZv8M+G+u07H2WCtjr/zYZ4nsl5bv95lLauLE4mkdTGCS3gEvrNgWolygP0hRDXArz
 p1URV/IFGMesdVdk7HupJAlPFnwVNAyIMQAX2tRoqi8t6ngp5ebDHqinzPPsrWLIL651
 50i9WSB8KigtwlT+MzcS2Owy0Yf8nYrPaSeyeBb6b3Gyfp4s2B9ci+IzTgVixVvaIHrr
 MGVtFigLpWgNL41ZrWDV+5/q+gmm9Qc2ah+JIELqVhdhPVePYT4hvpFKcgJ9XjSWiwJ+
 dHl5+uZd/UKcIh609yjj0ZovVRhffqQJyzxblRrjahUJlNSweKqNfHu0boJw9BbWxUm7
 7CYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVWWia6JEcTYZ3NdpGJri2pXTsfm0890ggCoadPiSgkkgJKNkfhh8P/9iG9WEn5yuUnNUs2/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6K2Yjnfwy6eItD/J05tpLqH7xlNG2do2TkRuiMKqmeznhjNfa
 RyhZPOjPWOsw2AdXT59VEPkEwdOiRNkPe6hVftWIiSeUEAvjokXz7F/VSgjeHSGXd4zMa4fUZh5
 +1YF1GyJJzf3C6DDYg5zLotKYR2npRohIxRRpkAr5VjaK2SfmkRlM0w==
X-Gm-Gg: AfdE7cmZhZi4k4xDkYpP3L1pnmPFl+MsurPy9b92AJ0+9hIhK0Ul8DoYnfg/3fN6lSM
 pxkYbX8hHLBPbHA1Z4K3ErYnn/5p/0e88iZnFV853ZvSPG8voOtmbrX4CnvU+S/FlV3C9tFMw4o
 qRl8MJpKg1lXBOD9MRZsc7ORZkWA3uWOlqtPm9cOuxlzNYw/QPes0nZAQkuKEMkkQ6V+A6tK/ma
 zEvPNeqTs3O7rzV8rQJLPRvGhz2cJJWyCMPUaOyojEmWELeoDkOgCNV8GOdgjEyAXi2OWU=
X-Received: by 2002:a05:6402:3217:b0:697:daf8:6090 with SMTP id
 4fb4d7f45d1cf-69cd6c71d53mr4998135a12.15.1784140947243; Wed, 15 Jul 2026
 11:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260706215446.4068820-1-visitorckw@gmail.com>
 <20260706215446.4068820-3-visitorckw@gmail.com>
In-Reply-To: <20260706215446.4068820-3-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:42:15 -0600
X-Gm-Features: AUfX_mxWUaBTsC6IkRV2v7CC1ljOpGzpOLHHmKA6DofDNjWIVsUtcIPflQlkK8A
Message-ID: <CAFLszThSiEdQJgGNy_UQHxg6eYs71K95SpV84rUcFWyoz0iwDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fs: 9p: Add 9P filesystem support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On 2026-07-06T21:54:42, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> fs: 9p: Add 9P filesystem support
>
> Implement the VFS interface for the 9P filesystem.
>
> Map the U-Boot filesystem operations to the underlying 9P protocol
> client. It also registers the 9P filesystem type within the U-Boot
> generic fs framework, allowing it to bypass standard block device
> partition checks since 9P is a network/host-backed filesystem.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> fs/9p/9p.c     | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/9p/Kconfig  |   8 ++++
>  fs/9p/Makefile |   5 +++
>  fs/Kconfig     |   2 +
>  fs/Makefile    |   1 +
>  fs/fs.c        |  35 +++++++++++++++
>  include/fs.h   |   1 +
>  7 files changed, 189 insertions(+)

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -466,6 +487,20 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
> +     /* Intercept 9p to bypass block device partition checks */
> +     if (CONFIG_IS_ENABLED(FS_9P) && !strncmp(ifname, '9p', 2)) {
> +             for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {
> +                     if (info->fstype == FS_TYPE_9P) {
> +                             fs_dev_desc = NULL;
> +                             fs_type = FS_TYPE_9P;
> +                             if (info->probe(fs_dev_desc, NULL))
> +                                     return -1;
> +                             return 0;
> +                     }
> +             }
> +             return -1;
> +     }

There is already a mechanism for pseudo block devices: the hostfs and
ubi special cases in blk_get_device_part_str() in disk/part.c return
success with a NULL desc, and the normal loop below then probes any
filesystem with null_dev_desc_ok set, which you have already done for
the 9p entry. Please can you add a 9p case there instead of
duplicating the probe loop here? That also fixes two problems with
this version: strncmp() matches any ifname starting with 9p (strcmp()
is what you want), and fs_type is set before probe() succeeds, so a
failed probe leaves stale state behind (the generic loop only sets it
on success).

> diff --git a/fs/9p/9p.c b/fs/9p/9p.c
> @@ -0,0 +1,137 @@
> +     if (p9_client_walk(c, p9_root_fid, fid, dirname))
> +             return -ENOENT;
> +     if (p9_client_lopen(c, fid, P9_O_RDONLY))
> +             return -EIO;

If the walk succeeds but the open fails, the fid is left allocated on
the server. Please clunk it before returning, as in the
readdir-failure path just below and in p9_fs_read()

> diff --git a/fs/9p/9p.c b/fs/9p/9p.c
> @@ -0,0 +1,137 @@
> +     if (p9_client_readdir(c, fid, 0, sizeof(buf), buf, &actread)) {
> +             p9_client_clunk(c, fid);
> +             return -EIO;
> +     }

This issues a single Treaddir at offset 0, so any directory whose
entries do not fit in 4KB is silently truncated. Each dirent carries
an offset field (the 8 bytes skipped within P9_DIRENT_OFFSET), so
please loop, passing the last entry's offset back in, until the
server returns zero bytes. BTW a 4KB stack buffer is quite large for
some boards - since it would be reused across iterations anyway,
consider malloc() / free() here.

> diff --git a/fs/9p/9p.c b/fs/9p/9p.c
> @@ -0,0 +1,137 @@
> +     *actread = total_read;
> +     p9_client_clunk(c, fid);
> +
> +     return (total_read > 0 || ret == 0) ? 0 : ret;

If a read fails part-way through, this returns 0 with a short actread,
so the caller (e.g. the load command) reports success on a partially
loaded file, which could go unnoticed until the image fails to boot.
Other filesystems propagate the error here, so please return ret
whenever it is non-zero.

Regards,
Simon
