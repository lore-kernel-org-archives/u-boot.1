Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72803C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E94B808AF;
	Sun,  8 Jun 2025 09:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Lv4ISABN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10DB80FA8; Sun,  8 Jun 2025 09:42:38 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0D6807B1
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EBBD7446FF
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749368555;
 bh=CHbnIdVV0gojHl/zHzkShAAd7H51aKYaq8k5gvN7dJg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Lv4ISABNSE4QX3sKPT7T/fAKBOxZ7Rs3ZKbOSIaDxyrtbTtDfdjX025HyR6ClskPX
 aSUBJzL3q8KcCnb/oZmmODczBe6ukCdWAcHKi30NVZtoizeY/Xo+JiHgyGu7VSU3zS
 u2PsNRj3lIvZCWsSdG/LZWqtFCUY0+3dXvI95NSI6+zWQJPd3cBv5nD3833khRDvrt
 V3LTMeheDvNMfXWZNyWVnUzjtlT4D/hSIeYswOKsJJcg64L334x6boq7ku/1io+qjf
 q32hbbOFLyLy5vNFRSFZVyHa/V42K6hDdV1OqR4JJrz0Hkm9sSiac2BJzu/KU3yJbm
 1U6VkVJhq3OXw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso2064962f8f.0
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749368555; x=1749973355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHbnIdVV0gojHl/zHzkShAAd7H51aKYaq8k5gvN7dJg=;
 b=Gg5KYKjb72SdmcV7xQPx8ZiGITeREg+j5VAZaqfLrUeklEF1yzS7ZVJv7gqI0+gPNs
 AwuREF7bM4cgIMpCKPQ95c39fjxZHvQFOaAhnYp1wu7VxkLo2KWYQEKsEk66McIdqUk9
 qvLbRMffwLLRORLUXUxaab3IDW9VtJG19j7rN/TYv7bOfgpY6KP1YtT3/fIwrTnLS0s7
 Au40+SuwcCignKyIIpEvZe5xek3PXN5418ClYDzHLGbdCPMWVoav/R2KjVEIIpCvfoTd
 PO0u9OQKGZfFTvh6Xlawop7VRstw4TEmvbGu8qlFaRK8QMzMhYtAFreghCMe1qE2DmIy
 xtog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8HXq1kUOmVkuAbFDrc1KOb3jEKXdtLDDM5IEz+a2L3eqMYPaQI4vobKxJmNuISQO5TPk+1xo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ8GkVlUVoREVKNbbbeK+1qrG67aW5hRG4iMx5EpFuUEggwD60
 ssCJUlbXjhlZA0FSMFITZJQpw0CYaG9m/Nr8hBQXIPk7GT746I772GCizKbAa2DGMQ1oVUgtd2g
 YeIW47bTCj5roOXTwllb4PbOOyx7XJ72g7edPVZOyecAaoJS0AS1sfCQIIjKhf8k6f4Y/Xdc=
X-Gm-Gg: ASbGnctp+mdmhrO4GapfDIfMLbbdtbxDavmib/WiJ5/Cz2zIayRCfS54p5gYBb6YoR2
 8+heLJ1GPJTIz5qPIEghi0HxBbwOW+BX1ZHrwLWEdZoI23jUUT4UguFkvWfT90HBCW0665N4Cv0
 YFVNi3an5S8OZ0oxIh0JhEy2RNy4uD1xRkcowRAj3wY+MBRXPhnGh7RdERcfv5JdT9TM3zgTd2j
 HME3qE+QT1IZN+YYZeU0xo/b6csd3y/Cd0iPSNPvpFlIP4FDJvtVnGLCa81s4z/HgAP6B1Ejh7z
 8EZXoc8tV3nBvVZn0hWi0oi1yNSRHYWdLq4d9rDcDW3e9+EjGSIAL65ae/RWbuvWSrCsmOtg/np
 N7iZ36Dyszt5DQdJjTIJjc46q
X-Received: by 2002:a5d:64e7:0:b0:3a4:dc3b:5a3b with SMTP id
 ffacd0b85a97d-3a526dcdd79mr11463093f8f.10.1749368554651; 
 Sun, 08 Jun 2025 00:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVwjYc4Q7eKntlysX3xPp9LOr/oFHFHB0tN7ivwkOZId1+pdEQXaYmTK3sCN90Qc9wdqmo0Q==
X-Received: by 2002:a5d:64e7:0:b0:3a4:dc3b:5a3b with SMTP id
 ffacd0b85a97d-3a526dcdd79mr11463071f8f.10.1749368554290; 
 Sun, 08 Jun 2025 00:42:34 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6c6csm78285635e9.2.2025.06.08.00.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:42:32 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/3] net: consolidate PXE processor architecture type
 Kconfig
Date: Sun,  8 Jun 2025 09:42:25 +0200
Message-ID: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

DHCP and DHCPv6 use the same value defined in
https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
to encode the processor architecture type. We should only use a single
Kconfig symbol for both protocols.

Furthermore we should make the value customizable. This allows for instance
to choose between "x86 BIOS" or "x64 UEFI".

As "x86 BIOS" is encoded as 0, we should not use this value to switch
off transmission of the DHCP option. Use 0xFF instead.

Add a missing include for verdin-am62p.

v2:
	drop change in board/toradex/verdin-am62p/verdin-am62p.c

Heinrich Schuchardt (3):
  verdin-am62p: include linux/sizes.h
  cmd: remove duplicate DHCPv6 Kconfig definitions
  net: consolidate PXE processor architecture type Kconfig

 cmd/Kconfig                    | 45 ++++++++++++----------------------
 include/configs/verdin-am62p.h |  2 ++
 net/bootp.c                    |  6 ++---
 net/dhcpv6.c                   |  6 ++---
 4 files changed, 24 insertions(+), 35 deletions(-)

-- 
2.48.1

