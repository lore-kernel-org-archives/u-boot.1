Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31122C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674C287124;
	Sun, 19 Nov 2023 15:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L3TL6h60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E3C87116; Sun, 19 Nov 2023 15:47:26 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B2F68714F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7affff20d38so136481739f.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405229; x=1701010029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeMRzhweb6I38GLgsic7DodqYiG2Tsr2CARijlepS/M=;
 b=L3TL6h60fjRh/FhRIh/rekf3CuZgSxaIJgonokMSReFJKRnEXbYV8uNSeJ39poTlgc
 UdQGH1eIy/gMU6d2AlU6ImQuoBcLZ46N8g92pZgeP+soqSnga/FX7PbjTPo8pNjprgYh
 H+TQnyFSeJMUkUxsjT8E5hPBABX3qOCFC7G2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405229; x=1701010029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeMRzhweb6I38GLgsic7DodqYiG2Tsr2CARijlepS/M=;
 b=iOn4eMKsMiS5NS+aYoZdypDRq2/9k6m2ML3v7aiRPitnttkxyGtOMiBySlQR5vnjDc
 e/LItDH7WgeLMif8KpjqOY9FAjUkeE+jmO6vuLIQZtRXg/8VxAwilk8z1+QxT20JpT/X
 aq5yWC1tH0pv88btl/NJpTZunSsght08EvEWZ7nWvBKWbaYo2kxS1oLBrxIrr77SZi3P
 Hk3Em+QhishDjr6V8/xVAysQ/6MtGlu4ihNjLZWwnyhiWeCFdUHYNkzJ+zzOSvPnx1Uc
 ZieOqy27F0bRLAJETc7wVw7IWt0oicyrFsOM5P74Rda3K0O7cD2oiw+Kr5mW3vxrE5xX
 9JLg==
X-Gm-Message-State: AOJu0Yygo9ytPScIH5I4T5Cf8swmtUsfIaankuYAWLVoS/ERt9VNK1B2
 a5tcp2b+q1Yfp6WZlUn6x4lEroLBR6RcI1V6Co+BhA==
X-Google-Smtp-Source: AGHT+IHa9tp/5zA+lz7YZ67SAgOGgFwXxnHFYVd1hvcpAc1dE+ZJ8dNUo8/wYeMqE6mY/3bvUBF67w==
X-Received: by 2002:a5e:c604:0:b0:7b0:733:b8fe with SMTP id
 f4-20020a5ec604000000b007b00733b8femr6464284iok.12.1700405229778; 
 Sun, 19 Nov 2023 06:47:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4/5] sandbox: Increase cyclic CPU-time limit
Date: Sun, 19 Nov 2023 07:46:42 -0700
Message-ID: <20231119144700.631322-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144700.631322-1-sjg@chromium.org>
References: <20231119144700.631322-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 0283701f1d05..07fe53dba687 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -628,6 +628,7 @@ if CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 1000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.43.0.rc0.421.g78406f8d94-goog

