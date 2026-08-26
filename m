Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8309CC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4451A6068A;
	Wed, 26 Aug 2026 13:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wG9MqOeqGLLV; Wed, 26 Aug 2026 13:42:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751747;
	bh=1+b3JY52qYcFJ2KXVQDwH54tvNgl9Fq+WAhgRq/GU7I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nWrMDmYdAPJkwrSkEPCaDVwb8LW6+4gtJ75kIwIE5Z2KhyTKtydDw1Bg8svGiKVU7
	 9741f1SBQI/kabJWKGfKo+vNTSW8AFA26zdvygEs6e4I6QRPITVwfhn+F+x9rTSRR4
	 rAVV5DlZquvMU+nOUoRlrsTGYPQbBH+ed6PYcS/+keTYgLea6DPamtgvZgAKK7X1Ch
	 Ii1uIuuioBtQf8AUxkzAgKvfAPAojyzLmWDQ7l9IZtd2mAtqVqsW8U38VaoqmKiA0P
	 UZaka76owkubSKBsI3S2bfaRgcOZc/Gy8BIuVbdPLh5JBXJ2LclXJ8qXqYcMc+c2OC
	 txI8AtEUrh+hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21F79605AC;
	Wed, 26 Aug 2026 13:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0E98396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E296E80B6A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m075pUerOKh7 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:10:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SBQ/ylZe
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99C8C80B63
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:10:37 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7ff05e5d009so11362577b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787749836; x=1788354636;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1+b3JY52qYcFJ2KXVQDwH54tvNgl9Fq+WAhgRq/GU7I=;
 b=SBQ/ylZe8ZZC+o/SwruhTN4AZRBOXzxlON6noUINDTVhESZahGr3gBmBEL8SapquVN
 eYxt6tJwIaJs4nKvSVe4cQyuDdO057my1sbQzIvJbMpzHeA2kazlU6IYP2uugj+4L1ih
 Lqm298RnK+teiZx4nOJCdE6tsNxwDGUHOE9t61fZVTso3XS8FZ1OjywG8gyRa68ABkuL
 6LIv2ZEeLwU25KEA4B9wo6nobAWr53PsBwydQzNhvH9JcW04aGVBIDQM5GO3fV55ozoQ
 Am1szzBg3yQj2FxraN3EzktSMMU/HfNMkx51AZqQEYB6xEKsiAekYDKYdX9qadXa18Dc
 dssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749836; x=1788354636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+b3JY52qYcFJ2KXVQDwH54tvNgl9Fq+WAhgRq/GU7I=;
 b=ZXfcM3tWGh+rwzFeIDOP+tzBMa1wyaJPN5wImiVNIgKna9Jzj60YVkkpHyQ9c5QJWi
 tA5RCAlawbRRj/xcX1XlsSWxPgt7zlxmLVjLhyNoBPW8WwUFS8qS9gn9pQkNAnBCXMbb
 8byOjBpvnSopy7C82Ec9l4b8U5wBU2OF23F/lnpQ80ukcpZduek7pkXAepXZV7Ap4U9u
 dcUjbhHltESdL1Ggun7Vjvjai5Lqgb2hqBrIDTeJijaj1I4p3SeWqMjItHMX5i7bXLqg
 LEe/pX6Esv//kdse9H6OT3x4SO+U2I3NvW3Jo+fABaeNtxXdU7DWELYJH95rOUucCOU9
 dFbw==
X-Gm-Message-State: AFuF++nOUJDjFetdQYXBAsBsSE5+xwcYrc2P3+v6Q1JvuA7Aylp326/u
 2xiCzfiReUyzDl6QxaAGISUDFCpmBogFnDw9LcXYZzQj8+5qf+qjTvGwW9PzcA==
X-Gm-Gg: AR+sD13tIc2uGhB6TJSh1hP+Eub6tj5caVXUqOHvCWyNjbd2ZR4VIvdr/nbCFXpgKXU
 NJTo0fEaGLhYxuqJQjYOQv3OQoBaUHJnP+KgcsrJL/upqrIoY+ntmMwQ3PlYFybyIHw+HTuh/AF
 wLtVYre2mwBbMZE5nvbr1jgMdUVIyd1Nmr+5Pu+klB0CuMVzw/xqfQlMX58SsEcLzMD4B+TUxKj
 JNIuPquZ5HiPwadp98/Ws7e09CLGt68kOGeK5gIi+kr0aILnUsl0azLJGB3PzfQvRQFzfKzEIZa
 +y+jSMPAdgvgb5tCV6BiC0p8HGmYCmfM7IDXfUWvstcz0PkEw04S/RCKmmPqTsQw1blfsWDHj0p
 HxzVzMQjsLN0AC2SYvMvDESxDWCnXarHrKpsmtH5Ce3GnoAQfF9gt5ejb0zzobBENkQqtkFkM44
 HW7gI8+uB0DD+sALwURzazqtI/qWy38/zcF1AisF4yb5RW1k1cR0zfBi+KHePiI0CNwQFhYnw+
X-Received: by 2002:a05:690c:c6cd:b0:81e:a471:e8b0 with SMTP id
 00721157ae682-8573f6e6fe4mr25015627b3.21.1787749835884; 
 Wed, 26 Aug 2026 06:10:35 -0700 (PDT)
Received: from Abelha2618.autotrac.corp ([187.32.229.113])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66d245524a8sm1307068d50.1.2026.08.26.06.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:10:35 -0700 (PDT)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	wpopov@gmail.com
Subject: [PATCH] jffs2: initialize datacrc for inode/dirent entries built from
 scan
Date: Wed, 26 Aug 2026 10:10:30 -0300
Message-ID: <20260826131030.1372296-1-wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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

jffs2_1pass_build_lists() initializes inode and dirent list entries from
raw node scanning, but leaves b->datacrc uninitialized in both paths.

Later, jffs2_1pass_read_inode() uses b->datacrc to decide whether to
compute and validate the node data CRC, or to discard the entry as
CRC_BAD. With an undefined value, behavior is non-deterministic:
entries may be incorrectly dropped or CRC verification may be skipped.

Initialize b->datacrc to CRC_UNKNOWN for inode and dirent entries created
in jffs2_1pass_build_lists(), matching the summary-based path behavior.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 137a9585b0b..eb0554f466f 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -1726,6 +1726,7 @@ jffs2_1pass_build_lists(struct part_info * part)
 				b->offset = (u32)part->offset + ofs;
 				b->version = node->i.version;
 				b->ino = node->i.ino;
+				b->datacrc = CRC_UNKNOWN;
 				if (max_totlen < node->u.totlen)
 					max_totlen = node->u.totlen;
 				break;
@@ -1764,6 +1765,7 @@ jffs2_1pass_build_lists(struct part_info * part)
 				b->offset = (u32)part->offset + ofs;
 				b->version = node->d.version;
 				b->pino = node->d.pino;
+				b->datacrc = CRC_UNKNOWN;
 				if (max_totlen < node->u.totlen)
 					max_totlen = node->u.totlen;
 				counterN++;
-- 
2.43.0

