Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04A3CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AE4808AF;
	Tue,  4 Nov 2025 20:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="HVXwWofo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3E08144A; Tue,  4 Nov 2025 20:43:32 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster2-host2-snip4-10.eps.apple.com [57.103.68.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB4F8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-7 (Postfix) with ESMTPS id
 9479E18003EC; Tue,  4 Nov 2025 19:43:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=oeOauARKqWxkL/pNoSq5ZAedrWpRgZxfjQxsSeOpJNg=;
 h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
 b=HVXwWofolQHuIRJX/j/nO2DZAHQhS6i9rX3w4qq7bqfAcGApvPaEAtIcQhpLTktb9JQKl4GGz/Pwre/jzZIUSJ+T7RWI4NoE/FjOeImgEsAkzu8Coi95nT7rEt+KNRF0pLwZQUaiF7+jWJl9KNdtIexPv7VLl9yy5Vp2bWRpdFOsMDzjLXBZ6iqWVRRNVw7II60R86DHP4X9iOv+P9CQzQiqIpTfQu3WOfDMIWxmz+BmVvopUGUD5RXShsJvgWeQpuiT7tKLV+4PKfQWJ1AC6nt5esyHW/7VdttZrdAr/50KVnY8o6pAqE4ioUIuE69kv/rFq7gsfv7AQCEEDWWi2A==
mail-alias-created-date: 1643268037438
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-7 (Postfix) with ESMTPSA id
 166FC180140C; Tue,  4 Nov 2025 19:43:28 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Bryan Hinton <bryan@bryanhinton.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] Add Radxa ROCK 5B+ defconfig
Date: Tue, 4 Nov 2025 13:43:16 -0600
Message-Id: <097D31DF-D7AC-4008-BF9A-CBFBF01247A4@bryanhinton.com>
References: <dc3d6a1c-37f1-45c9-95c0-d37effcb2ad5@kwiboo.se>
Cc: trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <dc3d6a1c-37f1-45c9-95c0-d37effcb2ad5@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
X-Mailer: iPad Mail (22G100)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2NiBTYWx0ZWRfX3SA7vmb+Me2d
 6rpoA2xPUW9dQeoOcvzYCz6G46PPdCLlw/KK3e7yC6BATXATlPPDZQDTGhDCciTfjpl8jCeIjZm
 LJy1IXHvTxZNnB5CnrXjNmFK4D6zbBQZK6ytAz2d+Jve4sog4l9+iaHdXn3g+pBjVK14RQjnu6h
 DX3eH54vWvNIt4j8btb+Cn4puBqYL4BHBpPDhfcKy31JKpyji3Uo/FYO1GQ6TA/VBY/1tbpPju4
 NunPnZ8Pbghg+GsBCKTXPJ1D24tDc0UzRTNxwIvh3p8jfNBuMzeKEBfxrk57HEZo4UDQOtEn8=
X-Proofpoint-ORIG-GUID: Eb-ki2SB3TVe5Alx3-9YwxT7AFEUS7I9
X-Proofpoint-GUID: Eb-ki2SB3TVe5Alx3-9YwxT7AFEUS7I9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2511040166
X-JNJ: AAAAAAAB8kzqF+JLaVz2Daeu6tXwS982SoWPRN7UfDZMvAaFTykEJryRYrGGOPiJwZHNZzpMD3U4vHHXm0j0dl35sAV5NnJJvwfqRcJpGwL3Io28BLSBuPDV9cEQ14xZAQ2MIbOH5h5sZ64Qkr1GrZ37OR8rg5JmYxtMxUNjt+jwTyXS1zi5LiEj9JLgLrADLAe/4tU4AVckEKJqNzSd/0npRgqi11/ROCqTSfLb0PMQiKanbtMSNj3sg1i+m+PGwbgsKlrcfkhiqmfSLy1GUvCAViIrOMd17RipDjzt5bNveEqh/WsAU2QYJlzRYi+18gvRzEidN4gtcmvurFVCw8V7hlf9XnVKIHRgyoTI5wzl8f8bJaelWRLc7QBiuh4hXjlyHqvWPds4WJglR94qLNEOmTA0HXzkO/SAi3eWpBC+pdjDEZLU8rdDyXfcOLZvJGEphiIniG9D1QPsK+541dAE907U/wHjT2wOk79o7pxMOgUQxR9yCjb3JWDc8Fgv+C1WT17XyQQkl1uKdbQc9n/flk/MxgKA9D5kQ2aYjI7ySUte5fq7XqF+CAv7EMdUsh4bvHhcfy33OxZa7thK1l2CF1EBOAsbr+ng+Vvcc5GYRK6/qDycu8xUTEIpRWmVjQ==
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

Thanks, I did see that. When I pulled mainline master, I only saw the 5b def=
config and dtsi includes in arch/arm/dts. The plus dts file was in dts/upstr=
eam/src/arm64/rockchip and appeared to mirror the dts configuration in Linux=
 mainline arch/arm64/boot/dts/rockchip for the 5b+.  I tried the dts configu=
ration a few different ways and reduced it to just including the 5b config p=
er Tom in the patches just sent.
I=E2=80=99m doing other testing on the board related to memory and timing, a=
nd hope to submit some more mainline contributions in the future.

Which TPL do you use for testing the rock5b+?


> On Nov 4, 2025, at 1:04=E2=80=AFPM, Jonas Karlman <jonas@kwiboo.se> wrote:=

>=20
> =EF=BB=BFHi Bryan,
>=20
>> On 11/4/2025 7:25 PM, Bryan Hinton wrote:
>> This series adds initial support for the Radxa ROCK 5B+ (RK3588).
>> It introduces a new defconfig that mirrors the ROCK 5B baseline
>> while building from the vendored upstream DTS snapshot
>> (rockchip/rk3588-rock-5b-plus).
>=20
> Please take a look at the existing "rockchip: Add support for ROCK 5B+"
> series at [1], it extends the rock5b target to also support the 5B+
> variant instead of adding a new defconfig target.
>=20
> [1] https://patchwork.ozlabs.org/cover/2118033/
>=20
> Regards,
> Jonas
>=20
>>=20
>> Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5) booting U-Boot from microSD car=
d.
>> Build used:
>>  - TPL rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
>>  - BL31 rk3588_bl31_v1.51.elf
>>  - GCC 15.1.0 toolchain
>>=20
>> The eMMC controller enumerates even without a soldered module. SPL =E2=86=
=92 U-Boot
>> boot verified; SD and USB enumeration work as expected.
>>=20
>> Thanks,
>> Bryan
>>=20
>> ---
>> Bryan Hinton (2):
>>  configs: Add rock5b_plus-rk3588_defconfig
>>  MAINTAINERS: Add entry for Radxa ROCK 5B+
>>=20
>> MAINTAINERS                          |   5 ++
>> configs/rock5b_plus-rk3588_defconfig | 118 +++++++++++++++++++++++++++
>> 2 files changed, 123 insertions(+)
>> create mode 100644 configs/rock5b_plus-rk3588_defconfig
>>=20
>=20
