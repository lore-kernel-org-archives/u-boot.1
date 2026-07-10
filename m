Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98741C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 22:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B5A84A9E;
	Sat, 11 Jul 2026 00:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DU95Ysj0";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uX/GvmEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0572784AA1; Sat, 11 Jul 2026 00:20:52 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAF880517
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 00:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK5dVG584661; Fri, 10 Jul 2026 17:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=jmHzJMltYfFFp
 EMl0GUAVplU80OvpT3HSiqs1cMk8no=; b=DU95Ysj0DEIMzY1914E8QPG83a4Yj
 nnd46P38oDjNRzaepol5PbEze+CVAJ9nsBAZdr/shsJiU+StMl0+RvtVW8M5EfIW
 C2/nlHRURwQIm5pNDzY/xirMtgfXHoim0I3SZwWMYvIp5bx8+PB8gvuWHJzaZ1Jx
 ZVELXbm+nWWbRF1oP+SVdnkiyI+BLi1BAwQ7svyTXd8KQiY6DDadhy1BznTi2GMF
 DsmrkZKXgj5oRw6qqcvz96yddnAlIWPJK5ENqOiIkuAdc/8lBFyGWGD356WaymX3
 B4Jhu9Vn3PjXEkYw0PiIHMa1HFnnqIDPphA10Z+lPNJ40+qf/XfgKAq2Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fb0q5bfv7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 17:15:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW3AxiRjoi8QxEEQrQb3SVLX74V5ngxwUpb/bUJLinY9zqbr4K4zFy9Z/fB12jBMXpdvWRa1nE5dgHJclAymnn/5G0Ewp3Klyw/nv4wulDSn9E/kZq71zyBrc9W/OO5HgkX7flcBso8iupFtnb3HmDtFUFn6W3HHl+RqPl6MqI8kqK+EQeSSQGZyfJHGGVIeuTcfW8U/RDLjwhMKh10Lp54GyCoKnSrTu8OTh3EgKjXLoYjh3WIfmaUDvbP10hODe0x4IjVSh7rpcY5CIX1sIY0Ac+ENYhSYtQUzVRjJ6DkRMtqpF03+rSL/+MZpRtjCHKVuQlxB9L9V4dBpocfUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmHzJMltYfFFpEMl0GUAVplU80OvpT3HSiqs1cMk8no=;
 b=k7YTFOnvT3BFkc8hFIJEg4M/EzSZWtdczslLwishnkRs2R8nH9O7/SQBykx08bjDDhyhnz4/Tv+qouHtf2zxqc9aYZs3g2j/OEjsM2JDUFKxg0wayOkS6vTr9aeMqUBqUDTCCrdmWvNifvO9ol/u/Rm9ypm/ZLQCuntoSuE5xDr/xz5tjV8DEtcf5ZzV5dHxzImC48rj4VDYYyKkr307zrOyTFpSTXVVZaNAOEEXdFzTfxpi8cqUexhgkhEP2yys/3hPe3irYf79/VOBelkkijMFPllt5w7gaPT2SjQWFZMxA8uOf2uZ/ARrDyaOU68D8NOssPMxbszwE9XA4WvwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmHzJMltYfFFpEMl0GUAVplU80OvpT3HSiqs1cMk8no=;
 b=uX/GvmEW1NbY1dnOMCwtg+Elf8KV8FJaSyOzEHASj3HrIweKG/OceMc/6YWiPGCuDWWl9qSOihZBTbDytMNZfnTbzNQqqmDTECQqUJgl8wA+daEVWn5udGzoOxHMuhiQXWK3uP99YPBT7GmruCDl2WQ1O7pBwrSnWZaMpPOE17M=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by SA2PR10MB4620.namprd10.prod.outlook.com (2603:10b6:806:fb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 22:15:43 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::49) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 22:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 22:15:42 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 17:15:42 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 17:15:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 17:15:42 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AMFf0t4069882;
 Fri, 10 Jul 2026 17:15:41 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Jul 2026 17:15:41 -0500
