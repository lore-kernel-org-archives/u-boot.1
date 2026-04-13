Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9CEBFD10
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 07:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F18839D5;
	Mon, 13 Apr 2026 09:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tn0Gc1as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C637839DF; Mon, 13 Apr 2026 09:56:33 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850538352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 09:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfd4H1+QMhQuKK52xBC9arxOv7ZyddpRgWxc/1B0HsuAPq1ZsfEH6PmKjfmbBlQT8xOomadcnH8+4hmpX3SdT76fOSpbhiWAQpQzJPgV5s7tw29Cy6HmIzoNZ1Ndrcb+/e3CHJkws9YcI95nwVWwqEYdwWRFWuYGjB998VMWE4dlAUPN9sYDWp5P1oEZig6oHQA6ICNnpQKZyGRjlhfasiZL4fFBlwXcG8/jFCm4GtpsZ16Z9HAI26e4BpInFaDIb0jn0oH2PDSudl12982YB52Y+qzpJ67M4w0SI32sfITVyUzLFBzJW04VJ5J/xpHXhe6aYy0cge6u0s4FmB4SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sSaLg6qrA1vYb/YVN+0dBNaNeI9EFtVh5oNWaZyHCk=;
 b=fPo9HwhG5XpD1AwgVccg69k+1JDHXK8RsUEbeo2P84nK22ZIemi+N4b50WtUqdQY4FyHXaOjF3gzptdpvE21eguf7pyQ2F7bXo1/V2+UWd2RprdwxpdE2fXdzYTfIIn9GOtbmXYFz8i+RD/LFo7GJUe1SU7oplXG+JDuPYnmxON5wO1KWqERk8EDVGfpayf9QBgs5MvdBy6l+VIsEqyHmIJP3cG/r+zjMBaiyw+RTp9IgfeAuF6hNSmM2qZGFMGwX8zTUvnfys9KTEtBgCTXAi1IFYfGtOS7ngcIHtmfDoRT3SPJ59GFTHOvc4gMKoExM5FRIlmjDAerlxOep1tBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sSaLg6qrA1vYb/YVN+0dBNaNeI9EFtVh5oNWaZyHCk=;
 b=tn0Gc1as1uZxFhwCSwq+9346x9Qo8aSFq1dbW47umzTlWrk2gH16lWsNrs+YniZyoufymbrA5LCiNcGfRlJ78+KwtC92zxZadvpKlDph+XHZvWH3nLFnDWBkfV9I4YYSWg4bFvSEEWVF5M8cymxBBUkap1qKw2wETeEzK69d7MoPOIqKYKaNRqVKr2vNrjTv2i3SgsyFv+hSm3F3XL1XAeTQzoaJTJ3WHhSnO4m6ADHoeCm4xq9CKypcd63XDhyL7wc4RahBdztsNbRVspxAZrAoQkALS5pH59bCJ738A2mc4D43VsJJDe43xNDxCGzlo4PuSzW2kvVmSB3tmeLSFA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN8PR03MB4964.namprd03.prod.outlook.com (2603:10b6:408:7d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 07:56:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:56:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v2] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Thread-Topic: [PATCH v2] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Thread-Index: AQHcl0FMZ18d7pnkbkiuP+Ezp7wtbrXdAtX8
