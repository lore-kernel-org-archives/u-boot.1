Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21498C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E20180F98;
	Wed, 19 Feb 2025 14:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Z6d15ONt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D286080C98; Wed, 19 Feb 2025 08:20:57 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719C4801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDSyOKFTg+F0k8G+7LedCLmUWt/QQPEkN7nxMWbzzkoO/5SwwPZoAeRPPoI7DjlaAh+24Jt74WcS4Fm153yXFmZDi8zKASxG5R9rfuM8KO5gHPMgAsinax4O6timDMj+j1QGjjjm2+/k22PwJEX2IAa3PRpiirQWijz2KO+sofm5LnpQVOLI/gk8vr7fORy0Lu7MWd81EQe7RH3UJ44/ETdzNt6grsj5lLMu19p3B+J7cCPAWGtsAB4hH6aSwjTLrthv9L0qy2d/HgljCZHaDjbCZd9AYOTMvap9y5cR2iNMajUInp892URdXkigQJwUg4p9lHNbkjFM4PdHZt4PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYw7WszzxpV3ak27eP2A8qvq9hGqBix1+zMu/WWrxQw=;
 b=BocPb0HIc5xJT3QQq+NgwSk8DrLw0Fvl0ZNyqfSRxGRn1k3CpZjag+MlZRk//QBj2qJAK6MoBOsafj2APl32fihobagJJTNPzZrqj1kdL0eWHzkwkewZvj6TNAKv5IjVfTPVkumn2GpLEpAhE6uJybb4LO+afMi0ILPeEwKuD7+0+rW5CEadS16xPvqa6aWr3ePx1hJElYcn+iQx2uo/VqOD3QM0NAJyeNxGaEO+QPoqC/5yKjlSZI93Fj+4wQmI3b18ZFfAHXxWhhqmbfSG1JErzgzqXB45AlMZlMYnixqUFZrmMzjLreUWgMKPHwB5WACB3MH2ba8ZmcznbbWnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYw7WszzxpV3ak27eP2A8qvq9hGqBix1+zMu/WWrxQw=;
 b=Z6d15ONtaEB6CRfwmOkB3U1GV07Utytq8l8KdnsUMGid+ei4Tl1VWWXE4Fhb5I8Tov1hj1+IeKkb2N56s+YnkCCnL2r+WZoxAdSFXQYkhE99Gy97A0+isejog+CTIXtaiHo4irxLOn3nAgzsQcKu7K4LKhNPNA9ssA8aiGKrnt+O+VhUkrbcR3CBkIe7CrbwbkjVhuhxo0lkarRq4JzOvDoxEwZNNOmix3LPMUJlQEINdM1y4zciraCJMZDnhcAVTMuIHhH0naCoPo51G8R+SifmtJAwlAE3ZgS/zhrWrrgTGlk5dS5gRNOdtJRQL7D5qk66v0eVkWAWWAkXh9BZDw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:20:53 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:20:52 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 10/26] arm: dts: agilex5: Add firewall configure
 settings
Thread-Topic: [PATCH v2 10/26] arm: dts: agilex5: Add firewall configure
 settings
