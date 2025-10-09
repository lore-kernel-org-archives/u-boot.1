Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CB1CCA471
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4360F83948;
	Thu,  9 Oct 2025 06:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="K4dVwf+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2C583966; Thu,  9 Oct 2025 06:22:47 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BA9838E7
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C5A61032C1; Thu,  9 Oct 2025 06:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759983764;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=iqFm7okE2M95r3iHRG3ADLpaQb1/JeiSilCNZvKY3FM=;
 b=K4dVwf+4fjwOTNfxEtE/RsM+DAkHXW8Bj1FwcFJcTDJ+S1F0SKAzd5H5gg5YibVJkMPnv+
 CgzzI3FdzA1XA/kSvE13dlexKqCYFPJW++CXZWs5CGTDMlhaAD8d1fnNoNAmipOW7aoZk2
 OGiXfpQDe/NIEAhQ9KL/w3Kp0RG96V/cY0+IobmSqMYDYTeHKip72DctyLyYDTOUiPMAQx
 pI3K7CLvWjRiycGJTS2HF+vz3QbeCRzU9fbjFQZC+qqgeB2/K4qOq/TfzbRNTc+IMBrn4p
 kJVcavK4Mm0mmMW48LwuWSzEkh3RIGjftFsLwYmG2lkVbewOiv3NsDlpW6xoZA==
Message-ID: <1f803ccd-9743-9be8-a594-58fcfeb0f687@nabladev.com>
Date: Thu, 9 Oct 2025 06:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
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

please pull

The following changes since commit 92dcb3ad5d98f494b2448a7345e1cb7eefa50278:

   cmd/dma: implement dmareset command (2025-10-07 17:49:15 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-ubi.git tags/ubi-for-2026.01-rc1

for you to fetch changes up to 0cab29ff467e297064a9fc30200347bda06ee0c4:

   fs: ubifs: Fix and rework error handling in ubifs_finddir (2025-10-08 11:36:05 +0200)

----------------------------------------------------------------
UBI updates for 2025.10

- ubi fixes found by Andrew with Smatch
   - mtd: ubi: Remove test that always fails
   - fs: ubifs: Ensure buf is freed before return
   - fs: ubifs: Need to check return for being an error pointer
   -fs: ubifs: Fix and rework error handling in ubifs_finddir

- fix: limit copy size in ubispl found by Benedikt

- extend support for LED activity (use the LED activity also on ubi reads)
   from Yegor

----------------------------------------------------------------
Andrew Goodbody (4):
       mtd: ubi: Remove test that always fails
       fs: ubifs: Ensure buf is freed before return
       fs: ubifs: Need to check return for being an error pointer
       fs: ubifs: Fix and rework error handling in ubifs_finddir

Benedikt Spranger (1):
       drivers/mtd/ubispl/ubispl.c: limit copy size

Yegor Yefremov (1):
       ubi: extend support for LED activity

  cmd/ubi.c                   |  4 ++++
  drivers/mtd/ubi/io.c        |  7 +------
  drivers/mtd/ubispl/ubispl.c |  2 +-
  fs/ubifs/lprops.c           |  6 ++++--
  fs/ubifs/super.c            |  2 +-
  fs/ubifs/ubifs.c            | 16 ++++++++--------
  6 files changed, 19 insertions(+), 18 deletions(-)

Azure CI:
https://dev.azure.com/hs0298/hs/_build/results?buildId=186&view=results

Thanks!

bye,
HEiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
