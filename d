Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F547E784B8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72AD87179;
	Mon,  2 Oct 2023 16:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UpZ+cQnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF6986D91; Mon,  2 Oct 2023 16:41:23 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61F087171
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so18020836276.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696257679; x=1696862479; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpuncAybwhiZshuLgmGPKQ9SE16ahGXLGV8xBJKrb7o=;
 b=UpZ+cQnSjfy3C6b9cc7EYpP0J7cV2C+a9KqwO5b7qOKVwrNvVBBEv8B6dl9TxOvH17
 R3nFqTQECueA15+y/sf0u6aW/H/ddYjmNDakp+gfIGPrVg9xgGTFsD13NJIhK4v/Htz7
 Kc8e79YfEPZnV9DwBa5oXCGxCf3tAFjm0I/ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257679; x=1696862479;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpuncAybwhiZshuLgmGPKQ9SE16ahGXLGV8xBJKrb7o=;
 b=EExyySMcFOWdRwDt5jNNB3nVqfvpTFjWF/ZpuZbRthcurNpGYH8gSn5Cikolt3MdqD
 rwX37VeMXB+Rw1pHrUFjmx0kBg0N7cNgUcr83oyvYlvM0cDPSwMaAvGbbPEmY2MDVvwT
 WMWCmyFVdWENWKl8bEJutdB+ku7K/40Q2QZOcYCLEt3UnzKqPdkxRj5PO8tm3j0J206L
 MWm9G7oflxZJ2xPZCVe28a/gfflTsko6vfmCYld8xrzsFIyUii0g//X2TdecwS+dT0tK
 BKMXP8xGXWbZc5DTgpbkGey3+xNo6VMIB7nlizS6/xvDv2KD/kxsIO4R6NT1O2w9ztZ5
 DNXg==
X-Gm-Message-State: AOJu0YwmU7H3fjr1Op+7c8Mxz0WsMtOgF/0cBKHzS20w2gn+WX8aAERy
 j0FyidLJMOxmGhVzUUHb500+l29Aob/c6JAPHmX5aQ==
X-Google-Smtp-Source: AGHT+IElOWP5R9idgVFGb/aCgNUwn2kzKgC2I71kR1Mg4s9dkMhoWWrgcqUsXKcPwTvDjc4lc2bsXg==
X-Received: by 2002:a25:6dc3:0:b0:d86:55b8:2b4c with SMTP id
 i186-20020a256dc3000000b00d8655b82b4cmr8964705ybc.12.1696257679083; 
 Mon, 02 Oct 2023 07:41:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 cf1-20020a056902180100b00d20d4ffbbdbsm5640685ybb.0.2023.10.02.07.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:41:18 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:41:16 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2023.10 released
Message-ID: <20231002144116.GV305624@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ja8x8jK+Zhqf63Ky"
Content-Disposition: inline
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--ja8x8jK+Zhqf63Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here's v2023.10.  Once again I want to thank
everyone that's contributed to this release, not just in terms of code,
but documentation, testing and otherwise ensuring things go as smoothly
as they can.

In terms of a changelog,=20
git log --merges v2023.10-rc4..v2023.10
contains what I've pulled since the last RC or:
git log --merges v2023.07..v2023.01
for changes since the last full release.  As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again, and I'll be merging in next
shortly. v2024.01 is scheduled for January 8th, 2024 and the merge window
will close and -rc1 will be released on the 23rd of October, and then the
next window will open with -rc2, two weeks later.

Thanks all!

--=20
Tom

Delivered-To: trini@konsulko.com
Received: by 2002:a05:7022:3847:b0:6c:973f:6477 with SMTP id pk7csp1030278d=
lb;
        Sun, 1 Oct 2023 10:40:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:8e2a:b0:14c:d0c0:dd27 with SMTP id y42-20020a0=
56a208e2a00b0014cd0c0dd27mr8703436pzj.44.1696182048903;
        Sun, 01 Oct 2023 10:40:48 -0700 (PDT)
ARC-Seal: i=3D1; a=3Drsa-sha256; t=3D1696182048; cv=3Dnone;
        d=3Dgoogle.com; s=3Darc-20160816;
        b=3DVvIJm/T54zktzsdpKeNB8NlRu9ItbNaB7e1qOxOieu8Sm3OVc91Ev+btt3kG61k=
