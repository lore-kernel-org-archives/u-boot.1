Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAD4C41513
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0BC885F7;
	Wed, 22 May 2024 19:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="rur+7Hg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82ABA8885B; Wed, 22 May 2024 19:03:20 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FE1885F7
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ba0cb1ea68so1382789a91.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716397396; x=1717002196; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nc26+ITg4ClZFs622ecxztnk0h8ByWMJMOQf73bEjAc=;
 b=rur+7Hg261Wfdp/pjcBT8BdrRvErsy4hITsomEZAPdG4/AVASaqFlCBJ/NJjRwv1s4
 rm/gYPE4IEeOpdnJ4wHGgsZv/U06pFtgsnGJ05geLXh7+RwMqDbkAiFkHk8p1joCg0IK
 qsYbEQCA4yaIaDcsiVOCWrtHeQmgHTnhwCrji4UpL7FTRpSoEwFVWFKrvfLWh7MBPvG1
 Gkry9sng8wuUHRhK6s36RUKz2awk3D/gifbv/sybRfVPOlyGM5n5p2XYdJIkGmiy2h6k
 jitgV9tSanJL3WQyDmWEVrQzUg3SmOFf7FkHzUXRd1GwuCuO/5meQ2sIVSxt5fhFac0C
 X+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716397396; x=1717002196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nc26+ITg4ClZFs622ecxztnk0h8ByWMJMOQf73bEjAc=;
 b=XNMQQDGn163+c8QEZEaga99kFOM4FNUXNpsTuc+b3j4lyIZpKxb8aGlCBneTq4p7dI
 SJgRLNgqT5KRnoiccWASj/bhyzPXOPmJO4wMXFAsT+qlOPO71r01PyxJ5l1aOE6DvlwC
 ONIGYBXhMyoehShOlAHn5d46Yjvme7ULUSpv+A+LITbzSnaG9TNCeQHsQF3R534IOTRJ
 nr2SEXe7Yu6wHTosvbW41Nl5hyr6VVEV9ICFzvEU2z8EXoI84HntcHvcAfVEnIzqjDt5
 3/Czx154wsSpTPQXvI/ii0MK2pFHm+cKlPA1tMLREkuDpMwLDCDk1H8jRbEvfqt9PX4F
 qdhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAyzCFS09qDgER8dZ55AEwdrR1unZOY7ZYAFCIL7FiOsCCK0CwWUsAEpEHcmOzfkiZ/FQ5yOVo95LdBwi7WRgaY32ZHA==
X-Gm-Message-State: AOJu0YxwyjehDWGrmF39Uo7llklyc0Rvtnnpbdz09S5y3Jz3jIIgzRGb
 QbRRR9mhR8Mc4HOFpnrd+l9CeglkDEOJoOeGdLbR0lfyqsug/bgnq21/9UHf5Qopf7ix0o5Dszy
 svaHDiA9IgZuXV8LOdIgieKkpyhD5pmAMumIeHA==
X-Google-Smtp-Source: AGHT+IHdANBEHF1R1OU+FIrKs+b0qAf/yJ7RwoQHaAER7HAAhMCsoqW9MqBOd8Az0QbtB1gmiSbOZJDzm7THUusgrtk=
X-Received: by 2002:a17:90a:c986:b0:2b6:22bd:f4b2 with SMTP id
 98e67ed59e1d1-2bd9f43c44fmr2614980a91.4.1716397395222; Wed, 22 May 2024
 10:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240522101437.225880-1-robert.marko@sartura.hr>
 <20240522101437.225880-2-robert.marko@sartura.hr>
 <289a7fb8-7a27-43aa-8215-fd4ef941a88e@linaro.org>
In-Reply-To: <289a7fb8-7a27-43aa-8215-fd4ef941a88e@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 22 May 2024 19:03:03 +0200
Message-ID: <CA+HBbNFb364Tfjm5Efg6WJHXGYs58VfrkkF+pq_L6Dwsy2iWVQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom: ipq4019: add missing
 networking resets
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, j4g8y7@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, j.beck@linefinity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 22, 2024 at 6:22=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Robert,
>
> On 22/05/2024 12:13, Robert Marko wrote:
> > Add bindings for the missing networking resets found in IPQ4019 GCC.
> > This syncs the bindigs with Linux.
>
> These bindings are already synced from Linux in dts/upstream/include/...
>
> You should be able to just delete this vendored file instead.

Thanks for the tip, indeed it can just be removed.

Regards,
Robert
>
> Kind regards,
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   include/dt-bindings/clock/qcom,gcc-ipq4019.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-=
bindings/clock/qcom,gcc-ipq4019.h
> > index 7e8a7be6dc..fa05878575 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> > @@ -165,5 +165,11 @@
> >   #define GCC_QDSS_BCR                                        69
> >   #define GCC_MPM_BCR                                 70
> >   #define GCC_SPDM_BCR                                        71
> > +#define ESS_MAC1_ARES                                        72
> > +#define ESS_MAC2_ARES                                        73
> > +#define ESS_MAC3_ARES                                        74
> > +#define ESS_MAC4_ARES                                        75
> > +#define ESS_MAC5_ARES                                        76
> > +#define ESS_PSGMII_ARES                                      77
> >
> >   #endif
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
