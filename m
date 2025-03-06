Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0684FC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83163812D9;
	Thu,  6 Mar 2025 15:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AhfW4ewX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5304812D9; Thu,  6 Mar 2025 15:25:57 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB17B808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so8199815e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271155; x=1741875955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5iQqo2S+fZYTt972q3EZ74DKC9t1fUDrgzhAysgRvao=;
 b=AhfW4ewXINyDwK8BrzE/4vE+M/CfBUiKsXHbDyB76kvAUToSScoLrFS8lGwhhmUzG8
 SSD1eqPo8+/M8EXB5V3BwS4TmKIOYY/BaxVvaUWdlWx0i2ykF4DRzFLrEGnlOFMluf2/
 zQJiiq637/6t3UtDz6Q17sjQV6kUxWmRtjsEjyPLZt9djzhjvM2s2dN7yUL+w+Fvr8ly
 GP6E5onQ79UKJvuwOdPcWZNDeWvtVrxgR8h1U6otR3YkUI9hD3VMPYAR009cQ7IO6EKu
 FcXGLmDQ0XZhTQIPlFReQc2bf0biYKrIKsa7rJHi6OHMX9OewFQFbCRgIViizmtpgZZ6
 eQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271155; x=1741875955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iQqo2S+fZYTt972q3EZ74DKC9t1fUDrgzhAysgRvao=;
 b=k7m8UQnZxRvaq/Mm0UkYaL7Yu3P8RLm2RJ5Ct/uEiH3IkvgpVvf4HrKoTWrUg9MGOz
 fSg5W/4dG+zwQV27GjNWm2RPcGHHMTjRlMHqMeeiu6PLboceZsZ/TxgwbtxflYXwqBtm
 fVzLneKORjL+7qm2AUTBO0AvIAIW0TsSqTqAc6qrUFNREOPEahGmqRW2qr8wXV7zAXG+
 +hthaTQCMdC39XIWAnN3BAytfTJnqXw685XBXOlRAW2fcfrTWwUGyNtNArVeNOXzwH+q
 uVlBfUTR9pq7jLNbqtSQfXED1xJ3r+Y4F6G/EGYV8xlzC3iQthhS7N7SKzQ2zd81pxy+
 ZxkA==
X-Gm-Message-State: AOJu0YwRNyFmUgBLowhgSxex5Rah4wVbiwLdmH2BbCCGEnk4MUPoqtBB
 nZVZr+sqzpZllOrhM2td9Oo/LmrHeW0Ty6cHUP83woJoVNVrbVA1lK4ALWgQbSjtOqptzMeVw8m
 h
X-Gm-Gg: ASbGncstL4OSbI7olGFxobIguiZFPlDe6RkK5tc3aiBskOjeNAqeJ3FhNlWVkrGScSB
 IQ1YGnw11uJrRnu8akEWBPGwIMCQ+dEqi2HKUXXus8vo5r0W4bk4QF1qqKh+suqxloICuVWQRZG
 avgvOjPZpqeT/RjGawaManOnyyc0y74HQudNQidOAWgGy7QPDImhbTxKeoropyDrGKoVL3qbMNa
 BOaLuD7dPA73Fol0T8dyzooU5QCugf9uS0pRalho7XutUgAonYDxN9OyIViB1WR/DjD475A9o/w
 qq+9fGJ6PstGONw+igsGFI60xv8ZmAqtIB2yTb5FXgxvWczkz8iy3Q==
X-Google-Smtp-Source: AGHT+IFz3jON7/QvUDwPUwumJJxTAEs27Z7KqRGGZNt/7fKNaqx3rM0FFfZ5uhVQJUvMygDiLwwE3A==
X-Received: by 2002:a5d:64cf:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-3911f7ae0ecmr7571760f8f.37.1741271154905; 
 Thu, 06 Mar 2025 06:25:54 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm2181543f8f.26.2025.03.06.06.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:25:54 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/3] net: lwip: map struct udevice to struct netif
Date: Thu,  6 Mar 2025 15:25:18 +0100
Message-ID: <20250306142525.3079189-1-jerome.forissier@linaro.org>
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

This is a small NET_LWIP cleanup. Instead of re-creating a struct netif
from a struct udevice every time a nework operation is requested (dhcp,
ping, etc.), store the netif inside the udevice.

No functional change is expected, but the behavior of the network stack
might change a bit since not removing the device may have impacts on
various states in the stack (the ARP cache for instance).

Jerome Forissier (3):
  dm: core: add 'netif' field to struct udevice for NET_LWIP
  net: lwip: save struct netif in struct udevice
  net: lwip: remove net_lwip_remove_netif()

 include/dm/device.h |  5 +++++
 include/net-lwip.h  |  5 ++---
 net/lwip/dhcp.c     |  7 ++-----
 net/lwip/dns.c      |  5 +----
 net/lwip/net-lwip.c | 25 +++++++++++--------------
 net/lwip/ping.c     |  8 ++------
 net/lwip/tftp.c     |  5 +----
 net/lwip/wget.c     |  9 ++-------
 8 files changed, 26 insertions(+), 43 deletions(-)

-- 
2.43.0

