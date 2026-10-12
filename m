Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE29CA9EDF
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A96BE40624;
	Mon, 12 Oct 2026 14:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-iIpbCkFOBa; Mon, 12 Oct 2026 14:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E7A0540649
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813692;
	b=RNkx9E5WlJKhMPmBiR/Yg1cXI+zlWHpmuGA21asOVyCYIXAgWqxYl99cdyLEbqLErNwF
	 JpEkB0hI/aKHa74c4HM+HW42eNzLxuJnLl2vsWrthFMvd2HbXtBF9dgENtB5EkG7l1jwa
	 AU5MuOdOfrkFkct+HdNwoLv6v1AoQIwF3fkK7xeaQL9QXN0bjgcW+9bppqyMfStMy1q6F
	 um/uL7UuPP/L/ypiaagZhWvqyubILAaPROy5MLxr2Sn37qsmup8cv29nC1CemcwTqc0Wi
	 KA1ZTubnzakOeBYK/9kPcWPGPeXyGrd3OekrvfnMbGPECTbcEGIQ7WwNgy1VE/ZKOKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6qauS+6863mYBUVE8gAUMAy2ifymlMF9k3JJZcOwu9s=;
	b=I70nA4m1ZViERq3BZp0+9dtnxDPPDvvd5RaZl6KaHEJe4cBcQGypLfOm/j4DsjX5dUd/
	 lGYldU1oQwrMvaP8NgVfDNauhkS0sEyrKcGSwBZeq/NeuUqLRGW4LF0BLAIsfaxxTrp9T
	 jtXVsbU8jaZtBOwbvOVtYoTdRYvLPGATq3dT0PpRlHoGJr37BAwfh2H197Lrn5KuTTHs/
	 8/c677HK3/AE/LyoVgYnb5yquWo02ZjLi2u30ziStiThMKQ1rlxWWfeS4uBm+iG/E2nmW
	 rDkuzRlliWU4ALxRCVOE2d9d4uBUfRBNk5nYrjVATqsOHRDEuw/hgJQnVwwtauIUr/Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=VbZQIPIJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813692;
	bh=6qauS+6863mYBUVE8gAUMAy2ifymlMF9k3JJZcOwu9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oY/4QWM+idsfgjmR2axT+ekFTtaieTswcn+04wBGm3NMKvHTAYQ3AKBZuSHd9STEt
	 K2/NdwnRndcACREf5Chp2G45T2U5fb3xgMeduGc+kLpd/FHwtlDHcW4MKWqwUuYzTm
	 5V+kAvmQJrHbMaxAfji1b3OxJR0CCh2Z+PMwOBwSsGIh3Ej1tAckaep4ESiNtPql4S
	 eioXgRascDraciBSHCfzIdPGILBuvNXchsOTejCxbkffRPUPNQoXI7jzUT5U5Q17yW
	 eNplI5XO/c6D2y1nGA7pI+FoYkVhP76qAfz/72p/wCXSBTkMiFXFW0TJgktU8jEU2v
	 EdyxOTtdiu/EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7A0540649;
	Mon, 12 Oct 2026 14:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99F60156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 740CE4064E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00SfplNNoq2p for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC6F440649
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813687;
 b=JpjPDGWp53Sg5tKG6peX6wQXw7Zaoxiu8audfNXnt+UXQP9lZCb2qQVNTw/tIlsDLwPc
 q23leRD9jiRzVUiq5RQHFAt5+sU56ufzQ9dfuimcRi1sY684he6T/UnAqED/poMS6dBhn
 gyrq49ZDnA06o7sfDjHqQZ2T6grS0JhHAxzLChZviwHfc/sdLTZCnhCwQdBE1KHKpQTns
 0sUPiz5q6XuyF4pPBaWcAnSmFr0u+QryaFyb7nueDercQ6UaGU0dBKydIyXJnlA74omtl
 /wWShrKXqWIToh7TlImVsqZ81XvS8tc8+F/jcEP+SNbOSpQqGHqusxrJQSEutxanTGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813687;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6qauS+6863mYBUVE8gAUMAy2ifymlMF9k3JJZcOwu9s=;
 b=Y2xAM24gRF6rwtGEKAenILEC8IGYC0A1q7Bb1kYQzjsauIGiGC6VML93SRL3brI/ORKG
 mJBoRK0H3KRlbv2htJdOZyxWA5ArI7e2ZEyQmjb5NN4lBECgPGjI97HgykJ8iv8emkI7J
 vaT3WnH71yRybgpxnT9l3GrkYnKKTgLy4qiUEHXmC5D9N01ewS6HiMrHpsuOZ+3n93k+8
 NR3Yb9R4MXtS1aqZ+RA3fbdLzL9kLFdMgbMMJYzjwnpYBR7Qac91ikDoP2zWMYSm3/IuA
 OG06LoSMTbX2T0Rp75RfC7ETXiQ6O53VICG90yDbGor9+RUPd2crtFd/qX/88W0TM9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=VbZQIPIJ; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=VbZQIPIJ
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC6F440649
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88D5A3F13F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813683;
 bh=6qauS+6863mYBUVE8gAUMAy2ifymlMF9k3JJZcOwu9s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VbZQIPIJliejVI38/Rs5QPAMUzj++RVm8vW5y8Z6QH/ItyP0kdmCX/snfs3XCpUCA
 odyoa1VxxqZPYNOLJlFJVIr7xofLPkQYxRzA2zmUuE9u+yj9b17IfbBcxJyY7Bje/m
 fBqU8KLSLY3BlayROxSRQWsHKNehQRMRdbbMxVAdy1OornuwY1OwyrBOiKr1pz9Bhc
 tGVuC/enysyanP8/l7SvTTC/jx+4JobIK/IIqevb/US5vVObdIk3MN+yifu7lR2isI
 UfLA90BW+juRI1rc2hkrBqbJpLr4ftcZs468okA2E3If7AAjVf9jXeDHVGgM+NjiUA
 tsLruZjbuzYawjyDf+dGgcAQtkmdj1NT1/tOAfsXmSzB81UDH+Ss2JrceF9sv59I7c
 AF1GfzBUs6mxWpogLBeLuoFoZ40fcDsn/3B/Ug+3hegROynBlrzUDtSoHSdxCAWeES
 8C48qMVNqhDKdT7CZmPepwL0pmeY9B45oSb9vWw5F4hgyNosGrvUfwI4lDLArtkVIw
 oSh/i1MB/VKL5KEkOmkF6XuOtD33Pp4p0OKQCnu2koKZE/KEO2642RWofKG8dTMC8c
 ACL3e7/4gFpX3okJP9ODAv80O9iQVlyYnUZw8wg0xgIGcu9Z3aGzYkcj8qZqUuRb/v
 /4reTpORXkRhgHSJi2q0Qrsw=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso15009145e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813682; x=1792418482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qauS+6863mYBUVE8gAUMAy2ifymlMF9k3JJZcOwu9s=;
 b=e+7bsUzb0s6CNLGDO08bhVBnlqL6l+8jAG/VhwvXMk+71M12gvsDR8ffIp+bJxAfqa
 8WsIh1ulZt7q1/q/u3VG67xBn53GUrLpVP6bkXUmPyue5+35h+yKdCbKQlmtJc4//l5D
 jwwHTmypDBn657XFkqHpCsRe1aiOOXKtXuUtzBMiM6j4j4lYy8NMk6LJvMAc4ZQnWG67
 rprCapBbGW3Lp8NLft1e1EYmJYXAViYWiDXmNC/vZSZJkndwRLs7NCQ7Rl68FYrFeUDF
 3B0v85QJP8ljVPpnJE30pmEDPhPa5ctPvR7HqM/eRV5m7WweeDsZRRmAKCPFhGIhgHyU
 VP+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQpYjkeV+4EAJ9eCldiXUh5XK5R5gEypPMEphSZnkEZpK/DGYRP2rLmyx2bDSd1oMPEP2flBI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKqQ6CPv6jTtHHbwb/YKbGI20bQT2U2AMbnFjZFBRZ0+FsYC2sc
 GsdVw9ao68JuS4QanuQizQk7lmeXLG4j8qhCL3GZ8yo6hlt0hmgx7cPd5x8AxgS7dvRo4nd5yU9
 fbsbNr9raLQD/+Vt7EirwSJu5L+CfLnXE4Ho424eewMe0aaAednuk9ptQe2PxicAfab2xQbcQZt
 3rxCpJLTbiLA==
