Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73881606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sdlWYpmV;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nD1s5ljH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 448156078F;
	Mon, 16 Nov 2026 14:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8QcmLFSa1r2; Mon, 16 Nov 2026 14:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4063260794
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837661;
	b=Zq5JipBQ3D/RbgFmlNTyEfRIgRP/aNYoMx/HKt4EXJkvI15IV1M8J0ukATCh+LoZosqG
	 vB7LlXMAm8DnGm4NNsRudvf9Evk/9LZB3SRgczOx450V/6w23+Mkjbl1/v2HiS+kY9U7W
	 wc7QgwOOYumDLg/XBi4jnvkfqRQD2ONAyEJcaG9PDOwricApSKqTGMgNxZBTNPNlL/02y
	 0r2vZpdduIefSSucRNtKLSEmCJA10dUuNxeCfBHDGSArUYUEOzhHZFspOl68fjoCr/X/l
	 vYhb3t/dYu3RxLk+8JUGowfJSJF0gkHdUYEdGMQrPfzwXg9jJ8J2504nL4xmPfQPIig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XCJfzo9MEb7Fw6LY8LSFldJ+C5nk/t7oPzcw9y/aRMY=;
	b=aanb4BMC9WZ17YJsvjAi+4AlLFjytB1Ual8yBN+/SLZbfstAppTvh1gPq11sh9LlyTum
	 op5oXC8OQfrpTr7AV5g/cZTrhr5ViyIUCeRLq9AnJWc9c1rfLbUdjig9vxrRfEKPtEWan
	 LM6ZWitkVgaBBFsgRSYXJqusO/pOvNg4+hQQkOOY+IDyi8ipb0pPFIBdmDStUNhth3ABC
	 zqUijJT5xqcZBqlL0/i+4cVlPdWc3XnRZNWhmvbutoMrL0JwyVHiUMUw4Qs3/noM9o0MW
	 H6NnkaAwmqR9vDLhtY8l++XjzW6cJl7A8AKJX720fpprhhZS5inOtlLH1mk3VFQZbpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nD1s5ljH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837661;
	bh=XCJfzo9MEb7Fw6LY8LSFldJ+C5nk/t7oPzcw9y/aRMY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sdlWYpmVxL3hSrnTUUfeSNGkVe1VfRxt53UpFb+OaJz/5Icqnim1x0AT2y8MhAtl+
	 hFbneaNLSuG+AsEBeXkxGdwFSfFKhCUNG0jmW41LCLpfLd7L7rVsonSd6bkZ6Fwd1w
	 y+cft8uixsjpn3FE09BQ/CqZUikl1mkToIcD4ryU04r2WJWff2R9WwfN0pSnULHVN+
	 e+8fH5KGRvxUknMEJRfYy0bH0OeckRBIY7xeSlAxNeOhjbEiMyhmtC1F7SahzWkLYd
	 5YPVDeAXYy77iNME5aWoe/t+N5RziZCTVogEdQpXbKIuQ/F6sJb/PCzSjx6MiHLwK1
	 yIgIA0bu38I9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4063260794;
	Mon, 16 Nov 2026 14:01:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D8C3109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4ECB260794
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fe-XmvZoz01n for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B8AC96078A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nD1s5ljH
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8AC96078A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:00:57 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso109069766b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837656; x=1795442456;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XCJfzo9MEb7Fw6LY8LSFldJ+C5nk/t7oPzcw9y/aRMY=;
 b=nD1s5ljH+6cgGzG+5LysytTN1iDpoaYwDR6ZTvt9PRVgoG0ZmWx+8PAOUOZo9j6yCj
 /4816B2C5buPwfHNkJC90978xyseZKsSB8eAJ0FJ3UAKxyJBPOW9SCdE6iX769b1xWTM
 yBoWXsgpmsso0ilKRjjXYIauTZMRHiNenZrohYCoG5ndBjO5r3kq0r7k4FVpS15S0+xx
 14ilwvDE11JS3D/rtR8XCes+OYCCSi9UglcFrUh6RheEMkHXTS9YFQ/80jcLExxOIdSz
 EGUJ54tj6erU0rqfO9/4zcxMd20LB/lncYyIhgJy22YAQFSpNaFS2qfYDhzOjhJ3i3ps
 L12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837656; x=1795442456;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XCJfzo9MEb7Fw6LY8LSFldJ+C5nk/t7oPzcw9y/aRMY=;
 b=EPf0U6ko+ZfMTHFaa+k4uIpiAYOqhlz9M6Xp+gg3ebRa9VMYuG0eIJHkmbdSHz3NA7
 5MdbGbAaD16b6aqw80SCn+VIneiZev4j7hKoMmrRWg5upbPnO0bhPeGUfDins5r0L31a
 0iZv0UMl46AMykjZR6XPtxh08zzyubg9Xhf2PwyHpZD+W1w9E9kZ5Co6TEkiV3Ij+cSr
 Y8qeUG884+zaNNxC5ViUY9QvfGLjzyyIyIS/6KIaiLX01sPcaWVzJPaSYwT9CbG7ALzV
 Rg0GPRdFLWMmJHVwJUNcHhD6pwwgddXtwFxCpvHIdVBmn0fKH3Ec0uaxQuc7PG86Umne
 5Hvw==
X-Gm-Message-State: APuU4Z+fbnBZaPQYDwjvN4dadsj1LQr9TXQEaunF4JYt9Wxmh1rpeuMK
 uIG1lkwWs6HGTLUknVc1nMoo+gJfMk2xMq6KPDHxRdcYFw63N7Bq7RqP1MlAJAUBdpw=
