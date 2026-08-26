Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3FCC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 10:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32B4180B89;
	Wed, 26 Aug 2026 10:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROyTShVSV2DI; Wed, 26 Aug 2026 10:10:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787739011;
	bh=B4raq7VAw9OEprCZpwx7AP/SGFKr9tdE+e91NxAmw5I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/gkHnxTodt5UPhls8jmX/nNu96vMd6HtwXeXF5UiZqtWDJ82j73BZGre6Zbz4vAA
	 +OXe05BQbdLmfxmC0H3H6xFOMzPe4VHLJr4q+qr1rTGTfRBFV+aL9ei79XgLplwUe8
	 1zncBfDBwbmnDTLapuLqkaw8EHFC0RAbbMYL+2PCWBAgNlCL6Twgat3F++Q30+HA27
	 kSsy4Gw6g9vBhH4BjPOqmkb/5u6v8sYLXYLHLxOj9R+qgR4KZtDuUvMxd4e/oPuqKC
	 M80elZ0UxL9gyhABnv6d0jZFVoq4NIYN7um3OcBb9rfe24U1RnVO4B4N2y4CqBTFyy
	 GMAaNejBcdl9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59BEB80B7D;
	Wed, 26 Aug 2026 10:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F136C39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2C5E6070D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8Yax_1OV00u for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 10:10:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wrl69NpU
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 388216067F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URKsqQ8/0FdVy2Htbpa28wX87BTXc+T93+umXTC4Dc41PXAV+x7P1wMo9+YD2bO7jsxT6bNOv1cI9RMLxMyIvDJkoFy+ZNuXf0SpZCFdmJIYWuENXeQlfqSUsCTuORJVHXBpo7IKXTwps/3PCMqEjVREZARKmhixt41Qkvb5AKa/oW8Ou6bkR15x4ecPuhbY7EwdmhHxEgYGlDJ0l6yuwIlKqzooflCiGuZV+vGYve7QxWW0gCMuB+VEtMzYVKABxWqv4HxyoWCF+B97nQcX0QFUozIfjYvMbhJh3gY2kO/d1LN8iFvBVYgTLktV29uJ2/wuZmKCOnf5uNw6eRhdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4raq7VAw9OEprCZpwx7AP/SGFKr9tdE+e91NxAmw5I=;
 b=Nu4OxRgJxT1KCJuiTdBLLvbG4hHBs0uuZaJdyTkqMhd4LSAohfk/6+7jdxKgx11VsjmYvG1UgkNZquYyzhAY+zD9Ahojfqy3rBsNfX92hoHjMXenrFmTcrUFLN/s6HgsXHrUia3FOPTVXOrVbPGS2yULd0NDaHcZmFa3amDhTFIH8gDAWYGfOJRJbwoDfz0P3Ck54B+nju6elqXPKT3RsPieA3G1Cw47xWNrQSfscNCFLoTHeeY5989//LwnJ+TwSEPupLVaE4KWxUrUIv8FHlUYxJl6pk2l9I+T1gyHtygfM4HriHlqeJb9yaKYKip/qaAuh5up8DjYZ1cYUjbMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4raq7VAw9OEprCZpwx7AP/SGFKr9tdE+e91NxAmw5I=;
 b=wrl69NpUUI4f/N+pEuBtJcxuIfMxZPw2qAgtWIqn5td/u9KVci0sJlvFIBLFuvQHwivYiAq7v+R9Da4pX/1Z8J3SYo4yAhIoRZrRlzgKOkmjLW2odew3lYBVI2ls/+yhmR7QRvTMlCCh4zq2Lv5iiACfG1x39j+w8RB6a6/pvsIHN9zPn+WuCQGLa2ddwHrzCy9Oz/ed4dPRi2afNsSWki1VO2q5rIdmNjGqqgwqrnVMvvy/cXgOivI1JbJkEAsduKjAPnfJCaAEu/IWqnkkPwWM6wfI2ylfxKW13ZLG4kNAJN2O7D1TMNT2m9dwm7c/GlP9W69ugR6oJyKbA54itA==
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB989172.namprd03.prod.outlook.com (2603:10b6:510:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 10:10:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 10:10:04 +0000
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, Jens Wiklander
 <jens.wiklander@oss.qualcomm.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/5] mmc: Call back to optee after a successful mmc_init
