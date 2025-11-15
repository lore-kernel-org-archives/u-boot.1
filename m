Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051CACEB2CA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 07:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400A183F2F;
	Sat, 15 Nov 2025 08:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="sFPpf/lE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAEF84137; Sat, 15 Nov 2025 08:55:40 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host5-snip4-5.eps.apple.com [57.103.64.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0878883F15
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 08:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 871181800172; Sat, 15 Nov 2025 07:55:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=NFwG5A1ZCSl+s7U3lAvELX8HRvZVhFE9FMYcI/jwR3U=;
 h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
 b=sFPpf/lE6H0dBmnUSPHuAZcwxckEMV0FDcx71I0/4j5saLGtCDhnNleE3wgOzKkxU9s7S9/7zHuZjfXHJjOiLINRq/uNQWcHwNEhYkXl+hIqoB5ePMRW/cXCskVTkRhWtfQVm0VXxszLncrtkOMR2SvpoZ/qYl9PGLeeQSAh0YReANU5ousuqlt4nGSa7k7nm/CdJLILPsIaTrCyUvIM5Q38pfpE3B6Dv20AIglqBfcjCdUIXKNCzGudE6lUvHN9OT2d54t5aOjip4JrDqH8xadEd3/gGd1C4b87jnmIQAGHoMmghICvKLzw8PHex+WermKbMFR1kGHRm9DWk7JZlQ==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 A55501800157; Sat, 15 Nov 2025 07:55:29 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Beiyan Yun <root@infi.wang>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
Date: Sat, 15 Nov 2025 15:48:56 +0800
Message-Id: <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
References: <20251101123401.110681-1-root@infi.wang>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Zi Yao <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20251101123401.110681-1-root@infi.wang>
To: Beiyan Yun <root@infi.wang>
X-Mailer: iPhone Mail (22H124)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDA2MiBTYWx0ZWRfX8au3vtS/OQJV
 OfRyLbFq+KWnrAzMFiPIDvvzbKIwZ5OG2OrRPnbU8/6/L1+h2WN+OxKiokbQbWitlLWGraCkGUE
 nsvIMUHeRYyXp41daC4JVqyNCSgVG4j5rhZjwtgYggzbj683Bel6OFMnwPo+xOt4v9QcrQp4tj2
 ps4mSG8UPhpl7L0pq13zFXa8vHun5LuSdojSESwa0BBi0eSGeni3ctk8idqJZdTONTOWByrKTH2
 zDsKMUrC30sda+jacDlEOOkgpQjunbcQcVY0WLscaS3RqD+nvij3wliUNzq0jWc5J4YV7qBQkpH
 9qydBmOG7XkQS3sLoek
X-Authority-Info: v=2.4 cv=Uf9ciaSN c=1 sm=1 tr=0 ts=691831f5 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=juaZcWxvmjS43f8_BdkA:9 a=QEXdDO2ut3YA:10
 a=8iqKRNYe-yLjZuHCO3rH:22 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=eeDtFMHqlkPJeBvn9BwJ:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: dUaL1qnd4kAuXLyX1njqBqyWFQMNXEct
X-Proofpoint-ORIG-GUID: dUaL1qnd4kAuXLyX1njqBqyWFQMNXEct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1030 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511150062
X-JNJ: AAAAAAABw95RknG8e3BvTg/andc/s4ghkdhtUpq6J94TIOeKLYGUvihkz61rlyKkJNerr0l5fcF6EL9YeUDVT/Bi/+fksdymbWJQhlgr3NPnBaOFip5lIs4QbCdZaU4li4TnifsvhfuzuVgZMjSFxUbuL9UsPhzlPxZDN3uT0K+7lva3RPvauHDBC6KCBZsbm3A9pDn4rvNtE9sD53CwwTUh2TeLaoq3KwgKfrqy+yNM2S9rN0PlgqAMKsBH1eLzoyiLarewicCMYCt+B730pzasfQH9wvBX+j+995RJYsU+KtJXGnYEyujRHGvLQ7yGsySsFAvRZksaAzyX7h1dUD5RVueb8eMaeU5QL/7egKWLPeBCYH49oFaCZyWHBueTPYGVJ8l5mMHh/0fvuQoh465D2Cc2avr1QO/4CX4fpjnd6NrGMr6by/VL0BQVLQtwTVfq0IsZfvTk+1XfI4sgAOu3F/SDtnaMbiOeUjMvIs4rKa31umS7eBo4T12DycesZJpb0DYmPQq3K+pqb4x2/SY5YAmRc2++9ApfQgQzuC+EIzqJUSt12IQgFeFMNBkPODg2HPxlfpxNErMeYZpHZqdg+dNO/wCh941grBen8q1a1HeEJFO6xLDmhsWanIUaT3lfXRJXDp5ZRNVqiaXRI2nMNDqpGNH0yllgEPjbwE7CgZ35iw5gBnPT895Xp4hIDm+tHMfpa0FyO0gpv/8Eijl106WRE4bSYktz5WEEnU9jiRD4wo53jHSyKD3QYhbWhSi0LZwejbiyWhZhnQWyZFjrE0OqEcHV5rT5moR4/w==
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

Hi all,

Gentle ping. Any comments on this patch?

Thanks,
Yun

> Beiyan Yun <root@infi.wang>=E6=96=BC2025=E5=B9=B411=E6=9C=881=E6=97=A5 =E4=
=B8=8B=E5=8D=888:34=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BF
> Hi,
>=20
> This patch series refactors the Aquantia PHY firmware loader to use
> the generic fwloader framework.
>=20
> The existing loader is limited to loading firmware from an MMC device,
> which restricts its use on many devices (e.g., routers) that may use
> other storage like USB or have a UBIFS root filesystem. Migrating to the
> generic firmware loader allows firmware to be sourced from any backend
> supported by the fwloader scripting framework.
>=20
> The series is structured as follows:
> - The first patch prepares current loading code for fwloader.
> - The second and main patch replaces the custom loader with generic one.
>=20
> This change has been tested on a Buffalo WXR18000BE10P router, loading
> firmware from a UBIFS volume for Marvell CUX3410.
>=20
> Changes in v5:
> - Remove fsloader codepath
> - Drop binding changes
> - Make script name static
> - Minor refactor
>=20
> Changes in v4:
> - Split firmware upload helpers change
> - Reorder `aquantia_read_fw`
> - Make `aquantia_read_fw` weak to allow overide
> - Rename exit label in `aquantia_read_fw`
> - Kconfig polish
>=20
> Changes in v3:
> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>=20
> Changes in v2:
> - Add support for script based loader
>=20
> Beiyan Yun (2):
>  net: phy: aquantia: refactor firmware upload helpers
>  net: phy: aquantia: use generic firmware loader
>=20
> drivers/net/phy/Kconfig    |  23 ++++-----
> drivers/net/phy/aquantia.c | 103 +++++++++++++++++--------------------
> 2 files changed, 59 insertions(+), 67 deletions(-)
>=20
> --
> 2.47.3
>=20
> base-commit: 62b45e82bdbf703571450e97f605893fe0d50530
> branch: aquantia-fsloader-v5
