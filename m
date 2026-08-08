Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92165C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5666B6069B;
	Sat,  8 Aug 2026 17:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KF19SbcsmT7x; Sat,  8 Aug 2026 17:33:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4323A6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210400;
	bh=nwXt7f6WlTyjlrlGaWimLN5gqe8yqj7JZZpmECMm9Vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dySaB4QjWE8Lmsd5fvJKssN+0iOJj4FUHhKOGexNLvtMvdkbtobS00qsg/X9KBuva
	 ttSpNUJVbByFYDMU2mPrY/kCYeG659ww8/pKgonoBOMRqgXPvtdyDNh8i8aOWR2B04
	 nSntv6zYQAN27IXbqhG5OjI49iCQS0Gln4Y61dmBTONmcI1w1ZNDv+TlfwcYFAojPG
	 Jrcl20nBWduQ+iCa5SuqKGFMaWWURM6jCFUbdLRFvBC6jdBxy3aiVxC/CwIPACkX7y
	 da6Q5CKCDQGXb+n97dO7H44ImH9T44lq2xLBUZ7mBm0/kCJesWFLiNrmGjnNcYmz3Q
	 zCccklVWZdQKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4323A6065E;
	Sat,  8 Aug 2026 17:33:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7479282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A94D34007A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYZ8KLQAlQFx for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:33:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 99004400A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99004400A9
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99004400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:17 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso585429a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210396; cv=none;
 d=google.com; s=arc-20260327;
 b=bEmyem0G63Hm+rFOBOiBoklbJYjktjOL0YCHjRz937aunqw4lFrJzqotkjcWc+CgdK
 bJRl3w3miNQfZkSrDasHeP7N1Tn1qEwYDF2me3TTzcV2E9rI6nUFvwGmpAqW8EsrXCt8
 p64DOv1UjPVsAdTPBQ8vbNLirpNuV1OC+VRO0jbmgg53mBRlKLISZ3MMRrCj+u4/vRam
 xPgFIjBkjA2J5xAbFSvpy84Y10zk4rQtuhuf2X/Z/PGVuzvSpVzuzV5ceNKFuQ2EfqJn
 AoAoeR4r66B/REZ1Y0F048+jP0lLx1rfttNQEa/qiYOt+3z6qqAw5HLW1F6bK47ctAPp
 LcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nwXt7f6WlTyjlrlGaWimLN5gqe8yqj7JZZpmECMm9Vo=;
 fh=8ELUOjKyCW5zjNkDVsUi4ofPIdn1lZF/cGwENRhulfE=;
 b=ru1qqrS86r8XpzD572P7WKTFISkL6+WsvyvRuu7eUIWvdN9b+gUH073nTWuu6l2Y3r
 ts55ECyDxj09CU3kL0I+VMouK1+fNjgHPQ7yl3M29aT1SkMnbBqXT0/GuK9wyPL6D8rq
 vD+ZDmMWl3JoRkKDacKW8RsK5ENyerYncf0DXvjUwnV7pIqIEJKvZx2k79gpvnRME47h
 j/iJURkhAsVRouwLDkkFPOqTfzIro6nMy2N6IHkbMbsE2No3y7/gSGx1Yh/f/7M/LDIj
 4pLiePYXj6kx+YOiudscnrhBw0RBdhCOnab9UzYU2NlVvfI1ngKFWSq0PzJtsPW3+Md1
 ec8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210396; x=1786815196;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nwXt7f6WlTyjlrlGaWimLN5gqe8yqj7JZZpmECMm9Vo=;
 b=oTnuxZz3lx8eMZwHFq/YgbxvmyRWOXkr+hBDThhGemoUrUB1gb90PAoCsrUtce1A2g
 sbSFkIDYMSPDEPnVmbLWn3BYoY0q1RAm7nmmtLtwXpvVNn1UB4xp0pIkaVH+2l9CB/r0
 Ym0P2tfhY7liTH3aChAreGr0Hghc5gg+Sa/09QTq38EqGlj+RBPsdmRMJeKqOfF93WbC
 n1scSAH/cPpRra9FNL9QDbbdjw5kqO8AWfC50K9iKiYcTSvFlQX/QtlRoajcXsHUQhVe
 UxfF0sSB7dZzF/WNBfFqUEn3iBSjz3Qd7SOaBrFEz9gIdgKVYdK5J9v68ZvOfRkcVDCf
 s6yg==
X-Gm-Message-State: AOJu0YxyF4HpIxOqcl5XQDZTi5stUCfuWVZKskfQH8ApTYKqYTlcsX6Q
 jBil4Cn99LArXNJi5JWSXNd9RZzbEtqCehl+yWjw4uyziZkxs/wh0yAwbfmF1DzgjbzecxRd7pc
 jhv+3zSdJrKHZFkGQSUhtrRvGI/oH6rqRWKhe0gHa
