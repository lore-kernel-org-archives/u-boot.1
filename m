Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589F7D42B8E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C9588E42;
	Tue, 12 Nov 2024 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="r42oeqt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE5489440; Tue, 12 Nov 2024 15:55:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1581088DFE
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Traut@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzZZuTeEaM9OzSXP1IhgGfL3Xk0yPs69AfjxqGvY+eGY+oMr5mn7/qMx5+HLWgj2LySEWdy+SBkiOzr4sS1I391LksBJislZ8mWGrxIVEUjG8SKgqRxDCNw/d7s7lIWMu11RWTPuSCKh2D+Pw9QSFNkV8bcSLQD/63GctsWq6UIyGwoGevmveaEh7a2rQLJ+7eA6/Dyps8Gv3PgjoKNyYVdy5sslZxky2uV+OEmywWpQ1TZ1xmMV8uMS8ky6C0J4eX4MbJARULgQ7PEySjDhVnZ7Nls5s4AFoR1+q0igXaawBwqiZo5eoHTmbFlDKV7ULcsNpgT319EwGnE0MVjSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVb3oOnG+hZ43/w6acOs3dGkl5y/Nq40SkM6a81HfYw=;
 b=p6BSR0Ro8NZnNp7GfHuFgHPCpm8Q2kXjjAq8XfKhQp1qfCkzJMqD7jPxsVldcpxnxL1SctWZyiirsaWNneurFuDLBLO0AZsky1ny3xQ5HKPmHy5JOCITh8yOj1ygYD+TWhMfWX4sBGEyNZC0hh3jyAXuUpxdu0l8Nd9x7LmRxcs5hCmqDnUZ6d0tYH2JMGA9coieWimX2MZhC9TzdMiXi4THId788jaZiBOOGhZ296XRUbRqeRM0ns0OsU9JnfCuBidobCMeiMu7U0kWl/ASIhxLy5MubgVXCYMpHXwvB2ucMWsmuKkGs6TKinUQL/HSn7dPcvFnOQ+cKMuKrMXtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVb3oOnG+hZ43/w6acOs3dGkl5y/Nq40SkM6a81HfYw=;
 b=r42oeqt730S7pDsRn7pqvnX1V9J/mnYWgCYYjPcDQrfZc06cKU1bZmeYHCiKowWZYtUgyglk0xxKycpdnA3XbhNZLVge5IL+UICcjhlMWt/aY9KGnYdP0tCAljkQbFAj/NsyyYwdotnuETyKC0jimJf5v/lMM8vrH4X1FwxfLu8COTJpsFQ7x0RMmA1K9zIOzM4YzCr916hWlCiKYNs47C2XNwkSRwwq6h0WBTpaWYo/1bfI05rsiEYJcYks/+0eIStJjpekDfZTozeMtl4rL56DqbXFq2slSAXBAbwUabb22fZ464llre93E3lKesfRkgCpO4oKX3PMfsTSeT4Mjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com (2603:10a6:102:f0::8)
 by AM9PR03MB8010.eurprd03.prod.outlook.com (2603:10a6:20b:43d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:55:37 +0000
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b]) by PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b%3]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 14:55:36 +0000
Date: Tue, 12 Nov 2024 15:55:35 +0100
From: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>,
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Burak Gerz <burak@gerz.io>
Subject: Re: EFI File renaming
Message-ID: <ZzNsZyVFuXAry8qT@mt.com>
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
 <ZzNkjdHYGXQy_kUa@mt.com>
 <CAC_iWjJEiNj+tCj64TXs5i+oqOMnEvevs1YrwPGQJ_XVkWsgsA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjJEiNj+tCj64TXs5i+oqOMnEvevs1YrwPGQJ_XVkWsgsA@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To PA4PR03MB6784.eurprd03.prod.outlook.com
 (2603:10a6:102:f0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB6784:EE_|AM9PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0910d009-60bc-4ffa-1f04-08dd032a112f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LT8h1eHO5y4ypUr64JebqRSUBLdFudAihNBeHx2dEvcelhdcWH3RE4x8gPCT?=
 =?us-ascii?Q?dWhWt3ajrG+okXqSfgiSOou1oIWm7MB6TFydjUyuHRN3lSXfNhttIj9st3ct?=
 =?us-ascii?Q?jbJ3lwFkx7+FaWg1wPr/rwNL4pXaKAfGG8Mohw6tRiOKQdFMxLuM+bVQZVHp?=
 =?us-ascii?Q?P2G1iMI7YTujmcEH1oOZ7NysC1xsuOHfK/W1mmFuWAlWyZR/BbzjhwHqclMD?=
 =?us-ascii?Q?pZ3RfQdcqfY6mAqxP5UbH+kI+wmrYxq3c4hI4QOWp/URB3bTTaE3uQjcpWPn?=
 =?us-ascii?Q?nQkr6nzAWzMyYPmEQNZbsyDaQ+RDsHtiyxndwZK8sOWpO081V8lztc64ISbH?=
 =?us-ascii?Q?Gkk5fAHigqta59otR13xMm591qsCcMGRqrN/3h4AyJC3Fqj257Js6Y/Fd72S?=
 =?us-ascii?Q?ewUvWrHoomMh4dsNDt7qkYD1ODfBUfzIU576O4VM0qR6aYeQ78tSH7qhceUp?=
 =?us-ascii?Q?Lvopyt0FYcJohaG7oCaBrYBEA0My9Q8Na/cia6Tm3l8X2KH0IoyhlpuUed/V?=
 =?us-ascii?Q?2rUbZ6qugZCb+YkYoHBcmATJ0HthRqZmucEmoIthCvdL6IQYrmJgBcwVATfp?=
 =?us-ascii?Q?nBe/rxIQfUk1oqagIEcYvEfjUaIB75xiWHfN04cJotCug2rPh9o0Y+kh6wPE?=
 =?us-ascii?Q?QoWy256QKl1wVudqRki1LLlMVnjdmKmQA4kNAtMjirTDCTixsi0fvlddgMYn?=
 =?us-ascii?Q?5UxEGKzfv1hxcoSHT1FoVufbLl/7YE5henw3zVCMXmI7WfyWF8r0plwdY32z?=
 =?us-ascii?Q?lDxLOMAD7BGL99CChHhWg4bN3Y/tQrO7fudWNAJ/Vfxks4bi++8rfKPcoC5G?=
 =?us-ascii?Q?s/tAKaavGIoDUsuK/CWKXFWhqb4nX5KmIco2eVk1l9ybcpxOJiIQ5aIy8pHv?=
 =?us-ascii?Q?Y68aCTL/0ET9qbL9S/SLMcFHVqdB817M58wqXpHeVg6tCxI+JBxtQxVuBrd7?=
 =?us-ascii?Q?dBu0tGzxUsWjigTur5uMUZgN00srpFQ7hJ+l/Vbsx3uNyVxq25c+03ELlVmt?=
 =?us-ascii?Q?aaQdopLN5W3M8dyy/cMe5aQ2aS4qA1GAEKb4M7Bez+rqQtJ/FdPdGQOTDauI?=
 =?us-ascii?Q?vTeFipaACm4i2GoCUSse6xH6/pRGa61qCCwwniA5IR6f0kXjh6IMBY4xFc0F?=
 =?us-ascii?Q?jlT4/CEMmnV4MtD0kHSn/nMpjTecBzdVlMOM82yW3RqTpsEEYu9npl56+CsI?=
 =?us-ascii?Q?Svqnt2okf9pKGgRQ0gndqkZC59CsOKGWvgzUMF3hT8c89gpKcS/6yIaSTBlb?=
 =?us-ascii?Q?61RlhR6OOE7WTzV/dQn0oanNba3YRq4tMuim6UR1DRQocr1xA2k0bKyGyOr+?=
 =?us-ascii?Q?TbeC8OKlNQOkYsRBgjvOtr1G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR03MB6784.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2D5W6lF4cs+Z5qbtLv6dtw5D+Eo+kQIBMRONuMGuSXYgpyRVmXC009UHnHbq?=
 =?us-ascii?Q?ertWw7pL5yRb8WfgQA4pTYpiUPXlxSghldcXd/V9aq6HcosCjljj64WbKijU?=
 =?us-ascii?Q?INcS/o+Pw+p6k1k9lZlcP7aN1WyKFzLIptTGMkp/2vMWPktZsiilRbGcP7OL?=
 =?us-ascii?Q?HyN472SDQkJu6t01GCBGN+/OWQ4D31PsogHmzR3Xf2z7q3POVKGYdlGT+xi2?=
 =?us-ascii?Q?XzgBsUaquX5Cly1fcvgPE8dykgBEtkQxNqgwUaIEdecGJZUjjfo1EF0PsDog?=
 =?us-ascii?Q?mtRM0c0TF6CEm0bm4nREFg/2rFkqqzCnk+p+t34ahEH9mKZOHPhEBeN+i1Nc?=
 =?us-ascii?Q?uMWiUQrt1Wlqt/hEReUFvh3GylpqABgKzEOPHuv3rpB3X33TS9+OEKKkjCs+?=
 =?us-ascii?Q?x/KIhFNf8u88oL5XrwquVmcbxAIjT89+nhSRkTFTS7xRMx4g+A9F+zhq7ca1?=
 =?us-ascii?Q?J+1lkfV2rif8kie81CikkSbrD/XJgN7xA28VDu3DsXaF63cUoLgArgRtPDhu?=
 =?us-ascii?Q?SX8VlM/nr8KpSdB2gCc7lvlNrk79xaoepAm1VDUgSSkkWB6/SRGSzSNVB9xA?=
 =?us-ascii?Q?IHN9pA1HcM3JqUu9pa5MRq2jItnSv7ovppCEY9KWeDwZZ1O3c14UsmePf+qd?=
 =?us-ascii?Q?bQpLAN3pbPDLJGRR9m+wiF/wmDavutptzoDu568s+Yl36DjFXsB7RS7psJkE?=
 =?us-ascii?Q?O0IFgV8detJxkIryhfsScnzXc6uZWRKFTktFyFg4Lk0/6hasZ3fyq6WtHORk?=
 =?us-ascii?Q?/LveYveybTdbO8IMdT6xQTI37MckVKkL+ANOIduF+3v51dfKAXFGIhDUE44R?=
 =?us-ascii?Q?nXWWOu1TuQu1JCe4y4uNwCXuVKgaFmqk6hFDyacpZWFuQyT8d3NgWQWPlwKS?=
 =?us-ascii?Q?VILyWa3zsOZSBv2qMTDoo6KViUIq+Y4rB2pcmbXLfwowpSuGq8qqn7WOC7RT?=
 =?us-ascii?Q?0BoFprcJbUuVZZpZBTW/9H2pY+xlLUBzCK1H01mb4BUnfBGv8nis0hTzbZzu?=
 =?us-ascii?Q?DvXI1l8T6Fs2ppwd2YT2QKtsnnhqk7mSF0mzAYA9LlGbHWnwaRZ2SFV8XZ3P?=
 =?us-ascii?Q?11kfm4MQp7Lz5Wj3NneWOL52NXhfpWCXrghdScbaqunY3p8NWbiY1JFUxiub?=
 =?us-ascii?Q?/2gpOTxqDe3ncVabhd74VotehId8QdBY4t5RjZNvocqzfPOkX/HiGY/TpQDp?=
 =?us-ascii?Q?Duh5G3f/WzB/masAcLGH5Cuq6X3OIsUcM6F2jzOYASnPcN7VS87Bffod0Fia?=
 =?us-ascii?Q?gmQ6hJ4ZnxeOnLtX/mr/GMEYuMfDIARUw2HJEzOaOqwq7A+Pi2ViCdb+sGri?=
 =?us-ascii?Q?5XBYpOebrOg8muChN5bxHUJM3+WV6/75/I9qpUINpWHJ4OmW+ax1IudyR5vj?=
 =?us-ascii?Q?P8u7W5fcMloI8ImrtFOMKFzFbL28GAxXXt3uWnHcXux0kU4JY6+BS9ttvtWL?=
 =?us-ascii?Q?cbvDuvlWLZ/syWrsH5TMR9C4t9L2UnAgs86wMD8xcBpu5VndfvmtSCir9tz1?=
 =?us-ascii?Q?rjxVQe2RkaK9gJqLgZJJdv2DtlV6HhhZ2PLus7b6Mk3iskHQZSGxhLim3snl?=
 =?us-ascii?Q?j2GUFnTqBdETQGMJd1FsG4cxXukBjbIfUonXQXJV?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0910d009-60bc-4ffa-1f04-08dd032a112f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6784.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:55:36.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kV0KsMjagNbbqNPKsu4Eyubff7fA/zQdqwK2YTlJ8iWbKLVHXd/wEkdsXV7JxNOZa76BYUyDFLB04gKM2MjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB8010
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

> > > > systemd-boot counting logic requires [0] to be implemented.
> >
> > > > If not we plan to add the functionality in fs/fs.c and fs/fat - correct?
> > >
> > > We don't have plans for it, but explaining any use cases you have might help
> >
> > systemd-boot is able to do bootcounting by renaming the UKI image [0]
> > the code that triggers the not implemented code section is here [1].
> >
> > With this it is possible to have watchdog based A/B switching on systems
> > without a writeable u-boot environment. And therefore it is a nice
> > method to implement measured boot.
> 
> The A/B is ok, but I cant understand how that realted to measured
> boot. The TPM access, UKI infrastucture etc, will work fine without
> A/B

Yes, TPM, UKI works fine right now :)

systemd-boot is renaming the UKI before it starts it, by increasing
the bootcounter that is part of the filename. If the system is fully
booted the file gets renamed again to reset the bootcounter.

If the bootcounter exceeds systemd-boot tries the next UKI.
The UKIs can be signed and are still valid after rename.

I expect that changes to the u-boot env will change a PCR measurement.
At least it should be like this, since it might alter the boot path?

For trusted systems it would be nice to have a meaurement of the EFI
variables and beside that have no dynamic environment.

Hope this explenation is understandable?
Manuel

> > [0] https://uapi-group.org/specifications/specs/boot_loader_specification/#boot-counting
> > [1] https://github.com/systemd/systemd/blob/3304a029b847e87da51f7a8ad8c118111508e009/src/boot/boot.c#L1407
> >
> > > >
> > > > [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/efi_file.c#L971
