Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDD606A333
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dpsEwecx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hmvZMwgg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 975F240764;
	Mon, 23 Nov 2026 18:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktZ8WtPMR2qX; Mon, 23 Nov 2026 18:00:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C68314070D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456818;
	b=iDhRixPctD0RoshwjLOVrXy0lne1HCon+V8s8bIYjpUSrKtDyFfKjXvtjT05iu8NY4dI
	 zQhyf21GcLER+HeBvPSEHxNxZEjqPJlEmWwGsnQlA8cXjQ9ZBBHQMPXy8s92fhF7VIbE3
	 8xefomb3znpGYjRCUPxJMQ+zrnwEKMwOvx+LDDH3oCrqZsavpAQW5F0PtyMwLkdCdcG3z
	 mOVJvai8fBRfQv32d8fyGQHZDV8gjDQfPggwEXwt5LAXkXF1/MCa0Yzc2lF7w1/HaiSyL
	 Lp7JtE6DC9swGzP0Uw91r2jA3d7eqi3VJ8IHFA/tEaFL4x8JBF5+CLSnLIXIuUhvuhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R75AUdf+wz83EVxLlJWkmX23NYZV2SaVVdCePDV/4uE=;
	b=K+0+cdZJ85vpbBmEd1bchsGfSB+0w0Byiwrxe4QYJ/iMd8wMjSDJMx4/CYNl9tje7yxp
	 5F83WrtsUyEwlPZO257q6AM3xFASVBCcQw4H6Vqpyi5eLDnSd3A4xN2WFpmrXVcoQ+9Fy
	 QK1eo0X4jnaoNqL9QW1UqsNNEx9X12oewy5iB9vbOjJdL14/8J/Ao8NZFZB2kjLzmCe/B
	 QKDrtunUC+HkHd0glqWC3NTvbVDjAws3mQTzwOxqwic0aJKBlFr2pgjP8iD2zkNokynLM
	 ISNYbpS+/6YW7VovH2s5COVQr9grH/pKdChr+kHOctbTeEuE50NaGtuvZZAEavTgg4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456817;
	bh=R75AUdf+wz83EVxLlJWkmX23NYZV2SaVVdCePDV/4uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dpsEwecxB+TCKcvwRbuicpeE5U9dfS34hbfHJ2BnlWzFC1/HU32cxbc3IS14XUF9+
	 NyuDiGOrzHaHtr/KTBWMGPprq7fat6uRXB2Cjn0IVExHWrr/JO/Onn/eMtr9r6vUSm
	 QjRt9GXpxDCiPS2soctIlaRl/Ke+OEHZKOPP/FfLjaEldsbA0EJDlnOX/1NCKqSMAK
	 dKdj4C/3FUds7si8RFbCv+m/E9leULssknYTrQ8KNe4vYul161EvcMdDx4P+nkaHqo
	 jmBmLKGIb58JPcBm41TRwHLNMiar29OVsD6YOk9okzC8S9dxAnBeOkGA7/YAW/xOUt
	 c3p80ELl+CIQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C68314070D;
	Mon, 23 Nov 2026 18:00:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC6CB15D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C250C400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wDQPamPeX0A for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C938940093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hmvZMwgg
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C938940093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso34413005e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456809; x=1796061609;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R75AUdf+wz83EVxLlJWkmX23NYZV2SaVVdCePDV/4uE=;
 b=hmvZMwggKzK1sGgUmdISdpYVD4T8M3iO6xYNMqurHWd388uW82kzJ4lqY8LAmmZ0Fr
 /rpjZDEnY32g67DUhSdh/aAqTW2+yXIpI7RTN1CBjkcEJTONFlNgLNFfl/Mja+bwbaaX
 JPycGXWFWTrXWOpk9dnsJEj7lDJKg0YWb/d3ameNcT9ubr8kr6uVLQGOh0e7iNAO9JNs
 vPPSiy0uL8C6coga52QI0RJ8PawPn8StKZLm+6qt9EBS1l5eQWku6slVm0yNAe+Dy8cV
 42f1gLxKQnq9Ad8WMoApD/E/UJC8ImqAFRwa6aIhgr+HYdHSaAzozVNqx0m/8pk8wCfz
 GmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456809; x=1796061609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R75AUdf+wz83EVxLlJWkmX23NYZV2SaVVdCePDV/4uE=;
 b=dDHg82YxDd08jvYyevtrjPrBB3qliAsbE9iBDbfFFv26BI1zk7mX+bryHPD5lA5TRr
 XmJMbQpLi0ucWSMPC7YlAXW063wzbIEAVZR2r9tyqE2PAgwfaNoDab1H5IIT6+j2c6Up
 4uMEpdJ/bPFSeTK1m35AqclESKofoYoT39lnhdO/OGuOuEHB1uL4QC7vjj15bAIpbrdK
 yl6p/xg5czvT41ZXGh0mde58fYuU/9WOD0WegNgO6GNFCon3cEbTohFjdFhFPp3attRk
 vvSGgcDxXsys7ba5e3aHQS36xzQCVmIXnAsSog//1KDJ5W0sf0ANPtRpSrsoL/jvBkiT
 6JrA==
