Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED0F109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5812783AAB;
	Wed, 25 Mar 2026 17:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MKIAz/Vu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C047F83A91; Wed, 25 Mar 2026 17:55:33 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2056581E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4673790ab85so3006715b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457729; x=1775062529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZtOhdIYb7moHvHPIaOKUtQTQcWhiRvVx/3eNC6ae68=;
 b=MKIAz/Vuq4PHE4bWFVpQCHqdibS0i3ZGBcGF+i5R0jGYGZ5Na8L2+f//z1ntquVRuj
 JBDSk06+ldn84jj/ShtiG6kCqglX21z5/dLcmbek0RV8tFmVxEYblynKV6GVBqOt/3dk
 XVy8zgZOZg4W/zYufisaEj3o/F7pgzUzxWdOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457729; x=1775062529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZtOhdIYb7moHvHPIaOKUtQTQcWhiRvVx/3eNC6ae68=;
 b=n4obILPUjJX8Dt30FT6LBzPCbsCR9Hl82MsiMANWKEeQs1b8zO8rx4Tgtwdyh9BP1S
 c2kGyl//sXrWJsE4mHRi+zPDsMnTSqSg8Mm/mcuh0ZFV4NnUbQIM2p5IdxDqy6N02ATA
 Iaulj3encRsJpEyv/C/vHysMY8tSKXPY31QZBUFH7+npxYw8IBMzcD8MHd44ZJXVmPm8
 FCpzV04SqRJpv8ftfKHUCYddBABCIO+TadfjqE2MXJgurGv4RpbhNxi2Ww/7AaLvLt90
 pQ98hrehRI3h8cuRqO6X0FMl7fO/MnJAJpDWT9pRRq08pJrN9UggElb9jy/iho+0fIq9
 zq+Q==
X-Gm-Message-State: AOJu0YwOgoBQZmq3iz8xKzJqIXLUVcV8WS9E0GsaaLzrR+MBFfIP+Bc6
 ZBv/1Jyuv/8XQZqQ2UnB1qDZzuWK1ikUIE3cY3mdHbyYH8XgeAtO4q+ui/QVFQX2n3NGxzV4dED
 RTq0e+g==
X-Gm-Gg: ATEYQzyHCnyKtyb0i0J9P71Y3ynpqENPZ76fC5wt2plylbKF3oQVuGaZyknlrIvrkuL
 hrmZR7KY34ZUILpTeVoroVYruW2MQWx+v64nr7lTJhC6FAfWgnj0pDxzml8xE8SND35tZYF66Ez
 7G/Q5W9TKppstD1qFL02InkYAv+Oak4u2yyuKKqBKYZF1mpn0idSHNgFvsgp62WD0d+473DiIUY
 vOuEhhWPkWjkLCG9xkIyUFOzS3TdMW25t23CTEbv7hbKYdIFlC/MDj/86GtIhiUx7eCXnwtGFvo
 eb+qHbVOdf7BIH99CMQAgQ+yQa+jS8rA/rDA9cuGq2w97BXkAVZX4xTvuLBsv7+ekNs7th9OlPj
 vUzSInDYlr/zLjx//ooe757y82lDTzxIeBaJKD5YrhJogvefC48mCF+IaK1X9rGtPRTSlJOvvGi
 MPYYu/c2ss59Rq4T2KjQ==
X-Received: by 2002:a05:6808:4f49:b0:467:f36d:a08a with SMTP id
 5614622812f47-46a5c59bda0mr2106626b6e.5.1774457728732; 
 Wed, 25 Mar 2026 09:55:28 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 00/13] boot: Make fit_image_load() easier to maintain
Date: Wed, 25 Mar 2026 10:54:09 -0600
Message-ID: <20260325165431.1027591-1-sjg@chromium.org>
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

Before fit_image_load() was created, the code to load kernels, ramdisks
and devicetrees from a FIT was spread around many functions. By
combining most of the code in one place, it became possible to add more
features in a consistent way. The 'loadables' feature was much easier to
plumb in, for example.

While fit_image_load() was a substantial advance, it has never been a
svelte function and the passing years have not been entirely kind. With
a few new features on the horizon, this is a good time to improve the
implementation.

This series splits much of the code from fit_image_load() into a number
of smaller functions. Most of the changes are fairly mechanical, with
just a few renames and tweaks here and there.

This should make the function much easier to maintain. It may also
encourage someone to take a look at its callers, which could also use
some attention.

Code-size impact: about +8 bytes on aarch64 and +24-40 bytes on arm, due
to the compiler's register allocation across the new helper functions.


Simon Glass (13):
  boot: Split out the first part of fit_image_load()
  boot: Move call to fit_image_select() and rename it
  boot: Tidy up setting of the OS arch on host builds
  boot: Move type and OS checking into a new function
  boot: Move handling of the load_op into a separate function
  boot: Move obtaining data from a FIT image into a function
  boot: Check the image is allowed before setting os.arch
  boot: Move the architecture check into check_allowed()
  boot: Move image-decompression into a separate function
  boot: Move decomp_image() into handle_load_op()
  boot: Move setting the OS arch into check_allowed()
  boot: Drop unnecessary data variable
  boot: Tidy local variables in fit_image_load()

 boot/image-fit.c | 354 +++++++++++++++++++++++++++++++++++------------
 include/image.h  |  11 +-
 2 files changed, 273 insertions(+), 92 deletions(-)

-- 
2.43.0

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: loadb-us
