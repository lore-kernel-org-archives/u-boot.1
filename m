Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B36606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CVtJNLeN;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hobCzSZl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8004480FA2;
	Wed, 28 Oct 2026 14:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azEtxarSDbm6; Wed, 28 Oct 2026 14:46:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91E6180DBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198780;
	b=BmeUvLEmigNXIVfMBd5nYBOf9A10veWzPKCxOrYWDhTphtO14F/quehCjGpQS0rIjS6T
	 mKp7RsgmFPwSgkVLz6/e7Gs8UYNNGTs6Q59R2ub9XnKSL9TNxXucPMJuB9GuyjbNnJnrb
	 dKY9LVelP5sz+OWYBZ9ZGCY8jmRlBbd9xby5NAy/E49DSzhpQc9sYQBZapaA0to6maZ/p
	 2PQUWj8fDE52Y7SQhmfZtGDHtATNrfwy0CmKO0oK7eRsUoUJKkM4/2W8y9K43Dpgp8dA2
	 r/3Hj40djPaQOcPt4XYHQPbvZsjZce/OEEY/fVzJsVGJn+2cujFVtJ+1Rb+X+JNLd/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cyn5oI/HfR7PCon/LDawGNNoVjLTJ/gcCALrAWyluCA=;
	b=bo+6PFWmhskFnvEbLeAqvmcmYErhnbP+U78cJlcaByHK23Ve+k6wQYnH6ZjA9RYB5U0O
	 3ACbzTpeF2sTXcIih89irakg3FFw6j7rtKAEC/gXdA8Z9cWm4LRI1DeyV0EnR3qtk/3Na
	 BNlCp764Kd3hdh38+X9L+8xYpdnL+AvMGwRXBvvcgU5EYANaHqHQ3vz+gIfbIxAv11ZmD
	 BYXgP+3MBZURPmW1uU54YK1Wa4Tq8Uf5PA/XjfsVILYTklTgyhoQdWav4RO5zNLmXGAEy
	 Gxg4oE0/DmEYag4WimELRQYU0aSImb+S5tqf55QZujRjdM6wF+BVX5KsFJqk88tUE1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198780;
	bh=cyn5oI/HfR7PCon/LDawGNNoVjLTJ/gcCALrAWyluCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CVtJNLeNK8vCvLbRLQv0koPKSQaYEFt4cX6TFZYXn3HwiGKDK3IdPkD2I2nLL5niY
	 KttUzpH2/jypJ0hT3kVReEQiEPuDjUUv7ulLIPHsuzh3E06E0ra+xCUuEn9sqBT2rN
	 21UYlaQxhWoTBRRMjHYiVpUMnFAEpR5JAz96Me8ogpetdJCU8KGWIisOml3Ph1VZBP
	 NuaW7vJCwuCYXAsWwMZYwU44/Z0XbsESJI0JD/tZ3DvzY/UTEIRlrlF+HDHq6UHXDm
	 Fs0O0an9PvZ2kMPt8pluUccIrBJZRKEupDEfWbk3qTc2WqF/gC8sO/3OqfW35HtxRL
	 n7/KgSBBId/Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91E6180DBC;
	Wed, 28 Oct 2026 14:46:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67108380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65165400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B-15TqmE5yw2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83BE3400DB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196662;
 b=BRsxfLx5J7PETXDhNDPHrevKPhlEnJDbF3b49ZVxe9JVUJTfVVXIqFc+Z3a5AK8/nHtu
 Jnod6lrdDajEYvqNVT+5BFvafQRfsraJy0g/wXfBfnjSCmJGfwTBhVPD1Fcgouz0tTRce
 ZzqrOFRsYgkhsRI90fvrF8GSuYtNkeBHdA7WIxPvxwA4qUtzbZKVlmIpIF6D4uptO1xaZ
 mE7XjmJ8Rx3jz2bjNukJn5iCIQYqdwmEZe2VftMnkGa7lYVo/xK6aA/U+eiNISzY3xH9/
 sNgiGbba/JA8jJ5GEzfjU6Ak17H8WcF2l1rOp23ckzuiOM+RZUdVLw6WuIR0zzJQBWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cyn5oI/HfR7PCon/LDawGNNoVjLTJ/gcCALrAWyluCA=;
 b=pDWqB1qwWogWZixVklMZMTgFar4dzeBCrVRIF+d/x0+Kw8IRJX1qCLldzO44OefVbS1h
 YB8u/BogEWWGn5+/9saJa+5OC5EjwmnPCK/YG2n9IDW2nkpbi1pgUJQS0+gsIc75r62tG
 TaqJXQ2fqh48MKshf97nD7dEErOh8ijfRvPQKIC4zsUMr6Lq3DpbllIfU5sTKxG8Y4Xtv
 BG9+0YO5LZ5Al2cMA2PmWzHfA2+OwN4fAjgvHT8n242rWXWlJdUsc5QdudbJBQMOhZYU3
 rLnPUoUtsvnU7A748KpLld9XK0uFZTGazYfXVIrsxKkZ8UjChMSxvqgLXwQSZpDayCA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hobCzSZl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hobCzSZl
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83BE3400DB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:00 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c3fae9338f0so10548966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196659; x=1793801459;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyn5oI/HfR7PCon/LDawGNNoVjLTJ/gcCALrAWyluCA=;
 b=hobCzSZlgZ0lrkd3dmcdnAb62/7J4hikQceWLHzVTBOWvpWA9i9qALpJIUkQRM32fD
 W66GPdV5KasYxOskU5PBRdIsqQDwOY6df9dOXG2pz7nU/Fid2BRWiaLaRXX3kjHiOUgm
 RentWR2d+4bx+BlW9Lvl4Yfuxp18yB1FxIXjws16uzMKHV+7h0Q2PQJ5FbCubj/wE0Mg
 7whx0IxN0OW+nHuYwzlthzoOGyqaoqS4qGj/vaPFgC+kXCFuakkByZCIXoAblTZkJWG5
 mqmqpqO16y+ZSojomIK0sJ1XNO5U2D1Kz+Lc+mE0B2AHvU7F1IRf77mi/DdhrdFiQYM4
 NpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196659; x=1793801459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyn5oI/HfR7PCon/LDawGNNoVjLTJ/gcCALrAWyluCA=;
 b=nCH5jHvD6yAF5BZNmUwsBczgVBYO5+cJEnRdUzAw7AGJaT8VVvf2svW4x7ADkalIGv
 PZxztogKNKJKA1MkzUgghR0E0HV2v8xrVU074Y3jtNYO9164euWpZUw3by4WIBn4vhgZ
 CYvr3bjk+v5aNlJNMQRqsjEIznZA7ZA/wbAPGxP79qHgNtyuCANLvFwitFqUO548yuMs
 ac7l1udiI27udSURz+S2L7upQ3HKRc24Xv6mwS52+lKnQFd6YuRdKu+8ZVsqMWUovcle
 tfhvwqtP6DNcN0HzPFwsLwA47mPUuImUNhEuz9FAqChSgoK1zAh1VxpGAF6igpxoX+XB
 VmIw==
