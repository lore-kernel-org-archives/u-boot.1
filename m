Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E9C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0h0MCTGk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klpm3zhs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A71F2810F5;
	Wed, 11 Nov 2026 09:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDDGhHqQpnzc; Wed, 11 Nov 2026 09:32:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9C73810D9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389542;
	b=PQpSk4OcuNtTum27epq8jUnsNI9nfPgghWgFGQ9SAYbZw1N1garH3p+XBFKYDBebth4L
	 c2AK4ZS+dRzu1clmVowHHgY+QZFHmjV/le4anR05C1Md8m5pKY+tm0wc+zo3C4N6e4EMe
	 nHT/DRV3Th/W1OrfK5uHzKwcAicAbjwxMaH9K6x3rKwZhnN15+/5BcLZHzkp7yycz77LA
	 SPvYxyzg9SOULxu2q5lrRKPFtxaMV6J3z2i/0WPqRJkFjTfYhprViZwTE7Z2uq5qmOHlH
	 D08tYWRUod4/zB0KLxKt38v52ofOePiqz8oXwFkZHvmZs7B6q6AQ0hSS8ant7xBK8pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZoqeMIudz2fykM2IRgwAr37SzIGBeEJ35U+Z6+z1cEE=;
	b=cWOWqauosErZGW+r/fM7PT/QPyjEGISnksxqSuZSi3Qo8m+UVNa3RaZoH50V95rsRvBa
	 7Lcwh06y634bmwrBwsRk/stAXbNO5MrrLsbgF+Nyu6GkB1fZ2jVASGCjttAxZQybupqk0
	 M4Gunp+O7XifVnczLERN5EMGNLb5jt9YuBpJyUQm0ZPoSk2s9Ezcb3oMByH9FTwXwAkCw
	 aQTku+v5ZwCo1O4RfSjXBpmwtoZEsXdv7XVMapYQOBh4THZl5UweIJ9Si958cjFgq7GAY
	 +Nu6EiaAQVkWqyyzti1gA3vzYb+0E0l7k9FuEdpZV1upwiCryiB6Lf3iVfQKOKbkUCA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794389542;
	bh=ZoqeMIudz2fykM2IRgwAr37SzIGBeEJ35U+Z6+z1cEE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0h0MCTGkKCZYi/tQW3EXNbYY7ULd3cjzUw11pl7MtEcQ05rKzfdeo061AAUdYyG+a
	 M2eyVkzSi1l/TgIS0VofhUoaxk7sTq9E2/C8QTL3+EC5PH5wDi23q33BlxqUWivDNF
	 oKD312r2F3OqhqIIeduYnWXisMAhqo2yKjMYuHUH5QkJSrEPD9u2ZoCb9g0oj8qaeH
	 G3ODwwursqLyNq2USZ2ndqUk85oLvHaha1Be4w+F1azIZjQ7HEDnN/JVhGtXcspLoG
	 +Y0zJzOgt9SMTFALPSgYiZAWgAJWrV95llfvM9q+Y46t2nD8R9FFiYOOl1WLoa3lBW
	 IhkD1CmgQtMBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9C73810D9;
	Wed, 11 Nov 2026 09:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BC2617CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42433607AA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:32:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxT02tdN8kAs for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50CB360794
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=klpm3zhs
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50CB360794
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:32:18 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso21396765e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794389537; x=1794994337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZoqeMIudz2fykM2IRgwAr37SzIGBeEJ35U+Z6+z1cEE=;
 b=klpm3zhsq2oVCRQGmNMUNElxVuDtioa9iDARN4it1Vijnv+ZeB0W3t5Q+WILLLyrd1
 yEogJ+RNJT94I58KqEdVP1xGYegOSkyfOiefJDzv0LTlXTUCsNCd5vpzLmFW0+nIZ5iw
 jyR+xdCOADJOSxI1fEhCOqWWGL5BQIjzYzT9B0zLiN8o+y0Dx8JckuIGPDKBrWGOF53/
 bdqLbdp23C531qk4m9HQR5BYI2Wk7LI3ygjyMDQkiy7p54d2QmqgadVAXm9m1JcxMr6v
 MO51BlJqUjjgAIRyvLs221x3hgwtD+PjqxoHP8Esi1pNBBVWr09XrFiWjlhY63nQV1gJ
 Y3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389537; x=1794994337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZoqeMIudz2fykM2IRgwAr37SzIGBeEJ35U+Z6+z1cEE=;
 b=CnSpRFr5sHt0sdoZ73WlpYU0xIzILwyHwRy0A8pIzD7UtcjCqBK1N0wtKytUJYNxkb
 22qhoMXhk/WgYNflMRgjX+39GngAkVzWPN7jry5aG8SF2oIwXKKmP5gsaYLT102UlfVA
 bkTBpcE47mYzXgCJ+ub8HLcBEkX5LglQULS5lvjsKaSiC/Wy487j2JFRL0fNMgQHQPvM
 fj6x0g1YisYUjvv39oZ4o0oyKmTwlpv7srOal15ly1jtjApDdwK75ILrGDd1rxREFqBn
 2cU5NPRMYOV1897mnwHqU7ZLfYb3y3i/pI/B/envvuXsbmQHYIzMhhCDw6Vtjnw1odbU
 6WBg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9myQAufH6qeOW5aw2Kb+pDomsZ1NZbSAO8ZDjJmgp5dVLB3Jy0S4qhUOambcAgp/Szuf7vgA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9T/q1Uh2/JT1ZLw7/Xo23ZkIPuP8z4945z6TUajgWH3EvS+mKa
 aAc501g+5Fe9+lQUDhdjrvsRS0SVQyKr4oi9gotIxaXrfiTBA9WyV8XsAC21Kg==
