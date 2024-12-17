Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C34E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A251801F9;
	Tue, 17 Dec 2024 12:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fux5zKUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F1F801FB; Tue, 17 Dec 2024 12:03:28 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5AB5801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3fgR60DsqQeJxCpaejKRk7EFrfW8xwYFBqE+p7STe+/TSeLuGuPz7z8djP+sXaiuNgMG1kOet8hKBGAqQ9yARjKx289Tiqq8mPmSG3gxR9wRyvnVfczONncsAPMeCID+HiX78+HG1WQcc4Co5noCFGdfuyUR/RzlDToyIbznx8d+EBhnRH5hJrXX+W8hby+qke7RyJho109gaabT/kJcXuGyxOd0QDFC/NG3fz2X3LLQSzpdGU+DBxWkwn8N0921Ml+B+EP34qaL9QRii88RY290EA1W1xHYFw8vEwc3QaQa4DVWtYcxNZIhEKg9Inc+aItK11Xiz/eD5BmPT7FrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH3AqE1ghkiikT7SOt5s9fMphH0YnS/C3QE7bVim66w=;
 b=dHt964hmFcdznohpjH0EXy8FUdmpRFLYx9RpLE9aYqbKK2RJmyAz2BETzY1oXd6hNpY0HCmfdk6YLvto/fnfAoyJ0R1ezeU+lM6gzGZLpzTcoR+OrpgQ4CbGifgdrMttkC6iVANaICGhmQxPit6Fi6DwwHs7MDgiIPIWVbEjH+AUcVgQbryhuMN+Yc5+IJCTmHxdlbWlQ1t4meMe7z/DXWeEelwoaa15abNx8g+Pwvb8DHmfsR/a8fQMjwp12S6CdjxEkTE0SxEeRtUbcFkT9YI1Avrgfjaq/1cbN+yM3yNZ/g5b+ZXuQTAH1CAnamzsmTtZbjjszIH0aZJtuDUMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH3AqE1ghkiikT7SOt5s9fMphH0YnS/C3QE7bVim66w=;
 b=fux5zKUX/cdTsMm2rAvyzHQ/wjQQl7af0l+dE8Nc3jiWfkjM3oSbXmcenkDDEqcda0MMcoeGVfreVujAKGld7CAa8X9d2Fb/hOyGmHHqqnguZXLo1lFMpzvW/PDGf2LRo9aHwr+4Mx00SZ4xCRzbrBLLMCinRaYzz3FOAttKKkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 11:03:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:03:22 +0000
