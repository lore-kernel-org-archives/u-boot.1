Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41996C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FF284942;
	Mon,  6 Jul 2026 23:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XD4c3sUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B24801A9; Mon,  6 Jul 2026 23:55:19 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF3B849F6
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so2655750a91.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374915; x=1783979715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cEvdBYHA9uw+n5OIbXeS+yqS5JIwl1l8lBCMgcGNJs=;
 b=XD4c3sUmkG+wYgKkZ4cES17VsdaFk99dd5AA/XvsR/+Tlhq811JXFQoBA9pucaStjM
 2QoPMyIRasQQkp2CY4Jc989sVwdFP3sCzfNpDXQnYe1aGFAwDOxcnSekEfYWNfxHJbG0
 O6Use1XqUkfjaNW2G3GVSCYER9cUeKpCII61EMm5gzO8HElrrl34N02g9lZn9ckIOC8A
 SjX84657C561qHnEVvyH2Dz4Z/gx6qpo0ioXdg+ohAKaW1nDpau7FtzHwGN3uWX1mgvP
 HqwkcU80zfkXvnNEJobDfY2oMIK66Y0wkpW2XL0y9MtW+wZLMoTbbpGnySnuucxETXHx
 exzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374915; x=1783979715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cEvdBYHA9uw+n5OIbXeS+yqS5JIwl1l8lBCMgcGNJs=;
 b=OaHjKTn75raA0Tw9G5PV0eUXZwxl7BVYqmfeC7tiUQdHwZbLD9LDKTJuZ9AEQuGFSd
 uUb2dZm4h50Xbm11jj4bL8ZdsIG5RMZ5vs1VU/MtoBmAY2jGVCjX0YpjRCjNPKlxxsqz
 ZCk9L/Rv6D4PzkplsupzCwfpsPSpyjBHvt4vFlgq4tY/x8sak7HqyvWDb/uAojpALPGJ
 opEVnSoRpietp7TLo76brF2F+Zsu/5q+fDIU4VZQk3OhxT63B91nd3iU+jt8NWIYdPXj
 gG0glyWLxqzHBEBzwfqy6bskaSVlY45OkzJ5aRep2VHCN7esJxoEpl0lX3ynraIzA8MI
 nvXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCDIYwj05lJsjpG2WxMba7P4fJ41R1fLJKgHLoHVFTOeKDrEigsZpTDa15iNmM2T10UoeABfY=@lists.denx.de
X-Gm-Message-State: AOJu0YziiIbgO6y74e56xfs93Nj47zukdr36eTHwe5Uz/yihHup5PZbI
 KrjGZ8UXCfhUROBS2tI3SJYSk/cERaMuryhzzipARSgvl3bAA1VCNu3T
X-Gm-Gg: AfdE7cnlV6vbQzDjk9KGKytzMVbOnMvwZmnKrnQZp8AOL8G9metSTJ4lG9QhSsOj4hL
 79xGsZpy2RpRjtWHju33/iTeODoIlzPjnZHQnJtA2U50LpYv2e20ZMgdI7sxEQ2noSSYJvLq0SL
 QduFkVN9Wyz3ZqWVUkEFEfcVq4tI9I5S3LUFwOC4acrgkEWVcc2RocTZkhJyE09hAYIMBt73rLs
 SRNfTUelDoWlCY0/j1D0bNDZT05LPr5oLKurRIJw/V6gwwz8UCpUkg1XHBayo4TQCc8AIA2eyxv
 sCx9CfzkYqcEsT95VigScoHG1j4AGzLt1BpOu6sK7MArO8seA7hywMqKinR9mvrGE9yoYsz05D3
 15YKXsVM7RvEMBAKGLN8Aksxw7/pRvrQW2UWuzLsK/OhVvzYkWLeWqd06BGDixMMaXIXElzBpBB
 cfm+pxlaKeQyzyr9E81phgdkxIQUg8icCCcvWC+NfXDYnecFPh7sEwRstWeYlbgYEn1XHWOeeT1
 NuNXIHovu17
X-Received: by 2002:a17:90b:2d44:b0:380:9157:d5f with SMTP id
 98e67ed59e1d1-38755191544mr2418846a91.1.1783374915278; 
 Mon, 06 Jul 2026 14:55:15 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d64sm650864eec.17.2026.07.06.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:55:14 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for 9PFS
Date: Mon,  6 Jul 2026 21:54:46 +0000
Message-ID: <20260706215446.4068820-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706215446.4068820-1-visitorckw@gmail.com>
References: <20260706215446.4068820-1-visitorckw@gmail.com>
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

Add maintainer entry for the newly introduced 9P filesystem
subsystem, including the protocol core, vfs integration, and
virtio transport driver.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4eb2c13a43..2deb6b37420 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,6 +50,14 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
+9PFS
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_9p.c
+F:	fs/9p/
+F:	include/9p.h
+F:	net/9p/
+
 ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

