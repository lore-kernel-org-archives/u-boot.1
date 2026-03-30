Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177FE10F3DCD
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC83883E7A;
	Mon, 30 Mar 2026 16:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XliP43J/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XliP43J/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3EA83E7A; Mon, 30 Mar 2026 16:23:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C573583D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ogGKhZkNsOQf1CVZ/sBkfaGNKz13XXoQCaySkAgInrN7so/ezIcoYngsB4err3bgRJ3o6iMq9vqeRm9+kp4vSVx7y0FLdXqm7XuZiHTft4DxWc0cOQjSXi4XtYgSpI/DksFf6uN1KAcyQHdlWHVmdrtJ8Qig+ijvKwJQ/If+KvMz47u2PMQuXKhssVQcV4nQMQcN70Fa+X47hRHYmyQXcSSJ9A/Fu84zSguK8mK6mx8kKYBSNmnS2fliYxAiU4S8UtCWJBnGqxGkSK7P5PuVMI678jh5v3iIIoDzaCiZsklwTiKqvNcza8BCIMbUhb2MRWVKG+o22IXM9Um5+4lekA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6DerSeWNhPEcy/Bi0OCbchQeDSPDpNQOY5bvPeUops=;
 b=utnrY/pTPndGLX3NcoyY5HtH66dL1eC4t/MqMy5TnpCxPo44UbhwcVEXMTykuH0t+AEAn+DMihE+i8y4/vpVSnsEvfPssYoNC62UHP0y7w4F0Ext6geIh0/s0Za4oEKanJFvV+fpfQ4FlE0qCKOvi9QDmmi1KH3CbW/Z4P3e1jAXADxyTidBWhKaNMRxcHxY6s2I3vm5PC/B0jdAOSvq5xGlv1GdL/5C7IJshYd6Ph8wJR1ugyM/1iUA8398jp3exfk+1OQod3Gcs45fMo2XX/79dXTBNLgFIbAV1RSUghTMFQ+NuJnMb+pWXRgbeOsn5j7bCs04zLzguDk+9P/4vQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=realsil.com.cn smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6DerSeWNhPEcy/Bi0OCbchQeDSPDpNQOY5bvPeUops=;
 b=XliP43J/hR7J3kMTIxwAdI29A/vU71Fpf0ST+BXvbKXnqjjeKnFS99+nfSz+kNASF9JeSkeyusw8/IHbbOEjVYb1fVnmbH1lMdJ5/BoPSEk6V0wuJKMEwg4hjyYTyqPnWwmamIPYejVZYMQ20kf4m+N2WkRhsiTZ98KDOX+0cbQ=
