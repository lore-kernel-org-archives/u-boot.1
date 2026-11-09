Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E0606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Um8ATj17;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tsboo94g
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70C86606DA;
	Mon,  9 Nov 2026 20:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYU0cd8Wa_ei; Mon,  9 Nov 2026 20:32:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D4DF6071A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794256368;
	b=cyn9NOOzwd25JtH+u/Idfuh1LTyFJOIh9XGMIXjoZzUdSy7h6nMumqTuTMqcWImAb4Wu
	 cJYXgjq8MGckzldudSY60o6FTXKIeOezlWi4cv5WbFvtd3oXbl0eomteOLQMYIyOBWML/
	 QsqcMKwtzrCBGjQGhN7fgA/OqjYWmvLQAq2SJ8+cp3Pi7APoZb3/asuQz5tJeTAk0ACGs
	 Qq1jP4UU8r3TxAJocOpNyzoAUQRemTo5H9+ounJNPnOGq86q6MiPSHlr9Ji+50qm9Crs7
	 Ih0oJKl3yulZ+wSfm6dv7lDwM6WhbDG+vNXA/utxHeXEiL7S9CMqsdrEIsItPu8ewJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794256368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/IEHSAM1SLmAWFMIYr1YSmdRhavdtCHZ8m7k8x9B4mc=;
	b=NGQKcNfa+q5vN7G//kwLQUnI4Nh1ZQtxzausKnj5wYNJSMXClIlYDSb4Ke0Y/a6Y8gxf
	 JRwAR5e1uA3Yhlgzve/ksWPsN4PE9mhWskQDF1i/SMnRtwPv9EgHcDceDwA9nyeyn0cuC
	 qm2XNKxhoYCLXLHg4bNZJdZ0ZuggH+WyBAGTvDIzm+3YviCZ5EMggCSk2OoO+XK8N3zah
	 BOWJBOdTwDyxi/kSgUl+P95zqfep14LWfN9MPUNunvKyxEi1uOPwuWV96lsU7DL/e7CJ4
	 qt/EqNvMLwU6McvPu14kqluJ6iiN8BxLiukYmzmlPNUiGOr06R3XWVXnVhzTJsdiFBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794256368;
	bh=/IEHSAM1SLmAWFMIYr1YSmdRhavdtCHZ8m7k8x9B4mc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Um8ATj17eubFhGUu1XE06jQbbqcvYOL/hyVzOwlJsozXvjmPYftJg8loeYwhWYGU2
	 ImZGZ8lvit29V1WbolpVHGb5Y+JELoQ6Vr5uEr/z6ECQKo9HILPS+ZkkO65oBKd3Gp
	 H+7v7sofnMfVtqU+Z+oq0FWJqLGGZ2SQ1Y7N2BLXZcZud8X5ozIGXeCeGnFhHU0SiC
	 IVgQeXIFTZwMxF+/UESVHULXn+IIny/8BCgFHAAVmeLsiCnt9WZQG22wVuFO65fdmF
	 F9FvBI4u9YeMmbywgqvZVQ+YecdB6a8cXqXlA82x+2Itf1wtW+Sw5A9cnS2tT3mgo/
	 lZeVAmRJZV1tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D4DF6071A;
	Mon,  9 Nov 2026 20:32:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35501388
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26A2980DF9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRfns0Z617dQ for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 707C880D5B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.132
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.132;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=tsboo94g
Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 707C880D5B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:48:33 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=ZVm9fP4DFmgao9Bw4KsvOpVwvOEfH3Y6d3QmgPx2vcM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794253712; v=1; x=1794858512;
 b=tsboo94gwI16ulasi+ZYm+H0mukufrmaJmhP6fkTBLMB/MoOQ6exTQu1j2aBdBo+GL/Jf2u9
 v4PN/PCuIrtZajjy0Z28ewqkkTxxblRuS5jfih3Dov/ILAP+v9nylGrtwZoU1qKJVyKpJEKHNA/
 2zeyEiSQvgiF4rKcfIjBnC+Q=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by mta11.migadu.com with ESMTPS id f1e2f22afd2e1b57;
 Mon, 09 Nov 2026 19:47:29 +0000
X-Mizu-Trace-ID: f1e2f22afd2e1b57
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Tom Rini <trini@konsulko.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>, u-boot@lists.u-boot-project.org
Subject: [PULL] u-boot-ppc: PowerPC maintainer updates for main
Date: Mon,  9 Nov 2026 19:47:25 +0000
Message-ID: <20261109194726.3227855-1-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 20:32:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull the following changes for PowerPC.

The following changes since commit 30524290ed7a2f6bdeca423b329790158dc9af2c:

  configs: Resync with savedefconfig (2026-11-09 08:30:58 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git tags/u-boot-ppc-main-20261109

for you to fetch changes up to 439fb4b1e84baa551e006459d9e4a24ea763a8f4:

  MAINTAINERS: update email address for Bradley Morgan (2026-11-09 19:35:37 +0000)

----------------------------------------------------------------
PowerPC maintainer updates for main

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/pipelines/1942

- Update Bradley Morgan email address:
  Update maintainer email address in POWERPC entry to bradley.morgan@linux.dev,
  and add .mailmap entries to map previous addresses.

----------------------------------------------------------------
Bradley Morgan (1):
      MAINTAINERS: update email address for Bradley Morgan

 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
