Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JPvPkCc5;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=auEC5+9g;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=sLc5XEj/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 075CA80E0D;
	Wed,  4 Nov 2026 13:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RhDt6oCoI_hZ; Wed,  4 Nov 2026 13:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC24680DA1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793799074;
	b=eMapI5w0/RolQzDd0qIMmHSj2vueDZrc0rioR6J+SSVwP5jJ3/4OM+n88aW7JvCltCpy
	 xE0h00uEpr6g1arCK6/BOZrvY6QpZ45JMFAo+14zxrEUrz7msQatIsHk5CkvXnsyHoilH
	 3zFBmRSmFHOSC8SZ/hTsavjalXcXdr21vFdO1Q+WolkFoJS3XfMC1Ak7TUIGpKkEu91XU
	 Nrx1Ls5ZPwBGfwJ9j6HIk4MARXZiwCIja34HjdPqTy5QqrBiuKjwAKaVo0cT6koeG28/n
	 EFIas0eZS5Tzr8Q4Z4787RM75ecChnaO/DwzTWHR7aEOFmAeVaJbGN8iCtzzCaNLLdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793799074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK0k=;
	b=Ek/Jw5+3cScVr1Urdrkb5vGAa+CFUiZ276SwSVowlMpOTfjas0IRW66PHy3lqgG7vfZu
	 yzbNARaVSRq9DaZfBPFMoVdtC+rGYIfG3NSg5z7TMjBtaVET98PV2jz4XHdW8IDVr0aIJ
	 rCmsWeYWt+cYDw2vyOkIk9qvhy2uCts2D/Vp3zoqctnXUDJRW0Tj5ryD13cs51QaJ6h3Q
	 7Qckg+YaxJIwb00CqMnF9zwQ6O/XUuqxEhjHzfFQ3kuSxdkeLVjR18/z3DFrg3XJa7ROH
	 gI54EElEKq1MsvwcqdxjnFboPe8GJBhJG5GaAZVhEwvg4cLhq7DnE0vkGZTMMoRQXfQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793799074;
	bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK0k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JPvPkCc5dadsP+aWGvF+gUif71SkTJEaCcNer86lf8E2BPqDgXkRDHxNpLnRlHvR2
	 i+z2wu5wzqCNTPlePYJ/3wV7t6rKezu9yemVaAdnJd8OV/hboegIfpejeBabA4Wgyy
	 pDDI9jp8yRd57dU7NpDmeR82TsfXwA/lNmuc9aGcS8kgqYcPq+jQzlkWIzUo6l4pmp
	 zADhYb6/z1JkzGsq6cKyAt1wbaoWxmc6caTne5nEh5aZ9YC9T4T7PZxNf5dLVuZ4vP
	 DCFSQ8ORDkQVj/DQ5QYx4tKjdqBYw3I6VHUc4jCljrBzIFbY/9DVrF6R/XiIyj4A1G
	 Yr45X5wjQw/WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC24680DA1;
	Wed,  4 Nov 2026 13:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF36932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFF42405C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LC_m-KFiivt for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EC56405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793777820;
 b=fnmVulzNpX9nInoXBIgQvzAT/JpAg+G4NH6OV9uaRBJSTgEngZBkIDz74xSsSOr57xDq
 yBDh3YXRaWX0+1/bTNERGhDYw93rmQd+AFbCDhF25g+YokHPqmIxe78Nh0ykFA0NFpaSI
 7lpZcHJCYg54r60YbgtD2BXnyK5AYw1KOuHgyDUVfs/pWvB3Cz6j8Sp5U+oIsxrRjC5wl
 UDMFxeVh88UcHnJFbSM2BSHW64r/H6WopzcjgRF+9S4ybBrQ4hPRlzp9vuILkzw1ZaSrD
 8DbL2elxLfD+trccUCXq1qpvxubKJYwFlbrT2yCffjLyY5gBRPLC7/pd7/YgDhPwSQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793777820;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
 x-ld-processed:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK0k=;
 b=We6G3tVBn0hSbkABLdcXOSsquwK3aeEPyAG2rfYe7zeewrMrNAZ36+Lu2n9htkvLz1mk
 uKtRvFtZuuZ1z5tAp/UjYAWfw4DZATwWcnRIM2uxqpYYrPSsi+O4JyUZn47JfX3RGMI/L
 FeX+qa5itFfDWj4Uh9UWmWUFX3Q6YqJ1mlP2+97esy8n1q/stfkltplNQ83lS29WtSnzB
 i4qHo7eqnkUUcNTe7DmMUTMjFRMZjGr0AtSF9h6/TTGkenxU5aFxwmQUjK+4Wnin5tGJE
 f4gHm48FwzLY3SvVCKQYGLvWsdi+q8Z5+pdjvYnWsEu6xYcr2ZwiQ0HvhYMEtRsQFcA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=auEC5+9g; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="sLc5XEj/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=a-kaur@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=auEC5+9g; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=sLc5XEj/
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EC56405C6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:36:58 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A476XtU1167004; Wed, 4 Nov 2026 01:36:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK
 0k=; b=auEC5+9gmOPwoP8fPVisqobS1gVcVv8UfEMpwTmdHBwl5EFVdpxEusp4+
 BJO873um09LJ2CWZJOuNZjH23x25J5Abd1/A/osFjvRqujxe42ppTQ2mTGwjcfT1
 AAp5o/Lj/a3lwZAeT2JJ4FZLzeJV6fZlvZHl0BlziygNWtcpz8dA5h/jbJX6EsG8
 308alIIMnaCnR/wQdSM0hm3Y0MN+THrTE+0y5STy368HpNupdSivR6Cj1mb+KhoQ
 aiyBlXQOCx9PJvA+57kmC9WD1afi/JChGJPaaC45c54SsdREYwxhgMP15XAjH0Sn
 yTTIBmiqJ+IAFwtBpj9EwI9IZRrCA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqu7ehp6n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 01:36:38 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsAGuOCcggqwHNG+zHsoOJnNZ+XWmpNijQHEuzflFIqCenWEKe2UY/FY9oqImI38Jp9pVMCVHousNJ9YxvHG/0XYtWhMiWoPW/vcNuH7v0IVcxTE2ebD56bpDmDs74xLYhZulNqhCP6VP0+2f/RjJ0ZmesyH0guMM0oXtxO91d437JIhTopFULy3O1C9UqlUwYffj2urc/Eft70O9kdhP3CUJW6XqXg9CLeBJ68cAnPyD/zZrxjCxhFhlSTqNEkFotQ9vQaSqrs+Un/06OEEBabRltcvWjqmiqK2onmQOhQ3oT/4F8PElB5o0mZKOV5BX8oMtVsfxmp7EzZ5Pjb+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK0k=;
 b=nV1MgxgWY09rw86NXSvjBQaQ1zmYxSWvXY4WAi1Gv4udZTrai/k2yiGpIrlCQPLy8xjqruWzjSn7XsKC592ENWkoIJt6NH/zgKSCPnOobDct96v76EAAs1zVyfh6dbd8g+sv/cbbCgyvwjXJWuQA1twuGu99VOjuA923A9990Uvxa6l1HaEwAiP18pdX4V6vQzEX31JcmEDPS82oO2qRJF3NuRIsOBS8+xvonsnaE0xMICxUjX6XJnao48CSG0ZKPWf/2Fs/fPROiNAKW8rMTjB1m/1m5YjulXIlRk3fA8QnUF6m8rZ5svMuZX8fDjln+HG4r3u7a530JJCV3Irs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU1b+5Tth8VPym9C9MSntEucVKokdF6MyDTr+sdCK0k=;
 b=sLc5XEj/8zzuWdXZnRLeCBhPCJXI1nZYpF8L6mLbUJXO269k6qpjj5r9qzmVgkLroplD5X+7ZKUmN1mK7hQFQRRSpiOQ+3soX5ZTxVV4sRvRP/0uREG3c1IAYBS8i2/a+K/1Tg7ZfYL6a91mu5C4Nv+eJJ2a3QjY5lAOXfQ89B8=
