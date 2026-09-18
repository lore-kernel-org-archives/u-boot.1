Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E478CC982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B60C360D79;
	Fri, 18 Sep 2026 10:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uFjtXVYCN8vZ; Fri, 18 Sep 2026 10:53:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0ABF360D4E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728801;
	b=kSm1l1/Sl4ectHH9hpDvwaae0GIXrSuBoWwqV4M//e2AHNPJR3OLq9GweaqnOSyRX2y8
	 wZcQ6J7THtBVlq/7dRbqn5zKaZ30xrg62IAZXuK61ssA/ivyDlZSLhlv176e653AiDfvV
	 SA/AaptuXlBImDpEk4qW4VnZbzscsFfESIThcVaV14nZNiICmyvfUhdyCLooGX2dgAoXb
	 Q1/yxmgZs/bA27VLI/8j5eOHIueMiJ1R5A5hb9Bsv7ctHz5ZHVMTXxKRRzW9HPax6I6xD
	 cy1o5DTbkbF9Z6oEoqjFdtOvrRmOebUM8mkbtcGwiz9p7o4M2NrqDLPFCOKOsxmRxWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
	b=P0j6qit3GMh39/eEWTO8u+Pd9As4xESmS/ycMHVlOcx2WXvtElxKeLmMZD3QHIfHKx51
	 0TiDl6nR36foI3vCX1J73FyAm4nuUru5olmEnPSjTCVZeF4e+9ECGB/ReUawDlFKy7HS8
	 0Lbzkc/AntC3uHXqrwFDBzJ2o5FeENCJObHN5aOROGB7I/9A1FpEqu5/05NeeDcnCIZ7d
	 g1qNOamTZjzZfzmwUexc+n5sicJ1ztrsmXq3ehsjV1wtFdwuzwlhoL+ACVelaKyf+ybGL
	 dx3a0zTBarygOln2WyPscI+tYlzdIuZPau37h9mUaIzriyph9dmMHb7Fqc/Pb/r9Qhg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="bIW/7uGh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728801;
	bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HO4bF79eIy3BF86N0vrr/ttCyMDlENboVItAZVdIKaJw98HIOw3WyNH8bp6vuKo/v
	 L7rtPBiHtP0Grf5A7KCg+d71fQWiPnq5hWbOccp7+VF337zObmdIcjGhJibpeuj2X1
	 h82DEF0tauS6yYcpHlSRml2kd3qsVxAZlM1MdLGRhjvO0yMVSokp39uI4sEnw/R6F0
	 2YrkW2OMhLjrpACh5OACvCYt64zD+nd0rNX8UP+xmwViSZxqVXj71mLK567s0uiwr3
	 1ny3//ssGOxDCO5+oznSOijcm6S2lBaf+gdvCMjxCmYa3ExeHiWoDYVHV7jbiUUwc5
	 zxbnAEYFrWhEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ABF360D4E;
	Fri, 18 Sep 2026 10:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3173E24D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17E5D60D65
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ucvbElY6O5cG for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 376ED60D4E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728799;
 b=X798P4kVh8JU2o654dqSMs3U+OYOm+riaYtKkiSrDecoyDwGmUxbxqDHySHvhdy95rF1
 UdNEJLWHs//AXYaLM1t9/YXxeL94GUR24DCb2iYT678zWWoJRzgolBYhLGMJIbYcehhUZ
 3DxayDjmV+0t00huXsBmRjj1gC0uJ+T9jE/GWPW41VU2QdVvMtudKgfAWqwlZnKTHviTT
 z2Zui4XALk/RJ7lBaIaNjoRoGy+DM9s82NFRZAyWEbndsk9p8MQRdwoIEsKGP/cjzjtmH
 0AOzmLmoQ7EMC4fQHNPTs+1VqQ6eIbEsYficey+IyO3YS4zUt8iP5izc/kYdO6B2+XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=R+9LxFHT6xVwCuYzO37b3mTnYK22GDpSjY9afDQDAz8VSY+cbDxVUynBM//SVaRJ4BtI
 3Pymy0d4LDEJRtbbzzS0RH3WLCn0d1YwlS2iZCnD1QgLHr7v/5mHXrDss3ktoGr8oyEih
 dqg4Kl7Z1ZxErjEVMFL+eJJdI5zCXbppST12cx16WCVU64gTbUpDdlaJacDbQF6YXSEdC
 PyIr8ydT0FcDlAdQs05xD94pDSH2ePuucsmrLZBzMoO12x+gA1LWdvDoVHYT8hChQ76K6
 cEg7J4YxjCk0RccO7DkeCJ+1ERFBQIT7eN6MPtoj6g8eZN1MxqGShKw1Zx2G4gXKtQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="bIW/7uGh"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::c;
 helo=mail-wr2-x0c.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bIW/7uGh
