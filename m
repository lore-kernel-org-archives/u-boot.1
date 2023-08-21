Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53754EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D11C871ED;
	Mon, 21 Aug 2023 21:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bCEhp/hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6D2871E8; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AED871C4
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d650a22abd7so3865318276.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DUhATtX6fHYk8encCFexcIKwHerIuhM5nQ0BLgnNwow=;
 b=bCEhp/hbJsY+9h3/BIextNjImzjBvUy7u5oc7MniBZCO5lbcgD1x65ytact6PWkrrQ
 DIeaHa/tXM9g4NLbWyY7ioZZJGilQLEIs+3m94z6QrP/pJUYHqAQ6+PztbzWG9YDaIPq
 S9PqrfKH8khtkFwzkVMhkNdFOvZr8NH+1uQLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DUhATtX6fHYk8encCFexcIKwHerIuhM5nQ0BLgnNwow=;
 b=XXZljxs9VASSSPUERG41W56Ikud7qwWtVJwJKAFACvI67uFqq7lUaSamSiRFm0EkBI
 aNDxftB9pzkp2wtzseLcH1qfMj1bsloyDxcf0qi16HznBuJMNZlK0g3VvglJLqMwbIAG
 FxxibgM3isT9osQXy4381UO3dqdta2lR5yo5wuPxkgKmN+XYXMJceppJnjvkMscpgwaq
 LijqBpYGscfUbF9JyUGS0ukDlhTcVkCwb/KiRRGhqVTBY7tPfozh4LdYa/G+DAkVGBMX
 3htLwHmhwP7Lq6A3qlnblWKWmmG4fpniQJ1C9rZmyIMDWUfiy2Y3WfxjA+saPKlswZ1N
 JLFg==
X-Gm-Message-State: AOJu0YxJuXbOOVqIkLrIEym54THo0BMHBnvYi2aMgFRuloNvNB0yeNsn
 s9tohaGytOV+DRli/O1AfOb3HcKthJbw4fB2GK7zkUgchRA6LskZuoc=
X-Google-Smtp-Source: AGHT+IElj+uFXu+WgOnlj4oCsS48lKoYyo3yhONc9rH/9NEhjitoHlHUYz8XzsirHLdw1XHcbA6rdzubM8N18apKlvY=
X-Received: by 2002:a05:6902:50d:b0:d62:be1e:1622 with SMTP id
 x13-20020a056902050d00b00d62be1e1622mr8145282ybs.38.1692645213130; Mon, 21
 Aug 2023 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-3-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-3-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:47 -0600
Message-ID: <CAPnjgZ2u9B78we3ta4YPSEsofO4GydG9HQRs-wTxFRXp0fRFOg@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] video: test: Support checking copy frame buffer
 contents
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com, 
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> The video tests have a helper function to generate a pseudo-digest of
> frame buffer contents, but it only does so for the main one. There is
> another check that the copy frame buffer is the same as that. But
> neither is enough to test if only the modified regions are copied to the
> copy frame buffer, since we will want the two to be different in very
> specific ways.
>
> Add a boolean argument to the existing helper function to indicate which
> frame buffer we want to inspect, and update the existing callers.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Add patch "video: test: Support checking copy frame buffer contents"
>
>  test/dm/video.c | 76 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
