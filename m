Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E7FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B31C80601;
	Tue,  7 Jan 2025 14:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ah+Hxx/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D778036B; Tue,  7 Jan 2025 10:26:09 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7DE801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216634dd574so147334905ad.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736241965; x=1736846765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvEgKXh2NVD0vCGLuHFk4n8pEg4bbSxKDzfZbvMmPf8=;
 b=Ah+Hxx/uUicUrirc6h3y9/7F9Dva97GeQDzzt2pTBO4b4yDi/TAD0nc8yo9mNfo4kZ
 9mHJ9Ws7KcRZY4RI6nHZkZRC0LWnSndRu/2JFnlXcPTZ5En9uH2E11VsSODr2I9IhB9V
 XnqeeAvHRA8M5amhsEr2bAR+EUMvcEIGgfDnihcJg1BjdCsHaByGmBN7caEuyJd4er1A
 /AN+eQMz6e1O7a+10D5nLzK95vfQSIGh2vShfd7jRcbmUMsNRLqvYG1iExX85UFqcBZW
 xrCtoeSzmjLqBskbNzag8jByMbyStGBFT4A9Mo1vX4hh3h2h/Mz0YCJT/FheG1tJlq7E
 2Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241965; x=1736846765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvEgKXh2NVD0vCGLuHFk4n8pEg4bbSxKDzfZbvMmPf8=;
 b=Qk41SKyADcNqBT0WjdKFm+uP5Oku6sxBN/kKnAUyXOQUumEkMdLm4mKUubTCc66sX+
 wXl3IHnCArh66B0USAdx+vQ8QzlZadFL0wU4qIVcKGZP8XdGW5QdkDwJD74zQ7mDF54J
 bHmWT+ET5213HS+lpg+qCtymdjXmYOz3C0i8WcZsN8rSXvm3s3ClRDjmwlpfL3DM0tjw
 HJIjGWNjcbiZLAXqU1WHiTCsij8RibonSu4lVZOoABAfDhNCeYlKLu+ll5qSK5kWqcOt
 v9OL/PSg55MAdlK+0HmjobEFWI6cdH3IpYaZWGrpv+MnGNC2n3P+W36cjTyreOvYtfAY
 F9aQ==
X-Gm-Message-State: AOJu0YzAUCQ1VniHvyjH2nNbYEM9mHDVUjiGSlAELoHWxhc0zV2qZjTe
 Ce5j8Zw1J7OnQuNdJ0taVf5H1t96Z3dqGakd1zO2ebimdzM8OBjkUK61MJfr
X-Gm-Gg: ASbGncvHf6u53iKAX5+fw02KifyBK4a++jk3xOhY+yvL3FvNzhRhvUk8/R9E9Tx+zew
 fyFLoYSbvBN0xWYn4GJK1HdEtUQj170NplGcLY4qj2t1x0qFVIAJ266/OuEadfGNHOA6cOM8kRK
 +mGpFk0hZxem7czFz/+AGn1DwtGqdt5GDL2fw992LGTF7FyIJ4TgvxM39VsKEpWW6JQ52h0btJj
 HW0rU1+hgmyTeW70+lOLBqLPCpnDudQqK7+E/zghNIqv06aemvpGv7kJYZ2RbQgiTWEc9k=
X-Google-Smtp-Source: AGHT+IEsIpIiLnCGCv/VBUYd896K1nH7bWbMYjB6k5p5GduPnVGjX4AZYzRm+fKfeetoNwqPt6+t/A==
X-Received: by 2002:a05:6a20:841e:b0:1e0:d73b:15e4 with SMTP id
 adf61e73a8af0-1e5e07ffc48mr100440113637.29.1736241965289; 
 Tue, 07 Jan 2025 01:26:05 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb09sm33806352b3a.121.2025.01.07.01.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:26:04 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: u-boot@lists.denx.de
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Custom IDEAS <vanbaren@cideas.com>, Software Engineering <wd@denx.de>
Subject: [PATCH 1/2] spi: spi-uclass: Fix dm_spi_claim_bus()
Date: Tue,  7 Jan 2025 18:25:39 +0900
Message-ID: <20250107092544.1798497-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107092544.1798497-1-kikuchan98@gmail.com>
References: <20250107092544.1798497-1-kikuchan98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jan 2025 14:15:02 +0100
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

When dm_spi_claim_bus() claims a bus, sometimes plat->mode and/or
plat->max_hz have not been copied to the priv object yet. This can lead
to an SPI bus malfunction.

To fix this, use the object returned by dev_get_parent_plat() instead,
which is set by spi_slave_of_to_plat() on spi_child_post_bind().

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/spi/spi-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index d604975374..0b3f29b6d8 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -54,7 +54,7 @@ int dm_spi_claim_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	struct dm_spi_bus *spi = dev_get_uclass_priv(bus);
-	struct spi_slave *slave = dev_get_parent_priv(dev);
+	struct dm_spi_slave_plat *slave = dev_get_parent_plat(dev);
 	uint speed, mode;
 
 	speed = slave->max_hz;
-- 
2.47.1

