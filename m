Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF19C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 21:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D7082E35;
	Mon, 26 May 2025 23:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RIjR3en8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7380B82E66; Mon, 26 May 2025 23:10:40 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B766E82DB7
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 23:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyLTn46mxvrS8P4ZV5iUU/6JMR4D4bLK4uBPdluCbDDEQ9qPplSBlwvyR4MaCZZ44+k615ze0SdpiJWvInCDPWU8QUaZCFcE+MHz+Bo6NNCcnLAembKR7CoEfAZ8Sze2BttmOr8/FbiN0YUlcyAfN4/VGaCnw9SPOUD2QEVTKC5SYU8MOzALwK6xDwn4AE3lm6lYjSJi15Gh+421bK9YXkBgl625MMhMeXUmbPA8txLhoECUhcifg7ReV/du3mQK4jgNnM3yGfxps+A0ySwK1qABeuSop05FMUUKdofH8wepM9GuckUvwwioZOuqciiuwVBAMXvTVDRIz8zLLKDojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0bHHjrA3YYVNI/MOojJ7wYFGfgXtuz/LDB+j8f5gl4=;
 b=V19DJlsfQcasqReYvKuXKKqSiiURnU28h7SOg/rhsVp9yd1yB0uu3EACqzJvwbBHm26HAceEkjS9UgCp9ZwSRIPgNBD/Gc5qbG90It+WOYxo4iu/kF3bYph7IcpXmTj6JiL2gWf4s0cEvMurc8fKu2xLQ+Rw1Mjwz2rhygduAMXsrt5maM5I+a3QoK2EEuPm1f1OOHp46HrlCh7AOFh6JFERTWUu6Idkt+o4GVb0R4+hjkhOHJMPPYxzeXPOixX6P9yH8UakQbrF3lC7GE0GwGlkNSuk+Y/hu3twSimYOcIDtj6xWrph/23fZ3buStMSVg80Lil4KNo9gVZ/Yl7Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0bHHjrA3YYVNI/MOojJ7wYFGfgXtuz/LDB+j8f5gl4=;
 b=RIjR3en8o51m/w11Z6JSwerm1F66QQyBxaN4g0KR00Xl5c/9yaNGNb3i/U8tO0Dtdei6hPWRLiamPXjxJeF3B0QZ5ucHPQfM1IdLiBuz8jWOT+NpZ/3LEn7cbi0ToOog3pEbR8flYF+NmN2m3puCA/Vr9tr+wbO5gtwrW8OnOsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA1PR10MB8502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 21:10:35 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.031; Mon, 26 May 2025
 21:10:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>,  Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
In-Reply-To: <20250525230201.GS100073@bill-the-cat> (Tom Rini's message of
 "Sun, 25 May 2025 17:02:01 -0600")
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat> <87r00c3143.fsf@prevas.dk>
 <20250525230201.GS100073@bill-the-cat>
