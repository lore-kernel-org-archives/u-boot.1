Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF502C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 564A340360;
	Wed, 16 Sep 2026 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yt7Hmby0tw7G; Wed, 16 Sep 2026 14:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B22F403E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789570642;
	b=OGpuIO4cC+P4RXZFExDIc9vi4v0XGf/RUntDs9eInwXifz9ywhGDP1DIXxUi0bFK7GXL
	 PDgTAvtEnSWBLe6pmUHUM31aM6vr09wxeLtvpW1Vv3EXCe3u/wiFaZfSgFni1i3vYGzsc
	 m+tITs/JPmSnCryhpWH0jh34IXma13X9ykkJ/WLHSI5mQlB4NtYZOI00ZNgA9RVmEgaQk
	 KvQFSb3g4j/nFLbqE7LImY5LHZygeVEeURpL9va+7t616pwm3FvtxohZkcsEmyQM2T7fy
	 6pjMSXf4TGOlMNfBPxGAB8NjciX2amjxOqmi4dQIaBMy4+V01k4vaOjAPgxZcR/4kEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789570642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0GeXK7UEmYgK2FovIV7TCPsFf5P5bJzE97+Emr7wGE8=;
	b=AUSJsRSur4nNvMGgwtDlNjCMiGcbjZAulbOFGvAPEWIw7Gaoh+gFIS+jV2NgG3AaUmvX
	 i8Y66wzIGxhwxDtcHxeEsmVyyy0LI071dAQ+q1p3ZL31N7DYeNXWRSQricd6crDH+smpl
	 cfhjl8jjwwTHscxCyW/uvYbc6b7YiCXvh5BAJkdXb6rhqwAQsyGT6QCl/1ozNjXMPilpX
	 hGJHjgQKp5qrkJsev6aV082EVtuFf46hwOWTLVJ1fqGLpPEZP4PgF6+DWv7am+VHlbYUF
	 QodWV2YlpzV9aLJW40qKAglS+mkXRkTcCW3uio0J0qpPKtsXY2t1NwK+Tod8M9rEJxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789570642;
	bh=0GeXK7UEmYgK2FovIV7TCPsFf5P5bJzE97+Emr7wGE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1IGW8yjL4OCAznoMqpZuEgbTtoP1p0VThVPE1RUEI8gSetG+sPqDvN6X1WYH8ET9B
	 WBKakfGJH+ymGNaDM5+zg1/scWP1BMGEzbej1NDok1QXsPMjy77digLxSeDoSzAoVD
	 0FkFOQnQPVNaW3EWOfArAhy4iT5qnyCfFPEwLW34KFnJVZLDpxhfovrCJEtyUSrXEq
	 p+URlvczwy7jhtJtJeK73jbrKrDJnLClpwRVV2r4LNK6X1gJb5IIW0cnOMStC4P6xp
	 CvwMC8vrJ44vtTG/jlusF9PINs4t1CsPQHoxhT/PNzOuOuaPagjjdvwODQwCBZCQuk
	 Icn4SLZlQLZJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B22F403E8;
	Wed, 16 Sep 2026 14:57:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3943CDD9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F6004030C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cGTNfA7c-wRu for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0408740083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789570635;
 b=R8dyViKZ1dpIDWmYtViC5TyCqxOJvVwlMNoG3dcnPsfj25rlwN0U6ll+n7WHtDVcy5mI
 IM5Jj0Pq63wAua8FfwGU94D+BHVkoXjBmnB5kEU3Nq8XXUGzbFs9pE0TOhtj7kPQVoARN
 z3rZvd3VdBIIfd86JvyU5ok4MTAAWIauMAszw7yWU56JydDxv8ECxJkqDtgtjUaXCgZbw
 6WeMcgsB0QyjGCRO4qb9zBQJW79+83xNTKJ6810nQXONVUd+vCJQbwTLrKWYpZr2Hl1jf
 FTU0fNuN5W59pa+gOKlIlUXrZhcazetCZix7euyQSXGnnXuE90v31lQ6nM1JHmFMBNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789570635;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=0GeXK7UEmYgK2FovIV7TCPsFf5P5bJzE97+Emr7wGE8=;
 b=J2bKpKZSkHh/Tv7Fehkca4Eiomm52YxHkcQkXTf51yHLyKjCwlnJn/YteJNF6OQtDRmg
 uyUi1ZREacEH2JR6fdAde6cLeJFyrvwEjHI7RWBSK2fe0G35cUZtS11vZvm8uLVVyhVA9
 XIppWeqQWp3r9qPLiseNVtOU2w7vdevY8gi1L4vBy3/Zkg6sFfgD/QYfhpwJ70zlnYg5A
 0Ovhw6LpPv+WhwlTfS2rwsnELWZQ3r592mUjS38CSYCTyg4/YzxFOZx4xy5f5ULDGktdd
 zeNg+jSjRJCsRAGQJF9afyxeFXOAjB84CMRPjm4xiJAtFFNe6kOTntioRffojfNQ88g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Yx0lDmN3; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Yx0lDmN3
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0408740083
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:13 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so7676495e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789570631; x=1790175431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GeXK7UEmYgK2FovIV7TCPsFf5P5bJzE97+Emr7wGE8=;
 b=Yx0lDmN3S1M5m6Q/y0p01YnYMHSIwWJMRBrLA5VXK+B/6E6vv7ldlYY6xKWo/86hsv
 v37mQeGBUbi0rJ+AZzkZAmdkm+1BGWnho/8B+IiPF0CEOMfx7C/dtVNHOc+AlNY0kvMx
 9A1FiVREAlzZFybmUgreD0Jx+13z6322hGc5sQUloOXpkZ1tfpO/vZIiyRDepTPuTPZz
 lmiV6upwOgutnxIIjKSd8Am2Ic7CHeOQMohUxCsOpqZti/hGPGT642PXv1zQRBt6vB4x
 Xnblmh6qqkly90U4VBCo4KT50uYIBqgdrIC5zQQydM0j8j+UgnUSkHGWBGdpcvnzn7VH
 aALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789570631; x=1790175431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0GeXK7UEmYgK2FovIV7TCPsFf5P5bJzE97+Emr7wGE8=;
 b=tMo1EzhvHwgNV+ZWa1ofNHzGm33gO6TlrGwLLSKnrsQuDx4h2N1R0d/P6vWew8uoT0
 Oh1E96FExmqUT0gqenzeTrlyNsyJQz2Lg+8LrWm6LyhsccZNShuqDkhDlNEbl22Ae6WP
 bAxlh83hy+Fc5r9JEiToqNfxvOVnEu45PUIwK+7ILS4fXur9PC+eEI3tTzh3QWQR1U2y
 fGchp0jwz1GcS7CMYSkzWAZFUrQhypeAn1rmxc53IT6mSlfauVREPWLvJ+Jl0PWdxTQ0
 uXcGW0mw5a8odNjnpUN4iA9nP061lJK6/oFEQOJbVj8at4imTaP5xBZOyh9Fxhlq1v1e
 BOKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7rw//62S4C8EJESK0avgBABJPfwweZwCsN57MRwGmEaKqPRatY5GdKQwmRxlvPIDkQ2kSFZc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcT+GPuVXucrm/DGQFdIXTj0XT8KN78g+Uyy2ULXx6bYxQ7UeL
 yH+1US/0qJ5hmpQtAClR1G3iT1c5Z8uw2Pv6vY1UK+MnQTJh0O46y2EoHtAsl/d04jA=
