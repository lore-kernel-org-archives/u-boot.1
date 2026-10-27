Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mKaCqqD1;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D9hUClVq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D7A340786;
	Tue, 27 Oct 2026 14:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXU_RWLlHDTh; Tue, 27 Oct 2026 14:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 269BE4057E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109913;
	b=bm0B/FBZJJGzl2ofP1shaxP2pH1iDyNO0CcVD98+3W+ukEkAJ9y9hPsvIYSY/3byfcBm
	 ZE7c7gTHm8kVBKYonhynSFZNOeZTlFXWCVIMF7RcvFifZ/bQklWD1DpYgLpMevisi7A+N
	 vkMArcX2A1P4tcfu7MkXsYzkzif40EN8AB2vX5J18BYcxR9vKghflxQB3o/qXE9WaQzQO
	 BcoOwpobwxwIdy3aGsfcqrN5lT1fqK9v5mJbZ2jRHP/AhgmLdUafTYutvVaUGlea5F2D+
	 DDRAIeyEtuf3M5iMSb+mocvT+yEo0pFjkwAOdU5viuGN0GXba3wI+dRemVq4WB9CENw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793109913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
	b=SRrHan4NfCejFujI8ONSqxurB1hty5p9B0LKn27KO9zpKunf49Zo4N09x5L/qT3lpdpR
	 /YB3H8jDZiPSfhz82jtJiN/vsef0GiiRyyCXbE9gztTNtr7yadHNBxyPsVkTD8/JiXqwd
	 ezfV1F5c12YinLVuSHws2thnGX8cRAFcYVrILAkjtSCMRebjKukmBhdt91/KvZe1WaAs2
	 hBwjmfB9g4pkRYGrK/07vjSRGpt3CK1iZvBdPNx8QxcmQ96X6oAC8irdUl8QSIJtrewtX
	 ++hhiLiv7XdC9lTHoO5YMfsLtmhqUI6udx/qjk8r5MgIz4iY0NwVc2vkoloOjh9sGug==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793109913;
	bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKaCqqD14ReOFJbNi5nV2gR1tPFUAHXQJTafzdnLxutUNmq3mFL+PAvfxw8rfDLFK
	 vMAONtWV4p2VGQ26z6sbwZ7yhwHBlpY17FF11a/s+pR2eugPOKQ81mo3mytiaG62Mv
	 wo9B1fpl1ho+N5az802r6LOjcFuiHG3Hykzh9bAtTLwQyHZHHQKTaBB43kPvRPkla8
	 3Q5B+rMxZkrkPEl+gaRK0cEB+JWH3mBofTdl/qs45QmQmPt7zcLLuopJ2srAon5Qmq
	 Ziwj6bU++ppkKhovT2e9bBRuLqcxkQZgpk83YvNO8vDBok9GPkSc/b0H7AQRzKW/qc
	 +iRtenYF9FlhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 269BE4057E;
	Tue, 27 Oct 2026 14:05:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 312702F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D15C16078A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCRzpctrHjH1 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E64BB607A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109909;
 b=tR0uRccjaiqb8z0Gi5lDEi/Hy0VCQFd8FM+pLW21ayGIFx0OvC8K10Hu9KAU6v7s83Mm
 YUXUxEH8BhTl8weFJ3B9clPuTGuV4+07cyEu3RVVYpWILR3j9E+7W1z1dLDaryw9vkZ3N
 H5teaj9zw97gXKI3KYnWrqMqMX3zW/kbCZWqJvCkkTaoFzADSErAoIVS8xLgDUBXPzOLw
 4NXlgHnIrEwK2mnuORN0bat8VVy90y9pYeQcoafj/glIUkSvTUI2RkPiBbu7d8JwTMJyK
 FY4mMoLOy8ht1bDwkL0poWwNewbhf4sl3i2Hn3vVh1jZPHdndhXKHetE80pW952iGNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793109909;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
 b=PCIv9V/Md3YBcb/be4BeImaYHZEPAn+2trERm0KXoDQxauV24qRxUJXNe1SFI+O0+yEc
 LbTQPtaWvpD48K6lyBeZGFgupm+pRnyb/6zVebFJrfiSa7PvOqQ+fyJl9HWniIIJa8lyx
 2iDzBR5PdBz2kFL9XY1OcsAd60nOcdF4kXAx0w09L3rtBPyq8dZeyLEmVyaMvlLZmAyEy
 mB9JN4nUBbgteh9OjYDDE4Z5eLVf+0r1RPvyc2YYTYaZQ34oFOmd9iOatMtsUHQH0Sgt3
 EpqJTAUcpXIS0bgrfgspsM+fkTZEo+XFfSmUbzEqpdqxcQMFGu0WoujaeMZs+AiHN/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D9hUClVq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D9hUClVq
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E64BB607A2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:05:08 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b40fc523faso4622085a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109906; cv=none;
 d=google.com; s=arc-20260327;
 b=ER0srgw9LgH8YkMxStiBMGmsa/cttUo1jylUbhDW7KsWf+o9dIZKrqCyHKfZ8ACud4
 NEOFaLinQkzbjQPO2xrb1C4zXGNW9y1h9gJFY40M7P3e+A6Y8qXQCwyAZGQphUm+4r3i
 /HpVi0fHkNjxnkzVJS8OJ9mm2JrNU3agYzcegUs+J8rN1IjKkZiecyhuDmJ2jqmj7X7d
 ywZC2LRb8gRcEWdArbQxKOkbuCfDOIOfTaRr3xeW4EzJbxF3lhisSYQ7RXs1196+zfpK
 d2ba0Zu4c6b/HLbXMi2+KKI4nCS70WX6go6roZXJ+8sbCmYFPb47ZOynKCJk5Wbiq2Re
 W/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
 fh=Pw0FZJaKBa2cx8LEcGnG18ynAmWNtezAHVhYUBhxtnQ=;
 b=HW+2xXUhEKLJnY+BoeNl8SB3Y0S/oATAgNL7ZxG5ZKYWmqygFhcEuyWMi5F4KQB3hp
 HhGIW5YDkqrGnaavgd+lSf5EIYIE/Z5clz5Tu+rY2A6MzkqsjDhFvLMDF7KpvRQ0E1DE
 K7YEH8zD+AYR7cvTV+8hx/Kj0edvR1607j2bO99/snNvY7TVHaNgrhb3uA3F/juqDHWp
 Txzx4IgLlvXTtDCKFTTOnawOUe9xN1Pr5CvLo9o2HpCz6cT9nVJ+N+lJaoRn3oyE0r5N
 l2EscRk82tJFGxT6YRzfxQbBA35JGLTj9OL844bNc1Odb7LDPqGw7HpzFGQxnIZJGoB3
 Vb6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793109906; x=1793714706;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
 b=D9hUClVq81C89gtTMvrAzedbLqjFN0sbKV6gtmG3dHUR7uaINgbAonFvn7nuPLKUUf
 UxZU94CXnPCOiwHI7MtgaVzOr/qWvl5lJTUBz4XFKiGz/TOhAKF3CyKq4sKZWUX5mEfc
 h+wD4/QrvJCA2JsvLuSBuPfv7NBi3XizvxPy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109906; x=1793714706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROShavSfujNnDVgf2p1HBqqbHnts5PYWeoHRmAqrM2k=;
 b=uDXw1CaD/JYgalXKNcF9shqC5q7fl0wkW6h7fhixIGNeJOmx/tjNFBNci8bRAUx+Ij
 db1SZ46K1rDxKoL7c7OCqfiYTkvtAlW4bUFOD1m3HpFXfIynYysyGsOsgTlwplj7Zi/S
 TQL+FeoycZGYQ4gENiqKgT9EDSmPehog//HNG1H9VK9rw62Ha24noBpHmmbUExEE2EHf
 fZFwV1Itl7KkZP9BVnHYOvTGM08EPcsqTKySL+H8QFw8HGa0ewkWv1sFh2YUcFwHBfjV
 DEkY1xR1q1VuR4XCWEQ1cy0wgvG93DHeiUAI1zllCHNluxnil3c6a1r1PIh4+8wN3Z9p
 Wg+g==
