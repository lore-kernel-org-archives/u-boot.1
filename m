Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA1C5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9284681086;
	Mon, 17 Aug 2026 18:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcRuD-xkuVH4; Mon, 17 Aug 2026 18:17:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 531158104D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990637;
	bh=RhigocsbA35Z/6pro6D90OqIPj9PO558uCOOyYHONzs=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dwlKKPhdsxUMT/1M0vyqpEdgvAzymmm+VMUG7RHmvScqMKvk51o6fPtKGym5YH6O+
	 6brbEcYR3LGXEK7b0tqMqSsmCv0MdI99wOzxA1SUf7YmisioPfsrwPK06so0Ss+ehA
	 AYmPOb+TFAzHr/Tqa9ZeL/aYd+ioc2WfXqXZax8OevrYyI1jp6De43akj68nWwVpL0
	 68IBfXShevTEpV3Pry2lO6TEQZIZSUusLaoeE+BFCIqve4UmKQj/MDo75FNAlP0K+Y
	 9U1BLMlWNHt3kmek6k5DKKkKVb4m5KaPKU2Vq+S5y63HqFIXFyiT/x4yUG2syA3+5w
	 3wGyZjxApFlDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 531158104D;
	Mon, 17 Aug 2026 18:17:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 234DB337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1529E6078D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeYVigxcXG7N for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:01:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1E51B60671
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E51B60671
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E51B60671
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:01:47 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 63DE13F82D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:01:45 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a17c89d8c1so3948840a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982505; cv=none;
 d=google.com; s=arc-20260327;
 b=XB1ojDu34Jp7gLGuVSi53gN+3dKUY+0KaSI24+0HlF8E/vmiSskH4UhrQfzvDHUD7C
 uE3F+eldElr2TKcszTIURXY3ui+Nc++5dmhN45gRHejHORubTVdDMISiN2B7zr7oju+T
 2u3jOFIr6EiYsKBxbFC7Ocn9aY4ClF1z27W1bMZ7AaWDPGhRRE562sQMsaFq6c0qVGaA
 utsZC+34q0VhZtZYV0auiLOnC+9cTs4ufOJLg8BL9sTVwcyQDm0w7Lb8VCRZSjf/BcaQ
 9TExtoiN1DhaUqaBe4BK6/nE3sDVd8Q/YsedwOUGi8SvbgoCpKuw7uNB66vY+5gZ5d86
 J9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=RhigocsbA35Z/6pro6D90OqIPj9PO558uCOOyYHONzs=;
 fh=Y+ahTN+NUreNdKr6Oh73nuYYatXhaX4+tuFrQS8QNNM=;
 b=lUiaRdygug9xZw+KNqgfn9h8UKkz8dDXTPwjBv4KhUbFfC4Xoc3S34vWJM6ab05Ya7
 tqn0BfY9wg9FSpbOs4paRT+rbSZrIegsn1R35IXDfLkcWQz3cnfRcBbP/wcQeE4g51Iv
 5PjEZPJhigzmOYM7eUcB/MR/nUO/uSP7CzeTWCB8hlK4+oxGNajvgJjYdNVxNJStuEra
 VEJkZVvjkrzVmkoXCBkxhxo/yQR/PikP8rJRRlhOsozKc9L7CIHV3N4y4EzVDcgSHr+/
 2JGEIocXMb85zLEWGuR18SFuMui/mKAKXy/z22qKO1t4WQVkAab3XeBkUhtuyeYQFWPi
 Iu+g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982505; x=1787587305;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RhigocsbA35Z/6pro6D90OqIPj9PO558uCOOyYHONzs=;
 b=T/BrWWgEJSDkh666SHx/19Vq0RC7DpYNjlsmPtvAkdXtJK0KnpzS4BT9XX5U8moWLG
 M1v1b1qg31AcjbAaQnIzC+GW8NXr8qOT6E7cP/k1m4+FIUCx1UKuRE0jOmBvLsDW0bag
 lMPrwggBJoYMjWaWCLG87/wNKwBH3xcLZow/ihlFi5V+cgf3xvF1u7+TXyG61/O7UiZN
 3i2YTnBaaOluLWOmE2NTuNIkIPtxfBAjoPBAaypgblsp1FgvtTyO4OZc9epSR0Oby42C
 h0+I6XbCcoORw/on+MH0s4VgCo3z6wJMw6ppvOthQLf7KbqFS+SmaYYpFVNFpbRRDnx1
 bdjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC5hCFNikSArLhGcsUxKiHrZTBBePkAN6ceHhDNEVDoDmFbi7enY/Rg1N3DGF1O9arnKT1mzg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyGConwWD83/ni6DcNY4beddHbLHYL6/J2ya7qmQni63i/LKLDS
 tDEgBo55yctTClFAyQwZpSaziu56KCw7GqZZnm1e48RFfJOaQ9k1lkieoeB0KDPVQp7UkXJbpns
 3cbYI1LVhlGPQRM48H7A3TibiifcnrUKGlqmBPEIKXgmjDTUCxWmeRqma3dRBBmpisDtITNeo1q
 mXpvP9ibRYJr3WhP1uW/R8YgqAY4CVEuATPMOguUGXjIq5/sNOY6p0Vi6rR9+U
