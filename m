Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA8C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD1E880D6;
	Wed, 27 Mar 2024 12:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IClEfxXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E1088069; Wed, 27 Mar 2024 09:11:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3DD88054
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBaPldpyUviI5ACe71jF09eXL4XLFU/dH7+Or9iWqMU=;
 b=IClEfxXI/zrbxPCWavuzg6yUBZyRVd++hz/LjQ++YI7rwuJv00KrNIxFk400WqtEVEbtkM
 +8shDSO1dZ/uxIToui5SzWY1VvtAOmXaf/tqUzBUgbE34j8F/OuT6UaGyYLzmGTxIp3TO5
 qOrUjqrimA07KALFfRmWpDJXprt77gA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-_47U13TTNNeLyi7KGEVsrA-1; Wed, 27 Mar 2024 04:11:13 -0400
X-MC-Unique: _47U13TTNNeLyi7KGEVsrA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6ea81ca3883so2909778b3a.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527071; x=1712131871;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBaPldpyUviI5ACe71jF09eXL4XLFU/dH7+Or9iWqMU=;
 b=p5hJQ/j/T6xNHGXEgQ97iZjhTIJFB4ru5OKwlll5QJuH2BuEg5EbQ/KmqV9j1NAbjM
 /p7B3jUeuvlAghW6wr5ffTrh7zjoAgkPINiXmpAwOTMTL4cLaFG9z+awtK3Vz41dxw0N
 A6NZqD6S2SlFdl5ap67TFnqzjpGU1lhlu/t842eiw9e4DJbXXB/bb4ldvMbF/C+TtI5j
 hZa9+1G+tmRMvSEYfxkrBda0QrxgagyyrC+PD19cBN0JwlUmxYxGkthL/CwmJN7yr2JT
 uLe4qTHv8UZ2xUj8aA/06vnJHXu7ys2ZN40I7NMIaj5+mCqjZ6fr5bnQ4jpm/GqgHxXT
 xdvg==
X-Gm-Message-State: AOJu0YzDiByJFlUdbodtuMiSlWLPLmvEB0oR01FURt92lVR47sFJV+pt
 JnzDbEPqyczbgd5BUeWvyqeXbbgWtNpe1wrpITvG6tPk6P/JO+ko83yIFk5h0SADiaxNSEmQgFH
 jF27pua3InZJlu3i+alduMbeaxxGsSrct8cBfCtnqVc68pCqDAagDog7hBqx6EplEha/KTCs96+
 s9xpPPJTvJYIVip600OLPDHYmylZi1IJstdUc=
X-Received: by 2002:a05:6a20:549f:b0:1a3:69a9:e403 with SMTP id
 i31-20020a056a20549f00b001a369a9e403mr5958672pzk.39.1711527071630; 
 Wed, 27 Mar 2024 01:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaSkBfhzpTBcsbUGNfovivsDvtiVgzu49yOd69jnlZB5iumsRrjB2jE8cGB4icfrC1ieeSEw==
X-Received: by 2002:a05:6a20:549f:b0:1a3:69a9:e403 with SMTP id
 i31-20020a056a20549f00b001a369a9e403mr5958635pzk.39.1711527071180; 
 Wed, 27 Mar 2024 01:11:11 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:11:10 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 4/6] net/designware: add compatible for "snps,dwmac"
Date: Wed, 27 Mar 2024 16:07:25 +0800
Message-ID: <20240327080817.44501-5-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/net/designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index c222197b11..bc2726485b 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -861,6 +861,7 @@ static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "amlogic,meson6-dwmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
+	{ .compatible = "snps,dwmac" },
 	{ }
 };
 
-- 
2.44.0

