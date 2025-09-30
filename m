Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EA4CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 12:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B268C832AD;
	Tue, 30 Sep 2025 14:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m6mT0WUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AF2833E9; Tue, 30 Sep 2025 14:48:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C99D83045
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so56358755e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759236480; x=1759841280; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82UkVI7TJlozsVBRZvbBpW12F0wp+jTBcojgg+J4n2A=;
 b=m6mT0WUkPg0jLRWurZLu2lew1Itp5sM0v+B59GG0WgSobYW9UVZzgvIz8tjCkiNp72
 jChvN9qkTisrE226/o/n0D0GxDC+eBGFUz6R4A5IbC8xQ3qjkyjhxO0svaJKCjdsZ0YB
 F1hNNZpzh/fYS/k5qpoflyJHnHUxYLAcNae0Jb95l7XZInrm15i2+SdmTUZmfUKwnR/c
 JEsRTQN9f7Rmd45GTpmujjaA1L1RBXhIXbHeHL7U84t8urLuF/u4fe48jZfrf1yR3sBj
 pj8knmYgmKU84jnXRrTeO2VnPu9M2UlPy58HCEoOUgAlclNVHF1oR3Hc7jmBnwI79vEh
 R3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759236480; x=1759841280;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=82UkVI7TJlozsVBRZvbBpW12F0wp+jTBcojgg+J4n2A=;
 b=uBfoK14HqXGmoKx3zNweANlDQz2HSKWQmFg7+q/Rx0bvW8fKtiSrMEwFtuxGxr8RAU
 x3vedW7i3+o9TentD/SSbj1IrDrZgSXioeELs5qr+bMG7/L6xmvf6MZ2wC5lbZ9MeUPN
 XTCCr/wvSxmukxylInHAUfUNyEQc0RGQ/p8MYz1fM48sbC4I+4s9JVi9E2ob8uLNycdx
 vnR7kyLwRknaWiyvVNke+dPYW3KxdJ5kx77qhOO8CgWdQoMsrOZ9yC8LIjcPvGXMHhpn
 GYzek/Ms/kwmzu7EUlaoy3Tf+eB+JWVVvfftgLft2gwFhD8tRxupHkB2K4Pmjbh9K2IO
 PntQ==
X-Gm-Message-State: AOJu0YzmHMRackzlmvA9gyQMxisO6EkZIlTgyHBzzVBCbINOSiFQQ4wz
 KSL6uTXIskn7Lb+FgK5/9xixOIS8CslaZGkU/86Ufz0XnYjyu/1XFD+X7ccxdtJZhCvioKBMXjv
 1R6wXk5Q=
X-Gm-Gg: ASbGncs2mb4d4NSEcqVQDvo2+4KDuoMRc126r++prr4pwHzgUFTXjNB+yI38sJqjZRD
 +dJpXOSYfOZt1fvg4+fHm1+4x/liil93MkyVKrs9jotSaKTwNy+gUuFRky0oWNx9Ha5V+vnKT7w
 USaJUH2mThK+X4RgCEDEZnJIj/PPAJ5u5+p/sL7YHXLVOpcCXSaAWyDY127P+N/PdtUfedflBwH
 KsmvofkJeiBzofscld/+Bqc45L7DebRQ0ti1qRJsM8b+edHbLrPfckff2yMzlr2ggm4+FFUP7GA
 p3pP9UVUTj1rKJdCK1l/qaSPF3aDqFlCAMS8qLIuwLQMaEtUwlaZk4b7nWknEUedpyxhH3q0GtC
 CbFAXKPnYSXQ+ia3LkP9FGUD5EON8zdKj3Lp6fg3g+ENRo4WmP86lytsUiU5jdi4cPg1ppH8XKl
 XymA==
X-Google-Smtp-Source: AGHT+IHiWFueaZFceI3RKgNBGXp91L7CNo/MFuFNyHgOZLHhw9W/mw/199po5Xe5RAk+K3qoFSZ3EA==
X-Received: by 2002:a05:600c:755:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-46e32a30192mr120968045e9.19.1759236480383; 
 Tue, 30 Sep 2025 05:48:00 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31e97sm269440585e9.14.2025.09.30.05.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 05:48:00 -0700 (PDT)
Message-ID: <8030c76a-e70b-4be6-aba9-86fc93c26e9f@linaro.org>
Date: Tue, 30 Sep 2025 14:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20250930
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

The following changes since commit a239b0b0b6dbe6a168969b8cd6e600cf85db278d:

  Add symlink from gpl-2.0.txt to a COPYING file (2025-09-29 11:56:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250930

for you to fetch changes up to b2217c935e3f30d15821b1c5183ab4dd4c9d9dd2:

  net: lwip: ensure alignment of packet buffers (2025-09-30 13:08:38 +0200)

----------------------------------------------------------------
Pull request net-20250930

net-common:
- DesignWare: avoid regulator enable failure
- Fix RMII help text

net-lwip:
- Ensure alignment of packet buffers
- Use NTP server(s) obtained from DHCP

----------------------------------------------------------------
Ben Wolsieffer (1):
      net: designware: avoid regulator enable failure

Jerome Forissier (3):
      net: lwip: enable debug traces for SNTP when CONFIG_LWIP_DEBUG is set
      net: lwip: dhcp: make NTP servers usable by the sntp command
      net: lwip: dhcp: set ntpserverip environment variable

Tim Harvey (1):
      net: lwip: ensure alignment of packet buffers

Yegor Yefremov (1):
      net: fix RMII help text

 drivers/net/Kconfig        |  2 +-
 drivers/net/designware.c   |  2 +-
 lib/lwip/u-boot/lwipopts.h |  1 +
 net/lwip/dhcp.c            | 14 ++++++++++++++
 net/lwip/net-lwip.c        |  4 +++-
 5 files changed, 20 insertions(+), 3 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/27771

Thanks,
-- 
Jerome
