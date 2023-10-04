Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFBE7C4EA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFCD8768C;
	Wed,  4 Oct 2023 20:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="btiS5GmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043B387689; Wed,  4 Oct 2023 20:00:48 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC07887662
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 20:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b9ad5760b9so18415466b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442443; x=1697047243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v1EE3yLpAYaM6+Ch8JYtY4zv8eQ6FeCAIf98u2I3qFk=;
 b=btiS5GmO7CbdNqlgQINpM8kpS9uY7b89H4pHliJMpzrgq0T6TdafSWYaEcf4d63QkS
 QCgzJWeOOCreSqpzHbanxPWepFGT3LMaxqTChnaFqPudbGqnYOXMqug+XUy8JSrfLEN+
 CyanAnSuZRdidQZ76ihUkSfEk5rSLHtcP8b14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442443; x=1697047243;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1EE3yLpAYaM6+Ch8JYtY4zv8eQ6FeCAIf98u2I3qFk=;
 b=fZ+LHDEPG8XmIBdccW0kKEG/xMgqhUIa7hyGh6RvlQ4hQfHdEk+3HExLXblDXhcg2Y
 Ia1eP/u2Rj39GTkICsuHSAmH0UNAx7x8Jxy7Kb1gURE1MAksX2iVXJLuuNcRIW8iZbIx
 iKN7iCzm5hAhSowAXIoiNXyj7Y2mliBgoaWk6WD8TbqjGzf2KFxSQKsOfgXsYm/zqzPt
 So2bF83Uo2l9DLA4oxu9NXrXhnoXZIdGKSdpRBaGT1NrwRvBMxgmEyRs7v/zPUfFJZAw
 AgzYcdOUla9Mp9RMjlCfEZWQque2pulZ75oXao20vPbZmIOf4Su5wMgrSySS1rEUJr1a
 1k8w==
X-Gm-Message-State: AOJu0YwzKxwAylG0qTwtM3NQHoLrk4tmcZm6yWglZnJzvdB1s0oBQ1ES
 7zTp6AcgUDrk1PnBPr6bbCmaAWldRsDhCQCVn5Yf7YIoWOdm9ImsgZzbTA==
X-Google-Smtp-Source: AGHT+IFKIiNXiTCpopwrGkqGJnwuKl67WnDGsAV9VrmcUo922skYP9OscHECj5I2+Zo4ROz3s4F+5IhsKjCsk3+PuwE=
X-Received: by 2002:a17:907:784d:b0:9b8:e253:9a1e with SMTP id
 lb13-20020a170907784d00b009b8e2539a1emr1886227ejc.38.1696442443274; Wed, 04
 Oct 2023 11:00:43 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 12:00:32 -0600
Message-ID: <CAPnjgZ0V5_UsZOPPX_sjNECHTzC-pgFqMsfuNWP0-kEe5dZxRw@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18014
(usual azure branch but I cannot get the link)

The following changes since commit 65b9b3462bec2966911658836983819ab4e4823e:

  Merge branch 'next_pinctrl_sync' of
https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-02
15:19:02 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-4oct23

for you to fetch changes up to 4840b71bb009711564e20f9695b92950c3f73e42:

  qconfig: Update the documentation (2023-10-04 09:25:22 -0600)

----------------------------------------------------------------
moveconfig: enhance output; rename to qconfig

----------------------------------------------------------------
Simon Glass (28):
      dm: core: Adjust dump-sorting to get stats only when needed
      moveconfig: Drop -H option
      moveconfig: Avoid deprecation warning for setDaemon
      moveconfig: Correct ordering of asteval import
      moveconfig: Drop unused cleanup options
      moveconfig: Drop CONFIG-moving code
      moveconfig: Drop check_defconfig() and update_dotconfig()
      moveconfig: Drop suspicious boards
      moveconfig: Correct some regular-expression strings
      moveconfig: Correct parameter-type warnings
      moveconfig: Use f strings where possible
      moveconfig: Correct unused variables
      moveconfig: Correct non-snake variables names
      moveconfig: Correct use of members not declared in __init__()
      moveconfig: Correct list-comprehension warnings
      moveconfig: Use an encoding with open()
      moveconfig: Fix misc pylint warnings
      moveconfig: Only show output when there is a reason
      moveconfig: Reduce the amount of output
      moveconfig: Avoid showing progress at the end
      moveconfig: Use u_boot_pylib for terminal colour
      moveconfig: Show failures in progress
      moveconfig: Show a summary at the end
      moveconfig: Drop the initial output
      moveconfig: Move summaries to the end
      moveconfig: Rename the tool to qconfig
      qconfig: Rename the database file
      qconfig: Update the documentation

 .gitignore                                  |   4 +-
 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 160 ++++---------
 drivers/core/dump.c                         |   3 +-
 tools/{moveconfig.py => qconfig.py}         | 894
++++++++++++++++++------------------------------------------------------
 5 files changed, 273 insertions(+), 790 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (59%)
 rename tools/{moveconfig.py => qconfig.py} (65%)

Regards,
Simon
