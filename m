Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A9C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D38C84A6B;
	Mon, 13 Jul 2026 02:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XMyP+hb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C861484A0F; Mon, 13 Jul 2026 02:19:42 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A5984A0F
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso1975911a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901980; cv=none;
 d=google.com; s=arc-20260327;
 b=Vl+iFqJKF45jiMwIC9X+MPfYxZBCT7onDsWV7CVgxTU4w4ONXFJvkpluDKUMK3pdMe
 /eFe1OpatWslwPBg941Q3nk9VVHX8VM+fW2OrkirB5v+HYLDALkahTaCIWN0l8FwU+0+
 8r35QUYIOY9H+CKeR++uizUkTVv13bKt9lYOuQOe93n9VHLKLnc26ycgYGo8PhJG3Bem
 jfp4VY6MuEd/yT7PjRSdL+GihTMVsaqcRWxDMqMfgabcJlPZwSNEbboN0NgXL1UWdPXt
 NT5swsUPE2Bijog1vPPXSTxEiy/WZ4QRP3iCTuSlp01ld+gzMrKvA6JJGR9+pfPss+01
 OvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kd/AR0CQCH5JmURaAes/Q/GILeNYD5P8IQX378Zs+kw=;
 fh=RMotW0d5XlV4ufFtnrZdzQ0yk4gZppNtVCUWCpNgShU=;
 b=JxVEdaEpiymo0FgRERbv1KxsyOox+Ky0E5FDcpgcHWjI65T6ckkTDv9RDLrurMQVtO
 LdUaYFBPgQthMKgsJKBTHVZJ2EE1w0NvMcym75/c9Z6zKve3f83zujcMxafSlzV2jAAd
 Z6XPEfs4eIIXp+nw0XBf7ltEYR1gCL7xtHj7TqrNGF9BhZN3KmZuh0s1WDt7K14r3bhA
 YLOKfvHD5akxD4nl3yNwNeAJ2bqHFackyLHiIfJNC14m9bOo81VhaQ6nM+mkwzuDL/+E
 83cfYs+kA1JyME8wbXjceGnDGnfgzt+NwYCEB7O5GZdXAxsls/fjw3Ad9QMnCx83a+NM
 kO+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901980; x=1784506780; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kd/AR0CQCH5JmURaAes/Q/GILeNYD5P8IQX378Zs+kw=;
 b=XMyP+hb6JzZtJ792+Y8z8Ob6/kGhdiOwhuHB9ZgVB1wG6xh04nZsxBa9zHTpi6j1BK
 gewI0HdxrUayrhdObm1Gyup7t+n0ls0QFmsVsS7O9o3MWEgppDwNqbQ2896jvUx0vCmd
 Os/uS4ZyIIFBBL667uVn9lYHVxwot1e9KU3hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901980; x=1784506780;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Kd/AR0CQCH5JmURaAes/Q/GILeNYD5P8IQX378Zs+kw=;
 b=XuYK3Z4rhli20egbZ8FC8ViSQHvQCitPgMOmP9g8b/ggWtCq5UrveOJka4EejFm4e8
 aqIF0KtAVf0io4z5i2HSq1tx2JHnDtcUwcMSg36pOL3zRmHDBMJRVytjIdAvUMlwirUI
 8S3+9IM3B+hgjmOD+fsvgQ6QItQXWbmbFvoYRioig35qULS2zwFpt3gQiC/9z/1z575z
 dt6MmSdUXo6CmDuywoSavyStc0/I1HfsbXZJ6Ezlv4RC9OG9+bcV3ax2jBkCXWYmFDpm
 dWUyO6qJSdxkr63TAfNz9ztuo+rUzcE/MlcyUpiG3i3pttbo/2uczx3Lgx2AD0dFQuzQ
 dtLg==
X-Gm-Message-State: AOJu0YxZ70+Ji5PbXE6q67pQGbZfi0s7uP7UO751z6kaAXKK1T1Jfw9k
 MNXCQB+JLvy1gUFCQ+6Y4Qcv3h4NqQhuiNCXzgSmHC4FnJVri8NtlIoCW33RqL5Vj3WllC0m/Xp
 ytAVoqLUA+sdlt4woWF9hgKGfBH4Cbogolya1tWZP
X-Gm-Gg: AfdE7cm6r19I8Vq15mWmO5+A/SRG1EIGYHEEITb7AC5t0DgLU73vtvTElxNbYXHOv/6
 g93vb8p0mfa9ibBi6OlkIj/9JnSUqzq7m3AdduL+mdz5lRqoB5mox1fwaeJjj7UuHOYaFfINb5X
 VSigG0Y4Zcx82Pf12fuydYcKABuOq8Owes64UKFAnzC6kEIuXOrdhUad9aZIzc3+T49X1ASK+mX
 l01qDPDMbWD3qaYr8FlIdoOlfqmPNypm8u7wG1HrFryxPIAh3wRewgvUqOH1Z7luvuKBA4=
X-Received: by 2002:a05:6402:3584:b0:697:add3:a274 with SMTP id
 4fb4d7f45d1cf-69c5efbc522mr3112966a12.15.1783901980455; Sun, 12 Jul 2026
 17:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260708103452.49277-1-aristo.chen@canonical.com>
 <20260708103452.49277-3-aristo.chen@canonical.com>
In-Reply-To: <20260708103452.49277-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:19:24 -0600
X-Gm-Features: AUfX_mzKGy2FpDa8sISG7DF2_He4y05Vitx6GXXlNfhqS9rO8Oho5VlYU0i9TYU
Message-ID: <CAFLszTiaaWr43xNNNmMNDqP9eV+yYfMHTj_T+ZXweBPqD88NSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: spl: check load_simple_fit() rejects an
 oversized data-size
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-07-08T10:34:47, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: spl: check load_simple_fit() rejects an oversized data-size
>
> Add a regression test that builds a FIT with external data, inflates
> the data-size property far beyond the image and any plausible load
> region, and confirms that spl_load_simple_fit() returns -EFBIG instead
> of reading the declared size off the device. Without the bounds check
> in load_simple_fit() this test overruns memory and crashes; with it the
> load is rejected cleanly.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/image/spl_load.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
