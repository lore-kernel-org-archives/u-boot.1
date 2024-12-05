Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ABDE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538D38952D;
	Thu,  5 Dec 2024 18:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eaqia8Gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175D489527; Thu,  5 Dec 2024 18:57:28 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C471889507
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa503cced42so180510766b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421445; x=1734026245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbqnXbsBX1TfmpPChg97ArOK0XWwsXnpfyOivjLW/rk=;
 b=eaqia8GmtFtXrk1VavQFVFzvuZIcBFhfnSb/0GLzLaUSTm1ym8CE1ChFOd4v76xz0n
 kFNqOQTBigYAVH+QHo4sdG1oqrC2oe+fUCFlCCvC2aoBFLYeFHBB2p39Np+iHsrmAWpH
 KtEszp48QhhnMG726J7NbKd74ARSIoD0lWEto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421445; x=1734026245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbqnXbsBX1TfmpPChg97ArOK0XWwsXnpfyOivjLW/rk=;
 b=Vtg382Ho7g3TAeAG1Sokp0SaeAegfBDL3w+Y3VSe1xBXekBWJX+ByDGaP5CqTZkTIe
 OClcoWr641V7d0MHc29kU180BtKY11+Py5cFiq66/5fpDxR+dW3XbaWZDWK+I19KDXbu
 ixuaWzxf68BqleAIPlJ9YIVr1rUx4K2eIoXTEZUMPrq4I74Spm5uoLw1HDgbMhr4UMLU
 4Pj6ADHQsAsx6hP0KjA1ddlKQeJVeBnB0nWnA3VWvGfaTG1OE5ZYioQ+QfzdA7brkrR0
 qmi9g96NyBBUj8b2WhitqxfWZB8WriM6XqNNiDRYxHJJh35VzntahcDnVjkfC8QxIsD9
 eWCQ==
X-Gm-Message-State: AOJu0Yx6Sn5myMnrrBkdTlY/qeX31NpMJ0962uscoYOykNp5BhdbaBPC
 e+LRf6fUsYvl6c7mBD75AKTuyViAd+n04iIkvccP3JeAUe+PVQ1BF0hILdle2RK5PdMr5YsbhOu
 Wy2VcRS3VFAe6sz7DNiOWPmqVEGmutd6k37Cy
X-Gm-Gg: ASbGncsmMtgR8cECxcDVjN7KjKFUkRhqzztsSsX4Mp7mC1ut5ts4eN4KLUfEb1+f2oV
 5TIo6mHIEGuQjHIXo3L7ROS9CtzVleMl5
X-Google-Smtp-Source: AGHT+IE0lnRIRsNiAPJfgUARDTcOA0Nz/SmXxEzu9yI8Vm77KaiLig1islraeiiXShSivfvKD7ZhckwimPxJcjEg0fM=
X-Received: by 2002:a17:906:318b:b0:aa6:25c8:e74e with SMTP id
 a640c23a62f3a-aa625c8e79dmr201362366b.32.1733421445236; Thu, 05 Dec 2024
 09:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20241204223107.43349-1-olivier.lheureux@mind.be>
 <20241204223107.43349-2-olivier.lheureux@mind.be>
In-Reply-To: <20241204223107.43349-2-olivier.lheureux@mind.be>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:56:58 -0700
Message-ID: <CAFLszTjVrg0fC-6gHHywOM1bs2QA7wW1uWVSzJ+NXZi8YX2F0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: sandbox: Fix the "sb" command name
To: "Olivier L'Heureux" <olivier.lheureux@mind.be>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, 4 Dec 2024 at 15:31, Olivier L'Heureux <olivier.lheureux@mind.be> wrote:
>
> The command name was "sbi" instead of "sb" in "doc/usage/cmd/sb.rst",
> the file documenting the "sb" command. It is annoying, because the
> index in the left panel on the
> <https://docs.u-boot.org/en/latest/usage/cmd/sb.html> page shows no
> "sb" command, which makes difficult to navigate to the "sb"
> documentation.
>
> Fixed the command name: "sbi" -> "sb".
>
> Fixes: ec6d30649cd5 (doc: sandbox: Add docs for the sb command, 2024-10-28)
> Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
> ---
>  doc/usage/cmd/sb.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
