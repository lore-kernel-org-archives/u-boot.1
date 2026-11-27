Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63957606A32C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=afRH1GhD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=eBvlRZXn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E56DF60A6A;
	Fri, 27 Nov 2026 03:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CuN6m2tKwb5; Fri, 27 Nov 2026 03:39:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF5DC6071D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795750781;
	b=RmFnIS+zaKFPNclQQfMhAyogP81NRrplbusjMOrmkGsUxKxBvEv/co9jL3MMJnYsw2lz
	 hk4qfoVN9yabSp8KC38iVqqxlL89bvMDVKUQhU7nfyYCkt/Wkyr1+NBc9JVyd+58XqAOM
	 vc6g04TUIa2GU8GPcdpcsN+8WvLTnMu82AGOZ3BXOYzeizTpLMAIlWj8Qbz5ImraF4Af6
	 H8Lr77fE/zQqLJDI/Ik96XEarG0oUq9DEUIP7obBcI0fBActeh23GRmLueLyhaQrx/L+g
	 EJXevaehS4tz4OPeVtEqL5NbKjiJWEDbf+nHsp7MCul/7a8aUzsKkj9ExDISc4/2cZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795750781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uKCi7vXX3hNBiR/s4qynykfXoIGr6QFBtVn2fy1U3S0=;
	b=T8Ih3+KXDsBB6qhbA1U0C8Z8UlWa+cf1di+9qZTPWRfP6JZzATlLx5vbu2lSp0W1FiTF
	 TgevGCbQwS8Y6fh0dAFz5n9gR4YDqFiLh6i+gZJF7BBFK3o9huE0Yh2CtC9abibz9wbZk
	 mJcRUT5ZphIyy1bdbsgyYoCZtZ/iblDLa01z6RUo9oBxfwzDxWk/pqEPUJze8a9jGdJYg
	 fDAqHuGkhaCfxCQmPupWH2CTYEnsyFF01fKh5p8ZuLtWGjWsgUmgi5n50nF5Szam5R3N1
	 K7PfUIx5qfPflCgmLKXFjK70w5xMGkmtJSWNy1Wl3QffbDHrwHVAczaob78wenabhbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795750781;
	bh=uKCi7vXX3hNBiR/s4qynykfXoIGr6QFBtVn2fy1U3S0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afRH1GhDaJTnmpJImrdENUynPqHW/LuysxR/b0ZXHUdohcQBKiwianDXH0MWMMwaO
	 aHGO83mJdgvE/CY38jDmXXcQLCWtbX+QlavgciQfn7H+xspuMWYDKmk1EKWD2QR2u6
	 mCJhXt/UTTwyRHdsxKPqk6K2TnUYU6ZhSRnGtGiFebvMX5QGu+JVqX0dlhGJMf49Ry
	 bMe/EbzGYNAZIZDN5W1SXzJ/OByItjDNcVrXrKCdzvPJju76Iy5678fTnm3fOW6lpT
	 3ikMlQs/Ovd7flpe6pBSck3Kjh0nkS1kJGi4acG6Ad2h/IhYjIDj8NB63ua85VBW3q
	 MVlEU8gbmsEHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF5DC6071D;
	Fri, 27 Nov 2026 03:39:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A3F3266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FCBC8116C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UoOLCWyU1trU for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 03:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F149810DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=eBvlRZXn
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F149810DC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:39:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=eBvlRZXngZQhANOUp9dmTdP/vhEaHnREhnGi/zj+oAJYF84cTnnIvanDRDNipyoroPSwn4rWlZiE+CZMxoHXi6XK/i/IGdrLFTUGVqAxW59XbMY1ua5zRZyU3Y5mFsr2cvQZWGXDdopCtAWimDRz3fYXUqwWqb+//cXMbZeFclY=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=uKCi7vXX3hNBiR/s4qynykfXoIGr6QFBtVn2fy1U3S0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795750728235316.0641858763453;
 Thu, 26 Nov 2026 19:38:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 11:38:36 +0800
