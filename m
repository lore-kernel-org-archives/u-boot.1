Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8211CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F61F40752;
	Wed, 14 Oct 2026 14:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT3ozPeq8zv5; Wed, 14 Oct 2026 14:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0027640753
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989286;
	b=prxCve+7ogc6gU07XR7QzG8g4MHaNy47igSfgGijUlqmBKDmR7ZgBByb7wfVKpffS1Et
	 3/OE3gAbQ50yZrnxqTcn2tyvtzn3HAAxU3880ojlkLX5qUG0LXFzJ6PmIUu1c4HHN6jMu
	 gT9BumhM8u9Iyp0x9bVuf/3/Dy0Eid0xeI0zYHs7v+KiuodbdobxGce8lpWHCFiLRqX92
	 G6mrRZoSyCwWzmBGMUhnzKiaWekHWJZz07Rhoi4SpVJd0uL7sm7kf0pNME0T/3sQ+ECxL
	 UmR0dxM7BqXrpYQ/pi50feuSOypKggtAy9IrbF4rRW1VThPJ+lnbrHV92JyaJ9F2UXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989286;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mNOOOTvQd9L8vZtyxBiVy2YFePatZHQN2zFy8I7QLaM=;
	b=GhN2Eaz2X4ihbnc6WTsVNWBJBq+SYB5pLId+Z4B3009fpMi6LglTIuSK3zEBs2djGkW2
	 x0V845Hd1RtKark8BgP4U1KDFejejkn4AHoJl4Csg5sb4bAuJQrmaqW/xe3zRsrPkdwj7
	 UWNRr8MNb4LdzR42KkmRHuUg5Uw7li1UNKsTfBCTCWPKb7ECBoxQHFFgrmjJ0VGUeFnXi
	 OpSQjcCegV9z+TddaazETf+f/hUvNNb0n5hZ8NBE8Zcipgw86qEXS9mQylrUn82dAc3u3
	 rWrI7XiSp9iFJWMjufpBs+kHdA35eBho7UIKqhYbppXoyXHt13yHD1ZKAJPd0po+ctw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989286;
	bh=mNOOOTvQd9L8vZtyxBiVy2YFePatZHQN2zFy8I7QLaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uqRZ7u1rcT2+5cFnc0BxPqiX4Tc1sqKlWnT3cp3q2Y3leiy3WDoc1Hd16hlkFeDJ8
	 u5fGR/ocKGs23gNCj0yMJC+uH0Kna08337YPV27XQybXje5KWGcZ2UPWYKTSpTJBzG
	 ET8tnS+p4xDwNspBzNUrqUwOhC8FfqWPxcCZQTYv4BoJa/mMu0bLPSUTy8rwe2uyjB
	 ACaHiD4d9OWiQGEOV+KkqyPwZjZmdAcw5ma0TOwGxAEj4OmxRWnKZJrzdXW1bMa8m+
	 aQg2cRKB32HtsMKGA4zNVpMevYicajHX/YOc3MTOEeFCszBWXEWUHWWMSy1qoYTuFA
	 +dcDwnykiE9kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0027640753;
	Wed, 14 Oct 2026 14:48:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE67F2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2E6560888
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Bh2d4aVtTNd for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:48:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6F3360819
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791989283;
 b=jgCTpBxNeBzOKiG1Gi5swZX9PeDtW/H569YTmzxtixg5A7qTFq8d0LQPgL9orPuA0ucT
 XLHMSOxhlqkJCiKmpRCGfCGsdmz1IuSIWJahI+vr5BcS3LOur2ddwL3X0z0bVxXzJy+/y
 P0/I1G2Y9cnLL4lEww1D9425JuYx+KX1FK03zlLydkhE7ZpNhvM6N2RPYKwjjXk0+BKOa
 Kmtm3l/vBwo+l+0JTGY+bkryiELXo0N7jAxZ4UaHUTgDoyqBTN1gCBG5WKPePGk6MqUUx
 wd3CEbK9NIihRdW7da6URJ9hMTZIRGG04KqG4kmiihwtqlYiiqyLz72YiKa0eWQ4S5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989283;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=mNOOOTvQd9L8vZtyxBiVy2YFePatZHQN2zFy8I7QLaM=;
 b=nNbIIrgpWiFisw0pr/8u4hTu+sgWj8u/eQG1iDyqCiE3AklQPuTZFQ+o0XpN/kS0PCK6
 Y9SYOI1147E6p+8JcjNVG35RyG0ZwvOAygviPlS8Bq5hCg3vImsiPOtt1coGAoVnJOpv2
 47L8N00a3dW85dj4ivc/q8oK0NLnjX8nv0ARyzeS8PcVWKoKTggpJ0En761+hrrr02nDl
 DNOhxaEMRmTlEhZgG2/MFsvfSeaV9VlfJfT+AQVR6os98YqWO8MgV5jSLWzS5KhYBxsLg
 XAZu5mY3lNlsce83DIG54fwOjRY/7Dl7n4dBHuJaNOwTu1EYWmasneCK/yeNiPLbPJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WReQdepV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WReQdepV
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6F3360819
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:02 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35d0be18c71so901343eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989281; x=1792594081;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNOOOTvQd9L8vZtyxBiVy2YFePatZHQN2zFy8I7QLaM=;
 b=WReQdepVMmPv77zNFhsJVihuN98iypXtWmdiiijrNnfjk4i3Oa+NlMmH5rACwjh41d
 sEqp6qYCq4JtyTvR1KAzQlZ0gujnhuhRKEizmX0w5FuJs53kZJ4s/9AjSNCocqKyhCpO
 POs7MITMtWajWAnf4R9xhLnVQesGYVR5grGSz3UinF/OiLtDVHOfw1EYuVi4/qI5KG71
 36lzgv/nwZiku2MlCV+Uhzgux3DfYRrHT7dIjDsf1NYvbnTIyDNJSbu1fCvlsoeoHYIw
 36kFsow+p1wDhl18XkijvDrjjSPTvh0H8NEJehyvdEz3XPmp9RrJBBI4DOSywIQsk0eS
 FkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989281; x=1792594081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNOOOTvQd9L8vZtyxBiVy2YFePatZHQN2zFy8I7QLaM=;
 b=LK0NYrLQlyOmorBhT4EZXiXVWIqKRxdC8zhZMoFywOBG/fPoMEJ5kHiTS5PVI36vfu
 R3g6plqmZwZn+BJh9h4JiIjK4PSQhTzdb5HKZLEa06HXknoC3g44TAyy2/9VOIBORU2d
 GaiMywb1dGAThZClcECOd9qJWhC/ArxWc6JZDIvilL5kWunl4bzyVeDL+jXnD9GcIdww
 AsCISY0hKDbudwxGrPwDKOeEVJWx260YoVkPzUreXY6m+dqOlDs7tL+L5owhJSk3Vtmi
 kXHHYTF5xleDbqd9yzYzE2IlIPvOWVKrxovIas5W+N6udtatp/npyTJ+y21El6bWCP3O
 3apg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwliSIUMk41AO462+LT0GPofndPLaewu1Aw/a6jo8VjMhdREtuhjFELBwlL4ATe+5lUsAwyyNs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIiKUq7ssiqMCcz79iImXklweKJXeApbxVBImj2xvJDWEA/a2YB
 jDDF4uQZa/YnoO5jOw7rG4fJMcKsxV0LpH3ViBmik/NP9+eBnliTeNFg
