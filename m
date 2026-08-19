Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC62C5DF7D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 01:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6959180E9A;
	Wed, 19 Aug 2026 01:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIVpZ-fP6W4I; Wed, 19 Aug 2026 01:16:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787102217;
	bh=fFNlwDSP27FqU7uc0v0ssrmNUTy3bGHY3peRk0ssnwo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ktfO5DVkUInnYFf/Uup9LdMMBKpuk6cv+PfTh0+6FgfuSstMjofYGpjaf3fL8MHak
	 YQEEpCyCjnVhzDMgFes7GOh2copeL7EFrSkIrbxAtKQtu/RaKAmRMSveRMf1WUJArH
	 JGAWmzZT8BEfXfCol2/vBwDPFtQ2X8r2Egzd71wpRmTRLrVjQEXUbmBzA9zeHpVqdJ
	 D3S5DBOQSpxoQyD2F0PtNP/CDmchvZJkOUZ+O0EcAAU2Q/kqz5SiIJGpjR3wRJrLkV
	 9vf5I/YGxi9TesXHg8Ad4qAQiw2lIvhfenNH9yaFkfZwnsO+kGMAYKZqKoXaleiu04
	 p/x22nLemO8zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A594280E8D;
	Wed, 19 Aug 2026 01:16:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD07B40B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 01:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B23634065D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 01:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-27viy8tU-I for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 01:16:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=w4iiRc1n
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6666940633
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 01:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL4QJDMdbRoNRIhVuCwJKRcefFCNRi6r+mMM2T+zX6AnmXjgFDdrFPobUotdGaDLh42VEFXB2IBde0i2fgd8pP/nkOCaC+kEdeRBUkSS0PFX8eAYe2pVTnfoe7FWzbt7VbvxxEuj5pGE66VNISBTypkqJjnDvbjbTc5UZ811RNEA+WbpGzCDSJJKOdaMBQFP+vHCihdY3dmDGKquZD1wOzCHc+6/qX9BYkU8zoVYv4RkQgxWPHwflh2RNFLc5gEnDGfe7OQ1H5avGAGna9iPlyrUO53njk792qSAzAUVxigWng5qFcDnWdSdXhVk32eYm00gzyPSzL8lLPgkzdeAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFNlwDSP27FqU7uc0v0ssrmNUTy3bGHY3peRk0ssnwo=;
 b=ZPwr9UYhLLlGluVNjTaiyP8ljd/qJcAAbmRqgQHdy4js9mm1a5k9iDNvgPr6JtYRIZb4qlj4mo+2Kfb99tdl6ojg3OiAQvv4lm3S6KNtc1mZT8vABfnFT+OH4Hg1OqrS3Xi2tsL5VbvMe+M+Id+NEtwE/n9ZNxj5dRRkLVeyGSnexN+t63oiRpzmn7PSRcJzCipWIzowoBMMPRRSC6QS0Mq5YZ0VE0C38JeQ45RiUVA/bjaYmuNoyVCEb29Qy9fXShqD/MiqZw+Wkl7dafLF00Goc/6wS1AUB0selBhwQVKtbhqMLmQ2qfawwYFen20hcXPFeepoLc2rI9Y8mWXoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFNlwDSP27FqU7uc0v0ssrmNUTy3bGHY3peRk0ssnwo=;
 b=w4iiRc1ntJz4CeMy3EWbQauDf60+4gHAoFaWdL5r0AGSh16COQrmElZOQJrHOTuFmQWiIpmEc44t3XvPIWIBnpg3+Da9yCh8HNtQIEqIU98d6vWbu5KULvxDN1gVMhaFHdQuY/aeFdaLR0dm98sMp4fcaQ//6vAOujTtSoHA4LBRXcKtUlOdzHZGR7qtAe5FytNiqqLv42S1AcfBRG+YjbJHrJmbCTTJnY0b58cYP3urXYBNiESyED8meduV5iwCEDA/FK2qUUzSMLmy/nb1v6zGAYhFpq4pSCnjCHepUB3koCaiEVxEucVFIzGimOGQTuS1OKfst9t11AVsftVvxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by BLAPR03MB5491.namprd03.prod.outlook.com (2603:10b6:208:285::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 01:16:51 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%7]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 01:16:51 +0000
