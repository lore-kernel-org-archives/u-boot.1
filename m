Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AD6C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0932E8827D;
	Thu, 16 May 2024 11:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="P8+zmRxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277C688293; Thu, 16 May 2024 11:50:18 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E13880DB
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbJydH8DvOqVlFHxUl8aRk5682NL0EIZR0llmcGa9SY4UIJVGyWgxFdQ6HavVS5QoD7wgyuRTRIzqpsAowTcxjVgaBodeoPNKiiIUR6WyCWx1OmZurCT6zKEhlLitYqI4bYxhji43yKaLvt0cvnpzRJfPXgy0/eotoqlrRQSl5huWMDXhD+Aac0Boz9QNF5dnVGqeVtC8s0M5TPKs8p8dhNbI6Z7QxV8VC/FZIsiuSQW15eRNh/5ffvKZo3Q7NBwWjcVGdXwHGzpl0jKcDsoZ4kGyLBjdBcrU6tD1ISoYqJsZpOspxwCG/T3stdwvYOdmntBjcIPd2mZ4MB+2SgNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG3Z4Tt/j7AENAm+mAqiPre3KjfWvuD0bXdCTJFAi5E=;
 b=GDlNSvmOFp9ykVzrPllUTt1KUKYjs30AEua3gavGA2VHv+ei9hB7Dul9qz+d4XAtS0K2NEBxaf1HF3x8ej3I3qdfZWeU2C53mutFqN5GLndLdxpG8xfsqsUIvuM+8UfkqPiGCH1GLu7K48PpoBycfuno4ZhFkz8UNKrj+d7+pF5XC0Xkm3cjK6U3m0XZ7kMC39gXQxKzRMZDP2eiPMxnBhrug+v3ZeoyFfN9XwR88dCX1kAFCrPVZB/a9I4HDCwIn7MimYwvWJ6fA3jNUze9K7uj2YhNPlYAddaN6B/5gaqrurC/iPL33reD27I1ouHdW9ckdZQjcb+chkb4ruxWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG3Z4Tt/j7AENAm+mAqiPre3KjfWvuD0bXdCTJFAi5E=;
 b=P8+zmRxQYIxa7/88ykjsO/FIAliT2vCI9byIOYwQIv85FXzlOdiz6IQ34wZCWH32KiVaHpVaBR0VDSzIvo0rSCnKehexEZ9C2ZrLI/YVd1mBU80HD9Ouzkb9LLUYheF/0zb/FIlx+Lc5NWFjV9FURtTmyYi5G4mlCaOWRg9/bN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 09:50:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 09:50:14 +0000
