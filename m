Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD78C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 13:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE03C87E71;
	Fri,  9 Feb 2024 14:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iHWOmGPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E7E87E79; Fri,  9 Feb 2024 14:40:42 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46C187E6D
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 14:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41047395814so8252815e9.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707486038; x=1708090838;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j9Y7PWcnYoCpWR8GWPRoht0MZm13HRPqJVr9+kR0nbU=;
 b=iHWOmGPiDavKWcJinaHhEquG16xILalkLcWJqzMeGB846IR7M2Odc2Z87XQXL+tOwF
 o+8tIQ+4k1aIdN5zx6FLQGkT0e26gWK1a38wcDdBgH6H1qUU/qgem3kpDZtveTnZY08h
 VKbk8TMz7AiVwqWk+GOaxiI2pp1myHToP6TlhAK0uBIMk7zYXJvkj8IwzMoevpHM3Isa
 biEH7INUaoQhPV+hSDYnjLnBUwlDRdgXex3S7Ur5EqkMHEef6De4QBXVMB13p+8Wh6+K
 cNbRI+aLjccPO0tYSe5ex4glbubMmvHgO8QLwDqwAEkjh3deQ7r7X29H+4KBAvLQzFCf
 fyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707486038; x=1708090838;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9Y7PWcnYoCpWR8GWPRoht0MZm13HRPqJVr9+kR0nbU=;
 b=bnjGoe4Cxmy2nE4/sGNI08B2KI0ub67iFN28ae5NNyZctI31Z9NrOEqG1L+5cQocz8
 L2Xdawsq9SKK7QWea3on+mOVDo85Hz251gIiLsa6flofpBZ9BP3ikTFR4YEb3reMFpfj
 XbR4d6YG8lk1GfthxqTHUZokPStMQJ6DadeDjZ/0nYnHXPpCpr02QXYXM9czqa+gEh/H
 Dw9U0JJnkm6df1ZUqVtZvsIRxI+cFSN/H8AxXpK8kppYVnMhRi0Ax++AxZYrn5S5lEKQ
 KbPyAR3gW3ukDM2X/MkUGTCbLDImZA+p5lnZG/NCzvzThV2dBTXfdzAyuGgu0WYYPERz
 R4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVym4TH0O0RKgULcB6Aj3sCuJbBv7YoSkYUlSoI1H0U2vq6z4vwiwSvClkrOHWnQZ8Ahtpm4mO2X1Njal3OoBJmqL7bAQ==
X-Gm-Message-State: AOJu0Yw7+H7Lco/0BQBPoTZNhAjHY2EbvcOqoopjt9+zZlT8wwfXg1td
 lnazCA4bFgEzZEwHiENaeKZLLR9tCn0nKGX052wfz5R+EfpBI1shVwLfPkii0fYP2MNHEW8JIfm
 s
X-Google-Smtp-Source: AGHT+IH1SMDQCIRixNEMxLDjHLdyATLpeSnvhBw/cs+H1D64FgwMjmUWe/PdzWSS4NMLqYL/pgA4jw==
X-Received: by 2002:a05:600c:19d1:b0:40f:b691:d3c1 with SMTP id
 u17-20020a05600c19d100b0040fb691d3c1mr1237545wmq.30.1707486038682; 
 Fri, 09 Feb 2024 05:40:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRYClBJch6c9DBLMuzsCPurUdbhVFsn0ftk7YlsyTVRfIxCQe4gvzBjBjjyTvfAC0RqOx/FvZ3L4IcQBE0kSB5jH2coULRAP8arwHBnQQ8sWuAmsQF8muxnEDCPg==
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c22da00b0041004826669sm664160wmg.42.2024.02.09.05.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 05:40:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20240209
Date: Fri, 09 Feb 2024 14:40:37 +0100
Message-ID: <87jznd21t6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Here are some developments for master including:

- sparse error checking fix when using raw chunks
- 2 new additions (AVB, AB) of myself to the MAINTAINERS file

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/19573

Thanks,
Mattijs

The following changes since commit a4650bf65e4b7d3ef04c90ba8031374428e4a682:

  ti: keystone2: Move common Kconfig selections to under ARCH_KEYSTONE (2024-02-08 14:42:56 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240209

for you to fetch changes up to 766f04a297e892d5106f7f7ac8b43c69bd8a6007:

  lib: sparse: Fix error checking for write_sparse_chunk_raw (2024-02-09 09:42:04 +0100)

----------------------------------------------------------------
u-boot-dfu-20240209

- sparse error checking fix when using raw chunks
- 2 new additions (AVB, AB) of myself to the MAINTAINERS file

----------------------------------------------------------------
Mattijs Korpershoek (2):
      MAINTAINERS: add Mattijs for Android AB
      MAINTAINERS: add Mattijs for Android AVB

Sean Anderson (1):
      lib: sparse: Fix error checking for write_sparse_chunk_raw

 MAINTAINERS        | 2 ++
 lib/image-sparse.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
