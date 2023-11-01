Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DB0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 03:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D9687BC4;
	Wed,  1 Nov 2023 04:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Onegdf22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D71B8727E; Wed,  1 Nov 2023 03:57:24 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37886871BB
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 03:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongxing.zhu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYhPqol0QmKX0A5yej9rJnXiAkptQUnUSo2bbAj3UVEjASR+oz107AHoRfIV7mJlTTsXQkA4TkPRv4XpRGQlu024k1mtWVOT4fX+MxnQY2RYItOmv8N1tHSDCQqtHiYzpV1GA6E91j9pH2MH0KUD+XYL1ynG43VOKKgougzyLMvI8enCPpKsjR/RUabf5Vr8slYCXDKkHwPrDlsN8xYICbbiFsFqTPAIbxsFGUHV022bz/y/QEF96GNx0aur/7P/pbXiie0+ou3zeuXzcCUZES871Px283wVPX35zxVrU+KnEkm/lUeXxqP8AMf39QLT0dfz4fZPKZ4sNOfKB+gMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OblxuPAJ3M2AYAVRByhbiMmcYAiJxy5AP0wmZ/H+Rw=;
 b=K3OKkVWGxCqlL4+sg+yCDOQKxchZi+3M2EaFlMtli1JuEXhEFld4imHRtYn/HMSZOizVWa0JIwFgvl2CjkYWDdhSyQV3VjcovZHB6DHkR052pgMqASD5lbQ7cEYiay3qijioeHwJDp7AyMoCpqFS+EPL1vo9bNrRJK9wecDXBlOsNYGfViKotNrDKHnCzOOxjkWiMs0FwB0Ib0zCCpnb76ti3wVyQe/isQ+LbHQCtYJ2QyWsZJnjVDz5BXWH7Rfi3zvnpSgR/XjwG0jsXq1bv/xoBNeqsHDmVsa+rrw8Ui2/uaK9dGRiUOLMc6VNV4NsXsT2w0EMF3Gc8z0Wp12noQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OblxuPAJ3M2AYAVRByhbiMmcYAiJxy5AP0wmZ/H+Rw=;
 b=Onegdf22nkzwSOnu8FHwg3ME+8I0o07lMO+dwdpZ8LUWmAuzUJogzpftDHj9H5MpVNtm1f6oxyBT+WXiWFnI/xOuoex3WzESlmG5jE6IRyxvtFXunnLii8YAfrzzlQKGVpk0dOmOlHh9UlYh1NvWyNGxAGOGaXzjaUdL2RX96Wo=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8350.eurprd04.prod.outlook.com (2603:10a6:102:1ce::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 02:57:18 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ee2f:6e8a:3c9c:c3ea]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ee2f:6e8a:3c9c:c3ea%4]) with mapi id 15.20.6954.018; Wed, 1 Nov 2023
 02:57:18 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk is
 gone in next scsi scan
Thread-Topic: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk
 is gone in next scsi scan
