Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC458606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dxL2Rxbr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JOQXJbvu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 985CA606D9;
	Fri, 23 Oct 2026 04:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cw85DHpifOZ8; Fri, 23 Oct 2026 04:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC62C608AB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731578;
	b=nlvL10gQvdMtvz6x0XJjGEbZ8wz75yh7e4duutaOoGK7CiBMokAGIXWpjE2NH9L64bu6
	 Q64kGszOxVY4lSoxm//dPlhifGGxX9HIJlKfn4VEGMQxcvG7fdSaE/8GP9Xi1nF9yDLoN
	 qbgcf+w3K/aPdJS4KDhBtHtjGTpL+qoNbYhyZZfVTis9rPNfV3F42F2KxREgg79YGEeRY
	 dknYsqH6yRQ4O3pt4muAhayDsKRImxCngvSCKBOXT3rOC4n1sNl2ecYf3QxdGf4zCZNXk
	 yeEV3gnn4ECdIaznDE5JvV1bbzYFWuUkK8/kOT9G6YdmGBwKNpc9NAjoQytVJy5VP8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GOeyMDStp6o/79pl2zPgPmlCqhMlff0C0eCQHDOZHno=;
	b=e0F7yW15RsBD6UejU3k7pOOCoVLLdBWZsM/m7fvMaLx0M8SoZLv9KGjDxY0yGBWUmJzu
	 smPf92uf6dMgPOHaXucDjwmWPyoZnWGyY+Dx2qhwS4AE9gHoZXi/Rwwr0UKEGz1HGuw7X
	 k3N2u+zaDbi7p4jJPkEthE662zpfgGtZ9c79tf5bJMGOaLQ2wYDQtkYeYZzhJMmSaKWom
	 XhI7HvznCyXex/Rgz+ITH3jPa/W/AC7Zc5JaPDYxT6KYd/7OkNWM0pfRmqQE6NnSas3eT
	 m47X1vfsXMUdyFz39TIPQlOuppeTMHNaeltS/W16ZDo39c7bzLyyYGfaR6hFltuhNJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731577;
	bh=GOeyMDStp6o/79pl2zPgPmlCqhMlff0C0eCQHDOZHno=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dxL2RxbraGoiSpOtXWnYxqBVgqqFtlsTJyB5nIar/typo6sTjyFwWkcOGGW8me2qu
	 MsvTee3qW36b+9wfOmduIZ3pmRq2j4k+/02X46JxT3joAQ0dNTcXLMbIaXVxcoP0gH
	 YQiwJjhnkw03r6Kb9z4aRWR5E/k8Bir5UPX5fLmgAVx5raVehvP7yOoJHSULcaK2vi
	 XehXNpF156pYFFGnJirRDvwdDDpfXFGZ8dl/JoKSKqnBAbl9FtGLbtZqgojRuyV01t
	 3tg47Qfw6yefx6fOZ14m5/8MlxOYwf2Er+s6mF978hsNLL4c344KcLn85T9U7HdUbK
	 wAyE80HomksuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC62C608AB;
	Fri, 23 Oct 2026 04:59:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AA6049D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B8D140580
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFaDe38BTSyV for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 03:04:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A847640575
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792724643;
 b=SDCEsQX8sG/jSvGvKiqfjbhO9HfJMLG9QFe94pgrMrBXHilgWORUJN+TrVhtmtr0C8qK
 g35Ape4xtqqoIGK2xvSFo+fHt5Rxakn/B+zEs8TfFz3C2jhbhX35WuDCZXE5iDuHmCXKI
 YvcFkmJcLm2KniCL+7gMaNXyq9oHgL6RvYBQ18MfFFp7awdwwys07VSNJP38RMQrX1HTx
 QqfdNOfoDSHBHBdkElZhfLO/OBxmUfmd4nlDQdhVeoTQ0XlrsXTy2G6rLthI6Todpd+ha
 z9IlcOfHdzbIEl8WdebjyjZVguslcvjZwhq2AVgHQXFrmSkXSuQKKFAB3eFedrXBsWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792724643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=GOeyMDStp6o/79pl2zPgPmlCqhMlff0C0eCQHDOZHno=;
 b=cKTrrbCjx+78vMtQSf18JLb2N9DpHcimx1PyiDFW7aP/Z0lelQyuCEoKup9iGTAI3l93
 dbbqQp+HXqwx79N70qxOa/nNBjSpOeZY1zOhL+XzzvPj/BNjbISnf9pg7IAiksfjDbxUO
 cx+gtYjCKZLUUk7+jJsZhZmEGOdP+S5S3rXqAi/n0v7FqOo3d9/2w4UgJcWh4Jzg2EkdR
 czzFIjMaqIU/haS6lNzyFPjppTcKxDQDRbiy1PwutN4hTrt+gHRZpqu2DU8vJLF8aOlIP
 b0RAARM7F39MsrvD8zWM6UZmeeVeBvC5NwxrQHGnMdl8f27Qusp5Zmb6vP/UMSWNS1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JOQXJbvu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JOQXJbvu
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A847640575
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:04:03 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91c1f548f87so7304986d6.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792724642; x=1793329442;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOeyMDStp6o/79pl2zPgPmlCqhMlff0C0eCQHDOZHno=;
 b=JOQXJbvuL9WPaWfQmwsDESdLY60BNz6/WNcSxqJwzj6KTMXf33Kc7bOM5rx2lRC4Tw
 VIbaZBdSNCjZ1C/OtCaEBGxmZI1VImEtLeOt5CDKVv4NLfUcwKfiOABFa0cyj/0n9+EJ
 7MTry/6HHxPoc7tUuk0DUr2diiT3BW+OBYHn5fjfY4OfSjcrqJKcEw5BOhLgNoC+D/oF
 Vs7u0ASXYTLhDaRLfsxzI9U8ErKXwKv9JGZSV/TwJirEUwg+P7kTm23GdqM1cxPqE155
 X+yaZ42J/X8Raw/auyL1J81cZ0ePEeh1Cn0ojEzRuwHY83yisEeVqY2ULIkHMyT6ndgN
 BoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792724642; x=1793329442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOeyMDStp6o/79pl2zPgPmlCqhMlff0C0eCQHDOZHno=;
 b=M90R0Q+S0g6Q8XzRnPlMMZGf39qJ0vE4s/i30As7I5/DGXsslr60nuJUjXqz6IGOB/
 x2LNSaR0Qp5nmziLIihpjRfwZ5A3rDkSQxSX7+zCnFmUvmwl0mS7hVFTReTFymfd7ZJp
 WAGQTIuLQ0jfs/rwtyqRXpFN9VVQ00/Kg5cX5mH99wKkOEpHNtsiev+VFvIHu8M9jejU
 zT+bg+s8+1h+tHrDmBovIBQ23nMIz14yGt7iXEZmGJ8cv+OdslBBYd1OARrd/KN+t/oY
 AVH7BriMGXhBLL6TDWtMLGM34XVKQy51NhO6hheEW0scB7l5P53HopF5OkN9TokzUEy6
 S6FA==
