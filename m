Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B12606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aTsnpOd+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mBCbsyzG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F72440748;
	Tue,  3 Nov 2026 12:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tMvzH1KVMbM; Tue,  3 Nov 2026 12:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88090406FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793709637;
	b=H2VmAnFPeNjfiASY8BdTev4aB971uKQDfhbbAQI2lqwCbJ7+TykdgjFOuFc+0xQN3pVr
	 MueJ9hEp/rQhVWZtwWK8Umwn9uG5QHfWmKszUm+Nzv9CMyMBx+r14bkhgSF6xgoyTwtp6
	 Ngt6xaJyOUuxZ40fUbHED+LCVzHbffLl+TZXgYoZTlkU7hTEdyzb/cVP0W/9qWYUY93Ad
	 6y2NfwrxlkC92dhk5loh06RQRZrMpQy8WeEd0GIuR1lE3KNjl/EB8rA3s8VM3VMw1sqJO
	 q3LgkvXoiZh10HKKcjZkANEmb5NIbIeATQ6dnQH5+85vlUHnh2jHG/BWaKfm/JYQFoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7K50RWrmZcEfcDcaRnK3Y1GaBBqmETF09tP8CYr182U=;
	b=GKMffoWQ6CORzGBN4c7AtGto6Z23FgD6bXiVGQA6E2rh3avIj5kVK3hndrdfdcQ+raMK
	 lKTdM5ASYbbDBcRhOu70tCcM0jfSDK8efWFJlZj6p74QBBjLQ0qbHvB0/O7GymbbClZSd
	 Wp7nn0Q+9Uw7PJFIYaZbvtEVJ/STKwWk44gW3FFbqPaNwLPi7SnW/iLs6ZOWg2Bg6OxgV
	 4q/VbQW8jBKTjRmVRZ4LdBpi96jZrJcRog0bsxZV0ALLRJe1Ds1L40T98W4jH4tSTEP3M
	 YjicUWeWLUvpD9Hg1kMdhAxqn/GeQMyrQWB0fAX4/zMy5sogS6Y3lzMXLHGNv3md1hA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mBCbsyzG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793709637;
	bh=7K50RWrmZcEfcDcaRnK3Y1GaBBqmETF09tP8CYr182U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTsnpOd+VUG3UeCVzmy8G2WzZWrMj35LLcwjF6lmgYb+iz/DamJLO0KAyJ8Zvjyxd
	 vosS2lVN6T3n8X/QgWGm/45nTpeT3fHRIHcUVqER6sJx0T12g6Ha5mCk39REhFKtUc
	 fbXa1JmCZVPFXvmgc+gTWdvuH/OdlW6/KEcvhXZtDm7FTnudkpoLEVR9xd9wGJ/KPI
	 0cEbt4yU6OpNJRXVMRWNnZzTDphtbQz50jWPuZ5O6EJHgaop9xK5MIGyc5Jj8um9qb
	 dZQqjHQQgfc/T98TPNmzLWxl0I0a5Z7om1X3xRiQw5madOrV1UgV4nqf18QaHy9cbQ
	 7y5YSnMBIdhNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88090406FA;
	Tue,  3 Nov 2026 12:40:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62EDDA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C3F34064F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2EhVqWuvt1v for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B95E406C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793709633;
 b=OuY8Ksa8Mb7dvQfBztJJ/dDbeDlgSIHQVrgqS2n0QB3+/vbv9LZS1+lb2D8m7lB2E+cT
 3Gq/uvJD55xun9mhpfr85KAEvaJR1dtemJBwkisZfaRwe5WifRJkUhbpoYu1cK2auHLCd
 uBLOUR2y8UYYWtjcVmUgzBYMhOKlsMUGUOlHu9oaGqWpUzM/urUbldNIb2vzDXNwBNXPq
 lKzerhwLvIQ6E/3D60CvyXwt04xTUaw0wEim1cmM50T2ySvQZal46VqtaNqXQOjK8oDt/
 DxEWIqk/KyJ8F6Ey6gI0NOA/x1pWcGyCYCL8Vk2NmWpDQsxQ867FajiRCBqF95r3NKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=7K50RWrmZcEfcDcaRnK3Y1GaBBqmETF09tP8CYr182U=;
 b=eFy8WLKf0QrMk4P9lKFt+Io7cV0AKxjlFpRSL7Kr11/I3OXVAhdriQfx3iqc60HK7ycp
 swsSyFA6SSfwWFeekIKRWDvb0U3Vob8XZuvVAadE/Xm28S36W3OHcyFk7R1Ql+QQyIbLN
 lrL9HcjHnCJAxZGDSXXqXFyndz/rjbWLhbk8p5Mt6k9KPQxaOZp2kb4gpFIk0N4aX3pqE
 Sshi6LVAALQcue107alLprCGSedTDADoSoYmXGd9JLgilBNre/L2xiGJwibcfNAH8LkIj
 f4kX92d7Q3Ryqf9MUmVvr4Pd2zUiKVUFikX7922FyllDz1C5PxpRKNMngWWC5RXzZfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mBCbsyzG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mBCbsyzG
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B95E406C9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:32 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so41963375e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793709631; x=1794314431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7K50RWrmZcEfcDcaRnK3Y1GaBBqmETF09tP8CYr182U=;
 b=mBCbsyzGIVfbWebOZRx8z0jG9XtbQzS1nPGV2vLW3VrwE7PudHEAT9/+U60GUZnmHj
 3jBRezKlVFeZhNxqktPzO0HmFKbU5YZAlk2ykrF9T8ptyuEDR1upISdsl6mUm8FoFjNr
 TdD4XzntSRNOR8eu2S/xxNwIGTpGrWkd76qVw13FUFAzXpLXOWmCpS7DGoRjrLMqu722
 mSLCUuRWZa10rtyOJ+F5ii9AAtiRx399WMBznIa4C09NW3HqiaOiisSJr/QuW1cH+pdF
 MeYyNjsEI5D87Cr0PDctYvwf4eUK4z2SAMcfdKzZflRMT7q0LKYGl3xJErwXsHOBsXif
 sKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709631; x=1794314431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7K50RWrmZcEfcDcaRnK3Y1GaBBqmETF09tP8CYr182U=;
 b=b9ZJytF8xH9TYZaj4TxKaVJObdTZwnB5iOaQGGg5oXjB1+qm/UU8xiAftuyfkNGy9e
 N18Bz1qRKO/aAknpC4DrHi2Mj27bagEywamUdQ7Ib05SAljVtvId5QoNV6tZOauFcqnE
 f13fVfmad15FmwwiLwH1xWKPObLeFXGipVtxkoemKfnoKyguAMqkyLFWYQaf9dCL3QFx
 9AHaxqhHCMS29aSGT2X8Ly0Ax3XXwrAg7gGFiXUtCdaSnX4XxL9s3omNN/ekOAAlwQVj
 k8FMNnC415SyydsZfd44MY+Bba5NUz8Q6E5c/2H9WEi15VNQW3/3E/8pWD16AHYK/KDP
 awwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsdODOJ9nXwRpxRUoAOjJibqqxZfKoDOIDGiPmUuFymVYIL/9lcPr6gdjTPUieTggKuN2fr20=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+j3Zm1KSy7zn5QqzamHd15TJvzJQl8mEPwpX75xnMHgzRqEAII
 267tUXtX4H6FIZtNRVHGxeRa585DszCFFevgSTb+QHNzMukxqnHZITdDZ6m3sPR5L7AuHPZ+pgP
 G6fqGTnk=