Message-ID: <aa29ae8a-ca23-4139-8d8b-e56ae0e6b8eb@prevas.dk>
Date: Thu, 16 May 2024 11:50:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Claudius Heine <ch@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 open list <u-boot@lists.denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
 <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
 <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
 <CAJ+vNU1NJOXELwyUJ_QW4m-QTdJZwSA9R8v3-1wzJK9K8PxEZw@mail.gmail.com>
 <ac57d92f-5f75-47fe-b2d5-5f633290b030@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <ac57d92f-5f75-47fe-b2d5-5f633290b030@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c866bc2-fbe4-45d5-4522-08dc758d95b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVpCNXFTbDh1S3FPcVB3NWFKeHpJcWp3UWFYa3FHR0IyYnpJN2tTcFpOWUNV?=
 =?utf-8?B?cVNvQ3VXSmN1ZWxwekt5MDQ4Yk05YWpwSmt6U2h0cFFJcDZIVDBqOWJ1Z25q?=
 =?utf-8?B?VjVjbFovaXRUK3R5MjdVUndoVjYyR3V2VUpyc3dYeGUrZG9LUVRzeGhiSnc0?=
 =?utf-8?B?MjZNc3JtcEd3VWI1aUJUV3gvaCtrRUkrTVlDc2VJdU00UEt4d212bU15M0U5?=
 =?utf-8?B?V3d4WHBGRWJuaXBaZm1oQXZseGowWlY3bSs5S1R3OXZ2SzdtV2Q4QzZlRnlM?=
 =?utf-8?B?eEFEczBNMkpUZENpMFhLZjNOamVvbW9oc3k4cHNIQjBNWlRIbG9aT1psMXRH?=
 =?utf-8?B?VW1laG5reTVsOUVUOVlkMSttMGtKaE0za1QreWtzV1FWM0gzL0dBeHdvUG8w?=
 =?utf-8?B?aERYcjRuYUFhaUIzaCtFRlc0dDRVZWM2c1A5Z2cxS3lnbk9CL0gyZ2M5cEUv?=
 =?utf-8?B?QWZCd2VPRmUvYS9VSFBSbjduZ3RVdEkrSjczYkZKTDFLQUhOMDhoVCtBbjk5?=
 =?utf-8?B?eWU5ZEt1b053S0orNjdMcm5lSHhYZU01VFRFL0x3Z0M1OElXUEsxOXRlL3BB?=
 =?utf-8?B?aGZOR0VpcTV3eUFWOHpUYWdQT2ZVeHpjN25mWmRDbEZ1bEtITktKbmR6M085?=
 =?utf-8?B?YURNMit1dVhjbSt5N2o0b0Nkb1k2RFhQS29ZeUJINDhFSTRGdCs3VUsya3l4?=
 =?utf-8?B?NC9MY0pDQWxEUnBWb2FhK3REM29qYjB1ZnFLSG1FbmpOMEdpYkw5dmZkT1ZQ?=
 =?utf-8?B?VlQ1L0NVM2xSV2g0VERHREJpMGVXbXE2NzlLSWRyT0FadXBQNDVvMXdVYkpx?=
 =?utf-8?B?U0pnYW5YNzVzTGtkS085dGNHay94ckVCd3FodGwyS1kvK01vRWRYRld6TzBB?=
 =?utf-8?B?VXpDaHI2eHlGK08zRHd3QWRiUHlUcDdDRzh5R3l6RENlZk9RcFRwN1p1dXVr?=
 =?utf-8?B?TUxjTksyc0xLeGxzcXFvcFNzd0xxK1I2Y25VSUZzUjM2dEY3b29PQ0o3Lzl4?=
 =?utf-8?B?VU1IaEdBQ1VuZFJjRmg4NlNCM0Z2K25RZmwyejdvK1RWRSs0Nks1UFliVzU3?=
 =?utf-8?B?dEQza1dlMjViaUV2MFJiRGdmbkhjdFZsQ1NKbGw1S1VOc2lDSWh1OS9YSTVL?=
 =?utf-8?B?M3FRcHpKQkU1YmFSVTZqRFJCMFEzSDZ1d2cwbHVlNzJKTXpnVkIyVkJZdGJV?=
 =?utf-8?B?eHZmS01OZDBGWDc1OUtTNzFTMG9Bb29kWUdNLzYzU2JkMjVuR1JqMzVZK0dk?=
 =?utf-8?B?eTZkeHo5bHo5Q3R5ZWFidWZGY3dmSHgybXVWVjVhTzlZaTNuajRrbzlkaXQv?=
 =?utf-8?B?RE9YbnhPZTJDc3lYV00vMnp3UTFZQXdibGVZdlYrWW53cHkxRlcvdGloQ0NZ?=
 =?utf-8?B?eTdhZVk5am1yY1FjZVdGTlgyNjlUalNMekFCOGpabitPRWIwQnlTRFc4Y2k1?=
 =?utf-8?B?UHlOcDZRSlcxYnhOcVF2RXFRN1VkMWgvaGtZell6RVRIZXg3a01wTkJBbjB4?=
 =?utf-8?B?eDg2akRZQTJBQVozYUR6c3pUcGNPSENLQmc3ZW1oZ0ZCL3A2dkRhTWQ2N1U0?=
 =?utf-8?B?dzVmcG5zcmZFSURDVEdHUG5Relo1RFl0cTV5dVNSd2loTWxPNERicXMwamNr?=
 =?utf-8?B?Q3J3cjFGck9TdG10WGV2QnBSSi9DREFlZUNYa2FqMHkxMkg0b0UrSUljLzdU?=
 =?utf-8?B?TDR6QWhtYlpTcHNqaTJHUmVaYzN0WE8za0NMY1Y3TFVuYnJFWkhDdG9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3AvUWpZUHFWOVhQVEVVNHFaOXdpY1JOUUprbHhMaTZ0V0tCaFlRaCtIQ2NW?=
 =?utf-8?B?Vmg1dE9yaEdjRTZJeHVtbFY3RWpSd05wTXZvNDRISnFOVWhvaFhJOWNKaWo1?=
 =?utf-8?B?Ym1jY284OHlmVFBjSE9JTytvdnlBZGlwcW5UbUZhRVJzTytYSTlCam4rQ2ZM?=
 =?utf-8?B?VWdWUVdHbEE1VGlHUXY2cTByWTVlRU1UcUgvWWZ4Rm9Xamt3R3cyMXYxc2dm?=
 =?utf-8?B?Y05jWEJzS2FCdlE1MkllZldNYVJmN2V6S3ZqbnhYWVFLSEZqTmRZNnhYaEo5?=
 =?utf-8?B?b2ZFNXludGNuTVpwd005M29ielZFY1A4aVhHNERkUnhVU0pPeFNsZDlDRG1n?=
 =?utf-8?B?ZG5FY0RMUE5Yb3ZyVTl4dDFTcWwxNHlkQ0lETWFtcThldDR1WXFPM2FPYUt0?=
 =?utf-8?B?dStnaU5HaTV6OUx5TVZwdVkvVVluVDRRSk1wempPMGJsSUhHSUp5RHc0WUly?=
 =?utf-8?B?R2diclh5UmxTZjcxN0RTTzNwZitJbytKVXhCTlZleUxEejF0a1dYZ010Q0V4?=
 =?utf-8?B?b0dPMHR5VDJ4bExSUVR2UUIyakFpSzBjaFhpckFPRXNReFhpdTZxdjlUMlU4?=
 =?utf-8?B?SWxWVHF3bGVHb1lXU2FpdnpQVUhSOGlRVXJYcGhhQ2VwRTl6S0tiL0lxc0lQ?=
 =?utf-8?B?ajVrVlJNTGxMTWpPdVVQM1ZpSUdjK1pQbTRJZW9oRzhGYXBhbGNwSm1WUmwy?=
 =?utf-8?B?azF0N281bGFyUHZ2bXlQRHRDazFhekRxQ0ZEQ0VZc3MxemJYdndFSUZvTnFO?=
 =?utf-8?B?MmxXSjEyWXhLQVY2enkwUlVaWlNwU3FuY3lqaVMyU0JhdlVQckgxSnB6TGda?=
 =?utf-8?B?TjZpU3BnZU1HNGlxa2NuaUlUTDZHWW0vM3NwZzVORUJ2NndFbUo2ZXBqWVhk?=
 =?utf-8?B?TzMxWTMwa3pndi9OT3lTblhNZUZOS1NSWndxZG13NzVmbEJXYVFXcWVNTHFD?=
 =?utf-8?B?WWpBSUl4NVVHeXBETVVvR3RLQnIyU25UU0RWNWNiWmFPRjF2ZUtPTjlValk3?=
 =?utf-8?B?Y21vcEpVZVBnUm9TaWI1Z3dnaGdVdGNROGY1ajAvZDhHUXZXVi9LVU5UaUxu?=
 =?utf-8?B?RXBDTW9nSG9tRy8xWEc3OFJvMlpZL21DSmRRbWJSTWFOYlJJNWRtNFljajUw?=
 =?utf-8?B?TGtVU05GNk4zYlM3Y2lSZFhVNS85SXdPd2VsR1ZQMGJ5RnlMZ2I5cEtpc1hT?=
 =?utf-8?B?MmhXekhCWDJSUVprQ0o4ZjEvZnloZGk0dE5kWHVYZjVSYVI2am1IMzRHUHBG?=
 =?utf-8?B?YzJGYXJ1VW9OcFB5cWh6SGh4TVp3YnNReEFGUmFWMVFPNWRDTTdZV0lXRUhC?=
 =?utf-8?B?YzhtelNBdkcxK0R3MFVJSnpCZmdWUFlIb0ZaRVJZQ0ZsdzdEejhENkxqalo1?=
 =?utf-8?B?Zzd0cGJGTlRXYXVMTHMweGZGZnpwRzdMNk1vNWdySXhQWUJuL2xoQkxXSUFP?=
 =?utf-8?B?d0pWYlUrWHZteWl4NVVKbFFwYm8zRktNeERrK290d0hnWWlXTUROMXh0SDF2?=
 =?utf-8?B?OUVUY01iMndCaTVpVStkUDZ1WlhGUUZDdUhnVE93UmhhVDJLWkdKVXNHc3Zz?=
 =?utf-8?B?SFIvdVdaOWRBWTNTbUhqL2RMR0liWVFHVWk1aEM3bnJLV3k0QXc2WjUydkp6?=
 =?utf-8?B?cnJVbUs1RjJhSE00SlNKTkdYNkpPTFcxVzB1N0g4YUIyK3ZqSytUOWFXdE8y?=
 =?utf-8?B?Qm1pOEFlM0FHZEVmeDhJUkNpMzlpcDQ5YU94RXV5OXBoNitpNjV4UHI5NGVW?=
 =?utf-8?B?US92WEdWQjc5SklUdDIwc0trOEU2bnBScWRJSEloMzJhamN4OUlOdEEzWVQ2?=
 =?utf-8?B?emY1QnNOTGRnekc5OHpYd0hRdlNrdXZmTmZ0S08yV2hRUFhMR05SZStBbU5D?=
 =?utf-8?B?QXlVNWVSbklUOEMxNlBSUE5KTzlHcTAzSElwWE11V0NWRVFUcnJZaCt1dDI4?=
 =?utf-8?B?RmNPcU9tN21yeXFZM1prSXBNRGN2MzM0N3grWmM4Zk93aHN6U0Q0MjZmUWdK?=
 =?utf-8?B?aDZYSTRnZzYvaUc5T1dKc2tEekRieURYUnJJNFlQcFZNQkRHbVZWbU55V1ZT?=
 =?utf-8?B?YkRoUmo1MXZ4Qmg4czRRSDBzMnZSNzRZTHVFTTN3cFJhUkNEeUNhU0tkcitp?=
 =?utf-8?B?eVBBaU9MODZJcVlsL1RtMEl5dks0RVdJNzJSUUpZRkNSd1AzbGRlTzFTS1Va?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c866bc2-fbe4-45d5-4522-08dc758d95b5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:50:14.3508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtK2bddrK/3zeg409ecy0y7VRtdB89KFKDB8vU5dd0eNn1fj0MwSKlxQtpS8EpC3kNqBXtx2uG/b5zhc4VjkKbqgPO5mpZ/RVIhONDbSdHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8322
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

