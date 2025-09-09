Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EABCAC585
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0CF82A9E;
	Tue,  9 Sep 2025 07:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tAZsvnnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3628E8312A; Tue,  9 Sep 2025 07:58:32 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F232680422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDcvd9nbDJWkl5AER4WQIcTBXX2GgtsUuhuP2h/UAT9V3isISse2EtPGCPtEOIXivp3Nyxw0avGVk8U7teQFtbsVlYetz9dq9Owrw18CCnAqda6rMmEBxgI4GQ0VVq9rtkVgBGW17X7ifjKpl7QH9l9SPzD8v3EX6rrjtAtFy+a5me+q9LpoeGmiT3HEINeWkQDv1L13Q9i8Y8J/XfCi4PzrZwHTrWUFy3v/XmEsEcsiYM8z08lMkx3qCSsdM5g/md37FkZeqW2n/uOZzTFfu+2m+4YdBV9zcuaqfqXS5skLGvUZxY+V1C05vuCv4AS1mQATZ0dEBOOnW5MnA/dZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiYFa3DJwj83qCAunw+uiN6HZj6QhY8fd9s1h/khQXs=;
 b=LE4TxBltaIV3erIp9qVE3z/8FIbJp8nGjIM3z0zfDv1qMD7rophlE/VXF8FggreJ7zOdalq9sECMdzONXyvIxqSkgJodrdZGESv0dKyIYSceu2SEvcmbSJ60k1SclyuMgQIMsCXaZDArZobnTNJ95X7qKv9Ye0t71Kh/W+8+IGze7bwcMYJkpbEQ81DZzeMBU32baRNrgkdrCRjzQnpOZMEtkOzfyMJXhHzf6oyD60bE1KpEj4a/+DrAdJhaB6dcgKkaOH1J0faB40p2AMlENtv7IvKgtojSf0Qt8Gh/OQLfNYTQ1bGsRfkl98TYQnVEHN3L4JVIdxDcPPhx73bn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiYFa3DJwj83qCAunw+uiN6HZj6QhY8fd9s1h/khQXs=;
 b=tAZsvnnOvs9OHKXNQg0WYctgENncqU7YQ/oTSh6oV+EzgkkH2bzkD2GxEsgbpzvDKIuq3WB9SpaVJ4T1JdXxrGZoTO1QHQJNpGhRh246O3EDuTAaYHMAx8W5CsDQiMNC8vOqoFLz3pr4mxgPxTJdPAkSxKq1o6eShEXQdWMRRB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:58:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:58:27 +0000