X-Gm-Gg: AYBFou2QRI8jrEtZZdrDJv4w5SP23MkXhwccBmqBl/BEU6ZfN5tkEtWJvx2wVJBtzGY
 7QbtR259+u4E/Uf8cHZKmXwjekw2HCRDgqEGCl4JReti2Inmrc9Z9H1wDlNEdbv3DYmTfReynJc
 ONZmJjhHztrJp5/Z6WyyaNZA5PYVhaEFVwnQ1jxA79WmKPlZ7Gy+8iaTV47lK8bEtb7qt+yTwYa
 IenekBIYF+eHEWlZ091KC48aAnx5RpeNvvsiuxjfstXK8MIFOMyuNt1TwQCDJjVbuGR2Lvfpyyd
 bP109n0zDNgmo4tXlRIX5vT3AwmVDQVxZqtOR2KyUe84m8SlflyTQAEySAZYvkNy+3ymrma7B8P
 Cdmwq8qT3gNKSTYVLNVEI8409y69D+W1QaW9UmotoCLjbKAd4jFyKnYYmLukcaEZRLw/BQsvnwK
 AqVLCW1Dly2tKGnfkCHT0ddz4N8uSpfiH3jm0XAXVpN5b4jHFXTKAPNNawBIQBgZJzFMYVhA+C0
 YjIU/ULmS6QwTSRv2NxNW/1hbEehKvOGSjmv6YlTMCNDfTeuhpwUAFd6iuM0E8gShOs0eOKl89S
 bgy4fSTsY81+sbnnRRFajcdYj6gtw0Z8mqa78ECO0p9jpGEGjibs3w==
X-Received: by 2002:a05:701b:450c:10b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-16a133b7925mr20114214c88.17.1791989256085; 
 Wed, 14 Oct 2026 07:47:36 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm44840639c88.10.2026.10.14.07.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:47:35 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 2/4] riscv: qemu: Do not disable initrd relocation
Date: Wed, 14 Oct 2026 22:47:22 +0800
Message-ID: <20261014144724.1763675-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
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

Setting initrd_high to all ones tells U-Boot not to copy the initrd at
all, so it stays wherever it was loaded and the user has to make sure
it does not overlap anything else. checkpatch rejects new settings like
this, which the next patch would otherwise add when moving the
environment into a .env file.

Nothing on the QEMU virt machine needs the initrd to stay in place, so
drop the setting and let U-Boot copy the initrd as usual.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 include/configs/qemu-riscv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index dad59cc0d..63078ee41 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -32,7 +32,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	CFG_STD_DEVICES_SETTINGS \
-	"initrd_high=0xffffffffffffffff\0" \
 	"kernel_addr_r=0x84000000\0" \
 	"kernel_comp_addr_r=0x88000000\0" \
 	"kernel_comp_size=0x4000000\0" \
-- 
2.43.0

