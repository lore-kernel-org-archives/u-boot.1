Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C7606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pKgFozoC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDETkkb5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F6EE402D5;
	Wed,  4 Nov 2026 12:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9pKPJ-ZN5iv; Wed,  4 Nov 2026 12:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D558040596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796631;
	b=cfZJydIy4iNPq/XnN5YuzWNalep7/FW1phZP6V8+G5hSYzRiz44NHQExrHqiGU2xwL96
	 0j4L9qNLi+scpJxShJHzbP0YHe0fRLpbgHTU+A2d9sUc3+7IU2lsl4Av6MDTGvVUZuU95
	 l6zZ/dUYlFvfq5jKbayxAVJ9+kAbYv+xqYkn/z3F4vA+0JQHdYnjkuLIMErOqDmiAKeCA
	 iggnUQTUTdIB6qYuJGjn28oimRW7CC/N9AVaDWtA4DI5Xws4YROw6HW9ESXin6j/57ei8
	 CxbHqT5nyfG6PSTw+Kk5GzC/W5zHItRmtD7EvOugV1Xs/HCYtESIEPD6h/dBt7GEj3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
	b=HHbOx8qrcHIx2rgct5AQL+2aiiff0FD1MjOEoLp/pfZq45BZVFF6Xx9vnNNNunvmza5f
	 G442bTAfujJ3OzJexvtfabwI1rxRCQ2NqEwKeSgTcudqkwbCik+m1vzZ5gPEFafiRztyV
	 oYk48GR5UpfZn8dqOVUZbf9mbNnokcwZwsPlSntCpbD+A+os/4r0qPSS3Ir+egYJRkHBb
	 HpByEFGqKJMuvRhN8XORjGwJdkxPrxgh9NboG9u0kBwkbHs/IH5pzscegbRJl0+VI19sT
	 q/sed3Q8TmCtd42Kh5IwH4kv8t84Q9El33YhjegPsNMRcGLuBRThTN4Y0zNTk6q/w7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796631;
	bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKgFozoCF3seRPzQ+yJPMcWFFgB7vSglQY/tBeMULrCeFaBo9Wa1kUdH2eRlfWR8g
	 9QSTRn04fzwA1K4VnL8ipdbE1I7wOCKtg260iAF3GTMDswzTleJwZ2j2SlYmr0eISz
	 ohw1ouw6COcZ3R7zdmtnSOEgPsw0QnakavZtbp4VGyKNX1wvwX+StqfFVa478b9n3m
	 Qxe7OrYrKRkeDYPw+xxpch9L4wSt7RbOC/apwd8A2X7fBLPnEIbJ7Qwp0r5jn3Gsj6
	 2wGJkG1Pcs6pwxye8vEclpPN4bydUUIX3sCZ6ZtU3ATl5lX1qA9IoawWDmvoI7JrKO
	 KaUFzQAkoJ96Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D558040596;
	Wed,  4 Nov 2026 12:50:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D52D6341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6D16400B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7aEhR6q5Vowb for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C3C6D40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796629;
 b=tYjMrIae1zSg2FGHth8WZsAB4IkuTNeCECeF1geRvuDjWH82VfkjJtVnNbmu52qmELPE
 PRlFTR70qeaXbikWvne+18q7sZn1q54RDMaDE6eMRnSsQVQ6M+l0bYhlWSklKnbrcMuC6
 Hywi1XuokXKatki8O+d0bV7WFHRFK0edrHbaDtgYud23Cu1VvjYlMOWdKSqAhTDLojU9U
 RqeMACu6mFzUI38kQuQjg6Y5Q+4BHhNoMwLfhJRMLVkPrCmmp45bIYfCuvptnxTVpxDIJ
 5uCYwKwlOfsulOv4cSlndOgKbumaHEwYhiIQzOZf6Ni1NU3w6fKc5evNRXrhdKB6bqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796629;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=G3ZPrqxgKeKIZw3LF2+JQv7XMWa+hlC0phip8U4kaNF3l2st8Q4pLSNWOi33jF5vtUTX
 5cMqHN1Rry7RG6lq3tQw93wsjs89y0GNCoibqV17xRaVSIiNo8UPH8BSUf6Kul16dEoTc
 bHet2689wQJf4HWehrNGw3iGWNTa9gAHi1Zdk80KDHnLjDkJ6M/y8rrG1qJbY0+ucM8bI
 DYZotLe6mD607jpuHqEod4rLtu4eBzOXyqBkZMbKaukY4yZFUVli6GQ+t6GgG5KfmziSI
 z7z9dJDVzxygSViEX0+XrxKXDrYXCuZenqpYVBbdY8JFpHF5+ZjEbRzW1PWs8HKC3CA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=SDETkkb5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=SDETkkb5
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3C6D40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:28 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so916743a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796626; x=1794401426;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=SDETkkb5ASJ0rDs53E1YSVac7Z+O4LVM8qGSwxp5GGXecNHD8unX/3lEP2ghnxFemG
 LsCiSDICArZA/oO66vmEwZxur9eyEictZYvoZiQXGObpYtntqEqShF3NRCzXSRRYBv52
 YA3PUfS9BO6kY+Zm0zmN3WMEa+8+0ePwYrQYdVsX9H6i+N1lRVIbJRILOIaTK78RzBx7
 25N4uzSw1sPW/4bm6srNNfv7APQ4NryKFlNnc2P4NMLj8r1plo3h6VAXYdP0B+DlJvx2
 Gh6AotdjDQnAg+78f7DVZc+9laC2TQG/YvT3XZHYB8vDtmAzHv35yF5byaSeS4GqUvcX
 3KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796626; x=1794401426;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TkW16wO9GLe2G6aCtR4TQ8gpNoVNtcc30WpD+u5SQBs=;
 b=yIxkkPQLsjhfE+ij2McfKQDnCrmV15NW+Lr5gI4ejnYLsmgVVL4pzvS497sLHnRuE2
 qyg5FdeOF5BxboEsE0G8IOVHZCXcgTBZPUtLvKjHer3zPPYN9VdnKQ7BMOM82RwHx6s8
 O0uoZzNjtFRIzo1I2T3UGPFa3ZrWYHvCVVuIsfaHgrBZ1Q/Rz9xCYhaZ+/kuXxODpg6J
 mnRIiTREcUq43LSt7QEYXVPzN9Gi2U7dmc3bov/JhkGSeZXP4MYCthPoLxShynNLzbq3
 rX0zd/N16jmIXhIDIslfXVwnGhSl5vUKwdQio+Idxb4o85Wu+rHs1cBPADt+bW8jV6Mp
 nKfg==
