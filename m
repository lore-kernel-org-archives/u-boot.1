Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F8CC79F82
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A3B980D49;
	Wed,  9 Sep 2026 00:03:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pgd4zCdPGQlK; Wed,  9 Sep 2026 00:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3AF7E80D44
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912217;
	b=VGQob/+HIZx+FR4JmLSRSDQhilE7pceZcdfcrrCtTlACzlrSb28ay33SuxL8e1z1RWYH
	 0cAByzKb1iIrbUA/mdOySaoyHq0Wo15XDycH0+ARZbN+QuxprPfDSVONKS6kueftxBIck
	 tsfRAWtXp3+UwEwW3RIcuL15cKV1743oRRWReptGXxzbnS/DxJfnvBPueLzF41xyC1I4q
	 eaCaKcvEZGVou99Mut0XHSiIVBaHavOdU69xT2qCzPbBmWZoUkfpHGgIByFq2N2AECPXF
	 UqnybDDoqxHhnyyPeE5dB7wUxe5vmByEaLTejWQFW2kopFKJaH7SS/99RUFR5IERsSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uq6/PDaUnYpZDCnYjgaHJNelQbvBM5iL9p1e0sbG6m0=;
	b=NrYNXNRRhzkqKprNlF14YhZsJfpylXh7kW++Ki1elI+CYshW7n1dPcFmLNYbrVKeEhnM
	 Jw81+Xl3to4KEYwrgBXl6vOV08/scopMzqdwHpGdamF7L9J77LoZY6EP9qocO2xO17smS
	 SyjF/jeWrqchqox7IrRL6uN2ZFgN/j4PmJCo3JBN3a1sJHWPHxUzXhqf84tRjarf60tOk
	 kja9P+J/VaHuoBz8eumd2SPCUVpG+Z7NN1KtTsoJj7Bg/28vQbULwkj7Kyvwi0VRCKzuu
	 o4ZK9H7qpLa+dlY/VRaNqBxR6fqo8zlymHOVSnZyNtvyQnvbV7ylLvDsj14z7EvI6+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=efvN0IKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912217;
	bh=Uq6/PDaUnYpZDCnYjgaHJNelQbvBM5iL9p1e0sbG6m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7PWZpk9pjDvFogFErbJAQMv6fEQpOpcBiiygAd3TQ+t9QRPWxZHRDUtTObsiHoAc
	 VEKDkTc5Aha4JEDFXyrjSd6XOp6UohSrz2dRCh1cz/gfVkGaHSPBjddCOUpYdMZCWo
	 dNU5qwzDEp7nze2uPGhAzYbsEkZcozWjO0EZX4P7fpJvUJmS/F0ko9t63sAGo9UsPs
	 M8f5tKW9TdsRPtwix8XKEV1ZcU0MkPjtJJRk6uzn2y3XjIw3sJJ1llyUNpqhM6zFC1
	 /cXJYQGTVvcIcGXHuLs4GGAIa6kKc1Q1ABfI+YnTR14FH9GTP1IC64Jg6aolF4oKHv
	 oWwb1csqB/XuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AF7E80D44;
	Wed,  9 Sep 2026 00:03:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93BAF701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7882580D6E
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9q1PqHUUpKr for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E85B80D84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912212;
 b=PYS0pksv/B88cQPPyKfujOVlt56qx8AOgPNItgQncNQeAfF3aMZ5hFayFOgPlx3zq3a0
 Dql+7q7rM9VV8u5wLVBTHU2p3JZjX3CFq9C4/7kRFvpTdpxRJxWMA3S3gUa/oaGPkku+N
 SPgiqkTRA/JCa0HU0JEOeXdcSdlRNxXa9+olbecMHiNKiEd3O/S29pVVmo8I6ISssmuR/
 0gRpvA1N8S+VGLihc2Ge8Nzp++IhhOD4oiFenwlQBD6tSTltfFjOQsJnD6zWrHYH6J5DV
 qXwCkqJ2DphH89AaERzOxCAG/629Qm3QAaxL2NtQekfvUaCbmsoJsiMJNriwXlIBmBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912212;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Uq6/PDaUnYpZDCnYjgaHJNelQbvBM5iL9p1e0sbG6m0=;
 b=raKK5f2RAwz2VSpNTRsRqR8qcUceaYKhSedF0OqYnGmEhoZ9a6ihLLci/lDSQ2b5ucWa
 h7c3UPRXdItI75NiUmZAoZXWs2ULahcHWjpWhmV06yCTDRnwWh18Iz51LIgNOZa12l/8L
 rVAaPrpL/yvuTyskp1MWRVQDjcm0rGDYvMNLeWYaKxGjaRkveFaJ1IipU4qQmwQSQM8rM
 Np5bUgdBLO3mhL0hUnFdJFvYkSNRgbtVm0AOWhHr84A7lKkCnUgNOBsWNhXv4gYpjnPE6
 Sz1bNx9Vf1UOIBhJc5GAoyitynKCRuiOAt9jJflEif5IaUxDzHs6IChVFjpL7s9MDew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=efvN0IKZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=efvN0IKZ
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E85B80D84
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:32 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6b1afdf5196so1877649eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912211; x=1789517011;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uq6/PDaUnYpZDCnYjgaHJNelQbvBM5iL9p1e0sbG6m0=;
 b=efvN0IKZ5YY3cNI5Au0IEGg+wiJtd33iDVYrnoYR9YHt3JBE373CRqrwhOcXwmWxzo
 5B1tC3XoUWrOCi7i/oL7QFhuahY3nyvlfVbdqxTNPKTJTM5HA1zrnqHK1INftnlT0Rm8
 Wv+PQXcpHQcLMp3gfL6JD7yubyuJe1ZnTi7j/HceUVHLDqsfXLCQ6ch0/Opn6EB7PsXN
 e/JOt9iouJ0REpX4WnRMeU4kcmfPOLyCMle0J6QY4YvSV8Ia2fknWDzO2l6pfzMztLB7
 4OqnALyimIoUKPiHjxOKlQmLXEzWorTLkG8juqgrqi5FYC3jkv6q18qTN69gIrjPvh2o
 xdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912211; x=1789517011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uq6/PDaUnYpZDCnYjgaHJNelQbvBM5iL9p1e0sbG6m0=;
 b=X7LivRyCHy7QZG7dpImbVS6IlC5+A0doG/G7wqOTnIdzscxv/pHk9i1KdIMOew0wvi
 fJdBpZXTUvPCSingLq4Qbe+0CN35XXhEoLmHoxTJKYsViU3ZKD+S3YZuo8gFGxcBBb3B
 fFeESXdqvfAytciiVNe396xPMHNdSyGHEaM71ioZwlYtlodR5h6b4944vphvnPV/joXb
 lbcojudIacmPkAMIccylqqt4NmQSPt4w87fNvs6I4VijTpX2rOGYRZVPGHsm2nnngtqx
 uKVzRB6QeH9I6AZz6wl1DOuGT5UGxAMzLaOs0mU8cVjiHLj4CxYo8VQpmN/lMJJNMegX
 U7bg==
