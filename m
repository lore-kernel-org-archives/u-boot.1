Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B88C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCE0E4082D;
	Tue, 18 Aug 2026 06:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jl6ZVfY_kshA; Tue, 18 Aug 2026 06:16:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 737F940550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787033806;
	bh=cXQ4YJ5B/9Aql6jCfk/NVHdbaZ1zdNKmqVHgJT8Ef5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kTrSMACQUjNjetkfRh3U1K/rZnk7+iXFmsL2BVX28DeK186QvxgGm8JS4Z3F88+Ee
	 I2NfWuI1ZRw6cdGacBBklEvt65YL4ukHc1/d4+OBwCktoM5Zeop6RgzwdxAz3IusOe
	 i/PiPJ74raisC2utRTSW2fkoET9rOodo3lscBGtiDpDPhcJmSoKO8LrYLT8RqWVUE5
	 qXQUSM/IXiai/oYDIAxHzMHr1fPloeS9BG9Zg00wxtNtPgT9/UW13EckquuZ+Isdvl
	 rlU73pAYpezee/7R2rXlyo+eP4/+EzY+sf29X+uSpnaZSgSRF1AtmJ/ERt2XlKrUCh
	 osgGaOB9CdnFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 737F940550;
	Tue, 18 Aug 2026 06:16:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 132F52EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 111FB400C7
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUpUuc0uWAS3 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:16:44 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 954F940059
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 954F940059
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=BM8QM69R
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 954F940059
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE4r+KwIN9DyJtlrHENlYrGwyQsqoRfD4yUD7wkSJRD7rBJKBhbtSn8fwQkj+ootPtAJ8ywFUzpY+ImpTBwz9BSl4UOybNkvIkXIEESeaCQTO+0EbXVaBJ37nzE4C9MEVfXG5+kLxuj7J69difPvg4PxS7TeUOodhdAozEIsJs5l5qtOgQMHDafstFxUbJTKZ0odWdV5uLvSLjyd/0bps1lpmm6nQL+Jet6Ce5Ktu4YALmqQBnnGIUlRMqhqNoPJsPPMRCbQGhcDZMRA+XeRCoJWas4vTe4HuQ8v1b7Vcgvk9BWLagHIiFpsk67Q7Niqre6RrBgCfXOfwi6Ipk97Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXQ4YJ5B/9Aql6jCfk/NVHdbaZ1zdNKmqVHgJT8Ef5Y=;
 b=qWGC++DO42MdIURHi3Qcd/+31ibzCy5A0lXEl3XDnzQBGEMwNihtHvYCv21fh3s/X/O9X6hVnN8nVukf9tD9VnlOqGZSPZ1J0Iwk3vsnwtU0sz0kpJfZV3+ZbQvY7GHO/Gc6zy8lZh6o3GRMB8V4el5raYjwoYR586pTEYZUu4z61Xx/Z9LB8XbazQdd6OP3Mr4o03GKYQKqEz9FzeZB35XY3s/uO2RNDgBs/jSWNbcbYH4Q3dXpICGsd3KJovGWQqQ7mSIxfT0HCJTC5KU72KZpyqAGYLcNXslQ8+bcUQui/M29RkGx3/9iOZ4SsM2KNDDr/2JpsHsIffpSkEs7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXQ4YJ5B/9Aql6jCfk/NVHdbaZ1zdNKmqVHgJT8Ef5Y=;
 b=BM8QM69RQaE07xZmKq9j8Iac0TMWf7guEr2yJe668wcmL8wCkr6ho8qdM8AcwJyRUUU8KsDVx9xAm6ErdVltUHZxztGFr3/jStBHIrcGKp/Na0XI6vOAj3fdTyHMrXOoQXSsrtnyAAqjJCQrGaunf44sLW0KCmOmYtcBD/FvoTsYlS0IeMobon+zGZwavpLL2Llrn0Zlc+o399ox4QxTTXAJs/GCWQ4BkPeNPYj7K4ty1+BhCBEtY6ZuniCgdts45MHF72x/rrvFzNMVIKruXE4zcZ3sQfI/DPvQfUQogXlSgPa3WDt+fpZD3r87IigkCF/tN9bqKKxr9oyADgcaUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 06:16:40 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:16:40 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 14:20:13 +0800
