Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B9CCF2CF
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B84D60662;
	Sat, 17 Oct 2026 18:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id liiU_9zcH-yO; Sat, 17 Oct 2026 18:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 716F460628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262798;
	b=amLNYo+ZlQqYjFI6gD0nrQNd7g2hPkF6g5szEUNQglIp1kl8T6u5je0bq1y1AdIHoJQ5
	 Pk4LPbSLuE4p7MmCYW7yWSPS3+AdUW8rsDhHRNqawIFdAJdciyRaYS1hboqjmioWNAj+G
	 XRiyQzhvSAKAbMG85Vy7URXjsINhul9Ke5RE6+jNXJrmCDLE5Na5FZ7mn5hEGwHD5M0vK
	 A84vrPcrSB2Q6vH/zXFAEmKqR6GoG+Dz5fUeB22ag1OKFCiUq0CeEMl9Z4852Smu8ndaI
	 Oq/PAAaJDng5WOcvRtH+At6WK0IlgFiAOgPAKpQVYPmhtBZ3mvue6gOz/YzH5vrqQlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0bvwMGtxjXdksnK6Q11Ez53SmO4An2KE0fum/Y99zn4=;
	b=Bksusd1rz91cJcDN2osMf22rKCssWaKv9e+bt8WR8jOivgWmryj0MEcNnhHP0e9DZ+MP
	 DBhZDvxJ5KA8EkTM3ZMAu8qpT9vUS/LC/dkeBjCRGqlc5b5OjPuzjgZcdhX7XoF0tUKMk
	 lHwCQ9pn1MlwgQmE6R2ac5aar/jZ9SZVt4bZdW5/+jNo52d7oIqtImHjXwqbyH2z4bQ2M
	 0SkWBBbsdetmRzCJ38fyVzEKq67roY60+S04/yvBU7VRJOV6wx91THGZuvFl4cXmtHyKK
	 YCarTNmKVK+5snL0EWOkBNB9BFaiQ+XTEE3ymt0pq8s7nuXnNJlfA1onUMexeGYNBYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262798;
	bh=0bvwMGtxjXdksnK6Q11Ez53SmO4An2KE0fum/Y99zn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UecdFAnzIQ1No0tN9pMIisgGHpwJQj/QyO1E5Uqw2plJaweP6ZTVi9fJc+k9x5LdW
	 v3gqSsrmIKUH3ZSx1tOlkqgB9/L0Af3z+6Hy/8k0SNQs0ivfwOo9HxSy5q+FcOlgJ6
	 hXO+ItcEaRVa9Q4B50GxtGZI/gMUYWY5P1BZcxaaDAJsWR9hzro43fZDPqdAgwoyfe
	 nvWd2wbz6eEyJWpJUE6juS7xYeKY0s7c2yOno1Afs59wB+BvYh9+oT+rP8nJ66JFfn
	 NsaeHsCk6sy43TdsenCaGJnB7EyDPGvdjBpBERWCVaHX0SMeKG48becHtE66WNGI29
	 CLmbP7IKDOWNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 716F460628;
	Sat, 17 Oct 2026 18:46:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D60AD2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC57A812B9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4GVB5OHGxry for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AE6E8115D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262794;
 b=LAXjeaKaaZtjnRPCXvQaqKZOh1xGSkW+w+u2J4STRUvsIKQoYmwoq/6yj50TTBXmDA9P
 LaczE66EuSjBC+NCwCyjBgVpBSu5h+dMzWql2McytokLF/vnAr8UpzbhQMQ77/z8NhhnJ
 J6LexlKzeJS+Q+v6GUhuYWdC2nc1h+m05JjJb7uMjK3tEy1VZaTeuRNp1/iWO4TXKmmW9
 lnJ+dxAoqHOZBDGxoBJU24SQBr1plLBUXCPA+esJQxc97ih6lKTRi9YMVbpaXq7Ny8SXj
 POo+moV3VKR1HZEE1Amcsk35qOdtncbhr11v+3TMwLb2LEwpZMIVFnNessXGNxJJi8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0bvwMGtxjXdksnK6Q11Ez53SmO4An2KE0fum/Y99zn4=;
 b=WnbpJCuu3MYv8ck3JM+KjXcK4EbgD3AXtp7CXV+cCshfO34RXF60aUbgy2+1XuQfiqZc
 93n8PkD7DEl9pM/264ts4H4l2A0S5F6X53HOAfyVwU4kzNt0Ci5cSrZN2Mja+H5mx0QIz
 YSjF9F5bq1l/B98zUaaEHzgLLL7459y+CwRVBM7O4WahVlRHlJvRwahIkFT83pRH9ft5w
 EHxn6XbxKQQHd5mFwQOFLzj1VB4nzycuGVcMmV5I/XDc9n9C94DjSpAHQdLspl1qAUpek
 DdxjlWDj38tZoxQmtzw+nIEFCXab8ciwRlOKbfBhQfLiLKHJCpWJr987Ef0SZiBr89Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NxIDssCd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NxIDssCd
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AE6E8115D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:33 +0000 (UTC)
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-17bc533fda3so1061093c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262793; x=1792867593;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0bvwMGtxjXdksnK6Q11Ez53SmO4An2KE0fum/Y99zn4=;
 b=NxIDssCdnXyCkkUigHHHZgpt66hokF4l688QYaWEXTpsDM8RP4aL7fUXgiU2NccoVf
 yOEpYXE4yk1u4U0tnccNX9GQcimCu5156HOAEy3/5ewN+yBxqJcsUM0W4bEmxmeCgHES
 lNCDq86Zj5TPXeQWOZc9Lx5lczpzzUxsGgv8DKpxomuLdBhxvLyB9hRjZYF9EU1BkVFf
 q+zcmKdAXeCnOyULweCoGTVOQa82QTXUau66ZUZLEhrluEIsxqazRXEOKGerRFCeG0e1
 2Ced47RC9xiTtYfZYpl5e+nb6BAf7ikl10rDg6lqII6hsUB5BqlhYGA9Rkg1Mcf+6oJm
 derA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262793; x=1792867593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0bvwMGtxjXdksnK6Q11Ez53SmO4An2KE0fum/Y99zn4=;
 b=qKsQiNc8zWFHqWJY+SrWK89sW8pLuROUF2GYU1WXzc8KGZmLa8LCKkjvzvU8bwiMwa
 woLx0AUhgMPjvJjKrRXaygnOm9wUaaLrhl4lDIkKw0Qr+5+y+kvcLUKHeRUaLEoMRr6d
 aHAIjJOFCCrznaSNt++Ii1Wf8jkxDsfShzAhqN6TAS6DqrsZi6RZ9tCKafkiuYjmDeTR
 G7Ehbe7yE6ORCKHDZH7U6jj0nMeneYq8/fMRLpcZXuNcVN3+o7oTvvMKwx9rFspbaUOl
 NTBZh8f+tESe2aH75rFuEXRdmDYMHgRAfbiqufjW0JWD+H19q63up8xWuXm56TUFvBOg
 ykDQ==
