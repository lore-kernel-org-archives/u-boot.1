Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1F4D44D78
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2908891D7;
	Wed,  6 Nov 2024 15:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4qOMBv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62121891D1; Wed,  6 Nov 2024 13:47:45 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6935891B0
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 13:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso531220b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730897261; x=1731502061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkXYlqSznNckB1RfyyckBmBk42FQO8sMHyWNQuxHyoM=;
 b=U4qOMBv1FfMfmM0uwdzusQcSTxt7W1LLskO/8ijaTYgLjcwIL9gThSwWXVrCNj8hZB
 ozwIuGhqRfyeJKF78RPc7rDb5U3E2L//dBfhIScuZsIj9qvoO7xMC58tti/0gd7+rFhH
 nKeZ6xadXElTF0ItRk8uW0z2QYIqq8dAMDeW5mD+Il7H2sOuKjKHPMxRqzyQfyJXixrI
 0wxjZNgWHhsCWj0Ukixw18SqYpowJvGKApCVPlLWpxKttCtASoFKXAu6mQNbtevukDXd
 5ijwkU/hYTmAtJ4rmNqdbhaNdnkksmJO1JsfraDWQ7Y+ytkLxNR86sIKnepPtOjVupm+
 EG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730897261; x=1731502061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkXYlqSznNckB1RfyyckBmBk42FQO8sMHyWNQuxHyoM=;
 b=qc1p9+VW+tVPpqzhISrooIsZ99X9iHq1088ZCyankJ0sQ0wmk0zbRDBA/7NncvpCle
 eZPocSaxe5vbLTuevtuqy+q+5wQBpY4FhNbtaN5JRjnVR/MWjdaZhlzZmGXJv5ZPFxjf
 9+HXo5Va29lQWppB8b5MoiGwk2yKsL3MqGXs00UbNvFqP1sv2qmur0juPGyqG4bDv5uJ
 Y7ZXt1Ks6KIsRy5epZW1zs6JlZuS0SHitTLUeH564jS/QwObMro+IeyR8H4eP8DKZUON
 +dqmY3YdoZVQFA+ozc/QlacU7a46rMm3eeP5O+lc62WosWvl0gLLStw7mHL75fa2YMvK
 pbnw==
X-Gm-Message-State: AOJu0YxpOyEh0Y1MyeOqc2hjsJMfTbvSYwhXeKXp6S/xjk9o6c7MpJTg
 3Zsex9+KbD0g1sVCgyJk8zcTkE5nAVeSh5KXRJ5xjfLdKLXWA++NCbNli1FeHVI=
X-Google-Smtp-Source: AGHT+IEMsJ+FKZpYULxd5kknpsfT1iXg2fjVDuVo7HFwNf3r3RZ6rXlakpgfriZkVOmcMyVI738l5Q==
X-Received: by 2002:a05:6a20:9183:b0:1d9:15b2:83e with SMTP id
 adf61e73a8af0-1dc032e1a32mr3943700637.7.1730897261005; 
 Wed, 06 Nov 2024 04:47:41 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb57bsm11802650b3a.173.2024.11.06.04.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 04:47:40 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 0/7] wget: Expose wget to applications
Date: Wed,  6 Nov 2024 09:47:31 -0300
Message-ID: <20241106124731.209482-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

/*
*method:		Filled by client. Desired HTTP Method
*status_code:		Filled by wget. HTTP status code
*file_size:		Filled by wget. Download size
*buffer_size:		Filled by client. Size of client-provided buffer
*set_bootdev:		Filled by client. Set boot device with the next download
*check_buffer_size:	Filled by client. Check download does not exceed buffer size
*hdr_cont_len:		Filled by wget. Content length according to the HTTP headers
*headers:		Filled by wget. Client-provided buffer for headers
*/
struct wget_http_info {
	enum wget_http_method method;
	ulong status_code;
	ulong file_size;
	ulong buffer_size;
	bool set_bootdev; 
	bool check_buffer_size;
	u32 hdr_cont_len;
	char* headers;
};

extern struct wget_http_info wget_info;

The client can then set wget_info and call wget with wget_with_dns in a network stack 
agnostic way, providing the buffer and the uri as arguments.


Adriano Cordova (7):
  net: Kconfig: add CONFIG_WGET symbol
  net: wget: add definition of struct wget_http_info
  net: wget: Add a global struct wget_http_info
  net: wget: integrate struct wget_info into legacy wget code
  net: wget: make wget_with_dns return value compatible with its lwip
    version
  net/lwip: wget: put server_name and port into wget_ctx
  net/lwip: wget: integrate struct wget_info into wget code

 cmd/Kconfig          |  5 +--
 include/net-common.h | 29 ++++++++++++++
 net/Kconfig          |  8 ++++
 net/Makefile         |  2 +-
 net/lwip/Makefile    |  2 +-
 net/lwip/wget.c      | 47 ++++++++++++++++++++---
 net/net-common.c     | 10 +++++
 net/wget.c           | 91 +++++++++++++++++++++++++++++++++-----------
 8 files changed, 160 insertions(+), 34 deletions(-)

-- 
2.43.0

