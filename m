Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C12EDEBE8
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D2B83F61;
	Tue,  3 Mar 2026 19:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QB3txSih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74F883F80; Tue,  3 Mar 2026 19:52:14 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A03683F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-660a293515fso2247154a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563932; cv=none;
 d=google.com; s=arc-20240605;
 b=Z+5QtAdRF2z38ydy13O7FWQ+/i8s+xe37eZnEm+p6uBWNR+4qVCB3RbkBW4C9PXbad
 fetE4ksQ7gxQibVskX3JguhRwxMc9+w+BKvXmJiF/28+5rx4AXdLYiFNhJJE3Ag6xNqd
 cpZpWfYigPCt6ChTZkjeLOfFBCbrFcetwWaKptrtNQJuG/unnt2eQGTOWFe6xdfqrSy6
 t1uP4WQzhku9jYymBvJSRTtTQ/NNFjaNIKPA/OvZZJDWtsrIxHc/nt/1gB6JbQJ59L9Z
 66xGBSPL+XlJ/2WsULPv2ussJq+c02Dl/mYbaDpI7mv0QF8a0xhqC2Pd0ixNHahV3vV3
 KKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CBfM36QXg/+u8qcpFY2p0+slBw/LhZrfNtN9QQlcnik=;
 fh=A7WOA1UP+TJLUk9JDjRBZEhJ9uGubqfA2YKwyYovrTw=;
 b=dfYUwzjhWKhGh3yVVaF6ii5Zr/Zkkbhso/OD6EEqBYwiMgp/3gpsg5Bz8nnqjJMxT+
 DUMJrC1eR6WWy9bUQxAqQIrRJb2NdoYONe0KdAi5rPlLEbW7+cQuKCuTqgs3m+tdSNnr
 GiL2ohpc5LvpXITakjusiy6SRLXUfZD0+GULJypt683ulvhZsfvadix8mStHcL0XUBgy
 NXvMfYnW536JRUmr2/TspV7ZAKm8kmOaY19BrPmd9G8bs7ErIlbG80mfFJ8Pmg8FBQpt
 89OwCElM7wjOZP8K7rxXqenFJKTm0BNSMcV+C/GnRfRAvz4fTWAiSM+mq+OY07Dmh0f5
 v3Zw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772563932; x=1773168732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CBfM36QXg/+u8qcpFY2p0+slBw/LhZrfNtN9QQlcnik=;
 b=QB3txSihfjEdM1MFec07r9ffvInl49Moo4kFCm2gb0yU+BrAuGteVnC7LFWJzFU7n1
 wlEsFykrP63P3VGyS5eGyxsqBmsC718OQDlS0OL/iXUSgZGqcQiVeL4zeb6y2cCpPLIJ
 ZQhsm0R7hnYZU8ajKe94Y/f2Mee0XoJqbV/XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563932; x=1773168732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBfM36QXg/+u8qcpFY2p0+slBw/LhZrfNtN9QQlcnik=;
 b=puetgDwk6eHgWBfIDaQpIKmG4j6VEJXKWK7fPfhlasFLT9IYzwtOGsxccuEin6EiSj
 ntqfUWOpQmXBkENkiBqLFGwIBpohJT8b4tyU0dV+3k5rDh3fT5LUm65Tnr0GfFjRBuUU
 V5JZrh4xEvQSl7kahmY/OzHClGbSWpcrP9wtdX3XOUCWV4a+qBZa+N+xDlon9GXDC5eQ
 1tiYr13EG/BWDm1fUawP7DLsPfIQNLzKLkuBzu3QUW+IrWekkyGr+kvS67v5nD/MBr4i
 HT2FO0DLzNBJeRFs4YfnqfFbu1WM/lQCmq1S+5+0C1g7ydixV1pmhtYlZlAc/WSorOeh
 fLUQ==
X-Gm-Message-State: AOJu0Yx13h19A8OnxA2VL0rmKZHKWKGSq0fxJQkhkzv1zDeiBsbtNAEk
 Lq1cTLhIn9sJTkMXURODe8QmfVkcX2jB7LMqu6KRwiccXxXfWcLnrV/FpSFFjK8RNIUy8Ppgj1G
 ee8GjCdNGaxG19YzZDu1OCnsPL5+1lPwKwNweelc8
X-Gm-Gg: ATEYQzyZu+laVVz6Qlppi1GJGvykr4MNWtmCbQ4fd1e23MFmn4z2ChuZOY2Y1ID3ixW
 jSae9GUAX0RQVxR3ygWDGQD8W9WtP+ddmKKk/MM7iAD3nO6yCG726nicuspwHqARx5Vn9/QfLTF
 wU1DmCs2yeixIvfmkVlJXo6aVAW49DWp8YSITvYD6QyH7DAqHEZ+lnPbo0P3D1Uf0sYTJbkTvUJ
 Gd66sexVFXsG35T2+EJHzbw/cYEk73WQNRnwYYeNmI5T4ugaoInVHSCiLWd9Yr4flQ3c8jGAFTE
 w9EkHQ==
X-Received: by 2002:a05:6402:51c8:b0:65a:2ec5:99c0 with SMTP id
 4fb4d7f45d1cf-65fdd4cc8b2mr10663251a12.3.1772563932004; Tue, 03 Mar 2026
 10:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20260226234802.345968-1-sjg@chromium.org>
 <fabec198-7034-4fdc-bc02-5658477c7591@cherry.de>
In-Reply-To: <fabec198-7034-4fdc-bc02-5658477c7591@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Mar 2026 11:51:58 -0700
X-Gm-Features: AaiRm52-mSMB7BVm2CkCfcsdlNmwFW1uEalLG76Utzb_Hm-iLPI-pwHndnbs-F0
Message-ID: <CAFLszTj8sTdjtnoSAAMUumzWn57eq==t0wE0+V4UPRtRJfstgw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] binman: test: Organise test files into
 subdirectories
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Moteen Shah <m-shah@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
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

Hi Quentin,

On Tue, 3 Mar 2026 at 09:15, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> Thanks for doing that :)
>
> As a general remark, I would suggest to remove the dependency from this
> series on
> https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/.
>
> That is:
>
> - remove patch 1 and 2 from the linked series,
> - squash changes made in this series to tests added in the linked series
> (patch 4),
> - maybe something else I missed,
>
> If the series cannot be applied independently even with this done, I
> would suggest to invert the dependencies such that this is the base.
>
> I'm assuming this series here doesn't need too many eyes, but the
> imx8/cst changes should be thoroughly checked and there's no need to
> postpone merging this series here I believe, especially since we're
> about to have tests for UEFI capsule and may receive other tests in the
> future.

Thanks very much taking such a good look through. For imx8/cst it
should be OK as the code doesn't change, it just adds tests.

Regards,
Simon
