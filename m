Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF68CCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 19:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AA4849C5;
	Tue, 23 Jun 2026 21:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iIh4WNxn";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W+G0HFVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B42849CE; Tue, 23 Jun 2026 21:26:39 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E840849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 21:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NI8rM41748491; Tue, 23 Jun 2026 14:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=0N8Kc693yMoO/6i1Ik9DDyQDet4EJY5NKaJwt3Tmy
 Lo=; b=iIh4WNxndyn8mBWtmV5G78ZgBak+x3iSpZiKzXfwvqsjauCFkV1biqTg3
 gePG8dMY2uA1pGWo1gmZ3F835ux2P7n6//7n1qUt2v9jUkLqKWVWNdLV9msxWNb1
 JPZyKsM9ExrilhSlzwJcHKij7F6z3iQshuLjO5kQFU71n2VkelzezRBCn4/PHmxb
 6V1y13VeO0smNvCEUDGTQ5w7nnaN8+HOKUWsDLzXGOgMo0jtkFItIqEwBAzCzMJE
 fS548WblUtiTG7eJclxqooxyT2EDcMZCkx/9WBn+ZYTDsW925jtmYvMGxwIH6wqe
 CwNUubIUyViSYrrv5nHlt1//AIqOg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4eyten2ug6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:26:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3dPUTuRVz/XUW/ufsIi+DWgev7cJr8/xBPjegjn3kQsOG1cgMja5l+t7Az17/1TXwHZCseC12BJwpS3JRyBxrSUCZbWpHGW8xql5eJ/co5Ajoc4m38OZmw9YM7woshTfQBVOpLANmbw/6e2YjMft0M85SxuPBeH7VU0fcu9CC27d+ylEj1H+TyZmykTUWlOVNX/lP6GWbKuP7WhHRGZCMS1NSr+NN/y1ez8/E04ssOW0ilNe6TykJ1gNTgatWv228T7HnTQbYKWh4jyHbExA2ZkiKTsOQ5pQ8lgX3Tx/B+l2WgUGrdw/IbncKYff2R3OJ1cY5RLqXJx9J9Jo3ZCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N8Kc693yMoO/6i1Ik9DDyQDet4EJY5NKaJwt3TmyLo=;
 b=iqe0xuroEBQgl3x3st5g39sBqiQtROQ7lUaV6+kjhpltkqkdS/oibTeShn2Zqt9lBUO9vboTjiKAQZZcUTXS/gmSjitwaBbDo+z4J4m2hmJrCeWCI6e2R+GsETj7Z9oCXafc1cCMnanVhqPo4Oiy5DRmT/cJIkGTHs+UllQVNA4lRXjMD2JXpOmnDhIVDahhS22FWes7KC2cJB/EBTWjsgjMwj4Lg2920x4fdv3pLpWhgggQx9GexORm1die6Q65+FdXb3JETJruIpXpr3toxLhD/hkkyXyRqMp40El+le9VCFeTgqpqzpRLMXOjJ/oSZFyUEN+hz8YIgb4wqhE8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N8Kc693yMoO/6i1Ik9DDyQDet4EJY5NKaJwt3TmyLo=;
 b=W+G0HFVYGyJ1DAaDyjzVgTpBg3uenZ+GKzns9sIkeBKLtk38dksTFaBcAFcG7JRNel7oFyX4oyI9TTsu9AT2Ex2d5oSBPi0w9cAAGqR2Ybic9BfvFjjSb8UsAKvOEAnxzSZqbqkUKLv4XiecHroLEtTfiUbFx33MFQrwbWTMx4Q=
