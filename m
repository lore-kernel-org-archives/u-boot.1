Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA79CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26FB86E54;
	Thu, 12 Oct 2023 14:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sysproconsulting.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sysproconsulting.onmicrosoft.com header.i=@sysproconsulting.onmicrosoft.com header.b="IQBIO3V6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F1C86D4C; Thu, 12 Oct 2023 04:05:16 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDDE86B42
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=sysproconsulting.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JayTalbott@sysproconsulting.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcLQZE5sHCCQI0LAcTYW54Q9y5brKxwKBS/R4fRy3eLhScfH+3bb6PX81knh0MRDtpXs2kQQqJAI1lY/pAkd9WI1++OmeeM+SuU66ElFFQsVp95lhi6ySkn9EmQc+FHMQQcqNyhq1w1P4Vv8OgfQatOANT/SWeu787eW2+7uGoacr6Ud/MatCbXSLpWza4zQ0cW5DVPW/ZaQQubSovnCV3XhMLQsSUTQcRPNhiZ7KqiGyBotNGtNV3+WNWoAwGJokSBvSuPHycu5FPEBUdUYebgI0jxHeLfW/PyGqPoXHlDCDL0M0G/N/yLxHeUwZdZB6Hla6n30lxDdvADbxuIWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xupbgQ96Gomw5ysb8uvwKaEeFFW+WRd8LcLG//bisg=;
 b=Kff3nK78gacHFaH2+lM47drTtY1OZ9x9ZpwNO0OMf9gzL5TCazgdFLeBgd50UnczCAiepJMpuGjG0SrPtfEUzjO2CtfN+zHh6XbIKUq6HQe2IOHWrlOp60SVTxsjL1rkfHRWXSC/NoUm40eeTMkKZSo26ZsllO0YsEsL8VmEjPAA+bPQzs7z9Luyy6V6DEHFs7Zhv751taT9XPQSXskFqHF9AUO3crA1vkD0dlbhmi331Cs1MVOcfn2AKa4MrNLgU48rK1bW+fyEOe8733jiupAgJgYR95yl9DtLnnZgVDCvQlD4SqF9ikGwRe7szmP9fCmQKBJTFTKm9euIPK22iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sysproconsulting.com; dmarc=pass action=none
 header.from=sysproconsulting.com; dkim=pass header.d=sysproconsulting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sysproconsulting.onmicrosoft.com;
 s=selector2-sysproconsulting-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xupbgQ96Gomw5ysb8uvwKaEeFFW+WRd8LcLG//bisg=;
 b=IQBIO3V6Cj8AwYkJK0ORA0t6Pshh1/QjHOrCSqdGhyUmBfZXp63HkEvEliieYxLdQpM7jpxPRRA5oHLv8x88LH3MD6237KLZvrgAvpVBMKd3N6OcaV4INKbBS24hDhSV2k2k02i2tDkZKAhXTtbuGnIea4QZsaN+IlaDdhc3pmk=
