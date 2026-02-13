Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF678EDF170
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FDF183015;
	Fri, 13 Feb 2026 16:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hQ+g1dGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A5683AA9; Fri, 13 Feb 2026 16:15:15 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD63382A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh1Jj6MkpTFSmTikigMZFa4ZxKHchHsXGqk6z5xIzTETG71HjtsWaQ10dhyI7foCHmt/WTa/4mtytz1o4SWnXiGGk5QWXYaVjtjkP09mVyVSiOKdkHOr5quxkmJlMMam8C44wPehnXy8m1/j954PwYDQRglAikcVQa/wDlXcPnb6tQapCoTWa+sDaq1X1U+XyXoIdEVECNuLuD5C7NxHZr2Bch3/WnO7gIT6Vtq39J90xRqQlu4KyYd01b7DLPSVyBkqH71eOd8Rw2z0TIVRZFNadwTxRSnhelZcmiVc3l4O3n6OWprxPWHHnoGzpiL1uTDkiTYyYctHIbSnW+eXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeltkqOslUBYtIFYN2qctgXptWbMHaSKPnm8B24JWCQ=;
 b=nFQZQQq5Ot4y2PbJdBcX/dE8rs7/80A08eK5Dv+nZRBdCHWoX0XNPuXM2mRyegEjWGQCmyo0y+mjr6jCvM49PsWDyCkpbs8ycApn+0gA+GgkuCB1GEYtZ2n4diAsFEW6tqyMSrKhjJGSBrEvcZlbRAWr1zrr8usffA4CD8ItpIee7gerSrXd84DtSQ4ysddqrWFRBnQabwgV9xt5YOBMw5FhRtLtrOLf/iPt8ayjURssHlRs2v5FviT6HwT0iew9fG4DEHaEusd/d9N9+fNyZG4yb+U2PjmX96xtxfewbVWczTy0ElOywrtfWqegJqPqVpEfikw9aMiseB70fYsqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeltkqOslUBYtIFYN2qctgXptWbMHaSKPnm8B24JWCQ=;
 b=hQ+g1dGADDigwpJyJvof9d6e4VbgtoL6msyRmTajtnEVDe8/EEgGjpZNzY1kCOwERrd/zOlH8EAoQpBcfGk0s2UTiO4JREo82FekUK65Cif2IP3odzwjh9NIRKt4atiBufPcrb21tKA5Dl6sdBWvTE/qprEEUYOIkEGn0rwDHHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:15:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:15:10 +0000
