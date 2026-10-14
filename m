Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE85CC6B2F
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D6E81112;
	Wed, 14 Oct 2026 20:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9mJoXEQ0qKM; Wed, 14 Oct 2026 20:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7832E810EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008228;
	b=jAald+T3qaSfWrpKUespLj2XYPWTS3H15rvqZ82/0cH5HLZ0AGC/Ve6LlwP/OmYBGykR
	 UJSmDY1BpziicgLfREz3cDftb2bC/vA5sCSaIM+rbOt68cZvUHXJ0BFtdJb1egsKX+4jn
	 FxcwYDEptPAqbKVFlWTAtamIrgGpxB8ZPtOdLkkHbciY6X/ydcgcR3XFqlE+hwmjijIcP
	 HTWeEr2owhggppqVaMpGSNooplKqGUDzpMJ1UOorlZhXCMKpm8El3lmzWR48RfUkJ8qib
	 AAfy2Ptwgd9kffySVeqzW9weHBJyZmJqb1fo7fao5G92gT/BmkfpGeXc9pK6lS8493w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mbx9tuFfHEtrM9BAXVGlYyh05LFvV9aAIQsjDlzn/r4=;
	b=iUeqNuuSmt/xvGesqL0MG9FxnTPjJa6gdJL8KeLiKYbxNNFQi1N3ru/o3WrZfkHn4GYz
	 hZxG5RfCThJP6mmuguh/VzxFTRE3b4nwFcJ8kJTYUyMpbCF1geCN6G+MASyMxzahbdODT
	 W2Nh81gL8FSSlrcmEyEmRqbJu+EpXXKBjaRYo+wVB61xXeyVu6ggCshko2uLjHKMbGPJt
	 xnVe3p8nr5Oh87cOOzlJQ00GyvVfKsPsP8Hg4rOs3+HpC+7mmnuLtnDrGWnvLjbIpBCDZ
	 ZDEOvZ0xRiFMWdxJX46K9ZuHdxtnxmxC2qi30E5uw4LKSEcJr96HwrH7sgan5cdve4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008228;
	bh=Mbx9tuFfHEtrM9BAXVGlYyh05LFvV9aAIQsjDlzn/r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W98GpHNp51UIcSSQh1NNkPwZjmiNnCe5UonGGSdfAe4JyjgfJLeeENCaAHwFdK+oG
	 UKqVt7Xx4v00yBjKOj67cq0YkJOjzdelOxHOQj6x2KC/iczzf1qhMv/ePD9/aXg/Bh
	 eN6H+AnjLWOl0Qo30wiWXlT1zV6zriF5YwVlPN8vT4Teik+jZ23oJHeZxqems0Hmgs
	 AB7RBbAOYrqMYvdxot+4AnnkWxkFv7bXTEcBfg79YzgLa4m1l7Ao/juTVHdtbYdPJl
	 WGzzmyu3hF+twnWlWfL7G2ZEmKN5jQEw72NDF7+AjD7OIk13c8m7VsFPPmTKzxC5eo
	 6GVCD5gcE6Vfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7832E810EC;
	Wed, 14 Oct 2026 20:03:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 208512AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FCE6407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5tszRAcxBa9U for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 418C2407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002216;
 b=XplZVQUGz2Jh3+GFM+z0JCJKvy4GMy+QGCL1WQRDROtqzDXCLTws5DEBjfIjMSJEM4qg
 4yuM2JyZuQwFqv2Nyx19RBh0DU+CLpHhC+uFVYBMkMhlCDYWgMrayEN82dXkM8VKW5G/g
 mSP/WjSHnKdGUkTIbwvMuCNgcbu10ahxDZmjD/1bt6amoVAONFuN1XK1wSwAqTb3tXEIc
 iUyr332HW9kklt/DbgZhnD+RvUr/cHk1YGjbkhutjBGJIMJUsLcLOgGw002bul+olQk+i
 p9FRK73w6Gtwm9f8kVpPACjP+WrKWiUPSPLluwIbk7LVC3XquNqJqzj7u0fJCDk10Aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Mbx9tuFfHEtrM9BAXVGlYyh05LFvV9aAIQsjDlzn/r4=;
 b=auogFhtt1ebzpAFre7k10GPlDuinH7Gwphn3/PLd5dDdrMS8ktl2A9PcV6uWhE7rqo7v
 Y5nXfGtoWdV1EsuXg0PDMrXnrik0cPXny3epnB6HTb9MCBRsyEyj9dN9VHgqvaNuqfjFA
 hGnUGtubXOArCEIp//sRQXOlxNjOJUwxUeT4guEf5Y77uN1sd/XXk+zx0lgNqvWdEfJ6M
 mdOLNHXUzKfkekm7v3xTqS4hGFBDwERdzQRRoPCxXREEgJRLrRS9LrXeGWnKFqxW1TC6G
 YUPhbuSkefwMEpEznrQ0GvLwl4mnm/1o66eQaSjSg1PYB55X5OtjTwSpFWay2ilYfUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=rstz7NK9; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=rstz7NK9
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 418C2407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CF68153B;
 Wed, 14 Oct 2026 11:23:32 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693AD3F871;
 Wed, 14 Oct 2026 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002215; bh=ZkkkCmx4bk6aSYdvoao6UxinKO9gQztfm+arPnDBg4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rstz7NK9U8CAxFxQxRWSSd2zS6HV1leg1HcHId5OczL9+Wb5S/O3wkUQu9utbAre6
 bw9lJAMR2qxQJPJcc2CYCXOXtpWXmj/HCaZtj+jcr+jela+s6DqVWBzIiQNMI6zT3I
 QHzaI2lij1S0NoL+vnf2JQfPazBw96GYpM/VZ4qs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 15/22] efi_loader: enable TEE runtime GetNextVariableName()
 over FF-A
Date: Wed, 14 Oct 2026 19:22:55 +0100
Message-ID: <2c5c223f498895006ddf1b6efc4fab26563cb7fa.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

v6:

Ilias:

- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A GetNextVariableName runtime handler with _ffa_runtime suffix

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
 lib/efi_loader/efi_variable_tee.c | 68 ++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 7e8049e177c..b078ccce20e 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1007,6 +1007,68 @@ efi_get_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_next_variable_name_ffa_runtime(efi_uintn_t *variable_name_size,
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
@@ -1322,15 +1384,17 @@ void efi_variables_boot_exit_notify(void)
 	/* Update runtime service table */
 	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
 		efi_runtime_services.get_variable = efi_get_variable_ffa_runtime;
+		efi_runtime_services.get_next_variable_name =
+				efi_get_next_variable_name_ffa_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
 	} else {
 		efi_runtime_services.get_variable = efi_get_variable_runtime;
+		efi_runtime_services.get_next_variable_name =
+				efi_get_next_variable_name_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_runtime;
 	}
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
-	efi_runtime_services.get_next_variable_name =
-			efi_get_next_variable_name_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.43.0