X-Gm-Message-State: AFq9FYJihFOlx1fX0a0ilft7NVdJb1+lFn/0TOc7jni2Ml3D63lx+tCV
 sA2qhBWpzZCfmHp3etRRSvXtlUqccbvUfNraRl8tFb1s5GeAveBhKPNVGUolJnWSpYVxjwbPFXw
 wZQ8e
X-Gm-Gg: AYBFou1+sgCHK3oZ4tp+04YiXbdTSA/4KfIdMJ9sMH3NFUfHGKJXlhk6OYE4lb+KNan
 LOPddQYJ8O9dOwXcvi0tq66iwiHMwxWvxLBWet+xVwMa0XBQBU7EegVyVE8SaC/O8a+7MTWhDbe
 8f7q6rA2Kur+DZg2FJy+eqatP63x7YPNtD/fdNYRiV9p5tSy7DjYlGDfWLalgUbJsbC5ZzMsSQd
 lIcnHax7FLNnIkLwWVreNv//NzJCLVEoa7vF6ejQvZgFWwWSXqhtKLVoLxnn3mTdVLWEf9+nhUu
 9ykSezSJgeNDJh2zazJYBr3oDpkIu0FJbE6zFoHVu2eMI1gwdOKxCFEFy3e0ElYuWn2+O3Tm//G
 0clskwsCG3XJ0FtmN6hOrmkP/15tAryu0poCcc0sxF67UUa06PLfOicgHnPIxRYFjcPD/FsWx+r
 tEK2ksD90rEg7wv+3Fc5gaRwYIWqMvJWf4xaG48lM5EuA2y1A2+WWo5kvD58fhjFE5aaxRnCN+S
 0KIi6o3o667zGek6BoC4k+h4IO+yXJ5woTy3As2rTI8ZowBG10t09rawQcGmmmjm64VAz8jXHHh
 4B+T6sShHx0LDvqHh8GvHaePt3R3k2xt/COUkIrRfUUtR3BHWFLfJzle+SRky41QufvhXa7u0FZ
 JcoIOGmsmew==
