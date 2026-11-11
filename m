Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3E606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NqQRI8Jn;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=gKkLXSoo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9877860D4E;
	Wed, 11 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71cFz6Y458qk; Wed, 11 Nov 2026 13:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE77C60B5C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402856;
	b=H8zlGnhpMubTNP0gD2Rn0pFfAS7u5N3TChbkXkFLBY2OoE+0oX6Yu2YDE1THc5uBIGlp
	 G5jz1tw7pU1gxA79uIMOMuvgWgHoL4uYlu6NXwpq/85g39vKwOP1xm7HJwbg6oHd9BrGo
	 529EX+quHc8Ncx6dAlHMnlxbOWY3G97OiIOtbJnpy9AyI8WcJs76qjNsPZXx98lfWoZdt
	 Di6D7j93mwrc70+CZmkI2vIgoObyIKxlnHayuoHpAT/h785hf1j8C6FNa+34dQ9NoC6kG
	 TW4eMGhArKpzi0gkzyVU9ydhAM8WdXrwRfysMbtaH1hY6Gc8LciE3VNdTv2R7AlSP+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ob1Yt2m5Sn1Gs6ipoID+dHaZEtMipGgSNcyf0dXNqDc=;
	b=cfo6sz8/W3IcVvtODJIO4ZBS80Xh+q1EAA22hZuHaR63UmdeW+kKgSt33GXPp7gtcAFs
	 pPrEWQTb++AOzUvjqJmnXUojhHmVPGSCTh76rfkoMTkSOPiQMvEdaMMMP6JMSfCtBhERU
	 RnX3bw4/g3KfdiJ0nNO6FXgU03eCEicWhfgJmisP5op2A6KqFvCorXv5pDg9nknGUj3JU
	 3zQriw6Hm0XlAXrg4ip2huy0uxIu6F/fSQiJVQt3k+arZDDec5a6/9KS3yMMMJrdS3jph
	 /y7N6XB35qk1HIeO5zkOV8A2mykMElwCZItt8aHmGJuYrOgte0OY9o6r5pbqFrXmGvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402856;
	bh=ob1Yt2m5Sn1Gs6ipoID+dHaZEtMipGgSNcyf0dXNqDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NqQRI8Jnu3VqJYeXQ3bFqqcaNGWtNVHzUmgbS7hHArfZ/LZHIxUVWmGxkt5ORCuiE
	 4rxC7joSo7SspLQRLkIbh6CBuM9/D3cUwQ4CIzll1H2Df+DZ9nMr/dL3FbHxSHzB+t
	 DbiHvJLUo6U0mPc74PVxlkVCMwdAyzZdfAsPgrqAXZ+aU5dh9Rz1wukZbPx4PeS+3d
	 rRQZgcNGNDqI7M1pKCn9odeCbjw0brqH7VzFPNrsDqTQu2ymoe33YMJpd8TbBsUDg/
	 KBSweZ2dXJ9z6n0ir+ZbDQ5yTPURIhOoo609Bfy85ikHRrPUlD0GRbemmRrFFzqnQ4
	 dq3mo7ZsIXElw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE77C60B5C;
	Wed, 11 Nov 2026 13:14:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AD1F17CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 510E940318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzhi1r7poHpb for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 59C4640070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=gKkLXSoo
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59C4640070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob1Yt2m5Sn1Gs6ipoID+dHaZEtMipGgSNcyf0dXNqDc=;
 b=gKkLXSoohOvmR50a0BKZHopLf9/teJ1pZBCmoEVvDgUbwt0tHRJlTJva+8j/MqJvfGrjZt1eVzEFRnnx9tRtvwrX+C9mTA3DK6cw6B0Ogyr6MbaqFm1DNdQJd91a4ffISgsy+mLinFaIjXUsJaR24gQ5WuIvFXcQpKtyMJKT0ALM2zllNgGq4yI29AMzja02UVRfFR8lBrR4yx4GiGbSQW9Q9Wd//qBC+gPjJXRvqmeDbW6L0gxPoo0BzaTLo4O0+W80mByYU6xMNO2mdRM+c50Snx/amgitrhYi75icCpgagNgdaNBO/XLWU3txZu5IQpPen+LbctaZNpiv6no7/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SACPR03MB615085.namprd03.prod.outlook.com (2603:10b6:806:540::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:51:13 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:51:13 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 u-boot@lists.u-boot-project.org, chen.huei.lok@altera.com,
 alif.zakuan.yuslaimi@altera.com, boon.khai.ng@altera.com,
 kok.kiang.hea@altera.com