X-Gm-Message-State: AFq9FYL0JP724VMaj++0FDR127vrdtpmFjiZiVz35SQVOvKAupcUcLQf
 Ut3sy8tA+1/k8od8THRcENNYTZw2wz8EFt0MQ7fDWBUwC7ts3XA08+7m9UXMUK8TONQD3MalPSF
 UL0txh70DUwoY+jhiYuDIpC2zVcgkbYQCTNIDG4Zr
X-Gm-Gg: AYBFou2xG+UF1cX2E3peMMSzatDiYh4gvHU5EXvTTR1bJs/l8O4vXgD9L4EIMJ5HCQg
 VqTFHL3BRYDdDGb0k6q44HHAll3Xlh462G6P0jyrTTMLV9dC0Rk3eYAd9tbiMYgstZpyVPf410J
 DaJCdXS2byxvugTQJQgv1oBqg+c/6aOCGq6FuoNegOerSxtHboy3suQYKdy8duQWuCuxCpJhqXv
 NxSv0xAei+v3itO1NtbXFlPL9WgrbRgb9eTW73ka+cIJMUWYBK5O65WKJrRu2DQCMTQ3SgMmQAL
 NODsHc0/8iRFunFYzDFn5eASI8uMO4s+3MXC2XWkXuv73tPmNm7BWnGLWzYuAdlpxwR/s6MeDAS
 T09EAn7AjfM2+ga3AqVnUWhhUFRfhkE09gXo=
