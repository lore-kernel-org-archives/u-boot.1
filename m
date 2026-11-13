Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22B606A338
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lHKryZOD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/O9Br/1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2661160DA0;
	Fri, 13 Nov 2026 06:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0a2Pcaf4iRG; Fri, 13 Nov 2026 06:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E37E60DAB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794549609;
	b=brSAWguthlejbTZe/MQBwRYiljmpA7zHIHpjOtyosc6MFqxYMOS/HYDaNJokRQjxr2j6
	 67RccNufda4S3T0tgRadlDXSkQbF8cTNwmShm0E0JH2agxTIC3nBlShGHmGAunFPyyU76
	 1umV9W9llx6r8u4nSSklset5N0q59Dwju3Y9/wPkc0LwlsXx0POzLKhSdKdwOKMwFvysK
	 ogqMxK/VIPXovkpHS2a5wtdYJBEhWMf9JgbxOwzeKmkDTDV9+NEICQpCy22rKXVzoUGJt
	 ms5gS8C1xOv4KH9TSo3nH1b81Zed4/Peuug3ndEwtuW1TQlCRdopUZcV3wcneD5PkQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794549609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dauybAsgYHN+r1mBSw/ZKgLkKjOG5ZLloEwZBq9NJ44=;
	b=gGnyU3gP6caOOj+JmtXOGANfE6JJY0TumesCGOnYb2JFZN09AIJXwALd+KOjZLIuM+HO
	 0hLvSLa4xe8XDQhYurgsU/w+A4rAmViOJzngzl3cNvdyiW6sYRKKenduoJ6po/MqoDmqJ
	 aenoWGzxtIvIDHwVaWURLZgSKUeRI+Z5StDVPC0gO6zb63Dd+H3P/1fmEwCN9yaO0TlDW
	 n97KiPEBAb49/HR3mVe/t6N3/aL7KMtYE6pCXILWV3wsoNPrxK8qeBDZXaGNhmEFMQ7hj
	 CD6kUXmE93MpuYzM6TletcgJYKb9nkS+BtYOYT96X8s4ZwhPD2/tbyUjWzppYIOLcZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794549609;
	bh=dauybAsgYHN+r1mBSw/ZKgLkKjOG5ZLloEwZBq9NJ44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHKryZODTr9BcmIO55kPU9ZE6+AzSG+94QnfrgnRUNGhdnzIO+dgvCfyZuQVdRqb9
	 aoOhoQSETErhG4ZU4m2G8Y5eMxf+BuHFWLKY7DYCTVbw9jUnogL/JT+BezXoEtv7AZ
	 9MJMvK2aUxQrhCLcoFHmsSjOpT8GSsJR3QCV+Pb+DDRCEBQHdBsYpii8Q1ko9F0Ewn
	 iS0A7f3cqipjvMY3tyYjClUxcy6GiSpFl6ke4OlhQbcoiWLkwg7DRsKLZsNG9Jw+fq
	 aRYFFIa+2yUvlDj2xZN5Llyjh46RjJFF0QAjGiSmVK/f4g8q/V8lcBRRlr0i9by07J
	 /Pio2qY7v0Xlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E37E60DAB;
	Fri, 13 Nov 2026 06:00:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 838B71370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A26F40D9D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9SicQehrcRc for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3184040D8E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=V/O9Br/1
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3184040D8E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:03 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso7096855e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794549601; x=1795154401;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dauybAsgYHN+r1mBSw/ZKgLkKjOG5ZLloEwZBq9NJ44=;
 b=V/O9Br/1jGqz3HUoFLLsqhCxSz4xYPt848bdynvE8AV01gqouGJwZs58bR7hKad8g8
 1wfXD1cdl5EQ/M+IKFExue5aZwFpSyINRG0N52EH1OLUSKoV6ufFjsnbqFBDtgR329GK
 purHwoBPJZNgXUMOLYR67jMO9ga7yYTQtRr85do9sEz2mmkfmWacyzkbduLFAjNJ+AjL
 yrn809BzIpwEWPgGlQ1ZjVX+8UupouQUcFy5kyWuc1xmO7KwBkgaxbNHo2oGTB7WT454
 9a8WlilhYnsme5DALqj27jqjqbkzfPBHawWyWhZXYVy1IC6v0Ap7qJCoI9iIUeUhRtsz
 VGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794549601; x=1795154401;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dauybAsgYHN+r1mBSw/ZKgLkKjOG5ZLloEwZBq9NJ44=;
 b=WBoQIzTfLEdThPfHSMLAiTilQqIkOEl/vCNC7M3oT1VX/Rt9L+yb/ioiUuk//ywQcC
 G9tRAWR8xau6ZCeMtAC3DB1VJq47xjEkbEG23Z3kQQgBNXdqC+nVY2vmlWc8Wg16we3U
 /2h6kyHI3voXbmuKQd2SaKNU/RrRx4K2hyYp2+AwZV8etwQ2f4WefU/s+GFjHYWImvDT
 y0pVZsYkCJSw69dJ6W5gy7NyTcKcpvbp23q7vuF63C+i4oaihvx+EWgbEv9FrBA0vtnu
 cwgRfvYeowg279RHZFwZllqWMzuguGLULw3jG9DK9OGbGKvgG5LDzYWx5t4xoYKy022M
 eM8A==
