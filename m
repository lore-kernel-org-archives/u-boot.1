Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B250606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpOLeM58;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=IbAOZw/L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 286F1405F6;
	Sun,  1 Nov 2026 14:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfy4KUatdBKv; Sun,  1 Nov 2026 14:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 562AA40609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793544727;
	b=H8C1wgrlcDcMpd93rL0oAyRKA4PDZxS0f1zS4oqcdVh1bub4WmuB7oMv64SJXThYhXTi
	 MW72hQTB4ecVYYeLakwxXENgoRhe/bmsmcoIQwwLHgA+7TF7ClSdiUNc6Ddle7NcED2L8
	 7Gt6VlosG3dlob5cTmWPTEZ/P3zYIOJhxegzb0udl4glh+CjIVBytngWGSDz+41Njdy+A
	 6QI9qCN1Xiurh2uXSIADXCivTRhTMzjTnewfzqZRQs58GgN8NWHs+5ht0/fDtxxxi9KSo
	 hNAONnQl9yP62rhDrV6EGhvU6+xEbm1HBxPgwopZcT0eRYcoRHJPUBMyNCdwk6MdVkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RXL+uY+GDBXXksSII85+DjDpO1/tMYS7qPpwGkyt+1c=;
	b=nw4K1EQBEmFShAh3wtbxtj4ElvJE52uQOtd6MEL2vJWn/aL1pOQ4W/sJU6cTpc3t4Cbg
	 wdJXHCTDfc6wHAWqHkMhPwPeEfdSHCe/AbrJtXGLZj9EjA8fzF86XIFJTKGaa8UYuNIcM
	 Vdm4x/FKs/KcgO39NBaWL9qpfg+tGNSVab/s2kG0RATEPX/r30VDMAc+2Bc97bjWGxBH+
	 vvkouTVhtVwQYKOr/ZbG6L50ljrp6hlTR07P0EiwuKoDPJS+mDzBiH/3A8mwHsbqkHKD2
	 6OrRJnxqGwns8+jwloISu8Rn2uNlIBSPyEO8Cv6RNkMCd2b6tHNfX1+QnyHf9UsaKWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="IbAOZw/L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793544727;
	bh=RXL+uY+GDBXXksSII85+DjDpO1/tMYS7qPpwGkyt+1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpOLeM58hacH7XQN0BiAh1SES3ma4Smwhqkmz14LorixFAfU6PZ7GXS9I4jGRXSAY
	 YEeOV1rAGeS3AYXmrMh/6epKdPT/UyZm4uDj+r01QgpP7QsKetLLlRRZEteK2x87xL
	 Xk/F7VJZdPmkDedxj87afEzQaMvCA1bEEPZGhp3qAui8rdv6vN14trCRCIfIC1TqKG
	 2eUqLXZxKamW9u61u0aNh2vXEGbY88knj8H7drXAPntcT0psMq4idiH0/mI2W6+PCQ
	 vykGA4S4W2fL3f0zfC7r+j99kyYWW5g8SCxRbMOGmizcnhETRUt/bd708tNq9yQTsO
	 Zk74oD76mCbgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 562AA40609;
	Sun,  1 Nov 2026 14:52:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A25A323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FE87405F6
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipGhY7bhdBTj for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:52:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85AE0405FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793544724;
 b=kZnSqtTnyj+8G+bOee/saZPMzjChD81U2F9LFEUb+JvWULLUFG8LfB/79Okrf4kw7Uz3
 UIo/u6H3weZqWFxk/4cw+Bq6cqz1aCoHCQImnxxxbquKXsUckVzcpEbXruVYzfoaiPN5b
 mPDYN1V+BGdovZpvFNGSFbp3Mw9uCpk9UaX+r0sczljRErxitl+fTqBcA453ETG6bsY1+
 30oixV1Kh8IqdNI/F8TQiTJQi4F68SOHcNVXd7HND8KqHNS9SBB4m5CIVX1l4JC11C+cn
 L0sbpBD4m373uioNf9ObswF8s8Y51e0dBRJUv2uPFA4L9csrGZ70tjn6VzB0wOf68xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793544724;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RXL+uY+GDBXXksSII85+DjDpO1/tMYS7qPpwGkyt+1c=;
 b=OSs5n+AnnZdythJalIlrsZ0/FdcBDKY3l7Ho3DUn1wmLjktt6uSqmwp0tuz54Z+jpv8j
 eETthpzP5MDDKkUlg/fclPnL75Gr83R8B4VkjHIQVtsgx6H99/Rcxo/iNaQ9Hq0Re5vzw
 JHsBwZAWcEOl+iSfuq0hj9JhsL3SAbuy+8efjkz50C/sD7eSE/ndaVYQQ1Wj9boLwYbPO
 FvCx8EVH+9ZvmxOtzw2hrkAsTuLghOMMBEdHcGYtSRwynXZ2xeYg1wOhUwW3nnKvEUWUI
 Vso9ukeIbnRJWDSV/ruEemvckvbyobd70gB3UHFYLGNQqand9G57/E3dYKb8JLttTMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="IbAOZw/L"; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=IbAOZw/L
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85AE0405FF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 18333B00548;
 Sun,  1 Nov 2026 15:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793544723;
 bh=98Hb9+/+qp2rCBC9VnIVpkm5BG/uQZc0HGBo0s2TYJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IbAOZw/LfpDi95NZvYxCNYG5iAkE/H451vGD8oTF+7E11c0aaVFUwG5WtWItxgd1E
 Dqu2MsxQZsnIXwTP5WWetMObmgeyQ7HD9xwEf22kfDFqodQUSlT3FzkM0Kpqef6I9p
 +P7bR1E9X6A5UDoOw3ptlibO20I58SJzZfyqbVaIuAlur3sf4lFs6Z4Q57sbPA7+Ud
 P/HWtwFFrlsLsJAfz9GHAhtrD39fSg74ofrUvdm551vVja1G0+InUT/VA+4SFCMP7z
 4jTT6wfL6Pk5e39Crp+VDTl0yyO9OzZFaMKSUT2WQS26AvScFvHyYMgwKTnvk38gRS
 Xgukh0EvqhjGg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/3] board: nbxv3: do not start the MC for bring-up RCW
Date: Sun,  1 Nov 2026 15:51:17 +0100
Message-ID: <20261101145119.348038-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101145119.348038-1-vjardin@free.fr>
References: <20261101145119.348038-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CARRIER F in the RCW build stamp is the bring-up RCW: it powers every
serses PLL down and zeroes the 3 protocols's serdes.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

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

