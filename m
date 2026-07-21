Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9828C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85CA16081A;
	Tue, 21 Jul 2026 09:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xzl2pAYBijFz; Tue, 21 Jul 2026 09:17:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65E7960816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784625443;
	bh=aaHKsP4iiRx2cWUp7vvhKuKwOdbebknmsCNxXQcjJJ0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JRVWkwregqlNbFrGAGwQpeBK7ACOnmfZ9M+BRi/FXolZ10QwljsHIkSmY2nU4Uy3b
	 xDX0PpOB0pfDIXPBaaYvyQBArpWeXiMc0yD8Iarsxt3tHoK7LnU34WlKpyhKtw7nUU
	 zd/9dkZTXYysHsBYpyIQiKEyA/4jg/dFDfZZ/Uf67fo1sE9AzkCYS8ovE7SVqATLUY
	 GvAneh+VMwoF7gUD2o+8aKUqBZY2n7MNk/QMO5VW2adZRI3StpP58roE2wb3QRWBBG
	 zfo1uTluZ+NYQMhNC2DciHfFWAifUC1+938wNVPnKoPgY8VoFDIQTk/roOcusnfvB2
	 adMLV1gtxCVuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65E7960816;
	Tue, 21 Jul 2026 09:17:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54A4D10A3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A94A80DF3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcIrEy1Gjmgh for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:17:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 02CCB80A9F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02CCB80A9F
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02CCB80A9F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF3RAjst6lNFOTu3Gb+DNSEvqau8RFhGQVG1b6bk32YU/a6xicD1xqlKHekMLVJITvbK4MC/Lsm16rNLxCeEtEh89YFeAvBkxSQPE53U9RRK2zpzFfvZFZ4MSDywunvd7dWuZzSo9rj8+dtkHsLDTCYVeeyxQCJdPxXDfRvN8gpyohRmDNMBfQVcDcbQ8QB1cTVUY/TkTGRH2QmffF+d3QhqKmK9ZP6cLEB1jvT5CRPnIS/j3dNy0tmKZRkUrGGjUGYfvnW/N8rkShy3y/BmYHPU+AqgVf6IQwxHQXc88OHyjmNpUCAYlhtX1rfUcstc61CWTnHhx4d0mFqrQeCsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaHKsP4iiRx2cWUp7vvhKuKwOdbebknmsCNxXQcjJJ0=;
 b=kh+iKDL14Zm5HePFlMw+0jpurpXIqOhCvxB6N4KcvgJ5eqFCcpamMlOdwJEF/8Qltt1CfWkfSV0FEwDY/AsCypsZGBekBUkQ4/wa32i2IHQhEFKomS2BwhdO79Q9aAAUzMZGBCFONbc8qsAuiIXj0elUlmKFuIum4neShiue1EtUtBfKD38c6QTSq2bD0f2D6cY8vohkivpkBMTtuIazgKnLPzdebb63dklzxnFBBOPd4Er8nyk7rDiTriE7V8V4I/XTan9ouSVQsSVxbrpyhx33wYNApzYkXjZuKlRBXeIzbqAA/HOnB+wDrKZIA4JCR88nDKLSWgMS+Ju+oaukBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 09:17:15 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:17:15 +0000
