Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87371C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEB787954;
	Tue, 26 Dec 2023 10:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QiaKmJJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F58878CB; Tue, 26 Dec 2023 10:50:21 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244E7878A5
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204235d0913so2353363fac.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584217; x=1704189017; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si28QcTVcaz+QddN+iwQmeKdkn9xM97JW1ybfxVPuCE=;
 b=QiaKmJJwWtz7p34P7sACQy5eNixgg1kqQjBlKuYJiuW7uW6RIMQsTwCScpZOptC9yl
 XcinUbtaqXHxtn5F3PaVduIwcdbQ6GHs4gEQOYdNOOYlcFWpQJ6iTQ8S91+ji/k4JKI6
 gHYEg+xPeOUlVD2JmV9wFw+hjEV1e9XppgYDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584217; x=1704189017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=si28QcTVcaz+QddN+iwQmeKdkn9xM97JW1ybfxVPuCE=;
 b=pR9uplJEUoftz8ydSVt0B3p6WhbfdpbkyODzto3gDSRvd/VWOCnJdQHOY/7vtjS0CI
 obBX0+mDgvGiEjK41NU6/Ccepn6CI4lN4eAtuzoz19ZZkOXgtGcvW/kJnClQ331nfSeQ
 g6jarTUkeps0/IFSczJpwOz6nvC0TFLChshd/WS/sdeCchh/mIEThXIv5Xuos5RQtubs
 AAgTa9U2zc8mG3pb9us9XVKKVIYLCStMUQcwtO9EKstr8Sc9CflWmaiQcpf5SbnMHM48
 TbxcVcrIMFkYuECbD5T/UOXxzIUQOCRGSiaVJSPLm8n+J1I9RPe9/NTLG/uGhoKv/RNZ
 zhpw==
X-Gm-Message-State: AOJu0YzAGcrtgchoUCVNjOmc/8vpiqzeSRkzx3BXGFT2uC8mfFTmLV3s
 qO03PZystxHXfe+SJWeFYoCO320rK3XuuZ9fcyoDC0ScZ6T/A3OLlyF0M9foiQ==
X-Google-Smtp-Source: AGHT+IFEIC6G8t1E+61QFFwCsA0x54lgYuBpTPACSlqVES9C5/E6Y0VJgeKbBCupSmrDZ2QyOCAo3qaAjbCxq5SZ6J4=
X-Received: by 2002:a05:6358:9047:b0:172:b387:51bd with SMTP id
 f7-20020a056358904700b00172b38751bdmr3402713rwf.25.1703584217046; Tue, 26 Dec
 2023 01:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
 <20231211122051.1240855-2-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231211122051.1240855-2-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:05 +0000
Message-ID: <CAFLszTjjjXmvrCSXNS03uqhqEvL1Q=MYyjxK_RosgyT6VzZ_XA@mail.gmail.com>
Subject: Re: [PATCH 1/5] sandbox: add generic find_next_zero_bit implementation
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>
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

On Mon, Dec 11, 2023 at 12:21=E2=80=AFPM <lukas.funke-oss@weidmueller.com> =
wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add generic 'find_next_zero_bit' implementation in order to enable the
> use of the 'for_each_set_bitrange' macro. The implementation is currently
> missing for the sandbox-arch and using the function results in a linker
> error.
>
> There are more efficient implementations in the architecture specific
> implementations. However, for the sandbox the implementation should be
> simple and portable.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  arch/sandbox/include/asm/bitops.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Could you add a test to test/lib perhaps?
