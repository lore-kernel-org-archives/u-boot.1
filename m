Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883CFCCD192
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 09:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C2C8870D;
	Wed, 18 Sep 2024 11:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bFYXG/gy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 879A38890D; Wed, 18 Sep 2024 11:32:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1196188356
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 11:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwQAJpFFutzMAmZfnzL2fepAjo8eKcSHnijOqaU4RGqcuNgEqgh3PSMj2rEXyz5EDnlv2naJ9lVfaC9mXMnY8YP02JtUGla4kb+CP+LakOVHmhO6Gc8HTJfRSXUgAslTj+MyqIQhrhcC95BrsL2ALuS+37wNpAl0VpVwzMK8u/IrDk2unnrtsIHafvPRncZRPKMShyttDlAXsw9CPTTw9D4QKaYEew3xvkr8ZYAPgHoCMpVJTRlqBxc+HRUKTACgm61hh/zJixxCixeSGQyNjEHZmHZ1mgRNcaAxY26+8rMIhIfjx+4P68OgLQImhF075Bj/h+bM3bHtLf+HYTkHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+JPm1+zwY1JIBccu8+78WiBZEn/cJGK1Q8lUl/18b8=;
 b=uuyVteqhDB0TaZJvdwXV2jgA0hckRMKfPPJ8LJCixbrecudeb0W75Rj1JvrogQYPDzZCqiXlkgGTDTOQLEEUdJywzSvnD8PBsUOrkaXmz9f1wuxl6pH/QkWZ1rww5s44yx9a3+s5hJF7PlFN8LstaH6D/xbxxwfdAKfF8zqBCxcd0bhZFt8bwhfkHibqxVYrYPbvSHltOv1f3KNA3wiiqO/FEQk5g0nxdlBlCu3WgmiW85zY0fPpdB3WjBrsXVIKhaiX4qpg5FxUv/TH53kpEV2VlRUUb439sUavZy35fT5wxrzceIH3rim4dugcZw5hbfYV/hmPXAfHnwDt4oolEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+JPm1+zwY1JIBccu8+78WiBZEn/cJGK1Q8lUl/18b8=;
 b=bFYXG/gymbAMZCLIPbbBF5uA69XeDWFbqal1lxoJUV/k2edCzoSZUuCwFtbz2rzB4neyfvSHJEudLpmA0qY5Rhgm+arLaLqzx3iiaL+joDpPHL72GJXs/ESOf3whWq1vymeS5et6Gqy6MkVyMrfLpqzHcqnf8TMA6IHZqVYPsQc=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 09:32:07 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 09:32:07 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Tom Rini <trini@konsulko.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, Bhupesh Sharma <bhupesh.linux@gmail.com>
