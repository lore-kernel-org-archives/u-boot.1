Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966E606A336
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jB0kE3gc;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=lt9rqypv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 099EA606F6;
	Fri, 13 Nov 2026 13:54:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9J4yPRrJrnWo; Fri, 13 Nov 2026 13:54:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4753760A52
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794578051;
	b=pH+YLMML/v1B+vvhqIGccSCiuabQUOswFVhWlhL3BRv4E+yJIC6oJSmNDzNOh7aESkiF
	 cGrSTCv8TDscQZvap311xBXM8pqnucfnx0h/UTp2rSzgim7jUkOEJW8FrbaZivuenQz4v
	 /VP5J0KvPpwFF7O74sa96FVsOjZpduBUvpgpUBv0biyORLeNUEbPjAnTKlWzOs2keds6Z
	 w6i7UL1EkBXILvlfhpjF2jGXAA9Ew6UOYoAptij8mebvPTa1wvk0f/5kn2n3AhVOKMkAK
	 97QxaPWdNz+33jbXlNaX/8aFgrRwJ/HJ8mPiZf44T9sJUGWGq1b75FbQayjCMYoz7hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794578051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=gLhrXmOx+Ia6LYpvIr+QMED/qzviHjVRUdmOnkrDdWE=;
	b=ewZqXmTqdl2tKmjHz0OxhgC29mDcmpfe5bryAjnaAcHahnF2Nvx8z1CtoIvAYd9fzfVm
	 uGd18S25qNLnZMAJZGlLmeH7yubUE9PsuEctVaiRCx8SSRX/RzB39FFGorUj3IuQ3zVGJ
	 bRf6tw2b52ydm6v8NHEMcHRc5VRiGfsxUc+Lbs9d1+l+iTcD7eIBNApuLRmPnedOU4MLC
	 7PBz3BHGzFm33cOFWtUVhr6h4kfOJy7xi0LzQW0o7zLYwA5WoOSp1DN9O+FdXGSj9tg7V
	 eC+UGH1FCNEXAu83r2HGBFSdR9nS4HigWFZsoyrb0JCoGYweivDJvK9BbK3uVzJHZJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=lt9rqypv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794578051;
	bh=gLhrXmOx+Ia6LYpvIr+QMED/qzviHjVRUdmOnkrDdWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jB0kE3gcSVoZ+di7TVF4lsvK6Ui73346iKc8WcNp5rCbLLMhE+h2X75fD8+bONWdS
	 2aVWxBnQznJwQCxRzRNCKfXCn5w4yxriyjrWMb+0/Lg06ADprBKJETR/tS/6QN9S/B
	 mMD/Vq1rDkLkULAVmsl1oqXhe+jeMdrLQvhBBMN+rmpzrL3cCbvJ7D6hI450o7tPuD
	 aLasInefOLmWzVz5x4UfGHiyA9zQfAVeAoeXl+NKYbsh+Y6t25oii0ktrL2sgP3t8e
	 L0bzztgJPSWM8NC46L7SQUKEUPoZBTmKHLqQM48VjQwA+up9yEaRavAWGC5aNUjZIG
	 DVZxWIFY0OF2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4753760A52;
	Fri, 13 Nov 2026 13:54:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66DCA2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CF9E60A52
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ys-q7eqK85R for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 13:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53C2D606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=lt9rqypv
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53C2D606F6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLhrXmOx+Ia6LYpvIr+QMED/qzviHjVRUdmOnkrDdWE=;
 b=lt9rqypvLIBbkeU9Of1TaVHWB+r21C71TZfU3M4Ttgq902nkaRggktEYv6gdyGSMngD8stXjPzcwmTif7SbTDNi6eUBEbYrU+YDc39LxPfZpn+RJIbgXT8XBekgNHmqs4VhEscG18hJj4ZxUojbZ0ve5hqeLTKV5t3nb3i+m9jg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 13:54:03 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:54:02 +0000
