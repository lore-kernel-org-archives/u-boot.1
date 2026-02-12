Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1041EEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA0B83DE0;
	Thu, 12 Feb 2026 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="J5tYWIoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C528883D5D; Thu, 12 Feb 2026 21:45:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9CE83CB5
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPjEhwKqFdW3U76c2HevInzAo01+HnpgzrClJb7Nnk8=;
 b=J5tYWIoSAac7QMkkaFeTCGrdNfmD9F4jyvLt/zobEIB3yEXpem+8uuAz/TdKtMn7VZKd+4
 3IgdjJaClD8H0PRWv1BnLurHWAu9Nep/Hn6J0U+25AAKbmFMOYR0l9H0hhsqjEJaAylLI5
 D1XXpQRiUSwIjg1TK+DI9lLjvyw6fLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-0AO64U2fMIulHGSIT6_11Q-1; Thu, 12 Feb 2026 15:45:25 -0500
X-MC-Unique: 0AO64U2fMIulHGSIT6_11Q-1
X-Mimecast-MFC-AGG-ID: 0AO64U2fMIulHGSIT6_11Q_1770929124
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so2095595e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929123; x=1771533923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPjEhwKqFdW3U76c2HevInzAo01+HnpgzrClJb7Nnk8=;
 b=Mlmn2bM8QhrsLtdfnQXe4S4+JGGSgjMrUu4KMtfyk1zuU2V8Y0O0hZgnzFRlQX7vup
 Fv+Pylodj2C26N5G4kxvbaCu+WAjVGlu/vqjFongMlrBkSFeAok8s3R3DyoR6chPlURe
 /mzYAZBS+LHnr4j7SRlRmzttKUIYGevvlQCU9W1XYh9QkoR0aiBPxryo+ZEV0zDwVaKz
 k2kA8CKF/LTXLgdysC1Irapyptqg3OdeUQebLIXRk9h9MVbUHMs7CYIpI9PVy4AYs9I7
 Kym7uuBhHlD61zD9EHM1yzUP0HdG+2sTPyMauPrTgrP36f0HshUttLnpRRjUlaatmblE
 /kYQ==
X-Gm-Message-State: AOJu0YzXkSYpQgltNZ8LEtb86aWlBgn8aucDevLURqMwu09K6XCzfnsK
 //LbGoqrp2VfSx1wuXt2OsV3Y3X7ABh2R4jPCR4IFokp0Tpiod3uRFVOalSYx9Yro5JmO7G7/G8
 cULQZY1vawD0lRM6cKyd2pxI2wnjdKCu0eHXK5ggwqwtNYm8Uy/Wctilt4xWWQfygsNvYxoQohy
 K9V86zXlM9UOGm3wC3XTBMWZ4RqJE7fpbwd9yJdQ==
X-Gm-Gg: AZuq6aKfWA5QCLcyJi8y+zQ9cPXwrhzFGEcVA2q9MMfocDH3bK8rH0oMCdh0VVvMaSH
 ditGUn73/JrE0K5qiz33ZAOc/wlrl/puVwvk/BTLEF2apkQuE+E77GYmTqfNlfw1ewVDDbzTKwB
 EL5aPj5MIZfdlqSGFCqCTUAfKDwUW5C3kiyX6ffECRcXrxPadjP5FdXMH5yYAXGYpA+yda9hmK2
 EqvQvQ7aSY8SkCTOgm3o4XhQyEeq08uhhuCax17ufxJEH6/A4+P9m3nsHFLwz3lzOqomJL750Bz
 0KfX5waeWcVRte4gqqHqdQX+B+jlk6tV7Cl3rwEmzWL0k+iC9ZTVwol8JWQy2tFJU9adocRRicN
 WOj6oDjoDGCtdAGe/w3510tfA7bnlnRTorIHUxVgIKzBZTxc=
X-Received: by 2002:a05:600c:3591:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-4837105571fmr7012255e9.36.1770929123396; 
 Thu, 12 Feb 2026 12:45:23 -0800 (PST)
X-Received: by 2002:a05:600c:3591:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-4837105571fmr7011845e9.36.1770929122948; 
 Thu, 12 Feb 2026 12:45:22 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836ff00332sm17387105e9.2.2026.02.12.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:22 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 4/7] disk: part_dos: Document part_get_info_extended()
 helper function
Date: Thu, 12 Feb 2026 21:44:58 +0100
Message-ID: <20260212204511.619392-5-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dyj6ufKcNBtp6Udp_DaMo04rNsitDldaoJP5Fednswk_1770929124
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

The function receives many parameters but these are not documented.
Add a description for these to make it easier to follow what it does.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 disk/part_dos.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 60c3d6773696..a69ad8962106 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -196,7 +196,18 @@ static void print_partition_extended(struct blk_desc *desc,
 	return;
 }
 
-/*  Print a partition that is relative to its Extended partition table
+/**
+ * part_get_info_extended() - get partition info for a DOS partition
+ *
+ * @desc:		Block device descriptor
+ * @ext_part_sector:	Partition table sector
+ * @relative:		Relative offset for the partition
+ * @part_num:		Current partition number
+ * @which_part:		Target partition number
+ * @info:		Returns a pointer to the partition info
+ * @disksig:		Disk signature
+ *
+ * Return:		0 on success, negative on error
  */
 static int part_get_info_extended(struct blk_desc *desc,
 				  lbaint_t ext_part_sector, lbaint_t relative,
-- 
2.53.0