X-Gm-Gg: AR+sD10vt7Z4DXz3vbBBrpZJvBxIgBuVaiQbbowWrQ7K9u1uIocXBC61LtnObTi/Fdt
 xLC9Q680mQMF3jGWFdDi8wOwE4mX/ZziL2z4k+7YphGH9cvSPDOkS6qTg4QIG5WFfwkJ2yud1/H
 IQHDT0fKMPZCb3q8QQBHIiyhIWz7RJUEKfANy8T/NjJ0oiIfjZYXfOr4nm8FEyvA09ZdvUY9Asr
 QBFIsv4Yuf6HPbP5islS1/X24JkPco8XnWCYcCOTo/p2OjvdfqQThY4XA6j5rpV9mlaIsCdbidT
 NhyqryvtlZ80/YLja6fXbPo+IG3esCc8v+bovTgH2XC8
X-Received: by 2002:a05:6402:11d0:b0:6a1:b515:c3c1 with SMTP id
 4fb4d7f45d1cf-6a1b515c6a2mr8171195a12.4.1786210395576; Sat, 08 Aug 2026
 10:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:33:01 -0600
X-Gm-Features: AUfX_my0ThUeqTL_WaR32dVdUNeLc7fCXnqztdxU1DqrZFTUeARXQCZnmYYfACE
Message-ID: <CAFLszTgS-5RydbUwGKm=S4NWKJF+WcmzH6wkN_wFPe7b0OOk3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] board_f: Add verbose DRAM layout print option
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210396; x=1786815196;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nwXt7f6WlTyjlrlGaWimLN5gqe8yqj7JZZpmECMm9Vo=;
 b=PXuoezl5Y60k5O4xQOjA6amWMjXD280nBcSPKDRBoCehC7IVCn1hcQqwzh/DNWYLAW
 UtjQWAJpULyGuR9Pzji+gBm8gPc+4p7uw0xMY1pXppIxHtANWI9YWle8PlfpET/53z/k
 oW/PqQibbnvc11q7UnEWWSBaKuWcTZTOrfQAY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PXuoezl5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-02T21:33:37, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> board_f: Add verbose DRAM layout print option
>
> Make verbose DRAM layout print on boot configurable via newly introduced
> CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE Kconfig option. This reuses existing
> DRAM layout debug print, but with additional rework to place the output
> at the end of DRAM size listing, print both bank start and end addresses,
> and skip empty banks. In case DEBUG is defined, the DRAM layout print is
> triggered unconditionally.
>
> The original debug print looked as follows, which puts the layout print
> between DRAM: size announcement (1) and duplicate DRAM: size print (2),
> does not skip empty banks (3), and does not print DRAM bank end (4).
>
> "
> Model: Renesas Ironhide board based on r8a78000
> DRAM:  <----------------------------------------------------------- (1)
> RAM Configuration:
> Bank #0: 1080000000 2 GiB
> Bank #1: 1200000000 4 GiB <---------------------------------------- (4)
> ...
> Bank #8: 40000000 2 GiB
> Bank #9: 0 0 Bytes <----------------------------------------------- (3)
> ...
> Bank #15: 0 0 Bytes
>
> DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (2)
> Core:  68 devices, 26 uclasses, devicetree: separate
> "
>
> The new debug print and optionally verbose print looks as follows, the
> duplicate DRAM: prefix is removed (1), the layout is printed after the
> DRAM size print (3), the DRAM end address is printed (3) and there are
> no more empty banks printed (4):
>
> "
> Model: Renesas Ironhide board based on r8a78000
> DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (1)
> RAM Configuration: <----------------------------------------------- (2)
> Bank #0: 0x1080000000 - 0x10ffffffff, 2 GiB <---------------------- (4)
> Bank #1: 0x1200000000 - 0x12ffffffff, 4 GiB
> Bank #2: 0x1400000000 - 0x14ffffffff, 4 GiB
> Bank #3: 0x1600000000 - 0x16ffffffff, 4 GiB
> Bank #4: 0x1800000000 - 0x18ffffffff, 4 GiB
> Bank #5: 0x1a00000000 - 0x1affffffff, 4 GiB
> Bank #6: 0x1c00000000 - 0x1cffffffff, 4 GiB
> Bank #7: 0x1e00000000 - 0x1effffffff, 4 GiB
> Bank #8: 0x40000000 - 0xbfffffff, 2 GiB <-------------------------- (3)
> Core:  68 devices, 26 uclasses, devicetree: separate
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> common/Kconfig   |  6 ++++++
>  common/board_f.c | 33 ++++++++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