X-Received: by 2002:a17:906:9986:b0:c46:b5a7:5b29 with SMTP id
 a640c23a62f3a-c49bde9c83amr230686866b.2.1793196658242; 
 Wed, 28 Oct 2026 07:10:58 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:57 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 15/63] usb: dwc3: import from kernel v4.11
Date: Wed, 28 Oct 2026 15:08:41 +0100
Message-ID: <20261028140930.3025368-16-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.10 to v4.11.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.10..v4.11
Commits imported:
de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.h   |   5 +
 drivers/usb/dwc3/ep0.c    |  14 ++
 drivers/usb/dwc3/gadget.c | 287 +++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/gadget.h |  14 +-
 4 files changed, 260 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 14b760209680..2b9e4ca3c932 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -40,6 +40,7 @@
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
 #define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
+#define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_EP0_BOUNCE_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
@@ -724,6 +725,7 @@ struct dwc3_hwparams {
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
+ * @unaligned: true for OUT endpoints with length not divisible by maxp
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  * @queued: true when request has been queued to HW
@@ -740,6 +742,7 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
+	unsigned		unaligned:1;
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
@@ -857,12 +860,14 @@ struct dwc3_scratchpad_array {
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
 	struct dwc3_trb		*ep0_trb;
+	void			*bounce;
 	void			*ep0_bounce;
 	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
 	dma_addr_t		ctrl_req_addr;
 	dma_addr_t		ep0_trb_addr;
+	dma_addr_t		bounce_addr;
 	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 9bb1f8526f3e..e689cede9b0e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1123,7 +1123,21 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
+			struct dwc3_ep *dep = dwc->eps[0];
+
 			WARN_ON_ONCE(event->endpoint_number != 1);
+			/*
+			 * We should handle the delay STATUS phase here if the
+			 * request for handling delay STATUS has been queued
+			 * into the list.
+			 */
+			if (!list_empty(&dep->pending_list)) {
+				dwc->delayed_status = false;
+				usb_gadget_set_state(&dwc->gadget,
+						     USB_STATE_CONFIGURED);
+				dwc3_ep0_do_control_status(dwc, event);
+			}
+
 			return;
 		}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 204c754cc647..79e7a3480d51 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -171,6 +171,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
+	unsigned int			unmap_after_complete = false;
 
 	req->started = false;
 	list_del(&req->list);
@@ -180,11 +181,19 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	if (dwc->ep0_bounced && dep->number <= 1)
+	/*
+	 * NOTICE we don't want to unmap before calling ->complete() if we're
+	 * dealing with a bounced ep0 request. If we unmap it here, we would end
+	 * up overwritting the contents of req->buf and this could confuse the
+	 * gadget driver.
+	 */
+	if (dwc->ep0_bounced && dep->number <= 1) {
 		dwc->ep0_bounced = false;
-
-	usb_gadget_unmap_request_by_dev(dwc->sysdev,
-			&req->request, req->direction);
+		unmap_after_complete = true;
+	} else {
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+				&req->request, req->direction);
+	}
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -192,6 +201,10 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
 
