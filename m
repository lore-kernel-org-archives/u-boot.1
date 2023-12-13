Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231F7C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFB18780C;
	Wed, 13 Dec 2023 20:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z50krpuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04F98781A; Wed, 13 Dec 2023 20:51:24 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4C687800
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e2b8f480b3so8562387b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497081; x=1703101881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nnCQPdDemPKAKVEUukCEHOWFaU/llqK+xe5ZidFAfjY=;
 b=Z50krpuCOIOSMOS2rbMV6zj6uac+Sf6o1LiYUYWjMeH1iodC7mogKVoOZktu3KRsm2
 qAChj+ORAXDkHtaKrc8JLlyya4NfXvMgdGvyjHkihAqFRRDKJu4bxO+kdCPwcz+ThoaK
 raquwQMAoHu5xvIR1BsQguIkUObZF7RGx2kIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497081; x=1703101881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnCQPdDemPKAKVEUukCEHOWFaU/llqK+xe5ZidFAfjY=;
 b=Y3wAjA1PKo8VaoE5VwciQCpY5gur+BoiL8fS/fKD30rVYjrMp468DD5mNA+XMgtKrS
 BwMIf3vTCuWdGv9KZFnVK6TD5zUPSUEqrRQdQASj/FkKgi5W6GD8fYW/OSxeGBwQE2RL
 Y5IsrEgTcMOamufTEdsBSF7QzZM588I6BsQnjfM5Aixv9C+XwBl76XPZBpsZ8ciM+pEC
 pbndvGZLA0Gf/rnwJf7AfIAy1t2/LDqLzIJFXX7Pa9ctPyHhd7d/i1sZ8KS/pYjnXiek
 1AUSAUWD/KXa/9Au3H8kMTNyDQkre5Y44w/WPXIexR/nlTxioxEacsr74TMkZclntMxD
 NVmA==
X-Gm-Message-State: AOJu0YzEQ7+KgXbRHH0gOSojQAkY76BdRcxNbiA7qCWyAxRzj3/H5b7o
 l1pN7LqTX2bo/M+XKwHHjHkTyNjAxuQX9R3go4JK30G/um+k8ymnM2s=
X-Google-Smtp-Source: AGHT+IEUlc6+ZJMs0u6QCKZ33USkdDs/zReFlNHfw8iGozNgqaH/ls4G8JJtK9IB2NSF1zWND69iP/nrUnCqsyShjUM=
X-Received: by 2002:a25:cb54:0:b0:dbc:c924:c0b0 with SMTP id
 b81-20020a25cb54000000b00dbcc924c0b0mr1699521ybg.15.1702497081270; Wed, 13
 Dec 2023 11:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <20231212085236.2730768-4-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231212085236.2730768-4-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:09 -0700
Message-ID: <CAPnjgZ12ofNdg3L=TrCjr-oqfmM2EitwVLq4Sy4mdbpKLSR2mQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] test: cmd: setexptr: Add tests for bitmap string
 format
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Lukas Funke <lukas.funke@weidmueller.com>
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

On Tue, 12 Dec 2023 at 01:53, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add test to test the bitmap format specifier
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
> (no changes since v1)
>
>  test/cmd/setexpr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
