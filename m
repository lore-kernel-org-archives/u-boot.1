Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C344C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 21:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E2D8784C;
	Sat,  2 Dec 2023 22:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kln8ExyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D352877FE; Sat,  2 Dec 2023 22:16:35 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D745877FE
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 22:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so471037966b.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701551792; x=1702156592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qxmIes+S9sQem2wxP5dhup3M57eMnihl3HRgKKeLVyY=;
 b=Kln8ExyMA9xlWYXDvKEUzRFYWYHBuHzHHToA1KY3EHRqShHph7g2rEEg4YN7LtQclz
 3aXVP1/hY7RLlIuAl5clH2s7jx8RD1j9sb6UFz3EykE6W0zWernBwg6fxqUw3TICqkJ3
 mYQjFM7g0A+VpsmOjP65T6fsLKH6kwq9ums8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701551792; x=1702156592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qxmIes+S9sQem2wxP5dhup3M57eMnihl3HRgKKeLVyY=;
 b=TwzBy1NFe6yqawCs3flbW2slsyX4MyKwcYw/urBbCPJAMM6gSABKi4dzUUnyUvslEG
 eUUA7eKtyVImaVEOSaGMp71SDRtD9pmG+wqstt35oTYSqwesgZOS5eAfB8RnpaF212EN
 BDHLD54FPxxS/MrKRWyf0XMCCgEOX6wCDOQyuFsaFsu9ZePHNV2qZx7k0LNH/En9VE/8
 93AH0+eAhSWo0NiKZMFOAaltkWrcVMSXrirBNLxu5SGTVqAG6oHY6REVdr2NfHI902jQ
 lCP0lcFIsCPsWRkZKuQdcNvBoGX15iiQiZIWO4H3LoIdfVITvNf66P0/EcJT9sxBMweG
 OYDw==
X-Gm-Message-State: AOJu0Ywi5Uw+82JJYPXHBcpYkmn9lVPaoSanG5+Hw6qqw0ZkJpzJgY2Z
 Jb3UVhTf4ty/6PshyarS5wuk5+wyYHOkNotjG++nzg==
X-Google-Smtp-Source: AGHT+IFtxWMVExh56z9IACCRCgV0kZo7iccSR49JhXaAQm6+W1KLwQXNmzbFJHzkNWtCHGmyHJUk7uiDbBdVf4xcmII=
X-Received: by 2002:a17:906:bcdc:b0:a17:781f:20bb with SMTP id
 lw28-20020a170906bcdc00b00a17781f20bbmr2122632ejb.1.1701551792397; Sat, 02
 Dec 2023 13:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-17-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-17-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 14:16:19 -0700
Message-ID: <CAPnjgZ3F7QNJPr=+atQf4afvgRp6TO_t=s9ww5ZQ06QxPrj1qw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] bloblist: Align bloblist used_size and
 total_size to spec
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Align used_size and total_size of the bloblist header to the definition
> of the FW Handoff spec v0.9.
> Update the related bloblist APIs and UT testcases.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>
>  common/bloblist.c  | 86 +++++++++++++++++++++++++++-------------------
>  include/bloblist.h | 26 ++++++++------
>  test/bloblist.c    | 35 ++++++++++---------
>  3 files changed, 84 insertions(+), 63 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
