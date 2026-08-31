Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2607C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A206605F9;
	Mon, 31 Aug 2026 07:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KluMk0qK9pn; Mon, 31 Aug 2026 07:32:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788161556;
	bh=HjsecZXx+Bpw2jlVQQbROARlCI72Elsx0L00zY4hhmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VAl/uRDz3IyyX4SHsMHRpQOuSqRA0qVa51TyPcjrcbQ9qfs0EMIirvwhGLpqB3SiM
	 C4K/zxFjgpQWXXN4kO5+cMh3yq/jrPPAMgorS473/0xGATpMTtRPQiXbW1PChovKoK
	 +HZflafllGNPp/9ceyXxKl49gSykg1ntL9F5XcX8tLQWLq+OdTPG8+QIAvpZTlXzs9
	 BqP2tSkwRPo3bIIL/ByGr69D0id0UfbFO1gBWyZOY9qxuwsFHFR0JN4AFl+LFLd0zK
	 Gcw2Ed99U7As3ZO6qkaTLekuVXvGRzKdnXz6W06hT2nuWBNREsRInFNEBzcmfo8i+W
	 txDZ6+BBIh6LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98899605DF;
	Mon, 31 Aug 2026 07:32:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B70334
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D520880BDD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRoHuuai98ia for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:32:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=bHZv3D29
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EE8F80BE9
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1788161550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjsecZXx+Bpw2jlVQQbROARlCI72Elsx0L00zY4hhmE=;
 b=bHZv3D29bnQYjU6C3vgznkP5VPqXd6ggminW+xxc7ve5zk58N++zkvJtXd0xr6UGTN7iiv
 vkk+o/zEUrn+e3tz15i0cg8qeUTQdb4CTQ6u5KuuPI7Y1Hl5jeNOI00VpZu6tQxDNVM9l5
 HLwZcmKcFX7XMIRk8ITXyS+psHV98zg=
Received: from GVAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandwestazon11020115.outbound.protection.outlook.com
 [52.101.188.115]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-9-metcq71BMlSNUe4WTGJ2yw-1; Mon, 31 Aug 2026 09:32:27 +0200
