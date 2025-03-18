Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475E1C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 20:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636EB810F4;
	Tue, 18 Mar 2025 21:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sH0FPNAo";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="V07ZA9kx";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WvkySeT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5CF8129F; Tue, 18 Mar 2025 21:32:21 +0100 (CET)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24EE81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 21:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Alexey.Brodkin@synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKCdwS019351;
 Tue, 18 Mar 2025 13:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfptdkimsnps; bh=vKvowAbtMs4mDltedDlxq
 AuTJNCYEO23V/HbELNcfWU=; b=sH0FPNAomRVD0mj1AM9YIUYQMMx1GhiF9xzNv
 c/xuyQHz+GpzuLjLuTgDYYIaumUcTCIYqfNShvoc+w7hBwJjORWNNhjXIA/IhK1g
 XSWkC4v1j0vINtftNXGHgpSzrQIGyoPU7q4J00DqQ/aycoGnBJCTTxKCd7nyUdKw
 DGn+682joiwB77Gyo21GuBJpYAXdm5PoDIpywCuLA+7lNqpb8kmGLyVmUnXCOafM
 mir10+cOZ/L4fuFu/zmmRSEHsS6PkDEhnoFR2y9ZthiigLTvtPS39it5R+5i1JWx
 oJW8C/Y4A4iI9uJqfkBNKMIOmrfuzHmh1JjYmYjJpLcKv/QJA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 45d86erfyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1742329935; bh=h+iGWWt9E+wz3l+0Yh5aWYex+JZ2VSnjemCBs0XKRmc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=V07ZA9kxNdK0olzd/PfbyL1ICmiDgUkmPmUuh0CBfPOOcKMeVw2ebHZpfXiRa4dcU
 SLIZH8AwZMrjklU+KAagPwGe2wc3WsNiBeHzto9Adls99EKnw9IjeqVLDPf0Zw7Kpc
 Qlr1zpUd//ztdkEHXoRTxnLE26zYKGOKxRvo7GiZOsIlVf+SSEYlzJQVgpd29jfPCo
 WYpjwwgjXzovaj98LceQYDwyZM4LQyOUhs2ONs7meLAkiDRYVOtzzve75TgatD87vT
 GSLbDrMMpgE+yQ2CCtdw4irGg/UhoJ4iRO3DMq08ojxfN+3VF9DWnM6vDvvZWBJwmn
 CIqrluCcWkdig==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com
 [10.205.2.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E43B840175;
 Tue, 18 Mar 2025 20:32:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com
 [10.4.161.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Entrust Certification Authority - L1K" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 63359A006F;
 Tue, 18 Mar 2025 20:32:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=WvkySeT7; 
 dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id C976A4048E;
 Tue, 18 Mar 2025 20:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lniWa8R79HCNSFdnRjonVGTbC1mqn6v0xxavIoACNQHdsZVaKRkJO1FgHajhOLFV2kiLr9bncs46YguQOLfzwgnidRbHBFtWZ7HmJ93bhWQ4tVSbDHihfkPaluo6KNJAaIPuh4CAucgdounJSdtOodVtX/Nq8eUG1vXbwu1DNuu+0W+AYm5YBjKx+JnFdAyuYuonCw14SaJM1HB8HNs8bUn0o7LNXkrtHQvcD6jgPjXL9pZjv5SiCwGg/qOL7SvItduMfyks0UZo305F8uLN3mZ1sz4IsZpmDxadDaUBGYPqFmBjtUxRPD5oGxO5MVHLPcnObMTn6aiOknVuOiCIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKvowAbtMs4mDltedDlxqAuTJNCYEO23V/HbELNcfWU=;
 b=vGQYkOxcPiP2lhth1ankqJ7IRIhw0FalFyapUVkkydUILmMIKeYGSy75eyQxz6f/qttYP9rd6VLqRy91O/GKAbRG4jeA0IQwvtQpoI7eWJ5ltBaNxoIDO3bu5Cmx171/0SAQ6ywNDPUYG4jy8EBXCEMZfDKbQXucx92PVpbnwkE8umiQkEeDx5rv4clcw3Yd/ePLqEDi2nZUA7WFPXJgwQM89v43NBJzcE+FdFyxLDizDvB/FH7SwEqoYSBfJ8q1LvsMiYNNXFpU7fV137KcIZOjcY7iv4d6NUa1sN/VWEEjm0AOjdxuum7/psHFIHmla635N8xA4qY4fP6K8QjOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKvowAbtMs4mDltedDlxqAuTJNCYEO23V/HbELNcfWU=;
 b=WvkySeT7y1Qqr+l6M4COGJQDI4rRZew4KRl+myad+afJECEiGYsDw9P3/yZxvKMWSfmtaYIvx9i+GjDY3a2NIExx7TubzSa8aFV7xsXquOfAVMNKeTfGrBO7PZmDRlaiDNVQIq35HiNHRVAnjUonN/F0vMwB745yBgN7qd0kYG8=
Received: from IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 20:32:11 +0000
Received: from IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf]) by IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:32:11 +0000
X-SNPS-Relay: synopsys.com
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Tom Rini <trini@konsulko.com>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 "uboot-snps-arc@synopsys.com" <uboot-snps-arc@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] arc: Rework Kconfig choice menus
Thread-Topic: [PATCH 1/2] arc: Rework Kconfig choice menus
Thread-Index: AQHblUm0LmqaqgmUOEa13NFTV68Z/7N5XA+f
Date: Tue, 18 Mar 2025 20:32:10 +0000
Message-ID: <IA1PR12MB611373A7B6C9ABA54EDC0DA8A1DE2@IA1PR12MB6113.namprd12.prod.outlook.com>
References: <20250315012923.399465-1-trini@konsulko.com>
In-Reply-To: <20250315012923.399465-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6113:EE_|PH7PR12MB6810:EE_
x-ms-office365-filtering-correlation-id: fe99a23b-e4c1-464f-880c-08dd665bf5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RkgLeD/kG0RJplKqJERfPk1GFJIvEFdlUjlofKyl0wxZoE+VFismkQ7Jg0he?=
 =?us-ascii?Q?BuvVlSiXxYoCD01Pt8uiNgtibSEzLPMAHuEjRbzuD7ClkejVuJIkjDIiuNDg?=
 =?us-ascii?Q?o/HWmL6QlsBtdJN5d52i/t7g6DoH3sdo5dHOj5jnQiMUU/58ewpfEoBg53xR?=
 =?us-ascii?Q?/cIxEzXwP041nk276lbVnecJQMC4779EzGq6X1zGsBPJpejWVC0flgNwH6Pw?=
 =?us-ascii?Q?d861Pe8Mtx5uMQF64yXQZRfdz5cphIC0XR2McTHAdt8OPBBD7PB4eH3P4OgM?=
 =?us-ascii?Q?+KonDyvqqiNW4GHvtUr8E5wdMCbBb6EgVymYLwU9NNmNMqcNTD830Cmxg/bv?=
 =?us-ascii?Q?Hd0XPewW0gZr5sNjSW9SVOFnqUikWPqYbz8rrhl7L7PEWZWKHjX+2pWhCutQ?=
 =?us-ascii?Q?6GyWIDL22/fTIG2zYp43dp5BweGDhK+ZfxoB/W/nGxN2RIWd+NiTfvmIvfg8?=
 =?us-ascii?Q?JzUD2PJfG05h/FooMOQEMPPkC5siMmaJVqNjwlL1M4DmBNGKB4mO+ralPRps?=
 =?us-ascii?Q?mtJL05ISgvfqIvpkiDAu07cslB+quTzFrQuF4WAOB8pDdVe6IjG0lOzcsOFU?=
 =?us-ascii?Q?t8pplC05rdqHysN3D346iVR1iwXGsL2CrHyW/Z74H19rDBJh0u92YogAN0bD?=
 =?us-ascii?Q?YlfU0Hv+nZ6CJVVoZpxDfvW5JMKsxjujGUXVbY9nvRBK49mqVPQjUWlk5TOt?=
 =?us-ascii?Q?z/BtKJy2kgdSael5xnZI6PQNwKpyKoczPEXENNiATtsAca33nN83mqn7dRt9?=
 =?us-ascii?Q?8k53a8r6Rspwt9Zr5nOaqY0K8v6UQMp96D4DTclh1rDbXsON4VoYHFkfb05R?=
 =?us-ascii?Q?mY/hWDvpeOB2zd6GF8+7HzW2pzaSYtj0ogAn/UGtI1oeBkZVq2l5gNyocBZ0?=
 =?us-ascii?Q?/vHhg/JLzigkhLHKWvNDiX1FNDe8Kt1zZdsW8PRbuBkllILoqa+gQ4tU6cBB?=
 =?us-ascii?Q?2aGyFzxj7xh1hDZvHyCtKvQG2sUxnvuz6enrpPeUe/yFbFm2Y5a4txChpPqJ?=
 =?us-ascii?Q?kCa3nuCL6TKmHB1wuxExJPYZ6zFr+LlfOAYDSyXYiygobofXHWqFMqpzlxUP?=
 =?us-ascii?Q?bCSiK/mbLFWnAthI9mxBN1Ai8IOv2wFWx1t0hzr/K8/6ZNXNa1WEN/XXa1Gy?=
 =?us-ascii?Q?ePiHn4NEi9W8HEwIkVTb/EwJZ3lCsZxZiztKnyi1zFpTxTtlnFWH1e5hCEy4?=
 =?us-ascii?Q?dHkD9sTCTgTx/w4LmYzX5HPUkZrUTjRAR7Cf8f5UPc7uxla64WknWfDw37GG?=
 =?us-ascii?Q?ILNN3EDdxXvfAeRo8powB5mrJwY+r7XRPAhNpSOFcMymJ+RS5n6mYczpH7t2?=
 =?us-ascii?Q?mIh2at2dlPOfMqeys+1RbDP6dxakAay308WK2atbRpH7KcV2i2B5LTA98nHn?=
 =?us-ascii?Q?AYvMfIFXMP0hUrGn1R5zM+FWrCPg6Fu7q9xNIV9uHvwEj7gqaz13xBSr0xoG?=
 =?us-ascii?Q?ypWSbSdNYclVg1p93/lUPVSOIrqRuncn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6113.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wlA5XehFS4HpbvKl62rRp35ebwOKQWc/yF9SEpPjAiAUtnbWrRcjmJP8t9a?=
 =?us-ascii?Q?HnT7chE2UjcyvxQOR8JDkWQ9QnelGIJJ/uabts0hHjWyHqwwIMr9Um/6VwgQ?=
 =?us-ascii?Q?2kebnwF3xnFGmerqD11hz8wMiuQoyjjM4H/dXM+NwfMrRBIH2UUGJBYeuEMl?=
 =?us-ascii?Q?EefAQwl9fceC/m/tS78D8YGITLqw3llb5bpwYlQvzBrCClQZYtTSFrKJ7dMZ?=
 =?us-ascii?Q?/uVaCo34+gcpvwGyxZ431ym0ldzc22XlfK8ByTHS1wsahdJ49r1HWPsqclfV?=
 =?us-ascii?Q?pOhQo/o2+J1IXn64l4g/Vy08DiiL9J36sST3iQqTHQ5yUQmnlqfuE4pxqVGt?=
 =?us-ascii?Q?+BS5L5HS4vaCVcYQ0JOZFPN76u8o2QIvkvdolJro+ddmnuM145AiK9+CbYhS?=
 =?us-ascii?Q?0R20BkJOGiWRvUmKL626ypN6us9uZ29Al/Yj9tDHYhq8uN7zmNnmc7ft/4mX?=
 =?us-ascii?Q?lc6VNxe7IFtS6HTkxk8QzaO4B8R8+Ib9Nt7IZbILPMMnwdOE4QGJr1uhBxxS?=
 =?us-ascii?Q?z+jP7UrbkyakiYFfJEo3KGqIHMhWmcNhbMiUElUndwztDaBiJaUDuru6WgcY?=
 =?us-ascii?Q?bJy+yJKwkHyrX7w6Aqf0a8rNnR81TyA2vGoFQETynP/b6/aUyFJFvYqgB4Ij?=
 =?us-ascii?Q?S/9CFwWJLCLaEkAq6AvygyVqejx1qzBNAWqXseFDi51qgHtrGRTfCoKAX9qJ?=
 =?us-ascii?Q?pBnXCrVG/V4Px4EvqDWjNMQvp9ireOIqT0uGX27GYwqChDj8pkQa1Ael4V1Q?=
 =?us-ascii?Q?GovddSKjXgbiDbwnRy8gBtIZRQlFjdNHcALGqFCMHqy6jWhgeZrW+HIPiJMJ?=
 =?us-ascii?Q?v3Izn8pdoQZts6LkqYNA2TXVywHaMiD4DZW95iZdkPP7zkYl0IxN6mr0jfAg?=
 =?us-ascii?Q?zzN2WovnU+gXjcr5bhyeUw6idlLSVcBpBytfNLmjxIQWSFP+j0LY31pQKpGa?=
 =?us-ascii?Q?nVpYN9J0CRRyjcd6GYZNdeaEblBKwHJtflPBYypKnx7VR7MStAHgaRE/Cksg?=
 =?us-ascii?Q?JKFZo63ugA64Y6S0nTlOqhK0X7KP15CxvEhlv+aGoN3bM2bzLTeBC/lC9qkP?=
 =?us-ascii?Q?Nm3vGtrr0I/gu7EXiijnIDV9QeSha4zFgoo/LFcO6AhadFwr697rOw96oHVq?=
 =?us-ascii?Q?bry1BDu+XmXDvFEKxU25CLoGbIk/Ue/AiGaNr+NCmeGxQmAyfEp5HHRHF+Qd?=
 =?us-ascii?Q?tc5NjlaK23Ujeug01/OJeBZaCVBltepRn6CO5bV0MB6MVfQHiNQTWq2qd03R?=
 =?us-ascii?Q?LeLXEfhS0AdbLHjRuY5NkUq27xEZ5mCVaHn+NggT+pVyaeJ8AHh1Oj/evju6?=
 =?us-ascii?Q?G4nJ/2pEWnVCYf+6mQ9tYv/afxohh+JqbzAvbyZ0afL9/tG1QL13VWK/QBHS?=
 =?us-ascii?Q?ERRk6ZWMgp3FsFkE187ueTAlT18V81ozf47HE94lE8pnMvgzWB3Q4kZo2+Me?=
 =?us-ascii?Q?qsBlcpXXn7IrnFWR3IR6vj9MIdkwMvwuGsWHJoqlrvI3dLCQHKCqawi11kJI?=
 =?us-ascii?Q?vTI2KpNHuP2u776xyHfTeaFSnanQn8+A3CAY5F9lCt2fsHue1cocq9Qge0cC?=
 =?us-ascii?Q?zdzpWVWX3nOC81dNBwZb+U7w3vk/wxUI7lMqshI8?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKYF901ZMxiD/YF8NKyAQ0HfC6wnBAJBGbgWFYSGaLErb6gOI7Pj3I7YhqbQmGS7cYTIS9DhcgrIvUjpluhCCoktZ9+Xih2KgDACRaUYQ/33RrPbkN8g3MNNosuoZPuwBhjtyXU1U6UzcQWqzP6MRkystcLV1CG2H2w8gzqsiQ06mTQBuICnTgyVSWp2Gsui3/FNQny9E081JQ9ynC+nqZUVvbaVTIYB7Z1P5ldm1AXeOdqb1BysiJGImLEJTmmoWRD1ToJkRm6w85QHu/SmpAE84mKrNEK9CjOBSlA1BnKnX1xmc7zFCNYeNFwojknFKcowovm66uo8tyK6nugecuuTSsIAimIDthUUDUKKllGV0W3c++4lDjfk0FoM6JkMZNam4vm1m3l6hqUK3050ZKkY2v7N+x32LiMEXQThRw29FHEu8I6xMbN1dYgV1QUj2W0gw1v3rkJWqUF7He+XQDtxsoHczQJ3S6LJXiczBrzERaGDz4dWAWfC51vpiqs/WMEMM/+sakBmRJ2uv+lhoG2Syw+N7YjA47FdvyYuHxzDrZTg6IVEV/ZVwp7Lc5SjKtpZtJcfVn/b0K6Pw1fY3UNUMSunw8GqMU4tcKAMJ/7Qv4RFQVTjTOofz877nlP39uZXg/3XfN7THPXhvolQag==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe99a23b-e4c1-464f-880c-08dd665bf5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:32:10.9677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLmCvLNGHu9ryl0zTYCyvqxpGggVtVfPD6TlZtOhKi//XAK7EyTARFlS16veLh5s98XG+XbbcBgxD5Tou0mjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
