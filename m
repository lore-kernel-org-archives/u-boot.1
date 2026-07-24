Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D81C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 16:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52C4A4082B;
	Fri, 24 Jul 2026 16:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdmiQd9nc6rK; Fri, 24 Jul 2026 16:58:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48B0040846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784912323;
	bh=H1z2bM6F6h07voYVN91Yn77QrD+2fydW+UZ8JEPCqNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZD/OdBYcroszgXxwefaJRwH8ECrpxIH1Ukhk3/SAVEI6CTYfF2PC0JI9rhz3gvE91
	 i77b0w6QeM50gpFUsq1gksQmrnD5fQgPY2NikPKiRiIJsbMhFQoK9V9pGTwQDfTDXG
	 f4jxG1jUfbMTkfPDDgPz0wJoV1ZHuActpS9XYiod9zK+Vbjhunf4EUapmdHdx+qnF1
	 cli3ZOEWvnHppJZPFstpi3rNipPhq0gmN4wFGSfS2MTb587qJoNVyayqSs1a0+WRc9
	 RQrcWfHNFAD8wN/KyvRHmu9y1Op8xaWSbsYM5Rej4CfRXWzwpqlvalHrCRWikroeWw
	 7K1VcllIt5U4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48B0040846;
	Fri, 24 Jul 2026 16:58:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC849224
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 16:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2416400BD
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 16:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMVfUahHLU_A for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 16:58:40 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6095240083
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6095240083
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6095240083
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 16:58:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4611E846A4; Fri, 24 Jul 2026 18:58:37 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE088800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 18:58:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vn4OZDte5otcAuq43bL5ZJTsEwXGtE1wx79p+N3ytxc43ZWys02q1pjXY0QJ5N8QipBqxg2C1Mf/Y5bIGKMQX1p0YGm35auUeJawbsfuhDxzfFNXJdPFUactCjo6rmYi5LChhrmtnrUFDwPww2iakBhSRJ+NYsn9lOTvB9ASLX25IBzY93Hb0KAt+l7DJn/GTg52StE3yN4fZ8xPwMSC2M8w6ncb7yV/cWjl3biPQIZAykOK9PtEWDq0aRvZ/AVJkGzxBlpUxxnJwnVUbfT9vsdNNTlPLtCZ9t8v2pA9f2tPGwDtx1ysICIoNI16DNOUgiZYBdNf5BkBWh7MlxCzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1z2bM6F6h07voYVN91Yn77QrD+2fydW+UZ8JEPCqNk=;
 b=LHTXqeirIY2ZPQKo0YnGl3+Q/wOspyNah1lrHwnmys1cAS01rl6PtreAPtS0TXjt4XuEZd5V7CBh27j1enJC+qZF27ebFE8UOPWZA3MwwXVjlMjzyUmnvA7F9hkVGMVbISHGpA/XuXTtDgFihSOv51cIqJs9Zmr3DT+13045cOlLK1CqWFYrJ/5OiCFRw7qhXueNgNnzPvJTrO74RppoWyCClRC39PqnboIrTbjX5qK1kyGB8ZIlzP0ZuuOzz+KCUdXvrUR4VRt/Bt1f0ksCZT0O7fkF0lVkYLhxUnvkDI3SU2aAMLlrCuHZ8Ag9kpwX8CKwWwrj2zTfaGfup7q3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB11037.eurprd04.prod.outlook.com (2603:10a6:150:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 16:58:29 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 16:58:29 +0000
Message-ID: <2062cf5c-31da-4ccc-8ef6-3dadc5a799a4@cherry.de>
Date: Fri, 24 Jul 2026 18:58:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
To: Wade Sparks <wsparks@vulncheck.com>, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: Disclosures <disclosure@vulncheck.com>
References: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:802:1::40) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB11037:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc9bc94-70ca-4033-31c0-08dee9a4c8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4133799003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WAkvVcYUuTqnT6E6dS8zFmLq07q3xG6K5Wp1mt4VT4ZqRUKtlgQ8C6WZsMylx/TVMgAVr2xkxRJno2RfsZIWkI5ZTNw8sod69cxF/lNCOO4AHT5U4cmfYrIZa4lnu86b95ELZqhBhwfGxkE5P91rv8d+nvE6roSnfF9Zr14xovQQQ2NiOhyGI/wjEsNzWHaYxqIrJm1wcdVeadvM33Xq8cAj6nhO5mU9UFOZnEwQtKHtyxYcysX4Nu70l2d5gjROaRKm7/oxlKXmJZg66KPuKcKzePZPTpQ5WtpW8kOiNXaDCAqV51BxrMArgFRKu1KzUR+EINYO1BQwVL9geF9QbAv10r6gJBThTWyQl92NJ1/ifimsB12vf+NfLN1Sbuu6WZegqgHr5dVDIr3iEyP3zs5OqnhplyCXx1Nqkw5NquzQw6hjm05eIDt9aruXU88nRyI2gfVjxLxQ4T1TyR27ew5y7cO+0eLIymrCDg+Rocy5X8ovpEikcdJ3OluPPWJVTztnmSB177l5IokgYuPvVJMDn7ThYGG62hvrtj8RAc9/8E7Rz5kKLxxFv7qId7vPyzEY9iy/sA6Al8xg72ezE3J2Owym0H+Q7O5UY9446jI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4133799003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtZNzg3MVNoS2lRbmZZd0tVSTFlSWFjeGt4RWduNU9QV0xrdXhqN0tETTJj?=
 =?utf-8?B?MnZJeG5sTWhhU04vNXg3eTkvL3N3YWNjNjdxQjVoc1dtL21NeTlGenY1dHd1?=
 =?utf-8?B?Z01ETFk1SHA5RUdrNEZsbGVhOUJnMU1OSUVYRTkzTWdVRHVQZlpFMDl1em4r?=
 =?utf-8?B?TmFxdGwwcVFvT1QxaVp5UGo0OENqSU9MTk5MUmpMK3dqVHhETk5wRUhYSVkx?=
 =?utf-8?B?Y1pibjEycXFkRXk4ZlJ3THNiZ3BUNnBYeDF6eWxHQmtXL1d4cDkyVlpGMm5t?=
 =?utf-8?B?NDVFL1JTUXp2andjUkZIMDU3M25nU2lDYUJjUUd3dHNJVUlaU003R1pNV011?=
 =?utf-8?B?MkN2clo2Z3pNTWRIOVhBb0JJbnllYXNwL2pZcGRaQm1XUERyZDg5YWFIS2ZX?=
 =?utf-8?B?anZWL1VNM0ttY3E1VU80cHZNNlFGS3VhWjNoNHZtK3VXN2xjbEEwTXUxdUJo?=
 =?utf-8?B?dWxhVm1XeDhpUmhGZzcxK2UzcEJxZHlWNytmc2RpeDhtOVR1QTVCNUtlZUt3?=
 =?utf-8?B?eTc3Y2xMRnJXYlNwcXhKU29TWHhQZ0liemFFWkw0dlZVRGdPOGhiRFh6YW1q?=
 =?utf-8?B?ajk1aXBqQ1BUZEJkQW1CeHE1d25iMGZaVndXSUNJTUNVLzRPOHdQb0FCUmt4?=
 =?utf-8?B?VzRwRUY2SmdmUWhSSFh4cDZ2Rmk0SGsrNVA3QlVuR2VlTDZBOTVkSlR3anVj?=
 =?utf-8?B?ZXBQb0JDYms5NXBubU1nK0wyOEpVZFpOSkh6MFV1bktQS2RrTURaenhVRDg5?=
 =?utf-8?B?bE9hVUMvYVFlU0JycUtNb0NhT0tod2FOWGliWS9udWV2d3orTytnbHVrakgz?=
 =?utf-8?B?bGlHT1JPNys1cXlCZVIrY3RtVmRjOU9OTm5XS3BpTmFvM3dwNS9qbUpCZm9h?=
 =?utf-8?B?Q0syaTdOd1JDdWhxUERkV2ZvNFlLUVgwQzZaODIvNUc1OVdjMFU2Z2M3REoy?=
 =?utf-8?B?aUdiQWNJbkxIZmIvVEZvRzVrMnF6bkFOTlZTaFhjb3hsUGRLWnlXUHJsL3Mz?=
 =?utf-8?B?ejdlTHdSQ1IrZmFXb2ROWUR6RXlQQTh6elpIWFo0eFgvNHVZNFlwMVVVOENK?=
 =?utf-8?B?OXVNWUF6VkNndUloTHVDWEYrYU55djdZWW9ISGptM2xqWStSSUU4cHcycitX?=
 =?utf-8?B?VUQ1bktLUzlhcDIwSHFxT0tPVjk5Mi9tRUZJb0RNcUNqRzcrbHoxT1BiYm9z?=
 =?utf-8?B?bFB6MkVjQU8zdEVLaCtZR2lIMlZoYXVaa2E0aVBPdFNSQSt0ZFM2R1Y1bi9u?=
 =?utf-8?B?eXFDMWFEMjlNWmxCelcrRC95L1pjUXpkZEljR3ptRzJpa2lBWHgycmF5MXRa?=
 =?utf-8?B?VXBKZnlBeTRIWDMxMUkzaHV1V1c0T2ttdmlIUDhCdXR2b2srSmsrZlo3djZV?=
 =?utf-8?B?NEpYcEIrdHp0SU5COFY4R1ZnWlc0UU5wLzk3SmJndnBteHNqbWprcUE0ZC9s?=
 =?utf-8?B?d05vdGU0cjgrTWlCSU5QanhrTFU0M2FGRS9DSDIvbmF2aFFBaWpZc040c1lr?=
 =?utf-8?B?dUVkbVRRbFp0SlBmYVZsSVppL2JtSzlhcG5rb1hqOXFnYUpmQk9BOG9HenFH?=
 =?utf-8?B?STFGdzZBbEVUVUw2aEh1VGRBVWJWemF0NW15RUNmZ0R6VlE0M013eWpVbFhw?=
 =?utf-8?B?bDFBQUFWRWFhcCtoRTZFVzRyUmJhSU1HWmF5bVc4cGNNNzdYa0o3SFBxajJm?=
 =?utf-8?B?YXh2K0plNWY1UFJSSnlCZjVrZHljVU1RNDQzZVUzWW9HYTgzRUNEWUZQaEdv?=
 =?utf-8?B?aW4zV2k2UExZNzFPdDVoVU9ZYVNoTjg2VU8yK2VFanhvN01OYXJIbUFUaW1m?=
 =?utf-8?B?WU9jS1FDbXdvUGlveGZOczJlaDlhK3lHQkRxeTBId2JVTTJvK0xiektUSTlu?=
 =?utf-8?B?ZGlCL0ZXS1R1d3NzNHNHREtWbzYzNTNYRTl0eVdqOWNMcCtpei9NcHd1MW10?=
 =?utf-8?B?Qmx3Y29qWm9tblpvY1BkVk9PNGRZY0VuS3g1R2ZCdnFuV0lZTXBLaGhqcUVn?=
 =?utf-8?B?dStXc1JKNGw4NHJVc1BUVmRPeUcvdWxzQkx6Z0s3V3JHQklITTBZVTBWdHpq?=
 =?utf-8?B?aEQ4QTJhQlN4N2Raek9GNHh6YUtYcUJlYi9lU0VHVTNkR2NPdjU4RGZMZzNM?=
 =?utf-8?B?dUMxKzBWMnBFNXl2Smk0NkN1RHh5SE1HWCs3WHBLTWIxWVk2aERVVjRXY1Rp?=
 =?utf-8?B?R01vbDJVdENpb2tSRDZOMzlpRFdkZEtrVDFnZ2VYM2xwUWkraTdUcWtabk1o?=
 =?utf-8?B?NTRpU1J2UzlhYU82RXErL2p1TWUzd3MxY1EzQlJwb2tTSWZvK0d0T29uNkJ3?=
 =?utf-8?B?cytiOTgvUDY3d25BSm5CQ05ZU1Y5MFRvZVVJQmsyVzVqN29hZWc3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc9bc94-70ca-4033-31c0-08dee9a4c8e9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:58:29.0661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ez2jWn9pup1Vc0w0aXgwUD2j0JOt61LtHLZhOj247QJP/ptqqO0+ZXzM+pu8hGIgtviMSL35hNlZCmutfx/jIUNRAAjBDXZDpqsonvUfX5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11037
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1z2bM6F6h07voYVN91Yn77QrD+2fydW+UZ8JEPCqNk=;
 b=Wy8UnJHdE3u3RqQBmlT0oXznFoGE5ngoLKHqZY9mLuuHH7QplhHOe3a/f502P09BSJYnGvYdM9sH2bq7ibKyrU/ycKL5wKSysnOJNhXW3CL80AcIXqcyqFuBIvpLpCNCXrIjQ7umboJMITk9XFXA5jH+IC0vrrWr3Y9CLfRItf8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Wy8UnJHd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Wy8UnJHd"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 5/8/26 7:20 PM, Wade Sparks wrote:
