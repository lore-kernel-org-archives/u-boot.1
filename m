Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B3606A31D
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZyuM+bDN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=yhYjf+rh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=YI5e/IOG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16B996063A;
	Sun, 22 Nov 2026 22:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbkOCCCUnq6Y; Sun, 22 Nov 2026 22:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B6D66062C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795385545;
	b=fX/lIv87zqM7dbst3hHH/wLtuJ1k3R8eLf9GXzcG3vc+dkYMwNBOA2lH3kBgL/gVPQo4
	 XZtFzP+gskFSzrsdG7lPQPVjC/Np35lA/eDW1Z3N6f/wPPk4ECgT7oRnsZ7NZQA8AORIa
	 JpaFV6RXY+RJSw+QlAlMthtGlPXNRy7w32A9KFHBNDehRdMPpYa6f4+aSXRxb0uLbesGO
	 WZXvhqHKkn5e0tndklAlpw7L54lOYqmyR61Ildi7CFf5+iTnuBtU12b831xwLl5oDzu59
	 ghIpuPOdkixpLOjuA7UrcQjwwyCO3vN3HB7TeALgJurOTOat0vQP/cm3m7FIuYwRGKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795385545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yUCKVEF7/MgHIi4bafkHT0EAY49COSmHHhBP93kXOvg=;
	b=Oo84vPLC7JbsWCFulzmUtXG6yEtZgzsr10cyYQ/01ytNqZZsHHgbywWhvn2LIKwG2jc+
	 QHEpj5QZbgRz/v60isQrgS4QZTuIsgQWIJTnMUuqBXO32ryBnKhuyepjELHyu1jC/TMgj
	 E8dcN07F1K/EjWkCKiHHsVAkg0DM/r7xaGvuHHbb7yX49FcMNrsQO1yKAMdq1Kl5qXWed
	 B0vx6GJ4Ilo87c71aVFCooau75SCSFSxJdahqwQ0dgXy62ThljvcPf9WIaqEsen3Uej60
	 YIKscwhUY9KzAuRcCxnMvSMEJMa6WhpFreRowcneg8n+nR/Csk6E3HU7JTFVYduJ9nA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795385545;
	bh=yUCKVEF7/MgHIi4bafkHT0EAY49COSmHHhBP93kXOvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZyuM+bDNLgrBCY3n0rTmvQ6XUchMYcFjU0xdWiV98WeRSjW6Ksk1y3ANbRd9RBmIo
	 iRqXIpn8wYWfC2A0OUXTYW1TeT9RT9O/dtEdf+Jg8JZfr6Rt+oz6oX6KsUh7vAUZxv
	 yh7rO6bfkKlLrr2VqYlcEuJyzX6r7cVk7JrKjYdzWE+lLAH8GlsC+zkRKEc3wFx6TH
	 XUAUi2NDl7wS5afB4Qb+3sN4qxPueAJEWuwFnOXuwxm07bufMvPqi7uFo8e3x62lPF
	 yQUFNpadvs2c8zC/UI4VV5LN+FYJE++bLOZLQ3EaWY5ARE98Wgxp0y6VTvHSyELRky
	 ZsyUzz5+I28KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B6D66062C;
	Sun, 22 Nov 2026 22:12:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7FF9371
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D94F480C6F
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9gRQYdI2yY9A for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 22:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA16D80C1C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.6;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=yhYjf+rh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=YI5e/IOG
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA16D80C1C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=yUCKVEF7/MgHIi4bafkHT0EAY49COSmHHhBP93kXOvg=; b=yhYjf+rhvmc7cQnzGEu7xOes9G
 NDzZT8wt/L92lZtwdMA1gXtCtaFQN9voLBA4bX3RaNMhsGpDEk4CTAC8fEyjl8YpLG20l3RTQTSNS
 otMIdAdsvQjXwTERI3XKde1sXQ2jEYRCqzXnF4BpkjhoMSN2hli3Y1vTF4HVBtTYtXXw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVFnC-0000000A07n-2Cfn
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 22:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=yUCKVEF7/MgHIi4bafkHT0EAY49COSmHHhBP93kXOvg=; b=YI5e/IOGye3sl+CcJ+h7INxXbp
 av5ppbWQ9noDX7w8iQTm/Kg6RA6vXLYyd6CgOwlJF4299yF96YxO+NxSCT6LATOVfxKjWc/POpoU3
 gyHftc3p16C3/1JCrmN5+I0QEdkQYOKhRgRjpbLoVsCVP+yBlviWc7s/q/8f3IdoUopM=;