X-Gm-Message-State: APuU4Z/R8JiqbXeLZe5JGBjSZ47zLxz2Bp3aKop5QjhmvJAepoP1ejE0
 gQcSaGpkRNf3BwF24J+HpFM+4rN+LL+Rzu/7EMgbBCiqhaaNYFtiQSTg7gEZgqoK
X-Gm-Gg: AYBFou37oayJNvUL+SkhkvtZFbu8gnni1godix1fNef4PEDHbc4IqiVyMnNRIbP1CRz
 Sg2lhs64OTAfcCRuPTAYh//HMKaiXu+jBc5RUl7JaYiqELp/IigZy38BDN0vWGudPQeSgY4HY90
 F0nF4QW85DkDM4WI/8OxFVA1PqrBnCslFEL4Lenv0QVJXd3aWhbLwxBymKMPs1978K1DLMNmsa9
 H1LKoK4brfX2PXR06+peJO+DsRfWsJeaSOtifYNDVpJ4txmlAOLDk25XVK+gxFBWJTZCDwKFjwx
 NhzcPyEjWMjpg38DwoPhQW0akVPTwRG4hV25eRY6a5leeEq2CJB1gqzvJC4An1yjY3vvXV2wFjf
 huhzgPz1g0ALy1h4AaFxzeX7+9iGBOmlv8jYZnfXAGLp2LLNXlkXZrGfdTlm9qpmW0+QGS9B4L1
 rS+Dz/QNa0Gxc5UJB91zsKIAcjSxeS1QyC7ZeDhisq9g8SMKPulIDascB1F6Xpz5REy4i+j1o71
 4+NGYm4h1BZEXQEcQ9RZwyIdgeOzRIoz4yeRXSTR8B9QQNnq2F/rePfSOE4/YjoM+BDB5kzc6KV
 1rmEsZJn4wKGYpQ20G907wcJTicBoaMpy3wwyM8Y
X-Received: by 2002:a05:600c:4f0b:b0:4a2:1196:db0e with SMTP id
 5b1f17b1804b1-4bb55a7d04cmr30535575e9.30.1794549600987; 
 Thu, 12 Nov 2026 22:00:00 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm32906355e9.7.2026.11.12.22.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 22:00:00 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 13 Nov 2026 06:59:57 +0100
Subject: [PATCH 1/2] arm: mack-k3: Kconfig: Hide remoteproc configuration
 options
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-remoteproc-v1-1-be4c313f577f@gmail.com>
References: <20261113-remoteproc-v1-0-be4c313f577f@gmail.com>
In-Reply-To: <20261113-remoteproc-v1-0-be4c313f577f@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Judith Mendez <jm@ti.com>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The K3_REMOTEPROC_XXX config options purpose is to imply the corresponding
REMOTEPROC_TI_K3_XXX ones. Having almost the same settings in different
configuration menus, does not help the user, and it can easily lead to
unexpected configurations due to weak reverse dependency driven by imply.
Moreover, the REMOTEPROC config option selection can cause the related
code to be built in forcibly even if not needed (any K3_REMOTEPROC_XXX
selected but all REMOTEPROC_TI_K3_XX unselected).

Dropping the prompt attribute makes these options not-visible and thus
they cannot be set/unset by the user. Anyway, they continue to imply when
required, providing the optimal remoteproc configuration on a case by case
basis. It is left to the user to just play with REMOTEPROC_TI_K3_XXX to
select what he really wants in the configuration. Moving REMOTEPROC from
select to imply allows the user to unselect it if not needed, too.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-k3/Kconfig | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index bc02368a04d..36580f27d48 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -175,32 +175,24 @@ config NR_DRAM_BANKS
 	default 2
 
 config K3_REMOTEPROC_R5F
-	bool "Enable K3 Remoteproc driver for R5F"
-	depends on ARM64
-	select REMOTEPROC
+	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_AM654 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_AM62P5 || SOC_K3_AM642)
+	imply REMOTEPROC
 	imply REMOTEPROC_TI_K3_R5F
-	default y if (SOC_K3_AM62A7 || SOC_K3_AM654 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_AM62P5 || SOC_K3_AM642)
 
 config K3_REMOTEPROC_DSP
-	bool "Enable K3 Remoteproc driver for DSP"
-	depends on ARM64
-	select REMOTEPROC
+	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S)
+	imply REMOTEPROC
 	imply REMOTEPROC_TI_K3_DSP
-	default y if (SOC_K3_AM62A7 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S)
 
 config K3_REMOTEPROC_M4F
-	bool "Enable K3 Remoteproc driver for M4F"
-	depends on ARM64
-	select REMOTEPROC
+	def_bool y if ARM64 && (SOC_K3_AM625 || SOC_K3_AM642)
+	imply REMOTEPROC
 	imply REMOTEPROC_TI_K3_M4F
-	default y if (SOC_K3_AM625 || SOC_K3_AM642)
 
 config K3_REMOTEPROC_PRU
-	bool "Enable K3 Remoteproc driver for PRU"
-	depends on ARM64
-	select REMOTEPROC
+	def_bool y if ARM64 && (SOC_K3_AM642 || SOC_K3_AM654)
+	imply REMOTEPROC
 	imply REMOTEPROC_TI_PRU
-	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
 config K3_HSM_FW
 	bool "Package firmware for HSM core"

-- 
2.34.1

