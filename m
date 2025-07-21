Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B89C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 10:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA08830C0;
	Mon, 21 Jul 2025 12:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="IQxP3Frd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DEC830E4; Mon, 21 Jul 2025 12:40:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8966E8309A
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 12:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1753094430; x=1753699230; i=frank-w@public-files.de;
 bh=oCoTIdrvuI/CBODK1Pj4cbhO/ih7htlgESndafj+LrI=;
 h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IQxP3FrdBzd6RYGW+myd8p0pd7XdQbC/xrioDihgqRuDA+8n6ouF4LBYUj2rezq6
 gOf8C+qTy4z3U8sMCYuSQh6dK2djYkNENchLRXlT0erzthRusM5oihYtfR8vJbmYj
 hCgoF4aXG+sQwMyo6yXcGBylGG6g3IHkqN2K0XxQaC0tjnG8eHC1HosBMecFa/4Kf
 RdFDrfLCyGDTZjs/q+1c7A2FFpq+drZQHan0CNcNTWerJHR+3qKETmnfHmovMv0TS
 4pP9Nrfk4qJBe4SIvDSfPy+ZJyiTukuFBsOuOopuS+aah49rIZfVboCy2rR8SYQ/G
 ys4h7EKxH3OAW5x34Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.73.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1v1tQc3QxH-00pB3l; Mon, 21
 Jul 2025 12:40:29 +0200
Date: Mon, 21 Jul 2025 12:40:30 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de, trini@konsulko.com
Subject: Gitlab down
User-Agent: K-9 Mail for Android
Message-ID: <EB8511BA-0BBE-4770-85BC-EA2E8C56E5F5@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZwHHcvsmm+E3z1OK3BAENH4zU3JtoCIzXLjOmaM6r4xmumIr93M
 tur5zYpjjuzDXcbzInikkOaFU9VxOMhpKRF2ETlDQVA+VDhndhJ//hAp7E8eu/KZg42tJK3
 FCW/V8f8Pf62UndI0QseVd1o/UkEdtXTr6uOJ2In8PkYarJGeyL2OTnDwkI4SxMpkj3Y2np
 a2sGhUSV1b3YYOUz1ztgw==
UI-OutboundReport: notjunk:1;M01:P0:LZ6ScgBZwEI=;iecsCKZu8sDMbJW9IEWqp2PCh7L
 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
 iDPg5ePOW1g==
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

Hi,

I guess you already know,but gitlab on https://source=2Edenx=2Ede
only prints a 502 message since at least yesterday=2E It does not look lik=
e maintanance=2E

I change to GitHub repo,but i want to know if maybe your own gitlab instan=
ce will be dropped=2E

I found a thread from december 2024

<https://lists=2Edenx=2Ede/pipermail/u-boot/2024-December/573566=2Ehtml>

But no actual one=2E
regards Frank
