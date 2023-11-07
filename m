Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B2BC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B63B8707C;
	Tue,  7 Nov 2023 13:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ejcgLwWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92805870EB; Tue,  7 Nov 2023 13:23:22 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A75587098
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so7345652a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699359799; x=1699964599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dK80Glwohnq7XjDiihSkUXIccI4jX9qMvgljNOHnpaE=;
 b=ejcgLwWFwtlcEGlPY9U5iuhKXGbe4VMYTYnKo/8WCB8u6BXipAUTkMMvwy3QSiL30W
 +1/nY7vTurUDxINBQrvNEqVt8itBeuqzZy+sf4cgrxVwgL64Vq5TAzQwJy6jla8/Z6qZ
 Us1VnyYb03Wb60QEtb0P+bHFgljSxUix3JjT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359799; x=1699964599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK80Glwohnq7XjDiihSkUXIccI4jX9qMvgljNOHnpaE=;
 b=NryaqTNtKcsHsDxPERp92yBvyNPNJOA2Bn2wElnZ8kO4M4RRkDGaeA7+363p5Jl7rz
 u2R8atcgXhdWMge5zUotKhyLZcoTPgmRkwByQN79fRPtzk8c+UB2nzMdckJFfkraV6+U
 NnatSPCzcuV03L1yZsO5eOe9GjWkMGbbGK4J9HcSurv3IzSweu/OxehE94QQXw0ZnfUU
 pESftX2U8bNv15qF6YIxPowctm16pmTMpBn0z9ORviNfnMpHtWVP9bNj3YFs6iwdTOrv
 4gnsFIaAeB1iVvu3tjRAFqQTsThLhCf5wgZGg2Gyk2U3MoSrLf1kiaXshpjpxYFpxxOo
 nT2w==
X-Gm-Message-State: AOJu0Ywmr28SudZhS7sZc3WQ5FNvUV5hEsi/zdyFDCsFw8yQRkmZXN/D
 UfLE+G/jwUbM/Ees8g4ltabqLKnKBZbt5aC+CiUsWw==
X-Google-Smtp-Source: AGHT+IF6ox/uDfMubPyairfdO25ziLh0RPGUGY5Ck6zsDcqvYf1KMlbdHNq90DlBx4Gr2pE5P+/mxK/5SF2I/AN4IoE=
X-Received: by 2002:aa7:d804:0:b0:514:9ab4:3524 with SMTP id
 v4-20020aa7d804000000b005149ab43524mr26873761edq.7.1699359798942; Tue, 07 Nov
 2023 04:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20231107101729.1.I843fdbc83d3f8522e4c43d47c72825b388643ac6@changeid>
In-Reply-To: <20231107101729.1.I843fdbc83d3f8522e4c43d47c72825b388643ac6@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 05:23:06 -0700
Message-ID: <CAPnjgZ2YgwAzsG2kHZZWgy8p126hBH_r0r55nParwOt5wjuW+g@mail.gmail.com>
Subject: Re: [PATCH] bootstage: Correct exhasuted typo
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, deffo@gmx.de, Tom Rini <trini@konsulko.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
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

On Tue, 7 Nov 2023 at 02:18, Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Correct this typo in the warning message shown when no more bootstage
> records can be added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> I just cherry-pick the Simon's patch in the branch fix-bs-working
> of the dm custodian git but it is not yet present in patchwork.
>
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/8810b8dd3d233978c15203b23420fa819ab1e791

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you


>
> Regards
>
> Patrick
>
>  common/bootstage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/bootstage.c b/common/bootstage.c
> index a68d883c684c..0e6d80718fd5 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -137,7 +137,7 @@ ulong bootstage_add_record(enum bootstage_id id, const char *name,
>                         rec->flags = flags;
>                         rec->id = id;
>                 } else {
> -                       log_warning("Bootstage space exhasuted\n");
> +                       log_warning("Bootstage space exhausted\n");
>                 }
>         }
>
> --
> 2.25.1
>
