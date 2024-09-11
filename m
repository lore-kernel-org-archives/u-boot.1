Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E95EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378F388CDA;
	Thu, 12 Sep 2024 00:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b1MUorMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF289882CE; Wed, 11 Sep 2024 19:40:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA53C892ED
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlK6hwTy3inQXYKSaZKA9qEgjMKO997UFTiONrEsYu4=;
 b=b1MUorMrHmI+kAdPDd/Du2hix52zDefhSiOhlyIwuWA2bVo0sUrXbLQVt4eJ6fwtUcDmMN
 aYfkkLVvhUMcYgWzRH5Cy1GuMq9qfIG97PT9ss+jLkLQUYAz1wbZsC/QvhhamC+xBdHmkP
 wWgYlLB+R8jsCFRZlHrvkIEWSIneZZk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-nCuavLbNNuiDjWJgLhabow-1; Wed, 11 Sep 2024 13:39:57 -0400
X-MC-Unique: nCuavLbNNuiDjWJgLhabow-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4582a549257so28161cf.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076397; x=1726681197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlK6hwTy3inQXYKSaZKA9qEgjMKO997UFTiONrEsYu4=;
 b=ufEFhZ3+W6vIG3n06S5I+1wYKrmjoXF7ZTSimrgBRZXVCsy4Sw/VV7GbzHTfw2z+e2
 HNKuCIKt+Mn96Ma3p1GiNM7WI4281fR3Ug1PAVWv6ifKjyOfFarqjj+9R+VU1fWJlwib
 h7sG7ENxepF5JAsRtfyCEnSPZL9oVmQFS0DKOmmNcEQm58UKKVuGyNEw/uEwDZDFLhft
 BVWWv0Leww39LfsAh6jdZayqAlgs6sHnjuFdxJPEERf3gopZ6I9iraKJduPQ4ICo8zZS
 UN1vdj5BrTB/tYnKGPBOimIiL1aYytIBo89OehAX/0Zpnxh93JSLvLNeKWz1QAi8P04V
 GUVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaM2k88sWv5oDMgM1chWjUupJP8CNov42WfyI0jjo4gsGYLnNX2+IsDmYgaDXBlw9DJwTRuUo=@lists.denx.de
X-Gm-Message-State: AOJu0YxnfHy6YHPBTzmd6DJBS3T6/fp0oiYliQdnUeXz2YrEhvmDduTi
 g+40LymEAgXQ3TjoQa/VgLqk3gJVENEC1S8mWdVdfoXdUpl9dXtB8dEWizYljXQqxEF8h19vbok
 T/Mtol3AO8Lth+MHjnIUJIHe3I4qhmK1KkEOaE+FCPHhgpnXIrug=
X-Received: by 2002:ac8:5851:0:b0:458:4d6c:ae2f with SMTP id
 d75a77b69052e-4586031d083mr1558681cf.26.1726076397241; 
 Wed, 11 Sep 2024 10:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfeeA1Ne8a8IjGlCSRuQHYYobuOlKGL+V8w5VtAS6UUuLAutAjhMXqGOshudhc986rMZVJDA==
X-Received: by 2002:ac8:5851:0:b0:458:4d6c:ae2f with SMTP id
 d75a77b69052e-4586031d083mr1558461cf.26.1726076396863; 
 Wed, 11 Sep 2024 10:39:56 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822eb0027sm43663781cf.53.2024.09.11.10.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:39:56 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 11 Sep 2024 12:39:50 -0500
Subject: [PATCH RFC/RFT v2 4/4] configs: j784s4_evm_r5: Enable ESM related
 configs
MIME-Version: 1.0
Message-Id: <20240911-j784s4-esm-enable-v2-4-957f56b588d9@redhat.com>
References: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
In-Reply-To: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 00:03:14 +0200
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

Like other TI platforms, let's enable the ESM. This allows the ESM to be
programmed during boot, and the PMIC associated with the ESM output,
enabling blocks like the RTI watchdogs to actually cause the system to
reset.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 configs/j784s4_evm_r5_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 543b0a50d7a..4d3bc68528c 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -97,6 +97,8 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_ESM_K3=y
+CONFIG_ESM_PMIC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -123,6 +125,11 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y

-- 
2.46.0

