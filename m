Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C3CC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3815B60A88;
	Fri,  7 Aug 2026 15:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLl1NcUGzopG; Fri,  7 Aug 2026 15:46:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 846B9607E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786117600;
	bh=KTNn4lmo9xGz4wPPBjX+ofHGW6h5Rgu17RHD6gdN1hQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WxolrpqjLT9QmqTntDz4xVJURpOMzl8lgAawzGXZsw5dcOEFUUOT8GSqpwdlpGDah
	 Y0vsKe+t7fT/jcrVaFsgCODffLHBTr8zmcYrNRtGa4hoc4l4FoZRA5acnZvDwdRBJz
	 vV97CDbQsv2oZTZIDToiDW17aUD7DDrx7XXc+oPDk1rYwtUThTcX99jcWBAciBeL14
	 mx/X71DTStbtkZIiYFjWR9bou7ARgc+IWIxPXrFtbsCWaUvlxU3y+PWGyfskK88mzU
	 7wS5VA/XgnmQYiXjUVY2oHBsZ2rxwuNqiLzuE/g4IJbWO7+UZUiZVdgWmzLgudx5v7
	 sPCP5a9Iugo9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 846B9607E4;
	Fri,  7 Aug 2026 15:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 365AF282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CF21400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRxSw6GqUZx5 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:46:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 587B54008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 587B54008E
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 587B54008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK+Mdb+TEk/zsaZrBb237hqnXNWf++T6jFKWN0fPFOlrDCA5StNsSCo6sJAcA/Nin29tkf41SJaLuvZBVc6hnaVvzrMqofrBcgi58bYWQvSgUItxv6rSQgzIIcn8aSQ9Om4+DQH39zoF0RQnrhEuQoqKMnXd/6iX+/VY0Ayu7R9Bi8NckGRhBB11rj4fP5JJaIKJ2bkWn9NVLNI19N+8Peo49ko3u5zWrKidcDGonLDpsMI1EhkAfL+dhzjxLepCuA2EdDU+Y8RkqyNODEndL3gNFNijJc1FPqvOLFgvsMAaNiIOXH0sTUkhla5zxkHeTk749DqgomvX2DpeuNC54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTNn4lmo9xGz4wPPBjX+ofHGW6h5Rgu17RHD6gdN1hQ=;
 b=of+qS6qXQ56s8U9BL96vHfE+Few6rR3lUFMYvpFezGNSlar1/8q8yaEYlnMo/WKEm4aiwMliOiu1J8iY+VzdZAlnEzzUURwxcvoGnHkFleRuWbOkLfRRXT9dj1FtWK36vSc93FovDeLyeKUXM3+6/gAmkN/ZwcOVQyKXJUOehW4KMy7nm3LxV9zo/ujJ5HwUXiU/2I/J2ZqQHCLnqRqGTVgx/I71tSt724lN/We12szzHHVYeLZuNAJFA6Sthyyq8mTJ/e3vmkN7Om9ZAzPNcUZncA+D9k8CVCjK8YeXzkIuxHIfE+XQGQbNLcarTDtXD5TcotRdDwcsjg0qzvLhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:46:33 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 15:46:32 +0000
