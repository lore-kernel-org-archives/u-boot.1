Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E1EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238FB877D1;
	Sat,  2 Dec 2023 19:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tx00dXLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 046E8877E6; Sat,  2 Dec 2023 19:33:54 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2D6877D1
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso16578327b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542030; x=1702146830; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rEmLeAvCFV/CgTj/r08FDxIUaEuRipxdJIreUveUhAM=;
 b=Tx00dXLWFGZEtocRYfgARNzAa/rH+N6Frb1H0AcH8abA/4u+uiIutYK477rBCmmShB
 ldKW91hOZeioyAORVaCH2UpWLcceVaGIqkkAZMncbyrHxKU7C7Xm7Re8umpZABHZMSgA
 v0Rvtb5zU0b7tlhGxIXxIklp9XV5ELJzl9zyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542030; x=1702146830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEmLeAvCFV/CgTj/r08FDxIUaEuRipxdJIreUveUhAM=;
 b=VcFUA94hz1DGeMwAzBxdg2GzeXaymdbLI9UWTwHs/8nd1kgROhFFJ22WfXUjdgU+ty
 pGsxZONyaiYMGwSul4+kIXIfKQDY+p0NDGXa4w8JzdUBrgLPFGr+yB+WK9n0MlEDYBTi
 jdHbHwxt32L4FjKZzLr6VnR0Id3yYS8C6zYMaZ4pnvz7IMwEei+H4qcF68Tpf30DMf27
 Fi3NdKbJjKq7BAcCLCJSnyyvgcZwYYqBUoO3BASfmwHM6GM1R1sGu7MmewdlCdTJUiXg
 aea1Rm3iVxQIxXzdOKYsuyvd8rcdRQcYftk3gQpC6Sl8p55vPzT7/jgv4eeK+2y7uN9b
 YGKg==
X-Gm-Message-State: AOJu0Yyfvq3Ao0qB020y0JQwoVhYNI0i3UnzjYovQiSgx3d8Aw+9KMDJ
 Rl7A37GOiDjyz1/fddKnQpjgzC/bfzlOAamG+hWNuw==
X-Google-Smtp-Source: AGHT+IF08ZjNzKc4VNrNYiaKJv+6XN3LUvr3zGy73XekXiS3IzT/cbW8BCbANJkwsxjYt318Jtj8wqaU/jMUnd+zOZQ=
X-Received: by 2002:a05:690c:dd0:b0:5d7:1940:dd5f with SMTP id
 db16-20020a05690c0dd000b005d71940dd5fmr1133845ywb.53.1701542030526; Sat, 02
 Dec 2023 10:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:16 -0700
Message-ID: <CAPnjgZ0hLZyJqdu1OR43x8zi+_N+KJp8No=nG6A0rE8DN5eUTQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] bloblist: Update the tag numbering
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, 
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
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
> Align bloblist tags with the FW handoff spec v0.9.
> The most common ones are from 0.
> TF related ones are from 0x100.
> All non-standard ones from 0xfff000.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Align bloblist tags to FW handoff spec v0.9.
>
>  common/bloblist.c  | 16 +++++++++---
>  include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
>  test/bloblist.c    |  4 +--
>  3 files changed, 48 insertions(+), 37 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
