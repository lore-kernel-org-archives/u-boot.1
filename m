Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC35C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 23:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF85180F42;
	Mon, 10 Aug 2026 23:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYXFC6qmz1cJ; Mon, 10 Aug 2026 23:46:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF24C80F43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786405573;
	bh=i3WXrNh4nZR1ztdsectTkU4U5j/mx3zcH0L9rw336cE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HTKaRZ/+cL2qrPmxIRIdpx1C5FpFaJKT4JmevslmuNI47lvf3VdFPJP0WdZUfuT67
	 v54RjWPH0DNZmzPRgz0Bs092SOEHW/tve8kmeh48sxi50HOxj549EmPoMVgkoBW8G7
	 r+OzU++5zj5xwHzfpuUlzBWybYtlARUVaxXkqYf07tZcnzyC3uYNpwe9D2tszvpa5w
	 67R6yUy22kOL9Jn4JxRPCrbuoTFKb7dKajt1pgGIvAKmDpWce0e0hf8STpKFeTfZt4
	 nJKjnVXwDreOXblOYmNVyvNbqpZh8iTVj16gLw9vSmw3HVMUAsS8vu1NRQWNJeXepJ
	 xHtNjPGMc9GNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF24C80F43;
	Mon, 10 Aug 2026 23:46:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 604F9345
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 522A480F43
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id osbyBjiNxdug for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 23:46:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5BA3280F42
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BA3280F42
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BA3280F42
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:46:11 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-7564b7a9490so267969137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786405570; cv=none;
 d=google.com; s=arc-20260327;
 b=YfXrhJs6egUwQoAQs+Lnf/erUjb4UJG2u2IBnLxmPzOw4ePdJh4NCRb7ZfsXZzT+fI
 dUtEp4aDQTU0W2zE8kj3kFXHstVRyqtFfvTt+koYG/R/LDK0C05XCzdPMZUoboJTA0LH
 AliWzwCuP9IznHhP8RTYa2FLXJzUwAwPWDdWR6L32LYkDUWKdKsWygF0aHjvA1nXu1NP
 IW8sxE4SiXF6ThkALiCiXdt2o9uL9H12Rx/2ikXw7ymv3J4+okzh5wUrqRhYlnS1WnMa
 f3UX/xRLN2EiRcDeVa065vNwhdSFngEYwEujHm5C+vpmWeXJTOBRr9H+h9YqXHCPkN7G
 /pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i3WXrNh4nZR1ztdsectTkU4U5j/mx3zcH0L9rw336cE=;
 fh=tUymySUR6fNVkFVjGmHJu0mpraiPWPzpo8YU3bqq73c=;
 b=f8xYBaYCmK+JcMcCLK3MaLBETLSPlsPtLZo9EQckquVT07ECSxBZrXLF0WuTA7zf5G
 lw+dqFInAo19CVn9C5JGXFUaf+TPaJTpJXBee1QIn/K7QUVrOS1s4VbV9ne0GsLKv802
 4Lxbuo/TXM0SWsqF7C+2CJKXenMsoQrZIQUE2Bg0+avEIpROFULDHjKHTSo7pQg3GFV8
 YoiLoLUT+h9KUXPVy7/ImaZiuRZMyT+wQDBeSAKugoehcfjyaompInhUmiMwasCL46/G
 WwOlC7ano/d8L4uACE7etgBgzR+qOd5ajL94o8i6mCikFI059VJeyCOqPLvB1+OBRv9u
 BGeQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786405570; x=1787010370;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i3WXrNh4nZR1ztdsectTkU4U5j/mx3zcH0L9rw336cE=;
 b=CnLrBmGwTOOjt6/uY1nuXPjHBjDuVWHUSUPPYhA9S5j2EG+CSUYLs99pqAiocRkO3B
 Zc5yK5K6JtqQTC3DPJjRE44aSnby2kqO4ETq+rYu9A5M2CagBy0ltvu6LNaAD6+lPyZ2
 YJOdEbJ18zmwVRCPWrYh89aB8+Qdj/rOjk9ntuU9WJEH/JNu3LhchE5Sd/sR8aQ7x+aL
 CLTAfmDcUp4exUQUmnch7s3v3ZTdPJrhWmSP9Pl7eZ54ukL41Xk+B3452gqkjILs3gZi
 V5DbnyS+kGDxXGXgvCHCT8A7MTjEruRpyNCLfaRpFOI6yB4NXhgEVERFWOG0pYkKrbSw
 PlAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK7A9Y15UQySoAwvj/Xk3pRytkWxZruQxO7RaB05WcaBww4NzUuVgywN8ifUm8WNGB0KXbrHo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz4Qwb3blycJ8gDRW2q0ZivKbXjLpCnCqvZGSDd0ql1vV24am7K
 OYzXaBUaqJnJj7aGP5wKdgJZSSmGFhti6XuG+feJtL6qZOXW+g080mlvgsTANBQUjtS+2Tz+bEs
 iZ7yw1kGjBN3QEUgHARO3kQvirIIzshU=
