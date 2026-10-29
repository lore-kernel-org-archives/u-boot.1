Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD8606A325
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cbf+nPlM;
	dkim=temperror header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=j3kAAEFb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19080606C2;
	Thu, 29 Oct 2026 10:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0-t7GaH3Wu8; Thu, 29 Oct 2026 10:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5641F6068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268309;
	b=IEtr7F4Nxt3/i08cyEHTZqPd4IiuzoOKsTE7PVnWwOU+SAsuRjUn6jjLSjx73dpNus3v
	 0oiO1pFcRIspAfJtY4byIgpxeLB4tWRdH093xDtIdV4scvNGkWbYYEfGEwgyvCyqStSk8
	 lCS1mkkR1R1uqAAxNAvLp6iHJJB65uDS4M9eolb7+dHoQWXtxCJpOwzcbvK+2FeBJsZey
	 zofEfXO8qW/JYER+rj6+f3tghZBghII158qRd/eWuadwtlPnpB1fAqLESJlCWslChxpeR
	 XYV7sA6HzbwpolEJIjLCL5D1N/rNNUbB2fH/LBmcMcnRBBhYrmLpQSidW4HTZzInF9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
	b=SBDInzZUg417ON/vwTajLjP4V+daUCh/oooTP56RuXKpEEZ6fGtpQpA5TxdEZk6psZNN
	 5kWE051QHX77xLUzNQpFhllE/C8iOcb8jlledPugqKApZM5Ur1U7wFfllOJHSxw6BMesQ
	 3jNu3iHzLAIww/lx360W5lXEFCmjRzpolKQwExXwjuuoVXOUipo5qI8Z4EClYjT369O6o
	 2ZCXizWwP1wCh0HGpH+4pY9m4C2h4bURleIXZGULXl3uBm9+rhEXwoboV9c3K0ZgBqjZb
	 7itDDQG0FWlSv4ycBLter3asVPdff5nEEO6R3Ywkd9ryv3qubvJqqek9lC4rZbiImZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=j3kAAEFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268309;
	bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cbf+nPlMF/c+228jMJuUbIQI21gJwnMY7amHLCTLyFuANfvKZUSgJ/VooKfR+/rca
	 aXDJwvKvXkv2oJdcdA6G0v7efazLlqP8XI+65Zgw2lhXSU1Qjd0INYsGu4DVGCnUZj
	 wArXdKeLylpPRQh8PDkFin/x4TR3qOjX5lbPJzkkoRfTCfSpigrhj5Jt9EySAHlPuJ
	 Jyf1+kHRmdgN5ilxEZhaZa+l4B2pAml6+JV4ri73taX2W/7KJ13MCkD8+N3B7VXnK0
	 UQ8jgJbwKPltyy7l6cLejteu84mJPGroL6q6ajsl14cc5srq1hHUnWkQIv+VVjeSOY
	 UEIS+DTVQP+zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5641F6068D;
	Thu, 29 Oct 2026 10:05:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFBED380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A19B160677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OvIi9Ci1JPpZ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91C9B606BD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268306;
 b=gamXOh5IzuLrv4IBwtaMzW0fMgsLBCoGApDMhsYLWHC/J82BTs9HDG/4xfhTkzF4zEXD
 rMHeaIFSkDx1vWW9htT4GXt4wcMfz2SqJ2iAcQNcISbqYyxGUq7rLT2qGUm82RTx8Sd00
 AOc0BmxCZY3trkxeuRWPeT8wz4LXc3SijYpM8bjIjSGUl4N5JMDqD28GKTV7Jiif8Bcvj
 ChcPsMA4oVfw7p+n7OXWtzjwisa7JhmBmfSwCpiBEiSxN0xWWA7tIS+HMhf5pqRJIJJT1
 S+TB7906rYL8rxE8cLrXGymyTVJDH4TPBKftw6Ir8MwR7CepHKKjpAJhtYC0R4cjqkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
 b=EizZcdCRd8crWun7SpkGUnpBZUsj8A9SCfxYK/L1imFmHOq18aZ2acdiLFRuaRcgNFPe
 td3wRPxQV3PErbRe+Bwl2pAISdhXjxnylZAkI5SIOHeOzDip9q2aXleN+BLIcg9oVK3gs
 xuqbDWDuRspMhdnxlMASuriDzoHYogNX1BwKQzA3K6BZhZIBqeYMmFkUbauS2Q7tOJhoS
 IbIb4RaOjCqd4BuTynWnMDzp3+WxcrKGPKjaop/NaJXv6VYeb7lt+n1VUiJLHwj7qwDeO
 4lG4xyQjmxctmHNMFzGkE5fLp6UXxMGobzchK7iBUd+ms1mcR8gX5LdpSgnZZSjehOQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=j3kAAEFb; 
 arc=none smtp.remote-ip=185.136.64.225
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100501c5af8c86470002079c-6dcygo@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=j3kAAEFb
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91C9B606BD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:04 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20261029100501c5af8c86470002079c
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XB64Y61ZhHb9bx7a2FRnf2GmDyfJVC9ea8TE/R8f5/I=;
 b=j3kAAEFbz2AwjwMRNoYiWPDZXOSZWMo7I9VDJQASc7llqoBEwVmld5f3gkkKrvQUib1D+j
 LVNjVZu0cSjh2l4fWfUQvi6MF+0MzoqupoVK6maLKq5CBkg5G4bT4g6D8lbT+4itY6mAsN2G
 DKXRqxq0eAEpNrP6JEAShgMObCZD9t5Hewu0qWYCpbynXIn+Anbcd1saAEJ+EpZMXN4+q8x6
 /a4Y7VajF+/OEMV9gtrZqQOutdO/r7RBJZHptMKCo/+qRLNtwfJ6wxPQuFQ9i4IjufBPYtmB
 oveD2mtzGofxJaFfAtFYq9BFf/H4CIXkj1vftSLVXe5C8Qm+6aUCTvaA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Randolph Sapp <rs@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 4/6] iminfo: also verify signatures
Date: Thu, 29 Oct 2026 11:03:55 +0100
Message-ID: <20261029110356.v11.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

