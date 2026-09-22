Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD36C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7764606B1;
	Tue, 22 Sep 2026 06:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WGu2sWPgegg; Tue, 22 Sep 2026 06:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D88A60668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790057416;
	b=gXwz2LiEbbnQLjpwDS6fBJb/vIwEjlkTa51XLRQ5i3CbOrxg8XdhBTpOa7/OMwHep2aj
	 Ko4QvqrFRIOeoa109FVHztnn7GhfVkg9JPJoCTiQ9j6LBu4DDMlRb9x+1h7UuRrv3Xhxu
	 SpR+RjrBYzV2bbquX6IsW3G9IrIod+Y6ydm57iyHeVwFCqKzmClFrJPzvmIYFqwd3SfMm
	 O0ySaa7T7RPCVQjJlacMG2vuWPs5+9jyplUnB+o+YNmybKLB/46KXMtT6Sw+wsqZd5yJm
	 4JL95dNz2yD++BcMlUJxVQsp9gmCnQRlUbGR3FE/S6lGeY80WihkAQoGjJwRUiyshhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790057416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AUJBHBC6/8UBbwH6Vbm9eYu+EjMORYQnaOfg/WPjx7A=;
	b=LhSUs7LBXaVXyGZKJSPT/S6RR2hm7pa1/w8tlFy46d++CXl9OR4iujWXS+a2/vOpy9RG
	 MMvDXaBr3eLxsGhf1d98eXu6WUlkZMXJpkGNo7mPN//TsmMBH+ENJl7/OGTh3je8KRIkA
	 Tinl//dUeUy+NW/tOky8bixhJmWde0x5uneovAXFi+S87pegD9sZU7Ni/IxrhgWwA4YmD
	 syb0Hmd6O5i0YOCtv2QHZDY6Blzcnth0jY1v7XglkBmwLbIihnGHNS4ITQnbp0sEQMuD6
	 xb0ChoIFeJMc6UqI3y4UlcyosV5W3c2PFTCOF5UPeXFm6u+pGeirhnFzBgj2eesL5ow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790057416;
	bh=AUJBHBC6/8UBbwH6Vbm9eYu+EjMORYQnaOfg/WPjx7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmSFBjoDetkfDH+ZYXGNJRFWJ9u0gPCwnDXTCcGOsIRH5z70C53s8sr7gXmJb8gJ1
	 6EYsgCeeWAyDvFiZE3jDeCJva0GF687kFXSieO46nhh+OC17+CC/kbQSgVKAVp1jSN
	 psy0yrMI1Sy6qTP6aZaTyjw7v4hJXRFqFGwRP5r3+dGIMTCi5ZqzVsa8JjH3VVLLpu
	 mzDZJlkh5sdeyzpxsISsKLjG0FngG7jGqxJ9KM8Tk2zrQSsNTkMxGw0MYkLFB6l9vu
	 4yPzf3pmH+IRGAKuGUJeLIwFIGe5rvTvabjOltelUTD1YbCrjedk5AXQTn++O+bDBj
	 NpaVv7j6mxvyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D88A60668;
	Tue, 22 Sep 2026 06:10:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFE0134E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1FB480DA1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ew3nJq2u7hRw for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10D7180D9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790057413;
 b=QX++aJP1zAXrY/pO+/fMT1ZaUG3Q5QweFtW8FrKrHDSM1AYOLV2MH7OwRNW0J4jP7g+B
 QlXz5QSC+QuJGPUNZvrwsPtYnnZlfqX9mkszlhZ8sVH+17OM7ViLMA8PsWO3++J6I6/JI
 1OHCq+ELHzfhgoQkOBWC7Y0PNuqjWDDt0mwoUR3HT5Qt3r14fSfYx9QPFJwT90wk9IiPO
 1irPaGKA21A+/cVdSS7aGZPhT7mqqDoyWBFqMaZpgTmv79kvwyMnM+WvtPSBQ3593fVaJ
 jc1OYEgCofvkslIs4gkPsvIiLh4BPALkM8+U7xjM5uUl0gLT+zOYQbmtdy9IbEtIBYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790057413;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=AUJBHBC6/8UBbwH6Vbm9eYu+EjMORYQnaOfg/WPjx7A=;
 b=DdGKU66ejY99O9Zwy1IBflpPJJI5JqpjGXWmGt1lMBZxXSSf3/vWWdZ7bPF6I0+Dei3G
 D0lCgLojATqLVCW4M9ZOBSkN8lWmJn7VX51jNUehyutIY2wRy5Y1q5bP5BFv7rHA8K6QP
 u6hyaVDVPkRg6r8h0SDoVS0jSJcqZWzz5O8C1szMUkYXwold6GzgVbuG3aNnltiXCy06p
 iHxXSwgKUEoZuoq5xyvqxBU0DA2PqbE679KjN9NI+ZV3KPHSjpD4OkEI429QAdTDJ6kUv
 Cw1KqYBWQzAzc9PBwMuP40ZGx93NLMj0EkCxp7kQVvVNxFSms9xleRRykZ6a7Bl+2HA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZF4N6EcV; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=ZF4N6EcV
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10D7180D9C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A7A91056FD; Tue, 22 Sep 2026 08:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790057406; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=AUJBHBC6/8UBbwH6Vbm9eYu+EjMORYQnaOfg/WPjx7A=;
 b=ZF4N6EcVf6j3CFBxfm9JZ94bpioQQEVP9MtJ83v8yzsaakBFzG+Im7V7209Lvx01RNCwV7
 NRqbBmIKE3hL8Bp9CRt6cPFA6cvR4RzPw9cDc1pGwQzPBledOqmPtp3+XBhft6964I8XAS
 8uk+PQMjpyHndnIQUBuQWyIfic0Dqr0yB7WAP6hXDdhhfyo+Kvt1Y5RNglAHbvdgjrI8mg
 PGrd7RNVcchJG3r2vTSxHERy58lYXhMRAoziIgBvd2kpkWXRS6t4uazkxNrDJoq4qNRCUA
 bP8MiKUDQdbDp+ZVjEMdH8N7peigYZ4DpaSh3QFpFzhLg6VSZpQ8JSDUjLz5Fw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Vignesh R <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/3] sandbox: spi: let a slave name the driver that
 emulates it
