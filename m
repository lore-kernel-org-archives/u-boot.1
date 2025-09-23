Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F97CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 07:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A298E83443;
	Tue, 23 Sep 2025 09:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="uI34oe7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA73A8349B; Tue, 23 Sep 2025 09:14:11 +0200 (CEST)
Received: from outbound.st.icloud.com
 (p-east2-cluster6-host11-snip4-6.eps.apple.com [57.103.76.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D296E83443
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 8B3341800615; Tue, 23 Sep 2025 07:14:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=+C2dT+rXOYTxTJ4lJxTKkdLpdqC9U9+DlVqaPrUfEKU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=uI34oe7TljgHx3s9OgnrTEVl54WWDlcOz6YV9eMTiIaBnniekdc6LkpVJ9xokSrubJln1Bn4aLvqS9EWYI6q+Gy9gthDJlr5QqWyucrJhj3ZC+b4dyhK9hHijM4Ct7NGJhwAdC+JyU8vgFycaWEECpEUezRkAx046i4G3b5UPxizt3sYTsu77KddJ/sFH34WOfJbu52OAjnbOOqlnEhzfNArs+S5fyH1XH+bJWJHQgyia6wa8Y8aqYsG9h8eQvHBUdIZyhao2kHNG+LHFcG7sWiIBIIIgvuz772vFn1oI6ahx0+mBAv+yCtDyNosVRT2etygMtOwZ/zJwYf7JpoxYw==
mail-alias-created-date: 1549370554000
Received: from debian.. (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 5D0A41800608; Tue, 23 Sep 2025 07:14:07 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 2/4] doc: bindings: fix aquantia-phy.txt typo
Date: Tue, 23 Sep 2025 15:12:59 +0800
Message-ID: <20250923071315.276114-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923071315.276114-1-root@infi.wang>
References: <20250923071315.276114-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gti6wi_xWePpYll3tEfYctnLje8T1tF5
X-Proofpoint-ORIG-GUID: Gti6wi_xWePpYll3tEfYctnLje8T1tF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA2NiBTYWx0ZWRfXxz/I/0oHXO/d
 54gL37SBHD7Y/rOtO8imHzo8WkcvJBfY+rBHOYIIWOjM60EbLlu23plO/5DAReVhfqEyAYfDT9S
 OjjfBMd6KhEONluXKJtkw2faCaG0Jtd/YeTIC+iuAKzigZfYD8lNaGFZ4u+eYgxmRWOZvtmjL02
 HSJMAO+tJjrH4NWbeyLFv4d8VQPSPgLrkD1VJgzY7SNzd+cgsmLTjFxa0gZLvtwMo/2au5j+IlN
 7FKIvcsc4rlVGUHLtg8AFdsoPQEK2vMEv+enqf6rFLTXVN7KEjW5hM4QGIh5i//Rwva+aZRlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=929 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230066
X-JNJ: AAAAAAABh78x3qrUqqHD/peHLsuFDPCiWhfTtPCmEA0ZvqUgywvKJ1JMeJo+yi6i7Q2HMnlyWrGWJI58VJ+lj8JKllDN2fLZQI2pTSadqfXuHcurcjNnI3Xx+LXGKdjGG5RRH0arGbFc/8SZ8YQY9oIOkQ61RbFPMPc+MFIRE8UplTk68IZKuB0cdxilLSxWJ0MGFSp8op5gt0Yck1D2tDnSfbwvSsLz3v9p0ZZSxj9dZTNCruPRBA0l7wOGQmlO3c0YOUiOsxqgy2H9Wf4QOQEMOnHso70ccYRfWeim9PTo+MMbJ+SpwZxS3dy7PB4/CSg0FSTHiHpKlSbPaCBZ8TDgpnygymHq7LSNZQWkP9osxc8s7QV7EVVKPBcsF9t9HKsz2h+QJJPC5A40a5L/PqY7ZXg5n0+VO7ZPwhP/A5R44GfwG4PnG+u7QnN2tmod20snqFAOyT4EDeMvwOUWdeGuUw8a8XHB4rG1bGPuz6RorVL5CjQlBaF/jJeb+GYALJMKVomWSZL9IqLJACwM+/hOlEzI9P4jY2qA4fdo3ul0JeXyBDAskWmHSx8x68p6YTahV1ONLgJkIgC7+GrgAwqqDqC36ECYl6Zkhw==
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

Fix typo: "weays" -> "ways"

Signed-off-by: Beiyan Yun <root@infi.wang>
---

 doc/device-tree-bindings/net/aquantia-phy.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
index 89ce61e05bb..7dd3d45df12 100644
--- a/doc/device-tree-bindings/net/aquantia-phy.txt
+++ b/doc/device-tree-bindings/net/aquantia-phy.txt
@@ -4,7 +4,7 @@ This text describes properties that are applicable to Aquantia PHY nodes in
 addition to the bindings in phy.txt.
 
 Aquantia PHYs allow some flexibility in the way they are wired in a system,
-they allow MDI pins to be reversed, LEDs linked up in different weays, have an
+they allow MDI pins to be reversed, LEDs linked up in different ways, have an
 I2C slave interface that can be used for debug.  Normally the configuration
 corresponding to these is driven by the PHY firmware with the downside that
 a custom firmware is needed for each integration of a PHY.
-- 
2.47.3

