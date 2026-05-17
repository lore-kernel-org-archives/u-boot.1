Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530D6CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BF9846BE;
	Mon, 18 May 2026 00:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DpeMxvOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A506846A5; Mon, 18 May 2026 00:53:22 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0888466F
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso292654566b.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779058400; cv=none;
 d=google.com; s=arc-20240605;
 b=ODR7akg8A2asDkwT2KDHvEqYgz01hsIXPOFM25af4ck4taw8UJqmj4AElFr7buQe1z
 0ws9dnkO8/mDRinMiXw122LQpxvNjaRoWpMrcsvkxmnFNfIqEeTD3knBuE52FSEc+jeZ
 yo6/zaIZ2rLV+cu8z7MobxSu7AdIuWMos+bK4fN3quTbSCx9/8uOQ4z5NLrBeDx6fXmA
 LLPNS1gLRnT0RdtThlNG7+WI2DyJCGHlmugu9aYKBxvVwu/rIcmMh0i+8mlA3AbjOSt2
 kn8/v2w7xHq/7U/LvsCfcfZDcvllNrA6aqoJStIClm/e97BN1rsU+GYuhOp12f/8Qsb0
 QGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CkeDwYUwEWMrdYZgBJ8McwdeqKNwBdCmhU2yqbfFP9I=;
 fh=2+EkYWhs/J7zTeUM4/z2dpCvsQaqZvMB3yv+I9g0U6E=;
 b=MVsmxllV4M1Zglv4/z1oie5XaRREgM2SGZd1nChVQDX29zSoSct9aTRucvELcPV+e9
 m1v7/JQqdqvpD8laL6DByi5CSKlYN4JN7kYXLsBOM1PfCgP0UuMABQRfqT+PIYsx3U7D
 PXUy4vGLzCGCfO/S1wksAw75EURwKEKBCowEh+qO85t/IbTAxLZBpT5gS3VxoiuR815y
 6mYJHbJlk2vLvfmgKQeXkil6d2sRcV8uJlYByef6IHkmDxPTRgFhak6QrVShbBIHUWeg
 7F3xWaiq4f0mJh7cCEjlFfat8Zn1knsfuDnx1a/XVTVN5TonJsj+2KZqdHMbmG0FL2jX
 rf6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058400; x=1779663200; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkeDwYUwEWMrdYZgBJ8McwdeqKNwBdCmhU2yqbfFP9I=;
 b=DpeMxvOWqZF1trhgbL2hzBGHM6YpUZq3+R3hWm+Q9lE2SZD3tV5dXYTG89PMUfx5Fn
 dE3F1PtVKAIm4I9gMIzVSgBHGMC8g7cH/YbGpJPHG8zn1ff72xgMGu/BsgMT2Hn+ACb8
 AfYu8NMWM15FwAqxL6ORDQ9lmGEpt4hgW5jxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058400; x=1779663200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CkeDwYUwEWMrdYZgBJ8McwdeqKNwBdCmhU2yqbfFP9I=;
 b=L0oSeTX5rYpKs5qdfjHvnEoq0PSo199+kccdFW0+G/s9PyJ4L0/Xek4qOJa05m6hUE
 1pksei6tilAnim/wymd/L0gwBL5SIg+bG1tjlX9u9DubjKDHFTwT7revnaCutUr1Ku3b
 06ZJSSxZzoIUamd0kbLoTVlJXLMw88j1vUyi8ViHyKejmTO67OVyHjQ1FtXJpYbhgq0v
 dJj8DMLETjuaLXZNgKhi0kF+hdXiWP7R+y61aTdGhB/D4ZmLe/pWq7/Di48ePIn/u9XH
 LENkrILpEbVHoZfFEEbBRQ5nPJkQpiQEUDdXIAGEmkk5/zzYiESs0jdmxHTwZevrQIts
 Sybw==
X-Gm-Message-State: AOJu0YwrH4I71alarz4NVVJNpI4vzPvqFhdCSt/6HPXn7ukMOi7b0vnL
 8mi5b/dLfw3qwL56vG39maPgXCV5yMn5A1IfyLB9FcUngZel/L6geHEpK5tAfOsqSUhZ3v1yJRa
 k+MDjPH9toLt6Q/LlMKbfu3oLyGWvwxLg3brGucks
