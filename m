Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D012CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 09:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 005ED80E07;
	Sun, 11 Oct 2026 09:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id butAwM4nnSCu; Sun, 11 Oct 2026 09:18:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58B0F80E13
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791710284;
	b=hAgshgVLmcv9Uos+6RK4eSkxHGhiVLgqA/M0r6RTeTvLtM4hHgXn5YGBpMLTyE5yf0nm
	 Obvw198g0ILEnjgpVMHPP+TF08zOw1EHfEl1Aa/OWHtbECTIsYqb2IPd+3r3GkB8D0W6A
	 ZGssEaF46Chju5j2dbC1TiJhKFpJHG/vYoB1FMtsaDgGGnFCVaNDr8z38ejihEWOH9DY8
	 xtG8KQoLT1OLknNIYBWY5hSzYPe7lY+MsJX+fFJMgmz2hJOfrY2QmakUut7mW47bpLEPp
	 6WRMtyB75tLaIonhm38TZ5Oz0vaU3HXsPbzsL9rt6vvxnqpfMxm5NHvtPb4nAp4KJMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791710284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GL+ok7k34LD4mQrV8b1EZOIxc39nQT9oOBomlz4oMFI=;
	b=DCukCKGPP6pPO/O9rqA0vhjVd2XaveM17KATNJ1e99RA0BaVPSVuZh8ggWHrauxFMSXF
	 Y0gmS+MUhxIujE4+kwQZ4HJQqwA6YSyBrIWvnR6ugFwc2h2ifLoe5KRccN5RZGrs3cRLN
	 rXd6ZJxgLQ7q6r6qt5YiOwDSj6/nUdCuC7243bxS66wk0CZ1ZkEDH45jjydKLpYeWW3+N
	 ZxYMWk93L6qmID+WIuGQkZTV27lVw0jSoQmfSAZB9+BjtqQlL/74AckQVc0sqveY6mxC4
	 DSgvIOKaWNLgJdUwJckuFwBkmz2RZXI2OYcXwPRbViXxP5kJjGUUymkOkdCXGG6Vlmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=toradex.com;
	dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=fgGaW+oG;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791710284;
	bh=GL+ok7k34LD4mQrV8b1EZOIxc39nQT9oOBomlz4oMFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ohmn5RfihNq4avQv+1nzu6Xh1mIbcfeA01lW+fXyxdjGfQWtqezxBRoDBLBVvMBKq
	 gNo/td2UN5Gr8gur3rTZUsBs8pUyItQJMnX2EV31BSy54w90wPOtK1CgzTBPg3+un/
	 eUTvhf0jLdu1Y/MdxQAnu2iquXXWMNp19ztc4f+icw3RyzaLwr/PCg7+kATNitbYyA
	 e4NokK0sLBH+hOztW82ffen2IQ4+MQ8qWF0zG5KY7v3AdeOdihMCWaBOyFJ54voQUb
	 SkxfjLYRqEp7lkaKcpKu1EHZpaWbfBcYxOWK8XXQS9eUmyMz4WnSYwXZCHiluUFHV8
	 Kplw/sgoce4hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58B0F80E13;
	Sun, 11 Oct 2026 09:18:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CBCFE380
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1B9380E13
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:18:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpGwTohMCP0s for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 09:18:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA24D80E07
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=194.104.109.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791710282;
 b=dPisQEfuK6hxaX0vQjfDDDOwukoa0mqyK2ReJdUK9s4qrWPm7XK8CzBnG0/LS9Yd6aR3
 WJMMVOP7E+Zv+ccaCmMiiKxPdkNujjKeTEF3i3/UBwkwoCP6AIAZJMSgrbw9F+pjWE97z
 sSA5mEqai8QtcL+9sny4hKBkg94sq+C6Yr+izkEtIbHiMzM2j6k/KN8EQNizHdQ9yhdEr
 g9bgU6BkD0JndIEmjiBXk/RBXBi6WVeH25b2Lo0+gADy57ivS+YQcqF8Do4uXRBiaDGX8
 czV926x05jYBuoRt5UWQI5GHxrKCUceuUHjxImQ3l3zIbadkrfdakv1PsA3nKt0JWoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791710282;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=GL+ok7k34LD4mQrV8b1EZOIxc39nQT9oOBomlz4oMFI=;
 b=I5WjaeJ5LR8yG6LAzQm/Sdfspel+E050kXWbxCIqj9y0pOP1NWMljB7Y86T3KyAVxn4a
 qCdGqRQSMEAPIy5u+lQ487zLvWZi/pqnDs83FAN6wLWxYZCVL8E/f7dmvgPgiG62iRKBP
 ivxTUcwoc1/fcFkwvwmiVWEg7ycmpeyulMsfhXGqP4PERe5xTM7Unh8yyGf1YTtL7r9o0
 402zU73/gEACEpY+1LaBllRVeIM6pXXkTpMR6FCAWYgcFwy95IQUJs+qzUeCZ+DVg6zpr
 OTiT/TDHrW9bOq6kQlfy2OOwgdu8I7lIATjgOFo3oBxiupquSD1vzB0KsRbsVK69zkQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=toradex.com;
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=fgGaW+oG; 
 arc=none smtp.remote-ip=194.104.109.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com
 header.a=rsa-sha256 header.s=toradex-com header.b=fgGaW+oG
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA24D80E07
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1791710279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GL+ok7k34LD4mQrV8b1EZOIxc39nQT9oOBomlz4oMFI=;
 b=fgGaW+oGiXmektsPnEBkUiJ2xBdHErweMI5BB+bah3E/dNSc/oiBXQFl5qjq3/t5IqL9vs
 D3Mj+sD1RGO7sj8VqdP1JnVCRsR5HjwnreDCzLsT+14yyiLYkry1uLK19/EDPQzh4UzCAV
 pv+Yov/0iRpFthbJkFGt3celjG9t92E=