Message-ID: <83d2b4a9-ae55-46cb-9dbd-9d603fa1ec94@altera.com>
Date: Wed, 19 Aug 2026 09:16:43 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, Brian Sune <briansune@gmail.com>,
 Tze Yee Ng <tzeyee.ng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20260818201715.GC523975@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260818201715.GC523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|BLAPR03MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3037e9-e8d6-4259-d327-08defd8f8c5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|56012099006|10067099003|55112099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: a7kBOfy60IbZAN4qMOsOCs3T5nss6Esr92Zsh9wo9Z0kWlHmYneRhNnKMY9oKndOyl8yMlbH5AzR6ZpW99rgYryFgEAAqFA/fIA87kZ+Zvyz3vls968N3NjqLmbT+Lx0qpEnRgSJ09TA2id0A1ab8PRd+N1QMBnzUtWK3UCIoWIK94q7W82g/rzGFYh++c96ZdY9qd6wHq95pKcaNvjuS4zEG83YOqfZPEqW3Z3AuJEquC2tFItfA+3MN2lbNFwFufN9fjqhzXP57vJ4Ty9Axn5hO/mZMYfKBNV96AkJnW58N3glfiqafGgZjf6Hgr0dKIwKUJd9LaWyR45vKByxr4BP9U4zbCkaS1PC+xkOZtQnr8lRcaGf6j6E700ajJ0XBkJXGz/NClORsGIRQ+7J3yQrhSiwvALOEBXonulh6PUzTdvtHgSvy3P5ZoF7HTSYgnzEyrX+qUlmI1vN5xbhO02smQz2x1iSHrT/5MZyfqptOlAE71jWMMwS3p0BwE7HWFe8SBLICIJM0OWok5CemVcLcC/WT6W4U3NcSKznIQgeRVbKo03FIsMbfZ6LzEnSmK434UUc106EX54jAO42Ebqa3VGUvjQLbvrgUuTdsIVjerS93I79Ef/8iAdB06MA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1M0cUxQTVFSK3NKWVhvRVppUndYcnlkd3R0WkNVdHZRSEd5elNXTldsZFJP?=
 =?utf-8?B?OGR0UGdqZDM3dWlmdUM3RUtwOEVML2k0SlJDT0themZhazJPTGFaeFJwZVF0?=
 =?utf-8?B?VEFZT01zamVIV09qNU1tMmJqWGM2K2kwUG9rSVdYMnQyY2RTSUthakZXQk11?=
 =?utf-8?B?VVpvbStGOFhmZTlpMmJuWE1Oc2ZZd0o0MEZTa2YzUHNFakdWZW43dmpqakc0?=
 =?utf-8?B?UnZwQnBpM0QxL3IwdFBKcU9kZ0VUUWdXTU9GOXZIbFdnYjZMNkdqOUVaM2NE?=
 =?utf-8?B?MzltRVBMQk1YZzJ5ejFsV1drZnQ5UDNDeEJ6YmFsZVZZNGZxb0xadGpJbHJl?=
 =?utf-8?B?OFRqckhUME5RVzdwTk5KL2tZUDE5OGNJSTdEckFsd1lodWtQcXB6K0JKNncv?=
 =?utf-8?B?UVZRRFBUMkpHMkhKNWR1VEQraFVhbis1UTVmWEZudWZYM0hOakpzTmZDNHo0?=
 =?utf-8?B?SktKamhjZzNzUGl4ekpwcXVEZ2o5RVV0WkFMeGJObUcvdmF0RXl2NHRGejRT?=
 =?utf-8?B?QnFGL1R5QkRpWmtoMVFuUzlqN1lvYzczTzVPWUJidVlEVk83bW1LVEczamkr?=
 =?utf-8?B?SlhOMzVXSHlLY3BFU1YrNmRLRU8zR2M1aHdRUU5jM0lOdDVnNzRmNFlaNDFO?=
 =?utf-8?B?MjdQbUZ3NWUzZU1JL0FzeFhQd1Z6NHVFNm9lTjQwbDloNHVrK2dyK1VLM2lU?=
 =?utf-8?B?d1lSN2hRem9hOXhKUWlvaHZSYVlGWDRCRTdwYlF4UzBmV1RwZjRMaW90eVJS?=
 =?utf-8?B?SlRuSHJZb2FRcXRzR0dWMkdYRXdDQk9jWFdVcTlnV2hjZ0lGdW1jNTZWL0Q0?=
 =?utf-8?B?Z2c3M1d1Ni9oNUhQdUFGUWRqTzdZSU1Ca0gzWWltb3dYcUNWbHovcmJNVElT?=
 =?utf-8?B?eGoxN0VYM2pxM1BhYXRyc0JMMmU2SUpQZXhlSGxvdUowVVYyeERlTUhLamxS?=
 =?utf-8?B?OUdtN0xuM2g5Snhlell3bENNTWw2OEpJV2VMQ0oyNkYzb3hKbVR5TWZLcFFh?=
 =?utf-8?B?VWpYMlpZby90RC8rSTh2aVQ3dHBnZ05sY3hXWm9ic1Q0NDdCTUZUdkxsTTNM?=
 =?utf-8?B?ZGNrQjlvVE5oVnRrVThEQ1plSVE5emdwQ1ZHaEVXZ3RpVWRwOGJKYStnSisw?=
 =?utf-8?B?MjNYaUxWQlhwcVpOUnptcG94Zm56TVBBblNabWhvcXNnbmF5WEFUS2Rnb2Ev?=
 =?utf-8?B?TzlmSjZzMXB1TjlWZzNZUEZMaldwenREK1FUVVpSaHNqZS8wME1keGNaeTRT?=
 =?utf-8?B?S2w5THh4TVVqNEovSXZHcDFZVU9YRVJsemMrTlJ4dHdGaHU2bm5ldWVWQUpn?=
 =?utf-8?B?cFZsTy9lUTRLUytVK1NMN0l2MFBSb21Da0gydG5kZU1SU1A5Sk92L0lKenky?=
 =?utf-8?B?Qys0Lzc2UUxyeG5udkEvUXltaURVMHNpYU54TXlibmp1VUVTTEpoVWxUTW5R?=
 =?utf-8?B?eTdIRld0VWgxS25rM3pHTXhQN3hMSmFHVlRNVlc2OFhuWDhaOFRZYkN3a2g3?=
 =?utf-8?B?cVl1aFNjMXJDTWRxTEp2a0llaFB5WW9UWHlOUnQ3UnpodmYxSGk3aUtKdFJM?=
 =?utf-8?B?ckdBUUU3Mk1MZUN0ZDRwNy83WWc2enp3MDZIMzh5OHRZenNOYWtnRWlDRm5K?=
 =?utf-8?B?bnlSWkxta0p4OGd3ZXR5eDdmTVV5NzVvQXpFQXhvemhCejFlcXlaWisweXRM?=
 =?utf-8?B?d0gxM0ZCam5XKzNDZ0xNclpaaDRTWG1kUjJtb1RyazhjOFc2a3A0RlM3ZFJO?=
 =?utf-8?B?WGxDdms0T1dOdEpLOGUrQlAzS0dLaFh3cGZGZWl3Wm1XUHM4eE9PWWFNSUM1?=
 =?utf-8?B?SEpmd21CcE1kRzFYdHZTOEpiMW5zbkprL3RkckFXbmM1MFF1SDJJYUVKakFK?=
 =?utf-8?B?dDRtcS9yL3NiSHJhY2JNMFJYc0U3bmdpampxZTdkOE5Pb0MrSkUraVBHcThj?=
 =?utf-8?B?MytHSFdGajRpN25VSyt6UFUzOUFhU0xoU0VaSjYwaWhEOG5wY1hNZXdTeFJr?=
 =?utf-8?B?eFZlUzJjTkVHZ2FOMnA5b1NHZEVGMWxKT0U2dTc4bmFzdWF0MGt6MzZ4YU1G?=
 =?utf-8?B?YUdFVC9sNVJEaXJIN0owOHp3b3FDTEpZTDJIZ1B4NDYvb2huSWJjSVgrVmo0?=
 =?utf-8?B?clpoVzBJQjRqM3dPbDduOUZmcHh4VytCWVhSNkxBWCtpMmpJRGZkS3FwQnc4?=
 =?utf-8?B?TTlUbWtrRUw5VDZvS3F4cktITDNmVVlRQUpHRmt5WjZqMTN0cTJUSDJtM2cr?=
 =?utf-8?B?OVI0KzlRSllQbEhsWjl0dW43RjVTWWo3NHBmcktHSk1rRlFMRHR1c1BzVUZH?=
 =?utf-8?B?OVd0Z0hENjl4TVowa0d0OGJoVTJlNnpUY3ZtWlVqYUZpTkMzNm45dTg1SmZD?=
 =?utf-8?Q?lqPPIPaTUPzLhqms=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3037e9-e8d6-4259-d327-08defd8f8c5b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 01:16:51.1007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBG5loPmCtQhTBDvuxuowtMdyPyk/a49Pk1cjt75Gkov+k8op25u5F2XzH7YV447vmH6NO9gbThplqwja1/gnWD42dY8IumzAliAfDV4Plk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5491
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

