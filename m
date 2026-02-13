Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86122EF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E4A83CB5;
	Fri, 13 Feb 2026 21:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nLJvUdgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E1483015; Fri, 13 Feb 2026 21:20:52 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7071883E57
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a7d98c1879so7621615ad.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014049; cv=none;
 d=google.com; s=arc-20240605;
 b=Mu4VQtMbP8lMj+PhK2ubIQQQOykfzMxsD/8SPtsMDPEyk8bM9JNx+7NmYa3QYSaAJm
 TXc7A0VstsHMg3BN+H/bC7BZnuu9a9cMq/Gk7LWZq7ncrV8OSQOduplVgfcHv4g1AawB
 VyQbdDxYNj6qsNqI1KmdoIEPRqT+bKHNWup6ELbUi0pCGZHMYkcNWv1UYcdvf0Nyw8Zu
 n9gmN9sU4imIn5DWM8pQmwl0YoMzwvJR373DIgwKbrech+UxR/HqoTmWTguTeRrYko3x
 lc7zIZhsuit7n2BXvF+kaw8v9IcdqCUgpWhfQDNstBNyNa9dVW0H4jCmMeni6tIKeVgJ
 bqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rTB99JAeDUk7heewdxmfNid96Yq5+Ks6gel18vCuEKE=;
 fh=BNXxXodM6x/TTtNw5dDUbIgJJ3THT0IIKdNrgcKqd+M=;
 b=P9+oFa2KSoMYa5TFeHQFtzguYB8lJTiLezlE6Yiqf1Wu5hgBOsW3A/cd8HHQczMzDI
 kNOFDYVCheUT7cdB/gCYb+BVKY1FbgvB7H15IUDkkuUFmuo2pqChUwz3T1A8I6nglhmL
 BqDtG0iSR2nWQyTFOvlbCAItnLgL61mVA7HiBLmJRy0YnJinWVea43xdYZt27YN5RK1p
 zcDoBjOBnuyCG4b1n1jTBuToAToOYlfjv6zq1rWwK19oCipD5GqIp8zmWfdHCHBIkxo2
 u7Qm9F8FHgXDrB2flvdbCkfacCBD3md71647RjPsr30Q4OzDMoop9peTdIc4UjJPqGml
 nPig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014049; x=1771618849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rTB99JAeDUk7heewdxmfNid96Yq5+Ks6gel18vCuEKE=;
 b=nLJvUdgEE8kgrv76Gb6NAsF6HDo7boCd8pvnG7F8uFolB9Ak5FIJfPKm8n6zP1Y9YZ
 bvIwxo920Zgl8MrplPMIdlS2HLzOPxgnGebV5eRdMMcHYpG5zaiXmd9P4lKK0vz4esBh
 5kzDH7so25e8AVk1RZsYs+UFEceDw5fd72RC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014049; x=1771618849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTB99JAeDUk7heewdxmfNid96Yq5+Ks6gel18vCuEKE=;
 b=r7kpRlSHmuJq4HFVLKzMJGp5H7Ln318JeZlassINw9Ap7iiLxFCw+RIqHnxk5sYhr4
 IXXgOz+KFnu0ySfSUtYZDztW1NbxUQC/TeJqbibAZIAsaB24qYHCfkWsB1d8wDEVRcuW
 MUhF2ygv3ROPb6Isutru8dbA65HL4pQc6B3jWc3qw/I181naUNwaKEQHAPaj5RF0oGIC
 DgSswMSMuP1fLOrPuIKvDHMMeUw9o7VvWkbfnoBNmZ8IobJZBYjHTHK5KrQu9Mb2UiPx
 LX6BnbsDIly3aEgDhZqazvDENh+gnbre9iLQ53Ar2dOM5XgsLjN8lM+Po4c0QLBU054t
 W1Iw==
