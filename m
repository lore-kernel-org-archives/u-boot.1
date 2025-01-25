Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7401C0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 19:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A51B80EC0;
	Sat, 25 Jan 2025 20:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ODTQE4SZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E9780C7E; Sat, 25 Jan 2025 20:59:34 +0100 (CET)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C661880F1C
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737835171; x=1738094371;
 bh=1b/dZBl6R1D4vGiij+fndcPTjzCeyOnjCCB8WWTyWLs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=ODTQE4SZY68YhSksXmMbvtMtZils4I60fa6ddXReSh2+I+Jq7afUlUgXYvnMYSglu
 Fyz0AGpVSpjsBoMApgX84Tqb67lb3cpn8bNdM98Sl/qF/KOA0xxsKaYgSqb4p1BkNq
 VXb2hhYhpjWSecXz4ivV/mYbeU83/GHySzetIkAuVJAc8uTB/y5LyZehnVm8f43xLm
 93pK4cOstcK8B5zaNJoSEZnIbssHmZBkkStZ9doTW5P59AXaTSJSmkvzjwTFwXBiHd
 4t9KD2YOsCmW8h7B3uISTrPrjFh19or/nvwo5pRs80I70cQNbJ3IjELWuIz+7Ozjcj
 ZkMt70PrScbaw==
Date: Sat, 25 Jan 2025 19:59:27 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 3/3] qcom_defconfig: enable SYSRESET_QCOM_PSHOLD
Message-ID: <20250125-msm8916-sysreset-v1-3-62073932ff0e@samcday.com>
In-Reply-To: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
References: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 82e0fd6d82d47ec1829c993e5de0464e56032c8f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

MSM8916 devices use this instead of PSCI.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d19be69190da4e2ddfbb60c4d44ff793e804c523..8392a5de90f1a9639d27aac2e3f=
ecdd2d4b62c59 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -121,6 +121,7 @@ CONFIG_SYSINFO=3Dy
 CONFIG_SYSINFO_SMBIOS=3Dy
 CONFIG_SYSRESET=3Dy
 CONFIG_SYSRESET_PSCI=3Dy
+CONFIG_SYSRESET_QCOM_PSHOLD=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
 CONFIG_USB_XHCI_DWC3=3Dy

--=20
2.47.1