+	if (unmap_after_complete)
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+				&req->request, req->direction);
+
 	if (dep->number > 1)
 		pm_runtime_put(dwc->dev);
 }
@@ -833,29 +846,14 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep);
 
-/**
- * dwc3_prepare_one_trb - setup one TRB from one request
- * @dep: endpoint for which this request is prepared
- * @req: dwc3_request pointer
- */
-static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, dma_addr_t dma,
-		unsigned length, unsigned chain, unsigned node)
+static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
+		dma_addr_t dma, unsigned length, unsigned chain, unsigned node,
+		unsigned stream_id, unsigned short_not_ok, unsigned no_interrupt)
 {
-	struct dwc3_trb		*trb;
 	struct dwc3		*dwc = dep->dwc;
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	trb = &dep->trb_pool[dep->trb_enqueue];
-
-	if (!req->trb) {
-		dwc3_gadget_move_started_request(req);
-		req->trb = trb;
-		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		dep->queued_requests++;
-	}
-
 	dwc3_ep_inc_enq(dep);
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
@@ -900,11 +898,11 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
 		trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
-		if (req->request.short_not_ok)
+		if (short_not_ok)
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
-	if ((!req->request.no_interrupt && !chain) ||
+	if ((!no_interrupt && !chain) ||
 			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
@@ -912,13 +910,43 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
-		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(req->request.stream_id);
+		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
+/**
+ * dwc3_prepare_one_trb - setup one TRB from one request
+ * @dep: endpoint for which this request is prepared
+ * @req: dwc3_request pointer
+ * @chain: should this TRB be chained to the next?
+ * @node: only for isochronous endpoints. First TRB needs different type.
+ */
+static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned chain, unsigned node)
+{
+	struct dwc3_trb		*trb;
+	unsigned		length = req->request.length;
+	unsigned		stream_id = req->request.stream_id;
+	unsigned		short_not_ok = req->request.short_not_ok;
+	unsigned		no_interrupt = req->request.no_interrupt;
+	dma_addr_t		dma = req->request.dma;
+
+	trb = &dep->trb_pool[dep->trb_enqueue];
+
+	if (!req->trb) {
+		dwc3_gadget_move_started_request(req);
+		req->trb = trb;
+		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
+		dep->queued_requests++;
+	}
+
+	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
+			stream_id, short_not_ok, no_interrupt);
+}
+
 /**
  * dwc3_ep_prev_trb() - Returns the previous TRB in the ring
  * @dep: The endpoint with the TRB ring
@@ -974,21 +1002,36 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 {
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int	length;
-	dma_addr_t	dma;
 	int		i;
 
 	for_each_sg(sg, s, req->num_pending_sgs, i) {
+		unsigned int length = req->request.length;
+		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		length = sg_dma_len(s);
-		dma = sg_dma_address(s);
-
 		if (sg_is_last(s))
 			chain = false;
 
-		dwc3_prepare_one_trb(dep, req, dma, length,
-				chain, i);
+		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
+			struct dwc3	*dwc = dep->dwc;
+			struct dwc3_trb	*trb;
+
+			req->unaligned = true;
+
+			/* prepare normal TRB */
+			dwc3_prepare_one_trb(dep, req, true, i);
+
+			/* Now prepare one extra TRB to align transfer size */
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
+					maxp - rem, false, 0,
+					req->request.stream_id,
+					req->request.short_not_ok,
+					req->request.no_interrupt);
+		} else {
+			dwc3_prepare_one_trb(dep, req, chain, i);
+		}
 
 		if (!dwc3_calc_trbs_left(dep))
 			break;
@@ -998,14 +1041,28 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
-	unsigned int	length;
-	dma_addr_t	dma;
+	unsigned int length = req->request.length;
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = length % maxp;
 
