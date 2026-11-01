Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E162606A326
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cJnO3zO4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmzcMd0W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46404607B3;
	Sun,  1 Nov 2026 07:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KATAiudJIyXb; Sun,  1 Nov 2026 07:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D58260748
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516502;
	b=n96bfnapiA2igNicFOekojHVvxKB5L/wELlrXZRKoxC3kYCLANU16Yjb19QnTeMQKobU
	 VLh7Nh7I/wigFIBBH9SuiG5PWnkco452TfFhqYZfp+Q1nLwly2+g1p25BgoR2xsez70zp
	 VLYydZlpAKZAt82OnEcrPWED3IvZld/kl10EP7jOSFJvqD2e4efgqObDvrdhG3Xez6dR2
	 uRNuwFPXpEM7vIX7YmJqgy5/z0TK2VHvVbUzJQwh9BSD+tMupS/k3N8EfT1RYaXXQXD23
	 QtiOsQ49/5PTzN0Z6F17XCVT/pDJEMK4jlmWtpc0MRpc9BU8I0s0ukkYLYjCR+dbIRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
	b=cwn+z4hMUVxxEJMbq7z9qNJZXQdZpR03ERGLzAOengl/auPYAcoIenxoMwH3xpUN6Hvm
	 fcbexHbHZ93OxQRsziKym6p5pP5jdzbFWFDketJYq1hS/aIpgGylavLLRYnUICrMjqga+
	 BG0fFQDSmjGScr/4Muu5AXXxQzh1xTTLqcmZKnI3iafQiXcfVKfpKgobQtAX8Xt85wmeL
	 4McuI8Q8c+LXNc/zMO41BxCgZVaWZM87OM2M4r9Sn5sQQsIYfbMH5/dA/1Vm7uVb9nsBD
	 OULi6j3uRs9uu6VzRws1+1aEGVy+6Siqhdcff3iDqe++SNtWahrDy2xbONMZavvD1Lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmzcMd0W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516502;
	bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJnO3zO4Y2FYhoHnIdyTWv6QedAfIQ20oPi1XgoohizJDiAuNKtHQLDHbhPRBWgYb
	 lG06lJ93cPprl61fYfm+uPlgzaEN9nBzdx28k4SVGIxEXnrGO24cmcH8KjC97Mvsb1
	 9mzv1wi4IL5NBHsJ6Dc8hjj0AfDt9geR696rhAtW+sze5pj8SIAbJB+eSYlOBRMWKI
	 XZ0nVKJ8puXw3pU+YcTk3yhDEMLGgVyK4ULB5IvRc6TFJtdrDjIKQo1Hq+4md6ca7e
	 +S4o8yvGTOAEmXKZ+5yyT6D0vdrffrcYSBs7CsdvuvmpPQfeW/YI0YPhSUC36zioIS
	 44ys8xAkaBAsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D58260748;
	Sun,  1 Nov 2026 07:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C032411
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D71260748
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KigXbP3B5zMd for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36A2660725
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516500;
 b=k5d/o/cTDdH3rChESluPRv0mhha7oT/PqOhOHdGk9ABXvoYO4I/h8rO79IxrPslqJ2d0
 KODN93/hWivFwE8d3WOJlzy4nUhVs6Fp6FM5sWEh4WEv/CjQeLD4uvzOqS/T1zAMSxacy
 hJMJNnIqzMeeYCIQbbB93mTpkqkVrwLkgLVwS92JGpi3kZZtggM7hQ8GvpvudJ5GK2vK6
 ot49trad9cNWoxAJ0PiYzvhZeSAmMg09uJINMc3Jsz0CgpHIBr+vg0m6h0y8oAfCIB6l9
 +NIQMF9k+AHLtC2tYJjzD3rsd+l0yGeavyUcu2ULyXPQ8SIBpubFm1Kx+VsSI5DOnWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516500;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=DCqzNOw8W5cQngzmT6+yqHh8+tK03moxN8fESrgAS3TGnynbMDGJ/M+9AOXcoOz7xzNq
 /Zb5csIGciqMqONmR4aAdktm2Z8mbhTHJjbEXsZD96vdzjdvBlVdxY8+aGY7/gKLXnMRl
 obMu8gGw8NMxupPeN255wHsy9I7kLUGtbXpgrZ3Gwfmv18IL4qTOMtoKUEu3Jg8D7qCWy
 8tfXiNiO4hKA79qq/2FU0d/xKpDN1xgey3vmtyqzGfZvz9E5jA2k/MFWIxLEWyU7Z9nm+
 l51n88E3ljMsQdAnZ6Uzg22jdJdkwVvP2Qg7Qy7CUIdS/NIBFJnumFICoC6yRaRREWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZmzcMd0W; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZmzcMd0W
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36A2660725
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:39 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1718311f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516498; x=1794121298;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=ZmzcMd0W0suSileDiDG75jzf09j1ZnKZ/0UShTLUCDGapxdfvMl84SO6TXg2yXjmlb
 5+BAGTwP5sL68XZFiHxta5l7J+yNsrnOdn1G6Tv4SpgDkMWdJmGAFTlQm/OEkvpZB5Ax
 eLebsVEW5NvaI+Z2IxiqEnPjXGj7OZY4NCSohqq4ngREghlYApsnRcifvwimWeoh+17e
 qORQXbRkOLXlIxjPccFXpaL7t23z1GWgMLcWqbn4eVEtT+ScApPDm5WhlwdBb3E+GXy4
 yVpgNtT3FPZOMkh4mGtboKmu7Ebesd6bP8IufkjHyyJgOJFJ17e/uwJx+aGLcbA1KHoN
 VQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516498; x=1794121298;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=mMbW+GTe3tevvxl70Pc+/iJpR/RDDVREgFQqd6YydRaRIDJZES6sr7daM7+5CF7bao
 MWt6MLFCoFQm/Mz4a84QBToaKIGs3ihGC0eSEpaxfhM171pWybcJOus2clW4CjjpNS8n
 aDxcTBAm6Bps1AWgq/yD7K5+UmFk8t1Eh0C8CtX/fIdThVb4zk9ym9D7aiizt6Aa0f61
 iraSeZmO2d4KzPMvsLTBKY5I9NMONrQtg4iwPbSFpb7OozFo5h/q+BWTjUpF0jOZjUYv
 rBKhpfCvM/VJuRlNo3Dtg+uhcr3pIKTKDlE0wqTeZdDA41VWR5lnXuxpzSbWPa7yNkPo
 v/lA==
