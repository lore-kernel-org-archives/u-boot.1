Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB798C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BD9D60BFB;
	Fri, 18 Sep 2026 06:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMniQGRq2i39; Fri, 18 Sep 2026 06:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D265560BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713391;
	b=GYNlNhEwxR9Clj7ctnrt2CiIekmdBvmWyRfAcJ9ijw2xtrSE2aXdjzUss1xq7YqzzjqF
	 yfQ3XuuR+I0OI83Ng+YVVEc0b4pjGWnGIVOsaalYo6DrxVU1CCObQ4uU7s8uPGN03PkyN
	 waBj5p32m0rDMbKlD0pKfyW3CHCxuCqeYlquKrguoE7SDok3d86UOtCWsQprgUCur/Oi+
	 BjU/zOeCVYwO3pMgK/rC1EZgs7b9INSqp+EH2uifSRP8iIttAqkF90wOLAKsWrm/AJJ6o
	 5uUYzGJ3I9ppCyJPxRuk5NsMlNe9KsTl2AdLVB14wNMMqnVsMvvjj3LKbNEla9lhl0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zbYLKBDztYk4sA845F1rfFg7SRExqu5DGAtQxriwwZA=;
	b=KiWtniPuqE80RGEAEnCgSEWHaapoq9sjExUuVkQEOb7paUzALJHZcfKBuSfC2br4nMU/
	 C6aSjKzfv/pukUX3vlhm27HOamR7yRlIdMEAHdhu8C1zLpE8XcYPFzp7auZbbjlhPoA5L
	 0QUZDF7czS/xzzZfBGDIK8CERFGzMNS0UK8MtkYiHCvalzZXs4r2DAsEnu+dZjHDY4dWj
	 SVnnT1aqfhWz+ksSJx7u5epQo06tnm7O7X9Z2Vl1rSz9hiU8r/YXeY+MtuCPoVNJ7t7PS
	 nDOiiGR4j3zuVb/gVQBxsKyYz0E3JceAjA8olm2Olb0dR+MCus85pwkNMparDMLaLjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713390;
	bh=zbYLKBDztYk4sA845F1rfFg7SRExqu5DGAtQxriwwZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RwGHlqalz9elxql+b3e0K8zTQE9p/Wkcau7fBgfwrTqSPq+RUlkjlBe1P36Ub2Yo/
	 MLHHA5gZHFM/RWHuvcAI1grLVEO3MrL6Eh3VjljX5AdMxn/yPOQCo7DNuzm/+pOmeG
	 vWvDk0FiP7xKh/a4QDmT5DmVB/rI9iiBxAgCqQC5pShJ7DCECaGOM/h81GXwHYkwR+
	 r7lLjGIn6u67h7nGGgiAlOyn289C/IEeD/Uw9tC87fG/YHWAJtw/T4pxZh6bB3rD6W
	 33akaJFmvoUSyD8v7cpv9By4hyPJjOEgodlufvnECQbvSZSqqNrBGRwl/ZRxobbx3R
	 OFApz1dE6h6Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D265560BED;
	Fri, 18 Sep 2026 06:36:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08D4A422
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2BC0404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsSNELYtFGfn for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 01D51400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713388;
 b=buNjbh/VTlm3jCYboxpk4ypsfNlhAamjf3+8pjq9SrEK/UzNejm3JxVnDevtgG80ZcTf
 T7vMNPbmuDrRjm9z5RZWNRV/ZBYVLeUog1TQExJE3wnpPHjfRfPenzb4jVquCetxJOQME
 vw+FUKf4/WRrhy9YORddj48MH6B3Ag5qgiVVELLJqZoRkD41x+1GeMwrEF1srczr7H/tG
 HWa4RufDzh5N6JPV9NKn0MpoaGOYQZGdssuMCkxf3Qucol6NxAayuTHp7ktZrDD0EvZ4X
 EJtaoIfVB5D/usJEw86/DNfzTWPb+6WfiV4ACFqss2aCibhhKb/FblcrWlEBr7I0B/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713388;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=zbYLKBDztYk4sA845F1rfFg7SRExqu5DGAtQxriwwZA=;
 b=MmrUJ9MGn2egeH1QD4SFaFUshIb1NtCoZtbqVIZJeb7ow4b7dkAIPnT1kWwErtocpm0s
 ZyHb4g0/9LZriPOleWaEi4acIEKFvnWLCIKkB9iYAMni4ZD8RbsY2joa0gXICfHO0nxz3
 TgIhEoqemHTnOYbePq1Mrhh7pWiWCLxrTiZzKZILcVS+6BKrdXPlvYrAbile5r3/iZOWw
 +62a2A1tlrvMC33LhxJ1MNaK/4qudcDtGozpBJ199fhOugBUSAM/mHlRweT8K3aLsA4Ja
 vpnJarLShBqOEeNdvwLVdhZ8Q5XG1HW/AQf6QrF9rkYooC1C7rWYrMXA2GZtdIsE/Sg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3zH90b66; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=3zH90b66
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01D51400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:27 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so1760025e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713385; x=1790318185;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbYLKBDztYk4sA845F1rfFg7SRExqu5DGAtQxriwwZA=;
 b=3zH90b66IKcs6tKMJ9W0U0Ikv5odSuDlBZggY57Mie8DYc9fyb+ICNYYjZsctS92zm
 GOS6qjGaApE7kNeXKr4KQHoPmNqYh9NqgxDSoBlc5BDpOKWy3qVp89ny89izml05EYML
 MYrREqGhPLTdInh1cbRRa1bAiVxTZjiPLoTFmnVgzBQu6T6CcW/Hn87pK1c5xPXSK6ff
 cFmB27DW5xsxNf1nDd3MptKIF21WPTpO3abxy/tSkAUewHNW+rES9cw5UNXvNbOafvQ8
 GD60q5nqbbuqqRNx5TOz2euMoX9KmJlI2d1sZk+XZNDO9MNoIhEXioO3+74yErXNL40c
 QU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713385; x=1790318185;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbYLKBDztYk4sA845F1rfFg7SRExqu5DGAtQxriwwZA=;
 b=uBlUKfx6rAiPSc7eERjh9cnrhMoS6TmEBP8aSvbUJWoEf4k8cSa4nkHYQgnX6WRVsU
 gQ3yeEs5e3TLx/I2axNWYyYpVbE6Ntp/uTSFKAfhIyhE3bzhCPJ7uXBEoODgNNDtnn+n
 +Ao0N8N+3VjiF+BcFLV9elBT5kiAuCuNH4WyapIZVNToEwvpO6aUTs/l7PespS4RNjSE
 MZdRWErR9JVcLAkwQx1wzdPxQyW8RaWtKlTNweKsUUjdvLz53OG2dEUVyS2CMkKo/xCs
 wwtY8zNyo8WRUE3tN7zi9Yx70B0sim1sON2YBjNKV3OwmI689yMChZR3ERwAgVNEOpR1
 1wDg==
