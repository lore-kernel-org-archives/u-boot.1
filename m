Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD1FCF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4775D83FBF;
	Wed, 19 Nov 2025 16:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Q0YlZcNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2200883FC0; Wed, 19 Nov 2025 16:22:34 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB9883FA5
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR5l3QaR29pys61iYVRIufP+aLxj/V06WrhvT2eXcJyTYNewCQVljj5bIJqLtUwvXukpNEQJ0lJWo7c/oR2NKaa2G285TdjNLnwhZEwiN0TZuI+SXap9RCFr02b9UPEl1+WeqtmD1BYTXiCEGfCphpESU5U+GylZARPAxZf0Z0ee0Rq568R4eK9RbNVXG78jWFB+uM5QUStWZaK82kHSIGDJCkGgGhuFdj15Fe9imo1vomNS42PEvXOItC77ikirfna02S77FvjuRhwfljaO3JCcMjD8gKgYe17oBSg+o5Lm+aTvWms47VpqoOY1M0RqqMkfhhdufrl0wVHxC0bqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6fegAsLhXqB0Wf5AwHZ2nSMAkYUlMjQpTm7MZAXuuI=;
 b=tudwI2nXNEodcPMt9g9oWBfVGd0952FcyrmH8q0RBz5smRL+2VBICO1QgJwoIFi5SQXZZhzIYX9T1wdzneLxoiDWrfMTYkh5/kO/A6CDI99cr3UxghS7KSNoD/rhKsYcO4pCz9ZKntP+3al/f5UNxTTDKn2W++D+C0leV33JARq25FaAvBt6YbsgMuTCrmLYhUJbuCX+YteCP0a1c3rkqEaSxYOC8BacgivhTjpoNQjJVnp5GqYvBUggjQ3YraXmmzoDX57mhaDqeBabjq1nxCdm/RiAVeSJ8oT1TnZSxiUpCKtY0AOe2nqnANnWOg82k6KUjJhgSWA3+7SfqkDLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6fegAsLhXqB0Wf5AwHZ2nSMAkYUlMjQpTm7MZAXuuI=;
 b=Q0YlZcNarkxPnzbK9CLKFA2A2mzKdduPvUaRhLPbzHeJxyanmGBOZW8pX+4mFnjNSA1UPIKOdy2t35zCA3I9So49lHqBgnvxQfJ0lszntbtZxunnHMaRT+/XyiJyTat5/ifsG793UGnKn8lrKRA7qmGWS0Ip9K/h72dQkXnZIZhdrMjDtGPyycVnEiYmOMT9ApCg4Bk5MuWKzECPx6rutHG1uzC/wvxWxSU0DQ6oeCPldbHhjFov9MzVNoVrmL+lqrO8AoV0Tau5eOZ0Aof8K7za12p/Y+ZXO5WsgWu8av8NxDNJDb4jaEg55G9LgAVyOJ4E+x7rT4E3q2TikSN1GQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:22:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:22:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] mx6sxsabreauto: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6sxsabreauto: Stop disabling device tree relocation
