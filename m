Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC50CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1219380A86;
	Wed, 14 Oct 2026 08:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSRdN6JEy6j7; Wed, 14 Oct 2026 08:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5575180AA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967222;
	b=pufdRDP/d6fJ3bV7ra8LdpK4YltpODthbKcZG/ket9t6GIxpOXtEPVEnvzd2VClh0dXs
	 eu8pSV+5PtwWvnR+ZuuC/kIwDDggM/CAkmCyOmc/IOjhMB8tjNf+1StCCtVH0/hJbAo1U
	 FBWuzXm00maZKAnll9DIItUc7rPhY/r/MNQtNY8IpEVEBU5zwc0OUEP0906E8So0dbmMH
	 1Vvn3SPgva8IRPKAbwBTXgW3WObqbiprGLGFOxUFytgchtaXHtgz1fxKPzA1EgNqs/VvV
	 u8OknQalW9f4ygAywF5upp9OYc3rFKi9qe00Fn91/HVwaCRxQFcPFP1TJ7lhRlxKjtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967222;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7a5MwTD872ytIJ7tGi/0WqB8ELQbC9BX3MWJlWrJs3E=;
	b=jpwb+vBw9arGL6SaQMc6EcAGkHQhtaAxE4C6e03+AnjSw9hmaTWVU2PAD3Fo6wOC1ISS
	 xCtp/Xrj++jPFXajTfVlTsZkrH2kZ7LHXBrMExEWlMaqbCRg+Le4djdKKt46wl9yUjRrY
	 bLF4cZVDejmpXgSRTz5lfGJktw02oHkSGkVFdGogcfaMDL14z2/9eY5EBTnAP/NN3ijIy
	 KJ8li7GLDQFtiYM6Koea6tSaB84CWNsNk9dRaa+uC1/3cOJHL1S6PH6T5vENN/4B0AmuI
	 IwdEhYudPEpInI/qU5xcPPV2+UDfEnXfeBju71nvMCdmualtSnPINwsDkKEY9Dlhh9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967222;
	bh=7a5MwTD872ytIJ7tGi/0WqB8ELQbC9BX3MWJlWrJs3E=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UfFzBWvtkM/Hv0ciIKD2PzM/zIrX7tGSWJmLIHyjahUrQLqzqOOlRKU2NXzY++L6+
	 f7hOXOPJJ0efgtOtw4EPdUKLFPJHcfl8p7Ttsxp/cXkvIxn9xYbxR1dRyxZsog8yvm
	 qYY6e8KrqIwOkJv1VoZg/IdZ8EWBWrDbl3EiUmMC+X9IV90mlMA+WnvDSNRjIOX9pp
	 iUu/VkIHzGPOFB9yKqASVt1iqL0njU/9PqfzqxdUjkVlUUr2qUr3jlZeifPb3TqOSU
	 A9SHNtEsJatwNvTkId/qBGArA7j0Vh+tEjwQTEbVeqEF3SNdiRbzgkFVfEbPt9ViFg
	 9Fl/qhK3rlTdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5575180AA2;
	Wed, 14 Oct 2026 08:40:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8B1255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C584240606
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pj0izaLNa-iS for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C21E405E2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967220;
 b=hFDyyTgWcI359/kpoIaldRJYzLKWuMF1rvzgUtM1+SSb/iEdPu/2L7ds6SihOSdpIhhB
 gdCX1Wh51i+d0p846Eu+CQHdIyW6kr6+Ww9auHJORQu2/xD4VIZGVWgt/pb5gl+zxCgEs
 /8RYNZWDRKvl3xQIHT2kqgydH0yjVQLnC25cVQVF7z9NntT/zIjtG+6RPlih4wJUXnvdO
 fZGSW2U0xccGTM0VHqRbPL2EmcZxwk/9pbaJJ7rxM6iQb647//98jJlezTtT1n15IXHci
 j1hNB0/tuuX8FeAifqn9VzoKpAHd6DwyObYPw5jS+JTs59cSag/V+EX410Y3DlpCiKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967220;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=7a5MwTD872ytIJ7tGi/0WqB8ELQbC9BX3MWJlWrJs3E=;
 b=AA+uVMbkFEy7zrbFJfpnKHOTW8h8+jNo+h37UWDMN3hGrElne0O/BMKJ4xZK7KA/BTZJ
 6TV4WoF6XEuvb30V8XHoytBw0N368vWs6ieGUnxXsu9J1PYxB/Bm2BhfisoVB50FImRHp
 L+2EduzRUDDVsKcj3rQ3LF1UdazaWbyt+CqjD3AVa0VG9IZVDl++gTcXVptPZuhvbNhTY
 4eK1EWcuxCRONRGc+Wu4cyENhTYGXEU+XZCZ6JNXDS7nD3CeheFt38qk22pYIhouS9FyK
 2RPNcbDi+cZZ1TF7xG4O06AzpVetPbY4hx6mHv7gDxV5/xAGFdXOYoLTKtUoTouSf6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C21E405E2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:18 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuX1-000000005fQ-19KN;
 Wed, 14 Oct 2026 08:40:15 +0000
