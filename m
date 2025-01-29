Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC8C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 05:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E15480EB5;
	Wed, 29 Jan 2025 06:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738129340;
	bh=sxqyuzrNJaawmEbSVlZ9Aw9kdxkrBId24eK+xgSAw6s=;
	h=Date:To:From:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TymVMRF/yOZ6pSnH6Pe2htmp8/aZTmpgCFHQd3Oej6puusZjr3pM3nias26ViENq4
	 cEzFcoCUx//tkdZNeD/3lLSVUFeBYW+oJiKi5xmyvjRcpKrMTNY/aZ0u62pO2MN7r5
	 azBk7IzimnBS+2+dKVRHh4OIKlFE33r7fZVzLNWvQkrCXwfg+HETXV9DDwhb3NWS7L
	 mp4gUbRVdAE7Kl0QrZTMnb3Uw4X3NJqJrS1kzP/bnYX4znz9Am95KCTZebZX6fJUi4
	 SoZ8pw7AQGhceYoMgD2c3EpLRmlAhwvLZKW8SpznaFROqbAZnDa0FmB63rZcbTnjHn
	 8/FRD/ikXbY1w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9BC80EEF; Wed, 29 Jan 2025 06:42:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0474B80885
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 06:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LgM4bAVy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A05C10382D08; Wed, 29 Jan 2025 06:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738129335; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=sxqyuzrNJaawmEbSVlZ9Aw9kdxkrBId24eK+xgSAw6s=;
 b=LgM4bAVyX2fxw7IMwDshIivk10lETqHSsucFDvYiZSLtSp3XEzN9GQ4w7Qvz1+Gdz/ZfIJ
 denUAPpIIoAQ2Tj57f2scyvWx+9QcxlLL6ksRI/rR6sJUvDpGUvesgQjf7FxERKk9YGTC2
 BczFtTypq1kKsWQL8IRqyfhQBaN06jD7e1E5IZyuQQv0TKKRL9zRBA7dpQsvLvBCzbn1Tk
 d2TT1qsPyPT3j7iSa1idnrsXRMxOfQ2H2lVDgGJ47Gn+3BKJr4kMBQ6i7VQ19T8xJFdh9D
 gFbQ0TZEeOoYFOLBnMYgruX4aanYCpDK89h/IctjOZPFxUJHUjRCUs8YxPz4Zg==
Message-ID: <4cc734a9-3e96-fb51-20a9-e82245227a20@denx.de>
Date: Wed, 29 Jan 2025 06:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi master
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-ubi one ubi fix from Michal for v2025.01-rc2

The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:

   Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-for-2025.01-rc2

for you to fetch changes up to 14e02d6c6180f85114cc0a90469e010a5d68b2ee:

   fs: ubifs: Remove unnecessary assignment (2025-01-28 06:44:18 +0100)

----------------------------------------------------------------
ubi changes for v2025.01-rc2

- ubifs: Remove unnecessary assignment
   from Michal Simek

----------------------------------------------------------------
Michal Simek (1):
       fs: ubifs: Remove unnecessary assignment

  fs/ubifs/recovery.c | 1 -
  fs/ubifs/scan.c     | 1 -
  2 files changed, 2 deletions(-)

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=169&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
