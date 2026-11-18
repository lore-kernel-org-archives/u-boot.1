Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AB606A32F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XO3sRwli;
	dkim=pass (2048-bit key, unprotected) header.d=cisa.dhs.gov header.i=@cisa.dhs.gov header.a=rsa-sha256 header.s=select1 header.b=oo5HkTg/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E134037B;
	Wed, 18 Nov 2026 18:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtHVG-p6Gcaa; Wed, 18 Nov 2026 18:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E292E40396
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795027167;
	b=nZwTfpigaw32NVm+EAJzTorFPzAoBLonO1Ma+Zuz6+Xxa5HPDw9tcLLgZBnzBL0afDbS
	 yWIzWOHcaUmkGjoIxikKYM1T3/p3xTUR8EXIkbu7QjgNBm0D1lK+Yw4+6ZGoOezeZDAE8
	 llUNiYKzZZzP6+y8k4GwMI9ReugUThd6LHpqao1P7zcTh8JkwDJcSvEetfHia8vwN6qOq
	 uwrzeWdzrv2ks8zWP3LJkNl8Ffm8avbhBdFiMIWs+jkmDp21v6SzDODmFd3uNIgRmZtUK
	 9cGXCz4BQ7ahNYaMM9iPJskkAGdvJeJLZGT8i60bgR5fyUThX88s4jgFg4x4CstbcBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795027167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JenbSbETBGPZ+e/5r/EAqviqFzOevji+FaUCXycWbMA=;
	b=F/XAYur9+DjYg+xw5bf2P8pATwE87fKpztrUD+Aq6MZ6m7yFZuM5wW7xLSZNFcxb2sUa
	 N9hgDp67/mQnl2CEMxNt464hEK5Fs3eNMjs0ek0g0FqFJX46pKTfO9xi4RP8d7tVHszX4
	 nqogdxHr4naaEJUa8BlGJ0KCKngdnUyHosvFePar/T3CkEfQBK4czgoPegv70aVrFPfKR
	 ZLLnzQvImSc4Uf54Mn+GYoh2nyze1e3o1knDgpwKJNKFLiP5TtUxgOdCWWC1FBO9Xtvbr
	 cOipROLliEf+D6QqcQk2ZGVaeUlIGlI+S5kPw/7CJ7z0X/PPuy5ZeZRWrRrUz3wDvNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cisa.dhs.gov;
	dkim=pass header.d=cisa.dhs.gov header.i=@cisa.dhs.gov header.a=rsa-sha256 header.s=select1 header.b="oo5HkTg/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795027167;
	bh=JenbSbETBGPZ+e/5r/EAqviqFzOevji+FaUCXycWbMA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XO3sRwlil6375rMMTT0QXnL0mDUNV1Nad3OcSSp05RWXWX5k7/RC5sPwdbMkFi1SX
	 ukvVGoAbhoSb47dxbHSgK5dZKCWFcKlrALApXxEY1cM+cFH9LvkEyCc7ycYJmve4KE
	 Bz5OZHhPZDENVDfKkWcJnKO20yHfOeDsuZWI9v90D/CoRV0OXfqv1qtRGEHYwC6rd0
	 8obIeDlhjDW7kkBtukiU/Ilzg3PFrXo8Q89eoa3QvGWuVSjwcE1gJZYjtYCAIeh1hr
	 ekdvZOHv3x0/ZD42JhrxbbI17Rgd/YR/emrweXJ9O3wc1tJeTZrCZfgTvD/Z2Fpk5E
	 tT+bu326VBz9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E292E40396;
	Wed, 18 Nov 2026 18:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DF2128C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E65B3409F5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BA0PByBuBYUu for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 895AD409BA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=67.231.147.98
X-Greylist: delayed 568 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 18 Nov 2026 17:06:12 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cisa.dhs.gov
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cisa.dhs.gov header.i=@cisa.dhs.gov header.a=rsa-sha256
 header.s=select1 header.b=oo5HkTg/
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.147.98;
 helo=mx0e-00376703.gpphosted.com; envelope-from=cvd-mailbox@cisa.dhs.gov;
 receiver=<UNKNOWN> 
