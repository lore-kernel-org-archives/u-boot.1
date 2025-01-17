Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C29C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E492580716;
	Fri, 17 Jan 2025 10:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xcR2m5T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182E980312; Fri, 17 Jan 2025 10:45:07 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710078036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW5pxGjNJcjADL7l3cwR8m9y2mlVGctX8iiTgStGFrzQZIVjtcDZvTiSOsHQGCOBGgOtgJ86xlRjXtlw0ZbkRdAu35ZorSGkRleWeJxI+sQoSR0iqJyBo4vtO6LKvsjcQEXOmyIPJovUlDlii5xAbdqK63axd+/YEt6AUbBmyAHMR9xbsqSmCfREaPOO80IjQsC5VNmjRsDUvz8m445ub6NKPwOIYDjyJ3OyCjNaP1WLWOp4SWa1VOOFhk6cWBAMTpNlK5zgdkvEZLrTgF230uH/ZIHeN8AoiRtD+Aj0B12ILLdp89PLXGIPZO1DrvO0IYYt31+JkUpbv3tUEWDZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfA75RzSvfvlRGwG8aFdSTkbGXWxjI4CMt1e2+1D7E8=;
 b=nwC9DbUfDT4dQNbRgWZ/UOuRX3LVLq/PFOzhEUq+18dKkEjHV2KjHLcraQ7abWi9Bl9VtkU0IRzuKKQDSNxg5qRBrAHogW5rcNuCJcst5UIEVe0Ziz4FqgziIwhT/GPgMNSb0F3Yb3xq9rrI5Hccjhn4Mh5ZSl3VWNd1+kKebMgSOtwCLM4ZHP7dXhvAEWcLQ+LMhdS2xqTRZoINEoOyC2dHjsqDLCgELx2GWSG6zFW4lJH6K8sqvcht9UDkyZr43KbZzsZWdidE/JFJXrhJe0fvgYONt15V+qMD4UZBVjZNRf4Fqkc+xuoPe2TshfpVdzv4bID2zbKlzN9OV3k5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfA75RzSvfvlRGwG8aFdSTkbGXWxjI4CMt1e2+1D7E8=;
 b=xcR2m5T4Ab08IrMrR/B5Nvv7s6p0JrVlyJCXkzvKl16ivboQZxvKV04bEMkqV4JOPMHJipnf65s1zJ+CMChhVkQ3wiSefZS/G9Zhz1cDZHSk0bhLJQ9AjoHlB9/i7qUR0CyFOojl10LSPqy3kxDURveqBUKfeQFca1tCvWYVXZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 09:45:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 09:45:00 +0000
