Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7C4C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E2987996;
	Wed, 27 Dec 2023 12:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UzS2Hw8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 207AC87998; Wed, 27 Dec 2023 12:03:14 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D664A87995
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e68e93be1so3774598e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674990; x=1704279790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jdaOF6r613PoXrXRGeSX6/Uy/aUq7pS4R2buao1LBk=;
 b=UzS2Hw8+d6Ph47RRQ6vtuynWbpKwAl0SP/W49dHDnaA79hV/2l6xw2gnR4F7GwKLW7
 tYsm9hmrsVAxUQ8cV02jvG9e9PVZoVHIRPtQ+WDjgQd8zkJbD7MqjRSVjt7YTMItpCQN
 CP3gShjxXV+ciA9EzEmzabLDvBzBDdrepvoJzrr63bEyol0jyjvVPk3AI8eicrg28ZAg
 7b8neOcQtr1cFSz3r6lcGIPZYi8kRyWX/D/0p9D5IanKxgkFX+7SigZlLoOnQ2mEz6Je
 7mEE+1656lr9K2D727tW5XZyWEL9eq/9AHnOumlU9P0143pv+PvKcyqFQIJ8udOCHiM+
 QuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674990; x=1704279790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jdaOF6r613PoXrXRGeSX6/Uy/aUq7pS4R2buao1LBk=;
 b=KPSmHIRxJLZWgOB7VoMkO+K48SQqHYTimXhab5nxFSmpQNGedV9ia2hpia8dbdPoKz
 AT702QcSf84f82/naCnCMbpLT62kXfGGOo6U7ZWyyislEeC7kPRyAGiky94VcrpjYYFh
 GJmovhXsyM0Jx74oMQ3c5Ppn0a4rj/T+DDnnpNPuwSHgF0FEav/YiRBNgpsg0lRUcWJ6
 0PlFapNEZd86RBVMSdmypv/YJxtKRi2V/6r7vx16ldHSR8pv5UEsdDbwalhQ3IImb6Ix
 tXCNnoW5Af/wVSvpW9KMVLk+F8dXCt2K4bZB0At7+bxEN3h5ViRiJuEVJ6TJNO5ozVac
 tIMg==
X-Gm-Message-State: AOJu0Yyr7NDzI2q+1V3SlqeA2my/2eJ9rlILYtnIP4tuwMRIdvjmZg90
 K1wu8B/EsvfLIgUo7xYzxceDkPLVcHwc+vn73R7LOmHU6PSGlg==
X-Google-Smtp-Source: AGHT+IF99oMTWw4qSbszPU7SuUhC/VM1/H86Bp9QkQ2SuGM7PsUUquDlzV0Irv5vcOVyGP8HFxMw08lolXE/A4Mq4hI=
X-Received: by 2002:ac2:4c14:0:b0:50e:698c:3426 with SMTP id
 t20-20020ac24c14000000b0050e698c3426mr3109548lfq.118.1703674990231; Wed, 27
 Dec 2023 03:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-3-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:02:34 +0200
Message-ID: <CAC_iWjJm+n0cU5YG-CSy6JyJd+YvtJeaPY99G5nDuDhsOBOHjA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] smbios: Move the rest of the SMBIOS2 code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> Move all of this logic into the else clause, since it will not be used
> for SMBIOS3
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v1)
>
>  lib/smbios.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index b417f8a9057..eea72670bd9 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -544,9 +544,8 @@ static struct smbios_write_method smbios_write_funcs[] = {
>  ulong write_smbios_table(ulong addr)
>  {
>         ofnode parent_node = ofnode_null();
> -       struct smbios_entry *se;
> +       ulong table_addr, start_addr;
>         struct smbios_ctx ctx;
> -       ulong table_addr;
>         ulong tables;
>         int len = 0;
>         int max_struct_size = 0;
> @@ -566,9 +565,7 @@ ulong write_smbios_table(ulong addr)
>
>         /* 16 byte align the table address */
>         addr = ALIGN(addr, 16);
> -
> -       se = map_sysmem(addr, sizeof(struct smbios_entry));
> -       memset(se, 0, sizeof(struct smbios_entry));
> +       start_addr = addr;
>
>         addr += sizeof(struct smbios_entry);
>         addr = ALIGN(addr, 16);
> @@ -603,8 +600,11 @@ ulong write_smbios_table(ulong addr)
>                 printf("WARNING: SMBIOS table_address overflow %llx\n",
>                        (unsigned long long)table_addr);
>                 addr = 0;
> -               goto out;
>         } else {
> +               struct smbios_entry *se;
> +
> +               se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> +               memset(se, '\0', sizeof(struct smbios_entry));
>                 memcpy(se->anchor, "_SM_", 4);
>                 se->length = sizeof(struct smbios_entry);
>                 se->major_ver = SMBIOS_MAJOR_VER;
> @@ -625,9 +625,8 @@ ulong write_smbios_table(ulong addr)
>                                                                    isize);
>                 se->checksum = table_compute_checksum(se,
>                                               sizeof(struct smbios_entry));
> +               unmap_sysmem(se);
>         }
> -out:
> -       unmap_sysmem(se);
>
>         return addr;
>  }
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
