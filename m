Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE2606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KIEd8kAE;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bN7BwWeU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AED87811CA;
	Thu, 26 Nov 2026 15:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYbNhT98dz0X; Thu, 26 Nov 2026 15:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A45F5811AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795707149;
	b=gr1whPicGwHkwtu+yB3abiRbdCZLBoRNBcHEP2NYoaHC1SvhB7nHOacnegabeBIq+XoA
	 JXdE+3VF1M8bHFxQq/L8MqkF2CaDRVGEzRs6wJuLGinFsxA5/UP/ZsXEEGpNzR84EWSlZ
	 OP5tX2X6jfa1hofc3dmr0smxvjHPRkMzwJWHEsjghatmmXHuHdrv1mgC9JcnOUimg/YMY
	 MC+EvlNMfZY9ZbWFpKw+Yt3mu1euAuvOxl4r/lEc/ovn1vyDTzzJyLB5YSTjpX9rKqBTI
	 W2uQwnbyc7x038mBvOJ4hZbVS9ke05+T9pYxdjybVxukHkrWiK3ILVkwqWF5CvGRLtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795707149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jp7rmoCrfPnv0rvFiFUcXQy46lR5Xon1V4Sk13iM7Vg=;
	b=QPiqwqljhrTPGQblFcj1pAlzkWc+jZl0ligtMh8O4VEHvP2vuUpy6/If7CK35Ii/cu1m
	 DVqZSA+aL3yyOVxW3pQKaS64CCBzxzxYqF5F7qq5bLcFMb3NZjZ03R4M1GOC8WilEaZqB
	 Hyg8kcfVWYom3Cbxqb045Rk+7ugptqWSOoBI3KNz4aZW0YbFY0Ep30s2PSXcprRzhL575
	 cjdfAGITBeuROn1QvZFoYv9iqCI2r70boMA2lD0uf1IXrIQ7nx2mD6TwWYBzxkF+jO++Q
	 aZXT0lEyzb8SFYXXNUU06xm8Sejs73pyMlKp8ELnbJ5bTItniR6OuPDr8/bt7g32c+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795707149;
	bh=jp7rmoCrfPnv0rvFiFUcXQy46lR5Xon1V4Sk13iM7Vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIEd8kAE1Kl8srdzRGUKM9Y4iZTAwaDf6wsJaRAXAOrZMAi9ePHo7+645F2aO27Em
	 wrQPU05amvn+h0aTj/asUbogNFBZmyRoA7pMtASKJzMWZ5who4kR5mmMatxBmkSS0N
	 FF5EGMn99H+MoyFZs8/tOhmpej35XNuj9U6Dw0+iNNuGOnFGM2bswnWhOvBeI+ds7L
	 GR/izYi8raG8xUAE7a4/ix/ogdMkPMwVx1ycZKHto7m2Giy3oinbmyY5ZFOz001nvU
	 fFw+LvpjCIkX6BoxFSue7m/LOibw9Ej2JTPQR3M1xwtA/ZmjL3w0dPKCeYt6uaTucz
	 j36ba+vBj6s2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A45F5811AC;
	Thu, 26 Nov 2026 15:32:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2CE1325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8A014090C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46Db3sS2fkhx for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:39:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CA71408F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bN7BwWeU
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CA71408F7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp7rmoCrfPnv0rvFiFUcXQy46lR5Xon1V4Sk13iM7Vg=;
 b=bN7BwWeU24ZDl0g+1Qdafn9e6x9xIz/gjobO6wTB2YZec9J5VpnH8/CkQyZ/MdAyGXd0JxkrIA/X+UcbLi8A7UXBfbRt4/j5RCNz1Y2kBMe4rL8gd2H0bBONChN/sho9uxDzjVSGJWrknj7QjC2LSVYffxO+zLbLXGO4SwINfeY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:38:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:38:57 +0000
