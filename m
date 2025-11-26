Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05360D1118E
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F8B835B3;
	Wed, 26 Nov 2025 20:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ac6HgUwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9081B835C6; Wed, 26 Nov 2025 20:51:29 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5608352B
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78a6c7ac3caso1972797b3.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764186686; x=1764791486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EHszzabYegN8xNsWOAKZrT7Vbl4Qn18Ca46L4w9fXD4=;
 b=ac6HgUwdwCazrfQgIrx/AKqqyQT2AhKvL/xxuFvwFB4Qnh063kKk6W6B7CPZyJnJj1
 hGlkUrj8+yLBOfH7/97d1mhTYhiy2bBlVFtvs5j7izW49jiay07OZd1b0EkBdEQbud89
 EAbazH7N69H1WRkGOHXwnn2JfygccUUJ3r1zMCFk6IdozrsZmlYCQTD2I0kMY/v9F75q
 cp7P0cmK7W+ptHsouoqQrgjaoeQ8EJzouTrdCbonXQixcrb7aTkoy2I04WUCiR2UMmII
 GS6Xg8ks2o12/dQVblwxTTO7l4a62qoy4lfCwEZJPUqy0VI3YwXWZ8reoC9cisax9Xtp
 sY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764186686; x=1764791486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHszzabYegN8xNsWOAKZrT7Vbl4Qn18Ca46L4w9fXD4=;
 b=PmzhKDVm06yqSwNYy339WoZCa1LZa2AS2xz5pqd+yBgjxCgxqfeJPOeRJtREi+r+dD
 sXue84+giR97uLZp1LoGfv+/f/zZUMBZyfBTz2DdupOOizhF6vmZE7uHXNz7m391bu20
 N9FolBm+P1/Nq0z3yd0yUXxEqsg3L2WAGa5PjwHZiN/3UXIi8d7I8+vtKiQJc4B9xtRe
 9th5GCV1XB+sljMI0ZSQfxRBLLQBE6TJ0E73KPgiL4yrToFj0jaDrnv+SbLgJ811E4NN
 0dSy39j9pm8cnTbzycNv5VA8cz/+/q+3r1v4Wc1zc9K4/s99COpx7wPeJaF228PK5tCI
 mkkg==
X-Gm-Message-State: AOJu0YwJ+1v70p41E+XdrDdMIxfAvHaSzAS1OxfG4wDAzi3S2NYZd6pX
 z9pFKaA/IqJeyUuk9eRcq6N+nYulyW+3IbsNPwytQs4cosp49EABi43v+gz2
X-Gm-Gg: ASbGncsT51FVuhNsWxeg/Z+MKC8JQ+feTmb84sYhOS59tWHOJYu8kFOj5q5yVyapYHZ
 Q1gb8/vnECBQrkAJ23nUaN/nW1oUoxsYmOICRQ/idVrRyk1Z9bNTP7p61cNRHt/qiSmfLdmFdpx
 79tQEJkZrfY3R45D5lAt8MOodOwpNsaQWVxMlR6IDdJf2ECHKiC4hbz267fkRZyDGIOSEoPYv9e
 gTLlOAX/LDy0rBbnHGnog2XuDkffif2B4CqiqOMYNNbieuAnONhsY5He/oflCcyXSlCrDl7tIh0
 KyVbPsDTu7OcGR71e7n73U/6tKmbEFqEUvwcHL1FJQXjfvS8OoDLFBoF+fBfp9DWreugSHG/DnH
 2Q7s62cjY3/C7XXyai0ZGWY7ApafvX4ztaGxf6CKvwDW72MfUlyljLxdgwC/TBuTWlAo+uhn7uM
 ac2wxjtLSB6ImSJHD2CiX3le/AXY4iEcspkpdQ
X-Google-Smtp-Source: AGHT+IGTto5oZGK2BdLzHDZZd3stJueF0I7NTQnURUSSVMuQo7QPIbz8kGbG17JEyIyacKw2P+fGwg==
X-Received: by 2002:a05:690c:6707:b0:789:6c45:5df with SMTP id
 00721157ae682-78a8b472270mr172904847b3.23.1764186685970; 
 Wed, 26 Nov 2025 11:51:25 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78a7992511esm70227077b3.35.2025.11.26.11.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:51:25 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, adsp-linux@analog.com
Subject: [PATCH] board: adi: Fix missing semicolon in nfsroot
Date: Wed, 26 Nov 2025 14:50:31 -0500
Message-ID: <20251126195047.866-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The nfsroot constructed as part of the default Analog Devices boot
strategy is missing a semicolon between the server ip and the root path
itself. This adds the missing semicolon.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

 include/env/adi/adi_boot.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index d56b14f5172..7f0dfe15ff9 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -41,7 +41,7 @@ addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmas
 /* Boot modes are selectable and should be defined in the board env before including */
 #if defined(USE_NFS)
 // rootpath is set by CONFIG_ROOTPATH
-nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}${rootpath},tcp,nfsvers=3 ${adi_bootargs}
+nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfsvers=3 ${adi_bootargs}
 nfsboot=run init_ethernet;
 	tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
 	run nfsargs;
-- 
2.49.1

base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
branch: uboot-master
