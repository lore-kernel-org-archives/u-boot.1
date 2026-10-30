Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E48606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tSjr8quh;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kcLYS28O;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RhIAueVR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7702E8116C;
	Fri, 30 Oct 2026 14:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXErpak84uie; Fri, 30 Oct 2026 14:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA57A81167
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793368901;
	b=RSj9mDBXZJ/k3HI3rrNGsq9noyAmwRaji8q6FqsTle63duovdCi+kgQHixoNYC/nAqIa
	 nQEjvZ8wwKOHeet+knDhZTUmAAidGcOU8u//SxViDqDeHYUwU/PssBnt/s0k6fge8HRve
	 z7fb5T2kVISJC0XA/2sN4dycHEGzC7Rp+q7KKwCl2c4AvFdSvhNEV0CJsM6mxIPpJNswr
	 DGGZaYTCOt/AwY8495nhihp+75RBSkhyXcothDvoiA/KYkB5jX10x2s5PRXj5hre7sf0c
	 1NOSPlbltNXbmxMgbKivgMXqkd4ObnaoijOMPhrJDOKvjEj4njsWOXGI2HJDWkY9YSA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793368901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u2BAy1FAM6SJGy6ojq+9vmL3/L+WChhS6fmiQg42L38=;
	b=FpZHxQyruSVdztfAnFz2QKk84vbA+nuLr+9ETCODbnxJmwFYEN2qw1W1hif+tb+mM5Aj
	 Up1Uh1NkArq6KYHCLSMo6A0yZGvWDegq/Am7jKozw044hYwhZnet2lZFzgdfe4UC4ufb3
	 bPN8u469qBbPzzyXzSBQaMRsxnTntJ+/UaMik1NlsjKzNIVuA/7X5pQf610ob0w9otqnf
	 tQbDBLf2h3r0mEpz+RVpPD4Uq1rvcVA2IhCFAmYOTzsmRL1LnNcFxUtwKNaATa7NPYLQR
	 gmgjeRmp994NE/T9GEu9sN3bMYnw2z2GEmuM/we+liOVMGE9ozmPQ+F71da2QfF2rog==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kcLYS28O;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RhIAueVR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793368901;
	bh=u2BAy1FAM6SJGy6ojq+9vmL3/L+WChhS6fmiQg42L38=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tSjr8quhBYWdaabX72mkmtVCpZER6oOLBoHm86dUF4RyJKhehoMw/FkD879n2RwfP
	 VzHsnzkJFarC0sDWMLQqZCqdAgWdRgAn7Kkt9ow/d4cZwAulKqSA3UCi/Y48Am5J2E
	 JhfT7Uazife3QzNHGbZpxBbpwnna+j0ffWmwS9Z9ZTTNjsfPOHoYEzQp4Y0wRgbsT9
	 GJFKKChvx+8CMDBTxRYFoj0x2ROi9+dn2TvTQduuKGfMPu4Wme2hjMc8+kYiBkByEJ
	 lBiyw8a2+jGGbhoAwSRmov8JSYS7o7CtpD73aN2quRn6iAYWyvRxmsLA78EKGDfS+L
	 Whh70T+gKmzoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA57A81167;
	Fri, 30 Oct 2026 14:01:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B8624BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D32481167
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeV7Hov9GK9L for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53E6C8110A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793368898;
 b=XjmYMILSOHDl7xRuq11YUCtaui2SgMZ8eesA2kcABt0PYMBAW5lIe4sMgFeRvfeJCcsk
 g8sZBn6rC0XopRx1mQfjlO1r5g1Jnv/PCq6nvXrs2S+2+eBvUcULug16GJUV4Prw6uFqN
 DKU45yBAITl/WW5Xq6kA9PvfcYccT7Im5LQcX0Y/pHowQrQgS6oLej0L3BTrHNYPOxZ8v
 qEj5GJwWKjn1u18wTrUFls35MmtFEBs/5xncNdHagDxGAdNaKZVqPS+9F8kw0mD9rSRbL
 96CjmjCnZd1rbTP83C7ceKRdIqtqMIxfTM1yORb0gUiQU1EnvdwReDQrpmMoH4g3RqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793368898;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u2BAy1FAM6SJGy6ojq+9vmL3/L+WChhS6fmiQg42L38=;
 b=nZSz4EwZQFx9lap+gre+7scJPkM+P+lDs3mXQdupSLIObNCmwmU9s+Bs6NSQSStICS1y
 2EwBnGtQJCJO3x+EHQgfmbIcdRNFxUj6Y2zs2kcRdiLh8DZ+HJbOyp28XBKvjrAFav3aB
 eHzZG3GIJQKAhoE0GtTlpdmXdUQx1jgj1QxRUAkQP4Foe40dGiao1JIvrGdZ7nXP5MgJH
 1CSnRNs9dlF236T73cEYGaBl+NRfc4Ng8CtrUblNVMZAP667YAi/bl9FAWH86gxMnMxi+
 ZUVFV4Sl6tUvEE16T8imkQaNL7kHw5vL09w7f6eEmfU9WOneu6gSgBfcwbkus3b2KFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b=kcLYS28O; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=RhIAueVR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kcLYS28O; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=RhIAueVR
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53E6C8110A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:37 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGmeT3932094; Fri, 30 Oct 2026 10:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=DKIM; bh=u2BAy1FAM6SJGy6o
 jq+9vmL3/L+WChhS6fmiQg42L38=; b=kcLYS28Om/C4L+qxmmnu+V9qEjv/Pr9o
 JcWWEjxr04gJn2qE2Mgt9kIjnqRF9Vnuy50EAKecRL8zB+zqXAJ2K5d/jFCYFi8L
 lbV/p5vYXc1T8FOHLyi00x/jkVJpxFbI+ylDvWqYDxi9BjOn7UvWJ3Nr/5Xg4kje
 zU/Zp88atFOCjaefplauYssVHw2BBfJoiHUArS0mFqvDUUMvIk924RsquEFSMY9r
 u3AYIvc7gVmiF+LpCxgwodzEKK8Juu1bzEfPWtmPIjpi+E1M/VeoM5JKcrXh05MZ
 JbXJi6XIhiyDGcJ0DyHAtD6RYpWrcrZgSq+1uT6hVPW0b+yjVxu/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=u2BAy1FAM6SJGy6ojq+9vmL3/L+
 WChhS6fmiQg42L38=; b=RhIAueVR7dRgFqdi7p2ivQx0vo3cOq7e27LDXSmYsaG
 Y0iuvBGACIzcKbDIbFGNr5PKawNUyh5raboc1ebdb3LMdUPv6NGEFMMGkyi4dzFR
 sT02WNXogd3qMNJdyVIH/Htghe23jg0oDWAMuqjWpaR4jtarIhYA86JWL3yGmwwf
 JVMUzIh5UJiOB40NaR6OcC06xtoAFqPH2ErWoTTmF4WFRpP+bw8DwwlLT6mACvcb
 w3wac2QByaoO9zB0gYAOWB5eZ57BIACrGfhBDJEygO24p5p+ad9fcO0L4nkYRv/b
 FYvhIlNB1+W6uIn+FgjWCeEyRpm13FFpwkngnITWAxw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4c22-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 10:01:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaYUS/kK9mnL4PMeW7XfWSOv1pTyNEVCqTVGoj1sClmshsLfOhvmowY6/OGoUUo/Qf9cs8DejNJUL6ccuC38pdjnG7KH9DUfCpF997EI6lHe3d6chMqG3iCoNLAKx7x2Im4XBzkIgjiuZ2x09NgLdJ/Ok13xQ+DOkSFtKXPO9bTkANba2750lrg7rrsPJ7TVIKD0+Zy/5mbR98n31aGSVGmHXpvg5UkPYUfi536gHDFiDX1OHldJHofQ/5WKvV1pp4M/FHgUk9gJFhNwzk0hCwQhkfg9eDVJl7hh1y5M+KIxbtE/92tOjM4XTMtcfFlpkEkq8rTyhMkvNTsRWKPCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2BAy1FAM6SJGy6ojq+9vmL3/L+WChhS6fmiQg42L38=;
 b=oRzojrxb0z/pGJzWoB6sN05dKAOov97FMly/wIAvjBrZ1iaEyV9jyRcoPY26/W9dqVdTlIktg64/4ghjnxbr7AqUNa8W3YXOo+fVijm/qUI7lQsvxckv1+S0a+q50Zd2X5YeyKU8i/jdCQsVgnTu/idKdtVYR8Jb/xGREghkivzqUpSZ3J7dTON2E++Ske1W8j5kQrCLYiAzdduHyPpXb90znM+9gUrlZV5v3h8DOanP4YnD40ytK2mj9IsBFfxYnNtP14NVr7nzkEvjmXZWAA+MrcHcUjzQ9E1KA2eaTX+OCnBUPG7i2O/kxGdEbRYW1s9OSp24WgoRiL3VbDzDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH8PR03MB989600.namprd03.prod.outlook.com
 (2603:10b6:510:408::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:01:31 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:01:31 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 0/3] SC5xx Carrier Board Kconfig Cleanup
