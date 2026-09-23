Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604C6C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA5A607DD;
	Wed, 23 Sep 2026 11:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CF3Yy9DidcA; Wed, 23 Sep 2026 11:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4D8B3607FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164279;
	b=peUMpuYZjNJTFcattpvQTr16m8eifN7N5/iU3f3oXEzDXd6GuUg356yYUUQbxFGohaJw
	 xkfEhkGqDV2CXShzDuZ06/P1oqQhl2Kn6SbQA8XVwVJS+NhA5ISNfbWG6sBKbpBLBNotd
	 vZvsAfWEByaaojpa5W4xUQNB+Hsz1V5fmma0Fj1dizv/KG3cCBbUKRohyk+cElt4Klfn8
	 B9x8hwYi1QitVHvg3d4E2tiPZHyI9tr8mjYvTrIdYw4UGYT7DTJRkBG5TikZx6KhxTYlR
	 gfbX4vp8jiPdKwfQjHGM7Y1mw9cl+fYRaFPhZ0rGairTFn31BH1hWIx9XdcdbfL7hLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
	b=VcnfS34k+WlpDntXKV3vBBTM8SUbkRJw0TjUjRTEFctNR323wsqKlSkkumm7dA+63RgT
	 anuJg6oe5Q7rZNrjFZ7ZveeHyVUjA1aGcpZAfRtMfJQPKt7Jh8TmFAinM1Hhky9bHBzJ8
	 Kf6zFNYMSrozNKQpCwvbc1MnRkJIImLzhMgP54iy/+A7HHwmPftQG6jm/syVcV4lNggTD
	 CT0j8xSKuIwzuSE3R3lPzLuYoycHE0YNSFOoLc6CAbie5G/3QYOf7DYEkX+qb+CSOXRo3
	 OPtqEKnf8R4qxr5+awu8TLaDWu8N2fs2iO4zohSDjEkZUvfYhauA7BGojSO+bOU5Aww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164279;
	bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rgy+rqNDQbbj+oYJva1bHbwqlfXORS9HBn1RRZ3WaU2FATgCp/N2eGmYPf+r+Tl0r
	 nZnrNmzbdtxdvGflF1n6mUla/S0FQMEMOO6eW/rZErWJf8t/RRjSfEcgibleS8YHR0
	 fI5zEyrv5BAfwTk42bcuY+LeSv79s4GattNM8i5vLKVpJMY9XkI2r2jEMaQ6OZFLGf
	 jo30As+RnjggvXJdvcIu1bTYR/B4KWt54oS9Z/Syj115b1jU8aSu5bysmrWSoa3eJc
	 nFIfFw6+9WlEDO+04S+Owd4zwV4ocXfIJRgavDC/6xXelxnfjM62d9kLNRr6f9tgBW
	 X1Xo/TAYtCArw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D8B3607FC;
	Wed, 23 Sep 2026 11:51:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7C12A29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE245406B2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sd6To_qD6ukE for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF738406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164263;
 b=fHJoVfu2D7RsOQRCyaJS7Ktuea7xLA2iAeOrlLejlNOWIbrKeshrvbIntLsXBlt+XVh+
 v6//N4MTOZrVG4gI/lEHg01cpGmWqMcORzRrK/T6tu2wNFDYXYAMqMbz4OrRHt5LWVWpc
 0lrMRTOve0tXv7yiV1cwmxCJuIsWGDxqsTKbc+2+xNWN6l4l5jiiigf3Wf+tdobK4mvKr
 10X2oCsoHlTvRzvk4jmrCDWr1sJsxlDJ+qg2WSU1hekzd7KHilb91Fq+eM1DGxB0IklWX
 tSteHL/Azn2AXr1UOZS1iS3seU60kKr3FmmwgWCHmcXNY4GLLfM5Fofia875aPl9zeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164263;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
 b=r4CXlOyYUhOv07Qn4+CyPoSminGBeCu0gTOeVuJgqXiJ9Qv5opVCdIUSDff2OwSHiaOp
 u5D251zmMjK1r4ibjxx7LiwChq6In8x7cz5Ecjb3FmJqikGy7mBHT0/pYAiQ8van3h/5J
 Qu0+muEIMDaEQy3DnCvew1MbCtXiiV/PNEYHB/l/A9AObyMYBCvMU58Bc9/dkrQaCt2UB
 B4+X8VObJ9CoN1MLAmoGyOdVEwuOgTAQ44ZNnI2Cj01Z8U3CM9ZTA4Vg/iP5m7dpK9fS1
 21WL+n2itWzPFWvn+uUrwx3kzLcXlPJhuEbDHCUwuxKdHu1BoOiG3sOMpQ92juW3Nxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=dj+bm3qC; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 66 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:03 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=dj+bm3qC
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-1328817-20260923114954f2229cb28c00020763-_ky_w4@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF738406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:03 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20260923114954f2229cb28c00020763
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
 b=dj+bm3qC2yl46vxJbPPpFnUtSRIcIW1/uLCFqt3n3XwFl8skkHB9nfZx+B0Lan+53cjZlD
 Wj2PzFlOwNoQA2KLoSRbVqSz9ujc7vRw26D5EcD8u/gFBxPPP0XxTQUVKKjxyBlDk7mpmSfs
 VbFYCC1FQ3Cx/mQXbrCSjmYADtOJ4apt7FtuidD1WWgFjgCtVJy9DcBBKnNtc7BpGveJTMAE
 LUKX4GnTnpIjcRcdSMWxbPdwe2tW3p5VjmnBEGZDMSetzYfFwX1am0IjE0Cm+5HELciQwxVJ
 KBMz2wptFhY0XdQXzpebEb6Z6JaRtek1h+RJOIW3Bju36fe9mLhRznnA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 5/7] iminfo: also verify signatures
Date: Wed, 23 Sep 2026 13:49:32 +0200
Message-ID: <20260923134933.v10.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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
index 60e47db5fb0..ade8d706d55 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1558,11 +1558,64 @@ int fit_all_image_verify(const void *fit)
 
 		if (!fit_image_verify(fit, noffset))
 			return 0;
-		printf("\n");
+		printf("OK\n");
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
index 07fd995ebed..eb4c7c89d65 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -255,6 +255,9 @@ static int do_iminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 static int image_info(ulong addr)
 {
 	void *hdr = (void *)map_sysmem(addr, 0);
+#if defined(CONFIG_FIT)
+	int ret;
+#endif
 
 	printf("\n## Checking Image at %08lx ...\n", addr);
 
@@ -305,6 +308,13 @@ static int image_info(ulong addr)
 
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
index d991b4c2bc3..96b341a48e6 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1488,6 +1488,14 @@ static inline int fit_config_verify_with_key_blob(const void *fit,
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

