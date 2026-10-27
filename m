Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13404606BA69
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G4HNXyOT;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b4WBp3tM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D91E5607B2;
	Tue, 27 Oct 2026 14:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwJPtagGafNq; Tue, 27 Oct 2026 14:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D65EC60793
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793112144;
	b=N36nZK7G+yKFzbAb2qUihrEvHSekD6ungDgbf/lkLk+bkLTLlQrNV5cQYfRJsCYTcacg
	 Kgou72Y+/3CI0h7WlsjUvcKK0ngtHRph6pi8IFvYiBXMIjEXXBaNOZKiRbnbeiJ7xUDXB
	 ljgyTRHyak6BBWQgIwEetugYWqaih8l4vx4VIFA0HQgbre7AHXArJPbjtQGuzhr+hn4kZ
	 WNTaRq2rKOseIgXot+OhC63mjNwKAALx3ZbpuQjiusDobziBFqI6nEYtzSKKKQL6/qdSr
	 DyBMXgV+iMrTWkzubfcD3kYd+ayPRMLexj2jle4EoMktkjbXVWA/VmvHIxUCBxSpZ3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rcQVjJxZnxTXGjH4tEi4dFeFrRtRBgbLPoX2uDwZfSw=;
	b=SNr8cvnq2dfJdc8AOqyGw8LvJX3ZjL7NgFO9pR8ftoe2Zhu9BFfRM9qD85r8qU/CDgUW
	 oXvERpKCptMRjKXm14cpjCodI/pMqYkHGr2YGP6jGQSCXxQGUzHQDs4qM0SBy1d1PoqCi
	 aoj/eLfkIOeS/aUU12gluO49CQJ5o3Gda0QjVad4xEOei22MmR2creMKSWnvsNNhvRsjQ
	 M4aFdwJBFXst/zWADysOlIxsjhAjTVkFbekxygcfuG5Kot5YlWi/5F0t6eWwIi/O3nMi8
	 IxeUwTo9L3EquPLx1c1R/gEGQ5HuR/jZr28ZFY322ksi9f0LKOvpBHM+QJ+AqhZfv3A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112144;
	bh=rcQVjJxZnxTXGjH4tEi4dFeFrRtRBgbLPoX2uDwZfSw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G4HNXyOT+Y9bRthzDGXeWyi/o5cd99cFnai3GpDEunal0jzcfw9zRrdG8Ww7UZrXc
	 SJga7TnpzTwb4uSotk5Q7WcZdZivct/kcX1PpOj2cMc4QrHvw3BrZKpQcZgJ+Mn76L
	 sJV0DFtZ0oYrQL4L1svYuk/YRPA8kp2Wo1QwELBMzAg1kfmCsDas6FAXfDY/VSXY0E
	 uAX5ZqhqAXJf/cgRE+EkYyBm3Zcjd15lpVsyEdK/w15FE9e+pKB9hWX4JSPzVwKOBU
	 RUHE+AtTI6PmfL6ZALMdNHpF6z017DkHFyoyYUPExkHBfHG8BYudX35RI6Wuk+d5AM
	 HNbJUZEVYGJCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D65EC60793;
	Tue, 27 Oct 2026 14:42:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D61D6A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC18940781
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7rpHck8B65b for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:42:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F04C40792
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112141;
 b=oHOtG97d6Pskbe8vunTca4hlM5HrU+p9XTiKJzqA2tpTyXkAyaoNW4y225+3vshIvJT1
 A9zMrr51wKvCPH4J5lbI5m665zfVMbMOh7p50+dcndl3kjV4a3bBmu64kM9Qrg6Sbfmen
 DGTgqSEYGswtyfOjxv12GywIAGNIi3k9I3ggJDURAqO0tpsOo9AIb4rga7CxV51Id4lrX
 pc85MZpZ2aAHmaM8t/Q57ok3uNL2ieOScC555MoMcGMejMdFKIcUFuKxNokfeAEGJREe5
 Oh+DJJnaoEp5BKndgA9kWL6YkrG1f5IGF95LeBIlUo14zimxYj1ATUBhmh+fhgPo3hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112141;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=rcQVjJxZnxTXGjH4tEi4dFeFrRtRBgbLPoX2uDwZfSw=;
 b=ddr8lEdwU5NjJRGppBEkQ+odV8OH4fTDhKQOLET/y4YUknXeA/nAm8lbic97FWc7x6Ar
 lcnIGWnjshMNge0VLK60ja6gWPXQk7B3kRUlyS1r9PnzJbxCUIRuaGpreqI2IucWC4xjl
 1lFPMCRqDpO2h28kqYSsrQy1f91nyFMpRmqT0q9OcOM8I4IECol0j5qym22KA7JP8Vo1u
 KCXjkl01z3cRaeB+41AzOv8YqecNC/pl1O315kNt3GSp/lL8t0crIcqvQEJs1s3bBX640
 qoTDky/d00+XYgH4sauWJkaH9QougjZa3DTCJjCNVT+CWSQKQ+jtnKYCMTnE20D7feQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b4WBp3tM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b4WBp3tM
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F04C40792
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1+mhPfOxtZuDwNDBHSmOIL0q+2Kjo8GyJoEjbxs3Fw3MgOVhn0Gun5csXIyS0BNXjIBXnSKDoXZdIgfkfLvqSELZPvy/xHJtH2L9u3WkgnJ3vAXKenPas3K4MJXPowcGnK33odvM0wd6WL+LCEYi26W0LOZoKzwugnXxBXApj2RB2A2qK1Z/CnhpNU3wZvNJBJItR2ummFdw3lPRaDH4M++y1o5+gyVcIivBC5g4VtmhR0761OTy+B7tUJi4kaAHHGMFBL8SPf9BdLkWvVKxroReWCF783hn+kZe+cmEeFDYA89cyqWg9/bTYLz020jZ/SHmBSFDUL7tREEtbCNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcQVjJxZnxTXGjH4tEi4dFeFrRtRBgbLPoX2uDwZfSw=;
 b=H1usfto90t7DnOqpmIkN+vEv6iYxY+hHW6ZH1nWoYhhrDPn8ffQSmVHaXxxh7+YzHzCkwvfqxwuks8EOqoWttNGYFLe/uLGquBpGTOdYIO08zpDeMuwy4otxL09QVhRWsLliwunQWM0YB6RnA8mY3xunLfpkFjR20bAoZ87nqiNoJiduvK1156aE472Vh4WtOHjr48Fff75qvG1NP5PoQli8RTaYliL62PwDqKlBIPB8GHZH0Z3ofOi//JwxagNEdaQVdVv02kmb3lFGILBbkHsDT1ugjaaKCDBIsGMd+JZXDHI60M9MTPFL2N/JuhXmpUJ7AWRBID+GuiG5L/pgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcQVjJxZnxTXGjH4tEi4dFeFrRtRBgbLPoX2uDwZfSw=;
 b=b4WBp3tMVQkyU9gFScLAFUrz1BjfwHHXX+YL/RQgaID/z6GE3K6yk7+SDYAKFLOeQO/UVJjMVmGQAzvdPzKevfNEwz3Gl0S5wyuO3nIj0+tKi0DuwtrZb1b/+/92d92JuwKfQN2Cn636OWQ2vljzFf9qjGGoo+xx9vsZGWE8htg=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:42:12 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:42:12 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 0/4] mtd: Add MTD virtual concat support via device tree
