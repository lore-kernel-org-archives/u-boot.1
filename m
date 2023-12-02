Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F77C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98664877E1;
	Sat,  2 Dec 2023 19:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XbJuHf64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC72287554; Sat,  2 Dec 2023 19:33:44 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67486877D7
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d7fa93afe9so1231472a34.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542021; x=1702146821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGEBlTsbXQT5yh37sw3MrNHMqkdwXQbRxO98oGzQy4I=;
 b=XbJuHf64kFc/b/Elvs/+8hOXnpQi/h+LKsPVSG8LHnNHHVOltbA+3RoAW+iuA63iBw
 kL5Zng/RPppWYVm4C2A7sLll6d0f5qXNI5lNE4eDVefEb4/2VEVolumEU8xXVGnGb1d8
 6mJqGuagjeRbDrt19AOFDknixsLWzwuHp4w4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542021; x=1702146821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGEBlTsbXQT5yh37sw3MrNHMqkdwXQbRxO98oGzQy4I=;
 b=ciCIp5uTy8pXKWhXJv1oRSb9XIGHWei7Z6p2G6YzSj/qyQH23e7SDbhLGGhNTzbgCr
 HNeBkcACvl/GGVOv4g5jm76Idt0sHW4wqiNDpsgHspZR8yb9xG7H1OqbQoRvrOqG+enj
 JF9j2zpveIDMb7OREchkPCYH6tEAT7KXDFO8Wu8ST5zYIT2XvAtd7E1yghJT57PMrq1q
 qGpyKTszsDWrtnuspk0eELX+hW5XEkZZQV1tIgsnGbyaN5B4zKUyKOeYtdttFsNXiMSv
 i1QPEa5ROZarkiYeB4guhwdGA7JM3ndsudCwMrY1u709Y2YIRjDheMNEId+Bd3UTeo30
 y1Tg==
X-Gm-Message-State: AOJu0YyP1ViwFhujg2aIQzCPUWJphXU/OWDiwqysQSDNLe74kv8BMg6m
 ETkF9MkezmsO4kql9qQiFm3EA1OME6FQT85YmJJ2Lw==
X-Google-Smtp-Source: AGHT+IGdmaS/1D9qX31Z7FsgrfJBHuC3TIQ7uq18bcaVEjH2NpeUDRzxCqI582kOFcshZKTYg2BG6OhjJ0BsjToDkzA=
X-Received: by 2002:a9d:6c84:0:b0:6d8:74e2:6f3b with SMTP id
 c4-20020a9d6c84000000b006d874e26f3bmr1356422otr.55.1701542020823; Sat, 02 Dec
 2023 10:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-4-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-4-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:18 -0700
Message-ID: <CAPnjgZ0Y+unk18YHXJALs-pBNOb3dU6WwrM_vsmBT_RBCq4UvQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] bloblist: Change the magic value
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
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
> This uses a new value with spec v0.9 so change it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist alignment to align to FW handoff spec v0.9.
>
>  include/bloblist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But you will need a later patch (or update this one) due to [1]

>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 1e4f1a6342..30441f922b 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -75,7 +75,7 @@
>
>  enum {
>         BLOBLIST_VERSION        = 0,
> -       BLOBLIST_MAGIC          = 0xb00757a3,
> +       BLOBLIST_MAGIC          = 0x6ed0ff,
>
>         BLOBLIST_ALIGN_LOG2     = 3,
>         BLOBLIST_ALIGN          = 1 << BLOBLIST_ALIGN_LOG2,
> --
> 2.25.1
>

Regards,
Simon

[1] https://github.com/FirmwareHandoff/firmware_handoff/pull/24
