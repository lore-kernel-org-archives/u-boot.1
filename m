Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A425CCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE3684874;
	Mon,  8 Jun 2026 15:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uiZB19OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB19846A7; Mon,  8 Jun 2026 12:34:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5240784701
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 12:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 395F9445A8;
 Mon,  8 Jun 2026 10:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E480C4AF0E;
 Mon,  8 Jun 2026 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780914841;
 bh=Zwn7G7pC9YhoADb3OBYiel29QOqNm4BoiPDJjnajRqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=uiZB19OBatpZkJxOT0mVf172GAZqpEK6QFIcE5bmJ9Pf6HpLreAU4xC7YAwzU242v
 QA49LTelIeBezPUTWl4mXJ+RjaOqgHyVN2SeXzzbr87tTvQQ1uKfEnE75A5Mi3VpGC
 dxhfaYOYLvPsEWVsGCrCml7NMxmTtRf/lnXkx+mi+fw/j73ihf5hRxzaUSWBy+W6gx
 SVwiJmB+MqilqRpCA4ZjIK+vAhaVhHo+xvaoid8fyiaghYiFLw5r0nPvPjQD50WpyJ
 1lwnxKwTI0P1HBJvK7XMXfIFK9RSTzG5gg4Z4gy7/hUQ/m3vYFEUso7y9IF/xi7GqX
 K4KlivcvSmBDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 15F20CD8C9D;
 Mon,  8 Jun 2026 10:34:01 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Mon, 08 Jun 2026 13:33:29 +0300
Subject: [PATCH v3 5/5] MAINTAINERS: Add myself to the list of UFS maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ufs_tool2-v3-5-a9f181e86229@mobileye.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=610;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=Evo/xayXeA+xDd8mrRtcOpcBO0hiTU23xBCrmgriIpk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJpqW1bnCUMTvFfx8ii+6W2MYAw/eB5lqSspBY
 2phdCKs5/qJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiaalgAKCRCfmumUluiO
 OQmQEACtHxB1TfPueraOdSIpv4DCPBg/nxPo3VKyoQNF+/sFq+YYK5VYSvTQmuHxzfRzse3NL2Q
 jHtzcAFNHhBLCBsb1kQKXBj8ybiD3aCTDfNkcfTxnZ+feaP3iYeqZWjbFLupRL5Tg6N8Pr26RZE
 0iP1cToRDVBqBaXk4U6M4iiIwORcNU5OL6x0NfG7FRu7pGIrDRX1slvvmZodm7ZZCIqKEREEjLs
 lTP1aDamsFzEcVS42Kn8D9iUC7VE6PTQztT/SZeedCQQEBzlfI6WigNSdCYRs960uo5cWmhPxUl
 jJmfFTWbwPbqE8nSMW6jke2GlGY+OJJJKm/23hnW2xO0iydb2tJChxsmen1/I11DduLxHlimL5P
 Q7ro3IYQbVnStt7OUxPVXdLmdDmNJbA6rlDZWQKMmD0sLI2ebPVnSI/IUr7LfXXMLVCvgA6ZaC7
 3puWKMH1xCdbx0AS04Q4h7DZUGgC5Dpgke8xYU9+xMAa2WSoEUu1l9BKsrmDpiJ5jnmkyLPjE2q
 56RQXECORTyQgmbB8tgg50hNsonImhQdnyHn8W87V9y4SORFISu/wMOogum1hWYeSIp4PwEd2Ix
 xg4g2R4yKfpxsjbROi9bHkht0H+/hVUENwwFWlYfrZYrTvouBxMHVv/gjAPEChEmjIVTfNmTvZp
 6iX5nfV5bqa2xFQ==
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

    Adding myself to ufs.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..d2257a8327c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,8 +1920,11 @@ UFS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
+R:	Raz Ben Yehuda <raz.benyehuda@mobileye.com>
 S:	Maintained
+F:	cmd/ufs.c
 F:	common/spl/spl_ufs.c
+F:	doc/usage/cmd/ufs.rst
 F:	drivers/ufs/
 
 UPL

-- 
2.43.0