X-MC-Unique: metcq71BMlSNUe4WTGJ2yw-1
X-Mimecast-MFC-AGG-ID: metcq71BMlSNUe4WTGJ2yw_1788161547
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 07:32:24 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:32:24 +0000
Date: Mon, 31 Aug 2026 09:32:21 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <apUuBcsqkBEIWp8g@francesco-nb>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1159:EE_
X-MS-Office365-Filtering-Correlation-Id: feef99fd-db16-4525-9817-08df0731ffbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|22082099003|4143699003|18002099003
X-Microsoft-Antispam-Message-Info: GB1dvQWG8ywCASsyVPjs3EB91/4ZQ4Yl6wfk7rRBWHQQdBfTigrpks5j92TiHpxTE1VMaooPtMMIii/SIxn8RhR5SaY+BboYIWNGCZVlfnxWz/8oKwxLOJGRuB1E1ZqFqy3C47NBy672SaI3Vy2wzCt2lpm+X5TyA2KqcBEUWr2FI2HHFG3PwuPm/uFo7XAb/WCvisXhm7/MGLJS75Ck26MzCpcrj53/+xvDMrgIJvnjzW30h0GT9+GBM5tv4unuyWrYs72R6C8x93LiF8DqdZcLI2SPlslck374kP4sMPvnxZhvkLK2HMB5g8yubNEw1xPuq5Zz9V7FiZZ+0lUIYqLWejjvVXhkozCLYWez7pKn5WCRv0E9vDgjo+/wrbCMIKDUjKLVA0LAoovtTqq4WJjY7PtNZFUHDTTLmgWF3lkALTIujURZb8eyl7WLTu1tt0ynJ8axM/BuKrEcXH88XDywPRCDXd8EvLteN2DpmgDETaDAdN3CFxI1GnaTjbgGo/e1TaypV/p2KCIXqrrwdNWMcERvucXWhsx0et30/5d3YROC1ErqSMMKnH7vxq6B7N5uPZQCqGPdxN6ZwhK2UddnJljSDRUDt234/sHbhVuM8Km5AVh920L1xOpY5BBQ5bW08476sPy1MdM6/EayWIxsZDXuMrhwHf010y/4dbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYZgZ4QIzNvKx+bLPNNcmflpajGCeCnLu9W0kdkpBJvNntjZKQQ0QH8Adhr+?=
 =?us-ascii?Q?nAYqyer79wtHHlny/GHux/G0TfJ5HnHpIN4gilHi6X1qAoTzABE+eoHCi+VM?=
 =?us-ascii?Q?bMgzTiXZqZfNOV6m5+lLsV2ljdORyZzokClBt3drXRnEi1YMqTsr7Nw/KJy4?=
 =?us-ascii?Q?SS4hjy3Idag0jEuo+OiLi6tbcnMF7F6fSbNas/skpTbRNCMoGrZB471UqMih?=
 =?us-ascii?Q?JjziPUgUr6F1Jpm9VJMJGEgiJc9twSYZ92U/hlZFeH6cSAGmaHt4CodVfv+k?=
 =?us-ascii?Q?nCdzYay0u/3jH/h6+f/+f3YeagRsyv3kp9UMlT8PJVSnhNSd0LziIYD+6ERF?=
 =?us-ascii?Q?nd1AwFIJ/e0QTJ6yIwgEgQqzM4YK51oIdqjGWXIs6wppkirzC5hjDYzGZKqk?=
 =?us-ascii?Q?t5iv5lhcdXge4LgXlaz5Uh2SYvsSZHaIBckdRFPc9yGMxJ9A3qrr4iQhxSSf?=
 =?us-ascii?Q?mRuFyHT+IqW6HP1s+Vu3VQwtv7u+l0xld72DPBMLG8dHOS/6LK6UvFd4Ensh?=
 =?us-ascii?Q?Rd1QlesTy0Pm5GBfnl4vBpCSJuYedpIRVCNs4B2ZDN3xvVvvY+GMitauz4tX?=
 =?us-ascii?Q?yDUxgy8J//FF8IVpg+s3LjuzFKxksoGyVMMbm6IefnqMQS9aPx4PC2mgsviX?=
 =?us-ascii?Q?FE+WiCGMXRJBG2cCnJr+2tjwRlcTC7ge9qAAcn8KHtfavp9zLi/Rhlyp566F?=
 =?us-ascii?Q?9wllF0MgHZPVreWhdG5ZdpcbQU3mAMTs50/w9XmBCqxifIfzLi3aKP2O4qbL?=
 =?us-ascii?Q?DuO2vRYPgkuh5eAg6aaCuNlPAxh5iU/9tcjZz4WQ9hmWxoCueJiTWWmKWcOU?=
 =?us-ascii?Q?IlB7Ni9QoEXUm6YpXzGDDGPXGsNzdPDwQO6q7/eeL8pQNGKBY5ulo/Uzs39D?=
 =?us-ascii?Q?oDiYuc567/nAWCe3uvXAuP1+a44+g7yG6mU+ENJJOu1VPXo4moYyUIzsuk1x?=
 =?us-ascii?Q?aqhemaFFJ2oUVQCUKvgsSeCscelbHLZnDkuQqZazdvo3hLHEaqR9S3XSzpQr?=
 =?us-ascii?Q?Nkqmt4I22mYYjk1YpPFI/CUIpy4V2OP48XbCOrtjTMrpC8DwvZ/pb6gouJzS?=
 =?us-ascii?Q?dVCL2zlVfE5jbFY2uEnpCJ53ioB1EEi1pnAbnasLYi7MUqqcB85KAyneaz9R?=
 =?us-ascii?Q?gJBAZnfTERukvG7k37LhKhCP0SGv/dW9eBV2SKeTVnsGeIXGu31Oevm/rr9c?=
 =?us-ascii?Q?C/pXqjWrOOiGj+nWmjExVsvwvqJwNHFiT2/PiYv5DRo7EnApHQWBc9DPoexo?=
 =?us-ascii?Q?LPHVZ66WJjSp52Bxabnew9ToaVTM3NHRg42aczDRwZ3g0gcN0r212ECOTPAF?=
 =?us-ascii?Q?j4v5qMld5+nja7X02N45Rc0yp8GGl3Nx9uHoLumyoG6Xg1gZJZ+1E3zW926q?=
 =?us-ascii?Q?dPlbBh7d/YRCur/uqMecmrFvCPxIaCh5LNeWTqrk+itr4ObL1s8W+PQfoTX8?=
 =?us-ascii?Q?TWGUplRgOKvnsIt6r0dTzTBAFpNJN4ugA36Tcywo0Y2NKax15DjX4bh8W164?=
 =?us-ascii?Q?Pevotr8ja0Rd7u0NVed0YvXfqbmeOpxGI/nNy09pSUbltuLxhdrq0/8fVbsj?=
 =?us-ascii?Q?jnXkYDYgTEssWt1AgpJhovcHQaSm5Rzv40pczQ5JlmQQkCeuWcj8kIl1qW+l?=
 =?us-ascii?Q?KjwBGECpUxSdG2rbhY8vbFDm1iLPjiPAIr2rKTGiCJksRznzwV9lleZkI8PC?=
 =?us-ascii?Q?xAVchCLed9ePmgmiTcBaat4lM6niFCfkCmdiyVnmqEi7FntknIZJmOoIl1CC?=
 =?us-ascii?Q?cMuqRsIwvCuq6mlBL6bcFhNXaLZNDlA=3D?=
