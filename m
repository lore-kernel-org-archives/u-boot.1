Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB828606A31B
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v6G2krJ/;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rIbkFxL9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 198BF60601;
	Sun, 25 Oct 2026 20:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id asOofwD1JQfo; Sun, 25 Oct 2026 20:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24182605E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792959544;
	b=PaqVEskFfnT6xGjGyet72dTQY9PUrQgKOQRydQqSwvOv1Z7SeXfcgAuF4YVddtXVjEY2
	 eEgTEgHI+odEgw3DByRMB78vXwKEtj9gVt7+q6YWx2xsHPMreIbE6X5ywjWfbBeIF5xtK
	 BXAIaMomIJkIDX+ZXxkpCqjzOjDqczH5i8ZvMPtlwhdf0aiQ13jJJ3B9EJJ/h2D/lVo5D
	 frSnsCktuECpsqk3jXgWtI+NiRNaGi2gwI2KntwkYCiJUrKGIbE4KR/e10z+NKftywVAP
	 BY20xhmrndx+rJk8khD0AOH9FWBhj+VAjxsCtaEV0TGTU5DM6iU7xIwtvmQNglxV4Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792959544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n9ROf1Amubfta6wvZRtCxgwkRT6MRZT0vs2O3RlWbrM=;
	b=MTg2tmLjtFiXQLElkoXbyjMncBjp+j2ToPi1GWfPPf38XfIAOrWvjzF6OXllSeBH+08a
	 U0cbK7RcNghT0U+NDNbe+x9YyhxsitrTVgcCfzO76K7OEXkTHR1Nzt/GEVFgXg7izCwBR
	 4qDva2pVurFDUjelcE4IO+jhgTULECfHC3jzGiWg5eQGoMhDso1iAGyWviE8aeFMF8RBS
	 ilW3mxZzSIXixVoDaeCm90Qu2hcLnIj/xfH2eZEaXJwOf3lpXCXhluQqo3m/yEypgYY92
	 l9pg1lhJEydMtCTBtza8IA0OwmOtVZP7RJAs01QnmKcdky3r07bQNRnHmgi2o85w6gw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rIbkFxL9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792959544;
	bh=n9ROf1Amubfta6wvZRtCxgwkRT6MRZT0vs2O3RlWbrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6G2krJ/lwe5Z1avRuTxMpe1aVEVEbzw7jPffNOi9p/VzoYPlGWKAQ3WZnEEE2Myv
	 zZAHwTjwWS8eeJXT5t14+vPudc8JPhcN7IvhWUVWIxH7Q6oQ8DExXuXzmevJWiplHK
	 9xneiiz3Gbfr3SibZ2trYfbYgENWIZqUthSUkVNP0rqgA/DdSl7SnP8iIA3wJa2L9K
	 9h86bFH17++f2LmuPgYzHHlveXLi/pK1xVGcAiRAopkQi/h3LD1dlVtwECQbXnA9JM
	 Pru1Vjj/rXO2bMY6sVh03DxJ/0yB/SAdHmILsOa7Has2QxHIb50A8odZ/l+8PkcBku
	 ApUoJi5sx7BTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24182605E0;
	Sun, 25 Oct 2026 20:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DEBE5380
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4AC4605E0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWGdkD2A1C8J for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 20:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6373B605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792959539;
 b=iHw4Ldgkhqb75VL3P0NocFxv4BiiCjcM9ofRKa9jYt/qfzyIRf65/dbU2p+cHzfysfMn
 ARBCaXuAh5LGO8bAsYA5vuIG3Qx4VJJnpl1Jb97aL3si4+Yj+Zw/WFJvWiqPhBLhQqxFe
 IuYjHX1AJW4QwMJ9nKEmEqhCypyy2wVoGDD/d28KNaNPjT0WyWjJtqDE5IP9dunNxX0NK
 Na8fNlEweOmN0s3x246eBVJxdApTmo2T82YDGwuru6oMKaq8KUhZiaNW0D9GPMF9d3PCB
 oOdMn0pZ6bd1tny8luWJw8ICr1nCHA8ig9Gk3wVtX+h9dHZOUn85W9831Sdh3HWePUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792959539;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=n9ROf1Amubfta6wvZRtCxgwkRT6MRZT0vs2O3RlWbrM=;
 b=X3rculYrCw0evlTD4BWEJBFs4KnV1U9gJrsS9xoj2FjGH2rd4GTeCrks5OA1EiMTfhyV
 WpO9yHoM+gqrJLqgDT3cn0WWMWRNzx2yTSd6/dxtU90YFfaAkZHOO/DrLc9we8KLWRA2y
 ZLU4F1mtdTuUOV8fZKy+oYzWBebVfPJGOX4VJ8qX03u86UHkm0VbMvGzMWol8LRyuJcIN
 c7QLvCLBXw9ia/BNCWvP6ynykhJDLKA46EN07lkOyQI7qA2Sn9LDY2EZfB916wNT5+HIZ
 EKCdaEnD0EviaUlVYMDNNSL3Xd7HOxx6Mv8drm5XOqWcf+DLjUbSekhO4P4dJZKsWXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=rIbkFxL9; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=rIbkFxL9
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6373B605DF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:18:58 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E609542954; 
 Sun, 25 Oct 2026 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792959537;
 bh=n9ROf1Amubfta6wvZRtCxgwkRT6MRZT0vs2O3RlWbrM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rIbkFxL9dKCnB8o7jdM8PzxGTjp8d/4x77ZFUL/udZL4sS2AbKwmOjDQ3upcj7bXT
 1SAw1A5AmKhJV3IvCUlGR0099R516fUKW78P2NeGzwR9JlOeMtFp8unl3f7I1x703g
 ooNJXPHQj6z+Mf42DFJ5N4zm0nZHtKcjtPUyYTTCD84FpWMGRL/H7zLoc+9AW4W5KA
 U5Tk63sNsTmFrfB2h16KtOjhpJQCQKkLO+21Yq+KrIsg50o/wv+cF2tv1b7cWEO4wf
 5GN2PqaQoa00QnzbtqcYLnEy0Xn8wF7MZDuRYMW9LJrjuoV2Ki4wq1ikXqQuEaUdOx
 FaCXPmjjO5VLCpzhpUOVK/J478r/tSZOzAMDEGIazwFc8hno1QSLLzc1gzPn98ELYE
 qZ1ozmskGB47XpMDH44KRGj/NOg7IGAa8DPyG1xZVs07kyRalVv1ZaVSF8DPRJAv0F
 5yiqYtjj41agA4+z4biedWBAzoTyY3Q4ALSeQlO1ZoLAP3fKW/RU6AaugoaLvzV0Kx
 d5VK4RN418ekJ+NKcS5vzhhcUfVF67SIfdJ5Uc/n5Vo24GVx0Umq54tSan7cOPw+bd
 q5Cc+DDFzPa/2wMDb69H8/RTEwneRJ/g7kHlXGF7e357+2Z96jX2SmCu0hziIKegqg
 kg0sibPjlJnxUE6poCP/1ADI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] efi_loader: implement EFI_DT_FIXUP_PROTOCOL v0.06
