Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B281CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 09:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EC786B35;
	Fri, 13 Oct 2023 11:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Awai353D";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jjNVsN4s";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oF6YgbsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED8986B29; Fri, 13 Oct 2023 11:21:46 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CBD86EE2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 11:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Alexey.Brodkin@synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D8T51j005034; Fri, 13 Oct 2023 02:21:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=uSx5wn5lOx+lZS0m/l4YK5hPhokyJONUSD0LMUhyEoI=;
 b=Awai353DsmHhcxvLHFrJekOaA/rhBa0J4UxrOb2jZoeBgeeVwBh7UCp9qHf40cIjPhi0
 iHI1NTx6c1bNRsRXd5r8SfQB9Zma4yd+FPolb2Z94PG896mCiuA/QGE54VknpfABCR3Z
 I4YmsvNUpiVrbgUGEpnIUE8MHIZFy6lJXOwLcq2uKPUBRmNaFnsQtzkHCIwdHVURbFjT
 9C1B97rrC6aRsezMxP9DznewCpN8PRuPmepoyY9btCCyYZ5RnYLwM+yHP5apMeufxKu2
 sSinfPnWsquczt121PJPG6BWTDkCEQU6y/Ob+mHEXJDrMRIVyih1UZ/5q2uqfH3+hWeC sg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tq2dx8bs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 02:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1697188899; bh=mhvDU66pBN2Raft60Ye48IV9rs/FVAPmBCmxyjFmo1k=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=jjNVsN4s2QOTVDaKMJ0MCWTvMy4InMW5dw5wYHh+DbzlxVEYots4uct4T+JSnY89r
 plDjliRcpt+3jaAh5EQzoR7WOfzceWWI80VVm3v7mGjFV9X/UJwtzIgy34v1BjRfsD
 Uo44clC+xscBQC0ag+kTpMOdHpFSCTceomcFU2ni/078/1Lfi1DrVG3f+dyzX9CmrE
 6lYYZD/PoXYMPFP/gme3Xei5Zk3lzZ3RssMuS1gYcICcCj676KS+9LOYODD1gA0feA
 FFaIbbdLQZG2o0Qe52oGbHX1r2aUtDsariKiok1U7iDtyiqIdqvPnaMNpmjzcpFlvL
 iGj382slOtHKQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com
 [10.205.2.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 84E0F40567;
 Fri, 13 Oct 2023 09:21:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Entrust Certification Authority - L1K" (verified OK))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 9D272A007B;
 Fri, 13 Oct 2023 09:21:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=oF6YgbsC; 
 dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id B6923405BB;
 Fri, 13 Oct 2023 09:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXb8rEcnx1iZIbT0QDmZV0ml3aUDWlJPO/o+0tiA8TbD4uVEhypVsDW5BrzDFkN1Iik7tEKbObJD2ytUETUm7uvPDvCiqe+2LqdB8JghDVyT6148h21YIJ66S3+Vjn3sh3LPku57pjl4v57MH2zXzOrInDkF97xokZ8IMmyUtiAICKdH6kYR0HByyrMIWMjUy7p6Qmru4xekzdwrvW5vZCbPz+JWyBC11ikk2kHCQ9uKDnFeUEVGIKgg1gu4svVkoHGRDu+gs4uCXzGInmwvxw3RIb3oJrtELYIZwxZ6M8Or7X5S/EYm+vO66DMbOP/0PR6qTGKnx6oGGWCq+k4jGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSx5wn5lOx+lZS0m/l4YK5hPhokyJONUSD0LMUhyEoI=;
 b=nlvltafWuBSypGS2GpHp8ju/EbHoBUY0o7w17SkBlDes/fpfW8yJ/FjEfowVj+6pmPs+WRnOdLe4EPKyRzlD6aFrbK8i98TTXdP7JTjnNCjbECPvXy5tE0O81b9/ucR70egvSoutNMILM/xPYv3UftB1gK5Zr/g0chhTGlUMAT24oLC5K5i4KPnoNxKw+sWI97dpp8cZK445UOlkkrorDto1k0b66bTWM7s0L5u5QffFHgidpIEUUAMAtCA5GmGHAtfOXFrZ0ZXEIKzWPZHxVT4i/tQwQh74L9xrALscR31kDorRt7Yee2urED9cZ43iGnjEvZ5e1oz+z1QMIHvYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSx5wn5lOx+lZS0m/l4YK5hPhokyJONUSD0LMUhyEoI=;
 b=oF6YgbsCr0TqSgOYEA5z+uO5ow0QU6bCW97fKFLsgFu+7P7gpq1Q/kzTF+faKmSXSRK+sPEShSoccuTKmkQqG4U7uOx9UB1CdxcXYmU3ZceP+j0Y2S32/ddf9wMtoac4WJ1j/R3bgXsrs+yIUWMB9EAAB2IDvUcaX1VSwBcE0e8=
Received: from DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) by
 PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:21:32 +0000
