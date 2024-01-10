Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF068C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31FE87AD5;
	Wed, 10 Jan 2024 10:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="YX5RKZfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0A387AB6; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CAB87A36
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTXi3gsgueaKzdv5frCOuOxhYDuht1KEzwVrj8lMjHLnbuKOPCn0uguossjaPJREPSnSWOnsyP29fQ3Wd2TypuKjGMwv0154+6VfQlOGtyg+m8JeIWkOV2ND/ea27bXFVhIKl+mFzamfqFB5VoQ8mGcUt3wg+3v0lohHD89HBxprb26tKz5sBFD/TtqjGBpP7o82DUGxzS7xrfSKoPGtFCMz94OctWkzcp/3Rt3tCvmUKBc1TT1IW7cirQaaYUL8pgBYXS5kktCPTQdopY+ruFTRqjyDTknVOeGsuSY9RktwItvDJS5gAI9hEBMfR8co/9VJTJU7Edifd4P7EGh0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0kdG3pw6LCGrUUYniTTbyKqDoX28rKk/TUhtvdVKgk=;
 b=LorlWt27i1GA3dMysKtYJop5kcseLmJeyYjiZaFNtSaUtu+9Su55c2ox8kGUeIQmYCUpl4p/w1ALIM7HHV82BK20EksuroHfa9CmfbvtG0lyyKzGEZljS8T1j03kvjveT7BfN0+BR5ey52SY+QW3Cj54+EX/5GZOGD1TqjjjUe7AWsnw2aI9mFeOYmD3RCaB/rG5SLiBTHbc1VmIeBYBVWvwXpwDypolZhogAkkK46BrNFs7VGy5ddN6qakE43tagLJL4D3SWaC7wp6NJUauJ4SnXs2m3A/RdUfW5fUYBOezd27ORSlKLUQreptMejD9YsnBWDIJDdMzcDiwmI4Bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0kdG3pw6LCGrUUYniTTbyKqDoX28rKk/TUhtvdVKgk=;
 b=YX5RKZfLtsxvkaU9EMSm/2aFOBSJTLb/5TGLF60BgWyfgl1eLIBCpwY4xFjNTseQwumx6SolpCKpXtBtlqtWFnGelpprA7GjqJjsm70SrR+0KhDyCbOxpwqlu2DZee4OjDkQ2Pc9jT06OKtxabH5vXDK/p5D19dbx3oW2pRdYWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:48 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:48 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v3 04/11] doc: printf() codes: Add bitmap format specifier