Message-ID: <0b5cfe2d-836b-4593-b849-eb4c68d6924c@amd.com>
Date: Fri, 17 Jan 2025 10:44:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH v2 3/3] fpga: xilinx exclusive commands info
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
References: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
 <20250117092815.2986832-4-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250117092815.2986832-4-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: db7aecd8-b6d0-489b-d91b-08dd36db9c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emswQjBQMk5abzRGUXIyeWRNeVFhWUd3TGxOeHFHZWJadGdneVVkLzlNckxu?=
 =?utf-8?B?blE0Uy9MT2FaSExCSGlNbUFXUmJIaDV4YUNWc0c3YXVMZ1FKWXV1eWhoVXd3?=
 =?utf-8?B?cTQ2U3lOTzRZNjNiUEZ4V243dDZBTGFZS3ZPeXp0VTF1cVlqdjJsRjdTcmtB?=
 =?utf-8?B?b1hjZnRWWXovTmdKSW85ODVndUY4YWhWczl6SnhqMDBzSDlyeVFpV0grRjU2?=
 =?utf-8?B?ZzQ5TTRCM1pBbjRCSmh4ZVdMQTk1NDM1NHlkd1M1bCszdVIvOEtuM2dZSTZq?=
 =?utf-8?B?WGJzWHFMRlFzSmlJY1RtNSsxOTFnRlVtTVhCS0o2RWdLeXRnb3NLK3ZlVFZk?=
 =?utf-8?B?YVFTc3dxQVhRR096ZHd0ZSs5a2hjUnJXSGFyckNuTU5HU2w1NXdqNnIrMnYw?=
 =?utf-8?B?NEg5ZzVwdy9WRkJoS0VLSUZWOVdvYlZEMzhjSTJ3MksvSFRnS2wvSWlpUVhO?=
 =?utf-8?B?SXRNR05kN1hzTHNaNGZDTkhJV3hxZFpjaTUxMGNDNlZscGppNklPd0JmVk1P?=
 =?utf-8?B?SXBrK3lJMjFlZjJYc1VlekVvcW4yajhWMUpjampmUyszdDBmL3FJZThCbzF0?=
 =?utf-8?B?Yk03bm1FZ1RtSWF3VzQ3a2RRUFRUMUhCN1AyeFoyRG50cVhuWXRDcmpacW1S?=
 =?utf-8?B?WW82RXdpamhPN1BHV2tiajlKYTdacnZjbEtkdStPc2oyWnhxZ0ZqeHVIUFhP?=
 =?utf-8?B?eHlVTzBpaEV1QTBwT1o1ZCt4WFdtM3RMNGI3cEsvdGczaGpoQzB3VDF0RjBh?=
 =?utf-8?B?b2FPRGY4Z2ZwZ1JCTU9uVUZPNnRhajhPdW5yZGRwbFlKZlNRVzFDRnBOejJD?=
 =?utf-8?B?bjZOYnJjWGNoVlE5SENmQUR1bkNlbjEwQldKZEFnbVoxczRJTkswMmNRODdL?=
 =?utf-8?B?cXl0QTdiSC9ESDk4R3FNenpxeUZhU2lWYTZ3MHVnQXB4K3JVOUN1MGRSZTN4?=
 =?utf-8?B?OVJKVzV6d1g1UitVS08xdFVjcDIwV0RRekhpSndoQS91UWJvckgwNkhqS09Y?=
 =?utf-8?B?WlVyVnhNWm9EVU82SWpCVFpDOTlHZXVFMkszM2x1VStFZ25VanlabWdQMyta?=
 =?utf-8?B?MWVJR1kveDduMDRaeXpaYVE3SVNjaTkvdzUySWpGMjV2QnRoZkxaZFAxYVJu?=
 =?utf-8?B?TVNZNlJXM2tMZHgxQktYVUp1UzhWWURSQmNSMFZ5Z2lZREFCMWhtb2tZSUtX?=
 =?utf-8?B?N3BLV1lGWEMrRjZTblpBWVNqeXJtVVd4Y1FSbWNFeFhLejQ2YzZkVmJBMVdq?=
 =?utf-8?B?dlpvNWx4a2lydTZSWnJpM0RkbWNQenlNb1hVMUdJdEVkd2pJMXdqMllMM1N0?=
 =?utf-8?B?aGpOVHA3UVQrMUpOQU1YcnRZeTlvSnNXdnpIMXYrTnhxSVNVMDdGS2FJU09O?=
 =?utf-8?B?WUFRZW1Fa0toZmFzb0VPZmw3YlFWNUJDYk83NVd4ampDSXlVUHNTdzVySUdZ?=
 =?utf-8?B?K0VHYkxBSmx4OEFYazlwQWhJTUNHRVVqMUVwNXBkQ3BhS3B4d2JRY3pXZDU3?=
 =?utf-8?B?WGs3TE8rMTBpNnBUU1AwbDVUbVAraUZiUmFyOVUxazdSTnhFM1A2WHJzUi9H?=
 =?utf-8?B?dWl6TXZtcldma1FiQVo3SmpBRDE4TFNZTDE3M3ZYNEp6dmtYNUx5YXQra1VJ?=
 =?utf-8?B?dkorZ2hHbW5hbU5GMjhzNjdEUFBPV0Mwd0IwbkpIcmRET0NDY3Y4QUU5b2k5?=
 =?utf-8?B?T3Q4WmtyeVpTQmt6YUdvRTJCQldNa1hQL3RWSjVtcmdtN3QycVlTandkVkRw?=
 =?utf-8?B?dXlBakp1ODJBUlB0dmZwc2pRY21UdVg2anJiZC9ZM012UjJYaHQxb1k5R0ph?=
 =?utf-8?B?WTdZakMzeTM0UjU2OWYxRDRjTnhsSlVCR2R0T3lwSnRQQXRJN2UxdTJvWXZF?=
 =?utf-8?Q?ffsxsLmBTbyZw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lrOHg4NmFQUld6WmFGeXlXUmh0NmR2b0UwdytyU3RTemxrNTlCMTUzdkpD?=
 =?utf-8?B?a2dKMVF3ZjgwRlNlZThlQkhsYjZ6R0lUZFM3dXJqbTVGcnZrMU1lTDRadWpx?=
 =?utf-8?B?MTdLUWgwQjAxdW5QZEdDaUJ2V1hVWjBET1VZa2tBdzdnVVhYWEtoaWI4a0Ro?=
 =?utf-8?B?TE5JU1lDWmMvb2l2OFdpRlJnVGhWYjYvMVdtblpidU13S0ZKc1UzazlCbWNV?=
 =?utf-8?B?ZGdOMElKS0J1by9wYytJb0V1N095UU5aT2V0UDE0Nk9wd1dwRU1MUFI1dllk?=
 =?utf-8?B?bzFkVjZmb2loazRRb3dMbFF5Qm9JUEpic3padXZlSnZKaE9wWVVIUkU4b3Zo?=
 =?utf-8?B?OVBXcFVhN0NLS0N3RE01djZ1RnhPbGREdG9VUDNEZGNMeG9QWTF0ZFZIOE1I?=
 =?utf-8?B?SlRWbndFL245ei83Y1ZWazcvL25pbGdMaE55QUVWSVNDN3ZpNnVSWVJWVlRF?=
 =?utf-8?B?WDM3WFRrOThlc2YyUjAvK0RPeWVlSjE4RWswdTV3SHhIeGNIR3BBZDBrZjYz?=
 =?utf-8?B?ZVhtRkZqZDZWR0wwUVpHZFE4aWhUbnNnUTdnRkk0eTFGcjNsb2syZWI5L0Zo?=
 =?utf-8?B?TUFWbit6UTB1OFo2azcxMGhZWVA3Vzh5VGlZSit6RE5oNC9sdVlLWlFOL2s3?=
 =?utf-8?B?ZmxvcFRNYVE0Z3NyM3FnbjgwSTVkaWFKSmF0MllIdjN5YWZ6VkgvNDNvNjdK?=
 =?utf-8?B?QVdldm1LcjUrcjU4RENMSmowbldseXpIZjFXWnh3UTJveDF2REozOXBDbnpP?=
 =?utf-8?B?ZmVpZm5sSkEvcUs3b3NtVDg0aXBUeDR2MGFGYzdoUUs1bWZDbzVSUEtlck5h?=
 =?utf-8?B?VEt2cEdSa096bElvWm5iOERLSjczM3VHb2hKaGVNVUpZWmxIenBnWGY3dmcy?=
 =?utf-8?B?VFJqL1VVb2NwVkg4NlkvcmNnb1l2V2dFc1hiZ05XL2FTYXk4WmFjMGRmZW5V?=
 =?utf-8?B?amdxRDNLd3JwYzZMVi9BRC91dlJGdW5ITVB4OVJabmhMTDJWeU82c2h2M3RJ?=
 =?utf-8?B?VzVtd01CTktkYzRIVzAxbFlkdWl5bGpiTkpIUUo2NnFoSXZoTURnWDBETnd1?=
 =?utf-8?B?cHAzR2lTOTB3cEpvTUR3MEF6TUIvVXd4TGRiLzFzZ09ucHpycXhFYXMwaGpo?=
 =?utf-8?B?UE0vVlRSRHlVZVhrNU5XbFNCM0dCd25kYnA1UE91UWg1RWFiZThBN0pWNjky?=
 =?utf-8?B?MGtjL2lhT1lVUlhGQWVwOHRSUGEvb3dMOWxQMTkvQ3R1bVNWbG9LZUxWa1Fx?=
 =?utf-8?B?M3htL2Y5YXJjcnhzbHFsWEx4RTFFeHlOelh2VDVMK2lYMlhMSHc2T3lpUnlz?=
 =?utf-8?B?UFBPb053TVZUYUhjdVFTbTBVNXkwdWxyaXVCR3BUSm5mNVp6Mm4xcm9UWk8y?=
 =?utf-8?B?TGFpc29wMmtxdVRzQnA0RHF3YWtYTE9VcmZHM1J6QmZOSktJdkpIRVJqNHJh?=
 =?utf-8?B?MWV6WUlLNldWOGdCcTVRL1pWUm84VjlJUXFwSVlUUkRlRlh0WUw5L0xVb0s0?=
 =?utf-8?B?SVVHQnFTcXNrMktrUDNPZ3U2Q3NSazVVNXA2WTN5akxZSmJ2UnZEWWtyWW9H?=
 =?utf-8?B?eGxhTEw4cWovRk5lbEpPcTdSUW1yekE5MG13ZnIwZFFRd0s1RUxZa04zMnpp?=
 =?utf-8?B?ZndYZStyU0NhZlJmOUMrSktaejdjWUVVcGp3bVZMMm9VbStocFVNRnZUQlp0?=
 =?utf-8?B?UDRGTnBYZkQ0dGU5WnJ5UFNzN2JlckdZNTRuUnVwNXNwR1hvekVEMVYxYzNU?=
 =?utf-8?B?UFpjbHB1N2M2am5oQ2VqajNCR2wraC9KNVduOXo0VTVJbzRDZGFUMDZJczBU?=
 =?utf-8?B?T0lXR0xMWGNUM0tpL3NkRUhOVjljbGFiMDhidWYrcDdoRjA3WmdEQzRLYnhn?=
 =?utf-8?B?K05FdlZHeG9xcFZSWHNVZGd4ZXlWdHAvUTVQSFhNRUtQeW1xQnFtcU9tMWVW?=
 =?utf-8?B?d0VLc1IrNGJmcnhkTWFteHFDbmx6anQzZUYrVlNBYWdsOXJYVVZ5aVJlbm1L?=
 =?utf-8?B?Szg1WEhFcE5VVTR6VDNlVjQxeWEwSU8rRm5EdlQ2OTBDUUU4OEZZSjNYMWJJ?=
 =?utf-8?B?a1FSQmpCTjhTemQwQ0I0R2h5c3plbFVhSHpJVmlqMnZ3SFlyR0FQTXRxbkZF?=
 =?utf-8?Q?J2XIaxMu+uANYup7pWVuvLX/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7aecd8-b6d0-489b-d91b-08dd36db9c3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:45:00.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KvFbXkoDab4KosnsCIkwgEKplT9LiQ9BuOt6pEUVOzTPNTNlmhdB8AxJDSz9dzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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