Message-ID: <DJV8L3WDJM4Y.1DD4YDH3JEKK9@ti.com>
To: <trini@konsulko.com>, <anshuld@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Proposed k3-binman.dtsi and k3-binman-capsule.dtsi cleanup
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA2PR10MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3bf78a-060e-41ad-cad0-08deded0c846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: k+M+dJ8Eh1WDLj8ofmZuKqa4umRsG2xjEz2gm06Bh6WUWx9Zt8mzeEhPk/PCAz8KVvOwTm6xk89gWLO1LPaIegFi/QougZfT0aqVSMxJZr91wkSP682RWV8JJk++hs/7nAKE0qF8ljuMCne/ExAz5UEXfw+vK6y2u+htZ/uSW8RRfe6XjV8rlvwxk4LHAEunhDHrkkqrGLX+qdRoR1fYYrX5Ltca1nPcWhPW+1tZmw8vAYgnLU1CApYJX1yFKF+1x/5nAJIF4iaLH/YSfnHe7tDVgr1dmvZF5wiS8MSwGLQ5mEXaVdSWIJE8Y0T/BtJaZdHo7uKT/XmuiRqBMxra1wgqf/crtGir08lw0gJYVag8Zzly/JDmeXt1p01JaytDvNNccvsZ+KN4J2OiaAnwYAds9nJ2ffs+ynnYQYuNzXRJq3crqbnHk63gB3HMuP7vZBsHHfwVX8UwYycyp+eHsl5QMykpcmZxrPflhlhxrgyKiBsxRKOmqG8xvWRPYW+vBfQSp9kYNo7MlRrQBcGCymlGw47aG8/RaszpifsBkJ19N6DGFk/PJATfeLNsH04+r56Mb48Gl57tn/WrczJKOKDEv1x45OO3W6T8bqcL5vY6vlTbQ5BrDyIlN6wXaEqIQv4+9vBWwQ0IqYrVWXzktbAGv2/lsPLyxX4b8Az8w8rJtZ9S0yO4e0mhu3CHbOtEVKuSCOuodYFi6p9yXLKViA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UJHYyqZsrBhseBF3S+tqmKCOd9sg3Dwz7HaBFxQz+KmRnhbHNYZXdbz2dzE1KbqvbLPTTDhsbG9DRHv4/sF63PRkntU0nSCSPCvLjskBrcpVssdxk3UtbmndLE2m9djdyNwxU3y6ky75GXe7p3CnpmaLk45h5dreW1pn1ZhaJt2beRTTzIs4c5enOoP6ZHjxp0NMry6M0lpRv4hbvVIwAnwIN9FFRgoPr4a6Hn7dQFQHn8/Xc4dRTv1XlZUBg81vswnecWc4Mh9ZbWfSjGplv+NMHBRIdA0R7R3d0Y8pLtZXlgofVwYggeaVgeRuOw4xhsIF13yRw0IyV8Txd3PLjogECWBATS+fuQm5+6UBJbEHTS09QV1EhU1fP3QV+BhbThtHgqWQaZOMTPxWXv6C53H5BRJO2vqrzTN0prb/PCnPt5qr0caVRRgdG9H5Zc4l
X-Exchange-RoutingPolicyChecked: L/G0juEvEPZ6COwVDgc1bkNKov6N0BhEqLybqJppmtfJosxxy8aLawS25W3RvnJOFvdNaT6NEr94hOGx4plNofZtwrmTp3nyMD/5fux0Ijs7FIt6REeGta7wKVbPb9Pc0qW5mm6mx4rg0v6rhp1vqKeBa3P2jbAYg3Pz8KmKX/FEsUFd3Bo0c6xoXdWXU3PtUTIPjMS8lFUpgHcI5ldCUTY7EYv5tr/ByQ6s+uM4vsJkBTFlPAio6ifkpdyC374jh9+J9aoc2q428gIib9qoRgNL22D8GKwscOC0ax+FVwirPBynHMVJVDQ/H5iGgOyHQE9dVU/EcJuXYXryd2us0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 22:15:42.6629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3bf78a-060e-41ad-cad0-08deded0c846
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4620
X-Proofpoint-GUID: SBFpO-ARN71xezV2bpTtOGj4uRn9rPk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfX+JMRft9/gTz8
 5bclOBQTto3FZHX08z7xmBJr8i2jaVvVpyFGXfd79tNY+Xon6Dmg0LIVAYudqv8CyNDpr0Pqpkw
 NmS0bkkICs3H8eaZk3p0vt7W0AYKMEWG/tvqR8oNtHYedNhYvEiYV9h9XEBWHe/SrrMmeLezdUM
 M/qEGOYhAWCRi6dEfzjkdpym7Nm0qKmVna0DqHPQa0Iv0w9oVCWWglM/KDtHH1+SQr4p65xxS6g
 PzVVrsvnTv3CV0MdXIQhKK/3icU1VEJYGvEvgmMCATqMxrc4Zp4m4JFDTY5NjI1NCOTAEeltOXF
 8R+LefoWehOE19/hZWLy5P8E93KDPcvLzGD+TtJcY5k9sFNR0tQ4qh4goLN8r935fnJgnvGHu4G
 G++utxPj0YrEkWtmQEaDZsIVwB6XLOWwkpkTVMuvPmzYnX5c1UXj0wrsYeVPChoMUVV/18I8bKQ
 s+Pe9GssHjiaHfZsSZw==
