Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8696CC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E8783677;
	Thu, 24 Jul 2025 10:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JWjXbJ+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F41E83678; Thu, 24 Jul 2025 10:48:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DBD83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN7BbRcm5NLO/ydvR/03svTlVqp+TcUZv0MXyevDw3XdHFQdiZ0gt8mdujwuKyTmcslG6zvtSuhjHmd3vj20WGTEBpxZfM8BOHwzT+nUA6ut3uDRrs8cnP4yt63pf6VjSBEK4cz8Ds6hrgxzU1y/4Yea/wre+gAJUskNKtKQsLlX/bFsJU9UA/gkJir9BjPMsRXX7so8rWYRAzj2ajLd7KIm/DGqtE4xTT0MshNZs+xgFfSudguHG2RkkMjwuklB21GpV2rTHi/XzEQdo4OobXhFFIoYvlpcLbifEOYDAdjxwZh+q0ycHxeTMRoCAEDUdqaEQgzabIz2el3cffzo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLx1STnXra//af2nb6ii4fqLkugSyWw9yCcY4qFwkMw=;
 b=gSxTWhkgk0DtNtHTxbexvy8gz/5+RqCa5zK+8k1BgVocNdYpvyxBxd2AhxPOrMXEJp0ZTR+G8seSH/g+DkppWwkMtYrr456lMYTuk3CeoEWQ83yW8hIc4Qg2zluPu7Ae6FS6TkIYeIXK4K2LC98Rsg/FHYYraBkYjJXzOh78rqi19IDhHaVt+/XDJqUPoIKneJcV4rgCef3+a41uG6zSh235f9OJjGCMBB59so1l1+A/qRUOmttXuTY+k6/FGNNWzsgDtMUt3u4mYeczTzMXluNcMF3fUiXjbsNdD/lDQ4DfBRzKmOysnkt1nkT8QiVpZrh0G+OwgpuzRfQyQVZJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLx1STnXra//af2nb6ii4fqLkugSyWw9yCcY4qFwkMw=;
 b=JWjXbJ+N3NvZy/pM1jjP7rhfpwTqQmkUXH+d+JbesNgUm5i2JF9OquqglACBZtFH0PqVNdaEdv48Ber1gBFYVuGtMj72nCdLOVwxFhPFbbp4mLWX9NaoLl7LRb3IUA0Q4Zn21zzVhaszxxXVRvi0KkLvRslpHaBT8BlRMqRZ5GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 08:48:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 08:48:47 +0000
