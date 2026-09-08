Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D67C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A792D40546;
	Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNTvyiNgO0ou; Tue,  8 Sep 2026 12:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DBF14403FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788871489;
	b=Wb1PMbuTA9jNE7Be+TVGWbzvBuAAfifFkvSnna/LEuk2ncNLufYeiXGGjZoy4CoU72kW
	 PzFxlZTniRBDOH1r0j+MNwhVQJcsoRAhBIIqbDyziG4SH1KIcijJqceVq5l6aiuYiRcFu
	 IMLxW0FXxwvnY1MFubLN2IJ6Bk9CUwtjXGFtZ8ZX6kD9AMEgeZgzJ85aWIGTWNfxGNrDS
	 r0Wl78SqRUTqgtYuvC5C7/yJpW2kjUZJbQ4l4YcfLoT4s93t2kk06LgCUvsiD2wWGOzrw
	 Gw7ecrBkxmL2uy8OqNK1KPTkrtD268SMp/k5W5sVLQN2KgUxFslKwnjYRDDEdbDV9+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788871489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kfMCS/XIDZJiL0xEZZkkSvHqS28pq4g+5Rk7VqZrZ00=;
	b=akeYkRB/I1l07el7T96Pu12nZO5VZKRl+lFfQ9nVNQ9tvBKkuwzIKKfKuhtK0Sh4doJE
	 EyJVqnGwx/WMMHSrpjWsghxk/PAiBwzBuqXZZJAYiuWQo7SVR7zZ44QLpoQoZI6L007cX
	 v5llbM60L9fNgl0XD1pv4J2kiy/XqAc0PmIIaQCcDctSzfgihCmdoeh76XLJH+hAgXNid
	 5wBA+rBurbNkX6EYv6ltuqyVBiZlQb6zp3W3NXQPIM2NHJC3jXiwMsdIX6sgsZZj7VyBE
	 0ZjsmEt1RoIqANX44URRd2mF3em26nNBWKdBoUzMb+J4uQMNryhzaZf+2Wip86ioqSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788871489;
	bh=kfMCS/XIDZJiL0xEZZkkSvHqS28pq4g+5Rk7VqZrZ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTsl5dLG72ybI+pPdvGyqGVNOk/62X4RB6+udHNGmDawK/O7X6jze5ThVlOtAa8Y7
	 uJLlai2J8xaCnZJmYMDn5vFPfHxKwkvuYOkU+WyQNYyuHxDx+BtLNGLNrjFY0q11f1
	 A5nN9G3dOlC619lwg8lVBvvhOPg2ICr2mEeHq3ZhIeWFcKvgQhZnmpw49xwNJuOR6r
	 DHxsnJpFS+2fBTetPw8eRxdoj2ZWpWoz9fTJI9qx4bD6WZiaVhNxDYkweVM+HXVkOO
	 J7+xhrB7DGng+xnd9H+SiMXuptAeyk/kFyM2Jw5nqtGG7JoB7jBkroQys7796loWwz
	 olyW2Dns59u1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBF14403FB;
	Tue,  8 Sep 2026 12:44:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB992230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B887680A66
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lycvIn4TGniY for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:44:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A2C0D809E9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788871487;
 b=FODhaHcECN/RggO0UXsWfkGc4O4zZ7UTpRCAEiFax2AtFyOhzbIt+1bXUpBlgI8HsGkM
 Og+kpbS+Sdx8MlduiUIFXeo6CQAOqrEvGkCUUYvt2q3i+W9UIlLLUllWjfX7FqT3+/fZ+
 CR/8ROYrndOLC3JZqXW6QUttkV7lkmhcrPFw7tmnvvsaZwGkjXrI/eqXJ79vZKiRt0+6a
 nam/7BDfG64CEK5TQ9Z0iueYZqEigQkCR0EZsOxfAognPVhLzP0xcXWaCqnXBY/NdVHa/
 ajl8HU8/cSYnWsgT2GHg6UcyH+ZxVZ71GDDxB7NF5OcncjX949wEGmPqxL8pc3/FkRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788871487;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=kfMCS/XIDZJiL0xEZZkkSvHqS28pq4g+5Rk7VqZrZ00=;
 b=bkx05EqlXrdkETxnH4M+GoqGR4QJq8F16wEeoF6E7d7O15q5BhnIltGwuLijpGd10YCu
 inULzugfF6hxisdpGe6tEKMSOPM20RpWW866pQJtvgGKxy67Pl1WAvNT3g5Fs4OJiRmaq
 2bYYe8eq1u0Xw2nbjEBHstMve4zrj4FlyO+0sVYFWesKRsUDX3ubCeVtuo4NIRaKDHHOF
 4fsEzTRRWp1tHN6R+Ch/fxAHCOBIihXg+gm37TL2CvRYj2GUV0UGtTbNTzilGBUszMx4w
 FcyQyG2KERNyjUFDiA8ma/aKGgwExGVyhAKZgvx4f7I/POECyqLpUVmXu/Uo2T8KsXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Yq6P8kjf; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Yq6P8kjf
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2C0D809E9
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kfMCS/XIDZJiL0xEZZkkSvHqS28pq4g+5Rk7VqZrZ00=; b=Yq6P8kjfIPKo90I2oPFxek1oxy
 9jL8tS7PyVcDozk6m7iapcxgAKf4si5U+Y6gqYlc4W0I0uDHAysXgq5uxQwFvcRCeQPtbWmV9jVLC
 EdKFekcmDbzZxe3sEiVYyDp4TY5uRBd+iXJtktoQbTY/O65N0MnLagcQ2dvIqb1kSY70eazQjtQ/K
 vafIdXCYFt+/iOtBKfNTYUVVStJq/MbAVIcOTjG9qSoMk+mkyZXZG4w5vDl+JtfjBhYl0ptQ6+sNr
 P0mQQUSkyDf9uSwvo2AKlt9sFv5X3T7To6GPgVnmINE0OtpMkdCu5EtAXhUajXKkNmbvX2auJ14kB
 cDIhwElA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBr-000Buq-1j; Tue, 08 Sep 2026 14:44:43 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBr-0006vC-0p; Tue, 08 Sep 2026 14:44:43 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org,
	u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] configs: tqma7: rename TQMA7_SPI_UBOOT_SIZE to
 TQMA7_SPI_UBOOT_MAX_SIZE
