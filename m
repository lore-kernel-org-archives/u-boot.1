Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5771C47DBA
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90038719F;
	Wed, 15 Nov 2023 00:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iFxZa/3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38E08722C; Wed, 15 Nov 2023 00:31:19 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63FF2871E4
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54553e4888bso9288992a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700004601; x=1700609401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oKkrHbKZVfaJuezWnisCLd45f8E25JBmDPX9TLHb8W0=;
 b=iFxZa/3t9kUNevj0rpCoDom2CfvPxCKjmD5UlxwPb0+E5LhBxq45vSVIb10RcHmwZP
 eytKVwe34gl5eMKQT4wnt3vHiBDvoJTLjsbdK8XoKozOrdcrzPnYghqz+e20idiqvZDq
 tti/RdZTWqnd1lwDMIjr/u4TQf5efe8OWrY0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004601; x=1700609401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKkrHbKZVfaJuezWnisCLd45f8E25JBmDPX9TLHb8W0=;
 b=KW/3HdP+ggjXC15dBhj3f/alX+EqtUT6XL3kJzgl6sgEv75IyG2OPPEuj5fQWqfRsZ
 t34zmjRx5HHP2OAr1exue2ZQZDF0sCCGtXDXKKMoIjD9FMruoschgTXRzBD5YXaWp2g+
 OYc7esHc+n9nw8vxFOwZL5c1DFBqYtJn6+seeR2Cqsg+xfFhBbdIVHoOJ3fHw0sp8Btj
 x4t0tdvCiCHqFHKlrPdbk1jjcK0A/7nz23ZgGeJEaw2eKk+aL8vq005x/ChJe20L7r3X
 llEq/f2zNsa2DYxtpoZy28VMbrMftK9LLRf4qKj33EBtuiYPZ8OqBXMRDIt2g7jHcO3c
 Yyqg==
X-Gm-Message-State: AOJu0YwxAU/N/J7ABcUtdsjlJ/OL+4tXLew5C53fqdTZAyEkR9glgae7
 E1jMaz1rp1Uw+RY/58VmRUTu8pUkGJpoqYXLbs20OQ==
X-Google-Smtp-Source: AGHT+IFRQRgknjfAjkIlQYWH8hvXyv7tZJInPlShlkdeNzrh/TM1YNG4yJg/z7V1D9mjQ3DLCfGihmh29qqDzwialN8=
X-Received: by 2002:a17:906:53c3:b0:9be:53ef:211d with SMTP id
 p3-20020a17090653c300b009be53ef211dmr8269075ejo.72.1700004601432; Tue, 14 Nov
 2023 15:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
 <20231114021428.531887-2-takahiro.akashi@linaro.org>
In-Reply-To: <20231114021428.531887-2-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 16:29:44 -0700
Message-ID: <CAPnjgZ2VMTxHg5pWoMLt1xuTFWkS1EwG7oSUUmY_TnTYdne3iQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] test: dm: skip scmi tests against disabled
 protocols
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, michal.simek@amd.com, 
 u-boot@lists.denx.de
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

On Mon, 13 Nov 2023 at 19:14, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This is a precautionary change to make scmi tests workable whether or not
> a specific protocol be enabled. If a given protocol is not configured,
> we skip the test by returning -EAGAIN.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v9
> * return -EAGAIN if we want to skip a test
> * use CONFIG_IS_ENABLED() rather than IS_ENABLED()
> ---
>  test/dm/scmi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