X-Gm-Gg: AR+sD11Lwn2Z6U2Nr8o+Ew0tKiht1qmg4rCU3enEaFIhXA0lIQ0Mgc2cuGKZEta0xc/
 TfFMJAdH7T8uJHcN6mh4HfikUmcI9lE3XwZDNKRZjL0www0wIuAFGYb1Iv2DrfzWfoSk3cpE4eO
 JtYtoSXfMVD+p5PbWgBksdJoic+v0uq+ntnwPPwVVbDAsQk+ZG40503Udu
X-Received: by 2002:a05:6402:e03:b0:6a1:7751:64d6 with SMTP id
 4fb4d7f45d1cf-6a38aacf081mr11925406a12.21.1786982504761; 
 Mon, 17 Aug 2026 09:01:44 -0700 (PDT)
X-Received: by 2002:a05:6402:e03:b0:6a1:7751:64d6 with SMTP id
 4fb4d7f45d1cf-6a38aacf081mr11925367a12.21.1786982504341; Mon, 17 Aug 2026
 09:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
 <20260810163728.GB1160436@bill-the-cat>
 <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
 <20260812155750.GB3297518@bill-the-cat>
 <CAFLszTiGA3mZZHHTZ5cDD-QqOFRb4AgzDP2it7LEE-4LknHHbQ@mail.gmail.com>
In-Reply-To: <CAFLszTiGA3mZZHHTZ5cDD-QqOFRb4AgzDP2it7LEE-4LknHHbQ@mail.gmail.com>
Date: Tue, 18 Aug 2026 00:01:31 +0800
X-Gm-Features: AcwNN1VehsGoBlXcfjsA2YwIvIYaCiPrNiWt_1pINBgSC4ZTRPmq4Y_Vj0Utvsw
Message-ID: <CAA=k7==8-gRa-qFqf0EDrzxF7YtO_ssmx=E5-Pf6LPhNedYBWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:14 +0000
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Simon, Tom,

On Sun, Aug 16, 2026 at 2:33=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Wed, 12 Aug 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 12, 2026 at 09:45:52AM +0200, Nora Schiffer wrote:
> > > On Mon, 2026-08-10 at 10:37 -0600, Tom Rini wrote:
> > > > On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> > > > > On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> > > > > >
> > > > > > > For a compressed kernel_noload image, bootm_load_os() allocat=
es a
> > > > > > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M)=
. The 8x
> > > > > > > multiplier is a heuristic: it comfortably covers what zstd an=
d xz
> > > > > > > achieve on real kernels, but any well-compressed payload (say=
, a big
> > > > > > > run of zeros) can exceed it and fail decompression, and no fi=
xed
> > > > > > > multiplier is safe against arbitrarily compressible input.
> > > > > > >
> > > > > > > Read the real uncompressed size from the compressor header in=
stead.
> > > > > > > Add a small helper image_decomp_get_uncompressed_size() that =
returns
> > > > > > > the uncompressed size when the format carries one: gzip ISIZE=
, lzma
> > > > > > > header uncompressed size, lz4 frame Content_Size when the FLG=
 bit is
> > > > > > > set, and zstd Frame_Content_Size. Other formats return -EOPNO=
TSUPP.
> > > > > > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), c=
apped at
> > > > > > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled=
, and
> > > > > > > falls back to the 8x heuristic for formats without a size fie=
ld
> > > > > > > (bzip2, lzo, xz) or when the header lacks the size (some lzma=
 or lz4
> > > > > > > streams).
> > > > > >
> > > > > > Have we gotten actual problem reports? This is a good bit of gr=
owth for
> > > > > > a problem I'm not sure we're seeing. Thanks.
> > > > >
> > > > > Thanks for the review! Honest answer: no bug report against the
> > > > > current 8x multiplier has crossed the list. This is preventive ra=
ther
> > > > > than reactive, and I should have made that clearer in the cover
> > > > > letter.
> > > > >
> > > > > The reasons for this patch set are:
> > > > >   * The multiplier is fundamentally a heuristic. Nora raised the =
same
> > > > > concern in the v1 round of the earlier
> > > > > series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.h=
tml>):
> > > > > "Deriving a buffer size from the compressed size is not possible,=
 as
