Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D015606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EX39f22X;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=unVGJC5T;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=fntV8FQE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BEE1607A0;
	Fri, 30 Oct 2026 14:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F24athanmXJU; Fri, 30 Oct 2026 14:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FC9060808
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793368903;
	b=jovr/Mr+d897lAOeo/SJkDmmj53BLYjsAIZflyFRn/EDOHOkGe2gfWYkiPABdCdf71Rb
	 jvZS7JjPZwXdDww5rK8MdU+lyS94Z+Z2kP+qtU/719pyuvjJGoGmC/QvnWVCdl7Ado77z
	 oukK5EJAhIBwNn27lfaD6d/4MVSKnVLhaftR12KCMTirOnCMoUXWuLrK/7L8VCT4JgGnc
	 zUK9qV1zmonkM4VkSfda23RzMUDxFVMQa8go6W0I1B4mVBNURBbNJ3gH8oYb/6doca1sc
	 u7fJx+KeQDNQvkDW/fPWLI2Z5XpknS6NyguKA0Rxh6xhrx3nw2b6whvGkCW0YtoHfKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793368903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ICHL8VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=;
	b=Sq9Hu95OH8ve373DeWCZif1B2CU9du2NLYN66oQKU+mHDfxLSveNe3xKwtDcMrcY414u
	 X093q/Bx4AD8mV7pi1oSR68CKRRkdNwf05RFklcIrvPzt/+NqtdqQ8ksBN35iwiR4e9/j
	 Sc3k59Hh2j1FeRri5y0Oj0rNMq6lUfDvBA77TI7nHylpxGPlbv2Tmuj9IsaKQa/npClqa
	 Qwr8JgLx028dmjBvUpgHZOysBC6MP66qua7/j9h9QwXeW/IGQQIzt8a6P+q1h9Rpldrqb
	 II4CS1a9rsvY2QnCSErcR/HxesMtcNpNQYlTc6U+tm3DdHX1ZmKEpDY0J1yJ3FtWlcw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793368903;
	bh=ICHL8VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EX39f22XaEtVeEmjKWNEDRJ/b7ClaR0S21ibUMmNy8UiO/trIVnPanJHcaGoqqS11
	 75CZxH67fnTlB3ntnuWfwP7DMCFcPvcypX46xh7JoaUdYRnE3Alb285ypQHlQymEID
	 0HvZ2rZmihb+ZQN179WD0LBBK8zeBnumrWSJlDYIQ9phIjQgrHR6eeSj1YlvIx927u
	 tzfpXmk79IFGMgFhbap+VMERqz2aCxJ593BsGHZteAPckv6etxeq9NFeZxS3JMNNtR
	 vTX8Ogyh9vvEONsMf+/lbTBoZJ1NMbIIgOi7X0a/dblROgR26Ctw6TJ/i5kburho+a
	 AqBE3HKzR1UFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FC9060808;
	Fri, 30 Oct 2026 14:01:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B6A14BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D05040AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOyGPzI3eteU for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D205940AF5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793368899;
 b=F3ryCmmtw04j6lmettpxUzaUBWED90pR5QdHUDNTTbnKr2YQqR/FzDaj0ZY2Oug0Y3Zh
 4JWgEcSd9U+23LJHr14XZMKxvVBfq6WYTx6+JhUXLTPv7Ys+TIeGTIiVknxjUGMjBEEvD
 r/53ltmWS598bxyuB7/oroeYr1K+tI3sAugB2Y9/mFO22YR8Dw2nV8vTnoUKy5gXnSapJ
 +wDST51HvTuhIYP66R8TJjELZKhmpYI4RIsuIkR9cW/jYsMl3dftOcNFdc606u//RaFmw
 sdqFHtglTk4MDZhFQJgh0SUdcasCrSByPn8SLZ0VF4L8Yg2DjB+BV6EJRSfqg2BVjqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793368899;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ICHL8VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=;
 b=WWk7fuGUY2SEVwzoE0VhJsj9cjU3ldcI/R52MRIjmeRgcsd9C0YZWWIr16/bcCrS2CZK
 vf02r9ZfRxE/UjF1AhqkxnXWUZ19k+dYQpSZWwkiLbHobB1OgG4O1G4ndd7WzyduOcNsO
 G/F5Lict70LYrTnATLUSAuAO+PA6FGig6VsvTZTjEsS974ifmUxlGKau9slpYSoVVnSKn
 iXs+UxAyuqkz6S2V/S1YwibbMJE3RklXDtCV41EfMwnzqtA8zVa/qFaMzVel3yxlGlVA7
 unsqRXotMh02v2ajad/yltmpjgDt8acQI0HRacG55tu8TPyApG6dAtvUsz6B43+rHrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b=unVGJC5T; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=fntV8FQE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=unVGJC5T; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=fntV8FQE
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D205940AF5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:38 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGmeX3932094; Fri, 30 Oct 2026 10:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 DKIM; bh=ICHL8VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=; b=unVGJC5
 TBvpscqZpnVZJSEK83f6YHCoRoS2ilflFa0TGdzdTDa8n1jOlNg9/OHcGBdwfcxQ
 w7xFTfUcYGLOFR7hPCdoZtKi2i4m5TFY9en+9HLWfT171WthOIXS5vcP848fT+bu
 dNOxEXJQVwQS8o/b7xt0oz2wgBDoGVKkrLQKpVAYbBIhE+ZfIkCNcIeVzBdJPdDr
 xXUfBsRDZ2yV6W3I558f8l0OunsOdNpQ1s10Ye+LeLYrT1KT3db0snFR/3anUq/M
 Fqvp8j982HFMzw41TiArWJK+Gx83REDZDIUNtMvj8QjYCC1nOi0A7OXhTG8qBIdZ
 iBztIBNIwtYE/aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=ICHL8
 VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=; b=fntV8FQEFQmzrdok3pJqX
 J09bQhHABhkpLHj5vJ0Pu9sR+XxOdsEvy88+8XJwjPhgDOUI1RglS84gBOed+hTQ
 cQHS0TOhtkpWFt4wx+3BWkovjsE5VfVAPmqMVxRfjAB+8rzzd7jQLJkgxHWpX+T9
 hSS1KmHEvNOBYj41O5hpUITHSe8t7FzX93iY1knN7ddQZ+DeK9a3QlkEzU8jG8+w
 SJLcQ7BpytI5KTIvBKyPjZXuRMPy7QNgoXzqP95j0GuORdBpVm2RYUh+By0Wi3wl
 PdgLVw/jZkUStVRUYDqvgxmL2giNriwRcsKn3+fOPzQIvZWwuEYH6XT+eMuKmyKG
 g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4c22-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 10:01:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVTXfy0wezfVeC+Ai8kWVu9cP3Z4GDfYd5Mb2C4CXIu91WThpS/+25HH1HmIqq64rkMJozclLJri2UH8FHIrGoIc2L7PmrrzoNbXj7EIoQ8oBa/HspEvjpfadwRqO0ot4KKJ09QlYztYJrUMJK09/P1gs2k+Mz2QlotcOfIWLNxoC0XBBdvHnWnu1QM4xCm4ui4qiZ0skbXgl7pEj7on07Dc4fvRDok0sEX/e9uKvaMqMr6XaMaWojuGqq1npV8gYHVFWN/r1ME9u2Ew6t77dhCvEQHU8Mc8LFq1+05b5xgyY22m/lJ8hkCiyZsPEv3hAKc5Fyb2/i90Rfez9iFpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICHL8VlaQL8fixF90f2H0oSIt3j6X4o0AH06DUDdecA=;
 b=m46C1GfXKKcpf2fXKKnfjJFcH/CeAGf/vSfVc2Xon7cLq5iUK537XgL/Xk+zInTAUb54x4/nd8SeFs/cixrm7lmWjJp6+zDiCouoJy3rfvB37DRyk8wPPTlTC2jQFq/lPFraGTTQKGNRcexlK64gc5OzRNTgQ2HZJNkDlaME8EaeHeYO6jseMI90i7EbDJ22cQ88rVPBv6ZPjpjYr+6vA/v6EV2GC6b9bWoPYqG4O+vM23q66SnYcqTSHJC8Ml/xFEBlN1tZcbxmO0s5EkInECywbZq2pTqmAI0QkmncwU4ZaHe7NqVj9Mfdf1JR1SlmNlxOx6vXQs7xNyszZI5VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH8PR03MB989600.namprd03.prod.outlook.com
 (2603:10b6:510:408::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:01:34 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:01:33 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 3/3] configs: sc598-som-ezlite: drop explicit carrier board
 option
