Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3E606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A7mfECPv;
	dkim=pass (2048-bit key, unprotected) header.d=tezduyar-com.20251104.gappssmtp.com header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AczC1ejf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FAF081105;
	Tue, 20 Oct 2026 13:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7C77YWQaXAMm; Tue, 20 Oct 2026 13:21:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D3A38112A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792502500;
	b=gm1Z8zCzUhnEV++FFkvYOp0eqN+gspA3a1tAd6yx89mTEKHyjdptWGC6nlpMlkqx+pdH
	 P/yZs7Aw+TIrb5Tm0hxzKAQKiM1zjRepdsa5ZDDu19prMFMt6PgHJIKfDiayqGnAavxye
	 qNysK6d+x9u60pWYq7muK2+bsFkOAUXH5seP/vkn0W6PaR8uRd3ozRRQt1RqNwyuTY0ZP
	 txITN5lBOfz5Mnk9rk+/6M6M3X4sTC7wafl+97u7Ltw2r2skVGmuPJvqbReBczUQUHFEM
	 /6jJI5c0xM5GoNV0+LTVnTcRB6TxKd++cPDdG5gWXQqpROb8azumyNDzj6PIrN8Rdyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792502500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
	b=UFoexFG9QxzQUg6Sgtnozbh9y0ChLqVVvgrePlJmQPz8pjW3URX28jyaBi/j7R++aOU4
	 JGVHIV4Lyt4F64SkWhW1H+QcdvnYZPhiZ7Jf/hmjr8lEq62SFMhDV10yXkZLTxzLvuBhq
	 /Q78DsFtEluAMaW/nLrT0LvQx7qWHIEYJWWcFLY9H0L1gGJPEvef3GBqVyjO78g4Rd7MR
	 riDDwz/BQY7LBjNUh0K7Mo2cvyny+bvTAF/+bzXSRP2/jHMTYU16VThVL2/SqZAWp6vU7
	 M+do7dOtwd/ZBESSs29gaU1pYFgrOKLYDc2to3MZfXT9H3cOr65hP2mPtgMohysg4Lw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792502500;
	bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A7mfECPvE0W86+ZFKTzk9W1nSjms2gPC0AFC5IdqA8uLO/k5KXQlmNq6ADlgUAQDx
	 8w3naJAwJiIj1FLVEBe15ImSqTpPcpCeuwLILC35jZSHcQ9hIhFC55FG6oaz4LWVnl
	 RW0LpXqng82tqttr2WnxpLDT7X/5sZHayQ+//g7giKIGAZQENaB5Wu17ce58qvaZQs
	 /lVgY7GBpSCDujrKqmcA0OucFhpzblXdEFoOn15nsNt1rPT+17YQOyP2PwS4MR0r8z
	 xA/gVSrgeAyyH3T6db88erjEzWxdyE8g3ugTQS0x6qP7wUmG5Driqg12OA1tmrnu7b
	 Pj6JnMI1tto1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D3A38112A;
	Tue, 20 Oct 2026 13:21:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C68031DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC63660792
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_CWH3g33uQL for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 12:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 160CB60685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792498574;
 b=EAyEcAIJE6YV9mDkYf2IzQisc3Lo5RC6DHK86dQBogYtDG18kyI+CSHdeOvqL4NN4XW3
 /npAQAAs2P9Txxt7CEIumjYwzbEsdzJecGPTvVdwc+C63yJJCbZgbDipFhJ2drC5BD6VJ
 f7GEl8NpWglbxVfB4hky3PHpeEJh5R4hKEld3G9ChrbZQ1KpRfLyQsc11oyq1DV5lhZ9o
 NdpuHPA0FKnURD6Rw7VectOcU4r2Oe0AZ2/nNnSDzwxbFRGQyDOsqoZHvnNHkntMWa9uS
 gTb9sAJHFUYeB9uC50d90n41QGKTPB8dMnTBi/g5aamDkvAjxiSck5iA3LyZaKOVBrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792498574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Content-Type;
 bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
 b=oZb/fP6ioQnCK/2GHLCo/vI0T2woerRZK7puXknhj6uzqJeukbbt2RDrtcqgBLtLGJgc
 cxsfuoCFf/ax5xdBpqvUnsUEBzl3YRdlaK2uDqdICgyxn5Q0BFengSrEBdoFK6rZSPzhX
 5H1UR0+2JR6fW4b6ONDHlXh+nd0/ZmxYRpDhB4jHuiL+3NlE7NkxwcG5aBzgNUSkszeco
 +ReqxrF/knHbtdf64oyUqm/4s8H5FvsukmbZB1rGtCLXNdNuT7Sy1nfHsYheUGseDQALo
 ZzkBbmy7T3Oq8FVf4TTHwxLLMfJBLs3EO8nsfDK7RbrnnWWzuuuczoxKPcZ4eTYJ/nw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=tezduyar.com;
 dkim=pass header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AczC1ejf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=umut@tezduyar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=tezduyar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AczC1ejf
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 160CB60685
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:16:12 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso3926353a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792498571; cv=none;
 d=google.com; s=arc-20260327;
 b=E/OXLKdan65BhEod89J4uC/ukbT1SL6ehGtKSdIhx1XK9uAjFWQAzVk7L+HiIGuDRA
 l9nQzZRcArm4iTRY8e5Ik4KVI2yMCspqVLMZOBvsEzq1GQ6KVZZOrdF1lR5DW65Qa/cx
 PQKYE56ZntLoeY4v3p9xxJGaVqeO/UfTltT2yQ3d0PvAnYJbNeQBBbpwTYJc89zDllTp
 JCM+SYBhZ06ujKZNSQ7REZj5dQuxRji1E+pWGGdaBDVjX7b/Za6da/qehJGs5PEmHMmp
 EJT9Zavuis0JBckjyc4ifcAheU0SRORNU1MgIA0oVg+q2BTsJozf4XUrIdINOvqxxPOg
 63sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=iV1OqsKO6VRkI2uzvxtJcK8+J2o6RhDpTbG+SRT0pP5S8QJCZJDPYK7fOuE12eNJgO
 jEZDVm4yo24Vz8ib3OCILu4lZhB9eA0Bhu6YhWdeUIN0oJbZ1aJmsDe4srLy/m99jB4q
 LikYavL61b54Au2Rw+HKrDDr3rmi1/p3oiMrZwnZKzQHFRPpcrVhP6ET+vf7hVz5Xapn
 m3SN8LrNDAj84uqrhMUyPI+N1/atA0tX3ycPqjXUrR/kdJUtqm/nQ53txkAcF6FO0foZ
 u20Y75uC7waFcs0I7hXXFpr0BfvDJmNVE/dWunspyzlpYVY5ydZ90lw2IWT7rvlW7vlS
 5NAQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tezduyar-com.20251104.gappssmtp.com; s=20251104; t=1792498571; x=1793103371;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
 b=AczC1ejfiRWEKlxrjFwqtXveM7K1j2jSO90kivGbctx7akbedby2oF8eJhyvUZBfc9
 L/jd1ZKvfUd5Om1HpsqlmImPXJzUuYRku1/k/+s+qLXxXzwH40EV2+kpHpWTzpJg9/I1
 CpbArpLQJ2rULm61Dq5lJ8yLcLpzf0nDG/WuhjwsQBPPg9vZAJXSMzQI04CZ+SDQo8e6
 4XzUPk/D4xvWc8XTKHahfhPjMR7bMDJil3eU+Z5uND1lz6z8zRB2ikA2x/4q4KxVUU8n
 PKpG2GpLEAbo/eqn/oPgexX2JyBsDGBi1tpuHHJ9qsAS5R5/GmUV2CueS4CCujkQje35
 B5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792498571; x=1793103371;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=25DSDsyMeIxRwnMyH2PSXopXAVHKPXGx+yTKfKioBpU=;
 b=Sl/AKsaGrkDWzOwF5GnATWNi64PXD0pfb2+FzZu+OV63ft6dQ0CLqqqUqoBYvN9J0M
 y2RYqTlWRPVUned8rBhB8zE4JytXLSnLoT36rCumPtBlEuNP69OeP8HlsSRTlO/lh8S2
 uFUjskeFjPVfoS37TC3IkDrmm+OFI+e+jzh5Ed4eKFWpAyewdjgDIRJTMesWf+FppgID
 4v8y7jGO2ExzNA3gdM7M1EREBJt2a5aHOPRhmQII4JTq9VxyuHlUiaC9wj6PdyeDgJdz
 tWztAVaRDZ3m9YPs6afye5mVkhd0doKlQci1RwPVCmvnrKv4yqygJbmeIvprH6mA1CsC
 erQQ==
