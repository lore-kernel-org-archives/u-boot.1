Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8A4C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 05:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C1A3809BB;
	Mon,  7 Sep 2026 05:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEeIEWKbIlex; Mon,  7 Sep 2026 05:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC313809C2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788758667;
	b=LLB4CCJghe9RceCKJA+2Dm2a/s+XqtBraUJ/JWjJBta9EZiBUshI0/SzFmMjIBfJnfV8
	 3465VJeQShDL94i+KFaQVuvTn8+mgvVfSbXZD11U4+PqJUNjLRNQzd9MGH+d4D60GV2q2
	 FsqmF/lJ34tye7EA5o9AWUqLfMRwcsG0IpiZmDRYRyasnoULpVPHuFOOxLuLI7KAq42gw
	 A/Tp5pvT7XbDCm1qspWy6KtRePTX9FOv5TFaICQkoBsgUPNQ+lyjotmu0GRBC/nZWMSKT
	 PYBjzydP03Q0kcFQj1pn65E4rS5yuxwbfQVD1BtpT5hQqgue0kOXYL9lwT97N9M1orQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788758667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-Mentions:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YLAHsqw/2Ncnv/bqqNnCxZrFLW9gWSu0Ick+WAIYzf8=;
	b=aVEQd7r7+UDjSuy1Vcb0y95OaoqOE38nUmJLpCJckiCDoMuuy8aygNnp0zIHR5zn0GKb
	 uNsBMfArPX1EmAlr+wXn2ssdT3Rz8f8deKF4qcH1vdFaOSTGw5ca0aEQhJrN8YeJ3PLFB
	 jX6tiiSlDonGu6IhtGRRtM5KY/nAP3Oc6DmystW8yIM82gOLUCkik1SDCuv6YzG5oeB0R
	 IgWXBDlAUvfO6sl6nSlekDBGMS1+nWmLu9mNhEYZBVquGKEEvDQ/bMsJL0hFzx4sWaPxf
	 yxboTziI7kP6w6Xs4uNp40UfE4Z4VeZHr3zt4uI8IF6XHrX/ebCKgETFZprDSEy4XdA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788758667;
	bh=YLAHsqw/2Ncnv/bqqNnCxZrFLW9gWSu0Ick+WAIYzf8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E88J+/3B7cVWoPyLPy2u+TLt6OakZm8/XcfhlHLsfYsLTNVz7R/6mIRphNya8CCdV
	 Nvmnot/1IQDtnXBPMrB3V96sV+IgwMTbH2tum2+wAyNDI+DjRri5TRyg37wUE0GVN6
	 BseXDqT7kS5ZrXHg+eAzKtML92GHZMYcbcjYvbv6n19oZeWFq1/3Xp4WNbstlYl81g
	 qxJirk7Zj5LlDBsBqrC3a5DPJeWtJ6wv81cvhCVRz5JxbCBf94tvHBuZxVaKy3ZrDJ
	 ZCn4WdS3yNzhHadduLMJwLYrHzvHNUwNx5CVof7fuaYQc+QVpeNoRSH9gNZCgsafy4
	 79IUzCdSP9TLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC313809C2;
	Mon,  7 Sep 2026 05:24:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B323990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C1D360638
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-0botThWQaB for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 05:24:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9BAC0605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788758663;
 b=Gc9SxXbL/RsVV5o3BJL/Rfy/OoyG6lxJUy95SDCNWgrdb8qHX/bOTreSsoi2Tht2cbX2
 kR6Scuxb5uvdxxWe/cx7exU3T6nTg8AwMPpXiOfC0Daki+i7DPdOXezW6n3EWd0+v3W2P
 7QwG+ruaAJ2O25hpMDMtP8eaZapF7hR954MN8kqXuKjhAqTfK+25FS/ebZcBnCRXtNiO/
 jN8y0KPTdLKQfj+oPXfFA+P2bgKNhRQd14cimXW7q3Tj+zqT1sRCQCCP8nBqAyalkRCFM
 PBQgSgYbwZ9DmIpH/gA0tGzmvTZ6pGu5DVUNHjEGn0ms1Agub6uWJDByFfMZymcDXXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788758663;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-Mentions:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
 x-ld-processed:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=YLAHsqw/2Ncnv/bqqNnCxZrFLW9gWSu0Ick+WAIYzf8=;
 b=Aux+P23alCqdHLTxXPSdXn2PfPnKrt/GJQ2lGiZXeRWjn8s/FvXicM/NQuAZ1neSFdKe
 EelVFatrIqtqxnq5VTjQ7RCHJy0thLf7tlSggMEEFHxjVTirFKQrrl6AKHUoauRq2Cx2A
 M2UBkOOW9iav5E7pKpq2QpedkSJPuXVJS6TFnZybJZx9FkjEn7inw7O8U+NJihx6yNMoa
 MO5pGMbTp8kOLzLwOf1v/Icv8gMyNBxF08Edj+p308Ke8rzcootqcaypWjp/n6yz+3hCK
 rZ8NbF5dqr/rT+v6VODYISoSKwlDOrvLYq8qRfSjLT+seZz/NL7YtIKgKseZANt+8vw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mY1y5YRf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mY1y5YRf
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BAC0605DA
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/iGwL9qHFUIBhzXSLSshBF0bbRUUT1I0rgCjjE33hrb+V3iYC7puCQwpA/8BnveT+6WSmwQkcoSj8t8ndYVrrq0VFiDju5J0hd1U6blI3eZr+Z3dLPRsqSqQdRdmDDIBnYRkIFoUwXaaiQYQOsRYDNLDO+uNqKejlT9ADITj+2KKfLZoniLubgxfugkLSzNvuw5T503qKkI3axRO/1wIAjnbsHptFCIDSI2aGrZlfNyTS7Al5KO/Ts57whUb6XkZwkZJfSVqfpZprhKRwTD34tj6NU+6TKwW81+aDK1FaRuioGHmwYuYh9pu9fhpBBIGlDE4O1PbfPeWJtIuU55/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLAHsqw/2Ncnv/bqqNnCxZrFLW9gWSu0Ick+WAIYzf8=;
 b=psUwhjunV5798ljQrEU80LZdWDsFEKUWVzfDaO3out35Iudl52Nl7HpF0sa8PfuHjS4fve7FLleX4JqNwg84zJL/Yze0Z5OkH2Oea+s4NKvpQxQur2bF7iui7wuPSyaFD15cmtGcggaI5J2RlRYLNzwn4gC/qGNqrBBp/4q4umwh5SUZ8C63RtIQZjeTr1akecMSHdXgF/QYkCpZNAMvR+Di4o61Y0FuE+iRmkPlfO5RzhfdMX5t/woNaNc/NZEgQ6LXaItqG9h1yGIOmMCSC3xhWpKVFl7zrrerWH4A9OHj01utOgVVdKnEVDYK6Fg0eiApeTNp2P4DOVNZ+Q7lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLAHsqw/2Ncnv/bqqNnCxZrFLW9gWSu0Ick+WAIYzf8=;
 b=mY1y5YRfQZUwwfHdkYj8MJMvLZogLG4VQ0hi6n7J1n4bWKLy2KCzcOMUbOZmuXX7ZjdEE0mbnfhF1WJooiObCmd/DNMO3CLZ3u1eYqqVnkmXSKMni+cdAcYyp42S/Ngjf2u9fnn7Z1omIJ1Zcj+l+urfb+9qtO6jANH+nZgKeEY=
