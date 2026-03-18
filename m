Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1302FF6E9F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 00:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46EBE83FA3;
	Wed, 18 Mar 2026 01:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R4dVYa5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007CE83FD3; Wed, 18 Mar 2026 01:10:58 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E12983F6D
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 01:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-667de793310so92642a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 17:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792655; cv=none;
 d=google.com; s=arc-20240605;
 b=ZvO1cqkQHJ4/QxdA2ZB8snQrSvgxAWOPUzJ0pphl8YD4z7LjndCwq2GxICem/BtucU
 BTo0FjQFTEMr/txkoBfKnsPDW/iKhVa4VO6EhoyvRMuJYg1Yz6r2EXpZ6dtukYrIh+Tl
 n+SEUZePWoop4qrP5kFkNdj2LsU6d1vYlOkp3dtY6ufjxQ+ET85Yhr/8drxVUp4k4Cq7
 XBv2UnorPGxEr9M4YMVY3XfGg2D5SjYLNMZ2/n8N+OQEA8WPoN3hA04XBi2t5w/XXQw4
 gjMM1mO5/fUMYlrmaTL/9FN4wVTbuOVgji0Jmg8j48lsvB5ZUChbmf/3MXiG19mUruWY
 ZGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oPFGv7G+KvOSwp9n+12e6L8uPF73mFKhqqaph2NStzc=;
 fh=bLtfC09wmpDLVvWK0+lJ91PLbYUC+rpgLlo6ttgQvHU=;
 b=d2WApWCndMqVrnWZdsUFVvjF/3Btnq/0Y2BHiMbLwoKzJ9lTW65B79DQd/LwShUYHG
 2MAffBjOGpD7QIDybKQ4Av84Y6sERytbo/Qrk2uibx11TROLMuIY66zqRcz0D9M8KXDg
 Fzxs+cR8q+lKxSJr665GSXcNlOx+WdVhtpRotNOzEt76TiEoOMoCjiujSNZnGR7tLiRW
 Kii6+IDn7XagGLwutwAmeyhoB8yR4nT6MXQ6r+tU0qvkGF0eGo3aevwR/a0wRFZJ1FCf
 RFf+VZEz1k8yKkf2GvSWd/3PhhTM7obINseNUQOLl3mA46Kq/QhEHJNA1TEW8KnoBeCB
 GQDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773792655; x=1774397455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oPFGv7G+KvOSwp9n+12e6L8uPF73mFKhqqaph2NStzc=;
 b=R4dVYa5HDhg8W1aZffbeFJYkE1W85tCWxqvEyRKmtds8F8tyFC/s77Du2PAn5Cx9e9
 xiLdobdhwhDS73zlJvxgG5SQivWdBoAjmzUEDhzIHa+pn55kv3ghLKImRemMYrwiBNkY
 uaMwMAYUpnIy/RtDujDTARXmFZEKL4uZGDGWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773792655; x=1774397455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPFGv7G+KvOSwp9n+12e6L8uPF73mFKhqqaph2NStzc=;
 b=UpZ/Ha1bmpT9j9Hfpw+q4dlAzAgKMUdxNb5gUlpnyIGjE44S8PkUPQRhZX3DOdQlBc
 +p8/i7lXcc+UHB25LmjPq1wJg7U2zOi4gQkZ5Ky6E1ORvTjUvmFriEit0gFvcXH91X9j
 hlakBBjVW7gQIsQWtYcRSJ0I6op3B/qDtwhQjH80NtgLT5uEuH6KVIA5aUOTP1q3TR3a
 dsuY/+oRtm//hk2aanaYsxhnicc+7cA8LIUQ/E627G+WdHV7yEU6lEhPZ7xx+5neNXU9
 hkG0eIQHV7n6Tqu1KfhNBrCyREdabvRuQBGyr7AXZ9nQ+UgumZ/IBkQcdfjmFQb2g/Zf
 hxQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIEUuTDDU+bTLxDdhZkgWqyXOPzRx3MK7bpiJ8uz0r9clZxo3oHJZnVZOaX5Y0OrEVyZfdDsA=@lists.denx.de
X-Gm-Message-State: AOJu0YwTVuefyW8KRiYUYf45KXmKasQ15IzcBeB6MltwO8gQpr/UuzP7
 uFskvB/HRmC10O3/Z5HtyQIYnPyGDm2sD6dflyIb0SADQgM/laCYBryfKUamOEGISlBdQpli/ww
 rkb18XkuCi+x1pphhepiXS8ko2TZnGe51vEWizbn9