Message-ID: <2c0fccf9-07ef-4d05-92a6-ed9bd5a9e517@amd.com>
Date: Tue, 17 Dec 2024 12:03:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: versal: Wire SPIs for dfu_alt_info variable
 generation
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <67ff88c8c7186138353c0b74ed37a318fb4b199e.1733395093.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <67ff88c8c7186138353c0b74ed37a318fb4b199e.1733395093.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0275.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: a974cc79-4a50-45b7-e009-08dd1e8a6bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkQybk1TY1dTaXBJWFFIc0FHZFNEQzZyWFB4bDlrQjlDa0dyRVVPdDVnd2Vp?=
 =?utf-8?B?OExjU2NWaTRpU1hkWUVSdy80dndQSVhkaTJrTU5yTC9YeEd0dXdvMWVEL1cv?=
 =?utf-8?B?WHhhOEJSaGo2ZlRTUnplWkorNnN1dm90TE9BbWhoMXhCYzJ2UDY4eWhvREt3?=
 =?utf-8?B?T3RQZ1k3Q2NZNXBtbEFTZ0RMZE5Pc3p3TmEzVUdQSHYzZUtTcTAxNHV6dXpP?=
 =?utf-8?B?QVBLdmVYMWxzOEdBNnFEREFobnVHMTh2eHAvbHBNN1RYS1dRRHVSdVp5VjZj?=
 =?utf-8?B?NEJ2Q1JUWEZ0NGl6VzNad2paaEZBNzZ4a1FwQjd2YmdPY1dTT1QyUWRYaG8y?=
 =?utf-8?B?cFluNkRCQ3RhTVhOMDl1ZzZiODM3K1B4YVhkeGxDZTg2Z0lYZ2tKNlllK1hy?=
 =?utf-8?B?bWQxWWlhQzh4dnJzaDF2OWFtTWRRUkZlSkpNdzk4citsVWUzZmxxMzhZcnZR?=
 =?utf-8?B?WGNjYzZTVEFLblE1SG9Sc0U1b3U5MkVTczJIcjZ1R3k1QVV0d2lzZXZlZHNo?=
 =?utf-8?B?cGtvd2hTUi8wYWFTb3AxVVFsa3ozNVNLR1k5cUdOc3ZqVXlpR3ozZklISlEx?=
 =?utf-8?B?aHUvL2QvQXV5dERBN3d0SE4rblVrRld3WTZUOHMxdnBJSE9MQTdPVEd5RUhN?=
 =?utf-8?B?dzNqVlpNMHA0a0YxYmdBUzJWOUFYYTluUUI0a0pER1JWa0h4MlM1cUFPR05a?=
 =?utf-8?B?ME93TmRpNEhCYkU3UVpnL3UzQ0V3eVNCcEVwSEwzampNM01aQjVXT2lwZHR6?=
 =?utf-8?B?a3E5UGpmakh6NTV4WTAvcVBRYWIxMWVLZmlZcVdKd0ZkcmR4RGdTVm1LeG5j?=
 =?utf-8?B?cjExQXlKK21seStDSkJJSnFLLzkwNlFyRkViOGlVdE53aEl3SndINHV1MkVq?=
 =?utf-8?B?Qm1qalM3Tk84SmM1RjJxbk5nNWVSUmFzd2xSakpmN2VBUTkwRU9ETVNoN2ZC?=
 =?utf-8?B?c0ljaThPNW4vNGRrOGV2SldIMDd4RzVFT1haZTlEdUFqSlZRTmRyUnJFZ2Uz?=
 =?utf-8?B?K0E2ZmVxQTRtbWVqWk00QUhnOWpFZnMzbjZmVUJCZGI0RnRhNjcrUk14b2ZB?=
 =?utf-8?B?S1plMnkrS3BlWjYwOCtlZmF0Rzk5Zm9LNzVXUm1uNE1BcTNPZlZPY3RkVDZE?=
 =?utf-8?B?OVFBQUFTeDV6RHhGR2JCNlBrdmgvLzFhL0VPRVlkbGxCekxHNTZZK0kzcGJ4?=
 =?utf-8?B?S1l6aDBrR2YzS3I0UVZaR04vYVhxMnJtRXZZU0RzUW5pcFROSW81TVIxVXV6?=
 =?utf-8?B?NXl2TmxWQStYTDdrR2FkM3RFNHpMTzNNcUYyM1hCaEk4TVBIYWpaSE5XNWM3?=
 =?utf-8?B?WXRGRkFwWnFJSldSbU9NVTRLY1RFZ0RuQ1RVV0VGOWZ4WnB0eTlEb3FuT2xw?=
 =?utf-8?B?dlIyaG82cHVjZXlveHRPOUNZM1hpNWpnZFN6WW1MMTBhb0NJTDFEandNMU5X?=
 =?utf-8?B?QVphK3ZPUUM2RWlsTGZpQU5WbjFVQVZCTFJhMVNIQnNWMThPTFJxT1RkNTBk?=
 =?utf-8?B?YjVjZzBxT3p4OVNrVjBMUXFsdFZwZ2pzUXZhdlBFaTZCbjkramU2dUk5VmdV?=
 =?utf-8?B?MUFiMjZoYUV0VXRRcmppakp3N1VIYjkwV2l3RDB3eEN3aHdxREp4MXk1V3Yv?=
 =?utf-8?B?S29SbkEzYURZZWluS0VKVndvOUF4L29HTXVkTDJDZmpGY0xQSWVrMDNGTW5v?=
 =?utf-8?B?Y28zV2NybnFUa0hnNXpRRmFoOWdydmdNMjF0Q2VZdjA0ajZMSm9GbUVNTXB2?=
 =?utf-8?B?STh6MUpWNSttRjBHa3l3bXdFaXQ5dlloUTRmMmlDT2ZUZ1JMdGxuMU8rSSsx?=
 =?utf-8?B?SW9Ca1ZPVUhLNWZMZG1xb3hoNkY3bjZnR0kwSDllRXRTenJ1RUhCNmVjTm5V?=
 =?utf-8?Q?W9X4yUmhCvu7z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlI2Mkg2dXU0V1FwR0I1YkNycEhDL1JQa1FRa0N0aURBQ3ltZjFMMjE5VzV4?=
 =?utf-8?B?eEorSWNXNjBHa05saVBoMStWaEZKRE9WaEpTR1FwTXdoNHpsZVJhemdtTTkz?=
 =?utf-8?B?U2ZQaDlneDhyWis4VU8wR25uV3VMSXFQc3hhWHlldC85aDY5VUt6TFcyTE9W?=
 =?utf-8?B?OGYxV0poRFZTMEJaTk1iY1k1R2pwdllJazJEd29WNmhYNEpPTW1UR29pQnJZ?=
 =?utf-8?B?Tm9Ib2pVbnE5RDIvSTBna2ZtdCsxZXZ4VE1sWDdiZC9qejdyVGZpRHlyNzVv?=
 =?utf-8?B?bXROWXltYmZ3ci8xNnlrRzJ0blVNWmV3amV6d01LRUVlZjh0R1BiZFVnVlIy?=
 =?utf-8?B?ZWpkdnF0K2JZbTUxMUk5QmdJMG80NDB4OTVqb2ZkallGeS9UZlFQRXhDNFdk?=
 =?utf-8?B?SytPWm44eDdQVDd0Z29GSVkxazU5VTk4UFQ5bzF3d0x4ZjcvNzZnWVFocVA4?=
 =?utf-8?B?amltajhiS2tWdENTUVVWd3lBSHMrNU1HWG5Ha0JxTXZaR3B6VEtoYSttUzBF?=
 =?utf-8?B?Y0JGcmEwSGIzTGJaQjI2Ry9FblJDVFdFWDhzK2kxNmVjZDdCRlNncm1jNUJs?=
 =?utf-8?B?ejQyUkN3dUdKY1l3Yi9aVyttWDNuc1V3Z0pTZ1pMWDZ6NFF2VUZhS0tDVEpL?=
 =?utf-8?B?aTNNcThlYVhwN1VaTi93TWh1NHNZUU56RThxSXZoSHJDbU0wN2pQb3pNM1FY?=
 =?utf-8?B?cTk0aGRLUy9DNnNhUCtHT1MrMWxCMXpHOVhrNjdZL01keEh1SXpHYkR2UzJT?=
 =?utf-8?B?QXN0TEViMFlINkZMVUo1NTNsa3hkbFN1TWdZOEZaQ3NLWVl5Vm8rMi91RTFN?=
 =?utf-8?B?eVRGYzVTSVBwVEd1VGNNWFhEcHFXY0Myd2dWQ1ZOcXBNL1g0RE1heXloUUo0?=
 =?utf-8?B?aDRjQ3dCeTU0YUlYWVJLZDJ1eGRtOUppNUF3OU15aUtoN1FrQlF3ejM5SzFN?=
 =?utf-8?B?SHErbmJvVWpCSFBXUW1iTzZEbUJqeG41c0tmbEVsejNMQ2FwVkJOWUNVTGZq?=
 =?utf-8?B?SzI3Nld6dUxYUUZVNVJEV2dBdEMzYTBmOENmbDRSWG02VTNqN0pqLys0blVS?=
 =?utf-8?B?MldpK0ZuWnZuY3pHazlqcDBNTi9yaWRLQzU2SklobkRvZitVY0NBcVZXWTBD?=
 =?utf-8?B?c0ZrQXhZUU5mRFFwV0FyMmUwbHZVZ3N2YTJFbW4wandFWENWaDhQd2lOSHhx?=
 =?utf-8?B?UDVhZzRtUkRTR3V6WVExVFM1WkpVdUdsVm03N3FkcFV1Ky96UG5GWEtPUkEy?=
 =?utf-8?B?dzVhMThsUENYZWhPTldlSUpwZHh2UmNOYzk5OXNvbzgydk0zVjdEZm1yUG1l?=
 =?utf-8?B?ci9vYUNWWldHOHJFelBXRms4bjljWGxOSmg5aDY1NTAxSjUwRWUxZjVVWGNp?=
 =?utf-8?B?SXg2UFNVZTdwbFBCRldUdHFUN21qNmIwUXRLL1VQSFgxcVNIUlFxeHNWVElu?=
 =?utf-8?B?TDI1Z0FGSUh2bGFEVHlBLzVTbDZHNy85YmZEL25MSVZBVTMwNW55WENDbHMr?=
 =?utf-8?B?SUIxd1hkamxrSXVyMGExdEZucVJadi9qWDRpbWl5VFNodUxLazlBOGdEa3FM?=
 =?utf-8?B?TktGT3cxZXp6OEh4Z2ZHd2hwM0RZSktyaGRPNlF0QlByTVVTbU94RVl5WEl1?=
 =?utf-8?B?MGRmYlJQYy9jNVVvendDWStwWjloWCswV3liREI0UmZBSTZkTUxXU2cxbm5z?=
 =?utf-8?B?M1FDSGowdHZyRy90b3JCNWordlBtanZ6Q3A5azlXYW9BalBvSnJVTk4xS3FH?=
 =?utf-8?B?L0RmUVgvUkN3eDhSa1NaWnRLOVBjaS9aQTh3RlR4TEsxY3daZ3dCOHVBaE5T?=
 =?utf-8?B?V0E0TklFNS9jWE9UdHVxbkRpSFUvdkxob2pOKzV3TzZRcExobENIeXN5ZUQ0?=
 =?utf-8?B?b2xsUEZZNVVzMEFkRDlyR1VuRHprNWFLWDBXbmovNjdjUFFsU0V6MUQ0S0VL?=
 =?utf-8?B?dE9FMENHOEl6VURTTG9ham5SNnZrejJSNTh2MTJGanNDaDM4ZlN3WUhzcmdC?=
 =?utf-8?B?eThJZTIyb09mV3RUS2xCbms1MnNHWDBpd0NTbFVBNWRaRm5Tbk9GK0NOY3RP?=
 =?utf-8?B?OUEyM3lwek1lZHZwckhzNDhNMXM4RlZmL0wrYVMzRDNGdWJQYk9haVh5N0Nv?=
 =?utf-8?Q?nNK6B60pH033zWdtZe/y3xxy9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a974cc79-4a50-45b7-e009-08dd1e8a6bc6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:03:22.1825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBbThogQV7+jK0IhuJNzQKTGGh+u172NODClTpIXWB3kUEd+qlB9RNIqksKdplZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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



