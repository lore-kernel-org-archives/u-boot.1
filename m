Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A319CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF37C8484F;
	Mon,  8 Jun 2026 15:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OQERtepX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CF884704; Mon,  8 Jun 2026 12:34:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3812A846A7
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 12:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0303244232;
 Mon,  8 Jun 2026 10:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9393C4AF0E;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780914840;
 bh=S32Sbu1IkHpL8PnopdzXIACfseTAz+tV1tEaLC9bLn4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OQERtepXxnABUpnh1YR5ilws/p4b76IG0373R/AEoVGTv4TUOMPxEpHXV6r14pzfT
 mWcSJxKw7k0rkMevwUL9AWoWyfVoNT1b4VdfDIPGibapht4MubaqWv0QlCKpXh+9xh
 cNi9R9XVp4MQu22D1tg4JDL+vRFmI/6EV8ebyuwG7N1OsAv6krky2rmuUAvCYTMxt/
 pAWc8WM0wQlxszp2D65dPiYBhSI19xt91MOXoOYkra+J/aja0GRLoqT/XJg2FaOFqI
 c1hxPMbprYNEI2yGZXGfI0K+9YEp+IcnHleKDrNVmCJLujYpTy71+hxVd/6sX0snhr
 ObpR/2L3DYgBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8F26CD8CA7;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Mon, 08 Jun 2026 13:33:26 +0300
Subject: [PATCH v3 2/5] ufs: Add flags according
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ufs_tool2-v3-2-a9f181e86229@mobileye.com>
References: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
In-Reply-To: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=726;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=/w2PkHnQPmuBGriJVqFAGn8l0ypJLuh/dA3UCYxJEc8=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJpqV0+rbusA21eQNSPdnAXwB0MLAuBvP1rbvL
 QVg0OVAWxyJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiaalQAKCRCfmumUluiO
 ObmYD/9sZ+2vawYxYFUHN5SrIBeqGb57WIOcE4vj/VEB/H7Qd5HPMWpR8PqcxtVkupYSXI4StX0
 hsiNR0jkKqAA+peNmicG8C8A6Ghytkh6z1/Vu25v2Re920S6iFd0F/KGA+YcA30xfaok1AsDWLA
 wIGC2OO8EBf4Gm1VCx/4JcgxKLJ4pUsJhNSqKU/2JrXgfZs3Byd0c5hV2LzzTHKPn+8nSvIVkyn
 9XDk508RB3aPvjfshVBjB+v8MOKtip3K9/6pGydsytJhKfDiG9z3SV8cVsbbRHSLwskmUSWA2DW
 hQb/JRxDtHRIND2RZoep4Z29xCthJ1ZXIYTeTSlhj2Z50be4keA0ueN8D+zIzp0x09DAbFAx+8e
 3KXWzCbrqtzTD7Vo0n+kEsAACdHpP28lt0731y2THEyk42lkOCHanzfCvgIOWpeJMDlxPsjb6BX
 ZRgSZ2l2ugK8RbYmnqGc7SosncLK8xaK4WHuP453sMj3i36AXOPcGKqghhHUlN7SQKa5Dieh4W4
 g67lp3pzGI8CFmJqrq4kpHd5amL/guEcVVzyLcx6ol8NVOWSPuMggfnDDAmmJ6VofUF6Ikplv5q
 CFonULNMhg87IteWsINZoq0DA2NOq4d3RvNECKYIc0DELBATBPk/Cq2roD6ToVeyVAxDfSrQ5rg
 H87aYH5JWxXErYw==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:23 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

Some flags are missing according to UFS 3.1

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 213b489e5e4..75b7ff83155 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -218,6 +218,9 @@ enum flag_idn {
 	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
 	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
 	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
+	QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
 };
 
 /* Attribute idn for Query requests */

-- 
2.43.0


