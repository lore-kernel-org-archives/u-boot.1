Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC77FC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C0E805D7;
	Mon, 12 May 2025 11:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pqezf45l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1728091A; Mon, 12 May 2025 11:12:55 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C188180050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPC6V2b144Pazmk3Wj0RIpcXlt1jFBggfKGAnZ9viMpTU4bpSu/QEkbo+cvQvnUKC/NbvvD4vopfMvleHU3MjyGFsoi0VvI0RRPofPRyO+XlFUBupU2dQZxwRvBi0l13qQprIg2ZSMbkCn6YBS2w8vzWX3uDktMQufPNAWmq7F3K0m3TIr+4+r7mJ+/WKO5TRqn+XWv1y82JJk7hM5+WF+Fla9rqnOts/93y46AaLrveyELe5PSsBB3GoGuemjSRlGySQL90miVgsh2pMvLVInsOcuoAzRwM43XutcL02ru08wvYK3Wy79gs9IGBect/At2UI23jffU1WBEd/5iPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRJ9E5K2tgacEzvKgnuKwQUYKGwSxAvuY+24Rcis0L8=;
 b=BfHLGU+WzPkpMtN7odmqF6PP6gb7xCljAGGrP+NozIro8RfDXTCdvLwM1+6/zfR6ww4/38/8t/XasnIrTpKF1b1xSKbumVk4OTVt7SJquIMxfY13afEWZOyhDioCSYI/HjKYsKW1XSeScwEdtI6AyrHA3eCjOM1eqIs5+iXDRJfdB2DOnNoraYGFaBumX1M0LlMSDpEiFcDO/IDjTh0KbyBDOAObcgXkbdgfk9d8CEbYTofenVmX1WKoZEdnnMPtxfICicuR8xggfmJ5b9rhrdkb66UxF47DvSQ56HTZWJ2A5E3UXkoVrwXgXZL78Ix2QyM4K/24N6EuOuTW9AIa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRJ9E5K2tgacEzvKgnuKwQUYKGwSxAvuY+24Rcis0L8=;
 b=Pqezf45lghcWjvfuoiW9U4A8MYeo9RjT09r7/lbqiOWAf4tJlqvR+hvx34vg+CqHsusHREhdmDr1YU2ZizVZBet+ANd8ssihnPh5vgN7xontgXxYFTxCjBGTNWCpKKjlrw+8ObwNRb0jHGtC00bLFNCHOQ0FIzh+WVGl5a/MML8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 09:12:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:12:51 +0000
