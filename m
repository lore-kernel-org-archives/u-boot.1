Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C64EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53839877B3;
	Wed, 29 Nov 2023 19:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mRvxWEj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33367877C1; Wed, 29 Nov 2023 19:21:54 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645D5877B3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so8165a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701282110; x=1701886910; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkNN3ddhiBCA0jZdqQiXc1czw0BiEYre1hseMorZyLE=;
 b=mRvxWEj0oo/0WS5+Np+7zvOp5nfysJvkwIL4eANrvRl9jGGs6/J1Y2E1zmP6gRpVfs
 hsPNlpvuLjCFhjS5jMlp1bzOnGWSh2BjP0LNaPoFxclUjzIIZWObpUY5Rtqm6q9NgoPY
 hi5yH9R6cgwiWN1kGfOIsgbjhuSYNl4mUpk77UvxezaPZNESfvuJxd+u12CpyCEEUxQF
 7BBKEmABLmFJ7xxgt3x+Ufxg1b0E6wq0xaUg2XLWS2rfwEkBQkjQENXOSBSWdza0gQDX
 UbD7wt+vA3rdCQCaAaG1agkgz1ycUlWDb6aFZVmapHtRe7C/oF88ToT5DSXVn3Bv2gip
 dz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282110; x=1701886910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkNN3ddhiBCA0jZdqQiXc1czw0BiEYre1hseMorZyLE=;
 b=aAwz1wr9cRmzhIj5DkOXrjLMqdLTRyd5MSteNt0BWHHotAns5m+c5bN0CMsP8UEyAd
 MaPa0sBQ0o9lpD2tOFFf28qMLS5tRjstXiXPwiMliWxPhFj3CqGPxmbHZXmYSowgkdzE
 t38J3oNVUjm8A2b/nM5SdJj+A+5zghr++aJB/gkj85kBF2iXwhhbfCamvaYjn+E09ZIc
 DnRc8z4/wILrwzaQPJc/EQk/h0u1asKhKYcKWYDiYHemv1fKV0X+Xx7F9244v3Lp8IHY
 NVvuj9+26iu+xhb+a/h43oXi801ANi3VRaXIKBZrxGC7OQDXZmFAodUC3YSY/XU+0AvW
 nFhg==
X-Gm-Message-State: AOJu0YwCORbxnPAGw857RWgBa2vFgqxcppXHztsHGUrD3gGaO7nIw1D3
 cjJ8sXHRFeq/z18SoteJXD9sHPG4e1gTg5lF6Nw=
X-Google-Smtp-Source: AGHT+IFqkRz01W2geDsKBCWdykz7viXhQt5yLAZZHpBO1A98AMv+DWypiAqmoydPx6b9r+WfoDiDw9ejbEl6URZJG1Y=
X-Received: by 2002:a17:90a:d996:b0:285:f76:9d6e with SMTP id
 d22-20020a17090ad99600b002850f769d6emr19918182pjv.3.1701282109731; Wed, 29
 Nov 2023 10:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20231122233753.64481-1-marex@denx.de>
In-Reply-To: <20231122233753.64481-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:21:39 -0300
Message-ID: <CAOMZO5DudceEi0jyRYnEkNjYDZRoKhomPWAv12vHea90yw7cEQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx8mp: Enable TCP, IPv6, wget on Data Modul
 i.MX8M eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 22, 2023 at 8:38=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
