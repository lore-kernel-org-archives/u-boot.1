Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3667AE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6FB89740;
	Mon,  9 Dec 2024 14:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VafQ2FTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1EE8974B; Mon,  9 Dec 2024 14:29:42 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC7B89751
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2161eb94cceso16970535ad.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733750978; x=1734355778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GiLkCwbJ+EqQEae5GKTpDv+zsSfDNXtU2audTGm38iw=;
 b=VafQ2FTq/joQInu1EOqxWRS9HUopbXT3njVGZFLAfT+BoUXNi2SVYasl91OfbgWDl+
 VpgZw/r9P/3miwDUFeiD58QX+W682i9lbCLlTHzAhtDw1OxwDQP0BicBNWkmnc+qDRx9
 nc0xXeGEW0nA0HgDbeULKDNINsjCgzpKfjNbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750978; x=1734355778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GiLkCwbJ+EqQEae5GKTpDv+zsSfDNXtU2audTGm38iw=;
 b=pjnrtMd6L18/IvdB7gY9JiXK3V+U1HDLq8GNGMCJPcXzt2PqYWfWFLj3Vz9j8WgLai
 8rF3+d9m1119nFoVWAvJUzfSmyu01SxX/F+yq8m5eQvCRrljHyUiCqgec6g26fbw9DVy
 niom0O+NKau0608oIWB/J/VJWp8IWBxWfkaQ6CjjVmb6GU/3BKczhtOw/4+ZvtD3Scrv
 Tsu/wS7Zi38QERiZlrWL4U9+ObPGXQqsB0J8BSR502oPGLCLxKCHPz2N5qjFSKSSD0ro
 DpR0ACtNwQTR4UPqTcwTqPdv5Ux5A9hn4ebqO3d5RNtBJcONcUA3mlHwT2ClVucHjQdC
 K6KA==
X-Gm-Message-State: AOJu0YyXcAWn9uBSRbD8OB8Lr6awnZ+jzQx0rXr+Pq7HSxGJ40coPKky
 hENysFF+zW3jjhBEgneI6W0vYRSJmAPLsgaxqbmMWBAVGTcQenaJhnQ9xinDtYh+397cJzM8lZC
 PGtJPxJF0CWtxQNyNtc6Zd7Sqpkb8WD88pMzP80kPw/Ck3io=
X-Gm-Gg: ASbGncuAkhSQltRwOvCKWDKckzG0WAgM/qpQ/72vaXmmmB3ENSv7NLAa7YmOwir3RZd
 Q3ZgOMx6K2EfQ6cpmfQ7GS7LAzSV3Ibtg
X-Google-Smtp-Source: AGHT+IF/wNB+iQq0wBusozHbx/SL7XszeFiw1qUeiS2xkvWW5iU4WULNFk/EKBcLd+gvgscSeQHv88qybx0pOn6k3gk=
X-Received: by 2002:a17:902:d4ca:b0:212:1ebf:9a03 with SMTP id
 d9443c01a7336-21614d2dfc0mr191602375ad.2.1733750978313; Mon, 09 Dec 2024
 05:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-3-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:29:17 -0700
Message-ID: <CAFLszTjTkTkPamxR=NDaS29N5KCCKDgABzyowoeFRuUZ_U1wsQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] docker: Use ${TCVER} more widely
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> Remove the rest of the places where we hard-code the version of the
> toolchain we're using.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/docker/Dockerfile | 52 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
