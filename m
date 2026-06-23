Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9FCDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 586E6849ED;
	Tue, 23 Jun 2026 16:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1XLy2l7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15768849F0; Tue, 23 Jun 2026 16:50:37 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DD0849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c0b97e268f3so565650466b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226234; cv=none;
 d=google.com; s=arc-20240605;
 b=BSp8rKWdS4EYfvAAY9cGdrkOrp6Dn/wgZ+IKC0d1OZdhflvvgb3VHcfqpMoXu1TxXf
 s9JEjh0MlcGvkuJn2ia5t93ULKeaWG4jNP9FV9wVmIb5REcIUoex2TZN3t/Kv2mjnC1n
 9AKrpy7z1Uivu6j3PnJGYMzxHd8G0awrL+jtsEdILyODiAuwsJhogYXhEs2g7lKSWj5g
 wZxARlUBY6sRnfQldHwDnX3aFu0pZDVsAfyJV16cKwFfrzR2VVIyK2MOrSNCUJPCnqci
 xoq0JNHarCxoqstifyW1U6ieV8Jj99znp8LVb1jYKXOEj2uUD8xb64tEwiwdA8UxG70h
 762A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BfI9//pBvrCr+2wfCgd3RcO76dLV1XVbjSCKzzk6bDY=;
 fh=rYeNvwZ95QoTu4VTExaF80OtbJOrvs3SV3AkioWYlR8=;
 b=ha/M1VAzycUDEX9W6DzEwen54ACEh7GsiSJ33DC8rmZtJ9ZlvT6yZR/AqFhSGpF5p0
 OaxCUye7liQgqj7A9CrAlbJWlqFUkOT49KU/iDk5B2N4xTbUTCF/puri4MnkT4PfMeGl
 F/wa5LdEm8BL4U0nT+YxBZa9pvviOe1UhY9AePcv3WOajV71WRjqGYiw6BgQWyJueSGJ
 H8/fzU58Y5aza+bct1y5Mtiae8IujwV/COht95j3Rbbz23xhQHufDAKM1aLsGhfo8KVC
 zNYJ2P4nkGZRyh9Aea/MocSVyjC7vFsugGHgMqvx682gV3ciM2/oRTg4GOniRKBNpf3J
 9BBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226234; x=1782831034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfI9//pBvrCr+2wfCgd3RcO76dLV1XVbjSCKzzk6bDY=;
 b=T1XLy2l7ruXKnswuJxMVy7MulY6c5Omkb/LJNdXUd2Pp9mN0pcuFs5oDI+UOCmT6WS
 +6LmGjzN2DO60K8wsTlXpqOVSh+dhf+5n66WS/9I5LT37IgkzYa3NyfqWf0QiinaHSht
 qkqtRtG5KWr5iTPA/FBUkpq7so+DRIzjld33Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226234; x=1782831034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfI9//pBvrCr+2wfCgd3RcO76dLV1XVbjSCKzzk6bDY=;
 b=ozw4aKq1Q1xcSiqGas8DoKk1Nk17gYXTIfOc3HxmHW1X0Bkpllqa7tXBXhLTnfN9q/
 vKc/hORdHyikG9vh9q8efvsvuLlpYv5fLgtVMoMrgpcndIEOSXfh2xq6lDpyoVbh3aL2
 +PeqHthdi+2uQ7i3QnwPw0dypLDR9kPEY9APCWYInyAF9V3OEml7qcQUmCFx1X7Q8jCl
 L72igjlMnwjioEh49XrjfMNqF6n31K45e3dJS3YMfUpgn54Ph4PtruMai8yQWskoD9AK
 Jy0mVMhSl5OHRrCPnz6AyyO0O3o7n73c3BVep01MqIMlx+nBLFkQ5V3Wv8PuHRF7mA/Q
 C6UA==
X-Gm-Message-State: AOJu0Yw03kF+/njFBwfSiaqM/5w1wbhIgPP+Nwoo8frecEZIPnQCG8qA
 j45PJRsrssJ0wDktpPqSz8HlY0UjRhV7g2G4ysI8A8QVdDvj2K8632t9lIBkKz0Tsmm5wAXouwK
 OsA6KDfsJXbiZuqCi+3HA0RS7fVR16tZIMDbWrGJt
X-Gm-Gg: AfdE7cnfxgyyJft1pv3Ze/ZpTpx8O6gIbJ54S4U2w94lFuzOJxMKbNW0jaTbO1trS1R
 aRSQ1eOSAiw5aVuvWInNwYXsmoUkpsal5RpM9ZS4PAux4oFq1RjDOWlZ7SBZEDBMzO+W2kwE9vB
 iXL/vgdpvk6sBRI1f/hiavHZZmo9yPfo9X4YSxyzXRiA+kGI2cpcVZy30OyYzooacqYoEKK54VC
 6XDxC88XESxpcaQ3hWn4CccorbcQaOBNIpBncFG/grQXH2OUTFFFd4jDW61EtkTCiqKceIS3Q==
X-Received: by 2002:a17:906:6184:b0:c0d:4971:2eed with SMTP id
 a640c23a62f3a-c108fdd6614mr150887366b.33.1782226234433; Tue, 23 Jun 2026
 07:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260621143938.2863-2-aristo.chen@canonical.com>
In-Reply-To: <20260621143938.2863-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 15:50:21 +0100
X-Gm-Features: AVVi8CclEEDRDOKGNubcGk69R_DEox3Ut8pUjyvzap5jW-mle5mxjA8hD8R89Fg
Message-ID: <CAFLszTiPpm-15dwp32i9gRj9+wqpEvEhiAF4duH1AzaPH38w2w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sandbox: vbe: size firmware1 area to fit the
 binman fw-update section
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>
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

On 2026-06-21T14:39:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> sandbox: vbe: size firmware1 area to fit the binman fw-update section
>
> The firmware1 node in test.dts declares area-size = 0xe00000 (14 MiB)
> but the binman fw-update section in sandbox_vpl.dtsi is 0x2000000
> (32 MiB) and the FIT inside it carries ~16 MiB of external data
> (spl + u-boot subimages). The FIT therefore extends past the
> declared firmware area, contradicting the documented contract of
> vbe_read_fit() that the FIT must fit within @area_size.
>
> The mismatch was tolerated because no caller actually bounded the
> external-data load against area_size. Bring the devicetree in line
> with the binman section size so the FIT extent stays within the
> trusted firmware area, in preparation for vbe_read_fit() enforcing
> that bound.
>
> state-offset and version-offset are left as-is; they were already
> inside the FIT data region and are not exercised by test_vbe_vpl.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> arch/sandbox/dts/test.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