X-Authority-Analysis: v=2.4 cv=fcaty1QF c=1 sm=1 tr=0 ts=67d9d850 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=k-42gJp3AAAA:8
 a=jIQo8A4GAAAA:8 a=p92pRBko72cAWatojy4A:9 a=CjuIK1q_8ugA:10
 a=S0Mk3trynWaGryfCkNsA:9 a=g4hgJDrqjSzh6fKN:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: bjzo2D9HfeAnyoKF6PKryrSXHwy3pDe8
X-Proofpoint-ORIG-GUID: bjzo2D9HfeAnyoKF6PKryrSXHwy3pDe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1011 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180148
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

> Currently we get a number of warnings about using "select" statements
> on "choice" options and that this as no effect. Rework some of these so
> that we use "depends on" rather than select for the CPU, and have the
> CPU select the MMU version. The MMU version is no longer prompted for.

Thanks a lot for these fixes.

I'm wondering though if these warnings only have started to appear recently=
,
i.e. how come we haven't notice them before?

> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: uboot-snps-arc@synopsys.com
> ---
>  arch/arc/Kconfig | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 6ae66bb163c0..be9774dc2896 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -66,28 +66,20 @@ config CPU_ARCHS38
>
>  endchoice
>
> -choice
> -       prompt "MMU Version"
> -       default ARC_MMU_V3 if CPU_ARC770D
> -       default ARC_MMU_V2 if CPU_ARC750D
> -       default ARC_MMU_ABSENT if CPU_ARCEM6
> -       default ARC_MMU_ABSENT if CPU_ARCHS36
> -       default ARC_MMU_V4 if CPU_ARCHS38

