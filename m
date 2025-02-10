Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D17C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8323D809A4;
	Mon, 10 Feb 2025 14:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T2oeijMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9EA80821; Mon, 10 Feb 2025 14:07:16 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683BF80A23
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f6d264221so21442435ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192833; x=1739797633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yH6ROVe64GZniKekXMI3bF6+mXM2bVt7aRCmFCG+O7A=;
 b=T2oeijMe6bUyoabo+7hVEQDBiBYKPZP5vB9AxtgwEaMOjUxszTC5hGMwctt19DJCHZ
 o111ubahsea9+hu2sGzDYnMpiT3UaQqADQkCt2jSOd8h0wKJwkk6lPQQrKHaQFnSygQx
 mXFOSH0gV5XUvQ+KjeV8XFd/+e5kOWZrBk7Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192833; x=1739797633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yH6ROVe64GZniKekXMI3bF6+mXM2bVt7aRCmFCG+O7A=;
 b=E7iE59ZpWRbfKta0A9+KeBxMWMnSS1I6uEQn8G+tKxfmhWnhjdp4cWKak9eEv/Wn9K
 MrqJJWG7KXlEw0YDEyxPZpZHGGIug16lTe1NqlyLkTKAx3tR9Z7oHnyVX5wyrC4sc088
 A4j9Zc4AnDT5Z6CGUqsnG7qWJ6WN/8NOJmYggs4XXDwbwRaPHNAwaUuCtmLMqB+6wgz5
 zIWiex62T4gTfjxoo6XW85eDN1mVjuyADErzEPdy3SD3LEJJc1nqfrFWrj0cMBzXcXYm
 gEWSaXYTq0npM3dPwqbQTqyM646LdDdmsoAMAc89L+ukjb7vckHWHAc47Jranwho02F/
 OKxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC1JhZirQdVV059VDtuttpqsa+eBLjPMHCB7hePP9RG6U7hbMeVYT63O/DWghI70PX3tUyWXE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4IBNxqZ/c9FXnRePhYWYkI+5xGWo348n8oXpwX3JxJTLqGj9B
 imwFnpApOErx/c3s091SNUsEPM+p+NfTgFcGHkTb3TLwdp4eRoeSsIEhcjp/gV0iksO4zAeyxhw
 FFl/pBWm/AkR6wE9illM1DqNb3o+om+E/muaj
X-Gm-Gg: ASbGncvUnr9SDllZeLU0qCHQYUOyzilDsA0Yd2oDjfC18fSeXfufdbcvG/hHLwa8w1m
 u8y94Ma8r18Zei9JoKLzaOunGGYtlbwy8FF7JJ3DZC0vWBhIVTgqUVoEQxDll3cWQ00dTeFYk3w
 ==
X-Google-Smtp-Source: AGHT+IF/jTlgUG2En6XYXfY69tjvmabGOGW+XeaZf8L20CYHLvbLvtb9Hs96yGe/ke8pmrdOKfbhx5OvSaYxajD5nKE=
X-Received: by 2002:a05:6a21:9013:b0:1ed:a6c6:7206 with SMTP id
 adf61e73a8af0-1ee03a09dc7mr24430738637.8.1739192832956; Mon, 10 Feb 2025
 05:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:06:51 -0700
X-Gm-Features: AWEUYZmf-pg1puJxVoZ4WJCYzEPUeGJiYTI6RpuuSGFBSgWpZjo8SNXwwqWX3EU
Message-ID: <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
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

Hi Yannic,

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> The top level Makefile calls binman with fake-ext-blobs.
> The test setup should reflect this to spot potential bugs before
> reaching users.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a553ca9e564..1f194f9ecae 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -372,7 +372,7 @@ class TestFunctional(unittest.TestCase):
>      def _DoTestFile(self, fname, debug=False, map=False, update_dtb=False,
>                      entry_args=None, images=None, use_real_dtb=False,
>                      use_expanded=False, verbosity=None, allow_missing=False,
> -                    allow_fake_blobs=False, extra_indirs=None, threads=None,
> +                    allow_fake_blobs=True, extra_indirs=None, threads=None,
>                      test_section_timeout=False, update_fdt_in_elf=None,
>                      force_missing_bintools='', ignore_missing=False, output_dir=None):
>          """Run binman with a given test file
>
> --
> 2.43.0
>

I would like this default to stay the same (False) because that is the
normal case for Binman. We should expand the test-coverage as needed.

Regards,
Simon
