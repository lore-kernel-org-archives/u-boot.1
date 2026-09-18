Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211ABC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C47E160BAB;
	Fri, 18 Sep 2026 03:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YP0zXnAZzAUv; Fri, 18 Sep 2026 03:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 210F060BAF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701386;
	b=KZAzF9OwNRo0qcJB5838theIcs4me91FZVD0e7UTUE7wj2G/xAIJfLrBI2S6BDGZCTLM
	 Y9DYA3wcql8iduawcXq49NWz+Qy1aSh2dhBX5PC1POfbNUnZ3byv6p0L3JPSweJIlrKwS
	 SCPTfE9pbqfYh/kHUSB6rYW4eMUUW4FU3dvvVLa8QxCrIzPTImkjFhU8AMnVkCROfW9fe
	 Nnq7jZobLxNsll5YGu/2hzRMah2y1tPxc3oprzCbrsl067acYfrd0OZTpdYcdcMYcukyc
	 C60Tmim+bRPl7IBlDP64aT0RnSmz88KuiO5PH0xdI/X2J2XCzFk13HIc+Il9qjt/dTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LF0IP6yOg4kALz39CE6krMZEDTOdMaef/VWT20NBC9Y=;
	b=m1jw7M4v8O9cbHidsC6BwEkq5ElFBurJSzvQxYp/n2Xm3A/0chHfZnHu0XqfNI/Z09pL
	 QsDQO7mKWZw2lT55PKUwpK+vBFah5z9+8UXH1tZVKmD4oiF2rD8chzzzp/+RabcE5gbfs
	 xutaiEtk7g2sMVkIhNt+MhYZGGIN8TupzNXKBt7PlMoVZVPgwto27liTXC9BaNtoarMO5
	 P0CSM39S+Zw/3Egc38VzOVgtpRmOK5tWkRSs+EwWrDx+dkr5Lxf5gqht0W9AQ/wytFFQr
	 23lF/2bPKDnwjZBSk1OvN4EjZvmFfgmjORUFDCJZapL9QEaGzZ75C7JIXLJqpHc+61g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701386;
	bh=LF0IP6yOg4kALz39CE6krMZEDTOdMaef/VWT20NBC9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5VjnsUZOH7+hgs8kmgnRJDBALR95RaDLmrNlCoULpnrsRjEe/lWxUjSADF2KCcUJ
	 kqeoGCJRxJXQk6RxZKEYVHTnwoK4NCxrU15ZqHMIeqKA2QwOug8cHz3pPjsKs5Qmhp
	 wpLURwv4jcgSqicwsuyZ+/ggcdhxxHFSlq67JCftzkPvUB48DRjiieojoFHqWfhadi
	 EvZua8rdNT4QB7Rpzso2syM0uByfGlgqn7i62Fwmt93573mQ5dVKwsjkkY74coXPW/
	 mGQqTE95dqEVbBAbDskfR3cfyRzuX+VYWd6bw5lt7u6jtTUNM5bifU7XNMQQOU1dT6
	 sI60gYzY8uMSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 210F060BAF;
	Fri, 18 Sep 2026 03:16:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B101B29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9728D40AE6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6foKf0rj9vN for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0D2D40AE0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701384;
 b=X5ZuVCc96qYnIkyzfYjIAoJKm8aK8Cby9klzrTdqD2Y5IKiv+M91in54QV4ta/5FA+Gr
 S39OhTeyxohUA7ry3zPLdd681aCoM0U3ifRF2/lpmib7K7huY1lUHwU9jwLp/jJtGkKvX
 o9OTleK9VPrRATavSDnBZ7HuaTNkuIrj0FTePd3Zk4rpJohcMDznVqQaAxOk0WU5/atQg
 je1qLOmt3IhbGilPEJuneU0+/sPQF/gpqtgvo8bCYulikEK4J7KBGOFMXCtGFUYgt4EGd
 qbrwf9HyK5AW0emHZcYq3eKRDdxq3S4GVVYudxpik2t/AgU9T3Uvsls6/HJzmos24/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=LF0IP6yOg4kALz39CE6krMZEDTOdMaef/VWT20NBC9Y=;
 b=XrgvdN9HvwlBULmWadI8WaRVFQ4J84IayDKT+e65SdQIUmVZSw55kDkm8IvV51fTird9
 PCL0KnbMNuB7zDDkVr/17yJrEHvGsuN4671uoTS2I+o62ZXZO7D3dfXnQkcc6ceYme0aU
 aR9IKxMbbUAcLvOWHV2327plaisR36kZ1t+vaPBCcA+gTR+/iShxRVheFbmPN5ts15bau
 78W/fOEed5in+rGJa3WxW63PgKgknZ+H1SzF+b2xS6ZPJIHsKC9gchEVN6cIXaZ5WYjSe
 cFqmSqvcA8O5gv6E7YBmLWAhfdbnpJ5S8bde8J2nOuwzayWYWbqeU/mwpbkB9YFzHgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="bNsfvt/O"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bNsfvt/O
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0D2D40AE0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:23 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db18fe459dso1410555ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701383; x=1790306183;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LF0IP6yOg4kALz39CE6krMZEDTOdMaef/VWT20NBC9Y=;
 b=bNsfvt/OdbM6FiB7swexphYz17d8i3qTUydUkq/9GH3Y3k1nymWpfmz/VP9o/DcF8j
 oPhgdhpVkBL7kJuEGsP9k6p7KRjkTt4dSz6PzGLuSsgg33pujT8CP6mxc1PlEKSg4NEF
 yU85K1sa2vYui13vF7Ya6K0bI1GM8DjhUugLuI1hvjjWBCJCBFtCf/Jmcv6Xz2z2sMP5
 XMXt6geD2Xu0SiTT0eNId3HCDCN1pnFSFYiIP4l7ZNOwLuCX3zDXRBHIstslDXMRPkHT
 LA0ryn0UUHxb6ru0i5dvEUQdn1M7oqvve0DNHeLe4vAfdAKxwbfufoJ18hVVz7uZmG26
 4M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701383; x=1790306183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LF0IP6yOg4kALz39CE6krMZEDTOdMaef/VWT20NBC9Y=;
 b=QdtMBREE+hVRi94VTGSyUHYkcPFInc0LCE2yXuib3XAjTa2HHM+j06aMaN2nOLr0hF
 +bjXgJaIRYWIfeivRYHpnqNxBzrfNajAyaa3McJPHKVzH+UeLoX7n7uIUxaXx8+zTTTt
 SH4NhV+S04Lap3CQk9muu85Y60ZwwvtUMb9YT10uTzFWndfvxxoTQV2rquIfKIosMIEL
 JyD/PBe3TPN7va9vgm+vQgyn9C8Gu9aWKPwL6QbL5BjVoc3K82uvI01Oa6bLNMG6xt58
 xZrO0hIj6nyntk0IrI3b63aI+bePZwknfXk/DsxqNws2ywYctyWt1343NVao1qA3A8bh
 0Dsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW1drYIU84WMIsNzzCwiYAFqb0IjqbYchLfNTaYbaZUbBg+xeQ7CT11dNyOCK+uqqwHB4UCzo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kUozU6G3XEyLi8Z+WzXI06ElywpHeBQuwBs7oh0JaKlpckYqeg
 eTF+8mea1Z45RlqnMz/6r7DQRrTopN716Hao4nATipgoMwTmv6PXxQni
