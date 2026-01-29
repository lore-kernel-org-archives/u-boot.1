Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C648D358F6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A6B83CBD;
	Thu, 29 Jan 2026 11:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L841XZ+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B92AF83E13; Thu, 29 Jan 2026 11:09:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2157B83C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 067426001A;
 Thu, 29 Jan 2026 10:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2B8C4CEF7;
 Thu, 29 Jan 2026 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769681354;
 bh=U9dmP6ErwteGxYzDrHoQwqCL91iisX7YuvDSe/NGojQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L841XZ+b1XydW90CptySE96hzsnjeJtrS5oBMN/nmMnsTdkpK1wb1o1owgnZ6wWbl
 OzrQKRvIGS3yNxUAKaptIrcJseqO4Wa+7nPnHYEcdi3RHZX1QQySLLupi7+fKp5Iv/
 SePnczHBSuJn8+lDP93EZbt/2jFU2x/om19nEOsXuQpEglzvEtFlj1EMCg9zm6RVr1
 2GJ9l2Z75JwaoAhDohaNEDX3FPW0q0lSnjt9MwfT54JDSE2RNQrCyeQn+NmJ5X205R
 9ZonxaEYYOJ9w802GDMj8JsXnzs42d0KmgIySAS0VrF5VRsc7RC3LmE5ZXlgFgLjoq
 cAenweYEU1ESA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, Stefano
 Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
In-Reply-To: <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
 <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
Date: Thu, 29 Jan 2026 11:09:12 +0100
Message-ID: <875x8kohmf.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Mon, Jan 26, 2026 at 16:46, Heiko Schocher <hs@nabladev.com> wrote:

> Hello Mattijs,
>
> On 26.01.26 10:48, Mattijs Korpershoek wrote:
>> Hi Heiko,
>>=20
>> Thank you for the patch.
>
> You are welcome!
>
>>=20
>> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:
>>=20
>>> Not for all SoCs the bootloader start at offset 0x0,
>>> in a hardware partition of an emmc. So we need the possibility to
>>> set the correct offset, where bootloader starts.
>>>
>>> Example:
>>>
>>> imx8qxp revision C0 emmc Partition layout
>>>
>>> | eMMC block / partition | Offset     | Size  | Purpose                =
        |
>>> | ---------------------- | ---------- | ----- | -----------------------=
------- |
>>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A   =
        |
>>> |                        | 0x00220000 | 128kB | secure boot signature r=
ootfs A |
>>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B   =
        |
>>> |                        | 0x00200000 | 8kB   | U-Boot env 0           =
        |
>>> |                        | 0x00202000 | 8kB   | U-Boot env 1           =
        |
>>> |                        | 0x00220000 | 128kB | secure boot signature r=
ootfs B |
>>>
>>> imx8qxp rev B0 emmc Partition layout
>>>
>>> | eMMC block / partition | Offset     | Size  | Purpose                =
        |
>>> | ---------------------- | ---------- | ----- | -----------------------=
------- |
>>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A   =
        |
>>> |                        | 0x00220000 | 128kB | secure boot signature r=
ootfs A |
>>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0           =
        |
>>> |                        | 0x00002000 | 8kB   | U-Boot env 1           =
        |
>>> |                        | 0x00008000 | 2MB   | imx-boot-container B   =
        |
>>>
>>=20
>> Why can't we use raw partition descriptors for this?
>>=20
>> See:
>> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-de=
scriptors
>
> Thanks for this hint!
>
> Possible yes ( I must try)... but this will lead in adding
> complexity to scripts people use all over there and needs
> to adapt CI setups, as siemens has B0 and C0 variants.

If you try, please let me know.

Do the same boards (as in U-Boot board definition) have multiple SoC
variants (B0 and C0) ?

In that case I understand it's a pain to add more script complexity.

>
> If we introduce this series, user has nothing to know about
> offsets for different CPU modules as no change in API for
> them...

I understand, and I do like this approach as well. I just don't like
having 2 code paths/approaches for the "same thing".

I am not saying that this is a NAK, but i'd like to iterate a bit to see
if we can either deprecated raw partition descriptors (and migrate
existing boards) or use that everywhere.

I will try to use this series on VIM3 to see how it behaves. It will
take some time though.

Thanks
Mattijs

>
> bye,
> Heiko
> --=20
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
