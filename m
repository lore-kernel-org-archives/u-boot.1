Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D5C27C54
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BDC884CD;
	Tue,  4 Jun 2024 15:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSkNMpho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3078839C; Mon,  3 Jun 2024 18:47:44 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 441868796B
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a634e03339dso505054566b.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717433262; x=1718038062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XUvTr/aX7DuIXBOeDyEM5/bWqSgFqgSVKBxvKrci/nA=;
 b=mSkNMphoRixjwUobBWGhDd+VH9d2A7x1Ax+kyVYl0FwUAUShUi+4WPg7rjYfRoiVAc
 3ducURdJdK0hGJzjPloHCkird4sVoKX39jDZOXI2/1uaNFY1HqRiN+rmQDxMVC9a9s73
 UDmO6WW+pM/kPhWwl+WHcCYaSeJL0dPgDKWmF+ZhO3QxeTtC9Aui7Xdg1RZLhFJfcr/A
 6CC5RIXCerH4dbpXHInl/AmdMStWIk/UTslZrYerpAtiimBOK5UntFMtDjEjpvB5fMn9
 XvkM5xiBwu5z0kcXtL97uxzkFDSug1VAJ5C+OAU4xQAsOm0RIoAQ/3KkC3DC7dwyV5AB
 hKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717433262; x=1718038062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUvTr/aX7DuIXBOeDyEM5/bWqSgFqgSVKBxvKrci/nA=;
 b=noB2g1QAK5f2AHjm1I/qEjsDKxZSxydx5wOFBO6QC5B5ujP2E+Zq6Y4H4geglc7Cj6
 1GY92Q1JneIS8ys3IWxAv+6EvlDRCp9iEPlAG0cKfuOIEiWH/N3g7KgwC/pRP77gtIi6
 t+1ryblBsxh95ItAu7eYCUO1OCE5Cq33zKhVRdDDFG33jPHKIU2uzv4XnMsbo+jW2W9x
 7t1aMHJKGEh+djOssrkkywfVBjpTyWvBEzPdix7a8UICTIJnlmY93uUxLfI3R37/jGj0
 nAwUNoHivYktbPxS/eYTDQutJJnU4XTyMvc1P1b4PzB7F8yQwV19t9Qa0WcOPCJNJHjl
 8etg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzwPtL+DKi13D7QOSoCg/RpU0esXj0bTa6AjmREPmpnF3mltJXVqoUJU9FnnLJLZnHNLuAjXi6VN4VE0AQjbkDHlqwNA==
X-Gm-Message-State: AOJu0Yw1T5M8nPONAPZRJUAFoo2orBvyFIu3K50cLyaFX0ZBTCNnvBxT
 SVvbGPmbkdsASmGVD3ejLL4ZYq5+0AB1xmiyYotOJXcvLZY1plAk
X-Google-Smtp-Source: AGHT+IETfeSIKyz4rIeSeua5z3tiwXhwgG34SJDQAptO2lqABohMk5/wPaHtY8WPPr8rYYmybGPHTA==
X-Received: by 2002:a17:906:fd0e:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a681c6e74b7mr578953566b.0.1717433261397; 
 Mon, 03 Jun 2024 09:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c014:12e2:7350:b51b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e73faa76sm505449766b.75.2024.06.03.09.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:47:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: michal.simek@amd.com,
	trini@konsulko.com
Cc: santoshsagar.algapally@amd.com, vassilisamir@gmail.com,
 vasileios.amoiridis@cern.ch, LPolak@arri.de, venkatesh.abbarapu@amd.com,
 u-boot@lists.denx.de, sr@denx.de
Subject: [PATCH v2 0/1] xilinx: Add option to load environment from outside of
Date: Mon,  3 Jun 2024 18:47:37 +0200
Message-Id: <20240603164738.437834-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Changes in v2:
	- Remove duplication of custom hardcoded env_locations[] code.
	- Add implementation with general arch_env_get_location(op, prio)

v1: https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gmail.com/

Vasileios Amoiridis (1):
  xilinx: Add option to load environment from outside of boot media

 board/xilinx/versal-net/board.c | 47 ++++++++++++++--------------
 board/xilinx/versal/board.c     | 47 ++++++++++++++--------------
 board/xilinx/zynq/board.c       | 49 +++++++++++++++--------------
 board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++----------------
 4 files changed, 101 insertions(+), 97 deletions(-)

-- 
2.34.1

