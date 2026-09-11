Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F2BC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9E1160635;
	Fri, 11 Sep 2026 16:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWbrMXKWst6a; Fri, 11 Sep 2026 16:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E87F560621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144401;
	b=mXgycSfSan2ojd9ePZR5dQ+Nwi+p73vMQPQteh3k5/DfFMY938oKj+m2f0fIi6swuTB6
	 QFGpK0aAT6Ja8xmOMC7LT5B0CvReRH/hZeGiEcoCbgcQFvUTtLNLFerpzD6aJkmXzNz1L
	 SKV3k8I/BvalOeesY+8lzBl2h8XoQKbjFqj57h1Mip3GfDBA1R43nqFifhVczTC5rURI/
	 bG4vLbQS/O6n+lAdg+q32MRTyM47xWhxTwRBTk0QHdW2zwJG1M2aEDbwTeKPyxJCfCmP+
	 sRc6PPSfVEVsGhtt8iM97tw7iCjtE0e7krcevOPuNoOjwS26AZNnNlBnb0ADk0A8L1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
	b=BcCpQlTo6B0CjgIhDrc59c4hvRVscEJPx8RLLN3OOkWUDTP9A4xhOrtA8fnSfUtCtzsk
	 d1Fm687q8KzKHlljeqEQEj6BufGWLT0619HdFGQXy17Z6KpnFI3pPKXxDPOlK5NsnvB4n
	 FUAExwIPVvJ9MwEH/z674hBvr9DV+tZryw3b2dLXbdNSr6x8FTN/WssPNEg6vvL5xBRMB
	 DnOVH1MSAv1bzk0XaS7IC+Hz0OBTYpWgHEPegF7jzvcrX+tkTKE82d3u7ZngSAtrVYyIy
	 Rs/WLAXqmZvw0P/g3nTbx+bB3QTgUENeVb2Zp6u6sLN4jtpEbDouVNu5b/fM7JntYQw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qkuHlp+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144401;
	bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYgCG5xmtpp5J2oNWkXq0gAMDWhKYWOJsMfculsKrxaGinxxswHDH/EtxmSRa67T0
	 WTo+ID6nlB5AP4R9GLQ48nUUH7J+Y9XJhORlZhNaWRR/F2XUHdCJyVRhhqrUN3u1U3
	 z38C9dIR2uO9pLWyrOpGo2SQ6WdPIfh3TDg76oeFGCpzlp6uQyzc1ENVXLE5dQxv7M
	 Ob4AZhyDQWbDkecy1urHAU8nx4QD264NknRE5qWdH1uA7CHCJkpQGA4UzIBIXgMaqf
	 XXctOLX+nT8bvRvA5UiisKV1pPnxjzs35C7jE7wuObkZQSZcO/kQScwL2Igwbniwye
	 hgN7qsdqeRrSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E87F560621;
	Fri, 11 Sep 2026 16:33:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F1C214C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9BF360625
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsGk86b2BLX9 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 31B5660623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144399;
 b=TqEnyHrxeq10eWSVk3gxjHmbsOBD3y9n1JDaIgbqXnKV9Qm1JTzdmCa1S8pnvtb8306L
 bjdJFwBoyWytFak9hVZd5MnaeENQiBZCaRJ9HZ36DU6rHvh1A2/AIslRvEoLB9LjkIKOf
 sg7GJCkjuODpvuu5+LNz6cFrNsuUU7WjqD3YQqEtI8wlD89yP9yUz1SUyUuB7XrMgrirK
 8+/fI860zq13f/b5qJ7n+Pb5aKhNT2fuuY6GPzDfjDd/WRN+us7Wf2M5kv+sFl9k7RBgM
 OwnrFvDgr50kRPRGiuEyD5rtO9cUAKACYQciQLY9bmwK40lzs0aZV7byEuRBJ7U2Xig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
 b=DcNoBkyRKuZCkXUHz86TBtfHUYE+DjzrEH8IZQ+KXPT/xXppxuMNdl7KzthUtONEU5DE
 ddq0jVbNIYGMplWyKD+ksC3miKrS/ShDVO5iBJA8eo2dvNzZG09eUtjQl5ORmU/RgSHVy
 0v+kazVE05UBzMthWDGzCh3doc6J4ZFUHqylOeH737BAvdVLTu3isGOIi5uL25EYxltMD
 QQ3xzRaA0nqkgJytMTjHn+a1xMD93x3jUqqgTQfyXOmfdPimvyQu50gjlOr9UV6DPr2bl
 1iQeLXimWIzwF4HFOwQbKBAmcvVAs3FPew4yTcW5k0YizaqBYbwiFb6mWcVqAzVdqhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qkuHlp+t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qkuHlp+t
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31B5660623
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:33:18 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so1174781a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789144398; cv=none;
 d=google.com; s=arc-20260327;
 b=JMDhr9zY/kOa/D73se2vyR51Voyb8RNjHwiGZUJLm82Z6lg1Vs6douGIugJwQXOnxn
 1vVkUmHbM5YeLwpfpoPwKTCf/V5Zm5orMlyH9L/5f42n89+k+UsFP0dGMsm8di5Sbfwu
 hu2NCsqm8m9jMoQ9xBZxA9mbpoGf16TbNIL2DFhIN5Ti7OqefNuxPjik91UxnBhkNg3A
 ayJSdOabJFkspCUvRJLUCE9sEoGk5pYpH9Uv1XLgZUQ69FmX93FmISoTmYd6kP5H4yBp
 nTwIPKSoHweAYwVu/ThjcKed5nO1uhkDyh8gtmmY/wPuy1cWDJC2mp3XyxBs5T7boIAL
 8/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
 fh=LfeEjkq/Yq80tkHkwtAwBiaSjxJjy/fq+BFUyShCiAc=;
 b=FH5BOVmKHWkum6euCVJQBhroOunNBtKNvP+DmNFOCNH/zamMak+kYwJ1GbvemeWKSb
 9I0cZ5l43smKURFB0x8uewJ5GpcFnqngXGS3ny213DFw062ajsAkyoKG+mzmt6wh5+0C
 4GrPjclGJvoVFbyzNZyxTrzKGAqhOP4Vt5t44DzWV5eZ4xuKIhP0p18s4jgiQOrGOhXc
 qcJyPLjRaTibew9PjmDj8N4yK15U3e2JQXS3fSkh2NO15nV6meQDXOC/yyWvPcN4B01Z
 rBocYVwRgu7kmZfGwPRwwr6UYfAf9J1gRJsHYR75ox9+nOmx7HI5U2KOOwGnTYTmW1vE
 pCYA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789144398; x=1789749198;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
 b=qkuHlp+tr2NBCLR/ASOVCD2zTxk7S0H9L/GziqhS/wj4iUddCBx+t193kkEZ3pzv+I
 bh8VNrJsoTGV0F3YPocC1lh5RX3VUFM5BIUXdJRsriSScxt0baPx+EmOo8XA5popzBdf
 nEE7qR7+WYyCxg3NaUrWxcSWEUgnofv6wEhCLy9G1g/ZLEqpiOEVlv5MS8/wZzLleOrz
 5fkSzKL1XKSma+wUpAKWr0Gqvrr9U3yWzHjbMxqa2L0Gbb1bjrkCqmaTyFQpWIMnNXgB
 UFGLFpun/sf0ydhpzGA21PYAT0eUDAZ28i0PkYyTlQFZrsEGXxjNWN4PIAOcGhwMNIQz
 Sb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789144398; x=1789749198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duekrT0dvfp1bDtsMdSEDbV3MWRUnwkWqiIsJYNQ1UE=;
 b=dENDZLzYAVAJEsX70RyFxKhW2i0Mmb1U/79jaeeDg1WYQ1zz8t3Toiul6y5j+juCyC
 VbDVEsWua+1xVwMo7wMaKHuiuq0AOr3qtcdBCFO9NlB4jQsWhcltCfKZm2J8ggBaNlrj
 QCZxv42I/MqW4iwNwQljmgW4eyv65jdRovFxXmH93CdMMtdbm9wipHrNFV+EdY4lud2+
 cgRRAKlcGRNW9huIjPCGdkff1LfvyeIYOC/BnoYAUTCIIw5HnupUqstayzD5S2TTZaxo
 psL8yXSh71H3oQ48h3qKzUPIzgoKc3EGLvL1OnmKjzCdC5Mu5h7vDjm+Locji2yv5a2r
 1Fcw==