Received: from mx0e-00376703.gpphosted.com (mx0e-00376703.gpphosted.com
 [67.231.147.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 895AD409BA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:06:12 +0000 (UTC)
Received: from pps.filterd (m0186849.ppops.net [127.0.0.1])
 by mx0e-00376703.gpphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIGoSRG1466351; Wed, 18 Nov 2026 16:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisa.dhs.gov; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 select1; bh=JenbSbETBGPZ+e/5r/EAqviqFzOevji+FaUCXycWbMA=; b=oo5H
 kTg/wKONkAQJrCV8Sgrq2Kc+s3eyntpv97hGuz9U7TOmjwWJtHRcn/FL6IDAdNhd
 +SOZEKln9VwCoA88oUajxqsHf7fy1fDXsgCu5r4T+Iy8IduQvW1R1gXkkktlVZmA
 yCMVWMWONP5XdK8PLI+Gd6qT41PPc9Ia/Nr6OacpGB0oOV0tozu7FKB4MBmL8JRD
 Bql8a/HkYeKw2xCNAqu82S4P6/VLI6ACg/34QrjGo2GYAwZ2d0vBoJnNvvFh6lRX
 UdhmPldM3OGUIX1VpD/Ro43sGosUNRZTdTM5n/UFmGWT0KOZJQGcdWBxZPL7eEbb
 K7YCvNim+C7MVvrb6A==
Received: from ph0pr09cu001.outbound.protection.outlook.com
 (mail-westus3azon11013002.outbound.protection.outlook.com [40.107.210.2])
 by mx0e-00376703.gpphosted.com (PPS) with ESMTPS id 4j0yvjc8vd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 16:56:42 +0000 (GMT)
Received: from SA0PR09MB7017.namprd09.prod.outlook.com (2603:10b6:806:79::8)
 by AT6PR09MB12491.namprd09.prod.outlook.com (2603:10b6:170:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:56:37 +0000
Received: from SA0PR09MB7017.namprd09.prod.outlook.com
 ([fe80::8718:5c93:6e66:1532]) by SA0PR09MB7017.namprd09.prod.outlook.com
 ([fe80::8718:5c93:6e66:1532%2]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 16:56:37 +0000
From: CVD <cvd-mailbox@cisa.dhs.gov>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: CVD <cvd-mailbox@cisa.dhs.gov>
Subject: CISA Coordinated Vulnerability Disclosure: Das U-Boot - CASE#740545
Thread-Topic: CISA Coordinated Vulnerability Disclosure: Das U-Boot -
 CASE#740545
Thread-Index: AQHdd3027ZlvivXNdk6LsZGCFeW6dg==
Date: Wed, 18 Nov 2026 16:56:37 +0000
Message-ID: <SA0PR09MB7017E1D9AAD585327316F230C37A2@SA0PR09MB7017.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisa.dhs.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR09MB7017:EE_|AT6PR09MB12491:EE_
x-ms-office365-filtering-correlation-id: 87f06296-66d9-4efd-922d-08df4594e8a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|6049299003|42112799006|261009223027099003|260925021311599003|18002099003|260925021911599003|260925022911599003|13003099007|8096899003|4053099003|261022075727099003|261021135927099003|261028144727099003|261022105027099003|56012099006|261026140227099003|10067099003|38070700021;
x-microsoft-antispam-message-info: /bvqy9g3TzUg9BX0J1Cnhwl6j3hm0sb2EZu4VJCtD6CRPQ0dZhBOJsuAneW822ZUSfVt0wPs43iW8gmNphsePFYs/2Bq2r+iSif6synCCIaZ93ATzGb76cyn81J3O8vHc9TFe74Tgz8wglJDdpiHrbG3WFmC6tJiACA1vZbGQOroG7TJGGBuDgL0Fp9Pz51Ra2WiLPMtSNHSyeK/vnOIpGBSrElJu5kEcDu9zMQ0uF3QetBUGROShJsbtJnZaU4Y+v/4BKnJWtZLQ8fvWBYDyi72gWMM7ar+yFm9Fr7KPR0Nq6VylBU0++Zm1kmV/i6gv1Fr7KS1HWruPiRzt3yR7EetavFQyp48G9upZmwxYMpvRmSD3CaDbM9h564CL00FXDi7fziDqXJ+zRQ0VjlN5pPUqFL9bfuy09F2+3nRzEesVNKx2XDzm++4K6vdh2nJeSth7meH8A51Hgrbh6V2DScnx6VHDoATJq1PRkXLYUmHgaaTLMHtj3bHlLRXejYwrIlvNGd49mxLjT+MZLmhr6VrkUkWsJa0tfhCdUjyhwfhMT3bJKg6Znv/Ncu/E9/yDOXiahe/ZGEIbV+lVqC9izYN7ATOyDnNbmybhKtHAV7VhGvxoEU33SrCPBJQzRQMtmvONoQXbIZTGhm31/YpdHZLym1/hZxQKwhRsW5zOa4jAuuJUwelCwBJGDwUbMqp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR09MB7017.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(6049299003)(42112799006)(261009223027099003)(260925021311599003)(18002099003)(260925021911599003)(260925022911599003)(13003099007)(8096899003)(4053099003)(261022075727099003)(261021135927099003)(261028144727099003)(261022105027099003)(56012099006)(261026140227099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?PWvLKhrngiTId8AELPgLIN+NRTmJC8W7h1160ybbvAy2gS1MySwdHsap?=
 =?Windows-1252?Q?g+gBm0zCgHmE4ZxFmFxF1CCIweY1+Na0LVw20fJ+O/W7KCeTxLMxRCn1?=
 =?Windows-1252?Q?euCOp65XwXbP9t8Z9b1zrGDm/SIlLZ51zoGQGG3fcm9xpP9J6XA+WDPH?=
 =?Windows-1252?Q?bh/1/vG3voKXBj+25AQclnayBRm6dXj5+tt/I3VCZKY1fCfgAKB5LZm1?=
 =?Windows-1252?Q?jcocZXJeNTlKI3pseHCAxXNmPiqS472fHMcwnmVDky6xHTHtuyL8xqZx?=
 =?Windows-1252?Q?t5cC+8lZ1cbXh5jc640+J9YLXJBWXBcVaKAOAJXnAPrXKWruHrertZ/c?=
 =?Windows-1252?Q?RZBaLcfxPI1jyITcHOmgsD4+1qi0EvL1i6UKaKSPFw0y2Gwc3zs+NUCu?=
 =?Windows-1252?Q?QGVPCOyTYM9fk4eAVZGNgLg3z/6zinse3mBwcLvbDaoack0lAEeaM7nV?=
 =?Windows-1252?Q?1opa/WFTOGcR7tbV0lHld3FEo1vLZcfju3lvzRzvf22l3CPcFA8xwtuG?=
 =?Windows-1252?Q?Expcbio0XQPAgi4Ya7Pn8NW1RaBL4GrvJhMSNkBYXYOox7BnaSmMUOaD?=
 =?Windows-1252?Q?cQ+P7aYMOJsofjapD/pr2ye2kqXNiO6yD1M3YtmzjRUkPrsS3LHst2lI?=
 =?Windows-1252?Q?edvgfXCNQnPp5qqRMqmarzWPmqilDASdEsYFOoMqdRUtYAWp3IGr9YAq?=
 =?Windows-1252?Q?o+PaDmArmPvPSMJDO1UnKxMLtQPkAF79bDiFhJDQvgNOVHEU6gqj6Uq3?=
 =?Windows-1252?Q?jv7XkPZ3YpkKmZ4JbSM6Scvk1lWeEPXFG5PWJ39buMYbaGQmgvhF+Bdq?=
 =?Windows-1252?Q?6RrTNeq5qP8F3nE1s/QwX5QCVp5pKNBo4Pk4E+axgsLg0/xTU8Mticut?=
 =?Windows-1252?Q?d4wZwuu1NKjouhwizjQxLOUEBpnd+CGCmFq6hzyw4x4SvkoCnZB4xKY5?=
 =?Windows-1252?Q?qjM7p28gOJujIlcvbMMRU8+tJUpdCSXo1kO1I3r9w3wwRIwXUyR1WqIy?=
 =?Windows-1252?Q?CyA3IMM3KTqNmZK12WaS8s/eGn0ZcCDIxrB8BRZVx7nKfuYxTi4VpEFG?=
 =?Windows-1252?Q?vcEsesBHVlZ5rcbx48Vj2wkXiaXI9hTRf7KTkbm+kzjo8ReY1+cCVG5X?=
 =?Windows-1252?Q?W9KNR4E5UsmAqQ65jYqroSSO4PceUaHNcQK4A6Hnt5jF1ZkICogq7Uh2?=
 =?Windows-1252?Q?KMlekAuJwXL8LMi5y6jtUaDEpwRV3NheltDoyoCpOzjJeGEGwd2i3XU9?=
 =?Windows-1252?Q?RpQGSpJYLH8Z/VG8bOwZa/QFqvGNW0WdNkB35ENSmHagEdPuyIgZwhH7?=
 =?Windows-1252?Q?OhToEEuhswdG4N97lc4G2fUU1MEoK2hhAlSGRkboSVJLtgDA85QWJxLi?=
 =?Windows-1252?Q?xDdwnoFLvOnJiw0tDSC1hwhaM0yPRzFZdvWmQU2FXKK5sDJibXLcKAqX?=
 =?Windows-1252?Q?F/Oq1fGMuwWo+S8Iu8afp8w4c3DSfIPud1J62u08iaSDjaref7S0+gt6?=
 =?Windows-1252?Q?ihyoc8hgyhNWsdFlYy37kU3ATT+1+0rqbykqPYaAk1e6rFfSw50qT8fr?=
 =?Windows-1252?Q?917MKt1nOVazR4GtuJFhI18dywqEOhLIyKiEIdX77Qo4CjDSiKSwX+AJ?=
 =?Windows-1252?Q?z+jLU2rjcSL9OIPmjzath7KImzvePs+hHJDtsOih/WVo1zkRJ4o3F1RP?=
 =?Windows-1252?Q?el6RegEzHqDIiMPAfgZ4Fyok/yj4q/gUB/p4c5HkKaQhVIHUMbYOMiMk?=
 =?Windows-1252?Q?4DhCxJJVfzzCgEJQFwH4ts28DT69O+XRQJoVsJMCKALUz7NhTTkqBhwM?=
 =?Windows-1252?Q?a+qIS9gfd0U2xI52EQMVcarkFotc4BVk7j2DidGaGxkp+qYR?=
Content-Type: multipart/related;
 boundary="_004_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_";
 type="multipart/alternative"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QR6X1+ONpkysxL0yPkEqcXid6nrDfyfMEknCoZuD1gr/WTKrtkyYEILuRkYGEQdY6gX4IIMm3np/yDM8FEweXVNKnOd0YoHbfBo2IPv2WkpqyZPHjCmD5ftFLbCC5PpJfsM/TQWt/IcBSvfgbxqjs3TDA1DeozTKSKsEfnYH1F4BXOZVAowbjHJ/ImYolaGVU/O3QM9HU+mGWSWZEAchInMfNfffX9rkjPXPyeQixMmYMS30PRXPHxwqvN6LJB0n55tK9u8reasVRJtx/28q99XBUvAjFGGWWDYJSQViyCzyQK449wO3dLopRHlcBsUiKnhlse2oSkK2yJt0o664MA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z+Kc/MeDIDJGW4wahvEU2o5vJYDywufkB27Nwy78OW+7DYHfp7RjlbzZOQ5gxA0f0OPKcALGWoNoahW3gt6OHb0ThbQbSemathXwHIX264QDzGtLt5fiddO6YdaEQQl3S4youiD90Xuq5Oxa8pKnAy5ikRxoIaYLbh5UNFl7C7/Q60fLcU/d8tTTy0a4upqjRJiE83QrhIgotgUWnLVNwOh6r/61l5eBWLt3LbYdDrytml9RE6YMXoduAkHB5El7wmcqraVby30qKrIIFHPTY285/eLDQy7k9xLxbPM1e6xU2AkbS3O/Msmx96ePmFHW9O2k9x5m1ZOQYgKfkYUDlTZySE90S5KNDs8Wm2ISTCYnoDqy2nmDx9pwb7OUHxR9n+NgKIPJc/TcVxyBi9YFVku2pt7uVyGzD2enCDuiTLBSOgh5KPtvN8PwSPLwsN/EqlpJWPuG6vtHnI379N+OJlsXhxuMu+kJs1Qo0izEEezaf/wRRpiMKkJxGpDggSQ+1uZYfCwdyOBxYdzApC/K70S/Tqq8TGO09Kvmleo633BO1vZ9Dg+zKa7lK6E9STNTiMJLerHNAjTdhImwXPX/STCZgafr0cvp1Ho13gdFRwNwnPiL97w0rgurIY2shLoyQesxAD2H6tGeN5uhujNoHA==
X-OriginatorOrg: cisa.dhs.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR09MB7017.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f06296-66d9-4efd-922d-08df4594e8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:56:37.0521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 69c613d2-b051-4234-8ed1-fd530b70d5d3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR09MB12491
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NiBTYWx0ZWRfXyHPFT9YAzCpj
 dzzhXUw+GWQJ8Gih/h2MwR2lpQk+BFK+TJjtIzl0UkATdq/xKGMeDdWfI1PLI1Kyk8tnkJ+i+fE
 CFBkRzqKOEFGHgDZqbJZyauJczms0F4dEfLsDE8EjgHaLgC9amUA
X-Proofpoint-GUID: hFenTnRYeDotCkZ81ee89EJC7cOWQt-J
X-Proofpoint-ORIG-GUID: hFenTnRYeDotCkZ81ee89EJC7cOWQt-J
X-Authority-Analysis: v=2.4 cv=BadNQbt2 c=1 sm=1 tr=0 ts=6afdd8ca cx=c_pps
 a=OcpDMAjIOpI13VhFRUoKEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=3x_-aT3qCdkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=cUfibiFPLLQVyJr3AsUn:22
 a=BUXaFnP8tHfJy7_U-OzS:22 a=7EYLHn_AAAAA:8 a=_bNNBn50GW1ufhuTFT0A:9
 a=lqcHg5cX4UMA:10 a=pILNOxqGKmIA:10 a=iXytpDAKk7lg7EUflX8A:9
 a=vdd5pTlfTRkW9T1C:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=HXjIzolwW10A:10
 a=T6a71-JsGAwA:10 a=zY0JdQc1-4EAyPf5TuXT:22 a=GH8-RhGAYbb3X_7dexbv:22
 a=NYvOAZVpcHA1vhoMOvR0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NiBTYWx0ZWRfX5jcxvm1HVucK
 9DHKT9754YOu3VL7+H808yEgPLXbJz+tXiJ7732zYTJ0Vt/BFmmnYS9UPDhB+2PntuM1ygQIdnK
 QKny9BrfQa0jRWGggBJWGV9DFm1yKR5IjqdjuAgtpAEBLQj2aWOz9jMS7uk/PUW7654D3fsXWbD
 8sv/vjyl/gflx9UghNo4Mcgp+g0sX5+mUwgueIxvZwW7dmgiOXVhvJvHsYk3Ihv23yXsq9X4Zdf
 PDdXaDQwGsVlPcYMJgo2tsVGcDETeLl8Vtf6/glR2lm6h1nsUowvhntlUR4TdneBmR9VgYyHIIY
 HxohvlfQDeNfCujKbkumyrVAuv+eyzit7G6FBrgJD6af3jgs0NCes3iteIU5DaOnN0WR4br0NQT
 eobLNtCzeP86TimbNEvS9Wpeu93XIP+goBs6QmuBslEFeQlBzyGBOlr1jYBHpHvjS+7HLM6xJQj
 XZ26hxPnhcHFs/YmJbA==
X-Proofpoint-Virus-Version: 
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180066
X-Mailman-Approved-At: Wed, 18 Nov 2026 18:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_
Content-Type: multipart/alternative;
	boundary="_000_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_"

--_000_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

My name is Kevin Harwood, and I support the Department of Homeland Security=
=92s Cybersecurity and Infrastructure Security Agency (CISA) Vulnerability =
Disclosure Program. One of CISA=92s responsibilities is coordinating the re=
sponsible disclosure of cybersecurity vulnerabilities affecting industrial =
control systems and other technologies that support critical infrastructure=
.

I=92m reaching out because CISA has received a report from a cybersecurity =
researcher regarding a potential vulnerability affecting Das U-Boot. We wou=
ld like to coordinate directly with the appropriate contact at the U-Boot p=
roject so we can securely share the technical details and work with your te=
am throughout the coordinated vulnerability process.

Could you please direct me to the appropriate contact or product team for t=
his issue?

Thank you for your time. We appreciate your assistance and look forward to =
working with you to address the reported issue.

Best regards,
Kevin Harwood


[undefined]


Department of Homeland Security

Supporting CISA|CSD|VM|VRC

https://www.cisa.gov/ics

cvd@cisa.dhs.gov<mailto:cvd@cisa.dhs.gov>

https://www.cisa.gov/coordinated-vulnerability-disclosure-process

If you have concerns about the legitimacy of this notification, please cont=
act central@cisa.dhs.gov<mailto:central@cisa.dhs.gov>, include the case num=
ber starting with VU# in the subject, and ask to be put in contact with Vul=
nerability Management's Coordinated Vulnerability Disclosure (CVD) Team. CI=
SA Central may also be reached by phone at 888-282-0870.

Industrial Control Systems | Cybersecurity and Infrastructure Security Agen=
cy CISA


--_000_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
My name is Kevin Harwood, and I support the Department of Homeland Security=
=92s Cybersecurity and Infrastructure Security Agency (CISA) Vulnerability =
Disclosure Program. One of CISA=92s responsibilities is coordinating the re=
sponsible disclosure of cybersecurity
 vulnerabilities affecting industrial control systems and other technologie=
s that support critical infrastructure.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I=92m reaching out because CISA has received a report from a cybersecurity =
researcher regarding a potential vulnerability affecting Das U-Boot. We wou=
ld like to coordinate directly with the appropriate contact at the U-Boot p=
roject so we can securely share the
 technical details and work with your team throughout the coordinated vulne=
rability process.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Could you please direct me to the appropriate contact or product team for t=
his issue?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you for your time. We appreciate your assistance and look forward to =
working with you to address the reported issue.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kevin Harwood</div>
<div id=3D"Signature" data-signature-name=3D"CVD">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 0px;">
<table cellspacing=3D"3" cellpadding=3D"0" border=3D"0" style=3D"text-align=
: left; text-indent: 0px;">
<tbody>
<tr>
<td style=3D"text-align: left; text-indent: 0px; padding: 0.75pt;">
<p style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family: A=
ptos, sans-serif; font-size: 12pt;">
<span style=3D"color: rgb(36, 36, 36);"><img alt=3D"undefined" id=3D"x_x_Pi=
cture_x0020_1640735659" width=3D"104" height=3D"104" style=3D"width: 78.59p=
t; height: 78.59pt; min-width: auto; min-height: auto; margin: 0px;" data-o=
utlook-trace=3D"F:1|T:1" src=3D"cid:1221b77f-895c-4304-8f94-405bf53f55f7">&=
nbsp;<br>
&nbsp;</span></p>
</td>
<td style=3D"text-align: left; text-indent: 0px; padding: 0.75pt;">
<p style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family: A=
ptos, sans-serif; font-size: 12pt;">
<span style=3D"font-size: 9pt; color: rgb(36, 36, 36);">Department of Homel=
and Security</span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family: A=
ptos, sans-serif; font-size: 12pt;">
<span style=3D"font-size: 9pt; color: rgb(36, 36, 36);"><i>Supporting</i> C=
ISA|CSD|VM|VRC</span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family: A=
ptos, sans-serif; font-size: 12pt;">
<span style=3D"font-size: 9pt; color: rgb(21, 96, 130);"><a href=3D"https:/=
/www.cisa.gov/ics" title=3D"https://www.cisa.gov/ics" style=3D"color: rgb(2=
1, 96, 130); margin: 0px;">https://www.cisa.gov/ics</a></span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family: A=
ptos, sans-serif; font-size: 12pt;">
<span style=3D"font-size: 9pt; color: rgb(21, 96, 130);"><a href=3D"mailto:=
cvd@cisa.dhs.gov" title=3D"mailto:cvd@cisa.dhs.gov" style=3D"color: rgb(21,=
 96, 130); margin: 0px;">cvd@cisa.dhs.gov</a></span></p>
</td>
</tr>
</tbody>
</table>
</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, sans-serif; font-size: 9p=
t; color: rgb(21, 96, 130);"><a href=3D"https://www.cisa.gov/coordinated-vu=
lnerability-disclosure-process" title=3D"https://www.cisa.gov/coordinated-v=
ulnerability-disclosure-process" style=3D"color: rgb(21, 96, 130); margin: =
0px;">https://www.cisa.gov/coordinated-vulnerability-disclosure-process</a>=
&nbsp;</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, sans-serif; font-size: 9p=
t; color: rgb(36, 36, 36);">If you have concerns about the legitimacy of th=
is notification, please contact
</span><span style=3D"font-family: &quot;Segoe UI&quot;, sans-serif; font-s=
ize: 9pt; color: rgb(30, 83, 163);"><a href=3D"mailto:central@cisa.dhs.gov"=
 title=3D"mailto:central@cisa.dhs.gov" style=3D"color: rgb(30, 83, 163); ma=
rgin: 0px;">central@cisa.dhs.gov</a></span><span style=3D"font-family: &quo=
t;Segoe UI&quot;, sans-serif; font-size: 9pt; color: rgb(36, 36, 36);">,
 include the case number starting with VU# in the subject, and ask to be pu=
t in contact with Vulnerability Management's Coordinated Vulnerability Disc=
losure (CVD) Team. CISA Central may also be reached by phone at 888-282-087=
0.&nbsp;</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, sans-serif; font-size: 9p=
t; color: rgb(36, 36, 36);">Industrial Control Systems | Cybersecurity and =
Infrastructure Security Agency CISA</span></p>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
</body>
</html>

--_000_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_--

--_004_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_
Content-Type: image/png; name="Outlook-undefined.png"
Content-Description: Outlook-undefined.png
Content-Disposition: inline; filename="Outlook-undefined.png"; size=31166;
	creation-date="Wed, 18 Nov 2026 16:56:36 GMT";
	modification-date="Wed, 18 Nov 2026 16:56:36 GMT"
Content-ID: <1221b77f-895c-4304-8f94-405bf53f55f7>
Content-Transfer-Encoding: base64

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

--_004_SA0PR09MB7017E1D9AAD585327316F230C37A2SA0PR09MB7017namp_--