X-Gm-Message-State: APuU4Z/iY0+I83U3mIwwJ2Ww7hdKotJRNvNn7k+1l08M8B35I0efUxcb
 prouUH8lIQOarQh4hW9deBi1ZDZ/7QeX38GhC0501JYoVY4mkcW7c20s
X-Gm-Gg: AZFdTZe2wntjBydCT9WfLGG/Dg9Oz7OvRQCaNhDNxuFVDTYmhpgmfMJiubgtzWoQBf7
 NFuAc4N3CK8Oc+K6G+M1aQChMX2g4ZVh6SolXagiReT04IN0w9GxEZb0fXbaniY9ELSre5mc6JG
 kkvBtco9wAzV2mTksE9u2xAcAy8evyNlNrsSqkbdWgb34ViRNl3Ct6Ct8qnf4axrEyguzCBkQNs
 Zp3JhdzUnzBQGvm8m236HMdS3y7E5pTPhpjQvFfjdRTtM9S2GdcydTD5bbZCyKuAaqmG+gKA2sT
 hEFE5wNaSDWaOb5KxrAWF+OR+5ITKBNVvHkKYLsLarI1eTCrSfPJpc0dJHsTNTuXqxTMHg0tNfI
 YISryntFQUJUK6fukCdTYF4PxbR70Hy4txNd7j6Hf3qlceXH7VG7cg0Kyy9301PL4wiQhI+GsFt
 ka+0a7zZTfJo/TegtVjNJH4RtpE22SWICrQx4hGziKZcr1kQMdVyw+oVWzdRm/8VKgs3h2zW08d
 9NFR3QLl7zqL4iH/YwMBSIyBAC+PW6i13HBGTUKDygw90BFtV3iwAfT+5MfH4jsr4YtyxMSASNH
 kjb5E7ne38qNl8ms2ZUkXQc0eBVSIxdwfflfNKA=
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb8880abafmr292601125e9.9.1795456809354; 
 Mon, 23 Nov 2026 10:00:09 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:09 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 19:00:06 +0100
Subject: [PATCH v2 3/5] arm: rockchip: Move SPL_BSS_MAX_SIZE default value
 defintion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-config-v2-3-be23de2a81f5@gmail.com>
References: <20261123-config-v2-0-be23de2a81f5@gmail.com>
In-Reply-To: <20261123-config-v2-0-be23de2a81f5@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All ARCH_ROCKCHIP board configurations using SPL_BSS_MAX_SIZE have
0x8000 as the value for this option, except one, the evb-px5_defconfig,
which has 0x20000 instead. Now that most Rockchip board configurations
have migrated to use the same default, there is no further need for a
second SPL_BSS_MAX_SIZE config statement definition, with different
defaults based on complex conditions. Instead, in the common/spl/Kconfig
file, declare 0x8000 as the default value for SPL_BSS_MAX_SIZE when
ARCH_ROCKCHIP is selected.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
New patch in v2:
- split from patch v1 [3/4]
---
 arch/arm/mach-rockchip/Kconfig | 5 -----
 common/spl/Kconfig             | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c1dbcce1e27..86eb5012192 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -840,11 +840,6 @@ config SPL_BSS_START_ADDR
 	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
 	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
 
-config SPL_BSS_MAX_SIZE
-	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
-	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
-	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
-
 config SPL_STACK_R
 	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
 	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..216542c0288 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -150,6 +150,7 @@ config SPL_BSS_MAX_SIZE
 	default 0x100000 if ARCH_MX6 || RISCV
 	default 0x80000 if ARCH_OMAP2PLUS || ARCH_SUNXI
 	default 0x10000 if ARCH_SC5XX
+	default 0x8000 if ARCH_ROCKCHIP
 	help
 	  When non-zero, the linker checks that the actual memory used by SPL
 	  from __bss_start to __bss_end does not exceed it.

-- 
2.34.1