Date: Fri, 30 Oct 2026 10:01:22 -0400
Message-ID: <bb34e0bbf794c53a17b937b8c1e8ccfed2002a04.1793368074.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793368074.git.caleb.ethridge@analog.com>
References: <cover.1793368074.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:610:e4::15) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH8PR03MB989600:EE_
X-MS-Office365-Filtering-Correlation-Id: 5befdcdf-d69d-4c69-7791-08df368e4e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: mZMzlDeTSzD8XZEif1crhQCXuQp49EgcO646VPyLJbyRYic6m74mgnex8dPuPih4TSi0qjiqLg7PShDh0rQEyVusCdVqgpFXsVEnqSWrISMYPMGA0yPB4rjyhgPHojzzTrJNlLqxef01wemtsc0udZQHnQEZho5fgqJV+eLULuGMHpG8CEFTaPezQsvBho0loFj9aBQnLldr0IacONkkJkY/l9qgQwXUj/FB20vIiAAn7g+DstSSgSkavS4cyExLNaFNOu9UUpwvgDi4+EnQpB8Z3sIgff648toDG6cNv/fEs9/+9FhtWgF8jpCrs83DHYyfDIKqu9Ud38y+LTvPHLMbAYb/bpPTVaGVxDx4GWO2LltyBhNpkGqprzrLd/q/a+3Btwo8OzJSRmJWmnG2APfofvOOrbhf8nRx7Oa60//hyyKdFDTEZXRfWI0gAyPNjQmxT+h+TxLuG6WgVM9Ha6xSjVQhWooyFs+R+QGKylPL1FVuCGFQLWDiivXqtpfv+c4TijKjoEALbJA7XENywwXYWO3p9+SeRC2zDXuonkLS//ClvTgzd/L/NURMDJl1o6ogSfcvSsua4tGwXKGxKnqpo1tKQlujx6VCaEvWHvMr7e/0iIIQSJNmkv7SbVcz/UxzqW8WWmCVDNFNKMcdqdqY50b3XY0pnYwE3KcdoSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMMfhYBI2QODCJL31p79gnZt0fz6S9ASzGAq6OelPAk/DR2KIwETLbNFSaFe?=
 =?us-ascii?Q?SasrQguThS19Xy+eFIH+9N4FsGrSlwp4aTWCYsfTJz5uSd9R6EBu7c10LWn5?=
 =?us-ascii?Q?OCNg1f6n7zEEzFznIjmK9dczNvVgbbghRWp9gXN4uaxoFHghJbGPFqOqDd8L?=
 =?us-ascii?Q?wak3Pb2TeQs4FZA9Vp4CWGr4S85THtLJP31elo40EeZ28gK/UgFq4LCAHhMl?=
 =?us-ascii?Q?tOLmmo+tSh4/K/vZ66OK/IddDmnieqTeKD0QhWDWtwUi6yU5Iek7aswHw6Hz?=
 =?us-ascii?Q?EYsPPj66Mdf2RBGZb0mXsgnRpV8vPLAl58ZpV8+32qy2mnTb3zotvmZJDWbu?=
 =?us-ascii?Q?04mq6vnc/S1Iy6mjCoTkVGd8Hhn931Y/p3t3LZHaidA6/d60qsstBVcdu4ID?=
 =?us-ascii?Q?Gm9UZTP8yLaIS7g5I//LUt8Z4LkaZBfaghBo1q3RXaudU6H3BqvyFqpnInhD?=
 =?us-ascii?Q?HBlrDGOkBXgGuZFaOPuPWdRcDypP6tGDn4FnK5/mTrq6A81vZ4vvJovtNZwr?=
 =?us-ascii?Q?f7Iz6+pHDBFxQ13t3vzeKcrnII8cCdjBC/4+awxqMWtjFzLp67unysOoiHAR?=
 =?us-ascii?Q?n5ivU5GGFkssDuUzruGBOe0E1lFEBH2aBbrOKyJlTpgViB4Bs7X0kyNxZsDM?=
 =?us-ascii?Q?4znYwxy+OPy7CCXv5YgT8N+0A8ohrOfFJAb+qZ1tmU6BwK4mHt3kRHDvLknM?=
 =?us-ascii?Q?vNtjeqMQU9MGwCtyENYrV8twjmU5svsbGqfWMe29W+cI/Z1zVjXeU5o40JPZ?=
 =?us-ascii?Q?pk893BzD0UMaAwD89OTs4eAPK6/UOWffFttHbl4KgqVJK3X7joulwePAObGs?=
 =?us-ascii?Q?VsN67/E1wYn7Nh8CNMUaJeJQjrvRlSuMU9phEcibHlAiq9eXB5APkgbj2W2K?=
 =?us-ascii?Q?oOaw+zFcRF5OyiyorDcGO+YXfuSy38BOTKEHMUUWEnVjGPACPUx7k5qKtYgc?=
 =?us-ascii?Q?TjdMW+NaOaNH5R8o+iq4XWlyFMlrUlnXHDDzFMCG4cKLh6rjS/zWU8ijPjhy?=
 =?us-ascii?Q?QnFo5hqZO1CPDzmutI6qeg0GqzvKdvZ3y6Cm1BFS3D5xzY2BGOdWdXXd8o3w?=
 =?us-ascii?Q?kcjGsc9drk2TRIX2OdZtAvKaJV5RSgUPcCoKnzIwJRQHhlXwY8wHLTO8ctiT?=
 =?us-ascii?Q?/1oeD3wWFQ/x1sQG4a3+xp4U99TgHJNiooL1Hnb/3zMKNovqMT3rWO+jRKv5?=
 =?us-ascii?Q?ZGMukmcwlFme8S4hnZvl9gKM78C6S5m5qOEYRdK9uBBKjlOXfN65xA4ZMIkS?=
 =?us-ascii?Q?Mg/+MAbOMwP5cOvHTAv07Fd9hBltrH77E9HwVOIOqaaPS+rerTZhHYkxRGJ2?=
 =?us-ascii?Q?oAEcUJcRNXBv9yuh1vvAz9Vg8XjFJu+wG7qla9JX/vPWvU77ao+tZLd/fV71?=
 =?us-ascii?Q?FFKJLRNv+wZN0h5PWzPQR2Iuc8p2wsJd0PaSUR9ouDJoFzl3/3vLgqb6Y3sK?=
 =?us-ascii?Q?+8/Mb4BMzO0jyu5Kt0hqOvuNYCyJOpBVjuM3Df0nbK0w7ljIUfZS8nIsgKj/?=
 =?us-ascii?Q?2dkzBBB6yUOfyW4eBYj7XGRWMle7i1Qe4TTX/wtG2NXFWsLzcnu9Kuk7EyH/?=
 =?us-ascii?Q?+61fGTELYxifSft3v9IrVnbwWW+TQ3jwAo0LEhmbP1N/Jr/C+OWODUlgKrzF?=
 =?us-ascii?Q?AwGLNt7Yehyp4FZm0VSMvXHnthij24fyKHQe/wnaERK6kzvVo8dkt9qcrN+O?=
 =?us-ascii?Q?ZOMHiYPA3In+lqeDXeMu7yTbCoFRKrFDZ1zyra0zpgAiuMOs5QHkFaOzH9QX?=
 =?us-ascii?Q?O7CSNMT8IYf+b7WoAHuKrdF2XsOcuAs=3D?=