Hi Tom,

On Tue, 18 Aug 2026 20:17:15 +0000, Tom Rini <trini@konsulko.com> wrote:
> I know CI doesn't fail on this, so I only saw it in my build logs:
>        arm:  w+   socfpga_de10_nano
> +(socfpga_de10_nano)
> +(socfpga_de10_nano) WARNING: unmet direct dependencies detected for DESIGNWARE_WATCHDOG
> +(socfpga_de10_nano)   Depends on [n]: WDT [=n]
> +(socfpga_de10_nano)   Selected by [y]:
> +(socfpga_de10_nano)   - ARCH_SOCFPGA_CYCLONE5 [=y] && ARM [=y] && ARCH_SOCFPGA [=y] && !TARGET_SOCFPGA_TERASIC_SOCKIT [=n] && !TARGET_SOCFPGA_EBV_SOCRATES [=n] && !TARGET_SOCFPGA_SOFTING_VINING_FPGA [=n]
>
> That needs to be fixed.

Changelog since tags/u-boot-socfpga-next-20260817:

- arm: socfpga: cyclone5: select WDT with DESIGNWARE_WATCHDOG
   ARCH_SOCFPGA_CYCLONE5 now selects WDT with the same board filter as
   DESIGNWARE_WATCHDOG. socfpga_de10_nano no longer warns about the
   unmet DESIGNWARE_WATCHDOG dependency.

