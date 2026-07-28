Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABD3C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 14:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0122813AD;
	Tue, 28 Jul 2026 14:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfL-WMCpUuM2; Tue, 28 Jul 2026 14:40:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E7EC813C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785249657;
	bh=UcZIu/LeA4dNUQ4TzO+alMqtDsI6nwJ5n1WJssOZMiQ=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VY1NzW8D9KEMn68Iz1NuzCZ2ChyhKgGBPrUv9reP4uFlHKW227CTl0Y0fcjB148Oi
	 lWst9oVhUvU8YMMe9OxN9FfM70waCajNQxL/Yg7WgBwE3o1Fm63pXs8k6yqO6uAjxd
	 92KcB/ETe3KT3VR/No0qxh8NdnTMkxpy52IuF58CDJRKjQ3GEtgv0USsa6hsoogUiq
	 eDyNoJO34vZmMqo61djtW8qO1hV/oW3wiwSfcuHRQAhcpSRFpDtT5H/F34/gcXv5BI
	 aoX4FFA2pYJ8cegG2KZa0vdglo9TSO/s1+UFVxmxiifQyaiyBCKqAThgpHkrPqsPFU
	 peUqxuNxyngfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E7EC813C6;
	Tue, 28 Jul 2026 14:40:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C5252E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C6FF813AD
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5UdVFHYb2gO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 14:40:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7B502813A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B502813A7
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B502813A7
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmlfrvcDbZaObm+pdWUDgDZ7jOpMvgZpeJ6O0+SE4bD3X2q5K6sKnMOf+qyppIoFnsTQ5vdjBrvGdZWaoV5YTuAH6+lbT7xY4LRBOLrbVmM+P4WhLFvrWS2QZSqY1LkWLSxrPae3rdKk+5FA5AZDDShGC3cVjufeMHMqiOWvACyiNcWvUfnlChGMugLpumm8vHIUPOXWfsz2RNzaTdoN+j7jNdkUJoQYNsh39PttMaSTzZKgN18OC3d4CweddmWRb2ae/SAsbxPbeuvw7YRb2TSriW6rWJShr5LFf8kRA76WtQFvXg/THbR0UMs5s/CCrlwAvtQ4s4lLCzKc5hO4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcZIu/LeA4dNUQ4TzO+alMqtDsI6nwJ5n1WJssOZMiQ=;
 b=HiqAFp6hhRN6eNS+uMHSPlVU+DMJSqXYvvzUleW+tLEyS0szLJ4iNCnZEDeJ2Pe3hp6eO9IPNGwD4Ri18FwQ3DQYQ4Y1ULtWKVp6+nXqnTNqy5QMMV57FxYxRFcW/UJkFcBr1UZ6I6sHvEJihYy9fDSYeXWkt385rOtpsGsp7+OCPEw3ddjA03vX7YGmZxdCjezrBeUjFBgWkJi+pxFJvJhKVzOXC7ECduDZBQj0oMMJissPRMvPlp9L6LexEGucuTvCDlXwYRkDRnscg0lBfeiWpHV3bJwAxGpilsyHg+D1UgMckaFyEMVhcs4+Nc/6RhOautdChf/xZ3fixMpmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB5139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:330::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:40:45 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 14:40:45 +0000
To: "Sergio Prado" <sergio.prado@e-labworks.com>
Cc: u-boot@lists.u-boot-project.org,  <trini@konsulko.com>,
 <sjg@chromium.org>,  <alpernebiyasak@gmail.com>,
 <marek.vasut+renesas@mailbox.org>,  <ilias.apalodimas@linaro.org>,
 <pbrobinson@gmail.com>,  <sughosh.ganu@arm.com>,
 <wolfgang.wallner@at.abb.com>,  <xypron.glpk@gmx.de>,
 <quentin.schulz@cherry.de>,  <jj251510319013@gmail.com>,
 <Wojciech.Dubowik@mt.com>
