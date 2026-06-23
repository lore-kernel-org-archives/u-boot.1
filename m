Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36376CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F98F849FB;
	Tue, 23 Jun 2026 15:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yz0YQrCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B61084A12; Tue, 23 Jun 2026 15:22:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0993B849ED
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso36918095e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782220948; x=1782825748; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H/wtcVhXH3n+qdtxqaFKIKdHD1FwrMi65bT3YZZirfU=;
 b=Yz0YQrCt8UXnFZQZ1qciW+qo08RbNXO6t3RVj5d8Kec/nplKJXmoa9TsiFNVHmj9Mu
 rlNIae6zBcPGYysLLi2UAEbtDSyK3pzPIOWLc3m5bbIuVVpbDVXTDgCXWmsAJIjPv+Si
 02gnYgyA0UnWhXyjY8MbbmRjDF3eHNjKHeQkA/cQHrPwk1gLTrLUzUoI8MLCdaH4qO/e
 DfQYGqzOOFvPCPU+ecxQ5vQG+6esPutuKWYG8TUNwwIa8yjSIdcEakAbqNS5oOC/mzXP
 +ofNkkp9BkJLopM6wjlBxacHeNnKsW9lekuwczVfOZ7yzrfv3IPQognGSVlfmC6wdMl7
 gdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220948; x=1782825748;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/wtcVhXH3n+qdtxqaFKIKdHD1FwrMi65bT3YZZirfU=;
 b=aYtFyqD/fd1QOXi4CaostADyemoPZIJdZXclNAZTXxrYk4IfqQ+q8HX4thTg4cwdlL
 S/RD2kfbDa9qYkEIg41cE5R/eLpvA8Diq7jlHWeDBK/U6sw4nGCoF8Gettii6NM8J0gE
 6qi1qTZ1htrToCKs8flEBcOxTitMgs9q1Etjy7IQ/6h3HgSbAYbXhdtpJUic3DKSOG7d
 jRzFgPNM3Ap53FIqE1Yv38aP4EI6B3P6wogeur7j2eJ2VjXiLgN4FN4ugkR2Cjb5/Igc
 YGhvCIz31/GRJvQ8BwAD/EAnUyxQIhl5xoAh9EioS2DOf3LBXUFPdBnexf5awF4fQBoy
 Uzig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dqnjkInwGQYD/3Yf1LEaCb3Wkjb5Or1lYERrPEi0oJNMTXEfJZYHBtQzeiZqfQA3kCTLZFog=@lists.denx.de
X-Gm-Message-State: AOJu0YzGk081MB58cskZ5lRRRSKgFLnjQ5dZp7grMQhGrOlGTsbiljiw
 DdLoZME8LV+PZQa88P6F4cHeOfAGMVv+ii3XuvDgjc7UYEv2BilxV5qQESipkhGJw2I7IRQuSBJ
 5M060
X-Gm-Gg: AfdE7ck2HYyKMzBDS3pLEP/KVZbWCm2Uz0rIun3y8X8LzHaZcXqWztSqm+WpzthXRit
 149v91ePjHK0LmUebN+qPnZ3TJxWiCkH5uTEnze1sBWvH4zaWQg9fhx5lZvxGswx9Z8HQv3sx8w
 YOkuLUtkg6rKDaX6DLgfJVA96QwDN4jrwwRFnRSCdTpwPCXMrv9jfoCQWNRVBJ+WZ+fhpyVU/42
 41WLeBs3LxLC79SGuDvvO9C3TZiMBmCjfKxfpJvkDDzUTs+DRw5+ysy0kIChNOoRhv+vZUEHD6h
 Mk3aFoCVLCdtzsv9kDE9/8ZUCCAPFd2lJ9XHi8HEeUneuqbM5Ie8H18HIY/49jDsVXlSzFskssm
 zjQSe7xix9qWrGrDwB3ZsoTfa8IGDPAEL2KkalGDFnlkCRksDjiYJMgk+68jDk1ymoLy0GuR0nc
 CGv+kPe/oHNClM0raBaHRw+V1+UkY=
X-Received: by 2002:a05:600c:154a:b0:492:3e66:6c84 with SMTP id
 5b1f17b1804b1-492490af5c2mr226631765e9.30.1782220948212; 
 Tue, 23 Jun 2026 06:22:28 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm349965745e9.13.2026.06.23.06.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:22:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC v2 0/4] Prepare migration to the new mailing-list
 domain
Date: Tue, 23 Jun 2026 15:22:23 +0200
Message-Id: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+IOmoC/3WNwQ6CMBBEf4Xs2TVQKKmeTEz8AK+GQyktrEFqu
 oAawr8LePY4kzdvJmAbyDIcowmCHYnJd0sQuwhMo7vaIlVLBhGLPM5Fip4Hzy0+WuQX9aZBpYy
 TmZNWqQyW2TNYR+9NeYPr5QzFr+ShvFvTr7IVa4h7Hz7b8Zhs8P+PMcEY8+qQallq4WR5aqnTw
 e99qKGY5/kLB8OyJMgAAAA=