X-Gm-Message-State: AFuF++kQucofE6epaBFwyhdsgzq7Ff1RUzNG9iosqc/tExoG4dxNVpgK
 B3YnfteWwMjkHIt9XNNLupEdv9gAVNvEutrLnTQ58DvKPmNFtyAznd9DC4ABha7Yzi6j6Hv13SR
 I09EgLCIo4bZDD4tuXsJ6Pmtv2/o4rYixUDCMglU=
X-Gm-Gg: AYBFou22cWeqtEq4DLXAX/kAzh2c9xuf08n1Ox+TDC2SCtNQS4qThgKElZITy0elqC6
 k014EMz9e/L2P3bY+AT4csx33adaIQaAPOwkMfJ3qGoX55ARLuVyWdgwZ2hEvk74Arwfw+OxWnq
 sSJRYm6dPgpIsNjrCn7DWocyXP5j4gssQqyltQsSHY82cjIs4zIRxTFa1jSDUBvP+LSxLdlSRc8
 DtBDWJu6bc2PjtQFz5zzb8ZYIQoEtq8zAm2HmLKyMyLlAwMhe/Pf3lDoFX0qwmYDrZwbG59J8wp
 iQmO6baR/44czwO17ojMTH/gH/kAEWIRyOYiXyYeNQEqolgGJe311XIESJxOg7uGykVsC7k+9Rg
 e6HlJL7NFW+nX
