Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9171CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F1806062A;
	Sat, 17 Oct 2026 18:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRq4-Nm14D7u; Sat, 17 Oct 2026 18:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 594CE60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262790;
	b=hbSXW/04cZg3n60tKzrxCHPQyRgOF5E+RBonJHrZN710cnRK1dIFv/qFg4dYCkDEuwFR
	 H8pKkOubJVH2P4OnduOUWB5BsrOMxcv2K8qtR96kM1ZFG9vqdLfySZ8Z+1k6AJK4Pwp6z
	 NLLEV9ThZy3C2UMFsZFFDtmcP2BlakQ5XpXHdWsyZtODNzKsPXT+ewz2muM/afK7I0A8I
	 R17C/Lwn+QhsX9Y/0QSw1VLQ16Vr+jcED4caGiuXqw0bWPJjxUvvCWXx6RtNa0Nxkbx2d
	 oZILWXStKfq+zTpstSrpogsYZ8udAGL7teZvcxFnRBsqx6MWn6BYsente1Ri+jcq3dQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kZ0T9OeuLv2L9sgRXvmqkcUl0pChvEf2KNSRCVp5ygQ=;
	b=RD59Sy5hta7Rwz2Cc1VMa3k1lcFiscW45iXmkb1vRGiHDGEf3xqC3CXj6xLab4vOPav/
	 NtB9keFO61EYNuIEh9NR8eTTaE0aqQoghd7/Eu2peAgbAfIvt/Zyv85w0zIB+Sv5x1YeS
	 EZ0DUFkqlXsrlHFzI9Z74QtN0fk8M0hKZ2pgzMmEnEPFdiPWj60eHuTYkyU0libD6Sqce
	 clFwzcxmrfDVLgdiSpvj5y0PQQl6rHlK4gh9DSD3b/oE+lVyoZF5nv1sufWTE08RwoWZ9
	 j0jkz13bTAk0E1Yx0K937ZLOnMA+aq3KJ1JsfiC8sqcUXpFMFCqP74+PUqfrydzKy+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262790;
	bh=kZ0T9OeuLv2L9sgRXvmqkcUl0pChvEf2KNSRCVp5ygQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i8kQJqbCJrZavZ1gsAqWhcVgfItU//beJFzc9j3FYuD+sldamJEz6zXJ7NN/FMTsO
	 dYkFkmOKssTVhQGqdVlTzskJn2Hzeh0MULUl8XQQk+tML+GsMdqqbla3yRCcenqi9d
	 nmIN+Y+zcYFRXpIU6ShTfYalsU8MliGEP6F9V34a8078MxO99WP5ftBcM4QihqiorB
	 AkUg96s1gSDhqIHrZf9fPH1wcI6vuo4/S6iYiwhtTiPVII3XVdn0HTjpK7iUFWMgHb
	 2Hqg15hljKgdJARhYMRbcoPPgG6JxsOinV1KzWRXt6z+0ObFBGcaqpkxb5ScN8juPM
	 W5rD6LPJ6QV4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 594CE60626;
	Sat, 17 Oct 2026 18:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0CEB1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E8EC812B9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ui7xFck1El3d for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E931F8115D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262788;
 b=CxKOwBnVxvVKvb8cbgMzJTxm8pJXKfR3HrDF8d0QH/5TBC/Q4RIu+yLguolaxgjqf4xA
 /haJpEu8q8ep99CKHzsow7nxmAlcWDLW6p3xhuJmQbg+2IwxNAB70HuDSuHOa06bOmFzW
 uIy1yjAUuRZ+LJcuxP1kYGqSoSxQXjT+BVpe69oCroMh6URMJem/hJsDy4UiFJ21l8NvC
 1u4loBcrr3EFgCCeC1WCgAwdseRbnsZyYiF0GVx1tzfU3sKDSxvHmYQLTpd+ASL1/agX9
 4L9PWHNV8WWkqRUJ3E/AV/Wa50B7euT00vvxnIr/tyOj5sJ6+AN2vxa+Q5g0KpRmx1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=kZ0T9OeuLv2L9sgRXvmqkcUl0pChvEf2KNSRCVp5ygQ=;
 b=SM+O08epLiXkAD5vBOE+eia6cY60A2SuKE0jXAXdPBJ+g/L8Y7qMyudXjSLrftyYLyQX
 rFBToWl6Twd56u0WcNXh+w3Worp1qhDiVfKA84kNSYoBtnctSSrPH694ebcU4+jyrTALq
 HZ6H5rdyM7kyZfiwlu99Nz7pV5uXOiCPSqMhunglxmHVpdPKpXWUuzDDoG1SimBiCxJwm
 xPS0nX7zRlEy6cQqP+MG6XnMxtpbw0R8quhWvizdHRr66Dgt0B8UkyDulxBYplNh+fETQ
 zIlFXIpil+4HM0gpMLRpNSmkI/yoWkubXGDokK6wL0RudKTaf/IGHpfPggRByB01iUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Hck/xr+M"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hck/xr+M
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E931F8115D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:27 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-3514b90bb89so2397535eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262786; x=1792867586;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kZ0T9OeuLv2L9sgRXvmqkcUl0pChvEf2KNSRCVp5ygQ=;
 b=Hck/xr+MYRv6HrkjJEy+y86fRUV78q+vOyeF/45GSrBCCLDU/7NNV5MPdTzuZSr7r6
 BVd9Lxq3bK3lpD1dKJL+38XHuWBJIjrV1kLfhRRnx3jAbYwReq8eAf9tTzqVJsBpkrtJ
 5w7xCm/H97UKKQTbA3pWpdcv7uqRdWwD3+OW2gxy1AdIZDOV0EtGMy28lPp59Hgqphzc
 QrC1rT05h2aXf0dvnJlHpM0E4Ir1rqlDkqRym/Vh49ONClTAFfguKleTPR0f67gJlY99
 j4CDZZeT1BNtcD45Xot0Dz61P+GzbnEIU18n9rGDcss5MkctcINP2fuUXiIKCzx30oRI
 wG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262786; x=1792867586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kZ0T9OeuLv2L9sgRXvmqkcUl0pChvEf2KNSRCVp5ygQ=;
 b=uIgdWEjPNnL3s00qGeivKnAGQ700WpnNwxh1+l8DHtGGEy0TAFY/iH/y4kV7MeAb7H
 Ejqz0quf6x1Yo9xskLPga/TKqo4FIOE+i/WPralC2azOjDQtIcnbLXdObqiTs8yMdbxm
 QNQ/ykzLeJVFHIMfwhfHJ3kwLa9Ru/ZafTQNoWWfVvfOZdVuL2jlmU3D3yJNcyuXINA0
 HBm3U7u8ovsM1hP15zSzHtiTacwcCpUu8+7IE1SK24JZhZlWkqYROs5dg/ke8Rn3nYcN
 uGQzZp0hyrwmjW5YjhP5cNkmLydPSo/9N3O245l6baXvYrq5cFSUfi+DZ5FkC+vBZoOL
 O3Vw==
