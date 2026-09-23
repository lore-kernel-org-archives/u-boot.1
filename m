Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A5EC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01FC783148;
	Wed, 23 Sep 2026 20:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw09Xz_hH4sY; Wed, 23 Sep 2026 20:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BDB183112
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790194965;
	b=FRn29bUL0aS5BtvLSs7PTGxkpttA+NDn1eYPXCoVx1OeZ7IJoHmIbtsq7WCgYqvlzqmV
	 NdURWFdcy+qGKflL89XTl/jXqGlT74fRsSZfclGdK+SVekfKy4B98rZPKvCtNVj98lixT
	 ytdPP9UUYLkUEbB38E1R060OdjMxlwYz+UaVIX5j3SSeenB87pWB6QthIGDl7/U+b8kb+
	 xgESUHqSyasFjSlnqptHYpqJh50669AuNw4ZQyLymd+YARYa6wbQ8oIOHxqCsUYROBRY1
	 Vw1TbbqG/6wC82w6JAWghpXiu98pn4pbq8GTkRNmd8IE8CkNZPrVFNn/J0x6n9irytA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790194965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=545RaKC45PN+vQA7eG8AXhiDiMhLr4u5T7jy77boObM=;
	b=oDtcdvS6alcwegtqs87XlhFxrM3d284iB+mHHWu+GgZt29lXXXnVJGphdpsO7WhuRyX2
	 XpxBAuYTI17Td6XsDSCBBqVjM5FfB2ktBU8GK8/azZISVqrZ47dfxwao8JA40ZmUXJxza
	 V+x7O0IGgaaerzKC1bmu1KzsXs+b9iTYZl47a0+N16HFBxdNKyBYFKoOSyDviDnBjlHN7
	 td2FhSZb9on09y67+sWOjwhY+08XTBGRy3zHLR4y051nPpynvD9IqAldO4nP8C5zMrMqw
	 wiRodBNgo8b/ojiy3SpBZEZdfNks4cF3or97j/1PYtniLKE+DZmttadziEFPneSVxGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kbb3PBau;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790194965;
	bh=545RaKC45PN+vQA7eG8AXhiDiMhLr4u5T7jy77boObM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R0DixPDKPXkwKwuomfJznaycwmJkk45E2EwlV6gWl5ON8+hP5CnIvtnwkueejzHKH
	 VHTZykdOlEOCB4/pWXWRDDq+8gv43nRVVg7SUxdACqeZin+CPMtxLpysnU1XmLHcuD
	 sLLubgG4pWIp5KEmAT2rI0Rzp3++vua6FURM2WWdABJVhBX9dTnWa5x7GJoVKIrENh
	 vdSHYidPTgJQNlyOdSskRcitcLfaThrLZCTMDyA4B2PsMcwjn90GFJOTC+/3I7x2fE
	 igSGYIIPginzlgbzUTWaniiB79Od0amx4lb7CZlDSLG4tBaQxs+uR6bgPfm0BtDuW8
	 MCP1vE3yAYQIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BDB183112;
	Wed, 23 Sep 2026 20:22:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EEB232F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1483C83077
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxzW19rEB_5B for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C73F82FD7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790194963;
 b=f91ukXslTJSgchyBI65f4LwN3UKUVu/qCVFNl+c/K0JTImNrVzkQtPYbXOB0Av1YdLio
 R/jIYnnywxbfbrir+UEVHRpX7G8+HVVmvXHBU3TRqmC1XOdV0kOfKMFLmDajIZelDbKJt
 f73VHsNP4MUFMCIJLO02oXD6bCRufC5TNwliIsCILTMDZ/E5rPk7A5ToXWCFauNHaWdn+
 JUztFQXUpZtG96pHaIFwZ2bt5v2BmSYd1y0sH2JcmSIjlaZUIX5gxTIGA4cPYDQXpv5GR
 reZjQ4uuB61QUGcORWgtejp7UEDqVFBMkL7WSxCnIic9UBZhI1G7p1seFDB60JQekdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790194963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=545RaKC45PN+vQA7eG8AXhiDiMhLr4u5T7jy77boObM=;
 b=QHUdlB+W/h/VipmcmJ9zFDDII4G5J4LJMx6vBxhtcjh4EetOTCQmmr9PFheFbH7NqTnB
 GwUZlWmA2604d5eTzUenwL85wMWVyym9K8tmxVPzDcfsq9RdnmhmX0CcskVDOb8YHwzSo
 Okytp9KcHOz4QNRO8XAu9iNX0hcs8dV9F3oEWGZPkLpsIHS6GzThmYwprNnydK6YzOsw3
 o9lYj9asIYg+Dwx3eKTZiemA3KKrzQC+ZNEHfggnvT8y6nnZN83nJrk5eL9fBf/C/obzL
 ms8wfkSlMj2KjK6mEN7F23hLU7g8Vked5RIfJ7UizGKiVL+j+gxpqouD8KZKOqa1uhw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kbb3PBau; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kbb3PBau
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C73F82FD7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:41 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c2613d80fbso828749eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790194960; x=1790799760;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=545RaKC45PN+vQA7eG8AXhiDiMhLr4u5T7jy77boObM=;
 b=kbb3PBauCJpdhfg8ctM6paHUnOIFgi3b4Zo8ezmfp0iJOKxImgbx6mNqEKm/4Ur5Br
 7DJXLKy5B7JjXisNi1qt/WVrM1YzwsL72LHUtP+2Pv+I7bxih68dP2w+TMNjPrFwi66V
 Qv9uycA9RYjgtEaIwXYI5TbDnxQ00lozIDrNogKu9PZVMfT+pRErbd8uR98H+HS3QxWK
 FcxqMoDWQzwK/TCmfKQYwXsPFYuW745SBeTBONl7kGng2lyUEbDhDsvKIqdygHJEJH+/
 EcJTK9RoEdzIHFI/MSAJVV9GQenoYdH7uGcKyafK28UWYEAI8cbqyfZNkDVYwiGs7aCG
 JbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194960; x=1790799760;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=545RaKC45PN+vQA7eG8AXhiDiMhLr4u5T7jy77boObM=;
 b=1vfSSRQuZ/Rx7TtSYrab6Pyg/CRfe/83pGoaFgSd8a/zsrm0SZHX2lWnMx1+e3mJUh
 1z8R1Z8+uMbrquHjq3mLZTJqPDU2h2owzxNX2aNIe5bOV2y6EnmnZkBzxxg9K3RYKSKp
 w8ZQ9ae1q3z1S7jWzqxCfsSr8cmuk2dvpA8DsV3xC08HMl1sAv/bmV2rkK93wesg4XWr
 CWRyVcWGez7pCqE4+eKiAYs7lykzTC6fQWkewsjdVuPZ8oN/c/q5w8R5Dn7+5XRTpmQc
 Vm+4UgC30e3LIs3xEfWLb8U6lqFzGeJzpr9Uu8czCP6FRKF9mOorBwvPPjIZi8Qa8ozU
 eRBg==