Subject: [PATCH v2 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
Date: Wed, 11 Nov 2026 16:50:55 +0800
Message-Id: <20261111085056.15418-4-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20261111085056.15418-1-tze.yee.ng@altera.com>
References: <20261111085056.15418-1-tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SACPR03MB615085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0839d68b-e11f-48c2-ee72-08df3fd0f066
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|55112099003|3023799007|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: ttSJ8Ijy+CGuvRhtB1def/YSE/QqB5gYR34wbpegpnIVkYXLlTJlWmf9Rsy1dygXK98Z4lEaMO9koAisHC7pFs0DdQrNETfjyaEnR3sPPhiPl9Qt4tEe8+f3Q4T4jtmGxmfQFNJoqNuhA7wSEtpyWzkOKDcTlFsIBVGCwDVWgq+RysZL1Jkwy3c8xb+0/mnJHG7jYBb4doks2+izzyDcOSGBO17zQwp3Gx2M1OJvvMPDT+DAxVbspaKHrKZz7oS5bLCqcmVJIkNEmjWfZr41KqC0bVdh2rV2OMSx4ZZ9zLtln0eVh9gr7tiIJYx8b3r+5ZR9VVUjz78xxQgwXAXv95YKcnQq/E1NwKkXgwcT9rYbkOmKg4waldBQv2pG7e3Zl4d0FWOyAHIqj1+ZiXSB8FYMjwQtz7x65PEEnO75HvLJqb8b7jm+syQR9qTI+RkYYcLWOYa+sieBjXL8ZbMXrD3FcdQBeuj3f8neQBk/JY+QkXQzvNwKqger1U1CuoK2Si5lHmvQKGWw0x/uBj+pN6Dovk9G2Jl+DQ8fuNk3FbkqIdP9UKdIFukwrkTP7fhadDwo2nhO66TL+/8Y25jP8VqinxJElQzNoAxJtv4BidpKXxPWYG4q6+YO/oJdygwocwRerZXA6lyUH/djGukR+JYugOUjwrMK5FDxqf0eFP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(3023799007)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M41y/60wnNKgVMubFk9o0TqUMGjeXjkb5f9s0U0yt9TV5oWdvQ0poIhhqgwX?=
 =?us-ascii?Q?YyIhqSmtQM2hgcumQlIkp8WV2RoHRJTN47v8IOdXrDOKglm1n9nf0yvAaI/Q?=
 =?us-ascii?Q?5mwj7HCrTBHf7Jpi7//hgXLO4eNG4PS8BqOz1mWNwujS6U4e3b7jtbL/hx77?=
 =?us-ascii?Q?n21dI9KuOBTQzUJxJNRPfI90VF80qGJsKbOM2wFCQBJ69SEDadqsODGpbCdB?=
 =?us-ascii?Q?0qkzE6dS7KhGuZVMbb2Oj7E+fC5lFrVZczgx4RA/4q0LblgHyLlYI2Jhmvrv?=
 =?us-ascii?Q?Vz3Fh41RGHHa459lBmDBNW2nmRy/c6ATOPpHOk50WSx+xxZdPw6ASeEsvdC/?=
 =?us-ascii?Q?YpYop4hKEsFEXrbdKY5o+I7PgbDSpgs4Sfv9A0tHCr89a6CLVzCoLz1cAJrK?=
 =?us-ascii?Q?wsqMv5LRJxWL/wHLpOt2YVc8dqWVjqRHJs7du0egPH/6krzZkrwS4up86YfR?=
 =?us-ascii?Q?lQZlbUHT97KqX+y64u/uAjUpTpiycrE1z5Qew6KfzOFFJqXQlBeXgxXxEmgu?=
 =?us-ascii?Q?3aIKWNbz/67v/mF5KqWwloCwPY8CI0QZA7ofAUDuUpizbDUsmKnDeMBAlOx+?=
 =?us-ascii?Q?A4bIzs1BS5n3nF86kAW2XXlSI8rLbHWd4phz+BnIy4g0lciFtgG5blPOG4z4?=
 =?us-ascii?Q?Yj8fexhmBkhuOjQtyUoJiYMsQ74SYAaFqa6aYhxn/eEiB748Mo0qOKMPCDOL?=
 =?us-ascii?Q?m9uALAef4iyaVTJTjGgUNVSszVFFOskQgbmRtC4oE2+j+72WEgEhi+jfiAR4?=
 =?us-ascii?Q?2gcz3SxpD9fcXCSXv9T8KKABYJ/PQu34Tk2X/I8mlA3HUaDFl+wjUJcWekkc?=
 =?us-ascii?Q?9oFapMkMyI1unEZSEz8NzMmAzuUv6MvmWaRKzDZ8asvAvWyITf4xWjwDoIIW?=
 =?us-ascii?Q?mV8vm8ofkAKAsu1RLQqbfpPt6V7u3VErsWjpAgb9tGN9nSM5rBo1GT+Qbxbb?=
 =?us-ascii?Q?OziHuADJ1bhR9CxaeHb+6W41vvsUE1eVu0ON4T/cF4xemNxSEpYiBfQIkBlZ?=
 =?us-ascii?Q?pPDqOK4QK/OAsF2CwAexywU3nXxH1YyFSXhIQybEaMDg9lqA+F2e4gbPofax?=
 =?us-ascii?Q?+J+4V2YzTqUCHorMpGkfeAGlN98NwwdL1L6qhdt2dAI5CpmsfCOs7eBdp7Px?=
 =?us-ascii?Q?cxKboIlmDqrGIzsbYExZ+IILXsW8NTQcOvsCYkzYdoZlxaLtkP9SXDNU9prl?=
 =?us-ascii?Q?nkQUV8znCz80voYRWTBg7zegVgyX69NmLXnbCMofRXMkwgax7LN3XOzdVuYE?=
 =?us-ascii?Q?fmTux0MMtryLWhTWB3mUlj1jX/TG2J/s9QTjp9C7KFuxYz8DlpiK8BoGCSsm?=
 =?us-ascii?Q?+MHVzfopUatfG445AIRHcGhNVjhm7dO5+JLwQG0XrAWFBYqyCrQsdNG2awT7?=
 =?us-ascii?Q?zYNiPSHn8Dxc7BDf6RDpnICO13a3AEaBUlXEU3NyamfseopjsB4gY+yFTxbV?=
 =?us-ascii?Q?7iaqmKpTsEHVgdAAYojM3I95rXCk4oXrys05h+XSTVQA3eeZnAZnVV9ArYqu?=
 =?us-ascii?Q?Wi1BBahj8WticdM67r2YYntxR0UdKn1DOJ07A/ZqYMAxE+PQFMBzDeFhAMVI?=
 =?us-ascii?Q?3Sic4eu5PIVykJHsQfQ48l4pIddsB+EW0nD875kD41wl+UwYZZZL+4n4rc+z?=
 =?us-ascii?Q?qBKAJtCzzDqJXrzWVrOtXjRlDhzJZplXxTZcKPS/Guw/CXCsZTMPqWeCwA9r?=
 =?us-ascii?Q?4dU0wY/VX5xFcf9Yxe35ddmcvvJiyP0q4CqIROrkHK40kSYQiIEgYOhwYQV+?=
 =?us-ascii?Q?Hgln8pHxJg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0839d68b-e11f-48c2-ee72-08df3fd0f066
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:51:13.2013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6arec0IIoxWYTXScxhMzMeJ+D/CVO+bebUc0y3wmVl1pLKPqgwdvZPjr9rxzvd91iJFUQbJoYZBhb9zXc4u3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR03MB615085
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tze Yee Ng <tze.yee.ng@altera.com>

The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
which positions the read-capture (phony DQS) strobe relative to the data
slices. The combo-PHY guide defines this field from extended read mode:
0 when extended read is disabled, and the rebar (RE#) pulse width in
clk_phy cycles minus one when enabled. The rebar pulse is 2 clk_phy
cycles, so the extended-read modes (DDR50/DDR52) need 1.

Program register 0x2080 on every PHY adjustment - the field is not reset
across timing-mode transitions, and it must be set on each speed-mode
update - keeping the documented reset bits and deriving phony_dqs_timing
from the per-mode EXTENDED_RD_MODE bit instead of carrying a fixed
default. A board whose returning DDR data needs a different assertion
point can override the derived value via "cdns,ddr-phony-dqs-timing".

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Derive phony_dqs_timing (PHY_CTRL[9:4]) from the per-mode extended-read
  setting and program it on every PHY adjustment, instead of writing a
  fixed per-mode PHY control default.
- Replace the raw per-mode "cdns,phy-ctrl-*" board override with a
  DDR read-path "cdns,ddr-phony-dqs-timing" override.
- Expand the commit message to document the derivation.
---
 drivers/mmc/sdhci-cadence6.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 8f9d9ceca3d..d505c98bfc6 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -58,6 +58,15 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
+/* PHY control/status register */
+#define SDHCI_CDNS6_PHY_CTRL_REG	0x2080
+#define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING	GENMASK(9, 4)
+
+/*
+ * Rebar (RE#) pulse width in clk_phy cycles. phony_dqs_timing is derived from
+ * it as (rebar width - 1) when extended-read mode is enabled, 0 otherwise.
+ */
+#define SDHCI_CDNS6_REBAR_PULSE_CYCLES	2
 
 struct sdhci_cdns6_phy_cfg {
 	const char *property;
@@ -80,6 +89,7 @@ enum {
 	SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
 	SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
 	SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
+	SDHCI_CDNS6_PHY_CFG_CTRL,
 	SDHCI_CDNS6_PHY_CFG_NUM,
 };
 
@@ -102,6 +112,7 @@ static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
+	{ "cdns,phy-ctrl-sd-ds", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
@@ -110,6 +121,7 @@ static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
+	{ "cdns,phy-ctrl-sd-hs", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
@@ -118,6 +130,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
+	{ "cdns,phy-ctrl-emmc-sdr", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
@@ -126,6 +139,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
+	{ "cdns,phy-ctrl-emmc-ddr", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
@@ -134,6 +148,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
+	{ "cdns,phy-ctrl-emmc-hs200", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
@@ -142,6 +157,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
+	{ "cdns,phy-ctrl-emmc-hs400", 0x00004000, },
 };
 
 static const struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
@@ -232,6 +248,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	struct sdhci_cdns6_ctrl_cfg ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_NUM];
 	u32 tmp;
 	int i, ret;
+	bool is_ddr = false;
 
 	switch (mode) {
 	case UHS_SDR12:
@@ -257,6 +274,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	case MMC_DDR_52:
 		phy_defaults = emmc_ddr_phy_cfgs;
 		ctrl_defaults = emmc_ddr_ctrl_cfgs;
+		is_ddr = true;
 		break;
 
 	case UHS_SDR104:
@@ -299,6 +317,22 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
 				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
+	/*
+	 * Derive phony_dqs_timing from extended-read mode: 0 when disabled,
+	 * (rebar width - 1) when enabled; a board may override via DT.
+	 */
+	tmp = phy_cfgs[SDHCI_CDNS6_PHY_CFG_CTRL].val;
+	tmp &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	if (ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS09].val &
+	    SDHCI_CDNS_HRS09_EXTENDED_RD_MODE) {
+		u32 phony = SDHCI_CDNS6_REBAR_PULSE_CYCLES - 1;
+
+		if (is_ddr)
+			dev_read_u32(dev, "cdns,ddr-phony-dqs-timing", &phony);
+
+		tmp |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING, phony);
+	}
+	sdhci_cdns6_write_phy_reg(plat, SDHCI_CDNS6_PHY_CTRL_REG, tmp);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
-- 
2.43.7

