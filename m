Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20207CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D74CB405D0;
	Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIBG2iGjZNdK; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F3154062E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813687;
	b=BTIPVy/o/x6PdclW/3XfUu6ojuz070Or9EWBqYeHAjd/W3nXC+hh0fSFJUW11DAsVlAl
	 FfQW+j3OO1xcI2tfYwnzpl0c1mb4xClbaeRVEafk+L0sdQqkBpj6Z5kK+ailXmUq5gZHg
	 IZ9YGZm/AAnwqKBVXqUJnaaRrJZ4siZPq+jCWcMgmU8YsO6FSMu66wC2j1r2/5SAMOS2O
	 3QRpE4BsHpPxBuXdPF3z4K9BgUd/YC5x/c1yNAb/seOQ/YQoHuzq8teAPSnBRel48nQCy
	 iBwPMJsKJHyOBCPJ4Z8ITKrZZYgtJ8gT9AJBI2b6bLHB3tirKeObsbxQrfdkwoxTo7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MuGF1x1+rJxSRSKdQHzryOc1MO1NkPUrc85yq6h43+4=;
	b=KOzS43WSVJtnObUHuD2o5V67C7WsE3/NDjkSgdbaY8s/KLaFM5SmtE2TyofV7jZuKLKZ
	 oo26uBoJx5m4AdtHg3zjCwwQUrTTJ1EuaclzVMR1GhANPJasRf6LcQaUmQosCD6xCii9V
	 zWWAzjOYMoN7js31kTONeEURPMh4CZ6PUQ4sH88pcwMc+Vb0+e0/fjmiZs8JBlKVApihS
	 RvqU9l5gxIvgGjnRcsdeFkxbkKZKz9sRDX6Z6bcG7NZHHlYbjMCvOHteWFkTAUFYGWcM9
	 L8pv8v7u2pTh+DaEgcLycts8qj+h58oEbwN/+PjnkrJGarJSESB1xUnRS0VxkhX585w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=TAciNsH2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813687;
	bh=MuGF1x1+rJxSRSKdQHzryOc1MO1NkPUrc85yq6h43+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZMHGPmpR5wEBeJUIbpMHligI3+kL6qAwzc95pSxHv/QJ2+y3q8iIGxSxF16ffdjY
	 BWYk67RGBq7TxRxcy9A4WtPia74+Dy7YHHZpcByZywTwLOoV4oFh3Ms4IRILxrRwui
	 LmxRKLg5uXXuREWv+3hP4IXgElHMgpqnCrV3BDnnRxXXATJVpTuy+IMrJ+cgdpUogB
	 yrokx+tqNqkXUQfszgpjEDHHy6CXrUeJSWpqw7PJ3qAjbVS4PEATA/r48K2vhX6LWd
	 2qfzOckC2CJ8e3htZVW5l8RVcNrM54PmDGyrg9R8NbADIfo+xSKetu2uyEBSHk+iWl
	 4fFONiPA7Fcmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F3154062E;
	Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAF179DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C104240649
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaVdaw_qTktc for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 059404062E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813685;
 b=pRS8gUvWdVI9K597IM648cnUBz3GH/T2qxyg38Q1itNAepS5lz83XLDXCyge9JJzzeKV
 zodwclEJJ+AZSeyJSGq+70k4cS38gT482JYuD6ueUgtE0yHREPxGUOsDjvfdskSFvU+AM
 AWn21gybiXiRONdYpJy+31YpvBxt2rqlhR9kWJI6a3d7fCN1kee+vDw5ypahYjJhKynYJ
 YUUicNQFVdPt21X0e5CH1DWkLT3e81dcdjrUpXlnsp7nA6eH0Gd/Zw6lovLxXKRcBaIFJ
 j0yNbCC1mAKK98dlmdaJilTaJ/rZmZ8TNhZ8W7emsYtQ9rBQJ5lboV1hqyEGT0W7bgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813685;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MuGF1x1+rJxSRSKdQHzryOc1MO1NkPUrc85yq6h43+4=;
 b=abk75Nd2meaUbeT62546ILUfLapJWFXUktZXjDBQ8e47+0Ds5cmM8yQV+gFyHparzHqu
 Kl6RQFq+wDTSqXpp8VJu+krrkmQemhBd/gkDItOYhaQ78OBnFKHlUpNatGE1+Lm4ggfiS
 AW1SAlRu4ZX/kmn/o4bNjyQtj5phmsxoSsjjL4XaKZ8GJb8XmfUqDgctx57TLHqA7nqdz
 1l5fo6W6lnxmBu4UXDlPpTdQT9/ajr2zqg2vdgpdi/WGk6Z6Wx8P72bRDdSq+VaT2WDcu
 S97ZRhJ2t4xs6jbzdy6u+tnO3Ir6a9oZFPGis64+N5iCoisY0X1xovUsKppKWJa6xRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=TAciNsH2; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TAciNsH2
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 059404062E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 831373F282
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813680;
 bh=MuGF1x1+rJxSRSKdQHzryOc1MO1NkPUrc85yq6h43+4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TAciNsH2hRKxpAdzogGLDguEqogRJcOSF/djbOQcn6ouf8b3pdOZIkuf8hSjkhVu4
 TS9Nm1PWe35NPnpzSk9bnpDawhH9PNO7+Bfp2gbNDYKLD5+JYp8uSH88n+VASxG9/Y
 VF5ijRv1kpNzS3BgFFP6Aqvj57RjeFR6IUn5tcpV3W0Y3GhfQM/k3iQOZccY3cWWct
 6xZqXVl/vLUm1PVgepEoNvcz8mshkHQ+81oK/YpftCqMKkE/uwO/oaqp05iSsWOldz
 Loo4IvVAeFXo1f6Sk+xSKeSjI9tFrEuYe1xsdiN/ATvqvueVX7cyIG76xSii4fahc9
 jbnUGjOHJcYzVvO2Rc5Eo7epwqNscsYo9AmI42PqQBqkAW4jAbqv+3OnlDmniIM0fU
 gzyx96lykhgIKPXZmuTOkA69QYz1PXTm7X9BOeEJgK9XMlRPbFCc3Zea8Aa3otVVhs
 x/6dgylp3OlNvVT+G5wxwn03Cyf+2ohJ8PrQWFVKDqMMx7i0A2mbnCE8Y1KtYdp9pM
 I1BKSiZvTtj5fykda/SIar+kk7y3LWD8PmKawBG4NxDc0h+frj7n7mQ9EmRf5K4Yja
 2Yt3HapamXU4hcf8+Cq5hfENYfJKOAXx70KA2E7pgtIVzr9ZquLEM0j1KyPcrlt7Au
 NEtMMJGDwcDT3DmpCvyTen8Y=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a0228f4a1bso10926695e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813680; x=1792418480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MuGF1x1+rJxSRSKdQHzryOc1MO1NkPUrc85yq6h43+4=;
 b=EF77hq5v3q2z3grk+L7oE9hXM0QE9Lh1s3q7BZcYkvBvy2Y3bp0VBuZwzl0TdFZZlx
 EdleummgzkM2bx/OJVfhrJbRyhA0h+lWqFwDoWH3RYqtqOyWUwx4RBtEd25fvWJAn6a1
 7e48xtPZ4O38ed8BIY5n78XH7d5Ty9WgMWyAYf8X0/3gAYMdIw8DIq+9f2mstHtM5/vG
 affP75Cj3IxNREmBRSZEFNi18DgCxQx8H2n9FtBlbx5rA4ylkZzQkt88CdJk5LxZ06ZX
 x2upO1kwnmPYyO/GAdOYN0td8nL269UjLmGIbUSDONZToic060jcBU7TesI/pW2Yr4+W
 /XQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvF3//c0vvpXuOB860ezV2PmQgGdtqyW2rwqfN7zuGHygcukyPMC+TRYm/OpvxUcTVaVJkPKY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYICaXRq0zn+lMulcrGNWocaviP925lzP+STZ7FXK+VZMzdH5iqf
 Xiu4Xr/mmlTHb3Jb7LVXKTGOAdjvc3TqCBCgr5VBhl09tKrfG5oX/rwSEmRDkMWjEdUpI77f+HZ
 MiiVFv3gZReD7wHA8EAOnLwvatbO3i83E5ZG8hoCCN8AxIUU5wBjIdlcevYYksjg1tC5qjSf3Y7
 6SCO08FPhhMg==
