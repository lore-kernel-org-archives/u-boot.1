Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19898C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 11:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7347982BF6;
	Tue, 15 Jul 2025 13:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Hu3ULeL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24F982F6F; Tue, 15 Jul 2025 13:50:20 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5668277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixin+h/1UC9RSFOw5/WAWzNqnc2oAKIaRv8IhzWLx3uAk+DNQFgkdaf9DICrwM9uE+eV+GA2Lnh8vNisfdIObrga0nNbcvjAfkRk8NLQ/4wXOIfZccsHjpsds3XiBJor67Sbz1qaljTi0SfqC3SakQScQ/twFIJI+/YOc+ASxs3DxY3mYyq7hJaiYZvwJe48cEJGBqPStXh2KRRO+DHnoynEr93FF6Qeu6PqYFrFkGEY7esW+UIbSLJdhk7uaVIK6r90+KGq7fgCp9dcHaofrliVdYP4bX/0wnE72bbVxz1bt5chxrEGuz/bOq9btTADdTpyC6h7sP24Hg3x7gQ8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA9+b9P8S4v5q4jbK6+e8Z+HBCbEhS8DfH4jnqAFIU0=;
 b=Uao0Ss7+Y1Dt6QsTuv4SPbVUTcFNY1kwjiHkEEYhFJGroGnYumWLfvUoQsmyKJpbQ56SbECBIkXYiBLJVgDSgXJAcvMeiDqKrLSTJjN4BoUX31X3SOswq6nlLb9kBRHPzzPHmyITRCCE53CrTr7bgYxYJCP7BpKCXaCmfp2P6MVQg1zlNNM+Tu4epnsnhAikBEn9wGl+BZ9TcqeLZQAXEDGInG3TaI99vrRfdOXTq8nCC52D4THYk+ohJ2muV1H3ZMT888PEorOZvXcfAig5RGNc/D2JhsiaTgPSX2D7Od1P0qHPyuwa5NYSpZmttDdsMH6N8tch4RtMLEswpHHnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA9+b9P8S4v5q4jbK6+e8Z+HBCbEhS8DfH4jnqAFIU0=;
 b=Hu3ULeL3VZLsA2EH5VbJy0Pc08uJjfD8dL/t1zA1+UhcxTCT4J4jorZoc/8qaZqo7uwXw1mHaOkgkI5vL+AY/mOr49aHbtbegbhFRbWxH2jNXgqfsWovRHReUQXQwLYTqNJGZMkje5/3CMpofFKAnMxyxwL94rmOUMQGipGdcDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 11:50:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 11:50:16 +0000
Message-ID: <400621fa-0cc4-459e-82a5-4d1b0fe8982d@cherry.de>
Date: Tue, 15 Jul 2025 13:50:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm: k3-am65-iot2050: Fix invalid default
 configuration reference
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, ravi@prevas.dk, sjg@chromium.org,
 jan.kiszka@siemens.com, baocheng.su@siemens.com,
 Aristo Chen <aristo.chen@canonical.com>
