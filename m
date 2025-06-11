Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA6C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0384782CA8;
	Wed, 11 Jun 2025 14:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="cjGlJ1ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847C82C67; Wed, 11 Jun 2025 14:09:00 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342FE82B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so12957995a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749643738; x=1750248538; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t6x0Dly/ec7mI95CgvOhCX5i3V/pw+tb0xcfXbOINKA=;
 b=cjGlJ1ctcU5BqaK0aXZ9j3xBsQHDNLc8sK0rZj476MXbRFZ8tzeVuuyy72xesTaJlI
 9DXVpw+pwIBWXtnry9BS9/DmS/fCp2HJ5QIffqcVsuS3yaL5Vx78le3DrLZZw5givJ5f
 EtmcXREFD5fCw9l9A9JiIj81BzTCqosita8WWlsNZNb86oKCrJFQjjR9a2JLACGz1Sr4
 H8vZZN3pdnOqzqFYB2zZd4XAQW8IYzJiIferAlZYhkhQKM4k074yq+jO3aC9PxcAFkgn
 uBAA0yc6azSEk/52AV+p8ABpH1wBQR3Psk3HdrRm/tVikyrtzAJiCln+0DuOfaVB8vGg
 jrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749643738; x=1750248538;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6x0Dly/ec7mI95CgvOhCX5i3V/pw+tb0xcfXbOINKA=;
 b=dfSPTZ5RBYn6Is1Jt8D8Yz13azyASKnDaqa1hIvYVIAEXUMMKmP47k1A6aR87OBhQy
 sNQuo37eW6ki8dNC2ZzIjugCsOFOvjEzbhJXJXwNxaHSgdlwDuaLPoDFSblUgdghiUiF
 80Rgp1UflaHN5t83HqGNBVxbXSG1YZpnAb5rYaFyH+uJunH+C4csqUHk059nYZ5FRKTQ
 f1wByDWNXrO+bfagX5L9onFDY2k+m9HHmFnBYUxps3+f0LA+mqs3qPmfmhjK+gQtc1kI
 RR/ESyA+aIyeCGzHRl7Vzs7s+I3XOvXGr2qeQM2ZXl32YDK0y+vbwl0f7l/GqWik6M8W
 +sFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhQACeLo0lLXh4QHHrGaivjzXAb+zOHN8tpqJYedxdbvuTOr0QH47lurxEj9EoxzQsh0Xm1JA=@lists.denx.de
X-Gm-Message-State: AOJu0YyxH+Sg3S0d1WlnsZqb6nIGJxGGC8xLS3h/z9DDUHSAfnz4M4HH
 NzRz1JLJ2XB3IUp/E/5QSXtGzQzFI8ljbhq1CIkRLPBljb6IU7xFBdZMoBlDdr/JoCC9jCRAvfi
 IkQe+MVE=
X-Gm-Gg: ASbGncsempmTxNjHwbQRHYCSpXCBOD2qQGOQn60/svWtwU8mLi3cZ58dVLgHFOX0co8
 iEJ/X3SuXYZKvP7EHsdLh5FOs7bGz1zJNxUQanxC1LdK+GHSKyp2a2wkcnoEQb0sPZG/KEkyePn
 MHP+/aysBJuwoOCDX4S1UYNUI+F/g2Mo7yDXB1QUGo9ISDvp1Cg+tOCHVLFBQczcduCftpfHcZQ
 oj9nx2GZINoHr2WfIVdOGadFoB3SjdPGq6GTXIDu2e0bCyx0GB+SZMBHXt15j2FLvv17rVzn8PK
 dCAXV4lC17g8EgnWQhEIywkXSCIH0aN8B8zLxMx5i5VVLTZz289EPm6IFBYiASyJwxA6NCouLTF
 NUyRWCHo6hI5NXfI6SG5wClhXBPqmZFgY
X-Google-Smtp-Source: AGHT+IHY8tlwsrqSEUcNJofxpwQYGnODqNTskeGML5fNtaj7FdXknqNBfIwtIzGYrFmH0odYmxsF8w==
X-Received: by 2002:a17:906:2c10:b0:ade:902e:7b6b with SMTP id
 a640c23a62f3a-ade902e8601mr153442266b.7.1749643737609; 
 Wed, 11 Jun 2025 05:08:57 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc39c34sm870512266b.117.2025.06.11.05.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 05:08:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Fix variable name of msm_clk_data in two drivers
Date: Wed, 11 Jun 2025 14:08:43 +0200
Message-Id: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMtxSWgC/x3MSwqAMAwA0atI1gYaxQ9eRVy0NWpQq7ZQBPHuF
 pdvMfNAYC8coMse8BwlyOESKM/ALtrNjDImQ6GKStVEeNljR7utGLUXbTZGp3cOqKypqWqpMSV
 Dqk/Pk9z/uR/e9wPGNu5NaQAAAA==
X-Change-ID: 20250611-qcom-clk-variable-names-0cb615817b3e
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749643737; l=558;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=plLj1ZY9oTU2pMVCna7iFloyjFZuh5nCqXqdxf/qy2A=;
 b=g76+SNp/wt9WrelqTRXeXz2pkfpyUkvWr5cscXwMdyRBDIMEx8By8YAspVuqt73Mijct1UsUN
 IMSaqh8vVROAxX+o9YXFZklX5jujadLn7Shewapa9TAu0mztYoucynT
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

Just some fixes with no functional change.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      clk/qcom: sc7280: Fix variable name of msm_clk_data
      clk/qcom: sm8250: Fix variable name of msm_clk_data

 drivers/clk/qcom/clock-sc7280.c | 4 ++--
 drivers/clk/qcom/clock-sm8250.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
change-id: 20250611-qcom-clk-variable-names-0cb615817b3e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

