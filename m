Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CB606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=drw3hyqL;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=M1CByhbF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF1780F34;
	Tue, 20 Oct 2026 12:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4SZqm6BOCdg; Tue, 20 Oct 2026 12:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BACDC80E16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792499401;
	b=UZjvUUFIMh0vblMNEtQ+P1m4nN0J+Gn24sg5WCiN47idxJj5tUxEh9NekN/iDcJ24gXK
	 8J7L5RnjdaUpSiJYqolvwBrx/s5gg8PE0cPPL+fjMb/K49WTQfRYearS5EAyqEqoPzrEN
	 UhBEU3VonQgpbBsXgChyPNuS+WAGgjQs3qzE3N6+vt6Diytd1E9HIou+poJdBi6BUwr2M
	 zDjlwtSl0k+11Qto1wNXOvXC5XHRhB4EKC0aJQNJlCaLCvaIDeQzm5kOGnmPP6UIoeuPm
	 3P9ZDzi6/THT7x/+rFSj6rrAfklbcblhvZKwO3ZHXCUwe/4+0VbfxxVg//1pjReVppA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792499401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D/g/iu1DYNdGCVgqs6gng+QK8aUgtlAXvqmQfRUeEIo=;
	b=BkLz3xMBgBLgTt3aZmBOwuCGrOu5VHj2mZK57MnHZitYMsRluhzmrpOxYeo4/+bo5KhE
	 5ugV/B8lAtGOm5lRqjxg9rvUs5h6XIPnywYhQL9HkQ3cdkHG/AG6Lb8DZt7m/nd8mXl5Q
	 AcQxtcEtfKgYq/xg57NtLZY4IJHY5UPEXhlfyWkA9sdkS7SDV3o3n0ucp5vx5RFQk3awu
	 vroPq0KnlPZNKD2BtonSPadZdnWQ7WMmJnkUs1FJo/adOVeQ+oeyn4iReHh0gIjh3OgwC
	 fQ1w+1j9YpHwsKPZLLDIUqSEC77f6/VESC0Rc/BGAKE0wFtAQMk2RnxIxH1t+jM802A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=M1CByhbF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792499401;
	bh=D/g/iu1DYNdGCVgqs6gng+QK8aUgtlAXvqmQfRUeEIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drw3hyqLdj8/3qJ0Ep2Q3cagpVYMFDsof0GWaZslzy3C5YZxfsMQ8LAGM7ymoi9xt
	 2UJEDlc8Se71KVby5XWFYOzc1VTJa5wbiM0AYWKQl4JsWO1acUBkgLFNB/N+BuTVMc
	 1Uos7FdynoBV0zWHiUZGKps/73kHAd4WF+5Kew7q1rH1jWB1Mo1swI1hKv69rDNeg1
	 H6VNb2j2sBaWQOVq3A+OngY68pX6h6osjhPlXgEl4gdQaMjEIkqDEXXIkBWp67ny/R
	 5xATFeewmK6N3JZ6KaSUFCRYF5J41/hOKzbc5iJD7vpAT5NlZgv4fNH7qcGfoQ7WD+
	 UdiXR8nevNtJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BACDC80E16;
	Tue, 20 Oct 2026 12:30:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AD3F3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 709D380DF7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpbZX14vvxvI for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 12:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E36780E0E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792499399;
 b=btrVZrnz0kN5Dq3fZXWFQPDRJ7Q53knRLC8f6FJfJs6w58NB0T4yd00DU/9OQ9AAawCJ
 Hi3Bmusgr9WC6r0nkp/Mgau0nZanRfxnEPSeirdUbo0i0HzPvvqRY+TOmCedqrc3uiIqg
 4FPNvVgjVVsWtOiKaavh4MRx3zoFcZrl3Uq+VglrZ30FvlbLm21L80hDSvCGld91+79n3
 RNZ4Sp5QVuE1Fj+VsZ7PYzVzMs5owUdMvkv2TKpSBze12E+YN8aIjg556+caDl2zriEY8
 U+GotdojryocbTntu6NTiIHSg5hRYsIcA2PQXNY/mwsKFIdulyHHsqsVnoWJru5Bvlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792499399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=D/g/iu1DYNdGCVgqs6gng+QK8aUgtlAXvqmQfRUeEIo=;
 b=qBCJkiP4UkuTZVRsHBJM8CugFMBoGaKylKZVjoyupxcvDOVC5T0GodkRnrlaJ0dfpgJd
 JFHBzIpsN8VMDU5XW98THC4SYMJgduo2BMdCyv3aiCrfB0bTvYZgZtQcX4jKOtsBl0g8T
 y6ES162ONn4C0gImRKSrgqwy+4rQLmIIOsDBZteST+e3wwGoRrIPR97qAJ7VTjB7cWS2D
 95gqZdEcvtsIgge9PApG6ZTiicL3vyS31QJ0vwWIv8TgXD3hiyELcgm8BN2THyTfbvhjH
 4QAALH/lhQo/J+RZOIsBf83b0QUgv7Zyo1k3A4mJ95gFD/COFl0fmtqLS+Db2kz7cHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=M1CByhbF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=richard@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=M1CByhbF
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E36780E0E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:29:57 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so492936066b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1792499395; x=1793104195;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D/g/iu1DYNdGCVgqs6gng+QK8aUgtlAXvqmQfRUeEIo=;
 b=M1CByhbFgJS2MrmEaCaeQ8yi92PEapHBdAw1NABrimxX1wK+m6HjNHOo11Nc8FPX15
 wS4JPptbbatrDrkFl2tafQgDLz++ZHaVz6+xLHzkQ/wO7fyQUJJdt4pEijDL9/sHZ5V7
 SzOsX6Yna00iEKJCAZpaqXV7Zj3bRXiKl8NeS/veax/2wB1m6DU5+X+N+2+Fynm+LUJ7
 Csz17YhVEjTtHgczdLnrkHkB9vswTlXuHh59Tzp18y3KaCKM8P4oXU0SZv5qK22NVatX
 f6jKVpjqu2rwaNEMBA+Jyc6Z3Rc00SUW45Idxt4KmFy/AEvm9DG4rvHKE/14Bp61pd5C
 I2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499395; x=1793104195;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D/g/iu1DYNdGCVgqs6gng+QK8aUgtlAXvqmQfRUeEIo=;
 b=n+RTqDbs4aUNNRAXj7wmRshuZbnaCbWngu280DaLA/frwXMVP6wkZKQ6WvAMZpGlWC
 nMJioej86k9PqV0D/iIa4Rf+F5oWqa2H12cc4089JPiFchKGHBFk0GAleVU3rjaf16EC
 hCo7YzQ4scxE+7lyrU2Dme91Yl/KP4EEzxSrbnqFRoZXlGXdvEC77A1cFVfL/cUmFMul
 OoljqSPimkbJ3VfESAURVB1nRUL6jBltXsgldNwbAHxTNz2d1XKIjdTUch5+1Xh1AfiZ
 qJEwSbAnQEqnYmWoHakhYmiB/QjtyBSZR8KihxJ1xUkpj8U6deH17vwY9fPBOt+T8xxl
 A/kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwu1H5yLW/sJkTbVrdtmrz2/DKm8ACsB3SnGCFd2j2dV7jGtNSRxbYgOHjTnZEUKXPMfrqZBxk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKUKpG/Y8fD76Jsok7A1SgR0mkfnGb2Lmx7KcwqhoYkTpdyMkul
 Q3RmGbcdbFD/rcIFB/lRi0D4eyGLuPXDL2RKVZd9AOscgjTYvVLsSns7CkTXsozZvNY=
