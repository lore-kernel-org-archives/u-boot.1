Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E2606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wFgitekM;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E1jrLh2c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DBA9405F6;
	Mon, 26 Oct 2026 12:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfRjemjP8vRw; Mon, 26 Oct 2026 12:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86E8740664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018259;
	b=Agbmo6vIKd0wmQ3Gb9ElK2QiSv/XpphqE6KTi5PoSxVJ1kEYwOJGTGrBbTFTURgSwKJ+
	 1pRj/TPIVyiy7du4Wdv/fyD0wFR+YkH/e+UynBU1yQQP16Ix8lRuoowWwoXZpbydboygM
	 snGLGgyNQ4ggoLTwdDueBaJLXeLGO9v5ib8Meg99I5p/sI3vAxpkzNr8lB8Jdf97CjNIL
	 p8MAAtJPSbOQgR78lhKQ84loW5Uyw/y+92mKVV5yAWw9bobCAVPpna5BDGtWveHcNHP3j
	 ko0oWVoxJtfatS/1rmeJlg6ga1MIDoJFwCmwirug4KJV4JCa7Z2RjQq6h1b+x1Y0d6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793018259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
	b=qJnfKywCNs7IknIw1+I6Da9PG2ZujoCO1kxF1Dlm5tPY+F4mpSahYjskMsRAentnjgvz
	 ZM7NS0YKNd+FryUBGyPE1rj2W4XNiEk974cGconVWuCPt12rxIAdnudzeSa2dUoma8x/a
	 64wR99Y6lX4tssuCOe+hD3NBYGUWVjOU+7vZ9AIfvpEoLaftyobbIMyKWhdTXXrwoaUjV
	 1UpjLadBflPHv+hq8XKZsteHH7a1a4hMDAefhawyNJX7P5O0OC7oW4OZHPEIlQZAtJE9p
	 sCgkgemwwDNurbNI1C3c6O72u3O75W11Pz2fD5ZtjkffKaxOfCtVRPQnsu2ZYy3kDTA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793018259;
	bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wFgitekM4YeBrNMdII0kAF53xwsbegyOGuRwx3p5sOL6E9bqj5JEF/ugwufGYUfEx
	 oQE3p/pVd1flj6oiN5RJWALP4wAbueN2d2D7eqD2vXXbsvsu/MT/G6np0722MBEAZE
	 Q/cDTyZi/0LJl6v4wjj0xXy3qZUkvxX0jtjl3x1GmuZVTVsYjsjI73koQ4I3S/TUiN
	 pA0EzIrQ6Nv3oWQ57BtMksPtBxp1yj1FDubvcwkm/5uubUhBPQ4qm0OVnWTGq52PQC
	 /rFBd2wRPU/6jwBotSgt0UMPlYVqRAJsVx6fAA0idjibOq/3kuJmmFZ8B9UrgoJi+d
	 6vn4m55bd8QDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E8740664;
	Mon, 26 Oct 2026 12:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6846235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D84596060D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZ_dmsn6PN7J for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D462605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018254;
 b=VMttJEgdLvaWcBUBjf99sONzsK8a58bwIsi9pSgSSb0mrWc/afvMu9zKuAjxNbRFpiko
 PNj3b11RZghPJRlYHov6KOgd6DL/VsbfBqmw+cNNZg2ieF11NTPVYXbl7Q9KEm2g8eYXW
 119YvXSuXFxZNCEzyBRJwvw3mWlg0fPkuN7cdLy/8AyCs1SBGnq47ofRI5xZZAtDtrJzc
 yMp7vYXPlfts6hrWgMTBk8Pm8TyclbZ7qdIU4PvZLodhtVaABrCk8+xGZKTjLNPeK3gYK
 vU8FDTy7uEL+PyVO6f9XbiIYYaf5BZUolhpXHslZAYbsGmVrIVBnKsgXaGKEEHgBDew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793018254;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
 b=VZUoOnKs9UQchA/yE50aI6fBa5LJYxim3F+iKmdYIWiUgAD3aMI1vngNYLMCIKzLezNz
 Lg/Hv3jaM5wrgYh22LlayZAJe+VzhoNj+XuGuhTTGzfr6ie+y3vWptpl3XlLkWvpV+i1S
 58QHimKWOx9rs9gfKXqijK3hqqGgPF/y+ShJwjuoB4x1+nYklBwlABKSbDlzTZ1MTkeTz
 JjMckezyYHmDtg8dlkvgUnc6lgO0ccz/nGM3Duji57J0TlOkPjBejNJZsfLlxFwJjTIMW
 ujHcZZft5tAiu7R0KupTGzeVutyzjCvuBw2ohOqmnRZqAD9zonUzSnlAe9vpHvxMB4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E1jrLh2c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=E1jrLh2c
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D462605EA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:33 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ae2b7e1e17so319631a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018253; cv=none;
 d=google.com; s=arc-20260327;
 b=ftyC+ahUHMoFSfZ77ir6Is7+a/L7QpKOJX2gpRxHuEjZloHOFgWZOJ53oHblQUm+lb
 dwmfGhu7CzayowZyjWrwXA/d1eIhHuP6oTDVuDKXTQgLDl5FnkTSeetxHvU45XEszGQT
 8mAMbmcr1jBgAP4spBDjNVExATJhfFuUOT7JQht/MLsk+ORIyw7bv46hKiptbG8QT7ef
 lcm8+Fm4/wGOSF47N2XckRpO3t1TXCCY/pK73ifKIn39C4rESLOWlZASrXZq51zGhIX3
 43plq86t6COqlgmfEVxEPoDbwhtGo6ZmRXc913RiKkFkxE4uoAjLzlm6dA8ieZos7l0K
 pjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
 fh=VfJjCBdJk/BP1VXUhUz7jRsDFzmeovrzAQxCxb3U+NE=;
 b=j5ntIDxXZopeuTZb+NSPzVlTg+5SAGfuF0fbMJHA9f5w1bhr37xGZY3GxWllXu/01U
 OoZUduxEmoW5U/oGcaDq1wd+XHgUr3ZlzK0wj3Gpk77uorMpAlvhLvgpRd10hYiWyEO+
 51xefrQZV+u/Tx1or8ZIbDs0beO5sf5ybOOwhuZgPCDTl1C26/BRJUNuRilhE2eZYKdC
 vVJmeannWBvcITrl5GuxMNkL8Xu6lnwyL764j4u3TP5K6wqY30bvLXjzx0QZstqiEAV0
 yQt+fvQQnFbm4NIiQ4ADFl71z++g9AP/r8XaEn0r4TunoM0GuQ+VGbRUsGPEXidSyeOo
 m/UQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793018253; x=1793623053;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
 b=E1jrLh2cbD3njWV3ezdDjD+OPcqV6VL4UCUhOIuiQjWcPYmXQE4Xeq+dvxAWP3otQX
 sURIH/PYrvgKfWXUHluX/YGFFjdijYNryWLb0956bJGTZr3hMM8HnMWucwUiysELeo0O
 atzmwaDpB9Y93Sgqpof00+D2mVd5VaqoQBboQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793018253; x=1793623053;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KMBnJWbxcZZMkBSIhvgr+El+NY8jduIri+UoC+sWJEs=;
 b=q5Kfe/nm0as27GqJIHQTPPvb/PrfZwV7hgupaJ7V1cT8cYwVFKm1F9fXtgfuahruEr
 3/Lz7134POYJDpi/+33omAFxX82fWL6SpC7qgnAHl3lH0YIQ1KZ0YwFf1kUQGcfG6MkZ
 csTIE2Qu75HaaOj00hj16pGzoKj3UrWW88hZZ8/gyJV7zYxmkFXxIcVCVX4oeT7tjP0y
 OpsPqCujAovHFvgHCPpeQYfetiH9B77pstttdrJ6oUTWU0jZA3aI7aJu/ZW+BHSP39RF
 b3G0fVjfLPbCVCHaul504nrkzxJyYv7/RQKCQhS4ff5FF3evXjCE84MGFvRw/RrjJOI1
 o3Gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCEBj7zRXieF9JnX18mwf7i0cO+gMdK/LZBPLkDlve6/+fpQqJDNh2K2rpv7AA8VAqLt0l0NQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbtkoVdpdGp/xbggqLQ8c05IUt9BghcR+2YUAbbJ583oEYcOoJ
 Ew0C3cyaJ/DyfEHAbBy8MBtl5+SGYe0YZ4247UZMg7QmfTq+a0Kh7YcthjH0smMQ1uNPt/ZvfEt
 RE/hL1ctuz5DYqD8OBVgYa+67TDERUZZQ/XZyW2Q4
