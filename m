Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0351CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8048488A;
	Sun, 14 Jun 2026 18:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PE6i5fOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62D084894; Sun, 14 Jun 2026 18:18:53 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D518485F
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so4605399a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453931; cv=none;
 d=google.com; s=arc-20240605;
 b=Xq+13jDcDe2R/EKszrE5uVTdybeCilVju0LIBFiVV6BmQAixv7lv8+XP72kodVSODk
 xCipNLnoj/4imqoTJJKLYpajABDFl24iQbliXSYWeN1we+GVjpu62bEWAu3YEPzBjXrm
 msC95lG6MpF6JWpTAB0tI5uxmmKTZ5p0b1Jie/WcyTwx6HZSU2MR8zy9OO+VbGgW1MgY
 R8dcA0NwzcuOFaZH9ojGoAhYCQRAsJAyvu74Uf0xderElojjA4X4Rx1BGz4Nj3vvLezI
 PhUL3AY+W2gstwRf1GHqsyZgGJKf8fFWfEQBJWGIlebWw1y12eSEZ71ZC9ZH3q3vfkkH
 B0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zdKEz/4eND6nq4veIAAMiHTC/bJHzTz4lXAMT/5H630=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=JC54U3NdzUUMARZ7eltpRck+Kj1gScIBCMD6HTEYYenP7yyviKWKTImsBrQrfOUM7a
 v8z4pjbZg2pAEt1xp4JQp5IHHRfvHqSIPSi5tmYrF9+gl1/1YrI/uU+bXUAD5PUgrmTH
 dfer9z23gSUxe41HmwPsLY41j53B4B/9Mg4LiVR2ZbQ3xPuT/Ji3XNmiz6kyJ1YJknUh
 Wd9eBNhxErfEQKJUy8xu4zYKq+j0O6UYtxhH2+9e8D1iKk1FiWBrRIN5LV33y/mYMvfh
 92PNWA9yPv7sdqb1dRk+BLDul0D23KhawNDf6OwR44KKQGKZ07+SbkTU45YUlj3XJS1Y
 1bhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453931; x=1782058731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zdKEz/4eND6nq4veIAAMiHTC/bJHzTz4lXAMT/5H630=;
 b=PE6i5fOs/cc4g4tO1X3887IgF+/WGTkGwMpqCcoZ9heeGqzMkHoPooYsc7QXEuwlWt
 yCPJuHVBLTGxn8EFKCWvMSw5KxEQzRkHFM5NdmTkhbqsX3gdlDpvyzUikeCXKzWLT+oO
 58A0W44V21mEfA+RYbR9z9jYXuic8f7olGl1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453931; x=1782058731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdKEz/4eND6nq4veIAAMiHTC/bJHzTz4lXAMT/5H630=;
 b=SIa9YeJZ7ZXBaXryMU5QyUa2pw6d9q7WuKYYnwAdtZfqLaX4qf6JdAFyXZkgnJc2bA
 rJ2luyqSBPzkWR+x1dtXEIkL6mw+En0ZyHBmemrVaG1gfkUcItlxWQ1gcGiKV5R5CAMa
 XQp1bA6DXnuJeE/lsnlV3zKws6LBss3ir1V5KT39XcnNvqgOF6lzKT1geadKC/yqYKuV
 MnormpyCGFk4Z8eBYduuA0n8y8NRuNstdcz6CRv6Pp/WWqfDgvgWT5yyeK/HvXUAJu/c
 CejRNatwmN0iTBzq9mbdxymt3HIIsNTMsOChHOAgDEsTVyiyVIqakmZ/WW3GxsySRb6f
 elrg==
X-Gm-Message-State: AOJu0YzgVJcb0TcKBvvZi3Pf5+UgMUHKplCiBT+0jNDhdQWR+Vq+22bq
 5+DaghPHAiie+LWU89I9dvkI90zlJ02xsLHcex3M+2cwim2g6x2AwHEadHoemfrnp86kxMKJsgV
 +Ea5yb8Z+MYPsSj0V7YMijbyVceIWt0+b1wsX5h+3p0kxw78tb1Q=
X-Gm-Gg: Acq92OE8E6j6uulnPksCpwu+PDhUC9OWmkPVUVfguHio4Outgl5S3FcYfilNdMRKyL7
 kijnOAbZJjiNCG74l2UxFIdcRYIjzrX5LSTAAiWuEDnpcRajPO9WuwBMWZ+SOVb5hS35nHQRB+X
 e5UBGBcHwtcenAuPxnYOtw9OAi0AD6zOk7Cfj6nPpkOQBlj0Fzhest8pZlMas8kf87gFTLDw15w
 nBjiD0lc3TBXJ6RIGFMof5TLXszgFvIpyfPpknaxBgzIFDtk58I1keZRh6+2pzdwqiQ6My750r8
 NqqekcWrb8AM3Lao
X-Received: by 2002:a05:6402:274e:b0:691:b158:b416 with SMTP id
 4fb4d7f45d1cf-693c6a00073mr2962551a12.6.1781453931262; Sun, 14 Jun 2026
 09:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-3-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-3-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:18:39 -0600
X-Gm-Features: AVVi8CfVcDyFbcTDhkYZJJwj0sByswaQAVnoS24mcqoknFz94fjAVSi1vTf9T4c
Message-ID: <CAFLszTjufqo4PWS4T8KhPrO0BDjt1s2++mu-5mzzAbOvHfx_Kw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] binman: section: add AlignUp+PadToAlignment
 helpers
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
> binman: section: add AlignUp+PadToAlignment helpers
>
> In the following commits we will be introducing new etypes derived from
> Entry_section which need to align values and pad data. To avoid
> duplication we introduce the shared helpers here.
>
> tools/binman/etype/section.py | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
> @@ -1040,3 +1040,12 @@ class Entry_section(Entry):
> +    def AlignUp(self, value, align):
> +        """Return value aligned to given power of 2"""
> +        return (value + align - 1) & ~(align - 1)

We already have tools.align() in u_boot_pylib which does exactly this,
and it is used widely in binman - please drop AlignUp() and have the
qcdt/dtbh/android_boot callers use tools.align() directly.

> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
> @@ -1040,3 +1040,12 @@ class Entry_section(Entry):
> +
> +    def PadToAlignment(self, data, align):
> +        """Null-pads given data to given power of 2"""
> +        return data + b'\0' * (self.AlignUp(len(data), align) - len(data))

This is a one-liner over tools.align() + tools.get_bytes():

    data + tools.get_bytes(0, tools.align(len(data), align) - len(data))

I'd rather not add a method on Entry_section just for this - neither
helper uses self, and the new etypes are the only callers. If you do
want a shared helper, please put it in u_boot_pylib/tools.py as a
plain function (e.g. pad_align()) alongside align() and get_bytes(),
and use snake_case to match the convention there.

Also, stray double blank line between the two new methods.

Regards,
Simon