X-Gm-Message-State: APuU4Z8J0CHaH8GMaWTUlcbla1Mq5+TGEEkm5OeEigWMnuRe/6HwUfuZ
 uIkZQeThVRitZ+2+/OSzKCHhwJBZyICURVkiuvZYN6Ldc3NgvYkBaIFM
X-Gm-Gg: AYBFou1pPQbfDMU6Zc+o4G8YEivbL6dnGGGp82/BI7hsZiQPAt4Lk9GzOc0Gb5Mg+4X
 rSJLmC6VWIyYbYd/mqXLgfJsHPBxzrFivHxdfYs2LQvGRV0M9ZrxUFwlUVrS6jne66QjKnn6wxg
 Pv4vwDP+gMS8LfglrNVwh+CFM+NFGl8nWR42C8AfFty2faURDZq5ZwX1qmNAVZJBvKgPiaOJZ5o
 W2qODzCanykK8hFSliG+XiZLk8TL9Bb5PB795vFllDWARya4jmtvtvJdoMFCN2C0hZb7SzfVq1J
 QyKYGnUTMEn80m2AH7p76tNVuC9z1DQZ59TadZ/RCC9vRiKezWU9/xLRKgVqfkT4EganAIpPe09
 W2Kq23bLW8fACwZcUDDcFVrlAtc2oFnT/TyYgN9YhfwjERGG5TuwojSZL5K2pNgba9Y7g+vyIPm
 Ih9YIwM3SVTtTQ+aKjuWZkcTAyUZQdVcneaIYtVvMfd8TlTFn+QvHa346QyyUoMK/JZ6GVq5R57
 Dt5jAqjG6Huo6rOibI5OQcvLdffQcUYH76kgOX3qiH8GycLCBBZQSXDGUCQEPMCow2htT7DiZUc
 62U4oC+5wrykzBaXQezH4eT5Ony6SQM=
X-Received: by 2002:a05:6000:1ace:b0:48d:e62f:db70 with SMTP id
 ffacd0b85a97d-48e6e30404emr15583954f8f.48.1793516497647; 
 Sun, 01 Nov 2026 00:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm12691290f8f.11.2026.11.01.00.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:01:36 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 01/14] treewide: Use is_power_of_2() from linux/log2.h
Date: Sun, 01 Nov 2026 07:01:34 +0000
Message-ID: <986d4fb9-64e3-43d3-b9cb-d2a0946925ce@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The btrfs code and the bcm2835_sdhost driver each define their own
is_power_of_2(), which clashes with the one in linux/log2.h once a
header they include brings that in, as include/blk.h does after the next
patch. Drop both and use the common one.

The btrfs copy is the same as the common one. The bcm2835_sdhost copy
takes a u64 and also takes 0 as a power of two; its only caller checks
the block size of a data transfer, which the MMC core never sets to 0,
and the Linux driver it comes from makes the same check with the common
is_power_of_2().

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- New patch, so that blk.h can use is_power_of_2() from linux/log2.h

 drivers/mmc/bcm2835_sdhost.c | 6 +-----
 fs/btrfs/compat.h            | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
index 720127468d3..eee7e2d43a2 100644
--- a/drivers/mmc/bcm2835_sdhost.c
+++ b/drivers/mmc/bcm2835_sdhost.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/log2.h>
 #include <linux/sizes.h>
 #include <mach/gpio.h>
 #include <power/regulator.h>
@@ -660,11 +661,6 @@ static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 	writel(host->mmc->clock / 2, host->ioaddr + SDTOUT);
 }
 
-static inline int is_power_of_2(u64 x)
-{
-	return !(x & (x - 1));
-}
-
 static int bcm2835_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 			    struct mmc_data *data)
 {
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 4596b9d1dd3..ffeba740eff 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -4,6 +4,7 @@
 #define __BTRFS_COMPAT_H__
 
 #include <linux/errno.h>
+#include <linux/log2.h>
 #include <fs_internal.h>
 #include <u-boot/uuid.h>
 
@@ -74,9 +75,4 @@ static inline void uuid_unparse(const u8 *uuid, char *out)
 	return uuid_bin_to_str((unsigned char *)uuid, out, 0);
 }
 
-static inline int is_power_of_2(unsigned long n)
-{
-	return (n != 0 && ((n & (n - 1)) == 0));
-}
-
 #endif
