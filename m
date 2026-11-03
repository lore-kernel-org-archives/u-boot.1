Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9391606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X7BZHcIm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUd8RPfq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82A9B40653;
	Tue,  3 Nov 2026 16:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfqfZfp2JP3C; Tue,  3 Nov 2026 16:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0F6440660
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724619;
	b=D2tZY6zmKtXVmJh31EEFy9/gQqbsf+kiC5Qu94sJtQueDlzDOn0FB0ea8ZuJNVviXRkG
	 9DxdR5PqaHSGHxWbVZ65N67TJS6bNL5L2tg5HfZS1uAMPIMXaGkHwA7KW07KTaJJXwFhL
	 h6LWTD4TzKPU6JM0AhXgFiqUuhQenttHN8ZxwJqOqI4pl57/Dsauu2CHE9XGckL4duOSj
	 9XFxMWVKt3+0W+L59LjzIGhhcSGEWERgSx9aHrsPGdHc+fBphxsBMfhfS2eCe8BpJCGzL
	 dhhRl0rVRsBFzllLtaX8RP2WRpo2ADypsNCC6YblpkwtJq/jCS/RNjzv2fOzOSk2Z1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dSvE1FVPYOj4zq9tOEix3YUetwTNObTYd3Gutx01wiw=;
	b=Yn/Ovx7zu3QIWK+l4W0M81TpTfyyZpJWymAB3fbDNotb+u4xsXo/8MR9Fo4hLvR5Mbmr
	 ETadxbDtglYSvrvclwwXYPZahY7mRqBEuIbDHaEh5ZMNsUm603SPme50ugjY3cbs08S+E
	 5lZevmW5ZquRzCqzoFUKzYM0WkVvKZgKVeU/clweyH0UBPwSYGFLRqy4QlrDxuXAeuy/K
	 76Q9tek2jpvYHG/zCrd/TY7UvFWScopTqL7XsTZ8oQlDCUK9pBtCRGLbx5sPxS2wYP+/j
	 UNQ6ZMymRPEODB/Bm+Y7p62A0wtaDSDyC6dkBTNZcsMP0JKLlHlUIJYL1bZL5gZfnBg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724618;
	bh=dSvE1FVPYOj4zq9tOEix3YUetwTNObTYd3Gutx01wiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7BZHcIm5hE42VE2zQuvYCNvR4mjZLNZYJKTzqL1OdvtgyRe6bU4ur2f1/NHM9Cee
	 b2kvD/45S6TQ1QY6K0kGaSuQdVn3ZfkRe8dXEXDBJnsbtKnyGFdgOkiuLKj8rgXo13
	 h+RbVpXvASz6evKBp31b6own9fFzhFwAL3OpSD1rWlcBUfLADo5ClP2gI4yLVuznEH
	 pSXkZnbJx/VzrS7MGbFmV6Fh1HQMorHo4/Gk7DL7hr2uG8mBftgNXgpJw+auh83mLv
	 fYB4dHBpPVHLR9bmJel66LDp42nijbx3YKNzbpSCGylSxroOD99NpTOB7d7Krdjpvn
	 UznMpm5gNTnZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F6440660;
	Tue,  3 Nov 2026 16:50:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F12E2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AF85606CE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKIbzA3JPFTw for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A00E9606E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724616;
 b=IFulaK4AKcJhhKFXsGYumpjzAuFGZCPID4UDhEdZfVg0Dzuv7RuYB7Gc+weEY6F5QXwa
 AV+cyNHkZ3k7urWBp220NKSuQtNe6Sp5sC2fcUFA0tGPGTkwjVslwfhgB42eSGZVC26J7
 QNYY0T8HDZZPV1ULzWuXrLLj07rJr4PuTVZK8eD23lvVVKcdRa+QbM0OpMD4+ElZJYj5R
 sKJ/8w55NuWyy2Jb6vV8qByRdXHPqZmtmaaJCrobaTdUAFusxR2zcAT2ed2jm1AJqGaTT
 7zpcfKpTjSHGoOQICflHraOSV5XoNQ2VzNajNo8ck3DkNpSYWvJzLKP7B+swe1g+YNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724616;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=dSvE1FVPYOj4zq9tOEix3YUetwTNObTYd3Gutx01wiw=;
 b=VfInknRGTsCbvukuvzyA8HmZiUuBu2Sule0VHAAxRROimpM6AmN9dcpfu3aFBgxpt+XL
 4vC8OH4rWrD6rhRb+5oSWEnNNq+o3zePks1GggMorNYRMaxaDn+MX+FxsOEOZR7Sm5n3l
 rAuXJlS+Cto9qSQxYQMrXdpCPn3c4Gb0n6YF6zGGIdVQy+JH7x9rBA49yMPHrVVNTSRzQ
 r7Iy8x1p6puZh9MDDJwDc131eUi6MtjcDCPcJU7u9LuUMRFGCPo0q3zH5MLH7gfn3eT7d
 ynuX1JaCKwnzOQgHtQffnAKEMmLFL297onn7ewprQZt2Nx3DYV9TUSljojHCraQ4F3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sUd8RPfq; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=sUd8RPfq
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A00E9606E1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C9B8482A; Tue,  3 Nov 2026 17:50:12 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1C784823
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b308fca7c3so875627b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724604; x=1794329404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dSvE1FVPYOj4zq9tOEix3YUetwTNObTYd3Gutx01wiw=;
 b=sUd8RPfqic8RVncSWgkej9zo67sjFFbyu+yH6OO1La3u2UnHGQyM5Hiv5W0QvkR/oC
 WSs2S7/wLTD5nn/MdlkkFxLIGEjUdoe2PG45vJrRn65Xmc49m65WE66Ro/1Hy8NSLCUQ
 Xo77B5E1u+eDKSjxcPzBIqBPaWjJ8OnbawY8UsxpJ4vOztEDmIwnwm78A6GK5u07YYDj
 5jEpETJta8nyRZNQYf5Q1/CjGt6guUw9lQkoSqY2wusMj7f1FlAoznpWE7wOhwYjZpGr
 2NEaIyn7x3XVwaGHYrCJGEYU/fptoJM/9CbzvU0vXFD3L+AbOemZ4s7WfeQFxPd8tMUN
 fidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724604; x=1794329404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dSvE1FVPYOj4zq9tOEix3YUetwTNObTYd3Gutx01wiw=;
 b=yj8u7QuWLgYWhrNh/qUjYr6H6S+RfzAjIF+hyMm8/OYtTufslTNbCRnH3BIBYMkW8h
 LS30vtN2pVq5qGfui/16BFzVptKFHwmMFZFJk78eomisO28SWTJm3pZSVu5OKldBc4rx
 U/RjfQCYbDcYsDXBxXETLRjHb1nUNwv7oeoD+zMooEyKunWmJfvo5OOT5d1HPMQGFI/P
 wZwQinoEL+iwG34/CVM1qw+QJakW6XdjSfV74Cf1DlNOa+6fxrk2SU+a0iielyDe9nIj
 /tPtzPHo27SavgdYvLyzUHr+8xzcsX0QkWoGJIBhW3MmKLu0FxXm1v8kR7j6sdHsA5k6
 //tw==
