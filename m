Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6917EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E551D864BB;
	Tue, 22 Aug 2023 11:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WfMDv7PG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2F3864B6; Tue, 22 Aug 2023 11:38:47 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C848486483
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bbbda48904so48129121fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697124; x=1693301924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=WfMDv7PGfh7IZuzXUTktJpJAzVvzBeQJ/J8JVHvY1IWQ5oGaeZTNPtwJZs0Z+pT9zR
 jSgbWj9BA38eT3Xt2NHhGGmseG/gpS0rypxnQvQmsD/O2d5bX15u/2QGj14J7bR95GGh
 yz/aMlbzA4lYHehpJa3pmHpDAWT/n8rJmeanzgoYt/JkkwVhvXO8AQEsGK4N0km7DXuy
 ed4ig2APDGE1X/QWm+Cn8iNJbunOH7tqCUvTDz8eJjsZ/A68j7JnhOQP0kJbKDs43Qs7
 08ifIphOg8OUEQSx4Pc79/CZpwNTPx1qHjcLkq9pWgpw1jwqfhwdHXdwTfw1oRa9rfmW
 sSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697124; x=1693301924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=kKG0/sREq8ng0nSHIKbum1HEHzcQExKneOPr0J6FuZb2YxAfGwsSEL7Xre6ZQxR483
 Wu8HsQ/O/Hp0AF9+UTvOkt2/+yDXz6eS8lmRHxb7iWfyqWRLubsTsMvT8fOQWJwn/MOE
 nZGbMVMIJAcA9/ddTI/wck1Xkla9sx4B5DaGs8EMz5pnOV41I2DniFn5uWZW5cPjRIyl
 mdFHlkHadLFAKf09aj+lWkHRq1cQBxCoP5w5iulm0O0Dwbqj7KXxjKHF7xGQuzymucno
 WltEb+pZgfFSqqrlh1NxEckgqXICTTqqRgPXuQEWpgQN6UsxJ3rpdwmjpN7/y0Ejxy7s
 nBug==
X-Gm-Message-State: AOJu0YxVUc1hTda5Vrp3XrFUdceT+QyzT2DIXnEqWfuRwmofjym9C921
 W7JEgYtS0X/dMjAzUDetGVACiXV5paPw6X0beVQfLg==
X-Google-Smtp-Source: AGHT+IE83QHpRT0pi10aqIuq2d7QmQejQlq90w0co/thVsMhcvTLFIPYrfW1fkUEk64k8kCDlI6rVg==
X-Received: by 2002:a05:651c:1052:b0:2bc:c466:60e9 with SMTP id
 x18-20020a05651c105200b002bcc46660e9mr2911416ljm.49.1692697124023; 
 Tue, 22 Aug 2023 02:38:44 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:43 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 10/15] net/lwip: update .gitignore with lwIP
Date: Tue, 22 Aug 2023 15:36:09 +0600
Message-Id: <20230822093614.4717-11-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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

ignore lwIP library code and reused files from the lwIP.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 net/lwip/.gitignore

diff --git a/net/lwip/.gitignore b/net/lwip/.gitignore
new file mode 100644
index 0000000000..7b5dacce90
--- /dev/null
+++ b/net/lwip/.gitignore
@@ -0,0 +1,8 @@
+lwip-external
+apps/ping/ping.c
+apps/http/http_client.c
+apps/http/http_client.h
+apps/tftp/tftp.c
+apps/tftp/tftp_client.h
+apps/tftp/tftp_common.h
+apps/tftp/tftp_example.h
-- 
2.30.2

