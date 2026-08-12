Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2BAC5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15FCA6084E;
	Wed, 12 Aug 2026 08:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhE8a3mAtuto; Wed, 12 Aug 2026 08:11:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA4B860887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786522280;
	bh=wGqRkzXIWHz5aOpQMHDuaEEjTMQzQK8x05KPjUMc3C4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FxY8WpRXIxXRymCXS9zqwvsIBvEbH2NH/gP4DAFBrWQFXSJ38FRmqGv+zGdy5/Ry5
	 34VgrHG5UE0rjzQjEUvbDG0WFk8F46k3/G0AfzpK0HdG8TgfNu3oG/hcPyhBDSIpyc
	 2wdb8fsxhG4mg6YBFVvDeBqN3pZmIzAYldm+voni+WpG1JsYe/keXx2vR0tNDnoc68
	 CjJWSYrbCObdDsaLukJhsGJrvydiDjTPUSL7i7wLvB0PsiX1GfH0Yb42vgVKdZXRgQ
	 KnWcsLaxqekcwCQ2+vEEJG0SSMvbO53KuUemDkAHxgza2xufv/AUKQLd79fP81EsBb
	 gY/hfP5tWR1mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA4B860887;
	Wed, 12 Aug 2026 08:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17EE81F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC4B381121
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdVvPw7JbMRL for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 08:11:16 +0000 (UTC)
X-Greylist: delayed 1510 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 12 Aug 2026 08:11:16 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 58F46810CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58F46810CC
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58F46810CC
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:11:16 +0000 (UTC)
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wu3eq-000LJl-2j; Wed, 12 Aug 2026 09:45:53 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wu3er-000Jz6-1I; Wed, 12 Aug 2026 09:45:52 +0200
Message-ID: <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from
 the compressor header
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, Quentin
 Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>, Randolph Sapp
 <rs@ti.com>
Date: Wed, 12 Aug 2026 09:45:52 +0200
In-Reply-To: <20260810163728.GB1160436@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
 <20260810163728.GB1160436@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wGqRkzXIWHz5aOpQMHDuaEEjTMQzQK8x05KPjUMc3C4=; b=okfaJITm+yQiTK37hgpP4ZDvgJ
 ONJ7rJV7rPkFTPGpCKv/FULd87zHG6CSo7xIo317im+Lze6/8rQGCefxnleHktj/w6r1PQGDe3oQC
 Mjh5BS9kEzhojrlcLrUHIrWInI8bAOSY72g2Cd+QWMAaKLVlzFiuTB2JjPs4jXLKAydSOGu77BM0Z
 3qvLzMojdhEX/CLhDnYtpmXeq+w4KBVmZwm5FY6XQyF+1HegeklFoTZuuzGgwQM9K2EIIpmfGHJ5V
 vM4b85sH5F6Ml7SyK2LKFU09suRGXHzRTtOeEjgtg39qnIm+Em7ceuqZE4HD/pK6bPakVDR07XJ7z
 9wInNzxg==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=okfaJITm
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 2026-08-10 at 10:37 -0600, Tom Rini wrote:
> On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> > On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >=20
> > > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> > >=20
> > > > For a compressed kernel_noload image, bootm_load_os() allocates a
> > > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The =
8x
> > > > multiplier is a heuristic: it comfortably covers what zstd and xz
> > > > achieve on real kernels, but any well-compressed payload (say, a bi=
g
> > > > run of zeros) can exceed it and fail decompression, and no fixed
> > > > multiplier is safe against arbitrarily compressible input.
> > > >=20
> > > > Read the real uncompressed size from the compressor header instead.
> > > > Add a small helper image_decomp_get_uncompressed_size() that return=
s
> > > > the uncompressed size when the format carries one: gzip ISIZE, lzma
> > > > header uncompressed size, lz4 frame Content_Size when the FLG bit i=
s
> > > > set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUPP.
> > > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), capped =
at
> > > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
> > > > falls back to the 8x heuristic for formats without a size field
> > > > (bzip2, lzo, xz) or when the header lacks the size (some lzma or lz=
4
> > > > streams).
> > >=20
> > > Have we gotten actual problem reports? This is a good bit of growth f=
or
> > > a problem I'm not sure we're seeing. Thanks.
> >=20
> > Thanks for the review! Honest answer: no bug report against the
> > current 8x multiplier has crossed the list. This is preventive rather
> > than reactive, and I should have made that clearer in the cover
> > letter.
> >=20
> > The reasons for this patch set are:
> >   * The multiplier is fundamentally a heuristic. Nora raised the same
> > concern in the v1 round of the earlier
> > series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.html>):
> > "Deriving a buffer size from the compressed size is not possible, as
> > the compression ratio may be arbitrarily high for data with many
> > repetitions (for example ranges of 0x00 or 0xff)."She dropped her
> > replacement patch when we bumped 4x to 8x, but the underlying point
> > stands: any fixed factor can be defeated by a highly    compressible
> > payload, and further bumps are just moving the ceiling.
>=20
> Yeah, I recall this. But we aren't really handling arbitrary data here,
> so it's not as much of a valid concern I think, without real examples.

It's probably not a problem when the OS image is a proper kernel, but if th=
e
next image is a tiny loader itself, even a small amount of padding (either
inside the .data section or at the end of the image) might result in high
compression ratios.

While irrelevant for current U-Boot, one example would be OpenWrt's lzma-lo=
ader:
it has a build mode where the <100KiB binary is padded to 1MiB (I may be
remembering the exact numbers wrong) before compression to force a cache
writeback during decompression (to work around ancient U-Boot versions that=
 did
not implement cache handling correctly.)

Specifically the case of kernel_noload would usually be used with EFI
applications, for which additional loaders (shim, systemd-boot, ...) are qu=
ite
common. The combination with FIT and compression is probably less common...

Nonetheless, I think a principled fix is preferable - I like the EFI-in-FIT
approach a lot (we may make that the default setup in our TQ-Systems standa=
rd
BSPs in the future), thus I would like the feature to be well-supported and
without known bugs.

Best,
Nora


>=20
> >   * Simon suggested the header-size approach as the principled fix in
> > the same round (<https://lists.denx.de/pipermail/u-boot/2026-May/620121=
.html>):
> > "It might be worth updating image_decomp() to take a ulong size... I
> > believe in each case it is also possible to find out the decomp size
> > by looking at the header."
>=20
> Which would make sense for a more general problem, or a less constrained
> system.
>=20
> > So the growth buys correctness: the buffer size is derived from the
> > compressed stream itself, not from a multiplier guess that can be
> > defeated by any payload with a high enough compression ratio.
> >=20
> > That said, I understand the "we're not seeing it" concern. If you
> > would rather wait for a concrete report, I am happy to drop the series
> > and re-send when one lands, or to shrink patch 1 to gzip only, which
> > cuts about 40 lines of parser code. Let me know which you prefer.
>=20
> Yes, I'd like to wait and see what problem reports we get at this point,
> thanks.


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