Date: Tue,  8 Sep 2026 14:44:33 +0200
Message-ID: <20260908124434.894275-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908124434.894275-1-Alexander.Feilke@ew.tq-group.com>
References: <20260908124434.894275-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28117/Tue Sep  8 08:26:31 2026)
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Clarify the intended use of the variable.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma7/tqma7.env | 2 +-
 include/configs/tqma7.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/tq/tqma7/tqma7.env b/board/tq/tqma7/tqma7.env
index 05035078869..f46933a0cee 100644
--- a/board/tq/tqma7/tqma7.env
+++ b/board/tq/tqma7/tqma7.env
@@ -26,7 +26,7 @@ uboot_mmc_start=TQMA7_MMC_UBOOT_SECTOR_START
 uboot_mmc_size=TQMA7_MMC_UBOOT_SECTOR_COUNT
 uboot_spi_sector_size=TQMA7_SPI_FLASH_SECTOR_SIZE
 uboot_spi_start=TQMA7_SPI_UBOOT_START
-uboot_spi_size=TQMA7_SPI_UBOOT_SIZE
+uboot_spi_size=TQMA7_SPI_UBOOT_MAX_SIZE
 
 #ifdef CONFIG_USB_FUNCTION_FASTBOOT
 
diff --git a/include/configs/tqma7.h b/include/configs/tqma7.h
index 6b77139f09d..26275915e22 100644
--- a/include/configs/tqma7.h
+++ b/include/configs/tqma7.h
@@ -44,7 +44,7 @@ static_assert(TQMA7_INITRD_ADDRESS == (TQMA7_FDT_ADDRESS + SZ_16M));
 #define TQMA7_MMC_UBOOT_SECTOR_COUNT	0x7fe
 #define TQMA7_SPI_FLASH_SECTOR_SIZE	SZ_64K
 #define TQMA7_SPI_UBOOT_START		0x1000
-#define TQMA7_SPI_UBOOT_SIZE		0xf0000
+#define TQMA7_SPI_UBOOT_MAX_SIZE	0xf0000
 
 /* Physical Memory Map */
 #define PHYS_SDRAM		MMDC0_ARB_BASE_ADDR
-- 
2.43.0

