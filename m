Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA03DCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 08:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DD33407A0;
	Sun, 11 Oct 2026 08:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdiAMIpwEGjV; Sun, 11 Oct 2026 08:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94DBD406C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707386;
	b=LxiJYecJV/hZwiUKaJ7y+BkTCi0vdJTfnDevGMjzRfv2uSeNepkZwtPQDBg9trP4BqWR
	 s6pqpjosFV8LLK8k4TWN+E0eGgCSJcpF9plpdAMncPko2+8JBYxVx+rQ2RlX/VV9i7oGN
	 PxFtsf25R8/RGqWCjlw0u3jip13rQQtHOzNOd1jHieuf+YkPp8DXc1VeKtmT5jEibo2IM
	 hIkSXoOltVGqYoSL4Bk/LL8joNi6QRcI7eqaSin73g0UMXpwPVJOGVb1fVygm0I2Zw0eh
	 sNLlT7A6GWcZUolzwR7Ir5o4ansm1D8+jFLmsyKhp0LocC+cWFcwDtFvbKkidJYpXkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791707386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
	b=OLdWrnA6yfEuAobcPDts94zwdghaE1prbjAMl0X7a3ON7xi5G9LdShcONdUy8Jn39Dn0
	 1Gi6e+mSfyWAXOgnmYOE7dXwWCpyfC2hZuBgfJU6Jgeq3VRLWtAl/bdqQ020ALteTce4c
	 McOnQ/X7l08HxnYjLM051Os0jnIQwuXR4NTko/XUHq7jicrEaYoJsNBVEiDeRmKdFKSqg
	 FZztp6DueBPGt0ReqCXDn1xJDd8OW4e0fqGpNHLOpEMfkukw+n/B8NnxA2bq2DfcffXqV
	 rDY+PVGt/IVyHKqIIxeii3ycCbm6y2eLZ8jYdPnbzSmdUlo7VxCK5SlEWNDUwEVasSw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791707386;
	bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PvcejMOsel9D3Kayk6rmqROyUv0QGD+FqTZa3Aml1bjsDfkqkt0gNmjPsdEwSzS4Y
	 NT3kqY/Z01EnawG4Cv6n6LX74xrv+DXhyuLBOqX89UvBLvYtA8B14ctiENS4xfidGK
	 pv+RO/oWDwz3llLqJ5S3UP05FLufCOwCnmLLzl6hny8KDPA0ArELgbw21G54LN89EB
	 Ih/N3MaeGuw7WxV3lKL4so+xCInzoK1CXjEMgVHHfFNhlbSb2GSMq3jQDQm4ydDibU
	 BqXf/cXJUYw86lbu2LqplV6MqalduKDqbdt3TkgqdkE0a2gXhDqD+JkdDWncr2ORlu
	 kfZoP1OGxhzVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94DBD406C9;
	Sun, 11 Oct 2026 08:29:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE54C1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEF4360644
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:29:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJSWiQ7chbyl for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 08:29:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B837C60638
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707385;
 b=kUUGuUqEvr6hBwvRYwHXSaxuUU7f94Y1AH3TMt7eagRW416ISRZNvo1QmcQAvBq+oH12
 W9KYb43sgYAopXuZBPWsUS4MDOB/WTQMnd4Da0eifjkY29Lxzb9vPXiR1BaTOr4oYonFY
 CA3HyZjbmqlNKimQnCZFlcgbc64j+vTh+ElzQUjnOUv9GClSmdBCBVP1riX9RmPiRVa/4
 zfmKBPzYPRFww6J1+ZUpXzRMqtYoBRMAuUXSajLvI0TpvoxGva3+CGDDTIBK2X3fe9+vF
 En2mQNO1HWfc+Yuy+HltmJAkVTWYQ6NEQI7oFIvY07StoKEsvkYFb+o2ZdUSXJ0Fjsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791707385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
 b=IakwLVafSQfL0AMUp6WpVnm+modFSCCuk8wVGQOSB4wDbsEHCPwYhgjYHq3KGO17LT62
 UkE+8e9dcIBIik06CfXrXoB0j3jAlbHnSdVmH7klWeZDF/t9khujkrhan0CqCMFO2udsM
 YY44ja76Yg6GsQ5bIWKDPn0FgJWC7Mb6o/5N2GqrP5iEm2qeUOnVbRoYtrxgJ9l1Vr3JL
 JUy2qzU9XssuNp8h9/ovdojITGbTwaXwKV4VRbH/9CLeNK9C3EVFmSCbn1ABNH2f3NvP4
 qr2go43R54lQHd5X5xR/kYmZS25f5we9eP6O5quofELqzjpNfZlAVpXyXFVMfSDpyBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h1zfEtST; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h1zfEtST
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B837C60638
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:29:44 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso464199a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 01:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791707382; cv=none;
 d=google.com; s=arc-20260327;
 b=cajvv/0NyWlVd9mpIhPgtlkkU0WejzYal/wu70+gW7CkKaF8jNFVLAt0DH2b/eS3hQ
 R0FKkSq+0tSXTdgBt/DMuBqdy/Y5mblY5/wrli0WTnbf8+qdCOx4MOnnJUc65P4Krn4/
 km7xFZEMQ1dXygPJCZI2/JztMmK2dWDPB1GvxD5jS0pAAItz9VEKP5fj8lm1sMD2wJdB
 qWHx0fgEucCeC+j8OOJJ12vqnUICP/5Ol6eoQknPu2QunJWNzkSsC3HF+7aJ6i74C+lj
 rhBI6ujKHNO9vLiKr2/MV3SYog5aVN8l74REPIH+VdU7p0IEhwzlIG/QP993nsCoFEMw
 qxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
 fh=PisyWqpOt3KgwGOMNTdTJHnls/W+CsMJkBK+ozL1iPw=;
 b=PuvbYV7aNY/cm6A4QmG1gY2G400bd1Q8ZNe08zU+dl0ycV5B1VM0Hxnv48q5X7BowQ
 B/aY+ylEatBVFmhgkk9kszONqnA7plxir+7BScfOinXyjhfilEC2G/Pw1l3Xhe1fnuMJ
 YPjo+Ixf5gUwIhLJGy9EQeAukLjfvGuSk0X6fr4FEesDvuVe4z1Pg8zf3bqRAwKVkYZB
 8qIzLz7nnqZpFiIMnbYtmJIU7n5X06J3/JnkyE4773zReZWEBZqW49oKBk982x1uX2y2
 rvWKKL2muH0WYxMHiZCC1LFCmpSU22+LJOZxs1IFnKoJP1PaDTBfnk6cGLCsKP+OpToA
 FeCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791707382; x=1792312182;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
 b=h1zfEtST3iVuF02rARNA50OFElQSmX7cUWBVbfG4tD/BBk8tZeZ3US+GW+/Md3T+AO
 bTaOQOkEtqdd7nIUpqfQg6GhFkK+MtWOnJy2n/fuTggbdxJOBFLGb6TooipmqUKg/Ng8
 vloiyjB1YegKlxwXtgX+2c+Bg8l41UwdeGghI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791707382; x=1792312182;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2PnOWPYSwGANi5HtvmDZhcyMuz+qsUa/BN+s2LsvWXI=;
 b=D+9pwjKE4jqwEJcyYaD3b9xfDoczDPCtBdZ1/jkoStLo5ZwG1NgSFdyf+CVEqhoRt8
 thu59onV5wzEUw4ZX70qkFUS5rlFMQBNACO2famGze1wPXNC1tVHhb+SEsDRS6W3WMij
 5tDskDhYnIt/SJ4Gbm1Ql8c/GI3J1eNmfh2eNkpnY9C9Q2oHPns/K1wmjglmHkf5reQC
 DzSXK7qUPENLOLLuyHkvDQHKK9BvkTUx0nbG+BzpVsB1J51CFL3JpZXmZ2o7khbDSfou
 SzoeIpxLTolG0wG3ZiAbUcSxlo6/KbpIubgQhz9QjrcZO0jwMK6DUUSWU8iEnozc1sUd
 N4Kw==
