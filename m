Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BA8E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09D4874E6;
	Mon,  2 Oct 2023 03:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lRd8/EYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8019C874B7; Mon,  2 Oct 2023 03:23:00 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CA4874A9
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d20548adso14458997f8f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209767; x=1696814567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qb2fkaFfAA9gH5jfMdFq7m+J1+A0X3HLBoP9ZlQfpdQ=;
 b=lRd8/EYlf0KTyEnbvV9/TCEZ2L0YewAgd4BzjUxX72Uywv3FNRHN8of55KPl92/K5+
 DeA6odBZnmyGPE1Zz74xPKBNvsbgrK4T8T+AUmEXFqASpNK8iTegrWvj4jL7WeNB97ca
 hAvh3w3eED2+2ukq/q0cn57Kew3FQApvc+sNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209767; x=1696814567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qb2fkaFfAA9gH5jfMdFq7m+J1+A0X3HLBoP9ZlQfpdQ=;
 b=wwdShO/BFr0kZ73iPFTXVK4KRNnMstGtSLWfBb6iFiRPRX5+poYkjH9WnyOY8UdhUA
 vus6KAQc6CQ8inpPHqcN1npaZvZOKVdV8Bk0nE8IuiSkfEeIg2bpBjECGOJJcqVWA4Xx
 VqA1hSKst65DedVSt+olKk2kTHc/DK4WypWE4mVVR/YoR5PBtsMRLJWbSjap5qParbYz
 1maE+xZh7b0d3w1kq9iBa3sK3jE69LjdDtRuRoES68z6zJwMSLH7aw9652PlfxzDGWmk
 73vbFuIwWQilapm7BVo4Wpm+qtci36KtLd6Y5h4bmkCiYC40BAJz2DD5ybgI52lV1+RS
 168Q==
X-Gm-Message-State: AOJu0YxknaZHv28icSGRo0uBQj7ml9cSU88YdvKJWrtKv5ptT57aTzzB
 fKARTEbzUjQJQ6UHeDqkOyPL/l81fNT/xCQBpntLBzC+gwsJKqhOqc4=
X-Google-Smtp-Source: AGHT+IEcAZ+gPgYTjD5/S+sUgsJIsmQY6DM7JQ2WLRC3CNBCp2DJ/HIWlDE+L4dk3ocSCdM/3yKt5U7oahHN4eviCW8=
X-Received: by 2002:a5d:4049:0:b0:319:7787:54a9 with SMTP id
 w9-20020a5d4049000000b00319778754a9mr9337467wrp.24.1696209766639; Sun, 01 Oct
 2023 18:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-13-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-13-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:04 -0600
Message-ID: <CAPnjgZ3Fd5HOXCaAE6CYnWJfc0mbbAAk9kxyMcioXTg3pavKFw@mail.gmail.com>
Subject: Re: [PATCH 12/15] cmd: blk_common: Stop using hard-coded block size
 for Sandbox operations
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 04:09, Bin Meng <bmeng@tinylab.org> wrote:
>
> commit 3d2fc7971454 ("cmd: blk: Allow generic read/write operations to work in sandbox")
> used the hard-coded block size (512) for accessing the sandbox host
> device. Now that we have added support for non-512 block size for both
> Sandbox host device and blkmap driver, let's stop using the hard-coded
> block size.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/blk_common.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