X-Change-ID: 20260623-osuosl-ml-switch-88cf54f5e884
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>, 
 Simon Gaynor <simon.gaynor@ezurio.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Wolfgang Denk <wd@denx.de>, 
 "Mike Frysinger <vapier@gentoo.org>, Fred Bloggs" <f.bloggs@napier.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SB68UgkLBR7X9T5d/y52SiAmjfJIs1dy3pm0PwpYMTA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqOoiQhnX4Xd7/auRtGz5X4FQjsoiFPIyHbcnEiKva
 ble6FcKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajqIkAAKCRB33NvayMhJ0a7nD/
 9edfhVNBo94H3R08V/YhMTniXEBmgdMsLUt/Xx0F6yryKmyyh2mQYS8Nnmi+heJO9GN9p2l6KNa3Ys
 LcqbamHeqtKmGBUuKcUE6Mc5ShGWeguV3vgW258Jvx4XK/ZrRudO8aMkJAvqpsQuh1b3s18ARNmABI
 /Fj+PNSnNYnymC9jwZy089np9vLOckw0Jf6t8LmjfLkmfwBN4LZO1nIzd9FosEQtEV6930jHSNOL7W
 q918uv2B4Tc9sC8Ysq+kOpuv5soFj+6f7OYcE803dHF1YUAU/8YuizXvs9A3L3FcwnQDUESYzpuulV
 4eQHcbvyn8umiNkdB/rcaekp0qXob3Tw16tAz4A0IVM7Plymen/9kEmN4pCH/I/gE1Y7y4YxIRVzrB
 FOVb9vNh/QVPGTRKS4T41951yiuS7awlVncg39azAUUM8+75OG800roOmiCWoPEO2H9Nm724d/9Wt6
 tb26xbLCPTgM8cP09EUfv5DQO0P0m4qg2OFtPwLUf6qU2MGYqE0Im6oHRFcjCIPt3QU6lALwgeBZHX
 Ny2ECJDa51lsVGFDEJo9Kbqkqa7ZUekKrApn4H8I0Gy4+z1pL6LdzBtUv7O96tM2FDUcL2/bLJu9B1
 NI6iH9IG6gO/k4XfGPe34fRgj0d+6iNXSnImcqF619XvfqMw+7z3e9ewSZnQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 23 Jun 2026 15:23:02 +0200
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

We are preparing the transition to the new U-Boot mailing-list
server hosted by OSU-OSL on the new lists.u-boot-project.org
domain.

This changes all references of lists.denx.de in code, comments,
documentation and MAINTAINERS/README files.

The email links were manually edit since when importing the mailman
archive the numbering changed. We should instead refer to emails
using https://patch.msgid.link/<message-id> in the future to avoid
any dead links.

Please review closely to ensure the trsnsition goes smoothly.

The exact transision plan will be announced when ready.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Also send to the lists.denx.de list... sorry for the noise
- Link to v1: https://patch.msgid.link/20260623-osuosl-ml-switch-v1-0-6d93a5ba2f5b@linaro.org

---
Neil Armstrong (4):
      tools/patman: Migrate mailing-list to lists.u-boot-project.org
      doc: Migrate mailing-list to lists.u-boot-project.org
      MAINTAINERS/README: Migrate mailing-list to lists.u-boot-project.org
      all: Fix lists.denx.de links to lists.u-boot-project.org

 MAINTAINERS                              |  2 +-
 README                                   |  4 ++--
 arch/powerpc/config.mk                   |  2 +-
 board/boundary/nitrogen6x/README         |  2 +-
 doc/CONTRIBUTE.rst                       |  2 +-
 doc/chromium/chainload.rst               |  4 ++--
 doc/develop/codingstyle.rst              |  4 ++--
 doc/develop/historical/generic_board.rst |  6 ++---
 doc/develop/security.rst                 |  2 +-
 doc/develop/sending_patches.rst          |  8 +++----
 doc/git-mailrc                           |  2 +-
 doc/index.rst                            |  2 +-
 lib/efi_selftest/efi_selftest.c          |  2 +-
 tools/patman/func_test.py                |  6 ++---
 tools/patman/patchwork.py                | 38 ++++++++++++++++----------------
 tools/patman/patman.rst                  |  2 +-
 tools/patman/settings.py                 |  2 +-
 tools/patman/test_checkpatch.py          |  2 +-
 tools/rkcommon.c                         |  4 ++--
 tools/u_boot_pylib/gitutil.py            |  2 +-
 20 files changed, 49 insertions(+), 49 deletions(-)
---
base-commit: f072620dc9ffda00b010783da27c41231c3a439b
change-id: 20260623-osuosl-ml-switch-88cf54f5e884

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

