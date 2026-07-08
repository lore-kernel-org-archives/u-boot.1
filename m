Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37022C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF2884B42;
	Thu,  9 Jul 2026 03:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QeSDlNhb";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VHbTbWtl";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qZUiCetz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E690A84AB5; Thu,  9 Jul 2026 01:04:46 +0200 (CEST)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com
 [148.163.156.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503C6847AF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668K61Um3831454; Wed, 8 Jul 2026 16:04:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=cMHp0a4Or0QtNU9L0Vo5iYskDoUr5SFwU7x8lM1JjfQ=; b=QeSDlNhbGxcp
 sHTRomjDhbrd1twPIdqC7mDf6Vx3QUJV3tgku6mbmgtlNsw4MTrwrFtFuzmOZD3P
 c9+Ce9Wtk80jAaNjEnBsCwrhmopa8a2ysimbyg+3+4zpaaRq5j5tMYLsR4XNR7AD
 tZ/fUMefEl5Q8E7OrXhMc+veP8M6tqhUSww4L67qbFP1HAkZUyeaMF5LZQ+Gj4aG
 VMqe4uYtzS/rb6BZOgHwRe204ygYSQZRrq9iPoL91Ntysx+eyPQXWcyX75s+ISYQ
 7uPxmynYcNWa46tkKTmdNQ30bWL+TaZJOEzQPt7HFWr0G0Aehttie5PT1rWNVHjt
 4stGqGCc1A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4f9w8r93ss-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783551864; bh=Ml7bqQ2UUQsvXypD7XOFeBDF3GtDOZUhVbyD7BxfGYs=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=VHbTbWtlAjDn8BvVCo+gHtEWaWqRfJIM0Ju3vYf5uNKHtBUAYP8ocoEu83SvAp5Nm
 iS+JtH+IUzwDLKoo9NpLfMYuJ0+AC16ZE/Rm3obGUg7yshi6uVOxV17HTZ3f1NmGmj
 4pqd2h9IOvJfs4ZXyBuIIKXvSbxBv0je9meKJn9gcWJVo8gPRrx6MueC3nUp6JN9Pe
 oih1f4yes97IiWFGIettN86z9MkDpRkh6EPz147qvN1uUaySKDdvfrT0VKh5HtvrN2
 KRb6V8anZS17OqZ3j59rWj8n5uXO/5txsq3nslqLwRJ1cufApWj2A7SzDMC470la9L
 EGTYNXmzLTNJQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com
 [10.192.0.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B348B4012F;
 Wed,  8 Jul 2026 23:04:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com
 [10.202.1.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 36000A00B0;
 Wed,  8 Jul 2026 23:04:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=qZUiCetz; 
 dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com
 (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0FA14220384;
 Wed,  8 Jul 2026 23:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCw/AQcknLeqcA12woTKsC4ixQp+L8vCvHgsL1E9An/BxlV3qriA2Zo0JoybXJ2RV6qx+9OBECAeLEeBOxO+BggDIP38NSej6H9mgamNFdny3t/0vRDHblEEPiFeH7KUg1XLoDk/Ya8wkGJKJ3mF4geAwBXs7TeLewmk2roAHt13LgLQ49tQHbt/UWENQhhHiHhubduSbb8xZOMuvDHBGtCfIf/kBOWwWKiZMsvfEI5h9YPESHIOuiu/tBXElK5a4f+KOmpc17nQ32lZu1ac8O1yuuK5ipsOnYcJPsdCQLnlDfp7KYvB6S/n9XdQ1Y0jCkT5NNwMUZB1/WHxujOung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMHp0a4Or0QtNU9L0Vo5iYskDoUr5SFwU7x8lM1JjfQ=;
 b=SXqZ17Y4XsP8NjGdrCqWrkxFw7A0p5TQNUpQSI8GkHdt+b9sncy3COmxVGcW77Uciu4g/SlbHO8/aF5Q3ebPILHszgG1ZcwNoMyZI/IgZiNhj21eY2T/CGvsY2+Um2IV5Qcq7E1xeoNpcTunWcn+migfdCA63BGs8bIuwS1+2tF/MnYwKsAoqoGxG1XYhXkYYwG7qfio4CZug/OWFXYu4tb2Rpm31qLS/9+KUngFWLJojVgR90fDFJclYsv1wjqRhSahEb82yWGnNgHAqs62RmiycV/wewgamVo1RvE5ohFeqJ0LNFsjC0o+30U2ksoYKR0w68DgKd+5wLrkucLXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMHp0a4Or0QtNU9L0Vo5iYskDoUr5SFwU7x8lM1JjfQ=;
 b=qZUiCetz+ieesJ7KROMHca95clEb6klM+Gxq/wtmoEwb5H/c/zJSfb1sH6VzV1ewG+cR0xBIDcdjUHaWvRbaTYFeDfoY/NMAvaV11vQHwatA8HigQNgyb5yawLCB8+OKQqe+aJYLsL9vq9Vngf66QCKaGj7DFBOG6V8YAVSx+GE=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 23:04:19 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 23:04:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH 1/2] usb: gadget: mass_storage: add SuperSpeed descriptor
 support
Thread-Topic: [PATCH 1/2] usb: gadget: mass_storage: add SuperSpeed descriptor
 support
Thread-Index: AQHdDy4bvm63aIi6KU6Q0LTBpfs9fw==
Date: Wed, 8 Jul 2026 23:04:19 +0000
Message-ID: <2d03a7810112b4cb830fccc0501644d4fd3a9770.1783551505.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|LV8PR12MB9358:EE_
x-ms-office365-filtering-correlation-id: 5f76ac21-89bf-4582-7ab9-08dedd453db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ZHaCJlj3HIkty5qaJK9iJfx5SlAKew2tW7Xm6HlaeFnKlAC0+OnA5jVZuaUMLuv4+lLbmWKN29c/TihNc2bcNcLO5nmbOF4vV5QrKlxk7fz6OwqjYoIrRjzvThmAHoysBHot548/uAty8lFXur/JR0XySa5iuNC5guBmKKAUIWg7n08c7AhK1ON65NC50GjGsvWHtoNNdD+qjYW7TNdN2Ht9h5WwYXpmMpUM0acsJ4qePw9zSyq1GThQWoxrqT+GCZLI+dAgO1R+aWkWpGR2I+ZAe3CqB4Rj0m13U1PHZ7FkiuFha4Rafc6r4Vd0NnVL1tsQQkKan+N3ngv116a3da4tZKj3dsTx2s7zgFFWpp+AzC4QFOfdagRffL2zZdTK+PqEwouvbd8WuNizDNh7405EWLRMfn/eRVv3pQz9WkS4sxSGeqWkO6BaxEjltTVrwc84sLto5oOeOjW/6BfdJIKbFBckydQHaqEa/3iBZqvi1dxtF00YeY0QX+HyxkmJ3U5diPVucIp/k9b1FSvY0MzCDTGvVKzaxXho6nmMDV4LIlqjR2wP6wzFifhc57ZhWHZIGklJPErAqJ0d5/1Dzp96tyw2h7ap8a83j0Lwh79Pmt+xPpG/PfY69yvZJ9uWjmOx6x1a9Pp8FZueigAK3XW6SpiB/hbvrddDjl9hIXvu9QV94GxiwVNVZPCBN4sgH5y0j+/2+LqGM/0EWV/ZcKBT9k8WTi73SfUdLbsdWBo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y+7VFUP9QEeXgQq41kabTsNhjsaBWXfRDUfPWNyG1fDZv0poeGCUn5IGNd?=
 =?iso-8859-1?Q?04thMaLKXzdoDrKiR5htchpLq+yJMbqJKFDdFSdGlHKkv3Tedsz6ur3DEp?=
 =?iso-8859-1?Q?94FVeOANw6d0LtQa/HDvvu5vxnu1ci5M0ChQ+AxSnTRN/ETJWlGHQNJmoO?=
 =?iso-8859-1?Q?7v/nmDHfci1fkW0MkHP/GJHAzFCVlj0Ah9h9HD7LvjqndL1432PR8R2lly?=
 =?iso-8859-1?Q?fzTYhfHBW36QqbG+UHzr4zaOeMCL2hOgJ+VFiXkMByn9Ciho8QY2PFb5Pd?=
 =?iso-8859-1?Q?cfPujAeAnmaHl6tTBkxNf81I53MOWzN9FX8MxjqDZP8HVDD3r6mzSIXDNI?=
 =?iso-8859-1?Q?HXU/MJcKvBE0cBjGk+k9/hM7b/KoGNCkemkQHaHbRnMlsWtRdfRfHqVHvn?=
 =?iso-8859-1?Q?JBGqeo9zrquumyOQAUHtSO/zJS/QqEnJoIIpzmmltsZ3dSPDYT3pkHS0kI?=
 =?iso-8859-1?Q?K5mNrUKxp8GjqR04xQYoEPgc7uYPXOhk2zXhn0f4jcBC07xJcwCFs+uU+V?=
 =?iso-8859-1?Q?Dtx+b1c3YFSTUsZ7b5rdEEkvCdifvUx5Z6eKwRl491pbo93EAe0LuuN2SA?=
 =?iso-8859-1?Q?tmryFBpfJgXhxfX+3MAow8e+L0Nujxcscyq3HOASUGR8u5w6+V9vnHHosl?=
 =?iso-8859-1?Q?9xfogMkzdicuNvlVWhKngXIwo6AtQUN8rGSnAgzRbECtMH45toViNrvrjy?=
 =?iso-8859-1?Q?zRZT8k2vsWA7NyZzWrRz3x3bTegUk7/PlVE4GfC/yXBn47rhjpIFSm3UOm?=
 =?iso-8859-1?Q?yOs7dQuaY4LwS3a84lOHObJa3RDg+KVxNQ3L9BJPUsmfPf686DCYMriUkl?=
 =?iso-8859-1?Q?wAL/Izw6qQk25pTZkAoakXfx9UGL54qnt78puGLGW437Zj80hcGlyXZlt5?=
 =?iso-8859-1?Q?xayBmsl3k5u3p279McttbISZKyXyygZpSo/lviuM5UIEAUExVfU5wqbjP5?=
 =?iso-8859-1?Q?UPWNv50ZjRHCgLQyOfhdFn7/I3VsABx81v01OKozSj13cRwsmEgXmvH6tf?=
 =?iso-8859-1?Q?Wzwl0I9bN4jfkzMVFeeaFo8gsW+jXM3jvCm7h7C2cbA4ujjGvqwwb7D7ev?=
 =?iso-8859-1?Q?2vUVZP8R/yWAuGhDqdAS1U2A10gd6/iv9uDxMmcYqvtOHhuW8GuOjPg3fo?=
 =?iso-8859-1?Q?mrI4avR+9+dp+P/+rahdky8Un0aW+MqmDXEVyiAGI6rANJkl1EL6r+Lo83?=
 =?iso-8859-1?Q?Er7qUY9yQKJwyVdVMpEDbKChx8Q6VIQ+bFE2oo/8WFaewqhPs94KJ716pl?=
 =?iso-8859-1?Q?ShN83APsEVR60ZlSQNu7iN9fKkWNIX3pz9xIoQlVNe+JsD01CGBmaqyUcn?=
 =?iso-8859-1?Q?Y0zMf7Q5ECIyUiwRFfSnKGx3kGHsd8fy6D0Cgu3UNmCkAvKt5c0Cxx6psG?=
 =?iso-8859-1?Q?givcdklDTpC8BR4ThNl4KP/5QJ4sOYWJWmOngHG+NkwqSqnUmjKtwQn5Bj?=
 =?iso-8859-1?Q?IKuzHeaQVHvbPKBeRHb9ToXmcTNrxo6+hfmkwlg5yX+hPdOGLeiiR72QIJ?=
 =?iso-8859-1?Q?0oj/23Mbt0dOqHUJjCdKK5zTRH/TmVErE7tMNP0vUlF2nicDMvBj+vY2Vp?=
 =?iso-8859-1?Q?zOid7nE2CGkJPgmml9yKL74AlVfll3lyKDOd4en2ZyqOH/CuGjaUrefBkP?=
 =?iso-8859-1?Q?4NOnm6toT35mZa2EDVfDwSRShzcPfXMk4qp/d+E5mlKGyXQnXA15eaEx7R?=
 =?iso-8859-1?Q?Gg1NcypRpUY83PtEsLcr9o/Ie9tP7KRtZpTZnaL7VOQM6QJPmEGi6wLcai?=
 =?iso-8859-1?Q?5dp6M3Iusn2vy6l93z4jTVpyDn6z1g5eD9mObs9uwcNE7S46v3P5n199pV?=
 =?iso-8859-1?Q?qUQJ7QvJ9Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ljnVVjsIN/iVeCNtohZzpQE/EjFldLAYeVDzz6n62ZVSCQZSTtlyHJCdT6JgryHA/9PF7q2O90cXOOfzg+Gis0ZhwOZ32fCbS6dCZE6ryl9rmbzq3ilZYMndSa8f9LM/JcOkLb/2DK+tkRxuquwNg6he7oig+SR1crH/9og+f89qLJc/NMbYyel2nM2Um6Kf/0FVpihrtjedYv3H7UDDWxJ+Cy+J/6bRBAFa5CUpAnuAzltolKd1SmfgyvzHVeedXABkpdZTFgFFyoNQsnStQT3JDsg1x9nK40tvrfYQ44SuTFuBfT0tNBT6Cv31NQCO68tUumAN7bKfuBYJxtSp5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9XdwjUqnOzSvsqjz0AcX3u6LqX9teMC01QJaY/8DvApbvXYtTO2iwe5on+M8OhO44QR6SWEtAk0sgherkSo5M9Pj17uULQJoHprhPCvaXlNaZygzb4sOBmsLuMCzIH2nZU0hGKWCn3jpza6WadyHXvF71PhPAnIKHu9cISy97M948xNyIFpu4e7OskkXJrtBYUm/AqnYA/310NUIkETpPiKSrOyOTyXeno31JSOzPuOOdg8mApYBXdBkRs5SiulSidnj2FyNWpLH4L4Dr2a4Cgan+mVwpWWWlBzX/UJ7o4KZHX2mJSn1jUkzA7VncQsJRq/Pn+fvrqhNBP4EePva4BPdFTOde1s4EBp8hNuxBFgbwXxXU4ykkTAphdLSPmH8ItcDvGODT7J+qN6NPyjLTOJTVWg1aIA7UePSVaE2vWOnoPQsvvyxqGqacJC0vF/Hr6kOg59gaBpq+mIqQ31l/IR/RHiGmAqXUTyu+4UrpyeRZnkcVxRBfn4wl5zBDNqj3cXrz0MHmBHeuq61iVQOt9fFOG+7ZgpFW8zS5BTPmSjdiCbcDJsR2YSEFzkd6pfW+XuzHbrfsho9sGXiJtyXhwCNj287/NGARUG3UYt6GHCK36uiw8vrOHAHv0J5oZPau3PTVZk/0o7UdQOsfiKS1Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f76ac21-89bf-4582-7ab9-08dedd453db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 23:04:19.0766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9dSpT4msepf3PUiC6ECognDUmFa3mwgbhstNIBwkYRifNhvkTnFNhQAdjT74SANZ6Ui/98IrMD5BOD3gc9Tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX4jLp3IKsT6uh
 csOutAZ5m1VD+TqBHqGwARc8bIJnyVLxr3z1C6glkMWnNIyd7bfPxYT0nW0GCRQaUD94J/Q7Sq0
 IbNRfVRGxu341eUomRf+TBrjLii1ALI=
X-Authority-Analysis: v=2.4 cv=Icu3n2qa c=1 sm=1 tr=0 ts=6a4ed778 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=jIQo8A4GAAAA:8 a=UoMAnIRK8_7dL5_KUCQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: Ce7vxCf49dHOqyWpw_K-Pf-E-LmQymXE
X-Proofpoint-GUID: Ce7vxCf49dHOqyWpw_K-Pf-E-LmQymXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX3KiCXaVNcOPG
 +o3awZZdNVfhqKU723cEN58nAFQfBOvCUmAIv+Mfd3oVBybumXurVFUk/rk2i3UhbzI0bymqZNS
 ghkrft1TOZVNBv6hOMSm3D4pTrJQ6F5XjbgffhEAnUX9l08+blwVPE0cSKtsrVDpIKlp55J7fBp
 Wtyj9/hy5xHDFQyCANLecogE1gw/l2+HYxQAsRKXfwoW2dtXZN105dwAq5aP7fJWIiVbgOhp7ZE
 AsKz3xGsaEJtCp/g90QVv2a1ytazsr/yhbpomMF3082iy8grP06x8WbP6M28hFyRZOiAkDmyHER
 9SYD8NaJsfHxlT0liR4BXkwBfkhj2gvL5nBYFC7tqd+BuqO54XH5dQ3AtsmU+KFRwLuJHVtwtOQ
 JyOaRc7mxJVBvMY+kM7S8R7KoUB0kT0Pvxx7oItUKlyJwMAIqPgFzP1iEq4YQjcVCdU07njygdt
 McWbUS/kMcxSmSv29Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080226
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:42 +0200
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

From: Dan Tran <trandan@synopsys.com>

Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=3D15) to
storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
to select them when operating at SuperSpeed, and wire up ss_descriptors
in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.

Reviewed-by: Tejas Narendra Joglekar <joglekar@synopsys.com>
Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mas=
s_storage.c
index 87ed25e8bb3a..a2f34c100482 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2225,14 +2225,16 @@ reset:
=20
 	/* Enable the endpoints */
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
+			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
+			&fsg_ss_bulk_in_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_in, d);
 	if (rc)
 		goto reset;
 	fsg->bulk_in_enabled =3D 1;
=20
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
+			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
+			&fsg_ss_bulk_out_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_out, d);
 	if (rc)
 		goto reset;
