Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E204CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 10:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696E183FF5;
	Mon, 25 May 2026 12:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="GtchAFkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DF08404D; Mon, 25 May 2026 12:02:48 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD7683EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 12:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-304545f5206so3706027eec.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779703365; cv=none;
 d=google.com; s=arc-20240605;
 b=WXxnPVb6jvatlLVGIWT/y3ne8YBmeOfdSwARnKte1f8YfmmTIc9iI/G2wLXok/K2V2
 PZGpTasEWRFxtgKRS+xSBtKrj8OGnhus5+/9Bf6+UKt+F7vhM9FIyWvGz+zG2gvDb4ZY
 FjuSCIg2waaw2xFc2/niWGb7chGjijU4WlGMxqFfDxZ4eV9iQMsDeCPl1K7TeOKrqydO
 snXz50Qw9+zz0qTNSeAWzRZHdVfF1tGMmhd3wpRAL55cUDC4ilSmqwVL1LuO63gboMgy
 OJbxL7nzFNwo/LymnQmqhlGesaGYtOblICq2rOMZL8SfdIj4x67hwNM3oMrikAf7idb/
 iYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T4ezdnBvEi0XY7LMIyOsGgdcYnC9cG4X6UINiJpmLu8=;
 fh=Clcr5shMxu0DXwHz9Up5uSrOFHc+ci/jwuRw35EL6Vw=;
 b=Lb5hHZPXtcQo3qs7z0hJ4Mit/DNM9cNVnjcSyDeDV2ljSwkcWmU1DS2sdVDD2SV7JH
 +1IyJC5dKxCiSEFd10BzebuYY8/a02vKcGauee7HFKTL0vplWn9/QpClB0b1Lq29R+Kt
 vndK/Tn8hpRV7LcPxSfiGjro+cGslqCQ7IjOg1LuI8OzCnUjhnF6uhuR22EJ9e5SWzum
 xe0Bff88gZQ0LXxmELaTmC2FIAQiljt021xHx58MINnkvnBKW+iFBNth7PPYD6HdKHEl
 FcX3h4lkcyrE99YKlWDKT4GS3r/5dG5iuxgkz19c2qGwUhM13nTVGGBvgE8/qZsDQUU/
 U9FA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1779703365; x=1780308165;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T4ezdnBvEi0XY7LMIyOsGgdcYnC9cG4X6UINiJpmLu8=;
 b=GtchAFkdeAAcYAHJF8x4/TjGj3qPTxbFW4Ry2E7uteF7iqHfedQrBtfnyd6/wCu2ID
 ctDX9ZtViMWDDWCFBKtvvTKN9nk3GoEZE4vnaNPqeCOFkIdL6h6FaUKaWnM1BMqFaLGc
 RXNFN+X9rB5icDqQkD+y8J/Y4Rshkk5a4BpZFt1RRiR8tz0gOVQlqi13hbvj++4ehkKZ
 ifjnX/j02B7vZ/lXVV8BFmWM+19HPu5RN3wULGn2jvL7Uc1hDjVx9h/Wp72+ctVtbFfK
 oLSALUIDozNgvCye8EWGQ2O5ay3WXGD6xCo/Cq6d8AJMLrWRLOcGsXRPKA2ZIupfyAGo
 CtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703365; x=1780308165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4ezdnBvEi0XY7LMIyOsGgdcYnC9cG4X6UINiJpmLu8=;
 b=lKStxtmHxQG1hOE/kXrieUb7XDMUjr9p52sdkiKWmIfxrEhL4ZyfU7gRKHq07EPX1U
 faAE0Xub0Fbb5Wckrr8gsVJYgQ/hbEESYTZDLPmMHsQtwVCz6Fo/Ibwtf4Mx19tv4yAR
 T9LmaQlxNCBYMH77l7vXksbI1k0HebIrOBoR9oLmLdHzDgXOO5Rf8UFaorV88V+A83IM
 qbNugzn/j9j17Owl890T2SfOejsu7eVIIJALw6QvIsq7yDNxjUr+edMUXINFDIBTXbn8
 FOAUnv4FsoohVKzu13X384y7+buavGClofZkaQoP5HF1MlK1MDEpdZ7q/oceLyMlV2FG
 f6oA==