X-Received: by 2002:a05:6402:1356:b0:6b1:8316:ba32 with SMTP id
 4fb4d7f45d1cf-6b442ff2d2bmr7455667a12.17.1793109905345; Tue, 27 Oct 2026
 07:05:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
 <IA1PR12MB952911BB398C79508458C86489602@IA1PR12MB9529.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB952911BB398C79508458C86489602@IA1PR12MB9529.namprd12.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 14:04:52 +0000
X-Gm-Features: AclHuK-a_8nbxbpWxEYOgQN-tlaug59e53oI2NqLFfuo92YPDldTSipaDhQi_7Y
Message-ID: <CAFLszThKj8=YLxrJPYqL6QMAPAb_mMbHGg0PckFEAfKTQQ9b4A@mail.gmail.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
To: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, "Simek,
 Michal" <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Suraj,

On Tue, 27 Oct 2026 at 05:36, Hanumant Kakade, Suraj
<Suraj.HanumantKakade@amd.com> wrote:
>
> AMD General
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Wednesday, October 21, 2026 6:13 PM
> > To: Hanumant Kakade, Suraj <Suraj.HanumantKakade@amd.com>
> > Cc: u-boot@lists.u-boot-project.org; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response=
 file
> >
> > Hi Suraj,
> >
> > On 2026-08-24T04:47:18, Suraj Kakade <suraj.hanumantkakade@amd.com>
> > wrote:
> > > scripts: pass dtc cpp flags via a GCC response file
> > >
> > > cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> > > path) in the HOSTCC command. With a long $(srctree) that command is
> > > too large for /bin/sh -c and Make fails with "Argument list too long"
> > > while building a .dtb.
> > >
> > > Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> > > HOSTCC/CPP so the shell command stays short.
> > >
> > > This change requires GNU Make >=3D 4.0, since $(file ...) is not
> > > supported by Make 3.x.
> > >
> > > Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with
> > > CONFIG_OF_UPSTREAM")
> > > Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
> > > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > >  scripts/Makefile.lib | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib @@ -448,7
> > > +448,8 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
> > > -   $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o
> > $(dtc-tmp) $(pre-tmp) ; \
> > > +   $(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
> > > +   $(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp=
)
> > > +$(pre-tmp) ; \
> >
> > One thing I'd like to check: the .dtb and .dtbo rules use if_changed_de=
p,
> > which compares the expanded cmd_dtb / cmd_dtco with the command
> > saved in the .cmd file. Since $(file ...) expands to nothing, the saved
> > command now has only '@.../.foo.dtb.dtc.flags.tmp'
> > and none of the flags. So if dtc_cpp_flags changes (a new -I path, a -D=
 define,
> > a different DTS_CPPFLAGS), the .dtb is not rebuilt and you get a stale
> > devicetree. Please can you make sure the flags still count towards the
> > command check, e.g. by writing the response file only when its contents
> > change and making it a prerequisite, or by adding the flags to the save=
d
> > command some other way?
> >
> > Also, cmd-check expands cmd_$1 every time make looks at the target, so =
the
> > flags file is rewritten on every build, even when there is nothing to d=
o.
> >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib @@ -448,7
> > > +448,8 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
> > > +   $(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
> >
> > cmd_dtc_diff (used with DEVICE_TREE_DEBUG) still puts $(dtc_cpp_flags)
> > -I$(obj) directly on the HOSTCC command line, and it is part of cmd_dtc=
, so
> > the 'Argument list too long' failure still happens there.
> > Please can you convert it too? It can reuse the same response file.
> >
> > I'd also be interested to know what sort of srctree you are using which
> > overflows the limit. What is the limit?
>
> The failing build had a $(srctree) of 312 characters.
> The limit is MAX_ARG_STRLEN, 128 KiB (131072 bytes) for a single argument=
, which is what make passes to /bin/sh -c as the whole recipe. The dtc comm=
and appears more than once in that string (the command itself and the copy =
passed to fixdep). Over a hundred -I entries, each starting with $(srctree)=
, are part of it, so together with the other flags the command grows with t=
he length of $(srctree) and exceeds the limit for a long enough path.

Got it, thanks.

>
> The other points are addressed in v3: https://lore.kernel.org/all/2026101=
5044923.206217-1-suraj.hanumantkakade@amd.com/
>
> Thanks,
> Suraj

Regards,
Simon