Received: from IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 by SAVPR12MB999121.namprd12.prod.outlook.com (2603:10b6:806:4e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 7 Sep
 2026 05:24:02 +0000
Received: from IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03]) by IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:24:01 +0000
From: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
To: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "mark.kettenis@xs4all.nl"
 <mark.kettenis@xs4all.nl>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, Borislav Petkov
 <bp@suse.de>, Michal Marek <mmarek@suse.cz>, "Belsare, Akshay"
 <akshay.belsare@amd.com>, "Kummari, Prasad" <Prasad.Kummari@amd.com>
Subject: Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
Thread-Topic: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
Thread-Index: AQHdNh1Lx+8iAIiuxECzllUaOGQGebax4/GAgAA0ioCAEHF3Kg==
Date: Mon, 7 Sep 2026 05:24:01 +0000
Message-ID: <IA1PR12MB952914F6FB38C8B02761B6C189B22@IA1PR12MB9529.namprd12.prod.outlook.com>
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
 <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
 <CAC_iWj+WXkNAZPyRup4w09jSyr6TbkjLgZRyDxKzCQdFaK8-4Q@mail.gmail.com>
 <20260827163731.GE3959812@bill-the-cat>
In-Reply-To: <20260827163731.GE3959812@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ilias.apalodimas@linaro.org,mark.kettenis@xs4all.nl
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T05:24:01.260Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9529:EE_|SAVPR12MB999121:EE_
x-ms-office365-filtering-correlation-id: 72757af3-a2b1-4e91-6a11-08df0ca03a06
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|8096899003|38070700021|6133799003;
x-microsoft-antispam-message-info: 3voxL1u48PbBNsl2y8TnbBffcBlAn5BgyObe2798Er+Owc0JnmZLpuIQcIPS21XTY8cZwPnWrA4TmhNN2LUIolBKmgGoKx1QTIn5ak33a0K3vd1nWY7MoZR+BweqlMjyknv7Bg5Nh69xmB1dalcGGy5J8VYlBLn+wvOQb6LHV4b5TUwjrjofiaYuuIvcr1yE+1+T2MRHzyQjaRAAF21mzONor9nBHxM9rDAXubD3x+L+y11yOArhx8fwtHrT9HNAFr+HvTWnCoiOi7kPIWAYSxnuDt5hAEZ1jTHLPtOi1nrsxsRpkyjB1EMQZnskQkH0BJ0BV1wq7ydlfwkqMbQlcoBEXux7gM95C1cf3A/0OSTEoJrnFUHLerqS5v29mz99gbRWufzqXmy3VAzQoJaGEKhqNeomiPSN547SWU6cF1nxz02YIJ5frBT1msrItPBd1RsUNGZ1fSoci4p9AqVRso3M1FuMMybEH5ECWicLhCBo0BKYokiS8u+cilIjjlnuw9ORFvLuD4CIaUqgz08vgxU5uNgZeehU85RYJG2Y/OSyPuFWsz0OhVVg82BSngBjCYd2JYgVe6NNdB04rbyMjCHcerzx4ht7NOblr8Guges+yReeWyjLxEPlilFEXNNu34Q1Ei1quaN0jMsdvIDYo0OD/ZDT4lAJTRRNKCL61qPSONX98h4EZh+J9WUpzKRliD7/5cqNEWfDQSRG+WVUixW/mqCm+R62IO2HXbbCnHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(8096899003)(38070700021)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AR8pK54iK6/uGa9jkO3aEAw1hiSsU8uxzxr3TyU0TxN0NIt/rCvW8v5blt?=
 =?iso-8859-1?Q?IPe1L6PzXH4eouQWqZ11DUpiOhsNkMmHnLTde9GsQCJGk1i5lgRV7c5cOx?=
 =?iso-8859-1?Q?psvSniEjDq+5ESDdVLso1KGYWbZqsssL3hitB/c2bmze9XmoYrIwnUlGIv?=
 =?iso-8859-1?Q?Zik9S/WRxsrY5UI1tHx4n3Gsz6HEJAS/O2h9h1vZXQBhE7dzpD3J+ALjzo?=
 =?iso-8859-1?Q?iplcIdQn+7VVKumcohfaGdP5z2kjIcPvINqgWgzJ9Q1rXtro3MCUrIg4QC?=
 =?iso-8859-1?Q?MuO66MHZudzxWJ2za+aDOmGjZEt2wLBCnJ1nEC7ykrpBtEGbdK6yOjHUpd?=
 =?iso-8859-1?Q?ctbKO126nfPDqwQbfkN7GyFsMuGlUBQcUrTFpsCswDvmBh77DAvlLXHeb7?=
 =?iso-8859-1?Q?svJ8r1HcUqKH8XuDL1J6sFFi82W2iFoEestIRzIJunsvhI2hne6t+PH5Kz?=
 =?iso-8859-1?Q?DFKpHOKv3I1g1MbdZg5L7L8Jp0x9uKN5wTZFBjWYS5MFqut01+XqwOAV9Q?=
 =?iso-8859-1?Q?VhJ9sC+rIWRukCYnwC+yHNM1LqVFPUbOeR3LS/T4+zoHFz49YISbkacTFL?=
 =?iso-8859-1?Q?7riAPUFLrYCVkFjcnew3uObw7tNnz2uqYCcgHo+Gh5zcnbKVknwsfLz5kk?=
 =?iso-8859-1?Q?suBiF7H9OCyuPmA0hjVRF7kTXkZ3yRXzCWgUm4jXwGbMeOMR3lR4wvKvdG?=
 =?iso-8859-1?Q?R4YIgCDlZ6LueZ/3yK365H5xpPilWgrykpuATRq9gTi1oubj58f23s2A7n?=
 =?iso-8859-1?Q?uQl1cClNcNY7LQexflf5/O9JWEFq9L4iB2oMvKg0hg9aEblHIjrEjsmH/3?=
 =?iso-8859-1?Q?1pcve/IMkHgYpr8r7IfSEz20pmFZyi03YlilbOQmkCcOcscuGiG3v7FMxl?=
 =?iso-8859-1?Q?cq9NppSzAllQiIk8csrO4CWSNqJPTFGwOrC+XT6EivQ5914ofVmRv8X1mY?=
 =?iso-8859-1?Q?rZDxwStn2Fpgf3HHUsfePXqpnyieVMvRrJKI9CV9YmY4YLDmtvVWBwkzBb?=
 =?iso-8859-1?Q?50wUofPPF21ZZBk+YxR1XP+0ehz5e77bQBc5bX31iJ455wybPutnbTJoaO?=
 =?iso-8859-1?Q?hWlK4TjU2QjQKKiRc7T/DV43reBJI/63Avyo+9Bwh1s1vlm0rM0+p1VO+7?=
 =?iso-8859-1?Q?8LDZno8MtE1vdsV9GKehU3j8S+1Ud3szbzOZMkjVZFTb+J/X7oWXLl1QYt?=
 =?iso-8859-1?Q?bZnbKBxRFs8DhdAccMFv2xZTh4ayBQW9m6kCTkPTY8Q/wOS1dYsvR7aV+F?=
 =?iso-8859-1?Q?MQEXePtfVvD7iz9r12jkjHMD39EoboQnbq0nHgO6b0+AvMkLjijrKkOhwZ?=
 =?iso-8859-1?Q?5wxscgjlxKwd75edOK16lLngGZF7jVx7Qi8Dn+nGlUsU/jkW2wDq5d5j4S?=
 =?iso-8859-1?Q?jXGOYg1wYPg7j7T2JVt2uZJcXaCFqLR1GrxA4oTx+16TRMf79jUdi+adsb?=
 =?iso-8859-1?Q?w3ZMpf9YG+I/ZnStZpZhN8EDTvJfxRzei7QpDQDzUUQoyuBfu9LveWgO1n?=
 =?iso-8859-1?Q?wFJEaskDa2WSM8guzSvGLlkCvi7u9Mbl3CwBXr780oFqsow8lru0isIJIX?=
 =?iso-8859-1?Q?q1ygGJUuSKTzpOgZybsuFJiVImlLR6oBrjdyFrVyxSYppwpQKIOnL4j8AK?=
 =?iso-8859-1?Q?wWyF1EovcpMC5Gu/8CPNd0cjU9nxC5G47CbismXLdZon0C/OCCQzOR08jk?=
 =?iso-8859-1?Q?rWX7QCre1lnwZQZ2zI1r4T0ho7WbxgHWOwBTaK4Lw1RxNtLzsNqV21UwBR?=
 =?iso-8859-1?Q?XAdpJvCbSQ31BeM/3rouc7VSEebBnp+vBBkV4ogZhg7/MZ?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB952914F6FB38C8B02761B6C189B22IA1PR12MB9529namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72757af3-a2b1-4e91-6a11-08df0ca03a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 05:24:01.6995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvPBcr1QZ375AVcv7tkiNWyZkhIIL+sD6K2L+rP18BSFsKLzPVpDlYgC8P95tfT/o4lU8vOCFv4t9Hckv+YYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999121
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

