Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030DBC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F6C82063;
	Thu,  3 Jul 2025 15:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMn4H4xI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013C282A76; Thu,  3 Jul 2025 15:23:19 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2E78091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-710fe491842so76321997b3.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751548996; x=1752153796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8moqK51Zab8XF4hGWuqlRskaruAJVZLRoJ5szvjfI8=;
 b=TMn4H4xIyeG2B/MqrbjFfPS78308Z/O2R82OiBVpVb6bbfV0aDZIaVJWoiCpu3UqIn
 6ya6ON2K9ln5pEpNiDNsrL85H75i82t9J1opPT2AgP2owrPOz2Hv6q7iZJYyzF3jKMis
 4cpwrIOFNyI/K9sU+dnUzaA0VzG6pAWyWrYE8zDNCSOfiyAEjXhd3aLZYXVTGtM/x5c7
 LbAqDQkWNqxx8bZ3cjp79cjSMgXTpQUttgnlolcHKWDgZKfWR8q2b5+pV3uwJlDqFzqj
 5tZtMiypm4M/jn1scTZ+cm6EcaMAEive2H+s1PhH63zcOW/HRERN5n7UUtdN/HceX3Nt
 11FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751548996; x=1752153796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8moqK51Zab8XF4hGWuqlRskaruAJVZLRoJ5szvjfI8=;
 b=nRcoAJ5YdbbvtfIonuTmv7OCYDlAa5oHUspAXMNCjuo+5Tw0UfzgQnaMi8HO8nQr43
 +ssTJwjSLudQ4iBtswmjL62zx+dZKc7ScqAS3Gl6Mc1oQauOeRv4GUlVQClp+MvOmJkh
 90cJ5j4aJj8l8daMkvcyjP7dgkUmeIYnnnG0rZ5q0lZhN695bQvSE/eOs23c0X/8u4In
 w4zzuA8vYwhjqoXIAe7XBM2PzL0cN5Lr5iyrDoVJSBT/RMJh6+/6Ri7GJ9Y1umycxHD1
 tv+a/91TqZ2mxAIXeYBce1iM2I8sSEDKXlCaDSExmgB+xkKLA4SdWVTyw0gscUlS95KO
 3nCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWjrl9/2Tr7fTbu93jaS15XXw2J4yXJPloA74WenyYQkBof5dkMIx7jBeWqGBV3Q/V5IGZ2uQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwHN9ZhydFH5YfFtyx2mArQK3ieIlS0EwB6Bt5FGQ+LlbuE9J0+
 Tt8A1zeuQuU3ZLEfIVbLQX/lAvvjJJDWRY4gvHoIGOMj/gKThEbKPZuoWTtLI0GYe+pUX6nGLOX
 veqcexOvckrTDIw1CdapvcZKxr+3y+sWmwICE7cI6TA==
X-Gm-Gg: ASbGncv9RTCmprnvOOfz1/x5NgfRknQYuHPboit16aeWlcj+wiFJdQCPaIxm4CmwEyC
 jO+Lp/sVfe1DH9Cq8O9ukJM0NJuFD6VR3uDW2P/NwezSwecBd7KosCUA9FmRLPtcNCPBsXHnJg9
 3OeELIyh6IjkQDWzJF9mQre4YofotlhG/SNxyTss1VHS2R
X-Google-Smtp-Source: AGHT+IEOp4s8luvod2oCMPsb7W5HpXgtVo6tdYA44pXhLnc2xROu2WcKZ9ob2m/PIciRNbzHb80fL7ulAkjNEMcbJlI=
X-Received: by 2002:a05:690c:fcc:b0:710:edee:74d1 with SMTP id
 00721157ae682-7165a3203c6mr40365827b3.3.1751548995705; Thu, 03 Jul 2025
 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250703051951.43372-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 16:22:38 +0300
X-Gm-Features: Ac12FXywhhzVagEcSc-6mczm5cKfPiKT-wmW9-UTkCNfvb-zoDqhxBPV46lMtmo
Message-ID: <CAC_iWjKQoc9tosmGo2zm2vSAcDdG59XtK3=b+67cjX3AXJhzKw@mail.gmail.com>
Subject: Re: [PATCH 1/5] cmd/exception: missing include string.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
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

On Thu, 3 Jul 2025 at 08:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occur=
s:
>
>     In file included from cmd/arm/exception64.c:87:
>     include/exception.h: In function =E2=80=98exception_complete=E2=80=99=
:
>     include/exception.h:41:23: error: implicit declaration of
>     function =E2=80=98strlen=E2=80=99 [-Wimplicit-function-declaration]
>        41 |                 len =3D strlen(argv[1]);
>           |                       ^~~~~~
>
> Add the missing include.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/exception.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/exception.h b/include/exception.h
> index a7f21e73d75..0d4dff49954 100644
> --- a/include/exception.h
> +++ b/include/exception.h
> @@ -6,6 +6,7 @@
>   */
>
>  #include <command.h>
> +#include <string.h>
>
>  static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
>                         char *const argv[])
> --
> 2.48.1
>