X-Gm-Gg: AYBFou3po9QlRip5R+cuu8Gkn8pyaxtCbvoi2+wy9ZjpuD9uZaUZoKkIHUy5RiJElq3
 Zpj8c1nGdF+dt8/AH3dkkze6LIxwDylpCAYRuJn/65mffM5wE9lu0x00nCVbV23DyMmy930IVJS
 xC4dX2+AsE4OsbZVCYMeseDxS0XwK6+WYIndvSm1wyKD9eVnUnFSync377SEmpFTXEUwKudNlyI
 N3p5ULMrcWxNeyDD3Ukgf3CTJv8yC5I8cokxcrSx1/FQsNms6ltkX1Mwdk1wD/ORaHOUxsyASsX
 sOpk72YGarHFtR0b77x9BbTcXG1UyESR7iEygaiLXTgtsyN0OIXRtEI9hvtEsrZ5sZDRZZCuA2O
 3MaWURUNCmFPniCx7kCLuKcqak599pSDU42f+Tc/vsMfeuUQ0duTAUPEgUGB/O3Y9FCrKZSWQ9S
 ht4stSUVwToTa+Sk8Aq/q62zw8ojcOiozaYKBTF+Xz0a0Y1P7p4xLrytTfTysQccYvXHz3T7Uxv
 IdxtrrDk6gVs3aFZLr7C2kpTEDb8zQGdlna2l5TZQDfSs3Ys8OlxCFzUj9sY1aR53htsMJ7I/qQ
 ZNIL36vwZ/FDEU1oL2I1q+7X2/+U3IR+axY9bP2mMsK0hGHaY3+5iZU=