X-Gm-Gg: AR+sD12jBJK4TAf67JV7ZPT1VlyIGnHynt5vmZNLeJ+zmxDrIBsYW/GMJU0iP0PAJ+b
 1CsTUFE42lpoXzhOb61bDKU9izswFElLMlRsbmd317C67pz3EL7XNUwz2HmEpYibr7kocYr63KT
 1yN+XlbmNvv5W1txAQzuxEZr626HkcrgQPy1NSjv4BVZgLBnJ/qztzzX6moH0nfuIpZOkkGrd/Y
 r0cs+sQ2Mo7tig9g32UMO2WJ0IR335Jx7EyrEZ3B1ioLHtPI1b8rZJoQWYEGqI1hf/Dp238lpvc
 +LO+uV8yU6Mp5gHdJ2tYeVcF2Fr+0wVLCQZvrahPeRUEQoBNSPEaR7WM795rvUbB+6ZTHJp3itq
 Xf4Ldw4vo91pwAfIiEunpKqSlsFOvg762UVWj+zDbqDaTb9ezOlkf3Vyr9WyRJMEHVEO31AM6Dz
 z/Vbf5HpBGfxApddhj43CIIJJ5St9rhsgTBzCw
X-Received: by 2002:a05:6102:2b85:b0:738:89ca:65a0 with SMTP id
 ada2fe7eead31-76ade655a1emr273105137.9.1786405569951; Mon, 10 Aug 2026
 16:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260728161904.96004-1-james.hilliard1@gmail.com>
 <20260810213225.GE1160436@bill-the-cat>
