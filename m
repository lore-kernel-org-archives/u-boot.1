Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20B2C5DF82
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 17:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E5D6608FD;
	Tue, 18 Aug 2026 17:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pWG8N2Zh0VS; Tue, 18 Aug 2026 17:53:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A74FD608F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787075604;
	bh=CkX69gYW2sgViJf9MVmtJHWEYlSFwX4Dzw+0hwth6ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPFxOtyz769RfW/ZFH7ReJyFUGaj3VG0hXEhyo5ax17SrlPjVNiZWmFMe+uvwW4D8
	 cbr++GGReKLI+Yz0RbaYAnV3l7VWAvSp+OV9kPcPk+P0o6oU+OGceE3YeS0fZjKb9b
	 BPdXFTCkJlaCYYx2Q6taZ7Zgxwpwzg1dZ5JvW3CfowKmMLofZq06j5QSZdpRSO2yNk
	 uHMR1oAX7BGgsFAxPTl0LlNjywmifuoSqSUkozK6SJPmEp8Z6ANRCL5K1/25MvHy2x
	 ILcMhjhoOIXaQPNnZMTILbe3QrX76ws4M3Q4EMVbvPGJnsMx1XZ/zWRZ+aUR/ytEL3
	 qEcVauuNBRY6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A74FD608F6;
	Tue, 18 Aug 2026 17:53:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 863F92FD
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C50B608F6
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLn6QavyNQ_U for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 17:53:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:204::4c; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B475C608CD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B475C608CD
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=gOFEdVuK
Received: from outbound.mr.icloud.com (mr-2006h-snip6-5.eps.apple.com
 [IPv6:2a01:b747:3000:204::4c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B475C608CD
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:22 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 A48F71800125; Tue, 18 Aug 2026 17:53:20 +0000 (UTC)
X-ICL-RepId: 01a01601-a100-7273-ae6a-36bec5fe96c9
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEkCTV8OXh8EF0YZVQRHHl1WXh8ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAAUkLXABeAUAIVgtcD1wBSRRKHhtWB1ceTRFdAV4echlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787075602; x=1789667602; bh=CkX69gYW2sgViJf9MVmtJHWEYlSFwX4Dzw+0hwth6ng=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gOFEdVuKnKBDlmMeRVj2f3WLvfMOqZW5Qhpi+H/nV9mcGOJlLutIH4DKkp8fMjf8XmVCkgi2P514DzBaikqk0bhSG5Wx4x7Z36kqD2LleM6AAO0Enlt2q+d1G0xKK5NoSoOGYuByl9x8q7RaBcITka+33cOfasB/bHaX1ninqFhOI8p67jiMaBhHZgVc0fqCIwEJEaEXgo0yIo34fl/AzFPkRXyCyoRQMg64N3909nv/SrCRXk59He/SSR9PiSAKh8IW+0ubSWub0dVaLAoBxjQ93dWcbTHjcHbWK4iHGedEdJI7lSu3Ewe6CMfeEuq3xGMs4N4Sbc0+9CDpEbYIRw==
Received: from DESKTOP-GUOEOAE (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 0C3C5180018B; Tue, 18 Aug 2026 17:53:16 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, sjg@chromium.org, trini@konsulko.com,
 igor.opaniuk@gmail.com, alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com,
 Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v1 2/2] boot: android: Add AVB verification support for
 different bootflow.
Date: Wed, 19 Aug 2026 01:53:01 +0800
Message-ID: <20260818175301.818739-2-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818175301.818739-1-valentinliu@icloud.com>
References: <20260818175301.818739-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzMiBTYWx0ZWRfX9M/jL3ZMvZRR
 LtzsAuy4ZgPu92obpsndT3ixe2tHFbQSyXrcgw06DyFNWTbo43S9hs5ApevmWLk9x7j+bt+dbep
 KIcME3K7EqDNAFnkLW3M6MsrvgioAIXJME/Vig9fVJ6w0nmZNlZtMX6JLv3+ScGmZOBhvb7cPlD
 vKLBGpCAg72OTdq3eAVSgFiyHBDxZs46jjSgcpxGOINhmYRO5+FDdnWzmjYAHrRlW9THHV6TzaH
 60VDOdTi+on/5U62JJHWHVos9NRVmpX9pNmbtVAt4Co4YUume8n+fkQ+zPSX4xtuzUeblmgbhUA
 tjHiuzB99mpkS5pJQSAe5cRQRc3+PWhg5YKeeEz5+EgKLO9mdi/EUH3yPYlf8A=
X-Proofpoint-GUID: UF6WLKoMGS5PNmhQHDQaYKNIb6x2pAQJ
X-Proofpoint-ORIG-GUID: UF6WLKoMGS5PNmhQHDQaYKNIb6x2pAQJ
X-Authority-Info-Out: v=2.4 cv=e6ALiKp/ c=1 sm=1 tr=0 ts=6a849c11
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=j9oKZqiKmngdUMCPrd8A:9
X-JNJ: AAAAAAAB9qZ0mX7X5Gs5QhertznvOpTTLSc0pGLMoJzz0S3ksNospzzVM7J135vMs5jmNFpwa0rLQ4531DFwAPVN8fM5+WAFb3h9DfjdfwwCrMQwpbzcj4DsgjAQEOKjQv1t32Hs8GW869FdMLFmFgkJvqjBHnOEkq9MpdQa16mh33O8Rby7HZyMFYy3mLWCc8WOFhlQA3gtviehbq1Pop+3VJnYqhtmNtfipsu1TZnM2PiHGsNuUlExAE8wsXyD5vioqkiQ4sLTD0tpvladI+L8/twOzOs+cnMdkU2SsL8lFOr+FbUuI9TtVL6F9PoBy2QwfIw/IS6x5YAIA+9X6MkCQULVjG5ZutXVqfJPolrT53CBOXpoZosu9vx8+hZ8k2d5URnm6/wxSvz0jV82kQaomLDWFPsOwpRDZb7a797Y0KVh43dnpQD0a+Xk4BzdBf9AfKmGJM1P/utN4bOddh5miDnPWzbD421BWXG65VjFGwBrsGdkcKa+krG8Ahm4z/51qwV3PMDNL3WnqIjZdcn0y65ilVseY/djaoT+Z0IiehrTRhDB44t3XpwoT9tyxYNtODGIOdTbXDVGE6LWUWfVTV2ttgnvburbXsHlZ+kz5X31stz04wWVMf0Bc5Q73uuJmCZkgpHecZ/8SmxmeFpLpTOXBMWWvEPoc1HsowCzVKzdINHtTEj3JxQmcEQviWG8sNxyMS5nH/0A2saAN8Hsya7lQr6nGSSW4H3Fr5pqruW4osWhkx+tJ3l0Q0HOWHUVdTSI3e0al5D71fJwkw3UUuwd90xtYkUwlIHxBRUuyzMjeeDr76FNQeLXe7ko3aKLWFunaj8LdFX05m4MGDrLDBOYspqBuDf9rInTIxb79Fa9Mio4/CsjsVET++DR5/Iz0lrYhA==
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

The different Android versions have their own partition layout,
so the AVB verification process should be dynamic.

In the new verification process, we need to use the header version
fetched from boot partition, so we need to check the boot partition
firstly to avoid the downgrade attacking.

If we didn't check boot firstly, just use it, the attacker can
bypass the AVB verification by flashing a boot image with header
version 3 or earlier.

Signed-off-by: Valentin Liu <valentinliu@icloud.com>
---
 boot/bootmeth_android.c | 43 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 904640d360b..55cd99f3043 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -479,11 +479,12 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
 	return 0;
 }
 
-static int run_avb_verification(struct bootflow *bflow)
+static int run_avb_verification(struct bootflow *bflow, const bool boot_only)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
+	const char *requested_partitions[4];
+	int requested_partitions_num = 0;
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data = NULL;
@@ -493,6 +494,28 @@ static int run_avb_verification(struct bootflow *bflow)
 	bool unlocked = false;
 	int ret;
 
+	/*
+	 * Always verify boot first.
+	 *
+	 * When boot_only is true, only verify the boot partition.
+	 * Otherwise, select additional partitions according to the
+	 * Android boot image header version.
+	 */
+	requested_partitions[requested_partitions_num++] = "boot";
+
+	if (!boot_only) {
+		if (priv->header_version >= 3)
+			requested_partitions[requested_partitions_num++] =
+				"vendor_boot";
+
+		if (priv->header_version >= 4 &&
+		    priv->init_boot_img_size > 0)
+			requested_partitions[requested_partitions_num++] =
+				"init_boot";
+	}
+
+	requested_partitions[requested_partitions_num] = NULL;
+
 	avb_ops = avb_ops_alloc(desc->devnum);
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
@@ -562,9 +585,10 @@ static int run_avb_verification(struct bootflow *bflow)
 	return ret;
 }
 #else
-static int run_avb_verification(struct bootflow *bflow)
+static int run_avb_verification(struct bootflow *bflow, const bool boot_only)
 {
 	int ret;
+	(void)boot_only;
 
 	/* When AVB is unsupported, pass ORANGE state  */
 	ret = bootflow_cmdline_set_arg(bflow,
@@ -617,9 +641,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
-	ret = run_avb_verification(bflow);
+	/*
+	 * Checking the boot partition firstly because the standard AVB
+	 * verification is rely on the header version from boot partition.
+	 */
+	ret = run_avb_verification(bflow, true);
 	if (ret < 0)
-		return log_msg_ret("avb", ret);
+		return log_msg_ret("avb boot", ret);
 
 	/* Read slot once more to decrement counter from BCB */
 	ret = android_read_slot_from_bcb(bflow, true);
@@ -631,6 +659,11 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
+	/* Standard AVB verification */
+	ret = run_avb_verification(bflow, false);
+	if (ret < 0)
+		return log_msg_ret("avb", ret);
+
 	if (priv->header_version >= 4 && priv->init_boot_img_size > 0) {
 		ret = read_slotted_partition(desc, "init_boot", priv->slot,
 					     priv->init_boot_img_size,
-- 
2.53.0

