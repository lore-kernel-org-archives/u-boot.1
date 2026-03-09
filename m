Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB1FEF3711
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 08:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A9383952;
	Mon,  9 Mar 2026 09:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MgQCea1F";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MgQCea1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F11A83F14; Mon,  9 Mar 2026 09:17:03 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D64183BC7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 09:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sAWJEI5JBzxzDwD/W/EjNZAJrFA0U9C963VV02ZSbmPXjZjshCrw3G54VTgpYJBP6pRb8bK3j6Y7gfOTribyIGkcvfTzsiVve5l+bkFsxUQxSzhR930tdL2k3mWjOLvraFDLoggyExOsstSThmMI1vu3W8QUtmChpE6bn5WIqHkxLGRBwll7bMyOs2ybR9ojT7q1se74d199neIw7y4Ir4pNFm3CuouXCr5v2PYAwz2BncQEzViioMA7Glh5aSJbZHNadWqMDisNf7NuejpE5l+6JmdLhT7mS+XS/rOCYhNRafvQTMyatEBXcpcFlbFofFPBHn3qRs2TDLfjQogP1A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o1MW5jTDilbb/7gGGRVYNg/okwwNAdHqj+IuYivCg8=;
 b=nmMAnsu1u3o+ULodRecq2XvK7sff5GH06CuWB2RluLogre2wwwW+L/RTJ6nKPbUmHWIt9aS477udXtIrMb4hpGzCw60dA8vtNXjPuRNItEOkQqUpRLuwPe2YffByEKAlx1t0ZvO02+XOBGM0mVpIv5KXRe9gddY3L7P8Jnu+UKm+yq7JqMjssn93YMPbck52LrKmsf3w+6V2D9GD1gRK2/9UML/C+FJXKToxQLo4xh/XnHNZUuzWgJbEeGJN45ecXBSWIw25HRbJijbIs/flHTf1bxI3jd3TLK4lJlUQi2abNsfs7VoLVsbi3XMry6kRDqslLJ9wlQeGcffkC4gAXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o1MW5jTDilbb/7gGGRVYNg/okwwNAdHqj+IuYivCg8=;
 b=MgQCea1FTZ60LDSocR2u2H7gg6/flmE837iYqZF8f2SrjikmEWS9a/mL/Q57bpCF2Sn+4XCq3g5xehnjhGHky+uQz4Kdqnk6yHA4lo2aiPPew4Wwols91DpumrV+68bD6r7nv1KtXbcdLDRRVlx2oYfTrqmNi6xWoin1ZxFSphc=
