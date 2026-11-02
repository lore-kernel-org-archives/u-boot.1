Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D9608441A
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wOtlBaaR;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=gw50eTSP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 501718119C;
	Mon,  2 Nov 2026 16:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D07XN8W15mtT; Mon,  2 Nov 2026 16:21:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6199881195
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636474;
	b=hcU+YPmBVtSONK/TSKkOpKRjMsVVqGPAXL7wah9FmMnKbFOOi+qWlGtGagdnt4FxX90v
	 Q2GFQteesWMUM58RNEhiAF0kJDRRcpAD08sG9Jd/jG6qX7AMlzHO8u55sNVKLx5pjTbti
	 FCtKGY/N4F29IZiUATTvxqhqkJ/dXMEuBd0moPC7gXl+pbnZOB/N3ZIoDHygcaqXcyKkl
	 viw8mbxC4W7yzkBFAvsX1uACIf43wsWJIOR4uIeEkVGZj2OxYBDYdAVoIV/bD4Lz2GaJL
	 2SpD8s1PKvDV4JlRgYuf6MEbQn4AkRu2mCkFXftzwZSekPiGoBYdj5vfuhM7jSW2pSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hU//vBEb+OQqoCsy/+/Mdg40GLiF0ZcNrSL9gtXfWG0=;
	b=BcfBr3AqkgWx0+me3B0VnLwuH42HrV1vmZ9xeQ/gnz04Vz+VTBqvIQV+aaCo4OBWaRJH
	 2pknSPQQ8l0e/uhs/2ZQ5WbTqPYOw3OkeNzDU9gpcNgH4soaMc5ZF/wfwE+oOqKLYDM0g
	 yIMUx5aWHteZPyGgA4dbeKjiwSXyFuO/CIOwzEK4P//XVyVBpD2JAghWcK1Wo0KCurQy4
	 4l9iJNahvWh2eBDgl90KXSFdXYcNNWzM9eQ6A6l93cOU3z7cphn1WXBIxYDULCY2QWy1s
	 Zm6eZkttYeoQ65PRop7I0Qt54ao25qPMtFIVPQkWhpL+LantHojI14MhqYrdCAf7nXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636474;
	bh=hU//vBEb+OQqoCsy/+/Mdg40GLiF0ZcNrSL9gtXfWG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wOtlBaaR0VgzXeO5gWUdHqtcwO93ONpr4ntTv6OHc5cq7ypQswD1u1YGYei4ZIhKf
	 syi9bkH/BtcbtkV/M7EdYXdzg+LERfqgzV8t3hsC+lVqWiy8mkUHfM5yefsocU7DUo
	 1HlTk7re7BwCHgITjOfxTxu04QFikYyJ0Au+5xn71IhBDOFXKBJr0zyM4JpDCOSjDR
	 tgV8qYYvfv6lI9WkFroBG1w9BIvicYzOWUPaYEaVQEnKXf4Ic4jQcJ284r3NM6GtX8
	 05FetTXgxdQihceDj8lF8OKEVGos0aUFjTNmNLBRAFYwHfQ8wUgZb5j9dGgD0ooc7L
	 +ybVwaXHMZidw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6199881195;
	Mon,  2 Nov 2026 16:21:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7AED3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24D9C4018C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stYaa46rc00r for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5AB5C4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636455;
 b=ljdP8tFvYeQTUA5KStVRk9X7axCOR2eUFcR5FZXvlIeIzveuYkXWY8jChzGsPoaMMJks
 K0YO5Zr3wtoNtEjgoS/mwFRaGP71g2EI4xy2AjuQWwhfUF+dWiqe3k3RKoHnO/oEAyvtq
 MgfMJzMnEFNqaeOSIOTsbvQRmguUmZfeRFPAAt+c4YvNhr2tlAssWUdZvHrM+vSlT01JB
 yny/hi4wiaxfZaQ+0TWLhBZomXwXk4teSMUmbDai67S7vez7UYIODCux+Ngtnu1eIzCXu
 JO41Ma1ykc3kVOl5xpCFTh9sOI0HwiAkeempZu5dsn9Y/i9DBZVC0EcAC1EGjmqR9MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636455;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=hU//vBEb+OQqoCsy/+/Mdg40GLiF0ZcNrSL9gtXfWG0=;
 b=K3II9LkuXXb1u3aeCasDcfnLUMhPzZ87iyfjPXBAzc6PXxrQo6adymlucxRlALCvV3PI
 lRlXGx3YekFwxypgQaT2FeO884pmHcXRSf0cTaE/10JKG5/lic+v3AGHZGBOMCB8qThdh
 aMFZCX+YIyqKpO+Q7cqVRTJCVTqWP3cQkJi9OB85+M31VIVX40d7FFXOfL7P8WzvqiEE/
 g+ZFuuEUl1pFJs+OfKOVzc6axSh6geMC7/tjXaOu8h7Z7Ca5msatHxvvTtH1mJTxcGygC
 MMe1ji9o9+sZX74mMOsBIpY2Tvos16uyTtRErhMtl3H3N6YLxWVRzznlzrBoWWPkS3Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=gw50eTSP; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=gw50eTSP
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AB5C4009E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU//vBEb+OQqoCsy/+/Mdg40GLiF0ZcNrSL9gtXfWG0=;
 b=gw50eTSP2AUms3yf1EavsS310DSReuAoWPz02+TFJNH2pl5KEW+rXTFx63tiIa+LehAzNU
 dRDxOWh9r3KQzRJOt4ichd6ULuHoIbNgY5t6jHR7/hUc2wjlIM0kj5RD8+t4zrMI0k2dTF
 yOCJ5N4wUPVuDNcdxqjDnr0Rc/65R9lAkM4/xtk7jV2hFHyCqZcdLZROFfmybdxrbzX2nC
 v0oknO+FsdWYAi3JsL8i7wsiJrC+0Z8pyYRLWG+AiSnXI2lzHI7K2wRzGnlZ7qVx0aoNmx
 PYCLDRTGFmp9jdlBhxLwM6824wJ21WgTfd4885UGcNUuHjA+Tnxha6WNqyziIg==
