Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59136CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 20:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ADC84BE0;
	Thu,  7 May 2026 22:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="NhO5FG/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C3784BED; Thu,  7 May 2026 22:10:16 +0200 (CEST)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB7A84BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 22:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso1638491eec.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 13:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778184611; cv=none;
 d=google.com; s=arc-20240605;
 b=BzNSIpW4p6T2yor1J3RcXvu4p8YRlJjIp6AzwNv1++LcloxewHuK4O01ejDrQgBL0m
 FtDI5AgoCfRyPPdNAEDgyxoGu33YXtcn7oQOqUBK73dIG6Zk1Cqi+7Fd8XAi05a9Y1ox
 qUfPNQw2c1P5s3CwTwzcUOXEMZYCpC1MJirRAYB5OdmhNhyM37UmDOn3H6CxFZdsYWe8
 /jtM65ad2ZgWz2dR7tZ2+iSIcFpa3073oX+nsot7DAi5uPBL8t9ccqPs1j5yklsnzmxe
 mOptMy2ma5NIzTla2JTKNx6W43fqyW7J1Eq5KItYSrcs2GrN/f7ZzzDtWBnlUbKOEoFz
 VlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E6jr4Vn5MJSknJnN06DhtjUSLn1LgwCtxeQjEdg3umk=;
 fh=B7++efQEoSVFQ9ePsS0QvvXoKtroD+13bBMFR3U3XYY=;
 b=fQqbb65PhxwOBBi6FRbx38QnnPLW3zbUmHaC0mEcyOC5SAtOaT3T5DIzqJvGDEJ2C8
 USH5nF1Hh4HK1jmUeCb/h8CIEaqy1Uc6j4XYwJYMoG1GiqsDJO9qdnQ6E+w4bErvvi6w
 YHdRK99P9Ono8L87ixFD9svrCJGejxpljIM3HWckA4KkQdJ9wKytDZwO5apZtIAyPbdo
 jnfPGUIcTTEvYlIgsLpA0enR1QFc5L8T195LdYzs8aRLpuI+2VKKZdVxes5UFbVZySid
 GNTGGXG+gijsX2GCnLUb7ckQo7CcCIF9xMSI/0GtNnpyBD5wsI/vUkOtK5U+Z6TBjDjT
 7+6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1778184611; x=1778789411;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6jr4Vn5MJSknJnN06DhtjUSLn1LgwCtxeQjEdg3umk=;
 b=NhO5FG/j2vwsjoIhIIi89oqwPoKJw0sA2sbujUtCkT1rfdDGGGJrW0ynq408sae/DK
 GSsGilH/j8qmGhQePCx7/Kzlo6sV/r/ueLaA6oNxMvhSEZ26e7a3dKySwHKa8AhiS8Tn
 te7oJ9Td6NiQPj88+eWiwJskMwM1SDlmW3YMj0eR3mToLJJVMupLLsChgSCavc0t+3kA
 /UdKHp79DWiD/5swFcsHBQ1P8hBUSmoLLS8G7oEhYD71T7BMSv69+hPqtXW81O6KVa16
 PxfK6KRCC51FsoIalHKljh1KFBR57iZXMma1OlTPftcApwupIJHgIJqaKHgODpyPxySV
 r3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778184611; x=1778789411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6jr4Vn5MJSknJnN06DhtjUSLn1LgwCtxeQjEdg3umk=;
 b=I7t9N6yCYEo47zzQxjJ/LHXUTVBpdL/1gg5Hngoaju917dAyCYc0RFnhHbYFohZJq+
 xVF9QbzXYJH/TlA6SkJGau2pgakSNHUyH/Wdq5r7E3cPkKN9A+2LHg4ipiJy+r48aXGC
 ImNQIGiQWVgb3T+whTn9LKyPyya/7OSgc9FGi5C5l+ViHlBLzvfw2rv2f3OzTQT6UiWC
 Wsx3+JYP0PnhZNOVLmUwnucQJsRBD+xAkKilxI3qRpEMwolum2rDV4DKeUEgDJVGvdwM
 1WJ+oFJvmGsyNK/6a8KAHKCxm74YpnydQIzV4s6MX0GFX88jTipWECONJvUn34TLLfqD
 GC4g==
