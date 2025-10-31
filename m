Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAE2CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B1E839A5;
	Fri, 31 Oct 2025 18:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="FKUmSsFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B2183A45; Fri, 31 Oct 2025 18:22:01 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host5-snip4-6.eps.apple.com [57.103.64.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0E883956
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPS id
 ED09E1800129; Fri, 31 Oct 2025 17:21:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=7UhNI3X/U4lLw06X6JnddZDUKcdi7cF/5NTUVixiSZA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=FKUmSsFJFcb7A+ShvPq9VGhuVCHPktBHW0VF2ysnogNkU7u+TFfWoZUQmlTDL7Z7qLxGy6jNX1Iuy34pIjiW8xeUFNmNWAx8ScsCN9Td2SCheDBMOkkx0QpPNNqEZnPo76ggEBaWkonNCLbtuHBeYmBY2yC/MJoOxJxoI2Lb8fzOJ8Esm2F6JvGPua8AeakTtU+HRe7xECnYtcAExIRKeqJe07ioGC1qbApFRojoJiz3cUCgHY1zAss6xngXiOiD0s8vZ6kGrB/5RUkhvssDK1fzoXAqP9Z/6c4hln2dK1RB3EYvjvSLlHBMHbtlEn7gQJTsMNQznoOZR+GAyuI2TQ==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPSA id
 1E7F71800125; Fri, 31 Oct 2025 17:21:52 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <C2649793-C878-4906-BDF4-0410DA9F12A2@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 1/5] net: phy: aquantia: refresh format
Date: Sat, 1 Nov 2025 01:21:40 +0800
In-Reply-To: <ac552ba3-832c-4cfb-aa39-c80949df7900@mailbox.org>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-2-root@infi.wang>
 <ac552ba3-832c-4cfb-aa39-c80949df7900@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1NSBTYWx0ZWRfX9dBItw5iMZ7G
 B3eamBIKtaZOApWZTzgzAxjKpbcAkV+6UA/NiVZIg0cJb2Gc0VtDqpkNuETMUSHnp/pGxHKmRij
 E30maJei8fRQbFYfWWeN45YoylKu7ydl2JZi/Cu18n6R490eKtQbeeP3DuQOQMfxPXyvsXMGHhg
 1ftaZdA5fx6L9/4PH343MiFr9RP5ZTe4r+RK2V+xtAs2F7LLQKifzYNNfNsf7CSdymlw+N2zV/5
 JNi/DUXdvuMXImRCDY4QHJhze2R+NhOTyZHCw8V0Itx3U7IU7lSko+pcHueYYUf3ITIldqBQE=
X-Proofpoint-GUID: qO-mklvmYIE-Y5l1X4XJaU2U_RkTnMRH
X-Proofpoint-ORIG-GUID: qO-mklvmYIE-Y5l1X4XJaU2U_RkTnMRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 clxscore=1030 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310155
X-JNJ: AAAAAAABLidiNuSSfmlc+Y2/lNge78cz+EqeTKqR93E8GosFLW49SC4F2h0o+8t50xXZ2cPWURlyomXslw8Vllb/2YwSPhXg46jA9dIaGKy1Q2GaH9wC+NH00kzsDBsDK0tAQHfhgJ1sRC9RWpXN1luSmmjvnqJM9Zgi+Rdg7YiqmUE+kHLGP+0ct97FUQLdWsx2k4kad58JX8B5xH6Px3Y+CgfhioyeynQ4v1DcdTar2PlRg/nfhLtemDFxqqj7gayD/Us+wU3bJ9J6sU1wV49h2Z8t8XaULQExlfP6fNPwIXrgILfJCXDRLYsVY8h5s1hCVUQtGdrN2pjm/dmofLJzCxKA/sq6pvP1OnGQQSI/xEg534hEC37rcFi+LecVVHDVOLwUkPRab+sFwVbaYw5OOJKwpwCcAhaJAhNKMQHcTPDjb+pwpWe6jplGiCD0FNK8LhLc2CCVdTjTgnOX8q9IGtyUy2dVlHf9IacoEi4x6jwbkTcJAkefCcTIIxED0RqWgzpFrfhYjc6g4ibREeKowhyyx8lVm2vqawc4lnIw17/Joh0FenWvM2IFqNsP9CPhJ47eyWS+Ez3a9xX3pxRsXWnOoSGN6FOFqY+iZCTTZH/tsBSghNj/CFMGXfvIvSS0WXMjrOlDVhvNysAZ56UfZwFZjPPlSfn9JboAr0VdYcn/T9bvLUCz7ZjlCgR7Wi+T3R7mdF0RTOvwyaL2YWCLJWmOEzxmKYLkddf/cUmq3BLIK1rQlsZuZ3hc
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



> On 31 Oct 2025, at 11:51=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>> Refresh format using clang-format.
>> Signed-off-by: Beiyan Yun <root@infi.wang>
>> ---
>> Changes in v4:
>> - New
>>  drivers/net/phy/aquantia.c | 159 =
+++++++++++++++++--------------------
>>  1 file changed, 75 insertions(+), 84 deletions(-)
>> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
>> index 903fcd667f6..439c4c48bdc 100644
>> --- a/drivers/net/phy/aquantia.c
>> +++ b/drivers/net/phy/aquantia.c
>> @@ -18,28 +18,28 @@
>>  #include <asm/byteorder.h>
>>  #include <fs.h>
>>  -#define AQUNTIA_10G_CTL		0x20
>> -#define AQUNTIA_VENDOR_P1	0xc400
>> +#define AQUNTIA_10G_CTL 0x20
>> +#define AQUNTIA_VENDOR_P1 0xc400
>>  -#define AQUNTIA_SPEED_LSB_MASK	0x2000
>> -#define AQUNTIA_SPEED_MSB_MASK	0x40
>> +#define AQUNTIA_SPEED_LSB_MASK 0x2000
>> +#define AQUNTIA_SPEED_MSB_MASK 0x40
> #define<space>MACRO<tab>0xvalue
>=20
> is perfectly fine format.

Agree, until clang-format has become the default. I don=E2=80=99t really =
have a option.=