Received: from DS7PR12MB9041.namprd12.prod.outlook.com
 ([fe80::e04:a4fb:e04a:fd2e]) by DS7PR12MB9041.namprd12.prod.outlook.com
 ([fe80::e04:a4fb:e04a:fd2e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:21:31 +0000
X-SNPS-Relay: synopsys.com
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Tom Rini <trini@konsulko.com>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 "uboot-snps-arc@synopsys.com" <uboot-snps-arc@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/7] arc: Remove common.h usage
Thread-Topic: [PATCH 3/7] arc: Remove common.h usage
Thread-Index: AQHZ/WBnO53NcbNcH0aC4AqRTZMT1bBHcfko
Date: Fri, 13 Oct 2023 09:21:31 +0000
Message-ID: <DS7PR12MB90410DF2D4CDEC130E17E05CA1D2A@DS7PR12MB9041.namprd12.prod.outlook.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-3-trini@konsulko.com>
In-Reply-To: <20231012230359.2005249-3-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9041:EE_|PH7PR12MB5594:EE_
x-ms-office365-filtering-correlation-id: 43611d6a-23f8-4c83-1473-08dbcbcdc98e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNIxWf9K3gaGznSBpbzRBkf2fhPLxCERgJ1eYf/6glkn1iPMHtVY4nf68DYcEjnar5sd3CGjtCPK1fTvP75Xf4+GhPVNkGV05E6shay06x76oMUvd3dS/V67RxWuXqf6J1kCK9dDsT6rgqIr1bF00NDqke9xA0rqTBzCUrET3/psZBmyfqM8/wQE6jx6hRWr9nh27uTt3/wiVlX+81bYbnzr0oGa79JqEeAp6vD+I+aC4t/SJ6xvKHO+jdg0KxTlsm6d5XFUZhnpdUJ7fPSs2u9uBrDo6HCMprSpzSjWJf62Ibz1HOXx5XvPdAD3pAnbZLxjVdiHy7FiVv6yHSrCxlM40SSXiHl7fYRRygmiL1ZUxCYhiRzJiGSd/W77pW3ahOdbZYdc+eenIFQXT69deZFvIUmsmfEVeWgj9uurcI5Sw0//9kqNKp7nf/+1+v4R26YRNLO1CEWajMpVduI+dbB4zmioceZJrSW2Yc14wQQ87JaaFKxQJmdjwmvfpozS+5VlwjqOo1+LNR5uFedbmYmDGTBtDuTIOWXSqy9TSReIu1D5TMPpczMptkhL2H56RFgmhqCweSYJfPaRbb5EPMevetnkW799I5q3h+ushGqATI/pD6lvJSmpM6sFu5UD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9041.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(71200400001)(478600001)(55016003)(122000001)(26005)(86362001)(38100700002)(38070700005)(83380400001)(9686003)(7696005)(55236004)(33656002)(8936002)(4326008)(8676002)(41300700001)(4744005)(91956017)(76116006)(6916009)(316002)(66556008)(66476007)(66446008)(54906003)(64756008)(66946007)(5660300002)(52536014)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kxDxBR4gdHNEg6MX1gZksQv83D1TVoyDKlsNY6CgP7bF73XBCLnWOj/wMA?=
 =?iso-8859-1?Q?iBDBCU8SSWQgjNEva5HeWssSIppmXiDXa0FxnffcbB6a55JiaQt73v5t30?=
 =?iso-8859-1?Q?1SgciOSaj0lWYWx8o1kmO5Jzx55T+s1GCX9sjQdY5j0gE8yrrA+vq6GS7a?=
 =?iso-8859-1?Q?s1Yyk9Hxc5zT6XYUeaVMgX/NGCTg7g0UR8FndcEvChn8wdPmogx2jKkEbE?=
 =?iso-8859-1?Q?YR0/jE6B0Xtovuq2x8l+f7a9NkSvNglLvPEwIiizZigXsTvT2TKXgULZ+b?=
 =?iso-8859-1?Q?2SYGwqXUFFLnnNKUZlTZJeW83AWfarJDXvkzkzIMbuCNFzPmXCWlVRs+St?=
 =?iso-8859-1?Q?A3WmYVqYBlOXGQ2ng7Bl4Y3OE2HifsYKFnegNKN4P6trxPCWqNYHl3a6ug?=
 =?iso-8859-1?Q?p7T+GPOTFlDOOzC4hZAySPj/vbuJfTPPDLg4iSZ1hsSI6a274Hnl1fuBg7?=
 =?iso-8859-1?Q?KeqXcC9ih2rK3htTM4gTSrceewcWszpAMeskQ9ieTEiuVLyXmPgIRQkgud?=
 =?iso-8859-1?Q?adpDNeiRgsYjyGsLbaBzdvuD7x7PT5jKYodJGPq4TWAc+H92iCTdZlmgPi?=
 =?iso-8859-1?Q?q8MtD+neQ+2pa292KpuMWmRf5uhsK8e262La7phDmR8dy1zqhrWvqJ2Q9z?=
 =?iso-8859-1?Q?dWqacsOakWvVdwomkF3ZdjuL7Nm6HP0tKFqM4RHiQ95A5l4QQ7qH4RrWlT?=
 =?iso-8859-1?Q?OyMURVdw0Ph3TvvIZFtVwZWunlbgGRRljk1ffnQ3+YUXt1YO+yY3MN5fNE?=
 =?iso-8859-1?Q?+eGXq5LWX79cKxO1ZOO4vNrgupA7o7zHRzqM0zRtI1EC/r10o09tS1MWQk?=
 =?iso-8859-1?Q?oBqTSl92TJpEitSJ5P34MgivR7Kfop8zZwVEqcUAvJi45w++w94XehXVGo?=
 =?iso-8859-1?Q?KHsNXn56ggV4+/VTveeRlKEEE7z2+Lv3or46md4McRPHsppp3xjCjJSo5i?=
 =?iso-8859-1?Q?yCC4itcoaR9NoZ6A8lhAyHnDxHkIR5q5cFg4BYnAhFBUC3sy+PG5a3TSSa?=
 =?iso-8859-1?Q?RV4FR+AQyrLEhQzaqILuSUwVImBoV1HUJKwvjhXCrvVDFtRjC6C8HxxrhZ?=
 =?iso-8859-1?Q?AIvacHeDHBTJ+RHQ0dDspCs5uXExQajUXAcybwcIRz0gd011MnNEdlDGhY?=
 =?iso-8859-1?Q?wald05fILxS1M1QNKSU8vqg9L3LnNZg9tUjAKc/drLBaWqP56bx97jAHRE?=
 =?iso-8859-1?Q?sL+KQM8s0fw8wud4Aw95y2Otq37UDLKkJOG2ZkJm2p10JXoW/QUY+uYJxv?=
 =?iso-8859-1?Q?Gfz+mDzH/rrhkziVnZxCWTZG3YjQpHwwMYPi7nF6NynHE6lYBW29TBWe09?=
 =?iso-8859-1?Q?PQJkY6V4G/HA99ZBTo3q61NQOndDhJNLsAJExkotG50fKnyF5gQUzWUoX8?=
 =?iso-8859-1?Q?+P3Iji5GoeK7FYfBLEUYSZFFD9GyYkvReqAYY0Di/W3YbnPAogAAMrMoJn?=
 =?iso-8859-1?Q?DwcAOomH4lZuk1ltU/F5pYX9TN01faFW6VQyytVmmsCk3yN6kykmv2EqpK?=
 =?iso-8859-1?Q?oJ02ZMlkYEsv+tCYnqUsBScLCWg2Fwal91ZnnRteBtKnMfSkrLhteAIrxf?=
 =?iso-8859-1?Q?Q8mfIxx74FJtAKZdfx9nY1PE3LDADu3sls4cttBlonug/hFu86ej64KAQV?=
 =?iso-8859-1?Q?aZq5ExzDXlR5PZBvRfZvp+NN959WL634mp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OLqRAoxybDAQJaGVcK3brsXrfPJnQafLjL2MRHsdUWm0QnlulgPT6kMBT2MPIbS2ZLiHVH0PTJudWU0jX/iE/SHU+5TrBKSAS2iCTvS+IHV+SpKAs4ml0j/jIXJA73zmpsYDndhGvUEVvv32PWCKHzu/e47zjNM8ac+oI8sd7LBzKRTnR5gK3tgqLxldC1fLzR25Nib9CT7y18lOQELYqanna9bTi1dMpRPTMGew8IklDdd/KkfzqIiBJVTt0OD1nY/zAVpyoSlfDvZR0R55mXsnLnKQ5EyEpClK2RhHomd3LDFNF/rNY3NqemIjwX0JD29lUL+bq8brXKjuVhcVeKucjOvhXMKusTqMM7fLc9HW7xYH63jl7PMTr/Tdv7aKyB4fCWXvzhzo5+q3fWpfv/OqErtG/DLRz3W/HgHvPvDzr2ld1SAVNWEubtTD1lGVHwngyRwbEuUTrtvCM3SOsvQE67UpwijL9pngEkJhxtderkh3RDhIgoZCCW5E7QjJx/Bc51fyZWHJMkhvBc4R1KQ0yMwufIUfDYANsjLKo67Aq3ta4AAGCraYAOj+UbDJrSDvbiQJHcu5nW2QAO4HczXdU0XIQo8+OwiGYPRh8MTwNpB20f3XgS/Lu1BMad6IdDFZCarVI+g6FdVOZIFTbTbNfd7Mq3jCY6NXmL+AmsKtOE6U8evcM1MCqvgIQz3KjyEq6VcXxW8uw9p9htkZhEY2mWyjzZWqbVtphyUvNM4lykT5W3YhTayqbZ5ZaLvt4RzQz7wwbIbHKcwv6mraEVd6stHZivUe7gMBxCQHfvbeQgn90MsyjAiVO1jrI3UfxBuslnC93ITmwocveqaDWA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9041.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43611d6a-23f8-4c83-1473-08dbcbcdc98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:21:31.2925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65R1xznG9y9GBBiZuyggUBJxCWdlf+g4T9vxbRD28rQBNSPnwUdKd/6hJcQc78U1uDAmzLWu79+ynC2fqZbShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
X-Proofpoint-GUID: 92amf50K_l7CHTMvDW25B_Hlsujrk57d
X-Proofpoint-ORIG-GUID: 92amf50K_l7CHTMvDW25B_Hlsujrk57d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxlogscore=666 clxscore=1011
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310130076
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

Hi Tom,=0A=
=0A=
> We can remove common.h from most cases of the code here, and only a few=
=0A=
> places need an additional header instead.=0A=
> =0A=
> Signed-off-by: Tom Rini <trini@konsulko.com>=0A=
> ---=0A=
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>=0A=
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> Cc: uboot-snps-arc@synopsys.com=0A=
> ---=0A=
>  arch/arc/lib/bootm.c                   | 1 -=0A=
>  arch/arc/lib/cache.c                   | 1 -=0A=
>  arch/arc/lib/cpu.c                     | 1 -=0A=
>  arch/arc/lib/init_helpers.c            | 1 -=0A=
>  arch/arc/lib/interrupts.c              | 2 +-=0A=
>  arch/arc/lib/relocate.c                | 1 -=0A=
>  arch/arc/lib/reset.c                   | 1 -=0A=
>  board/abilis/tb100/tb100.c             | 1 -=0A=
>  board/synopsys/axs10x/axs10x.c         | 1 -=0A=
>  board/synopsys/emsdp/emsdp.c           | 1 -=0A=
>  board/synopsys/hsdk/clk-lib.h          | 1 -=0A=
>  board/synopsys/hsdk/env-lib.c          | 2 ++=0A=
>  board/synopsys/hsdk/env-lib.h          | 1 -=0A=
>  board/synopsys/hsdk/hsdk.c             | 1 -=0A=
>  board/synopsys/iot_devkit/iot_devkit.c | 1 -=0A=
>  board/synopsys/nsim/nsim.c             | 1 -=0A=
>  16 files changed, 3 insertions(+), 15 deletions(-)=0A=
=0A=
Thanks for the improvement!=0A=
=0A=
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>=
