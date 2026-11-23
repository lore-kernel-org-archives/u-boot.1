Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC2606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nbiP/kFE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qjlLDPCQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AFA640635;
	Mon, 23 Nov 2026 18:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmIqAo_UziMl; Mon, 23 Nov 2026 18:00:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26BCF406FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456814;
	b=pIvtyMCJDW7Apu75Pmd3rz3JItBOoimaGpq4KuordpKXcmcFbjl1nRVJqayfWTqV17Zd
	 0B+E2YSBwijk+UynVlCQ/RUYva6vmkUxInb/0TXuS3XcDANkRYCGrEGcBayr3/MoJc2aY
	 tRzV7WovzS9sbL9B4RawZOBys3HsNoRTqeCuHyEERnsP/78cPnOs9PZy96vzilSuEvYfC
	 cksHVP9iRG/u/aPWlhpUa5pJYnH+2bZov797eniF5K3q/Q8tEROQcIAr0l2pcD1NZ9Yfa
	 UUsFnNWbA7dxM0f8SvSaqVYzf0nDzC6IEIAOJ/GJUrBOftTBrllBZE/wXaXOHAYVrmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BnLV+2LIA5/bF84sRwgltpBokQa8i+AB1EOoBoYuw9M=;
	b=o1aZeqDmb4mos024W6whvgG2gx8IUU5PmhRpG4rEiAr2dSVQeeMZ1jRnimoG+oeQ69UJ
	 8pBiuTw99m2L2wV4z/9OZKW8YrRxbCarjLujMSgJoZn90+KzmdMwu35wPToq1pZnMOBhu
	 h4waZfqWLzZUC8SU/8ipmIwnWQVCbVbxfiodb0W/tJDswuEEO4XsIgpgs+xvxnZsf61oa
	 R0dwk7pFK2zccCehgtjiI+nwy4ogmMto2DGKPEvVd5EZKfQEvPQ7XEiXD3RTXEeWGC1Hp
	 rLf8WVWjLGQUpIBRQHG953rYsXxWnMr/DtaSuRbN/cp8X8calz/7hbDBHBQ6irJsvpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456814;
	bh=BnLV+2LIA5/bF84sRwgltpBokQa8i+AB1EOoBoYuw9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nbiP/kFE8Ze28Rzf/DpqZgXpCeaHVV8vrkjxiWTBHI0cDfHsKNJ6Y0IRUFdKjoZrX
	 RJvNzLzVVgkBAnJc1d8ACL/rgGbALcFuwsnCnG/UD1S5Me5Bmmx9o2CgM7sMqxF+Lz
	 fyniDBUe2IQEzC8h7jN8KT6yLyvE20a+lDaJFpMAgHyPR8YUYhcKC8GIeAR16iWA3R
	 dcPz6sPoB0YqdWiPenLlWvfQNz2HasIvLy6nGnTkPMtk2kPrbQ3JjBrFvT+yklcUX+
	 GVSFSl1IHj9LYFZBUIv3H2758CT31//xPo9qvtRNRBPkLVaUFWZync/cikJbsODPvb
	 PQCUmdyuVjsNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26BCF406FC;
	Mon, 23 Nov 2026 18:00:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 857CD759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8261240093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPjs6xt1wvhP for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84F5B400E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qjlLDPCQ
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84F5B400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:09 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so30568125e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456808; x=1796061608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BnLV+2LIA5/bF84sRwgltpBokQa8i+AB1EOoBoYuw9M=;
 b=qjlLDPCQxM5OiXYvyyqYTanDO+jQV3GHd0z3tDMzg4w4N8s6XxjTLZtKntaObd+L3E
 ix/8CCGqkgD+cqvnU0GQkHtNCQvGkL02oOUtKm3BeY7VQslgC2GhryAY32lRTKJlAKHb
 vRaMVNHOls4GApEbBDU3GLXq+uFH/KPVOBpGIyPpDQm6aMwEN10XUaR5eipGlNiEKPFB
 cleK8eUJUnWO3REmDhHxTKL41JW4kghVk71+Csz4dZZG7CbvlIjvTOaz0GW+Faf3N4SO
 EFo/6PedrCyEgsZh4DupIHKOozGBZPagb4aUvcSyrq2m8vOeIhBSMrp4BKaZ1wiXGv/F
 GhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456808; x=1796061608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BnLV+2LIA5/bF84sRwgltpBokQa8i+AB1EOoBoYuw9M=;
 b=VnLFfBn9lh6y9mdYVW1Jc5I+IxWc05dsbiq5VAQx3H25Um0/PnuR+bT9xMNr0pjz/I
 6cm+GIG+pVSOnDiJd7ziQUFWNHsJfI7/QHkTPZSncSA+t8pOap40GR5Yd8Cbzqqf9Ate
 Chyji8LMpmRpWF/9aA4DUu/+1tiO5lEHnUZ//2VVroZF01+Qadtg2AwiWsWBgWLavSks
 nAizYINjxDonXb1+KMwp8XTFMDBER2To/e9AtUNlakz5nts9bx7LW9ZrHJ0VsOF+jWdA
 Rga0P35vFwwMSwIENcE3uBRG/eOZXra+0J2sPtmH7GhExlwdRQHApUweHamI3aQjXlO1
 bMRw==
