Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5687606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sdD7Gnw7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVTQfNaR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8142560665;
	Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6Xuqy6ViWKa; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF50460774
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189600;
	b=dRKrNM6iqTr0Sd5TfJZXAYYjhiYeWIIn7LfXO6uA+2hE9m0SV2/u/K7C2EKUd4xbvF/y
	 yVcQCA7rXae9DlJLlLU+RoItiifKjFitPyhTYRtdMC9CiWfLglH6xm7xOWeJcMaeHBsXC
	 K68PykE5e6c6tS2pjsxQwcS92JdiifBiG/6nmjSCxpF+vXpQm3BiNwbk/E8h7ovb24RL9
	 OVeEbqFtwMHPX9NU7vX/jgOwE7otIy9lkCxrXLVHh/+DWrbwYkSt42QkUZXr5floc8o8U
	 jgVtTLETId6/q8G4X32K36H6Lxr6ZqFq0CVLNvQ6Ey7nvEtu0+y0ZseNii6kX6HweUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JSl8WT9lHGgZz5KtFtvIytjbn0Lx6qOgbnisSVrG1Mg=;
	b=iDAFvibwpUyzB8K5FzJHyxF2RYrR6ajYlja9u07a6flPuZRlZ8PYDzZAkdpqtlZd6k0D
	 xOwFtlcmn5SCzQ8gIjQ1sUT9mBm6CG2FLO0qmJwLw4y0XE2SCaljeJCjojhxffu+uFuzF
	 Rw4On8Z+5CZ9vBlR0YWZWLZDdwv38HXBO16gI+Q3lc0hgg0/aN8h6z46ZNfC55wM6KLzR
	 cTTOQ7tSoJQlfP61596G/eYK+uvyvw1KnP7vYfKfUD0bT+ROwDUADqCDCIyRMmvdbyv2d
	 kFQ1AVUvmOnHxKVs+K58xgtoZDHGi617yYGLgNUk74Yj0nljeXFVQEUSiDwbS4Bs9ig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVTQfNaR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189600;
	bh=JSl8WT9lHGgZz5KtFtvIytjbn0Lx6qOgbnisSVrG1Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdD7Gnw7hOvdoJp4CKZHiHss6PieXffMYJTbJqvx6lhZkkkoJBvnySrV9gYCpZS7d
	 UkG7mnJpKe5isFrNzyh6p3HNy8zRD4eNWPSPTdn9+ln2zazsY2Tsd8XHdJfV26vRvp
	 S1Hm8DPVFotY2TesWLMuhWhH2M++XnSwiYsP41bpFpb1PiqVHVapydMrEMyfVHgJRC
	 LqD1s5VWM8WSk7DZrV+k1J7HWONy7v1+wlYmb6rdeGKF6wWa3wZJ5hH15b9i9LBwMO
	 Eks1zzpzAesoi2h5NIo1vh+NOmGRzaWxBx9bJzxWCwrzs2CWB6+yufK81kVnY8qhCK
	 r9gyzrpiV6KVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF50460774;
	Wed, 28 Oct 2026 12:13:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A562AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA8A760699
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUFag8mFnm-y for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FE7960600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189593;
 b=Qd0D78ZxDjY7Ts9KxswfiNo46eFNdpMOT8A8XkExmgp3719lkcZXjdnxGBjYhX4Zw9lb
 Obo2UOjAZsmw59hXlT80dJOGcnlSeL/BMjLM9gl7bvpjJuQCvGKLJ17/ZbBbdESncqzlH
 RCf2SN46xzTO2Ao7iYJyVT8s6sJhyW3SKHzbJdm3xX2VTrRtfteojTyUwgnOkmAyOQNHM
 MS3fT7IqSGDU+a/uU7b4Vb8scyqjt9ZX9PQ63Nk5OtKGcdLHjUc+IKo2kqalnbIfMFIIQ
 tsA7aDRpXDRf8hIVzwkKuuGQwN4dV22QvY95xpFVM2IBvz3MiMdBr+I94C+iOd3AvKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189593;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JSl8WT9lHGgZz5KtFtvIytjbn0Lx6qOgbnisSVrG1Mg=;
 b=ONnZzDb+3CjlOShTLux+z+6FyyzVbcde0CdDBT0iD1bAEp/GLzVTrCJtDvNzQbKJgAae
 QcyoblNKikCZHTkx7FZRI1cR/Wb3bgfRVTOmxUC2s0BG1lKmMDGEEA9fNUWnFlxNftDt9
 z/dO3Sqv7iHZw1r+KhriImDawUVjcSHD3rlpzVKRsyv17R+AEoaLUZ3/iMbO4qCGd2MWB
 LBQu7QpKIK8V4+5a+6BMHzRLG5vx9vMOzzJ8+nd9ptEXmTEhZvf0abCYYXClb6tZIK9yd
 b0mjULQm5FHri3EAS1JOeTiN3XyDpG1pedhiylbuv6yzelH1NF/gUOjjNoIppk62ctw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DVTQfNaR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DVTQfNaR
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FE7960600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:12 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso642679f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189591; x=1793794391;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JSl8WT9lHGgZz5KtFtvIytjbn0Lx6qOgbnisSVrG1Mg=;
 b=DVTQfNaRWpJv377DTkkZguG7khUNvNYTVzuupN62qf08i7DWDi/eI3b4SVkWTCsDYR
 QHp1B1cHhsaYzkMoEmvi9BMaAWK0flZ2/Vzww2gWDbbg7FMX635Jm++Y5GEySlgpNjWR
 KC55TTzU5d4lGhrvOtAwBgrKrN29qfjKFJbFD91jp1Ja4a8NFn73IANNHKxhl6aJQomx
 GI4uiqdllj/JPAdbkjskuqhRrZVNqwYa+PzWjgQpgO2d2ltgUL2a6GCKON5aTmkMzA5r
 Qoc4i4M+a6P0ynOrnE1E8iCgt+IzfNed6PZ64Qp99e+D8a8hwSu51nF/udA65ru8/W8l
 /j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189591; x=1793794391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JSl8WT9lHGgZz5KtFtvIytjbn0Lx6qOgbnisSVrG1Mg=;
 b=C2HE+O9Y12smtYZ6LHAFeUU8GPIsPB8/6+06wqHJqyO1BqzQi6MdeV9aZY3aSwqKzj
 R6qO80owm22TpFFiNmeLczkZ6tEM0xghRXoB5+IQi2NJEdoQOpgcsJAH/k4PWP3NW89I
 5HvPdfAy5deqYzwfkDqJLOlkt7bvIAMsj8TstjWvGzLaExSZD6ENb9MHf5aaJZBe9N7D
 6KPNH5mvooR6Isb9naaivuKlW/K8+0ucIAK63R4O2bdmr2yJp8v6MNWDfZwEjw4YmhNk
 nZZHvki3k0sTmsWBFzLHjGpojYlFeGM88l05tMrAJ0h2F8r/Q+AdHbDPsjmG/LqOKU0w
 LJFw==
