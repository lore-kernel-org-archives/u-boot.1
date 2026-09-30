Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447CCCA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D96260B0B;
	Wed, 30 Sep 2026 12:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgdY4o_z4DO9; Wed, 30 Sep 2026 12:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DE3B60B2B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790770712;
	b=mxDJ3+1huPTeJir0FTVGQsjriplqCS3yYajag0YYmbzwEsgM/Gj/C75XilfboGuYY8A1
	 n9zwRz8GUBvYfv33ZUng+XQz2iwXU6l1esTqtpeIxarOGHb6k1LYCaS1y3y+apGyP7E0u
	 u2ukh81LH6QN3U/o1vxpGrshUoPlinJTUolXJbU7JqoqhMoW90Eq0T+s3EDIUk7Gz4bbZ
	 qLBPxyHd8YjujJNawm7BIuVNHaBwjoEO2i0+5u82nHppAI1iZaY4b1xIkZ/l8rXEbN3lJ
	 4q9VIS5nuOf6lmZnE6JcTCo4XuK74AE5BJeC23WoBWttKj+fvcF2IbwkB9I73UCeMBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790770712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AWoH8I3Yi+xPlvNgVLW18Xp4Aod1FcM6EKyY5IdxjgA=;
	b=groKiuL/lEQeBzLVVRAya2D+S/Srf253BdpL8hEYO27EFvDvFk5sSFvHxexOHl0cljbW
	 DwEO0Rbz8tDn5UhAFwgnTjRto4uDOvvD04Qhmni0Fi6XZTVH5VTtNuZqEbpHfWqwaeyQR
	 2P+hew9mpWFJYYBCPrTwZa0ZdJS2Svt0XttCEOsqP5RiFYKO/imTjllRr3qE0pJ8zCnSP
	 O4QQOwZIgdItDRLSpJgho/UiyFgS8VdpCVYknkXh0tQYhwgqP/lRGtqg7oXKqdAU6rQnd
	 f6avgg4nrbWCYqx2PYdPND9RLdYkFjvnyKF/StJmnpbGcFe+g5aN7qY6lQ0yRqaGeIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=detj0WmL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790770712;
	bh=AWoH8I3Yi+xPlvNgVLW18Xp4Aod1FcM6EKyY5IdxjgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OufdiWoWqj1SwyP48sRKuZ2JKV/mrcrn3qn+XFN10K86SG3O92+I2UtBrFcVZoYkm
	 3JKQKzKmPKkeaGJapcqZUpa50Z6NY3X0Js+jGGxsO19b3eDz2bcGIrtu274n0wzp2t
	 A86pA/Bpq5/HzvuZvIyBBsUmJJJIwrnc6YO2kuGg1bTeW/YNtAxk2VSva0DZE65vQ5
	 kAlTkA2J/pQJfKXNjSwhM1RRNbm4+5bJAuSB0/cGgpduHDugU9jFkkSHTQLOzKfHk1
	 zKdVL+bTw/5icSGkf0SAJtYN0xJIaSDWzlT+JIcQF6PkgrSETho9nrNKP3UgoOWrki
	 XhWozQZtO55hQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DE3B60B2B;
	Wed, 30 Sep 2026 12:18:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A88B233B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A09860B0E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9kiCPqGSRU2 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A95DF608A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790770710;
 b=N9075LOe/Hbz18ZBTnfkWYCM4d2WMS8l1uw+PxBsYsaigpCnCBpUXFH2BynnS80Evx00
 O9VcZ+VDGrQy3zBeOvm5vlEQdHyb7buO/w7PsoZ7vW9+s00mrepAsJKnU+7jO+dd811yY
 paGHeH4MY9NOtNK9DS/qvlf4bFJBnZDzwWIdjk6NCr4ktZXHwspySnIPuEjaUM58Qti5/
 xoBUUXkodL6V5OutW6RLgioagzr9GQSTi2iuXU99Kkgs4GCiSE+EWvPD5bAmy/LFUtmAB
 1pSvqXdzL+6aKNtFQAAbS5DVtQ17uF+Yp1uusaoj88J0SiUyDiVVNllZnMGae/5MCoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790770710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=AWoH8I3Yi+xPlvNgVLW18Xp4Aod1FcM6EKyY5IdxjgA=;
 b=TU1Kfc3rn6fN+DjLFxN0uIQ+CKnUVroXCBZiUFQtxpY8/bBm8RcgTDSev04UoZo/OPHi
 z4Q6t2BetKcaWDo7ZPSv3vuS6I6MtqSGSNXLvFMtbvZlSDI9NfJuGxb5pFBpubC8VouPA
 gFP9euubQ7Y1iq1jsIIqd43FCilCWhjU4N1saY12XS7uHU5LbU7GSS+5b4UI2QEKLiPU1
 QtAB/Fuhf+SgknkMiPFBD+ne5obB2mP/3GzMz8HRbYIDtVd/+YQ6N5nxj1BbROFktZW/9
 TnNJSeGDZzecn9Oivffg6WfSJ2M7EboaYQ9LNYMwM278cqDbK8wCkzOzzne7Og7SnXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=detj0WmL; 
 arc=none smtp.remote-ip="2a00:1450:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:39::e;
 helo=mail-ua2-x0e.google.com; envelope-from=hfranco@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=detj0WmL