X-Gm-Gg: Acq92OFn3MHiptCYoUptqsLkxREee4/X9kICzmq8kGxy/onybj8xnZRL72/ACZPEEHL
 4sypeMHViFKKBN4dauZBVFz6YSMsvLbk6ywhalRXDzG+X3MSyG4gMQC1kWKRooI66H0ZvxlJccs
 LR21UNaR33EiyR1ZebBlEElsTOW145mvF7I/Gbe9hls5pdXfWExzReqwFecRDqjYQ1IE/2tUL/P
 tpgRqbCFJ8SgC0X8tIlbFow3wPu1r7FqsmN9666+8th9LDZChseroJwtYjfUyR0SDvbxRaG7Jge
 Ptow0Erk
X-Received: by 2002:a17:906:9f85:b0:bcd:acf2:e8b7 with SMTP id
 a640c23a62f3a-bd5177bcf01mr672299266b.13.1779058399605; Sun, 17 May 2026
 15:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260511115340.675883-1-vjardin@free.fr>
 <CAFLszTj40xCsVeVMxCCCHAx=N16-LL48OJ4_M_tja1ka48vCrA@mail.gmail.com>
 <agopzp-8nFc7W8xU@L30177.local>
In-Reply-To: <agopzp-8nFc7W8xU@L30177.local>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 May 2026 16:53:05 -0600
X-Gm-Features: AVHnY4JxeM6dNpzQSkGG8pqSP0bq1YTe8w5ZFz-hSlpqPgg8lU9tw9aXK4Updzc
Message-ID: <CAFLszThNKg7W+Qt4wtBN2=raRF3hj8L1CdZg8=gnNrF17xnDmA@mail.gmail.com>
Subject: Re: [PATCH v1] fs: dispatch null_dev_desc_ok filesystems before block
 lookup
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Vincent,

On Sun, 17 May 2026 at 14:49, Vincent Jardin <vjardin@free.fr> wrote:
>
> Hi Simon,
>
> Thanks. See below,
>
> Before I send v2, I'd like your feedbacks,
>
> Le 15/05/26 06:43, Simon Glass a =C3=A9crit :
> > 1. Typo: 'thue' should be 'the'
>
> ok for v2
>
> > 2. If cmd/ubifs.c is the duplication this patch obsoletes, please
> > either remove it in the same series or reword the motivation - as it
> > stands the duplication is still in-tree after the patch, so the reader
> > is left wondering whether 'load ubifs ...' is now the preferred entry
> > point or whether ubifsload remains supported
>
> I'll reword in v2's commit body. The point of this
> patch is to make load ubifs <addr> <file> a first-class entry
> point that routes through fs_set_blk_dev() like every other
> fstype. ubifsload (cmd/ubifs.c) stays in-tree for backward
> compatibility; removing (or change it to a preferred entry),
> it is not the goal of this commit, but it seems to be a quick win.
>
> >
> > Please also spell out which user-visible commands get this new support
> > ('load semihosting ...', 'load ubifs ...').
>
> ok, v2's commit log will show them, per the following.
> For instance, based on my records from today,
>
> My board: NXP LX2160A, U-Boot 2026.04-00933-g0a14371fb76c with
> OpenOCD attached using J-Link for SYS_OPEN / SYS_READ / SYS_FLEN / SYS_CL=
OSE from
> the host filesystem,
>
> load semihosting
>
>     =3D> load semihosting - 0xc0000000 semihost-test.txt
>     76 bytes read in 835 ms (0 Bytes/s)
>     =3D> md.b 0xc0000000 80
>     c0000000: 53 65 6d 69 68 6f 73 74 69 6e 67 20 74 65 73 74  Semihostin=
g test
>     c0000010: 20 66 69 6c 65 20 66 72 6f 6d 20 55 2d 42 6f 6f   file from=
 U-Boo
