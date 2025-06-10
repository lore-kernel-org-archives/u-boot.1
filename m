Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295D5C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D6982BBF;
	Tue, 10 Jun 2025 18:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wQFG4G2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24F482BAA; Tue, 10 Jun 2025 18:23:40 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A865382B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2409567f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749572618; x=1750177418; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R8auT6W7mx8XL+z4o2H6z8v6Sv096Albr26zMl7vTPc=;
 b=wQFG4G2OjjRrxcE/TftAQC/3rbhyeP+uGIqEmn9mgpyQsrIM0e2dpZLwPFJv07sJdN
 IjupgJrJRG8QP8FwN6hQcpgHj1uVE+/OLxv+26rd+aAdl871WHE94xhD6ATPbUmONkN7
 LBWtXWKsiikdRLJV6qTVUcXd88H9BMNIXij9J4HhBSA4ugZVWA/IESFav5gIlLzONiSP
 kC5ClUXcpWoB9Nf1YGDtcjVIclZtt+A9TNRX2iiPmBtNJoxOFc04XPR/CEDIz6OhWKcc
 FCUKHBcUivIc81+gkmY55wOXdgSBHX4eanlRIPHPHyb+PPEN7yXi3s+3b161eBnY889Z
 M83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749572618; x=1750177418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8auT6W7mx8XL+z4o2H6z8v6Sv096Albr26zMl7vTPc=;
 b=citOv6988dL+V8YMCJqhVht/o7njsWujq7lWxfMxbORQjRneFhOXbfyCGP9S1zg1Tn
 xO8s+D6tYh/M3R7uIE3lsS1MiM4fDihJ4uMjMddAXKILLilWe2XHry+XL3IyK4Cy487x
 r57VGVGzO9hpQ2jZFE+tvVPyQil32qVQK4YyETw2glynxx5Bos5xKsOXSrljqMCCMJs7
 G3EAbvTUR2G/5HYt7QE67oaDbpoMdRiy7vQ4qW2U40cd7ENHfiNIOtJWahQz+L8u87PX
 FB9274jxdGGbzRtwE2561QKWS/mGxRHsZy54MbHE1W6Y7cMuj6bYveZSp8XWXKRPVlXQ
 uJvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY88yN1F17NxckvCZKbD3kxucZspARkuCEw2xxG3uky9zerQW0lRPLupgdLuMvbuGHJ4T6Crg=@lists.denx.de
X-Gm-Message-State: AOJu0YweFEENhOESogJrxsCUvOG0oudPli20eHyl/dTHXunmAjdbNmO7
 EJTmqVL3sdnPh0DtePgSML9g3z9A3G/4PC2BLnPHTU4EhlZQJSrT9FwDs4IeUamKpIs=
X-Gm-Gg: ASbGncsCYa1kDdqnC5I58e5Eed0/nnB1qYlNFGlI6xpcRH0LJY8YoUXYm85qry0zbMv
 gFbbr0xgzTc+h2tSMZQjdbkGsw0TGh9h0/nXokGwTmCcPYnWwpakjaRt15yU7+X84vMoAEZ9qbY
 Cbfkjt7dlWBWDv+dH5VnoLIKCaijJ6+KIaU+YQsUx9PKk2ZGDzKzDnxE5ANo2AmEIWM6Y9Z1TTk
 ffhy9V+QlGscD73WbCDu+ctOjwAQk1HguDNspr1vaMon6GJ7qCbmDEyzZCfOgXAarhoXiiNmHZ1
 1hn5F7v+8KQJmvFee3LB0R18LDdjm40DGBXdohyb7rb6ueCtTFtEgY0/2nazlH4Npa7NWw==
X-Google-Smtp-Source: AGHT+IGz6hy23UFOCpuBhZBOMIQ3b223Q/U4QwgjFy6WDgLbYl7VwypBE4nFbXUmOdKP1BxEN4ExYA==
X-Received: by 2002:a05:6000:2382:b0:3a4:f744:e00c with SMTP id
 ffacd0b85a97d-3a53188578amr14254973f8f.29.1749572618069; 
 Tue, 10 Jun 2025 09:23:38 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324364c9sm12962890f8f.51.2025.06.10.09.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:23:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:23:34 +0200
