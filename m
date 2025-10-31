Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4BCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C5283A2F;
	Fri, 31 Oct 2025 17:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="Eh2+v+3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B35C83A2F; Fri, 31 Oct 2025 17:35:00 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster5-host3-snip4-10.eps.apple.com [57.103.66.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C81383A1B
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-2 (Postfix) with ESMTPS id
 9889718013E1; Fri, 31 Oct 2025 16:34:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=zivya74la+qS6JqDpePwdKR5KP6Mbd9NymMeTOlGBLA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=Eh2+v+3bEuCaBA7aWbIGHF4w4bF6LKWQVOePGXDWAfKDdRK2u6t+2ISHVXRWqTxPxxLkov9RuyxmXk6OKNwsG0bkYuUheSbCaMeGU0uW5j3CKgnOTtRyldf3W12BOFeO4YvAE8ibRl2ys2oOtzOL6HINcH2++pv+y6F6aGx9r9yvA4OZIDYwsY92pCiNFF/tAgPkGOMblLJd6C5y7Bsf0bclHmrXlQjAEHyXkYeYWPvoJAcUsR6re9EH8GN3zr/d7P1ssbY3r+UHVBNZIA9A0nzQUXy0MN0alnhBhm14vc9cFJk5/os7fd0PyilboQ694RBiNBPeHu6QpTgCl8NTYw==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-2 (Postfix) with ESMTPSA id
 CD5BA180017C; Fri, 31 Oct 2025 16:34:52 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
Date: Sat, 1 Nov 2025 00:34:40 +0800
In-Reply-To: <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
To: Marek Vasut <marek.vasut@mailbox.org>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: _E1e_5WxstnXIKIjcW-poPrj4HD7yrIX
X-Proofpoint-ORIG-GUID: _E1e_5WxstnXIKIjcW-poPrj4HD7yrIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0OSBTYWx0ZWRfX80+CMXklpqjo
 IUw3bU93rrLXPX+fNL54eBj8OtlDiB/p281LmVhqUOWfLvysa36yHviZQYqz+YBc2arHfkCxofN
 rq53fLfMNx9OXxo00y1WpkOvaAhBXd99xfBPaCiULIkw2pY44jNHUHo05Gfp8d/jJoyGqLTiLPg
 UDMNuTi2ij8K5W2j+GP5TQGebiHdQEsUY+2JmiyXThnIQxZ/F9V6GrbhLANdJ1IyFy2lvI8jxmv
 bLcD5+WRkiogKjMxJnRqdW6e2L3DyExQ5vtpLNUCuDr1HpoOXQ8Fls86EsfTrQWB5Bz5V39vY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 clxscore=1030 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510310149
X-JNJ: AAAAAAABeSW5ig6poj1dBQrwj9zMfU6fyqB1dwXCS0ZFUwX+lK9Ht0xwAnHlaeF1tGRUQpTxvcASldJnakkeKM5ypTYBT9l9QQyzAMsIAI+wNBusX7+tlXCUL50lRvfM1h3YqnR1qJ68n6yv5mMjWxXdn0Z6zLB2cPbQGmcYZhq+BW1OzknpXGiC/0rh3jh+xUhLYeY73GDzX/u1vZ69b9Yet/Cqk5SBB/eGegswx/e0t4aGzWIrvZH+OSNVQ/B4wq3aXCHLfQPBayNaY8eXBmu3gSbhmxzbMgKKfiEXqRUeo+FntpLgGCSk/xpddDpKspRSWk3mAStW5dlynVfdzMctgwbOZ3VU8i9EzFW1+kFUqmOq0rfJRJNpj5k2VVBSbjxgYWQ4KRt1igYXOzlyrgCGHyw5KG3vwyoksgfvcewEeZjx0rRtr79RVaT0rAxTD8kIGaRbe3k133NAPyCCWOlYXetYiI4MAKfvP14Gj8+93D2PJflcgknedQWWW6XF1eV9O+0hJRu9SMzsAhKGtF/d7arN+IUQD4JPMIKk99UL38+2+Ak+F3LyB1kMgT+9bVPRNCDQX1DNRvSUdhRgmbxStTzo0brHVbOdffWScEH1pS+Obu32NZVHuRuWB4ABzTsln4GTzPmaW0JPnzuLrVFsFUcGljCg1z+U11zcSVbnI1n3vNxqa3MPuzXSzUdi1Hn+U5tQE3t+m441yKjniFiSV1IQ51hexaeoP/+0rSFUFBebPkdmUHyWj7x9IF56leN3KiUAQBt8GqmeWtTYbKyJafiAL9p751pUKdinZ3sWOMEI60g=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



> On 31 Oct 2025, at 11:57=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>> Aquantia PHYs are being used w/o SPI flash in some routers recently.
>> Current firmware loader only attempts to load from FS on top of MMC,
>> limiting the use on many devices.
>> Removed the old firmware loader, migrate to generic firmware loader =
to
>> allow a wider range and runtime override of firmware source. (e.g., =
USB).
>> Tested on Buffalo WXR18000BE10P with UBIFS.
>> Signed-off-by: Beiyan Yun <root@infi.wang>
>> ---
>> Changes in v4:
>> - Split firmware upload helpers change
>> - Reorder `aquantia_read_fw`
>> - Make `aquantia_read_fw` weak to allow overide
>> - Rename exit label in `aquantia_read_fw`
>> - Kconfig polish
>> Changes in v3:
>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>> Changes in v2:
>> - Add support for script based loader
>>  drivers/net/phy/Kconfig    |  28 +++++----
>>  drivers/net/phy/aquantia.c | 122 =
++++++++++++++++++++++---------------
>>  2 files changed, 91 insertions(+), 59 deletions(-)
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 018be98705a..4a74a0d4e8c 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -1,4 +1,3 @@
>> -
>>  config BITBANGMII
>>  	bool "Bit-banged ethernet MII management channel support"
>>  @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>>  config PHY_AQUANTIA_UPLOAD_FW
>>  	bool "Aquantia firmware loading support"
>>  	depends on PHY_AQUANTIA
>> +	select FS_LOADER
>> +	select FW_LOADER
> Can you not use the plain FW_LOADER to load the firmware from either =
storage, UBI or Block ? Is FS_LOADER even needed ?

Thanks for the suggestion, and yes you can, but that API is =
script-only=E2=80=94it expects the board to stage the blob and just =
copies from the address exposed via *_addr/_size. The current users of =
this driver expect the old pattern: the bootloader mounts a filesystem =
(MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies =
it. Keeping an fs-loader node in the DT is effectively the same contract =
as the legacy MMC setup, just generalized.

The fs_loader driver gives us several things the script path doesn=E2=80=99=
t: a standard way to describe the storage via "/chosen/firmware-loader", =
runtime overrides through "storage_interface/fw_dev_part/fw_ubi_*, and =
no requirement for a board-specific script. So FS_LOADER isn=E2=80=99t =
redundant=E2=80=94it=E2=80=99s the part that replaces the hard-coded MMC =
flow with a configurable backend, while the script helper stays =
available for boards that want extra logic.

