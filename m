Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F98C5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 15:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16F814061D;
	Wed, 19 Aug 2026 15:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yudTWlVy3OsI; Wed, 19 Aug 2026 15:41:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787154110;
	bh=spFTsbgYfYQbeS+jQ8Dl3NCif2hdTLho3G0dK4D5AyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fcD2iEmuKeukdX4/537ierIQJ3CaS38h1txASX7zTTSLsQNEKVFs03ttgAm/XXwKm
	 jT4n8QiuS6MRZ0c62vPQHOHm1c6QngaJVJ+Nk4yBC8fQkfSrhM2jpBTBPBgD6zywuT
	 oVieQg/+rWnlGBkKiZt0Jm06suMRTIyZ7rox6jnWZ77yIUmkB57+1giNzngiF2RnKj
	 r45pw3IqUnKNFOdUT+X55WD3JwZpLylAbhS4SvuOT8vbRyaqsjavLtmho3gYgpghJh
	 JqZTh+ca836+j18iL3cTXyXidVwD/BjWDYnkqBAUv/29ODkIlTo1JmOev+nCBJxMhp
	 E+OxbGaI3xPig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E34E4057E;
	Wed, 19 Aug 2026 15:41:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9065129B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8246260645
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7U8mEKUfo09 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:54:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=lXSVvr7L
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E01AA600C4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:54:13 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1205F3F2CA
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787151251;
 bh=spFTsbgYfYQbeS+jQ8Dl3NCif2hdTLho3G0dK4D5AyA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=lXSVvr7LNHrvy+I8MVDuuPN/iLN2SwITDK62YY0CW97tlP6e3wKuWQPPtxicCKPbt
 c/t0vdluv6s2LSb9tCfsyOAchdQzEN8d54J7tTp8r6p9S35THra8RRa3cZ4Ko/rfUQ
 dJDNcPhF0XMmE+8KgyFyM25BROkgeec7Q95WYcsV3z3b7ex5DOQfry9oRBENX6fNks
 vaj5tJoOKnn3orVNJ08+ih3aiRLQzxl0FYJBx7QuknSj8DGvQ1EyNRCJghq1GakmmJ
 QkUPlxktZWj8nWICc6DjWXj6+3SEbU8cE9wAuzmUA2KQ+oPQq4PP26K/IIS47ICfJ6
 kpaieV3ubIiA0y8HEQ8W8hzhxahzn2nZWASwKwJ0rYqBvfV+RfQuaq0etDhFN7tIWC
 jki5EmmLhlW/NxetQP4D4ZJ6yWLUnON5YgZeoiZxrL1h/e+H6knkQV0IeeOaf8XVJQ
 lpz3MzFOonmE+gI8JtX5TfFutDXYKpEDP2ijfX8yfFcn9io9J/TqF8WEDsGzNejSQC
 KdEH5DvJj4cuBfvjgVEmh1w43psL2hA97spelbUaMEslyHciEC8RgkBhYUKYNlTmSZ
 voRBOR5wxuiJ9ccf45G/3Zn3jqDmGZZVfjjt6r/TPkXyIDAAawXGCCcuD+Y6zR8rUX
 ZjhfVjgN22fqzYRM9++7Y5GM=
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so76888566b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151250; cv=none;
 d=google.com; s=arc-20260327;
 b=Cm0dG4vWM/8aEZL5+WI4TR7unC8gJCbMK1X4DpGbaWo/AomHmgwTTHuHbPGtSkPUIL
 K1ia+1Z21oZxN0sjRALTu0obX+dHsqu5XjyUKusa93kP8cNjni/mPjTxdPNKz0ZtHZAR
 1WHbwsDftPRoVYnvyoyz+Uev7/zDQoWT0hOq0R0yH6cjJgGsB5wWmHvcEAId0cONyiLN
 wtEIyLFSaJoW0k6gOjSKa+Y/nUH3pEPwTg/wLYGMNcQ2LoxkFHip/TqtBP9Voq1z0oHo
 9E5mbrGS+cVo6feuAH0IIVvzzAH/WFD+3+vPCPeCEC763AgBM9jJ206w//4yOsIOET7o
 mmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=spFTsbgYfYQbeS+jQ8Dl3NCif2hdTLho3G0dK4D5AyA=;
 fh=r4oZReMDYy7z9RIeW32CDdjEZIu82AwCAubq2chlMVc=;
 b=NPwO0lUarlz2HNQpWZ5K1MEV6SMj+yD6EElOakjgAqEaBA+QIXrBWWK6BtxnbCJP8k
 fn9atmqCA960zV0jHV6L4pjVHBHoB+PsMZvI1apkQaJ2jMVcp0tDVzh2kKlbB8Ui98uG
 Lr3gA1gH8nQKIk07ZJXtzb82Jba3vPesVYq4Cfk2u8AWK+W9L6Xr0tnSj81+FhTk3R7b
 YSnFcaM8VKZVU6aeklAICufMSfpQow5lv4jgiSE88qNwSlehIRVBpY414EaVM7s8Bkm2
 imqZbrvoTIVMavJ7RdkwQo9XEOQ1pXbaqxG6uLd3OuYh4zCwYzC1vsw8xrq9thV57bbQ
 +rlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151250; x=1787756050;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=spFTsbgYfYQbeS+jQ8Dl3NCif2hdTLho3G0dK4D5AyA=;
 b=IbHoIR5pkjzp/Sg+Mpx2RIOKShcyppaS5Sn29ipwIMieQpfmL3Ne4jFtueUqBHUS/u
 hpMtcjabrwHriXQfXDfIM+JLdy/Vcqqsa9Kfxm3HIs9i6Z7Ltu1NEq+g4jdIvcd/gqaN
 H/GtbR7WAgPBSocyvFeLMnYkFyd1co9fwF5UrZ2D3pWHKbP3lIttUIxHZGISiG9qm0Rw
 r7fNLZDa8kclpcPsraGXWvqXmO5L1Xpp+B1PvHgwuohqnx5i06b0yO34D5JRLZI8pk51
 JOSBl1rFqIVmH+5b+dIHxtMszcs56kKhyvQZRWD3ZB7puF3MTH8YKz5Q5PxY1ZaDNaQb
 6nAg==