Received: from GVAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandwestazon11020093.outbound.protection.outlook.com
 [52.101.188.93]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-17-zEV6DM4EOi6wdTVfRlvm6Q-1; Sun, 11 Oct 2026 09:17:57 +0000
X-MC-Unique: zEV6DM4EOi6wdTVfRlvm6Q-1
X-Mimecast-MFC-AGG-ID: zEV6DM4EOi6wdTVfRlvm6Q_1791710277
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1688.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:65::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Sun, 11 Oct 2026 09:17:56 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 09:17:55 +0000
Date: Sun, 11 Oct 2026 11:17:54 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 emanuele.ghidoli@toradex.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH 2/2] toradex: {aquila, smarc, verdin}-imx95: Enable
 caches in SPL
Message-ID: <astUQpojAQPoglo7@francesco-nb>
References: <20261010075951.3939861-1-ye.li@oss.nxp.com>
 <20261010075951.3939861-2-ye.li@oss.nxp.com>
In-Reply-To: <20261010075951.3939861-2-ye.li@oss.nxp.com>
X-ClientProxiedBy: ZR0P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::21) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1688:EE_
X-MS-Office365-Filtering-Correlation-Id: 401c424c-feb7-49f0-8389-08df277888dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|4143699003|56012099006
X-Microsoft-Antispam-Message-Info: zcSNaELdspCyVr6+4zJjXWdg8EjKJlxhOWWUEIJB63tOAAFe7eJ0GnIgrMuAYVdY+X1lCD+F8p4HSBFBAz22w7M4jIjSljxOnyPOg1NXk3inMXeVJB29cCWtKGe/m9cyc39nokgkNEy30d8ndjUQr1MbaCXQHEj6K5uYcjbSdMq9ZINDKGyYn6AHerg8T0WARLYmeSc8yb8Di3UTzm/tYol0xOfhY79lvTwJa1JDUs31CMUZxr7KByOM5HQflONdm/rYqe4eBKIOFWf+72Enm9hfWL6fNDdlxNeJmoXSPatYmlDPEofsJewOyEvJd40xV3LgWM+8j+XVvFyLr3a+HIFrapnpsdYbO4L/k0oo+qUjdd5B6837ktymgZUoSFYyHy2/Z+nwn/N+3PkSc7KEsq+7x/KkTbGud24orVa2tO9uF4B78uVHesQrLwpkGqkaixez0ZAo6Amqfwt9Htp6BjN+pGxn2TDlLRMlryVT2fS1lUNOCVUj4F0hU0UPDzoKKDLGVIy2jPAHx9BJkbYr45Mx+eRoC3TBEH9RIGPuRcczSpKzlm2VZkmxFpvxhtmZBN7vgUkXbf9oz28p99IAhgzHoUSoT9dn0smA+ylJ2p/KTPodwt7M/DWagHiDnlk1wKLIk0jQpBL2Tu9i9KirwL9V5iIlKIrMnsHNnGOzfTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MUWz1TNaFup31X0gEVygmLXDeaz0eDBSIMHsO+PrZnfYFt8SNQd2cdvrtCG?=
 =?us-ascii?Q?sL4emCjsuM5y7q+SeeJJlW6v4rvgOfz+akXYu9++WYH+4fEh/36KQXKQ18fs?=
 =?us-ascii?Q?MWxMSgfnQTkB7l+UWtUdoE41ULhFANPc1uHG+uOurTt4vEik4qFazllJgtlP?=
 =?us-ascii?Q?xfj3Vm3OGx/ZDWj5jzDPPtSB/er9Z1lse2HjO41TubODt64wbnQT+w5LUINm?=
 =?us-ascii?Q?naCr6vaHsJn668t5+CEY/nNjGuwvZj6O4PjNyVawTBOEtd0PtpSXY9cMRwMg?=
 =?us-ascii?Q?X8mof/55WTJdZXdRBIghGXQZINOr1DxB9GDO24iTX11609wRywhWuXzRv7iM?=
 =?us-ascii?Q?Qh1wfo0vaalNKlxGYbypmehMUuOH4mvjBq0wjlYhAUpJiUx1ljJk11jIKFIk?=
 =?us-ascii?Q?sip8ny8orofSjgMCleP9UbUgRSelyTA5DgkTrXe9xLsaTiFIEBzU7rUNcdng?=
 =?us-ascii?Q?JrhxwRfesxW0DfJ+qe8BU9cvMqvEmXOnat1Enr3o863qVXehnnDTkRvbhzAh?=
 =?us-ascii?Q?P2B6FdoRC7QSg3LbU4e6+YFAoovdjoUWHFCdO5Sc2a5pIn/dRPfFCutI9J4E?=
 =?us-ascii?Q?c87OMk/rIKF3Fskv2c/1Hd1R/Hpjxfadri8ofrLwYlmwx4IFOxQFc96aQutL?=
 =?us-ascii?Q?srz3fZL8H32Q21QvDbjlv5WVBCxydv5U9r+QFz4AXXQMe9ewaya2cG4/vvyC?=
 =?us-ascii?Q?IjvSz3DLfOYIL6QtEAxmpGobrQfb8S6WtWllbV4dRuMMQZ4XiXz5KZRhdZ2y?=
 =?us-ascii?Q?vEhBBewbYNeR0xytjeZW8cDqMhd3NIPtTbizbqblaKW3BjLG7pnJA8dPnUQR?=
 =?us-ascii?Q?0GD7k8fKEOK4+1Mq70LLN83LiJo8KlT/cb5++stf6/7aymYfzqMRvVtkhOMc?=
 =?us-ascii?Q?Tu6nE9hlT6xR9g+Do+2QckOJ/3iF/z9vR72PMLIHrmJTKw8q837AUSV/LKXe?=
 =?us-ascii?Q?BFYtPMH3wkLM0qfQwZQ0JW/LFceYrEbFssX4AT5qAT8cqrmGCrqCMD139Bxu?=
 =?us-ascii?Q?nQqQPNpt8su7EvSAsS79ZQurAuQHoRtGJWyzVYPWi7WBSoMn30jZx3oJQlCe?=
 =?us-ascii?Q?U4E5MscD+mPLW1G98EzlyiQu9xzvf6UM44C3J57tcj/VrXzAALCUO71nFMVA?=
 =?us-ascii?Q?sdrOtWetrhv/GwUgUQJxI/xOHhGjJj69aKG31WvRlNkmMl88Zo2LdsB5Zfw9?=
 =?us-ascii?Q?UzelOqJnfFdvB9NOKB2MZczjZBQLIhQN0zNHStbPjxe5jXvHMiPedtqSk5jw?=
 =?us-ascii?Q?zJnMMeYIYWlEOq12wrfwYLXMy3TnOgXys2yJpEUHDBq0U5a4VDWAfcy0u+Kl?=
 =?us-ascii?Q?zXmq/qL1c7UFKlJoRQ1QQh6ro7GXgGJg8RAfuL1r50G1cUi5RWahz8NoyF/j?=
 =?us-ascii?Q?iHKD6DzLuV2XxTuQIlEs/c2WWTFA9PK6bbYuaBCDymgNhdPmcXMsHZUsDKB9?=
 =?us-ascii?Q?cXiLlBEUxMfnd9rBMG8zY8NjnGdb2XSaU/3GYSNqaTYEsk21C7hIOKPfGLHZ?=
 =?us-ascii?Q?4JLVbotFIt494Pke0oxzWOWbL871VjZmtjouBNRhq+bhM+0wTGosbdmDWUb1?=
 =?us-ascii?Q?6h2XJi7E/dt4SLLkp8IpK3jjXYp9//C4gpTruUBYEBoUGohgVC9wHl59fyWP?=
 =?us-ascii?Q?Q2vzokZ1t/1By29YI49lpJlgq0lC/AgNN9O/Yv01s/Yt9GJE5hlYSTRu/mdN?=
 =?us-ascii?Q?Ph7x4/wwYbBcFz1tLsC0/L8lvfpA1LLJjLHHk4w9XoskvOm65omYAcN1OfQc?=
 =?us-ascii?Q?LmWanxxOxnWipF0Q54q5SW6Y61jl22c=3D?=
