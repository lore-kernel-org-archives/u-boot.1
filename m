Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93154C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469E760BB3;
	Thu, 17 Sep 2026 17:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdE1_2Zu1jb0; Thu, 17 Sep 2026 17:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF61460B8B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665581;
	b=CkL+Wa0q4PCTAWIzkFmfLtaeFTxr4CSFf9DstJTPtlT6SpUQEctETF4EGUKvwQrKWJhn
	 zlzBmytX+STCIzxqpaRdbKXbB4jxsXZ6RbuWI5xAuwNKdShjCeBr/NnD5fZun6t2kcvua
	 m45Xb7VR7mAI5A6B57PsK3oF5T30LsHuAtU5yOoNH0uXZFhVMsXWgZIlG8BCMaHR2a9VY
	 w5p9dNntT9Pc/6w0/9CmHBL/bXB86iiLbpexAGz+bt6l5l3HdDKUg48xsjmPvnNT3Q7x/
	 m393FqYT9VD6LXV3130Y6FspZp6CoUKWfgGe4M7NXMFB24iyIExSWX/3m62SC5iJ+iA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A4DvBHQk/G+2AcnTPc3j5zki41puqHY4ElZAZWBVXt4=;
	b=NhYBR4NuhU1JzlfrxvW+Ya2bFVPMFryUuOG0LHdrUruC5NEsXnPt4K3lmu1LnH1Szeyd
	 d4iHUT4LS7XjZXNYludro6S2AymPiwd32uIQPNNJY084+QvbFz1fu6a6wd3n/CJqTH52z
	 UmrmGGGxT14/vxOEQc+eRapjwODCN2L7zNFKOYPfJgowgN+tSbmySegU7gYCpCFbM4LcD
	 gt8v6tYdWd7oOBZLucPc9HygcJVzxoWH18ORZY6FVSJqSgiAMIfoYs+wgAj80si3pZqiV
	 y5BnTDTnd10T+PXx34moznrCB/VzDQS0QyXdk3suBolcCOMFQ8mutLhLaoLzRR4FBPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qLHoi9xy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665581;
	bh=A4DvBHQk/G+2AcnTPc3j5zki41puqHY4ElZAZWBVXt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQMLCp7GThpoHevQj9eu98C/0bmDsE7JWz4GuuKovU1ZGg/x8twGcJ7TI9qyQp6ya
	 m5CIj2OKzwQxomiMvlYs+ROcp1+O0CmZ1wSqHNp6ILB6BPESBRAevTXqMXzrRCbYLX
	 5dRaNFAIX8/WJ9GuRHb9qlAnwgkikFxQMqXJj5RuFazF2Hcz58PzsiKnGQlmLwNdf/
	 dNXa/XD5yO5qvZjveAq3YWuf9+7EG0xRKVg0qGidXd47mqNiW8bu3q+K8qwek4Xn2e
	 z8A4g4AMb58WqmHSF6AxyvWjZ1tzYge52z6SHcH/LpmIWk1+z28HaMjCKa4iJ0T/XQ
	 x6pOKvi+avdUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF61460B8B;
	Thu, 17 Sep 2026 17:19:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70B31422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56C8F60B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L63cXRocn1Qv for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 40D8960B58
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665528;
 b=KY6W4vF1DRdbzdekdp7rSWDV8Fz7K2xAD9kwkHPpgKDPtwXMMX4O6ka94jrVsSigqAe8
 KysyMw0IMdgRt61ImZK4JEXlJX+VYYZ8DcrkakR3mNfS/0dWTEbZ9JDLcV6L6XV5E/viO
 /Y7yR82E3K4ar21fEcMfNsyfadMfhGcovNXu965xsYqjn3bT8E5f3iymQqfWQK4L6SG/1
 THu+c3pGkFYr75OJ84xZZnW3jPWc9d/3R/vTyQbgrtKSYk4em8uTxfogEf2C9hXGxBkWK
 NqdoyeqFuJQyBo1qSyDZe5RysFCIRjXMbKdUYt8JpIPr0VNfeHxKdF/voa9oxhr19Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665528;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=A4DvBHQk/G+2AcnTPc3j5zki41puqHY4ElZAZWBVXt4=;
 b=dHZNGII+HFB5lU8QFD4iq2X3lODFwq+vGsHen+uxqO3LYaT6iKTqdYEUlSfnwxp88Q6f
 cy9jWhHhlhYjDgn9vQRUFxrKXxZ/Je59JLfvj11yrTrBacDMyzZEJeoVC8S5pOMrcgcr3
 3xTOcgTc8acz/53zjp6kK24SZV3OsddAM/bN5Q8Za+bKwHd+Z+Q0IOm2VimCp46OWDmG1
 cLnaGjowq0/Wec3FfgE8hh5KvUrsofV0c5ys+bzb8Y1gJfCf0yqe6PDXOte/yQsueIQ8y
 qxAGovKzrp1ilaRUa9WAeF/at7RhHyJlU9/kWzt78lUTd1Bw2jCGya6jQWMExXq6fKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=qLHoi9xy; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=qLHoi9xy
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40D8960B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09538143D;
 Thu, 17 Sep 2026 10:18:44 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744853F7B4;
 Thu, 17 Sep 2026 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665527; bh=PQwX+U+60JKpuEPThmtWpDpIl7Sxike+K9FeHzm31KA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qLHoi9xyCBt1oY35YQfI0vNgCl3kzJGbUm/U7MkjJhG3QqKDZ915ORvNI6eRnucXO
 JDHgbubW79z8e2zsLFuZPwKpvUkipSLl4wmbtsyFa1mRHOusM/15LyN9wWN3Q24V/N
 OjAOUdXHcvVyMjOkXlzyul81RH0W/KEO/fhvq5QA=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 07/24] arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
