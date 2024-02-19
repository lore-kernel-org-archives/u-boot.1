Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7886C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 16:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0772487F46;
	Mon, 19 Feb 2024 17:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="msOwY9OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABF087DDA; Mon, 19 Feb 2024 17:32:27 +0100 (CET)
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com
 [IPv6:2a00:1450:4864:20::24a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957F683CF3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3kYLTZQYKBho10HD0I6EE6B4.2ECK-1EEJB8IJI.34DN.34@flex--barnas.bounces.google.com
Received: by mail-lj1-x24a.google.com with SMTP id
 38308e7fff4ca-2d23d2bd17fso8336511fa.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708360338; x=1708965138; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C2eQfBNdiL33t+IxFqWEfUAbJ3JZZmnmdLCrNl+nSXw=;
 b=msOwY9OGpLlvxR67+Oy0eXQaczRKaB6K/fg4GpjISS+CwyL0F5s1ky5P4dGAdSf8Vg
 3BQ3uJE+Ii5wfG8uwzs4JPi8iNkp/ss8G24Y0p7gg0yECHoVIgwewatxGTEu8EF5JwWR
 sr3odsdFzH9//HYfO4SM4FeY+rLq7sAsLD1ipTqltJ627hECFOT1lUBtu6ptZqvW0D6W
 a7+uFFHjfkNAVDHbYnvv0Uq3LNw/lBkgUoUkKIX26qLEYtgl9oSEkWXq7pmM+aivp7o2
 Pt5INWJ93+C8J50O8nvNbZDLcmR5rni76+lpFezUVTe4tOdIWM4gkNGF7o2NMu8W6G+p
 k6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360338; x=1708965138;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2eQfBNdiL33t+IxFqWEfUAbJ3JZZmnmdLCrNl+nSXw=;
 b=ouvL5eFnZ0Ity/n/ljxoFKqhOwwW7HXCBCLCNYUOSVcIrivBm4Fm0gRJ1z9xO9Oooh
 1NOxYJ+g7VdTuvxyMon4n1ZTLXpN3F/zcaY7oXqIOEfnYhRDGjb4ozxgqwkx+zgdM2DM
 l/g104QMBNFp8urgY435FlHO1C3VQe66S5KhKaQTh78bveysSHHZSM5MyCNvwD/0qR0V
 IK+AL2yawI9UUvPLhxvT3Qat07OQZnFICgfK+U72Ci2PtTE7LJzxemW4y5/u0A7JTCdM
 Y0LJkex8JX08Y0DlEW01Qs7bzAZcXyGX1Dt9RV6ktJlwRFPZrjfmUT65Ij6/e0EG3MGz
 6+tA==
X-Gm-Message-State: AOJu0Yy8TO5EgghI3YwXwKwTqG7tLpyMUtn18VZuVcHyO/LtSiScyFJb
 hAHIleCIDxsZoQwt+mBGPGvOgeKViuzUSr7t4N+zPVbXl55YzzlGHcFgX4qFkNRztBnF0Lm0Q9a
 oSvxFRQdtkcid7vQ+4xZ3kgz3Rg8IoEaNAZiWz/6isChIFfDnhv1eBRER7CtW0f4n2nJ5iedqPc
 V5GMjSwlQr9e9eKAbgXSor7/4pSBj0hA==
X-Google-Smtp-Source: AGHT+IFY4BQHJxrdf32VTEMXtXd3kW0yrVnT55YNyI2mnsAr9BwR1701y2NCfwEEERNWqxBIEsEYcyM2bnE=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a2e:95d2:0:b0:2d2:3fdc:b914 with SMTP id
 y18-20020a2e95d2000000b002d23fdcb914mr2196ljh.0.1708360337406; Mon, 19 Feb
 2024 08:32:17 -0800 (PST)
Date: Mon, 19 Feb 2024 16:32:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219163213.855667-1-barnas@google.com>
Subject: [PATCH 0/3] Fix driver for misc/atsha204a
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Feb 2024 17:35:44 +0100
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


Fix the driver to behave like the chip datasheet requires.
Improve wake up function to send low signal on SDA line for at least
60us as chip requires to wake up. Fix sleep function to move the chip
into sleep mode, not into idle mode. Remove unnecessary for loop,
which would never run for more than one iteration.



Micha=C5=82 Barna=C5=9B (3):
  misc: atsha204a: remove broken for loop
  misc: atsha204a: fix sleep function
  misc: atsha204a: fix wakeup function

 drivers/misc/atsha204a-i2c.c | 90 ++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 29 deletions(-)

--=20
2.44.0.rc0.258.g7320e95886-goog

