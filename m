Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07DFEC145B
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEEA839DF;
	Tue,  3 Mar 2026 15:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JhvYqi4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEF683F4C; Tue,  3 Mar 2026 15:25:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5034F838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSWi8pZxuuoKi7Df0fawt7wHfpSMVDqW5Ix34Y1Kb/mQYz9TyyI3tN4b9N8fEEZi6GN+/YcvxGHAxLarGZLB/NTMp00nGA1npCxO+9YscsWIzOArHsv7YrkH28bcWtm/ekeTfTUoIstv9mFXNv+sKf2A7F+po7m2wtG8A/HGWz4JqxaN8chIGvyhYuUCb7Ducvmvp4sVld1NEOCAN5F6bANe58pthpIkZEQoWvidvyJ3KVufheDH8PUZvjFT+LEkzhAheKv6ieCVxHdG/Xo9/sLlZaC7XpEWUs9/+g23TEYhG9KkctvQlHuGCQ0suqRVmr+wLFbjQEU13LJijmmrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9uauUVhTtNEpgUwbrqTIsjszejigmH4lXkN0aA7VYo=;
 b=PtFxr6E8XmNmvO955dP08sZ11l8jSfVYgqcqkm7XF01vVdCzpodgwb/MkB/aZE9LlG+jNmw2EFG8ovPV75yHRnQ6dTh8Ut1BsKkSsmJlhkpWaShCUtiyxQKCT6MLGax2o8vihbXhRnJtF+G63Zs8wRPl4ePRAXx8nH7zA682oWfl35fjsv5W/OgnCXCAXx1J6PPhHK4O3CctsqeQ9SmI+qcREDne+Fh2Wv5yLg+GdJQg2SpxoR623tSvF9lHVNyrSkXb3y3FuZZMgHToCcMXMsCzAyuPscr49pNXs3779BW9WOaEjoSiqnHywoYiwGz9JrYgXeSjtQuqqq4s9EvA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9uauUVhTtNEpgUwbrqTIsjszejigmH4lXkN0aA7VYo=;
 b=JhvYqi4Feq2UPZlyUdPuFxAHcRuhvJq1RvrJnwvpCcwP2LMTQtKoFvcPATz1dbu/6yokv0puIhvnDJ7mMSaGQu5mOpipDzVDN3+ukPRzYDBc2cgrd6nUYQDuO4NM6kYzSvsE7aLOYLWSS4HkHpBWLu+9v9iGz7VqrcDQ+sp3lnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:25:31 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:25:31 +0000
