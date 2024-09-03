Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DABCD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 17:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBB788BBE;
	Tue,  3 Sep 2024 19:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QZUvHXZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E1D88B49; Tue,  3 Sep 2024 19:10:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF96D88646
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 19:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bbc70caa4so37346625e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725383407; x=1725988207;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fBzqivPZTPTpFxcqckwdJ7L+Bbe65D6DbtGwktqoaHg=;
 b=QZUvHXZSfEVch0CBQUExipAUIr2qoH4mgeq5wGIo2+XYVaUIXZXPzu/2jpvTp2zQ+W
 0Ho8YEX0F1cdss8w+RfzeJe+pLVOSi/asv91YSV8VRkFzEzCOg0iWm/pXnMSWh4dPkhs
 IM2Loocat73GCAQo0B4cH2Dn3fZITOq1nrAdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383407; x=1725988207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBzqivPZTPTpFxcqckwdJ7L+Bbe65D6DbtGwktqoaHg=;
 b=YeVEiTad5m70Xiugaf9/ndLZ6SIyQs0g90585KOtKh3IKPeMr8TYg4m7WOaowh5tJm
 VyZ+xRcAxVw9cgjBnmNp5nRK0I7IBpbpRcpaB9L3yYpl5OzGLA9FSmUQcu76w9N+AXEV
 CK9tDgZMZ+qf/06N4fWFLqNi+/P5QkeM//+FIGOEZQOmta5gPqAeJUhdyaExmLCn+/wf
 Gn08z7HNgBcTJj4rQn8+e4SEDxohtTtzStSuO77mhwP07jp1cuv3D1b+c/25ccf/g7Q6
 6ml8Z7WJ2ee5HRXeMfEH6XFIx5BKDruEGu5qqpXxlxunYwk9lOYsqPwwZoJP7nrHmHGu
 F47w==
X-Gm-Message-State: AOJu0YzFI9umIFzoZ2468Eoz66/tTKwz52YGs0Vjf+moj+IYi9Runq9k
 VSEpGVwEfEyxo48SoQr3n9/TLpOMM3w9aRQVIBiUgc+i5viGEkSheWDg2wu4LhZXagawvOUIMDn
 q
X-Google-Smtp-Source: AGHT+IEawyKSVoXImYrOt5hSCT08aTd1bNVReNEtLYsw6vzxjMRg/PvEbIeUd2WMsrRZaD9FCOkumA==
X-Received: by 2002:a05:600c:4f47:b0:427:ff7a:79e with SMTP id
 5b1f17b1804b1-42c8de7b311mr12700865e9.16.1725383407126; 
 Tue, 03 Sep 2024 10:10:07 -0700 (PDT)
Received: from pwmachine.numericable.fr
 (2a02-8429-e2c2-8d01-f9a2-0489-9dd5-0071.rev.sfr.net.
 [2a02:8429:e2c2:8d01:f9a2:489:9dd5:71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm146364975e9.9.2024.09.03.10.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 10:10:06 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 0/2] Bump new hush commits and fix old hush test behavior
Date: Tue,  3 Sep 2024 19:09:41 +0200
Message-Id: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
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

Hi!

With this series, I bumped the new hush to get the latest commits from upstream.

Also, I added back a reverted commit which goal was to fix a bad behavior in
old hush test.
I had to tweak a bit this commit, but everything worked both locally and in the
CI [1].

Francis Laniel (1):
  cli: modern_hush: Add upstream commits up to 13 July 2024

Ion Agorria (1):
  test: hush: dollar: fix bugous behavior

 common/cli_hush_modern.c   |   2 +-
 common/cli_hush_upstream.c | 150 ++++++++++++++++++++++++-------------
 test/hush/dollar.c         |  31 +++-----
 3 files changed, 110 insertions(+), 73 deletions(-)

Best regards.
---
[1]: https://github.com/u-boot/u-boot/runs/29350673974
--
2.34.1

