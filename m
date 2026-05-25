Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63674CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7DE848BB;
	Mon, 25 May 2026 17:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmgGOxjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 056BC848C5; Mon, 25 May 2026 17:25:29 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F0784859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1418830866b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722726; cv=none;
 d=google.com; s=arc-20240605;
 b=JKBoG0TvfRqd2Y6bqRnHeFTkVe0ug1HzaIuP27RsrZ+Ny/l9k263JawlKIRBMsBjO+
 h6v+kiI1Hcka2n9Ips+m8jqaiW1bVdiZ3/Z140oXZZetgf4UmQw1LGHSF7HM6e+HtTx+
 bQdEO5dC9J7nfsvYKP/hWY8/rptt6ZhHBRPsGFXr0XGLqLV/L82376HEdhXf1go5XXRJ
 6PpIGStoTgHsIgQumIguZp3j3ou6mmt7VPOa/ZIchJ5jPUhHdtQdRa1dxk1x+6QDWpYE
 Nj7Yim+4FnkY1XO6/2LpOLgJQZRSHy15yE+4GbrkhYotxKFBRRUjJYflQkBaOgTRQyzX
 lH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UqrI+RQsxv5Y+p11okJKxpz1M40MZ2TpzjdOCzJwY+A=;
 fh=rLQMN6a/UX9jMmUsQuTe1A8wK9bTo6tPxTHfkaExRTU=;
 b=P/oLzN0aVLlNrA9rSKh76qHuex7k0YrI24uESi8Ba0iZ6+EgMczXdxK5Nx7oIIHVQ4
 1Mval+m2McDvGxXulng0R2r4R+0FZrzlT5AvEg7YcK0yuiJd2f7hFwAmKtVXaFVZUSax
 3loGxbgbo17rVL3QIhSMYvbjPDlTIdRVYvSQ9HYoMhEPs7QthE0zXWx66tcjwSwJz34E
 klzdyxgvrC435Hug6d4gGehOIYJ/DwIQ7NeYDvT8mM612L/kEYs7k4dewBZ0mxNJKBTE
 n4tAJQnXMH17vL/ajNDmUjBUMVwRdtOtawVmnLvbfoZap/AqtB1jcefiKe//wHXygD0j
 wM8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722726; x=1780327526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UqrI+RQsxv5Y+p11okJKxpz1M40MZ2TpzjdOCzJwY+A=;
 b=cmgGOxjI/NDrDtEaUuYHsi13+wYBbEr1YQjsJXS4TpPTdE1rF08c55HgdsGX2KN+pJ
 rGb/ZK74i53BpILyrb6hfdKGOPmnvCaGdMSbiWt3Oyp0U2C45l/AjDK7NI8qJRVCpV3B
 5JflYDwcL6kYhBf0sE+bTKuHdHIMiq6RhJZlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722726; x=1780327526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqrI+RQsxv5Y+p11okJKxpz1M40MZ2TpzjdOCzJwY+A=;
 b=njmCGCk1gPsgF5TCt4cGtE6oAX05F+WIbosWzGlybkJctI2uNXNiBSs2/R+t/uBYob
 4pkghY/tx83wrTFuJlpGuHJk0LIBwnuv63tZIJmvj9TwdNhOfVpsJbRAsRdhXWUz4Coe
 fq4bQsIi25G7mP0WtFYDagXJcQLNQ5WT2wHFJInfxz1/J/YSoibv8sIQnAB3PJYolzz1
 /fenAS1XXuPyvCyjxcuwe5J7C+HOeYKdfnx4mCKwixxPc8BtLyRYXfCQtB+B9xGlmISg
 e/kwhEM4BTu1/g9okGtkp2fyEEtCvrzSubZXeKmR1+tPvBVe+z7lkN0whaa6W5PWJ55U
 CFIw==
X-Gm-Message-State: AOJu0YyUjPKFf+qfqi6tpWKP5KuKR55/vCs/Mu0eHpeu7JaRUjIVETO0
 qXll7JkLRBzpJBNMLbGvicGj/2h/+Xd8pNh+j5INX2/dLwqsAjuBp0dC0eartzSoGYBNz6U3ZMU
 F2z3C0smeRRCLmPBr8Y52QwG3bNxah7oOQu0zDMfcf3JwyDt9cBg=
X-Gm-Gg: Acq92OGoGRTjD830525Uyt3K+bFnD5Wlo4MlUrXD87vKka1G+fAF8CSUfxNW8qhMYnX
 CheH5j01qBY9HPCOLcsKvtIf9rgxOOU5RRwCklAivpPE8RcflUAFd0YNpPzUx5PTMIc8dxGY8Io
 5ATBs2CaAaWzfMWELII6gr27JOoVh0Mh8I48AecLjeLcmB++TEfakXKVnuBhUFzR4YwO8q2JbEU
 xG+ZB3VdiQb5kZFhM2XXm2A0eQlPZG7yjg/2OBQU/ZdXUxb+Qpu3hG3T3hsjskUUinHAuVFbMn2
 2c33aw==
X-Received: by 2002:a17:907:a68a:b0:bd3:413d:c51a with SMTP id
 a640c23a62f3a-bdd236fb18cmr854572066b.17.1779722726083; Mon, 25 May 2026
 08:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260522012312.860026-1-dmukhin@ford.com>
In-Reply-To: <20260522012312.860026-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:25:13 -0600
X-Gm-Features: AVHnY4KDmFX7xXJJ5WBvaY9DgzKGo8lESbT2FaqGn9wKAhgQx_NAQM_eJsR66Vg
Message-ID: <CAFLszTiwegtmhcSzy8xg5KKc1JcjeoYwsav_Tb7+9o9Hy+aY9A@mail.gmail.com>
Subject: Re: [v1,0/4] reset: add board reset type
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de
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

Hi Denis,

On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:

> Patch 1 allows per-board default reset override.
> Patch 2 adds reset -c support to explicitly trigger cold reset.
> Patch 3 adds reset type printout on the console.
> Patch 4 introduces a small fixup for the x86 reset driver.

Since you are adding new behaviour, I would expect a sandbox test to
go with it. The sysreset sandbox driver should make this
straightforward - what do you think?

Also, prefer board_sysreset_default() only as a last resort - could
this be a DT property on the sysreset device, or a uclass-platdata
field, or a syscon driver, so it doesn't need a board hook, or even in
extremis an event? Weak functions are awkward to discover and don't
compose well.

Regards,
Simon
