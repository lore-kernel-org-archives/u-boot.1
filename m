Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BCBCC6B24
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 07:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C20386083F;
	Wed, 14 Oct 2026 07:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QyGaDBlmRVx5; Wed, 14 Oct 2026 07:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC67C607CF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791961909;
	b=FbtJF9WQWT9zHPnmyX99WZ4K5mKnHK3RL4msxU0RJ3+FGxg6oVztWhMywQsk3UJ+6xfb
	 W0GuebqecY3HH20xAwjbY/l3rnxfoWqRHEYOGIQ4NQ8hbNuSfZohPQNGcyijxpajl1+Gm
	 mZB7oyGUIEiQooigXGeUHFzWYHTR+UKYybVW2OPg4ig8hk/KPnC/0+DIcieBIZhjxfR+v
	 6eC3cDQUI2JAat0rpEBo+nEyMECKrmiEOEQE4fSovJbj/HQJzM6R/5CWTAbdDhvfuA08B
	 VBsZ5AkOk3tKYgKcxmAYHVFdPnvztoBvm4EJx3IINwXbcO+iruF282niNpBn78DdgVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791961909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tZZQpR2axRW4ptHqq3rkdhIqScqwSLWeNMVbdYIrXVA=;
	b=kdSHQdYT3iKe94g+bcTp/C7avXjcUK0iSIB+VSGLpULcx9L/GAYfNgzXUPqCtRkrfePR
	 w/LGbsub7gjK0Syp0yL6Q5FA0pXI0siCGpLl3Gctfv9ll5MtQ5IaIrMgMKeC5YxQPp24P
	 Hvt/8LOz60k8qId85VCSaW+o1U5HqjHnJv67zMJ9bj4nE3r6tZ5IYh/jJskFLOGD0gz3m
	 E5kY+OUncTboOhPMGYbEz7vGj5XvHTEvFwP0Ode/vtxiRZUwe7KJB4oUSz9qxl9cLm2TD
	 iVx4TKc3QeSjD3IX57bJqVI0gEb4W4+7Jwqki6OUvhySOk5gXp86FwoRs8NRiehIdFQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791961909;
	bh=tZZQpR2axRW4ptHqq3rkdhIqScqwSLWeNMVbdYIrXVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZZL55lIUOfUaaFKFOWjy8KDjs8h/FMrE9zWxtgnh438JnbwLKWx9u8yjoY+m9UyE
	 tyWS3oUhx76is00lr8I1JiaaWN3XeOhGtYbgrl6eHUtZq4My64u3RgBUxQDY9ZscoF
	 Ch+OMEnvovPuc/gJhtbCh16tEVR1vwaaT9l9TGx2kTyjPiMaRnKzjWcRHg/1EN7ViY
	 W17CWqepD0SqprZO2+V35/JuESgarEcD8irfGoPzmykUMdIF2mtXOOwqdpnQmvE5OI
	 FxGlFntE0ppgAkp022ilpXi+8gc9Ii6jyBwhnJacfN/t8SgH8Y1InYIBmlLbAWJp7L
	 xV7b/5yQ/k6+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC67C607CF;
	Wed, 14 Oct 2026 07:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84DD82A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AC2540535
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:11:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpxWSKvkNfy0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 07:11:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B345D4035C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791961907;
 b=ewij7jhn0edPA+9ydnrE/hQs9WBxres/zKTaJi8acPhVOO12YGQfbgFpcbwnuthPrK3D
 Kmor2Pui6x1yNWhLKFWCHsFaxCMoQPeoQ/wk8kDc7Wc/SRbf3I9aoZZtb0BOHmI11pB4N
 ihtE43hnth/0hwc1U7Bez64yOoHXByF8owgpSQRXm0eL0iJicnE2x9+XfYDngUUhEYr8T
 rN+3ksB3FSr81sCEUD8GOQjCBDIkarS+WlDX0Me19ePXTTopXcbz3H49s5vRmtVcee0T5
 vJiT48ztTUKMGke01zPYGle0IU36nNjAVWIL7MY4eWeh1LNlmNkHzRm5A4qTtZMgI4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791961907;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=tZZQpR2axRW4ptHqq3rkdhIqScqwSLWeNMVbdYIrXVA=;
 b=n+LFsU4OG01N5+y4OGDbVdvWXtbDcxZeW27gSd2+amaFo5QcNlqNthVbI2fmipkfmzoB
 0+/T7xVgyBnkd5I/P38JNXtIkRvpx6EKKrnqoLOKG2XULVdSNHPsUcRe7MFsi0L8wxB0K
 AAaeKR5SX7sNCzcKwMeJKalSkI9bZdkxKfxVOlj748DhcfETwPUB+bbiZip5tbxBMh7S5
 r3W9tuCbq7wiabhc3Z3aptfmIjNj2Ul80b3DbvVvoLBsf0FZLSOBvlG51f438yjvKeILk
 nhDEr94hksavIcxra1wqCs59cyMqH3jFuV2yu1nkyFszBXcJ0wKOQJgZEEHzrN4p2dA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mR+DIUpK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mR+DIUpK
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B345D4035C
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM+M3/oFbLvg9mGgtSzEfpGm+4IDJimrtKy1NhxHzAilUkzLlWsMvAMYk1OGAFCOnSSyB2PY8nQgxvBTUAhleKJWaRz2Jc5po0GyQHoKI1K1Wi81gaEw18Ng+QtMoObU7NYww1a8VWvU6mrozMI7SYF+PyFq/A3xHeHfuKjUuUzTHeZmUHXzdb9CUEmYNastpDIjzINZk25ILMtgBat6Et4G1KQuleXfAafeO4CqeijhF0T6WDrV2nlt6HDIHIN6CpdSVFjYrADiEyCC7TThfowQ+EeWEKzt9GgMt7blEoQWZY82t1uKzjoDLt6MVqjcJzkoAfxBwPiA87/Rwapwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZZQpR2axRW4ptHqq3rkdhIqScqwSLWeNMVbdYIrXVA=;
 b=JRSkWtBM07EaCGMsaCl+C/xZWIO+TM0ziUi/u/NT873xjKgk+88tggmp/QMB+Et4K2z382p9TPgl0Hz8nUGxRFOlJ/Z4oPCZWxQmcYJonlYFWgSO/X1YcFC/ivZbCczNIf7BWCjH4z71sEIJunMO9JvZ4tz4vAw6s9QPktRGq3MUBXN0+NS1Inplzc6JWgmTN3K9476ACQR09YN3yq9Yler/NYU6+6lLawtRncvhbLo+bFkiIZnaD9JahaIw8uezHig7gtie5KP6I5TRgKg+N0DK1FoTz2PbtPUMW7vqq8bhkweqPzIuG+CCIWHkxoyMZpDSh/9JgJEYNWj/mkYGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZZQpR2axRW4ptHqq3rkdhIqScqwSLWeNMVbdYIrXVA=;
 b=mR+DIUpKsPMh7mRQW5MbtU5DPt8ZycqZYKu5posOXRcn3L8Qw1vXuTZ3/7AFIqSS3O1HxJii5+l0TmVFWN+lNQ8bX9rKdnqQPu+T67ey4gbEFQWdf66obxFkSc4Qj5A5ZV7o9Jb0YkgHMXwpVCoO56LFBTjpfaKB/Sl28/Y/JTE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 07:11:41 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:11:41 +0000
