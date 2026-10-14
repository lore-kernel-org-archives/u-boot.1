Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DB7CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBF7580E05;
	Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1t4h_BvaVD4n; Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AB9E80CC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986846;
	b=EpCMF2WG1dmbj1ixsMmJ57KTLOkFqsSPAPx8Z8nmb5dvYK2CQIo41ll0rzBAvk7CU/9y
	 KHkRt+slfGuReqUxGETQuk/zGu/k9d174Rg6yzyVzPb5uwXBJWhfuPEoghQhAxekJgL45
	 e21MEBbrYyg7AZTVwH2lHKh5VItVv4Z+85dqcnu7vxiG1BgR1TJ0LvHIEgfKO+WbH6Hm+
	 JK/zNd+bIO1rfSvBOhf/5QKs9+eRxtPYIKRA0ipmmKngqmdYPjpI1G8qyI/i4xMC5Xpbl
	 1gUswD878xGga+ZfGIJHVjm4x4KsqdfyRrSeUMu3BARyGTR4Q/u59yFHCm5qEDwatkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Io8AxnzmczsbTesTqWVa29ZbAPsFicOuF2JUEd5rmKI=;
	b=oz0xc11Wh3TuESrBjNEM+z6rcUptyO+TN+80loB3brFTNQRyNUsOA+93liInPCRx6Vy0
	 b7hG0RBhNYusAbuqZuEUy8FKPf3pebH6oV5UJWvulHkyN7iP6pn/sTHpUVt1wTWNPXxhC
	 XTIo52rydddBGf/EVN3o0gnRiHn+LsBlquaXVnho7pEVe7Z/0MZL5yN3RQdCpta7vB0lw
	 45oL3JNEo5+9QAHCNf90v8TPJTwYtn+Yb+9LXrJRFcznejUoV7TAFlNJjS1xy2kzZmRl7
	 Tl0zyITteLk6BXr3If8/J1shfQ7qwN+/ZEowvXlCBio+morGNE/5s3Bj89bfXzr0lVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MFPH2cxN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986846;
	bh=Io8AxnzmczsbTesTqWVa29ZbAPsFicOuF2JUEd5rmKI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qX2pTK1BGMoHBRLZcEiZi63PI0lWjk/ki4yBAr6GPWiYaexySi4sKLEX12ITYGoZ4
	 2wd5q4B7amfaqqm6YRiv8J8jO0fNTKyZ9XKuzCLYkWG8lNNbdpG65FONKJRlmV21Bc
	 X3TOrat8tH8MDkzoSf157dVNqyiezaIUsCj7hwaJb6jZny48TqgwZGevzkQhYj2OyW
	 dNJ6NFFft7VccNt+W2L4v9n9ARlAQkBJwAKigjZn2MmENWSW5Mj6MGi5zIW/7vdWw2
	 Ls+ukWEyDY6hGACOXUQyCqLwlIFykqN4n0nRVKKkgzgggv2R8m7xPl+8KvlRZsTCSA
	 vd8rP1s/hIG2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AB9E80CC2;
	Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 232BE255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 093FE80CC2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ui6rHOSItdKh for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 695E380C3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986843;
 b=E/DdK9B8dmkyI2gw/crZ29Xpd/yG56mLJ5I7b4UcC+atzU4YVjk0A3QlBjXxlSoPApAF
 ujWZv0klSpWt/ea0UDWAYcYgYI4FrMWIDKG5JCxct4BB0p5s3AJANBLLrjQjB/lbeZ2/9
 P9TOO3s60+tMLgbC8ejQiEOiXi1Shk+VC7GMOVv8PmBa69egdYfRPTSmkmBc1ZL2i6kBd
 qDMJB/bNa1ZO16mAnc4an2i5M932ndaYVWGiube1Rs7UZqV67X4GZSXSS7Lrnv4MxtCoT
 PfEkyPPL+cDbVbepxrbI6td42kdoZrb1+ovvxKLkR22zyNgzwcqVqmu7bl3jc3d2TNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986843;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=Io8AxnzmczsbTesTqWVa29ZbAPsFicOuF2JUEd5rmKI=;
 b=RASmeqxa5NEwFHxr6jFyj8e+npJLPerQ/RYHHm+4JPpEhG9CNKLUOWnIuqCDXmoEo6uE
 c0oSrkPVIxf4THai6+5REP4eDAZUNKHlhvaT7ZmKO54yl/C4aaqGKKfst6TPUK8pGLCSh
 A/Mw6iG2bdtt9c+UOU2O52gomoP2lXFRTHdDVlMjqgZYUBprU32AmwIETiAPquTbxxCc2
 /4pO/eZIuXDdt9zrXwFn6Jm8AJ+n62uptbw/kSzPqKC/2cVQzZrKDwMc4bHGdae+oWyXI
 xh1vXRutu+A8cYvYN1UG8wgpInZ8PLWlU4DqQRj+6ziGrPQ9U7rYZQyjKoFimwp7lJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MFPH2cxN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MFPH2cxN
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 695E380C3B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:21 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e946155442so4542475ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791986841; x=1792591641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Io8AxnzmczsbTesTqWVa29ZbAPsFicOuF2JUEd5rmKI=;
 b=MFPH2cxNJWCB9Kg6/UJTmZIC2dIIInJ/oGXfqEqCh3jujmTYD1o9BCyn1X5FOR0P0/
 IwyhITMKrMTQRapH12HSPNtZkZmNLo2ObN6LghuGtBaP7xQ2p48u3Lj+mw+T2oUDZMMU
 vrx+bOOvgyPCK3lcTRZkcSs5FyvdD1g+e0pA+DdwN/XzpgzJ+2ut6yBtk2AfP4ogqkP5
 Qje5TBcnVCVwg2l1cl1xMNlOlUrh+jOZnPPe/TP1UtOZ6x1Kyn3IpaWltQ4bep5cxMYd
 kUjCXpWtQ4wwB+OmQdTxfyOqwgqvLdCPxi58gRt9JyTE1O2HHHWG3UMJqIo8PJyRzKvM
 yzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986841; x=1792591641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Io8AxnzmczsbTesTqWVa29ZbAPsFicOuF2JUEd5rmKI=;
 b=1QFzYt1Pq/yTfdtKjmV93LRutp65yPQvoQ/LnVwEU22lyiHT+nRlzXHwsxrG+aza83
 LdGVUrgTRcTnk3C2lK8500nQ/IXvwVJbLAw07e1WiK3Epro0F7F4cETIEgYRLaRysjEU
 nv5qXi/X8kKg+sV7Xku2jLlA7khwuUnx3vexkhouyPUZFweUOSnqrGWtxlOwW4cp0AWy
 Z9zFArVPOUSR24sfke3cIE5zEMJu3CD+dYxKod54onadQ2yG11JNUFpwJPmWFENTsYFV
 EixTJZF4i88KTuu4brupRA9Oa6VK8lu5aIORycYFwalLj1h3l8hbTKku4sH4GdqtahL/
 +DHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMoXMkrPRKSMlRg/0V3tfzARMARNeERy+ycEBRGkt53y0gIl6ZvcHDblR0/OSzEzCtFBsSDo0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKAi6TZyhmgyZ3xLL5L2E9WdEiKl+dfEAcyQ2KhA01vMvHFl1sd
 GkJjLeKI7PsqBn+ZKjIMQc22KkX96MKCouqvRBNtAukJMaf6mB9ZMz2e