X-Gm-Gg: AYBFou3KMU/lDJ8ifnhj1+BhdrHuOvP5ia8NiC+07lEjYsIgbUduFe8ZEzArL5lxQG9
 T5AKJp8k6EdNC6cqoxzOCBdBM/YmtpLiyXEg6QeAia7HHR0r84KP5UIJ+OLaQ4drTiSNcVjP4Kq
 iYBy9QZmuKPy56Y9Qy2tYpYxQ4riGl7vw7XFR1w3RekroJKmqp4lK7AYkmtkzA5zuI+hCsFOpRK
 AJhO+Dtj6QdqHyPZTbvJtLTAilqIhKz163hsGxOLcdV5Wn2xvbUWA1MLwaTGt5xi359Rrjmjt5m
 XdOkeHqXyJCxQn0rFTSS/81LExLHNZM+q9lXlrhbNxAw0eMABE15uTeAcsurPwJ6W2NIgbQ8DLA
 NShZRLAVO1cGx4PRBr6POCNc9st8YQjBPPigevyaoMA4U6EjsjdA2oI2s
X-Received: by 2002:a17:90a:e18c:b0:3a7:8c68:6446 with SMTP id
 98e67ed59e1d1-3adeafea707mr5342124a91.63.1793018253287; Mon, 26 Oct 2026
 05:37:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:37:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:36:37 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-8-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-8-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 05:37:29 -0700
