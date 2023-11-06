Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF62C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09B886F9E;
	Mon,  6 Nov 2023 03:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PYBlu2TG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D44286F9A; Mon,  6 Nov 2023 03:26:52 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2206A86F9A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6707401e1edso25027476d6.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237571; x=1699842371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISxLHPyi4EGEjppBD4H1YjjWp8enNJYR0I+2mCjeRSU=;
 b=PYBlu2TGPrnFKWA9u8XaD32cTcoo8CmcpHX97731kcAaE+rzIn47rrilE8J8r7h4E3
 dLy2z/fK2qKLdlVP/Lrgcqm1UN3idt7j9dihB1dcrFbtlSvA+bgSCpvLdTepRw2eWgYf
 A0bdeb/qWyAzkzbpAmFtgWS003kG2fy3yq9bgT+Qhp6aQGt+1ytajHeOP+Z7P/CfE4Ag
 aDtVtwiZs9pnl2ZVpM+IWUMqMNxFCg4CsrVHnRnm8a8m62zx9+QuMcHM4LvL47tTVJbp
 xc/fLDdJr2Ur0PYcXsPUz/a8I4rypNZn6M0pteZ7Q0UK0csHs5tsv7PdoycQjwz5mU7l
 T9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237571; x=1699842371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISxLHPyi4EGEjppBD4H1YjjWp8enNJYR0I+2mCjeRSU=;
 b=K12WYxx7CBzx5ErRldcZ+YokvH7iWfZ6vV0Wst/TrXQH3XjhjTklpaqYN70HCwltak
 KUz2SwymhDFRp2FK0kHlgcizi/qRDUNlcmjYSmZeHxMelVCINFP9WcCwhK8VWSWdRgmQ
 sIHhEuSm1UMUunAzQfb9jk2ZS+yJ5l2/RKOkYe3LQ3xHt9ZCVJpxdX+DQnp4IQnwFHsf
 4XH/AKRqweZQybjuAu/d0xmNLQfqhMXtUba+m6BCFaCAXd/Q+G7otBK5qknWNM4SX5p6
 Rfu9gK3zft8bMjvYLfTtT4S5QBwXD8S/3JDoZFZKePENRZp6GXOFwurfSWm6xqQy2h6o
 RBYg==
X-Gm-Message-State: AOJu0YyC2Er5wBcq0ll6iQPtlmp4gMrCd8szfPvH0lXyB5wMtarQM5MC
 bVwDtiTGKX3DO3Xlp7Ddp/w=
X-Google-Smtp-Source: AGHT+IEw0VKtWbWqemb/CT5LL2ynKVO4lOayFrOx7rdUvtWP2LSv75PgzP9GWnFL9fj9mejB870eZw==
X-Received: by 2002:a05:6214:2265:b0:66d:6439:4383 with SMTP id
 gs5-20020a056214226500b0066d64394383mr35041543qvb.58.1699237570953; 
 Sun, 05 Nov 2023 18:26:10 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 mx1-20020a0562142e0100b0066d0ab215b5sm3070521qvb.13.2023.11.05.18.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:10 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 04/25] spl: semihosting: Don't close fd before
 spl_load_simple_fit
Date: Sun,  5 Nov 2023 21:25:42 -0500
Message-Id: <20231106022603.3405551-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

On real hardware, semihosting calls tends to have a large constant
overhead (on the order of tens of milliseconds). Reduce the number of
calls by one by reusing the existing fd in smh_fit_read, and closing it
at the end of spl_smh_load_image.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_semihosting.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index f7dd289286d..8f11c29913f 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -24,18 +24,14 @@ static int smh_read_full(long fd, void *memp, size_t len)
 static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
 {
-	long fd;
+	long fd = *(long *)load->priv;
 	ulong ret;
 
-	fd = smh_open(load->filename, MODE_READ | MODE_BINARY);
-	if (fd < 0) {
-		log_debug("could not open %s: %ld\n", load->filename, fd);
+	if (smh_seek(fd, file_offset))
 		return 0;
-	}
+
 	ret = smh_read(fd, buf, size);
-	smh_close(fd);
-
-	return ret;
+	return ret < 0 ? 0 : ret;
 }
 
 static int spl_smh_load_image(struct spl_image_info *spl_image,
@@ -73,11 +69,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = smh_fit_read;
 		load.bl_len = 1;
-		load.filename = filename;
-		load.priv = NULL;
-		smh_close(fd);
+		load.filename = NULL;
+		load.priv = &fd;
 
-		return spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		goto out;
 	}
 
 	ret = spl_parse_image_header(spl_image, bootdev, header);
-- 
2.37.1