X-Gm-Message-State: AFuF++lipC69OsfDTmcOfepA9OOqCpBu6hyjOdjtbtQJWxkh1FS26Emn
 VLi6oysGyNc0zChkxWyzYl6absvRmnH1gw5KD6qiN8QB1lsaPmZuHVLyLJ2CGJXV7Pc=
X-Gm-Gg: AYBFou3dqcOiGfZjM+8ng1aqZ/7g/2pYpFsR5UCP+peDvsgiLmGqk1iJgyhRxfYc1VW
 o64DIOqXnAscbcTZBsZgo1t7Z0bnOkMA1lBLRJsisNhn4ZoImq7H/V4Id+2/GkJMe5AkNkB3a8t
 TgHMvXLZ7fuDTJvZmXuWpM8cQwjDNGzBBZEpqVYeeT4TjBDYtjm2vo1GsxSPI+UkbEr7tbo03S7
 wVwb758qCUgQXvYABfZwXaMILPiWQYvCFTdViwrZ+HvFW3udsQCSbwr2WM52Oz1ZirGYw9A5Am7
 GUja/F1pMdoKPHZfxj1TdoedqtJntS5Qwx5dNdKvpGlKtqf/qWOxEYBU3G9FLB9LhFc4DBuoEy0
 xyefTD+0fN/IXidZhLjQGOr866JllfzGyGw6jblRRCBEwP7SrFqw1/NIFwcWDcaZsH1DPcHqkzA
 sutGQw/VjanZYbqKr3ZCC4kC3aCu3fGHkfLVE0ev83CfOa5zOFFODsn1gS2DUOCyjn7viq2gZKT
 zqXvxr4SMJE2Q==
