Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853B3C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241E7800C1;
	Tue,  4 Mar 2025 16:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lf5bodnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2ED1801CF; Tue,  4 Mar 2025 16:47:56 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06968004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abf3cf3d142so511908166b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741103274; x=1741708074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v6wgJ4GQApPFIFYUXmd2vlOm3UXe1cmM8yR2GpjHMiE=;
 b=lf5bodndPcOsYmpDQeu0MM4/juk+aMIjni7+NqOEZCwyL3lsVbC9LL/0ErBlahwjJQ
 8shvTs25zn7ZDh9azaCwj/9Vjg/nv6QGHQPIzE5bnj/wXO10q9GutJTlHmhfOGT9An0F
 2GRLEMdatF9SCjwP+jITUzKtTky7d0enPyY+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103274; x=1741708074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v6wgJ4GQApPFIFYUXmd2vlOm3UXe1cmM8yR2GpjHMiE=;
 b=MhRtO23WNe88Tl3LiX5AHl5CSScNlLRWN/yk6ZbaRS1CTFTwwKNDK8ndUx8/BVrr2E
 DRvi3e4yyMBqhhzisMAys+4dGb+RzRNfYcc46O9mVXpz+19q+Q4GWgtBJ2iIU4CaqGZG
 lo+weDTq7v10rwgTlaNKRimQWd0NSBmVGm6fbPc3zAtRg4E5dPI3MQ1YwotBX8BRMRuv
 0wzpvYl2+21nXnZdITQMW+0+FNoyLBrA+3yTl610fXVMJPdF+nVoj4ZPabnW3SegglGr
 PRtg2HFkiKTZuJFBjX0ZbiPxSr+m30JZ3t2BcedfClOgnrNwwiGfcF3UUSKqNSEBxfXi
 HzxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk//5wG5H78DjnaUoNqWcHF2fh/wqiqbXazEN4zb8zCILSBpVZ6rBWo436ic6yaS/0qp6z+E8=@lists.denx.de
X-Gm-Message-State: AOJu0YwSKwrCspEk4VAaT98mbHwOyePU0303ZHO6Imxx4VfgFIrKmIhb
 /uJI0vsmUmxs26FJ7psRITvna8tZLFw6oGaKGLbHV1Fp3GO3Rp40Fg2X7L9BJYURc4opCXlP8xb
 idyQnINB3REvuHUWq2NZ9tIk7+tze/ZWIov0F
X-Gm-Gg: ASbGncvezzovnLCU+/Euib6KdgTUbomP2FFk7qA1pBIixnwIkP7g8eC0pexNlZyhhoM
 YlEeSrgGuDr7qDHnRoFxgufc5A6a8ceNaSV5Id7tQ2lmXwqki44TmdLpCkv5+1G9Vgj0ssvIH0+
 aeuPsC8mz/urvV9cX7VZdziWiJtZ8=
X-Google-Smtp-Source: AGHT+IGnRtW5TC29UbAF+VZgRLOosFUrBLu2WJ0/Dt7VsQz01deTmN/e2w0daWewmEiPiZKtEZIs7jW0ioj+TyxyxgA=
X-Received: by 2002:a05:6402:35d3:b0:5dc:6e27:e6e8 with SMTP id
 4fb4d7f45d1cf-5e4d6b4ba23mr45356041a12.24.1741103274420; Tue, 04 Mar 2025
 07:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20250224120214.147646-1-clamor95@gmail.com>
 <20250224120214.147646-2-clamor95@gmail.com>
In-Reply-To: <20250224120214.147646-2-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:47:42 -0700
X-Gm-Features: AQ5f1JqEvuBrKYvawL4_r9ZjSp2Od31EwfzbQR9uzjhj7uVLEUzy8Z-WCtoADiE
Message-ID: <CAFLszTjSLr7R_0_MYmi0Nj-1iZ=R-LFoREYZBjtXmOi_+QZscw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] video: bridge-uclass: add get_display_timing ops
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 05:02, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Add get_display_timing ops for internal bridges linked to
> panels that do not support EDID (MIPI-DSI panels for example)
> or have EDID not routed.
>
> Tested-by: Dang Huynh <danct12@riseup.net> (PineTab 2)
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
>  include/video_bridge.h                     | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