6jg
         6VKyzDpu2Lv7yKfE7e6yDVca8iOO/I0D2ZpuqyPH0Rw1Qo0iqykJ1CqYHLGWBCfgfF=
7i
         vBbk8yXsE6cZvsebYxKERjfLxSBwvJrGa+BEjWaz0bil2ZafK6Ks4g9qtXP5NPGlB3=
G0
         1j5Rsd8Q6YK/q9sJvkaS2dX2W5dCWWXKoRtnCXc8omezjAOCt/1dErNKk8i7APtNcO=
AL
         /5T8SxaRiuQZOLYf9C8EjIxg85Y+nOGyXH+uThhsgEnO7mouK2AOoIZ1ccrmBzfQUP=
uN
         J9rQ=3D=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dgoog=
le.com; s=3Darc-20160816;
        h=3Dto:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3DoYGjrzrT4i60OQX80SZ/5vklnmtfzXe0SgY2Bdkzo6A=3D;
        fh=3Dg6xdOssgqwqsFe6n59EFcypbcgeI705GBsfaOPKiga8=3D;
        b=3DxZA/cPvs4Dxx9SPzve+jC0Pa8L4RANWzm63du/9/PZC1zK7yeYXx4oWSy0Dp/co=
hgC
         y2rt63oFmnJI2dNIARSM0seiTeGrEcQY2udYVM7q3lVBm0RyxeGTcHmqt6CxSNxzxM=
lp
         Cbz9SjHeWIOxCAj+DhNpdwGgYeorju/c6i+lbWaFNzMHEeCBCTGFd0gZymmB4YTLy/=
XN
         iFJL9ukcoaXBBLU90sT90w4yy5et0WnjRGmCyhULjOd34KiG9uGek5da9r8xjOp7wk=
Uz
         V3zvE86IsM4bhwe3fwroudj2j6WiVGQkL6TxU+aVhhRZo+nx5Qp4t4nUaKRc6YwXWY=
Xz
         wSiQ=3D=3D
ARC-Authentication-Results: i=3D1; mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3Dmn=
Z6zIuO;
       spf=3Dpass (google.com: domain of edi.feschiyan@konsulko.com designa=
tes 209.85.220.41 as permitted sender) smtp.mailfrom=3Dedi.feschiyan@konsul=
ko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
Return-Path: <edi.feschiyan@konsulko.com>
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.22=
0.41])
        by mx.google.com with SMTPS id be8-20020a170902aa0800b001c5bae148e7=
sor4915519plb.5.2023.10.01.10.40.48
        for <trini@konsulko.com>
        (Google Transport Security);
        Sun, 01 Oct 2023 10:40:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of edi.feschiyan@konsulko.com design=
ates 209.85.220.41 as permitted sender) client-ip=3D209.85.220.41;
Authentication-Results: mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3Dmn=
Z6zIuO;
       spf=3Dpass (google.com: domain of edi.feschiyan@konsulko.com designa=
tes 209.85.220.41 as permitted sender) smtp.mailfrom=3Dedi.feschiyan@konsul=
ko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dkonsulko.com; s=3Dgoogle; t=3D1696182048; x=3D1696786848; darn=
=3Dkonsulko.com;
        h=3Dto:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DoYGjrzrT4i60OQX80SZ/5vklnmtfzXe0SgY2Bdkzo6A=3D;
        b=3DmnZ6zIuOVi2UKq76qoQyxU2zeJF/FknQT33q85eI2/+2xOdbM+s6TOBXG2xUhhs=
p+o
         okPVvcD45UCrVInXBbrTdBRwRjiQbn+yjYwKDt5iJ5JEfcDqbgnAmTTN0i9P3BKNQT=
vf
         XcPK8lEj8gnicEXTmBdYUZq0S0CrqQAID//Uc=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1696182048; x=3D1696786848;
        h=3Dto:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DoYGjrzrT4i60OQX80SZ/5vklnmtfzXe0SgY2Bdkzo6A=3D;
        b=3DmABg8XORPS6/BhR0oFOkbgMTzldmz2vSXMG6QulGL8jNwVQm62Hc7t6AezUGhFM=