Message-ID: <446e84b5-652f-4573-bea9-ea6488c47fb0@amd.com>
Date: Tue, 21 Jul 2026 11:17:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: armv8: mmu: fix DCACHE_OFF incorrectly unmapping
 region
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Akshay Belsare <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com, padmarao.begari@amd.com,
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.u-boot-project.org
References: <20260708111721.1455945-1-akshay.belsare@amd.com>
 <CAC_iWjKDy8ziyMkuHwhg=-VGZ7C5HMYXFQG+ZjATXqwEDjvipQ@mail.gmail.com>
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
In-Reply-To: <CAC_iWjKDy8ziyMkuHwhg=-VGZ7C5HMYXFQG+ZjATXqwEDjvipQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::27) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 854f3a1f-af55-4e15-65ab-08dee708db27
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Lq1NQxvC94MupgAzMMns38HS3XGamiGWeUYSciDcEIIfxGdMzvRd8k8JGuFFaF0CuhT6wsY8YKQ3b3Fi93EW/ltiBgbxRCuJ9iAJvXH0J4KY/DxFqnP4puFRRj5loES/aBCK/HuvWsM07eys+l5oKEDjKaJc4aWcAcyvyaF0Sl+nt18skHA2VQXKBz+u6Gq07mLVlAVy9Zm8fF/tU4iuaiWM47TVErT0zoJ/JPByuQQRbLOa+/EgmtvFs0aCAlhJgmA6zsyLLW2aEwB/XZKvfmq8Tfw1iUZHm6qsBq2FQLiFxZsB0m/6unzvOWeXm1VmabCXQEtGytiZGjurDGy969w1lxs8RjxkMRCgfCPSePXMk+g5YlWzSsUHSSVLehXrdsXfGFzyhBFS9W5RPvj7LBBco3ZD7kanQNk4FUkvjQUTyBYQoKm+eEIddIXXSh+25SGRoTr+GxB1dlwe6RACB/wLWxCbOVMn24agcsmcdOcQ9jPFLi4+rG387NevLbdmXOsJuvcTLISbcrj55OlewbK6L1SD4WMUIMmC2DTeLz63/md8cifxIEp1noTH6GLKaOVuUNPMioPLU06GEFkPxrU7xniz5WgFlIjFQ7Xggiv8X5JXdmgrKtMVyn6hd6RnD6tqAY5EbYvMGE9ZXGcwGVj3189VVUpqrUf5w0MM0lY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWg1QVNTa2ZWWkpJcTg1NU5IakpaYi84Z3Z6VWxXcEdQNS9KQVNZK1hLR0g1?=
 =?utf-8?B?VTlGcjQ2UzVCV2phRE92Mmg2YnRBWEJ3Q2huZUd4QjVua3hSZE9jTElkT0tU?=
 =?utf-8?B?eHpGVFFDVEhWL0VhbXU0Y1BuYjdKQUczUlRPUjNQOU5NcGVSZUY0b3ZtRW0v?=
 =?utf-8?B?N3BES3ArWGhJaWZXV3l3WVJtZVVmZ3hyaWNyY3BOR2Q2cTE0dTRjWGZqb09T?=
 =?utf-8?B?a2o3a0pHaS9tcUtVRThGcTBEaXJYMk9vTit4UVI2Tm9rRnZOdm84UGFhbVZY?=
 =?utf-8?B?OWYyaTVCWTlRMHBybWpoQXZ0K05hdFRFMlJmc29NVnZOeDVjeU94eU9zMGc3?=
 =?utf-8?B?aUdISUdXZHFOS3BtRVBoYUdGcDM1MHR5RStYNW4vcWgrelFTamNmVW1DbG42?=
 =?utf-8?B?STIxNmlMdys1aDFha25Ubm5EbXhaZVBPSDBudkV3SElCK3c4TjhnNUhiYjBZ?=
 =?utf-8?B?eEMwcGllOFBZOXpBcmRIN2JSdlN5Rk16SS9VR1FQRW0xeFViYkFrQjJpT3U4?=
 =?utf-8?B?Uk1pNzZSRVB6Uk9IVkJkM2lYdlZXdUlMODhYbGEwM0pJbVRCTVE1NHo0N212?=
 =?utf-8?B?VXdZODJ6M21xcllBTlhwNTNjcUlXRkZ0M1lRakcveTNJc3FrcTBtK1pyNTFU?=
 =?utf-8?B?V1pUVytiVmRPVlQzNXZ5MSszRWVpcFNhZ1lOV2dJSU9pRmFOYndmUVcwVjJq?=
 =?utf-8?B?TDRENlVYYkwzVllVZnZGY0RiVDJzdFl4VUVyblBrSXhwUFJ6bDR2T1BXSStn?=
 =?utf-8?B?VzdWc1ZIdnphR0plak95WkZQdlRuSXc4dzFEZWtBL0c1SnBlTzRLRjBUNU9x?=
 =?utf-8?B?V2IyaTRkRXhJMFduZ3NmR1BGSlVMVkYydDJiSHZMdkVDNVdiRU8zY2R1MkFp?=
 =?utf-8?B?aWhhTmN5Y2h5OTZzbXdDYlhZZkpOM1J4ZnYrcy9GTVg2WXpuSzdMOFZtcE0z?=
 =?utf-8?B?TmwxYkxDN2RPOGRycEY1SHdpNi96dHpFSkt2Mk9WR3BwU0haUEFwRWRHa0JT?=
 =?utf-8?B?WG5hNm95NTRJa1N1VTNPemhwYVA1WUI2WWQySlQxTlplZDFuR1N6WlVMdkRh?=
 =?utf-8?B?SzZhWCt0c0xKTWs1emVJZEdEenZKeHJWU3U3OEVHK2tmenFVZTQ0MWZuckRh?=
 =?utf-8?B?ZXEzRGxvNUpibDVJbmJVdmZxT240MVFGdjR0U2hzZHJlL0VrNEU4RWVtVjFM?=
 =?utf-8?B?eGdRVTdoUTVKcFRIdkczT2xvMzBGMkIwMVo1RFgybUFlY2RuSnRWWFV5UE9R?=
 =?utf-8?B?NGVwVkV3UlI5Ykx6eDhWYkE0NURKNk1ubG42Mnk2NSswS1pUNzZpaXpJQ2tx?=
 =?utf-8?B?U0VCOG9mN005WHhRaWhXRFVxU3BtR2txQzFNYVJEc3kwaW9qZlI4dC9KRjlK?=
 =?utf-8?B?RDhtYVlxU3c1MDFUVUIxSEozMnBzeHp0bEtiODEvcU1LeFZHSVVZQysxQncy?=
 =?utf-8?B?TEpML0p0a3J0ZjY2eUVVMU9aaVpxSjFhdEdyc2VkUk5wVXcxTUFEQ0VYNmtH?=
 =?utf-8?B?VnF5WXl3Q0NvMFNoMjI1SDg3Z3diNFZNV2lRZVpNdklTcUZ0UEJ2MTFZQXNP?=
 =?utf-8?B?eWQrSjVNcFJXWFA2QzUzOEpTY3RvZ2p4bWZRQmlwNW04cUF2TXVpb0R2M0JQ?=
 =?utf-8?B?YlN4ZzNnd2RYVTdlR2RVVGR5SmsxZ0FmY1FOTVIxTGRXY054VXdpYjVuOEZJ?=
 =?utf-8?B?eVAwT0NyOVA3bldveFA0UUgxTmJYY3cwUXViNkE5S29VVU5wYy9DTzVrNkQ0?=
 =?utf-8?B?VWgvY3JIT3krRkxXZjdPa3ZSQmNQeElTT0R3bDg2L2VmbmZEZVFmVDd2elB2?=
 =?utf-8?B?TjlkQjYrVUthSUtnSkxlSHRINGQ3U2dZdnUvS01nNzlWT0ZMVUlsanErZzlP?=
 =?utf-8?B?cy84WElOUGZGSkNJUFFDK3BNdWhEZk5NU21uYU9ta09DRjNoendKMU9iL0E4?=
 =?utf-8?B?YmY1ZWdJMjBDNWcwa0VTeWNiTmFrdUVxc2VTalAybFI1UFJoZDFaOVFhQjFG?=
 =?utf-8?B?VjB6bU9SeDZnN3duR3RxOU9ybTlhdW1CTE9rMC9LYWxjT2FBTjJmODhIL0w2?=
 =?utf-8?B?NUt2cmRFQ3ZGaWZERGtRbmhVcEMzQUluZGF3UjJYZHZWZjVRdXlYaWJKZURL?=
 =?utf-8?B?Y0VXODlVUDJyWjJnZmV1MWlGTVljczdqZjZLYUNWbXhIZ1JlZitCZFpmbk5I?=
 =?utf-8?B?dkFrazdMM3EvNVlvNHgydzNTUVVtNWc5SkkvVTgvT1R0QnRlQWxWUmgrUWdX?=
 =?utf-8?B?OUwvZ3V3d2p0enJhZFdtTEp5a050SEwvcDhHSFc5d05Xc3I1RTk1OXhPOGZy?=
 =?utf-8?B?TW5hR2JJWmJPd0hkS1NheWRyWUdzVzRybWh4b21Zanl2YTZ1OFpnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854f3a1f-af55-4e15-65ab-08dee708db27
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:17:15.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIafTb6cMaSfnPmzH2Nzba/GTX0KwYXFsOEksb2GUBQE7/wa2jNkdL6ks3gGmq+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaHKsP4iiRx2cWUp7vvhKuKwOdbebknmsCNxXQcjJJ0=;
 b=ecosYL9Z2rOOi/XoixMN8L5kq7m+ZtKFGgQF+hOudEJ09XeBQD1M442cApJum9nmCUzLDkhyOvM/UvWAuoCO3A0pCLRvKl9JPsqLnYWo1gPBfBY9MJULsMv1J5d2Sm7IBCFIB/r3HieyX3HK8E3Qt6S1tgjKf5mCdpGhnIJ3PQY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ecosYL9Z
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
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
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On 7/8/26 13:47, Ilias Apalodimas wrote:
> Hi Akshay
> 
> On Wed, 8 Jul 2026 at 14:17, Akshay Belsare <akshay.belsare@amd.com> wrote:
>>
>> DCACHE_OFF is defined as (0 << 2) = 0, and PTE_TYPE_FAULT is defined
>> as (0 << 0) = 0. In mmu_set_region_dcache_behaviour(), the cache
>> attribute passed to set_regions() is computed as:
>>    attrs = PMD_ATTRINDX(option >> 2)
>> For DCACHE_OFF=0 this evaluates to PMD_ATTRINDX(0) = 0, which equals
>> PTE_TYPE_FAULT.
>>
>> Commit 6468ca13ffd6f ("armv8: mmu: fix and optimise explicitly unmapping
>> regions") added an unmap path to set_one_region() that
>> triggers when attrs == PTE_TYPE_FAULT. Because DCACHE_OFF and
>> PTE_TYPE_FAULT share the same numerical value (0), any call to
>> mmu_set_region_dcache_behaviour() with DCACHE_OFF silently unmaps the
>> target region instead of changing its cache attributes to non-cached.
>>
>> The subsequent flush_dcache_range() call at the end of
>> mmu_set_region_dcache_behaviour() then crashes with a Level 3
>> translation fault because the region it tries to flush has just been
>> unmapped.
>>
>> The existing flag parameter already distinguishes the two callers:
>>   - mmu_set_region_dcache_behaviour() always passes flag=false
>>   - mmu_change_region_attr_nobreak() always passes flag=true, and is the
>>     only legitimate caller that passes PTE_TYPE_FAULT to unmap a region
>>
>> Guard the unmap path with flag so that DCACHE_OFF attribute changes
>> take the correct else branch, which ORs in the ATTRINDX bits only,
>> leaving the PTE valid.
> 
> I don't really love the 'flag' attribute that distinguishes between
> preserving or overwriting the permission bits...
> 
> However, this does fix an issue.
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Can you please cherry pick this patch?

Thanks,
Michal
