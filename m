Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B85CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F414786B09;
	Mon, 25 Sep 2023 10:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ffOgE64n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8EB86B0D; Mon, 25 Sep 2023 10:47:22 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1A68620C
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPhF6N0oywWU9HvrUfTJ5PJ/QiIyMNZcrqmDm/LXtJeaix7nr1g5xUO1aY6lYz+4e3dORlA5gizu+Uus6G4jXiLHL5QbPD/lxqHjqMWwK3wpXo4jQnExltJbZ1Zsv7qHJ4LBAkkfUjpsOwqrhKCfy4iaeQyww6p2RABq/3izKtmvpvhi7eHTqBTijgOmFERybast5o/GF8hCZ2vXzMBrQ1L7la8O1eJ8i7A1eyrd9UF/1wEkJKopkYVmmyGdhrWsqL9yO5WJ09r1kH5noHI06zQo3I44+0WcI9aAn1b2vpWr6dewrI9DSPPoVJ0GZ3njuZaHyYpCXpastHiRtMqmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA8+0gLMOcj3OwlkJVZIrT2j9bxfLRTJdKPIZiYNleQ=;
 b=Pv8aCFPak03HYpKopGP68CMERR38dDUWQpVnjLAa4iD4ujkc8IhuDf43nM45NIZXNNvXCrgTgXKTHzVkskAnmBSSpg2/Ge3okpESDqde+jNIgNtOhBI3ifCRatbHdriH4ZmdTrbgfa9LvsGgKDaACoRwzLi4GFkaQCt3Vak6hYa59U+LwOzlLXB0vjxDuYShWBwSLMEHMsOI+LP6nYxHtL4ILFWaqx1P/wU6KhF0pLjLtR4stWidR48xUJXKy6QKM3VY4WgJky7ONbxsjNKCwSUd2rSpiC3lteJ6l/DduM9mUe5Ij8gf92cBEZuVchQKCREjMAfGnkgxZt34x1aLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA8+0gLMOcj3OwlkJVZIrT2j9bxfLRTJdKPIZiYNleQ=;
 b=ffOgE64nL3CbRVGG0kGI91QKfNCsEU+aNUUKu13BQBjbRMa7aAbkL08x8yxLn+U8mjqIwyxGN/OHxbKGGHlNlI7ZaS9E2W5AAlVJUc3gY4PvhXLiT4LuqkjrJHYtZs2GE1pYUuklUdbYWdjDSxwOUK7ujUsP2WG6DJ7knf2Pigk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7280.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:47:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:47:19 +0000