X-Exchange-RoutingPolicyChecked: Dn5wfE31EH5jOvtm4+o4++u+9dVbOHCba2vo2PRKIzn+Yvp/p7E45rYryO3kCSBn029aHp4b/iugO6fntzABasQaf0MkxhqdO0rR9LVT6Gf7tBSc5nxWMzRWhMgMNaqXciD7YCL+QX4/wjIW8R6Ufw4xy1YCJ2EUDdJbafJKtA7qd5mI7hwDesXvP79byiu+ZABFacnpwDL3HKBUfzmnUhFBRM9MNOPL8U0NaUsMyrlBrIDelmSXfB197DXNaN1ImN2ITgHZg2JD3zwwyfmwoFNapOMkVkCEbil5avi1DJLhYDStRdpL4BBJ/RZEanWRu7ii5b9K/gBOPllv3ngVUQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feef99fd-db16-4525-9817-08df0731ffbc
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:32:24.2175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJEaeTZLIevnKn/D8yh24qeAFNvIymugjqf4DHu5MgoZrUrDUKtHB6NPMI+kzCFxWWCefs1U1ejtngcMuusazuW78IA7KsmxVoiUPfp2CFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1159
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aNls-ONt0Z2Ev7O7LM5SQMpF0uxZI0XeLA7ibEV-l8Y_1788161547
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 09:18:48AM +0200, Michal Simek wrote:
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

...

> diff --git a/board/toradex/smarc-imx8mp/MAINTAINERS b/board/toradex/smarc=
-imx8mp/MAINTAINERS
> index f7fcef1c0921..056750c50fb4 100644
> --- a/board/toradex/smarc-imx8mp/MAINTAINERS
> +++ b/board/toradex/smarc-imx8mp/MAINTAINERS
> @@ -3,7 +3,6 @@ F:=09arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
>  F:=09board/toradex/smarc-imx8mp/
>  F:=09board/toradex/common/
>  F:=09configs/toradex-smarc-imx8mp_defconfig
> -F:=09doc/board/toradex/toradex-smarc-imx8mp.rst
>  F:=09include/configs/toradex-smarc-imx8mp.h
>  M:=09Francesco Dolcini <francesco.dolcini@toradex.com>
>  S:=09Maintained

thanks for the patch!  this one was an error in the original submission,
it should be doc/board/toradex/smarc-imx8mp.rst

I can send a follow-up on this, or you can fix-it-up on this patch, both
works for me.

thanks again,
Francesco