Date: Mon, 26 May 2025 23:10:33 +0200
Message-ID: <87msaz2i46.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA1PR10MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5b73bf-e307-4a1a-5772-08dd9c99c18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tvqCceJQnyg9D+Zb0rwTr7qsrq7dc98ymCIxOYVBLwecwVcx88VIw02SjHG0?=
 =?us-ascii?Q?YLqus89aZePDdieSmDwvgIDuPBXLednSCy6AcrvqziNm5Pae5h0CMTPZM+Rk?=
 =?us-ascii?Q?jFdzyhKzyzjkba/24wQ6Ifa9RMmK+c33EFWBhyB0EpjaOnBnRHQHOyPdYrrF?=
 =?us-ascii?Q?WRmVHGfzR1QSz1a3D13g1IFsGhTxoHF60idiw2z4ib+ymENrBBYLw0lF6/jA?=
 =?us-ascii?Q?mFI5vnmTCrIe4jh4TF21CKlOqUcYqsr42pwfTENjw5nPxSCz74Ech/cgj6dC?=
 =?us-ascii?Q?1pjxjTu+DnaLm5Mjl9Wb68XGFMKefFLYeV90bI83V99C4As1aPJ80ZTPZztG?=
 =?us-ascii?Q?5pNFQknDk+tXKc+EN5IHY5Sg6OvYGXNxVLhqzQ94KkRYJKnCBhUFOwubszCP?=
 =?us-ascii?Q?93k3QypPAfmGV9GCOBqJvKo7Y6nNEmReeVEyayAOXCZff/sGi9nl28ePEE0S?=
 =?us-ascii?Q?NwmrwhBBz2PccMU6V3Fw4nHb2milnEXMbsZvRycUhVes1LSEdTScdekoTQRZ?=
 =?us-ascii?Q?PunaJF/jEKyZreSA2Wogw1sutTVaYc7p6MGldd+EekYxKyGsidIl3UUWlWdI?=
 =?us-ascii?Q?/19HYP7L/xBSaKMI1dyVZT7cwML/lUeiLIEfE2ewTvc7BPVEtEpu3dkwZ7Dq?=
 =?us-ascii?Q?Uq1q+tEmZZk/GGGp/Key/j9L4W3dIIbWF/m7qaCJMni5k2/UkG9AAyIXd9eo?=
 =?us-ascii?Q?gsC6SI4zgQO3u8Oy2rOFlsLN7+KQQ5d28BEwbYSvb+/mHoArW2uDffKXGq6W?=
 =?us-ascii?Q?RH7H0gjOrZmDX3wgzwd1yLg7+VM+OUTZt4PrdwGcZT+b9A/+p+nDCf03YoFC?=
 =?us-ascii?Q?GYHFbpsk5B6vq/efO/z105henuX7lpUG74n2pj0vMm0StP9Kff4ysxFTXPFX?=
 =?us-ascii?Q?iS3NLYtQ2nkc4KM3qZ6d42oWcGQo4/2eyFPmJGugNWSNSB7n2SF4QaivYk0r?=
 =?us-ascii?Q?HxcADC7NO7hxgV9MPl9ywVoEaabPOshtq6g6X1dAaLLVjgqF3Tz7L7+X8rlN?=
 =?us-ascii?Q?GEVkXwh5YTJyCME9uUhDFq0bYQ/h6FOf361z/pBS5aD++GFiZQm20sVr0hOy?=
 =?us-ascii?Q?IcTDwjfkYit6MxQ8u0T0mgpBo6/+g6JuFXeGzzTH0/mt4GQ1uoe7hSONoO2f?=
 =?us-ascii?Q?ZvxzVoqvECtCo7dkoO5Hu7sHXTm8E0o1+Rp38xo/lGLZGJrOgxVPtE5nCxkA?=
 =?us-ascii?Q?oB1X2C+Zm5w091pPCdwHCyyKPd4aEHsNXqlv4kRdltizQC7bcbKou00xIShZ?=
 =?us-ascii?Q?grk48o6o3D1eMxux1cND7EycN6b+y4ntP5PnrxhlNQOQMZZRuh6CYzqd3dtP?=
 =?us-ascii?Q?LelcxChPLs0C1iH/+vD9d28WK6iSBz08yYWKC42uKzyNNWQpBO0vjZtkqBEw?=
 =?us-ascii?Q?HNhBPLTAhbHgAxFwuDTImUPl0ooYMBGE3l2LPZ9SYihwK311z4e5zJgAoBRu?=
 =?us-ascii?Q?V0m/qqArc31N87SBGXZbSZD4yngCkB97bF1R/cSCI/xDv0e3svWn+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oQCgCqegZn0+bzpO1Dl41rCC7etu41s+EbwavQ8taIwb1++hy4tEPwghBdqb?=
 =?us-ascii?Q?woApsveCOpseQo3fz2bja3EgYf0xEBxAnQZZRc6InvobjpBlxu112b9KyLG7?=
 =?us-ascii?Q?y7Xej/HSwB+YKSwU3iFjaZRprwbVrsSaCqrcXFVPgUq+668da/uk6LnhaOC5?=
 =?us-ascii?Q?fFFrmp10eniJ0GMWkWBqeS8heL+sW/oSTV5CHV9nNpAdm5lqTg7eXdNZDoNP?=
 =?us-ascii?Q?PSBo5b4cg1qv6aY/AwPon66nf2eWFyR8eVcV3lO0h05tNQv1bVdWZ6zHAFET?=
 =?us-ascii?Q?KzyI5WYrL6kry5fF7g27tyx4XGgJCE7yGI+iAxKMqPoqQwhGZNR/csyfsm+p?=
 =?us-ascii?Q?lg0h84KzHD6AvdLSYkrLm5tltjbmDAmaZGNWISsLbZONpj/OW0tmiR8Biir1?=
 =?us-ascii?Q?8gkPt2MoIHTD7JtwJnO18M8ojYiE1qYAQyMbUTripVgQYBfxy4M5bVozkaUr?=
 =?us-ascii?Q?vWlBV9j3A4DvlymT7hm+um56RkWvzn+79J2ORZNedUcH18BmCYg2Z9W+Zwwi?=
 =?us-ascii?Q?FKIgqlUqxveXukoR7kjdii7ih0882Du3iTX5GBc4rjMrAbX8ykA2Baze+xY9?=
 =?us-ascii?Q?WCYDrk34HRlzlaSouk0TrEQXCRiNA2RUrKYQAZu+ApPQ3LteiOP1JfBdEJZ0?=
 =?us-ascii?Q?BEHaN1DujjghDJuCswYH/X5hYcEANDspogY/H1O4fa95Hs1HrGJRmZ1eZxJv?=
 =?us-ascii?Q?dq9la3d+3iILkZoEIsYsFnip5MSiNGxwU78Ur4VgF7KmornbmYzRYItfiuWc?=
 =?us-ascii?Q?FyVdJg+a8JqAtYWJfgqMShQ2T1VsbZHJU9GKB9Np4QSX6jWnSf4YTcv3oHIx?=
 =?us-ascii?Q?ajy3Fvbn4zAWWooPXcgiGJ4nuvSjKS2ZwoivGGeWiiuZDSai+nyhd3XH74RA?=
 =?us-ascii?Q?U2/yo77uP39hk4J9I4qMcmZoJAIGtSZfkvjBNMhMv0gD5s1OOJ7P/Oh7qCe9?=
 =?us-ascii?Q?kUw6PbZu/mJINQMfiGvE5lhkHg63SMimGo9ay8pAnz3kxj1MBPD+OpcILaD8?=
 =?us-ascii?Q?jL/AG8fXWBZcQsPSO77I7unEgcHzvH0RT1xUa3i1jdTZKfQHABPNKZpgZ5/0?=
 =?us-ascii?Q?btSowER1Ae7HjtDprrr+H9w0OYaEGUlA2TIT6FZye86N5tbsYFCkg2pLxmZm?=
 =?us-ascii?Q?b0U7gqx2YpLDJwfgAyvl1D1+fjZLZhYTF+rKrzNYcamEhj36iSKxRncHaYCh?=
 =?us-ascii?Q?Jb7CUgMUsYzGdep8aIvS2ZA1j//0x31Ri7AoMjmcaRsGJtRb9/B1AV3ZlkJ9?=
 =?us-ascii?Q?EpG4ExRg1rrXaJKtYMzQzOoO8pdElV6JkZHHdZxlyP67i5HfRRT2opnSAzr0?=
 =?us-ascii?Q?BFCSWtjNDNM+LZ+KzMI2kXXZL5Vgii672koGe7RuFzDpr7sA3/68zEa8DcSG?=
 =?us-ascii?Q?xXnvSu0gHM6yiEaTQHscJr9woI9TKxalH1AVG34lZS7cL3kZUjsDeuhrwnXc?=
 =?us-ascii?Q?Dfxtht+PpZzClfkq758gRolfyh/NkXPjxfdMBnKizqkRjPRoGSUY/j1RpLth?=
 =?us-ascii?Q?NlyDU+UeELHINUNTAo8E8S778l0W8DuNG+4rSwndIPSFaHqXN+4fa8hiRvPN?=
 =?us-ascii?Q?YgYS1dMoyu4GQz7Q4KaG6jrpTC5+5SW+Wh4DDvDucshVFwGTQttorSyyHaKk?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5b73bf-e307-4a1a-5772-08dd9c99c18b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 21:10:34.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJP0J/n6opiksBWTtCNE933AG+FfD4qfpoSI9NQxlKOKxScUf8eujuPtF1GVr4Ajf6NrdI75Az2SugozONq9J7/QCiMrDClpHsCAmvosZn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8502
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

