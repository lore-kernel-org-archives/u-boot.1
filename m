Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D032810FCAF0
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690E383CE3;
	Thu,  2 Apr 2026 00:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FCq5g0gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5C684056; Thu,  2 Apr 2026 00:10:19 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6652580517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so27713766b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081417; cv=none;
 d=google.com; s=arc-20240605;
 b=B2qFR1lzV6vTftKzvkstb8G/JRoZF+IcwMdEJouiiEwYcygDPjglhBfPASjQqFx6kx
 0zYa6lUi4RuuAiGkV9RvkEtHAkxmqsTQuDZWZwbV2pCTGSUcW72RqBhro+C1LTy0yfhX
 KJEPujmSIGL1vmd92cK1psv94EwvNJGLV4ytD5RaVsm9aTVtCT87yRvMtSJoZzd5rmLr
 TMsfZ5/7loHjphyNwdgKRFn1wpn8OmmN5Su2vjucbueNQOWNq/DnxSnA1Bs4HygdJ+Nt
 UTGoHT0hIQOuQS3yL1wrmJoWjwB5X/43+/F6HRv2h9lep++RE/s97bdKDBZb/oaNFBLs
 r2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mGEq07OdlCfGPCWklrKzJjzhv+q8BHvvWmsJ+BNwges=;
 fh=LMBg4xvMlGLaeyJ99UwfkurzK8eeVHh5v9dt3H6v40c=;
 b=XUXUn+kAW81okgg0dnAyoj/U6u/Fn0GU78pA3dHdU8xaRn3DM/zVQ15Es8VpCZxa/P
 U00TAQn6adv5+pESn1hNmrj8bOv14SnFyobiTIIDcsJ1hYAUnVE4eKBPo1susgN9Kddt
 pM6OLxtVMyLcFgYyLMN2MewEyWW5XugDmkQAnHU1AuvwvBFK6XWPLBv4zZiQR1r61Bxa
 9+QGdM22k0x49OGqdqRBXYtp8sPSjWbknX0nm3z1X6nS+xMU8ttijX7QEigwLa+Gm/p1
 TRJJrL4ZzbaQEfy285myIpdzvXj9shk44aWsv2Pc1ZfVZTwfBOio8vnQrpuRjGqdsN1V
 Jsow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081417; x=1775686217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mGEq07OdlCfGPCWklrKzJjzhv+q8BHvvWmsJ+BNwges=;
 b=FCq5g0gcsOrXoZclpfi9M1wF4Z+8Q3+sFjYfzD4+yfWJgrHcbrYhRr9JYYicE2O3Q/
 Ua7JFd7XVtl/soHkbFUZpt6ix8F/zkvFpjrCj9QI3oUneJtIhJ8gH2xfURPmqZLXS4Vt
 kWr/0ulagd56PeJ0AYRVWN9PNbEG89ouGV6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081417; x=1775686217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGEq07OdlCfGPCWklrKzJjzhv+q8BHvvWmsJ+BNwges=;
 b=SGkgAQ6BwShB6N/uBJtzY3bch9M6r6fJO2VJzTa4qigvM9pwLoIowAjpAn1e8RjPK7
 /Anz2/feQuRqfAwWIFXVRIm9jkrUNG/8b+roCE9iW2THDzrDHzG+RVvL37IyxnKAnivV
 Y7VVpQwvn1nE2nVNhUVaVbgQ/6Kdg7SRF1ILWj7oTFe1Z3//ehXWK7HLxxBDvh8L++ly
 pb+J7MSiQmUqRr2SS5g9F9plMyiZ9MghEObhavSs52uuwGp57+Pz9bUdWvq1pBfDi7zO
 TOm1dY6BeDC7oo0t4dhtvEc3hy2hgjF5FZWUVkas5qiAQ0uiCykz8Kudsd3WxGk0+Kjc
 bMBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp3axHMqqp5h2T8Oej/4dEHMQbTXozs934PSzuUSrya6ZfhATZcwJUcEmoKluQNAmMN5BfJw8=@lists.denx.de
X-Gm-Message-State: AOJu0YwXFryw4HZCOJEG/QTHnAaV56hhqSEufym020V56QP3f8gg6uL/
 j+sai1Wg+UlS0BBbYc+mmgttWDK/zh8Q0FNVXtRF+S7st2MTn111Wk1JePTYlcLf5MZfzK9Kl5S
 HJcp2xcVbV5mWML3SFBOJeuB7Q51FhFQLlT1h2a+K+iD/Z9o1bdjgVg==
X-Gm-Gg: ATEYQzxS0GzABBhu51RgBNX30pu62NKKrsGKE8Z7O1dxkUuj+hrV5dnmXXPrORDtr6H
 ymbg9whUr+eA84bfp7M05nbNBLSnV8dJj5lpNSCXJ3p3He7W0NOAiiW6HDvsL+of+cxodVtWjhn
 ugAVCpy9kna09D1dgdmxqSfGCnmL19y8IDo04Qs/Qxh3eLyV8i/R3LelzNCxz1a5SjZxmEbzP3n
 rzY8rMJ9NJzxisPPZ2mtU+tLqLA25bLhYRqk/+QAk0Ar4zT9kE249UNodNAYL5zjsyiPAW9KJEa
 K6AQa0ef7e4tVp6P
X-Received: by 2002:a17:907:e112:b0:b97:1009:7536 with SMTP id
 a640c23a62f3a-b9c138cdde6mr278501366b.15.1775081416782; Wed, 01 Apr 2026
 15:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-8-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-8-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:09:47 -0400
X-Gm-Features: AQROBzC8wFf1ROtwx5ac722-FadysIVE_65uhDYag0qXt-rUy3HFU1qgeV7HnNo
Message-ID: <CAFLszTh5z5cMm+0BHds--QtYqya-FCKvtRP1UD+sqc4xsD4yfw@mail.gmail.com>
Subject: Re: [v3,07/15] test: py: vboot: prepare integration test for ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: py: vboot: prepare integration test for ecdsa
>
> The vboot tests only consider rsa algo for signature.
> To prepare the integration of ecdsa test, the signature
> algo is now explicit.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/py/tests/test_fit_ecdsa.py                    |  2 +-
>  test/py/tests/test_vboot.py                        | 99 +++++++++++-----------
>  ...1-pss.its => sign-configs-sha1-rsa2048-pss.its} |  0
>  ...figs-sha1.its => sign-configs-sha1-rsa2048.its} |  0
>  ...ts => sign-configs-sha256-rsa2048-pss-prod.its} |  0
>  ...pss.its => sign-configs-sha256-rsa2048-pss.its} |  0
>  ...-sha256.its => sign-configs-sha256-rsa2048.its} |  0
>  ...-sha384.its => sign-configs-sha384-rsa3072.its} |  0
>  ...a1-pss.its => sign-images-sha1-rsa2048-pss.its} |  0
>  ...mages-sha1.its => sign-images-sha1-rsa2048.its} |  0
>  ...-pss.its => sign-images-sha256-rsa2048-pss.its} |  0
>  ...s-sha256.its => sign-images-sha256-rsa2048.its} |  0
>  ...s-sha384.its => sign-images-sha384-rsa3072.its} |  0
>  13 files changed, 51 insertions(+), 50 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