X-Gm-Message-State: AOJu0Yx2VwC4bghe2Bq1myYoHzMgjValh4w4b/KD1caWCLcz3H/0r0rL
 X1kV3oDlfh/mYy7CQ8X7mrhBrQlT5zbL6blEAMpCyRccgP10iCSnqsSw35QCU/AIBP+RD1dUC6Y
 ZVyUkg95E9GGR+QNjr0LH2G0zpbdLbK5Ph70fDZhw2Q==
X-Gm-Gg: Acq92OHvju94oSAUZL7sRHa/ZAlDm7ew5R/n1m6s7sMgJ2M6ROumFrnQ3crlIipmQmy
 RI1IXsyLtb7cTgXMLbp992RkdV8NKoTGZ7VoX3X/BOz6dtavmafK7s4+TYT6+mnHTcBzNXkZzoM
 8YZnelCPYZ1RLxoU/MTbPM6WX6pvnAbheQb9KJEc7W8VaqGkUQFUtmftf53P7qkDMtZpcOIqltd
 vk6KQOULCJNFkg+k7MbAIbZn1ewyo7LDfkAj+g2b4K6/EB6bLQdfTfrE27ZEgPjPVVslLpPQlE3
 4h0pTCkE3Bu/BOd12Qt00j21roKi9rkrSiGHFON+NhhtFgiljQE=
X-Received: by 2002:a05:7301:169a:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-30449102827mr5528538eec.21.1779703364721; Mon, 25 May 2026
 03:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
 <CAFLszTjXNhFU7pPQhi-uoZ2z2Bi3qxB7iuF59x+aEJ2=68zK+Q@mail.gmail.com>
In-Reply-To: <CAFLszTjXNhFU7pPQhi-uoZ2z2Bi3qxB7iuF59x+aEJ2=68zK+Q@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Mon, 25 May 2026 07:02:28 -0300
X-Gm-Features: AVHnY4KBG5Aw5icpDb9un6z5Po6lUpeQpbGQURxihLCBycTpjHuplhQwl4jyobo
Message-ID: <CANu7NGtJe_iwbf-cc3CyOXFW5ZFbeMf9m=NxNdvL4EZyksAU2g@mail.gmail.com>
Subject: Re: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de, 
 Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

> > +        # Find the OpenSSL pkcs11 provider module via the modules dir
> > +        # reported by 'openssl version -m'. This handles multiarch
paths
> > +        # like /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu,
> > +        # which OPENSSLDIR does not point at.
> > +        m = re.search(r'MODULESDIR: '([^']+)"',
> > +                      tools.run('openssl', 'version', '-m'))
>
> You construct the bintool instances above (openssl, softhsm2_util,
> pkcs11_tool, p11_kit) but then call tools.run() directly. Commit
> 08bcf962c5f routed the existing eight call sites through
> <bintool>.run_cmd(), at Quentin's suggestion. Can you do the same
> here? - p11_kit.run_cmd('print-config'), openssl.run_cmd('version',
> '-m'), and the softhsm2_util.run_cmd()/pkcs11_tool.run_cmd() calls
> below.

Right. Will do this for the calls that remain.

> > +        Uses '&' as separator if the URI already contains '?', else
'?'.
> > +        Returns the URI unchanged when pin is None or empty.
> > +        """
> > +        if not pin:
> > +            return uri
> > +        sep = '&' if '?' in uri else '?'
> > +        return f'{uri}{sep}pin-value={pin}'
>
> The PIN is concatenated raw, but RFC 7512 says the query component is
> percent-encoded.Wouldn't it be better to use urllib.parse.quote() on
> the PIN before appending? You could add a simple test for that.

Good catch. Will use urllib.parse.quote() and add a unit test with a PIN
containing reserved characters.

> > +        - cert-ca: Common Name (CN) embedded in the certificate. Used
when
> > +            generating a generic x509 certificate.
> > +        - cert-revision-int: Integer certificate revision number. Used
when
> > +            generating a generic x509 certificate. Defaults to 0.
> > +        - sw-rev: Software revision number embedded in the certificate
by
> > +            the sysfw/rom variants used by the TI K3 secure boot
subclasses.
> > +            Defaults to 1.
>
> Ideally this would go into a separate preparatory commit.

Right. Will split in two then.

Note: Quentin separately asked to drop the x509-key-uri entry arg and let
keyfile accept either a path or a URI. v5 will do that, which trims patch
2/2 further. Since that's a non-trivial restructuring of the entry-arg
surface, I'll drop your Reviewed-by from v5 so you can re-evaluate, and
re-add it once you're happy.

Best regards,

Sergio Prado