kz9
         D4lLvkETA06wr5yPG9gOs1U9dvmDBWZ14+9nUtUhOThr0euuCF8a4WNdsF6nZEG/CT=
zX
         lUnm6hTRKLWbmLFrrEMm2HrMCNxPY6WRegx965EDVb4MqGe0nI1IuDtDYbWJeQeo6K=
Rc
         KLfCOAeJ/W1riwWWw3BP2mpUt3eTQVjHCp49rAMj2LapqWwbHHjipv8c5B4bSAcLVa=
Hf
         6ACe/rH8cBNCjhEe5uOHsxBRSJ6LvT7W4mGeojb8tcpQEn39khbyfjmtY2VJHXYJX2=
L7
         0LrA=3D=3D
X-Gm-Message-State: AOJu0YwQBa6uTcgT5x1tLUdW6US/agflW8urR+mcCL0PlUKu7utcF3mU
	ItYeNYSf2sxFKYcFimQZqLHX5gMLu4Ha8K07kb4AHZFxZp8NzMHxFRRGAw=3D=3D
X-Google-Smtp-Source: AGHT+IG+1WegOJFgDI0yQQTMeoeCF3rrOHhFV1GthwGdCJ8vNqKRW=
kdYr4xCbxbsaelBfQR0KzbHg40SjvvRVSfJ80U=3D
X-Received: by 2002:a17:90b:a42:b0:263:829:2de with SMTP id
 gw2-20020a17090b0a4200b00263082902demr7612436pjb.2.1696182048274; Sun, 01 =
Oct
 2023 10:40:48 -0700 (PDT)
MIME-Version: 1.0
=46rom: Edi Feschiyan <edi.feschiyan@konsulko.com>
Date: Sun, 1 Oct 2023 20:40:32 +0300
Message-ID: <CACpOGAf6A+rNOwX5KZAFSk0GhudVoguAi=3D90htzoqf4YrEXH+Q@mail.gma=
il.com>
Subject: weekly status
To: Tom Rini <trini@konsulko.com>
Content-Type: multipart/alternative; boundary=3D"0000000000007656c80606ab28=
87"

--0000000000007656c80606ab2887
Content-Type: text/plain; charset=3D"UTF-8"

Hola Tom,

AGL -
  - Ran the usual tests for master branch and reported findings to the
community mailing list prior to the dev-call.

ESS - 12h
 - Installed the new signing keys on DS300
 - Synced and rebuilt DS300 image
 - Digging into grub-efi and SELoader to investigate Secureboot failure
with the security violation error on grub.cfg

Best,
Eddie

--0000000000007656c80606ab2887
Content-Type: text/html; charset=3D"UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D3D"ltr"><div>Hola Tom,</div><div><br></div><div><span style=3D3D=
"fon=3D
t-size:12.8px">AGL -=3DC2=3DA0</span><br style=3D3D"font-size:12.8px"><span=
 style=3D
=3D3D"font-size:12.8px">=3DC2=3DA0 - Ran the usual tests for master branch =
</span=3D
><span style=3D3D"font-size:12.8px">and reported findings to the community =
ma=3D
iling list prior to the dev-call.</span></div><div><br style=3D3D"font-size=
:1=3D
2.8px"><div><span style=3D3D"font-size:12.8px">ESS - 12h<br></span></div><d=
iv=3D
><span style=3D3D"font-size:12.8px">=3DC2=3DA0- Installed the new signing k=
eys on=3D
 DS300<br></span></div><div><span style=3D3D"font-size:12.8px">=3DC2=3DA0- =
Synced=3D
 and rebuilt DS300 image<br></span></div><div><span style=3D3D"font-size:12=
=2E8=3D
px">=3DC2=3DA0- Digging into grub-efi and SELoader to investigate Secureboo=
t fa=3D
ilure with the security violation error on grub.cfg<br></span></div><div><s=
=3D
pan style=3D3D"font-size:12.8px"><br></span></div><div><span style=3D3D"fon=
t-si=3D
ze:12.8px">Best,</span></div><div><span style=3D3D"font-size:12.8px">Eddie<=
br=3D
></span></div></div></div>

