Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BFBC28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E2380F0E;
	Fri, 14 Mar 2025 06:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="axYNZtpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8432380F9C; Fri, 14 Mar 2025 00:20:18 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FEC58007D
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 00:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741908012; x=1742167212;
 bh=jbYKeyj6+HbsN77e54ckQUc1Vw9VL+TEqicwsJ19FHo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=axYNZtprK8aBbUPveZrD51ni3HOJim9omJTuhiZJGJcorCemvNE3OHPO3mws3+NC8
 R+mam4KUm4M4bV3vUJNuynR1nWj/9tJtfxelYQPPFzyDtkVh5b/OrtwqEeuUmlrd0P
 xgMu3ZNGF3xkf32XK6bccHaL9HnVmOrokq6PXj/zDRldcCL12SvZPi8nXS5GG2CVfH
 Njim+YlnXoDq/F/ztFlMs/61OvQVE784sv0jXf5O4ZcKbjtSvpXvbMmPqvdHCnuTSP
 qi45nLBpbiTQsnvD1Q4nRrmD6BNDCz396XthiyIEr3yT/c/QMU2iih9rdhYgb5vRoa
 IdDrq1xX7SazA==
Date: Thu, 13 Mar 2025 23:20:09 +0000
To: Ard Biesheuvel <ardb@kernel.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
Message-ID: <liIpk-rf5MT1ndPhbZRBXLvYYm7vGI3VC8KWAV-LPYu_Xw8wYlkuJdBjRY--CslBe6IicflH_unJefkWdhvOpNiTpseLHi7qSoiR6BTqfcU=@bens.haus>
In-Reply-To: <CAMj1kXH9=4dk94SKy38AQWpSiJZPRMxrZ6dGzo6b1XWiV7Qrdw@mail.gmail.com>
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
 <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
 <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
 <CAC_iWj+R9VA9vNGM=R-UwJCDJ=t9Wa1A28Om4tAX48MmpnKcxA@mail.gmail.com>
 <si98ZC92YWJExsBQWbCusXzfn_jNmQuszo7DUC1pjA6gx-9vhr2Viu07oL9sdNDBWAYMFKEW_MQyCZqLpLWiU6q90_afofYyie74RiJhFCM=@bens.haus>
 <CAMj1kXH9=4dk94SKy38AQWpSiJZPRMxrZ6dGzo6b1XWiV7Qrdw@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 418c8f93eaf0e84cf45105c071160356bcf73b3a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

On Thursday, March 13th, 2025 at 11:11 AM, Ard Biesheuvel <ardb@kernel.org>=
 wrote:

>=20
>=20
> On Thu, 13 Mar 2025 at 18:27, Ben Schneider ben@bens.haus wrote:
>=20
> > Hi Ilias,
> >=20
> > On Thursday, March 13th, 2025 at 2:35 AM, Ilias Apalodimas ilias.apalod=
imas@linaro.org wrote:
> >=20
> > > Can you apply https://source.denx.de/u-boot/custodians/u-boot-tpm/-/c=
ommit/b04e708c615c15423ffc80d73430bf2d36fb7c21
> > > and see if it fixes your problem?
> >=20
> > With this patch applied, efi_zboot_entry() appears to proceed to
> > __decompress() using target =3D 0 (first entry on my device), but
> > then I get the following messages:
> >=20
> > EFI stub: ERROR: EFI decompressor: Out of memory while allocating outpu=
t buffer
> > EFI stub: ERROR: EFI decompressor: Decompression failed
> > efi_free_pages: illegal free 0x0, 0x1140
>=20
>=20
> Seems like the compression code gets confused by a buffer residing at
> memory address 0x0.
>=20
> Could you try the below please?
>=20
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -75,6 +75,9 @@
> if (align < EFI_ALLOC_ALIGN)
> align =3D EFI_ALLOC_ALIGN;
>=20
> + if (alloc_min =3D=3D 0)
> + alloc_min =3D align;
> +
> size =3D round_up(size, EFI_ALLOC_ALIGN);
>=20
> /* count the suitable slots in each memory map entry */

That did it! With both the patch for U-Boot and this one for the kernel app=
lied, everything works perfectly.

Ben