Date: Tue, 22 Sep 2026 08:09:31 +0200
Message-ID: <20260922060941.534035-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060941.534035-1-hs@nabladev.com>
References: <20260922060941.534035-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
on the sandbox SPI bus, whatever that slave is. There is no way to
emulate a different kind of SPI device, and a test for such a device
therefore cannot be written.

Take the name of the emulation driver from a "sandbox,emul" property on
the node of the slave, and fall back to the flash emulator when the
property is absent, so that every node in the test device tree today
keeps the emulation it has.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 drivers/mtd/spi/sandbox.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index e5ebc3479fb..bb3e34175c9 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -518,6 +518,27 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
 };
 
 #ifdef CONFIG_SPI_FLASH
+/**
+ * sandbox_spi_emul_lookup() - find the emulator standing in for a slave
+ *
+ * A slave that is not a SPI NOR flash names the driver that emulates it
+ * in its "sandbox,emul" property. Without that property the flash
+ * emulator is used, which is what every existing node relies on.
+ *
+ * @node:	device tree node of the slave
+ * Return: driver to bind, or NULL if it does not exist
+ */
+static struct driver *sandbox_spi_emul_lookup(ofnode node)
+{
+	const char *name;
+
+	name = ofnode_read_string(node, "sandbox,emul");
+	if (!name)
+		name = "sandbox_sf_emul";
+
+	return lists_driver_lookup_name(name);
+}
+
 int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
 			 struct udevice *bus, ofnode node, const char *spec)
 {
@@ -530,9 +551,9 @@ int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
 	strncpy(name, spec, sizeof(name) - 6);
 	name[sizeof(name) - 6] = '\0';
 	strcat(name, "-emul");
-	drv = lists_driver_lookup_name("sandbox_sf_emul");
+	drv = sandbox_spi_emul_lookup(node);
 	if (!drv) {
-		puts("Cannot find sandbox_sf_emul driver\n");
+		puts("Cannot find SPI emulation driver\n");
 		return -ENOENT;
 	}
 	str = strdup(name);
-- 
2.55.0