Message-ID: <383cc638-2db5-470f-8585-13274a338c6f@cherry.de>
Date: Mon, 12 May 2025 11:12:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] doc: pytest: Framework for documenting tests and
 document test_000_version
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250507221112.518041-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: b232c3b2-2adc-468a-e31b-08dd91352bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3ppRHBJSVpuUHVZSGFMOWlGaWl2NnZOQmtvV1BPT1ZjWENjNE0zVm9PdnF4?=
 =?utf-8?B?c0w0S2RGc3BNNEw5SkhsUU5YL3lKaTZ6Z2NGR21MWjJ1V2pQV1pVVGttNnE0?=
 =?utf-8?B?U0JTNmdqV1pyS0hUTVFvcHp4VFlKNWpkUU1na1BPK2d4cVpvQjNTU2w4UEk1?=
 =?utf-8?B?aERWZnVWOVVvOHluMmlSVWo0eUVzUHByaEJFNlZ5RC9hL2hxRXltVWF5c1N1?=
 =?utf-8?B?QjdaVEtHcFp2NEROb1daQ2dHZVMzYmdxZ1JDVCtKZUZHczRZaEt5clBHYmxD?=
 =?utf-8?B?NTR2RXo5ZktMRnFQWHg2endjTkM2QzFYMmNYVW1sN1E4NnJaOGtHdVRMNGVk?=
 =?utf-8?B?ZUg1enlKWGw0dVBCUURHemM1eVVJODErYlNOMHpTTTF2djhVQ3pJZ3NCVmV1?=
 =?utf-8?B?Zkt3dkExZ2hGYTVCWkdXWDJkTXZ3UnFVMlgzVXZZYVduMkhINnprOWZVWmJr?=
 =?utf-8?B?T3U1OUNSOTd4ZGxYS1cyZitWb01CTE8zS2NKczh3NFFreThtL1JqQXJDTEh5?=
 =?utf-8?B?L0swSUVlVnZiaENIbldjNEhiQUpQcTMwa2UzcFo3aGJjVVN4N3J4MmQxL3Uz?=
 =?utf-8?B?NXltQTdsS0FZVUFNUExNejVLM014ZlM3NWlmWW43anhET0l2cEZIaGZiUHZu?=
 =?utf-8?B?RDBJS0JCKzZ4V0ZXU1EyUkpscXI4azhVdjdNcW0vcDhsQXl2QkJTU3JFWGp1?=
 =?utf-8?B?THlMeWhHLzFaRmEyUk55ZzY4NWFVWnNUNHB6ejNqTURQSVZQZ0dhNUZ3SFJQ?=
 =?utf-8?B?ZThybWpTTjlxMkFWVm0wQldrL1hYZng3SHVKSTlhYmFVTUs5S080NzFwWG4v?=
 =?utf-8?B?anNuWVN0UjYrbE5jYTFET05uQ0RkQkxCQkczdmVhdlc1YUhjMlp3bGpXZm9Q?=
 =?utf-8?B?QXh1VjFtbXk1N09yOTFjNnlnZGdkeVJKWCtkVEZPNk9hWmIxanpmbnltUGtB?=
 =?utf-8?B?cVpSZU1CeGhHSlhTcUowZFhIUm9TVEI1ZXpUb1RjTlgwYzJVL0w4QW4zT3FG?=
 =?utf-8?B?SGhsTWk5MTBTSkN0cC9VTjg3UlQzNGRBTHFCQVh5a1hxKzdCbkR1NTdBS3cr?=
 =?utf-8?B?NXl2dmwrWGNEY09lNHBFbVRWRVBnSDNvczlFc1ViaWlSVmtpQ3p1eGU2R3o5?=
 =?utf-8?B?NXc4OFc0KzA4RTRlR3BDSWl3R1hyTWdhSEhQTkdrbHRNdlJVQWg2bHJvVDdx?=
 =?utf-8?B?dTFmeUd0c3k2bnhWaGkwQlhoNGlaSHVoTjZNSUtwM3kxNUhWZXkzL0oyclBZ?=
 =?utf-8?B?cUtYQWdnaWEvUExIYTNjYXZ4bEw0ZzBCWDlQRURjc0VMNUhHVjZtQlRHTHly?=
 =?utf-8?B?RitFOWxiVkdVRU9wY2tqbENSNjFCeGtiL1JHeDlqdE16L0NNbGZVR2xvQzJR?=
 =?utf-8?B?aGtnMm1xSHRFNGdmaE53c1IxTWplNUY2d01Ubmg2ZWdBWDNpS05aQmVyR2lo?=
 =?utf-8?B?M255VnlqMDR4QVQ1Y3VYRU5YeHliVUYxWW44MnpMaTRBT2I0WUpFQnlQRS9O?=
 =?utf-8?B?dFZYc0haSko5eW9Sa2cyZ2NXaWdvLzcrdkFld2xaenc5Sk9odFZHZ3Z3b0tw?=
 =?utf-8?B?cEdOWjRaVEl4WUdUa2o0K0ZzdUtzakVCeHRJak1HT1RUcFR3WVcxOWhWOTRM?=
 =?utf-8?B?NkFnT3JDOEUycFpvcENXaUxQRDdDU0twbWptMzF0YUtvdHdDSzI4VHF0Qkgx?=
 =?utf-8?B?VDgvTTQ5TUl2Z0haQ0lHclUwOU9wRlFXektHSHVwanZSaUUrN0dWZW9NSXdJ?=
 =?utf-8?B?ajk2NjA1c2dhYmhXUzBld0MwWFJsaERDV1ZWdXJaMG81c2dFU3EySVI0c2M0?=
 =?utf-8?Q?0pTRr5DAL9PiPExDw4Xqpg/LOl6jwk6tW+vQg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWF2dUFWY3ZoWCt3ZEp6ZGRxRkhaU3dWREw2K3o0dEJ5U3JzZFZReGJ2SGVI?=
 =?utf-8?B?bFR2U0Y3elM2N0Y2aDI2WENGZ2RsTGd2MjF6UHk3UVR6bWFidnVzR1IzMnNy?=
 =?utf-8?B?TVNjTjcvRlo3dFI4dXdUeFpQU3JBTG9yWlMwZXB2UDZZYnVpb0pmNGNUU1ll?=
 =?utf-8?B?djV0bEZxNE1wZ2J4MHJTUzljekZLRzRwcm9YK1loSElJYWFic0k4U1ZIMjEv?=
 =?utf-8?B?M2hmdkh2cnZUaitRKzI2T2svNnk5U0g0dzA3d2lzS2k0OCs2Rmtka21jL3Zv?=
 =?utf-8?B?eEtVRnlCVUpTdWNBNUJwN05qVWxvd0JKbWI0MkRxNDNQMzEraTUrOHFFeWdq?=
 =?utf-8?B?WUVpclpKR0ZyaW9Yb1lMSVpia2hGdkRSeVFES3k3bjZSVEtOUlNkREUvcmJ2?=
 =?utf-8?B?RlVNZUVCOTk2emUvQUduNlV5YzZ3WjhvaytqWnkycTB3ZXpaaGU3YThxdDMz?=
 =?utf-8?B?L0piYS9BWUc4dkFPT0daNEtRWHZ6TmFKTWZYQVN1cnJkQkVqQlFDbGdZSy96?=
 =?utf-8?B?Z3VuNzBrRE9hcDl0SEhXT1RDeXZhL1k5a2xvUytoVTFoR25vN1JaUFNqQk9P?=
 =?utf-8?B?T1BRbStYUTY0ZkNQSmJmSldlamNEZmhmR1JzSzBNSWVGTHRCTHZaODlVZDVa?=
 =?utf-8?B?VDZMa0Rpdm9BMXRIZ2F2bzg0OU9SZGpjZWFta0JQeXlQNGVHNGZ5QmxYSWJF?=
 =?utf-8?B?ZzNSZDhpWnlEYzc0UDRWd1VZdTljOS9uMUFUYk9TcEs4czlyWHVKQjRZc2hm?=
 =?utf-8?B?Mk1ML0RSemhPY2tPZjUyUitydTdFWlZKMXdDTHJRWG9aYkMrbEI5QVVXd0h4?=
 =?utf-8?B?cGhuYnV4ZnRiczFoTVc3UXFVSjhKVUh5Z3lpY2VneUtSWFR3OVUzZEV0OUFx?=
 =?utf-8?B?UjJwTXFKRWd0TEQyVTV1SUVqMXlIZXpaUzYxa1hIaVZwUEFXRHcyZ1lVYWE5?=
 =?utf-8?B?U05mZzRtVE9ldGlaSlZ1RGVJM21uVHYwYlg0aWpYUkZpUkl2c0Y3SjNKb3FQ?=
 =?utf-8?B?M00xUldLN05KM3J3ais3WXQ5SzhzWlVNRWsxUGRTell3b1g5bEo2b3RrQVdl?=
 =?utf-8?B?K0hMcDJSdXBNdFpRTGw3Ym9LVkI5Q3hvTlVmdTZiSklqQ1V5b1ZsQ0dpSDM0?=
 =?utf-8?B?NkpkQXVGMzhqVlRITE9KTE9vNzhEOHdQMmFmaWdqMlB6WXJybFhsNFpJYklD?=
 =?utf-8?B?SnNuZk43Zk85YkFpMU82QzQ1SjV3VVdha25OanVvTEEwUVBMWHVwL05EekpG?=
 =?utf-8?B?TnR4Y0U3Q3QvZ3gvSndCeTRubkRJZi8waEZneUZkWklSNC9sMXhTdC9uazQ1?=
 =?utf-8?B?ZmxVWkJXWUVoWlRWZFJMaUxUaVkvbVZHdFNDTkYzVEt3SlF3NS9qem9XSWkx?=
 =?utf-8?B?WkI2dlJIUG5ZVFl6OGdnQWs2czE1RjFNc1Zvekdad3FIcmFxdGhRc1pVSnRL?=
 =?utf-8?B?d0NGUW9mZm9oeG9WUVZueWdNd1ZQQzVPTEdVcUVGWStRdzk4RC9NcWg5Z1A1?=
 =?utf-8?B?Rk1rN0p0NUpjbGNlaXZYOUluNVp1WG4zUTY4R292MU9sREhtdHU4QXpPSHJz?=
 =?utf-8?B?eE5xTm01bzZ1WFdZc0Z1MTd1eXJ3NUVwdiszYnNuUFc5OGlBTzVhbERjYVBu?=
 =?utf-8?B?Y2haTm1aRG0vUVpSaVNwVjl4cko3aHlHN0xvNXBMbTU0c2lBL0Q3YnhNcDdk?=
 =?utf-8?B?enZQRTk4cEJkUnhmV2xaOGYzSDE5NnlIeTFDK1BISDkxUkQycmZ4Yzh6VHRO?=
 =?utf-8?B?MzBJV0NhTUR5TDVqWlkvWXFFVHdGb2l5RHFKSmp3dlMzU3VscFg5eFBDRmE4?=
 =?utf-8?B?QjMxLzR5NTVYR1M2eHhFd3FEcXVISENzbmF1SERQaVkyZWo4Rm13NGwxZElP?=
 =?utf-8?B?bExCUXNkVThoV1E4WmNrd1lsemRWOElNcWdkaVUzSmJyZlhUWUNLNTBoYzBB?=
 =?utf-8?B?MTlDQ1RNOXhPRXZlN3k0Z21GRVlwWEdHUVJMN282Mk45ZS9ZTHBNZnkvNkVR?=
 =?utf-8?B?YWVlcFViaTBvcVNqcDArejZGUmNiMzNUZHZ3cXVFTWVTWVU4UmhwSjRLcEhL?=
 =?utf-8?B?QUZvU25SaHpzQmRDdEY4OWRUd2g4T1BhWmY3UVZ1RnVDcGFJVU5WZGRaSjZF?=
 =?utf-8?B?MmJUeTBuNWVDTEtIUHlHU0tnWnEyTVFleVhqdEVOSXFFUzA0bGMyc1FIZU9D?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b232c3b2-2adc-468a-e31b-08dd91352bd0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:12:51.2294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXSdQteL5vpUOKjS/K74XG3ULzmjvdlaRT3TF7Oh8RcWMe3BUsdpw/VdP0X/zWl6Xx5gi7R43plM2/nvLgrVnr6iJzmC7ab+o/kZ2U/1G3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
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

