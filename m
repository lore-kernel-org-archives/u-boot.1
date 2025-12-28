Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192D3E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 05:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E2583A1E;
	Sun, 28 Dec 2025 06:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="gsigYa2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA87A83A2D; Sun, 28 Dec 2025 06:35:07 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3677B83A07
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 06:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ0Y13KGJxDoxrn+qy34T+3MwwkQKrRuq0bWRoxNBxu+nHeLijM9u37kqtilpDHKs14JJ7KYTlPSodSwLwKbje2eCk/Zy8cJlwYHJ56Zj4wN/4HB02skjjWnfSBIaG4R7oXuSrqbnqKdN4pQb5lZqaTsrlCPbdEt/LxCOam0QBCBJ7ar/pfptYvPpPLAIQzqk0L9kUQHJpWXaQXAVuaxEqFpZcW2vux6iNVDWTaY3V1Uvcp6xmsr2Pf0ONCuuLNEwcvcE9vioQsJMhhWGSdeULxcg3hzhXnyrrc/P1XRH1cNW7oYWBlS4XrEqjZQwI5+j2hqQCxsbUYjuQjIeNTjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43rCOaFRV7IKA66cyHiLnCScw4V2J5hKm2nQr3odvSg=;
 b=cJSe7dSKNti5BaTEiUROD3yqwhTNhLccT0/9y0H/pzHb3Xs5WW9PRE3/e36ELmsUDA0/J4mBwvU/s283bgyr1DJ7SjnkAvbJIWmLREAP6vAAm6PlCdXnEek/WLABhj6uex//drdQcuR9MDfcYYWBV2O58xo0F53TPS3sWJOasr+PnN86vFofr24zWVuzTH3/tDtSjWIUsEVIZJxwk2Z3BFjPLJFEfHGRN4E40EmQLEgjLBMrwiI+x+VfxYO7H4Zuu4x6CHqfvGUux1TyVR4Zso3fd+RM0wZC01MLHF6MUQdwaFS+9EGZ7QnpC2P98uQgYPFudlP6Y9p/EUkdIvON8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43rCOaFRV7IKA66cyHiLnCScw4V2J5hKm2nQr3odvSg=;
 b=gsigYa2XZGo3MzqxSkd9RjHjnNWnFMW2i5H+6R9IkJTAANt5D7pobRFQ/ZPYgND8w3W29hgqSUijxqXnmZP1SK9zaM1oOBa9xqnxNaDj3N3HN7sdiykjaF9MlazPSRBe1waMWT1vjlCdCvGnNSjnokSz9oi+549/dwv2G2sYkuufM6BHKLGhBrbbeMNKWvmt1vPE7FadlqxTa/NHuYq9niaL2TGTQBxEYtmUvRmqO+4GH2oCUYFNtf3Z8CJvJ14NIGy+41wwWRoxsOKvLhR6NcEZqiPRlFl3x9QuAeUC0eC5Ytn8dDSxBLPDSrNJUuYLqsDuJRDrI+lxifsCdsHZVg==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by TY4PR01MB17012.jpnprd01.prod.outlook.com
 (2603:1096:405:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 28 Dec
 2025 05:34:59 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Sun, 28 Dec 2025
 05:34:59 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: sjg@chromium.org
Cc: ant.v.moryakov@gmail.com, casey.connolly@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de, yangshiji66@outlook.com
Subject: Re: [PATCH] common: cli_hush: clear Ctrl-C pressed flag before
 exiting loop commands
Date: Sun, 28 Dec 2025 13:34:38 +0800
Message-ID: <OS7PR01MB13834D81092D48CEF11F0A21BBCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAFLszTgZGmmwD_YgCF6N8h182eD5EvKhjrBC4V_OzitFrUEOCw@mail.gmail.com>
References: <CAFLszTgZGmmwD_YgCF6N8h182eD5EvKhjrBC4V_OzitFrUEOCw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251228053438.14234-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|TY4PR01MB17012:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d3b025-86f9-4318-c6e2-08de45d2d67f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799012|41001999006|8060799015|51005399006|19110799012|5072599009|12121999013|23021999003|4302099013|440099028|3412199025|10035399007|40105399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IwGzCE46UMYKaxoyxGQVe9ANgZ1UnffcRLIJLvexCc37i+CiENqYc4h4yboG?=
 =?us-ascii?Q?MpnQ/5jPQWl+yR9ZQxxpqIMCtjEDF4mS7kbLFhB6bcK5WBOeWAHjelYjZ9Vo?=
 =?us-ascii?Q?LOGi04d/5dFalL+kokg24k1DVShroNGg0akCXKqTFB6Idzq7YUCPgnhUxDs1?=
 =?us-ascii?Q?6wYZxOIT/0lniBzWGUHOYuXvojrMs7kzEo0wR6hpCUguyy6lzUsU4LqHwP2p?=
 =?us-ascii?Q?/xRDP8bQR4cFLZNWDmRxFc3a7RkqyvMseRzJbwKCKsIm4MTbs9Z44704q5dn?=
 =?us-ascii?Q?NJOYe1VRXRCvrtuboG1dRovdf+mGEv4IHEueAG13me5T+szBK6KABNmPAXvy?=
 =?us-ascii?Q?vD8i18SMBCC7+dpP4S15ZDPuPEN4mofpMVAo0bsyQYz5lhejPtGA5OzbXmN1?=
 =?us-ascii?Q?lT4vbHgP9y31CdVw+hxghVsnJ0IK2lp8HJHMyxseLrLBtDVpvzgeTDsS2JOT?=
 =?us-ascii?Q?CRfEzJ61+VwuXmv2qvrS7RIGdsz908HGfMV2JXdVSGGcHHugvWNZF0UsUSME?=
 =?us-ascii?Q?n/Sada6qhu+FsnKxWtl/5+ORq7aJQD1khahEOrHCs7BCDSCbKUPMFzAEwOT9?=
 =?us-ascii?Q?BLolKg4qBeQcR7dclWTzHPsJ4jdoMheEogep/qKT4QMAgxDjYIyljty9xj5F?=
 =?us-ascii?Q?PrYCmDU8FuQ7Mywi2YIKtY0t/57tRcfYgC+A5bE1iVLEnFSVI2QaCItU7qHS?=
 =?us-ascii?Q?TmmyAotUcKke7YcDDUvGTJpB/PCXk3ZWEe3+ASjewnpfhVYQH2PEVvcZYRgW?=
 =?us-ascii?Q?KKPiFwt653X08fRQ8tUz/q2CKD6TTG3IrQG+zyyJjDaEJjZoaS/4PWYWIP6n?=
 =?us-ascii?Q?nnBJbOm/CuGs/cxnsjxLxnE677u4h8paC9ree4KoFL+gp6u4Mele70Qd05jP?=
 =?us-ascii?Q?o8x35A4jplA6LFqwCx8c2kBKditdvK2I1p6Im8oiNCztyt/GV3VdgWgJwhsB?=
 =?us-ascii?Q?gW3sMs/MvJYq5BpLKJwDJji3Ih1P1yaTeCQbnEuhc/VGk3JuoEhDX8iv4eMh?=
 =?us-ascii?Q?+iGuAwiJXX4b3HqvDACSfvPc8FuYCBbcrIxEeRZ5BcrnKaL0d2lc+2YKmatI?=
 =?us-ascii?Q?4UcVBmXyGLj333951HX9DqlufSTGLq2CPevP2XMUBHfFQ/WOIW4oF5veDuKV?=
 =?us-ascii?Q?rrEw83/+HSD1dZ2FZSszLusoB1T1HR20DAJBUkKBvyvPr2Ens9Y0Z2VkrD1U?=
 =?us-ascii?Q?0vN5jtGlBsMovYFJf6UUVZECXrXE5H/YRVZh2/SdfgzQGS8E4Agx2kBxQlII?=
 =?us-ascii?Q?cM5+rOIb8kEZFTRBntJjf7B7um2gP1iRLooB3t8cWWagXzx9i/CokOY+rdEp?=
 =?us-ascii?Q?qB/PtvZL7nohBCbMRO+N0v/8Vme9J4nIunCefYUI2Uuf9Tkzpt69XFxUmEHO?=
 =?us-ascii?Q?+n0JyNsIUKzuMMXEJ8TCV7hQRABP5i0r7iKAmzMaTHjL9RFwHA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SMD9l+0ZlSReJTxjtAY2TWClf3o9cFMOTgyNNkC7YiU4bjVpCBamX1InBDQ?=
 =?us-ascii?Q?f9C5tp1q+SqDkB0eT0ZzGfRgTJb7QUkQREd8Cu7FbNByQOXFKUJiO+3C8IGW?=
 =?us-ascii?Q?jr1lGYqBVQzpA4FBiBi8l7+YwQF26kmbgu7PlqqsuZN0RS75B+vc+Rfh+ePn?=
 =?us-ascii?Q?WOQJ4evKPgYvTWK8S8XJhVN8fAl+cTe80HTn4siJvrhj9i/zj4KFLGQkCcLc?=
 =?us-ascii?Q?HCHGVKJCg9FYzcbnx/JT1WZTTONmzEl9pA70qxXQ9d0NK6Ilq6PiZyri5y0B?=
 =?us-ascii?Q?5OaMUANIlvoLwlusNEWSA+g74wXweh5/gl9U9ecQAM8G06+J2gu4xYaa5f61?=
 =?us-ascii?Q?dNsPIxbo3QEG17ublKcVFr1O/Dsf6MAMqUu5vM23evQsvejUaUP85Y48W0zX?=
 =?us-ascii?Q?KshgWCUN6F1dyXsq7Sy3TevhgDLSduXKIuMJmBXdA8Rx8TPPk0eS4JYKONzv?=
 =?us-ascii?Q?1gHdlkeCWukMHQIreW2+mGUQkmI8czKR0LFkxeq4+jBdmEvw1+Do+pAARm7r?=
 =?us-ascii?Q?E2wKUAOjqPtYxarvWOjma1KwxZpJtcHPddCYDOG30Et5RkMzSiKbcw9nkLTD?=
 =?us-ascii?Q?LwV2oyE75SL7vYR0Q8Nv/A2mDgibqUEKMAAGo5E/5WiaRBFcDyoCjHxylChu?=
 =?us-ascii?Q?TSx1udd82d2Dmtk1KOvsQELy8alIvKPQLzdjuT1MHuHjTfImf9CGHfbLNKDz?=
 =?us-ascii?Q?YDUxlk+NPh5Dedzf+acmLdwTISSjZMj8aLdeLi2L145o767/eNr9f0mpyjTI?=
 =?us-ascii?Q?1JWOP/pA+GPdozqd0zRqOawAD+KLHyYT+jW58YIHVtYlEQjGBGvIpbuz0ERn?=
 =?us-ascii?Q?3KnCQCdFCBWNpAeljlcIwY2w2JUpvDYTOQdWU4bKkRKr+VkCREMJMQIVd4+f?=
 =?us-ascii?Q?06iuEAzj9MsaTLJT95UVnDoLiTt9/7UwjLvJ9S+MeZ6njjVwSEIyvVTO/fiX?=
 =?us-ascii?Q?Qu9LmGXrvTaA9u4oz/fbkBzBIhde5SzcMXA4/rgIHWfk8/MpI5aE4bDrJvPT?=
 =?us-ascii?Q?ad2NEtWES/4nQIYBGsqrg/4CggH1m+hoj5ebK2IA5l14cIUtQHHo9UnORKoO?=
 =?us-ascii?Q?ZWKDD6fm2Zot0+1SMLq2HqppJtU59gYj0a6oo9BSEbGMjvN8DW4AoaC/W4FW?=
 =?us-ascii?Q?vo//pynHGpfGBKMM1ZebOuGNLk3gPHzJ02FQpk3kgJ5msn6oFb57FY4gHGhU?=
 =?us-ascii?Q?RnIaI4kZ2cS9o3m5dOfnlQMmIN7w97FMw04caFi5Dn7Rqo4hItG9Q1UjXDzc?=
 =?us-ascii?Q?y0rM7aP1TYSzgT9R218ub7ZTnWoq3Lewp69sPzS9O9rXn83HwCtL/Kzm2rrK?=
 =?us-ascii?Q?XH6I3zzjmykIdtMcTLhlyAlOglSCx9rOlHshtkdg4z1gW7KG42Lg0+SWRDUD?=
 =?us-ascii?Q?/p7Mh9QhMoDN747Vmas1ONUx3FGH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d3b025-86f9-4318-c6e2-08de45d2d67f
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 05:34:58.2254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17012
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

On Sat, 27 Dec 2025 07:24:15 -0700, Simon Glass <sjg@chromium.org> wrote:

> Hi Shiji,
> 
> On Wed, 10 Dec 2025 at 23:39, Shiji Yang <yangshiji66@outlook.com> wrote:
> >
> > If the Ctrl-C flag is not cleared before exiting the for/until/while
> > loop, the next loop command will be unconditionally interrupted.
> >
> > Closes: https://lore.kernel.org/u-boot/OS7PR01MB138341D2719717E66B069F33FBCA0A@OS7PR01MB13834.jpnprd01.prod.outlook.com/
> 
> What is this, please? The link does not seem to work for me. But
> really the detail there should be copied into this commit message, so
> we can see what is going on.
> 
> > Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> > ---
> >  common/cli_hush.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/common/cli_hush.c b/common/cli_hush.c
> > index 7bd6943d3ed..ec07bf6b3be 100644
> > --- a/common/cli_hush.c
> > +++ b/common/cli_hush.c
> > @@ -1798,6 +1798,7 @@ static int run_list_real(struct pipe *pi)
> >                                 /* check Ctrl-C */
> >                                 ctrlc();
> >                                 if ((had_ctrlc())) {
> > +                                       clear_ctrlc();
> >                                         return 1;
> >                                 }
> >  #endif
> > --
> > 2.51.0
> >
> 
> Regards,
> Simon
> 

Hi! Thanks for your review. I've send a new patch to address this
Ctrl-C and cc to you.

https://lists.denx.de/pipermail/u-boot/2025-December/606342.html
https://lore.kernel.org/u-boot/OS7PR01MB13834BB74CEC85C67277849A2BCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com/

Regards,
Shiji
