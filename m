Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A24BC88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 000FC60841;
	Fri, 18 Sep 2026 06:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1THTS1QRNRV; Fri, 18 Sep 2026 06:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4029A60860
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714667;
	b=FOMrEKNPG6pMLlyRgIBTYPxGF4/xnnXfDysAmzX72MoS91rbo80CUb00YjBfsnYAdcei
	 ej3TsD6lz0lmAmAnD5vdEr94CWo4tZbBMTcdxCjJPPnU/VQPTsYgxWguUEkT3bla7HcXk
	 CAP7rhGXbgmFqDaA53+fNiVzrndSi+BiUnZDYWEOH9/zyOdwXz4xqLuvfPp+M2un2T2zE
	 GtqGsBIZRY1YZiob4MS3r6iKlbsACXTHM7YIlIilnmIsLUE07hKphgcImKrbm4t9/72HS
	 CQnhUXgD57SP8bGW6tOj630GUsZBwa33XhcKWv70rTVydHbLZu/alhzPU4BoILfxZ7A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789714667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
	b=MlXb/zpKU1JpshfN1cyqxVK4Is/2szaHS26YUPIQfjY39JON5uWe4zKmKst5/Q4ZKqpR
	 wRxLfWmkwUQdu2VTXFoTz3HgtzK9Jp/M8KX6xE9kT1RjDZJSm4R2gWClkOgkQ0Rtj4AGQ
	 j0kr+9pOm7RoILUcHagk177cG6DTCZQkagox94h0WKxZEYfJRWrn4mi8LtehuYQz+9uYT
	 o6OSKpiiMXKUhhSaFCikcoEG8oX0KxwwDiHKrqu8HkW7pwpZ/1JfnJho1oHFQGrXCry7f
	 YatoKJ7s0yE6qq5giy+FnyjJ5g+3g38fO3wgn4bxuJLsD4b6z0PuGaHtvZMry8jmdUQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=7k0IdFUP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789714667;
	bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aklyEPXydsvAHX/R53NadivEOYSvv0FL8tSH+fY8sjxwHKW+XuhKI9Z79WzUGRlHr
	 2+ZFZ69hDlgqSI6Su/F5iUUY6Hs9w4mJ8OxSUe+1/+/izC+eedRWbHLiT+WzHWwc8a
	 n5b/oZqOWC8fwCVOTJbvH5XbKQUlATmrjXiyxZ+uwvgrnWoBk/VaEyQhk7lOKH4b+w
	 6arDn0W1H8Pm2DBzOqm3ohft4+XTSNN5nWSoLKhcmOyl6iUanLMei8HM+aQ/mKVlyH
	 ZqeJiHP5TdpeQxtlzUvICkhaZPy517A3JQdPHRylqQyXtxNP2E3wS3uy6g83jqb4SY
	 9AJoL29EMhQ6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4029A60860;
	Fri, 18 Sep 2026 06:57:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB5F03AF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A102F60860
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id POkXiKEn6HKM for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FE6060841
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714665;
 b=BTiWJ14/k8schruAEgdUKynZrLu0CpxM2N5ntwwi03sd7qRCUs4gFWNXPVJPsW9on80F
 /2/Fzlk5oWxohAegyggWM1iHG5JM7R/H8jnDiG+D8+jSH9ryN9kPxwbg5BM9bKlKslKUZ
 JJeuZ3CwAXBWYmP/MucqSTI22P7Bfu7YsC3+Ms7nSROcLxfueL7Ai7VsZCgsofpg1jm1+
 hOjjWjO14O6lpDDTmNHHJZCMRRfjPH+ThxW/dYhfIlhSl+eazKKWR/4et8YsKIOumha6j
 udf0TPmnRtwcEcS/PJBLHHCWHGLfppnhH6z0i/XtpEgtg1ZkDq8JGL26j5IcB60HIaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789714665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
 b=T7p7jHu1XWpOI/tSE7d7jIlOWeIKpN2qch4zpozLZ7Qzj8ob8ryghEDWwgItFhv8OTr0
 CpOx8lTPRBXymToYEjyUxAIt21YJspoK1ciAdkTNJQVN1P0tR0TbjeUmkBwYDNYVNF3kz
 A8tYWswtutvpOzif2wca/VFp5xGm/wI+28rpAozOYjAwqOJve7ZF39iX7paTaJmoUm2Q+
 u+Qf+/pohlMlxdMt9i+fSFCtX9yYDgQAHcTBe/LDORC6Cbr50PtbSJeoYIfFNfCxds6iN
 VUK2cVboSHLqGKU0hiZM8Oy+MS+okvVVjF3oxCEc64o09ft6jEmZDPdR4x9W9WO3Yag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=7k0IdFUP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=7k0IdFUP
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FE6060841
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:57:44 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c293c683202so50607166b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789714662; cv=none;
 d=google.com; s=arc-20260327;
 b=jHVV9L6Nc1iJuzVmb1U9Bw3Mmf9Y0Un2MljWGTvh1ClwWiUuPqDUtn18oMrglNZovK
 48OYj+HdhXo63VD6y+kThaypklBAQAKgGeocVs8N+f5tg7k8IhUPeA8418ejgm8dcbz0
 Ita68n9DAOae0Sg1kMklD8JES5KuMv9AknhLvrALMxjIEvkPWWZCWrWjAamJ7DA08fAj
 awjnpJLqjzPp7Z2XV1pvUgdrWrN4doIvooJDGOTYqguTRfC7umFEoS+rhPSRYATOChzU
 HnuWw3n77drgGv5JSVkr8O4Rv6uyTXs8+BsgVHnfcoTrcA/RdZbIjVI9fu1LqmYS+J4x
 /DLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
 fh=WZHfgUaukd1yK7Jm6ESjxS1kgrsDM1WiddstkLrJDUQ=;
 b=Sa25TWQc1681k5ib68xaGCg9/PRp9Qldpuk2cxcACVMeqxvsv86RufXmO7KoneNgQG
 AWkbuL2bwLdPY2/Rqx/4dE34o61SrDU/A5AZPDRzSnkWGkaaK2+vX1RsQaHHxYpsNDLK
 Iokp7grCDznN+cYlImFIM/pLcgQmYW1w20zgcs4iJcTi3+WLG1ODeGQxWefJiGtQ4tFs
 mImMN3lbK/ttNJZMG6KZ6pDjlCHaO97J8APHtf4syoo2If5LxXyBYmxrw4UmQFXlMXA6
 rVsNiZ1mFkx4CgXwqh5DsJZSGJZ9u2C50Vs9xcBfHIaP0njiXqhf89K8MQVKCUQXMxoI
 6XMA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789714662; x=1790319462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
 b=7k0IdFUPlbaJsF4xbNPSsiIVzpCeLPBm2E2HfNEWNoqf9hK0UKsLEk/fP8M0PNA15i
 ys0FLGHiZdY8+JrzM6WDoFomsrja4H0Lb1nFRZZ/xpQ1aG1NuSuyfKw3XEb55LCarX9+
 6n23U9Mw0XViY4Y/ArMRUrWEu3CI6NbYqu6PFW7RFvDBmJ6uwwk2C8VkhTuXj/qxlrai
 9kW5RUmjwRsexR04NKr1gbT6wnOnFRud2SDVMGyGkW5ECLy2VJjfime4QAefi9+DeGM3
 fkSLpnLsSvNXEi9+3ARWTOPiuEub9sW9+6TYSjvaf+9DzVkSTc4zh9eBAyYPZPVadNpK
 XjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789714662; x=1790319462;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VrOcKIy00u2AoOIcjclDX/5s20YA0sTBHOWRyaxnUvc=;
 b=nUCs07tUnaQav5IkCxzZ3LuNMyv8ep4H0zqydZWICukmcnFbWXNQ4iRppaDjZDcKjX
 BF3M1u7BtXxd5GUrIWFGZCXDPrwd7Ff1ALgRu22xQobkgcUkPvQKplm47ZkSBfrxK9Vg
 3DV1MIcMTLDnBiSFW5DkCrykqKyMwMQCfnikw3CQGT2TT0BN6Hndg/4CdpdmGv6mTfn6
 eIV+OiTZZ1PMI8OqScEcxuU5jn2iUZWVbmN/olG+4QMraYTx26g+N7jWYp/55nrHoIRJ
 O7UMz487wxmt8ln7F143zwSc6Gq9x/z23icKV63Nu8yu3aQZeRK9DmuguOBCLtHUbfSc
 Z/Xw==
