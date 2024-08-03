Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451CC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 12:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C4C88C50;
	Sat,  3 Aug 2024 14:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Cp7WmMBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E90D88702; Sat,  3 Aug 2024 14:42:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D1788753
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 14:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c82d=PD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722688919; bh=FGisq43uJQmYnx3cqUi/dCLlIaN74WWLuTyOYse02qg=;
 b=Cp7WmMBL1VkpRDK98cpZj+ux6BL7tVQWIP8P7w2wWU9pjmpcaKiFFI9H+hms5RHKF8Xy9tSPE
 BDs1ikFZEhr5I2Y3T4VChrry5dpdD+bRR90ZgUPZwDIOSahYvevFqofD3I8LIEF6lATZvnPytPz
 gybN5tgMvmZvZd9X/Ce6OaqjCB7aYcuu/Bk9TrbaGdGldxfB+Ule5L71omtoQ0jsWp2vPnqk0dZ
 2I0DXIvUT7diRNu9/kg2QOUUy3DaRHabrs97zaCnUDkFwf0bHM2sDzcbMKD+juSvAHD34saimmm
 cprtnkX6PWi1C/3Prq0BbJE8Nxo3Su30KlUrp7x245Qg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] bootstage: Fix unstash of records from SPL
Date: Sat,  3 Aug 2024 12:41:44 +0000
Message-ID: <20240803124149.2916030-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803124149.2916030-1-jonas@kwiboo.se>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ae2594c2f14e5c6aed0267
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

The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
for all") changed a bootstage unstash call to bootstage stash, this
has resulted in bootstage records stashed in SPL no longer get unstaged
in U-Boot proper. Fix this by changing back to a unstage call.

Fixes: b81e31a1e6c5 ("bootstash: Do not provide a default address for all")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 21a8944e2b0f..0b017ee12a7c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -804,7 +804,7 @@ static int initf_bootstage(void)
 	if (ret)
 		return ret;
 	if (from_spl) {
-		ret = bootstage_stash_default();
+		ret = bootstage_unstash_default();
 		if (ret && ret != -ENOENT) {
 			debug("Failed to unstash bootstage: err=%d\n", ret);
 			return ret;
-- 
2.45.2

