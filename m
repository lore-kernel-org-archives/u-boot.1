Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08281606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DWs7oCa/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqqHVWKk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9DEF81083;
	Tue, 17 Nov 2026 04:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UadzrQv2AY9C; Tue, 17 Nov 2026 04:34:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 251E781091
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890097;
	b=X0TwErf68SD2uReEb0s4qYFDZwYJ1JFM6fnCdAkxposa+dRQUTp97zWCo1TBqOBtN66C
	 4e40S6pfOIYa4uq4hoYjQjon91Z8zlMNaIVqiPkyHG2EiioBOQN+XibU/s6n6cD0SFnGl
	 AFnEPRLxxbI+AEGbooqDX4hfkDrWKB/TENM9Usoe9lQ+nje0/LsULSaGVpELH8qoIAJvo
	 Ot+s1az0NfmwQZ6+up0Jve+ZDCP1Z7GKnj+d/ORTECwobnbaMA5jNfi+HFom+knhFuBRK
	 Xc0uT/AOdjnfYgohN9F6rglLe1oNewFDBLn8kRvrbu80O2ER1AyrJG5DH2qeorHmLgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/sAsQBV5/p4Oq7HNtAwLQuvrN4es80oVcXGtlYTm4UA=;
	b=FSmTc+YacwxYA5zYr5kZv1vQ6SOVSyfsTdUsLf+wtr6TD8yCqHlGAzkkAWkOQENyRegv
	 2QbhjoqvPdl/sWRz6BEaFr6Su+h7cDc8DrCLkQRLIgT8tEE7gBRNqmg/rcCE3gp3pyZ2F
	 0hUCpAZ2UQHgaNQCf1tdES0V1kc8Cjz4duCnjv6Pf/efNd7xKLsnapGqSi0qEsYzuKlN3
	 OHtvtVrbE/orOO05ZXqUn7gicYUHJNYMR9XFYykzsaQtm0LBCebOJwsJPAz8Ls4Oj3Bbe
	 nJCBOPrd+K3PzNKO+myQS/rat7X2rTcInVWnX935Px2SamlBD2FqFy4XqMH0X+A0QCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890097;
	bh=/sAsQBV5/p4Oq7HNtAwLQuvrN4es80oVcXGtlYTm4UA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DWs7oCa/kpfV/wq73FlA5mxyaqPCoGaT4tYoAHphBWb4We7GdiPFh+PrvM7NcISxE
	 9sPcLM4FvJPCfTxJFEDnkwGgOUbGx0V14TPL2P6bG2ZZAIIM/aATMgycC+ajtWMHYM
	 L+6HmbD7k5i9pzD1gupogWNaJyIf6KiyqClSFKEQErZYS8bLqg4fBbAjTB6w7YIMu8
	 yB3wPIjQjcsDt6atbSayZRDgkYUXRbIEw1xrIWjYHfIcgvSpzjKlmKtDRcjPz6MOgQ
	 KEueGfWkvp/Lx6eNr9Z3x09FWC9NaW74rI2fihSNp8PZNmq8UPfMwE3O49c7C4Fyj9
	 s86sais6OcfEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 251E781091;
	Tue, 17 Nov 2026 04:34:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E56BF70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB91260774
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHKvDpatlJ3j for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 061F860739
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gqqHVWKk
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 061F860739
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:58:11 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b4bc5b8de5so2431987b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794866290; x=1795471090;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/sAsQBV5/p4Oq7HNtAwLQuvrN4es80oVcXGtlYTm4UA=;
 b=gqqHVWKkIkVGPKqmYByBH1aQc0AJ1e6BDvvjzdS/CO2W/iJPLa9lKrEcRYJ7OKXarz
 n7s4J7ZpI+HAk/0JAY1GpWm8+gDl1y5zJS7QIffR4iMi3gw6uVVIJ8FYEGlK0M8OBeB9
 ADQn5D9EonMzZBZfo0jxoFufkFJpXy42QOtFXFOp+LL3HCUGosMjp75GFSPXmwgi7Nqz
 ZjiMSE9BeryHrPtIbpxIOe1JJ3a09mvZJgO1LztAqRTU2dj8ZRKPZgTPLyz1QW/SNHUd
 LRqOfFtCpZR4YnNdV+IB4UU6f8sIct5K+JuyJs/onVC2efw6+2eMibyjYVXxKrtVE0Pl
 aKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866290; x=1795471090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/sAsQBV5/p4Oq7HNtAwLQuvrN4es80oVcXGtlYTm4UA=;
 b=ER20GeA80EddxgwbrH6BDKCcoJhJOopDnhHVb3kyS4rWGpg6znakkWXQE+mQJnMAxL
 apCTJyQ0qq74c1UYb07Z4oWgI9D63yqK7cdzAQYbfJF2OQOPTbLCqETw8fpNWjX35f4V
 amsKDfYH0wd/+5N/U2LBlMzLhSJciT+Rnk7EXYUoV/O5K4SHDotnBrctwb91Sa5dhGKz
 /6t1NosqK2tHCluVdkeeCs7FxMaNahvZvJo/nnL7SbU8KKvQRC2Ns2qoNIs9qbp9neKI
 t1PQXw+mtp39S2R1Gm22bVrPnTvX7Wo3R61lIFsP2BDnwAQFpPvaxh3Nrhn2Q5PrI3+e
 TRsA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1k0fQjczIJ6KRaoFx4scs+BW3J1CvrLLSMgrJjs8V+HLfe655oNmNA6yA0zU3giTYFeV6UfU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/hiutjqLzRTNzPwZ2HnWhu9+uErwp4FDVpGiGHK7NCFaVo7pL3
 osW5HNyODr2ofOXDnKslUOZL4UAb9ZUwrIiS0YA6uLCMLy5i7MzjmHSs
