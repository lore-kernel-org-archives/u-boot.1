Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762E1105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 12:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D010E842CD;
	Fri, 13 Mar 2026 13:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jA6CJrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB7F842CE; Fri, 13 Mar 2026 13:58:17 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E458423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqkuui5j/4tMFaM5s7H2IaF6v803fdDy36rHUUPjm943m7zDgW5REqOMiw0gLrvJVQ2HjvabFKKW2qXruOHYOJw8u9aJVAa707fg/ApKX1KiHlRfJkq9qhsIupDrhALIcLZESA6SvBhuNnoqA17addoxztzAo3145KjMlG1KZv7/4zzBv+GfMNBg6gW831acotmvOuPZ/MFyBV5EWtno2hT6mTD3ZMrGqkgiSVyjhF0K+fKzLZ4aNlwZnQW95ZXg3EQsI0UoYjRDYqE80yewTsLqEh5mRLqta6+hssNodzT0QGDtBDNjVxFGj737dEz9o3myt9N2TDqj2P6lnc6Cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTkGrg6o4dtdj32aqR8IEVYzszxKsVhO9UYnTYTTRNQ=;
 b=Rovke9RAm+voiJZnybDTMTrJUqtmlQwpnlFheKT2mFL/rGzQUrngvvhDilu8d9vs/cVPWsd6YL0epG+gwZx7Lnye+GiHzbN954WN2fM9yTy8ZymonFbM7uMPmC8904HT2qong7O2/eqUUh04CHeFt3HL8OAS220jDGepU7GkjUweFhFzvx9dT+UUyfzkGNE/1p3bEIoWIzmYE502pMshLQ8W5lwNvn/VXSyECKMGaz9OSFVwJdXHHljV5IldvLDZq0aRnF3jdjEsGbtAnIvZu+cGrzapUyCOd54dcmUJ8Sn9FyBzE56zHF32/pfNmLn4wSpEydWrkK6um92aa3PT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTkGrg6o4dtdj32aqR8IEVYzszxKsVhO9UYnTYTTRNQ=;
 b=3jA6CJrljVhCiBjXi1FqDMDzTxMWjahA/6I3/2jEMyxwJHZNdF9+m0sbilFnU0337nafnh4ge/e0RQbp4rgFz+2ql9fVrwzGxJ+kMiVRNjNRqUgP0IiXOHjtu249+xGM55b49vHba+aKxyQYXYgnnlfbgdaltCx19I3zpe/AMSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 12:58:08 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 12:58:08 +0000