X-Exchange-RoutingPolicyChecked: VrxktzQUAY0qEtsBvN9TlOCyRLN5ZP6WnOv8TfHZq/LkFp7hNIFz++USQqbHWTgKoaWYyjxP1VCjrhbh6jvI574l0OU4xUiNxc+77P8U9OfzPGl6IuJisK14esUnCObCOeTIjdC19Qhw+frzo9eizHFG9AYkxJ8h4AjcIHFaigFXErTG9qVEHVAqu/+Dhny2FMp+jj9sgjdzRzCl35rE7UCdJm9Y1vRCsILjPIX9TM93QfALd/cvk6aD0zJTiz3xfuPQ2lRcsykJdmahvAnTKVB9BYByTrJZddMRcr/RWyEyvLUgaozM1UrxApVN47+Fk3iUNo/O2/MWEo4IMt5OVQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401c424c-feb7-49f0-8389-08df277888dc
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 09:17:55.6922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS/G5MXwRt+hYp5rtKjWHBxbk4whsgw4KrFSQNXufRzXKcdPz5kFa8dJJ5OznHI4GKzL/o3GEMlvwciW7SE/tSbP1kCdF7+I3qKdpnveH9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1688
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 73TzHskRyZXpejW4lM5rEoYtz7zRAbuSJFH_w2j-ORQ_1791710277
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

On Sat, Oct 10, 2026 at 03:59:51PM +0800, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> To enable icache and dcache in SPL, add the definition of secure DDR
> space which could be accessed by SPL and move arch_cpu_init before
> spl_early_init.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

