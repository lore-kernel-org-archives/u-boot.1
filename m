Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AE8CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419FD84A0F;
	Wed, 10 Jun 2026 03:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="UvLsRokJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945F5848BF; Tue,  9 Jun 2026 18:21:41 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d111::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63578466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MujQLwaxdXIetSpaz2lPBOeKhjQ8SfvfhLXPC79KaS5qszz14xNfo3vmTSc2yywctubGE4QSSEmvN1k1nyWCy90ztfHwX6acVcKcTL6m5BSJ9kjRPQ7ZCHWdOzukL4Whwre0pqk23v3nNIbI+GY0999HfZHpl/tdbJoXlI+0PGNKObRsj1h+Bz/1MHJUlE1lqI8qWtRR0rHH0c39eOwbFoJv7CiC3Xavh+04FIpJoibtMHsg4oDkmNrOV84RBsH+UIgTu6ERp+RLlxBg8+wAyNpbLCVFZMLXcw6ECbW3sY2jWI3cOuV9JmMq1oZkXJulG5TRDvLszZF6cfNjGox2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kf8ICRGGf7zPO4OMKOQnnZCEfZGGnM44DQtDyU0YTo=;
 b=EIhjFMCvLFezDjNL71gi2zqixs8yxlnV1mG6L4NGoyRfdDq1hUR593lBvAc4afz0qns/gOThctuxmYHABe3MXR77mwtB1niIiNrFfWRLja7JNPrDb7oDXdFk0O1HhsGQbHT+FuM0EIpagE2n4KUDlgXRykyWYCAsULeuq7IVkk9a/tChnHiyKyv7tB5vdsCcxeOe815O+AoTJqGVWuNyLRih3y5TfUPmIKxDSA+7bBmONLcLhB+kummf6jVWuSMVVtCy2ULV1zOXNObIZmxXVVVcvKcFyEdP/8e6vwdz414Fri1N5hXD6Va427v8bA1kGQeXDOTPcvH40rlLKRa6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Kf8ICRGGf7zPO4OMKOQnnZCEfZGGnM44DQtDyU0YTo=;
 b=UvLsRokJhMVMhfpdQ2ukrCyzidvQgSg6dJQRXe33Qc4MgKx0alkM617ad5A6jyAFhN+IRgotTHRzsNzc9xoiMgj2gWHhQIkZwdi3sfJ+oafxu3LM0yb7OlwFsPwCtMDjVWNZCGXOhwyvPTurncuyRnzGhcAlPFPg+kSV37MXWx8K4LTAXa10Zjcu4HL1ZwwssxKfeSw2pjRerctqH1rnRdmq6Jq1RhiK1bcowpG5MNKYYbE/UilntnV/Pih8ErY+GV849nL0Y9j6rZ53rx0Evcv+zoAcnXpK8cdfaO2AqvIRAoam0rFFuP5eEMc74mUOEsLgMiyfU2qnUN+cRBOqHA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CO1PR19MB5094.namprd19.prod.outlook.com
 (2603:10b6:303:da::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:21:33 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:21:33 +0000
Date: Tue, 9 Jun 2026 11:21:30 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, quentin.schulz@cherry.de, trini@konsulko.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH V3] board: rockchip: add Anbernic RG-DS
Message-ID: <PH0PR19MB99733839A63B1D53F6C6C07398A51D2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260510211713.68312-1-macroalpha82@gmail.com>
 <3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com>