Date: Wed, 14 Oct 2026 09:40:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 09/11] boot: fit: share the external-data offset calculation
Message-ID: <d72da3f8f4489f302298fbfcd795cdd452d96df1.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

fit_image_load_storage() repeats the data-position / data-offset /
totalsize-alignment sequence that fit_image_get_data() performs, and
writes the result through an int pointer where the getters expect a u32.
The copy also omits the range check on the sum, so an offset that the
embedded path rejects is accepted here.

Extract fit_image_ext_data_offset() and call it from both. The storage
path gains the range check and both agree on one expression for the
alignment.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit.c | 82 ++++++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6ab6c6c7da9..f02ac58d733 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1056,6 +1056,47 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	return 0;
 }
 
+/**
+ * fit_image_ext_data_offset - locate a sub-image's external data
+ * @fit: pointer to the FIT format image header
+ * @noffset: component image node offset
+ * @offsetp: holds the data offset from the start of the FIT, on success
+ *
+ * returns:
+ *     0, if the sub-image has external data
+ *     -ENOENT, if its data is embedded in the FIT
+ *     -EINVAL, if the recorded offset is out of range
+ */
+static int fit_image_ext_data_offset(const void *fit, int noffset, u32 *offsetp)
+{
+	size_t fdt_total_size_aligned;
+	u32 offset;
+
+	if (!fit_image_get_data_position(fit, noffset, &offset)) {
+		*offsetp = offset;
+
+		return 0;
+	}
+
+	if (fit_image_get_data_offset(fit, noffset, &offset))
+		return -ENOENT;
+
+	/*
+	 * data-offset counts from the end of the FDT, so that is the base for
+	 * every image; the sum has to stay within a u32.
+	 */
+	fdt_total_size_aligned = ALIGN(fdt_totalsize(fit), 4);
+	if (fdt_total_size_aligned > UINT32_MAX - offset) {
+		printf("Invalid external data offset: %u\n", offset);
+
+		return -EINVAL;
+	}
+
+	*offsetp = offset + fdt_total_size_aligned;
+
+	return 0;
+}
+
 /**
  * fit_image_get_data - get data and its size including
  *				 both embedded and external data
@@ -1077,29 +1118,14 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 {
 	bool external_data = false;
 	int ret;
-	size_t fdt_total_size_aligned;
 	u32 offset;
 	u32 len;
 	uintptr_t max_offset;
 
-	if (!fit_image_get_data_position(fit, noffset, &offset)) {
-		external_data = true;
-	} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
-		/*
-		 * For FIT with external data, figure out where
-		 * the external images start. This is the base
-		 * for the data-offset properties in each image.
-		 */
-		fdt_total_size_aligned = ((fdt_totalsize(fit) + 3) & ~3);
-		/* The resulting offset cannot exceed UINT32_MAX */
-		if (fdt_total_size_aligned > UINT32_MAX - offset) {
-			printf("Invalid external data offset: %u\n", offset);
-			return -EINVAL;
-		}
-		offset += fdt_total_size_aligned;
-
-		external_data = true;
-	}
+	ret = fit_image_ext_data_offset(fit, noffset, &offset);
+	if (ret && ret != -ENOENT)
+		return ret;
+	external_data = !ret;
 
 	if (external_data) {
 		debug("External Data\n");
@@ -2185,12 +2211,12 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 				  int noffset, enum fit_load_op load_op,
 				  ulong *datap, ulong *lenp, bool *early)
 {
-	int data_off = 0, data_sz = 0;
-	bool external = false;
+	u32 data_off = 0, data_sz = 0;
 	ulong img_load;
 	u8 img_comp = IH_COMP_NONE;
 	void *mapped;
 	void *dst;
+	int ret;
 
 	if (CONFIG_IS_ENABLED(FIT_VERITY)) {
 		u8 img_type;
@@ -2207,19 +2233,13 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 		}
 	}
 
-	if (!fit_image_get_data_position(fit, noffset, &data_off)) {
-		external = true;
-	} else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
-		external = true;
-		data_off += ALIGN(fdt_totalsize(fit), 4);
-	}
+	ret = fit_image_ext_data_offset(fit, noffset, &data_off);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
 
-	if (!external || fit_image_get_data_size(fit, noffset, &data_sz))
+	if (fit_image_get_data_size(fit, noffset, &data_sz))
 		return 0;
 
-	if (data_off < 0 || data_sz < 0)
-		return -EINVAL;
-
 	fit_image_get_comp(fit, noffset, &img_comp);
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
-- 
2.56.0
