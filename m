Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC523CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36573836D1;
	Tue,  4 Nov 2025 22:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="aAJ5fmvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5CA8390D; Tue,  4 Nov 2025 22:24:01 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host11-snip4-2.eps.apple.com [57.103.71.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE448004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-7 (Postfix) with ESMTPS id
 88F3D18035CA; Tue,  4 Nov 2025 21:23:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=C5GBb7140CLm+Dvj24H8jVpNQMxCv9DnArpff8R1fhU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=aAJ5fmviQWp4QU/VX2clNH2FQ38+wzK7cVhAxjjox6L7SfPg3wMglATFGh607pa5euOhlbI7XDtKGygXQCIkNxIv8PkhXGUnq0ol/R7GiByrNJkFY9UV6Io40q4P+ULK/TVSvJk8gpgOI1KwVPZHSroLTAdEqA/y/RXCd3S6R4/2tU3ZEASIZ37o2Xbg7feBA10CQA9G7KmNhRGtqcMBDqUzJrkX1T790Tdjq5GdIh3+QEaIRcc7ccDnABbs+fdvnGWfIMbahKnE9zWPYkhJDbzpVSXdnFGBaFzOTwQwlBEydYUfiAflG8dbZ84fcljRYAkTlc3uB+KgXGsw334Wqg==
mail-alias-created-date: 1643268037438
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-7 (Postfix) with ESMTPSA id
 98E481800D2A; Tue,  4 Nov 2025 21:23:55 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/2] Add Radxa ROCK 5B+ defconfig
From: Bryan Hinton <bryan@bryanhinton.com>
In-Reply-To: <fa5080ae-0652-451a-8b71-d90d6fb139a8@kwiboo.se>
Date: Tue, 4 Nov 2025 15:23:43 -0600
Cc: trini@konsulko.com,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <176BBDEC-BC75-4B8C-A9BE-3C070ED33BBC@bryanhinton.com>
References: <fa5080ae-0652-451a-8b71-d90d6fb139a8@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE4MCBTYWx0ZWRfX1cJuLw0Gp1CW
 q1/nFAeJrNMTsjwiD2lS7CPo9D1tm5NIrjgPM8qHu3Nlj2fPoXNyuxeplLBAZxKGIVpNnW78o0M
 G0Wya51Sr3Zm/ffHgsKqEvtNRAdFp7KcfqDSoI7ePRuJYZNG3PiZ0rNAQ0mswOBSnK97jWoPQ6N
 +M9VoaNvR0CegsoiA7pvlHVqHTXf1LU6VCldHkyIMpcBiRrcViKkpSc+McW7TzZKSU02h10fAjA
 7KUUvI+PQqHepc6iIwxM4RuCGjzmfoqiIhMbxrPu6YeNMlvELXxm0lSYtPnPdnJN+uHIjf164=
X-Proofpoint-ORIG-GUID: qvhw0FPSoEmoccZt1yMlu3GbVWfLz-J4
X-Proofpoint-GUID: qvhw0FPSoEmoccZt1yMlu3GbVWfLz-J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1030 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511040180
X-JNJ: AAAAAAAB3wAjr6e3FVCAMCKI75jZIPkH2Vlu6NnKGsEZP0XTWFB92bmfPpgM9Ez0XBZAIQ8obEGiwwmiH8kavln6RwbLZwLYm7qDTnuMpI2TP4Ge312REWZda6oTZuEf3pbjx0fAvXLuadMSvopYzXKVADSY1XrJ+/ec7BZXXryKQyYsfN/jsuCVENrcSoHZtjwSwHI113cqvKN2diLsSxL+0r1iaWmBVeqdPmO7r19rv+T9fjk9sQqu+I8IOHe7hxqF4m+KkaYOUhMkaQTF4ulXbUTxHjN5b4LLhL8vSGEqqmPNlqFr8Zn68ylrVAapJe9umvXCgpUAVesjY+hLDiKlxg20NgWpwVjAPfJRTqMhIMk7s9XP3zFf6rc7mWH6sPiBFmhoVBLWgRhKzYnRO22bzcD/sWKXE+LwYgc3wGh/VmSZvL2sZ+ftpfUpyNBcQW7CJOY7HflMneVRBHdDKksk4bUmkeieJWgJHirMDwjZ93ZjYnjBHp978VczrYCVK9TKlRZvQ2Em86mbUEVouNnDirwje2ZIWHWPtQBkSxVBjxkukCAIDEDix1+khWXxNWbbsAoojK3KXA6T62iAvtYKR1TZ6GtH5OxnciFCCwRX3D0GM8p6svIgrgJELeCr
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