Message-ID: <2e7de6b9-40a0-4605-be87-e826dfdfce4d@cherry.de>
Date: Tue, 3 Mar 2026 15:25:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/16] binman: test: Move CBFS test files to test/cbfs/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-9-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10297:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2be600-116d-4dbd-0091-08de7930b9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: t3raCUvEU8gmYf32ujlAuWYvuNweU1mvY5A6xbL0jO0Uzscf6FEioyO7o5YZ1U7lO9sJ/sgxx3J9wI8Xc36Y22YyfgEmkigW2L+jdosUqFJg6wH2HZIlWFg/Q5iDqaU6YKd6x7yLBeBKjginbbVub5UFNT6BesF2gR05tXpVz82LV2L34bcrLzFly5vduxTHSH6z4Sv1Dn7BmNxIOAOfAyy06bh1mcfZyPDAaBJ0+sJ7+X4b/O3qvPtdkLtWS6Wq+e3unkfvpvcXG4K/LOmAraLsOZOVG0cGARc6mqYjELkYqrYzBtvmindXIpcAkOzy1dZWOs0niruahJbYYU2JgiJbWOkL3qsHGoC1uWLKiEKsHKru5uFwHHmaLeIohZ5DwNzXQz7BG6zwVdhzOzLvfl/b/nhZVRsmKjR5UrzDTxdaLAelmXdN9vCmfT+Rw9QH8ZYzBSku49zElp6M9Rw3Hqtp/x7fHLkc/HuZpybAyxvs8O5Vq7bGYA79AsAbm31LLi7Nxqh27jLxCIFrxT3s12giskpmG3wUqAmWMuWPSSZGX32uNXObVCHwbfPMHBfUixgE7A8dG6CylWlW+pVKbUZgyXnI5Hx+T7ePgKviFc3SspNUwGyo/cOYWSQEyatb/MA4EXK6ob4sxGizYtwf3DJfB7WKGI2+f6eindWqEVBBLPu2FEJ2Wj9XDkj2EghLNiF5FbmWfdhD/eAA0/gmJbUyHmw6tFwajV97PF8Ah7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGR2V2ZHazhoenh0azJpbGpiNGZLZDFCYkJqcWUxQ0JYTTEwTkZqZjN6RnUx?=
 =?utf-8?B?ODFYQUo4VXVXcVNaVFA2b2E0VmU2bWs4Um1MU3JLQ1pob0JFOWY4R1VKdkVn?=
 =?utf-8?B?U0NveHhpeWRaN2pUZ3paTzgrTDI3RlRqaWtBdGJLcnk3SWRKR1N3WGI3b29r?=
 =?utf-8?B?aTZST2o1dU9kSDd1UFFrL2ZBdUJKODJRWU9BaGorTU82YmxKMGZvaTZaWGFE?=
 =?utf-8?B?a0VoN0FUM2E5WWRGVEUyVUhtTVMvdzMxMWZ0MGxtb2dPQ25WbXp3RE11R01Y?=
 =?utf-8?B?NXZPMXRMdlZlcnVNUFdKbjlNUDN4Y3BEWTdtdlRsOXhoK3BaMTc4MmJNMXd5?=
 =?utf-8?B?TFVEblRjM1RNcUQvcnJjRDdscUZhN1Q1bFdxTUtsZG5OR1cyWUVaMjV6VitJ?=
 =?utf-8?B?TUJjMmpmeG1SSFg4N1hCMkdKaEZWRnpkYmhkZU16dytaaVJvUDVVRE9iYnlI?=
 =?utf-8?B?MExlQ3JjaVVmSU9nZUlscWJjVjhiNTJKTER3VU1nbVFFV3dKT3lBNGRFNHox?=
 =?utf-8?B?blRTV2ZrejZud1U2Z3ozREM2YTQwM0NBV1REa1cwQ0Y3QjVFTE91ZktKa1Vr?=
 =?utf-8?B?TkVSbjhEY0VpYjZpQ1BTdVJLUXV2SUszTCthaStPbHVkMkNJNUVTL2NucmJ6?=
 =?utf-8?B?ZXFudXduVzdPcEh5M2lwWlVrNkZEajI4RWpRTUFkL0NRcWlreHFtRVZHTnZV?=
 =?utf-8?B?b0ZrN3pCVkttOGxZYzNwU0tjeHU0S1Z1V2N5RGl2aGh0M1J6a09BQS92dkh6?=
 =?utf-8?B?cG1RMjM1ZjZRdGRtUWNSL0lyNjUxb3V5cDVjTWRPOVptN0VXT0s0NDgweCt4?=
 =?utf-8?B?MGhjenE1eUZjYVpRdzZFTjRuOXl4ajR1WTA5akFlNU1IcFFIdVc2OFo3U3RI?=
 =?utf-8?B?KzJLa01FYlQweHNPRXJ1b2hRL1JOZzZ2eTY0TjM4c2p5WjRZNjJWeVpLNVgv?=
 =?utf-8?B?cjMweG43TGhZb2cxbWtaTGozWGRMZURtMGR5bkJYem5kZ2tPNkRrSlYyYjh5?=
 =?utf-8?B?Nno1V1VpdmdLMGJHbzRoTFM0ZGxWRlFIVDFDZGZaUXlUenE2UStGK05mMmdU?=
 =?utf-8?B?elFRdkc3YWxvcURCVTZCS1gvL1hsSWRtSGM3d2dwRGloa0dEU2ZQZ3I3SUtY?=
 =?utf-8?B?SEZwVVV4UFVCV3h4MXFTQ0NrM2pTbDVZSnpYU0tLV2tQT0czaFN3U0ZRdEJW?=
 =?utf-8?B?R3YxRk5xTUVFYXJMY240SXdCby9wRlRWSUllaWk4clRXcW1ZNUlWSGd6bmVp?=
 =?utf-8?B?Ty9kWHZpTjFGNWUrZmhoM01FYjRmVldnSXl2dXc1djB6UEU2aVlxZTJjeXRQ?=
 =?utf-8?B?bFpPanVUdnAvRGJrVENxcGJBa0RMYlVZZUxsM3lpMmV5ZDNiTmJaNm5wMDIw?=
 =?utf-8?B?T21sOE5IcDVYWElVR2MvSjA3WTVhVWF0eTBqcU44eWZleEtTZEJpTDh3TUFV?=
 =?utf-8?B?aWtjZXhhdCtDc29PVHNxeU9mQm5wOUc2ejl6TUFBSmhOL2xablZqdEhJYjlS?=
 =?utf-8?B?YXdVN3dXTTVtc2JaUTJuNDJ6VjJxTm5vWXZUTWJuZkdmVHQwa1BzMFBDc2lZ?=
 =?utf-8?B?K2IvV2JhK1h5cU9leGF1elVpZzJyK0psOFdKeUZjakU5Wmx6UFJNY24rSlRB?=
 =?utf-8?B?MlQvQmdRdEx3N3JYUVB6ZHNNb2paVGpaR3JJL2E0QzZ4ellUODNlZlM4UlVt?=
 =?utf-8?B?d1dCQzdvVTVkNFRZYnBpbnp1QnN4UEFoQWFIZTlDMDFWVWdsVGx2dDFkL0c1?=
 =?utf-8?B?TjhkejNRYkc5WXFweGZRa3FEUUU0TFh4UEZYcjJQMnZRTyswa2p5bzZvQnRh?=
 =?utf-8?B?YUV5VVhQRGQwa1QxSnRUQ2tRcHhaRG9pdVYza2FHMkMrVDhacWhrdThUeDFv?=
 =?utf-8?B?eEhsOWpNa1NjK2tjaGpDSitIY1FjZTloR3dkb1VqeTR2OHVCT1NTeVkvVzQ4?=
 =?utf-8?B?b25DYjc3SFU5QUJpTUJaTWhNcFFJb3hCZGQyNDdrZE1nK09STXFEUGRSZDIz?=
 =?utf-8?B?TUxieU9GTEx1L0t1NGhxbk5tVkZMOFY3REZaV2VFenJYN1VNSVIvbnhVS2U0?=
 =?utf-8?B?S1kwNlNBZkhlUWhZdkFMR05oNXlhM1UxY2ZpWUdKYVN0RVA2dEdxcE5vNUJB?=
 =?utf-8?B?N29JcEFvOWlhSDFlRFVpSGVFdEp5dzRJRjNBZUIybU5KVUtEYTgrS2pCVjlY?=
 =?utf-8?B?VnAzNjlwRVVveHpjNkpnWGMzdUdQRDAreUtzYXZkcFM4WjFXRDV3WHovdnFB?=
 =?utf-8?B?WnZwdGllcmdtSjZkMG8zdENxKzFPMUIvaWFrcTZMbnVvdzRCZzY2WTJ6dlR1?=
 =?utf-8?B?WmFoNU8zdHZEL0V3eC8rTjBjU2U3MU5tM1NlWXcwem12dytCVk5yQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2be600-116d-4dbd-0091-08de7930b9e4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:25:31.8738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+zSwHkxA94LLLV9dX9jE8S4Vvre43W2WdXy/dZ5NrwsIfttS4chh6FOSsscy3FfkOQOKBRv+1i/YP8HHIqNadUQSxYmww8tCk2TcOtxyC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about a dozen test files for Coreboot File System entries into a
> cbfs/ subdirectory. Drop the numeric prefixes and the redundant cbfs_
> filename prefix, and update all references.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
