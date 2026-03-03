Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF2EDA6B4
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 17:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04541839DF;
	Tue,  3 Mar 2026 18:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iEBEG+0j";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iEBEG+0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E2D83F59; Tue,  3 Mar 2026 18:10:34 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF11D838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 18:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qvt8gJ5x3r6kwPKhfszTfhcApTTgz+Bcy5U77L1Urpvgs02VAvUm2CYR8I6JkAYSyO30FskkTGZD7PHesk2jurGY/t4Z9E/HDPLiJy9Ww/rPv4+5f8ug0ziXlwjyzK27ML7U/C8SkoStcFGWGB9/MgtjL1sf+1KoIQxxPKhNN7VXsLqhAAYSntWuZrQBPgDZ8yW9gl+4O5ID8H7sypsLFNxHlUAlzN+pxPGJSnVxNvEsMwe5+zsi9cwIcaqaGvlGUobS+sm/FZ/9SbWQHrBezNLbI5RBWyNlH7uRs8YTA/IaTjCebk+vGJTubzWVncNhcIn641IaRYMzjH4eyZgR1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5e+lDe6rahybjASt3vinqV8OhUBkHg3uCB65hXsOzo=;
 b=LAKdys+YOiE0kP8FbkcdyF5RnbblM6x4gNs+MZRJuL4Jg9nZZDw7x6iTKH31wooiQXkivq5VRbKQJqgYZGO2KacuA19WlWDgye6N/XRPItRpcKAjrPSfYjoKGr+1VA8XLKWT7QV240cPqFGUvaqrRnPDZIgt5T0iowLvWDI6u9eI7Wuz2XD+3lTb/PJXoaT43u2/SJFNfzlhDf+24LVnwo2xejv3LIh2N6+FoZJ0lbbXaVG6ojRzGJ0JWLusUvSPW12pyHsk75nhPixUSoFtk/5NEIgAPeDE2EnL0IyZFs0fpjzmCceL2+LGMddyB7RFoRrtQpcUB+3oMegXGx1vnw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5e+lDe6rahybjASt3vinqV8OhUBkHg3uCB65hXsOzo=;
 b=iEBEG+0jPIHHVZ8AQobKGlTxskDQVxS2aohCNm+H2vCEOw8B2YAjcbnoKvv3hlRX1VbNi/1L8AUHO8zmtxSGNYK3O3gmD4GMhzLk+AJTskalYfvjppBH31XFhns8BKgG/1nJIS8W/9mYWN/gOiUcKn+YXusHhhLFZVV6px8bkmQ=