X-Exchange-RoutingPolicyChecked: NSK68uV3OrXSLbm50ZJp+lv95Yh1F3J4p7/LpWAftsCGUryUrEAvrnQwjVV1M6BS6Q5dkqFLziJfVuXxEQZVsZbVdxnEa0FoBvpgZrH2nq/kuD/n0LOxde7rI/vzW7/8dMYNC5e6rAtL3M8uOUfeJ/FP+qNeu7Xpitlqjcob+7XYascc7ALVw6XDfWHU/Fs1+mR7ZwNw7iPN1lbSxWw3icsV98cTj1QlCSz5bS7QdMZALjLOHsF3YplP4ZrcyhlOrVdIWUT/mSTI4gLOl+3qee0ZffV8AKkoChl1SfdloarseXZA5oIh7iekrbv7tpuXZ+0t5Ulfwt+paRhy0FxWXQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5befdcdf-d69d-4c69-7791-08df368e4e58
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:01:33.8966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBTsBUQ4l6XOn/R/sDzg0ojVTygnnkUr6nveK9/RylKqojRl5wOrwgqkOFPXQi4BSTEGXSNBhkNL7USBQ3TAUDIwm6IJBE7PCpPOOIMfsa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX7r2Ap8x3J8f2
 lnWI9mbW3mX0ygbi7NKW4ixuobuad9kBUoB3/1MkvaFyibRaOXuRrvzKRwQVvT63N+WLgz6QIpL
 XMk+HEf5k6IYSS4ubYaeTW6Du/KB4DTgmvMnyYGOw4yptVyl5BCjNp40EzDJFOW0UeJnJuxjN8U
 lnUy5oasHevipeenqCZxA2e5Fp2PwtzuYomcyB9xg4bik0DXvJRNO14OwR85p7Qt8adXxwiIDh5
 EHsswZui78REPO100NPaw33NmPP9x+t2aQJbVsvO+ZbCFohd0Dn7hGKZ6AC0A/8rfmMeSPHbYT7
 H6/8ZPR/p0POp1UadfdFQbUFW3n3JBeGhAnyHcXRF4AIxZ0jpQ12ctJUTlsl+bxwn8NhPQzbR15
 YtaZKGwqs/4El7/0rXU1WDCytvFNao5kUKfNNFMmwsQbqroAEoeh77uW2hZ8I+sIyOi+Uz1CWpW
 UQoIoMz7hm0aMaq3yHg==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4a340 cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=lYaIdmz2C2Zr_ttvaKcA:9
