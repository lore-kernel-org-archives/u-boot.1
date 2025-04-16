Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20891C369C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80F480FEC;
	Wed, 16 Apr 2025 15:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FPtCYBe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FFB82DF2; Wed, 16 Apr 2025 15:20:13 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B40880F03
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTli0VMDUeCyWtHG9tuOmpMplS3LZjtXeoQPZRvj5LsLqByDDH6oCHvj28M3huVk9VjSKOdwm0QtWGLGrqwL8KSPHIspuW3LjgfBC5BiLIyCQgWtqXvioSZxW0PdvSH0VKnJLVXDLIXM4gZSMhO/I2pxVLg0hAbAZbBJxE/pm7u/b77Bj/CK7peQ1rE2jFKFgb9rBqeRyt0+3IQrKEz2bgxhe/R3gcFeCihnsoegiu4eRYvX2hk/Ty+L/GsR5dVCFiTfklhHil3d9ghz3cKlh7+h6mEU8yUIM2BgIVsJCP1rpt7311pPyv0fUfA2RXZufcn5JyAY8aC7w4dVsOYgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwDwDi15cRUKFaPO8Hpnluzdy1CD4fWVN+O1loc2GkY=;
 b=bqGYxduaVD0mclsJOgl002Q7XZzJJoVx+oXlot0e8deSKj70ynbeqdKMVbebmEux8isY2NyvKq1dReA1mlDJJFmtVQFYiRDEdxg62jgqivIDtvi5/ZcfX+VTR1t0TOGr6Yp6H3YY2UOi78rON4ALJ0MDzfueymPwy3eOkXoSxKKdfyPnVu0u+0Fv82vmBP+5PbCNd+J5PoxBdCPX7HQNIsc+V3S/NS8dklXpY9Ih9/pMpJWehXvAvA1m5YiioB/HpYXL/4HTpJZNh2fxSae5m9X7YZ84SJaYkU1oszahsv/6YBO6zBTDVi//m/aWsqLatjZMPhePmcBAqKEj/rIWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwDwDi15cRUKFaPO8Hpnluzdy1CD4fWVN+O1loc2GkY=;
 b=FPtCYBe4r1TFh6x7XEFnwD+zCunCi3iPjReOHpKJ5sV32oqQO1sUIrQWC2isGqiJcjtrFo9SEsx8lD4XNgmEsk640ZRtJg/QlLVtpserezFuHgcoRQUaW5Wx3qGjA+KbkgraEOVfTYXO/LOhfOG3tHzHMps4AlheRbc3Ivoj0IT2zXQzWTaABg2wlSwCKT7NwBBSO2lQMxTIHgBv4n/YTr5GRIK2VeyxhtGI8C1gtrO7Dk60pO/SGeTJu1gyS9hzKW5eMggkMipg+nY5OlqYHV5bm5Wa80u8GKrgnUax1BcyH8gPXwzR9O4B+kUJAqTh792YWu3cQrPqV2NMRzJGyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PR3P195MB0697.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 13:20:09 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 13:20:09 +0000
Message-ID: <94f3bd98-5854-4f09-9927-54d83cd9adeb@phytec.de>
Date: Wed, 16 Apr 2025 16:20:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Neha Malcom Francis <n-francis@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
 <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com> <87o6wwv5ke.fsf@bootlin.com>
 <7f87c129-b949-493a-9df7-26e9caf9d58e@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <7f87c129-b949-493a-9df7-26e9caf9d58e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0243.eurprd07.prod.outlook.com
 (2603:10a6:802:58::46) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PR3P195MB0697:EE_
