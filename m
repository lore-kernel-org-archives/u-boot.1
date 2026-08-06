Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F09C5AC80
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 689156087C;
	Fri,  7 Aug 2026 01:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrMdBLMNj4iW; Fri,  7 Aug 2026 01:50:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35CE7608B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067442;
	bh=B4MhwD0ko8Ib1z3DrlMcexQu6FS9yzIXb+b8LM+KY0I=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NIsxkEoESjFRvJwhmA+JdXkbYiBq1ViW0UJhrQZiwV19ar8s3DupWHHOB1chuPEuR
	 dJp/eiNUZmN3nmBNko/D3YIpuz8NY5hB9CP6w5BU4/ZbGNlCH7F9sHoi1q2HCqsCyI
	 9PSXlKmnmrNVldjxSmym1XwzBx4k6dIsKY5mqyqyAjjPABUGNXx/b4jA7lYbXP4QTx
	 DrUCoN+GtoXQC1KJnWw/dnSJR2Xkpi9VrtOE1LHD5lVmzL2Wdsk1CdQvJ1wAKkFTA2
	 DCpySWQyds2cSQr0xxBq9Co92eIPZq6n5kfFUPRGEl1X1udqNW6ZvLJcX3FRVz+pSb
	 NYD5fSw23Oxxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35CE7608B4;
	Fri,  7 Aug 2026 01:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C591D23F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC9EF4022F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsKbAXF3eFRW for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:29:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 947DB400BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 947DB400BC
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 947DB400BC
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:50 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51c08df8513so17353291cf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051789; x=1786656589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4MhwD0ko8Ib1z3DrlMcexQu6FS9yzIXb+b8LM+KY0I=;
 b=P4OlTLRqEol9nlSMrOb86OcA8NJVzlVeYAkRvkaGucLbuU6Em7QnPpxUGacw5j7y7f
 GCoP0J4B2v+tWZ8cO1BN+8zp0bloL4LMa9vWqFIg5whFHcF1iDn3e/+BzXLf4+v/X0nG
 0NrRdqjDm5Eh2Npt1L585B+5ksayQrCKVtk1J+VPYuldfUkClnr8NRkgGJaDn8RPLw0O
 y3+PgllpQ+Rpl2khqzDXd8gdB8t9pFawA4BgoVBIgDsqvmJz5BzlhyAS2yAAsr3qPzZ+
 zdRHGc8hqaeHO+Wb4T498w9M32luIVFcEAiH8SkeFvzyXTHG2qrFZ6KiViMrnhu/HCbz
 sWrg==
X-Gm-Message-State: AOJu0YzysgiQI1gbDIpvDr9XaWy3XouvLEBE4/BxuC6cxGmRE62No8P1
 IRkU3/P5sosid5peIRaq0eZMNN3SFARA1c6S69RMVAoKun4g1me2DRSIgqN4c7BRQDE=
X-Gm-Gg: AR+sD10XO+x+gVWsRAbpjPUfHw3tG+Z+pYO5SJ5bwQAERhQ8F7fKb62yieV2ffQDQvr
 4BfJj7v39oTKB0PVBNhkXINo/hiplUq0+LdOAvx5Vhh3U2okdYsxM9V9zTbRPEC1sJpl+YkmfX5
 jJs2pq5veOpRl7ae/0haojpAOKGW2bIphC81hoRRYcdfsY/MLLDCM3vvOQlva6kynnN2Nvb9jSW
 vwi0CRifmJlhjVEcwNf8/+y2vF+POxVMGaw/BnmwpbiwoKNVZExGUErMcjc87ti6Gp3ANQ5FpFE
 1OJafg5772MoNg73kfkQYiQ/QpzgZe7eu7FjakuUvxD4XQEGWd7XrbGXgcZvcDVYhNrTltiRrYN
 47pvFTdXBbVwqcnCNRHiVjitY02ATSA4QVX3+OqS6azuueVxxQs9jpMti799k53xDU5AJ7Rqu9S
 OQnUNGcSA0vdPqWAKAS0AquCpCVEZc1M6ym2OibVJ4OQXdYyGIP/nqo5F6DX6rM4VOqpIh7TuPt
 hh+Gr6ZmlJjNSqE
X-Received: by 2002:a05:622a:315:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-52ce5f62ea4mr186001571cf.12.1786051789069; 
 Thu, 06 Aug 2026 14:29:49 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c207b4fffcdsm2071466b.46.2026.08.06.14.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:29:48 -0700 (PDT)
Date: Thu, 06 Aug 2026 22:29:22 +0100
Subject: [PATCH v2 4/4] spl: fit: Bound external data like U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-fit-ext-data-hardening-v2-4-b181cac15c29@binarly.io>
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786051774; l=3751;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=b8nEpCiF5PLYQ+RxNYXPnDv/wtSlFzK4PbnHEDtjuXc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJLfpRRBSpf7K2Q8i1eQD+EccJLZhfnCRqeqbpY+9DmkjYa4kgNAoKI5sZ74gqYJ9Y5DHuAt8Ct
 cPsau82AYWw4=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786051789; x=1786656589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4MhwD0ko8Ib1z3DrlMcexQu6FS9yzIXb+b8LM+KY0I=;
 b=R+qOBoSlHDw/Ov+/ioZvnREiNQ4ENgdg4hzH7pwep0b8QVzj26ufzpLdEyPoFcVPqA
 TWrhziMsOqJKeCWAT6ETtYJRgqzOnju3Dz18uzkMItsuSKmNyFP32zTsmCiEAlyn5/7q
 q1V0gXV3Y5cMyfRs6y5pOJ7yWzSMUD1mNXcVxGN4Ng/5qjY3HnUIqIWGi/hpbKEzkJYv
 6MmkvgLdowB5SqCXmTwRtPNV6BgUu7I/7C3w0ddCw4qolC4tyuOEHBYDw34JfSXHkyYD
 tQJxDy/BxwZsWR2NuWJEfT/VkBSj6hjxWyCZcEOKkIjBGMUMS3fQqR97k7eOurjhCpKZ
 ABCA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=R+qOBoSl
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

