Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BE1D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B2488DF1;
	Sat, 26 Oct 2024 09:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UiXbF0Ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991B988DF1; Sat, 26 Oct 2024 09:57:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EFC88D13
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c957d8bce2so1391798a12.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729929470; x=1730534270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+XARH5HSpG7w/stzXhdcMBKtYiFLu0MlOS9eE4iLoro=;
 b=UiXbF0Ds4yWFO2gbGtLS4LgiKZIS9X4W52tXTciqlgCIkX1sJafK60fDvDWrMEYGI8
 G6Wk3m3eGjK6ccVBkOncc31T9WUaup86HcmfOaD0789rJKn8OueqBwBm2u7RIxrXKVx7
 CV4Xnjc4eO/9qJq6IodiDN5ePSfNLkFsKPqU38zG8hMB/dele36yNwhJiEPAcB1Ejb7e
 cvLZs646Q3rB4aD/Gq4v5hlnl5jTMERj/W9bcyvn1Y6j1Mnvw0uX3QEINp6ex5hJTnuJ
 3ccZjMwmhlRMPKeF1YH2Cfs0ze4HGkfrh4MwSa8Yb/+bCpNE/3E1TctsRmPcHO6y2maB
 FRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729929470; x=1730534270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XARH5HSpG7w/stzXhdcMBKtYiFLu0MlOS9eE4iLoro=;
 b=GEkA7sGpWj8F5c8k/zEZKNE1cfDPxsYGEhIesGWRHHt4SyDLzqnQTMWInMcMsAY3hF
 VCPAFFcCXpe6jEfbt43s1z40ioYD4O0VqdVp7bFkWvCBo7UTnY3eJOJO+iZ49bShDNkl
 DpLtyadtzEHDQn3HnVF3yU49aR5Mn0y5JjExS7aRK8ff5hkjE5bjtVwfwg5WWAIiNy2u
 kjt1GaDvFmEjmvGXbb8LbpJlN6yNnyN2puq9D7FQPOczcFIGr4l1mgotVk4yZjqz7o0T
 Ek61wOSS130VBAg1iMYT1wfE+O/cSNoR9gZnOuxh1XdZeLJiKafYGLzDThHB20oIEShI
 ZYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRSvAgL2GK0WDtmSXr19ZU0hU6ypaRroU837ju+ej2MofV/7unJfS+Krmh8Pb9oftYAaU1+Yw=@lists.denx.de
X-Gm-Message-State: AOJu0YwVUnIVUHr4TJQ6QRbH+pgQmugapT/CvdPNkwkZeHnDbJ0Tn8qY
 ibOAWzYD6m6IN4tg2o/G7lRgzl2k7UbQQz34GQYwD2CrgfqZ3ZUSNeREHeOBW5c=
X-Google-Smtp-Source: AGHT+IGDcbkvBNlCwq6+hsgzk7SgmpvAVur5W5fJ6mMQMKTcUcVEtDzOOFgprNDcUuOUX+lGcmxAQQ==
X-Received: by 2002:a05:6402:1e93:b0:5c9:40f5:1518 with SMTP id
 4fb4d7f45d1cf-5cbbfafd4d9mr1718682a12.35.1729929470032; 
 Sat, 26 Oct 2024 00:57:50 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b31bc028asm151475066b.177.2024.10.26.00.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:57:48 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Mark static functions in smbiosdump
Date: Sat, 26 Oct 2024 10:57:41 +0300
Message-ID: <20241026075745.117832-1-ilias.apalodimas@linaro.org>
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

Mark functions that are only used locally as static and
quiesce W=1 warnings

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/smbiosdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 2f0b91a353d1..d7f2ba30a954 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -289,7 +289,7 @@ static void *get_config_table(const efi_guid_t *guid)
  * @len:	length of buffer
  * Return:	checksum
  */
-u8 checksum(void *buf, int len)
+static u8 checksum(void *buf, int len)
 {
 	u8 ret = 0;
 
@@ -304,7 +304,7 @@ u8 checksum(void *buf, int len)
  *
  * Return:	status code
  */
-efi_status_t do_check(void)
+static efi_status_t do_check(void)
 {
 	struct smbios3_entry *smbios3_anchor;
 	void *table, *table_end;
@@ -401,7 +401,7 @@ efi_status_t do_check(void)
  * @buf:	buffer to write
  * @size:	size of the buffer
  */
-efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
+static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
 {
 	efi_uintn_t ret;
 	struct efi_simple_file_system_protocol *file_system;
-- 
2.43.0

