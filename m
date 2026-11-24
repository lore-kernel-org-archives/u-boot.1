Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753D606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x3M8tnj4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrB5gXzG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E381B80E76;
	Tue, 24 Nov 2026 19:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id blFG9rAP3A7C; Tue, 24 Nov 2026 19:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12E2E80DE2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795549985;
	b=bClqM1fqByUa509PEHPpTYJw2rWwehWaBvfPUPVNt+s2pT8LkqkQfCgvBEwRwhzIMkR/
	 RvQTbnr/xSw/QH5Um4HpR2hVG17zoY2F/SBdiYEnFbloMMrZiWBWB0QdN/0x1S6bxznYP
	 pBZEHTgZio7CEzJZfoiq2vQbVm4d+BYRdGRBgPHjbC80I0s7do+VyigWzA37BvUNuCKoh
	 tv+o+ZbDBW8xc6ApPrMcS8T07bNKewvw5PbxkKq2OBk/LAKX9gO473CkYntIdkqcuyJMM
	 hjmfYXgIje8bE+71sapueD67gTuoSc47u+VE792tcxw6qxef993Tuse0tY3lSQHIMQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795549985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aJnAK59mThk3ieqV2AiuPTeQ09ngOO7rV6QrzOy+kP8=;
	b=ZT+H/TR5bZSb4ZD6nbjl3NvoVOvUZrq92Ag4ndjpNMZvdTNvKWH5KKs0ekjA4+n63yPA
	 r+7ShMBk9Rj9Wuc6jURpSb1vr/abjBtR2TFbzIzuUeE6uo46/VzYwGGMMDxT/tGQnoOgh
	 rT1fXGN0UBKzcd81xENNf0S+2kFxDrFqD6HdvhQlBzrHXikQJcz5LQrMkaYkvp9NmD444
	 94BYzi69DpDGxpZP2ww1AR9dzDZAUcS2RohZDKBMJU/vZi0sY+oDGtuOq3r2zSSn8weR5
	 4GNo0GcKqaLI7s427i5CClAOdI/TrJn1EPC7Q3gJzJFefO6to4f7oOQ75bxAfsTgFuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795549985;
	bh=aJnAK59mThk3ieqV2AiuPTeQ09ngOO7rV6QrzOy+kP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x3M8tnj4h+jbxCTUGqcy3MtQGYYCxYGzn5C00HaGNZJYY29GQZisINsyFW8gooOaH
	 mWaYgkoaxEhV2ESslzEKtyIfURTBvXJwOCqhb60r3Q+eTsbY4pmT+yLpl2piVl5wxt
	 2HK8ntBv8NdqFi7IzsDmtiQ9IPNTKdlXqbT/7Hbk74ZkwZw6h6mlstxH8M0Ce2mlp+
	 aAlQvW6dJYdPbtco6AeKkO4/xZmF1EEchPqZ4Hal+HF4CoKCwkgylfIKl5LxeU5u1C
	 DuBpsr/J+mpUiioWSl0bldvaDZ9nhIk+rF7096hF6oLxoqjEv1rylDL4MlEmZMyjt3
	 0SJmGzm/tpbvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12E2E80DE2;
	Tue, 24 Nov 2026 19:53:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8558A325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BB6C403F4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5kaM7JMEcmt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B02B403E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OrB5gXzG
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B02B403E4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:01 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5c14470729eso4704391e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795549979; x=1796154779;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJnAK59mThk3ieqV2AiuPTeQ09ngOO7rV6QrzOy+kP8=;
 b=OrB5gXzGYWXPaxmZGl2zhOD/0C1jFd6Q+JJi0Ua5QXHNkrN4wP7b9USwlk1o5wqn13
 Ruo80SGnjti4E0xuqKDWKhuO9mOQTgawoYJOPwei8MIb6ODyyW0t8spOP6KTvuHgQGmQ
 wxj1NcweUioQMT5fmVKhhvUPEoIJhNckoonzexkxT6M7k3RxoVkxDnFDL9m6yFumjQD6
 Lnr4UN8ZN3P6Kmi/3jQzHF0UgbHN4N7QvZiapjML2xqok9lvDbD71lNtmQW1sxLjobS/
 LOYjhEm2YO8dxfBlwd+kjx7tKLm9RMJ5me0UpqG6PY1cQmM9ggVyza8I2EU/4e5VODtm
 V5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549979; x=1796154779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJnAK59mThk3ieqV2AiuPTeQ09ngOO7rV6QrzOy+kP8=;
 b=uEQHmx4N0dhnsYuUNtt+MZsmGSadJ7cJ0xDLM2+sL5R0Vn9+xKH4OEAA2wBn1V0rTM
 lA0u2sOQX/Hg9ZADRcDQgDNkGItangeTjVR1HdszHxL3TaNNXW8aNaZL/7O3ibfoK25n
 R8yLZS8BjWLyZck/Tq2zE0/1IivIGVmczdZy5Fw32VYqUJK0BIEzi4YQ7uVBJfu2LCUY
 qfnrpxtkwZLOIdbINESyEd55KmD7h9tX8etz2cc+6Q0WX1jxKgg88ugxRXn3A8ngtdXE
 m/tb0zfIdJ1N0EA4dblm00Iky4676bSt/P/axAZ0V7SF+rDR+ZeqMduS69usVc+4EPR3
 SKzg==