X-Gm-Message-State: AOJu0Yy8tp6cuFOEASyq9nJi1sR/MJXsLsdkrnKGAla4gM+p75o9BYpH
 cQBvTf6wuzAgpIRBNC2LWnjttvJuyS8r3m313g2TAB5gMQiD+OUD3p4TRGGTQzPkyDQUS+NsufW
 pp3Nm+snOO/VgrZ11oGPtLSRtnoeOgWYtWxGQnQwdew==
X-Gm-Gg: Acq92OFaXgcsr3dSfg1pkt1srdQ6OPvgg7S62xibPpDM4tSQGx++0yWhIj8KRNATjCG
 2Kz8o1rUDaxT4jxfF6G+rMXIF00NTAOje922uj4dHp8+EiLO/qBxM5w11M8UwOCVbY77PRbQz+y
 WIEx4M88/LK1+eH8HTYSjTGxKcT9ywH3uh6pKHRDlAAiEWj5ZiqjhAUnA1gBNES9qkvsrGc85vE
 wHqYMtw6JxeiUxsRRoRazjp6cW0MUq6HN59VmUJwOo+UpdLA5SmMLpfmcgfXUxuM4yOJT0kiHG2
 fNDbKMYWdXcPSVYu/9Q0vb2RwgWOKVwXrMb2DFI=
X-Received: by 2002:a05:7301:3f07:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-2f54b57793bmr4947285eec.34.1778184610955; Thu, 07 May 2026
 13:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
 <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
 <CANu7NGs0=o5H7o=qwoQj5EYMxDtB7_NTus_-18Q1UZBnk3DiuQ@mail.gmail.com>
 <dc13566a-b477-4580-8954-0c0f83608ff1@cherry.de>
In-Reply-To: <dc13566a-b477-4580-8954-0c0f83608ff1@cherry.de>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 7 May 2026 17:09:54 -0300
X-Gm-Features: AVHnY4LrWFdMJnhjjAYUC-dMrRkFIpgLwKUjNk0VUNqGrX5f0gVWqR4R9plDu8A
Message-ID: <CANu7NGsFtWuLH1AZ_B8oMS8+rjpjgANYuVuVtVAaTNW1HzgcNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

> > Good point. I=E2=80=99ll scope this more precisely to X.509 usage. Woul=
d
> > BINMAN_X509_PKCS11_URI be appropriate, or do you have a preferred namin=
g
> > convention here?
> >
>
> Is this really PKCS11-specific? Is there no other way to get an x509
> than by PKCS11 or plaintext file? Trying to think about potentially
> having other providers needing something similar and then setting
> BINMAN_X509_PKCS11_URI for that would be confusing.

Hmmm, good point. What if we rename the variable to BINMAN_X509_KEY_URI and
the entry argument to key-uri?

> >  From my testing with SoftHSM2:
> >
> > - Provider-based flow: configuring openssl.cnf is sufficient. OpenSSL
> > dispatches "pkcs11:" URIs via the STORE API without additional CLI
> > arguments.
> > - Engine-based flow: configuring the engine in openssl.cnf alone is not
> > sufficient; "-engine pkcs11 -keyform engine" must still be passed
> > explicitly.
> >
>
> Being curious now, I'm wondering if setting the -key to
> org.openssl.engine:pkcs11:<key> would be enough on OpenSSL 3.x? C.f.
> https://docs.openssl.org/3.0/man1/openssl/#engine-options

Good catch! It does work.

$ OPENSSL_CONF=3Dtest_engine.cnf openssl req -new -x509 -key \
   "org.openssl.engine:pkcs11:${PKCS11_URI}" -nodes -outform DER \
   -out cert_engine_unified.der -subj "/CN=3Dtest-unified-engine" \
   -sha512 && echo "exit: $?"
exit: 0

With this, the implementation transparently supports both flows on OpenSSL
3.x - the user picks the URI form to match their setup. I'll document both
URI forms in the binman documentation.

> I'm tempted to say "another person's problem". I was already not happy
> to contribute support for OpenSSL engines in FIT signing because it's
> been deprecated for years at that point but I needed it (could have kept
> it downstream though). We just need to make sure it's not impossible to
> support if someone really wants it (and it needs to work with OpenSSL
> 1.x I believe, even though it's official EoL you can still buy
> commercial support for it).

Understood.

Regards,

Sergio Prado