X-Received: by 2002:a05:600c:1f8f:b0:49d:1de5:ce0a with SMTP id
 5b1f17b1804b1-49eb732052amr36430935e9.13.1789570630684; 
 Wed, 16 Sep 2026 07:57:10 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0a4e68sm122355e9.2.2026.09.16.07.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:57:10 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 16 Sep 2026 16:58:08 +0200
Subject: [PATCH 1/3] power: domain: mediatek: support SMI and infra-nao bus
 protection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mt8365-add-power-domain-v1-1-b768d71b895c@baylibre.com>
References: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
In-Reply-To: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

The scpsys bus protection so far only drove the infracfg register block.
Some SoCs, such as the MT8365, also gate power domains through the SMI
common space and acknowledge their way-enable protections via the
read-only infracfg "nao" mirror.

Extend the bus protection descriptor with a target register block and a
separate status block, add the inverted (way-enable) set/clear polarity,
and retrieve the additional "mediatek,smi" and "mediatek,infracfg-nao"
regmaps per domain. Existing SoC tables are updated to select the
default infracfg block.

This mirrors the Linux driver available upstream at commit Fixes:
1b78070aaef6 ("Merge tag 'net-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt8188-power-domain.c | 164 ++++++++++++++---------------
 drivers/power/domain/mt8189-power-domain.c |  74 ++++++-------
 drivers/power/domain/mt8366-power-domain.c |  40 +++----
 drivers/power/domain/mtk-power-domain.c    | 116 ++++++++++++++------
 drivers/power/domain/mtk-power-domain.h    |  62 ++++++++---
 5 files changed, 275 insertions(+), 181 deletions(-)

diff --git a/drivers/power/domain/mt8188-power-domain.c b/drivers/power/domain/mt8188-power-domain.c
index 265d222f17a..58dd5b2dc92 100644
--- a/drivers/power/domain/mt8188-power-domain.c
+++ b/drivers/power/domain/mt8188-power-domain.c
@@ -122,28 +122,28 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -180,12 +180,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -210,8 +210,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -224,8 +224,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -236,12 +236,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -254,12 +254,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -272,12 +272,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -290,12 +290,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -308,12 +308,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -326,24 +326,24 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -356,16 +356,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -378,16 +378,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -400,8 +400,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -414,8 +414,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -428,16 +428,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -450,12 +450,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -468,12 +468,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -486,12 +486,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
@@ -504,16 +504,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -524,16 +524,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -546,12 +546,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -578,24 +578,24 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -608,20 +608,20 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
diff --git a/drivers/power/domain/mt8189-power-domain.c b/drivers/power/domain/mt8189-power-domain.c
index a4857bb4c8c..3cf1e71b845 100644
--- a/drivers/power/domain/mt8189-power-domain.c
+++ b/drivers/power/domain/mt8189-power-domain.c
@@ -83,20 +83,20 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.ctl_offs = 0xe04,
 		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MCU_STA_0_CONN,
 					MT8189_PROT_EN_MCU_STA_0_SET,
 					MT8189_PROT_EN_MCU_STA_0_CLR,
 					MT8189_PROT_EN_MCU_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_1_CONN,
 					MT8189_PROT_EN_INFRASYS_STA_1_SET,
 					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
 					MT8189_PROT_EN_MCU_STA_0_SET,
 					MT8189_PROT_EN_MCU_STA_0_CLR,
 					MT8189_PROT_EN_MCU_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_0_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_0_CONN,
 					MT8189_PROT_EN_INFRASYS_STA_0_SET,
 					MT8189_PROT_EN_INFRASYS_STA_0_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_0_RDY),
