Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F8C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB7280285;
	Tue, 14 Jan 2025 08:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyzG13hA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0A580619; Tue, 14 Jan 2025 08:28:02 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B9E8007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgC2BGLd/RegqkN3IqnK40gsa6pBSi0pcnU9ra71hsuUleRAvLrQ3byzy4V8MwVWdSOAzQBHQT4vFgMPp41NdphlmuGh7o82Y7kPF8/BMGqNlBI3KVBhSfXO3dKxj6760Xw5enIN1g5frBV12cldobzRuWT/R8fSymkixqWck2c2w0sSdksPwL/qQls4Qekx6l5hYcFFLUFbsmbRKg5cVHC49gZueQ8zAlDHqandR1zkVb4fC9+3N6kGv0zEgiojQpK3PEoyrM5MegN52n+UoObJ4QUqcbgYvVUeqZcqermLgwvdxlpuYhjzKLbrmJOb8WZDphe3gESvhbq/A48WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUeUpXY4O89lr8d1EnCecwHNxlfd8gpOxnUAXbqKDT4=;
 b=jFkdZbrUDkcYQPvdxdjIhW6waWn9jCrzc+LXfxrPOcuSdH1m1C6t2/Fb+Qqxl/F/EdCOC0UC3ncoiPJAdnxKm8Rz4la5C8m7hAXR+642UaCN5LcRFoZiZ5GvlolHKJ8z5uBbwk5qs8WtONYaJvEkPYd0tUxaYDQjN/efIkcLGmeRJeRSS3bKomqgyGeS3bDZ9QXurH5IWNCg8PXE56cGjgpN/af/NWPAW7MKwBGrKrcKxBeNqfY0J2nQ7xG3oGqqNRezHVh5smd5nEg4Xy9e8wNgKo8pJC+k+s+NfSgrdTRbHCzUnFmx+kkwPV0hslp2tbYUboFwWr0izGsXHv6a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUeUpXY4O89lr8d1EnCecwHNxlfd8gpOxnUAXbqKDT4=;
 b=nyzG13hAkjuqF9AXlDEfndaiKpA8jS+VrOU035LnRca/cEExQu8wLLynazf8ZoZUeXuedQTxrDmz+3Jen+N6cyYEy7N6M1jez1LQAcxkNQDa24ebP9Fs8s2NdE47YkwUCNRPN34t5OnsNT10l87prXkuMhCnz8YDy7feozXVvO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:27:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:27:57 +0000
