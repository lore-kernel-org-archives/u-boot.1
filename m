Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A460606A32A
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XavnXPKD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKSnDRI9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC83840A59;
	Fri, 27 Nov 2026 10:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPA5bsEJmOl1; Fri, 27 Nov 2026 10:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 429F340A70
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775539;
	b=aOxTEbXdq+DjWPE6PlmQqJkFfdwzkJ/NvJATS3F4+PPne9qJOIrUF6sVOF+UVKHkkPs/
	 pYaWtT7TintpNa41pbJfqrCMYmQiJJKTH7A3xnzEgDaa4esxHPkYxzUIzz1E9dMt3Aqxd
	 MM8BlJlawrpJCfVeiz8DdddaXr2YlR38J6kfBioKWk4BBG3vgGjC/0ienzp2A1tXd93tN
	 SQY9upogo7hJP7yUr0kQYTekIDTb0UlzbmrQrRCjyCTp6tbE/k+rFhlqDqtWxPbqytkYl
	 KuuEMIpfuv+cKBQKCvHobbOGkkrm6BTl7gIFJnByZAvmOJ67126qzRycYqs+LdbUrxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3DddBBBVz965LRTPt7OWxBEVenZDPN1pqGbYzOmX/4E=;
	b=Hv3UshXWOj6aQWVOyUjsUfDCoMcZpin1eqwadA2f/mrmgHPMAWNZy+x/4iwSDwbIYnLV
	 0jdyWHjU0KMvMiMR8LnLNO8LdTkx/yOnoSUo8H6Hb1kK7w+OlCm0NZIw7xBqeZuBKmA5p
	 FiDssFok8n0LO3pU9KgJYpKfLVXYR287dYhVZh3mUXqhhsThAT6eki4c3Cn4r3gN9Wd94
	 rD+rPsqvpqj9AZ6+DaUxLRzzYs5BIBEmASjw9sOayDgcYduiFxNZ++7DZAKLb9dfhkUuE
	 w1qgtVEy1tHaPzNb1I2ojudZ+ELOJg/WSY/NeX3+nZENr09drYkNhdeHTsH11UgZtpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKSnDRI9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775539;
	bh=3DddBBBVz965LRTPt7OWxBEVenZDPN1pqGbYzOmX/4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XavnXPKD2+O6bJKKAtteaA8wuIbmXHIvA1ghAfivrnO2JsjKoHoU2QfZsmL/eJxxh
	 77raz8xwXXRHE/zj2vaz71DkcFvZyNn5t/QwvTYMBpo9hS3di3zcVIcmQ2qCjZyVbM
	 q1VyCgE5KIdeZex+elPgDuYjwwvTJXd/pn3WCmCyVmK4wYh0c75KftAfdIIrYzERMF
	 uX6D3qbN72wo3CYXIDze2TgUYdXoqQ7wXjQeT7aX/wwn8zvf89q4cr3Y03Oadlqyma
	 DuhBW3Bs2K4ACGtHYpQHfiM5dODmURB1Sey+ryM9wIiq0504uGnzGWox83mL/2tIr1
	 k9sKNGsg2xvLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 429F340A70;
	Fri, 27 Nov 2026 10:32:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 920C1D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A4040A70
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lFYU13hPPo3 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CAC7F40A59
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VKSnDRI9
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAC7F40A59
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:17 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-38190551625so15208470eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775537; x=1796380337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3DddBBBVz965LRTPt7OWxBEVenZDPN1pqGbYzOmX/4E=;
 b=VKSnDRI9ifSiH92LBPU6YRvK/66WMRt7WfeqQAEy527jaIrxOE+H8KZCnuw87IRD9x
 CqrqGxGKgofMqSuOnW5PYtNsfHI9ycXTpr4pq0QP4Zim2FkcfgeoXysnd6T2QgLV3SVd
 p2/B+k4BBy3bPHmjHgw6EV9g/2SJuD4/1kHpVsfyzxyHzPzde0O2uASf/Jkk3dFDzR8l
 kVPEJJMqIcfQqbLY1wppuRQQpNX13D4MvFf4evGj8iYYsvifbYRHdnpeQiKIYo5Ydv38
 DeksfaJbSDGVviBx9hrOidVLgWYlIgXs8RaMJGMYO7gAn4cfxywQcsRaBfGPDXJsaVYz
 vO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775537; x=1796380337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3DddBBBVz965LRTPt7OWxBEVenZDPN1pqGbYzOmX/4E=;
 b=YsSd/rMZENe2OHwqh1qmrNBW/qIMx39Wl+zZICFWZFehJbHwT8FcxEmOv5eQ2pO7ES
 1LHVjHg1ntWEJgjwqyxYM7DZO10eaPQ8ip3uOlp3d578NGORCUji58VNjYKR6rCdALSv
 4TcxO+9bx0fBLbG4Bnmauf3UhttQp1bVnx9ZK4MpWolMOkUL61RAZ1ZlaIIC9qG+W84A
 oNQ0C4CgKPJaRXmSRfuuwKK2/b5vFBcgX12/VXGsm9qlE2mCAkAWj/ZM4W/zY/wyyNFW
 Z0aoST3jDK9w4uEJSgEMMSYcuj5kAKWBqWJjq0AT2V59IHKqY6z2oOgSVPhqpL11Jm3+
 tMlQ==
