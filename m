Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD65CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 974A081011;
	Mon, 19 Oct 2026 13:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCbLRSNoAFQf; Mon, 19 Oct 2026 13:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 97D0D80F8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416247;
	b=Oc8fMiIWoAh0ZxmVadGlo+DLZnzJP8S+CLOj7jXNPWSrHZPuglFClSS6/Nc0jYmDPnHh
	 9Rj53cl7Emis8ZWfjExAoJ9lDcyQazWp88JCBvzWTgnReXeNyM+kDSAHQO3yIyCT5zpRX
	 1gUnwwebwuCsV5pLX+iJiYim6M71sAtd4PJW1CfT2tQ/uhiJEjMWVWIT/Cw49WtU2f4ia
	 JT9/YIxsAtBoo7oN7kBDwuQ8nvIV0X8xRuyFVmH8NLbXSJC6dbqGknPkaCjzhu0c5E2M3
	 MerQaF2tyQy6DcTmP1bT8/iDMy2Sbts2Hwnrl+UrP49IUpLdqpFjJrPR4nMyiSqayuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=laxwd6pnE/TX8UoOcx47eAQ+V75v2bKKopZuqv4pMTk=;
	b=aKj1SZGA24i5exTY12Zdj86r5SAq0S7b5W6ByCGNL1ETpYvArxb80UGEHzv/t2lUwbFW
	 l2rhUfvl7hvwGms88DRmq7TLP3hO3fzXgMqhdT9UEg+jWc9se19bCxn/oSBQLKB4OkVQj
	 39XHaRG+Mny5E8YQYap7jE3FrjJqNTj4y3f7QH6gdLdVfzl2UoyOGHMTLpYmiithipA7E
	 sheQXXWXwnF2JuAF3sn/SSgbebO9gOlOfrAHil6y/i1lnj9o5jJoUkZrvCfCoAUwJk4NK
	 AWeoEDBfHsJ69HbxkCYES4mpBee4accvtvMmjIT8/Ixob6zUKsaoCpWDVEPnZ8a353Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416247;
	bh=laxwd6pnE/TX8UoOcx47eAQ+V75v2bKKopZuqv4pMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVNTPVGyQDSSWs2EAy3FJQedK+9PmAq3ztYAlrGtnobbDIKjfu7EKWMLw3upTc2dr
	 Doqj+rRqUuPh58GoEIz75xBKwOBvKeUKiTdPmQ3QxHPKAnJ4w747dEhqGYuAjqGLVP
	 3ThjJU6gpcuI+7yXeZIS8UY3oHsaBDZZa4rHBkSKjFWulPTmtZp2O5wpWB876Y2dhk
	 IVzfz5QDEaQNm0MjiUoYRZ1Ylaaj70H2G3+oBLC9nM3i0BI0algkb/bVcHnGOy2LwM
	 OnsW0TOCi8uymimCustDyCcR8ZjBpHi8dnhkGbcmIYqIjbGqRpedWFLghwMh16WbTh
	 vcV740yvLQ8ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97D0D80F8B;
	Mon, 19 Oct 2026 13:24:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA88C1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D055460635
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPjtiSUY56F3 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB46E605D4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792414776;
 b=CPbeH1bIU7YJapHpENWMCdR/tyBbwLc2vNiTFEn0guBtz+sEMcO10NRZU+1roFonjY+7
 orDyl5c2gUYPAjCv+yeFPiu0FoSeQ07xUfFEByWDNX5erBO68YPJ0GqPb07RAGWOMlJ3x
 1vy0LuQl0pBg6FX5nh2KY37ahs1VlyhS1t5MldCQoZwf09ZOczOoYk6F+eBJiGW/t5yyA
 pSZkOl3qX6rTb6CeDVOxaaYoNsgqwT/w43REV1YiTh90mqlYIm84tNZ4MnYQQmy2CUWPq
 azJ3JzAX9H1DGN4kpi5Yyje0EhOIdiAInAs9BOnyRTVrQkWQDVeAPuH/PPfWptLaYYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792414776;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=laxwd6pnE/TX8UoOcx47eAQ+V75v2bKKopZuqv4pMTk=;
 b=LOgq5tkylS6VaGYaV0PShx8+8nMxk2pbQBAvJGXsu7y86AvafrjL18MIQ7N+Q8lJx2O2
 AVh0g4IQ1LkcxY6bNTn0PdzjsBZEovU/VqRqrWjQic5b/ZzmQPy0pejT7Q33akfHnf1fV
 WXxMm/BibA3Na5eHr6DdNnThWJc5vrcEOs0Mx1cZmiPq+AAlWtWThb7cfsWuq/bXgQbvo
 ZQgPyO/+6++hZS+9koq1Kp/zSEJYRNV4KR/kp/ZS/tE8hJbb86fqpgZhfjhVGYvaryQCf
 POdnOPIw3nYVNyJHdeOiytSb34taC0CPZCr0v9OjTbbTxHQ1TztLscEOUSJ2NcxrV5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=R5mggsvI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=R5mggsvI
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB46E605D4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:35 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so8841165e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792414773; x=1793019573;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=laxwd6pnE/TX8UoOcx47eAQ+V75v2bKKopZuqv4pMTk=;
 b=R5mggsvIyg9pGnUOt4sr2spB09HuUvT9Q+MsPgXe9MOR2v8zwaLiSpV9zJCjDex0Yl
 NGRKuvqIffug81XYl1OcdHJDcfEGTfyVO1tGBrEIC08MS+6Ctt0BSzKRBm3sO8eBczIL
 R3OA4rY1nT00VcJbi+oNLPIc4oLNMXM4XC8G4urZBmYNOtZiI0JFf8H7pxQ/68TsQdv1
 XYTW4GcpUYR/w3HOcAYy3NBIJ7HCtX3BgxQk7lh4JsEGQvt/v0mblPNKf6fBgbHjykYt
 hBAsqb62RBBac5lVfoCrMkmtoTwj34ywkaic2dArPMwVH2qJ+a4pbX/RT6iyXBT9dsJh
 2DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414773; x=1793019573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=laxwd6pnE/TX8UoOcx47eAQ+V75v2bKKopZuqv4pMTk=;
 b=w5MrCx7vv/tijtX6CiAHNWvWML2+VdKN4MinxdzadGrUG/5mapEjFSl7Q6cAL5zkx+
 EAbvm1RiShyiumo/97k89+WcwyAXC8WqfnTcGcwBGzxmMXS3e0/Pvd3bsTIQeNqo6zLx
 dCF9ltGND3h4wQQPDzArPxBEcmYg4oIVP92speNW72AdxN+SsyiCQZUlIsQa5HOb1j2W
 98Qa3XoPf8v7DmAxtkoKCm7k3PlEZgMYQ2TJGUeuviX/h2Sg2ipIZ1qZNVVoVtLZ/OlQ
 AUpT0X+0+u4+RP2GPNhRPBei2HXfidYlGcMFSlJ+XjhymKH9QydnmpqDJsI+FhuL9Xzo
 aCmA==