On 1/17/25 10:28, Ibai Erkiaga wrote:
> Remove statements of Xilinx Only from the fpga command information and
> ensure Kconfig dependencies to FPGA_XILINX are implemented instead.
> 

you are actually doing more than you write. You are also resorting commands 
which is kind of messy.

> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
> 
> (no changes since v1)
> 
> Due to an issue with patman I had to add an empty line on the
> CONFIG_FPGA_LOADB description
> ---
> 
> ---
>   cmd/Kconfig | 32 ++++++++++++++++++++------------
>   cmd/fpga.c  |  9 ++++-----
>   2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..31f1df2a67d 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1163,16 +1163,31 @@ config CMD_FPGA
>   	help
>   	  FPGA support.
>   
> -config CMD_FPGA_LOADBP
> -	bool "fpga loadbp - load partial bitstream (Xilinx only)"
> +config CMD_FPGA_LOADB
> +	bool "fpga loadb - load bitstream"
> +	depends on CMD_FPGA && FPGA_XILINX
> +	help
> +          Supports loading an FPGA device from a bitstream buffer
> +          .

weird

> +
> +

one newline is enough.

> +config CMD_FPGA_LOADP
> +	bool "fpga loadp - load partial bitstream"
>   	depends on CMD_FPGA
>   	help
>   	  Supports loading an FPGA device from a bitstream buffer containing
>   	  a partial bitstream.
>   
> +config CMD_FPGA_LOADBP
> +	bool "fpga loadbp - load partial bitstream"
> +	depends on CMD_FPGA && FPGA_XILINX
> +	help
> +	  Supports loading an FPGA device from a bitstream buffer containing
> +	  a partial bitstream.
> +
>   config CMD_FPGA_LOADFS
> -	bool "fpga loadfs - load bitstream from FAT filesystem (Xilinx only)"
> -	depends on CMD_FPGA
> +	bool "fpga loadfs - load bitstream from FAT filesystem"
> +	depends on CMD_FPGA && FPGA_XILINX
>   	help
>   	  Supports loading an FPGA device from a FAT filesystem.
>   
> @@ -1182,16 +1197,9 @@ config CMD_FPGA_LOADMK
>   	help
>   	  Supports loading an FPGA device from a image generated by mkimage.
>   
> -config CMD_FPGA_LOADP
> -	bool "fpga loadp - load partial bitstream"
> -	depends on CMD_FPGA
> -	help
> -	  Supports loading an FPGA device from a bitstream buffer containing
> -	  a partial bitstream.
> -
>   config CMD_FPGA_LOAD_SECURE
>   	bool "fpga loads - loads secure bitstreams"
> -	depends on CMD_FPGA
> +	depends on CMD_FPGA && FPGA_XILINX
>   	select FPGA_LOAD_SECURE
>   	help
>   	  Enables the fpga loads command which is used to load secure
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 91ccbee0fef..f46ca040d28 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -412,19 +412,18 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>   	 "info   [dev]                  List known device information\n"
>   	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
>   	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
> +	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
>   #if defined(CONFIG_CMD_FPGA_LOADP)
>   	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
>   	 "            with partial bitstream\n"
>   #endif
> -	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
> -	 "            (Xilinx only)\n"

You are removing Xilinx only but still still no symbol for it is created.
It means when this is applied it will be available for other vendors too.

Feel free to create two more patches (in front of this one)
1. resort entries in Kconfig
2. introduce CONFIG_CMD_FPGA_LOADB with also using it around do_fpga_loadb()



>   #if defined(CONFIG_CMD_FPGA_LOADBP)
>   	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
> -	 "             with partial bitstream (Xilinx only)\n"
> +	 "             with partial bitstream\n"
>   #endif
>   #if defined(CONFIG_CMD_FPGA_LOADFS)
>   	 "fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>\n"
> -	 "            Load device from filesystem (FAT by default) (Xilinx only)\n"
> +	 "            Load device from filesystem (FAT by default)\n"
>   #endif
>   #if defined(CONFIG_CMD_FPGA_LOADMK)
>   	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
> @@ -436,7 +435,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>   #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
>   	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
>   	 "            Load device from memory buffer with secure bistream\n"
> -	 "            (authenticated/encrypted/both)(Xilinx only)\n"
> +	 "            (authenticated/encrypted/both)\n"
>   	 "            -authflag: 0 for OCM, 1 for DDR, 2 for no authentication\n"
>   	 "            (specifies where to perform authentication)\n"
>   	 "            -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"

M