Thread-Index: AQHcWLXCEf7iI9XZIEqrgdge8sqOILT6Hylw
Date: Wed, 19 Nov 2025 15:22:30 +0000
Message-ID: <PAXPR04MB84593C240CD5EDB70CA9626788D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180413.591224-1-trini@konsulko.com>
In-Reply-To: <20251118180413.591224-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8379:EE_
x-ms-office365-filtering-correlation-id: 7e080422-a89d-4fd1-7c55-08de277f74f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QCIlIfDmz7C7pfU0/04MhpNpmPT8REw6KPz10ovr0Z58g/F3IztTl1KM1HNd?=
 =?us-ascii?Q?4AtOW0tR6fIb/P1a7L85eZeEjMIqNdbTdniFKSOD+ogvaMhmLzVQneqgChsq?=
 =?us-ascii?Q?lLl4Me3crpIvLKxS9seJRYEuzt9PJUm+Z33pj/fHug2nEEp4n8W0uEEZIlTE?=
 =?us-ascii?Q?GCcupS44BzO55VENFs4s3AWXGYsyenG9SAm++AZqGFMBACqfpvP+j7Bq3YW+?=
 =?us-ascii?Q?2KjAO6lTyRSyxLBH4ZYVDdOgnz2M+wnSRdW6hlb6emB01CIwzQzqfMOSw7eS?=
 =?us-ascii?Q?sr+uZDiOb4yTo5aYg0Jv5q4Z1ArAc+SPZWZB0VCNCeyVcWMmOOd2TkO6z1mm?=
 =?us-ascii?Q?F/hLlMP+JhZOI6t1OjQdZIySFmpry5gNPwvNLV9eh806Vpsz3h0wdtPi07ui?=
 =?us-ascii?Q?hlPQqnMThpF7cGEfLsLr/i/TfaYaQ36QmKoraVcGod+OIgZRPItZ4m9jnT23?=
 =?us-ascii?Q?CdkjtM5e1ZLPt3LIV95SmkGUebBxgQ/HoOnHRMZ2XM+ay7vEb2lQC7jmvyFX?=
 =?us-ascii?Q?efw/rl3DWyUqJNqhBQ+1iR+TFEUlfnn6QMB31jEX9Ba4Soijl2lKfGKVZPYv?=
 =?us-ascii?Q?slEuK9bx5Lq/0WkhmEZzg2tq5SDMDMjhfy2PqwKivRXbSiWaXngMC78t2fE0?=
 =?us-ascii?Q?JUdUVKqFCxpSqn8oXDREGiFi0Bfa4FqMKVR4bb3JrO7mqyxRFttaXezrvWs4?=
 =?us-ascii?Q?t7E1r6e9QgTfEVuc3r3T4/23p93oEiEpQnkhEVYCIvxarmniNWL7RBaTE7Zv?=
 =?us-ascii?Q?VnTzexTtDWzguciR/UMeNEN4+75rJyBUL6N5M/S9h92/warBMTQ/Z+0wMiSY?=
 =?us-ascii?Q?FZY+AZsvjaY3G/7Tpk42gc2FdTRzpEAjJUJPuhdZSwt6LXNgs/PxBzJYuROb?=
 =?us-ascii?Q?WGjBbHJteAfONDJHGo2nTUcNrv3oZ/oRu6n0AMgE1v4H6Jl417kbsfx2na1i?=
 =?us-ascii?Q?qyeIDrNvZMyLTjhH7vGVCa2vD3h7tDq5d9VkMdvA0mW/xKvyWXNervU66cVC?=
 =?us-ascii?Q?pPdo8iGX25heldtJ26Xp3lfmf7gygldHnI1U3ap7eRSBXrHSf/1KgvnShow8?=
 =?us-ascii?Q?CrXkxpEGZK5+zpDxSb/CNgc+wDhAOV71YB459aWj8NvoZKOL+UVPzuOa1iQt?=
 =?us-ascii?Q?7Vhfw8ClLjd6VN0W0CxJDAQKVuGQe/KXNjjfO8KnFlKMZzurpaOb/SM9oLhw?=
 =?us-ascii?Q?/8XfYzyDx0maqx3oL+T8PF8+EvT+6mzRY+sQRSapflC1qaJST3plHXjwr3/W?=
 =?us-ascii?Q?Dn18+xw5qScdUG76c7L2Qs9t/yv9z8L4KrXK9nDPvtggqwII4H84y94UIFUf?=
 =?us-ascii?Q?7zPRWbbYpHDdTbSUEZK1VrKpFHoDAODiruEeOkbU6cqxYCd7e4Ziuv7II14g?=
 =?us-ascii?Q?uIaYSpS2/bwJuTC07z42CWWgg3OkNE5SkC9H0kRRwTBvcY4FFYEhjGcDntTB?=
 =?us-ascii?Q?r8R8RXkU/DMGpQnBpwDeS7T3hqeuDK5J4PL7GahOyffTMQQB7wT2fV/+l7+S?=
 =?us-ascii?Q?Q6YJwifS9NmG2KxRSdIo806X3gxEtn7nItst?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INVHr5111VJ28KrRV/WxOf1fqu0iExTw/dkKysjH8e2hQz4ZgDYxydKl2LqW?=
 =?us-ascii?Q?3aQP87jZNWbNueBhORRMJCDcOJ2qzfcqKgAZG+Omu9wAJ9JB2XzByiQPtvGk?=
 =?us-ascii?Q?pubURkzP2Cgk9ceivBFxqGVU/CDWGJqLR57OfGcQlnN2bCqT8SAp58odoQ9I?=
 =?us-ascii?Q?g9FH7QMFLCIoKwo+OoPh91k/boYg8ZBLa8WaRHrTrvPdfq+8LYgrBfjtig9R?=
 =?us-ascii?Q?1C7sutejHcWC5h0H2q6Zi69iV9nwtriHoGi474IdG9s1ViFuK3xntHgTJCQP?=
 =?us-ascii?Q?Ez55+GuxUMgWoEE4XK9GAPZhmD4v7EnWa0sX/95evcdVE3l3C7Trd65VZ2AK?=
 =?us-ascii?Q?93hwYZsqHQmq1KhB+NneFGGX8++CkxtnKr78h/JPHPn1ClcVGoOVDOsDyIWl?=
 =?us-ascii?Q?6wFGZTAyKGWnPJeGM+HkcEwQcgnrBHXM49xX30SslTFfiWrW/YUpuZzF/Hnj?=
 =?us-ascii?Q?FIZcAqyZ5pfP7QdgB8bOw61cGSR+nDG0ab300+SjRe3WOWybqTgbvAJ+f+uQ?=
 =?us-ascii?Q?F2nb16SsIO18NMuEYzTRy5XI0vGI3Qunh1ycWHtk55AN+wAX8lPmDygJZ8hd?=
 =?us-ascii?Q?La9wN0QZtR8tIdXUnXZddoR4mDqdhHo/35bKNsxDwhePlokRqv1ytOdJsiyg?=
 =?us-ascii?Q?fqtQpZcLUOxwHUNZucr98y/9XTJVsaEd55tlCk6r40ePWLfsw5DCyS4CcpcE?=
 =?us-ascii?Q?35s9qJAGXOdE8EnCEtKRjZ0tzCe8i+Ku6Y2dYR4jDydECvkQa6gySdTspQdX?=
 =?us-ascii?Q?L49Km0bsbzXg+1V/ADdlDGkp75hIYT48BNddLnDeqNKOxrvXkWBocuHuXg7w?=
 =?us-ascii?Q?2+S6FhkpRJsObenO3Ez6nNFP02u0+GPpQrotssYM9D2ITmnqePVzWhjaF42B?=
 =?us-ascii?Q?0G8Xv5nLURrJlRu/agMllm8yTBVJWkrn8p+fUEO1dhh7dC0ypzyiRVop6/G5?=
 =?us-ascii?Q?nEAsfbMup/3OlqhXt9RnAfmnfe3VKEWtsbuparkx0Bi0d8ZBFfZuHsPyxw+6?=
 =?us-ascii?Q?2hjhyAUX7wLd7abBehDQv+bm3H9QKvCVTG/m505JhSUSwUodt+PNAhsKAi8x?=
 =?us-ascii?Q?C7jtpy0EWUBNORNiDoOF2J87PGYt/HTd0h4PaHoFmFCgcTB934kEMjF+lLVe?=
 =?us-ascii?Q?qDklOywP65wdRblKCOE2Z3Y5F64fcR7edli6nBh92cc4vIN2bZSKSj7Ymsd4?=
 =?us-ascii?Q?nwsPN3O3xY/jDPMRUMBWe0U9rBO5OSnkGESOwty2ynsLVAIvKZgMNrYdiZfC?=
 =?us-ascii?Q?ombq1NSTK8EVQJad1juIXhNvzflK5hK6DcotXDdUxczx7mRdIFqc/AvWDEhT?=
 =?us-ascii?Q?0UXg05xCrTW+5I8rAI1iYBfe4H5vgdS7f5v2Qmc0zk47tD77Z9ZNt0S6uDVO?=
 =?us-ascii?Q?ro0DN6acEw7oV5h9WRmUoqHyLvl2zKQ19D9FbogqczyKiw9vsn3Uk3Jh3EoM?=
 =?us-ascii?Q?iVeldbjaN1EB7Uk74xDNJqR/odPbNK7x8FhLmgqfnqQjSl320zluG10+9QXV?=
 =?us-ascii?Q?qbHzDOoAfSnyQIfGxaoKInQuHP1H/0vPALB3CY8mdMUn/3DhH1cpU5mKPxT5?=
 =?us-ascii?Q?DNlAmCz23UBNQR/3HXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e080422-a89d-4fd1-7c55-08de277f74f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:22:30.9587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8B6otnBVZgcbVTaR2MdGANAzDuFeV7Sh+ofN++1SJPQZs2VhwbSl5S/UbLOWZRNOgEa6mbxfgGUWnGVS8COrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379
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

> Subject: [PATCH] mx6sxsabreauto: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
