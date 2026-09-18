Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DE7C982D0
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 02:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D24F360BBA;
	Fri, 18 Sep 2026 02:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLcOmfQI-wy8; Fri, 18 Sep 2026 02:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2D59060BAB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789699715;
	b=d2YTfv7PYQKq9/mACMyTvZmrVfy+SlonMPlnH2rSzABNhPrm3vU9Gn0dKMUjnq1Ils7L
	 htmzoWYFJ7CLHyVTHIRslu6iN6QC2scgz0fEnW9q+V2vL/NSvz60h77RxZXZPECfaEPK/
	 H0kc8Dbla2zwASKyM1d0QqLnaCQYk/LfTu3k1iLsuTD8yi6ReB7UK8SuO2OPTOgBl1JmJ
	 FPBGsKsPEiWUi0bYmmga7qc3GhEsptfsZJGQIQ2lCDYzhJwM3FwhhMZLrS97murcmlsTr
	 V5233XZvPB92rFV1aQUMvVUDVDJUgiq8SUOHNkRHX1KKKBz2lx0Lcgk8twR2B6O48ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789699715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JtaBJ3c2ZBcV0TNn9Q/fqfrbV8NPeWDCLSCgyx7Mh18=;
	b=oe6Qenz08O+10gQs/jfd5fuiAW5N698d9R7GcrgTi8eGZ3eLp38d9WgN8Cov+8oTS9cv
	 wlVW5y3CjZPxroUgt51FiTHx2m8XtfqDLqS1wLT7m9awq/T+H0qejswbpipyBr0llgh9f
	 ucKAoc10JdaNxTfhVC7C8a2XOnCLkdTdFlp0VkSCqmd932dRmYWN6pPqteeP0YMEPc28e
	 ep1hfoCpV9IyISiiWebykW6WlJAvPQ7Br98IQ64F2vLp+e5PEPlWDwhfhRlOvbPZFPRBW
	 0qpWhpJ77VUjznBCHcjYoLKmx77gh8xtW56yiedUKoKUXvAVjBJUVWtfnXnPnZSlSig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789699715;
	bh=JtaBJ3c2ZBcV0TNn9Q/fqfrbV8NPeWDCLSCgyx7Mh18=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0Sx+FDFFVRtv/VEWXTu0kvHWAtD9NeXHZYtMtySwNXMZozzN8R7GOq2ZcUkvAqLZA
	 uiH1lHSDkvB9YF01pBqK8OMOqGREZsiQkcjYP1GckRoUKEsQLiFHYQhk+OyXryWupY
	 AB2TYv1/1zku3xOnVZnLJN0Xh0d1YIm+InAP7Cq8eHHnT6X8XL9txdYPqOVPRcszxt
	 NRwfvAM4gdz3YYOItEawsjteOVg+2F9erWt4ntNbI6bqIH25cZN+XMkt2Dn7StPIpq
	 UUj6XDJgV9+9obxM+LuFXbdPWmkhMPv83AOkI4DxcOHesiiY9H0ySQXeFrlzQIXIRz
	 gCBMjk+gxFpmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D59060BAB;
	Fri, 18 Sep 2026 02:48:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EAC33B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14D4480F22
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nc8aNtQdWTR9 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 02:48:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 64CB081094
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789699712;
 b=MUq9GBVJBzuJBYhKH19Ehw//BAPuTcoloOSk8SLsS6yp9ICnUbTUqKPx19XXKcX11hE6
 1ryfyOhUjvVBB36Qmgy81oj+aSh3xdjBZVQz3JEkyXWSVDpDrYwDqsGu98L2YB33iGofl
 Uy2fX/imEn7ol/v1CNAqk9EfY9caynLJD57CJ4I0p8X+FqtdSAvaSTHcJ+U3StBbzctOa
 fFKJr4B0oGk9N2kKVRUryqzMLNGWGUo7yxxye/7qufeQYfj33Y5fFddAchn2o+SGJmy0p
 MdY52kRHyFTdtAqPmChrPm8ictX/VELkQ2rv454OGT+/mm80BJpha/m8Feq3rJxfXoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789699712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=JtaBJ3c2ZBcV0TNn9Q/fqfrbV8NPeWDCLSCgyx7Mh18=;
 b=Y3UoR+L1RnvK9YbIf8XvsH2/m+0+tx4otkTBqFMvFO5Jx/GmsKmYxXaU6PmfpsCiS6vM
 +mZDOiT57b+xH9ewnkHRy3NxEhn3RZRBUOl4qbLTGD6TnLNgGKadcXnkdnV0+/tXGU0y0
 dk/dmfrzGarfi8iqPL/M/L7VqRK8KgejNJz00xzNpEo0R/Om4/0/O4eF9Kn/cGy2v4q3g
 92dvPkQjyRlmFKrH9fWsqZHxQtBS2D91FUDE9dAIirHd/1NIPySDLKpg+D6nMAf6II7F0
 gOAXRPcX7C0ku82UzRsniY/l88DxN8nKTDB3HHQ2Djuxlg9zmv+qE+IPqRdFMmpp/fA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z2YXBPfo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z2YXBPfo
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64CB081094
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:31 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91ede8035so2833445ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789699711; x=1790304511;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JtaBJ3c2ZBcV0TNn9Q/fqfrbV8NPeWDCLSCgyx7Mh18=;
 b=Z2YXBPforrOvRLDfRM9gNmfunT83NlN0RwdOvw7Wffr5FtUfozNqSUn0txTFiBVjib
 kxAtxlZ/TBche8nRM0Z+mLkQZMJv3RNZL0B73wGXaji+XS0RbzS6efPCMT+s8dAfvTzf
 PvlfW2H39qF1Gm6SCa4lpt8VLMPHlHSb/ZSS1gjOm/8yWI4QUEpEg8uDzish2V9JqinO
 ll5N4ltywhQ1/989GXyvU+V/AVI2eTMQTmTdhHYkakDY9z2NA5+26tnnfk5QGUy5ZWyz
 5a3YlAQWg1oFHAqjkZR/yTg5bNO/qFcn+6Vj9MSpkieZb/fUd/5DHoRJxreyt3OU1KtS
 x2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789699711; x=1790304511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JtaBJ3c2ZBcV0TNn9Q/fqfrbV8NPeWDCLSCgyx7Mh18=;
 b=XNZY93kgushrQubG0jIbVHGh+y1wNAUsWOjOP0mFYMlzkJLIcoYi/3u7odFN2IDBsT
 L/NZWcbfcXfXtmE4l/QTC3cZVRy6XgmR4kCaC/w6j/GwQEekvvqHupx60xRJYQ0XBapm
 GODc+vG9tBsDX9xwWob0AJBVZDQ5CtY8azuDVv4zzUjYi5MIVmHaWn1S043enIaksKFo
 Da9cPlLLoU9gWnfFvhFr4/3MLkktBYCxr47LNqvlU4keGFBhZv9st7YPDuI0CeIyUwbD
 DgRteOxGYnGPkMPoNskqyNth3uBbNkWcKVfIEydvaRWTYsTrHMWAOthSJMmRW35S8wCG
 JXJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwO0qXfM+Lq/IUc7otq5TDNDjmM3VLSi6BBuVIgO7VAH5ksdX0D941chnMp2MZZ/5Wu0GXJGQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kyY6qHJHCk8VIE7XzUc+ImFXGmaAVV140iPVHyismPytVvbHtb
 bt2Vgm1mxcVHvN43OdCxBKdVjJNjJE5cSDweHM8Ca6LRxh4Q32mc91qh
