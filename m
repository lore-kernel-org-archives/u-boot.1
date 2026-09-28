Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F00FCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD65280EBA;
	Mon, 28 Sep 2026 16:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id siqRYmJU43jp; Mon, 28 Sep 2026 16:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 13B9880EA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790613009;
	b=cBplJHz/Re12TIpdPH5PBozKTgR6jZ/Dc+LRo5rNoFptC3/35c3OIqXtq/B7EOhVFY9J
	 rMHqQXyyjO9fLJClWm0dViBvDMpj++5jn8EJP3fmTar7axErecPHmKED6woEzJRebnIdW
	 ADbh6C5j9KhHOJIWjXyg3KWU9Dj3wyetgVZyHGZ34DwCdLakXHBqcpiZnmr6spWRhVAzB
	 0mC53u82s85oEXIARbhoqQ9CRIO2OKNO6U4hNEFlNxvYvrZ4Var0VpKvUStGWa4c2kRv8
	 QM2cvOgJke5dDLpz7OS07j65j0QLki+ay5BYL0O28gP0LICDY0lkyo/FzUGBd2FpmDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790613009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=slEPYW7xuHZ0rze+Cd1l1CYs/J3GtEAa1fcdMhPEMLI=;
	b=SgcMOXpnj7wjAcakmChyZhIDDMcRru3Rpmoxc9wr4CdMWxtwe/AgtrVKRdIZqDvP9XFH
	 LJBlEpStetAdr9dRJi6IFcOLDIk7F5OjEgZ+gKeCAlq+4XDDeYCLFu8aaf3e4+/HsguiF
	 blNh6o5XwciiqRUQfaAlRmuW1MoFALgGxJfcVaLRYntlHkbGOPxLDNPk9NfxHtHV6Gmlq
	 gpfQmR5zqj47oku3/Y67TKxWLFrMFOuoQloH/J8VFT+dgCjRfKmLNu80mVAFPKyglOjoW
	 HthS46MyPHFpp65UlLl+NzeKwwFYCdoFn4ByFCgEVJdPvV1MbHu7pihIyL49dZkmXiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790613009;
	bh=slEPYW7xuHZ0rze+Cd1l1CYs/J3GtEAa1fcdMhPEMLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=on0Suub1yoY8OVrrVaZRSI1loHRJzDgfJdVpy6wxk6gg9wOU+SqucuBFtymW4dMKY
	 oTUONSUia4OWNvWNgmOeJw8CbtRi+qos+RMb2jFE48aVaIrDkvHgn/AoDw3jVUAAB0
	 IL9mwCWRdG72nb0CifbiKnnYXXrrt03oHjQnstuQX/B3bASPqHvJYd4CQkp8LoMpxy
	 a7W3H5nxVdVAgJe4kxZZV/NQDlzfpsD7kNodaIWBlmIpMUKS3lFhmlAYFyn19O1SCj
	 bh365EfwR4CBUNXj2ZPTEd4ynd/wTKNhehxoj46qHQ4YRgBDBdvOzVgFipzp5IRfJc
	 23Q5PVAVIzXyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13B9880EA1;
	Mon, 28 Sep 2026 16:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBE2472
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9B29400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvtuTZYXH80K for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 11783400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790613007;
 b=IuJth9CDRjwndILHrJTNsOvs8pG9vC5IAQQrQU2MiJ4FYw7W02uGHXfIWLqfzfKOFDoS
 RKSk5/w+8JxjHnQ51e7APwfyslrff3ve7Zbwtu6NCdQT13EVteY/GbECLhFlL/gb22NBS
 tKM0RC1gIf+A4lW+yuVcHRdspF1OwdDDVYpLJQTIps18tjhRhBJ0fxspeLi7SfeuCU2yK
 AjgtrgRFg6qr1ge+HmX1k6FkG8RLiDVsh7F6WRwY6F5gtflfmci6Z113FfMtt4EbMpuyZ
 3A0Pc9pdsqz/fj1CdXJsKqEpDLWq1QkSO91hNlsZnG9fQ/5gjKHExeoYnWMXqBxQy9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790613007;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=slEPYW7xuHZ0rze+Cd1l1CYs/J3GtEAa1fcdMhPEMLI=;
 b=Vfn+ZdJsNJMcJLUFB75nQ40Nn1EMu6E4twzFBUIpDbi7Hq7SRhCcaRK9r2v3Y4BNtLxZ
 z0xi77+vsXP6LphanhCDzXhF+8m763zMYgE+56raiQiAP3q/Gd4dTi/Ha+v2nwMSRoubr
 JY6g+Imfmiu410RNHzysAGbrc6Dz52/Bn6LiXtx93J2UxW1zOU+D2fxVQo7pvaNjgwqVu
 C5onTr0tIZj6KxyogfMG/LoJFrgkPaiFql1xlDxDldHOkh4mvIlqi67fLu85qyZZhalTB
 nPrYwIraBNCG1FoePN4pjEqAiAV3sdoFe+hT8FIkErE2XpOW0g4cEWh/mcAaZMngcsw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=bEWzx1ql; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=bEWzx1ql
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11783400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1C612B0055E;
 Mon, 28 Sep 2026 18:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790613004;
 bh=FvpMtxQYQwkPw336Xdd8zaDSi0SbtjTsE5GBYtPiUKo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bEWzx1qlsh+TtKhxl83FQe1uzII9r1hiWw53gMr3RfKgIWp0TudDK0aF4lSb506WY
 Y07LrOrDP71jx8TMzNYSH11LjAB83B/OfWZ/L9N7roTIES1xtB/YoZHpwFVFpDjQ8V
 1Ah7dEtDr0k13pjfKJAbLtIM+AZi4+0QeScmpX7i0pPjaxVBHeSBmsi7LuRlC+y1AN
 cAjbIoIWoHInSlTDwDrC1+GZnJFBkrbjwLDf1nfIOhKwyTWQb0itDRDr6adi5rXdrs
 20n+60JGKAAEMH+JbL0utHKiLKpRoTQyXdZq1TaKMu+m0fCbAVF/YLUhl4WAX+PASo
 8UvVwQSno7sBA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 3/4] test: dm: pmbus: test
 pmbus_regulator_read_vout_command()
