Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A260C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 21:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D38486405;
	Tue, 29 Aug 2023 23:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="jFCiZ2g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1EC864E6; Tue, 29 Aug 2023 23:03:35 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFDA83F7F
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 23:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693343011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkaMx7xSs5eKz9QE4kzyuBX6UhxfNmaA3UzJQIutDlc=;
 b=jFCiZ2g3Efy9+NlPbhCkV3PEQ8oEBTYFZ6tUkyKCZpMr3eZON319NiowQQv5P5JtxZdmvf
 qCIfVC5VOuQSUr3ZhW7yPNg2I9/Me6nEo1MXCC5UceM/7LP9tRwgIiUd2Z1182HRJWq3Fg
 XWQOJmt/G7fsGyvAIi0O0DcjKXQByu4=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-6heV9TZbPA2-dDxj8ihAkw-1; Tue, 29 Aug 2023 23:03:28 +0200
X-MC-Unique: 6heV9TZbPA2-dDxj8ihAkw-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR2P278MB1162.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 21:03:26 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135%6]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 21:03:26 +0000
Message-ID: <a9588c13-1fad-37f4-9311-ffab6e94e6f2@toradex.com>
Date: Tue, 29 Aug 2023 23:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] CI: Add jsonschema python module
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de
References: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
 <20230829150422.GD3953269@bill-the-cat>
 <5219f4a0-b91b-16d0-33cb-4b7fea37625c@toradex.com>