X-ClientProxiedBy: DS7PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:8:2b::33) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aig9ikU2xloqkHFG@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CO1PR19MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a9e5bd-7603-4d7a-de39-08dec6432c03
X-MS-Exchange-SLBlob-MailProps: vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIk+u7tbzyIS/lqcteMPvwCiHV5i2Ue3mofYWHjwuzbq6cKL3GECqqL94FkNCZHaNLr9U3IFcSAaIdGB9xspZS1XC+50V5KhKeT+iJCZ63/8As0Acc2TNnew3dlLSVf9kPq3yZayc1JgLaSSeXfE/zbH7tZmOuSzGUdIh5lG6feWga8sHkCJGXJieZ3nvvI/Wr//VUvqLlsXyl6SatzQpsJuiA1g4FoqaeMPeeuh5ZS2jirSrzimkzXhnLC9zVJl4Te3DkqH3ZonhFmWhqjn4a1qCM/cTmdu1+m8aO1RYyKbLzKzIYil2ZvJGxw9aQIBm4iOy2JqdxXIXXJgU2Y0R/1zFPNH2/HXL0+d221JueHnbvX+c/O8uAubsPb0ObXAuUSp0UTF/KeblnQvOnYRHJ38XSyY5OCP/m3RlVl5CteJSQ+LebutxaH0KeFp3/373SiGw66rplovBqSFGvuYPihtkM1opCnRDYwmtdanfeljcLm6kOUhrPBmzo4q5DWJIyiLCO1nuC/cxe971SLII3lZLjcbAd7ENeT4RhkBVtR4g9M0JTEbhca2Yg/8L9F3IlURlNic4nx21hghX8wi6nc+FlGcIx3GhV7/pndgc+tRxWbUYBzsm7qM4gEc4kFaU2XQELhe2pqYssXbcGGIVw9oLDUTyudQi5mg92Mk/WP7eA3COyKXK42SghpI+s8pjh9iKzKSC4PXyFCe7RhCAWN3Vq8b1Vxf4ztzKz80uRScC5XM9KnPI8mBTNVYpLFAhDsVpTodwFw4DLEIWo4sX6GIQtyiTiBBuqS
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|37011999003|25031999004|24021099003|5072599009|8060799015|15080799012|19110799012|23021999003|40105399003|52005399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnJRVkNzcHRXbkNrU01jVXd3eUV6bUwxNXZlYUdZTUd0VXBQT3hWMDdSeTM2?=
 =?utf-8?B?VTRoNjZZWVJ0VHM4SGFUelZMenpiMHlDVVR2M0k4ZmdjMTV4Q2d2NWFTUzMv?=
 =?utf-8?B?blR5dHQwVVpFQmFxMm5rdDU1bFF6dW5jQVRFd0hqZ2JJNUFFU3NTZTR2dTVQ?=
 =?utf-8?B?N1BnOGdxQXUydUFZTllwNVRNbDltQ0pxOEdZYUljbXpkcG0zYUNRSUlwVCtx?=
 =?utf-8?B?ZHJMWTRBVEFQeFl2dndSM1hzcCtMeUgvU0tGNkNEdmRIWVA3bEZjbTZFcUxH?=
 =?utf-8?B?ZGcva05XT2UxTUVMbVU0Y0d1Y2svVHFmR2lTdHltVmdGbDdUanFUK0VlcFQw?=
 =?utf-8?B?NDVXSEczVEdOVHl3bmNtaGxXdjc5QndKMGdmMFUyUy80R2NPUnFPMkNrbzVH?=
 =?utf-8?B?bWJhbmJGcTRzTzRiTDljYVUwd0pwbXJ0K092VVJlWFBmZVVPZzU2RUFJTm92?=
 =?utf-8?B?WTg1dHFQV3hSejFxQ2JiSEIzd1ZGMVpvTnJJajZhQVVRUDVmMnpnQmM4d0N0?=
 =?utf-8?B?eGQyeTgwYlI5dkVqdGRjTFNEUlYvWEsvYWZzMHpjT2xSU3NuU2VhZ1A4VW5R?=
 =?utf-8?B?c295OHhjSkE4RFZWTk50NTZjcm1wTXFLOS96TjlmS3A4MTd3UUFkNlZyNWRv?=
 =?utf-8?B?d1lXQjRoQ3IxWnU3ckJhYjd4WmY2UEJSeWVDY29vdDdFYVVLUWxra3JBeTdT?=
 =?utf-8?B?eEQxZFJxZGQvUGtiWGJyNUZ6NDQ2dHRFNHVQTlMwazlnYUtKeWczclpZQ2ZT?=
 =?utf-8?B?NHZtN0xhMkVMNFQyRks3MGdiSVBaNno1ZXRRYTJJNWVyUUdmV0JPRmFFVHlP?=
 =?utf-8?B?ZUNOczdyaVBGY1dsNG81ZDJOZVJYMm1QdmxJUXU4ZzNQcURFbWlXbVlPLzBh?=
 =?utf-8?B?SmRlbkJPU05iWTFMRktCNE1qb2hwRnNmSm02UUhmZnZuNjV2NnpSSms1VkdK?=
 =?utf-8?B?czB4SlljVW5WSlNHcWJ6dFdxU0lTVHE0bnlqL0QweWszWGZlSFlxOXBQNTdt?=
 =?utf-8?B?U0QzSnNpSVRPeHZ6RmkrVXF6ZWk0Z0o0NHFzUXEyVEZEWUMzZFgxZlJnYXRD?=
 =?utf-8?B?UDdCNDllRWxKaWJ2WUNLcUZWbXl3VjZ0MGlBZ3BlemtKU2ZwbG05TEw1OUdD?=
 =?utf-8?B?TVBnUTY2T0pSdXZMeGcrUkd0MzdoWkRJRG5wN3VVTDhRM24vSnFMbVZZbkg2?=
 =?utf-8?B?cXF2K2cvRG80TDh6YjZXYy85aUkybW1MNHhTL0dua3NLRm5jbnFKUXdLa3I3?=
 =?utf-8?B?andoWndwMFhmeGFmc0RqelZwL2R6dS96ZDA5aGVxS09GVCtaaUFaMGtpNG1q?=
 =?utf-8?B?YlRibnRrL1dHQkorV0Fjbjlzd1FZdU9CR1J1T3luRkcrZ3pxLzNtZUZrc3NO?=
 =?utf-8?B?aXp1Z0pyMFpjcEJoeng4dVNQSzQxWVdGQUtvb0FYTzRKbW44MHpmM3kwOU1N?=
 =?utf-8?Q?7cB1h+EW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dQbEowN05OMVZCNHVjeThQQ1F4M1RBQW9hSTdBRTNFTjlEd1dYMG1ZLzZp?=
 =?utf-8?B?K1VmdmlEdUhvUzBBbW9SbnI4L252WTFkZ2pScFFhdWZxSHU3T015OHMrZjZY?=
 =?utf-8?B?TjZOYzlnWjliWmh5OWd2ditpT0VES2s3Tld2bG41L1REZE1KdlR1Rzd3Z3FL?=
 =?utf-8?B?c05NdHE0V2VsUWs0V2NtU1IwMzl0L2szRGNJUEpkSGVuVXI5S2pVdDRhYzlo?=
 =?utf-8?B?NDF1eXdRaC9TMUIvZkxKTGI4Q0w4M2taRFV5aEs3MTlrSTVMS1J4WWt4bzRV?=
 =?utf-8?B?VDZUQitweXk4U3N3U2V3R2tpdUl6UWVqZ25NZWxiOFc3akg2THRIOFlaNkNv?=
 =?utf-8?B?ZG9oRndkYitZVUp6aEJVWVhIWEdkUmxLUXR2eHNWTUdCRmNSV0FDVTBMa0tE?=
 =?utf-8?B?UGFMWTkwV3RpQVdTWUFWY0Z4emhadS9veURpbkJxTFpySXRJa0pEY0E2RHdF?=
 =?utf-8?B?TjZaUkgzaklnNEYwMy9raWtVTHkwUUtnd0hXbUVpTWlGcy80UHhxdGQ1OUVY?=
 =?utf-8?B?SVJJZlNWMzNMbWMyVk11N0xpdkFuRUtsUnp4ZExhL0lwVDU5RU94ckFpdnFm?=
 =?utf-8?B?Y3lBZXBvdlIwR0VpNmpRYzlEaDFxem9za3dLUHdiNjBNK3BOMHRiMThFMTVj?=
 =?utf-8?B?NlBLM2UwVFp0Si9KUWdra3dPNHdKSUFyU3RaK2NvOEJpQXgyN0szMUVmSTE0?=
 =?utf-8?B?cEt6VmVuNEpTVlFOV213SEhJT0JKS0FyYXBZKzQ1N0VMSzh0QzFrb0QwS01u?=
 =?utf-8?B?UzU0OXNCUHB4b1RNWUNOUExyOUVsSmYxa2VHN0VwbnEyMkIrOW9yQXM4LzJh?=
 =?utf-8?B?T1MxdCsrZmFseElNYUhxS3lQdzVyRlVTeFNCaWdGMTFoZW9zZjlBeVZXOTNx?=
 =?utf-8?B?eC9zOFYyM1Q0MnNqajRWNXZNdUFvcU8yT2kvQis5UnRKWXlVbDNNQ1BWM1VU?=
 =?utf-8?B?UWtXa1dkWlFiTFlRNWtpanBlL1krSE11cTJUZXlYSTNkVzVNUE9DNUlDT0cw?=
 =?utf-8?B?dkRKSFhEMnRNN3hhNWdGOVhmU2t1VndEOTk4TlllRTkrQnR1eGdjSE9UTHZv?=
 =?utf-8?B?UmwrNDR1VTAzclhTTFBzNy9CK21QdS9UZTIxZjR1Wm9GYXZac3FPb2hTMFNh?=
 =?utf-8?B?ZFFkVkxaaXV5bGhENVl0WlJNNjYvK09HZm10VWxtYVRmVFJWb1YycEM2Y3N2?=
 =?utf-8?B?RUpPT0xFMlNXTUZWekxqK0QrOGdRY2tPNHVnbC9FVjJVaHp2V1NDak5WS2xN?=
 =?utf-8?B?TGtWTHdGYTJuVXNEa0p3UEdMSnZBcHNScWU3YjAxYlVVcTZPaG95RHpWcktB?=
 =?utf-8?B?NVdVdG02MjY3UGJiaVdtbjE3a1ZnQ3dlMHZ2V0MrYy9Bb0VEelJ2c2wyNHpI?=
 =?utf-8?B?WHlOdWVxdm13OVBLZmJnWVlWNWpxNUIxdmNsbG1CZ0ozekQ3OHU5WEZTM01H?=
 =?utf-8?B?bVFFcnI4cEoyak9NSzJqTXBlK09GcUFHL0l0LzAvLzBDRE12ZGpXOU1yTXJy?=
 =?utf-8?B?d05WcWxjQ2JST2pEUmk0RXRNZEJrZyt3VWhiemxmdjczVHlLRjdJNk5FS0xF?=
 =?utf-8?B?ZkQ0NXMwb1JyQ1Y2Q2NZdjZQWDRMWlJmWkZWN2lzV0FmdGZEUW9RcVZvM0d6?=
 =?utf-8?B?TkVreEhHVFZOdklKTktiMTZ2MEVMNk9nNXRodU1UZUFlWkI5a3VNQUZCdGNu?=
 =?utf-8?B?Z3Y3L0FuNVpGTmUzRVp2NFVaV0djVmdmdmUvTmJiR1pMTjU3ZUlIR3gzejlY?=
 =?utf-8?B?akg1MHJTbzZwZVgyN3RpZGk5YmNZMUpFL05uUS9FODYyeWxyNWhoYmJFSzhV?=
 =?utf-8?B?MXBrbnh4cHY1UCs5ZzlqS0tNT3JKLzZvS0w2clBGWHJGcjh1R1gyaWlvV0xK?=
 =?utf-8?B?cG4xUGJsLyt2QWpPbm04UEUrOHlPTVoxSnltTk9meVZ6UlE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a9e5bd-7603-4d7a-de39-08dec6432c03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:21:33.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5094