--_000_IA1PR12MB952914F6FB38C8B02761B6C189B22IA1PR12MB9529namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi @Ilias Apalodimas<mailto:ilias.apalodimas@linaro.org>,

I do not have access to a macOS machine, so I cannot check whether the host=
 tools still build with this change. If you have macOS or access to the mac=
OS CI jobs, could you please look at that?

@mark.kettenis@xs4all.nl<mailto:mark.kettenis@xs4all.nl>, would you be able=
 to test this on BSD and let me know if you run into any issues with the GN=
U Make 4.0 requirement?

Thanks,
Suraj Kakade

________________________________
From: Tom Rini
Sent: Thursday, August 27, 2026 10:07 PM
To: Ilias Apalodimas
Cc: Hanumant Kakade, Suraj; u-boot@lists.u-boot-project.org; Simek, Michal;=
 git (AMD-Xilinx); Begari, Padmarao; Simon Glass; Markus Schneider-Pargmann=
 (TI); Borislav Petkov; Michal Marek
Subject: Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code

On Thu, Aug 27, 2026 at 04:29:29PM +0300, Ilias Apalodimas wrote:
> Hi Suraj
>
> On Thu, 27 Aug 2026 at 15:11, Suraj Kakade <suraj.hanumantkakade@amd.com>=
 wrote:
