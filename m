Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F6FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E8784713;
	Wed, 29 Apr 2026 12:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ggcnrv4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32D384715; Wed, 29 Apr 2026 12:27:41 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A31DB84711
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7+jfVO4Hwn5ze8UdRruQaK9muP4SOybmRuHZ7azDRr9/NG6vVEz2B4os/WJFqMfc8UIBkJQotfUTFmYsz1mdpqb7YZqkZ4Q+7w/iLIftbtSf4n/eg3rXy/jcag4My4XYES+n0NRcY+c3kC48zA/KHMiF6OcxBOrRF8GpSqXdlv1cHyz1HmDjeaQsUUgIJfkCwFx305NBm1ITZ80jbdIBzjMo9DnuHi4ev8bAxPomwEJBjB5jHP2aOi5cTg55OE6CQGF41YXucJWsq1VQ9uFyYs44/NPcFtxkPFuOKyUpwu3HaZ+j36mrUxnwbLetOmIXvSuNXm8afowh5kXWvWUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ndo54+S9zz1coQDB68zmDFWP/dJ+aclP98O+7uOnTGE=;
 b=yp1lFqhv+gDhJwesCGN4GIChb7LZSyyoCa+ZLnkjaPiCpCz5GY7lsQV/nfWQ0KJfs82fY3yOHXqzMF6NTEh6DcU5vrGniZ7A98ryFVRd0jnClkv8DrjT3KuTdolFa2e3WWiZ6YCmoZ+7z3xLSxCuvceECK03O6kDB8l+3jsgRzM3Ne8ctu4J/WhDxsDqNraFo99gt1uRhBOYIcLtFZjK2rtlb7PQhXmg5eMwC/YhdO3XBI3/EWUT/rSuU7DZTEBozeFNSsOYAwe8ral7ShBWBexxx/ft5xjzbA79Pdt4tQowfdLs5ovcvnDaxYuN/+Rg8sC6UpCKU+HyAPDhHlAf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndo54+S9zz1coQDB68zmDFWP/dJ+aclP98O+7uOnTGE=;
 b=ggcnrv4gcA3iZnwjT2U0Z926LWmOcfn/cIHdELMg24t8l+xJPI3ijyCXlNCt+vj8crYQZtM2AmwM2lePZVSl3xpvcUKLCUVcwVv5KOZMQdknXM+S3wgUvHFs/Y3buiWjOxA4oMhKcaXmwzV2BmTVvdSjbgBBBFU/lpPu+Fi8yLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA2PR04MB10348.eurprd04.prod.outlook.com (2603:10a6:102:41d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 10:27:36 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 10:27:36 +0000
Message-ID: <311c790f-98c3-4415-b227-7eae33c1e64a@cherry.de>
Date: Wed, 29 Apr 2026 12:27:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: wget: validate URI for lwIP
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.denx.de
References: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
 <0581216f-2e6c-4924-b7ee-058d892e5b2f@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0581216f-2e6c-4924-b7ee-058d892e5b2f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA2PR04MB10348:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cbe345-5d92-4578-cc01-08dea5d9ed06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3ZUhVp59lg8Ze+ky0yp2SNB5XPZueifVFDzvCSu9duizfsfcBl8hnHbXvqeaoDSSDOo5IhwBSLgBEj6oYhnD9excDdbZgXXHSzyCAsNe1g/5txVRi85E9iNFdhLjxjQ+BiIjNizr0EAEEX82ErGgOPsl3T+V1m9Jctq99ptyouEgWBFgpCDJUmmGTGZ1w1E+2VPwY/nmQFkVG+4hrS0leSxFgYGxrT9aGiULGmmR5BvCMtrRl7sJrXPTdx3A6do9WHvM2RJxPaqia5KJREAxDUCIGrHH8eTkevQ6+oTdiJe0zCZYfAE3urxfN5lYUcVx+9cYEO+4+qyqqE7GeuD3qggSw9OUKfwdkch414zezbm28jFZcQGwWX2zkI6ZvCPgKkY5Pv6vkuiVWgRGCcEGP0OkopnLdKOjr/7AOzRI2SeARFrSb78ZPVjGcZE9iDNie8emg3EV8/TJ6QTjG6djCnYqemlUuUezf3uWYylXjOmAamymKWdY36CNxoYNWayzQsIYcT4ujzBkiHXi9EJf6TAuN9Nx7Hj9+I2eG+OCJhDB4/mxImkw6fDij2JtjDfe2hkef8T6wU7SrNsdzHQC8L+V4VItoMHTlGuuQ1UPgtvm76x7cuxcuXVAdZE5neicbbWBGU8qCXXWKEoTw1TvQesmFV8OHnBx/OAqJ2SYpoR6slBm8xMsD9aNJRv+ZkfcLRHAr9Eh7btmnh+tzo5Gzx/8HuUGJ0UiRGmzHK3+5i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGMwaW1sN3RZYnl1UEh5QzNJMlpIMVIrSzNFT3FJSWE1TzBlWk9OVXFTWCtE?=
 =?utf-8?B?bENDdk9MdFFOazVtU1NwT3ZCZXI5cGpabGU2WVgzT2dkMEExdlR3RUdxUXJO?=
 =?utf-8?B?Y3c0V2dBZW1tQ1V6NlFCRlVobVk4SUwyUUh6TzFFWVFEdkQwZFViTEM4NjVh?=
 =?utf-8?B?WmRhSTFKZFJDd3c2SHIzU3lvc0Z2Y1pRdVFmQldIVmVJUGg2RzFHbG1IU0JG?=
 =?utf-8?B?TUkwZ2RmUG1ZdDhHWC9TZnhUS3k2eFdLdHEyS08yTnVRNzVzUEtmNzEwQm5y?=
 =?utf-8?B?Z3hxUXZuZjJJNHowTEVhamh1a2lURUlYc0dIU1lKdTkySTVlMUJUdGgwS0Va?=
 =?utf-8?B?L3FlRi85OUU0aDF1K0Ixb2dVa2NPODFBWm5BMFN5YURKUllncnJmTVNlRk9V?=
 =?utf-8?B?RmVQYzZKR1FLN0RoOEpZYktSQUFnSTBVWUpZNEQrY1JjeEI4eTkrR3F6L1Zq?=
 =?utf-8?B?ekxncW0yZ2FLamFQTVIyLzJxV0hxMmxnZ2p3RVZrajZyVFFyblN5dXl5WVYx?=
 =?utf-8?B?aVhhMmIrbHBvY0lSTkJMd1lMWmYzYWdoeEJNZkd4ZkdmSVJLV1BiTkI0NE4y?=
 =?utf-8?B?TlNDWGs5YkV2aG04alBISlJMMmZYOTgxMDNMMG1mVEZaNmtkU1J1RlR3T2lF?=
 =?utf-8?B?WTk3cFM4a05xOUpLSndobmhGd3gwcVFWSEtNQzNFUTFiT3J4dlpJanRSU0N1?=
 =?utf-8?B?MHJ3Tk5ITTZTY0FUeEszRXM2bllZT0I0aEcwdGlNWkRpVjY1UlVCa2Z6ZnhG?=
 =?utf-8?B?dUFXdWR1WTF2Qzg5dW9NL3UxTGZ4OHhpZ2xaZFF2WithcTRDOHRZZHdJUGs2?=
 =?utf-8?B?VkV0c2VHNjBpeDdmVEh0RGlOY2prQnZpaU5HRGtEcGp4SG8wT1NKR04rWUpT?=
 =?utf-8?B?cmNSK2JZMHJiTDFUa1hPdVZOaTRmaVIyeGppNWVneFRUbkYva0s3aEJKNzhk?=
 =?utf-8?B?QU5jUTFTVk1nWnFXaTg2WStRVTJqZlZ5NjlDbnB4bVZhZU5EYnRmNndFWVlF?=
 =?utf-8?B?alEvMXk5QnpHa1lndVRzRE4rRWtSQXdFZzVFclA2Mkt5VTNDUUdJT2UrOGRL?=
 =?utf-8?B?S2pJcEhGaE9OQjJWVzhyTjNwckhHTkZjZzlVdjhDRndYcTg1d0p0UzRrWG5k?=
 =?utf-8?B?YjN3MlM4ZnFwUi9BK0ludEpSVE8zLzdINWZUditSVUlaaDIrWFUvQmhkNjRG?=
 =?utf-8?B?V1RIUXRzcGk4MWpKZXlOTFRMOG51cDJMNUtnTzIzL0lWRjVFZkNVMVBJemNi?=
 =?utf-8?B?M01NcXVIRVNYTnA2MTFQREdTdjhCUDY2QWRlZENBaW5SV3p3R0hGaHRWNDhY?=
 =?utf-8?B?SzVwRFRFd0doUXFidjQ4TklsKzMvZENZUWVlQitzb2dpZjBLbU5MMUErNDBU?=
 =?utf-8?B?YVI1V2t3M05aNHRPZ1R6TzhySEVJL3doR0FjclV3KzhvdUZCYTJXRDJvUVVk?=
 =?utf-8?B?REV2SXNtOEdkcXF5STZsTjJEZUlNRk9zMitkUWYyd2libnpCbXNNY2pYSGJU?=
 =?utf-8?B?aDFjUjM3Y3dXZVNsUXRnTmh6MHQvTzBGVHliVE9nYUhnQ1VTZCtvek8vT3Er?=
 =?utf-8?B?UXFqRmJKVC95VGpIQitBWW9ubFE0d2x1d1BMdEk2RHo3a1VQRUp2aFJ4ZUw0?=
 =?utf-8?B?bkZRb2dpaU1MMG1KMG5GN2ZjRUE3aXlzMUdqYTR3UEsySkFsVCtmUzNoVkN3?=
 =?utf-8?B?ZjJ0K3dJUkNGZlhwbFBsOUkydWFKRE9aYVNRSE15ZnV2SEFuL2x6bUFGOSs1?=
 =?utf-8?B?ODE2QythZnZaZnJLeVpVMURQenRxeGhzZXZJWUsxTFkwOUtRVUpwLzhMa1VY?=
 =?utf-8?B?ODl3SktlSUtLcXlId3VZb1lacFpSRU81RmVVZU80MG8zTGQ0VzE1cytrYStx?=
 =?utf-8?B?V0dsbVN6bUtITGo0eTNXM3ZBU0lKNEtFY1RWTFRhTVB3M0l6N3k5TEZZbnVC?=
 =?utf-8?B?Ynh0MHIrczVORFkwaUc0djBtdndKUGZNR2dnOW5rdk9LaGlydEJINHpDK29I?=
 =?utf-8?B?eWoxYXVrb0dRSEdTN0luNXNoVEhuYXVHMldXM0Z3eVRjM1VyZVlBQ3orRld0?=
 =?utf-8?B?dEZZVEdEYWx6TFRiN1FROW5hUFdlcVgwRzhKbGZNYlJ4Q0IvRnhpaWtmbFl1?=
 =?utf-8?B?Q2lyWi82RWlodUpQSHZJZVFrb05DUU43N2RSQTVWZFVQeFpWZEpITENlZUhD?=
 =?utf-8?B?TkQ1eE1peWVPVG1IUEpzRmw2aisrMjZMemNNS0xJWnNSUnFjWnRvTVU5VXQv?=
 =?utf-8?B?Mm9QalhvbWlSZnFPNEM4eWNvK2VncHZtOFlDUVoweEE4djVqN1V5dUtNRTNu?=
 =?utf-8?B?ZUIweXh0T29aUUNyZXVWR0lyeFdFZ1FBVUFNcnozaDlPS25LNUord0JPQkhZ?=
 =?utf-8?Q?NgLIx1rAmwwmRmyZZVysBvuBlNBNVPSVyqE6r?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cbe345-5d92-4578-cc01-08dea5d9ed06
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 10:27:36.6797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIUC0guDd23pWLHa3RBlNxSqX0JySu5MTcAhlbEryvlh0bU2BCHLFt/3MXtgAXIr+OjPK5phKlPyikomDAJgVy6UWSH2jNBY4gLrpR5DRlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10348
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

Hi Heinrich,

On 4/28/26 6:42 PM, Heinrich Schuchardt wrote:
> On 4/28/26 17:55, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> We've had wget support in lwIP for almost a year now, so let's do *some*
>> checks in the form of validating URIs.
>>
>> The other test in test/cmd/wget.c currently requires structures only
>> defined for CONFIG_NET_LEGACY so it's left out for now until someone
>> ports the test to lwIP.
>>
>> This was tested with:
>>
>> ./test/py/test.py --bd sandbox64_lwip --build -k net_test_wget
> 
> In the CI we already run a HTTP server:
> python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" > / 
> dev/null 2>&1 &
> 
> In the test we should load a page from there.
> 

That requires the user to have a webserver on port 80, which requires 
root permission (or CAP_NET_BIND_SERVICE, or whatever else to allow 
non-root to open such a low port).

This actually is only used if env__efi_helloworld_net_http_test_skip = 
True (according to the cover letter in merge commit 5eb1b7843811 ("Merge 
patch series "test/py: enable HTTP testing"")) which needs to be set in 
the u-boot test hooks for it to be usable. I'm assuming most people 
won't do that and we then would rely on CI to run the tests. But even 
then, that wouldn't be enough as you need to manually run a job which 
runs the tests on a board whose test environment sets this variable. 
Many ifs, lots of hidden knowledge, test(s) run less often.

> Let's use the sandbox host network interface and remove all sandbox code 
> that is emulating a HTTP server.
> 

I'm assuming this requires us to migrate to a Python pytest test also to 
be able to access that variable that tells us whether we can contact an 
HTTP server? Another option could be to have a compile flag which is set 
if HTTP_PID is set (or something else from the host env) and return 
-EAGAIN in the C test function to skip the test, à-la

           if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
                   return -EAGAIN;

in test/cmd/fdt.c for example?

More work than I intended to in this patch, and I'm not really 
interested in doing it. Too many shiny things to look at and this one's 
not shiny enough :)

I can also understand Marek's position, so no hard feeling if this gets 
dropped.

Cheers,
Quentin
