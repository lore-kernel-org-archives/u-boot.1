Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D0D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BE583B07;
	Tue, 20 Jan 2026 14:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZmYehOKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48F183B34; Tue, 20 Jan 2026 14:37:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A554483A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rv305xC2dqLr+T5M4kaDJJOifUuv8yt54KWPEF2XDGg=;
 b=ZmYehOKT2SPTnBErM5rb7xFzoWL27l2pVH2iZbWWdLC5Hk0jz3CUEUHTCnooDnVknk2GkO
 rIyCB/fTo7Ba+reI8ebJ5KveTUZNpfHlasLEB9R/S5vpm2x+W4su8Mc4puAoizRMmSe8DG
 UTpovuyKQkbBYm0GpXbqmCX5eJQzZYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-AjOwv7fSPcKhc52EZ1NFtg-1; Tue, 20 Jan 2026 08:36:58 -0500
X-MC-Unique: AjOwv7fSPcKhc52EZ1NFtg-1
X-Mimecast-MFC-AGG-ID: AjOwv7fSPcKhc52EZ1NFtg_1768916217
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4310062d97bso3247371f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916216; x=1769521016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rv305xC2dqLr+T5M4kaDJJOifUuv8yt54KWPEF2XDGg=;
 b=MKfx0vlNP5D0Fg/KzVBFAAdD/O/S75TeZJJ0Ajw+SKV6xTlIs6qd3a+3TRlxNqXGqt
 QVGpdDLvFRBJfnzr+X/DRl5kW5CpZs2zGFBufDy2A92tMQI82ES4/IVkQgsJZlq9IDuK
 Xt/IYvoJ/OAkhyksSyR8cywQddFlIc1nBNgM68jadSdyGLOb9thQSOhzgWyifpWlfgCf
 +F8m3U4tF9HPgT7+zRccKBbVJ6KCdFMdemCCIwIV+b7q1K/kQJmnH/w3hyWlSgJ8v92o
 Sga8/utB86g+dcGuLxFf47tzavCf/C1v1F5cnozLIIijAfRCcOE6NYlyILPudNFt/VME
 63GQ==
X-Gm-Message-State: AOJu0YxMPFnMd5eNnnMeclrdUxW2SCFVPj14Or7Ps6mGk+SEwkuOBp8X
 twqRAQiccyV0f2zjiajMYWH6lg7/4qEgKmaQ5u9DAYEPa57XcQDkP5xYJzQ2eCmVia4RzWhWb+B
 bvJjAKlj+TtNmvLkntu3L3MgN0qxowWgFdDkUXNF9Y7UdpZFP7qELtaLNsEt4S6RTur6Mfcpxgw
 D527zluUHv0LS49DROF0ngNWFud0DQg0yk5rTnSA==
X-Gm-Gg: AZuq6aL6RJsfM1AZzYHLc0K2R9uYiIcgbANvO267bnni3aTywoJNIBRYiwhsksXrAfl
 w0K5SyDZA4ShauoeqmEBKwnDeQdP1N95h4cI5+LgFabibEgTO4/7UZLj+pFO6YdqMw7vvF+3aVe
 meymRXy1zbJimoLj+dLe0l8X8f5nyezXoGx9Nj4YKmBQQF4PeG9Vu7QPkn3bGKAp6yQKX+A98uz
 1WjS9vNkHV6kUjZfWTwDdSfrJBD1gWs9QGsmO2OzY8TNsblX0FbieDwGq45YGumefpBk8vPSibF
 TXmbVlpGgshxqN8zklay1zEKDivSxTZ7fnXfUxNaUbIdlpbwVLvmnnjQZu0QenWRM2GBGeNvz77
 k1OPp12qkmRszuQzcFj/cqI5UAulANyP1UoE=
X-Received: by 2002:a05:6000:240c:b0:430:fd60:93fb with SMTP id
 ffacd0b85a97d-4356a053cbamr20932724f8f.32.1768916216434; 
 Tue, 20 Jan 2026 05:36:56 -0800 (PST)
X-Received: by 2002:a05:6000:240c:b0:430:fd60:93fb with SMTP id
 ffacd0b85a97d-4356a053cbamr20932694f8f.32.1768916216024; 
 Tue, 20 Jan 2026 05:36:56 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb2asm29741985f8f.37.2026.01.20.05.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] efi_selftest: Enhance MBR test for PARTITION_INFO_PROTOCOL
Date: Tue, 20 Jan 2026 14:36:14 +0100
Message-ID: <20260120133630.1695055-6-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120133630.1695055-1-javierm@redhat.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Af9ZBM5uRxwmMwVsHqbRcx6VnQCNRFfz1ULTvUokzvQ_1768916217
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
supported MBR partitions. As a result, it lacked specific checks for the
content of the raw MBR partition record.

Now that MBR support has been implemented, enhance the selftest to provide
coverage for the MBR entries too.

This verifies that the protocol correctly reads and exposes MBR partition
records and prevents this functionality to regress due future changes.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 lib/efi_selftest/efi_selftest_block_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index f145e58a267a..50d1fb29e1ef 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -404,6 +404,18 @@ static int execute(void)
 			     part_info->system);
 		return EFI_ST_FAILURE;
 	}
+	/* The first partition starts at LBA 1 on the test image */
+	if (part_info->info.mbr.start_sect != 1) {
+		efi_st_error("MBR start sector %d, expected 1\n",
+			     part_info->info.mbr.start_sect);
+		return EFI_ST_FAILURE;
+	}
+	/* The partition type is FAT12 (0x01) in the test image */
+	if (part_info->info.mbr.sys_ind != 0x01) {
+		efi_st_error("MBR system indicator %d, expected 1\n",
+			     part_info->info.mbr.sys_ind);
+		return EFI_ST_FAILURE;
+	}
 
 	/* Open the simple file system protocol */
 	ret = boottime->open_protocol(handle_partition,
-- 
2.52.0