X-Gm-Message-State: AFq9FYKB9mhC+EnyRjR4TqNswHe4D2GajQmslO9UgAyYmykB9IQscuU3
 sofh7N+dN4/zh1bmIm/IXekzvG1TyurxZLN0AZ3FUlBShfUI+NtjE4f2
X-Gm-Gg: AYBFou037y2DrH/HOOzr75P8sTOrLY12UlIc5hDBbziqd5vD9W6QSXTKsU/ZsCf0qd8
 LptNqcbQlr7WXMaRRytVCfJ7W2HTV//AtekYV+PPg1fWW2/LzMiScRFhF0snBOprtJMvI3lNOh9
 7KtCLCq/dWB5Q5j0Q9Gh3vTS7r8ggQEzVfziGF43jYytywdFqCTQK5/Hsyk6kd40AeNezdhxWIH
 9HltAftO6YgFYKsCWUTTyMHsYxjxQ1Ajr8AhYHr+hBFkI7xDjA/KH8RG2TuYa9xKtsKm0GJ3rXX
 YltjdVsZ+6VCdVnOq72AbI4luHVsmo4DZIn7s441e8o3LtpE6KMo+AFmfeMrB4Ze5+OHOLRlza0
 ou5KgOYunNgzVX67wtYrqtgLDldLnxtMbZkfu2UnNlFpg/+s3d1KKFXbowPxXqd5agRHCYCG1f8
 FQHLk2hCachyCRfr0mkE6VgSizQ0LDsd4spD+HGJ5ba0+2YW5Jc3FMSOLrLlj21V13