Message-ID: <b1777068-071f-4a69-9155-372dbd1c451f@amd.com>
Date: Tue, 9 Sep 2025 07:58:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: cadence-ttc: Insufficient elements in array
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250901-cadence_pwm-v1-1-140b04cd73a9@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250901-cadence_pwm-v1-1-140b04cd73a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f9b0bd-ad69-4c0d-7bb3-08ddef65e4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWE1Rko0T08rWHpQYjJJRTVQTHhZNHFTaGdiaXJCWXAvb0JWT3EwVlg5eWVq?=
 =?utf-8?B?OWRSbUJFNlROUTBycVRDVkhmaFhYUUtQclhDTWtrNk9zb1dXUE9sdUp1b1pF?=
 =?utf-8?B?UlJsK0UzZFhST0hUeWc0TDhIai9MZ1MvelNRYStCV1ZuZzFHSTZFNHFYSGtC?=
 =?utf-8?B?aU5iaGMyczZMaklIejFicXBjV0hIejVSYmlzU09NZzBNUFNaL3hzZW5oQlA1?=
 =?utf-8?B?eCtxb014b1dCdzI2dVRTQ0k0djMzSTV3SC9zdVRNRzUwMVdtZnNVMWpZK2hJ?=
 =?utf-8?B?bzI5Ujgwb3o4RzMxSWU3Y2tubjFPdE5DelJsL1hXaVFnNDFwOHZweElNSHFs?=
 =?utf-8?B?WUpvcE4rWGdmeEFVVUhtV3d5S0pjSFBsSklhRHdJMHVDeW9zdm44cW1BOGtJ?=
 =?utf-8?B?U1ZpbmRmci9GN3NqRFFsR2s3TGdzZkExaFg5MW5HUHBYeFVLNjBzWW9vS0RI?=
 =?utf-8?B?VCtscis5dENSTWNNK0IrWjcyWEZ5OFg3WXV6TGZOMTM2UHdnV09tUExHaFVY?=
 =?utf-8?B?TFkwYm1kNFNYbFRMVkxTUXN2T1B0T3ZBcEdEdEFOaGM0NHV1dGN1STk0OWFJ?=
 =?utf-8?B?eTNabVFIT2NOUS8wQlFhK1pjWFE0eDc0L2dOT3QxKzR5c0QyYWRRVFYwNUFu?=
 =?utf-8?B?NmhvYjZSaTU3YStPZEpYUnBURGdRZDR3M3hhR2lNN0p5V3QrSjhDMlNLS2p5?=
 =?utf-8?B?Y2YrcEhyeDAzQzFDK2FZT1RrekZCN0xMazVZc3h0VzU0Wm4zOXlrcnVDak4y?=
 =?utf-8?B?dTBDSm1VTXB4NEV1UFNldFM5OEpkZzE5bTZIWmc3a013R2NjYnR3WVQyNUhy?=
 =?utf-8?B?c2NEUlhicU5XYk5neUxNTEp6Y2dyTUREOHIwdjhodXNORTBsRFFiaFl4b1Rj?=
 =?utf-8?B?MVo2Q0xQTDl4RTlSY1l3eXlXQisraXRHUFVKMkZqdllQYy9YeHRCVi9DUHdF?=
 =?utf-8?B?dHU2Q2t2OFNIUWcwVHpaajRaNVQzdlBBQk1NRzFLczd1blpGTzhiSXpOdFJE?=
 =?utf-8?B?TUt5ZDdHTFlIMS96M3JKZWFBUkc0UFZTREhGaklXcWtqM2dNN2hVSU5HYmRt?=
 =?utf-8?B?OEZvS3RKckxXUElwbS9pTnVZbm9JbEcyUGNwSlZ2eHQrMmttcHgzSFd3V1Z4?=
 =?utf-8?B?dTJzTUg5RHluT1RoeEZ6VStMVVQ1SXJ2VE82MEpaQWtGRDdCZkhXbHI4QjZx?=
 =?utf-8?B?WjVITjllSVBVOVVkV012c3RHM0VlZWI4T29KSFdRSzJEUndxQmcraThqd1hw?=
 =?utf-8?B?cjlKY3RhTldDQ09QMzYzSHBXWE9pdmZqUlM3VEJnUVIvUU91V3kyaW5wMFpC?=
 =?utf-8?B?ZlNlOUJ4L21XNWZBSU90SitHb0xkSkt0RjlQY0REcGJLQ0piOTZRbzQ2OHhO?=
 =?utf-8?B?R24yQ3N6QWxPT01pbmZnRHpEZ00rMjBFMmJTVnIxNzN3d0lmcmpaQTRMaklI?=
 =?utf-8?B?UXc5N0h4MW5VWlY5MzdZY2k1M0lrRDJ6MlRBUlhKTHUyUTFuSjYxVithZUVR?=
 =?utf-8?B?NE8zcWs3OFJ5YWptblF4dGZkY2txNFBKalpIS0l5YVhBZ1dCb2YxVGMzRHdO?=
 =?utf-8?B?d3VJNGRhNXJHdjRCTWpXYXlaekNDYThob2VKd3VBeHRpblpTMXkwU2Zzamgw?=
 =?utf-8?B?eWlXNnJ6a0dQRE80NXorRVJ0dTZvT0x2dkJPQmJlbi9xQ1o2SUh3OE1rU0Rp?=
 =?utf-8?B?RUd3NHVFam9uYnR4aEttUTUrOGsxekFhZW1Ob1NWdW5tblBGMkY1Ukp6V1hM?=
 =?utf-8?B?bUFUdis1ZU53Z1ZITno4NTZlQzBJVUVTOEsyU0FtQjc3TllTZ2JRSFk4RjNl?=
 =?utf-8?B?ZkNTR2dKN3cvNkFNOWxQcFJ3OVJFZXVLTzBET2hkMDFrd0MxTTRoTXdZR1Q2?=
 =?utf-8?B?b1IwZlc5OTIrUXVUMll0cTU1OXErVEdsZFBwdmhYcE9XNDJkVDNLK293bXlR?=
 =?utf-8?Q?wDhFIHYxI3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1Z6eFRRSVpJQ1ovd29mN1ZMRDBlc3RkQXF5K1owYjZLd3RQbnZKeUUxVkxE?=
 =?utf-8?B?T1BUTExpNEZsTUZ5UGEyb3hCOFpaNXdSRkxCRlpvZElwRHVwcDNOemZqS21V?=
 =?utf-8?B?QWpBNE51SXFKUXkreHRvZkNiY3lzYTdnaHprSXlaT0ZUMW5STEI4MTVuMnNU?=
 =?utf-8?B?RFdqRjU3bXZBdkRsNnNWSi85NmpvMGRwK1N5cVcyRXZoSTgzQXgrUlJhRDRq?=
 =?utf-8?B?UHhyd2tRakFSK01RMVhMV2VpcVZ5bEpmcGdLbGhiKythR0dJZEUrcWh3Uldp?=
 =?utf-8?B?K1J6RVYwSHgwQVF3UWo4YjdxZU5iWFVaYmtEVlpnK0pINUx1dWF0aDBYWDlT?=
 =?utf-8?B?cmZucSs5VHN2dVNhdm1pa3k0ZjRIWHRZR3ZmeXErQ2FsUmNWVjNlRmdRM3lM?=
 =?utf-8?B?ckt0YUEvd3FRRm90ZFV6QnZwR2tGTmhQOFJ4WnpVRERneFg5SjRxUy9oVGVS?=
 =?utf-8?B?N0srSnJDR3FtNzJSMWVURUNUNGNjT21VSE5QYnJLazdiSnFSZWhNQUxXN0dr?=
 =?utf-8?B?ZEVOcFdkWm9XM2tNWS9lUkczVU1pWkJJRkRYSkRsN0gyNVRrZ05xbkFnem9G?=
 =?utf-8?B?RDRSQzF4QnhhUytKeUU3TFJHYWtiQkt5ckhEM0drM3NrODROVEdUbTRHVkRD?=
 =?utf-8?B?NzQ1OVhmcWFGdU9UTWFYN291UHEvS1ZBazNVWXFITE53ZFVmZFJDMkVuUHF1?=
 =?utf-8?B?bmVSYXJVZzlHWUZTU0UxLzdzWXZ6T2h5M2wweFM5YnJzeWdHSmpGc1BKZUpO?=
 =?utf-8?B?VUViQWptMGxjbnFzQWI5aGtDUU91dGpmWGs4akxpYXFmeE5hbDZsNEJMVzlL?=
 =?utf-8?B?TS90L3hWWUZsZTQ1bmZ2Y0tjTzMxSkRocUFoeWlrY0NLTGRYUkZRNVBFOXdC?=
 =?utf-8?B?RVRJblZhd3ZuZjhrMWJiNVFhZW52S1VNYzExZ2Npbm0vUXdISmxFZTFlZjht?=
 =?utf-8?B?N3d5eU1zcENSbGE2Qlk2S01NdU95bS9IejAzcWxqOWhZN0xscEZ3cmwyU0lP?=
 =?utf-8?B?Q1ZhRmNmc2oza0d3QXpBQmRQTU9NbnFTeHJDUWpCNkZJOS9zTGk0K29vOUt0?=
 =?utf-8?B?TW1NaFhZVUhhOU1CYlZaVDNxb2R1QlFKd2NhdCtWcGFORDlycHRSbXV3a3ox?=
 =?utf-8?B?RlppMFJKUWYwV3EvWWFRSGdQc1dVcFR6RDBoM1FuVndydlVNWjE2UFdtM1lu?=
 =?utf-8?B?NWV3WnpmMXY3bXVkR1R0a3RqWXMwRHV6N0VTYTJjbEhSUHp5UTJ0ejRFZVk2?=
 =?utf-8?B?d0FERkY1RlUzNlhsbzRDc2tld3IvVXhCdzU1MVRiUnZncVNwbXBMWEQ4NFMx?=
 =?utf-8?B?UXlpQjhnelVrakVtNXc3MW5KVW45V21rMWIxVUxWSng4d01hU0ZDeU11bjRK?=
 =?utf-8?B?T3o0M3pubUVzcXc2Qk8wbGpydnk2dUFSYzVicU93NS9pVXNIcmxSM3RLUVhI?=
 =?utf-8?B?bytIdDF5VGRGV3ZzSDZ4RXN4TE1ZZEFxMkRMZWw2RVRRRlF1WnowV1B3WnBZ?=
 =?utf-8?B?UTFZVlVUbmVnVVhXMVl2RlAyd01jc28xNGxkUVRCKzQ2ZjJqZ0RMaHF2RHQ0?=
 =?utf-8?B?TStBczQ1d1NPeU5yMHpHTE5PaHhEUTh2Mk1jMTNuTm1wNklQU0NnRFBqL3FT?=
 =?utf-8?B?SnBWZG9iV1NpSVFMK1BlQ0RIRDdXdy9MMlJjQ2V0dWVDbmZCcTQ3NXRQWk9v?=
 =?utf-8?B?Y2duekNJNnhveWZMV2FYaDV2K1RlU2RQWkZwaEd6TXRzT1J5dWc3MzBIZFlI?=
 =?utf-8?B?aHE5SmZtdmwwRTAzMm56Q1FMKzBFSVM0V05nWExESTE4RHA4cHlObmh1K09x?=
 =?utf-8?B?Sll0a2FiUlA1NDV6eHZGc3crc3RGeFUzbEFCWVI2WGtrNHRyVEk5YjhvbFpj?=
 =?utf-8?B?S2FEdDR3U0FJa0VuaXZmNVprYmpHMmRMSmxZK1RIT1FnRW0wUHVmV09sTEdV?=
 =?utf-8?B?Tm5IOHpsbk1tVDMxSXhiMDRlbjBPL0gxY1BpL2VxaFp2Z21UekhPZitreUtX?=
 =?utf-8?B?NldvR1d3RXIzL0JVMm81dGdWOXdjQkU1NE1DNHdPWDdxeUVoTndUT3pjbS9N?=
 =?utf-8?B?Z3B6VkFDZ2lNVDZhR3BoSUxrd1l6bUp4WXNqNXhkbUhiTXdEVldWZ1AzVlA0?=
 =?utf-8?Q?FDI/JTq/6hgfJ/dSaiohrz9fL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f9b0bd-ad69-4c0d-7bb3-08ddef65e4cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:58:26.8191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN37fS32gKIml42EnNYELpLS0sm8b31eH7BK8wCEGDDUW4rY1J5Jr8GWJm932jP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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