Thread-Topic: [PATCH v2 4/5] mmc: Call back to optee after a successful
 mmc_init
Thread-Index: AQHdMzg+mp2GFGjKTUW7UZt60PCMabawB82AgAAXrIk=
Date: Wed, 26 Aug 2026 10:10:04 +0000
Message-ID: <DM4PR03MB6208B1210583DB7ED1ED4258F9AE2@DM4PR03MB6208.namprd03.prod.outlook.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <ddef88ae1677f4c9b793252483f23eae900b89d1.1787514446.git.jan.kiszka@siemens.com>
 <ao6nc78dvKK60egJ@nxa18884-linux-1.ap.freescale.net>
In-Reply-To: <ao6nc78dvKK60egJ@nxa18884-linux-1.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-08-26T10:09:17.9666413Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR03MB6208:EE_|PH0PR03MB989172:EE_
x-ms-office365-filtering-correlation-id: fc312d52-7391-4147-6d16-08df035a32a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|22082099003|8096899003|55112099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: cxxlAVYyOM/vVhaghuhRNJbrrKQyO1l+Zc1JHZ/CsBSUWlSwPfO2vxwQ5k+7t2K91BEIqvRQiFARGddO4bHSK82Zwf7cVw3rJarEfmr8eqxl1w02iIAUS4pcBWii77UKdg3j3i0oIiXxUIf0IrQMnD7ZR5gBx2VkZ5dxgP9DHjy0ucL/nGec1iYJ4eD83W9DozfvSQG36AARSRsJtLuXb5n5RJY8hRh9D0ECSSKVMPtNJuey1swDBDzrVVtpFTt7ajNeYw4u1e45TOx71Go55T6GZJZmAxvRz14UXOhy49l7ixsMgi+XNe5bfrYzec2fuRDEAxhYA9dBujR895tgz5+qQrEK/nCzbEaIB2+TZ2//5EQJx1XHcZUwO/mMsEunvVhOJQCzi2dszeWHAvYzcFJaqCgJWBqhXi0Abxf4NdI9SN6384ZM28ocB3P1zixkaNIfyb2y9vNv7k4yF6DpBe798ERKApRlQeyx72U6qeDE6Dr4lDibQmHfQ5JdOyy+DrB8wIsLhcIa58IwtXYJW13TAVFifQsPZZxa0fNzsnklW71+/qHI+3xnhUgE8EJZXRAP4T/rlDLn6njHqXioLdE5lxGLjS/j+T1vZe5yWmcrku2KribZbCazHeiSOHGGE3ojC03vLd+m1zRGlcT2bVJIoObsFw/VqgcIbIWi1Gl2Vn4F7VyxleKHjSa4orM3nOl/KOwpuoq5H+1l9UchDHlogRe2LgcK/1UjZdPxxE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(8096899003)(55112099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZbiF1GH+LxVXVYTR3HO3AMLnde0XOluIg8eoDNJvU/1KQpzkR9xQ9+4HkiPD?=
 =?us-ascii?Q?A2mKMyXfwG7LDV1MgSK4gzp8QftHEUYWIOWmQhllwzlkZ8bwP8AcN6gV0Bv5?=
 =?us-ascii?Q?t8zsEG4dVewnLp3U5QlG9n0BmZB+0hp+0v/MlXIV4YW0e2NnCKgfdurl1wH2?=
 =?us-ascii?Q?Na7zCMw+4Qsj2I4GUBL0miMiinIAzdWN/JT62hxPlRcNxghO6i7BsTYGXg54?=
 =?us-ascii?Q?7DXcy8t4o61aNesaHt6KvsV/Yf6CcZvH90LzG/IYGUaL7FcEIMAF4Q5mVOs0?=
 =?us-ascii?Q?PU62KFfIGeUfqOqFG4yoC8cjQEvTqdX/IiS/6WlXeG6890SAM+FW9GFBWIVq?=
 =?us-ascii?Q?zSsoCwwX6qwSUMgFNUuW+3bohoO6Yy4L8PDx4/6PU7REX2Dn+HYVKqZI+Xk4?=
 =?us-ascii?Q?jL6zvT/zpJbEdW6r/GyDHA7b4o/X/Wa3wxWBAHujPfsdgWtBur20poQ+lvX0?=
 =?us-ascii?Q?VT5RrlDDNUQLnXSLRKxRYA2Ybc4/08BA9TZ5WJvaT0bBe//qgafwJ5d5bnDV?=
 =?us-ascii?Q?mv15VTAUVgBZg+sLwCXX0hdcB4HEfthRMxsVua3n5Sc6xNMCxKNf2SK5M6I2?=
 =?us-ascii?Q?GhesxO5TpmIOBFqGGRB5VtHZs9aZ7GqdiNYOp4Slmsn/hbff+FJitYa3sXs1?=
 =?us-ascii?Q?ELDsYG1zxxpINaDnMf+ENW7Pcu/pbF/AOV3K81A39SPKBloDd1+OT9CFsu2F?=
 =?us-ascii?Q?sefYLzkct6fDJ21YELPXxSHpBYEJ4sFYaTOp/TmkVhKkbIxoaWBGbBMQyTtn?=
 =?us-ascii?Q?Jm/T3ZywqBR00WdWHgQWzZW79mG4tb8I8uvlsLjs9TLaUNrqzO+iwHsleuKV?=
 =?us-ascii?Q?GXS8v5CEPodMRVClAsWZb79D5n/OtTbLVOQ14AmXaq5byxNZAzev/4kfSvkj?=
 =?us-ascii?Q?e0OB47Jb9sJolCb8mJicU0qLIUrO3JsVWSYh8+viTkNln1n3AEMDweJpWBAS?=
 =?us-ascii?Q?4zg1CmEPlmZGY8kpp2z4mMPwLCVgO0YHZ0atVOw3rJZBsRkcysm6ufSTFnYs?=
 =?us-ascii?Q?96Cj7jRkxrzDgL8LuIOIcTupRdvwvdiIrBMQJVwINuziP026B2sk0aHuAoDb?=
 =?us-ascii?Q?0ZNbuTeQ6cjXF5SCjZ1CG/kNacQ5LPNElMKzH3XOwdX71DRl47TuoHHM/zfd?=
 =?us-ascii?Q?gLa+fRxf2QXwKRRHVDQlXXDR1hgsy2yuCa8TXql0+YijCPnHjyhCACWMMeFZ?=
 =?us-ascii?Q?e9r5+oYgdfu7MdZVW8IALF3ASQNA+d9Brkp/OM8eZP5NWMQYlQUHi5gam6Gb?=
 =?us-ascii?Q?1nR8kIIoWKfq83xlA4ZFPDT8ntsJqkLaNqXDM39aSlqpGOBHJgKkefavLaVq?=
 =?us-ascii?Q?fXCEFGsaK3ZxzjWIM3nAMEyU2guJOf1U6JNgAJIAQCLFVBqVOG/rPVcHewYc?=
 =?us-ascii?Q?pAmJyyrIbzuFkUO0jN1hyfNOnl9V/kCD0HhshMbFk3psoDeFga87eUTgG0zM?=
 =?us-ascii?Q?htwzaMI08/IZJBzs2Z36lDZU27P8IVOqsu32Hi6XfsyAZUVFdv6g6y5h6PeF?=
 =?us-ascii?Q?TbHfWTTDNXHXpoGeAU4XmDJ4cWkrAKYiQTJBs+HFTrCE1oo4B21fxrgw2b5b?=
 =?us-ascii?Q?f/X9AilzJLsxpIeZV8d0VjbbpDrOwIdXIMBvPTi5BNRBCFiowrbPYExvq8Ph?=
 =?us-ascii?Q?2ftUYz/hXwyI9bVJdnRtLZKqRXVaWoTk9GJCkEYtJio01dvQEqg2gAqxhaxZ?=
 =?us-ascii?Q?UlgQs9qngYd+op+lLWfwr45nozEL6MuxlWNmhxe+ZPmVBK+u4dZ//SBYPWNJ?=
 =?us-ascii?Q?xhuNxNujq7XgYUqhJZnmw/Xic+l5O/A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR03MB6208B1210583DB7ED1ED4258F9AE2DM4PR03MB6208namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc312d52-7391-4147-6d16-08df035a32a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 10:10:04.0833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Y5DK7e1Br+tkKqpM6J91rm8dBHW4SkCyZ8O1hEUvuagVxgKzKiz6WB3nnBqpdqbMu4MtHuNIY4fq0yDnJ5vxrkHAJAhUwJfeauGdOTk5tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989172
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--_000_DM4PR03MB6208B1210583DB7ED1ED4258F9AE2DM4PR03MB6208namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com<mailto:tanmay.ka=
thpalia@altera.com>>