Message-ID: <b655aee9-ebc6-044a-cc7f-9e28d850b671@prevas.dk>
Date: Mon, 25 Sep 2023 10:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
 <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
 <CAPnjgZ09St0710SRLzubphauTYMtE1PyxAFWEKsupA2dAhXRbw@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ09St0710SRLzubphauTYMtE1PyxAFWEKsupA2dAhXRbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c20963-ab38-47ff-d244-08dbbda406d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB6RuA7exnBUJuVg4VfUIrfwKDkjpQA0H8W8AjnKF/OhPTsYfF+y1Yt3X2j5h/5fmms4usutSvg9R70HgT0QsTh1Q/SP/It9wiBkfUuVZBNh28UQaztxAF24RNnhHsmflBCgUe5/xGTKXQkbIKfxx89XvhE3ynt4cfdQdAL8IavERpuFxKHXigvu0dbThLkZ1A7085QUmVvVnyLlgg8qLUugVGX68DsQyMZnxLyKuZq5sH6GvXco0USV1LYwyO26Lj4iFARdXcJJW+7dtDGGIEGokgHy7sQfZMoCoycteu3RbcQPAWf58AWVo9SnDs1A7suQ0iCUMr4WGyYrHPNdh5NoIyZJLEfqlHFYG50vBK7B3PgypsEa19ubxpnabH7P0zMh7QyOQ0FpZHNTjBxhkxQeJzWHBbeoQ30KzB0zmepv9/yGszWBMo+Z/Uy5GR27wBwb6KRv0jzn9t1gI2FuhjNrfAzQhptBqP/sHrvIDbO4iQxPD+UwbpwvXOrSD/3zGYmkUKcvUOlSHRTE9vjSN4dr06aurMJBcRn3VpVniYSUo/XAewKzq5Su3jhmFV/YfrvUOpV00xa4JcfNquVLtfD88InlVoegq1SLmTrHVixSspNRXowpwMRQbNzGISJaNxakKX1XN6UGX14EOswUnH339VbEqKcIofhZVGuiS9aXrTlIfrgxoBkaDKiKk9GG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(478600001)(2616005)(36756003)(83380400001)(86362001)(31696002)(5660300002)(6486002)(52116002)(38350700002)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(31686004)(41300700001)(316002)(54906003)(8976002)(6916009)(66946007)(66476007)(66556008)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJaVjhvckEvU040aDk2SXYwK2poQ0RkeXlyOVBTaE5GVmxEUXJSYzgzeDB3?=
 =?utf-8?B?WmRXTnJ6YnhiUVNTTzJKQWt5dWd0M0QzblVMdTZuN2ZoUHg2QjEybVc4QzdO?=
 =?utf-8?B?MUJuN2pML1NJdmloYzVOM3pVYUF4MW8yMThSUGQ0d3BkVHh0TmhHWlJTY1Bq?=
 =?utf-8?B?ZXV2RHMxK1dsR0JGZ3BJMDdkWkg1aExPbDFzclZIaVlaTHNuOHZncE9WbjhU?=
 =?utf-8?B?L0ZxYTU2ck5qem9ZMzE3SERjU2RYclduRXBWNDdST2hGRzRwVjQ5bFdBWCtH?=
 =?utf-8?B?UnBoZ1ArL1hReGhrdi9SQTk3WU1zZW1TZW5Nd2w3VDgyVzI3eVZEZW93MVh6?=
 =?utf-8?B?T1dxQU0wMHFUVzZXWmpzYmNrc2lFRlZ2NHVDTTRrMFNISVVwWU1ZcWtMMFBy?=
 =?utf-8?B?WUFwWnQ1ZGlLbVRERTM3dGFBdEFVOXJoTzRaVkVRQmZWa0VWa3NwYXZMS1hO?=
 =?utf-8?B?aHRZZi8yVnYvbm9nRVRkUFdnZEVJbTlmejc5QW1NUDNBWi9OdzdoWTNQSVNw?=
 =?utf-8?B?VlZUU3Z2RlR4WUIwNG9mRlQ2dHBFV1VvS3JTSmkvNDlFZHZGYkNyWVpCcGdZ?=
 =?utf-8?B?OU8rUURLamFEcjByWStvb0xwaW0xTVhYN2RHOUtRSlZ4dlFRbHlGT1FMR2tK?=
 =?utf-8?B?ZTdiYVVCdEtjQXZvUkowbXp3Um1rbU8vdUZrakVrenRTcWZ2Q2ZiQTlIMnZa?=
 =?utf-8?B?d2lUbWdBYk0yWVBjR24vMk9EUCtabDRBdVRoR2RYN0FzOHlhM2NxTzVYWjJv?=
 =?utf-8?B?M2huTlVDaWlVZEl6am92SGtIMEZsVGpYWUR4eHNwTDlJNnZ2VVlIZkw3bDhF?=
 =?utf-8?B?U3hwVHBmeXpuMTgzaUtmeSsyUkRMMHBDNDVYajA0TXVrYkxjSlphbjRMcGI1?=
 =?utf-8?B?RnFTY3kyRUd2WDE3UjZ4OWZuMll1aHBhNnlORlZuNmZXZGRvcmxLZVVNU2NY?=
 =?utf-8?B?dkk1R2xpcmVqYTI5VHE5ZGdZVHBHVDN5MXJmR3dKWVhKWkpDTnhFZ3ZXaWtJ?=
 =?utf-8?B?UHN4TDNDMmpJdVc2Z2t6bU45OFkzYW1ydCtkZm1udWhQR2V5R0pMa1NlTjdN?=
 =?utf-8?B?Q1Urc295M0RvVlVXWlRMYW9PcjhESWE2NHZMQ1o3enpuUDlpTGQyZjNDRW90?=
 =?utf-8?B?d1lmK0RkWExYV25CN1RaWklJaUhhc1NSSWloN2w4R2xOc0tOZHR5UExmOXF1?=
 =?utf-8?B?bFRjV1M3elVIMjBUeTFqZW1jZmNLRmNVeDBvZitmbjJuWVNTMkdZNHpyaUdn?=
 =?utf-8?B?M1o5by9vQVJrRk1DczZVVHJvR2RGOUlmT1JlcnFZS3V1REY2VVB3eU5mZXNQ?=
 =?utf-8?B?VDAvVk9TUFhidUJHcHovUjlFcExwQVhBbzJwS0gwMkU3ai9ORnVwUS9Oampo?=
 =?utf-8?B?aC9MSFhXM3VTRFA3ZXYzOGR0ZjJhVzZvUFovWUNLSDZ0ck1CWHNsSVNjZHJB?=
 =?utf-8?B?LytYc1RrVDZzbzFkZEJrY1RUNy9qUXJZYjlUVk9sNU9XZEQ4MmVSdzFNcCtH?=
 =?utf-8?B?VUtlVEk3c2VIS1dJN2JhZm5JRU8xeXpFNlBjL0FNWVQ3bFpjdWNWQS9VbkFj?=
 =?utf-8?B?YmNLRU1ScU4vN2JDS0piTjQzUEp6b1pqcUJiY2gyZWE0dHJDUTZrQXRBOWcx?=
 =?utf-8?B?aExCbWxQTmcrOHYzR3RqbGFGQlg3Z2d5TkxkM2FSd2szR250bVVSTmRGNHZZ?=
 =?utf-8?B?Tm1nZGVCVDRxZFRqcGp3MjAvTUVoRFV3QmJhMmhJWjVTQ1pQVFRGZlMxcmR6?=
 =?utf-8?B?V01UQS9LUGhFOUVtTVdFRHBONVZJRDBRZnVSTUhpS3lDM2JmbnVKZ3kyTXN6?=
 =?utf-8?B?UTBsNDZOZFgyUjhvaTByc3JtdkJPSWErVlNKUlBRaXU5VVRydEtVV0dqaXBu?=
 =?utf-8?B?bmJHUTRWR1JYdjIwbkZQVmtoQXV5Q1RmZWNLL3RwZkJrUzZjN3JNVC92T25U?=
 =?utf-8?B?U29oRmxCbXhWTzlDNDRhT000dDJuSlQ0WHRzL1NHVHVMT0gxSDNWaml6ZTlZ?=
 =?utf-8?B?U0JPMUxnVmZDbHlkZTdnaEhiWGR6dWU2c1pjdzY2eFZSNjJ4djFnTFBPSXht?=
 =?utf-8?B?TldiYm5FdnN2M3FubDZHTXB4NisyTTg4QW1SL2xEak8xTzJSaEt0blhURWMw?=
 =?utf-8?B?SmRwQkErM0JXcGxvQk5VV25rYko1dnN6T3dQYi9GOC9IZ2VySDh6Mk0rbzZE?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c20963-ab38-47ff-d244-08dbbda406d5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:47:19.1699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogXYLQi+TE+pWbbozP6m6lJFIzaSPl6yCtxjyInilG8UXMFzHJiiFR6q/moH2vT8ACSkdB/kO331P7GG1WJvqE9rm77Joki7cV48233hTrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7280
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

On 22/09/2023 17.26, Simon Glass wrote:

>>> Shouldn't this be fdt_open_into()?
>>
>> I honestly just copy-pasted fit_extract_data() and shaved it down to the
>> part that does the "align the FDT part of the file".
>>
>> I don't really understand your question. Are you saying this doesn't
>> work (or maybe doesn't work in some cases), or are you saying that
>> there's a simpler way to do this? For the latter, sure, one doesn't
>> really need to parse the whole FDT; we could just
>>
>>   open()
>>   pread() length from FDT header, convert to cpu-endianness
>>   length = ALIGN(length)
>>   pwrite() the new length in fdt-endianness
>>   ftruncate()
>>   close()
>>
>> but I thought it was better to stay closer to how fit_extract_data() was
>> done.
> 
> I mean that fdt_open_into() does more than just set the size (from
> what I can tell). But looking further I see other code which calls
> fdt_set_totalsize() so perhaps it is fine.

Yes, I think it's as it should be - as a I said, this is really just a
trimmed-down copy of the function which moves the data externally, and
also needs to make the size of the base fdt structure aligned.

Since patches 2,3,4 touch binman code, could you take all four?

Thanks,
Rasmus

