Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6041CAC5AC
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 08:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E119882998;
	Fri, 26 Sep 2025 10:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="EYNP6DDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E8382AE1; Fri, 26 Sep 2025 10:22:46 +0200 (CEST)
Received: from outbound.pv.icloud.com
 (p-west1-cluster3-host5-snip4-5.eps.apple.com [57.103.66.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D26D8206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 10:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id
 B47D61800315; Fri, 26 Sep 2025 08:22:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=+mzFXfi/Jby1WptHjOpFdY8NG8O3LNkvlkSYO7UZvfs=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=EYNP6DDLZ+7VttO4UaUPA1I94gXUbfJ+z3ZaBObuc0G/Xy91JsYWt6+VnrlOPlIr6aGdJiOSCUO3eeKujdJBXYhPmkzuamwWHT/j6sr1/gbKIZKTdIn34QiBvVHUUuHpnPh6RTRJEyuXBGCTlraXOhxcYzfP5eoIr1YdFYglWuO5xVCTq5ZZXbi8NO8e5wpRY2BBDOFR+3f3zfpy6xjGMA63MF+pGSXu4jvUNFvmF+hNIb5UR0fcazyQOCjG/4WLXXk51ogmFO+egWrmspW/QL6ANCBZROzZLu5czDZo5Rd2jA2Mug9KbB0mR7BzaBqdjatIU+Ic6PBOf1UWKHRnpA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id
 0E35A1800149; Fri, 26 Sep 2025 08:22:38 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <A93BFAC5-DB33-43E5-973B-58AF65EC23D2@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Date: Fri, 26 Sep 2025 16:22:25 +0800
In-Reply-To: <aNKWLNH0ZhqFckNl@pie>
Cc: u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
References: <20250923071315.276114-1-root@infi.wang>
 <20250923071315.276114-5-root@infi.wang> <aNKWLNH0ZhqFckNl@pie>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: QwpEZuioqZnfgFb3yWIuSe-IzWYp2Caq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA3NyBTYWx0ZWRfX9xq9JX9bYvbd
 BzVMF4Gk+Gm/QoCzIJVLEubSebyysqqnnlsL9Kun9yKpFnaW92VGoLq52QCG3gG4JzZ3VlBMSnm
 XqVihuF+oh/aHr0tBmiSOUYGsh3rd7Hbvgtwk2SQx7sL5kXiBGWoiwRsdnjC2yzyhYg19wtIpYf
 S3KuL27cKP1dE/fCMc1cAuroBUeVX6dUMJ18Ry2qEeqj/V7h/VRZe3Atg7/Be3b+9T4CALANNT2
 8rDOclbw3o49Cc3gopDkipmdl+Bz0yjBtfKaGNoyP19neDA5+VSU3L/6T7KO8oi0XeuJPl45Q=
X-Proofpoint-ORIG-GUID: QwpEZuioqZnfgFb3yWIuSe-IzWYp2Caq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1030 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509260077
X-JNJ: AAAAAAABQus9aeW0Vj4ObAsRtkcf8aM3pJEoiipsOByXRDrDhsRu25XL9Q3UmkM406V/kXMM+Bd2NWG6eb162KVc2pFTQUckffVDYtmvwIVkN9CyZFZcBiT+SQrpFZ5h63/MMrIgOCdPQee939jO4EWNHA/EcvxR7BNvFP//4ky1mMvt04Ig0H+9HtZUlHw66Aa99O9IuoOl4eTA3HP1YvUASYCF83DxovSxDcbn5McHpQDbptMdswh/dWDylyJgAG+YS1roxsSoM8YWW7bq109WYlI8Oq+EsxV8E8wjYmGj2VffpenQ7fUWx2rbfSEBwfdB39Q+onzjK8Xc5R/zBZ79LJ1StAqj+oph8eRhHmwtMP2MyXyHGXP4dAm1THuW8xOEr3NPKh5h5DxtIdLyrT173LxWRb96E3PrCe6XyGS3EyADdw/YdJjHnSMrZTiAwn9ATs5mWcSzSeE128jk0pLm6FY11AztILnc2BnFi7TwpgvCXB2aFZyS7/moXh6V8TW3ibMZ42a6mr9cMsrtbP2pvnmEd54wpUSOUDsh+BbEPSi3TcZAyZwEhIUE4TGS8igQL9QFLRdK285qfZkFKrQWU4bcQI9r5WGojE/Ul6E5OVviB2kAsJCom7EJlt6KpSv34vsSPR6V22uLp0ll2jOS
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



> On 23 Sep 2025, at 8:44=E2=80=AFPM, Yao Zi <ziyao@disroot.org> wrote:
>=20
> On Tue, Sep 23, 2025 at 03:13:01PM +0800, Beiyan Yun wrote:
>> With the switch to generic firmware loader, "firmware-name" binding
>> was introduced to define the firmware filename.
>> Provide the document and usage examples.
>>=20
>> Signed-off-by: Beiyan Yun <root@infi.wang <mailto:root@infi.wang>>
>=20
> IMO this patch should go before the driver change.
>=20
>> ---
>>=20
>> doc/device-tree-bindings/net/aquantia-phy.txt | 30 =
+++++++++++++++++++
>> 1 file changed, 30 insertions(+)
>>=20
>> diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt =
b/doc/device-tree-bindings/net/aquantia-phy.txt
>> index 7dd3d45df12..1227c04d04f 100644
>> --- a/doc/device-tree-bindings/net/aquantia-phy.txt
>> +++ b/doc/device-tree-bindings/net/aquantia-phy.txt
>> @@ -11,15 +11,45 @@ a custom firmware is needed for each integration =
of a PHY.
>> Several optional bindings are defined that allow these configuration =
points to
>> be driven by the PHY driver and reduce dependency on specific FW =
versions.
>>=20
>> +Aquantia PHY's firmware is often provided by PHY-resident SPI flash; =
if absent
>> +or outdated, U-Boot can upload firmware over MDIO during PHY =
initialization.
>> +The driver uploads only when the PHY reports missing firmware or a =
fault.
>> +
>> Optional properties:
>> mdi-reversal: 0 or 1 indicating that reversal must be =
disabled/enabled.
>>               Firmware default is used if the property is missing.
>> smb-addr:     I2C/SMBus address to use, firmware default is used if =
the property
>>               is missing.
>> +firmware-name: String containing the filename of the PHY firmware to =
load
>> +               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is enabled).
>=20
> This looks good to me, but I have a question: should we switch to the
> upstream binding for aquantia phys? It's already documented as
> marvell,aquantia.yaml, and we could avoid the burden of maintaining a
> separate binding file.
>=20
> The "firmware-name" property is already described in the upstream
> marvell,aquantia.yaml, and it only misses the smb-addr property. The
> only U-Boot boards making use of this property are fsl-sch-30841 and
> fsl-sch-30842, thus such conversion shouldn't be a big job.

Good point. I=E2=80=99ll add a bit more info in related Kconfig options =
and drop the doc.

>=20
> Best regards,
> Yao Zi
>=20
>> Example node:
>> phy@00 {
>> 	reg =3D <0x00>;
>> 	mdi-reversal =3D <1>;
>> 	smb-addr =3D <0x25>;
>> +	firmware-name =3D "aqr-firmware.cld";
>> +};
>> +
>> +Example using the generic firmware loader:
>> +/	{
>> +	chosen {
>> +		/* Select default firmware loader instance */
>> +		firmware-loader =3D &fs_loader0;
>> +	};
>> +
>> +	fs_loader0: fs-loader@0 {
>> +		bootph-all;
>> +		compatible =3D "u-boot,fs-loader";
>> +		/* Load from MMC0, partition 1 */
>> +		phandlepart =3D <&mmc_0 1>;
>> +	};
>> +
>> +	mdio {
>> +		phy@0 {
>> +			reg =3D <0>;
>> +			/* Load this file via the selected fs-loader */
>> +			firmware-name =3D "aqr-firmware.cld";
>> +		};
>> +	};
>> };
>> --=20
>> 2.47.3

Cheers,
Beiyan Yun

