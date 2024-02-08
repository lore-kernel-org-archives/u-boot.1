Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386ECC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 10:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166F287BB9;
	Thu,  8 Feb 2024 11:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BZlD66mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EFF87C8E; Thu,  8 Feb 2024 11:50:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0E78785E
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 11:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BF603FA8D
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707389401;
 bh=41Axw2s+Oin12/F8eiQz/sf6Nx+tonSmAB7hJA47m1w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BZlD66mhZ3ahBlGXPOhAALp+biShbsae/CjfktJVkxEg5SZfflhg4XHS5ph8p3fRr
 /c1j/w26bbujiTOtoSnd+0/CqIsDGmxoad4w3BfqP8l36cixSSnLSSsSer8xbGxu90
 BXg5C5iJpjerKkG7lOwE9KRwIhZkGJD8MeraZ57orrXAnuILJBMUqd2uUn+vYZhq1y
 wJW6QJMVBshzTU9liNE+jpVCGuJhhaHxe6JyIOF1TyyVPfwvD088zTTInOwxdvCawP
 rcGQiwCdDmf2jkPrdvm7nOTkcqauU1pcMD2MfgpujQdGIrFhS4H1mAuEcr/0QK+pz/
 oPjURJm41cHug==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40fb9d0cfb7so9416745e9.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 02:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389400; x=1707994200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=41Axw2s+Oin12/F8eiQz/sf6Nx+tonSmAB7hJA47m1w=;
 b=sQBA9ZmjeXvxrNQ1GB/X0vsKte7kaV1Vc+0r+CuNEEE+dOPy2A/qtCkTwfVBuvj91r
 kyuwgL4Ml9Ix5+5KDQI7p3mB/h2tcZt8gruQsRmH/NLXFnCbkUcRcpVmSca2NR1bEzgn
 hXPW/GCZLn6kHvvHq3EYyzYEoEaXs02u4ZQ1fzqjr4lJycqAW1T+njBbW6r6/6VGik0r
 a02oVo9lePviP9rS23eiuCJK2a1GCG2JX63FDUxfOjsFdR2PwkNXI9ArkkCO/qQZs63F
 AcJ1d6qZzBiQDFn9muNj1enRv9aqBzH8qOMljU5BhP8WvcXbbk6n5eIEq/2i7q21BQE5
 Q+Dw==
X-Gm-Message-State: AOJu0Yz6TtJm9SbkRNwj5Yi83Nob6+qWTXphr1RucTCtV6kWrld2FqK5
 uNhYdiTjIYS8GC9yLRYMOfL4MFw/1z2x7ak7DrZvG+u87XM8kx1Eq7GPYmcUTwaCeu8qajwjRbA
 MmFAwJ2V7uqJpx997Mb6RqUf+b4fQhvqfvkISgC0Rjj7Hmew7jFFvySrAamLrJ7LSZBM=
X-Received: by 2002:a05:600c:a05:b0:40e:b17d:2f56 with SMTP id
 z5-20020a05600c0a0500b0040eb17d2f56mr6153360wmp.23.1707389400520; 
 Thu, 08 Feb 2024 02:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbDXIRrY42NBj7CJ5KPIvygo6qY+ojiG951UwIllXITPYd3P1FazFMvurbDYAfCv5/+dSSGg==
X-Received: by 2002:a05:600c:a05:b0:40e:b17d:2f56 with SMTP id
 z5-20020a05600c0a0500b0040eb17d2f56mr6153339wmp.23.1707389400067; 
 Thu, 08 Feb 2024 02:50:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXxrY6gzV3tjzUghORpKapU3Mc+jOHKI9Mge+gw1lJNGLEy1e/w23G/KSYjLpEZgN4Y7Rh6vs6/8YzPQdbnMSVJaPwBZTcF4SXw9qyDKElwfPx0iC5mqoytQyL38q0d7M8QtDS579px
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c470c00b0040ff7e3170asm1248348wmo.2.2024.02.08.02.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:49:59 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] smbios: fill wake-up type
Date: Thu,  8 Feb 2024 11:49:50 +0100
Message-ID: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We should not use the reserved value 0x00 for the wake up type but
use 0x06 (Power Switch).

Correctly display wake-up type in smbios command.

Display SMBIOS type 1 field family in smbios command.

Heinrich Schuchardt (2):
  cmd: smbios: type 1 wake-up time, family
  smbios: fill wake-up type

 cmd/smbios.c     | 25 +++++++++++++++++++++++--
 include/smbios.h |  2 ++
 lib/smbios.c     |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.43.0