Date: Fri, 30 Oct 2026 10:01:19 -0400
Message-ID: <cover.1793368074.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:610:e4::15) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH8PR03MB989600:EE_
X-MS-Office365-Filtering-Correlation-Id: d1432f44-d8d9-4d6e-5c58-08df368e4cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|56012099006|11063799006|261026121527099003|10067099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: I0DQnl4owU92j+K5ln4QHIthD3lZMyyyPzlnh+FFvFt1QsYSgP/djeST+FNHp3g7q51Llum8H1xq9wrR8vaefWfOjbNjDw6+bWACqdQjIjKbjlTX44/6lIsfcVnyC4fVyo37eh+L1VS0SmBObxAGTkyLG+3RyYd9Z4C7hl6+s3H5K+GNInZwmPHq21kGd+iW4XYDj4hhEkbfzbOHwDPDF/IqV4n3jaZx3flVFY/6hZ8UgzJGUoBb1pXvYG0LU2lls84JDP/2+GHqMm3uDByQEZ96a+tTAAmt+/FHm3TQyimXGqIiano9M3Y89+2XuCm7PKlnZGU50BSlSByWPlqQaN4wOdh40RisJeirUkHYQCLNd0kRf/lxUHUih3BAYg5tzPqcrKy8DAeeYnPIZLMLmVmhrlOQt+JclOFiRdQpHO3J2v3OspHG1uacG4GkxIT0YShRFfoWpQfG1gz3sP/vwh1ijLSOtolL1hZj5Lx7t7PD33J79F/WiSfD6vAgonHgC2cjh9JI5uggC8QeMuAn15WYChLYmxcT0GZZL96RO0LoxrC6Yo2NM2FTlsUb9IMwfX4K/vvHB2x+XpNOaBMDHWks237RHO5Ltv5Ud5KAzbbkZPyzR1njZv3ABm0rxkunRT05mQi5NrwnM60vcgisLRXWWXGyJHKbM1l781EHY70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPb6y3+d8mssEL9LiBZDtsRf+2FKiujaL/Ile+A7NrdefB6FCdk2LcgEfpUg?=
 =?us-ascii?Q?PMzAAzMZwl6D93qK+52rwfR9T1OOsQi2GMIpVIwxXoAu1iY9zgRJZIC24vvw?=
 =?us-ascii?Q?NyU4P2ipRGe8FlGbFaLT0YDbP1v6TkWDv8+qJduuwun5mkhr3EQqrpZMkHUN?=
 =?us-ascii?Q?LB3qMVEw5f4+fRy/y4RBwOxtbfYs5o8QF4sIWNt+SAlvYfq8ruCRQRXhJKxS?=
 =?us-ascii?Q?o+NXOjf4sSAEFLtnP0CRnYeedDDsE8VNavfd9NU/oGKqRhiT96BG1YcB7XMs?=
 =?us-ascii?Q?jSCdZfBtsd5aTa2C4m5I1SLIe7SqxEqkPSxVAncaXb0DG734OKe3JLDb2/JP?=
 =?us-ascii?Q?7z/aXW5piNySkyN62EK/3HGd8TkL8T6wI/y70EFFcBSvMWqkPqi0UUhRk9c8?=
 =?us-ascii?Q?8USlIMqjH4C4CudUhxoTccm4rL2ZxMpIHpKc5Mkqt/+insOkE2SJwk4tAjqu?=
 =?us-ascii?Q?1wGeNtSqEU4OX4xyFw8i71gRVt4Qig+4mRrkOWKdWbd2lYSTDjAoqkQOLcO/?=
 =?us-ascii?Q?oU+HcVRHA7BeFC4awGeNUhLbfmq484QbO6KaCd6Y1bcfpjisyEUgp5gJq57j?=
 =?us-ascii?Q?SzzXOCND14vKeN2YNPfUJW5xBcsFWqMCbAnTeHzbR0FJTf/GiG65TCKlktxc?=
 =?us-ascii?Q?MlkdLqWCqMxCbeGbSdCIOW2S2stlhZqLaYJtP3TJ3jIbe1782BibT4Gp6pZz?=
 =?us-ascii?Q?ivPYTy7X5eggX2p2eflLxCFnms4nsPzNzmH55r+UlteASa0JiakYJRvJlX+Q?=
 =?us-ascii?Q?q78TZlYeZl5djRvaCtxEckc86Vvs9Ld9sany1VspTRCcxFIDkL6Hfl0MV2kG?=
 =?us-ascii?Q?rKnlJwWMb2dKUKVjKhxgRSAVRkk/CMGwULIgCH7BvnKg37JkGpreeZroJ3KR?=
 =?us-ascii?Q?0qForJPutCg9O0bTnyelljp0iSyjslFDKk8wJM48qIE3lHDKcOCsL8+S8/y/?=
 =?us-ascii?Q?tKu3VT65ZnS7LjMhKbxU2IiLQ4AvLXAVZPEZSrbR5zaue2eBB7RRfJarytyE?=
 =?us-ascii?Q?tkfRwupDHiRwcx4yLaG0mU26pZa10NxiWnsdMD6BvyNhmLxGieCubo37Py3/?=
 =?us-ascii?Q?NmQxMmZ+Kai2HYRyo9nMqz4uzsOLxZT2rTb7m8PFT1BFfEErdwLMOqAlWIyh?=
 =?us-ascii?Q?LClCIGBVbNNcgOPJS7aw9N55+/eWV1k1Z6qURm+bewmFHxOfSvX9tH3E3Hnh?=
 =?us-ascii?Q?nXFZnlRmgMGs+yWa23bYYr5EvKGm4c5CoaCSDlvZa6Wfz6CzFDbUdqk0Rz09?=
 =?us-ascii?Q?6w74kvoB4skh5InrDHhyaKLSX6M2knIuWuOj0JrJftNMSpOOcDzGCybPGXTm?=
 =?us-ascii?Q?jwxlXO3sGh6GlIGJfnTIy2aeWkMdoFcjTt0lL4TG6us2sx3aG/oSW7SQkg3J?=
 =?us-ascii?Q?Qb5zZUU0yMF1QUY88HtdCc2PO/ypeAt0kSEyYC2XY9mmTeq0ndQtubP2aZps?=
 =?us-ascii?Q?15f6yEagUP/O/6U37KcYzXXJgSqa27cWSL8kpxO55OcvMjV0mfNgzZLsYhqx?=
 =?us-ascii?Q?Gel06oS+ELwh+S7ZIK0tyABqSbiJmSYC97UT3Qt1CTY19o2vFZAFgDjj3Tm0?=
 =?us-ascii?Q?kV9kO16KlBytqdJGBZMIivq2XqYsbgeEThmJ4V4UCQw9MCgTv8W2lAPm3xkr?=
 =?us-ascii?Q?IYQ3L7/OyPdwjTeE9Wex8TZQTZhLdjdFrc4ayS0SaWys25SD+66pxi8vChTh?=
 =?us-ascii?Q?8uzdw7tHYKomqCDKrb7SA+bIBb9oe62Sgoiujlu+8w6Hrtv4Z4ycUbVlYmKf?=
 =?us-ascii?Q?us6Ol8SSIANy7zW4BiKALThXJROccz0=3D?=
