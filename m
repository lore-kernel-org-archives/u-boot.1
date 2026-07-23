Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C10C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85BC24087D;
	Thu, 23 Jul 2026 12:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHchZ7hsNgwn; Thu, 23 Jul 2026 12:23:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5BBC408D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784809438;
	bh=0QhkNKMCWhP0jEHkIuWIJnLhc0m/G1tWuwinQMYHEj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HM+UBbVMPeAHygyQf8zlOmmrM+rI912HHIM1VzN/uzPObh4DuUuNsii4lxrvAlQ/Y
	 ip3ZNm+/Vkd5HN+QzKVNkldlXvsI16upSAFkTORQZ2b5q6D2s9dZnX63uq3qx987Ha
	 wl7wVoAhQHihEvR8AksQwJvn9eKrZGqjrhOLJkkPYyk/qSQ9stkmnQ6xpC9rJeiR+H
	 ZqZNlL+z7m+qm+5759JuhzvKNh9W1qnqsUJSUKL/R4tC44FZGIXk2PavwyUmTDaocR
	 6g/BSeLz607lROTxvcc0DETy+ChNZjhiZQJnruxmDPDdYTj76RoC+sabO2cmS3cnpK
	 Mb59tgfVmBNdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5BBC408D0;
	Thu, 23 Jul 2026 12:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B497F347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5B5260792
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dv2qS6Zyv44o for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:23:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9792F6068D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9792F6068D
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9792F6068D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAvfuZoEC1U2x+Z1DhzgxMzBcTLXt7rX0fxTq2E2MAge0GP4V+R5WJuU9P5hgjfbuIc4ifFA8zAJvZW4Gd+cQ6VHa7m7oLCse8IwOGIceX8MBcUdkxfA9Ul1mesF0yBpKUBTwXBl6xAnvAK45Xwujutn6BKrSRup36MDeJsGzKf1cMs4gO7iTBBRLNv3oEzkP/vvnzboYOp4Zc+kr5NDradvMu9fiq2ys+HKMrT48CXu2y+noyjfVPWVbaEwV4aYAkrViszYtgk6oIwmXr6ldGxyU30W8ol57wotPhy99AtCJ4LHuyGHRWdrVYL50rT1/ZSd9mRbebjJu9Pz+iI23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QhkNKMCWhP0jEHkIuWIJnLhc0m/G1tWuwinQMYHEj8=;
 b=HT4c+cU3d+5+0Lfc2gmbSdlJ/jtIUVhG3HlaxBPQHQePe9gMasRg8FYIAgpYNkBR/e0ZIA+rqlapTcx2hhxMTIvWSskId8VoYdrpZQ15V6Jpnu0MLguT03md+zz+5XrWhaaYhPWpd2MBT+vO1GQsD0roIDToWBz+f65GPxhXBJsVpWt5jrpSFOoSQFKqy86/gP5er1zm8W2FtQ2lSUN5uJYHzAl6+3efQxFHmMHSuWLao7J4KiYXh1KxL2a9mL7TH5u4euC3uOZDbbRynCiLggYD/mhKjpmto69PhVw99WGa0SaF4KqDoU0Hf2Bpbg9erVwy3TQ3Bn2soC6a8eeujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:23:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 12:23:47 +0000