@@ -109,8 +109,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
 					MT8189_PROT_EN_PERISYS_STA_0_SET,
 					MT8189_PROT_EN_PERISYS_STA_0_CLR,
 					MT8189_PROT_EN_PERISYS_STA_0_RDY),
@@ -143,20 +143,20 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_IGN,
+			BUS_PROT_WR_IGN_SUBCLK(INFRA, MT8189_PROT_EN_MM_INFRA_IGN,
 					       MT8189_PROT_EN_MMSYS_STA_1_SET,
 					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_2_IGN,
+			BUS_PROT_WR_IGN_SUBCLK(INFRA, MT8189_PROT_EN_MM_INFRA_2_IGN,
 					       MT8189_PROT_EN_MMSYS_STA_1_SET,
 					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -169,12 +169,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -195,12 +195,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -213,12 +213,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VDE0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_VDE0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VDE0,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_VDE0,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -231,12 +231,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VEN0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_VEN0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VEN0,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_VEN0,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -249,12 +249,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -283,8 +283,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_MDP0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_MDP0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
@@ -297,8 +297,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_DISP,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_DISP,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
@@ -325,8 +325,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
 					MT8189_PROT_EN_PERISYS_STA_0_SET,
 					MT8189_PROT_EN_PERISYS_STA_0_CLR,
 					MT8189_PROT_EN_PERISYS_STA_0_RDY),
@@ -345,16 +345,16 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
 					MT8189_PROT_EN_INFRASYS_STA_1_SET,
 					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MD_STA_0_MFG1,
 					MT8189_PROT_EN_MD_STA_0_SET,
 					MT8189_PROT_EN_MD_STA_0_CLR,
 					MT8189_PROT_EN_MD_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
 					MT8189_PROT_EN_MD_STA_0_SET,
 					MT8189_PROT_EN_MD_STA_0_CLR,
 					MT8189_PROT_EN_MD_STA_0_RDY),
diff --git a/drivers/power/domain/mt8366-power-domain.c b/drivers/power/domain/mt8366-power-domain.c
index d40cf1849bd..e509f6f6c33 100644
--- a/drivers/power/domain/mt8366-power-domain.c
+++ b/drivers/power/domain/mt8366-power-domain.c
@@ -51,16 +51,16 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.ctl_offs = 0x304,
 		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_CONN,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_CONN_2ND,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_1_CONN,
 					MT8366_TOP_AXI_PROT_EN_1_SET,
 					MT8366_TOP_AXI_PROT_EN_1_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1_1),
@@ -81,20 +81,20 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_1_MFG1,
 					MT8366_TOP_AXI_PROT_EN_1_SET,
 					MT8366_TOP_AXI_PROT_EN_1_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_2_MFG1,
 					MT8366_TOP_AXI_PROT_EN_SET_2,
 					MT8366_TOP_AXI_PROT_EN_CLR_2,
 					MT8366_TOP_AXI_PROT_EN_STA1_2),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MFG1,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND,
 					MT8366_TOP_AXI_PROT_EN_SET_2,
 					MT8366_TOP_AXI_PROT_EN_CLR_2,
 					MT8366_TOP_AXI_PROT_EN_STA1_2),