X-Gm-Message-State: APuU4Z/bvNwaTHNqnYT3vYNSBGYy+ZrElvbdeb6Gn97VRhncgRVo3EvZ
 fX1SwE368RW5STzYblAy4MR4ZIpXiNt8nf3jglhPffNszXlvFgHrY2wP
X-Gm-Gg: AYBFou3pvprDElsh2oU41dYO2JZA8QL/8GJl9FVYQeYTsH9RNVtnd/Sv+fXX7zm0fDe
 jhpqdToo5wI0+B65QPqP+vDeBEYKElUJ3jKwgPI8GaXfIqyV0rdBOKGHeRJfjld0zeU9FpCCTzH
 4jLDP1vm/yOddw0vsEWQ+B3RHcgW4vvcL+jcGlMZz8/+YDpldAet+jHk4gihPS4NfP4ifsiZkVH
 2CVKqC2TOdnq57tQyfI1Od5K8SwKpFxymztK2hhI06vbhsX5q+NzxoAoO9/TgrebpWOk6iVX8+q
 BhFLMCP0lC3F8sFcoPyheVVe3PgOP+F3W9H39iBCvAHQhYhYMlwM/qs8341/5j+E6Zkm6/zjNox
 R9Vi5wpa/KQXZQEq6JpREuGzo4YPPexKQBvOGBST7LynOpKpI4Q9xhhoCZcLYSXM1h0IBOiT5FY
 R8Nt2Tkqf7ayY0qf0vZqlRUy7FuekSVeEdMiugwEaBDAfiOLQ0wqQhVlp4URBIvXutB2a8B95sR
 jVyQEHbYuounK9SMuXsXzhFw3bkr+jBu8udlHQlOo/Mye9jkRengDNHQpzsNS2GbkeShAiCWsC1
 b9KH+zAY4+xXvWshfq9tyIYT01jhT68=
X-Received: by 2002:a05:6402:2485:b0:6b5:646b:2c39 with SMTP id
 4fb4d7f45d1cf-6b5646b2d7bmr1102548a12.30.1793796626140; 
 Wed, 04 Nov 2026 04:50:26 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55abd3d83sm746030a12.2.2026.11.04.04.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:25 -0800 (PST)
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
Subject: [PATCH v4 01/14] treewide: Use is_power_of_2() from linux/log2.h
Date: Wed, 04 Nov 2026 12:50:24 +0000
Message-ID: <6d561e1e-7252-4025-95a2-0c1cce97b097@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