X-Received: by 2002:a17:90a:ec86:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39d9bc67655mr9201279a91.6.1789144398251; Fri, 11 Sep 2026
 09:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260910200310.3503830-1-trini@konsulko.com>
 <20260910200310.3503830-3-trini@konsulko.com>
In-Reply-To: <20260910200310.3503830-3-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 11 Sep 2026 19:33:06 +0300
X-Gm-Features: AcwNN1W-xwC6bkkNGkzNB12EqA18BLFAr4TxGIc0BNNK4lWcufAbS-KLDwPeits
Message-ID: <CAPVz0n3ARyGuFBW+Qp7nLzLfKh=xxb8DOeP03xsZou8a=7gLuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] MAINTAINERS: tegra: Update and correct entries
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <treding@nvidia.com>
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

=D1=87=D1=82, 10 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 23:03 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Update the main MAINTAINERS entry for Tegra to make use of the "N:"
> syntax to catch everything with tegra in the filename. This lets us
> remove the incorrect board config header entries for a large number of
> platforms. Furthermore, correct some platform MAINTAINERS files that othe=
r
> obvious issues (such as .dtb rather than .dts in listings).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v3:
> - Per Svyatoslav, drop adding include/configs/tegra.h to the board/
>   MAINTAINERS files.
>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>
> This is slightly different than Michal's version because it adds the "N"
> entry for Tegra overall and so catches include/configs/tegra.h which all
> of the boards which had their include/configs/ line removed actually
> use.
> ---
>  MAINTAINERS                                  | 6 +-----
>  board/acer/picasso/MAINTAINERS               | 1 -
>  board/asus/grouper/MAINTAINERS               | 1 -
>  board/asus/transformer-t114/MAINTAINERS      | 1 -
>  board/asus/transformer-t20/MAINTAINERS       | 1 -
>  board/asus/transformer-t30/MAINTAINERS       | 1 -
>  board/avionic-design/medcom-wide/MAINTAINERS | 1 -
>  board/avionic-design/plutux/MAINTAINERS      | 1 -
>  board/avionic-design/tec-ng/MAINTAINERS      | 1 -
>  board/avionic-design/tec/MAINTAINERS         | 1 -
>  board/cei/cei-tk1-som/MAINTAINERS            | 1 -
>  board/compal/paz00/MAINTAINERS               | 1 -
>  board/compulab/trimslice/MAINTAINERS         | 1 -
>  board/htc/endeavoru/MAINTAINERS              | 1 -
>  board/lenovo/ideapad-yoga-11/MAINTAINERS     | 1 -
>  board/lg/x3-t30/MAINTAINERS                  | 1 -
>  board/microsoft/surface-rt/MAINTAINERS       | 1 -
>  board/nvidia/beaver/MAINTAINERS              | 1 -
>  board/nvidia/cardhu/MAINTAINERS              | 1 -
>  board/nvidia/dalmore/MAINTAINERS             | 1 -
>  board/nvidia/harmony/MAINTAINERS             | 1 -
>  board/nvidia/jetson-tk1/MAINTAINERS          | 1 -
>  board/nvidia/nyan-big/MAINTAINERS            | 1 -
>  board/nvidia/p2371-0000/MAINTAINERS          | 1 -
>  board/nvidia/p2371-2180/MAINTAINERS          | 1 -
>  board/nvidia/p2571/MAINTAINERS               | 1 -
>  board/nvidia/p2771-0000/MAINTAINERS          | 1 -
>  board/nvidia/p3450-0000/MAINTAINERS          | 1 -
>  board/nvidia/seaboard/MAINTAINERS            | 1 -
>  board/nvidia/tegratab/MAINTAINERS            | 1 -
>  board/nvidia/venice2/MAINTAINERS             | 1 -
>  board/nvidia/ventana/MAINTAINERS             | 1 -
>  board/ouya/ouya/MAINTAINERS                  | 1 -
>  board/toradex/apalis-tk1/MAINTAINERS         | 2 +-
>  board/toradex/apalis_t30/MAINTAINERS         | 3 +--
>  board/toradex/colibri_t20/MAINTAINERS        | 3 +--
>  board/toradex/colibri_t30/MAINTAINERS        | 3 +--
>  board/wexler/qc750/MAINTAINERS               | 1 -
>  board/xiaomi/mocha/MAINTAINERS               | 1 -
>  39 files changed, 5 insertions(+), 46 deletions(-)
>

Thank you!

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
