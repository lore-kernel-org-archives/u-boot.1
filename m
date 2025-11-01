Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02AFCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 07:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA2C839CA;
	Sat,  1 Nov 2025 08:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="Gkqiha57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A37183A36; Sat,  1 Nov 2025 08:45:25 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster6-host8-snip4-10.eps.apple.com [57.103.70.63])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01FA839B9
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 08:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id
 850DF18001AD; Sat,  1 Nov 2025 07:45:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=gkbN5OhHetaEReY2oeWCFO7S94SBq9Y8POdQwJ+Kiss=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Gkqiha579gSfl2dU+vef9Y6/5Fe4ZN4b6WrGul4RA7KED6xGWuxIvK38Xfpn3rt8+mo7UdWIeuzLVcnErILDKZ46QFJWOk6f4NB1YMhgVFvMpEzzHWopkXjiFIkINTGkN9LslCK/3fzO5ZCzVCu3DhjIazHYswt6vRWY60ozWAS3BDfNxWZ/sNcRnGK/YAhacDHpWFLRw7lEaQxM248Wi6pOgncUWCRNvPRBSYAM3d3inAN/UBWoRsSkhBLQBPRXmwi7mmaI6ng96QV0IoaTncLmm5gTGffu0SF6ZWR5cPOPUPX2ijySsNmqNMOzmtqfKH6wwuu5roNvEUKTb7nGHQ==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id
 C551B18000B9; Sat,  1 Nov 2025 07:45:17 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
From: Beiyan Yun <root@infi.wang>
In-Reply-To: <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
Date: Sat, 1 Nov 2025 15:45:05 +0800
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8968863B-CFDC-4EE9-9062-08219AC0838E@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
 <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
 <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: UKD3I4hVt7hKgKbfe2JII-xZIKaDM8vt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA2NSBTYWx0ZWRfX2uF5SdsGuboX
 ZEAbiqxISX+LttIea2G47ZjFU6QKHCciUca5P78FK1TJ19saIe4zjtOl9vBybhXsTAfSI3LFHQU
 QZh5lzn7oQYGx0INrwTmzwWZhsInfDd1rFuF8kGKNfVozMpa4OyO+kWFIYoOVJA0BwPcAEnGdkh
 vX0nTmpjTxxFgtZLlubxrCieLkfi8dxHTNxphzmCNOQbHoFkaVHYyadZMqloyF6USauJGLDmY+C
 iQGsKM3bOLnPSAPVD/5JkGD80p7UHcXlsPzBNpjt/ZVKePn6gMqS/onvX8gzhiawQfVqUMY9Y=
X-Proofpoint-ORIG-GUID: UKD3I4hVt7hKgKbfe2JII-xZIKaDM8vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 adultscore=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511010065
X-JNJ: AAAAAAABgSW0G2/MX5N/YY2ntLU2vzDkqYfdoaodGpI05I6fmyCKnNzIJ4T4XeRmfl6lIAc00b00olwXYNi7mCGovAKQ24rjJfyhlOVqzVfCHPEco1/lwacsWhQ5SbC+pcwGMcIhCDydUXjNlkfkecCdyBZn5PYBZNzCZYYpeiefENqD+yeFfo849JRS3OkO1T9hMOKM4KJUZaPqePalck+65o+DVVvVGvRAieSlLe9L0RqNPi0QJQWMJabLiwmVybJE3FRNTZLks2JLL+cUjE87SfpxNIVA+M8G1S/QcQkP6v6XPU8K0mCL28KFEWQvQWwnlZJ4U8D75k3qXz6ycdhVF6WqDg24DZohw3hV1WcCD9hEBmD75CI+aPL7+jIn9XsQUO9vW8R6WRan80c0ITUsLCzfEvQSlSxvGNLjxKLDrnlaaDaopV/x2gLYvAfbuE4icxm1uNj/yEDyXHXgPtSAkdklAIjrv4K2Es3iqhh//lKpVB+poBrVPd2uxH6JtAYi+KS2gzGF1aAWRf7vhWEFtHlxcpQ4b33R4FwvE6f3b+I0R2vO1uCgZVp7HelWlpeqM/FjEOq+u7gTaGPDn24i1FJvAT44P+IZytCabksYZ9/jQnw6h/f7UOwTKGVHqHURduqNu+8Rt7aXZvMLms6e4oJXHzWrMJdqTktB2CTLas+OmcnB3mRFqB+l3WODYlYhmWPrpg/Zc1E65+AOJXEjUzPkx2OPKu4BgF+CHv9cY/Wv/TQYaa3yN/NDf6ofxAn3ZJPkizEBNAH8HBPEJvw=
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



