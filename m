Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30D606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fU5q9bjt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMu5ctmc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93DA44057E;
	Tue, 27 Oct 2026 04:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaXAa8mhv0g7; Tue, 27 Oct 2026 04:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8BDD40575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793075855;
	b=Ehdgk/8Xz5l8TntFhdIYG8PGIWNkk324DIwAb1vNv8t8R2R7eRAYsBj/vvT+meXhyrPE
	 iedsSg0HwT0q22COjaAeXaN+0PeRw6x7joPolYSFddLjg7a6dhebIy6+Bpyksk5utGxTj
	 h/t/UzKAMQkS1P+wXaBllcM346aYIytSrNS+DYtwRMOrsPLF3j2pWcuMzz6Ang+e0FDUH
	 KvbYg3mAyeAXS1wfzKXZ75fvO98yV0F1Qg6kyJzz+ijKZWYCBdvIC53CZZtqMVejo0y/k
	 WbKqMYLeB/6WTixZXFakejzde54OwVVCzIu+XgzT4JBJ+FYms9oso8crSX0BrIjyZAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793075855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
	b=Iogw2UmyeXSOaNRcmHFenOuO6KDPQuVXJ9hqqiUdR8K4pcIklhJOXc5ZcHJQ4Z6IVyy1
	 ZwferXQIoe5zAhb9wkQ7RR6YMowcUPzDpzhSyKzPYLCA+UvVpO0+5LUnuzI5oAlernRlM
	 sE+5CyLff9ni+o76jkrDB9a1bN1SQac7fVw3zRe4FROReUy7Xe+oBNTnp3Gs/dTPsPHze
	 V2WDEO+Cd8zSd1eU+2dX3Rq8Feo/ZFOov8tt6Btpfij68sXTJj6d9FmB3Xqfw3rz4YTyN
	 lrVmNHCrUaoe7bt63PGFYHE7r1ItNHeoahhurPxRvUzFMib+LtaCjQl3l07ouARjfDw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMu5ctmc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793075855;
	bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fU5q9bjt20eaydJhXwazIvk1SjsQRzsIKwQ9L+e4ZRW8sgnGCrOKSIokmQgb8NqXc
	 QMXHuO8UOYd1bDan0xAaR+4EVelQhTUl1p0XiJxOr0XxRqZKnpwXIwvFuSeUsfV6+I
	 a6OWRaZlOWjOWHnoUrZpeGP74vBpk2hO6QaGqWQV+okipMjeFiesMIQox3W92lF325
	 NbxoGL8+CmPfAog1c0lCjd3bPUmX03INJEXmVPslPaBa1RvU1EP6j6CwR0bTRIvYAr
	 8zdXGKYSoDdBc2Z34Ss2GqKJ2kNZYtLtbmFduDOWffNYESBuC+WgpxbqagejizxPqi
	 D4Vp2oCaskeQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8BDD40575;
	Tue, 27 Oct 2026 04:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B64352AC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C1BD40553
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2XX6YscE4fi for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 04:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEEB54055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793074465;
 b=nb2YRKp6DijnxXM3a/tyzzjKklpI1AXEcmlRICubDJVRnCwFGfHk0MNlwSf/zOGpJbya
 kpfCHl9rO89O1Y+ngQzppRFNCuxMTmNOrdbjHLpN6UpLcm4tuM78AzyALFiS1vmf+MOS+
 ZlYCfEmdxnTxvLZRRx4p3aFxtAoX88EHJHlVTR+1lqn1hhUfdbbpXc0RucW8nHCOoc2Q3
 vb0D1OMuUWAeSnFd3OdKeO2hFMt/x+gxJVTZUJhYh/nc2pgfKcEvJeOGkHxDomm6xUUFN
 WyXVzAaHIJsXCowTF3KHdgJqNgaupw+AwwWXHvUC/BAFJj5ne7Zys2Ex/DUrbmuUvIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793074465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
 b=K9lbEXFjo8d6fLKurP8zV4nenGWqCS9/3HHK/BoSLoq/z2NLaBw+ayzblKZX4KwCn67N
 E2p9C3ugC6xdhmDBqC60Bdlbd6t3M98kFSuuEZBILVuKmgbAr8GdhSuVJ+QL1T+hUCQH3
 x94iYp1/+B8+eiwY1auQ+br535dDS6+3KETg6e8JZp6TLyBJXIU1Nxyf9t2Pl7JeZED1r
 kCxgz37sEOwfPHO9W/PmUUFvU1Q3lz6myA0/E1c45pD+xaxKBLVCO4eQ2PyriKJbjQUlV
 qG8hoW6pu6RVQEaMgIsxqX8lm6TFPDQOk6GQqzTx0tYoPMEHuC/NvylEVVs0VgkKftg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NMu5ctmc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NMu5ctmc
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEEB54055A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:14:24 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-84621d8c7aaso1711320a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793074463; cv=none;
 d=google.com; s=arc-20260327;
 b=msWMsegftJufnXpek63FUkALz1j9tPInngs0e2zU6eLABx1Imp65ppknq3QD/xra4W
 3Rxmy74oSqV2ICqNe0N5UA5qcH34A00uNT3dthJCOUEx8CF71LrwRkdRI2RO4+sEPqbi
 5isitsT5Ag6yi+/REoQHeEXJQc0cNDGo1Sos4V1o8HDUPyZ+r8L/5I2VZ3P8gVPRIFju
 8hv9sdq4n4qtKG+kKZEKJSYcLoGyt6KTVtVoZo1HZSrxvYlGFu3UMlZDhBXifP3Qx9Fm
 62VM5M7hh/09v6oyhQRozzFjResjGqgGLKRHO/HQCaRtzj9V4WAzxVD87+qBV7P/g8JT
 4NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
 fh=Lsqw54Dd72DHL3FgaLgE0v9y+X0nG/mU9DtsOf6U5lw=;
 b=nUq3AilNKTTL6msyT6/a4yNE5+rNby11tUdqJEXq5K0WOSCj4iDTfaafl5cfJQ0tp0
 4DBilU0TqA+Ul6sEfpxe3+PcIE8/PSq7jOJIupPlDsjfn2hMgDbiGAgHoufcJ7VISCbz
 qC99IoPqNrKMNxGIalJymPycpzWICh9HOAqcOknOkHC89QseBzLAbvNZEmORpn3owB+4
 M0iwBH77TyGhWaatRBl5ab9M1nBmHT/Sgp78jL4NN9UNn+/ValgEmg78m3auRxkA0pnp
 WH/OCXt7qk9aClyrPwqo+i3bD7fgRnSjT7VjDBzQXr8yr+j2Xh7NOr0yaOsRvRxDmu6r
 Lyfw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793074463; x=1793679263;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
 b=NMu5ctmc/tshLKJdQrLTbEzbnsXV0es2hjSE2K+Mkp7niL4cJ/MZyzfnYrZZPlkthF
 +3Ogw9TL32Xl91QhbclWBZsTmtGHjO9YAcM/jxYtXXyyl6eA/DRuERtW6aS7yuo+XqBZ
 NSADSfR7Wiguz7YTNdY00ayTlNLw8odR2YFa9/DUlrdEZHft4Ehjssom7kajMToxPWh7
 ADWG4jF0dDsT53NbXOaeZHePYylCHB1K/DmtYvL7Y6NWY+a14syUdShqJZ0+KpqcUTUa
 jE2SG1lp2+F79rS2WYJ6tggsSyrDZNWbxFUT8z9Y9nH643KB5LWfeRHblDql6ie/7SxV
 QztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793074463; x=1793679263;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a+A0vyil0hzz8IQUClHmyH+AEH2++Th0apl90OmAnzE=;
 b=HQ4N7YRW3BPLDEfsCYylRSJmp6piLC2eceTdop8n2djgwxPJZI0NTgc44XH8yoObFi
 bj6DTpXNWIMpc0/f8ifbpbtyG9mLgTqZfprVY6IXNuXBgILrgS19aPtHyBAE+M4Q+Lj4
 0G5qtdJC/CU2owzT7ogv7tPlbfA2fZSHJ+5x4VvgIoVsgbY+XanfUU+kFPjV78ZqPCxZ
 LK45qib4QRcs3Bv6oEBxw8e8U4z6seKuF6Kf9dS1wpaQ7A5oBsFoPfGY9MIPFyi8+vg8
 UD42Nk33UFodoqG+cBQgaes0yYYqkdTX4KO8cgJGTDzV94XmkD/qqYnHCkC4dbggSx/V
 Fdig==
