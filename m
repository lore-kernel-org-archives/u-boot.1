Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A53E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 17:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1A3890B9;
	Sat,  2 Nov 2024 18:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BtRd9C4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E231E890B9; Sat,  2 Nov 2024 18:50:06 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BA089083
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 18:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720d14c8dbfso1599895b3a.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730569802; x=1731174602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gyBTluX2o3v7iq1C01E3X+/axgcNC05wx5GKq5cn7IU=;
 b=BtRd9C4lVX4XeFfwYKhlNGQflz/duVomYvln3AjOHHhMV3mFYDPg9YHlQQJO50ZFl8
 OY6TOX04Wc37SE/DTSvHl0gxrHocJPBcMJzxVOH6ZvxY4eJqDm9+/kvEW+vTp9bz4zfm
 RAmtaCh1I5jCKuCZKxfTb95lNYDoYNo1eLWWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730569802; x=1731174602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyBTluX2o3v7iq1C01E3X+/axgcNC05wx5GKq5cn7IU=;
 b=Gh/cyghA9hFmCiHtZU4qIL9UttWE8Q6w481oVR++ByEOU8XmYJ77Fkko5m9ZLToFal
 9auW5b3ygnWh4BzMSKxtL7oIPE5cROxRzXaw36VNfCSfuErH2+FSfZbmhce775hwVqqA
 c6i61+G7XzP3aPI3jtRXoie3ioAn9ODZHDDOfF+zViY2M8Qa4qozY8A4MFAqxem0JKo8
 1XbwgYvb11et7GYekJXLjapz04m56meDdSzL2UC6XeujqwIuPnxRO0W7RnMG5aPQBtjk
 ie7xYggk9j6BBP6EPbalalAGhdLmyCXTfC5AtPApbkhpmq7QQUV9npRfRJyvYET7vVnm
 dPUg==
X-Gm-Message-State: AOJu0YzLXJcafxm0BnQbC72iF8YGIXVCETf66bcIcO+FoaFkS+8aWu/+
 WrFNSKCs7Wqvh8UD4d2qSW1TOC8WIVC+b0EQGtHZ6vyC8pkeRc2sPVaQyVmhz/3dAlcy/Gq4/ah
 SqykJ
X-Google-Smtp-Source: AGHT+IHXuB9NIXAgTDdEEvzpjlgfMXh94wWm8zA2yzP9xtUYKCPk22uld4+SMH8V12T3+/Fnhs93Sg==
X-Received: by 2002:a05:6a00:1817:b0:71e:5b92:b036 with SMTP id
 d2e1a72fcca58-720b9db47b8mr15427134b3a.22.1730569802469; 
 Sat, 02 Nov 2024 10:50:02 -0700 (PDT)
Received: from chromium.org ([205.220.129.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1e5cbesm4402403b3a.61.2024.11.02.10.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 10:50:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] fdt: Correct condition for receiving bloblist
Date: Sat,  2 Nov 2024 11:49:41 -0600
Message-ID: <20241102174944.412088-1-sjg@chromium.org>
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

The condition for receiving a bloblist from TPL is reversed. This was
only noticed are the other fixes landed. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---

(no changes since v1)

 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b0655988029..60e28173c03 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1677,7 +1677,7 @@ int fdtdec_setup(void)
 	 */
 	if (CONFIG_IS_ENABLED(BLOBLIST) &&
 	    (xpl_prev_phase() != PHASE_TPL ||
-	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
+	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.43.0

