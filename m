Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4062CFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA78848B8;
	Tue,  5 May 2026 14:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GksqgwTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42033848B9; Tue,  5 May 2026 14:13:37 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F497848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651d692e833so5321528d50.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777983212; cv=none;
 d=google.com; s=arc-20240605;
 b=O2p2cLDG0LJ2YGH4YBV7qySSaelWR1JCq2g4Doc7ETPvBW/YaWOqmXk7cctOEhlbJd
 cylzpjySczcnuHSIMKE8Nw58/Z3O4T9WEqVtuttsFQZtjnrOOnfgZmE51vn/q13aqfdN
 pQ7z4Eg/lOA+5YKvudooWj1bzXx9naoxi3iOcZMniu+r9vprZOBMCeauAjtfd0kmos19
 C9LrLy7bQFOf0DQ/mgliYeDHdraDMqef1nV1O8qUmbino1G8jKNfxHpkue3fvSJwdVD3
 O64PxwRZbgF0SnpdvydMb4hXD5KXuvf1/sr3Yf12vqT1W7cxV6ug278IR0m/ML0Puo4t
 bSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cYGNLDzMFFv9F1LUbBFMx+R6kAETonrsBOy3oJjZMsI=;
 fh=m841BrIP82hm+nKCOo6D6Gi8sbFoQj/QTSuKMMLkn10=;
 b=asIoQ4IXg2iBgLgh3ZIJ1AkTh3Kijc8EtWd88xyBDIdPzpXNfoC2WXogUSvDQFtcny
 bvxEM/tsgjQtKVPCpHvXi6F94BlbWEWIpT8XgQBDv0/EiRvwRAktQEutdKI1xO7xbCzi
 3AalGhahSVCPAqai/YVM8nCAy0swW+dTh2trkij0ff40EJuYY/hc4jL4BC8Y9Gd9DfC7
 mZRB7siXT7bD+B/eSCuvK/BcPwuJraNmb9dUJb5mvbleYFZ7f4D4SOcwuwaPuTBP6qaz
 eCo5ZX5AisSG4zrCbvGb7jKEpa49XD9g0CXID1MAzfinynWTN3lh2dupFRmscxqfr+95
 P+YA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777983212; x=1778588012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYGNLDzMFFv9F1LUbBFMx+R6kAETonrsBOy3oJjZMsI=;
 b=GksqgwTdV5WC/Uwo2WZxc1PFVYxljfJD3TqOugi+M9OkfFe/WaGblojTAHup996sSd
 7KsagR+mAZr8KD7caK0grSzvP2LK6lSV1YVq3jfZnj626eD8CYix2lmPk6l0APMFBmFo
 sCuCbmFiITeZYlC/32TxnF+WQqBsVttQn91sXMRssrsZLFPFbpDhyrb595aHCzEOMh/y
 TjZQdcV01Pjr0l9/QfPxa551uadqzmfW52xrZqhFxTu/mhgLReuDYcJY4d5g1oRB3BTa
 oPuS/791KLbtvlvMxjE0LYzS05+rp9OOnrLjc9uqHz25YcJWkwLheBEdfGey9tgj7wFX
 8pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983212; x=1778588012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cYGNLDzMFFv9F1LUbBFMx+R6kAETonrsBOy3oJjZMsI=;
 b=gEgDkdnEXqrPZxOTwTwGoweUGIoNZY3IFmK4xZCxHThONb7m4C2fN/xnLKW0/an5AP
 1My/cnsA1f0/8DlXRAgw+H0U6WIOKExta2M5oZDJ0z8lX9GuM8V1IdKdBC6m+jKHqrk6
 wjo2/8B5hL8MpEg5co88Q4pMJ/XCuPsHbLAjGOGyUmchqFRwuen803N9OoyTHmsFt5Ps
 5ksfc1HCs1lbbUbf4XQL1pclwODQ6Qe6yHDgc95cBu/jBT/TDBnKTESEgY5elKdiid5a
 G6LNB775MAW4crfnEvNRBu/By+1BkJZ17N5Bp5uCsa6qC3SijYDq9Uv1PrxHMyh8dTJz
 ruvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nLm2d+F+uNwPZSXlMDWqFzobl4h5XnyO4fo8SWdcO9H0ziiFx5nRWq113N5Ocliv4GRIW1NA=@lists.denx.de