In-Reply-To: <20260810213225.GE1160436@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 10 Aug 2026 17:45:58 -0600
X-Gm-Features: AUfX_mxhmHOAzgm8CgU6PubOR7jN2GIDWO6NCpdYjW3zVmH_lZV46q7rRqubzMw
Message-ID: <CADvTj4q3xmYtp0bwoJP8Y1gbhtx-qzqpZT8QxwKiCxBF6tidfA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: fit: sign all config image references
To: Tom Rini <trini@konsulko.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Romain Naour <romain.naour@smile.fr>, 
 Shiva Tripathi <s-tripathi1@ti.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786405570; x=1787010370;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i3WXrNh4nZR1ztdsectTkU4U5j/mx3zcH0L9rw336cE=;
 b=rFIukV1eZBXeCx1bS2AfvFYZGBHL2rvDfAZC9CcdFMlfsXFioKglofnRG0vJNUsG64
 Ii0NX3jf7q+SHu5Z4xVSyBSsOBMjAvPDv0HCtig5vzzURbedjbVk+nHxlcBtdpgNI7Yr
 q+/0VTTTi+LD3M5pZp1ob9/3HLIcikhu1Pt4bkpL6zB807q5M2nH0a/cy1F46+OLVFmr
 q1gwkwcKeVHf8i8MDhmEnTbCLQjAJQOEbZ1/MPyJw1u1SxYEJLVbfSfA+kjrCskAblGW
 jVHpmiIIEsau70H+fFKe3mkZYY9Bt5veWzPgr6OAcvIrm3ud80gye1s0M2HzJUlHErKL
 FSNw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rFIukV1e
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 10, 2026 at 3:32=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Jul 28, 2026 at 10:18:39AM -0600, James Hilliard wrote:
>
> > Target-side configuration verification builds the signed-region list fr=
om
> > every image-reference property in the selected configuration. Host-side
> > signing still uses either the signature node sign-images property or th=
e
> > legacy kernel/fdt/script default list.
> >
> > This lets mkimage generate configuration signatures which U-Boot cannot
> > verify when the configuration references other image types, such as
> > firmware, loadables or ramdisk entries. It also lets the host and targe=
t
> > disagree when sign-images names only a subset of the configuration imag=
es.
> >
> > Build the host-side signing list from the configuration properties in t=
he
> > same way as target-side verification. Use one shared property classifie=
r so
> > the host and target cannot drift apart again. This makes signed
> > configurations cover the root node, the configuration node, every
> > referenced image node, and its hash/cipher subnodes, regardless of imag=
e
> > type.
> >
> > Warn when a legacy sign-images property is present, since it no longer
> > limits the signed image list. Require every referenced image to have at
> > least one hash subnode. Add sandbox coverage proving that a firmware
> > reference omitted from sign-images is still recorded in hashed-nodes an=
d
> > verified.
> >
> > Update the signed-configuration documentation to describe the same rule=
 and
> > the hash-subnode requirement.
> >
> > Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build sig=
ned node list")
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v1 -> v2:
> >   - Add vboot coverage for an extra firmware reference omitted from
> >     sign-images  (suggested by Simon Glass)
> >   - Warn when mkimage ignores sign-images  (suggested by Simon Glass)
> >   - Share configuration-property classification between host and target
> >     code and remove the stale load-only comment  (suggested by Simon Gl=
ass)
> >   - Document that every referenced image needs a hash subnode
> >     (suggested by Simon Glass)
> > ---
> >  boot/image-fit-sig.c                          |  9 +-
> >  boot/image-fit.c                              | 17 ++++
> >  doc/board/ti/k3.rst                           | 10 +--
> >  doc/usage/fit/beaglebone_vboot.rst            |  5 +-
> >  doc/usage/fit/sign-configs.rst                | 13 ++-
> >  doc/usage/fit/signature.rst                   | 26 +++---
> >  doc/usage/fit/uefi.rst                        |  2 -
> >  include/image.h                               |  9 ++
> >  test/py/tests/test_vboot.py                   | 11 ++-
> >  test/py/tests/vboot/sign-configs-algo-arg.its |  1 -
> >  test/py/tests/vboot/sign-configs-sha1-pss.its |  1 -
> >  test/py/tests/vboot/sign-configs-sha1.its     | 11 +++
> >  .../vboot/sign-configs-sha256-pss-prod.its    |  1 -
> >  .../tests/vboot/sign-configs-sha256-pss.its   |  1 -
> >  test/py/tests/vboot/sign-configs-sha256.its   |  1 -
> >  test/py/tests/vboot/sign-configs-sha384.its   |  1 -
> >  tools/fit_image.c                             | 12 ++-
> >  tools/image-host.c                            | 84 ++++++++-----------
> >  18 files changed, 121 insertions(+), 94 deletions(-)
>
> After some other changes, this no longer applies correctly, can you
> please rebase? Sorry, thanks!

Rebased on main:
https://lore.kernel.org/all/20260810234318.119255-1-james.hilliard1@gmail.c=
om/

>
> --
> Tom
