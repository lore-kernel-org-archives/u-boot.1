Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BD3C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 01:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF21874D8;
	Mon, 27 Nov 2023 02:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="oUuK9tzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E948874BA; Mon, 27 Nov 2023 02:06:00 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0E6874D8
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 02:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231127010547epoutp01aa395aed48612fda80ce1333a54ebe5d~bVV5UZilP3236432364epoutp01k
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 01:05:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231127010547epoutp01aa395aed48612fda80ce1333a54ebe5d~bVV5UZilP3236432364epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701047147;
 bh=cRsMv4iTBepVbmJkQvse/Yiwc1IdNf+e4PwiGRSEVtU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=oUuK9tzUpzcs42SO3VwYsSbn5JMMWq/almveTj2ySruN7cBsQNTgGfhD6SBGluLf+
 ClT6LAunxzg3zGI7BD5mcOuuie0JSjEcKBYMjPzm+ad8vlgx6Vbo9HOzeJGbQ/dzG4
 4cg8Prx81fIQJSME8aUskqw8xtebKs+wwI/6NJ2I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231127010547epcas2p1c3f75f0bfda88bb0d10bda40a5aa6045~bVV5AuOLC0512005120epcas2p1r;
 Mon, 27 Nov 2023 01:05:47 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SdnT672QWz4x9Q7; Mon, 27 Nov
 2023 01:05:46 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 58.9D.18994.96BE3656; Mon, 27 Nov 2023 10:05:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8~bVV2aTrVg0512005120epcas2p1i;
 Mon, 27 Nov 2023 01:05:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231127010544epsmtrp1d44c7036090240ef56e452ee4e4bdb4d~bVV2ZxKwy2962029620epsmtrp1h;
 Mon, 27 Nov 2023 01:05:44 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-fe-6563eb69a8b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BA.28.08755.86BE3656; Mon, 27 Nov 2023 10:05:44 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231127010544epsmtip2259bf2549b50d80238e279571cd5c483~bVV2JbnKa1388513885epsmtip2u;
 Mon, 27 Nov 2023 01:05:44 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] watchdog: Correct watchdog timeout print message
Date: Mon, 27 Nov 2023 10:05:20 +0900
Message-Id: <20231127010520.3170033-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmqW7m6+RUg/kvDC0u79e2OLnuA5PF
 272d7A7MHvNmnWDxOHtnB6NH35ZVjAHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
 hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
 5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGd1PdrIU3OOs+N30h62B8TN7FyMnh4SAicSJjgms
 ILaQwB5Gia/bCiDsT4wSV+eXQNjfGCXWdyTB1B/6tp0ZIr6XUWLVHs8uRi4gexqTxPFH28CG
 sgnoSmx5/ooRxBYRMJaYsbgTLM4soC3R+XkKmC0s4CjRcraLBcRmEVCV2LriOVicV8BBYt3H
 pUALOICWyUssfiABERaUODnzCQvEGHmJ5q2zmUH2SggsYpe4930uE8RxLhJLn/xjg7CFJV4d
 3wL1pJTEy/42doiZ5RI7liVB9LYwSjS37WGGqLGX+HFzCitIDbOApsT6XfoQ5coSR25BreWT
 6Dj8F2oKr0RHmxBEo7rEge3TWSBsWYnuOZ9ZIWwPiW9/J0JDNlbiS2sfywRG+VlInpmF5JlZ
 CHsXMDKvYpRKLSjOTU9NNiow1M1LLYfHaXJ+7iZGcFLT8t3B+Hr9X71DjEwcjIcYJTiYlUR4
 c//EpwrxpiRWVqUW5ccXleakFh9iNAWG8ERmKdHkfGBazSuJNzSxNDAxMzM0NzI1MFcS573X
 OjdFSCA9sSQ1OzW1ILUIpo+Jg1Oqgal/4s9I1Ul+VTOnei/P7toWMLW3zD9PcefGs9sDevlL
 5my0eGu5Pfhu37U3pT/C9Y8zTNrAs7BvUmHQFy6RtIJvJRG6V/+eKDMVjHn8aco2x7TIRQZd
 zGKPpPt3BH5+z1z342uByv7fW0zd//3h2Pho0+lr3ifuSpyrZrwl0Ptjy6ru/6pMt24sXhFR
 Ut8THLNWyDNvEU/wDYElu+LduHd/8z/joRRVxpdf+87ohoSWZHj497a3Jo2eB6feTT+zPXn+
 /Yf3by3ZaNeqYdof9W7N1OLW5ZW6R/uMNm4svhS7LeDMUbmUyAY799cv5JJU8q5veFTXuzni
 ulDwMYuvr8qvud/b1LPmTsKfKTt5LL2UWIozEg21mIuKEwHmpyVI8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXjfjdXKqwY/5ahaX92tbnFz3gcni
 7d5Odgdmj3mzTrB4nL2zg9Gjb8sqxgDmKC6blNSczLLUIn27BK6M7ic7WQrucVb8bvrD1sD4
 mb2LkZNDQsBE4tC37cxdjFwcQgK7GSXOXL7FBJGQlXj2bgdUkbDE/ZYjrBBFk5gk9p76wgaS
 YBPQldjy/BVjFyMHh4iAqURfWzRImFlAW6Lz8xSwXmEBR4mWs10sIDaLgKrE1hXPweK8Ag4S
 6z4uZQZplRCQl1j8QAIiLChxcuYTFogx8hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLD
 AsO81HK94sTc4tK8dL3k/NxNjOAw09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeHP/xKcK8aYkVlal
 FuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYNqfJN5T/ZJ1CgvDb5tp
 Zuky/GEzioQ7Xv5cOeWpvKCkiY2cduPEr+51B1bNussvdoB3I2tzzM1My2KfHj7u5GNuzy7N
 M7vDwfJKw1hIztit8G7/qze81j3BOq87TBpSdS6W3kzyKNDv85r8Lv0OUym3g2krx38W/4c9
 jS8WmuUsOaj+zDzD8lq6ipG999Krj4Nuz0p5u4BTUmfKV1ub+5kOuzZPYa6dJPZ/bqrQqdAd
 fiFvPW0jfbfcMwmZEVImwjA34LVwyIfC0E0LhAsyns9dmee50ln4pSR3Q9gxGRm7z6F1j1/X
 zmcOc1OLz3Xinsng6NySc77m8/K3nGbPFrRMkjF4ek7oTHSwUbgSS3FGoqEWc1FxIgCCdHVY
 ogIAAA==
X-CMS-MailID: 20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8
References: <CGME20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8@epcas2p1.samsung.com>
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

The wdt_start function takes timeout_ms as a parameter and starts the
watchdog with this value. However, when you output the message, it shows
the default timeout value for the watchdog device.
So this patch fixes that part to output the correct timeout value.

Before -->
StarFive # wdt start 3000
WDT:   Started watchdog@13070000 without servicing  (60s timeout)

After -->
StarFive # wdt start 3000
WDT:   Started watchdog@13070000 without servicing  (3s timeout)

Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the cyclic framework")
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/watchdog/wdt-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index ed329284decb..65a4bc1f90ed 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -141,7 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       str, priv->timeout);
+		       str, (u32)(timeout_ms / 1000));
 	}
 
 	return ret;
-- 
2.39.2

