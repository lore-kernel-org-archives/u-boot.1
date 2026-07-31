Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34162C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4388B60B39;
	Fri, 31 Jul 2026 12:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmRxlKgq2Xpq; Fri, 31 Jul 2026 12:08:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6232160B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785499694;
	bh=fB6f9ofEbzlk9ck3Age/if3GdvFH/ZLoCSXYvHJUY/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXJkEkdHEMSc/dE2EX4AoVenS+c+JYHVUF74hhLXnJtMencNPmz3jIJhlPDIdeLe6
	 Gid8YJWEyladuwshmlZF8QKcEksfm1CDqFbiUuPzH6i9KrfkBpHdUQoyJohlPAtHT7
	 qtYqk5WTDyVza+MJingzFT6ZOFqSf1DV83baW5nIsJ0E0G2PPwnUvYwtp/v7uaXd+s
	 TMEY7rc6PHcCCEU38SjcWt361BllM8TNzVqvJUygRZtEdda3AyrjNIjjxzF6+lXHYI
	 LEvpS37byuPIROUBUObri8IBkhjtBApnMNuMTSCKgfYBrNmkcCQCCSM1bNqfrNXjBk
	 f7cVvi7YTrO9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6232160B11;
	Fri, 31 Jul 2026 12:08:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 740DF36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65BBF81321
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvrxGSWq2Ozp for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:08:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 98424812EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98424812EB
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98424812EB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785499683; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AyOAtAciwsdACQ8TA9MvqzPqqub8WHejohVfn6xlgRuKvwRSjoActm73nNERvdguFBuFa9CbyYbgJ6S3TgcmqQ/6gAJllbniFUFdlxVWuhqvwC1rwd8BSTAjgKLYpfFjjltU5pyPSMU2oIVgomh9PleSnaWhcEfO6V2jBnOd5Ss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785499683;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fB6f9ofEbzlk9ck3Age/if3GdvFH/ZLoCSXYvHJUY/Q=; 
 b=Sbsw1PkSup6LnWcJ47h4UH7kMHLliUP3nMvaiK/WeZFUUPHXkS6XETKydemSGJ8Xi+Pwv3ls+5xT3J1VA6KlTm+pzOIt6PRB5nEGWGQ+uj/xnQv148mVjSGS81GZlpDx4xffEKpKSjSq4ztCchAae7XLnDZWq3J+baxgj1e7Ujc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785499680231684.9458854073472;
 Fri, 31 Jul 2026 05:08:00 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Subject: [RESEND PATCH v2 1/2] CI: Dockerfile: Lock the version of swtpm to
 v0.10.1
Date: Fri, 31 Jul 2026 12:07:49 +0000
Message-ID: <20260731120750.2212394-2-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731120750.2212394-1-me@ziyao.cc>
References: <20260731120750.2212394-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785499683; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fB6f9ofEbzlk9ck3Age/if3GdvFH/ZLoCSXYvHJUY/Q=;
 b=KB/JL3ggUc0+qRZ6KgKRFTSjg/lfoKFJjGhkKvAq6UifKpXNyFMgX/4okjGfcdZB
 CBbldVlncMV0NSPtBJB7zWkhhhmCRj+sPr0xQsTtmuNaF2yJAbENiiB47FdttcbuWca
 RLEO0dYp2DcH39JcdIGhkC3CZAknE4f1Z4Y5t73A=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=KB/JL3gg
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Instead of pulling the latest code, specify the exact version to improve
reproducibility.

Fixes: 8a87d1ae9585 ("Dockerfile: build swtpm")
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ebb679a5f466..fb8e2c523aad 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -312,7 +312,7 @@ RUN git clone https://github.com/stefanberger/libtpms /tmp/libtpms && \
 	rm -rf /tmp/libtpms
 
 # Build swtpm
-RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm && \
+RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm -b v0.10.1 && \
 	cd /tmp/swtpm && \
 	./autogen.sh && \
 	./configure && \
-- 
2.54.0