Message-ID: <09a323c9-0d89-41ae-a07a-8fe2c3d1043d@amd.com>
Date: Tue, 14 Jan 2025 08:27:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Enable iio-hwmon description only for SOM
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Paul Alvin <alvin.paulp@amd.com>, Srinivas Goud <srinivas.goud@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Vishal Patel <vishal.patel@amd.com>
References: <08ee4ce2fe242905dd99cea2b87373b57d8fea91.1736152939.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <08ee4ce2fe242905dd99cea2b87373b57d8fea91.1736152939.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0303.eurprd07.prod.outlook.com
 (2603:10a6:800:130::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 4836b04e-3a63-412a-e371-08dd346cf759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aExUUnd6TEsxa2cvaTdaRStwUFNDWExvV2lEOVViTnM5bm56RlJvZTcwV3Zk?=
 =?utf-8?B?N1pNdmo3dVZtdUR5aVpMRG52UGw1Tk1HMkR0d002K3VvS2ZtWnBUUUFwNFF3?=
 =?utf-8?B?WVBXRXdOY3dJSTRuWWNlbkZPL1VkRlJyNkx6d0l4Y0tQMC9LaHJQM2hvNytz?=
 =?utf-8?B?SkJCV0k1RUl5WWhkUW9JODFQUmN1MXdIcy9HQW5GM1BZNUZyUlhwUTFsdUNO?=
 =?utf-8?B?d2JhYVRqSE1kcnRhbXBCWWtKYXMvdTZHNkcvRW1EVE4xVGRSQXllRkJweC9r?=
 =?utf-8?B?bEovZFNsOEYrRkdDdmlkU1R2UjJQaEd1M3lSNjg5enZWVXhIcXlYVCtPeldH?=
 =?utf-8?B?SlFCdU9FNGdibWtmVFd3alBmQUJ1cXBxb0s4cUppV0wybXVwWlcyOHJScXQv?=
 =?utf-8?B?K1NMOEtrRUJrZzg1T3BqM1BJM1ZXekVpMEZ2Nk5lcUk0V3ZwQkRjaVhpbnd2?=
 =?utf-8?B?emtZclZXTk9JMUJpdDhEeHBabzlMT1BBb1Jrak1PdzRoYXhqbWhId1h4UkEw?=
 =?utf-8?B?VjNtN1kzNkZqaWZtdEIrbkorQXRSei9WcUFxWUJTWnNxSzY2SDlMbExvZ2ha?=
 =?utf-8?B?Uld3NzkrWERQZ3lqSEhKRnp5dHVZUXkyYWpJeHZNU1BaVWJlUnl6WmtwZURn?=
 =?utf-8?B?VEljSjdXN1Z0a0IrV0NiR1lkQ0lsT3dOVUxWVVlqZlFteklwNmdjeTlGWm5C?=
 =?utf-8?B?cVNmWFZTSkEzTDZHVjNlc29HK1VyUWNIenZUbHlIeVVVUmY1SEkwc2d0MVU3?=
 =?utf-8?B?ZkUwV2RHYVdmelp5NEsyWmo0YVM3cE44cTRwT3A0ai9yR2dDS2RwV3JwaTls?=
 =?utf-8?B?dEFteGNDcnJjdE0vS3VoZklnWXhFVWFvNTNzSzhFK09FcXdrSzZDNVNxQ1dz?=
 =?utf-8?B?M0tVbk9RZWUramVVQzZRZXkxdklKU2dYNW1vais1dUdzTGlZYmxVRHZ2TTQv?=
 =?utf-8?B?UWRGRzJNQ09FOTgrcmZZWnNUQldxb2lBMFA5UHVKNVJpMzlCQjhsR2grVnpW?=
 =?utf-8?B?OFdibitMU2sxMWhhamhQaGUrdTRuSkZlSHZDY1FuQUQ3ZFl3MUhvV2V5RlZV?=
 =?utf-8?B?bXRvQndrdVIxRVJkNjM5T2F5Z3RBQUdCWFRCeVcwVUxMbk5TeVVFU1g0a2cr?=
 =?utf-8?B?NFQrTzZyZ3VVbzRDVnRCNTVrc1dIN0lKc0lVa3A4aStZL0hHMFJOSFJudW8r?=
 =?utf-8?B?OWJycHh6c3lORlpjNXF6OVgrRjJJSUJwQzNRNkdiemh2MHkreEg5Nk5mVGVC?=
 =?utf-8?B?VGdNbDVuTGVtUm4rOGV0bGIxSXMzTzZoUTlidnhPT09qWXF6bmV1MWhCamNK?=
 =?utf-8?B?RG0yMFhRZkhFcmp1cHpMdnlHd3JFMmRhYStvdEhVSStUcUttTVF2ZThveFUw?=
 =?utf-8?B?clFjVzhSN2RzY3hvTGtOKy9lcFM3N1g4NFJmUUEwQUl4ZzJocWVQWXlXdnkr?=
 =?utf-8?B?UFpjeGZtdGZuV1VGdzRxcENNK3ZWSUFISUxLSWJLdXE4MTZQWjBoQm14Zksx?=
 =?utf-8?B?cXBmdVAzU241VzJhaG93MU96UGYvVFZoWEd2OXlIcU9iTTRFT1N6WU83NHgw?=
 =?utf-8?B?RlM5MTgzNjZ3TVVHNXdmVHJwdUpCOG9janFVbFBEK3M5VzJrbUJyZ2dmdUpl?=
 =?utf-8?B?Qjg1d0txd3ZhclBYakYvQUMxZXMzT010ZmkvQ0RsWEYyeEpuTDNOeDVZUExa?=
 =?utf-8?B?TmtKTVBiRyt1eG5JSlF2V1JVV0V6c0NwZnRXbWF3N2ZTL2RSZDdYU29tdlNt?=
 =?utf-8?B?RjJua09uZWNZMHBrZEo4Nzg0czhOUHJOTGovQ0F4TjlPRmdGU0FUejZTNTdx?=
 =?utf-8?B?aHByRXNvSW9tUjFpRDZpOXRVU0pqM0pGcmNpaVV1QS92Sk5GcjkzazMxL1Bx?=
 =?utf-8?Q?vg8EneQlfemq3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNzTE5VTHpYTXFJTEdyU01lYTJ5NnJFQnJiTThaYSsvdDFkazdzWlNtbzMx?=
 =?utf-8?B?eGdqeFdFZTZlb2hKVWQxeTF5TTZ2WHlpVjFQcnZzYmN4S21nOTFIckhXSUo2?=
 =?utf-8?B?V2VRendnaXB2VU5YeDloVERqY2dBdUdOWXFrYzNZNmNaeERWZXpZTlhrczV6?=
 =?utf-8?B?RmtmUTBqbW1aZ3hUa0l5cmc4RGhFR3B5dDluU0dsditjQWxSUks2L0pKM1RC?=
 =?utf-8?B?dm00Y1QvdGJqMGMwZU5mSkxud0hNc0kzMHNzNnNQWG5rZG80U3QxVDZZTmRE?=
 =?utf-8?B?MWZLNnFUMXYzeXd4VHVkb045bks2cW1iTXZFK2JrQ0EvVkxqM2YrSnhCaE5h?=
 =?utf-8?B?SUs5ajc4R1VYUEZjRnBWZHZYeGUxemRLa2VDc1ZBT2ZwZkJkbEdSZUFKaXo5?=
 =?utf-8?B?ZDFTYU1NRWVoNDdsdytTM0lMZ3QwWjcwczdvZnBnTnNkZnEwbzVlVmxFZHY3?=
 =?utf-8?B?Rys3T1BiSFJDSDlaNmkza1FXWjlzTDJKOUZPYTRRZWh5N2JFbmxlbDlUak5s?=
 =?utf-8?B?TUNZYXBMWHFQN1BLZFhyVm5ncWJ2bXdzU3R3Q29vb3ZiZFBQRmpFOTdENWtQ?=
 =?utf-8?B?bzFsRGsvYjdrdUh2YnczR2JSK2VCYTM2aUNNSDUxdnF4cWF6cTFaNU5BVkl6?=
 =?utf-8?B?ZHdBWHFLREFaZTJUU3UvT0plb3NRVmEwTWIxd0pyak01VmxvR2M2TGYrUEZS?=
 =?utf-8?B?NDR4cDdUVWdtOHJra2JyMXBsM0FBUG5lNEk4eXJtQ3JLRjhXZ1JnQWRmZ2No?=
 =?utf-8?B?MnFPaHFIalVSVjVlak5YQ2tvay9WUHVsakFpc08yL0xhb2RmTHJtby9FSUlG?=
 =?utf-8?B?RGc1M0VXcjIyelVWQ3F4YkFkQ0tkOFF6WXJNZ0RkOEVvdlhKOUFlMnZKaXpP?=
 =?utf-8?B?MmhkTlREMGlZY2lERHJlY1JLRzJqQnlKaE5UT1NiVi9YcFBHUjlUWU9NTkto?=
 =?utf-8?B?cktndXJaRVVTQnIrZzBUcGJ4eGxXUDY0Q0ZNRVpoVytiaVdxT2xyN0wrRHVy?=
 =?utf-8?B?cUhWNzJQK2JaNCs3eFhMVVhLUGhHU2hXc2tqNFlkN2JZb01GdUNZS1pDdkpN?=
 =?utf-8?B?a3BWZXhGS0w1YWMybW1kb0FZN2VPNlN3MG5zMnpJNUNuZXNub0JGai9ETGlo?=
 =?utf-8?B?bGRUc0ZScmNrN3E1Q3lGaStVNHlva3lPNGZMMlRXVjlXT1dGdVdVNW13Wkpu?=
 =?utf-8?B?RDJwWUpOZWZhTzJzcGZNSmQrU3BUdmJoZ0tKanJWQ21uYklkUGdPNjBybUxR?=
 =?utf-8?B?cFdjeFdPOS9ZZWJwdUc0Q0l2aEVFaFByL0hzUFA4OGtEcFNzcVRNUi94QnVq?=
 =?utf-8?B?ZE54WGdldzFRaGRYYk1nczhnL2pIb0NWUC9KUlNBQnNtYzdoQzVWcHVma0Fu?=
 =?utf-8?B?dVJGT2RVMWdram8vME5QWTdpY0JweEFDMGIwUFlBZnBOQXlzRy9adVBwTVlF?=
 =?utf-8?B?b1lEWVd2V2NvamZBOWlYSUJwYlIzUDBDV3F0aUFDVkZvMi9ieDdFcktFenNw?=
 =?utf-8?B?ZmpBTnFWZDczRlB1S091MVc2elppWVcvZFdiSXNJU1VsQXRYVzZ0dGs3V25i?=
 =?utf-8?B?OFNTR3JFYmJsblhzT01IMnhxV1RncDVheDZwYXBaK0FCa3VJUGp6MUYwcDVY?=
 =?utf-8?B?d3lBaHc0amFJYUN6cFV3SkxkdWdpTTZIdGJIQkEyazRRNnhuR0pheG9GdWNa?=
 =?utf-8?B?OGZlN1pUQUdrc3dJOW1pSXBlaU52Yk1UVTBlU0dlUG9VTnRnUzFlUHlVU3Z4?=
 =?utf-8?B?RWlYbjBOekJuN0JURExqOVZ4c0dYK1REVGdudzc0dFhLeTI0Q0NTbVdCN0Ru?=
 =?utf-8?B?TFkwWWJISmxCWG5vTkUrMUwyeTdOZlNxUDRWcmdEWXZTbDVqR3hBSTdkNWtB?=
 =?utf-8?B?V1B4K0pkYXBCdENWM29sRUJzelprZUNtcktnbWZ2QWdkNXlLRVVZL2Q3WFJG?=
 =?utf-8?B?MjIxN25jWGl3OWlhNCsrVUlxbWxCbUZXY1FGWkJZSEtYeU5adXUxVHROQjl3?=
 =?utf-8?B?TG1sZlN3dVMraDQxMFNUQWpDekY0SFR1Z1ZVWlFVakduMmxuTWx0ZXhiRStK?=
 =?utf-8?B?RnRldEhMWkw2Q3ZHRkFjMlBadHc5SU9rbFNJN1dmRTUrcGR6VDRqaVZ2R2Fs?=
 =?utf-8?Q?5vOxBfIrGHio+7g9HN6aC97D/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4836b04e-3a63-412a-e371-08dd346cf759
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:27:56.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt+gfPWevlyNNTRw41mRZQMVAIk31D5ku2ow4XSSAhHwnIy+kBbdOxQCbA7fSuOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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



On 1/6/25 09:42, Michal Simek wrote:
> Description is coming from SOM only that's why enable it only on SOM.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sm-k26-revA.dts | 4 ++++
>   arch/arm/dts/zynqmp.dtsi            | 3 ++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> index b514dc27f710..70acd3eb88b8 100644
> --- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> @@ -97,6 +97,10 @@
>   	};
>   };
>   
> +&ams {
> +	status = "okay";
> +};
> +
>   &modepin_gpio {
>   	label = "modepin";
>   };
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index e8750b08162d..0e0436ecce82 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -393,8 +393,9 @@
>   		};
>   	};
>   
> -	ams {
> +	ams: ams {
>   		compatible = "iio-hwmon";
> +		status = "disabled";
>   		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
>   			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
>   			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,


Applied.
M
