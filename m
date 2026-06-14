Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B952CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2900E8485F;
	Sun, 14 Jun 2026 18:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nSdk1aOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFF883FEE; Sun, 14 Jun 2026 18:19:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CEA84869
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68c1630159bso2577700a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453964; cv=none;
 d=google.com; s=arc-20240605;
 b=Z/c7h5TH7IOauYAEZ6hkkfVG3mHtj3kjUPGwFwsv7WgHGgAFUejMNsJ5dipph6NaMx
 1vn6wL8K1aINdOyEdWB7LN60C4BttQjZTRtoxX2Iz+VQ/yw7uaUaGEUAj4vMIr1fapic
 FYQWWGRsExBGvwbDvuAm742GmKtqx8oEom0D6RVuqBaToBBERZYL8vKycqzcA25f+5FY
 Fm3UE9MKvTLj+3r03/j1M970af0iJh0ts08SNOoVfIUEO3RxlgHTIuEELYBGNbYgo1lw
 cCN72lr92GGKlLXP6CE9jNcnGeXtLYxPaZwLAk3X5F2RzSDIdpqET6SwNHZHi+VZeb+D
 PLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1XUhmzGKvZR5iHc9qFtwNVBpl9LA4CU8DH5LnEHIGX0=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=JVAy0Q+PvC7b7AFlr+Fg4sDycnL7pdq9or+o4eWq6kRjexCcZPKP+jLjqki1+EKI1c
 7lNhgjhTDuJikQbmBa9fKHfmUU+NHou2FVFxBdNwzFi8ZjYwA5wbDfSFUlnOmDXDBvhm
 4cQKXaFvITDVMFmARNYusCPpxnciWpgiQjCAbtEta1fFoJ6/kfupKD7ktaVG3NDOG+u1
 Hn/v5gCRnDFmztbpi8VLSS27oLgElLBbZ5a0EDTSstEfs7cTH0L8Sbqz7KiceZzHM+4K
 Y3VvtMFV61JP6i6dBaPeG9Ewf/0B+rYx2U/DN7qyF93BZt9c4zNyblOgyVocpbnqgDJo
 Kx8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453964; x=1782058764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1XUhmzGKvZR5iHc9qFtwNVBpl9LA4CU8DH5LnEHIGX0=;
 b=nSdk1aOpHtdVTswkNeiyqCXwaFAetVPAAI9kSqDTNeip2lsv6K5+fRi8ETScY1vVaj
 Uw9uw1XQ3Mm9ASPjs/nX6PsqXLzO2VGzKaR64gtkDfGMA0MXJv+fPErN5UFEe1xn1VHL
 d5XxERR6c1QhzMKwRiri0Y9bxIkj1TL8FpyVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453964; x=1782058764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XUhmzGKvZR5iHc9qFtwNVBpl9LA4CU8DH5LnEHIGX0=;
 b=foALPAYHC5JFhGcCbMpvLnsPiN8DWLZKoXBAHo3DtTHvFeieCAvmYY7aAh65jtP/dC
 431ukyqahvJOAKcpc4YaGKStIkQ7nLNhHVr66r5tYVQJSQs6AkvbAM3yKiHJlgvkzw0Q
 T6gmvmAPb3adHiCMYWpOKO3ac3SfcCYqR5ScFayELgyAp90P51a1yprF9XIxTf0Z6lHi
 gtC4YGKghCOI/+4c/2mZm0KrjOeRceIyvmCHQwIc0R34burygyPxBao7M5WiG6I8tGUP
 BYonGrVyJ6BIF41ICLosOL0oUb2o4f0cFAHR+n7aMTvDxa1F2yzqGLyn/vq30vDW4ykb
 YhYQ==
X-Gm-Message-State: AOJu0YyNCt7jxUWoXq9kAhfuamfNd4bQBC2bWuKPc1/HX3Iyz8I4IxhM
 g4iEBHZm4rCNkNOeBl896AiGMioijM2KKRuvyaEmHzzonfEFndSPocu7lirxL4QhdT48SiCnUY4
 bpWyOsQdDbSqFb7qojxzwmIGnPZaDEQfCC0rcCaV1
