Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE6EC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FEB866D4;
	Wed, 30 Aug 2023 20:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nymf/7A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401FF8656A; Wed, 30 Aug 2023 20:06:30 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524B486591
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so2120539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418766; x=1694023566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ngf4CkmH0T/Lh1OQx9nMv+Pwszcpl+bpkgS+itPcD0=;
 b=nymf/7A/c/5jQEpq3hil4lgJATKauXPjxfDtEKdmmcPdWsa7mofBCpPP9K+3Zuo7Da
 jrBhIrAw5EB6NjtH42IZhd6JWQ9RZxGJPJb2uSDeWxonKfmFSXSUabYRUEr6MXkSTqxo
 53Y3pbcv2KzUCRDtmT96LeGfHLqx2t3sHVE0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418766; x=1694023566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ngf4CkmH0T/Lh1OQx9nMv+Pwszcpl+bpkgS+itPcD0=;
 b=LFvlKu3A0J63y5uuCTP5LdKkvrWwh8STvtlFVkrpnCCAg2hzyh34jt2wVzQ+aeBvbl
 RD+6xwlLMuR19ny3JE9AFOwkT2dhCFO/cvHjJN50cZ3aXRNXMm2+ZvaAls9ng/osX1Z7
 eG/om4yA5EhOiwZ6yCSgWSIEhDs+atHcpm3gBxq5xZ92WXFS3SaM0LTgfLEVm9WIbkxh
 go6z75lsMlYTheMzG4Q5K8Vlid8HtmJwf+yhWGbOHJEg6ew3FOya0gAlztERSMiOn/Wf
 Ygz2aWfDE1npjnHZZt77nD4b7htC2fwbAnLY/7sZ9qxrzemBWUZfBhgM3CV+9kAgmkrw
 LfCg==
X-Gm-Message-State: AOJu0YwtDMiVef3lh53K65GxyQEY4qbvVo9J2KgaxCOCTUggrLyZMUJD
 MD2QNTKpT3WC+5/n8J4HntpFKlEx7l4WrXAyJlE=
X-Google-Smtp-Source: AGHT+IHI4GvsVlvmXMvFlqMeqIsWAWxfKJpMkC7KgBZjUoZGQnzMgGvs9aTUHBEjzvrMR5rUcTx5EQ==
X-Received: by 2002:a5e:c011:0:b0:791:60c:4b4f with SMTP id
 u17-20020a5ec011000000b00791060c4b4fmr3529959iol.17.1693418765966; 
 Wed, 30 Aug 2023 11:06:05 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:06:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Evgeny Bachinin <EABachinin@sberdevices.ru>
Subject: [PATCH 31/32] command: Include a required header in command.h
Date: Wed, 30 Aug 2023 12:05:02 -0600
Message-ID: <20230830180524.315916-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

This uses ARRAY_SIZE() but does not include the header file which declares
it. Fix this, so that command.h can be included without common.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/command.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/command.h b/include/command.h
index c4e3170967d..7a0ab8c90b1 100644
--- a/include/command.h
+++ b/include/command.h
@@ -15,6 +15,9 @@
 
 #include <linux/compiler_attributes.h>
 
+/* For ARRAY_SIZE() */
+#include <linux/kernel.h>
+
 #ifndef NULL
 #define NULL	0
 #endif
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

