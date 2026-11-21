Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27373606A339
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VsCznw9H;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=N4T+C6Q6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEBB440710;
	Sat, 21 Nov 2026 15:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwL4jWyfgWVR; Sat, 21 Nov 2026 15:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 607BB40762
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795276047;
	b=CTGejKVtSNw9rJaeAlu00pfE2P4G9DaPinbLoxoUiaJVOaaDKRzmlUtvmFXGgdfDbQrh
	 Oxe9f+pzQLoW1m/WMSM5paSgTwQ7mcldW8QGQYwpTn6zcnxX5bAst79qia2RG1lZfaGoj
	 LV1dFCOoqd1yjYLB9INE6XTUDo0P7wbTQmFb4JYvtzBSw0Nfs+iWQ0bwCi30txD/2bTC1
	 7gEFlp8qCPt2ezFqhFuPiecnumvw3P4Pf5LKYKv9EDRmX6+gZyjI5lKn6z6kgvzhie0RW
	 8Z9CFJMi5WLZ+6KnxS1YQx2i10Eup80BmDOAjanUkSN+J/GyLGxjL1AfsGIxEUwuuzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795276047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1F//EQHYc61iTVtneb6AwsKfzmwQRtMvPst9cKBJPtE=;
	b=RFX3Fs6V/D2H9mp8du503KDC/nIgTUWaMvOjnOijQB1YdPx8tABLcqt4gdS2Okg8Q2r+
	 IzOJ7FmSKNPn7eN9e1t+IBTEfeKfTl+PRSMcWMpZIP7/UfH+h/HueGfRHzUt6f7MyUSO8
	 WR3Ke+SzFiyqm1cVXpMz/w3Xhp3ce/sHP0YWU+JPBCXogg1suyGPX4+OXRAKQDpAvYdNP
	 g5tdyt+dEXV9Cs9IivsWRwHamAoawXDq9pnsfceFI9cqpMJK+j6jeP8lHiuizpxtU/GPE
	 e88uJ6FKjTe7XV3EVTDg/ymYQkwszEeCI3XKpr3PLhpCLchwdOvlFmRbGkhDMUupc2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795276047;
	bh=1F//EQHYc61iTVtneb6AwsKfzmwQRtMvPst9cKBJPtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VsCznw9HwFSSf7u5VkE7dtCq0TASRhH1ASjHmPpIXJnatkDdZl3X/V9nvSZ58iSq8
	 CfzpIVg8jaRXqnBtzsDaT12VrHdmC5/VC+CjIHcpvty2C99NXPdxrGZP2V/i+Tm7pJ
	 A+xG2dHdoGnXvR6igh64h9LojFaCyHIt94lXUtCqstE4DHORnMrECYdGAyz4aMTReP
	 yCV2Rh2QxnfjUdQEW7UMG5X9X/NbI1MzyAhLkx5YHH/vyg6c+C8kNqU1hRKQZGaFzG
	 Hgq75dV1XF3eW9FrZxKTX/I36IbWqxwXt3OUA6Jg5aH0RATVC8f0MAqZz7Y81MZf93
	 BB3egsYvwBBcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 607BB40762;
	Sat, 21 Nov 2026 15:47:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D8BD15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 15:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 436A481063
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 15:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5x_2C4wkf2_K for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 15:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7852D80F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=N4T+C6Q6
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7852D80F92
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F//EQHYc61iTVtneb6AwsKfzmwQRtMvPst9cKBJPtE=;
 b=N4T+C6Q6aroLSo47GFZPKU925OsLv3VVhzzgegsrN8iMXa8lBm7uJ6C9C/rl3Jq2D2tV7j99ySEfPZH7kbhdMAI23kU0CF+IaYtPy+Z+rEQnfZ7SXdQTSxrukiAuxC/PkGmPjcE1vNXPmdW3Y3vdjE0X1ROLGyytwQDBBqXDNUdIlJ6NStUoaoy9yIRYcesp/Hd7bpTlQSO269Fc2OEI5GJESMtyNlS6iGHOCnAhfN7/sG5aaEdCDDronH+imBKRLdr9Kd8JFz+bXqGx1YgygmOE9kZ3LXWGGn2t+TT6H/nvO0KfvxWxQ9oWWQuAe2xAi6UV+TCJXnmgtE0YKhFnoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA2PR03MB5834.namprd03.prod.outlook.com (2603:10b6:806:f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Sat, 21 Nov
 2026 15:45:17 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 15:45:17 +0000
Message-ID: <3932d73b-5d15-439d-94e8-874794b990d1@altera.com>
Date: Sat, 21 Nov 2026 21:15:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: spacemit: k3: Add compatible string
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>
References: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA2PR03MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 280bef31-f9d4-4694-fce6-08df47e670d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|10067099003|261102123227099003|261021121427099003|56012099006|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: FYGuvx15DuCF28IUkaYTLg6lwG15hFJkkHvfzHaXCjNQO/UrRW585qODkDSxDkeDMwfXuNL82wUqrQiKvEysemaXgT9OXAu6m6aFuyKCABxCoUJX0GnUmX8VkfMjmpda1jbE10WgFpcjmMH2lfeUpLRG6lzccMNZIyVTBIpYQvi4lU+X4LbQksL9e6kiMKFnKF14x6CE6NarMCSy4mVe6nLxGwkqxDk9Qe2RZLdQuNY3gbnpGh5Mi5hdyS7HwQBa+n0zOFOf0VOl//gtE6wvFZlM7H0Tz3/ui035sZSNF/aLbIZ7rqazZy00kSV/7mPp4pudp2MSFU+93tw3MvQKyu2Xyiq4oPMlZU0/EFeGbS9SQiDKnWMCQYcxSqw3gz77Eituz3Qyk7CLTmKgOiOVDdF63UbMazoYJgxpAcrFB+X/bV43LfUR+TxagdNosDM+qILPyhStDYccl7eG2PtIpsHUBYYrwU1etkO11WmDLFLlhRE9w64eT17tNAK0zMDUPV3nAYrscSSTApiy6TBnhKm2M5wvYaEWS3p29YRjawsxzLuSm15vA+kBI/RL3wCHL6tOuVE8eTqsvuNJULhcz/e+GSELf7C+4hBSJ5eSQ+8KReqBCOyFDjq96unBHsPcvRtFGej5ce2sVOyoC6Hh+60qLzmxIG2GIXNg053L61Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(55112099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmU0MEhwTHhhdStpcmtaNkhIRDEyb0x1UFF3SFYzaHRsWFhOTnE4VkJaTHJD?=
 =?utf-8?B?OWN4YmdsVmc2ZjU4STV4bHp6OWdOT2UyVHBSZzJYQ0lHLzVYQnZMaGxiREs3?=
 =?utf-8?B?QUp5QTZIZDMyRVA0VFNqQUxpK3hzcGU4ZFd1cnFjTnNMc0YyRDhjZGNhWU1J?=
 =?utf-8?B?RERpQkFEMXl5YTRuNWlySFFEWlhRU2hHMU8wVnRpS016SWhkd1dZN2NSRUQz?=
 =?utf-8?B?WVNaUDhTSGdFa2lqNFVWMUtabi9aaUtwdWNta0xKT2pTNUhLV0xuYWovb2lV?=
 =?utf-8?B?OHpHeno4eHUrOUpnYUF6M09MZTY2ZGFQSkhPYS82NnM3YzVBdmJhNnZEbWY3?=
 =?utf-8?B?bWNtK0JtYkNFM3Y2SXlMemorajVNUmp5cXJqUlhMcVhDRnhaeG1WaVptOXdC?=
 =?utf-8?B?K3BKalVsaHJRQVZCbVRKMm5UWWtMcCtWY1ZsQytEVk0yMm9KQXFpSDhFRDF5?=
 =?utf-8?B?Q0tuR0RQRmJkRFdRN0VkWUp5UStNRm04STV5QzRGdzd0dWd5Q0cvZG1LZnM3?=
 =?utf-8?B?RlN3eWpmL2xSVEVSVUNrRWg0MitSTUptdmFMWDdhNGRMT1FWZGt3dVBzUUd3?=
 =?utf-8?B?amJvVlhpdkZhWVJIR21MamQyVWlKSVh2UFVNT2g1NGRnZEw2Z0hkWjZDdlJk?=
 =?utf-8?B?ZHpiYTFyUFBnWGFoQ2QvM3JDU2MwMzBuMEFLRlI1cWs0S1VKcWFPdmpYYjFl?=
 =?utf-8?B?Q1BYTmdXL0dTa0xRVXhwVE1ld01najZBWk8wYUZMTTIwb0hsT2NLZ1lSenBQ?=
 =?utf-8?B?L0ZCbzVTRllZZEUrVSs4eldzTXcwNnQ0aDdPL2g5QkE0YWRKT1dyM1B4S0F2?=
 =?utf-8?B?TEFPVUxIV3NyN1RLckRoWDNxYWUzTWFGOHlXbDlWQ2pyenVCMWJOUFNqU1Er?=
 =?utf-8?B?UUhHVGJJRVRIWnN3YkpJa05wVWNQVjBGYW9kWlR5WWRZR3VYbUlKZHpXd0x0?=
 =?utf-8?B?ditnbHNEZW10ODh2eTlheTViTXAwaFRUSFhJejlZMkFHdWIzNkZuRXMwRTJ0?=
 =?utf-8?B?aGU3aS9nYUJCTzduU282Q1g3M3FFdDNDYlBNS2trSXNYVmRxcXJobnpGMHdT?=
 =?utf-8?B?ekEwbzNaUWVPYjM1eTFBY2FJZmo1ZVNPM1ExQnpUdDBobkNQTTBkQU5MbFVL?=
 =?utf-8?B?d2t4M1lYZXlNSDBqanUwTmdmOCtYTStCWUtRSUE2N3oycm1HNEcybHpDdXFq?=
 =?utf-8?B?TmcxYUNodFRPWHNCUDV0VW16NmVuTGlSbkVpYlhGV3BQSFFmTWV0SXIzZzEz?=
 =?utf-8?B?ZVZiU2NqUnlNUGZ3RWF3QUFubmw0Y1prdTFQditOY0ZSdkVGYWs5OXFRYkRo?=
 =?utf-8?B?YjVzZjJRd2hXcDBkQ2Z3cW4yVUtuK29ud0syalpGcjlCNDAwTFpjYUVEb0Js?=
 =?utf-8?B?OVFhR1RFcGt4QUFpK0FGVVdpS3dOdlVnSlROS1h2U0J2VFBQR1Y5SEFTaGpV?=
 =?utf-8?B?bmxqalplUmtSZTV5YlB5N3QvdnpYeHRjTFprc2xpTHVjL3RNZm1zQWlKbjFo?=
 =?utf-8?B?aTdjS1hGM2JlL0pTU3V5bHNSMU5oZUxkby9kbE14cEp3UW9YRVdnSlFnVXhk?=
 =?utf-8?B?UURFcTZ4UVJmZFd6eGFZZFZ3V0tLbnN6NVh2TnZUTTlMREtMazlGR3ltMnpo?=
 =?utf-8?B?S3lJMkxYSGNrWWtwR1NxbUMzT0U5QzBsMkZoQW1yN1h5aG4zaFlOcDRBUlF5?=
 =?utf-8?B?RXZ6MUlrckxzNjhDQys3WEErdktYK1N6VFdReTdaakQ3dzViOU1hTU96UEJk?=
 =?utf-8?B?TlpjdUZ3NzJ1Ym9tRzVBRUdYUXROTWx3MTJ4OWkyakRxYThVRWVoTmhMSDNQ?=
 =?utf-8?B?aUxPS1VWeDFNdVQ0MGMwblU2dXRkYnB4a0FSWXdzMFBHa3JiNDRDN2ROdTFG?=
 =?utf-8?B?V0pwYVlvS3E5cnpVNzYrVDJNNWFPdWRXeDhPaEFpRFpjYU1YbHFKVG5raUhv?=
 =?utf-8?B?QmlOeU5aK05yL0NlRXpvUnl3d1FjZVY1KzF5eldHNWltSDFrZExFQWFGNzdR?=
 =?utf-8?B?Q1F5YWtCMTVLMVNxT1VndW13ZmZPOWRyRGdmZGk2ZGEyUzdBYWJFRnRzL3VF?=
 =?utf-8?B?T09nZUVLWDFJVjJqM0xDd1pzUm91YWJkQTFrdVJoUng0QUhxZlJlQmNGWW1n?=
 =?utf-8?B?dEZ0TmpLYVJuL0JIQWt4U3ZHU2tkemhRRnNhSzhrVG42a3lxZkFrdGNxemV2?=
 =?utf-8?B?dTZId3VFNXZpZWNlTTNCQkQzN1pQZXZtVXYycjZhaDM3cU5JSTNZOHRIRThn?=
 =?utf-8?B?emRqT2pvQ0d0Mnk4cmZPRzVuWTZqK2E2MU13YkdmNitqdU5pVWpEb2RiMGUw?=
 =?utf-8?B?QWUyaC9hUTBTSU9vcVpWei91NXEwcUJ5QnFVR2NBWDIzVTY4WUozZXFneFJR?=
 =?utf-8?Q?/lnP7rqPU5C9zKtk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280bef31-f9d4-4694-fce6-08df47e670d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 15:45:17.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLrxF6rMxpSDsWs3XlQB/xveA3cDpyywxJWu4WNESr7+bWEQZzpqMmSNKFZR6oAqd93/fP58JFY+iPtHyr06DVZ5u/D8Zy6OTBRccA9L0n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5834
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 21-11-2026 05:44, Yixun Lan wrote:
> Add compatible string for SpacemiT K3 SoC to enable support for
> the SDHCI controller which necessary for bring up eMMC and SdCard.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

