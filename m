Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8379CC88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40D2360790;
	Tue, 15 Sep 2026 12:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1VVchCwBj7CW; Tue, 15 Sep 2026 12:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62B2860779
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476823;
	b=rSR8rFCwFFT/axBFiLL3kKZCWIQ019dQvjTnmt+1/I1kuvSj+NNqDegIowYhsLwuKoGq
	 Y42OhamfnkadU7mRNROgGMckybkQpZc4MbmyCW/9VyQH30U8bBEsUKxN+gAsW0PZRdE5H
	 fQgcZHtG0kutAXFeIBl/MzJYBasr5iscBC2Thni7CS+70x8cLq+TI+sO9rgRl2g6q+1l5
	 2JiMmR5PkPjvLR85hB6j/NKLRguKU3Vs69tk0qZbB0TccFzu6CAwcswbIB6RluO69vjHT
	 vcV8515h1WnysgI/5maAiE+RfJjKUcxkk4ENmo/kHSepDmYyG/lYyt/4FB5dRGSyJQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UCfuJnfroQ5xu26gVF9FCG6xAUZWOzRyRteQmyFanqM=;
	b=krnLQu3HqORNfQEjRaPV40rxHEKidLTR62NDGC2Q4gpUgEl7BadliQHEKJB57r1xn6Bc
	 vhVEUCYIpKY8pLspWVQxzeYFX8l6fWgJzTsptgcKOyfVupK8sWEwTF2prRtKAJihkrvoP
	 lSz5PZRlz6UektQdjEoc9g9qegOXmOHmtGy0b0/6krC/U317NTCOFWYo/DK/ci9ntWQ6z
	 I5B21CVy0enSvdOn+lILTwkinLlLakdp0jkIKaXcaclOJtFfPOTJSgW5r4rbAYvgTxcQt
	 hqSfFID4qbAXYm/KAePw9Hn+RYuiYwEZ00MjyU7ujfaOGApo71FcIRkAUvO8PpJqOCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476823;
	bh=UCfuJnfroQ5xu26gVF9FCG6xAUZWOzRyRteQmyFanqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQqUbWx7vdXxlbo0366gqht1eabB/5NJsiHR7pyU1HG1yF27ffJZi022zs5HuWX5y
	 AaFp4RYBZdFP7sud73B1+f4EnCfNjFgwOJmV1gOHrzHWf+Yuu31M9zPoBSGQkww79M
	 c+05nlP+FA8PY0DfU/tOBmAD2/1wum9ZpU4tmcNNJPKzfe2aEZU0m428HijwLot35q
	 5g7+DxBZAj0h24cYaoZV4y6q0UnyU9Une1OL6LCQ4GWoY4kqNR0UN/XFo6gw7pUBrF
	 pUZWr7p4pGgKruAncGQRcSvyH7TPDEJdljt9liR55wsRO7/0OBhTLZmdCQ6OLRZuAK
	 vGABUq8T4cryA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62B2860779;
	Tue, 15 Sep 2026 12:53:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E4C7224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DC954002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gR5-btEMoKJv for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04EFD4009D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476812;
 b=sxUy68RXsOvp8Mi+/TCoL/82plgm+DbyM4rh2Pa7Y+Ag+DYhZ61ehMl4VdhTM660w0Bl
 Awt1tNaIwJAZrkW4OtHLmg77w7Cg8wxCWvvzmSfwuDqqQCdjfjWSlxCHcX+NspapY2M7U
 2OqlHa3/ceNavCk8YDACnoX6bZd5fgCHw2tsuWXZaDqx5rXW0br69iv23LdG41llNjupP
 po8UpReNc+Aq6jXXCh4bHAqNdG17W1nRkvTnfDEyeMBS1wX2ShGNsM/UVbG3S+MkUA4uQ
 gNwmJM1Lg4ye5zfIiMnD1O9zzbdXWMSIqA1OrKu34huOwhYzLHNAbwVTM9G+2z7Rx3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476812;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=UCfuJnfroQ5xu26gVF9FCG6xAUZWOzRyRteQmyFanqM=;
 b=kP728Af6vIn/ORHv0kcfylOfW6tRhvHodiY1Qu3DkSxHoZCyaJMZubws4oEsaUztnH2z
 V0ClWcDUkDD8at/uYSMIgMvxSv3NFuLrr4cBrD7SLTGnt3LKRBMeaU3Aqaf646FGp278+
 3udo17K9FuBlTk1HWrD+yw8eEhOouzCyl7QvSmUnW+pOMphkuVIgxZy2Mw4DnE/pCL2PR
 0gzYLsonKP93iVJz+00pA1exoaojmqq51HQP7pStauyUQnslw2K71vrDM7FtL3zdeFPEq
 tHaame/87wB76BBFuxCjWGq5STvquFnd6n/Wlz4UdMNV1FA9d2y9Vpsc9DCnLLZa9dg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=eGSZXBuY; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=eGSZXBuY
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04EFD4009D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272BE847F0; Tue, 15 Sep 2026 14:53:29 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2492480117
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="eGSZXBuY"; dkim-atps=neutral
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202609151253260cf32f98ef0002077b for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UCfuJnfroQ5xu26gVF9FCG6xAUZWOzRyRteQmyFanqM=;
 b=eGSZXBuY8VNCdm0N1qPb0ROSHwmaRJH+9Vns2Mv1/f7QTHioh5xlLsosYhF8u+TTNCSZLE
 M144boaUFvFLtHf/j2bQ1q1Pk8Uyyg0ZTkaRkGI+uaIXmEz3fqidCajiB6QQk8UhaOCQ/OB9
 m6z/PkHAqDNf8PVqATnMdFSNzieiKg1IceY366zCe5Eoq9t7MFZy96KnLG0sCED7x3R1H6qR
 8ZdfjYpBDoggpNlcPqJQSF+O+T5As6NQVP14rgZob04LgczcBE/yv/waq/q4FAEhVeztA3m5
 ZEHLjYF3v/5tA+rgrpfawYdrRUnM4WpsdjLPFqgUAyBOphaYgAq5F57g==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH v9 6/8] iminfo: also verify signatures
