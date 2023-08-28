Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A737C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064388651E;
	Mon, 28 Aug 2023 19:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fk1i2xRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C4C8651E; Mon, 28 Aug 2023 19:55:32 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2106F86430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d743a5fe05aso3370632276.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245329; x=1693850129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sEgSQPEHCWck3sJEKCzkYRvvQDI/Ug0fuapJaG+PerY=;
 b=Fk1i2xRJN/gl3OsFX3eeuNNn2jInelWaiPrkoniw1bGF7rsfit70Gu9Cz1U0luOek5
 Sql4151XkQEVvHPh1D3fBjToEk67hVaFtvqzk8RGkk9cA4qUbEeUrAsq4p41TtA2qTTW
 E/F/lFzrLeFDyQRjVNxOrD2+eKqZ/OMdITozY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245329; x=1693850129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEgSQPEHCWck3sJEKCzkYRvvQDI/Ug0fuapJaG+PerY=;
 b=j5r7vARketgVUp6hWFHdtj+qw5bCu23jRTCo3D3yhlPcOwj/JWmGv/lVzWtaaj3uS/
 oXZ/v/vT117F98MaTUhdfrxKaW2C5cFhcXMBOdCbwZVl9SMd1qA32Zh6G3VXc42UJxBC
 nNNyWl0uQdagOQL4ZOgbiH0NFTt2t0VIpRG8AnT9Zj9TT/w6ViDKeWKhSYlgdpDp/Opv
 fuxVkjbaz2lfm2j8p4TMzVe/F/n1urDviZHE+w4dIrqxbuE64h9ZjvmOTEEPooIe8mJx
 RBbvnDBxpzQ80GHkNWxfiMOAIkihddMJv+AjbW4oXs8AbgRCpuclwbBIhbNm9LWUryxn
 M4Ew==
X-Gm-Message-State: AOJu0Yz9xdbCz8hU6OhZX9Q5gqGhlNcbX8MYR7+BuI6vBxg+KLtz0mnt
 1q6JDBlYYzVuHnMcpWRUT1ESwNA03RPXJTLfO2lQoaphYQxHfuMKIzM=
X-Google-Smtp-Source: AGHT+IHN0h9Oz2WnxTbGcMb7596k/A406qFDMKEblKWFNea2fgP5nWMD0IiblKH8TUT4FL2ndF9PxW/gbE/tTEFeLoo=
X-Received: by 2002:a25:f81a:0:b0:d77:94d6:aa55 with SMTP id
 u26-20020a25f81a000000b00d7794d6aa55mr16789912ybd.31.1693245328697; Mon, 28
 Aug 2023 10:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230824124420.1665748-1-sumit.garg@linaro.org>
In-Reply-To: <20230824124420.1665748-1-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:56 -0600
Message-ID: <CAPnjgZ1b89sHnHTEzqUbfgGTkALQM-Orqfzpa0fJnApdcagBEA@mail.gmail.com>
Subject: Re: [PATCH] doc: board: sdm845: Explicitly add boot.img flashing
 command
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, rfried.dev@gmail.com, trini@konsulko.com
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

On Thu, 24 Aug 2023 at 06:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  doc/board/qualcomm/sdm845.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
