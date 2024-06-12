Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C40C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 13:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5386987C7E;
	Wed, 12 Jun 2024 15:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="lj1rRMl6";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="lj1rRMl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A437887C3; Wed, 12 Jun 2024 15:57:25 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2620::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFF587C7E
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 15:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vasileios.amoiridis@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1oXhn4MXULqwbVI+5OuLrZddXY8JGLX8+atvM5OlAmBYNMOZoY9U7nHfUhC5/u7C9jIXx2NB+LMPQ4K8EcuAHUBvCilrfYh5nzG3jGBZGkngBVR0lm+ryZivx4C+iXtpjOeN/57b8qGdemoWWE2IcABE1ZvhYtktisdIMR8wgPHABU/q8SpRPwSAZC3Ujcgg2r7QzpF+cH7Y4yHi/YAlFhMPv7zLegfdAy+8H3VE++wDRG5g4QPT+goLjuJzCDOhOwO/6gTIIfSo34PoWXQ8EY4fM7y+4n4fcCaNoI7Hq97dlgkOfmJojtjHiA5Q3Exq7MuCU83Zc5lls9OVYzYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0p5StvWz9SlYZ6wVsj6WCYXUwm9oUHLCYbJaMBO23o=;
 b=Wnb7D/bNGrkd6gL9/f290H4erm8E415is4nXOYN0LXbr7vLUKHMA5ipuorE2Vo5nyf9gVo2+QuQIhYS2V/TWMlH+kc04R0hgSQEkMpyHkGO91CDBfRHCTC3/nrqSdK3v1XmYei6mbsIxa4PgBnyClxzsd8Ke3gWN6qqlo/Zmdj+5X6X3XumNrtGtf4OBuhfJQDSzMXZCrKktlP6F+57ASgYbvKH0zzcuVBvXDnEjkCuPZLUu8WAKah+Bh29fRZN5EygL6gFNylef3JTkdKb0bGyDqfPTkWDJso9r/3PB0KzNQ3YQmYBX3p33ESj5Jaj1TR/fDVPMRgEhBnJcsf2rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0p5StvWz9SlYZ6wVsj6WCYXUwm9oUHLCYbJaMBO23o=;
 b=lj1rRMl64gxy28/yCH+v5oKE2ghQABlfD2sT+kUTaOH3LKW79n84ZUHfFh5rYRq1VUi0/GfU90ufOPRx6bMZbAgyOaBAlPDrW3Zo6CT4yNxgdk55wsH2tqL4hnpviGwMP2GEFwVBMqaKhllTMVev/61JlFILh21eNXsQVJjblyw=
Received: from DU6P191CA0052.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::12)
 by ZR0P278MB0790.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 13:57:21 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::ca) by DU6P191CA0052.outlook.office365.com
 (2603:10a6:10:53e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Wed, 12 Jun 2024 13:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Wed, 12 Jun 2024 13:57:20 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
 by mx4.crn.activeguard.cloud (Postfix) with ESMTP id CBBC981DC2;
 Wed, 12 Jun 2024 15:57:15 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
 by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id B98B981D6C;
 Wed, 12 Jun 2024 15:57:14 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=lj1rRMl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0p5StvWz9SlYZ6wVsj6WCYXUwm9oUHLCYbJaMBO23o=;
 b=lj1rRMl64gxy28/yCH+v5oKE2ghQABlfD2sT+kUTaOH3LKW79n84ZUHfFh5rYRq1VUi0/GfU90ufOPRx6bMZbAgyOaBAlPDrW3Zo6CT4yNxgdk55wsH2tqL4hnpviGwMP2GEFwVBMqaKhllTMVev/61JlFILh21eNXsQVJjblyw=
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) by
 GVAP278MB0167.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.38; Wed, 12 Jun 2024 13:57:13 +0000
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67]) by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67%3]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 13:57:12 +0000
From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
To: "vassilisamir@gmail.com" <vassilisamir@gmail.com>, "monstr@monstr.eu"
 <monstr@monstr.eu>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "santoshsagar.algapally@amd.com"
 <santoshsagar.algapally@amd.com>, "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>, "sr@denx.de"
 <sr@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Topic: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Index: AQHatdXD0/P73fwV50Kiuh9pvfodrrHEMRQAgAAEGQA=
