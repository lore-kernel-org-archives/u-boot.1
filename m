Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8882606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xsSwc2U/;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=n26DGBsf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0E5460606;
	Sun,  1 Nov 2026 21:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUc9aBSoXKTr; Sun,  1 Nov 2026 21:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8B5F60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568717;
	b=b/+xMCAq35vjX9WQcAS9+CtYWwMXkFJ++JmWtDUqWJDXCHqQ8R+B3tJc4b9Q1d2EAKQm
	 2esv0aNIL+ZXUGMOuXTNIcAHdmtWvYBxXhHeLF5RlliEDf7Y0eNMmMoOeG+kyAPHuDBJ6
	 xPsVKx0fQaX1LGq8g0gBnFsNMnxhAvO6iedaSwt9+KM689UIMhGeDQJPhjGmRLU8GOHbx
	 6qAq91GKQ0V3xmXQoAAWsGwDra8/BCBbhIqTA/X1GCthoPQQ1m3eDxCM2mSeVg2BmqNMh
	 xjzfchTrY6C9cvOk2bsafmtv+8a081BcWZE5cLxIBDc9z2rf7xf9cHSpxjy/JVJ//Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hq41VFMo3ejjUdQzmKFZ/jhGk+3GT1oyDOVOh/RqNkA=;
	b=YSi8IK33dL2JidfvFmry/n7eXMLADMRCPy5cdqUPJmoXCvLxegWIYMtjmY+KTwlvUvoA
	 k3w3v7PgWDcXttKG7Sy9lSMYF54nhGP5IJGBdD9mOi99LmZsElIMbuPrv80ZzssL+24Ok
	 iEtMT9fld1n8nPsjtQZ9a1AX6cCOmWghf2Sb+DOPBf2M3Xaplwc/4bCQlpzmZnihzZKbB
	 1ukJN7zzmyfT3ix+eIkNZb5jX7+RQF/spUnbfM3iFo+8/KOn1J6i654OFtbU3aQslPk4m
	 aAwvbuHUK5NFzvfcpHXQ3RJHiESKLNb13CEcPOy1Cpe7IaseGiEvZVz9T2EksRRKt6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568716;
	bh=hq41VFMo3ejjUdQzmKFZ/jhGk+3GT1oyDOVOh/RqNkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsSwc2U/g9Eb5XJvEAHzRv/Wa9Z27sJq0YB1Iim5vtc8PZ37SdHBxgmZQhVKjJRp6
	 5dMGKMGqZ70EhGZbYtPc6yOiZXGgIfzbIeeokXwliwYygBAjlYLULPUhl5lvetJAUm
	 A7jaCgRNW6XqEB3pcSM8YA4T1dsHJ0+1jQq4l5+wRHs9Q2GWoZeb3qKDYdKuMN9Y2V
	 1PqXM5SEfhKxBWdGPRy5oYNyPSVWOFQv8Qt8EXfnWmn4MmAR1w8wj1DQk5AD6QHq8g
	 m6IcYKERR9XZacGuNvDFl+kwMQ9TQVctM/X9YQm8aCc0E8DgbXcp6RbzBHScU7ck51
	 v4o9rcXRUhTWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8B5F60612;
	Sun,  1 Nov 2026 21:31:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D3A2435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F33E580D9F
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsqRA5_7ki9r for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12C8E80D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568714;
 b=OZLUYF9G12kVmXtmIDg2iXa8RrO8PRRQn9NyNBL9Deo4u+D8UVMNfjhg/Yhw0uhDu2B+
 D2ICdKOTBi1Ihqla2QSUE0xpxDSihZ2lTxOCo8L7W6HemWS1OkBvY93JzKxfdpYuSlRo6
 lnxZDW3mXljeKXnUN8M+7NsgiAsQ+kfGzzZR6NMRMOmUZYquT28o6l8BzQYglSoVkJOsV
 j0bNirqQ8NnyEaHwsmUQ++A5dXcacy1YYOf6k0ghN+hSXoc5yPszJNiKyNq46vQmYsHOt
 BRBt7eBMhaliThu2WMK85kooTjSUk9NfPLe4VGuZwTq8GFBTASSFxs28m075TAtnb4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568714;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hq41VFMo3ejjUdQzmKFZ/jhGk+3GT1oyDOVOh/RqNkA=;
 b=q3eMuX4BnJDO/HabmcnWes5Y84F8o8x8eJI+2+iuP9JQLNbvTQ0/RGyDSrpe0gWOW/Qz
 x9Fwz5SMkZJJb5HmXM4ziwvisj3lh+mJIhiNpglcGzzq5xxcCJ0FfMhdeG+VoZnGFaFGr
 qJGijrU2/kzDll8TFLS5CM+GyLJtYX5STe8S4ONOZPgEVlHUZBujZzX2yYLJGgOLn8awe
 qS/3uhIK6glzhdJdN0N59fbX3HFnq7yT0Tukohd/T4GlMSqGb+XTC9SYzx71hsDbEM7pp
 I4tI1sLVbWzm8FKcxFSFoBIt41PKdwkdG5fmCszZYDJN7y8W9SpPLUtjMk9ecNpa3Qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=n26DGBsf; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=n26DGBsf
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12C8E80D80
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3FF0FB00565;
 Sun,  1 Nov 2026 22:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793568712;
 bh=ylCgD/OJqaXuWmJhBPeIaYUgmdmhYBdjtW7fUi+cWLc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n26DGBsf0qvb+PnwIq4P2iDwVtfR2MDbT2g6k/4kAtAipIPIVuoB397zEpFztayE6
 LNPdjob/FqWWqdC6EUd+pJf8WxE3Z0jTvlvERHP3acp31YkCX58hk0ltVg2hWFTkGd
 xFAKFh6mqws+Mtxn/1Lk1RD/m6lGoA6sUMTH9tXH7mxikDOdgZRQ1hSFrS7ogiFhYi
 A3ep3w0SDqBFXAIWMkToXVySMEiITJA1j6j32BqFJlgR6VSaOglaKVEJ6FoS4Av6/F
 Dd9wnHfMsRKXkLPzHxjMp/Uf/+39lrMFR9bvwRmzRZqJmNgpyt2puPMyTDWj6cfcq1
 ItEcY3VbKDRjg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 2/4] board: nbxv3: do not start the MC for bring-up RCW
