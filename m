Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613E1C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22C8D80CAE;
	Mon, 27 Jul 2026 07:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qx-9YYx9WN97; Mon, 27 Jul 2026 07:00:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4657D80C97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135612;
	bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPtnOnn4gwkBbxbTtBtLFWq1F5gkVjdxQnzKnbkoBi9av9WBrYGfX+NCfsoDZmOGm
	 kyHKMOSNy4WgJbubd+ohuMye/trJE5uSyvizQ/7LuJHthv58Olzvro51LrzrpNfxlO
	 G4iwDZU95+8eIlx7u4pd163mp2VFEC2USRRJLG8IV4PJrLCF7QSEoFBFJpXzWf74PZ
	 RtSb0VtiiEOxjNUm92rYnrFd8arA4rJpJMCm12TkzA8TIGvHX4MIgdcfBdQ7XL9qbD
	 Z9zmydWoepurShe6QqStVIt+HhjyGvhBLjftWGouJOjfoOnzox2xUU2G+JM38F+NWk
	 d5RRyM1A/Pm1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4657D80C97;
	Mon, 27 Jul 2026 07:00:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E13F269
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D33B840621
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggI7sjCgTkgp for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:00:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BBBE4061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BBBE4061D
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BBBE4061D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:10 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cacf197759so34079715ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135609; x=1785740409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=V+1JV4rRSY5O7WKWAU1SMeP6Hoz6mD8fIGc5VGqVdFHZaXq4Db/lNB6F42CBlArTe1
 wGvXulEHzJxxnwXm1DKWD8aGANZCmxtyGz61gYOj/lKhB6mF/0YGSyQF10mZ7rVOO3JX
 1NiMblqolmyE9h2OsxbEBjQAQX/uU1o6N6QWlTXVgHCwk9MT1FIC95VxB+vyHaHTJj9E
 /RoLIFGqiYQnozLjH72lxmyFU3pWKpw90219qi5izWH/bQt3lY8CwybCa9d+jxJmXn2I
 imiGHdoqIzsFsCfnIVHgeltHEHTsw2lN+oXUoOaOUgaK+G5Lf2btMhFJ8TgZ76rnQqCr
 mpaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/LMNNLbsfuFSGdEIBg3HxVkQeUJL+5QHfY2FRWLWpa6AWDSAI+o4wyKf1bSMTcuLkm35JKlE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxMRx46glyYj6/JyNjwnDwupAYUZCovhlp7JJkgA4fGi94lmXi+
 KP+cW6iTTUN2FFk1XYsWJOh3v32a9VXLA6MhP01AH+7frxB7b9kQp6v+8ppNPfhAuwk=
X-Gm-Gg: AR+sD10up/PstOMLFY2nLIoF+mzHGAfrDhNVpX99ZWIajWWoXj1dfpBXzy6MxiAmWCj
 L+M9kxPFL+E0k0RGvWG2umc74cS1qFgMyas9XswftV0qQ/h2V8HkYC9ED8oE3z0on24QBxE8i+a
 3WUzXpCsoStFldK5/QHxAcWzsvNZA/BIYUbqhpcp1TKDFMrZwQE9Xy9LGfLYZm0DchlZD/rqU3q
 ILttp4blMKD1+ldLzIZ+h6cPodOGpuGsAsIMlG98Q4IRmloPzDv742Dw60dS1FXq69Nw2eWrZjm
 G1IB+56zn2pPwVviXsRI56K7tXhsjA28TwXgZ9+CZb0VAGIN3v3p2jMS6jFS08cqZqth3W/smuR
 cTEnPyNRCSutwigkO2kV2zfdJ+doHcJJUC0UnHpKOK79gdOkKcIZZc1BMveMtOq4E0L+QpuzQFf
 Fm1agWGyy4p8/jeW7CbUzxGGrQ2qXMlks+pO9Oga2OAkwLJF6vEeJWUHktnjaCJVcN4w5/5ryxX
 t8HMjzlbFCasqD8//5rAQqW8LMwaiAyP5NiTrxFiWM=
X-Received: by 2002:a05:6a20:d50b:b0:3c0:9c1b:d0bf with SMTP id
 adf61e73a8af0-3c67e0b1d30mr7250928637.74.1785135609392; 
 Mon, 27 Jul 2026 00:00:09 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.27.00.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:00:08 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:10 +0800
Subject: [PATCH v6 08/11] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-8-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135609; x=1785740409;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=V3tTbVHMkZCPj8tRjedeERR6eOCn+h+RHv+pSPCunYowyk/QX3WEEQMl2t5dOZdCmL
 m65hbRn6fs6gNUaf64UD6jYLBT0OeX365co/D8QIICch6bOOf71wtkH/yhl641dG92Pg
 N+jTzcrnU+FHiyCCmFSRI7IWGNYt8ui+L0zM0zPjSokHzvwVAI4+bQGTTLpUQD0nc0Ln
 JW1DtTEFAN/sYNAEQhlnGKT8hvh4AVJefxOIS8KZNqSBucsxKJClcinUWttmg1r18L9/
 H6I+gMmVvWv0XHENcZW6TbnEppWZWzDffgUvhKeA6W1IFpWLuLnrlpbrH2ZADA5W83YM
 xMDQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=V3tTbVHM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Update the maintainer for Spacemit K1 from Guodong to Eric.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index ca994e2a1fb..4b2bc4ecfc1 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi

-- 
2.51.0

