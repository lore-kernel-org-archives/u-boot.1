Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E2BE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BC4801DE;
	Mon,  6 Jan 2025 09:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qrez8UZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB4D801E8; Mon,  6 Jan 2025 09:24:24 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F292D80137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDNqnlLJzw/8l5fAA4+HJX3VmMDBSUP0/ODL24aUA/cBCakkVLwYB9nScSpSvUbFX/JKwhUCVZy0xvk38pVw4bmDoq3/SJrV2hOHGzVFIBMAKg7DSrR5/NziFksIUhuKbXAVSI2B+sCa8MJ1q14CxCIZjphoABHYq8ZJZLmjC6ECDxZqJH7PcOrbJAHxp8HrFe6/B4h1D7Hk2Sglmq8KGuTgFW8UsFRpmpZloXjAKkTr8H5nYlwMHIEEOFMlsMDWMFD0xX3R3JZ34JhjYTfbudifd6B94jUzrgYx11Tmk+26hxKdtz6xVMzLEa1Z4wjvCUDobNT0P9WKvk2rhuGpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeG/OfN9bwDKlFL1pYWDeua7Y3EQ0ORFWY1Xm1HRfds=;
 b=fFAVoQ9DQmI+XiA9ho9TiUpN9EuarXLNHeyakL5laWbW7GTR7HAVe78dhfauM60ltdHbhWW3CcP2Ft/ht5A+etmYAI3e3fo8ofC+CqIlRmpRPXh3kVyFwNjDAM331nvyYcvHdMUmJOssZma12wOIkg/ELTvEtrzG/hdda07xFsMuqWReBQ/R3uoLT+tVmQEPzyH5oIWdKfJ3PUstrURv0JvlJJOAw+3ccGCdKNIC2ztSZksN1Q7gqGdwUL7xKWSxgo6i/13IdX9nmQZaqIk/Ugpjfbf6hZDTllZE0TrxSSmZlOPXsDW6u8AHm+U7mWazhvgVVBjT3C9M12gvR2AIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeG/OfN9bwDKlFL1pYWDeua7Y3EQ0ORFWY1Xm1HRfds=;
 b=Qrez8UZDNoZ4WQJTtevWD/bL2ZmfyBpU/pd5S6/bOv6oEsBKuVRfVTsf612iUhpeK4PGx66Ib9/iB4A13yzlcj8gajcWewDUFjRQ9AXU40l6f3jc1kXPisLCO/pG7zKeWUKxABpkrzTnPTboT8jsktYK1aHI5HjNJT3mo6akkRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:24:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 08:24:15 +0000