References: <20250715025307.2013-1-aristo.chen@canonical.com>
 <20250715025307.2013-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250715025307.2013-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:802:2::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8df565-aced-4871-a214-08ddc395c3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkZjTWc2c2ZSb1RHaytLbXNnck93bDdtMDYwa3Fpc3NBWGU2VENVVzY3cVJw?=
 =?utf-8?B?Uzc1QThhVUJvbWpGd01XOUorRUpGYkEwMlNLTVZCNzlZU2FqbUcrREpPZ3Jq?=
 =?utf-8?B?ZGxPQk9NMm1ob1JDR0tiZzdQeGw3SmRWYjV3RjJZczBHcEllV2xXck5uSW1l?=
 =?utf-8?B?TEQwNDd3SHJSSGFFbHRrRGc5ZVB2WG5peFNVVHliTGxWd3BTdUY1ajh5RWxZ?=
 =?utf-8?B?WDY3eDFpSEE0cjdlR0UxTjdjRWxsMHlUa3R1N096VHlvUWhpUlBhejlITVov?=
 =?utf-8?B?ZGlVdk55Z1Z3M3ZEdUNxSHFCNEZwSk1hQ0JBNHZUTlFENzVndXM2RzZmNTVi?=
 =?utf-8?B?akVxd0o4Y0NQeEgvNXdQdGtVWTJwMGh0aThPSklJOVRiY2pDQXhGNkxpWHNI?=
 =?utf-8?B?RExvcUhmQmVwdzcvclJmRnRXNEt4aDM0M2FEbEpGTXVFM3dyZWp4VTVCV1ZH?=
 =?utf-8?B?dWN1Wm9KOEpGSzhNcXo2RjZmTHMxc3M5MU5ReFRaMWtGMXJjRko4VllBZUpu?=
 =?utf-8?B?amM2UW5kNjVVNmJXbThjekNIYmVkMDkxamNIQ3YyZDA5Sk5iK0lTN0l1RUdF?=
 =?utf-8?B?VW0wNzA1WjJyZ29HekF5ZEpxNjRMeURJMGxtTEwwL1ArME5GMmFhZ2lvL3dB?=
 =?utf-8?B?NUt4M2MyUk03b1JwRmVhcnQrcUhibnRVT3drY2JZb1ZuS1JFbmZTc1RENS9W?=
 =?utf-8?B?dG50czAwdXNvSDdXNWx3bnZaT1grQnV6dWtFYmJaZVQ4WXM3ZGhCT1paYk10?=
 =?utf-8?B?eEdFQi9aaFI3endTMXVDc3VDMkRJTzBFK2l2NGh4VGt4SndSU1dKSC85ZlVE?=
 =?utf-8?B?RVFIR0FzSG9acVFoeGo2a2lUN2cvV3NrcU1wTE1QaGdmUmRBSGFJTEZKMTUv?=
 =?utf-8?B?YXpmRXNwbXB4dTNDYzh1V1lyUXdrdFVtODhEZk5WS2lDamdkOXJCZTViM29q?=
 =?utf-8?B?eEpjbkZMTFREQUwrN1BWempUMXZqdWhsNWxWWDdZK3ZsOU41RjlUcnZ5OHhI?=
 =?utf-8?B?TFFUR0phcVU3Qm9GYTIybXFobnQraTRUaDBSK21UOEpsQnp2MExjTzVaOS9y?=
 =?utf-8?B?VnZLYVpKY2k4ZGg1ZEhFZjRHUy91R2hzeFRZL0dlaklvcTJiS0g4bllCRGRU?=
 =?utf-8?B?dDBSUnBLSHR3alFMVy9mSEZ5VFNpeFBham9Yd2Z5ZFJWNHl3dTd5c0ZWTzhT?=
 =?utf-8?B?MTNVSzIvQlBDRXd3aXFvbk5aUHNKWVFSQncyQ3FBcDNUSHhWeVdrR0JpOWdr?=
 =?utf-8?B?ZUgxOEpWZHI2VnltVXl4cUdiT2hTMitneCtSRnBVdkx5dHN0MFE4MUVCTklu?=
 =?utf-8?B?OHlOSVoyUkFoYkhpZ0Z6OFEvTzRuNis3RDM5dGMwTHN5NEpoMlQwRXI2VWRE?=
 =?utf-8?B?dlZGeUJFNFBzNk1nNHpxeTFVR0N6OEhkcW8xckZia1l6SitRd0U5SmlUVnVs?=
 =?utf-8?B?TzJBTzc0QXdMMnhpM0dyMWxxT1BNUUNVMzNOdyszVEI2aDBIcENTbVBsdFdO?=
 =?utf-8?B?LzhWQjFaSFY3UG9SUTVoL2JzQi81aE5MTUV4T0w1THFiTjNvc1JDQ2M3M0dJ?=
 =?utf-8?B?NEV2Z2hJeE5nUFE4SmMwbUNpcFlhUHpUZlN1a0RvRkFaZUFqL2kwbTFyK2RL?=
 =?utf-8?B?amlUMHR2QnZLQUxjRjh5N0J5YTlrOVBHcmlUY3hoSGorWk9LRGlYK1RvTHNL?=
 =?utf-8?B?VExWRnlvb2dpMHNLV2lSdlg4QmdKalhkeDI2NjBUeGpZV3NsVTFFYlBtbDAx?=
 =?utf-8?B?aWRUbHZEcWRvOGtwVE1ISUZsSE5JckhLYmVORjNIcU1xVVNDS1BBWEJFWWcx?=
 =?utf-8?B?ZDNXc3NsNlR3SDQ1OUJ6Q0pISGRmNHFrYlAwektDRDBOTXR4VHNTYS9XNmpO?=
 =?utf-8?B?ZDM3cHJwSTlpWkpnZCt0bXdUa0o1NFZoN3YyZHlCQ3NRd0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlN4UitIdnRXakRXb2tDMU1aSkwxMjhPeUNYdUtwTXFvUTNwZUZWQXBaS1VU?=
 =?utf-8?B?ZDkwQmRPQ0N6aldkN0FPODhOZnJHYkFZNDFwelJXeWcvaDdyV205R1g5SG51?=
 =?utf-8?B?NnRya0JocFJWbFdKK3A3WUlOd2xLZE5EYzY5MkxsenZqWDRNc1k5MFVyb3k2?=
 =?utf-8?B?dGluTE0rMkxyOFZ0TWF2Sjg5eUZ1NTFTUTk3ZFNEME5iaTg2cU1IZi9wR1lx?=
 =?utf-8?B?OTVudlFDaStJdVZ5ZXQ4YmFJQUZGUUlnbEk1dlJhZWNGYnY4MWs0b1FMMDJp?=
 =?utf-8?B?QzhYM1YvdXA0bUFEa3dWSkNyb1VublF2Z3ZGRS81YnhmNkRKUHJMN0ZhSVpC?=
 =?utf-8?B?ZzdIUlhmTVAwbjBRbk1VYTNGcG5PU0dkeUlSekswbGx0OVBBRDE0WEJ4cGxy?=
 =?utf-8?B?SzJUUzk0eitIdGsycVR0dTRQemdVWkVncnVaeVBsSEYyVExubk9HdExUS0s2?=
 =?utf-8?B?Z1JCdDhSTXRCYkxoZnE1NnVWWjdpNUNGOElRZUVKY21CNXY5a0QrMURmdzdC?=
 =?utf-8?B?NmZpS3U3cUNTYXdHV2NTWm5OR3Y4eHpubnB4aHFWZ3BtZm1wVmpLK016Zjcy?=
 =?utf-8?B?NlJ1dmFPYjhyZG9ROXYwYUFSbUdBWVhkWlpPaW9YVmErUXRIZkk1cTVMUU53?=
 =?utf-8?B?STE4WEVEVTJUcEpOZXdRdTY1V0xaTWFUU3lmMUdnRjBLWWVJWHV2Z01WRW9F?=
 =?utf-8?B?ZDR5ZmxKZ0FsL2xrUUpHZGZQWG02OEpaWjNjSUF1U1ppbU4zZE1EYkt0UE9a?=
 =?utf-8?B?S0NSSFM2REd1aWEzNXdYdFlYK1pKeFF5cGc0RDJTbzA1b2M1MkNVbitucnhG?=
 =?utf-8?B?VjRQNFQxT0wwekhCRjJzZ1FpeFlxUnNMYnFBVDM5cHNFMWkzNEVaYXkvbEJT?=
 =?utf-8?B?ZjdmVCsxa2lLSmxLdkszSUthUk95c0lWMXZwNUJlM1lBTXNNcUtkejZaaUVj?=
 =?utf-8?B?VVNjTjNQcXpOQkY2dUhtQXV5bzFKdHJsMkQyZ3RiVW5qUzMrZW12aUVaejVE?=
 =?utf-8?B?N1Y2VUVHd2JBRTJEb0pHTUJ4V1hwcUxDMlBBVXYvRFFsYytHWldyTmRvOTlL?=
 =?utf-8?B?Z2F2c0hONUVFSlJmV3Rzb2NuK1NtNEVNSkFWMCtyTnNTTVFVZ2pIc0Q1R2V3?=
 =?utf-8?B?Q1Z3UWdpTmUvZHkxOWZnbEVJTURqNkhiRGxBL3hHM2dKWlNkM2IxVGFYRTly?=
 =?utf-8?B?K29FMHhvUVowYWJJYUE4VDg0MXVDcVMzNWo5YzZDQ2VPVTVZSGhjbUwzRTdO?=
 =?utf-8?B?YjJ1M2NnWkY5cDBPdkh1T1d4TVJCNUFGcXBiakxPSEpEVzVESVpSU3dkWTgy?=
 =?utf-8?B?UnBPaHN3SERlTjNBZmFBRVlnVHJUOWNicElxZms1bWg0djBrWWxCOXhURldw?=
 =?utf-8?B?WWdtS3dSSUc0WlRueElSNFNOS0pYZC9UMzBuZlRidDRpU3ZkQURoeGZxOUxk?=
 =?utf-8?B?cWNzcU0wZnU0aGpvMzdUNG9BK20rMnlrQmUxbVJKV1Y4SGxKNGh1aDA2WVdL?=
 =?utf-8?B?eDBuWkZvTGdLaHdqdWtVUVkvVktRU3JDazhLY2premxjRUx5Mjk3Uy83VkNn?=
 =?utf-8?B?am5PQzgzdGdLaXVIS3BFaFB5Uyt4eXQwbEJQNmhNMmtVVk96Ly96bE5oOXhV?=
 =?utf-8?B?N2J1WWxwUEVMWXcvZWRpQWJYWUE3ZTVjT2owNjQ4OWttVHd5S3UwbUhNRk5r?=
 =?utf-8?B?VzcyZkM2bk9TOFVyUEwyeFR1bFNwSzF6cWltWUJCem9jUjNwckFRTkJDQ0RP?=
 =?utf-8?B?M2p4NjFhcFpLQzAwRUgrRFJFYmY4TTl3WDQvbmY3bUNUVmVwOG4wSWlaMU1s?=
 =?utf-8?B?YzU0UWE2MUhES1JPbHQ4NDk5K0pCK2lKTmhrUnBTMzJNVExNb3c5REVOUkll?=
 =?utf-8?B?TmljWlpNYkVUZmdxa1d6Wkw0RHpUSStDbDdRLzRucTRtcEZnbzVFR3JsdU1H?=
 =?utf-8?B?dHQrS00vUllHKzI0cHkrMCs1OUlINjNEUThhL280S09DKzJ4M1BHdUpuTmV0?=
 =?utf-8?B?bjVNbmNJbjExNjNlTElBY3NFcHhPb3krazdsc3NCSUZnb3ZJeHo2ZWord2JW?=
 =?utf-8?B?eUM1ZWk2MFNYVmpDMlhrVWxTSHp5T1FVNFhLRHdXYlExRFhhOTdibEljeXh3?=
 =?utf-8?B?WHI4Ry9aQmQwU2Nad1ZGcmg0dFNVV2J6TmoweTZtYjVxOTNqSVhZMTIvS0pI?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8df565-aced-4871-a214-08ddc395c3f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:50:16.5996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVKn1oTImg/+rebJkw3b8a1dsd599QyYBsAN3CPZnOaIxtw8ncFgcXA2RjBBZaX6B97/koccHmc7FYVrWkgh6Ocp3/0YgypcEF0w5lQL7Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
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

Hi Aristo,

On 7/15/25 4:52 AM, Aristo Chen wrote:
> mkimage introduced a validation step to ensure that the 'default'
> property under the /configurations node in a FIT image refers to a
> valid subnode. This exposed an issue in the
> k3-am65-iot2050-boot-image.dtsi, where the 'default' property was set to
> "ti/k3-am6528-iot2050-basic" and "ti/k3-am6528-iot2050-basic-pg2", which
> do not correspond to actual configuration node names.
> 
> This patch updates both /configurations nodes to reference the correct
> subnode.
> 
> Without this fix, mkimage will fail with an error:
> "ERROR: Default configuration 'ti/k3-am6528-iot2050-basic' not found
> under /configurations"
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Please reorder the patches so that the builds still pass when applying 
patch 1.

You can simply update the last sentence of the commit log to say that an 
upcoming commit will validate the default configuration exists and would 
therefore fail the build (as it should).

Cheers,
Quentin