Received: from AS4P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::20)
 by DU0PR08MB8787.eurprd08.prod.outlook.com (2603:10a6:10:476::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:23:08 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::25) by AS4P189CA0005.outlook.office365.com
 (2603:10a6:20b:5d7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA5LVEsXuXPfhBtmFO+/4SMGPMXwtHNOOhMXaGXiqqaAOn51ZRdRV9kZIRNFOEU8iCBPeqmdxB7nU+vAoxd9W7Q48NMWl03ZtlsKvhhJ2P7P9rr8SFnIVTwVUIgt8w81466/PMiadURNtzqA2G/5ThCjV+OHq02VxhDJwkmeVlWfD3k22CFzySkaeyrPgDzWfLvDpPI/SIRse0RDsKQCfEoZY1RQJnLVIES86CcnKruIeNY9Ue7vYCfTI88fkOmH568JxmAjrmnEQwE8PxLIWpzZOhakJgRlV60LoNcfEn2q+hu3Y/EddzQk0C9HCDTcCboQFpGueqgz+Ls1fYmW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6DerSeWNhPEcy/Bi0OCbchQeDSPDpNQOY5bvPeUops=;
 b=azjo7xxtyFkXUxR/db+ws8sWyG8IZpCT/piImtnfDWRCqUL5ByS4L9V5VligOv5AJ7tv/B8L6XJCVR8i8R7PuOAqXIxtjdoOdawkk6vX7HMHckz5QlykuSIFmRS3uJzHDCmQixuLkbGqbVbiTi4ROVR5eT+ce2xYxL9nokg7sG7QLGD3E1oPzAukYErQ2s0JbXOTOsm2IALLaHvp5bPgtN/Ms57hKXDPRft7owQPvfmYbiZsVLyp/ARCKo1ar1oeS0gpEZ2lNf1XSqKlp1cHCgUJu7S3cnRHJNbZWwIjGQLvl2mqj5zAFxlsKLT4OVJQhTO6qhQq59DoCH6042rm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6DerSeWNhPEcy/Bi0OCbchQeDSPDpNQOY5bvPeUops=;
 b=XliP43J/hR7J3kMTIxwAdI29A/vU71Fpf0ST+BXvbKXnqjjeKnFS99+nfSz+kNASF9JeSkeyusw8/IHbbOEjVYb1fVnmbH1lMdJ5/BoPSEk6V0wuJKMEwg4hjyYTyqPnWwmamIPYejVZYMQ20kf4m+N2WkRhsiTZ98KDOX+0cbQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB7472.eurprd08.prod.outlook.com
 (2603:10a6:10:36c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 14:22:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:22:03 +0000
Message-ID: <5705c9e0-da58-4c17-9f68-588f7e5e62c6@arm.com>
Date: Mon, 30 Mar 2026 16:22:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtl8169: add support for RTL8125d
To: Javen <javen_xu@realsil.com.cn>, "trini@konsulko.com"
 <trini@konsulko.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
References: <20260317072456.1781-1-javen_xu@realsil.com.cn>
 <c4a8714b4b294fae884ab2bfd2580b5f@realsil.com.cn>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <c4a8714b4b294fae884ab2bfd2580b5f@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0505.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB7472:EE_|AM3PEPF0000A78E:EE_|DU0PR08MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 379e4bbc-afcb-4e91-868b-08de8e67dd7e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: W2sKdDvd2PWPnmCa2K+JcsJgtjjmiONW0p64ZtdeG05fL23o0DBMFJ4O4G+Y50OJEvC6b+wLkXdFLmtkCRfa23EPS4OdhA8+jtCM9c8rFcr0HwX0uBnhBuuo6gxlDBTiLOqZ1fjmL06yZHNx+4HJeVyDbUY46lP0fZ1rommnIjvJirLxhTYFxHtZ7uRcHP80aDob90bj9AkFLu2NtzOBL2Gq/HW0550bpHeopMQWwwjN7PndY5SSiZLx0KMZduQuWaTyO2GINqPqfDHPPS0S/N7dqLdqKFPwR2Wrr4Yl7hRIYyshtqeNdKZdEkujZ2cqRt7KhGJJOg/pQGg/sW43oU69NAUNW/3TW5aCj3R/coJYyafJghIbyLeKK/3pjhYiQTHmv/KhFV0a4PDn+ADwNYkGIdlbAwSH3FsLFs6DGlk1gfCke5G1LSRgyAihgVIzdNJ+2HO7gijdrvTdvBrqp9ARYPxe+7wSiKlQ85iAb/Jgnx8JY8e5uPmaPAKkFMZElDpvLofM20/JwabLXU9peJclTPRVCNVGLKh7Vj8ELLv3IQGHmTf+P2Kq1xuEKIBkVuUpvVqYWdfalxMT1xYod2GO4riLBHBWSSugUej3fgG5dSKROGzn67f3SPLkRg8LvfufG+Br9aQHACj8LPqdgqOCcr10cqQCnjICQcTxrasiu/9vuESkJs2XBciRxPfR5ESMpgQzX1o4Yet7kqY8Zf9qjLsZNYG4Xftcwbn2Exo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: rM4bE4l8D7YIRhNSBL/Tr7SeiqBkd7mgCdK47+TBh6d2vsE6ZCGHLqMRbeku8Tc7rZk9DpQVJ9wUTpnq2mjExmZA5RJFku9PVvzvMsiTKPsnSunI//Bj0gKSWvqbh9qwy0vx/HxAMzUPRxRZGJvi4l4xpwByPUJZ7Egtl/6eRsTvJdk+EXsgEhs2vtbvh2Kmkf4O3ptEU3VSbUip061VP4OINl1s0v+vMyEtyNuUGtrmGhGJyc6fgSkb0+YXlxNHlQbL679G++fhl3LhyER3gxwtUAo171p1GUJRqtG5KvaM5vBeYtLridkHfqzo8XGCgDIFAYPTRdT5f8jeVgJIKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7472
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 585b3a82-1c5d-4f1b-ad5e-08de8e67b6af
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|82310400026|30052699003|14060799003|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DVxV73CuufL2L7WAkpdnXmm5KaYh7ta31dvG6CGod5+gZLDyocpCmjGVdgxhO1dV002CcTzdQeLkJCyZ+nMLija0vwA2/RzzKxSACKJFymLYKSc7EqCNzGf5OK4k3fXaEzdbHdWmly1IWxFhsBAA5MrLYNWFwZj/S3O8jX+f3xP+2IfZidGRbc2QNkgATnJ+t2/HMbfRYnQmOpttCVoUl6Sb4pRTocYBvF0Umb5PPhIlJ8DRDDsawgx7g14NX9On9gwRXI66wQM7+an3hebWI5SgD0G1spEDvAoWxpuA8FACLGSp5wKrCAtN6DrzwrNbu4EjLLbjZoPUlIUdPrppx0GFAsUDyQT7A4ePnzXRHTQf3PgNTfqWaW2jQPU46mdil8HNLzWGzaB3UDXTDg56iUgRsXHpwOyZmt6wPyz6snVP3PJLvqqFQcVTXz/Ujndbb0sYNV8axQhmqfkykHIVpoVIYPynNBnH10eAmqmMbZxljV8zUq5hl6bbqSnjSJQZ2JZ2F7vcRzzu9YfUP7UeQe0omrU18X8lIgmCtBHbTOIp+v40t1wIgf3IHSup1MXetGatoGlsUm8gAqBAfSySz7j5c8GqcsAtIqhMJrjFiYLlNB0gYxdJ1qS6VU9zdS9P7xN/vmDM9WWUA+AbZbT++aTmDXEQxqOrhGvR26BKi9jlWvJWzuV59MswkdF0NuVsk5TWdNleagqSGVU3BT7WNXAvDhloXQH+aRk1br5Zj4Tvzo7Grj7WzCI1dHpP5vsrVmAruPAcpgw0y6o2noc1GQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(82310400026)(30052699003)(14060799003)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OQ8YNnjtfhALu+Gn3U/iWbnUw20e7boA34r5ouzhK/NEv53FidchIKgg7e8dSdndoBMnQT+LCcDSOLOwAo3xbZ0FgQ8W0QE5wODKjn21RsQGhsPslzfqFVyWFJI9OTJr2+oqVHXbcTl0Et4dWKCu+Q+eJxDyLtM2u1HJ5csAeRan47aqvTa21J6RXJA4gRBxBIf4Gyhr/0hnk3n9psX5XGQ8plzCDiydQwiJtDlEFm5I9i52yu/WbygdzeFiP+Jq9XmotX7NCYPpDWfn4AxnQdQdnrRODJNa7OE5/KEUkzJgq2BjAawiDo5so7ZhLL2W3QA6raZ456jbiq2Q0bBTw7OPFZkeCkoC+2cuPEdvADrNk/t9RKn89Xa2bzcGlNKne/10iVYotGk4woBzfp/E+5/ThGpMqMYWiwxUsMlgi9g9UdQ9HYD0TO9DsodUBqib
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:23:08.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e4bbc-afcb-4e91-868b-08de8e67dd7e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8787
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

Hi Javen,

On 30/03/2026 11:25, Javen wrote:
> 
>> This patch adds support for RTL8125d. Its chip version is 0x6a.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>> drivers/net/rtl8169.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c index
>> edcae88a3fc..a679a64fea3 100644
>> --- a/drivers/net/rtl8169.c
>> +++ b/drivers/net/rtl8169.c
>> @@ -270,6 +270,7 @@ static struct {
>> 	{"RTL-8100e",		0x32, 0xff7e1880,},
>> 	{"RTL-8168h/8111h",	0x54, 0xff7e1880,},
>> 	{"RTL-8125B",		0x64, 0xff7e1880,},
>> +	{"RTL-8125d"		0x6a, 0xff7e5880,},
>> };
>>
>> enum _DescStatusBit {
>> --
>> 2.43.0
> 
> Hi, all
> I am reaching out to see if any had a chance to review this patch. I wonder if there is anything 
> I need to modify, clarify, or if I missed any submission guidelines.
> Just ask, no pressure.

Added to net-next, thanks!

-- 
Jerome

> 
> Thanks for your time,
> BRs,
> Javen Xu
> 

