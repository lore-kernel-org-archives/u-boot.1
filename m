Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67914C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A718987930;
	Mon,  1 Jan 2024 17:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I7Sl573O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000D88790A; Mon,  1 Jan 2024 17:53:29 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91B687910
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67fb9df3699so62167786d6.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128007; x=1704732807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHrCzpj6dLgGe/pAaVukS6R6B6bUC9FAjDXeSCTgRu8=;
 b=I7Sl573OWRVoUG/6R5fxGrDn9K2/NCV17JgGw/1tx6APfTJhw8kr8xSp3+JTWMcjc6
 YrAnUN9RSETYMTlKFoklCi7aVMUtTIvmTWZ5XWL5SZkd6chtXDwns/hpSNv0ELdUQcXP
 yU6ODi5BL4CgM1W0Rc+KwnN/kXMYkbxhQp0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128007; x=1704732807;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHrCzpj6dLgGe/pAaVukS6R6B6bUC9FAjDXeSCTgRu8=;
 b=X2CS6fOYtAf0nQ+s2HLjxmF1iD5/F2r0pdLVa6ryN7aPQkHWMloMEbDfXOX6mkWyTX
 bm8bCs2I6GGZ8BkMNO6mRAZ3GcURk5LZOT2DMVqL4VLqeCCj0VrWTAHUtIxe7iFR21lR
 Hluk0mYHAMJSF7Ij3USoGz0fP1JGpwVAk6hAxN4PoYzszoA+p9+2ME5MPUoGO9vhSPPo
 VljY1SzKnvsC+EnPyehoYFHAgfXVhVBzoW/AlBoz+i4gCVhSLLCrzTWNd57xRXPixj39
 jQImHKv9kXDyjyfbovbQl21sE7YZagR83kN7DMqim91OmXyvQ6MhUohskGCpc0UI2eKk
 ot7Q==
X-Gm-Message-State: AOJu0YzRy29TmMr09XewKn/hSjqvUhnUD0Ks6qYshnCubco/zM2CFwBM
 Qt5z9tZsT2mbtqBb7gfw9FcRsE4W8nE8d3m/t9ry4fcg2U7d
X-Google-Smtp-Source: AGHT+IFTrxhAnL2OEwfNUs8hCvpWaloWsXtvZJqolQNUfj6iUMedgFVKPcAJe6YPdUdve1Du20l/S03iUztL1aOC4so=
X-Received: by 2002:a05:6214:5282:b0:680:b36a:b52e with SMTP id
 kj2-20020a056214528200b00680b36ab52emr3008417qvb.83.1704128006803; Mon, 01
 Jan 2024 08:53:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-3-raymond.mao@linaro.org>
References: <20231229174244.892818-3-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:26 -0500
X-Google-Sender-Auth: gjWYLEeDDUBtgHLoJwQMu-MPerU
Message-ID: <CAFLszTji2z2T3_j4GByX7vbfqUwaZLsXaf9GjeEUOJN4G=h4_w@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] bloblist: Adjust API to align in powers of 2
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

The updated bloblist structure stores the alignment as a power-of-two
value in its structures. Adjust the API to use this, to avoid needing to
calling ilog2().
Update the bloblist alignment from 16 bytes to 8 bytes.
Drop a stale comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Update the bloblist alignment to align to FW handoff spec v0.9.
Changes in v4
- Update the commit message.

 arch/x86/lib/tables.c |  3 ++-
 common/bloblist.c     | 24 +++++++++++-------------
 include/bloblist.h    | 12 +++++++-----
 test/bloblist.c       |  4 ++--
 4 files changed, 22 insertions(+), 21 deletions(-)

Applied to u-boot-dm/next, thanks!