Hi Tom,

On 5/8/25 12:08 AM, Tom Rini wrote:
> In order to easily document pytests, we need to include the autodoc
> extension. We also need to make sure that for building the docs, CI
> includes pytest and that we have PYTHONPATH configured such that it will
> find all of the tests and related files. Finally, we need to have our
> comments in the test file by in proper pydoc format in order to be
> included in the output.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   .azure-pipelines.yml                    |  2 +-
>   .gitlab-ci.yml                          |  2 +-
>   Makefile                                |  3 ++-
>   doc/conf.py                             |  2 +-
>   doc/develop/pytest/index.rst            |  8 ++++++++
>   doc/develop/pytest/test_000_version.rst |  8 ++++++++
>   test/py/tests/test_000_version.py       | 10 ++++++----
>   7 files changed, 27 insertions(+), 8 deletions(-)
>   create mode 100644 doc/develop/pytest/test_000_version.rst
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 5e1938b05262..9c136513bb9e 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -92,7 +92,7 @@ stages:
>             set -e
>             python3 -m venv /tmp/venvhtml
>             . /tmp/venvhtml/bin/activate
> -          pip install -r doc/sphinx/requirements.txt
> +          pip install -r doc/sphinx/requirements.txt pytest

Shouldn't we force a specific version of pytest like we would if it were 
part of doc/sphinx/requirements.txt?