@@ -123,12 +123,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VDEC,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
@@ -141,12 +141,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VENC,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
@@ -159,8 +159,8 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN_STA_MASK(MT8366_TOP_AXI_PROT_EN_2_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN_STA_MASK(INFRA, MT8366_TOP_AXI_PROT_EN_2_AUDIO,
 						 MT8366_TOP_AXI_PROT_EN_2_AUDIO_ACK,
 						 MT8366_TOP_AXI_PROT_EN_ADSP_SET,
 						 MT8366_TOP_AXI_PROT_EN_ADSP_CLR,
@@ -174,12 +174,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_CAM,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 24b4991e469..768ab8bab9c 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -43,32 +43,57 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 				  !(val & mask), 100);
 }
 
-static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
-				      void __iomem *reg)
+static void __iomem *scpsys_bus_prot_reg(struct mtk_scpsys *scpsys,
+					 struct mtk_scp_domain *domain, u8 block)
 {
+	switch (block) {
+	case BUS_PROT_BLOCK_INFRA_NAO:
+		return domain->infracfg_nao;
+	case BUS_PROT_BLOCK_SMI:
+		return domain->smi;
+	case BUS_PROT_BLOCK_INFRA:
+	default:
+		return domain->infracfg ? domain->infracfg : scpsys->infracfg;
+	}
+}
+
+static int _scpsys_bus_protect_set(struct mtk_scpsys *scpsys,
+				   struct mtk_scp_domain *domain,
+				   const struct mtk_scpsys_bus_prot_data *bpd)
+{
+	void __iomem *reg = scpsys_bus_prot_reg(scpsys, domain, bpd->bus_prot_block);
+	void __iomem *sta_reg = scpsys_bus_prot_reg(scpsys, domain,
+						    bpd->bus_prot_sta_block);
 	u32 val = 0, mask = bpd->bus_prot_mask;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 
-	if (!mask)
-		return 0;
-
 	if (bpd->bus_prot_reg_update)
 		clrsetbits_le32(reg + bpd->bus_prot_set, mask, mask);
 	else
 		writel(mask, reg + bpd->bus_prot_set);
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
+	return readl_poll_timeout(sta_reg + bpd->bus_prot_sta, val,
 				  (val & sta_mask) == sta_mask, 1000);
 }
 
-static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
-				       void __iomem *reg)
+static int _scpsys_bus_protect_clear(struct mtk_scpsys *scpsys,
+				     struct mtk_scp_domain *domain,
+				     const struct mtk_scpsys_bus_prot_data *bpd)
 {
+	void __iomem *reg = scpsys_bus_prot_reg(scpsys, domain, bpd->bus_prot_block);
+	void __iomem *sta_reg = scpsys_bus_prot_reg(scpsys, domain,
+						    bpd->bus_prot_sta_block);
 	u32 val = 0, mask = bpd->bus_prot_mask;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
+	u32 expected_ack;
 
-	if (!mask)
-		return 0;
+	/*
+	 * The infracfg-nao mirror reports a released way-enable protection by
+	 * reading the status bits back as set, unlike the regular acknowledge
+	 * which clears to zero.
+	 */
+	expected_ack = bpd->bus_prot_sta_block == BUS_PROT_BLOCK_INFRA_NAO ?
+		       sta_mask : 0;
 
 	if (bpd->bus_prot_reg_update)
 		clrbits_le32(reg + bpd->bus_prot_clr, mask);
@@ -78,20 +103,24 @@ static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bp
 	if (bpd->ignore_clr_ack)
 		return 0;
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
-				  !(val & sta_mask), 1000);
+	return readl_poll_timeout(sta_reg + bpd->bus_prot_sta, val,
+				  (val & sta_mask) == expected_ack, 1000);
 }
 