> On 1 Nov 2025, at 12:51=E2=80=AFAM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 10/31/25 5:34 PM, Beiyan Yun wrote:
>>> On 31 Oct 2025, at 11:57=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>>>=20
>>> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>>>> Aquantia PHYs are being used w/o SPI flash in some routers =
recently.
>>>> Current firmware loader only attempts to load from FS on top of =
MMC,
>>>> limiting the use on many devices.
>>>> Removed the old firmware loader, migrate to generic firmware loader =
to
>>>> allow a wider range and runtime override of firmware source. (e.g., =
USB).
>>>> Tested on Buffalo WXR18000BE10P with UBIFS.
>>>> Signed-off-by: Beiyan Yun <root@infi.wang>
>>>> ---
>>>> Changes in v4:
>>>> - Split firmware upload helpers change
>>>> - Reorder `aquantia_read_fw`
>>>> - Make `aquantia_read_fw` weak to allow overide
>>>> - Rename exit label in `aquantia_read_fw`
>>>> - Kconfig polish
>>>> Changes in v3:
>>>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>>>> Changes in v2:
>>>> - Add support for script based loader
>>>>  drivers/net/phy/Kconfig    |  28 +++++----
>>>>  drivers/net/phy/aquantia.c | 122 =
++++++++++++++++++++++---------------
>>>>  2 files changed, 91 insertions(+), 59 deletions(-)
>>>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>>>> index 018be98705a..4a74a0d4e8c 100644
>>>> --- a/drivers/net/phy/Kconfig
>>>> +++ b/drivers/net/phy/Kconfig
>>>> @@ -1,4 +1,3 @@
>>>> -
>>>>  config BITBANGMII
>>>>  	bool "Bit-banged ethernet MII management channel support"
>>>>  @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>>>>  config PHY_AQUANTIA_UPLOAD_FW
>>>>  	bool "Aquantia firmware loading support"
>>>>  	depends on PHY_AQUANTIA
>>>> +	select FS_LOADER
>>>> +	select FW_LOADER
>>> Can you not use the plain FW_LOADER to load the firmware from either =
storage, UBI or Block ? Is FS_LOADER even needed ?
>> Thanks for the suggestion, and yes you can, but that API is =
script-only=E2=80=94it expects the board to stage the blob and just =
copies from the address exposed via *_addr/_size. The current users of =
this driver expect the old pattern: the bootloader mounts a filesystem =
(MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies =
it. Keeping an fs-loader node in the DT is effectively the same contract =
as the legacy MMC setup, just generalized.
>=20
> Can you maybe write a script which implements the old loader behavior =
in a compatible manner ?
>=20
>> The fs_loader driver gives us several things the script path =
doesn=E2=80=99t: a standard way to describe the storage via =
"/chosen/firmware-loader"
>=20
> Try this:
>=20
> "fdt addr $fdtcontroladdr ; fdt print /chosen"
>=20
> And then look at the "fdt" command and what it can do regarding =
reading content of DT properties into variables.
>=20
>> , runtime overrides through "storage_interface/fw_dev_part/fw_ubi_*, =
and no requirement for a board-specific script. So FS_LOADER isn=E2=80=99t=
 redundant=E2=80=94it=E2=80=99s the part that replaces the hard-coded =
MMC flow with a configurable backend, while the script helper stays =
available for boards that want extra logic.
> Maybe a more generic script can be a replacement for the older =
hard-coded approach ?

Fair enough, I=E2=80=99ll remove fsloader for now.

I still believe it would be valuable someday: if reading from nvmem cell =
is implemented, the same DT could be used for both U-Boot and Linux.

Regards,
Yun

