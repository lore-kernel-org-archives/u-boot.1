Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C4606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ey2AZv+2;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=k7vxAGAn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 755C781673;
	Fri, 30 Oct 2026 17:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rE-LdGy_yRF; Fri, 30 Oct 2026 17:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73BA281309
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793379917;
	b=FmJxMMOAO+3eceylmRij8t8NrgF8pDssiTIxOApSJXVKNl/taw9iFlqNMnegzcELqTNV
	 JbRYnX2nyn7xckn9zsGQ9ijZc0YvhpdLcvwjOLdKoQ2VAep3/EFLAddPTSrbcO8YdD7YM
	 7IW7p0sE3zEPT7fG0TBhmdirT+TPt2E/lkT/YkJsyKCe6fRxyDDCpA1rM73EGLXKf9HKv
	 9GqB5gimqFe52ctteX/70Y1KkFMMzEC0RCED8ht0NIQ+19w7+rp4OtilPxjBsp6+olBJU
	 DimBAe9qSch42keDKlMyvzLGsmCXigmTR7DoSqxhCxu412NoI0PHgt8pUWViUfecjrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793379917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EPAAuCB0S3W/e2ML7p7PUAK+RLkEZogpuGdl8EvfImw=;
	b=nMhm+sQvVNUfHoBcGrL4kf+Wyht0t317h1s/pug7t1vAkcRLwl6Iy7m7DDpE+WaVmBQ5
	 p1cTWGEfhzoS2P3o6uUZXiML/oyTJG3A9XXhxAaqnZ6UeRoSq9OBKyiU/Gm82ZFxHiGcV
	 0z0cY0+SrxXtw7GU1TtqKRJSk5m14hXjFElm8v6a7LpgKZL67JsjusyCdRfEuLPER3QHB
	 qED15Rm42d+AMLvP+mKGROEp1g3xKO8S6Qq/10FYptjhiraYAlpmFQkuiyeOKhlUAkP6I
	 U4ZyntNsUr1jB9sNEn6wjUGqckpkO2mOL12uTs3XBw1+2SvmqciAlM4XordGicwDOhw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793379917;
	bh=EPAAuCB0S3W/e2ML7p7PUAK+RLkEZogpuGdl8EvfImw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ey2AZv+2po9KYYNTBToWgE+71rMNDTyu7SbjpK37W0ZXjBSKw97bJZYH2aVBeU+o0
	 nFC+Ru/h7RZelBXyPKhPVrP/+Qzbkwpa0njAzvpFO8P17XPRqncydMG5HTFfrQqZmp
	 1xrOXX9h3ju7YsoriQY5KMEApmzzIGOBeQuEpKS85bX+tUBAPKWP0LuGvlD4qtwxKH
	 vXeP8n1u8GAqNkOMb768qao8BLWfOXxwkU2wcdvoUBmqm4n4uvbRMvp7JzccKau+Cx
	 2lUJHn9WBQLeB+KQ4nXk7W5UU3SFMKOAGuixAi8gJ61pjWIEuH4GPgPD4bobYYGr+J
	 9lDLMqm1Zz6+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73BA281309;
	Fri, 30 Oct 2026 17:05:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A201F235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93C2C60625
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eVcGkmMXcGHE for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DE1B60ACF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793379914;
 b=grY2cgg1tfb1+E3PG00lMLTaG6JZZTbQSoH8iife+vaTorUUfPPLHMrixIKsMAalAC9N
 iD4Pg11vm6OjINJ5/QENJ63N33CSWyEWuNpCZcyhf+TZQSiRKq/aizYzq7NcEMYik8+Av
 WTaZDtq/PiGgVbIjUKVn+dMCJASBZubj9aER0RQleF+MRDJQ+jPWuMVkOgKHCZ/UdkTd4
 34Dm6OlRwoLeHW8KkDbCVDWZi/8dcFEm3uzw389bP6GQrrNjm9BSdAATbhyPWme5d1wTi
 y67BvzRQbgFkb19CjUAiBha8FnGoN/W2vOtZ9eWTePUX/QhZkHuwxoJnzKe5NR+/47A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793379914;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=EPAAuCB0S3W/e2ML7p7PUAK+RLkEZogpuGdl8EvfImw=;
 b=W6wXVPWVa4KABMrxU/HD2FHptGCkHUpcA3RKWAA+SnCVqBXlBpfoqq8Yex2U0PvjlmMH
 CzEfXCqBUL/LPVW4VGSoVcauLZs6oFxF89vGxHzBdTiGKFuIxTU8JjuwfDnjnPg+WSbvH
 6Cc25eIAUNAw4UbL0qvo64Fm3WS9h1NeeZ1ad9KIHQ75djqF/nclUYPI2C51/1yhQDcDA
 aC95RraIwwX+tNfrkfwrqKsmjHyYIwqRAwKp8s3RkuSqSuCKwNVWfzj9/jFoQ57d+Y4vc
 Jg+VxSsBkd8ciNLkmGcqguPRHAOJfi95PjCE1UKiXmKh+6Fz9ra4GCj39XVvusXM6Wg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=k7vxAGAn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=k7vxAGAn
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DE1B60ACF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:05:13 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so8069665e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793379912; x=1793984712;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPAAuCB0S3W/e2ML7p7PUAK+RLkEZogpuGdl8EvfImw=;
 b=k7vxAGAnj4u6FPqvMZ9Gqk2ptrJ5nd5lWRtqsTUCArUmfZvDjqa1urEq0xH+uTsF9g
 Occnl6rwbhYzZ32fZPvtuarkoziBZbeMOAM9Fb216fTMkjOqpG4MDv/YWR+H++U62KVF
 ciVRyojcdUAvFLnPJC8sQorWUrOnID+29+mD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379912; x=1793984712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPAAuCB0S3W/e2ML7p7PUAK+RLkEZogpuGdl8EvfImw=;
 b=jl7ucVGMMtwn+XOatqH1mD0A6FEWCaVF6y7NBhJB0TiShWdE2G2Uha/FcN4yIDRHDD
 6ZLWSWuaxhgHwvJ5govFUso5/1enysSa8t2x999UdnBVtgZYPO4f/ndKKfKxarJ+VeLb
 RchQeoqJywR5nR26Xwt2xourHOYMgxqz91U4fL5UZt6mFypL9PIIEbCkv+knVIDGzNhz
 5+5ksL6fJ8pYlNNt67zWIfHhMTPl8CCQyWwmgSDRwII5h6IfJGue/PhRy7C5iC1zWy3N
 +GEVek87HdY9eWqe6k0Q71mJ6sTcdGy15Tu7w7hu4B/FCAcmvw+xV8GmsUgX/GAZR8lf
 4NJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo7VZnCvXXPfCJ/jzJyB5jKnF5ZaS3bhOB5o8dn+/hBRo11JTmbw4N3OJFQNA2wc4bZ7K7iKM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIYPEu/yWieJufITEG8XO8WmG37x1Xce6/gCAiJ9Wbotf62DJ9O
 6Z+shcdsjVvqT2Akmts+ksq/t1BcewRww47t1ZmLxOwSEAW4u4jgclbo32aobE/GhDk=
