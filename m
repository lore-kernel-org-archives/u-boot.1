Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F82C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6B284B01;
	Mon, 13 Jul 2026 14:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lc0FVIZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C68084B01; Mon, 13 Jul 2026 14:42:01 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F93384AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so7645729a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946519; cv=none;
 d=google.com; s=arc-20260327;
 b=b7LTxe8VsGhQUpNYRY7YpttinrsBJ8Y+vABu3rFrcnCbpyvr6zW211rMNUgA4cVtdJ
 K/kgqVYOeplSAh+8KREgg799F0kuQra4IwLhbBdtHd+Ne5sqyjJMduDH5aKwOCY1fEW7
 mTascgpgN2qTcpn8gs+YQxA3K+qZPeci0khJAZVmTYwocig5/625Bi8Hal3sT0JYnh+2
 yBxdy0+xfXCXojM3gZQ7LQowGEu1kTUX8UlLMyDm4ueuMvn8kCwhzz0xiM8aZsO484H1
 yYMitxwgw5YzzL1O8xmoLX1vyA2xuzK48d2V4PgSsLb3hKLOtdCYYhfd0pxL2/zLVQK0
 HPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pwMvdaOMSeZtf2pjuCgjH8L5FlSettO4E8ClGd74tus=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=LXfNGRLoTJ+9W3Adu0p7TMOEz4xcH1XzWetgOjS0oKfE4+qpggZtyJ90b+SLIY8YoS
 GfhgbiJOcv5HVE9ZAmBFJSuvze6XLs9nPfDzIC1pcQhtIXpCkgyfYRXhVv3xDTXkN7rG
 V1lFicJDp2knijdZ72G2z0zW4jVuiukqzk7aQdvysdBxql3kPX8V3NWMFGGZJLfztIMj
 qoT+WCUeapHvm/LlQcsgITZ0OsbvM2GHqUpI6rkdX4Lsg3xqW0c1E0KbPViTcCmwA1me
 sFDmUv83VQ/xocsCs9qy0Pyi9DpFfjzSMxV8c/LIuE8WVIcUMVK/aHrZHHyMKr7qjhXY
 X9cA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783946519; x=1784551319; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pwMvdaOMSeZtf2pjuCgjH8L5FlSettO4E8ClGd74tus=;
 b=lc0FVIZG3k9dARdGWqsbRxw4YWizn06y0MWqe8TN5WZQAuFzcScoBxixRa92n0jlQk
 AAeasgYi3tUj5NrAK9H3+4YH8WmNF/9jnXvHL+7uLsyZWpHUDRR5WjxXXVgpRdzw+gjn
 BE8tanKxObg3Q/DwQTv9r+zhuNcAZ3sv16C60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946519; x=1784551319;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pwMvdaOMSeZtf2pjuCgjH8L5FlSettO4E8ClGd74tus=;
 b=g01nWznsrJVYEIEH4lpmlMEJuK7WhyBPtEsyZY02XPp3ynVHOBMe1D2RXO6sAYqSJz
 VBQG+lhucZnDfRvnGC3DGcXBXlEz5vMc4H8YgJF7s0ezt+eM1Wexccp8mGQ6piI13XSa
 9D14ryBXeYS/RX0TYg59kWNI8QTuv6P4pGlYJYG/vp3EGesRDu0S69dbdnpZJ0ib8P5m
 RbvTkD7znNiRJCnIym4IrvG3J2XbfLj0XzYV5cItSlCN09OBnGOhV+8sC/70NuLyiAjI
 5rx4p+oIkc65eaiUQtsByvX7uv4Zk5EmChUuqaBT+iSv9KR2FwuZxAz1RfBw13O2ZbOX
 AMeA==
X-Gm-Message-State: AOJu0Yy47pNOHdPIo+FUEmqaEhrj8stqKzS2p2PMbGBRJ9VlO3H0WQWT
 VrSgS5dBg+KbeMQ6zmaWG63ciOP1rs1lQHoG/4vDPZqrDiudJDPHI7HirBz64OJ+eaNQT5UY5K9
 E0Jc7RZZQhToel1x/fPqLI4mgRAG4r0GCzk59BFH9MfMLabYOWqgm5Q==
X-Gm-Gg: AfdE7ck8ihICMhwg+gCu6ex4DFGQHhRbAfN2QaH02BX3bmJHYdTZgBbuA/4EqK6O+1a
 kM3KtW6m3Gb8oET7uJztsINmV12B3D9oRW3j2JLHa3oVYEIx31HzkxWu2qBercJZtMqVwv9Ufwq
 QHc4SuTBRNiv2/WKoRrfI8T4B1aVWEz+ahXvYaohCOKDK2ITAoxKQYPaOnhal8/YIbGuWU99FY5
 LE56wOqhX8gvcWv3LROK1q2zOtpl57O97mWbbiIbHRw2k+G8Y/zQtkq+IwhsmhosAnBvrAm6oGa
 Vo82NA==
X-Received: by 2002:aa7:c74a:0:b0:69c:20b8:f1e with SMTP id
 4fb4d7f45d1cf-69c24ea1ae7mr4144589a12.18.1783946518898; Mon, 13 Jul 2026
 05:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-6-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-6-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:41:47 -0600
X-Gm-Features: AUfX_mzXzRtJaGBhmzRybFDX2XYRFWCx9HBRwdWXTTl2KXSXaBGoB4QDiVeOgy8
Message-ID: <CAFLszTgHW7QCCi0g3CJk-FDVHKuyfJMPscQxDS0o6S+BiuHPKg@mail.gmail.com>
Subject: Re: [PATCH 5/6] k3-binman.dtsi: add empty distinguished_name_template
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> k3-binman.dtsi: add empty distinguished_name_template
>
> With the previous commit, "binman: x509_cert: allow and parse
> distinguished-name subnode", it is possible for downstream boards to
> put more appropriate values in the req_distinguished_name section in
> the certificate being generated than the hard-coded TI
> values. However, that requires adding a distinguished-name section to
> each and every ti-secure or ti-secure-rom binman node.
>
> In order to avoid lots of repetition and make it easier to just add
> the information in one place, add an empty template-dist-name template
> which we can inject in every such binman node. That makes no
> difference for existing boards, but makes it possible for downstream
> boards to simply do
>
>     &distinguished_name_template {
>         distinguished-name {
>             C = 'DK';
>             ...
>         };
>     };
>
> in their -u-boot.dtsi.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> arch/arm/dts/k3-binman.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
