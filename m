Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECA2C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B981288806;
	Tue, 11 Jun 2024 23:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="G80HJ4wN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCHVerKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C75887FE; Tue, 11 Jun 2024 23:04:53 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7223E8839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.west.internal (Postfix) with ESMTP id 7084C1C0009E;
 Tue, 11 Jun 2024 17:04:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 11 Jun 2024 17:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139889;
 x=1718226289; bh=97qREvBt2vuI+jwiq86tA33W+TAyOQxqC2PhOjDN1OE=; b=
 G80HJ4wNzUtruEfj9LHk1hzE9wYVePZuA329FPskU5D9ks9ayumHLFu4dZWpbEqX
 OFsa3jxdCDtdccR6rzm+3aIRryIpW4/K6cIqW+iYBDxcKLxYwS4yp0FVbcjxou2w
 9FarJ46wH83VS6BU12qd0C0bfP04XXLgyZYSmUXLVAdUMUN5UUIsJjjTrp5EvTm/
 FsifvzumIvWHVebG1GBoeGAQ2Y+xY+vCEsEC9rOvB3hSnYUb9miiB16Fp9pOCnDn
 GLihdF7eiITW2JIFgj+q5ykFwlljTh8pXwBEpN2qonEGpMp72UZJhXJ0iAQKCR+x
 A7bqksaoFZWpSDA6upslng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139889; x=
 1718226289; bh=97qREvBt2vuI+jwiq86tA33W+TAyOQxqC2PhOjDN1OE=; b=N
 CHVerKf55rZc4V0ykWk3lGWr+NqzjosLPLcdRKm9W9nZKEs8P1kdJF5cAXeHRi+z
 M8Rqwl+jzXRe8p/JJ5LU0JDIa4pa1dDiity/2pW7LpZyszZLNe3ktFenpop4i0DC
 CnPj420yaLExlYN5X7VBGOKlWND0sA4pMx176a+YqyXG8Xjzzd3vQTZ/iOHSERfg
 lEhiTWMawC7VQZqhxnLuxAVgO0csHk+T7o5mUi3Sa657Ym27whiNhhvyQxAasscm
 lMoJtEK7UDJCsKh+07BhIw4aHmhLfvRpByvpROFHKMFlyKz0DCv879/6884oQBne
 tPRM3Z9VPzSabC+gKWsKg==
X-ME-Sender: <xms:8LtoZk2pC4geMzFn9IjMJiyMuHxCI93Rrl-Fu-DCxfADaQ8Rp7CWBg>
 <xme:8LtoZvFfBIh6NxB4pMBGuVhHAJOevu0AsBH-_KGehYrFt4YaOPuVzAN8jPHFJg13d
 mz2mgtW3l2CFuD9S6U>
X-ME-Received: <xmr:8LtoZs63mz-KYl_04PxvW0mWcVaFVRuNBOBFbex0M7j0f62J7hN-qBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:8LtoZt3CO1d7tBvexNizFE5AH7gerqWi8mt2Wz5bjPyAHJlJb6S9fQ>
 <xmx:8LtoZnFKhFv9tQl2RIl4G_5r_UaEpbP6MxI-mnEtz5N0bxlBUr9ffA>
 <xmx:8LtoZm_UR_H502ebWphaBrmsC9SOcU7qYAAooHxsYN40LBgT-E9E7Q>
 <xmx:8LtoZsm-Ys8sQhWVaUwlKlPto0kzrF_F3PhmeJtRB_e5MRYQjCQTsA>
 <xmx:8btoZtYvAB9NGTFMUDrXb1OcT3g68dKuJtSTMUmCec6zwYqegu3o4o-n>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:13 +0100
Subject: [PATCH 14/20] CI: GitLab: Split build_world tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=UkjQgVWGvQQLsSPUIz/RlBoMzN/W10SQ59ZmZqO2Ez0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WdnvvtzYeYDGYU5jfKmX6sVtPgFTlw0Whbaxdf4w
 lhXILK8o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZivZ6R4XXxw2m8fdK3p9w/
 9zjvX9NUwSKPOQ0Xl0Wvu8bWf0FmYgkjw5xWN/GjgVdspwsslb2bnuN/WWqJ1p4rx1w3v1uVxiq
 9lB0A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Current build_world task runs for too long on public gitlab
runner.

Split the job as what we've done to azure pipeline.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4c17abea468a..efb84c3b119f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -91,56 +91,71 @@ stages:
       - "*.css"
     expire_in: 1 week
 
-.world_build:
+.world_build_template: &world_build_dfn
   stage: world build
   rules:
     - when: always
-
-build all 32bit ARM platforms:
-  extends: .world_build
-  script:
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-build all 64bit ARM platforms:
-  extends: .world_build
-  script:
-    - virtualenv -p /usr/bin/python3 /tmp/venv
-    - . /tmp/venv/bin/activate
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-build all PowerPC platforms:
-  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -P -E -W powerpc || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-build all other platforms:
-  extends: .world_build
-  script:
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
+      if [[ "${BUILDMAN}" != "" ]]; then
+          ret=0;
+          tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
+          if [[ $ret -ne 0 ]]; then
+              tools/buildman/buildman -o /tmp -seP ${BUILDMAN};
+              exit $ret;
+          fi;
+      fi
+
+am33xx_at91_kirkwood_mvebu_omap:
+  variables:
+    BUILDMAN: "am33xx at91_kirkwood mvebu omap -x siemens"
+  <<: *world_build_dfn
+
+amlogic_bcm_boundary_engicam_siemens_technexion_oradex:
+  variables:
+    BUILDMAN: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
+  <<: *world_build_dfn
+
+arm_nxp_minus_imx:
+  variables:
+    BUILDMAN: "freescale -x powerpc,m68k,imx,mx"
+  <<: *world_build_dfn
+
+imx:
+  variables:
+    BUILDMAN: "mx imx -x boundary,engicam,technexion,toradex"
+  <<: *world_build_dfn
+
+rk:
+  variables:
+    BUILDMAN: "rk"
+  <<: *world_build_dfn
+
+sunxi:
+  variables:
+    BUILDMAN: "sunxi"
+  <<: *world_build_dfn
+
+powerpc:
+  variables:
+    BUILDMAN: "powerpc"
+  <<: *world_build_dfn
+
+arm_catch_all:
+  variables:
+    BUILDMAN: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
+  <<: *world_build_dfn
+
+aarch64_catch_all:
+  variables:
+    BUILDMAN: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
+  <<: *world_build_dfn
+
+everything_but_arm_and_powerpc:
+  variables:
+    BUILDMAN: "-x arm,powerpc"
+  <<: *world_build_dfn
 
 .testsuites:
   stage: testsuites

-- 
2.43.0