X-Gm-Message-State: AFq9FYIOnHkvR0Kpk2UiydB/Oii4Zo1McGod++zCCJN3hYNyLt5qgnrM
 RKh3pnsw2hqMjUma81zoszcfalQrRnt9losRFTTJnD3yzhVgzGvQK4enLIbZdV/5CwknBfcSivk
 4kk+b4U6w7DPnAutjV8k/0TyB/XDBcNXVrMftvjjOqi+sP5ssLHnZdsWbkQ==
X-Gm-Gg: AYBFou0VwMpy+f6nqNdjumYcPKfe9hEJfU8ubJrlT+geNkcZ8WHRhI1cL/19o5PwIY+
 OFNdQ8QM5ebzJDUSDuYfH77+BPD5j+FxKEIanJot7dBugzpFJBXi5c7pzt0ZdUH6SbfMrCc8x75
 UffzR1Zia8iN8aO9DVnZjitaWOagXBOAzDEw12vO7J22nS6Xep10ZkF7Lp4uDLnoEwdMF9PaX+S
 Eg5jt+7e8h+7nnFHai199VEJ6RDrKNgcIW0dbUU3KzXkJue8qg21E2i9bT+ewQwKIKAQ477dj81
 +y8HwW7n7zpmvIKYDFTL0vvqI66BEXtIPdglbyx9nISoQ6+WISpURewUhFAdRfXQ8gsTTosfdzl
 uCXDlsIvHsbeyRpQ0TkIc1e3CV7Cd8Ch8g34hZZ8tB7MRw6VuQhZI2FezmB4Yk1vW/zw=
