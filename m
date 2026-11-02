Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266E60716E8
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pS7uDQ4q;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=jh6+mdH2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E0288112A;
	Mon,  2 Nov 2026 16:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bk1lX6ad1NGr; Mon,  2 Nov 2026 16:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AAC281137
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636468;
	b=BNdF8N812JAMQN0R5IG9b4TEkYydNcVFk1fPyW8qGVujwYr7zGfAXiObHIaJeADIzDR3
	 VGF2CcPx91qf5CAYnxjTia16tabF519cm18sGVLnT5WvNLBJBbOjutSmMxsCgccAjAMaV
	 WX4KQFIUazo6YDNRPUeE91dVScXXWfb5zQ3L6xPWL7PqLfmHGajdSesVQNpnX+MyIGtA8
	 L452KvGS2y9iT36IL9E77WpVkMWwW8ELoUEDgal3ZoYlted3KSsIZT9EldTzcciGJYSfq
	 AxCwN3MAHGu7ZjPln9jV9DT10vv/AQ97ppkh+tHoNr1QkljSUOQagYQOawq2pA0YJKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iCsvyfEZy+pbqhIztsmcS3wuoU7O8wgk7Fl93oYTCus=;
	b=KKIPXMN7JzfxKa1WNEN/KXl6lsdv4T5fSf6rvSrC/8LQfHjwJHliIYtC5l2FGvCpRazO
	 71p0S0kN2ZaJ3+Vd3/8IR6du7JZw1jrmWcCP/HNUaPX75bmKA9uuJso13v767XGiR3hyz
	 msf7e6i/J+Ghhf2QWfMHp/gy4o55JOqQ/9sGjGN1TqqHkGYCV2E6iTcarfgGj2FlQSy62
	 G2yKgwnxf9I0Le4HrLXze/98oZVGGUOmf0siBVaN/qSSpfq7Fxv22nTmu1Q1n7L2d9l0X
	 sBDuwcu5xXRyzAJulwXdiSBr+OXuXleyaIBnHuFFsS8JqX9/gJ/tMDDrhGJE070QPBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636468;
	bh=iCsvyfEZy+pbqhIztsmcS3wuoU7O8wgk7Fl93oYTCus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pS7uDQ4qJ9NpZfZZvNCyZ6e1h7rrYZ3puXMuvfwFPwzzO9C2TyLWfkVM6LUUZnPHO
	 SxT/COkeMwDe+SxVzSaT0Z3MXkXoFtjdU2/Bh74VTb4/IIhops9s/yIv926bldKfUA
	 mbF9D6rPZl0a/puONdoANfF91oKQ6DBqv1MEz7kWYU2bCzf0IlCwteqFJ2moXMwpeK
	 uNbxjjN5BDV5sbsDa6MDeRFTptO73EKf/fSvydqn3h63GcoqC0Wu7fn7M3npptwEk5
	 0IjcshA71tJWG2Q710KG9bYAPKXiiW9kxybF3hRoy9l5fgxIqUqfivpjf1jFNpovJR
	 ZUnNqPFaJ0byQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AAC281137;
	Mon,  2 Nov 2026 16:21:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E1FFEF4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F59A607F3
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOsHutkwftQL for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A51A6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636454;
 b=lFJyHY8YWhda/nWgUFfduQQreGbEbGTYReybOnLf9qM4NdPJeKJvVAqy6yEIdAvy2Qct
 gu05nqnQsqielnOlHNdKrpYmSbRZAd7sVVomKM0gc2CxOHQgH2NhE2EPzUW+L/KK+vUor
 bhraXEr9N3+Y5Z87uVDeCeVzlxIVME53ugo79U54ZISZKY0/+/PcPgK6lICwkEunQZp+E
 sp0CsUWDN3k/UbM8XT6FCgZYWMFpYglpb/N5p8MlQpuYXpvWahqOSDRTepqYi4pcC6bkX
 ThBCjKwz0W7V55H/8DBm663AyWgI3EHbQt4IByOV5hP6Jl5Bv7/HGGdRypJ2mwEDuvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636454;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=iCsvyfEZy+pbqhIztsmcS3wuoU7O8wgk7Fl93oYTCus=;
 b=cLlm71Sj/qhOHWpOUn+EPwvqWfkaFExOodrcROWFoGQMjs/kQ+b8iyNc6EVdmJPqJp+n
 +TgQIgNilbxupDtm2mrdLGO5/+szn7b/rqttcs+1dPEbTF6UDKD4eyHcIb2Ts74IgEr9I
 JCiDbzkdOQ42qWbzOJf9hYxGzVfIgSJpkntVtPvLxaXCHeY7VArKRz49n0XBO/qOpzCpR
 IlfX3V9ys1G9XVVmg5IYLKAaZXREaTjfDcruuHlYg2AB4g6f3ESXMHiEIR9Lg+lbe9VoX
 MglF2gNKh2/cChVpvUSVIngoFWmOSn60ffwW867prZTGrtx2oEdVyDMP4+X7jHCrxFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=jh6+mdH2; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=jh6+mdH2
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A51A6060D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCsvyfEZy+pbqhIztsmcS3wuoU7O8wgk7Fl93oYTCus=;
 b=jh6+mdH2Bw5zxahaByU4OgVSHxXMX6V4UU+DzMH9xqUb0nDbOXGyzHu3xo+oruYHYJE6X5
 SIPYmE9loimeGEBA685fDO0i+aQjCp7mmNhIiH+tEqyiNK1r+9N05BvBPE5ZJWc/cnbFzk
 1326DJHx3mSNDXccvvmzZKjtcljV2jAWkiWyea85/6BybkjvkL5mxHxLm6u9ucUhPKz7/6
 Dax4wx/fdbowsITLG01FpUqfwYEFcuzbdtAy1JtrVlkboEYybD7EMqIO8SYZ707ZSyUBuv
 1uJmtVLUDKP5eNvVsKrjZnjfnNjdl/dyF+4CD9ktH8clge5D77Ski8z8xZ7Tdw==