> >
> > RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
> > reached EOM/EOL on June 30, 2024. While you may get extended support,
> > it is a good time to raise the minimum GNU Make version.
> >
> > The new requirement, GNU Make 4.0, was released in October, 2013.
> >
> > Raise the enforced minimum GNU Make version to 4.0 and drop the
> > now-unreachable compatibility code for older versions:
> >
> > - Add an explicit "GNU Make >=3D 4.0 is required" version-check gate.
> > - Simplify the "make -s" (silent mode) detection to a single
> >   unconditional check instead of branching on make-4 vs make-3.8x.
> > - Drop the GNU Make 3.x sub-make workaround, which is now dead code.
>
> Overall I agree on bumnping the minimum requirements to 4.0. In fact,
> I think I did that when I did the Makefile bump to 5.x. However, the
> macOS tools stopped compiling. We need to check the CI for that before
> merging this.
>
> >
> > Fixes: ffe29ebc0701 ("kbuild: sync top Makefile with Linux 3.18-rc1")
> > Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> Why do we need fixes tags?

Yes, the kernel didn't enforce this requirement as the minimum until
around v6.10 or so.

--
Tom

--_000_IA1PR12MB952914F6FB38C8B02761B6C189B22IA1PR12MB9529namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Hi <a href=3D"mailto:ilias.apalodimas@linaro.org" id=3D"OWAAM452375" class=
=3D"tWKOu mention ms-bgc-nlr ms-fcl-b">
@Ilias Apalodimas</a>,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I do not have access to a macOS machine, so I cannot check whether the host=
 tools still build with this change. If you have macOS or access to the mac=
