Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF9EBFD20
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158CD839D5;
	Mon, 13 Apr 2026 11:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dLYGlJOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82798841D7; Mon, 13 Apr 2026 11:31:34 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3E28352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YORMQiCm0w3XBWN75YNznH4AQmr0WZqgP6uWCnSHFxh7YMNnEpY7ikUy9huGIvkT2CNNODIdO0GbWABIpuDV4+wFJMdKzYO8rPgb9f5uxluK/rXgtXwZ38ECFxvAH3gn/pBHo1j3a895krGbj1n5/D/ue+APtaWgG1FCqplRD+iygrHXCnD6h89Z1Q09tEqBoBl+C9mmSb0D3171udgxlvUazdkGwlGHu9B3lWssOCOVYx2QM50EUDbH5PzUMlexd8U4AxyWzn2Y4LaFtveP3BqPhox3MNzNCk8USUeHM6vo//BLMtr2rkJAHfHpfTiCCLc/r3AFg91joRnbAZlGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEKQ+RGFc+f7LbNK6G5/OMdtj3Ivcfojp8w/ujdfBAk=;
 b=G0tjLlOLqIzw4pEhKKNhv+9VaMPPNb9pVYkJ3M2nbYKHbMrcby/u9mJ6+/Eut/9LdWme6mrVVHdxowcTOSQsL7AVqOHJjSlsv6r/UYb4FBTrBJB4yx0enVqd44kjhE6olre/zS0jgjWNqPHYAVQqLTxWucAbWFcEmTe/Hld6tvM75zB58Q+I3ZFTK26oa8eUssqZTdPOaN/0pxzYOOvyOwtZEuV0zSKJcynh5JtH8ySqY/4jzWrKjS48xkT8hKyv+3XQT6y09fJQ3zTB5FOa15YPd3NmztEkkGkKFyNDQA9UBOy7WYxYg3vsrVp5Ehe1zDscEyTALB2fTy/+1ZjbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEKQ+RGFc+f7LbNK6G5/OMdtj3Ivcfojp8w/ujdfBAk=;
 b=dLYGlJOWF5Nz1DVq9VyFqiu+7ayObYhME0R5mOakYjgNzYKUC2UskEhKatAp5PM38BGDrOyg1GBj3FurTtuLIsOBLjIj/Q8Dijx5qXk7JnH7dg/mFlhghPNQR5g6+aXcHu5eYTI6G92kHxonn3WT2i1lNMKRlQ94I2w6JoaCFH4t4mHQ2q5IZ/T/W5rvYZ35TwDq2mITrk3Gn4sjzmI60fRimMC0cR6s1ssi+heSWAvV5t1s7rN+QKf6XVqLo7MFo2OT4lyEq1MlHMCelFNYikyX64tPYhkwpCrf+xhCvMXcQbPVaWG9op08Wc3ehZfGswVM6tiySjQ+R9qiEiwvlA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS7PR03MB5494.namprd03.prod.outlook.com (2603:10b6:5:2ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:31:28 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:31:28 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Thread-Topic: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Thread-Index: AQHcpgXoa8H+Rv7GrUKxSl0lz2cOzbXc/mo3
Date: Mon, 13 Apr 2026 09:31:28 +0000
Message-ID: <LV8PR03MB81371042B7281984F15D61BDA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225032149.1342-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225032149.1342-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS7PR03MB5494:EE_
x-ms-office365-filtering-correlation-id: 130b14fa-1e27-4147-582f-08de993f709c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: oU+U8UaamBqqMyu5HzdizNtrKi5yufcJDwjq9u4tBOc5mG+I7ISHc5ZAENwmK51/629mtGjAI9m9qhBbWx0BbOR3s7SIbclI0FV9dAEp+0FRToi83gGqq4qgIlX2T9AfeM6siEDEFXqJjnURZ7/oDb/5uRKs5FvNKfHFRsARq0ug7wvSmO0qz7hjqk8MgUidQ5yP/u56kjGAX0U/1zxXjS5qrKAzIi/OwAf3Rz4eqeUNznCgiU5RtptIg1oPDAvakk07b0PiHPriIhkQfNCU0kVPFN6LryWryMxk6b1Z3R2gbHHgpmiMEd95Vp0K2KB3RHsNZpy9ooI9pkZPBGCgo+/QznLOH4blTpFbmsWP6v//GmsRilUzlUjUizi7t6VMiv9ZTx5NtpTLPxZacE51X+TZUpeFxUG3QYoO73tw0TyJWmHcmZReNQI6okeJ3T4MM6rSOLVbUDhx8LJOd7MgOxjODsPgaglAlLyJxKVj5QS+w1rBIPUmmGC3ggeMRIDBn8zj9tKvRDjWbG5l3PufEe2oZUjqiIq4YkBpjPArojeJx94z69ozMWZTIil9c07FPDJ3h29xmf+raePua4g/eAg+nvD6Q5zroxVCciVwOBqTPEImTlLB5DQ+ki9WGZfj+LKYyEU/fvhOjoF7D3bTTeowLmz02Hs4Rfpxa5aHMa0FmZF2dnB3fYhdblEhfvFLcNk/Jly0HQTurjnqof9w6o0rExa24W4Z2yNt+M3frSmeoB9jSpBNmfC5Hp1IHGb2bBoZzHaPy/Xroo0lQpn0PWHJRXc4vmjlEqpNaj+mcyk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Fo3BfKGzEPAQ+q65PxKJfXNMKpYQE2m+8LwhrO/U9IrhTQw9BCuYQ40U?=
 =?Windows-1252?Q?IV11SMxxo5LbJkY3QZNW4VDhXVuIFox9E1FmjRpuc6kExTy1U/tkDpiH?=
 =?Windows-1252?Q?rKMW3dubGGWEUYx6mdPPDHxTm25o0dB28Jt8JMW0MKDMq8ps9OjL+QOn?=
 =?Windows-1252?Q?qHQD9G5ue4TSCmQt1TTq2n/xOmG0npz8VEWS4/TP05/G5RgR38Fqrr3e?=
 =?Windows-1252?Q?wcQHXWw203TsyUF2lXVumYZ/wEPnCPgkXjTI+ZEBgz5dOiXKCzjykFe+?=
 =?Windows-1252?Q?OfU8prPNuc2ht4/XpaM/vwTU+CqS0wlmyKy3ah3KlbFnOIdhPbsG6GfJ?=
 =?Windows-1252?Q?2fK+EXIXNqRhIwNY/lL7lTqD8b/ughKPLSoPu+CuM5VAnNacQzYLj2Hw?=
 =?Windows-1252?Q?Wkg420KFlOQnc2CB9w0iURxNkDFHCOOHwyJEno7Kcpf766JuTvtxX0Gw?=
 =?Windows-1252?Q?VADH1bA1cZKC+Svc+QpccjJUrfOtupir9PBkICYwLLw4w+yc/uJm4OgP?=
 =?Windows-1252?Q?VkQLJJfwPj3gZMmgnm7yOTTdJu9q9SsHhlimSCsfLb+XcUce/fXYsbbT?=
 =?Windows-1252?Q?aiDLAEJPx8HZHxJ4bvwpKavQO4KQ9MKtnVTYBiLsxfIf56TDM800ttWI?=
 =?Windows-1252?Q?BRs+MMeRIEmI5tzAlCLEPXXJVs5vx0CAfgUFypyQ6+6M21wVdYiPTZgk?=
 =?Windows-1252?Q?bTowr70B7YE+n0A6cJfVDQuXOYAyxrkweIkP3ISXmI29yZsJs1h+bOFj?=
 =?Windows-1252?Q?t9k3CIgchd0j6IBCk8Wkxi9stnJ0Xq5Zdf59sH5RzJPQTGYu7SgC4QFU?=
 =?Windows-1252?Q?KVq63jeCe1Tc+XppyWLNCZRzsEDAWnGUTX3DOucwBI3ATuUcIjnrymP/?=
 =?Windows-1252?Q?MzV7A8QwOuMhuqcu2Q3uvhzrJhCxH5XM/pgcKzkYSuNdJ0iktomoXkiV?=
 =?Windows-1252?Q?KULGdkMWmEfVETruKNiTttiyb08/CGE+u69vGmhnc723hdx6AO4nCfzH?=
 =?Windows-1252?Q?CtC4Tre+4w08rLbRGYcoCbfjA/RiS6kY/urLpyUJuGnTZqRSDeM2O5tR?=
 =?Windows-1252?Q?lP1IQ16A36pZkQi6xKV+BXUmdluJ97/nWnDtwVDXQ2gFeTUEBAHo4sxP?=
 =?Windows-1252?Q?oXx8d48E7UoV7ey05wKCHb36HsCdsimjbJnX/TIUvfnIfPNnn72fQvJD?=
 =?Windows-1252?Q?gzx2wKQUnAxCTzo5+XY2OfjaAXWxmZtcDk9Twe3HvNeww9fqPN1GwEMT?=
 =?Windows-1252?Q?xKr5S8orXtFa+qprBNhIcDZqNtM7uBoiG+XMUfxYHHCeg1WfV/INj1VM?=
 =?Windows-1252?Q?qjlasiT9c5WoQtaJ+/EX7qKd47Nu4QieYauMbZNfs09d7tT+JVSrOt8S?=
 =?Windows-1252?Q?g/jFHxjV+LsuTYOKIH2jYEFSLHZyUkeZNuwk1L7kw+gkZf33dQIGEXaL?=
 =?Windows-1252?Q?2m0UIuaGt8EHK0po9gQjrgQiEsezwG6JgjczLfks3yet426N8v1uhFcj?=
 =?Windows-1252?Q?oF8qAebkjlD83m60Ax2joT5So/G4e14MRJjdC+VLoPJcvnEhu0DGKesp?=
 =?Windows-1252?Q?bAgC4GQFXGG4v0s+mMyxj27jOnurYWEbooBTai/onhsn+/MP+gGhYi/8?=
 =?Windows-1252?Q?6S2z6xYRoVuu35pDtvYtPx3VLD5noxV3DMQt1a8zKFurcXkCpYYbwLEh?=
 =?Windows-1252?Q?2UeU5PZ1mgaaS3J9D6b9VxZqgIFEDnbxTQi0FD7r9NwQ2MQnTUNENICg?=
 =?Windows-1252?Q?ds69T85KfbfcxyO/3nbcAI4GOTidam9EJg23eGfYqTIpQZ4ft7QBLAv8?=
 =?Windows-1252?Q?HBRYDhy+g5HEvk15owvVbHih4RyHJn3Y3F17HmVJ6DYMZFz3NryK6lwk?=
 =?Windows-1252?Q?2nE4lkzecS1qtg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130b14fa-1e27-4147-582f-08de993f709c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:31:28.4235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsP+6rry4pgqGnKrYn49L3B1EcnIYlsvotkRcJ3LhF5aCFTnI9fUCqmFFecb5QyR3GzGtZfDJDMr3OaPXyaqRKrTUb5ZD63RkmnnQYVDiK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5494
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

Hi Boon Khai,=0A=
=0A=
> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 11:21 AM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Marek Vasut <marex@denx.de>; Simon Goldschmidt=
=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@altera.com>; To=
m=0A=
> Rini <trini@konsulko.com>; Maniyam, Dinesh <dinesh.maniyam@altera.com>; L=
ok,=0A=
> Chen Huei <chen.huei.lok@altera.com>; Hea, Kok Kiang=0A=
> <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security=
=0A=
> Control Register size=0A=
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> noc_fw_tcu_tcu_scr register has a base address of 0xFFD21400 and an end=
=0A=
> address of 0xFFD214FF for Agilex7/7M and Stratix10, which makes the size =
of=0A=
> the register a total of 256 bytes.=0A=
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/dts/socfpga_soc64_u-boot.dtsi | 2 +-=0A=
> =A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
> diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> b/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> index ce5b37ef547..a6e0b615717 100644=0A=
> --- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> +++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> @@ -132,7 +132,7 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
/* TCU */=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
noc_fw_tcu_tcu_scr@ffd21400 {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 reg =3D <0xffd21400 0x00000004>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 reg =3D <0xffd21400 0x00000100>;=0A=
=0A=
Instance decodes 0x100; reserved offsets are RAZ/WI=94 (or equivalent wordi=
ng). If TRM does not guarantee benign behavior for reserved offsets, I=92d =
NAK 0x100 and request to keep 0x4 until there=92s a concrete need to progra=
m additional offsets.  Please check if only 0xFFD21400 is valid and accessi=
ng other offsets may bus fault / return unpredictable / hit other logic?=0A=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 intel,offset-settings =3D=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000000 0x01010001 0x0=
1010001>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 bootph-all;=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Best regards,=0A=
Tien Fong=
