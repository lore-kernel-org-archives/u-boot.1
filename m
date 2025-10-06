Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E81CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5E483C7B;
	Mon,  6 Oct 2025 17:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UpGM0q8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A135383D71; Mon,  6 Oct 2025 17:38:48 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589A083C6E
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqQUf3Rcp1vOTXlxcpJTg2br/BQzGSBUbVIjSuhQM8SwGP5w3BXx6D85g0k2yLnoviH3zrWKSLPcJiYz+Ap+EFLY3viacrx//c13oSOcnTQL7YjJmfWPWvcosPGfysa5qhyWa16WkKiIkKVl2xFMwiFrNcTgLmo86bmPJYqbynpDPb0StElUvLozVXOWK5kUmtiYqo9zMHAWRYQt9vHC2ZhRwsUBJzI/sllDRRs0AcbU9KYNQWRpzJCSTHW4HGeHNyv7422/RqSD/My3JsJ10pj54brRxsA/hJUCdgIe6IB4Iw6Jd7i/Rc0V5PV3qjWviT62PnRHtE9NKcNNlbx8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eI2xSKBc3qr1B4W61DXuZrm1/Mtet0nw9zBcqIU2cM=;
 b=Vki82AhB4Pbb2PMP1EHMMrE/cgK81l+//a5V2GbgOH0PKuaudKnG43H6VlUmF/1SJIt3UzKyTyKmyqhtye3OP56MsWR3e4kWbB5OqUI1SVAI1tX/MUqim2dcG2UkuGC+9XHadqg2Hw2A+OErW4AqDC7p1a30fKaOWxj7gkMJrjMNt9mY5hWQc/CEzAhzDXjMP4bJxD54lleqBhnx39cLMdM4/TO6X8MeHp+xPH0K/NDgwNeC2gY1v+CmJOgODrVN91tybRgnT/UsbTJL7cqjpM4nnxVDLLgcWNYKeRrRtil4Udnl52wFDEwBGMOnu9+DTX+MI9qlp3rg7otnVbeQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eI2xSKBc3qr1B4W61DXuZrm1/Mtet0nw9zBcqIU2cM=;
 b=UpGM0q8J3OAZik+zoayElfTWPRyo8hOHTpDPeNW9tsnvbZcPcMx3nLtypvYt8gLi/92Qak1FebStoTJkIRPzJD4q5yWQPIdGp+tQSYPW3rJ32nrzcirvbbPsNSuponVEBuGo3R2/w38BXPsdShzSvpjVKJMjrN1mHvwYb+cXAqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9732.eurprd04.prod.outlook.com (2603:10a6:20b:672::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:38:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:38:39 +0000
Message-ID: <cd667b19-ec20-4d4e-8b4e-4c991df4fcd0@cherry.de>
Date: Mon, 6 Oct 2025 17:38:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4-config: Improve b4 config for correct operation
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d258695-3225-4d9b-de47-08de04ee6be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmoyVEVBYjF0YzQxY0xQWFNTN2hJeHAybzQzRnc1VDJ1cG0xcFR6Z1ZTRkt6?=
 =?utf-8?B?UlB2MkcwLzNZNWRxSTA0M2hHZjVXOTVBRVJTSE5TeTcwMnIrb3ljQlpyNXFQ?=
 =?utf-8?B?dklYeFdtcjZjYkc3ZjV1SVQ2bUxaeTFLQ2FoTTVsZk8yRDVBczVKK3RibmNL?=
 =?utf-8?B?MjFOTHNUQmsvUFVmQnlrMnNDTzhGdm0zZ2I0K0h0Tk1DQXlpTXhrM21aaGx6?=
 =?utf-8?B?cEpyRm9IcmNIeGZKWG1WTllTRWZpRXFUWFlVN2lmOHRKaXlHRlB6eUtNTDRl?=
 =?utf-8?B?MHFZT1NESEtPcHNWelJPRktqSkw2eGlvODd2akRlRzlRSUhsK3ppMGFMWWsy?=
 =?utf-8?B?eEU4N1kwWHMrK201cE9URHorSEFIaDhodjRhcndJTkhRalVpK0lSRDBZdFBs?=
 =?utf-8?B?Rjl0MlV0RWJTOVJGWWZnem40V01QMDh3bHdtUHhab2ZUSEpTSlF0bHAvU0o2?=
 =?utf-8?B?czJlYWN2Z3FBRkZQWnBjaCtPbENZdXlTMzM1VDlzYkVHK25zRTA5a0pVSDdE?=
 =?utf-8?B?TkgvUmZiRDBiaS9xVTh5TFlPak1DclFTbFUvV09mTnhaYm1PQVlUTmU5QlFN?=
 =?utf-8?B?Y3RGRjZDTWdUTEV6eDBVMDlJQVBuQ0hxZUpBb0FrK0p0d0tEeGFBRzdCYWRp?=
 =?utf-8?B?VUp0SkFub3RET240b25LbGt2M1BvT2xVRHpFRkNUcFloSDloVHd0R3cvbGgy?=
 =?utf-8?B?cnlnNCtnR0thbWRUYUhCKzc2czFTV0VkYWNTRElhRWlFeHIwYnY2RERFYS9n?=
 =?utf-8?B?cFk1WW9IVzJRTlhvenJlQnF3eWNrQmVQSXBYMklEb01nT1l2enhQRU55V1N0?=
 =?utf-8?B?anVrdWFOT2ZxZTZKSTZMMjQ0UmRiaWZ6Q3M2MWFCZTFMNFhYTkhMWW5oUmZY?=
 =?utf-8?B?bXJxaGZCdzZqUHM5OXlmdWVKRmhlaXhjRmU5SDBpY204cHR4Zmc5N2xtcUky?=
 =?utf-8?B?TFZNOE0xUE5sUEtTb2lUVnRGYzVjTGNHTVhkbXVEa2NBUU9teUgzdzJhSUd4?=
 =?utf-8?B?T3hxMWpJUGVvWnM5RzBmVXhHVHZQaDZEMEp5L0M2a2ZmNEU2SDNMdUtsRlVT?=
 =?utf-8?B?S0preHdkYXRNeDFDbWdsTmZtYXFNWFFRS2VadTMwdlpEWExKYmROa0svcXpQ?=
 =?utf-8?B?UTZuYkM0RkJidGRvaUtWTVY1UW9SMnR6dTk3RXFxY2xmVy93a2ZWUFRiM1ZZ?=
 =?utf-8?B?dncxdmQwTDNWTGhnSmxIU1J6WkV6SDlFTHh2Y2lWYzhqNzJPWXRrbmU4ZUIv?=
 =?utf-8?B?S3ZNMGFDUEVYeGl1TldPeitxRm52K1NZbE53eUlKd0EwQUg0QjNPQjAvNTFi?=
 =?utf-8?B?WnY3SXJJN29lR2V5WVpHRDBYVnpKOTl4WHhLcWNUL1NCZkQxSFF3ZURqaW5D?=
 =?utf-8?B?Y0pWQmJlaCtkZ29QRHovYlI3SElOR2hSMUVTNE5wdExoU2F6eGtyeFNFVU92?=
 =?utf-8?B?Y2M2WEhJdGVUd0VYUnd3bExZR0Z5UE9sa3VCY1FiUEdTdm9XZ205ZkYzMXNy?=
 =?utf-8?B?eHNJamhsR0pyM2MwNDhMQzBUT2tqUW5UMmIzU3BJcWxReGxrYlNIc2hJVXdx?=
 =?utf-8?B?elhhdHVZMjZxQi9NcHJqeXFaNEdZaXpEZnRFU0NRLy9Uc1lTeFQ2ZjlHK0ZG?=
 =?utf-8?B?a3o5WDczczlvRkdVKy94MGJtZnhXSVluSWJsSk40WC85dDAySFJPVFZ6dmVY?=
 =?utf-8?B?SU4rb3U1Z09talZjM3pVaHZidmdOd2pmWXRVUlpWc3hzSEdqNi83dVN5aThi?=
 =?utf-8?B?OXVrTGN4Zm8xTmxkZnJIWUNtTFFRUGxLQmxQZkNLWnNZaFEydXFveURZSUVM?=
 =?utf-8?B?OExLOGh4RXVXREUwY0pOM3kxS3JMa3J0eWlqWXlBc2plRWNBeFY5cURYeFRQ?=
 =?utf-8?B?WUdmdDdLaTJaRFRqaVY3RDdMaXEvbytha2JWbEgxU21HZ3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFzRHQ3TmsxZ0I3cUMwMVlqZytldERYLzM2UVIyQUNvRjdzY2w3WkZmS3VT?=
 =?utf-8?B?azZ0dmNwYVpsREsybGIzcU1wMUpibFJHREdUNFNhVzkwcURFSEdqZ0piTW0r?=
 =?utf-8?B?MW1mU2VnUkFRWGtFcUdGcm5WWFFYdktBQlM1TTNVUHpQNDJ6dko4UjBMaitO?=
 =?utf-8?B?MFpTM0JGUWdBbkh2V3A1VUExUmJKaFY0MlViN0xMaXAwbGUrckhSekJneGJp?=
 =?utf-8?B?NlE2RGRvTDZ2cUc5Q1d3YTNvYnY3bzFaQ216OXpmQTlEcXFXbS85aEtJVnh6?=
 =?utf-8?B?TGlmUDlTNVVraDI4R1lqRlQ4WmxxUmZDenhTY1A1T0hCWVlRZER3MG5jL1JJ?=
 =?utf-8?B?ZHhmTDNwRW9HODdjL3pLZ0Rpc3dtTXQ2cys0aEpqMWZJT2dsbnN1NEEyZnNw?=
 =?utf-8?B?OTR4VG5SMmdNS0hoZWI3aXlxSmJFMFArRU54b2gvM3ZiVU5SMENPeHQrSTNU?=
 =?utf-8?B?blhCNUdpMno5N1J6QjM1aFd0V0RDWm41VXZ5SlhUeXIyS2t2QlRxcVRLTWp4?=
 =?utf-8?B?NkplakVLMWtUWXBZOWFXWmV2T3E5ajVYZzNFZDRIYUtrckloMkR4ekpKMVVr?=
 =?utf-8?B?RXg2RXp0ZS9BYWN2ZTdDd2hsNmlocnl0VmpOaGtLWW9DTkExUTZzOURUQXox?=
 =?utf-8?B?L3BmVnduWU5ldjVIc3dNZ0U1S01aUVlCdStaWU9CUHhLb3RSZHJuZTFmMFVj?=
 =?utf-8?B?eFNSakwwc2NXUTI5TVlQTStQbDM5aDdtSGNyYWhPV1VsVUdoampGSVBiL21m?=
 =?utf-8?B?NnpKTSt0cFdsK3AvM1hveXoycGsvSERUZmpNQnY4T2xJLzMrd3FOZWo2aFM3?=
 =?utf-8?B?RHdkL3BQQ2twb0hONUc3b0FJMC9BTHVTRXlOdHp5YVEwTFJyT3JuUlN6ZSt3?=
 =?utf-8?B?UW1wbXNHUmpLOFBkZVRVcjJIRWlzaUdQa2poWlRvZ2lwanpUNHdjT1hlRDVl?=
 =?utf-8?B?Q1RsUXZ4OXYwUWxFY21ORlMyZndVa0V5ZUpTSGorUk1QK1FiWW5VRVE4WkQw?=
 =?utf-8?B?dm9nQWdDdDBCbHR1U1E2QVNiVGRLWElBYzRrd3RCN2h4VTgzNWJOamFEZEp5?=
 =?utf-8?B?TnRnUHFacjV1bkttK3JHbjdSUEJhUFBlRW0wK3lRaS95dDRqcGNSYUR0L1lT?=
 =?utf-8?B?REhHbzF5ZExxSWlqSDJyMGhrcU1kdExkUWVRRmlSLy9UZU04OGtjUU1yWXZ1?=
 =?utf-8?B?Z3I5SFBncEdBVWRURjBQbnoycy9LbVRTZVNTNUJRZ056ZHE0U3dOT280eHVa?=
 =?utf-8?B?OXJWZzBiR0oxZW54Sk1sNnNoTkQvM1FoaE1pOS9pTmZWUkJuK29zTGxRdncx?=
 =?utf-8?B?VjhjTjE3REYwUEJncTdFVE1YWUZtNytKS3pra3B2ZnlMc3Znd0pqOTJ6aEpU?=
 =?utf-8?B?MkZxaVZxQUlXZkVGWXF4MEVldW5SMFYzSHBJZkp0S28zMFJoWlU0ZzAyZ0E1?=
 =?utf-8?B?Y0lKWWF5di8wY3IxNFc4Qml3WTR4UUFpL1dxVklGcSswTTdEejNoa1hvQmlv?=
 =?utf-8?B?OTk0V0QwbXF2NERnZFBzU1F3Tm9Eem83T2sxbEY2N1pHc0Y0c0o5RTkySis0?=
 =?utf-8?B?cXhWL2kvMHZ2Qjg4YTllZnh3M2VjWU03djgrOStCZmFjWk9jTWppRVlpbXJJ?=
 =?utf-8?B?dnRKaGRvQ0FScWZQbjlQNU56MVhsOXRsSGxMNGdTYlBhbnU1cFl2R05pNHpt?=
 =?utf-8?B?amcvVXU0Z3c4TFlhdWxQb2NhMXpRajRTMmRGa1BLcll4dCswWGRaOXlRQnJY?=
 =?utf-8?B?T1I5TUExUWF4OVNNL2JuRlZMQ2JkczBwRkVlaGxaSnQrQVNua1VQVzg2N0dR?=
 =?utf-8?B?NVY0d29FM0N5UVIzRU5XWWdxYjlhNnRxTGtqZTRvcmx6Ti84ZkprdzM2ZEpS?=
 =?utf-8?B?cGRGZlRUUEFpODFWcXY3dTlIK0hHQXVzZVd1TVJ5S2VKWG4wb3B4SHJPWGk1?=
 =?utf-8?B?QjVsRlV4K2dLVC9IV0RQSUVoQzdVZE5JUElNa0dUaTVjMGZVaVhjWW5PL0Ux?=
 =?utf-8?B?WnVvdkQ1ZlVUdzUweGpMcERrUDBFMmoreXJxNlpzNXJFaS8yRm43SXRuRmMy?=
 =?utf-8?B?OVUxQ0VUeTJDamx4amFObUlQOUpDZFdZN0pjYlp0ZkM0TXc4NGw0NCt5QnRK?=
 =?utf-8?B?TVFNOXBBeXZ4Smg5UThGY0ZxSnk4a3Z5Uk92Skg0OEpqT3RBODYrWTByMDVN?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d258695-3225-4d9b-de47-08de04ee6be3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:38:39.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWoFmACvJn5ZcmBV3+TSBzLicRgm5QlnQVosp/kH9VmpOae/y1aJjQEEyqMSn5EHChny02VZ1AW/tuXr3xIz/dapvVZ7h4AbgSRcE1aBhhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732
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

Hi Andrew, Tom,

On 10/1/25 11:28 AM, Andrew Goodbody wrote:
> The recent change to .b4-config resulted in some expected recipients not
> being added to the address lists. Rework the commands so that all
> expected recipients are added while maintaining the ordering from the
> first change.
> 
> Fixes: 26efc940c86 ("b4-config: configure `b4` for U-Boot")
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   .b4-config | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/.b4-config b/.b4-config
> index 6ba10cf9b50e6acb8a789544d35a13641e6c0411..1f9ada793e652c99854e4d15241734c9b3bfc117 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -2,6 +2,5 @@
>   # See https://b4.docs.kernel.org/en/latest/config.html
>   
>   [b4]
> -    send-series-to = u-boot@lists.denx.de
> -    send-auto-to-cmd = echo ""
> -    send-auto-cc-cmd = scripts/get_maintainer.pl
> +    send-auto-to-cmd = scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins --norolestats --nom
> +    send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback --nogit-chief-penguins --norolestats --nol
> 

This seems to differ with b4 defaults[1] by swapping --nom and --nol 
between to and cc recipients. Is this expected?

I've been using b4 for years in U-Boot without a .b4-config so I'm 
curious why we suddenly have a need for one and I think it'd make sense 
to document that (now as a comment in .b4-config since this patch has 
been merged already).

Cheers,
Quentin

[1] 
https://b4.docs.kernel.org/en/latest/config.html#contributor-oriented-settings
