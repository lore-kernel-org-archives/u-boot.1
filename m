Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B83C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCDE8772A;
	Sat,  2 Dec 2023 19:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KsG3a2bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C64877A2; Sat,  2 Dec 2023 19:31:55 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D56E876FF
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a196f84d217so290845666b.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541908; x=1702146708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XrpBjs5HjbI5GAjlvgCVR0iR3M7oumPbLLddHNuXELA=;
 b=KsG3a2bYLzjW7u2JWNj6ArpaRS5eg2B9IvYuMEfgLpacjTEA2mKlf8czyUSp6vVP/u
 zNlMnrrGeTv4Q+ASAa98wC3F/PBK8hUsjM7cdHhWkEegj0h4e82DsJSYXpgH7CdAhmc0
 1S+YUHOIbYvXo0bC4sMdXOfYLnwrg961Wwz40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541908; x=1702146708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrpBjs5HjbI5GAjlvgCVR0iR3M7oumPbLLddHNuXELA=;
 b=E8AWJGuYd86D7VaIMMYcICIrU7xUyPpAO3qTySLf/9cRVBtxLZcxTXe9V8008aKfCU
 Sr5nOs6SrRC45LmwePIB9YcbuXCdoCAWnX4WQCkwM8nt6r5l66aXriFwn8nuWY8qAnGv
 Ljr9MgNtN2bU5eKg81bynDc9hPsj9LYoDLmBravi5KObYpTkC3aHG02j2v/By80STYIk
 DYYLp7EIjlATdun7XOeyEwVPmd+iDO9frEy6Yv0l54FcPcht9Y736/7FCwDKcVBHTquM
 vV3SYMZaGK649HnK3nxOW3oAOnFHTjOxuwt1WFA49bYufu/HkPkE4Pabirzyy2puow3I
 jVMg==
X-Gm-Message-State: AOJu0Yyw/eyyyvM3vKWiMzSv6IA7XhcopitEGovKtBKsRIldBnWW2GjW
 4p9Hd9SxC8+dbw7ebkA53fnDFpk5+yk4moyKf8dsbeTBfnIUTfTp0E4S4A==
X-Google-Smtp-Source: AGHT+IGbaiXa7+mmFWL9wj5fT7MpgT8L++i3KlQsw0co5RGTq45fYPgSqfaA8xM+hDlEfqQuya9JpBBWCU4r15mysJ8=
X-Received: by 2002:a17:906:1ba1:b0:a1a:57e2:2cac with SMTP id
 r1-20020a1709061ba100b00a1a57e22cacmr742594ejg.144.1701541908410; Sat, 02 Dec
 2023 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-10-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-10-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:32 -0700
Message-ID: <CAPnjgZ2SsfntYp7RrecjoSRJMCYnYT3fJZKzkOX76BkLL32s6Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] bloblist: Checksum the entire bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
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
> Spec v0.9 specifies that the entire bloblist area is checksummed,
> including unused portions. Update the code to follow this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c |  9 +--------
>  test/bloblist.c   | 10 ++++++++--
>  2 files changed, 9 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