Well, here the idea was that some users may want to override
MMU settings for their particular SoC/design. See ARC cores are very
configurable and it's possible to mix and match certain components.

For example, it's possible to start from a full-blown ARC770 and
deconfigure MMU from it, effectively getting something like ARC725,
but not exactly as some other properties of ARC770 will still be in place
as opposed to a true ARC725.

Thus we used to have a "default" which comes with a particular template
(ARC770D for example) with ability to override it.

>  config ARC_MMU_ABSENT
> -       bool "No MMU"
> +       bool

I thought that comment of these "bool" values will be seen in "menuconfig" =
GUI
helping a user to see what's that...

[snip]

>  config ARC_MMU_VER
>          int
>          default 0 if ARC_MMU_ABSENT
> @@ -172,14 +162,14 @@ config TARGET_AXS103
>
>  config TARGET_EMSDP
>          bool "Synopsys EM Software Development Platform"
> -       select CPU_ARCEM6
> +       depends on CPU_ARCEM6

Here we had "select" because this particualr board (EM Software Development=
 Platform)
does come with ARC EM6 CPU, and so I though that selection of the board enf=
orces use
of the processor. But maybe I'm wrong here i nhow that's meant to be implem=
ented
properly.

-Alexey
________________________________
From: Tom Rini <trini@konsulko.com>
Sent: Saturday, March 15, 2025 1:29 AM
To: u-boot@lists.denx.de <u-boot@lists.denx.de>
Cc: Alexey Brodkin <abrodkin@synopsys.com>; Eugeniy Paltsev <paltsev@synops=
ys.com>; uboot-snps-arc@synopsys.com <uboot-snps-arc@synopsys.com>
Subject: [PATCH 1/2] arc: Rework Kconfig choice menus

