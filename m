Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21E606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=glBsDl9T;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbFUnyl2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2742605F1;
	Sun,  1 Nov 2026 02:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nblGXUYA7Bvh; Sun,  1 Nov 2026 02:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E43056060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793498949;
	b=BZ2Jz/6Pk4Sq4vwbBcqTEAOCA+OOuyq1mHclI+dsUjtfIcBjswIienFr51Ve6h/YyOBK
	 7p1twtIx5/fqcXB4cbO4DEnEbbrtDSsK5uYSJcnjJv4sezVVee75iraS5suHtNHdWuia2
	 rvENdDRnqfq/PeUzI6kOm4tQ2jw4fty/oUfhQ0Lvd6koCJEjeF16/hvO4ia4o+b2KXQj7
	 zWnOLlfFKf05OBXeqV8vsOphCWXlrxpmlasEIaIRpRhoJI4Wp+uRvYsrRSmIaM1nXzA4F
	 EdI1dspQICZzlQXXvsqykmTOphFf4a9cenuRoGa3y2fPVgtRrH9dF6AserRiGE67l7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793498949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
	b=ocT3e9YuNWJ3Y5eLTLQoENhtAxBgLnsHtKV9qVxPAr2agsU6gMclY3h4xjJ+ZhNcWyHb
	 6EdR0dyTW9cFfAwYD6Ky9dojq7v7EM11umOuElyvX8A61zy47SYRghsOssUdf2OQJjxf0
	 VqJF9MRAexGwu9NIi9/ndCMm4UhvZFQnhsVdtAaXAfxXWz95kDejNKJWmQ6Ajaopyy2TY
	 YMkrjzgW/FeSSL4SKS0P8M5uRxjkaJkbkRCtrOH/9sVqnNk26RaKMXqyUzUJgx8sc1imy
	 wZiX6ARoQOHYpOhcBvsPAwE+42g1G+dla18RW6uae2UchbTzEZH018eV1N75UpoliNg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793498949;
	bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glBsDl9TrY02dnAOapqXZv0tjNgSpvzMeJJTjoZd7/8UjAKFWLmnls7diyDv6mdey
	 cntjgYhVX/h3qcgLa2X4bYlrlUssYagiupI/KDdT0NYpC1Lql8603FeTw6OnVMim6B
	 T/ahUEAi+xEVts39Sq17cIutzWzBKbYft0xhrlwI4DsihOXpgpn+eJE8rBjZ5EUJ5s
	 RSTHLHwjnee80eQaMTyJCYGnDv/aMouuWdZe5UI21a4am8tqDo4QEX7p5AosC0Tcns
	 NhEWHGC0o1d8WR7I3eZuGyCPJQDoOaRZ/PkTHdQdXH7vzvC7xkoZnI2t6F1BphZvFn
	 48eOCQaR+Vvfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E43056060D;
	Sun,  1 Nov 2026 02:09:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF51F380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D10A680DCE
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYDHwscvbJTM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 02:09:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13FC080DAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793498946;
 b=m+6BzbfKs3UamLfHO1V5OO02tnopdTgo3aSf30K/cLY0aELRqZl5tA4CdXvvW1ZDzg68
 V7vx4bgCuwfaPmQi5gAhZxw/ti+PpMDapHNnc+BEV+B27NEwFncwf+I/3PhteLIix14PO
 77mWwXB+XNHZMk9FTsWYvKFzpIESlbcVsnswvuKFbbSyQPRjTgsMQEoUHEsIxOgynZEBW
 F5kSMsW3c3a+8NIOXo0l9cAe8ZmAq7OSqQEirACUkl3yiYKZg/9OkXtXGTNdQQj2u39TH
 hEt5lJ4ILb05EMjvzCONY0TXzE6wFJREQTpXpFxp0MjJBa/JiqEj94ohbwC8NdP0Bjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793498946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
 b=ShUfiLhololgIAjV+SpsgCaFV1VvgSQY59EOPAwa4fVRLErzdIw3K95UEUNXSKXZ1cIW
 0lU9QlwCt6sRKUpbzOdPJGD+Z6HJOPiiOv83rDOb0JbA6bgyR71YuAaBlJZJoUGARRB2e
 vQOU5WQwhfjLI35/GOMZ9by0hiErPFo/53QUra/ZM+NKw2apfjVLUxiAsakxqYmaQhPbD
 g2OTIgCkZtrAN4FhOtVo5nhJ4RT+AQQiXrp+Cbpo+ISX3q1ifJ+T0hy0iQ6XEgiNHx7of
 7nP6jUWY2mIFibcvHMIdKAq4Nkny9hAsDkP9SlbRywFUWrUAWdYxuzm5t+ZmnL9XAug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YbFUnyl2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YbFUnyl2
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13FC080DAB
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:09:05 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso40261eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 19:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793498944; cv=none;
 d=google.com; s=arc-20260327;
 b=XsBsIXjQda8mN6EhwYES6X+9GGr+/MUAt3OcDz81D2Tj1Xx2pRPCBkdT+ONNwCAkQx
 MXeouWXyYRLgI91bGWmuGiUyZ1mxYoZYuXj/TtE4th0edyfKh469wYMcZTPfz/irJ3H2
 hRlbKRaDV2LMygk7BDPQ/xghLc1lO60tBp5MxAyMmnlB0MfTcCj4lGs+nRfFH53aXyWh
 P2o74VfY5O79lGtzabPRXRQNXaOFcOBXzcOqAi7aqIPVCHQh38BQWcbv1Ijun7QCmAV2
 BQ8HWG2Y5j/yFHrnwTZSX65bstteEJ0JpCO1oZq4AMuKCjZj1zwAQm9lzWkU9G/N6uFe
 Rruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
 fh=iy9ltC31QH1D3aFlDE96HQTfqhjTJOYJLKjhoUe8fJc=;
 b=iF1wcF8/uU9FxC7UtzwmS1pTsqTZQPFh1pQthei4C3vuVpb4cQ9lLdx+vKHfnRltHT
 EW4pzOHMBWtudh7/mBWx93jqdCz6qLwN3/O05bsxGiNtWA0cyj1hShKoSVHXZ4N+bRVJ
 YuLZi0dODX1clOGXvWhAsvOnc2ulNz8hab/D1kF//BEW+WO0fqlfdm8KiK1wIc/R0dQw
 0gI37SGIA1jF4zQpEA4x2PBvchZv1giSA9mHO0OGddmfhCgG59Y0A1Gi1LgCUGOcUGgw
 SOexBns7cNeiGK5qPdr2x4UHSnzo+tgxb1OHy8yfmnOsBgTt8Bmu+4ysZSC60RHMnMj2
 jaQg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793498944; x=1794103744;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
 b=YbFUnyl2IWKUMvDJkpG1fz6Ri6vzt2heYeCddEuH1frCTtd8groTDm4TsqdnfD4xrV
 mys/pBiE/4iTIw3ZohZ5b5l2XLE9LmBGseBW6UyCYchjZoWVoRipxGjp7Wazs/n/wtbT
 AwUrDPX7vs5BOcxIBsvap1akqE2oSEoFKRr5DaND3Q6zqvI0UETEATj68hxIzSTubB20
 e5tn2wKRDTp2E3iz/jY9w/xx/oERJvFTWEPpaWKH3yUBnl266qyLPcFZgSWHoY47AUja
 Kgf+mcQjJK10Qz9MG1rVfLUPjPOza2REcObEC+bOKJSo2PW5Efd0DSl+efzij+y1Xv/k
 Z8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793498944; x=1794103744;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sg5rxH1I2t6NbARFNM1eq8aqYm49qhuahE5hg1+8JFY=;
 b=mRMDQjR4zPIHttBxBPOQIg/mtvR/iH1eymDDo2EVdb/h7X3ETwx2bt9jklK08QuQZR
 En+9a7GWGHZX7X7ZxVYJ4mBJGtRIDgh2SmNLR8Slf/GS0/G3xdeeFdvMML6jtGvS/fZc
 oGF0tfZhRSVFh3XYVfJYtZAUud1o2mAIKY29x2UzsO1SmXGhNF++lpvT2T2KSTLbHvae
 KsE7bviKvKfocdj0PK9uocFD/zpFwapgzDyunEPSC1VWsF3E+YsKvysraPk3+yCJRYwD
 iJv9cVx0LGljKVC1S5HpI+LH0GV72y7jvJwDE1DvWJJgFwKM6c7Ke7MklxDNoA+Gtxtg
 5CHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhsXrU+wIFPeZF+YL7tBcmWjfw8LcsxUNI04mLQYIaaOGYA9/qFoSy2LB3D3vNd7H/NoJu12U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJ1d7aD6Qlh58Y5i85pFdsgLdc3vvauVD1sYkaIgQhXuN64hnp
 V1pT0//4+bA+NmerUWsEPVMJheonTmStnRxrM2KVokLTku7rYKbwTl2Kq4ngYKdXQW5PdN5uVP3
 EHWm9YB8i/5kA/2xRUaxDdVVFjIBicc8=