On Sun, May 25 2025, Tom Rini <trini@konsulko.com> wrote:

> On Sun, May 25, 2025 at 10:07:56PM +0200, Rasmus Villemoes wrote:
>> 
>> :( so we've been relying on that prefetch() laundering away the
>> volatile.
>> 
>> Which really begs the question: Why, exactly, is it that gd even has
>> that volatile qualifier in the first place? 
>
> The answer is likely early 2000s GCC.
>
>> I'm 98% certain that we could drop that and get better code generation
>> and avoid a ton of places where we cast away that volatile which
>> shouldn't really be there anyway.
>
> It would be a good thing to experiment with now and maybe try for real
> in a near-future merge window.

So since it's declared per architecture I just tried with arm for now,
and this

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 45401d5e3c8..f7a47204b7c 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -133,9 +133,9 @@ static inline gd_t *get_gd(void)
 #else
 
 #ifdef CONFIG_ARM64
-#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *gd asm ("x18")
+#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("x18")
 #else
-#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *gd asm ("r9")
+#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("r9")
 #endif
 #endif
 

builds, boots to linux, and passes our test suite on our
beagleboneblack, imx7 SabreSD, RPi 3, RPi 4, RPi-cm4, wandboard,
imx8mp-evk; i.e. a good mix of 32 and 64 bit arm.

Rasmus