--0000000000007656c80606ab2887--
Delivered-To: trini@konsulko.com
Received: by 2002:a05:7022:3847:b0:6c:973f:6477 with SMTP id pk7csp1331648d=
lb;
        Mon, 2 Oct 2023 01:59:52 -0700 (PDT)
X-Received: by 2002:a17:907:2722:b0:99d:ddae:f5d4 with SMTP id d2-20020a170=
907272200b0099dddaef5d4mr9571965ejl.44.1696237192646;
        Mon, 02 Oct 2023 01:59:52 -0700 (PDT)
ARC-Seal: i=3D1; a=3Drsa-sha256; t=3D1696237192; cv=3Dnone;
        d=3Dgoogle.com; s=3Darc-20160816;
        b=3DI496et2+84IAIc2BzvoWiaOss9/Fjf+cA5lIm67Q0EWsKU1ulWR7Z7bLoENSYNM=
RUf
         UN5q6VsifraQmYZILvjYWn2vHempgUb5rs6tLeo6Xl/QHciiOGFvcSDNVzymdiH7zj=
5e
         TBY+wwdblXMZeMxc1/m8TcC9I++E5w8kaZEUX196p230Zl6Cki9ePqBChZlZYDUfAs=
Bb
         XuNSMJMLpbTLa2fuMafztDNY/zfOboJlU0KcFEXb4r0+HdSE4MWv9mHH7J2/SQ1sel=
wC
         9Kqgb43dKemZV81eMh57UF/HzejnSQ7Hidcsu7m3EgAlXEqzc6LtuIzrXlf1XrHbsf=
uL
         7M2Q=3D=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dgoog=
le.com; s=3Darc-20160816;
        h=3Dcontent-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:dkim-signature;
        bh=3D0ebHzP6VTlbA+NI4gF8LQwzoMeFZOV/P32vF4rv1LFo=3D;
        fh=3Dg6xdOssgqwqsFe6n59EFcypbcgeI705GBsfaOPKiga8=3D;
        b=3DGfreTzxQ8im55v1OCscE5naEbbh2YRB44eWFKv8belx+lpweTXceYY/adjD13/I=
FeY
         DnuT7zL15ukJ3A40tqEwEZ5fYlXzDL9GC42yjoeA9dofdXI9E6OYzTQtgrbWGWqZJ8=
uv
         7J0+sly/GpBP7oiYni7tyA7E7/GPmWtc6ZAJrp5YVcshxdLQmZba7CTmj6ryJFyBnj=
6L
         IpBokLq/KD6VN3NTxb52ZZaPLoqofWNTsGAFD9gr52AN3EXft3IIG63jBRtGXB52JU=
oU
         KrL4cyJ/CmLXNYcboeNoAYDLrOS5iDDQT6LEY7DnahNN5lP8cb8fMrQ9JjHy3euUy+=
bf
         yfaQ=3D=3D
ARC-Authentication-Results: i=3D1; mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3DqM=
FYqvlK;
       spf=3Dpass (google.com: domain of leon.anavi@konsulko.com designates=
 209.85.220.41 as permitted sender) smtp.mailfrom=3Dleon.anavi@konsulko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
Return-Path: <leon.anavi@konsulko.com>
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.22=
0.41])
        by mx.google.com with SMTPS id hg21-20020a1709072cd500b009b2b73186e=
bsor181646ejc.3.2023.10.02.01.59.52
        for <trini@konsulko.com>
        (Google Transport Security);
        Mon, 02 Oct 2023 01:59:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of leon.anavi@konsulko.com designate=
s 209.85.220.41 as permitted sender) client-ip=3D209.85.220.41;
Authentication-Results: mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3DqM=
FYqvlK;
       spf=3Dpass (google.com: domain of leon.anavi@konsulko.com designates=
 209.85.220.41 as permitted sender) smtp.mailfrom=3Dleon.anavi@konsulko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dkonsulko.com; s=3Dgoogle; t=3D1696237192; x=3D1696841992; darn=
