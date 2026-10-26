Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEB606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qlr5rjkY;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Bm1kWHWZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0583D80E3E;
	Mon, 26 Oct 2026 14:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6qcymXyRx3O; Mon, 26 Oct 2026 14:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26E5780E4E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793023364;
	b=QeuGYjHKClRZuipEV3Wgw9vQ9I4jVCaMgXTOrxisL04QB+Pre7XhrFgViTEWU1sjaNyc
	 xtM81vqO9MW3ADteT29lZ2dLf3F+MBwqvkef+ZF3eTngwdWgWfX8Tgnmd05qeKKOxjtgu
	 PaAo1CzCnc7iu3mNELnUeNm26OZwg8I2cZ20r/NheomMbDFHj6cAzMP44etIyVl99dcY1
	 6935GpvLSwlBmaYMXGXRqUAtWBf273W9K4aDZos784fJzr4AKbW3u/DZXeXKCoi7TQ/Wy
	 p9inSFsjFdElsUbnAFi8yc9FDUlsQ8b32ia5cpnIkHP/kLTiUttgHjsRZULOm3Smpeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793023364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zlx+eewQx7BAKzh4omaOX/NHBHlV0t+IKR9a4tOMSio=;
	b=FXHCTLWE7dTIn3fHyvVs8sw53Qp54A9DgI4UL6Jj2zat3sfQzDBvGUoypqfgffmoANCX
	 cAAQQByqk6lrNkNXKG95mIpvt1rhktgYXWVOqtGo39YlETmzBFcEQy7GVeFTuj6SiUMi8
	 2yex6MxeYL35T8l0ddk77KbihIM0HL60ZIRbglZJFv5GK0/Y0+Zu0vGzHJ8kdspJpaDFT
	 b6enwkpqp+KBbx1NOwJPDwJJl0oJQ1tmHKXVRm4scy+kQuCER33wGLwgoTVX/QTAlGXSB
	 LYcBX9rprEzKKfKZeAxBytQz9wRbPT+jaJfCafgHkOI8W9oL9zpDb0atA18YRDD/Zxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793023364;
	bh=zlx+eewQx7BAKzh4omaOX/NHBHlV0t+IKR9a4tOMSio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qlr5rjkYPvPTxXPgGDU6Y6LPZyEqVGfFisv4Cq0lqtsFRWZEvhpX64Up1kY8kkz+s
	 Tx8r7Ma6vc3dGfljRjP4Hhtz6FwwHChf7T3xExUd3b7EPbCHnKK9ay28YzXDkeqKe3
	 UWds31DPCnOiIUvJZ8uerHuylgbvvBEPa+rvGk3eWq3P+L8sSWX3KiARSwsb8sApSy
	 AmIRD3fJx+HXjGdslBarcsaizywzzW+MB9iCLO9hSHV2xUjp9ClseQxKxe66T5FZoS
	 xKGVjM7qxw/ksZQLkRgbqlgRN7GFNfi0je3OREXqNAGl9ZLV/MhdZxXfj/bi4L/pY5
	 U8Yzu/Yjb8Qdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26E5780E4E;
	Mon, 26 Oct 2026 14:02:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E69CA4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D826660635
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIZieNZwsukI for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5168860670
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793023362;
 b=Oaa5GU6SE6a8ZxW4IUPKS1kvzyVp6wdIGYb+Nq4T6xgZF+mveyrmZSHQb3y9eTM+tsMG
 TGpV1EBRwT2/XwIr1FXicV/sFmBsAdJzAiL0Ihq3c7TV7Igw4RU6nsn5ieKVrjUSGZR0M
 xeUjNIBpc7NLs6jIBrTmgNg8z3y5MfamBydDhAW02sHF0hnLxUgJvB4LXor2urz9uABKf
 PSsfnbDEbWvau/b3zDGX6ADo2WbeZTdFgBIxNt0m4APNcwbhrYNqEqTWWGYTVPVk/LgkI
 CPhlbrpLddZhA1aDzFixCs9Vzmp5Mr5G22qgHKc/qEhd+LOj6NOtqF8zQC3V+AAaXyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793023362;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=zlx+eewQx7BAKzh4omaOX/NHBHlV0t+IKR9a4tOMSio=;
 b=LUAHgx37DHHm4zKptU0C+Dhvv1Pwn9eLYhLbZvWiOK7wyoBLPPcMiDJWiKIvcy/5M+Y/
 Wpl5eDbp82rCOVd7i6p/WMFH9yTSM/TaDSP8MpVJj1d6Uu3VFDQXueDAb5Ca0HvjkV/Wt
 snxx7NZiZs1GO54DwO96MZ7XGFGSu5jOjKqgxWih1pPGrb3P8Zmt1eL7nfmLzaS9I8h5I
 rSi4/sSg+IphI90ftVDJcwWxSj0xlKWlQ7SFaC7ZpXwK/kIf/VN4GUAp8goPQkj46g3Og
 SgXFE5McpKkPVah9BCVeosoLy4NK61k+C9cvzZuTKh36EBDuTdvoGIE/z4+0EHnBQjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Bm1kWHWZ; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Bm1kWHWZ
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5168860670
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zl
 x+eewQx7BAKzh4omaOX/NHBHlV0t+IKR9a4tOMSio=; b=Bm1kWHWZNFLXEyqO77
 ihTfv9a6r9CQeDhaAWGfCI0T8ox7iCB0k6V4aK17PpN7Dv18gBqm4WUzT5T455th
 AEI2wLncJAGKbV3BUVJcD2829dqu86zd9L6QS3KYvrM4qohtGtKInF2dbw5yIfRz
 5vfGni5dlLIvTfeYdEhk2Zdos=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3N95qXd9qrufGCw--.5946S4; 
 Mon, 26 Oct 2026 22:02:20 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] bootstd: Export the script bootflow execution handler