Subject: [PATCH v2 4/4] board: imx93w_evk: add board support for i.MX93W
 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx93w-v1-4-2b1784c35822@nxp.com>
References: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
In-Reply-To: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: fe03c670-d1f2-4f62-2c31-08defcf04480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: DltPTgtS5PXI2o7Co5SAufZ0vsMtdFZiKsHcKYMiW4KMTGoARh4DBI6XqHGyPLzD+Z1V6mGZCEC+ovTVoDQPb4XkIBaqyTa9+kmNUu2z1U2cFFQHVhVF4FueJgKZHOkIwivqUIIVaDmf/F6Y5FfhYy4PS9I9fHtvHbQCOzoyE+16Ymhiu5gcTMi2H3NSTQV7DFDE3N1UYlHrrp2mTZY1LCxcRPV5Zv/tTZoYDvDXHOeBRclhBLQA9Uso22CMKcsuMe1xBKSdzpJQSdmV3CfLZC+K1ZCcQYKAFiMwiMjnDJeIv6O/CdxBiOjlp0491yQU9aSSBj3r3Xj7DHMNUaSHAp4LC+uSG+VEWrJ3c9/I6og/aLiCOHRE835AjkFqvbaWHCY3rLO4yzeu/n6BhX8tI7IzgqbOhGPhNk72dRhGRBDwzYXczijZ3cOt7dlhJMuqM23GI21FhmOjc/4uarmG3J6LVTtmJU1mYSN4+pKLqG0+rV5+0gwa8RmBeXuexBByjPuK+hEY0OIpx1oa4t3vMidTNJE39eAMelPl59cIxar4NEUCowuTIMj/JYfpP84XGv3wWkzY6eh7dskBkIrZjAdreHj896RNljja215x6xtnxkAq+Cdu0w7TonfDq0UGHlXAGJ7gLJMGygmMreUANLQ0P4rfvAwUYqruzutyL3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzR0OGphcFRkbkl5Z1I5NGFUakYycDRSeDdIRDZuaDBpdjdKMHZQWngxRWV0?=
 =?utf-8?B?K1RmVFZ4Uk9DODI4aHA5MVFPZkVxY1NybkpNcTVIb2tHZVJRa0taQ2RZenFz?=
 =?utf-8?B?TGRvTmFEQmZrZHlYTStkQWIzRWMxMTIwblVlTGEyV1lPK2R6U3o5eUZRVjRz?=
 =?utf-8?B?ZDVIN2FsbWcxU0R5UHlkeVc1OERrNlN4TGJQUTJVRm91cDJvbWJnck5UVFBj?=
 =?utf-8?B?OHhHTU5JUVFnOEphNEdkVXA3UVlXUExqc2hNS0ZCQTUvWUw2bFZJMlB5aGhZ?=
 =?utf-8?B?cy80ZXh5eThTVGpvcDBLTkEvNUtGUmg1SngzcEpHZ24wdEVXTTBKQStqWk1Z?=
 =?utf-8?B?SzFuMWhtM2ZYdHJpZ3BuTEJsRmk2Z3RibVgyT0N6cjJzQ1hjTkNqQkdBN0xY?=
 =?utf-8?B?dXlJTFVuTXpzNTJ3SkUzMnF0cldkbkFPbTZuNGtvNlhiVUI3SHVLVE5ESUF0?=
 =?utf-8?B?aUZiVzg5ZVgyVmFkSzZnaDFMK0pPdGxtb0xjNjZaTk40S1hYa3ExVXE0alp5?=
 =?utf-8?B?cnpIVCtpZ1dkcE5KV2NaR3FDWjlFVjhkaVptU2wxa2p1TE5tUWVleGdsdkpC?=
 =?utf-8?B?eW4ya3l1Y2dkVnhzL051SGRadjdqRm1zcHkyRS91MHM3MWNmSUFPdFRFR1do?=
 =?utf-8?B?WFF2NjVTQzlhdlZ5eElVekRRaWJUdU8yR2ZBVHlKZm9xU2Y2SStKUXd1aDF4?=
 =?utf-8?B?R25MZTJrQ205TzFFRzVEa1NCbTZMYm1oUHlMWTRnemN2RHRTVzF2T1hVZHlD?=
 =?utf-8?B?N3U0QTJTY3hKSk83em02RTR6NkdsclFxWGVGK3pTSkUzcklUOUE5eW8zSnM5?=
 =?utf-8?B?Y2V3d2d5SERiMXdBU0VkNEJ4aUhFNVFSUGV5d1BLMGlBV1RKUWhRK0x5Mmp5?=
 =?utf-8?B?WjhOYzhEcVN2cUQ5dFBNVHpNdU4zV2tLby90aHJvdkNhWjcxOS82RGpiMi9p?=
 =?utf-8?B?bTViT1AyczBYdjVUK3dZcEhCSklLV1gyMzNaYnpxZHhibE1McU1VMVNjUENq?=
 =?utf-8?B?KzFjUkxkTWpucWdaZ1R5S1JZVlRpZjhRSGxZY0pCSDc5N3lORTl6czF0c3Qz?=
 =?utf-8?B?WHEza1RrRzFUTjhpZEVmOTRudWpVeVFTTkJNUXBxQndoOXpDWFJUdFNaYWdl?=
 =?utf-8?B?Z1krREZlQ09wTmRYM3JGd1k1T1VXc2FNVFlpVE1TUlMzY1c0blRaWEVzTk90?=
 =?utf-8?B?clAzRE16NDhmNXZxVTg1SnhqZW5lN0lrbjhiMnN5b1crcjdSdERZbERybTNY?=
 =?utf-8?B?TERZeGtSWFN3RFJNWlJuMHE2Sm1Xc0FEN3RUZFA4UDhBanNuMjl4UERFR2pK?=
 =?utf-8?B?RUcxSFRoZU43R1J0TXZyZjZCYiszUXpuVnB5dDdLUzJQYjlKa05IUmoxTThq?=
 =?utf-8?B?Q3dyV0lJZCtNK0VXTjhVaFVEMGxPdk9GU0N4bWUxSXM5TkJ4d3JIUXZLeTJi?=
 =?utf-8?B?RXlhSEFyamZSRXhxTytRNHdVNlhCdURuSmRQNk5vQys3ZFI3L0lncXlrTDlD?=
 =?utf-8?B?bTNxQTJwanZhcitkRG4rY2VJK1IvSTRnUElJWDNBSFVyTjFCK3ZZNk9SWGxz?=
 =?utf-8?B?RmxxdTZWamE4eEJnY2l5ZXgwWHkwNms4amprYTdvbTNncjgxd2xBRThQOUpU?=
 =?utf-8?B?QzhIcHpjSFNQR0NVdlVQK2c2MHRoYmZKY3NBcmI5dDcrakhJMnV1Qmt1anVt?=
 =?utf-8?B?SzU0ZklvaDJIUCtIZWtsMExtZko3YndmYzl1dS9yT1FNWS8wc3JwdHhYY1V2?=
 =?utf-8?B?ZFlpWFpQY2FPbzZxRHcwUHh1TmtkU2FncW96ZlZzeEJRenRmK1ExdTgwTnRs?=
 =?utf-8?B?SWRLd2JkZGdnNW9pb0xuTEFWVHIvMEZNT1JkVjRVdS93UFBxbjFidlNyelVF?=
 =?utf-8?B?cWJIYnQzQ21rOHFrYWppTFpXcytvd0dhNEJ1THRqbEhZNXVOanVNb2I4cXpN?=
 =?utf-8?B?dXJoTVFxU2FVdXFPOTc0RCtFWkJ0MGs1alhvR0MyanA5bjgxUm1udjNUdlJq?=
 =?utf-8?B?VnBnVjgvVGlydzRWM05na3VpK050ZlpPMFFoREN6TkZWTG1FNmdJZ1lPbExt?=
 =?utf-8?B?YUNyN0M0a0VTbk5RSVZuUjlGTjB3Q2RNaXo0eVFSODR2ZGcvYkFUY0pSRU9C?=
 =?utf-8?B?YzM0NWk0MFczWFl4N05pbzM0MWt0a2ZpblhKUkQzQlNyUXpBZHUvYjRDbk4x?=
 =?utf-8?B?NURBWjJLN21INWhLVm5CWDBjNzh4OGh5Q3VnVjJ6eXhLdWo4b3VmeWlzYmlC?=
 =?utf-8?B?UWpDb0xPZW5NNGp0anlOSjFKZ0cyTm1oZXorV2RQYmlrVHVnc2RBc3pvQk9w?=
 =?utf-8?B?cHBKK0ovSUN5WFRRTFk4TGlJa29jaWowNFJxcXduU1dmSGhPa0UxbjJ0RVM3?=
 =?utf-8?Q?ZhAuHyvoXGgsnNhVboXRw9Dab3Sh79naKzYls?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe03c670-d1f2-4f62-2c31-08defcf04480
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:16:40.7229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fEBVJh++uLr++XJhTcH7brt017+CAidEJvxgynuAYhG3/mF/LtJ5CJNKeJae891hJLIgT5sjJ9kvCUxA5gMWznyp1j6pDcjAOBvAG5/VST8tzRjgw6fb1/dPNF243yG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alice Guo <alice.guo@nxp.com>

