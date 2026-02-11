Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890C7E9E2E0
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D714682BF2;
	Wed, 11 Feb 2026 12:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F/tbTLe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B464683B30; Wed, 11 Feb 2026 12:01:22 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B68380050
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so4994134f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 03:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770807678; x=1771412478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zq9mukSB0k0GtKj3eAtLT6NzCfHPmdBrLZTf78gKW0o=;
 b=F/tbTLe8m3OCYz+MFUcw3OVk8kyeztCzmKlhyzpj4Vo18rMwg0z+p7jOxpt30xAyRh
 h0pMHGHvcE3UTWUx8H3fgzcD/Og3ps2vKOBq18jbMCG0zDc7BeouMH1bgpfWzfLPeZyq
 uqlTAg0P9bTJPc8LsNirwKggHu9Ys2G6toifWtkp+T1bXoJzhss5IGqt//tLQ3mglM2G
 SJLVwIigGHP3xNIq95QV+D9XJPQttwEKbPc2TMs5ytN/BZpMbSkTVWhJeHinw+K0a0sH
 BVtsyR/tsdjZIdTXLMUHNdkiZzIq2Y6gxVWNg9ztvX1odYRz4ywfR/M7iHEW8DC7boK0
 gDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770807678; x=1771412478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zq9mukSB0k0GtKj3eAtLT6NzCfHPmdBrLZTf78gKW0o=;
 b=YGPoSmjy39uoeVifY3kMMjWIX0+da7ZqtZhyIMEo7CwvIN89/Xgx7CCReTfwTv6OSq
 zVcBiLVYwfkfYhj8nA9fJ95vlrjgc4W7nGdCMRLIE1USa3cP/8WJ/yUzy5CeZdph6Zze
 LTEcu4B3FOJJh2D3PFcK0Gzxr8rkKGh5iAutWcu8zPOYBfWO1KIKdV4nnqYHzAUNyJx7
 1pNJFaivRY3xMnemwSg9mc9Vadaifhz1uLfiwL/+grEjA0GgTJNKHR0SEL8Fr4YKPyhR
 mmYFzReymWjPBQ6NEUiCINfraLpshc3zzbbxG42tVwkQJA6d7j2G8rahPWRlydsTNe1d
 ZG3g==
X-Gm-Message-State: AOJu0Yyd4qOKA+5/23ytKg7r8PzyPGdgHQ7zhvcVU6fNyzzsN4eLpn9y
 bJY1yD0BAK467d5r8AfBsx/GV/YFCyHtu/rDcwUxfhHBpwaUITwcuxnmAzoQPSx4IKUxwfQy12q
 0HrwGNmc=
X-Gm-Gg: AZuq6aIv966xSbWazaIZMSwG/3iP4EXz3qryQF0R5/laoZftt0leS12o3lf3ZYbIp6A
 tN1WY1doPagzwsrOxJcfvpMH0dq65NyDeuytDrP9pTGw3C9vuGyaD70hQ9PloSSlURW1q132L9D
 YqaTkpcumS+GuhX65XLkQ2DVpdlhVXrsWemkZbsjnyO7avYmyeqZDoid1j47kFFrm8FwvpHOAT9
 9Tw3zfmc0Qc8YWa+50gwHoO3XUHL5/x1kdIEBE92ugFi9O4YaXLRrVWfACJf77n3rSbSkpG8iYq
 5QscVGXfkwaMhGQ+7hU3ehlzyphNnxKwvrWJnsWAYUvl3bGKWi0BSDtwRyGKb9FxUnG2JUJsxss
 gyLWZuFTTnHl3KqPyHEs4dVD8k466O5sWQyXyjpUNANv84RwyHNJbQ4gZgnMb1KWDJyC7T1p4TI
 jV1KosQzwVg65uMrvPAl+VvnGdALVzwF9F/PmVf6O+KZA0n/lkNIBvLWUWmiJUwas2xl8Bc5/Qb
 Wb8dXlWVNePYTywOvGN7JOZR9RjXJd/gxaYsnpm3TCtmKV8wiY9FUborOP9W3h2sQl6ZMlLCmqw
 1wDyeaCHFYqfvBLae/FLBDyS0iYH1SyGNl95+GUpjddtnl4fe+WZxeBG/9QcXbAJXi2Bledu+79
 /FuA9rLXpROc/aAdSx8SNr06Y/tY4a3SJNLpR2nEAKCkEN75bqGbEN1FxJxWXKR+ogVCVpF9cul
 08nPACq/fAqoC6fbnaAW7nFdFKl+PwqKsL9XGrFoNa/aJnJdgZ9soC3YxFSRdt
X-Received: by 2002:a05:6000:25c4:b0:430:f241:a11f with SMTP id
 ffacd0b85a97d-4377a57c696mr7325966f8f.30.1770807678290; 
 Wed, 11 Feb 2026 03:01:18 -0800 (PST)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e38e26sm3846434f8f.26.2026.02.11.03.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 03:01:17 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	kory.maincent@bootlin.com
Subject: Pull request for ab-next-11022026
Date: Wed, 11 Feb 2026 13:01:08 +0200
Message-ID: <20260211110108.66433-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Hi Tom
A PR for the AB support from the TPM tree.
Kory has update dthe code to mark invalid banks. Those will now be
skipped in acase of failure, instead of trying to boot from them, fail
and fallback to another bank.

The following changes since commit b99da05e1538b8fa153322da82917af2aa27e1d6:

  Prepare v2026.04-rc2 (2026-02-09 15:07:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/ab-next-11022026

for you to fetch changes up to 9367b8d9339f07d83aceaf03fcd89bff9d59f727:

  fwu: Mark failed bank as invalid during rollback (2026-02-11 12:17:18 +0200)

The CI seems happy
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29254

Please pull!
/Ilias

----------------------------------------------------------------
Kory has updated the A/B implementation and added an invalid bank
state. This is already described in the spec and can help boards
boot faster by skipping banks marked as invalid

----------------------------------------------------------------
Kory Maincent (2):
      fwu: Pass bank state enum to fwu_state_machine_updates()
      fwu: Mark failed bank as invalid during rollback

 include/fwu.h                | 22 ++++++++++---------
 lib/efi_loader/efi_capsule.c |  5 +++--
 lib/fwu_updates/fwu.c        |  6 ++++++
 lib/fwu_updates/fwu_v1.c     | 16 +++++++-------
 lib/fwu_updates/fwu_v2.c     | 50 +++++++++++++++++++-------------------------
 5 files changed, 50 insertions(+), 49 deletions(-)