Date: Mon, 02 Nov 2026 17:20:22 +0100
Subject: [PATCH v2 05/12] test: boot: Restore the bootdev order if the RAUC
 test fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-5-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3746;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=i8Ax2Fak3b7D8e86dKjr/OVV8FPOHzNzRHbEz3WLrzk=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjtgz3jO5c3UD9nik7A9esHuifcFf35dC62Jj7k3lu
 Dpfe2pCRykLgxgXg6yYIosUv8VrW7NYH/lj1VEwc1iZQIYwcHEKwET2cTMydE759n15866PLhPs
 H235UnXHfJ7cvfQtQpMPr3ZN/rAofwMjw/0qxtUzvyuZnN+YsaAp0fpXo3HNv3n+q5o+XDhqvfT
 /NAYA
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

bootflow_rauc() points std->bootdev_order at a static array and only
restores the original order at its end. If an assertion fails, the
test returns early with the static array still in place, and removing
bootstd then hands it to free(). This trips the dlmalloc checks and
aborts sandbox, so the failure of the flat-tree run is never reported
and no further test runs.

Move the setup into bootflow_rauc_run(), which restores the order
after running the checks, whether they pass or not.

Fixes: 36add050eea4 ("test: boot: Add test for bootmeth_rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Add Reviewed-by tag from Simon
---
 test/boot/bootflow.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d478fd575be..d2d4edb0add 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1619,23 +1619,31 @@ static int bootflow_efi(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
 
-/* Test RAUC bootmeth */
-static int bootflow_rauc(struct unit_test_state *uts)
+/**
+ * bootflow_rauc_run() - Run RAUC bootmeth checks on an mmc bootdev
+ *
+ * This binds @mmc_dev and the RAUC bootmeth and makes them the only bootdev
+ * and bootmeth used, then runs @check. The bootdev order is restored even if
+ * @check fails, since bootstd frees it when it is removed.
+ *
+ * @uts: Unit test state
+ * @mmc_dev: MMC device to use, e.g. "mmc10"
+ * @check: Checks to run with the RAUC bootmeth
+ * Returns 0 on success, -ve on failure
+ */
+static int bootflow_rauc_run(struct unit_test_state *uts, const char *mmc_dev,
+			     int (*check)(struct unit_test_state *uts))
 {
-	const char *mmc_dev = "mmc10";
+	static const char *order[] = {NULL, NULL};
 	struct bootstd_priv *std;
 	struct udevice *bootstd;
-	static const char *order[] = {NULL, NULL};
 	const char **old_order;
-	ulong mem_start;
 	ofnode root;
 	ofnode node;
+	int ret;
 
 	order[0] = mmc_dev;
 
-	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
-		return -EAGAIN;
-
 	/* Enable the requested mmc node since we need a different bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
@@ -1646,13 +1654,21 @@ static int bootflow_rauc(struct unit_test_state *uts)
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_rauc),
 				"rauc", 0, ofnode_null(), NULL));
+	ut_assertok(bootmeth_set_order("rauc"));
 
-	/* Change the device and bootmeth order */
+	/* Change the device order, and restore it also if a check fails */
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
 	std->bootdev_order = order;
+	ret = check(uts);
+	std->bootdev_order = old_order;
 
-	ut_assertok(bootmeth_set_order("rauc"));
+	return ret;
+}
+
+static int bootflow_rauc_check(struct unit_test_state *uts)
+{
+	ulong mem_start;
 
 	/* Run scan and list */
 	ut_assertok(run_command("bootflow scan", 0));
@@ -1705,11 +1721,17 @@ static int bootflow_rauc(struct unit_test_state *uts)
 
 	ut_assertok(env_set("BOOT_ORDER", "A B"));
 
-	/* Restore the order used by the device tree */
-	std->bootdev_order = old_order;
-
 	return 0;
 }
+
+/* Test RAUC bootmeth */
+static int bootflow_rauc(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+
+	return bootflow_rauc_run(uts, "mmc10", bootflow_rauc_check);
+}
 BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
 /*

-- 
2.56.0

