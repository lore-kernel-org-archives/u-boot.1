Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21D5E77188
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 03:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB43805FB;
	Tue,  7 Jan 2025 04:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hui7wJ4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D167E8060A; Tue,  7 Jan 2025 04:24:26 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C209E805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 04:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6K3C2Sr4rjfbZBX8GHxOjDYhVqY0UGwHV0ZDm/5clXD3PqHtv3PSuG91xtVAK1/fkxv6AtGmZAhWEGhg3I2eEfMFdH1a1+jIC31QiZHnNUcf2+1hxioxJIhiFyQBky2DlfArH+3uP7K2kgn5Zv+2o7Cq8xElR/769SS7IaGTcOn0mjrFhRAcxOXS243BRsYqOsvCHw5hTayj5lzmZjsAOAnI3uGieBiSksqqF7DLJnjsWVFUGtivb39OoiBgXpb8vQTRX4woFx/RsSaQxWxtlOWZ+HMd8qAR0rLJKUtSt28kMIOScb14X4TR7Ry5ptmRvzzE6hSYp1wap9G7R6uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQj3E7xKmKIut3B8zNpo2UvETpVXPbNXvJKgh9klr3g=;
 b=eKJICip2eIE23Y2olu1BUGqVnwm+lxfupREJ3QvCuBWOwgh8yVDYqV4qJB0TJTRVlYNVz7qZvSA5kjruHF8yGQf89mbPCgLiY7/W5Yc4ahzACkGde8H86VCbD8isdJWb7p6ab6qkvYlfAAxCGymWEifIsaGy+6g61mPI7YyR+IDRBxR9ZXFbly7wTfDjC8jcs45tXfL0DSjzGDrw0Ee09Zdnver5bgIk875wAOfzgS2QJqYCe6aVZRRLIWgIpfLL1947lqOI3Ui+Oq/vJqC88r8sU8D+jFTrPVX4BqzdzT8UJ+4cwz9srTtuE6riO8QAdef5YvbQzxrDH+zxGWC7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQj3E7xKmKIut3B8zNpo2UvETpVXPbNXvJKgh9klr3g=;
 b=Hui7wJ4HY4TI6y/SbDkw2P8kDKTWtBQNEEai/OnchXOBshNUCRIIrLV9hZUbqFDS/7tsV53ml8PW+DU8vcfUcT0QUvpLF2rJcMgbArgzFCKCc2lFe1xnLQv29PiLaccK875ZO8GPhyaumojqoWnmd3BGv52g/RdZvTqXMsm65w5ICQV6hPUSVVWMmUUjXMlfPTuCZsN+p3pHYaJc7HGm+81nEE4FW/ez6gIKZBy41EsfN6AvSyP+Cmu2y/dTUmSsWqwpFKsZGu5s9UtlxvkD9d9wJ7mlgTjxPGrwbpTxcn1meP5DMgb5Q7iubRSuv1RRffJ6CQ0WYLctFwZ+W0E1+A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 03:24:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:24:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDIvMTddIGZp?=
 =?utf-8?B?cm13YXJlOiBzY21pOiBzbXQ6IEludGVycnVwdCBjb21tdW5pY2F0aW9uIGVu?=
 =?utf-8?Q?able?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAyLzE3XSBmaXJtd2FyZTog?=
 =?utf-8?Q?scmi:_smt:_Interrupt_communication_enable?=