Date: Mon, 26 Oct 2026 22:02:16 +0800
Message-ID: <597b6a3fca1bfa60e227b9a4f4c5ff555226b469.1793020986.git.hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N95qXd9qrufGCw--.5946S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1Dur1DGrW8tF15CrykXwb_yoW8ZF4Dpa
 nrAa4fJrWkGF13W343Cw4rW34akr1kK3sxtFy8Xw13tr17tF4kJF1ak34Fyr15XF95Kry3
 uFnIvF9rJrn09rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbKsUUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8QwF12rfXWxeUwAA3m
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make script_boot() available as bootmeth_script_boot() so another
bootmeth can reuse the device environment setup and script execution
without duplicating the filesystem script bootmeth's handler.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
Changes in v3:
- Split the shared script execution-handler export into its own patch.

 boot/bootmeth_script.c |  4 ++--
 include/bootmeth.h     | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index cd50977cc40..9e95cc51e58 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -188,7 +188,7 @@ static int script_set_bootflow(struct udevice *dev, struct bootflow *bflow,
 	return 0;
 }
 
-static int script_boot(struct udevice *dev, struct bootflow *bflow)
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc;
 	ulong addr;
@@ -258,7 +258,7 @@ static struct bootmeth_ops script_bootmeth_ops = {
 	.read_bootflow	= script_read_bootflow,
 	.set_bootflow	= script_set_bootflow,
 	.read_file	= bootmeth_common_read_file,
-	.boot		= script_boot,
+	.boot		= bootmeth_script_boot,
 };
 
 static const struct udevice_id script_bootmeth_ids[] = {
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 2a492dfd73a..2d855632a50 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -425,4 +425,16 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
  */
 int bootmeth_get_bootflow(struct udevice *dev, struct bootflow *bflow);
 
+/**
+ * bootmeth_script_boot() - Execute a script bootflow
+ *
+ * Set the device and partition environment variables and execute the script
+ * stored in the bootflow buffer.
+ *
+ * @dev: Bootmeth device
+ * @bflow: Bootflow containing the script image
+ * @return 0 on success, or a error code
+ */
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow);
+
 #endif
-- 
2.43.0

