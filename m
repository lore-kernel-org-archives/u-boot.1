Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294FAEEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBDE83CBD;
	Thu, 12 Feb 2026 21:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M08L6hzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8974683A47; Thu, 12 Feb 2026 21:45:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E31E83A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6JyvxxSpXUNmI9GDQelVfUGS2Vr6p4xYVoHBmqDRO4=;
 b=M08L6hzkFNXjuHlFimbMxmHgJwW5wxi0OcKZpqTKseSSk9XFw5Tbot1PyKxyME29M1aVE1
 fchnLEWeC5LA4dmQWJtGue65Jo+n5rzB9ajylqpEC+allPouIT8V0Ly+zmkCzilaHf6NIi
 oplVPru8tj3iihAGQjHlCZ6XgAql5/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-3zvVriYDN9SIyFSsJQjxiA-1; Thu, 12 Feb 2026 15:45:18 -0500
X-MC-Unique: 3zvVriYDN9SIyFSsJQjxiA-1
X-Mimecast-MFC-AGG-ID: 3zvVriYDN9SIyFSsJQjxiA_1770929117
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so7129125e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929116; x=1771533916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S6JyvxxSpXUNmI9GDQelVfUGS2Vr6p4xYVoHBmqDRO4=;
 b=Eod9LLiNScRhd3XlKNMJhjNGvozAyo99aF3LF7MIM7fs7iC9WzWCU/B+TgMcugoDcg
 DA1iC1Nx3VkhUSUF8HG810KXYxqbTcrX4IWnzo3nd09l75a2qC2Xw9pebk27ZOACsBv1
 giVAkrd2ParG4DdoUmgW92FkzT9WX0u757WKnVaqxd5HXtM3IKuYynXgPvwr5/p9gPNo
 jXjjayEXZKOJk6XhKSafh5fHO8xLGTQ8rsLsEZhHocu5IVOSKNXCLmMvbEKDBXXAgYE8
 zWiwVMBc64yiSrhahXpKr7D+blcr/pZDQPxCcgdLUX0iJyceesM6R2IZ6pYZuCXPGCk3
 a9Gg==
X-Gm-Message-State: AOJu0YwH1PlLeO0/XgF/mMf/g/lE+GyfpI/MjPf/0PU3rdeiXQpdJPUz
 G5WvCCtlS1vmGJTAKrzWTseKTrQsEEEHedmZQnkwG8wGDLwOvaPjF4sEWroRcMzuHT2S6hV9adg
 lut8JHG4ub1cFn6WsthFDVSaxrfDWsHM+s2aSe3N3Ps/zvEXJAO4YrVWmpsC1BCC42Xfv1uoa7V
 6VbJXF3tbhbY7LD12S1T5QE5E/yIEkJrQ/VGuxnQ==
X-Gm-Gg: AZuq6aJVehGB2WfhOpktCDZfE01vwUOJ0rY37hYZLG6DQXUquUml+5dwR/s9b6gjfj4
 KG75k31diC/zgMJpDUFeT7nOJYYydrnSUdvF58YDEK3d97+/qds8Bdz5h0xkaUEjLVBFONFaj0x
 RlkN5VXVE3eot3u8TpLtZhoOmZSILa9h+4wtWZOWZdP+/pQHvzOkMSLQ8PNFcbvRaz3qvLfwW7u
 E643TGOPAus9otHRC8RXdX98ujUAk3XZjaPokr0HUb8h5j1rsiwnixthskNIdC9utjHaPBrslUA
 KpmXNdXKuK66UJl+0lz+PkqXr6/nKXQw4l+IRD+cddiyhq20f5l32ZPjz4+C3784ldOgZGBHyvk
 aFomh5Kgd3S/2GvDNCUXh7sTBG6daTZqvbdrW9sDjlOEBsmk=
X-Received: by 2002:a05:600c:a14:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-48365fdec4amr61669725e9.4.1770929116626; 
 Thu, 12 Feb 2026 12:45:16 -0800 (PST)
X-Received: by 2002:a05:600c:a14:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-48365fdec4amr61669345e9.4.1770929116203; 
 Thu, 12 Feb 2026 12:45:16 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm466079f8f.28.2026.02.12.12.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:15 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 1/7] disk: part_dos: Move header to the main include
 directory
Date: Thu, 12 Feb 2026 21:44:55 +0100
Message-ID: <20260212204511.619392-2-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IPRNvMIm13yQ-FtMhxNzZkK7Dpa5P_eKViUiJ6XWg7c_1770929117
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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
2.53.0