X-Gm-Message-State: AFuF++lH3sCIH3YY19AlCHyIUPgimrLi+F8jJTo1BCC68cBu7us5Nno8
 fX39AcuXwAecI0j/n6QCdaj7P9Vea3ZbujeRH8+suTEKaweoYygP/v/MH5Igkj1gv0k=
X-Gm-Gg: AYBFou3+4axKvwELku1eXqLYm5Ii87Mzv+VZkgI9VtLMZiD7zgaDeDO+9D045ldR5oo
 yCybTWCdRhpMKeSWXpbTEv64C3FhVhLSut+sC6NNlxqchn7I+5fWJAQjZmWqy8yQ6Y2a18PWCGU
 dGjpgVTMxp8ndbQ8D0JjX/WnmLvg1H937/h13E0saarN2lak9XIq1ObTHULTUx8NkH6VJ+ZtT5u
 KBPuEsrVCC8F76j10CSuq76F5xiPrCOzjRC0J2NsT5PZWjy6gp3GvjpT5vJB+6IHpFYatGIwvLv
 CzB9iQLl41qDhbrU+Q4Tcb+eiS7XBdDiJ6+RTRcT4FV+T4JbIQZWa0JZv4QgLKO2NS8DJ2Yt9FQ
 rp8Z0w56GaMe5Yx7vj4P/HZmRUQBKEqvBMHusH0pGFx4vIkUOBSZwN21iZ0kkVk6FgEJezAokKA
 BeMixz15SsKh5vEywKL0bLi1nl7YUzXXCfX+BxVLxE8JQyXE7Y9czYpJAbOJCOtelY+53FW0y7V
 yoJrg==
X-Received: by 2002:a05:6820:8187:b0:6b7:46e9:9701 with SMTP id
 006d021491bc7-6b746e9a2fbmr15991138eaf.49.1788912210967; 
 Tue, 08 Sep 2026 17:03:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Sep 2026 19:02:34 -0500
