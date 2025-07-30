Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D76CC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9B483340;
	Wed, 30 Jul 2025 07:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMTCvLqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AE782063; Wed, 30 Jul 2025 04:44:50 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4931380C83
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roy.walker777@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3f80661991so354945a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753843486; x=1754448286; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q3Fpmj+I/whXXDLw53SJ68WYicSIG3Sq/QXTO6CNLso=;
 b=JMTCvLqxn4IUhZysDoX6W6NojW+ih2/nPancEvAjMHh/a3CDJfiaBPFFelMjYDYSww
 IChke1qX9IRvax/Yg7thNCyso3JnVP/qfOjY5w2Qk2IGo2AUNjNE6sWdlE6Jjefob/yu
 yRaRE3+YRyj+CFAW7ggeKnIBRW6lu/12LEiJFPycrqJVanTy7xo688BWAmTjBIMe+0zE
 mrG0tIrGJiKDpIqZx0aH2ns6Aoi4m26jKbOmMAJFPPoEhqvRGswc6YvmORsDc76JDCDD
 4ARsG/Z5PP6nGju6/woZ71Kw3mc5MTcUhdkJvWPwtVx4nUm767l4JUuuIfRrgPIdK+jy
 C6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753843486; x=1754448286;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3Fpmj+I/whXXDLw53SJ68WYicSIG3Sq/QXTO6CNLso=;
 b=BEUH2i9YLp1XdJ/K12OhaWEhGjdYJX4RSHybMkjZGGM08H/HrXhtPJq4MmWq4teRnw
 kAjX2oPgmLlFcUHhsftbC6xJDEBVW3XHR0NCYx91M5r2RbGDnu0Ox3AZIAFyzOh6x2Fw
 NnquaKS1AQSbCjkdKZ8Hhe6iOuxv1ET4fZ+awBkLgOMzY4aVA0twacYamoX2Y+gQLh/6
 mNJq0dUy5nzc2W36zACf7ZH8EAaeEeI5XVQdLHrkOvKBRYCL2zSSDDcDx/eEJk4NfXP+
 EchtvChFN7nJF0BGi+tS4BuXaIibP2L2jEMdGcXSRgPZiqgrxWFu/aEaBoWmqg4VCh47
 QtUw==
X-Gm-Message-State: AOJu0Yw45UxnEtvE0tThOYsQ76QqTyIcwa20abJQiSbg2HXD1HMI5ghw
 kEj3QKUfgVN9rdyI8QxmeWMKHZbQMy8IRYn2uomsKApR76PZDF+h/Zdrvv7KodYGo1OKbWxJpwD
 hJ12KoJS6xGGjbIslxOEixaKUgwMxLKLr/lCX
X-Gm-Gg: ASbGncvOfIDEF0ublZz1CAI2r9yVP0hVuaBfHRhR1c9lyW7Xt5Kk2x1qpZ9xpoKizYa
 BD5mu0z3ZpP5g2ZK6F2lZw4EA1JK9Igc3lUkfzHzvQtIIVEIthH5CK9/3RMaa1/5i9mTp9+/El+
 uPSOh3vdCkyDkd0AOsOhejNzWmKH6XqXtSs7uKMJHwUSExz6MADhhDjVS48yKZ6UYp5tjycb0CO
 LH529U=
X-Google-Smtp-Source: AGHT+IEiUcxx5wLAYSCLbJF4iaU5ZV5aKIegw34JiJgY4ut5uQIHRvOKuMFqk05Nf95Ini4Hmu88mzp+IJXYEJ1tpqc=
X-Received: by 2002:a17:90a:ec83:b0:313:aefa:b08 with SMTP id
 98e67ed59e1d1-31f5dd3b442mr2008694a91.16.1753843486306; Tue, 29 Jul 2025
 19:44:46 -0700 (PDT)
MIME-Version: 1.0
From: Roy Walker <roy.walker777@gmail.com>
Date: Tue, 29 Jul 2025 21:44:29 -0500
X-Gm-Features: Ac12FXy7a5AYHQda_nZ-4LT2ALrwOvXU6UdoAAtdnuzO6YvxoKumW-SKngWEZj4
Message-ID: <CAD-tQfVy8CqKGeeWXJaR1HoC9DMrZZ2Ynq1UkYt-0pxkt4oS5w@mail.gmail.com>
Subject: MT7621 help
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

I was attempting to put OpenWRT on a TP-Link Festa F61.  I messed up and
wiped out the u-boot image.  I am trying to build a new u-boot image and
ymodem it there.  Followed the exact steps here:
https://docs.u-boot.org/en/stable/board/mediatek/mt7621.html.

When it boots I get this and it hangs:

U-Boot 2025.07-00889-gbd0ade7d090a (Jul 22 2025 - 16:25:47 -0500)

CPU:   MediaTek MT7621A ver 1, eco 3
Boot:  DDR3, SPI-NOR 3-Byte Addr
Clock: CPU: 880MHz, DDR: 1200MT/s, Bus: 220MHz, XTAL: 40MHz
Model: MediaTek MT7621 RFB (SPI-NOR)
DRAM:

Is this a newer version of the MT7621 that is not compatible?  Maybe a
different DRAM binary is needed?  Here is a link with DMESG and boot logs -
https://forum.openwrt.org/t/support-for-tp-link-festa-f61-v1-6/236744/3.

TIA