Received: from PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6)
 by CH3PR10MB7119.namprd10.prod.outlook.com (2603:10b6:610:122::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 07:36:34 +0000
Received: from PH8PR10MB6600.namprd10.prod.outlook.com
 ([fe80::5df6:ceaa:4393:60d2]) by PH8PR10MB6600.namprd10.prod.outlook.com
 ([fe80::5df6:ceaa:4393:60d2%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 07:36:34 +0000
From: "Kaur, Akashdeep" <a-kaur@ti.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, "Menon, Nishanth"
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>, "Brattlof, Bryan" <bb@ti.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Kevin Hilman <khilman@baylibre.com>, "Francis, Sebin"
 <sebin.francis@ti.com>, "Willis, Kendall" <k-willis@ti.com>, Anshul
 <anshuld@ti.com>, "Shah, Moteen" <m-shah@ti.com>, "K, Santhosh Kumar"
 <s-k6@ti.com>, Nathan Morrisson <nmorrisson@phytec.com>, Garrett Giordano
 <ggiordano@phytec.com>, "Mendez, Judith" <jm@ti.com>, Aparna Patra
 <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Francis, Neha" <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, "Padhi,
 Beleswar" <b-padhi@ti.com>,
 "Chawdhry, Manorit" <m-chawdhry@ti.com>, "Davis, Andrew" <afd@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, "Kumar, Udit" <u-kumar1@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, "Thakkar, Devarsh" <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?utf-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, Julien Panis
 <jpanis@baylibre.com>, Stefano Radaelli <stefano.r@variscite.com>, "Bhagat,
 Paresh" <p-bhagat@ti.com>, "Liu (EP), Bin" <b-liu@ti.com>, Jerome Forissier
 <jerome.forissier@arm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v10 00/24] am62: IO+DDR resume support
Thread-Topic: [PATCH v10 00/24] am62: IO+DDR resume support
Thread-Index: AQHda3njgsBubLqs5kq57w8e/mruJrcdh3gA
Date: Wed, 4 Nov 2026 07:36:33 +0000
Message-ID: <f65980d0-1b13-4c57-a07c-e0f4573a1493@ti.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR10MB6600:EE_|CH3PR10MB7119:EE_
x-ms-office365-filtering-correlation-id: 9da5ec58-dd54-4f99-5843-08df3a4659d5
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|921020|261026140227099003|261021135927099003|38070700021|56012099006|261009223027099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261022113327099003|261021123027099003|10067099003|18002099003|261102123227099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: SP4honjwuFih1u2BhTTrD4jWtUE2xKAmbX5P0Zw0CVHM7pf/NcGwUxWl02WkJdpQ+v7BjBDgOkzIZN4as3xPYZoROkwcFduZ4sdJDmfHgg+jR+vn0Rn2LHw1nyz2CwhWgyTasMc6ppGZA5tEFNVE4VF2uL0THC+ufEKI1vM8bhlDyimX1OLcAjToMHIa8I9zKKcMr1dB8YuwF8WLb8lqaKizpvr3H9qUpQLUtHk06cXMTgF3Z838yalXyUv/JKIPTXp77oX+/2Nn+QAtK6aBX3BCHyhx7CzgrG1aWZNSgFdomgwVqiugDwP4NhUJsJlYnNJvHqtFoxV87yrs+7Idf0BCGi412rUd1siDPPf60yFU09ivTyNbSN3JHENmGf/hnkH5AbY38SIezPRD37F1D2tpSHboNnQ93aOB9/3yzpTDP8xHJyBQpKAIqRgSPXB5SFvlUy9VbKi14CAGmbFXWUv2gUH/T360xqfre4MfrKf3Ffq4Ango4AnT6ShwC7txk/OBw6+V/l8o+MEj653BZNeY386KRR16j83Ycfm2LRxzAfzxDZVzbMyOl+5QlA9RguHygJ4/q2bcmgug68B4mTkTf8fPJsOpy4dqKRJlpmCU4iLwEAyng+b8Pgq2R7SHTMBhgWGXKMEbRvmNNybYFNCCIU8F6flQCXJ2h/WER8NHezgXd2nTXBy4QWgQcML7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6600.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(921020)(261026140227099003)(261021135927099003)(38070700021)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261022113327099003)(261021123027099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVhrYUZMdFBlcDA0STcyRUptSk4wU3B5a0w0aHdPZWZPcUtUem9lQXpqQ3RZ?=
 =?utf-8?B?YXQ5RVRFNGVqSjBVbUpZL1U3UUUwY2xMUlNobDBsM2Q1UEN0RDBXdS9kR2FK?=
 =?utf-8?B?ZUQvNm9GTytHcVBNL0JSenJUT1VUSUdzWVZDbGFOT25FeWVuaGllQWRoNXcx?=
 =?utf-8?B?U3RYcnlMOG9pMjJMSFYwQmpwVmlsTFl5VndMUDhQMks3bmQwb2t0Rm1jWDdI?=
 =?utf-8?B?NDY4VGNwc01MQlBGRDI0QnMwb1pSSG1hMWtSNWhRLzdsSjlCOFlUNnlLK0ov?=
 =?utf-8?B?SC9Gc0xuTXJoOG9IVXR4cTFTZU9YaWlVKy8yUERIb0p5VjR0OGI3eThwTUVs?=
 =?utf-8?B?VWY0b2drYW9VelBqaDNwODVIMy9ZWmFDcUxYSjRBcHY4Yms3MmZCbUdQQ0Fz?=
 =?utf-8?B?MDBCellaOHBWRURHQTYrbjRtZEZzdGZJcEQ5a2NTY1pDRkFPazVmK2ZpcU42?=
 =?utf-8?B?bWUxWkdjaThDZTVONk4zT050ZDg5Rytzd3ozeWdGU2VyL0hxamZyNzZ2WjNX?=
 =?utf-8?B?aTd4N3JaZ3MxT2J4MTRmVFN6NDV1ZXNQNWswVFkrRlJzQUhuK0dtOTFjTHF6?=
 =?utf-8?B?YlFQOGtjbUhRV2xhdUlhTkxJRitXb09sTEFVejZQVitPN0FHZTA0U3lra0Fk?=
 =?utf-8?B?bk4yVXFHajZaN1RxMFJ6dHRPMFNNMXJiTC9UdjZNWWZobzF5dHJ1M2prcTZI?=
 =?utf-8?B?aXhGT1g1eFh5Vmc3TmdyUUpHT2dzWTNOLzdmUGttWStQanV0R0R6cnlqeVo0?=
 =?utf-8?B?Z2pES3NoekxBWWl4enNGVkV5WnAxZlVpcVljSDV6VHErNUZ2SzZlcWk3SFpF?=
 =?utf-8?B?c0dRMjZkZ1JTYng1TFYzOTVremZUWVRqa1NNWlhVSDZ2OUp3eUxVak11a2ti?=
 =?utf-8?B?ZkNMRVZveE1ZMWk1ZjJNeGVseWlJQWlhSTJDSTV4VC9KS3NoMDN2MjZTODdn?=
 =?utf-8?B?RHJsSFRyK0xoZUR4UjJwemtMRmNtY1d5V1E1VDJYQ0Y5UmgzYVl1eDB1ajNu?=
 =?utf-8?B?TlFHN0FMM2F1QkRtTkZRWjdwWFg2aklQanRIbU1pU1dxS1ExbXcxQ1VZZEIv?=
 =?utf-8?B?L2I3aFlmaVltR1I1R3ZtcjZ3T1ZUZGlpMG8xd1dyQUJKbmd1NGpDbEFzZDlr?=
 =?utf-8?B?d0l3SFJ5MC9EN0p3UFJEaUIwaGVLQkZVWCtzODZUeWxxcExBbVF2VmhoRms0?=
 =?utf-8?B?YkM5Y0xXc1FnZDIxeUhYN2ErSUV5cUthZDJDcjVCdkpUbVJReTVJZlhWc0lD?=
 =?utf-8?B?Qy80b1RYcVFhQTltcHFad3dqcmQ2ZEg1Sy9idXo2Z2wvSzlzOFRKZzdRZ0JK?=
 =?utf-8?B?MjljV2YvSzN2cjlJSWl0MGJLZFoxQmJUZ1lPZkFTTk5VdW1Ydm5hLzNRQytu?=
 =?utf-8?B?WTRhaDQ1SUxCN2ZNWGZHNWVZQ2k2QnV4OW1uZVZtWWpINDF6eVl6YVJPOGRv?=
 =?utf-8?B?MmxNSGs0VlFvYmN1VkIwWndMRExTcWdXMHdBZDBMRG43ZXZKd3NZNjFPRG52?=
 =?utf-8?B?MysyMWIvSndWZC8xNDUxS3pkZ1BUQm5BZTdCWGEyN0JVK2REYnNaMlIzcE0v?=
 =?utf-8?B?TUtrbnVYcFdRaW1pSlVtT2lxOWVWbzh3a0YwODF0MVllaE1UYWhpdnZPUWQ0?=
 =?utf-8?B?ekpWZFZDOXhIeHR2Y3BkdUJ1NEQ0a3o2OTBiREhFaWdDbm1sUzROWGxIM2Fo?=
 =?utf-8?B?S21iNWVaaXYzN3FNMGEzK0d4YnlKeXR6Uzh0MENXKzlNWFh6dENnUTRlSnRp?=
 =?utf-8?B?WXMvMVZablNBQUJQd1Q2ZmRGek51SndYOWZFb3lGemNOK1VLdmoyMHEvcHIv?=
 =?utf-8?B?UktxTnF2MGhVcUIvc0hnVlJGSmRNNnZXZ0prTFNwRjNObWxOandzOTVXcjRa?=
 =?utf-8?B?ODB4NnM4eEk5VnAyOXA1TnM5a0EwSnh3YllQREFuWE1zRG1iU3B0WFY2Wkhq?=
 =?utf-8?B?akV1blF3WWNQZi9YVkhxZXVzUVQ3ZFppZitwSk85bFphWUk4cTh3d1lGdmZ3?=
 =?utf-8?B?U0RsZ3ZydXF4QkxXUnMwanRnU240c0piK0dLT0k4clowQ3c1SjEzWHJmV1Bl?=
 =?utf-8?B?bnVEUUJkK2hkVEtPT25TOXFxeUZWNGxzOXUzcTc2eUFVcEYwNEkrbnI1S3dO?=
 =?utf-8?B?aEhkdEU5QUFIYS93UlQxaHlHZU9qL2xGMnhveld5Y3NRc01ySTZXTlNYa09X?=
 =?utf-8?B?ZjlaS0FySXR3c0ljaTJhT2M0R3h5bXg1L21ndW5iQmFVS2tXdEQ5d1JUTHBY?=
 =?utf-8?Q?gq5FFNnzWYrAerctdY15dxJQF4UZxIi10v4+WznMAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463A0604BDBA2E4B9F8063C57D6E5752@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rBg5cu3izAh2RSs0INJ5wbor5zxnOJ0XQAil/V1QwI0p0bQxlOZycm7mmwSFPzDe3WbQCEHOVYTdg2ZK1+RWwJC6xCFRL/7W7tW/IbihyjSlz7Zzd5wKues9E5jNChy4LuYBWuTUMLIeOLoUsaJ0EYvjf2vlpV+xqy+g0UGLtESZsPkcZP3V6m0XAHLhYEV1XTFMzd9XI5mBxvrf+rCImkNkJDJh+kGnV1TUqCgRfjcw4CtPCPVONxB6dp2gprohQ31UqSGf5+32OZkXg0UDrI6brT0n4cdBoy0KaNWoChzdzt8WfAAqe6Rh9lfUYAAW0XQeY9ZQ7jw4XLmXQlpXGg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6600.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da5ec58-dd54-4f99-5843-08df3a4659d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 07:36:33.8953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThLDol1Fp+4KOmgCPbxeYyWo9T5KoCSWo+ibQR5gJNK/Yl8jdHUjg9EsRHzRdMgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7119
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyOSBTYWx0ZWRfX3VTzQ8YtH5bJ
 /xFFmZ35PZ/uKZf5a+XX8TdHJ/QeMPa9H/esem9IS0eDAA57QaXwzvAl1rAHtUy/5/I7mdlwxzi
 uELDYQ9Za04nssIyWu/cFbv8+0YQ1Y0=
X-Authority-Analysis: v=2.4 cv=fPusTpae c=1 sm=1 tr=0 ts=6aeae086 cx=c_pps
 a=SqiBG769zjf53VTvhFyIdA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=IpJZQVW2AAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=cMDUSdu-AAAA:8 a=KKAkSRfTAAAA:8 a=BCujI86rIShfq8TPR9IA:9
 a=rkxTcYasjZZqAkD3:21 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22 a=QRaI_VI5Kbc4sAalow4w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t0M_7nPStkHHoDdqRIrKH9VLBAMXafbd
X-Proofpoint-ORIG-GUID: t0M_7nPStkHHoDdqRIrKH9VLBAMXafbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyOSBTYWx0ZWRfXxin6LbR/KMzm
 wKPdC3HR/y/8nRYmNUZV7RNRxyb5nrf6FWWE4QmPsHGIc56uax7AUI8knvrCJCr1fn5wn5BZbBo
 7RFjucY2vCqoHA39nT8YivEFAd5txv3xBZvKuwXsYsTA5XJfKRlekdn+W79AtsirbUqMRuW2ztx
 4puWe9wMtyLlDbfLmqTKLmpytMsm6Ztrapj4vwWIgnWREBv4UfuhQK2gTaQEvOjB44HfiHVS1od
 oFBTB0MU7wSNgqYsETsT75EwIAV9zdlmt8Fy6VlupkrXk/u+v4KBl73TWdoxCO49qy3nDkslge8
 zBiZiZBbsZ6R9dQW3VCIgWX0/CtoLfZJ9Lce9toG4cqhSm6C9qB02eGDhLXhdlsxE/JPWyDXRuj
 dKkFoRS8Zv2z+fbNCuLZQlw9DnLEUOYGzohzoWIIQEdkCUwNkTIpvmpEhGqi5Ir5l+5HZF0M9vi
 PfPdeSR4VNQMewcdcUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040029
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:31:11 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTEvMy8yMDI2IDM6MjUgUE0sIE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gKFRJKSB3cm90
ZToNCj4gSGksDQo+DQo+IHRoaXMgc2VyaWVzIGludHJvZHVjZXMgc3VwcG9ydCB0byByZXN1bWUg
ZnJvbSBJTytERFIuIElPK0REUiBpcyBhIGxvdw0KPiBwb3dlciBtb2RlIG9mIGFtNjJhIGFuZCBh
bTYycCBpbiB3aGljaCBuZWFybHkgZXZlcnl0aGluZyBpcyBwb3dlcmVkIG9mZg0KPiBleGNlcHQg
RERSIHdoaWNoIGlzIGluIHNlbGYtcmVmcmVzaCBhbmQgYSBmZXcgcGlucyB3aGljaCBkZXRlY3QN
Cj4gYWN0aXZpdHkgYW5kIGNhbiB3YWtldXAgdGhlIHN5c3RlbSBhZ2Fpbi4NCj4NCj4gT24gcmVz
dW1lIHVib290IFNQTCBpcyBsb2FkZWQgYW5kIGNoZWNrcyBpZiB0aGlzIGlzIGEgSU8rRERSIHJl
c3VtZS4gSWYNCj4gaXQgaXMsIHRoZSBERFIgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgaW4gazMt
ZGRyc3MgZGlmZmVycyBzbGlnaHRseSBhcw0KPiBpdCBoYXMgdG8gZ2V0IHRoZSBERFIgb3V0IG9m
IHRoZSBzZWxmLXJlZnJlc2guDQo+DQo+IEFmdGVyd2FyZCBhIHNwZWNpZmljIGFkZHJlc3MgZGV0
ZXJtaW5lZCBmcm9tIERUIGlzIHVzZWQgdG8gZ2V0IHRoZQ0KPiBtZXRhZGF0YSB0aGF0IHN0b3Jl
cyByZWxldmFudCBjb250ZXh0IGFkZHJlc3Nlcy4gVGhlIGNvbnRleHQgaXMgcmVzdG9yZWQNCj4g
dXNpbmcgdGhlIHRpc2NpIG1lc3NhZ2UgVElfU0NJX01TR19NSU5fQ09OVEVYVF9SRVNUT1JFLiBB
dCB0aGUgZW5kIGFsbA0KPiBmdXJ0aGVyIGluaXRpYWxpemF0aW9ucyBhcmUgc2tpcHBlZCBhbmQg
dWJvb3QgU1BMIGRpcmVjdGx5IGp1bXBzIGludG8NCj4gdGhlIERNIHJlc3VtZSBhZGRyZXNzIHdo
aWNoIHRha2VzIGNhcmUgb2YgdGhlIHJlc3QuDQo+DQo+IFRoaXMgd2FzIHRlc3RlZCBvbiBhbTYy
cC4NCj4NCj4gQmVzdCwNCj4gTWFya3VzDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBTY2hu
ZWlkZXItUGFyZ21hbm4gKFRJKSA8bXNwQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjEwOg0KPiAtIFJlYmFzZSB0byB2MjAyNy4wMS1yYzENCj4gLSBEcm9wIHRoZSB0d28gRFQg
cGF0Y2hlcyBhZGRpbmcgYm9vdHBoLXByZS1yYW0gZmxhZ3MuIFRoZXNlIGFyZSBub3cNCj4gICAg
cGFydCBvZiB1cHN0cmVhbSBEVC4gQWxzbyBwaWNrIG1lbW9yeSByZWdpb24gc2l6ZSBmaXhlcyBm
cm9tIHRoZSBzYW1lDQo+ICAgIG1lcmdlZCBzZXJpZXMuDQo+IC0gQ2hlcnJ5IHBpY2tlZCB1cHN0
cmVhbSBEVCBwYXRjaGVzIGZvciBzcGxpdHRpbmcgdGhlIG1lbW9yeSByZWdpb25zIHRvDQo+ICAg
IGJlIGFibGUgdG8gcmVmZXJlbmNlIHRoZSByZWxldmFudCBzZWN0aW9uIGRpcmVjdGx5DQo+IC0g
VXNlICJscG0tbWV0YWRhdGEiIG1lbW9yeSByZWdpb24gbmFtZSB0byBsb29rdXAgdGhlIGNvcnJl
Y3QgbWVtb3J5DQo+ICAgIHJlZ2lvbiBpbnN0ZWFkIG9mIGEgaGFyZGNvZGVkIG1lbW9yeSBvZmZz
ZXQgYW5kIGluZGV4DQo+IC0gRG8gbm90IHJlYWQgdGhlIGFkZHJlc3MgaW4gdS1ib290IGNvZGUs
IGJ1dCBwYXNzIGEgcG9pbnRlciB0byB0aGUNCj4gICAgYWRkcmVzcyB0byB0aGUgdGlmcyByZXN0
b3JlDQo+IC0gQWRkZWQgYWxsIHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzOg0KPiAgICAgIElPK0RE
UiBsb3cgcG93ZXIgbW9kZSBidWdmaXhlcyBmb3IgQU02MlAgYW5kIEFNNjJBDQo+ICAgICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwMzEwMTAwNjE0Ljk1MTU3My0xLWEta2F1ckB0
aS5jb20vDQo+IC0gTGluayB0byB2OTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDEw
NS10b3BpYy1hbTYyLWlvZGRyLXYyMDI1LTA0LXJjMS12OS0wLTdlMzNmMmM3N2RiZkBiYXlsaWJy
ZS5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2OToNCj4gLSBTd2FwIHNldHVwX3FvcygpIGFuZCBzcGxf
ZW5hYmxlX2NhY2hlKCkgaW4gYW02MnA1X2luaXQuYyBhbmQNCj4gICAgYW02MmE3X2luaXQuYy4g
c2V0dXBfcW9zKCkgaXMgc3RpbGwgcmVxdWlyZWQgZm9yIGxwbSByZXN1bWUgYnV0DQo+ICAgIHNw
bF9lbmFibGVfY2FjaGUoKSBpcyBub3QuIFRoZXJlIHNob3VsZCBiZSBubyBkZXBlbmRlbmN5IGJl
dHdlZW4gdGhlDQo+ICAgIHR3by4NCj4gLSBMaW5rIHRvIHY4OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUxMjIyLXRvcGljLWFtNjItaW9kZHItdjIwMjUtMDQtcmMxLXY4LTAtZTcwZmVk
MTZiMTY2QGJheWxpYnJlLmNvbQ0KPg0KPiBDaGFuZ2VzIGluIHY4Og0KPiAtIENyZWF0ZSBhbmQg
dXNlIGFtNjJ4eC1scG0tY29tbW9uIGZvciBhbTYyeHggbHBtIGNvbW1vbiBmdW5jdGlvbnMNCj4g
LSBDcmVhdGUgcGxhdGZvcm0gZGVwZW5kZW50IGZ1bmN0aW9ucyBpbiBrMy1kZHJzcyBpbiBrM19k
ZHJzc19kYXRhDQo+IC0gQWxpZ24gYW02MmEgYW5kIGFtNjJwIGluaXRpYWxpemF0aW9uIHJlZ2Fy
ZGluZyBjYWNoZXMgYW5kIFFvUw0KPiAtIExpbmsgdG8gdjc6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNTEyMTAtdG9waWMtYW02Mi1pb2Rkci12MjAyNS0wNC1yYzEtdjctMC1mMTEzYjE1
NmY4M2ZAYmF5bGlicmUuY29tDQo+DQo+IENoYW5nZXMgaW4gdjc6DQo+IC0gUmVtb3ZlZCBwYXJl
bnQgbm9kZXMgYm9vdHBoLXByZS1yYW0gcHJvcGVydGllcyBhcyBub3QgbmVjZXNzYXJ5DQo+ICAg
IGFueW1vcmUuDQo+IC0gQWRkZWQgbWlzc2luZyBuZXcgbGluZSBpbg0KPiAgICAgIGFybTogbWFj
aC1rMzogY29tbW9uOiBIZWxwZXIgZm9yIExQTSBtZXRhIGRhdGEgYWRkcmVzcyBmcm9tIERUDQo+
IC0gU3BsaXQgb2ZmIExQTSBzcGVjaWZpYyBkZHIgY29kZSBpbnRvIGl0cyBvd24gZmlsZSBrMy1k
ZHJzcy1scG0NCj4gLSBSZW5hbWUgbHBtX29wcy0+cmVzdG9yZV9jb250ZXh0IHRvIGxwbV9vcHMt
Pm1pbl9jb250ZXh0X3Jlc3RvcmUNCj4gLSBQdWxsZWQgcGF0Y2ggdG8gYWRkIHdha2V1cCBjaGVj
ayBoZWxwZXJzIGJlZm9yZSB0aGUgSU8gaXNvbGF0aW9uDQo+ICAgIHJlbW92YWwgdG8gcmVtb3Zl
IGxhdGVyIGNsZWFudXAgb2YNCj4gICAgd2t1cF9jdHJsX3JlbW92ZV9jYW5faW9faXNvbGF0aW9u
X2lmX3NldCgpDQo+IC0gU29tZSByZXZpZXdlZC1ieXMgYW5kIHRlc3RlZC1ieXMgcmVtb3ZlZCBk
dWUgdG8gY2hhbmdlcyBpbiB0aGUNCj4gICAgcGF0Y2hlcw0KPiAtIExpbmsgdG8gdjY6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTExMjAtdG9waWMtYW02Mi1pb2Rkci12MjAyNS0wNC1y
YzEtdjYtMC02ZGQ5OWE3MjcxYmJAYmF5bGlicmUuY29tDQo+DQo+IENoYW5nZXMgaW4gdjY6DQo+
IC0gQWRkIGNvbW1lbnQgZm9yIGxhc3QgcGFydCBvZiByZW1vdmluZyBjYW4gaW8gaXNvbGF0aW9u
DQo+IC0gT25seSBtZW50aW9uIGEgc2luZ2xlIGtjb25maWcgc3ltYm9sIGluIHRoZSBjb21taXQg
bWVzc2FnZQ0KPiAtIEFkZCBkZWZpbmVzIGZvciB0aW1lb3V0cyBpbiBrMy1kZHJzcw0KPiAtIExp
bmsgdG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTExMTAtdG9waWMtYW02Mi1p
b2Rkci12MjAyNS0wNC1yYzEtdjUtMC05ODBlZTAwMzZjMjZAYmF5bGlicmUuY29tDQo+DQo+IENo
YW5nZXMgaW4gdjU6DQo+IC0gRml4ZWQgY29tcGlsZSB3YXJuaW5ncw0KPiAtIExpbmsgdG8gdjQ6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMzAtdG9waWMtYW02Mi1pb2Rkci12MjAy
NS0wNC1yYzEtdjQtMC00Y2VmMThhZjAyMjZAYmF5bGlicmUuY29tDQo+DQo+IENoYW5nZXMgaW4g
djQ6DQo+IC0gQ29weSBscG1fbWV0YV9kYXRhIGludG8gdGhlIHN0YWNrIHRvIGJlIGFibGUgdG8g
ZGVidWcgdW5zdGFibGUgbWVtb3J5DQo+ICAgIGlzc3Vlcw0KPiAtIEFkZCBtaXNzaW5nIGNvbW1l
bnRzIGFib3V0IGN0eF9sbyBhbmQgY3R4X2hpDQo+IC0gVXNlIGFic29sdXRlIGFkZHJlc3NlcyBm
b3IgazMtZGRyc3MgQ0FOVUFSVF9XQUtFX1NUQVQxIGFuZA0KPiAgICBDQU5VQVJUX1dBS0VfT0ZG
X01PREVfU1RBVCB0byBhdm9pZCB1c2luZyBhZGRyZXNzZXMgb3V0c2lkZSBvZiB0aGUNCj4gICAg
cmFuZ2UgZ2l2ZW4gaW4gdGhlIGRldmljZXRyZWUNCj4gLSBSZW1vdmUgdGhlIGNoZXJyeSBwaWNr
ZWQgZGV2aWNldHJlZSBwYXRjaGVzIGFzIHRoZXkgYXJlIGFscmVhZHkNCj4gICAgaW5jbHVkZWQg
bm93DQo+IC0gSW4gbHBtX3Jlc3VtZV9mcm9tX2RkcigpIHByaW50IHVwcGVyIGFuZCBsb3dlciAz
MmJpdCBvZiB0aGUgbWV0YSBkYXRhDQo+ICAgIHZhbHVlcyBzZXBhcmF0ZWx5Lg0KPiAtIExpbmsg
dG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA2MjMtdG9waWMtYW02Mi1pb2Rk
ci12MjAyNS0wNC1yYzEtdjMtMC1hNGRhMzIyYzE2YWZAYmF5bGlicmUuY29tDQo+DQo+IENoYW5n
ZXMgaW4gdjM6DQo+IC0gVXNlIHdhaXRfZm9yX2JpdCBoZWxwZXJzIGluIGszLWRkcnNzIHdoZXJl
IHBvc3NpYmxlIGFuZCBhZGQgcGFuaWMNCj4gICAgbWVzc2FnZXMgZm9yIGVhc2llciBkZWJ1Z2dp
bmcNCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNjEzLXRv
cGljLWFtNjItaW9kZHItdjIwMjUtMDQtcmMxLXYyLTAtM2QyMzNhYWVhMzU1QGJheWxpYnJlLmNv
bQ0KPg0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlbW92ZSAnZGVmYXVsdCBuJyBmcm9tIEszX0lP
RERSDQo+IC0gUGljayBkZXZpY2V0cmVlIHBhdGNoZXMgZnJvbSB1cHN0cmVhbSBpbnN0ZWFkIG9m
IG1haWxpbmdsaXN0DQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI1MDMxMS10b3BpYy1hbTYyLWlvZGRyLXYyMDI1LTA0LXJjMS12MS0wLTY2NmRlOWMxMDVjYkBi
YXlsaWJyZS5jb20NCj4NCj4gVG86IHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmcNCj4g
Q2M6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAa2VybmVsLm9yZz4NCj4gQ2M6IFRvbSBSaW5pIDx0
cmluaUBrb25zdWxrby5jb20+DQo+IENjOiAiTWFya3VzIFNjaG5laWRlci1QYXJnbWFubiAoVEkp
IiA8bXNwQGJheWxpYnJlLmNvbT4NCj4gQ2M6IE5pc2hhbnRoIE1lbm9uIDxubUB0aS5jb20+DQo+
IENjOiBTdGVmYW5vIFJhZGFlbGxpIDxzdGVmYW5vLnJAdmFyaXNjaXRlLmNvbT4NCj4gQ2M6IEls
aWFzIEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4NCj4gQ2M6IFBhcmVz
aCBCaGFnYXQgPHAtYmhhZ2F0QHRpLmNvbT4NCj4gQ2M6IEFrYXNoZGVlcCBLYXVyIDxhLWthdXJA
dGkuY29tPg0KPiBDYzogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiBD
YzogQnJ5YW4gQnJhdHRsb2YgPGJiQHRpLmNvbT4NCj4gQ2M6IEJpbiBMaXUgPGItbGl1QHRpLmNv
bT4NCj4gQ2M6IEtlbmRhbGwgV2lsbGlzIDxrLXdpbGxpc0B0aS5jb20+DQo+IENjOiBVZGl0IEt1
bWFyIDx1LWt1bWFyMUB0aS5jb20+DQo+IENjOiBOZWhhIE1hbGNvbSBGcmFuY2lzIDxuLWZyYW5j
aXNAdGkuY29tPg0KPg0KPiAtLS0NCj4gQWthc2hkZWVwIEthdXIgKDQpOg0KPiAgICAgICAgcmFt
OiBrMy1kZHJzczogQWRkIHdvcmthcm91bmQgc2VxdWVuY2UgZm9yIGVycmF0YSBpMjQ4Nw0KPiAg
ICAgICAgYXJtOiBtYWNoLWszOiBhbTYyeHgtbHBtOiBBZGQgMzJrSHogTEZPU0MgZW5hYmxlIGZ1
bmN0aW9uIGRlY2xhcmF0aW9uDQo+ICAgICAgICBhcm06IG1hY2gtazM6IGFtNjJweDogRW5hYmxl
IDMya0h6IExGT1NDIGR1cmluZyBMUE0gcmVzdW1lDQo+ICAgICAgICBhcm06IG1hY2gtazM6IGFt
NjJheDogRW5hYmxlIDMya0h6IExGT1NDIGR1cmluZyBMUE0gcmVzdW1lDQo+DQo+IE1hcmt1cyBT
Y2huZWlkZXItUGFyZ21hbm4gKFRJKSAoMjApOg0KPiAgICAgICAgYXJtNjQ6IGR0czogdGk6IGsz
LWFtNjJhLXBoeWNvcmUtc29tOiBGaXggd2t1cCBSNUYgbWVtb3J5IHJlZ2lvbiBzaXplDQo+ICAg
ICAgICBhcm02NDogZHRzOiB0aTogazMtYW02MmQyLWV2bTogRml4IHdrdXAgUjVGIG1lbW9yeSBy
ZWdpb24gc2l6ZQ0KPiAgICAgICAgYXJtNjQ6IGR0czogdGk6IGszLWFtNjJhNy1zazogRml4IHdr
dXAgUjVGIG1lbW9yeSByZWdpb24gc2l6ZQ0KPiAgICAgICAgYXJtNjQ6IGR0czogdGk6IGszLWFt
NjJwLXZlcmRpbjogRml4IHdrdXAgUjVGIG1lbW9yeSByZWdpb24gc2l6ZQ0KPiAgICAgICAgYXJt
NjQ6IGR0czogdGk6IGszLWFtNjJwNS1zazogRml4IHdrdXAgUjVGIG1lbW9yeSByZWdpb24gc2l6
ZQ0KPiAgICAgICAgYXJtNjQ6IGR0czogdGk6IHZhci1zb20tYW02MnA6IEZpeCB3a3VwIFI1RiBt
ZW1vcnkgcmVnaW9uIHNpemUNCj4gICAgICAgIGFybTY0OiBkdHM6IHRpOiBrMy1hbTYyYTogU3Bs
aXQgcjVmIG1lbW9yeSByZWdpb24NCj4gICAgICAgIGFybTY0OiBkdHM6IHRpOiBrMy1hbTYycDog
U3BsaXQgcjVmIG1lbW9yeSByZWdpb24NCj4gICAgICAgIGFybTY0OiBkdHM6IHRpOiBrMy1hbTYy
KjogQWRkIHdrdXAgUjVGIG5vZGVzIHRvIHByZS1yYW0gYm9vdHBoYXNlDQo+ICAgICAgICBhcm06
IG1hY2gtazM6IEtjb25maWc6IEFkZCBzeW1ib2wgZm9yIElPK0REUiBMb3cgUG93ZXIgTW9kZQ0K
PiAgICAgICAgYXJtOiBtYWNoLWszOiBhbTYyeHgtbHBtLWNvbW1vbjogQWRkIENBTlVBUlQgd2Fr
ZXVwIGNoZWNrIGhlbHBlcnMNCj4gICAgICAgIGFybTogbWFjaC1rMzogUmVtb3ZlIENBTlVBUlQg
SU8gaXNvbGF0aW9uDQo+ICAgICAgICByYW06IGszLWRkcnNzOiBBZGQgc3VwcG9ydCBmb3IgRERS
IGluIHNlbGYtcmVmcmVzaA0KPiAgICAgICAgZmlybXdhcmU6IHRpX3NjaTogQWRkIFRJX1NDSV9N
U0dfTUlOX0NPTlRFWFRfUkVTVE9SRQ0KPiAgICAgICAgYXJtOiBtYWNoLWszOiBhbTYyeHgtbHBt
LWNvbW1vbjogQWRkIGxwbV9yZXN1bWVfZnJvbV9kZHINCj4gICAgICAgIGFybTogbWFjaC1rMzog
YW02Mnh4LWxwbS1jb21tb246IEhlbHBlciBmb3IgTFBNIG1ldGEgZGF0YSBhZGRyZXNzIGZyb20g
RFQNCj4gICAgICAgIGFybTogbWFjaC1rMzogYW02MmE3X2luaXQ6IFJlc3VtZSBvbiBMUE0gZXhp
dA0KPiAgICAgICAgYXJtOiBtYWNoLWszOiBhbTYycDVfaW5pdDogUmVzdW1lIG9uIExQTSBleGl0
DQo+ICAgICAgICBjb25maWdzOiBhbTYyYXhfZXZtX3I1OiBFbmFibGUgSU9ERFIgcmVzdW1lIHN1
cHBvcnQNCj4gICAgICAgIGNvbmZpZ3M6IGFtNjJwX2V2bV9yNV9kZWZjb25maWc6IEVuYWJsZSBJ
T0REUiByZXN1bWUgc3VwcG9ydA0KPg0KPiAgIGFyY2gvYXJtL21hY2gtazMvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gICBhcmNoL2FybS9tYWNoLWszL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAgYXJjaC9hcm0vbWFjaC1r
My9hbTYyYXgvYW02MmE3X2luaXQuYyAgICAgICAgICAgICAgfCAgMjQgKy0NCj4gICBhcmNoL2Fy
bS9tYWNoLWszL2FtNjJweC9hbTYycDVfaW5pdC5jICAgICAgICAgICAgICB8ICAyMCArLQ0KPiAg
IGFyY2gvYXJtL21hY2gtazMvYW02MngvYW02MjVfaW5pdC5jICAgICAgICAgICAgICAgIHwgICA1
ICsNCj4gICBhcmNoL2FybS9tYWNoLWszL2FtNjJ4eC1scG0tY29tbW9uLmMgICAgICAgICAgICAg
ICB8IDI0MCArKysrKysrKysrKysrKysrKysrDQo+ICAgYXJjaC9hcm0vbWFjaC1rMy9hbTYyeHgt
bHBtLWNvbW1vbi5oICAgICAgICAgICAgICAgfCAgMjAgKysNCj4gICBjb25maWdzL2FtNjJheF9l
dm1fcjVfZGVmY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgY29uZmlncy9h
bTYycHhfZXZtX3I1X2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRy
aXZlcnMvZmlybXdhcmUvdGlfc2NpLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM4ICsr
Kw0KPiAgIGRyaXZlcnMvZmlybXdhcmUvdGlfc2NpLmggICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDE2ICsrDQo+ICAgZHJpdmVycy9yYW0vazMtZGRyc3MvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvcmFtL2szLWRkcnNzL2szLWRkcnNzLWxwbS5j
ICAgICAgICAgICAgICAgIHwgMjYxICsrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMv
cmFtL2szLWRkcnNzL2szLWRkcnNzLWxwbS5oICAgICAgICAgICAgICAgIHwgIDIxICsrDQo+ICAg
ZHJpdmVycy9yYW0vazMtZGRyc3MvazMtZGRyc3MuYyAgICAgICAgICAgICAgICAgICAgfCAgMzEg
KystDQo+ICAgLi4uL3NyYy9hcm02NC90aS9rMy1hbTYyYS1waHljb3JlLXNvbS5kdHNpICAgICAg
ICAgfCAgMjkgKystDQo+ICAgLi4uL3NyYy9hcm02NC90aS9rMy1hbTYyYS10aS1pcGMtZmlybXdh
cmUuZHRzaSAgICAgfCAgMTEgKy0NCj4gICBkdHMvdXBzdHJlYW0vc3JjL2FybTY0L3RpL2szLWFt
NjJhNy1zay5kdHMgICAgICAgICB8ICAyOSArKy0NCj4gICBkdHMvdXBzdHJlYW0vc3JjL2FybTY0
L3RpL2szLWFtNjJkMi1ldm0uZHRzICAgICAgICB8ICAzMiArKy0NCj4gICAuLi4vc3JjL2FybTY0
L3RpL2szLWFtNjJwLXRpLWlwYy1maXJtd2FyZS5kdHNpICAgICB8ICAxMSArLQ0KPiAgIGR0cy91
cHN0cmVhbS9zcmMvYXJtNjQvdGkvazMtYW02MnAtdmVyZGluLmR0c2kgICAgIHwgIDI5ICsrLQ0K
PiAgIGR0cy91cHN0cmVhbS9zcmMvYXJtNjQvdGkvazMtYW02MnA1LXNrLmR0cyAgICAgICAgIHwg
IDI5ICsrLQ0KPiAgIGR0cy91cHN0cmVhbS9zcmMvYXJtNjQvdGkvazMtYW02MnA1LXZhci1zb20u
ZHRzaSAgIHwgIDI5ICsrLQ0KPiAgIGluY2x1ZGUvbGludXgvc29jL3RpL3RpX3NjaV9wcm90b2Nv
bC5oICAgICAgICAgICAgIHwgICA5ICsNCj4gICAyNCBmaWxlcyBjaGFuZ2VkLCA4NzQgaW5zZXJ0
aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZGZjZmM0Yzlm
NzhkMTc0M2Y0OTBhNDk3MDgyYTRlYzhlMDU4YWFlOA0KPiBjaGFuZ2UtaWQ6IDIwMjUwMzA2LXRv
cGljLWFtNjItaW9kZHItdjIwMjUtMDQtcmMxLTBiM2EwZmZlOTJiMQ0KPg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IC0tDQo+IE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gKFRJKSA8bXNwQGJheWxpYnJl
LmNvbT4NCg0KVGVzdGVkLWJ5OiBBa2FzaGRlZXAgS2F1ciA8YS1rYXVyQHRpLmNvbT4NCg0KDQpS
ZWdhcmRzLA0KDQpBa2FzaGRlZXAgS2F1cg0KDQo=
