Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374F5CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6DA83BA1;
	Mon, 10 Nov 2025 14:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NjQNyA1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8A983A2D; Mon, 10 Nov 2025 13:50:06 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2FE839B7
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEPyJr7DKDGizSa1weqzgUxDNPCJd82J7o4AXyiFUx84TBUBxoq5eAHxZa08P1duMav1OLoaONTaZeFQ5JRYon0sXxeSyIj8bgR+Atdm2gMu9rGuSLfS8j+6oZfz7u84BsZ3bibjFghsksp7BQ9D5PZf2eLl6/RHhR/z1eEcE8SQUi7bmZ4SV8azMkf3fwncGQJKAz9nzatl4FvsrkkgSRs7Z5H7iU7SRi19rR/lUA9TiQaMywbzPT5v5ZmjjZA6GpEQwn57KSMcvcsYxTWXUEEZvNk1lIIGtBDBgX3Ajxib/NefdYgQgKf62ph5OPJhO7gdGWfTNKmooQ3QHHUVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noPlVEes4ILduKaEa2I+0yYbtghZns1YpPuJOicSBb8=;
 b=grNFHsA1bHrZgOLU5KQkeMcAd53GkR3BOqUP/fraPdJzpUM4zSxShlSWiXfJ+5aKPZfHBnyFvCkzQ7Z8OeROEDlk6qgMT08j+b0YL9mxcLf8LkXOKEqlQIr7Z5MfGyDakWRXilBIh+WVGNkVG3gd+3q2TnyXUgHlpITM2qNhpKWNMVtMnTCqOkTEfnDlXIOFIWxxff1vbBBksDCRdi+ubho6GEII1Bwin31IAPGO9pT19Hdh8eKnM2W9ExIHiGYW2OjUvvJoSu3dUuQlxsXMCZ8hBy1e3u1QitrP1/8pS/Y84IdjAHuxg4BGUeYYeSE4kt+ccKRwJQE6yKwZWMqAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noPlVEes4ILduKaEa2I+0yYbtghZns1YpPuJOicSBb8=;
 b=NjQNyA1ws4ZRYtf0NPkiLnD/2KKoTYVsQgio47o1evPhwv5pE8LqrkbkJW11DxpxlGfu6ldRAKFvL/RP/ghom2wgAzQq0SUZ1iPOcdP9qxShZmRwojidHXYjjT78Uz+pcaxCAGQEETsgJw+F58s3qcQt1pXWE4D1XLUf8vM+reXIAY1GplXhAsalj5nTWdJELKBpyR9PA/xC3MD9TsphZTu+g2yTftkN5Uf59zvKyXjigFFe2d9awJIv7Ko/jbGYmlhVeT+2udp52vx0AMXXTJ0z6cu4fw56xEIiHXv2qpGHsBr1KA+akZS6mNSYg84F131u7/170yKilhVVLyP3jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB10063.eurprd04.prod.outlook.com (2603:10a6:10:4af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:50:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:50:00 +0000
Date: Mon, 10 Nov 2025 22:02:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH v3 1/4] clk: scmi: Bulk allocate all sub-driver instance
 data