X-Exchange-RoutingPolicyChecked: rFYq36T0HpGGT7dC0aXy6RBWnx99414lR3qiSHscVkoJiv+p0zQ1YwXq2209rrJZn3/PrdHOENrUzUvhy+NNXFmRNh6j2/S/ELhbKui/RDWKPM8Wq6PRh7Vf22fIv+KalHdgwIDudque8esOt9BfaUjjdi7V2m2u61ZN4auMApcUwksGY5gzrkpAZPZ6JD1DAtd0pOu24WAhdcRFq91EQHRCsygg7cCB6TC0xx84byuKqCNi4+gpXgRIe5+v9g93/trCQhROP5QhC52rCUQMf8CdnsKlG7+EwJ6rJNAsVhaYMCtV5Q2TeKeEJsx78x5X4x8mdQWhQW0fnQ5TNffFxg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1432f44-d8d9-4d6e-5c58-08df368e4cff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:01:31.6223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvZNbgXcGxD1hJdZ0mcbQJ96/xmjqLyueejmDw/Nn9aKBCFGsRVOmPOatsBiat8YFljli/84eYy3BZ/t6PRsNz7ydLVqmejTqey4OA/a6hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX1MeinsfKZn8a
 7ybv6r6xekBfimYCtojIwdOGDLSR017umwQTHgd1o50rdQZnGO02VI/RWj6tXZsjOyH+VCtOdYX
 sOKH2/d8ciMb8B810hCpbo9kD5ugTo6GcaxPlLO9fCzpDeKBHOInBGt7wSY1yC/Myu75WQTrTNy
 VGnaAZfYijmwcXsik59Dgr6DMNabhfUqg8Tei+gpcP5TbDqT1J924BaulNIdnKTipwM9Bcm5MFr
 xxH7AKU4w8FjjcNQMAXK/H/rXnphGkKq80+amaEs/dgSIY1Yb2Hc0SSQtzxgDdUCv1CWEBApbRY
 oQyIugehD6SNNhJiZqcmZETf8e57XDsa1e/XDyjSlV4A5XPdc+iNMRXdKhdyQNR4Fa8Jy+q321i
 gETFKUIa+IBpDtzt5IJKi5lrFmLawedos72YzgBHNvXvks1cwlzJR622IHJya/UssYj3DsVj0PU
 1Xv/0b3B/F8hgldZ2XA==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4a33e cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=ks5pRECwAOJaFs5u3uQA:9
