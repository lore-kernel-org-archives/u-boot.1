Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD29C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09FE88A11;
	Fri, 14 Jun 2024 18:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HriMjwmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BC488A1A; Fri, 14 Jun 2024 18:04:55 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7D9889FB
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6fed6e899cfso22295a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718381092; x=1718985892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WfvDqBgq45MSE/U/XZPikqIIbPMdseivuCznFA9F2yk=;
 b=HriMjwmCbP4NdXkwYr4pZH2QpLLiTYK66nnOTk/PQoz6K2XuuMyt0gQ7XFcUvxMMw5
 DkqwrsZTlLKBxycPD5U4XN9/5y8lXQUsiZQt+eH6HXwj6ynFO9vPmu62c8mb+xVo2DN/
 9TlB0fAK9P2c1beGgM3Gv1Qs54fz+8NTtsKxbRtdIZ5FUJ4ROwTaUNeBZUhn3Gb4uOdM
 GTEa0m2q0MysXirl5bzRcI5q404+cjDSA2xa35MEU95+QLvgPOIjdINWHIpwfqHzV27K
 2BcPgAnzQm7LbBhGbsfU/ugGHoSEX8F4F1hvOoLGTyYtUTqBsnEh+Pf6pN7SescXPt1c
 yfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718381092; x=1718985892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WfvDqBgq45MSE/U/XZPikqIIbPMdseivuCznFA9F2yk=;
 b=qlSYZZZUFBX06nQ5vq6Gq0V8MCIV57/UZAMsXu/+MOdbCurPl7ObWsjBRPSKLJgfmo
 lcy3xqs71tizOp6vYf9YXaq+S5ujpJnUNGDRfQ6Zs226L0p9ZsE9HpW5U0b1Y/QdnDtU
 o2AG34f6rNwxtB+bjziqZXiLyQVQq5YnYpA41kSCYM9MbZD3FKNli58KNxuikqXozkfA
 rod9bRvGyESKBMeddqN5oNy1YeIp8xA5giuRnUqdTP+r4QAGfS4mmczugywnb6mVXev9
 QaAzQTdwWcmv2uKTYuF2jBkr80A7lWV6a1+wQ5/vtNJrxDdZC3o+wU7j5WSQj+2Jg/i/
 sw8A==
X-Gm-Message-State: AOJu0YwdQvh7DL4aiVjThfBIwnijsANWAskR6jZ6LK9RK9BmRiMHwbmM
 U/5hBIxeCmERe5UiLx9l4H3+78HFFotN29X4lQZXepNQGx09egbqq8VQsA==
X-Google-Smtp-Source: AGHT+IF3X+5xhwP0R56VVCjkzwRDEOFiWsCoC1p63ChEcR6YhANHZwZLyAYf+Epbx2h6q/nqivlTSw==
X-Received: by 2002:a05:6a21:32a5:b0:1b6:fadd:8862 with SMTP id
 adf61e73a8af0-1bae84aaef3mr3418611637.6.1718381091520; 
 Fri, 14 Jun 2024 09:04:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5aac:3864:3a80:46b4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc922643sm3219531b3a.31.2024.06.14.09.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 09:04:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240614
Date: Fri, 14 Jun 2024 13:04:47 -0300
Message-Id: <20240614160447.2087616-1-festevam@gmail.com>
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

Please pull this single fix from u-boot-imx/master, thanks.

The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36ea4:

  cmd: sound: fix help text (2024-06-13 09:31:56 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240614

for you to fetch changes up to 09d63e647a0eee024b493ad1d0e0d4a7a65ae500:

  board: imx8mn_s2: Update timing with production one (2024-06-14 11:42:19 -0300)

u-boot-imx-master-20240614
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/21125

- Update imx8mn_s2 DDR initialization to fix USB boot.
----------------------------------------------------------------
Michael Trimarchi (1):
      board: imx8mn_s2: Update timing with production one

 board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c | 23 +++++++++++++----------
 board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c | 14 ++++++++------
 2 files changed, 21 insertions(+), 16 deletions(-)
