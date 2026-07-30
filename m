Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D6C55164
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F58D40BFC;
	Thu, 30 Jul 2026 15:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dur6BcBSmp43; Thu, 30 Jul 2026 15:31:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F36F40BF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785425486;
	bh=NfaJWo5NB+4tzHvD5bKpJeFqkDSmrPmJLWsw9mtGehw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0ZL8ZNZU4HvQm/+neNMVB0DzQBqployweDapEWhYjcSfsmrw1gR3ptUTbb4wpy7sh
	 ZbVgzKQ1HbmE8Fj6dWcfi7ix6ByuOolSKaIBiKFtJIRQ0tdWEQy/HEQ6DY6p1QEM3V
	 bE7xDgL1wO95oCLKj+raNYqMk0YF6zUQQvKoHlEBLOkvCdsk3mh6gX5haU4+OXdmVu
	 dELI/yIkCiu7Daa3/pd7dvAT8bE9dueCVLfqZq6z/XERg0sinkQTERsIrYiuyWc25K
	 oBxY4zdamKpRfHeG0ddNrWBC0VRGOYPkmn9CGYf3EKMmI5iPSH8NlMyH0fOUomZcrU
	 qiM7+ZqWTzbqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F36F40BF7;
	Thu, 30 Jul 2026 15:31:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B850352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01D78403B0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W94jA7Fuf555 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1A41240089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A41240089
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A41240089
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:17 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-977bbf2eb1dso747467241.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423856; x=1786028656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NfaJWo5NB+4tzHvD5bKpJeFqkDSmrPmJLWsw9mtGehw=;
 b=kY7VVp0QhaX8bKKfPKicM6OESiglFseqVpzqgkIX1RbhKqdP7vwscl5JlB2dBDRcv5
 0CrSWHqSfsAe6SrZEPC6whNy9mdrsoUWwl+cnGiBJvLmzumV7ODCQLIYxXWXIVVHtL1F
 NbtuCes8R+KIuGcrUzOwnEH+UVE4jIXCBEvJWAIFqrarHNJ4rq0DBWK9Pws6bnrkSIwH
 WNv0B+pdGoYYO+U8isp1E7Pa7FpdFu/DZXuiJIYXS4oZDMPaxkr7StIKIYWrLubiXTIA
 1ym9KdGoTsOy8HXfp0t2AekCrjIfSoYwNoF0xbbuYGZr7sJFrzd8PddFuA8kgHRoHQeL
 SksA==
X-Gm-Message-State: AOJu0YxOOT5ZJ8+Z0mDubEMAvSQlbNO+t6f7cg2uzWIc5qcdNDKJsW9h
 LgSyD7ES5DpIoLYTliQH/ONGPFuzp6V0EQfkq2Vu8AjPdN6NCRZ+jBTRbvmzJW/UGgY=
X-Gm-Gg: AR+sD12X0pBtXpps6pSuo5j2K4L2wPPZVrRP0oSP7Kgm+sFg1KpdxPvo7CejYmcoRLh
 kClp3u2NeXHBD4JQI1nGX8pAN237+Vqy45ofKcpnkYJcb2BFatwvVLpLt0/81X2JtchNAP7iU4D
 PpK4Hj9SAdaaz1iVHMbYJU0AT0yranvQWLjYF47PNu47eGttFw+03wP4g0OGkJ2afBolNCWnpHi
 Swlhz6AAQTgBU1Ncx913Mnn0kFPWIumIbqVYT9xQxYOoULq9GWK2OIEGar/84M8nlqSidUZzYJO
 t916cmBQlOI6FKmFV+bWsFFtNpHF8axIraJUID58gg6SXNYvyokYO1xJr49mDwokw1W28lWTKq0
 DJ8OlelAdN79Miotk5tz/JDAfuWG/h+WNjkiynDyet3fq0Fhtk8dPXFpBxJu+X7jbP+RiQ3UP9J
 6JbRrjOR+dmFPM5jWC8h69b5DnZHJf+CgViFQRU4pbef0nbQPSfW8NPK4XYH2OlKH3NPhFzhkiD
 luFUoon2fh14HvW
X-Received: by 2002:a05:6102:3707:b0:739:977f:c1ba with SMTP id
 ada2fe7eead31-7574ddc4f7amr1121358137.2.1785423856491; 
 Thu, 30 Jul 2026 08:04:16 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bbc755sm78846966b.54.2026.07.30.08.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:04:15 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:03:44 +0100
