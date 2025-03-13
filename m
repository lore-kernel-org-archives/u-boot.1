Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11E5C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 18:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84CB880F9C;
	Thu, 13 Mar 2025 19:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="AgrGrwv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1325380FF7; Thu, 13 Mar 2025 18:27:46 +0100 (CET)
Received: from mail-4022.protonmail.ch (mail-4022.protonmail.ch [185.70.40.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E8080756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 18:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741886862; x=1742146062;
 bh=Nlm65DW1Az+di/DbfNridKVdRhc8eeL2R9Q6ssAjm7U=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=AgrGrwv/LnHNChuXfIxwI8yqiH3Itlgx20T0KYJdLwxXDzciEDYxOAoeBywxsB5WH
 7uWq6l0XBNnlVHPHczPKZ0DZ0RI4QxRQ0sZBcIb8oqF2SWJ/3qLNhzd8w/Kmzo5pFM
 ztJrKP+x23C086MC1xaRFa6En+TfL32k62NnLe75E7rMu4NXkBoowSNSsRu/Qr/oU3
 v5e/sd1h75OGIYZCeJZZ2Q34Bkr8Er1Pw9gpbFPcJZy/l0161nfU46BSEsV0D45Xma
 p/YV1xNBR2Ls69i5KOGN31aTfeRksy/7S9re5TYOx69Se/udXH2Zh3Qzy1NYgI0csG
 NGl6UzlBvxenw==
Date: Thu, 13 Mar 2025 17:27:35 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
Message-ID: <si98ZC92YWJExsBQWbCusXzfn_jNmQuszo7DUC1pjA6gx-9vhr2Viu07oL9sdNDBWAYMFKEW_MQyCZqLpLWiU6q90_afofYyie74RiJhFCM=@bens.haus>
In-Reply-To: <CAC_iWj+R9VA9vNGM=R-UwJCDJ=t9Wa1A28Om4tAX48MmpnKcxA@mail.gmail.com>
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
 <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
 <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
 <CAC_iWj+R9VA9vNGM=R-UwJCDJ=t9Wa1A28Om4tAX48MmpnKcxA@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 6a0f223de10e969fc7acc3e3f53a55a0c6048ade
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Mar 2025 19:33:27 +0100
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

Hi Ilias,

On Thursday, March 13th, 2025 at 2:35 AM, Ilias Apalodimas <ilias.apalodima=
s@linaro.org> wrote:
>=20
> Can you apply https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commi=
t/b04e708c615c15423ffc80d73430bf2d36fb7c21
> and see if it fixes your problem?
>=20

With this patch applied, efi_zboot_entry() appears to proceed to
__decompress() using target =3D 0 (first entry on my device), but
then I get the following messages:

EFI stub: ERROR: EFI decompressor: Out of memory while allocating output bu=
ffer
EFI stub: ERROR: EFI decompressor: Decompression failed
efi_free_pages: illegal free 0x0, 0x1140

Ben
