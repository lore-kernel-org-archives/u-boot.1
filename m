Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2565DC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EEF140849;
	Sat, 15 Aug 2026 18:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vg_GWBzItm7K; Sat, 15 Aug 2026 18:33:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3999F40834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786818835;
	bh=tTCFRzXJVIAVd8Xh5jWbFtDcvRP8rSUebKRDqEfOZYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OsCUSms6Bwo7FQkmT4cSFPE0Fln3hwHmF5tFfRLj7AxIpZiwFUI5emj349LIh2b1p
	 GjFJQjdcRP7k7rtiqxFqr3FuNqKtBxXnwzFgNYigauGqqJCCUg0YYKOhc/0crqEke5
	 qBLDZQE4VfXpylTAk0zm8Bp0MSL6eFfZTjM3J7eSS/jb7o70//qHCxM/amL48ljYnF
	 +WeGWYMFvipjdwhCwy7cYH6d3SwRLlphHjvOAJpNyT+76WErPEtIVAE1cPHxA97/Il
	 iERH3wCrmJ5pySF+JUNkEWbzGqh/q5sV66BLkc6zOstJyL8amIl8TFoCRZOzAg3DQb
	 jiTXQfn3mpYHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3999F40834;
	Sat, 15 Aug 2026 18:33:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B3EC336
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38C2380E12
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZeSKRnu7IF7i for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:33:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CFBBD80C44
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFBBD80C44
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jZCr8FpI
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFBBD80C44
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:33:52 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so279050966b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786818830; cv=none;
 d=google.com; s=arc-20260327;
 b=jNFhoUFfIBbNimaODGRzczeATkp/FwnqG9IRNUaeHVprfYthsdQBRCCPIs57LSNbvC
 INBAcXgCxyo1Fbcf2HrbvCb1TU4IZwRI04iNJZ0QiqOaXBlP54SZYWPe5sMCIg1y9F6E
 90KUAhNN9Cc0KTX6XGs8xFlX2yFywJLaDTZEWPKaxQPGlheIXZgQVdM3tvLDYMKT7kCn
 oMYczS4xgOL2aV3BjT4L1spQrzxDfuZN6hAsqQ99qOBor2iQhVUwRptg6Xi13XpAbca2
 qzMNlLzKUuNA6gOAPFNis3k0Z413Fo9hQzZPb8LVh4k4drHkU1M5EduPtTw6N3rD96cB
 Pt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tTCFRzXJVIAVd8Xh5jWbFtDcvRP8rSUebKRDqEfOZYI=;
 fh=K04EaKhrKBZQX26quPlAJHG8NSEHuoNsf4q+xbBIZio=;
 b=Y+W4wxdLzONSCYm0S5g0+U1+4b/haz6pxD1bAtTj7Kph3FCutMAm+8JPRxsQIyIby6
 dxiKyvOkWulmgiQVaSPlNjsKu8+zcsLSMWECw1wsw0qLsL4dvQEXV515VokFmvPL2mPX
 R24w12luoISo7QoFzbDsUdqoUVMpaHIwBehEFSYHXk920eroAPWGrItiaO6Eu7ZSKjmL
 hQMOnzAVhqaPvyufbOyDl/9vRgRYnpWZ0ztkvOHTWRh/wGUrX7MsjVXbQeailnImiw9Q
 33N/hmxjpzpwtjkCpYMaeQjA/8+w2LHkEvyBhGBOZb08++IqpL+i7v7BC7ZmP78k9Krh
 8/5Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786818830; x=1787423630;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tTCFRzXJVIAVd8Xh5jWbFtDcvRP8rSUebKRDqEfOZYI=;
 b=jZCr8FpIBVxXVkY1tCrtZwygHs0ECdIawwlxKIgGnNUoY0EuMB2zO4hpJoYP+BY0PO
 BxUGnaBIwVrbkioHBEDeygc+7ftAwfHj178sf0LKC7o2XyZvvwVrob+JnT6kdksGhmx/
 LpRUV89zuqDKnFkp3hgpUccHMuyuZm6MjIR40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786818830; x=1787423630;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tTCFRzXJVIAVd8Xh5jWbFtDcvRP8rSUebKRDqEfOZYI=;
 b=JMQA/LTZrnHj+m/IhW3+xnyNEqqBxN4zdjshAYhA/U+f6GwxeOZl1rUv5QvuIBkhZU
 ao+bMbF4/dB0RFpzmkO8K5U59L2JmNFrZRl353julXmNtvyGzdO8NuYPSkhvSLYnu614
 nerNhs6hxwHuzpr/OOaDABEMCTr9aEf7RSifrzjWatiBI0Kt5xHVbyR5P6jx6oVttuzd
 kl+tT7sDsQ/nnlqttNSnly1cVetMTMcV/MO4JcwI23O0L3OTvgeJcIPbbwOR+4TbKJxL
 1+MNhgPmQiiGNt21enz68vE9lPISalZ4Urh4C2hDBo3VZbpj89PNVqCnTNWuMcJJWYrG
 gYfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI6pK7N1A8ZsSfuWPLzEraMW+kOm/MN5THfYldBaA1ssTi6FU63lIIONklj/fOZP81qQhR5nM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw5TfnWSNUyhzLuxRTxSmgLdMpwJ7Ec31Pn+sXHvsCFbqWmNei2
 u/ufdW0o3cz08wIqS2T/Lc2DXN2bLTnvgIxXQVrt+trVL+RVf0z6JHVFGrXEVUoxvctFqKZpUmy
 lreyxHj8dkYX1LU34MuShypxZ4XKoAUob//HJ6Nq5
