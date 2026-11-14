Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F299606A335
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EVGNvIGK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2580640EA6;
	Sat, 14 Nov 2026 00:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbDos5ETwIoO; Sat, 14 Nov 2026 00:10:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62C1C40E9C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615022;
	b=q+0Zi7DzKiwiPkqtY/Sn4u5Ir1mO0rUhBZrokxB1+BkpZcx83vRihcvrv4Zug0c4tTqh
	 qKq/ch8dhWDmiEFRHyRlex2TMqkHnqND6WPp6FTw3oOAOUnau/e0L9+3dfQOZp+68dJP+
	 gWqlKBEPT6IpABYBt9OtOrTpOF7a321ku6QnByqFEtfbj27HKMiMbbInge/Moebsq/iXR
	 zDbR1x/b/lwYKwwZFiqGt+5EG/dfB340kJ6muIyOynErXUQKjsbcUHCj2GetAEgafiwpe
	 5Kv+gO2BtTKf7L5NASuUTLCrdaeaaZcpTzzcbcrnV1STYOm8CUvnJgki9RXROgR3t0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dRtMqJUhpD9Ouq0ya+MPshaH6m+MzVsuej7CSC8IYVU=;
	b=mTigMB2rIplaof/6mmTgbwFLhhRP39rzeacydRAVaJtCh5brMy9vRea6QZKtF3IobSeC
	 MawLNVAQI/+Gyv0h8B9jWzsklpOH2jWeIKDes9eNAKkP0XkFRFoPaQQOe76d6nHXorQnh
	 fcvX/OokmwFxdM+kqHP8+Xi0zjS4NKABZv022IR5uYjjwnQgJB/bs3lSHqxGnp3rKQuTH
	 b9BIYe90ActlOp1uQsXMF8gv2zADja9V45ZmsAbzyCm+lg0SYwquSHEi8G0qG+SS9VNRX
	 gX8zAD0SxhpZbf4Sy6BemDJw//jZj7s7BPGXC31m1oYzV136x5DU7ocaNqMkEqoD9rg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615022;
	bh=dRtMqJUhpD9Ouq0ya+MPshaH6m+MzVsuej7CSC8IYVU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EVGNvIGKFZz70aefaD2mbjFE+ierNNTxaziZinOKdpGm46NNBFmduv97YXj5w2HGw
	 a0Oz1Y9Qmahruj+Yx//m0+y/aU0d0qAg0AkWf95uNmzBCrrsaZcoHIRiQgcKvIbqdL
	 HbTB3lWcLJC6LY5+k5tCxxj+tGbn7l/bX7vmVQzKoENB3oQ8DBs2Cy+QHeiTPBRggF
	 +71x/MlAr46bIUtkJ4kD40rzwDP8QtGd9Er8sa1eVbxEU70wVL4wdviPGDpV2tuSV+
	 3G+qWXEAkuN3YZt3irYLnTTQ/6BSBPw1T8ahl5+fUUE2xpspyke2MRY2NHmI27Yvue
	 EGBS8+yFzXwaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62C1C40E9C;
	Sat, 14 Nov 2026 00:10:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8A192FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE98E812F6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFtMe1ROMKrc for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01C9781AF4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01C9781AF4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:19 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1LQ-000000008Vr-20cq;
 Sat, 14 Nov 2026 00:10:12 +0000
Date: Sat, 14 Nov 2026 00:10:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 3/9] test: boot: bootm: Check ordinary failures
Message-ID: <9ba9ab9a205a56b508fca98c738a4389be0f22a9.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that a failing bootm subcommand returns -ENOSYS with the expected
console message. Force a ramdisk allocation failure and check that it
returns -ENOMEM.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/boot/bootm.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index ed60094f3c1..5f013298f8c 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -7,6 +7,8 @@
 
 #include <bootm.h>
 #include <env.h>
+#include <errno.h>
+#include <malloc.h>
 #include <asm/global_data.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -249,3 +251,54 @@ static int bootm_test_subst_both(struct unit_test_state *uts)
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_both, 0);
+
+/* Test that a failing subcommand returns its error to the caller */
+static int bootm_test_subcmd_fail(struct unit_test_state *uts)
+{
+	struct bootm_info bmi;
+	int old_state;
+	u8 old_os;
+	int ret;
+
+	bootm_init(&bmi);
+	old_state = bmi.images->state;
+	old_os = bmi.images->os.os;
+	bmi.images->os.os = IH_OS_LINUX;
+
+	ret = bootm_run_states(&bmi, BOOTM_STATE_OS_BD_T);
+
+	bmi.images->os.os = old_os;
+	bmi.images->state = old_state;
+
+	ut_asserteq(-ENOSYS, ret);
+	ut_assert_nextline("subcommand failed (err=%d)", -ENOSYS);
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTM_TEST(bootm_test_subcmd_fail, UTF_CONSOLE);
+
+static int bootm_test_ramdisk_nomem(struct unit_test_state *uts)
+{
+	ulong initrd_start, initrd_end;
+	char *old_high, *high;
+	int ret;
+
+	high = env_get("initrd_high");
+	old_high = high ? strdup(high) : NULL;
+	ut_assert(!high || old_high);
+	ut_assertok(env_set_hex("initrd_high", 0));
+
+	ret = boot_ramdisk_high(1, ~0UL, &initrd_start, &initrd_end);
+
+	ut_assertok(env_set("initrd_high", old_high));
+	free(old_high);
+
+	ut_asserteq(-ENOMEM, ret);
+	ut_assert_nextline("ramdisk - allocation error");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+BOOTM_TEST(bootm_test_ramdisk_nomem, UTF_CONSOLE);
-- 
2.56.0
