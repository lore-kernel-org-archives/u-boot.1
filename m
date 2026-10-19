Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56115606A31B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WDx+Ce/N;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G3Mk2Wv9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3072580F0E;
	Mon, 19 Oct 2026 17:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuCrgiVbPlNP; Mon, 19 Oct 2026 17:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CCD380EA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429486;
	b=JQnaPYe6PRfct8/dBk/33ZitYW7hIkAgsj4/ZRzZHc9pHiaG2Bz8Tl+K/Yb/+CWG/VW3
	 r59gSWolNvBpVeV9K0B9tnm6Mw6C0CcImS7fT2/iowyLZLW4tk7GHEvPXXv0l5ojvqxMM
	 bZXEDw9MVlgAMLyVQoLVJEEHZh4ejbBtGh5PGUiZ/aWQXk14p0bi8J960AdwNQgVq1GWr
	 C94jZn3viTvyHUPU1vkDG1FhcNXdPsGBu8JjuMO/JpvGoIOrSIBx7XyaL25/z91Uxis8p
	 GEwH0JbqMk9xSyst3RxSHUWU5BIndxzTSSbJp9PNjdAalpNZnpYUlB5Wdy/MwUrfU0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
	b=Nc+Dj+GhYjCq3IHTBR4sq3R/uEEgd/OUiVMzKs5CWjbJ4Qt9aAgVniIpvhenWtQYOxpc
	 acW3DuFG982p39KUjQhnJ0fxMEyQJhFc+ymDnNEvEEYPzRj8jTjwjKAqA22ooE7oLGSrm
	 BizHsUlUus/ogVEHrzpZGrYt9LWIcTIaZu+ga7RmfWiywRnYY/JKOxQY6uFQ6FrllHuA4
	 yx1mDAJZgQ9KM7A4KWduDq0Pt/6ts+BLzoybx0feqYlSqd/up2g+H6ldHfFd1NSaQc2sT
	 AhJJLUDqdmffeVRmoLYJBmeYB+j5pQtJR/X8r69YM5OnMH4bxZaXEHMsCV+XZyodW5A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429486;
	bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WDx+Ce/NEj9CRdGOJVuqnb9cqT9IDquVnL+sRG/NmzlqMqiq+CPMQqRWn1iaKd0+f
	 xMVqXmo6FA1dYU+6B63hMScMRUapPoCoXRqXfwOGvXwvRi9tmjq96x5h1ycGTuYgry
	 DxV3wTBIdnTv/TrRWJWPfGOOL8EhBmV7iQtJetmJN/WL1o9AZ1zJi6mtgEQ6mN4FRf
	 gejRCU6Wl25kB1alNvca/uE6HM67VoaPpPlDsxoYMhOqfHKdG2I2lKn9fo1JVJjEP1
	 Q3tvul+BnLwLfQsHcpX4h2+o79N2V1b/1QTp+MDwjW3kbcrAd+K9RjEZw9ad04gNu4
	 afm3+YIVlEaxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CCD380EA3;
	Mon, 19 Oct 2026 17:04:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 713E734E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56C4A40179
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8ewUtJmUhzM for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A2F5B400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429482;
 b=hN1fJTPMw0cZsnORROdZxlDU01C4mDYyGxAONMZeNeVpUIXDNKtzrqUnqaVbYiGUJDFI
 AZ6a3QtsBVRckCobT9LQ6w8QL9e2315h8pe46C0VqPkVp9nvErymVA/cgSpNa0NnThn5w
 +WfFeDs/RwLoiHgM8sGvS5ToCPdBXIa2COpdcpMbwgqiI2V3V3wSB7IlRAMzri8H0dqHh
 +WxejldGeyhTBNGZy/7B7AFl7HW6xdlOgBrMZUQ97iH239Zwf4KSK3CRQrCDPNTSBEdpX
 xZoI+U/jNzr+8xtUYqzPb+fzro9ia3TPEI4XX341fGCW+sh1oxAx69HThicJ/y3UQtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429482;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
 b=ihRRT1py2ZrubxVmKh5eY7ZvIjMNIzuKUecWl+26sO1am5880xy0MiiN1fYNUeomAdYi
 5L1UC0KWrjvQlAMpYxL5Lw2oLAPfxXA32dHOLVpXJ8qAOl1rOfT0jv9RbcMPdu9CiFqDX
 nRM68/J1DAgiVzLyvcx46BgWu40t4ZwEtZA8uKrnDt8glZtJyB9mkIOfWUc7/L/v/RwJQ
 IKJ2Ev+p1v1Ou+jarZR+OfcyUdfbH2NXx0LugG/soh4aurIb6G/yIxRs4pvemXhiWBXFi
 OcyjedQHdeRM4+JSGTCB85yloknqYY/MwNDnn1WjgewQ2LTHNqD0n0zYa13YXrQQCEA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G3Mk2Wv9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=G3Mk2Wv9
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2F5B400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:41 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ad2b3b1c02so830223a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429481; cv=none;
 d=google.com; s=arc-20260327;
 b=X+slgmjJ/wNMlFmmpXcGyxQqRvI6S0PNknxuAMDFLBeqdUCb2+xovjBEs8g1TX+Vnm
 dR5N8QjlcQ6/mqDVEU1kUVFucjlFpckHOKRJFj1aS6ozXerMAPPzjZ3pMC0KogkwTHdM
 wRPgxWGj5+6DavTWTKWYUn6ppX9s3zxcnpXwXth1ZPmPJMVpCQpOdGFOedOVQtCTPkTq
 GXXPYZMyU+IpxpD0Sb+AIDjBr+GiIDcTJ4CrE13I7+SX0oNjtLf/fDwafBWAq2kZa556
 0QbbGPVFQO7ijzgrPFhLbcuevHKJdbfXbJTs3aQgLyejZzE2Q7WB+ZF+mHMV5BV91Jqu
 eFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
 fh=ap/DPoaJXtWLitaouYIL+MlV9taUVtpp1u5jcjYgzho=;
 b=mSw2/uAE1ATcNQEY4dUEJ1kdn4EIKarpVqsnoaZyJkiG3dOSpAVtmi1v+Prepc3yhH
 fPmte+4zlFbZHHMMYkKUnNWSb0VZtW12dALwNyTGfi9GAnWI4w7lu3OtpHjDGYmGqKv1
 AtMNVEBM9hN6ts8OHSgmOHNyWTuAbsDjUJNF4cDJ6gzrMZZrk0+wOSR67VeysWL30n6Z
 Tn42m5FeXh5IAAB9EVhKWtNEz1aoM22l8fpuUJsmytuXQv/pqdVndSHZQpvGJLLObDid
 whJtZOynZ4qxowo8es+bHGXvgeFpjWkqbsb30di6oKOx5qVlUouCPp7pg1VZy/IFqAZS
 ezrg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429481; x=1793034281;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
 b=G3Mk2Wv98/niLCh2MaccK5YRv5w6Jj1sDkoTZUFwa/TAAJv75B/QIfk4JZPe+fnLVh
 54MXuh1k1vqmYmFBfCj4h+ha9dx2MRt/nL+pNRq62hDNdUUULLNreh4/owwOqB/zRXDI
 Ivuai0BK6G+BsAfG9d0DMtwrPBRTR6JzLG1QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429481; x=1793034281;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LGH1mpvS29ROVrwqJuF0igdAYwP2SqmdgKVi618HStg=;
 b=pRKCsjXA/pgpRPJndbubuCLUo1FhVUoemQ10Gu02uqKVEhMluNGPAYt9AUBJy0elBw
 SkQdUIvdIMwO0BeGVy91bLWqpGFCXVDQsmlDnwXyINGTUaMOqBq/EVWivd57geBuiBeF
 0br1F0gPa5e96unElWRRvNeruNoy0sZqetlr/kze0utWYgbqXCVCUNI6d8i/qRmK4Nvt
 0mQEDgBBQYzRQKu6bMzM9igD/hmTUOSgoLnenuf8WLvUOBsWOkRkfJYmMEIgN1P0V4bq
 qTY4YJ3vH6KSonGr4B26ujjA8xysrKGfcjlSSeL1YG/88QUfqTmsodl3gah6bvFX52G7
 O5YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd/28ODmLTz5Xrr2kRCmq+/uLfwzJAYH0TnGhHZXUfcHW5uPxJk8Ey1FXos6lDlmUaeG8mvWE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKMV2std29X7g3yNYNBRRII1IOuWxo/eS/9FK4OtEu+2ioAkj7g
 FH6Yo13RaonNHiYwdy5KTEcitE4oWgu/aWm5DE+Ptjr7hKKmiM/9dvHIyCmNuYquiPWq+GlZbht
 KZauIW3xrlAQlw9HE2amG6j5zHCPK3h0EEEMxfIb3