Message-ID: <f985dd35-4bd2-4858-a806-dc4d1e5723b0@cherry.de>
Date: Fri, 13 Nov 2026 14:54:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] clk: rockchip: rk3576: Remove unnecessary
 clk_set_defaults() call
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org
References: <20261027224742.2527550-1-jonas@kwiboo.se>
 <20261027224742.2527550-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261027224742.2527550-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fdb9c4-93f8-4b16-8852-08df418d92e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 5Cc48EyYybWyaFd5/nrgG85YP/duxW0ONLWNTBPtN3HyoLWtRLOiT+CRyAktkiOPgWFGNjsmsBGtJcFImzJTcx4EngzT5GtqiaBRHW7mCyFysU6V16YLQk3YWFdKBSRkkow6ozbUD5D94R0sjIwXA6if8uUhDdcQ/GuE/YVsd0zXdHFce6wjsgchJLZsDEyXWvTX1p8EftJB5E2qFzB6W7KqsRMLYI0L8nu5dcD4eNnAaCSUvDh1kd4IERMXAmOB+fCpvSn322WwQfo0jeWbX1er+EBwVKc0apEnIMcUoB86xiV/viWEvMqGYJhXZ4JRbpWBk9WyxE7MvSvnaVpXjGDvHIcq/+C8zlHJY3tc431uVFeBrDmqLGvv4+K/+q+GsbrTUePQTLAqjKoDyAQrqXtxKXrEhrq42fMmFutYhHOPJGbKgHdetJNIady5roeIkxiSy2l5F18HPCyNCtrrAE13pflVgrAVdWpXKLZ6DHdSSxw8Pt6dg4cQTgHAqXU3IxQxqD6Q6DxE46YITZWhmiAMqeuLnRQd6bBip5y+XOrYFYmwGeWyJMY90jv1pX96RifhP91PkrYbNj+KDDjw18ayut+dM9yxqKyp6K1nSGroEcHofDyryP4PmgmsUsrchQhmBIQV2V/fdNAI/Vg7l89kzgxe82Q5fza+iPFiar8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDVoZHZlcXpGYVZVcjF4a0RINmwvUmh6U3hwZnlaaktZTnRxQ0lIVXdCdXVa?=
 =?utf-8?B?Zjc0K1RCdFFtUTZjLzlxQ2FQSGFHZGZQK0ZrKy9Td3VldjFNVEhyeEJRRUVB?=
 =?utf-8?B?eVhvZzR2bXFReks4VlJBOFJGbS9POU9WTjNPa2dZU2Qya3d2VnU2bEFjS28v?=
 =?utf-8?B?RXFVNlYyR0dTMWl5a3NNOW9DT0pBdSs0T0ZOTzFEbEh0RTVTV0dZV0ZOYUFk?=
 =?utf-8?B?UERxTXRjM2tLMkRIWDZOQ1ErZ0ovcFRIaHpPNEZXRi9XOTg5eHZSeHFFWWtC?=
 =?utf-8?B?KzZFOEVPWTNsTG1VWTB4UWNFNnM3TDJoOTlvS3dKd0NOTFpyZUNIMlNId0xD?=
 =?utf-8?B?ejQ4aEhXYmw5cjdnYTI1RnFyTGN0ZEg2NTYvOGYwbWJHWXNjY1NpWkp3T0Iy?=
 =?utf-8?B?bUwyckZ6K0VpSFdPRlJ0YjRCS3RMUTV4RGpzblljaUk2eDNydDVleUlrcjRY?=
 =?utf-8?B?Q3pQbEFMWXZEZXR4SythYStGQ0NMTnllSXJObEMzRFFGLzYydytxQUxkZ2Z5?=
 =?utf-8?B?Qk9QMzlsenIwUE1CRGFtbXAxS29YVk44S0FrUytPbTRJMkZSZUpxYUlseTg3?=
 =?utf-8?B?eUszd3E0cUNNanBvNVhPWEFYOVJsd0MybHJOb083WTZsZ0laNWNBRkhmZ01a?=
 =?utf-8?B?KzBXUHBNeXM0ZVFHb1BmZE13aXdWcVFFWDdKK3VLS0dPNlJkUkZPMXJpUTZl?=
 =?utf-8?B?V21Ic3FvSlZTWHVxNkowMHR0ZEJFR1ZoQ243ODhuNDBrL2FIZDUwdWw1dUxj?=
 =?utf-8?B?Z2pXOFpJSW1oWDJCc1VoL09XbjkvYnlyMVo5cFc2QjlBZzdZbTJqUUo3Y1Na?=
 =?utf-8?B?REdPWXBqM09OOUxPVnBUL3NFRDdQTit4eHJNdFBSSUlNQkpYMmdEVkZleU1y?=
 =?utf-8?B?c3hCTWpXSVBMb3BZbGU4eDNLa21rR2Y3RGo4eGZmcG1mS2RnOU9OREdsVVhm?=
 =?utf-8?B?MEdJUGFQVitTTWkwVDEyQnJOTW5hTXVqMDBRT25wbnFvbkJKczluRDdOZ3Ex?=
 =?utf-8?B?b2F0Q2NEMkhBWFlSTFBSN2JldE9zdDJTZ2FZeERVcWViMkVBK0I1c1JtWDdO?=
 =?utf-8?B?djhDUEwycE9hWUpPZkRveDNjWDdRNDZQOUF5N0NGNkpMdnJLdFdZSzgrSTk5?=
 =?utf-8?B?dVNnNnlVd20zamNOWXhyQVNLR0JYbTZCL2grd2NBZXBRTVRCaW5Jb05vZjRS?=
 =?utf-8?B?ckVQRjBIUjNwR29RS2Ntb1huLzFZYzV1bU5GZ1FMV3NLNTlJL3k2clJHUk42?=
 =?utf-8?B?K0w5NEVSMkk1OWxXejdTSFM3eWFzODhLaDhsN1JJMDRmREhSWDRWc0xTNkJs?=
 =?utf-8?B?d2VWTGdJYVlQaWFtVVc1emFCbENkMWVyclFERjROK0dUQXRqVFRueWZ0d09v?=
 =?utf-8?B?MTNmVER3QlRVMEx2NEhOU1hFRmlhZVFBYzVYQm9CMVlaZWh5dG91bGtpSDRy?=
 =?utf-8?B?TWdDdXpYajFNSFV3elB2Y2hWZDhabmdwc1lIVWRBMWlCbGZESnFtNUxYWUVr?=
 =?utf-8?B?T2hWYk96NCtEQTRPODdtOXBaTEE2Y0F3OURJQmlsM3hHekhnWGxldTR6RVNL?=
 =?utf-8?B?REZuNmNzT0h0Rk80YUNuVzA3Q2JTZ1ozeWpkYTU3ZkVsd3NiZGV2YjgrNThO?=
 =?utf-8?B?NWY2ajFONmU4SXlISHR0RjFKU0s2a1NqbVJHUWtMQ2ZGdVl5emNWSDdwbFlH?=
 =?utf-8?B?T0NvcjRISVlWUWcxdzlobTdTTnc2RWN5dW54WGZBT2liODQxWmtCOWplUFly?=
 =?utf-8?B?WXNSWXphd1A3YTFaLytjMzliZFF3TS9DYkNRSHN4VU50WVFpcGswNktNMVpR?=
 =?utf-8?B?Um9PNElqa3ROWEwyQXJlVVRpVzZZQnhmUHJoOHcyU1ovRWlJQ010N0RtQkhO?=
 =?utf-8?B?MTloR2t3VURYOGdIOUlQTjlJcW01K3htSGRDNGxLQXpGS0lZS3JkazVFVzdi?=
 =?utf-8?B?R3NjRnlhN3p4V0RqdzVKMWJtWUROMTc1MGdIZTI4Z0grTlk3SDR1ajNyVEFw?=
 =?utf-8?B?QXFjS2RsY281WGoyQjNPQ0JJQnN2N2tZVVJyMmtQWm5weDFRMDNQUTNIZ0l0?=
 =?utf-8?B?VlRFUWVQNndkQjRKQVpTa2hjcWNzYXkxd0pjclIwdDR5YXNUdXNlZUN3QUtz?=
 =?utf-8?B?OHBmRmd3SjZweXFmQ2tocndoMmZhbUdhSEgrdjNMQzdtR2dFSmZtbzVpWlN2?=
 =?utf-8?B?R1VIaGp3L21ObGdvd2ZXZjZYT3VvYzl5dXhXK0V3TDZvNWtFU1NDakx4V2tK?=
 =?utf-8?B?RTFjY2lBQTVXMDFqQzlmbU56KzVSTnEyaDRvbXNucnREY0NNWWxWVytRdWEr?=
 =?utf-8?B?cnR3NURMcG9Xb0IzeWdMMFpVWEdQUzc1RWVZTE1MNlZEWk9RMWtqUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fdb9c4-93f8-4b16-8852-08df418d92e0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:54:02.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nla6ZpxFJr6MZ91p8lIwkDpSY+3QaOEeYbRmOn4ZxL3+pQSQj7ge1jShV09S7JsBuON2LQ5hV22L5H7r7BgSbIKB96YrYcFlqoRQRAvXuMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/27/26 11:47 PM, Jonas Karlman wrote:
> Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
> node of the clock it sets up"), first included in v2020.01-rc2, added
> a clock-uclass post_probe() hook that applies clock controllers own
> assigned clocks.
> 
> Remove the redundant clk_set_defaults() call from the RK3576 clock
> driver probe() ops. Also remove the unused sync_kernel field that only
> recorded whether assigned clocks had been applied.
> 

One assignment of ret also got removed, but since it was not actually 
used for anything, it's fine. Would have preferred a separate commit or 
at least a mention in the commit log, but this'll do, no need for a v3 
for that.

Thanks!
Quentin