X-Gm-Message-State: APuU4Z9b2x9w5q9Lt2SzRZNGD8D9bW6ZyW4oRXMewEN2TV/MofoKFnv+
 bUCufyNUIe2ypqVKE/OFiEx7q4d4nUB6kQ5ZPvceDgsAb8bLP4CPummUOeE1vg==
X-Gm-Gg: AZFdTZfKI7t7FI1ZACfGxNVJ6bfpw9/EnlcEq75dMXZtZzF1RwXb1mBtvXKQpejxQbA
 Bze4J5ByKI/nEExgd7AejcnhVJ/C3SvCiIeqCY/ned93uXwna3CD326NlibAd5ZUbVizpXVj62j
 PcCiJyfYC7zWmUsr6qr+Ihen1xK75p3iSNedFAwCumuiyHzPdxougK1N3Pou0vp3g9x8gT332yk
 yVyfBchZam/Pl3c8E3WFDKTaXX602XQ7Zmjx4mV/hOnipH0yncuaTvdT5G4xM6pPmbkgaExBNX+
 F0UrPd81SMFhajNiu32NR8hpfhK78tWwZAEy5hvtG07mM6UePOzTK/qC3hpES0rlujxGmH5jS9L
 mt0Ng5IEln5ZjZJy9JQ8PvPayiSEctc0ajZGoWghWO7X9N5XL26K9BpRUCfkEG6vvf05mYnfwJo
 tIhDvEMx+9LnA5hAxH7dX1YdLaNf33z6OFh2zK+rCn2MIY93iLB/kf3RZEEBtrHnDNUuM1aQVRQ
 o1p3/QoOczH8h5HJwCg5TikRbp9P966rb5vPLLtBUsA9ONOfZSq8koWyR5Z6TUoFH8mldhWu88a
 j3tDmSUSwSlwkgAoxgP6/MkC0FUkD2ErQqjG8AxuiR9PKN55og==
X-Received: by 2002:a05:7301:424a:b0:386:b132:6eaa with SMTP id
 5a478bee46e88-386b1327096mr14526887eec.16.1795775536475; 
 Fri, 27 Nov 2026 02:32:16 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:32:15 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH v3 11/13] riscv: spacemit: k1: Enable GPIO,
 pinctrl and MMC UHS support
Date: Fri, 27 Nov 2026 10:30:10 +0000
Message-ID: <20261127103030.4647-12-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the SpacemiT GPIO and pinctrl drivers in SPL to support
GPIO-based SD card detection and device tree-based pin
configuration during early boot.

Enable MMC UHS support in both SPL and U-Boot proper to allow
SD cards to operate in the supported UHS modes and select the
appropriate pinctrl state for 1.8V signaling.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/spacemit_k1_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index a6d0ba6153c..8e41384a3e1 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -122,3 +122,10 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_ONBOARD_HUB=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_SPACEMIT_GPIO=y
+CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
-- 
2.56.1

