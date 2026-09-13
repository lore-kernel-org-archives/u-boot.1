Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6125EC88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 04:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 052CC80EA2;
	Sun, 13 Sep 2026 04:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RF_to-Xu2i0J; Sun, 13 Sep 2026 04:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5289280E9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789273425;
	b=drvMN1kTLhUGkq99+OpfzcZmewa7aL2hc2Y6+utd1jacOgCV4lGRcAbNaEHaZEvqiOka
	 ar6f2QXNAk40YonTcZFGvd/UyDHIh3VLa/Oz7HFZwVSoNGmJPk7trxb/XOP7+96V0ocbK
	 ScCwe/SN7ViWUHxQNIVD62oeXX/UxeWYx/APi64a9MpImZ2TlZ/kvCyhYz9vby/n618Qd
	 Yc2G0JLll48sXeWnsRMLL3Uj4DNpkjas2+OBufQ8oyql/G4VWjidKld/fShOrmMf55v8h
	 Jyz1SFJjsGWEE3JWlk5wCaPkDmvN6Obig89mxil4ml0rebalL8dSk7s4sRPF23cszSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789273425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gqwOSkFbbaaM666+EBaLZbWNhRNq1E9NXjbDAAuMtsU=;
	b=XocPFCq6Y4qFYSKj0Tff9FxiTiPu34SoPV70j2q0M/GJT4hzdWejjxRJjTTONyiILMZm
	 ezZp5zwjFbwFO4l9QKpUHD2xW66vvSqm5690Reo2tMvH/ZdibyFmWeqm6+PmKHhGIj1dq
	 sjt9x3iq6gEddwVU+e0omAu+2yS26jR4SqvCTiJreZlj+5G3TX1jWfaxRQGcno8Wkypx7
	 DtS0ypc7Qr2OFYr4dfoDOCn1oyUe4Zky8GaHMO7hZoU0Q3fnLD2h9o+VOUh7B5sxmPXVk
	 UYcv5CLdhj6KI1C8VKmnbOmHj+7B8CpQHDIZ+RSOtqEDSUuX1HH9EEUdm4wtMAHMWJA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vmUyJAix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789273425;
	bh=gqwOSkFbbaaM666+EBaLZbWNhRNq1E9NXjbDAAuMtsU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtZnu60oLGvMzGgvKYq3sTJVuIOyFVzyZ8j5q/j5npyNRAPQoOWMXx8k9EowxMAzB
	 K7anCFrslI9ApVUg5MTPI5xP6AlJtB/c/vdeSonPwvDE5Pxmg/jPu46wz1r+HOjO4W
	 6s/sAsFndUNSFOCKXqBI2OTGclcsD4S1lbOzAa/svrz/PH0Ma84iuzMhNLtojbQ/mC
	 NZY/VQhmU8/5a/BuXAtlxCUolcb/0phNpODiFsAjPXtbLtL114BHc0UOAq1akf00X+
	 IIklfr00Y6MfL8tYK6kK+CuLRetudKvOghDEvGdfW8Z6J6Jfw+HvMiAwo4DAxZVGKM
	 2LiPpkap44LFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5289280E9D;
	Sun, 13 Sep 2026 04:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FE1832F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75DA480EA1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id py8wCP1JMjFd for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 04:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C136B80E55
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789273422;
 b=NAvN4w5iXygRlYfnEJHBM18QOyCQoWzJZ0YR+lNPTE7+wwJxwpsCCJkdA3fAINtTkmWG
 MFQMdwT9yG6Evll7DiYKn/58YS8zhjU0K5lNVraSGTVQhKYO+Vjydith7mFnu0vA5XUct
 GskY05kz4HijjI+49bcrEKofRqOzjBfHaJoSHS1U9QHs3rXYcDTZ0OWiB58spLR1YUgAg
 N2ENw2rjZyDrwuYVmSTmGeiQB2DtOsz9hT3lzFdcYX2V0iOXjvRost7K/kd3+khrd7xSd
 lqlSIoPUYDkAD0qcL1E/Fk5znMio8MUPEd4myzqx20g6zY6dSfx3qsnQyNAcuCHp5+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789273422;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=gqwOSkFbbaaM666+EBaLZbWNhRNq1E9NXjbDAAuMtsU=;
 b=bU9Ax5AI0klApwFIVdHyobk7hx9lGvZzrU0WdiR3PbI3PkofrpMo6ySacY4TWGLMT2vw
 SDJY0Ix3agO8nOuoo0El09zBtnN5RUDpN8NFTq+n02OVi3GZnMEvwoUJYldEBEsuTSr7i
 fXP84jGHvevSZKIct7lrdlb6V/F/936ugVTbqrRmRDzxIeKkUB9fetBQ/h88ov1gnwfGp
 IxZOmWrY+bTBaByTRBmS9aP7iJ+M/ZqTK50OSFxKGs84pnSK5TCIwAGNi2xNpJfF/weRL
 tF72IzBumbQUu42qzWzoiAUwuV9IldCKDanF+sL1uxtodzrMMF7D2GEyU5Ws8yyKYXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=vmUyJAix; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=vmUyJAix
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C136B80E55
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:42 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so959755a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789273422; x=1789878222;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gqwOSkFbbaaM666+EBaLZbWNhRNq1E9NXjbDAAuMtsU=;
 b=vmUyJAixEzjUsZcJEfV9/PHH/PlaYTwpk5TL25DJcHEqAEiMudGeDyRdQuRVG+A7mC
 wsznsyaKHeBt9EXa1aFk515WUkRXjm+62ltQDfMQFPGzLQ84RMHR4pv4fIB0AC5F2UtQ
 Jr4uPDV3h8EUuViY6cg5mSJ2xBJ//vD+k/4V0jgkMCHrD4CRasO4fUU1ZrrJNxttmPXM
 MzXrr/xSDH7xoxNDhGIy8iFeyRuWzjyXmYrcu5L8iEAbVTnT5i0YTZzYb/xdnXDEvNli
 Uw/umsy27UWpEzW4tyXMNzOky1CChxOO7FCvw0wYl1OvEsZ+NOhl4NhhQwvSc061Yhy+
 b8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789273422; x=1789878222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gqwOSkFbbaaM666+EBaLZbWNhRNq1E9NXjbDAAuMtsU=;
 b=Rffm6Cw7LN0H3bZ1JLCIpwY4oc/MBH0vXvTqa9CAdAXEe64f9maWaSr0dggD7TKPmV
 0HbCbTTtdfoxZnoy1uSzK/vBhrKvJfK+5VOlhrcIuRTn4LWOCH3SgEL5iUvuqqdJn3qT
 qVawylTKJKfdzauQzolbsEi8Q1a07qBvFuCvozd5XbPf1HPEMBy7XE6JuklHj2fGtfQv
 ECaP97RR8XKjFFOYai+S3UHBGtUTCc1UQEJU9rx6pyufqGP7V4Mma+xwoCFxZ3qPzYT6
 59uf6rSdfbwNaDABQuQfjWkL5l4QGKlruPdoX5xJ/IHtsKfCk0UfABGmFpSow5kD8vP2
 GVQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcw/JVprpgipIrWKyuz2wKs28i9ziI/9n14fMOCvcyDqDZOJkByG8Y6OmWLp764okIWCrE8ow=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kwQL89ha3OqXpLnAisN1R/Bh+mA6+ucNd1AowPLID1PH7tyAPv
 s6HFTI1M4IslwiRg0tVotTw22/bJT8Ztah/9I1DYXWP/VraX0S04jsm4ipELj+Bo8WM=