X-Gm-Gg: AYBFou3GsSC2hFvY1brm5Yn//u07dHkUKE2wjNVDbGfXiclgBgnyLVK6dhianO91TKU
 Ovm8mW9T2SGtfod8IHtHhwOWbHX8btla6VDJ2zy+Y56OS9ZWpGY3Z8zDBmmTwskWmdltmmZ9vPS
 MuNsUOuSOjDIK8E9UWpAtquDNm/IHk03uxA/ZgxMECBKhlV2Dk6sqHG+ZtWuzLdyHIGNi+Ey/hp
 dKCvkRO3xtL1q8OhzdjfTUkntnL4NZmR/Ju7JGOdmxiwxvqtK85pZJnfntiZ36oK5BANzUgRPwn
 LbS54VMgxH2yQYrSlck8ZK2lDU/dSrWozSuDS8gklUI/3PeyP5HXVR+1YZzGeemtqf7xOK8EuSJ
 YgY5wWbxEPePpjT4nG/d3+Tp4u6+BGW4iZwnt/hTTgcNQ+/vWxUtvwv4=
X-Received: by 2002:a05:600c:1909:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a18e4a3f5amr206746345e9.23.1791813679935; 
 Mon, 12 Oct 2026 07:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a18e4a3f5amr206745345e9.23.1791813679233; 
 Mon, 12 Oct 2026 07:01:19 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/9] fs: ext4: set inode timestamps on write