X-Gm-Message-State: AFq9FYKeHjtAHg1wgUdsqEdAbCJTuJ0r6bzEsEqSMJY14MK9GRZEG7UV
 05kfkwf1MuoHaZcJySi2jhUiO4dpYLjwSn42zif0lVv4XY3h14LWUfao7zcEjfyq
X-Gm-Gg: AYBFou2ZySCKpAqp73RIh/XO5tQASBlEGavgpZ58ilx48UtbGwbHynt+DmCHWxnAjFe
 Kvzri8oFTUDMr2a9Ejrf0ynTozGX6crrjdq4Ppizv1d53fsiRJ0RNic8ayRGf6HfFRXAm7jmTOA
 Aa0woptDacSK69K/ulg3s+2hFYB3nwikysNEuDICJXmmt1IG0q3/EKluaYL0d2g4vLXpUUy38Il
 3anqvVEz+SxrDkARfhqtbQMmaTU6dgXqV1gPD+q0c2jvYe/nngZACImns6vrrKW0WjWDiBOcjwk
 Qz2wKFs6wAOVluGttF0/bYS6aayP/xwCOhK9qEFsM5fedGk1ESmnBwfgK+GDq4Gjt8V3oXYuWaR
 Icjr2kalKHM//GIqxZF2rQQF6WHYxwyzpkSszU7RxCuojPl9B6Ua+I7CE4eo9UQXOy7Ece3q0lr
 RxjcUHvo2udbduy5uf/v0oWE7MKF8KpeL6/WF0CT5jsrDxyumGIzDQdcwU6EfEti1rcMNsgElbG
 4r2a0izZyaj02CgwaODhVCaoR+rrg0qJ3L4NBN4c+EfVFsVOULaxPektqW/orvtzm2d1xVMQDgF
 Eix2YnOzCZsdryEWvqxgU3p2SHNMZhZd4zebyMafpZoRr9q7OIjj9w==
X-Received: by 2002:a05:701b:2203:b0:143:2982:1043 with SMTP id
 a92af1059eb24-1876658f7acmr1358347c88.36.1792262792641; 
 Sat, 17 Oct 2026 11:46:32 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:32 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 3/5] MAINTAINERS: Add entry for virtio RTC
Date: Sun, 18 Oct 2026 02:46:20 +0800
Message-ID: <20261017184622.3925389-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
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

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- Add test/dm/virtio_rtc.c, which this version adds

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c..2ce94d7f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,6 +1872,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

