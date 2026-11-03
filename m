Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E9606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i4bT7iSu;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hq1+ikJv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6AD280AC4;
	Tue,  3 Nov 2026 07:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qcdz6buydrie; Tue,  3 Nov 2026 07:00:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB88480C7E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689227;
	b=DExcSO/qDFo3rgw9jEpRlThiw76YrkS7Yqe2JrDvx2aL4RAR+3+JXM5NLf8rr0ZLlN/x
	 lWR4iXev6aNmpNkZms3GO5uoT1lg8X/SHqdaXl7QrT+008gp0NOyaH2jWDLREGI+3qbPC
	 54TKvqF54VftyzlrsQKD/9NmMNxUuXjt7dYbsA6WmUsxMXe1qPoTLDCBQkxg8/kzyO0ZE
	 7tFrdtycwzDC1AavL0in+2c7qmHSOqGHNUXCJfZ6Vg/P+inpR/Jginse4vlZN9pQtSlHW
	 zQ2od2xqwb5e15OhA2nwc5zj9qz++bqE9rEE1yimQD+ViaFgjeVVMhoX9meUOUOQjyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=EV0d7I4kLzjKEXqj1L08BF7WHj3vkAfG+dphJe+w0jo=;
	b=gaW56k4J7/ZC/UB6zvPYVXBoGbiurWR7+fjvU9oJEpPTEJu7XWwhJOVBNPRLu+ZDIEZ9
	 Qx5nNXrTle6lJPMCsrT/JQYOgA1jpJhSoDJcRCqhzhN6DWCZ9jEPOQy4Rig/ZtwiQl99j
	 UN2nchZLZr/hts89GbpG7V+h8rmT8KtXIXhavK/LMVzmLOzoIgf4C8dqyX8JOmMOmTejQ
	 B2SJPsgbWZ20CqSBbePkjLFcVPIGB+2mcg7uCupDuNvdIvZmjP96+dWoAFKtETfkv3VE1
	 XSDYTyJNUrJcW8n2ezklnPlmSOTG/J92eZkw7R12nxJ8J8ZNQUNtoP0n+0kjx8HYVIA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689227;
	bh=EV0d7I4kLzjKEXqj1L08BF7WHj3vkAfG+dphJe+w0jo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i4bT7iSuWImJfJwod5NIYIHcxFuPkJE2xgMtviWgMd7r5i6g+Gopw69A0EGmuSc3v
	 74zAGNpsPL9mjf1QAr4yyUL85wziPLnvDjKP0oJHO5/HIE8Miw+Eaj8s9Ak7vo5eXH
	 /tcTXRizgP/CPVucfT465c9tfOcjhGbkMDnS4dGTmxbuhVtzJ8nW5lO1ymXVV7msHS
	 gGUUSHQTNgcW3Mb3jAGbId2KEA4oS28SPuGGb439muP5iubhTOQjSIjWhJtjNDTrQr
	 V7wnTCsyRDF39v0BmJ6qHKgXgOJm1lFgdl418vncjcEeavLu1HIF2VJYE4XiJSSkUu
	 Om/X82NNz33mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB88480C7E;
	Tue,  3 Nov 2026 07:00:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC8F82AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDF25606D0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtxEqbLfPkRa for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CA2E606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689224;
 b=mOCGSvhisAiAdaA9wf/bHts6aI+4Myy1IxfAvN+yBjpIweQ87dZs3z7EtpidWVAMHATH
 pto4lUE2x9QMzXFDt2bAnCVO/BF6fhlM8aXy1i75okllQTJi5rXEZE80n42KUjQz4Antf
 g5yrwTX2VdcmigNX76UDZ1EH4f3HLOopgOB6YOuJCHtXxTMqlyAu4hXJJpOsIyGuyQYCv
 xAt76wikdHktlHsXHHlRBLJHM/DH8nUF9vJO+eusbZi6ipIPqd7bgbgAPHbqZ0cN/zfiC
 0rjBsScZJRnG9TpooAnGCywZ9u99IE0VPGyB9n5rDZkFm4Bxsy/eJIcIc7LOoYXf1Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689224;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=EV0d7I4kLzjKEXqj1L08BF7WHj3vkAfG+dphJe+w0jo=;
 b=YNaJYYtijjWWNaOEZUiU562vU+/ijOYVCVbo6/+/kq3aaxgTpLZdjJODGwChhYzs2IBY
 L0i2CUlY1uQCnOFDTM2PIq6Q6msDyFZ6SIjv4I7Ga37Aic9NRDEZ8pJiTWtw89cm/FnrP
 A07jTmZqVTTAukPOmVPQ+UGPNv7Q+oGqKPUmPBUF8tizq1xj6TozXG3eF6VowznCtJ3mf
 0Trl7Vqd3TJyGgVTs5ZdwwkhmqQpt89p0pYdQ1suQmvTRDGXPTV7sgruNtVm7SRb6NIQV
 5Xh+q3WDrW8BJ/cGZmn7UyT28K/PbSUmA8T6tl8/0DjrTHwIT/GmOmDZSdbEDeDPoYg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Hq1+ikJv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Hq1+ikJv
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CA2E606B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3HesXSB+POzL8F35xmwV8cJEYTkJPTA//Kp1xfYamM8mntd48XpV0JGqCAzlY4D4d9w0HS1t/sf/hxUCMD2W23qWeohKESRB8gHUJOdLy3G5Qg2Pk7SWCZAg1rn9D0RhA9w1+ltY+1oXszqvXgUv6cZa8fdeU/W5EpVzGwgaPSQhxV6YcNicB017giBp7y88FpPgTuWLCGxPMHZ6s95oE3PI1mG8VtrD/QYYmeuzUlw4MGupP7G4AqEwYFGnVWC7gvM9jyznYnUPsyNyCbBmYZEQcve0YxwZ++7/c53LCVucJJF4OcTwIi4QY8/7X5ojROp6rUCxXuSUJmjVFKBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV0d7I4kLzjKEXqj1L08BF7WHj3vkAfG+dphJe+w0jo=;
 b=CTub21ms7pLf7kSrHNEkvqx/OeNs+f1CD62zRimLj58B5osaUshope+lwHrbrZlSjQaY6izfneKlfkwXtVvk1p0PHI7X0tVMudWKsbRttrzYFhIxtN4HyDHknwuAWIMY5+/ltym0ss35n/bDRtnLPv58mJShNZqhyzqkY2h4R4t75D9W4kgb4w5ogfRN91OngPFFWUhlPeFeEm7HRYHcfZcUMBCGSBXWH8L6ACPKEVELyIxDuiYWw38EjZqbt7TMdN9xBtg+EhbU/M9lEpwVIhA/eIN6X2UZH7kfnypOpawqRN7xMibueWZXxpnyO2vQQ2Kn/x7jrnMfLZeLFATV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV0d7I4kLzjKEXqj1L08BF7WHj3vkAfG+dphJe+w0jo=;
 b=Hq1+ikJvsJAoGK5AhzzfxdyzhNAFjLISy4my4vkUcpl3sOR2dYeGWGeQcYzhlJvtGwd+s5eUKGBAjsqDchRQJiZ91ckuUG1RrmuUua+p3CEAcwLl5S/8SH4Yphk+JswQJaHrvd6Qc0qrIlIFV4lZm0lIo8DYLfJ+JwcUvlisny8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:00:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:00:19 +0000
