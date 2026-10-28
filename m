Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D75606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yWS5u5Us;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=D2TC4RBT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E8AA8089D;
	Wed, 28 Oct 2026 06:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpyF6r0dYB-9; Wed, 28 Oct 2026 06:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9518C808AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168025;
	b=EECzHkuzzYfrK4srHyGDxOZTgoON1GsntpToyo6dRoLmwFBIc4UckgjaDb0RbY1T/dVD
	 SgxfvKZBcj9jnUD8nDPgEEGHMgjKD//L1+v4e2cPWp3afzJZ1+4xSqO42Th4T3ZW5kYcX
	 R0pXql5SruI6YzEsBNkpNEQClq6RSdWqJOcXzpqkLWxb9xePx9vrk9ZhXOuVvrp9wL+Am
	 ONVGJJyTiCspbm4fZDc+6C3HF+Mmt/FLQPg0+zI8ERtTw2GLm2u1XmqKr3lEXESfz4X5G
	 UYz1Q5onHzcd16t1QmS27dCVLJYi++hCVy1ODzjhzz8lmuPOnZHbVIuj4QY5eEcjM8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GzUx75ergh2BmmyeIwlBib02HbwtSfgniZZ4UiTVe60=;
	b=s8wOGn4AY435N/UvLM1Egznj5IMILQCMGF2U8hYBVww7yjo3eXaRMrP7N+WYgMQqYTl9
	 ZjimoAJ4xMZp/ydjnQsQfiINlG67ItKbawVdHEwgsJ+7uZz0msNzxL4NfT1dZ5kQWxfkN
	 5hkBVb0hGavzhgjxTgttCOVBLqaitNv5IEMD6QlQuTDdTawvV4Sfrq2RVG8EdcJVK5d6v
	 7DP9kFgSicu0y1LAYBmItwqi4e6HqNUuPlPoYaeFupcG0es0o5VKbHvQ7ujgYNXFDeI1W
	 /3KY7a1fqIodJ3b7dMjlpkwMyDESTcKmMSe9LYIDBaC6A/5/SqcoXdcwft3hoovac+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=D2TC4RBT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168025;
	bh=GzUx75ergh2BmmyeIwlBib02HbwtSfgniZZ4UiTVe60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yWS5u5UsDnj2UYDzgH0GWp0xXHH3o7ydNTL2zMiKagO/RKTldiRTki5u+DXQ5mwRz
	 fLLp4NBcwxwV3W2CQj8LGZuZhJqfMUyI9FHHc+7/WYpOUsn1ZZavEq1vIPoFuIuxvx
	 lETmyqBsw499h190zeXlG3muBvBNCIEmmOYFPnUW4x4XcjDspWTnUHjH0hvP30tY6Z
	 hybeRU987DMkhWx6JDqZSilxL8LrLFHWsM03r54g+dxBCHYbgTruvxea1mi0w3zrGP
	 Q1zmQQ5gJtNZx9btSTddZdu+ywIXM0KSAXuu1/LOVGqaHVjgChRAPtNdjl2dhXz5Wd
	 EHCABQhBaFtjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9518C808AD;
	Wed, 28 Oct 2026 06:13:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D6F473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B5D680848
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRJ5lkPF9WRG for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26F04806D0
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168023;
 b=rJS+qPM5CRp14Vm21y1wUMfddxRZ04m4uX5aK027lT3SPSpJ3yZ6jLVl3EfbB6w071Di
 9fWYzRMB9aiCWbC8jDh/s3pbZC80GiKOpOA2WiQNdD7gsSaYqTcfQbcL5MMcLXUmIwOBu
 7GjAwd6B+mO2Hf7IoHyPfA9cIkvRRs/sE2Uc+MAOz01qTiOH3HgxJOJc56/mlcqHVLhdT
 36SF1NgLDiLWUpfUdhLIEo24a5aLns9auVkl1E0lu18xgj2DbvfEHAGd/hK362NDOLbfj
 YBRWpvFgXtgSbjbDhWXnjRYLmEA5pGHXilhowvzdfMQAUmOr4VEywT6A5Dzw0Urw/Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168023;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=GzUx75ergh2BmmyeIwlBib02HbwtSfgniZZ4UiTVe60=;
 b=ianP/mQ+cUkH4FIqKxZOHW1cz6dK0Nd5wRljZGCLvz2Dnrd3eWuIKml7nXXyyc+E2r7C
 RcDA4pV+ps2YEaXWLfV87LGiMzfDvjwtBJ0tBhPQ5TXFLgYnhDd0tbwXZjqOOoNkVWgCW
 Sip7oiAFIx57ni5tdW8b+ujB/V+spkIDECbbdgLAaUKnNDjpnWc6ayuo9vz0QDFSG9GQN
 7zM4F27zIHVTpJfD3QpbgLw9qdZgF1qxBzsGLkjyt3zCWp/KH6raKveNqMlYJ00suz14l
 DveH6dFXbyyleANuOHL6pMxUeszzsuu5gbRAAHEjp2yjB7lhp6GkR6PX/K+yaVtmwzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=D2TC4RBT; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=D2TC4RBT
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26F04806D0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 715BF10BAFC; Wed, 28 Oct 2026 07:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168016; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=GzUx75ergh2BmmyeIwlBib02HbwtSfgniZZ4UiTVe60=;
 b=D2TC4RBTBgvINhWXqGkWvFo+4r/oZ8F5SqaMgkdRNaalSdipgiyTe0QLEXTxZ9WbAdFdCe
 k66doiYx33XIMgkXVD57aGJNf2IEZfwjYheGQR5gEQVoWjmwAb5QgVKGtNse8B0B4gpSN3
 neoJlp+r5PyibFqRUcALHt24UdFUluuZjrCP+cPPoDq7nXfYzLDBpKkgKL1EuzPi9YhNls
 MIZ/5nGzCNwPnoHxu9ZiTuvJXU14BU0vKPnKMvrj0DT795J0v1egmnehLaGPaQaABYhAQE
 Uo6okNHwvMNX7hG8rh+J/3G9UDDO2oFSeWUJUjT3Sm8LDB4zmQNdQv+04LazTg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 4/7] test: boot: imagemap: pick the SPI-NOR by its partition
