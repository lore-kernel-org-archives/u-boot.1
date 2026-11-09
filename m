Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD2606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EsmCuUXV;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MuHK/eu6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32B5640624;
	Mon,  9 Nov 2026 07:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3mKUjUQ1NLL; Mon,  9 Nov 2026 07:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E4D040683
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794210175;
	b=Bg5VNDbtZQB0HSqrYzBXnoEzbBosC1PRiMt3tz49vVyN2+IBXdZVOif6+lYoh2cAgYP0
	 h7pkIIneDRUZv0VwKCtKew4pzoIJ0+RKj+1yeIeq9PUKNC5J9lEfTM0+5JnX4dRrIuuVQ
	 lzUEu6LWNy3K3KFuQnJ81Io66R4DB3n5eFUvfpmJmJymJ9lFnP8JOYEgfldJKHq+yttuU
	 7x6pnCiXDYhh4JYmEBWuPvYOpRybep/V1HBvdghtdUWrwmIHeMyiqa2Vmex/hc0ZmrCht
	 0mk24yxq4LOo7FCwms9/lqxkPd4db9bv/JOOQWLCJwVFXxCROBYK8SPcShWvfYaJY/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794210175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XdsKOxqpU14bkHwqHlm67cgK8R7qTL5nCcruNsyvFRc=;
	b=Na+030a+udDlplrK871AlEGPc7aovGFD5NSpMnhvL+6qxeV8NXXf1S4l5wiu/659EOzu
	 m5oG+V6+20RmdEBDXlBfPbPNZiKMtGAU+jGUF5awBHvAd+Z2cmAAwMwufBVkm2GG40giT
	 KgZB1pXNh5gIAu4Frld6KIFdEO4KTDUm7ftqKNu+MD/5cXzL4SQYsEX8lngCkk3l+SFgj
	 jOwByE6IRUmoOUlXRpy3mfxEPkqfECZErNx3lfEpj3s1rUqUmSvdEaCn8Rmv/js7u9W7N
	 aQbU+MLE/efkqZmvj2g4cNalCE2fYJeurwvllI+sPlNDVf9ujEZv1FFu6XyzmYtvf9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794210175;
	bh=XdsKOxqpU14bkHwqHlm67cgK8R7qTL5nCcruNsyvFRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsmCuUXV8vcS3Lcfk3Cz9JfkI5UEtEEcD6Sradft1RdXMN4s06Omr0xWATq0ZUyUi
	 3fvVu4sM9BDCpEwAz3BIfU0lIgCstUrZilSamFFF1m8vSG6WpEB1kPhrqHiscAJUu3
	 fSVrERguLnFLVhjrkP+wT3rglWRqHRpNOLSLmzFJbkyNfYgvl3t3sQOrH9GfJvuKUG
	 nTArETuiuHmTegHsrwiNVFPqwOOg8w6P1LqMCG54nBRUf+gNFgUFlFuQgCB3KQ05ur
	 Fi2o0jxhVv9bsWGwW7QUPO0gLhpQm+uOtAMOkScA+p/E4ObHNQwO6nHrU3eO998gZc
	 QGp4Ak9v1OQtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E4D040683;
	Mon,  9 Nov 2026 07:42:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 672EC111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44CDB60699
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EmMf82qSf1DD for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:42:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07F32605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MuHK/eu6
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07F32605EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdsKOxqpU14bkHwqHlm67cgK8R7qTL5nCcruNsyvFRc=;
 b=MuHK/eu6yJgcAEn2LFfauo9Tapf1yGJBYJMTn0ewF22rsGIdsa3lyF4Jip8pgKsUCAFwyEs2FiMAS1Vrjc50710f5UK3FEw/rETcd0AePgiM2YBMkg4y0FzHsaO+6tz+SzJvONyMOUvnKsjgHR3hqJb3BZk4o1N7QqIAvfTDjU79W8xHldUi912YiYj2RsC3zQ+L6RItplmecA2alPqpge47XISTtYjexHfn794NGRaCmIbK59toh+qdj55ZXrcXBRnyllizNHcSbWdoYV8QH67/AnExNwgfIGjGn5FIgerBmSq7EjZoPf6jMAoI4NY3YHIS7P/6CJro+fRZH/2QQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7226.eurprd04.prod.outlook.com (2603:10a6:102:8e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:42:45 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 07:42:45 +0000
Date: Mon, 9 Nov 2026 15:39:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Marek Beh??n <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH 0/3] mmc: mmc_set_part_conf() fixes
Message-ID: <avF4pIC8NfWyzUdm@nxa18884-linux-1.ap.freescale.net>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
X-ClientProxiedBy: JH0PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:990:77::24) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecbedb6-588e-424d-34fb-08df3e350b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|376014|1800799024|19092799006|11063799006|56012099006|261021123027099003|261102130727099003|261026121527099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: wZAYnHXw6dNudH7ekAVdLvSx6e3Clc35EG8Hi4MVgm/GSloIcKo3ISI0nOUzqnuaetGciA8vIXLeBWOcw8L/0SRNatWlEna8EFdRMNoxPmVZ9cwdumMoMoVngjFJugR4ng5vqRMzvx8BKkHxJxzQ7lmRLSqCaVKUbVwMMbjVi3MKsNLlHmUdVh5ebgSgZJH0ORv5M3cGlEefZZIGxJVJKQwH7u5UfeKUckL/uPGXrdbw+PcyqEQKe6ratEGo44kyQ8rxFvwjOceyWarsPAL8ng3tHdrP6pYbaexI6V0tmZpSP5Ou7hS6kygavyv/zNH24FMidgUXpRvV4SSIwRXArDW5zFWPjBgD10iaemvT+voBCHT1GrIKugs7+hvncGk/mhtKMXeYw419szFzETYk7B7KZ4TNGnrLx4g9uNIvYBpgS7CrsnbCwO55NER3n3BmWe2jggwKZBy+a/iwGczY+0O+hP1Ke47D7UKd2AeHWAvBGr8KnM5SbzXjE+MABDL+/ukg1OxXxfAvIHsY1PBj+2ZrA/QRpvSZJOR8sjwsrgG7dXuSGEX3wuzjN2TVMxfyCxmp3VztMdFLePSIGuTPbDuhQ6pOcavNbycC0PFgQcs41swZD6FhGb8qZ2U77IQ5C4gKCehgBUdsh0+PA6Y90jre+0r0/TmoZSPDMRu4msk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(19092799006)(11063799006)(56012099006)(261021123027099003)(261102130727099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpplZZhm8ECtqRWhqSD6UIq69bhniaZ+/N6CVTEfTQIp2piUmqJihTxGJeFp?=
 =?us-ascii?Q?bnxG7W8eIExlruFE3TXYgsyx7c/MZZ1Yxn4UDCKZGFvmyG0JgKFmv9ma0bX/?=
 =?us-ascii?Q?Zgdo/yHmXp1Ty5txjGm3gJHsiGEx2nyIvrfmEG4n0fdzW56H9RQrZZj06TAH?=
 =?us-ascii?Q?AbWlUQtqCYSdrpA+uMRnw4rcLR9aF0sMUEnXfAeZTwIJStzoFWp+j589195p?=
 =?us-ascii?Q?BK7YjRYVckPIX6LaMqbF3aHUHulIHkFT3WvPB13N/BPhgTyr6VSE3d9tbhKh?=
 =?us-ascii?Q?HNtD02K0zyUGbzg6/Yf/ptFTcTFHsfNhe9IAs2r7dYg9NL5ROF9Xg6A4u2z3?=
 =?us-ascii?Q?0P6K9mNhFAfLPZovz+egEdZygbCu892G7rPsnmpVofoGXTk/Loe8/axOROFj?=
 =?us-ascii?Q?h08tX3YagqjsigLPLcnl0vb239U9AlSW366iJIW2Yl7pHVJ7eHmfd3vBU2Zx?=
 =?us-ascii?Q?jRhlXLAPsj1vOW5uuLOpmS6U1DtA85ldokBPrHlkhb/Bi8e8di94Eqn9nbPk?=
 =?us-ascii?Q?oETUVr/Np1pCElQ+Lv6W4QZwFTDI7NBhdMTYSs0N/O4cQPPE+U3rQM3Hns2u?=
 =?us-ascii?Q?YGXpZmZRMuFnoaFfLFaYAmYEIgpoMBAztW1xJ7O4NFqbF/Gq4QgJcoAZiUdo?=
 =?us-ascii?Q?uTH2h8ufXgN1C52HM0BnBYSpo8vFnzscJ7dOFXwz96fi6SANHGrw5Ml/ynhx?=
 =?us-ascii?Q?OlIwSGhl3wq09c0desPIg+yYQR46N+ij4h91E+7pyfH0l06RpnVTQV0j1qBd?=
 =?us-ascii?Q?S44FWtE+3gFvyKgrJEw7+MvmADbTQXcMWrVhAL0HGVAUAesnCx86vhOJ7dQi?=
 =?us-ascii?Q?O/C+JzSzUPJRN3FEJV0mOs0BEgA0V8PiSpHTX4E8XrxdJiw2rOgKTA/6FZgo?=
 =?us-ascii?Q?IRORfAJnltOGHm1ndiqEY64q+2U3fBpsoPfPmW1PXBLjKH5Nw8j6Hzt6k5/3?=
 =?us-ascii?Q?mJmHLjNPXPzKAZEE4Vz9Zq5qwpPWTyTryzZSqBgf9gljQoE+jb3z7WsUH1vU?=
 =?us-ascii?Q?NAjAGss9nsFY7KStM+hdv0G2UMXEDsmjECvZbJfjl6ett6/paHiHAAKnXzf3?=
 =?us-ascii?Q?NqcLiGTwd79BkaD/La+D4uZO3FN8lR0z5clbP3DUXihry4Y0AKPYKHSEarSL?=
 =?us-ascii?Q?0/QeWubTXl79ofg/Y1zIAntex9qj3TxX6MyPRxqJw+7WjJosCqZRBSpOHjEC?=
 =?us-ascii?Q?HQuNhc9R8OqEgLfR1/zuzcCOvpTA99acA9adgX04i7r4emTB/t1zdWW8iu+0?=
 =?us-ascii?Q?uNBR8lz4u2lcgL2BwfkaqBLdzeB02qEGDbntN8xlOkM15XEroJbBy3dWMrGA?=
 =?us-ascii?Q?iM+SD4x1IVfOyx9LzwcQKRAgMQCgOSoKnMFX0RQpPS01GJ2NTlVjdko8oKeB?=
 =?us-ascii?Q?poM7kxMH1RjQ69ajObRXCN9aYz7C3Pf8dqdCKaTBTHIgDBqWzkTu5lnsnJCd?=
 =?us-ascii?Q?jr1Mi9ulzeAMJYvQOxmSC8aUvG8Vp+wOHu1w3vJLyeO8fwgG4hBbx78FeYsD?=
 =?us-ascii?Q?4mVam5+UNC/Z9mhT4btRpVzpPQFDmvSG82sAeQRPxEcj8FhJoH9mlVH/wqcV?=
 =?us-ascii?Q?VJntayatCp+IOuGtecHaWMC2SggqSvC3YSQLxlRhhCC4KQpqveDXnSa6cEI7?=
 =?us-ascii?Q?VRVSIkcpg182uXvqnz8jY6LvP5Yqu9ohH5RTUbJl4CAQ4LVW1xXLCwifrGLM?=
 =?us-ascii?Q?7sDMssGnNIC0VtaQpERhPjRF3ND2AcIW6vQlIWcK30FowTttYtOehB1EM1Si?=
 =?us-ascii?Q?CUQkMK9DsSRvllCWqVS9OiSJTXMDl3hS8HNdNFVIlCewg6rU/OaH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecbedb6-588e-424d-34fb-08df3e350b64
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:42:45.7128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFJMo8WdI4dFoVv6n5PHkFttJ/SviUEuzlOz8S67v4/BK0nTgfb3MRLq2bNUQ8SASwxytWlpEZvd/4HM8Z3iSjJIjK0yXwDk+kEYDjig+uSLyl+d/3mEXIMnKore4NOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7226
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:03:19AM +0100, Patrice Chotard wrote:
>This series adds mmc_set_part_conf() parameters sanity check 
>and fix the partition selection after "mmc partconf" command on eMMC.
>
>Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>---
>Patrice Chotard (1):
>      cmd: mmc: Add mmc_set_part_conf() parameters sanity check
>
>Patrick Delaunay (2):
>      mmc: export mmc_set_capacity()
>      mmc: select the hardware partition after partconf command
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
