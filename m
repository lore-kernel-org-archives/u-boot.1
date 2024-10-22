Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D1AD2CE06
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCACC88FA7;
	Tue, 22 Oct 2024 19:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J4UZCJyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E3388ECB; Tue, 22 Oct 2024 19:00:42 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C24F80245
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71f5208217dso536441b3a.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616439; x=1730221239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdUR5zvxKrrtU9sVY+rkq7UaYEDGwlGnrD62pYTsRXA=;
 b=J4UZCJyLd1BHfvcT3zfQOv1LpqQN5fb1WxJ0oYr+G1riAzhefG+gcqNtreqZTG/IZt
 LOg/NrG8BBJ6+MEqiDj9EeV0KrUxhom2UF4ErCfQ4cdpbW1f1vf0h30Gm0qpDtgUb+7E
 lgAceYbbxahM7Ph/pys35LKFludOIzSMmzzyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616439; x=1730221239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdUR5zvxKrrtU9sVY+rkq7UaYEDGwlGnrD62pYTsRXA=;
 b=vUFOEyHePKD5OabomrFam9bNQePT7uPD8OvhoeU6xEbScUcE+DMpHKId95ystwL4PS
 PFLX0AcRyUw6Q0Ji/MWGXKFXwvQqcCm0tS2RrxAdyQexcNFG5oF7oiFhPB4l1100gozD
 ByDZYxYPXjgJbJdDNbn7ZtIqCsGZIdbNf56FS3LItP0+UvHVPmvRb0qoMdC5f68FrXjl
 JUsLLAFQVS/RnkcqXiNa/uVKnTfzxUo+ZavcjqRdg8joPF+LFP64FzPpp0LroWViRA8x
 7npGr6yg+TyPtZfzakmHRcIOvoARok1I73e3YQ/wTsIDZed0wtfuLZwd4DVI2KUqIYmM
 eOpg==
X-Gm-Message-State: AOJu0YzFJsiU1+ZKQgRKImZWxNgl4PQ647tDD5QGBEirj6Z0rfhZYjNo
 Is+zvB3adPlF2Wi6qGU3+VDFcq/x5T5YD+sGZgMnVyG7pChKjSdWuh2iJ+fMEJJwMmBKFJYRCez
 oLngr0030t44BnSV1BYHHjuGPdoEofmWESXgFMeY5HZlNqtGQIK3gQdY=
X-Google-Smtp-Source: AGHT+IFQ6YTwng/Bycd1mRlDRR2qTBsrdcI3sOdGC2PBcG2bkQ063gfXeCZ5EniGR+6gnC1P+e60nYhGOYXvnvTYV2I=
X-Received: by 2002:aa7:8888:0:b0:71e:6e4a:507a with SMTP id
 d2e1a72fcca58-71ea31924eamr22853117b3a.3.1729616439048; Tue, 22 Oct 2024
 10:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:25 +0200
Message-ID: <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
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

On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> be first used by the IOT2050 boards.
>
> Based on original patch by Li Hua Qian.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/sysinfo.h | 1 +
>  lib/smbios.c      | 4 ++++
>  2 files changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

What is this used for? Would you mind adding a comment for it? Should
mention that it is a struct uuid

>
> diff --git a/include/sysinfo.h b/include/sysinfo.h
> index 8a77ef44856..1c5008b5f23 100644
> --- a/include/sysinfo.h
> +++ b/include/sysinfo.h
> @@ -49,6 +49,7 @@ enum sysinfo_id {
>         SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>         SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>         SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> +       SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>         SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>         SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7c24ea129eb..1441fa4cde6 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int handle,
>         struct smbios_type1 *t;
>         int len = sizeof(struct smbios_type1);
>         char *serial_str = env_get("serial#");
> +       char uuid[sizeof(t->uuid)];
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, sizeof(struct smbios_type1));
> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int handle,
>                                                       SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>                                                       NULL);
>         }
> +       if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> +                            sizeof(uuid), uuid))
> +               strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
>         t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
>         t->sku_number = smbios_add_prop_si(ctx, "sku",
>                                            SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
> --
> 2.43.0
>

Regards,
SImon
