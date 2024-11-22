Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED95D75E33
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F141D897F0;
	Fri, 22 Nov 2024 13:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KBmUUeKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96D2897F0; Fri, 22 Nov 2024 13:34:27 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F33C89339
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ea45dac86eso1700270a91.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732278864; x=1732883664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJZ3lmn35+t1yQySJbz61d6U14rb7y1yJlwjzLALoHo=;
 b=KBmUUeKn/hE3xHzJUdRDoHBbA300TFSlzPs5+7ktsR1h3EyYDkXWhelDe8uSnC6xFJ
 Y9yIAMnvAyUguG4GgcVjgmgnMjDjM2myHHbtg10zT1pCwJm9S2bewQNt7auJRJRL3rlR
 c3sQGW8N5CH7TiveHSTI8xhEFmLn9s6EjIrCStwSBOBbkCa33CCxYAACY0D/q8PDJ8Wj
 XrNuqWQQ7I1LTGaP2cLy9+YyCuXWEjY+z8cRsO4WID5QIVMDmZAFwo9k9SMStsSv2aSr
 eT9+9OzL3nv3w1txkJwI2yawhicZTCgM8c7pktTvg95ttooNknP8/AjfgsjJztTYg6IU
 BzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732278864; x=1732883664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJZ3lmn35+t1yQySJbz61d6U14rb7y1yJlwjzLALoHo=;
 b=QEA1af/+7u34Y1dSIinvL3+7mVkEfQDfd4KWBhfcV/iEFJdypp9fY9voUfiy5wQptl
 Sq6QZaf5LADBXo7GFD2B7ThIt8vr4ldfapFw/IOQ97rJGJ9s2GOgHeU0yDF/C2X7lyGa
 bd0jp1ZgBOme6DG4HBeNHZF7qPmV4DTu5sb1vYIzKQ3rJ5YSHxaM4r0OBd8Yhgky7z80
 Lj3zQqaTOF7wDY+DDMIGnYP3UazjKAHnzBjzaAkEYSUIzfw1qfOKVQ87cOXFIDzb1sGh
 fKDSPuFsO9aCSUMg+q076q4gFR+OSvG4fyf1qCRYaqD6ntg4lffyJWmeyNKToIwJkaJC
 QYrA==
X-Gm-Message-State: AOJu0YxVDlUqfhgbA66UeDO4XsiamjOZrdCcBe5Qo+zlsdPzBqn1rUsd
 DgdhfqHKNeag+HtHkVjTC/RTq2r4mfGLaqIomiBEPo1GRFspwFdyOod5VN3ZWIrOBVvFUuMj0D4
 c+L/qMtCnHVivaOkRMJnE9zSiVAdvo49rILK4NQ==
X-Gm-Gg: ASbGncswPQW3wnp8mckjyhGyGizJSzV3cskHE/qUcrcEHq+Ltgs2tdh2gFW4QBAboGE
 t+86IoG58Adm8jPSQZIKdVYvArcOZcg==
X-Google-Smtp-Source: AGHT+IG51rbMj0jQx6tZUGNHZKCTygzdyEJ/1eWaKizJ7TNCjeiF/E79MKbfb8z3UUxTl2l7YdrF+KAiky1EB4HENI4=
X-Received: by 2002:a17:90b:164f:b0:2e2:e2f1:aee with SMTP id
 98e67ed59e1d1-2eb0e5264camr2583849a91.22.1732278864001; Fri, 22 Nov 2024
 04:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-23-sjg@chromium.org>
In-Reply-To: <20241119131844.4078144-23-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Nov 2024 14:33:47 +0200
Message-ID: <CAC_iWjLNsy6tYL9tvWLc-iXWs94oWWRzeep2-kB-wxWoRnbyww@mail.gmail.com>
Subject: Re: [PATCH 22/39] net: Drop #ifdef in parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Tue, 19 Nov 2024 at 15:19, Simon Glass <sjg@chromium.org> wrote:
>
> Use IS_ENABLED() to avoid an extra build path.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/net.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/net.c b/cmd/net.c
> index f1b520143df..03b33aa1f20 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -366,13 +366,13 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
>                 }
>                 break;
>
> -#ifdef CONFIG_CMD_TFTPPUT
>         case 4:
> -               if (parse_addr_size(argv, addrp, sizep))
> -                       return 1;
> -               *fnamep = argv[3];
> -               break;
> -#endif
> +               if (IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
> +                       if (parse_addr_size(argv, addrp, sizep))
> +                               return 1;
> +                       *fnamep = argv[3];
> +                       break;
> +               }
>         default:
>                 return 1;
>         }
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