X-Proofpoint-ORIG-GUID: -pgDet6MP5D6M-bVLAZVtOm2xO5TKS49
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXySCPWmQlbfKY
 FVlgNomm0epbf/+dA/ylvMhdf7sLxW6NY13AHtGzTjo0wJMZnhMKxk2S6S+fpSZ0+PS3In/E5UU
 VaJhS14T1wneBmw91zKM45qXSjvRtvBunAEc77fzdh5OTS5dN6J2
X-Proofpoint-GUID: -pgDet6MP5D6M-bVLAZVtOm2xO5TKS49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Caleb Ethridge <caleb.ethridge@analog.com>

This patch series does some small cleanup of the Kconfig options for the
sc5xx boards. Common code for the SOMCRR carrier boards is now only built
when one of the carrier boards is selected. Previously, it was built
unconditionally which resulted in dead code.

The series also fixes a bug with the sc594 EZLITE where it was being built
with the EZKIT carrier code, resulting in the Ethernet not being set up
properly. As the carrier board Kconfig option was a choice, the select from
the TARGET was being ignored and the fallback was the default EZKIT code.
Carrier board options have been changed from choices to bools so that the
board targets can select the carrier board properly.

Also, removing the explicit carrier board option from the sc598 EZLITE, since
with the change to the bool options for the carrier boards it is no longer
needed.

Caleb Ethridge (3):
  board: adi: Build SOMCRR common code only with a carrier board
  arm: mach-sc5xx: Make the SC5xx board target select the carrier board
  configs: sc598-som-ezlite: drop explicit carrier board option

 arch/arm/mach-sc5xx/Kconfig            | 26 ++++++++++++--------------
 board/adi/carriers/Makefile            |  2 +-
 board/adi/common-sc594-som/sc594-som.c |  4 +---
 board/adi/common-sc598-som/sc598-som.c |  4 +---
 configs/sc598-som-ezlite-spl_defconfig |  1 -
 5 files changed, 15 insertions(+), 22 deletions(-)

-- 
2.43.0

