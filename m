Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB729CEB2CB
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 10:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3BE83F15;
	Sat, 15 Nov 2025 11:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="F9AGkycZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F49A83F2D; Sat, 15 Nov 2025 11:59:33 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66EE9839D5
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 11:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39B7510AB3E; Sat, 15 Nov 2025 11:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763204370;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=Zsibg4GvUQfLZrp4z2YZTDMUZXjSWGCJ2f4tOVFLrA8=;
 b=F9AGkycZ+bdSsxWUkFGc++uPDA7w4A2r2mm8e8vpGPoAcbIv06Y3z/tIJLk8Bp7A6r2y2J
 zu6SY5eVwkl027xfmwqKEFBYeQDgopmGNeL7qi8MTEVoTLuaW2pWOJ55xLF8/e2jfCTeFY
 kHo+6F3LiyCQeL2Pr8+C1EWTVe8MHTXGBudS7uRp/eG3/5NYlpQ2RJCwE7TTRsExzWBl5K
 2jorJkYWzVAK/QeW4arUWu/+6TYX2OAsNWQsXy37vJJ2p871ND2BIROvmrzkFjmrRN3R9v
 AK6EjVUTV1Bidx2osnbaSjsxIUaQV6rSu6dSJeZCyyp2EjFH0LK/PR1VChciWQ==
Message-ID: <b5468640-d599-9964-c01c-5d9bd6fa5474@nabladev.com>
Date: Sat, 15 Nov 2025 11:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-i2c master
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

Hello Tom.

The following changes since commit 6b27b6886945a9351fcea8c9acf9418844f46670:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-11-08 09:03:54 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.01-rc3

for you to fetch changes up to 107d5f340bcf20386022d5f6d9188e9e7bd39729:

   i2c: muxes: i2c_mux_select/deselect() should be static (2025-11-15 07:37:25 +0100)

----------------------------------------------------------------
I2C updates for 2026.01-rc3

- i2c: mux: declare staic functions where posible
   from Michal

----------------------------------------------------------------
Michal Simek (1):
       i2c: muxes: i2c_mux_select/deselect() should be static

  drivers/i2c/muxes/i2c-mux-uclass.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

Azure build looks fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=191&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