Date: Wed, 12 Jun 2024 13:57:12 +0000
Message-ID: <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
In-Reply-To: <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic: ZR2P278MB1164:EE_|GVAP278MB0167:EE_|DB3PEPF00008860:EE_|ZR0P278MB0790:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a2c48a-80e4-4012-6139-08dc8ae793e4
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eFVTTVc2QnQxcFFrYk1Kc1dNTkliUGlrZk93dGlwUWxmZGVTRmlLcGlYbW9u?=
 =?utf-8?B?aG5HSnJXMU95azgyS0l1SXZuZ2hnWHZ5VDE3aGRVYno1QUwwa2xycklSMno1?=
 =?utf-8?B?U1dEUXhFVkVlQit5YmVUK2pGNlZjNnBNUDlGVnhrR2oxUFpFOURUZ3dqaDRI?=
 =?utf-8?B?THJDdDVMamdPV3RzL1ZpVTk5SzBXQUdyZGNnSVhjaVloYVg3N1hoWVh3Nitq?=
 =?utf-8?B?SzZnNzNRSGhrZ3IvNkI3YXo4QVc0NWVzMVZpQkY1OXpFNVBadEZ5bW5uSWE2?=
 =?utf-8?B?YkZDYTNjQ1A4UEJmMDh0bU1PeFRQSEUvbDRNYWJXTElBSjFrUzcwSkg3VG5q?=
 =?utf-8?B?d2hhRnFpbWlsYlZYSzZpRWw3MFlnOHMzL0Qza1VYOEJQdmtzd1FMQzdiSlZR?=
 =?utf-8?B?alkrYWI0ZUZQR2s3RHdVNkthZ0lhS0JhSThWWi9YTWNPU3pZV3hvUDhNaXR3?=
 =?utf-8?B?TmEwSjB5VFJnWndkMVRnblN3aVdSdU1VREI5L0k1c2RpM2o5S2hOamVGWmhL?=
 =?utf-8?B?QnNiYUJETEVOUy9hR3M1WGY4WTg4cTlzYW9GVGs3amtlR1hzODdWanllKzJv?=
 =?utf-8?B?MldqdGNUSFIzVUJrSWtEVGtCN2ZqZ09ldjF0YlNkL1VpeTRicTB0ZHpFd2ZK?=
 =?utf-8?B?UkRxc2J6N08zYklIRjA2blB5UVVOdXlkT2pIRGI3S053U29DMHM0NktmZlNu?=
 =?utf-8?B?UkxVaHpLTDNSSGdYaHZJSENta09FMTlTa1Z3QVZocnNoRjJuc3dnSDljOUFR?=
 =?utf-8?B?VFVrSWNmVURqVWpRRmhMY2k5T3hRK0ZRVkdXSXVpOGo0QVBpRllMalQ3c056?=
 =?utf-8?B?OWhjQmo0SERjNTB4QlpSWEY3LzJ0UmJXYlYvUGZnN3U4OUZNYkZMYXR2S0xj?=
 =?utf-8?B?Zm9DZmZER1ZsbFBaVmFBemdmcm84NFpPU2hrQ2wxeldLbXBJU09TRUh4cFRt?=
 =?utf-8?B?ZG5naHlRb1l4N3AvcUt6R0NaOXN4UlM5Ylk2dEROU2d4eFFZbjh6NUtpZmVh?=
 =?utf-8?B?MUhKNy9xc211ZWxZRFoxNmhPRHZVdDdKVlBCdThWV3FRaFc3QWRGYjlyblo1?=
 =?utf-8?B?amxFNmcxM3Z5MXpiRFVoamllNzBOMXF3QU9icHY0eGpYWDhkNHpsTDIrdHJz?=
 =?utf-8?B?cmlnOXJnaFVURlVPYmFWWVM1bDgydnRYb3h3UVEyVzhFZXg3S3BsWFJhSmFJ?=
 =?utf-8?B?YVJPUEVUZGk1QzVmMWdJd3VVUHpyZGhBejgwRmF0a1lnakhxT2RGV2FtVVdX?=
 =?utf-8?B?cFhFak95UktIVVZWNWhNTVNSTnhRaHpqcit6NzNvbE9vWkt4T3dkR1J1bUNq?=
 =?utf-8?B?cmgyNlo2UDJEWGk3L1ZRc2FxU3R6elV2T3JHUVFnWW55MC9BOTdtTEhEV2Iw?=
 =?utf-8?B?U2ViNmVlZHRPMy9BTmdYY2dycG43NDJqY3d6YXFzMmZraklCbWQxRkdVZUpn?=
 =?utf-8?B?bEszQ3phbEp6VG1Na0xYS05DRVZ2SThNekNHQTM5VUYzRllRdVo1L3JvT29n?=
 =?utf-8?B?OVVlZzNsNXVtWWVxRjl1YnRTRnFJcFZBOGE1QXRENFlTQ3VmTGkrQ0gzRi80?=
 =?utf-8?B?OWlGUkVrTzd4ampmai84WkRha2szR2RSa1VKYlZiY3JsVms0OSsvK0F4Y2pU?=
 =?utf-8?B?Z2d4SnJwdXB1cjdoRnUrMGFBeWF3V3Zob1BvMlhoUXlTSXhRT0d4YzNqd0l4?=
 =?utf-8?B?NVY2V2JONGNBaDJGWTNCTHRsRG5DZm5QSkdqSkF6akUzaVlDeU9Ca3FDejQx?=
 =?utf-8?B?cUwyVzREb2VsWUtKSU5KeGVkcG8zckozWWQyblIvaGhVbWNGaHhhVHV0cEpD?=
 =?utf-8?Q?njNXMndLl8BkRYo9le8jHHxIY4WFY8Y36aTbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4912AF833DAB4B4793ED28C7C8CF02AE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0167
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8bc87c1-0706-4ac2-5300-08dc8ae78f70
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|1800799016|82310400018|35042699014|376006|36860700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm9oeDcvMExsTXV1Z1BjcFJ5YXBWL2FJTG1tZnE5dWtJMVF1R0JURkE3Mkkw?=
 =?utf-8?B?VzlyaHR6QXR6ZUEzdzZqQ0Yzc0tpU2FkaEhKK0NiSkk0UWsxbU82MVA5bDlE?=
 =?utf-8?B?Uk11SVRCcVFjVkkxb3ZPbjJjQklXTVlqQVJvaGRPazRPRk8yWTdtYU5CUFRW?=
 =?utf-8?B?bWNvRmFVLzFMSm50MTFGNWdhZ2xJTWxwWW5PcjlwSmhNTUxPT1hKRmFNTS85?=
 =?utf-8?B?eU9EUGpiYmR2Lzk2NDZlZjVGdXd1LytUK0lkK1NjbjRab0FXMjRoYmhLbEVn?=
 =?utf-8?B?blJqU1dZMWRNSnlwLzR4c09jd1E0VmJ1cmNvSk5MYy9IZXBvZVR5d2JpejB6?=
 =?utf-8?B?VGwyOUYzU3dkUU9uMXN6SW1CNkdCNmYvbEZyMUhkK2ZzUDNDNzdRSy9pNUdh?=
 =?utf-8?B?SXBvcUlxT3liS0RkcnQ0a0REcjllbEd4cHI1VS9KdkJrR0cwRldRUUF0TzYz?=
 =?utf-8?B?bEN6SEE4Q2Z3QlNTRDVGM0dnOTY0cmVFVkI2V0QvRElUdGRONmJ5UUZmUyta?=
 =?utf-8?B?Z1NXR0Q5dmdCUTJWNXE5KzBjV244UFFocndaN3I5OTJmUEgwVXIxWFIvY3FN?=
 =?utf-8?B?REpSak5MSUZWZUlMR2xUU1U3NTZNY3IzWENaV3pXbjB3OG5XQkJPY1VvTjNL?=
 =?utf-8?B?YkZtSjZISS9uWGJlMTRDajErTjdMRllKbkZHQlJEMzNnNk1kVkJTeDhTVjdp?=
 =?utf-8?B?bCt4MW9QcWIyVzdRZ0NBeXlpMDdvUUhxWVFQVlMzMllsNGhlY2RFK1ExT3oy?=
 =?utf-8?B?L0d0a3BCWkNHcUJKdVQwMkFiYTBCYk0yVTRFcEFpQloxNkRNT2RFK2JMUUJO?=
 =?utf-8?B?T0IyNUtSSVFFU0JNK2xIUitMdityaTVqcytMNGpnd05RTkcwMEluMjBYL1RG?=
 =?utf-8?B?RGhiUjd3d2lDL2dkeFQxQ0ZRaXJEVFFSV3huL2hvMFRUY2xvOGhDbElBMXpX?=
 =?utf-8?B?cHkrbzdWL0lZWWsweEhXbW1YZEdzOHcrMVdUcktNVjhZdjgzaWV2NE51N2dn?=
 =?utf-8?B?YWpvYWZ5Rm5oazFLbVVSeUQyTjIyZjRzRkowRTNXVVRKeUxYS1lQTXJIOHJw?=
 =?utf-8?B?Z3hNM2ZaMXFpa2lSd1poaEZiQjU5SHltNnhVbkNlQXM5SCtrVzVtc0xCL0Nh?=
 =?utf-8?B?UUgxY0FadTFIS3hLYXdnMG1VU2JaUVZPUXhVSHlEYVZzYXEzc3dUdGFzblJq?=
 =?utf-8?B?ZHFLd1h2dUo0ZzA2TVFTeldvQzBXRDNQVmkvZjNyWmEyckc1WDRXK1ZKR1M1?=
 =?utf-8?B?QlNmUVBxb2ZHOVFDZVJmcUU0SDVtLzRsZFdsajVORTdxMGlBWkRVTWdIZWxo?=
 =?utf-8?B?dDNyYjM2OTgydE9TdHpLcmV5dlZ6cmJUcndrc2V5d2FHeFRIYkw2eS95aHQ1?=
 =?utf-8?B?R0huSi9HNVdrTVZGQ01CeFhXamE0YUgxeWVJSE1aTURaVC9hRFJLOEtRS3JQ?=
 =?utf-8?B?Uk1qeEMvREFMa1l3VktQaUh2dGNJaXVWSEo4YjQvQm5vemF1cXhOdmNBaFJp?=
 =?utf-8?B?QW5JOCsyLzZlZkUrNnQ5QWo4Vlk1akc1MG1LQStxVWtGNHlzMkg0VEtiV2RB?=
 =?utf-8?B?Y3ZPSjJIR0FVZnE5eldzZzJza2REQVlobUE5VFN2ZCs1WkVXV0paUXpEY1R2?=
 =?utf-8?B?K0h2T3o4VUsyVWo5aGxxbzJsTTFMQ1FPRUg5NFUxOG5TK3hsYTRQYUZ3b1E3?=
 =?utf-8?B?QS9oN0JQMUYrclFZQ2RvSTJJb0kzOUZPNlhNcDEyUXA5QlFkYjFuSTBjNmk2?=
 =?utf-8?B?SVN5ampKcUFiK0I1Slk3NkVzNTg5RDZQMzYwTzNHQm8wMnVWOHM4ajFFcUFs?=
 =?utf-8?B?aEVKNHFvTjUrVDVrYUNQWW81R0VLUm5qM24zVGVlODJHOGxCUy9ZRWJkVHVw?=
 =?utf-8?B?eXdUUWpJcWlocU5XSVd3TDU4VUsxZHJPK2x6Ull3ekt1SFE9PQ==?=