This pull request updates SoCFPGA platforms with Stratix 10 and N5X
driver-model conversions, DDR robustness fixes, Agilex5 storage and DT
updates, and Gen5/Arria10 maintenance.

Stratix 10
Switch to the upstream Linux DT, combine boot-flash defconfigs, and move
firmware register settings into the device tree. Enable the system
manager driver, refactor the S10 clock driver, exclude S10 from legacy
MMC clkmgr address lookup, and improve SPL data save/restore and
watchdog support.

N5X
Enable the system manager driver and switch firewall setup to driver
model. Adopt the upstream Linux DT, update GMAC nodes, consolidate
ATF/VAB defconfigs, and use common SoC64 environment settings. Enable
CMD_MTD and ISSI QSPI, split the reset manager into common and
platform-family parts, and drop the kernel node from binman for the
non-VAB flow.

DDR and memory
Add ECC DRAM scrubbing and DRAM size checking for Gen5/Arria10,
secure-region support for the ATF flow, a delay before MBRDADDR writes,
and a data-cache flush fix. Use dev_read_addr_index_ptr() in the DDR
driver.

Agilex / Agilex5
Add an Agilex eMMC device tree, enable 8-bit eMMC, restrict watchdog0
autostart, set DTB filename and kernel-node removal for non-secure boot,
disable gmac2 on Agilex7M, and update Agilex PLL sync-to-async
configuration.