Received: from mail-wr2-x0c.google.com (mail-wr2-x0c.google.com
 [IPv6:2a00:1450:4864:30::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 376ED60D4E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:19 +0000 (UTC)
Received: by mail-wr2-x0c.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so331851f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728797; x=1790333597;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=bIW/7uGh8zejJ8AYnAKz0TcPb1xn4COrNP5CQltQWPEprg3FcxAP6QMt668VTaS1v9
 OeXC/ce3GlfMdHzDe1bDjMGk8AfVJhLcGkRCbaRGdhFl5Q2zhCnSKHAAaUmvWLGYWvkn
 6t4+C3F4ag5F1P1GvKHvNftUT7SqqdGejurQqHH4IUqqVQqUJbrIs2HGyddII2ReYYXk
 tNEvTm+Pao9E2nOsbTR2Q5uycyaTn9YviTk3B48tvQY8r3/A3ZEBtzvGKHulnWBD220Q
 QTeggdlXrDhMvZXmWekjh40cS1TcfW/dZlkMl10ne0/kZrtWiAwgW7xNbGpglFJn9nCw
 QTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728797; x=1790333597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=o3SfD2Ub29i+4cwW93wbyEavWoHx4ccdD95Fy3sF11Xiaag0OQsOnHaECPO6ZMltm/
 55Wi7JmWkzxjsrMiH4dfQg5JD+Q3Uo+hzFkoRw1KLIpHRsrScIeCou9XWV/A4badcp0l
 myN/BprlFvn6zlWIFGYm2z1pxKtDzTSGOBn8ij+wCJ4SuaClge9AAdCmMwst1D+meSwH
 0ZLjN1II+YSq7ykn8PVlwhavZPCtK/1SwFAqoAx/Su/ddsvc+dV057aT5b5p2tYlHgvI
 Uz7xiDzoEsotGD9OMfxPAHew58P1WoHXvPLhyfPz4oz8DJutqB+hwbK0uwaN03VwuR2j
 M3AQ==
X-Gm-Message-State: AFuF++m1+5AL9wad6yrkzis4w6uj9/fvcNEhQgnSg5yDc1bG/cCckgUv
 ylwug37N/G4virUD17MOTyP5tSbNvKZxoXnYxFWHiTfqzMoutcjbOklqtz0hlQKYses=
X-Gm-Gg: AYBFou0kwDqOcJ/YmgFjoDAdoGS0RxfzepdyPpQtVj8xLnnvCHbYlE/GgXlexpx01SZ
 IdgUqsk9vfCCR7hjUj5pby81h9V3y6EPsT+32YWmmLb9ctEz+Brs1pL+2cM8mxSv3HT7T3zlVix
 BSDOBBVuWZUds43LBWOsRReJtXBOWLm2/krSrnnmy7Rppt4xh98rDZ6IFvOpKrguE9K9qMan6uY
 IzNeanppuPdLHYhfMo9yUsH6p49EfQvVTgc9W+ui+2t7vtx9GNkdEfL5S+4JlGEPIb77ufAF33h
 HCYwka1Bj4BB3kW4A29hWprTTiiUxUZnQL48T11H/HYh0mOjpC7FANWWINGbjSL3U3U0O5pdSIJ
 Vs8TXqlxgmnbc3v5zA/7WShMV+hBjzmqeyTH1Zac2eM1Su2GwhRlvyA5QIuZZ6g37NBXsp5XFcY
 j2FDDIWt5QOftWxkMR1bpAQ7nYD8lWyQ24715qjrP9cPwD1FOzcgwCI3QkGp3RkgnC7KyiYDnb0
 XhLeTmpvdITSilNSA7tWA1n6UpHlbeGAdU3EWAIuQG2HJLbb1o9
X-Received: by 2002:a05:6000:2006:b0:487:106f:ee31 with SMTP id
 ffacd0b85a97d-4871e261d7amr2948793f8f.27.1789728797057; 
 Fri, 18 Sep 2026 03:53:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:34 +0400
Subject: [PATCH v2 07/11] test: spl: Size the FIT properties for the image name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-7-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZG4UJp992ov4euj3JEpIYMY1E9fiRv0qw9MiMV1Gaec=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf97d6rNvxtP7+pF5ZfJvJoYGzuj5NEVy89Hvhiuc
 e6fZ+QT2DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUc61nZDi1fk5JwwSLzKiFVerKD/YELWIV7qv1z5x5vDB4R9uLBe0M/9S+LxZ
 U3ZbG+kMq4dOqWcvWfnswbWWN5uHcmFcTdNXii9kA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

create_fit() budgets a flat 596 bytes for the properties it writes, but
one of them is the image name (named after the test itself), which is used
twice and can cause libfdt run out of room and create_fit() return 0 if a
new test with a longer name is added.

Size the buffer accounting for the name explicitly.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 94ac3a16b863..34ddc49d2463 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,14 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/*
+	 * The name goes in twice, as the description of both the image and the
+	 * configuration, and for external data this budget is exact: it is the
+	 * whole buffer start_fit() gets, and where the data then starts, which
+	 * the loader expects 4-byte aligned.
+	 */
+	size_t prop_size = ALIGN(596 + 2 * strlen(spl_image->name), 4);
+	size_t total_size = prop_size + spl_image->size;
 	void *payload = NULL;
 	size_t off, size;
 

-- 
2.55.0