X-Gm-Gg: AYBFou1bxI46Aueu9d5O452O7WEDyzMOCG55px9TtRqDDZnFZS5qJGc9+wQmrwdQliB
 qEJM8LMnzCvNQYE1+pY7kZCxzO0N8w8KcWf9TOjEq/dfWGXtGMX+RZhpY0ZMF7Dy+PBPcoUROc5
 9khRSM7Xv9TYz0ab2R2VqvyvuFfdiXa7+x2ubXNdZYw9Bsrnuune7vNr2Z0LSA6APIZRCKo0rK9
 KFt00wFpn2cZ8LNI7fOjNGCDzpyc+/1Ye4PKNn822fRMmBMaaTnxNiyYk/uPCyDfkOxpNf3Dzib
 g8yr9GJ4RZMAUAOYjaEoYyochWvYpAm+Xt6+tgSrU9r0ZcheYIFyRsErbztPfuGMVJTwn0fRnaF
 nfdOqFiSOc1h1EJthQVxSiCSWpDDTwrxluCw9Cg7DkLguNg2ZfbnHqp98xradp375MWg075F+iG
 0ZPJ3CP32dv3zPje2wrzWaz7CNRYSDAxpPtNBaAAMNZ2lmQLtuHUEk9U5gIL+htYPjk6Br1cpD6
 BGNCmr487eLx0d7rcMx2c8ieXkYtA9RsDrcpf6AofKvP62CPClxGI4nWsmJhjahCMTCvibPnBJ9
 Jq7SAbPOZnl1FyT0ncpPfjwNwI35qfQOhGh9CiaVz4uq1MD6NTiTuqX0N3jRzKkBk3sH6/1gBbq
 g8os+rqxkoEkp9ePOTvr6PMobczUYumC+hieR7qbnkbgxFtDTAyFsTH0vca4M+bdMogbDLVfwcZ
 j9n92uPnh6ifng
X-Received: by 2002:a05:600c:b86:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4ba0931efefmr34036105e9.4.1794389536531; 
 Wed, 11 Nov 2026 01:32:16 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm77140075e9.0.2026.11.11.01.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:32:15 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] disable VBE by default
Date: Wed, 11 Nov 2026 09:32:09 +0000
Message-ID: <20261111093212.3390778-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VBE protocol needs explicit device support and as
such isn't particularly useful by itself without that,
it also adds size and the potential of an attack vector
so devices that wish to use this protocol should
explicitly opt in to it like all other large features
in U-Boot.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 boot/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..556e868a5f4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -720,7 +720,6 @@ config BOOTMETH_QFW
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
-	default y
 	select BOOTMETH_GLOBAL
 	select EVENT
 	help
-- 
2.56.0

