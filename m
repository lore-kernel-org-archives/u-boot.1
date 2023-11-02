Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D977EC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E00918774C;
	Thu,  2 Nov 2023 23:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A7o3MLyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72387743; Thu,  2 Nov 2023 23:49:25 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2CF8774C
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9ac31cb051so1514722276.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965359; x=1699570159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBSOqYYaT4Kyi6K35rL5yZ9LbwVT1zZdccyacJWxBBI=;
 b=A7o3MLyC62dyPVRbPd8NPorxGLTIAOR12O+LlhTV3NN4E6ovaDd9sCQaJHCQHT/qM5
 1A4nnZyJ15/K5tc3kZ8orFY0eZ4g+WzSGc6UDbeYqHraXM/v4f0OM9MrwQYkdn8RPy/e
 mgI7u5Pu8gOzdkha/WZHDzi/0juUEumO7KTWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965359; x=1699570159;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBSOqYYaT4Kyi6K35rL5yZ9LbwVT1zZdccyacJWxBBI=;
 b=TwL2kSYVusYAkpvhk9cPipv6kHvUaW51hO2hoHeIH/xdhxtSSDYX6lluVbFP9F633o
 v3Du4NAtoHpP+Bv/Xr90M80KjcBfj8d7G+kEhJuA+p9Nh1KhSTj43tY7KrLot3UsWDxW
 vxX5HK/FrEtEo08EKxK4iEeCzjD4bStgRhB3nSCdxRnrI0f/s0HGqASCIDiyFv3qNajA
 5ERgSlAIkY4Mt6cGrCPnVWq3EM8N6U15pK1LbZno9BMf2Avmw5tq+hUoRJKhI/4ge00n
 1ALkNm81o1/9dSsiWUUwjU2rIk3uj1EIK4H9SphYqKncsXUugTc73f9xt7OeNj1DVtwW
 M44w==
X-Gm-Message-State: AOJu0YwI1iw9/fCmlE3+qhzCuUmKeLLI3L3p3n9+EpTZBVjaYqbpMapN
 znrEIT3ldnG2AoC+lK7DaCh/TMZAkchvZvTMhMwOQg==
X-Google-Smtp-Source: AGHT+IGZCNKcJWmMSHASwxZ9aiMw60KT0gFwenfO9h2gMFznH3Edxdwr5xpj9owvKZTgGNU37+IABUvemeUWwU4jyPE=
X-Received: by 2002:a25:ab03:0:b0:d80:1604:f6e9 with SMTP id
 u3-20020a25ab03000000b00d801604f6e9mr20425163ybi.44.1698965359215; Thu, 02
 Nov 2023 15:49:19 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:13 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231014204033.3077052-7-sjg@chromium.org>
References: <20231014204033.3077052-7-sjg@chromium.org>
 <20231014204033.3077052-1-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:13 -0500
X-Google-Sender-Auth: iV2sDkru-UvHXeYGJAQdU6G2Pq8
Message-ID: <CAPnjgZ2OZU_HjqUVrtnXeEAPA=3j5KQ11-Z8=w-LAXVj71n6-A@mail.gmail.com>
Subject: Re: [PATCH 6/6] binman: Move stage header into a CBFS attribute
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

cbfsutil completely changed the way that stages are formatted in CBFS.
Adjust the binman implementation to do the same.

This mirrors commit 81dc20e744 in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py      | 64 +++++++++++++++++++++-------------
 tools/binman/cbfs_util_test.py |  7 ++--
 2 files changed, 42 insertions(+), 29 deletions(-)

Applied to u-boot-dm, thanks!
