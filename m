Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C500DC77B7C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 06:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B68088A2D;
	Thu, 29 Aug 2024 08:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmEH5v08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD8C88B0A; Thu, 29 Aug 2024 08:34:05 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C42C889D2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exi9Inb7MyvOjbb2K+PFxKxT2VBS7SHVu91VytcCrFStWexJyzaq/1hkfE3dUaHZiAYhk+tWF5J2b2KIWOdQPVO7BGe7pVhLBEM1Z1Xw8twK9T97VuIW/QESRkbubG+P11JrIAt9PO1rITvY3eRu+qktPTCYwk59SzCzPl22LrFPCKkYlVgr3kYAxXlHA/wZ7RonlTOI8zmHGe3DwnEJoD95ACEZqgIMfhHAbCzxq0fmRJr69a4t0UftVR0xezYEbp3+4KPwWhX1UZFOk+wTkO/Ikn12xqcAZhzGMCHnp4yMMjE/yaTlF9S+DpLQdJuSzfogCrDAeIcgZiDLbFCf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9aPTi9QaY/UP3ZJVWEbTZtfMPX2/D8WGWMbnXlV1T4=;
 b=FmoNJKepjvTBosv4BMH98Tk6aWFACv2ZmU21zFSop/EGUQr2IgmEPLLde11bR5RAnMCyqbNMb7lylQFOOe+th5cNaR3rOOzDrdZ4LOaObcZCAVz+JAa9cQ3Tu3re0qC9+aasCgZABm5Y8OzyyRy/PopHTx3MHIcnUlvrldzjpEbD9nx4XOxjMWrnH6a21LY42jSPfMxmhl/aMitbEjFV0t5SGNHikvvrP5GmqODkOJ/jYYQbScspmAXOR0tCXqIyNqaaUkNa7m1yKK08J5IGOCcXvwKZS3IFkH/T8yc9wfRwSRjUNOtLTanUPQGTGmyc676Tpoq18xKaHjfnQ7z6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9aPTi9QaY/UP3ZJVWEbTZtfMPX2/D8WGWMbnXlV1T4=;
 b=cmEH5v08Jmfj82+k33cY/gC2j+Y56r/6uXZax8HuPkfH6w7PDrLAzBeqJSEwdCT2m+i0E2vCY1D47sx3LhkkQEjcl7aj5cfOElWcj/+pw6MvEEghuW2nvw3/EREKA9jh1F0noI67AW6SSi0nvFIJwlQknND+XoCwT0j9vmKW678=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.29; Thu, 29 Aug
 2024 06:33:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 06:33:58 +0000