OS CI jobs, could you please look at that?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"mailto:mark.kettenis@xs4all.nl" id=3D"OWAAM843157" class=3D"tWKO=
u mention ms-bgc-nlr ms-fcl-b">@mark.kettenis@xs4all.nl</a>, would you be a=
ble to test this on BSD and let me know if you run into any issues with the=
 GNU Make 4.0 requirement?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,<br>
Suraj Kakade</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Tom Rini<br>
<b>Sent:</b> Thursday, August 27, 2026 10:07 PM<br>
<b>To:</b> Ilias Apalodimas<br>
<b>Cc:</b> Hanumant Kakade, Suraj; u-boot@lists.u-boot-project.org; Simek, =
Michal; git (AMD-Xilinx); Begari, Padmarao; Simon Glass; Markus Schneider-P=
argmann (TI); Borislav Petkov; Michal Marek<br>
<b>Subject:</b> Re: [PATCH 2/2] Makefile: drop GNU Make &lt; 4.0 compatibil=
ity code </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On Thu, Aug 27, 2026 at 04:29:29PM +0300, I=
lias Apalodimas wrote:<br>
&gt; Hi Suraj<br>
&gt;<br>
&gt; On Thu, 27 Aug 2026 at 15:11, Suraj Kakade &lt;suraj.hanumantkakade@am=
d.com&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82=
,<br>
&gt; &gt; reached EOM/EOL on June 30, 2024. While you may get extended supp=
ort,<br>
&gt; &gt; it is a good time to raise the minimum GNU Make version.<br>
&gt; &gt;<br>
&gt; &gt; The new requirement, GNU Make 4.0, was released in October, 2013.=
<br>
&gt; &gt;<br>
&gt; &gt; Raise the enforced minimum GNU Make version to 4.0 and drop the<b=
r>
&gt; &gt; now-unreachable compatibility code for older versions:<br>
&gt; &gt;<br>
&gt; &gt; - Add an explicit &quot;GNU Make &gt;=3D 4.0 is required&quot; ve=
rsion-check gate.<br>
&gt; &gt; - Simplify the &quot;make -s&quot; (silent mode) detection to a s=
ingle<br>
&gt; &gt;&nbsp;&nbsp; unconditional check instead of branching on make-4 vs=
 make-3.8x.<br>
&gt; &gt; - Drop the GNU Make 3.x sub-make workaround, which is now dead co=
de.<br>
&gt;<br>
&gt; Overall I agree on bumnping the minimum requirements to 4.0. In fact,<=
br>
&gt; I think I did that when I did the Makefile bump to 5.x. However, the<b=
r>
&gt; macOS tools stopped compiling. We need to check the CI for that before=
<br>
&gt; merging this.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Fixes: ffe29ebc0701 (&quot;kbuild: sync top Makefile with Linux 3=
.18-rc1&quot;)<br>
&gt; &gt; Fixes: 5f520875bdf0 (&quot;kbuild: Bump the build system to 5.1&q=
uot;)<br>
&gt; &gt; Signed-off-by: Suraj Kakade &lt;suraj.hanumantkakade@amd.com&gt;<=
br>
&gt;<br>
&gt; Why do we need fixes tags?<br>
<br>
Yes, the kernel didn't enforce this requirement as the minimum until<br>
around v6.10 or so.<br>
<br>
--<br>
Tom<br>
</div>
</body>
</html>

--_000_IA1PR12MB952914F6FB38C8B02761B6C189B22IA1PR12MB9529namp_--