-	dma = req->request.dma;
-	length = req->request.length;
+	if (rem && usb_endpoint_dir_out(dep->endpoint.desc)) {
+		struct dwc3	*dwc = dep->dwc;
+		struct dwc3_trb	*trb;
+
+		req->unaligned = true;
+
+		/* prepare normal TRB */
+		dwc3_prepare_one_trb(dep, req, true, 0);
 
-	dwc3_prepare_one_trb(dep, req, dma, length,
-			false, 0);
+		/* Now prepare one extra TRB to align transfer size */
+		trb = &dep->trb_pool[dep->trb_enqueue];
+		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
+				false, 0, req->request.stream_id,
+				req->request.short_not_ok,
+				req->request.no_interrupt);
+	} else {
+		dwc3_prepare_one_trb(dep, req, false, 0);
+	}
 }
 
 /*
@@ -1298,6 +1355,68 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dwc, dep->number, true);
+
+			/*
+			 * If request was already started, this means we had to
+			 * stop the transfer. With that we also need to ignore
+			 * all TRBs used by the request, however TRBs can only
+			 * be modified after completion of END_TRANSFER
+			 * command. So what we do here is that we wait for
+			 * END_TRANSFER completion and only after that, we jump
+			 * over TRBs by clearing HWO and incrementing dequeue
+			 * pointer.
+			 *
+			 * Note that we have 2 possible types of transfers here:
+			 *
+			 * i) Linear buffer request
+			 * ii) SG-list based request
+			 *
+			 * SG-list based requests will have r->num_pending_sgs
+			 * set to a valid number (> 0). Linear requests,
+			 * normally use a single TRB.
+			 *
+			 * For each of these two cases, if r->unaligned flag is
+			 * set, one extra TRB has been used to align transfer
+			 * size to wMaxPacketSize.
+			 *
+			 * All of these cases need to be taken into
+			 * consideration so we don't mess up our TRB ring
+			 * pointers.
+			 */
+			wait_event_lock_irq(dep->wait_end_transfer,
+					!(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
+					dwc->lock);
+
+			if (!r->trb)
+				goto out1;
+
+			if (r->num_pending_sgs) {
+				struct dwc3_trb *trb;
+				int i = 0;
+
+				for (i = 0; i < r->num_pending_sgs; i++) {
+					trb = r->trb + i;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+
+				if (r->unaligned) {
+					trb = r->trb + r->num_pending_sgs + 1;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+			} else {
+				struct dwc3_trb *trb = r->trb;
+
+				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+				dwc3_ep_inc_deq(dep);
+
+				if (r->unaligned) {
+					trb = r->trb + 1;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+			}
 			goto out1;
 		}
 		dev_err(dwc->dev, "request %p was not queued to %s\n",
@@ -1308,6 +1427,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 out1:
 	/* giveback the request */
+	dep->queued_requests--;
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
@@ -1335,6 +1455,9 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		unsigned transfer_in_flight;
 		unsigned started;
 
+		if (dep->flags & DWC3_EP_STALL)
+			return 0;
+
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
 		else
@@ -1356,6 +1479,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
+		if (!(dep->flags & DWC3_EP_STALL))
+			return 0;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
@@ -1918,6 +2043,44 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			dep->endpoint.ops = &dwc3_gadget_ep0_ops;
 			if (!epnum)
 				dwc->gadget.ep0 = &dep->endpoint;
+		} else if (direction) {
+			int mdwidth;
+			int size;
+			int ret;
+			int num;
+
+			mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+			/* MDWIDTH is represented in bits, we need it in bytes */
+			mdwidth /= 8;
+
+			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(i));
+			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+
+			/* FIFO Depth is in MDWDITH bytes. Multiply */
+			size *= mdwidth;
+
+			num = size / 1024;
+			if (num == 0)
+				num = 1;
+
+			/*
+			 * FIFO sizes account an extra MDWIDTH * (num + 1) bytes for
+			 * internal overhead. We don't really know how these are used,
+			 * but documentation say it exists.
+			 */
+			size -= mdwidth * (num + 1);
+			size /= num;
+
+			usb_ep_set_maxpacket_limit(&dep->endpoint, size);
+
+			dep->endpoint.max_streams = 15;
+			dep->endpoint.ops = &dwc3_gadget_ep_ops;
+			list_add_tail(&dep->endpoint.ep_list,
+					&dwc->gadget.ep_list);
+
+			ret = dwc3_alloc_trb_pool(dep);
+			if (ret)
+				return ret;
 		} else {
 			int		ret;
 
@@ -2029,12 +2192,22 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 
-	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
+	/*
+	 * If we're dealing with unaligned size OUT transfer, we will be left
+	 * with one TRB pending in the ring. We need to manually clear HWO bit
+	 * from that TRB.
+	 */
+	if (req->unaligned && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
+	}
 
 	count = trb->size & DWC3_TRB_SIZE_MASK;
 	req->remaining += count;
 
+	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
+		return 1;
+
 	if (dep->direction) {
 		if (count) {
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
@@ -2118,6 +2291,13 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 					event, status, chain);
 		}
 
+		if (req->unaligned) {
+			trb = &dep->trb_pool[dep->trb_dequeue];
+			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+					event, status, false);
+			req->unaligned = false;
+		}
+
 		req->request.actual = length - req->remaining;
 
 		if ((req->request.actual < length) && req->num_pending_sgs)
@@ -3019,6 +3199,13 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
+			&dwc->bounce_addr, GFP_KERNEL);
+	if (!dwc->bounce) {
+		ret = -ENOMEM;
+		goto err5;
+	}
+
 	init_completion(&dwc->ep0_in_setup);
 
 	dwc->gadget.ops			= &dwc3_gadget_ops;
@@ -3049,12 +3236,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	dwc->gadget.max_speed		= dwc->maximum_speed;
 
-	/*
-	 * Per databook, DWC3 needs buffer size to be aligned to MaxPacketSize
-	 * on ep out.
-	 */
-	dwc->gadget.quirk_ep_out_aligned_size = true;
-
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
 	 * sure we're starting from a well known location.
@@ -3062,15 +3243,18 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc);
 	if (ret)