Date: Mon, 13 Apr 2026 07:56:26 +0000
Message-ID: <LV8PR03MB813764D9AB9C683D10955D58A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260206081904.12390-1-chen.huei.lok@altera.com>
In-Reply-To: <20260206081904.12390-1-chen.huei.lok@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BN8PR03MB4964:EE_
x-ms-office365-filtering-correlation-id: a24cedf0-6f2a-4d62-e66b-08de993229f2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info: 0lz9SFP+36JJ6l/AAZ45KzFlZPZDtrlM8h+iqeMpHs8uyn02wEf876pjavkMM98RabkWriRAMAej5UHZEMwML0IRBuuqgLMmmSk9uhUGwc6oBf04yP/hjsXNMgEnbXAFpNfEYv/0GjbxWSEA75JuuYRGWLfBwJzICsjDF4ZbKLqvqIFB6xiGVOdTw9NL/gCJmb1JxJcXnthIO6c4hAtQ9J0F/MP2Lz0SwKY66Pn3p+h0MsJveKIrld0X2rhIpZe+35nHzOi4kkgTuYUZBxsnqpMVQZ99IW7L1JfyoTAso6uCx7ZppBW+CPRnT5DFq1x3JOGl9HvbUxOSBiWJ8Vcgupl1DkrBurjqCu6oNBfBz35YwKgW0/6mS3xU5PuvJpv1NY3orfLl4kXK+r356I24CUz/tIGaVuMDDipS66roNM6MR+bJ4rq1U6GvcCBwyJlIdjdiLbtgEqwCjv5cZxj5B45hj+5wA0k2bKODAMzU7FIjdMxU/xmff7f2QeZe2sqfhuMkLKapy5oJEc7WEx5cXEqN0N+ctAxWU0puwyUmfohZDdGxbjEP5Z9vCS9a8rxIA3TU/HXUpGSJTOcNFgzF0/bxNNVDBrJMXl86oDRZDR76KNncKfsdacC3T0nRJLIk9cOXG4oLnbtsn6LJMf4mCXZZ1as3KTqLB3o7+vGd9iO35biIUI0q3cRF+nrB/FA7dWw7cnbEd2zrXQnRb0cDifaBRBdaySg0AkUb74/IgrEsXZB64YDprTibKofn/zs9QIn3aQSe7gIofrmOnEzBEqPBGlifGHNw6dVZ7DdCcXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2b4+h1jcy+2lLSeXU1Vr9hVefTVNoEQ8f+YTyWNPUG7CnRUYgmDxs8Ia9b?=
 =?iso-8859-1?Q?X+VEvJU0dEDRli19EgfmnN6x0c2TUPW7nO4PeHQHbsFkd01GtUJ3e4LMIQ?=
 =?iso-8859-1?Q?Hhubt8m33ejgRGd8706LaH67FpoeeOlbyt25Rr5eiAk1WhRown6xaPbcYW?=
 =?iso-8859-1?Q?Gjmrt6z80nOEqNCvMovp2wb91tpAfj0P3MQZuSTTdfwaM7IFj85NIWqvB1?=
 =?iso-8859-1?Q?kiZHwzy/IZAMRBOM5tsj9fTxS7rWA1YJvrbDpvKtM+GJ0V6+7n5Tw2oJLK?=
 =?iso-8859-1?Q?KouyCrhFzzLO5pyIYGIo9cQBin8y/UqOuWH4CQ40HOAx2LRJ4DLMJzjqC8?=
 =?iso-8859-1?Q?SptCl9552fVMCQRCkcRgjWbgZYJqj/m/4av6LtT/joZM81qTeYZ1w9O99Y?=
 =?iso-8859-1?Q?FWG1NYVFKgWbM6nPMZMXgPnzhiW/tvCjRlRPHWOj/tJ6BW1pIqeT5NrmTC?=
 =?iso-8859-1?Q?+3UU6Qx0vprrCrIOXAQFeaUyrN020NhpMZfOM7+C5u5HkWbRvmA1FSFB+C?=
 =?iso-8859-1?Q?fbucL2myIAuPtGGe13qLJnvLzSXfCqpXwIXS/fH/ataVo3oxDlnNHAK+xb?=
 =?iso-8859-1?Q?ALZFlwC42D2HtcbFmyAGv5vEgv6FsZcDdbBUpqynw9J65YWEsqgSK2hHcP?=
 =?iso-8859-1?Q?HRcaxhSdKCxvCsAQw0Gs83SiEvLA5YAlL8PWTQ6QorlzntOEU1g9tpY6HK?=
 =?iso-8859-1?Q?bxnQh/Fqo9MJ2BeEm1ZPTweyYIH3d+RfZgZXspd//UGYhAPuV+hyd23OIa?=
 =?iso-8859-1?Q?kdSkerEnq1nrDqjNCeAK1dzpV3tn1+LK7XrSpDd1RPnJS/y2A3T8pswQ09?=
 =?iso-8859-1?Q?NyX+uo0e490RnssiYC9LA+Z3MjJOjT61KYB9YP1rSiY7+N/c5o5f5sdfAX?=
 =?iso-8859-1?Q?4KPDXhJaFqeYf9yxQQllweDKySrwyIBew2ZV4YMk/iLDkZQY3OysatafwC?=
 =?iso-8859-1?Q?IQc4DOVlnWK4ITK4vcoBP+yOf7ZKjyYbcdJoSuImT35fWWkiS8KRgiqoag?=
 =?iso-8859-1?Q?gnmnvuc0wYp3trIWu4wXicq6FQmfomYvYWylKmqeLVuKo33NNH5G8SqEQv?=
 =?iso-8859-1?Q?ROG9lOmXO8Hbn8YwHmg7trC/loKg2ff2bSO7H1DymaXDcNEyD/wJflGU+u?=
 =?iso-8859-1?Q?E5fNIxmDY4cP+Uj0jaC01o0n+pWEmWEnRKpGRg8BSVxvFDb08jDenGqtde?=
 =?iso-8859-1?Q?kFgQb9gms/dkEo7Nn9m5JEH1Rtw1Qg60B5faJXzzdXwIV3dZ2yIP2R30Nc?=
 =?iso-8859-1?Q?hPo+nAK9kzafTuP9SJQ4muw4DyOpx76CVdkfB9UCPiH4dQr/b8wmrLQ1wq?=
 =?iso-8859-1?Q?pslTO89/O8m1/82dNMUnLlpgaQKkyP3UZ0LEworOGi5QwKJ9WywHLpPbcr?=
 =?iso-8859-1?Q?4kh681ZZNjfITlOKCk5VRUeX6G+HYLDaGb8gVGsGHb1x0KjnTeYb0Nyh56?=
 =?iso-8859-1?Q?ZBjPUhFg86QBMlD1L4z+2v3FVix8wJG8U5Z8OH6LKVMsDaFyc+vw2Hwdo3?=
 =?iso-8859-1?Q?WNQjjgi6i56saYh7GoSGmjaLBXMt7mNlC3vu1iZFs57O8x4s4UeqIYXtrh?=
 =?iso-8859-1?Q?fLmYkxjsIKrdQeMe1aezX03TWw/b3fs/dvSC/sO32Tb64U81BaEeJnUiB5?=
 =?iso-8859-1?Q?GivJfv3mhVDYesVZF32VxZ6gxsNoVZIzNNpS4NNXIctVgRY2+rwKGuch7O?=
 =?iso-8859-1?Q?QiixIT44iEOifYa4tyTRsFBLRCdBE0HVry93Lwg3Ejr6T9vFTY0tiLAufp?=
 =?iso-8859-1?Q?RNfvmhUvWKOjZDQMeyvdG9WtaLGL0DInDYrjlr+Woe9QExqikqFbxTf0Tz?=
 =?iso-8859-1?Q?w/E3fjrbhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24cedf0-6f2a-4d62-e66b-08de993229f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:56:26.4176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqIbq+8BqcmjGkZle+cyjvVKv6e90A+u+G0QDkyXO5M03WFcsDnAWGNlIs5HQigGmYevpieGBgchGEt2wiPEuA+qM1ycZkNZUwZ6ntBOQdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4964
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

