Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB1EE8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0EC8702C;
	Wed,  4 Oct 2023 04:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gMOF4Fbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DC887202; Wed,  4 Oct 2023 04:11:20 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A8A86EA8
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso2637740a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385475; x=1696990275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0s9stcQ0/Y8mcKHg1/0oJvhzSFZNyiA5lxjdSdA8g94=;
 b=gMOF4FbhPGcSzkTwX8tqonXE/4ci7MqhZojUdvKGuSyKmCwJCKdPoo3IRBIus7hTqT
 agcCw10lDzvE7DsZbrjsEbEvD0SDtpv5bNkn2PuvHd7xvN5lIz+Lot26iJPnpR6y6hhP
 D15g44xTNXkn+LGCgycR7q5BOl8HJO3/Udk54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385475; x=1696990275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0s9stcQ0/Y8mcKHg1/0oJvhzSFZNyiA5lxjdSdA8g94=;
 b=MNOZhq8ClFy/45SRoUecufeeWDgwkYgC0WY5ssw/UYUw5XFqJylw0kZhe/dOKUoLUM
 Js7IW1bOxdBNt/n+pHJcdRoYpHrJIQyH32Kmhe7tyHD4iMLzBdEHJyFBE/jLVloS0dKj
 35uiJ7QMsp5sRJuWWUpaRI70j2L7FymQEu17WeyOsBT1VMKJSRKtN9swLJj3rGlcTRTI
 gHLyyFsgf6pmIR7MMvqgxmg3+nLfE3J20GVgVC2i64OevBUNAYeQtbTIvDB6amRm7RXe
 0NbMtbuE50CP/7yvQGcdX2pL33knOIyOcmLSA3L0lGbukhDf6neUf+Opr8nMf3Yyg4X2
 Linw==
X-Gm-Message-State: AOJu0Yzc56BoDQlrO4BqFqm7NERmUu4hkzUh4NCLVFn5fFHDfnFqGxsw
 saq/JRx2bKwT9Tu7it03JN/lpynksr4xIb4TY5W3mg==
X-Google-Smtp-Source: AGHT+IFJqGsIVdB3I4e0fhrvRQIfzR44PEiltJ9x3YZsm1WxnV5F/X0vzvJ4CkVzg/hKXWSyd4+zx4t8dO3HEbx/xQ4=
X-Received: by 2002:a17:906:3012:b0:9ae:4054:5d2a with SMTP id
 18-20020a170906301200b009ae40545d2amr695145ejz.16.1696385474795; Tue, 03 Oct
 2023 19:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231003062126.42026-1-clamor95@gmail.com>
 <20231003062126.42026-4-clamor95@gmail.com>
In-Reply-To: <20231003062126.42026-4-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:10:52 -0600
Message-ID: <CAPnjgZ2WF-OhVohbM7TXwSZjs2nQ3GQpy2KO5tCtB9o3WyS8uQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] power: regulator: Perform regulator setup inside
 uclass
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 John Keeping <john@metanate.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Tue, 3 Oct 2023 at 00:21, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Regulators initial setup was previously dependent on board call.
> To move from this behaviour next solution is proposed: on post_bind
> boot-on/always-on properties are checked, all regulators with
> such props will be probed just after binding which ensures that
> essential regulators are set, then in the post probe regulator
> autoset is called so that correct regulator state according to
> device tree is reached.

We need a way to do this later, after all devices are probed.

i.e. we must not probe things as we go. There might be other
dependencies not yet bound. It may also take some time. This is not
following driver model design, sorry.

So please think of a way to do this properly.

One option would be to add a new phase in dm_init_and_scan() which
probes devices that want to be probed early.

>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> [jonas@kwiboo.se: use autoset func, only probe with always/boot-on prop]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/power/regulator/regulator-uclass.c | 30 ++++++++++++++++++----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>

Regards,
Simon
