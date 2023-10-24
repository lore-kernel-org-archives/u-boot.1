Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C06C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 11:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9C787032;
	Tue, 24 Oct 2023 13:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=omron.com header.i=@omron.com header.b="JoyzSQC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7E787064; Tue, 24 Oct 2023 06:31:05 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC60286D94
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 06:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niek.nooijens@omron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frW/PCvFi2mDRcMahl/xSI3HvGKc5oYdDmRMStr+51mLdhvgeBZgVAcIiNyrU5Tr3UOUqhP5lX3VRgzE0EmYON7SbdgFlpxtDxrDktT8jd2PvdnwLWLoCV/zMFBK4w5u13E8vxW8cIju1qJoaOe84OxZIdzpCpUlMfro8pkWsJeHwecDxfwv5KHXFGnKQ5e9eh/84nFLV6t/9MfNZKnpEBVaSppQ6fKsU8ueXX/koeciyGxlteXrOslMniwRVlTtVsYmvWdy0+TCmfjqtdbOEx/3T4znbqOPV3CTvHCzDn0yzeBJXIUPZnOu4bcsPlLPunY/FH/VWPrZVALO1Ucz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xeNEdai2t38wR7Xs7Jy3JQgQWIrwJHE/oMuqWvjeI8=;
 b=RfBwmPiXipyTfqCmjuxB41AvDxCc38w/VRbZc9+2nu7J0A/9O7MWxbciojsrz/Hq4XyQQtiDSq5uxxoMdGOpq4pLgpE4KZKqtaZO5TyRANEpO8yHY9MrxC7RI47xgZPEtnVCs0NE3ZUGHAMP4OgyxPUKK9U2lOmccnIKfuR98OqO3X0XUg8IXx9CsZHdyOyscLcWju/SJB74Upg6EtSmLuZbgdY+Tr+KdvlW6vid4Dujn0qm1S1UjaJMyAosEMLD6DWkvNde42dlxTRd7uDHmG7gi4C95sOCvwFIp9MMHiqhqgew2VyuAiRLMK+R2k3ZOrrIomw0moLMBBqzGjEycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omron.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xeNEdai2t38wR7Xs7Jy3JQgQWIrwJHE/oMuqWvjeI8=;
 b=JoyzSQC3UoacZmU/KjFHbWYbeyt1fyj6OsNljCXCkmjBom29ZgM/Bs/upUL0oRcIwQK+I1+t72MiEQ+7JKYDSjH/W5okv5J+vw7h6UgDXNrqYTyguZG6wALROeVQh2mlkX7Rf07YtlsDV5TgrO+AeDEhZgwmr/7TCKknGfBPiY8=
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17a::14)
 by TYWP286MB2353.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 04:30:58 +0000
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c1fb:c9f3:b13e:1790]) by OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c1fb:c9f3:b13e:1790%7]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 04:30:58 +0000
From: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: quick question about TPM
Thread-Topic: quick question about TPM
Thread-Index: AQHaBjKW0la4Dg61rkK1nPrJuPcPfw==
Date: Tue, 24 Oct 2023 04:30:58 +0000
Message-ID: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB1495:EE_|TYWP286MB2353:EE_
x-ms-office365-filtering-correlation-id: b4cc45ff-fe6a-4e3c-0cc4-08dbd44a0513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oifkXrvzoYEnEe8N7CLEU0vkoxQ9puWe+vZzVn/EItxvnTEy8KuUDPxpSELphQBoXAMUlVmShyWbQHZ68WuUG2yN5NuDyIbNtH79o1KLgIXf13V+ri+cjT8Lu7Aa+ZfSpjNu/uhe+3DeK9DW+eUsLkviLavBUpiBvN6/qlRCvDR2wW06aqIfm7QNCfPSBV83GsXzGOnQWkRiLn7QJo5wE6sdzSUAiuDYV5xYqaLjTz4eEA2tHAeFvTyNTKBPTLcErk6X0GybOSq3wAJsPuGSVpGhfn4a1CyMc4fcf4DIy5rBT4gg4NpjcRyF+cKnd8Czs5D7cRjDdwCx+K2IaifCp/1MU+oQAkvSyZvepywJdBTFnH5gIIzYYv5wVVoyPiSg5W3HZZEJUBpasRp2WbNy2Q83wLVH8aUi3vzJzYSdNeXyY4lHahgQBUjXQU8MscxlHUlyqNF+Oe60SU9cggMWjx3zCpFjkUOEHYsch3y+lU1fdb46RcKUlB1yDQgHaA7dWC0MfUmCgMXo8uLZ7Ytcdo4h6KXCJslKofjqMd/D+nvT7dlILt4aA6ipJryteRv+En/bki40jvWGExguAHM3GIpNJdqX2n1NTkZ+aMSTPPJo9EMuKr+I7YBdZ+/n2Ke
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(4744005)(2906002)(41300700001)(38100700002)(66946007)(122000001)(3480700007)(66446008)(64756008)(76116006)(6916009)(66476007)(316002)(66556008)(6506007)(71200400001)(478600001)(7696005)(9686003)(83380400001)(86362001)(5660300002)(52536014)(33656002)(8936002)(8676002)(26005)(38070700009)(19627405001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VCt2QkJDNjdqTWlOV1M5TzRCYjBqSkJtSFJtK3dHc01SYmpyUWJmamUz?=
 =?iso-2022-jp?B?Z1U2bVo3SmlCdzRwUWR5Ylp0a2ZDWlpuMXJTTkRDL1lVU3k2Y1V6MlhL?=
 =?iso-2022-jp?B?YUVYQmF1dzd5RTcwVVdFMUtFdDVxSTFQemNhYVV2WmxwY1c1ZzQrb3V4?=
 =?iso-2022-jp?B?RjF5QkFGUnd3dFFrbEJFaWZydE5iUUkrN3UyWjhYMXVMcDI2NEdNcmc5?=
 =?iso-2022-jp?B?dTN1MXBqVStWL0o1OGtreWcrV0R1N0lCczBOaW5NOTdTcnc3QTcySWds?=
 =?iso-2022-jp?B?N2hWR1Axb24yUTRUaFk4Q3lscVRaWWVRS3JHcXd2cncwT2wrTWxoWTV0?=
 =?iso-2022-jp?B?b2tsWEEvK1dQdXhuUnZvMWwxOFZlTjRCaUg2QWlSNGxzeVpqZjZnMkdY?=
 =?iso-2022-jp?B?TkNuWVNxdmpzZGYrZFM3Vmw4NitUdytZUkpCTDRrYTFQSVN1bitmay9D?=
 =?iso-2022-jp?B?UVNpbE9lVjlOWjVkalIzcFdHcG1PVXJTbGxKRzQrN2w1UlFIUWJOaG9i?=
 =?iso-2022-jp?B?Zi9JU01YbUNRNkJkcFpjZ1VmT1Z0UnJtZk1BenFwVk4vZTNqV3lmbGx3?=
 =?iso-2022-jp?B?azZRblhGTjg2Z0hSaGwwa2RXKzdWWmM2KzRtQ01GajQrcGhNSkkxQ3JN?=
 =?iso-2022-jp?B?bkdDWWxHanFnNjdNT0pjOWsvZmJRZ0dZckViSHppelpsL3R0cHJRNmhs?=
 =?iso-2022-jp?B?SThwYXRwUVd5QzE0VWRRN0dia2hWMlVEKy9IZS9kWHBHY3BTMm8ya1dJ?=
 =?iso-2022-jp?B?Z0pkZVRaRmc3WFgyRTB6QnhSSzdkbTdpNUZRbEhHL1FSallQYlFWWFhF?=
 =?iso-2022-jp?B?NGwwN0FJcFpNMzY3STMyQ2lKenZDNVpqeWdLaHc2R1pPNUlpNWpvanhE?=
 =?iso-2022-jp?B?WllLODNRQ01KRmFiTWJCM2h4blRLOHBQUDFEeVhNNWdwNUtoMEJ5anFi?=
 =?iso-2022-jp?B?VC9uU3IzcnNudE9aQXpjQjlKTHJGQzF0K05tWVBoaUhKVmw4ZDh1bXR5?=
 =?iso-2022-jp?B?YlJ3a0RhcjVmQzlvMWYzbzI5amFhUU9rc0k0L1RYT1d0L0JoUU9pZ1lk?=
 =?iso-2022-jp?B?VStxM0hHQVJJT1UwcWQzMFJCcTNpTmhGN2hyV3dLUFlQUUlYMnRZN2tz?=
 =?iso-2022-jp?B?d1oxN3MwUThaWUF0bkRJV3p3NHI4c09oaVRWWnFwN0cxU243ZEI3MWVr?=
 =?iso-2022-jp?B?cCtRRWpQVlNjR2paa3J1ZGI2dG1vbGpweG1VZ3VEYm9qYngwSU5mUEp1?=
 =?iso-2022-jp?B?NXdKQjgxODJJblhhM1p5M1hiVjFIZ01UcXFodWJVWS9SR0pqelFTbnZK?=
 =?iso-2022-jp?B?bTFqNUJaaDVqMkpUUWd5enA1cWpnVlRBUjBlV1ZSY0hzTFU2Z1cyS2FX?=
 =?iso-2022-jp?B?Ti92a0FOZDE3K3VOUllCd1VodTI4by9KdVIvM0JseEQ5WHhzWGozb2Jm?=
 =?iso-2022-jp?B?dnVaYlZhM2h4SUJSL0NwangyZWVRT1pTVjJtdU1UWnBaajBDTjNTa2JL?=
 =?iso-2022-jp?B?V1pFcVlJWTYvOTVYOFlaQ1dGbWhYVkdkVTJlMEo5bEVMYTh5d2w3Uktx?=
 =?iso-2022-jp?B?aGV1K293QXhjS1FpTzFTUGFMRGJQMytybGpiOWJLWEpoai9yNW9Gd2JB?=
 =?iso-2022-jp?B?WEMzaElWTGNCQXR3ZTU5dkZ3dGppNXpCOVJyZDdjM3g4QXZRQXhGd1BJ?=
 =?iso-2022-jp?B?aCs4WUM3WHZSNEpzdUYxSjhna0NJRllpV1R1b0Z3clZzQ1A5THRKU21s?=
 =?iso-2022-jp?B?QkxuTG5Wb1N1NGI0TVNxU0RxWHZjR2dnTGtkVEV1b0IyN1dNMFB4ZDlE?=
 =?iso-2022-jp?B?RGNPNUJjazJaazV6Q25zQkxCSldOclFCWUUzdERFTHF2ejFGN0l2SHR2?=
 =?iso-2022-jp?B?S1VzTzk0d1lsUWUxY2tkVUpKUGRiK3JZanBVUUVlUks1NytZN0gxYm9z?=
 =?iso-2022-jp?B?eit6V1h0Zlo2Vms2K1ZCTk9iZ0p5SHBkUS90MnZGbnhRZmhVTmxsUkxY?=
 =?iso-2022-jp?B?cE9rMCtKdGNiK3BEdUs0dFpkd3ZENFgzN0NSWlNUU3MranFvWXl4MHBS?=
 =?iso-2022-jp?B?WWlGa2QyUjVMUGJUVnR2WDRzc01JSkI1NlZEZmNZekRPR1VsYUJ2TDNj?=
 =?iso-2022-jp?B?K3l5NE1lNUNuYzdybzkvMXVGWEhwSDBaNEdjZFRJaEpONzA2eDZGcUNt?=
 =?iso-2022-jp?B?YjNzSUxselJDbXBYaTVsNFRaeWFlVkNaKytCSjhqZnVxSlRuU1JpbEhM?=
 =?iso-2022-jp?B?YkY5TjExM0VtWU5BYjVkajZEODVCZ3VQZ0N2S2Z1SkoySVBxOUJEWk1B?=
 =?iso-2022-jp?B?MTFLbA==?=
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cc45ff-fe6a-4e3c-0cc4-08dbd44a0513
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 04:30:58.0791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bCTxsMXnUgYpvrrusJndYmxg5zfIGY3Xubt+/gWgzz+i7Egf4KNsUHTmsD/VIgcdEeD9rdPyMARR0/ky+3siQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2353
X-Mailman-Approved-At: Tue, 24 Oct 2023 13:51:05 +0200
Content-Type: text/plain; charset="iso-2022-jp"
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

Hi

Just a quick question. I'm developing a platform using the socfpga_cyclone5=
_defconfig
everything is working, linux boots, but we decided to add a TPM to it's SPI=
 bus.
For some reason the TPM support menu in the menuconfig is disabled and I ca=
n't seem to find out why, or which file disables it. can you point me in th=
e right direction?

Thanks!

Niek Nooijens.

