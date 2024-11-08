Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F569D5C0C9
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F178904E;
	Fri,  8 Nov 2024 14:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="o5SEifUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88B988F23; Fri,  8 Nov 2024 14:53:13 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B40638904E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrGUSJnQNvMPkXS2p+GDPO2g1v8l7TXoRRI2VaUkchMRb1DEK7eD1IdS2IyFf7nJsy6VmVvLMsfaZGhUCbjPKDYsDOGPBxNZHDQzGJu54wW2nOoYkoaoTF/sAr3CM8ecQlA789cu0nKK+WGYIX0KyEbgjKlRgo8AYgXwn6NvBe+O5G/VUi2ww+Es+EK5VvHBtBxnE8deSnduMRhYrSIAS1VuULwQcAWyHDnDJrZU8bsWwsB7PPaw7Pwqt8ZHF2U0CsYdD//uUqeJc85KH6m/tyAp1ReTGycm6o1sx276kW6wnw2gY81ahvVCQYurxFum2gY1G7//nC4svZqXjxOqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h7wNmz+v6fruPG8G/UH3qXdUvOe1w9x221o0lT8cZQ=;
 b=TSMETVhemPUqDDOfRJK+9/zksFi0Vlm4fcP8Cv0yhfh+pPmbN0LQizx5VdMWrcIzen7UsfPyLC2ML6t3jdFtyCk6Iu0MMhE3yOj3YOBbWeOZYAnNpUJsdibQXKZeyndB0xlVGcElFLwpeQ7Xh5YcAtbC9vXXBr4hKNzy9qlmmHhU8qafqxyoCXqXJIoHrVD6mM2HHS/FhTcnVldjD7EFh/KxMiHIEWwARQBaiGmozyrGeMvb5aHdWFhWgRfB0A4vludeD8tu2cqsabGkJ3+7AbSQl7WUp2rIa02mNTgEwJYKmtGygb0PdZsPv8TRRuGF/aZY8sWJTarIaA6BfJ0Exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h7wNmz+v6fruPG8G/UH3qXdUvOe1w9x221o0lT8cZQ=;
 b=o5SEifUPwih4sk3NIz1I4scxORjOLDjeCjvWWU4agWaUOVDnoUhl7dZbBQrZrnZCQPWd52ZTnsk2gNo0HGk87J42SxeT3r4btTyw3QIDwOvLJtrta8r1JYr4M0ii69hFJBzZUz3qWcFmxQ6lgZ4fMkVlDIdtfZfvMhk6CM6eTYNpLxXWbhOApT7uKjaAW9LHsIbKWDqSsdSA9reJI8PY5yOE/tY+XhatXUcwSSzFsfOfvxjBqMuzeQWVOF55nqG6OjyoJZ6joTeb8x9KlauoOvcsMztQRykKapLLe8snkgnRqN3XHCuZbwiof2OoB2u41iBQcmJoojYXFZfcDasC6Q==
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by PH7PR22MB3988.namprd22.prod.outlook.com (2603:10b6:510:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 13:53:08 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::10) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 13:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 13:53:08 +0000
Received: from f642ec5a18a7 (unknown [10.168.174.111])
 by builder1.em.health.ge.com (Postfix) with SMTP id 2599A613D;
 Fri,  8 Nov 2024 15:53:06 +0200 (EET)
Date: Fri, 8 Nov 2024 15:53:05 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] arm: mach-imx: imx8m: re-use SNVS init routine
Message-ID: <Zy4XwU-nFavp2lyQ@f642ec5a18a7>
References: <20241108111052.4-1-ian.ray@gehealthcare.com>
 <20241108111052.4-2-ian.ray@gehealthcare.com>
 <CAOMZO5CPT1o6Fba1HNLoAXdFrKNSRczmdRVTuBs+eS_DikcvBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CPT1o6Fba1HNLoAXdFrKNSRczmdRVTuBs+eS_DikcvBQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR22MB3988:EE_