> [You don't often get email from wsparks@vulncheck.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello U-Boot mailing list,
> 
> I’m a vulnerability analyst at VulnCheck <https://www.vulncheck.com/>, an
> exploit intelligence company and research CVE Numbering Authority (CNA),
> where I'm one of several folks who manage our coordinated vulnerability
> disclosure (CVD) program.
> 
> An external security researcher recently reported several vulnerabilities
> <https://www.vulncheck.com/advisories/report> impacting the U-Boot
> codebase (discovered against release v2026.04-rc3), and VulnCheck is acting
> as the intermediary and coordinator.
> 
> VulnCheck follows a 120-day disclosure policy
> <https://www.vulncheck.com/vulnerability-disclosure-policy>, meaning we
> afford vendors/maintainers up to 120 days from the time of receiving the
> report to address the issues before publication of CVE records and
> third-party advisories. For these vulnerabilities, that 120-day deadline
> falls on *September 5, 2026*.
> 
> We have provisionally allocated the following CVE IDs, which have been
> shared with the researcher but will remain private until public disclosure:
> 
>     - *CVE-2026-29007* - Out-of-Bounds Read in TCP Options Parser
>     - *CVE-2026-29008* - Integer Underflow in TCP Payload Length

Unlike claimed by your own advisories (U-Boot <= 2026.04-rc3), these 
aren't fixed yet. You've also linked the wrong articles from your own 
website two of the three CVEs you created as a CNA (as can be seen on 
NVD website).

There also are patches suggested for the two CVEs listed above in the 
"external security researcher" report. It'd be reeeeeaaaaal nice if, 
when reporting vulnerabilities and patches are available, someone 
actually posts them to the mailing list. If none are available, please 
try to motivate reporters to engage with the community and propose a fix.

>     - *CVE-2026-29009* - Buffer Overflow via NFS Symlink Chain

I believe this is fixed in commit d6694018eadd ("net: nfs: fix buffer 
overflow in nfs_readlink_reply()"), available since v2026.07-rc2. Your 
advisory and CVE also are incorrectly generated.

You have received a separate mail at support@vulncheck.com with all this 
info.

Quentin
