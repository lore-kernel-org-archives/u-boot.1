Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A595109192A
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014DB8407E;
	Thu, 19 Mar 2026 23:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="du2bSRQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4C884067; Thu, 19 Mar 2026 23:09:26 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C15A84056
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso8434566b.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958163; cv=none;
 d=google.com; s=arc-20240605;
 b=Lp4Am5E/bz52DDi5JDeueliJA2v8hFEbKxgsB1Ib16lVzKG0ciWHf0iqmFFynEHMVu
 cpIaX8n7xGDT/bjLqQenp7gWsom/OhupKNPEOIFBstZXuCYBgHPLjpqw4uYM7k8nkewZ
 aXkz7T3Puq0f/eIhmfCZhj8t/CFU2cYCWdnMQQ3upnOMGWNmnuOwHatrYiGoF6FhlwEr
 OHiPJw521BaNT7q1x2YPNB7wO0oroobi283aZp+rkmVbJq5jasTHiVOH3nBFArcYP1MQ
 BqNIybGt+9JgOp1MwU/nKUb0Lu3QmIL77pbh5z+LGQSup20jEQSh09sf7XXATtzcb/EX
 D9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VPve5oIvjrd595kNEH2LQT9/gRWlKmWbwsnjo2sLAsM=;
 fh=0TEFg7aVJKKk9JXw94V9x2jgSOocUbFB1vHOy/KsALk=;
 b=eVcxUj1hTj7NkWtsWNLJLlHRzee+GBsR1XDuWpl2sOlRAzjSyfWvloKN1jsyTs9FjG
 /qoZjmPY3fvqMiXWkAkz39RZtvuxJq6DCspX+2plL6ezcpD1b5o7RF+wsy6iBccf7Pr6
 oMKqfDGDcWrqx0LQvn6Y/BIGRB8sIcsbfoRBw7D9V/kvSQTXCmaRgEcZJqB6pmKaWZPl
 R0X6gNS2Uy2WhKsajCowcL5kHLFFs+9iJJYqL2dnvLcG2D87uJfvGc3AdQaO5mUSwvuK
 zWuo0yFru3xumZ1r0xMaFOEWtbPPYWsGgkOA51TJlzcfJdV26gi4wW3U+Ob0dMt5oQR6
 cnkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773958163; x=1774562963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VPve5oIvjrd595kNEH2LQT9/gRWlKmWbwsnjo2sLAsM=;
 b=du2bSRQJQVHMhjMOhFR8NN4kOKEYRdyFDSapMW+zOdTkhdMpdpIJcktVrFXgLDXXax
 76DrQ6P1stBXa7GdBVeiPsiTYQ1+yJBJ7tav+SJS1bt6NRgfcnV93SH0wCcEC3XYGqJP
 UMn+0+PtoPWD9WSOlrYbwKjVxRaN8h2YuRSFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773958163; x=1774562963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPve5oIvjrd595kNEH2LQT9/gRWlKmWbwsnjo2sLAsM=;
 b=NsPQo3Z1TRm6LN7bYkLB8RCur7l44vuiUUrxEOr1WHxc0Za/du6M9bXHP+CfzCgbZl
 EHM32rjWETJu+XwYixAVd89bhrp6Re3m5BXik1Hvq8DsPhv9QC8C8EYIDWSTWyX5p/rE
 CcgzULyHUIcc9HzZ/g0sefRbr1SImCFSrADSLJ3+9DzWeJ197RC6UZuhR/Trv3INtUZi
 cQ0I4cu/fK64Rl5jaEXi/0ZiQRdC1w0Tp/49SQc/9PdIZC8eFLO3wUxcOAoGzzI+h/i1
 0MOmA/nGXCP9+bbMOVBj35FzJCAbAWb1rnhVonL0QZlaHHGsTfVKAEXKZ47uvqfocVNm
 lx5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFID5YyJ4j0+SpzDzsYMRgULyzwhStjw70IEdxdz2Ec2ckwG6h/j1UsvU2xfJfgp+3V+J/+4w=@lists.denx.de
X-Gm-Message-State: AOJu0YwztQ1cVEkhhmezP3AxV+g5kBKFZNLjHrX+vfaZDesdS0jobvfC
 pMAOVIBxKm/5UOB1XCsQhK9Rh/XjeM7rd1z69HUvjSR5oy401t1bRWlwewHv6rtotoY7XsvwkAE
 B7awBeJXjFfh44akmiDYADEmXgD6O4T6kgBlQFcxyVJcyU/P5HVCcsQ==
X-Gm-Gg: ATEYQzxbfS8npGdd429zLi8oDgYFYg2C4miZSnQ/JsVf/np1kpLrg9WePZtpWBaAhLz
 R+x9WSoBr3LnZBuZ6nCnLFhQSqwuErs2SKr1alUNVnysEK1hebCsdnRzTNLjeaBYPW8uLopD1Fa
 89coLNQpdaYVAw6vhbcMcjczbDfjITYMMiVBX7NBTEkvdgWCfy6M14xOl1MuSuqtS1MriX1qq8b
 SFRTbFOULH3wFEgv4MPZlLmTNH9ShJeKCKEH3rnQab8/skmbJbq0hSTl1bHteWpTHjoiRP2+agE
 ks+iIXt2
