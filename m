Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F58CD68BCF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE8398911B;
	Fri, 15 Nov 2024 20:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E/9Kfiki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4830289185; Fri, 15 Nov 2024 20:01:58 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D267888F49
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-296085d59caso1321508fac.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731697314; x=1732302114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i+bEqwDSVvRKH3+IRn8CotQMdwsXS5szsjzNPsbTkNk=;
 b=E/9KfikiEoWKDJb2JBY8kKlKDAtqmBOJ2rwfkwDOAa35tOkwQB5BhCugTxUoYI0DfO
 iQyjcr8/454yaepfH9UcHiHjgQ7Iu2O5B9awt67ZQrmnfCaGDtj8ZmIMWcjHbUDpS57M
 UPz+4I7Ew8RZIHmeEwDJTo4FYgz8Ni0XxIXjJOqapNTY5HetAPYpq5iGTn1RrkVkzgKD
 18ReeGqvAL5u4GJnHRFglhhfxu87ZYmWqSdbQ5QJ7RDfvV9bbCuj7WTJgCf4tKQh1wtP
 vVf7wD+99eXm20eH1XNyTDEt2TPsh7PoF5kldui9JSU94/7i844OE4wM7P1jWD2OkpmG
 NP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731697314; x=1732302114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+bEqwDSVvRKH3+IRn8CotQMdwsXS5szsjzNPsbTkNk=;
 b=IXTn1frmaqwTaF1+AMOrH//ehPw96PYTjmt8aKDlTxH1Rjd3TSidIy9V8RAP/6Jq4M
 xoirg3W87qLXlf/UcJMfMlGv6XFYfbXNByxe7L/ESjk9BWEYhV2nrmGkQWv3gNVlPbz0
 KZnmHruwxEW8hQOZjqTE/PTvUlo404+UYVurSRhqhHIaklpgJ79aAKdtNs8xHmXxHtl2
 ZNB0+vkgM6OjCIOZqlc0TAQRu7mMUfZxgNlbbPXREMCmZUdYS8ZS+dyQvuEzT5cuQBTd
 LUCrp4xpzvsS/ZPIh4VFd0Y/5OEJQ3n/+Go3l/aoEezc5Kgv+wsamLM+kMdyx2+ikEEG
 a8fg==
X-Gm-Message-State: AOJu0Yz6HRuzTNl57mNmkCwl/hR0MivsOF/rU2Ll6GG7af01ZE/GtVJa
 z6gdHMEu00AB+LIBuUyuhDMUfDpQbA2iceqg1GNmjbALfvZLhqfR
X-Google-Smtp-Source: AGHT+IEyst68khjhgUnVgJ+EocELmxfA95aeppUQfVkI3yRoRJpn0jXmwwq/+QBAzQzZfAHCNRTZLg==
X-Received: by 2002:a05:6870:9619:b0:287:9a03:94f0 with SMTP id
 586e51a60fabf-2962dfe8e09mr4652970fac.27.1731697313853; 
 Fri, 15 Nov 2024 11:01:53 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b27:e686:f7dd:85b6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a780ea49bsm686827a34.7.2024.11.15.11.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 11:01:52 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241115
Date: Fri, 15 Nov 2024 16:01:47 -0300
Message-Id: <20241115190147.190726-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 2bf2615b8004e4a296fb25498ad0c183fd5c7b94:

  .gitignore: add test overlay .S and u_boot_logo files (2024-11-14 18:14:06 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241115

for you to fetch changes up to e6c3c63035c7ed58e6d6a95525d4f297c14e139c:

  imx: Fix critical thermal threshold (2024-11-15 14:36:47 -0300)

u-boot-imx-master-20241115
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23373

- Fix a missing break for CMD_DCD_SKIP reported by Coverty on imx8image.
- Fix i.MX thermal threshold regression.
----------------------------------------------------------------
Fabio Estevam (1):
      tools: imx8image: Add missing break for CMD_DCD_SKIP

Francesco Dolcini (1):
      imx: Fix critical thermal threshold

 arch/arm/mach-imx/fdt.c | 2 +-
 tools/imx8image.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
