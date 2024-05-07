Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9758C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A22A8834B;
	Tue,  7 May 2024 16:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkzTrBLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAA68874A; Tue,  7 May 2024 15:21:46 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1199687D2F
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 15:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoni.s.jankowski@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43caa36b9f4so10481141cf.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715088103; x=1715692903; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BbarOnUc5PLmBoKxfzjybpFVwpHbJugYJOHjZkW/QuA=;
 b=jkzTrBLeSPQf0sOAJNg+4m1oqGDIjH8rk64wOSaSJXVh1fERN602OEcdWWGp/mcoyq
 slwMgXBBntR3Bm6Q003JsE36IxI6/ivlAiwjBqzb9m9/xCbo8u7SoFXFqgFZHMYn/+mP
 9lyRLrvc42zsVgVDxiFC/EZ9uDEwaCTCiclNxSsqyJiwcwQYwTvhIiHDFdDJht2u5SLc
 tmP0C/+pxODaG3HPBK6p5wNbeeCu32WS8ezFt2IH2SomiKtMt1vu8/EiZA985RLmOJbY
 6vghWUileyl+oCORqvGjkqvjTQBZSllUTTGHONxFz9wSAvzbRDl76vX2Rm9Hjic1QyNR
 j6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088103; x=1715692903;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BbarOnUc5PLmBoKxfzjybpFVwpHbJugYJOHjZkW/QuA=;
 b=f2Ufzz69IVX38ZRSZyVlwCuednyPpHNdMyeYX7iZC1dbE/h4Vt/xplcw8RCkv3xrg8
 U/CgEDuPpt/qYbtaAL33EdvHUgwb7Iy8yrG5akq2aNb5mnd4b15SBCLMtJCA4aCHSF3o
 jLGW5KgSnoLFKL8iUMhwyXTUdf/va3jigKYfSpnSPToLJYzzdCP+x6eaLy3ISmg4yTkf
 Qr79zphK3ukLO+URHZKxZd3puQbebWZeNEBZqfQoWaARmBCxoxTxWaqX6L97xZ6qqg5Q
 dMV/ZVlmc2g8CePqQ3aMDxjCZQolUPKnxeX/IyrxNhVgC6i1nOLD5tZKU/BtgITSJvBS
 yh3w==
X-Gm-Message-State: AOJu0Yx1JZwcQperO8KokiBuALyDcMZe/I0w0pZkSD58e5vBobnJv0Hw
 GwzXtg4UyM4X8UDobf0d1QSbv7ieB+GPnS47MUVAVc1Ww3Xnjk4jGiki/0Aa6jDW+ytK4NcaQCr
 yhqukHE9ReJ48opo9MxF1TRiuWT3sLRZM
X-Google-Smtp-Source: AGHT+IEZC6Rwk7IxpmU01h/iVfNMGBr73NmqU7af4eXwVGgFoxb8X0emmECF/mfm/CiTZHgKlrSIWgtOEc4zMOkELFU=
X-Received: by 2002:ac8:7d84:0:b0:43a:ea68:e0c2 with SMTP id
 c4-20020ac87d84000000b0043aea68e0c2mr15624265qtd.5.1715088102807; Tue, 07 May
 2024 06:21:42 -0700 (PDT)
MIME-Version: 1.0
From: Antoni Jankowski <antoni.s.jankowski@gmail.com>
Date: Tue, 7 May 2024 16:21:31 +0300
Message-ID: <CAM4sPk-un78JmrMQpAe24nWMp0ytrieyL3zrZd_Qg9HOm--gtg@mail.gmail.com>
Subject: Distro Boot instructions with examples
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 07 May 2024 16:14:24 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

I've recently learned about the Distro Boot feature of u-boot. This sounds
interesting, however the official instructions are sparse and examples seem
to be non-existent.

The platform I'm working with at the moment is a raspberry pi CM4, are
there any examples of how to implement this concept? Distro Boot seems to
be suitable for updating all the rootfs at once, including what usually is
a separate boot partition.

Best regards,
Antoni