Date: Wed, 28 Oct 2026 07:11:38 +0100
Message-ID: <20261028061231.39152-5-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imagemap_test_mtd_blk() takes the first block device of type
PART_TYPE_MTD and works on it as the SPI-NOR of the test device tree.
Every MTD device binds an mtd_blk, so a further MTD device in the device
tree can hold that place, and the test then looks for the "nor-fit"
partition on a device that does not have it.

Walk the block devices for the one that carries the partition the test
needs, probing each candidate on the way, which is what the single probe
after the loop did for the first device.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v3:
- New patch. Problem found on CI run:
  https://dev.azure.com/hs0298/hs/_build/results?buildId=223&view=results
  The next patch gives the test device tree two MTD devices of
  its own, one of which took the first mtd_blk away from this test

 test/boot/imagemap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index de00a174470..717d4d5fa71 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -539,17 +539,22 @@ static int imagemap_test_mtd_blk(struct unit_test_state *uts)
 	 */
 	mtd_probe_devices();
 
-	/* Find the bound mtd_blk (a PART_TYPE_MTD block device) */
+	/*
+	 * Every MTD device of the test device tree binds an mtd_blk, so the
+	 * partition this test needs is what tells the SPI-NOR apart.
+	 */
 	for (uclass_find_first_device(UCLASS_BLK, &dev); dev;
 	     uclass_find_next_device(&dev)) {
 		desc = dev_get_uclass_plat(dev);
-		if (desc->part_type == PART_TYPE_MTD) {
+		if (desc->part_type != PART_TYPE_MTD || device_probe(dev))
+			continue;
+
+		if (part_get_info_by_name(desc, "nor-fit", &info) >= 1) {
 			blk = dev;
 			break;
 		}
 	}
 	ut_assertnonnull(blk);
-	ut_assertok(device_probe(blk));
 	desc = dev_get_uclass_plat(blk);
 
 	/* Write a known pattern into the "nor-fit" partition */
-- 
2.55.0