On 16/05/2024 10.25, Claudius Heine wrote:
> Hi Tim and Marek,
> 
> On 2024-05-16 12:46 am, Tim Harvey wrote:
>> On Tue, May 14, 2024 at 11:50 AM Tim Harvey <tharvey@gateworks.com>
>> wrote:
>>> On Sun, May 12, 2024 at 10:08 PM Marek Vasut <marex@denx.de> wrote:
>>>> On 5/8/24 9:23 AM, Claudius Heine wrote:
>>>>> On 2024-05-07 3:28 pm, Marek Vasut wrote:
>>>>>> It would be good to mention the DT properties which govern the crypto
>>>>>> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt --
>>>>>> somewhere
>>>>>> around this sentence.
>>>>>
>>>>> This is something that should be documented with the changes where
>>>>> that
>>>>> code was added, IMO. I only documented here what I found out and have
>>>>> used myself, I haven't used those.
>>>>>
>>>>> I would be interested in reading how to best overwrite those paths and
>>>>> the image structured from board u-boot.dtsi files myself.
>>>>>
>>>>> If you want to can pickup my patch and integrate it into your
>>>>> series and
>>>>> extend it.
>>>>
>>>> I'll keep it in mind for V3.
>>
>> Hi Marek,
>>
>> The documentation patch here by Claudius does resolve my issues
>> discussed in the other thread and I can confirm symlinks work fine so
>> I think something like the following should be added:
>>
>> CST_DIR=/usr/src/cst-3.3.2/
>> ln -s $CST_DIR/crts .
>> ln -s $CST_DIR/keys .
> 
> `keys` and `crts` are very short and generic names, and putting them
> into the build directory might cause issues at some point. But I would
> not be against putting them into a sub directory (`imx-hab/{keys,crts}`?).

