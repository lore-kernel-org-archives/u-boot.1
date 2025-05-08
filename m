Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9B5C3ABC5
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D8D82905;
	Thu,  8 May 2025 15:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="i1029xKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CB88294C; Thu,  8 May 2025 15:27:18 +0200 (CEST)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA97828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746710834; x=1746970034;
 bh=Al6rg88lHjDrEz/fpiU+jOuxnHKS5UhVNnAOrPUNDPU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=i1029xKDFjgH8a4dyTWGhbMaqgoudiCguSyjFyaU3OKFohhfI2pDpuM0zFkosqo4j
 TlFhqBUD6ahn8yUq3nSYq3VdKWuXtwXWu6gJ/OWjzOVm3rnJ5EJ+EpALQ05DDb7cJE
 FMhir1tY3Az5xfBHxaHJmVSjBDK1JFRQSysvulVajIWyNHIom2abNSjLZ3UmnUhoQV
 k44S2jSASRY0IUO8dCKgBrMEDfSck4yRuZZPAIFCBJBbFCy4SQigXnx70Nsu/COUCE
 RtnpXT6snbNZLQ1z68qXGV3fXItva+RHMBMFz0l1FEBJ+cdwPUt/FrYS5RR1fMhMcg
 kfysEaHvdY5ew==
Date: Thu, 08 May 2025 13:27:07 +0000
To: u-boot@lists.denx.de, patrick.delaunay@foss.st.com
From: Johannes Krottmayer <johannes@krotti42.com>
Subject: U-Boot STM32H747i-DISCO support
Message-ID: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 9802ae048da63a4e62716f500446a2153ea40e8d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello!

For a long time ago, I have wanted to release an patch series
to support the still active STM32H747i-DISCO board.

Currently I have added support for this board in my local
Git repository for U-Boot. But must do some tests on real
hardware now.

When I have tested it, can I release a patch series to
support this board, or isn't it useful?

Thanks in advance!

Kind regards,

Johannes

