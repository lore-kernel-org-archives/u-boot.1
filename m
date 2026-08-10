Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B8CC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C9DD40718;
	Mon, 10 Aug 2026 22:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_TO77PQ0J-n; Mon, 10 Aug 2026 22:11:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6ED7406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786399911;
	bh=rAD4+jpcupk1VU+gGtewGi8VH0gZwqSTkGTMoXEXhVQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=iIxtetyJckBcxtdsfFw95yH824KOJAB3p0veMC+O+Rk33hDXyhNEvbKPlS9MAAB6E
	 qxCJKoh6SZg7YXxgXrqgJ6Rr07/2xOOnMsLAP80Ucn8vYh2R+c+fBRrtCP6aRzyfOh
	 V54yWShd9i9l4QiTpCAq0DctQyOgilq/gfGoUtTWEyhdWsu4/DozZbHVHJopABJfkT
	 OdJz663uKfq5JalUya63gdbZo65TNSqMeatVU6qzxpcCuaWfCkVcgUW14QT1dkjsVs
	 Rv/YCR85sZ3dN1cnVkB7iDpMMcrSJS7fdiM07VNe+TIF1K8l8pOEN7NgHZOZdAPeII
	 +UZnF2erggOLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6ED7406FA;
	Mon, 10 Aug 2026 22:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04DC3345
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB73440116
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Vq7Q2zdVK4s for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:10:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 32F164007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32F164007A
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32F164007A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:17 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51c2a818fc4so16125211cf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 15:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399816; x=1787004616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAD4+jpcupk1VU+gGtewGi8VH0gZwqSTkGTMoXEXhVQ=;
 b=icytQ0JO+ol2qD2mxxUIyLpgD3vLeTrHA0S3LbPxEqT8ArS8hKCFRog06+0w6aVp9+
 OpEP4O8EipbPJwa6ErRnJ1h1ZIL85lIuDvafjo3sMFohWeRc83om1re7LsSUrg2iA4AJ
 r0WzKpNOL7XXGLNsWmHNk4YC2SoEQUofzZ8+GmkqDu8OLtKgznZY3UyFp2yMu4+ZSxnY
 NuiU9i/J2dSRRGOH7hVRXk18yTRyBQ55Rb9YQLVTQ0rPcWxD9wPBCbixKETao9+2hIC3
 DoiEBTKuJTqILEdBp6KDapUU/18rhjwe1tCagc3H8tqUZ59KNYf1eNwfrOwyuLrhJfrm
 zobQ==
X-Gm-Message-State: AOJu0Yx/rqjDmdfw+mDPVVwX8wdj7hdO2iWeIAzwW6lUPklnaHnXZZz0
 7nn+9H+iw8j/KJOfiBFZ3/KZ0j6T1s2olaSAoZdko50+OpjGqthau/FuGH1fDgs5y+slnhg+W2W
 kTDvuRD5F6avmfFs=
X-Gm-Gg: AR+sD10rvteAuMsi8QA6oZTWkQ+1ckt3h3EZgx+g+JZs12KnknM6nXAiybyAADV8HCV
 mY2zxSlajD0/lAJjkq/bun1AQ8/xDD+mS/jsCGpfE/YqDqgUgzi7QZ5Q1tyzjQ4b45k+By3eRYA
 gCSoIP79MHtZsTxFXRcaKcxuQ2vpFQuW0mPeNNoBwMcTVNPwQhOnZlCushvteGpIMbIOe1C+bKS
 x0fc87r3sAB51yL+RaaSN+EZiNytuIZzTibRIQm5v+KIBr7QXAoh+GujOD3fLyoynUK9Gt65moM
 r2/sTw+8H4eeyCNxxGpWl5HdgJfbg/wzgcSe+2TtcbGP/wL93xOSfEevYjIC7PmXDzkYWfwPaEI
 WrmKzqagqqn0N7Z9R7DiWJePP0ebrdix3mKT8oflabNikXaBaJCJYDnlbuAWsXcn4u4KdyuGJOR
 uhXg3uYj/VdYbjK+7+s/YYk0X6pNjf/9qOdkViKdlTTmpkdzpiP+oRhtcxl7UxZK95WTVHIBDaQ
 hT207qkQvDzCCRF
X-Received: by 2002:ac8:7dc1:0:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-52d4bf69b45mr47630731cf.19.1786399815735; 
 Mon, 10 Aug 2026 15:10:15 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080c90e87sm441651666b.34.2026.08.10.15.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:10:15 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:09:57 +0100
Subject: [PATCH v3 4/4] spl: fit: Bound external data like U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-b4-fit-ext-data-hardening-v3-4-17184cdb87fd@binarly.io>
References: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
In-Reply-To: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786399803; l=3796;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=mXH+s0jquy7C2PkC/jvf+etICuOTqdpsk+EJZNeVBYM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QODuGjepgMIINW1MvdhZpO71mPokIyjMl+mg5IXy4Sq43uAzyBzAd/2wPkkWbVwYvkXMNQiC4GD
 ShhrsIWA0jg4=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Mon, 10 Aug 2026 22:11:43 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786399816; x=1787004616;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rAD4+jpcupk1VU+gGtewGi8VH0gZwqSTkGTMoXEXhVQ=;
 b=QU+wuUcH1aWV6Uf6TH70EIPgX5O0rGtaElZ+0yu03rd4jNo/mgsggKIPmCPulJrb1L
 lqyuSHDH9ueHCaVyZmnTmKQAYQ0woLFJ+CKldUpBuUAYHH2N7h0EzqGUv4NiPr95zUmS
 aLn66NjuiMKlDfVnpHgUishnILXOq7Lum6Nk+HXQ+jQTTcrKwqgOjNewYsIkKvylilYz
 6pCa0aKQEeiLJQJ+Jq+HImvdzmqcs0I9s0LzpC93LF5vUYmjwGJCFQQl6f4SWeGQxo84
 qJiIfQ15E6x89KJZ3lU1ga/FtHcZaEVbj8uTn2HF1dVID5DQDmrSNp63hWyo1i51ZuxM
 hX1g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=binarly.io header.i=@binarly.io
 header.a=rsa-sha256 header.s=google header.b=QU+wuUcH
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
Reviewed-by: Simon Glass <sjg@chromium.org>

---
Code size impact of this patch alone (buildman -S, gcc 13.3), measured
on arm and aarch64: 387 of the 413 boards that build spl_fit.c. All of
it is in SPL; U-Boot proper is unchanged:

  spl/u-boot-spl: text +24..+64, rodata +57 (all +81..+121)

All of the text growth is in load_simple_fit(); the +57 rodata is
exactly the new printf() string - happy to change it to log_debug() if
that is preferred for SPL.
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
2.55.0