Message-ID: <adf6fccd-e97d-41ab-8ffc-611e330a53d7@cherry.de>
Date: Fri, 13 Feb 2026 16:13:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] rockchip: board: qnap-ts433: drop DW_MMC config
 options
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0285.eurprd07.prod.outlook.com
 (2603:10a6:800:130::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: de51df6c-3caa-467e-b9dc-08de6b12ae09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtINW8yRUN2amNlTWgybnpyb3RJZGpEMDZYREprdE9CUjdaN1BxbzZLWmZn?=
 =?utf-8?B?NytTZ0VkR2VWQktSVUlZNDhXZFdPQVhxMHNZYXFuZFB4eW42UXpVNFJsZHV3?=
 =?utf-8?B?aUdWSmN3RHhoWUlmWDd3TEwvZzUrTGpjNnNYZmxJVEZOLzNYU0o5ZCtkVmVa?=
 =?utf-8?B?c2pkSFNvWlJUM2dGbjI5MFE3TVhWY1UwYktibHpaVGF6Q0c3M1R1Wk15eTRZ?=
 =?utf-8?B?YWNnU3JzaDNlcVd5N0ZkOU1kNHhNYjBPcUtVcnhvKzloQUIvVGZNeDRUWnRR?=
 =?utf-8?B?Nkc5UXc2dkFYM2o1T1BKZDdjRXVndFprYlRqWTB4Tk9YcWQ1cE9vUTlOOERq?=
 =?utf-8?B?M2hod3ZjbXMzZDZMS0lJdEo0S29iZG5XeU5ldjFtV3pLeG5MQ3VMYUZBMG5v?=
 =?utf-8?B?a05aSTZmRXBDMUpxanVCSmp3aEVEb1FWR1ZlNVpqcVlrOHB3RlQ5V1lqaHNY?=
 =?utf-8?B?L2w0WFovY2dQTzMwN0hvQzBpanNWWklyMTBjWDlLdi9NK0hIb01GbXArb2Ru?=
 =?utf-8?B?UUNtYzR6emdabGxVZmF4azkyOFQ1NHlSeDBGR3NUWGwvc0REcHkxZktGQVBi?=
 =?utf-8?B?TDZHRWZMYTVtY2UzM2RVb3lNVmZUa0hhYUltZ3kzc3ZnUURvSkFyOS9NOGNB?=
 =?utf-8?B?ZEhXN1M0MWlyeURwWkh2ckM0cTE2SlNnQ2xpVlJLcGl2VURSTUcrQmhNM1Zw?=
 =?utf-8?B?RnI3OG1rczRYMTQxQUlLbnhod2d6UnpjeU5hYm9mTzF6QlAwUE1NaVZpVlhG?=
 =?utf-8?B?TVZBcnJ6dkE1bVNjMXpDbVFIZzN0WWhmRXFqbG5HWHlVMTFjYWxHY0lKQmxH?=
 =?utf-8?B?Qm1tYWtFOXErdHBSbFYvYUI1TS9PazFHdXJqMGIzZ1ZxeUFvN2llbXpBZll2?=
 =?utf-8?B?dDE4dG4xVi9UWno4Z2d5ZWYwaXhUdmM3ZHB0TDlOUWFSamVJTFNBQ09EOWxv?=
 =?utf-8?B?UHQ3YUtRM1g4bDlOYmtVK1plY3VUV2FOY2Y0NHkzZDJpd0RBcDV5dFcwMWRZ?=
 =?utf-8?B?dkg0WTFKR3VLN0dpTnVZWEhENmlMSWFndUZUbGNiLzgzbUlPeFdVWC9XWVlC?=
 =?utf-8?B?TFRJVDBFWHFUOUFYRThFN0kvWnlqTWdnQVJWTE43a2RQQzlIMGZqRW5TV3E4?=
 =?utf-8?B?YlZkc1dBcHNoTHQvL2Y4UkhHTFoxMENmcWwyWnpGck42UFhsbnZLTWpJQnRF?=
 =?utf-8?B?a0tqcEVhUWE1VDBkSEc2dExqS2RadGpMK0dxc3Fid014aDVucUs5eXdDVWg4?=
 =?utf-8?B?QTZuUmcvWWpYL3RMSWdwT1ZXbmUyRUR3RTc0RThubzgreHZBUkhrM0J5dS9w?=
 =?utf-8?B?Q2JQMDFacDdvb2xtYVhTdmVjZUd3L3hDckZNWDlYWHFsaTNqRlgwamVPTUxi?=
 =?utf-8?B?eEhhalkrd3JnOEduMVFRWUczWVNsZDRhc203YmJqcVRmbUhFdjMwRUs0MWts?=
 =?utf-8?B?U0ZoSk1COFBCSk9XbnA0anVwZ2hjQ0kyb3RyeFpjbnRiM0MwaUtVOE5kZ3VC?=
 =?utf-8?B?U3pJTnhocEVXQTRiNXBjVEJsMlZndGh3MGNVNXd3TUhGTy8yVlpxN3NUQncy?=
 =?utf-8?B?c1NUbHNVQ09YZTlzLzA5dmJ2V2JFS1NRWVZDL0RENlhXaHRsN3pBUWZCQ0Jx?=
 =?utf-8?B?VWp4RFlHeUFuZ0dEOUs5QkZNNWZCRE9WblN4aEg3OFN2MFkwaGxoVGlMallj?=
 =?utf-8?B?NkF1dVZ1VTFTdlhJYUwxYnVUTFVpdVZEVFVSSEdOWC9Mb1FMLzE4OCtwVklQ?=
 =?utf-8?B?c1VzUDFZemh3aUJzbHJCNGFrV3JzSjV2dUVDVVdRd2MyQXkzZ2tvbHAyVmlF?=
 =?utf-8?B?dlVNaHV4THR1UGR6RndKdkpLc0pvQWtRYXdtTHU4d3dFTmMzVUN3b0w3MUdG?=
 =?utf-8?B?dEFjODYySkRuZXBZQytTVUp3RTZ3UjNCRXRSVGwvRWUydGxKMlNNbUhHTVlY?=
 =?utf-8?B?Yys0elltRW5sb1JOWHlWTnRCWXE4cElYN1pOSU1BK01uZ3pPSlNON1M3REt2?=
 =?utf-8?B?S09kKzdVb0N2YjFibS9tUkVUTWM5WnA4ZWdhbDQ2RzR2dFVmd0hzVUpBdFJZ?=
 =?utf-8?B?dTNyOTlPUUhSRHZDdFBSTTdPQWUxTWg4dmRkS2NGR0ZFalZYb1lPc3BVME5w?=
 =?utf-8?Q?deQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU03Qmg2ekVoUkNuaDlKVDltMmt0Z2g1UUZSRzBDZEFqekphNEx6VEl0Q3pM?=
 =?utf-8?B?a1FiRHZCSU5kWnh1UXBmS3k5R2doSTU1WGJCY3hwR1lKRHhiT3hoa053Q3di?=
 =?utf-8?B?MTdsMTZYRFpWc25yWDZwU21TMXlTWHVERUQ0ZjI4KzJSdmllcGNUQmIwdWhX?=
 =?utf-8?B?dVM5ZXJheWZsZWlLeEtXM05qQTNvNzYxV0JqRFJOaUZCSXI3Mml2VWtTa2hH?=
 =?utf-8?B?NXN4Si91Rk5HbmpHTEdTMkpiSTRNSVR3d3FVcUFuaVBGVlYwcm1VME1ZU2w1?=
 =?utf-8?B?dVRhU29WOHBxMldhQlpxWlBBN0dXUHRCNkxpRnRnUnN5QmVmUHBqN0l1R3Ix?=
 =?utf-8?B?T0ZwcDdrOUFFNkt0N3B1SjluRU8wNjhuV2w1N0Vic0Z5MG84WWlaTXozNHRy?=
 =?utf-8?B?WHEvMmVQRlFCbjNjalMrcys0L01zZlFkbldJNXZlbFdUYitNRVFhd29BNDNq?=
 =?utf-8?B?Rjl4b0hlWE9tcDAyYUs2NFVuNG1hWVV1QjhIWllKUUlpcld2Z2tIYlRPYXJv?=
 =?utf-8?B?UnRsSUYveTIweDE5eHViSElqUm8raVN6eXJkY0ZJRmNaREk4VnN5bHNUTTRr?=
 =?utf-8?B?d1cvUk1WQ0d2eHZObGUvNnJ3bTRoaTF1QVpmenNpbnpHT0I3amQ2Q3Bob2lJ?=
 =?utf-8?B?dlRjbHNpNlRHN3J3TGQ1bkNiekw1c3ZwREQxY0w0anAyZEczRmkxOGVDZ0F3?=
 =?utf-8?B?VkhOblJ5WkdZWTN4OTdiVk01Q3l4bkdhdytVcVNIcGpsT09UazJBRDY2M0Ey?=
 =?utf-8?B?UzJ2eWQvR0dXOXM3c3hRbzZPYk90TEc4RjdBU1dySWloenFRT2dmelNhV3pS?=
 =?utf-8?B?cFFGME1QbmRIYU1aUXhyR0JBRXcwMnZiZ0I3cW93WkNIVGlNSXdZWXZ0Q2M2?=
 =?utf-8?B?NE1sUUdhcDdPczh3MXl5aE50a1ZhSlY5MEloNkdoV0JaaHZPb3RrSHJoUHhC?=
 =?utf-8?B?OU9ZWVF0TzV5OWpDZ285SU9zN01vaC8xWkh4Wmp3NlJGZEQyYVNsRW1HV2sz?=
 =?utf-8?B?dFloaWN1ZHU0UEpHeEJqcmtEbmhNSGF0THBkdEpicjZvS0I0cTVIZGhBRmNw?=
 =?utf-8?B?aFZaUHUzOWhBZEtqTUtXeGxCWmo3QVRKaldBZ0hQWHNxYzVYTEhxbDc0RVZw?=
 =?utf-8?B?a0JQbFhISWR1RTdmNVo5MGFMbWt3enNhUGxOVGN1eDQrcHhJcG5rSEFsZ0Ri?=
 =?utf-8?B?YndDbWJEeHJ4OWx2Mm1HUUhCWVptaWc1VzA0NTZ3MEVybHUrNFh4OGFHeE1I?=
 =?utf-8?B?NDgvUzN4Y2ZUZFJMUVl1MFFjZThQS2E4NDZoN1ZIdlNFbFJ4ZU9FcW9vOHlW?=
 =?utf-8?B?WW9rRGVQVU10RXlQWkpTVncwVlh5eXFOd2pwM1IxazJiMkhEeVliUzFZZ1hy?=
 =?utf-8?B?MmNpOUxtZlJ1bTlmU0MyNGxlVnU0dUdmNUQvbnppVEhVcllEMDhLc2pLd2xC?=
 =?utf-8?B?RTNvYWNtQUsrNmxnTjdTMnVjN2xaTGhKYWRpb282S3JZMHVRNWJUZWtWQWpt?=
 =?utf-8?B?b0tvL3poWTFJT0c1eWpHY0U2SHc4UnNPc09hYjYzekFvcUltczA2ek5sSEoz?=
 =?utf-8?B?YUJjbVRBZ2FjODRuQ3h3K01kcVN4VTdjOUUrbWdPaDhmUE02NERLL05zZzVP?=
 =?utf-8?B?ODl2Zjkyd1hJcktvUTlOdGx1WlBRWGlsWEtJSmE4YitqZ256dzZpaG9SRVRM?=
 =?utf-8?B?aVJ1K1dZc3FSdkxhdllPdUZuVDFMQVFFMHhqTlF5aUFYOFBDcll1b09QUk9I?=
 =?utf-8?B?K2ZhM0RDU3pxZWlQWEc2R3dtUGxVWmludk44aVF3Y2J4TllmWTRmdXdITHZo?=
 =?utf-8?B?WFhjb3ZPZU1QdVBpS2tTK2puVFp1di9CMHB4Rk5vWnA1dk9OeDBrWHdoOEpJ?=
 =?utf-8?B?NXJYVWtwbjUrQ2FRNlRkSWZBdGxJSWpnOXdBSmhneWZBMXFXQlUrY251L3o2?=
 =?utf-8?B?R3ZTaTVYU1l5YkgvbkNRR1FVV1gwSFBTcDBHWTAvSGxDT05HMzl6MFhLSWZq?=
 =?utf-8?B?ejc0VXNyVEZDRE1RVWZDUkpFeEpsamZ6T0YybWhyM041aEp2WFp2czhwTFd5?=
 =?utf-8?B?a2VkdGpoNzkyY2s2aGJ5RDVVN2gxS2dxSlJZa1RxenE0TlM0TW5paS9rYjVB?=
 =?utf-8?B?RWIwWGVvamNDSkZPeUpiY2Q4enl3STR1YWI0R0Era3BJVE4rUGw0NmZWcmhw?=
 =?utf-8?B?dDNXeFo2bFNHeFhGT1ZtbklaMUNWUUhwQ2Qyd08vcWhROVRBL1B1cGtLWUFI?=
 =?utf-8?B?RGFVaU9OS2syYlhJK2t4eng1V3YrRjhRT1JnNzhSNHJ6ZVlpUHkybktyQ2lx?=
 =?utf-8?B?Um53UHJwdWdZcW41ZGl0azV4bzBIT1lpcjdKczlLMUk5RTdCd3RWaEtuSHJh?=
 =?utf-8?Q?lay6/EOdiAr6iuogeyzy5A5caTg3icWbaJcmN?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de51df6c-3caa-467e-b9dc-08de6b12ae09
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:15:10.8557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJbhES9h8+ogrZgsyfaQqKiSakU/1CAOsMAvK6/a/aSq202AYSzoKjv1sdSYf2CWt0xtcZ+lBB2uPdBtkBV61dB0jXtgy8WCPayNHfUsjVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> The TS433 does not have a SD-card slot, just the separate SDHCI-controlled
> EMMC on the board.
> 
> So drop the 2 config options.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