X-Gm-Gg: AYBFou0WAQtneDqWd8ldxnggONSMLCxR0aI6VIbxZI+dyOVQwtju7r+vlM0Ry1EbGK3
 cYqv3bMm0zkuqhIBHYU6l1jwfk7fXYfMS5EtHGMb4ZoFpbaYApn6AohBFedfmSyeozDphGlkiQP
 ZWesaJtDDCzJcSzcMyzscGkaQAaqSZkx0svurMhG4D/n+51u102gcqvEBI/YKSfGJJko2OeYBfI
 cmeDgsuaNeVAQVWSxxvgXOUvexEBti6we4X/EH7IlJyV80gsfJjoSwFiHS7Cr/MGodBN22wyqKm
 k59Z2n9vtysv0UZMUYVVlv/2qjmTThlJNGb6wGSCYgllt7iwBh4Cvk8XR2EkNxu5aRlxO+eJgjY
 Vcsg1iqNHYVE4Psz8sqUHWj1rn/CfZDAdlyBNfofgkhFKTyDNzvmaVdck8d9rNgNDDNe7Kh6fHa
 uf22E1VZgBF0G6T6+0VuR7FjNii2PUiPxucgHsEJN486X4iu0OeNG9oUtSEecgaFtheY2h3BOWy
 d2/vBgKjzdm38g9JXrnS4p7ZAkiJLPInJOMKmV8xlieDus4TU+t8jOdjOzsosEk5SocD/RJIG5l
 Snwt/1FBGRvS62ddN6kwtizp3aBDcM5Xy1OifAwPfJ0TiP96nFJ+edVp4hbViojT+//VG3hA/R7
 jUxUJDABdJpEGKFfCY7j0EUOHof6mlmZ2UUjg057FIx2uXSMnHX1oVCH/AEbxpfea4bwMbdABF7
 F2VtR3JNxLuPCCQyVv3WzN8XCJlg==
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4ac18a88fa6mr67955625e9.32.1793379911728; 
 Fri, 30 Oct 2026 10:05:11 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm166602025e9.11.2026.10.30.10.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:05:11 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] imx: fdt: drop the cooling devices of the disabled cores