X-Proofpoint-ORIG-GUID: NJkTFhqjY_Fm8W3_8JhlaZauYDvJCGgE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX3cNgTfhhiEn/
 WFwZCiMCRi3iBPpcVaACEnrMJ3sTJbCpxnA8Qv/80EtmLbVJQanZ6VNIEhbtmuE7g2GXtkGKbRP
 q8ppD74BgRqqfaU4/Ta/KoVXCUAB1HOlGkm4MSI1H+MPRWAOrrYv
X-Proofpoint-GUID: NJkTFhqjY_Fm8W3_8JhlaZauYDvJCGgE
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Caleb Ethridge <caleb.ethridge@analog.com>

ADI_CARRIER_SOMCRR_EZLITE is now a symbol selected by
TARGET_SC598_SOM_EZLITE, remove the explicit carrier board option.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc598-som-ezlite-spl_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 8d42e9a4d2f..0c15da00ce7 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -12,7 +12,6 @@ CONFIG_SPL_STACK=0x200E4000
 CONFIG_SC59X_64=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x90000000
-CONFIG_ADI_CARRIER_SOMCRR_EZLITE=y
 CONFIG_CGU1_PLL3_DDRCLK=y
 CONFIG_CGU1_PLL3_VCO_MSEL=64
 CONFIG_CGU1_PLL3_DCLK_DIV=2
-- 
2.43.0