Gen5 / Arria10 and cleanup
Improve QTS handoff prepare isolation, fix the PL330 TARGET-to-ARCH
naming, enable DesignWare watchdog and random MAC on Arria10, select WDT
with DESIGNWARE_WATCHDOG on Cyclone V, and apply related Kconfig, FPGA,
clock and MAINTAINERS cleanups.

Please pull the updated tag.

The following changes since commit 527115ef6783cec49e5610c523c124b399011361:

   pylibfdt: Replace removed SWIG Python 2 compatibility macros 
(2026-08-13 10:12:41 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.git 
tags/u-boot-socfpga-next-20260819

for you to fetch changes up to e80a7abab162936039d69864c697e4276d27470d:

   arm: socfpga: cyclone5: select WDT with DESIGNWARE_WATCHDOG 
(2026-08-19 08:38:02 +0800)

----------------------------------------------------------------
SoCFPGA updates for next (2026-08-19)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (23):
       arch: arm: dts: stratix10: Switch to using upstream Linux DT config
       configs: stratix10: Combine defconfig for all boot flashes
       arm: socfpga: Move firmware register settings from source code to 
device tree
       arm: socfpga: Update Stratix10 SPL data save and restore 
implementation
       arm: socfpga: s10: Enable system manager driver for Stratix10
       ddr: altera: soc64: Add secure region support for ATF flow
       clk: s10: Refactor S10 clock driver
       mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr address retrieval
       spl: s10: Enhance watchdog support in SPL for Stratix 10
       arm: socfpga: Consolidate dram_bank_mmu_setup()
       ddr: altera: gen5: Add DRAM size checking
       ddr: socfpga: Implement ECC DRAM scrubbing support for both 
Gen5/Arria10
       ddr: altera: arria10: Fix incorrect address for mpu1
       arch: arm: dts: agilex5: Enable autostart on watchdog0 only
       ddr: altera: Add delay before writing to MBRDADDR register
       clk: altera: agilex: Update sync to async mode config in clk pll
       arm: dts: agilex5: Set DTB filename and kernel node removal for 
non-secure boot
       configs: arria10: Enable random MAC address
       arm: dts: socfpga: agilex: Add eMMC device tree source file
       arch: arm: dts: agilex: Disable gmac2 node for Agilex7M
       drivers: clk: n5x: Add support for enable/disable API
       arm: dts: soc64: Remove kernel node from binman for non-VAB flow
       arm: socfpga: n5x: Enable system manager driver for N5X

Boon Khai Ng (1):
       configs: Enable CONFIG_WDT configurations for cyclone5

Brian Sune (2):
       Fix old TARGET naming to ARCH for PL330
       arm: socfpga: Improve handoff prepare on SoCFPGA

Chen Huei Lok (8):
       configs: socfpga: n5x: consolidate ATF defconfig and simplify VAB
       arm: dts: socfpga: n5x: update GMAC nodes and DT register settings
       configs: socfpga: n5x: enable CMD_MTD
       configs: socfpga: n5x: enable ISSI QSPI
       arm: socfpga: n5x: switch firewall setup to driver model
       arch: arm: dts: n5x: switch to using upstream Linux DT config
       arm: socfpga: n5x: update SPL data save and restore implementation
       arm: socfpga: soc64: separate reset manager into common and 
platform-family parts

Dinesh Maniyam (10):
       arch: arm: mach-socfpga: Change U-Boot mailbox client ID
       arm: socfpga: Add NAND register address and data register
       arm: arria10: Add correct mask bits for RTRIM and PU_DRV_STRG
       arm: dts: socfpga: n5x: Drop kernel node from binman
       arm: socfpga: Setting the image magic value to romcode 
initswstate register
       drivers: clk: altera: arria10: Fix wrong API used for memory free
       drivers: fpga: arria10: Remove unreachable code.
       arm: dts: socfpga_n5x_socdk: Enable watchdog0
       arm: socfpga: Remove confusing timer related words from  watchdog 
reset
       configs: socfpga: arria10: Disable  CONFIG_SPL_USE_TINY_PRINTF

Marek Vasut (1):
       MAINTAINERS: Replace Altera/SoCFPGA/Agilex with N:

Naresh Kumar Ravulapalli (1):
       arch: arm: socfpga: Fix data cache flush issue

Peng Fan (1):
       ddr: altera: Use dev_read_addr_index_ptr()

Tien Fong Chee (4):
       arm: socfpga: Gen5/A10: Enable Designware watchdog
       configs: socfpga_arria10_defconfig: Enable CONFIG_CMD_FPGA_LOADMK
       arm: socfpga: n5x: use common soc64 env settings
       arm: socfpga: cyclone5: select WDT with DESIGNWARE_WATCHDOG

tzeyeeng (1):
       arm: dts: socfpga: Enable 8-bit embedded device support in 
Agilex5 eMMC device tree

  MAINTAINERS                                        |  10 +-
  arch/arm/dts/Makefile                              |   4 +-
  arch/arm/dts/socfpga_agilex-u-boot.dtsi            |   6 -
  arch/arm/dts/socfpga_agilex5.dtsi                  |   4 +
  arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi     |  10 +
  arch/arm/dts/socfpga_agilex5_socdk_emmc.dts        |   2 +-
  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi      |  56 +-
  arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi |  16 +
  arch/arm/dts/socfpga_n5x-u-boot.dtsi               |  56 +-
  arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi         |  22 +-
  arch/arm/dts/socfpga_n5x_socdk.dts                 | 122 ----
  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi         |   2 +
  arch/arm/dts/socfpga_stratix10-u-boot.dtsi         | 313 +++++++++++
  arch/arm/dts/socfpga_stratix10.dtsi                | 430 --------------
  arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi   | 119 +++-
  arch/arm/dts/socfpga_stratix10_socdk.dts           | 143 -----
  arch/arm/mach-socfpga/Kconfig                      |  33 +-
  arch/arm/mach-socfpga/Makefile                     |  18 +-
  arch/arm/mach-socfpga/clock_manager_s10.c          | 448 ++-------------
  arch/arm/mach-socfpga/config.mk                    |  39 +-
  arch/arm/mach-socfpga/firewall.c                   | 107 ----
  arch/arm/mach-socfpga/include/mach/base_addr_a10.h |   2 +
  .../mach-socfpga/include/mach/clock_manager_s10.h  | 175 +-----
  arch/arm/mach-socfpga/include/mach/firewall.h      |  69 ---
  arch/arm/mach-socfpga/include/mach/mailbox_s10.h   |   2 +-
  .../include/mach/reset_manager_arria10.h           |   2 +-
  .../include/mach/system_manager_arria10.h          |   2 +
  arch/arm/mach-socfpga/misc.c                       |  37 +-
  arch/arm/mach-socfpga/misc_arria10.c               |  24 -
  arch/arm/mach-socfpga/qts-filter-a10.sh            |   4 +-
  arch/arm/mach-socfpga/reset_manager_arria10.c      |   4 +-
  arch/arm/mach-socfpga/reset_manager_soc64.c        |  80 +++
  ...anager_s10.c => reset_manager_soc64_families.c} |  81 +--
  arch/arm/mach-socfpga/smc_api.c                    |   4 +-
  arch/arm/mach-socfpga/spl_a10.c                    |  11 +-
  arch/arm/mach-socfpga/spl_gen5.c                   |  17 +
  arch/arm/mach-socfpga/spl_n5x.c                    |  32 +-
  arch/arm/mach-socfpga/spl_s10.c                    |  70 ++-
  board/altera/stratix10-socdk/Makefile              |   6 +
  board/altera/stratix10-socdk/socfpga.c             |  12 +
  board/intel/n5x-socdk/Makefile                     |   6 +
  board/intel/n5x-socdk/socfpga.c                    |  12 +
  cmd/Kconfig                                        |   2 +-
  configs/socfpga_agilex_defconfig                   |   2 +-
  configs/socfpga_arria10_defconfig                  |   3 +
  configs/socfpga_cyclone5_defconfig                 |   1 +
  configs/socfpga_n5x_atf_defconfig                  |  89 ---
  configs/socfpga_n5x_defconfig                      |  29 +-
  configs/socfpga_n5x_vab_defconfig                  |  90 +--
  configs/socfpga_stratix10_atf_defconfig            |  90 ---
  configs/socfpga_stratix10_defconfig                |  69 +--
  drivers/clk/altera/Makefile                        |   1 +
  drivers/clk/altera/clk-agilex.c                    |   9 -
  drivers/clk/altera/clk-arria10.c                   |   7 +-
  drivers/clk/altera/clk-n5x.c                       | 129 +++++
  drivers/clk/altera/clk-n5x.h                       |  19 +
  drivers/clk/altera/clk-s10.c                       | 616 