X-Gm-Gg: AYBFou0lURgheo19ej6s9dekBDDNnOTrKKNOkbdGCtRhrvsMCh4XsdnjkLMnny8DbVp
 dckzORjeMRfZQ/uHDewz0bl0oD5TVCRKhp0HU8YB2RT8On6bzYRXt9E/WK+jY/vbBfcudgYVyUn
 OCKR223Pcsx96+f8MuF3KpMW6xKcB2J7MEDVBNmle3Xzde4S1qVTFF+OFM57XJHTcgYauc84ssI
 d+jy3tQgMUq0/9XsiNg20jU+IokeV4PUJkkGczfDmMJXJNGzf1Gfy4LJNI5+rc0W2RMrAjxHgTN
 nunkmh5TUaxF22ai+oTY2rw/9SUH9SH5MT8o+nKCWHRmidZZKBHDhtqfq2J9yBbtKqqv9xJgjdl
 tXzUHi+FTRwA+xohiEAqldD0rNp7Iwx8Afs0XFnf+3Rr0MwlIzWwYs6R5SRqXab8HxAiPHl9Hh+
 PgmqohI12vhDuMx5n1we5rU6DeNxo2bjWQvPCNX2QUg3rrryLG82IXDDk92VHqyImIYHfjQhiT/
 pKPE5+7Am5FpoVtuRmOlsxSMJlNODF+pQIulFArTnzaTgO6MrFyX9bBFBroo+tBlownE1IBd7hY
 WkgmX1s0Ly34acCRNMOqZddIbkNp6g4R3UpRALrKeORGeZNyBUCS9gBbZuicBMqN
X-Received: by 2002:a17:902:e54f:b0:2d9:216a:cdd3 with SMTP id
 d9443c01a7336-2e842aa7c60mr135036595ad.18.1791986841065; 
 Wed, 14 Oct 2026 07:07:21 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8202sm66885495ad.51.2026.10.14.07.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:07:20 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 0/3] virtio: Add a virtio RTC driver
Date: Wed, 14 Oct 2026 22:07:13 +0800
Message-ID: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one: it finds the first UTC clock on the device and reads it through
the RTC uclass, so "date" and anything else using dm_rtc_get() work on
any virtio-capable QEMU target, not only on machines that also have a
goldfish or PL031 RTC.

Patch 1 adds the driver, patch 2 updates the virtio documentation, and
patch 3 adds a MAINTAINERS entry.

Tested on QEMU v11.1.2 with qemu-riscv64_defconfig:

- With -device virtio-rtc-pci and with -device virtio-rtc-device, the
  driver probes. As "date" uses the first RTC, which is the goldfish
  RTC on this machine, I also built with RTC_GOLDFISH disabled: "date"
  then read the host time from the virtio RTC, advancing between reads.
- Setting the time fails with -ENOSYS, as the clocks are read-only.
- With RTC_GOLDFISH disabled and no virtio RTC device, "date" fails
  cleanly with err=-19.

qemu-riscv32_defconfig also builds the driver without libgcc helpers
for the 64-bit division. On sandbox, where VIRTIO_RTC now defaults to y,
"ut dm rtc*" and "ut dm virtio*" pass.

The alarm feature is not supported. I have not added a pytest because
the CI Docker image builds QEMU v10.1.2, which does not have the
device yet.

Hung-Chun Tseng (3):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: Mention the RTC device
  MAINTAINERS: Add entry for virtio RTC

 MAINTAINERS                         |   5 +
 doc/develop/driver-model/virtio.rst |   4 +-
 drivers/virtio/Kconfig              |   9 ++
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 206 ++++++++++++++++++++++++++++
 include/virtio.h                    |   4 +-
 7 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

-- 
2.43.0