Date: Fri, 30 Oct 2026 18:05:05 +0100
Message-ID: <20261030170508.2819620-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On i.MX8M Plus the cpu-thermal and soc-thermal cooling maps also list
the GPU and NPU, but disable_thermal_cpu_nodes() only truncates the
cpu-thermal one, dropping them, and leaves soc-thermal referencing the
deleted cores of the Dual variant:

    OF: /thermal-zones/soc-thermal/cooling-maps/map0: could not find phandle 17

Remove from the cpu-thermal and soc-thermal cooling maps only the
entries of the deleted nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-imx/fdt.c | 58 ++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index 1ef267184634..f732eec2025f 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -9,49 +9,53 @@
 #include <malloc.h>
 #include <asm/arch/sys_proto.h>
 
-static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 max_cores)
+static void disable_thermal_cpu_nodes(void *blob)
 {
 	static const char * const thermal_path[] = {
-		"/thermal-zones/cpu-thermal/cooling-maps/map0"
+		"/thermal-zones/cpu-thermal/cooling-maps/map0",
+		"/thermal-zones/soc-thermal/cooling-maps/map0"
 	};
 
-	int nodeoff, cnt, i, ret, j;
-	u32 num_le32 = max_cores * 3;
-	u32 *cooling_dev = (u32 *)malloc(num_le32 * sizeof(__le32));
-
-	if (!cooling_dev) {
-		printf("failed to alloc cooling dev\n");
-		return;
-	}
+	int nodeoff, len, i, ret, j, k;
+	const fdt32_t *prop;
+	fdt32_t *cooling_dev;
 
 	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
 		nodeoff = fdt_path_offset(blob, thermal_path[i]);
 		if (nodeoff < 0)
 			continue; /* Not found, skip it */
 
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device",
-						 cooling_dev, num_le32);
-		if (cnt < 0)
+		prop = fdt_getprop(blob, nodeoff, "cooling-device", &len);
+		if (!prop || len % (3 * sizeof(fdt32_t)))
 			continue;
 
-		if (cnt != num_le32)
-			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
+		cooling_dev = malloc(len);
+		if (!cooling_dev) {
+			printf("failed to alloc cooling dev\n");
+			return;
+		}
 
-		for (j = 0; j < cnt; j++)
-			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+		/* Drop the entries referring to a deleted node */
+		for (j = 0, k = 0; j < len / sizeof(fdt32_t); j += 3) {
+			if (fdt_node_offset_by_phandle(blob, fdt32_to_cpu(prop[j])) < 0)
+				continue;
+			cooling_dev[k++] = prop[j];
+			cooling_dev[k++] = prop[j + 1];
+			cooling_dev[k++] = prop[j + 2];
+		}
 
-		ret = fdt_setprop(blob, nodeoff, "cooling-device", cooling_dev,
-				  sizeof(__le32) * (num_le32 - num_disabled_cores * 3));
-		if (ret < 0) {
-			printf("Warning: %s, cooling-device setprop failed %d\n",
-			       thermal_path[i], ret);
-			continue;
+		if (k * sizeof(fdt32_t) != len) {
+			ret = fdt_setprop(blob, nodeoff, "cooling-device", cooling_dev,
+					  k * sizeof(fdt32_t));
+			if (ret < 0)
+				printf("Warning: %s, cooling-device setprop failed %d\n",
+				       thermal_path[i], ret);
+			else
+				printf("Update node %s, cooling-device prop\n", thermal_path[i]);
 		}
 
-		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+		free(cooling_dev);
 	}
-
-	free(cooling_dev);
 }
 
 int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabled_cores,
@@ -82,7 +86,7 @@ int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabl
 		}
 	}
 
-	disable_thermal_cpu_nodes(blob, num_disabled_cores, max_cores);
+	disable_thermal_cpu_nodes(blob);
 
 	return 0;
 }
---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
branch: imx-fdt-cooling-maps-minimal

-- 
2.43.0

