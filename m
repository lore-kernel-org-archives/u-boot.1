Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D68C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E47E82DE7;
	Wed, 21 May 2025 11:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i3fkL9Dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996F682D6C; Wed, 21 May 2025 11:08:28 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537ED82D2B
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601968db16bso2384196a12.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747818506; x=1748423306; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:content-language:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0xsCINiDpC2pirzX/J7kPudLcbb9wjvAXsqae8Ok5U=;
 b=i3fkL9DjIt7p85Yl3BWRaucRXT2tsbtI284uQ2eOPZNd1Cydg9/fa8PIgHsZLu4a9c
 HbRzxkVz1wa8EBUUjtti9MqpJliLEQzvZa7ea5/XlYJxt04fl0xYSvwas3T56c6u8Zj7
 /RfUdFeTsf/rdskTxSr5y0jja3eI8rPovfPLkeGC5qC9s29fJjMvE/eZZQJzOrXpuxb2
 IJH42n/YLeitVxIqiE4FLacQ3GDNZD1Vg5HjUgCzPxDesRcQyTsAM+hMQ9zkZvkzIHsZ
 GH6SUdQ+l5/PPflqAYFk078LfztYgmHdScvlOlsX1kfhZmIA4VPQP5zfuXoeSHcr374o
 h9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747818506; x=1748423306;
 h=content-transfer-encoding:cc:to:content-language:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f0xsCINiDpC2pirzX/J7kPudLcbb9wjvAXsqae8Ok5U=;
 b=taj2m23gwIgm2MeVKIhpikgAYbeHPqtpTEpGbsgMuxf17mN0HongoaY8RBkz/2W+A0
 AT5W2JirFYl1043aWB3UA/SQOubaOlpMtuDe5I09c2gJB06V9TU0uiiiOFZcyTviAaVk
 rp1IBI6lZn1txLthUYfFW9DpRa0qnhX4DTWXSw1CilnBwz2imK76avZa+ldDXmarGj1q
 +81ZnGAh00qQMbbM/urBcaV5KG0igg5oq3TK5cyXyKG1s7cSSGXhOJW/tp8Z2xHG1h6g
 mPpRy+MHSKJ4XtJx5R8vdjUNEJF8bMG0XygbzFutDHHBIewmWjvgiFz4E2y2Kt1y8X91
 TyxQ==
X-Gm-Message-State: AOJu0Yys9xWw1It7KXWv0dRGugdjZBaH4pDemzpsouV7h5396CVTUd1R
 j9j1sPKH3jlZha7iGQ/Y9GWJjG0LYq4lnKTdylvclV5RBnQOkg5+I4+SxExERAMYAHX3m2MExlE
 tUS2QlTM=
X-Gm-Gg: ASbGncvzJ22ZcqkxcyUQeR289CiwvJkkGfIco7ozatWOIsiHNtcOV23YQjMSW0z3Ap+
 I2cB3wMnteo5iaBRcpwOp3BTwesUGObIMxNnoC2YfuUFlyEq6S7Rh5dw09xFP4R1tTYjf37Zbw0
 v68lEpm152NZjJ9n01yVQ1DflEAptZbGhrbqLbiw4UmpT8RDg88KtEma6ea14ijQCwm8u8a5OdD
 uQjVvaOurS8JdVBThPRpX8X73ppgByDYrp1NQANYr1Fu91eSRIu4w9cZmifXHaDoYK23vVNkXl4
 rcCbvpVYLQIJep8/yF+ym6Vset8NBM0Hn3oBwgWNkdrEYxhjG5ucdgrK5oP+Qg==
X-Google-Smtp-Source: AGHT+IHZjkMImJ/aPXMGul4JMCJzcz443/SWnAii/Y2qgbRUKcxtbZipubOsg8E45wjrWZyXaYvSIw==
X-Received: by 2002:a17:907:97c6:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ad52d5174e6mr1856956866b.36.1747818505727; 
 Wed, 21 May 2025 02:08:25 -0700 (PDT)
Received: from [10.5.0.2] ([176.223.172.184]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4382e2sm872985766b.107.2025.05.21.02.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 02:08:25 -0700 (PDT)
Message-ID: <4ec1ca88-d52d-48a7-a883-acb84add4f1b@linaro.org>
Date: Wed, 21 May 2025 11:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20250520
Content-Language: en-US
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

The following changes since commit eeb5ff1a468b2303efa9deb2483b5edbebb568c6:

  Merge tag 'efi-2025-07-rc3-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-05-18 08:06:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250520

for you to fetch changes up to 722e41ad9931bf6f327a66b5f8ec0dadfb32e0f3:

  net: lwip: tftp: time out if there is no reply from server (2025-05-20 15:43:09 +0200)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26247

Thanks,
-- 
Jerome

----------------------------------------------------------------
Pull request net-20250520.

net, net-lwip:
- Remove wget console output when called by EFI

net-lwip:
- Add 10 s timeout to TFTP
- Add LMB buffer checks

----------------------------------------------------------------
Jerome Forissier (5):
      net-lwip: change static function wget_loop() to be wget_do_request()
      net, net-lwip: wget: suppress console output when called by EFI
      net-lwip: wget: add LMB and buffer checks
      net-lwip: tftp: add LMB and buffer checks
      net: lwip: tftp: time out if there is no reply from server

 doc/usage/cmd/wget.rst                             |   2 +-
 include/net-common.h                               |   2 +
 lib/efi_loader/efi_net.c                           |   2 +-
 .../lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c    |   8 +-
 net/lwip/tftp.c                                    |  71 ++++++++++--
 net/lwip/wget.c                                    | 122 +++++++++++++++------
 net/wget.c                                         |  23 +++-
 7 files changed, 175 insertions(+), 55 deletions(-)
