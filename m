Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB00C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 20:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D7588161;
	Fri,  1 Mar 2024 21:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="Ic40UqDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C714687CF2; Fri,  1 Mar 2024 19:45:14 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8296887CEC
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=97901b73a3=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 421EwWIV011325; Fri, 1 Mar 2024 18:45:08 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wkcbr1pnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 18:45:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9FRCFNi7GciDHT1Yh8WQjjX1FqwfEUanf0gQ9L2u4NtJfcfG0j2lCrK/NVUjKy7Wvj9EwIIaENsk2ie9/7N+vNq0p+CB94ZdMm28y8EBkGWqcN5kuf4P4hJj+1O0DNCl3MH3guyafbgd81NHxyIRAgKT5VK0EmRhYudFEq2y/BuAaq0Rn2Ctpkz7Orqy+7ji0NTUVthPH9BXRkfM5ObHCNzkXp0eCI+uDFr3XhDvnFmzgU4iaOs+IjYCq8pglXRyGmtQUE3vft6sHT4wxPIdOYLvAgyGgxM21DNXli8K41xVrem3LRNgFouIhoU+rU17X11RcfEAZ2A8zllj1lljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PUAGoI6E2xDNJHcealDDwBQSVcXSf+MMa4WxGG4OS8=;
 b=fbL+GZJT8RktzeR5jPvEkNnBCU8kvOYUYqEQwX1PuW4rjkgGy0w3QWUPg0RvxDn94JkazyTV2aFEGHvOaSZSdWS8JGPi+vv0uT85dX5sUBeeq6A0oSCI9qc/qC8UnDSbRB3sCHCbcgwwpZN+AYMkNaqDJVBErJJ5R5clnWa4JIEhpSfyDrdeXCbA+qszLCM3hKs/n1LUqiQQr2SGsrO2SiKIhB6gKDyBAmUA4YlRw3LQzsRUtNo156NyOHYO+lKW6Y88H/oTPneRnR66Nx1RBj10M5N5gPAxGvF+R4SBTQ9Mfy1ZFhHSLrLEKKAp05vQrmYMXO/9zYCpgOAyVIg94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PUAGoI6E2xDNJHcealDDwBQSVcXSf+MMa4WxGG4OS8=;
 b=Ic40UqDClE5Mn3FebY+HNy4udvwz1AFg2JtL93MT7c430IuLr3cfvFhod5aNzVgxTmUoiZmrVbHutqZfC5oskM1/NNNxJ8BNT8VVcOGDIF1A5dSMeS16xVc/+8nh3CIjoWKms4FB1R0LdDbRLl92+3IzX6JM4RCbWmmNniA6GbytGsi7rdHkqU4lO9gq5rv0ATDxg/0ubOF6s5Hz3Z7Fbxn8tyCKqDusG86XqMYaVpQBfrOCW1CbmIf+r3t4usSFBqSphZVbR9ZM3zXM8wz1JNMLmhD+RlfL0VhD1kxZFrS2q3C5/P42h/80/fZyQxZjPA3us5TIu3SjoHQJMTCefA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DB9PR03MB9760.eurprd03.prod.outlook.com
 (2603:10a6:10:456::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 18:45:03 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 18:45:03 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Topic: [PATCH 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Index: AQHaaxqJOA4ENkIqJ0y0V3cEXU8mPLEjIg+AgAAUyYA=
Date: Fri, 1 Mar 2024 18:45:03 +0000
Message-ID: <871q8t6bbl.fsf@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-6-volodymyr_babchuk@epam.com>
 <c1dc5e6b-7289-4671-ba55-1a26add7e99c@linaro.org>
In-Reply-To: <c1dc5e6b-7289-4671-ba55-1a26add7e99c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DB9PR03MB9760:EE_
x-ms-office365-filtering-correlation-id: bc505ee6-0a8a-4c69-59d7-08dc3a1fb4bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6XdVAdiJ+upHj7lYRwHz3r2dRRL4k3irWRNMvsagdqOpOGuFvuxBUzpl6mVhda+NT50bJHiCATBUIUR+B0ZqDsij7CFH+hZo8JXwP5SA/t4MnPkY7v8eJhevbDEsjPgEEFBAYh95oeD+mbr93aP6t5xfUJsqAECWuLyxXt/4vR7mpm35mA8IEA+uknI+Iq4lv6AlLQmBa9JikpprqBHMuX9QNqLMqAcnmdvPRZYd3Wp4zSl2TE8kcwv/g/DyOhRVFMa7YiugVkm/t086pa/xLsBYnjRsDrbYjd1aiXYr6KkhZ4AJdmj7IPzYyDLpW9ARP/7wOMgKnqDUON3MrD8b1/n2g2dwoXuRc2yAZzOZp/7JtB9O+MnKHzQ1hV80oS5xOLJmEbgVlLVCCHh4XCGoAxo19sZr3V/7wl9S9m2qDtBVmA8LtaQKrmrlMsJqfonnkTGjMvjiH/Y1KhCFjbohp1HSQ/mIuyGwxjooijlpL2fKA1b8YEpoHLn/0urX00Vd3vpTOMgvEZEn3lmyrtdbsPBvtB4uJA3Wdv9i50elk4IIW8lh/L2Z7LirXmjgXYnz83kIQvtLLjO2E4CKYke54mNgjgl7xJ9p1eUJ3vMyf9x3jv8KRAwJNc6Uy9FFs/PdBGBJe0SpEiOTmFhMm6Tn1AmEtWheF1rtOYFaAanzWME64xuIlDGchWiX0mfWQ1BgVFkSimpjAjo0yw8O9eUK/HHUPqtVtz5wDEXiTImhn7g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qT1skfW3222UkjooJJglI2lcNoRC2UK/OGEFyk73H77I4aRPcduysxDmCi?=
 =?iso-8859-1?Q?l6FvEdXxC+Sy6xUuFNbndzTRpFEelHVaAkML88pHNL0aUsnc4zCnuPjhJi?=
 =?iso-8859-1?Q?1lxfb8y5gp07OMzgADaTyPpgmfrgK3qVIf9VIcrYTVyzaADc71gSAvMyeo?=
 =?iso-8859-1?Q?Fks3KjMmFFIegn9+NuQE96ngdaXjkwLLPlhJlB/t7WNUJjdeCyhEdeaocc?=
 =?iso-8859-1?Q?pprIeuZI+8d/Kmr2zfaTfTzlT3E+dUK9y+gRQOrHYiAleG3bl0DVKF1wXF?=
 =?iso-8859-1?Q?FzZxc8f3TtDHApTHdcWeR1OGw47csQXQ8gdu4JzPKxwKCc0CTXG1XhC5tg?=
 =?iso-8859-1?Q?lGPq9W6MfBksWlQE+ne3KiXcNQU+l+hVvmIrCtGr2VhZUPinhtFMorJbvq?=
 =?iso-8859-1?Q?QHr/nXvruKp07fJIeQh/gnJMvXplTpL8HvYxQw+sq+tOl0+N75jH9KXK5V?=
 =?iso-8859-1?Q?/kNkyRzuxb3YcV8qogsRd2Xfyt1b50uUdA3EQmh+9qKBCQ2ssxev3UUENb?=
 =?iso-8859-1?Q?MOs707chxWDJysYRI4WZ90fMvr/6YCkm4/ytUFtKslfSXJf69HxLNB3pXx?=
 =?iso-8859-1?Q?16ilq0GBpKuP5+wPKRaa3dZ5DdTY2nbYY1tnPOHiP9i1Xq0qVQfB52G0TC?=
 =?iso-8859-1?Q?GbGxIlAqxQFx5Ru0eU3PK5n98kBJkZ0/wUzyO3ynByI8VcGcWBDVXKjMG5?=
 =?iso-8859-1?Q?uHxRp6Efz0XFaRxJTfeFnKFpsjsSP/K7jj3nUCaDWsZfr7xy2r5GbogLhp?=
 =?iso-8859-1?Q?CSoiLgYzlJEjLsEKTnPG/WJHHar6g+reH+F5ED3px0KMoIHEytnANUAXUD?=
 =?iso-8859-1?Q?QgMPjWzlmDDog29uxbm9P+sYEtns+0zwluZLAcU+M5A965g9MliqeC0akC?=
 =?iso-8859-1?Q?6/TqqNH2Ie/yuigPCn6pKxr6JbB4s6rlY7p+wXehVKDo5L2Zs7mxOchHp8?=
 =?iso-8859-1?Q?0MSynQb1Nu9DSAqjGuW/AmAz6cvjFoSvAdljiazqRJTYcIyTbJh1q0m88H?=
 =?iso-8859-1?Q?RLMdBfMEFhPbkMp7po1hEowNz8PGY4kqsvV+DmtSA9aQkAGcOzqhmCkBjq?=
 =?iso-8859-1?Q?sipPZ+OGdZE+sqyjzCg+Tbn2ZzaU58pz2vqxvFjqhp2fzENHcyXthzzQwg?=
 =?iso-8859-1?Q?niQglQfMNjjXDxecnLyru1muUFiahhvxLBSB8TZqs/JnKjSCozHlhQ6rZo?=
 =?iso-8859-1?Q?Z2ZFL2IUWm/Xn9zqkNtr1iS0noZWAQbEIdTvfhxUTNHVrPTsjDT9qfsr3n?=
 =?iso-8859-1?Q?ABM1cNQOQxQKTPpPnrCIWOM/awhIftsEe9+ywnwkE8cWO33saRb1sfO2Fx?=
 =?iso-8859-1?Q?dXC61calTaeXn0wuYyrjcPwgbDpDXXYuPv+rcU2xaTNMYfx2mWIcpc++1b?=
 =?iso-8859-1?Q?bKbx0d0NCR76q6CJURxshVAV8gXJv6iQOeLiJlcUuC1WSQ5HIB7fe9EMQo?=
 =?iso-8859-1?Q?NZvyo2jZdUBK390eKb04R7lU78tkvTyCI+vAQ0bkqP14Ito5NbGoEX9D+t?=
 =?iso-8859-1?Q?SUhvAiIgUX3mp2QnD3/QwSkKoxBnIqmBUJYuVwUdlXboSkL+26ju8wq6rd?=
 =?iso-8859-1?Q?a+jdzbomc+iY108aCQdIQLhS0dTxIQGLcsaJXn6U3Q/JmF4ioD7DlMv1I6?=
 =?iso-8859-1?Q?hz+7N8ZOUGdZaRDcOA8bAdE/Vv/sburEZzo5ikdCoXveYrFDsROjOKlg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc505ee6-0a8a-4c69-59d7-08dc3a1fb4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 18:45:03.0367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZXqVDcKXRcs3Ql8W7fFt/F7pdIzFCKITzeiCgmHujd4joa6c9mPLeJOXCHHs8+zR1fw/D9Z4CXRdV/ifHQuUjcY9d5LJSnT6p5pg08d1J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9760
X-Proofpoint-ORIG-GUID: 8KDvaa5YcMNzHcTM1Kn7IhRcI1h06t2f
X-Proofpoint-GUID: 8KDvaa5YcMNzHcTM1Kn7IhRcI1h06t2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010154
X-Mailman-Approved-At: Fri, 01 Mar 2024 21:30:21 +0100
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


Hi Caleb,

Caleb Connolly <caleb.connolly@linaro.org> writes:

> On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>> Add clock, reset and power domain driver for SM8150. Driver code is
>> based on the similar U-Boot drivers. All constants are taken from the
>> corresponding Linux driver.
>>=20
>> This driver supports clock rate setting only for the debug UART and
>> RGMII/Ethernet modules, because this is all I can test right now.
>>=20
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>>=20
>>  drivers/clk/qcom/Kconfig        |   8 ++
>>  drivers/clk/qcom/Makefile       |   1 +
>>  drivers/clk/qcom/clock-qcom.h   |   1 +
>>  drivers/clk/qcom/clock-sm8150.c | 234 ++++++++++++++++++++++++++++++++
>>  4 files changed, 244 insertions(+)
>>  create mode 100644 drivers/clk/qcom/clock-sm8150.c
>>=20
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 0df0d1881a..18ccf6a45e 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
>>  	  on the Snapdragon 845 SoC. This driver supports the clocks
>>  	  and resets exposed by the GCC hardware block.
>> =20
>> +config CLK_QCOM_SM8150
>> +	bool "Qualcomm SM8150 GCC"
>> +	select CLK_QCOM
>> +	help
>> +	  Say Y here to enable support for the Global Clock Controller
>> +	  on the Snapdragon 8150 SoC. This driver supports the clocks
>> +	  and resets exposed by the GCC hardware block.
>> +
>>  endmenu
>> =20
>>  endif
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index cb179fdac5..12c09ba19e 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) +=3D clock-apq8016.o
>>  obj-$(CONFIG_CLK_QCOM_APQ8096) +=3D clock-apq8096.o
>>  obj-$(CONFIG_CLK_QCOM_IPQ4019) +=3D clock-ipq4019.o
>>  obj-$(CONFIG_CLK_QCOM_QCS404) +=3D clock-qcs404.o
>> +obj-$(CONFIG_CLK_QCOM_SM8150) +=3D clock-sm8150.o
>> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom=
.h
>> index 12a1eaec2b..41107df216 100644
>> --- a/drivers/clk/qcom/clock-qcom.h
>> +++ b/drivers/clk/qcom/clock-qcom.h
>> @@ -9,6 +9,7 @@
>> =20
>>  #define CFG_CLK_SRC_CXO   (0 << 8)
>>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
>> +#define CFG_CLK_SRC_GPLL7_MAIN (3 << 8)
> Please follow the existing scheme and remove the _MAIN suffix.

Ah, yes, planned to do this, but looks like lost it when created a final
version of the patch.

> I'd also be fine with converting all of these definitions to follow how
> the Linux drivers name them.

This should be done in the separate patch, I think.

[...]


>> +static int sm8150_clk_enable(struct clk *clk)
>> +{
>> +	struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
>> +
>> +	clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> This will write to the GPLL for every single clock, I think you're
> missing a switch case block here.

Yes, you are right.

>> +	qcom_gate_clk_en(priv, clk->id);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct qcom_reset_map sm8150_gcc_resets[] =3D {
>> +	[GCC_EMAC_BCR] =3D { 0x6000 },
>> +	[GCC_GPU_BCR] =3D { 0x71000 },
>> +	[GCC_MMSS_BCR] =3D { 0xb000 },
>> +	[GCC_NPU_BCR] =3D { 0x4d000 },
>> +	[GCC_PCIE_0_BCR] =3D { 0x6b000 },
>> +	[GCC_PCIE_0_PHY_BCR] =3D { 0x6c01c },
>> +	[GCC_PCIE_1_BCR] =3D { 0x8d000 },
>> +	[GCC_PCIE_1_PHY_BCR] =3D { 0x8e01c },
>> +	[GCC_PCIE_PHY_BCR] =3D { 0x6f000 },
>> +	[GCC_PDM_BCR] =3D { 0x33000 },
>> +	[GCC_PRNG_BCR] =3D { 0x34000 },
>> +	[GCC_QSPI_BCR] =3D { 0x24008 },
>> +	[GCC_QUPV3_WRAPPER_0_BCR] =3D { 0x17000 },
>> +	[GCC_QUPV3_WRAPPER_1_BCR] =3D { 0x18000 },
>> +	[GCC_QUPV3_WRAPPER_2_BCR] =3D { 0x1e000 },
>> +	[GCC_QUSB2PHY_PRIM_BCR] =3D { 0x12000 },
>> +	[GCC_QUSB2PHY_SEC_BCR] =3D { 0x12004 },
>> +	[GCC_USB3_PHY_PRIM_BCR] =3D { 0x50000 },
>> +	[GCC_USB3_DP_PHY_PRIM_BCR] =3D { 0x50008 },
>> +	[GCC_USB3_PHY_SEC_BCR] =3D { 0x5000c },
>> +	[GCC_USB3PHY_PHY_SEC_BCR] =3D { 0x50010 },
>> +	[GCC_SDCC2_BCR] =3D { 0x14000 },
>> +	[GCC_SDCC4_BCR] =3D { 0x16000 },
>> +	[GCC_TSIF_BCR] =3D { 0x36000 },
>> +	[GCC_UFS_CARD_BCR] =3D { 0x75000 },
>> +	[GCC_UFS_PHY_BCR] =3D { 0x77000 },
>> +	[GCC_USB30_PRIM_BCR] =3D { 0xf000 },
>> +	[GCC_USB30_SEC_BCR] =3D { 0x10000 },
>> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] =3D { 0x6a000 },
>> +};
>> +
>> +static const struct qcom_power_map sm8150_gcc_power_domains[] =3D {
> This is really nice! Certainly better than my approach [1].



> Please reorder the patches so that the power domain driver is added
> before this so we don't break future bisects.

power domain driver is added in the previous patch: "[PATCH 4/8] clk:
qcom: add support for power domains uclass"


>> +	[EMAC_GDSC] =3D { 0x6004 },
>> +	[PCIE_0_GDSC] =3D { 0x6b004 },
>> +	[PCIE_1_GDSC] =3D { 0x8d004 },
>> +	[UFS_CARD_GDSC] =3D { 0x75004 },
>> +	[UFS_PHY_GDSC] =3D { 0x7704 },
>> +	[USB30_PRIM_GDSC] =3D { 0x6004 },
>> +	[USB30_SEC_GDSC] =3D { 0x10004 },
>> +};
>> +
>> +
>> +static struct msm_clk_data sm8150_clk_data =3D {
>> +	.resets =3D sm8150_gcc_resets,
>> +	.num_resets =3D ARRAY_SIZE(sm8150_gcc_resets),
>> +	.clks =3D sm8150_clks,
>> +	.num_clks =3D ARRAY_SIZE(sm8150_clks),
>> +	.power_domains =3D sm8150_gcc_power_domains,
>> +	.num_power_domains =3D ARRAY_SIZE(sm8150_gcc_power_domains),
>> +
>> +	.enable =3D sm8150_clk_enable,
>> +	.set_rate =3D sm8150_clk_set_rate,
>> +};
>> +
>> +static const struct udevice_id gcc_sm8150_of_match[] =3D {
>> +	{
>> +		.compatible =3D "qcom,gcc-sm8150",
>> +		.data =3D (ulong)&sm8150_clk_data,
>> +	},
>> +	{ }
>> +};
>> +
>> +U_BOOT_DRIVER(gcc_sm8150) =3D {
>> +	.name		=3D "gcc_sm8150",
>> +	.id		=3D UCLASS_NOP,
>> +	.of_match	=3D gcc_sm8150_of_match,
>> +	.bind		=3D qcom_cc_bind,
>> +	.flags		=3D DM_FLAG_PRE_RELOC,
>> +};
>
> Just in case it's useful to you, I have some work in progress patches
> for dumping the clock configuration, I hope to upstream these eventually
> but in the mean time you can find them here:

This is what bothers me now. Looks like I jumped in the middle of your
USB series and Sumit's Qulacom device tree binding series. I don't want
to interfere with the ongoing work, so probably I postpone posting my v2
unless at least Sumit's series are taken into the mainline. On other
hand, there are couple of patches that are not directly related to the
SM8155P-ADP, like my fix to the clock driver or already mentioned "clk:
qcom: add support for power domains uclass", which you can reuse. So I
can post them separately or you can include them into your series if you
want. What is your opinion?

--=20
WBR, Volodymyr=