Thread-Index: AdoMbvzePOEhAsuLTy2OTmnmM9Wusg==
Date: Wed, 1 Nov 2023 02:57:17 +0000
Message-ID: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB8350:EE_
x-ms-office365-filtering-correlation-id: 53790e96-6318-41b5-fd4a-08dbda864206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJBAIWaLzKLloaz6oMWsFqCXSnMs6FrublxmTGpRv2Kh5Y97ciuEJR6W7JkIZNR4KC8Botv081yuhzL2KACERR6ogj+Z+b/N66u0YTmvaAwfg86V1b1Ztk4XwrvCH39ACx8LhSJbB4SNQmzEc/MeCmHM3lSDqO2YRgDABX3xEOcgc5ZSPxVXBdYt9PFGbZyssScOxgxwBJMJeR+JKkQrOoyjALIh0N6/mIXD6ru8l1N47yAybP1J7IgHiUW3MMCjQR2zGPcUkpkVzM0FHRIduwWIzfIRr8AxjV1f5z+XiAmPU85ByspAZbhy3vyWn2C1XOn31qH/E7WME2wXQGC29OmL4NM59PWolDvMc4FFMYao4KuDEC3TnNL8YIbkVGaH3JHephQpt+m12u4EuQjf4KLSMqRPqoBupdkzGmXDHuwJrHLkN4ufKdZDQUY+JcnUxbWMEBtav+kbba0K57BRFVQt2fCReha5mfH1k339lBdoDJyEH278w3sOuBc6z9Ur+T4aqhycQJzwlLezG7jZlpSMpMMH2oBgwOJesFCIuloUAbLSuUFAFkk4PYD5LsnO9X66GkMpWfgu/UyfRmWcFdBSeMEoZ7GqTtfRx5BYOZfAmgKtasFZREhcCMnMPJ5Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8676.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(55016003)(9686003)(6506007)(71200400001)(44832011)(83380400001)(478600001)(7696005)(2906002)(316002)(5660300002)(41300700001)(66946007)(76116006)(66556008)(52536014)(66446008)(66476007)(64756008)(6916009)(8936002)(8676002)(4326008)(38100700002)(122000001)(38070700009)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HV5a6haV/J3oK6WQ3vphBTmDNJSNJ5nqCRABDwhgwCYsJSnsXhJOFXB8tNYT?=
 =?us-ascii?Q?TaJDiS4Db9dWDgqjcyQ9seLMfWnoaxI+G9i1QlBxPeWYU0fwBPkE0b9lva9d?=
 =?us-ascii?Q?Gc6Yw/kwh1z/FnBUHFAzt/wafm6cKnXZkuJftoGduwVKSIcV4JOq1g7C8sxa?=
 =?us-ascii?Q?migPLo8fUXMQzD/gKbXZSA7EI169FdK+Brcc+0BMqkF9AitYoIeS8P4K6eQm?=
 =?us-ascii?Q?2MHUry5zicjMtYC7RP9K4krHm82sdESHXIIhuqA6/8WjpbsHac0MWcJ8ajYf?=
 =?us-ascii?Q?Ye1VPAGRAqUpDp+qOoorkSeGb0Pi2LaNN9625+6ADPe0/EdtWIoP/N3oXpyX?=
 =?us-ascii?Q?CQu5oQZlaCqcHpBH6PCrsNwV7VT8BhInCcJhd3C7sQH9WYpUNYvjEXmUkV6j?=
 =?us-ascii?Q?VW+446VjJBt4mWms8wiR/bSNNW9hTySyaY8KMRxksgxO/4vF4qQ7qE2jOEK4?=
 =?us-ascii?Q?S2Zj1idUqXGb8taH+a3IMbUREJaMQZ4cMom/ekX/kXhk2upmhcZyFHEvV8vg?=
 =?us-ascii?Q?vn6AXMlNEFDDUhHe6kh2wNHwmcrli3iukggy5mq7GB4/ne8XreujkqU0NSTp?=
 =?us-ascii?Q?wx4xzko+QLTK97xP1br1itWXreen41RAFZQALaFGNdaKPGTOBMbtrMCdAnaB?=
 =?us-ascii?Q?S2gp9FTSvKzOJt0tUK3rW6EddWKIAIFAmNz1WaRuDgMRFReLz9fnI7RYRjS8?=
 =?us-ascii?Q?P1tK3WxnAVyQCNUjaiL2boIGJqpQ9kA95LQbZOguYJkQBdaCp1mjsomBl4Os?=
 =?us-ascii?Q?qd+wLAxyybTQVLvgQjj4dGGT83+o822AM1RQjkR3Bzz2mKtYAtp86gaZfSze?=
 =?us-ascii?Q?mADE6hQEXuttTBfXpIIXdJISZH1DJ6Jr9ZJG3qoYfbboVIxan3pow8kBgmnC?=
 =?us-ascii?Q?N11I1aMxMWf/XEXEiakfibFTQ6/IWYHRNrOEhpU/uaoY/l99iF9nVNQ4QgVd?=
 =?us-ascii?Q?STiukn1K85yDdY1hV1NsDczAVBJsBVT/ffocN9M/pR7boE3nYEHVxGZm9iuL?=
 =?us-ascii?Q?zSFLiJ6lxF5jNjvLFTyWnqTYZ8ONxy9zkmmeoh64pvGA9rQrUKmkqmp+7k+g?=
 =?us-ascii?Q?kjLpXLFGFc/L7apPKWigPCfNe9oi6lGs7UoeImxIsmp2N3v3JUZhIWu4Z81v?=
 =?us-ascii?Q?eoazZlMJRRE/UvKltPCxUyKo+nCTN+P5UoPWN2TWgzIOCPCoatnaXoNhOM6Z?=
 =?us-ascii?Q?WtMpZ8OUoKvJGwTH46OrcUUL+OpEtnb8L48VnA4aeanjK1nrskY0+ujmJiE/?=
 =?us-ascii?Q?thIw8KA2Go6BLUJFGuL6jVinI0z8xYGdU/YAmsdJ/jC801Lr7kC56bjx5/cd?=
 =?us-ascii?Q?rvsGWufzD0VT9YeWyjkTfvZBApoVbAd9oJ68ge0A++3WbFCNJgDCUmyp97z7?=
 =?us-ascii?Q?JNijuGf9TYBfUIeBWn1LVfplGds7LePIMM5czGgOcWUbRtGCLhtrC95eDpQ/?=
 =?us-ascii?Q?79SxAlZRZ7lBrApPHuqLq4fW2F84U2y9vQmprt3wjahLvybawQgv856+uhNJ?=
 =?us-ascii?Q?961E9CxkX/X95XnrqAZWCmfD33sAiIGK9SNJ2PAwrpu+GeOMpEWBIl/kkmfP?=
 =?us-ascii?Q?e3iztWjtK3RuOUTFhcCJGDexzjMiCY1pMgPFf/su?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53790e96-6318-41b5-fd4a-08dbda864206
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:57:17.0766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrFDTXx1/rnY4mn8yBlc4RzIgKIzr1Ps7iOMCcVFJeBNo4zlp9UO7ZHPJa8iHFiTd1H9BODSMUmnAMj1cn7NXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8350
X-Mailman-Approved-At: Wed, 01 Nov 2023 04:02:23 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon:
Nice to meet you.
The u-boot I used is based on v2023.04 tagged version.
Layerscape LX2160A RDB board has four SATA controllers.
Based on LX2160A RDB board and two or more SATA disks connected.
I encounter one "scsi scan" problem.

