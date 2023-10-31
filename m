Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A16C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456A7870C0;
	Wed,  1 Nov 2023 00:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKlBA7ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65CC870C0; Wed,  1 Nov 2023 00:06:57 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD2D87061
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simonkbaby@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6ce37d0f1a9so3894900a34.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698793613; x=1699398413; darn=lists.denx.de;
 h=to:message-id:subject:date:mime-version:from
 :content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=eAjjDJdxS8RxuyhF2c2SG1f2HwJ3yy42A7ZeLX5Umts=;
 b=VKlBA7ye80YA28tJtOPvyzrywKc08EaLtzOfQa+EWdEd1uuJzTh8l9MW0LfqDQg41V
 Arxe90NutQTs0MONcJ/dPw8lsyXJKDzGcG0jSCV5TsJ4EfrRwvGHnTd1DdfPlnv7DYXL
 s/j03ppuyBwh3pjcVyWmvdOpLvJ1lac9HqIuHxZwhYWrX5iBf7GmV71bn7jmUpgeswCz
 tNp7Ri4cVPXbVjEONG6h/W75jQf2Jy2RLsKuefU4zV8LJXWeYUtl05Tjp7nSUegOci4L
 0HE7WbIUpuGOIJ0MneczOasCqvL/54lccLLoRoDMIVlwTBe7d7rTHwJzEugBmrYRvgK7
 1dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698793613; x=1699398413;
 h=to:message-id:subject:date:mime-version:from
 :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eAjjDJdxS8RxuyhF2c2SG1f2HwJ3yy42A7ZeLX5Umts=;
 b=TfW4i20DqZfmteUVRZ9S4I27I9ptUjwmBM8JWUmYCDM1ER38FskBPJjkUpMnGuYfgg
 MHhMtuGF0ly5eVv2UCGrRJ/P0+NiLWjvmGnPzfvIRD0yBsuT4Amrs5hVHKSbrXyW+iDO
 knMLcSy96Ewle/j335rnG7JPrp5DSTjBFjJlLUFHM1C4k23/3HZ/H5wsQBSsHoTM9V/q
 kLSOL9neR7qkb1+sjIA+gWW+aYApr9DWwdyw+UC9s2LmPpanc3JaYNSDB6gTf4X2qv6F
 EwXtNA17e3rhjXSP1YCjJ+R1QwFiXmSXrcb9fqlRoDZx93icaQ/5hlvmnhUWu5pVDbjZ
 /n+Q==
X-Gm-Message-State: AOJu0YzX+hHV2RMwDvDq51KyXr236JgTQf6HQ87HuigF2mF3scxbcDQ4
 RR+6QfXWX/QMoveSqbDj+Wi+uu92q/0=
X-Google-Smtp-Source: AGHT+IGk2PGgmq4chiGInD9bZtrVsr72A5v/v58q3rWulwOenb3N+kSEtYI211JcYuGCEvpvAMsbeg==
X-Received: by 2002:a05:6830:20ce:b0:6bd:836:4fc2 with SMTP id
 z14-20020a05683020ce00b006bd08364fc2mr15478703otq.17.1698793612838; 
 Tue, 31 Oct 2023 16:06:52 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:701b:f7e5:69b1:c8b0:5032:982c])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a056830245700b006c7c1868b05sm45785otr.50.2023.10.31.16.06.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 16:06:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Mime-Version: 1.0 (1.0)
Date: Tue, 31 Oct 2023 16:06:41 -0700
Subject: U-boot env in binary format 
Message-Id: <DDC56A09-6749-48A5-A4E2-B58D2BD5C7D9@gmail.com>
To: u-boot@lists.denx.de
X-Mailer: iPhone Mail (20G81)
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

Hello ,
Can I know if I could generate uboot env file in binary format as part of my=
 build process ?
Currently it generate as a text file .

Regards
Simon

Sent from my iPhone=