Message-ID: <b058c8b1-64ce-4843-b05e-1cc69d31e391@amd.com>
Date: Mon, 6 Jan 2025 09:24:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Sort OF_LIST and add missing vpk120 and zcu670
 platforms
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <505996b6ef969b1b677ab921462c75c798c366e7.1734335553.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <505996b6ef969b1b677ab921462c75c798c366e7.1734335553.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: b84275e3-86f7-4759-946f-08dd2e2b81c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1grQUxDcjZGamtoUHdFZ1lGc3B5emNmNUU0aXNpanNndmpmdkhlOFFOb3Va?=
 =?utf-8?B?c21MZlBValRRd3hoUzdSazNkTzNEdUovMS8zUndjanZQbnZ2SGZlSUN6SHVu?=
 =?utf-8?B?T0VyOWZzcGNtZkZxWTgvNUdiWUNmYjJOSGF0SGtndW9vbmN1WjZGRCs4YUk3?=
 =?utf-8?B?Y2Jxb2U3L3NEbUJPK1pVVjNwbU52T0pnL3JIZmgydGRLUTBraHhIK0E4SG4z?=
 =?utf-8?B?cEdqdERMaHZJV2NESzJKaklRd25HbWJUc2tqOXVacy83T05pa2VnU0UzMmFi?=
 =?utf-8?B?TG56dUpOMkhGY0I1dGxsQWY2dUMrL0hBYktTdDNDNWt6M21KNmpjVzc5WXJ3?=
 =?utf-8?B?amZBem1ScnUvY0gzQ29ubmFYNGRUTDVZaDMwUXFIZk5ydHgrUlpaOGlHRjYx?=
 =?utf-8?B?OWRNZnFRVlJxUVpxUWlhcUlnWWREekp3dGRQZ2ZnSVAzc3JEZENNT2NKczBk?=
 =?utf-8?B?WUJoOEFZYkpJUzlWSFpWOHFWV1dHR3JVMmRTa05wbVdoZnQ5ZndIREtUYlJr?=
 =?utf-8?B?SUd1UStiNlB4V2J4MEdUdFd5TWl0SUxKaWZRWkc5bVpoN2RWTyt2Nzlqa2dm?=
 =?utf-8?B?V2t4eFB1NTNiS0pDRTFVWmFqNFZpTm5RUHo4em40UjV4dXZPMkdnbFFYdzZQ?=
 =?utf-8?B?V1M1NUhKUEhjaDF0Y3F2TzZtWDhITytaR2lYMFYvRlVCQlJyOGo2T0xObnI5?=
 =?utf-8?B?UThDUjJtZTVxU3VXSEpxTktRNUNoRjJ6NW9pS2RWVHdQNmUvZ1lGdEdrLzZl?=
 =?utf-8?B?SnZBRUpzMHhvT2JqVEtQOGcyUVpQaTZkVXJuNGNzbUJwUlRLWHVuNUV0ZTA3?=
 =?utf-8?B?VEpXbGdwaFpFRGdwNWRzZy9HNnVaUGlHenF3Zy83YkdNVXRKL2cvZjB5WER3?=
 =?utf-8?B?MWRQVHFRdERmOUcycjVaMXNPWFhCVnVMdTJUNDZHc2UrZEwrVmpiZnRNSGth?=
 =?utf-8?B?clRRbTBlYzRsVFBaWVc4Z2hlVVF2NHM3bW1Vc053Vml0dVIvZkQwSG92Ykkr?=
 =?utf-8?B?a3g5MFVPbE5ldUVJbzgvNVk5RVdDRjhCTGpNbU5nVmJKcDdDbkVHTVlDTlcy?=
 =?utf-8?B?VDM0ZFo0TXNtWk5aUE0xNHJPZC9NZTBnSVMxTjY3S1FDNVBiVHdwZG1pZUhF?=
 =?utf-8?B?N2FDa2dhQVNzbDlpSkZPL3dCaUNOSEFEME81Y1dLemxsTUMzWHB5RXEyWTEx?=
 =?utf-8?B?MG96Smp6aVhhNkhFM2kzcFlSc0VzQjUzcjVxeDkra2I3ZlNRRnpBTUkyOFRJ?=
 =?utf-8?B?RFJ0eHFKaWZ5dkIycmVJSVFFZE9WTFBtRUNtSVZ3dzlNaVEvM0t5dHF5Q0F3?=
 =?utf-8?B?OVZKbWZrTlR6YzROTHVnYnd3b2xuamM1Q3NDeXZERGJQbnljSUMvNitYYXF3?=
 =?utf-8?B?SGlDTXBBUmg4NGIyQU5nZ010U3FSUEV6dCtaL251Z2psZjN5UmFudmhST0xN?=
 =?utf-8?B?OW5rR0l3TlR5cldTeEhqODc4Mm5HN1psTk1XMkVmKzBtMDdFaUp5ODliSThL?=
 =?utf-8?B?R2RNTU5Ed21LUFVERTFGekg5OGRFaHhzRlFrODFOWWc3NUJvK3dNMjdaVGNw?=
 =?utf-8?B?T1MvcFpiUnZ5andld1JUTXVVMkpXcENQT3BGbGZRRUVSZ1JvOTMvTUI1V1lZ?=
 =?utf-8?B?ZWtaMnFIQkVFdkU2SGl0Mm55U1ZlSXNueGxDYnI1WjFuUWt4YWs4RGZmYnQ3?=
 =?utf-8?B?eGdUalgvaEkwTWlxNFdwMG9mRDVpWXpwR0FhVjQxQWtXUDRlK1lYa2lxaU5y?=
 =?utf-8?B?ZE4rb0FuWVdBWFZmNVQrY0tiVWdYM2g3UXNCVWF2UnY1d0d0Y2dPclNGS0E2?=
 =?utf-8?B?UXNkZ2FNVjdUeUI1SnBMSmNlUThHTDV0Z0Z3UFNtSmcyaTF2U2ViaWV2NGw4?=
 =?utf-8?Q?xiNq/48gvXSEm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xicE1HRks1WXpYUDFITFNJUk9pTU5nbmp2aDNJYjc3d0FzaGRXL3BEeXkz?=
 =?utf-8?B?N25PcTR3b1REdVY5ZzNCSzBndmhldktXdU5ZZ01tbVRwL2VnV3M2TFJhY0Ju?=
 =?utf-8?B?aFpUOWJMemlSenVkTHNvRHhMdzd3UWFzMHl1WG90cWNWQ0svZHFFWWtpSkJv?=
 =?utf-8?B?ZSswdDNRbjF0aU41WjRsczZOZm40QUYrSjYvWGFRZm9qSWNPb2twMnRWdjls?=
 =?utf-8?B?WnN1aUhVQ21jMXhBcXlZYjhKSWhEVHVUMUR5RHQ4WG01Z25sdWprbE9lMG51?=
 =?utf-8?B?T2RvMFNZa0JNdzVmU3RkUCt2cXl5Q3NDd29tYUI3ZzVaUnJiS3hqdktka2xn?=
 =?utf-8?B?dlArZC9vN2N5aUVmckw0NzFrbElITmtvRXNBQUwzRGltaGx2dk1KYjU5UHE3?=
 =?utf-8?B?eHZKbXRwT1Z2Z0JGenFiRWFWSkM0dUY2WFIwWUhlQnB3ZnZtclh5RXpuOHR3?=
 =?utf-8?B?NzZ2amdDUHlCOFVNeWoyeUhxMFN0YVEzVmNSQVRleGpuVmp0MVpqSW0wT09u?=
 =?utf-8?B?ek5aa1dCdkt5ZEM1cndob1VvbDJXNklkMUkra3hSNEI4MzZEVC9QalpwRkor?=
 =?utf-8?B?OXBQMWFuLzFzVzl2THRad0w0QWtpa0YyTGc4ckRvQmFhM0VMVUJvblBjeTQy?=
 =?utf-8?B?VjRKT1h0cm4rOGs5VytDZ3kzQkxmbmM0b0JyMUlGSERxOGRobEIxSW51NlVN?=
 =?utf-8?B?ZlBmd0hRcXJFVXZKWURlMEJLcDFWeitCRTNMKy9GalJnMkxpcS94MWxmT1ND?=
 =?utf-8?B?VnJmTjIrQ202OFdlMFMrNU1JcmJhMytGVU1FWjJEb0pWWk9QR3Izdm91UVd6?=
 =?utf-8?B?blFIZDIxWC9JbDRDWllDVnZPL3hETmxJSWxMU0h5Q1pUWU9wVDNRN1hJT2dJ?=
 =?utf-8?B?WXIyeXZDdUx1eEdQVHhURlVBaUtPVFd1K1ZiSFJyVnZJZEtmaTQxd3NYaldL?=
 =?utf-8?B?NnNSMkNRNXhxcUhVUGFieXh0UE9YUzVSRVRHQ0lPVEVlbWh6QlNXM3pXYVh3?=
 =?utf-8?B?UnpMeVRNL0tPZzJ6SmNLMWNJY0dVSmZrcGZoV2FwY3NkL0hMU2s1c1FEcC9t?=
 =?utf-8?B?OUVSb0tJOENhdDlXdWRGRlpkMFY2Y01aT0VJdlJURWcrWTF1UzluUTlMSG0z?=
 =?utf-8?B?dENZdEdra1RiTktHekttRlhNU0FIRm0xcWt3QmxWMXk2d2NNWEh6WUhJK0FG?=
 =?utf-8?B?NisxWndUdi9WTzN3dHFtdFdBcmJGRVZTYUdMVmVlSTE3c09DVTgzSHUyVm5u?=
 =?utf-8?B?TWgzZVFOWnd4UURhK1R1V2pPaW1PZHhrYU9Ta3FPaXlQWEdmbGpFL09naEJW?=
 =?utf-8?B?Mmo3ZUdEeHF5Mjd0TzhYZTJzT0xIT0NvWHNnZm1IT2U4R3NyczE0MVAxdjlM?=
 =?utf-8?B?c1Aza3IvLzVQdCs2ZW9Wd1V6ZU8wRVg5dVl5T1NFanlCSndrcXo5eWhQYTBk?=
 =?utf-8?B?Nkc5RlpJUjZoYTNDOXJUZTFNSlE4dUpSWDVWb0gxclExalFhSGV4d3FtTTFW?=
 =?utf-8?B?ZmNjbDBmN01ycVBJdERyQ1RVK2E2amFHUXp3MkgyTmVZcENQODlMZVQ2dnRt?=
 =?utf-8?B?RkR1cE5Nd1BOTGwrVWkrY2pVN216KzlsRTh5SVVhTGw0S0VpNEl1NkxGYUlQ?=
 =?utf-8?B?bk1WOUtoRFBpa1V5cGhsazVPVjErZFZWdmJDSTF5UWRoQnNPTzBmN2xRUUh2?=
 =?utf-8?B?ejV5c3pFUEZaUEtqb3hNSjFWb0xpQzhabFNDaVJJaGFzbHdYUmZJK1hOdGpi?=
 =?utf-8?B?OEM1UlFaQ2ZES1pZR0crMEhRMU4vWXNwUitFMG84VlY3NzJ4NVo2Q3RQSlVW?=
 =?utf-8?B?dHNoRjBNUklxcmo5cW9CWW9WZW5hajFzcUkvOVh3YnVnVWNwU1BxQUNyNFE5?=
 =?utf-8?B?aUpRaXdFQ0orNnZJVDZ2MjR1cW5MU2FrT3gySTFpSDR0LzM5a2MrYmppbXNm?=
 =?utf-8?B?MUdOWitwcVZPRzVEb2U2Y1NqbjlrYUh2a2RlYWRMeW1QbzRvWElXZ1lVM3Ft?=
 =?utf-8?B?Wk1WM1k4OUtEdFl3Wm5xME1ZV3pURUI2WDZ5U2ppWnJ6eEc4WEJFVitaeXN1?=
 =?utf-8?B?UGptdDJ0U2RhYlRGRWxnQXZYWE9ad1JFa01jZnpzK1FNT0JwQ1JTd2k2aUcz?=
 =?utf-8?Q?rd4aR5UU7v5dIGHFUw2wHo6cd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84275e3-86f7-4759-946f-08dd2e2b81c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:24:15.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2VF/jnF+9mvFLmCS5wc0yWEpAvGYEOsc9SgwRhUQ/T1RN+iXmmpasw5flrLw3Tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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



On 12/16/24 08:52, Michal Simek wrote:
> Sort OF_LIST entries and also add missing vpk120 and zcu670 platforms.
> Compilation is failing when these DTs are exported via DEVICE_TREE because
> binman is not able to create a link for default configuration.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_virt_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 09f487acf0dc..b13079cdf707 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -110,7 +110,7 @@ CONFIG_CMD_UBI=y
>   CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_BOARD=y
> -CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
> +CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-dlc21-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-vpk120-revA zynqmp-vp-x-a2785-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.0 zynqmp-zcu102-rev1.1 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-rev1.0 zynqmp-zcu106-revA zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-zcu670-revA zynqmp-zcu670-revB"
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
>   CONFIG_ENV_IS_NOWHERE=y
>   CONFIG_ENV_IS_IN_FAT=y


Applied.
M