Subject: RE: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Thread-Topic: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Thread-Index: AQHbCampdh8P/00k5kqn1EG07sxpc7JdR8FA
Date: Wed, 18 Sep 2024 09:32:07 +0000
Message-ID: <SA1PR12MB869703AC7BDDEFD2BA5A5DDB98622@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
In-Reply-To: <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|BY5PR12MB4114:EE_
x-ms-office365-filtering-correlation-id: ef51807c-2183-4745-f40f-08dcd7c4c395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzZ6aUZPOUkyV1c4RVJ6ckVwM0FabDhvbkxrUzFRSDB4MlhrWlI4UjNCS3RW?=
 =?utf-8?B?RVlmT21qT2V6RCtsejhyYmxIajlqbUZ1TCtNUjdEMWJ1L0JScWp5MUZNYTl3?=
 =?utf-8?B?VnhMdEhkbnZpWExKN2hjYVV0dWZCbno2Yk1wVitqVjFWMTNRVXJIVWQ3YSto?=
 =?utf-8?B?MktkT3lkckI5ZktsQjRmTjd6MjNFdm82UVZQWVVZZy9Gb0d5cGRTZjc2M1Vt?=
 =?utf-8?B?cEdCOXpNVEJwR0RBUlBCWlpmMWpCMG5uUHU2STVDVkpKR1kxc0dWQUs2dTc4?=
 =?utf-8?B?TFA5cUtRRUV6SHlFVnhjRnpkZGViL28vbWtIU3FQSGdXQXRBMGw2dW5LdnEz?=
 =?utf-8?B?bUhHeHhDclFSS2Vmb1EwQzdKUFd3SjFodFRjaWZJY2Z6aHZmaVhCSllNNG5w?=
 =?utf-8?B?cHAzOUYvZU9UTzNROEZ4dlowQ2dHdEdhY0IvYVRaNlhPN2l2MzZkOUZMMklI?=
 =?utf-8?B?Q1RkNjBMdWVUQytib3FZNHY4YkliNEZMcHBPMzFpYTRCbWNYVVlEeVNncjdG?=
 =?utf-8?B?aHN4SzZZSTlQWVF6VUxQdm9zcWY5R3NsUVU3eXdPN0swcSt5Vzd5a1h3bUpk?=
 =?utf-8?B?Q2tvUzVpK3RCNU01eWJZU0ZEeWwvOFlNL3hRcGRod21rWDUrUVBneng5YmVp?=
 =?utf-8?B?QUtqV0lDTjZYOXVVNW9uNTE1Y1RhWUVFajA0SW93ckR2TThCaEV2MEM2SlRq?=
 =?utf-8?B?L2hOaW9hOXE2Z1RnRkJ3bDVMV2Z0a0hIL2VrMHBVMkc3VlZDcisrQ1lwTStm?=
 =?utf-8?B?Z1VpODVWaE9JaDlvai9WWVEwNGtGYWpBdWhKM1orZk1GYUtDWVFOUENHR3U0?=
 =?utf-8?B?dFU4ODdQR1lKS0lZR1lUWGJPWHd5ZnZZUzh1NHRlOUhoVkZNdk4ySmtyVjRH?=
 =?utf-8?B?UXo3MVZ1c2wwTzNXZEN3ZzQ0eHRiQ2ZEZ2xBbENwY0JJZkRydGsxQ04yUWxx?=
 =?utf-8?B?ZEdnak9CUEhZcVZBMFZRV2gwTUdvZ29HeDZYdldjaDR0Q2xyV0Z4Q1hueVdV?=
 =?utf-8?B?ank3MEs1dVFyeVFzTnJBbENOd2RTN3prMUxRWkpoM1RxcGMyNjFQK09IU0Nr?=
 =?utf-8?B?b3RFK2tDYS9VTUFLOVBYYVBYYVcxMlpKQ3ExWDlNdFY5YU94ZGp2aFdnaURl?=
 =?utf-8?B?ZVpRcU1XdGhRL1FXUlNtdmk3UDU0R3ZGZnVpTmVsclIwTThKTFJUeFlFcHhk?=
 =?utf-8?B?V1JRU3h5YzlCaEtBa1lnSWRlM01na3NQODNObHpIbXJCZVdGL1lSSHpiVkRt?=
 =?utf-8?B?ZHExTWNlSm9QSmV4Sm02WUxKdmhMTDVXNUZsaEpFZ1cxaHYrMktCWnJrVFQ0?=
 =?utf-8?B?ZVdad0lVZUtZQ3FCbHh4K05uUnRyT2Y1a2gzbW9vTncvQWhQZlZ1VWlGZTVD?=
 =?utf-8?B?a1JZMGo4L3h2cUg2aTlPaXlRZTZWb3hjNGs5MmY4dWNMZlB6UVBNTHpWNFR5?=
 =?utf-8?B?RGl3WXU3M0tYVWszVlZBN285dUQva3dIVlNVTzJna3J5bFM3bmY0UmRKSUFv?=
 =?utf-8?B?TXpaTVRWNnVTRmdrYVdhdFhEa2krbHlKTU4xRDJzOWQreVkrWFlmQU83YXFK?=
 =?utf-8?B?YnZLWkJGWml4UGU3bEZabTEvcjRYN3lGVGZwZXN2d3ptU043RUVPR3UyNUFT?=
 =?utf-8?B?TGtrVXdVelFJRzlJNW5mSzZqVzdVQnhoaHdkV0FKNnI1YzdjdmpUUWE5Z0tK?=
 =?utf-8?B?UWdJZ0pNcG1hWVJhTDdhUnBmU0JjSU1idFMwcVV5c09NVWhFTmZXUkFWZVV4?=
 =?utf-8?B?b3N2N3A4VXRDa0hHcGpnei83aFF1TWJQaHhsbDVOMGN6T3k5RXpucFBrQnNM?=
 =?utf-8?B?ekF0dGErUFo3ZExHWnlnaHF5RGVqTXI3aUlkVldXR1hOaUlhTmtEMGVVbjdu?=
 =?utf-8?B?Y1d4OUJpNEFJUGhwSWxoSEZRN0FrTjE3YmVEcHFtYjlQZHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JrTEcvbG1tQWpCcnJPS0F0WmwyU0tGTDh0bnBJbEdZL1Z6NHZ0K1pHZDAv?=
 =?utf-8?B?SDhvczlWWExsMVBqNEg5NlZMVFp3U1FBYjBKYkFpZkV0bzV5Y3VUcXRJQjBx?=
 =?utf-8?B?M0tmWDRnbmNFT1g0ZVA3cldmYllnQ01JcVgrR25vQWJVSFRrclRpUWdQWVNm?=
 =?utf-8?B?Nlp0YkswaktEME5VUndhQmw2bWVEZ0RBR3NVMXAzTmlUWmtCa1J1Znl4NGMx?=
 =?utf-8?B?WUllZGdlSzFsYVBBWEE4dG55M1VFL2w5Vk91dnRQdXhSMUc1bmhJbnkwL2J5?=
 =?utf-8?B?ZitZS042eERaNGdqZVB3dlNZeFZHVk5JRHkxOGpwRFY2Vm9WWXpiMDh4L0Fx?=
 =?utf-8?B?NzIwcmp4Q2w2ekpOT0ZKQzJrRE92QXlRY3VuTHYwbUwvWjJSV0dZSDFXMFBV?=
 =?utf-8?B?Ujg5Rkl2VUg1N1kvM3ZmUWdNbE9ZYi8xaTRJR1JocHpMSXlJc0JMY1lPSUFS?=
 =?utf-8?B?YS9JWFZ5czU1bmsxNGRrUnd5Z1RMTEVjQ2NmSlNRdkdMTDM0dHFkMlNVZTNC?=
 =?utf-8?B?bnQrZW1waTZwUzRUeXlBckErRmVLWUF0Wnh4RFhoRzg3ZkZCM1dKNjdkRFdj?=
 =?utf-8?B?U2ZEakU2dktnNElmanE1NGQ2NlZMUHpEL1luZ0Q2WUtUS1dNQUJrdVZnT01Q?=
 =?utf-8?B?WDlCNll6aUx2RmVBeUtwVGpTbHdoZ0k5Vk4wN3R3cHE0V1MyVzRUMHAwVTRP?=
 =?utf-8?B?MmlkV09TNkRDV0dDSEpEZ0NSUldjeG8yQ1ZhQTZDdHdrT0c5czJFc3lRbms2?=
 =?utf-8?B?bmRjWk5NSjhVVGFxUTlIM001THVveEtPSWJ5UkZPVHJQUTRIV3ViazNnZDc2?=
 =?utf-8?B?cUVHZ293NGVtcnZYTFhDT0RKQ280Sm8vR1NwUndaSHBCQTZQaEpLazdNbnp3?=
 =?utf-8?B?T1kyT253eDJocnBnMEtPNnRrYXY3bXZ4Zk1zSjA3c21sckt4UHdWSUU0K2Rj?=
 =?utf-8?B?UmVSSmRuTFZ4cGVERU5HWmRIOWFVS3BIbE1CWWIvKzBnTmoyT2FMSlNwMDBt?=
 =?utf-8?B?NWFvakFuT081cjVWT0hWMFJHNHZZOGR1TzB1MXZVV0tDMEdiblk4WitYWHhp?=
 =?utf-8?B?NnplTW1vUTFmTmVaT1VBRTVYaUFsQVFQQ2VqT2wvVEZlL2lLRHlpbG10Rk9k?=
 =?utf-8?B?WU8zVWhrQ3FqSHNqRWQrYVpWNGprVTZJKzlOTXBwS3Voc3JUbnpSK1pqdXVC?=
 =?utf-8?B?c3B0TXo0amluZlA3TkcxUWc4bE44MVBReWgwbW10aUVKYWluMFNUQm1UM0ZY?=
 =?utf-8?B?ZngzL3IzTzJmSU1iWDYrSkpnU1I0RnlzUFhCVU8vMkxaOWNsMmRlU1FLYmlj?=
 =?utf-8?B?c2pjRlZtZmJYdjl3NU9kZHdkUCtJMmdwbHN0Q0FzNXcwUkZkdDJhV1ZjWUlv?=
 =?utf-8?B?c2VHVDB1ZEMxYXBabEZLYWJKVWRuT29ERHR0R3plWWppSWI5QmZmRUY3NWhq?=
 =?utf-8?B?YTc4QjkzUS9ycWRvV3NiY3lsaG5SR20vRFhwUkI3aTJVYStHbVdxU2pJMUpR?=
 =?utf-8?B?c2QydGoxTk1tRk55T0Q1Z2R5N0RmU2RzeXJmNmhEclZrcHZRNFZPS01PZDNZ?=
 =?utf-8?B?WS90aDROd0l0YSswemMwU1pwZ0Zoak0vdmt1RkJzd3hPSWtLeUNNRk14Vlpx?=
 =?utf-8?B?a3kwTDYwSTllcXgvQXl3OFF6NFVSdGEwdkJBOUYzSkx3TXZtd1JjcWlIeHp2?=
 =?utf-8?B?L0NRTDRoRzNObysxNkFGUG9QN0wvRmR6c3lTcWYzaGVqTzZBRTBtODM0b1p6?=
 =?utf-8?B?dGowQWFXWExkaTE3MVl4MTI4SzBoUkZRY0x5WXBuWVU0L0R1RGlDaDZMMDhO?=
 =?utf-8?B?UVlIYWEzTjBDMlNoZWlXa3l0Zk9uUUhMMXU2NVBuWVAzSWtDc1BldDFDQ2Qx?=
 =?utf-8?B?TWl6UWxZNnpVQ2ZGRUg1TmpJWlc3aVZFNkVldE0vSEFKazNlQlBxaytEWkFJ?=
 =?utf-8?B?WWRVRkkvS0xHakdCc0lYbjZYQStLOGVYdGV3QS9xQ2pUQXpUOWtIWmM5MjNa?=
 =?utf-8?B?SXV1MVY3R05OREliUTVwTHZkekY2UXNFZEx1UzI5dTJEeEhtOWRsRTVTcjBs?=
 =?utf-8?B?Y3JBa2h4U3ljbDFsVk16ZjlWaElIQ0ZCNHE4WnZRejIxcjNWSE40aGZ0dGt1?=
 =?utf-8?Q?bKsk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef51807c-2183-4745-f40f-08dcd7c4c395
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 09:32:07.4466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9furbCTKXxjVlZUUU7b2z1M+9Ne7FJVlH0ELowYiooHWXayyq9Sv2BRsqdcj2Dy1vHPOmfr8QimpL5ixPdj9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAxOCwgMjAyNCAyOjMzIFBNDQo+IFRvOiBuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnOyBN
YXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47DQo+IE5laGEgTWFs
Y29tIEZyYW5jaXMgPG4tZnJhbmNpc0B0aS5jb20+OyBNYW5vcml0IENoYXdkaHJ5IDxtLQ0KPiBj
aGF3ZGhyeUB0aS5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgYm1lbmcuY25A
Z21haWwuY29tOw0KPiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1k
LmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB1LWJvb3QtcWNvbUBncm91cHMuaW87
IEJodXBlc2ggU2hhcm1hDQo+IDxiaHVwZXNoLmxpbnV4QGdtYWlsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwMC8xM10gdWZzOiBlbmhhbmNlbWVudHMgdG8gc3VwcG9ydCBRdWFsY29tbSBV
RlMNCj4gY29udHJvbGxlcnMNCj4gDQo+IEhpIE5laWwsDQo+IA0KPiBPbiA5LzE4LzI0IDEwOjA2
LCBOZWlsIEFybXN0cm9uZyB3cm90ZToNCj4gPiBIaSBNYXJlaywgTWFub3JpdCwgVG9tLCBNaWNo
YWwsDQo+ID4NCj4gPiBPbiAxMC8wOS8yMDI0IDExOjIwLCBOZWlsIEFybXN0cm9uZyB3cm90ZToN
Cj4gPj4gVGhpcyBzZXJpZSByZWdyb3VwcyBhbGwgdGhlIGZpeGVzIGFuZCBiYXNlIGVuaGFuY2Vt
ZW50cyByZXF1aXJlZCB0bw0KPiA+PiBzdXBwb3J0IHRoZSBRdWFsY29tbSBVRlMgY29udHJvbGxl
cnMgaW4gVS1Cb290Lg0KPiA+Pg0KPiA+PiBUaGlzIHN5bmNzIGhlYWRlcnMgJiBkZWZpbmVzIGZy
b20gTGludXgsIGFuZCBpbmNsdWRlcyAyIHNldCBvZiBmaXhlcw0KPiA+PiB0aGF0IHdlcmUgc2Vu
dCBzZXBhcmF0ZWx5Og0KPiA+PiAtIHVmczogY29yZTogcmVtb3ZlIGxpbmtfc3RhcnR1cF9hZ2Fp
biBsb2dpYw0KPiA+PiAtIHVmczogcHJvcGVybHkgZml4IGNhY2hlIG9wZXJhdGlvbnMNCj4gPj4N
Cj4gPj4gV2l0aG91dCB0aG9zZSAyIHNldHMsIFVGUyBjYW5ub3QgaW5pdGlhbGl6ZSBvbiBRdWFs
Y29tbSBjb250cm9sZXJzDQo+ID4+IHNpbmNlIHY1LCBhbmQgYSBudW1lcm91cyBvZiBDYWNoZSBp
c3N1ZXMgbWFrZXMgYW55IFVGUyBjb250cm9sbGVyDQo+ID4+IGZhaWwgdG8gaW5pdGlhbGl6ZS4N
Cj4gPj4NCj4gPj4gU2luY2UgVUZTIGNvcmUgaGFzbid0IGNoYW5nZWQgZm9yIGEgd2hpbGUsIGFu
ZCBzaW5jZSBVRlMgaXMgY29yZQ0KPiA+PiB0ZWNobm9sb2d5IGZvciB0aGUgUXVhbGNvbW0gU29D
cywgSSB2b2x1bnRlZXIgbWFpbnRhaW5pbmlnIHRoZSBVRlMNCj4gPj4gc3Vic3lzdGVtIGlmIEJo
dXBlc2ggJiBOZWhhIE1hbGNvbSBGcmFuY2lzIGFyZSBvayB3aXRoIHRoYXQuDQo+ID4NCj4gPiBD
b3VsZCB5b3UgcnVuIHRoaXMgc2VyaWUgb24gdGhlIHI4YTc3OWYwX3NwaWRlciwgajcyMXMyX2V2
bV9hNzIsDQo+ID4gajcyMWVfZXZtX2E3MiwgajcyMDBfZXZtX2E3MiwgYW1kX3ZlcnNhbDJfdmly
dCBhbmQgcWVtdS1yaXNjdiBhbmQgY2hlY2sgZm9yDQo+IHBvc3NpYmxlIHJlZ3Jlc3Npb25zID8N
Cj4gPg0KPiA+IEl0IHNlZW1zIHRoZSBvbmx5IHVzZXIgb2YgVUZTX1BDSSBpcyBxZW11LXJpc2N2
LCBpcyB0aGVyZSBvdGhlciB1c2VycyA/DQo+IA0KPiANCj4gR29vZCB0aW1pbmcuIFdlIGFyZSBj
bG9zZSB0byBzZW5kIHNvbWUgdXBkYXRlcyB0byBVRlMgd2hpY2ggd2UgcmVxdWlyZSB0byBnZXQN
Cj4gRFdDIHZlcnNpb24gdG8gd29yayBpbnNpZGUgVS1Cb290Lg0KPiANCj4gSG93IGZhciBhcmUg
dGhhdCBjb3JlIGNoYW5nZXMgZnJvbSBMaW51eD8gSSBzZWUgOS8xMyBpcyBzeW5jIHdpdGggTGlu
dXggYnV0IHdoZW4NCj4gdGhpcyBpcyBkb25lIHlvdSBzaG91bGQgYWxzbyBzYXkgd2hpY2ggTGlu
dXggdmVyc2lvbiB3YXMgdXNlZCBmb3Igc3luYy4NCj4gDQo+IEkgc2VlIHRoYXQgdGhlcmUgYXJl
IGRlZmluaXRlbHkgc29tZSBrZXJuZWwtZG9jIGlzc3Vlcw0KPiANCj4gQWxzbyBzL1UtYm9vdC9V
LUJvb3QvZw0KPiANCj4gVmVua2F0ZXNoOiBDYW4geW91IHBsZWFzZSBsb29rIGF0IHRoaXMgcGF0
Y2ggc2VyaWVzIGFuZCB2YWxpZGF0ZSBpdCBvbiBvdXIgcGxhdGZvcm0/DQo+IEFsc28gbWFrZSBz
ZW5zZSB0byBzZW5kIG91ciBjaGFuZ2VzIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZXkgd29uJ3QgYnJl
YWsgb3RoZXJzLg0KSSB3aWxsIHB1bGwgdGhlc2UgY2hhbmdlcyBhbmQgdHJ5IG9uIG91ciBwbGF0
Zm9ybS4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo=