+++++++++++++++++++++
  drivers/clk/altera/clk-s10.h                       | 203 +++++++
  drivers/ddr/altera/Makefile                        |   4 +-
  drivers/ddr/altera/sdram_arria10.c                 |  32 +-
  drivers/ddr/altera/sdram_gen5.c                    |  64 ++-
  drivers/ddr/altera/sdram_s10.c                     |  60 +-
  drivers/ddr/altera/sdram_soc32.c                   |  85 +++
  drivers/ddr/altera/sdram_soc32.h                   |  15 +
  drivers/ddr/altera/uibssm_mailbox.c                |   2 +
  drivers/fpga/socfpga_arria10.c                     |   2 -
  drivers/mmc/socfpga_dw_mmc.c                       |   6 +-
  dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts |   4 +
  include/configs/socfpga_n5x_socdk.h                |  33 --
  69 files changed, 2164 insertions(+), 2114 deletions(-)
  create mode 100644 arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
  delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
  delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
  delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
  delete mode 100644 arch/arm/mach-socfpga/firewall.c
  create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c
  rename arch/arm/mach-socfpga/{reset_manager_s10.c => 
reset_manager_soc64_families.c} (76%)
  create mode 100644 board/altera/stratix10-socdk/Makefile
  create mode 100644 board/altera/stratix10-socdk/socfpga.c
  create mode 100644 board/intel/n5x-socdk/Makefile
  create mode 100644 board/intel/n5x-socdk/socfpga.c
  delete mode 100644 configs/socfpga_n5x_atf_defconfig
  delete mode 100644 configs/socfpga_stratix10_atf_defconfig
  create mode 100644 drivers/clk/altera/clk-s10.c
  create mode 100644 drivers/clk/altera/clk-s10.h
  create mode 100644 drivers/ddr/altera/sdram_soc32.c
  create mode 100644 drivers/ddr/altera/sdram_soc32.h

Best regards,
Tien Fong