Message-ID: <30423767-dfdb-48ea-b708-e6a21c75cbcf@cherry.de>
Date: Thu, 24 Jul 2025 10:48:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] binman: bintool: run 'apt update -y' on first
 invocation of apt_install()
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250724083433.57867-1-jerome.forissier@linaro.org>
 <20250724083433.57867-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250724083433.57867-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 744b204a-8a1f-481a-f913-08ddca8ee77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTRFK0thK2o0emluSVFVY0IweDQxT1dKM1pCeHR1UWtlaFp5b2RsWlVNSGhN?=
 =?utf-8?B?bU13Y0JYOHBBSTZIbWJLdFRMNmRZL3BhTnRaVkozWHZ1a3pTZG5Feko2Ti9R?=
 =?utf-8?B?T2VTMlExNjBDb1pvb2IxUUd5V0pPQ1FFUk9aOUdXOVJSa0YxS3NlNlVoZFho?=
 =?utf-8?B?RDJFL2ZJK2xkQVBUaDNRSXRPNGVIVmlBK0lvTXN2aVdSZ1hlMzZzaHlldFpy?=
 =?utf-8?B?QVNLK1JWckthZHoxNDZBUFNqQUhFNXpWRTdLdjhvN25QT2t4UG10YUdxek04?=
 =?utf-8?B?QU8xMWQ5RXI0clA2OUkvME45TmlXQUhkZTZxSUs4RkNmdmZrZkxRNms0aXg5?=
 =?utf-8?B?WmxiaUFmaWE5OENvSURFSmJaSXhrR2JuSkN2WjJUUm1jZjQ3QWJIM0M5UnJ4?=
 =?utf-8?B?UVZMUFRPNUpieDk5dmkzZjg0ZzBsUlZCSnppYXdBY1JFYzhvZC9PTjlvSEM0?=
 =?utf-8?B?bVhHREhNSVdlRWVmWmswUEtOaWJZQVZGV0IwMHh4b0FybDVGMVhOWFIyeS80?=
 =?utf-8?B?ejRodm80clo4VHBaMTdGRE9ZSDFWNjhjMTFGUHJCSnpPSkw5eWJLQk44TG1j?=
 =?utf-8?B?eHZVQ0JjQm1RMmpwMUxILzVSK0lRc2JGZHhvazZsbEhNQ283VlJGNHJNYkNm?=
 =?utf-8?B?SElEbnFHUmF4dkhpUDJYTWpSVUpPWC9XRnZXa0lwRDJqc1dtd1oxLzFRTTlj?=
 =?utf-8?B?Y1pqQlJKODdLSDBXelVCNVpEa2cxcldkMHg2M0QxM2FWYWxBaFVReXFUUU1J?=
 =?utf-8?B?QkVkZTcyWjh6Z2tIbTRNaWJIOFpqN1BHMXU2eVpTcUsrbit0UDlxVDVjMTF1?=
 =?utf-8?B?eTZVa2V4ZS93bUJqSUFacmUwNjBrNmdJci85ZVdvOERGSkI0QmhmWGpkR2pC?=
 =?utf-8?B?bTVUZVY4cjExWU8ycFRKd2ZyWmhic3c1TFFNVnMzL1Q0cGhtOUJPenVmejJs?=
 =?utf-8?B?V05WTlNCak9GWjJja0M0Zy9KWmRYYjB2allhMEIwR2gvVmpNVHJ1dHloTUI2?=
 =?utf-8?B?OGtCVzdPTGFGbllUK3NnSGlHLzF0alA5OG1uemttak5FQy9zQTdNVm9yWUgy?=
 =?utf-8?B?Y3VLUjRTQTJ3NldCU3ZPOGwxZDRCeGNmdEpyS1Q2Yy9ZVjlzYUtrZ2pBRGU2?=
 =?utf-8?B?azVGTVd6bXVWcjFlZGdyMkRjMExkOVRQQUNwK212L2hyd0NHN0YvN0VQYmdY?=
 =?utf-8?B?aTNOeVhIMkhXUUZuTkM3ZUFzVnJyeVFxU3VWUmNJdzh6TXNHWVJCb2o1MFE4?=
 =?utf-8?B?aTFyMFlKMEdLWHUyNWpsQ3Q1Y1BMS0xnYiszU29GdGlPNlJ5SndZU3ExTHcw?=
 =?utf-8?B?YitQbGlYclRHRkczbmdzM3lQV1Ntd2dmTnRLYjZocUtUSWVsMTlVWDFqWko2?=
 =?utf-8?B?cEZURzJQZk5UZEx0bmRhRCttV1UvOUxFTjZhMU8vN1NwczVNWjZFaWdOcVNh?=
 =?utf-8?B?dFYzKzNrUm1XaVFzdjk4MXNpUXdUZSs5UUFKN1lRK1VKMzlaOHdTMERlcXd0?=
 =?utf-8?B?WTNEc1pha1BkOWJJUi83OFI5SzVlalB4dXkzek5XNlZPSC9udG9EcytYbmZz?=
 =?utf-8?B?NEhiUE5BNW1DVWpOSTVXOE56L0hBMjZ1ZFdCc1lvWitjNVZHU2FOdURVbDZR?=
 =?utf-8?B?Uk1IWDRBQzlRL1BMOVRINTFFL3BXck9oTFJ6dmR4WFdpZ1phNGdYNmR6NUlN?=
 =?utf-8?B?elNHT3QyUGlTMDBobEJicmZzT0lXZ0FPUEkxZkI5UHJma2YyeUNYNEZOeWVk?=
 =?utf-8?B?ZTUxc0FUYTQ5SmYvWW41VTlXR1ZhZ1EzVW5rT2x1Nm1Kb3FaSDlEcXJxcDdl?=
 =?utf-8?B?ZmFHQXJLbUhmSDlSVGE5U1RISWRuVmpaS0RYR3JSVTE3RVNNWlNxN0RvenpN?=
 =?utf-8?B?TS9uRjY4ZW9ySDY2UThUYzE0OWNhbUhPRVNRZ1ROb2xoaWRMSEhDaDJlMFVn?=
 =?utf-8?Q?VGADv0jxb/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVwemYzeDQ4RkhOS3pxOHFHVHlVaktkcjREeEtqZjkyUDN3NFZnZWlVU3lh?=
 =?utf-8?B?RGN4MHVjMGZORUhjelM2LzFMMWJsQnk4T3pJbTd1NlZMVVdxK1Mva1VIRFlv?=
 =?utf-8?B?aE1GRUVBOWJ4aU9LTVZDcGpoaFFCMk92MEl4aDVIaWtpK1hCR2xPQU5rSy9T?=
 =?utf-8?B?N2wyZ3BueTFwZ2hzSHFYYWk5eTZ3Tmk4S1Y3RUI3ZHFLV0Y0STVCWGFzUEJL?=
 =?utf-8?B?ZVNkamRrWW5iaEI0YlJ2MUhvWE9ZTVpnREQ4UmJMZlVXUWpyblAxTVFSU2ps?=
 =?utf-8?B?SzBuTE93V0ZhS3kxNUVESk9XRWFjN0J6S3U4QVBCMmx0WDVPTUJiUkNiaFl6?=
 =?utf-8?B?ZkNCK3BueHJRdHVOOVVLVW5SSk9WVkg4ekJCVHFHQ2cvYzcrRXRpcGY1Y2JB?=
 =?utf-8?B?N2pQdWV4c0xOMTBmM0o5SXc5R1IvRmIzMURuT1JTSUhoY284VkYxVE8vYThH?=
 =?utf-8?B?blIxN1Q5ZEFSQXVSYnpDZDZPSGNLSk5VbU1ZdVMvSmVTbDRwdlVDamNaWW8w?=
 =?utf-8?B?RUY1dmtYakh0c29YaW1XK29tSzd4MFVLbEduUkxLekRDVkZQQ3V5aHdUcEx1?=
 =?utf-8?B?cVpZcmFLcE9NTk5kZ2tpakJ0UE5qK0pDemZWbk5UdXAyMFRleDdMTnFHeGE0?=
 =?utf-8?B?a3NzTGtJN0dhT2pRYXNURlUrQzZGL2N4TDYxOUhabWEwTW1QZTM0STdBaDIr?=
 =?utf-8?B?U2lTNmtxVm85TU5XcXhyUWI2MDkzYUYxZGNGSytQT3lVdG9mZE5DQVJKM0Fp?=
 =?utf-8?B?Snl4QlBwTFViNHpieTQ4VXp3TjREQVpCRk9aUHdpc2paWG1Wa1dGTVJ5OVpC?=
 =?utf-8?B?SHhiRFozZk1BQXA4MXRMenhlVFc2Qk81KzhmWEk1SGRsVU5DeXNxL0M5R1ZT?=
 =?utf-8?B?eFQ4UkpKUmV3ODFKbUFMOHlITVdBN3QxNUt5NkJSeGJJc0p1Kys2S2lsQ2U1?=
 =?utf-8?B?ZnArVWhKV0daV2FyN3NNNi9XL2tKQlNQQzRuanVDWldqaHVzZnYzMHJtMWtt?=
 =?utf-8?B?cHZIbHlQTUVySEF2ZmJhTmkvS0lKZ0JKYU5WbXN1eGJzWnk0OHNMUVZSK1Fu?=
 =?utf-8?B?cUl0bTJuSVNiWU5JM01pdFp3TEVLaDl5ZXQwcEtmNUU2YVdsZmdJWkkvQk1z?=
 =?utf-8?B?aWJBdFV0TERNSjZ2N09DaVFnM0JhS3Y1N1dZa1QrNGFaN2trL0FxNmNpTXZC?=
 =?utf-8?B?ZCtXMjB6eVd6bTV5NHN0VTNnTlNtLzFoWFZicDZqTWE3bFJsZ0NTODd1MkZR?=
 =?utf-8?B?eHZvaysrZjBkVTllS2tIZVM0Ui9TRUh3WWUyMnV4TjRDbGxvdCs0RmNZMklt?=
 =?utf-8?B?RWhxSHRYaTFlSWVza1F5UEQ2elNnUUdlWk12NExJYURPcHpBcWFnbi9oQWtX?=
 =?utf-8?B?WkU0dGV2emdGNk56UW03S21LaEgzRWs4dThkVXh0TlVBbDk1RDhWVkxVWG1j?=
 =?utf-8?B?R3BlL2FhSCtzaWdCYlhoRThDNzk2MTR5K1Y4ZktjU3BWWVlRc2h2Si90Z3cy?=
 =?utf-8?B?UElDUytaNDhDY2J0TWFCVnZjSitTQnRXc25ObWVFSUdFMDdZT08wYkxYVHhD?=
 =?utf-8?B?Vk1ZcnJKMEFWTlVaMnFGeExCQ01yT1BzOTM4b0lxSWlMalRmbUJsYjJsV0x0?=
 =?utf-8?B?M0dTSHNoUWVMTDJiWENhMWZIbkMvYUZOVkdUa2tQL0U2VjNETkJlNnpHVy9a?=
 =?utf-8?B?SVI0S0hlc2JwUHdCMjdxenZMQW9EeFNsZjRLN0ZSUlV3eEh3ME43TkFuN1lx?=
 =?utf-8?B?eHlwYkQ4MGdqM04zd01ZLzNuZnU2dFVBVzFNM1UwV2NvN0psd0hlang0NXFM?=
 =?utf-8?B?WjNicDZJSUFkRzNKNDhhR3VNcW1yY00xMkRFcHV0WUR2RnBlTXN0dmtablNw?=
 =?utf-8?B?NXdpVDdlcHVvSUJ6bHc0RENyVGlldWRTNGNnbVlaTWFoeE16WEllaWE3aEJj?=
 =?utf-8?B?T25mRFgzNTBGa1psU24vcUw3eWRnck00c3BzTWsxVkdiSkJyQWw1RUJ4cmhj?=
 =?utf-8?B?RGtYMmUyQWx1Uys2NXVWMG5hQzNzeWw4Yy80SmZkM01yVnZWNVp2UUdYNUNj?=
 =?utf-8?B?dkNhSi9TWElLOUR3SkhQUzdmL3Z2MzBRM21NNVZlNWk3NjJqSHRtRUlJWSta?=
 =?utf-8?B?MXRmZURRdFp5YzVlK2Q1eU80dFdOei9nV1diS08zQUR5WEFZQ2VpTnF5S3RS?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b204a-8a1f-481a-f913-08ddca8ee77d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:48:47.7042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMvxuptoKklR59mZuimhWeho0AhgYg8LSHhwWiPuqq8iyHmsCwjc5MmzmzsBZ8F9xqwKNLIKKfxEALr4QMRC1Gv/EXZqlA7V5E9/FOyVONg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
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

Hi Jerome,

On 7/24/25 10:34 AM, Jerome Forissier wrote:
> 'apt update -y' may be required to make sure that the list of packages

The previous patch in this series is swapping apt with apt-get and now 
we add apt back, can't we use apt-get update here as well?

Cheers,
Quentin
