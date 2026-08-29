Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8CC61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6357D4076E;
	Sat, 29 Aug 2026 19:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6vH4qR5Gn18; Sat, 29 Aug 2026 19:22:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031324;
	bh=yyfPIcLCDZcckY9yfa2oL50oSgXadYXigmwC9gCjCOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0p5JHaQ4n8h0MmGPLFbfLqhrnh3oLknyawy/kYvYEKJT2Pcb+bhXwWed8P15SNvX
	 leBSipwz5CNCmbevRtLkL/ojbo094UZIsGW2h2Nzdwo57LSNyECIwjTWTCjnY8ZNzl
	 lSIJT/ykp6sRK0TGU3hJEQgNj5w3Vg7amBJKTJdjwCmxxUoL/RDeS1OfomEUS9Hi0f
	 cGIYlaRLmkDLTikzPXSX7anibZne2yfWJhT2bGHZQnA835vIlK5YjVxkdH7esrNVsn
	 YGkZoQlzHlj9olpdED6KyuquWtMsluFYv4mV/sVTf2LHsI6iGPSi6sHFERF3ZbAD+I
	 PVHk1TsgpC9iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C98A44074A;
	Sat, 29 Aug 2026 19:22:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C199D4
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E71296061F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hnRuxbFzsIg for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:22:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qU9NUaI0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5518A60617
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:22:01 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3140767a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031321; x=1788636121;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yyfPIcLCDZcckY9yfa2oL50oSgXadYXigmwC9gCjCOY=;
 b=qU9NUaI0fMh8C1UtPZuK0hYprAD9ot7gG/QlkCoftu9Cg4uWGVtW8CNs86P8yyjh42
 cVp7kx/QxTaQLui9pog2tFgMXyF+Z/dRUTw13UYjLaL9WAWxj3Eby+4ovVjPAJ5q1OfK
 z6EpmNbPhRsqrbXAE4L6EZuIHLV0FCQc+qmLVF6rZXsYU5Hx6uuTxesCUpE4B/ec1qK4
 fiPlrwqZ6Sxn11o2ZHBGazz5/MVQpMpaTB/QjTA3e4ycy64fZRXImnJQ26K4d6bOJUFZ
 9SfWKnvTbLlkpkZigLtmy3666YntB/HGrpBkCuNPkFQwzax9vjDvaCL8IQHYRxep/h8p
 YO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031321; x=1788636121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yyfPIcLCDZcckY9yfa2oL50oSgXadYXigmwC9gCjCOY=;
 b=pnonubaBQbtx/Kd1zFBNotVvhShKJbalWTvJNhsZHw9gSQP2QznoApHPtZVWtvyuZ1
 SZ2eYxNx0J5RSvznxgAwL1Zzol44GL55m1h34ESVVlwfzj5FrXTM7JjRJKohinK3ZWy1
 3ZWwIvH7XvBbHqKYepRTmsHg5D6LBKdQ0yC2sojQItWAC7SbBOz00tMg4toVYHdVwtj8
 lbiW3vVFsQ3zhdp0eyR7hS4S4qZ4gvQUtmeK/9t2qt+ciwebk2u9k14iH89XVjQtKGOw
 JgiHHTRmRgI8+du/zND0heXYp19BL7Bhesxuip2EuT2Y13QsqtmFIbWTv9G4YDYbjNwp
 gd/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp44FcpYW+LdPdU8pBbAnD3IfHnmqalEO5m4ir8HvXAdt5qxRqE++9nDDkxgV5bvrfTsPTW0c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n8uOkA+3PmmvyZ63J8ciYS6//tQQO6bcgqwYOl5VAuYvfYhAOa
 Vm5/igRUJHRgteVF1JqaucxK2LrY829qPOxJngPsKBNv13iEYIUBxMKE
X-Gm-Gg: AYBFou1AgN1fW+hcz7tmhYuALGtAIlBW6u8R30q1lAwrobeoYMsdNx4se+74ioft9eQ
 7rB1NUsiA5aWw80vLYgZ94ujFP04ZJ4ZW6AvFdP0+X6HchlojCavsEQn/q9Q2gTnzqPjdjUaGNZ
 j2mmjDlxk+nkh6BdFl91YJiITsF7xVoB+WLWZWSf1DalNeDXr6sdCQ/Z1FXp8VLVqdE5U/dXZHj
 RPlW9BQDra04KalBAG0p6+3gHcWorjDKvhdo2tEIjXVzHweIczSyI5DU8afFhVcq0GgDuPO3q9k
 hk9pjkO6L2Cs2RJ9NPavRW51hXpXspMTChgXBjdGODaefx5SzBH7bucl23gA+DzUvOb6BcvInat
 eSCQ75LaADqTZBT1KPpr+g3owhJwk8NRjJ9KHTKlsFO+wNJ1Yr54uabudw1VJaefdCOLgsCzgk5
 COI6HCEW6pT8VKHf7XnuJDd/Td9oBZPRNj983c9QrxYy0kox6Yw18Y86feVZmxkv5y9zlXLNnI1
 y0tChf93X2f64kyOBNKoty38X44A6JBWxFXXzMGiJsfy7b/cMQEbu3efBbJMY/bZx+3QXkUW7iy
X-Received: by 2002:a17:90b:2b90:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-396d0fce294mr28671632a91.12.1788031321175; 
 Sat, 29 Aug 2026 12:22:01 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:22:00 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for 9PFS
Date: Sat, 29 Aug 2026 19:21:19 +0000
Message-ID: <20260829192119.2658328-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add maintainer entry for the newly introduced 9P filesystem
subsystem, including the protocol core, vfs integration, and
virtio transport driver.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index acaba95ed03..498fc690d0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,6 +50,17 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
+9PFS
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	doc/usage/filesystems/9p.rst
+F:	drivers/virtio/virtio_9p.c
+F:	fs/9p/
+F:	include/9p.h
+F:	include/9pfs.h
+F:	net/9p/
+F:	test/py/tests/test_9p.py
+
 ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.55.0.897.gb25b4bd76c-goog