On 9/1/25 19:00, Andrew Goodbody wrote:
> The Cadence TTC has 3 channels that can each be used for PWM functions.
> Ensure that the array has sufficient elements to avoid a possible memory
> access overrun. Use a macro to keep the array size and limit checks in
> sync so adjust checks to work with this.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/pwm/pwm-cadence-ttc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cadence-ttc.c b/drivers/pwm/pwm-cadence-ttc.c
> index 767628833bc..fae6d5a1739 100644
> --- a/drivers/pwm/pwm-cadence-ttc.c
> +++ b/drivers/pwm/pwm-cadence-ttc.c
> @@ -47,6 +47,8 @@
>   #define TTC_MATCH_1_COUNTER(reg, channel) \
>   	TTC_REG((reg) + MATCH_1_COUNTER, (channel))
>   
> +#define TTC_PWM_CHANNELS	3
> +
>   struct cadence_ttc_pwm_plat {
>   	u8 *regs;
>   	u32 timer_width;
> @@ -57,7 +59,7 @@ struct cadence_ttc_pwm_priv {
>   	u32 timer_width;
>   	u32 timer_mask;
>   	unsigned long frequency;
> -	bool invert[2];
> +	bool invert[TTC_PWM_CHANNELS];
>   };
>   
>   static int cadence_ttc_pwm_set_invert(struct udevice *dev, uint channel,
> @@ -65,7 +67,7 @@ static int cadence_ttc_pwm_set_invert(struct udevice *dev, uint channel,
>   {
>   	struct cadence_ttc_pwm_priv *priv = dev_get_priv(dev);
>   
> -	if (channel > 2) {
> +	if (channel >= TTC_PWM_CHANNELS) {
>   		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
>   		return -EINVAL;
>   	}
> @@ -87,7 +89,7 @@ static int cadence_ttc_pwm_set_config(struct udevice *dev, uint channel,
>   	dev_dbg(dev, "channel %d, duty %d/period %d ns\n", channel,
>   		duty_ns, period_ns);
>   
> -	if (channel > 2) {
> +	if (channel >= TTC_PWM_CHANNELS) {
>   		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
>   		return -EINVAL;
>   	}
> @@ -153,7 +155,7 @@ static int cadence_ttc_pwm_set_enable(struct udevice *dev, uint channel,
>   {
>   	struct cadence_ttc_pwm_priv *priv = dev_get_priv(dev);
>   
> -	if (channel > 2) {
> +	if (channel >= TTC_PWM_CHANNELS) {
>   		dev_err(dev, "Unsupported channel number %d(max 2)\n", channel);
>   		return -EINVAL;
>   	}
> 
> ---
> base-commit: 4a2f360bd280b2b5af1c5daffbc189590c83c995
> change-id: 20250901-cadence_pwm-61d1815e7752
> 
> Best regards,

Applied.
M