X-Gm-Message-State: AFq9FYJGvBTbAGJJNfNpeAP9ebUvoX8gjAR940gO74CWyw4EvHbMOCLZ
 Wzwq1uJJQ4ZauSSaLi7pUxoNgcCf5dShj3H7HmQlnXtPGJjwTONoc2o5Tm+Eguzo
X-Gm-Gg: AYBFou3xSY8g5OOKj92qsQ52t8phRbYb7167YAyhc0l/ycdwshE8kUyIY/u3Xd/kWi0
 M+9QZ/KqKi6UP1/bysrQz4maskkHcncDID5fyPh0vA0v5TSM66daZz8CozurmXD47J2+WoQ5HLS
 T86DKrl0q35ZIHUqa3HIEYr89yCX3mR7xggpQ0f/vHY9aZJr7bZtKCDbTpIiZckr4rXe4XtWDs9
 jYJ2Tk3KGW/GRP1qFE/hmyJMdUF2mYTTLpPD6/mJ3Vvv0brmb6zASDBcf3sPW/hMPbQeHp8GWsY
 sdKK1Vgu/oMVWafOTMzLjpzv/shxNQ2mJkZ0gL6S6FzxYSsZbV7pgBa869KoUb/IYAJHYgDzFTf
 eHY2DJJW35CccTXGSg2GowUv+Xo2CKVNWSxmjQbcPMnAeJhDkVT6/6abZiOHsdTkDE2u5uJmysB
 F+rNEi7xeXl3pya1uwaUe70ViOMyh1Pbrioz2T/I+0xx8BKtYlzK6MX/00NQcQ8H0j2xtfHUorF
 o2IFKhUaRO2g0MLO880exUN+4jKtFWg6PGwfNyCDrskEPLrb04AYgSrgbuSmmoJLRKrbjNV5D/R
 RGXJH67K8gw2sbOq9zXgPZK45EbSP1XR8U7IoDoJE5N7qMsKdrSgjw==
X-Received: by 2002:a05:7023:a4b:20b0:151:6e80:ba7e with SMTP id
 a92af1059eb24-1850ce9f56fmr5185161c88.4.1792262786272; 
 Sat, 17 Oct 2026 11:46:26 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:25 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 0/5] virtio: Add a virtio RTC driver
Date: Sun, 18 Oct 2026 02:46:17 +0800
Message-ID: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
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
one, so that "date" and anything else using dm_rtc_get() work on any
virtio-capable QEMU target, not only on machines that also have a
goldfish or PL031 RTC.

Patch 1 adds the driver, patch 2 updates the virtio documentation and
patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
virtqueue requests as the device would, which patch 5 uses to test the
driver.

The main change in v3 is how the clock is chosen. Following Kuan-Wei's
review, the driver now prefers a clock which smears leap seconds, as
the Linux RTC class does, but falls back to the first other UTC clock,
since QEMU only provides a VIRTIO_RTC_CLOCK_UTC clock. Patch 1
explains this in more detail.

Tested on QEMU v11.1.2 with qemu-riscv64_smode_defconfig and
RTC_GOLDFISH disabled, so that the virtio RTC is the only RTC:

- With -device virtio-rtc-pci and with -device virtio-rtc-device,
  "date" reads the host time and advances between reads.
- Setting the time fails with -ENOSYS, as the clocks are read-only.
- With no virtio RTC device, "date" fails cleanly with err=-19.

On sandbox, "ut dm virtio_rtc*" passes.

Hung-Chun Tseng (5):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: List the supported device types
  MAINTAINERS: Add entry for virtio RTC
  virtio: sandbox: Let tests emulate the device side of a virtqueue
  test: dm: Add tests for the virtio RTC driver

 MAINTAINERS                         |   6 +
 arch/sandbox/dts/test.dts           |   5 +
 arch/sandbox/include/asm/test.h     |  25 +++
 doc/develop/driver-model/virtio.rst |  10 +-
 drivers/virtio/Kconfig              |  11 +
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 249 ++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c     |  15 ++
 include/virtio.h                    |   4 +-
 test/dm/Makefile                    |   1 +
 test/dm/virtio_rtc.c                | 306 ++++++++++++++++++++++++++++
 12 files changed, 632 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c
 create mode 100644 test/dm/virtio_rtc.c


base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
-- 
2.43.0