X-Forwarded-Encrypted: i=1;
 AL+hErHvbe/LEMY3aiDSKgKjGbOWoY68rHeudxhRrZxurE/IjcezEjjhalRz+UbgsVxwdH4ZV7twLMM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z87+ZjioewuzvmgyiJdDluS88hFiJvBzXM6Mdlz5HUOUeBIvFFH
 kRXwzmv3XYOO5MBRdRVwd1K8P5Ze1SIsaIGJRgXroLJljjEI6GxcwXb0
X-Gm-Gg: AZFdTZcvRLQMUvJ7gEAs8Vgw+pdM/vzVdJXh5/PI47QUj2PJAvTpaAxyMeVenhir78u
 2ip3ihVU4L2lA6t33FjldDsjqB/pYVa3nC6Nb6VfYQ9kPPJxdUOhdHGkD1cL1j/8mNwfWpYvmTw
 6q+kh7VWm+ob4oTZ8dH1OBx5BODu4/YcXuRFku7QXIhRLkrNslJ9JMnrn4VTgkRmmmkOHkBj+S0
 quFohWGPf3OMHtr3kfh1QJhGv8plZCIArPsjctcsnmbgdb7JBO05+7MhbpjBA+Ot8QzV6pWhOCX
 Hhu2xJS8tcPZD9I2KO2lvSyT0Zcy/cIsAGYiHVWrKky/0LnQSGk0X5XjHUaQwPOsV2iKCjx+GdR
 ViviA5dmxRRvlIbBBbY7DOdqqBrBS4PMfJpmi9Y0y3ZVtLbKM9HtGyu+Prx60UiJd15CengwrKM
 zJ9Adz7q4Da71E4RynmGwU3i49SKhJAjI+zbcO/UMWZfihrhc6bsoPmwW8+c9dm5opDNJ79OUQh
 Bp+mZSIQdAlsbNH7qFZFARo8wyhJnoour007jzWwUkyzlbr/Lg/lgTpcTCFy8MmX2Me2IJqkHN/
 yY1xClT6jj5yy1gBeQK4Bp5Yk3658oozRNJv4U77BvNMf3C4OR8zw/JkPYDxWccQXHo=
X-Received: by 2002:a05:6512:4006:b0:5c3:1120:5527 with SMTP id
 2adb3069b0e04-5c31120583amr2406192e87.15.1795549978917; 
 Tue, 24 Nov 2026 11:52:58 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm4057216e87.53.2026.11.24.11.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:52:58 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: Tim Ouyang <tim609@andestech.com>,
	Leo Liang <leo.liang@sifive.com>
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Han Gao <gaohan@iscas.ac.cn>, Kongyang Liu <seashell11234455@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hiago De Franco <hfranco@baylibre.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot@lists.u-boot-project.org, Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 3/4] riscv: lib: rename thead_cmo.c to thead_cache.c
Date: Tue, 24 Nov 2026 21:52:36 +0200
Message-ID: <20261124195237.692679-4-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124195237.692679-1-indrek.kruusa@gmail.com>
References: <20261124195237.692679-1-indrek.kruusa@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file will also hold the cache enable and disable functions, which are
not maintenance operations.  Rename the file and the SYS_CACHE_THEAD_CMO
symbol to THEAD_CACHE to match.

No functional change.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/Kconfig                            | 10 ++++------
 arch/riscv/cpu/cv1800b/Kconfig                |  2 +-
 arch/riscv/cpu/th1520/Kconfig                 |  2 +-
 arch/riscv/lib/Makefile                       |  2 +-
 arch/riscv/lib/{thead_cmo.c => thead_cache.c} |  0
 5 files changed, 7 insertions(+), 9 deletions(-)
 rename arch/riscv/lib/{thead_cmo.c => thead_cache.c} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..23fe867c840 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -89,13 +89,11 @@ config SYS_DCACHE_OFF
 	help
 	  Do not enable data cache in U-Boot.
 
-config SYS_CACHE_THEAD_CMO
-	bool "THEAD non-standard cache operations"
-	depends on !SYS_DCACHE_OFF
-	default n
+config THEAD_CACHE
+	bool
 	help
-	  Support for non-standard cache management operations on SoCs based on
-	  T-Head C906/C910 cores.
+	  Support for T-Head C9xx cache operations not covered by the RISC-V
+	  base ISA.
 
 config SPL_SYS_DCACHE_OFF
 	bool "Do not enable dcache in SPL"
diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kconfig
index 57f724ae043..8fd09719852 100644
--- a/arch/riscv/cpu/cv1800b/Kconfig
+++ b/arch/riscv/cpu/cv1800b/Kconfig
@@ -6,7 +6,7 @@ config SOPHGO_CV1800B
 	bool
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
-	select SYS_CACHE_THEAD_CMO
+	select THEAD_CACHE
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER
diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index a02f5f24906..738bdc7523f 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -9,7 +9,7 @@ config THEAD_TH1520
 	select SYS_CACHE_SHIFT_6
 	select SUPPORT_SPL
 	select BINMAN if SPL
-	select SYS_CACHE_THEAD_CMO
+	select THEAD_CACHE
 	select CLK_THEAD
 	select PINCTRL_TH1520
 	imply CPU
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a527b3e9ae3..89c4fd4387e 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
-obj-$(CONFIG_SYS_CACHE_THEAD_CMO) += thead_cmo.o
+obj-$(CONFIG_THEAD_CACHE) += thead_cache.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) += aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
diff --git a/arch/riscv/lib/thead_cmo.c b/arch/riscv/lib/thead_cache.c
similarity index 100%
rename from arch/riscv/lib/thead_cmo.c
rename to arch/riscv/lib/thead_cache.c
-- 
2.43.0

