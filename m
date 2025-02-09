Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3FEC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0793F80A2A;
	Sun,  9 Feb 2025 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Awv9d72F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63B180821; Sun,  9 Feb 2025 17:08:05 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C7780BB1
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84a1ce51187so102031039f.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117276; x=1739722076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLmwxozpliBjtfiZeFDgBEMqsRmGZlHcv1cN6eEThhg=;
 b=Awv9d72FRrOZWFHn2W01UjGxljmAAm34JKCfgTFEx1YokZbqff2UmHbUJOKmqEBRVk
 YeBAPTX1TsZ6SfLiO5SgAFzKHcs+HSyVPqS6fGmzjOMbK9w9Ovr8tcBoSIZKipqQwPUo
 VAzBgTnjjvDPRMZ4dKLEAMOQjltDyXvUBalEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117276; x=1739722076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLmwxozpliBjtfiZeFDgBEMqsRmGZlHcv1cN6eEThhg=;
 b=i0Qbjh6KKqOhawafGQBel8ytw1eL6U1bsvPyMTI0DSl2cQwO+9bbp5M5ERVEePj5/8
 9y5eXOOx81cuKTs4dSSeTDiecWvOGXsDUaH7pPS0Mdx8Q4hrdSZJ72C4eRocshcYRVez
 lgeqSekIigIs68Vsna5vH9H5ZirsxERyeJgvHZNLyB8Z7Nhmqqe91Qy9NW14SLqGdm6Y
 6/hLcI1zk6FHQrz1Ni8oqtcqIhi1YVi+iqwqgWBcxtV1YbuVuhzlSOJ2gfqEFAkvo/XB
 qCa0wU6H6Q1lbSGsKzDEoQlNUHQPzWY2gX4vOgL/1C5QU2T0TZ9iRNbWH/ww96ol5h3J
 jpiQ==
X-Gm-Message-State: AOJu0YySbU6YFCof+5TUGj7D4PNB0Yipgey9oLlZS/R3+Z83YZfXrTO5
 jGglI8hF4wUH1WQCMHxkl8TDOzXRJ86UUpl3hVG2dSBuhEBFvEggVTRpGhy8fW9rK7kNiZF37NY
 =
X-Gm-Gg: ASbGncuK9CQTVRSvUCfoRnQEQdYK/HWhjGCB+OBw++rxTRah1iYMt7t+t6SU1oMFe2s
 hl81IEL4ADob09wfD0kWbdVeaB/tfAzjcciNS+b96xxyI+2mdnoIZ5JDzVWxZEY7aZ1E9jJPol2
 uMSQCWxXu0IPmrrv/alM5Mz14nMUJ6F49HlNK2geSyft8OyRmExh8ZMCasfyB0D7Km5dnvSSzVR
 znulClDbpw2IMA+DWniN9NV5FLopHhXkuE1JqtdGzObhVaaHu30iMxX4mM0ME1DqWcatvzih2g4
 Uwr9yFGnyYVZihknytA+ftGBQyixQHIrkHj7Jq+1mln+epOV3r1R
X-Google-Smtp-Source: AGHT+IE87nJQR5iTWLOOrhQ08n69rBAnX/xHGxWYalv9opH6nHRhqQeqcL9U0BuJhuIbMGLXlQ0DbA==
X-Received: by 2002:a92:cda8:0:b0:3ce:7cca:db24 with SMTP id
 e9e14a558f8ab-3d13dd62ad2mr74943435ab.13.1739117276052; 
 Sun, 09 Feb 2025 08:07:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v2 6/6] test: Make net tests depend on CONFIG_CMD_NET
Date: Sun,  9 Feb 2025 09:07:19 -0700
Message-ID: <20250209160725.1054845-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
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

This fails on samus_tpl as there is no 'net' command.

   => net list
   Unknown command 'net' - try 'help' !

Fix it by adding a condition for the test.

Add a blank line to keep pylint happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
See here:

http://sjg.u-boot.org/u-boot/u-boot/-/jobs/19821

(no changes since v1)

 test/py/tests/test_net.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 9f4ee0c9ed4..4732e4b57f8 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -91,6 +91,8 @@ env__router_on_net = True
 net_set_up = False
 net6_set_up = False
 
+
+@pytest.mark.buildconfigspec('cmd_net')
 def test_net_pre_commands(ubman):
     """Execute any commands required to enable network hardware.
 
-- 
2.43.0