Received: from [79.28.115.6] (port=61029 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVFmu-000000004nS-2hb8; Sun, 22 Nov 2026 22:11:56 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 22 Nov 2026 23:11:36 +0100
Subject: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
In-Reply-To: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
To: "Kumar, Udit" <u-kumar1@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=francesco@valla.it;
 h=from:subject:message-id; bh=mSX1hTjjjYt3JdPfbrOp/K1kvzcTK4zz8jbimX6OJ4c=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMGau52i54bnTV9pzpd6lVIytMKPNY7C/HKKGdMX6Ss
 l+jpDZ1lLIwiHExyIopsoSsu3Fvz1zzb2kbGB/BzGFlAhnCwMUpABP5HcDw361FhD1oI8OCZvMz
 9Uvu63/xbuKfF9bDdFhUVFth+5m/MYwMuzf9+/CpepHURcm3My963Uz6c11KUOe0342F78Ien54
 szwoA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d02efa3e4b0a8ce2355d4efbd82beebe
X-AntiAbuse: ID - d02efa3e4b0a8ce2355d4efbd82beebe
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVFnC-0000000A07n-2Cfn-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TPS65219 is a family of fixed-function PMICs for which the output
configuration is determined by the part number. For this reason, usage
during the SPL phase is unlikely.

Add a SPL-specific option for the drivers of the TPS65219 itself and its
regulators, to allow its exclusion during the SPL build. Since none of
the supported platforms that have this PMIC onboard modifies its
configuration during SPL, default it to N.

This fixes boot hangs on the boards compiling this driver but that don't
have the regulators sub-node marked as bootph-all; since commit
607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
this absence was leading to a silent boot failure.

Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
the same configs, so it's affected as well.

Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/power/pmic/Kconfig       | 7 +++++++
 drivers/power/pmic/Makefile      | 2 +-
 drivers/power/regulator/Kconfig  | 9 +++++++++
 drivers/power/regulator/Makefile | 2 +-
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 95687d0bdfdd..25cde40eaaf3 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -440,6 +440,13 @@ config PMIC_TPS65219
 	  The TPS65219 is a PMIC containing a bunch of SMPS & LDOs.
 	  This driver binds the pmic children.
 
+config SPL_PMIC_TPS65219
+	bool "Enable driver for Texas Instruments TPS65219 PMIC in SPL"
+	depends on SPL_DM_PMIC
+	help
+	  The TPS65219 is a PMIC containing a bunch of SMPS & LDOs.
+	  This driver binds the pmic children in SPL.
+
 config PMIC_RAA215300
 	bool "Renesas RAA215300 PMIC driver"
 	depends on DM_PMIC
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index da9b810de90a..36b197c7e956 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_$(PHASE_)PMIC_LP87565) += lp87565.o
 obj-$(CONFIG_PMIC_SPACEMIT_P1) += pmic_spacemit_p1.o
 obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
-obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
+obj-$(CONFIG_$(PHASE_)PMIC_TPS65219) += tps65219.o
 obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index dbd24415cb5a..752420a87569 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -545,6 +545,15 @@ config DM_REGULATOR_TPS65219
 	  TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs.
 	  The driver implements get/set api for value and enable.
 
+config SPL_DM_REGULATOR_TPS65219
+	bool "Enable driver for TPS65219 PMIC regulators in SPL"
+	depends on SPL_DM_REGULATOR && SPL_PMIC_TPS65219
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR TPS65219 and the family of TPS65219 PMICs.
+	  TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs.
+	  The driver implements get/set api for value and enable.
+
 config REGULATOR_RZG2L_USBPHY
 	bool "Enable driver for RZ/G2L USB PHY VBUS supply"
 	depends on DM_REGULATOR
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index bfe3349e3e5d..300a2c9d8cd1 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_$(PHASE_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_ANATOP) += anatop_regulator.o
-obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6357) += mt6357_regulator.o

-- 
2.56.1

