Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB1C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 09:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F10E8058A;
	Mon, 17 Mar 2025 10:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qH91omXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D0380F4C; Mon, 17 Mar 2025 10:42:48 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377DC80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 10:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlrVLTNo3qeETOg5r2CUAR9WpZdHKq6ngAyqruHblnWfsy9cIo0yrI6JUvkCbhcc/3ax+UWNc6jgScfEJfYSnSEgx4Helhz4f+3eRFqegAQ1kP+28d1FwaxW33osWWzcoz/xvp7fVoMD2KkMiUVZDhuFwtA1/LfcY2FM7H0Gnm6a76vuIdItUOwAerV9+kXjey97Q5gPIqubVG/+NRNkoxv3N4g8Xp9ZtDvgVHir82s9+QkHMGYMiOPBrZFOU5WiFFZHU7tqP558Cq6eu4LDbva6sSWALh3pnuufZo8KZPwr7KTCs6hqKd08+gX0UGVUoF/K/E5lZAGzPL1lGQPUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/uP/G3CrLdVtE2kR6U14mluWQ15vNxsy17TlI38JK8=;
 b=T34YehOPJ0+r9BQcbC4HAnq64xoP3lTdqrRZaZlcu6LexUPMyooADH6RAgG408GbEuaIPTYHtxIM7iPKgQdkxK42BYQ6O8JyOiL+Y6nEhnpDiGa299aihuzgZbs2+i4vevDO3S6Z41OY2UW2fCBMM7rVjIH/IzIL86R8+cg9uB7TzWLDAgt03m8Or0Af2fWgR1+ZAnBeiDqBxpwrpFkraNj6QX7n6/FKWkzNIUCE5SgAiEOVOV7p5A11Lb2nsa3kbJ5vLAgr6VjJPy53RdJU7fImvy27K8cTF9bHNfxV1tzeEpk5IlatlK+QTgBLlN/Y5zQ6cJrK9CDKz/fRChfYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/uP/G3CrLdVtE2kR6U14mluWQ15vNxsy17TlI38JK8=;
 b=qH91omXXve6YNZKCtm2Vvw6tbrdpXVlEOo9k4RzTYo7tWihWcFU6Ook1Ie1wMhNltZJlktdlqtlfVaeXGR5cwfNNCvobsmOEBjNmbw+Lk6RfqCsbqZOmqBynszaZByNgxT/YVrwqCgMRb+B9iawzu6s78fjxuvRCxE9XNLry+QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:42:43 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:42:43 +0000