X-Gm-Gg: AYBFou2fMd/5hzC7+MwYuvrjcSmqAk/KcQu4RkLspk1AmaWKvkSkHXq4DPrd9zHSg5L
 QDFVEk7vYdUeld98KCGYwYbcZzVW1K1ZVANcfRuqX8UOA9UbYoHK4ZFno5mQ9n6oishO8Emqw8G
 5GTnQ0fDD2p+17MJsaweYw2LkbADo87ZRkAKFSHhsXbrLoPKDRmWfy/wNz6k3BFpPOQMwtFo7qQ
 SXc3B8HaaD8jYZ8xzWoM796Y8IW1GVfNeh8QV6Wzftm1/Nax+FiuaB/hFxHPqwyQOo84E7TzR/k
 NKVvJPyhz60hJOQ6Yg1rQbPWlv8eaFPtOqoJfP+o10dusVRn+VQasHDG8gI+ahUZz+6qtsafINE
 1ydhyj8lqo5ZXoozbYLCiLiiM0j1aTsaJNDhg2s9sZkJKW/VizSb4h0n1iIzGjcLvQjSJ1VH9lT
 IoCHWWnzClB58GoEPQST8V9/R1oOhLQwgba2GQOejJV231LQd6g7nK2n29j2OS2PNagjg9npcki
 fJclPONv2leOfszRktsuFlE97r4rcj7JrAUe3L1aEaUtvgxIyqgZZFDH6vGW6lPkaR67rCDpPeZ
 +o36O1VbMwDrapovcoLIURqJrT6XIse0uuAwiA==
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4ac17b2c8a7mr294254165e9.25.1793709630772; 
 Tue, 03 Nov 2026 04:40:30 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm60369835e9.0.2026.11.03.04.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:40:30 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Tue, 03 Nov 2026 12:39:25 +0000
Subject: [PATCH 4/4] board: kontron: osm-s-mx93: use common USB boot
 fastboot handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx-usb-boot-fastboot-v1-4-f3a918d55a20@baylibre.com>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
In-Reply-To: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, Christoph Stoidner <c.stoidner@phytec.de>, 
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Daniel Drake <ddrake@baylibre.com>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Common i.MX code now handles the USB_BOOT case by prepending fastboot
to the default bootcmd.

Remove the osm-s-mx93 USB boot handling which is now unnecessary.

This introduces a behaviour change: previously, this board entered
fastboot with no delay, and dropped to a U-Boot prompt after the
fastboot session ended. With the new, cross-family consistent behaviour
offered by the common code, an interruptible autoboot timeout is
introduced, and the default boot command runs at the end of the fastboot
session, which will generally cause any newly-flashed OS to be booted
right away.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 board/kontron/osm-s-mx93/osm-s-mx93.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx93/osm-s-mx93.c
index 23e33bddc53..dd853628a6f 100644
--- a/board/kontron/osm-s-mx93/osm-s-mx93.c
+++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
@@ -91,11 +91,6 @@ int board_late_init(void)
 	if (IS_ENABLED(CONFIG_KONTRON_HW_UID))
 		get_serial_number(uid_otp_locations, ARRAY_SIZE(uid_otp_locations));
 
-	if (get_boot_device() == USB_BOOT) {
-		env_set("bootcmd", "fastboot 0");
-		env_set("bootdelay", "0");
-	}
-
 	return 0;
 }
 

-- 
2.56.0

