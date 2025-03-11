Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1DFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2B6807D7;
	Tue, 11 Mar 2025 15:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PbNHANpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB751811C1; Tue, 11 Mar 2025 15:29:57 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AD1801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so4793355f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741703395; x=1742308195; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mob+1RBvg0CJBVjKEasJXCwbjwW/FaCzsMBwgcwFp2E=;
 b=PbNHANpSG8WGHBEuJv6+cDxq2Md0IozEds30xLVsxBwOnJ4FU7LcKYppJjpDSM4f4D
 bSJ5MYL1UpIvhjF2x89T7q9+yd4KSq+gmD9flHgWFa0UWOOPswCazgk6rIKHEHbumc+H
 2dNtLfOv3HYy8L0CxLwDuc1Ox+qoGaACssnQ7TZCercELl1ZOgcJaDvKVZdzOj/VNlu8
 HAmG+v+Pl0CZIGD80Y2qp3vSVk/t0B0ccHX+GwRkuItyByl31UiMRxTmvPizYjuJC7f5
 Knq5E5hUX1PehD8m4TUuJQOyMq7BIonlTqiUUIlh+xj0AK8P3euAnK+GUXiA50B8UtZt
 y8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741703395; x=1742308195;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mob+1RBvg0CJBVjKEasJXCwbjwW/FaCzsMBwgcwFp2E=;
 b=kcpRk7IvdBE8IdOcPRG+nCjPRE9r84NiohGSrv99QPcBT7rtH7pJOGD69o43LXvOju
 xPswlQekJqOR/+lHMQGJNhhLqhwJazQWylyofFyanuhPxK3o020v1RIVA54EFve4wf2i
 RyaBykJjbH/JR9WcZJQwDoGRRaQPL5DFQxrutBvjTlaRcvUebuqnqtLmLmnJwU/qONvO
 v7qMFup3/ghuThOsJOQk2U+iVeL+3//Gu/C9E1sfoTuvHTTyt9i3JAYW+LBAoHDBPhHT
 BMN05g4gGwePT6HAD+tsIvj4QPN4F6hWH5JEVDsr7dbvrfS86Nxn2t6pNFYGN1VU51KY
 hg8Q==
X-Gm-Message-State: AOJu0YzbtK4gaFIYgjVDdFdB4Wxu29Q2JvOV+FOtnhtGxF/3PhgMkhxk
 ijo6QQUdVhJrprYTwlFELrTehjYGrH3NzDmvKAgNbVF2QfmSZSoq07SVYluUWxo=
X-Gm-Gg: ASbGncuSQanLm5CWeGD/RV/zDEUmQ1tONU4g6I7gy08ez2VtoLbn3TYuRv9A4Dn4w8V
 Z1i1Ccb/bgRdVexWeS8RJug523jIxOti8+0KFje1QRs8MXpyjL6NqDIf0KLP9XTCi2iMAHfw2GY
 qe7ZI8Hvg4o0ZKdFNLv/V7LvEqtjuOiNojNgDZVNIS1rmtOZJ6fAIiUHDM+G+hZrMFgFG1IMTLO
 9Xxw3FfqgRY7NtJNvXZFCp/c8pL5rbF7sy6lGtDtcjX2qd34EHZ3rtB7TvhOr49SqFIzVWy92QQ
 yrDIbZI0GdHZZ/3zZz8DGqDl2MiPzPqRqberb4+JjcmSM1N/SgSWj38=
X-Google-Smtp-Source: AGHT+IFU6qgNkUUt6Tfpj9HspRoowuLqGPdo1p5tCOZTmgAdrcK+nK+lArfgVAeKrSERNIckKh+KEw==
X-Received: by 2002:a5d:5f8f:0:b0:38f:39e5:6b5d with SMTP id
 ffacd0b85a97d-39132dbb269mr16190917f8f.44.1741703394620; 
 Tue, 11 Mar 2025 07:29:54 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1d67sm18278861f8f.74.2025.03.11.07.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 07:29:54 -0700 (PDT)
Message-ID: <21159101-d1f3-4a72-b065-e4e0de3609c8@linaro.org>
Date: Tue, 11 Mar 2025 15:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-next-20250310
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

The following changes since commit 1b42f57ec82ceba4d5f08cfb359717232301cfa5:

  Merge tag 'v2025.04-rc4' into next (2025-03-10 20:18:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20250310

for you to fetch changes up to 22f3c9cd024459887066c6d82fab8766447cc289:

  configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT (2025-03-11 14:16:03 +0100)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25084

This is mainly about adding support for root certificates, which brings proper
authentication to HTTPS and makes it secure at last. As you can see from the small
size of the patches, this is mostly trivial and is a benefit of using lwIP and
MBed TLS, as expected.

Thanks,
-- 
Jerome

----------------------------------------------------------------
Pull request net-next-20250310.

net-lwip:
* Add support for CA (root) certificates to HTTPS
* Add CONFIG_LWIP_DEBUG_RXTX to trace in/out messages

----------------------------------------------------------------
Jerome Forissier (8):
      net: lwip: rename linkoutput() as net_lwip_tx()
      net: lwip: add CONFIG_LWIP_DEBUG_RXTX
      net: lwip: extend wget to support CA (root) certificates
      lwip: tls: enforce checking of server certificates based on CA availability
      lwip: tls: warn when no CA exists amd log certificate validation errors
      net: lwip: add support for built-in root certificates
      doc: cmd: wget: document cacert subcommand
      configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT

 cmd/Kconfig                                        |  22 ++++
 cmd/net-lwip.c                                     |  21 ++-
 configs/qemu_arm64_lwip_defconfig                  |   1 +
 doc/usage/cmd/wget.rst                             |  82 +++++++++++-
 .../lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c    |   9 +-
 .../src/include/lwip/apps/altcp_tls_mbedtls_opts.h |   6 -
 net/lwip/Kconfig                                   |   6 +
 net/lwip/Makefile                                  |   6 +
 net/lwip/net-lwip.c                                |  18 ++-
 net/lwip/wget.c                                    | 141 ++++++++++++++++++++-
 10 files changed, 295 insertions(+), 17 deletions(-)
