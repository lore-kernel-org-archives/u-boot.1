Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED0606A31F
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=alK7x8Wk;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=2mIK64c9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9376A8105B;
	Thu, 29 Oct 2026 16:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6i9IQ09zYQWG; Thu, 29 Oct 2026 16:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FD378100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291032;
	b=b5uKaOTwtOSxM452pA7x3dTvUKgrIN9kkjvsJjGVFDJE08Sn7gl6TqnRWUQet04xt8/p
	 /j2f43hu4aUMxTqwF6skHIjbsFS6vWVlgoyw9nQhzbxSuwm1wG/dZupc0QDYHtATr2Omx
	 VodXv7HZMZ8SOOC3cP/DRvd9iqEzvh873I/nf2KXB921ih5yrV714eJl/1a78QgcPiX49
	 oJ8ebUrkDPpNmDEoijVnFl0LpULQE0Bx7/fymoNluzfCyaOyYYLkqjwiEvfRMwKHOajk/
	 NH0qXwG7QKVFapLsO+wCTTsD1UgqpNWAbh7sI2+vefGb/k6eJRKd4zcCLjJ6IaN9x9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TAH9cJOniS8v+YhQu1rkj+SxTN5ldXQAx+poY8WJ6gM=;
	b=Je/lbIdaGZ2Cdsq/PT1tk5Ch7dQ7w9BAmv2lf1+Xsp1cg5zMcF1rUH6qfhMhloc7TyKc
	 +j9oYUAx2EPy7v656q5mc7zi1uyp0+LxBZMZ9kLpUnLx95xJHXjY4daagzLK5Am61/0Nq
	 x0oJYaDGsBlCxcpfpvbn+WyQdGATG+vqJC4NgRyU2BewsADIP0v9hlTe5jHrsb9kJZM5A
	 GiTVBb1nngbj777fpH7j58CjnUwpR/WT4na6RdBPRP5Dt2wp6PEZ8Ip9QEVzVozjyy/am
	 LQaEUAEdqPqzTVF6XhZpqSQ3fu+GG2jmf4agQATVZ04vLSAXP/WQe4G4UIS0vEyEb7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=2mIK64c9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291032;
	bh=TAH9cJOniS8v+YhQu1rkj+SxTN5ldXQAx+poY8WJ6gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alK7x8WkyfC6nK764x7VLmuTRa35Qz2EtH2CzXjvh1XwVJDZENUUlAmeF2KwOQGi5
	 0qHEnnFQrYJ1SvrAJuMD+598cylpwCNM+0Dv0FHk2EoFuC0Ac6TtA4mI28nPz+GIgE
	 OXeyNxCzwOK/Q34PnCjtREy44bT4bWi9IhvABokZKurCDDDn2cAcDa3HIeZpGIjML8
	 8OWb6QenKKC2Wl3SwsQBxCJzsPGILrIABvkSetUL6pTeYtQjSV3/BymecRrRJlvhF7
	 PJAuvWTyvxiQEIodyESKqhmkiTpddFmnbOQAwmHX8mGvLbquWM4X2ZVocL2Kw0Kb6n
	 qLjRkmlzxwTEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FD378100D;
	Thu, 29 Oct 2026 16:23:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2FFE362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9C4D80FC6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XeexUJk5bK3q for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5BE180DD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291011;
 b=rQdDpvoB3Nl8WvF00mxFtAi3HnC0BP3k6e4HOFK2nYQHgqAY1nzM8q/5SXvjla7RjRYc
 MOCLHyyUpFOvhAsTG+GhH5oYzLDlHEVT+ikupom01BV0CiBfPQrxsokOSpDsX0XGoo9mS
 8SlMjmJ0ql7ON8BDwTBj7epXGzCX0ulTsSvSpCc9bp+DhJF2U71JEK1LWU7uXCTvTeq0W
 Bum8CJyWSdpvmQphTSSssAcx+9caWnyK+W8fIG4zS4ScEJ3dWHOljwr7t0E74cadwHiR6
 CeqIZQikGblnn4AK5JGLUSZb8871oYpl3/5X/673CC1WtCvWT/73NyTDlfNkfRuj67w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291011;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=TAH9cJOniS8v+YhQu1rkj+SxTN5ldXQAx+poY8WJ6gM=;
 b=I+ZMOM1615sEMi7AB49jL1CuBWZO7nRqmnNUhOVhKie3g1hf1NrIKy244fxU1hy43KEd
 bynch+t7/uE7RjKvHen/SxNbEdzw/yrYITpAIX5lachmjXqmqEWRXxHov2UbaFxaPb5DD
 Nl30I19Fk2Fvl7b0vETJ9/8cvPF9SD/wXyjlAY8t7y7MtREQfhOPfqTJqKk1J5opJtqnh
 WGNClIPtuh/D0OKGvq8XNwmeazarAuul5sdZTdsPJKl8QC14graq6v37Wbg/FUQIVxeK4
 41XniR+13LOvU57gzRwabHDg19Tn+1Ku2dNhsqH/BKp/cEMVXvu1t0FnAoWkHQ0lOqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=2mIK64c9; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=2mIK64c9
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5BE180DD6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAH9cJOniS8v+YhQu1rkj+SxTN5ldXQAx+poY8WJ6gM=;
 b=2mIK64c99SPnDU0zT3CmQ03GaUMxKuhpQakw9m8Q2jwjCTQQNFMkUypxfkL93QznFnEafN
 o1YBdyDBpuv3HdClodOSpuvv0jhE4Hq99J3eaAYYRUN56AwZmAP4Bc3MU1l+wee+BCdf4y
 EssNUJhsMGAsIPv/34R+GKThWu2oGacIWb5igtYkhKO4SFMMKd05FrWXfs8Pnq/tNCvjY5
 chHGuutzGbd/YmvTTrRC+jWGbl8Oa6dJXKU1VDzEfdknrVSRlwHmOn9mHDPVI23ozm9DBE
 OcsKGeD9ucGiuzrJaFzs9gNLtyq5OrFnIELQNsmWW5jeowFES9k1SNKqbuzbKQ==
