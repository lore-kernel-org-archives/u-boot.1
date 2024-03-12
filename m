Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3895C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5359B87ABC;
	Tue, 12 Mar 2024 16:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew2CYRIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A73B87F27; Tue, 12 Mar 2024 13:57:35 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2438987D6F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=colinmca242@gmail.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7c8d5ae5dfcso4460039f.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710248251; x=1710853051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsvugGWQtYlTHpFIYczXD0jIVZr4jSfdJPIw/uAtfvg=;
 b=ew2CYRIfRIZTkPfSM0ze5pCEbvZU7pvEP+7kq2txDw8YxXiJZ5UaNkSK2vMGRzCHpF
 2Pw6Tz32Mmcpq1XHcEFMyAbFREo8G6rhz9wJuhdMHamX2Jk2Y0ZB5q+2NEsz48BcXiJV
 1quykpCIUj+rWoZsXftj5sa2Ooy3LeMMD5DRq6AX0YJUnA4LsWB2Y5dMpofyIRXt3py+
 Mvfd3nhZYtrUcdn6ruMygJdtBaoe03WWFf5n6LvN7mPbsvXanxFBpwDM+VPybEf1Tr+5
 67tCiHYyLRVPL9/GwBWujVM6hAH6870fhpjcrvGTNguqNOfi0RFhoXTtMoQohWL3IL+X
 vEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248251; x=1710853051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsvugGWQtYlTHpFIYczXD0jIVZr4jSfdJPIw/uAtfvg=;
 b=IsGAnMgZ3hH/PMkSGtrrKvOr0KMtzOfhmug6mzDAI/wrXjXVVkIgcc0jkKPi9wva3A
 +KjewWhx+E4ipTR/1aRoR8/Ap2n2V8VwAxm0uxlZ8kYXdspl5XwJegxJAuKhvkT6Juir
 5jfeiOIc6ZttSEdpXnAo4vH7X9tfRv/gRD2Gk6y6T49y3MhGxSWQzIqYeFH48itvMRMB
 ysJFE2XMIqFSCJmBvB/x+VibVhThofZg5jLetSrAwuooz2GNef1yzApELdK+I0AJLWWJ
 pLLcQBmXx6OnBI0NWXJk1fzV0PSuzDs0ErBmT/UF+nLZ34vCi3Wyt1b82f+9wG6zNO66
 Bqbw==
X-Gm-Message-State: AOJu0YxGpuk/LXnXKaNIumWEJFK6h6CNwoB0xtn1P3XiKxGgr/R7exJQ
 +XJZi4gNXxSYq/7b+2idwe02kQQxuOaHOBubUFyrO7vTCWb/u3vj1yjhP1CSwGI=
X-Google-Smtp-Source: AGHT+IHqpey5/EeGEV6GGsWRzqUs3A2VGDGQUC0oYiIfaswTEVHLZgb+lfuggAztmgUNOZAH/x3/Dw==
X-Received: by 2002:a92:c567:0:b0:366:655e:9563 with SMTP id
 b7-20020a92c567000000b00366655e9563mr1591202ilj.6.1710248250902; 
 Tue, 12 Mar 2024 05:57:30 -0700 (PDT)
Received: from rehoboam.localdomain ([136.37.200.217])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a92d485000000b0036577b41481sm2278595ilg.73.2024.03.12.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:57:30 -0700 (PDT)
From: Colin McAllister <colinmca242@gmail.com>
To: u-boot@lists.denx.de
Cc: Colin McAllister <colinmca242@gmail.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH v4 0/2] Fix Android A/B backup
Date: Tue, 12 Mar 2024 07:57:27 -0500
Message-Id: <20240312125729.82695-1-colinmca242@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 16:00:41 +0100
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

- Addresses compiler error due to missing semicolon
- Removes use of preprocessor macros with ANDROID_AB_BACKUP_OFFSET

Bug was found by noticing a semicolon was missing and not causing a
compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
a patch to fix the semicolon before fixing the #if's. Testing the latter
patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
compiler error.

What's changed in V2?
---------------------

The second verison of changes removes the #if preprocessor macros to use
C conditionals instead. There was some minor refactoring required to get
this to work, so I did more thourough testing to ensure the backup data
works as expected.

I also realized that CONFIG_VAL is not needed because there's no reason
for the SPL or TPL to have different values for the backup address. I
opted to just use CONFIG_ANDROID_AB_BACKUP_OFFSET directly.

What's changed in V3?
---------------------

Added "Fixes:" tag to patches. Performed additonal testing as described
in the second paragraph in the testing notes below.

I opted to not use CONFIG_IS_ENABLED because that macro appears to only
be intended for y/n configurations. See note at top of linux/kconfig.h:

"Note that these only work with boolean and tristate options."

What's changed in V4?
---------------------

Nothing other than sending the patch in through a different email
address in order to see if the Garmin SMTP server is borking the
patches.

How was this patch series tested?
---------------------------------

I built for my target with CONFIG_ANDROID_AB_BACKUP_OFFSET set to
0x1000. I first verified that the device can normally boot. I then ran
dd before rebooting to corrupt the primary data. I confirmed that the
backup was used to properly restore the primary. I then corrupted both
the primary and backup data and confirmed that the primary and backup
were both reinitialized to default values. Lastly, I corrupted the
backup data and not the primary data and confirmed that the backup was
restored the primary data.

Addtionally, I disabled CONFIG_ANDROID_AB_BACKUP_OFFSET for my device
and confirmed that after I corrupt the primary data, no backup is used.
When the primary data is not corrupt, the device boots normally. This is
what I would expect, because CONFIG_ANDROID_AB_BACKUP_OFFSET's default
value is 0x0, which would evaluate to false for all C if conditions.

Colin McAllister (2):
  android_ab: Add missing semicolon
  android_ab: Fix ANDROID_AB_BACKUP_OFFSET

 boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

-- 
2.34.1