In-Reply-To: <5219f4a0-b91b-16d0-33cb-4b7fea37625c@toradex.com>
X-ClientProxiedBy: ZR0P278CA0025.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::12) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR2P278MB1162:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f0a593-2ec9-45f0-1823-08dba8d36312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 5Dd4CJBLPNiCtfPdxRsk6x2eAq8TY5H6XpVLUR3fBiySCXGXpHYuMAxmmtf/zQ6I1UzLRdJ+dM9XVsxopC8RaFFNyPZDkYmr+oLsppZeKauglqTNa+au7JP14GtV8nzO7WKbWLj62grdXJOzw5hNtaZGBCTRhbqFHov1Al9ccWzcJm5ASZHHVJ4kB0Vsd8YfHFsMoir98ifAbbGJOQ6xiqfhrucVIZ3IuxyPuM4bYpgp7EHdCyOh/DSB3OM9skVMbI99Xq6Yy0CUCqycpYJfws/Td+X7LRtjJtELXBC5Um1guw/4rUFvrBlpqNqqtM+pUGjl+YT76RhTohetlqeait821isYk0bCDUHGEbSTYRrlw/wsmemXBv/UIOjm7aBi4BDQyK4Xtxi7dwLZDmi5VCv43BJ0wJ76Hsgaou7QLJyz1HkAAlpokMo5LDdZYd2ondkpr8PkX5rU1K+rUOt3usGNIZRm1Yqx6pAmVpuTqpprOLor4Z4kDAm9I4ZaJ9CuvB7Ye2WUGukSIpCcX7iM3xsBVh+JEdiyd30bFXp/wjdqrVG3qlufh6l8tTnyYaMgwZfxUh1BK07Ozl9EdM/STcHQilrBNfY21ZS15CgE8U7YaUFgFLFjdzrzxM28cW9snpJMKvl8LYKfRP1wcEl2Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(66556008)(2616005)(53546011)(6506007)(26005)(316002)(66476007)(5660300002)(66946007)(4326008)(8936002)(41300700001)(6486002)(44832011)(8676002)(966005)(6512007)(2906002)(110136005)(478600001)(31696002)(86362001)(36756003)(38100700002)(31686004)(84970400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NDL0FYSHNjelE2SzdZa29VOUc3Tm00UTlCek9NelJNY0s2ZEg3Y2hZdXFP?=
 =?utf-8?B?TG5TSFJkNi9kdjRZV0lvWmZ1YUVUT1JpU24zOFB4aHNacXVjSGhLcFVWRTJt?=
 =?utf-8?B?clVHRmdsRHRjelRoWUIzZ2p0dWRCQlBoOWVVZ1gzV3Z1SXFycXpIakc1K3lB?=
 =?utf-8?B?MjJvUWVHUXA5Nk5aWDZYcXdteExDRDcwZHB0bWgveVVUZEJmOGxiTlloTVR3?=
 =?utf-8?B?V0EvMFNXYWVmYWxoc3poVUwwOU9hak81andhM3NNTVBNWmNsS296d2w0QzNL?=
 =?utf-8?B?cWQ5VTM2TUtUWWhDbnFUcDB4azFRK3RuVjcrUGVSZXRHWThXTW5HaW12eXZi?=
 =?utf-8?B?WHhIM1AwVnVhWTJnQVN1QnlBb25DaStxWnhrL3pkMkY4RjY4Q1M0bWY5UWE2?=
 =?utf-8?B?bDlmdkd0MlNYaDBYQVd5WXdlcTZBQi9Fb1BkLy9kZ05BQWQzTG5nMlBkYkQw?=
 =?utf-8?B?VXZOVlJVYS9jZ1ZqcnJNLzNwMnVpM3VUUXFMM0U2anQ1dkRXejlPZ0U0NGFQ?=
 =?utf-8?B?ckZhalVDQTVKMXN3cHBzb0pWd2tWczdWRDVpOVV6UlNDMlZYUnVZUjBaTXlm?=
 =?utf-8?B?WmtOd0R5RXI2TVRhOHllbzl6M2ppM3dGdk56c2VXa1dFbEF1VUIrN1U5bzVX?=
 =?utf-8?B?c2JSM1lFZXU1a3lyM040TFEyR2I0eFIrVVUyN2ZGQjJVNGRRQjluT3FDYiti?=
 =?utf-8?B?T21PWXRmWTBLUkxDakFvZ0tQT3VZNnJQaWw1czdWTVNGbTY4bWV6b0RnNnJK?=
 =?utf-8?B?a0tsTlBING9UQWg2RTBVTy9VdG5FYkFHUmc5Q0NUeTgrNklqYjI5VzNoeERv?=
 =?utf-8?B?Z0xGL0hMdHd3cnhHZmRLd3lEZVRMYkkzKzc1eGhLVmtBcFhPWkNWS3N5bzZ5?=
 =?utf-8?B?eWtSdHdyT28waHJsT0hZQlg4UTRYOWJxUGNxajM2OXMyeXg1R213bG5BTC93?=
 =?utf-8?B?RkdBVUhTdkRRZUk5WHpYMmRxYS9UcHJBamQvVTVjb3gwSTc5amtvcUJyTW9h?=
 =?utf-8?B?aVh5eGFvMnBqRXl1YXNOTXNHNEVYeE1JWmRTQ3Q3ZmFXYVIvTFo4YXFjaGNZ?=
 =?utf-8?B?T1BCV2dVQndMbFFmMUY4Qlkwc2lVQXVwNVpXT0dQakYvUld0VEoxOG1FSWZk?=
 =?utf-8?B?RHFGV1c4ZEx2Q3ZKb1VuSkh2YjhQY3ltVEJqMXptSUIwODJiSU9PRXBMZCtF?=
 =?utf-8?B?SGpPdDA0RXR0WE11bndUVDVxNGtQMDVKd0RiRWtmOStDZWRJZ1ExWG9XRWVp?=
 =?utf-8?B?amdQb0ZyZFNpTEd2NS82bTRTVVFFT3l5blZWdkhTb3FYUGN6UTRlUVBFaVBx?=
 =?utf-8?B?ZGpxNHFTZGRkeWpjZTM1MFVnMVZ2ZjJRdS9uTDdzUEU1TnFKSm4rbm96bDVL?=
 =?utf-8?B?MnEycUhObUhlMWVDUXJBNHBUY0I2U3o0SUg2bVM2bk4reEVFWERWRXFRQnNB?=
 =?utf-8?B?RlNyNFV5UDlwSVZSeDl1UWlUb01pUlkzbG5Ecm9GeFJKaml0STFHVHpLMGUr?=
 =?utf-8?B?blpjS0RTKzlDWnd6aGtEYzcybzZmQktySVBGNmVEemdoT1ZVVzBBSjdkdnIw?=
 =?utf-8?B?Q2h3NlAwbVdKaktSMkh4dURvZlZrUXkzRUtwUmlabWYxdVlpa1cyRkk3NDBX?=
 =?utf-8?B?ck5RTExQdE43ZEpMVjNlb20rMmlCamp2ZDlCZDZ1b2E3SzhKUTlxU3F1TVFu?=
 =?utf-8?B?bExrcHBWUDRoZ2ExTXpZV3RCWFh6bzJXeGNrbzlFY09ZY2NRa1FmdlZRK3pW?=
 =?utf-8?B?Y2cyVkdmSVpZTjVESmMwNVJ1NVJPZDhjUm1vMzlLNnhvNGJTOTNkZzJPb3pE?=
 =?utf-8?B?aC9DQTE4dEhwVzN0U2dvRnU1N1RDOFcwcHdDeWtNamlPaDdpcTJnaXcxWEFZ?=
 =?utf-8?B?SVFJWlQzSk41WFlJOFBCYkRob1U5K0hia0FMOE1aSEFPVVJxM2YxMldJMkI2?=
 =?utf-8?B?WHpQZVlPYUk1eGFQTms5UFJJSjJjbFluZmx6czRsb3poNW1kOXM3L2hlVlAx?=
 =?utf-8?B?QlJEamxDUzJqN2tGQzg3TjJJRytvdngzajNtZ3picXBpQjlTdGVycjQzRU1F?=
 =?utf-8?B?b1hJYW1iUFBxTkN5UjcwLzRqaFFMUldaZkJvZFQ2c2V3WENhVFI0ejVsTWEr?=
 =?utf-8?B?YWI3Mno4VjZFUGQzN1lGTHd4UzlYM3YzbUg5WisrNnZpOVZjeUxXaEl1T1Vu?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f0a593-2ec9-45f0-1823-08dba8d36312
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 21:03:26.8356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gNzPnAuLkx7pU5V5KZE7TuakUoySSpDaurKQfV/emIwBw7NkMilLAHlpSffuC8ZvDCkxOBDPxiqAfxY0i3iXRZYyCy0ytCxz0HitVQ5esg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1162
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Aug 2023 23:25:50 +0200
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

On 29/08/2023 17:37, Andrejs Cainikovs wrote:
> On 29/08/2023 17:04, Tom Rini wrote:
>> Interesting.  How exactly are you using these CI images? We have
>> tools/buildman/requirements.txt now to cover the newly-added modules in
>> CI, as we call pip on that.  But, it's not being used in the prepopulate
>> the pip cache stage in the Dockerfile.  And, I'm not immune to the idea
>> that we should instead be installing the distro package here.

Tom, I got the full picture right after I sent you my previous email.
This particular file, tools/buildman/requirements.txt in used in *CI*,
right.

Well, in this case my patch doesn't make much sense. Or it does.

I'd like to propose to install packages to runner image instead. I see
the reason why it might be convenient to have packages installed to
runner for particular jobs via .gitlab.yml - a bit less maintenance of
Docker image, which would need to be rebuilt every time there's new
dependency. However, if you think about pipeline execution times, on a
global scale, that's a waste. As an example, I see four occasions of:

pip install -r tools/buildman/requirements.txt

Twice in world build stage and twice in testsuites stage.

If we take another example, packages from py/requirements.txt are
installed 37 (if I counted correctly) times during entire testsuite
stage [2]. And I see you run them a lot [1].

Since you are maintainer of this, I will leave this up to you. But if
you're up for this proposal, I can do this change by myself. Of course,
this would imply rebuilding Docker image and pushing to registry from
your side, to keep stuff synchronized.

[1]: https://source.denx.de/u-boot/u-boot/-/pipelines/17556
[2]: https://source.denx.de/u-boot/u-boot/-/jobs/685270#L366

Regards,
Andrejs.

>=20
> I see in Dockerfile test/py/requirements.txt and
> doc/sphinx/requirements.txt, but not tools/buildman/requirements.txt, so
> whatever is mentioned there is not part of the image on CI runners.
>=20
> Following is the part of *our own* .gitlab.yml file,
> which uses a public Docker image
> (docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230624-20Jul2023, as of
> now):
>=20
> verdin-am62:
>   stage: build
>   script: |
>     ...
>     tools/buildman/buildman -o /tmp -P -E "verdin-am62" -M
>     ...
>=20
> And this is how it fails in our CI without this change:
>=20
> Building current source for 3 boards (3 threads, 14 jobs per thread)
>        arm:  +   verdin-am62_r5
> +binman: Unknown entry type 'ti-board-config' in node
> '/binman/board-cfg/ti-board-config' (expected etype/ti_board_config.py,
> error 'No module named 'jsonschema''
> +make[1]: *** [Makefile:1108: .binman_stamp] Error 1
> +make: *** [Makefile:177: sub-make] Error 2
>=20

--=20
Best regards,
Andrejs Cainikovs