Date: Thu, 29 Oct 2026 17:23:16 +0100
Subject: [PATCH 10/10] test: boot: Test the RAUC built-in boot command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-10-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=msSA5O2k3Ou1QXZvbPPGjcqQu4AO8plTzvcwLEEB01w=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0W/Vh1sV1dn8T3Z4n2N+3m9/Z75gRXsk/474iJQvv
 6SMNN93lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATEQykJFhrvLLk0lr3ustSGf1
 Xv78UoG+ae0kvT0zM2/pTXqxrXf9M4b/AdYxCsa7xHO2XM5ONq8tClg6Uyfx2t6IK5Om3Dr//Ck
 fCwA=
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

Set CONFIG_BOOTMETH_RAUC_BOOTCMD on sandbox to run a test variable,
and add a test that boots the RAUC bootflow on mmc10 with it. It checks
that the command sees the slot's partitions and raucargs, that slot B
is booted once slot A has no tries left, and that a failing command
uses up a try.

Booting saves the environment, which sandbox keeps nowhere by default.
Set CONFIG_ENV_FAT_DEVICE_AND_PART to the first partition of mmc10,
which has a FAT filesystem, and select it during the test. No other
test uses the FAT environment.

The test is skipped unless the command is the one it sets up. As with
the partition name test, this needs an #ifdef, since the string option
does not exist without BOOTMETH_RAUC.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/sandbox_defconfig |  2 ++
 test/boot/bootflow.c      | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index b952622b403..a79012b5a21 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -29,6 +29,7 @@ CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_BLS=y
 CONFIG_BOOTMETH_RAUC=y
 CONFIG_BOOTMETH_RAUC_PART_NAMES="boot_a,root_a boot_b,root_b"
+CONFIG_BOOTMETH_RAUC_BOOTCMD="run rauc_test_boot"
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
@@ -167,6 +168,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_REDUNDANT_UPGRADE=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="a:1"
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index e0a3c8a28b1..38a6eb66fcc 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1851,6 +1851,84 @@ static int bootflow_rauc_part_names(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_rauc_part_names, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+/* Scan and boot the RAUC bootflow, which saves the environment first */
+static int bootflow_rauc_boot(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
+	ut_assert_nextline("Saving Environment to FAT... OK");
+
+	return 0;
+}
+
+static int bootflow_rauc_bootcmd_check(struct unit_test_state *uts)
+{
+	/* Start with the default tries, also when running a second time */
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+	ut_assertok(env_set("rauc_test_boot",
+			    "echo rauc boot: ${raucargs} ${distro_bootpart} ${distro_rootpart}"));
+
+	/* The command returns instead of booting, so the boot fails */
+	ut_assertok(bootflow_rauc_boot(uts));
+	ut_assert_skip_to_line("rauc boot: rauc.slot=A 1 2");
+	ut_assert_nextline("Boot failed (err=-14)");
+	ut_assert_console_end();
+	ut_asserteq_str("2", env_get("BOOT_A_LEFT"));
+
+	/* Slot B is booted once slot A has no tries left */
+	ut_assertok(env_set("BOOT_A_LEFT", "0"));
+	ut_assertok(bootflow_rauc_boot(uts));
+	ut_assert_skip_to_line("rauc boot: rauc.slot=B 3 4");
+	ut_assert_nextline("Boot failed (err=-14)");
+	ut_assert_console_end();
+	ut_asserteq_str("2", env_get("BOOT_B_LEFT"));
+
+	/* A failing command uses up a try as well */
+	ut_assertok(env_set("rauc_test_boot", "false"));
+	ut_assertok(bootflow_rauc_boot(uts));
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
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC) ||
+	    !IS_ENABLED(CONFIG_ENV_IS_IN_FAT) ||
+	    !IS_ENABLED(CONFIG_CMD_NVEDIT_SELECT))
+		return -EAGAIN;
+#ifdef CONFIG_BOOTMETH_RAUC_BOOTCMD
+	if (strcmp(CONFIG_BOOTMETH_RAUC_BOOTCMD, "run rauc_test_boot"))
+		return -EAGAIN;
+#endif
+
+	/* Save the environment to the first partition of mmc10 */
+	ut_assertok(run_command("env select FAT", 0));
+	ut_assert_nextline("Select Environment on FAT: OK");
+
+	ret = bootflow_rauc_run(uts, "mmc10", bootflow_rauc_bootcmd_check);
+	run_command("env select nowhere", 0);
+	if (ret)
+		return ret;
+	ut_assert_nextline("Select Environment on nowhere: OK");
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_rauc_bootcmd, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /* Check 'bootflow scan' provides a list of images */
 static int bootstd_images(struct unit_test_state *uts)
 {

-- 
2.56.0

