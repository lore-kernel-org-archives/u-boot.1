Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882BCD6DDEF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 10:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B230688E50;
	Fri, 15 Nov 2024 11:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZkZ86aoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF2588F28; Fri, 15 Nov 2024 11:41:22 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C6788E2D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt4jUI9TRS91YYHbsMbB2bmXEcuns1IN+zz/zYLnbfwRRPyw+D46ZYMqQCFJ9YFpo2mhVTFURgtHLft5CX6bYPma27VWySa76hASHWchu3G4nhC3b6Jt1ziTDtdg/Uw5jw6MfknY3gano93Q51d73KzYa+Zw3sZr2THO7vF35/eE75kyMdrEN8HXQGEF/oaI8N3jzqyw0LcL+dC2Jmh+SndlA4ijRO7u4BhNOPInwSiCeQM5/fxy5pJNbwJOTlOvIt0nNw0TnfICZQt1DpV16BGFKemAYizAenTGijrDrMsQIUhSSnBua8IOSlQL40SgsQwBQ15AAO8+d8JGy7w98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsaFqW03433E1Mxqu6pKBSJhdphbpB7Kw04hLFFWLL0=;
 b=Ft+wqMZ/3h52nL31LAKcjMJtQIEaooZ2YS4cNu5xbEswgdW8+QYTo6+YnTiCRzQ5DgLa+l1Xeo3FB7BvP1FeUNYGIo2dRvvKFS7XreZSgRwoMQluJ5DFYF1kVu4J6rlx3RLdvVz9vYc/Ax2m2xRt1moxUb1MBFRBgDmwgEKed1Ngz0ob8tNw/ygwNxFWrfh+07UT+1OWuXwJkwBkeYVdK97eC/9xCjRd/lCq80qGiEynJc/jXgzqRmtmdanKev6cLZ0lEAhDLzn5XKLgJm8bg9wGgPBv7rvE05eVNxtuUa4fWF8i+rvrbtprdfOxkDloK3dpdZnkeJOx2VhGVwnvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsaFqW03433E1Mxqu6pKBSJhdphbpB7Kw04hLFFWLL0=;
 b=ZkZ86aoZ2PwZ038C5RxMlRLsVHCoXDIVVWt4zvdXD/KgkftUiswnQqPUpsytIH66osuj6neolU3XU30oSB6xd5p+xCA2GtBhEeqQ++uSgzFPhKY5XYE27+DpNjiKQLQyaexbQg40iNwxjA1lveljJhbonk+7ZYTkvJKrUsq/T74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DU0PR10MB5335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 10:41:18 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 10:41:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,  Tom Rini <trini@konsulko.com>,
 hugo.cornelis@essensium.com,  Simon Glass <sjg@chromium.org>,
 paulerwan.rio@gmail.com,  al.kochet@gmail.com,  ada@thorsis.com,
 Philippe Reynes <philippe.reynes@softathome.com>,  U-Boot Mailing List
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
In-Reply-To: <CAM=mAOkaHf-TZ1Xw0W6kcYV7G+9wCJk14svaiCtdt6V1KpVQ4A@mail.gmail.com>
 (Heinrich Schuchardt's message of "Fri, 15 Nov 2024 09:34:54 +0100")
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl> <87ttc9m0cm.fsf@prevas.dk>
 <CAM=mAOkaHf-TZ1Xw0W6kcYV7G+9wCJk14svaiCtdt6V1KpVQ4A@mail.gmail.com>
Date: Fri, 15 Nov 2024 11:41:25 +0100
Message-ID: <87ldxkn5ii.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DU0PR10MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 0640c50e-5ca6-4650-dce0-08dd0562093d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ifvUbHa+zmDXDgRDN17UtMvg/+36BJazSSljL86bHD8NbES9T0OTUCkzccoS?=
 =?us-ascii?Q?wyPEnhQzh4kRchwOK+mGF6AMysIpJc5+/R6I4hxVQedhZdqOlNGSQU1XgQmd?=
 =?us-ascii?Q?IcfPGFzCIOoQzAJwTQ5E7bsWnHdkMiYFbzqgbET3Qhb8IFPcevHt3GHi6HuZ?=
 =?us-ascii?Q?B9rTzXa2GP8wBI6o587st0N0QtQ3Cm1h+vJ8YDRzpO7QA0aTytpqWVBaxC4t?=
 =?us-ascii?Q?N2fMRurEubkUW4LR+gwVp8w/0GrOw06Jzm1y4ergYRGjPbJGFaGI8gllfdH9?=
 =?us-ascii?Q?ojoHQDVKubKftO4Y6MDBFfHGTGrx9C5bWdGdZgs6gXV/Edyv99+/ZfjimAMj?=
 =?us-ascii?Q?k2R9/5EgKOpI71+FlFE4AXXWt/qJJvmqe4rZE95HUVy6lJIfKwDFzif3nHKx?=
 =?us-ascii?Q?gDEtJEsyxC2QeVGdlC8KZStl3a7mJqT7Q6KYl3QfkhvgPEp+pt6U93jZtFTj?=
 =?us-ascii?Q?EXBK+ykUF4tgijKR0+ZqH+eKUS67iffHA6g9njFCSxioyizSqFkTHM0hIhpw?=
 =?us-ascii?Q?202iXF16mfoPL80iZtYiwdgeWjs7I+bUQ2I1QaJ+rpZjyh3JXgkJGINLiamF?=
 =?us-ascii?Q?dyT5pDgKF845H2+Vsuo2SgimVCAEyPGaeGKS+4pIUM2zUgEqS5g+t23JqM2F?=
 =?us-ascii?Q?5OW9ZuWb6iZHZbgs0z4tptmH6c4+8Can8SRfyQWn4PBMZqS803o8JKxRYZjL?=
 =?us-ascii?Q?my2LvxPtt4G72xSviPpJVM/WEJlB9lD4SgGzXKbBeihE3PZ8R2OAbz1e5iPj?=
 =?us-ascii?Q?vSEivvL2/Jz6NrpS85S5XLW0YnjhsC6gEfdQeSbH/ZH/kzPRmVpUhMh8LKAs?=
 =?us-ascii?Q?Xo0oeyr7ZjwzhMJIgskJmpvPbMDpMrT9XqX4OygKMhVR3CtqzdLXE879ic4y?=
 =?us-ascii?Q?yk4LTBVx6RNmSx1AIE+QL3boa26aoOezw/DkQJuochJ+vcOleEDQCUMO7BkN?=
 =?us-ascii?Q?Jv41Fv/KBzVIqd8C0dIzbGpTslAmfUFQnWSxtEZ9sS4KZaY8FbofIdmEODbp?=
 =?us-ascii?Q?afK+TfjZgPh7uzHzlsaUPc5OW+FQ8MVs5Ow3lykVhTYS21k2VM27THbxdGoo?=
 =?us-ascii?Q?WWQOYmzkC+7H0+k33wqt//lguNF1vW+2cVcYXuJ5Qp2aa5iqE5H9O3HTDtNA?=
 =?us-ascii?Q?a4V3rgGX4Ay4UYHDhaPmIwKZRb+ZZlRkiSb41K960eikSnge1YJEmOuJsd5P?=
 =?us-ascii?Q?mbayCKW4aIWoLEHs/UMl84ksNhqtbITlGuvVWMLLK23R6W7YPNACVFJJiNHU?=
 =?us-ascii?Q?/Y7zbyo08UKtBToOIB4TPTLN5BEt8B5y9tiEtnZ0bZeV8HZa28MyXSija4D+?=
 =?us-ascii?Q?Xc4nbWp9TKJc6P+K9Ih8a/9ieywHUNPKKc0KK5BQwssO64pvH9yWj5XUeUGv?=
 =?us-ascii?Q?Azr/yO8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zd//30DOsrtX7d2NYdwoOrKD2L0Qyv1XfTHrzyWTKZoFUvPvBml5z//JDx9a?=
 =?us-ascii?Q?qIs55XPv03G6BWhGAJUmWSl3IWvaW2SsVSG5pDmN+5Ew6NXqGBzJrLbp8hrf?=
 =?us-ascii?Q?1XvUowKun1wHGR5E5qJZYTNcRT3klFHWq4FtwNq5C8ceR2wmSy3yZgmMoa6G?=
 =?us-ascii?Q?zym9dFyA7ne1MjTG375o1IpK5E+F8mpcmm93S11JLFfVwYR8Rg8HfelZKGDF?=
 =?us-ascii?Q?xW9ObfaiGl0QEHUc5VgoBcIP5BLPFb2lN7p/v89UhK9a5MIJF2Xdducil7Ya?=
 =?us-ascii?Q?VkUbVUyhcipAsttnak6q3fSljuRTsX/mux64mn8gWGJEB+DqWb9g53zbH344?=
 =?us-ascii?Q?aTbC4nn4HBglDx95FX4j8TKOBVVsh5s9EKzeJpcCYpes9lbmzplAR8t+q4cH?=
 =?us-ascii?Q?227j/G2jc50mlCMAaekrtZombKH1HI5dMcz2gasS0o3sWzWJIKMY57RCJitP?=
 =?us-ascii?Q?OcXGa2ysFiXEJUX26VD/963C/sjZ3HrboHMunQLYpkKDHFkRt7G9Xz9XItMf?=
 =?us-ascii?Q?5/ovGTJL9Kr7TJhLPG3N6gweHlkB06h356J4sduRdEfal5sXHA4dZq95Y+st?=
 =?us-ascii?Q?wljha2TfCdnfXtoEAPB6DpKyyk2r3wGzTD7q5pz/SE1LbdZw/rWGu5Tw0zoF?=
 =?us-ascii?Q?hKiQThs75OSWFzEcrQ3+wkOofiVtFl9Lmc7wcLdQUP3ZEKBbk7mX3kbfwMAr?=
 =?us-ascii?Q?kZqeYX9B71tAv8PdgS/eJlHhK/bxtOJqfwa7l5SRr+Om0CSFX3gmXREvxmOo?=
 =?us-ascii?Q?39nQQ13CeAgkS2DOk/MBSfyCQCuSKoh/8wmEepyrpCRLU5P0wtQGBLapuLOJ?=
 =?us-ascii?Q?xIWkMWDLFYeUZJfDublYO7mq99npXUtY+BgImKeYiEMrY/iTVZLwfTfy9l7b?=
 =?us-ascii?Q?R+o48r7E4X/Al8P5aA1C3MwQGtHX/QbF4SZZhxh5g5R2EAIYlQVHl85gR2XA?=
 =?us-ascii?Q?F9yrWCdXE03XxSa7oFnrMtlChX+uigEhNNJjTNSSxeDxWs+F+qpX9SGyJW8Q?=
 =?us-ascii?Q?oqAOBGWOztui11Y6+K5wb9tovjR/PVuM/YaqfkdxNyKNjXEog7UuhnnDNUxT?=
 =?us-ascii?Q?ZxlXvVTqtOnk6n8PyRx7IzdmivrVWqe61Mi7M2Lxf4gDyEOPHFzSdtG9k0rq?=
 =?us-ascii?Q?zhcHLIMFZZ9rf8NS04nDsdohCcjkjsSp1hVr0oMCy5QZO+F62l6cHyEhr5+3?=
 =?us-ascii?Q?Ak3hfiHCwAe+V+j1QUb7AHy+j/2I/dC+QwiP/mp36C1LfCUAUfy4Lliy4/Tm?=
 =?us-ascii?Q?KYQhlUOaMWHBWNedSdvRKvgQPOyhXux2SFkXKfciZ/a3ogFrF0aq/Sg7r6re?=
 =?us-ascii?Q?zfVxN6JPteqow9gRQPWkqhdULoCZaZR3ikP7QioWXWV7MW00iiuyqG6dP4EM?=
 =?us-ascii?Q?F/XUBdhongk8+Q2IznkbLkL15vKmmFSU2O6sIgut9EvKhB0Uba9aS1StpUHV?=
 =?us-ascii?Q?wePOusE1Gy4BgK5K5OLLgMZHiHt7zTKvpBu5SMAE6LOe+saTmyLUfIsS4Ld2?=
 =?us-ascii?Q?xLllmssegoQUaswXlC5+4NgCxmWrmQZnLr4Y1U2MKshqVDhCeUmvXuxkncNe?=
 =?us-ascii?Q?FqvGS5ytzyTG5masEyeoihGitjIPkiQuUCgc0rwtv6ml7qPJGIYea2XBOZOG?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0640c50e-5ca6-4650-dce0-08dd0562093d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:41:17.8404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ntdk8PRHLEqFoPSJXCcAJv/aIocRBTjJOSTvC48ynU6hcKm3BZ4gOJ0ymAm9J5gbCTJiRhA5f+ai3SSIO5ofQnsLKp8VN2cunsvFggCQMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5335
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

On Fri, Nov 15 2024, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > Linking against libbsd might be an alternative on older systems.
>>
>> Or use getrandom(), which according to the man page has been exposed via
>> glibc since glibc 2.25. Or just read from /dev/urandom which should work
>> everywhere.
>>
>> Rasmus
>>
>
>
> /dev/urandom is not available in containers.

What container runtime doesn't provide such basic nodes to containers?
Is /dev/null also not available in those containers? Strange.

And how, in that case, would the C library (or libbsd, or whatever
implements arc4random) then actually obtain random bytes to hand out or
seed its internal state? Using arc4random() or rand48() or xkcd221()
doesn't fix lack of access to proper random numbers, it may just hide
the problem and silence some static checker that knows "random() is
bad!", but doesn't know that arc4random() might be just as bad if used
in a crippled environment.

Rasmus
