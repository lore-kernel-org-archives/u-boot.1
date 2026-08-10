Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B2C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 08:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEE3F4046C;
	Mon, 10 Aug 2026 08:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DoNo5dktfJG; Mon, 10 Aug 2026 08:11:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D435040497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786349494;
	bh=Qp0w6KTyXeXmFy66J/NSP6o31l/8jYg0orG6J3F9JVE=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cdjD56f3FPIUaSHpu0eEpov48dd1xBrO4ImUW9cCnBtSqRj1Hyn5c0Vgxac6OE9AU
	 MpKDNYpdANPi1NQOCvKqT9aHjcwcbdDS6WvRXTg741S2vCPSJGIrz0AX5vaU7bD0w6
	 dbl7vpczVHNCvHyYrQQG0jETUWc8udgvOrpb4Cm/ZSkbKvou57iyG3YV5xNgQ2iKZ/
	 eaoDhrm3SE2Hhl/eg9wNYzx0aJfPtH01gxYHs+FYYtonwEtSEo2I+lYL8Pp9EYGp4h
	 qq7V37w8q7KXr3L1AKQSzKNbmmItW5AYwwKdt/D/2OT/XstHIMYYJvzAGNXvI/dP4B
	 xQ9zIZP4y6rlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D435040497;
	Mon, 10 Aug 2026 08:11:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 682F328A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 02:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65FAF80B00
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 02:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mCb9C7w8Onl for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 02:32:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 184DC8075B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 184DC8075B
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 184DC8075B
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 02:32:28 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59FD03F66A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 02:32:25 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a17c89d8c1so1834518a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 19:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786329145; cv=none;
 d=google.com; s=arc-20260327;
 b=oZxtZhG1+AxM3WICUYAG1GmA1P8Asnsoz9b2Ktylbm/2x3WD/cyIJGt74Rd7UZbH8m
 IIY3dJ+M8SuPYUIYmgrH590iXoGOLfkUt8R9RxDvqIjDRSm9d67dkq38UOiRzNamSW4n
 iEWfz2LTc7FwT3pQDJpuv1ToRjqgITSoPDZjug+0xyMzNeIDADVOJ9qQffY1dJPpsyAm
 31gn9nk1whX1GG3YiE+Uy4xZFbtvLkW84TQ/sCnDtNljYTWUrC8n7Uyurf/N9gP2odtR
 rJ+m8KtOvz9AvAEBW/oEf3srXSESq3odS3j0P6THaGvnmZrNhoD1JVzlBnRxTA1EkUAs
 dPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Qp0w6KTyXeXmFy66J/NSP6o31l/8jYg0orG6J3F9JVE=;
 fh=AnmAzO7Z3KxnsNMxjnA2X+r8QqgD6bIIAkZQ7/1JSaQ=;
 b=H37vsqippeOcsIbwA33tzMvTwzsUyB0s2ULZwUFjLJ0/CXE5bzd9lg5SDNim+z8AsE
 aZE2/lrHQ3nxZ9RTygfdUT4EN5Uim8tlTHAntO7kd2HZ2kHAag36GgLarjMaY+j3xlCT
 OZBItTUcYEUCeSHbLpDl7iXg3sKTI1qBT52DBv1FmY0SzYDc7tFMXw47Z3EWwCXWozsV
 NYumSiWs5AqSl3F/FCTjvNcrwBI7/Su69BXoobxR0eRdffmyuuE20Uw5tD2jOPsrGcOt
 Pblsbh+fnWfPLohKS/AWHbI8GCUP9/mckzdHFGqSdRUASqJXxnFhoAtQWSsG/44Gq+zY
 O6Vw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329145; x=1786933945;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qp0w6KTyXeXmFy66J/NSP6o31l/8jYg0orG6J3F9JVE=;
 b=HxP6rEAhi54ZSoIUcID9D3DBINgwwOcpKFXHCYxoRlrdrshoNsWOd+cnrUINq1aiDI
 K/r01Lki08tn4SPoHuIwO8rXfSRzoN+5F5rP2htNqkUxaMJ3k5CkJygSuU+6xEDn2mUx
 Zoi/0mRp1AKtvX7lJcVeuNN0la1+nvBrZJpenWXQFKV/BDlgcgziPqdpg8g51xG5gltm
 tTNhK3/QJQef6jP3co//GAdSUhft8p8jrY4R28Jlf7ZiJNaPKSIxAQ6bdQaVSqJBWDAz
 iwp1XrdVOCfiIh4Z58Pf20LFGEWScaxL7TyzwxM+ye4eTK47ByuuNN96gLsC8vcoKp8w
 MGrg==
X-Gm-Message-State: AOJu0YyHt655MlDoIXhv3N+oJr19C8U/TfXQVTj9rjwoN8UYkO1BzlB7
 9Y4z6ds01Hi3sTaI6CRJ/iutSJVV1Za874lyLEdNWChWY/7iLUUsGC/7gzeOQbnypG/+9i79aGy
 guoKuA1kQYCM7BUtZpeOopTs0brH0ImN7dyVxy/qVaOfPSAbrdL6e6UVHZqAbZi7jyv8qkBSHgS
 XHILQ6WoLZUpcbLBNTjgGHleiZ4UD10DmxaNigcjNsgJi4elWmz1ysO1HBfUfP