X-Gm-Features: AclHuK_p3cthyNz39AzeNDCUXWk2dL89Jk2IZgk2XO7NcOyikQxrydoT-A0kEfs
Message-ID: <CAFLszTgNfacD0cDBii5VudmUWZhGThU2WFGHh=qNr6FvM5PTVQ@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accelerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
>
> [...]
>
>  drivers/misc/Kconfig                |  23 ++
>  drivers/misc/fw_loader/Makefile     |   1 +
>  drivers/misc/fw_loader/fip_loader.c | 558 ++++++++++++++++++++++++++++++++++++
>  drivers/misc/fw_loader/internal.h   |   2 +
>  4 files changed, 584 insertions(+)

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,558 @@
> +	lbaint_t offset = part_info->start + part_offset;
> +	lbaint_t pos, to_read, read = 0;
> +	lbaint_t blkstart, blkcnt;
> +	char *read_buf;
> +	size_t size;
> +	int i, ret;
> +
> +	read_buf = malloc(desc->blksz);
> +	if (!read_buf)
> +		return -ENOMEM;
> +
> +	size = min(firmwarep->size, (size_t)ent->size - firmwarep->offset);
> +	blkcnt = BLOCK_CNT(size, desc);
> +	blkstart = ent->offset_address + firmwarep->offset;
> +	pos = do_div(blkstart, desc->blksz);

One thing I'd like to check: the move to lbaint_t in v9 breaks 32-bit
builds. Without CONFIG_SYS_64BIT_LBA, lbaint_t is a ulong, so on
32-bit ARM blkstart is only 32 bits wide. do_div() needs a u64, so
__div64_32() then writes 64 bits through a pointer to a 32-bit
variable. Building Cubietruck_defconfig with CONFIG_FIP_LOADER=y
gives:

    include/div64.h:220:32: warning: right shift count >= width of type
    include/div64.h:224:36: warning: passing argument 1 of
'__div64_32' from incompatible pointer type

blkstart is a byte offset here, not an LBA, so please can you make it a u64?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,558 @@
> +		to_read = min(desc->blksz,
> +			      (lbaint_t)(sizeof(*hdr) - read));

The same build also gives 'comparison of distinct pointer types'
warnings from min() here and in blk_read_fip_toc_entry(). That build
has no CONFIG_SYS_64BIT_LBA, so lbaint_t matches blksz, but size_t is
unsigned int on 32-bit ARM, so the two min() calls in
blk_read_fip_firmware() that cast to size_t still warn. With
CONFIG_SYS_64BIT_LBA=y, lbaint_t becomes uint64_t, so these two calls
warn as well. Using min_t() for all four would avoid this. No in-tree
board enables FIP_LOADER yet, so CI won't catch it. It would be worth
building a 32-bit board with it enabled before v10.

With those two nits fixed:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
