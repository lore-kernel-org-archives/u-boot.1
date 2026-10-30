Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hcvN8AC1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fllVZhx2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAF4B60ADB;
	Fri, 30 Oct 2026 12:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iFDeyWBvhXVN; Fri, 30 Oct 2026 12:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42D8860AE4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365192;
	b=Zc+Qb6X5PdT5kbeJDKcvE0Umawf26/IE8pDlZAuL7+7T7OMaeLRsU9t1ygdy1YNWz4Ze
	 2D6V3fYF9aUJVYsquTqb8YUB81DQ0JU6pUxR0rZWgEeMexwsRGokg2SvcT4Jwnh3pJk+x
	 xFkiytJUx2LBGxu4XRZgW4EwVI/qv7VFxP/28gW9J6g7HZd/rZyczysVK8BQsTqNADS3z
	 DAFgxLrybN60UHl6oYiF3x61e1fii65BbRyPUerzlc++9loHGw/r8Ssii//c7AT0jfXYo
	 RBjfew2H9bel7NFkM1lEu5N11KiFXVoRQa+AebuvO9MJMYov9ijv9Gd8SxUJETKLimQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mEWxd810gy9ySc/1Xc+LeGeNzDpGY5Bq9Q51lgOh6JE=;
	b=DCfC/2ImnB6GPFLfjujduU7Wib0q/7ylj7Y5Cqwcbvs4AGhZ6QcR1WoKhT6naarZl5YA
	 La27pMZND8aGWaDxRfwC/5IhQM5+L7lZNMyy9OUBtch5SvJ70vs4qvlUh8BepT/bdfQRu
	 dyzztqzGrEop2i6xFMTRpL8wdLjV7XZ/t8EekJiNQL1DSoeq/bTsaDDtqI09m/U78Yvil
	 Dci7c/so6iOrzRAxc068XUbPOW8Mvy2JDDD7BKIA5+umEVxlLIT4ZYZtwbWoJPLNeEW6h
	 4Ki6SagW5eqTJD85cbDq/f1N3/TyQMWWwsLgCoO5mgSkN1Pt0V4ZydpsLuP6KcCyVBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365191;
	bh=mEWxd810gy9ySc/1Xc+LeGeNzDpGY5Bq9Q51lgOh6JE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hcvN8AC1DHi7XsuDcvpmfQj7vsFxegyTZYYxkm9KB2zGzUOwSj43eZI7PNa1rZmLG
	 +k2WOFICYD4qmLezJEQ4mHcitVE5PlTNzbLDsLc7gfRfeJN43YOkU+/oCNVvXQUHZt
	 MFm/XvcTTYTRO2UmhqqppX1OyVr3qd0+7MvN7LGMwyOcMDZeFBBO2jNPN5M51aSWps
	 5oRbADwySzUM6B+x/Jnk8sIPDUpgarjDngFhRj7gx8hMFO1ql8zUQwj6H4xz2Zc3wq
	 CmWgfXWxDfM0/Lwm8KxftSnbgSgxrQ/6xAKIzSMXSMtH0oEiQhALcygLqYwMtE1FKb
	 5ya9CBXdA53iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42D8860AE4;
	Fri, 30 Oct 2026 12:59:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 307B9712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DCAC40329
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gBDTkUH9qSl for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50718402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345860;
 b=SDcqqyTvJCDGvTWu/nCCkDDBp9tDZwNcI36d5BQUiTOCm+m+WsR4hv+ebnWw4ACmEZnH
 qfJCHGQhsCYPnEfFc4RBx0WwDYuHru75ddJnwxCSk1eDPhRpdrwIula+wpQLthVYMd+gS
 trAhrhML8FdxV05bPhucYPA/BhHfymbIBpaak6fhWRo+qCR7slHZWqnVOCRWzEWyKUd7N
 3J0mjFL+tN8yaOnoy6YV5yrELKRRWELFVKc1qjC/LgRoM4YMvH+FwFeKyG8mBlUTixtmT
 zGKP2lJDC9zKaGRSUrMoudjYSrmrxaQPn5VWIlKcpa0balZ18QlMhlAixBuo1GLwpHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345860;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=mEWxd810gy9ySc/1Xc+LeGeNzDpGY5Bq9Q51lgOh6JE=;
 b=cOHShHn7+r71oIWaQVZ7pEfT9S4HTN2G8t1F2VrzJ74mSsPUjeVsvEPccJmEm5uQBvHL
 ZC/LQCberc/qoMfoy60rJCK6Dd6K3Gn0wsujfI1SPgepL/SbFVkrINQ9AjP5Z4HB4xQ32
 tWmN+LYPgauW7i8CT9XRRmloakhUcbQPDy5jNpv1xakH669jkjLU5CfFSK7joAMJBI5Nn
 Bzx2IiiC5AjAjyckN4VXSJyP2q+fiFIkBzz3xZawoB9uw6oP1Erao0sC2GIcuisWbbE69
 mtg8c8S/vbQ1P8G5XeTHY2oVo+UhhR3HOvK5wlENV56bnsmcgc8O3DXg3wI1gIh4Keg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fllVZhx2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fllVZhx2
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50718402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:40 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso3772155e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345858; x=1793950658;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mEWxd810gy9ySc/1Xc+LeGeNzDpGY5Bq9Q51lgOh6JE=;
 b=fllVZhx2mky5rkojI6uiPYEjq1sEgkE6mXJaPsuIgQcZGFWAZGEPJasauVMpBHFj8g
 9tFQIOqJzcOzdal0iVejZJit7yEYIqExg7eDZAgHMPZBdhCNQlXNhULVY9QSRvsTTY9b
 ZTxMvNRyJs3vl4L4/1Pco1KuYCc1694gz1jZtG62vHfOvOCFeiVksZNF6wu+0BZKjx6c
 5ar6VS70smYngFIatV5An6G7+Ub0DCikL6eq5XYbTEs3b4m6Tjkx2FYkcPeOiVFtkfov
 uQAFnKmHKAolAC7+dr6iFB+ZAHuVBkfTcfyGckvAypLfnJVShpTGM1lxqbzcMsrCffKG
 uWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345858; x=1793950658;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEWxd810gy9ySc/1Xc+LeGeNzDpGY5Bq9Q51lgOh6JE=;
 b=vYlcEXV6ktlhM7HcwvQFMIqt3wCvtzA1DgxzVnzNSmx8STlqLE2UZyu2Y7syfFEepa
 m7D9Rk6dcHIeCMSwwi2pgscIezLNGJot5T9dsVgoSMlZi3f2lIjrBSB0RTB24AjM0j51
 Hh6rz1IW1uB2CzeQ9zd8qoWZn9X85KVK4IhkuqRF0q5xv9sCUKhb9lISky7WRz1GZRkB
 Qo9GwHzNwobEijMbax1acqGGGPtBtWcqXjsr7OC7syZA6TLV2eMyQx92u2IPVhRY80ii
 QzSIx0M2NZtT1/HVQqEcnxZbhU88kYn0QTFna42mPllReX8L6L0JnZVRqMna+tc8A/9b
 x9oQ==