Message-ID: <bdaf952e-41ef-4ad7-95fa-93443d6552ae@cherry.de>
Date: Thu, 23 Jul 2026 14:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: rk3588s: Add support for ROC-PC-RK3588S
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722184024.1210447-1-festevam@gmail.com>
 <e26ee0a6-5220-43b3-9846-7b594c4c4f85@cherry.de>
 <CAOMZO5AGM3Lm5=rfECDnkgwokTOxb=T9ww3+gqS9wdXpm-bQ+w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOMZO5AGM3Lm5=rfECDnkgwokTOxb=T9ww3+gqS9wdXpm-bQ+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0135.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::32) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b7b334-7a55-431b-ac7a-08dee8b53ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|4133799003|56012099006|10067099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: h2H9YjgDQ0G2Sxo/loHCxQVBJfXBjty07nU+cXOUaHVNvf7Y+efR3rkYPFqSp2d4S+75SCwfyyfnYzDtUmQz+7RugcubDcuyInmaDRMzs11EI0D08fDGCeDDny4FU7AP8pA04hmbh45piSqFORrXqAQBU5c8zy8VTiaS4LskK1qGq80ZTClZKOp2mc6JaXMLFvsPa2j7tKFkaM4IQeazgBU3ow1Y9mm/bmZImZ9euw8YOs4kJl1XJCi1GGnERjY5mJZFiaMVwj1/njbbVOkSWrd0FLbzmcR/bWJtU/mVdgHqwGqH/7fc8UY6P6y6JcEmcFCG2e94X1cK+atXclGVFfs1YQF7HzoIQ7M9D4c/GItV/abooY+1AYYh6box9WT3fh1ACCV4Br3iDhh7L52BYCEauAvXFnUX/B7d03uEpKd1Ou11T/s0Ov2oW3grck99Uj+fbZVGL9DtrJNETtptelN8b6SNqUs7OqBxyhxMmyLQFOY6gHioxMrUumBnKikLGzxbZHhanjIvaXLkzMZIaz7KsGELXb6dqnKW9IvHq2usV1tOMp4+MPxg/2TR+AL8cMApmWIPv4qkFANHIRss67jEZqGzm5alywfvr/eIcwS4iwcPV/PXyzMc4lvTZCv/KoJgm44H7rTG320iKM9CIlqRJkenKNaQm3ycnQYKzL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(4133799003)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1sRERIZHZXSEN1TFgvSUJNWlhCbHU5U1A0VXE4S3owMGwwMDBEdmZKOHRX?=
 =?utf-8?B?ZEc5ZUhONXdLVEVmOFhkdEVQWjBlbVNmODRIb1R5ZTJVczRmaS90bTdUU1RF?=
 =?utf-8?B?MWUvVWJrc0ZaUDAzUTNVaGRzaTVQL2F3aGx4MHVhWCswT0YyN1ZpVVdVZEZk?=
 =?utf-8?B?ZkxraWxaVmF0NkkreVJuNTI2Q1hLa1BadjRUZjJpbStXSXZXWFFrQlovMmFo?=
 =?utf-8?B?STQ4Zlo3MVpnWU1JN2FSOUF0bll1WkM3cEF0NVFSUGVYSkNXcTk3MThiSldQ?=
 =?utf-8?B?ZEdJVS9xeU9zOHRPTW9zSURpeVJ3TVpWbEUxWkJEL2pFYjJKZGZkOWhYd000?=
 =?utf-8?B?TlVJWlA1L2wwQXJsOGpDUlZTMzhyY2EwTWVnaVoxTVM4MlZWSmZOd28wRnRE?=
 =?utf-8?B?dFNDREk5TWFlMVVqa0VmTnpYMkdKam0xSTk4Qmg3dHVHU1FDZThoQW00a0VZ?=
 =?utf-8?B?RmlrQlhpWm1nZlJMOEM5Vis2SG40MHA0MmVyZFJDaTlrYXM4ODhhQkhEdjM2?=
 =?utf-8?B?L00zOFVld3ZCSFdua2I5ZStXdi9FaFUxNDdQN08yM2ZMUDFreDJNS3RKMFFk?=
 =?utf-8?B?eXdtSmNacko1UUp5TlFxdHMzL1dKNGZFZTNxdlFPRmIvVHY1VzVyM2IzK1h3?=
 =?utf-8?B?S0JkVmFzMkM3ZGNwOUZ1SXlXeDVZM0FhREs5VExTc20yVFJXM3NseU9oa054?=
 =?utf-8?B?Y3hSVkZsK2JNOWdpUGl5aGNua25lSlJvTGtoRDgrMjNsVkFncFVKbUVaZlMx?=
 =?utf-8?B?RkM5cmxabDZ4MVNiT2VxZFd6ZXhHcTZJZUhSREhucmVYc1dxZWdTMFEwaG1J?=
 =?utf-8?B?MlNzbFNLMURiR0d5YlVxUU9zcy9UekNHN3Z4dHQ0VWxkSEd1L3NBWjduUk5B?=
 =?utf-8?B?bmZQaFRVZ0FkTjV6RERPOFBabUdlb3VLVG5WK1E1UWlydjhocFNidUpDV3E1?=
 =?utf-8?B?eTI1Z1FuajNzcG9sTDZlNXpSYkUzWHlSdERuc3pIWlFQU21jbVRoSjJjTFZo?=
 =?utf-8?B?UVpkMEVCbjgxNDRLVVhnNG54RVFsRElWZnUxOTQ4eG5oYWk2WlBGcDJIMU5w?=
 =?utf-8?B?YWk0Qm4vem04VG1ucDRlcnRHQzEyUTJuTUdUNmpvVllLQjhid3VaVXlVamhS?=
 =?utf-8?B?dFJmSE9Yditsc0VXSlJpNTZrRU40MDlCRzdlS1c5YTFrbFZyOGN4SVAxdWJX?=
 =?utf-8?B?c2dkZkdPWW0zeEFncHg0cXE2QVdMdG5TN29ZL09jZHNoYVQvN3N6eU9CSXkv?=
 =?utf-8?B?NzhBQXZYNnhURHJuL21Qc1VsREg2aS80TW5DYkl3NEdubnEyU1U4ZjhyKzVK?=
 =?utf-8?B?R2lVL0YrRXlXbkJ1Qk16VE9rSWFuOWtWQVJyY1pKelRyY1NTMnFiNTZYMXFx?=
 =?utf-8?B?UnQvSkJ0TGthSm85dkp4UXRpWHpZVU9UNFowSXAxeHA0ZGNPQithRVc2aFAw?=
 =?utf-8?B?bE44SllqKzNMTU8zVDBDTW1GVDQ2N2MveTUxUER2L21lNGtxWW1xS0V6N1Jm?=
 =?utf-8?B?SHR6RG9HMys4MU1wTzk4R0g1czdobjVwN201b0lyTFRHaldHOGhsT2F4VWd1?=
 =?utf-8?B?T1RMSmZuWFhhZnZyWTRlbGY2ZWh0UkUxYXJFMFlXUnBRWGxhcE1pT2JRVzRz?=
 =?utf-8?B?RFVJdnQ2YVo0SjNmYXYzVnY3MllaUEdERWprUkh6bVhkV0VXa1I4UXl5Tm1n?=
 =?utf-8?B?VGhSMG8xcytIdDVrY0tnbW41WlZpcy92YndZTUJ5d3htbC9uai9rNER4bm42?=
 =?utf-8?B?V2VIb0JDUHlUUnVQQVBaNmhaTkxRQmV6cjdCZEVzYjczbm53L0M3dHAxTDh2?=
 =?utf-8?B?c0IxTTZtQmphWlVvK0U5bERyQ0YyV0pwaEc1UW5aVmluUFJ2TVZHeng0SG1O?=
 =?utf-8?B?djIrdzRvc2lPSTQ2Q1p1WTYvaHY2SXpqWkluWEpHcXpNakdvOVp4K3hIWFVz?=
 =?utf-8?B?bEt3NWJaV3pKcko1ZVk0V0YvWm1Fak5vY0NJaVoraTZBWWlYQU1JclhPNGUv?=
 =?utf-8?B?Q0NCVTVVYUlGdWQ3YXZRd2RBN1U5dUxqS0RocmNyNGZVYXhHeXJKQ0VMWldy?=
 =?utf-8?B?cWFIYllCVm5DZUNjRGJDaVgyQVRQOTZYdFBPM2g0OUFYb3RIU05GUThmT1Zh?=
 =?utf-8?B?SkswZ2taSUU1U3RFUjdmcWxCNXFMdHVqU09zVGNLdGVqR3FOc2RHNURHck1N?=
 =?utf-8?B?V3h5RnJEVXhoR2FGSFA3NEprN0VPZlhZQXF5NzczUDdUZisvd0NUd1JPVmww?=
 =?utf-8?B?VTRCTGRvQTZPY0JyUjd3SFR4WUlqN3ZINk51aStVK2pZaURhOEhLTDZoWkNh?=
 =?utf-8?B?Q3M0d2c5ckdsWWJkQ2FIb2EwZFpyTURFNDJ1d3VGSmEyaHRDeXZhZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b7b334-7a55-431b-ac7a-08dee8b53ec8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:23:47.4364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6FDuqIK8TvkpMc8/XZlmgFH59T+FxFU6tk7h1giFLKVEWjtqa1Yi6Z7RE4HUeXoZUPwkPcLitv2fplHZv4FfHrJ3qoekyXmEA1pVZIJetY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QhkNKMCWhP0jEHkIuWIJnLhc0m/G1tWuwinQMYHEj8=;
 b=e8HDFvtkVs0npyWUj+ZgCUOboncWeB16fUCelo4poo55KQS66PgYrJDqDYPF3i+VRkFlGQJtubUVImzRdhgoPHKxgIOQKgKPIMBixXyc0mULWkwjeuu9J5mM6GL08SrJcBkFBqOGzooQQrmwDrrR/DePrMWjX3A3MLn6oGKwtnc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=e8HDFvtk
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

Hi Fabio,

On 7/23/26 1:31 PM, Fabio Estevam wrote:
> Hi Quentin,
> 
> On Thu, Jul 23, 2026 at 7:01 AM Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Just to be sure this isn't an oversight, DWC3 is used for
>> usb_host0_xhci, which is enabled on ROC-PC-RK3588S. I see there are a
>> USB-A port marked as USB3 on the product datasheet, and also USB OTG
>> that is capable of doing USB3. I couldn't quickly find schematics to
>> verify what's what, so does the full USB-A marked as being USB3 capable
>> still working?
> 
> Personally, I am not using any of the two USB host ports in U-Boot.
> 
> USB host support in U-Boot can be added later if someone needs it.
> 

Fair enough.

>> It's actually ROC-RK3588S-PC (c.f.
>> https://wiki.t-firefly.com/en/ROC-RK3588S-PC/), I can fix this up when
>> applying if you want, if there's no need for a v4 based on feedback above.
> 
> Please fix this up while applying.
> 

Thanks!
Quentin
