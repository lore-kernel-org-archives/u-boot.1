Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB5C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4997083390;
	Mon, 11 Aug 2025 07:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RZZ8VLmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6E383330; Mon, 11 Aug 2025 06:30:35 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE8683323
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 06:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mcarausu@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-33245e653bbso25640121fa.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 21:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754886632; x=1755491432; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=igp0WM6OKetk0LZ0DVjsGupcDmzTEHS39NHF0vQBjBU=;
 b=RZZ8VLmt7VdQC2BDI73Uh4uDJn4UoXljzUHdn+lrRtcYkcr8ZnGjO+BkNFe9WAffYj
 2iZYYvjtN5/AUg/VcFEx6m3LhnxZCjQlZy/s7zi5BfQ07g5PWI5zGdUlEXgyzK0okELk
 V5A9k2IUyGk2oY+NMaRJkvGNwWPL1IvPAqQXJUJRPFBCwSHrwl9psY+x3MupeOqs/E1I
 uToNraffSdwhRboK/iF9F2+P04GHq5AY489Lmb/R4gCgUPuFAkmhEmfW7Z/MSlyVD/yp
 q92SkzZznOVyceUxrwn42MMlOxLXlvaq9Fi29KbyFaOgPPALHq7mZuenW+BsYbeClffY
 nU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754886632; x=1755491432;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=igp0WM6OKetk0LZ0DVjsGupcDmzTEHS39NHF0vQBjBU=;
 b=gJ9c0nHPtfb/0W17oGN+DyGukeIXbu0M7xHRlMqCvR17Y/23Pe1Q5i4kI4u0MNoLzs
 t0u7yv1lgk1V8cizcCLtoxYBLe8eMs46uuypLiLC+Cr4RgT/FCuQ9fwyT6bmPCGWateR
 Z2s012KF5JxxfzpNfI0X8nHu/S7mmnzUU6QA/OpCeAlzjJGvxlT23z2yBlCPt+fp9Hfi
 3nC54wWyknk8+9ir+DXn+PMCyJW9HT+CNCP1OJqwBCOc69DOYOT52DAcKe/V8yszJLNi
 rNdQwI89STRTIS7lIbjG7BLR7AWv/mOYQAzBFU7bLSuPQiwa6iV9m5hFOvtBhBk3VJI1
 m/wg==
X-Gm-Message-State: AOJu0YyOpN3U9ArXEA42JduetcouHCqCdif5Wg4fgH1g3dEZuBhv1O/+
 GxHF9IPkL6hje/TGeMWq3riRS1GHRsL6DbGl5XSjVV8C8ScoumBlG13t4uuJWNJt9aUfkjAZty1
 oTw3OFtljrRan36+HLTYXJ/5IxQE5uK+YRbHm
X-Gm-Gg: ASbGncs7eW5rkaLDHVr8s/FdK0Pi1zbbucHT5U5xaaXBO+n7f8vz5ALGTZ/viFJEG6N
 TgdhXLlWNBQvhBqc8u8eMytMVjz7m5l0eIFqwbP/z/LbyLyFu1qwUFx68N9LYc0DSId23WNw5KB
 cacVVJ76OUhWA1Y6+swZuREweLyEQBf4NkXFaNgldqYJ0KYLp83sFAJIrlsfyCcAfOgnxNsi57j
 cgj0fImNxGKRPEY
X-Google-Smtp-Source: AGHT+IH6ufVDk+YL9UFxE68c47Uyrun9yVetQCPPnRN4/U2y1yUYFRG8Nd8WKjrH6dhUiV7TNOCVdC9ejOUwXIagigk=
X-Received: by 2002:a05:651c:1109:20b0:333:ad65:c549 with SMTP id
 38308e7fff4ca-333ad65cdf1mr15368211fa.25.1754886631669; Sun, 10 Aug 2025
 21:30:31 -0700 (PDT)
MIME-Version: 1.0
From: Mircea Carausu <mcarausu@gmail.com>
Date: Sun, 10 Aug 2025 21:30:19 -0700
X-Gm-Features: Ac12FXwtj9TUXgaBAZAsxOh6GqZNyETZT1OKPXiJoddwH90RIq0x1uAyqkM2VKQ
Message-ID: <CAMFYzVwEtRBndhOaog8wStZeBTZvei_gdZ8=6xM2y1=SU5R1cg@mail.gmail.com>
Subject: How to avoid the need to run 'env default' command on modified env
 variable
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:03:08 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi All,
apologies in advance if my question is trivial:

I am changing some critical variables in the read-only / compiled-in
section of u-boot env variables via CFG_EXTRA_ENV_SETTINGS in
include/configs/<my_board.h>
All I want is to have them take effect automatically (i.e. without having
the need to stop in u-boot console and issue the env default command).
I see the new values if I use the env default command.
Since I am applying the new config via a RAUC bundle and some systems are
using automated testing it is not practical to issue env default on each
board.
Is there a way of telling u-boot to load / use the read-only / built-in
values instead of the ones stored in env storage?
Current behavior I am seeing in my setup is that old values stored in  env
take precedence.
I have dedicated storage in eMMC for env variables, which is configured via
<my_board>_a53_defconfig  like this:
CONFIG_ENV_OFFSET=0x3e0000
CONFIG_ENV_OFFSET_REDUND=0x3e0000
CONFIG_SYS_REDUNDAND_ENVIRONMENT=y

My platform is a TI Am64x.

Thank you in advance for your attention.

Thank you,
Mircea