Date: Wed, 10 Jan 2024 10:10:30 +0100
Message-Id: <20240110091037.392520-5-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4a36b1-b57f-4ec0-6bfb-08dc11bc0940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t86s5CeKveD1qdnmKD/n2HwBZ9sQI9EX3Y7MhYKg8sxhbarV0zEl6WawbEFgFwGT0qbamIwitYvYrOzq/th9+O/N9n3IyNRifBW87R3RrVeGfbznIAryhhwTCY+DyDxZjXyx593lndQKnOBDT/i52109jCYY0oeFOPWjj05mZwdK0t58DvWPZO6NSqTG3QLFU83jaEnPudnMaRbkl/23wMr+bG8bqNT2RYu5Xggno5fPGqqLi5jeQDdVZiwIvpZMWG/vU8f2q7eZhhImaPq/6X9NBToWVRvIB9dJB3YJE8PJzqA5pjgRzkDbjYe1csl+Xz0OukOWlHCwX+D6SAEmTuXsqdjqDJlpCsBxZSEh4e+SrkC8SKuxEq8BtRM0lSjy4TnkSely4a9EgBK88HMN2zK92GSamBgA1a59p0D20J1tRWpzuwIeFQ1ESr25j+1Zsfh7NKbBZtZ/6+lJ+oM0oZ33nk8iC4g/Y44RgZLbypiPdEJivViNkk1/OwK+cC/gDlSxPplvfwMKn0Jo75EU4xQim8AUVJvCZU1p9yqYSzGnyWVq3ZzZGfef5V73hmY7XIRMJ5kbt+flvcdV1zWU6u6uSkUbc3WQ4sa7OS6YN1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(966005)(5660300002)(4744005)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPyIKIlEniWsnS0EJq0MhCSA3Ccqx84Q0r7ng6VFii9Q0mDaDsMwqCYR9zZ+?=
 =?us-ascii?Q?uWFE5KeuKNX9JM/VM/6bsbI+WJAXvlb3WZvNMVZAxhQWzDwkoEqpPISzmfdm?=
 =?us-ascii?Q?Uifhhq/CbArwMM55lKIL3vYq+dG2zeSigRRsocCDs7FJ1C2xrXp4THF/mM+U?=
 =?us-ascii?Q?01atB9jLaxFgN3YcsNj+pw9fRs+EIhDet1jwQ07bK3aHTIus2iKu9MBuTqap?=
 =?us-ascii?Q?NnEDctoQkJCCrkXE05tobzAVn5bZbDuS9OWuTUsFHfseMDLRpgyKXRxTaQ7M?=
 =?us-ascii?Q?vxuuVGWEn4V7EnKZ1f7AYz2s7989hd/CuhH40Ys0mlskCx9vV9oBCJ+EROaH?=
 =?us-ascii?Q?fjVVkpVcNAVJFFDRadhz/bYNxVhNEOfdyfYsSNG2VHTfgb81aAGr5m1bwkvp?=
 =?us-ascii?Q?9aT7QxfMnwDKpAsFdthC/mPQ/nTrw7s7e1od4NGJnuf+cUx+EVGtB5WfSAiw?=
 =?us-ascii?Q?NFpPkted6zmKBgsH+0HFYX9c7Sc+R50HINsu/JYfdjVNnmZLVQPCuN1ajvx5?=
 =?us-ascii?Q?iiK608a68ULiXNEv3CsWN7Hy/92UMbqfgxzJKN9+LJ4Ss38C+D3Q9awuI0C8?=
 =?us-ascii?Q?48Zq1WGJSRTI4cTN+SotMCvF2z3+2uwYmOV4uVe39mMtzTivYBZBg/1G0xlE?=
 =?us-ascii?Q?/NxHQZ8cQGUOee4Fsj4G2x+UyxanCKWY2EK+Nhvxm9WweY2hMAwirlMqm6Ot?=
 =?us-ascii?Q?4VBhOPKvyi04IsWjD0G9AI6/DL6+xla5HXu5RTl/hn78ndSCwdZ4mXDcX1NX?=
 =?us-ascii?Q?ZxfEtJeeHKfp33KvF+RD8ZBXfq71w/f8E92obCxtS0+0R9b0UrsyVELnVSuW?=
 =?us-ascii?Q?V+NtqPL9R91cUjqaPXE17p6EVoBcSKQrQPYHFJwJ6puNv/WGuyHzC+QApt9J?=
 =?us-ascii?Q?F8shngkEddSifLwQHKAbqYMODPx5Hutdb1qPRDLFZL0opEr2a/inSrT7G5D+?=
 =?us-ascii?Q?S5PtUjDtnr9DAE8LQGY0AbvwVx+Cp7pexzNXBdWQ8ZRjMyEXsxbsBrod/AdA?=
 =?us-ascii?Q?pN9XZABOXXj5JKktKS7R3011kY8YhoVkoYfdye7eW7Gouh4xYvotOC6LgjmV?=
 =?us-ascii?Q?zkn8f73UaBS5jttgV/3QA6ZBHQBP39QXS5fWCVI3ETOOjZei8h3ydGWEyqj5?=
 =?us-ascii?Q?ee/Pvu7MkIGZHnb0xNwAMVamc/sVCfOuYidTinAMaN2lK6zH/xp2vhaLz7XZ?=
 =?us-ascii?Q?4Em283c1LHfLSGUnCSNzKHatEBawj/2ZBSR5tf4aJHITnExFBhkjmadPj4TH?=
 =?us-ascii?Q?x9d6S5KKYbj/VHm0KW+ftrBgnC9LvtHwufVFG0X5SYp6N8/RHDGvXc8ZVwos?=
 =?us-ascii?Q?C7EI99sV2h1lu+ZKGUJ7q2kUb1PfkWq0L1z7O4u3ftCHd/fM71MeW3mlXABZ?=
 =?us-ascii?Q?92eipJgFuaPJi1nsXKnzOnzDeG4nC1x7FEakrEKv0rtVlWCssQwSLvKISXOZ?=
 =?us-ascii?Q?vP/jZ4AV9bu+/FafCJ8DMxvM3Sh2PpbG7EVT0JLbKdml40FJps079ALp7vsE?=
 =?us-ascii?Q?VWGPfMsrcGdv11v8QOpfACemTFUtmkLvFcQogDGeFmb/QL5wByvKLxvJsVUG?=
 =?us-ascii?Q?78s/9UtomM13D5RQsE44g76DJZQYw2nzvih4raR3h6DdpC6ujj/Kf8y83ABN?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a36b1-b57f-4ec0-6bfb-08dc11bc0940
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:48.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NZoVS9Lww7AA6CopBCXO5gLTamb47VA5dHGp/rI1ryKl6Ajx+vkL75y8H+JHM5WVEo/aqN+Xq2GXIglB+KMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add '%pbl' printf format specifier as descriped in [1].

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
- Remove '%bp' from documentation
- Give an example output in the documentation

 doc/develop/printf.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
index 99d05061b1..8220c7c12b 100644
--- a/doc/develop/printf.rst
+++ b/doc/develop/printf.rst
@@ -165,6 +165,10 @@ Pointers
 	* phys_size_t
 	* resource_size_t
 
+%pbl
+        '%pbl' outputs a bitmap as range list with field width as
+        the number of bits. e.g. '0,8-11,13-16,18-19,22-25,27,29,31'
+
 %pD
         prints a UEFI device path
 
-- 
2.30.2