i.MX93W integrates i.MX93 and IW610 WLCSP in one package. The i.MX93W
EVK reuses the i.MX93 11x11 EVK with some minor changes. Since the
upstream imx93-11x11-evk.dts in dts/upstream does not include SDIO
and WIFI nodes, only the part of the kernel DTS changes needed by
U-Boot (mainly the I2C3 pins) is added here, together with a new
TARGET_IMX93W_EVK Kconfig entry, defconfig, MAINTAINERS entry and
documentation. The board uses the LPDDR4X 3600MTS timing tables
added earlier.

Function differences vs. i.MX93 EVK:
    Function        i.MX93W EVK                     i.MX93 EVK
    WIFI/BT         IW610 in i.MX93W                IW612 M.2 module
    MQS             N                               Y
    PDM MIC         N                               Y
    M.2             N                               Y
    RPi 40-pin HDR  Limited (pin conflict)          Y

Pin connection differences:
    Function  Signal        i.MX93W EVK             i.MX93 EVK
    WIFI/BT   SPI_FRM       SAI1_TXFS (spi1.PCS0)   GPIO_IO08 (spi3.PCS0)
              SPI_TXD       SAI1_TXC  (spi1.SIN)    GPIO_IO09 (spi3.SIN)
              SPI_RXD       SAI1_RXD0 (spi1.SOUT)   GPIO_IO10 (spi3.SOUT)
              SPI_CLK       SAI1_TXD0 (spi1.SCK)    GPIO_IO11 (spi3.SCK)
              SPI_INT       CCM_CLKO1               on-board IO expander
              NB_WAKE_IN    PDM_CLK                 on-module IO expander
              WL_WAKE_IN    PDM_BIT_STREAM0         on-module IO expander
              IND_RST_WL    PDM_BIT_STREAM1         on-module IO expander
              IND_RST_NB    GPIO_IO28               on-module IO expander
              PDn           GPIO_IO29               on-module IO expander
              NB_WAKE_OUT   GPIO_IO14               on-board IO expander
              WL_WAKE_OUT   GPIO_IO15               CCM_CLKO1
    I2C3      I2C3_SDA      GPIO_IO00               GPIO_IO28
              I2C3_SCL      GPIO_IO01               GPIO_IO29

