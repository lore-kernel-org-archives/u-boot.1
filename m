Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8614C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8231B80F28;
	Wed, 14 Oct 2026 19:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kr0jA01kCQ4W; Wed, 14 Oct 2026 19:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D3EC80F23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792004801;
	b=iTNEhoCzBqxRf4F9j30Y1yhsP0RdTw18qL974f244PAg2Ij1NdEqnVRWQERWEb7J20zV
	 E1xmxQOF9Vx7VYrHXdWHlxL3+Kj1TY5DTCStBi3OaHjcsEYoV02ckY/szukza7kDPDI9z
	 c/eLlp+/6jhwj8DGjcVrQs7w5qs0Ids+YffDXRnz+1S3bTtVapM/voFFhuqmDPqieU9Qn
	 GHOS59Y21kU31tWqd3svXSs5TQh24bQEG3+J4eYYhqDcV4u1ZzzsmlQ9tPButnaYgLmjG
	 jLeNdANY60fJ3+YV2S53pWoaO5sOswDVXD1UdXIB10wIyiTxt5QjTIp2ED5ACDYe3Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792004801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tx8TrV4ThfsRXeAwFWZj88NORh3jAxKqgpznD3lhrdI=;
	b=BcCIzyQkTZQtjZD2oyzwW3e4uwQfAvbwvV+lcEvXdsudWpjEo/B0lzoIuG+25XusAXp8
	 YhSQ9n65hxoVxFB373mmzNQpkapwtMDKwuF6aYpEuzVear6cqbS5z2rnV02PuOM3JhCc6
	 L7HZ9XxtYSw4/O1ssG5YmCnbR+DiD3yRbMbu+MHPe9+NnkUZBoYYp711gZlHgAni87wXA
	 MooKfxShp1qm38WIoL6RlZ+oMAXe+5Vh/5IjETAAIRXiodYpEb2goK3kab4QJPD6OLWkF
	 0/Cmi0w8QsrCpqG84QApeXBpqBjFLRYFj61i05AXqmSvtarGFd6MUAjB6jZ0/BHy8gA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792004801;
	bh=tx8TrV4ThfsRXeAwFWZj88NORh3jAxKqgpznD3lhrdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pZTo8/FfDX0tTMmNW/zpqaZ+zOR/iJvTtp44CQ4Fg9GiEfuPhgzDQMxoxmjCQyIKI
	 98KbEd6K6nZnfq5+GyZIdk6TwG9oUIatbg3snw1b2WXHUzumtcDBu53ZksPl1w07zc
	 zMvTJrR1FxZKBFhSLjPS2u1RcP2f93R/3shdwTXOqoWagMKMyC47jjh9bmDHP3RW7h
	 LTGsTI3krNtfR82BzXyncQZkmzGAvsHviQzMCdflBrJsWBnLUeEus96NpSz8DAVFm6
	 HpXtFwanjLHhMRAkqdTm3Y0CvJK6XG5kMAVtWyGFHx9ipVTOA+8qy2C+Uxx+B4F80J
	 LTffVOBpY6rZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D3EC80F23;
	Wed, 14 Oct 2026 19:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBBD3E4D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDEDA4018E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnD0e1G09rlQ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:06:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBC534009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792004799;
 b=NGupgJHiGKBgYfPFgskUpdaSEe3MvicxY3Ot7nsjy1V85kR6/4Gjowe/D0XD1ugeXLOw
 4uUWA+qtGYRuaDqdqa2ctfCl1S8ZAGEvU9A2LypOXALSswskWFg1cSeDx+p0DCQrVVDBH
 b2gLaTBzXdLnBtsCzJwU5F6NJA9FoHMbW1AX5nZ2+powFIawCszKhNrJloRdm0a/mT0KW
 whaQBzOT1eoC9+ubcCZw9TOs4zMCAEKvZnviJYdoSjWZu8PRaMowwJKjWBeuR6nHfU4xr
 2d4iW0ZpGEurJZFOl1membSWl7OJAzog2Cuq2xorSE+HPSID/Ckk2tpGM7a6yvlRNKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792004799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=tx8TrV4ThfsRXeAwFWZj88NORh3jAxKqgpznD3lhrdI=;
 b=htP5i1CwI53vElhRY/bjC4ZLSa5LSe/0TyTl2uWy1+LF0Np0xni3XFTOpnHMpMfWKsE6
 DDC+8MOd0yF6UyxqZFqhKE9M/FECDBvO+a/7GRA79f/ryn+S3Ac/uTEFdgI4EL9QQvfPy
 kTD883fjTItAlkm+HlGcmbOBhMbRcn069b3EE8h4HOkur/wBL0Pl9kQpOcScGizOOHgrQ
 Sk+5OT38wEeVRvI8l330wI96QVBfse8RmS9Jj5wDQFhHwkexS+fdJEnZlgm9gY51I/CLG
 +qrIsbj4wbk4OJf+q9YhMIlOI9zDfNB4H8pJ2LAHKNlkOtVMsh7Hn7SaFEVe0Ue5WNw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="rr/7UNoQ"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rr/7UNoQ
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBC534009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:38 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso413266a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792004798; x=1792609598;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tx8TrV4ThfsRXeAwFWZj88NORh3jAxKqgpznD3lhrdI=;
 b=rr/7UNoQGWEWnulm4DPyPQjLLkhTgqqaGuqffZ+ubKGi6al3k9Zb3TIvOK5IFmGurU
 9cshPrvowc6steq/vCexnGEJbjkiCqs5MtzBpc3q7G1IvzbypUkRWkWZiH7puwWntaNx
 6btLPxpls4k8BiPM9qUvE3TtWg1Mu+Zbz/5Jv2jwpGEyrPZDJRiA+PMMK2DRdinaSC24
 6bpq6zVV3I01Ele+USKkGuB/THgtkVRsWjszHb7CsSwERIU+dkHuTcKhIliHNN3SWPHk
 wIY0ECVVjL0xIui4LjtuEBbKZG1sYCZ8LLw99hU17EoO4u0n/uELOWdTAXb+RpeXgdue
 ZAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792004798; x=1792609598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tx8TrV4ThfsRXeAwFWZj88NORh3jAxKqgpznD3lhrdI=;
 b=x7e2e+hrKwEOSrHmdLVyBtobRX7Qnpk5k9YdRvIbTBrTj+9iXGxBK7OwojHoPPtwg6
 /G0Mspm1S5onIJ6tZO3oXi40EeDlkfBgwl2c+bSl6EUto7vUDuElfgBqri1nPej2YlIZ
 Fngm4Fz/tlGh/Fd9pJOTUzB/Y9a1cNmRjxbAXu3KAB9AZZ1R0APpuVqFZaG77PORgzOk
 liHd86kaCOrvzwmqay00hjagtr+WD718a4fBE+OfrYBZjHvpUBbpwKlbzJuD+75ljZBu
 RjWc+8coFrmyCCIKRCS0+UAnBBhQrkpkrQwyS5xxp0yWhlDnFQ5ipJPa9Na9SkCn47IO
 Ghpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBySn9LdaZ5HeOfOBNDRZ0QxzGVY83hofbA8AITZ04Fm2CJis5ZyKOYRg6RasyoZgRYzAlT4aVQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLILwfSbs7Xi2owwV+b8CYJIqoAcM3fBq/2Uo7Q48gsPl32p9SM
 e2oA5R0RGAfnEkLsjzKOUnmc70aSLO/9wjQELmIlghivpNWP+fAkB7Zd