X-Gm-Message-State: AOJu0YyHhQdrzoZU/l3NU5HL1PRdiDxubrvh6TDYDoVsftdisEaEshVo
 DY4joRsQMGnOLtuC4pOVHr8XdFqnjk3BrPPSk5gL8rqMqylw+VAdhrgqviafJtejjSDwfDeeewN
 pwywwakjMIkX07YS0/YsCRtIbAq5MaK/pCnY00USrM/w88pNSbdoY2XlFeMgxzRvRViFn4ZnEat
 obrlsYz4mEsrNCE5Izy5WYVOwTTMh+curswr0h1iTTd8Y6bR3qEQ5WDqOtQycZ
X-Gm-Gg: AR+sD10M+/RQ0IrBKATOmhiOxzPI2+jbFPYCCTFeFwLIC0VEO76U2MuSsdbpnYi5HZw
 XFLlPSkmWDagbIMB8R2zfIv0iqrEMi/g5z1+927uXqMNJg/VqMKyJgsKp0UHiuIsmsYGDVFqbTN
 eulD6qVRw3G3PBocKmQI6AGdYAuiqEQk7E1YBi+D4TMDG92W1gJgpu+jRs
X-Received: by 2002:a17:906:9f91:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c24457baafamr234729266b.21.1787151250321; 
 Wed, 19 Aug 2026 07:54:10 -0700 (PDT)
X-Received: by 2002:a17:906:9f91:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c24457baafamr234727166b.21.1787151249955; Wed, 19 Aug 2026
 07:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
 <20260818221019.GE523975@bill-the-cat>
In-Reply-To: <20260818221019.GE523975@bill-the-cat>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Wed, 19 Aug 2026 22:53:57 +0800
X-Gm-Features: AcwNN1Xu2OisqiBMUEZBooZdyga8lKrtDhrHBNyNliaKW7u7eRMlUftc5lLbxUM
Message-ID: <CAA=k7==gD0A2Ri=-=4ogTf=yJH5s6mOUMF7k5LGYGRR-Sommfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] bootm: size the noload buffer from the compressor
 header
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 nora.schiffer@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 15:41:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

On Wed, Aug 19, 2026 at 6:10=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Aug 18, 2026 at 01:23:14PM +0000, Aristo Chen wrote:
>
> > This is v2 of "bootm: size the noload decompression buffer from the
> > compressor header". Tom pushed back on v1
> > (https://patchwork.ozlabs.org/project/uboot/patch/20260809042338.63397-=
2-aristo.chen@canonical.com/)
> > on two grounds:
> >
> >   1. No concrete problem report driving the change.
> >   2. ~1297 platforms grew by ~170-400 bytes; the change is not
> >      opt-in, so the size cost falls on everyone.
>
> So, the first example that pops up in my builds is imx8mn_beacon_2g.
> And for v1 of the series:
>    aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
>             imx8mn_beacon_2g: all +16384 data +14336 text +2048
>                u-boot: add: 0/0, grow: 1/0 bytes: 328/0 (328)
>                  function                                   old     new  =
 delta
>                  bootm_run_states                          3316    3644  =
  +328
>
> And now for v2:
>    aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
>             imx8mn_beacon_2g: all +16384 data +14336 text +2048
>                u-boot: add: 0/0, grow: 1/0 bytes: 368/0 (368)
>                  function                                   old     new  =
 delta
>                  bootm_run_states                          3316    3684  =
  +368
>
> Next, picking turris_mox as it enables ZSTD:
> v1:
>    aarch64: (for 1/1 boards) all +472.0 text +472.0
>             turris_mox     : all +472 text +472
>                u-boot: add: 2/0, grow: 1/0 bytes: 472/0 (472)
>                  function                                   old     new  =
 delta
>                  image_decomp_get_uncompressed_size           -     416  =
  +416
>                  bootm_run_states                          2360    2412  =
   +52
>                  zstd_get_frame_header                        -       4  =
    +4
