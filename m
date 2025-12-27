Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89C6E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C0083C14;
	Sat, 27 Dec 2025 15:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T7X2/UeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04CD683C29; Sat, 27 Dec 2025 15:53:02 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDA883C14
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so5160410a12.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847179; x=1767451979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jEVj8iDmnEwNrMUwvL/Fgfeu0Hmc6JZWi5Pcw6F3uqk=;
 b=T7X2/UeOXDGv4KSJCGYAzXlkEP8l2BfQxTnNtwjFkVY9XRPea38e0ELYVDdNV4JyBd
 7iNToI9lkjI61m7x4ITBfXjHLEhve0EvwoZYzMEZQTv6lM+xJyT/icvbn/yMzFWSQiOQ
 cRwuN+z7NLtTHo0/7C1Q8fH/ax6fZTbA8U+d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847179; x=1767451979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEVj8iDmnEwNrMUwvL/Fgfeu0Hmc6JZWi5Pcw6F3uqk=;
 b=Iq5zmf+JZDX25rerw0IrspXKSAbf7ZGh1z04DBZ8DtEGoCQY/odLlaxwkiP67xQ1jz
 hJkcRcbpo378/L+IYcDiplgiRg9L56E6SdvN4+DM9KYmyC0nmODcgjVkVSj0+vd+mSnD
 9DvrOzW9/dBmucDskXNzBbRLq2EAyPWi0ngspc3pa99tE6MD5lLG4fkhI1K3rZ2PPutA
 WjBXKQjMfAEqjrwPt+GjlGBRmAe9X6+BKGxo6icA3vhuqCDLzAdaLUKtI62iChGva9H4
 jWplMDtsLbvMbqdx01L04NY9acmNNggABOqdlbuL6m+i0LshhsuFeQiAvmAOC3mo7FYk
 J12g==
X-Gm-Message-State: AOJu0Yz6m+UHjAJKFqIHCm00HodgOiZmVaqgqEc/3+b37YZlnIMvVHPv
 kgFne38vxeZCPf2Nfa/ac+YtIYNSBD7GqI1LF1flKlQQFdntUw878syUqhUSEajn2KmFdqmGCzh
 ts0bVRpRj7XPZAjPGUMXtBR5hev+E1pwKGQGlKh6b
X-Gm-Gg: AY/fxX5f66H1C8jZo3FLNm3ZETDFuzlsWW/bBlRooN/X2a0OmilUnJLDQUAvtwtKeRT
 wguRlOKFI3qMVwGHj3+dTHcTBfBHAhxL9gdFg+ghAbyMwYaddQpCjArBzPTfrVkas8n/fE09fuU
 vL908mFZt3Abd124JHopIO36JZbUTBhtVSN1p6IcnJOH4YIEBCJDfaBsyx111L8rM0V+TYOXQEL
 CfcrpmrjQf90ZOGv6zSxZVi6XajFKdh1+a5rv26TNJuWGQTlVAyrzaYUGvUiea8j/MCgg==
X-Google-Smtp-Source: AGHT+IFcNSWG4Nj3eHqo+C0hBxqnDfLPvy/q/42/EkJAUbYB9uuyhzLrN+L6Tvw0P1ra2J3Tz28iUn1lOOIJQKCZ9RQ=
X-Received: by 2002:a17:907:268c:b0:b79:e4db:2e9 with SMTP id
 a640c23a62f3a-b80371f8c2emr2727880366b.60.1766847178966; Sat, 27 Dec 2025
 06:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
 <20251216150841.331408-3-Wojciech.Dubowik@mt.com>
In-Reply-To: <20251216150841.331408-3-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:36 -0700
X-Gm-Features: AQt7F2rOmRf07lzOkUIxhis9vKNAB4GNnguZj-VUAQNuQtuGta8u8OOZfL-TjDI
Message-ID: <CAFLszTjfwkAdc9LHvq29Y=hFtZcoqJdh64LPrBP0AJcr0VMAgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] binman: Accept pkcs11 URI tokens for capsule updates
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, trini@konsulko.com
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

Hi Wojciech,

On Tue, 16 Dec 2025 at 08:09, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> With pkcs11 support in mkeficapsule we can now accept URI
> tokens and not only files.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/etype/efi_capsule.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index 9f06cc88e6e5..8ab022915d9d 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -125,9 +125,9 @@ class Entry_efi_capsule(Entry_section):
>          private_key = ''
>          public_key_cert = ''
>          if self.auth:
> -            if not os.path.isabs(self.private_key):
> +            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
>                  private_key =  tools.get_input_filename(self.private_key)
> -            if not os.path.isabs(self.public_key_cert):
> +            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
>                  public_key_cert = tools.get_input_filename(self.public_key_cert)
>          data, payload, uniq = self.collect_contents_to_file(
>              self._entries.values(), 'capsule_in')
> --
> 2.47.3
>

Does this have a test case?

Regards,
Simon
