Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1A5C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 21:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA9FF6074D;
	Mon, 20 Jul 2026 21:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DNhHYSkinXqY; Mon, 20 Jul 2026 21:09:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D19060744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784581746;
	bh=PEm8fW7f/vIa2EFRfMUPbAKn0H9PJGLiRQYFeTpxvio=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sbKwB/L0r1eF2EOzPUiP/DNltzEUCaHfWCs4RJsccbgv6WnUnYAvUQ7c6Odh4+VHL
	 30VurXEFlYhgsl/jvwONeVprP36eFU9AVOh3jBNKGt+6pD7xSKwETseuWHWnB6PA+z
	 R9zOTu8VW5GPXejjC4A66evQuBZBZnmPks7iOBtu/lzzLCkmfi46dlt2Qd5qxxjW7f
	 ABwp9Ecke2U5ss9e473Moi5246sEWWV4ma3S0YmtdeQ3sulcvdxZwu8ijRNdjX/d6S
	 J+D0GAqVM2bOF0g35GokHX0QAVUg5cHUMKKRz9cneP5uX1ipIzhhWC+KAZDki3AWMf
	 Zo2FM4EKgbwBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D19060744;
	Mon, 20 Jul 2026 21:09:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 220AE224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 21:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F39FB60749
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 21:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRt2vEHjEb0d for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 21:09:03 +0000 (UTC)
X-Greylist: delayed 498 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 21:09:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ABE6960741
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABE6960741
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABE6960741
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 21:09:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23824842FC; Mon, 20 Jul 2026 23:00:40 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E3DA82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 23:00:38 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so12052829a12.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 14:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784581237; cv=none;
 d=google.com; s=arc-20260327;
 b=iG1naZ4nNeva9TZ3yVn4M++AL8zYf6f8LFNPzDDhx4I6O8LG4KHDhaeMixHxFvWc6x
 qCrkuMRIJ/LQhlHG/6f8RdlOlHf7E1df6DOa4BAcpQBN6QkLarwYVerpnOCQAoKiXeGs
 a4La3cmxXjNzKzYSdBrregb9beQzzVH7qzYH1R69+ZsqxBySygujBwPzoUX91mXaguiX
 kRz91mEkD29isVgCFiC4eBVnLyM6V6HPpKQ56Z+71zqMlnXJPnUsK2efh97VpopSAOsE
 igTCEM0TEPQ27uZjxV6woz5m1okrRvGSVjTVvw6Jv1RtSvErvecIZTAB1OGcSxst6xdV
 jkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PEm8fW7f/vIa2EFRfMUPbAKn0H9PJGLiRQYFeTpxvio=;
 fh=D0gWoIBIo6lVyCFYh7Ujoo8MbeKqngFavKH6GAvjvpA=;
 b=Prx8/M5ePSPVDy9wZViQ7ojx4lhRkNTyrqL9LpnixB2YdSavRvpo2XZrluxDiWt9k6
 NMtUR/r1OiYEyPyFZIPZBX+UvsxhlciVMQTVaQNlasuyR/yv/Ce+Svfic2RnhOB5ie4O
 pqSyZqYwvDKhQX9ZKfm+HmuGcA1C7VMnKoFiZSjJ5Bu5GnnSdaK5PE4386shY9DHd/f9
 DBbucYJA4Y0mkyA84KZQr5LN5uEgnR3e1H72khrCVL9aa/t8T4V5lWuRWbhEdciLzqfc
 ofUMECEUHGVuw23SUyUOdsAOTFrEewc0rvH6jlKJOMw+Gwu96ZBea9hxMUfEHSKI+LAT
 0amQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581237; x=1785186037;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PEm8fW7f/vIa2EFRfMUPbAKn0H9PJGLiRQYFeTpxvio=;
 b=AaT23w54CZ4kPbRVTB9prxiJa490nviU7cKOaWNztJRnyhL9VVIakvh01iXtqNwVi2
 r+UEC7WsaOZHchGHrge975O4c2AaHQGdj7f9FWq6T3PtvXbdjQhlYFud43wRBGt4tf41
 gfYknxr+yIR5tB8ZetHHPYn32IJJ+MaZivKno7VS97eb7kAU9RnnY3tBx98FBUvLk7Ya
 O71RGaVuv/9iON3qh+gvg1JkdcysJgvh5G0F4Wm9zppCFFIVoZZoGFtvwTcJASOHDp83
 3VyMMCk38juesdaNnFb+um2WnOAtfhscc16OOwRkd3AXpueTIe5iCos4kC9FzrqLPgdn
 KnrQ==
X-Gm-Message-State: AOJu0Ywkb1Yz7yDwiwSKxluvR4Rys1xe1zR9ryfznBEn6MOV3tGicZD/
 UbQK42hw3RtuYO5vQHJ07u/oa6R/NHGNjEyEUXH2xmTTKcxv3uzVbBWdhKfBO5/Izu56NBeosag
 N6FfzJc8XRPJk1tKdS6nMJhjUwaOlzH0=