Message-ID: <65d05173-645c-4c41-88d0-886466d2708b@cherry.de>
Date: Thu, 26 Nov 2026 15:38:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] boot: fit: Allow choosing how SPL's FIT payload
 is compressed
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-20-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-20-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0c6d24-c1ab-43cc-de53-08df4bcb00fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|6133799003|261009223027099003|22082099003|18002099003|56012099006|10067099003|5023799004|11063799006|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|261022115727099003|41080700001;
X-Microsoft-Antispam-Message-Info: 5ZZV0hv+ChbSyYHgsBX97F6zjTa4pz+MegDklkwMgYbB9hDtaKKnc/XaeqGKuyPZv3Nv3NMeEhcOfeUNrdaZAKPnCGYP4HX57ap1S4/U5+OUxm8GDJxnzhFkNg09kioH+X19p31DNYpn8AcrGRBxYEyLVrowPi2uYoBzr3GtxtrGDjQplonrQdkOc6jp9yiIqT5wdnKALBaRrGAMkb+74DV8htJB8gpFgURAzPjZwPfE4q4pSjW/wKqr6Z7f+zEZ5n2kPl55P8E3lWtGovnI+JSOzdRlh+jShbg/G6Ern0GLxOF5FVkw2QDVid8foQE2NFEVVZ3aFC6OKLG6nFh+exqPhZf1cMYm1THMMNDnTbsCyPcE3i61v6rtwcH3vtjXJmUyar2VXB/q/5LVT9jlTLRBdGeK2/LnxCYRrw2bQ3V0hNdyuTfWKDnZNA1mtW3ymYAvWS4PMWQLc6jcfUi2d/pXBjNhScjIabMPg8GH7kG46DHL6nTb52XMrexxMAhiy/w3HRDrA0+23yOxMCbSq32ceKaOstKDix/KiXhsmcpAB+STnu1Xso/DHdLyS6hF5LXEeDRO1giqq7OUDj0cTpqSMLq+urGDyHEflEAKSZmGlHKDoBzfz9nGD9mQmog1Jh4b242eO8ExM0VCTcyez4E+9VrgOgdKM94tRnF76ubzyOBDRlCr2r1/IY3Lm1kekvPz7Z/RpnBdR6LavIDZYxIoFXGGH9CYfmBTe+0eOpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(56012099006)(10067099003)(5023799004)(11063799006)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(261022115727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpDcFNJR3Z0cDFxY3dyZjJzYis0bFlpTm8zWVNEc3ZnQzlUZUVzQUxjaTNJ?=
 =?utf-8?B?UlhWVGlEczFTZ1Q5Y2N5WGIxS1pPVXV2L0h5V1NZcWhEYVFpMnJvQUhvamxD?=
 =?utf-8?B?NFpRZzFCSllNalZPcmhYaCtOL1E2SGlDdHkwSk1SbFJEYTIyVVJoOUJ6enk1?=
 =?utf-8?B?M1dGbEg2M3FlR2NpS05PNG9SaU10a0t2UzN6MDZGdjE2Tm1KSVdKRlVkV2t5?=
 =?utf-8?B?cE5Wc1N5eXp4ck9TWUZxRkFBRm1wRm9BZldPMUEwQWV2VUFoVFZBbW5BMDFY?=
 =?utf-8?B?MDdoTW1aRkN4cDhIT1lZYmlyVWExUmx2eFBVM1N1d3QxMFNybUpPbmNXNEpx?=
 =?utf-8?B?aDF5RHpOWExkaHZXVVAzVzZjb0hIYnBRaEFkMVR3U1R4RVd1WC9iUW43cW9k?=
 =?utf-8?B?VWNyZUtwVUFwaGJJMVBYY2x2ME5TQWFpakFkMTIvY3hNTlhCZEVsYlNNL1ox?=
 =?utf-8?B?N0FMVE80VE9kanlVY1lITVpLTXJnYjRYSEJBK2RMUWZhNWFWK3VuUHRBSklG?=
 =?utf-8?B?a0R0c21uczRQRnpyZWNUZXZSSEpIOTJxWEh3TEtLYWtSUkEwZ1hvUWJCMGFv?=
 =?utf-8?B?cWk3Wm4vdG9oVGg1d29JUWVEby82ampWZWZQbVBINEx2OWdTMnhqNzg4dXpQ?=
 =?utf-8?B?Q29kUXlQUm5EV2V6Z0I1N2FJVC91eVpEemU0YTJYb3hteTVTaFMvc3dLbGIr?=
 =?utf-8?B?TGYybHlOTmdOekk3ZGVIZDZ3NldMN1JoNXJRVG9VYXVCQ1d6a3lValFuMHRY?=
 =?utf-8?B?ZU1hNUFvNll1dlk2UTZkNXUzL2JDNk1TaSs2STZwVkZwR3hVOW15RW1aVWpj?=
 =?utf-8?B?dUZqL1FmcW5IM3MwbDNNeU1hU292ck1hNXlRdjBtakl6SllQUG8yUzN6REFM?=
 =?utf-8?B?V3U5bXNZU2xWYi9WZjZqTmxUNnRIRzhORTdXUFh5Z2JPaUhCTDdia0ZnTFE5?=
 =?utf-8?B?VlNYeGtMODA3ZnNBTWU3SnlDMXNRRnJMMkJFaEdjRk1tNXdtNFdPeTZ0TEcy?=
 =?utf-8?B?dlNyMkp1allHMm5PKy9ULzdVeTNBRUFqMFAzOGxEZDhlVlVpcEc1dWgyR1J2?=
 =?utf-8?B?eTl6UDhUaDlsaEJ4ZlAwZVBBc00yVWZLczZEVElIcnJzZ0I5YytXU3lqaU0w?=
 =?utf-8?B?QXYrMm1keFFCY1JVVEVhUWVCV3ZYc01iSWR2TXBUbFU0dU9KMDQwU1BxazFY?=
 =?utf-8?B?VDdRSzErbHpjeWtHbGpGV1F0UFI2N29EVWVlS0thbmdHTmZtN1psUU1vWkVw?=
 =?utf-8?B?STc3a1NyaitNTWxHbEllaDQ1NlMvckxtdlV6ems2Vys3TjF3ODN0b05CcEV3?=
 =?utf-8?B?ODg0T2JGb1dpenpFSG01dmxBdmdndExwOEcvS21RcXhJejN2NDlqNy9ORUV5?=
 =?utf-8?B?czcvYVJUclUwT21uQ3J1d0hYNGwxT3BjNVArdmhJVXRTc09FemZaU2N5cWV0?=
 =?utf-8?B?SjVTM1B0L1Y1MDl2U1dabC9JREtGeXBscnNtaVBkVjJ4WUtsTUlRS0VncVZL?=
 =?utf-8?B?eUpCY3pQR0hGUzdHRU5mNUpOY0lPZVJNOU9GUWh6K0laZXRzYXc3TlRkUXlB?=
 =?utf-8?B?OURzQ2MvajBFWGFzdXJZaktCdjdKakJ3aU15anBFaENjMVR0OEhlRi9UdDMz?=
 =?utf-8?B?U09Dbnh1S1ZBR1hQeHl4VkdTaU5jeXJyc1FBTWNLOHJQWU82UlY0cXBKNllP?=
 =?utf-8?B?WkpKUlAwTjNZWkhJVkphbW1aSWg4WDhVVVVRRHB0dnlob0QyY01JbjAxNVpH?=
 =?utf-8?B?eHRPenFnVlVkeEIvWmg4SnNBaFVJT0xJRm5ianVicTkra1lZK1F4Zk9NckpP?=
 =?utf-8?B?dStVZDFKS3BRckRhaGhoaUJEUWtiTHZyYit2anE2MmppMEtseWtzTU9McXRq?=
 =?utf-8?B?K2VUODdDRDB4d0NKRVN5Y2hqTE9lekZxNFIwOFQwck5KT2N4NDhGMHpoVGMw?=
 =?utf-8?B?dVMvdkNwMThIQkdpNWg4a0toelJYRXVzNkZRcitORGFGM3RlMWNYTHZTN1hL?=
 =?utf-8?B?ME44c3FuNERFN0lHdkhFcUxwTU93R3ZLUGEyVzlMS0JnSjZQYzlwMmQzclNK?=
 =?utf-8?B?eUxWSmw2dWQ4UnlLbElIWkhXdEp6b3I4OTF0Z25XZFZzeTlKQlkrN2w0ZHd1?=
 =?utf-8?B?S0FaWUhhV2JweGdLWkxkaTF6MkZTUXBXTHhyUmd1c1hIcExSelZxL3J6V1lM?=
 =?utf-8?B?MnBqa01KVFVweXd6VlNTYmJKaHFOUWE0ZTdtVk96WkRMVUh1MHh1ZjdnNkNp?=
 =?utf-8?B?R2dJYTBreGNaeGYrVVJzd08yaDN6c0JnUWdhRHZBdlE2M0RRQ3NOUGhGNEhF?=
 =?utf-8?B?S2NJcWtrSW1nUWtjWHBXRlNEOGxkQitxT3gxUFVSZWFmdkFZNUN6dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c6d24-c1ab-43cc-de53-08df4bcb00fa
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:38:57.8097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drkmIR4IFhmY38z1DxT2n8AHV5quChNlHvt3/zJ7G7c4m6s5y+B0qDRxi4X+CxIQeEs/TD29dwzm3HnZohuZePHSNXtWC9y1oeQ1DiNA/PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388
X-Mailman-Approved-At: Thu, 26 Nov 2026 15:32:26 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:41 PM, Alexey Charkov wrote:
> Platforms which build the FIT that SPL loads have no say in how the
> U-Boot proper payload inside it is compressed. The ones that compress at
> all infer the algorithm from whichever SPL decompressor happens to be
> enabled, so turning one on for an unrelated reason silently changes the
> image, and asking for a particular algorithm is impossible.
> 
> Add a generic choice for it, covering every algorithm SPL can unpack,
> where each option enables the decompressor that provides it, alongside a
> companion compression level.
> 
> Gate it on HAVE_SPL_FIT_COMPRESSION so it is only offered where it does
> something: a platform selects that once its image generation honours the
> resulting string. Until then the choice stays hidden and the string reads
> "none", so an image description may reference it unconditionally.
> 
> Offer the level only for algorithms whose tools take one, so that a new
> algorithm has to opt in. Let 0 stand for passing none, which leaves a
> tool's own level 0 (gzip's 'store') out of reach, as binman rejects it
> anyway.
> 
> Leave sizing the SPL heap for zstd to the platform: it may come from
> SPL_SYS_MALLOC_F_LEN, SPL_SYS_MALLOC_SIZE or a board-specific region, so
> there is no single symbol to check it against.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   boot/Kconfig | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 8fcdc36c9318..cdad11918ff4 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -66,6 +66,15 @@ config BUTTON_CMD
>   	    "button_cmd_0_name=vol_down"
>   	    "button_cmd_0=fastboot usb 0"
>   
> +config HAVE_SPL_FIT_COMPRESSION
> +	bool
> +	help
> +	  Selected by platforms which build the FIT containing the U-Boot
> +	  proper by applying compression specified in SPL_FIT_UBOOT_COMP and
> +	  SPL_FIT_UBOOT_COMP_LEVEL. This in turn shows the selection for those
> +	  options in Kconfig, so that the user can configure any supported
> +	  compression without the platform itself duplicating the boilerplate.
> +
>   menuconfig FIT
>   	bool "Flattened Image Tree (FIT)"
>   	select HASH
> @@ -347,6 +356,94 @@ config SPL_FIT_IMAGE_POST_PROCESS
>   	  injected into the FIT creation (i.e. the blobs would have been pre-
>   	  processed before being added to the FIT image).
>   
> +choice
> +	prompt "Compression for U-Boot proper in the FIT that SPL loads"
> +	depends on SPL_FIT && HAVE_SPL_FIT_COMPRESSION
> +	default SPL_FIT_UBOOT_COMP_NONE
> +	help
> +	  Pick how U-Boot proper is compressed in the FIT which SPL loads it
> +	  from. SPL unpacks it on the way to its load address, so the image
> +	  gets smaller and the boot gains a decompression step.

