Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08819EE49A5
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 19:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB42864A0;
	Tue, 22 Aug 2023 21:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XaVb8So0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 103338649F; Tue, 22 Aug 2023 21:46:54 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBC9864AC
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 21:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-523476e868dso6042224a12.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692733609; x=1693338409;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Oxpdm7iPqFIM3zmYDlu28yywhCMGmNyb1z1h4rrkEvU=;
 b=XaVb8So0kHxAZPI6qF7udPogb54rtfUBMfF+0XJ11Fxe0Six5Etp514xfELlfzWh+p
 z47XKCV78Uhl9HDE++UGwk9ZjWPJHObbzzLZHY396hGQvBvTp634tprPKnCD9aGlQGNI
 qPP8n1N2ICgm4MNMhgVdu+Law0T4xOa7upe+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692733609; x=1693338409;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oxpdm7iPqFIM3zmYDlu28yywhCMGmNyb1z1h4rrkEvU=;
 b=XoBr5pc4D7khxvAJF+Q+O37oQwolZMlT3KlTiwlUDvjAcHY5ZfiMg/ZM0Vsz12x8oQ
 WfUsn+OCkzS7hAZBwFoDvMoFOrU422KtLWRlZLlzrvxheh/LcNyPk8pH7KSSJep5jv8T
 VBnn4RbjCMxHsmF3+3Z++GzZlInfUussEXScRNU2Cwu7CmRBivO0hthH0ga6r7qaJ5+X
 FUFZnonIiSd4M6ciF/rjKS/8YRpm2oeWsofSvklccI9PNBzyWinNia9enpFbuDh0MNvK
 MQ1fJfkNgsqnTR9C1F7DttSX3zcqW4bkdcLZ7jE3uucQyrJ5ZldHxgQC320GmMh8xwYI
 0F+w==
X-Gm-Message-State: AOJu0YwYS3jqr5HGGp58xmApnN4itiQEPPtKbLvOOHtZkWKrtfU8vl4T
 eXokQGYiCNmJE6QjorfoGv1MmrGfGTdsmSNdN1Q+9HgAb4sI4g9UJrLAbw==
X-Google-Smtp-Source: AGHT+IEX3jZLZ/6sZ2i5njydFFDXC3shE3l/tQfstNIv4Ag2XhzJcd4YMxvxcCjBqLjHbYJECkCKtXoJlZvK6C+W5V0=
X-Received: by 2002:aa7:d6cd:0:b0:526:9cfb:c12 with SMTP id
 x13-20020aa7d6cd000000b005269cfb0c12mr7981058edr.38.1692733608644; Tue, 22
 Aug 2023 12:46:48 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 13:46:36 -0600
Message-ID: <CAPnjgZ1h135x7Sp7yXj2FxFdwr8zvVvM-JgzB_s+Ra=9yDMObQ@mail.gmail.com>
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

Hi Tom.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17476


The following changes since commit 976fb2ffa3875a7bed9866bf5cf939a81c423ef8:

  Prepare v2023.10-rc3 (2023-08-21 16:19:59 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-22aug23

for you to fetch changes up to 1c55d62fb9ccc107cb4fefa9bb04cb16395ca84c:

  riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback
(2023-08-22 08:07:54 -0600)

----------------------------------------------------------------
RISC-V fix for CPU init

----------------------------------------------------------------
Chanho Park (2):
      dm: event: add EVT_DM_POST_INIT_R event type
      riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback

 arch/riscv/cpu/cpu.c | 11 +++--------
 common/event.c       |  1 +
 drivers/core/root.c  |  6 ++++--
 include/event.h      |  1 +
 4 files changed, 9 insertions(+), 10 deletions(-)

Regards,
Simon