Thread-Topic: [PATCH 0/4] mtd: Add MTD virtual concat support via device tree
Thread-Index: AQHdYi13eef6Nn6CPE2LdSHpbVIlGbcMQQkAgASnuiA=
Date: Tue, 27 Oct 2026 14:42:12 +0000
Message-ID: <PH0PR12MB7470E35D8D16EA032FAC250EEC602@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <CAFLszTg6W7f3ou6-y7C5G8hvFdsdSTwpJj-g7BjN4X75bcVZ+g@mail.gmail.com>
In-Reply-To: <CAFLszTg6W7f3ou6-y7C5G8hvFdsdSTwpJj-g7BjN4X75bcVZ+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-27T05:48:10.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|SJ0PR12MB6928:EE_
x-ms-office365-filtering-correlation-id: 2c0beae6-c57a-4f3f-a723-08df34387cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261026140227099003|38070700021|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: TNJ5YQr2+d2szPye7XDmk7QadApdIIB6/nHKxl9yR6+QzDiIhO6xQsvbAaWbQlYdKSZsLhQN36edBCNmBxI1tBKcsQN60KjM1XmQ63eyyiWhbnseMPhhJA+epAWT/JNKl9czUXjWgDaUNaPwVWtiv+fv4cGJ2a9LKuMfiEd8LQoIqxR1vVZyQsUCtLKpJQ4DEW83ZS3U9N+JLoKcm6SoklbzWF/44KtvF3Yy55NyWsGwWz6KvEVSR9R7ilmOf65/iK48ciwadrbj8yQAufKurywuOqwzevYVpNerKWn1+m6FbKKNCTbK/3x3ykkxHw3/mQX2i4bln3wTn7SOIN1coOU6Tejipah/STKS+EkHWrDopk+gtyIJP+KVn58WkojL3Qvwz+0Y5cHbcKpAMcpDeIgCGRpcfqjs6b4SHS4Y1o62pVoM+q368DvweNqDW7jbNH/qa4uBgS6mCmv8aAQ0iAY2ws4FQBmaCfvl7Nkg5LldyJZuXMdMMBEn9gmXIXuurTjgz4JrxY+VxJW9kT2aGhz66rhmnSz8n+ChOStqNVmxw+LOjYH/vwMEk7dShP8BobOBSAC7Jwf7JwLFUtGPYpeMBeiamSs2RienQ+pbBCWSq+b7mmlIEZs9sQm4xhq2L6etCPZSOdbWE3rebtoTel65BdNMmfNwIMenRgcMMnGqxl6vjUJZISImrnZmP/O1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OW0jeNK4My5rjbAhhiFLVj74MEGXMFndbCCceywjCzHoXywS4fSnLY/rfmuc?=
 =?us-ascii?Q?RE9d1BTcCXHHUgz4+Gg3E7YLOx26hN6mWAz71whOCbYgoUAlFrYjb3jZyqiY?=
 =?us-ascii?Q?V+L20gOnkNbNULUwmdK5Ts7lgeEKyRRqLhTZ9nbZWH2qUNyq8WEVNFDda+7K?=
 =?us-ascii?Q?zsPdvGzH21m98AXE9udEIinfcF/uKrl9rD9H0g5NVGNKaMEAaEGVzbnFrUQq?=
 =?us-ascii?Q?f8Rbe+RxIQYlX5DeREUMbd/D2BGQed2h7Hxn7u6B7zgaTSwaVUIE/b64fTTO?=
 =?us-ascii?Q?DEHhdk47QeNTGYkMYbOixCzJTDRncVIPTHh4VnPXhSATn+FRQOdpXz+0pDYO?=
 =?us-ascii?Q?zoBlLGZ1KZTdprUnA/yVXwpnZp9ZykIzFFJUrmTpvzQwWKQ3vv9xYPoe98pJ?=
 =?us-ascii?Q?7GHhKUkIEYUMjUUc5Rszn4ZzhpLPE4OG7DJBjlJ61tNXFPAPnnrJyOaY0PtW?=
 =?us-ascii?Q?a27wsoCtyfkG7A6Cweqkk2t4nEXxnP5lxxyiUrl94pAL//M9/hUv4wWpLQKf?=
 =?us-ascii?Q?FUJUe0aD1kWhsIjNJDpS8/vTT3kl5o8kVIEVTmrE071frRybLVoyZ3n+EYLL?=
 =?us-ascii?Q?CfmsFWKgZ2Pd7m2OFh4CTQSKTos42C8wEK1kh1+e7i2NEjZGHhhvJIxJAIl1?=
 =?us-ascii?Q?bA3SvCYw5zb6pLblhlgOAjUWz72H7ddg2Ax4FJUCPlO4f/6ao8/3itTesq4M?=
 =?us-ascii?Q?W7XPy58vcMrkYjUX4NT0GDIZQRD6J9lIDshHRRq28anv4WUkyfQpEa7kKPmA?=
 =?us-ascii?Q?17kDJu/qKvir0HzdXPnY9DPeccARtPT5cDUwXPqtSdw+K4aaR7W/9GXevmx9?=
 =?us-ascii?Q?y4uoE4l9Dl85slf7kDv9UK4I4lmZKCEOhxly3usISaGrhnx9vRKtsNJ3a2D6?=
 =?us-ascii?Q?N3EiMtkJCrBHDaubntjBWX47A5xMDZ0exC4/O+X8em8f1QFfXMUXxYQBGkqw?=
 =?us-ascii?Q?adK1nezq6JhtOxdXjRnOAL0iZIazuZAP6AtGrZ97yK9RfGbn6kBx0v3cC89x?=
 =?us-ascii?Q?CPcF+rp2Gx/oCWf2SzarWWR1WPjRSzBR291Btlr5sbQKmPvV1CIPIDlVxfmY?=
 =?us-ascii?Q?bSZkfqe8KmDITEZcpL8xouPNWDOQpvdcCLuwI0YD1BBSnc8BLeSdrOc4abb6?=
 =?us-ascii?Q?n77Fi0BkCiBM0cHZYlz4xycUafzO1X8HNXNdi+QCznUYhL/WNrIdjlYJ2gRC?=
 =?us-ascii?Q?9vfHKtkESW985EeIS5eQOzbsDGGA0iTn2OZDoGmtwcoZt15gWRF7XwyNs5BC?=
 =?us-ascii?Q?35bFuwR2/qLp9RqZ9aW5t0KO4N/899rVfo5hu1LJdOs2ayQh8O1iObDHi8Zk?=
 =?us-ascii?Q?JpRSl8zffK3Ui+QNOSKGyDRV5hSyYOT7ioJ27JBFlWTjf8EeIUdC2TAcszoJ?=
 =?us-ascii?Q?OnGljkSQGKPj4te5szFOWjOKP4ZOboK3OPn1/tk9B+Z03NuFMwOD/PpPvVOD?=
 =?us-ascii?Q?0FCkMswRUQ47eqLPiLHOSVMO0TAkAwbwpbn3D9pP3NyLglWkVYNtR0oniUyy?=
 =?us-ascii?Q?ekhz/50nKoL9rengq6NVR432iOUuUc2ma8TMy+/GvfCeZR/8FG6ZBp3oTmZX?=
 =?us-ascii?Q?HFPLuGQ4VhKUM+WM6ZMtnhy0+CDBpd8L1IPLZEfgHLpANrXL7pNI5N4f6QbK?=
 =?us-ascii?Q?bO2j+Nab87Tt8h4+asTmT4gPOj73sDIfLvipnebtxXmI0kjMzOtl0fltLE3Q?=
 =?us-ascii?Q?47ZEfqquet90byfja17JmBBHFnK7hn5bYYF4AqkQ7pZZX5BJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0beae6-c57a-4f3f-a723-08df34387cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:42:12.4287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Uo5j79ATNuy5pBisEi1QN7BTKFWVUsfuMXt3Imqriwv3K5ZxZlgh/GS3w9mOLSdxG7GIhy1qI7HM5x3Za5AHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