X-Gm-Gg: AYBFou35G47EZrR3EPFbnhWECFx9D54IF5x6EBCju2TyeK4ecGFNbLY1UVEyC+OojKm
 iHYsDD0cUWVPbXPAVjBwgeFmKhvSZjWm3vOszQR2ZTjvrN6naQqA7jj37ay8FV61Z1B0i40B2Rv
 8Y2xAb6563nHzWv2XxbW0tfeuwnklIMan17skL+wfR60JfHLEn8ERNbrWQdSEBkLdpmw0aI4GuQ
 jKEl46ZT1x/Me1TGqqPgAzv/oEnNTynMJ3Z1iA5oJwqWdQxw+xT5wYMhrmANBbs2PQUv0u/DQd0
 oMEKxuNS5tkhdmoIwWJBr4wjBvQVwwoUixc1uiI1fUjEOzxGh8MXUgjfAW3+HXt3achtCeJPzoG
 Ya9coqqrJEhB2E92aqX7rIydI5Kb4ozBndGsBkGjHyS8i1U1Ya/iltB9cziyP9xrO1U+1hWmAc2
 N3Ic+X22f/wOr7kh89sHq2g3jB4P0j6THLG0usSxI+Z8L1Iri5etnc9RqEGHEIK4umOztiF077J
 kx97MDTrvzB+wlG733VI2/ZPlVLlevcfUwDDTu/JLnBrFdtfPXwD2x+QCdSOIgEJbzaxLejEkMm
 6QMeYg2QRIY2ZZyQyU/YTEua80eSA5GU1YsMMekccBHFllu4qT+E/Q==