X-MS-Office365-Filtering-Correlation-Id: 93619ab1-e6f6-4af9-1d3d-08dd7ce96922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEdLNy9yb3J1QXkwOXBmclNyRDFoVGRHTHVVUjdUeTJwblVlTnl4VWVwcHhl?=
 =?utf-8?B?TDlqWHJHbE1WNnhKZis4em1rb2htTVVxellaOXBkLzArbzI1eTVjWDZBZDM0?=
 =?utf-8?B?Tk90eDhpYU9scHNkalF5bUVpVHJZTkNLRDlPOHZmbmVzeGNvZ0pSWktqYzNa?=
 =?utf-8?B?WnRENWZsbElpbi9iTmZHeXMwL2pISWFFS2lka0d5MHlYeDg5M3BZZEdvL3o1?=
 =?utf-8?B?eHZMbi9kYUFIaitnelZLS0ZSYTlDQTU1aFh1Nm5KdEpicm1abUpoZXFIaTJQ?=
 =?utf-8?B?QWV5dWcydnBlYmFNVG41OStNckxick1zWitTemlLRTBGMjk2N1F5aml0cGtl?=
 =?utf-8?B?WXcwaW9JdWxHdnRCZjNDeG1zaFRremNtSmFQejAra2xMZ3VMVC9BR21CVm9y?=
 =?utf-8?B?cG4wd3I0YlNVc2dVU3hLQmp0K3Z1MnlGNjAvMi9UakpIYnZpMDlxRExjaTFi?=
 =?utf-8?B?bURkQVQxU2ZaZy8wREVhLytTY0tTOVZwb1F2cmxDUkhSUFNrQnVab2I0Ulpq?=
 =?utf-8?B?T016eEExOFh0SE5adllsWHlVdEdLQU5XRmRGS2UrOTVQbGtscmpXNjdRTG1F?=
 =?utf-8?B?ajErUW94ZENuMUdNd2V1WVU2YzMwWjNxQm1iUmp2SzJzL2FXd2ZsSjgzVXRa?=
 =?utf-8?B?dWRvMUFxRnRkR2Z4aHpJb2QzNHRSOW5HYnlvM3JlQTIvMUxWQWJaYkZWbFcv?=
 =?utf-8?B?MW81dXRCRDVHNUllNk9BZnN0QjYzV0ZwdDRrdXU0VkNUUm42TTA1VmxBeG1X?=
 =?utf-8?B?ZTNxeE1hbzRtazBhdjRSL2lWSTRtUFRSSVZvWmtTclZqN09MV1g0N0o5U0hM?=
 =?utf-8?B?Y0NLb2pmaG5USktsK2RoVlFVV2RwZVdnbXVhbXJxWE45UEFPbEhZQmcvSHY3?=
 =?utf-8?B?RkdDWGExR2xnbHRiSWh0U3UvcnUxaGpnOGwrRHhOLzlHTXZxY1VsdkQrZ2Z1?=
 =?utf-8?B?WDRrRTBBVTBjK2phNDZLV3BHU0FRbnZyY2ZRQkVmeWE2SW1VRWt2Sk9RYXB3?=
 =?utf-8?B?bVRFZ1h6Mm1hQzB3aFo3SktKR3R2MDJMbHQ4N09EcHZPYWJUTDZteUYvZWJX?=
 =?utf-8?B?TmVWd05ER093VUh2bmpXTCtBa3BxRStvT3dUUXl2eW9LT3pqTC8rMW1lTTFv?=
 =?utf-8?B?ZXA0OG5oQXhSaFJqY2hGZ2Q0NHBlQm1Qc3dKSXQ3SFdBenVEaDYwM0pNU1g4?=
 =?utf-8?B?K0FSdEN2SC9UVUlFWVp0MkRodThPdDVXZ2pCU1VUcjVjZVlkd0ZObDJpNU5Q?=
 =?utf-8?B?OE5aWVZzRnZRemlacHVEU3VMVHkxeUJkYVI2Vks3SitMcnNQNWRLMjl1bCsy?=
 =?utf-8?B?MXg2RloyNWFMbjhVU2t1RGhZb0RHcHpqMEw4S0haUlJ6ejFZd0xrSGYvSkh1?=
 =?utf-8?B?a3NtaVRoWExiaDJEd01DK2poY2ROWFRqUGRQVmRIYmFWSHQ3K1FkcnFVVUN2?=
 =?utf-8?B?bnRpR2MyRVg2MGNHL3BWS0F5YTRIVmlkWlp6bUY5S2lhL21EMzVhTHBnR2g0?=
 =?utf-8?B?R2daYWY4N2lTQmJLRDJYUTBjb291YTMzWTc2T1MyTXQwaTJQRFlJTHJqOElQ?=
 =?utf-8?B?UHlhVUNTcXVHRk9zcDhKbTUxcFBTd0tvdWFSMFJhMEhnbUp4c3o4d1RzRjdI?=
 =?utf-8?B?MW9tYjA2MG1oTXkyYitaUWhjb3dTeWRvVXE1bzZLY2xVeHhJdjVkdG9PMnpn?=
 =?utf-8?B?ak5peU1yc2d2UnduajF5ZjNlSFJyVzhuRlJiVTErd0h4QVRTaVgvTjFnMUdC?=
 =?utf-8?B?T2JhNnJmNUtvblpTaU1NcTNrVVFsbWtNdTFvbW9vcUNmUkxieC9WekJBQ3FC?=
 =?utf-8?B?aDB1Y3VCbHo5TW1PcGFPNW9WT3BLRElQLzJFR2pCUmVLSTJLT1VYUHFHdW9u?=
 =?utf-8?B?ZWZCeEpBbGZOZEh3ZkljYVdWcEdtRVRwcXRMbURFVWQ3b2txWVJpKzBPbUxx?=
 =?utf-8?Q?wwgidEsjizY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xEMUNPQ0pQdmk5QWRiU0Z0eU1PMjdXNFkyQ3dUS1U5cjl0SzNuQUc3b3VD?=
 =?utf-8?B?T0ZFdzFKTlI2L0lMOStPMXQxak1oNmVNVXp2ekI1S0gwL01heXpSanZMY3Vn?=
 =?utf-8?B?YStCNC9oVVpZMzZqOHV0ZkFXUVQ3Zjc3bEhaNGVpTVFOOCs0YitDT1NYVjVj?=
 =?utf-8?B?bzh5TThBci9seFFqRFB2Q3FIUy9HRVpCcUE1R21BTysxRWNIRzVkR0E2MXJN?=
 =?utf-8?B?eWYxSW5RR2xUeW1WTXNBRDdKR2NWSS81VDhnZHJIYnlZOHdkZXlRamVVbmlU?=
 =?utf-8?B?R214SWliaEcxRXBFcGhRUlByWHdaYXl0RnN4dmtMSnFqM2FDbmYxL2F4L3FL?=
 =?utf-8?B?L3krN3JEMjJGc1ZEM3d6Q0xiUkZDbHhTVlk4YU8zRjJPeUR1TW42UVRKaERq?=
 =?utf-8?B?TnlqYXFMNVczQ3dLNWhxYzkzeGpPME9kRkMwaVF3VFh5NVhtamFDSXA1YUNj?=
 =?utf-8?B?NXRGaGZqdnJsdTlXZFVGVlFyZFhDSzdROUlpcFJuQ05NbVprc3piRzBKUm5O?=
 =?utf-8?B?NFIxNnpnalBqbGtyK3YvL2FrYk9qYW1kZnhqWi82Vjloa1BDL3JyeHhLdFlG?=
 =?utf-8?B?eFBYemtEUmxqaFBFSklIcFNYMTd2L0s1R0tFSnB5UnYxaURXMHNTcVZ5QXdq?=
 =?utf-8?B?RCtIcldKdGl1ODBETUNmV0FrNHRPK0FnQjd3a3RrZW92N3UwSlFaU3Nrcnkw?=
 =?utf-8?B?R3JGeWcxWGZQYmdWMkt6b2Y2eUxObEhPVXdjeEM4QzU5UjhxeXE2dndUZ0R2?=
 =?utf-8?B?TWxjRWo5czNad1hJcWkwcHpRRHFtazhHcG9mMjNOTytuMHZsU2tqNmRhVFJS?=
 =?utf-8?B?WmI1bHdaL3FReWNVSlpGMWlSalRYUFJHaWRNeWdONmZlQWhGcTJ2dUNGakhS?=
 =?utf-8?B?dHMvTENTejByQ0h5bnVadGtzQUhmNjZpYWZVejlXTGMzSkF4Q3o1YTRQRTVq?=
 =?utf-8?B?TXNlY0NaUTBYb1gxUmpKaU51OEYzckhWZ2YwNmlOMTBWTDMxNk02enhqOFBR?=
 =?utf-8?B?OVNEd1pLRXFFVkRYbEt5UWxoUG83UnFnYnJsUG9rZ2JsQThkZnljLytrcklI?=
 =?utf-8?B?WldKNzFtWkduMkNxVEh6SFpiMEQrNXlLMkZCNitUd2xLTXo4dzNsMVBoOGcz?=
 =?utf-8?B?aDZIUnFvUEF1dVdjNGdUdDdINHNneFlxU0x0eG51OXhjZThrdmtxRllpRE5B?=
 =?utf-8?B?NVF3QzM0MUJ2K3V3ZGRMb2I4THlpRC8vejNnUGR4a3lQZmZobURKcTFVSVYx?=
 =?utf-8?B?SHdJV0hkUUlSbkxYenFUMHJlcmNtTTU2b2ZqYktQN1cvcXcwazQrL2IwSURN?=
 =?utf-8?B?eVpXeGJmckFTNDZtaG5MZU5oTGFyQWI2dXpVWGhiTDJkTkV3eGYvVlBHblR6?=
 =?utf-8?B?b01ZcWhYL2xQc21qcjFINWZsQTlQbDc4RDl5YnZmOXhvTExuajRtYUp4T1Fn?=
 =?utf-8?B?YnlNOVMvTWxQUEZEb3ljZVZRa0grVzdTWGd4d2lLMzI0ZHlwRDl2SGRrL2F1?=
 =?utf-8?B?K1I4Z3NmVkpuN2IyTmFWQko3d01HdHd1OGw5azhmcUNBRURtdlRIMm45Umcr?=
 =?utf-8?B?RndHNVlXS3kranluekN0UW1wTHZaTDRCV21LSkxsTFhYTE1mUEQ0Y3d5RHFk?=
 =?utf-8?B?bHhVNzlhOEN3VUtGQUUwNXZXWkVwNXVNcXR4SDFYUTVXaHNCejZzeE1nYVQy?=
 =?utf-8?B?cEkvdTgxNVQ0WFlPQ3QrMktERi9KTjlQTENsdjZsa3NFaUtnNnpSUHNubnVo?=
 =?utf-8?B?azZMSkg4MlVDRzVsMithbng1UnprOVpHbVJrZmlYbTREcGlNeG90YUloS0V3?=
 =?utf-8?B?anJGWFZRN2FWZ1BWMnpqNVpueTNIall0d1BoTWZqT283d3kwK3RGNXY3NnlN?=
 =?utf-8?B?TDRQQk1nZWhmNW1KUlZzbmtTdEFhS0tUcWYxcEI1T3pwanZPMUN2M2tDN1dO?=
 =?utf-8?B?UmtTUFRpZUE2cVEzYzdXNncwUUFKODNmY1VsMmovZDlqVkpsM2g4MlZ6OEVR?=
 =?utf-8?B?OENWVDNqYlJXZXZQSEkyVHRvWENkdzM4UnNzSm9OSHRvbU1FazBvSGhiVmtw?=
 =?utf-8?B?RDF2bEljOE1EZE5paXJNWHl4OUU5d1FoN0djZ3dVWFZkTHBLNWpySnBpdVFB?=
 =?utf-8?Q?ZCWb+siAPl5R/oUSn1VpUNBDp?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 93619ab1-e6f6-4af9-1d3d-08dd7ce96922
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 13:20:09.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1oKw7bFvRTvbXg2pMOtLjiKrG88coTcLVlJuthCJyAivNwrdQktoLWwZeOheTbcUPOwOqvtXXIPM12YBYQOPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0697
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