X-Gm-Gg: AYBFou155xF+zsB+Gih0E/ab3uPsMthFoVAOmOtGN1Wu4p+f0zcYvCCzM6SzA4zlmLP
 2vLuT6DhmSDdicZCn9SKV/ujEwc+JdHjzIsicgN9tLyNGMZX9cRTqIiolwyyEkyK6vvG9m1HPzz
 tD9I9PQODNtnfZFWSihk4EQ4gRWVVyLDEbYpo6kDEV07Ijl/4v0vutC5UGt61waUpqlwk0DBtqb
 naBMPj2sAWm0hbGWwlCVxs26gFKQ/r0jVSkx5/XOFh529l5qBXKO8N58asry2HHGz4lFdS3qujQ
 lrQbLPf4DK34kZAtvQCK2APtHpiekOpg6ZFTYo1Z1Pn3H2k1bCLzEr3NZrpdYgis12E68uR3S7R
 8hrq954qbjrgS1LV3ZJEwrZQI4J/cED9LoP9VP0z+CryXpM7KMcKre0KGjIc7EGEnf7TMa8Uj8d
 0ixZAT5J/JOwASH2xWzQ6VMINvSiDW2t1t1tFv3rE0/4/XFLLGQYMLTjFHsnrEucuwvrXD67z/U
 BfxPQxX
X-Received: by 2002:a17:90b:56c5:b0:39d:f247:bab with SMTP id
 98e67ed59e1d1-39e54b66f85mr2724389a91.6.1789699711056; 
 Thu, 17 Sep 2026 19:48:31 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287c8163sm308483eec.27.2026.09.17.19.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 19:48:30 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 vigneshr@ti.com, takahiro.kuwano@infineon.com, dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH 1/2] mtd: spi-nor-ids: add Winbond W25Q02RV
Date: Fri, 18 Sep 2026 10:48:00 +0800
Message-Id: <20260918024800.1838414-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

Add the 256MB W25Q02RV (JEDEC ID 0xef4022) to the SPI NOR ID table.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..3e7096bd419 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -633,6 +633,11 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("w25q02rv", 0xef4022, 0, 64 * 1024, 4096,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{
 		INFO("w25q01jvfim", 0xef7021, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-- 
2.34.1

