Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF69C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B56087988;
	Wed, 27 Dec 2023 12:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vtsJfGQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AE48798A; Wed, 27 Dec 2023 12:02:47 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDF687973
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e81761e43so1401853e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674964; x=1704279764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nTtv4QXK0CUtYDSf7rDlTot1WEsNOyGfXVtcph1lIDM=;
 b=vtsJfGQVL7NP24890EJwuiWw1+fPeCYN0h6qGxfCxTMXGX5T6FmITslQ2FXLzGQ1LM
 wX2+SHPPovYDgse0c0sp3sicVeQoQTLJxx/t6mFk62qNFl0tS51+5dwHcx7gNqG//zZl
 /eN/+zuHst4Wno6O0iI4iS60yGkpciDmX10iSK02eRnWOcMrKROFoYOJ2Spt6gKxzK1W
 83A++OqqEH9DOHIDpb2OI4WKoD5MOxVkdqL7JL+Fo56u8s8saLfRBSKeYrwpkwjzZnSJ
 0zm3dMQS+nWvWHRuSM79FGasHHJHxvA9QvRZ7Hl9BfchUaSafknFYh6eeCxa5FnOqQsI
 UrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674964; x=1704279764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTtv4QXK0CUtYDSf7rDlTot1WEsNOyGfXVtcph1lIDM=;
 b=N4HFvR236HQqZZpEo7WoFeRDKhAse0f8akgBQ/AgMsknadJBOU6VjltZX6NbseA5Q5
 lworWIyjCnGydcxg8b0bS9D++cJrLo4yHCStbCO8tMDyYlvTuRsonWcl0yxCMoKvGSrj
 pTM16gfJQy0XSrwLy4j0sI70AXmeTiT8RQc9/kq0vdOLNAmxlelGygst6PQV2JuoD1e7
 5j0OrrEhFL9Gmjq+DfD5NM9z7DJ35Id1HeBkaC36wmkcon3zzVwiqZ+jMtFiJJiB5wPj
 WgkNLmOTYgeUAQdulIpQOSiYz+VniY4D3k55X/9Z+p0WZ4sBK+8qujeI7DtNpDboyeWS
 tg1g==
X-Gm-Message-State: AOJu0YzqK/4Ogolvo3YO+yTMuZGDgNQXqzCFbopRZjxVQ3rgcRm1DPp+
 BLcqPKGrpIaEUeQUDoS/3c2UMeZAugNaNp8Exg7nuRr1nRcPRw==
X-Google-Smtp-Source: AGHT+IFaBj2iMizxThA/eCeZjyceqZZ74r0CsSpbmXq+fIr5v+xiD4Y66rFo3KDTkxAA92W6lAGjANUlWmN6kxCPw7o=
X-Received: by 2002:a05:6512:3b8f:b0:50e:7c9b:85da with SMTP id
 g15-20020a0565123b8f00b0050e7c9b85damr1663170lfv.76.1703674964311; Wed, 27
 Dec 2023 03:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-2-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:02:08 +0200
Message-ID: <CAC_iWjLTcVubyo2Ou-t7Ypm+or-bOuPSdv3SCrqNe8WPG4ifCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] smbios: Refactor 32-bit code into an else statement
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
> In preparation for adding support for SMBIOS3 move this code into an
> else statement. There is no functional change.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v1)
>
>  lib/smbios.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 45480b01af4..b417f8a9057 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -589,14 +589,6 @@ ulong write_smbios_table(ulong addr)
>                 len += tmp;
>         }
>
> -       memcpy(se->anchor, "_SM_", 4);
> -       se->length = sizeof(struct smbios_entry);
> -       se->major_ver = SMBIOS_MAJOR_VER;
> -       se->minor_ver = SMBIOS_MINOR_VER;
> -       se->max_struct_size = max_struct_size;
> -       memcpy(se->intermediate_anchor, "_DMI_", 5);
> -       se->struct_table_length = len;
> -
>         /*
>          * We must use a pointer here so things work correctly on sandbox. The
>          * user of this table is not aware of the mapping of addresses to
> @@ -612,16 +604,28 @@ ulong write_smbios_table(ulong addr)
>                        (unsigned long long)table_addr);
>                 addr = 0;
>                 goto out;
> +       } else {
> +               memcpy(se->anchor, "_SM_", 4);
> +               se->length = sizeof(struct smbios_entry);
> +               se->major_ver = SMBIOS_MAJOR_VER;
> +               se->minor_ver = SMBIOS_MINOR_VER;
> +               se->max_struct_size = max_struct_size;
> +               memcpy(se->intermediate_anchor, "_DMI_", 5);
> +               se->struct_table_length = len;
> +
> +               se->struct_table_address = table_addr;
> +
> +               se->struct_count = handle;
> +
> +               /* calculate checksums */
> +               istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> +               isize = sizeof(struct smbios_entry) -
> +                       SMBIOS_INTERMEDIATE_OFFSET;
> +               se->intermediate_checksum = table_compute_checksum(istart,
> +                                                                  isize);
> +               se->checksum = table_compute_checksum(se,
> +                                             sizeof(struct smbios_entry));
>         }
> -       se->struct_table_address = table_addr;
> -
> -       se->struct_count = handle;
> -
> -       /* calculate checksums */
> -       istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> -       isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
> -       se->intermediate_checksum = table_compute_checksum(istart, isize);
> -       se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
>  out:
>         unmap_sysmem(se);
>
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