X-Gm-Message-State: AOJu0YxT1xm1mOJm3p42GWrPbfIJZcnFIzSBO+5JW/wccFIH6H6dEFpk
 iqri6HC2ijBS7xWEUm/3MlE46b72ZOxXnDSWKfqDfWOMgM434vpqJWISOal+3gEeJQMFU5AIZJT
 BgWMh/75p5YPqmyS63Q4xQ0GXOT1r5tlfoWhGENgziw==
X-Gm-Gg: AeBDiesDT5Z62qDqsV6m9A4gbVbR6iwyMUrvRZN3QHrYRDm2azupQ9NfzREe7B6gIFU
 esuhEsQfqtDPD2i/vWb30iDq363DzZo32GMsIhnd2YZ4MCUdUenZ98+7VjYhFFwdq+kP0A7aH8Z
 tmGN1AX1sInyKCOB83mx63YOsuLaxmI3UVtnxdax+3BTzHAtIL080CPodUHAGke3qXK1sYe/Ojd
 AqMRPd94Ny9kv5HBjaOAPtueJn5MzNjHXgqGSaANZqHxR8eMSXXdMzlus1ZgMmZ0gdFH5VAGrp+
 Mh3/D4aBl6gXBKh8thKlw9WPFZXb12+GQ/27wBkfz2l+XnDlcTnhdwrBxPXX054E31IUfLTaUYv
 +SsakkfnwFoXGRfXGl2Q9u4odCIbVmHHajGdFEMx3gLWj75S5yjaPtnhdlgv7h4dkMlbfXS6v1s
 Q4/LXeaNM1AhPx7Qto+958LI9o5z4AKF3UGE8bY2hokq/KJ2ciAV0Fl2QL7wdlQ6OdNAJp3L4fB
 vxu47/y2zDJFGj4s5Oz/D9JEtGKX73WfD/jmCjDcvYsuVaUACefwP/ssPKgPpb22lz3vHEo6cHP
 Mpxodu3K9uw1ytKN6580yIFmo7TYioGrVpEk+wGi21IR9ZunXkn0MX/bA/vTRfxuEpfNl6mNUCK
 3RXTr0GbZa9Zb3gNW
X-Received: by 2002:a05:690e:d0c:b0:650:35b1:b16c with SMTP id
 956f58d0204a3-65c3d9726aemr13003727d50.8.1777983211959; Tue, 05 May 2026
 05:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
 <CAC_iWj+iD0m9JL+A++W85+sYQGYSqVHP287ga7g13dkVevy9AA@mail.gmail.com>
 <28B9184F-96D7-45AF-84AA-98EB2ECE713A@gmx.de>
 <177764628159.1446310.9289654256628987669.b4-reply@b4>
In-Reply-To: <177764628159.1446310.9289654256628987669.b4-reply@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 15:12:55 +0300
X-Gm-Features: AVHnY4IcRe7PIOpTBpLALF8Yp37o4bQLCic1Mw8LNx2v4cRPlaO4UNp8mvLiInE
Message-ID: <CAC_iWjK4yWwWGUuVXqpsgD9s7RC6KxyfiLmTw-qKa+iqOT+oDA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix AllocatePages overlap status
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com
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