X-Gm-Gg: AYBFou39Xs3pQRwk0rsg8aeJZamGS5/OeAVR1HNw9/uOxbywW4DVLwwslvjaau26iD9
 xVgWk+u6sgG5E96GHzh5oP+QS+/shsFQndsMdDHdyWEH+wtA3Jj3gqPQSYVQac0V6Z9OB3okvLj
 mlC0SFU2O/BzdQ/7D1PVZUu9bx3CSXUAA130CEiA/KGw3ma+91rPjuvgywtgzvVRKZeboU7LDWb
 Xv4rRnUhcAoddi/0QPp4TYxgeQ8sZ+F6yOpyaaRVQiw8kqY22nfITD9Pj/rcRo+dXct4yui6kZg
 Kzh4640BergzJqMTxZgJckXHxfxvfjG1o4Jha7eVv7P9uHqu50XX1qvNyt6V6ZoG6qdzFAP31Dd
 iUsOFcWXs4SKJHa4/nAS4CJgdNjKXKi/YxmclsGBewbNN7BusP8LsqUMtnnjpAyoiSBXVLWHHZ3
 2IjlhIockRn/T9yjzk2KqV0VYXEEfgN4IND0xq6xVdQbawKVuSXw8qKl5c4wi6ssfJwp6u8AukI
 mOEr3aq6rwy7NHxiQyeWdz9YLXuP6FyGSCGdp3rLoVzOdyQecTNoTJx/jlB+0xEzSignJkS+YWV
 jB2qfpF5ugCSrAaG20HLJc3PhIMqjGJmYri0QR6fy4qBFLwh6+JkaJhHn+owGHE5MZV21i286ms
 4Blg41WHy0S+JUL8Bc+QijT6ARk+dWJEpe1ukba95M4N+yw==
X-Received: by 2002:a17:907:60d3:b0:c40:4f39:22e8 with SMTP id
 a640c23a62f3a-c50963d3237mr911270866b.44.1794837655767; 
 Mon, 16 Nov 2026 06:00:55 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:00:55 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/7] Support fastboot boot in SPL
Date: Mon, 16 Nov 2026 15:00:46 +0100
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5WPQW7DIBBFr2KxLhWMTQ1Z9R5VFwMMDVUcu4CtR
 pHvXkIqVeqq3Yz0pK/3/1xZphQps0N3ZYm2mON8rtA/dMwd8fxGPPrKDAQ8SSEH7hzWCPF1ySU
 RTjwvJx4wFzvPhbejvCbQOAqBnlXRkijEz1by8nrnvNp3cuVm/k4k+lhre7nHmMVM3M3TFMuhQ
 zt4pxBdMGrUvXJglFWGAngPGrTUvXEWBLvZjzGXOV3aR5tssv+M3yQX3IPxQapgjdXPFi+naBM
 91jmtYYMfqxR/s0K11vmjlsMgyatf1n3fvwAVOsNdiwEAAA==
X-Change-ID: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test farms need to run successive U-Boot builds without rewriting boot
storage. Add optional fastboot boot support to SPL so an already-running
SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
then load the operating system using its usual boot methods.

The standard host command, fastboot boot u-boot.itb, accepts a FIT built
for the target, including any firmware required by its SPL handoff.
Uncompressed legacy U-Boot images and raw binaries are also supported
when enabled by the board. Raw binaries use the board's configured load
and entry addresses. Legacy and raw downloads are rejected when SPL FIT
signature verification is enabled.

The series reuses the SPL RAM loader and normal SPL handoff. It also fixes
ignored errors when loading an explicitly requested FIT device tree and
invalidates stale or incomplete fastboot downloads, so neither can be
used to boot an unintended image.

---
Changes in v3:
- Fix the sandbox SPL build with warnings treated as errors by excluding
  the unused RAM boot callback.
- Collect the remaining Reviewed-by tags from Mattijs Korpershoek.
- Link to v2: https://patch.msgid.link/20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com

Changes in v2:
- Split the USB boot acknowledgment fix into a preliminary patch.
- Explain the FDT output initialization when a missing FDT is tolerated.
- Keep the RAM reader's sector argument name and debug trace.
- Collect Reviewed-by tags from Mattijs Korpershoek and
  Guillaume La Roque.
- Link to v1: https://patch.msgid.link/20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com

---
Carlo Caione (7):
      spl: fit: reject failures loading an explicitly requested FDT
      fastboot: invalidate stale and incomplete downloads
      usb: gadget: fastboot: do not boot after a failed acknowledgment
      spl: ram: allow loading FIT images from a supplied buffer
      spl: support booting FIT images downloaded with fastboot
      spl: fastboot: support legacy U-Boot images
      spl: fastboot: support raw U-Boot images

 MAINTAINERS                     |   3 +
 common/spl/Makefile             |   1 +
 common/spl/spl_fastboot_boot.c  |  76 +++++++++++++
 common/spl/spl_fit.c            |  16 ++-
 common/spl/spl_ram.c            |  99 +++++++++++++----
 configs/sandbox_spl_defconfig   |   1 +
 doc/android/fastboot.rst        |  56 +++++++++-
 drivers/fastboot/Kconfig        |  16 +++
 drivers/fastboot/fb_command.c   |  43 +++++++-
 drivers/fastboot/fb_common.c    |   3 +-
 drivers/usb/gadget/f_fastboot.c |   9 +-
 include/fastboot-internal.h     |   3 +
 include/fastboot.h              |   8 ++
 include/spl.h                   |  25 +++++
 include/spl_load.h              |   2 +
 test/image/Kconfig              |   9 ++
 test/image/Makefile             |   2 +
 test/image/spl_fastboot.c       | 230 ++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load.c           |  46 +++++++-
 test/image/spl_ram.c            |  48 +++++++++
 20 files changed, 669 insertions(+), 27 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