Subject: [PATCH 4/4] spl: fit: Bound external data like U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-fit-ext-data-hardening-v1-4-4a6b91e37b51@binarly.io>
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1785423847; l=3325;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=BlVO2bjzLzvJYgJJaZ7pYTf/jE0qMD/o5n+SXyQPHRk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCl0YF19iyzvG5jQps4BrAz1GOm4he3QYNc7B+gdF28LBQ8Jq2KsNsV+TafOZrxbTtZZLL+6SJ8
 vaUqaMf8SagU=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Thu, 30 Jul 2026 15:31:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1785423856; x=1786028656;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NfaJWo5NB+4tzHvD5bKpJeFqkDSmrPmJLWsw9mtGehw=;
 b=MTFrcPSpQsBbPrFv5HfpNWlpvMiMEG7wvhdXxL30yXBL9D4am5czGb0n7lC6vxumcg
 Aqt64t9wn1vRWb3ElPpG2J5D56luxZEY5Pfee66+RYWzhQ6aBdYQ2N2x+Tv2YXMjI5hW
 MX+Yoc2WUmRjgIqyqWmafdzHp/lalUnX0V/T+Gcsxx0wgXrf38DNSUKBw94H2ojyRZAl
 nnWECgzgXagLLRevGl98FJbW3rtN8DpGU/811wF/aieEqMXXeeS5b301bB3oQuQib8ko
 YskTBDKP4c3yuOfS+fUHhHia1zpSqz5M694ZF0JeumUb1QZgxlD0a1SyIuofG/tVAMgu
 ap1g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=MTFrcPSp
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
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

fit_image_get_data() checks that the external-data region fits in the
addressable range and, for signed FITs, stays below
FIT_SIGNATURE_MAX_SIZE. The SPL loader had no equivalent check, so a
hostile data-offset or data-size could make the read offset wrap past
ULONG_MAX, or the destination range wrap around the end of the address
space.

Add the same check to load_simple_fit(), using the block-aligned read
size and the source pointer the read actually uses.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
 common/spl/spl_fit.c  | 26 ++++++++++++++++++++++++++
 test/image/spl_load.c | 23 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 9b0bee25b8b..ec66707efe7 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -343,6 +343,32 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
 		length = len;
 
+		/*
+		 * For non-signed FIT images, we can check that
+		 * (read_offset + size) does not wrap and that
+		 * (src_ptr + size) does not exceed the addressable range.
+		 * For signed FITs, we can additionally check that
+		 * (offset + len) doesn't exceed the allowed FIT image
+		 * maximum size.
+		 */
+		if (size > ULONG_MAX - read_offset ||
+		    size > UINTPTR_MAX - (uintptr_t)src_ptr
+		/*
+		 * #if (not a runtime if) is required: FIT_SIGNATURE_MAX_SIZE
+		 * depends on FIT_SIGNATURE, so CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
+		 * is undefined when signing is disabled and referencing it
+		 * here would fail to compile.
+		 */
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+		    || offset > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) ||
+		    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
+#endif
+		) {
+			printf("FIT external data is out of bounds (offset=%u, size=%u)\n",
+			       offset, len);
+			return -EINVAL;
+		}
+
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 557362ba113..334ec77b18e 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -483,6 +483,29 @@ static int spl_test_fit_read_offset_overflow(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fit_read_offset_overflow, 0);
 
+/*
+ * A read whose end position (read_offset + size) wraps past the addressable
+ * range must be rejected.
+ */
+static int spl_test_fit_read_end_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	/*
+	 * The aligned external-data offset (0x2000 plus the size of the FIT
+	 * itself) stays below the 0x2fff bytes remaining before ULONG_MAX, so
+	 * read_offset passes the offset-wrap check above, but reading the
+	 * SPL_TEST_DATA_SIZE bytes of data crosses past UINTPTR_MAX.
+	 */
+	spl_test_fit_offset = ULONG_MAX - 0x2fff;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x2000, 1,
+				  spl_test_read_fit_offset, spl_test_fit_offset,
+				  -EINVAL);
+}
+SPL_TEST(spl_test_fit_read_end_overflow, 0);
+
 /*
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier

-- 
2.51.0

