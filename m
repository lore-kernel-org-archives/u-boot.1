Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A86ECFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 09:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA46583D8B;
	Tue,  2 Dec 2025 10:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="QmJO0Lkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CA383E40; Tue,  2 Dec 2025 10:42:24 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC00983CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 10:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGGp28KsR2og6ExDP5O2AUt2wCJJQ8n1L1VQK3r0m+tcStzyJ6qr9/sjNuPCbQGMaT+2EhpLfXLgF9Alx3qDm9OdiL7/BVMKc2HfkhHu3Ks0G4OvQO99fVc4K71MaPmnVJX8QBDMiF7iDx/cU+JRqvSCewSbHPAZJd5jPec7ecWlKVCPNk+qbPhcFIVIitLrSjQA13KsxgVNAIjaSZwV6ouhHXF5fVW7neSIt58brkMpr2TlF9/bVQKyN3lrKe+UaDOQGRdXOuy/xjU3kQnpz/hI+hM3b/vMDPkBvNord7fQrd34ykPaQuItZwVyBWjwsv0tSYsvmYf3f54uSY2lHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2x1IM+5pQZI3LII2DwmFNL9eqMxGn8vCIU/LmlM7ik=;
 b=C9PfeWeA0JuaU8sXZAM4eTF0A3xbUjavSDxMXyuO2gFAqowm806X7+2JYwW0nd0T8n0tHLXrj6HInQEo8ocNy/fPmKPnfpdkPF3lWWFKPV5KMPUeqW8LHkvvmIdhp8U+iX9IlnJx0VBWGzuBASl5czmA6YrnqRub7wGYjBEe5SJyns1b137C+OL+dEWKakbQcBdEepROIbicokvdtdmcdy28IVF3U8+buGRVASDEr5NXiZd2+ThE3ylJddYVmWOkh/eMHUHf4yZfVi/W/MA7NCQbLIJWGyvjlg2cr8iL1TOLffzT1zl/U1j0Gav5qIpUpCj/qaYx0WcvTgzYyYreoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2x1IM+5pQZI3LII2DwmFNL9eqMxGn8vCIU/LmlM7ik=;
 b=QmJO0LkwzBpREUIV1cEAMEMSfcDG0oG9xW/Lv8bQ8HC4Dy2VRhPcCCpGPhamksnoENT8aPMKoLPR8+TozSlao94aXb//uQvwm/IPP2Ee6sU+IEZaMftqLDbUccsMhNz/N9WLd4xh5e764MYeSn/7MjGiq5Jf/o5cFOATrUTq3b1cUg+dJqMcGGlg4JSTtxPowGPtwSH/RRrn7+Qm8ghX/1VlKqxg4OHanyOrJw7e/hoMkzjOzDJbyC2qyAGtmkHD9JTqbsBEUnM/qo8jz508GUeJK+E9Q45Xs2OPyyRK+uM9uQqIWdmF4h3Nl13DJUTI4XOSjhKmfum+ucPeDNJ43A==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by AM8PR06MB6833.eurprd06.prod.outlook.com (2603:10a6:20b:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 09:42:21 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:42:21 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Wolfgang Wallner <wolfgang.wallner@br-automtation.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] board: BuR: Update MAINTAINERS files