Date: Mon, 12 Oct 2026 16:00:44 +0200
Message-ID: <20261012140048.214059-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
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

Replace the hardcoded zero timestamp in ext4fs_write() with the actual
current time obtained from the RTC when CONFIG_DM_RTC is enabled.

Per the ext2/3/4 specification (ext2 design document, section 4.2):
  i_mtime  last data modification time
  i_ctime  last inode change time (the 'c' stands for 'change', not
           'create'; this is not a creation timestamp)
  i_atime  last access time

All three fields are set to the same value since writing data modifies
both the file content (mtime) and the inode metadata (ctime), and any
write also constitutes an access (atime).  If no RTC is available, the
timestamp falls back to 2000-01-01 00:00:00 UTC, matching the FAT
write driver behaviour.

The ext4 i_crtime field (true file creation time, added in ext4) is
stored in the extra inode area beyond the base 128-byte inode and is
not modelled by struct ext2_inode, so it cannot be set here.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_write.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 2fba2197c19..0531190ddcd 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -21,14 +21,47 @@
  */
 
 #include <blk.h>
+#include <dm/uclass.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <rtc.h>
 #include <linux/stat.h>
 #include <div64.h>
 #include "ext4_common.h"
 
+/**
+ * define EXT4_TIMESTAMP_Y2K - 2000-01-01 00:00:00 UTC as a POSIX timestamp
+ *
+ * Used as a fallback timestamp when no RTC is available.
+ */
+#define EXT4_TIMESTAMP_Y2K	946684800
+
+/**
+ * ext4_current_timestamp() - get current time as a POSIX timestamp
+ *
+ * Returns the current time as seconds since the Unix epoch.
+ * Falls back to 2000-01-01 00:00:00 UTC if the RTC is unavailable,
+ * matching the behaviour of the FAT write driver.
+ */
+static time_t ext4_current_timestamp(void)
+{
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct udevice *dev;
+		struct rtc_time tm;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (!dev)
+			goto fallback;
+		if (dm_rtc_get(dev, &tm))
+			goto fallback;
+		return rtc_mktime(&tm);
+	}
+fallback:
+	return EXT4_TIMESTAMP_Y2K;
+}
+
 static inline void ext4fs_sb_free_inodes_inc(struct ext2_sblock *sb)
 {
 	sb->free_inodes = cpu_to_le32(le32_to_cpu(sb->free_inodes) + 1);
@@ -854,7 +887,7 @@ int ext4fs_write(const char *fname, const char *buffer,
 	unsigned char *inode_buffer = NULL;
 	int parent_inodeno;
 	int inodeno;
-	time_t timestamp = 0;
+	time_t timestamp = ext4_current_timestamp();
 
 	uint64_t bytes_reqd_for_file;
 	unsigned int blks_reqd_for_file;
@@ -979,7 +1012,15 @@ int ext4fs_write(const char *fname, const char *buffer,
 	}
 	if (existing_file_inode)
 		free(existing_file_inode);
-	/* ToDo: Update correct time */
+	/*
+	 * mtime: last data modification time (ext2/3/4 spec 4.2)
+	 * ctime: last inode change time - NOT creation time despite the name
+	 * atime: last access time - set to now since we are writing data
+	 *
+	 * Note: ext4 i_crtime (true creation time) lives in the extended
+	 * inode area beyond the base 128-byte inode and is not modelled
+	 * by struct ext2_inode, so it cannot be set here.
+	 */
 	file_inode->mtime = cpu_to_le32(timestamp);
 	file_inode->atime = cpu_to_le32(timestamp);
 	file_inode->ctime = cpu_to_le32(timestamp);
-- 
2.55.0

