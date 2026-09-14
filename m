Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E21EC88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EEB660711;
	Mon, 14 Sep 2026 14:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ym0VrpnEd93; Mon, 14 Sep 2026 14:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3422606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395450;
	b=PSmyX5tm3JGmkb/xaje1DwHaavdVJvmxP/mx6o9aGBOaP3m21iUxaz9rcNhGmQucmr5R
	 0WO2VgrSfc0y/IzX2IRVQkKXfClRCY8NJSr9DaTGrOkin1++RtAQ3X5nBlcDIYyOL7S9A
	 ei8FpfxmxJ7TfJRmei87wXispeTR4G4D/Km2onQF3+jzxGVipSgHP1mI3dpe1LPjXiLnJ
	 J5ToXbkpvon1T1rooM+9ML7h3wAO7lL0vAKSS5W0GWD46BrXIBdFAwulcC7kOkMlliz1v
	 IVZ18OEY37/fURBeWGIyjUo+08aIqYnyfe6r3KKuGPl0XZL0/Q49CeW/h1PB2vDZtYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6QNbuky1YaSfIAVc8oTjwDybkr4oDKLkXWgPnEfcq1c=;
	b=IjFgP2hDndOnzOc5t3hYtLVr8MmaKbmnTxrizzZ/Cx1pPF6Y1GGRZBdu4iRCflkass0x
	 6btD09VzI4rYu0CdsN859P+o/ysRbZ3t8UvTIBD1OmzgftvY3KvI2xk0z8/C4PcHeg4G7
	 88XkXbbgsyhtNq38NJSSuCBpiWTOZsTdXsfu1FkfLWo1lsO5DvSWtbWxPld5z7aOhDlcd
	 vGoM3E/QN4l5u6OWqr97uTWajG+R2s8vrc5brn6DpXPsRpx7KhMGv2wwseU2tWuWPkjwh
	 pSOx/1VMw44k9vHx4jfzwvS5ipeYVmD4KUR41I7h9bxCRPLx+yEmxF7U3vNy1e03Rrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395450;
	bh=6QNbuky1YaSfIAVc8oTjwDybkr4oDKLkXWgPnEfcq1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4qHP5IUuDXakEm5myC3TWHqo8Tpl8V18IkdYwmfGTElOWrIZSqEQAbNWLolkblmt
	 /ok/uZnBkc7Oi6Bvxj63nxzsXZYoHrFcSqGxE5+7EjqZLUrU+Srfu4ZZLSb/gVVz8w
	 BSzKkqc4eT7xsIi9iHpjIt0WqEjhg/Bq4OX1l4jznhCf9N7dZkpOXRfm/FTzjd80iD
	 F8MFWuvawr5n7D5Wc3/gI/miJ0zYYaXiUHcmT/a3usUFkuuxNo5XzNKU3rdl3f+GlI
	 XsIH1HKU+ZSpl68HlR96UFE6MDQqtgvK89RwzKTOVz2xGxN1ZlZPA6puGXvmB1/BWF
	 dIRdwrGp6eQ4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3422606F7;
	Mon, 14 Sep 2026 14:17:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BA3C2D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 411A680DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wEVeLK4T3Nd for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DC91480D89
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384216;
 b=G/B6FRnBglhzYo2w3nr466M2TVn+VZVs2ePcAFIu4jsFCoZ1GA28tQNpYYnh4hNLi1OT
 kFjl4wYxX5ErB71lf6neLnuklOOj5O722Ldid+t4nJU1VBRDf1OKYCH1DZOl4gChaftJD
 E8Ick3beTr0HEotYR9Ij08a7RHQ1r/WXXUY4yPOMB0VJPYzIuXlN8wPbLkvkfohbDvGz4
 AXTwl5sqtYebSXv6ThWXSFpqtYsNgIxTEQjBmt8ji6fx4RtSLAZsEGwhcPqWl47eI59S5
 avU6d0pPDBHzRXRZ1ydkUUrJB9EvblUN+EKajGFm0ZlENTRl9KtUG6TL3GYkhwPaufg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6QNbuky1YaSfIAVc8oTjwDybkr4oDKLkXWgPnEfcq1c=;
 b=NPjOvG88rAEpm2CZOt7HkiJT+u1+J0BevljfXlddyZe7fUXlXkNEuuvBw91BdqdodS+U
 +/EdhsTyewy1OLLiRq9HcdaPyw2vGVzrDQydeEjrUEwvwx6nwYuJT/Oq3JcnglwSc8JVE
 IP5Bv47Srh+bGX8XQX057pgkDhqsNt65eJ5klrepcKWVhGgNpYSx+7zhkeR96oajAegb5
 95VcOK74wJVFBC45WDbHjdtLpQBf82DIhlMqclH4Pllf3Wp/TxZYEM3j6pj7dZ51UJQTr
 C4RATL9JtGbmRvw9i4Q46THhVEGMsqz4XZtuuacXG+ALb2Si3iRoZhNtc4qNZaFOK5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Of8FO4zd; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=Of8FO4zd
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC91480D89
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582331EA6;
 Mon, 14 Sep 2026 04:01:50 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 593C23F86F;
 Mon, 14 Sep 2026 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383714; bh=clDNgRoJChSAmxZNBK6Sp0suUSMdVlCDWoggjvNDKO8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Of8FO4zdYl+DI+1aRA1new1vat0t+rN7izuBmW+xwKHpuAOW4ZWRjmZQytTphsgsh
 WuQDgxye5lqUFq9tLhndobnOXfgGwhHaR21gWxExJjscY1WnN5KA29fJ292aD0ioJ/
 e7alEgzdEAd2525+eGa9BSVbA7KXFXBJjmC/e+os=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 15/22] efi_loader: enable TEE runtime GetNextVariableName()
 over FF-A
