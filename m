Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D1C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 14:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6DD801BE;
	Fri,  4 Jul 2025 16:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bF3e+zNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85A8803DF; Fri,  4 Jul 2025 16:40:43 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B824A800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 16:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-702b5559bbdso4637906d6.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751640040; x=1752244840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zZU0TaejqRcvrjl8T+eu2VDCMLrynUZ1ivBxUfJ4fMA=;
 b=bF3e+zNEfJwcYQGHbjGSGVipdaU3FfzGYs8/Os2mxS9qdPZYZLnpeTv6I6gIrIA+Ts
 PhaAmrBLtuyWlzXk9kpw33rRzmYB0zdZJkLsMTxTa4jXx9huat6S155hZJ5ixH0AOcwZ
 c3xnG5bw8Z21Y2aLZBhzoPI93kIi9D0eHEDDrnmnM3V628WwXEAVBflNnrdNiYsGTXUv
 q31jHyFVDIMCxtE6Fe8dhjcQ9JveOHAYCOCbOpr/b44sdh4kRgiJ2RWvCxNPrL216LME
 KibDsdoYM9IJW4E8lTLEOmS9NKFaXILJBNAGlWQbd+7HauET4ka5tUryLVdxv+Jx4WtZ
 gm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751640040; x=1752244840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZU0TaejqRcvrjl8T+eu2VDCMLrynUZ1ivBxUfJ4fMA=;
 b=b9NjNe1QC0wN0mdIpWKh1EHsVOqeqItZzuUFVkFhDeyaBPILajf0cT7AapW6S1n3TI
 GYujyvWm5W/OWbKeeFTDRPR+UwxfIZSAV3FECpTIhiQ5G4pK/Kq7qQ1AxB48eTjPE9op
 AcmFuZPepagWa/tmmycQJ1LYrHNxSL8N2BDS6cD7NkZ9D3SH8pW7O72vwe0pCZWY/VcX
 2QxFhdRGSZKKlOUGWa0yon4QKxzBJcQgf8i/q3NgoTtgi3JiKbzkpLuNLRmuVSZSg0zn
 TKpbIyUtwveHkI7+86x9FKexT3ypwQcnmR7M4Fsxx5hjpj5J2B6Vz1YVzx4fb/MRNi7S
 gX0g==
X-Gm-Message-State: AOJu0YwfypJpbIvIWjZ1GF3/+L+kIyubXmjuT/mXspDeOjJX8L6NS1us
 /5WIRzpICLijSAjeR7bbx6dl7hQ5NPJXeVFr0Zd53nhKcG8iLCgfw4nj
X-Gm-Gg: ASbGncvj3J6ZUBLFescwVh07sZ03W6Sx/22MlnNfZLxeKKllghRdz4JKMEUQKPIXuZ5
 fElbyhjwxGCe0ZeuIcpqXI7+a5BE0uJBL7PQIpB0GpMnvhTfn5j+eyAl5S7NjzMsP5jm5+UQgfJ
 hzVMhOzQSjrNDIgdj/B2WBpJkFIlViUfxvPFueqXQG6EN3aDOcXmxWQ3UbRYlEEH6eQuKPVvvSG
 x06scGhTwZVwiRzd8OdiWyGgVZzTU0FylTUlpMsvboCOzjwykSo1iW3oSxgFJ4dyrouKLiijnzn
 tkRUyjEPp8Jx39W89cKycYkWa1rFZ35V8thep+y0O11Hqc2UGOZilvnNkAy3Q8NqYBd2PhZSogs
 =
X-Google-Smtp-Source: AGHT+IEOj+e2RNoe3BkG5FdfuO/oDvrF05Ve5FFKMTJt3p99YrzPcPFKWKVvfWx7t481krlU4zhuBg==
X-Received: by 2002:a05:6214:234f:b0:702:bd47:c83b with SMTP id
 6a1803df08f44-702c8cfd274mr30940606d6.45.1751640040347; 
 Fri, 04 Jul 2025 07:40:40 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b490:55b4:7a89:ec6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4cc765csm13436286d6.24.2025.07.04.07.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:40:39 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
Date: Fri,  4 Jul 2025 11:40:22 -0300
Message-Id: <20250704144022.3946416-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The mx6sabresd U-Boot proper binary size has grown beyond the 
CONFIG_BOARD_SIZE_LIMIT.

Reduce its size by removing the CONFIG_MULTI_DTB_FIT, BOOTM_PLAN9 and
BOOTM_RTEMS options.

According to doc/README.multi-dtb-fit:

"Usually the DTB is selected by the SPL and passed down to U-Boot. But some
platforms don't use the SPL. In this case MULTI_DTB_FIT can used to provide
U-Boot with a choice of DTBs"

mx6sabresd uses SPL, so MULTI_DTB_FIT can be safely dropped as the DTB
selection in SPL is done by board_fit_config_name_match().

Tested boot on the imx6dl and imx6q variants.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/mx6sabresd_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index f041f1fd1a3b..312af2f57fde 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -40,6 +40,8 @@ CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
 CONFIG_CMD_SPL=y
 CONFIG_CMD_SPL_WRITE_SIZE=0x20000
 CONFIG_CMD_GPIO=y
@@ -65,7 +67,6 @@ CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="imx6q-sabresd imx6qp-sabresd imx6dl-sabresd"
-CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.34.1