X-Gm-Gg: AYBFou1LmTeCWY5pz3VXkUN+2pcsGpMBJ+RnIwznutfa5ocEKsZlYSwgFWVehnRrR7I
 094yrIQr3uAH7Z3df2La7R+0A5ZKludDSR30B3SCNspYLxAei4HgSfydy4ALBFBvnO6EYqPcamu
 8cXPgZmXcb9oK0of1ECePeBydTd6a4kTODgkM75JZaJlYwvc0OqPEa2AojFZANIvM7IZgdFo0th
 gvYIAQE6apdOThAH/boBlUWObLeOUMJcaRdV05MrY7q8l0jRtvuUiKGIpbolC2pzE4552AMFDuB
 nxlJorhdVWEQurtUe8pUXM5k5zjTbYbLAxwzC2soUgYcKp8Ja22beDtxgEcnv0Cy
X-Received: by 2002:a17:90b:35c4:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3aceefbe973mr7205679a91.17.1792429481080; Mon, 19 Oct 2026
 10:04:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:04:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:20:20 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-6-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-6-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 10:04:38 -0700
X-Gm-Features: AclHuK9gIYLP16jt8Utfk0F3EGI28bmYcN6pSfFc_JSPHqqfocxNzMRUE3u_svY
Message-ID: <CAFLszTjPA9OcG7x6aCrKR+cLCadkvUOW6stTBa9+=0Y2NMuz7g@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] dm: core: add ofnode_get_alias_seq()
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> dm: core: add ofnode_get_alias_seq()
>
> The sequence number an aliases entry gives a node can only be looked up
> for a device, through dev_read_alias_seq(). A driver that has to know
> the number of a node it does not own, one it reached through a phandle
> for instance, has no livetree call for it and is left with fdtdec.
>
> Move the body of dev_read_alias_seq() to the ofnode level and let both
> of its variants call it. The flat lookup reads the tree the node belongs
> to instead of gd->fdt_blob. The live lookup covered the control tree
> only, as of_alias_scan() builds its table from that tree; a node of
> another tree is now looked up in the /aliases node of its own tree. The
> stem must match the alias exactly, which the previous patch makes the
> flat lookup do as well.
>
> Tests check the lookup on the live and on the flat tree, with a stem
> that is only a prefix of an alias, and on another tree.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
>  arch/sandbox/dts/other.dts |  5 +++++
>  drivers/core/of_access.c   | 42 +++++++++++++++++++++++++++++++++++++++
>  drivers/core/ofnode.c      | 20 +++++++++++++++++++
>  drivers/core/read.c        | 20 ++-----------------
>  include/dm/of_access.h     |  7 +++++--
>  include/dm/ofnode.h        | 16 +++++++++++++++
>  include/dm/read.h          |  8 ++------
>  test/dm/ofnode.c           | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 141 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