=3Dkonsulko.com;
        h=3Dcontent-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D0ebHzP6VTlbA+NI4gF8LQwzoMeFZOV/P32vF4rv1LFo=3D;
        b=3DqMFYqvlKIoOUMbnQK5g67I6OKtGItubguQWLMcB9QCjKCBC5AdIKUhtML2ubpL9=
f2n
         SSGJv9v8CFJXSge6FlPGDsMtVgGKvxS9uAFuuhASe6vAk2dlETSjgew1UDrUSnO156=
lG
         pgaYpRcUcq7h0IoJ0SyiWLzUGH81TAA3GffZ4=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1696237192; x=3D1696841992;
        h=3Dcontent-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3D0ebHzP6VTlbA+NI4gF8LQwzoMeFZOV/P32vF4rv1LFo=3D;
        b=3DNXMsQci3KndyYGITcRCvIwb24poN32NFK/YybuU4sGyCOw8Hl8is22he7vcQiQU=
S+m
         k7k3PMdBC7jJA/TekICqyxaer9jXJ9FEReN+POt1ml0Tw99V4jXnHLukQZCtFmvEZD=
hA
         vEEJNC+C2dv1xxSBmUAmJQ21Dhj6C6U+97gZ1LkLgE/Pd4UJHG2D09EmMPyfuFp9o/=
uD
         +1uViP0nRuVIfWz9QgwHGHkE/C+zCca3xkVqE6XLCToOBH126ZgA1Lpaxf842i2eXZ=
LL
         gcSWWEHxIlxlhEXLmZ2xhep5fQN0evQFfdY6B9wr9AJ4ttNrQUSGt75uDOV9ZXIX9J=
qm
         b86Q=3D=3D
X-Gm-Message-State: AOJu0YxX3FZsfLTfzUpeqkqjLx787sOwym5orwOCVoGBXsL8f1lNqxnT
	4Qy2OC8f4GLzBbgSkGguEZTi25tpqwzYNXAuymsGWA=3D=3D
X-Google-Smtp-Source: AGHT+IFuR0rXv+uvqrAUSaCXNWv1rxRFBjPQEJvxbvnKSv2EfsLxu=
BTU+5tM9VmvenZgTvNMvgcvUg=3D=3D
X-Received: by 2002:a17:906:31c7:b0:9b2:ba53:a1a6 with SMTP id f7-20020a170=
90631c700b009b2ba53a1a6mr10258379ejf.72.1696237191821;
        Mon, 02 Oct 2023 01:59:51 -0700 (PDT)
Return-Path: <leon.anavi@konsulko.com>
Received: from [192.168.5.249] ([46.55.231.62])
        by smtp.gmail.com with ESMTPSA id c25-20020adfa319000000b00324853fc=
8adsm9663581wrb.104.2023.10.02.01.59.51
        for <trini@konsulko.com>
        (version=3DTLS1_3 cipher=3DTLS_AES_128_GCM_SHA256 bits=3D128/128);
        Mon, 02 Oct 2023 01:59:51 -0700 (PDT)
Message-ID: <e6f13bac-b19f-47a1-a6c1-9cd6d68393b6@konsulko.com>
Date: Mon, 2 Oct 2023 11:59:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
=46rom: Leon Anavi <leon.anavi@konsulko.com>
Subject: Weekly status
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
Content-Transfer-Encoding: 8bit

Hi Tom,

My weekly status about Hexagon:

