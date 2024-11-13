Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD614D637B0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F3E890DA;
	Wed, 13 Nov 2024 20:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ZLgvZUR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E01890D9; Wed, 13 Nov 2024 20:50:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB3C891E3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R76tomCoGt5Ex/VmP2jtma7VkwmYGK/GUB/NVQ7igYaxggBJ/qquoyzHDmm53lpEfS9/w0uwNum3jgBFLK9630XqEQw4WjNrZsbXhwXPBrdhUxfUg5aIsJLF1AAHeYw57F243vXcuvrVmslG+eyOQTPDUKYWHP/mxRsOMsY4e+U66s9pMOorJlpTvQ3uTGk93YvfCILBtc9NsU6gBsMxVRIRmDItnK3UjR1GlR368eS5xI+GIMG0IeoKFsUfvdHrO3nmepPknVGoF11S2Fz1+9drrUi7J0dvbV6s85sVD+W/HtpiqPe+xl3kNnR4eHcakHL2sj0iTwJ0vjhCbGiVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H95l4fC1oMgDULFmopqvnYc6/0l6cLTpd7RaoFZ8BDs=;
 b=Wdeq31FqcFnbK43AdNP+F1lJC2nH6b4PI85sxazBmFEJe4hvZ5GJRkG/2gYYdK8/7A3+xlt0fYzTrvcsc56kI2+4mDsjadfIm6P046I2+k1+yNs09indmUbmY02J0Zza/IbcuutWAEfT3GWd5DYNCVB0zrzu8uVseIsRIeqbGRtR6ZbsK4iWGYYrS242Ut4AGvCnjahai4fDCBeqPNXk59Ob5ZDJVo+e/oMlsjyMMf9XMGce5KEOMg0Ae8WuOukSIXS+8POXC+zHI6wF0FNaFMMKM55UbfQ6lMhQQztCxCrRGju17IR6oKG8QMnWVoGjJXRt3/fJHo4iA2WSbN1LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H95l4fC1oMgDULFmopqvnYc6/0l6cLTpd7RaoFZ8BDs=;
 b=ZLgvZUR38BEbBni6QWszE0CLw1ctIHcbK8n4AHqPlWajkqeSqw8qKxx5fMy89vW6lwPPZfp81djEZPbk4hkWKJteRv+cVrAVemjpOwUwL7C+3h8wOcdhN6VYohKL3zaXKGje2CIiKX6up/IPKmAB//afMAXrKubculTIZFI1DYo=