X-Gm-Gg: AYBFou3seCJ3FMiq+GLN9NFoIFJPipITELDZXopX2w7GfV7kYli0PSM9gFoDtMBBFrb
 zMzcz7te4uStegsvTk6V8T7NOkXr4QYvX2cFPv3p2n0XV9VmXut2g37i/fAWDGFcQwl+bDQhJbg
 yT3QzHcLqiskVEcyDsZ8gAyXBTaRa/D+/l5y2sm4sTshJDHVp2zkQOWf+SFkpF39euM4JDgjvQj
 5UOScf8hftwI77wqB61tZhlRGTmh+374aNFUWmjEWezRAYHnb6Pp7GYvj7OSTPnx1xAObyRcEV8
 x+VAvJbUfzZg7gylSDQr/nu2zSgx/X1G7fNUEA8ronEVE1NTsHDKOQaN/Fe+78JT4VFHZ8NvxVQ
 0Epduwy1tGR/kqaHOGK/WvHhlT12B2IDvFoz5n5Zon43gZ0X9qBXNNLPS7RQfz7Q4Kl3r+AeUIo
 IxXQN7G8+BnLBjLI3QKk/U3r4QrNHFWvvCNaqrUhQhbHXGKTEx/ywQs7GqsAQ=
X-Received: by 2002:a05:693c:6393:20b0:369:f291:49da with SMTP id
 5a478bee46e88-36a4243f71emr9741165eec.40.1793498944120; Sat, 31 Oct 2026
 19:09:04 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 31 Oct 2026 22:09:03 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 31 Oct 2026 22:09:03 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: khaliforce <kforce@gmail.com>
