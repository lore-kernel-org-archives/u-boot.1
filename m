Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E8EE49A6
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AE087002;
	Sun, 20 Aug 2023 23:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HON6b0pS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5B387002; Sun, 20 Aug 2023 23:57:39 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C522C86B86
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bba74ddf1bso40684651fa.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568656; x=1693173456;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5/2qLcxdaZZBT23/7spikIKZHN+33hTQ+qMGtOJMapw=;
 b=HON6b0pSnCbYFSUl2Xeb3SlGrcK7Tc1ewPbGO9Kxun2zlGlzufK+taPoHxHLBIebX3
 JcYCAyBmoSpI9R9LPp2Z36rq2IWopDP4loVuYvW1bGAvwAzYNXaY9C8gDslbdFeHfOnI
 /zSR+Pm+bubqiG9X9sDNFvRC9fC5GPQ2SEW5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568656; x=1693173456;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/2qLcxdaZZBT23/7spikIKZHN+33hTQ+qMGtOJMapw=;
 b=AbxPfbAfDIQZlRGmkxz0Ow3mIiRcYx4hzL3aturNK+X5oIr6RGeZLHK6hI+U5GAj1d
 aA5hOlaNwk6ptx36M2sGaUQnhRb0astDB+fVMQwWmgsfzWp7YJEj24E3Q0BAJZda12yq
 uFy1+w4rXM78FYSbUIA7lwKd2c2AVEPxXX5NQYM9DiSt/ZZlUjuzid5B+pBOMjb69uzx
 5w9NoZg7uEmnaDTcSEFWaB6Wagz0D1bDN4LKmdOZKL9oFncPQazkswpnKyAVLIjqC7zz
 xW8gtRIw9+mVNageXCk2ikzss1v32ZOfkuHa0Htq417AckbwGkVdte27r8xwMZw7GVHy
 VutA==
X-Gm-Message-State: AOJu0Yw0xpguGBl7WsgOo7KX9TPprDprHOeDUhsX8oPWeLWqcMBB1ZRz
 rnzk3JHlP85hr4Db0z78zGt5IYIV4s9nsalxc9VKzw==
X-Google-Smtp-Source: AGHT+IEEqJscvOSRaDArlqsl2AKH2rqLLDAGEWFrQmTyZOyd/qKMBUMB6MKkFNwvYMzsKUj/PaA33kpMD3cnEV2SYxU=
X-Received: by 2002:ac2:4e07:0:b0:4f8:7568:e948 with SMTP id
 e7-20020ac24e07000000b004f87568e948mr4259388lfr.51.1692568655782; Sun, 20 Aug
 2023 14:57:35 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0rEZ-Z=xq6iuFaPxQX1V7yDW8WdKA8JVtqvndBsLAATQ@mail.gmail.com>
References: <CAPnjgZ0rEZ-Z=xq6iuFaPxQX1V7yDW8WdKA8JVtqvndBsLAATQ@mail.gmail.com>
 <20230813033209.486168-1-marek.vasut+renesas@mailbox.org>
 <20230813033209.486168-2-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:34 -0700
X-Google-Sender-Auth: SplwsDvJ1oE6H8v4UrSSykHHBNQ
Message-ID: <CAPnjgZ34teo+XsAwmL6oEF_27PKhm9YBGb9dg3XKZ-U=fUA2Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: sandbox64: Enable PINCTRL_SINGLE driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 21:32, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> PINCTRL single driver. This fixes ut_dm_dm_test_pinctrl_single test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
