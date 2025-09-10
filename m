Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D8CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 19:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416708319C;
	Wed, 10 Sep 2025 21:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="YsbjutEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22DC083236; Wed, 10 Sep 2025 21:42:05 +0200 (CEST)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C940C830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 21:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757533320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRe/js1RVy71kQm7bdvq8JeWm14tOdR0CD39njSXRJE=;
 b=YsbjutErAwSBbrL9KhLf2KUvT2VEwSt6HtGU7VKes64FdBgmSJex2dI8lBJFra1cUHs8yB
 c5ikS0gKBLEUYZmRnG9f69qEuJrfWvgKY2DPu1bOHOu+5GTW6wzi8cxctK/3BBLhDWaZFJ
 plp2Rfz4s4lInCk9fdKV7YoN7JgHmr2PnXTGN+6oXmLHgrSZ/UAgpF1DiMXmjt3wKD3xLw
 emE8KxsBQKXzx7YuP3u7CwOQPkQfAucs1kPIZLfn97tMMRPz2ZjlTvKTb7u26rHxVZR0Ry
 KypbefMte7xGdk1rwSvXOGZvacDoLb9QtXdpAx0OelZALfXRC1iMUTNgUja4jw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 19:41:54 +0000
Message-Id: <DCPDKAEDSH5Y.2CBK1ZYOKLSOX@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Tom Rini" <trini@konsulko.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 1/9] tools: mkimage: Add Amlogic Boot Image type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Ferass El
 Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-1-37395d9ff5af@postmarketos.org>
 <52510c5d-e4f5-47f4-9246-d13a5580958a@gmx.de>
In-Reply-To: <52510c5d-e4f5-47f4-9246-d13a5580958a@gmx.de>
X-Migadu-Flow: FLOW_OUT
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

On Wed Sep 10, 2025 at 7:36 PM UTC, Heinrich Schuchardt wrote:
> On 9/7/25 16:36, Ferass El Hafidi wrote:
>> From: Jonas Karlman <jonas@kwiboo.se>
>>=20
>> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
>> Amlogic AArch64 SoCs.
>>=20
>> Images can optionally be signed for secure boot scenario, however
>> creation of signed images has not been implemented.
>>=20
>> Example of how to use it:
>>    # Create an amlogic boot image
>>    tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin u-boot-amlogic.bi=
n
>>=20
>>    # List boot image header information
>>    tools/mkimage -l u-boot-amlogic.bin
>>=20
>>    # Extract amlogic boot image payload
>>    tools/dumpimage -T amlimage -o bl2-payload.bin u-boot-amlogic.bin
>>=20
>> Or with binman using something like:
>>    binman {
>> 	u-boot-amlogic {
>> 		filename =3D "u-boot-amlogic.bin";
>> 		pad-byte =3D <0xff>;
>>=20
>> 		mkimage {
>> 			filename =3D "bl2.bin";
>> 			args =3D "-n", "gxbb", "-T", "amlimage";
>>=20
>> 			u-boot-spl {
>> 			};
>> 		};
>> 	};
>>    };
>
> Thanks for adding the Amlogic image creation support to U-Boot.
>

yes, thank you Jonas. :)

> What is the basis of the patch?
> Documentation, reverse engineering, or existing code?
>

There has been a lot of reverse engineering in the past.  These days the
amlogic image format is somewhat well understood, enough to build an
image and get it booting.  So there are various external tools that aim
to create bootable images, such as gxlimg, meson-tools, meson64-tools,
etc.

Jonas wrote in his cover letter:

> The amlimage type and the eMMC relocation workaround is loosely based on
> my prior work, aml_chksum, a small tool that can write boot image
> headers with updated offsets and checksums, see [1].
> [1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a6b=
df0024b718f

Thanks.