X-Gm-Message-State: AFq9FYJqt9jNtshyxRneh7p68fDcEVFqd49hB0DMqF3VwKv/4ZSc7yVL
 LvkIMQCLXYxMYGJ6MgO9J2/WA+po/Ca8iYR6C10/b92XI47m1BOys68xWOWjzvfDEcWZ6FHg4di
 oaBPFIas0fNnoQ7nrJF3idpGyAV4L88Q=
X-Gm-Gg: AYBFou1tbs5GD4Lk34EpJI1BH//RDkxxmZqoRnJynknYPR+Np0dm4lJxF+LtKjt1Dpz
 VziSEL1CYE+lE47kDmfXyRVYltIoAHP7JsNoL6TWJ4NCFT9YjpRcV5o7Ma9YKNyV2sfIAu+Q7wT
 q9tC9FC363SltT5umqGj4HVquxL9XCWRx5cEmpdtxLYGaW6oZKWU7NkGNguhOTUFEufTBiPWBJn
 H1x0Wrco9Gq3SLsWCCbnrwdgVlb7RNZ/IZFoCFMaJsKHjTrmLLq834hVZVynzFSlLob6F1I+/WK
 FGjGqQm6oDXsmQk4yhSh7KCedXfJ/SIJV0O7n16OKfwFtL3UgFL3ZC0hMcUs8N7yOQA9mo5iXt1
 wO10Em6qioxY1O1Y2QqSupikYFhomKn3yf3BEsA==
