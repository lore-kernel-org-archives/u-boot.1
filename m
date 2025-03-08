Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E686BC282EC
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 03:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECBE8043C;
	Sun,  9 Mar 2025 04:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="HbAoLhBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7614C8058A; Sat,  8 Mar 2025 18:37:01 +0100 (CET)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B3180050
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 18:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741455416; x=1741714616;
 bh=+S5T1v9RdKydyrHTdWzQsXF/yI3UmGGyR2JPgAwngRg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=HbAoLhBPIq0hCPfILeHaJgDI6W5CQAfuh1LkPm23PRTkrvChnABoM9EZHyuzeaefv
 v3Cqd53cvDFT9qEp6YnJe/jnAlLb07rW9Zb8oXlUvOnyYtcZvWl/A4kML6uX7F1TdL
 RnEGZdlhnsirxQ9f6qNTtwOQBtLM9KCGGF2KIb3IcC96TbLRj+U+GkglY2m/AoNnOR
 ym1HgfCK04m2KWy6Dnq/Y7XxFpoET+Sx33MaqJRbD5zvSFBtQdGtK9Btc4LeaUl0SR
 /GjtSOwqgT9ZPTiqpJg5I8MxaF8CJKmbUM1sRX0caxDeDWh0xBvCQhDUdmEiw4lAMj
 GDkrXer0qnRgw==
Date: Sat, 08 Mar 2025 17:36:53 +0000
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
Message-ID: <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
In-Reply-To: <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 8294f5f1ebb33e9dc0109fc76eebfcf663dbaa25
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 09 Mar 2025 04:25:43 +0100
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

On Wednesday, March 5th, 2025 at 12:20 AM, Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>=20
> On 3/5/25 09:13, Sughosh Ganu wrote:
> >=20
> > Can you check what is the address being asked for in the
> > lmb_alloc_addr() function.
>=20
> maybe also add a call to lmb_dump_all_force()

Thank you both! This was exactly what I needed. This appears to be
a kernel bug in randomalloc.c which always breaks out of a loop
after only one iteration[1] which is unlikely to be the intention.

Ben

[1] https://github.com/torvalds/linux/blob/master/drivers/firmware/efi/libs=
tub/randomalloc.c#L133