X-Gm-Message-State: AOJu0YxzsB1s9NhNL/ui8HUy4jylZoR3fY1MBo8tbQ1xItz1M7eHGjWP
 /wZl8ZJevTXcOhBOCFa/DwrufDteZgYPxwHaIXwD5NoUEdJpsTl7LNHFNh0++TT4Bmf9zujQDSt
 TjGR/grqh5UTLm5KoQLtCY2g8YYTmHnTDOmxlURFt
X-Gm-Gg: AZuq6aIpK74kMg4ZnnJFI7MnBxm4QCUn4r/lQLsSxQC/mnUO+edRahzWCbXHIp8DZzz
 d2mvoIsA+kC0zM6c9twwJA4hf+Q49DjmnI/HIeNqXIcxbUp85jRWMRdpLWaUKkF27ng9MJ1mPNH
 /ytt5iGfoK8tmJHLWaRGlLVPaYDAuQi07ZPc0VNo6tpaZ0hRM9sEvVaeuaLY+hX+SqMOp4/wKaP
 cw1G/BovOrNJMw5ApaMMLeJsN4uDhelyjiMHCcV2N+lb2WzR0cFdWX2AG3Ab4xLAFBDeHUJD2oo
 JeuR
X-Received: by 2002:a17:903:19cf:b0:2ab:3cba:4304 with SMTP id
 d9443c01a7336-2ab505e4f39mr29202135ad.43.1771014048929; Fri, 13 Feb 2026
 12:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20260213001212.157033-1-marex@nabladev.com>
 <CAFLszTi1M=J6+R1CcAJRY4gnQa87ScFkQ-YOK+NWzsB02VKnwA@mail.gmail.com>
 <481a2418-4a4c-411c-8028-db7c5c4c243f@nabladev.com>
In-Reply-To: <481a2418-4a4c-411c-8028-db7c5c4c243f@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:20:03 -0700
X-Gm-Features: AZwV_QgsXddOoLZwsQ9PnbZ7RE2YkMZWfu8poBS6LujjZaRVj5JNn2dZwPDh71E
Message-ID: <CAFLszTj0PjocZLL_3VSP+ckDKW57j99jPbZ3nmUKdA-M3-juFw@mail.gmail.com>
Subject: Re: [PATCH] binman: add CST backend selection for i.MX8M signing
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, 13 Feb 2026 at 12:27, Marek Vasut <marex@nabladev.com> wrote:
>
> On 2/13/26 6:53 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> @@ -161,8 +165,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> >>           with open(cfg_fname, 'w') as cfgf:
> >>               config.write(cfgf)
> >>
> >> +        # SSL is the default backend, PKCS11 backend is optional
> >> +        if self.backend == "pkcs11":
> >> +            cst_backend = "pkcs11"
> >> +        else:
> >> +            cst_backend = "ssl"
> >> +
> >>           output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
> >> -        args = ['-i', cfg_fname, '-o', output_fname]
> >> +        args = ['-i', cfg_fname, '-o', output_fname, '-b', cst_backend]
> >>           if self.cst.run_cmd(*args) is not None:
> >>               outdata = tools.read_file(output_fname)
> >>               # fixme: 0x2000 should be CONFIG_CSF_SIZE
> >> --
> >> 2.51.0
> >>
> >
> > This should be documented somewhere, likely in the comment for this
> > entry type, so it ends up visible in the docs.
>
> I will send a V2 with documentation.
>
> > Also, this code path will need a test, please.
> How do you propose to test this ?

Extend or copy one of the existing imx8 tests, perhaps with a new .dts
- and I suppose set the env var and see that it works too?

Note that imx8 has basic test coverage but there is quite a bit missing:

tools/binman/btool/cst.py                                  18      4    78%
tools/binman/etype/nxp_imx8mcst.py                         89     69    22%
tools/binman/etype/nxp_imx8mimage.py                       38      6    84%

I shed a small tear whenever I see that :-)

Regards,
Simon