X-Gm-Gg: AYBFou0bnRqUMDjlK4wdutbB7K2KZeC1FKWaxcWh3ytJHGUKJWW8W7hKCOmx9tPvqj4
 nOJNHLj/5juSu68QWerM5UvdeINsaIRKPZ6S2vkRQTOYt2CYpEMiSULq82B2WP+w5iuX4gp1M4B
 o9XUKeB6ro0oa0edh6hpOs/BDwlopA2v5NAk1Yvejq24c/dnr7a4FymPkgQ2QDbHRpI6/goFAC9
 4hHL1sME6mo6YHgeX69T9uMbok93U/HN+vhjrL4RfYqtFgZ+UpJ1BLyvl6YGLmhXnL/F8PwZOES
 2Lg1FjubiJDyeFvL+qK6xr7SI4ZdPQlV69laG01IK0pXRb3lCFy96R9fkiBGb7c74twMJf0oXht
 oIZywAiLZAH+SeoPkuRBtpRSS7S3kM9cLN63r6H4407T/X3ML2MsGmew=
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id
 5b1f17b1804b1-4a18e4b1311mr174042295e9.17.1791813681101; 
 Mon, 12 Oct 2026 07:01:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id
 5b1f17b1804b1-4a18e4b1311mr174041425e9.17.1791813680501; 
 Mon, 12 Oct 2026 07:01:20 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/9] test: Probe RTC early in dm_test_host()
Date: Mon, 12 Oct 2026 16:00:45 +0200
Message-ID: <20261012140048.214059-7-heinrich.schuchardt@canonical.com>
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

The ext4 driver probes and reads the RTC which allocates memory.

Ensure that the device is already probed and read once in dm_test_hook()
to avoid false positives.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/host.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/dm/host.c b/test/dm/host.c
index f577377da6a..32a9818248a 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <fs.h>
 #include <os.h>
+#include <rtc.h>
 #include <sandbox_host.h>
 #include <asm/test.h>
 #include <dm/device-internal.h>
@@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
 	ulong mem_start;
 	loff_t actwrite;
 
+	/*
+	 * Probing and first read from the RTC allocates memory.
+	 * Do it before the measurement.
+	 */
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct rtc_time tm;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (dev)
+			dm_rtc_get(dev, &tm);
+	}
+
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_HOST, &dev));
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
 
-- 
2.55.0