On 12/5/24 11:38, Michal Simek wrote:
> Enable automatic dfu_alt_info variable generation based on MTD partition.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/versal/board.c          | 41 ++++++++++++++++++++++++++++
>   configs/xilinx_versal_virt_defconfig |  1 +
>   2 files changed, 42 insertions(+)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index fd5c6ced7956..964a779b5f19 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -14,6 +14,7 @@
>   #include <malloc.h>
>   #include <memalign.h>
>   #include <mmc.h>
> +#include <mtd.h>
>   #include <time.h>
>   #include <asm/cache.h>
>   #include <asm/global_data.h>
> @@ -346,6 +347,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> +static void mtd_found_part(u32 *base, u32 *size)
> +{
> +	struct mtd_info *part, *mtd;
> +
> +	mtd_probe_devices();
> +
> +	mtd = get_mtd_device_nm("nor0");
> +	if (!IS_ERR_OR_NULL(mtd)) {
> +		list_for_each_entry(part, &mtd->partitions, node) {
> +			debug("0x%012llx-0x%012llx : \"%s\"\n",
> +			      part->offset, part->offset + part->size,
> +			      part->name);
> +
> +			if (*base >= part->offset &&
> +			    *base < part->offset + part->size) {
> +				debug("Found my partition: %d/%s\n",
> +				      part->index, part->name);
> +				*base = part->offset;
> +				*size = part->size;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>   void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	int bootseq = 0, len = 0;
> @@ -371,6 +397,21 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
>   			       bootseq);
>   		break;
> +	case QSPI_MODE_24BIT:
> +	case QSPI_MODE_32BIT:
> +	case OSPI_MODE:
> +		{
> +			u32 base = 0;
> +			u32 size = 0x1500000;
> +			u32 limit = size;
> +
> +			mtd_found_part(&base, &limit);
> +
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +					"sf 0:0=boot.bin raw 0x%x 0x%x",
> +					base, limit);
> +		}
> +		break;
>   	default:
>   		return;
>   	}
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index c8f166c12218..fb757c1067d0 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -83,6 +83,7 @@ CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y

Applied.
M