In addition, the default iomux setting 0 of CCM_CLKO1 outputs the CCM
CLKO1 clock. On i.MX93W this pin is wired to IW610 boot config[3], and
a clock on it would cause an incorrect IW610 boot mode. Configure
CCM_CLKO1 as GPIO input with internal pull-up in U-Boot to avoid the
issue. Since CCM_CLKO1 will eventually be used as SPI_INT for IW610,
the pad setting is aligned with SPI_INT.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx93w-evk-u-boot.dtsi     | 171 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig          |  12 +++
 board/nxp/imx93_evk/Kconfig             |   2 +-
 board/nxp/imx93_evk/MAINTAINERS         |   2 +
 board/nxp/imx93_evk/Makefile            |  12 +++
 configs/imx93w_evk_defconfig            | 172 ++++++++++++++++++++++++++++++++
 configs/imx93w_evk_inline_ecc_defconfig |   3 +
 doc/board/nxp/imx93w_evk.rst            |  72 +++++++++++++
 doc/board/nxp/index.rst                 |   1 +
 9 files changed, 446 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx93w-evk-u-boot.dtsi b/arch/arm/dts/imx93w-evk-u-boot.dtsi
new file mode 100644
index 00000000000..4cf6a4a71d2
--- /dev/null
+++ b/arch/arm/dts/imx93w-evk-u-boot.dtsi
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx93-u-boot.dtsi"
+
+&{/soc@0} {
+	bootph-all;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&clk {
+	bootph-all;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&gpio1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpi2c1 {
+	bootph-pre-ram;
+};
+
+&lpi2c2 {
+	bootph-pre-ram;
+};
+
+&lpi2c3 {
+	bootph-pre-ram;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	gpios = <&gpio2 0 GPIO_ACTIVE_LOW>,
+		<&gpio2 1 GPIO_ACTIVE_LOW>;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&osc_32k {
+	bootph-all;
+};
+
+&{/soc@0/bus@44000000/i2c@44350000/pmic@25} {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	regulators {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&s4muap {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&iomuxc {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		bootph-all;
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x31e
+		>;
+	};
+
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		bootph-all;
+		fsl,pins = <
+			MX93_PAD_GPIO_IO00__GPIO2_IO00			0x31e
+			MX93_PAD_GPIO_IO01__GPIO2_IO01			0x31e
+		>;
+	};
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_lpi2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 1271a3e88e6..ad1a425e652 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -105,6 +105,18 @@ config TARGET_IMX93_11X11_EVK
 	select REGMAP
 	select SYSCON
 
+config TARGET_IMX93W_EVK
+	bool "imx93w_evk"
+	select OF_BOARD_FIXUP
+	select IMX93
+	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
+
 config TARGET_IMX93_FRDM
 	bool "imx93_frdm"
 	select OF_BOARD_FIXUP
diff --git a/board/nxp/imx93_evk/Kconfig b/board/nxp/imx93_evk/Kconfig
index 305c3963f06..99df2079107 100644
--- a/board/nxp/imx93_evk/Kconfig
+++ b/board/nxp/imx93_evk/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX93_11X11_EVK
+if TARGET_IMX93_11X11_EVK || TARGET_IMX93W_EVK
 
 config SYS_BOARD
 	default "imx93_evk"
diff --git a/board/nxp/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTAINERS
index da0540307c6..0c542aced87 100644
--- a/board/nxp/imx93_evk/MAINTAINERS
+++ b/board/nxp/imx93_evk/MAINTAINERS
@@ -5,3 +5,5 @@ F:	board/nxp/imx93_evk/
 F:	include/configs/imx93_evk.h
 F:	configs/imx93_11x11_evk_defconfig
 F:	configs/imx93_11x11_evk_ld_defconfig
+F:	configs/imx93w_evk_defconfig
+F:	configs/imx93w_evk_inline_ecc_defconfig
diff --git a/board/nxp/imx93_evk/Makefile b/board/nxp/imx93_evk/Makefile
index b077acc70a5..ec2a0af3501 100644
--- a/board/nxp/imx93_evk/Makefile
+++ b/board/nxp/imx93_evk/Makefile
@@ -8,5 +8,17 @@ obj-y += imx93_evk.o
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
+ifdef CONFIG_IMX9_DRAM_INLINE_ECC
+ifdef CONFIG_TARGET_IMX93W_EVK
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing_3600mts.o lpddr4x_timing_1866mts.o
+else
 obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
 endif
+else
+ifdef CONFIG_TARGET_IMX93W_EVK
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing_3600mts.o lpddr4x_timing_1866mts.o
+else
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
+endif
+endif
+endif
diff --git a/configs/imx93w_evk_defconfig b/configs/imx93w_evk_defconfig
new file mode 100644
index 00000000000..9a1d134f4db
--- /dev/null
+++ b/configs/imx93w_evk_defconfig
@@ -0,0 +1,172 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93w-evk"
+CONFIG_TARGET_IMX93W_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x2051a000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_SPL=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="run sr_ir_v2_cmd;bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx93w-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_CPU=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth1"
+# CONFIG_BOOTDEV_ETH is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_ADC=y
+CONFIG_ADC_IMX93=y
+CONFIG_SPL_CLK_IMX93=y
+CONFIG_CLK_IMX93=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_PHY_REALTEK=y
+CONFIG_MIPI_DPHY_HELPERS=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX93=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_SHA384=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/configs/imx93w_evk_inline_ecc_defconfig b/configs/imx93w_evk_inline_ecc_defconfig
new file mode 100644
index 00000000000..04ba29fe3a2
--- /dev/null
+++ b/configs/imx93w_evk_inline_ecc_defconfig
@@ -0,0 +1,3 @@
+#include <configs/imx93w_evk_defconfig>
+
+CONFIG_IMX9_DRAM_INLINE_ECC=y
diff --git a/doc/board/nxp/imx93w_evk.rst b/doc/board/nxp/imx93w_evk.rst
new file mode 100644
index 00000000000..24e994e2ee4
--- /dev/null
+++ b/doc/board/nxp/imx93w_evk.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx93w_evk
+==========
+
+U-Boot for the NXP i.MX93W EVK board.
+
+Quick Start
+-----------
+
+- Get and Build the ARM Trusted firmware
+- Get the DDR firmware
+- Get ahab-container.img
+- Build U-Boot
+- Boot
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.14
+
+.. code-block:: bash
+
+   $ git clone -b lf_v2.14 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ make PLAT=imx93 bl31
+   $ cp build/imx93/release/bl31.bin $(srctree)
+
+Get the DDR firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.32-1991416.bin
+   $ chmod +x firmware-imx-8.32-1991416.bin
+   $ ./firmware-imx-8.32-1991416.bin
+   $ cp firmware-imx-8.32-1991416/firmware/ddr/synopsys/lpddr4*v202201.bin $(srctree)
+
+Get ahab-container.img
+----------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.6-c0b284c.bin
+   $ chmod +x firmware-ele-imx-2.0.6-c0b284c.bin
+   $ ./firmware-ele-imx-2.0.6-c0b284c.bin
+   $ cp firmware-ele-imx-2.0.6-c0b284c/mx93a1-ahab-container.img $(srctree)
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx93w_evk_defconfig or imx93w_evk_inline_ecc_defconfig
+   $ make
+
+Burn the flash.bin to MicroSD card offset 32KB:
+
+.. code-block:: bash
+
+   $ dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
+
+Boot
+----
+
+Set Boot switch to SD boot.
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index b28e5b6ceb9..fd92deef3c8 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -17,6 +17,7 @@ NXP Semiconductors
    imx93_9x9_qsb
    imx93_11x11_evk
    imx93_frdm
+   imx93w_evk
    imx95_frdm
    imx943_evk
    imx95_evk

-- 
2.34.1

