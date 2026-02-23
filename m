Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3149CEC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7974683E8E;
	Mon, 23 Feb 2026 18:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eUzfkFpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53FCA83E8E; Mon, 23 Feb 2026 18:53:15 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAB28063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65808d08423so6796929a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869192; cv=none;
 d=google.com; s=arc-20240605;
 b=Fgd/OU2jvbmesIZ6AjUQYG/hTXIm9qnwSdXKAOfcQiWxd6NlgiL4uVH3LAof0DivZr
 QogB+3+YI1YIkoAUaKKBSol0FvQWR26vvwcGysFyMm2rcjLs8ZGwTb05x5WQWZi1lu2O
 WvNkl8NgggMi6YLew6wEMKazDqgKkr34e+PwTT/EfJuOwb3rNDz8RoJ3ToTk0wx1GgM5
 to33lX47QcnzLTK9boVp0DJNXlTKqmq3JkUIPVCHozlCLsQ8iq1hIY8d2ELZpFBWUdlZ
 jROe0fcmciK2QoSZNEVgVlbp9Pi2MyPVqVxNXymXRyXKeg5xwV75bUNziYp1Mknz5Rol
 uq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wnr9H9oA/AhZLJ84l3QkyPsDjystTvAyHr/trAMwClE=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=R1pYjg2qA4WITtg/KoXO/qM4phGpZA5yr5Fe8kLpJH2IlZxU30/XJNnR8Q9DTCjnwk
 /lKh7wBZmO46UZGLY1Q5FCFQSzc8AJ8Op/Mn6GuROy3zFVb/l7eQw64w9b7FICY+Fq0o
 X7hzRYacBEusNwsH89g8OUF7wQOhQGLgG08RAK04BZ8xAjMbMAQ4CFyc2QZpDQLQNlvo
 Q0H+NPJ7FHeN0aDJ7bSuE1vWOOwvUX2lAYOTogWHhYEsX6h2qMrFnqcE+nDyoeAai7WR
 OIwYNdetjAmqXuZHUwqoyU62d/JYXp6UjemGfa2cm8BaDZLllecYw1LE/unT01LCU7e1
 av0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869192; x=1772473992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wnr9H9oA/AhZLJ84l3QkyPsDjystTvAyHr/trAMwClE=;
 b=eUzfkFpZvddjqPf2lVvPlalBIDOuMY/v9XS9eE/0ReSvkeq2z5GUrcoTN6xoDMJpgL
 apf3l9rZo5fRiOr2PgFbC3jah50mJUNziLjooMqkjQIt30SAucptf9oAf39q7zMnPzl2
 rtYcnRImA4vndUFBB86UAC6qt56L9K69Exr+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869192; x=1772473992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wnr9H9oA/AhZLJ84l3QkyPsDjystTvAyHr/trAMwClE=;
 b=tW6chOwXvlEBrXRnVBiTj0YOL0pMB89Zi151MdbgctajULVqaZjyirifUkCTKPWm9K
 wHlM/E493IpoCe2UdBxrXo20Th9oCV+YdAu/EJqPY5cXiosbC+LuxRjxuWsxRH5YdPZ6
 J159s7ZXWUDd/yK8lUn2wWqx+iwwI96f9MoqzJPcjqgppSR5N73p+HQqCwNGU90m7x1X
 KLKTP5ATpd5fFcCvaCq2cZpcrIAsqkw6Nm0RU+ie4ayuS6Pt8nYTjtVZGEDyXrBx2LXz
 yyPdygbXj/UUVZfu5R31PIpBDniAusd8VR3faMrkzLhhXdF152T0DQiiMftaba6C57Rj
 tZyQ==
X-Gm-Message-State: AOJu0YzXy96T25pwmfMrZAmyJukZYEbXcJPSJGnwoxUVQpRDb5fd28m4
 sDraolVrrQpMc74B9t6AhL6CKsrilIX9ZVj2QYRr8l+WAptDnqtib8UPqTrHq1OC04uO9MmMjrk
 F2UI8GqhEL4tcOWKMDaSVL7uind9acWQf70tm/aJA