Thread-Index: AQHbgeAbGDuJMfpH40C9oZ9BHF/qcLNOOdVQ
Date: Wed, 19 Feb 2025 07:20:52 +0000
Message-ID: <SN6PR03MB3583F51E80175C42D3BE02D3A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-11-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-11-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: a6dedc27-f28b-4ea0-1462-08dd50b5f19c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RlwLhgDkZntXbdHUz/O4qSDWGtvTsjJqXLlF0RKiWcecobQQW4tSlmhTPW1K?=
 =?us-ascii?Q?2BtreZ+pDCsmeJJLTduePubUAAfj0ZLm4BYZPGELvtAsmrkVmUhbJ6jlyoF4?=
 =?us-ascii?Q?ETgDoDjYUAdbdKVpwB4CouuFJyVRmxTiLNxLwcowJQvkuSgvu4PQBVTHIsgZ?=
 =?us-ascii?Q?xYc2fhqPSl0At7cwu92Dlj5ywVIwu5kpQRfL3LhspQxEsCSbdai/nVm4fe1q?=
 =?us-ascii?Q?RZz+iN4/mRnkyIhgu+z045UpTsOWSd/c+bIYnmR+t4W/+2bStg/Izfs1sBnj?=
 =?us-ascii?Q?9OUtwr3GDD2DlWO6tsyHFGq69bUGop1ejSevV0r8JI5hq6TcrBBVcKaG0yNb?=
 =?us-ascii?Q?RL72yl4mJ8n5/DnXM3du2r6e7iFbJiWvoNoz6+Xir9TeBIwqcPTOObHP5A6k?=
 =?us-ascii?Q?c+D620XfWd9k1lgbasy5hDEF3wVzMNAtEvLHkvrMmAu4oGjNK+NxDE4obcaT?=
 =?us-ascii?Q?wpmyKuTZaR5D87RLODjrGHCidDobXNw5Y1zKaf1hts+9UfuX7oqo4p5Zqshp?=
 =?us-ascii?Q?LneI0A//G4d/Dya5ENno2jIEBQtEFGsoRT5LqNOL5USL2JoS1WjFCxyRJQyV?=
 =?us-ascii?Q?kl3FDzrCp3nt6uCGVHPAC6h10Wi+wM4Dtd9dDM2CWaHwpqEWx/k6Js6vLWgv?=
 =?us-ascii?Q?FvFf0/yq6Z3EfEsb3kEPlSxCcKbpXOEfEyYnsjLX2RVJC5IyEkKOS81AN+co?=
 =?us-ascii?Q?Za94Am32qfqvOajWewCsMPwa56GH+2XZvFFv/kynO6QXn3xbRyJF9wODxn2c?=
 =?us-ascii?Q?8Xp+HS9D5+JuN543ujujWHUurOlJcvepBOTXpXprA0RCxE2vsSNdo8lFlRYm?=
 =?us-ascii?Q?AkYIySuhBE3BFS8SJLuJDfM8/ZtMbuh7+Dz3etUth2fIzef/WAR0IZwI5q0e?=
 =?us-ascii?Q?FUBaSpR18p4YfevGUN3nW61kKlfs1pB52eyf9kZOf7qnw1Mt6nQF0QGvTCiK?=
 =?us-ascii?Q?iaq9aoDM7InPic7ahigqBdhzsskSysiza8Y73mBovY1nt88hoVwYbb1AYOFp?=
 =?us-ascii?Q?MMBtjdJj6LGbGS7Ff16hPNYZwPV2uUQX+kMh693o1PpNJVDt7fUDI/ibTDPZ?=
 =?us-ascii?Q?ERDOJjxzVhrX4NsFAkjUCxVWZCXXSf/ogPReHQjFHr+h+Ou5SYcLgQUUeSz/?=
 =?us-ascii?Q?zuWoHNVCqywjrv56MXGEK1AkEf1E4IZIHjxbTK2VyEGg0ttL7yAi5TcjAPSk?=
 =?us-ascii?Q?QZt4OoLQwJJ8YAghJ8oTsHPlliNNsxHHyd3XNxMC1uJl1EnPdmleqvqtzhOW?=
 =?us-ascii?Q?odS0DTPzCD3il2LycSJ2hdnqvhmNWdlpXA7zTAW4j41bBQRdOe+s+pHSJPM8?=
 =?us-ascii?Q?0HMxHdM4YrxnTYyC03Ewi/6oFtmKi3f+vag608cD/F39DxkT1HDM4yQI2dmX?=
 =?us-ascii?Q?iTnXW+enzHeFAPLQ6AvAnz7e4eH0Lr7RW+0V5pyt5IKzkHAHjdO1mcQpxJtR?=
 =?us-ascii?Q?J48QYOlGeOA+3qIhcV2TMwk5RIIBtJvp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ys+Is/9LOXmCJModXQXoutG+El2lpIuwGn+ywvWo2jp8j4VKI9nZubIHxilm?=
 =?us-ascii?Q?yktl2NYez+zzJVPWURVve7Ocz8CDCOUnRvHuWI+RgfFtvepDnPePQSs4TIBu?=
 =?us-ascii?Q?R4MalTXs4E/wPl18YSUZQHQKFR6z832+No611THNSL8q7O3xOsxptGJN4hUL?=
 =?us-ascii?Q?XL0viac5O9JZCrdAc5U+Q8D2RNGj6dD796C0G3mNy9tglu1B6BAMAMYIUmxb?=
 =?us-ascii?Q?f0/fSm6gIdpl/fUe0+Zp+fmG2qdq21vTLrf2attWT52I20BvQGJNSP60Zt1K?=
 =?us-ascii?Q?7P6de7uaEa8nNCMORhbUA+w4OdI981XosMVqyJObCjPrZ+EHeEBcUrEeHSDC?=
 =?us-ascii?Q?as5NupLk7QWfzEc3vhnY/k6Ry5t7y6wVZjJ0DudDU6fT2/KtmUEmPfSJVeFw?=
 =?us-ascii?Q?i3QXZDOU1XIo46j/n/Y7RNOvBSCoWYCdXwKLFb/ih/0lMKu1Dt8/vh9uLroJ?=
 =?us-ascii?Q?uVzeQ+ONX71C94tLJLxI/Z+9XWtac+YqXUCxw5OQawfb5Dh4x+r/vUjwMMCz?=
 =?us-ascii?Q?WMY3LZxk7ofSCpFsQqfCTLAJQb+r/e8nhGJuk4iKpwMzO9TksPrCg3iebsnU?=
 =?us-ascii?Q?SfYyL3hScdC8tdmW+dKla7tC/vIcm6o+Z/4lu0Ehebqd9nSuG++5E3PPVHhj?=
 =?us-ascii?Q?yyDyKTM+SCnhHCxnbx4BKaWHGFcGKG34/2C4Xd0lLKvZ1TddqqQ06w+ShsMC?=
 =?us-ascii?Q?R6v60EjzWKttALfo27teLmQ2KlT2bn/hhxDjb8PCeF16nuIcu1FrrDyz5CH4?=
 =?us-ascii?Q?e+vYkreG/4xiopnoriIMXTJyGyi6LyGnvF2jF4v6Bk3/3fyIyf8FrrXwSrhv?=
 =?us-ascii?Q?DCLPP9hNWSB1dkmhBH4/v21cEDfDHkv/Rww4+eX7oyImUmQ0ddTUxOwNph5B?=
 =?us-ascii?Q?wjKyCeDa9uqpZyTUir94IWE3oZo5ovLbKBmAcRbJIvMoV4hLkh0PdyUOC7zB?=
 =?us-ascii?Q?GhYE7lnJQY0bb7OzTb3UIaboaEQl1LMWq1hdUoGCbnYDXuIizINWT7UKbKQh?=
 =?us-ascii?Q?h08ydA463AUHAvUqH71CgKucsEgG1RGKKTw8b6w632ZkGPlJaG3M51ORT+0C?=
 =?us-ascii?Q?UtDUpUQKylQZn7RFtMk7o/tk0xfDSIbsWclyKERl9lbblha9+y8Il1A3eUjW?=
 =?us-ascii?Q?tTRpMHtzRMMf5oHvVGOKP831Pgi/D18J4T1jU6WsA4+DtNGW6roY9AsYlsVn?=
 =?us-ascii?Q?nDVCb8xHKrqOA/XnPkfzq+q8c6HP9vu97qHbmimnPrtVkX+WF7pk8DGMZnE2?=
 =?us-ascii?Q?f2oNRUxW/1D5Bop4wkx6EYEKIPzIYII1N6yrl9Lq4A3By/ceviT62pCSF03z?=
 =?us-ascii?Q?JcbEvIoebCaXNOgDDO+cEz+qzZkSXQNuiQNiqUnoAs0GUH1m+0+edkJszvcK?=
 =?us-ascii?Q?gKTqX6DXuAxTm84Y9Ze69txN0dHBIi+kou5eZu/oThuWtVwxd2wiDkf4+0Yy?=
 =?us-ascii?Q?YC/TuTAnXnMpNJxhsiJgcISC7v0+aa2ZzB5YWpDytL+kJBKhF4mqcM01+uge?=
 =?us-ascii?Q?P88ylgExYDp/NotvK96f00zplwU9RY81z/xpQDOudbYtKxkZ83aK0JFzzB+4?=
 =?us-ascii?Q?52J3tisx6YVrR08CiHlgfLbFHMUYcJD4H9XLk1UC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dedc27-f28b-4ea0-1462-08dd50b5f19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:20:52.9212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+3hOElSvJ/0Jy8WBoq54AM8H+e8YG2WuEvabm2xHyZfc/vs7d1hsI823AXMBxKvAgObKlu4NwNIishh6rwVpf3XHGCYAjfFgtKjSDt/S+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 10/26] arm: dts: agilex5: Add firewall configure setting=
