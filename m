Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B54BFD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1400C83E7A;
	Wed, 25 Feb 2026 14:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AXXA9o4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9494783D8A; Wed, 25 Feb 2026 09:42:40 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F9082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJUZYrzt2FbIJn/uMZEGVQCVX8Pqv18Eg8URCWbEsQY30BpYRDJ6qSAPr5oNLzB+JTOVAPWTODryYK3FrIpx/3cXdi/GagkbHdEqWZBhAF7lsP5gh7PR5WI6H0yi8Z1Qi410Ccit3yUZJZosjusGJxVkJ2/zTfICny5vywbpTdqMK0m4Y5gAkNBJQjQNfIo21nX3i+vB9Yql2J2kpWRr2cI/zN9tBgU/sunKlIHHunjm9JfZWBUD3k1IqJYqdXVW/0qIY15CUsxs2P/zIf1q2kjU03mVqJpsiOBWvVbhuSQ5+BQ68OusLH1ikG/dcnVdGA7v0RraMK7T1oof3LF03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKfhHuYSBDjarmIaNmFyC2di7kDu7HKgU3sV87Q9E2o=;
 b=jP5m0aYx1FNOyeV5NGw75Asbp1PovZcWNc7GcqRhGtImJUmAShmqBHhal5IQm1bfLpvOpcEeycZtE48CmocXd7bOTcKnv+DqXzdQIfiJ460rW6KAO+9nA4Ut2SAnsEqIgwbc5OlckI9s7vd+c+UQb09fROv+IeV1wf+NIb/iAXzxpqGXwCeq2n9BgQiSEk2uedJ49AHdMeuUkwquz/zer1tvK0XpzMHeMxtWQ+Gq6JCO+9OwK85aj+ykncp/L79b1V3855Gvwo7d+vgQnnwKKixyv9odwcG1jtZaTuBspwJH96nHAEpw/xo2Zf1IInH9BrR0k4uX73XDw6MZKGL3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKfhHuYSBDjarmIaNmFyC2di7kDu7HKgU3sV87Q9E2o=;
 b=AXXA9o4jlxcvzlZmeE06EM+nWQeXmLhm2DycylcmTyJ7d0ZMHWWmat3ov+nLKN8wkDapg03rKWFJFStiDBJDKjzRdRai40Z7JDM7ywna6jseK6zbdwqNYzD9FnY6q1UYrV0fu1NVY2dc4/Sm5UF0/fq36acVewAv6ubksDAg7Ye26uCDc1NAaA3aXLZvhwOmZLFA5zTW0CS+Zs2GKTBS+8pa+NXoHz/sJ3C5jsrutxq3CnMVeyvbkYM/hZ3qEnOFX2TitIXHaqnuyU2BGCQprZ3URxPa4lQR9eP4qOarpQQhGrYYzN9jywaEaac/QXnLDiRQIsJiD/EuOkKgjtnlew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH7PR03MB7134.namprd03.prod.outlook.com (2603:10b6:510:2b4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:42:34 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 08:42:34 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] ddr: altera: Add delay before writing to MBRDADDR register