@@ -2653,6 +2655,7 @@ static void fsg_unbind(struct usb_configuration *c, s=
truct usb_function *f)
 	fsg_common_release(fsg->common);
 	free(fsg->function.descriptors);
 	free(fsg->function.hs_descriptors);
+	free(fsg->function.ss_descriptors);
 	kfree(fsg);
 }
=20
@@ -2701,6 +2704,24 @@ static int fsg_bind(struct usb_configuration *c, str=
uct usb_function *f)
 			return -ENOMEM;
 		}
 	}
+
+	if (gadget_is_superspeed(gadget)) {
+		unsigned int max_burst =3D min_t(unsigned int, FSG_BUFLEN / 1024, 15);
+
+		fsg_ss_bulk_in_desc.bEndpointAddress =3D
+			fsg_fs_bulk_in_desc.bEndpointAddress;
+		fsg_ss_bulk_in_comp_desc.bMaxBurst =3D max_burst;
+		fsg_ss_bulk_out_desc.bEndpointAddress =3D
+			fsg_fs_bulk_out_desc.bEndpointAddress;
+		fsg_ss_bulk_out_comp_desc.bMaxBurst =3D max_burst;
+		f->ss_descriptors =3D usb_copy_descriptors(fsg_ss_function);
+		if (unlikely(!f->ss_descriptors)) {
+			free(f->hs_descriptors);
+			free(f->descriptors);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
=20
 autoconf_fail:
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/stora=
ge_common.c
index 7e4b542f7ce5..d745649eadb7 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -531,11 +531,61 @@ static struct usb_descriptor_header *fsg_hs_function[=
] =3D {
 	NULL,
 };
=20
+/*
+ * USB 3.0 requires SuperSpeed descriptors
+ */
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_in_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_in_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_in_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_in_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_out_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_out_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_out_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_out_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_descriptor_header *fsg_ss_function[] =3D {
+#ifndef FSG_NO_OTG
+	(struct usb_descriptor_header *)&fsg_otg_desc,
+#endif
+	(struct usb_descriptor_header *)&fsg_intf_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_comp_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_comp_desc,
+	NULL,
+};
+
 /* Maxpacket and other transfer characteristics vary by speed. */
 static struct usb_endpoint_descriptor *
 fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
-		struct usb_endpoint_descriptor *hs)
+		struct usb_endpoint_descriptor *hs,
+		struct usb_endpoint_descriptor *ss)
 {
+	if (g->speed >=3D USB_SPEED_SUPER)
+		return ss;
 	if (gadget_is_dualspeed(g) && g->speed =3D=3D USB_SPEED_HIGH)
 		return hs;
 	return fs;
--=20
2.53.0