Message-ID: <9800c4b3-18ff-47d4-bf3b-11df348b6cc1@cherry.de>
Date: Fri, 7 Aug 2026 17:46:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] clk: rockchip: rk3588: Use SPLL_HZ constant
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::29) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU4PR04MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd283b6-e57d-40fd-0d63-08def49b0dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6+3msMi6ypFN9B0Ei+dmkPXbXCXJVh//qgBT70eaTsGkCgFTf7b+AQ5borQT6uLdiVU9Bz7n553TyUqiV8aj/sv7YlAUGVOp3mOyZ8A9vRow6kNpMsrWuPn89IqYFBsu4cSAPoO9AN+qCdEXu4M9l24daEttItQq4cF+WdcZvQdlFaYtw90WCLrG3oFW73T6OA+4XUhtqzigkrDtM0jiFf9Zl9FEvv2xIc3IfniYSjemhzXK4XrvFydDWxOw2oDXPFqcWkjo4KiOk5FIYmJozndR3yMQcibOWsa5xZxMk/s6H8kONajouWls6+IdhvJgQVyZnnuyLWSNjApLEUrrUNPU8kaJBHLezN4FY/vmYzQBckODE5mEXX+X2H++lp8rEeIqY1SMOyGKNz2ExPr5z9Tjh7U9/ASsgapL+6SRNgY4ubwv52wSfYx/bfjOEhgXjnDpcCPmOTqNny+/SgkYQD3N8WLKiXZlWlaLlQSJ74GD63b0XLI03cLmomYAmE8ElUXKav7vuJwMX1r6u8qgbe73n5+iO+RbnBvtkD28qBWs5VblOCu2O4m8jRR1avm/KQI7CzA+ks3HMkxuA9Cpo1vCMdUFkj6palhhnw1kIuGVyfwzaDteTjqiaOTGYRMUEOm4KXdN67DywJ/d9WtyPiYJHe4JNlty5bEnhr0Xcrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxXQTRTai9CbjdlN01QWjh6N21BU25JaGFFS3hWcTZ6RC9XSWdJYjdjNytw?=
 =?utf-8?B?S3laTk9EODJjNU82OTlRMFdRek9ERjlSTmVHNjcxaEtlUmlIQ1djQWJHYmFT?=
 =?utf-8?B?bUZuMDNkVUZ1MlZzd2lVR3VSalJla0h0YS9XNmRhUW5SUFpwdGdWMXpVSEdH?=
 =?utf-8?B?d0E4Y2RCU1FzVzdyTC9IMnlab2hkbUVobXZxSXNZQUtuN2hIVnNrWUprNnRM?=
 =?utf-8?B?UFI1QmQ2NlE3eEgxb0U2QWN6TjkyOWpmNjBJUnBkWC9pTXdnK1Y1ZEJaK1lw?=
 =?utf-8?B?Sy9yZkdXTTVpZXkwMWRPVWxwdUgrbDU5MVMwNDRSeC9ydTQrUGt3amtldWpx?=
 =?utf-8?B?M0tGL3BNSm41RVVpMHVUVnBka2hBcVNETFNiL1UzWDRnUGxTbWR2ZkMrS2xa?=
 =?utf-8?B?cEJLK2t5NTgzVnVpcHVkMTZWeVpYWW9PcFRlS3poaWcrcXNWYXo3SUxPU1cv?=
 =?utf-8?B?NTU5N05VRU1IMmg2Q1ozbXZLMGVET2MzWmVvV0xOejlhS1dCaHYxS0M4M2xO?=
 =?utf-8?B?UFl3bHpVaERoTnN5OFhyWmdkeHRWZ3RJUzJpK3cxQ25PNlRMb3hXbHFRQ1RS?=
 =?utf-8?B?em50Rk9YNlJLSEgvQmtHcDN0N093aUd4ZXpGL2JBNEFGU0VDckx1TTZiM2pq?=
 =?utf-8?B?L1NvMEUwZDhBWGRGYzFCa0xYcE8xajF4VG9MVEpXVHlqQUZNUkFHaEZ1b0U5?=
 =?utf-8?B?Qm9sK3lXcktyY2NFbmtsK2xRUEJ2ZU0vSWNLaTNsYU9RTEpXdWtQSktaUDUz?=
 =?utf-8?B?bHR0eG5VUVg5Z1dQOURJRmZwL1cwNEt0T2xxRXFqRUpkNjNodHJwZVZtL2c0?=
 =?utf-8?B?a0tRVmdBS2t1R2VCbnhwVk5GNjlFMnJZS3NUTlhlamdhdldYSkduUlFVWS9l?=
 =?utf-8?B?alJwSXhMS2dKOXdobHFhampkSmhIVUI4NzVHQm9XQmtOSDZLblVpZjArcDZt?=
 =?utf-8?B?a3lVUmRTN0hIY0V0a2RYYmhOc1R1alduYWJtdzRSRU9uUXpJczgrQks2dnVV?=
 =?utf-8?B?V0FtSU1Jd3o1eTFJNHVnd3psOEJyTGtKU0VOYjI5Y1I1YXVwYkIwY0hYT1pm?=
 =?utf-8?B?eEJNRUwzQ0NQQ0I0cWFzd3UwNEQ0NjdQQUQrQm4xMFRqN1NtOTlxK1NleS96?=
 =?utf-8?B?WVoyT3R1dGlrWlNlTktxbTd0ZEsva3IzRHk2ME1WbUV3bGhqbEx1UnBLUU00?=
 =?utf-8?B?WVcyQ2tRTlZldjE1c0dNblI0aEpTM1RFdlJnN2VLQUFTVFplMEdjZGx4c0t2?=
 =?utf-8?B?cGdpQ0pFd0hqRE10azdVRVpsOFdicE9OMHo0eFV6ZW53TzRueENCM3JHVGpj?=
 =?utf-8?B?VmtHTzNCdlJFS3Y5ZVRpUis1NjlwbVRkN0drUGcySDFTOGhzQlU0bnpncHR0?=
 =?utf-8?B?ZkZSSFVBTURYZ1JwSjlGbGRTZGMxNXpuRUJRYm5Idk1xVzRINUx6VXZuZDNC?=
 =?utf-8?B?YkppSmhtWVJyYmJUTHJnMnN2eERmTmdTMGJ0QmxIZWdCazNBaHdLMTl6V2ww?=
 =?utf-8?B?aUhLVmFtOWlTNzBuMFVHb1dDM2M4NUMwbHpUZkpRZG40b3ZaaUUyT0w4Qnln?=
 =?utf-8?B?eFVxVlU3OFNZN1hNQWFFeFR6b3dGMmZFYWN2QXQ5YnIwbng4SGF3UW9iU0sw?=
 =?utf-8?B?QWVqTFBTQWxtRDE4VzlZTHdZQ0NXcTc1UzVpN2tGd0NCM1BkVFdyV0NkU2cy?=
 =?utf-8?B?US9rVUI1b0pVelFlTjVLaWpFc0tnVnZwMHJ0QlNoa3ZVNTlQVXJnVXhSbzN3?=
 =?utf-8?B?TXFPdHhhT1p4WmhGa2hWbHpPTks4aGhmZkpPYnJRcnNscHc2aU4raDVwZXZP?=
 =?utf-8?B?ZDlFVjdSeTcxcGo4eS81aWJHT3VnWFRRTWV4VDZrVlFtNUNLYndPVmZVRU1w?=
 =?utf-8?B?SjEzRS9MRWVRdWN2clk2em1teTR0c29lbnA1dUx5YllYQ04zbnZlSGZjSEhz?=
 =?utf-8?B?enhvWk54MGtuNjRSdFRyTDdUMU02bnc4QzRSRTRpTzNsRVc1UFNDTzlvdnlH?=
 =?utf-8?B?bDBlM2JhTGdaMnNxRk5ucmYyeUlON0ZaVnVFOFFvVDlFZytHSi9aZ3hLaFNr?=
 =?utf-8?B?aGQwSkkvTnowUnpmRDkrUnVjTTV6djhWNkFjNmd6MzFPQlo1USt5ZmdpTE02?=
 =?utf-8?B?VXBKVnBJcFd3TVFIb0dNZkZnSEpRbSsrTGtGUCs4a1ZnWE5rTlZsQVd6bThx?=
 =?utf-8?B?bzE0UmZDN1B6Tk9nODFOKzFvaFZvVXM4ZWVsVUY2dkc5aThweXUveHMzenR4?=
 =?utf-8?B?ZXQ0NXE0bCsvbG00S1dyNHBmb1YzbVYwMGlyMDBrWjUrUHVBUHN1eWJiL1F5?=
 =?utf-8?B?ZWFleTd6cC95cEQyZUdLZ2o4VHZyZXRSWkdDcnR3dCtwQlV4QUdpS3ExYm9I?=
 =?utf-8?Q?Gz61Ml7J+UxXiQyEFzoo3WPID6U2c81xsNsh/XEKIBj4y?=
X-MS-Exchange-AntiSpam-MessageData-1: JbZm0u2m3zQcN3ulxj0OGod4pHX7MDOKHzc=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd283b6-e57d-40fd-0d63-08def49b0dd0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:46:32.3912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXebEW8zDu++334Va87HZ3SUpS81CvmSK9PFQahBTQ8kHnp1QUbwYbH53iW+e3M6FjKHXOSfaGiNzPfQq6U2NLG1EKfrNp/9u1VAGoNbY4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTNn4lmo9xGz4wPPBjX+ofHGW6h5Rgu17RHD6gdN1hQ=;
 b=P3eT/xi96f+sl2REVhvj7rR+Bq/QIYrm9xShzOn3hz3brmyrLgAFsTbgJrd+Rx2dRSXV7K4ruEq40ldP5WbRmDcuiN/k9ZA/ZQo960b3CtG0b6f66Yz2SR0lbYGaFxEdpcHkqEqgVVsmDiNhPvLLxtcBjUUfIbZ9ZohAUzhwpeA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=P3eT/xi9
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The SPLL rate is set to 702 MHz in SPL. Replace '702 * MHz' with use of
> the SPLL_HZ constant to enhance readability.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