-static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
-				     int bpd_size, void __iomem *reg, bool subclk)
+static int scpsys_bus_protect_enable(struct mtk_scpsys *scpsys,
+				     struct mtk_scp_domain *domain, bool subclk)
 {
+	const struct mtk_scpsys_bus_prot_data *bpd = domain->data->bp_cfg;
 	int ret, i;
 
-	for (i = 0; i < bpd_size; i++) {
-		if (bpd[i].subclk != subclk)
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask || bpd[i].subclk != subclk)
 			continue;
 
-		ret = _scpsys_bus_protect_enable(&bpd[i], reg);
+		if (bpd[i].bus_prot_inverted)
+			ret = _scpsys_bus_protect_clear(scpsys, domain, &bpd[i]);
+		else
+			ret = _scpsys_bus_protect_set(scpsys, domain, &bpd[i]);
 		if (ret)
 			return ret;
 	}
@@ -99,16 +128,20 @@ static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
-				      int bpd_size, void __iomem *reg, bool subclk)
+static int scpsys_bus_protect_disable(struct mtk_scpsys *scpsys,
+				      struct mtk_scp_domain *domain, bool subclk)
 {
+	const struct mtk_scpsys_bus_prot_data *bpd = domain->data->bp_cfg;
 	int i, ret;
 
-	for (i = bpd_size - 1; i >= 0; i--) {
-		if (bpd[i].subclk != subclk)
+	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
+		if (!bpd[i].bus_prot_mask || bpd[i].subclk != subclk)
 			continue;
 
-		ret = _scpsys_bus_protect_disable(&bpd[i], reg);
+		if (bpd[i].bus_prot_inverted)
+			ret = _scpsys_bus_protect_set(scpsys, domain, &bpd[i]);
+		else
+			ret = _scpsys_bus_protect_clear(scpsys, domain, &bpd[i]);
 		if (ret)
 			return ret;
 	}
@@ -199,8 +232,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	 * Some domains split the bus protection policy in two: one part has to
 	 * be released before the subsys clocks are enabled and the rest after.
 	 */
-	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					 infracfg, true);
+	ret = scpsys_bus_protect_disable(scpsys, domain, true);
 	if (ret < 0)
 		return ret;
 
@@ -221,8 +253,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 		if (ret)
 			return ret;
 	}
-	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					 infracfg, false);
+	ret = scpsys_bus_protect_disable(scpsys, domain, false);
 	if (ret < 0)
 		return ret;
 
@@ -259,8 +290,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 			return ret;
 	}
 
-	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					infracfg, false);
+	ret = scpsys_bus_protect_enable(scpsys, domain, false);
 	if (ret < 0)
 		return ret;
 
@@ -277,8 +307,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	if (ret)
 		return ret;
 
-	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					infracfg, true);
+	ret = scpsys_bus_protect_enable(scpsys, domain, true);
 	if (ret < 0)
 		return ret;
 
@@ -396,6 +425,33 @@ static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int paren
 		domain->infracfg = regmap_get_range(regmap, 0);
 	}
 
