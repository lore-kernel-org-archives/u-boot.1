Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCEBC7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 09:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D1882977;
	Thu, 26 Jun 2025 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="jwSHsq7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8D982D83; Thu, 26 Jun 2025 11:23:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7989480E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750929805; x=1751534605; i=fiona.klute@gmx.de;
 bh=X9JHnqc/ngGZc3gFqvUcVpF73GSGx2mmviCn3EvCg3o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jwSHsq7wWAC83Ymuyoz7hg/AeVOU/IemRMGUlVhFzwKnkwqzsSTPRi8t/gc/i+T6
 0I8TT5d2970Rvda/4hiX3mMeS94reJ55ED5Q+n6xlQSSeFkvSY4HSOMs6DxayWEvS
 ff6K1rH+tpshGn0DoXA4IrKogM14okV31QfeQqlGAfQVFaUrJWNP1AjxH2ptFgyxI
 LH+ZtlCuVwgv/9kUV43VEjbEjAhSFF6/av21/Sur1uFkj5PgtSDUKu8P5SPE7j2Ee
 2wZemKUj1+iu4u7tOuCX42jGJQD0J+af5xzXxtXw0Yt9OmejBzMEvzploG1WInAJB
 QGdkIQtRqmA/hGXnQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.164.90]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1uwuAs3MtC-00nkG9; Thu, 26
 Jun 2025 11:23:24 +0200
Message-ID: <7de86b29-7307-4b2b-b153-fdeaf58e0ec7@gmx.de>
Date: Thu, 26 Jun 2025 11:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: mention that extlinux.conf can use environment
 in "append"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250623113801.2655669-1-fiona.klute@gmx.de>
 <20250623150434.GC4003484@bill-the-cat>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <20250623150434.GC4003484@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWWvSU/9fU+acCQhKuDkB2sT825Sm5ehfyMyt+UU+R/DvYScshB
 jZ7iqPQ7w7muIYa0iytheYo/TbPXfsSkXY2o8jMSoL0B2maqZFbh6q+Li4fIajmeyluZzcn
 A6g+3LruVQrADZXpHxwqThZFFHy9x4kIFo+n2NEZFjLhnBnmaXqe1Ew6v2XA1V4D+vSWmqu
 TUOly5QQ/6SmN+1Rhk02g==
UI-OutboundReport: notjunk:1;M01:P0:4lYXmG7x0zM=;hMb1N9sJMwC3biRki++fhJav8ZA
 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
 lA4OH77aiZ85q/SPhB3aGk0=
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

Am 23.06.25 um 17:04 schrieb Tom Rini:
> On Mon, Jun 23, 2025 at 01:38:01PM +0200, Fiona Klute wrote:
>=20
>> This option is very useful for A/B boot setups with read-only
>> filesystems: Letting U-Boot fill in the rootfs (and possibly related
>> parameters) allows keeping all boot parameters except the actual slot
>> selection in the extlinux.conf file, where they can be updated easily.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   doc/README.pxe         | 3 ++-
>>   doc/develop/distro.rst | 7 +++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> Thanks! Any chance you would be willing to convert doc/README.pxe to rst
> and call it say doc/usage/pxe.rst ?
If you mean simply reformatting, I can probably do that. A review/update=
=20
beyond that would be beyond my time & expertise on the topic right now.