Received: from DB9PR06CA0029.eurprd06.prod.outlook.com (2603:10a6:10:1db::34)
 by DBAP195MB1098.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 19:50:07 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::42) by DB9PR06CA0029.outlook.office365.com
 (2603:10a6:10:1db::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 19:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 19:50:07 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:50:07 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:50:05 +0100
Message-ID: <cb26ccde-f10f-4f8f-8a92-2e44e272f538@phytec.de>
Date: Wed, 13 Nov 2024 20:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
To: Fabio Estevam <festevam@gmail.com>, Christoph Stoidner
 <c.stoidner@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej
 <andrej.picej@norik.com>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-3-c.stoidner@phytec.de>
 <CAOMZO5App0zamP_zcMLEH2ih9=q25VfGEi6k2agoVDAQ2Kwirw@mail.gmail.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <CAOMZO5App0zamP_zcMLEH2ih9=q25VfGEi6k2agoVDAQ2Kwirw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|DBAP195MB1098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdbe2b3-cc02-42fd-5537-08dd041c602f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azdrdnF4MFM2eXhQbXJFMVRuTTFxNmJ2bks0alBiOCs2UEdKSTF0QUwvdTN1?=
 =?utf-8?B?RE9ucFN6b0N4ODdYUkxPQkQ0SVkwcjJXTlA3Zk5qd0lvVUIxL1E4SnNDYWJn?=
 =?utf-8?B?MTUvcDlBWTNCT0F1dWh4bGphS0JNcUMzeWQ5a1BWdURTQW9MTXRpMGt4Zmlx?=
 =?utf-8?B?am5tek9MMFJsYUF0d0VwaWtFaHpseFNpdmZnVEJYY1BHY3ZiMERDQ09CS2V3?=
 =?utf-8?B?VDZWcVYvOHhpRFloNVVDS0pBSU54d1hrQ2lUa3RUNGwwalphdHFnOHpLbFIr?=
 =?utf-8?B?NXBVVjBZRGVoWjBHUVlQWTFYUWQxc3RJQmphUHE3bk5GQ1ZPOHJwNkdpQmtR?=
 =?utf-8?B?d0R1TnFIUWpDbGg3VC83aGVXTFhWM21LVU8yRTNHQkxDamlpWC9DL25WTkxr?=
 =?utf-8?B?RWJFNmNzTWI0Zm94RTQvMUhzSzRNd0FQN3FFSzBlTVB6SVZCOWNBZGhERkQx?=
 =?utf-8?B?ck92L1RBRGpKaE1LMlEzTVNCbmwrSUpXYWlKMGF4TUZ1ODEvamhsTHZmaDN4?=
 =?utf-8?B?MnA4NmVCaXI3bTB0bzgwcDRUSnhOYTVJbDhlaVZMSUdRZTBsNTk4WGRXM3Vn?=
 =?utf-8?B?U2RWSUFtY20yZ0lRWTY2REVGcUc4WHg4MUViYjhXVDh6OVh0MFlhTG5NYm8z?=
 =?utf-8?B?OE0zWEg1R1VsMisxNEx3cXJqSGtIamxoVGJ3L1JRR0FKNk9IdEtDTjM2eUxk?=
 =?utf-8?B?ZlMwdHlaVU0wOEpXazJnd3BFMllQL0xRVm80b2R1dGFHY1BKOFI5bC9IVnQr?=
 =?utf-8?B?T1NTRkFNbldwN2VzODl6bSs4T0pka1VkMkowZks5OU9lSnZIT01JbGVhQk55?=
 =?utf-8?B?RWdSTTYxQ0JSK0pMbmU1OWNkRmNPN0VYWXdUdkFWQWx3SHZCZkNpU3drUm1Y?=
 =?utf-8?B?S3J3QkNGNHZ3amVJeWdoMWZaNFB2WjNNLzlVOThEY1hVaDYrRWJrU090N1FI?=
 =?utf-8?B?TVNTNzBBdUVqV3VoQktEL3dwY3ZzZU9Zd1o0SlNhU3pQdXByL0VZMjBvL1Fp?=
 =?utf-8?B?R2tNY0hDWjRHVVJFSCthUkNVOG5DcVllY0NzMjkraTQ5Q1J5M25Yc2JGWEJt?=
 =?utf-8?B?UlNqVkxTbkY4RkdsNUp1UFRXN3ZnTFAyeEVCd0cvRG00azdzVERpeTByeG9j?=
 =?utf-8?B?SGdPS1gvd1B6Z0xURVQxMU5FVnZYeWZrbjhPWDZvdy9HZi9Zakt0eWtOR2NJ?=
 =?utf-8?B?QU95Y3FvYWVydnJlaGVSM2h6WlV4bVBIaGVhS202ZjlSSVFLYW9IYXoxb3Fq?=
 =?utf-8?B?eVprZnc1OGM5K04rYXhlL0F0RGE2bCt5ME1JcFI2dGJNekk1TlU0dXRTTHNQ?=
 =?utf-8?B?akV1eVYyZU5jZW9xTG5qbmJrSUtPVURzMHZGTml1RzdJeSt6TWM5NzMvYWVI?=
 =?utf-8?B?dkVscnpyOWFpQkRFcjQwL3YzUmQxR0JCajFudzF0NmRzU1FEZ0pUcnJ6YVlK?=
 =?utf-8?B?N2k1MUUyMFhqOHNKcjVHakZFeWd4RXpscnNiaTU2cllSWDMxMGNyMkVVRzgy?=
 =?utf-8?B?RGJLVFBTY3laaWQxZlBVcEdweGxSR1EvODdpNHdIelJZRWlrQXhxOWs4Szg3?=
 =?utf-8?B?L01OQUJDb2FoY3RDRWdsemRtN3dqY2dEVTlhRklTWUdpQjhqRWpvckVZcEk2?=
 =?utf-8?B?UDlIa25SRjA0cldCVFd1TU9BYkU0bDVhWHQwZWVENS83SENzR2JXZkpyV09J?=
 =?utf-8?B?U3pRbXp1V3NXckFEOGJaUDloS0RDd2tWSnMyL3ppdVFBR0xMWGVtVU15Vm1P?=
 =?utf-8?B?ZkdsVDJGTDc4WEpNMW5hbWQxYW9CU1ppRWRtQWY1R3VJM0EvYkF5ZFV1ZWZT?=
 =?utf-8?B?Mzd3cldZS2Jvajg1Y2I3bXhjTDZXbTlCRm5aWEsvRlhVajdXTnE0NTdSTHZY?=
 =?utf-8?B?WkM1Z3dlREFkT2RkemVrMUk2RitVRk1wQnQyVHArRHp0THc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 19:50:07.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdbe2b3-cc02-42fd-5537-08dd041c602f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1098
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



Am 13.11.24 um 19:29 schrieb Fabio Estevam:
> On Wed, Nov 13, 2024 at 1:16 PM Christoph Stoidner <c.stoidner@phytec.de> wrote:
> 
>> +
>> +       eeprom@50 {
>> +               bootph-pre-ram;
>> +               bootph-some-ram;
>> +               compatible = "atmel,24c32";
>> +               reg = <0x50>;
>> +               pagesize = <32>;
>> +               vcc-supply = <&buck4>;
>> +       };
>> +
>> +       eepromid@58 {
>> +               bootph-pre-ram;
>> +               bootph-some-ram;
>> +               compatible = "atmel,24c32";
>> +               pagesize = <32>;
>> +               reg = <0x58>;
>> +               size = <32>;
>> +               vcc-supply = <&buck4>;
>> +       };
> 
> It is OK to place this in imx93-phyboard-segin-u-boot.dtsi for now,
> but I assume this will also be sent upstream.
> 
> Please confirm.

Agree, we should add the EEPROM nodes to the Linux device tree.
