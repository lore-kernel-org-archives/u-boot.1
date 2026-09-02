Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB7EC624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3513A60874;
	Wed,  2 Sep 2026 10:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gm4XFtJfjoev; Wed,  2 Sep 2026 10:31:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788345119;
	bh=MyEJld8VBpO6HYRVKSsGsQS56AnjY0hqZ3b+3zVo2ac=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tBFX4yIL3VD6N+hIzKW/8qmtVjHxE2n2W4tzEYLAnOfe/4kNc93OxaKQ82GsUbrA7
	 KZz93U4bazX1Zid8dLdjoxh8HHVn6XRlGq58ro17hq50wnEiYb5rfQEs4kZOrKYV+n
	 9Q/wljiUTirmDsuS0tCpgDihPJU8JnNNCE7Fxx/oGhZJaGIrLrB22iDwXzjp1PBI4N
	 LcYMqfJOX+KxuZIeeXLpwLAHe1fYg7uCRrp9LNFvUhBGrZd1dR3LcZsUl/yBXGRJlb
	 /do/SiB61N5d+ggxTLBw0xiDKOpYmnwhYR0xF6EsoIRze1qzLof0lFg2Qom0FZSH8P
	 vDluxoyjze5IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0742B60823;
	Wed,  2 Sep 2026 10:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A1BB127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27C3D4031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8_5eiCV88r5 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:26:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=mcpratt@pm.me; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=TJVYZre9
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EF4840310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1788337501; x=1788596701;
 bh=MyEJld8VBpO6HYRVKSsGsQS56AnjY0hqZ3b+3zVo2ac=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=TJVYZre9F4gX5aTIzK5oBJAKiCwMm5dkhQ2PuF+JOiFrjDs6JbUIWOT3ij4d3Yh0q
 0rl1xhCSMHMU7RsptWAYiB2s1ahUHNtz6hBQoFGtkWxJ31x6eza41PkeD7886X/Uvp
 ohh1p2ofj/VAP3jpD37JKIPRKBB6l4UnDJBV48+Oyq3d9vITUnZjaEzPfmvDO4b681
 UHpkuCrySWMMIip4P2xUi9dBrjUMVRli/17OJMWp05Y4DUL/Dn/SRaMyeTCEvd5EAJ
 7bbsS8Vp+0rmGVfWLjHaVhyuZl4rAa4k97Na9mz0uD9lCinMDohV2fAKds3MA8Lzmd
 AVcwt4d3Y7pZA==
Date: Wed, 02 Sep 2026 08:24:57 +0000
To: u-boot@lists.u-boot-project.org
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C. Pratt" <mcpratt@pm.me>, Tom Rini <trini@konsulko.com>,
 =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [RESEND PATCH] fw_env: allow detection of NVMEM device using layout
 node compatible string
Message-ID: <20260902082439.20547-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 7bed9457a6386b7d8d99d7dd34b0ead557a87b21
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Sep 2026 10:31:56 +0000
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
it is very common within devicetree to have the compatible string "u-boot,e=
nv"
in the nested nvmem-layout node instead of the parent partition node.

This allows u-boot tools to detect the u-boot environment on a
partition that is also using the layout driver for NVMEM cells.

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


