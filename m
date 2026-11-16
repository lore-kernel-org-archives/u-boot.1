Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221A606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pjTsLUUI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIpjCK9o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6EA5404EE;
	Tue, 17 Nov 2026 04:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpusMipuD8Oa; Tue, 17 Nov 2026 04:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FE634043B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890088;
	b=TSpK+ZxQzVTsWtCmr/tfejRQGsPM3F0oafeHoRk5Fe0aaKIMgioJKDYigSEKQvnXr/ev
	 tFeuW3+eXqYDIQ7U+eRLKayv3HINPcWSH77HgXFI18iJT+MGggLOMIG9/Gzvi8fYLiGKB
	 iRCmQSOY40RKGBOh4UZBBpdRBftc0NZWxze7KdzV9QUaxmo0spwffQtG1EVHN2LdMCQF7
	 KkQEBIGS1Eau3PVjz3/93creanijuL9vcp4cpaXdJbM4tLnLMfbIONY7vzsedii848PbY
	 NT5UYkkq5xXxH4oX3pbBKx7nYfh0PZYs6CmQOjROqsZtyZxm8ACsh9JrLtdQcAlLJig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ws3DIDfSzFmWqpqp2oLpEGN8pGuE64qkZDPSnCxL/RY=;
	b=bH8uch2p3nkG/wQPLg8qD/atZ4Ey6a0PtcZoAmgOshRAHG5xapZqMqld/Ki+rAUv0fMU
	 vyjUREATKTiujM6i3niQPXnDoH+vz/2Neh2rY3jcYaoTKyMWBEiGu2Z52Jz+YUnAHfgYt
	 TVmrZ3q6Ji1VFWUzqT66QJ4V2OT1CNbAQnv45/bsZNjotfwVCbJPNjq8iUQVseAcrSaM/
	 R6JjEfRojSIQdWi60qQmN3KsjorQYluvkt6J02asPORtej1RtSxtvdxhTMpY/YixkAcsv
	 SbBGWWqhAmXOs1PPY7954Ym7KViXUgcOpaEdTbJVzPUmlDMlCoKNthil85jaKAaUXCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIpjCK9o;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890088;
	bh=ws3DIDfSzFmWqpqp2oLpEGN8pGuE64qkZDPSnCxL/RY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pjTsLUUIErr8tm0rlBU7cKJYw+hs0fHPv8mwK5/HGfswI7syszBFMQTqTgOo/qiww
	 wPpDBX1AfccR0Am+7ILAWJ7GZ81yKra9BPqSWcQmC/lTWJ0sogWC0NTgtkfZhI3+Oo
	 ROCXSU+HzATBubs+8XWsrK7aDbKqlHVyCOZq3FFlhN2ArhudvPqly3VVwm8jEJmHzR
	 1QscN6hJ6bmSqJarQIFBX65tZ0/RQ3xQQcynzyyJvrA/B8mEiIF92qj4OEgJiZbEVT
	 MR7iIuoMP2awnyTcgeHayox8ic7Fj7Oa9xDTkDfOrme5G3vn54ajInDUOTfR01lqbz
	 YbL6DxOSdZASQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FE634043B;
	Tue, 17 Nov 2026 04:34:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F12A49B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64D2C40742
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KTIfrG9CVcH for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A795740723
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NIpjCK9o
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A795740723
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:01:30 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b4c685c751so18156177b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794862889; x=1795467689;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ws3DIDfSzFmWqpqp2oLpEGN8pGuE64qkZDPSnCxL/RY=;
 b=NIpjCK9obkLgTTXfuQKXZ1fWvkISKecHXZJqp9ZC7i1Kesk+d082KPjiItJKu+L63z
 dyfDPqlEIF+7SiGHCt5gWJZco9wQrdhYqLuKqNI5WhCG1Tlw++c+0NCazI4wAh4m/VRn
 1x9PMqv9XAjl3KM6UnAhMVo3RqB+x5cj9O6x/1z2shPL62xw4T+1G5+c3Gjn2sMpfj/q
 8103E5HQJaxxj/s4udHnC/JRhOg7+YTH0Pz8NBvyhf+rhcvMPp3kPE5ZDoAMRMqGwcqj
 flYzjllz1sYGdqysALlOmlJrn1yfcARB8il+oLAgMbDIfWrkJo0zXrz2ivH97r1RQkIb
 skoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862889; x=1795467689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ws3DIDfSzFmWqpqp2oLpEGN8pGuE64qkZDPSnCxL/RY=;
 b=LzQefrMR2uMaEOZhUfmtk+fMwkxxAnXY0BVF4anWuoBrM1etmF774xYe4YOfDb0l1n
 JRG5+n+tKpIOzNkdpAwk0DePeFr/KydpN72RNBKdGqq6FVefJe4duiDgs2YE1rUIognN
 eLqkahn0/JrzSmY/PQvpf1sR/wIZuVzU9Y0x8wzxy3Za+5y9ly/dSbBygeK3zmAhpOMQ
 xnJrlekmceXTfSuT0yLEfYBeXq+Ub73kDYfeKJNoHHGTOtGXU7cJFNAVOM5ecLIXhZwt
 F28lepJg/+u4siQQMZ8NnedulaYjGtTeLaq/8IwrCXAzK9VE8lf36rjRdWg9c6vWn1bR
 TvRg==