- PLAT-5374: Successfully tested booting masep-install-image built from=20
Kirkstone from USB-C stick on Display X and using it to flash a TEZI=20
image. As a workaround for the kernel I used=20
imx8mp-verdin-wifi-dahlia.dtb instead of hexagon-dispx-\*. dtb files
- PLAT-5374: displayx/local.conf.sample: Switched the template for=20
Display X to Kirkstone and Toradex 5.15 kernel.
- PLAT-5374: testing vlad's kernel images.
- PLAT-5451: bluez5_%.bbappend: Modified bluetooth.service to start=20
bluetoothd with the --compat compatibility flag and after that run=20
sdptool to add SP service to the local sdpd. These modifications are=20
required to support Bluetooth Serial Port profile and to perform=20
Bluetooth range tests.
- PLAT-5451: Built and uploaded=20
masep-display-displayx-3.4.4-bt2-PLAT-5451-20230926.mender\_tezi.tar to=20
download.konsulko.com so that Daniel Hess from Hexagon can use it for=20
Bluetooth range tests.
- PLAT-5451: Added instructions to docs/02-qa.md how to establish=20
Bluetooth Serial Port connection between unit A and unit B and exchange=20
data. Update Bluetooth general instructions to add an example for=20
connecting a mouse such Logitech MX Anywhere 3. Provided details in JIRA=20
and moved the JIRA issue to QA.
- PLAT-5451: Ported the recent changes from konsulko-sow5 branch based=20
on Dunfell to konsulko-sow7 based on Kirkstone.
- PLAT-5450: ibss (ad-hoc) is not a supported mode for the WiFi=20
interface on Display X with the 5.4 kernel from Dunfell. Switching back=20
to the alternative plan for WiFi testing with AP mode.
- PLAT-5450: Added mwifiexap to hexagon-display-packages.inc for Display X
- PLAT-5450: Add iptc to PACKAGECONFIG of systemd for Wi-Fi AP mode.
- PLAT-5470: Explained the warning "Found more than one dtb specified in=20
KERNEL\_DEVICETREE"?? and why it should be omitted for Hexagon's case and=
=20
MASEP distribution.
- PLAT-5451: Provided feedback about minicom regarding Daniel's question.
- PLAT-5450: Added hostapd to hexagon-display-packages.inc
- PLAT-5450: Built and uploaded image=20
masep-display-displayx-3.4.4-wifi-PLAT-5450-20230929.mender\_tezi.tar=20
for testing
- PLAT-5450: Wrote step by step tutorial in JIRA how to configure and=20
run Wi-Fi AP on Display X.
- Mender/Yocto/OpenEmbedded training for Hexagon and Display X specific=20
layer and Mender integration
- Wayland/Weston/VNC training and code review of Kirkstone implementation.
- bi-weekly call
- Daily call

Best regards, Leon

--=20
Leon Anavi
Software Engineer
konsulko.com

Delivered-To: tom.rini@konsulko.com
Received: by 2002:a05:7022:3847:b0:6c:973f:6477 with SMTP id pk7csp1071003d=
lb;
        Sun, 1 Oct 2023 12:35:25 -0700 (PDT)
X-Received: by 2002:a17:906:2b54:b0:9a6:1446:852c with SMTP id b20-20020a17=
09062b5400b009a61446852cmr9344071ejg.27.1696188925145;
        Sun, 01 Oct 2023 12:35:25 -0700 (PDT)
ARC-Seal: i=3D1; a=3Drsa-sha256; t=3D1696188925; cv=3Dnone;
        d=3Dgoogle.com; s=3Darc-20160816;
        b=3DTxj4JAeeSukRCVDrnQYk9Bul1An8hCp8nBq+1elcKIfrrauiJpZJ8IBCJ2meCDX=
9Jo
         11jkmVwZ2eMuY6fNRCUJ43qYluKLCZFzDFZxQzc1U0DQI0AjnbONCp+h3LcY3MOirq=
WE
         klYHfaSN7O0I5e0ktrBaLYWVusVP/4a9EY3ZIHM7YORRoStdinpwrc4jagGg1uXehH=
ut
         1KHRq+WZBaEJ1XtaBlW+FPqZh49YDVIv9/u1fZmnGLXrnTZiBn+X7AP58JT4jCfnka=
46
         pjgKrIBgTmVZaAP2mRt0BrMBlTBLQV4b+n3t/QjorUAAQu6vOWOD6psL36/uM4Icx+=
qx
         DfUQ=3D=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dgoog=
le.com; s=3Darc-20160816;
        h=3Din-reply-to:content-disposition:mime-version:references:message=
-id
         :subject:cc:to:from:date:dkim-signature;
        bh=3D7PfrdlpYIz/JD4RMesHRoZUhPKz1sZTcJc5qdMXVfzQ=3D;
        fh=3DADY+DTdKoaNfD19kvk4m0Yp631ttiLm1G5JhbEMphsc=3D;
        b=3DEnsFhnnI9gr9HnOgL7YWnJECZwfmLJ/iiZOVS7ha+UgiZs9iNRDA8H8Qy3NjZ+x=