> > > > > the compression ratio may be arbitrarily high for data with many
> > > > > repetitions (for example ranges of 0x00 or 0xff)."She dropped her
> > > > > replacement patch when we bumped 4x to 8x, but the underlying poi=
nt
> > > > > stands: any fixed factor can be defeated by a highly    compressi=
ble
> > > > > payload, and further bumps are just moving the ceiling.
> > > >
> > > > Yeah, I recall this. But we aren't really handling arbitrary data h=
ere,
> > > > so it's not as much of a valid concern I think, without real exampl=
es.
> > >
> > > It's probably not a problem when the OS image is a proper kernel, but=
 if the
> > > next image is a tiny loader itself, even a small amount of padding (e=
ither
> > > inside the .data section or at the end of the image) might result in =
high
> > > compression ratios.
> > >
> > > While irrelevant for current U-Boot, one example would be OpenWrt's l=
zma-loader:
> > > it has a build mode where the <100KiB binary is padded to 1MiB (I may=
 be
> > > remembering the exact numbers wrong) before compression to force a ca=
che
> > > writeback during decompression (to work around ancient U-Boot version=
s that did
> > > not implement cache handling correctly.)
> > >
> > > Specifically the case of kernel_noload would usually be used with EFI
> > > applications, for which additional loaders (shim, systemd-boot, ...) =
are quite
> > > common. The combination with FIT and compression is probably less com=
mon...
> > >
> > > Nonetheless, I think a principled fix is preferable - I like the EFI-=
in-FIT
> > > approach a lot (we may make that the default setup in our TQ-Systems =
standard
> > > BSPs in the future), thus I would like the feature to be well-support=
ed and
> > > without known bugs.
> >
> > Thanks for explaining. My concern, now that I've put it through a wider
> > test, is that of about 1550 platforms, 1297 grow under this as-is. Of
> > those, ~375 grow by around 400 bytes (380 is average, a few go higher).
> > The rest are around 170 bytes. This is all presumably the difference
> > between gzip only and gzip+others (with the few much high growth being
> > all algorithms).
> >
> > Maybe a question here is, haven't we already validated the compression
> > header, and so don't need to do it a second time? If we really can't
> > live with a good enough heuristic, we need to work the size growth as
> > this is very much not an opt-in feature.
>
> Given these comments I'm going to hold off reviewing this series. I
> agree that getting the real uncompressed size is a nice idea, but if
> it is too expensive in terms of code size, then we might be better to
> stick with what we have. Another options is to write the uncompressed
> size as a property in the FIT image.

Thanks Simon, I think a FIT property is an attractive option,
especially for the EFI-in-FIT case that motivated this: the boot-side
cost becomes a single property read, the ITS author or build system
already knows the uncompressed size so nothing needs to parse the
stream anywhere, it works even for formats whose streams carry no
size field, and images without the property simply keep the current
8x fallback. The trade-offs are that it needs a binding addition plus
image-generation support, only images that carry the property
benefit, and the legacy uImage form of kernel_noload stays on the
heuristic (which is probably acceptable). The property value would
still need the CONFIG_SYS_BOOTM_LEN cap before allocating, same as a
header value.

To Tom's earlier question about validating the header twice: the
value is used only as an allocation hint. bootm performs only the
format-specific parsing needed to obtain the size, caps it at
CONFIG_SYS_BOOTM_LEN, and the decompressor remains authoritative for
validating and decoding the stream. But I agree the property answers
that concern even more directly, since bootm then reads nothing from
the stream at all.

On the size growth, since that was the blocker: I reworked the v1
implementation into per-format helpers that are only compiled when
the matching decompressor is enabled, and re-ran the world build
(all 1550 defconfigs, v1 and the rework applied to the same base
commit). Median growth on changed boards drops from +160 to +96
bytes, the 856 gzip-only boards go from +112 to +80, boards without
any of the formats go from +108 to zero, and 1222 of 1496 comparable
boards end up smaller than with v1. Tom, the "few go higher"
outliers in your run should be the binutils Cortex-A53 erratum
843419 workaround: each triggered veneer is padded to a full 4 KiB
page, and any few-hundred-byte change re-rolls which arm64 boards
gain or lose one, so those jumps are not code from the patch itself.

So from my side both directions are workable:

  - if the reworked cost is acceptable, I can post it as v2, split
    per format so any individual decompressor can be dropped;
  - if the property route is preferred, I am happy to prototype that
    instead (binding plus the bootm side, with the 8x fallback for
    images without the property) and hold the rework.

The two also compose rather than conflict: with both in place bootm
would prefer the property, then the stream header, then the 8x
fallback, so picking one now does not rule out adding the other
later. I have not listed the combination as a third option only
because its boot-side cost is the sum of the two, so it becomes
interesting once the header cost itself is judged acceptable.

Which would you prefer?

>
> Regards,
> Simon

Regards,
Aristo
