Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C92606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LofILAv9;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=H31MjvZY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E7138111A;
	Wed,  4 Nov 2026 08:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TI3mG6N8cSpw; Wed,  4 Nov 2026 08:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0BDF80F50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782338;
	b=H2oP7Dp4RD+qFRvmmoC+ZEanKPCT5ClML+GZVaSLsTvfCnONrNmAWjWikPU3fV9wKV5l
	 b8vMdLbUkX69JRdmmfPhBnFa+YMruM6vI6pypjKKLTQfToFmBpl48RxkeebLb2msyi4QQ
	 mqkJKQDaZNNW8r3x3clYb8iD6b7bhaEq3sgVuhrOXFOzb8l5HD3asHVKi+ooztvZNx1gO
	 PVnkyHb73KT5VQV18Vu9bVojYkb9Uma+ng91AsIYkAm+9/tMsDLJm3gCTHDT229pgxVik
	 rbVDNYOl/fG5HGC98bd7OCgGG2jQB6pNWnLChaKxdPNLOWwMxVUBPxrIp05n2aCGm2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X4QzQZa3t+/18ZVpeoZLqORtyKyg0tK6BFR4HywmINc=;
	b=hlC/7EDrL2QsGViwNGCO/xOwq8Td/XvPISolT8SKgrNILFt/na1l/ZtTBCWnsoBGPCE/
	 66JBya5FwT4agIeCsJ2wWNgqvmo+WH5dmQ+/iK4EIePexxtLExB8lMmznlvCw4WOItfCn
	 0xo493pxffe+VTUbs6tUqxKYrYve6j8zeSVgHmZAL1jr4A6Ef/6/vu170GvYmiSuKx5Em
	 ajJ67e6wStDxhRnDHh8rNa+Nmp9dqkYclIOK16IsRHm/e6dJuJG4DhsigQzQvBg7XcXUP
	 KafCbI5aKJG66FANmKtxjOEgRWKzvBOu/68CuH4eLvI97M0y4oA9Qb5/VeasiVuAVBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782338;
	bh=X4QzQZa3t+/18ZVpeoZLqORtyKyg0tK6BFR4HywmINc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LofILAv9+fpC22Oam6XgTaRMWE8Ws0PmHK2W2sHB2YtFPFv2wAtJiCZ67Av3rBxET
	 XsPFbOInSWstDRp/zQpNA16Y7ljmF4zdgOj6IZTiaHArpV7lFUWHV5wifPCVoDr8xw
	 r94K9XBQTQ6J/BLnB4JFfcgjmgJVFlf3HVXSm5avwpdHkwoKvLzXuUEmmzHpTMY0hY
	 /9lDDGXRAE9y2RkSTYx2LQqVm8Qifm7RiwHu8JFq7+NnqLNT/lKJcPds8b6oDy+Fu7
	 xQ9yCdvVw7rfLTgFTU+g+NDU74rJd9M2Nnk8grU+k0kWb8TJdd30n0hpz39Hiy8HQq
	 Ikm2fUL/ChbZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0BDF80F50;
	Wed,  4 Nov 2026 08:52:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F1C2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AABE401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_zEjqsUtB7x for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF13B4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782334;
 b=b2hGITWAeCtZojfvnMQaBzLBtn/HNs2SBK7KIc+ePvvuhQaPmj7xE+UIfTpD7FQmSdMN
 7zEGj21NOCntTF30Fe8UVUaCZo3cCEniWHI9HJKcsYoFeLNliozn7+y00q61UiJ5u9nbw
 v0hyyk7g0b/K8AuzXdIGPPWJbyr/YMDWo/Oe6SGsyDhSWheaiW3+CfB5nLQTwu2xhHyd9
 qTc3WiRe8wVzsCXje+m4YSLxa5umV+zGTEMPFzLnB6D4g3yCS5el2MvaCdsy5+VeHQK20
 g2RHonxsVSikYeuwfF52GZCzskcZ91hrvVqXDnXEYqwQxC1rSoAlK2VTZ64zAT9r1ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=X4QzQZa3t+/18ZVpeoZLqORtyKyg0tK6BFR4HywmINc=;
 b=jm4sRXo+st8RwGrhfj+WnQHGbjhLDds0DLv16BxIYeDzDqJmQEnY9ZdsFJcpzN0ydZs/
 LCyRXDorNGb4lqdZxj0jvUPF6o1IztHSFNGmNZFIKStNpZxQdDoCzn7WWhMKL9p3gN6nu
 U0Rr84VOUx9UYvIBvQqNTEIwHP6mTiqXV6NscxRYxbyOGm11pPAllIOGo3fMqN7XrDDkG
 axufAe7G4TFbJgV0/Aa/OlYf1a0gvVoeIEo4X+NeiDTMVLvAw790KfoO24AX93Zp/fyZ+
 A/Yjd7rpaA/tVRSrPfGwMbocF/qIEnrcgLnifDKGlCSkr37TxpQ+NFkiyX/t6biKrfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=H31MjvZY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=H31MjvZY
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF13B4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:12 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3381815e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782331; x=1794387131;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X4QzQZa3t+/18ZVpeoZLqORtyKyg0tK6BFR4HywmINc=;
 b=H31MjvZYwpH5qKdVUHDQ7j/2jJUP3f5zwlQQd0KF5BHikcCwO3Ih1J5Pdf66JxxQZG
 xFAEzNCCEyQftAxmxXJVz7pPDBZkrTuP46Qr7PXuKxZnmB8wW57tdr76zq4nsdxXrH95
 tCB5h7ZTQ7aNLsaASYx1Kh5Cg6zzt1HOQtMGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782331; x=1794387131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X4QzQZa3t+/18ZVpeoZLqORtyKyg0tK6BFR4HywmINc=;
 b=INil2fE+aIo1GYXzVi+TKopa5EO/GK3WC4qXKdvo/9fafCqhG6XZYvaUdA4fFFsYQr
 6a6MmYPyhQlZqen0vMgdbrrTDebIWbSsnHL9uE1M9Pt/77ZIXmOP7nJqR8r9ijjc01yu
 I/8CstwztXEAadgqyTqT3QknEBnUA2suJSx8iKeE2Y8YOq32YDCu0uBO+hS9nhL8ZAOc
 VYC8oGpLSgbLD4ZrRAywCd63hugxhVXTy3B550YbVM891rv6z2wi2VU7T5Tf6z2XUxa1
 mrGurS7npudTQhr5d9JGsr75trwUuwSfu1Qx3jXj4lpcvRe9vn/SpnhO4z9UX1mNtc+p
 av7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+n3bRoitB7Fl7IiHSMU3GbUZvIW3HMf4N8985/Zm2fL4rloHTn5Cuxm27jNguHOgBtKaU8sc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8BQag2/pdr7VuHeeTm7mtoRu0OneXFxm1kfxXM/Nv1e2ltGsJN
 Ej6r+vQx7VfmER0b2W26CTFAsrQzOV4RGcgM+FEjhq0RXzDP9KBuvfC82XN0jiaalCI=