Date: Mon, 02 Nov 2026 17:20:29 +0100
Subject: [PATCH v2 12/12] test: boot: Test the RAUC built-in boot command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-12-4537bcb19d66@kontron.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=VCK1QHe1JRq/WmFIulzQU4FetiPfYDF9UPsHWS23pmk=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjridq8T2vOHbOPF2dvDti2ebTnZ/8lp6U+HtL/24D
 Xevr2Z+0lHKwiDGxSArpsgixW/x2tYs1kf+WHUUzBxWJpAhDFycAjARZzaGf1blM5St/9UfiGIQ
 UNd7UZl+79irdKnTaavd7x8Ldv/6PJWRoatw+c7bOVqhnn7iea5qqQuufuy8xqosVWxZt1DINEO
 BFQA=
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

Add a test that sets a built-in boot command in the platform data of
the RAUC bootmeth, which runs a test variable, and boots the RAUC
bootflow on mmc10 with it. It checks that the command sees the slot's
partitions and raucargs, that the boot script is not loaded, that slot
B is booted once slot A has no tries left, and that a failing command
uses up a try.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Set the command in the platform data of the bootmeth instead of in
  sandbox_defconfig, and drop the #ifdef (Simon)
- Move CONFIG_ENV_FAT_DEVICE_AND_PART and the environment handling to
  patch 6
- Also check that the boot script is not loaded
---
 test/boot/bootflow.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 0c22ad58521..2278453ca4d 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1664,6 +1664,7 @@ static int bootflow_rauc_run(struct unit_test_state *uts, const char *mmc_dev,
 	ut_assertok(bootmeth_set_order("rauc"));
 	rplat = dev_get_plat(dev);
 	rplat->partitions = "1,2 3,4";
+	rplat->bootcmd = "";
 
 	/* Change the device order, and restore it also if a check fails */
 	std = dev_get_priv(bootstd);
@@ -1924,6 +1925,66 @@ static int bootflow_rauc_part_names_mbr(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_rauc_part_names_mbr, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+/* Scan and boot the RAUC bootflow, as a successful boot command frees it */
+static int bootflow_rauc_scan_boot(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assertok(run_command("bootflow select 0", 0));
+
+	return bootflow_rauc_boot(uts);
+}
+
+static int bootflow_rauc_bootcmd_check(struct unit_test_state *uts,
+				       struct distro_rauc_plat *rplat)
+{
+	/* Start with the default tries, also when running a second time */
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+	ut_assertok(env_set("rauc_test_boot",
+			    "echo rauc boot: ${raucargs} ${distro_bootpart} ${distro_rootpart}"));
+	rplat->bootcmd = "run rauc_test_boot";
+
+	/* The command returns instead of booting, so the boot fails */
+	ut_assertok(bootflow_rauc_scan_boot(uts));
+	ut_assert_skip_to_line("rauc boot: rauc.slot=A 1 2");
+	ut_assert_nextline("Boot failed (err=-14)");
+	ut_assert_console_end();
+	ut_asserteq_str("2", env_get("BOOT_A_LEFT"));
+
+	/* The boot script is not loaded */
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_skip_to_line("(0 images)");
+	ut_assert_console_end();
+
+	/* Slot B is booted once slot A has no tries left */
+	ut_assertok(env_set("BOOT_A_LEFT", "0"));
+	ut_assertok(bootflow_rauc_scan_boot(uts));
+	ut_assert_skip_to_line("rauc boot: rauc.slot=B 3 4");
+	ut_assert_nextline("Boot failed (err=-14)");
+	ut_assert_console_end();
+	ut_asserteq_str("2", env_get("BOOT_B_LEFT"));
+
+	/* A failing command uses up a try as well */
+	ut_assertok(env_set("rauc_test_boot", "false"));
+	ut_assertok(bootflow_rauc_scan_boot(uts));
+	ut_assert_skip_to_line("Boot failed (err=1)");
+	ut_assert_console_end();
+	ut_asserteq_str("1", env_get("BOOT_B_LEFT"));
+
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+	ut_assertok(env_set("rauc_test_boot", NULL));
+
+	return 0;
+}
+
+/* Test booting a slot with the built-in boot command of the RAUC bootmeth */
+static int bootflow_rauc_bootcmd(struct unit_test_state *uts)
+{
+	return bootflow_rauc_run_env_fat(uts, bootflow_rauc_bootcmd_check);
+}
+BOOTSTD_TEST(bootflow_rauc_bootcmd, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /*
  * Test the BLS bootmeth against entries that live below a '/boot/' prefix,
  * so that they are only found via the second bootstd prefix. The Fedora

-- 
2.56.0