X-Gm-Message-State: APuU4Z9TCbaKIBBAFLw8YkkCmvXSt8UyMLme5yyPZAQxrDoL6f8ZmMTt
 NaVR7JjZcU12EWbv11RBoAZez17YY7+MkQUIRi4HDOvhYxiKX1JMIU7bk6ofy3JH
X-Gm-Gg: AYBFou28kcCJ3AYwTO20X3YuhMt9Jw+2ztDj94bQ98I7JhEOl1Lzm+tc2bTsUkiey9H
 UCPZBChBkTXHFHB4OsMPbCGa8ObFPd+RJY9/w7bMOOA0xWfQpCzkgPChcgC+iib82FRobq0J37Y
 0Jd6LTMkgC8zedBTPWh0OkJo9PD6aq8Cr8zwVoYHOkgCFaqsZc0f0wwGam3RA2xpwqi0ubGBtiR
 4wjjtKAXUNZ3371/ACMjFZh8d4KUWBZkzD27tayq8RvCz1bJDi+jhxxZpABFx/0f/YVD7EBZxEr
 3gsi2KWSFM8MONPaNfplVw8STGZQJGWZQosCT0Ty3ktZaIauVK9eN/GYJDRUcy1t+/RxlTjobF1
 blLR2ct0bd8DViJk9BWDUNqXyqJLBSNHwWMwsFqrjIsBER5shR9NjipBTSVcaov05oQmuYNdKiO
 YAYmgPyed3T167Lo963jalFO34UZsv/sz23cz3glL973MpSvunl3uIsPp6oALNOaZGvCzDmC8CV
 AQT4dbebA0S4dZMK3Mee3e6HzTrAcSoI+ATeloXxVjFxaDaM5vkvYokEjcyDADaCnbrnNSos63W
 IomQZ/pvaO3UEq0UZHQKE7Af3UN3gtUx3DA0Z8Y1iBOoptFfbLdG5eS+Dg==
X-Received: by 2002:a05:690e:1448:b0:67b:e8bf:6e8d with SMTP id
 956f58d0204a3-67be8bf826emr359066d50.45.1793724604482; 
 Tue, 03 Nov 2026 08:50:04 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:04 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 2/7] fs: jffs2: reject missing fragments and fail incomplete
 loads
Date: Tue,  3 Nov 2026 13:49:48 -0300
Message-ID: <605b615864fa98102dd74b40300d82362df85593.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

jffs2_1pass_list_inodes() initializes the selected fragment offset to
-1, but previously passed it to the flash reader when no inode fragment
matched a directory entry. Check that a fragment was found, report the
affected inode, and skip the inconsistent entry before reading flash.

Also fail file loading when a fragment header or payload cannot be
read. Skipping these failures could leave incomplete data in memory
while returning the full file size, causing fsload to report success.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index f21def1821d..6dedecfe741 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -740,10 +740,10 @@ jffs2_1pass_read_inode(struct b_lists *pL, u32 inode, char *dest)
 			jNode = (struct jffs2_raw_inode *)get_fl_mem(b->offset,
 					sizeof(struct jffs2_raw_inode),
 					pL->readbuf);
-			if(!jNode) {
+			if (!jNode) {
 				printf("%s: failed to get memory at 0x%X\n",
 				       __func__, b->offset);
-				continue;
+				return -1;
 			}
 #if 0
 			putLabeledWord("\r\n\r\nread_inode: totlen = ", jNode->totlen);
@@ -769,7 +769,7 @@ jffs2_1pass_read_inode(struct b_lists *pL, u32 inode, char *dest)
 				if (!jNode) {
 					printf("%s: failed to get node at 0x%X\n",
 					       __func__, b->offset);
-					continue;
+					return -1;
 				}
 				src = ((uchar *)jNode) +
 					sizeof(struct jffs2_raw_inode);
@@ -1036,6 +1036,13 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 				}
 			}
 
+			if (i_offset < 0) {
+				printf("%s: failed to find a valid fragment for inode %u\n",
+				       __func__, jDir->ino);
+				put_fl_mem(jDir, pL->readbuf);
+				continue;
+			}
+
 			if (jDir->type == DT_LNK)
 				jNode = get_node_mem(i_offset, NULL);
 			else
-- 
2.43.0