s

From: Tien Fong Chee <tien.fong.chee@intel.com>

These firewall configure settings are needed to disable firewall on respect=
ive hardware component so both secure and non-secure transactions are allow=
ed.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 166 +++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpg=
a_agilex5-u-boot.dtsi
index 4270dce38df..08f568f5650 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -222,6 +222,172 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_firewall_config: socfpga-firewall-config {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* L4 peripherals firewall */
+			noc_fw_l4_per@10d21000 {
+				reg =3D <0x10d21000 0x0000008c>;
+				intel,offset-settings =3D
+					/* NAND */
+					<0x00000000 0x01010001 0x01010001>,
+					/* USB0 */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* USB1 */
+					<0x00000010 0x01010001 0x01010001>,
+					/* SPI_MAIN0 */
+					<0x0000001c 0x01010301 0x01010301>,
+					/* SPI_MAIN1 */
+					<0x00000020 0x01010301 0x01010301>,
+					/* SPI_SECONDARY0 */
+					<0x00000024 0x01010301 0x01010301>,
+					/* SPI_SECONDARY1 */
+					<0x00000028 0x01010301 0x01010301>,
+					/* EMAC0 */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* EMAC1 */
+					<0x00000030 0x01010001 0x01010001>,
+					/* EMAC2 */
+					<0x00000034 0x01010001 0x01010001>,
+					/* SDMMC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* GPIO0 */
+					<0x00000044 0x01010301 0x01010301>,
+					/* GPIO1 */
+					<0x00000048 0x01010301 0x01010301>,
+					/* I2C0 */
+					<0x00000050 0x01010301 0x01010301>,
+					/* I2C1 */
+					<0x00000054 0x01010301 0x01010301>,
+					/* I2C2 */
+					<0x00000058 0x01010301 0x01010301>,
+					/* I2C3 */
+					<0x0000005c 0x01010301 0x01010301>,
+					/* I2C4 */
+					<0x00000060 0x01010301 0x01010301>,
+					/* SP_TIMER0 */
+					<0x00000064 0x01010301 0x01010301>,
+					/* SP_TIMER1 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* UART0 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* UART1 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* I3C0 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* I3C1 */
+					<0x00000078 0x01010301 0x01010301>,
+					/* DMA0 */
+					<0x0000007c 0x01010001 0x01010001>,
+					/* DMA1 */
+					<0x00000080 0x01010001 0x01010001>,
+					/* COMBO_PHY */
+					<0x00000084 0x01010001 0x01010001>,
+					/* NAND_SDMA */
+					<0x00000088 0x01010301 0x01010301>;
+				bootph-all;
+			};
+
+			/* L4 system firewall */
+			noc_fw_l4_sys@10d21100 {
+				reg =3D <0x10d21100 0x00000098>;
+				intel,offset-settings =3D
+					/* DMA_ECC */
+					<0x00000008 0x01010001 0x01010001>,
+					/* EMAC0RX_ECC */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* EMAC0TX_ECC */
+					<0x00000010 0x01010001 0x01010001>,
+					/* EMAC1RX_ECC */
+					<0x00000014 0x01010001 0x01010001>,
+					/* EMAC1TX_ECC */
+					<0x00000018 0x01010001 0x01010001>,
+					/* EMAC2RX_ECC */
+					<0x0000001c 0x01010001 0x01010001>,
+					/* EMAC2TX_ECC */
+					<0x00000020 0x01010001 0x01010001>,
+					/* NAND_ECC */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* NAND_READ_ECC */
+					<0x00000030 0x01010001 0x01010001>,
+					/* NAND_WRITE_ECC */
+					<0x00000034 0x01010001 0x01010001>,
+					/* OCRAM_ECC */
+					<0x00000038 0x01010001 0x01010001>,
+					/* SDMMC_ECC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* USB0_ECC */
+					<0x00000044 0x01010001 0x01010001>,
+					/* USB1_CACHEECC */
+					<0x00000048 0x01010001 0x01010001>,
+					/* CLOCK_MANAGER */
+					<0x0000004c 0x01010001 0x01010001>,
+					/* IO_MANAGER */
+					<0x00000054 0x01010001 0x01010001>,
+					/* RESET_MANAGER */
+					<0x00000058 0x01010001 0x01010001>,
+					/* SYSTEM_MANAGER */
+					<0x0000005c 0x01010001 0x01010001>,
+					/* OSC0_TIMER */
+					<0x00000060 0x01010301 0x01010301>,
+					/* OSC1_TIMER0*/
+					<0x00000064 0x01010301 0x01010301>,
+					/* WATCHDOG0 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* WATCHDOG1 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* WATCHDOG2 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* WATCHDOG3 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* DAP */
+					<0x00000078 0x03010001 0x03010001>,
+					/* WATCHDOG4 */
+					<0x0000007c 0x01010301 0x01010301>,
+					/* POWER_MANAGER */
+					<0x00000080 0x01010001 0x01010001>,
+					/* USB1_RXECC */
+					<0x00000084 0x01010001 0x01010001>,
+					/* USB1_TXECC */
+					<0x00000088 0x01010001 0x01010001>,
+					/* L4_NOC_PROBES */
+					<0x00000090 0x01010001 0x01010001>,
+					/* L4_NOC_QOS */
+					<0x00000094 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			/* Light weight SoC2FPGA */
+			noc_fw_lwsoc2fpga@10d21300 {
+				reg =3D <0x10d21300 0x0000004>;
+				intel,offset-settings =3D
+					/* LWSOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* SoC2FPGA */
+			noc_fw_soc2fpga@10d21200 {
+				reg =3D <0x10d21200 0x0000004>;
+				intel,offset-settings =3D
+					/* SOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* TCU */
+			noc_fw_tcu@10d21400 {
+				reg =3D <0x10d21400 0x0000004>;
+				intel,offset-settings =3D
+					/* TCU_CSR */
+					<0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+		};
 	};
 };
=20
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
