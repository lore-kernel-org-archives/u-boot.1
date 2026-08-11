Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3515DC5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E978C407E8;
	Tue, 11 Aug 2026 23:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZHV18dD7nCM; Tue, 11 Aug 2026 23:05:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D23F407E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489510;
	bh=2W74sEggzKkPhMT1e/f2q6M7t2bR2+Yqkqm9WdAyMNE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MY+u6enpoHqyE+m0EH+7Gy6QSO9GRJsmDHHIlALSpzENv4tevhj72CuiKuKzzeBb7
	 Nj5VrK74ICNds6BDolBGMpDtP8kBcXkZa4HgEgg6hwKTzbhmAzJFdEZbX98vEdobNp
	 PM0l1qS8nogVHyT4p/voceiwZmVqFzModFH0ujHOkx1QVRnE9UGx/L29ShtQfOIarG
	 Nam2tJQsZF+EJjoOg8KA2QwrgeVzqM8xwuiOkI5Y1nr5JgypiDBmxFtQPfnnZQWrZ1
	 sQYishz7IdrCEL+QNL22n4hkmKyyfTVQmpBs/ZQBVOotJx9E2xIBvghireUgXzCoj/
	 CCMD4wZ4Qi7eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D23F407E4;
	Tue, 11 Aug 2026 23:05:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0FF349B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7C7D60882
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbpvYUBZwdpu for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 19:12:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CA74360788
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA74360788
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA74360788
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:57 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a17c04563fso277274a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475576; x=1787080376;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2W74sEggzKkPhMT1e/f2q6M7t2bR2+Yqkqm9WdAyMNE=;
 b=agXnB/nLad2zPv/Gb5jjhMGMauWrOZI+hYJ6qFo/Kjsxo4KAC5sSf5X5stF8nWrVzM
 ja7YVDq5kkGVa8sJzJY8uG/RHfgiGdsHWBM0eWLDoJ2VvZHxtKme/GH/SKeR6rZrlxm+
 DwIjFZdZrU8v/IlkxuujDW0+cUCctWpUeEOTdYKopPm3+/uHtD3k7UfbqwPQNGG26SLw
 ST7IaeF0+flCQVYIOx2N8KCqIH+psaS0T+MiGXXgnRD38M0vJM2kGQZahcImJ59FLOJm
 xioF0MWoXQdheZtr9bySZ2P4PaddK5HpQgUsSJaPaWhrvBHdVoJcQcWA18+9Tdpa60Ph
 qT0g==
X-Gm-Message-State: AOJu0YzW/p/Eh6s7mdv6XGpO9KwwVkicHWi1y9Mp8DNtd0Faj8ZvlIjK
 xA0CpqW01cXzJJlb75vMOBJCknik5GTKMzsxvRaa5BmFH6tQV59lcJ73zByKlMw1EcsZNvK/UbX
 tXIFZ1zY=
X-Gm-Gg: AR+sD11jMlZXV2zNKaDlBfQwgXsLodpU3WfL0F3ys7Kr8xx5AZ8CdTP36y/SuwQfID9
 20lc2p347t3QhzFd2jjnWaKZFgS/MfkUDb5iWuSlDXgL85Uti1x0bYf0pxLkdCfSti+laLFN7gr
 kNOzdTVQJ4CDwAJrPoBu3oSF3VjZ6YEVsSUL73+UKaVaqI6Zl3KccSwK4JDgUlpsJqtu3zDzzGD
 J2XZlnVYA66JTum4iiKFXgg3mx9PBMO0hSdTl6EsPaC4yfAaatNVSY1CPo8UM0DnUlZjOBj7teV
 ra8lKIx1YLHneefZrIU+xphzkbrg8ML97E1l7/Xrdhg0DXdMAb60izAKp2VgMQIosJqJ8DiZPgn
 AOd9fEOIqTlZlqEX1y4FUsHnyy7dT6VmzujLwu+ZdSgOK0a/ZPtqI84SBytnDavJnXB5B+lKZnj
 rkpTCuJB43bGtTb2tGdY6EJzUyPO5/66jZs9qIkO2tbuv9lsN44JHEuVlcurdH/OSmWJIUBsnaC
 z01e2E83wulGlkAGwl2eHmEXfeCWK7s6xVU7dwZe/E5HqmfCNfI7g==
X-Received: by 2002:a17:907:7281:b0:c20:2eee:97c1 with SMTP id
 a640c23a62f3a-c20e600166bmr280921766b.4.1786472177661; 
 Tue, 11 Aug 2026 11:16:17 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0a9d52asm2288066b.33.2026.08.11.11.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:16:17 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH 0/2] net: nfs: reject an out-of-range NFS read length
Date: Tue, 11 Aug 2026 20:15:47 +0200
Message-Id: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNme2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3by0Yt38/CTdtMwKXWPDZBNj40Qjo2RLQyWgjoKiVKAw2LToWAi
 /uDQpKzW5BGSEUm0tAEPvDTBvAAAA
X-Change-ID: 20260811-nfs-oob-fix-31c433a22c91
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786475576; x=1787080376;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2W74sEggzKkPhMT1e/f2q6M7t2bR2+Yqkqm9WdAyMNE=;
 b=maIOo6+4+I2pXWAo/n1gSZPJ1W4GqgkUUlAntrnVX5qho+b0e3splqqs9Rw1waklS2
 splvdD5xyqA3hCq9wMhGm5fCmzNnQMGqHMt7NB9F3D+Z8ScywLfom4yz/HF+8w394/5/
 mwDJxU/5IwOzwM9mBhe5UgX0pvmw5nIps7CSTm2Ym81SBpUrB56kG65t/d8rH5NkDRfL
 i3ETeClogIvr2ylpGBOGWG+4WvjdQc3LARbSYjOHIb3DWKWYqY0YpEcr9KiF8nlZrZse
 WWhbXQUZelPesqtcVBAVYQJCzDrbqiZbnNTIPuwJyT8aKb1LzdvPn31QQIKJc+1e2Jkd
 H0Xw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=maIOo6+4
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A malicious NFS server can return a READ reply whose 32-bit length has
the top bit set. nfs_read_reply() keeps it in a signed int, the bounds
check is defeated on LP64 because the value is negative, and store_block()
then hands a ~2 GB length to memcpy(), which reads past the 1152-byte
reply buffer on the stack and writes past image_load_addr. Both the
classic and the lwIP NFS clients reach this through nfs_pkt_recv().

Patch 1 bounds the length by NFS_READ_SIZE, the amount a read ever
requests, before it is used. Patch 2 adds a DM regression test that
drives nfs_pkt_recv() with a crafted reply; under CONFIG_ASAN it reports
a stack-buffer-overflow in store_block().

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Shahriyar Jalayeri (2):
      net: nfs: reject a negative or oversized NFS read length
      test: dm: nfs: add a regression test for an oversized NFS read length

 net/nfs-common.c |  4 ++++
 test/dm/Makefile |  1 +
 test/dm/nfs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260811-nfs-oob-fix-31c433a22c91

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

