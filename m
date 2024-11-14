Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A813D68B3C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A371C88DC8;
	Thu, 14 Nov 2024 18:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="xsTYyIYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEF988D3C; Thu, 14 Nov 2024 18:01:45 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE94788DC8
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz5pdg7SJwbhT4aKw7wJhAdP7CSPkERUG7SoI7cQgXG6kDTWyTsUNyw+nKovyCIQcoC5xbPjj2ibyFiYkyqy5VeYYCC02CDYsDHREa/7GcyNerruuzmx693K4G16ao5iRel0vNvySMHMNqXdY4O/rILZCWtXzdDENepIJxJe4xADg2sbrtsDkObkbE50/6BWZ0VJy6X157VlgASI1MfqM//TcMpH+WMnhUGynquT2xv+dd6GeT/pb0i6KkjaXE5MpI8i1Yu+XtgEPRZ/wYjxZGRNYW3tOTROYqbDGOLicBKhj/XVcsFNBHktQDpPnzSdAxp0l4GV7NjiMqPYeXrP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxdgUVVwjebXfrfQQzkZQS7f2roTov2BJM+cBQPxYmo=;
 b=w259+RYSuAXd78pKWnXuuwWpIsvAfqc455Avj7qnQJijrXAyz/B7pc9Xyjkbtki3H2S5y9x5jL7wi8fZAkqOoA5c2JQrozrYL+7PQSNNNthDCkfVP3knTkRYKMeTsbTOA+d9SfHeKRGzBkNAFfk4UIYAXlOPKsHmWW+gE/CsNX3rLp2ySczR31ptxM9nDa4EJPA3pFPYMtWZt6KBxweUj36mVMtDKnNhkFkHyxo2BmOeXtu5B2Wkqrvh5aPzQmik6LU2TweHQ4LsgHK1ALeYnjPB6xXEG2RPyQTP0O3sl97SAjCalk5QE086CQQlCZihjRXgvUKTuPXpPeHjv2r5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxdgUVVwjebXfrfQQzkZQS7f2roTov2BJM+cBQPxYmo=;
 b=xsTYyIYW2iB80kkZPDGdmDlG1KCM0FXHpOFwEadGb9y6uCnsdoYTEwX5wVBPiNRVWDPk7Tdel3J1TsDsR9kn0mj0qOuK5AlSKwiFZWU04XRDr0oiRtXrf5TBtCvb4MC95/bEUGPfXhW7ftdJVG/Qj25+C83ejB18QqlRTqEQBkHywaz8qvFUTv3gaOLm4L7QI76VJRFkn22cdORLoxk1wlbxAEAYBAjQc7hoOHP2TSDB2oJA3AsZzmP8j/HlqFMtFB4YWSuidmdvlWijOH3EI+qPAATO73bm5PNzEQoqfTqe6Z3VFSXRyM3omIDKNUqunK6FH6KdpuG1SlBhlRt8aw==
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com (2603:10a6:10:2e5::13)
 by PA2PR06MB9267.eurprd06.prod.outlook.com (2603:10a6:102:409::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:01:41 +0000
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::319d:ca18:d682:3eda]) by DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::319d:ca18:d682:3eda%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 17:01:41 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heiko Schocher
 <hs@denx.de>, Stefan Roese <sr@denx.de>