Thread-Index: AQHbXasjFNU2xPM51EuHJGhVQiV3ULMIrgKAgACb/gCAAPGYAIAAbJvA
Date: Tue, 7 Jan 2025 03:24:15 +0000
Message-ID: <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
In-Reply-To: <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB9928:EE_
x-ms-office365-filtering-correlation-id: 8daebec0-bb4b-46ae-f6e3-08dd2ecac349
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?UTZ4V1V6Vy80QVEzZVErS0xIVmFEbTQ4T3g2NFdscTlFZWFZVFlEUWw1bWp1?=
 =?utf-8?B?cnBzNU5oWGEzcGpPdG9XMGhmU1Ard2IyZndlTUtlalFYVTJKaU0xdWpsNHlS?=
 =?utf-8?B?UVFIVkdXYjk2MzRxazRqNEZza2xjWjhQUmhZMnRmMmFMNWNob0tXSmxsZU55?=
 =?utf-8?B?cWJNSllaQzJiWmNwUEpvWjlLNE9jNTRhUGErVVFPSEhYaU1Mc1FqYzBDeVJK?=
 =?utf-8?B?aHh5KzZaTXR4Z2ptcHI3b09CTjFKa2pqcjVKWEZyWFE2cUJNbFJSdFVLVDEr?=
 =?utf-8?B?VmNjKzA3K2dNaW5iVDd6NGlqbnBiUUJTOGg1NGdObkRkZjhjSUNSaVNoY0Fw?=
 =?utf-8?B?eHBDSVlVNTVpa01qUXdJd1hLWVNjS2c1Qy9pRWhJbEFGUjY1Z0x3Z0U2NGYx?=
 =?utf-8?B?S0d6amdycEtaZE9ISVArZEVTQnVjTVVmTngzcXE4WngvbXRoYzlMRFRTc1Bz?=
 =?utf-8?B?TnppVWN1blJhVXRqYjVTcVljaDExNDBVNy9ZaDRFRlJQaGIrQWh3MEVITHJ4?=
 =?utf-8?B?aHRGMmpmampZZWtnTk5pQmMvcG50NnlBcFA2TFNXV01laTNvV1oyL1kzRDV5?=
 =?utf-8?B?RUVDQ0pNK0hKY1FuN1JURU1YRlBUQkVSQWkwbmFad1ZmV3dZSHlUYmoybTNa?=
 =?utf-8?B?OE9LUmFZS3IzUjZkM08wRFhuNmZjdjFZVy9WTXhOR1ZBeUJlVk9uOFRxOFQ1?=
 =?utf-8?B?eWN4UnI3NFg1VDBVc2NkK0pWM1cyczlENmcxNUdod1Y0anM0RS9XYkJJUnM1?=
 =?utf-8?B?Sm9KbFFCYjByL1AzR3hsSXRQVVdKbHNGcHdQOEVRdjBCU3dnZUgxZFphV0dC?=
 =?utf-8?B?RFhId0FIbzF0cHYyZ291YmxSaitSclhWWVl3MXZpakx5Wi9hQnZvRGNHclJ3?=
 =?utf-8?B?eTZVSExBbGYrdW9tT3RxRE5ocXJpQ0pkVmttTVlWZ1BTb2tYS0JtdTlPYzFo?=
 =?utf-8?B?MzNXR0lwZWppUnFwUEcxMEp4TFdGMHBEZ0o3d3JGamM1RU5pa1d6UTFEVFNY?=
 =?utf-8?B?aUEvYmc4S2praC9kTS9ORUoxMm9HcHRXYzJ2bGlIbWdUTXhRVGxXQjBTQ2s3?=
 =?utf-8?B?NzhqQ0grWnhOT1lEWFp0bGFLakdrZDhROXdXWExFOTBER1NyY2p1bVgxUER6?=
 =?utf-8?B?Q2tabzkwS0s2SjlGR3VQT2dyV2FwS3dRMmRnUkhPTzJWcWF6SmYvMFFGcU1i?=
 =?utf-8?B?ZFYxTktvUEJ5aXhGTVpuT2RoNFFOVDVxV09wVE9GcTlEL0dzaVZ0Vm5GbUZm?=
 =?utf-8?B?d1h2Sy94VnZ3ZU1IMWJwcW5CN2V2RDRacG5FNy9NaDBNNHl2dUhJMmQ2SmtF?=
 =?utf-8?B?QTRsTDJqcEozOCtoOEFSQjdPYVNsVmJzMWNmbU4vR2JhT29NNUdBbElvZUdw?=
 =?utf-8?B?WHNBZXlSVHgrcFpYWkNsZlhXZkdoM1JxZGVUNFZZWm5PVWpPUENZNWpkRDB1?=
 =?utf-8?B?NXdFRXl5dHR4VW5JYXoxajNBSXBDSFVIR040NncvTGVhMytqRFJQYlozM3Ay?=
 =?utf-8?B?QU56TktTYityVlBEaFhKbTY4ODFENmhkcWwzcTg0TWZkWFVLTWtZSXNzWkxN?=
 =?utf-8?B?Z2dRTUovd1lsOHFQZHlJSUFiMFhUdmtia1RsMUJHYmlZbjFPdlNNSVZpaDll?=
 =?utf-8?B?eUhwZWFzSmxZSVQySUh6cUYrdGc1bnBIVkRGemtMSmVVL0s2cHd2dlMwMHRW?=
 =?utf-8?B?dGJvSEVQVnduTHJ2OWJSV1pmYUVwMlpxV3kvSVBGTi9lNVdabks5UEpVQVcr?=
 =?utf-8?B?U2hteUM5akFsWFMyWk1sNzNPYldPQ0wxZG1lOEVibjYwU0xDN1BqbU1IQ0Nt?=
 =?utf-8?B?aEN4NzlJeFpxMlZJaGtmWVVHNmNBSjFvVFhXRnpnbjArZ01uRWZtSE5JdEMz?=
 =?utf-8?B?SmtCdzJ4VGJtcFEyZHlDZ1c0KzNmRy9CbWJMZkpMVlI2MFdHbXZmY2JRZVZv?=
 =?utf-8?B?UDNtM2UzbDU3d09wU25MbnYvSzRFYVE0ak9EOEJKS2hCQzRuMExFdXV3T3lS?=
 =?utf-8?B?VE8zTnRKOEZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnpqRG9RanVOdUtjL09ycjZjeHRVUjcwdVJIK0ZSb1UvQTRkRno3WkVKVWwz?=
 =?utf-8?B?L3FFOHM0ZGVRdXZuM2puNm9oYUJjZ0dRcDZKV2pVN2M4bmg5YWY4SGdNcGFr?=
 =?utf-8?B?RWRoc3F2TmUyVko4RmtHWWRFTWRJZjYzL09rRVZvRjRZVk5scDBzaGpwWldI?=
 =?utf-8?B?cGVGSDRxVXo1elo4a3paZWt1OFJ0SFdBVjBISnJXZUlFemVOV2VQdlU3SEtq?=
 =?utf-8?B?Q2hkS2xnV0R0aVNtRTlGam5YZG5tMUJCZmlBcUVmK29ZMDNBNHdhQnQ4S1Aw?=
 =?utf-8?B?ZHIrVGo1K05lNHdJaGplclkrRENFQjhDQS9KMWpUN0Y5bVBmSnNnNWhQS0Fu?=
 =?utf-8?B?bHRKT0VuUWRyUHArNWNiZWpLcTNCTHpyMStNT240YjBMNXFTWFMzYjVGVVpn?=
 =?utf-8?B?eUlOTkROS1pBMDh5R2p6am5IYytySWtIVTRpcmdweVhtZTNXcEVGWmJtQzlx?=
 =?utf-8?B?LzVhaTJYbmhTcnhmNy9neWNlS0x3M3NCUjZzMDc3bVMyelhXNXQ3c3B2dit6?=
 =?utf-8?B?MWJ2akpKYjZxNHZrcW1Vc1MxZ3JXbU83Um93bTg4OFo4UzhDYUZQYkR5RlNF?=
 =?utf-8?B?VUVoM1ZCd09UUFBkS3dXSW1ENnRRVzZWQmVZeGs1RkJ3ZFFDOVNXVW1Hc2tU?=
 =?utf-8?B?b3ZEUTVVMUhMQTBXb2Zhd2p5d2dPN0J2N1VuYUpOamd3SDhncDZrWGhWa2l0?=
 =?utf-8?B?dkZtYU5BRnVHRmdnY29YZHB3R2Y0TStNUEFZVXdqZHJMQ1gvZHRJRXNiUWJh?=
 =?utf-8?B?OHV5NmZBbk9hY2phckpabXJ6MnF1aUorYzJYRVVOOStnWWZEblg0R0lDVkF3?=
 =?utf-8?B?dGhvbmdsMjR2Skxnck1VQWhlbEhFS093aTQ0aWRPVXV4ek41alNEY2RhNDk2?=
 =?utf-8?B?Q214d1ZwMjhvQ1JReTE0YTB4TG1Hc2tlZDBHWHJDVUZ3V1pXRXUzN1JyTlFW?=
 =?utf-8?B?a2l4SUJONGpqVmRYd2tjZUhLbUxxaWRMWjNSdEduN2g0Z0ZsYmxxeVAyZFRr?=
 =?utf-8?B?Sk9CR3BuMmcydFBCT3h2TTZzbWdZK3F0WUY3bXFTY0lGTFlZUDFVNVVwMm1M?=
 =?utf-8?B?RlVoVERIMzFod25ISWdDc3BPc0NPV3VxWHlRSXNxcnVWL25ITnhYWURndVB0?=
 =?utf-8?B?UWFkMFFFK3RwbDVYOXA3WnBYMngxUDZoc3hCQmo2b3k3bW9VeTA1STVTeEJ5?=
 =?utf-8?B?cUhmR3p6MWFvZVpPYjA1eFp2VFNueHJxaVgyV2djOUMyK2t3UjVrblplNDNz?=
 =?utf-8?B?ZFkyYUZxTkM3N3IwNlNwK2grZit0a09qaWdQTVhvUHNGc3pPN284R1ZBZ0Iy?=
 =?utf-8?B?elZSZjlJZlhyUTUrVDJEZkZoc1BKMzZ1c0dwUDZKNHdjeVJIalh3ZlJNVjY0?=
 =?utf-8?B?MnFKVzZFSW5iK1dzNCtpLzVvcWtJQXNHMWI5aW1kb3VzYk1FTERZSEVpTU1J?=
 =?utf-8?B?Vk14YW9IaFVRbUZha1NyYW02UzBZVmpzMENWc3lDQUptejljY2laMW9rVHZq?=
 =?utf-8?B?YjZMTmtWdzE1MzU1VHpXQ3VoVnRseG9FbDRqWVhtK25NSmxVcWk1N3dZQTdh?=
 =?utf-8?B?V01GNEhiWDdkWVA3Q1d0V1p4NTVhdTJQaCtkd2QwekJHWjNNdHY0R3JqZlpE?=
 =?utf-8?B?Y1JqN3A4L2swSmIzc0NRZC9yckkrYmdMNTk4bHdDV2FkZUxnUGs3eEdwc1NI?=
 =?utf-8?B?VDQ1U3RjSXVQTTZ2eEhvWS9TMXU4c2ZIU0pHanNaeGxiL3hjaFI5MWRFdEpm?=
 =?utf-8?B?T0YzbUlXS1lTUmdFNVM4em5jK1lMUGV1MHZrak5DZmdZUUxac0JNQmdacmY1?=
 =?utf-8?B?TEYwNE9LYmk1ZmFOVkpmZUFCT2ZkeXVGdWtVVnZxUVB5ajVjVGZ1aGN5c3dw?=
 =?utf-8?B?T0lKdVBSTExIUVN6UGJIMmQ1cWlpRmViVzZ0R2FoakxaeGxzbUR5d0w3L01U?=
 =?utf-8?B?U3A0akl1WUJKaUk2VkhOYy84SmMvTCtSS09yVEJ0eDRzZjZ2NCtFVU9tTTZL?=
 =?utf-8?B?NTY1RlY1Y1VtM3lWckNFcEticnBJdCtueldsbjNVMlptUFIzdlZxaVNjS2p6?=
 =?utf-8?B?ZHVMQmtWUFBUcmdOaUZsNkJ3MXc4TVJQV3ZrbE9GdDNkeUxTd3h3c2pzY296?=
 =?utf-8?Q?8XWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daebec0-bb4b-46ae-f6e3-08dd2ecac349
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 03:24:15.0574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OszCMXtYcgdwntW7Oc5qNVteEpt8W06sEYsQ20Mf5IzNyJlikbtiijSXqEtsvKdN7vl97DF2XB5hl4zBgGJH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928
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

