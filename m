Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81137C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310DA880E5;
	Wed, 27 Mar 2024 12:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="a7+IV5FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CF088065; Wed, 27 Mar 2024 09:11:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FAE88064
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VD+y7r7dM5xTeayVgiXbCheGbQvqvCEuZsaN2oem17s=;
 b=a7+IV5FMyczMkLgkcQ5veUF+edFKzp7ZLt+Cs4StFaA3LyBLgGQFQtasZAFaR1+gb8d+/z
 +nRewnJPEYjkY4/r0s+Q8EclX/OKoQtFtfNiaP8Xu9eTGL16eZrzcvnK0KM1HknMuTXO6t
 0oqwte1mXhHhPCYrVr1nPf7VGyX4LJc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-HQzHAER-PAib_o5XAx2FyA-1; Wed, 27 Mar 2024 04:11:26 -0400
X-MC-Unique: HQzHAER-PAib_o5XAx2FyA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1e0b3a4c2e4so28320055ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527085; x=1712131885;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VD+y7r7dM5xTeayVgiXbCheGbQvqvCEuZsaN2oem17s=;
 b=Lqf267A7opmt2fd34dGlr376CbpcRJxRU+KaVFIR/zlXmDkdDO8oFszJZbSsld0VrF
 ZjwczLQCxqQFgD2OaMIx60pdcVfIxs0jSm5EulSPUo/X+ZiT3qVoRfI1xcM3lK+pI08x
 1f3yk+i+RsbisPFS2NUn6gHNAD/KKlfmOoMJIjk98FUxbYvubBdj4YFMXOimNvw0z8w1
 GzKIPphgs7ifwElT1QhSmkReiR6xu2Qvgpg6GZlAmZGZMN2ddZr4hMBn4SC5IaDHAFyr
 N+B2DXrUAMPEt7mkhgTByn4A1HosD9caWmPXqcV/WPZVm4HYSzembmQpD1Xcn13cn5/I
 HXbA==
X-Gm-Message-State: AOJu0YznO2ObARXXDU8RU8TCfPK0El4jmIk7XK6+pkBIoahOtAiGeviE
 vNYTskEbZmnQtGB26VIMn4LZelDIV+aeQ0gb3BtZauF0yAiT+Cny341wQKVYvkw9L09OXkagFfU
 aEzjyzBbu0Rrp9Sd5xgK92pVuG+/7+V/1Lw4cXDZvf5QNvj0dIeCPqk2irF7j42tNHuz/W/w0Df
 /jQeqsH72IC8qshAL17zc1nxrqRTSdDnOrL6Y=
X-Received: by 2002:a17:903:2342:b0:1e0:e2c2:5703 with SMTP id
 c2-20020a170903234200b001e0e2c25703mr610077plh.0.1711527084899; 
 Wed, 27 Mar 2024 01:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/l+bZeawPsROKVtJ7LtcCTFHHPdj2JzBq+bx4NQGhyY1ZXfssNYVLxIZ0HYqx9Q7B0CTsmQ==
X-Received: by 2002:a17:903:2342:b0:1e0:e2c2:5703 with SMTP id
 c2-20020a170903234200b001e0e2c25703mr610024plh.0.1711527084153; 
 Wed, 27 Mar 2024 01:11:24 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:11:23 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 6/6] config/th1520_lpi4a.h: add more env option for booting
 linux
Date: Wed, 27 Mar 2024 16:07:27 +0800
Message-ID: <20240327080817.44501-7-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 include/configs/th1520_lpi4a.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/configs/th1520_lpi4a.h b/include/configs/th1520_lpi4a.h
index 87496a52c4..6c0c4bc50d 100644
--- a/include/configs/th1520_lpi4a.h
+++ b/include/configs/th1520_lpi4a.h
@@ -17,6 +17,18 @@
 /* Environment options */
 
 #define CFG_EXTRA_ENV_SETTINGS \
+	"kernel_addr_r=0x82000000\0" \
+	"kernel_comp_addr_r=0x88000000\0" \
+	"kernel_comp_size=0x4000000\0" \
+	"ramdisk_addr_r=0x8d300000\0" \
+	"fdt_addr_r=0x8e000000\0" \
+	"fdt_addr_fixed=0x20000000\0" \
+	"scriptaddr=0x8e400000\0" \
+	"scriptfile=uEnv_light_lpi4a.txt\0" \
+	"devtype=mmc\0" \
+	"devnum=0\0" \
+	"bootpart=2\0" \
+	"bootcmd=ext4load mmc ${devnum}:${bootpart} ${scriptaddr} ${scriptfile}; env import -t ${scriptaddr} ${filesize};boot\0" \
 	"PS1=[LPi4A]# \0"
 
 #endif /* __TH1520_LPI4A_H */
-- 
2.44.0

