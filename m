Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDFEC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 10:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4E48824C;
	Tue, 25 Jun 2024 12:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FY4AEyRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32DC8845A; Tue, 25 Jun 2024 12:03:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A3887B1A
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 12:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL2XdSfEFH56qNndgeRXCO2MlJ5Ci8pSMyXE9oc6PNQKdIBOxJOg7WvH2RvO3KZM6hhhqXnsu68LtRdDP1jN7CDkeAfnhsigQ5cabWT3l7XSwumqGL75g7kP0BwSQ1ovNz2+UGXrXD/VJPfett+9TI6fsA9KgnS1HcjdLVAGFyOP+cIAkCJKmU3lt4JB7fAty2vM1N9MbvksRw8CyVH8jBx1/YXbDDMPB5rs8bSWPgCm42GTTjddF8FaiQWEesk8Yzx4I/tn2PwXxcfwWbGnxs+O6GqcPDkUhRnOW6eKyTwlJEYFLZEjWU/LpNZ0sSzFdyAYHRXosVtCC58G8hD37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgsPrWU1SDfYUbNPmAuccjod9U3U/UH1VEAafTW+i0w=;
 b=k2eTZtKAvTIPOSvsQ1RbKxYC/GV/WfXK/AoUYdREerg0hddfySJU+pjFAF9jiB8xS/XK1qcmaP+ewJ5DTEWtAThViTiltSzVYOaMNcLeu7LrK0T0Kmulk0ncdGJq+U140CuxHtu3oY7VjycI+BB3RuEOdOBPCnzFDpqDqpL832PxoU1go5q+TBZGkS6TukoQQ3gJQ/CKzL1a5+k+WtH1MqEUEF70WdWYEzTr024iautt960zNaqakUGKtB/vo8RMurWdP8dve98qjuDVg0liB3wetF54l2HeQAWsgRTGIO89gu1f263q7CDhIzSF8glowe56LTnQEKN1xy/KOIqLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgsPrWU1SDfYUbNPmAuccjod9U3U/UH1VEAafTW+i0w=;
 b=FY4AEyRQAewXdpshTgunv1ZFOiyS16HlAQCeTGmRNQSbl/hzQ4BFytbWkYntZc56x1BtaxY/pVPgmSeMzaXwo5eWxRd1QGMIwftjh47cAO9pmU14UAUG8M/2DtTcLkVey3MSiK8K2R18ps3uI16HP6psOLwJfo57VuKj+uFL61Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 10:03:03 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 10:03:03 +0000