X-Gm-Message-State: AFq9FYJhX997hro0cAzfuI7/FDvjReR/zz1YGgNTbmevEj/A/tf9ONmc
 lz8JwpAq7Py/8ez+0zUm2IW3k8crrw7EYzgJvFk0nFW3NbdDNaZpgsOEyqUoCCQJZK8=
X-Gm-Gg: AYBFou3hnTXvoqshxKMIxHKTgilzrKNwKbMnbw1zjevXLTB3WABmq7HcrY7qIJeGSsa
 tZfj3iqJNZ16NnNE1Ve4gxhakib/hA0bWjvUqZqv/ATgvTpvIEALxEVh+sKVOVEG6POgeC6ZOEs
 I0O1iM0LWL4JPJX0mh6AXhHFEkzhkt4+SwUNdoBDMtT2UKBlgXdqeaX2Rs5VS3Jlcur1eUgB/iL
 V1Ug1b60ZHUbVbe63KjhsvhLcGfC6JY9+jEBWjt25MNKbqk9uKXZGGlCty6+VZm2QjsBtB9ga/L
 QqAt0xcNjZfg/iCvq1Q3Hh5jMqsMveSN/e3p1dmYqp8KN857OPdafkmkcm4iwQyCyT9vgisgx2I
 flkLku00VxXCw3QXFdtGBVWXv6rJJaKj1h0yX6ydW6KVADUc7kNa2yJAI/nYoBN9HB1Nj2/CLhq
 +RRVDfsas0Kp/K2j7U6utvgSdmkmQqFJVaUNuuh1VymjurkD5rRLui84brswqcCFb6j09l1dNVq
 Lj1B8q0XfRFEIA1jj5p9tvEGrdWqxkQciz1zO9OnShiUYkpVW+G/8Cf0LiPIKUjrXiHBV6U40Lu
 mOYha/v91b5TMbga+MBlix6mVZnZE8wA9po=
X-Received: by 2002:a05:600c:8b47:b0:4a2:1960:6db with SMTP id
 5b1f17b1804b1-4ac185bc2aemr29017445e9.26.1793345858028; 
 Fri, 30 Oct 2026 00:37:38 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm120112845e9.4.2026.10.30.00.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:37 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] timer: dw-apb: read the counter until two reads agree
Date: Fri, 30 Oct 2026 10:37:30 +0300
Message-ID: <20261030073730.165067-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the RK3066 after a warm reset, a read of the running DW APB timer
counter occasionally returns a wrong value (about one in a few thousand
reads ran backwards). timer_conv_64() takes every such value for a wrap of
the 32-bit counter, so the 64-bit time jumps ahead by 2^32 ticks and all
pending timeouts expire at once (here: SD reads failing with
"fs_devread read error" in about half of the boots).

Read twice and retry until both reads are close together; the counter
runs down, so the second read is at most a few ticks below the first.

Tested on an MK808B (RK3066): 5 of 5 warm reboots load the kernel from SD;
before, about half failed.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/timer/dw-apb-timer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/timer/dw-apb-timer.c b/drivers/timer/dw-apb-timer.c
index 77ccb98c..ecabbe04 100644
--- a/drivers/timer/dw-apb-timer.c
+++ b/drivers/timer/dw-apb-timer.c
@@ -34,13 +34,25 @@ struct dw_apb_timer_plat {
 static u64 dw_apb_timer_get_count(struct udevice *dev)
 {
 	struct dw_apb_timer_priv *priv = dev_get_priv(dev);
+	u32 a, b;
+
+	/*
+	 * A read of the running counter can come back wrong now and then (RK3066 after a warm
+	 * reset with the clocks Linux left: about one in every few thousand reads ran backwards,
+	 * timer_conv_64() counted each as a wrap, and all timeouts fired at once). Two reads of a
+	 * counter going down must be close together: retry until they are.
+	 */
+	do {
+		a = readl(priv->regs + DW_APB_CURR_VAL);
+		b = readl(priv->regs + DW_APB_CURR_VAL);
+	} while (a - b > 0x10000);
 
 	/*
 	 * The DW APB counter counts down, but this function
 	 * requires the count to be incrementing. Invert the
 	 * result.
 	 */
-	return timer_conv_64(~readl(priv->regs + DW_APB_CURR_VAL));
+	return timer_conv_64(~b);
 }
 
 static int dw_apb_timer_probe(struct udevice *dev)
-- 
2.47.3

