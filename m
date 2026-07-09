Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F619C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC4884A73;
	Fri, 10 Jul 2026 14:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fQqMgpOu";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="GjV8rLfR";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wSnf9hOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F4F84B86; Thu,  9 Jul 2026 20:02:45 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3680784B72
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWoiS2246821; Thu, 9 Jul 2026 11:02:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pfptdkimsnps; bh=DYMhlbIAu8anMnjNmpXMGFK6yxmiWoZYwiEgG4Gs+5w=; b=
 fQqMgpOunb+eWzW2f097wValfkxVL/wxTLWjCMelsa4GU5oXqgf5ksPLBKpDYopE
 fP2IeuaAj8WYz+n1y0kvDKCCuUW8B0imI2EL4KK5vzDN6fYQBavUXp8kDoll798J
 QkFQpOCOlnunkj4ackK9Kg7iJbeKC1S91+6Ez0nF6i31E4Qx8XRuvVr6RSopE4OS
 vD3NvIZwjHU20wsDxo0fOZiRdqY13gv2v5bEP79M4WrMM99UXAfz53gW4RTLJ4Xi
 Y8oqf0W/TU+DI6YY50+X6GnjDl0ToVwo9yVbmEHN4r6/dTVj87KlmC96KbKy4/pb
 BkU6rqkLpZs49AfLgX/yjA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4fabjq2w1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783620139; bh=DYMhlbIAu8anMnjNmpXMGFK6yxmiWoZYwiEgG4Gs+5w=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=GjV8rLfR1OARJw1HVvklZ+hnim+400nB3flYFbdpaBE503HBd7gSfOOYTnCzHSfZ/
 etNa7kS0JjB2ny6umy+WfRdMn9sHGBeX6LP3ei2uhfBYQPsvEeKx3AK46vwIu4IpF6
 ggAZVMrgpmXwLU9N59/6vjCQ+1gckOHmK6A7Z5kQycyY91Linbh2BYIVD2QtvCC6GJ
 Ut+J7yPzuxZOnWtVV/SQv8JKkBY8dU5dF2rCocjWydyhL4fgv37TSiTDglpulotEmy
 gi58XWXrblpLWp64uVH3nZgGACazHqFnClaz4J2vKLG3mI7x/Sv+E6n8FJoksrVsMO
 FcmGorXXP/TGQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 860C840138;
 Thu,  9 Jul 2026 18:02:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com
 [10.202.1.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 1C5CDA0076;
 Thu,  9 Jul 2026 18:02:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=wSnf9hOr; 
 dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com
 (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id E97FC401C9;
 Thu,  9 Jul 2026 18:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIcsT2mQ034m/sakJPNACdrsfZIRu3CqezCTJkhIa2Vbq5403ZE76Tmh2JB/xR50PXV8ghj/qKmotb7Ulou7znfWq4RLRYfdWFoegWkO5VAVs+am6zwE3lbauK4j+3XLRY0LCylpjxf6qDkwYBBH/sefW34pWkG2qXqRy5Yt79b5ca+9fWM1d/klJQi+nalJMVkjR/IFQ0+DO6FWhS3EAzBkn1ceALN2D2fKXuvsT+AXTJgdNidPDa/7V5A5BZ47oSG2q7GIWhCXC7xAvf+gaHxKnPz9wfFP8ZoO8XoIvoEak7wMPXRfVIexoRzUsDV4Q92sOTsmy3L68T6QmEQDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYMhlbIAu8anMnjNmpXMGFK6yxmiWoZYwiEgG4Gs+5w=;
 b=gxWQaiSbcuHc+3Qk5ZxPbtDEnD+cTnX4+T79Sxsc7yJg2pVYxn+mr4JK8tMQc+lQwNuq1txDbw6HbvhvVz2DVevu6a7omg67OK2LHnwPXSyhLNkGDd+wriGr3mOEWagDerc+OcKWlh6N2XP3hazVzkC00TsNSJGcmchfERZn0MHqV31b1MjnrIhpDdDVxJMyrudnJdzmmhV3aSdZFs9JtJw7upcEw1Wf5OpNShMzGWWXqLnwig2SHAccmOvi+TOkVa3oXQIrWsZXI4yYBQSjhkC4/0+WsisVxkfAPfftlkAJe+JXagDbhw/sd4ksrBqyv/lNDUcYdFoGJQjLzMFWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYMhlbIAu8anMnjNmpXMGFK6yxmiWoZYwiEgG4Gs+5w=;
 b=wSnf9hOrsGxY1BUpeWuduUgIo+URaHKmxR/qdXTK+0QFvWwUDzDMa8MWmC8snz4PdRm9iKbxhIC5o+7HK45r+WqZzijBixRtrRKw3PVpEGXa+Sn+9rIwQETcpgKEYbl7nPwEKn+okxnRaFu+0C4aqSWOtOaN37UmhWt8Qdm/C48=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 18:02:07 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:02:06 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Topic: [PATCH 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Index: AQHdDy4Xxj1ueZVS2UGU+zbJAT6CDLZkShEAgAExrIA=
Date: Thu, 9 Jul 2026 18:02:06 +0000
Message-ID: <ak_hevCBnBK2Crr8@vbox>
References: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
 <d73503d2-98f4-427b-9565-0b8bad7cc1b3@mailbox.org>
In-Reply-To: <d73503d2-98f4-427b-9565-0b8bad7cc1b3@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CH3PR12MB7523:EE_
x-ms-office365-filtering-correlation-id: d9ca55f7-40fa-443c-3bc6-08dedde43014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: PWE7JiSoyt5oGFgc7TuqoQCyZ6AGFM6lwFU1OvFeWt8ReB44WBqDIk4ANv3NM2IJ8VWADRIP7LrFFejyxwLKZB45wZy3BV5QZts3bVx7l5cvwd56Wfcpp3WtcC8HaXAwHwmLxyjvTdNEqSQmCkPvCCEFamESsaHq+jqlQBiyS1qe40wRHj4JmqaipFwVXQQaIfDNNSRKY74nGJtP2WpGqayp3Fd6AChXo2trWc3hn42tB3aiQ9x+I5C4Dl4satPSPlziWeZJJPPRfM9NK3689k+UrTdWSwiSundBf//UBKOn4+K4WvIRvFt5X5fhskEMG1+yllR2Yevr4qJQWYh+tz4L2jFq7xmGZBdcIPwSdAPPoP+4fZAks7a208OfYe2chbcwDCqt6v5y/4p8RGT128leaJGl/BR0ROZCpdP39rjTeVEKKTH+0cusFoO8Zyr1va85a7cMhJo0hQsu+uwj+vozfPcj5gJLK/pPaiCgm6MPLO+m4ePTA0ULRLjh0kn9dZ2USabl22KHU5jkSAecWvn8xnPVCeTXhIIEl//3wMuynm3Lmwpqlvy91v6s4zedvVp25wMpCXUro2tu241UeKYr+jjrg5oxYn4zDP1OM7HkoS6QNfHgk4dNAmodW/XDMhV/avCI1gh/KX1Ric80V1PFwx9kOYhrOaOV7d8paOPaUDrpUKeQXz3jA0KUENIhzXSgs6TxEuUUFh1hUJVOuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJsWE9Ba2tLaVFNOXlOaW9RU21tNFdUOUFKNGpvTGdveTdZbmFtbzVPZHJW?=
 =?utf-8?B?eUNXT01NbEd5NDRoODE2YTB2Y01tMVlGaVpvb0hLZnhLTU13aDJCSWlWYW9U?=
 =?utf-8?B?TEt4azFXakZZenFLWXJzSWRhci9GakJEYXpiK1BBZnE4WjdYQkkremcwSDM5?=
 =?utf-8?B?eW1GWmZ0RytrWU5IaTAwamVqTWdYWlB0R3hWNXRvcEptYnZ2a0RyNlVsbjlB?=
 =?utf-8?B?eWlEdXlLeEdEWE1ScVdGK2xid2Q4OUdkQU9jWDdSQkhPeWVNdHlJM3owRGlZ?=
 =?utf-8?B?TENNTXpKU2d0ZW5ZbmZVNHZFWkJUbklucVlhVTNPVjNNUlFrNkVaY2g0eU9q?=
 =?utf-8?B?ZE03ZTJsbmtjd2FWdW14TjJEaGFkeEJjMUNYSUwrS2pzUTRNWk1Na0VUSThp?=
 =?utf-8?B?VmhOQ09MOTlSQ1E2M25OUW5KdGJobG1MTWgrL01sUHd4OW9vTkFjdUhIN040?=
 =?utf-8?B?VWtubjFsUmpMSmVyWFFHNktja0FzeXQ1TFlTaVlWYVBHNzFyRFArc2UxYlNp?=
 =?utf-8?B?aW9WdEkvUGVld2NtVmg0NStvM1pxbE5ZZkFjVTNEajVPQlhtYWxjNlNMNlJZ?=
 =?utf-8?B?NmhiS0Z6NUVWZjRVaW52VE5oZGNXaXJDM2crcFVtWkF3UHZWTXA5TFo3M0dh?=
 =?utf-8?B?a3lkNDMxd0Vicm1VbHpXZTRaRmNOVzVOcFY1MWUxd1YrK2RSNkVxYklGQlRi?=
 =?utf-8?B?b3RLTVlxb3VWWWFVV2hHa0hqWmlENnY1SDNjVFhhNWRwRElIOGZkKzZmeHhN?=
 =?utf-8?B?S1NVMjJKS0E1NGZWc29XV3NlS1hhcGQvQW1oVHpwaU5qMTFLMmhCTzgxV3Fs?=
 =?utf-8?B?YTU3eGJaRDVVRmRGd2pURFVudkt5V3FnT0JocEVWRTl3Sm9qZnBLSVN6aWJs?=
 =?utf-8?B?NDZ6WGFGbmFhMkdndENLVGZXUUE2M2ZueFRzT29TdkZYMCtTRFZMUmU5NXRI?=
 =?utf-8?B?TjRndmpjNVh5b01ZSG5KblIvc2JmYUl6VlFFWGR3THFGN0swUXVGLzVNbk8r?=
 =?utf-8?B?MWtKN2xOellTVlNzNm5wZTNZMmJNMGtUZTNPNllwTmtuYS9QOU5EM1hrWHVG?=
 =?utf-8?B?UVBIQ2ZkbHQwQTQxOVk5NklLUHRYeG83VVd0Tzk4eFF4Q2gvaml0Q1VuTDh0?=
 =?utf-8?B?T241RmdUa3hSWnNZajA1b3dFb0crbzB4Y3lodXduWTl2aDlhNmh1MGdtbkdM?=
 =?utf-8?B?UXFmbXlrMTRUMW53OHBmL1V5RGhoQlRVeE1zeitpZDZsb3ZXVE0yRW5nQ0k2?=
 =?utf-8?B?NmhkZW4xdFhKMmxRamNzUlBOWWhnM3BVTVoySzJHeENvdlV5ZThVaFpuSEds?=
 =?utf-8?B?TW8rWW9KVm9GMzBhbkpwcUxMUURzWTZrZHpvTUhmYU8ybkRodWhkeWhLRmZt?=
 =?utf-8?B?OWNkRU9GUFZOWEoxWkRPMExNckVZOTE4MUlGMlZwZVIrbFhTWTVtRTYwbzJp?=
 =?utf-8?B?WHl2NHNiSmd0ZFk4Q3pJY2dDQ0NhZUhqYnoremp4emVwZmNaOFQ5YlhMZ2x5?=
 =?utf-8?B?QUprZk80OC85dTBkRzc1L1gxcjBIOUtvRkZCVGRqOGlPVU9RSEg2SDgxY0p2?=
 =?utf-8?B?aW5XS21tRUpyZHBIK2UyRGt2QmJWM3JMZmNzeUF6cHp3Zkw2bEZTT1BjNWpu?=
 =?utf-8?B?akpRRDBQcFEwWnRJMGxDcXJHNVZQZVd1T2QrbXRCbWpJNUl0bVBsd2RXalRJ?=
 =?utf-8?B?TTA1ZE9FNTJQeEpoajEyQ0I2RXg1Mi9samliRnhZNlRGdFFXTTRESHRySHhs?=
 =?utf-8?B?TStEd0E3YTNmOGpRakhwT1FLQ1VSTWx4UldoTXhtTUdZRHV5T2NwQnZ0aFd1?=
 =?utf-8?B?LytSZmZ1RXpZQUZ3a284QmJGUzlseXZEYnE5d01hcmxNVUx0WG5lZnJ0azBH?=
 =?utf-8?B?V0tQczRnbjFYanB3c3JKcDVleXk0NjNTTWlnblZSbmRrNldXWWMvZi9tZTBB?=
 =?utf-8?B?L2s5NXoyWExPTE12ZTh2VmRPd0h3MnNYK0ZMVXJqMjhMdlgzTFA5aEs5cW01?=
 =?utf-8?B?ZG5wWFphL2xlTmlFQWhMOXhTVVYxRkZqeDBBREhWN3VvdkNFZURoc09yR3ZY?=
 =?utf-8?B?SXRuSEovZk1uUDBub0Q2b2VYK1dJMGJVaXVvSmFlV2J6aUZZbEprL0c1YVdG?=
 =?utf-8?B?NkVJbFlPK051YmxwamFLaWc4RGc5eTVUTkh3djBiaElhSWE4SldjNDMvd0V4?=
 =?utf-8?B?Q2hobmRWVzdncEdoczc1eXdqem1ya1lHR2s0Rnk0anBNMXdGcXlRMTg1WFQ2?=
 =?utf-8?B?T0JVSmR4ZlZlVW1JT2VuMlh1bVZtNlFKSU1IWjY4VlhKNzUweUJjVzN1TDNH?=
 =?utf-8?B?NnY4enVkNkM1ZFBYZVU4VWdRTnBBYUxaMHdVTjFLOWhPL0RnWlM5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <029DF4D43EE6A3499DACE7BBFC0C40E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: epbcD/FTLmBjF6OHLHC0PBindAC9T3HwqcVBXBH+bfyXm3cVJIAJvAy8MT1LWFc9lZ63c3iyl1Adpm0Y4NLOvf7jGHy59NOglTHViLhoXhhBjeeZ9EwJq5sBhf9CdjArRb+2NrEkzNLMnBbhySW2/LYhchUKgnVrmcnjjfLIaNfaMhPGUFYy8+9F9ccgs7UFWuSZsUtsggPUgfELtbqSlUF9k0/ofXmdyJYjqB+80QKSxlAbmedA2jdCyRB4dLxCWsx2RLiBlxIk77IHjaf2A52VwDBHVtl4l9lQc3Xn3WkT6RYbGZHes2JvQoD2dLb5H4Uy55KIekru3RMsb72ZVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mOVncDyCc+l3eyPmh1b8U/CwZ+aQNmTuY0pz+ML6cQmL5L0KXFN5aOAJOgQC24tmXyCitaVYHr1vzrV0eLedrYWPez55E+y4RPwLGXzZVFeTOGxrGxPd7613ACePzTP62Dd0FYnvKdWuYjUaTO3jOQE4kVN1B53MADq77nUTV9Lytuwe26WAve+kEFTzfDY9Fof8aePCEA/b97992eXYIPnp/Vsrk4Zy63o3NHyRca9CyAak+QMPIOYfFS1HlguwKICftyPJ6K9Q2S5NWbIBDJJQX2eJ2Ff1Xr9PehiUrdoiEJ9rodw2i55xnYrqLW1t9tkyBwyoaY5D+WczE4cQLB5vPWqLp8MnbGTURmoz8sm8GzGbmEP7zYLPDN3pDQkLoF1coBo3WwJSqC9FX7LGNzQzAn4mUs/Bzi0E8eCdl0dWCzx2Bg7SlPTh275c73eZ1i+pMsI4ViRoQSCfaWo4dnKJFAPWTex3KCQ6+EOCqx7T4/FOcUeYNE9PphyT407DEzzXng9gRgLBXXJme6j+vggqQAEDplVGWpaA7dUgb1WBvn6JrrcoVPTUNxfQdFXub4GlNJlK35dSEwefwb457CKbG0pejNblDIrhmqGBUSse4NHJFWu5LljWS4YOF1Isla7YaSWZD/Dg9l6EwtrZXg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ca55f7-40fa-443c-3bc6-08dedde43014
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 18:02:06.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfAREq12EXPYmLypFHUjTcNNRlTFu88PEeVrAW9Zu2euL9re1u0J9ghBxGJWN3duMFRYPbCGaMFFbaLGRaGs/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
X-Authority-Analysis: v=2.4 cv=Zd8t8MVA c=1 sm=1 tr=0 ts=6a4fe22c cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=IIVaRaqS7XaqG0zjYq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NyBTYWx0ZWRfX4gdinRy1JqWJ
 t/MbbP+ea1AVuT50I75H3Tqjqoxbdw+99h4W6ka6hl3c7nzjHusGhELw+JIYk/1ZZBcTEhsSeB0
 LZOp7hwsrWa8LDClTkxlV5B0z7Wiwgpo29m1qSGNg+3QmCDEw6t5WXdsMBaObfKmX4kkvEzm9ON
 0pyJX+HHpYFIHyZf7z0Nu4azgOhP1NOWfVV7FhqAweDHZOrYk+wnrw6usJPxadxXdz3Kx8T2uV4
 90tpfy+yB/A1D/to55Y5NFqYz/4p2PMNlfrccOLalMT2NbJuD/RRatZke0sEVKpX0gkTICrhqe/
 /dvOWsVmF+Dk9fduyhWv+a4oqf6yw4FZzP3DTsCpx7Un+xZN/S4zrCnUMgxrkWarQPDOoDUSPVC
 rXQFpx1dB4gnQ4GtDVdytXEmRIjPCW/S2P+JAI8q4evA6FQhh+bq2BkpssF1UKaDjytkhirqofi
 jPzvyNnYtljquiGnoIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NyBTYWx0ZWRfX9q3f9TYUvl8S
 rIw+kOqNnZQPkcSZPnFI+alfhRWYzsKBr2DjLeILOHF2YdAtvdN6F1UhPvhXc16L9ZKde14bWr2
 4khUp0fEC9btVUq4X8Y0U4xz4Xx3ivQ=
X-Proofpoint-GUID: PCdiuTxBoLZatqV8-uSNp7F8bgn5FFE7
X-Proofpoint-ORIG-GUID: PCdiuTxBoLZatqV8-uSNp7F8bgn5FFE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607090177
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

T24gVGh1LCBKdWwgMDksIDIwMjYsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiA3LzkvMjYgMTow
NCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgU3VwZXJTcGVl
ZCBkZXNjcmlwdG9yIHN1cHBvcnQgZm9yIHRoZSBtYXNzX3N0b3JhZ2UgYW5kIERGVQ0KPiA+IGdh
ZGdldCBmdW5jdGlvbnMgc28gdGhleSBjYW4gb3BlcmF0ZSBjb3JyZWN0bHkgYXQgU3VwZXJTcGVl
ZC4NCj4gPiANCj4gPiANCj4gPiBEYW4gVHJhbiAoMik6DQo+ID4gICAgdXNiOiBnYWRnZXQ6IG1h
c3Nfc3RvcmFnZTogYWRkIFN1cGVyU3BlZWQgZGVzY3JpcHRvciBzdXBwb3J0DQo+ID4gICAgdXNi
OiBnYWRnZXQ6IGRmdTogYWRkIFN1cGVyU3BlZWQgZGVzY3JpcHRvciBzdXBwb3J0DQo+ID4gDQo+
ID4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZl9kZnUuYyAgICAgICAgICB8ICA2ICsrKysNCj4gPiAg
IGRyaXZlcnMvdXNiL2dhZGdldC9mX21hc3Nfc3RvcmFnZS5jIHwgMjUgKysrKysrKysrKysrLS0N
Cj4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9zdG9yYWdlX2NvbW1vbi5jIHwgNTIgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gSSB3aWxsIGxldCBNYXR0aWpzIGNvbW1lbnQgb24gdGhl
IHBhdGNoZXMgdGhlbXNlbHZlcy4gQnV0IEkgd291bGQgbGlrZSB0bw0KPiBhc2sgb25lIHRoaW5n
IG9mIHlvdSAtLSBwbGVhc2UgZG8gbm90IGFkZCBpbnRlcm5hbCBSZXZpZXdlZC1ieTogdGFncyB0
bw0KPiBwYXRjaGVzLCBpdCBjb25mdXNlcyB1cHN0cmVhbSByZXZpZXdlcnMuDQo+IA0KDQpTdXJl
LCB3ZSBjYW4gcmVzdWJtaXQgdGhlIHNlcmllcyB3aXRoIHRoZSBpbnRlcm5hbCBSZXZpZXdlZC1i
eSB0YWdzDQpyZW1vdmVkLg0KDQpCUiwNClRoaW5o
