Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C06C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 09:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2142086F64;
	Thu,  7 Dec 2023 10:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D440oJZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E4E8721C; Thu,  7 Dec 2023 10:19:03 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D11686F40
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 10:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c19467a63so8184285e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 01:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701940740; x=1702545540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+bcIVKkY5stwZBcSeRYwiMKOqKU1JfXmy5ROkQS3Wz4=;
 b=D440oJZc5UfUY4fxtrUgeK4DSPBzNt+ESrojNRmkPQwMrLwOWF6P10+ldhc1evCcJB
 UI3gd8T7+42I8ufWpOwUTjDy/+wxZHV4wqsYN78wsFbDwikRhecKg5VRcWEIplI9sofJ
 019o/9vKJcmt/hupjOc1md1xX4gidlLElYJrN783OwNSMsQzNYurAqs5j/rWOiRoUfkd
 XMeZKlrCFQBgiWIJU78V/ePQtP5v8iJtEnOyCUPBYGuGrp0JUv+kyErU9eGlYxd9ZARo
 hIORPrLvHWzJgAK/9G/f6lPnaTVmilcP7BY1CsvqNNfUZTphgmr0Efu/8WVCl6Q/sBA7
 j2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940740; x=1702545540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bcIVKkY5stwZBcSeRYwiMKOqKU1JfXmy5ROkQS3Wz4=;
 b=A/nLGbDjujaJ2UQsc0Il2Cn5OfvIyFWVENc1KT1lT3A9pNz8nZCDl1UxryRaHNapex
 K//2sPMlSr5rt2oPUbc2FcYYjWy3p88FuittoHAjVwhvKgqD5baD/OTAn+jbMyk8gBqv
 MUIZNe8FuwjtnAAe8DqBc7dWQGTIN/cn5dQgS2XKLabJlABdTnayBrLDO5Pni6KhgZhb
 71hg/CB7u8ClNNG7Oyw+w3f9SNDmi1GvXkgfkpB8rT7VszB442il+tt9j3Z+h9AknmJA
 5Wj6YkQ/4GSwlvJHjuvSeAoRLaeBbWiubXTWIMwhJ3W3TnFGHdevaWmgOIqedw412f3X
 XsFw==
X-Gm-Message-State: AOJu0YwBlh8OSHo2EZwsJXTRwVZFqg6mFWO6CERJEEasPDB4bXvaxqjR
 FiJY2BAra/8JEvomggYMQ1T7dw==
X-Google-Smtp-Source: AGHT+IGN5/7te+fbkANJ/Qya45dLQFfvwyXcJ4lun5GiX85xohFArgfaGS1Xlzuc+ipSRMunXRh2VA==
X-Received: by 2002:a05:600c:3103:b0:40b:5e21:ec15 with SMTP id
 g3-20020a05600c310300b0040b5e21ec15mr1354383wmo.71.1701940740246; 
 Thu, 07 Dec 2023 01:19:00 -0800 (PST)
Received: from localhost.localdomain (ppp046103111243.access.hol.gr.
 [46.103.111.243]) by smtp.gmail.com with ESMTPSA id
 u21-20020a05600c139500b00405d9a950a2sm1299003wmf.28.2023.12.07.01.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 01:18:59 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 0/2 v3] Provide a fallback to smbios tables
Date: Thu,  7 Dec 2023 11:18:48 +0200
Message-Id: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Hi,

This is v3 of the smbios series [0].
v3 has a bigger cleanup in the existing smbios code, folding in
smbios_add_string() that were sprinkled around  to smbios_add_prop().

The latter is now the only caller of smbios_add_string().

Simon asked for a selftest which makes sense, but we plan to refactor some
of the smbios creation code anyway. I am happy to add tests once we do that

I've also removed the r-b tags from Peter and Tom, since some of the code
they reviewed changed.

[0] https://lore.kernel.org/u-boot/20231127171058.165777-1-ilias.apalodimas@linaro.org/
Ilias Apalodimas (2):
  smbios: Simplify reporting of unknown values
  smbios: Fallback to the default DT if sysinfo nodes are missing

 lib/smbios.c | 163 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 122 insertions(+), 41 deletions(-)

--
2.40.1