X-Gm-Gg: AYBFou32MRXXVkjt7pyah+7lYLiNitNtCEPvw5/zWEwhVhp7SMt4mopd/NB7HzzG6sF
 /W3KjXvRBOWNDTQZkXPscqoQwD9UF2yA18iGNn3DzsG7HshX2BPOEidUpo3WiGTh+z8VWbwPPJC
 a4Z/yr9EqhwD8SWJUzW/DwzaqYRFo4HGjpb9R5oTDiW2ppyyP7GcfpdrGDm7Tgr7iYs6pcwQ54B
 9+W/DCsKVqI/dBZhkjCA0XSL6bFeKcbPZebhdgfeRHcynWDI20+8LMbs2Q/OadcgAL2E0jA9vzY
 z2nKxjyxO7etV6pU1rxT2lbRJ8RV9RWh9YdtjgX15TosuVtKewve4tJIjWnnW3aNy7QHSM/Zo0b
 kePePPGogds8b0NOHRGy0/leuaIAvDnXWo0Wjp2ee1s5XemBuIi2/PBN2wMl5BBgx+W2iENk3bw
 7ttaoEb4JXwqHJVremD1sZPTKjJJXyQbHVUr6jkLWkgpV7rr3UVWMj/4sFT9bbxaY/7E87jnuCT
 D+kugfuKhnj118D612Wm85wJ9ysMOpLQP5goW8Toi0DaB73OOruoMQfBeG3xcJggcv5MFKRYK9W
 tudb+h/nTWGryJAR6xDQVYQnMvfeLqgTFJeT
X-Received: by 2002:a17:90b:4984:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39d9c3968dcmr21770988a91.25.1789273421827; 
 Sat, 12 Sep 2026 21:23:41 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm19389409eec.15.2026.09.12.21.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 21:23:41 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 13 Sep 2026 12:23:13 +0800
Subject: [PATCH v2 4/4] MAINTAINER: add K1 PCIe driver to Spacemit entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pci-v2-4-4fa1a8b5de06@riscstar.com>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
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

Add drivers/pci/pcie_dw_spacemit.c to the list of files
maintained for the Spacemit K1 board.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 board/spacemit/k1/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index e12288a206e0..c1d6b8f3a1c0 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -10,6 +10,7 @@ F:	doc/board/spacemit/
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
 F:	drivers/mmc/spacemit_sdhci.c
+F:	drivers/pci/pcie_dw_spacemit.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

