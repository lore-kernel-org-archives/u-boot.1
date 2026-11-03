Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7210606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lkPz4TNU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZeKyGp9N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 978F880E3E;
	Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ME8D3v1a3CX; Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1FE180DD8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724617;
	b=A2+0TG+f8UutpnN/OJ8KtzuFRMW+o6Uj7wwv30f1GtkocMrwnur0WWyD0MAr79wnvZY4
	 6HlV7FOZ5tyVoiPziftIi7vV3yP04Y0jaw+1MVhYbqKA73MjxVHThsHBeqv+NtJyYEfH+
	 5CwY4LX1uDtLHUgb2vZvKNCinVS+xwNkKvjXA74/ecVqAiWrlnZAt8Y/LD5MrpwDe6M3k
	 pI2yNNm9xD27zwxLgkMhi+zX5x6omFUQkDqo0VDjlr41gl3VmW8A1jNbSMfy0Sx7m3XTv
	 RYXQzKwd0itIR49O/IUnQVhZSeqqs7GpjVfbl+MifwczCJzmEtnFUmiqaAkF96u+OJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JbhTB+B0Anj4d9OdOpaWmw74165WNQw1S4WZRmBAgc4=;
	b=iSOvQGO7/sJV/63u//xgDafauK00MiHrPB5lb7gflp9G9CPUmtsMDGZllIF4CZUbbEeO
	 7ILrGMmTG7bNQVz9zDJ3DE4m2AyxzPeSL+aCAk7C+fFc6iUV7QA6Up5XyQtewCoRwUpqD
	 3uS6BrzZah4Zf6wPQMTkqyvE8xYvjDu4zW9b0ySaq3fZuJRyq9RJ5VgTbntPoPwy9vtx1
	 YASGNJnbz3fQ9CRhEm1WVF81b4HyjbOQLQxirkwbaa7QJTiXMGKiPOqgkS1UyFCn0++jo
	 lXcWDxUq/CkOEx8LEeAY7MsnBcbfBu8rVrI7alFhRrh4mUGbBoqGl59N/vTLsJ8/n7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724616;
	bh=JbhTB+B0Anj4d9OdOpaWmw74165WNQw1S4WZRmBAgc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lkPz4TNUZQgYTOobpVDiLmaZDjYLyoGVV0Q2ULwqM1euUoMY6m1aZ5Z5pm9MaAyFi
	 X6cvW9/4A0h8x4XiDJCP99JXWOfEQGN3XgoExmCBORx3DnU4udV+QQun2fcIWCWEpM
	 XTJjeDwX4QA7RCcGwlTZb7eq3xRG1pHq7HtU+RRWiREKR4njuVXF3A4iVltA7k5zRY
	 PervrHuFLWYxfBHBm/2/PB8g/Ra6ssVj5/XdqTq5uhP7HCJNIm8eNAfg/WFGmfIYb5
	 YVSuDpH9dpnq9ZsBQMrPYfXOqvXY2neQPLR7C7qEfp3V7RS6MKYBYQMtTkFPIJ/lQl
	 /m2cSfzEQieTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1FE180DD8;
	Tue,  3 Nov 2026 16:50:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C9565356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAE3940660
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3K2LDddn40P for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D5E140653
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724613;
 b=lLeFvKKSWCPA1jvk7QnPp7KxpOjt0vye5twXPnZZBiFrUvb8z7tns4qOMweoxiKSl2HB
 jm6r0QF6VwBy0/iBtGS1PquqequCyv0jjh0h602r9bwSLudil3S0uBJmBR0vMJjwSE2iJ
 XP8fMLHap7ZMGI/totf8GmBGXGxeOvTTmLMOKreMP8eVgXqtK2G13DCb3iOPR+d3UyS96
 rd8NOsuGLs4PYeJNuRlFDw6fJfWt8DPci66EKS24L6wX9NE+M5wS+/RO+MtolLqBw9Bgx
 qRpzGj2Ma4858iVY3Qx54lkVoZxS0LxHT4zoSsF3uWu7Fd2VFg6FZXQcH+hrm2ijWDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724613;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=JbhTB+B0Anj4d9OdOpaWmw74165WNQw1S4WZRmBAgc4=;
 b=OUDn3NAQQyolhqdnaYog7jUyT8Rs1X70HOAQLfHz2jv7Vex1hukPhl4PFQb01d6M5e36
 J4vvgFprpCFR6+6L7tk6ura0lO9wDjEYUXKxJ+JvF8R4KRJ5tcw7wTMfyRb5ksNR94Z6l
 REO9FVuKtFeqfH4vAlra+Jr5LndrTxpJx+uaOTsfJXTFTLs9vshX1idCYCqtyvetEgebW
 wP5pDAs7ZQP3lP/gk0FCMo8LtxbOjtOJnlmSqM382FDQHfQXiUxwCDrv9/oppt/IJaLFE
 i/5Bdle/8LYA+5hXjUXFXtr3rKe9COr9YOOd84LH/z2v2zinpjOw/4wkwzYv5j0kG5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZeKyGp9N; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZeKyGp9N
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D5E140653
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3E584820; Tue,  3 Nov 2026 17:50:10 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8130B84820
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-679a2b5fe87so3918782d50.3
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724602; x=1794329402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbhTB+B0Anj4d9OdOpaWmw74165WNQw1S4WZRmBAgc4=;
 b=ZeKyGp9N56PRi1mMmc/Dw7rah4eSXo7YZcGIOwqP4OHlOa4KS50HQx4jWgfEqoQa+o
 qZC3X0ZYjsR6ulNM3THaRdyWC/OSRSl7JrQJF/oE0dgHlz/TcflPXhfJf9YcyVA0b/RX
 lw16nqvQAbw8rSIS+SF2U/z7YkEULtlg9WhD3UbphCfvgCyGR4EMe6m+nh74D5BZuaQD
 OYNw+JQsHgkVy68IkgNTh+ywP3HOUhxqwsdqnreBR8/phzch81AJ70JYz8tKG7ru5CMr
 j6c1nORIadakkVsgFLRtS5E5QhuS3xta2sbbq+T6Zifv7IzEgCSVMvO/lrEX29Mf0b4y
 ez9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724602; x=1794329402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JbhTB+B0Anj4d9OdOpaWmw74165WNQw1S4WZRmBAgc4=;
 b=vLIJCoelv6lDpqXuuQ9/Qap0hJQfP2UWlZK9HSZ+DH7OndRWNvHZXbF1eM50q41i4Z
 f6MPk4oUdtwRhuBzhpgkXUnN55g38NwgvYy330PaFvl8ndGG0wt+pJFwWTqsKsnVP63L
 66tZ76ujGBLeefKJCpJnh8y3PPFLRvemZi07OlmGkOx4Er0dWAm2xTicGMreYlA5+w7/
 Vo5mqD+6URDy0yEk6CoRjtMIKRjDs6DpuyfK5fw74r4S5FWN9a342lSfp668+s1aHi8Q
 iMOXb40p+p+w3lyjlxKh6C+fI8TouiIXyNf1qiP6MP2k/Uln5itPcI89apVlqAqLkn3t
 FAYA==
