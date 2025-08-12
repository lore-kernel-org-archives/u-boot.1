Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4E4CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDCF83526;
	Tue, 12 Aug 2025 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vHIR6dsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291C08341A; Tue, 12 Aug 2025 14:43:56 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC73834B6
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so49418395e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755002633; x=1755607433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9pCu2CoQaahv8bBIqFJPXxCVDnCn7evJjk8WDdRglTQ=;
 b=vHIR6dsJk2t2bqzioTP0cg2BdU/R+tqieHkpdGtn+N2ZUu1WwWZ7ha71WiTDI5ddj0
 skSHz187H8tehLqHhY5TU9AF82OHKnpH1yil/OD2nGlZ4lNqpIilUEwTQnCj8g7Y0tMa
 /CdK5MS5H0lsgVRN/hcliP/DjRgH8jdYFKefRv36CWJRkSm1A3B+JpdiMx+orwhV1f7J
 ZZBO2JylyBE332298xUBM4im9kdubEFXFF+Ptsz3hxt2pDdi3eZ980KPA2/jW0PkGwoW
 Z0I36QDLxpY2ylJn28tdBNTZAvzCKc4GnZbJC6/dBVZZSbErO38kvixQ51H/luBiOqaF
 ovkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002633; x=1755607433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9pCu2CoQaahv8bBIqFJPXxCVDnCn7evJjk8WDdRglTQ=;
 b=ABBD2nCdmqkrWDF0P5eTOmj48hvlWthCEJ1R4uGrORvpJ87mx8rFm2k6ylH/VdDI+7
 q4XOFf3GOX+6Sr5eD1EmHlw3/Mswa/nQY9aBu6P0J02EmaIvPfguZfM+baojUDQ80FyZ
 466pIuk2Ogpil6DtcylVFnOFoo8cdu4DdIUaq8Pb1wbk0ZNKMSDKWBWM+F3+pJL+pBgs
 46sy15MNfe9Slkc5K4P4jPzpOiQp5yYY3JrYLB9PEO6SCWf2su4epky22PfE8NoQXed9
 BSpWBzQ0QW3+Cuu6bqnzrKAQFVLFys9uPSIS6yAGMk4sjKqMtWgy/bmKUwTpFsHEgYqi
 beNw==
X-Gm-Message-State: AOJu0YzhUBROSwQ/34ARITYTvB4Q0D5tnaKH8mQUKP+K8Ns78vdAw7Do
 sZT1MDcYTDuj/dZ+XwoZCDeNYnCvlTGJoZJ6/q4xfFY0PrVW/Q0a8/wNpCNaZZzubYQMLG+WdIm
 +yMV8Tihl+Q==
X-Gm-Gg: ASbGncvlenRa0YBxCqJpDIcVFLhPWUHQlTD448hMElQVPJyuJ3DiwFuKgTHMYGb4V0h
 /6YQwchrEFDZEiPVSSUhIdPk45YX0QWV9fAA713EIrsOr2QuKapzaqoC1EnOoH0bq9RDXszs/2U
 b3Wsucg4MLXWhKoezGjNCuGrtCqmkAxyX9ACYtAPFdc1j5XnMzbUYY99TVeIB261AFHkDdn2kCe
 EaM7EXbKoUuyQXglIK39kUQcdWp708I0nWEDm6xXOnEm4s3JV44vOmNtmJcR7NvnhBn00CA9IMu
 SMCZArSqdLvwtKUCM1BPeo23AwVxDnsBGKJ+Y9Lz76HUY36YvebKCM0YH0jZbGZAUJ2+alN05Jg
 vVgT+8d9JOFmBdmBa50LxyiBSyzzncH0=
X-Google-Smtp-Source: AGHT+IH+OYZTrk9XzECE+FRofap3OEi/6NA+bk/kQA1KFHXRj2yo3dJKOkgXO8SG4SiVXbWkH5wAWA==
X-Received: by 2002:a05:600c:3b97:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45a11e79ac3mr21831415e9.2.1755002633066; 
 Tue, 12 Aug 2025 05:43:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6b34:4d0b:774a:130d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585430csm297745475e9.11.2025.08.12.05.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:43:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] lwip: add Kconfig to decode and print ICMP unreachable
 messages
Date: Tue, 12 Aug 2025 14:43:17 +0200
Message-ID: <20250812124331.1464879-1-jerome.forissier@linaro.org>
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

When using commands based on UDP such as tftp or sntp, if the server is
not reachable or the service is not started on the expected port then
the command ultimately times out. However it often happens that the server
or a router sends back an ICMP Destination Unreachable message. That can
help troubleshooting. Therefore, add support to the lwIP stack and to
U-Boot to handle those packets and print a diagnostic message on the
console.

Changes in v2:
- Fix typo in subject (s/detination/destination)
- Add link to upstream pull request

Jerome Forissier (2):
  lwip: icmp: allow reporting ICMP destination unreachable
  net: lwip: add Kconfig option to show ICMP unreachable errors

 lib/lwip/lwip/src/core/ipv4/icmp.c | 17 +++++++++----
 lib/lwip/u-boot/arch/cc.h          |  7 ++++++
 lib/lwip/u-boot/lwipopts.h         |  4 ++++
 net/lwip/Kconfig                   | 13 ++++++++++
 net/lwip/Makefile                  |  1 +
 net/lwip/icmp_unreach.c            | 38 ++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 net/lwip/icmp_unreach.c

-- 
2.43.0

base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
branch: lwip-icmp-unreach