X-Gm-Message-State: AFuF++nqm1DnBLGWPEWHP00o9sySJ0iw/Z8+ILvbdKtroNN2+0JI6Ims
 5l1lordbkBBLrhsgFTztWqcrvxTqc1LioX5VwpJ/Eb6lQ5p3cRDdXC4QG09JHVfYvCQ=
X-Gm-Gg: AYBFou3WnQMAZzGCIY0AvAW6s0UDGFFzrDJenSToc/7KAn7U62bhAyMmsFsaNX5Fkop
 /jMvlDX4ArhoK3cqOq0G6OhL95XsNh5bberKhsc3Bt+tuvZ3xwkzKygZqYQwWwzDyZudD1byayL
 KMYWudHQUjCSPqGGOkGIHdCqNpM+YbiOH6WapeiLHgplHCcxX/5uxGJtoVXUz6QOvhPnWwgbC8J
 jWEnKp827I7qjIdyg/zeL8C1n9q+rFPWTxOWuszPw7qPDcpbwEK/1x+YEspjXMthR9KCRmtrbw0
 Dl+fh8hCEvkgIoK51Q5C0+pEfhbJgbGM3F3++PyZfZX5YmrMjo4t12ge9SxVHOyW9K9tCpjU0R6
 qXJsf+2F6dcz+/itgfiM4l8JRgv6FidbBzquL/aR7G5tISw3QaucLgCv36GGo0z+26ztyYQ/BMA
 h7NfCRpArgp/s9t4j/+0QvBu+uEUrnJBKaEAwyb4Lm/w+MtukXoD2pRSkY5LbXjRzKKO/ts8Uuk
 BQBb8cnUQ7bP6AKrqTeC9bbQORzhm/Ini2uMOSUcbjn4aonaZoQut4qJ+agyQ==
X-Received: by 2002:a05:600c:3ba7:b0:49c:fc6c:be00 with SMTP id
 5b1f17b1804b1-49fc57509f8mr18917505e9.23.1789713385473; 
 Thu, 17 Sep 2026 23:36:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:48 +0400
Subject: [PATCH v2 07/10] ufs: define the well known logical unit ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-7-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=alchark@flipper.net;
 h=from:subject:message-id; bh=2fYs7cu6GdAmgAHvvgASZDDXNUGKdWC4vZz+TcKN8II=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1xja7wzrw6hqnOpf1fVF+fOJC9Zc3Cf0c+3K3vy
 ZVnTD6Q0DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUr/7EyPDJ1u3Ij98Xg7miGRPvn45bNPX/61UHL/w/tXveNWaWJb3PGRn2C/R
 9mbAznFnZ+d726zO2lVne4ZC5WvZj0T8e57QwZ1lGAA==
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

A UFS device exposes several well known logical units that live outside
the ordinary LUN range. Name them centrally, in the public header, so that
both the driver and the SPL boot path can refer to them.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/ufs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43b..40088c935209 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -4,6 +4,14 @@
 
 struct udevice;
 
+/* Well known logical unit ids, as they appear in the LUN field of a UPIU */
+enum {
+	UFS_UPIU_REPORT_LUNS_WLUN	= 0x81,
+	UFS_UPIU_BOOT_WLUN		= 0xB0,
+	UFS_UPIU_RPMB_WLUN		= 0xC4,
+	UFS_UPIU_UFS_DEVICE_WLUN	= 0xD0,
+};
+
 /**
  * ufs_probe() - initialize all devices in the UFS uclass
  *

-- 
2.55.0

