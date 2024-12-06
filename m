Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA35E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DEE8972B;
	Fri,  6 Dec 2024 20:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lv55misl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542078971E; Fri,  6 Dec 2024 20:16:16 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326D088F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so3826292a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512573; x=1734117373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1eZS+eRqg1M1Sj52V9c0evUinMSqxgW/yb835eY6Nc=;
 b=Lv55mislyh3mpkAyfKHtgOq8winqRyqvyVDXT2RxDsp0vSSjzucvXL7Urep+SQRz/g
 PMyodQlXEU5p6LfTFBmdqoplHfG8rw+hAGN/4xSVXhYWsU4wKFdvW88pfMy26+Mie/j4
 9hoau8MAxWJ10+f2OULV7iNYCz9VH78rvAgPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512573; x=1734117373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1eZS+eRqg1M1Sj52V9c0evUinMSqxgW/yb835eY6Nc=;
 b=WSHUFQInsV1tiAUccq+qOhDhHAoFQNh7chSOyWcIFlPCiUmp3zqFriguZKyMZQ0SzY
 yZsFnhCetFC6S4oefcbIj3E/d8eK6H9ECZ1+jyroCqh6bpYHmNlKPm8oQsoyvUJgfDP+
 99kpACLqB6HVEariL2bxdzMp/dEzsAz01h2utX7MKMgSzJJA5ynPZz/DOBvLNpzvT3Kd
 ocmF+4iNKPUuIiqspwcSpwFZpIg6ew379tAjGaMFCfA0OnuFlY0yrbz3pqXtPt2F8U0U
 dBrmmdzTV/ss/Xae0k6pgTeuqDE/ZItOa3LyKIukeTAZrVSZAMwmw4KuWgm+jfH1Amnb
 gDsg==
X-Gm-Message-State: AOJu0YwhWDQdapRCAws/mTinXDEVsVBSu4aCqpcXNK3Dqps7kaLwxoCJ
 twFTict0/mDjL7xSaQiqC+h11JTMunIkSRDTNYyV0otxooZrulnk/7lrm9CNDxKoX8j+z9Ut6U0
 yMXinHyfPKFPwB1vjaQBi5E9IQIT53dUqFw+t
X-Gm-Gg: ASbGncv8cgLm5tMbDmOfRKQjTGT8IBM2E9dIwPgyCzc1bY4eP4Iiyb3IABnwLK/QuSK
 RZd+Fh3sIJWkALD17L0i6KGJWolUq1weuQjNP
X-Google-Smtp-Source: AGHT+IGvO3zYcsBjWi4SRkkumIqoLMsATIQqRxd0R//nlq8maQePWBsx3v0o8Ax+2dQLIS3wfEfGOyJBUR/QzqchGUc=
X-Received: by 2002:a17:906:1baa:b0:aa6:32c0:5d03 with SMTP id
 a640c23a62f3a-aa639fec9femr382767866b.17.1733512573643; Fri, 06 Dec 2024
 11:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
 <20241125181654.1182646-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125181654.1182646-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:01 -0700
Message-ID: <CAFLszTgsm6WzRNHzx3z99wu3P3abwgE4r0KLW4VwSc_TGP5Xdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: u_boot_pylib: Allow to append input
 directories to indir
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
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

On Mon, 25 Nov 2024 at 11:17, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> append_input_dirs() can be used to append a list of input directories to indir
> global list.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/u_boot_pylib/tools.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/u_boot_pylib/tools.py b/tools/u_boot_pylib/tools.py
> index 187725b501..0499a75526 100644
> --- a/tools/u_boot_pylib/tools.py
> +++ b/tools/u_boot_pylib/tools.py
> @@ -123,6 +123,22 @@ def set_input_dirs(dirname):
>      indir = dirname
>      tout.debug("Using input directories %s" % indir)
>
> +def append_input_dirs(dirname):
> +    """Append a list of input directories to the current list of input
> +    directories
> +
> +    Args:
> +        dirname: a list of paths to input directories to use for obtaining
> +                files needed by binman to place in the image.
> +    """
> +    global indir
> +
> +    for dir in dirname:
> +        if dirname not in indir:
> +            indir.append(dirname)
> +
> +    tout.debug("Updated input directories %s" % indir)
> +
>  def get_input_filename(fname, allow_missing=False):
>      """Return a filename for use as input.
>
> --
> 2.43.0
>