Date: Sun,  1 Nov 2026 22:31:08 +0100
Message-ID: <20261101213111.483600-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101213111.483600-1-vjardin@free.fr>
References: <20261101213111.483600-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CARRIER F in the RCW build stamp is the bring-up RCW: it powers every
serses PLL down and zeroes the 3 protocols's serdes.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/carrier.c | 35 +++++++++++++++++++++++++++----
 board/nxp/lx2160a/nbxv3/carrier.h |  1 +
 doc/board/nxp/nbxv3.rst           |  8 ++++++-
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
index 61bab54d5ef..06a54bed0eb 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.c
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -57,12 +57,14 @@
  *   1     NBV30 / NBV31
  *   2     NBV32
  *   3     NBV32 with SerDes 1 at protocol 20 (2x 40GE) in the RCW
- *   4..F  unassigned, treated like 0
+ *   4..E  unassigned, treated like 0
+ *   F     bring-up RCW: no SerDes IO, it names no carrier either
  */
 #define NBXV3_STAMP_SCRATCHRW		12	/* SCRATCHRW13 */
 #define NBXV3_STAMP_CARRIER		GENMASK(31, 28)
 #define NBXV3_STAMP_TAG			GENMASK(27, 24)
 #define NBXV3_STAMP_TAG_NBXV3		0xb
+#define NBXV3_CARRIER_BRINGUP		0xf
 
 /* CARRIER digit of the RCW build stamp, -ENOENT without a stamp */
 static int nbxv3_stamp_carrier(void)
@@ -91,25 +93,50 @@ static const char *nbxv3_carrier_detect(int digit)
 	}
 }
 
+/*
+ * The RCW of bringup powers down every SerDes PLL: there is no WRIOP for
+ * the MC to manage, so do not start the MC.
+ */
+static void nbxv3_carrier_disable_mc(void)
+{
+	if (!env_get("mcinitcmd"))
+		return;
+
+	if (env_set("mcinitcmd", NULL)) {
+		printf("Carrier:       WARNING: cannot clear ${mcinitcmd}, the MC start is expected to hang\n");
+		return;
+	}
+
+	printf("Carrier:       bring-up RCW (no SerDes IO), MC not started\n");
+}
+
 void nbxv3_carrier_env_init(void)
 {
 	const char *carrier = env_get("carrier");
 	const char *origin;
 	int digit;
 
+	/* Whatever ${carrier} says, the SerDes have no IO */
+	digit = nbxv3_stamp_carrier();
+	if (digit == NBXV3_CARRIER_BRINGUP)
+		nbxv3_carrier_disable_mc();
+
 	if (carrier && *carrier) {
 		printf("Carrier:       %s (from env)\n", carrier);
 		return;
 	}
 
-	digit = nbxv3_stamp_carrier();
 	carrier = nbxv3_carrier_detect(digit);
 	if (carrier) {
 		origin = "RCW build stamp";
 	} else {
 		carrier = NBXV3_CARRIER_DEFAULT;
-		origin = digit < 0 ? "default, no RCW build stamp" :
-				     "default, the RCW names no carrier";
+		if (digit < 0)
+			origin = "default, no RCW build stamp";
+		else if (digit == NBXV3_CARRIER_BRINGUP)
+			origin = "default, the bring-up RCW names no carrier";
+		else
+			origin = "default, the RCW names no carrier";
 	}
 
 	if (env_set("carrier", carrier)) {
diff --git a/board/nxp/lx2160a/nbxv3/carrier.h b/board/nxp/lx2160a/nbxv3/carrier.h
index e7eb42265e4..44b2ce1f047 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.h
+++ b/board/nxp/lx2160a/nbxv3/carrier.h
@@ -11,6 +11,7 @@
  * It is idempotent, and it never overrides a value already present
  * in the uboot's environment.
  * It shall run after initr_env and before ${mcinitcmd} is evaluated.
+ * On the bring-up RCW it also clears ${mcinitcmd}, without saving it.
  */
 void nbxv3_carrier_env_init(void);
 
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 3eb87104a52..8259ca85095 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -112,9 +112,15 @@ CARRIER ``${carrier}``
 1       ``nbv30`` (NBV30, NBV31)
 2       ``nbv32``
 3       ``nbv32-40g``: NBV32 with SerDes 1 protocol 20 (2x 40GE)
-4..F    unassigned, treated like 0
+4..E    unassigned, treated like 0
+F       none: bring-up RCW, see below
 ======= ==================================================
 
+The bring-up RCW (CARRIER F) leaves every SerDes without IO, so there is
+no data path for the MC to manage and starting it hangs the boot.
+U-Boot clears ``mcinitcmd`` for that boot, whatever ``${carrier}`` is,
+and does not save it.
+
 Boot flow
 ---------
 
-- 
2.43.0