X-Gm-Message-State: AFq9FYL5o9+GRj44QeSQldX5fjQ80VALsOgSh1AM1cSShGUU6ew7dwXt
 55ln25Zu3HvTloQnPjeZDfs7nctdclp9FjvhRpYHN+HYqjRP/Cpx6xF7zopJTLQQ
X-Gm-Gg: AYBFou2S4Qmuz2RtQIv++qmhDoKumG8XQEwYV5J/zKtFNsopbEzJmTUJFdKdCKcBYh9
 VAqa93GvvbVtlQT1L1PVI4Y7dHErbBxl/GmhCal8cOvojJhC/0lE32YT/sMg6ldp1q0I0VuM+jl
 yF34U4HO4G87NT4Kyq2UBAg3iqXJPJ3aSZEpvVOago1yF0S3r7HKJgmMV5H1DtugA1MQrE/nkIy
 bCkug63y/dKWn5sXjGZsfkLedgyLW0YLgPzpa3oa1Znz9oRvulF+9n0+3UsdqHyePAl9IwVOyLx
 R9DU5fg1FGT45jYfCURU2AK6TA+9FdFSv03kKP36QBsc8bDSRk9PwUn6CLfKFvSZ+fcDQTZoW8p
 30XTk5vqXQzbT8D/06eTOToionmWRExKtixUZcfOpg39OQkVv3FqSRFm/ryB3iB2BE8Hl4wacdB
 WYceRlTId/ma4Ugvp2Eyg/bChwjkY4f/l4ba2Cga+Gt3XaoznNow/8htxNqILCp93XjJ8Z/v9Wm
 fCSx9bYKAnMOVqh7MkTvLBINmkS+xdaCzVCDSh4+Ax6bcFOxEvSFH6yVMt6msjTZwwsscL+3eET
 bClb6djDU54NW14WDAgAdGQ3sLD56FAJBaE7EJEDDBQq8pLToM5YNFcPDrD8s412jdDhbVdHeMV
 WpCzvbCMSbONsXa3vVrhqAnXdpcYlzs/rW36oQXgUn+wlaV43Mcuhav5eOxLd4s3J8nx6ilFJ4d
 lVKeBY8gwQ3WbUwcyd+1h8t027aJwvB+TpPCqb3Q1sylJm5VRVaQvx
X-Received: by 2002:a5d:64e8:0:b0:48a:f320:dba0 with SMTP id
 ffacd0b85a97d-48e5d5df1f2mr6201641f8f.45.1793189590533; 
 Wed, 28 Oct 2026 05:13:10 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm28113560f8f.53.2026.10.28.05.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:10 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] lib: crc8: Do not include asm/sections.h in host builds
Date: Wed, 28 Oct 2026 13:12:58 +0100
Message-ID: <20261028121258.572-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121258.572-1-pepe.schlehofer@gmail.com>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building all host tools with tools-only_defconfig and HOST_TOOLS_ALL=y
on macOS stops at crc8.o:

  arch/sandbox/include/asm/sections.h:21:13: error: argument to
  'section' attribute is not valid for this target

The tools-only build uses the sandbox asm/sections.h, whose getopt
section names are not valid Mach-O sections. crc8.c needs the header
only for __rcode, which is empty in host builds anyway. Define __rcode
for the host instead, as crc32.c does for __efi_runtime.

Fixes: 3b52337c759a ("lib: Mark crc8 as relocation code")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 lib/crc8.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/crc8.c b/lib/crc8.c
index bbb229c3892..635466f688a 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -5,8 +5,10 @@
 
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
-#endif
+#define __rcode
+#else
 #include <asm/sections.h>
+#endif
 #include <u-boot/crc.h>
 
 #define POLY	(0x1070U << 3)
-- 
2.54.0 (Apple Git-157)