X-Received: by 2002:a17:906:c9c6:b0:b98:4d6:8c9c with SMTP id
 a640c23a62f3a-b982f363047mr56144766b.32.1773958162622; Thu, 19 Mar 2026
 15:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
 <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
 <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
 <20260317140918.GZ502704@bill-the-cat>
 <CAFLszTha9TbXVyRt8yS8i4_Xm6WZ8MQVF3aTB6W-uq99Xn6S3w@mail.gmail.com>
 <20260318014444.GI502704@bill-the-cat>
In-Reply-To: <20260318014444.GI502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Mar 2026 16:09:11 -0600
X-Gm-Features: AaiRm5099_GX0o_EKM7RKwvvUIedSgo_L4PflRXJRNGHxCbZoNNg5cfPndhtN10
Message-ID: <CAFLszTh-OA7vfZ5hnzMSvMCz3gRCRLYe2y0X5R7iV9MK8K-JCA@mail.gmail.com>
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

Hi,

On Tue, 17 Mar 2026 at 19:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 06:10:39PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Mar 2026 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Mar 17, 2026 at 06:28:47AM -0600, Simon Glass wrote:
> > > > +Heinrich Schuchardt
> > > >
> > > > Hi Marek,
> > > >
> > > > On Fri, 13 Feb 2026 at 19:51, Marek Vasut <marex@nabladev.com> wrote:
> > > > >
> > > > > On 2/13/26 9:20 PM, Simon Glass wrote:
> > > > >
> > > > > Hello Simon,
> > > > >
> > > > > >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > > >> index 1bea091344d..a3ebd397d82 100644
> > > > > >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > > >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > > >> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
> > > > > >>   variables. The following DT properties and environment variables are supported.
> > > > > >>   Note that environment variables override DT properties.
> > > > > >>
> > > > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > > > >> -| DT property        | Variable  | Description                                                      |
> > > > > >> -+====================+===========+==================================================================+
> > > > > >> -| nxp,loader-address |           | SPL base address                                                 |
> > > > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > > > >> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
> > > > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > > > >> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > > > >> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| DT property        | Variable    | Description                                                      |
> > > > > >> ++====================+=============+==================================================================+
> > > > > >> +| nxp,loader-address |             | SPL base address                                                 |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,fast-auth      |             | enable fast authentication method                                |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,unlock         |             | unlock CAAM in SPL                                               |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
> > > > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > > > >
> > > > > > Perhaps point to an example?
> > > >
> > > > Sorry I missed this earlier.
> > > >
> > > > >
> > > > > Example of what ? Two lines below, there is an example of using those
> > > > > env vars, see the entire file.
> > > >
> > > > Yes I see it, but it doesn't have CST_BACKEND right?
> > > >
> > > > >
> > > > > >>   Environment variables can be set as follows to point the build process
> > > > > >>   to external key material:
> > > > > >> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> > > > > >> index 8922d6cd070..29bc778d0e5 100644
> > > > > >> --- a/tools/binman/entries.rst
> > > > > >> +++ b/tools/binman/entries.rst
> > > > > >> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
> > > > > >>
> > > > > >>   Properties / Entry arguments:
> > > > > >>       - nxp,loader-address - loader address (SPL text base)
> > > > > >> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> > > > > >> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> > > > > >> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> > > > > >> +    - nxp,fast-auth - enable fast authentication method
> > > > > >> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
> > > > > >> +    - nxp,unlock - unlock CAAM in SPL
> > > > > >> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
> > > > > >>
> > > > > >
> > > > > > The way it works is you add this as a comment in nxp_imx8mcst.py and
> > > > > > then run 'binman entry-docs' to generate entries.rst - see here:
> > > > > >
> > > > > > https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
> > > > > Why is there this entries.rst then ? Should the entries be removed from
> > > > > here and moved into the py file or what is this inconsistency ?
> > > >
> > > > The entries.rst file is there so that the documentation can be build,
> > > > containing it. It might be possible to update 'make htmldocs' to run
> > > > binman to update the generated docs.
> > > >
> > > > Heinrich, what do you think about that?
> > >
> > > That won't work for readthedocs, it needs to be generated, if it can, as
> > > part of the normal sphix build doc process.
> >
> > Hmm that's a bit of a pain. We don't really want to run binman from
> > sphinx. I could create an Sphinx extension to create the entry and
> > bintools docs, perhaps?
>
> I'm not sure of the best way to solve the problem of generating this
> file on-demand, so it doesn't get out of date (nor edited directly
> again). I just know that in addition to the CI targets we need for
> readthedocs to do it automatically as well.

I sent this:

https://patchwork.ozlabs.org/project/uboot/list/?series=496461

Regards,
Simon