>     c0000020: 74 20 70 61 74 63 68 20 76 65 72 69 66 69 63 61  t patch ve=
rifica
>     c0000030: 74 69 6f 6e 20 2d 20 32 30 32 36 2d 30 35 2d 31  tion - 202=
6-05-1
>     c0000040: 37 54 31 35 3a 31 38 3a 34 33 5a 0a ef be ad de  7T15:18:43=
Z.....
>
> size semihosting
>
>     =3D> size semihosting - semihost-test.txt
>     =3D> printenv filesize
>     filesize=3D4c
>
>     # OpenOCD debug logs
>     semihosting_common(): op=3D0x1 (OPEN), param=3D0xfbb37fe8
>     semihosting_common(): open('/tmp/semihost-test.txt')=3D12
>     semihosting_common(): op=3D0xc (FLEN), param=3D0xfbb37ff8
>     semihosting_common(): op=3D0x2 (CLOSE), param=3D0xfbb37ff8
>
> ls semihosting : fs/semihostingfs.c does not registers ls hook in its
> fstype_info, so fs_ls() has no work to do. OpenOCD's
> log confirms no semihosting transaction was issued during
> the ls attempts, as expected:
>
>     =3D> ls semihosting - .
>     =3D> ls semihosting - semihost-test.txt
>     (silent return, no error, no semihosting trap fired)
>
> Without this patch all those commands fail in fs_set_blk_dev()
> with
>   ** Bad device specification semihosting **
> before the FS layer is called.
>
> For ubifs, it is code analysis only, I do not have hardware boards
> to check.
>
> From the code review:
>
>   - fs/ubifs/ubifs.c:ubifs_set_blk_dev() takes (struct blk_desc *,
>     struct disk_partition *) and ignores both, it only checks the
>     global ubifs_mounted.
>
>   - The patched fs_set_blk_dev() dispatch path, for any fstype
>     whose null_dev_desc_ok flag is set, therefore feeds
>     ubifs_set_blk_dev() the NULLs it has been receiving
>     from cmd/ubifs.c all along. No new control flow through
>     fs/ubifs/ ; the patch only adds a second entry point with
>     identical preconditions.
>
> Do you agree ?

Yes.

>
> The intended behaviour is that after ubi part ... + ubifsmount ...
> have attached and mounted a volume,
>   load ubifs <addr> <file> and
>   ls ubifs <path>
> shall work like every other <fstype> family.
>
> I found those from code reviews, but it seems logic.
>
> >> if (strcmp(info->name, ifname) !=3D 0)
> > if (strcmp(...))
>
> I'll change to if (!strcmp(...)) in v2.
>
> > Can you add a test for this, that loads via the new semihosting
> > ifname? Do we need a doc/ update?
>
> OK, for v2, I'll check to add both:
>
>  - test/py/tests/test_semihosting.py exercising load semihosting
>    + comparing the loaded bytes via md.b against a host-staged
>    fixture. Should you have some test logics, I'll appreciate, I am
>    learning with uboot and uboot test frameowrk.
>
>  - a section in doc/usage/cmd/load.rst documenting the
>    ifname-routed null-block-device path and listing the fstypes
>    that opts into it (semihosting, ubifs).
>
> For ubifs, since I cannot add hardware coverage, I'll try to wire
> load ubifs into test/py/tests/test_ubifs.py alongside the
> existing ubifsload invocations.
>
> >
> > BTW, what do you think of this 'desc being NULL' approach? We should
> > perhaps improve it so that we can support non-block filesystems more
> > generally.
>
> You are right that the open-coded "treat NULL block_desc as the
> null-device signal" reads as a bad layering.
>
> Maybe, as an improvement fro v2: introduce a small
> helper near fs_set_blk_dev_with_part() that names the convention
> explicitly, so the dispatch site is one self-documenting line:
>
>     /*
>      * Some fstypes (semihosting, ubifs) have no underlying block
>      * device and ignore the block_desc argument of their set_blk_dev
>      * hook. The legacy commands (ubifsload, semihosting) just pass
>      * NULL; for load <iface> ... to behave the
>      * same, the dispatcher opts those fstypes in by name.
>      */
>     static const struct fstype_info *
>     fs_lookup_null_dev_info(const char *ifname)
>     {
>             const struct fstype_info *info =3D fs_get_info_by_ifname(ifna=
me);
>
>             return (info && info->null_dev_desc_ok) ? info : NULL;
>     }
>
> ...then the dispatch:
>
>     info =3D fs_lookup_null_dev_info(ifname);
>     if (info)
>             return info->set_blk_dev(NULL, NULL);
>
> If you'd rather keep the dispatch open-coded with the shorter
> if (!strcmp()) form you already pointed out, I'll just do that
> and drop the helper; I believe it's a nice-to-have.

Yes this helper approach seems good to me.

>
> Your feedbacks are very welcomed and appreciated, I'll send the v2 asap.

Thanks for working in this piece. It needs an overhaul at some point,
perhaps as part of introducing the FS uclass, etc.

Regards,
Simon