Hi Chen Huei,=0A=
=0A=
> From:=A0Lok, Chen Huei <chen.huei.lok@altera.com>=0A=
> Sent:=A0Friday, February 6, 2026 4:19 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Michal Simek <michal.simek@amd.com>; Tom Rini <trini@konsulko.com>;=
=0A=
> Alexander Dahl <ada@thorsis.com>; Rosdi, Danish Ahmad=0A=
> <danish.ahmad.rosdi@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.c=
om>;=0A=
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Maniyam, Dinesh=
=0A=
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea=
, Kok=0A=
> Kiang <kok.kiang.hea@altera.com>; Lok, Chen Huei <chen.huei.lok@altera.co=
m>=0A=
> Subject:=A0[PATCH v2] drivers: fpga: Use SOC64 conditional instead of=0A=
> Agilex/Stratix10=0A=
> From: drosdi <danish.ahmad.rosdi@altera.com>=0A=
> Replace the conditional compilation checks for=0A=
> CONFIG_TARGET_SOCFPGA_AGILEX and CONFIG_TARGET_SOCFPGA_STRATIX10=0A=
> with a CONFIG_TARGET_SOCFPGA_SOC64 check.=0A=
> The affected code is common to all SOC64-based platforms, not just=0A=
> Stratix10 and Agilex. Newer devices such as Agilex7M and Agilex5 also=0A=
> fall under SOC64 and require the same handling.=0A=
> Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>=0A=
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>=0A=
> ---=0A=
> =A0drivers/fpga/altera.c | 6 ++----=0A=
> =A01 file changed, 2 insertions(+), 4 deletions(-)=0A=
> diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c=0A=
> index 4a9aa74357e..246df72cb89 100644=0A=
> --- a/drivers/fpga/altera.c=0A=
> +++ b/drivers/fpga/altera.c=0A=
> @@ -12,8 +12,7 @@=0A=
> =A0/*=0A=
> =A0 *=A0 Altera FPGA support=0A=
> =A0 */=0A=
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \=0A=
> -=A0=A0=A0=A0=A0=A0 IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)=0A=
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)=0A=
=0A=
Please respin against current master; drivers/fpga/altera.c uses CONFIG_ARC=
H_SOCFPGA_* not CONFIG_TARGET_*. Likely want CONFIG_ARCH_SOCFPGA_SOC64 if a=
vailable.=0A=
=0A=
> =A0#include <asm/arch/misc.h>=0A=
> =A0#endif=0A=
> =A0#include <errno.h>=0A=
> @@ -48,8 +47,7 @@ static const struct altera_fpga {=0A=
> =A0#endif=0A=
> =A0};=0A=
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \=0A=
> -=A0=A0=A0=A0=A0=A0 IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)=0A=
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)=0A=
> =A0int fpga_is_partial_data(int devnum, size_t img_len)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> --=0A=
> 2.19.0=0A=
=0A=
Best regards,=0A=
Tien Fong=