>             make htmldocs KDOC_WERROR=1
>             make infodocs
>   
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6f11331514b8..7aadd5d8b735 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -164,7 +164,7 @@ docs:
>     script:
>       - python3 -m venv /tmp/venvhtml
>       - . /tmp/venvhtml/bin/activate
> -    - pip install -r doc/sphinx/requirements.txt
> +    - pip install -r doc/sphinx/requirements.txt pytest
>       - make htmldocs KDOC_WERROR=1
>       - make infodocs
>   
> diff --git a/Makefile b/Makefile
> index 15c7e633b874..bd136a48982a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2448,7 +2448,8 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
>   	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
>   PHONY += $(DOC_TARGETS)
>   $(DOC_TARGETS): scripts_basic FORCE
> -	$(Q)$(MAKE) $(build)=doc $@
> +	$(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
> +	$(MAKE) $(build)=doc $@
>   
>   PHONY += checkstack ubootrelease ubootversion
>   
> diff --git a/doc/conf.py b/doc/conf.py
> index 3cb9b2bb65e5..84d028feda83 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -48,7 +48,7 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                 'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>                 'maintainers_include', 'sphinx.ext.autosectionlabel',
>                 'kernel_abi', 'kernel_feat', 'sphinx-prompt',
> -              'sphinx_reredirects' ]
> +              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
>   
>   #
>   # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> index 435d84fc619f..ca45e157d3be 100644
> --- a/doc/develop/pytest/index.rst
> +++ b/doc/develop/pytest/index.rst
> @@ -10,3 +10,11 @@ General
>      :maxdepth: 1
>   
>      usage
> +
> +Individual tests
> +----------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   test_000_version

Can I recommend using a glob here to avoid having to constantly modify 
the index.rst whenever a new file needs to be added to it?

.. toctree::
    :maxdepth: 1
    :glob:

    test_*

for example, c.f. 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-option-toctree-glob

Cheers,
Quentin