Subject: RE: ZDI-CAN-24679: New Vulnerability Report
Thread-Topic: ZDI-CAN-24679: New Vulnerability Report
Thread-Index: AQHbNrMEORma5FhVkkGFiBCHMxLozbK2/8LQ
Date: Thu, 14 Nov 2024 17:01:41 +0000
Message-ID: <DU2PR06MB8334E5B005467C449D9923BEF75B2@DU2PR06MB8334.eurprd06.prod.outlook.com>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
In-Reply-To: <20241114163354.GH3600562@bill-the-cat>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR06MB8334:EE_|PA2PR06MB9267:EE_
x-ms-office365-filtering-correlation-id: 31aedf37-fc3f-4a25-da27-08dd04ce02f9
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YxTz1z2M8QtpDZwFscJ9wr1hEmAioXMxJV21btKKBMAlqs/6QXYthElSXfbL?=
 =?us-ascii?Q?ftQkdRsH1/mJFRFOARgpvOqAmNZglTN06LoiJwYpZZroy+tGJfvba+E40BuG?=
 =?us-ascii?Q?tgfXwU2WYgqwZqXG2CfJmXGNQaTa2GSRy06qhS7FyRJE9CGO/vkS3PvqoWwF?=
 =?us-ascii?Q?pABH02iyinWjLtAfvaABzW+W6C3XOJ/Wh2xrW+kAh5TSvyygv0DQP2TI80DM?=
 =?us-ascii?Q?tn5M0DM6GnCXCuVyt651LjtoYn1QdVLkeUersTD9wYY+VoGQRl7xqb+iRzM2?=
 =?us-ascii?Q?zPDhbuLFBEFfo2CfECRujVGkB6rEOd01bxkq+59qgsQzQnanF5hhmZ8mv3PH?=
 =?us-ascii?Q?p/lzVnRL6wf8O5UG/Umni6BXTiqMPBICR12mseWWjeQ22N5lf6kq0A3BBGFQ?=
 =?us-ascii?Q?fcxWG3Ths10QsaM7mYUDtxRFs3PZwqUOPSmXQi1OBAa2aRk1nqGlWlklmHRG?=
 =?us-ascii?Q?pEfDNkzh1MOF5GTkrm3y78TCQ4UqTYZEtusS1cDiNxA+mzZes1lfZlp7wayd?=
 =?us-ascii?Q?ftQVWgQhnH0iK+X9OjY9xrSzw9fEt0MxsrDH1jJHYajrXBrj9FiIW3rmsWoW?=
 =?us-ascii?Q?g4CMdcJzAtBO0QLQ8J31Zkqb3PvfXVcg0QPXbfdS2gRVhWKYg5y59FRurnWM?=
 =?us-ascii?Q?vUs8raFrlgOfwqqympugQU3ymqlHbfaZ7lvg/4yoF+pKvk35imM4u1ZvX91y?=
 =?us-ascii?Q?EQJIvKsiICB+1d3+u9KqR67l5maOhO+Mj0ikGCVx2tu3PJx8nJcijItpRFmx?=
 =?us-ascii?Q?fEuWN3PH3zK+vBNgriwn4wEcLlkcVWDof77yGYbBdd3WkGXDQD62BFSHRZAM?=
 =?us-ascii?Q?2b+bvRxmzdF2w9gcLlv6QOSIGA/cmty//hve65FoDG5h3TnDpaslfR/hgBGP?=
 =?us-ascii?Q?4ArG6Z0WWspGAxWCNAwOKngIy2p227C72OKH0C70IY4GEz8xuXyviiloSvbl?=
 =?us-ascii?Q?Qyu5IufYRcuIVhXhlm4GWNdP3Y/LIWrwNwv6YzdsxfDspVmGJ2Sic85yT980?=
 =?us-ascii?Q?gPkSDGMpAaZ3ovEpqRQtneqzU58Mzzpvp5VZs9muuTGDHopT30CHOcG52bPT?=
 =?us-ascii?Q?eYx1mDJ0ptg7PdClSyMQKYhwGPy/08ke/dDYwVp/2aAqGeEIFurt1Lt3IMnB?=
 =?us-ascii?Q?8JwQ17PhW2DhFk/IX8G9e/oklmAm54tUhenHh9tmd+hkVe+7kv+6UJG/u1e7?=
 =?us-ascii?Q?MOQUQz1f3Pj9mTws927y3G090vYdEGwXRQD5ezcJcXoOWmcq3ztk5J92GSpw?=
 =?us-ascii?Q?TIVmJX2+PjlmUTGT7NlU3coNEMiPF2sSkHq8mUxUfLqs8r/BebCx1VqFkC1u?=
 =?us-ascii?Q?8Dw6JXEQ0ou0VGjrZSJ8YFweBZbymI7CAyv0G7H2ekIvcdBCa2y3PdYNZkWe?=
 =?us-ascii?Q?gPjTEBw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR06MB8334.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xpb0NHMvGmlCvZWY5DD3kvfir4GbecjGkV2VW7rSM0HVSxsLN4oSayJ8aRkS?=
 =?us-ascii?Q?2+dpUR5Z1oZwdPyQOTOyLLDs0tOQlNmwnJLctWWhnFEgZTB2i48mjnnifbIQ?=
 =?us-ascii?Q?Wrq8htfXEwDG1iUSQ2Cwwhp9GaL4WQDqaV6jKvLp/CfGiwqEK9ooIJKWRFCn?=
 =?us-ascii?Q?35mSsqJ4xW9NwR84ASF4Qa4TVFDAmosXrteBqTFJsaPKfGOacOZ4RfkZDHT0?=
 =?us-ascii?Q?fQDt90fORs+Px6uggRSwtdwPp+8RTgXSGUFXa3v4LI1f+/A0P6fbALy1Mxo9?=
 =?us-ascii?Q?Xp6T7OYiYcjGk7mSXjJRHEhsk4fes2rbXgnvIXQn8vgvn3ZYhNHRTtpPITHK?=
 =?us-ascii?Q?KA1cLTrMySellq8jlScFweYKvgWXRBd9bc6g3YzH6hseL5wpV/Zyj5uFK9wC?=
 =?us-ascii?Q?kNsQDoFz0Ab2f+JhfvvhDsIGInN/GNP8QliDpuQeV0JR0SsHYSz7BjrKLEah?=
 =?us-ascii?Q?bikAAo8V+SMuIRuFHRRFMWCC4Av/bFPD1blgHbdzwjN6e9rG/ys9uipGSqQ9?=
 =?us-ascii?Q?UGXYMuwuwXZtKhJr5iIHzwSbgVcgY7Ah02plBSavf70HDmmeePYY6fG1vRip?=
 =?us-ascii?Q?B2/5qHf/tlLT+zsFTMCXSP9F6sZYwI9etX6lKuCYtt/CltWcEhUBAcHKabzJ?=
 =?us-ascii?Q?R2p9rljnWdNY0S1U+p4pSBguxe9nwGCDOZrkTocl+HLEs/4ptmN5bJcNSa3E?=
 =?us-ascii?Q?I4U46ooymv3WozFnI0lR4vJGQmf1N0BmqkyOIjxbxHlkiRyqIDToOQN9jZLG?=
 =?us-ascii?Q?VYQtMejT7IX+XsXNpvXeqCUoboMoUWuWST8kGzBfQ+a+do+PC4T/tCCafCVZ?=
 =?us-ascii?Q?N3v9uYmX0ke5pFn8dfwZrUAI2zcrCws01ImOKLGFDvGgNY31/XCr65o1+3Un?=
 =?us-ascii?Q?9Wvd8XCiribYKxbx1a556vQ/g9aolaMruq4VfmAKGpRIUz7BC1GLd5u/gON5?=
 =?us-ascii?Q?EW75TzRwdXHWPI84tn6h48W9pPiEwE3SP7m0EIBqBeOaqs3yFxTBunMArn58?=
 =?us-ascii?Q?J+PdWAFgs8u7TD9+9Z6ldC0Z+Fvm+GSRM1nk8pGMn95dwx8ryPq2dsiEdvkh?=
 =?us-ascii?Q?gUtvj2b/g+YzzzfVVjV13MqOLJMUCCuKp86/DQEyPVxDgn5CsfcbZfCyUTyJ?=
 =?us-ascii?Q?Qga7+GzQWg3nIwVgNMMuTfZBsiZEsjyHKK4Sh6VeQytzKC0lDJwNPaT/5ad7?=
 =?us-ascii?Q?Me12lv5EG+nruvG9JWLFFcL1p57gZfrvPX9LqSkw2HkTD6GhKWe+JQZ/+uky?=
 =?us-ascii?Q?NvJZODE3gyGuXfD9s6RsDhbK3EY9PpgxpQSbOxh/3EAWXXartpfdRgdU6KHb?=
 =?us-ascii?Q?KMZ3Ck7Rc8Eyi65jgE2tXXVRQBX7qnMR6XaM2AnsBFqG6qVqFgDCS50mSSjM?=
 =?us-ascii?Q?OpULWhNa0Se9FlgoEz7OgPOE/zk440P/+YXgaxuGSI/9dNHiYtIgykRiYo87?=
 =?us-ascii?Q?9rXbaHfGjsyBfmIt5h0HTNI+1MP4WgbG/xGVhxewUPqsX+XMMxuV9mweoYhc?=
 =?us-ascii?Q?awNiyjtlamy0DWtQiFQVhT82t1RbMgJv0TqbPL4TmvzER0aM9QukmrD7vxBZ?=
 =?us-ascii?Q?gJccWBZmKytoO6aVQRm2ybPvni5HsViesZ+stFnPuhSPB9dMJzY0w0Ykaybt?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR06MB8334.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aedf37-fc3f-4a25-da27-08dd04ce02f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 17:01:41.6019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQyjaSYhM39rGmtcs31sF+EAe4CSOEOU67qhYs4V/wqta7pBOlCbdwWYVhlKlygzHtT8wPZ2REVgYYXEV4/vjNIeifqm2MmTZ6c3YbuHOQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9267
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

Hi Tom,

> >
> > We have actually discussed this recently and we have other issues with
> > jffs2 and not going to fix it or recommend to use it.
> > JFFS2 should be removed from our configs and it is also not under our
> regression.
>=20
> Ah OK, thanks. Adding a few more maintainers now then.
>

for all the km PPC boards we can remove the config.=20

Should I prepare a patch?

Best regards
Holger Brunck