X-Gm-Gg: AR+sD117gKyuow/Fo7F1k59N9RNPJnIart9j7RrZXBImCLsi/3rtuVz8M/G3YYO3X3G
 sQWFAZATxZA8kf1/tUCe2FgfqULcXtHX0lVdngM1ZUHkgd7F5RYQ9L/T+Pt4Vg3fr8n3X7UMfYq
 fCAktv9S0iywavx3ivpsd4eJzLA+MCetRaLuzYvBuc9DSGSAEA3oKWRqiFwg==
X-Received: by 2002:a05:6402:3713:b0:6a0:ca29:1fa4 with SMTP id
 4fb4d7f45d1cf-6a14f13ad5bmr18518766a12.16.1786329144954; 
 Sun, 09 Aug 2026 19:32:24 -0700 (PDT)
X-Received: by 2002:a05:6402:3713:b0:6a0:ca29:1fa4 with SMTP id
 4fb4d7f45d1cf-6a14f13ad5bmr18518742a12.16.1786329144689; Sun, 09 Aug 2026
 19:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
In-Reply-To: <20260809152703.GF394392@bill-the-cat>
Date: Mon, 10 Aug 2026 10:32:12 +0800
X-Gm-Features: AUfX_mxQirm3qftvhzm-q4xXhsFJ_Xh_xpph0j-2_tn-ZScxeGkAo3nPCdzMdcs
Message-ID: <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 08:11:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786329145;
 bh=Qp0w6KTyXeXmFy66J/NSP6o31l/8jYg0orG6J3F9JVE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=C2A5q3aYCqejjxH800YfBax5s9iURtuFezKRFtXsVjku1Rv2VaNTMiDbIYSo4ivhj
 xrWOu98E3ciqGeXaHq8ErHzFI93/PlR1nd2o6nWKN1wjCTzYExK980ToM4hw6SoxRJ
 1uk686MGbfQAaaXcw4eaXH0nmxyyez2YH48xX4y4qVzNGEPI69zEe+oDRsvq6Zyhgs
 wRx9OaIJ/IIypdgZ0UgxI/ghmJ8kjOWA5Q0sr1kkIPtgsd6KMlja0/pzdVmyezsGNP
 LH8nmGfn3z4RQwyG7S1zYmgTZ01DMLPkqMMA7wHeqDqGMsiqeV1V4oym6ap1it+m8j
 +qPGVraQfm/okxgJmV23xGKcQbV02KtAWZzXZgU/zsnFAfl+CIdklKtexM+Q8G7ko+
 QwCLcaXBZYgerx60BQtjh7kXgVPANTrmcx5uXpH5k3L2sk7C4SkLdCjl4IgRQf58dD
 g/hcDRIXL0VlnvIIMlk5NpVl7k7XPEa87QRp9j1G0Jros2MW8w2p2WrCvpfpP8Y1uQ
 BGeBM/PIVckEQzQf+6PUWRwSEsf3y8vpxsXpdHl1J24wkGl2wPeRdnjFvpIUoiiAoD
 Icql22oRGeMwO4mD5Px54BlFm+eqq89vI4BMClph3/L6bmXLo8Pa9sJEnfy1NdJE/Q
 1hGTvMqPWNFihUtTcYMO5Y9k=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=C2A5q3aY
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
>
> > For a compressed kernel_noload image, bootm_load_os() allocates a
> > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The 8x
> > multiplier is a heuristic: it comfortably covers what zstd and xz
> > achieve on real kernels, but any well-compressed payload (say, a big
> > run of zeros) can exceed it and fail decompression, and no fixed
> > multiplier is safe against arbitrarily compressible input.
> >
> > Read the real uncompressed size from the compressor header instead.
> > Add a small helper image_decomp_get_uncompressed_size() that returns
> > the uncompressed size when the format carries one: gzip ISIZE, lzma
> > header uncompressed size, lz4 frame Content_Size when the FLG bit is
> > set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUPP.
> > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), capped at
> > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
> > falls back to the 8x heuristic for formats without a size field
> > (bzip2, lzo, xz) or when the header lacks the size (some lzma or lz4
> > streams).
>
> Have we gotten actual problem reports? This is a good bit of growth for
> a problem I'm not sure we're seeing. Thanks.

Thanks for the review! Honest answer: no bug report against the
current 8x multiplier has crossed the list. This is preventive rather
than reactive, and I should have made that clearer in the cover
letter.

The reasons for this patch set are:
  * The multiplier is fundamentally a heuristic. Nora raised the same
concern in the v1 round of the earlier
series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.html>):
"Deriving a buffer size from the compressed size is not possible, as
the compression ratio may be arbitrarily high for data with many
repetitions (for example ranges of 0x00 or 0xff)."She dropped her
replacement patch when we bumped 4x to 8x, but the underlying point
stands: any fixed factor can be defeated by a highly    compressible
payload, and further bumps are just moving the ceiling.

  * Simon suggested the header-size approach as the principled fix in
the same round (<https://lists.denx.de/pipermail/u-boot/2026-May/620121.htm=
l>):
"It might be worth updating image_decomp() to take a ulong size... I
believe in each case it is also possible to find out the decomp size
by looking at the header."

So the growth buys correctness: the buffer size is derived from the
compressed stream itself, not from a multiplier guess that can be
defeated by any payload with a high enough compression ratio.

That said, I understand the "we're not seeing it" concern. If you
would rather wait for a concrete report, I am happy to drop the series
and re-send when one lands, or to shrink patch 1 to gzip only, which
cuts about 40 lines of parser code. Let me know which you prefer.
>
> --
> Tom

Best Regards,
Aristo