X-Gm-Gg: AR+sD1024x0wLFLvo2J7L54Q/tZNAiS1hEXD7NF2eqWGvQmtOrnr5HAlNRzebPJO9dZ
 gxM2u7ZkTSeCyWTX2n6xEVKzRtyn2uXyidKuZL3a67wrNaEDFpkp+7g+jtvNbcdM9hDbj9qkE1t
 cSB47TPwjfwJ+CsPOmq1KRoePzaSqH+AZtUcHOutH+KSBFJk1Ioal1En3+wNOW3lq0i1qasj7nE
 SSsgR1G/uDK8liBDsypaCbZhA40XDVXzcBcEz4QRe9iz31QHoeraQekP3uXzT7XzKs/5bUGGAlN
 hXwgTNIFnXWh1ThSwcmtW0QNAy4sKXoo45b3M8NHnWfpHefN97WgoooBfsyKQP39+lIPYzqB2jx
 0
X-Received: by 2002:a05:6402:234f:b0:698:3b7b:e48b with SMTP id
 4fb4d7f45d1cf-69e652f8f0bmr5487604a12.33.1784581237275; Mon, 20 Jul 2026
 14:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260703214005.3818185-1-james.hilliard1@gmail.com>
 <CAFLszTgmYkj+kWMkoP89Unv3DYeET+o2OTMk_yTwHnTfDr75Nw@mail.gmail.com>
In-Reply-To: <CAFLszTgmYkj+kWMkoP89Unv3DYeET+o2OTMk_yTwHnTfDr75Nw@mail.gmail.com>
Date: Mon, 20 Jul 2026 15:00:24 -0600
X-Gm-Features: AUfX_mw00doUCeOOhsb_E36TjenlM9zZaPkatiCbAcpUPEoSCpFLiC-Mnzcqv4o
Message-ID: <CADvTj4p_tv82VdAwa75SKKkYm-7AH2nXpo=qRg+YUTEahv08bw@mail.gmail.com>
Subject: Re: [PATCH] lib: ecdsa: use .key extension for keydir keys
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lucas Dietrich <ld.adecy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784581237; x=1785186037; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PEm8fW7f/vIa2EFRfMUPbAKn0H9PJGLiRQYFeTpxvio=;
 b=pcq9mgc1MzXLHxkCzyPDDjRMF/uX5Ebn2JOSSwld79epnqvj7LH5jFw3BKbRVTUVkS
 NKE46vPQcBvgCzTbgqcDlJLwqTIWG/0tK364yh+Jy1F82NLGeHdGTmyoiX8FNVdpZcSC
 gQnHAdBCIbHrDa2qUraaqMsQQKrFnCsz88dfEEwXNXHMxWvlsYDc/eEjCYst0wmGOdoU
 YVpheMlBbcLDVlKGEQGILqW3IGVgKvQtmFAGkOfRzXKqOLaI5RDlxZAMkPabWFGDcTvM
 WN0YRYpgF5c30zOTWmz5ZZsrUXwdcH/LEzSTR/VrAqN5DRWreg1UU8nZFzaDBPJdb0NF
 s2FQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pcq9mgc1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=james.hilliard1@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pcq9mgc1"; 
 dkim-atps=neutral
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
From: James Hilliard via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: James Hilliard <james.hilliard1@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 12:22=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi James,
>
> On 2026-07-03T21:40:03, James Hilliard <james.hilliard1@gmail.com> wrote:
> > lib: ecdsa: use .key extension for keydir keys
> >
> > The keydir/keyname path should follow the FIT signing key convention an=
d
> > read <key-name-hint>.key. Using .pem here is incorrect and does not mat=
ch
> > the filenames used by mkimage and binman key-directory flows.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > lib/ecdsa/ecdsa-libcrypto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > Using .pem here is incorrect and does not match
> > the filenames used by mkimage and binman key-directory flows.
>
> Not quite - this has been the ECDSA behaviour since 2021 (commit
> eb22759e2be). It is inconsistent with the RSA path in
> rsa_get_priv_key() and binman's fit etype (which look for
> '<hint>.key'), but not incorrect as such. Anyone signing with 'mkimage
> -k <keydir>' and ECDSA today has keys named '<hint>.pem' and this
> patch silently breaks them. Please can you mention the compatibility
> impact in the commit message, rather than describing it as a straight
> bug fix?

Yeah, I can add something like that.

>
> > diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> > @@ -338,7 +338,7 @@ static int prepare_ctx(struct signer *ctx, const st=
ruct image_sign_info *info)
> > -             snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
> > +             snprintf(kname, sizeof(kname), "%s/%s.key", info->keydir,
> >                        info->keyname);
>
> Given the existing users, I suspect this should try
> '<keydir>/<keyname>.key' first and fall back to .pem if the file does
> not exist, perhaps with a deprecation warning. That gives people a
> migration path instead of an abrupt failure. What do you think?

I figured people were passing the full keyfile rather than the key
directory for ecdsa, if that's the case(since binman is kinda broken
with the current naming) then I figure should be safe enough to just
fix this. I don't think ecdsa signing is particularly common in general
so this would be a fairly rare issue. I can re-spin with fallback or
warning if you think that really is necessary but since the failure isn't
silent it should be easy/obvious enough to fix if someone does run
into the error. Let me know what you think.

>
> BTW test/py/tests/test_fit_ecdsa.py only exercises the keyfile path,
> so neither extension is covered by tests - it would be good to extend
> it to use keydir so this does not regress again.
>
> Regards,
> Simon