Message-ID: <561f8918-a3bf-4a0b-920c-da7cccf2c617@amd.com>
Date: Thu, 29 Aug 2024 08:33:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py/tests/test_bootstage.py: Combine stash/unstash
 tests
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>, Simon Glass <sjg@chromium.org>
References: <20240828225610.3081635-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240828225610.3081635-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0100.eurprd09.prod.outlook.com
 (2603:10a6:803:78::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e7be43-fa07-4891-988a-08dcc7f49026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTlnRnkzY3MwK3I0RENBU0JNbkVVbk5hWTJONVR1ckZaaTFsZS9tWFVFcWp4?=
 =?utf-8?B?SDBvanJpS1V3SFZUV3dRaHlIbVYxenBqNWxESWkyUmFMeXBOek53dEhuU1Js?=
 =?utf-8?B?bkR2OEpSK1lpcU5JaThUNlhZSnA3Q0JNVE8zRWRyMHRaUkRZMFBjeUxHTDZz?=
 =?utf-8?B?cEFRMmJFRHVYalc5aVIyd0psK2NmcTJ0SW41MWUrZWVvOVFkbzMzVnh4anZo?=
 =?utf-8?B?WHc5YmwrNU5jK2U0SUdkdklXYkNhWDl1ZFhoTUNxK1BXdWh4YlVQMFhuM3pp?=
 =?utf-8?B?MHZLT3dxUUY5N2UvN3RwVGdQckl2bFJkRWpsSkRhOTdibzhPVEhINUo3Smtz?=
 =?utf-8?B?bDgzdmk2dWtIelNwdkxzUHZaNndCOWJCSlYrdmdGTnU5dnhVZDBvUDN6alUz?=
 =?utf-8?B?U0U2Zk9MVXZaaitxNFA0eGdjQUdkbWo4U1lERTh6WVd4OHhFbHRYVENiVVVi?=
 =?utf-8?B?Vk15R29kZDVaY0xKTldzSkF3STR0dFdkc2lPNHlBZkhFOXR6Q1diZ0ZvVEhI?=
 =?utf-8?B?QzdOTm9OdWtTNE9XSUllcGhzcmtvVUlsNERtNnNSWFpyQTN4dktxUVNGVi9E?=
 =?utf-8?B?TlB4bFJwWUJieGxoUVhxdlJYbSs5OTFvVTBiVzFFQnB3OXM2VmlXNU04SHdZ?=
 =?utf-8?B?WDJxMkdRMFVreDJ1aGp1dGF3aVZqc3l4d0FxQ0FtNzE2T3l1c1djY2hQeXVY?=
 =?utf-8?B?dCs1K3hiYUhXWjhzbkw4OGhJbmlsd1gwYnpNTGNaTnRDR1dYS3ZyTjA3MHJL?=
 =?utf-8?B?S3BBSk01Y3V4RFVEaTQ4eWhPQlRwMHdpTit6S0RTWkYvclpPSTJDdTVtQWZB?=
 =?utf-8?B?Y01OWnBYeHhMMll4a3ZlQzZlRTFuQkNYdlJPNVB3WlBRN1VaaUUvcVliRFBx?=
 =?utf-8?B?SnI1UVNlQzdZTE5mQzdyc2cvaW02eXZWTUNTNGdIdEFPcUxkS1N0K1ZxY3JJ?=
 =?utf-8?B?V2NWQ3ViazBOVjMxb3VEWEJXdk9nLyt4aU5RNHA4UHlXVVdXNGNJYzlEL2tY?=
 =?utf-8?B?Y3hhdGZ2c1R5YmhNTUlqM3dnRUFxWTFTbWlSRGxqdHlUSWxzRGVzVlhCODZx?=
 =?utf-8?B?aUxBYllqdXp6NVZZM3IwdHZBM21YNjFqeVNFaDBkWExsN0ZydjNLQWNpTm9X?=
 =?utf-8?B?YnhESHRwTzhBR1NRSS9pYng2MGFHUldxZmNIVDJXR2lrcWdZUGlFMjl5Y053?=
 =?utf-8?B?anFERFdhN1ZEQVY1bUxSeEhIQzlHc0t4MWkxWDI3K1hURy8zWVIxQUQ1QWJO?=
 =?utf-8?B?VWJlQWtHaU1OYnlhUXJLdXFoYXRhOUJudnhLWkpCZ3d2VE93d3JiVFR6ZW50?=
 =?utf-8?B?QXd6Nll5SVozbTJqMFNLcFlTMW1ZV0lJU1NjaGpNZSs3Z1l2SzhSaTBRYzZN?=
 =?utf-8?B?UTJzWk51Z3MyWVBZaFZzNEw2WlZiS3l2dVhid1Q1TkxxSW82NmNQS29wUWpV?=
 =?utf-8?B?TGFXMzQ1VHdQQW14eURwWWJQblNtS1RXcnNmeU9vb1ExaDVPZDNyU0RuUkVt?=
 =?utf-8?B?MDdLL0t6VkV4azVVQ3JmUndVV3piZWdPVWFMaWZycXIzNjdBUXYxMTBIY2kz?=
 =?utf-8?B?VnIxYzlhT1BuUEdVQU8yTER6bkZJU25vZGMrcjJ5TElIclYxbFMzN0FRUUFh?=
 =?utf-8?B?WXJNZE91QnVoWFJwNDAyVmR2SzZjZGRPbjdQMEV3Q1RJMnNkUm9YdmFnTEdV?=
 =?utf-8?B?Um42LzA3VVhncWFqTFBYMHQxMVlHUHlEQkpwS0YvT29NM2kySU9HWVk1bGZw?=
 =?utf-8?B?T3FtSHhYOHFvWEV0NlBYa0k3S1VZU1FvV1NmZisrVjlaVDRuWW41bm9uZXpD?=
 =?utf-8?B?WXc3T2VwRlNTeTNiaTFWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0wvYVZYam5iQTNLZEVHWEhiUlYwYkRWWkdoTE1LUWl6Z0JBYm9pbkVWVE1z?=
 =?utf-8?B?cU5wUEljNlh6ZmxINWtKRG5VRy9Dc2xkaFVFR211cEo2bEZrNEZBdUkwdlQv?=
 =?utf-8?B?clNxdkpnWmlYZ1plTEY3QmdjcElmOHJXZlUrd3FaL0tzM3FKN1Ezbjl2ajV4?=
 =?utf-8?B?OHd1ZGRZSXp0VDlOT1BIbk5zY1JzeTM2UU5ETis4Rnl2YVpTVVZlbUxlNm9U?=
 =?utf-8?B?ditYTWhvUDdVSURuL0lIcitkWGgxZUVNRE5qRWY2K0NUY0g0dnA4VVBtQ2xp?=
 =?utf-8?B?a29HenM4ODNmSTdaNlR3RWU1cDFlNXBKR1ZnYm9BQmk5UGpHdjZFdTVtdmVO?=
 =?utf-8?B?S2dROWEydU1mU2ZWVDUwWTNLZ2F6ZmpwWDc0S2E1UTF6QVV3UUtvQmxZZTQw?=
 =?utf-8?B?WTVGRGxwY2JydVRxYmtuZG9XRjhFVFhMVTJyQTZUN3B3cmh1YTNKWGtneGhj?=
 =?utf-8?B?ZE1EMWxsVHZJdjc2aTJwVGVxa2pZaUR1Q28vNDdSUllzVG5Razg0eFkwOTJz?=
 =?utf-8?B?Qk1qVWd0QndjVGEyNDZzZk9VeHk5SEw2WlFqeTFzcHZoS3c5ZmxkV09rUFEw?=
 =?utf-8?B?Tm1wRGZPcGhVbFF0V01BQWhQVFY3TUNoVTJKY2NuN1NVd0hQYis4aEVWc1Av?=
 =?utf-8?B?K3hMaXY1ZHpHbFRwb1hjc1RkZDN6K0RSMno2NDMwV0c4dzNGZUdrem1VcFhy?=
 =?utf-8?B?ZGJyUDdIWlduUlB0ZTZFTlZwYmUvZy9RcC8wNW1OQWRrRnZ3YkkwTmZFbTZM?=
 =?utf-8?B?U3ZkdFdTQ2hYL3dEcmZqWUMrNEFhbTBVV0o4MUVIYzJvekdvZWlvMGJPMGov?=
 =?utf-8?B?Nmt5bzQ2VEV0K2VLZzBNdkZ3SEtLaFdzUDgzV3VBUjRGMjBob0J3dXpmdDFu?=
 =?utf-8?B?V01TM2JjTEJndUtrRnY2VnQxL2ZXaUxJRnRnRm5JajZwb2tBR2VVb3NaSDFu?=
 =?utf-8?B?c0xSNkNucklQVVF5ak92ZGFFN01qUE1RZ1pmQmtrUE1OWStRMGVNNnJLdUhX?=
 =?utf-8?B?eitMcUd6a2JpOXA5d244V3o4L2wzL212Q1lObFZ2L0ZBZWI2L2JvVkt3dmhr?=
 =?utf-8?B?MGVra1FPMzVEbyt6eVJraitSUFg3VjVrcloyckJWa0hXNXFTWFArZEY0WS9O?=
 =?utf-8?B?Z3VjVlp6bkpLSnNocXNNeVgrWGUxYUEvMlYvVC9Ja2RlM0szT1lYd0psYmlQ?=
 =?utf-8?B?eDl3VlZ6U3lpYjNDR2JPR1RJNUJGZzJ2dTREV0FPU2NxRmVRM3JhSmxrdXdD?=
 =?utf-8?B?c3BKb1o2eWVVb3lIZFdmVjhxaC9wRW1vODZVb3orVk5LbmZXako0YzVSSHRF?=
 =?utf-8?B?aXZWM0k0MVQwbW9xRGFvdGpkc3BKb0NjMDdUcTFTUXR4dWJWYUc3U1BIWlMr?=
 =?utf-8?B?TlFSRmhOVkJQK0FubXpJajVEUmlRSDREWjBOeFJRckY1VXBaY01jRlprRDBM?=
 =?utf-8?B?cUlTRE9DUi9lUWtlMFpyZnMwMzZKNUpGZE1RWHJjc2VGWFpUOHdnb2l2U3pm?=
 =?utf-8?B?Rmh6VWZoaHlDQjFaZHpTZzZYdW50ZkZMMzEzQUZRay81bm9YRHRQeDN6elZr?=
 =?utf-8?B?UDh5S1BkSVE3S3JZUUQ3RGowMVZaUzRScGlwUUhXRGFweG05YVpOZDlmQ1Vp?=
 =?utf-8?B?RkhodFppQ2JnZmYvdkFlQVZjUkFmUVlGQTd2a3BlZ0t2SWFTTXpmMTlaM3V1?=
 =?utf-8?B?YlUrcFpJMlF0aXBqM2s4SGYyK1pjQVFZSjV1eDlicm9aWVJLaWtNK1IrNDNW?=
 =?utf-8?B?NmtxQmZXclRDQ0FkS0xHT0VUbjU2Vk56cEFpTVh0NUFBL01lTXhHOWd2WCtC?=
 =?utf-8?B?L01aSWJUT0QyUGo0Tkl2QlU3ZmU0MnhWNzV5bThvclE0RkV0QlJ1bkpxYWFW?=
 =?utf-8?B?OFEzTlA0OXZSNkNaYVg3SFJLamp6SU05K1VsY3dubEg4WUNqZHFuN1VybTVh?=
 =?utf-8?B?Y0UyVjV6aU4vQXNNWUVuMFpRVHJ4YUw0dWYxRzZ1ODc5dEY1SWF2aC8vV3lB?=
 =?utf-8?B?NFJ5bzEyRTc3dm1DcnZRS3pUZW9CWUdBZDVUMGxZZGF6TFYzU1JqTzBualZF?=
 =?utf-8?B?a2ZGcmlud2pheDlhMVVaeUlxTVlydEQ3RHpiZ1lVTXZiWmx0RjhPelJaMUZm?=
 =?utf-8?Q?1Xp6ahM2o+U31B+4J+ML89Cw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e7be43-fa07-4891-988a-08dcc7f49026
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:33:58.6529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtljx9vjEqgHEHLmqZVdnyRmsqr7QsllHGaloUXWejCa1/6aCgs6nNz+z77oCvfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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



On 8/29/24 00:56, Tom Rini wrote:
> When running the bootstage tests currently we get a warning like:
> tests/test_bootstage.py::test_bootstage_stash
> ...PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py::test_bootstage_stash returned (37748736, 4096), which will be an error in a future version of pytest.  Did you mean to use `assert` in stead of `return`?
> 
> This is because the unstash test will run the stash test and fetch the
> addr / size from that. Rework the test to be stash and unstash and then
> run the unstash command at the end of the current stash test.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> It's possible we could solve this instead by getting addr / size again
> from our environment file, and then also noting that order-wise the
> unstash test follows the stash test. However, this felt more clean to
> me.

It looks good to me.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
