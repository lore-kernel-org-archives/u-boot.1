Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B5FC30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A59887BF;
	Wed,  3 Jul 2024 03:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FeDUe+Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736C688786; Wed,  3 Jul 2024 03:02:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9651D88528
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQXXcjUAECwhsg5FzlmOFxmrHZqIlbbPnjMcYVulORcs/+nZfxND272wMt8ESoU0AfaZyUZ3HJOuJt9VPni/AdghFQCGb0+wP0BKBhEERAfZuwep3Nb1gTACMLUWbTYoluFIiRoXyzcEUvZ9Rs1XgQCwPJfVOTl9orP6rJk90y1taME7FdYWukf0sT2IH7qWmGqsdqSEOykplp4tWItH1/evrcjdhLMt3wD12qKzrjuwucxVnoa3agBOeSSGwPATAMu0epkFm97ycTXUH/FPnYm1f8v/vRD+LZibh7Zj16iBKevIo/565B+GVLU8uveOyHOks7S0DbsFOQR4FdlRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfPsC6kNQTRABj7rGQH8BJ74iLYigVrSo4QUky42QBI=;
 b=hZE5vjbeIoxqqu41WXJa2wT8wGmTk75m7QzMoxA8TYTNThOU/eg4QGlPBmPtRdsSoXiA3sKI6walSiNMfltZZfKTeDninG618P7QRvB7lve4450b/AIPK95I3n1hVp/z8zrtZVph1DXTersvWe1XEFh46ucUVBLdO0ES4Tt0uUnFpoLSZ7nHlUrOJASMOLL8jYQM/6YkD5uUCmT65esqntG4xuBpFf1cZWYETUG80ml49E/oh7cZ7/0ETSMAFs7Uqb9KbTegk54ca8Dhf/qMVtaO1jWeffKTVFRXEIvG4hwzePrEZgnYYsul5tAkXT/Mucd9Q/vSR5F3/ZTJDg+ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfPsC6kNQTRABj7rGQH8BJ74iLYigVrSo4QUky42QBI=;
 b=FeDUe+SrpMf74gymUN6OpC6S0n9Yz6R+mEw1MWzCHgq+PuJaDX+9cH/0rEMKuZmKsOzZwokPwVPzG9s80TuyrtE3bEYkFCM9yINlbTYTTpbzK51AAzU/hDOatsTw33dF3rGPKMmZjPN0vzTa2tcSQbuxGvcJmVjcje3IPSfFpU5z9msnDHM0ro3DmeE4MDLZEQ5lkvx2gd0Q3TnoSQtCRKYqjExXRqNEQs2nOWVPKGjV+msPdFIwG6u+BY6oMl6qNxzfGycb7xAZfp/fUM+qpLeqVpQ9ZCqs4ALNBzAYmZPqYx/CtNjCHun5lXzdt+i29a+8E0Dk/TOaj2CNXBrQzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:01:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:01:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: led blinking patches
