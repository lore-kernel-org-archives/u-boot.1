Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B34DCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E645884119;
	Mon, 18 May 2026 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="V9w674Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF8B845E3; Mon, 18 May 2026 15:43:25 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5386C83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7EBEE1122FC; Mon, 18 May 2026 15:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779111801;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=MKNw4dOdotYltCyWKOr3bPZlqwpYM5EpQFg/kA8eDRo=;
 b=V9w674Rv3pFjCiXM/kUEe3JPh0L7cZS2XBDiUYfSDSFceaDu6vnuGBfOrjdIluN/8xOyvY
 1KDpJ8ymW4cVtP97v+5FIm9kICEBLs9aSsXmSETJ4qMklkJrse3bmYlanW3Ne9tNB/94Ib
 i10t/Ea+4/skrR8aoPSnURP4CHHZy41YTrzn+Lw3lQOnnjf7ZVPQ8Jsnkvk/557RvY1gcz
 rNZS1KONC9wfjQ2mTQfDtpou3OnJdcm8Y8nab57cKatTeIBHAFcDaED3DWbHFLywb11fG/
 ZydWDAHSFZp0GuF5DBYHwfuk49s1YnRNusmc2bletyF5ddKTTcAXmqwyujW0CA==
Message-ID: <cb6e2933-4910-340c-898b-c25be4d87bb1@nabladev.com>
Date: Mon, 18 May 2026 15:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Peter Collingbourne <peter@pcc.me.uk>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-ubi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

Please pull

The following changes since commit 215496fec59b3fa09256b4fb62f92af46e2ec7f9:

   smbios: Do not fall back on devicetree without valid mapping (2026-05-15 08:18:11 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubi-updates-for-2026.07-rc3

for you to fetch changes up to 0646ee0ed86bd2809e10cff1f8ca3310ad7bf33b:

   fs: ubifs: remove dead code (2026-05-18 09:19:56 +0200)

----------------------------------------------------------------
UBI updates for 2026.07-rc3

Fix from Peter:
- fs: ubifs: remove dead code
   Fixes: d5888d509cc4 ("fs: ubifs: fix bugs involving symlinks in ubifs_findfile")
   (hs. correct the commit ID)

----------------------------------------------------------------
Peter Collingbourne (1):
       fs: ubifs: remove dead code

  fs/ubifs/ubifs.c | 3 ---
  1 file changed, 3 deletions(-)


Azure build looks good:

https://dev.azure.com/hs0298/hs/_build/results?buildId=208&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