Message-ID: <b0e2ffae-a198-42a3-82ec-ec09d466047b@amd.com>
Date: Mon, 17 Mar 2025 10:42:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Allow alternative boot strategies in zynq-common.h
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b6aa62ed-c125-4ac0-8424-d1beba536b58@emailsignatures365.codetwo.com>
 <20250307062948.216102-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250307062948.216102-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 943016c3-cd15-4063-ef22-08dd65381106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkc2emEvMXI0VTAyR1BFQ1g1WHlrb1A1ZHdLTEhoKzkyVkQ3THd6cHYvQVYz?=
 =?utf-8?B?Rmo2a1k1d2pUSVNhNjhCeFlROC9LQldmbTI5d1VseVBtQko3NnE3U083YzVn?=
 =?utf-8?B?cHdWYUdWSExYUkV0MmlLaVdZSFFwMy9CYkVPY3pjMGora3JEcjZ1YmIyaWo1?=
 =?utf-8?B?c1RCTEFzNjZYeTlqTDBXQXhPeFpqV1V4SE9MNTRzNDNKWkNHYkYvMnkwaWM4?=
 =?utf-8?B?bUtsNGs4ekhDQmJraGcydlFwcVM2YVl5K0hqakgwdldxU3liT2MvU3pDL3da?=
 =?utf-8?B?WG10N2N4cmVtdituTmlsMTFKaExWQlJ5RWx3RkI5c3NvY2tQOFNkWHlacm90?=
 =?utf-8?B?a1RzVFdFYlQ4eDg3NmpjMEJ4T3JZaStlVnM1Sys1aGhzUlR5V2E3R1hDdHdW?=
 =?utf-8?B?ZEliWG90VmdpRWF5T0lnakRYQS9nVFEzRklwdDJqVDYzcTE2V2l5YktNTlBK?=
 =?utf-8?B?THMrOE1weFRWUTBVbDB5OURhalFBYm1MQVIyZFBMSmtzQm93NG0wTy9uWVpv?=
 =?utf-8?B?djYrbE81bUl4WHhySS8wQmVrUGROWlZrbkVBMko4akVEVStXOXA1bC9HSDlB?=
 =?utf-8?B?ZzIyOE83THJkdkxRMjY2TG4wYlhlekcra1IwYjZnR25BeGcvWDFUWlhKTzdN?=
 =?utf-8?B?Zno1SnJXMEZ6N2ErQTF6RTZoRzh2NmdmTEdTeHNNMkx3QmJTUEJIQ0tVeElV?=
 =?utf-8?B?UFBhZ3Vhd0ZHeEFFWlJxQ095bytQZUc1TFd2b1V2WFlmaWZBaUg1Wkx6RUp6?=
 =?utf-8?B?OFNWVHV0SngrWmxQNnJoWUpZQlpuZFY1c25OWnVRMzMyNmpNTVFwQUFtOWwy?=
 =?utf-8?B?VGFoNE4vd1BRcDZQRzc0OGd0OVRUdmtTTGdBVmRuWG5YNmIvcC9Nc2FjbkJi?=
 =?utf-8?B?UDB4a2RQM0RHOU5NelZ2a3pva2I0S1dkdlh6NHZyNkh2UnlDNVJraWE3T1FE?=
 =?utf-8?B?dFU5VkFPZ1VCeExKVHphSjNibUJvOUovM3RvNnF2TjZjREQ5NThzT2RTSVNv?=
 =?utf-8?B?TytBdWI2RlFwTENlanJVUUhzOHZtWEVhNjRsY0VEWmRETk5rVjlsb0JvNk0w?=
 =?utf-8?B?UzlVbE5DNzFPcktKYjZrcFd0MEd3NmwyTWJCckpnY245SnRiWnJoenN1VEtI?=
 =?utf-8?B?eTFDN3FQTFBmMXpyQ3NMamNndFhaSTJ6Si9FbWFwcUdsOUF1cjdHVXNDWUdn?=
 =?utf-8?B?NE02bXRsSlcyMDc5WUVrRmtqdDJ3K1lxbHBZbnMrSUdscFAvWEhJbXZYOU9H?=
 =?utf-8?B?K3ZWaURDd0FwdmdLWWFadHhSdWlxbjVxYjVUTlN6QVo2dEEybVZva1hSQkxa?=
 =?utf-8?B?UVp4OGVNdjFLYkVRZ3VNMldXM05XWno3R3VqTG9BYVZCRjVHZDNiT29RSG9t?=
 =?utf-8?B?MmlxQWJpSlo4dDJSYitRQ1I4RWVpRG55RWdpWmhpNFBpNjdMdk4yaVd6QzNi?=
 =?utf-8?B?d1BlK1EwSlBtYkFWRXpmQTk0RHhzQ0ZLSVNhMTlFcXZ1ODFKRnYySUpQR0Vy?=
 =?utf-8?B?L09iWFh4OU82VjBTbEljbkVRK21BUE5FejBRWVNYZEhQK3Zid3Q0cXpCQ243?=
 =?utf-8?B?SkdBZWU4VFBsQnVIaWZtOU9FbHVXcWVKT1NpS2xvZTI4NFFRVVlPUkVweTlr?=
 =?utf-8?B?WkRxTUREeE1iVUIxMUwzSjhaL0tTbjRHKzZ0Q0NVMDRUcE91S29OTFV6eFNB?=
 =?utf-8?B?emdFRWtVdFhML0MwSzJSSnk3azlPb2RlM2JnQlgzV29MQUlLQjcwWmJlV1A5?=
 =?utf-8?B?SXFaK01mZ3dnOU1NcmdBcysyYkNFaUhWTjFld3IzcHVydm5EaytCUVVPR3I1?=
 =?utf-8?B?d3VmS1Z6YXd3alY2U0JvY05DeEphZlJXSUhXaExwMnZWYzlhODVSMlNsTEhM?=
 =?utf-8?Q?bwc4IGzx2FpwJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmEyVWtnUGdNaFRPRVphR3BTSi82TTR4NXcvaHRzTVMrRFhIRjhNUEt6RzQx?=
 =?utf-8?B?YzhrcCt2MzBPU0FiNVh3ZmZrVHJzblFmcXdSWXY4YmRJNVlzb09lbEZOTmkw?=
 =?utf-8?B?SlUyRE1oV3ZCTVYxYS9CNndwTllBK0VLeTFuYmNLNVRxU05Iam5RSFNOOVBW?=
 =?utf-8?B?NExOcGhqL1IyaHdmM0NRWDllSDVwQ1QxM1BrOExtN0hGVEFhSTE0dWZ4M0Ix?=
 =?utf-8?B?Z0UrK2hwdzFrRlB3SFpsMnpwUXZKelIwTkNnYlJUTUZBdkxXeU4zWldXN0Z5?=
 =?utf-8?B?VU9xRzhQNHNudkpnRWxEVm5jMU5LNGt5ZmpIZ3hIRHlqZkQreUlPM1g5VXk1?=
 =?utf-8?B?KzJSSE96aEllYWFVOXhEbS9XRWEwOG5zWkw1dmFTWXFiaExOK2ppZW5mam9u?=
 =?utf-8?B?bEptN3NkRGsxaFRjYnRYQ2pGWThoWW9lZ3hQVEFIT2pvOFJsa1F4UVhPamNS?=
 =?utf-8?B?VFVLRmJVTDI0d3Z6R3RYZWN0aFBTbGdNd1pkNEhFVXBkbDJYMy8yMDNmYTNs?=
 =?utf-8?B?ZDd3WmJsVXRwMVhSMEZiUEJBTFpnQWN1d1ZTMXc4aGFJbnRVNlZFZW1ncTVq?=
 =?utf-8?B?NVJnOStWaXZ6akJzWHozbk0wczNuY3YvbkdMdTEvYkFUcFBlT1BsS2Zydjhz?=
 =?utf-8?B?Lzg1NTl1N2xBelFvUmxnQWpMdVE5YXpxNTEyOXlXOHYyL1BIWjlmKzdEVnZu?=
 =?utf-8?B?dXFJWjRVRFFVWDd1U2Z4YnBBRTZKZUZrb3h1Z09RcnBBbFAyMEFYaE5iMkMv?=
 =?utf-8?B?YmFKdTUyMFQ3ZUxlYlRCOGJOancvZW9XZ2NmakZnRDZHYUdGU2hQVUROTEN4?=
 =?utf-8?B?VTV1SkFIVks3cFZxRys3VzY0Ymk5bTY1c0d0bjJWTXlpREJpby9OWHVHOEp6?=
 =?utf-8?B?Ympmdk15RVk1TWpXL0xkSW1wQmZsWHk1MFpQcWZ3TzZzc2NXcC9mR3dOQVc5?=
 =?utf-8?B?Yitnamt0aTAyN04zWHJ3bW9SV3hrODA0d1RVWmRTeU9QYWl3SHRyRU9ScGNi?=
 =?utf-8?B?MWV2bFFoblhuTWVrOHViZXhPRVY1S09hZ3UySGxWem41ZUVQdGhQZXNNN2Nz?=
 =?utf-8?B?b0E5YzcyazRIemQ2S2VrMkU2RzJxSzRLb2NENm95VDFoQk90eHJvdVJhMk1N?=
 =?utf-8?B?RExCZjByN2ZlQk04K2ZMQlFNSTUxUVQyTkxpbStveUVaZldpZ2VkSzZlTHlT?=
 =?utf-8?B?SHdiTytiMVhmOHRrTTd2Zjc1bjNSeFk4NVA5UERPNkk2cFZOMnlwK1VwTXZi?=
 =?utf-8?B?bG1HclFFRU5STEw5azJ2cUZGZk5EYkR0bUpqZFFaY2FDMWVXVEZkT2hzQ21B?=
 =?utf-8?B?b3o3NkliSWRtZGNYQzQ0MjFERFNQRjNOaGJuYlVONkhObzg0RmRqM0VYN05m?=
 =?utf-8?B?UHIrN0hTZmpDaGVQRkZab2JzZjFaR3l2TzBUelBIUElVTlFRTnArbEVLeEhW?=
 =?utf-8?B?OEs0STNvaXFzRzBac1pNbWxYVVd3aHVJYlhuNDROYTlidW9oLy9XbmtYMVJV?=
 =?utf-8?B?cXpzNkVtc2drdkI5TGdvNXYybk9NN3ovb3FDbTNEdWtmWWlwOWJkSHZmaDQv?=
 =?utf-8?B?dENoSTJOUHlVZHExc0dSOEVMUzN6V1dJZElpWXFCQS81N3pUSkkrYW9SRnFB?=
 =?utf-8?B?T04reWFMU1QxYTRaalNxaFFRZERoVUJGaXlFV3pPcGZzY0dxRnB3YmlzMkcr?=
 =?utf-8?B?V0lKK2dtVzlSMUZGSlVmK1NjeWxzVlJTaENRZ1dEQzNwdE5GRjFFblhidWRL?=
 =?utf-8?B?cUI0bTRncmpkNTV2N3E2VFZQNEdDYXlrdGpwVXVBTktWQXpQSXVEU2VwT2Nk?=
 =?utf-8?B?ZXBXOG5oa2Jjc3pZVmM3UFVaL2pBYWxjOTgwc3A4QThMbGcxclNTRnh0Ry83?=
 =?utf-8?B?dVM2R1BRTHRGQlY0ZjFLQ1BKMExudmhpbllVVVN6OEl1ZlMrOUxNVHcrcGg0?=
 =?utf-8?B?WGpNN0w1amd2aC9tUGloTTlLY3pZbHArOTllU29hZHNCdm1LT2RZcEdRZFdh?=
 =?utf-8?B?dlMwczRFMlVXRE8vdlI0SWdzVys1Q1JSSlJEZDRVNkJqL2JqaUtFWVJIS0Yr?=
 =?utf-8?B?bzFQYW1teHNtMnEyYjRYUHRvbE0xeStSY0xMWVhBdndRdU9oSCtpSFBxS3Bu?=
 =?utf-8?Q?/1u5PUNVEBRRFnRkaGIymSbr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943016c3-cd15-4063-ef22-08dd65381106
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:42:43.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiZViEkwvrIUyQhfsabwNsbO02cXfsgPnPBhLcluXj2cyfZo62F5meD6X71SfXeS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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



On 3/7/25 07:29, Mike Looijmans wrote:
> Allow config headers that include zynq-common.h to provide their own
> (distro) boot strategies. This is implemented by skipping the section
> when BOOT_ENV has already been defined.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   include/configs/zynq-common.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index 37c77aa1611..ad872c9d922 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -48,6 +48,9 @@
>   #define BOOTENV
>   #else
>   
> +/* Only use this section if no BOOTENV has been configured yet */
> +#ifndef BOOTENV
> +
>   #ifdef CONFIG_CMD_MMC
>   #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
>   #else
> @@ -167,6 +170,9 @@
>   	BOOT_TARGET_DEVICES_DHCP(func)
>   
>   #include <config_distro_bootcmd.h>
> +
> +#endif /* BOOTENV */
> +
>   #endif /* CONFIG_XPL_BUILD */
>   
>   /* Default environment */

Just for the record v2 was sent.

M