On Fri, 1 May 2026 at 17:38, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-04-27 19:04 +0200, Heinrich Schuchardt wrote:
> > Am 27. April 2026 17:48:21 MESZ schrieb Ilias Apalodimas <ilias.apalodi=
mas@linaro.org>:
> > >Hi Harsiman,
> > >
> > >On Mon, 27 Apr 2026 at 18:05, Harsimran Singh Tungal
> > ><harsimransingh.tungal@arm.com> wrote:
> > >>
> > >> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS overlap
> > >>
> > >> When efi_allocate_pages() is called with EFI_ALLOCATE_ADDRESS, UEFI
> > >> expects EFI_NOT_FOUND if the requested address range is already
> > >> allocated or unavailable.
> > >>  U-Boot currently returns
> > >> EFI_OUT_OF_RESOURCES when efi_update_memory_map() detects an overlap
> > >> after a successful lmb_alloc_mem(), which does not match
> > >> EFI_ALLOCATE_ADDRESS semantics.
> > >>
> > >> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS requests that fail due
> > >> to an overlapping EFI memory descriptor, while keeping
> > >> EFI_OUT_OF_RESOURCES for other allocation types.
> > >>
> > >> The UEFI specification [1] specifies that
> > >> EFI_BOOT_SERVICES.AllocatePages must return EFI_NOT_FOUND when the
> > >> requested address range is unavailable or already allocated;
> > >> EFI_OUT_OF_RESOURCES applies to non=E2=80=91address=E2=80=91specific=
 allocation
> > >> failures.
> > >
> > >Where does the EFI spec say that? EDKII indeed returns EFI_NOT_FOUND
> > >for AllocateAddress but looking at the function description, I can't
> > >find anything specific.
> > >
> > >Thanks
> > >/Ilias
> >
> > Thank you Harsimran for investigating this difference to EDJ II.
> >
> > The spec has:
> >
> > EFI_NOT_FOUND
> > The requested pages could not be found.
> >
> > and
> >
> > EFI_OUT_OF_RESOURCEST
> > The pages could not be allocated.
> >
> > Looking at the text one could assume that EFI_NOT_FOUND should be retur=
ned if the pages requested with AllocateAddress don't exist in the memory m=
ap.
> >
> > If the pages exist and are already allocated EFI_NOT_FOUND does not loo=
k like the right return code according to the spec.
> >
> > It is unclear if for AllocateMaxAddress a comparison to the memory bott=
om is required.
> >
> > The specification should be clarified in the UEFI forum.
> >
> > Best regards
> >
> > Heinrich
> >
>
> Hi Ilias, Hi Heinrich,
>
> Thanks for the clarification.
>
> You are right.
> The AllocatePages() text only lists the generic status codes, and it
> does not explicitly say that an AllocateAddress request on an already
> allocated range must return EFI_NOT_FOUND.
>
> My motivation for this change was tlso he UEFI SCT expectation rather jus=
t a
> direct statement in the UEFI base spec. The SCT AllocatePages tests expec=
t
> EFI_NOT_FOUND for AllocateAddress both with non-existent memory and with
> allocated memory, and that is the behavior I was trying to align U-Boot
> with, which matches with EDK II as well.
>
> Is this solution acceptable for now?

Yea, I am fine with that and the patch is fine, just tweak the commit
message a bit and mention exactly that. That's it's unclear from
reading the EFI spec, but we are better of doing what EDKII & SCT
tests expect.

Cheers
/Ilias
>
> Thanks,
> Harsimran Singh Tungal
> >
> >
> > >
> > >>
> > >> [1] https://uefi.org/specs/UEFI/2.10_A/07_Services_Boot_Services.htm=
l
> > >>
> > >> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com=
>
> > >> ---
> > >>  lib/efi_loader/efi_memory.c | 4 +++-
> > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory=
.c
> > >> index b77c2f980cc..63cf1a7277f 100644
> > >> --- a/lib/efi_loader/efi_memory.c
> > >> +++ b/lib/efi_loader/efi_memory.c
> > >> @@ -510,7 +510,9 @@ efi_status_t efi_allocate_pages(enum efi_allocat=
e_type type,
> > >>                 /* Map would overlap, bail out */
> > >>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> > >>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
> > >> -               return  EFI_OUT_OF_RESOURCES;
> > >> +               if (type =3D=3D EFI_ALLOCATE_ADDRESS)
> > >> +                       return EFI_NOT_FOUND;
> > >> +               return EFI_OUT_OF_RESOURCES;
> > >>         }
> > >>
> > >>         *memory =3D efi_addr;
> > >> --
> > >> 2.34.1
> > >>
> >
> >
>
>