Message-ID: <95e50afd-5071-41ce-85dc-240ea7426a29@amd.com>
Date: Tue, 3 Nov 2026 08:00:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence_qspi: Fix double reset assert
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <840df4102aeee1108ffba82c74dcfefbf0fc062a.1793001986.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <840df4102aeee1108ffba82c74dcfefbf0fc062a.1793001986.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: fc582328-5e6d-4d18-506a-08df39781f2a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261021121427099003|261026121527099003|261022105027099003|261009221227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Ptb6NCR+Ki8CkLkDoCt6oAu2QPT8BDjzPccsRBOuyl8Ph9dXJvsMcIs8vqYws4fgVofU3loaAVKI3FlNuid5EFvvamo8U2DPrckJ8XTdw3HTl9J97RUa+nZkhNh7YuGYtIjKhFgvvh3rZPsG2+7b5Mx/xSrrYk9uPhAUsQI4+JGKxyBlXGKb3bo51ZHNVZWcCJS9W42/ncEpJaBbO8LNrKKVgIxU8aJmmpWnpzxryB+wh4wSoR2i2z696CZAKL8MGxWGZY1/IJSv6anhSw7uD/6reexh9+S7iAMl+VJ2mAMSBSQid5xPbJwZcyby3+TcD54Smn5EAkB+NMyqZ6vRUAEKXAgGpYizCXgK7pBnEtYG8ovdt7BE/5dq/MCrwXc/sNXHb15JaZ+P7qY8Wl112wBML7nfYagagXydEb/6o/PpJUXeGojo2LkLd2yF6wy6umo5Of2Y3stbUWKb2rexFECt7Q9BT1bBi/YRoUoyO99hgudOk2Yo0K7Rb0BY6gKnP2fZBaoxzEORnS/Q9wli2Lqlvaez53E8Zl4XVxY69jhjrMW6NMvepFGel6nhkSBeR1LHFCxb/MH46PDbL+9Ot5NF0jQ3+krIzgSiqI5k3Knx5gnQQK56bsRrhCBcy/+H1vTtsgWm3OwZb13HOUcf5K7ygvQz9wzMaqPxFAz0BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(261009221227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkh3MTZoem5GZGV1bjcvTm94MzhhQ2M2alM4WjdGRFZsTm9pNko5Ym1zVVJM?=
 =?utf-8?B?Y1F3L21Db1VYNmdVQStNM1JRZTNoa2h1VnM1QXhmSk0yUGdPUW42SkZ6N2pv?=
 =?utf-8?B?VFNGQ3N3MFo0ajRpamk5UmFTU2dvT0tKL2tpSXJ4S2JvNDlCOEtObkxEaHB2?=
 =?utf-8?B?cm5udW0zNklTTldkYXBCa1BuakREVVkyQTRCVGxKN1JSaXJEZWdObEwwZ0FC?=
 =?utf-8?B?R0hmbTBIczZJZzcxUTZWZWs5TngvVlMyWEN3VXhnZWJNK0tLR202RkNwMGJz?=
 =?utf-8?B?RTNQdS9QQnlMVlY5My9uK3B4Z3A3eTlyVjAxaWxvYVNlZXJrTkhtSEJETzhY?=
 =?utf-8?B?UTJFK3J5dm9nTmxpeFd2YWVvemVmRDhnejNYZmE1MU9GaE9Kdlp3WTlkNXhP?=
 =?utf-8?B?RXB5cWFabDRaejRwazBoenlSd3RsOHlBT0dORUI2WFdWREFJNGpWTms4YlNS?=
 =?utf-8?B?UEhsdWRqcytOQWpiQm45YkU0UWgxSGZGNDJFcWpWcFBucHF1a3JmWXpKNkVp?=
 =?utf-8?B?Nkw5Ti85ZTA2QVhzdklZd2YzUnlqTis3VGpBVStzVCtweExqTFVQUWNTSVVm?=
 =?utf-8?B?Nk5KblJnVTBlY3VWTmMvMzFlbk1yb3VUd0F1YkNLYVB2YlhyVWlDRkRDS2dD?=
 =?utf-8?B?L0FnbW5Na2JCci9qMUcydk4rQ1VhTlRzOStSM3JMeW5obEtKalJtSVVOa3M2?=
 =?utf-8?B?dE9BT1M0V2JYM2JML0dPeXErcGM3WXBsN0pBdVp6T1VPeGgrSllPWi82RzFt?=
 =?utf-8?B?SG9HV0gyeGtMOUJ6bUNSS01BTkloY2FVTHVENU5GSnpCR05VL1BrNmQ5THZQ?=
 =?utf-8?B?K3dmMXJuQ2lrQitENUhKY1Ircm1QTktVMTJTbmlsSEtSbFZDS2YvNmdONVFq?=
 =?utf-8?B?UC9Bd0htNXF6SkhSRnhWaXFZNTJ5RFVZZzJaUTZxVFl4aFlqdlBQRjF2RTVt?=
 =?utf-8?B?NGhLVUNTWEJnMm9EdjNHcmlzVDBvRGMzbHQvR3FKWHYvSnVEeG9KelJqaXl5?=
 =?utf-8?B?cVBBNGFxdnFWbENSZEg3dmtMeEhyUGN4bkYrb2Z6R2J5OWV1NWg5dVY0MEV0?=
 =?utf-8?B?Y2ZBYXJLL0NvVUdkSU9LMFZvRDU0dmRNY1VIQ0ZoelVERzFPdmM4SjhaNDYr?=
 =?utf-8?B?NFVCTU1qSGpYMzFETmZuZmZDdnBYbzBzcC93bmJJci91UGF4YzU0Ym5GUzVU?=
 =?utf-8?B?WkZrdUlhVTdUcUMzQW0wZjNtd2RzRlhnaml2bkhmeDZkdDRoTXZjai9PQStL?=
 =?utf-8?B?SWloT2xsRENzUkVQN0dpWTNSdGFMKzVvNzREMnc5SDlRZDAyOWdudDVWb0hP?=
 =?utf-8?B?eEUxekpXR21adDFDSWRwUU9HaGtycUpDRUIwMzFTS2ZTOEZDQXVBZU15QXo3?=
 =?utf-8?B?eHplekxXUmMxMy9nTnpZZ3lpazAxZDNZQTBHT2ZHYWw1VHgyYThrb05Mem9N?=
 =?utf-8?B?c01rSGQ2NDE3bStCRjg1V2xDODhkTnBvWVF0dUVzaVNVc3BPbG9UUU9KQ2x1?=
 =?utf-8?B?SWZpaHFKUmhMWkR6SU9BMDVoa1VuS3Y3ZHFqREFiT25QSWUxT3YvMytTNFFv?=
 =?utf-8?B?akZEcTkxSURqekFncTAxWHVTQWYyVWxIQ2twVDNmS015WTdCcWNYVWd2N0Q5?=
 =?utf-8?B?dWllc040bkdNa1V5b2tyanFpSnZZY2xlbnRvRkxtaVl3QU9UUW1XUVlab09s?=
 =?utf-8?B?eXVLYnpSZFdIalh5UDc3MnZveFplb2pDc2FzYkprTjIrbS9OSUhWdEN6VUp4?=
 =?utf-8?B?ZTZRZGkraVU4eUcxNGllR0NCZStmRmZOa0swS21UTHVSM09HL25OTEV1Q1Zp?=
 =?utf-8?B?cXJ3VnJxcEdSQStML055Ky83V2hrbnFQNE1IRG81cW15dk1zQTJiTlpFOExT?=
 =?utf-8?B?cnpxK3orWG80RkY1SkY1TXNWN3BsQzE5bGF0ODA3Z0lIcVhwbTF0NlMvK2Iz?=
 =?utf-8?B?MnJuRklzRFJKczlUZDRLOEEvaFJaeGh3U3NVbWk1bTY0SEE5dkpnZDJyN1NB?=
 =?utf-8?B?UEtQU21OWUZadXVNa0R1eTdNWXR1eGt1Z01sVUs1N3JZN3NiN1F1UlhPZHky?=
 =?utf-8?B?OVF2NWVSSFNJdWEzR1NkY3dVdjZNd0xLNEFLZk9rekYwWHUzcmRISGlrcTE4?=
 =?utf-8?B?ajJvRWJ1RUlhdE1TV0s3dHgvVjU0WGlyVTRsRkdEczhEcUN5dHhYa0wrQUNC?=
 =?utf-8?B?RmZBOVZrWlVhZWM2cmszcllUNjhWbTZlRzVoTHZjM0dRdCs1OVJrZ1JWa0Fa?=
 =?utf-8?B?MGVMSG0vK2p0aytCTmMwbXM1TGZ5V2M4bjlNTXMxSksvZGllaTRmRUF6UHBY?=
 =?utf-8?B?QkVYTUE3SVBqdmZlMzM0YjRHU2g5Qnl5aENzSVlQVjNVM1VQQ1JuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc582328-5e6d-4d18-506a-08df39781f2a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:00:19.2336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIS6Cx7F5PiBJASThZUP6pvfq0KbH7qlU+/5IUnuP33pzCDUvKuPBcCXuBDwWHxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/26/26 09:06, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> The resets are requested with devm_reset_bulk_get_optional() in
> cadence_spi_probe() and released with reset_release_bulk() in
> cadence_spi_remove(). Because they are devm managed, U-Boot releases
> them a second time, automatically, after cadence_spi_remove() returns.
> reset_free() does not clear reset_ctl->dev, so this second release
> asserts the reset again.
> 
> device_remove() calls cadence_spi_remove(), then turns off the power
> domain, and then does the automatic release. So the second reset assert
> is sent after the power domain is off. With the EEMI power domain
> driver this is not visible, because zynqmp_power_domain_off() is a
> no-op and OSPI stays powered. With SCMI, PLM powers off OSPI and
> rejects the reset assert, because a reset is allowed only while the
> device is running.
> 
> Removing the reset_release_bulk() call from cadence_spi_remove() is not
> enough, because the automatic release still runs after power off.
> 
> Use reset_get_bulk() and store the bulk in priv, so the reset is
> asserted only once, in cadence_spi_remove(), before the power domain
> is turned off. The resets stay optional: if reset_get_bulk() fails, for
> example when no resets property is present, the driver continues
> without reset control.
> 
> Fixes: e145606ff293 ("spi: cadence-qspi: Make reset control optional")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - reset_reset_bulk() requires 2 arguments not only one
> 
>   drivers/spi/cadence_qspi.c | 10 ++++------
>   drivers/spi/cadence_qspi.h |  1 +
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 4d13c373aca9..bb8e7004a343 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -260,13 +260,11 @@ static int cadence_spi_probe(struct udevice *bus)
>   		}
>   	}
>   
> -	priv->resets = devm_reset_bulk_get_optional(bus);
> -	if (priv->resets) {
> -		ret = reset_reset_bulk(priv->resets, CQSPI_RESET_DELAY_US);
> -		if (ret) {
> -			dev_err(bus, "Failed to reset OSPI: %d\n", ret);
> +	if (!reset_get_bulk(bus, &priv->resets_bulk)) {
> +		priv->resets = &priv->resets_bulk;
> +		ret = reset_reset_bulk(priv->resets, 0);
> +		if (ret)
>   			return ret;
> -		}
>   	}
>   
>   	if (!priv->qspi_is_init) {
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 6a8f9c58e4e6..92f3c7f43986 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -246,6 +246,7 @@ struct cadence_spi_priv {
>   	int		read_delay;
>   
>   	struct reset_ctl_bulk *resets;
> +	struct reset_ctl_bulk resets_bulk;
>   	u32		page_size;
>   	u32		block_size;
>   	u32		tshsl_ns;
> ---
> 

Applied.
M