X-Gm-Gg: AYBFou3umAXRn2TlZ6FSARktlIUePl14MAxvC06Rm+CijOPX+QgYNXInRsZfEYVyd95
 6U33DpaKviE2IjjqERdVGEqijLX+vpySqYchevyLHrc7eKavnxGi03WYYFiv8cNuYGe4cKjbU4q
 EqvjIUeek5ZxuQCU5RRNN51KdkCejncBQqjxrudxyga37NHMiPJR1bXgszc3IXg9dw+gjMLE4Q0
 DYqFJvUU1rk9ie/yLz7n4J+MbU8249rs7xrgxneFs9BqtN+h4UYVX+dpH+CAau5Tld9I6atlqvK
 Jv3s5TpDeKPujY6EDS0OUpv8jNfumF7tuWj3njBb0MuTkk+9XZGuIKuSOGo1PHvTtPMa8lSCl05
 1wuX9lz5jW116rd20T56gVRrlwuCQRKwKZDWjl80q+tS8AAlKvBu1gbgK161bMI4Smmdd89h0mX
 JfbfXahz3blT7D89a0DlVsG+LJefwqQt43iIn6TiMReU2iLz8Kaq9xtuYXxdWz0Qxp2pxfvqMSr
 DdGiabYWOFsIQVQfowotVpYpQue53BFicfLFIytezWpd1/fCuVyEBN+Jgj40DjV97X1Tp6sYImX
 SIB+evl7+CzcCv5p8MBZGqkIvjfqwrFIIlkh2ueuQUzwNrpSRToyiKYZy9vG4DjXLRoYoASg4Zj
 AwxwTFulRgI2f5is7n/wdQUS4XvHgqwHv7rFgdr8ldni9+EDoFA==
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr362642775e9.12.1793782331143; 
 Wed, 04 Nov 2026 00:52:11 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:10 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 25/33] arm: stm32mp: move FWU multi-bank support to SoC code
Date: Wed,  4 Nov 2026 09:49:58 +0100
Message-ID: <20261104085036.4012238-26-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

The FWU multi-bank support, i.e. the boot index read from the TAMP
backup register and the selection of the partitions of the booted bank,
only depends on the SoC and the TF-A, so it is not specific to the
STMicroelectronics boards.

Move it from board/st/common to the SoC code, renaming it to fwu.c as
the stm32mp_ prefix is redundant there, so that other vendor boards can
use it too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/mach-stm32mp/Makefile                               | 1 +
 board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c | 0
 board/st/common/Makefile                                     | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c (100%)

diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
index 853469f3c503..e22207465658 100644
--- a/arch/arm/mach-stm32mp/Makefile
+++ b/arch/arm/mach-stm32mp/Makefile
@@ -22,4 +22,5 @@ ifndef CONFIG_XPL_BUILD
 obj-y += cmd_stm32prog/
 obj-$(CONFIG_CMD_STM32KEY) += cmd_stm32key.o
 obj-$(CONFIG_TFABOOT) += boot_params.o
+obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
 endif
diff --git a/board/st/common/stm32mp_fwu.c b/arch/arm/mach-stm32mp/fwu.c
similarity index 100%
rename from board/st/common/stm32mp_fwu.c
rename to arch/arm/mach-stm32mp/fwu.c
diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index 36dfaddfa0eb..122b13c3aa8d 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
 obj-$(CONFIG_$(PHASE_)DFU_VIRT) += stm32mp_dfu_virt.o
-obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += stm32mp_fwu.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
-- 
2.43.0

