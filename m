Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107D9C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A1E83236;
	Fri, 23 May 2025 15:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BfGVl9Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4138310F; Fri, 23 May 2025 15:18:23 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2492983276
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so1492281066b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006300; x=1748611100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=buJ4WM5Tx7fdj86pAZ7iZUnfVEfccPTH83ReT9R2MWc=;
 b=BfGVl9CfNXzVdiVpI4NGqvGnwmCRCYyboomKYSSZVi2PWAKt8qe/8DdaTzxVdESPve
 TTTV/qLW9rrG2RPUXcGfyQFhfVsMyu4GX9TZEH05f2I667ivc7skn1ntgh03MQSob1C3
 4QbJFiMmnq0+YbjGUtMKG/GBLq4kDyzBF17aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006300; x=1748611100;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=buJ4WM5Tx7fdj86pAZ7iZUnfVEfccPTH83ReT9R2MWc=;
 b=CUgCj2M8kAf8J6yaF7/v4JhKuhuSnuccnnm9y5hwY2cLh9sG6LymhbKRj2qBHkLvu0
 wAjeF+AaDWzia32WuekgPjzikoF/OmTpvBbkkthn6UV8ObLMrb+g64897NAm2KsAOo7W
 vlixVCMEq4HYouBreAqD4ivwJX3HvMnA8Gi5nCk078Fi7S/zbgUtabdEzZ+RSwPd010z
 ZVs9vMVqaVneaIRT7ZS5+Ga+igXTMLOl3y5QGU2XfhIkhG3vU+wgs8nxkY1sXeE9oFfe
 Xwxd3NM/xHlgNZzKX1dJhmKgPqc6fZqKmf+gtM5w5H6k9bC/APDqamNlqJCy7wPxabE7
 ijng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYdFpQseZWXTaYjPcpGnrrT6g+1zxgK1fX5TbMBX2dv5lRDx1xPGisninyWZ/YV2LmHI1DbFA=@lists.denx.de
X-Gm-Message-State: AOJu0YzajtXqwWO13PgCsD5j2DCGkl8bE3iqdKS2d3nB7msGV3xoWpu8
 dAgphIK2bt8Q5d0Jb3B/zBwyJl2FC57JDy3YwLaSsTJuQl3oJ9VrqiCPXGTYBXXazwv5GT6AyJw
 ni4391wx8xnZTJMn/GhbeNwnpTs5Kh4kyf3CcqtyB
X-Gm-Gg: ASbGncsoNBQTTRc0MixlvtO+ObgeTDBP2mcQpCDsfX9BmDIdlMdFXdsGG+AzW9iDjBH
 x2N/bxPmqM2t6Npu3X+uAiolHt/cV1jNBCrMyGbcbjbqM3axHx6t7d/rFfP4k98yS23PKrTxGiA
 qdsVOYIKqCrjtrloVqjLe7fM9fXt3gByrUNA==
X-Google-Smtp-Source: AGHT+IFmnwC1O3FbPXAkrGY0+bxCzVKH/qBmjQ6h+Du6FuiiOQIWX615Tgw+i4ToAHSUgSksvmzm3VgZhUjHiT44YvM=
X-Received: by 2002:a17:906:230a:b0:ad4:f6d2:431b with SMTP id
 a640c23a62f3a-ad536dce6cfmr1965314566b.44.1748006300630; Fri, 23 May 2025
 06:18:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:19 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:19 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-28-sjg@chromium.org>
References: <20250504132356.2317305-28-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:19 -0500
X-Google-Sender-Auth: KLgGMo3J7Vsat81jP65hf_JxOfo
X-Gm-Features: AX0GCFuT0SGKXCUYE16c-SGwTcBtJySV6gDZUhcvwg57FcNoE8l-Ly7wI7hqZak
Message-ID: <CAFLszTggZwiCZ2VL3y8xhBawqZApuGOcErGL5UtOyhCY2sWaqQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/30] patman: Switch over to asyncio
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Now that all the pieces are in place, switch over from using an executor
to using asyncio.

While we are here, import defaultdict to avoid needing to specify its
module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |   4 +-
 tools/patman/patchwork.py |   8 +--
 tools/patman/status.py    | 137 ++++++++++++++++++++++++++++----------
 3 files changed, 105 insertions(+), 44 deletions(-)

Applied to sjg/master, thanks!