/Cg
         ntIaY6OmV9smsXxGonhLXP47EmQERlYCBqd3B393kBcJP8lbB8vD3QtDcFgf/BkA+C=
v5
         MW+mXHvZKjAv35F8rOowuY6qSSwoX0TziG1A5/OVrjffM/8HQyYkqwLdVfh1NLCk85=
pU
         PWc1zi8xHCNXSbZKwOtHnGbEa08UuoVYaukQgrYOP7v5Zg5p+SZSBO/lMwLcs9SD79=
l6
         K550M7oQSwPpq155dEGMyocsPvUIhyCveEtB9AzIxW/8rrGvliKVcUtWGgXRxJgpwE=
JN
         ujqg=3D=3D
ARC-Authentication-Results: i=3D1; mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3DJd=
4fqU9p;
       spf=3Dpass (google.com: domain of vladimir.ivanov@konsulko.com desig=
nates 209.85.220.41 as permitted sender) smtp.mailfrom=3Dvladimir.ivanov@ko=
nsulko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
Return-Path: <vladimir.ivanov@konsulko.com>
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.22=
0.41])
        by mx.google.com with SMTPS id mf8-20020a1709071a4800b009ae61967a47=
sor4358554ejc.13.2023.10.01.12.35.24
        for <tom.rini@konsulko.com>
        (Google Transport Security);
        Sun, 01 Oct 2023 12:35:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of vladimir.ivanov@konsulko.com desi=
gnates 209.85.220.41 as permitted sender) client-ip=3D209.85.220.41;
Authentication-Results: mx.google.com;
       dkim=3Dpass header.i=3D@konsulko.com header.s=3Dgoogle header.b=3DJd=
