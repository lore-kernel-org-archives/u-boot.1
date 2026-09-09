Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C99C79FB9
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED5C4810FB;
	Wed,  9 Sep 2026 20:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPdwV0g8Vgab; Wed,  9 Sep 2026 20:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4791A810EE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986695;
	b=i77hnMO4/JiODOW373O6/zOycoHe3wVWUXp5IMAK1rMcLncaOlswvIRcer4a8aB2UBeI
	 dGD3h59DqiN5poxFu+uas1evJFAaxZE/fJG2Mg5Xnf01zQTmfSig7dysHmNR93JZt0G8t
	 KWYGRK1fuw37G/YH4lHoC+Zn+1MCo0oEAx7u0wAtrrtRj1fZsgRWevquuTNj2mpUN2jY3
	 75fwP0e5uXOceeklcqIcFBLHpdKO/FBR90pq59zxW03mRLKAKmGypAisTD88HHxMCkFlX
	 rSL19QxGpMIUM9rKanPx1wM/rnHaEw0qm7oYk2U21a/+ibqhXh3YKRg46J05wyk6FSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9ERykzlvc+8/0OqCyW2J9iJWCUI97ZWZ3hpQqvPugEg=;
	b=sUWIMpU+JurYGtfyeLK+X1cSYYHvfOUtew19s8u8rl9muFpnQDaZqqcrvkrEV5M0xGa0
	 X9NF3SMeGvLSyVNXZmofoMhnC6FzmuylacBYYdAI/wNA7osw3y7hRxnzDrydgfMdFj/ej
	 /VW0nLWVjpbqIEN1hAS5YwQ2r6jY2ujL9VLISVprienBHYILo1MH/AliDigT7qA+6+uOh
	 rkxzpa+eXoQ3eraLizWZa7E4SODn1K0YixB6hQ4ph0TI450i/A6NGEiqsceF9EjbeguCc
	 9K4xQU45fUMMbUYoeY76PzFHINrq7NKweSo3LL8lOQqa02u92d4jrfsnzeCsQ2SW/kg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986695;
	bh=9ERykzlvc+8/0OqCyW2J9iJWCUI97ZWZ3hpQqvPugEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtVcNWxIZYhK6jkeDXV0aZf2nQyICe+6nxAe3bxmh03O2sjQM/aw8a5qNQbDhMWpT
	 QkmqVYNAm0pjQJMyxVzbtTAywnqupwkJA0TSYekpjBPW+jmo8Y2TCVFnhlpUswD662
	 relk+FG7IhoPhldipF8+yTyhvcveFekNLGbNYUmKdcww/KsckwCG+NC6/ek6N2HPIb
	 H6v1AGIzJ+/ZPjbxIeuG/U+TtPemX2mhuhB40RCxrwO83lph/1hfbtdHJSR755AFkb
	 O2YGDqpAa90B8FBiEMdEe9xn8fmgsvV4rNfZdg5Hyu/4svSkZ+Csc6GULmS6vkjXAR
	 X0QoY3IJcxGBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4791A810EE;
	Wed,  9 Sep 2026 20:44:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 286403AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E78F60A4C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sn6peblw9JeV for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6013260847
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981631;
 b=Y77UJUNF49ReYfIBJ57bLyFZlL4jvb9n3VgiA4HRHV60CiJD+RwxOu8BiZkVC3KytuSF
 iuxZLREhk6Y3VJJapaU5+HN9enu5zck3XwqcRIwumeLErL/yIhaFwuspxuDIYMM50NVbQ
 aCgGI4SsAXEtN2KkQL3rOPDGvrcvRu+nX2o3HEuupXobs0qKjzeSiJ2Es5+52SgQVYtSU
 iK+d7BVNf69hRj8Mstk0PoMcNYl5GsrRAvbTH1etzlb3cWOG3uXHNJlzktxvIPXSSpovm
 VAAcFUvHhryqGJayjahxHs3sD5qA4plL9r9jIMykCIIZvOJV5nQyKypMm/esaK4iuig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981631;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=9ERykzlvc+8/0OqCyW2J9iJWCUI97ZWZ3hpQqvPugEg=;
 b=qtPxMEX5GwcynZiB+kIX0qrfz0Z2OsQQfHBKrGO3QPL2+CxLDlM4NMGGlZt1YmnrGCvB
 nDM2IFo0UxC3ehEjmYiQTHMtNa9iMkfwyQqQopI57ETVP9ZrtKT5wtCtqfypOOg3qExH6
 8TbsuinQTGYW8wUCrPalOgoQJzSTeO1bVCOqwg9YT7SlHKPZ8NAZsaf46ngIel4TzW1B8
 6Gz52OQdKWO6Yg06Cv7w0mHnKhmvjUaNutKCAkTs6HPuGGxoG2kn2tDI7hpZ/b3+Ju9sx
 gwRHxx51U4WXI5mBs70iSFqpLgsWBeyMhOwVA+2HNP/HnaMUZs9KxPIEWDAZts+y3TQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=gv5fPlhs; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=gv5fPlhs
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6013260847
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:30 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8D24F20B716A;
 Wed,  9 Sep 2026 12:19:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D24F20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981589;
 bh=9ERykzlvc+8/0OqCyW2J9iJWCUI97ZWZ3hpQqvPugEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gv5fPlhsZg3ADE4aLF3yxGni0PRXvLByMv4BRKejn47eNgMDBvjUo24ZEAtAuxJij
 +fDaDZ1HywBiPfQGtc9MDgH9YHuERtWvL0VEm8/lSOQ3XD9NxYHDCAQkiDuvuDj/tB
 HwWLgIoEkg38sQFqiv05n3JjMxiBNeqzQsppeD6s=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 2/4] boot: image-fit: add overflow guard for FIT decompression
 buffer
Date: Wed,  9 Sep 2026 12:20:14 -0700
Message-ID: <20260909192016.217183-3-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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

From: Drew Kluemke <ankluemk@microsoft.com>

Add an overflow check before the 'len * 20' multiplication used to
compute the maximum decompression buffer size. On platforms where len
exceeds ULONG_MAX / 20 the multiplication wraps to a small value,
leading malloc to allocate a tiny buffer while decompression writes the
full stream -- a heap buffer overflow.

Guard against this by returning -ENOEXEC when len exceeds the safe
threshold.

Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
 boot/image-fit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 26e9323da06..9770435f939 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2355,9 +2355,17 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	    !(image_type == IH_TYPE_KERNEL ||
 	      image_type == IH_TYPE_KERNEL_NOLOAD ||
 	      image_type == IH_TYPE_RAMDISK)) {
-		ulong max_decomp_len = len * 20;
+		ulong max_decomp_len;
 
 		log_debug("decompressing image\n");
+
+		if (len > ULONG_MAX / 20) {
+			printf("Error: %s image too large for decompression (0x%lx)\n",
+			       prop_name, len);
+			return -ENOEXEC;
+		}
+		max_decomp_len = len * 20;
+
 		if (load == data) {
 			loadbuf = aligned_alloc(8, max_decomp_len);
 			load = map_to_sysmem(loadbuf);
-- 
2.49.0