-		goto err5;
+		goto err6;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err5;
+		goto err6;
 	}
 
 	return 0;
+err6:
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 
 err5:
 	kfree(dwc->zlp_buf);
@@ -3103,6 +3287,8 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dwc3_gadget_free_endpoints(dwc);
 
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
@@ -3118,15 +3304,10 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	int ret;
-
 	if (!dwc->gadget_driver)
 		return 0;
 
-	ret = dwc3_gadget_run_stop(dwc, false, false);
-	if (ret < 0)
-		return ret;
-
+	dwc3_gadget_run_stop(dwc, false, false);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3129bcf74d7d..265e223ab645 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -28,23 +28,23 @@ struct dwc3;
 #define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
 
 /* DEPCFG parameter 1 */
-#define DWC3_DEPCFG_INT_NUM(n)		((n) << 0)
+#define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
 #define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
 #define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
-#define DWC3_DEPCFG_BINTERVAL_M1(n)	((n) << 16)
+#define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
-#define DWC3_DEPCFG_EP_NUMBER(n)	((n) << 25)
+#define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
 #define DWC3_DEPCFG_BULK_BASED		(1 << 30)
 #define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
 
 /* DEPCFG parameter 0 */
-#define DWC3_DEPCFG_EP_TYPE(n)		((n) << 1)
-#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	((n) << 3)
-#define DWC3_DEPCFG_FIFO_NUMBER(n)	((n) << 17)
-#define DWC3_DEPCFG_BURST_SIZE(n)	((n) << 22)
+#define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
+#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	(((n) & 0x7ff) << 3)
+#define DWC3_DEPCFG_FIFO_NUMBER(n)	(((n) & 0x1f) << 17)
+#define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
 #define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
-- 
2.53.0