Message-ID: <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
Date: Tue, 25 Jun 2024 12:03:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
 <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fbecf7-3986-4852-4497-08dc94fe008e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmJUV0NQMXdkTWlnaVFOTXFRV21jd3FldWVkMFF6WHBrMzNGRXBlTFM2MTcr?=
 =?utf-8?B?dDhNMXdYWFlud3hXMEJPQXFHV29jM0dVeFZFbTZhR21NWSs5RUhxd2lPU3Yz?=
 =?utf-8?B?ZzZPQllFSllPaVd6Tk9DQmYvT1F3bVU5eGthQWRYeWw2YkxvZXc3Y2RqaWhN?=
 =?utf-8?B?dE5IZVlXV3pONGZsZ1owNE81UUtKVUtPdFFTUndxdzJMajZDMHRwbE5uQjBP?=
 =?utf-8?B?R3I5Ni9HNTBwQ2Iza20zc3FMbXpMYi8zVDdyZDFtL2dEK1NFL2dHN25VdDVj?=
 =?utf-8?B?YURFK3l6SHlUcHZwbEVXdHZ3QnZPVU8ycTgxKzh5a3dwZVlsMVllOHpJZm8w?=
 =?utf-8?B?c2M5SldpaGNFdEQ2SFJtUzVmbDV4L0JEQ2JmT2VjWmRUOTk3ZzV6d0kyb05p?=
 =?utf-8?B?YkNYYUtJS1ArcUpKNmFjRlA2WEJqaG1mNGc4QXB1THI5c3VqUHFSaTZkNXZp?=
 =?utf-8?B?ZWd5SnRVUHVxc0kxczFBZGVqaDc3bFI5Mkd0ekZyb0lyZFQ5MHhlOTRPcHRO?=
 =?utf-8?B?ak1tTGlmODFrdWlFb2szWTBHZDhFSlF6ZWFVRk5mY0pYZ2pEK1pmTllLN3Rp?=
 =?utf-8?B?bTFPZDNqdHNXei9jTlhJcllqVjdvMnRFdnRYSnRIamk0Q1VCZTJUME0rdjFW?=
 =?utf-8?B?RXFkUEUvRWIrajArWS9LVG05aTRLeFEzVW41eXQvZEROOGVXSmZrZlh6UUtQ?=
 =?utf-8?B?YVJmU0Mvb0UxRzVhK045ajZQTTVlUHNwS3huU3pzckpRRmNSSFJHek1rZEVj?=
 =?utf-8?B?TjhoQ1NtQzloNytZMGZCTU5UZ2hpU2JXQVZpc1dVeG1ENmVjSkJTa2doUWVm?=
 =?utf-8?B?ZkJTdTUzbytsQVluYmRYOXdLV2dXM3JFNHI5d2ZxeU9FMFNHRW5SYlNEdUpq?=
 =?utf-8?B?cnkwUjNYS09tckFLMytNcGFtbVJocmxoRHIxdUxObmsrQTBoZ0RxcDFkSzAx?=
 =?utf-8?B?QjFzRkhFcmhqb1NKY1E4V3hBcnNMMzVGU2R1OXVRcHNWOWFEdFV0R2F4MkZC?=
 =?utf-8?B?ejJ4VTJEczdtMHg2THRCYUMyd0UxbmhSNm1iRHplWFF0UVBEQlpVZ3ByTVU5?=
 =?utf-8?B?RVlKaDVCV1dOSTdXMG9WRW1zU0RUYzdJbVpUT3JvbDFBTUtvL1JMQVRLZkVI?=
 =?utf-8?B?dmx0aGZsLzY3Y3VhU0Q5cUpXVUlsUXZqeFBUWlNZaExiSTVoV2xJWFFCaFRk?=
 =?utf-8?B?L25lRU11YjYrdDlpN29HWFVCZVdZdEVCWW41cENXdldydW82THJzcDhma040?=
 =?utf-8?B?SU1FTTdNQStXWWhKc2NMeTRna2NQNDVGYXF4cTVTcUFEOWI1eCsvbDMycWlY?=
 =?utf-8?B?bzRxTzFKUDhBd1lIUHkvUU5VQVVRS25yTDVaTkhjSUJtSnZFbzJkWE0xb3Iv?=
 =?utf-8?B?ZE1pMDVjL3RTbDFYaGJWNHFVQjJGalIrWjUvR1pXL3c2ekg1MGVlSXM3RjhJ?=
 =?utf-8?B?V1pEenBhZ21uZ1Mvb1BaaUhSSkx2RG9zRHM5YWVTcGx1d3Vya2RzdzcrWlJ2?=
 =?utf-8?B?ZjA1OWdjYStNZFQ0b1FhZklOdE0rVGFRTTU4dFUwNWpDWnBHSGlWNlUrS2E5?=
 =?utf-8?B?Y0hqQ1IzdDFWOEZXZGpSVGxRUkczMWYzeUs0REpHbDlxVlB0c3VUUks4RFk1?=
 =?utf-8?B?R0F1MXNwTndBU2s3WktBd01mUHozT3hwcEhYeEVBNlpMeUxXcEl5cXVmRXJM?=
 =?utf-8?B?NVhwaGJiRlFiSjdTTGl5Qk82ZG1MR2VQODN5WmlEaTM3aGYvdSs4WGFLRmM0?=
 =?utf-8?Q?wvENhwOntHwW8rb65E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(7416011)(1800799021)(376011)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZOVjhmeFFhVzRjbGlZTkQrb1AwVytzMFJvUDNUbGxtSkNycFVLd0ZPK3Zj?=
 =?utf-8?B?MzFCQXBZMEJidDlYb1NXUHRsMjN2Q005YTVkM0U0a3ZKNU1LSzE0N3lzenMx?=
 =?utf-8?B?bzBKVTdEaHRRdzVZSDVKdzVxR2E1TVpuRndNa3R0TExURkMvVXgwTE5CNG0v?=
 =?utf-8?B?WGU5TUpRMmw5WFRlMTVwNGRhWjEwdGNyZGNtSGVWOTFtRnpXNnRLcWlEcFdC?=
 =?utf-8?B?dU13U0lnVlpDTGJVMG9JaWJGWVoyMjJIYzNvdG5iUmU3MHN0NUF6WWZMQ0Z6?=
 =?utf-8?B?N09BU0JpZFhlRmpyYjJyelJmaGRRN1RXbDFsUzNBTFJ5U0hqY2MxWjN4ODkx?=
 =?utf-8?B?NnhKK2VmOTJCUWJEd3F6cDQxaitna1Y5Y2ZQRm4vUmg3cW8zcGtXTnJhdUEz?=
 =?utf-8?B?MC9EdElVYzVieEk1ZXZ1V0pmNno5VU5QeVZoOTlKbWpTbHdHSGY2VG11MU52?=
 =?utf-8?B?MnZtSjRXRk9YajB2UGNFQXRVUnV5UVRmcklKRHhRdGVYNFpOZUxMWHd4QjFY?=
 =?utf-8?B?LzZhQ1BkRTBxZlNqWXVyWHMyQzBPeVVwOW83RytwcnFwTDhRMHVLQ0wzblFh?=
 =?utf-8?B?SDNuQmZmb29CTlMrUlBhdklwV2JWVnA3OUtRZmFxcFh5NHJvNnJZNlNQbWJ2?=
 =?utf-8?B?U0xydnlVdFF0ai9ZUm5jNzhtanI2ZU9MSnBGVDY3L2Z5QVdRWWZ5MnExZ2dk?=
 =?utf-8?B?ZSttTHhNblBqSjUvenZZSVlNYWNYWGZPdlJuMWw1QWZTL0N1Um01UE8yRFli?=
 =?utf-8?B?MmRYMXlsUVJBbGtnaUh3Z0h2U3JtWlpmemJBMzNyUmp0WHN2OVVtbG01WTIz?=
 =?utf-8?B?V2xmcURmUFBGTlpDNnZkNlp2MGZUQ0krMmxFZHhVM1dxcW1ESTNjOWE0MkRm?=
 =?utf-8?B?TUc5aEJmWjdyNWhzY3BRb1RHN2hVS3cra29Ba25ud2hxeEIzRURMWEVOazZ3?=
 =?utf-8?B?cjFHV1VhRjk1OEpoMlVrM2pXQXZhMVJIajRoYUhnVi9VYkR0MEhBVkkwK0RJ?=
 =?utf-8?B?M2x4aHlNN001S0lpRnVzdkljaUZxbkpicllmZWJHZlY2R1FpVkR4U2xLYWNp?=
 =?utf-8?B?UVlyYXc3aTBXemN5V28vUlZlenZYSzJ0T0ZLY0tEZ2tmNEpGb2locFFSVlhQ?=
 =?utf-8?B?U0ROT0NBb09SdWNweEoyMnA3SWpJbmpOeHpESW5oTTV3YVFzcHVJaVFEbjN4?=
 =?utf-8?B?M1V4bGtqcGR0Q29HM3g3RnBUQm1yU2JpOU91QkttOG5oZWtEdDRSLzR4c2tt?=
 =?utf-8?B?YVBwakx1NXZtajBHaVVVbnV6QWwwekc1eC9hZ1NjZ1Q2UkR1ZnRwSFkzczJZ?=
 =?utf-8?B?OGxoREkyN3AzK3hlWkFLbmxCZTF5TFpRdGRlUzBRVW1zVCtteGNzeEdWdEdx?=
 =?utf-8?B?RlkxeTBLNUJSY2tnZUV1SUVJS3AvRTM4RFlaZGZBdHNYbTF1Q1gyTDFDdG9w?=
 =?utf-8?B?SWdNQ25KWjZ3VDc0aXBOK3BycUQ4SVR4dnkvbCt5a1Q5b0h6Y1VOU09hYnFP?=
 =?utf-8?B?M290VzFwRFFDYW02bFlJOXprd2RnRm8xNnBwZEVwZWZ3UVErSVp3UnBoSU5O?=
 =?utf-8?B?ZlVDT0kwR0t5VGtUZUFhOG8wbTNkSDR0Z2trdkV4UTV2bWlaVExvbURQbnRX?=
 =?utf-8?B?K1I3ck1pTVVZaTJzQzBYc3FTMG5paXU4bkFWOW1DamhSK1Z2MjFJSU9DcDFi?=
 =?utf-8?B?VHJvRjBMTHA1UHQ4MGJFOWo5RGVSbFRTS1d1YW1qcnlKQ1dSQ2t6bk9YMnhq?=
 =?utf-8?B?UTVLL043Qlo3Z2xWT2NhQUhFbFBTSEoydzBwNXA3MkxXcUYzeEh1UEhBaEpZ?=
 =?utf-8?B?ZGl5OHVUQnhjUGI3NHFJb2trTmhpSVA3TW5XSFI1TllVd0trK1c1VnEyS3B6?=
 =?utf-8?B?TVJmRE5YN3FQbkt1d2Y0MTVEd1dHT0hyNjhwanlISmxNLzBLaDlwQUw0YlB3?=
 =?utf-8?B?TzgyQThSYUlOa0hPRFlDa25xQkVKY3FpOGFCQVlOcWlYK1ZjR0h3ZlJIVHlD?=
 =?utf-8?B?TDRWQ0hSNUZGOE9WdVRxMDExd0Y2emFPRXphK2pzcVZoTm9mcTJodmlhU2VS?=
 =?utf-8?B?UmVuM2ZTZTdvM3VUamdnbHBTQStEU0hsTGM0YUdFQ2pDMkVTSTBUbXlVQlNV?=
 =?utf-8?B?bFQvQWFZWXl6MFk0aTBqSDJoYlFNOTZaVG5mWFdSUWs4ZVdLbDc0V3N3MzV1?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fbecf7-3986-4852-4497-08dc94fe008e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 10:03:03.2620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ta6kJ4bqjrY2X0fEu70J4Tq+sgCWf1x6PDpO7RTBwtPJIfXlex9rM3i1HauxAKctjnsPstAd55+d5SJh8v7fVbzxhuv1yoHSp1TUuYxAGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092
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

