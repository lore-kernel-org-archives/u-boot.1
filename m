Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96010C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0888778A;
	Sat,  2 Dec 2023 19:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZzmDytk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEB2876FF; Sat,  2 Dec 2023 19:31:55 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F3E87786
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a18b0f69b33so547388366b.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541908; x=1702146708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l2XjHVch5P0M3tOn3zwzTiJGV6MT/AIgjWebwBw+9K8=;
 b=ZzmDytk7o8FkKLKeWp7UazwERTAVxCvPmV4S5hoMlDYRMbuYRRwC6IZ+fvnVTPXXpu
 n4Mp3YYxFQcg4po7mtHphRS6RYrZzL/2XVqrRifpkiw8V8X7N8g5brIQdb03+hxcwUg0
 bzxJu+9sBIJobOpcQbMmUh2/35n1jXv1n3F40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541908; x=1702146708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2XjHVch5P0M3tOn3zwzTiJGV6MT/AIgjWebwBw+9K8=;
 b=bbPuDiPjBUod66AtpU5tn7+EIrQEqks70bFp5doEcMimZKipr1lBpBBcfUUSplu1/i
 2F5FtbdJy2nCTxVHet8pzoc8WN6CQ395Y35UkdB7bRPeM5k+JNflE8ap5FTt0fO7+JEZ
 /9Izw946ypeN4kvReRez1Z9tybBRpZ9e/gkg9qqJKDWviQgY9rTAVm45jL5J32wZmNzr
 wnO8sXPvUMeWu+6uMLNY5shMIiSFyBDiCPSVjfGbW8oskYu559vIsd1kjCKWj3c7cExo
 TIUjiCtukLMgmK7WJIo8YZAkCxKR7wlI4sxPOhKzXiMggeFHn4l6aRCLqIY4fpHgdGNJ
 uA8w==
X-Gm-Message-State: AOJu0YxwNNMR10KsRbvmEuxrjr4XNzWRlrhX4RrCI+6XSsnXdwv4A1Sp
 0vWdC5gaFtO2tJUyApItesxI5aOQDBqjim3wMeAjrQ==
X-Google-Smtp-Source: AGHT+IEX7YxrH2HIjji5gT0avSSdHQMCt91CNd6npFg3c3fZD3uZg4tLvctld337PhnELCn03oSTizIbFkpLmROoqrI=
X-Received: by 2002:a17:906:d92a:b0:a19:a409:37e4 with SMTP id
 rn10-20020a170906d92a00b00a19a40937e4mr3451304ejb.61.1701541908412; Sat, 02
 Dec 2023 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-7-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-7-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:29 -0700
Message-ID: <CAPnjgZ196_y4AtzGBuEj+5g+Dd0uqHsC=yeQJ-UtNtD3Jkk97g@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] bloblist: Drop the flags value
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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
> There is no flags value in spec v0.9 so drop it.
>
> For now it is still present in the header, with an underscore, so that
> tests continue to pass.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  |  5 ++---
>  include/bloblist.h |  6 ++----
>  test/bloblist.c    | 45 +++++++++++++++++++--------------------------
>  3 files changed, 23 insertions(+), 33 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
