Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85461C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56FE88A83;
	Thu,  8 Aug 2024 00:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FFeYkGtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCAB888D7; Thu,  8 Aug 2024 00:48:11 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63112888A4
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b3a6a7941so1258255ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070888; x=1723675688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPbDAUzI587VrP1AwwMmummAN3KXW9KfXtMJzjy7WGs=;
 b=FFeYkGtWHWG6aBYJmBvFj/cj3tw3TlhwExjZRs/1e50VGe1cwR/aCfp/8lzaw1TfE8
 iw0+yIMwzK50d9VemTnQTRVUvGnYGRbpq1Z14Ewrb9GLoEce2obi7zjtwAaTTNUK+mJ2
 nGhiWHrXfdG0Si1G2tiErnNJHowm4nS9fEjFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070888; x=1723675688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPbDAUzI587VrP1AwwMmummAN3KXW9KfXtMJzjy7WGs=;
 b=oMbeDrdxKlH2RW5RXxApE3zqhy+usl/uGvhB/7rxJ9xNLva7JgHb4yAX2fm9GzwP54
 CYYtWzGZYGdR4v9poTIzEzZUzN4Jg04cAauQjGglEVCHNlW2/ELj/0aZZkpmZiFhlFu4
 NNXPlOXHvp4GER8fyac01ffK0zANVz+EtVr9rE62T2vsjoEwRdjww8D+DqDOdQL7acWI
 8KbvHJXtuX+HTpb219MsXEr/miojRibwr67AvbfUcsWFm7yeF4MkD8MX47KMuqVYHY9u
 Mz+xNcFBs5+3vgGKzQjDzggRNfhL5fD1lBRwGKtC01Ioyt8Kyt6ZJ8LNNivniWHZN6hK
 NKlg==
X-Gm-Message-State: AOJu0Yz+mMb0Uz5qYMABfCRhChXVY+ZqWD9AmPNCtM1ln5Z3QFaJ9JrG
 RoojnpryRQ5ozPLefgwYqRt2NC5QsQRDbSpMSRBHOiZvTE2tERsGvkLjfGZc5SUQ/oZNkgYGris
 =
X-Google-Smtp-Source: AGHT+IEtJDqcMc06H0vXBeQnIAvS7Ec/tOvC4swc4+g0n5tHHRm01HVXwJ0hfGJmD5wkb6J6n71zFQ==
X-Received: by 2002:a05:6e02:1448:b0:398:16d1:610b with SMTP id
 e9e14a558f8ab-39b5ebd38c4mr1477505ab.0.1723070888045; 
 Wed, 07 Aug 2024 15:48:08 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v4 04/21] fdt: Don't overwrite bloblist devicetree
Date: Wed,  7 Aug 2024 16:47:22 -0600
Message-Id: <20240807224739.3858517-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

When the devicetree comes from a bloblist, it is currently overwritten
by the appended one, if present. It should be preserved.

Adjust the logic to support this.

Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/fdtdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 6865f78c70d..5edc8dd2f9f 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1685,6 +1685,7 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				ret = 0;
 			} else {
 				log_debug("No FDT found in bloblist\n");
 				ret = -ENOENT;
-- 
2.34.1