> On Nov 4, 2025, at 1:58=E2=80=AFPM, Jonas Karlman <jonas@kwiboo.se> =
wrote:
>=20
> =EF=BB=BFHi Bryan,
>=20
>> On 11/4/2025 8:43 PM, Bryan Hinton wrote:
>> Thanks, I did see that. When I pulled mainline master, I only saw the =
5b
>> defconfig and dtsi includes in arch/arm/dts. The plus dts file was in
>> dts/upstream/src/arm64/rockchip and appeared to mirror the dts
>> configuration in Linux mainline arch/arm64/boot/dts/rockchip for the =
5b+.
>> I tried the dts configuration a few different ways and reduced it to =
just
>> including the 5b config per Tom in the patches just sent.
>> I=E2=80=99m doing other testing on the board related to memory and =
timing, and
>> hope to submit some more mainline contributions in the future.
>=20
> Please try the existing series and if possible review it instead of
> sending a new conflicting series :-)
>=20
I reviewed your sdram and configuration changes for the patch you sent =
and rebuilt u-boot with those changes applied from dts/upstream.

> The plan is to use a single rock5b defconfig target for both 5B and =
5B+.
> And in the future the ROCK 5T should also be able to the same target.

ok. I tested various compiles of u-boot from radx, collabora, armbian, =
and u-boot mainline. The different builds and device trees are not =
consistent for the 5b and 5b+ boards so getting everything under a =
single defconfig would be great.

>> Which TPL do you use for testing the rock5b+?
>=20
> The latest ddr bin from rkbin at the time when my series was sent back
> in July and August when my series was sent, should have been the
> v1.19.bin blob. Did you have an issue with a TPL blob using my series?
>=20
I used the official blob referenced above and not all of the peripherals =
and bus power up properly. I noted that there are variations of the TPL =
binary in different public repositories with varying memory clock =
settings based on the file name descriptions, with the original file =
referenced above implying lp5_2400MHz.



> With my series applied you should be able to build the rock5b target
> and when booting on a 5B+ you should be able to see something like
>=20
> Model: Radxa ROCK 5B+
> SoC:   RK3588
>=20
> and this will indicate that the 5B+ device tree is correctly used.
>=20
Yes, I applied your v2 series patches and re-built.  I have a boot log =
from the u-boot build for your patches. I will send that as a reply to =
the original thread. =20

As you probably know,  peripheral support on this board appears to be =
spread across vendor branches.


> Regards,
> Jonas
>=20
>>=20
>>=20
>>>> On Nov 4, 2025, at 1:04=E2=80=AFPM, Jonas Karlman <jonas@kwiboo.se> =
wrote:
>>>=20
>>> =EF=BB=BFHi Bryan,
>>>=20
>>>> On 11/4/2025 7:25 PM, Bryan Hinton wrote:
>>>> This series adds initial support for the Radxa ROCK 5B+ (RK3588).
>>>> It introduces a new defconfig that mirrors the ROCK 5B baseline
>>>> while building from the vendored upstream DTS snapshot
>>>> (rockchip/rk3588-rock-5b-plus).
>>>=20
>>> Please take a look at the existing "rockchip: Add support for ROCK =
5B+"
>>> series at [1], it extends the rock5b target to also support the 5B+
>>> variant instead of adding a new defconfig target.
>>>=20
>>> [1] https://patchwork.ozlabs.org/cover/2118033/
>>>=20
>>> Regards,
>>> Jonas
>>>=20
>>>>=20
>>>> Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5) booting U-Boot from =
microSD card.
>>>> Build used:
>>>> - TPL rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
>>>> - BL31 rk3588_bl31_v1.51.elf
>>>> - GCC 15.1.0 toolchain
>>>>=20
>>>> The eMMC controller enumerates even without a soldered module. SPL =
=E2=86=92 U-Boot
>>>> boot verified; SD and USB enumeration work as expected.
>>>>=20
>>>> Thanks,
>>>> Bryan
>>>>=20
>>>> ---
>>>> Bryan Hinton (2):
>>>> configs: Add rock5b_plus-rk3588_defconfig
>>>> MAINTAINERS: Add entry for Radxa ROCK 5B+
>>>>=20
>>>> MAINTAINERS                          |   5 ++
>>>> configs/rock5b_plus-rk3588_defconfig | 118 =
+++++++++++++++++++++++++++
>>>> 2 files changed, 123 insertions(+)
>>>> create mode 100644 configs/rock5b_plus-rk3588_defconfig
>>>>=20
>>>=20
>=20