Date: Wed,  3 Jul 2024 05:01:29 +0400
Message-Id: <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: a7336a52-53a0-4acd-de3a-08dc9afbbd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcl7IN2hN/+j2O16Dtu4Cea9LhotlmUmpxUnU10MQPFng2MSR4B6HZsb3/QJ?=
 =?us-ascii?Q?cKCv8a1VvZ2IFBiS631KODxrk0Ysj3Kac8D4phVoG3evbxqjWRJCrpq2DNJi?=
 =?us-ascii?Q?z0vmP5u0xeojw91aerjecB+cAVnUZN/tPybiR5NUilTElsEh9A5PD4NykypC?=
 =?us-ascii?Q?Di0eY/8hS3Bp4/rRNw7kKPmwXaa+bmfa69NAt3wt0QLSDorA8JoEyuCUJ5hD?=
 =?us-ascii?Q?zc314akCNDCf3u938nwSLEH9RsdjRvssKb+CcPzzrFHR3Marp3TK/mofn3qM?=
 =?us-ascii?Q?mBPQUMdLVvHaRNytpsNRPFt16DfIBju3yFqK1n/ZxWv1ZLpIw6vcDEinKPvk?=
 =?us-ascii?Q?8OfbdWNtIEFhEOBx2OGlOHm+bTI5LF+SGgzoXS7vyd7WH5sfvCU1QmY5iM/B?=
 =?us-ascii?Q?59fQ3WJdjs3gUwR8vSDIC7A2kUrn922lR3NC6ZMqASR0Dt047ozZv8oNHPs4?=
 =?us-ascii?Q?Pz5gU0MhM7hzVC8A6sU8Rv1AfYm6exHv8QEZDKV1tUwaLAejvnUD26UMiCne?=
 =?us-ascii?Q?vKJN5GOyI6FicNWWXN7UroD4LA/mb0bsgFenWeUdwL7DcywXwjUGzLrWWo+N?=
 =?us-ascii?Q?kkwb27V5RInwKa4GtWb9z0FWXQRxW6uaALrfnTnElG1T5evJ/ozugFWLZhIV?=
 =?us-ascii?Q?0azAJU6pEQ0AvRF6k708GYLwhapW/NwtzZwBLcFPMRRza+6WP6S9BndUNwV3?=
 =?us-ascii?Q?xYiHXiDIBHswXbxYeUbl6qknIE28rpVfIvoo1hJB+/JjKFsNN5AwwJUtt2wH?=
 =?us-ascii?Q?cF3P89HkdL/r1MzM1GQOT7Z82rpDXor/87HrxTA0a4LrBr6iTcBeNYEMgaXK?=
 =?us-ascii?Q?DWt7WmX8uMjUuBe3xgRV3N1KjUVq70fGKcGh4iNmh6BCqyNVMtC++xkgAbY0?=
 =?us-ascii?Q?5ppU9sYlveVo9g4QASykN5TwqYNjpgdW/43KOvcP+msRJTGIpHuS0pMexGHV?=
 =?us-ascii?Q?hXpAI5JjdZDITNMfCaDXJ1BR2a5hA7VmTbEcnng8JhV/SaPejDkF1kZrYWrg?=
 =?us-ascii?Q?emZ2ChnzEBXZRRwtN3XptaL/NiFzwS738lKsBT70km18EgnrPv+uChLJFUp/?=
 =?us-ascii?Q?fmhJchtJ5E55G6cv89KZF/KdfXTFy80xheeuH40eZCqjDq5f9yjzOIuM1w35?=
 =?us-ascii?Q?TSEqb3m0Cwlo7ZrJvFAQPU92a40e4vT0rwMdXdrPv0OfWMHON1dW/vZ2znLg?=
 =?us-ascii?Q?5cNc2DS1DTz23VRvoxy0klWyJr9gifv6QfGQTgZOqvJWL1PYgNLlZwMha/hf?=
 =?us-ascii?Q?4WsdRJBKp3Xa90hv0vte0dsX7UVRbiiKHzlZSFbW2WHQ/PSjUiSuTqMIi+oc?=
 =?us-ascii?Q?r4Cp/ahgXr3Gfx0uykonlhrVAH5k43+sSiPFIXqMnU16nDk48xuEbPSN76u/?=
 =?us-ascii?Q?t/1x3jpIM+pV2GdFHuk9DSes7Ikj74jTB7xfqw1iZPE2IF15OQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j7YS9vNTEO96MSxni+LmEY+i9dO2EEakIpLvONMzijd9QS0YNBouF+HmuTBx?=
 =?us-ascii?Q?ahfQSZnLG5+S2NcMHtbU2FhzcVAQyXvBT5hbnYwhzYxBdTv92cWaaFeLa3UV?=
 =?us-ascii?Q?XNNDTYJGDtJnBikvCbvWq5vqa4cO+JwtNpbb/GvcEhcR8BWBSROXKZCZZEIV?=
 =?us-ascii?Q?0TJ00s/3Oe3PHRtBUc9hS0qsJeq9w/j6fB95u1ook/9jAeQWTcLo+EunH1ad?=
 =?us-ascii?Q?j/UevDdviMyewQ6NeE9sfr39t22M5nGJamQjlnKkW2oihVa4JOGZDig84j/Z?=
 =?us-ascii?Q?60XKSB8PEmEsx89TbaOslpxDZen9N805RsHsI83TQFE/VWx63D+1E6EDriMX?=
 =?us-ascii?Q?O4k1dhOyR2+cWD3IJnmJHaLalDLFNs0/zb+juMkkfNaFplfVV4a7PXtMl7wV?=
 =?us-ascii?Q?urAMsVO0QcvlL4/KHngzjiNy1BfO8WAriCiWW/zAJe9JwTxYlkx8IWx6SNcN?=
 =?us-ascii?Q?YvVz6nJCvoxctohXRU5l6KcH0Z+pIj4rpDStCEFfZM8UbpsjbOzDp1Db/DsB?=
 =?us-ascii?Q?nLDbD3rCROjIwpojNfcBesPvzrdbuog6q0idgWQY13C09O3+a3/3+fVoOVep?=
 =?us-ascii?Q?IWxsWmrUs688MHa7vKkJg4c3FvzGpIbE/ZtAsw3fGvHbO0WN+uGDitWBuPcZ?=
 =?us-ascii?Q?hWZYUQG9Jh6Glq7OBitF2NnylANH4zhAUVkYV5l9z6EE+oE5cczLPPIrGlpN?=
 =?us-ascii?Q?/ZsX2stxTUS+1eGjdYZLX71nhzUUioWfo2j3BZ15UT9zDXSaxxCPvgz6HFtL?=
 =?us-ascii?Q?HPk6dIk6Q/qtBjezw1wMEtt0Cfej+DpvITHP6RH9LvxGQd92CGBb45+Z4HKW?=
 =?us-ascii?Q?m0eGusXkBUlHdE4c2tjT4vFRApRyWy97EUNe3X4MRpolsb02Ecefrwqb8H62?=
 =?us-ascii?Q?68ocTD/nlgpklg31SdjSPWHlidaRycEo8XkZn4BG07HNXYtgR5t9zyP2zA2+?=
 =?us-ascii?Q?gl6hSl/nO2RcFDj1XqnYelHJLIq+mFgPXvcXHtty7LhwkLsuLx0ANtHB3rzK?=
 =?us-ascii?Q?FE8fOr08x2GtqQhoMH+eFBtchIAILdNlpf420qrtCIVasJyrG+s9VDJIaivw?=
 =?us-ascii?Q?AUcr1xkM95dXIHFbGqf1sS33Tns5Cq3/OaRVx4WxJKnjm2QwyAbELgVfo4Y9?=
 =?us-ascii?Q?2RK8M/pV3zC610QMyWe7rQJ6rjcyCFR/mtZaoa5drs/vYCDtUC2A0l0/VTW8?=
 =?us-ascii?Q?p50MZmuapHvjrmcaTFUkeYxa/Cow2TD294i3g63qx4v1TfR2ai6WSIEjgZJi?=
 =?us-ascii?Q?FmCehgJht0YbSr3+XbUe5K8irEye2BAvTO7yDFpcWtISEZ+yZ72/014bU7t7?=
 =?us-ascii?Q?l0x1I+zYU/hUi7hfCM4UNbyvle9jdCWvZKsSwLCREBZ7AcP5iwWotoLqSUWS?=
 =?us-ascii?Q?aPTejb6nSDgTp85dZ9eN1PKme39sH+hSEHECGs0bu8C4kQUsUpPZg18z0JBH?=
 =?us-ascii?Q?JUgcMNpFlF1n/RQifEOLYmDGXcz3//VyUUAMpDAy3y+oqf7uOjk89wDIEPRl?=
 =?us-ascii?Q?VWzHtzDYSY3JNdOYHBqAzkj6qf74cg2sl50zlZHwuS9iZqODI+FvFc8wttdX?=
 =?us-ascii?Q?RGyWWXqTKoUmpaXkj/zHMKJzTh1OV6v70w+UOIiqQzYEw2DVE3jH0D3+4cMj?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a7336a52-53a0-4acd-de3a-08dc9afbbd9d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:01:59.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xPgEtTcdOSfgDXwKiOpgdDBWDmYMtyfSmsrQ4/OKV6SGOzyjTnNnnHI4R/LlFadH1FXmkHqhA1/kgqC/mCQLmDPFU0V8nB+1tTX8J5akTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
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

Hi Simon and all,

This patch series implements:
 * software led blinking (via cyclic functions)
 * add support of dts property to specify blinking of the led

v2 changes:
 * Drop sw_blink_state structure, move its necessary fields to
   led_uc_plat structure.
 * Add cyclic_info pointer to led_uc_plat structure. This
   simplify code a lot.
 * Remove cyclic function search logic. Not needed anymore.
 * Fix blinking period. It was twice large.
 * Other cleanups.

Thanks,
Mikhail Kshevetskiy