Date: Thu, 17 Sep 2026 18:17:53 +0100
Message-ID: <20260917171810.4122899-8-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add FFA_MEM_RECLAIM support to the FF-A emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 42 ++++++++++++++++++++++
 drivers/firmware/arm-ffa/sandbox_ffa.c     |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index fca34ad7a2a..49e66963172 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -600,6 +600,45 @@ static int sandbox_ffa_memory_share(struct udevice *emul, ffa_value_t *pargs,
 	return 0;
 }
 
+/**
+ * sandbox_ffa_memory_reclaim() - Emulated FFA_MEM_RECLAIM handler
+ * @emul: The sandbox FF-A emulator device
+ * @pargs: The SMC call input arguments a0-a7
+ * @res:  The SMC return data
+ *
+ * Emulate FFA_MEM_RECLAIM FF-A function.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int sandbox_ffa_memory_reclaim(struct udevice *emul, ffa_value_t *pargs,
+				      ffa_value_t *res)
+{
+	int ret;
+
+	res->a1 = 0;
+
+	if (pargs->a1 != SANDBOX_MEM_HANDLE ||
+	    pargs->a2 != SANDBOX_MEM_HANDLE) {
+		/* FFA_ERROR encoding */
+		res->a0 = FFA_SMC_32(FFA_ERROR);
+		res->a2 = -INVALID_PARAMETERS;
+		ret = ffa_to_std_errmap[INVALID_PARAMETERS];
+		/* x3-x7 MBZ */
+		memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
+
+		return ret;
+	}
+
+	/* FFA_SUCCESS encoding */
+	res->a0 = FFA_SMC_32(FFA_SUCCESS);
+	/* x2-x7 MBZ */
+	memset(&res->a2, 0, 6 * FFA_X_REG_SIZE_IN_BYTE);
+
+	return 0;
+}
+
 /**
  * sandbox_query_ffa_emul_state() - Inspect the FF-A ABIs
  * @queried_func_id:	The FF-A function to be queried
@@ -693,6 +732,9 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 	case FFA_SMC_32(FFA_MEM_SHARE):
 		ret = sandbox_ffa_memory_share(emul, args, res);
 		break;
+	case FFA_SMC_32(FFA_MEM_RECLAIM):
+		ret = sandbox_ffa_memory_reclaim(emul, args, res);
+		break;
 	default:
 		log_err("Undefined FF-A interface (%lx)\n",
 			args->a0);
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index 34d332979dd..74087438395 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -89,6 +89,7 @@ static const struct ffa_bus_ops sandbox_ffa_ops = {
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
 	.memory_share = ffa_memory_share_hdlr,
+	.memory_reclaim = ffa_memory_reclaim_hdlr,
 };
 
 static const struct udevice_id sandbox_ffa_id[] = {
-- 
2.43.0

