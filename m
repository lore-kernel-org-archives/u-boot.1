Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B45CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8830784836;
	Mon,  4 May 2026 22:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A7EqkBgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDFC8483F; Mon,  4 May 2026 22:39:59 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD8184706
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so710905166b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927197; cv=none;
 d=google.com; s=arc-20240605;
 b=Ghq9oxDHXS6frPf9BFOFziYFQQu/urLl8BZ3xi2y3JooU+OZMVTAP3xbGCF2qhEodT
 9vgeTUgI3Np8bRa0oH1P/SurlGToQlpE7Scm32focOpDeif5/UgOssEFj5R1P4NFdI38
 11jhytDmqzbdKs5GDOtzGhc7lkr/bZw3h8ChWnxoeMssM9HPIjzyedBdYhCjTPekAw96
 4bC+K5uxhXpifsf1LP0AYkUu4znsOKTUy1BD85wC5BTYSTm26sgTB10jJaND50bKPMkd
 r3WSGgTmTqIncnixQnfSZJaL2mERoSQt2yqo/fpqHSxC6hjtCjCJBgX6E/F/f8pTkyD9
 Pivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lHldQmdd9PLvjqnzwA2HjnQme3MB9O4w+mhnBooenKQ=;
 fh=6sX/JMBB1a9uFLN+GawcERyIrfwFtjkiJ6nSJPOXXGg=;
 b=AO5eVuCxWLvalAac3VfAmm8+eIoHgHLLykX2RqrJdjzrC/cbf0uvfkpRyCSg8l0p9P
 zCgR4JiWwJpVhhY/wUe9k3QH4N9yyBgsNqx50pJN8PsNooRg91gwaHbXER0O66ofTBi4
 rRgZTx+Ltaa50tIhoEv+FtMCMmurPhHgg9nNZx3PfQ5EroFkWNLuqaX4QWNwwb1CntPS
 Asmu8W0pTBJQHVEfZYS4D/QCHtpkfikEqXVUZ4FEQ4pfufUNauI+4V4j+fmL6TkSxE/V
 EhZqA4UgNTaYo0OshnleUDLGtG+UJ/wRwNH4SdCEXbsz4WGL41xmRNh1ud1jtJy7jlZ+
 XhbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777927197; x=1778531997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lHldQmdd9PLvjqnzwA2HjnQme3MB9O4w+mhnBooenKQ=;
 b=A7EqkBgM93gzuaiPuGxSpXxXCNt/9mqVP+tBNqWhrntcqN47Xk1xkR28UuuhysAZ5o
 vnJ9gHW2lr4y5vHtbyfGbzqBBGzOoh7frXVWccLpM5j3N1rZYs4sX2riPAy7xp124rcm
 HgiiIIVgqim5tA8fjnsL7JxrNmu6QJ+adLKjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927197; x=1778531997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHldQmdd9PLvjqnzwA2HjnQme3MB9O4w+mhnBooenKQ=;
 b=SfZRIBDd4/8nwqHCAQ28wd3SZjtTbbASFMYVLWLC3oHg3D27BxK1Taun1Y1BER/BK+
 gsYc6ELpVWE5NNCDhgOP9yuEXZ/eVK29ESHOO07emuKC3vo2lY5FdWq+4NJitztIK9EM
 Y8VigayBmcvbmQt0VdQq+uu0jOBef6WYka2kd5PzfQvWaf72x/xBITtMBKueiC3pJwgQ
 tlBsNupzoFDx/Qn7KcqKmNAWJOAFQQwJ/1TrR7VfsJJmaCkxkzcSHP6neZ2WyIj9B/1r
 UyHgqKbeiaPrh5USmWGJqws+sFWieVEBSO8tzbKYd+bYZ9uBd8E7dt9odXYuNg2/hjyJ
 b+4Q==
