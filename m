Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61099C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 11:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71249875D1;
	Thu, 26 Oct 2023 13:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="gJGFxF+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E6C87B07; Thu, 26 Oct 2023 07:42:10 +0200 (CEST)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28BF87AEB
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 26 Oct 2023 07:42:04 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id E0009B5ABC;
 Thu, 26 Oct 2023 07:42:03 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id AA684B5AAC;
 Thu, 26 Oct 2023 07:41:54 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.111) by stwexm.stww2k.local
 (172.25.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 26 Oct
 2023 07:41:54 +0200
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.51) by
 stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32 via Frontend Transport; Thu, 26 Oct 2023 07:41:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUWyNsDA4IICSw8rOuDFDA+BOO3eBo7Wbm9eAeT+xeFh3iz6ueV2GM6B2vj7MRoSfJFihM2Re+TrlQ10rtUv6H3D0vRz9YXUUpaLKbUa7kGR5Bw8zVcD9QSRgjAvTwrh2FKGdYVMUGs9ZRs8MnDwhfgPYBEIdD1nFME98N4i2qMOnC73yqm8iwdst20hd2nSrHoJTEIVyyXLks6cEZlWQ1XvBIYdygx2cSS2UAkf7Csx4GJ2OK1A4sp/SjWqS/mm5JCME7NPBx0qbTg8l4049wsLP0aU1m9OV1beiYDTc30Uvwm0Lynav4LsLBh0BBmhYOntCh3hLpY8FDe5gBfwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fNCPNZPkQcwcsAffsVn+y3WD0dR+VYJeC7kRnA8Dbg=;
 b=edoRpoaINtkAb82eFPD/JKYc+85R6DpssGMO0TKGs30k45bUwY16Un4jLvmH59hgBbBJB9r6Hbg1UR0/MkA+S9ITjbsQlhf08/qxsS/pVkz/1wHpee0nKWG+gumcx+kcKmu4UeGntkGQMAybGVCfK+z4wjnSqCLGrYfjRMUlqDJVDWpebexY447odStWYT9Q9tJIK9Y6btktgzDFQx9mG8hn4hqZ3PPHSSh168vOauoRtH6w4wE6LseX9fV5xE+qU/W+D63em9Ev7IAkGypmFsgBww0Jo6HO1P/919XKW+WTy2DJgRYhj6grp/LbiRFTe39yHmBtdwau2Y4VKqMzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fNCPNZPkQcwcsAffsVn+y3WD0dR+VYJeC7kRnA8Dbg=;
 b=gJGFxF+gue46rNyl/bY7SS96eHK/b7Bl8/ylr8di8RqouDSUVooOIkoHd9E3GHMAssmhuwmYqBN5/ie6zhUpet+jYpG7LKF/avTlGIgdzZ8tYmSVFZsmln4RXCtS7KVhzVPwUcKr5+nhftSRIfB2CNLKUv2gM+fQfBztGIJDXqw=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by DU2P250MB0240.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:279::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 05:41:52 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82%7]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 05:41:52 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Topic: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Index: AQHaBxkfay3CNufpAUmSQMhUgsTnBrBah7IAgAEGewA=