Hi Simon,

Thanks for the detailed review.

> From: Simon Glass <sjg@chromium.org>
> Sent: Saturday, October 24, 2026 12:11 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.u-boot-project.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 0/4] mtd: Add MTD virtual concat support via device t=
ree
>
> Hi Padmarao,
>
> On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> > The implementation is based on Linux
> > https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-0-5e98239bb55
> > b@bootlin.com/
>
> Just to check, has this landed in Linux yet?
Yes. It merged as 43db6366fc2d "mtd: Add driver for concatenating devices" =
(Feb 2026). Since then, Linux has added 7 fixes.

>The binding is already in dts/upstream.
> If the driver has been merged, please refer to the Linux commit instead o=
f a lore link
> to v17, so we can later tell how far the U-Boot copy has moved from Linux=
.
>
> > Tested on a ZynqMP board with two mt25qu512a QSPI flashes on CS0 and
> > CS1.
>
> The last patch also enables this for Versal, Versal NET and Versal Gen 2,=
 but you
> only tested ZynqMP

We have tested on ZynqMP, Versal, Versal NET and Versal Gen 2 but mentioned=
 only zynqmp.

> and only GQSPI gets the chip-select fix.
> Do the controllers on the other platforms (e.g. the Cadence OSPI) select =
the right
> CS for a flash at reg =3D <1>?

The Cadence driver is fine, it already calls cadence_qspi_apb_chipselect(ba=
se, spi_chip_select(spi->dev)), so it doesn't have the GQSPI CS0 bug.

> If not, I suspect those boards have the same CS0
> problem that patch 3 fixes, so please can you either test them or enable =
just
> ZynqMP for now.
>
> There is no test or documentation in the series. Sandbox already has SPI =
flash
> emulation and MTD support, so please can you enable MTD_CONCAT and
> MTD_VIRT_CONCAT for sandbox, add a pair of partitions linked with part-co=
ncat-
> next to the test device tree, and add a test which checks that only the c=
oncatenated
> device is registered and that reads and writes across the boundary work. =
That
> would also get the new code build-tested in CI. A short doc under doc/ de=
scribing
> the binding, the naming of the concatenated device and the interaction wi=
th mtdparts
> would be good too.
Ok will do

Regards
Padmarao
>
> Regards,
> Simon
