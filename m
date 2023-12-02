Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9CBC10DC3
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 06:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F3686FFE;
	Sat,  2 Dec 2023 07:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Yd3P72WQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1558727E; Sat,  2 Dec 2023 07:56:51 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E100A86F40
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 07:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3MNVqZQcKBrcjlofqwcdlldib.Zljr-Yllqifpqp.abku.ab@flex--moritzf.bounces.google.com
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-daee86e2d70so1756372276.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701500208; x=1702105008; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xx5Ibg2I9fnODX9uh6nBQbVG3l4NBsZbl+3ujT8CEK4=;
 b=Yd3P72WQlLkauGklaFur1ort7d8CuD+fZUx8ZIRseH2Sl+BDYB6lQF4NXuVQzSYZIa
 3EKkEcb35YJ1cgbaC3QVRqoivX4AJqtzJ4icWNgec/hT/uvpQUPfz0J6BDFWTtUUdZJr
 Jxcib/XLHsB3gvQUrQmhSr1sE6q8ZoBSIMMAPGmHBGQmxFupLmJP4OuIHEJYL4FfXzhU
 Mh4jrgqtYADbmZXc/D+KBsQV/ZUdTDOo3W5nXKJtQwjxtMgArY2G6wYvgV/op4+9vhiK
 unoyOcy5BtypAUBadGuLLhy+7QwmqbPtfl774uLmK5/ckq46HIWEqdvBAcFIbVoyBhpr
 1TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701500208; x=1702105008;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xx5Ibg2I9fnODX9uh6nBQbVG3l4NBsZbl+3ujT8CEK4=;
 b=rUbIClpuDSSkx+jhVagNMVpvdHZ1WjL5ExKtKxNpgboQQR+kjMTufa/FX6gv7LdaWs
 XO3ewsNn4qeJc8AwbgWW/Zs6t06MOj8BRZ7pQIH8zb+21AllTuzdWkTZudizVKAuLZ2u
 uYIcgk7yg/fuDlLI/XyXVVzcXmyameScoeQQCtLRd47njtp1X39dcwITp39ctJANz056
 dKmfJFKNUgRNg9eE76nB6uLBcgmYwNJMnvBf6A3uJ7R7NC9ckCIjlroEcXSJsBQJptGw
 OkxkoPcFyApapillshqrSL+0ASrBEmmzQqNr+OZMVfiFus7buwyJJHwOFjg1gRxYHM4a
 S8Sg==
X-Gm-Message-State: AOJu0YxmD3sXVDm2/ptHp8A0B4rzrdJl6Jjq0UPEIg8MIcjV+hDwNcTJ
 cfEz9JjFlyxU71Z+92T0oeLiflRiNXcz
X-Google-Smtp-Source: AGHT+IGw4dBXGGiSGD/8BuvU6mxscr6C/Kk4SHVwrcrU7oYyPCuQe+kCROMzY08j5ZxPpGIlsYUrE3jW/I6C
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a5b:f0b:0:b0:db4:5eed:8907 with
 SMTP id
 x11-20020a5b0f0b000000b00db45eed8907mr787598ybr.8.1701500208587; Fri, 01 Dec
 2023 22:56:48 -0800 (PST)
Date: Sat,  2 Dec 2023 06:56:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202065634.3641171-1-moritzf@google.com>
Subject: [PATCH RESEND 1/2] nvme: Fix error code and log to indicate busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de
Cc: mdf@kernel.org, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Return -EBUSY if controller is found busy rather than -ENOMEM
and update the error message accordingly.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/nvme/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c39cd41aa3..ec45f831a3 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -835,8 +835,8 @@ int nvme_init(struct udevice *udev)
 	ndev->udev = udev;
 	INIT_LIST_HEAD(&ndev->namespaces);
 	if (readl(&ndev->bar->csts) == -1) {
-		ret = -ENODEV;
-		printf("Error: %s: Out of memory!\n", udev->name);
+		ret = -EBUSY;
+		printf("Error: %s: Controller not ready!\n", udev->name);
 		goto free_nvme;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

