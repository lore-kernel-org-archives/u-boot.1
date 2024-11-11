Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F334D41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7442289394;
	Tue, 12 Nov 2024 03:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MTGEhzNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523D089390; Mon, 11 Nov 2024 22:09:11 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EC489397
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c693b68f5so50735105ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359347; x=1731964147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tskGRX/EyISPYXwDxoVvBJsjOZnxqvqbqrVpw9s8Zig=;
 b=MTGEhzNenQBcp+Vnv0JYhcQC8eunbGPWRce8nm2Mg/ZAG4BF42kr0b0lveO/68yp95
 UhLfgKTvoWYXzj3GCGyJI+vbif/tmzeqHK/fr1dVjdPOep/znzYEzTN7gHqypJxIDc+F
 170d2V+vxIv+nm4js4Ia3PN6bP+hfxW4MBQWH4GPNpaQBSMqim754sGf1yBkPZkqYZOm
 uNv8Zm4g9Kbyv0MSSpFBD928dN+VvXyawxvA8qdKUnSEUcDuG5rw5WBxTo4ihkM4ffXZ
 g+MS0cK6LhMkAyAW5wYk3Tm+odQHm8+0hmzdyHnxWH3thWsRLf+CPlejjxfAz+DYNF/I
 WAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359347; x=1731964147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tskGRX/EyISPYXwDxoVvBJsjOZnxqvqbqrVpw9s8Zig=;
 b=WLmn9ynP1HCWSkXzVnndKT1dQPwb6ldHPZh5eiJGdH8V+qVHvP4SsfcmpIXDgX+8Ix
 1O3JrB6i8lTcmBW9DKA73T52127iPb4eiW5G/rE0xFcKhEjBWpF1xhEYCkhewLtMzHwS
 PlDH3Tb1Vm2rnho0UrV6f3ArqiyETivXPci6excKcqZT3WwG1/SiaFrbtgqcsm+8pRgK
 Pjf78Z/bPMvGD5Idov4X7LwWRvfwGJZuQBfWdidFPafGBsmgZlPn7tR4OJk1YZO+2rf7
 Y2vAK7MkugOSoY5dXlgE8edXKHmnmwmhbS7hjwZ9KALu4dL3L3FONp/qf19RmTR4NE5M
 yRMg==
X-Gm-Message-State: AOJu0Yz606D1A8wirExGTIf0Kbaasp45crvPYOaX9rV6p3EhBv1ttpYh
 BUQDLPsxpGsbQ3fEgXvKAQL3zg6e2pK37n6kWpBD2U9A0aSe+jQ4hPZNJQXP
X-Google-Smtp-Source: AGHT+IEncjgC6L2hcnkbXWKn/ZARKhrFnvUFleLQHhp7bdLKHE80aBmrwVsbBcONZ73v+tGo7WRUuA==
X-Received: by 2002:a17:903:244f:b0:20b:7ec0:ee21 with SMTP id
 d9443c01a7336-2118352689emr210249515ad.19.1731359346929; 
 Mon, 11 Nov 2024 13:09:06 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:06 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 0/7] wget: Expose wget to applications
Date: Mon, 11 Nov 2024 18:08:54 -0300
Message-ID: <20241111210901.560691-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Currently the wget command is focused on downloading the next boot stage.
This series proposes to set wget as a general purpose HTTP request interface.
This series splits the wget code from the wget command and exposes wget HTTP
requests for applications to use. This comes in preparation for an efi HTTP 
driver.

This series proposes to expose wget via the following struct:

/**
 * struct wget_http_info - wget parameters
 * @method:		HTTP Method. Filled by client.
 * @status_code:	HTTP status code. Filled by wget.
 * @file_size:		download size. Filled by wget.
 * @buffer_size:	size of client-provided buffer. Filled by client.
 * @set_bootdev:	set boot device with download. Filled by client.
 * @check_buffer_size:	check download does not exceed buffer size.
 *			Filled by client.
 * @hdr_cont_len:	content length according to headers. Filled by wget
 * @headers:		buffer for headers. Filled by wget.
 */
struct wget_http_info {
	enum wget_http_method method;
	u32 status_code;
	ulong file_size;
	ulong buffer_size;
	bool set_bootdev;
	bool check_buffer_size;
	u32 hdr_cont_len;
	char *headers;
};

The client can then pass such struct to wget in a network stack 
agnostic way.


Adriano Cordova (7):
  net: Kconfig: add CONFIG_WGET symbol
  net: wget: add definition of struct wget_http_info
  net: wget: Add interface to issue wget_requests using wget_http_info
  net: wget: integrate struct wget_info into legacy wget code
  net: wget: make wget_with_dns return value compatible with its lwip
    version
  net/lwip: wget: put server_name and port into wget_ctx
  net/lwip: wget: integrate struct wget_info into wget code

 cmd/Kconfig          |  5 +--
 cmd/net.c            |  2 +
 include/net-common.h | 54 ++++++++++++++++++++++++-
 include/net-lwip.h   |  9 -----
 net/Kconfig          |  9 +++++
 net/Makefile         |  2 +-
 net/lwip/Makefile    |  2 +-
 net/lwip/wget.c      | 50 +++++++++++++++++++++---
 net/net-common.c     | 14 +++++++
 net/wget.c           | 93 +++++++++++++++++++++++++++++++++-----------
 10 files changed, 196 insertions(+), 44 deletions(-)

-- 
2.43.0

