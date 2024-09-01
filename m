Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A1EC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F5688916;
	Sun,  1 Sep 2024 22:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LsvIdIOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EB088B9C; Sun,  1 Sep 2024 22:10:06 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1866988916
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a812b64d1cso164113885a.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221403; x=1725826203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ak1jMBbCiAKD3xamOTfiJiJrCDQPtx4LCGLr4aXQsnM=;
 b=LsvIdIOd0Cy00WP41aw+pJj5dHNGviasrDa9KwevIGhBjVXNc2Oe64UfkdQEpS+iDB
 IbjMxOWzq7ovjq2GSsiDuJcp9EigNkMCUEl6+wAH6V2Pyypr2URIr1AR+p5ArcB4p5E5
 nBNIpdR9WaJz7ShJ51k4fEuSe4OIgBgbg0idU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221403; x=1725826203;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ak1jMBbCiAKD3xamOTfiJiJrCDQPtx4LCGLr4aXQsnM=;
 b=eryeiaQYb/BzGn53iZWwQ9mNKgl8YmkqefI0NY15ZP4GKW0jktwDsU4tTmjGASieUS
 relBjxQtmC9qi8GXt18HWO60v1DOo8YLvwiDCsMMcZKlo4MQqJ2Fmi4TzP+q3iIaWhjW
 IM4yfPUFMVxLJpJvYf7ehW2715gkvnBROUfLltXNpxYKT7AjpvxNNkId7dcy1M6yt+D5
 lymDwjompegBygd3Y8Hgp6Cg7i2JZlINLBMBV/80Pe92pIaD4Igp4nC0HbzoKKBUGW8Q
 DpJFwNBymNAie1LrA7pEPz4v71qaaXCgNYK14yLQhENjXxnTaStmeKP2osVYkDv2iZbM
 5bCg==
X-Gm-Message-State: AOJu0YwCl5OB/mHTlxJ2LHT1nIF8nGD1tEg0sOddqOlzEU3LQgVq8AMq
 njxHUuSVE78m99Y2k+7UrD3bln1IJ34FCA0jxq5FoixcPEwDazGgkmlNAY2g12hmW4eShdKEDzu
 sm1ZjnMvZtZaokqBzspVCmD9GEhYPsLQKND2qIsm8+fC5SV8=
X-Google-Smtp-Source: AGHT+IHF8S8PTZmTb9yUgKc/5fxgWSH0EissGoWa0EMGZcpehcu9VGCSA44MGbUHd0xcCiAza6w7k7/pIzfMBVkXjQQ=
X-Received: by 2002:a05:6214:3d9e:b0:6c3:5346:ede3 with SMTP id
 6a1803df08f44-6c35346eec5mr73956466d6.12.1725221402869; Sun, 01 Sep 2024
 13:10:02 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:52 -0600
Message-ID: <CAFLszThCKjb92drKN0AkVoqJ1gbz8e_=vif3tOjkfwGcmG+x9w@mail.gmail.com>
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

The following changes since commit 57949a99b7bd0aa21abbde1ffa7e50e5d9e10a4e:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22192
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=67&view=results

  Merge tag 'u-boot-imx-master-20240829' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-08-29
08:15:37 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-1sep24

for you to fetch changes up to 4597acbd5943a53afb8aeb9595f2ea5a40e1f99f:

  qconfig: Fix an incorrect format-string with negative value
(2024-09-01 11:05:43 -0600)

----------------------------------------------------------------
Minor fixes for qconfig and patman

----------------------------------------------------------------
Brian Norris (1):
      patman: Resolve python string vs. regex escaping syntax

Simon Glass (1):
      qconfig: Fix an incorrect format-string with negative value

 tools/patman/commit.py      | 2 +-
 tools/patman/patchstream.py | 2 +-
 tools/qconfig.py            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Regards,
Simon