Thread-Topic: [PATCH] board: BuR: Update MAINTAINERS files
Thread-Index: AQHcY28AUozCFSfrOkS58WAbXlDWnbUOGEu4
Date: Tue, 2 Dec 2025 09:42:21 +0000
Message-ID: <DB9PR06MB8512B082381ED8153AFD6080CBD8A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251202093521.73250-1-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251202093521.73250-1-wolfgang.wallner@br-automation.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-12-02T09:42:20.790Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|AM8PR06MB6833:EE_
x-ms-office365-filtering-correlation-id: 95271bf7-89e6-4c4a-b2d0-08de3187171b
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9J6x40nvjrchzTOWCLfbkcFXvPO3JEwX9PZi21vqWm+tR+VtrZQAs6vaGd?=
 =?iso-8859-1?Q?0rgThEgE8LHAQvjQuqcncP2qeZtgVP9FBAVHrSQkrtvHInsvD3L6T2nwZF?=
 =?iso-8859-1?Q?FMLhPhqNzTySm7iFRwlUiDYbxUXarxnq3Z0r5/aBIu9HW2Sef9KXsWZTM5?=
 =?iso-8859-1?Q?qrs4tIMYJsduNqTLA1SK4yAls3uSHM9SV4gqFVOMY9nF1YYMxrjx6J9bGy?=
 =?iso-8859-1?Q?ByDVCihkgxIaH6O0Z5kCyeSkQRhzjsWQi64DgUW3LVksD37E0f1pBtVgfe?=
 =?iso-8859-1?Q?jk9ADah17cI/VTzMX3dBUkntAkGoHSKtd/48pqnjJJRkvCVxtRodnOq9tW?=
 =?iso-8859-1?Q?ADHN/Xvhu104t2fDJxQCjr+GJ3ZkayWgsDynG58B1CzyCwduMl7AAwKDuy?=
 =?iso-8859-1?Q?89v/T8HyBrGIR+Gtk3ewe+3BNkckoGtFdq42PMQlvzjL+VcWNMu35OpWjm?=
 =?iso-8859-1?Q?qGXITg/3iRZeK9JciHuTqQfVjLdx9mOrVu/GDD25/yjoRJTIsB3uOJD7le?=
 =?iso-8859-1?Q?chisNRylDc/wvvSVHyS5q3MthqZpquXGAqSxPhpqOiXHPAu3815ZG+Le8U?=
 =?iso-8859-1?Q?aCfIU6F2uZ8e274YOfoN/D4+Wi85UTxKqpFejXKDGm5HKSM958a2BU2fZM?=
 =?iso-8859-1?Q?pm6oqa07kXCmz/y3yR3OAa+uqkoBu8IGrkN547ZvTt8kxc5y556gx1bJjo?=
 =?iso-8859-1?Q?LMFdCZoSbWFPlsvg5dXCkfjnr6ADuvufcI/sAZXqCeGhlyH52xw9IR0AqQ?=
 =?iso-8859-1?Q?UCxi7E4qXGg6mIN+eERldKxlIPTJvu16RewrmyZ4He2keRcwNAtgDTJBjx?=
 =?iso-8859-1?Q?VZX2iEGClPELyiBg58y1xKhPNnf5Rtr1V7P6zO9ZOT6UOU/KERPUGLfLGF?=
 =?iso-8859-1?Q?gNzieRAR5FLelZp3jPtzcetaG2WYrUyRUzJvTpEOSJEutFV7eJ/aB8kqs+?=
 =?iso-8859-1?Q?7Kjjbbwqkaa2a/viRj6EqK3JCefqI6xAfECvLUlj8QTFXYzTKF0gT26RoD?=
 =?iso-8859-1?Q?b51mvPnawadSXhZvHT0rYQCz2mhUmywpfHH4jciAqh19X3//cN6okR6WJl?=
 =?iso-8859-1?Q?aTfOZClUrClvLC2I7HGGpEjRkY/m9sXJpKHrsZfUvzUt3jJpEXBnJUB+48?=
 =?iso-8859-1?Q?02QF8Rd18+2/YzhkDUm8S8W6xAhcpbBdYAOyjfipK7s1OG4xHK2W86Ujn1?=
 =?iso-8859-1?Q?XBqzbXtvta07+/AMjEGQTaPVJq0Et5H4vtLACWMaKoawkHmnv/WizefRUm?=
 =?iso-8859-1?Q?ftERmVuJX7j7uWLRb9HKyk/qL9GgKl3B1cjABPZryexPBNLoKwK+i1lMEC?=
 =?iso-8859-1?Q?WIPeJ6oXBbfEnhP+827e47vTu03JhbsznarwdgpOGIsLUdi+RZjgLj0MD4?=
 =?iso-8859-1?Q?rpVH1qrcX/bryQJhwZF/AiiP0nRsz4fyNwA3yRY5wqoQGKqmojouR15rVZ?=
 =?iso-8859-1?Q?OjXKgx+43jtD/FPQ7rQjwraF1MZCAGiuDOUc+yG0NlZRL2Zi45hLd2axMb?=
 =?iso-8859-1?Q?gnakRf2lfxII5oy82ZYbBwDC4cASaLI0/1j4csSopgN5vlPIapgO+asJ1A?=
 =?iso-8859-1?Q?BsSNu69RsOMqs97v8DtKXwADNQT8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9lmMU7JepCP5sr+IFDzNUodYRoAIySt6gEmdJm4K/HNIBrlj+fyA9+jUW3?=
 =?iso-8859-1?Q?1rz7ZOEbsN08wHolhpYGsSOKjD7ekVM+yXGsvxP4MdrHpTHnZbDWfKEwDV?=
 =?iso-8859-1?Q?+E0feqDWrWupp/C+VkfuMtW29dIt/bvO4b96BYGJU6GWTDuoeog/wKy5Dv?=
 =?iso-8859-1?Q?31ZIDz3afgVKgXda+bw+XnMDcy619UJKf+/3JlGWmD6RzCsl8TlZjs6pAp?=
 =?iso-8859-1?Q?40hoWXq9T9RftKtXDI8SMFP7Md8werfZo/RdF0QEOBsTMbCm99egIy7UpQ?=
 =?iso-8859-1?Q?w2oIIdn6lm/azBjQ6Dq0c32xxvun5zmYEphQdfNxmtXsEH0wQVsepyhGec?=
 =?iso-8859-1?Q?P8wKB+C5E3AT5FXed1ec5QUOT+Mh+Im6UougDPlIM0h7+nlnjowybJoWMO?=
 =?iso-8859-1?Q?un3Thuq9XlePSG+43JVJgcRorqvjMM4y60aDiN1i/9Pkz39rQjEkkQzzdY?=
 =?iso-8859-1?Q?rJgeF+tEdbXDH11JfbFV4nteVbTRiuZa0QAUWvAkeQADWbZMih97jMp+vp?=
 =?iso-8859-1?Q?vmyl5YQftPi4P3Uhr/gYlAs+wLZXDsKyrxIT63oHWUWv7HjSLaLmVlDMtx?=
 =?iso-8859-1?Q?Qk0B4gWCxwj9l8boseDWFkXyKzhqoJP3u0N3gn3qXvaBTmvuOgW0ZUh/e0?=
 =?iso-8859-1?Q?Q0DO/MZZdK30tfyfBHzfuM1ScEb2Kbu7KZgBrtZvmiPTejwXUzYp9nRn/o?=
 =?iso-8859-1?Q?2Qsa+NEsKEz8kF32ZIHRMDJEpjesrYB1efu5KfF+gxz0h7N+6cI84P7LYu?=
 =?iso-8859-1?Q?dPaF94EJx5dddG9YKwtY6lLATrhlKQA/0pacm3pDIzwHBH6QTBoCZYjwSa?=
 =?iso-8859-1?Q?XPDy/N5s1jlinvGrGcjT55ITBUGcn+Pyt80bmjQyoW/rD+7YhLpdjNV/8O?=
 =?iso-8859-1?Q?Q0k9y3de6CIuhb16evWnFtlwQI+6sZDO5BJ4uanuSziDlY98H7+zENXL+u?=
 =?iso-8859-1?Q?C7xns6dRi6kCxq3TbNQDtcIsCmMRn8Qn3njBhBNRRhfi1hz4OwvOejq7xW?=
 =?iso-8859-1?Q?2Y3DensLFmMpvHBpjJ60c6GV+R63WZsdDSHzFCgGQTb3NadLuDhPLL/k/C?=
 =?iso-8859-1?Q?5eHI0DLDA1ysVQ/q2/7c/f9LCdp+ISywBJtSCbgkBL8JhIaA++cislVfjR?=
 =?iso-8859-1?Q?ipcyTENhq1U+Z9OrZ90MNLV2R/lwLtQwMhvHJETz3OgHyRTDWDCccaVScr?=
 =?iso-8859-1?Q?12MoLnuG0xs8hgw354i05bnrXWLWdTIUjAd69ipwBLZseYCfkQ8EgJ0JPH?=
 =?iso-8859-1?Q?UAEgFv7eGb5DFkrsfOrICwNR+e/9ExRdXNkKSXYUhgXFRuI9ojGYv5lupv?=
 =?iso-8859-1?Q?o/mz1v98FQzEzHtKKFJETGeAet+ERhUfm7b8arPAiTmEB4JBzvzUV3WTbM?=
 =?iso-8859-1?Q?U/49hE9Cekcuk6z0/GIq0SnYf2a0S9H+3s0Hu8+cs78dsctkY9Zm2gGiLS?=
 =?iso-8859-1?Q?4DclrCqEhBrDwM6yYAbpXt4Cmszrg1aW9nQnezpKCVVex2imQyIVZGUTGa?=
 =?iso-8859-1?Q?AKint8ebt36pSY/gJbM2pmvqnABosM49gZMhOXY+W4ltvmR3jKUAvgyFkN?=
 =?iso-8859-1?Q?/VCFiGxIhZmnCMod3ByBy5hj7Z5bAJylR5t+GBgxzEyPRy9LTN8Ogi7H83?=
 =?iso-8859-1?Q?gi47KTfUkh41kQaMnVvy2Wh11tDnJ+2hrukA7+ySnee1dOxTb4Lf65aw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95271bf7-89e6-4c4a-b2d0-08de3187171b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:42:21.0617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DyKrKGzF8oUdnGekEiijrKoawdGVBTe6hYS/++p4DaZe7Y3XJ8Dfa+f9Vxzuf6RuZoe+BbGd8iMtrCMOx8u9dlwjo0sF9xN8I+o4QzQYNSTVxUGwCP/4cjwYpq9405R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6833
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

> From:=A0Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
> Subject:=A0[PATCH] board: BuR: Update MAINTAINERS files=0A=
> =A0=0A=
> The MAINTAINERS files for B&R boards are not in sync=0A=
> with the current file names. Update the files so=0A=
> that they are correct again.=0A=
> =0A=
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automtation.com>=0A=
=0A=
I messed up my email address, please ignore this patch. I will send a V2.=
=0A=
=0A=
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
> ---=
