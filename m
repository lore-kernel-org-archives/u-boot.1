Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED68C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 17:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF668650B;
	Tue, 29 Aug 2023 19:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="KYTBK7WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6208863E8; Tue, 29 Aug 2023 17:37:42 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD5A80702
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693323459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVE46BeWGlphEmZfhaOoAl5bQgjm//ikprc+vh9mBUY=;
 b=KYTBK7WBPgvGoGXts32YxUG246VGq/7hs1vTYlCo4i+sdWrRgpUMTOnIJVaaqlAdTBLvnx
 7t8dfyed3tiGzd/7pq73Lr2DaERx+QquABxj7b3OkBpkeQq0WRldMAmdks0y5ecK8gB8S6
 PeJX3wAh/2zTY3BRnlIFV1zUR1qK9VE=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-63-CYdMjmBuMYeNb77In3_ZAw-1; Tue, 29 Aug 2023 17:37:38 +0200
X-MC-Unique: CYdMjmBuMYeNb77In3_ZAw-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 15:37:37 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135%6]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:37:37 +0000
Message-ID: <5219f4a0-b91b-16d0-33cb-4b7fea37625c@toradex.com>
Date: Tue, 29 Aug 2023 17:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] CI: Add jsonschema python module
To: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de
References: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
 <20230829150422.GD3953269@bill-the-cat>
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
In-Reply-To: <20230829150422.GD3953269@bill-the-cat>
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR0P278MB0027:EE_
X-MS-Office365-Filtering-Correlation-Id: 964925d8-ff9f-415d-5804-08dba8a5def5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: /ZeLThtG22FyfJAEtIV+cLHfVnUICmL7eXCEUBF6MkhT/XdUGGMX+F1BGHFfjV1tEAGthsR05F8kU5VxxZoL50WM7TebqreJe3PVVf0LGdKeIVV2aqfJh1YCNKMqarw7FAsoM1aPKCD5YXyQici2fv3h5U42OMbcf+AahyEtYt27yfTkdUGu/IQdq/PuGTLY37mogIUKO0go0ur7MUo7V+P5zjx2Eiis0iOl+DhiCNsssnP14d/END11lM9F6xlLgu3FKDBOZJqvrVmC4w26qSKmOiPrRkfAx5+pPw7sZvgLphvmmXJlmNNhDmHt+UnDiRVY9/GAMS4wanTiOX79gKhrUYJd7ejMbSlxmmspyZ/QpW4hmxX3aod0sKsDFMHedyQdDzyEFvAUczIAv1lAZJnv4Sj80TY3kgcQ9BFWcemTNDWoEtf+IqNty2h9ZyofEOSqbrCxWuSG1HrWRT5PAFwnSiLsAZ/bQJmyR5lsoNjilAMt6QH/BJuaOwTOK01dsG3j3Y01syMCFN25AXNhaSYnkwEwMlUrtDLKJ/m9WZbc72+KAL75ewlm+nUK9kFJuLtr05qO4cg9Bie6zdUpnUP30Az+T7trKqTzB9Edov96Fs2WWqjXVcYAMiWaVr49IxNgo7qHqnQg8SVDaH/EIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(186009)(451199024)(1800799009)(2616005)(6512007)(44832011)(86362001)(26005)(31686004)(41300700001)(5660300002)(2906002)(36756003)(84970400001)(38100700002)(8676002)(31696002)(8936002)(478600001)(6486002)(316002)(66476007)(66556008)(6506007)(53546011)(66946007)(4326008)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJIakl3S25qR1NMNHIydWJTTUlRcngvck5yeFB2UC95UjYvd1RDdysvK3Zn?=
 =?utf-8?B?Y2ZKRjRUSUVwWWwyRjdhemlmYytqVEF0RmJ6NzNNU0NxOHduRU0xZC9NbDd3?=
 =?utf-8?B?VUJqcU5leVhqbHlTS1VKSmdVQW85eDMxV3N0TlFCS0ZvY0pPZS9rYm8rRUxk?=
 =?utf-8?B?WXRuMUlabU9yeTJoMUs1c0F3Wmd4UFlvRk03U2ExamxqUTdXTlFiZzFuV1cz?=
 =?utf-8?B?VEplQnBCVUY4SFUzSkVsOEV3VFhwT1pQVndqWkduS1B1c3p6L3hPcWlrcmNk?=
 =?utf-8?B?bW5JdWdZVHFlblhZSDFvd29qb1M2OWppcTg3ZTdOQjNuZ3Vob3d3NmcrN1BC?=
 =?utf-8?B?MmRuaVo0b0tUNWoyTUxzU0hLdWlFVUVHWVhGNnFWSy85MTNRMlJtOFV0OE9G?=
 =?utf-8?B?VWgwWW5DT0NFSmNHTE1wazA2Y0JjL29rTmxFSzluL0lyVmRYRjhFdktqNks1?=
 =?utf-8?B?eVJBZGV3WUhKdzFZVzhYRnF1QjdrVU5uMURPWFRnY0ROeTVNN2liYXV5WjZL?=
 =?utf-8?B?WG9ubHFGRy8zRHhaTWFBNSsxVW1MR21aMVRmeTJEOGY4bHNqQjZpVFViUEsz?=
 =?utf-8?B?bXlKYjRoZTUwUzl5TDExSTRvVGpwU2RseVliaCtKbnFqOFl2YlNmS25yWmxs?=
 =?utf-8?B?cXk2dmRhSlQ1eHlVa1FRUUJ0MXRyaldSdjl2eG5KMXFabk5mUExWSkYycXpV?=
 =?utf-8?B?M1FGRXhXNnlvZ2NabFYvWnhCYWQ2b0pHOWRFTmoxZE9TNWNUMS8raXFRU1lS?=
 =?utf-8?B?K1lGZXlZYml0eVU3VWtwQ21IUTE5VUlML3VqNnhIRDJWWUNrUVkweENDZTBT?=
 =?utf-8?B?STNEUUVKOStqV2VQZWx6T1NQM0MvMnpuZnhSbWNFYXhhcEdMY2pIWmtERmwz?=
 =?utf-8?B?Sm1mWndtaDBGdHNycTlzcFg4M3JSTmNmOVNBMnNBUkRHSkJnMXFLNXpVc1FK?=
 =?utf-8?B?b2swTUhRRXZwaUJMclgvK1F0ejZyV0l0NE95SXF6ZVgyYXJ2NzJ5aTdpdDR1?=
 =?utf-8?B?MmVDZ3dlemprcW9zbUZzOTlDeGlyMlhsY0tsaGpMQzBsMVM5RWUxYTVTMzMw?=
 =?utf-8?B?K3N5NnJBSzIxWlIxU3BjZlQzdjdIQWovYk5LYlZyeXNQNzhjc2pqSms0ZGpp?=
 =?utf-8?B?dnI2blN0a0pjRy9pczBnbUlRUFdGVUtyY1VYRzgyQVJNTm4zMFNrTG9vSy9B?=
 =?utf-8?B?cTI3ZXhqOHV2cSttaFoybGY3OFVSN2JkUUJPYzZEUkxvZW56RVdJeEF1MDN1?=
 =?utf-8?B?eHgyT0N2ZUlINmdzLytkTHh3cVBMU3B1UjRKYjlBeTBwTFYxQk5pd1BFU2FX?=
 =?utf-8?B?L3FoY3BQUEZTRjBRaHJMaVh0YkxBa2tsWC9NajhnMk5tcEc5RnNkcVNRV0xz?=
 =?utf-8?B?SU5Ud3pSWnhOemFERVUxbTN4eEV5N2tXdVpqeTZrWEdaNFFMaVVFWU9PV1pL?=
 =?utf-8?B?T05pVU05SlpUSzNyRlNUQUVESWxKMzByVENDcmhnWlBUSW5vQTFaSk5vcm1J?=
 =?utf-8?B?NmlhRE15KzZmYkVwT05VaG1LZm9DM2wzS2RVbmFyS1F6ZDVFRTQxWjM4SXR3?=
 =?utf-8?B?ZGEyLzJuN0g5azgxd0U5ZnBEWmpBVHhFNjlQajJiYmdUR0xWYXhacW9mdU9H?=
 =?utf-8?B?UE5wSXRTY0Izcng4YlN4cWtVcERmSnZacVFnMmsxeG9GcWxKMkpCWDdXV3Nr?=
 =?utf-8?B?ZFlRZE5UaXVJb0wvR1pUNHc3L0N6Z0hDLzVDbW5lUnc1R0I1eWRuKzNTelpq?=
 =?utf-8?B?b1k3ekhOV2I2QjM3bVNqUVdBZE9qajVnSjRPSTdRVStINTRYUVMvTEY0R1Np?=
 =?utf-8?B?bmlyOCtpQTdqaUpXa250SHp2SFkzcnZNS2dUOE1ITkpRTzlQT2s2aFAra3dK?=
 =?utf-8?B?bGtkNWhSZUdHMURlMkQ3N2VRNGRCaWRnQlRKR29rdWhVTmdHMjJadTQraTIx?=
 =?utf-8?B?WEM2WG9sUW9HOEZuNXFXMUdpdnFKdnB6cENvTlpFSW1taTJ0MVkwY0VYYWxW?=
 =?utf-8?B?Y2FVSWZFZHFoa3dLWmtBZVhRK21EdUQ4Z0tUV3BCMi9wT0dzaVNSQXd0T0sv?=
 =?utf-8?B?Z0UxdFNpTnBvNVpUWXFza05sQ2hyY0Qxcm1ld1M1cy9kR21NV2Uzd2N3dUls?=
 =?utf-8?B?TGwvRitydmVMM3lvc1N6dXp1TG9RUmVsaERVUzAyNE5zWExFSis4aEg1eVVv?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964925d8-ff9f-415d-5804-08dba8a5def5
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:37:37.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2EysviBwqxJKpoULjOGqxwPou4yZa2cKu8sbnq1hc87fokUaBdcO7NAh+ZULW1Af3xumoyRy3rfzvMm5MRe+ZLrBep6e6dNh+1T9/a4EWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0027
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Aug 2023 19:34:49 +0200
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

