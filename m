Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39423C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3242587A80;
	Thu, 25 Jan 2024 16:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UKsxoXt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A6587A80; Thu, 25 Jan 2024 16:54:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CBE8878CB
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA8B2404AC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198089;
 bh=z4uHYQIhRuc0FwuJZgCHGF0TZ+UMp8vyNkfFcH0H5RQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UKsxoXt2u807dfBTgrQYhpKgsLbdO9WcBkDf/U16aZhWbkYaZjAjRHl40zrMlUDCL
 PpYa/gxBSN6WbQLW48tzATUmPYSH2MOuRclLuiaaQZ6vd0hRgeRQbkrlTRomgN3b3J
 yxDa9hJZ5n1Besg4Y5YDINUMOz5jskru2Q/SAYed3mWvX1ZqQv/GoW1XLkESbyZNIq
 KkshmfTlqmvCcoAWNZCRuILj1W/7NQGIoQjB4GsZ65IV/TPJMH4NG1/sVlATgZyYcK
 WEFCKQsD3eicZxZ6PyDvep56v+voHtcclFgqpYwdw3i9sXEs8VopSs6VyQina0O+eA
 dJu98inxSuRdw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-337d589ef4dso4675516f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198089; x=1706802889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4uHYQIhRuc0FwuJZgCHGF0TZ+UMp8vyNkfFcH0H5RQ=;
 b=pLWOFS0xNj8cGNFJeO95f2j925KQBQ+ynTPwVH5qf5GwCCjyptNJO2iUfNLzGsVbfM
 TPpSdscDNu2VN1uqOyvkoP4m5JpLdYdFuYlIGQA4b4I+C+jMBVRQQdxRjAPCr1XPR8ZS
 3LmZ9yQ4Pc7tgS95nIa/RJOv8g8fNgzRLNu2dpVloUAiYINTnJ+w+y6Hq29af7xxzmAY
 Ie4ZLqrH2O4gub23N4NF56IOTOAnkyAAtRiDItAIRZ9ta75bOe+jXvYxRb3K+nrIrseY
 4gWC0GBWa5dGpdI4JMI6ixw3+BJ7jiJHerWTHOpfy2B0xa/BAS9wd+oulInlCMbyYCZF
 /tiw==
X-Gm-Message-State: AOJu0YxleIHw//XQdC9JZ36YJZm2NIULO1PmQIYQLIjcXf4eWzgYYS6T
 Nex3CEc4q2deGJCWZP/gjSKvZO8KKQRZK3/CdUtB5ayUZEUIg4LTSoBqZIeSP+peiqztCYp6CTc
 yszzIGJn3i/qFM/afe+7qBwsKiwGZvO+TFb/ljvNWlYOZPHkkaYpAq45cqzIa1NdOBnY=
X-Received: by 2002:adf:f548:0:b0:337:9d27:ae28 with SMTP id
 j8-20020adff548000000b003379d27ae28mr755099wrp.97.1706198089626; 
 Thu, 25 Jan 2024 07:54:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr3ghItosWQPA0aO/CsfLAm+55Ytfmnqfbmk3osiMMvfrlxILWXzIb94Mkw/BdcwPgUrCckg==
X-Received: by 2002:adf:f548:0:b0:337:9d27:ae28 with SMTP id
 j8-20020adff548000000b003379d27ae28mr755093wrp.97.1706198089293; 
 Thu, 25 Jan 2024 07:54:49 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:48 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/6] smbios: type2: contained object handles
Date: Thu, 25 Jan 2024 16:54:33 +0100
Message-ID: <20240125155438.47617-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
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

The type 2 structure must include information about the contained objects.
It is fine to set the number of contained object handles to 0.

Add the missing field.

Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	no change
v2:
	email address updated
---
 include/smbios.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/smbios.h b/include/smbios.h
index b507b9d9d72..98bb9e52cdf 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -139,6 +139,7 @@ struct __packed smbios_type2 {
 	u8 chassis_location;
 	u16 chassis_handle;
 	u8 board_type;
+	u8 number_contained_objects;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-- 
2.43.0