Received: from mail-ua2-x0e.google.com (mail-ua2-x0e.google.com
 [IPv6:2a00:1450:4864:39::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A95DF608A8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:29 +0000 (UTC)
Received: by mail-ua2-x0e.google.com with SMTP id
 a1e0cc1a2514c-986dfb672d8so2605469241.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790770708; x=1791375508;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWoH8I3Yi+xPlvNgVLW18Xp4Aod1FcM6EKyY5IdxjgA=;
 b=detj0WmLg9OgWNVnIc2SOZdNVTHRXGEv+XO8XCKvKrMy9B3S17f66zauv+OTIewyA1
 2phjhrIH/dyqahocGQ3xAGAtRQIPogQwlM9g6vN6JsKHBBfJYsqWDKuU0eonIy4EF2/R
 xOt+8YT/u85aAk6IwNHtEwGwW4ydRubePPr3vukXQ2bPRVpkJXDeUXp0AI8VTdmzoaP2
 9G6DPvPxKq3FCP706W/UH36eEzDsfaFSi+RD5A0ZcXLMsSp9lO0EJbeZIxAtfRB9j8JF
 p8jHuSNZAtaxOqGmqZTQ4PF8NjljVl3sl2RYJO2LWVsHMC5JnJY9AH13+hw54oavFQqi
 9GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770708; x=1791375508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AWoH8I3Yi+xPlvNgVLW18Xp4Aod1FcM6EKyY5IdxjgA=;
 b=YCNPBaerfw8SEFrUtFoZeMCF15SdjCRiOVXkwnC1UKbhSUr6AIoSpg0bpbeQnxt1rg
 a/Xth14fPZZmGa4GWiZXLTdzZVWQHkF7Qqc0lW0anr/1gyzZZ7Habkr8E3kIkem7ohAw
 8RAmwDKOl02qWNLnOqTriKCEgP5pbNcm2aojIYVl+w5N9BgKmoiC1LRQ3+Lu9ldHnl3f
 RdFWaJcM9sj0sZOgKWa7M82LMOxMx8AZyJu8oX/scGn7Qw9rda7ntS8tVfwhVBPLUkbr
 hE4OP2fWMmZ7H2d9j3ziHsL9sjFlhhs5KjBJfZAqyMdu4uvMt3qKVHtXS0XP4W5RuK4q
 ORYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwATjdOXZ2m7nYfq6wpnkd50sr9NsoCmYBka1WozK3AqCp4Bd1Wl9m2wCnM+qjjSlOXxYAo6Y4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNa/zZ4QdooMAoSXMADh/XMqutolwvM9JWv9blEZYikDJWpMRW
 11UgrTHLq/x4xg4PWicUrGL1iDbEJz64n+tmSezvWPPTbH37KXPhDtIADxcv92E9Jr4=
X-Gm-Gg: AYBFou1LNZaVeiPyjYTi+eMsvd0Igkk7vhHLxPO7D8seTXCF6m7DzH1TvcCLxwOskRG
 FhZGGlyenNt4+gB1CyMRvqYkcfMMRoyHppTarDWph0P98doEo2CiYSj+5Pqq/5AnKktcWFKjdSe
 LrSJ7ZFx58Y4eR+h7rLYo5z8ZJxwRTdMILoWS6SaR1Qtt0Xai5lQ0/xHWCZFiEWarvslv9UaAvL
 vvd6iaQ35mTOzuo3oU3LfcO3mwaEKKJrWsT0TlEn7MXhSdnQZUdZ37Gd9cvlrs7qvfSMK/pgRM5
 AajNNsx5mSFQOUiO7YoPxG9Lc+86dKIRlhYnU9m4ThavTipxWypCgKwD83NtoHdGTC2+1KvtF/+
 xZDPS4vKgI4NP5dmAqKn52pJw6SJbRKQyPIKYuIw/01PE0RQx4Lx4z0eJ/37vuWuVJNitVVxnXB
 ClBMRXGmcr3K04KlFnDdJoNFfg5UiozA+oriZzD90RIplGKPOdCQHvbFC2CNiS+BWg8O2jTlo37
 lemPMtPIM9Eq7fjbxm73qYMamJapL8mC6+5SfsYgGwEkfjT
X-Received: by 2002:a05:6102:4494:b0:7a7:19aa:8a88 with SMTP id
 ada2fe7eead31-7be7458369dmr275678137.35.1790770708060; 
 Wed, 30 Sep 2026 05:18:28 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7be14b3cfb9sm1298403137.12.2026.09.30.05.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:18:27 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 30 Sep 2026 09:17:49 -0300
Subject: [PATCH 1/2] board: sophgo: milkv_duo_256m: fix fdtfile quoting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-256m-fixes-v1-1-69546876ff28@baylibre.com>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
In-Reply-To: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
To: Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.16.0
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

CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes end up in
the environment:

  fdtfile="sg2002-milkv-duo256m".dtb

Use DEFAULT_DEVICE_TREE instead, which the build passes to the
environment preprocessor without the quotes:

  fdtfile=sophgo/sg2002-milkv-duo256m.dtb

Fixes: 98b59e181daa ("board: sophgo: add support for Milk-V Duo 256M")
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
index 4c1e17b53ca..4c9f53d0811 100644
--- a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
+++ b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
@@ -1,5 +1,5 @@
 fdt_addr_r=0x84000000
-fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+fdtfile=DEFAULT_DEVICE_TREE.dtb
 kernel_addr_r=0x80200000
 kernel_comp_addr_r=0x88000000
 kernel_comp_size=0x4000000

-- 
2.53.0