X-Gm-Gg: AZFdTZet9NC5jRe+9289IYrdEic1pMA4tKpjNZT/DgQUZqxstrqje/JVcKBaMyzavO8
 Oph44l9ue9VVbMYyx3fh1h845zbMOoxxhHu5HW09pJCDt34KHkIk8QxkR+FQeniLRrc/WmiPAJC
 Y69+hpq/ICZWk0qTDKVPkG22N2f21jVFBirszasQNnVds8QF7JvdKZg5TE3nqdOC55jphIMKHBe
 qWSenv2oOlcBopHZp3IPjvkhPy8k024H8QToV53xUJHbevFUESBZm63i9QOC8X9GRLBo1ydaTJ4
 bNDtiJ55tMBgBtEzTmC0wCkyQKS7lT6P1+VHsuTO8ht16xjV/WPeQcNtnRD/jKK2qnjYL5BpQqN
 LAbvWLbuaNrS+lXB/yEiIWd0bQCMEOQfJrusJ/25yjXJyvW3aOmHUz/XRG7Ef6Ye7EFH5mgn07M
 u3huTcD1Qvl5RWNADiTjvw6/y+A1YqwxY75SuHkanZwZwxKjkwDh0oAQRvbEso6i5AwA+v9QGa/
 UqtrpYFBELYV3gGh/nzBhvTLtDTiYM8JSSYo4kGoaKJNA1GMVZxa3QETqu99KrHux00gVvO7s3v
 dg0DYDO3MflxkI/p2NyCELeHDpdm/lx+3CPJ5I9o+9OR8IFSuMnjihiSgUQCOi0bphoPjBpLnY2
 lJPnJEzc9iBlJwLupUXo/u4m3gND6
X-Received: by 2002:a05:690c:68a:b0:8b3:648d:46b9 with SMTP id
 00721157ae682-8b4ee2cbc44mr4781547b3.35.1794866290174; 
 Mon, 16 Nov 2026 13:58:10 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ed01d566sm8425407b3.38.2026.11.16.13.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:58:09 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH v2] fs/squashfs: fix out-of-bounds free() in symlink path
 resolution
Date: Mon, 16 Nov 2026 15:57:57 -0600
Message-ID: <20261116215757.18682-1-dilipchowdary21@gmail.com>
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

Changes in v2:
- Drop the inline explanatory comment (Qu Wenruo, Tom Rini)
 fs/squashfs/sqfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 2092e3c1c71..caa8baecfeb 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -391,12 +391,18 @@ free_strc:
  */
 static int sqfs_clean_base_path(char **base, int count, int updir)
 {
-	int i;
+	int i, start = count - updir - 1;
 
-	for (i = count - updir - 1; i < count; i++)
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