> v2:
>    aarch64: (for 1/1 boards) all +428.0 text +428.0
>             turris_mox     : all +428 text +428
>                u-boot: add: 1/0, grow: 1/0 bytes: 428/0 (428)
>                  function                                   old     new  =
 delta
>                  bootm_run_states                          2360    2784  =
  +424
>                  zstd_get_frame_header                        -       4  =
    +4
>
> So, that is better. Looking at smartweb, both iterations are the same:
>        arm: (for 1/1 boards) all +96.0 text +96.0
>             smartweb       : all +96 text +96
>                u-boot: add: 0/0, grow: 1/0 bytes: 76/0 (76)
>                  function                                   old     new  =
 delta
>                  bootm_run_states                          3592    3668  =
   +76
>
> What's honestly concerning is chromebook_coral where v2 *shrinks*:
>                u-boot: add: 0/0, grow: 0/-1 bytes: 0/-2 (-2)
>                  function                                   old     new  =
 delta
>                  bootm_load_os                              520     518  =
    -2
> but v1 grows:
>                u-boot: add: 1/0, grow: 1/0 bytes: 110/0 (110)
>                  function                                   old     new  =
 delta
>                  bootm_load_os                              520     587  =
   +67
>                  image_decomp_get_uncompressed_size           -      43  =
   +43
>

That one is working as intended: chromebook_coral enables none of
GZIP/LZMA/LZ4/ZSTD, so it is one of the "bootm with no decompressor
at all" boards from the cover letter. In v2 every helper and its
switch case sit behind CONFIG_IS_ENABLED(<format>), so on that board
they all compile away and only the unchanged 8x fallback remains.
The -2 bytes is codegen noise from the restructure; I diffed the
disassembly and the function is otherwise unchanged. v1 grew there
because its helper in image.c was built unconditionally. Behaviour is
unchanged either way: with no decompressor enabled, a compressed
kernel_noload image already fails in image_decomp().

The imx8mn_beacon_2g result has a similar shape to what I measured
on am62x_evm_a53: both enable LTO, and on these LTO configurations
compiler inlining and layout make v2 a few tens of bytes larger
than v1 (+368 vs +328 here, with the growth landing inside
bootm_run_states either way). That is the trade of the per-format
split, which is what makes the no-decompressor boards free, trims
the gzip-only majority, and keeps each format individually
droppable.

turris_mox is the non-LTO counterpart and shows the intended
direction for the multi-algorithm case: v2 comes in 44 bytes below
v1 there (+428 vs +472 in your run).

smartweb is the expected gzip-only LTO case: both versions cost
essentially the same (+96 in your run).

Thanks for the u-boot-size-test.sh pointer. I re-ran your four
boards with it against this series' base and reproduce your numbers
to within a few bytes of toolchain difference, including coral's -2
(here: v1 +108 with bootm_load_os +65 plus the unconditional helper
+43, v2 -2). I will use the script for the size numbers from now on;
if you would like the cover letter regenerated with those numbers, I
am happy to respin as v3 with the code unchanged.

> > On the first point, Nora Schiffer replied with a concrete use case
> > (EFI-in-FIT plus padded loaders such as shim, systemd-boot, and
> > OpenWrt's lzma-loader can produce compression ratios that outrun the
> > 8x heuristic), and mentioned this is on the road map for TQ-Systems
> > standard BSPs.
> >
> > On the second point, v2 reworks the implementation to cut the size
> > cost, measures it across the format and architecture buckets, and
> > splits the work per format so each decompressor's support can be
> > taken or dropped on its own.
> >
> > Background: for a compressed kernel_noload image, bootm_load_os()
> > sizes the decompression buffer as ALIGN(image_len * 8, SZ_1M). The
> > 8x heuristic works for typical kernels, but any well-compressed
> > payload can exceed it, and no fixed multiplier is safe against
> > arbitrarily compressible input.
> >
> > Each implementation patch adds a small static header-parse helper in
> > bootm.c (no new public API) and wires it into a size-hint switch;
> > helper and switch case are only compiled when the matching
> > decompressor is enabled, so boards that do not build a format pay no
> > code for it. gzip's ISIZE is a fixed trailer read, lzma's size a
> > fixed header read, lz4 mirrors ulz4fn()'s frame-header validation,
> > and zstd asks zstd_get_frame_header(), whose frame-parsing code
> > already ships with the zstd decompressor. The header-recorded value
> > is attacker-controlled, so it is capped at CONFIG_SYS_BOOTM_LEN, and
> > it is only an allocation hint: the decoder stays authoritative
> > during the actual decompression.
> >
> > Text size deltas of the u-boot ELF (size(1), distro gcc 13.3 cross
> > toolchains); data/bss are unchanged everywhere. To make the columns
> > directly comparable, the v1 column is v1's implementation commit
> > cherry-picked onto this series' base, so both columns share one
> > baseline:
>
> Please use binman to look at the size changes, as it gives much more
> useful information. I've noted
> https://git.u-boot-project.org/u-boot/u-boot-extras/-/blob/master/contrib=
/trini/u-boot-size-test.sh?ref_type=3Dheads
> for others before as a wrapper around the options to get the most useful
> information out.
>
> --
> Tom

Regards,
Aristo