Date: Thu, 26 Oct 2023 05:41:52 +0000
Message-ID: <AS1P250MB0608EA436B47BBC3A5BA8C08A9DDA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231025135544.GN496310@bill-the-cat>
In-Reply-To: <20231025135544.GN496310@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|DU2P250MB0240:EE_
x-ms-office365-filtering-correlation-id: 0effcbbf-4758-4d92-fa13-08dbd5e641bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJBwL3TkQbsoNfl/Sb8I/yx6+M0H2Rp8CsU85IuWJiHZMjnZ/nI3CMTWSGPHCCZu9X5/seI/B0lcyW4noJgiPIeR9sp5GlVBYmE/2nONEr6BHvAfTOq5zsr9baVF6o2e0FGbxfnbtyTPknFl7/4OhqG2h1YR+fyDnvlQZe/zKsJR3VbU+jQHjPcM8ZJZXSBO+31R1HAGOTFZj3sZCklWYDUl68g4eKdmPf7EFkg65d0rUYLP4hUW29Oemcxni13N7r/wHq6durpdMYMAfGjsmslad+Lgt61HUKz9DdsdbZuYvoos2ZjIkhVRkn5torJNYcFvVlqDbGemwi5f4YHOrMw8yhW3NQAwhRbDPyaadDtMu/Nv4DKc8YoP2/l8nd2Oul8UmK6ogLwHI/hWzKCa3GqJrhOMf6BDu60jAvsIaQTMoA0bmrLzch4RgfbS83k7rw5tMid74tBAy1diNU25JiMMp9tUOquJe7lGVopuFGK4/I+sVcntIr9zkR/3LV3DOLpUXuBcumxsdQTCpW4aExHu6vKrwjmwzcQNbP58jZwV49mjyu9NOu6Q0ERqndvoXgPsInWfJIPF154ZAWp98itzOUj9boVVXgmN3FaLBTe36iCqUygmw4rEEzPtQCi6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(39840400004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(33656002)(558084003)(41300700001)(55016003)(4326008)(8676002)(8936002)(5660300002)(52536014)(86362001)(2906002)(38100700002)(9686003)(71200400001)(6506007)(7696005)(122000001)(478600001)(26005)(38070700009)(6916009)(66556008)(66476007)(66446008)(64756008)(316002)(66946007)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G0r1D3ZV7zphNHZGcgGLnrfZjV1JHnky01h6sZgoEi7ASoJwvstokzM0Xt95?=
 =?us-ascii?Q?FYEHg0ca87GVsJTpgE5rWjazT4fPSwWKxHkgnAmjYE4pqsEUEj/xUM1RsMdw?=
 =?us-ascii?Q?xGNudl7+ux5iZNFVfaSMyn4Kuy7u0vI4o5oMV1REombOqJGtp1HTxQ5uq/bm?=
 =?us-ascii?Q?7dtEAPtf9hNVbBvTElqDRcziVKkhvctBUNBCqURZIYETVEi5oybME8x2R58f?=
 =?us-ascii?Q?miRPLK0zL+gUbXWYPEC4TflXGXlwXhrBzq83XyVGoeGMbCzXQcC/HA8NVvn/?=
 =?us-ascii?Q?DpCAFCm1joxSARiSd6/Myu1PKsqKVkTyO8LD4VsKtqTGdx57StXLpnbMcZi7?=
 =?us-ascii?Q?CmV37Hrw1gc48LcDpuiyPCU+KuUW0ag+7uyLMsKuc/DfqT98T9uQIuTvGp9y?=
 =?us-ascii?Q?36+UNZUwMs8uktFW6VDhVflJ2aN6E/VOBhLKlek+ejZFMtNzGqLGC/JYKPtW?=
 =?us-ascii?Q?7L82M9X6/IVUlux2Inho7ldj6GXbxbv/6bow8k3+f5nlGdkOSzKadw03p4tD?=
 =?us-ascii?Q?Cot55Yqz5R1HJMbQrs5UMm7d27+6Qur49+hPsmmAUeUXfwncVQohbYQMfNbT?=
 =?us-ascii?Q?qx/+I2V6Es1eO5tMYbw9nF/tG2klBj60wGiaSmhFbH9BRAIrN8+oDF7oR/aZ?=
 =?us-ascii?Q?kJCUe+Rp0gC8quxNZPk6762xrmPAGqlSRhCp3eraLRMC4+n8Gs2mvx7Ca5JK?=
 =?us-ascii?Q?5zSjrO3lWaF6rx7KNyfl6+ud0i+ggn1xGOIxZ5DOigq9VzFIojuzDXsdIDJl?=
 =?us-ascii?Q?bXmyG9IOtHBrI3vAFLytH8DW7rn5D2nX4lRlje3UIQCx3Sa87GEHgnOhA2AY?=
 =?us-ascii?Q?PepBX3+jVc9RTYniqlZmE98MVmIVr2AFSa0MSVXG/pzxixar81pgKxQTz4sj?=
 =?us-ascii?Q?vPgR8zLdErgnPOopWfaE5SzZwI6WehYEBd6v7tVyOjqNDbK1YNa2Br2n1lca?=
 =?us-ascii?Q?5iRIEW7nYb8/hEHYyyB+hPtyp1KTg1oiG1IdZgpVv+WR7zleFsSaCzo6H3Yc?=
 =?us-ascii?Q?IgdeZnDZgoTvyzT95r3oAyK5eU+7zcOWes5ItxhcUq8fh9x73DIRncQsE2un?=
 =?us-ascii?Q?W45wiytA8rAMjeVnfNKdI7lRHCdGYgUWWq9xSWKrCS+ueddA5Bsq5vAvOXjM?=
 =?us-ascii?Q?vRfHzmR/hMd3JBKmSqdBqWhl5Jz2i1J1RSvn7EFdPIhHUoDg+036L4XoHK1C?=
 =?us-ascii?Q?I2GbqgDJW+sLluPSS/t8mG0NfwXHIfxlF76YvJT+wCcf0aU4s4rEaNZteWbn?=
 =?us-ascii?Q?hlKEGgCWzsQaRh0GshRGKKFr+QMdh/u2l0Fpo97gnxA+RgGxYnq46sCqeFLy?=
 =?us-ascii?Q?PuXM2XDNsgT0gHjh0bm7nrVk0Jw6zuvzLkr0ZvFbRTJfh1PDier3oQY8k2fi?=
 =?us-ascii?Q?Y8kunS31bgIssFewIp+dGHO8lySRLURNeW0hgyz2mFSJvGNiCw18F3SoyI7r?=
 =?us-ascii?Q?KdxY7M/fdjUZ0+HrmQonO/UR2cPs5FTgMCbOorz7vd7ftDEbuO3FTxDMRaTO?=
 =?us-ascii?Q?Udi9eOE78oq2XlgtdqXjmncCIopbBQEFcopqVYzEeppBSLJK1GoT0XIc/irm?=
 =?us-ascii?Q?KyTqMZXWVWfKX4hMM8AWAkkKACGZLPo/cT+QNr+1JMapnjY0iTnNDdVF7DLE?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g3CZXv02gs6UpbKf3UlBJoNJhv6UGDOinmJJJHnjp4Xem8kgDvk58AyyQunctdPKtAAKd3KpdrjRzqtKhkhwlz6o70F3oiR/4Fo1x9EOm3QSPQ/ukiJ7nhjViS50a8ki7TNaj+BDu6gp9lkGGgm8YRn6qHRAu5sEQC06oeRmb/uNPRQGnUPlTVZRcCaDxOBxHlolDZPZM5uFpTky9hJRTiNixI/o08n6sB9Cr41wn59v+Vw7AzUXw+yrTOxzWna89iRyD9fy5nzrcOE/wcEfttcqPS0rDJ87uyxqdM8NxiAcD17XY0FSL1E530ogfXfFMmGq0Ga5495ESq1YcQ7LVE8AJglF1KEQGNcwgP5r/Ov5VMch7sVq4/Ii8t3r23y6hCT0kS7RU1yprvlD1Mu3O59pvUFPBMylRYfmqO8b9D4Ocb71gIgErR+OJnLaKNDOB8NfyseGvZSUVEwvr0oNdx8fj2mVbu2DABrtjLgDoM9bAeO/aqUM1jI0qAVfzzKYAZGs7wHUuxtGhmRCPQkztQwzzx2+xI6/nfEUGqm0kVgv8LyNo2lrdqPMmQTN1u59epc+4+HKgsChiMLPoKo7tHzBNJMRYo78P/IRZd+4Y7hHYZbwJFdbg1g/FrSY7xTdrdRxmpIoffNjI/LjoJ072IHY4NRoLCi9XLlQbuJNlOFvTURl3t0Gy9sBcJvlMm8UOW2W/EHHzg7IB+SFRn3NYHoE2z+a770Oqn71i7NczlYwmgzLJC+aIkFuUBMEhYKe9gcXG9NkPyHCNnhSPv70WA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0effcbbf-4758-4d92-fa13-08dbd5e641bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 05:41:52.4666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/9wJmNw2aquQpnDCbtVxtVukRiFrYH8A4ur+8Po8I0N9g8drnOAChTGDSyGITJhSk0/COaT3l2X4TncMkunxT1y9uYimgNTtfkoUvxX+8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0240
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Tom Rini <trini@konsulko.com>
X-TBoneOriginalCC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 26 Oct 2023 13:57:35 +0200
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

> We don't need to promote the types to unsigned here do we?

You are right, I will provide a new version of my patch where I will change=
 all "unsigned int" 's to int's.

Alex