X-Gm-Gg: Acq92OFGTO92PwcWGvUdzl+RM8ds6QWySiwu7+8FL/bvl/TiWaSHwQxhSklt+EiO3nz
 Mi2tMLdNPtOZDIWQajL6ePDbqjbntkH7S9maQvXvVYlyTKYCVGhFNEmawNcsU3Jjf6VYEHWC0l4
 +bxx0PwV1pB28sd+3UZXJB0+RnMDz8YFMbXobac1M24P2aMkHyN38R9x9tKgEJDXCurlu1b3Dgc
 A6XotjcdDreMTOXj/Qu+99qop53+DLJJcoInok1A97i9UjwRmdYggxd5Bl5JQsBuzHolBMKbAug
 7zYeSyOnJBDk2Yq/
X-Received: by 2002:a05:6402:458b:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-69378a45d90mr4640740a12.19.1781453963801; Sun, 14 Jun 2026
 09:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-6-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-6-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:19:11 -0600
X-Gm-Features: AVVi8CfuKJJK-azX5-idSrLVQLJHFEHCDCBpZnGGTrSFH5ZXsOkenRuKLf6iKs0
Message-ID: <CAFLszTgfwGu9MS=YfaT469aUSzBMcVNK8y_oxL=_M4d-T9Yvnw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] binman: android_boot: vendor-dt support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

Hi Sam,

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: android_boot: vendor-dt support
>
> There's many Android bootloaders out there that expect non-standard
> abootimgs. Samsung and Qualcomm, and likely many others. This quirk has
> been codified in the widely used osm0sis fork/rewrite of mkbootimg.
>
> Presumably, these vendor-specific abootimgs were conceived before the v2
> format was widely available or specified. The evidence for this is their
> hijacking of the header_version field to specify the length of a payload
> that follows the main abootimg.
>
> At least QCDT and DTBH (both of which will be implemented as binman
> etypes in following commits) use this approach.
>
> Link: https://github.com/osm0sis/mkbootimg
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py           | 41 ++++++++++++++++++++++++++--
>  tools/binman/ftest.py                        | 15 ++++++++++
>  tools/binman/test/android_boot_vendor_dt.dts | 27 ++++++++++++++++++
>  3 files changed, 81 insertions(+), 2 deletions(-)

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -198,8 +217,14 @@ class Entry_android_boot(Entry_section):
>              return default
>          return entry.GetData(required)
>
> +    def _BuildVendorDt(self, required):
> +        if not self.vendor_dt_node:
> +            return b''
> +        return self._GetEntryData('vendor-dt', required)
> +
>      def _BuildV0SectionData(self, required):
>          kernel = self._GetEntryData('kernel', required)
> +        vendor_dt = self._BuildVendorDt(required)

Since _ReadVendorDtEntries already stores the section under
self._entries['vendor-dt'], this helper is just a thin wrapper. I
think you can drop _BuildVendorDt and write:

    vendor_dt = self._GetEntryData('vendor-dt', required, b'')

which mirrors how ramdisk is handled just below. What do you think?

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -211,8 +236,18 @@ class Entry_android_boot(Entry_section):
>                                   BOOT_ARGS_SIZE)
>
>          boot_id_payloads = [kernel, ramdisk, b'']
> +        if self.vendor_dt_node:
> +            boot_id_payloads.append(vendor_dt)
>          image_id = self._BootId(*boot_id_payloads)
>
> +        overloaded_header_version =  self.header_version
> +        if self.vendor_dt_node:
> +            # vendor DTs overload the header_version field to store the length
> +            # of the appended payload. Hopefully AOSP abootimg never progresses
> +            # to v8192-ish or we might have some real specificity problems on
> +            # our hands.
> +            overloaded_header_version = len(vendor_dt)

Stray double space after the '=' on the assignment. Worth noting in
the docstring that the vendor-dt subnode is itself a section, with a
small example showing how to compose this with the QCDT/DTBH etypes
added later.

Regards,
Simon
