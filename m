Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473A9C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF1DF60611;
	Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMBvLHlxxauN; Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014072;
	bh=XV5WHGrqyP+MdXel8Wp1eqcDDRjbICPVPruW8YVUFf8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xa8iHNM618Bcw6/0GbASv2Hv/4gWx1uKFwEqg2e2z4BFzNFQau7OdztIjC4KVkvi1
	 AtFXZYjOzpzEJvE6YR6lbxm4gsccYLnW2xjSE+9U3XSPFlE4INZBNPV3/CyGhUrG9J
	 +9HzpJuw+7tb/fLha4pD6qyBeXVoDDVhGK/zDP4zPvEtu5e2lWOSHjxE7BXm8NV/h6
	 OxS51PJ8lTsVvELXu5ZrJ6YhFWtqioLKuRxwF8Udmy/itdLB2vI9SJpAgsB2GISlhP
	 PKP0v9FaOzJmUvWVmVqqC2vjmK/T2/2GXP+s8D51NmsFlJ4JtlX7Kx0PfiqGhR4uU6
	 jOpwMP8JclSfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1E6C60607;
	Sat, 29 Aug 2026 14:34:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C5E0118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79D0380E78
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k59Nx33D2lJ1 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dL8LRej4; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WUTL/6VW
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2B1780E6F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:27 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxmcj269957; Sat, 29 Aug 2026 09:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XV5WHGrqyP+MdXel8Wp1eqcDDRjbICPVPruW8YVUF
 f8=; b=dL8LRej4nJxuhMEjjPix7SYiMjI5nu2DAwDWvyTXV9PVdFa8mrXXZujh7
 7l0S7J71RqYg/lr4gtO1otcLIUHkaDn9afNwpU7sOCOqsd+UuiOUxCePdVif99Ei
 L6tCEGy1tveCLMYEEcxGVSLnkLJ98UlYlu015U4NwNXUPJsd+Zu4WIifGH05355J
 zszMeNV9mQFSDZR1UvXZrYuF6wum+rSAgZL8l8FQMaiFFhQCUg4RFOz5ZvzzgGAp
 N11KlXnzoKaT9NYlhoaKbBrLTTGPgrniv3n4AVUdRmK2b6EKYI/UlniSH7NozwfS
 OuGt6gbZNpIBG2NvEoMerLi/31K8w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrt0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMtTWmrHrxIPL+9oBdAA76mMYp+1zQncsqV8IKNBgUppSKc8LL+9JtwC3rdACbNT0HYq1hwb4YiztoPA9tuR1uCMpJ38jlvcP6bXvx2+u0LYADJSabmgwU/EYUr1Xb5/gnk1vms7GQ2iNxFNA5435YszzUWjVwpAFMQLuj/htXLhXWZG9pbNEDPkF5cg1k+xMbKCm0DouYR4B/MAVnY1khLUDFEHUeJQYxzY/pjl8C8kK6ZW3r72D8i4nI0KN3vMbiOlKjNeAABkLtxeog7OmbDQGrtU+sW6077xpRrFMSGMZg0VIqM8OldFrMu3sc0mo766vsTbjRuChj18QCwyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV5WHGrqyP+MdXel8Wp1eqcDDRjbICPVPruW8YVUFf8=;
 b=cP3fBsE1d9++SLpQ3ZvWUkaU8spSKExqPf+lv55Rc1hQRb96ZOPMFJ1XA0mHayErN4m4jBrV27fwb5z22aFot1fosqJZfnTxdQE0N0zHrJxrTbdZ62OWISiERidIWbHHQLO/7A0VddhzJy0GfYlru/fOr8xIKdPEhkXRJemWy3lJOo3iroB7TYD5KVV7e+uA9QYKkke1KE7FenOCvbaIC/rs6dDKslJHAEAhS4bbY9h58gyDn1HYO4lkVrW3zsKj7lSSjN4HDWT/g8jjdb5uhza/jBHCUs3volZLcAu4/9BsFO0HbD8AZ2NlwaAwyco8c8akQCCV+rnOS/4zRXc1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV5WHGrqyP+MdXel8Wp1eqcDDRjbICPVPruW8YVUFf8=;
 b=WUTL/6VWfH0mgwzc+leFicq9h7rHghGzI64mLCNL00wYfl2pzHIZqSWNa1V9YXabd5wSmOpL+4iiCPAAxU7oAF5CsMvbvAZiSxMNF6nk60jZYB0hjCJKzEPWQFj6lxhStZX65akYzi50RIEJVYAwKC168i7q0D93UOwNFItpMdI=