X-Forwarded-Encrypted: i=1;
 AKwUvByF7zNdwESu/8gXvAgmUkfBuOI4s7fN+ebXhnFzCox8N+TPk2H5r2HfDLt3t1XkGStMRTv2lbA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLmD7hQEQg2yUFMVe/crXV8y2eN/xZHP7KDs7k+G7hPbkmgu8Ro
 iKudS6VoK/FfYakFoj/afZtRVnlqtQwDuUNjTc30H4D6YvEEB4cOdPVY
X-Gm-Gg: AYBFou0E4uYh5625nsiPBpYQwLW7jTAZtonb00cKNqYDnOV6MMQATb5wVIWHAtgxOfu
 yu3GgCQvy757NdS4WyQR9nB17ARVcilLsfkcamgo1g3TFXSl9fqkt7bNJH7K5nacSUkcJOKk2OL
 qn11/YOLeiPR11Ih+XDKFBsyhqVYluHLibNzV0+H/n242H+AMt4y/JFgE+6ENPeo0fYJn1N2R8P
 3kJbZOw4eTy5pqJZQDXCWfMfLRQxdoQ3WRYECrxKsXqILbw7OZHeiQlPpiDJZr+Hp4iWzrc+vmX
 LyUpC62wYg8kDwfsFP74vAyLvoMGvRH7JlaucKPP7+hj3pTS6v7Cz7Nwsn7lYcg8/JaZPk4iKpl
 iPCboG1LUIZsZdVuywWXpYE8rKivxd8J2Ye9edDbBRasHRD2Kkiulny3ZNeAmMcFbOGXuACoSqU
 8X8fXRMX6Kcx42YjMWV8u2DTMKUze3Kb7TD/x8TcvBLz1Lt/3viM31bxszLvsuuXEEhjU6CFPV8
 AKv1I+1sGriR0UXcgzGGASi6gmMgIM0miBSv4Y8G9qEj6plIPXDxOmEcUCMUzqajk2lMNmHhkCP
 Skg=