After the first SATA disk is detected and probed properly in the first "scs=
i scan".
The other disks would complain that "EFI_NOT_FOUND" error listed below,
when run the first "scsi scan" command in uboot environment.

Does this error matter?
BTW, "scsi info" says that all disk info can be dumped, and all disks are w=
orks well,
after the first "scsi scan"

In the consecutive rescan operations issued by "scsi reset" or "scsi scan" =
commends,
the disks would report "unable to unbind devices (-1E)" error.
The first disk is disappeared at all after the next "scsi scan" operations =
is finished.

Did you used to encounter such kind of issue?

Any suggestions and guidance are very appreciated.

Logs:
=3D> scsi scan
scanning bus for devices...
Target spinup took 0 ms.
AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
  Device 0: (0:0) Vendor: ATA Prod.: ST1000DM010-2EP1 Rev: CC43
            Type: Hard Disk
            Capacity: 953869.7 MB =3D 931.5 GB (1953525168 x 512)
Target spinup took 0 ms.
AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
Adding disk for ahci_scsi.id0lun0 failed (err=3D-9223372036854775788/0x8000=
000000000014)
SATA link 0 timeout.
AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
SATA link 0 timeout.
AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
=3D> scsi info
Device 0: (0:0) Vendor: ATA Prod.: ST1000DM010-2EP1 Rev: CC43
            Type: Hard Disk
            Capacity: 953869.7 MB =3D 931.5 GB (1953525168 x 512)
Device 1: (0:0) Vendor: ATA Prod.: ST500DM002-1BD14 Rev: KC45
            Type: Hard Disk
            Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)
=3D> ls scsi 0:1
<DIR>       4096 .
<DIR>       4096 ..
<DIR>      16384 lost+found
<snip>
<DIR>       4096 var
<SYM>         12 linuxrc
=3D> ls scsi 1:1
<DIR>       4096 .
<DIR>       4096 ..
<DIR>      16384 lost+found
<snip>
<DIR>       4096 usr
<DIR>       4096 var

=3D> scsi reset

Reset SCSI
scanning bus for devices...
unable to unbind devices (-1E)
=3D> ls scsi 0:1
** Bad device specification scsi 0 **
Couldn't find partition scsi 0:1
=3D> ls scsi 1:1
<DIR>       4096 .
<DIR>       4096 ..
<DIR>      16384 lost+found
<snip>
<DIR>       4096 var

=3D> scsi info
Device 1: (0:0) Vendor: ATA Prod.: ST500DM002-1BD14 Rev: KC45
            Type: Hard Disk
            Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)

Best Regards
Richard Zhu

