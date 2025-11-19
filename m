Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E878ECD4F3E
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A3883E40;
	Thu, 20 Nov 2025 05:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=sandia.gov
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sandia.gov header.i=@sandia.gov header.b="p8qnELdF";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sandialabs.onmicrosoft.com header.i=@sandialabs.onmicrosoft.com header.b="lwVvMYV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677E383EF9; Thu, 20 Nov 2025 00:16:44 +0100 (CET)
Received: from smtp03asnl.sandia.gov (smtp03asnl.sandia.gov [198.206.223.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD19802C1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sandia.gov
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=npyonke@sandia.gov
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=sandia.gov; i=@sandia.gov; q=dns/txt; s=snl;
 t=1763594200; x=1795130200;
 h=from:to:subject:date:message-id:mime-version;
 bh=0MqPrPUsDfGYmaKOx1r4wfJBli4V/p1mKT4t9sMDQko=;
 b=p8qnELdFluRQYvcXzYNVk+ir6OJmLkDO3gUu+9jJ79kPVOnxbgZ588gh
 PXkkt9ePFzfHI8hzumoa1VI5vZTHUzDwni1BKH0Dylta6ikJI+sLa7e1r
 GZ+QhtOkRAbE4N0y5LR1VR0vB25j12Zz1NJzsSb7CPX46QI4Get8kHjnL
 rlUb104/VTlvX4m0hIHUViHZaXNrTvxNnsau6M6PBaLp0RO0rF/DvD+87
 T8I82ZZ08o8oquyCp8A7MAYUnpi9G8aYELdeHc7+vVAzjORXBS6zAPj4V
 rH0zc+oWWdV7YIJ0ksUmmPqmck0E8yLE/c4X8BP2lSasnFLyFBfwz6v/c w==;
X-CSE-ConnectionGUID: rtjg1aqbS0+kQgNrSkjo6Q==
X-CSE-MsgGUID: zRjZn0xYS+mE/nGCs/4UIw==
X-IronPort-MID: 20241960
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="20241960"
X-IronPort-AV: E=Sophos;i="6.19,316,1754978400"; d="scan'208,217";a="20241960"
Received: from unknown (HELO mail.sandia.gov) ([10.253.59.5])
 by smtp03asnl.sandia.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 16:16:38 -0700
Received: from exch04asnlnt.srn.sandia.gov (10.253.59.7) by
 exch02asnlnt.srn.sandia.gov (10.253.59.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 19 Nov 2025 16:16:38 -0700
Received: from CH1PR09CU001.outbound.protection.outlook.com (40.93.20.26) by
 exch04asnlnt.srn.sandia.gov (10.253.59.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 19 Nov 2025 16:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI/eprdMdw4UhCx8ObjzszSSyIh4iSImLG8ynZrrfpes/lcqOb11oTht/J2Rj7j/sC0sgO9vZucY7Irr48yzKRUyBfirpkXZ3c7gjq8K1Xle+kMicrMbffBeRWF8uqiIDAt5+FC7AchyGsedj6J7IGHzuNObYIBNOlzd2NOEQTQ41neoD7RcjZo7czwdhs7WkjdVJiJCrHAdShzVVGANlK41aUi1QKPK/vIxazFCYM64eS2hs4CL0u6KCdw7E1Cgxz57F8OAixa7K8yTrvQk3GSjCBeGyFHTrFrsBTG9FzWtgPaSJE3ID/2LAKKRNHLezx6FklsdDCkmgBgpyCLMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kFwzn8IDdpQFqVXvcw5aJok7zoxzVK6Eb8LrpeEW9M=;
 b=dW/oUyEqxMFn2BN1jWCjOEYaItDkWsCM9bOCJGOlX/j1yP+Vx4rj3txnIn6ZCLsqp6evz5jDPmeUO3SFAvdjkJ0q5gPYgExNcUD0xk/zXAKISA2064Q53Uy3TDGu2f1f2xvqlL30GxDZRidRor3Tzi9dtLYt2kMWaYeebRstkGMtTzW8bwF1AvWMFBFthTXrVIRlQm/CJjhzamsv073Fx6lLJtPremlgX1A9RL4JaODcV/xw3WKHyayR4XzqYOD//pA48gixw6pNdF6cHryf5oMnMp8i48jBtkUpXB+2GWNydyWh1tkFbaorR91NXCnk29LJcvmvjdIDG+fUS2l91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandia.gov; dmarc=pass action=none header.from=sandia.gov;
 dkim=pass header.d=sandia.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandialabs.onmicrosoft.com; s=selector2-sandialabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kFwzn8IDdpQFqVXvcw5aJok7zoxzVK6Eb8LrpeEW9M=;
 b=lwVvMYV/DmCmCJMvJ1vZyDs5lrjDZjMBPxEmCGkTQgjzw1y06fWzZ7GAyMxUiQ5KgOM63BzZZr5hDFHWb6mHonJekdwktIUe00qvvkIeTmQGvl5aG3zHRZ0qYnQdzMPeuQP9WlmqSiyX3QN2j+q9DKkNokJj7qDkekXno3O1Uq4=
Received: from BY5PR09MB4977.namprd09.prod.outlook.com (2603:10b6:a03:246::13)
 by BLAPR09MB6241.namprd09.prod.outlook.com (2603:10b6:208:2af::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:16:36 +0000
Received: from BY5PR09MB4977.namprd09.prod.outlook.com
 ([fe80::44d4:280c:4015:ffb7]) by BY5PR09MB4977.namprd09.prod.outlook.com
 ([fe80::44d4:280c:4015:ffb7%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 23:16:36 +0000
From: "Yonkee, Nathan Paul" <npyonke@sandia.gov>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: tcp server with tftp
Thread-Topic: tcp server with tftp
Thread-Index: AdxZqh61gz4JvBHsSn2SJ7Aa8M7C1A==
Date: Wed, 19 Nov 2025 23:16:36 +0000
Message-ID: <BY5PR09MB49772032490F7E91C03B9760D2D7A@BY5PR09MB4977.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandia.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR09MB4977:EE_|BLAPR09MB6241:EE_
x-ms-office365-filtering-correlation-id: 3ef8629d-08c9-465a-0263-08de27c1afb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QbT07OSXzP4oQ655KyF2o8ko6PVA/A6g6IS2Lkf26xfs9V41/AUGLuV3rxGq?=
 =?us-ascii?Q?voXMdpXeqt9FTZa2C1wf5BmySFE1HtR9A9MjOdu06Pb5/npog0L+kJ7Xfpss?=
 =?us-ascii?Q?7OIfO+eHtzAZOxIVDpSSbM1W0+aCgLHv5WE0rlJJ23JVaOgICjzZnWsd6bug?=
 =?us-ascii?Q?OKTocUqQHCL0FCaGK1RRpo3EwDCmOzMiUsBkdKoEMLDx5+W2xRJeApRyNb7+?=
 =?us-ascii?Q?Z5fMZVy+2MpWjdbIyz05hN7QrQMFQYm7RzG0vqUFJs0+iJpimS48dlMrzV3N?=
 =?us-ascii?Q?ZamJ6DAD4QfOCb3g/JmQxPAH3Jv5OAUfK12fQj80X/u2bVZ1S2aXmG94KkK0?=
 =?us-ascii?Q?REG6SL1Ct9dU7Tow2Irfnq9lF/znah/JuFTH3cVHAcJbnALNPaFslnPaM4eN?=
 =?us-ascii?Q?DyiajwLk7Ez6O/1hWdrAX2iIjl9BoDzk+hBTUWTzjVSUptijWixTfw/ArYxT?=
 =?us-ascii?Q?BHHwrlXR2+POhStwx4Q1wDl0j6INmHg572TIwoN7yvOdsaKijeJOFikMMKrY?=
 =?us-ascii?Q?c1oh+jXU4Q96JD5AQ35BcpKxTT99H5tp3iJIpQAIcjQmA/eMwRXzYOdJC+oI?=
 =?us-ascii?Q?dw20sr+oJVdzdGnqsl3aLo8ZRu8k3sQQwvPxpUB0pc/7tob3vnXRPwVG8VfC?=
 =?us-ascii?Q?1WYJ3fb8IaRQEtiEDjb9h+DoT1/O5JTzAM/z9lnNDjMvVFEUaNeAn3M2a2b8?=
 =?us-ascii?Q?cbSgQDxVWRrH7FdfnsnJvCoNBFlQ61cnRIizCi5nllR1wQtVps9vKWHbTXRU?=
 =?us-ascii?Q?ha5QS9XcIIDUxsik+aqewDKDEKx+ZuexBc2UwhXTip9Cv/vkx8TIi9vhNHR+?=
 =?us-ascii?Q?g6H7UJn+0q/g6vWbp5VmYP2ElH0yCiVfdvp/9n6m22roOImShLD1N6XXRjfd?=
 =?us-ascii?Q?P6n0itzQbKF2z1uoVgf3qLBEuKPnfMh84my8BxdN3d3oQu7Uvty7ofZQ2l8j?=
 =?us-ascii?Q?jesAgjTJDmC7Mwi3VWpoRdGM9dO0huCm/Mg3CLjFrLjJ7aA/qYNZW9HqE4to?=
 =?us-ascii?Q?3FDJk9YMwzIliJNBx8hTZKWkg/aEcNBizNKHV4TfZOeyYbZqWCcLbWPX7x9a?=
 =?us-ascii?Q?9btk7BHVmtH/VAqTub2MZX5+lrYhdCRjpERUgtNMc+7+qvALOG4HEmPJTWeZ?=
 =?us-ascii?Q?6d+1KNHRdUYqVtVoCOtuobUF+1MmH+ZEnqDPoHYDw16K8kGAuvYX2QgxOmfP?=
 =?us-ascii?Q?JEdq6KBWrVtv8YB2yhVtStM8YMOwyuXXsQN6/vbGYHtHkxlxt8gnZFyqyaBa?=
 =?us-ascii?Q?l0ozLp9nZsszUHz45roQBL8ZZqAYO1fR6smDDE5D3PSNAGa6vLTIyuzbJYze?=
 =?us-ascii?Q?aybEPX4aZf1G9m3pp5BqIwBNQ2idSLoT2XfYrovM5gZmDXYM5Oxje8aHBC+2?=
 =?us-ascii?Q?HBmxo4acdwqHLPWzO5xad8Cv8S8MuICk8ZU/Bzbgd8XC+zxnVuhauC6DieYQ?=
 =?us-ascii?Q?uVqRTGBc49qhahksiXesIUDmsrHW48PXylpHuqK8AywxGpObCPizprN4sNyV?=
 =?us-ascii?Q?SC0QRSvKp51Gxk7vp6+Iikeiv1YkPkmH101l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR09MB4977.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(38070700021)(8096899003); DIR:OUT; SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6SNNtpL69CE1E3rPAIHQDU2LKlRT7LIHZvAEipjlNWMBHwFT/WCwpEKVm64?=
 =?us-ascii?Q?AXspMrhuOCkak2KB5KawuL7xFht5SwFhuql6dQDvMMwy+gEKCED7X9bqFXu5?=
 =?us-ascii?Q?vBWZgSvCNASl8Rrlk9EcEmCbf+kgv8F18fGxSn2BQmOoMdMLJG1ASH/HDOrm?=
 =?us-ascii?Q?fPC1iOnEZyzZdJT4i7SxSRAV0qludK9RNyVjR02YiehCi5RJ/hCrzabbdgcM?=
 =?us-ascii?Q?JgGgks1SkBecardbLjIoM17B4j3Sf2BoqLAeWXxHCXulAzXK6FxeBjrENwqM?=
 =?us-ascii?Q?AA4rgej4czJ86mluOK3RB30SzVsCN6PIdrTHzGzy8nH1x8iJq7jUzVXlPDU0?=
 =?us-ascii?Q?+ZINLqf5zkHyg7IhvczSNwUGiqGZRgotyHIh3sud5vwFoISxlL8OPoRw93Aw?=
 =?us-ascii?Q?NOfJe0y3AKI8i6x/W6rvTyzOoVr1siBGGmTWeJkS6h4BWZjt9jo7KcaypA9t?=
 =?us-ascii?Q?EuA28BpOu5+Fm4y94QxU7eXMsp6GDBG6DLHd6ACKQtqYUIOxLQnohQ/nAhOv?=
 =?us-ascii?Q?IAPTKfZ9WZbwZ7MRGN8zU1EC1YitAvp+cjRAHmOBjcfqhxwl72KzSdKIvT5B?=
 =?us-ascii?Q?kaVnpIAQrTe3AOVTyJKmqjbjapki4ROgifIu9DKCNqh89RUTm/1zbyoZsAWx?=
 =?us-ascii?Q?Dg8YLVDmuQIVSQLreRk3Rz/jLiMsnzAgmh30q8hikg2AxWNZtIpUcQphE6Xu?=
 =?us-ascii?Q?OQJ03mQLWWdrCv0aLnSgSGr49LcD9u1GGM+6PTd1DFxvNmpQmmYLICAApUpC?=
 =?us-ascii?Q?cO9hyHxSfo04E0cOJjA9ixvWYLEmXqL6zcT1ILLcQfk01PQUqY0Gfny9Moaf?=
 =?us-ascii?Q?BzFIFNlOkzWwc1FH1k7JHPrCjopNMkw9q/x+wQ+QJ4WvrEi9AyhhziOJ6HS1?=
 =?us-ascii?Q?QVhYcf12jRC/WykRqWulX4cV74UPphslczr8rgchsJBnl+fzivPjLamoUaCK?=
 =?us-ascii?Q?TrhbRBAJOtkqmjTW+tjtiBP0hZP3yPCBi3NhQmdzQIF1uptRQAs8Ss46hS8d?=
 =?us-ascii?Q?wvP+c1iWjSN+bFrOM2rFgiU0paeBOoIcSf063nNxbLW2RtQ8iXWfIz8IrFpU?=
 =?us-ascii?Q?ZADtQSveq2mfOyAx52azbFjmL58isyBM65PdLXILCykFQF2FCuKZMcYpk0kT?=
 =?us-ascii?Q?A8YrVX+9eqU64VCuW0mCFEC6mNiz0roQY+guT+IilQn28OTHk59VqofOMsxh?=
 =?us-ascii?Q?9lKplhzTx36YCQF619wLUFzCN5Xa/ErbRXTfEItJUQQJyVS+gO7CHZ1OQZKM?=
 =?us-ascii?Q?9kgWDEArASfe3SdjspxWL2vbxg13nKc1PBYCG/BvfssW9qF7yuzlXlZG7AiV?=
 =?us-ascii?Q?2c3fK6iYQXclKAWcmiSFzRGCIlzg8gHrqBpqxOJxvW1q4Z683QCzzNxQz5GB?=
 =?us-ascii?Q?UT39yfmyY+hwcBxAFyjBfJs85TJpsARErfpKsW0jtyXjO6ltfjnefqLdP6uK?=
 =?us-ascii?Q?ecZxfH6WnMZqa2lbDq6KyFIMCAE7HwH9q3V5GeByx8BCkaeAwtQ3t1fCy1Lm?=
 =?us-ascii?Q?i6nlaH32c9beYfkbiRmuUOWwcfBF1NdUtsVbcYgB4EFBxIyMueuX/ZbxXD55?=
 =?us-ascii?Q?QeMU29/iIVLLD1n2DA3+Btdg4DESuFhtAX5+SPm8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB4977.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef8629d-08c9-465a-0263-08de27c1afb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 23:16:36.3218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ccb5a20-a303-498c-b0c1-29007381b574
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR09MB6241
X-OriginatorOrg: sandia.gov
X-CrossPremisesHeadersFilteredBySendConnector: exch02asnlnt.srn.sandia.gov
X-OrganizationHeadersPreserved: exch02asnlnt.srn.sandia.gov
X-Mailman-Approved-At: Thu, 20 Nov 2025 05:42:31 +0100
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

Hello all, I am writing some custom uboot to run a tcp server to communicat=
e with our lab computer. I would like to be able to do a tftp file transfer=
 while the server is connected, but when I try I get error -13. I wrote a c=
ustom tcp server with lwip and I am using tftp_loop() to do the tftp transf=
er.