X-Gm-Message-State: APuU4Z+qikrYAi2Us5AnBOkTcArmW7XBz/4bWQtZPb12R9954QcqQrB3
 1kgl3pOXbPNcY8vJ2jVgjvNACWTqQ8bATHrMv0v6KT4K1HtdIPeVO2Ub
X-Gm-Gg: AZFdTZfwI45v6DrS17+V9k45AUzmQPtcGLuF3L0+bDmN9+989Vlq5dRfP0rQ1wlbhHw
 I6invD7VXC5cN6RQkY/ksBKLuMkJk/100QLRQ2VngZC6hFFaosrb/YNhc/krFHvgwLGJCRr+L1q
 cDT1tvnwZVBUzedGSSS+RmDJZIP7HpNlq/8BRc1E8PwUByaqyFU0ypu9CWT9b2QAB0rby6D9zv3
 RS4+MbOZ20SbTluY05yTuTS5qaIedZPqdQaOxIHhaq1HRYwNu4u4PDvb90EhZ8tFxXlkll28IQA
 cXg0TipxauDqLy5jcoPlZxY4seQN5zZSeUugWKEUU2fh+BNdCe+j7lNnKab2caOqBiyfqQy6nkC
 RYopBRCsl7e0f9wGWDcpuLVjfcQXDfdbxrp1Q6tTv9JlCdIYDnfXwxacBqOuRuSWF/+w/jI58MG
 LBV3RW3OpBZTQBwIJRTQ9W08tNsrEgGFcgxg+dYSNhFlUtQiRseRZU/KHkXmQ2CsE8vRAH74Pox
 pGboUIR0OvQE1HJuEx/wFvgtxwaJcz5Sw5Dk2J4O0HEDDhlfw1AikGW5fET5+DZ/q3ob7YrpVXZ
 ZtDn+57HxtHZw1a4z/1EhghRU27R/wK6A1dc5Kk=
X-Received: by 2002:a05:600c:64c6:b0:4bb:6a75:d04f with SMTP id
 5b1f17b1804b1-4bb88807d96mr242202115e9.8.1795456807647; 
 Mon, 23 Nov 2026 10:00:07 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:07 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 19:00:04 +0100
Subject: [PATCH v2 1/5] arm: rockchip: rv1126: Remove unneeded TPL_LDSCRIPT
 default
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-config-v2-1-be23de2a81f5@gmail.com>
References: <20261123-config-v2-0-be23de2a81f5@gmail.com>
In-Reply-To: <20261123-config-v2-0-be23de2a81f5@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

The arch/arm/mach-rockchip/u-boot-tpl.lds linker script file does not
exist. Therefore, in the end, scripts/Makefile.xpl logic fallbacks on
using the arch common linker script: arch/$(ARCH)/cpu/u-boot-spl.lds.
This is also the default value of TPL_LDSCRIPT option common definition
in common/spl/Kconfig, thus dropping this RV1126 specific definition
simplifies the configuration and has no side effect on binary outputs.

The RV1126 Kconfig file with TPL_LDSCRIPT definition has been added by
ffb191e458c ("arm: rockchip: Add RV1126 arch core support") just a few
days after 957848882c8 ("rk32xx: Use standard TPL linker script") that
removed the arch/arm/mach-rockchip/u-boot-tpl.lds linker script file.
The commit date of the second follows the author date of the first: I
suppose this caused the inconsistency.

Fixes: ffb191e458cf ("arm: rockchip: Add RV1126 arch core support")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- collect Fixes and Reviewed-by tags
- reword commit message title
---
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index d066df9a86e..57ef4e1aaf7 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -43,9 +43,6 @@ config SPL_STACK
 config SPL_STACK_R_ADDR
 	default 0x800000
 
-config TPL_LDSCRIPT
-	default "arch/arm/mach-rockchip/u-boot-tpl.lds"
-
 config TPL_STACK
 	default 0xff718000
 

-- 
2.34.1

