Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969F2C021A1
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 13:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C42809D0;
	Wed, 12 Feb 2025 14:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZSoJVGFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A0C80BAD; Wed, 12 Feb 2025 14:54:41 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127D38043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-5de6069ceb5so1501946a12.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739368478; x=1739973278; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jz7u4sqERdK8+U/rhGDQ5KMh0LDnmIrqfpzz4/leGAA=;
 b=ZSoJVGFDAvHe+x7GGJSu2WEnhev1rPevIvYoLK6Rn01GOsif/Ne0mf5kdQXwfhZN/X
 WZbvhZ4Q5xm2Ye3K46CtetyybsJMi83mSpLelSNHuIye+QJj4BAYyu10bIRx0PEDMnoO
 naL3cg9cxSht3KiN4Xwsqu84Vf98gr9ZStsVvP+g60WVPJCiwZ9tiayZlorcaEFpnulO
 qry3+nyxVF6rY+pBuBPT7+B2xIvekAi4h03NIHayrfUVpCOhULtYeEJ1pXWlt9PCpOXg
 qiPlKZmX2kMyQc2DKiHjv4TgL3kFNDLV3v2fVo3JA6/xP+xEck2hzFgDEG+8XAD5zGe7
 ue4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739368478; x=1739973278;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jz7u4sqERdK8+U/rhGDQ5KMh0LDnmIrqfpzz4/leGAA=;
 b=sbmbbqxLNuVh3CZ7T7uW3duviUoTClftp7Hs9bXRtKTyS5YkkqTMOVlPaqodjd9rDr
 qPxqVHo5b/2ZAVfb8fpBEDvQpCFPyBXa5YxVrexLZSlndzveoPPtWqfdkN5WwLXXVx1p
 Rx4zmFoKA1qAwjkTM7Bft6pavMO1L/DS8C+OFmkPRKJ6XGDEEzK1v0P4ZKKhpxsIB/r5
 YReddPYhU3YDrvbZ446vkkgNSr7gJsDEikZYAP0FpxzNHjvcNZlPB19yz5CJSzvVr8dz
 3M8OVaEuz1T4+4qKt+dEmmGOSlGsk+TYuSlOHuDurslo5a3ZUJfEm9RS0bOGjh52rqyh
 nR6Q==
X-Gm-Message-State: AOJu0YxmX8ettY2Da1motsmSA3YbFIBSxhq0YwMwTZi8IMgFVl7yfSWc
 CulBZ5XVDDbRSVoUyrK83EjYWEZMbo57mpuGG7naG2A6zuS5i0nEFH6L+h9wV2wTGAFyzNhp8lJ
 9esmkdVY0J1s=
X-Gm-Gg: ASbGnctlJu8l1Wdp99CH1Om9JkPZVZC/Ek1AexFpoXUxGfn5sEFSWpHQGsHER3lOHKy
 nIulLyaqE8l6JmjerXbWJj09fiQCInJ5Zn6MvHBvmENX1FKQgPuV/ZpkI97IWY++yF/zma6MiJi
 H7aoADWn7ciOWvqSCs7tYjSLKE/zbuXa4b49w+I811XPPoe/q+NjbSfWjWSPCDd1o0BofMUUt/u
 /8ohrpGr2NyWlJk2m4cgPSZBNKShxVj39RMKxgmRwXpCwsZ3TdoLiTKtaS2qP+qhmC2Z/EooMs0
 6BDBfOQSMA5Wb86oJSPJBbQwtf4cqJn0pTLBF7dWTzFqbXytrpNkfs1MwhUtWKSUeEP9
X-Google-Smtp-Source: AGHT+IG+yw4FKYXCYW+D9Ewi6/6moMA/0oYT6mw0ZaHIdHrOcPncbrxb+5bXVqvswHwyflqiv1c+FA==
X-Received: by 2002:a17:907:3fa4:b0:ab7:ce7a:dfc5 with SMTP id
 a640c23a62f3a-ab7db54475dmr664827166b.19.1739368478442; 
 Wed, 12 Feb 2025 05:54:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:bd0:e26f:4297:3d26?
 ([2a01:e0a:3cb:7bb0:bd0:e26f:4297:3d26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7b4aba036sm722812966b.45.2025.02.12.05.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 05:54:38 -0800 (PST)
Message-ID: <7caf7a0a-c2ed-420c-afc7-620ab11461b5@linaro.org>
Date: Wed, 12 Feb 2025 14:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull u-boot-net-20250212
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

The following changes since commit 3da1864b1f2fc3cf2b4eaa1849bcafa669ff674c:

  configs: Resync with savedefconfig (2025-02-11 09:57:33 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ u-boot-net-20250212

for you to fetch changes up to 893e32848f00e71eacdda2f7bfc32aa303f7a01f:

  net: Kconfig: depend on DM_RNG for WGET_HTTPS (2025-02-12 10:25:14 +0100)

CI OK: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/24577

Thanks,
-- 
Jerome

----------------------------------------------------------------
Changes from the u-boot-net tree for v2025.04.

net-lwip:
* Fix incorrect selection of ethernet device on boards having more than one
* Fix TFTP option processing
* Make the WGET_HTTPS Kconfig symbol depend on DM_RNG

lib:
* Add strnstr()

----------------------------------------------------------------
Heinrich Schuchardt (4):
      net: lwip: tftp: fix find_option()
      lib: implement strnstr()
      test: unit tests for strstr() and strnstr()
      net: use strnstr() for lwip_strnstr()

Jerome Forissier (2):
      net: lwip: move eth_init() out of new_netif()
      net: Kconfig: depend on DM_RNG for WGET_HTTPS

 cmd/Kconfig                        |  1 +
 include/linux/string.h             |  3 +++
 include/net-lwip.h                 |  1 +
 lib/lwip/lwip/src/apps/tftp/tftp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 lib/lwip/u-boot/arch/cc.h          |  2 +-
 lib/string.c                       | 51 +++++++++++++++++++++++++++++++++++----------------
 net/lwip/dhcp.c                    |  2 +-
 net/lwip/dns.c                     |  2 +-
 net/lwip/net-lwip.c                | 23 ++++++++++++++---------
 net/lwip/ping.c                    |  2 +-
 net/lwip/tftp.c                    |  2 +-
 net/lwip/wget.c                    | 13 +++++++++----
 test/lib/string.c                  | 40 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 152 insertions(+), 42 deletions(-)