X-Received: by 2002:aa7:d803:0:b0:6b1:e474:e0e2 with SMTP id
 4fb4d7f45d1cf-6b3a81dea57mr5240307a12.43.1792498570264; Tue, 20 Oct 2026
 05:16:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Umut Tezduyar Lindskog <umut@tezduyar.com>
Date: Tue, 20 Oct 2026 14:15:44 +0200
X-Gm-Features: AclHuK9g2jxhhJyX6R0HtqD5g_zhwwlfXMu2rOpabiG1aaRVIl6T9tgvoXTPxLQ
Message-ID: <CAFKnvs4jwfemfGE0i0zvg3LyjePU0KZU_1fb68PVeOBD+nqZDw@mail.gmail.com>
Subject: U-Boot UEFI implementation vs EDK II UEFI Payload
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000008b719e065e4498a0"
X-Mailman-Approved-At: Tue, 20 Oct 2026 13:21:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008b719e065e4498a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have been looking into U-Boot=E2=80=99s UEFI implementation and trying to
understand some of the architectural decisions behind it.

I noticed that EDK II has a UefiPayloadPkg component, which is intended to
provide UEFI services on top of an existing bootloader. This made me
curious why U-Boot maintains its own UEFI implementation rather than using
EDK II=E2=80=99s.

I am not suggesting that one approach is better than the other. I am just
trying to understand the history and the trade-offs.

I have a few questions:

1. Was integrating EDK II=E2=80=99s UefiPayloadPkg ever considered for U-Bo=
ot? If
so, what were the main reasons for choosing a native implementation?
2. What are the main advantages of U-Boot=E2=80=99s native UEFI implementat=
ion
compared to using EDK II? Is it primarily about binary size, complexity,
dependencies, or having better control over the implementation?
3. Are there any significant disadvantages to maintaining a separate UEFI
implementation? For example, keeping up with UEFI specifications,
compatibility with EFI applications, or implementing features such as
Secure Boot.
4. Would there be any technical advantages to using EDK II=E2=80=99s UefiPa=
yloadPkg
on top of U-Boot today (instead of it's own UEFI implementation)?

I realize some of these questions might have obvious answers for people
familiar with U-Boot=E2=80=99s history. I am mainly interested in understan=
ding the
design decisions and the reasoning behind having two independent
implementations.

Thanks!
Umut

--0000000000008b719e065e4498a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I have been looking into U-Boot=E2=80=99s UEFI =
implementation and trying to understand some of the architectural decisions=
 behind it.<br><br>I noticed that EDK II has a UefiPayloadPkg component, wh=
ich is intended to provide UEFI services on top of an existing bootloader. =
This made me curious why U-Boot maintains its own UEFI implementation rathe=
r than using EDK II=E2=80=99s.<br><br>I am not suggesting that one approach=
 is better than the other. I am just trying to understand the history and t=
he trade-offs.<br><br>I have a few questions:<br><br>1. Was integrating EDK=
 II=E2=80=99s UefiPayloadPkg ever considered for U-Boot? If so, what were t=
he main reasons for choosing a native implementation?<br>2. What are the ma=
in advantages of U-Boot=E2=80=99s native UEFI implementation compared to us=
ing EDK II? Is it primarily about binary size, complexity, dependencies, or=
 having better control over the implementation?<br>3. Are there any signifi=
cant disadvantages to maintaining a separate UEFI implementation? For examp=
le, keeping up with UEFI specifications, compatibility with EFI application=
s, or implementing features such as Secure Boot.<br>4. Would there be any t=
echnical advantages to using EDK II=E2=80=99s UefiPayloadPkg on top of U-Bo=
ot today (instead of it&#39;s own UEFI implementation)?<br><br>I realize so=
me of these questions might have obvious answers for people familiar with U=
-Boot=E2=80=99s history. I am mainly interested in understanding the design=
 decisions and the reasoning behind having two independent implementations.=
<br><br>Thanks!<br>Umut<br></div>

--0000000000008b719e065e4498a0--
