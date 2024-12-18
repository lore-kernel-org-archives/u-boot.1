Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B2E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AEE8027E;
	Wed, 18 Dec 2024 11:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OCPdM3BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C1E8027E; Wed, 18 Dec 2024 11:00:43 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3F480269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso43666105e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734516040; x=1735120840;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0IEc59M0uqAvjIamUafGDwUhD3rBXCSZikFDy+1tBo=;
 b=OCPdM3BQe+dbuyR8e2cYvirb62+2D7mAW/QHUL5ZW9LJ7V/fGlSy5bqT+Sx8yXQ0yu
 IuwQOW+CklXjMarw04J4kxtYYicXsbRVFTAB0fvnmxZ+dxsRvoDGUOkheaSDwiO2tkII
 Qnovn8zvPemqq5UtwZTln8SlFkh7SMF7OlX2E/NVvMmmHZiKq44Zie1Kxv3y9GkuwdQ2
 kPBjq82Y1vGX+03GkO0N/1RSMovLDOD7zIHxGAKG9Z/gnCjBbob/9xxcT/EKw/rHs3x2
 m6LsBOWggvJTlqZ6DzNZbONgE0jz3B3z5L/0hGto5wKTsC38wUCPu1ZDSt3TATFm6eT8
 5DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734516040; x=1735120840;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0IEc59M0uqAvjIamUafGDwUhD3rBXCSZikFDy+1tBo=;
 b=w2LP8vS1jom288qvj0kuv43Se4zJt+JKY5iMGMJbdTqc5nPvVkmpEJRsYlMJOI4MEi
 9eXn6aX/khc8/HOWLwfDUIFGo0ihi3Pq3cenIIJ4ZNWuFk4x59skpaABHY96oWVR90AU
 ijqsM2DN4AxGaUxx52OHc5QDHrfwXB5DbJESDxUqE23hBmQIgq9yZgR4FidbcF43Q5kC
 eFHn9ae87u80l2S3/TFkPWRhlDJo1TW6f3sI2QsklaMQHjA4JPPdEAGtI2pjYrmBUk6L
 CRZnAq/2Mf6jIXz5q103yR/LyVj3mdWoAdCsT3dhAneo7l/OaWap8mu/rEKFvx5fA2oE
 RrBw==
X-Gm-Message-State: AOJu0Yw96Czrz7Cljwu2RNoeLYwuNonoXYYqkgHLG6eJfxYmSQiob3qN
 3Tbo2CabRl7fkCUOBgxGB7/UsvBaAV29nFuONj9ZdBPpu6UTOK5bJZVNaN3BtgE=
X-Gm-Gg: ASbGncshKw5v/NhjsKaqa6K28ko4J1Fs3UriefNxMe2la1g264hqY60pJTV/1U4aw9/
 g4F6ZyJWiRS7880ASmlQehIqhYvcdA6oiPaxzPVe5pv6s0z0fyfliqSneZt0A7SUu7bcOsHAtCa
 M63WF5E8DR8Qg+LMg0cd8jWOg1s47yJppt9rjEmQx//zh0MJxB/orJpWTFjTcICbmDagZ6HXuKc
 k+qe+M31B6Zl4HnX8BzNf3FufVMYrVr+aErqgYHMi6EispRHGz4PanUUd3l61UxWw==
X-Google-Smtp-Source: AGHT+IEPDNYdZuqRq7r4/MzeQB3dJj7wPcuYYkfIdU1og6DXHREdwXcoSNiZSuYQrxdQKdPoAfwstA==
X-Received: by 2002:a05:600c:5103:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-4365542df01mr16160045e9.27.1734516039853; 
 Wed, 18 Dec 2024 02:00:39 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b053e91sm49245565e9.1.2024.12.18.02.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 02:00:39 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 4/4] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB
 DFU boot
In-Reply-To: <20241217131658.2920799-5-s-vadapalli@ti.com>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-5-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 11:00:38 +0100
Message-ID: <87seqlwbsp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Siddharth,

Thank you for the patch.

On mar., d=C3=A9c. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Enable USB0 instance of the USB controller for USB DFU boot functionality
> which requires the "bootph-all" property in order to have USB enabled at
> all stages of the USB DFU boot.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62=
p5-sk-u-boot.dtsi
> index cf087c6e343..c2091fc1a51 100644
> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> @@ -16,3 +16,13 @@
>  &dmsc {
>  	bootph-pre-ram;
>  };
> +
> +/* Required for USB DFU boot */
> +&usbss0 {
> +	status =3D "okay";
> +};
> +
> +/* Required for USB DFU boot */
> +&usb0 {
> +	bootph-all;
> +};
> --=20
> 2.43.0
