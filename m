Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6EBCF0450
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 11:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B9C8917F;
	Wed,  9 Oct 2024 13:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qibZOZXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C860E891B0; Wed,  9 Oct 2024 13:09:06 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B802E88FA4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 13:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 860103FE09
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728472141;
 bh=EzonidVe1YA55e4IorHfgR/UMct6mL5llTrqQYNTVuM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qibZOZXlYWkuQMLDtUcIiHXYNTF3kIwzFNueJ7PaLFcze7I2lwhp5ISyby36gqKSS
 hD2JNIJOXiu5WrvS+aS+2ruaiXVdygrGAhv2WrQuN/UhzbS7yqudSW4zRHbNkOxwOw
 V7UI4JQQOXwiDI5EpsdPvg6tvccpzpBcz6RV27bYwwiJRNBdEi8aXNbF9dG7j7OrD7
 Fz0E9MgFeY5B3wc8r+SVEgmyTONbmCrtcf0RP5SscVTQvAqDabwMu44LG3S6B6S1wX
 X+XnNVl2/f3pbnWuoyDXWM1PGOcnx64EuxdBV6KjRdWY8lACORnkLyjOSD3vtdMnQS
 yhUPUk4BfStpg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so353996f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 04:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728472139; x=1729076939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzonidVe1YA55e4IorHfgR/UMct6mL5llTrqQYNTVuM=;
 b=m3cxtYkGPOpvYsg5CGrUFApaiCelgtNF4CqPDi/4oFVqrYQFemd4Lbc+XE7FNki+di
 oKn55nQ+oErcylQz0ARBrHo+5ChgDCt2Ti/WpZxWMbUuwqEb2GlAMz6eWJ/cug0RrCOR
 BVkf671DEwu784BoafKx2hfjcqSFrWW35wdOSc1Mi+W1HCtJzR16gVBib7C92W40sn+F
 MbMi0KXU4hX/maCsn6uwv9xkJRaB6/nZCmHPxBekSlyGyMggT3o644jMx22s8sR8KUaL
 I8X3TCsEsFVimk5ghv7iSnOk6fW/MxptJEaXtDZ4VcAFOouCGFdVDGPOQMUwBGIpK4+l
 20Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4lGYneKgfsG+RrgoQ4m0TnLPzSAjXrhMZwDo2MY93683nK042HdxZtvKauEs3e0I62RTRQOA=@lists.denx.de
X-Gm-Message-State: AOJu0YwIaEaQ/KFpDOXVpVfTrMnwyQECYSprxowawtDnJ+Q/XvKkqExU
 eZx5u4M7ml67RmAHQYIdEZYMRy4KtEncb71VbBwzLrn8xTJdVuGg+wiNc1A8bGhpSWrvJa54877
 ixuZsoUDyXgS2I3iTO5bc5rIRnxCOqYY8hZWxUatv3G6EVbGYhpT44RrxVvuD1F4KtTg=
X-Received: by 2002:a05:6000:d0c:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-37d291de867mr3509762f8f.8.1728472139394; 
 Wed, 09 Oct 2024 04:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtgnsnwcVTHDP1Rs2AOzXbW+O9XR/TWoSIrBuHdibM3rJ4xAk5+lIFtK8x1xCdv/9oDGjSg==
X-Received: by 2002:a05:6000:d0c:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-37d291de867mr3509742f8f.8.1728472138962; 
 Wed, 09 Oct 2024 04:08:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:2015:3f67:bd94:474d:9e87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf43da8sm16695965e9.11.2024.10.09.04.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 04:08:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] net/wget: set filesize
Date: Wed,  9 Oct 2024 13:08:54 +0200
Message-ID: <20241009110854.9907-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

After downloading a file with wget the file size may be needed in follow up
actions, e.g.

* write file to device
* calculate hash

Let wget set the environment variable filesize.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rework commit message
---
 net/wget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wget.c b/net/wget.c
index b4251e0f293..c9b8fc9109c 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -404,6 +404,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		efi_set_bootdev("Net", "", image_url,
 				map_sysmem(image_load_addr, 0),
 				net_boot_file_size);
+		env_set_hex("filesize", net_boot_file_size);
 		break;
 	}
 }
-- 
2.45.2