Date: Wed, 25 Feb 2026 16:42:23 +0800
Message-ID: <20260225084223.19498-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::30) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH7PR03MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5e7671-a895-4020-48b7-08de7449d256
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R8vVxgXc2x5QVzUr54Rbu+ODFr2vfHW/F+zQ1ocSL3uixAeZzUNa2Vxp0vuP?=
 =?us-ascii?Q?g0oJotm0ToapvWDenzb6Lq5R/21wI8KoEXHU1jGC769yvu+W/mYsKv/JD66a?=
 =?us-ascii?Q?N/xQviufzUCRAMbU1jwscOqtcB78FIlluSAD5NBM9i/72vi3RnEadef990vP?=
 =?us-ascii?Q?kTw5yLrSowMMKbGNidoWw9H+V9NuQP93/0OOPHqlFp7NWDtpz/Db4Qt1lIzF?=
 =?us-ascii?Q?qXWhO0Cc1gyWQUeK6ojI/5eTFgN15+rYKPsi1onoosr5IQMoFfUs/CT+cNL3?=
 =?us-ascii?Q?7i3Gg4nVkYbDR28L1dQ3nllpk9uCMilssa2qRPWK5XhAjCObZXm9laQ+O7V+?=
 =?us-ascii?Q?m97GZQemJub4Klme6E7uF6jUhg1YeqH/QyvnfiLUwgquyCaypYiOxvGE2rKx?=
 =?us-ascii?Q?o2ZRePI5ZLozg9UxNS17occQlgVCk2mvIptM4FTYazbhCWqpQrgdqW8mWJIt?=
 =?us-ascii?Q?UX+70VLxULSDDh0QXfI4ddSC2ZvlUWPZElGkLr9N4FvKXl8y57TRBeke4cYR?=
 =?us-ascii?Q?7VUgCJy41DeN5OqtECNrEDIsy78bTISCk3wFVvZd0zm3uw490MIw13iwXBBc?=
 =?us-ascii?Q?mhAf7LbaDA5Wi8rzVQG71m7XdKyk0zKeq7+PsQ4QrxZWBqIDoLNQi7RsIVov?=
 =?us-ascii?Q?W641Z8H82d0xqH2nLdgXR/jgKVGIe6EEr9JaJ3CruhtbGUqSCiF3GqTgdLc2?=
 =?us-ascii?Q?5d3SgC7hzxXV55pr/7VdNfrmZiRBWu8wYTdSt7UwWA7q64Sjg1syNJwF/b5P?=
 =?us-ascii?Q?IaOByy3Vz5guamzqXKRupoVEQYv8ZUNbJm5favHJr+uhACTIBTyG16+O01LY?=
 =?us-ascii?Q?8PsB0iBwdx9mpbsZaq3ZFf68rqlkE87qcX98BXhJlpFwLNWcBk0Hz0GYdIVa?=
 =?us-ascii?Q?XE6BvAst1f34aCkZzEvYwk+sBP8lqkgLqXAsQZGuoru3sZ1ELe7KpUO1urtC?=
 =?us-ascii?Q?BRZVNuA7MiBTuO84Yc5phgl6JsK8Pzu+jsND5Qe6npHqcFyi/g34SqZuQsKD?=
 =?us-ascii?Q?b5FAef0q/nYigRG4oFUNjgbTwtd9FHZGznELcKGXPkdeg4kiGgTPcsisuKwC?=
 =?us-ascii?Q?eXYOc0cXFwfQkrmXUebLyHhlh8V/N5qiWiZ5MnASTUN/rfFG1vZ/plhz1+ib?=
 =?us-ascii?Q?hdgXqYdiqkqOkxuyp5SmiYU9KU91ugDk84eR3ToxK4y9KjSPbMfUgoN02g9w?=
 =?us-ascii?Q?wPXPjgtS12soReMHSTwU36sMoNuBH+yy9AG5e823nwbLxpN7wc1Q13x1Luuq?=
 =?us-ascii?Q?IAkCdNscFN7syhGnko6XqNG01rAytUAPzRPzp0tPPHCIhR+sFmAVtj7XPMOn?=
 =?us-ascii?Q?GhFkuGSmKdpYZ14z+guD5Wqmh90DacTO5OePcoyGjvI4KkSCo9eg2UyszMgM?=
 =?us-ascii?Q?l34uNW820jCWQBz5zBwA6BNLzemKFXjenaE15O7QDOEP0uud3Mt2pOaVdo82?=
 =?us-ascii?Q?1Sw1xw1j+OtW4UxSyXp4FY2wrTklhcDpiUdx51Oc9r+Kj6bTN+uUII1TTLjP?=
 =?us-ascii?Q?5c/UbkJZaGgoOW7p07tKbP8OqpCdSB83EHERVY9n2dQZfN9QFpL7gpkxLC3e?=
 =?us-ascii?Q?iM/UpBh0RGw6MlAP61c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksxtesBqfEQ6owPu6Z/Oh2ApZVNNsa0Nqyw/lijQIrfVJBlLq9oY3ijLiIGW?=
 =?us-ascii?Q?qo8yCzTV3QEfU3+SxmW9pBhhU94o43DWCo65JgObB5sBYRtP2INFqrshEl9g?=
 =?us-ascii?Q?nEK97XYMEB/0gY4JvhrCuJ6Mdkof4A1miGr2RBclxhVP+sRsqSuMEuBD1EWT?=
 =?us-ascii?Q?7oWHyAxvNVCoMmUf25/2U0s0wnLZLZ7ID73ILfFQ5JE8Sy7LqX5rI3o/t+2a?=
 =?us-ascii?Q?NARYOzzILY/p0Yt7190NDojFOhyaQgYLT5Ewlw6NKQJ+7vRcjn8c3QN5QEQ3?=
 =?us-ascii?Q?ZDUlUcJR4C2RGafmGw2dvHHGA6ryZRj3/1vJhDsTthmwgp/ydnmYx+NxBV1u?=
 =?us-ascii?Q?IS787D2Lbf1SHokeVzDFu+NVQnWxQiz/R90/+cxmFJcVVUlge5BLNjvXXPJ/?=
 =?us-ascii?Q?5wpg5koXUvSe7e0I/hj+2Sc4KLWPwnN61GbVvp/BB/fF5QET1sQig1W1joI0?=
 =?us-ascii?Q?BN7YgBAur2mJn4qZYq4NgVzXVlONZ/C5synqjSE5MIRgj4fmDqmO6o2H8U2E?=
 =?us-ascii?Q?T1Feu24R7e11Ehk3Cw190N16hsquW4SHlZLanRhvaqbeFJ9oqCqp04fvoGXZ?=
 =?us-ascii?Q?7wAwT9mNz/qjaMitcXGsZ3HvhjA7ybkVSeuQ3hPzmONcOpLdTTSnof/3ce6N?=
 =?us-ascii?Q?xlEhDO/yRpmBJrlAbZBl4+FDfKI9gBFYiwAzIVNfZKiEBUq3XnBarWEUMeWA?=
 =?us-ascii?Q?S0fCy3x2Hf3NEy7LGs5WFVizHOPjGLz9pJk4dMyqmfdpP+2C/0RoiX8eMMLI?=
 =?us-ascii?Q?dvZR9xvJGyjHcK6c1EMuAM/i2zISyIiWAapV5YPjFIYdKjP7xb8RiGdRGZXJ?=
 =?us-ascii?Q?8PRxc5Uvk5S+se/iHDDwOPTqQEoD4OkoAOOb/bsH7ikw7/93SzQbZkIY95DG?=
 =?us-ascii?Q?e0mr9vsriDiu1bcF+Cdu1ivpKDGsCwLiBamzP/s4kbkgGgN7BlmN4LoaKOlV?=
 =?us-ascii?Q?BGOncm5fQCJ4LUf+wxgE23fSb/ReFTERVaNB1QH4JLdiIHYzni1gvQCdnm3D?=
 =?us-ascii?Q?J9b8Ah21C1NDI9Q8Xk95eM4VlBV7bvi20wNzHJhVLAR0fmtnaF2sc0lCuj7N?=
 =?us-ascii?Q?b/Ow3pPd910mHsn2s7qatTJL3kiReK5oKwiqJ6Wu6/oGKzNF6JcZ43NWSlfO?=
 =?us-ascii?Q?JOzz2dYoX0rm8xmzPcZaTOyGquPkR8+QGhHG0KHf1+/Quk6Ew/q+eqt8Kr3s?=
 =?us-ascii?Q?wo46oZ9LO6x7QJWcyhQpfVYvSpQ+tuliXjwnoX3SLcyAplp03JV1FeiRAKCc?=
 =?us-ascii?Q?1qOS4DxOnMIazI9vvhG4NIQRxqhdEv+zN2NOt21I+gWxa9oM/Ai8SbuSLuP2?=
 =?us-ascii?Q?0vFNKeN/a4MfDHFZ6iT50oer/hhQ05li7E80EGUjkwsRN1Noii16Jxn/e0I+?=
 =?us-ascii?Q?MRXrP8NZFDKCy42j5dxhoEpAsBaWW8d8jntgxdNjgnwv5+ukkBYaH977DXg0?=
 =?us-ascii?Q?vVO0C9GvsTlVuya9XG+XM7EQFdohm1vq2Z/u952iSeUidJP3QbpXJ3kA6Krd?=
 =?us-ascii?Q?aV7UnYKEfDxkI1LSfr6/JMoq5ODdl9G9hN/Sx+j7EPIQTzmY2Ju1NCUd5UIt?=
 =?us-ascii?Q?BxXtyRIfJ371qlAIHc/dHNy9Jzec70DbXwDZyD2GiPYpk7UVJ4MpEcyrox7B?=
 =?us-ascii?Q?F1D+Ygp/n4yrUz2//0298BoJGdNYk8Cg7t49aq4KVi0AcByPpRMWgW71DNNh?=
 =?us-ascii?Q?0dMuNkcDCl/5/P518EvyVYmb4I7XqHsWlqWyYbbyaJT2Bem89ynp6AFVoACi?=
 =?us-ascii?Q?GRWBrcbaBg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5e7671-a895-4020-48b7-08de7449d256
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:42:34.7747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bysgTMUSny5mnp97lylKPP/ImyEMDXq0PX8OMsHY8lTF0Ne0MEMbLnbBO/VqrRNbITgkrKnldDEG5OWyMNVZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7134
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:09 +0100
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add a delay of 1ms before writing the address of the data for HIP
interface into the Responder Mailbox Read Address Register.

The UIBSSM mailbox require some time to settle down while waiting
for the MBRDADATA_VALID bit to become 1 without this delay,
specifically the board will timeout while waiting for
MBRDDATA_VALID bit to 1 after setting to 1.

This 1ms delay has been tested thoroughly and no intermittent issues
with UIBSSM mailbox communication is observed.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/ddr/altera/uibssm_mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ddr/altera/uibssm_mailbox.c b/drivers/ddr/altera/uibssm_mailbox.c
index deef61f1178..2316e602d3a 100644
--- a/drivers/ddr/altera/uibssm_mailbox.c
+++ b/drivers/ddr/altera/uibssm_mailbox.c
@@ -243,6 +243,8 @@ static u32 uib_mailbox_read_request(u32 target_read_addr, phys_addr_t csr_addr)
 		hang();
 	}
 
+	mdelay(1);
+
 	/* Write <target read address> to chms0034 MBRDADDR */
 	debug("%s: #2 Write 0x%x to UIB_R_MBRDADDR\n", __func__, target_read_addr);
 	writel(target_read_addr, csr_addr + UIB_R_MBRDADDR);
-- 
2.43.7

