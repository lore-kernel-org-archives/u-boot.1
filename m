Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC92CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 13:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B7487E1B;
	Tue,  9 Apr 2024 15:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kUOEt8E1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3FD87EA9; Tue,  9 Apr 2024 15:17:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9126687B89
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 15:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 60DD83F626
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712668624;
 bh=rWeDMrO7xnfdgEI7DqUZHWoWSGk6b/QWFNeWhOszL/c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kUOEt8E1H0PY2BmwHyGDJZRCg+ARdqeftZhzab772T4UQ49Yzj33SOnF7K7Xcv7Q1
 NCIpiHSlKAEBismaa9jL8c0fUjouPAaykMVz6LWghaXjbTVUZtrWX291MluT+sm2BH
 hsfMhJ1F0YxTdLnpd4sJaQ7aovFyBBwX6WjkmUTFM4Kd6gqwmOWPIruXYTkwkye1+F
 /AlIoh6NosArXQxlte6BLi/F2ivEAYKb9a/RhTLyC7LURC4tDCniJE8UGrgCQryJP6
 DPnGFyOaUrWwJRanlF1lXRq3LwzP8H7eK0Yv3mmFYYTSQh8iF94fQ0/smXsvrFU8aZ
 Q5lSSdm7SUk5w==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d884b718f1so22764981fa.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712668623; x=1713273423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWeDMrO7xnfdgEI7DqUZHWoWSGk6b/QWFNeWhOszL/c=;
 b=s4FbxNeXaUO5Va8tEd3SbNQroC8+KmZt66tm3Uoqn2mPNJDXLUhjU70hgKbej9KObF
 LhGGAs7/sT8v77lGO9HmMsHHNaE+CZvCRqO3j2prYEIaRH1dFYYjJL7UO9/uLoWbD21/
 Lg741Ui1ucjiOfediyR7F7q+Y24PKsjEWip6U8cGlkIBx/jwOD/Lfemu2KjcqlDcXpM/
 mNK3s8/5BgrcW4813//KChVEC/ixaMHg7bh9kjq/ey6Y/rqWReFYu+lUguh6SZHLSuX0
 4TeSUr3Kfa+kLKB0oMw1F964B4yL3JUJmNvDE2By8L06oHwiWJmJgSz8GHfXr6J6gSdQ
 F8uA==
X-Gm-Message-State: AOJu0YwFWmCOID6W5rvVbqM5VUaHu9g7IGD3dDMf4O6etvFFk8aU4bcO
 hyYvlEN6XXRc6KU783m/0Cfkk0ACaG4hntTIrb393+LjFl8jp+dOiXCZIBvUTQArptXio/qPnFB
 4Yy8CwjVLnKtBt2AVBmqPPIp4qtoY9X10TngBrZ6tLLUvlquvXaijsR6G69YkW91tFOE=
X-Received: by 2002:a2e:9c8a:0:b0:2d8:a8a0:19c5 with SMTP id
 x10-20020a2e9c8a000000b002d8a8a019c5mr1090282lji.4.1712668623731; 
 Tue, 09 Apr 2024 06:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRZ63+RNWe4rfMFnGwhkVoayU8C+oa1ZtSos06HS/BuVKlFkCQu3EUKnVEUNWJ7YHymQoDMw==
X-Received: by 2002:a2e:9c8a:0:b0:2d8:a8a0:19c5 with SMTP id
 x10-20020a2e9c8a000000b002d8a8a019c5mr1090269lji.4.1712668623326; 
 Tue, 09 Apr 2024 06:17:03 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 bd18-20020a05600c1f1200b004169f147ceasm3229366wmb.41.2024.04.09.06.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 06:17:02 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] api: add missing cookie checks for network access
Date: Tue,  9 Apr 2024 15:16:55 +0200
Message-ID: <20240409131655.59157-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

dev_write_net() and dev_read_net() should validate the provided cookie.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 api/api_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/api/api_net.c b/api/api_net.c
index 7515c26e8b4..0b931a80787 100644
--- a/api/api_net.c
+++ b/api/api_net.c
@@ -72,14 +72,16 @@ int dev_enum_net(struct device_info *di)
 
 int dev_write_net(void *cookie, void *buf, int len)
 {
-	/* XXX verify that cookie points to a valid net device??? */
+	if (!dev_valid_net(cookie))
+		return API_ENODEV;
 
 	return eth_send(buf, len);
 }
 
 int dev_read_net(void *cookie, void *buf, int len)
 {
-	/* XXX verify that cookie points to a valid net device??? */
+	if (!dev_valid_net(cookie))
+		return API_ENODEV;
 
 	return eth_receive(buf, len);
 }
-- 
2.43.0