X-Gm-Message-State: APuU4Z9Fy0PAe5CN+Bc0uvbScuMtAjACobFy0Nfq79zVfRBSfDirSJp6
 URuxNSiSc2Q5xdg46D0ohT2uAqL7ZAuL5xYS5z/t5/hEVmeX+z1v2/UTzmVJeA9s
X-Gm-Gg: AYBFou1IGB3Zab0JNABR6kIyGI0ROkAnFv6C1A2IB8drVi5i1cGF7rGMY+nM+5bhgkl
 G+cur50uVucRfr6d+vs/Cjarwma5BcNDWfwxdaGLi8o1f1TkvQXJygEhYi4XlE7UD3kWVotRtiN
 M3xKIm2liFESqpkwWSL9V4vzC7haEFfEgfotiAr4ksjNNZ4kWskweZRP90Lyfp4TXXbvvMg/ivB
 zlS9AvnuiN8nZOS94T9EH80NcJhhFuzewn8IcpUusMZ6hs8MakuRyAq2Jd16G10mk5AcCkD/6w1
 eRjHeAyBWhQ2dd9Zu5KT8C0bxqe6TJI8ADb96I/+EYS4DpKIra3+cGsaBRyptLyN5B/evzlWrHd
 JYD7c1BxtRayhhn8dO3gFrQ1Fy9NxQjCAWJFC3iLTGL6oLhwZClsf96+O0TvZ11f5V/HWOeUh07
 BjVJhogQLQ7j8n62RlC4DiMr725htXo7WitsMCK57UQJ/snB0m0jh8vL5OBNZJaZuJ1CaARlz7Z
 vgoKX7zS0o/uUVjSKarsaNccO86gtE4RdVFfzXvfC8TV/uyWHnuswY6Md8lWPl3PyEq3CDDhAuk
 iSoPauIkcC8HNMDoNvEaa/Hb+d4Nd+J9t9w1h3Xa4pwwTLS1S31V4ynVIg==