Message-ID: <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
Date: Wed, 14 Oct 2026 09:11:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Conor Dooley <conor@kernel.org>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Charles Perry <charles.perry@microchip.com>, Michal Simek <monstr@monstr.eu>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
 <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc35fae-73a0-4c0a-d470-08df29c26588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|23010399003|376014|366016|56012099006|260925022911599003|260925021311599003|260925021911599003|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: tp42eiY37H5Gp9VGXSFNsju+SHn0VZNeJwOhi6mJW5lgVc5Lf6xNWTwOizP3ZHdFL8FQeQNYMTBLPE+i1v9rDMHiiISUCyIw7Na3w5AbNLRdf+npMpWUrO1GsNFEHJvkx++8DJn5op58thd+gv+I1+yaE2l8glHU+DPIedSvDIjrcDZ3BAekWDgO3qVA5gm+ISzrCaSmC0gyQmPDlra7ukPANqCVNGfVtu1iLfMAFnWB9ntl33CeiXRxowszJAt1V/oSIDmlntNKD9tWzEOym0PC3tKKP12qAAPQan7DkjJRJ6L8/mnl0Ux2FWxeVDjwpPrCaE0FkX420JdlXRZWA5KzXSiBVCrZyfgMVjtfhFXtQnsSlL9LoHUmcN6AMQnOEnMl3YE9oW7FKgvysBiA2QPmNY2PjsTSBJa2kqFwAaz5Jtab2UlNXSCz2eYcXPnM5e1kc2GjalNCzneLNJGpo0Dk5TgMVs+dzKunfgfjgZGEOVndWKCUB3WbPbFlXp5FYI57YgW7BBC9SyITB+wjvV23avHNllcE3efr0/0487Jm0HQy8/cA7HaC2xzTG/tL7Yp1A28rL8AxvpPWfF2aimeMGqJocsx/3lNo8KGHM134chFIyzt3O7RFTFx3UuqK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JtVEV2WENaLytRb012WUtGbmE5VXBkTEJJR0dCQmdGdStEaXMxaUJTMHNO?=
 =?utf-8?B?K3l0SmRBRGtCUDBRRGdtcDlJMVNtNXpJSjJvVzVQWkJUb2J2OUMxbk5zSUVT?=
 =?utf-8?B?SkFwcGFEbzh6R2J2eFRKb3F0QUdKWlNyVEl4OFQ5UFdFZlQ1Y1o1RForckpM?=
 =?utf-8?B?WTdSeWt3a3N1aHNzS1d0VG42cWluNjVQenlQWWg3RUI1YlFnN3k5YlRhblh5?=
 =?utf-8?B?S0JndjM3MDJSNldrZ28zQXFNWVM4dklvVlMxS1owNjMyK3ZDYzlvZWNqbU9p?=
 =?utf-8?B?SHRwWmdaTDdzWG5Od2tpZnJZdWVOSUVJdm5wbXZJV01nV2MxUFB4QVBTSmp4?=
 =?utf-8?B?akFCNjJaWjlRc3F0NWhjU0dsWlNxbXQ0N1JmcmZuOGlvVis3SHEzZElwaVd6?=
 =?utf-8?B?cXd4bU5SK0dyc3JHeHc2Wmp5bVMrTHlNVSsvMUh3cDVZc3BIL214WW9FQS9j?=
 =?utf-8?B?ZGk3ekpBU0duV0NVSnFrc29QcVNYUStpSkpldUdacCtOL1dJb0U2eXh0aEZ2?=
 =?utf-8?B?ODN3S3RiUDdwUHpXRjhPZWxOWEF3akZrWUpXMUhIdGJOeHdUR0lqVmZjTWFa?=
 =?utf-8?B?dkhQeThXVWw5RVR0Q3VMbDkwa1hQNWI1Q3QwMS83VlhVVkJFOXpUR0dqRWxE?=
 =?utf-8?B?VWFCM3pTUXNPM3hxNEROQm5pcVFzUWthQlY4cmluaWFmMXlBbFNmKzFGR0JV?=
 =?utf-8?B?UkRhbFNEWVUyVlVYblpWdnJhS2x5NTNtMDFWb2pEbUx3NTBMZTl3MitUSEsz?=
 =?utf-8?B?aWtLamxBNGlENzgxSmhjMVp0aDhqZlZrQk5oWVpRZWt0VkE4MzIxSHdvWXlv?=
 =?utf-8?B?eWFOdWdwMFcxYThiUVdTcDZyRzhIbDI3NHNJbVRrZXNWSjVOZlNRSmc3YUlS?=
 =?utf-8?B?TC9Ba1VURW1XOFovVkhEODZ5QXB6ck9OOG40QkpZNzJqNDgva3lkZHZUQnc2?=
 =?utf-8?B?T2pzZVdiUzdZcUNwRUprZlMxb2ZONU04UU9weTNkVWJuLy8yZ3ovaEk1cHJn?=
 =?utf-8?B?cU4zNk9NekxkWjYrZk52VTZEaUZLRGUzdjFTY1RyMWg4blIva2pMTlpVRnZS?=
 =?utf-8?B?ZEJDNW50NDlDYlpNTlk4R0NBZWxlQ2IrajRPWFRxS01qTDdVdS9sSk5zUnpt?=
 =?utf-8?B?RVFRZ3pWZXJ3aXJZYjdZaFNtNDYvbWZDeDJWbnluS050Q0o4ZFFPb0t5V0FN?=
 =?utf-8?B?NFNabTM1QlZXUHpEQ01JcFRybGFoYUhzemN5SlFFSTFNeEo5WitZVFBBMkdT?=
 =?utf-8?B?NVg2VFB6OHZuTFd1aFVoMmxjclpBKzcvbndPR1U3cDl3YmpwZ3Nhd3BoSDZi?=
 =?utf-8?B?YUVneEZacmdFR203aGlBelUyKzBTTVZJdlVCQTlzTHE3MVdBQTh3eG0rZERk?=
 =?utf-8?B?MlZoRFhITXYwNjE3SittdVFFdlJPaGpaYkhtaWlFNGhzNVM2d0prYU54NXFW?=
 =?utf-8?B?Z1JzbWVjZ3EzOVpWa3ZmL1gzaFV5NmZ3K0l6RUxqM3dTRUhNdzRZRFBFMU44?=
 =?utf-8?B?RzVtUVFXWFN4RmlUK2pFK3VIOW90bWtwWHRHUVpiSUtqOXI0b29Rd1dycytz?=
 =?utf-8?B?SzNDYWdpUUtncXpneElkTjVtSDhHTFE5Rkd2TEhWTkNMNUFOSGdRWHJGZjd5?=
 =?utf-8?B?MFlFemc4amcwL1ZWRnN5ZFl0V1piUjFyTmhrOUlDNDZJTmk4aEs1cE1OSWEy?=
 =?utf-8?B?SFRWRUI0SVZoZW9hZUF6TjJQRTgxS1FPcTBpTUdaRlIrRUhSMDdEK0VLUEVs?=
 =?utf-8?B?L09ENGJrZjFiNWJydk1aM2JEcHFqVGxiT1VHNVd3b0hUU0NTbHYwU0FsM1Rt?=
 =?utf-8?B?N294SkFpRkJKSFlPVjU0ZnFQNFdKdk9lQTVDMmtIZzkvRXVFMzE3WUF6a3U3?=
 =?utf-8?B?ckwxVDlEbFp2alkwT0RScTZ0dmlKR0w3UVEra2FqSDgvMnJpaU5OcmhPMkRo?=
 =?utf-8?B?WTBGbWU0c1hCdmxQc3VuKzFuKzRMVm1FL0xrQWlVTzBGMjBKNXZYS1RNZERi?=
 =?utf-8?B?bG9mYzBtQ2F0eGdoMzQ2NFFMYzROZkRnSkp0UkNDTnBrc28vOFZtbkNuTFk3?=
 =?utf-8?B?VFNOak9DUFRCMDExYkdBQTRtWVdPU0p5dTJEUlRKVGJTN3RJVWNWTHdSM3ow?=
 =?utf-8?B?eHIrdkg1Y1Q3NVBOWjBZZUg3UGg5ZWRrdDZ3SC9PNnNmRnU1d3kxREtKZlpr?=
 =?utf-8?B?clZGVFNiOFhaWVdOUTRHSFJBeFFLdzdWS2ZMNmJSUEVNZjhBbHNCcHYxQWdX?=
 =?utf-8?B?dk5tU1lGNjVVVlZjWFpDcEpRZWZxai93eXRyOTdsUzJFMVJ3TXVqWW4vNXhF?=
 =?utf-8?B?dkx0ejFGNEtDOUJ4dzdmWXpsaHIxS3ZNbUxMQ2FrdVBsQnNIQ2VBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc35fae-73a0-4c0a-d470-08df29c26588
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:11:41.5193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VzBqyHmAF0Fa7Mb4egAFQ4DZpJTCTy5jzM49n04WZZ5t+Ky989YfPbEoi6rbw3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 10/13/26 12:33, Heinrich Schuchardt wrote:
> On 10/13/26 08:49, Michal Simek wrote:
>>
>>
>> On 10/13/26 01:55, Charles Perry wrote:
>>> On Mon, Oct 12, 2026 at 11:47:51AM +0200, Michal Simek wrote:
>>>> Hi, +Paul
>>>
>>> Hello Michal,
>>>
>>>>
>>>> first of all do not use mailing list on denx.de.
>>>
>>> Ok, I sent this series at around the time U-Boot changed to
>>> u-boot@lists.u-boot-project.org. Sorry for that.
>>>
>>>>
>>>> On 9/2/26 16:17, Charles Perry wrote:
>>>>> Hello,
>>>>>
>>>>> This series adds support for RISC-V Platform Management Interface (RPMI) to
>>>>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>>>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
>>>>> goals and purpose of RPMI are similar to ARM's SCMI.
>>>> I have raised my concern at riscv minisummit at LPC and also talked to Paul
>>>> (riscv kernel maintainer) that this is not the right way to go. We already
>>>> have SCMI and there is no reason to introduce RPMI when it is said it is
>>>> serving the same purpose.
>>>
>>> Cool! Thanks for bringing this topic to LPC!
>>>
>>> That being said, I don't understand why we can't have both SCMI and RPMI.
>>> For sure its more code to maintain, but there are other things at play than
>>> just the functionnality. We discussed this in v2 [1], the points of
>>> contention were:
>>>
>>>   * Anup said that the main blocker for him is that the SCMI spec is not
>>>     community driven while RPMI is.
>>
>> Based on my information none really starts to talk to ARM about SCMI and this 
>> has been introduced serving the same purpose. None should introduce another 
>> interface which does the same thing. That never was the right way to go.
>>
>> Thanks,
>> Michal
> 
> Hello Michal,
> 
> RPMI is already used in the Linux kernel since 2025.
> 
> U-Boot has already lot of alternative interfaces implemented:
> 
> * Xen and QEMU/KVM
> * half a dozen file systems
> * MBR and GPT
> * FIT images and UEFI
> 
> I can't see anything special about RPMI.
> 
> As nobody, including you, seems to be interested in driving a discussion with 
> ARM which would set back RISC-V for months or years, we should proceed 
> implementing what is needed.
When I found it I have raised this concern with ARM too.

I have also sent one patch
https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com/

and based on my discussions at LPC/OSSE I will send another version.

Thanks,
Michal