Date: Mon, 14 Sep 2026 12:00:59 +0100
Message-Id: <20260914110106.1974894-16-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Add the TEE-backed runtime GetNextVariableName() implementation for the
FF-A/MM variable backend. The runtime path uses EFI runtime-safe memory
helpers and the shared MM communication path so variable enumeration can
continue after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v4:

Ilias:

- Split the runtime GetNextVariableName() support out of the combined
  runtime variable-services patch.

v3:

Ilias:

- Rename TEE/FF-A runtime handlers to private *_int_runtime names

Simon:

- Add EFIAPI to the runtime GetNextVariableName() helper
---
 lib/efi_loader/efi_variable_tee.c | 64 ++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 254d6bf8909..0de9949344e 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1081,6 +1081,68 @@ efi_get_variable_int_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_next_variable_name_int_runtime(efi_uintn_t *variable_name_size,
+				       u16 *variable_name, efi_guid_t *guid)
+{
+	struct smm_variable_getnext *var_getnext;
+	efi_uintn_t payload_size;
+	efi_uintn_t out_name_size;
+	efi_uintn_t in_name_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	if (!variable_name_size || !variable_name || !guid) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	out_name_size = *variable_name_size;
+	in_name_size = u16_strsize(variable_name);
+
+	if (out_name_size < in_name_size) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	if (in_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	/* Trim output buffer size */
+	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
+		out_name_size = max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
+
+	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
+	comm_buf = setup_mm_hdr((void **)&var_getnext, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
+				&ret);
+	if (!comm_buf)
+		return ret;
+
+	/* Fill in contents */
+	efi_memcpy_runtime(&var_getnext->guid, guid, sizeof(*guid));
+	var_getnext->name_size = out_name_size;
+	efi_memcpy_runtime(var_getnext->name, variable_name, in_name_size);
+	efi_memset_runtime((u8 *)var_getnext->name + in_name_size, 0x0,
+			   out_name_size - in_name_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
+		/* Update with reported data size for trimmed case */
+		*variable_name_size = var_getnext->name_size;
+	}
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	efi_memcpy_runtime(guid, &var_getnext->guid, sizeof(*guid));
+	efi_memcpy_runtime(variable_name, var_getnext->name, var_getnext->name_size);
+
+	return ret;
+}
+
 efi_status_t efi_set_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor, u32 attributes,
 				  efi_uintn_t data_size, const void *data,
@@ -1348,7 +1410,7 @@ void efi_variables_boot_exit_notify(void)
 			efi_query_variable_info_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
-			efi_get_next_variable_name_runtime;
+			efi_get_next_variable_name_int_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
-- 
2.34.1