Currently we get a number of warnings about using "select" statements
on "choice" options and that this as no effect. Rework some of these so
that we use "depends on" rather than select for the CPU, and have the
CPU select the MMU version. The MMU version is no longer prompted for.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: uboot-snps-arc@synopsys.com
---
 arch/arc/Kconfig | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 6ae66bb163c0..be9774dc2896 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -66,28 +66,20 @@ config CPU_ARCHS38

 endchoice

-choice
-       prompt "MMU Version"
-       default ARC_MMU_V3 if CPU_ARC770D
-       default ARC_MMU_V2 if CPU_ARC750D
-       default ARC_MMU_ABSENT if CPU_ARCEM6
-       default ARC_MMU_ABSENT if CPU_ARCHS36
-       default ARC_MMU_V4 if CPU_ARCHS38
-
 config ARC_MMU_ABSENT
-       bool "No MMU"
+       bool
         help
           No MMU

 config ARC_MMU_V2
-       bool "MMU v2"
+       bool
         depends on CPU_ARC750D
         help
           Fixed the deficiency of v1 - possible thrashing in memcpy sceanr=
io
           when 2 D-TLB and 1 I-TLB entries index into same 2way set.

 config ARC_MMU_V3
-       bool "MMU v3"
+       bool
         depends on CPU_ARC770D
         help
           Introduced with ARC700 4.10: New Features
@@ -95,13 +87,11 @@ config ARC_MMU_V3
           Shared Address Spaces (SASID)

 config ARC_MMU_V4
-       bool "MMU v4"
+       bool
         depends on CPU_ARCHS38
         help
           Introduced as a part of ARC HS38 release.

-endchoice
-
 config ARC_MMU_VER
         int
         default 0 if ARC_MMU_ABSENT
@@ -172,14 +162,14 @@ config TARGET_AXS103

 config TARGET_EMSDP
         bool "Synopsys EM Software Development Platform"
-       select CPU_ARCEM6
+       depends on CPU_ARCEM6

 config TARGET_HSDK
         bool "Support Synopsys HSDK or HSDK-4xD board"

 config TARGET_IOT_DEVKIT
         bool "Synopsys Brite IoT Development kit"
-       select CPU_ARCEM6
+       depends on CPU_ARCEM6

 endchoice

--
2.43.0