Received: from DBBPR09CA0040.eurprd09.prod.outlook.com (2603:10a6:10:d4::28)
 by DB9PR08MB7627.eurprd08.prod.outlook.com (2603:10a6:10:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Mon, 9 Mar
 2026 08:08:57 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::37) by DBBPR09CA0040.outlook.office365.com
 (2603:10a6:10:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 08:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via
 Frontend Transport; Mon, 9 Mar 2026 08:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7rHE+u42jRYniZpHGKl5TCPdLbihM6AtC4wPS+zK3gWEPwvOsoW1blv7i0S34DAMbptgPyCwtGnphgYmHy5wSiBjnLP8ftmWGcDWuqJtB3UZb47C59zrlJRl0oPcvWEdLsjXiZPO5VheN+UMkxoZ79zdM/35rdfGeC5CrRx3dcdHMjbx0wai7eT7uefW1KtqS4uO9yL6678CgoDUoCPdjpn0TiEt7Fx1bx19UnWafR6ZSMEr96iQx6+XLi95tnUzhSV45JP6qB39qHtkqMaKZNTyt2pEOjr07cO4THHOqJ7n/yOy0OL3ivzgWo+oAiPni893EaXpHxF8DR5hcOi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o1MW5jTDilbb/7gGGRVYNg/okwwNAdHqj+IuYivCg8=;
 b=dO0kfApFmzB/L4/zN8Tno2r+JCpxE5i/PmnByMhv2G7Ll0+O2PDgpj8M4wNW4AYZDWNOuzm6EeHwHaX0HKt4WW/aidnLHU4HFc2ZIQL60A6jmDg0JQfuvg77ZnyF94+ZIvvYWUbHRhnufsdZ7ZNPb8IPZZ3gKrFcIpZHNuotmiaiWYBZdk07LTPyvVSBj07bd6DFFbSSdA07yNmSjcH3/9Bify9kwSfBuL8GFdtZTI6+ZIWwqnTxW9ACy2KtzX7fuEGrskBEFSbMjB1P8DICUOkl+AHr6bat24kz03dlxUTEjmgNvajeFuJsBMJCly7cDal257PS9wJigQ4AJDGqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o1MW5jTDilbb/7gGGRVYNg/okwwNAdHqj+IuYivCg8=;
 b=MgQCea1FTZ60LDSocR2u2H7gg6/flmE837iYqZF8f2SrjikmEWS9a/mL/Q57bpCF2Sn+4XCq3g5xehnjhGHky+uQz4Kdqnk6yHA4lo2aiPPew4Wwols91DpumrV+68bD6r7nv1KtXbcdLDRRVlx2oYfTrqmNi6xWoin1ZxFSphc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5706.eurprd08.prod.outlook.com
 (2603:10a6:102:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 08:07:53 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:07:53 +0000
Message-ID: <a3262e83-95dd-46fe-a0cf-fd6d7e429ab1@arm.com>
Date: Mon, 9 Mar 2026 09:07:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: scale buffer pool size with TFTP block size
To: Pranav Tilak <pranav.vinaytilak@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>
Cc: "git@amd.com" <git@amd.com>,
 "padmarao.begari@amd.com" <padmarao.begari@amd.com>,
 Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5706:EE_|DU6PEPF00009523:EE_|DB9PR08MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f77f24-3ac5-4fed-ca56-08de7db31ce4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: bdfRlzroXyhoY56UUOrqBkfMg2zN6G7QkOGGc+wr/bx7BHtsdBLToXo0JHsDTUAsaK8xNckae6fnnDYZSBqS2OQQVbyQDcvOGIFr/SiO27bpNo4N1DKu1d/vRphJ4NDt+EY+jKxSagxk2NxNC2Y8RuUdmvAMQxM3PvN7Aaquchm0panyLXQBRQwEYwRyvGB4Ww6FWoXPDwqaqTRYhKAYtCdm4j1O+zX5oMgyceXYoeBLaVZtZAtM0GkzyUTmto/fM2iu2UcsGJiFs645ncCnVzL7NHwe0jmHoPnv56nVjc3MRyDMo1g+VuRdnpsciCWt13S/gBkF6Wr9LzyN7INLRRpBy4hEEEeeWB0SuJRc3xZigINGK3CFTUWGyaXWPn6d1yCGMeKbXyLv9D26a22V2A2v+Apt1cZ9+VldGyln+Wt7u8KRCbkPike47KTd530YI/voHB1QeHU0U/lANCuEFtgrkmI8dnQzoCMFd/Yr45Y2votcK56GdacnG60jQDaeYXc2UESH4P/JDilsgGkc+60QFocV4wZNp7IB4apMHHqHsGP7lg3uK1IEkFG7gxhs+zUDULEj51AK0tiPuzHQvDWBhjjm22zx1qLPz4TFhmPNszG24QQZ0q1Ulzrc4IuDpW/XgG4lR8IrIdPI5ciZ7sWWDtCc7rjZ2Ckzs9A/pKgIMLweqhkarPbwCv/HH64nkn9KpsIpPAyLhd13MC03EhEleJiLt02IABUbVvxPc4U=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QBdCqcQ4yQiqsamfbQg0UkI8dVrQbC6mCIDEKyPhpMUJh0R/O899ougsyzZqr9WK1dF7zSIBRVwOJZullaRrpVWhWwx7mwhn3T1MA0YJ8FQdOxd8rJ0ht0yoIBhpYrp+trYjPQHZmz8FS9VKPJRg8eLJpnsYFYoOSsm+AN/LifB/BB623D6Bh4QkppxNgtvd982gF2HI383Bg8WTrPATVfjVzuoNMjzb+FEjy5/RSLcWvRL24+mW8BIMxa7c6sUPxx50HKkSpiQvpfxDRIf1a5yqtfQZnr3MSCwDDsCg4+/02DypLrkCMUCeeK1Ku3efxI3qYZtFLFuz/1xFDSLffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ee561da-5af9-4825-6e8a-08de7db2f6bb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|35042699022|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: vwNAb6hQTxwST+GfOVglTV/PIA4IiBo6zZu/cHk+RPIWm1Aegd/4olqkX+WsT5qgWg6008APViR0SmbDWIpJs/bCtAgA14/tWaLUkzDMsVMaDcve7atecX51Cgs70yD4qYqm/xrfxUl7byii802JYO7wuonAaWJjk7AOIFZZot6lJ1EyRfVTJmUwZaLj1GMtAEvpMOutiEx0V4MB9lzFS7NLKaI85oS0LqtLnjW3l5a8bikAWTDMsIcPMCtKuJy6KXDZFuoto3lc4Z7oU5T6NPBERuVviua0ao3nslA2RrPX8LA4Ox4Z0i2JaADtXnc/2KdCf5gtrqEgaEJQ63nRAtjXaMe5t/nvS/ojxB+kro+hKdeFRZFMTcqOyvG8n/UuE3cliEoLtfbX/J/hxuQfKFn4eKWoZCI09O8SWK9Bp5AeEBLwTZH2mObXs4Vc/4XOi5JTZyDLw3cKDaHCnPgGcOnbSQk9kBpzoYwthptcpog/u3W/j4VmJa4a68822zJDhz04gjVkTmcbm/PJxCGiGGR4oql2Dzb4tJoKRGR0OYgOhtsA4PrE71F7P0zW3th3TZwMfoCU8M6SS4XjDyHHjlEaBpvRSEq38EHCC6a6wIt2vPoehH9JJeWTk2+gcmw7Kr7hU4aI+k45PbU0tJ5EeI4LK/WK/3qRNSOMkO5YZ3tH3yQEPyOuTdHBGooJVO4qVrUmroO+g/UshIxiWqYTxbgmPY9lSHAVzZiuLqCflJgLqo6yrkZT0akOpFRx+H0S5yS+9naKWqQQQeTeZzEAUQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(35042699022)(82310400026)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ycR+AM14detwuJ5xpWzs5qWGJ4rlUQHBrQLx6LKlAyErKzVg9zBT/dTdDam+r+P44XgKpLaPFAhluD4jhzmqqBza6v+bvjsyqKF0KnA8CoFWa6+puquk8KZrk5qlCI30CDsrElwiCU76ebGGzCzj/NIjLnDJ7NNEdxFwGSva1Y3ArFB0+QOalQL6nJEtbxNwoKC0KolQGU4B2c3YtnGpKtn68ZdrjvJIdH5JpCTGGma4Cu4WLQLFc7Eqaemu2GMLOJCGN2u4UgKLQ52qDaizeyJ8w57llotxer+yNaQroPqBMrz9ei5euiibP5dDz68DhgegLJyFJkxOncSs0xcUjQEQkMEEZgjPn3biUEroD5VkuAz9uJWgFpE0TbXGw0gQ1XCq6Yrkk7isdtaWrpyY5DXK//SnCl1Zd83qLzj26raOL1zn0EnI0u+dDIJXZMHr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:08:56.9586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f77f24-3ac5-4fed-ca56-08de7db31ce4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7627
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

Hi Pranav,

On 05/03/2026 07:40, Pranav Tilak wrote:
> TFTP transfers fail when tftpblocksize is set to 8192 or larger due to
> insufficient buffer resources for IP fragment reassembly.
> 
> Adjust PBUF_POOL_SIZE and IP_REASS_MAX_PBUFS based on
> CONFIG_TFTP_BLOCKSIZE to support larger TFTP transfers
> while keeping memory usage efficient.
> 
> - CONFIG_TFTP_BLOCKSIZE >= 12288:PBUF_POOL_SIZE=18, IP_REASS_MAX_PBUFS=12
> 
> - CONFIG_TFTP_BLOCKSIZE >= 8192:PBUF_POOL_SIZE=12, IP_REASS_MAX_PBUFS=6
> 
> - CONFIG_TFTP_BLOCKSIZE undefined: PBUF_POOL_SIZE=8, IP_REASS_MAX_PBUFS=4

How are these values computed? Could you find a formula instead of using
#if/#elif/#else/endif?

Thanks,
-- 
Jerome

> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  lib/lwip/u-boot/lwipopts.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index e8a2c9d7a0a..b4ff31096fe 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -65,7 +65,14 @@
>  #define MEM_ALIGNMENT                   8
>  
>  #define MEMP_NUM_TCP_SEG                16
> +
> +#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 12288
> +#define PBUF_POOL_SIZE                  18
> +#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 8192
> +#define PBUF_POOL_SIZE                  12
> +#else
>  #define PBUF_POOL_SIZE                  8
> +#endif
>  
>  #define LWIP_ARP                        1
>  #define ARP_TABLE_SIZE                  4
> @@ -76,7 +83,15 @@
>  #define IP_REASSEMBLY                   1
>  #define IP_FRAG                         1
>  #define IP_REASS_MAXAGE                 3
> +
> +#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 12288
> +#define IP_REASS_MAX_PBUFS              12
> +#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 8192
> +#define IP_REASS_MAX_PBUFS              6
> +#else
>  #define IP_REASS_MAX_PBUFS              4
> +#endif
> +
>  #define IP_FRAG_USES_STATIC_BUF         0
>  
>  #define IP_DEFAULT_TTL                  255