X-Received: by 2002:a05:6830:270b:b0:81c:5aac:798a with SMTP id
 46e09a7af769-850fe1116a6mr7557160a34.13.1793074463328; Mon, 26 Oct 2026
 21:14:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020174629.24277-1-nimeshacharya197@gmail.com>
 <df378c9c-7609-4fe3-aed9-1967ea137b6b@mailbox.org>
In-Reply-To: <df378c9c-7609-4fe3-aed9-1967ea137b6b@mailbox.org>
From: Nimesh Acharya <nimeshacharya197@gmail.com>
Date: Tue, 27 Oct 2026 09:44:12 +0530
X-Gm-Features: AclHuK9rSkxB1hgWXrF4kDvXS_yDoeuXW0dqTGTXzU6VwypXlRg99JHVzpnivT4
Message-ID: <CAMb=oEbVuTR20CUDT=7Xs6V_sVc-eWfLxwTQPZCYGP=GuVGfPQ@mail.gmail.com>
Subject: Re: [PATCH v3] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Humberto Naves <hsnaves@gmail.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>
Content-Type: multipart/alternative; boundary="000000000000714f3c065ecaaea3"
X-Mailman-Approved-At: Tue, 27 Oct 2026 04:37:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000714f3c065ecaaea3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Oct, 2026, 12:17=E2=80=AFam Marek Vasut, <marek.vasut@mailbox.or=
g> wrote:

> On 10/20/26 7:46 PM, Nimesh Acharya wrote:
> > When using the default meta-intel-fpga configuration in Yocto
> > 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> > U-Boot from the raw a2 partition on the SDMMC device.
>
> This ^ is not relevant for upstream.
>
> Please retest with build outside of OE and with plain
> $ make socfpga_de10_standard_defconfig ; make
>
> Does that also lead to the same issue , and does this patch fix it ?
>
> [...]
>

Im not exactly sure how I would go about testing this. The results depend
on where the image is placed in the disk.

The default OE build places the .sfp file at the end of the disk (3rd
Partition, a2 raw partition), however it only boots if this specific config
option is enabled.

Could you explain what the default intended placement/behaviour is?

>

--000000000000714f3c065ecaaea3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, 21 Oct, 2026, 12:17=E2=80=AFam M=
arek Vasut, &lt;<a href=3D"mailto:marek.vasut@mailbox.org">marek.vasut@mail=
box.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 10/20/26 =
7:46 PM, Nimesh Acharya wrote:<br>
&gt; When using the default meta-intel-fpga configuration in Yocto<br>
&gt; 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load<br>
&gt; U-Boot from the raw a2 partition on the SDMMC device.<br>
<br>
This ^ is not relevant for upstream.<br>
<br>
Please retest with build outside of OE and with plain<br>
$ make socfpga_de10_standard_defconfig ; make<br>
<br>
Does that also lead to the same issue , and does this patch fix it ?<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Im not exactly=C2=A0sure how I would go about testing this. The result=
s depend on where the image is placed in the disk.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">The default OE build places the .sfp file at the=
 end of the disk (3rd Partition, a2 raw partition), however it only boots i=
f this specific config option is enabled.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Could you explain what the default intended placement/beh=
aviour is?</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000714f3c065ecaaea3--