Am 16.04.25 um 12:50 schrieb Neha Malcom Francis:
> Hi Miquel
> 
> On 16/04/25 14:36, Miquel Raynal wrote:
>> Hello,
>>
>>>>> -int power_domain_on(struct power_domain *power_domain)
>>>>> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>>>>>   {
>>>>> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>>>>>   	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
>>>>> +	int ret;
>>>>>   
>>>>>   	debug("%s(power_domain=%p)\n", __func__, power_domain);
>>>>>   
>>>>> -	return ops->on ? ops->on(power_domain) : 0;
>>>>> +	if (priv->on_count++ > 0)
>>>>> +		return -EALREADY;
>>>>
>>>> This change is broken for power domain providers with #power-domain-cells = <1>,
>>>> which can have multiple domains per provider device. There would need to be a
>>>> separate reference count per domain, and currently the uclass doesn't know the
>>>> range of valid domain IDs.
>>>
>>> I didn't see this reply earlier, would've saved some time debugging to
>>> come to the same conclusion :) but yes this is the reason for
>>> breaking.
>>
>> That's indeed the reason, thanks a lot for figuring this out. I am
>> looking for a solution. I can reproduce on imx8mp by enabling the two
>> LCD interfaces, as they have a similar pattern as on k3 platform: a
>> single power domain node and one cell for figuring out which PD to
>> enable.
>>
>> The uclass does not save any data, so I don't have an immediate fix to
>> propose. Let me dig a bit more into that and find a solution.
>>
> 
> Thanks!
> 
> Meanwhile, could we revert this patch to keep the platforms from breaking?

Would be nice, just took me the same route to pin this commit and find 
out about this discussion. I think more people will run into the same 
issue soon

> 
> 
>> Thanks,
>> Miquèl
> 