X-Proofpoint-ORIG-GUID: SBFpO-ARN71xezV2bpTtOGj4uRn9rPk_
X-Authority-Analysis: v=2.4 cv=UvVT8ewB c=1 sm=1 tr=0 ts=6a516f11 cx=c_pps
 a=kwi3Ow37oS+QRMqxGNLpqg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=5DWQvO6lUqbSGnaopCkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfX46K5P2LJ/jmK
 /PsDhW9pO5/+yaPji5nE9DGUsFCXtTDniH0zIN77OT4MHngXoEECp3JVp54xvv46QN/n7uhdRyG
 2bmV/CpIn3EsX0SXyLXXAD3R/eMAL/A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100223
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

Hello,

We've got a device that's making it's way upstream "AM62Lx" that will break=
 the
current assumption in k3-binman.dtsi that specific binaries should or shoul=
d not
be produced based on the selected *architecture*.

Right now I've seen we're just adding a platform specific "*-binman.dtsi" t=
o get
around that, but realistically speaking it's not defining anything *new*.

I've got 2 ideas on how to clean this up a little bit. Wondering if this is
worth doing and if so, which way we'll want to go.

---

1. New Kconfig options

I've seen that sunxi-u-boot.dtsi has a nice Kconfig parameter for their bin=
ary
definitions. A pattern that rockchip-u-boot.dtsi has adopted mostly (with o=
ne
exception that's still checking the compilation architecture).

I like this pattern. I think it's very clear that none of the binman defini=
tions
are actually architecture specific, it's just a byproduct of the specific
device's boot-flow.

We could easily replicate this with a TI_K3_TIBOOT, TI_K3_TISPL, and TI_K3_=
UBOOT
(or similarly named) Kconfig options to remove both the proposed platform
specific binman.dtsi and the current k3-binman-capsule-r5.dtsi in one go.

It wouldn't require touching that many files, and we can keep a single clea=
n
include at the top of the u-boot.dtsi files. It'll also clean up the curren=
t
conditional includes used for EFI capsule support.

---

2. Reuse existing Kconfig options

Almost every K3 platform supporting capsules already has an ifdef for the A=
53
and R5 target platform variants in their corresponding u-boot.dtsi. We coul=
d
reuse that pattern and simply split the current k3-binman.dtsi into two par=
ts.

This would be a little weird if we kept the r5 naming convention for the fi=
les
though, as the new platform doesn't have an r5 involved in the boot process=
. I
kind of want to use "primary" and "secondary" naming since the split would
appear to be arbitrary without this whole explanation.

This also means we'll have to add this pattern to any platform's u-boot.dts=
i
that wasn't already supporting capsules. It'll result in an immediate line =
count
increase across multiple files and a rather messy diff.

---

Curious what opinions people have before I start shuffling files on my end.

Regards,
Randolph