X-Forwarded-Encrypted: i=1;
 AL+hErHlrjCOHAOqOsH7Xt+dX/8feCiKdbP5iBkvf0k+GWpG0FdgbLj/CdzPUSOZ/oYXRfgU4YPrl6o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+yK5WEA8DotmrzTNLczYJp3U7P3WzBo9OkSK3OJiJDVcn2PWch
 fekVSLq27TaUmlIUja2/uSB/B5h/Q8CS+DnbGK5wqWBV0a7nqH+YhAtg
X-Gm-Gg: AZFdTZd1bJ+FJeWAeixXYHjxbt6ssD1vN5ia8+rW/5XYsaVvyPIJvN0iaSW+B3GDdwu
 3pp+tqdkvGJBMWSaCGu2etOGtc391CBTyMAL9VHVPSeDbHq+GTusiCG91wlC/dzrwcnAE14KIyC
 MQnB/3tKUnOqqG87EKlpcKRJ2RRyhjQozd+f17Ha1QBHPljK0J/c/zKey44mMFqXLygM2irfvoO
 BAw1hWpOdgRLu4caTCKjEYXzTuVMcxOmZUQ/JGnmZCQOKRP16HWujmmmUMUEKiaoQxrX344oSHY
 ky92JqpKM3I21OL7FBxHq6OCPk48LeNjbxSrXBNat9G3SILw9WXudH7xqYhNMX3HWol9bnrG3j7
 z9iJ0n89zaR6GvRKjQt8s1n9K8HMn7PHy5Iqcfuv9b44OPZddn37Yu7ij/O4H58Gy7VBOPMclYN
 RW0ayRGrCDaZfdBTPG21yCwngGeznxBT9eeUc9+JchdPoD2PXnaBjp/gx1SFzF1BrzccDCz8O3M
 gPWn8wQHslFi375swq02Mznb+MVjdotCCP/tmMzpOW+CM5yX8NbtfIxJKqOT0C+NTJ68OJaCm05
 ZQR3/4jGUEmYL7OPOrWWE/AU+ElLUNBD0qX3BGsnRujXTGnFmmst9Syluj2v2GU9J3EfjOoRYPZ
 749iO77FoP70TySJa4Mr2GoPcgXDj
X-Received: by 2002:a05:690c:446:b0:8b3:adf8:c2d9 with SMTP id
 00721157ae682-8b4aa2cb4f7mr57022207b3.79.1794862888993; 
 Mon, 16 Nov 2026 13:01:28 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ebc1bbffsm8686087b3.10.2026.11.16.13.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:01:27 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH] fs/squashfs: fix out-of-bounds free() in symlink path
 resolution
Date: Mon, 16 Nov 2026 15:01:10 -0600
Message-ID: <20261116210110.15132-1-dilipchowdary21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
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

sqfs_clean_base_path() computes the first index to free as
count - updir - 1, where updir is the number of ".." components in an
attacker-controlled symlink target and count is the base path depth.
When a symlink escapes above its depth (updir >= count) the index is
negative and free(base[i]) is called on pointer-sized values read from
heap memory before the base_tokens[] array (CWE-590). The caller's
"if (bc < 0)" guard runs only after the frees.

Reject the escaping path and free only entries we own.

Reachable from sqfs_search_dir() when resolving a path through a symlink
on a crafted squashfs image (e.g. sqfsls host 0 /s/x with /s -> ../x).

Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
---
 fs/squashfs/sqfs.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 2092e3c1c71..a6e1e42ac2a 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -391,12 +391,23 @@ free_strc:
  */
 static int sqfs_clean_base_path(char **base, int count, int updir)
 {
-	int i;
+	int i, start = count - updir - 1;
 
-	for (i = count - updir - 1; i < count; i++)
+	/*
+	 * A symlink target with more ".." components than the base path has
+	 * levels would make 'start' negative and free() out-of-bounds entries
+	 * before base[]. Free everything we own and reject the path instead.
+	 */
+	if (start < 0) {
+		for (i = 0; i < count; i++)
+			free(base[i]);
+		return -1;
+	}
+
+	for (i = start; i < count; i++)
 		free(base[i]);
 
-	return count - updir - 1;
+	return start;
 }
 
 /*
-- 
2.53.0

