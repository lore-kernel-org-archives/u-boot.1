Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CCEC10DC3
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3D6877A5;
	Sat,  2 Dec 2023 19:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gjB6eNwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBEB877E0; Sat,  2 Dec 2023 19:33:44 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476B387554
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d747dbf81eso4541137b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542021; x=1702146821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S61PzsZ99DaMJ2Mq9DPtaPm8M6vriCl4LYZhBvi2noU=;
 b=gjB6eNwjURK6j2gkuclYy2TP7wN9o+NVw0NqSQ1Gh1KcIDqCXiP0KeMIREZaafVvUv
 8ZsBusOIyTN6/zdJjCXIURVUsMQyC4vPtCj7ICrJhid9ekQo711K0G08JEa5KEPJ5fj0
 nXl62GvgItgP4dY9sj84JOCNlWaZfwZoR3vQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542021; x=1702146821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S61PzsZ99DaMJ2Mq9DPtaPm8M6vriCl4LYZhBvi2noU=;
 b=iX+14cGHirmqFWvI1igL/rFFIxbLzqc1gPkBkLl7SXWDCpvbQS3QF0Nsh2RuNsy//a
 p9oT9tKtFwui4Dhg1fgReB0RDO6YGdb0p4MzU+iBMsZSE/fuEj4XU/ltgTAICsjKTdrx
 nmWDKzE1umNlNWa+UDfI3gbsqpzZyBYwP/wkwQ71uOeV9oV0jmbJYsEEnp263X1dpeUK
 oTPbbmTxAdeO/y19eygkhu+aVItVMHnB4wU/m8/7Dgv/3Fd5c2LOF+4ssugqe21ddDzR
 fX0eNGbvH/IgBYbV+W+pDRMY6OqQzRgl3V7PcPAhya/dl0MK+uP89IIeJvIb8ap9FqyD
 0rmA==
X-Gm-Message-State: AOJu0YzSGUuaLmkK2XRuuXIxSJZAxMnjoSen6nUdsLNll8ueySQdg3V4
 Q50t9qlaIonKGIxzr/XEaNDR7InCtlMCpHH8Yq24Hw==
X-Google-Smtp-Source: AGHT+IGHyJ67Z7DZE/qUAVSs13rrBglzMTwRWExpMH7+XhMMk5Fj4S6C+2mZbVAlqjCym/xMOu/5MGtlwfIw220h5yU=
X-Received: by 2002:a05:690c:996:b0:5d7:8af2:6f77 with SMTP id
 ce22-20020a05690c099600b005d78af26f77mr558346ywb.24.1701542020823; Sat, 02
 Dec 2023 10:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-3-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:17 -0700
Message-ID: <CAPnjgZ3_LJRBhTQHEuu_Ow+6GB4r8ZtdgEBtxxHtYG1m8LmJBg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] bloblist: Adjust API to align in powers of 2
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
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
> The updated bloblist structure stores the alignment as a power-of-two
> value in its structures. Adjust the API to use this, to avoid needing to
> calling ilog2().
>
> Drop a stale comment while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist alignment to align to FW handoff spec v0.9.
>
>  arch/x86/lib/tables.c |  3 ++-
>  common/bloblist.c     | 24 +++++++++++-------------
>  include/bloblist.h    | 12 +++++++-----
>  test/bloblist.c       |  4 ++--
>  4 files changed, 22 insertions(+), 21 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
