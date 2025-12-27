Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A0BE8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2318383C01;
	Sat, 27 Dec 2025 15:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IYXyyBZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCBD83C04; Sat, 27 Dec 2025 15:52:50 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEAC83C01
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1192061966b.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847168; x=1767451968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ieMg7hU/mzRqQhCKwqKXeTioOU9MQehAwCi/qKCFN24=;
 b=IYXyyBZn6CeiCbHPb9FEXmuXmm9r8Crkeuqsrm0hE9Qay+xeq314HhPxYPfulezEU5
 ih35SspNmTK+SZZzxTtw4/87ekdNsktzotfNz9SJ89jyDtfxJ8y5PCZSSeFnYnS4gb9f
 ltnOGjUg/d3bMB2if8fr2hArR8cJX+IWpTFEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847168; x=1767451968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieMg7hU/mzRqQhCKwqKXeTioOU9MQehAwCi/qKCFN24=;
 b=bAJKoUnd6GdyS0Azx/Na/UfEeGaVXuko3qcsdFQry5frm+m7d1J9TA5+h1YioZQLRW
 gYI4fKEQA8BEbZPt5uOD4/Po5UlvKWWaH0+iclA1P04KS1RFHr+VqpcJnBzbrJSCifAR
 KhH72yr8oVbyib1ipDNkDfwmdm1aEy7VSpv1zu1Q7K7Bz6lS2fXOxx1STLrwtGnBvMEe
 tmWRMFIsvxaRi9J4n7+8dU6P09aIfJ7fs7CDK3dn8Qj9aItV7adlPqB9QqEp6UfZX7jw
 RvQf+N3W+KJXxaDTyC7n6eh9MhGZvRph88ZMPtYHjt8cNC1bMcDLUfsy/fjk7toRdIIQ
 eQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBUoafcI0JXhiutp1wcNXupm4MSPZ+BazWm28UiNwMuQnwYICTsnjBWAi3fkQItAMi9++hp7o=@lists.denx.de
X-Gm-Message-State: AOJu0YwFNZqsrnjeL76qmRAAsMSQHjVlfQF2r0xuNi05YklMM+6JT7Sv
 /ims9e+o3PTU7eDRe+rT3iZpp11o9c+ABHJL8LFXDOhi3UyZ5oL37u9DeeICE4kYvr2f+BEeL7u
 Em4VpLamDW0IKGbjFhBXw/tIKa2kzT3CyVV8Xi8dU
X-Gm-Gg: AY/fxX4pDrdXuZFkipNjP7tjK304LzJN2MNe1DSGBJygrrsjEms9VgFR0Pn4YnvW7lM
 WGmBNqRt7Gee1KwmPbJEhBu7N2P7XBPJL3ylkjYqJhpV6uY8aHH+Pd5L2IWotaM6pp6HQXU72si
 G9pHxaGOMKBJ01DOnmUISVC/hb3oecJSwObHV8n0NO1UYB6PuEvAHtgtmZW9m5pwEGk3ZtOgImn
 msanuyxOhLmvQX0TfjbgVfWqMpg+/Z8iSskX9oGGctDtTDarHnwCG/3ZBpK1lQ/fCTaCg==
X-Google-Smtp-Source: AGHT+IH2XDLlB1MDCBAiry3Bf0FM4YCfyXb0xp1VmehJs+MkR1b09NHqtxpFYsSqiNRxSSH4qCxgfbt2xGauHDidAHM=
X-Received: by 2002:a17:907:7621:b0:b80:3fff:420d with SMTP id
 a640c23a62f3a-b803fff4ee0mr1748513466b.24.1766847167732; Sat, 27 Dec 2025
 06:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
 <20251217-a-few-test-py-improvements-v2-2-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-2-e1f91e3bf551@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:33 -0700
X-Gm-Features: AQt7F2qHkOHrr2x7C3_tkbLhDd_t7-TbbeOhYTkQTIOCA-RKacFk32CnPMiwD50
Message-ID: <CAFLszTgkXmb=MTe-VQujfvhsfY8R40n3end4ZyNvcjzQvjn3Yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc: pytest: mention additional requirements for
 venv
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

On Wed, 17 Dec 2025 at 11:43, David Lechner <dlechner@baylibre.com> wrote:
>
> Add a paragraph explaining that in addition to the requirements.txt
> for test/py/test.py itself, users may need to install additional python
> packages depending on the U-Boot configuration being built.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v2 changes: none
> ---
>  doc/develop/pytest/usage.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>



>
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index df3821da20d..f8b32c07edd 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -90,6 +90,10 @@ environment.  This can be done via the following commands:
>      $ . ./venv/bin/activate
>      $ pip install -r test/py/requirements.txt
>
> +In order to use the ``--build`` option of ``test.py`` there may be additional
> +python packages required depending on the configuration being built. These can
> +be found with ``find . -name "*.requirements*.txt"``.
> +
>  Testing sandbox
>  ---------------
>
>
> --
> 2.43.0
>