Date: Tue, 15 Sep 2026 14:52:17 +0200
Message-ID: <20260915145217.v9.6.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

The iminfo command already verifies hashes of images. This change
also verifies signatures of configurations if enabled.
If FIT_REQUIRE_CONFIG_SIGS is enabled, iminfo also fails if
signatures are missing.

While at it print "OK\n" in success case of fit_all_image_verify()
too so iminfo output matches bootm. This will simplify the tests.

Adjusts error output slightly to be on stderr

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v6)

Changes in v6:
- move 'ret' declaration to top of block

Changes in v5:
- rely on inline dummy for fit_all_configurations_verify
- use CONFIG_IS_ENABLED(FIT_SIGNATURE) to guard fit_all_configurations_verify
- print warning if /configurations node is missing
- print "OK\n" in fit_all_image_verify()

Changes in v4:
- fix documentation to use kdoc style

Changes in v3:
- use log_err instead of printf in fit_config_verify_required_keys()
- don't make iminfo fail unless FIT_SIGNATURE_REQUIRED is set
- update fit_all_configurations_verify documentation
- stub fit_all_configurations_verify unless FIT_SIGNATURES

Changes in v2:
- document fit_all_configurations_verify()

 boot/image-fit.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
 cmd/bootm.c      | 10 +++++++++
 include/image.h  |  8 +++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..7b5c51fab73 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1506,12 +1506,65 @@ int fit_all_image_verify(const void *fit)
 
 			if (!fit_image_verify(fit, noffset))
 				return 0;
-			printf("\n");
+			printf("OK\n");
 		}
 	}
 	return 1;
 }
 
+/**
+ * fit_all_configurations_verify() - verify signatures of all configurations
+ * @fit: pointer to the FIT format image header
+ *
+ * fit_all_configurations_verify() iterates over all configurations
+ * in the FIT and checks the signatures. Returns success if all
+ * configurations have valid signatures. See documentation at
+ * fit_config_verify_required_keys() or fit_config_verify_key().
+ *
+ * Return:
+ * * 0, all configurations have valid signatures
+ * * -ENOENT, no configurations found
+ * * < 0, -errno
+ */
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+int fit_all_configurations_verify(const void *fit)
+{
+	int confs_noffset;
+	int noffset;
+	int r = -ENOENT;
+
+	/* Find configurations parent node offset */
+	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (confs_noffset < 0) {
+		log_info("Missing '%s' node: %s\n",
+			 FIT_CONFS_PATH, fdt_strerror(confs_noffset));
+		return r;
+	}
+
+	/* Process all config subnodes, check signature for each */
+	log_info("## Checking configuration signatures ...\n");
+
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
+		int ret;
+
+		log_info("   %s ... ", fit_get_name(fit, noffset, NULL));
+		ret = fit_config_verify(fit, noffset);
+		if (ret) {
+			r = ret;
+			log_err("FAIL\n");
+			continue;
+		}
+		/* valid config found */
+		if (r == -ENOENT)
+			r = 0;
+
+		log_info("OK\n");
+	}
+
+	return r;
+}
+#endif
+
 static int fit_image_uncipher(const void *fit, int image_noffset,
 			      void **data, size_t *size)
 {
diff --git a/cmd/bootm.c b/cmd/bootm.c
index ca7cec91fad..25cc51cbab2 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -279,6 +279,9 @@ static int do_iminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 static int image_info(ulong addr)
 {
 	void *hdr = (void *)map_sysmem(addr, 0);
+#if defined(CONFIG_FIT)
+	int ret;
+#endif
 
 	printf("\n## Checking Image at %08lx ...\n", addr);
 
@@ -329,6 +332,13 @@ static int image_info(ulong addr)
 
 		fit_print_contents(hdr);
 
+		ret = fit_all_configurations_verify(hdr);
+		if (ret != 0 && (ret != -ENOENT ||
+				 CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))) {
+			unmap_sysmem(hdr);
+			return 1;
+		}
+
 		if (!fit_all_image_verify(hdr)) {
 			puts("Bad hash in FIT image!\n");
 			unmap_sysmem(hdr);
diff --git a/include/image.h b/include/image.h
index 34efac6056d..841b6fb77cf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1355,6 +1355,14 @@ static inline int fit_config_verify(const void *fit, int conf_noffset)
 }
 #endif
 int fit_all_image_verify(const void *fit);
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+int fit_all_configurations_verify(const void *fit);
+#else
+static inline int fit_all_configurations_verify(const void *fit)
+{
+	return 0;
+}
+#endif
 int fit_config_decrypt(const void *fit, int conf_noffset);
 int fit_image_check_os(const void *fit, int noffset, uint8_t os);
 int fit_image_check_arch(const void *fit, int noffset, uint8_t arch);
-- 
2.43.0

