Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7347ED735EE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 03:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6BD89440;
	Sat, 30 Nov 2024 04:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=belden.com header.i=@belden.com header.b="efK7VOD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1146389494; Fri, 29 Nov 2024 22:09:54 +0100 (CET)
Received: from mx0b-00015a02.pphosted.com (mx0b-00015a02.pphosted.com
 [205.220.178.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942DA89049
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 22:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=606301bf62=aleksandar.gerasimovski@belden.com
Received: from pps.filterd (m0382793.ppops.net [127.0.0.1])
 by mx0b-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATKt6w2008802;
 Fri, 29 Nov 2024 16:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=podpps1; bh=AGg1XqQ15nEbjsQwIPkCEocd
 N/PMfC+3OPRdf36w9n0=; b=efK7VOD3OgsjL+oF0uzF7tQSp3jkPYFCX5H6BO5e
 Esx67WfZepY5zHGLxYgESJdVJyYKh6HNsvvC6hW2/M5uNvBfnaZ6OInbAnucm466
 WzgR2tWQ/18jwb92WGeDSFAhZpytdxHIuGjEqWPowebBp6U3+mCPgHtCFeX2qYDq
 PB2Fm5rQmAmdbeRZ0sMmSD/xYnCKAwN2vZ322ezfZSSxF4Ds62TNnn4woJK7C88Q
 WaMWLa6Jsz/o2vt8NguFR/PTmXPNPgi0bEJl5RN4YDwKKfRttV00tr5Hnrz7NJuB
 lnFBM9bE2CNWRRqiby6+FmJICkiFPMw6B3tjORLyfkjtHA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by mx0b-00015a02.pphosted.com (PPS) with ESMTPS id 43670twhus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2024 16:09:47 -0500 (EST)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by SA1PR18MB6105.namprd18.prod.outlook.com (2603:10b6:806:3e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 29 Nov
 2024 21:09:45 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 21:09:45 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: [PATCH] efi_loader: fix pe reloc pointer overrun
Thread-Topic: [PATCH] efi_loader: fix pe reloc pointer overrun
Thread-Index: AdtCoPWUQwb/C4wbSaqkqwl7mK5Zdg==
Date: Fri, 29 Nov 2024 21:09:44 +0000
Message-ID: <SA1PR18MB56923B0952E67CC949A90A02992A2@SA1PR18MB5692.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|SA1PR18MB6105:EE_
x-ms-office365-filtering-correlation-id: 4992aaf0-9f87-4b10-f470-08dd10ba2655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YLfr+yNOaQ1A7kpyPNpHaJV4zU5G6KRD08CFcHILTkerX3EzH/RT0MEd34Yy?=
 =?us-ascii?Q?4b3fvEXyHGHfQ/9LDQIs7ImgdaZaGthnBBS7LlHIPKH3WgAsE0yfOYip7TW7?=
 =?us-ascii?Q?CRJofrKDCrPZiezDBYBKP5+u255BIOmlGIMgYza2nzVHFqzEIx+iFMlqTrHR?=
 =?us-ascii?Q?Uf8m0YWKkokqzmKzdmwkrP51NzNuDrjHPnnKFJ0AoMq7k4cOj4UcaGjqvqpm?=
 =?us-ascii?Q?GdPoBWjn2VTj4x30sAZ9a/Vy1kt07jxmsiug1W7ydANMSS1EK3UFz677CZBQ?=
 =?us-ascii?Q?gYME5r/31zbTa2aPigYfjudtF4M8T6b9jjkjM/1Ti3S9OeuqXXA4fp03QObE?=
 =?us-ascii?Q?EMKPwJC+33wShL392dw2Sply0FaelVJ9umyYFekAIJfhf8wYfeeNh77/FXEs?=
 =?us-ascii?Q?FldOziBtiUMWaGAG1g69uzNS1FTIksRf8l2kbJcbG2vCF3CY84SA3GuP4R5p?=
 =?us-ascii?Q?+xlo1O//s67S9V6Voro7NYnrfmlPWP6VBI3R/qbCLFqmPTTmQeyoz1CGifWU?=
 =?us-ascii?Q?Oe4X456+TiajT76xzMWOGnHC4vbfgD1dPnz+KVcSJb7AS81n+LbCS0oRfpnq?=
 =?us-ascii?Q?G1o9C2ZZ1OPyFU8DZyHTanM0oDp/ZvcF8RnssZF1CZlA+wUAWlD+H2T2XwrC?=
 =?us-ascii?Q?DgO09vPMot/kmnm0hFHtkrUugWjkwMr4xKqAIH8kvm4ak1I8M6y9nx+KoKeB?=
 =?us-ascii?Q?6kTUBPSWBLk57TZSoyv2ekGKbG6O9y4G12kjVvgB6Sno528pg3P1J/Kxcx5y?=
 =?us-ascii?Q?ctAsCOPsQlegs0VaToy5n4m0I/ANt5tnLLidXOFwc2opPJeywlcle4K3Adby?=
 =?us-ascii?Q?14ZTxgKcUJPiQesezhHdsjkap3uJ8AkDrZl9pULx3zr71x54/0bAX2oq/OwP?=
 =?us-ascii?Q?J2vQae8H+T4Lb1DlqL8NTlli/PU0X84UpeZR7Ovxaq11V0j5bPFA3zlFOA+w?=
 =?us-ascii?Q?sfsv9Pmu0LDqvSvIaZdmaXF3ZzAgudDSZwG6HVnh3w1PICfupgIzxqZoA4HG?=
 =?us-ascii?Q?8UWfUuWK0xz6kJTGbWqSuoQB7vYTQRXPRvcfDX5eL0h8fKgpshYCcuWUTVS/?=
 =?us-ascii?Q?GcYU9VWjhM9ksKhp9RI6OWDKi6l4zs4BEoRbIfIDUGhEdtPv+yteGvqZ80UT?=
 =?us-ascii?Q?WodIQCsOID5zAewH493HeU+dTgiybi7nDbbu3JCWkCEKzITUnQvumxmkAhgy?=
 =?us-ascii?Q?uSePH2GrdTG1DVHhac7hForlycMeaMuFlukhJhe4vv3YALACFGpgLoF35Pp2?=
 =?us-ascii?Q?gQ23fV5RCNe8N6L2O41dK724SCrl3nlbKAfaxTVQizpzsVEGl9sJBv7UGbuR?=
 =?us-ascii?Q?ATGYoQRLkOkL67AMkWVcQjR8ePf4XLVo3G3i2XuHAkoOztBviCTS3FdYRiUn?=
 =?us-ascii?Q?GZ0iSW7Wl2Z9tcVQSEofzxsld3dNORrbZHrOl7kp++gBaNW/ZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR18MB5692.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ti5KmuSeTVRKWHJZFdGGTO9+r1tfuGajWZFSl7A3xivdd+yR7SO0CMMk6mRp?=
 =?us-ascii?Q?KQJZT+Bi4iw6hlvvr1a6PPOpJYRMMSlxL+OCPiXo/kanIYdZHkYlUmwWOUjY?=
 =?us-ascii?Q?uwDRXLCUIRWhV+R3/u0NJJzf/1vvgv7BWy77m/ovn1YLb4wuDeLhSp+HLNpJ?=
 =?us-ascii?Q?1ag//nB70NxCGNWmutLVDdCAvtbpwWasvjVgm4z7RsNdS06yw1kxGfZY0kKZ?=
 =?us-ascii?Q?j8TzyDMpDm1+F3yvNRt0vaIwngBT43VgBqrrX10MVJfZxk5IiXHinrW1aJQw?=
 =?us-ascii?Q?kcQ40Xyt+55WRRb5C3osN3Y+C4gV559CJ64q1K/qGio5kB9QTztqynrMoGoq?=
 =?us-ascii?Q?iXnh+EF1UXJGgQ/fIjWphiUddpup2N9n4CBuAkD7zefcRNgTAhJk7gvnC02u?=
 =?us-ascii?Q?QnusyKn+7m7z3rj78lQBcCp8siAtfBrH0WoP38tUOfiyePv+3/6yb4Iidmjj?=
 =?us-ascii?Q?9zjDUqdhk77tGc2jcDU4g9q31twJ5Hdxx3iMJpOSqzwgHOtxXTjtvWGHdKjZ?=
 =?us-ascii?Q?3+z5TC5gqt7Rgx/wo3PBEXXBNkLZK84y1nVbGxLwgGtkV0dIhoJy4rz5tcgF?=
 =?us-ascii?Q?hA4DyhheMgnIm+EkBz473bu65zGFDFvCtN0E1eoQH8yX9NTyP9iFtcGkxDaz?=
 =?us-ascii?Q?Ig1Lyu19eFwg9svPNBIZdg2OlKYxh8EObbSe5ia2PpUnh7u88LRqPHzyAepw?=
 =?us-ascii?Q?S0Hts0eTvD3XEropez89G+XmumB+u3K2TimGEFOrewD2j/ybVDtoquox3VCT?=
 =?us-ascii?Q?l5NlJtj/l6M7YndKokJPOwfvRa9iixXd3JiyPuj4Jz8U0rw88tyxUcWB1TWA?=
 =?us-ascii?Q?o0YlYC3T3WUGROdlcSzTHGyYzNvunScBU36NeFVVnAcTWmQcjsMOi4dLHYEe?=
 =?us-ascii?Q?WJgUwbY0XsmaLIJ1wSP2+JqARuB6Y1r8FfAHDk92HomTK9szH6ZvZKt2RnGI?=
 =?us-ascii?Q?+lzBTuxwdvPaEncZvF1vV9sYKKSkBc9BW1GiThvpJnq/v1ZY0FubHA5G9eoF?=
 =?us-ascii?Q?My6Vr9W46NDSW2qdQKrI2h945+flR1cemBPKHhjwYtT34eckUG6o6nJfs7xF?=
 =?us-ascii?Q?1LAjj1g6Sjk0I9xRMfA2gbF+awArpAyIEdF3b2GumMpwKlaLubxUZHN/RHu9?=
 =?us-ascii?Q?augbSo7O/iT1fS5ua4/On7cODUpAF3vmKImACK1/F6V3yK9kmMulKY/qGNe0?=
 =?us-ascii?Q?cJAev/VFvZjtXB+Vdzpkro+iSCCXI47mtD2KP/pRmyknau3ErqwZ0ad7qKw/?=
 =?us-ascii?Q?4hVrKbQQ/Ivv2wevBNSTAepYQGFPIyM5nMzCGAT62S9HpD6gTXrcvBmLT7Qy?=
 =?us-ascii?Q?4zL2CKIW+YIvyOHRskXEjmn06Yf8qjHa7TZjlTPbh6grsRrxPONu2wOcKhkK?=
 =?us-ascii?Q?i/aFW4z4ArvrbsQ3CtZqXmqaxGniEWygBJg5F3PPAxfZ6ygPZPxnHcJ/2QJB?=
 =?us-ascii?Q?H0dM7tSFEK5yMfGS8WsdvU3IKdhX0tLC2q88bUYI0SatOuG7s3BaBFHZ/ElO?=
 =?us-ascii?Q?pbM/zvKa7osAS3QajVbt9A1tA9rd7cMBknJmH3+N/WAfjw0sXzt3p+8K+qlE?=
 =?us-ascii?Q?GeNPfo/mwwgTUjv4DVZXsG2YtZeMfpHtknpAwve4rwNYn05OwLUrEGmBNJA8?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0ztgjY5PgZd1eNGgY7MOJZPPa/zSLC44nFs8OKNkk+8EwTsG9cuVfiGjmIVzEGCQeZY0lTV0qs34MLd6wHb0LFgs2rzCZbUVn/Y0XD9ug5+x4CURurCKDajjgPl8dRK+AteWa8iCPaa5paAXSBcYkgGke0slAa5ZwUSjkv0CEeN5qq72AWzLcXMqjQTLbsM3+ic/xrJgOzJtAiRzop51+kgXemltDy9uLBcPx8lC+7syBYElwmcp+ISqQjbYxpWFb3FDxCAG2SWqgRcoMt2hSdn8yw/YNsSwaKvgIPPFzlAqiMwF8NLcOnT6jIqfpf6WPo1yft+gIheJQkE2X8uYhGmk4YPJht9x/rYFM6wOliItwROddDoStBo9YUfdEc1tuutFuNz+gctmP3IwZLtwQWULJo8bYCydGap0LjRW+DOIRTzz00Cw9CuWaoOpLEcRn2V8NN/c1fODpCCpSR/qh8X0Jj37vcUZWglKvPm3EqR97CNCI3miujW5jIMuYQQaBnM5M2Mw8XIkcQEyCeFktYOUa2k3az390snHosuVAEDflpue7UKAm1jOyYxYQLx54Nv5z9Yee1L4GxVbbEcpcyFwr9H5APifAF6ipND148B8Swl/DscNTl01RBh7zowXhMWm6J5j6+ZjOKVPX+JqNg==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992aaf0-9f87-4b10-f470-08dd10ba2655
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 21:09:44.9430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JXDJlIWRac8oJIoD/DULLB62I7kYyNzjdEoRardR1FX+PNkHe+MSRn5vk2c01DYJkp5OS7AUBkrWler5YuICZ63a0xg3sMLDrnkpLo0IyoYMkS67J0mBVBSFkaFr6Gv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6105
X-Proofpoint-ORIG-GUID: O-GuHIgOIjvy8lD9yI-DEuyrQ46JANN3
X-Proofpoint-GUID: O-GuHIgOIjvy8lD9yI-DEuyrQ46JANN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290169
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
X-Mailman-Approved-At: Sat, 30 Nov 2024 04:53:49 +0100
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

The fix provided by 997fc12ec91 is actually introducing
a buffer overrun, and the overrun is effective if the
memory after the reloc section is not zeroed.
Probably that's why this bug is not always noticeable.

The problem is that 8-bytes 'rel' pointer can be 4-bytes aligned
according to the PE Format, so the actual relocate function can
take values after the reloc section.

One example is the following dump from the reloc section:
  bce26000: 3000 0000 000c 0000 0000 0000 0000 0000
  bce26010: 7c00 9340 67e0 f900 1c00 0ea1 a400 0f20

This section has two relocations at offset bce26008 and bce2600a,
however the given size (rel_size) for this relocation is 16-bytes
and this is coming form the efi image Misc.VirtualSize, so in this
case the 'reloc' pointer ends at affset bce2600c and is taken as
valid and this is where the overflow is.

In our system we see this problem when we are starting the
Boot Guard efi image.

This patch is fixing the overrun while preserving the fix done
by 997fc12ec91.

Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
---
 lib/efi_loader/efi_image_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_l=
oader.c
index 0ddf69a091..04075d83cb 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -121,7 +121,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BAS=
E_RELOCATION *rel,
                return EFI_SUCCESS;

        end =3D (const IMAGE_BASE_RELOCATION *)((const char *)rel + rel_siz=
e);
-       while (rel < end && rel->SizeOfBlock) {
+       while (rel + 1 < end && rel->SizeOfBlock) {
                const uint16_t *relocs =3D (const uint16_t *)(rel + 1);
                i =3D (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16_t);
                while (i--) {
--
2.34.1

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.