X-Gm-Gg: ATEYQzyoWYMbSXg3ffp/xcCq0C5LLQVSVvy2byAhD7kS36qyiXAZmWSZjW5GL/346AC
 OzxodGbn7h3Nj2Qo0s4JrALbEV9FTmG6AxfYEc6/tn3ZjcVWX3dXDN4ZxE67WfOZBMqaB/nTICJ
 Q7WNRR1IFtkG42+tcj0mNyxJIRa0zp4z4dD+n9F41TLxKdFuTYgfl3o6AVkJFsbj+SGIWQ5iDIY
 h1yT8NeCxz4S1Yw1qWB6YMdLIzLZ2a7w9iNHdJiqXmsdvafoA5Pt9UOfBVtVFhxX3WKb+xuvoca
 aS3r7A==
X-Received: by 2002:a05:6402:2811:b0:658:b3ed:64dc with SMTP id
 4fb4d7f45d1cf-65ea4f1925bmr5582332a12.15.1771869192579; Mon, 23 Feb 2026
 09:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
 <20260220091518.180641-6-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260220091518.180641-6-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:25 -0700
X-Gm-Features: AaiRm51jQXYbJLj5DfdbCfJ-cMhaNB2HyE93S96GxeBgEUD-O_JYqa7WDjWCgMw
Message-ID: <CAFLszTie-3Agov-=gRytUOrvrm7nJhKs93ABRZ6LzdfnhYQ=qQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] binman: DTS: Add dump-signature option for capsules
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 simon.glass@canonical.com, quentin.schulz@cherry.de
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

On Fri, 20 Feb 2026 at 02:16, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> Mkeficapsule can dump signature for signed capsules. It can
> be used in test to validate signature i.e. with openssl.
> Add an entry for device tree node.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/entries.rst          | 4 ++++
>  tools/binman/etype/efi_capsule.py | 9 ++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index a81fcbd3891f..91f855f6d7a3 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -552,6 +552,10 @@ Properties / Entry arguments:
>      - public-key-cert: Path to PEM formatted .crt public key certificate
>        file. Mandatory property for generating signed capsules.
>      - oem-flags - OEM flags to be passed through capsule header.
> +    - dump-signature: Optional boolean (default: false). Instruct
> +      mkeficapsule to write signature data to a separate file. The
> +      filename will be <capsule file>.p7. It might be used to verify
> +      capsule authentication with external tools.
>
>  Since this is a subclass of Entry_section, all properties of the parent
>  class also apply here. Except for the properties stated as mandatory, the
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index 3b30c12ea514..022d57ee5519 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -53,6 +53,10 @@ class Entry_efi_capsule(Entry_section):
>          - public-key-cert: Path to PEM formatted .crt public key certificate
>            file. Mandatory property for generating signed capsules.
>          - oem-flags - OEM flags to be passed through capsule header.
> +        - dump-signature: Optional boolean (default: false). Instruct
> +          mkeficapsule to write signature data to a separate file. The
> +          filename will be <capsule file>.p7. It might be used to verify
> +          capsule authentication with external tools.
>
>      Since this is a subclass of Entry_section, all properties of the parent
>      class also apply here. Except for the properties stated as mandatory, the
> @@ -101,6 +105,7 @@ class Entry_efi_capsule(Entry_section):
>          self.private_key = ''
>          self.public_key_cert = ''
>          self.auth = 0
> +        self.dump_signature = False
>
>      def ReadNode(self):
>          super().ReadNode()
> @@ -111,6 +116,7 @@ class Entry_efi_capsule(Entry_section):
>          self.hardware_instance = fdt_util.GetInt(self._node, 'hardware-instance')
>          self.monotonic_count = fdt_util.GetInt(self._node, 'monotonic-count')
>          self.oem_flags = fdt_util.GetInt(self._node, 'oem-flags')
> +        self.dump_signature = fdt_util.GetBool(self._node, 'dump-signature')
>
>          self.private_key = fdt_util.GetString(self._node, 'private-key')
>          self.public_key_cert = fdt_util.GetString(self._node, 'public-key-cert')
> @@ -150,7 +156,8 @@ class Entry_efi_capsule(Entry_section):
>                                                   public_key_cert,
>                                                   self.monotonic_count,
>                                                   self.fw_version,
> -                                                 self.oem_flags)
> +                                                 self.oem_flags,
> +                                                 self.dump_signature)
>          if ret is not None:
>              return tools.read_file(capsule_fname)
>          else:
> --
> 2.47.3
>