X-Received: by 2002:a17:90b:1d03:b0:3a5:de8:2c4f with SMTP id
 98e67ed59e1d1-3ab3b04c2d0mr12000648a91.65.1792004797795; 
 Wed, 14 Oct 2026 12:06:37 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a1f906sm624938a91.0.2026.10.14.12.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:06:37 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/3] virtio: rtc: Add virtio RTC driver
Date: Thu, 15 Oct 2026 03:06:29 +0800
Message-ID: <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
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

Add a driver for the virtio RTC device (virtio device ID 17), which
QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.

The device exposes its clocks through a request virtqueue. As the
virtqueue must not be used before the virtio uclass sets DRIVER_OK,
which happens after probe(), the first read looks for the clock: it
asks for the number of clocks with VIRTIO_RTC_REQ_CFG and picks the
first one whose VIRTIO_RTC_REQ_CLOCK_CAP type is UTC, smeared UTC or
maybe-smeared UTC. Reading the time sends a VIRTIO_RTC_REQ_READ for
that clock and converts the nanoseconds since the epoch with
rtc_to_tm(). The clocks are read-only, so there is no set operation,
and the optional alarm feature is not negotiated.

VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
VIRTIO_RNG does for DM_RNG.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---

Changes in v2:
- Look for the UTC clock on the first virtio_rtc_get() instead of in
  probe(), as the virtqueue must not be used before DRIVER_OK (Bin)

 drivers/virtio/Kconfig         |   9 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_rtc.c    | 213 +++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 5 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 55b444280..c19138ef2 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,4 +84,13 @@ config VIRTIO_9P
 	help
 	  This enables the 9P transport driver over virtio.
 	  It can be used with QEMU based targets.
+
+config VIRTIO_RTC
+	bool "virtio RTC driver"
+	depends on DM_RTC
+	depends on VIRTIO
+	default y
+	help
+	  This is the virtual RTC driver. It reads the UTC clock of a
+	  virtio RTC device. It can be used with QEMU based targets.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 6e7bcfc8e..ddb5ce4eb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
 obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c163b2fd7..c6cf55922 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
 	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