Hi Etienne,

On 6/25/24 8:38 AM, Etienne Dublé wrote:
> Hi Quentin,
> 
> Thanks for reviewing my patches.
> 
> Le 24/06/2024 à 15:08, Quentin Schulz a écrit :
>> [...]
>>
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
>>> index 93e83661ce..b30d51731f 100644
>>> --- a/drivers/net/rtl8169.c
>>> +++ b/drivers/net/rtl8169.c
>>> @@ -1091,6 +1091,16 @@ static int rtl8169_eth_probe(struct udevice *dev)
>>>       return 0;
>>>   }
>>>   +static int rtl8169_eth_bind(struct udevice *dev)
>>> +{
>>> +    static int card_number;
>>> +    char name[16];
>>> +
>>> +    sprintf(name, "RTL8169#%u", card_number++);
>>> +
>>> +    return device_set_name(dev, name);
>>> +}
>>> +
>>
>> I don't think we can guarantee bind order so this may not be stable 
>> over time.
>>
>> I'm wondering if there isn't a way to use the "ethernet" (ethernet0, 
>> ethernet1) alias in DT instead?
> 
> Actually the ethernet interfaces are not declared in the device tree, 
> only PCI buses are (at least on this Nanopi board).
> The ethernet interfaces are only detected when running "pci enum".
> 

Ah shoot.

> Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
> reflecting the PCI region address (so it is unique and stable). What do 
> you think?
> 

I guess that's one way, I'm also wondering how systemd renames those to 
be unique but stable on the same machine, maybe we could take some 
inspiration from them for that?

FYI, for NVMEs I also have 
/dev/disk/by-path/platform-fe190000.pcie-pci-0004:41:00.0-nvme-1 for 
example. platform-fe19000.pcie- being the pcie controller at address 
fe19000 on the platform root bus, no clue about what's after that 
though. I also assume the N in nvme-N isn't necessarily stable over time 
but whatever's before should be? Maybe there's something like 
ports/addresses on the PCIe bus that will never change or rely on probe 
order/timings to keep a stable naming?
Sorry, don't know much about PCIe so cannot suggest anything meaningful :/

Cheers,
Quentin