X-Gm-Gg: AYBFou3bzF+GO/y/fns/fWAWLFpTT/QUCQyVQNjG9T9G3xNlou14Gt6ndLsLR2kJObJ
 cRPQLxBs2K6tJWSEEsxhb1ROWZSOqTDzGIOJUVC+38FlQmaBqa13Lzf2AxqY7UEZ9EtLesWhl+L
 qmF4zinBd+j18jChP5YiQeJ5Nfg2Wq6G1W2XZCs95s1tWaMVMsh3YOx6HyeRb+Tv6161xgsV5s6
 GrdIyDf92YsexB038nUgu8Tgh31tgxTQFqnU7EX6rW65mJ3porc9k7sGTWhzUbK8tLfqSIMi+QM
 13R+TicCtg9LahyqIZuQCV0Pi6E1dm9C57HYRTWHTyN5MIyBFOE3MpmSGP4vfX/m63LezNMaLPc
 LcDMia052uzziprDdg+dHjqPavl6//8iXoSEU0+WMaUc/1WHxDOIqab/QV2qVbuAxaZj8plLFaJ
 /o5aeuYDxk10wc3U6AP0FnqBXWQO7pbQE05ZdX87cu/Zrnl8oKaYWjNrCXpyTxl222iheiQpoP+
 cWR0YSo0mQ49aawOqDNItqEJ87dKiClMozIWpqY8Nv3Ux6VaVzSdVYziz7Wf0vw
X-Received: by 2002:a17:907:1889:b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c41a03f73c8mr736013866b.43.1792499395161; 
 Tue, 20 Oct 2026 05:29:55 -0700 (PDT)
Received: from somecomputer ([2001:4bb8:18d:5ed5:28d3:2efe:fa80:adfc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40918c6e6asm468666866b.53.2026.10.20.05.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:29:54 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 14:29:52 +0200
Message-ID: <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
In-Reply-To: <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
 <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Dienstag, 20. Oktober 2026 12:22 Marek Vasut wrote:
> >> -	  writeable flag can be written and modified at runtime. No variables
> >> -	  can be otherwise created, written or imported into the environment.
> >> +	  writeable flag can be written from stored environment. This
> >> +	  restricts only environment loading, not runtime modification using
> >> +	  "env set", etc.
> >=20
> > Wow, just wow.
> > I always assumed that the protection applies also to "env import ..." t=
oo
> > since the documentation explicitly said "written or imported into the e=
nvironment".
> >=20
> > Instead of fixing the documentation, are we sure that this isn't a serv=
e (security)
> > bug which needs addressing?
> If the attacker has access to U-Boot shell, then they have unrestricted=20
> access to the system and it is over (the attacker can e.g. modify memory=
=20
> which can be used to circumvent other protections). For the writeable=20
> list to have any meaningful effect, U-Boot shell access must be disabled=
=20
> (e.g. bootdelay set to -2 or similar). The writeable list protects=20
> U-Boot from importing undesired data from the external environment.

Well, I have a different use case in mind.

What if you have something like this in your bootcmd: "env import -t ${load=
addr} ${filesize}"
to import variables form a file like /boot/extraEnv.txt?
I like this a lot because it allows applications to set various u-boot vari=
ables.
And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITE=
ABLE_LIST
is configured to that set.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


