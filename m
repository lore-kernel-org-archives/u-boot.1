Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497C9CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4E9838D7;
	Thu, 11 Jun 2026 14:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="leqhidFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C343846A7; Thu, 11 Jun 2026 09:49:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF5080087
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A0BB760098;
 Thu, 11 Jun 2026 07:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53EFAC2BCB0;
 Thu, 11 Jun 2026 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781164190;
 bh=Zwn7G7pC9YhoADb3OBYiel29QOqNm4BoiPDJjnajRqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=leqhidFQuG7F1MbPySgbSlx20auDrBkRoQzdbrqySqaf9JIH4QUw8NjYhZFUArfSn
 0GzF09Z1Jfb6O0vedbpME/xdpKVpxNzld0MJE/Fr1b/uQbch6gr0rGOhrD4+jsIjy1
 M2+kIHuhWKGOGJOAdT0R9l8PeqQy+lnfEYHZ59w1by1IX2s2OMmxvv6vwY446FYwv5
 HjjgA4j134V+FPmV8gKIhz7N6qnZUx/BfJ5ySG8QuiBmfz9Dy98KFHw+eG8ymPoB8d
 xkHxgEdFt+JOt4Bu/51MssidQVzrbCKJPw64wl3J2BncLwi9ni3VbPjuTdqQ+sTqWx
 Om1kQjm519aBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40B94CD98CC;
 Thu, 11 Jun 2026 07:49:50 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Thu, 11 Jun 2026 10:49:35 +0300
Subject: [PATCH v4 1/4] MAINTAINERS: Add myself to the list of UFS maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ufs_tool2-v4-1-a4de78bc2409@mobileye.com>
References: <20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com>
In-Reply-To: <20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com>
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
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqKmiaA1mUYQ6RoKhHxTR6dzZrxcJsr4PDpO+oV
 u87ZPxC5vWJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaipomgAKCRCfmumUluiO
 Oc39D/4oe9VZHLvp5vQvbOt+gzykH010C/NTZ93i7zvpyLeEhfwRUJsfjhGHhlvNnHam3bCSaeb
 QkVn/EdXjfhoSK32y2fjvdAOKCXRRdhwH+t/csEArHoKD9RTQQDNRiQT4bLgNLrfcxe//mj71YD
 jdK+M8Wvpi/PYQX837cGglCr4vy1+uIVV0LA91VJPwte28CUnLU/IoUGEt02tvzlPJc3l7IWO1L
 de/0b8baEttikyBU4AwrWtzxt/809dAdtPQnNLYcaZdUHtRqSIpSrm3MooQrvUZMebR5mLyf19h
 gF5fDBAE8MHGwGe/JotJltpozJI/OCzqJtTYcCAApO52TwS7AlSC055U4JSI5tf9hVHYhJ30VWn
 fkkHG0A2Lzfv0D6sEwngmmUHoSbb/URM0DsqyAdcXzvn1p/ZLymLXKsc/G+mKbeW6AIKGgtF0y2
 GPzreRDCBiEwnST+fI7gmM/itYomEHneLNi/5/j+aBxOtzfCFM6UEf/Pq7+B9wJ6r+BLU7B1Qwc
 7Hers3N/hZ6DL8XkVyBcXuY1K0I15GmAiXIk8pnjKJ+g6UM7Hv/4kkzFSJvKMocc2kUZnHg/EFf
 RQ1iwMsNoo8WgZTswkFL5l5l5i6dcICwiORPNYdxxQurLAazkZmYJinPwVi8uTNzAxCgv5HG1db
 bw6697pgTRyLeCA==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:43:48 +0200
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