X-Received: by 2002:a05:600c:1d04:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a1d76121a2mr180001915e9.15.1792414773422; 
 Mon, 19 Oct 2026 05:59:33 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d30d778bsm264696755e9.9.2026.10.19.05.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:59:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, stefan.eichenberger@toradex.com,
 francesco.dolcini@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/2] imx: mach: imx8: fdt: return libfdt errors from helpers
Date: Mon, 19 Oct 2026 14:58:52 +0200
Message-ID: <20261019125930.111608-2-eichest@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019125930.111608-1-eichest@gmail.com>
References: <20261019125930.111608-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

delete_node() and change_property() replaced the libfdt error codes with
-ENXIO and -EINVAL, but the callers pass the result to fdt_strerror(),
which expects a libfdt error code. In addition,
update_fdt_gpu_industrial_frequencies() compared the result against the
positive ENXIO, so a missing node was reported as an error instead of
being ignored.

On an industrial i.MX 8 booted with a device tree that lacks the GPU1
nodes (e.g. mainline Linux), a misleading error is printed on every boot
because -ENXIO is interpreted by fdt_strerror() as a libfdt error code,
e.g.:

    Failed to set assigned-clock-rates for GPU1: FDT_ERR_BADPHANDLE

Return the libfdt error codes unchanged and ignore -FDT_ERR_NOTFOUND,
which fdt_path_offset() returns if the node does not exist.

Fixes: e9cf7f515a19 ("imx: mach: imx8: fdt: set correct frequencies for the industrial SoC")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/mach-imx/imx8/fdt.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index 8337edc2f62..630b5e55702 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -281,34 +281,24 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 static int delete_node(void *blob, const char *node)
 {
 	int nodeoffset;
-	int err;
 
 	nodeoffset = fdt_path_offset(blob, node);
 	if (nodeoffset < 0)
-		return -ENXIO;
-
-	err = fdt_del_node(blob, nodeoffset);
-	if (err)
-		return -EINVAL;
+		return nodeoffset;
 
-	return 0;
+	return fdt_del_node(blob, nodeoffset);
 }
 
 static int change_property(void *blob, const char *node, const char *property,
 			   const void *value, int len)
 {
 	int nodeoffset;
-	int err;
 
 	nodeoffset = fdt_path_offset(blob, node);
 	if (nodeoffset < 0)
-		return -ENXIO;
-
-	err = fdt_setprop(blob, nodeoffset, property, value, len);
-	if (err)
-		return -EINVAL;
+		return nodeoffset;
 
-	return 0;
+	return fdt_setprop(blob, nodeoffset, property, value, len);
 }
 
 static void update_fdt_gpu_industrial_frequencies(void *blob)
@@ -330,21 +320,21 @@ static void update_fdt_gpu_industrial_frequencies(void *blob)
 	err = change_property(blob, "/bus@53100000/gpu@53100000",
 			      "assigned-clock-rates", gpu_assigned_clocks,
 			      sizeof(gpu_assigned_clocks));
-	if (err && err != ENXIO)
+	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to set assigned-clock-rates for GPU0: %s\n",
 		       fdt_strerror(err));
 
 	err = change_property(blob, "/bus@54100000/gpu@54100000",
 			      "assigned-clock-rates", gpu_assigned_clocks,
 			      sizeof(gpu_assigned_clocks));
-	if (err && err != ENXIO)
+	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to set assigned-clock-rates for GPU1: %s\n",
 		       fdt_strerror(err));
 
 	err = change_property(blob, "/bus@54100000/imx8_gpu1_ss@80000000",
 			      "operating-points", &gpu_opp_table,
 			      sizeof(gpu_opp_table));
-	if (err && err != ENXIO)
+	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to set operating-points for GPU: %s\n",
 		       fdt_strerror(err));
 }
@@ -354,12 +344,12 @@ static void update_fdt_cpu_industrial_frequencies(void *blob)
 	int err;
 
 	err = delete_node(blob, "/opp-table-0/opp-1200000000");
-	if (err && err != -ENXIO)
+	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to delete 1.2 GHz node on A53: %s\n",
 		       fdt_strerror(err));
 
 	err = delete_node(blob, "/opp-table-1/opp-1596000000");
-	if (err && err != -ENXIO)
+	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to delete 1.596 GHz node on A72: %s\n",
 		       fdt_strerror(err));
 }
-- 
2.56.0