Altera Confidential

________________________________
From: Peng Fan <peng.fan@oss.nxp.com>
Sent: Wednesday, August 26, 2026 2:17:09 pm
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>; Jens Wiklander <=
jens.wiklander@oss.qualcomm.com>; Ilias Apalodimas <ilias.apalodimas@linaro=
.org>; Sai Sree Kartheek Adivi <s-adivi@ti.com>; Alexander Heinisch <alexan=
der.heinisch@siemens.com>; Kathpalia, Tanmay <tanmay.kathpalia@altera.com>;=
 Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/5] mmc: Call back to optee after a successful mmc_=
init

On Sun, Aug 23, 2026 at 09:47:25PM +0200, Jan Kiszka wrote:
>From: Jan Kiszka <jan.kiszka@siemens.com>
>
>This is needed to that OP-TEE can re-enumerate services which need RPMB
>access that may have become available now.
>
>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


--_000_DM4PR03MB6208B1210583DB7ED1ED4258F9AE2DM4PR03MB6208namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px;"><span=
 style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"></spa=
n><span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);=
 text-transform: none;">Reviewed-by: Tanmay
 Kathpalia &lt;</span><span style=3D"color: rgb(71, 158, 245); background-c=
olor: rgb(255, 255, 255); text-transform: none;"><a href=3D"mailto:tanmay.k=
athpalia@altera.com" class=3D"ms-outlook-linkify" style=3D"color: rgb(71, 1=
58, 245); background-color: rgb(255, 255, 255); text-align: left;">tanmay.k=
athpalia@altera.com</a></span><span style=3D"color: rgb(0, 0, 0); backgroun=
d-color: rgb(255, 255, 255); text-transform: none;">&gt;</span></div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
</div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<br>
<p style=3D"font-family:Calibri;font-size:10pt;color:#000000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Altera Confidential<br>
</p>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b> Peng Fan &lt;peng.fan@oss.nxp.com&gt;<br>
<b>Sent:</b> Wednesday, August 26, 2026 2:17:09 pm<br>
<b>To:</b> Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b> U-Boot Mailing List &lt;u-boot@lists.u-boot-project.org&gt;; Jen=
s Wiklander &lt;jens.wiklander@oss.qualcomm.com&gt;; Ilias Apalodimas &lt;i=
lias.apalodimas@linaro.org&gt;; Sai Sree Kartheek Adivi &lt;s-adivi@ti.com&=
gt;; Alexander Heinisch &lt;alexander.heinisch@siemens.com&gt;;
 Kathpalia, Tanmay &lt;tanmay.kathpalia@altera.com&gt;; Peng Fan &lt;peng.f=
an@nxp.com&gt;; Jaehoon Chung &lt;jh80.chung@samsung.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 4/5] mmc: Call back to optee after a successf=
ul mmc_init<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">On Sun, Au=
g 23, 2026 at 09:47:25PM +0200, Jan Kiszka wrote:<br>
&gt;From: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
&gt;<br>
&gt;This is needed to that OP-TEE can re-enumerate services which need RPMB=
<br>
&gt;access that may have become available now.<br>
&gt;<br>
&gt;Signed-off-by: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<br>
Reviewed-by: Peng Fan &lt;peng.fan@nxp.com&gt;<br>
</div>
<br>
</div>
</body>
</html>

--_000_DM4PR03MB6208B1210583DB7ED1ED4258F9AE2DM4PR03MB6208namp_--