X-Gm-Gg: ATEYQzwFPThCtqsd6SiZALimqO9aOkq8xLUWRfpy35YBKgmNmcvjx5Mxu6kW5nmt337
 AvW6v0MsE99mmZyd/sK3q535eCUxAlsOgn+sCtzeTQar+10A2PLQJ7emzYC4x6KB2CwC4LrteK1
 aif0+rcM2HZqk7DXVy2wSpca/7HAEUH/zoPWbomaD/5IZlqNZ24kkJZU1kEHJ46TxPptMbmaTPY
 ElijCaX1RSirnNbkNtJX3cYZP6zFzkuXqrBzYtBzX8GlpQXexrjXLphWrUfRqaQ55+HR44KUgbP
 1fntR07XARHW9OF/dyEgonqJ+y/F44BpPgqQnsMF
X-Received: by 2002:a17:906:99c2:b0:b97:73ae:e2c with SMTP id
 a640c23a62f3a-b97f481a65amr70321166b.18.1773792654739; Tue, 17 Mar 2026
 17:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
 <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
 <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
 <20260317140918.GZ502704@bill-the-cat>
In-Reply-To: <20260317140918.GZ502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 18:10:39 -0600
X-Gm-Features: AaiRm50efw_WRVXmsqcgiK1NpmacZWYlB_TVxit9HAf51Hrln_hqBdMjAan3kJA
Message-ID: <CAFLszTha9TbXVyRt8yS8i4_Xm6WZ8MQVF3aTB6W-uq99Xn6S3w@mail.gmail.com>
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

Hi Tom,

On Tue, 17 Mar 2026 at 08:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 06:28:47AM -0600, Simon Glass wrote:
> > +Heinrich Schuchardt
> >
> > Hi Marek,
> >
> > On Fri, 13 Feb 2026 at 19:51, Marek Vasut <marex@nabladev.com> wrote:
> > >
> > > On 2/13/26 9:20 PM, Simon Glass wrote:
> > >
> > > Hello Simon,
> > >
> > > >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > >> index 1bea091344d..a3ebd397d82 100644
> > > >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > >> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
> > > >>   variables. The following DT properties and environment variables are supported.
> > > >>   Note that environment variables override DT properties.
> > > >>
> > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > >> -| DT property        | Variable  | Description                                                      |
> > > >> -+====================+===========+==================================================================+
> > > >> -| nxp,loader-address |           | SPL base address                                                 |
> > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > >> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
> > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > >> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > >> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > >> -+--------------------+-----------+------------------------------------------------------------------+
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| DT property        | Variable    | Description                                                      |
> > > >> ++====================+=============+==================================================================+
> > > >> +| nxp,loader-address |             | SPL base address                                                 |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,fast-auth      |             | enable fast authentication method                                |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,unlock         |             | unlock CAAM in SPL                                               |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
> > > >> ++--------------------+-------------+------------------------------------------------------------------+
> > > >
> > > > Perhaps point to an example?
> >
> > Sorry I missed this earlier.
> >
> > >
> > > Example of what ? Two lines below, there is an example of using those
> > > env vars, see the entire file.
> >
> > Yes I see it, but it doesn't have CST_BACKEND right?
> >
> > >
> > > >>   Environment variables can be set as follows to point the build process
> > > >>   to external key material:
> > > >> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> > > >> index 8922d6cd070..29bc778d0e5 100644
> > > >> --- a/tools/binman/entries.rst
> > > >> +++ b/tools/binman/entries.rst
> > > >> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
> > > >>
> > > >>   Properties / Entry arguments:
> > > >>       - nxp,loader-address - loader address (SPL text base)
> > > >> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> > > >> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> > > >> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> > > >> +    - nxp,fast-auth - enable fast authentication method
> > > >> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
> > > >> +    - nxp,unlock - unlock CAAM in SPL
> > > >> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
> > > >>
> > > >
> > > > The way it works is you add this as a comment in nxp_imx8mcst.py and
> > > > then run 'binman entry-docs' to generate entries.rst - see here:
> > > >
> > > > https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
> > > Why is there this entries.rst then ? Should the entries be removed from
> > > here and moved into the py file or what is this inconsistency ?
> >
> > The entries.rst file is there so that the documentation can be build,
> > containing it. It might be possible to update 'make htmldocs' to run
> > binman to update the generated docs.
> >
> > Heinrich, what do you think about that?
>
> That won't work for readthedocs, it needs to be generated, if it can, as
> part of the normal sphix build doc process.

Hmm that's a bit of a pain. We don't really want to run binman from
sphinx. I could create an Sphinx extension to create the entry and
bintools docs, perhaps?

Regards,
Simon
