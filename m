Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F7CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 09:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD9482A9E;
	Fri, 26 Sep 2025 11:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="jR+mOHDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684CE82A9E; Fri, 26 Sep 2025 11:30:29 +0200 (CEST)
Received: from outbound.pv.icloud.com
 (p-west1-cluster1-host2-snip4-4.eps.apple.com [57.103.64.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AB982998
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 11:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 C9FBD18000B3; Fri, 26 Sep 2025 09:30:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=VEs3e+Wx+Y1CyTKoBC6OJnI22ByH5UDB9uaTP1i6QvI=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=jR+mOHDBsEfVsr/FixK7k5z/1zSwdO52L23ZIUhEO2ddDC20oqS+vFz96UoQf+MBfLO3/vyKFOC1VdWqrzDy4QACaPBgIr1mQuPP2WCJ2dgNuGA91JwfsA5sQEmP/kRuo18pVyAjdDB44VacXiF+huJpC/Jv6GDcxYhHxCbPZXN+oC5jxAtILihZdJPjZXGqJd4Om95xBb/2qm2Qrb1NiMzaMOLQEKEqG5Vl1D/71OQ6hD/zO8ZVUcMTccSCUiaAMn3hihmYlcjwbpsbwb3pUnTObNHNz/KKAQoe90QZnt8wAaFSk67wZrj+f/IoTd3H3b5XTbGTi4EuZA8oEpXEjw==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 E46E1180014D; Fri, 26 Sep 2025 09:30:15 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <6689E83F-4029-4BD5-8AE9-20B9BC3D1A5C@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Date: Fri, 26 Sep 2025 17:30:03 +0800
In-Reply-To: <A93BFAC5-DB33-43E5-973B-58AF65EC23D2@infi.wang>
Cc: u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
References: <20250923071315.276114-1-root@infi.wang>
 <20250923071315.276114-5-root@infi.wang> <aNKWLNH0ZhqFckNl@pie>
 <A93BFAC5-DB33-43E5-973B-58AF65EC23D2@infi.wang>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: xS2ZQJS9HnsGU0Vk-lkmT0s3xWNqKlXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4NyBTYWx0ZWRfXzYuFKTzIC3ex
 TumFm5EWF9Wpp9lTNb2olHsuwH2boRKH0hHOC/tu5kQY5kKH4ah+pFzJlt3kYcisjERjs6V1xkq
 YjwNRqgGeaBeoUtuSYF5sPJJmdFP+UDKm5SVKTOhE1WQzqBywiUQUxN1BoO0s0xv0mkG2GUrUkW
 bSiUWdeFPGVvtQqNEN6sUxmqtuYO2vRcMqy79BWOwtcf56o3oGU5c+wXubVl89YRz6diWHEQqIv
 LMWFwttXs4qX07JrDb8jAQazuthOOPBEt9o9wP88qDPagRW5wOFyu4ZsY/BcFwkT8ziTYjzdQ=
X-Proofpoint-GUID: xS2ZQJS9HnsGU0Vk-lkmT0s3xWNqKlXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2509260087
X-JNJ: AAAAAAABpLHnjw1YZCa2EwWf23kJ/7oGV+FeBhrd/l/R2ucLc13Z/QeRr8SV7SslmEfel/r88jam7AaGoe/ONWmgpfufi+RCAOXlz2v7GzyTDh/n0eQcdis3TB/3bi6WUdKjDTylFAxrGL91R7ARvson9Il2ivnxmqpNNN21hFqtZhBfm1/Ic/PStUTRR59EfaPNHlDrErCbcD5kXA/eb2Xwj5wJkHGySSx+533AFsnf0dtHcv/iKz90gTrsQ7YuuW2Kh6Ykl+CI3Y0iID4e7uEsrur1tAnzuuiYz56zxMjGpxcm54B2q7K4HMnKfRStRXLPZHqgRJYavtGjkoA23GiJc8EyJO3cf/PXPowjU40f1OWPykh1fpZRRzeur+nUhBaX9nsN+omAg0qPnzCeNpSS6yXhTs9HNRfW/saCJGrbP6nhWQnsW1I0y0NhfvBPoezABcFOiKbwS0nCnBrwaih/qqqMdrDDPElUfAuIH+l7iuKzj/eMEqou6rZyypNGMTJws6D64dnSFBE8e+c6cun1h5zgYicUd+4H9Q9uEHcDeFyTkGBpTJlpklbr34HImpQNYZOsFTt+4tbeAC39BPVVVtuC7fQfGBDNP4XzWftbU+KSXAjabworwCLCB2g3l+4vz+yEvjkkKJzXlD8rBqRI3xkw
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



> On 26 Sep 2025, at 4:22=E2=80=AFPM, Beiyan Yun <root@infi.wang> wrote:
>=20
>=20
>=20
>> On 23 Sep 2025, at 8:44=E2=80=AFPM, Yao Zi <ziyao@disroot.org =
<mailto:ziyao@disroot.org>> wrote:
>>=20
>> On Tue, Sep 23, 2025 at 03:13:01PM +0800, Beiyan Yun wrote:
>>> With the switch to generic firmware loader, "firmware-name" binding
>>> was introduced to define the firmware filename.
>>> Provide the document and usage examples.
>>>=20
>>> Signed-off-by: Beiyan Yun <root@infi.wang <mailto:root@infi.wang> =
<mailto:root@infi.wang>>
>>=20
>> IMO this patch should go before the driver change.
>>=20
>>> ---
>>>=20
>>> doc/device-tree-bindings/net/aquantia-phy.txt | 30 =
+++++++++++++++++++
>>> 1 file changed, 30 insertions(+)
>>>=20
>>> diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt =
b/doc/device-tree-bindings/net/aquantia-phy.txt
>>> index 7dd3d45df12..1227c04d04f 100644
>>> --- a/doc/device-tree-bindings/net/aquantia-phy.txt
>>> +++ b/doc/device-tree-bindings/net/aquantia-phy.txt
>>> @@ -11,15 +11,45 @@ a custom firmware is needed for each integration =
of a PHY.
>>> Several optional bindings are defined that allow these configuration =
points to
>>> be driven by the PHY driver and reduce dependency on specific FW =
versions.
>>>=20
>>> +Aquantia PHY's firmware is often provided by PHY-resident SPI =
flash; if absent
>>> +or outdated, U-Boot can upload firmware over MDIO during PHY =
initialization.
>>> +The driver uploads only when the PHY reports missing firmware or a =
fault.
>>> +
>>> Optional properties:
>>> mdi-reversal: 0 or 1 indicating that reversal must be =
disabled/enabled.
>>>              Firmware default is used if the property is missing.
>>> smb-addr:     I2C/SMBus address to use, firmware default is used if =
the property
>>>              is missing.
>>> +firmware-name: String containing the filename of the PHY firmware =
to load
>>> +               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is =
enabled).
>>=20
>> This looks good to me, but I have a question: should we switch to the
>> upstream binding for aquantia phys? It's already documented as
>> marvell,aquantia.yaml, and we could avoid the burden of maintaining a
>> separate binding file.
>>=20
>> The "firmware-name" property is already described in the upstream
>> marvell,aquantia.yaml, and it only misses the smb-addr property. The
>> only U-Boot boards making use of this property are fsl-sch-30841 and
>> fsl-sch-30842, thus such conversion shouldn't be a big job.
>=20
> Good point. I=E2=80=99ll add a bit more info in related Kconfig =
options and drop the doc.

Hmm, I=E2=80=99m a bit lost. Here=E2=80=99s some of my concerns:

- Upstream binding has an optional nvmem cell as firmware source, such =
mechanism
   simply doesn=E2=80=99t exist in U-Boot. This could be misleading.
- About =E2=80=9Csmb-addr=E2=80=9D, what=E2=80=99s the best move? Do we =
upstream them to Linux?

Any idea on how to fix these issues?

Thanks,
Beiyan Yun

>=20
>>=20
>> Best regards,
>> Yao Zi
>>=20
>>> Example node:
>>> phy@00 {
>>> 	reg =3D <0x00>;
>>> 	mdi-reversal =3D <1>;
>>> 	smb-addr =3D <0x25>;
>>> +	firmware-name =3D "aqr-firmware.cld";
>>> +};
>>> +
>>> +Example using the generic firmware loader:
>>> +/	{
>>> +	chosen {
>>> +		/* Select default firmware loader instance */
>>> +		firmware-loader =3D &fs_loader0;
>>> +	};
>>> +
>>> +	fs_loader0: fs-loader@0 {
>>> +		bootph-all;
>>> +		compatible =3D "u-boot,fs-loader";
>>> +		/* Load from MMC0, partition 1 */
>>> +		phandlepart =3D <&mmc_0 1>;
>>> +	};
>>> +
>>> +	mdio {
>>> +		phy@0 {
>>> +			reg =3D <0>;
>>> +			/* Load this file via the selected fs-loader */
>>> +			firmware-name =3D "aqr-firmware.cld";
>>> +		};
>>> +	};
>>> };
>>> --=20
>>> 2.47.3
>=20
> Cheers,
> Beiyan Yun

