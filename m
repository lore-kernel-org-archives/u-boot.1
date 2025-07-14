Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D222C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021DF83045;
	Mon, 14 Jul 2025 15:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="1Pf46iWW";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="Sm2RALQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C6283055; Mon, 14 Jul 2025 15:22:37 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FAA82F8E
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=2UP6T+wptKcFgV2EqCSR1VodQAXP57pHdH5CzJ+bidc=;
 b=1Pf46iWWmjgsitd0u1KZF2wOSZ/wREIr8m1ea+3S+LoUJsxdn4k6fzsLhGJbOG5oxd1kLUtjI/dMX
 4JGmH6x+/Q4ng5bYNqRzTMeqL6JcynP2myr5GmRJpbB1MdqhVA9pZuBbCMAb9Ml5H0nG2Ur3bBUqA6
 bNQpmqlozzRK6Gz0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=2UP6T+wptKcFgV2EqCSR1VodQAXP57pHdH5CzJ+bidc=;
 b=Sm2RALQGM8QFGH1R4yO+rsvMZbiA+ILQPSUkuky318C0kooI70Y584IzUnehGEe8n2RGtZBv4P9eW
 g1R0vcBBpwhgNJDqqqNVt5ewzhGuNggJqy6Sy3xqwaa7m+wpWVaMGTbKBqGoSp3HWKfH1JrpiPQDDF
 wZLqjNQwWhzxFnrtXBed/wGR1+xe62fVT6WL+vI3CII/zGujbHcsRFCvJzk6Vm0wPvrWisrSvATPRY
 1bPAI5jfjZNHYVBvx0DTDarw6MpK8W3ST8CrMzmbjBi23Gji+lttMj7EHTew+EfDKOp/xKfijKZPrs
 3qvDAHQBuuzCXNrWs3O1Jif2vuWROxQ==
X-Originating-IP: 20.86.212.242
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 98f3e45b-60b5-11f0-be1c-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 98f3e45b-60b5-11f0-be1c-eb1d40c36193:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown
 [20.86.212.242]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 98f3e45b-60b5-11f0-be1c-eb1d40c36193;
 Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with SMTP id
 CDC648052C6; Mon, 14 Jul 2025 13:22:31 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id AB32F609521B;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 4/6] km: pg-wcom-ls102xa: add netdev in board env file
Date: Mon, 14 Jul 2025 15:22:19 +0200
Message-ID: <20250714132221.2471558-4-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Upcoming boards will have different ethernet interfaces. So we move this
variable out of the common code.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env | 1 +
 board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env | 1 +
 include/env/pg-wcom/ls102xa.env                 | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env b/board/keym=
ile/pg-wcom-ls102xa/pg-wcom-expu1.env
index 1054dbf9f54..c1c73b7da49 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
@@ -1,3 +1,4 @@
 #include <env/pg-wcom/ls102xa.env>
=20
 hostname=3DEXPU1
+netdev=3Deth2
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env b/board/keym=
ile/pg-wcom-ls102xa/pg-wcom-seli8.env
index 1232fe9da8b..bbfa8194a7e 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
@@ -1,3 +1,4 @@
 #include <env/pg-wcom/ls102xa.env>
=20
 hostname=3DSELI8
+netdev=3Deth2
diff --git a/include/env/pg-wcom/ls102xa.env b/include/env/pg-wcom/ls102x=
a.env
index abbec424574..88aaac8f008 100644
--- a/include/env/pg-wcom/ls102xa.env
+++ b/include/env/pg-wcom/ls102xa.env
@@ -8,7 +8,6 @@ checkfdt=3Dtrue
 cramfsloadfdt=3Dcramfsload $fdt_addr_r fdt_0x${IVM_BoardId}_0x${IVM_HWKe=
y}.dtb
 ethrotate=3Dno
 hwconfig=3Ddevdis:esdhc,usb3,usb2,sata,sec,dcu,duart2,qspi,can1,can2_4,f=
tm2_8,i2c2_3,sai1_4,lpuart2_6,asrc,spdif,lpuart1,ftm1
-netdev=3Deth2
=20
 newenv=3Dprotect off CONFIG_ENV_ADDR_REDUND +0x40000 &&
        erase CONFIG_ENV_ADDR_REDUND +0x40000 &&
--=20
2.49.0

