Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC8C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 06:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F32B880A5;
	Mon, 22 Jul 2024 08:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GgmtLt0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3C188276; Mon, 22 Jul 2024 08:53:13 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA688800C
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 08:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260f057aa9bso2244165fac.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721631190; x=1722235990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zc/p5/1xMsZVNfZCUi9WDcELXGhx9I8UCRp9NZzoa5U=;
 b=GgmtLt0qo34amE5nbmKiRxfhVGdfxP0H4IReygd8hQER8x5QeEbNvGYLb7P46h0dPd
 z2OJKfVvdY6Rf0wp/tEmdboi/dLuGK/4uCeQC0juULDFAr+ihaacLVlwcAOSg7bgJnGW
 VerTROd/diX9fxbV2UrnezHB9ce1R7K7pnX1hMbmN1whMJcTDg7uhO2bd55at40KE+Ks
 knYtiXXffM3Hn1EZoYTqGqY/i4nvmZY9QSFF5Gcr8YopIBeZ4XpPY/6p8pLdTEmo/t4i
 OHh+zVsOt3Kopv8f+8gGRg0i+oCN33OKwB36RaQHPD/1ibq80T1QMmZgi64weLqZHf9j
 DG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631190; x=1722235990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zc/p5/1xMsZVNfZCUi9WDcELXGhx9I8UCRp9NZzoa5U=;
 b=TGL7bDWYotlSg+CWx9pGKMXZqGT1YeWBfx4mPilvcgBP671d9at0e8a2A0Wc5QLXXS
 f+E7vMFtyLU2tfdr4Hp13Aksh/K5XNna7w2qzfk17DRIi/YeOL4kFNQ+AP43wPtTjdnR
 yEWQ3uoiWqO/PVrGikOwRC53lNrCSDymRx8DU6qM21jhxt1AvDtFYevsQ2g2qIdnPXGS
 kGDxZ7DYm6QdfZuelAv1bS3kKqVXO616D96TkjuYm32o0q0cRy47gQ29pfSrYgI4P+v9
 C64BDlOtoMr5Dtcgo4Kkh1fUiYoGn9CWCHPYoOBgmg5I5drxViqKujCseD4Ld21xDW9r
 fs6w==
X-Gm-Message-State: AOJu0YyDksIEOYONXL5XX6N4qjXbTIA/7OJVCDAe7HoDEOTRClwmmcQH
 JeqSzs/hLffJ6gzXiY3w3lPg3hZlUqXPjhFwlDEGvhV1+VbCvrwPgodbvr5iOlHKlKxn7rvNxlo
 GWFY5/BbkvDF8wWesbzWzh4Dutk1y70lOf6iaww==
X-Google-Smtp-Source: AGHT+IFJ6gnXmVLwU88MdbCbdd1C8E7VUhGr+7fHu9f/K7rnOrwgOKBbKTTIQt1eY6t++kRnRMMSCfqs+NI6nuwDc1Y=
X-Received: by 2002:a05:6870:3041:b0:254:e89e:fc1d with SMTP id
 586e51a60fabf-263ab59d582mr4875307fac.51.1721631190034; Sun, 21 Jul 2024
 23:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-13-sjg@chromium.org>
In-Reply-To: <20240715101354.97895-13-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 09:52:33 +0300
Message-ID: <CAC_iWjLb7OK=SFusJiSR7d=Kzctv7mWwMQSka-6G43LFZDNcMg@mail.gmail.com>
Subject: Re: [PATCH 12/13] boot: Correct indentation in efi bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shantur Rathore <i@shantur.com>
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

On Mon, 15 Jul 2024 at 13:14, Simon Glass <sjg@chromium.org> wrote:
>
> Fix a minor indentation / whitespace problem in a comment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  boot/bootmeth_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 56a6e47f5b2..39232eb2e25 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>                 return log_msg_ret("sz", -EINVAL);
>         bflow->size = size;
>
> -    /* bootfile should be setup by dhcp*/
> +       /* bootfile should be setup by dhcp */
>         bootfile_name = env_get("bootfile");
>         if (!bootfile_name)
>                 return log_msg_ret("bootfile_name", ret);
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