X-Mailman-Approved-At: Wed, 10 Jun 2026 03:29:29 +0200
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

On Wed, Jun 10, 2026 at 12:18:07AM +0800, Kever Yang wrote:
> Hi Chris,
> 
> 
> > 2026年5月11日 05:17，Chris Morgan <macroalpha82@gmail.com> 写道：
> > 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> > 
> > Link: https://anbernic.com/products/rgds
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > Changes since V1:
> > - Added entry to doc/board/rockchip/rockchip.rst.
> > - Removed &sdhci and added &vccio_sd to u-boot device tree.
> > - Added rk3568 to board path.
> > - Corrected defconfig and include files in MAINTAINERS.
> > - Removed CONFIG_EFI_LOADER, CONFIG_LEGACY_IMAGE_FORMAT, and
> >   CONFIG_DISABLE_CONSOLE from defconfig.
> > Changes since V2:
> > - Removed "clock-names" from CONFIG_OF_SPL_REMOVE_PROPS as after
> >   testing it appears it's no longer needed.
> > - Changed include to use rk3568-u-boot.dtsi instead of
> >   rk356x-u-boot.dtsi.
> > - Changed from CONFIG_NO_NET=y to "#CONFIG_NET is not set".
> > ---
> > .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 +++++++++++
> > arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
> > board/anbernic/rg-ds_rk3568/Kconfig           | 12 +++
> > board/anbernic/rg-ds_rk3568/MAINTAINERS       |  7 ++
> > configs/anbernic-rg-ds-rk3568_defconfig       | 73 +++++++++++++++++++
> > doc/board/rockchip/rockchip.rst               |  1 +
> > include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
> > 7 files changed, 153 insertions(+)
> > create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
> > create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
> > create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
> > create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
> > 
> > diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..7944610827f
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "rk3568-u-boot.dtsi"
> > +
> > +&gpio0 {
> > + bootph-pre-ram;
> > +};
> > +
> > +&i2c0 {
> > + bootph-pre-ram;
> > +};
> > +
> > +&i2c0_xfer {
> > + bootph-pre-ram;
> > +};
> > +
> > +&i2s1m0_mclk {
> > + bootph-pre-ram;
> > +};
> > +
> > +&pmic_int_l {
> > + bootph-pre-ram;
> > +};
> > +
> > +&rk817 {
> > + regulators {
> > + bootph-pre-ram;
> > + };
> > +};
> > +
> > +&sdmmc_pwren_l {
> > + bootph-pre-ram;
> > +};
> > +
> > +&vcc3v3_sd {
> > + bootph-pre-ram;
> > +};
> > +
> > +&vccio_sd {
> > + bootph-pre-ram;
> > +};
> > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> > index 2730220a18e..ec22898137e 100644
> > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> > @@ -8,6 +8,12 @@ config TARGET_EVB_RK3568
> > help
> >  RK3568 EVB is a evaluation board for Rockchp RK3568.
> > 
> > +config TARGET_ANBERNIC_RG_DS_RK3568
> > + bool "Anbernic RG DS"
> > + help
> > +  Anbernic RG DS gaming device with Rockchip RK3568 and dual
> > +  displays.
> > +
> > config TARGET_ANBERNIC_RGXX3_RK3566
> > bool "Anbernic RGXX3"
> > help
> > @@ -71,6 +77,7 @@ config SYS_SOC
> > default "rk3568"
> > 
> > source "board/rockchip/evb_rk3568/Kconfig"
> > +source "board/anbernic/rg-ds_rk3568/Kconfig"
> > source "board/anbernic/rgxx3_rk3566/Kconfig"
> > source "board/hardkernel/odroid_m1/Kconfig"
> > source "board/hardkernel/odroid_m1s/Kconfig"
> > diff --git a/board/anbernic/rg-ds_rk3568/Kconfig b/board/anbernic/rg-ds_rk3568/Kconfig
> > new file mode 100644
> > index 00000000000..8676940651a
> > --- /dev/null
> > +++ b/board/anbernic/rg-ds_rk3568/Kconfig
> > @@ -0,0 +1,12 @@
> > +if TARGET_RG_DS_RK3568
> 
> This should be TARGET_ANBERNIC_RGXX3_RK3566 ?