PiDkuLvpopg6IFJlOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDIvMTddIGZpcm13YXJl
OiBzY21pOiBzbXQ6IEludGVycnVwdA0KPiBjb21tdW5pY2F0aW9uIGVuYWJsZQ0KPiANCj4gT24g
MS82LzI1IDc6MTcgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPj4gT24gMS8zLzI1IDc6
NDUgQU0sIEFsaWNlIEd1byB3cm90ZToNCj4gPj4+IEZyb206IFZpb3JlbCBTdW1hbiA8dmlvcmVs
LnN1bWFuQG54cC5jb20+DQo+ID4+Pg0KPiA+Pj4gV2hlbiBpbnRlcnJ1cHQgZHJpdmVuIGNvbW11
bmljYXRpb24gaXMgc3VwcG9ydGVkDQo+ID4+DQo+ID4+IFUtQm9vdCBkb2VzIG5vdCB1c2UgaW50
ZXJydXB0cy4NCj4gPj4NCj4gPj4+ICwgdGhlIHRyYW5zcG9ydCBhbGxvd3MNCj4gPj4+IHRoZSBj
YWxsZXIgdG8gY2hvb3NlIGJldHdlZW4gaW50ZXJydXB0IGFuZCBwb2xsaW5nIGRyaXZlbg0KPiA+
Pj4gY29tbXVuaWNhdGlvbnMuIFRvIG1ha2UgdGhlIGNob2ljZSwgdGhlIGNoYW5uZWwgZmxhZ3Mg
YXJlIHVzZWQuDQo+ID4+PiBpLk1YOTUgdXNlcyBpbnRlcnJ1cHQgZHJpdmVuIGNvbW11bmljYXRp
b24gc28gdGhhdCBDaGFubmVsIGZsYWdzDQo+ID4+PiBzaG91bGQgYmUgc2V0IHRvIDEuDQo+ID4+
DQo+ID4+IEhvdyBkb2VzIHRoaXMgd29yayBpbiBVLUJvb3QsIHdoaWNoIGRvZXMgbm90IHVzZSBp
bnRlcnJ1cHRzID8NCj4gPg0KPiA+IEhpIE1hcmVrLA0KPiA+DQo+ID4gVGhlIGNsZWFyZXIgZXhw
bGFuYXRpb24gd2lsbCBiZSBhZGRlZCBpbiB0aGUgY29tbWl0IGxvZy4NCj4gPg0KPiA+IFRoaXMg
aXMgYmFzZWQgb24gQXJtwq4gU3lzdGVtIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQgSW50ZXJmYWNl
IFBsYXRmb3JtDQo+IERlc2lnbiBEb2N1bWVudCBWZXJzaW9uIDMuMiAoRG9jdW1lbnQgbnVtYmVy
OiBERU4wMDU2RSkgNS4xLjIuIFdoZW4NCj4gQml0WzBdIG9mIENoYW5uZWwgZmxhZ3MgaXMgMSwg
dGhlIFN5c3RlbSBNYW5hZ2VyIHJ1bnMgb24gTSBjb3JlIHdpbGwgdHJpZ2dlcg0KPiBnZW5lcmFs
LXB1cnBvc2UgaW50ZXJydXB0cyB0byBBIGNvcmUuIFUtQm9vdCBwb2xscyBHZW5lcmFsLXB1cnBv
c2UgU3RhdHVzIChHU1IpDQo+IHVudGlsIEdJUG4gaXMgc2V0Lg0KPiBJZiBVLUJvb3QgZG9lcyBw
b2xsaW5nLCB3aHkgZG9lcyB0aGlzIGJpdCBuZWVkIHRvIGJlIHNldCwgc2hvdWxkbid0IHRoZSBi
aXQgYmUNCj4gY2xlYXJlZCBpbnN0ZWFkID8NCg0KTXkgY29tbWl0IGxvZyBtYXkgaGF2ZSBjYXVz
ZWQgeW91ciBtaXN1bmRlcnN0YW5kaW5nLiBJZiB0aGUgYml0IGlzIG5vdCBzZXQsIHRoZSBTeXN0
ZW0gTWFuYWdlciB3aWxsIG5vdCByZXF1ZXN0IGRvb3JiZWxsIGludGVycnVwdC4gVGhlIGZvbGxv
d2luZyBpcyB0aGUgY29kZSBmcm9tIGlteC1zbToNCg0KICAgICAgICAgICAgaWYgKGNhbGxlZSkN
CiAgICAgICAgICAgIHsNCiAgICAgICAgICAgICAgICAvKiBHZW5lcmF0ZSBjb21wbGV0aW9uIGlu
dGVycnVwdCAqLw0KICAgICAgICAgICAgICAgIGlmICgoYnVmLT5jaGFubmVsRmxhZ3MgJiBTTVRf
Q09NUF9JTlQpICE9IDBVKQ0KICAgICAgICAgICAgICAgIHsNCiAgICAgICAgICAgICAgICAgICAg
c3RhdHVzID0gUlBDX1NNVF9Eb29yYmVsbFJpbmcoc210Q2hhbm5lbCk7DQogICAgICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgfQ0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