X-Received: by 2002:a05:620a:410b:b0:939:de48:e41f with SMTP id
 af79cd13be357-93f6f949024mr222255985a.31.1792724641740; 
 Thu, 22 Oct 2026 20:04:01 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f70e81a80sm77963085a.1.2026.10.22.20.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 20:04:00 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] board: nxp: fix memory leak and check calloc in ft_board_setup
Date: Thu, 22 Oct 2026 23:02:39 -0400
Message-ID: <20261023030353.153360-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In ft_board_setup() for NXP Layerscape platforms (LS1088A, LS2080A,
and LX2160A), base and size arrays are allocated via calloc() to pass
DRAM bank parameters to fdt_fixup_memory_banks().

On LS2080A and LX2160A, the return values of calloc() are not checked
for NULL, which can cause a NULL pointer dereference if allocation fails.
Furthermore, on all three platforms, base and size are never freed after
fdt_fixup_memory_banks() only consumes these arrays during the call and
does not retain them. However, neither array is freed after the call,
leaking memory regardless of whether the FDT update succeeds.

Fix these issues by validating the calloc() return values where missing
and freeing both base and size after fdt_fixup_memory_banks().

Fixes: cf0bbbd1ee7b ("drivers: net: mc: Report extra memory to Linux")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 board/nxp/ls1088a/ls1088a.c       |  3 +++
 board/nxp/ls2080ardb/ls2080ardb.c | 11 +++++++++++
 board/nxp/lx2160a/lx2160a.c       | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/board/nxp/ls1088a/ls1088a.c b/board/nxp/ls1088a/ls1088a.c
index 8ea76fe3760..29598cd487b 100644
--- a/board/nxp/ls1088a/ls1088a.c
+++ b/board/nxp/ls1088a/ls1088a.c
@@ -986,6 +986,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_memory_banks(blob, base, size, total_memory_banks);
 
+	free(base);
+	free(size);
+
 	fdt_fsl_mc_fixup_iommu_map_entry(blob);
 
 	fsl_fdt_fixup_flash(blob);
diff --git a/board/nxp/ls2080ardb/ls2080ardb.c b/board/nxp/ls2080ardb/ls2080ardb.c
index 9dec818280b..d9f23b72fa0 100644
--- a/board/nxp/ls2080ardb/ls2080ardb.c
+++ b/board/nxp/ls2080ardb/ls2080ardb.c
@@ -484,7 +484,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	total_memory_banks = CONFIG_NR_DRAM_BANKS + mc_memory_bank;
 
 	base = calloc(total_memory_banks, sizeof(u64));
+	if (!base)
+		return -ENOMEM;
+
 	size = calloc(total_memory_banks, sizeof(u64));
+	if (!size) {
+		free(base);
+		return -ENOMEM;
+	}
 
 	/* fixup DT for the two GPP DDR banks */
 	base[0] = gd->dram[0].start;
@@ -514,6 +521,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_memory_banks(blob, base, size, total_memory_banks);
 
+	free(base);
+	free(size);
+
 	fdt_fsl_mc_fixup_iommu_map_entry(blob);
 
 	fsl_fdt_fixup_dr_usb(blob, bd);
diff --git a/board/nxp/lx2160a/lx2160a.c b/board/nxp/lx2160a/lx2160a.c
index 10729dfaf24..330d720e9bc 100644
--- a/board/nxp/lx2160a/lx2160a.c
+++ b/board/nxp/lx2160a/lx2160a.c
@@ -804,7 +804,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	total_memory_banks = CONFIG_NR_DRAM_BANKS + mc_memory_bank;
 
 	base = calloc(total_memory_banks, sizeof(u64));
+	if (!base)
+		return -ENOMEM;
+
 	size = calloc(total_memory_banks, sizeof(u64));
+	if (!size) {
+		free(base);
+		return -ENOMEM;
+	}
 
 	/* fixup DT for the three GPP DDR banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
@@ -837,6 +844,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_memory_banks(blob, base, size, total_memory_banks);
 
+	free(base);
+	free(size);
+
 #ifdef CONFIG_USB_HOST
 	fsl_fdt_fixup_dr_usb(blob, bd);
 #endif
-- 
2.43.0
