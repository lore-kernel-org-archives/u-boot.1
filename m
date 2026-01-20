Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D9D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9391783AC5;
	Tue, 20 Jan 2026 14:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BEgPbjse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D512483AB8; Tue, 20 Jan 2026 14:36:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE75A83A91
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUZ9zKGiGazvekQYd0gK8/T6tGJkQJpqSV5e0fyFtkk=;
 b=BEgPbjset04vjSbmbTb0pkLdXetVesiK1sDWNdRWXxsNNcFBaZVARs9zIaAX4JkOSyaqUK
 Z45paX6EGj/HCXC3jR0QPUvRR9zsWZRHXVyAcy9Fr71PQwBUgRmzgMU861g0Ru1hBDiHyj
 vqkq+iJqrgEZVKGYsq/IXgGgXBrjqpc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-wCp8zhyvO5C1Qf-3nETNWQ-1; Tue, 20 Jan 2026 08:36:48 -0500
X-MC-Unique: wCp8zhyvO5C1Qf-3nETNWQ-1
X-Mimecast-MFC-AGG-ID: wCp8zhyvO5C1Qf-3nETNWQ_1768916207
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so4359315f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916207; x=1769521007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUZ9zKGiGazvekQYd0gK8/T6tGJkQJpqSV5e0fyFtkk=;
 b=kTeUgbcUw/Xs3klOfm6ARCviI4b2bgQ0K1jnC5yFdeIwpN6diGLoGNY1ncseqxoFBu
 Ca5oUakwH2OmQXDzeDhniitBId1AexezJLROX6CyHgRhA8AXxLpE7CfCzEdR8ABpOkzx
 GYuwn9UHiOhuleAuhe7oX5YFWj5Bxqo+Q8HtSRn1b0QKigyMcUmc/daAP4duwoHAoBrV
 lTqouDNcjBAtRsM/4cBw7ZhJdO7Is2kGakje/97bFUIbC+1/PfCuivEv1jCCzQ11Ld6d
 Latxpnh3segxpEvmXN6TaeWxlIXkqlpcVsRsqZI1DM+3/I66WSQARVAChuJ6LU7RS9i8
 A4dQ==
X-Gm-Message-State: AOJu0YxYZAp97Z0NendH5YUdvg7tSbq6aTvedqXqaO0vroYrjMFhDviM
 2dNIP7v0EOc08GG/HpzUECCkmX+QTY554nGZnq5b/RjOytrxd1TUdRnSuuOeNj1lVvkTDpxek1h
 wxVI6TpbR3Pv0xSw1/5RNCpqD1EPYrTQEEdqpZENUxvcbmA2s0iuKmL4fgq+FZ/6ktOpAo0lCkQ
 7Gi4XuDZNP59/+pZ9uTatS2vcHT7zHZ47xMarlVg==
X-Gm-Gg: AZuq6aI7CM85IrdYXEsVzDPCuu8db3q+wBSO403ye/6OGhjDA8/rZ04lY3dCUHQxUk8
 pELYTEfipyeR8MNMks2oTr2jB22VtFcQTR5M8K+TvF76reNZJnvI/jsTr51AeHr/lAn/GvO4Avt
 JKdJTXM6EjbS+Tp6oAnbzF/KJSVIB88XSbDFk76KHLR9oKYlJ10i0pxHrspRlVubcc95Xpjy726
 sPmNs5x1tRfyIaSezig+IXmKG0vMHmwE/BFwFLN0VAS3EbDpFkQ9EmNY179KBHJqzzW6D6FsS8C
 R7hCMguTGaFzDm908B26NEIsvGzEK7lCSYbwxOd6Q9hzll1Aj2LVWsjIaS35Xp+1m6sLbMhDoq+
 3uNPFyfMor5GIqr59mKKdTc9CFb3xCWZNExU=
X-Received: by 2002:a5d:5d87:0:b0:435:9336:21f3 with SMTP id
 ffacd0b85a97d-435933623b8mr2187681f8f.10.1768916206802; 
 Tue, 20 Jan 2026 05:36:46 -0800 (PST)
X-Received: by 2002:a5d:5d87:0:b0:435:9336:21f3 with SMTP id
 ffacd0b85a97d-435933623b8mr2187628f8f.10.1768916206216; 
 Tue, 20 Jan 2026 05:36:46 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595e0a705sm1290963f8f.14.2026.01.20.05.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:45 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] disk: part_dos: Move header to the main include directory
Date: Tue, 20 Jan 2026 14:36:10 +0100
Message-ID: <20260120133630.1695055-2-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120133630.1695055-1-javierm@redhat.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yhlwQxSfOO29LiIXwXAOIGV0NF4OmFqtme9q4cp8YbI_1768916207
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

There are two different struct definitions for MBR partition table
entries: one in part_dos.h and a nearly identical one in part_efi.h.

To enable future consolidation of these two structures, move part_dos.h
to the main include directory. This makes it accessible from other parts
of the codebase, such as part_efi.h, and is the first step toward removing
the redundant definition.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 disk/part_dos.c              | 2 +-
 {disk => include}/part_dos.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {disk => include}/part_dos.h (100%)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 18dd35c9b98e..2545cc6bf5d2 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -19,7 +19,7 @@
 #include <vsprintf.h>
 #include <asm/unaligned.h>
 #include <linux/compiler.h>
-#include "part_dos.h"
+#include <part_dos.h>
 #include <part.h>
 
 #define DOS_PART_DEFAULT_SECTOR 512
diff --git a/disk/part_dos.h b/include/part_dos.h
similarity index 100%
rename from disk/part_dos.h
rename to include/part_dos.h
-- 
2.52.0