Received: from CH2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:5a::11)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:25 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::45) by CH2PR08CA0001.outlook.office365.com
 (2603:10b6:610:5a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:24 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYNYD1551066;
 Sat, 29 Aug 2026 09:34:23 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:19 -0500
Subject: [PATCH 01/14] board: ti: sort file entries in MAINTAINERS files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-1-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: e77b2558-1704-410b-52bf-08df05da9f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: pv50/1fuP+TeF5aBXvvhUI/0+KXHwn4MJt8BYxkFzQfJ28SvCU9KDrzbc+XQNKOEvxGFD+WexVh8O9vlNDQiWLbMxuwrc1NHkb/Mz+hFpIydhVuFi1xys/vsLNr2WTrkLSJ93tEYgRw7qe9Rp2DMOM4tCND18k1yuJ/o5N37WfpwSCDO2q9dTiMUgiIojOmVjlpQXN1OiaFvlc/itbK52jqPoXCJBO5ybuiZ6uvq1lDNEnuBjZ6FMnrCaH40a8XWzXmxwGn9e9/HcgNpMl0/kiQiQjBPWHFwCDWUs7DmpwPNReyeYXxxApiWcsmcHCPdiZDigZ4kIGogbNwfZI5nZyZ+EDKNiWojXMA4eG5W8gj26QR39Fdhbapfk40QF9l2KnnJluW+mUC57EsRtl6yhMqlsH6bgi3LFLVBWK8xf2vWDZ0QIgbTwtG6oeXkZkbv6G3VNGIuWSC6uXroqGRJ0N77u2OWNgm0Pe4XpSMRiMfzLp6MVaP9ZuObymcwExDoCwfNkt0jKhb2JP6/2DQ0U2/iAbIT9TyQYGijjtFMHy1UT71HsVV8u6HKA9EQ/D+cHA8Jpt7KavN6tOz9H2Y5V9rrBoaUDeZxSt29b3/kcZwIHoU6R8JWmezCcQn8wz7HF3UmbtKchth/41OOTKMIBJ1e9xLC4qBgIq8JEfT+dz90AvbjIq+jambZCKTRy+cpszI7+s++OlsOEvYdpqAkBg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3HoDyzFxcUZ3XYJXC0revs2M0xpTnyynq35JzFyv7jPdj5SpdgAPQ0tErHuwa+z6nZFx8rTxcC/G8C4qgXE5ZYOp2gtabY81cmYoSVkrk/dfVcHqhpkLTiH9uDCaSOm/jhK7UJX/4QQl51z84+mZN+BrCbQ6XIDzQC/OV5N1vKm9xRqstkc9o+uWoYfQG047Swu0bLgGnJZcI7bi/UwcmisozXUvF9dgLOcg5K/ewI9tch59hTGIPiQAFfG5GKT+aSRxRbnFZ47L7Vdwd1ZAP3LgYB3g+K0MyxOW/QMc7A3mTb9+Y2iZ3l/44jImHfopZ8DyaDa7ehmhPb5g7WsHwmJzlpcG5l1d6JHlfwDOuawhOVzJVhLHhwU7SHQTyzrH5FRdZmKK6UW+nLMGBjZwxepQ6QKFIHE0ZrUsQu011/8aXkV0kmQmFGHaXZAq70O2
X-Exchange-RoutingPolicyChecked: CoEw1+boaBIbzJWwPlCb88YQgJgLNpfHLCvIQRuNLNwOCEtpMzyrhPcfgmHw510rCMNrxka2lrRjBj5jfiuiO9KwmQnj9bbUwe/cBdl9No1WOB3Y+AckKNkXAT222ygBiPVNdeGgvJRsmOqGFRS0fuYMNX223EhJKNFGRMIoRTtO1p3KFe1qSeXTKU3rzW/IRMdPxYqvg3edNTgq4RzMA5WPIkX7hnYNdR82uOWFTk9CTaqSUwKJVO0WLsvywVoQQM8CMg0nGb/RxTKtzc7bUCE1BljGYF+ngBoNzn9HFB5clejQu9oe0QRKSRaG2Zzy06jKl6Mriw2pMlfx78STmQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:24.4391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b2558-1704-410b-52bf-08df05da9f68
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92edf2 cx=c_pps
 a=v9d8l4VwGb/BX2RVr192eg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=CIDiaIos5ih4xEVTNE8A:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: rzpmdEb-peRVl9te3L2NN7wH80EpU1Ek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX0BkoPOxa0lFO
 eoYmogk1XGsZdUuiWbWUVqoneZVB6kfcXcJWkxXBAS5mnvIL8YUrSgimCa4hJN6AYEsUzjQtmun
 DoncLLoitm242Ib/SAv2wFwFSo2q3DM6TCC6sS9AD2AxGnz1trbkvrKno0Zl9S9apK9VIunlNQg
 1Ns7/81ZYi1tufWHe4GRonmF2cCx5ZyHIqGZWkvdepxk+vUqvHROJPWtVqnL73LyZcrn4AJj0JO
 h1rP4R0VaLvSNoVF1HIX2YnNpaZ9jvY1ULyOvuyY14mb8XGWk+DaPB+cK2ZW2CqfZTFOJohmZEa
 1FZDKBDlgwkyUjic2VJLjIzFg5ToXraorxDWJc+0I36unUK5U5462sfUVANTZlXVWrHm5Eh0IBB
 mBO/30L7EdxETZ+QY+q1YBZDXuit6XCowHojHN0IiYXZuFqCXx7xtUWLxX8G9TwkUAh+Uazb0Um
 KNGH1kWgh1lJUiFTJrg==
X-Proofpoint-ORIG-GUID: rzpmdEb-peRVl9te3L2NN7wH80EpU1Ek
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfXyq2ihqCSCacr
 C2bdSQKoLwcnO7W7p0Y3ntKT+3JwdW65R5d6T4Qfys3DXlAXLMhnzxu8G/q6ZwRO8RuItmVQzUG
 a+8E2xSYsGnQEZnuIPG5ay60ymz/kOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290125
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

To help with identifying missing or incorrect entries in the board
specific MAINTAINERS files, sort them alphabetically.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62ax/MAINTAINERS |  6 +++---
 board/ti/am62dx/MAINTAINERS |  4 ++--
 board/ti/am62px/MAINTAINERS |  6 +++---
 board/ti/am62x/MAINTAINERS  | 16 ++++++++--------
 board/ti/j7200/MAINTAINERS  |  4 ++--
 board/ti/j721e/MAINTAINERS  |  6 +++---
 board/ti/j721s2/MAINTAINERS | 30 +++++++++++++++---------------
 board/ti/j722s/MAINTAINERS  |  6 +++---
 board/ti/j784s4/MAINTAINERS | 34 ++++++++++++++++++++--------------
 9 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/board/ti/am62ax/MAINTAINERS b/board/ti/am62ax/MAINTAINERS
index bb0de6a04966..95ff5afb2c47 100644
--- a/board/ti/am62ax/MAINTAINERS
+++ b/board/ti/am62ax/MAINTAINERS
@@ -4,8 +4,8 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62ax/
-F:	include/configs/am62a7_evm.h
-F:	configs/am62ax_evm_r5_defconfig
 F:	configs/am62ax_evm_a53_defconfig
-F:	configs/am62ax_evm_r5_ethboot_defconfig
 F:	configs/am62ax_evm_a53_ethboot_defconfig
+F:	configs/am62ax_evm_r5_defconfig
+F:	configs/am62ax_evm_r5_ethboot_defconfig
+F:	include/configs/am62a7_evm.h
diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
index e7af7be35bca..fd5c1c93b7ea 100644
--- a/board/ti/am62dx/MAINTAINERS
+++ b/board/ti/am62dx/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 S:	Maintained
 F:	board/ti/am62dx/
-F:	include/configs/am62a7_evm.h
-F:	configs/am62dx_evm_r5_defconfig
 F:	configs/am62dx_evm_a53_defconfig
+F:	configs/am62dx_evm_r5_defconfig
+F:	include/configs/am62a7_evm.h
diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
index c6c6deca61eb..7747f96104d0 100644
--- a/board/ti/am62px/MAINTAINERS
+++ b/board/ti/am62px/MAINTAINERS
@@ -4,8 +4,8 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62px/
-F:	include/configs/am62p5_evm.h
-F:	configs/am62px_evm_r5_defconfig
 F:	configs/am62px_evm_a53_defconfig
-F:	configs/am62px_evm_r5_ethboot_defconfig
 F:	configs/am62px_evm_a53_ethboot_defconfig
+F:	configs/am62px_evm_r5_defconfig
+F:	configs/am62px_evm_r5_ethboot_defconfig
+F:	include/configs/am62p5_evm.h
diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index ca269fae8803..76c97ffc3b86 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -3,12 +3,12 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62x/
-F:	include/configs/am62x_evm.h
-F:	configs/am62x_evm_r5_defconfig
-F:	configs/am62x_evm_a53_defconfig
-F:	configs/am62x_evm_r5_ethboot_defconfig
-F:	configs/am62x_evm_a53_ethboot_defconfig
-F:	configs/am62x_lpsk_r5_defconfig
-F:	configs/am62x_lpsk_a53_defconfig
-F:	configs/am6254atl_evm_r5_defconfig
 F:	configs/am6254atl_evm_a53_defconfig
+F:	configs/am6254atl_evm_r5_defconfig
+F:	configs/am62x_evm_a53_defconfig
+F:	configs/am62x_evm_a53_ethboot_defconfig
+F:	configs/am62x_evm_r5_defconfig
+F:	configs/am62x_evm_r5_ethboot_defconfig
+F:	configs/am62x_lpsk_a53_defconfig
+F:	configs/am62x_lpsk_r5_defconfig
+F:	include/configs/am62x_evm.h
diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
index 626141367a57..3d05910d1bc8 100644
--- a/board/ti/j7200/MAINTAINERS
+++ b/board/ti/j7200/MAINTAINERS
@@ -2,6 +2,6 @@ J7200 BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j7200
-F:	include/configs/j7200_evm.h
-F:	configs/j7200_evm_r5_defconfig
 F:	configs/j7200_evm_a72_defconfig
+F:	configs/j7200_evm_r5_defconfig
+F:	include/configs/j7200_evm.h
diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index 19199dbeadd5..dc0315b1c407 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -2,8 +2,8 @@ J721E BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j721e
-F:	include/configs/j721e_evm.h
-F:	configs/j721e_evm_r5_defconfig
 F:	configs/j721e_evm_a72_defconfig
-F:	configs/j721e_sk_r5_defconfig
+F:	configs/j721e_evm_r5_defconfig
 F:	configs/j721e_sk_a72_defconfig
+F:	configs/j721e_sk_r5_defconfig
+F:	include/configs/j721e_evm.h
diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 96d225a3ac56..64d0553738ed 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,20 +1,20 @@
 J721S2 BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
-F:	board/ti/j721s2
-F:	arch/arm/mach-k3/j721s2
-F:	doc/board/ti/j721s2_evm.rst
-F:	include/configs/j721s2_evm.h
-F:	configs/j721s2_evm_r5_defconfig
-F:	configs/j721s2_evm_a72_defconfig
-F:	configs/am68_sk_r5_defconfig
-F:	configs/am68_sk_a72_defconfig
-F:	configs/am68_sk_r5_ethboot_defconfig
-F:	configs/am68_sk_a72_ethboot_defconfig
-F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
-F:	arch/arm/dts/k3-j721s2-r5.dtsi
-F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
-F:	arch/arm/dts/k3-j721s2-ddr.dtsi
-F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
 F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
 F:	arch/arm/dts/k3-am68-sk-r5-base-board.dts
+F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/dts/k3-j721s2-ddr.dtsi
+F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+F:	arch/arm/dts/k3-j721s2-r5.dtsi
+F:	arch/arm/mach-k3/j721s2
+F:	board/ti/j721s2
+F:	configs/am68_sk_a72_defconfig
+F:	configs/am68_sk_a72_ethboot_defconfig
+F:	configs/am68_sk_r5_defconfig
+F:	configs/am68_sk_r5_ethboot_defconfig
+F:	configs/j721s2_evm_a72_defconfig
+F:	configs/j721s2_evm_r5_defconfig
+F:	doc/board/ti/j721s2_evm.rst
+F:	include/configs/j721s2_evm.h
diff --git a/board/ti/j722s/MAINTAINERS b/board/ti/j722s/MAINTAINERS
index c97b3661e0ad..c5054084607d 100644
--- a/board/ti/j722s/MAINTAINERS
+++ b/board/ti/j722s/MAINTAINERS
@@ -4,8 +4,8 @@ M:	Jayesh Choudhary <j-choudhary@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j722s/
-F:	include/configs/j722s_evm.h
-F:	configs/j722s_evm_r5_defconfig
 F:	configs/j722s_evm_a53_defconfig
-F:	configs/j722s_evm_r5_ethboot_defconfig
 F:	configs/j722s_evm_a53_ethboot_defconfig
+F:	configs/j722s_evm_r5_defconfig
+F:	configs/j722s_evm_r5_ethboot_defconfig
+F:	include/configs/j722s_evm.h
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index f9fe9a9f661d..781b16ee013c 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -1,34 +1,40 @@
 J784S4 EVM BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
 S:	Maintained
-F:	board/ti/j784s4
-F:	arch/arm/mach-k3/j784s4
-F:	include/configs/j784s4_evm.h
-F:	configs/j784s4_evm_r5_defconfig
-F:	configs/j784s4_evm_a72_defconfig
+F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/dts/k3-j784s4-ddr.dtsi
 F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j784s4-r5-evm.dts
 F:	arch/arm/dts/k3-j784s4-r5.dtsi
-F:	arch/arm/dts/k3-j784s4-ddr.dtsi
-F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/mach-k3/j784s4
+F:	board/ti/j784s4
+F:	configs/j784s4_evm_a72_defconfig
+F:	configs/j784s4_evm_r5_defconfig
 F:	doc/board/ti/j784s4_evm.rst
+F:	include/configs/j784s4_evm.h
 
 AM69 SK BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
 S:	Maintained
-F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
 F:	arch/arm/dts/k3-am69-r5-sk.dts
-F:	configs/am69_sk_r5_defconfig
+F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
+F:	board/ti/j784s4
 F:	configs/am69_sk_a72_defconfig
-F:	configs/am69_sk_r5_ethboot_defconfig
 F:	configs/am69_sk_a72_ethboot_defconfig
+F:	configs/am69_sk_r5_defconfig
+F:	configs/am69_sk_r5_ethboot_defconfig
+F:	doc/board/ti/j784s4_evm.rst
+F:	include/configs/j784s4_evm.h
 
 J742S2 EVM BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
-F:	arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi
-F:	arch/arm/dts/k3-j742s2-r5-evm.dts
-F:	arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
-F:	configs/j742s2_evm_r5_defconfig
+F:	arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
+F:	arch/arm/dts/k3-j742s2-r5-evm.dts
+F:	arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi
+F:	board/ti/j784s4
 F:	configs/j742s2_evm_a72_defconfig
+F:	configs/j742s2_evm_r5_defconfig
+F:	doc/board/ti/j784s4_evm.rst
+F:	include/configs/j784s4_evm.h

-- 
2.54.0