Subject: [PATCH 5/5] splash: add SCSI storage support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-splash-doc-and-scsi-v1-5-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5Sbm5n2/FRH3x8zIvfhXKGrVkWY0gvv+W+hR2XH16gc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKI5U6tBwAZzdp6XlvIZdVCzXia+PPjOddDBd
 LCdX9BD+sCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiORYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYgEH/2Ifn1CarMtvgkkViFwWDA9yeoq5ozTN4bjJJiv
 U5ct7j9VK6DoOMYHxOtJgBNTVTzoeTWvSG0YrdqpI5eGJZQgDDA0h5iFUbghxJQeZPhk/hRO3wq
 D4c7B25mJz09h8TWEnx0/U6Ol6dpwgrEGgDr7iue4FhL3MVAbALfkU652qYOdtkVyeeLsz/JkoP
 544BCb+ct697JJz5cePye8SwC6ZzulIIAa5OZYuBH2/1pLoOCR5h+eafej46muh83XCpAfkRioN
 oOGgGFyHqrjplGxoFg/Hy5g6eGDDTLtCpkamJR/Gjm/gm2wnJ3EMbv6SLsvtmzzPTzWClTMYN+X
 Pf6A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a SPLASH_STORAGE_SCSI location type that scans the SCSI bus and
loads the splash image from a file system on it, and add a matching
scsi_fs entry to default_splash_locations so that it is available
without any board code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/splash.c        |  6 ++++++
 common/splash_source.c | 17 +++++++++++++++++
 doc/develop/splash.rst |  1 +
 include/splash.h       |  1 +
 4 files changed, 25 insertions(+)

diff --git a/common/splash.c b/common/splash.c
index 8cc9e28ccdf..8a65ae59777 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -58,6 +58,12 @@ static struct splash_location default_splash_locations[] = {
 		.flags = SPLASH_STORAGE_FS,
 		.devpart = "0:1",
 	},
+	{
+		.name = "scsi_fs",
+		.storage = SPLASH_STORAGE_SCSI,
+		.flags = SPLASH_STORAGE_FS,
+		.devpart = "0:1",
+	},
 };
 
 #ifdef CONFIG_VIDEO_LOGO
diff --git a/common/splash_source.c b/common/splash_source.c
index 767e4a44f28..a41b7155b8d 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -15,6 +15,7 @@
 #include <log.h>
 #include <nand.h>
 #include <sata.h>
+#include <scsi.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <splash.h>
@@ -152,6 +153,9 @@ static int splash_select_fs_dev(struct splash_location *location)
 	case SPLASH_STORAGE_SATA:
 		res = fs_set_blk_dev("sata", location->devpart, FS_TYPE_ANY);
 		break;
+	case SPLASH_STORAGE_SCSI:
+		res = fs_set_blk_dev("scsi", location->devpart, FS_TYPE_ANY);
+		break;
 	case SPLASH_STORAGE_NAND:
 		if (location->ubivol != NULL)
 			res = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
@@ -205,6 +209,16 @@ static inline int splash_init_sata(void)
 }
 #endif
 
+static int splash_init_scsi(void)
+{
+	if (!IS_ENABLED(CONFIG_SCSI)) {
+		printf("Cannot load splash image: no SCSI support\n");
+		return -ENOSYS;
+	} else {
+		return scsi_scan(false);
+	}
+}
+
 static int splash_init_virtio(void)
 {
 	if (!IS_ENABLED(CONFIG_VIRTIO)) {
@@ -269,6 +283,9 @@ static int splash_load_fs(struct splash_location *location, ulong bmp_load_addr)
 	if (location->storage == SPLASH_STORAGE_SATA)
 		res = splash_init_sata();
 
+	if (location->storage == SPLASH_STORAGE_SCSI)
+		res = splash_init_scsi();
+
 	if (location->storage == SPLASH_STORAGE_VIRTIO)
 		res = splash_init_virtio();
 
diff --git a/doc/develop/splash.rst b/doc/develop/splash.rst
index fe58dbf4418..50d9531a256 100644
--- a/doc/develop/splash.rst
+++ b/doc/develop/splash.rst
@@ -92,6 +92,7 @@ mmc_fs   MMC          file system        ``0:1``
 mmc_raw  MMC          raw                ``0:1``
 usb_fs   USB          file system        ``0:1``
 sata_fs  SATA         file system        ``0:1``
+scsi_fs  SCSI         file system        ``0:1``
 ======== ============ ================== ===============
 
 A board that needs different locations, other storage backends (e.g. NAND,
diff --git a/include/splash.h b/include/splash.h
index 83c6fa9767f..7671bd7e9c4 100644
--- a/include/splash.h
+++ b/include/splash.h
@@ -32,6 +32,7 @@ enum splash_storage {
 	SPLASH_STORAGE_USB,
 	SPLASH_STORAGE_SATA,
 	SPLASH_STORAGE_VIRTIO,
+	SPLASH_STORAGE_SCSI,
 };
 
 enum splash_flags {

-- 
2.43.0