Message-ID: <959acfac-fba5-446f-96f2-b06600258854@amd.com>
Date: Fri, 13 Mar 2026 13:57:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0178.eurprd09.prod.outlook.com
 (2603:10a6:800:120::32) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aef387f-78a0-4086-3a5c-08de81002c6e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: xK0RfWVM2q8rwefeEZjM74a9FCXhyS9Dj2raqfMCVl2WmFI/5p8jg23AJtN1KmKzUQC6tpyrTbQRTzuDEUTHA07aLLW6A+K/SCQIcIclU6dQfogMd7O+HDQtt2rNJYBJWHJl67QkkqXalCJQ8npqveqmrv38jS6Pvs4VF1xhu+ZsIHbXdCsnUIEZZJnSGCB2ekTPxgkzDwqc/TscukRJkEhq6mS57YtIUJYzO30D4+UBk1JEm7KsnF6PoU1xmPsG3Ys69qCRCHRr34tjjnPanrJvGZe4flNvjf2yPVR1gEYShqL5EZshVFZ7kh949ibyyzKaR++FkzJOfIEgVMOtyT1Lfzbdo5dF/ZO8SAv0tnxUSUDrp0EfTFNTyF5oSnGa4W1TmYPh2Ld74t3cew9BstWkGaWUNnzjnh8Zwh3teHqFNhHmbkcrJbx4xa8ecHJeqH1o1b880uYAISeWxi6u7aRNJDxuJVnW8cBEjRK1cZcrVifCdQOwKWlymni2gT41aTGNpnDscAmTZ91O5u8OFCfHqPE1w0MAQdS1BMuni0i3EcZfR4rvIQT60sYsTerkVt2tdt2TV4vVSAxW385Tu6cgyJjOqKq/aHtOb4ZRd3RDUHiXGgk2osaCIqSSgCtcJKKj8hfuj8tgzH0nwP5EKbEXOkoGAY6wSPvqKwAPEvHNm+HMjDFXDpJTZAGkZFxzLzodTplaF1ZcDsEKHUMBCkLkA8rXm79K21nt89E5Mo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUErSm1ObzRkV3ZSNjltcHQrdWNCeTdESkZkNzNSR1NudlZPSk5JMXo5NE9P?=
 =?utf-8?B?UVVBWExabk02VVdCdHBJSWV1N0FwSHNsaFJ5eThRSGltWHBsY2d1MGVUOXNr?=
 =?utf-8?B?VzYwd2NITDR2Q3RyMWx5TU15QnNjVzBybWxKVndNdWw0SnpZT0R4dFVhSkhl?=
 =?utf-8?B?OTNiSjgwcnUrTEFnOXhsemV2OGl1UEFYSE83LytCOGxQeGR0U0R2OUh2aTdV?=
 =?utf-8?B?U2phYlJEWUNBcThuaFhOSGZXMFRkeFRhYjFpM3QxaGF2SkF5UmgwVmRYRUs5?=
 =?utf-8?B?QWlKNDg5b3RzVEY1N05qOTN4YUtQeDQvV05GYmMwU1pFY3dFRE8zK3ZBb1Fn?=
 =?utf-8?B?NGRWVytSQS9xRGlyUm9nRGZpZloxVDk5SFdBQWVXMldMZVlFSVlxdXVFTHJa?=
 =?utf-8?B?NFU5M21WVDgzNHpsQVBLNlNsZXZXVXU5cnNTUUlWOHBIRFZSQzIzUTVGbkVr?=
 =?utf-8?B?dTloTzFyNUh4dCtQVFVodXlJS3JiTGpRbEYzcHFTMDdDOGpHZWdPbWo4eVVs?=
 =?utf-8?B?dWxkTHVwNW50SzN6UmlYMk0vaTRJU2FHTjdHV3MyR0VpR3lSUUFQSU5UakZP?=
 =?utf-8?B?SE9QUmh3K2VKTUJMRE5qaXRESGcyelYveDV1WEViNGFZOGNpS3NXRTlNWVk4?=
 =?utf-8?B?dG4vZi9pbXg5OTVWc0ZMUHlLdHpDOXNEWnppSWtpdTYvcWdDcXozWXlyWEk4?=
 =?utf-8?B?VUxWMDVXUmdBbXZRTjZzQXpBWjc5UEJvZGRrRlpoT2R5azIvR215RWp6M0ZB?=
 =?utf-8?B?UmMrMXRVVkR1M1YrWS9nUjJocVF3NmNZZ1dFZ2NaNEl5Y05EdmFjZUZBUW8z?=
 =?utf-8?B?YTRxdHlicE5mdTIzK2hyUDZDMGxEZEtTRW9PaVM1VElXWEg3SGJsOUxsWERN?=
 =?utf-8?B?Ty9pcG5pcURoVnFaWE9hekswa1NuYlVLa1RTOGt1b3lIVkdtdE1TNW80Y0s3?=
 =?utf-8?B?OWdtNnM3WVI3Z0F3VXJQTDhhZGw3dkV0azU1QkNIY1AvK0FPcVg1cU9QWDFI?=
 =?utf-8?B?L0NvV2oyUHZmeWFXOEV6R2FoZlFnV0NYSURGV01jbDVZNWdxR0hTWStCZzBF?=
 =?utf-8?B?TkxjKy9pQ1JJSGJsaEVPbVBxZWlQbU1TdXBxT0ZrT3FwbDNMY3hueVFWRVV2?=
 =?utf-8?B?UWVvVDFGdUk1MEVnMjRmeTY1aTFjMHh0QXdDaHFsckJYOWJRMWdWYUE4dG4v?=
 =?utf-8?B?Y2ZqemZvTDlVaWM0VEJqOHRVSm13STIzK0srWm1OaE1NZWpkUmZNVGFWcS9M?=
 =?utf-8?B?WXBEZ005VytpdUF1aDNlbmUzUFNSbmkwUmpZbUhSc0JiWVAwVHdyYUJuWmli?=
 =?utf-8?B?N1liYUhmTW5qdm1WMURwN0hmcEVPT3hIVVAyOWFHVzNIdWp2b3NIK2lLMUYw?=
 =?utf-8?B?VitIVngzMytFN1NZK1ZYWDRjWldPbVhqa3lnMjFBb2J4eDBXZUVMenVDczJC?=
 =?utf-8?B?MWN2MzBtL1IvSHVmT2JCYTdZelRLQTVJNFNuT09teXF3ZkttSFk3MnZ1TWNY?=
 =?utf-8?B?TmZVY0krMDZYNlFhYlNnQkV3U2pmWWVHV3Roc1F0VEZEQnZTemRhNWUwK3F5?=
 =?utf-8?B?WXlJWEtNZGpUVVNQeUduNVdOUGxRQm5mN2toa0tRVTUyVUZaNkcybXRMd2M1?=
 =?utf-8?B?eXlhK053YVNwTWk5U3RZSFM4QmlGQjdjQkJWN2EwQUFIK1lFWmQrMklYYnJH?=
 =?utf-8?B?bE5vK0ZuajVpcUY0dHNTakN2R1hGMTlwbDlVTU1MeXg0VW1vaEJzRm9QOXIw?=
 =?utf-8?B?NGtTTEFZams3alRHek1EM1RRSmtCVFlJNUdnU2E0OEpmWkJVNU52MW5zTC9s?=
 =?utf-8?B?bmI1eVdjOWZNb2hBNUllbkQzTDdkS2k0WUl2cjhRM0hHM0JsLzBCd0VXV1F1?=
 =?utf-8?B?czhpTHE1VHVOQmhhQnE5R2lMTG9wSGhoUUlVZTFRYjkwcDVjeVpQYkNTdnh4?=
 =?utf-8?B?MEVOeXdLTDBzV1JYK1IyVUpBemlnWm9BRFN3SGpDZ2RJQ3NTOU5SZ0t1UlVY?=
 =?utf-8?B?QUJxU0tQZGJybWs1V1RXOUZLWFl5S2xmTVJzU2kyb3RVQmM1NlRFeGgrdGxz?=
 =?utf-8?B?T1IySEV4N2tRSE9US0ZDdEMwenlYaFFIZ0lSNzZGZHBlM1FHdzA1RDE4YTgy?=
 =?utf-8?B?bkt5NlVtSld5SVp6NDN4cFJmV21pZDRqQVB1OGJhV1g3N0lYRVFsbUJrMi9o?=
 =?utf-8?B?bDl0SGs1M2Jwc0hoNFhoVUM3a2V0OGdYekEzb20rZ0llVzg5dVMzSnMzU3Fu?=
 =?utf-8?B?azhSY2xJMHBQT3M2cEoxanJpcHdtQXl6MW83cm9QamtiOEhRSHhqS3BsTUxr?=
 =?utf-8?B?V0doVDJFdzdNRU1RRkNMZ1ZKZmNDNS9HNEF3Qjg0ZFM2Uk1JTlJOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aef387f-78a0-4086-3a5c-08de81002c6e
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:58:08.0272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfP1nVpIZ3FvyUPCoGg4RCiIejIL+jWMpS7QFf5l3EnHjDdwdo6bfO76Cwqz5O0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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



On 3/13/26 13:54, Ilias Apalodimas wrote:
> Hi Michal
> 
> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
>> during unit tests. Extend this mechanism to be runtime-configurable via
>> the 'no_ansi' U-Boot environment variable.
>>
>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
>> at the start of efi_setup_console_size(). This prevents
>> query_console_serial() from sending ANSI escape sequences to the
>> terminal, using default 25x80 dimensions instead. This is useful for
>> platforms where the serial console cannot handle ANSI queries.
> 
> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
> It really means don't use ANSI queries to detect the console.  So
> before creating an ABI to the cmd line should we really call it
> "no_ansi" or perhaps "no_detect" and in the future clean up the
> variable names as well?

I don't really mind about variable name. Suggestions welcome.

Thanks,
Michal