It is probably useful to be aware of the quality of the cst code. For
reference, I quote get_key_file()

int32_t get_key_file(const char* cert_file, char* key_file)
{
    /* Algorithm to locate key file from given cert file  */
    /* for now just assume the key to present in the      */
    /* same folder as cert file. The crt in the name will */
    /* will be replaced with key */
    char * folder;
    int32_t i = strlen(cert_file);  /**< Index into key filename,
initialized
                                         to filename length */

    strcpy(key_file, cert_file);
    key_file[i] = 0;

    key_file[i-5] = 'y';
    key_file[i-6] = 'e';
    key_file[i-7] = 'k';

    /* Search for folder name "certs" in the file and replace it with
"keys" */
    /* Keys are found in "keys" folder and certs are in "certs" folder
    */

    folder = strstr(key_file, "crts");
    if(folder)
    {
        folder[0] = 'k';
        folder[1] = 'e';
        folder[2] = 'y';
        folder[3] = 's';
    }
    return CAL_SUCCESS;
}

Ignoring the inconsistencies in the comments, obviously there are a lot
of implicit assumptions on file names and paths. First, the assumption
that the filename of they key corresponding to the certificate can be
obtained by replacing [-7:-5] by "key". Second, and much more egregious,
is the use of strstr() on key_file searching for "crts", and just
blindly replacing the first such with "keys", and ignoring it if not
found. So if that string appears anywhere in the path (say, my homedir
is /home/dcrts/ and I have the key material somewhere below that) this
will replace the wrong occurrence (and look in /home/dkeys/ ....).

And of course it was unthinkable that this could have been written using
the much shorter memcpy(..., "keys", 4) so that one could actually `git
grep 'keys'` and figure out what was going on.

Rasmus