X-Gm-Gg: AR+sD10GPVRpEN2WAqVJ0kH3Eu7BGua8HNt/+rCUdxJ5Loo627i+Ydx0FRLvTalGoWg
 cfHOeHFdNXhLdsvTI/QD23RiQuIbV5fPwjFaYe21yY+RPmK57HzI0mqiglhsyVhvABAXKyI12St
 UpBOIemU08vdSdQ5KGiIWoUJCtLaMjvjWs6r3pI1HA6Teif1p0h59M/QvRmUpYhZdY0KrVnwni/
 bm0BwjsjrhibL9nAx1Fd5bs2bMDxsEWkrva9J+iznWsZTFKGcyUk4pRqxzHDFCweQ3G9sbzIds4
 7vER2T+xFSoX7k6N2VPcBJmSo3WhGexyWFti93Ser5hHOgBcXcB47w==
X-Received: by 2002:a17:906:6a1e:b0:c1c:3b06:ed19 with SMTP id
 a640c23a62f3a-c212a8d6680mr554469166b.31.1786818830476; Sat, 15 Aug 2026
 11:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
 <20260810163728.GB1160436@bill-the-cat>
 <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
 <20260812155750.GB3297518@bill-the-cat>
In-Reply-To: <20260812155750.GB3297518@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:33:38 -0600
X-Gm-Features: AcwNN1VRzHbKvGfAp49FnBOg0tqlI_xjx1ayzUGbjwhIMU37h5bVW-zv2S2S0eE
Message-ID: <CAFLszTiGA3mZZHHTZ5cDD-QqOFRb4AgzDP2it7LEE-4LknHHbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
To: Tom Rini <trini@konsulko.com>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Wed, 12 Aug 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 12, 2026 at 09:45:52AM +0200, Nora Schiffer wrote:
> > On Mon, 2026-08-10 at 10:37 -0600, Tom Rini wrote:
> > > On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> > > > On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> > > > >
> > > > > > For a compressed kernel_noload image, bootm_load_os() allocates=
 a
> > > > > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). =
The 8x
> > > > > > multiplier is a heuristic: it comfortably covers what zstd and =
xz
> > > > > > achieve on real kernels, but any well-compressed payload (say, =
a big
> > > > > > run of zeros) can exceed it and fail decompression, and no fixe=
d
> > > > > > multiplier is safe against arbitrarily compressible input.
> > > > > >
> > > > > > Read the real uncompressed size from the compressor header inst=
ead.
> > > > > > Add a small helper image_decomp_get_uncompressed_size() that re=
turns
> > > > > > the uncompressed size when the format carries one: gzip ISIZE, =
lzma
> > > > > > header uncompressed size, lz4 frame Content_Size when the FLG b=
it is
> > > > > > set, and zstd Frame_Content_Size. Other formats return -EOPNOTS=
UPP.
> > > > > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), cap=
ped at
> > > > > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, =
and
> > > > > > falls back to the 8x heuristic for formats without a size field
> > > > > > (bzip2, lzo, xz) or when the header lacks the size (some lzma o=
r lz4
> > > > > > streams).
> > > > >
> > > > > Have we gotten actual problem reports? This is a good bit of grow=
th for
> > > > > a problem I'm not sure we're seeing. Thanks.
> > > >
> > > > Thanks for the review! Honest answer: no bug report against the
> > > > current 8x multiplier has crossed the list. This is preventive rath=
er
> > > > than reactive, and I should have made that clearer in the cover
> > > > letter.
> > > >
> > > > The reasons for this patch set are:
> > > >   * The multiplier is fundamentally a heuristic. Nora raised the sa=
me
> > > > concern in the v1 round of the earlier
> > > > series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.htm=
l>):
> > > > "Deriving a buffer size from the compressed size is not possible, a=
s
> > > > the compression ratio may be arbitrarily high for data with many
> > > > repetitions (for example ranges of 0x00 or 0xff)."She dropped her
> > > > replacement patch when we bumped 4x to 8x, but the underlying point
> > > > stands: any fixed factor can be defeated by a highly    compressibl=
e
> > > > payload, and further bumps are just moving the ceiling.
> > >
> > > Yeah, I recall this. But we aren't really handling arbitrary data her=
e,
> > > so it's not as much of a valid concern I think, without real examples=
.
> >
> > It's probably not a problem when the OS image is a proper kernel, but i=
f the
> > next image is a tiny loader itself, even a small amount of padding (eit=
her
> > inside the .data section or at the end of the image) might result in hi=
gh
> > compression ratios.
> >
> > While irrelevant for current U-Boot, one example would be OpenWrt's lzm=
a-loader:
> > it has a build mode where the <100KiB binary is padded to 1MiB (I may b=
e
> > remembering the exact numbers wrong) before compression to force a cach=
e
> > writeback during decompression (to work around ancient U-Boot versions =
that did
> > not implement cache handling correctly.)
> >
> > Specifically the case of kernel_noload would usually be used with EFI
> > applications, for which additional loaders (shim, systemd-boot, ...) ar=
e quite
> > common. The combination with FIT and compression is probably less commo=
n...
> >
> > Nonetheless, I think a principled fix is preferable - I like the EFI-in=
-FIT
> > approach a lot (we may make that the default setup in our TQ-Systems st=
andard
> > BSPs in the future), thus I would like the feature to be well-supported=
 and
> > without known bugs.
>
> Thanks for explaining. My concern, now that I've put it through a wider
> test, is that of about 1550 platforms, 1297 grow under this as-is. Of
> those, ~375 grow by around 400 bytes (380 is average, a few go higher).
> The rest are around 170 bytes. This is all presumably the difference
> between gzip only and gzip+others (with the few much high growth being
> all algorithms).
>
> Maybe a question here is, haven't we already validated the compression
> header, and so don't need to do it a second time? If we really can't
> live with a good enough heuristic, we need to work the size growth as
> this is very much not an opt-in feature.

Given these comments I'm going to hold off reviewing this series. I
agree that getting the real uncompressed size is a nice idea, but if
it is too expensive in terms of code size, then we might be better to
stick with what we have. Another options is to write the uncompressed
size as a property in the FIT image.

Regards,
Simon