Message-ID: <aRHweXWNbXrewiBw@nxa18884-linux>
References: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB10063:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a38213-fb7f-437f-aa0b-08de2057a8da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQAIRQJKFrXGPkucuxPS8fYmy1vUqcnPC2cfdKqAIxwbGyHU2JaSf6tHoKuk?=
 =?us-ascii?Q?+bWYrAvf0jvZfLldMIVFoXXDDouhRyKHZeShlGgL37EulIj6CRdUaffkTCDy?=
 =?us-ascii?Q?iIvBneCd7HCUfNH/nR01Yh4JlkDzlvpPh4HI003Spm71j9SFEOrAtUWHu3/b?=
 =?us-ascii?Q?mSRSwL0xEKdsbyzaQvCrOUVF/hU99Qb+bYzuEBGcD2wj3/9W0+ZtkqEkNi0Y?=
 =?us-ascii?Q?n4jRm0136s/zM3bc4pMdf7tyYp3+QrpPoIjsvn00dY70abNIlYh4sQYlzCEG?=
 =?us-ascii?Q?nWlhqMxAuPEuRe4m9WxiyxqYRYmGsGc/u49k6HpYOQw9hA9fq8HF5E2nk6fN?=
 =?us-ascii?Q?YEplC5PjHZoCepL6WbrdYup78wSY421vQXRUQUL7rHkQ8IM+ju9ohtpMIsQo?=
 =?us-ascii?Q?sF287UCYyLG5xefBLM0GZcLVcdf3ZBt7eE/ZQQXeR05Mp2eypZizoIcO3tav?=
 =?us-ascii?Q?NpeBCyDV4yO7s6I3Qj/H9Z35WldjdTH/qQ1iDeusaDH+PKSoTJVH/Njwqf9G?=
 =?us-ascii?Q?MzwJenI+8smLphW9SWfErT6AlL+u5XsIR3j62U6P90Saovn6WX3T/BsPgIf5?=
 =?us-ascii?Q?3m6r0eHyweuhi85C8dFwFUSL1cdmQtHNssh/PgFADUOWyPY8o9iMUEbex3QR?=
 =?us-ascii?Q?1YGUCznUQ33KUWu6RNEV6SJDsSLuq4+C384HH0k83AkUTrFoUEm1I2tyngxC?=
 =?us-ascii?Q?q2dujbtrfeuS3HFw/SPxGUrGu6qifHEenC98Vofe2bQEo9k8xUib/qQVKCV5?=
 =?us-ascii?Q?5UVwfsn7b4joPB2jBhfXpJkVvWgxOlZBA1qE2HIkmugNBXR0zDsbrbZd7Omk?=
 =?us-ascii?Q?mwhNlla5GtAXjpx3HUEUPLTDXEviFR79sXzgnr5H5WiE0JSAdqrbQhLhSf+x?=
 =?us-ascii?Q?C3PHXbg3vpM64ig9hSXDW5NTUtFZplDUXa9ue2q3m06f+dtKeagaciIUz7/H?=
 =?us-ascii?Q?udMiVSGlE4F+vkmarTfcGT0za2RDXJUDntb9ZNwgZEdNEO1pwDV4RDS1rtSf?=
 =?us-ascii?Q?MzxEz103NYoR2xGr9bvWDt/WSkJwGsk7hWd6yDd2JK4sKwUFFAa0WmDpVgBJ?=
 =?us-ascii?Q?sDElCpD+aepfEsuoJrCvpGnAIPjjh59nbI06j/YYc+BeqP/C6a8FU2dS2ouU?=
 =?us-ascii?Q?d3md34oXwW3w6lF5mNzW1VZsV3zrrL75NsT52hsUEmsgiXbV+hrnpS7/Tb0Z?=
 =?us-ascii?Q?FdEyAAfgQQvYxfJOm1H0jYeOFiLb152ISEPbZSnsIxaCT7qQdbIF2kne6mjT?=
 =?us-ascii?Q?KVf86xsFCK7yvGSu3sX7o4zHhl8/xfe+Iv4OtLJwXD6XZt7d0MfHXVb3jxiy?=
 =?us-ascii?Q?HaoboxIYwRKdLjWvmhqTtaEcIMbalKAQa8fr0xOor/78TpuyGaDDo4hRrbMr?=
 =?us-ascii?Q?t1bSk1bimKUL4NoV+UgvldXM+JecByMsAFQjZdgOOvziUj0h4tkDeDrTsr6q?=
 =?us-ascii?Q?kKbdr5F3K4UtgutN6oNXNq66ljOhMtucQP3Mw/GYYDrS/MsygLF6neRo0Ieh?=
 =?us-ascii?Q?WeDM5O2y8VHwrrC6hYNusT2Aq6EQgf3Yw7e1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skLur7yDOMCSzu36sE7ckPzNN1fOq+gYi7lxYOQalMHdWaijQ5CGidT00JdZ?=
 =?us-ascii?Q?LUZXn+h7NYareo62nkdRTGavoo9R6MwMQZkcGOBgWITj/fDP3PQvkGab/GeT?=
 =?us-ascii?Q?/oTbcYdJKm0zE8bZeKFLy+YMMGfORbq7mOBj2+IbjmWlknpLVWiaV0Vdzizo?=
 =?us-ascii?Q?w6DdwmIjwswMF0+WUD5uTELEYylvvBG0lBnjjPZ6c4uY/ZVjI28QmC1A/Hs3?=
 =?us-ascii?Q?7QeqpusNW7LZouzRn8f7dgRuxKGW8GFsqS7wGz4zPXrA4ytlOekKjN4xgGVz?=
 =?us-ascii?Q?sGAfyyGpjDvKtOBGBsWASaMr5XlgguC8rew+gYhkuq2VilSgt8B70vD80vam?=
 =?us-ascii?Q?zItFkWJJFLS+tyHPIk9ibHEbqMv8BIC+cmce+C4Ve6Nq44P5KQexfKipSeYc?=
 =?us-ascii?Q?UyxSqAgQbadQeqU5vTumdTJwjRciIjTlfGT+Bz2fafCl1Op1ae/39MKRa34m?=
 =?us-ascii?Q?NLeGOQASbC84K1PBiNZPR7qRv3+x+WZdiVzTxWiycxy1waUy/bUpTG9CnSDM?=
 =?us-ascii?Q?YZM/JtMtm2MdW6NDLMEvMq8C/G/9QyW29SWGN5UYcQPvcpgd5El8mUH0kWb2?=
 =?us-ascii?Q?XwYyXzqYmgGCtXHWp5oG1otyVyqGUfjg40JzPddWk8Gq5qxWnvG1jQnbTE8W?=
 =?us-ascii?Q?kWlLxQStPiFV41huOJmDL2PLHelp4/J3jw5Z4F/f0Mv4Zc1AS72QnC3TQiNV?=
 =?us-ascii?Q?bIsqbFOdZSETkNtwEkcouOwp7kkSMGANIR8uw8vVgcNlY9wAJi2PCdJ8hSun?=
 =?us-ascii?Q?44wetgMyeqTKEs26OL5taMLYhoGELnrzu/YTvyVfPxs8CUkCOqCb9pUs0iTQ?=
 =?us-ascii?Q?9F/Ro8i00Yj8AaHNoLQWZKrjqJO547T1t8/65maKqGoo+h7uvZRNcmU02b6v?=
 =?us-ascii?Q?WBD0FAB+orKeJaFk0EkI6zT6GNsDf9q7WihQi1rSCIPoUFespsoFiuzwsW0l?=
 =?us-ascii?Q?u3aCmFtIbzLhInBsZYcHuq5qK5QaVEB0Bv3h8MB1lXUTRnFhC+FcdO2qDMmZ?=
 =?us-ascii?Q?0Jfw1yCQkK9fdbnlXFoq21xjtBXdDsvhaLIRc4V3JBBu9L7L7pouhdbWzamK?=
 =?us-ascii?Q?QghGK7NYFndOlSBviMbXvcB0Mbn/F8TWMXHVYEmXklBf3OxHvBhZF/Gi0FDL?=
 =?us-ascii?Q?MhNCOJHS7RN6qSVHDa/FYYdwfw004dICN0NqOOb/1qSQxbJlXVt8J3WQti8F?=
 =?us-ascii?Q?EdE5GAlEyihYfBh0s4u1TSkrmkzNgoRO3ldxMB3Hmu+Bih4/3M/c1UJ1+BAr?=
 =?us-ascii?Q?T7yvC1SSPuFeeTLojZ016CEw8oO50ISTFHkjhCKWQmS+dtk1d7FWX7FuoOoa?=
 =?us-ascii?Q?r31dQsvw2yEd1l8pONxJxdxwfaRMO2Av6C/s7+C+g1iB92sfr5zh3Xo3B809?=
 =?us-ascii?Q?YCGYTjqY05s9+Z6JLPGWle2JH/Phpom1w4HVC6Hz8RijWPgFKfAwJw/GEdbe?=
 =?us-ascii?Q?tNOquZmwyAH/anOa2ES9RkxhDnqByQ5MRfTxDEotHBGUoSLKzi4VpnUBXa+0?=
 =?us-ascii?Q?dLgBMJihA1uJk1/MczRAMQXKO5RDUrhG0gdingcb9OkUeJbHrJjB/Iud9gzi?=
 =?us-ascii?Q?yAWIpQh98784soVGyg0xlE96WV3xR/D0o5Zo0mRB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a38213-fb7f-437f-aa0b-08de2057a8da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:50:00.3144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XE96NyJNQ5+7uiGIreCnpN9m8NdOqsJV1lQOEigJMWQj51g5d5PYmfspou/hkStFvobkm1jzTd53UAdS1cukA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10063
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:11:49 +0100
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

Hi Marek,

I have applied this patchset to fsl-qoriq/next for CI.

After CI pass, the PR to Tom for RC2 should be soon.

Thanks,
Peng