X-Gm-Message-State: AFq9FYJ7hv+/VXk/FuYY7jHrqBhfSdd/xHAU7esa+6FDffhbniGFDTGS
 8oscfF39jCpFvliOXceVn0Aml7Lo4dTD41veJfI3/GGXm7X0nSr+YL0cB3tkljMRocvr/NKhEto
 +XqHFaJ2cIFsYiPHlNjDzoQw6nd+eqvUYmhuVVaUTD8V557lk9H4/sA==
X-Gm-Gg: AYBFou1+kHu+bCQYn00y408hrf+1tD0ssuebdsVGGwNDR0F0twccGzXCDfj+bcof5jh
 92JPYhhT3D356Asw1zqt1dR8goQ2pi4C7ZVlrBkRt6tyX9ACWfiCAWH4Otox5MgMsZske4A5gb0
 xaRswNvuDG8W1U7tr8Xl8hJzdSFzyyM1CQNs7mb8CIkQtFBBFNRNwuYZYA53MSbTHc2Pyv+adbL
 VtBUfMXHjGidRg9cyTSSqOr320rCvkPicxrx99YX6xLTrh9aM58kdf57b2FLFjsBF44Do54nk+h
 oO9nytQj7qHbEAsWCJmxJR42maL+WxClD2f1egQNiJXoFZwgLUfJ5tA=
X-Received: by 2002:a05:6402:529a:b0:6af:a270:b2b2 with SMTP id
 4fb4d7f45d1cf-6b17c163ac1mr6479772a12.0.1791707382511; Sun, 11 Oct 2026
 01:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261006110919.396293-1-prasad.kummari@amd.com>
In-Reply-To: <20261006110919.396293-1-prasad.kummari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 09:29:29 +0100
X-Gm-Features: AclHuK-qMMBrb5j62jJhjy3C3hfSFPc1u945_QLiHtGJ6pGv15LHv57sdfFygA8
Message-ID: <CAFLszTj=S5qCd9VkafcO_8q5EBa3yY7+Ma_=mX3eGO-_B0gcEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rsa: fix rsa_gen_key_prop() buffer-sizing and
 zero-modulus handling
To: prasad.kummari@amd.com
Cc: u-boot@lists.u-boot-project.org, git@amd.com, trini@konsulko.com, 
 sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Prasad,

On 2026-10-06T11:09:17, Prasad Kummari <prasad.kummari@amd.com> wrote:

> UT:

>
> Sandbox:
>
> => ut lib lib_rsa_keyprop_oob

I'm not seeing this test in the v2 series?

On the out-of-bounds test, a one-word heap overrun usually goes
unnoticed, so please check that the test really fails without patch 1.
For example, it could check the heap with mallinfo() or a guard word
after the allocation. Otherwise it only shows that a 2056-bit key with
a leading zero byte is decoded.

Regards,
Simon