X-Forefront-Antispam-Report: CIP:51.107.16.99; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx4.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230032)(1800799016)(82310400018)(35042699014)(376006)(36860700005);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 13:57:20.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a2c48a-80e4-4012-6139-08dc8ae793e4
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.16.99];
 Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0790
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

T24gV2VkLCAyMDI0LTA2LTEyIGF0IDE1OjQyICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
IEhpIFZhc2lsZWlvcywNCj4gDQo+IMO6dCA0LiA2LiAyMDI0IHYgMTU6MjEgb2Rlc8OtbGF0ZWwg
VmFzaWxlaW9zIEFtb2lyaWRpcw0KPiA8dmFzc2lsaXNhbWlyQGdtYWlsLmNvbT4gbmFwc2FsOg0K
PiA+IA0KPiA+IEZyb206IFZhc2lsZWlvcyBBbW9pcmlkaXMgPHZhc2lsZWlvcy5hbW9pcmlkaXNA
Y2Vybi5jaD4NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IMKgwqDCoMKgwqDCoMKgIC0g
UmVtb3ZlIGR1cGxpY2F0aW9uIG9mIGN1c3RvbSBoYXJkY29kZWQgZW52X2xvY2F0aW9uc1tdDQo+
ID4gY29kZS4NCj4gPiDCoMKgwqDCoMKgwqDCoCAtIEFkZCBpbXBsZW1lbnRhdGlvbiB3aXRoIGdl
bmVyYWwgYXJjaF9lbnZfZ2V0X2xvY2F0aW9uKG9wLA0KPiA+IHByaW8pDQo+ID4gDQo+ID4gdjE6
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjQwNTIyMTc0NzM4LjczNTIy
LTEtdmFzc2lsaXNhbWlyQGdtYWlsLmNvbS8NCj4gPiANCj4gPiBWYXNpbGVpb3MgQW1vaXJpZGlz
ICgxKToNCj4gPiDCoCB4aWxpbng6IEFkZCBvcHRpb24gdG8gbG9hZCBlbnZpcm9ubWVudCBmcm9t
IG91dHNpZGUgb2YgYm9vdCBtZWRpYQ0KPiA+IA0KPiA+IMKgYm9hcmQveGlsaW54L3ZlcnNhbC1u
ZXQvYm9hcmQuYyB8IDQ3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiDCoGJvYXJk
L3hpbGlueC92ZXJzYWwvYm9hcmQuY8KgwqDCoMKgIHwgNDcgKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLQ0KPiA+IMKgYm9hcmQveGlsaW54L3p5bnEvYm9hcmQuY8KgwqDCoMKgwqDCoCB8IDQ5
ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ID4gwqBib2FyZC94aWxpbngvenlucW1w
L3p5bnFtcC5jwqDCoMKgIHwgNTUgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAt
LS0tDQo+ID4gwqA0IGZpbGVzIGNoYW5nZWQsIDEwMSBpbnNlcnRpb25zKCspLCA5NyBkZWxldGlv
bnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+IA0KPiANCj4gSSBoYXZlIHRvIHJl
bW92ZSB0aGlzIHBhdGNoIGZyb20gbXkgcXVldWUgYmVjYXVzZSBpdCBpcyBhY3R1YWxseQ0KPiBi
cmVha2luZyBjdXJyZW50IGJlaGF2aW9yLg0KPiBDSSBpcyByZXBvcnRpbmcgYW4gaXNzdWUgd2l0
aCBpdCBhbmQgSSBkaWQgYSBjbG9zZXIgbG9vayBhbmQgd2hhdCBpcw0KPiBoYXBwZW5pbmcgaXMg
dGhhdCBpZiBvbmUgbG9jYXRpb24gaGFzIG5vIHZhbGlkDQo+IGRhdGEgaXQgZ29lcyBhbmQgbG9v
a3MgYXQgYW5vdGhlciBsb2NhdGlvbiBmcm9tIHRoZSBsaXN0Lg0KPiANCg0KQnV0IHRoYXQgaXMg
dGhlIGRlc2lyZWQgYmVoYXZpb3IsIGlmIHRoZSBlbnZpcm9ubWVudCBpcyBub3QgaW4gb25lDQps
b2NhdGlvbiB0byBjaGVjayB0byB0aGUgb3RoZXJzLg0KDQo+IE9uIFp5bnEgaXQgYmVoYXZlcyBs
aWtlIHRoaXMuDQo+IA0KPiBNTUM6wqDCoCBtbWNAZTAxMDAwMDA6IDANCj4gcHJpbyAwDQo+IExv
YWRpbmcgRW52aXJvbm1lbnQgZnJvbSBTUElGbGFzaC4uLiBTRjogRGV0ZWN0ZWQgbjI1cTEyOGEx
MyB3aXRoDQo+IHBhZ2UNCj4gc2l6ZSAyNTYgQnl0ZXMsIGVyYXNlIHNpemUgNjQgS2lCLCB0b3Rh
bCAxNiBNaUINCj4gKioqIFdhcm5pbmcgLSBiYWQgQ1JDLCB1c2luZyBkZWZhdWx0IGVudmlyb25t
ZW50DQo+IA0KPiBwcmlvIDENCj4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIE5BTkQuLi4gKioq
IEVycm9yIC0gTm8gVmFsaWQgRW52aXJvbm1lbnQNCj4gQXJlYSBmb3VuZA0KPiAqKiogV2Fybmlu
ZyAtIGJhZCBlbnYgYXJlYSwgdXNpbmcgZGVmYXVsdCBlbnZpcm9ubWVudA0KPiANCj4gcHJpbyAy
DQo+IExvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBTUElGbGFzaC4uLiAqKiogV2FybmluZyAtIGJh
ZCBDUkMsIHVzaW5nDQo+IGRlZmF1bHQgZW52aXJvbm1lbnQNCj4gDQo+IHByaW8gMw0KPiBMb2Fk
aW5nIEVudmlyb25tZW50IGZyb20gbm93aGVyZS4uLiBPSw0KPiANCj4gDQoNClRoaXMgaXMgdGhl
IG1lc3NhZ2UgdGhhdCB3ZSBnZXQgYXMgd2VsbCB3aGVuIHRoaXMgcGF0Y2ggaXMgbm90IGFkZGVk
Lg0KDQo+IHByaW8gaXMgbXkgcHJpbnQgdG8gc2hvdyB3aGVyZSBjb2RlIGlzLiBRZW11IGJvb3Rz
IG91dCBpbiBRU1BJIGJvb3QNCj4gbW9kZSBhbmQgU1BJIGlzIHRyaWVkIGZpcnN0IGFuZCBiZWNh
dXNlDQo+IHRoaXMgaXMgeGlsaW54X3p5bnFfdmlydCBkZWZjb25maWcgZHJpdmVycy9lbnYgbG9j
YXRpb25zIGZvciBvdGhlcg0KPiBkZXZpY2VzIGFyZSBwcmVzZW50IHRvby4gVGhhdCdzIHdoeSBp
dCBnb2VzIG92ZXIgdGhlIGxpc3QNCj4gYW5kIGl0IGFsd2F5cyBlbmRzIGluIG5vd2hlcmUgd2hp
Y2ggbmV2ZXIgZmFpbHMuDQo+IA0KPiBJZiB0aGlzIHJ1bnMgb24gcmVhbCBIVyB0aGVuIHRoZSBz
YW1lIGJlaGF2aW9yIGlzIHZpc2libGUgYW5kIEkgZG9uJ3QNCj4gdGhpbmsgaXQgaXMgcmlnaHQu
DQo+IEkgdGhpbmsgdGhpcyBzb2x1dGlvbiBzaG91bGQgYmUgcmV0aG91Z2h0Lg0KPiBJbiBwcm9k
dWN0IGN1cnJlbnQgYmVoYXZpb3IgZnJvbSBvdXIgY29kZSBpcyBub3QgdGhlIGJlc3QgYW5kIGN1
cnJlbnQNCj4gVS1Cb290IGltcGxlbWVudGF0aW9uIGlzIG5vdCBhbGxvd2luZw0KPiBmbGV4aWJp
bGl0eSB0b28uIFdlIGFyZSBlbmFibGluZyByZWR1bmRhbnQgdmFyaWFibGVzIHdoaWNoIGNhbiBi
ZQ0KPiBvbmx5DQo+IG9uIHRoZSBzYW1lIGRldmljZSBidXQgbm90IHRoYXQgeW91IGhhdmUNCj4g
b25lIGNvcHkgaW4gUVNQSSBhbmQgc2Vjb25kIGluIEVNTUMuDQo+IFRoYXQncyB3aHkgSSB0aGlu
ayBsb2NhdGlvbiBzaG91bGQgYmUgcHJldHR5IG11Y2ggcmVhZCBmcm9tIERULg0KPiBUaGVyZSBp
cyBvcHRpb25zL3UtYm9vdCBub2RlIHdoZXJlIGxvY2F0aW9uIG9mIHZhcmlhYmxlcyBzaG91bGQg
YmUNCj4gZGVzY3JpYmVkIGFuZCB0aGlzIHNob3VsZCByZXBsYWNlDQo+IGVudl9nZXRfbG9jYXRp
b24oKS4NCg0KWW91IG1lYW4gdGhhdCB0aGVyZSBzaG91bGQgYmUgc29tZSB0eXBlIG9mIG5ldyBV
LUJvb3Qgbm9kZSB0aGF0DQpkZXNjcmliZXMgd2hlcmUgdGhlIGVudmlyb25tZW50IHNob3VsZCBi
ZSBsb2NhdGVkIGFuZCBnbyBhbmQNCnNlYXJjaCBpbiB0aGlzIGRldmljZT8NCg0KPiBJdCBpcyBh
IGxvdCBvZiB3b3JrIHRoYXQncyB3aHkgSSB0aGluayBzZWNvbmQgc29sdXRpb24gaXMgbW9yZQ0K
PiByZWFzb25hYmxlIGZvciB5b3Ugd2hpY2ggaXMgc2ltcGx5IGNyZWF0ZSBuZXcgS2NvbmZpZyBz
eW1ib2wNCj4gdG8gZGlzYWJsZSBib2FyZCBlbnZfZ2V0X2xvY2F0aW9uKCkgaW1wbGVtZW50YXRp
b24uDQo+IA0KPiBUaGFua3MsDQo+IE1pY2hhbA0KPiANCg0KWW91IG1lYW4gdG8gYmFzaWNhbGx5
IGRpc2FibGUgdGhlIGJvYXJkIGVudl9nZXRfbG9jYXRpb24oKSB0aGF0DQpleGlzdHMgaW4gYm9h
cmQveGlsaW54L3p5bnFtcC96eW5xbXAuYyBmb3IgZXhhbXBsZT8NCg0KQ2hlZXJzLA0KVmFzaWxp
cw0K