X-Received: by 2002:a05:6820:1515:b0:6cd:3ffc:e337 with SMTP id
 006d021491bc7-6d441995b7cmr393253eaf.85.1790194959997; 
 Wed, 23 Sep 2026 13:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491ed71e8easm233729fac.7.2026.09.23.13.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:22:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] clk: mediatek: fix some clock definitions
Date: Wed, 23 Sep 2026 15:22:12 -0500
Message-Id: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3YTbBNBX8V4WNoRFxTMFggJ4
 d2tepnkO8y/UYIpEl2KjQyLJh2HjOOhoPCQoQVrzCZXulN5dp7Ds+cXosqEntu8PFqEsfjGVwK
 pfagov9+Gu66/8vX2d5qbDmH65mjfPyOmGgt7AAAA
X-Change-ID: 20260923-clk-mediatek-gate-order-a3b37aea83c7
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HJp1Up61xlWsRnEyQLsqFgpK05qYza4L0KIcZADNRPY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtDT3eMsitwgHvum8VmkLWNDX6C4CZbvPk0+jS
 k1FUZckqQqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarQ09xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGAMIAJdN6NYzaifCgx9UE7Ya0dzkdBzwolrPbEDjIor
 m491bhH86+5nUb6X8CIPqDt1G1DV2p0M9UwgvazPRuXLgHwy9xSVWUFPCz6YQWp7ETP3n2K91jq
 ALGk3O02ll8iPnqpSb9jUcO343TrPeb7wP7GsqWs1p2LdubWlpNj3a0TTG/hcRaepe8PZIcRZX+
 HOG3Vpf+AZbAAcmE1VHkqklAXBjYMm+VzB4V1u88j7oJk5UpiSTBQVc9CXnWreXaJILXo1yXNFG
 BtOWRjGHmnIPiO356m1wQUiJsZbPsDSqq11xKTKDQtFa3NhwoS0XWgFqfZ7aitsH/QB2MXefQ03
 ARCI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

While reviewing some adjacent code, we noticed that we had a few
incorrect definitions in a couple of the mediatek clock trees. These
trees consist of strictly ordered arrays where the index must match the
ID exactly for lookup to work. So if anything in U-Boot tried to use
one of these clocks, it would end up with the wrong clock or crash.

The mt8183 pumpkin board was likely turning on a few clocks that it
should not have instead of USB clocks that are in the affected range.
That was likely mostly harmless though, especially if those clocks were
enabled by default anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      clk: mediatek: mt8183: fix infracfg gate lookup
      clk: mediatek: mt8518: fix top gate lookup

 drivers/clk/mediatek/clk-mt8183.c | 18 ++++++++++++++++--
 drivers/clk/mediatek/clk-mt8518.c | 10 +++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)
---
base-commit: e3ed6c6436abc18af0c7a0298ac72f83ebf2b5d1
change-id: 20260923-clk-mediatek-gate-order-a3b37aea83c7

Best regards,
--  
David Lechner <dlechner@baylibre.com>

