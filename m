Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B522DC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 22:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04B581578;
	Thu, 27 Feb 2025 23:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zj34aTqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502C78166D; Thu, 27 Feb 2025 23:54:57 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4501081429
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ded1395213so2282539a12.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740696895; x=1741301695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+m2CmWfmYzPY4B580NDRmt4BWPL0AHHbU7jluEWVJo0=;
 b=Zj34aTqOazeKL4O7jKL13ewxwrecsbAX6JiCDB+mbcv7Xn+r4xNxuuplhqXI7n9AKi
 D8OG4tUE0ECDH7CSt60/CpwGmbNUEynWP5sog2ypD//T/26gxgAGwHtFM2lHjd2c8mit
 e+BfWGL6ZrRHnf25Pc0L4gBjqr//2nffq1h1yN6Ku9gVf9Osr5tx0/6c1oIzhAwuBgDX
 Smr3EjQ+5gx808Zx8ICFsAWM4KjJGw+cOvuQEzRk0QLFhx7EJmDB++xX1le38/7hoeJ+
 Z3rV3eGI+TLsRgBrUalhFV4xNOdB7QYZ+rXxcDGqbPdejTfSFz/Yri2h1RIALpUwUCh8
 7BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740696895; x=1741301695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+m2CmWfmYzPY4B580NDRmt4BWPL0AHHbU7jluEWVJo0=;
 b=v5dpYQhfj332PQcGeIJCKor18rAt+p/DNxSFmeIM/8ygTyCrmY6uMkjDBOyQZ9WaNy
 FnyFAnSA8gUoZCC62rXGfHHoRWAyO1Jt4A9c8nBEM+JMmrH0nMXkbh4wPDd0Vhc+4F79
 8I8k3R36kqv5KxPU0EfbvqkuJXPbpMrmEG4pM/iFl1d3LzaLddJDOg/mVdTfCdOzWklJ
 WFwUHBmls3u0ijnbpOgnSxeJocAG3ejRom6UGFWD58jLkIQhQB2HEDQymhtTYNABr4kd
 eg9ZbOH/MyP9V6aEc5xnzOMTkG6ok3VgW6j+R3B819BRVAPzH15MQj0FBmVH3vCtGiLo
 xRKA==
X-Gm-Message-State: AOJu0YwDSmXJE/lANNzu32x3Rriz//Z/Uf0UJ/mDmwwaVHvn75djV3Hi
 Bz6P4Ne05yYTQbb6JMUkrOsxe6fzJPIJuuDnbdVP7b2f6bX2jjLoGVJ/BFNRrN3kioBI8LvCpgQ
 pAII8nyCZnHOghhMSuv+dULy1AWo=
X-Gm-Gg: ASbGncsP/UtdSbveX6mwIxSGxQGyAJuWzndeI++2t6Wzntj9IDhupmhrsgT31bJvPXr
 Wmdd0zfWzvR0rN357DCS4MJx+rGXc5egGh7hkwlJnVVRNxUjqI4bKGlMq1jw8ROXF8rs3wMS4mi
 lL5kp1CesrMSdao8aV/Qh1m12zTKaKzo7mqqPl2zV1
X-Google-Smtp-Source: AGHT+IHupSWSWp4T0rEusmveA6n0uLlD2vtyhtjadmHtw/2ezCr9iQOuIbcvx2wqywrsKUdTkgjpcMbwFFgmQmG6aIQ=
X-Received: by 2002:a05:6402:35c5:b0:5e0:7b47:8123 with SMTP id
 4fb4d7f45d1cf-5e4d6ac9c41mr628739a12.1.1740696894451; Thu, 27 Feb 2025
 14:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20250227205048.4127552-1-trini@konsulko.com>
In-Reply-To: <20250227205048.4127552-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 27 Feb 2025 22:54:43 +0000
X-Gm-Features: AQ5f1Joc6FJoek7HWNxeCgqMK_6jBHySj0Q3FV2Jk-0YlWhePBwfzWK-qDWhqmA
Message-ID: <CALeDE9PZPm7Hc4GQnBDSBXx29+nrC9aJgiLfDzu==pMVHqqBKQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: Drop last reference to CMD_REISERFS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 27 Feb 2025 at 20:50, Tom Rini <trini@konsulko.com> wrote:

> While the code was removed in commit 3766a249a3c0 ("fs: drop reiserfs")
> this reference in the Makefile was missed. Remove it now.
>
> Fixes: 3766a249a3c0 ("fs: drop reiserfs")
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
 Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  cmd/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 8410be576bb0..c1275d466c81 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -155,7 +155,6 @@ obj-$(CONFIG_CMD_QFW) += qfw.o
>  obj-$(CONFIG_CMD_READ) += read.o
>  obj-$(CONFIG_CMD_WRITE) += read.o
>  obj-$(CONFIG_CMD_REGINFO) += reginfo.o
> -obj-$(CONFIG_CMD_REISER) += reiser.o
>  obj-$(CONFIG_CMD_REMOTEPROC) += remoteproc.o
>  obj-$(CONFIG_CMD_RNG) += rng.o
>  obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
> --
> 2.43.0
>
>
