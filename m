Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE948C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 07:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B02388938;
	Fri,  5 Jul 2024 09:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SHzAjYEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FA388934; Fri,  5 Jul 2024 09:20:00 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDEB88579
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 09:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so141442366b.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720163998; x=1720768798;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2dkxFQJzYnb+dgGS9iTvwMViIRrrTTItBM2tkRW6Jvs=;
 b=SHzAjYEsmRWo9aWSM5yOMWoaIaTPiTmeBWiiPcB5/CHJ0MzMjNlSs44IjWGHADj7FS
 FWzyDEzjdFAwlYYaZpj9CrFZ+S+NKxplHHIA5NnUWJmoE+PyP9NQQxy0yG8gkjpB2ptr
 vxr7u1OJHmpKhBZ4rzCgx8u+emBB/v2XMkXtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720163998; x=1720768798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2dkxFQJzYnb+dgGS9iTvwMViIRrrTTItBM2tkRW6Jvs=;
 b=DacxOUY7DuD0/NXkH8d5wfbpwnFVDLZPySYeHZ+TALwc7OJwybLyEwK13ECUHo89fm
 mhLRfq+u3ak7j4nxi11O+lGgyMW4V54WKqRcCz/p1VTuFaWVRxwcaTAQlV+BjmgyEan4
 mZ6uK2Vr4B1Tt8KHhu2bgW5/MLFsRaoo5jWCfwa5Y45+nLUKgtErLsCY4lGF080pdarq
 dDQN+ouPXVFS/xI3k/l8h0CdblouR+yMQnw6SEy+pVcG2craGaof89FE0jzb41sQ9hb0
 +vpDWgGC1zQ4xuTqkCavyOnY9l0MHb8qPJhKQQ/j81zdfdWCchjMnZb2ryLSIU2E6lFj
 YWNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1i3JHlS0bU0OLDb3raljmbQ5Qh4s7whzRaL03Cec+Pg9Xfj1CaI1PcpZRiKWjY+6PspIrRS5QOuqDPAlcROVj+JJ1ew==
X-Gm-Message-State: AOJu0Yy+GGq0Fbz4QPHVbN70C/qXnOm8NMWTS3BSKAvKj6DICQ9a0p//
 1t0SeO7tMUv1Zi9fDouxD4i44dEEAfJp2d5QDBT4Ok9DepQ/h6aDA7d4JenqadjUm+HuUDMWoPc
 ZGqY=
X-Google-Smtp-Source: AGHT+IE+kYWhF2CActpb/j0613WR4YIMh612Gci2J9dmbW9NmZpcXGDRCGuI626195kIDZmf9UgUhQ==
X-Received: by 2002:a17:907:60d3:b0:a72:8b89:f878 with SMTP id
 a640c23a62f3a-a77ba72d80amr321857766b.76.1720163997711; 
 Fri, 05 Jul 2024 00:19:57 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:a3e:4288:e106:2eef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b84d5sm655158066b.223.2024.07.05.00.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 00:19:57 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 0/2] Support imx8m composite mux
Date: Fri,  5 Jul 2024 09:19:50 +0200
Message-ID: <20240705071952.12245-1-michael@amarulasolutions.com>
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

The mux ops for i.MX8M composite clk needs to be specialized.
In order to reduce the code duplication we need to make public some
interface and write a specific function in the mux ops. Those patches
implement the behavior.

Addressed comment in V1

Michael Trimarchi (2):
  clk: clk-mux: Make public the clk_fetch_parent_index
  clk: imx: add mux ops for i.MX8M composite clk

 drivers/clk/clk-mux.c              |  5 ++--
 drivers/clk/imx/clk-composite-8m.c | 37 +++++++++++++++++++++++++++++-
 include/linux/clk-provider.h       |  1 +
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.43.0