Subject: [PATCH 2/3] env: set fdtfile environment variable from /chosen/fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-b4-fdtfile-from-dt-v1-2-aec4df0fa53e@linaro.org>
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=tviOySK4Z9E3YWOG/vPm6NTx15Y2PP6bppFBU/HTCAs=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSFwGRf6Kh1BPG8Zq2kgXpd5TJjiZpbnl9C+fJ
 qh37m/+7d2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhcBgAKCRAFgzErGV9k
 ttB1D/94qOXH2HbnXxObMM7Czc2lfDJPXSzZao9ljhk7pPjT7k6ZxZ38gd6HimQVqJ20ZvuGY5B
 /7HJqKctrfWLtdqh/LAtJ2JCMZmgnNmzmREchmjcKiQ34SLIhwLbfpA5uCplkB5CKO4kXFHyz1O
 i4YG/WHDZh++u1VHv/VN0tdvsARg4hYQ/bBasScTZuOwqnnexQmM4fdKhxM39jm97L9Sq/r/gbM
 wd8p7ZOLawB+SohpQcEnyJymi5uJDjowVfn+KlO+PJnC/pQULVIKYy5RYgWAgY/oYxSrRGYsy5r
 z0LOW79S/znc3ZfwYWUPLqhvqNQgnkBEv3Qc0DlrRKGbWTAjd7v5NABHJL046ShWtpOpWCxaooH
 Htqkyk6+xNoZrIjQaqhM0tzjd43yfzp0QIH6RVrYBESrgY4OsX0iLUUaGHVBGQsHN8s00Wl9pXM
 +YayLb1rvDAd1J4jySpAqElOwjRu+dga0Anch1b3Jp6w4tdvSeyGDnmitgdtjinmE10ZomcU4a0
 dtM/SiDuT8+8XRE3TV9ETH9wNJBFmIkMQZKpfQrrVlCONK6FS1US+P8zcoJ3vagtupo2504kBzK
 MhVEDMGVyPEBDPux/PzWYFrniX+S8cb7hlbiIFQe5UPNdeAQb4w/gBztfLB9BkvvUglyElsg8ij
 rATO4yp0u04RPGg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If /chosen/fdtfile exists in the devicetree and the fdtfile variable
isn't set in the default environment then populate it. This allows for
U-Boot to load the devicetree from the boot partition or ESP that should
more closely match the OS being booted.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 common/board_r.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index 41c8dec8d49ef21a12fd41272581dd94484dfa08..594c7827c39cfca5f4561b4699e5b66de54e11c2 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -448,8 +448,41 @@ static int should_load_env(void)
 
 	return 1;
 }
 
+/**
+ * fdtdec_setup_fdtfile - set fdtfile variable from /chosen/fdtfile
+ *
+ * This function will look for a string property named "fdtfile" under
+ * the chosen node and if found set the "fdtfile" environment variable.
+ *
+ * This devicetree property is used to identify the path to the FDT in
+ * use so that the same path can be checked in the dtbs directory on
+ * the boot partition or ESP.
+ */
+int setup_fdtfile(void)
+{
+	ofnode node;
+	const char *path;
+
+	if (env_get("fdtfile"))
+		return -EINVAL;
+
+	node = ofnode_path("/chosen");
+	if (!ofnode_valid(node))
+		return -ENOENT;
+
+	path = ofnode_read_string(node, "fdtfile");
+	if (!path)
+		return -ENOENT;
+
+	printf("Setting fdtfile to %s\n", path);
+	if (env_set("fdtfile", path))
+		return -EIO;
+
+	return 0;
+}
+
 static int initr_env(void)
 {
 	/* initialize environment */
 	if (should_load_env())
@@ -458,8 +491,10 @@ static int initr_env(void)
 		env_set_default(NULL, 0);
 
 	env_import_fdt();
 
+	setup_fdtfile();
+
 	if (IS_ENABLED(CONFIG_OF_CONTROL))
 		env_set_hex("fdtcontroladdr",
 			    (unsigned long)map_to_sysmem(gd->fdt_blob));
 

-- 
2.49.0

