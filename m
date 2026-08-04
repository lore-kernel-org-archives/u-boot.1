Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C8FC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 15:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9289A60747;
	Tue,  4 Aug 2026 15:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBhBkeEXCA4X; Tue,  4 Aug 2026 15:13:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE5B160615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785856418;
	bh=azXfULK+buUFJbVhT4CMaMWFkk48XLyg/de15fxBwD8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/T00xjXoQ0j3w1Y0Uh+0sl853/K6Y1eZoCJjb93VgX8eU5Mk4pfES1PiFdyQgGAZ
	 ckm4ppej1CoeNE3VVzkrgVVxdG+Kvvj2IRNVNza3Bbn4BVxVnS7JSS8UF5imDDkAbS
	 MXh+PHAp7L7zpiibfXDzU1aI3WlMkEzGQxuwbZTH0rLhzWiTv/TFvpk1Qa7gFQWrsi
	 OY6cW++1T4hRA7tzXfUH+Q9ip4ozth7zofm1du4HV5KnK/isB2Wic0H7zpxAtGSVL+
	 YQFZ6/hrVMlCcFwZZSDWkegTd2lNONqGxuqY8vnOjch4TOt8O2JZ+Sm8w9cGwEeykD
	 zYD0CDRc9eirw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE5B160615;
	Tue,  4 Aug 2026 15:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04963218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E18E540071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mt_TjrpYFpbU for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 15:13:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B87B740064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B87B740064
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B87B740064
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi/1VtZQ8B+sQP9PPYjgH4frgam/4Ay8y2vWnCwsbRA60lrjcEvXa9xjAA72rJuDN5q4QURzyFbqQqs1i1P3A+ffrUcVk+bgh8u1k/Z77v6LsyXmKjJ0i+y5nQt05DCJ7TLuLHlmGHPI3mp4jhu9+26a+Yijb0CCc1j7C8CTbYDn6jDEN7KQkHcj6SWP7QSzWQ+YQc2BBysF4MW+tBPiRra2tfI33IL5CWWArJs2EFYYo9QX6lxUGxnVn2k7D75mGynwVZxG9a3pDpw75La8aTNNYhnkT1/ZtnZZ6OSKsQgFM6ZXO/IMq4bu9m0wLjiH4DH1wBmWKam8bMyHn9TxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azXfULK+buUFJbVhT4CMaMWFkk48XLyg/de15fxBwD8=;
 b=lB5u+2Pfn7kver6K+3cPGmfkvLR8bwGv69SBuyl3w4iu2MgOiePXNDk+8OgUkV95OSz79tkZ9a8lVCNSD737rXkIIQ5c486e8nKvNrEkdE+iAW6HJCNkL3+o6l7gU7Qlz1a68kp5ueU9ajHB0nHzINEQr+/5KfptIdwwuG+6fn3IZljaXzcPrW/d3rNH1+eLMvWbFGY8eAI0CXQVS4mUOJyKv8oH/S+3lCxZvmGvShSzM1HlxZSKON2wil7Llq+9xzp133D+UMRg5/IsfEKvaVLxTXOi4vTxQ6HKzNbS90Eoqbs3AmKFxZJjrSKySjt/Iae1f6o9V+n1TWHZsB3mhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Tue, 4 Aug 2026 15:13:27 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 15:13:27 +0000
