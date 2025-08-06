Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFF5C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7888431C;
	Wed,  6 Aug 2025 16:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZTcY4Vym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6637083AB9; Wed,  6 Aug 2025 16:56:59 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 486BF842F4
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6199f850ca7so1335001eaf.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492216; x=1755097016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7OJO4y+K99hO5v4llAit1FJSqdO8FBocOfWbgmp6R48=;
 b=ZTcY4Vymtuv8w+p/BLscXVJ93+i2VxtuCSME/vZ412FTraqC8HqKCNrYMdH9QTGu5c
 vCiF+xsnohlYk8g/S1baKBX/7v40pHrwDdVJ1ETlNrYV0BDkfeIO2FEqciyonzuS/pqF
 NtKNwmPPN+WLPlvHtSVkimwsFuu6D58Ga6Jeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492216; x=1755097016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OJO4y+K99hO5v4llAit1FJSqdO8FBocOfWbgmp6R48=;
 b=G+QT/Ygid4uVwIZkFzTxbyabwWVZPnVQvV+7SDL7JYKe3HBTnFr+J7WZYs7FVYLmm7
 CWrBrPU2F5i5aWttRetKQvLcnF0oCeBZooEafSP3iYV0/9WKb/vJoysQqN1cu1EtVpgn
 aygt2boF0V5I9WkFGJLq4H0qWwQHBhUlgj5xW6Kb6VJi3BlGQQHpsIVfiDW9s4qjWwGM
 LWL2vuFpi5assbXKY47ngkShpKV6tnXuseiIMHedKQjyop2dpi84GsQDNXi5Et8be4Ny
 +OiGcAqofQ8WuzhH7ajOzcZRtJ9li81OwZtamBxgfZln9RhzT5JiJnmPsDDTR1dVkll1
 7Uiw==
X-Gm-Message-State: AOJu0YzVEq+GkqIOc20Z/JFUCrejGg5KQnZba0lKWE5hcVvnk4a2GvgB
 OYNBY39PUgit60RSVeYQdRu/OPI9kJ55VCSmI8i6VpaTTF5tViLw2Sgu2ShJpKhwCo2suQe3eIa
 1/sTv+1o=
X-Gm-Gg: ASbGncuP89IJGP4H/v9xL2nUHKAwsZvE+Cay52DCFL28fTwy2x+5sc0I39EPmXHtjzB
 5ZaQ+lVL4glFdkx+atkTES6r7+ANRHGMxuxobzv3dMezwKDu8+d/E1yDJgOxzx+M2ubFYEOfqjN
 KiaR3lwIqP61qftV0qXuKwtVaw/cjabAJVtGYoc0mth4HsgHbmaMlgkXBcR007SUO4m3P5v/XAU
 MgCO+dVe6i2KmAjoQyjNEbk/OL8LL6fMmXyN3O9BtS6vgRTxjgEyQXxnm848r5dcB1M2xxXU+gl
 ytggLDNOSb3eSC+b8aa2o10StmsXQj3MNEAOrzzyroWCcFMWr+FmcET54Mx4X6cClaNMrjrE2Gr
 B+a4XOsrXaxg0IF82yXZ3hz4aN2+T/GTSD0oKHqkvySOgjIus+2se4VuzTHU=
X-Google-Smtp-Source: AGHT+IFnQz9qT/0MITtIVBP7cbFzIKE0QiGzvYWDUbv2XKVdln8jb2kOKtyZTRA6+VWPy8TPB91DHA==
X-Received: by 2002:a05:6820:184b:b0:619:a3cf:4d72 with SMTP id
 006d021491bc7-61b5f1f0a9bmr1987959eaf.1.1754492215944; 
 Wed, 06 Aug 2025 07:56:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 7/8] video: sharp-lq101r1sx01: Do not make use of 'z' for
 printing non-size_t
Date: Wed,  6 Aug 2025 08:56:48 -0600
Message-ID: <20250806145649.1664724-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145649.1664724-1-trini@konsulko.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
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

The debug macros in this driver make use of the z prefix when printing
regular, non-size_t variables and this results in a warning. Drop 'z'.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/sharp-lq101r1sx01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sharp-lq101r1sx01.c b/drivers/video/sharp-lq101r1sx01.c
index 4fdf0da8a94c..1c7cef777c30 100644
--- a/drivers/video/sharp-lq101r1sx01.c
+++ b/drivers/video/sharp-lq101r1sx01.c
@@ -40,14 +40,14 @@ static int sharp_lq101r1sx01_write(struct mipi_dsi_device *dsi,
 
 	ret = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
 	if (ret < 0) {
-		log_debug("%s: failed to write %02x to %04x: %zd\n",
+		log_debug("%s: failed to write %02x to %04x: %d\n",
 			  __func__, value, offset, ret);
 		return ret;
 	}
 
 	ret = mipi_dsi_dcs_nop(dsi);
 	if (ret < 0) {
-		log_debug("%s: failed to send DCS nop: %zd\n",
+		log_debug("%s: failed to send DCS nop: %d\n",
 			  __func__, ret);
 		return ret;
 	}
-- 
2.43.0