No, sadly this board reuses an ADC value from the RGxx3 series so it
requires its own U-Boot. It may be possible to detect the CPU at
runtime and apply a different table (since this device is an RK3568
instead of an RK3566 like the rest), but I have not done that as of
this time.

Thank you,
Chris

> 
> Thanks,
> - Kever
> > +
> > +config SYS_BOARD
> > + default "rg-ds_rk3568"
> > +
> > +config SYS_VENDOR
> > + default "anbernic"
> > +
> > +config SYS_CONFIG_NAME
> > + default "anbernic-rg-ds-rk3568"
> > +
> > +endif
> > diff --git a/board/anbernic/rg-ds_rk3568/MAINTAINERS b/board/anbernic/rg-ds_rk3568/MAINTAINERS
> > new file mode 100644
> > index 00000000000..7b9b546f7bc
> > --- /dev/null
> > +++ b/board/anbernic/rg-ds_rk3568/MAINTAINERS
> > @@ -0,0 +1,7 @@
> > +ANBERNIC-RG-DS-RK3568
> > +M: Chris Morgan <macromorgan@hotmail.com>
> > +S: Maintained
> > +F: arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > +F: board/anbernic/rg-ds_rk3568
> > +F: configs/anbernic-rg-ds-rk3568_defconfig
> > +F: include/configs/anbernic-rg-ds-rk3568.h
> > diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
> > new file mode 100644
> > index 00000000000..399a216a7c9
> > --- /dev/null
> > +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> > @@ -0,0 +1,73 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_SPL_GPIO=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_ROCKCHIP_RK3568=y
> > +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_SPL_FIT_SIGNATURE=y
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_OF_STDOUT_VIA_ALIAS=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
> > +# CONFIG_CONSOLE_MUX is not set
> > +CONFIG_BOARD_TYPES=y
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_BOARD_RNG_SEED=y
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_POWER=y
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_PWM=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_MMC=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +# CONFIG_CMD_CLS is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> > +CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> > +# CONFIG_NET is not set
> > +CONFIG_SPL_DM_SEQ_ALIAS=y
> > +CONFIG_SPL_REGMAP=y
> > +CONFIG_SPL_SYSCON=y
> > +CONFIG_SPL_ADC=y
> > +CONFIG_SPL_CLK=y
> > +CONFIG_ROCKCHIP_GPIO=y
> > +CONFIG_SYS_I2C_ROCKCHIP=y
> > +CONFIG_MISC=y
> > +CONFIG_SUPPORT_EMMC_RPMB=y
> > +CONFIG_MMC_DW=y
> > +CONFIG_MMC_DW_ROCKCHIP=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_SPL_PINCTRL=y
> > +CONFIG_DM_PMIC=y
> > +CONFIG_DM_PMIC_FAN53555=y
> > +CONFIG_PMIC_RK8XX=y
> > +CONFIG_SPL_DM_REGULATOR=y
> > +CONFIG_SPL_DM_REGULATOR_FIXED=y
> > +CONFIG_REGULATOR_RK8XX=y
> > +CONFIG_PWM_ROCKCHIP=y
> > +CONFIG_SPL_RAM=y
> > +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > +CONFIG_BAUDRATE=1500000
> > +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> > +CONFIG_DEBUG_UART_SHIFT=2
> > +CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_SYSRESET=y
> > +CONFIG_REGEX=y
> > +# CONFIG_RSA is not set
> > +CONFIG_ERRNO_STR=y
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> > index 141071f528a..faccba4289b 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -126,6 +126,7 @@ List of mainline supported Rockchip boards:
> >      - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
> > 
> > * rk3568
> > +     - Anbernic RG-DS (anbernic-rg-ds-rk3568)
> >      - Rockchip Evb-RK3568 (evb-rk3568)
> >      - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
> >      - EmbedFire LubanCat 2 (lubancat-2-rk3568)
> > diff --git a/include/configs/anbernic-rg-ds-rk3568.h b/include/configs/anbernic-rg-ds-rk3568.h
> > new file mode 100644
> > index 00000000000..3c5bed952ef
> > --- /dev/null
> > +++ b/include/configs/anbernic-rg-ds-rk3568.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef __ANBERNIC_RG_DS_RK3568_H
> > +#define __ANBERNIC_RG_DS_RK3568_H
> > +
> > +#define ROCKCHIP_DEVICE_SETTINGS \
> > + "stdout=serial,vidconsole\0" \
> > + "stderr=serial,vidconsole\0"
> > +
> > +#include <configs/rk3568_common.h>
> > +
> > +#endif
> > -- 
> > 2.43.0
> > 
> > 
> > 
> 