Date: Sun, 25 Oct 2026 21:18:43 +0100
Message-ID: <20261025201845.328650-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025201845.328650-1-heinrich.schuchardt@canonical.com>
References: <20261025201845.328650-1-heinrich.schuchardt@canonical.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As result of the discussion with Tianocore EDK II developers in  version
v0.06 of the EFI_DT_FIXUP_PROTOCOL specification support for carving out
device-tree reserved memory ranges was removed. A new GUID was provided
for the reduced protocol.

Implement the new version of the protocol as a wrapper around the old
implementation. This keeps full backwards compatibility for existing
users.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_api.h              |   4 ++
 include/efi_dt_fixup.h         |  21 +++++++
 lib/efi_loader/efi_dt_fixup.c  | 102 +++++++++++++++++++++++++--------
 lib/efi_loader/efi_root_node.c |   2 +
 4 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..646581150b6 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -479,6 +479,10 @@ struct efi_runtime_services {
 	EFI_GUID(0xe617d64c, 0xfe08, 0x46da, 0xf4, 0xdc, \
 		 0xbb, 0xd5, 0x87, 0x0c, 0x73, 0x00)
 
+#define EFI_DT_FIXUP_PROTOCOL2_GUID \
+	EFI_GUID(0x60ed6ba9, 0xdfef, 0x4799, 0xac, 0x7b, \
+		 0x75, 0xe0, 0xf8, 0x33, 0x45, 0x6c)
+
 #define EFI_TCG2_PROTOCOL_GUID \
 	EFI_GUID(0x607f766c, 0x7455, 0x42be, 0x93, \
 		 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
diff --git a/include/efi_dt_fixup.h b/include/efi_dt_fixup.h
index 83382537d16..97865f8e88b 100644
--- a/include/efi_dt_fixup.h
+++ b/include/efi_dt_fixup.h
@@ -23,6 +23,12 @@
 		    EFI_DT_RESERVE_MEMORY | \
 		    EFI_DT_INSTALL_TABLE)
 
+/**
+ * struct efi_dt_fixup_protocol - EFI_DT_FIXUP_PROTOCOL up to v0.05
+ *
+ * @revision:		protocol revision
+ * @fixup:		fixup service function
+ */
 struct efi_dt_fixup_protocol {
 	u64 revision;
 	efi_status_t (EFIAPI *fixup) (struct efi_dt_fixup_protocol *this,
@@ -31,5 +37,20 @@ struct efi_dt_fixup_protocol {
 				      u32 flags);
 };
 
+/**
+ * struct efi_dt_fixup_protocol2 - EFI_DT_FIXUP_PROTOCOL since v0.06
+ *
+ * @revision:		protocol revision
+ * @fixup:		fixup service function
+ */
+struct efi_dt_fixup_protocol2 {
+	u64 revision;
+	efi_status_t (EFIAPI *fixup) (struct efi_dt_fixup_protocol2 *this,
+				      void *dtb,
+				      efi_uintn_t *buffer_size);
+};
+
 extern struct efi_dt_fixup_protocol efi_dt_fixup_prot;
 extern const efi_guid_t efi_guid_dt_fixup_protocol;
+extern struct efi_dt_fixup_protocol2 efi_dt_fixup_prot2;
+extern const efi_guid_t efi_guid_dt_fixup_protocol2;
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 333711b9957..ff42497b4fe 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -14,6 +14,7 @@
 #include <mapmem.h>
 
 const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
+const efi_guid_t efi_guid_dt_fixup_protocol2 = EFI_DT_FIXUP_PROTOCOL2_GUID;
 
 /**
  * efi_reserve_memory() - add reserved memory to memory map
@@ -132,37 +133,30 @@ void efi_carve_out_dt_rsv(void *fdt)
 }
 
 /**
- * efi_dt_fixup() - fix up device tree
+ * efi_dt_fixup_int() - fix up device tree
  *
- * This function implements the Fixup() service of the
- * EFI Device Tree Fixup Protocol.
+ * This function also implements legacy functionality for older
+ * versions of the EFI_DT_FIXUP_PROTOCOL.
  *
- * @this:		instance of the protocol
  * @dtb:		device tree provided by caller
  * @buffer_size:	size of buffer for the device tree including free space
  * @flags:		bit field designating action to be performed
  * Return:		status code
  */
-static efi_status_t __maybe_unused EFIAPI
-efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
-	     efi_uintn_t *buffer_size, u32 flags)
+static efi_status_t
+efi_dt_fixup_int(void *dtb, efi_uintn_t *buffer_size, u32 flags)
 {
 	efi_status_t ret;
 	size_t required_size;
 	size_t total_size;
 	struct bootm_headers img = { 0 };
 
-	EFI_ENTRY("%p, %p, %p, %d", this, dtb, buffer_size, flags);
+	if (!dtb || !buffer_size || !flags || (flags & ~EFI_DT_ALL))
+		return EFI_INVALID_PARAMETER;
+
+	if (fdt_check_header(dtb))
+		return EFI_INVALID_PARAMETER;
 
-	if (this != &efi_dt_fixup_prot || !dtb || !buffer_size ||
-	    !flags || (flags & ~EFI_DT_ALL)) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-	if (fdt_check_header(dtb)) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
 	if (flags & EFI_DT_APPLY_FIXUPS) {
 		/* Check size */
 		required_size = fdt_off_dt_strings(dtb) +
@@ -173,15 +167,13 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 			required_size = total_size;
 		if (required_size > *buffer_size) {
 			*buffer_size = required_size;
-			ret = EFI_BUFFER_TOO_SMALL;
-			goto out;
+			return EFI_BUFFER_TOO_SMALL;
 		}
 
 		fdt_set_totalsize(dtb, *buffer_size);
 		if (image_setup_libfdt(&img, dtb, false)) {
 			log_err("failed to process device tree\n");
-			ret = EFI_INVALID_PARAMETER;
-			goto out;
+			return EFI_INVALID_PARAMETER;
 		}
 	}
 	if (flags & EFI_DT_RESERVE_MEMORY)
@@ -191,11 +183,70 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 		ret = efi_install_configuration_table(&efi_guid_fdt, dtb);
 		if (ret != EFI_SUCCESS) {
 			log_err("failed to install device tree\n");
-			goto out;
+			return ret;
 		}
 	}
 
-	ret = EFI_SUCCESS;
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_dt_fixup() - fix up device tree
+ *
+ * This function implements the Fixup() service of the
+ * EFI Device Tree Fixup Protocol up to revision 0.05.
+ *
+ * @this:		instance of the protocol
+ * @dtb:		device tree provided by caller
+ * @buffer_size:	size of buffer for the device tree including free space
+ * @flags:		bit field designating action to be performed
+ * Return:		status code
+ */
+static efi_status_t __maybe_unused EFIAPI
+efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
+	     efi_uintn_t *buffer_size, u32 flags)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %p, %p, %d", this, dtb, buffer_size, flags);
+
+	if (this != &efi_dt_fixup_prot) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	ret = efi_dt_fixup_int(dtb, buffer_size, flags);
+
+out:
+	return EFI_EXIT(ret);
+}
+
+/**
+ * efi_dt_fixup2() - fix up device tree
+ *
+ * This function implements the Fixup() service of the
+ * EFI Device Tree Fixup Protocol since revision v0.06.
+ *
+ * @this:		instance of the protocol
+ * @dtb:		device tree provided by caller
+ * @buffer_size:	size of buffer for the device tree including free space
+ * Return:		status code
+ */
+static efi_status_t __maybe_unused EFIAPI
+efi_dt_fixup2(struct efi_dt_fixup_protocol2 *this, void *dtb,
+	      efi_uintn_t *buffer_size)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %p, %p", this, dtb, buffer_size);
+
+	if (this != &efi_dt_fixup_prot2) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	ret = efi_dt_fixup_int(dtb, buffer_size, EFI_DT_APPLY_FIXUPS);
+
 out:
 	return EFI_EXIT(ret);
 }
@@ -204,3 +255,8 @@ struct efi_dt_fixup_protocol efi_dt_fixup_prot = {
 	.revision = EFI_DT_FIXUP_PROTOCOL_REVISION,
 	.fixup = efi_dt_fixup
 };
+
+struct efi_dt_fixup_protocol2 efi_dt_fixup_prot2 = {
+	.revision = EFI_DT_FIXUP_PROTOCOL_REVISION,
+	.fixup = efi_dt_fixup2
+};
diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
index e5246f65df2..9f3806655d2 100644
--- a/lib/efi_loader/efi_root_node.c
+++ b/lib/efi_loader/efi_root_node.c
@@ -68,6 +68,8 @@ efi_status_t efi_root_node_register(void)
 		 /* Device-tree fix-up protocol */
 		 &efi_guid_dt_fixup_protocol,
 		 &efi_dt_fixup_prot,
+		 &efi_guid_dt_fixup_protocol2,
+		 &efi_dt_fixup_prot2,
 #endif
 #if IS_ENABLED(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2)
 		 &efi_guid_unicode_collation_protocol2,
-- 
2.53.0