+	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
new file mode 100644
index 000000000..f5d4a694b
--- /dev/null
+++ b/drivers/virtio/virtio_rtc.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Driver for the virtio RTC device (virtio device ID 17). The device
+ * exposes one or more read-only clocks through a request virtqueue; this
+ * driver reads the first UTC clock and reports it through the RTC uclass.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <log.h>
+#include <rtc.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <linux/types.h>
+
+#define VIRTIO_RTC_REQ_READ		0x0001
+#define VIRTIO_RTC_REQ_CFG		0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
+
+#define VIRTIO_RTC_S_OK			0
+
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	u8 reserved[6];
+} __packed;
+
+struct virtio_rtc_resp_head {
+	u8 status;
+	u8 reserved[7];
+} __packed;
+
+/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
+struct virtio_rtc_req_clock {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	u8 reserved[6];
+} __packed;
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+} __packed;
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	__le16 num_clocks;
+	u8 reserved[6];
+} __packed;
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+	u8 type;
+	u8 leap_second_smearing;
+	u8 flags;
+	u8 reserved[5];
+} __packed;
+
+struct virtio_rtc_priv {
+	struct virtqueue *vq;
+	u16 clock_id;
+	bool clock_found;
+};
+
+static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
+			   void *resp, size_t resp_len)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_resp_head *head = resp;
+	struct virtio_sg req_sg = { req, req_len };
+	struct virtio_sg resp_sg = { resp, resp_len };
+	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
+	unsigned int len;
+	int ret;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	while (!virtqueue_get_buf(priv->vq, &len))
+		;
+
+	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
+		return -EIO;
+
+	if (len < resp_len)
+		return -EPROTO;
+
+	return 0;
+}
+
+static bool virtio_rtc_is_utc(u8 type)
+{
+	return type == VIRTIO_RTC_CLOCK_UTC ||
+	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
+	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
+}
+
+static int virtio_rtc_find_utc_clock(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_head cfg_req = {
+		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
+	};
+	struct virtio_rtc_resp_cfg cfg = {};
+	u16 num_clocks, id;
+	int ret;
+
+	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
+	if (ret)
+		return ret;
+
+	num_clocks = le16_to_cpu(cfg.num_clocks);
+	for (id = 0; id < num_clocks; id++) {
+		struct virtio_rtc_req_clock req = {
+			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
+			.clock_id = cpu_to_le16(id),
+		};
+		struct virtio_rtc_resp_clock_cap cap = {};
+
+		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
+		if (ret)
+			continue;
+
+		if (virtio_rtc_is_utc(cap.type)) {
+			priv->clock_id = id;
+			priv->clock_found = true;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_clock req = {
+		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
+	};
+	struct virtio_rtc_resp_read resp = {};
+	u64 now;
+	int ret;
+
+	/*
+	 * The virtqueue must not be used before DRIVER_OK, which the virtio
+	 * uclass sets only after probe(), so look for the clock on first use.
+	 */
+	if (!priv->clock_found) {
+		ret = virtio_rtc_find_utc_clock(dev);
+		if (ret)
+			return ret;
+	}
+
+	req.clock_id = cpu_to_le16(priv->clock_id);
+
+	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	now = le64_to_cpu(resp.clock_reading);
+	do_div(now, 1000000000U);
+	rtc_to_tm(now, time);
+
+	return 0;
+}
+
+static int virtio_rtc_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	/* The alarm feature is not supported */
+	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
+
+	return 0;
+}
+
+static int virtio_rtc_probe(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret < 0) {
+		debug("%s: virtio_find_vqs failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rtc_ops virtio_rtc_ops = {
+	.get	= virtio_rtc_get,
+};
+
+U_BOOT_DRIVER(virtio_rtc) = {
+	.name	= VIRTIO_RTC_DRV_NAME,
+	.id	= UCLASS_RTC,
+	.bind	= virtio_rtc_bind,
+	.probe	= virtio_rtc_probe,
+	.remove	= virtio_reset,
+	.ops	= &virtio_rtc_ops,
+	.priv_auto	= sizeof(struct virtio_rtc_priv),
+	.flags	= DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index b981eead5..95069a2de 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -32,12 +32,14 @@
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
 #define VIRTIO_ID_9P		9 /* virtio 9p */
-#define VIRTIO_ID_MAX_NUM	10
+#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
+#define VIRTIO_ID_MAX_NUM	18
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
 #define VIRTIO_9P_DRV_NAME	"virtio-9p"
+#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
 
 /* Feature bits for virtio 9P */
 #define VIRTIO_9P_MOUNT_TAG	0
-- 
2.43.0

