Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C0CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEEC846A5;
	Tue, 19 May 2026 11:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="c42oMLXF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c42oMLXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F068A846AD; Tue, 19 May 2026 11:31:55 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F156C843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KVZ9sy0Vybo/MuJ9rUVY3TIcUaU8ctc39QRD0w3G1kdq6+55A0VWdj38IN/DbkHe8frABFM6HSOkRDNajkAbeg7n4+vinuubSiAPXnIyehE0nrcTsqaWOLFc9m84ALxdeQ06LjSStwoRsZYfn/+8/qCa0KA5iLqCqWDOMENgHYc4YsvdbTe15kRg9Yvzs4CbULQEKauLRxVcSXRPr7OOSC/NAlt6bctzKq/PrVnfq2cKP2w0vhDS6saHcTtClqjA1f+qKHUWgZg4sikuv/sSu24UWhS2wc7Pv0d7uRX4sVpHPj+BP3TKH+JzVPBcLBAIox0iwYvJaXoMhXNIjiixGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0w4Suk0ooWZpPLuRJNTBDr6MvJtURGrxhpnXvDvmgI=;
 b=ymO0WYjuKjPYEQXJ9oVxfuKis1c3mpdwoMlSkB3rwmm/uD9ZpUJSG7+cVifPpXZfz0SiCVOuuyyXkCaSDF0RBzY0fNx91TmI2KxmHGigwTPLvhU3l178titvx85hsGrEz2/DEiHbWeQyvQV+kHrld6tj6Y2aPgcta4R0muMyc054h5fnR3bgU1zfaHwxn9CIvAAFgctp8qf1wWv6wgqBWLdFoj+VuVBgBIv7q7h1Z+qZNlJGEsPFscQNL7OwcAz7l4DZ9k7txTuIMN6I+hrK5cNd3Inb0Ve8Hma0RyBj7YYy7B/w5jv7KqJ/oAcge/uMtMgrACH/MYS6kMAnQgnqxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0w4Suk0ooWZpPLuRJNTBDr6MvJtURGrxhpnXvDvmgI=;
 b=c42oMLXF9O2L0m14O/skRUJ01Wo7ywj1A6S8N5F8V+mAgHbbug1S3dtXDW+vsrDCSxXncYKgjeToUCC+Ybq43gyj5cAKG2tjlXaIs79jy7HMYbte5b96zkx+zgMo7zY0ogCKiTLMRLvMJIIbtIYPmY3oVPwZu5kfVdSOqLoIJmg=