X-Gm-Message-State: AFuF++nXKm53LeephLpMzDi+uiri7rfmk4dkEAGAfE6N4dfx1WGfS3f+
 /WiSUEnd1CR+BNlqmOZOW19+t7i5FoBOj4WrRRRa0YoZvn0TcrAfTXty10JnZJgpiElxatRiq2O
 fUTQwBSl2IHdEhwRaawyqC1ten7dG5mUhF7GSr6P51Q==
X-Gm-Gg: AYBFou28Ccqr0wXpPQelEp7hb19j1ZVEky5QObpKf83ajux0dOdEYxmyBrdRh537IHg
 6yJFfhaxFpeJvzwZPCb5MiN7u/AkF2U6x1Pmr9/b8hQ59+DVEiHrcoItR9T+WxMdYYVhL8mZxlJ
 C0JOHo5cSZRWNp7jfNBtF5w4RAwJOeiBbNIULgNDiL5pdsLDDX3BBElsuORDUXjOqvxPp2vTZQs
 A5d2M2Wl8RPd+9GujkO5Rf+WjjGR7XCDHmYiRoIaDIpuQuFY0RUsMtIIGKsukoS2dN/Y9o83LCL
 UJ/aZqEmmpimmZouV3XnOhfB5ZJ63b5DBmCUw8S6zgKlrXgTjgKyqPipYW10Kp9nv4cfVM1a6Jb
 cfMMdS10V4wY7Ia7ytRRSMXM=
