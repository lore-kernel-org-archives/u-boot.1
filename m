Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713BEC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CD99607D6;
	Wed,  5 Aug 2026 18:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hIaB_MnW7Wn; Wed,  5 Aug 2026 18:59:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEEBC60613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785956348;
	bh=fFfkXYs74z/t4RlnGXL0XxpicZApuPHhv07lLr2Hwig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SvXJpMT8R3hEOpKoUlKTTAUt9VhXq1vl2iPbEH1xygOiMdiBWA0mIk9L916DCWBvm
	 q/8IlUChSYACNrYBVuR34JeTTDbRjIXxKtUs9kAIEhw6SJxs1Lkj9vLhM6p8NOdX9q
	 0GOmPQL9eA/qzCNU57t9P/XmaynSjg1V7ikIXBZ1InFOb5wLvLjtpJuwtnVN30oUFn
	 Ys9IBjVNvqNX2Xy30dfzbvyvK98seVDkQXJk3koqdjnNdEK6TWfXr8hZhuaSCvVqT9
	 dz3gXPqVZKG98bC+N9XGuN7WPOVlOKuPjy/T7aM2ti9G4QuZFu5PU2HjxTxLOUqph2
	 LYJVvLoNsH6YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEEBC60613;
	Wed,  5 Aug 2026 18:59:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B44210E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D1E780E4B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kXxVaQZBFFR for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:59:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 33D3580E32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33D3580E32
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33D3580E32
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:06 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so2323788a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 11:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956344; cv=none;
 d=google.com; s=arc-20260327;
 b=OaD3DykWcKns2vh7cLa9A6WQ18vgytFq2tnS/WvEnJDlSjYB0o28q9Bm5WtTNnctFs
 BG/Ol8+v+kK878GLKGJcfDDOUCjbIhbRzhZRzc6z3pY0QmnZGzV06hyMKx9TO7Xcyp9y
 xr2vMLl/kApatAlQr7HRFZpltX+T/WWA7cvNhb4dA1cIPJ1YkV5IkkxJNojRL+y4L8Kf
 HpVrq7NBb+cIhkSIK2jqR480te7DIRpOvF8FcSJ2qOTh264KMCyLc81O4dsTQv3vvY2E
 7J/+XiX9mXCxJvUYw0RLp7CnMFnvvq8g8NNnDQXltSpu4APUqW7oyzlWaetYLJgCUJrW
 Yi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fFfkXYs74z/t4RlnGXL0XxpicZApuPHhv07lLr2Hwig=;
 fh=bSwY07iyaAvLtPSSmK9uzdP4S/d0Z2l4ZZHnjjrP/Xo=;
 b=mTK50OmhxJC54j8nnlT3Ks0ythzhFhgiY7M0TD2lGaoXFW9yDQkxYjBFJjxIqrnNU6
 uheijbWXRy8KTYUqwtYBhzmDihaY27B9Z74paeaFRPsMw5+zQnRFrgX7RyZutbZ8mJ0A
 nKHoD3l+vfnlS/nobJ88J6eDtXmD4crkPwcLY8+3zjsvtyjVfpvENRNHEjCJ3rThvycJ
 Of1p5a9lMgI0Ij2wDc4yws/vQiltPdGKFV0pxhMIbqDQ5aBBvAlYMH6nIUAEDr0+hm4t
 G7+QeDUWZ+D/OhBkhpBDTBn1e3zSFisYTE9NTNLbLPiY8uDM//bj9zdTkzcn3+YwoxEh
 eKNw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956344; x=1786561144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fFfkXYs74z/t4RlnGXL0XxpicZApuPHhv07lLr2Hwig=;
 b=RywsqBb6Rv5PDh0XhXpRFlbRpfRVsHq5DJWFD5k0tk6Al51cOxjNyIao6ZuDLEufZQ
 z/OP7JBju6FB9roVGx0wmcYr8ccaSVvalicgwbDuyd0mPweknFo72vl8Rc2GdKClm1UY
 RnifakiGxKEpmGnr7vwp2pjbZt/ke2HQP4XVYR1GaTmpaGiV4EMiA9tJY49H6DnTmDy0
 EQ9r9LWuAQkp+5kfviTFK7eRlj7POciOBgSqL2cTMXH/T4axZ0dZteYO1tHBlZlEZ/5K
 0g6Eyey4O9gBmpc1m9ykYTlyY4lcJ/YfvegjHXMA53ZC34dyIWIUQWePn/GyPESCPjIR
 NchQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonfWtoyos/yY1D46dkcDocS28IV1ftz26SwdX+1Fs8F/BejPOjT9Gv+aalTfwDKf77T8kCwP0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw8mk0teBe+HI4JFGnVD6fxloKKCxANLmSXeKtAEp4bM/yW47vP
 bQOhSyjpGWRnM7w7hKavbynZfJbpXu+ZUcDll+85jdchSQdJ12PYjSu0CEDgYm0m8YMXhTY8HvF
 H/zE1eF0GNzwaXwqfn1SVRiVIV6J1YN0B2WHC9ejn