Received: from DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) by AM8PR08MB6596.eurprd08.prod.outlook.com
 (2603:10a6:20b:369::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:10:29 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::11) by DUZPR01CA0146.outlook.office365.com
 (2603:10a6:10:4bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 17:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Tue, 3 Mar 2026 17:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfDGiIIGxnQ53bEGnDK2Ya5MEBapYtlRJU8wYf5ZSwXMUekk3ahAitRWo/vQkH3n4V18DGDwu2fM4Pakr5zNr7hnBzwJmDiTABWvoRV6XFuobu04nGvSxIl2675vhZDt6nv33GSTpp4WlkeTdEYfTH3eTUvhOfa6HwNgDvfBYEkblNq5Oa1U9L3QWACsXP4eqKjxNJmDGKkbTiIKSj4iWfa4g3QfmOtXY0hyGD6PawcBo5nesV+So2qAvdUAxYu0Re5IVm0s5iHOU3PD0NOwV1kqfXYTxYQCsq4pRBrXI0/ig9uByiW5rzr+wOHAnG2aCYZ12L6PBf8FBibhZ6ODYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5e+lDe6rahybjASt3vinqV8OhUBkHg3uCB65hXsOzo=;
 b=EV7J8XGFaqBxktGqL5yBHvNqwa/LNtEGqAQjG0BtKtmMtJCvCbPuzPStE4X+0fVQDlvpRINQ3imiy7JrpEWZziDHGeDfj3jrvIE1knhEhXRaImLE1PTUIr591uaAIFf+arhtZpJbDZDRTVqrTsDoU0bMlkT/WTMPFkyioLPseXFkWyZKCvW9FuSZGHuRAf8UmnQMUVjs2o4tkuwARYMN0d/g9ud0wzDMRlrTnTfYZj1azdoQf97QXPbUsAiRaEDrqj2ZpFbUV09dAikp6+rkCnCrHkMV8IUfI/ujS09a8qYF5119jwY9yICaCSBEXBL4qygXJSry6WjhQx5ZES62Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5e+lDe6rahybjASt3vinqV8OhUBkHg3uCB65hXsOzo=;
 b=iEBEG+0jPIHHVZ8AQobKGlTxskDQVxS2aohCNm+H2vCEOw8B2YAjcbnoKvv3hlRX1VbNi/1L8AUHO8zmtxSGNYK3O3gmD4GMhzLk+AJTskalYfvjppBH31XFhns8BKgG/1nJIS8W/9mYWN/gOiUcKn+YXusHhhLFZVV6px8bkmQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB10241.eurprd08.prod.outlook.com
 (2603:10a6:800:1be::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:09:25 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 17:09:25 +0000
Message-ID: <8c5bf3e1-a0e1-485d-88e9-d97189eee6f3@arm.com>
Date: Tue, 3 Mar 2026 18:09:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
To: Tom Rini <trini@konsulko.com>, "Lee, Sin Liang" <slee3846@gatech.edu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Taesoo" <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>,
 "anshuld@ti.com" <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>, nd@arm.com
References: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227184202.GZ1593142@bill-the-cat>
 <MW4PR07MB86365FC9B8024035576E2C7DAA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227220730.GA1593142@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260227220730.GA1593142@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::31) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB10241:EE_|DU2PEPF00028D0B:EE_|AM8PR08MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8f3b94-c30a-4f51-bb1c-08de7947c53a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: SAmyTEsJ/bTOLLQAvIufZYgjfTkwMoCKzkmBpoQGTTMM85Et20PUm+7MtpziCtw60YbeuAzaMUG/32QclX0BSpYPD11gY8KqDSmaudAi/HNEhxR/a+rIScH6NkjjdUJjAQ6CsrBwt4b8UXtp04bmv9O7qr7BiH8jQEeBY9btETDSK4g4igzBFROIE8tqOg5F5NvZnXl9EKRUy3MpEf3c6QA5EpQbc4SLhbvh5SBWsCrev0LXJz8rdOxdNfYl8tQBBwuCE2qpD7VXmjelvdiPxY7LYMBDjefkaUe1iHM0DHwBiv90Xk9nbPWPzIHh/YVvvA4G6SbsWyjpn9GXCRPwAxy7PPM9/WTf2PlVHqMvXYCf410flwewbgoulqb+8OZwHp746vFpgF83xIXJiZsAN7RwOEeTm0Gm3gGTOZd90UNvoq/koBitcmXzS7ascMfhcDK5082eqVgmRdb7BIVnv2lZ1eisT4hmRWMgYGYoyXGV9nS4aAPsRPzCutY6dLbVITX9wAPj3KODTb+k8zpFEeFP6e3XG0ZpvHYv8j2I0voLPNobIGqLn+zAXQQ2IDSPJ9iMa49db3nFPzdGItAqiY7x8TdRreQUnwq9ZMjyKzXXrEaznwrYQmVqlH2i+oB8jcf8nFY/Y2g1vXZcKSf1LgCK1/haRMFEIby5I/2bgTNvE6mqOaojw6FNTCiV0bHoOggrYvmlylGg0LT3rx1OxNOmBzidwt1rAKFfFMYeVX0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10241
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76231afe-cc1a-49ef-09ab-08de79479f2e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: xdaGBQZAxQukf2K4hP+EJ8fxGX/S/zUi9M4cDmjC+m24gbI6RpvZBwFOvbcGM6/2eGInojyZGhpw9UO6FGeIdq6lpbM0vCqoXlU2Fyx9JeLVVifVGlGYuKAmhspQXVOi96RsYKEWbovqQ8vu2pNVdeQAu2ftCXZB5oY1ugp1qI9Vj4NHqjHhoivliqk8JQuiKKtKzqzd7MShKQb6E95LS07Y+SUhef9OvTrvX2KVLqU9M2j3Hw8ZLkM/bpqUz6T3oNLoHGJeMvp+FqGoEg2dVl0sgIw7cDYTtnBYhMIuwNvunO+xUL8T6y4u4mZrkak0AcWSdGmQmpPRMeU3duvlW6UjwnnYTLftlJBFuK2HAOFCL9BdTBFSOy5YYPMLc8/6fSHQYm1zNdAEarZDLqv20hfbekERins7pLmB9xYYJLD+SW1KZ5Fc5Qq/AjPy4oscocncDReE4I1YhQMyvYW9w4V68QMqDIPPe2SgVmE69UGeXBrQHZNCr/BUW6MDC8BexmRZDCAh+eJJ0orloMTxOt/lVZXjUci1hnIsnOm38Sw/1D4sPpsV+kz5u8mskz6Wi7vjC6PriHSlrbvykCJo5yuSPLm6ih5z0D7mCVZJnNao08t3WcuBoiRkSL4r+wRW8uUn2afqgyRp5NAPsbGSNld0zjQ1qHW9/y5eVVhbYRjO+iUmnKZJ/bm9ViWfqdMd7hTW5JEQdq0mB/31B9HXcu3gnRlAyaB6btTfSBIoVz96kIVKVHxrGrqKTSWAnScLE/t6Ozcw3+yV4Ol16482dics5EChW/yJzgVG6WV0N/8XVtjdR1mKWqN7ZK2Dr+EPYeUcvVT8eduZ+mEs2pJxsQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nGmONsFsBFlBq9zpPzoaO7Owc2v5o2Vmg0JsDsDDYHKOfRzu0tagxLmdtuiqYopQUMAPo0xYKrHA2oQZJZz9cHtYPzSIvLvhBuG18nAl32NMx5BfXMjp6JDW1y98cbSb9Siy9zAlbc6dutMPJpWE2JbcVbS4Iz1IMsbkJJovx2qDVZU9/z8+pZn9tNYNKXOm6mZAbW3Hlic9kNCeYZCT8HC8e6yGTnrCxvbaRM0+tx9baABXBYss+XJ1rgxQKNJ07k4S4lMhIpugL1lsKQ30gFyjMNVR2xjkhwMr7cS8MevzTO1fwBQWMGEzxeLcv8G2uwq6tNF6gLiBF/e3Muw/W1Nmz4YXawDU5AmMCOdTmPGyZDJLL9MoA9GRh5kz39aBpde+CQyDETBFlTppZIuLcre7KCM5QN77uTvELdRE6LFZ1adi8qaRb9/kV7eWDG6v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:10:29.0769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8f3b94-c30a-4f51-bb1c-08de7947c53a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6596
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

Hi Tom/Sin Liang,

On 27/02/2026 23:07, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 09:28:44PM +0000, Lee, Sin Liang wrote:
> 
>> Thank you for the quick response. We will follow the  submission guidelines for our fixes and attribution.
>> In the meantime, would you be able to confirm the reported vulnerabilities on your side? That would help us make sure we are aligned on impact and scope as we finalize the fixes.
> 
> I'm adding our networking custodian to the thread, for when he has time
> to take a look.
> 
>> Regards,
>> Sin Liang

I have reviewed the submissions and believe the reported vulnerabilities are valid.

However, I would question the C:H rating in all reports except UBOOT_NFS_OOB_READ. It is not clear to me how data could be disclosed in those cases, so a C:N rating may be more appropriate.

I also have a few minor comments on the proposed patches, which can be addressed once the patches are submitted to the mailing list.

Thanks,
-- 
Jerome