In-Reply-To: <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
 <20261016000442.GG259661@bill-the-cat>
 <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
Date: Sat, 31 Oct 2026 22:09:03 -0400
X-Gm-Features: AclHuK-ggMdi1uHzWpRkFhy1DokKMwQerozSsPyHSTh9jxjTXcj3YP_Q49l-J8g
Message-ID: <CADskdwnLQymCXCvOAop_9uPO0_nWQH-dTcJa77uU+s+0sLctTQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>
Cc: Romain Beauxis <romain.beauxis@gmail.com>, u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek, Tom,

I retested v2 on MangoPi MQ Pro using the downstream D1 port
based on U-Boot v2026.10.

The boot path was U-Boot -> GRUB EFI -> Linux 7.3.1.

Two USB hubs were cascaded, with one flash drive on each hub:
- Near: 64GB Samsung Flash Drive FIT, attached to the first hub.
- Far: 8GB USB Flash Disk, attached to the second hub.

I added temporary port-path and device-identity traces.
I matched the serial numbers against Linux to confirm each drive.
No manual "usb stop" command was used.

Relevant excerpts follow, with intermediate lines omitted:

USBTRACE identity path=usb@4200000/0/1/2/3 vid=090c pid=1000
serial=5610050000154305 product="USB Flash Disk"
USBTRACE done path=usb@4200000/0/1/2/3 driver=usb_mass_storage
flags=4000 active=0
USBTRACE done path=usb@4200000/0/1/2 driver=usb_hub flags=4000 active=0
USBTRACE identity path=usb@4200000/0/1/3 vid=090c pid=1000
serial=0352315070000417 product="Flash Drive FIT"
USBTRACE done path=usb@4200000/0/1/3 driver=usb_mass_storage flags=4000 active=0
USBTRACE done path=usb@4200000/0/1 driver=usb_hub flags=4000 active=0
USBTRACE done path=usb@4200000/0 driver=usb_hub flags=4000 active=0
USBTRACE ehci_deregister dev=usb@4200000 ret=0
USBTRACE done path=usb@4200000 driver=ehci_generic flags=4600 active=0
USBTRACE ohci_deregister dev=usb@4200400 ret=0

The farther drive was removed before the nearer drive.
Children were removed before their parent hubs and the EHCI controller.

Linux booted successfully, detected both drives, and reported
no failed services.

Both drives used EHCI. OHCI had no external devices.
I lack suitable hardware to test downstream device removal through OHCI.

Thanks,
khaliforce


On Sat, 31 Oct 2026 07:38:46 +0100, Marek Vasut <marex@nabladev.com> wrote:
> On 10/16/26 2:04 AM, Tom Rini wrote:
> > On Thu, Oct 15, 2026 at 11:17:28PM +0200, Marek Vasut wrote:
> >> On 10/12/26 12:31 AM, Tom Rini wrote:
> >>
> >> [...]
> >>
> >>>>> I believe the answer there is that we have flags to handle this problem
> >>>>> generically rather than hard-coding a call in every arch's
> >>>>> boot_prep_linux or similar like we had to with the old USB gadget stack.
> >>>> This is shutting down host, not gadget. And I believe usb_stop() is
> >>>> necessary to correctly shut down the devices on the USB bus, while the
> >>>> DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so both
> >>>> are needed.
> >>>
> >>> Host or gadget isn't the point here, it's that we used to hard-code the
> >>> stop function call for the non-DM driver and now we have driver model
> >>> and flags. Everything should be able to properly unwind with flags being
> >>> set.
> >> So what needs to be tested is whether the flags are enough to properly stop
> >> devices downstream of the controller, or whether we need something more,
> >> possibly equivalent of "usb stop" in the USB uclass pre_remove callback or
> >> some such thing.
> >
> > What more testing do we need at this point to see what
> > DM-related-unwinding that usb_stop does that isn't also covered by
> > adding this flag to the controllers that are missing it?
> Plug two or more hubs into each other and then into the controller, then
> connect at least one USB stick into each hub, start booting and see if
> those devices get removed in the correct order (stick furthest from the
> controller first, nearest stick one before last, controller last). This
> is my concern here.