Subject: Re: [PATCH v6 0/5] binman: add PKCS#11/HSM signing support for X509
 certificates
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com> (Sergio
 Prado's message of "Tue, 28 Jul 2026 08:35:30 -0300")
References: <4LN_e4Mi0TK99Phw-qnFJv5fIiv9tloFlexssVWY2btc8KqK4_JhOcNLziBlaQYe1fRY5-gnFHrYEYQjBOTiPw==@protonmail.internalid>
 <20260728113535.128601-1-sergio.prado@e-labworks.com>
Date: Tue, 28 Jul 2026 16:40:43 +0200
Message-ID: <878q6v9nys.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0012.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6921e0-df06-4a84-9cb7-08deecb634d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XRROuGGYX64p9Gk5le1aUvbtIqcYsur9MamwRGurqlv1/DXpjph3otXnie+f8skiRdMWboR7DWhUR18T+ndoqxL1d43rS6bUJw0eYEpfmK2n+bkNVRMoAdciPnPUmREkJtmy+R0W7JD37TnGQsIkiZnJFSxq+8d7YjeRUkp13ZazYDF7zDWtKy/61KY1EcFBPNf57RhwlkFQAbtBdWGOqpVwAjL8gMbXODafMLhn9xEHCv7BqUX0UEobNMPP8vfsM/TYjIoOr4s5bjNSyR5JQ2st7212+Sb4/TdHuloCINGggKXimUSOeg7W1quaFVeXbN6ZMpHeWtbGZwZtQ9DLpo6LETKPrbGKl0KrffYS2e3rGfxKM0FcA68vJ+nEJUZAVA5hUM2hAH5uCJuIdfiinuptOqkOC0/tzuV00CorT8OCGc9rdIfZBvNG/7+Yz3/H/iPYNbBzWoF9NPXLLXad8Uc4A03icfXX5oFsaLuaVFqd5sqMWDdITlt1351hQ0oKWI6ektjXyVhNIyKx1iC9keg1CdusaQQ6QCevbSp0cK6YWN8CLu0kVIjvVV3jnrDUyjXeWMIr4kAK0S14HTDH3HCl4XfanTTYFC4OkXinGevHkkwM/9Rf/OA+IukAb6m+pMbb8dc84gwVfOLiVIe8wo/uuIkDgmGfxlJKIPA0o70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8xJyFoe32x6az9U+oxkVwEgRBCMa0VPk+2tnl+sLwcqUskajiaoO03UHfNT?=
 =?us-ascii?Q?aqjwtPZpoG/1UNuWAAJM+MMLyRpRVgQNtut+tdMIG/XibJOWVFOQI32gcrz/?=
 =?us-ascii?Q?g8gemJW7pozhoHgrYG97/Nuik7tT16xIDXZLLpONAbiRgTlyPC4JMIkiwGn/?=
 =?us-ascii?Q?TCsAAqNegBtWe00Pa6XdXAfCMgfuXoLcylv4Yywfgj5zwrkVWLP5HOOKdW8w?=
 =?us-ascii?Q?G+lRruuvdfKxIFeNdPr9YnFTQVVPoqcf0us9GoXjuuIvNp9ji/aSkqRsomXV?=
 =?us-ascii?Q?c+mqR6Nc2kRDiGjzJ7O92pzp175ZCh2Rn85egeSfIgnBY+jMZWVuw0iOYNRr?=
 =?us-ascii?Q?srhWNZBpc/i9kXH/XfmAmfQ80HDc80j5tWgdKr2tuseO/JmCWwC4BcYUfXcG?=
 =?us-ascii?Q?YHANHLx4UUTaV02LtEckEbQJ1rocfEgkGQUUbvzZ2+NHODbj045csFlPF03K?=
 =?us-ascii?Q?ikyplK25J86G+QiOMToxxNhiBroDYlQWU4c6fvP57Otgh3g5HV0YuphtD5LU?=
 =?us-ascii?Q?xAYROUfChfY8y3BBEHrZsfveNjUQtQTqIhjP1/bo1MMdK2XnpHU44z4eIEF8?=
 =?us-ascii?Q?LNwA+A0kwfyQHHl0ceBsBpV8IKa7bZeFmvPFXY+RPb5uC2VHyeijWXlQxA1t?=
 =?us-ascii?Q?vFqn9y54t142OrA2dtr0teHC3Fik2TVDEqry7VLE9B7JOVrM8ZLD8SEkaE7p?=
 =?us-ascii?Q?+6pkgRQqvhVQnyZQosKsW57I08xfIoydBuG3CxK/57xEAEIicuq/qO4mcCNd?=
 =?us-ascii?Q?7BJ2dMpMWzqMKKphhDhm3F40B9HlbHMT9qlWHpnasPku155J2+KASOm2FTpK?=
 =?us-ascii?Q?9Q7VqTlm/yLYCrKowdZpvY4eJ45I64xfUI6oq8x3oGse845Pd07EVioEVHUa?=
 =?us-ascii?Q?HKMAa7W2mPs0NGP7CZPYIqCIbdw1OAnBOG03EPc8bzDu8r9ybL63wd8KxzRC?=
 =?us-ascii?Q?pdQflLzxFUUIl2lEstPeaxsqDtog+n7rIvCNgne9oXanWvMejIVw0Vr9Ud96?=
 =?us-ascii?Q?+d2lR0iPxGaWGsl/hKF0zk66kQUk9iWstG7JLjv7xRhuxqSePD9WgzIuD30w?=
 =?us-ascii?Q?+s6XOIxRZ8STEtcBg1BZ7ydhVwjvLe/YRN+8f3CfGdz1XRKzEX0sDQWv4OOU?=
 =?us-ascii?Q?x6QORArgMAoFDGEuRhpzLVl5abC/Aj/HSjtrpYO4NAyUnF1jLr9yZqmhPoU8?=
 =?us-ascii?Q?lzHJjkysij31009bOslgAKBLK2cFsV+ruANz9lRHNx1WO4nyv07eoewU9dFL?=
 =?us-ascii?Q?lOQ1OPI1UWAP5x52HNwccKG7cockPAnvTYzIygR1JYFFoDd/MgZVSVXOO1pj?=
 =?us-ascii?Q?IP80Vg5iegcHce4z9TpKXoSasEwM6k/eBSVxd3LK/MgSEFWlVGcNn88ZU2BB?=
 =?us-ascii?Q?CNFvencMaX0C6w7rdhkwA0obOuG7KLY3xG5Wk0sJvOMTNay05TvZbNBHwWqn?=
 =?us-ascii?Q?hS/Lf6V7kDxVBRWHAHM22WuoeXB30B2NteQZ6FD17wpmC4KIryxhMcdIbsJh?=
 =?us-ascii?Q?O/5ek/2R8SthPX0Cwy3AT91TXKEp1RXZhvt4/ypjlAahZ8254LQUMA2pijbW?=
 =?us-ascii?Q?EDX7J0d704BVrviwbSRzaJPBgJ0rmlr8uxPjSOTLCR6dBYCm/OqUUdNdUVMQ?=
 =?us-ascii?Q?Rb7ag0o3EWV+AvBOBxCnhPhRDtFNRsYyEbweWPA8vdGNEQiH4KJYaajt/n3o?=
 =?us-ascii?Q?YW7YSByRKu+PDLp+MBaR5W/UwiN6GHbNfoPAGGJ3dW6SmSYFgQA1Y+/YVqV9?=
 =?us-ascii?Q?RP0kq5nCTLIUtU3pTHegN1eO9rL+Y+k=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6921e0-df06-4a84-9cb7-08deecb634d1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:40:44.9202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj4/PrnYdD9nzMp8AL9kfwH82rWWxu6ueZXE6ak6XOFddBo0wdZdaLcZ46z8O5hJAfTgbASfJCRhBrgk74fNIHY8j9imWnrdn8aKfQn8af8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5139
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcZIu/LeA4dNUQ4TzO+alMqtDsI6nwJ5n1WJssOZMiQ=;
 b=g8d68Jq/7npIgg2TEHZaRvE7flBn1bQcQMNUiL1ImcuZK/STyUClqUiZY8lqnHJQLCUZtUoi/Y44WWrM48P3BFe2OmCD9BYL+SIvHAiP62plATKCxFYVqhcfeBeHpcqAw7nQ/u2ejxU1b4gnSshrx20rIZFPS53j2MU30QOuP/Q=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=g8d68Jq/
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
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
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 28 2026, "Sergio Prado" <sergio.prado@e-labworks.com> wrote:

> Motivation
> ----------
>
> TI K3 secure boot requires X509 certificates to be signed with a private
> key at build time. For production use, that key should never exist
> unprotected on a build machine - it belongs inside a Hardware Security
> Module (HSM) which enforces access control and keeps the key material
> unexportable.

Hi Sergio

I was completely unaware of this work when I sent
https://lore.kernel.org/u-boot/20260717135824.2142135-1-ravi@prevas.dk/
(and v1 of that); I assume your v5 must have been sent some time before
my v1.

We clearly have very similar goals, but somewhat different approaches. I
will look through your patches tomorrow and see if they would work for
us.

Rasmus
