Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89E0CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40708397B;
	Mon,  3 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KXxHWM/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D55C838E5; Mon,  3 Nov 2025 12:07:14 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FB6836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63d0692136bso4627950d50.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762168031; x=1762772831; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5dQMVbyI+RWakujQN2d+LqqMIEP7n4FbkazA7cJkZg=;
 b=KXxHWM/GqBLzf6klBF0OBQPOEcspUT9KG83bWsA1iyjzyi8ZyRKYJDFr/WalDvQQ/j
 mpqjI9Fh2Vp8UCYiC+YSvoWs1NEuG2jqfa8W0x+a8/Gq7G5HLPA7rs8YSjuwn1Xeh/9h
 tt5U1i0fioYZVJEWnyOejLZJDo7bWMHFK9TAjtZDQsXzlq0PwEbgM9qi+Fojx3gEdqhm
 F/5Xh1BVLQXqklQ/6YBIRXAA65UoIkT37eI22z+j19JYLAPfzMNRgQBrNCQA4GoE80Pp
 N0jyN9Lxq67PL31pLfQh/iW9zof4sIS/uwNoUVT7pMlAVEAjPqToU8QJtwLsarG0tyjn
 dB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762168031; x=1762772831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5dQMVbyI+RWakujQN2d+LqqMIEP7n4FbkazA7cJkZg=;
 b=PXz9vGxrR+o5qctLrHI6XWDMPfb/RM/i3SFA2SRbckDn9VZY+melrwP1viZ4Ufdy6F
 1u/4eTnWpZqY8y1oBYcwVCZtKAZgObtuWRfre3WW/k8SqbbNlp1uedQ3YNQqVak1FScS
 Gp3vQ81EtwdkCe6vmJSuoTGhV4dtBb2MLHyEsirkToHy6TemADinGqj2qfw9UQEGzmAD
 mDOvvBpS1Q0CxKTIrXVXg41zzYOBJO3hcQ+m0TDZuO96lf0mEML1v7T/r5RPMLlK8y21
 qzyeHmL9woH4FZkDHNf/Ys/Y5YZHZXEvMbqPVjk+Bwe3j4SFXu16nWZVn/uAmCFMb6Fs
 pReg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhnoZU8NSCeEG9lpTm6Ahlw0lhfrhOt+y5aq/wv+kQeTfal7gexgXwNNmezOB4BpUnTZBb6/k=@lists.denx.de
X-Gm-Message-State: AOJu0YyzJ2+m4PGjHr3vmXul9ABMWNmJ8bFqUY+vVaq7xuxAZqO5eymU
 Uc38gjDy2yMD5KsrPT8WVtg2EH+bg0jccMhRt11vApR3S15Zs5XI767W/i5PwsaJE0AKGj4yZPg
 m+kQ5jD4G5MjKw7xOHaVxCpjqBfsEpII=
X-Gm-Gg: ASbGncuAUOlzR1x+XX+F7DrTzJxioBG7acbTPp8osaOwTZOSVdlOW1o0Rp0QQRGlkPj
 ILeeTl5n2b1EzQhQQOwRw/pgpMCD1rbXhk/T93/H3Pzf83kr1jvg5F6DDAvBCAS0u+d1DsdbBiN
 iDGHeKUefaT0azXcc+wzxqcH+rjX0fT+uVC3nBcSBXAdg+lttgAu/5vKpORfCjBvoVVFFTl5jAn
 95CjAbohmnE/ijma2wa719ZzJFVZp7q1s2bqU6vYalpaWlX7CZuvXjTjt8DApMwTYz6DeQUeQ==
X-Google-Smtp-Source: AGHT+IHGjtbjx9BkkbbrD4i1+sS82ZYoYs/xoLHdSScj1Yk4UEPysv7HEeoNmXYm44UMEH16zwXSqffdxJMVtiTCHHE=
X-Received: by 2002:a05:690e:d8c:b0:63f:9b81:bef1 with SMTP id
 956f58d0204a3-63f9b81c09amr7816607d50.48.1762168030683; Mon, 03 Nov 2025
 03:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-2-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 3 Nov 2025 19:06:59 +0800
X-Gm-Features: AWmQ_bnRGqolEfqhxabwRQLoMWx5A41U8sq7pM5nHNQQu5vAwJt0dDZWgsAHoeA
Message-ID: <CAEUhbmVds3hMzeLpheB5tNStzeJgsD6ExBsvq2P-UfLgcwkFcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] qfw/acpi: do not zero out XSDT address
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sat, Nov 1, 2025 at 3:59=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On RISC-V QEMU provides an XSDT table. The RSDP table points to it.
> We must not zero out this pointer because otherwise no ACPI table can be
> found.
>
> Fixes: 15ca25e31ed5 ("x86: emulation: Support BLOBLIST_TABLES properly")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/misc/qfw_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
>

Yeah, QEMU for x86 machines does not generate XSDT tables but only RSDT.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