Message-Id: <DN5OI2G4C1U2.103YTJGESLMES@pigmoral.tech>
Cc: <u-boot@lists.u-boot-project.org>, "Yao Zi" <me@ziyao.cc>,
 <u-boot-spacemit@groups.io>, "Tom Rini" <trini@konsulko.com>, "Yixun Lan"
 <dlan@kernel.org>, "Tim Ouyang" <tim609@andestech.com>, "Leo Liang"
 <leo.liang@sifive.com>, "Huan Zhou" <pericycle.cc@gmail.com>, "Eric Chung"
 <eric.chung@riscstar.com>
Subject: Re: [PATCH 2/5] riscv: spacemit: k3: Add SPL initialization support
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "E Shattow" <e@freeshell.de>, "Anirudh Srinivasan"
 <asrinivasan@oss.tenstorrent.com>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-2-1e60e1d78020@pigmoral.tech>
 <zfl63cgj44hzx23ozxkd43uwvv74wfiuhu6bf6o6su6skzns6u@fp2udqudxmhy>
 <589eed22-6a01-40be-afd1-536662e8c30d@freeshell.de>
In-Reply-To: <589eed22-6a01-40be-afd1-536662e8c30d@freeshell.de>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anirudh, E,

On Fri Nov 27, 2026 at 5:20 AM CST, E Shattow wrote:
> On 11/26/26 13:13, Anirudh Srinivasan wrote:
>> On Fri, Nov 06, 2026 at 12:40:40AM +0800, Junhui Liu wrote:
>>> Add SPL initialization support for SpacemiT K3. Enable instruction and
>>> data caches and cache snooping during early hart initialization, and
>>> provide the timer configuration needed for M-mode execution.
>>>
>>> Initialize I2C and read the DDR part number from the board's TLV EEPROM=
.
>>> Populate the RAM driver's platform data before probing it to initialize
>>> DRAM. Set up the DRAM PMA boundary and record the RAM base and size in
>>> global data.
>>>
>>> Loading the next boot stage is not yet supported.
>>>
>>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>>> ---
>>>  arch/riscv/cpu/k3/Kconfig            |   6 +-
>>>  arch/riscv/cpu/k3/Makefile           |   1 +
>>>  arch/riscv/cpu/k3/spl.c              |  52 ++++++++++++++
>>>  arch/riscv/include/asm/arch-k3/csr.h |  20 ++++++
>>>  arch/riscv/include/asm/arch-k3/spl.h |  11 +++
>>>  board/spacemit/k3/Makefile           |   5 ++
>>>  board/spacemit/k3/spl.c              | 127 +++++++++++++++++++++++++++=
++++++++
>>>  include/configs/spacemit-k3.h        |   3 +
>>>  8 files changed, 224 insertions(+), 1 deletion(-)
>>>

[...]

>>> +
>>> +static int setup_ddr_plat(void)
>>> +{
>>> +	struct k3_ddr_plat *plat;
>>> +	struct udevice *dev;
>>> +
>>> +	dev =3D uclass_try_first_device(UCLASS_RAM);
>>> +	if (!dev)
>>> +		return -ENODEV;
>>> +
>>> +	if (!device_is_compatible(dev, "spacemit,k3-ddrc"))
>>> +		return -ENODEV;
>>> +
>>> +	plat =3D dev_get_plat(dev);
>>> +
>>> +	return read_ddr_part_number(plat->part_number, sizeof(plat->part_numb=
er));
>>=20
>> Add some kind of fallback here in case we can't read the value from EEPR=
OM. You could use the smallest supported value (4G)? The vendor U-Boot SPL =
seems to have a fallback, so this should too.

I've checked the vendor code. It falls back to the first entry in the
DRAM part table if the part number is not recognized. I can add a
fallback to the first entry in my driver for both missing and
unrecognized part numbers.

>>=20
>> Regards
>> Anirudh Srinivasan
>
> Currently the smallest DRAM sizes for shipping products I know of are 8G
> for the Pico-ITX and CoM260. I don't know of any product that has 4G as
> the DRAM size;  one complication for 4G DRAM size as a fallback is that

I think Anirudh meant 4 GiB per DRAM part here. With two such parts,
the board has 8 GiB of RAM, matching the smallest board configuration
you mentioned.

> the default "addr"-named variables go past 5GiB range so that would fail.
>
> -E

--=20
Best regards,
Junhui Liu

