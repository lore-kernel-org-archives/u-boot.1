Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D60C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DEA88779B;
	Sat,  2 Dec 2023 19:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fGSCxdWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB95A86E82; Sat,  2 Dec 2023 19:31:50 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F57F87554
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54c967010b2so695487a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541908; x=1702146708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MEUrdSP1OICUcxxphrmSJJRppNWXEqI4xr62SYD7ySE=;
 b=fGSCxdWuAQDUEuAOFLtixNXdGrbEK+ybOep7Ad6zVlUGxvJCw+H2pxY9mPe8+KBRRq
 Tlr69aPzBeEyE9kD1mmXBZP1ZzTgJWBh1g/VNxRdp0Snfn5QCFmDBzjdQ0oFyX0h3kqM
 WI4Ty5UMGDvY5z3ICJpbYD6vof1qfABnfty88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541908; x=1702146708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEUrdSP1OICUcxxphrmSJJRppNWXEqI4xr62SYD7ySE=;
 b=rJZaoJWaS9/H6w4AExi4efNx1HBz8q1QHdN0Px3c94ERmta13aTnAZWmiTIoUedga+
 nR530j0Du28kHckxhde5XZm2t+FUIfubrRBu94fh1hbqAkAin9huldbCZABrVx704cN0
 fie6P/UXmQicMES4zGNb8tyAgqcQkDON9TlXJ5CU1IXnQbudPK4wvkD9clMj1Y2UW7pN
 6C/DLlCPAUzDuC+1g1h4Oib5ivd3zINZ/xkJLptvgGQ/eqT+QKBt7uedyPXzhoJITwMh
 sa3xtuBvlIN9AU2lW+twle9hRaQcYDJ6DnHtquxBtUjkOkz/VXiGsq9CksAZyiKw/5CI
 FuBQ==
X-Gm-Message-State: AOJu0YxezNh9dV3Xss3Wn9iz1M52smoCTUjLyAheJPiPIRkMDvxv9OGk
 s1leN1AuOPGynmDVKX/YitPLYbQOG+AXcxZy+OauRg==
X-Google-Smtp-Source: AGHT+IEx+n4q/oQPVjeTCK3hzdeAD9Kb1gSnl9ia3KpE86f/IkQVirVuiGWaL065bDCcZJVSeOjgNd7XpiHsvA3oaYc=
X-Received: by 2002:a17:906:19ca:b0:9fa:d1df:c2c4 with SMTP id
 h10-20020a17090619ca00b009fad1dfc2c4mr3424598ejd.36.1701541908411; Sat, 02
 Dec 2023 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-11-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-11-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:33 -0700
Message-ID: <CAPnjgZ1XrD71N-fPxB9uetT5ociUdKzt5Ht9Ltp-_dvbL36Jyw@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] bloblist: Handle alignment with a void entry
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Rather than setting the alignment using the header size, add an entirely
> new entry to cover the gap left by the alignment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I am not comfortable with this approach as it makes it more
complicated to reused unused areas, but it is what we have ended up
with.