X-Gm-Gg: AYBFou0lc5tCaDXVjC98L6LgFjMovEuICcyBI+4LW66FlEuhjQ06faPUK5n4/SNuCAi
 4OkNQwWAVxrDFwK/V8HpOKni64PWz0XcUY/oJEH+SmpEEHLFbMe+KsMYMf/7GshfT+KHsJjXgo3
 aIY7iErtKQ1ZxWCqc4ipzZINFmBfHa6Z/DHnfr00hTL79qysdrYki/DrxD8VYL4d1O1u9KZMBid
 1AOm1dHoh/114xsrZUAfQuLdi/vHGRACy0+U59Jtg/2x0sDKqoL4WL2s9PgQq5nB1FZ/dxVm1cf
 dvCsY1ZkcfvbUgfTqo4W7su6BPfAx3lHUlnVNI/LYh1heCbGVFPNOsWYzM3p240sRaUNIkhy+8V
 LY5vvl4NH67Y1ZrYHQ8bk6fHO+iGOEV9Ujv/dVTpLbEAIjsKuFpK0AK8czlIAk37/0deVjYR/d3
 ygVwFnVXIKxbWFLXeqfBTRvYWjK87pPEyz3wwFnFrDQrAKbo8vxjTegXjC7fhiUaZyo+mgBioql
 8Zlsa8K
X-Received: by 2002:a17:903:19e5:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2ddb1ad9adamr26111475ad.7.1789701382591; 
 Thu, 17 Sep 2026 20:16:22 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:22 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 1/6] board: nuvuton: arbel: fix incorrect ram size
Date: Fri, 18 Sep 2026 11:15:49 +0800
Message-Id: <20260918031554.1855939-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
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

fix incorrect ram size of 4GB dram with ECC enabled

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 68d516c7db8..17728f8435a 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -78,16 +78,21 @@ int dram_init_banksize(void)
 		gd->dram[1].start = DRAM_4GB_SIZE;
 		gd->dram[1].size = DRAM_2GB_SIZE -
 			(DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	case DRAM_4GB_SIZE:
 		gd->dram[0].size = DRAM_2GB_SIZE;
 		gd->dram[1].start = DRAM_4GB_SIZE;
 		gd->dram[1].size = DRAM_2GB_SIZE;
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	default:
 		gd->dram[0].size = DRAM_1GB_SIZE;
 		gd->dram[1].start = 0;
 		gd->dram[1].size = 0;
+		gd->ram_size = DRAM_1GB_SIZE;
 		break;
 	}
 
-- 
2.34.1

