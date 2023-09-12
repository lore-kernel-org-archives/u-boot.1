Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E43CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB1286E79;
	Tue, 12 Sep 2023 11:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jzbE4edp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A371586E2F; Tue, 12 Sep 2023 11:47:39 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 99CF486E4A
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0F23B212BC1E;
 Tue, 12 Sep 2023 02:47:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F23B212BC1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512053;
 bh=v6qLb4eeikYA/sTep8mDsgPvdEuKoKxPl/+g1uuYLnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jzbE4edp1UoErQntfHPTueOAwefc7etup/jvI0Cu8YUvw/DMjsVXbWxV3qYdrtjxI
 KmN736zXUR8OZpai+PkM3CpIzw+lKf67ToJHnX1erJWhEjDXQPVBMwZ2j9Vx9MgQgw
 jBoUj0JSiH5gahoR1lg9I4r4G0XH6/duvoQRh/k4=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 7/8] sandbox: tpm: Fix TPM2_CC_NV_DEFINE_SPACE command
Date: Tue, 12 Sep 2023 02:47:30 -0700
Message-Id: <20230912094731.51413-8-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

The TPM 2.0 command reference shows "auth" (type TPM2B_AUTH) before
"publicInfo" (type TPM2B_NV_PUBLIC).

The TPM v2 driver was updated to add this field.  The sandbox driver
needs to be updated to match the driver implementation.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 drivers/tpm/tpm2_tis_sandbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index e4004cfcca..3e38d28637 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -758,8 +758,10 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 		break;
 	}
 	case TPM2_CC_NV_DEFINE_SPACE: {
-		int policy_size, index, seq;
+		int policy_size, auth_size, index, seq;
 
+		auth_size = get_unaligned_be16(sent);
+		sent += 2 + auth_size;
 		policy_size = get_unaligned_be16(sent + 12);
 		index = get_unaligned_be32(sent + 2);
 		sent += 14 + policy_size;
-- 
2.40.0