X-Received: by 2002:a05:690e:488f:10b0:677:b45a:d5fe with SMTP id
 956f58d0204a3-67ba4f52b03mr4871506d50.61.1793724602125; 
 Tue, 03 Nov 2026 08:50:02 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:01 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 1/7] fs: jffs2: check cached-node reads before dereferencing
Date: Tue,  3 Nov 2026 13:49:47 -0300
Message-ID: <3aa59d06749e1a984b1862c2d406bf845512858f.1793724561.git.wpopov@gmail.com>
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

The one-pass reader assumes that get_node_mem() and get_fl_mem() always
return valid pointers. Read or allocation failures can therefore cause
NULL pointer dereferences during file loading, directory lookup and
listing, sorting, or symbolic link resolution.

Check the returned pointers before accessing raw nodes and report the
affected inode or flash offset. Return an error if the latest inode
header cannot be read, and skip unreadable entries where the operation
can continue examining the remaining nodes.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 60dacf13448..f21def1821d 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -604,6 +604,17 @@ static int compare_dirents(struct b_node *new, struct b_node *old)
 	int cmp;
 	int ret;
 
+	if(!jNew) {
+		printf("%s: failed to get new record memory at offset 0x%08x\n",
+		       __func__, (u32)new->offset);
+		return 0;
+	}
+	if(!jOld) {
+		printf("%s: failed to get old record memory at offset 0x%08x\n",
+		       __func__, (u32)old->offset);
+		return 1;
+	}
+
 	if (jNew->pino != jOld->pino) {
 		/* ascending sort by pino */
 		ret = jNew->pino > jOld->pino;
@@ -704,6 +715,11 @@ jffs2_1pass_read_inode(struct b_lists *pL, u32 inode, char *dest)
 	if (latestOffset >= 0) {
 		jNode = (struct jffs2_raw_inode *)get_fl_mem(latestOffset,
 			sizeof(struct jffs2_raw_inode), pL->readbuf);
+		if(!jNode) {
+			printf("%s: failed to get latest offset at 0x%08x\n",
+			       __func__, (u32)latestOffset);
+			return -1;
+		}
 		totalSize = jNode->isize;
 		put_fl_mem(jNode, pL->readbuf);
 	}
@@ -724,6 +740,11 @@ jffs2_1pass_read_inode(struct b_lists *pL, u32 inode, char *dest)
 			jNode = (struct jffs2_raw_inode *)get_fl_mem(b->offset,
 					sizeof(struct jffs2_raw_inode),
 					pL->readbuf);
+			if(!jNode) {
+				printf("%s: failed to get memory at 0x%X\n",
+				       __func__, b->offset);
+				continue;
+			}
 #if 0
 			putLabeledWord("\r\n\r\nread_inode: totlen = ", jNode->totlen);
 			putLabeledWord("read_inode: inode = ", jNode->ino);
@@ -745,6 +766,11 @@ jffs2_1pass_read_inode(struct b_lists *pL, u32 inode, char *dest)
 				put_fl_mem(jNode, pL->readbuf);
 				jNode = (struct jffs2_raw_inode *)
 					get_node_mem(b->offset, pL->readbuf);
+				if (!jNode) {
+					printf("%s: failed to get node at 0x%X\n",
+					       __func__, b->offset);
+					continue;
+				}
 				src = ((uchar *)jNode) +
 					sizeof(struct jffs2_raw_inode);
 				/* ignore data behind latest known EOF */
@@ -830,6 +856,11 @@ jffs2_1pass_find_inode(struct b_lists * pL, const char *name, u32 pino)
 	for(b = pL->dir.listHead; b; b = b->next, counter++) {
 		jDir = (struct jffs2_raw_dirent *) get_node_mem(b->offset,
 								pL->readbuf);
+		if (!jDir) {
+			printf("%s: failed to get jDir memory at 0x%X\n",
+			       __func__, b->offset);
+			continue;
+		}
 		if ((pino == jDir->pino) && (len == jDir->nsize) &&
 		    (!strncmp((char *)jDir->name, name, len))) {	/* a match */
 			if (jDir->version < version) {
@@ -957,6 +988,11 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 
 			jDir = (struct jffs2_raw_dirent *)
 				get_node_mem(b->offset, pL->readbuf);
+			if (!jDir) {
+				printf("%s: failed to get jDir memory at 0x%X\n",
+				       __func__, b->offset);
+				continue;
+			}
 #ifdef CONFIG_SYS_JFFS2_SORT_FRAGMENTS
 			/* Check for more recent versions of this file */
 			int match;
@@ -967,6 +1003,11 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 					break;
 				jDirNext = (struct jffs2_raw_dirent *)
 					get_node_mem(next->offset, NULL);
+				if (!jDirNext) {
+					printf("%s: failed to get jDir memory at 0x%X\n",
+					       __func__, next->offset);
+					break;
+				}
 				match = jDirNext->pino == jDir->pino &&
 					jDirNext->nsize == jDir->nsize &&
 					strncmp((char *)jDirNext->name,
@@ -1002,6 +1043,13 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 						   sizeof(*jNode),
 						   NULL);
 
+			if (!jNode) {
+				printf("%s: failed to get jNode for inode %u\n",
+				       __func__, jDir->ino);
+				put_fl_mem(jDir, pL->readbuf);
+				continue;
+			}
+
 			dump_inode(pL, jDir, jNode);
 			put_fl_mem(jNode, NULL);
 
@@ -1086,6 +1134,11 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 	for(b = pL->dir.listHead; b; b = b->next) {
 		jDir = (struct jffs2_raw_dirent *) get_node_mem(b->offset,
 								pL->readbuf);
+		if (!jDir) {
+			printf("%s: failed to get jDir memory at 0x%X\n",
+			       __func__, b->offset);
+			continue;
+		}
 		if (ino == jDir->ino) {
 			if (jDir->version < version) {
 				put_fl_mem(jDir, pL->readbuf);
@@ -1116,6 +1169,12 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 	while (b2) {
 		jNode = (struct jffs2_raw_inode *) get_node_mem(b2->offset,
 								pL->readbuf);
+		if (!jNode) {
+			printf("%s: failed to get jNode at 0x%X\n",
+			       __func__, b2->offset);
+			b2 = b2->next;
+			continue;
+		}
 		if (jNode->ino == jDirFoundIno) {
 			src = (unsigned char *)jNode + sizeof(struct jffs2_raw_inode);
 
-- 
2.43.0

