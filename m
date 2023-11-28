Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE1EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE56A8754D;
	Tue, 28 Nov 2023 20:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="US8UkyGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F5E87759; Tue, 28 Nov 2023 20:10:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9A786FA6
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a02cc476581so796419666b.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701198600; x=1701803400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zP0y8DU/EgdsS7aCo7coD1ffDbsw/+ynuinMaqBscys=;
 b=US8UkyGkc7PjiPRIlWqfqi0bXqKqDdmokmecGm4Q/e6YTMbtMA69/v8bhdeChNYef+
 CqonyiLG4Z868fv4RViSj/JOMvTVbkSPYfFY+9EFg+/8YMxQufny/uT1rLmvHyFeafhz
 LSRA3PvVn5xDm0lAh40CCibI3d2qxb+lYNDk2w7nRAKpQTNyRuPvToOhZJwSndNImTeA
 53oCOBwM6XT7rIflx/Kh0xlVfWw45RxykW7YzpWIjylcAXGXkbSTaSXzXOWVC1iwiDRz
 rJTmenKVFwlBZlwmvEt1coLrtxs0LUYC4aCegHx9J0TpKxSR2ZCdXfjKkPRcBvPsJFs+
 LPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701198600; x=1701803400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zP0y8DU/EgdsS7aCo7coD1ffDbsw/+ynuinMaqBscys=;
 b=JjVTbnwSazpkSbLCb5nT+IR+eDUzyWq3d+RjTtFR49EUPTAXvVNdBZaBuoj3Hb/Fwl
 IBbDZa8ULYIsuklXe3WSt4yQYBqhz0QBE5qAC/btFaoyOW0xA0seZVBM3Xv4tnQNFsUI
 jYRNyb15bcUDeACCCZI3eoh2XIEYqLCeiWK1fBMsie8bUF7CgesdMTairb5haT1bIt3V
 yKE2fOt75gqyvjN85SlMmKBJVfn9k+sIoofw1VDI0m1BRMafDRuX93gicI5xZ15DDJw8
 w+4CjJgyuA2S2+bqRKFQWtI773U+BvmBEew8CPqjgFQ+e3P8uKyz/ofIQDXFBBJrH7W0
 ukCg==
X-Gm-Message-State: AOJu0Yy+DImg4oCwiEJJNKBoRADaYSUTMHn2crxk8jVcGzNscKlMtaiw
 pve8e1UxpcbjOd5Yjui6EQSeVCL5Yzh6Ztwq5clkZg==
X-Google-Smtp-Source: AGHT+IGYvRv1bDFx4wkZSWwT7C+1pq7lsnmc9XrTKhQ2cmZIYtXu7w8zWQicd2E+Y6bj5ATrAr8Y+WtzVoQic48LwAs=
X-Received: by 2002:a17:906:608d:b0:9d2:20ee:b18b with SMTP id
 t13-20020a170906608d00b009d220eeb18bmr10691434ejj.42.1701198600643; Tue, 28
 Nov 2023 11:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-7-maxim.uvarov@linaro.org>
 <f5a9872a-0cff-45c6-b0e6-a8caec9d5755@linaro.org>
In-Reply-To: <f5a9872a-0cff-45c6-b0e6-a8caec9d5755@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 29 Nov 2023 01:09:49 +0600
Message-ID: <CAD8XO3Z=937HE_qKUuxqq7UEEy0kDRTFrAuv2qzpn4HE1M5PNw@mail.gmail.com>
Subject: Re: [PATHv11 06/43] net/lwip: implement tftp cmd
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 28 Nov 2023 at 22:34, <neil.armstrong@linaro.org> wrote:

> Hi Maxim,
>
> On 27/11/2023 13:56, Maxim Uvarov wrote:
> > U-Boot recently got support for an alternative network stack using LWIP.
> > Replace tftp command with the LWIP variant while keeping the output and
> > error messages identical.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >   include/net/lwip.h             |  13 ++++
> >   net/lwip/Makefile              |   1 +
> >   net/lwip/apps/tftp/Makefile    |   7 ++
> >   net/lwip/apps/tftp/lwip-tftp.c | 132 +++++++++++++++++++++++++++++++++
> >   4 files changed, 153 insertions(+)
> >   create mode 100644 net/lwip/apps/tftp/Makefile
> >   create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
> >
>
> <snip>
>
>
> With:
> =======><==============================================
> diff --git a/net/lwip/apps/tftp/lwip-tftp.c
> b/net/lwip/apps/tftp/lwip-tftp.c
> index 7b384cecf8..1d1b7e8fa5 100644
> --- a/net/lwip/apps/tftp/lwip-tftp.c
> +++ b/net/lwip/apps/tftp/lwip-tftp.c
> @@ -8,6 +8,8 @@
>   #include <command.h>
>   #include <console.h>
>   #include <bootstage.h>
> +#include <efi_loader.h>
> +#include <mapmem.h>
>
>   #include "tftp_client.h"
>   #include "tftp_server.h"
> @@ -17,6 +19,7 @@
>
>   #include <net/ulwip.h>
>
> +static char *filename;
>   static ulong daddr;
>   static ulong size;
>   static unsigned int progress_print;
> @@ -38,6 +41,12 @@ static void tftp_close(void *handle)
>                  ulwip_exit(-1);
>                  return;
>          }
> +
> +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> +               efi_set_bootdev("Net", "", filename,
> +                               map_sysmem(daddr - size, 1),
> +                               size);
> +
>          ulwip_exit(0);
>   }
>
> @@ -92,6 +101,7 @@ int ulwip_tftp(ulong addr, char *fname)
>
>          size = 0;
>          daddr = addr;
> +       filename = fname;
>          server_ip = env_get("serverip");
>          if (!server_ip) {
>                  log_err("error: serverip variable has to be set\n");
> =================><======================================
>
> Loading EFI works again, and you can drop patch 15.
>
> Neil
>

Thanks.