Message-ID: <4c5eaec5-6970-4643-8da8-aa9656ea948e@amd.com>
Date: Tue, 4 Aug 2026 17:13:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: zynqmp: Remove duplicated sys_proto.h header
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
References: <cd3c11a7e09ed8db3945910cdfed0eb860dcd61e.1784870326.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cd3c11a7e09ed8db3945910cdfed0eb860dcd61e.1784870326.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c0b901-8f98-49b5-6c18-08def23aef74
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: QT4pLRBNOZFB3UOIMnfMw7TFhSERMvaGo52zuEhyFMEzeUh/5CJCZT6ABqr5YfCqXVQHRFJiRoxa/sOVcvpByn0YlGGY7eDHL3/HQI58CVApDkQe3HtBSQJk2ofG+yKIqF1QhT2alhGDf/JMuqoHTyLUcQhtOWdtxaKpRt0SCZOqtgnf0m4WZAW7PHsp2Y0HjdGzrRVLbk3dzj540UYYwk+74PVLpP+BwqCAwMyTbJDcYHSGwCZ1IHkeEgJcu9ZikqpPKGNduyfdxn06FrTM3lz6sb37DAYXz2vpBAaHjhvM+xbObPQXsb6Pfk0qqEnrVeRR+Xwa+G95TcDc8ZvpzbwlvkeJzMWD+j4tZlBilQolV8Nl3yQhjPoBDq7LT91f0RWQ3/IIpi9GagNvvtSjGScSOt2pdeXnRxcmX/EGh/yspMLttAiRcPrpKVytODGlc45jNimeOSIZ+C+zYgIHnQ5v0NT1R/tgJ2ofPu0LiYFmzOaPmdRrpDtuwtEK+asIy+xCVh9bty3OFMpr3APDDjefZcf41ToQ+uKdC6534wNDPaIteyqC2NtLycl1u7y974/uHducmXt1yRSsiygG39J+xo041HG0206NIJGzCo9pybbtstME/Maf9RCI33mQwyN/jSiF+jLwdWBZpH5FptdCvRWuLqK+8lBr9wI1nh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBpNUxTSDJuR1FKUUtyNXRydm1TZWVkUnVIN1lmaUNHNVpvdzEvYWpDbmwz?=
 =?utf-8?B?aXpZVDNMTXluUmxvNG8rak9pRWVBTDhyOUVPRHYwV1lhSXZlZXlyeFNncEpC?=
 =?utf-8?B?Y0orQUJXVWFQVHBnalF0K3Joc21vcmpXRzZ4VUNoN1hER1Bxd2Y3Y0QzQVZR?=
 =?utf-8?B?eVZRMGlEU05QQ1YzOUVZdUNPbFVUQlRKMkVyNEJyekU4eXBqdENUbytUU0hz?=
 =?utf-8?B?SkxkQVRxWXZaOTZqSlk0NGdaZ2U1WDMybnFRdVZhY2RDWW1yYnZUc3diL1VN?=
 =?utf-8?B?Yi9MOXZ6NkNtLzZxV1VrcjEzWU81K3B6K01wYzk0d0hvOGljbVRnbnQ3ZERU?=
 =?utf-8?B?YVRZRUlncGhjMHhwQ1VRU1paR0w0MnEzc1d0a3E2NG93YXI3czcrTHRYV3Nq?=
 =?utf-8?B?bHIwcXkrRFl3YnRDVDQ1OUtibjBsWElzaVhyYUNkZWFLbkRxdGRwU2hwKzF5?=
 =?utf-8?B?blRhTlp4Nm03UVB5Mk4zTGpHdExIQ3ppQklmNFUxQXZMRER3M2xyREhiazlD?=
 =?utf-8?B?SWRmS0hmaXg5aFVBQVNjZkNDVit0MCtZL1duK3RkSWloUTExWDhTQTFiUlBl?=
 =?utf-8?B?YzJpRDhRZjlOWnp3MUVUdkRpU1ZNWFZ2eWxla2ZkWFhKejcrQkVVWjBNUkZY?=
 =?utf-8?B?dW4xeHBPQXY2dWxuWVdaY0RubnViS2twVWRHcmcza3RwUjdLWWxCalNkazN0?=
 =?utf-8?B?UkNxSWdhRmRHMHljVnhVbi9adGw2aGlsd2NRUElZV0J1UW1kN0ZTczNvWi8r?=
 =?utf-8?B?VnlhdCtncllQb29reHNNdmIyZ0JFelZUbTZXS29CQTVPUlc3b05Qc1I5Y1hE?=
 =?utf-8?B?SFVDWURDdURvdjdvanVKVlFvYkY4clJ1ekFVLzlHeGxYMTE2bTg1SEFyN3V6?=
 =?utf-8?B?Z1hHUjJVNnRhbTNyVHVaUTNVOEZqR0RKNGY3cFhkUnhCNGdXaVFmbW81eVN2?=
 =?utf-8?B?dG1YYk5uNUxJQmZDUTVXREZERENQOHlFdDVpOVVKdTRXOU5oUUlrejFNMGx2?=
 =?utf-8?B?QlZ5TjhNZ0Z0WG9FMTZxRERMRDUwZ0daS1Jmb1pEbTdHb2NuU0hWUGpEZnRh?=
 =?utf-8?B?V1JIeUw2N3l1LzhmUE9aZmpmUzU3cHJlWk1LR3VzbDF6TTdCUHZTTkpCQXpY?=
 =?utf-8?B?aWMvS0hjR0NCTmVBUnJBQS9NNTJrU0FKNlJQN2Y4M2t2V1pXVFVFdFExRjFG?=
 =?utf-8?B?elprSDlTVUVCSW0zcDBwRW5HeSthcCtYcDZ0THN2cXRvaS9jRk9qd3RCcEpk?=
 =?utf-8?B?MzBSRXpIblRpTE0yYUZBMkNJaDJHVVZzL2lSM0NtNzA0T3ZiUDRTc1hMUm5w?=
 =?utf-8?B?NDMzTmJzNlgwaEZsb2Y0RTFwOW9YSWp3N1ZLbUx4amlhcmFBWXQ3TFl6SEFP?=
 =?utf-8?B?TjhneWhmN1FPNWlKZEVjclE3cjRFV0tJUkh4RjJHS3crT1dRZGpBM0c1Y0xO?=
 =?utf-8?B?cTVSL09telFZbEZVUFY1eFpod3hQSnJIaENyNUI4bm5TZHVUMHdneHQwTnAr?=
 =?utf-8?B?UE9rMlRaOU1EM1NoTFRRQ3Z3Tml1cVpCamhLMmhoYnYxenc1UlZ5Q0dzTERh?=
 =?utf-8?B?TXdtd2xhLzRpUWczejZTS0lrSHNvMmF6cjZ3ZmlMVjBBNUdJN2lEb21pTE85?=
 =?utf-8?B?UVRwUjlrbUU2RTVnN0w3VkJkNEd0d29reUY4eElUd0NNQkhWZnpWT3daOWpC?=
 =?utf-8?B?QWxUK0NES0NnTkZuZTFPM0ZKdzgyQUNBRUljVjhqMUhqNWsrL0VXckFpRTI3?=
 =?utf-8?B?eHhvMjRVbnkvM0ZMYzU0d2V5WmZnTDZzMkp0c09jVklTSWVObmFURXhkM1V1?=
 =?utf-8?B?b1FVY2JicWtoOUVGWW02bVZneFRLUENhSm1VZ05aNS9uS2cyRDlwMVp3NVY1?=
 =?utf-8?B?UTVwVFAyelVFVVJkSit5a1lTaWw4OUhGOUN4alVHNWRDSnhlLzNaRkVJQ1lR?=
 =?utf-8?B?V3JXY0lEeXpuY1llNlhaVVExUDJRS3BtcjU3UDBXUUxVMFRVWW1ZN1NRMk05?=
 =?utf-8?B?b1B2cGdOVU5wSkxWQjNGZ2pvbmJsS0ZZZ1VTQ2V2Wm9obE13cUtBQ3VKWVJj?=
 =?utf-8?B?dkdERUhVRmMxdlZGZmRrY2Vld2ZMMmhjSTkvaTQ2aGk5UG5yck1Ia2xveEhS?=
 =?utf-8?B?eER0R2tjRlpySk5DWXV1UUFZQWdDa24rL3BodXZDTDU4cjVpcVBpTXFqUko1?=
 =?utf-8?B?MEkxejFJRDlFdE9LWittWjBPOUJtNDg3eTY4YzdxeHU1T1QwdTZGK2pKYkg5?=
 =?utf-8?B?ck41aGR3QmhkcXd2RFZlbU01eVhHM2FzZC9KMjYyc0ZqVDQ3b21LemFwdm1q?=
 =?utf-8?B?Mys1VUZ1c3RDSW00ZUU1MWFsaTg0b2tRMTBCM1NadVV5MFNoeGtLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c0b901-8f98-49b5-6c18-08def23aef74
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:13:27.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz1mrAVvH+ga6KSptQqFFSoFa25IjOfx12lVDsgXe4XROZnQy4yogd3RfFFKB5cT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azXfULK+buUFJbVhT4CMaMWFkk48XLyg/de15fxBwD8=;
 b=A7ZhSQaxqNEIK3hMxOW7M2cy166dKtq8uyrXnDOy0Pat3en+hSpjI06ZfHfnR1UAeM8l87ZHW4a8nB7/+0zc9A2yXPF7JyJo0ghbvKGU+T1wc2HYc9feL/Wij1ajYpO9GBggHy23u+OsK4gdmlcnTtYPt9Giv4tgSj4pBlXM9Og=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=A7ZhSQax
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/24/26 07:18, Michal Simek wrote:
> asm/arch/sys_proto.h is included twice that's why remove one.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index ade761830dd1..2bdb1c4d9f89 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -22,7 +22,6 @@
>   
>   #if defined(CONFIG_ZYNQMP_IPI)
>   #include <mailbox.h>
> -#include <asm/arch/sys_proto.h>
>   
>   #define PMUFW_PAYLOAD_ARG_CNT	8
>   
> ---
> base-commit: ef665e159fefceae515aacd1a2744d1153c38210
> branch: debian-sent3
> 

applied.
M
