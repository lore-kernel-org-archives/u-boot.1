Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5575D60CF8
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BAF894AD;
	Tue, 19 Nov 2024 01:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="fHoRiZEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CA9891E3; Mon, 18 Nov 2024 23:16:45 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8648891A0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 23:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnW6Bu7HVH66h+HH6QUiFsPqyFDDuiq8l/N4jp0n8y3IpwZV86DKSH6FPpmNf0k04TEnDbv8JHONR0436d2r7T4KO9ZmhyXIOoqAEGafo/Vh2MLQvMriIkQQ9301FsbksmB+ngcyYf+1isLiABMAd6K9W1E+GdgusKwl9MbyzNSgVXD/d9iqaxdkm2ZXdOjmxkOfPUlrB/5aR9Lie0BHy6QcxujbEJUEaRmy7pJIZKCzCyuPx44j4jxxbUVXyLyx4l9Wbtlcpxb2l8kNukcuQVjk54S18dfMxPPIgjokvSwIsZmT4A1PA0etugHfaGNh02aBjg4tDvhsAHeJUBFUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvnaCbwpKLF5yg23pJ/z257U1M/c3uoHAve11zmPX5o=;
 b=KEKRGvZUUV7nVxeGpJ74PAb284RY+kTvLOYVknNBoyFFgNCaP3Owy3t4UWZDk2eNT0vO9km4bzEtbMLu1htHBHymIemZSfnia2mLdgz4cBPc8srjCaV8GFxGHPqJ5UtuP7IDn3otB/kpRfgHt8qdvIEQ/ONkD3uzayhXw7Sqt+Q6v4GynoktQCzEOP5pTH7l/TSUT4/Y3xwbciXs6MfftVlFjJS9qlSqXsG3f0t1DwfqFOM1fTjShPfnumUiWvFt2Kc2ucovHlmhFEyNGkoRZrNkL4fnU+wjoLA+zFwyJsDEVlzA4aPYHMPABjRFECOtNuqowibZYV/kIgbVmvQgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvnaCbwpKLF5yg23pJ/z257U1M/c3uoHAve11zmPX5o=;
 b=fHoRiZEb6SqCJfGnKnRXqegRvZFQUhXlM3aOV0kumUU+c7Ugp5WgRqwXIhhPS68HUzAjSTZM8v51dE/M8pQlRMiTuBuv7P0GVrcdBJ3oKPpiO1HSTaxPaLVg2InLD1b/eJP9NLa0IBLB1q2Y77BuwwRCXvEdZH5tjEJmpHZzV20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SA6PR22MB5843.namprd22.prod.outlook.com (2603:10b6:806:414::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 22:16:32 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 22:16:32 +0000
Message-ID: <3bddda90-cffa-4c4f-8d71-48ea004838bc@phytec.com>
Date: Mon, 18 Nov 2024 14:16:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
To: Tom Rini <trini@konsulko.com>
Cc: w.egorov@phytec.de, t.remmet@phytec.de, sumit.garg@linaro.org,
 kever.yang@rock-chips.com, marex@denx.de, festevam@denx.de, jonas@kwiboo.se,
 Oliver.Gaskell@analog.com, aford173@gmail.com, prasad.kummari@amd.com,
 neil.armstrong@linaro.org, mibodhi@gmail.com, n-francis@ti.com,
 d-gole@ti.com, afd@ti.com, sjg@chromium.org, bb@ti.com, nm@ti.com,
 d.schultz@phytec.de, nmorrisson@phytec.com, francesco.dolcini@toradex.com,
 vishalm@ti.com, vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org,
 m-chawdhry@ti.com, j-humphreys@ti.com, j-choudhary@ti.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20241115195055.3023365-1-ggiordano@phytec.com>
 <20241115195055.3023365-2-ggiordano@phytec.com>
 <20241118141046.GN3600562@bill-the-cat>
Content-Language: en-US
From: Garrett Giordano <ggiordano@phytec.com>
In-Reply-To: <20241118141046.GN3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SA6PR22MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 74615a84-c91b-4037-a073-08dd081ea820
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnZJUWtYTmp3WmxULzBMbHBlMVBuVmljUGlXNkEvS2JPVFZ1WUpoTFJnYjN2?=
 =?utf-8?B?K1V3Rld0cCtQbFF4R3B1TVdNSndvbE44REk5MDJLUTl1a0dYenJpWjlzUVpw?=
 =?utf-8?B?b1hydXBFVWsrSzNWRHowRmx3SzRkZmZ1YVB0SFFmUDRrdTBBZTFOYTYvUjN3?=
 =?utf-8?B?S2l1aFBOamxidzZzZ21DZ1NwQ01kcTVkc2l4SGtCekJDRVJIM0E4OHQxZ3lo?=
 =?utf-8?B?TTVCWWNORmhNdE95VlpkVzV3bU8vUDNpV0cydnpNSmNiMmlGQUt5bnovekQ3?=
 =?utf-8?B?SWdFeGtBcktlL281ZUVVN1ROOUo5TjRTWkFoVU0zT2QraGxGWlJqakpUNVJo?=
 =?utf-8?B?SC96TlduQ01XZ1VhVzdxbU40bno3R2tKbndRM2NHMGxOenFUSE9tY0xRcDdN?=
 =?utf-8?B?SmxGTzNVZmxiYUMwSW4xaUtVWDVNYW95cGZmTFJxRzgwVDhmc0RQQ3FkUzF2?=
 =?utf-8?B?UXNvbGpDdUxFL2xQUkhLZUxodUJYT0RaTmlpemV4eDcwRml3Qi95blJUbUZj?=
 =?utf-8?B?NmRzM3hLWHVqRlc4TlpMUFIzWlBEZG9EYmpObS9VTXlJSkIxaWdJQVdTWm4y?=
 =?utf-8?B?ZDFOMFdVczNXYlM2bXovS3ZSNnFuUXI4WGozRUtNSU41NG5mK3FRM3A5S2RN?=
 =?utf-8?B?VENCTXdGWGo5azFsWVVvMjlEcWQ4c2w1T2VuVDZvMXM5V1ZxR1B1ZHEzTFFj?=
 =?utf-8?B?eUJpcmQ4djBWeTNOMlZaSlBnemtiYllzNWE0cm5yZ1lENVVsQ3l6QzBpNEpv?=
 =?utf-8?B?VlFDdU1Xb21pWUFVY0l4SHUzREtLSS9TLzIrc1JzUG5xdEdsaDd2NGxCWWFY?=
 =?utf-8?B?eGpnQ0dsVkdkVEVOb1RPT0RVZHk3bDhjb0ZxYkgxZTRzc09ISHpwajQxQlVt?=
 =?utf-8?B?OWpTUkZpeTJKdG1SWjFoQ1ZSSEplbG9PUWJpazdQc29USU42b1daZlVjdjJi?=
 =?utf-8?B?dldvcFpmUUlOUzBqek96V0t6M21HdE04c1ZWMWJmNERhVDBvTG4xL2xKWUpo?=
 =?utf-8?B?RnNTbko2NzZFMm9VWElOQkxic29ueCt0VVJjWG5hZjdpNCtTbTZ2dUJxSkJV?=
 =?utf-8?B?ekFOUVREZEtDKzZ6N0ZFbEx1bkl0My9TMmJ2OGI4TkpkWU90bUxaODlWTlBM?=
 =?utf-8?B?YjMwZjBUbGMzVktIeXhOK0RyMDhwNWFBTGZTNVVqb3JDNDRjRkpOc1hQWHlV?=
 =?utf-8?B?bm4xR2gwYXRUcU85QWFoT3BmU1dsSWJ5cXlVTis2T1NLb0JDWnlwSURBOGlj?=
 =?utf-8?B?RDJ4WC80eEZjSHJvQ0JuMUZVZWJwcHlRZ2dSVUk3MjhUSkFvQitYZlNRVFNY?=
 =?utf-8?B?MVNNenp2ckcvMkMvOHFyU2ZFZHFQY0tRVFpUTHdRNEg2d3RwV0FpdjNPSzBj?=
 =?utf-8?B?aWZNSThSSHZmQ2JRb1NMN1pPZHR6YVBaZU95UnJlQml1aE13Zmp2WFd3bUVi?=
 =?utf-8?B?VUoxNmc3dTlYZFZGamVQdURwbHl6OS9jOHV3VjYwU2RIcUc5akl1VEhaTnFi?=
 =?utf-8?B?RitvdXZ0SEM2OU5aRitSbjZQbWFJZ0tSSUpZc09hemZrR2tCOHI2dEY2SFl0?=
 =?utf-8?B?V25nSTNFMW85cDBjS3h1cnpkdmNSUy8rOWw0enVkekMyRmwyVXdseXdSa05S?=
 =?utf-8?B?NjJXMHRaL0dRMkw1VjdSbThpWnJ3WVRMclJjbFVBK0ZMN2VXMlNHWVZQcDM2?=
 =?utf-8?B?TmVjUzlxQkZPUHF3aTM3OEVZTGVCWWhZTHJPWHZ0b25PVEpaM2swenVLR1hO?=
 =?utf-8?Q?UMBcgO1XqfDKa6MIgno2Qf1YZTbmxoMaUgkJQsy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlh0RmR1YWRXMnJ5NlcwRytUdndxR29CSnNJQWNRQ3BEYTdWM1ZYNnZXK0FP?=
 =?utf-8?B?NkVmZDRjUzhPeVN3TTZEeXdUUFB4dWxGWFhmT0dWZndCSER4WWhXMndLbVA5?=
 =?utf-8?B?dElCeGl0bkJrWEZnZGRSbFN5bEltQmYzOTJXc1hWRUtFYnZYVUFYS2xBVTJT?=
 =?utf-8?B?V0RoUVNOaGh1cUdQVTNqNDlGRUFrb1JtRitJMDgwMXVicFdzdUFveXU0eEJn?=
 =?utf-8?B?NzEycFBvZzU1eUxadm0yT2pmZW5qa3BoTzRVdzdUU2lZUUlLaWJyeTFVMnd3?=
 =?utf-8?B?eWJER1lZR3UyVUFBcHpIUGhCNHpjNXdnVHo2Z1JnSlRJQlJLenZuYitXMThB?=
 =?utf-8?B?czkxUWkrY3FwbHRHV0RkNFpXcnUzaFRncVMyQTA2bkVsMXU3M1g0VS9zODZt?=
 =?utf-8?B?bnY3bTdXT0RQaFBUenYyUHgvZEx5MDU0SG51OHdEdjF4d0Vpb3NQWmIrZWpy?=
 =?utf-8?B?TS9VbUNsNGdqMnRYVWo2dFVGZnpyS2hRTWJBNWdVYmE5RzdGK2VZSHR0eStm?=
 =?utf-8?B?akRsUnNOYlZtZlM0TVJFYU5SOFpiL2dHcUl6MXg5TmlwSEh3bEllcmhQTUlx?=
 =?utf-8?B?Q1psUTMzR0J1UDZlNERBNm8vWGlhNXl3ekV6dnRCalFCbEpiaHlRendoVlU0?=
 =?utf-8?B?a0FBWkhqbHcveSt3K1lMQW9nR015MHpyUms2YTkrSExTTFQyYU1reVlmODZw?=
 =?utf-8?B?cXNJKytGWmE0OU5OdUJOU0ErL1JLSWhyOGxyOFFvS3F1UGRMUnJhMlZUWTVw?=
 =?utf-8?B?Vk1mQ01SWTM5ek1XbGROczlWeDNHWHQ4TTJaaFFRNmVWWGtIL1g5TVBDR3pU?=
 =?utf-8?B?eHNlMmZhTm1DQk1VQStqZkRURXpRM01zbUdsaFJvS2h4ckxsMGxUb1VOeitI?=
 =?utf-8?B?RWNGZ1VrbjIzZUtpL21DVUVTcHdjQnNUYnpML0VtYlN3ZTZEYW5PYmd0MmJG?=
 =?utf-8?B?TXNRd21tNHBjcnd0MGdIcGVqQ20xTTlxQ2NYVDl6dXV6OWdpZmV2NXVJZjFn?=
 =?utf-8?B?ZmJ2SS9DSTBWV1VLN3grcTlLeHR0Yks3aE51cVNQZEJIR1l2UUE1WEZiS0VF?=
 =?utf-8?B?TlJVS1VuQ0p5SUdTZzVUSU9Qa1AwcmxBT1g2a0dBVXdwU0lFTGRSY01zRm81?=
 =?utf-8?B?M0NQSk5tQ2JtcXBLUkhyc3ZNTDFEakZQd0M1c2V4bXRHSDVFQlhNaXJ1Mklz?=
 =?utf-8?B?OXlKa2JiN0FvT3ZhWnFOaW8rbEcvWEFqYklMUGk1RXVtc1k5dFlMQ0xwdWlo?=
 =?utf-8?B?VVhxTlVQRFJTK204bXU1ek5WL2c1S0VRbTE5a0ZDTk1UUU5WSk5sMktXUkVY?=
 =?utf-8?B?MFFtcEhkUGwyY1VOcXRaVHNSOFFwT3BKVWdqTUdwUEpZdEF5bkxSTSs4MnFM?=
 =?utf-8?B?aGN1eFhOZ0ZURHA2YWVMTHhkOGtvNUNveFJrZmtXTUpZRkduWkxJanVCR21q?=
 =?utf-8?B?cU1ZNFdwdm4vd1E0Tjl5M01iUVE5emcyc3oyc2dMcVpnTUZiQlc0emNibEc5?=
 =?utf-8?B?S2ZVZUwvNmw3VlhtOGVvSE1WenpwNjlXM3BDak5zczFGUzNJMWQzaU51d1FH?=
 =?utf-8?B?YkFqdUw5VlpFQnFIN05WMWcyZGZKTnk4NU8vSE5iNnhXcG4vbDBhc21rQkt2?=
 =?utf-8?B?WSt1MVFJcVM0MmFhaXFUNU8yQS9sVjZ3aGxXdGJmK01ualJ1b2NVSjN5c1hI?=
 =?utf-8?B?MjVxemNaZUFCTzR4QnJ1U0gzYmFnZzZFS0V1Z0RlMHpHZmc5KzJ2YUd6TGV5?=
 =?utf-8?B?MUtROS93LzZGNFM4dlhMSXVlSUlEQUJ2cXFhZG1kWnE2NEtvaVU3WlFrK01T?=
 =?utf-8?B?NkF4TmhpTzc0NFNGc1crbUdLRGdDekRoZGtpVmFUVVBaOVl3b0FCbXEwWDgy?=
 =?utf-8?B?Z1Z3NzdhZXFZY2d3T01reVh5V1pXVlZsSmZEZnVRcjUvcUZBcFdsUzVveXBk?=
 =?utf-8?B?dXRKcUc2MXlrL1lXQ3dQWDRZK1RaQ2Z2YXZVR2ZoeXZObkxBUWVobjFXVkUw?=
 =?utf-8?B?Y3lOZ0oxRTVhT01TTEJNcEVPZ2JFY2plNGFpSFd0NnhFN05yT0h2V1lQUFho?=
 =?utf-8?B?WmdkUHJLa1hiaUY2a0lMVG8rblE0aFdXaGdDSGRmTWE3ZjJMYm52RUQ4SjJZ?=
 =?utf-8?Q?J5uq+CTiarBgOHIyjoNDCZ+Gd?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74615a84-c91b-4037-a073-08dd081ea820
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:16:32.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emYTV+of12lehsT1CwAcqMtuF63xNLJhlkOENclCCQD62M0bzis0Um2ttK3T2iGdfxkQq0kD3nsnwH0WQGonIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5843
X-Mailman-Approved-At: Tue, 19 Nov 2024 01:22:52 +0100
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

Hey Tom,

On 11/18/24 06:10, Tom Rini wrote:
> On Fri, Nov 15, 2024 at 11:50:54AM -0800, Garrett Giordano wrote:
>
>> Add support for PHYTEC phyCORE-AM62A7 SoM.
>>
>> Supported features:
>>    - 2GB LPDDR4 RAM
>>    - eMMC
>>    - External SD
>>    - Ethernet
>>    - debug UART
>>
>> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> [snip]
>> diff --git a/board/phytec/phycore_am62ax/phycore-am62ax.c b/board/phytec/phycore_am62ax/phycore-am62ax.c
>> new file mode 100644
>> index 00000000000..60752f431d1
>> --- /dev/null
>> +++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright (C) 2024 PHYTEC America LLC
>> + * Author: Garrett Giordano <ggiordano@phytec.com>
>> + */
>> +
>> +#include <asm/arch/hardware.h>
>> +#include <asm/io.h>
>> +#include <spl.h>
>> +#include <fdt_support.h>
>> +
>> +#include "../common/am6_som_detection.h"
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
> But you don't use gd in the code, so this can go away. With that
> removed:
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
Good catch, I will drop the declaration and pick up your Reviewed-by in v2.

Regards,

Garrett