On 29/08/2023 17:04, Tom Rini wrote:
> Interesting.  How exactly are you using these CI images? We have
> tools/buildman/requirements.txt now to cover the newly-added modules in
> CI, as we call pip on that.  But, it's not being used in the prepopulate
> the pip cache stage in the Dockerfile.  And, I'm not immune to the idea
> that we should instead be installing the distro package here.

I see in Dockerfile test/py/requirements.txt and
doc/sphinx/requirements.txt, but not tools/buildman/requirements.txt, so
whatever is mentioned there is not part of the image on CI runners.

Following is the part of *our own* .gitlab.yml file,
which uses a public Docker image
(docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230624-20Jul2023, as of
now):

verdin-am62:
  stage: build
  script: |
    ...
    tools/buildman/buildman -o /tmp -P -E "verdin-am62" -M
    ...

And this is how it fails in our CI without this change:

Building current source for 3 boards (3 threads, 14 jobs per thread)
       arm:  +   verdin-am62_r5
+binman: Unknown entry type 'ti-board-config' in node
'/binman/board-cfg/ti-board-config' (expected etype/ti_board_config.py,
error 'No module named 'jsonschema''
+make[1]: *** [Makefile:1108: .binman_stamp] Error 1
+make: *** [Makefile:177: sub-make] Error 2

--=20
Best regards,
Andrejs Cainikovs

