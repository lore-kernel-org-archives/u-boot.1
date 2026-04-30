Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06015CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922D483FB5;
	Thu, 30 Apr 2026 23:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="CuQ85OoV";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPIrJ7s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBDF84198; Thu, 30 Apr 2026 23:31:35 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A28D80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id E83641D0005D;
 Thu, 30 Apr 2026 17:31:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 17:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584691; x=1777671091; bh=fV
 7ND8lCfHA8AbXjobBXZpgI/7XRSoWskhFRK2TN6OQ=; b=CuQ85OoVLSrf/FwnQa
 U00eqMV91Sue7b683R8wF78Qd0L7NFFjO2fwS/f/oUHA1W0NnqB/asBQukB1T0lv
 tsTeUEXD1SgYeHUkjd75IqBCS0wozBgzWQeVc+TPLWvLodKubeSInU0gTU4TM1cA
 JFwZCzzIjq8L2jFfO9ze11OcktVpwJ3qcLoLU59BC7nZWuYskXZXa06cgN/vhMUs
 XMq77D5JmDQleqPNTgUF3fRThD50093jgLPg8aYAqspYTKa83ywIqITh4V6ZASwq
 Kqh8nnyvDz+p0AjspqMtk2+I7PaBFOjmNdsTqkwffS8E0cOSgcNz72Sbe3aWTXj/
 STtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584691; x=1777671091; bh=fV7ND8lCfHA8AbXjobBXZpgI/7XR
 SoWskhFRK2TN6OQ=; b=uPIrJ7s8A84ND20eB/XOAz/m+jmUlg1KKVEdSGI/H6Bu
 GO7nsGLdejegxm3V8GcP5+jvej9WN7oTflDCPSuuqIpNqBhMtd7nAafFcut+DNm/
 3k34P/f3cZJmN7e4iTMLq0/A67niWPVAEode1oUOlqcSDPAio5EskmZSS1km8dAG
 uP/sQnBQQMM8pb13CESLfjMawadchSa9bEIfXnEgZe0gOtr7jyOkLcr9+Ra4/2h2
 MNKGz27oh9aBuh411CXptSkoJKaLuFIls/4wIzBCN9Hk72ebHBnze3bF3dNKyFjC
 nJHgCGbiaJN25qWtqad/vRl1UWcqOQ4s0U68tTXO8Q==
X-ME-Sender: <xms:M8rzaaPfxMuoT53V1FNlvzojQOaeOWvSDFBsMkIhLeXsUOAfR1i6tg>
 <xme:M8rzaf2QMENb2QmIlVvMrtYFstuwUqnKDbXgpay80oLbTM1BZaDP6nwQyRBo0M4Jv
 1fEG03zdE1wlLfnQQlwIlEAUWrLyKIASi1kxniXXHe-3MwSWG4L_iw>
X-ME-Received: <xmr:M8rzaZmcP_DdbFJNDGUgG61GlxSphc4slZ8Vv3nYn6m2ImO6_wBdPrAO8G2-RrKFkZmUSiE-TIo0Idv68qdA8xzq0lpAusItq9v25A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
 ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghnghdrfhgrnhesnhigphdrtghomh
 dprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthho
 pehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkoh
 drtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:M8rzaWVNdAJNvKfmYhB5GP3SN0KmBSifz0tpvm_e4pTiGwro6yW9qg>
 <xmx:M8rzaftuP61Bm_PklOuz35_z4ri0shukjJhf56XwvEESR6UaebCK6A>
 <xmx:M8rzaZYcGL_TwBTYS4irMKkC2RQg4E1dA0NA-28e0tAuuwQUQpeKGw>
 <xmx:M8rzaeU3dMtnjtgVZT-A_OQaLvKLtgZZpriUCYMwQYa_4w2Az1Vrrw>
 <xmx:M8rzadl_bmbKGUCcUTVVdB0LY9fKM4pLGVbIWbnvQPEXo6Nue2fYGUqm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:31:30 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:31:28 +0200
Subject: [PATCH] power: domain: apple: Add "apple,t8103-pmgr-pwrstate"
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-compat-power-v1-1-0889d4334a7f@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gbqhyJeRVyEmmpAbWhFBfHuF
 pdvMfNA4iicoC8eiHxKkrBnVGUBbqF9ZpQpG2pTW9M2Bkl1ZXRhUzpQw8URyRny3lJn2UEONbK
 X+58O4/t+z0sYpWQAAAA=
X-Change-ID: 20260430-apple-compat-power-ac0aff6a86ec
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=mGfkA6M41rBOWCT8aBVHaVgpD11fUdRPgxMjkss+20o=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPpwxfBu+yiPknVyzy9MSv89UFkVZMbb9T36zdEt6+X
 mjnpz33OkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEzk9w9GhrW7vYPmqvHmsb/d
 97HQd5bvm1u2yjusNPXyMudwi0+98pfhf+oTpb7D+0x9s/NnppQYzWtZ+enX6wXX9+nz8b3sXiJ
 7ngEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,pmgr-pwrstate" anymore [1]. Use
"apple,t8103-pmgr-pwrstate" as base compatible as it is the SoC driver
and bindings were originally written for.
The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
compatible as fallback instead of "apple,pmgr-pwrstate".

Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/power/domain/apple-pmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/domain/apple-pmgr.c b/drivers/power/domain/apple-pmgr.c
index bf9940621ee..71fedb405da 100644
--- a/drivers/power/domain/apple-pmgr.c
+++ b/drivers/power/domain/apple-pmgr.c
@@ -110,6 +110,7 @@ static int apple_pmgr_of_xlate(struct power_domain *power_domain,
 }
 
 static const struct udevice_id apple_pmgr_ids[] = {
+	{ .compatible = "apple,t8103-pmgr-pwrstate" },
 	{ .compatible = "apple,pmgr-pwrstate" },
 	{ /* sentinel */ }
 };

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-apple-compat-power-ac0aff6a86ec

Best regards,
-- 
Janne Grunau <j@jannau.net>