X-Gm-Message-State: AOJu0YwLUUUxVWzcQRVu8e2vPmWW9qwdjtvfhP1JKag3D8w6veGmYGND
 sA8XI8mKJ83mc2IGBPonmzu+TvstkD3lxjzLa0obAjkaorXWtGpobM5dwan7UBHu49naBIgqoME
 b4qskX9SVMWlKl8f02RbJuESII72U6Ea2thsUeMwOinC4l4dKwhuphg==
X-Gm-Gg: AeBDievXjmdPRgCDoe2EXThYy+Limucdp4ggNRoIgDJ93KaKFYPTSl5sPwz0wQzhOgs
 KN/mSc0UwYM0zLhq0qXqioYVEuVUvrDVuDYrlUFW45Njh55BR1uVcvSMnxEjBhsDNWBPDHdnoze
 +p0cpBIyq94YBc8vTbvbeigQP9zuhZTgBd+JX/jHGAOqtsMDK1KvPX/hzg1mBEDrilbako+tFaB
 EdDbwq4rrLCjipMFwn2rSy41qoakfW+FBWeubkuMTqhHXla4OVsaxTfwGBW5yo3V0WbxMYVoQAi
 gR283mceX1GUGlCI
X-Received: by 2002:a17:907:944f:b0:b9d:2fce:308b with SMTP id
 a640c23a62f3a-bc41173a689mr5975566b.30.1777927197131; Mon, 04 May 2026
 13:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
 <20260504-ufetch-net-v2-2-01bec4ca7169@cherry.de>
In-Reply-To: <20260504-ufetch-net-v2-2-01bec4ca7169@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:39:45 -0600
X-Gm-Features: AVHnY4LZzMH2G6GhnsLYxepBn6Pmb6BZRkJSBBg5j40Spjr3M9_eBy4miOkIIWA
Message-ID: <CAFLszTjsnTWPo+SbxuKqcDnqVWZgm0uiF8rn0syuNsbQaqe=Rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cmd: ufetch: only show comma separator if there
 was a previous feature
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-04T14:48:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> cmd: ufetch: only show comma separator if there was a previous feature
>
> Currently, if NET is disabled, the next feature to be printed will start
> with a comma and a space which is not pretty. Add the comma and
> whitespace only when a previous feature has already been shown.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/ufetch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> @@ -157,26 +157,37 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> -             case FEATURES:
> +             case FEATURES: {
> +                     bool sep = false;
> +
>                       printf('Features:' RESET " ");
> -                     if (IS_ENABLED(CONFIG_NET))
> -                             printf('Net');
> -                     if (IS_ENABLED(CONFIG_EFI_LOADER))
> -                             printf(", EFI");
> -                     if (IS_ENABLED(CONFIG_CMD_CAT))
> -                             printf(", cat :3");
> +                     if (IS_ENABLED(CONFIG_NET)) {
> +                             printf('%sNet', sep ? ", " : "");
> +                             sep = true;
> +                     }
> +                     if (IS_ENABLED(CONFIG_EFI_LOADER)) {
> +                             printf('%sEFI', sep ? ", " : "");
> +                             sep = true;
> +                     }
> +                     if (IS_ENABLED(CONFIG_CMD_CAT)) {
> +                             printf("%scat :3", sep ? ", " : "");
> +                             sep = true;
> +                     }

Sorry, one more thought: you couldkeep the separator as a string that
starts empty and becomes ", " after the first print:

    const char *sep = "";

    if (IS_ENABLED(CONFIG_NET)) {
        printf('%sNet', sep);
        sep = ", ";
    }

> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> @@ -157,26 +157,37 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  #ifdef CONFIG_ARM64
>                       switch (current_el()) {
>                       case 2:
> -                             printf(", VMs");
> +                             printf('%sVMs', sep ? ", " : "");
> +                             sep = true;
>                               break;
>                       case 3:
> -                             printf(", full control!");
> +                             printf("%sfull control!", sep ? ", " : "");
> +                             sep = true;
>                               break;
>                       }
>  #endif

nit: the sep = true is dead since nothing follows the switch.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
