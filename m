Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E03CCF9F8
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 02:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABA182A9E;
	Tue,  4 Nov 2025 03:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGwjd7Ku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1458389A; Tue,  4 Nov 2025 03:30:59 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DF28144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 03:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-54bbc2a8586so1857080e0c.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762223456; x=1762828256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NJJgq/lRehRlHbla2xyJTgQU7WJpXQInWjbzZIe8q5Q=;
 b=bGwjd7KuXXIavVBxXq5cszfYUVQl3yVDRGRg766qbb8TTzj9ImU5fxrsUHLyR0fHb8
 o/bpphXPosMNsw9lCTnqSPlyZBkZF12a0GqICwkLwelCLnG+kUAkTqmJM9TSG6GvRJCJ
 NhFEfoTBYAgc1A13sJZ5GK6DWrHTp0nbUXx8WMJhdJIm0bIfe/RR1chW0DQu7kzbMsqH
 Coef6MCBhenTG24Bo4Uhy0fVqmqJHSMwlsW+TLG0g5ZqdTpUBGl04HcB8UFURRJ801+P
 9kNMBbCEg2/vP+2oWkAJ/TuobvTmiDLFETux6fWSLyQIy1vHiyqqKpm5FS+zQLe8e1sU
 vtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762223456; x=1762828256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJJgq/lRehRlHbla2xyJTgQU7WJpXQInWjbzZIe8q5Q=;
 b=M28z35QMicuwUaOBGGLkMmSV867fS21NXbXpI0WJjbP1buy7EJBctVhXRzGgGdwqkU
 nn1ZnjzBXnOYiCD1wGcHdVicLV1KFo3/T4f8E7vSKZKmoTWws3nbl3T1zve2bezqPzNy
 js0oK/TPfmnp/lkxjEMxQHqn1Vf13xTDJBNvz0qvC7zhV5T0L6tNeklCSsX725J6bNPg
 ImL6a8w6CrV0v6gSZNZrLw6g6VcnPbj1pbdOIIVpGR7aRRt3PKPvaFth18OANI8xuRs0
 JEraPediYARGd+rY1bHlEVqbiSTjlZrex2a9AmCARtMfnc50nfS2dA9YeuEHi6QN1JxE
 rUQg==
X-Gm-Message-State: AOJu0YzDjpgFYkuEj6akXlpj1Tnmd5StmmbHdpcyilKlYGl+K0uWFdmq
 IVWOizYiQzWPG/Zm2/FXD+NX3SX/qGq/1lr/d+CmJj8b7muGKKCtWi0npO1vpmiU8WqkLfkJteh
 yXxxG3Lx1mTr+mXB8PIT5eyBuz46DjY4=
X-Gm-Gg: ASbGncsI+gQDPJ+pseuLmtj7O34IxKTHt5mblcsynez3DLl8HQtoyF7rl++JcXco5iw
 rPMlDXeiuWOooWzSKW78Xiq/NYoZQpgrS28MdUh2/zYGPDZTEFsoT0JoRVW6qEOGszOd58IhQDh
 Tqqc8dEfC1crWv8L/j8m0ofyukvGuGfIMWXEu8W30RDTvA3a0tnGsngVYFYig2/GKe5rKfYf4QB
 6BEqgPUMdxvFdqQqVtp5Hg5hr4ok3l7gmpfwdZvYSS5GSqxOsCE5mEoQRo=
X-Google-Smtp-Source: AGHT+IH2cxhqsNJcdVbhTbUsWH2nZZBwMUKE2oNg2maqsfVvsdIoD5kisDCcVnkUBT46Eu3LsmSQVC0cYr7srytr7Ls=
X-Received: by 2002:a05:6122:4688:b0:559:65d6:1674 with SMTP id
 71dfb90a1353d-55965d61dc8mr1831062e0c.14.1762223455699; Mon, 03 Nov 2025
 18:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20251101064907.5037-1-hs@nabladev.com>
 <20251101064907.5037-3-hs@nabladev.com>
 <CAMDkj5w4uwKFJwoSdM2CnG4-ewH3V5X0ZW3jk1MCNH+Bdg+j3A@mail.gmail.com>
 <076c5537-3613-38cb-8d7c-e56a89f903aa@nabladev.com>
In-Reply-To: <076c5537-3613-38cb-8d7c-e56a89f903aa@nabladev.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 3 Nov 2025 21:30:45 -0500
X-Gm-Features: AWmQ_bnDlyAZjInkToSTCMitii_fSudhvfj1qdegtk4j9-vTjYfj0y4Ve0NZHjA
Message-ID: <CAMDkj5yUcnyJXvyCZdjVWyMGDCAaiDWoTieMOdTpFEOt_JQMrw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] lib: implement SM3 secure hash
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
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

Hi Heiko,

On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wro=
te:

> Hello Raymond,
>
> On 01.11.25 18:11, Raymond Mao wrote:
> > Hi Heiko,
> >
> > On Sat, Nov 1, 2025 at 2:49=E2=80=AFAM Heiko Schocher <hs@nabladev.com =
<mailto:
> hs@nabladev.com>> wrote:
> >
> >     Implement SM3 secure hash algorithm, as specified by
> >     OSCCA GM/T 0004-2012 SM3 and described
> >     at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> >     <https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02>
> >
> >     code is based on linux commit
> >     f83a4f2a4d8c: ("Merge tag 'erofs-for-6.17-rc6-fixes' of
> >     git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> >     <http://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs>")
> >
> >     Signed-off-by: Heiko Schocher <hs@nabladev.com <mailto:
> hs@nabladev.com>>
> >     ---
> >     This patch drops a lot of checkpatch warnings, ignored them
> >     as tried to stay as close as possible with linux code.
> >
> > MbedTLS also supports SMx, can you turn on the SM3 option in MbedTLS an=
d
> make it selectable between
> > lib/sm3 and MbedTLS via Kconfig? Just like what we have for other
> algorithms.
>
> I must admit, I have never used MbedTLS ...
>
> [u-boot]$ find lib/mbedtls/ -name '*sm3'
> [u-boot]$
>
> So there is no sm3 header or c file...
>
> [u-boot]$ find lib/mbedtls/ -name 'sha*'
> lib/mbedtls/sha256.c
> lib/mbedtls/sha512.c
> lib/mbedtls/sha1.c
> lib/mbedtls/port/sha512_alt.h
> lib/mbedtls/port/sha1_alt.h
> lib/mbedtls/port/sha256_alt.h
> lib/mbedtls/external/mbedtls/library/sha256.c
> lib/mbedtls/external/mbedtls/library/sha3.c
> lib/mbedtls/external/mbedtls/library/sha512.c
> lib/mbedtls/external/mbedtls/library/sha1.c
> [...]
>
> But I find for sha* ... so I am unsure what you mean now, what I
> should do/change?
>
> My bad... The supports are still in PRs, not part of the main branch.
So I am fine with this, we can integrate the MbedTLS missing part in the
future.

Regards,
Raymond


> May this can be added in a follow up patch?
> Maybe you can add this part?
>
> Thanks!
>
> bye,
> Heiko
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
>