+	if (ofnode_read_bool(node, "mediatek,infracfg-nao")) {
+		ret = ofnode_parse_phandle_with_args(node, "mediatek,infracfg-nao",
+						     NULL, 0, 0, &args);
+		if (ret)
+			return ret;
+
+		regmap = syscon_node_to_regmap(args.node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+
+		domain->infracfg_nao = regmap_get_range(regmap, 0);
+	}
+
+	if (ofnode_read_bool(node, "mediatek,smi")) {
+		ret = ofnode_parse_phandle_with_args(node, "mediatek,smi",
+						     NULL, 0, 0, &args);
+		if (ret)
+			return ret;
+
+		/* The SMI common node is not a syscon, map its registers directly. */
+		ret = regmap_init_mem(args.node, &regmap);
+		if (ret)
+			return ret;
+
+		domain->smi = regmap_get_range(regmap, 0);
+	}
+
 	num_clks = ofnode_read_string_count(node, "clock-names");
 	for (i = 0; i < num_clks; i++) {
 		ret = ofnode_read_string_index(node, "clock-names", i, &clk_name);
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index ef2603bbdbc..06760286a3a 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -64,7 +64,21 @@ struct udevice;
 
 struct mtk_scp_domain;
 
+/*
+ * Register block a bus protection step operates on. A domain may drive its
+ * protections through several distinct register regions (infracfg, its
+ * read-only "nao" mirror used for way-enable acknowledgments, and the SMI
+ * common space), each retrieved from a separate DT phandle.
+ */
+enum mtk_scpsys_bus_prot_block {
+	BUS_PROT_BLOCK_INFRA,
+	BUS_PROT_BLOCK_INFRA_NAO,
+	BUS_PROT_BLOCK_SMI,
+};
+
 struct mtk_scpsys_bus_prot_data {
+	u8 bus_prot_block;
+	u8 bus_prot_sta_block;
 	u32 bus_prot_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
@@ -72,6 +86,11 @@ struct mtk_scpsys_bus_prot_data {
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	/*
+	 * Invert the set/clear polarity: apply the protection by clearing and
+	 * release it by setting. Used for the way-enable steps.
+	 */
+	bool bus_prot_inverted;
 	/*
 	 * Release this protection before the subsys clocks are enabled and
 	 * re-apply it after they are disabled, instead of the other way round.
@@ -85,7 +104,7 @@ struct mtk_scp_domain_data {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
-	const struct mtk_scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
+	const struct mtk_scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
 };
@@ -104,6 +123,8 @@ static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
 struct mtk_scp_domain {
 	const struct mtk_scp_domain_data *data;
 	void __iomem *infracfg;
+	void __iomem *infracfg_nao;
+	void __iomem *smi;
 	struct clk_bulk clks;
 	struct clk_bulk subsys_clks;
 	bool has_pd;
@@ -117,7 +138,10 @@ struct mtk_scpsys {
 	struct mtk_scp_domain *domains;
 };
 
-#define _BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, _update, _ignore, _subclk) { \
+#define _BUS_PROT(_block, _sta_block, _mask, _set, _clr, _sta_mask, _sta, \
+		  _update, _ignore, _subclk, _inverted) {		\
+	.bus_prot_block = BUS_PROT_BLOCK_##_block,		\
+	.bus_prot_sta_block = BUS_PROT_BLOCK_##_sta_block,	\
 	.bus_prot_mask = (_mask),				\
 	.bus_prot_set = (_set),					\
 	.bus_prot_clr = (_clr),					\
@@ -126,22 +150,36 @@ struct mtk_scpsys {
 	.bus_prot_reg_update = (_update),			\
 	.ignore_clr_ack = (_ignore),				\
 	.subclk = (_subclk),					\
+	.bus_prot_inverted = (_inverted),			\
 }
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false, false)
+#define BUS_PROT_WR(_block, _mask, _set, _clr, _sta)		\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, false, false, false)
+
+#define BUS_PROT_WR_IGN(_block, _mask, _set, _clr, _sta)	\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, true, false, false)
 
-#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, false)
+#define BUS_PROT_WR_IGN_SUBCLK(_block, _mask, _set, _clr, _sta)	\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, true, true, false)
 
-#define BUS_PROT_WR_IGN_SUBCLK(_mask, _set, _clr, _sta)		\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, true)
+#define BUS_PROT_WR_STA_MASK(_block, _mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _sta_mask, _sta, \
+		  false, false, false, false)
 
-#define BUS_PROT_WR_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false, false)
+#define BUS_PROT_WR_IGN_STA_MASK(_block, _mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _sta_mask, _sta, \
+		  false, true, false, false)
 
-#define BUS_PROT_WR_IGN_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, true, false)
+/*
+ * Way-enable protection: the set/clear polarity is inverted and the
+ * acknowledgment is read back from the infracfg-nao mirror.
+ */
+#define BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
+	_BUS_PROT(INFRA, INFRA_NAO, _set_mask, _set, _set, _sta_mask, _sta, \
+		  true, false, false, true)
 
 int mtk_scpsys_probe(struct udevice *dev);
 int mtk_power_controller_probe(struct udevice *dev);

-- 
2.55.0