issue: my brain refuses to understand this sentence

Can you reword it maybe? I don't understand the first part of it and the 
second part uses "gains" which to me seems like a benefit but is 
typically not as that's added complexity (and attack surface), and size 
(and possibly runtime, if loading compressed from medium + uncompressing 
is longer than loading uncompressed from medium) for SPL.

> +
> +	  Compress it where the storage it sits in is tight. Whether it also
> +	  saves time depends on how fast that storage reads against how fast
> +	  the SoC unpacks, so measure both on the board at hand rather than
> +	  assuming either way.
> +
> +config SPL_FIT_UBOOT_COMP_NONE

question: is SPL_ prefix really appropriate?

This applies to the U-Boot proper binary within the FIT image, which, 
yes is loaded by the SPL but I find it weird to be prefixed with SPL_.

At the same time, having a not-SPL_-prefixed symbol depend on an SPL_ 
prefixed symbol is probably even weirder (although correct).

That might just be me finding the whole prefix thing confusing when 
something has impact on 2+ stages at once.

> +	bool "none"
> +	help
> +	  Store U-Boot proper in the FIT as it is. SPL copies it into place
> +	  instead of unpacking it, and building the image needs no host
> +	  compression tool.
> +
> +config SPL_FIT_UBOOT_COMP_GZIP
> +	bool "gzip"
> +	select SPL_GZIP
> +	help
> +	  Compress U-Boot proper in the FIT with gzip, using the host 'gzip'