X-Received: by 2002:a17:907:3cc4:b0:c26:19de:9ad1 with SMTP id
 a640c23a62f3a-c2a15e53c92mr160584066b.41.1789714661984; Thu, 17 Sep 2026
 23:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-4-7985ac56ee9e@flipper.net>
 <20260917195251.GM858934@bill-the-cat>
In-Reply-To: <20260917195251.GM858934@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:57:33 +0400
X-Gm-Features: AcwNN1WxekZ51ks_Fv4HoIY5ocfzS7ZvZiQbMkiuqidKhzlSPZhDXcDNo1z6c5w
Message-ID: <CAKTNdwH1co27+N2PX_DW76U7Qx6zbP9O0aMXm_7aA25DL=O=GQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] lib: Track whether a phase has a decompressor
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

On Thu, Sep 17, 2026 at 11:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Sep 17, 2026 at 06:02:25PM +0400, Alexey Charkov wrote:
>
> > spl_decompression_enabled() names the two algorithms SPL happened to
> > support, so every algorithm added to image_decomp() requires editing th=
e
> > header. It also asks about CONFIG_SPL_* from a header included in every
> > phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about th=
e
> > wrong phase.
> >
> > Add a hidden per-phase symbol selected by any of the compression
> > algorithms and ask about that instead, which also matches how
> > image_decomp() gates its own cases.
> >
> > SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  include/spl.h |  6 +++---
> >  lib/Kconfig   | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/spl.h b/include/spl.h
> > index 8a9f799f192a..50b41a3a3908 100644
> > --- a/include/spl.h
> > +++ b/include/spl.h
> > @@ -1204,13 +1204,13 @@ int spl_load_fit_image(struct spl_image_info *s=
pl_image,
> >                      const struct legacy_img_hdr *header);
> >
> >  /*
> > - * spl_decompression_enabled() - check decompression support is enable=
d for SPL build
> > + * spl_decompression_enabled() - check decompression support is enable=
d for this phase
> >   *
> > - * Returns  true  if decompression support is enabled, else False
> > + * Returns  true  if any decompression algorithm is enabled, else Fals=
e
> >   */
> >  static inline bool spl_decompression_enabled(void)
> >  {
> > -     return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA)=
;
> > +     return CONFIG_IS_ENABLED(DECOMPRESSION);
> >  }
> >
>
> Is this build time check really required, or shouldn't the callers fail
> out appropriately already?

The build time check keeps the size at bay. At first I tried dropping
the conditional altogether, but it then caused the decompression
helpers (like the image header parsing function) to be compiled in
even on boards with no compression enabled, and several of them
overflowed their SRAM size by ~500 bytes.

I guess I could either inline this Kconfig check into the callers and
drop this indirection from the header - now that it's a one-liner
anyway - or try and introduce a compile-time short-circuit path in the
decompression helper functions themselves for the !DECOMPRESSION case.
Do you have any preference?

Best regards,
Alexey