Received: from CW1P302CA0026.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:297::11)
 by DB4PR08MB9285.eurprd08.prod.outlook.com (2603:10a6:10:3f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:31:47 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:400:297:cafe::95) by CW1P302CA0026.outlook.office365.com
 (2603:10a6:400:297::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ukh3v5nANQASm8HDHc8CBQ1oQHi6EQseglVGqgo1l0IfuMPjZbqUmqVFN481Wz3KcBV23CgjxYIpYy+q6Hj+zDVJYtT4Xbr2QaCE1RE7QkSMiM8Up4eOqglblllTViRlDoMwGiYM6PFUeWNniVxF+Dego+xVXvI5ps7seEgOaIi6ANn6u4AoeRZDY1efYMsp056u1w0EhuEuv+PxeZGyH5HusP8Uir2fUCJk2CGdThkfYDDnzB36VBBtbBjABvwwRBwfzhvDerUfv5bZwrNuS7NjVrvA6ivuri1wtqERbJJioI7MBbRifo3pbt8WIEpwyKKyGPFes3ADySRfg1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0w4Suk0ooWZpPLuRJNTBDr6MvJtURGrxhpnXvDvmgI=;
 b=iLr5EkcVDLpiO8KpaVlHfJ4WvQpardiNUOv4mpZItBVVfOhwSIxNjYnnGu6Af5fMgEEyMathZcAJ5PvvtxFvprM8LKYaN512m37rQkTdmB3NXqPncZPpClXnI9JCs1JcKKZKocfz3LyBHPVsbDaUsDsSOuDmWzrxBnRHTtiFHjniflBWEhXCF/wI+uUUw1b3ybRExXVfa4XIQW4aRh/5nyHoxagkBPCXJjifprxDwn0l1wGJ4/Ff1COc8XIfZohlbfuDQIXckL2hn6+4v5mppxR2l0aXKCe04z4N7hnAh1UqCcaNh2/Uv1ArnSwogRACSTZ0Is6EFGxkCKkThuPQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0w4Suk0ooWZpPLuRJNTBDr6MvJtURGrxhpnXvDvmgI=;
 b=c42oMLXF9O2L0m14O/skRUJ01Wo7ywj1A6S8N5F8V+mAgHbbug1S3dtXDW+vsrDCSxXncYKgjeToUCC+Ybq43gyj5cAKG2tjlXaIs79jy7HMYbte5b96zkx+zgMo7zY0ogCKiTLMRLvMJIIbtIYPmY3oVPwZu5kfVdSOqLoIJmg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB10623.eurprd08.prod.outlook.com
 (2603:10a6:102:3d1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:30:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:30:43 +0000
Message-ID: <8d271ceb-e594-4858-a73d-d09e4784fd4c@arm.com>
Date: Tue, 19 May 2026 11:30:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bootp: Prevent out-of-bounds read in
 dhcp_message_type
To: Francois Berder <fberder@outlook.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, nd@arm.com
References: <BESP194MB2805D4957FB23F4FC2C7F370DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB2805D4957FB23F4FC2C7F370DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB10623:EE_|AM4PEPF00027A63:EE_|DB4PR08MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e36bb2e-110d-45a1-c5fb-08deb5897278
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: xF56YnucjHZ5gfCyX+r8DdE778xicoU8OXTwqZ7g1V11uyMGqLP64sShi5Y/WUMvL/R+780CzXN/Y9W1fvGP09jDTlVfiL6LpDqUDuGuITzxU4NR1kvjWe8PfAWihgwqoIOSAazEwS7vZIOqY25HH48sjHRpS36n7rngI+Y1tjKVcjOi6u1i7bdKbFoenUs/IjsOH27gB2tmJlkZfvEchdbFYmbIyLkDlOhF9tR/m/a5jT9NxpYuvT0W3ZjUgj0sgXzB9gZccqpg44KcE4izXMS99LFWFCDOSDRjNlcg+OwlyumyohbfDpDBTHV4t/SwkevnxsVBebkipCl4nYHZaFMsuR69dJTmUqOG/tZIzchNNzHDKmjnIyvdUzqXwYNlr0wadz0uRN+mdF4AjXeZws/dvIcSyI/ksnZy1p5nYUPkfalFNUialw0mfYaO7ESQtWdfbMAYuzOJM81mzH1KLETuP5N7zAfTIWC5BnzNjTrKn8yZ/0Ib1nkpmqgKo22DehwiYh5WX+0jrJib8nFQdDwGdrAa0TbUQYhAGm880VUUwsYCp8XNjV11ASexdbcpwXA/r02mkbrTmmNRWMzJeREwvTBIq1yNgvsc3/sUFAp22/8d+p4b/+8pQhzUPTn+2HkQAoschpwMR7rL6K306YLsoR6ILMW+gjkqE5x/QVMDNF7/hK43IpTeVjNxUeoX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: qoTy1EXXP0ckE+x+6vKKaPTV7N2WvZxEhW1FBKpk4V4wFGEzOQxtMcWVe2mft1gkuexW0JR16sBZcaKWKQ6R3bo9giO1fQGrUt+igJqokCAJ8dviV+JUW7sQ9dv2/Z/9laXyWRARgT8Gcv6EZ6SP3HWVGebRPhR00+QsX7H/Xe1+cWtHo9FhVOD3dHjjST02lJNqD/zXw7uCV6t6wwKLJqMW6wkRehHM0CKP0FUBRg/J+A6POL3x4+kraL+UNzCPuusiEgDQ8hoy5GkovGQ9mpfmHNL0odIaBorSB7ZqqDlO/2EbnmLCohjUxpa3WGBbbW1AsHu0cUStKJXbdyvdrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10623
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a7df3ffa-aa62-4839-cdcc-08deb5894c5a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|32650700020|35042699022|36860700016|14060799003|1800799024|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YND1mEXpfHB+9r+Bcf7kDise0n2/rpnJv51+QTRp9wIar6Q7pBuXfxpDtuV2A2yjq7NhAg+AkKUJaDlefBJrbpy+YhFBk5Cr96fPgoj2+xAlqQVmIzVbzo2auwzjHCJnQwRdSdaX1Xx5fAeIxlWy0U/W1DJSlRfCmx4jOxIopMVUMI/WPuBtbKnsQKe/zxplCQXP27JsOszdaE0KdFWyVP1QNL8gOJ3RZDVuJWJrIlvdQKW8Qx4hjtQdSdZOx/2WC6u1fhXe3TXwAI+ERXAWncUcMFf7JW8Q0fwgLycuH+OAc2m48vaj068LZkC9FhCVqHyfEGIiN8rjMzGwRjxnSBELul0ZKAyTnEEOSss6PnIS71/ouuYhdOeev4uL8WPa4Qs8YJqHL5XlVa0kbgiWrxOP7rIXBDKhEeIvHfpin9HnhyzknBwPcHBfaN0CEAezlnZDbchzWOGBkroF/3gPK5IE8eJaL0tL8QVqBPeIGigaeh8EI7CXqPAWdK/tfSj6vrutWn+yHwd/0ZWexcVFdNEsRgxlGHVuKZfoy4XzDslYSd6t3/9sj0Y2TZT4kc7NN6/5Vv7dwX9eQ1nZ6GYxT56E5PeeA//kuXNFjVcKIXpCUN1x834jeZBU0zcgEhdVXJZAlKCUNNmAchKrEvq435n9ekDd1oYuE1sdveBNmJ14WmdpAjX0LvBzhYOFg3tnCQO3ZdO4gecSLsNcn4J8Fr26Uzawi5ls+adz9Ng7PzY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(32650700020)(35042699022)(36860700016)(14060799003)(1800799024)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cdS7DW+dKJxsbBUcIH/UBa8+APBQLP4ta+h9uNA7pg7oRY+FB1aHDq7YUBriQIYxdN442W8xL4t0nVfc7z5W8Lb+UAne0VY+BEi5rQPZbcdiFee44X+fq9xpkJa4WQSqjV5d4j936vqXQq3pqQ212yNpXi20ynRVrqM4Qp1suqNgDLlF/2gWgmZnLqG16hekncVDaMWXLN4at7ri4DmTbSs8FKVmOLYLRZZOxAn0XL20Phj3xjhdwMADs4jtb8RXn+Eft3npb/AXFS5LhNNfukuH96SieGnWd0909P1ECHg1H2RuvfjtZCJgm2TULMlEznNrovcNbxsXZXIPKz+b15KmvpxDzextf/8DHZyCaf6kVwv3ZmcrfX8TccilB9SytP0sLJACFr+uk1XChgJR9Ep7Buvqr5LKrW3ZiNSXn9CpwPwgdqRMOjR3e0cg3uAZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:31:46.7958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36bb2e-110d-45a1-c5fb-08deb5897278
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9285
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

On 15/05/2026 18:56, Francois Berder wrote:
> dhcp_message_type() scans DHCP options looking for a 0xff
> end-of-options marker with no check that the scan pointer stays
> within the received packet. A server can send a crafted OFFER with
> no 0xff terminator and large option length fields, advancing the
> pointer past bp_vend[312] into adjacent heap memory.
> 
> This is the same class of bug as CVE-2024-42040, which fixed the
> related bootp_process_vendor() call site. Fix it by adding an end
> parameter to dhcp_message_type() and checking that popt is lower
> than end.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  net/bootp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bootp.c b/net/bootp.c
> index 8976936b184..f0dc329d6e4 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -997,13 +997,13 @@ static void dhcp_packet_process_options(struct bootp_hdr *bp)
>  	}
>  }
>  
> -static int dhcp_message_type(unsigned char *popt)
> +static int dhcp_message_type(unsigned char *popt, unsigned char *end)
>  {
>  	if (net_read_u32((u32 *)popt) != htonl(BOOTP_VENDOR_MAGIC))
>  		return -1;
>  
>  	popt += 4;
> -	while (*popt != 0xff) {
> +	while (popt < end && *popt != 0xff) {
>  		if (*popt == 53)	/* DHCP Message Type */
>  			return *(popt + 2);
>  		if (*popt == 0)	{
> @@ -1120,7 +1120,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) == 0) {
>  #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
>  			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
> -			    dhcp_message_type((u8 *)bp->bp_vend) == -1) {
> +			    dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == -1) {
>  				debug("got BOOTP response; transitioning to BOUND\n");
>  				goto dhcp_got_bootp;
>  			}
> @@ -1149,7 +1149,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  	case REQUESTING:
>  		debug("DHCP State: REQUESTING\n");
>  
> -		if (dhcp_message_type((u8 *)bp->bp_vend) == DHCP_ACK) {
> +		if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == DHCP_ACK) {
>  dhcp_got_bootp:
>  			dhcp_packet_process_options(bp);
>  			/* Store net params from reply */

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

...and added to the net queue. Thanks!

-- 
Jerome