Date: Mon, 28 Sep 2026 18:29:03 +0200
Message-ID: <20260928162904.1143614-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928162904.1143614-1-vjardin@free.fr>
References: <20260928162904.1143614-1-vjardin@free.fr>
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

Read the setpoint of the emulated chip (VOUT_MODE 0x18, VOUT_COMMAND
0x0200: 2 V), write a new one with regulator_set_value() and read it
back, and check the -EINVAL and -ENODEV cases.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 test/dm/pmbus.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/test/dm/pmbus.c b/test/dm/pmbus.c
index 0184b201829..a2ef6b7b7d5 100644
--- a/test/dm/pmbus.c
+++ b/test/dm/pmbus.c
@@ -10,6 +10,8 @@
 #include <i2c.h>
 #include <pmbus.h>
 #include <dm/test.h>
+#include <power/regulator.h>
+#include <power/sandbox_pmic.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -190,6 +192,45 @@ static int dm_test_pmbus_vout(struct unit_test_state *uts)
 
 DM_TEST(dm_test_pmbus_vout, UTF_SCAN_FDT | UTF_CONSOLE);
 
+/* pmbus_regulator_read_vout_command() returns the setpoint, VOUT_COMMAND */
+static int dm_test_pmbus_vout_command(struct unit_test_state *uts)
+{
+	struct udevice *dev, *other;
+	int uv;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_REGULATOR, "pmbus@70",
+					      &dev));
+
+	/* VOUT_MODE 0x18 (LINEAR16, 2^-8) and VOUT_COMMAND 0x0200: 2 V */
+	ut_assertok(pmbus_regulator_read_vout_command(dev, &uv));
+	ut_asserteq(2000000, uv);
+
+	/* regulator_set_value() writes VOUT_COMMAND, read it back */
+	ut_assertok(regulator_set_value(dev, 1500000));
+	ut_assertok(pmbus_regulator_read_vout_command(dev, &uv));
+	ut_asserteq(1500000, uv);
+
+	ut_asserteq(-EINVAL, pmbus_regulator_read_vout_command(dev, NULL));
+
+	/*
+	 * A device that is not a PMBus regulator is refused: another
+	 * regulator, and the chip emulator, whose private data (the
+	 * register file) must not be read as a pmbus_regulator_priv.
+	 */
+	ut_assertok(uclass_get_device_by_name(UCLASS_REGULATOR,
+					      SANDBOX_BUCK1_DEVNAME, &other));
+	ut_asserteq(-ENODEV, pmbus_regulator_read_vout_command(other, &uv));
+	ut_asserteq(-ENODEV, pmbus_regulator_read_temp(other, &uv));
+	ut_assertok(uclass_get_device_by_name(UCLASS_I2C_EMUL, "emul-pmbus",
+					      &other));
+	ut_asserteq(-ENODEV, pmbus_regulator_read_vout_command(other, &uv));
+	ut_asserteq(-ENODEV, pmbus_regulator_read_temp(other, &uv));
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_vout_command, UTF_SCAN_FDT);
+
 /* pmbus dump walks every standard register; spot-check one line */
 static int dm_test_pmbus_dump(struct unit_test_state *uts)
 {
-- 
2.43.0