question: is the host tool *reeaaaaally* important information to the user?

I'm assuming it'll fail to build with a helpful message when the tool is 
missing on the host no?

> +	  binary. A middling ratio, quick to unpack, and its decompressor
> +	  needs less of the SPL heap than zstd does.
> +
> +config SPL_FIT_UBOOT_COMP_LZMA
> +	bool "lzma"
> +	select SPL_LZMA
> +	help
> +	  Compress U-Boot proper in the FIT with LZMA, using the host
> +	  'lzma_alone' binary. The best ratio on offer, and by far the
> +	  slowest to unpack.
> +
> +config SPL_FIT_UBOOT_COMP_LZO
> +	bool "lzo"
> +	select SPL_LZO
> +	help
> +	  Compress U-Boot proper in the FIT with LZO, using the host 'lzop'
> +	  binary. A poor ratio in exchange for fast decompression.
> +
> +config SPL_FIT_UBOOT_COMP_LZ4
> +	bool "lz4"
> +	select SPL_LZ4
> +	help
> +	  Compress U-Boot proper in the FIT with LZ4, using the host 'lz4'
> +	  binary. The fastest to unpack and the worst ratio, so it suits a
> +	  fast boot medium.
> +
> +config SPL_FIT_UBOOT_COMP_ZSTD
> +	bool "zstd"
> +	select SPL_ZSTD
> +	help
> +	  Compress U-Boot proper in the FIT with Zstandard, using the host
> +	  'zstd' binary. Close to the LZMA ratio for a fraction of the time,
> +	  but its decompressor needs a workspace from the SPL heap, which has
> +	  to be large enough to hold it - see SPL_ZSTD.
> +
> +endchoice
> +
> +config SPL_FIT_UBOOT_COMP
> +	string
> +	default "gzip" if SPL_FIT_UBOOT_COMP_GZIP
> +	default "lzma" if SPL_FIT_UBOOT_COMP_LZMA
> +	default "lzo" if SPL_FIT_UBOOT_COMP_LZO
> +	default "lz4" if SPL_FIT_UBOOT_COMP_LZ4
> +	default "zstd" if SPL_FIT_UBOOT_COMP_ZSTD
> +	default "none"
> +
> +config SPL_FIT_UBOOT_COMP_LEVEL
> +	int "Compression level for U-Boot proper"
> +	depends on SPL_FIT_UBOOT_COMP_GZIP || SPL_FIT_UBOOT_COMP_LZO || \
> +		   SPL_FIT_UBOOT_COMP_LZ4 || SPL_FIT_UBOOT_COMP_ZSTD
> +	range 0 9 if SPL_FIT_UBOOT_COMP_GZIP || SPL_FIT_UBOOT_COMP_LZO
> +	range 0 12 if SPL_FIT_UBOOT_COMP_LZ4
> +	range 0 19 if SPL_FIT_UBOOT_COMP_ZSTD
> +	default 0
> +	help
> +	  How hard to compress U-Boot proper, numbered the way the chosen
> +	  algorithm's own tool numbers it, from 1 up.
> +
> +	  0 is not a level but asks for none to be given, leaving it to
> +	  binman: that is the tool's own default, except for lz4, for which
> +	  binman passes level 5.

suggestion: reword to simplify

0 means use tool's own default (or for lz4, level 5).

Cheers,
Quentin

> +
>   config TPL_FIT
>   	bool "Support Flattened Image Tree within TPL"
>   	depends on TPL
> 