X-MS-Office365-Filtering-Correlation-Id: 55123ce0-589d-4d34-3772-08dcfffcad79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8+2PyCZMSy7T/UJ+//hxyfnUwWAnoEjSSSAyFH/iL1TxzRHMwwOg7Ao3OEU5?=
 =?us-ascii?Q?vMrdQyLnwPms+cB3a0zo5eqjpJ3v23d/ujWZ2Mn0vPHfV9Q2pF52sr2xDx9u?=
 =?us-ascii?Q?ezz0pnet1lvj1DuKgvKDt5muwLKE5lzXdL5R9CdLJoLNTqKIypdyhK9OfBIQ?=
 =?us-ascii?Q?/fcPApJOkwsDmFr+JO2RRPL7KrpU2uQExyME0x8nbF+LKJDEWjv+SjycSL93?=
 =?us-ascii?Q?1QrogWKdanZVI2f3yitk6Te6nIIoLOTGhAwqucrVe3paLm1Wf3CkmCkyFd60?=
 =?us-ascii?Q?0JR/k91IOo/UTnbH9pr3Bz6AbUPf1AgGLCPiL6IPuu2CMWsnaGMu+qe4efVU?=
 =?us-ascii?Q?md8NeQuVozfoHXwIwNtGZ1BGakfIbj0Z8k3eXOqSVxNsKx0qOdmATgM+m3YS?=
 =?us-ascii?Q?aB+cAjwmLqqHJBw+Dqey9yKZXDtCN8HJTEOfimhKzPRNBBRfzAaYlGkLqC35?=
 =?us-ascii?Q?L6K7fSC2XSQgt2WLbyQxd4jwwR/SP+dlv11w9l/z2+ujyXDH8VhmEmsBupTW?=
 =?us-ascii?Q?n2KkMvL34On3eNwYDR/UTj+045c1hTrswyfenYBG8AT42VdxVpzUHucBEx/v?=
 =?us-ascii?Q?QJeAIOA4hTBZTJUQt0tE+DOnULXvxUHMB+55d4AKN1eLeE7z8+AxTpONFcp8?=
 =?us-ascii?Q?Q5aa0Qv1cW0Tt5IjxI566yYv7JaP1HVbgEbVRRgTGxltSfJT2aZ5Y3gljcgb?=
 =?us-ascii?Q?z6d+XjFrBQ75lUJcl7Bw7RjUxVjn1aA5dfVy/S6R8SqAQoRARpdAl7E9oE7e?=
 =?us-ascii?Q?sTaK2qwyksizv83JlIC/dcI9fr9Tkyw//c2mvdKlMcvRp7tDUmOGrNdFehKr?=
 =?us-ascii?Q?pTC0596fg4vpcDPYUXU2XJ52BLQs+GU9YuZfa2JhtcUCUVCCw9vMau2g5hM8?=
 =?us-ascii?Q?1Ljhsw6CutR0+PPeoU36BiPZbSwwfKCz2KwqaabyLZXUY3lUpn1xCpBB6zWg?=
 =?us-ascii?Q?Iu5ZQd6VXDvZcEJTl7hg5O0L/CuBwSTk5ctXCrMskss9QY1BgoCaPUameuUQ?=
 =?us-ascii?Q?4O8cEBlZPylWmtBuuVAdRQlxXX8u0lJO1NXgTShLy+6Ced0ZPeEcjPxI73F0?=
 =?us-ascii?Q?M3hLv6fgcgzVNhXzZnS0qMX0n8VobMAkVpHmu5QTNX+9HWugzREE4S9BZIU1?=
 =?us-ascii?Q?jKWThbn2aRMKk2gVHxIpBbOEbEAJ0HX1uEVwTpXakJ23PGhlOcdIMDEcREnl?=
 =?us-ascii?Q?kkWqNArP0+NxWetHnldSmKpsyuk9LXb386q5/rT6m7cCKMKvV0etsi/T427Q?=
 =?us-ascii?Q?X1z3IoKJXpp5Qz+HyTN1NvZ7CcearpcTXjU8EqPhBcpHc2u3CjrYqVwKV9ov?=
 =?us-ascii?Q?zuIAm8u4kCM7DQBdwEK6dxrhjWngEknUnR2yoL2/SNHuyiXuDx9tu3epz8Hp?=
 =?us-ascii?Q?9x7uoyHI86pC5yEPAQr/BH+/+uhPlRn08N3nnN291xjmrYRDwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:53:08.4980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55123ce0-589d-4d34-3772-08dcfffcad79
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3988
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

On Fri, Nov 08, 2024 at 10:50:38AM -0300, Fabio Estevam wrote:
> On Fri, Nov 8, 2024 at 8:11???AM Ian Ray <ian.ray@gehealthcare.com> wrote:
> >
> > Allow unpriv access to SNVS LP for imx8m and imx8mp.
> 
> Please expand the commit log and include the rationale/usecase.
> 
> Explain why you need to allow unprivileged access to SNVS LP.

Hi Fabio,

Would it be ok to reference 723f8359c144eb29f0fb07291f9a2294bd2a3fd6?

Regards,
Ian