Received: from DM6PR22MB2262.namprd22.prod.outlook.com (2603:10b6:5:2b0::15)
 by DM6PR22MB1883.namprd22.prod.outlook.com (2603:10b6:5:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 02:03:49 +0000
Received: from DM6PR22MB2262.namprd22.prod.outlook.com
 ([fe80::c7dc:236c:28ca:3aaf]) by DM6PR22MB2262.namprd22.prod.outlook.com
 ([fe80::c7dc:236c:28ca:3aaf%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 02:03:49 +0000
From: Jay Talbott <JayTalbott@sysproconsulting.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: coreboot 4.11 + U-boot master
Thread-Topic: coreboot 4.11 + U-boot master
Thread-Index: Adn8rpZLilu83j91QQKlflGMUcs7Zg==
Date: Thu, 12 Oct 2023 02:03:48 +0000
Message-ID: <DM6PR22MB22626D184E4A7038A3648C97BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sysproconsulting.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR22MB2262:EE_|DM6PR22MB1883:EE_
x-ms-office365-filtering-correlation-id: 4fefc5cf-58db-4c2c-6f89-08dbcac77993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76JbYF4hlE0BMaTUQw8uMen4b1Oj+g9giJIx6uNTtEan2ZyhkYSf9REJTM64r8kyFtUcxVuQckPXaLVKgE3aoSI995MpqFQW9esP+Fo5+aGdl1RWIwh3pINPw5+CUWpl5NIw7+DvoM6gzkAgTe+M0KxPxhgUxkXTwCMhLIsT8MnkH1xMJevHFClTOF9gI/A6WpIWG1mDx78G0zMbzRXfPtJXqYnqFw0KnXW3YyMJjJ/67CEpiqYEJHGqFQoKiYRnzj6JNGZ3+ASVh8TzPfMMCijneCTFkcikwAaYa2t2jxkK5yVa0qSk3/oBFB2PxWZO0TAzb8hNRZIvHCqzx8CZKd6En+julz8TF8WHDep0wbYvDlNUA+O+YJ5wX9s7gNpidkGh+acv27s9Hymn/FxIBhYfrUk79OkQgoAMC91v3lngmuNd5w64h+/H4L8akIH4Eouofv/9HYJZj5dYNWkPyHkf23PRWMvwa0/2UD4HErPWmhqvkofLPOh0i3HwDLHqbekbXd8nuTrcFgSoDJGzbYhMnjMcPMvOKIgOrkI+XNMMf7jTwcTinyxD9idtsSOue9SF2goF7l8GIbOJ7EBB5h2Viz8Ksy3l43AZiH8d+2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR22MB2262.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(396003)(376002)(42606007)(346002)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(6916009)(66946007)(66556008)(66476007)(66446008)(64756008)(83380400001)(316002)(55016003)(76116006)(52536014)(5660300002)(478600001)(86362001)(38070700005)(6506007)(7696005)(9326002)(8676002)(8936002)(4326008)(122000001)(99936003)(966005)(2906002)(71200400001)(166002)(38100700002)(33656002)(40140700001)(9686003)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QeCgJb8BNV9XMm5BdsMAZ/NTgPNVCAso5zj/a/thBozHbTfMaF+Ad4ZzsQtP?=
 =?us-ascii?Q?/7kwDR6jjmVfg38XSMrKIy4H/cQPTnUJgw+kfaEPOaoPaH4wkqVoGOHiHmNV?=
 =?us-ascii?Q?FtF/8PERw8BzjHZfZFgelUGja05nIJMrsGi6hqM1EO7JH9PupV8HY9kRPZmU?=
 =?us-ascii?Q?md8bThZKGii3ZuMtuj848qhZK7d9654aGK6Hq/D+yXzpiX2awQoZG5qOGrwF?=
 =?us-ascii?Q?7l0MTecEBH2zva4wQO6rQ3tGDJMlzRUI/0U7KDvtnAGzEMHjlu3gDlTbqlux?=
 =?us-ascii?Q?Af2i3IU2kDkQXP8EtsaVIKudjYwRasuD3BnMrGczUAgGokMmXR6qGmFyxnqF?=
 =?us-ascii?Q?MZXBAvvXa7Xsss3TZVM5ujVcwwjnJn4jktFLIa3WfPrDrkfJJfVVYND46wfr?=
 =?us-ascii?Q?QZkkDx57E4xTLM5KX0ZlwR1SwexZJJCkJP7cC+ktbkH3o2yv5TpmM2szuh0N?=
 =?us-ascii?Q?XBNdAmTPgkV/KMcRIOE+MGfYky997cMxSfR0rBKiE8vozuu5jVuCdI+Ih/5R?=
 =?us-ascii?Q?D+F84O3vaV8P/CptChlto7AFCzLV0ae4T/WAS7wzovxZ4yUWsfij0RCV2Khk?=
 =?us-ascii?Q?/wumt6uzqtjVItsZYZHcCOPg+iMuK4K2eFXLCVeshMoxHaaD2p4/kkZd7JKW?=
 =?us-ascii?Q?G5Vn/E5F06KYlh7TKW7y6BnDGrlah/trmwAfnxM/DI5b0H9fhXr+GXWckNMx?=
 =?us-ascii?Q?9s0z3HgXT5qr+qcge1vc7DZzHWZjg3ZC4zX5iUIeq7uHPx5gwjLJ6VKBLKmu?=
 =?us-ascii?Q?IRxcuAlTXDFN1nWnAwb6ZC0FyrXIitE0QpAMKxrpjalBtVWium7aw0DJ9bHA?=
 =?us-ascii?Q?MySjsmiIaDA9+Vizse0JJZ8IbggKeQd2ZZZOJF3N22b8zLcZvLkpdbMPlMVW?=
 =?us-ascii?Q?hdLx1QWPCYw+t/2MnPpngpiviLj1H1rczI+ACwj7EPIw9WdwYDU3U0yEMNtk?=
 =?us-ascii?Q?mee5Ry26ZTyJ6u5tTa2dhc02HRrZoIBJfFihBLXDXQZERjNpoewUAPKXXW5A?=
 =?us-ascii?Q?y6qDLlN49jKDxNOCXFZAxzXJlJfhcnTGpMFf0G9XaqDJC1yxahnCINVTe8CC?=
 =?us-ascii?Q?70riXlcSMNvA2roo6f2KlHKBftBVhzrawXVZJAerti+ig4qEsvfvxopVbrnc?=
 =?us-ascii?Q?x3n7kUFnCC885b7guZmsHXcqkNNSIlYJ1Iw67ElIqWkV1zpC2797iF3x/MEt?=
 =?us-ascii?Q?zghzBLirt5t9gXHC5wS7/ZCDwH8slj8KJPuu/6ZQklaQKqsMrnlAiYnclFmE?=
 =?us-ascii?Q?mw1ooztVgQiYz/+pu+ccUZz/Vpl4gFfquNQYl101SPVEDePL9J3mstCkyrWu?=
 =?us-ascii?Q?2ZJtJacMTFV7osLh4XN2k10cOY6mJ32SnAgWQ8roLptM45TNaloGGN8o5sxP?=
 =?us-ascii?Q?+KAJewPMijHLkn0y2O0cOYwOjjKzfzPkm48WfpYBTxiqGC10wGJ5ItHJeWyv?=
 =?us-ascii?Q?/aWU2Ro2RNDQhFz5kmehHiLnG/eyrDOmbTf6HJYNJKHs5Izfqcg67aDAvaon?=
 =?us-ascii?Q?CRUOOEZO9TZwh/UOXS+sHDb4GHRsaMysxZgbTKpnBaUbnWcTWqtb8kEaD4w9?=
 =?us-ascii?Q?0dGXYq40o/BbfCmYazXb7nCRBimLTACoVRO4mxbA7wxYYUCpWsKoAonL6dcb?=
 =?us-ascii?Q?8jQKdN92eUKRa+gWLxI76zcazMChpbJzIZmIKunK+/8N?=
Content-Type: multipart/related;
 boundary="_004_DM6PR22MB22626D184E4A7038A3648C97BBD3ADM6PR22MB2262namp_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: sysproconsulting.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB2262.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fefc5cf-58db-4c2c-6f89-08dbcac77993
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:03:48.9898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 654c0bc4-2c8d-4f52-9ae4-b268875b4e10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LKRPcTKE9lfORRMMhNCJ6ANN2vx/+Nay5JYIrldY0L8bOS+U8dZDVqzoaMT8Q+wCgB0o9ngUmBGsiPFW2n5udDshOOsuQDCxVKEoLAw+qs5UZS/mniFOCEkPvrkNUCChNq/EHORLgOtKDtYmu9bng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR22MB1883
X-Mailman-Approved-At: Thu, 12 Oct 2023 14:26:41 +0200
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

--_004_DM6PR22MB22626D184E4A7038A3648C97BBD3ADM6PR22MB2262namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

So I gave it a whirl to do a build of coreboot (on the 4.11 branch) with th=
e U-boot payload, specifying U-boot master to get the latest version of U-b=
oot.

Unfortunately, it failed to build the payload:

    Cloning U-Boot from Git
Cloning into 'u-boot'...
warning: redirecting to https://source.denx.de/u-boot/u-boot.git/
remote: Enumerating objects: 945927, done.
remote: Counting objects: 100% (6622/6622), done.
remote: Compressing objects: 100% (2418/2418), done.
remote: Total 945927 (delta 4232), reused 6496 (delta 4159), pack-reused 93=
9305
Receiving objects: 100% (945927/945927), 190.29 MiB | 6.01 MiB/s, done.
Resolving deltas: 100% (793720/793720), done.
Updating files: 100% (20136/20136), done.
    Fetching new commits from the U-Boot git repo
    Checking out U-Boot revision origin/master
Already on 'master'
Your branch is up to date with 'origin/master'.
Branch 'coreboot' set up to track remote branch 'master' from 'origin'.
Switched to a new branch 'coreboot'
    MAKE       U-Boot origin/master
In file included from tools/imagetool.h:24,
                 from tools/aisimage.c:7:
include/image.h:1396:12: fatal error: openssl/evp.h: No such file or direct=
ory
1396 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.host:112: tools/aisimage.o] Error 1
make[2]: *** [Makefile:1858: tools] Error 2
make[1]: *** [Makefile:75: build] Error 2
make: *** [payloads/external/Makefile.inc:187: payloads/external/U-Boot/u-b=
oot/u-boot-dtb.bin] Error 2

Looks like it needs openssl to get pulled in as part of the build. Is there=
 something I'm missing that I need to do to get that to happen automaticall=
y? Or is there a manual step I need to do to get it pulled in?

Also, in coreboot's make menuconfig, there's a place for specifying a U-boo=
t config file. For the first go at it I didn't specify one, but I'm guessin=
g that maybe I need to at some point. If so, can you point me to what I'll =
need to put in there?

Thanks!

- Jay

Jay Talbott
Principal Consulting Engineer
SysPro Consulting, LLC
3057 E. Muirfield St.
Gilbert, AZ 85298
(480) 704-8045
(480) 445-9895 (FAX)
JayTalbott@sysproconsulting.com<mailto:JayTalbott@sysproconsulting.com>
http://www.sysproconsulting.com<http://www.sysproconsulting.com/>

[cid:image001.jpg@01D9FC74.2E526D20]


--_004_DM6PR22MB22626D184E4A7038A3648C97BBD3ADM6PR22MB2262namp_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=9610;
	creation-date="Thu, 12 Oct 2023 02:03:48 GMT";
	modification-date="Thu, 12 Oct 2023 02:03:48 GMT"
Content-ID: <image001.jpg@01D9FC74.2E526D20>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsK
CwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQU
FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAARCABLAUUDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC/ovw8
13UtNjvrPTby7s3iMqTQ25dXAk8shcHlg3VR8wGWxtBNSTaPLpd9cWV0fKubaVoZY8A7XUlWGQcH
BB6Vt+D2uj4ZsZ7M+I3l8pkRLS78m3aUzthU+bO3hC20cMxJI4NTahpsUlneXSaXrBu9pnM1xIjI
FDDfI45b+8DknDAgnKtX9Gwxc/aOM2rXt/w+p/FuMy39zGdK/Na7vqtulo/qeG/tPXAHwkuLcAHb
fW/zevJPT8a+QoZDC2a+rv2lJTN8ObtByfttuf518obD3r834nhUWZxqU/5V+bP3Xw5jCOQuM+s5
flEvLqW3BxzVOaQzyFjSBacFrw6kq2Ijy1Hofo0eSm7wWpZFuv2ctnnFU9tWd5Me38KYIz6Vbo82
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

--_004_DM6PR22MB22626D184E4A7038A3648C97BBD3ADM6PR22MB2262namp_--
