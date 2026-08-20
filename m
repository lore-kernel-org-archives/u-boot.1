Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00846C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 23:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD79D40840;
	Thu, 20 Aug 2026 23:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kct5c3ntkBIH; Thu, 20 Aug 2026 23:37:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787269032;
	bh=vASaLr7aLIeXhlETqsbYVvGMZ3NMzbu3eO4v6k0E8r8=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nfb9CR/B1c3iqWoPyF5TP73fG94JwCdlFiNV0VMm1z1lOAwDFwiOUc8kmpV395eWs
	 whe2DXPl3ihDewahD945CU609g3w9f5YPhx4fmS8VoXofo45FTPlz0d7dLQmwiqCOw
	 yipLUermeSrlsgsyeUEGFZIzghodJxRlqqR9EP7FBylH7Zl28bjpxjmIBcMIQQlBT5
	 fXCFms/oZF3FiC0pccwDLjFNq62QwmSgcJ7mSP5w/EUIYFbmP6+E5CDP3+MQgH+7lv
	 /T4Usf1jFuSIBh7mYXwW+ru7IKaE7i7oTwOVNP5gJgzwFrVE1xKqXhWv4N36qSDppY
	 Hfb6dFWPmmEaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD914081E;
	Thu, 20 Aug 2026 23:37:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF419336
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 23:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D92C0607A5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 23:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5lezdsM8YR1 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 23:09:14 +0000 (UTC)
X-Greylist: delayed 494 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 23:09:13 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=RZp1k6Ey
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.105;
 helo=mail-244105.protonmail.ch; envelope-from=mcpratt@pm.me;
 receiver=<UNKNOWN> 
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA8DF60779
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1787266843; x=1787526043;
 bh=vASaLr7aLIeXhlETqsbYVvGMZ3NMzbu3eO4v6k0E8r8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=RZp1k6EyFGtGhmZ4JZe1Hw5G3Rxf8F5YkYQiYrEwNmFXloHM0s0ohYwKnKPVSe3q9
 aXFW1SZMvD4rAaSAwijKHO6AmrSX6ox90lF9Fs44MEa5GGxHS5cogqzOu7kBbkBdnd
 GaYjBHsJ1gUr1z3WQ2yJgWvfkYKrmPu77Q8OjCR48od//1EABimA6/U60Z067hrH+Y
 evKE4OSmPWQTo82dbkvstty+0KusfyMVArNPSCzW4PssXlEnYQfK5P+jDefAIgfRHy
 xFKKs1s0CNUU6jOB0dWuNn8Ecyu8oqFtKsJoyr6W9mkKOu0s3ZCJjb0WIN1Hy3E8Hy
 vfijNYvAm4iYA==
Date: Thu, 20 Aug 2026 23:00:39 +0000
To: u-boot@lists.u-boot-project.org
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C. Pratt" <mcpratt@pm.me>, Tom Rini <trini@konsulko.com>,
 =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] fw_env: allow detection of NVMEM device using layout node
 compatible string
Message-ID: <20260820230006.17534-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: f8b57941ab97bc158bd9cfc79f30007e50449f0c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 23:37:11 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Ever since the transition from a separate NVMEM driver to the layout driver
in Linux commit 5f15811286af ("nvmem: layouts: add U-Boot env layout"),
it is very common within DTS to have the compatible string "u-boot,env"
in the nested nvmem-layout node instead of the parent partition node.

This allows u-boot tools to detect the u-boot environment on a
partition that is also using the layout driver for an NVMEM cell.

Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
---
 tools/env/fw_env.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 49a068d91cc..8810b0e94dc 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1737,7 +1737,14 @@ static int find_nvmem_device(void)
=20
 =09=09fp =3D fopen(comp, "r");
 =09=09if (!fp) {
-=09=09=09continue;
+=09=09=09bytes =3D snprintf(comp, sizeof(comp), "%s/%s/of_node/nvmem-layou=
t/compatible",
+=09=09=09=09=09 path, dent->d_name);
+=09=09=09if (bytes < 0 || bytes =3D=3D sizeof(comp))
+=09=09=09=09continue;
+
+=09=09=09fp =3D fopen(comp, "r");
+=09=09=09if (!fp)
+=09=09=09=09continue;
 =09=09}
=20
 =09=09if (fstat(fileno(fp), &s)) {
--=20
2.30.2