X-Gm-Gg: AR+sD10ygwKIeUtQrwyRU6XL/Cb7osYP3v0yejF9X9Q6Bt0iyrNHs9bl0qsV1Zz/aDj
 m2Ko/wYEMqSFyBaioYAvLBt8ud5JPnxx259AYsZoNWfJ0CfeAjtIlBLKYcUvB+H6NTHmTHgxQ32
 XS+JXjLgCFfWG7Xm0kZLYcSg4kcLg4aIvg8TuyhUKiTVZUuGpJ6QYI8mM/FVOvvtU39saG3PU+b
 z5IS/WyqMf8LA1URYBU9nJjua5gnMT2Nltl/89/aMCU44erqVa3D02GaY/50GWzuJ1iuBTfL1BE
 U1EzbXQV6Gi77x931xad8ReCiRWPFdviubE2nAKF3tLUExRbFfN6Og==
X-Received: by 2002:a05:6402:528a:b0:68d:92cf:52f4 with SMTP id
 4fb4d7f45d1cf-6a14f09bc15mr5459873a12.5.1785956344071; Wed, 05 Aug 2026
 11:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-5-sergio.prado@e-labworks.com>
In-Reply-To: <20260728113535.128601-5-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 12:58:46 -0600
X-Gm-Features: AUfX_mzQSdBV4x-ckW9lINeUmMKp9UuGTTw0VaYaSoOCY6dG_Owa7CgM-UJ1Qg4
Message-ID: <CAFLszTgUY7XrZL8h1snfOViY7wUVduWe6DAnWmowsvpFWYu7iw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] binman: x509_cert: support PKCS11_PIN environment
 variable
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de, 
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785956344; x=1786561144;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fFfkXYs74z/t4RlnGXL0XxpicZApuPHhv07lLr2Hwig=;
 b=Oo1gYo9ZBKa+XEpDvf5ORq3iNXA8XXwLYyWjiS8yRe8SB1ZkpENZzVkULPpTurgfSH
 uOFbcHcqKEq1REEQenOt+FWa6HWR8UUVp83k5KKznVNezp9MeVCnc+x2hBxlBRkse09+
 /PwiqXKUPBgqvd2s5KtWpSWJJdr9k66+dziI4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Oo1gYo9Z
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-28T11:35:30, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: support PKCS11_PIN environment variable
>
> Signing an x509 certificate entry with a key held in an HSM needs the
> token PIN. It can be put in openssl.cnf via pkcs11-module-token-pin, or
> in the PKCS#11 URI itself as a pin-value attribute, but both mean writing
> the PIN into a file which is part of the build. That is not
> user-friendly in CI, where the PIN typically arrives as a secret in the
> environment.
>
> Read the PIN from the PKCS11_PIN environment variable and append it to
> the URI as a percent-encoded pin-value attribute, as described by RFC
> 7512. The rewritten URI, not the original, is what reaches
> 'openssl -key'.
>
> PKCS11_PIN is a fallback. A URI which already has a pin-value or a
> pin-source attribute is passed through untouched, since the PIN named by
> the URI is the one OpenSSL uses; appending a second pin-value would
> silently override it, as the last occurrence wins.
>
> Note that PKCS11_PIN keeps the PIN out of the build files but not off the
> openssl command line, where it is visible via 'ps' and may be recorded in
> build logs. Configuring the PIN in openssl.cnf remains the option which
> avoids that, and this is documented alongside the variable.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> tools/binman/binman.rst         |  11 +++++
>  tools/binman/etype/x509_cert.py |  31 ++++++++++++
>  tools/binman/ftest.py           | 105 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