Received: from CY5PR20CA0019.namprd20.prod.outlook.com (2603:10b6:930:3::12)
 by LV3PR10MB8203.namprd10.prod.outlook.com (2603:10b6:408:284::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 19:26:26 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:930:3:cafe::99) by CY5PR20CA0019.outlook.office365.com
 (2603:10b6:930:3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 19:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 19:26:24 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 14:26:21 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 14:26:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 14:26:20 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65NJQKN42947709;
 Tue, 23 Jun 2026 14:26:20 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Jun 2026 14:26:20 -0500
Message-ID: <DJGOC6IRTWKF.2ONXRLRZWJWQ7@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
 <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
 <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
 <CAC_iWjK+ceFGMkdH0QmkDXcxu8YxD4uDr3dUgwpmajS8+pw9sw@mail.gmail.com>
In-Reply-To: <CAC_iWjK+ceFGMkdH0QmkDXcxu8YxD4uDr3dUgwpmajS8+pw9sw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV3PR10MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 08486c51-61a3-442c-2a7c-08ded15d5062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: extP5qJRhMBFOQJ1dIp/50ddV5xHTBiLymdOVgdRwz5Hk+DDrj4Ide2+Noi7tcQ/9gO4zUFd2v5oys2/4+O9ESNDR/0i49UOgw97VphW/I8/KE8ace3YcZrcDxrSVXE0YIcU94KoIdAOH3n5hhhmangG57p+la8C7w0+BBUJeYw3ALtjd0Xn6bRCSXu4UBYaRqRoXyPh4ZulMc/ahzXW7kE8xbDuO5YVEke59ME2IO2nzEVqnvc4iML8v4W11ZripLtcUURof3q1SsVmvnhqZLuu9kQcUHEVq/Nbf4r2eBXF7R4AKBjq+Lxtt80gqVYbWqdGA/vai7sKi8YOkd16zW/eGdfip2qHMIcmBjkv1GuV/djUL6xEjWr4dSP1WZry+SsowjS5Cb/U6lB3RZS2O+1vBAbLBAxk5hDsd7Ow3LJObcqH+Jbb2nNoiJU4FQ7+U1MGbJyYU7TprCym4enCpn0WH+1BVQuhl/2qzQ8dBEbY7avH//JrRKwPD4hwAKDuniXM28JJLeTyJ/Xo1sX8qqH9E/SGRQa/roiYYDbz5ygW0OUKN/BhLpAKEarpYoAWc5Z3hE343rnyXFI2T4omUZjr0lv3EgL7m8jgTOYMBIPp0AhemmzTbfYToMqTGHzEtib7KaXX6dLNEqAKw7idIKhVFkVprR+67F/icAoZTNs1aKinRV3IXn6jLZ+EYRS+qPZNXh6QzoJVJJl0Bb/SdQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61hKi45mLxxYamhdBXnHR5BnjKrygpRNuUniU10k1c2QQmmrRR+FDBDPs/XZe6I2pik3HP1oNPhdLeXcOTNX2oSOp6lomrrXBox1sEUC7wLozAAYy2eZpYUGQhHWPYIDKRH8SQw5JtwdTS4nYuNWLg0SK9mjT6VOP4BrXgR13rWkAl1vFG5kS3j8bSw//GLw1puw7AQVGVyvARnskvUT3KNkcLVpQAOdcb0jVG+6Ug8nv5EiOMVp8nmeWydYWP8oVqJ0WJn9GsKdS1Br5P+LNshpw8Ve+GtcQgq1UZ8odzHPvV+gNQLJS7gklHo4sfczbnTvZXx7EQhJAatnfU3gZEv4U/cQfPMrWIpMoGGUk6XkB8CKKc7d/BZB2kfwVkXenYiPgY6xNYeMJGfOHNrYu79UDk9P6oIh+GZUvuZxoiPqBxsb8rm0BIPNmMPTVJLx
X-Exchange-RoutingPolicyChecked: pRZGsFPfX0qoFbCYgJCwGjjfG68PRr9LfYrD7YkewLWKGuiYWDOG9iH9isE4xV9227w9Aa4DRlre8DbiqlVFc5T1DKW7NHGMxuYGoB0l+U+y/48TqCHPtt8o8o09L1OOJQYBqX8LF4UTtIjS0sktbt+e0RduX1Ao35YQcDWAO1YY2KKU4umdHlrstC3XAW/l5M9c79TlGPQt3yQeu2+P8zGUDHf/2qtj3IxLl2/qqaP9xHAHY2HUwrqvhm1sNvGAvCTgCWlgPq/M3eNDvGOyUZgwvkEIwtkUqgRjlkGlxbbxEC0l+FAs4FtDjKMVp1ipUvZASeLeNVW0ANKGSoPg4g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:26:24.3006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08486c51-61a3-442c-2a7c-08ded15d5062
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8203
X-Authority-Analysis: v=2.4 cv=eO4jSnp1 c=1 sm=1 tr=0 ts=6a3adde4 cx=c_pps
 a=H6CWIJr9C+/oc5/J52O/6Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=KKAkSRfTAAAA:8
 a=OfYIQKTzMWxIYJGcHMEA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7hrRq3jcmWCOWXtQ93BThO4kT8-Upz7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE2MCBTYWx0ZWRfXwXjZuZVVfzGp
 pQSuDph4bwrZXgka0zT5Jb49lOX7opcCGfO90zBXMcgNfg13a0kJj/zFikHpSES6rXlbhR+NjEw
 /3+BgLZY6CBg7cJhmQw5Dvpvc24KNW0uh+hEGY7UbyaGZl5bjMZ9UaxTsileFWfiHICGzW3RaPx
 h8WZXFEWpt2J5IthEU1WHELCS+XEJrQXRAfFD3U6OjXmCpzktA0zjKgrQgz1+ufe8Jr10xmtCkG
 gnN5eXisWmVR8MQ/54NHqpJJovQ3u+HCJBt02HYBcF5p/zoYNiTg7ySssGxb9mpnNwcAV+UWt1G
 tlBbBUtPws6b02W4iUFCiSo7v/Clk0JyoxlD9xajKnMd2wPjWn6c5XY0m1G1AtfPp6nQ8CljyEJ
 s1Nm9ueEeWg5yfvx5I36Q2NoMidN7Q7WcqezpYKL09m7a6d8JAqlEgnEUfZ/WLzWKssBPMFopAU
 /FxP/l8hJmQjvLB+tpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE2MCBTYWx0ZWRfX53h2Bt+HZe1b
 DCROc17upBpon2ouNnJ2vmu6hNgXLxHDJRzuqyNkn9dV5h5YswEDNVoodEeGV1sVlKcR7YwleSi
 u/qFsUkOX1GTXKNcE5prZZp8Z5d8HGQ=
X-Proofpoint-ORIG-GUID: 7hrRq3jcmWCOWXtQ93BThO4kT8-Upz7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230160
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

On Tue Jun 23, 2026 at 2:37 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph
>
> On Mon, 22 Jun 2026 at 22:15, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Mon Jun 22, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
>> > Hi Randolph
>> >
>> > On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
>> >>
>> >> From: Randolph Sapp <rs@ti.com>
>> >>
>> >> Add a weak definition for board_setup_dest_addr, as a way for specifi=
c
>> >> boards to override the gd->relocaddr address before the relocation
>> >> actually occurs.
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> ---
>> >
>> > board_get_usable_ram_top() can be used instead.
>> >
>> > Cheers
>> > /Ilias
>>
>> It *could*. Just felt a little weird to artificially restrict the usable=
 memory
>> because the stack just barely runs into one of our reserved regions long=
 enough
>> to break a dt reserved-memory allocation.
>
> I am not sure I understand this without an example. We always relocate
> to ram_top for now and that's why that function exists. I've already
> started to clean up the relocations a bit [0]. I don't want to add
> more functions to tweak the reloc address unless necessary. Generally
> speaking the reloc address should not be board specific at all imho.
> If there are areas that we shouldn't use they need to be described in
> the DT and the core code should look at that. I am ok keeping one
> function to change this, but not more. We also have
> arch_setup_dest_addr() which isactually board specific (look at
> arch/powerpc/lib/stack.c which is the only place we define it).

Alright, I'll add a little information about the specific predicament we're=
 in
because of this board. Our ram_top is something like ~26MB away from a rese=
rved
memory region defined in device tree. After the relocation, before we can
reserve the dt regions, we actually creep past 26MB of utilization. This ma=
kes
the dt reservation fail in the LMB path, but later the utilization retracts=
.
This lead me to find that some useful warnings were disabled [1] and other =
odd
things were occurring as a result.

We can't even parse the dt without first reaching into one of the reserved
regions. With everything using physical addresses we can't really relocate =
the
active reservations to avoid this.

To be clear, I don't even like the solution I proposed here because it requ=
ires
coordination between a device tree and a local configuration.

There just isn't enough wiggle room here when u-boot doesn't have a real st=
ack
size limit. We can't fully plan out a memory map ahead of time nor can we
account for this at runtime. Please inform me if I'm missing something here=
,
still fairly new to the way u-boot handles things.

Thanks for look at this Ilias. Hard to get these kind of discussions otherw=
ise.

[1] https://lore.kernel.org/u-boot/20260604155038.3182-2-rs@ti.com/

>>
>> Initially this was proposed because there are multiple runtimes with the=
ir own
>> allocation techniques that could potentially take advantage of that spac=
e. If
>> it's still preferable to use board_get_usable_ram_top though I will chan=
ge it.
>
> [0] https://lore.kernel.org/u-boot/20260617074846.84362-1-ilias.apalodima=
s@linaro.org/
>
> Thanks
> /Ilias
>> >>  common/board_f.c | 9 +++++++++
>> >>  1 file changed, 9 insertions(+)
>> >>
>> >> diff --git a/common/board_f.c b/common/board_f.c
>> >> index fdb3577fec09..d9d09ac94bf2 100644
>> >> --- a/common/board_f.c
>> >> +++ b/common/board_f.c
>> >> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
>> >>         return 0;
>> >>  }
>> >>
>> >> +__weak int board_setup_dest_addr(void)
>> >> +{
>> >> +       return 0;
>> >> +}
>> >> +
>> >>  static int setup_dest_addr(void)
>> >>  {
>> >>         int ret;
>> >> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
>> >>         if (ret)
>> >>                 return ret;
>> >>
>> >> +       ret =3D board_setup_dest_addr();
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >>         gd->initial_relocaddr =3D gd->relocaddr;
>> >>         return 0;
>> >>  }
>> >> --
>> >> 2.54.0
>> >>
>>