4fqU9p;
       spf=3Dpass (google.com: domain of vladimir.ivanov@konsulko.com desig=
nates 209.85.220.41 as permitted sender) smtp.mailfrom=3Dvladimir.ivanov@ko=
nsulko.com;
       dmarc=3Dpass (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkonsulko.=
com
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dkonsulko.com; s=3Dgoogle; t=3D1696188924; x=3D1696793724; darn=
=3Dkonsulko.com;
        h=3Din-reply-to:content-disposition:mime-version:references:message=
-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-=
to;
        bh=3D7PfrdlpYIz/JD4RMesHRoZUhPKz1sZTcJc5qdMXVfzQ=3D;
        b=3DJd4fqU9pq47v3kqt9P5uge+Vfj71wkyMlmXTShOzB8RpE1SgIHE1D00FCpkLEYD=
VlO
         qJzffZsavYsHFY+Q3VBrwWZ/1fyo/ft0QAkKHYBTHqbOPHch3Sqh3s8G8uyTsQXSsb=
b3
         fCiPbfc3d3xSySvN0EhRIuwVbEnagim50J9R8=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1696188924; x=3D1696793724;
        h=3Din-reply-to:content-disposition:mime-version:references:message=
-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D7PfrdlpYIz/JD4RMesHRoZUhPKz1sZTcJc5qdMXVfzQ=3D;
        b=3DPXrfeKn3gHxTRpiHIkJBtI7CKcdq3QEIqC9LjwgLMGr+ja4x+RArts0FW9oBACE=
lYX
         UqHiCaMxI0xqaOcOO5jtkrgn52ELVnBDNHl0y+nkrzIzP4oW/DYWSVbda4izOivD5V=
IE
         rcpowAF0OHKMqLfRURa+vn7e0gcf2rlOOUsX8HCSVcyHev/Wx6C/McSK4ktTAUuS1V=
wY
         4dZ3KJr8AjJJQYxXjY6eLqxaWNv52ZVw3zlSoj/jQi6dau/E9tSSljOLgw6dVX5LmZ=
uw
         fjljSPFBrqLSGnD+u2v7juSZZrovbu8dVa4a5sq3FwSr1itqfOU/gHRt17H96dtPXg=
+9
         9OXQ=3D=3D
X-Gm-Message-State: AOJu0YzftM+HHrAe/m6bmAhPqT0sCOD7M/ZV+c0pE2WFzKliUuHK2px9
	1RxzJjm8e1Za8IgsKxuQ6o9mjlvjsPt67nX6Y0JQ7ns/
X-Google-Smtp-Source: AGHT+IGXmZ9H1SwU6mEgxBgstCjCsERDreFdFR8lQBNqDuJwOmLIw=
HYWsBhLXltI9mDOUPFuOtamWQ=3D=3D
X-Received: by 2002:a17:906:cc13:b0:9ae:3caa:e12a with SMTP id ml19-20020a1=
70906cc1300b009ae3caae12amr8797719ejb.57.1696188924387;
        Sun, 01 Oct 2023 12:35:24 -0700 (PDT)
Return-Path: <vladimir.ivanov@konsulko.com>
Received: from p300 ([93.152.140.180])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090670c500b009a13fdc13=
9fsm15761301ejk.183.2023.10.01.12.35.23
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Sun, 01 Oct 2023 12:35:24 -0700 (PDT)
Date: Sun, 1 Oct 2023 22:35:49 +0300
=46rom: Vladimir Ivanov <vladimir.ivanov@konsulko.com>
To: Tom Rini <tom.rini@konsulko.com>
Cc: pete.popov@konsulko.com
Subject: Re: weekly status report
Message-ID: <ZRnKFf6Hru0sLtSq@p300>
References: <ZLWf2o1zIE/BVNS1@p300>
 <ZL7sBKi6hGlwXkj9@p300>
 <ZMfM1p5F8DrzEB0S@p300>
 <ZNFpvILxEgZ/Noc1@p300>
 <ZNp10CJwBhO/L0HH@p300>
 <ZOObwRRj9uzlLfaN@p300>
 <ZOx+oXSYDQzvlZNF@p300>
 <ZPgy1nu8eTn2+TSO@p300>
 <ZP35oGZsy17IcSCs@p300>
 <ZRLQWjVq3TZwVtAV@p300>
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dus-ascii
Content-Disposition: inline
In-Reply-To: <ZRLQWjVq3TZwVtAV@p300>

Hi,

Hexagon status for the past week:

-----

Hexagon SOW5/7

	- bi-weekly meetings

	- "Training: M0 architecture" meeting

	- "Training: Overview of DT" meeting

	- "Training: U-boot customization" meeting

	- email support

	- [PLAT-5373] convert kernel patches 5.4 to 5.15

		- pushed to repository and wrapped up

	- [PLAT-5320] update DT using 5.15 kernel

		- continued

-----

Thanks,
  -- Vlad
--ja8x8jK+Zhqf63Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUa1owACgkQFHw5/5Y0
tywq5gwAsVRSXWHrnbtIwc5VfTowWMigGEdJEr2F1qMcIc3R6WAYMswmchNoHWFi
tzfMz3Tgtn3cZ+5sYJnfWK7g4Pq5nvPe3R8WTeYTDT6TVjNJ0AJ9N8Il/JDAfUTC
mL7ihfl+r47zffSTp/MWF+ejxNoT9auiXJWwNBMGn7gR3Zbu+FSVb4qjd3u4bHcu
UUlePQ5RxOAHMQC4m5QdzpJ5PQThbcujVmSwL67VeMqFwuQitPxrL049HK0Oo8iQ
JNcw4spPyQL+uJU8SlLHY4WmLZjnMNGnkwvt7MYJCizuhRxACgJMEvYNHMC2kXAF
2XdiCeyg7WbxO0hwqCaCsXQNvlJuXR1/Gitk76Z+imCUqGwp/pwu0buamQrWrN86
VbwHlIYTVRi5O6m2JpE1IvP+mIPjKvtrusCP3ByWZ9FYmXlPDV5LLRYgjrOcMeCB
BGiyJEdypd6zswJf2E40pEWbJ3V9IJHjdMMMEbJFHpErZUzwExv474Zag6ieDrnt
KC1VGBlo
=8rd0
-----END PGP SIGNATURE-----

--ja8x8jK+Zhqf63Ky--
