Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD83ECD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0169984833;
	Wed, 17 Jun 2026 14:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dc9sgMKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA68584954; Wed, 17 Jun 2026 11:26:34 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA25484704
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 11:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 83FE9600AA;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5669AC2BCB0;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781688391;
 bh=Zwn7G7pC9YhoADb3OBYiel29QOqNm4BoiPDJjnajRqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Dc9sgMKoojs2QQllFMmLzH9My1kXbfCIupFDLbUXWJjx9zgH4PRBgZ4T74rk4ip4P
 WAzKUMP1irl+Nv4r4kL0Zfq1zRbWDz5cByGpEyNSjUIvmMnrp4oQC5vqGawvlyx8nF
 LkJcXrMQmCRmI20uYx8HH/rlakXQWW6Jh+O2FpGFEZKoK6dyzzUdIUUt9zDX8AWeLh
 bs3DqLcM5hV46ivty3Pzmd8Y4cjDXmYIybF27KYcDnzXCS9yknjdW5frxUojdhYhGH
 hbC7YmpYdLUfasQVTcS0yvQeRZJjALdTfd9sdsDz1tqvqqD500PirjLyjy4YIuHB+k
 7a1KC6KXcw7Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC2CD98F0;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Wed, 17 Jun 2026 12:26:13 +0300
Subject: [PATCH v5 1/5] MAINTAINERS: Add myself to the list of UFS maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ufs_tool2-v5-1-1cf099f71111@mobileye.com>
References: <20260617-ufs_tool2-v5-0-1cf099f71111@mobileye.com>
In-Reply-To: <20260617-ufs_tool2-v5-0-1cf099f71111@mobileye.com>
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
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqMmhDH38Ns4GFCf3W9saKMVL7FdVhrVa7Kx6mg
 zhbTvDAugqJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCajJoQwAKCRCfmumUluiO
 OT/TD/0TIT4gUz5fTvdMFUQ3hVCaAoTXNwjorkooXbriEdpT+KsmTlgll5IQyv/wRPc16XV1d9q
 ew/Lqoy5IjJgAURkpiXZ6812MiXqaqFRR9kY9pZaKY4M/nsKdkWBOtzzKmYVIw/53oUU28VMGOh
 8X4YMOGldErJ0sVCn+3vVis1/83TRNhXRfDYccLNree1upZEpGVNIxNTe6KohaHe1pa/Rgb+rqq
 +aTGHgHZKT9LjHeL2ii5H+3v/ei8oqnjfH/etqxEribUo5Zs9E+oAXnp37yqZRssRLRawJUH08m
 z7QRIK8SeE/EB9bWD0o0m+u7208NPJjZfVqWg/yntpdPVKZQpoq+u+n/IylQYozcPyJbckv3nvt
 qwjBpY4xKPXWIOzZZRZBCBjIynjTkp0UPTeZAE3+HGy0M+JxX8S3soHhro6sRwJaHYF2gk06qDq
 bGcMxn1wGb4ARkASigDfKt4gisQ2tMTt5LVBfdJdknEaXgb8SV1wZH5ZowYDt/JnQGgkB/XOILd
 XsXeAMLv20Pl7clSnALgwCw3Pj8SqsIMmF/3ATDyzqhNFaJSmsFSrfoM0ot2bqwfxlbknIj+aO5
 qeWIaICcz6CUBZJvnI20fice+QUUCZ/HSdmVwEoZr9xGBy7eAS3Ff0RDLO+yNCv38ooWvXUaADq
 lRTStuWyqLffoTw==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:29:55 +0200
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


