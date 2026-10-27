Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B8606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dHaiPytF;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bnoiJ8mn;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j7IU/Vor
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A172D80DBB;
	Tue, 27 Oct 2026 14:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPqRFbNU_NIJ; Tue, 27 Oct 2026 14:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2DBD80DA2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793110668;
	b=M07DSUWsLOpR7V8KxyV+atiFo0fD5RHFvj6o/qpHjmPsNtUwVj8G2Tyah+AIRSWcGapM
	 DlSYVMDEXeJs7yE4MeSXeuH8z71GGQlRINgDcRiIH4UWtQKKpZOWRrY/IhHl9ayiJ/d+J
	 CrOwHhfQ/L49dTwxMbaKpzO80llnINMeAd+dLyqTwJVt3YmBt3TKQOCFtIqlxOkDztPsA
	 XS3EVg2FTB1v/uUrEVlFmRq+7R5xCQs3t0QiTsTfZqzAGrKyGjBfhs0o5TMTG+7FHCbj8
	 LM+1ep7MfVzwyir1nDJMiOvuGn+AkEttdo3RrkDZU+zVnDd1H21VmF1zHhFm9johcKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793110668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3ZI=;
	b=QA0Gy6y4ZM+X45yhqaBaVqEcGv4qtUUwiatpn+VGb+Cb7K/gdmiQK6WWQXimZtFORNJY
	 nnu7syAGn+PNLJaRnkWFNLdjjY5X82w6mnM7yFJk62/Z3AH2HV7r06FWw47RPYGkZOvwl
	 kDhsTRjHPJTMj2QqSUW/6Rxa1ly7UpUxK1VNwOs50aVFtXl3yn70PCiNbpm/5xYC5L5GI
	 bUO7dswcB1rzvxqn8Y8sne4DNEnrc0rzFRT7t9HM9cr+NIMlprjtNMmb+3/WyHh5Ejm7i
	 0vj+8R17kmn2L71rhlQyp+VXsQYf25uDSaraOgDmMk3LgYV86eCNSDkcBneNhKxbG1Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bnoiJ8mn;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="j7IU/Vor";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793110668;
	bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3ZI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHaiPytF36BsTxj6nBg0Qw4DF/Wz0PwIGpjStX0QHG3/SIp5AfmSxxBE51lbYk0Wt
	 wy7HbM/colBn/bpze2q6nE7iJ6lvFAfw7Jb7+TltGBrgD+abOrCIOd6uFO+auzcn5B
	 1G8zDHg+8Nwpy9f5dAIhDI5COTEeatW9yLozU0vD3eHy6MD2P5Bv90PZ3VUDI3ngjc
	 1tCw5sqnAFOsZgERzPjoz3FrNOzjgIY/jsvS7FjXvolYRyZXmMdcIrgmF1EQjTDNV+
	 urv6/0xEYoEPym0T3UflnUNVfgCK2yOVZR1pm/oZABSuYHjkKGQkroAL8raU0TQvAv
	 iDvRpBUxawI0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2DBD80DA2;
	Tue, 27 Oct 2026 14:17:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 430D64D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 392E180DA2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kBzSZAQG04p for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7484880C0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793110666;
 b=Mx1J/98Y41BcI34LTt9y8nO8Dz4F6yYXyP1pumZd9RqEM1+JK0xp+2SwCnltPqzc4NRE
 DMdAI5kN5tOcrnmWACZyaLDUBjypHZl01YNHyDqm7PxNNiNYyuuvVw/0JQXjSZlrgrOk2
 GunAXJW3mitZyXAkPhYwWs/wJU2LeHhHLhQMAm/IeOkOYcF/L6NRvcZyih7PNA9sknPJ3
 E6N168xMRAHTHG+purK5LpmSATlM6P8HKc17fmxJVCx/INYV9Y0FVLxqKpuiR0pXCxNbq
 jeK5JE7PHw2S5nIHLWFOTR806sitXvPKb8ddTn9fGk4SU0yfBJ2XkERjZHjavgWpWQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793110666;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3ZI=;
 b=Q8ytonF/Z5m7OfLbUyq4EdhmMTYlfLJ/XDTZrDGjDdCEoT8+/EGvJ2LMGrHJE6dbFaUc
 WarZQn5taIIo4ve82mg0l8Q71jtw74XEmCvvn20qIdpiilI1ouLsKh5EoBFj3W2v3/1Ss
 B0BjUoikXsBF8RFqRQgF93Hvtz0ce6iLmNO5jav0rR87G5xug7qTX0GorcTRSDkjmfNql
 +hOm+F67biW+8ZE1tnMLrhymrKCti3DBC5b7/RxiUzQRPJgwM5yRc/DBEMtfy+PFyv4x3
 0csd4r5BBIP8SaYmmsxvP6cqYWxA6aHUE7HcvwRFKRnN5UJ6ImDcQrX/kxmtCBftyyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bnoiJ8mn; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="j7IU/Vor"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bnoiJ8mn; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=j7IU/Vor
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7484880C0D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:45 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69RDmNTK3686140;
 Tue, 27 Oct 2026 09:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3
 ZI=; b=bnoiJ8mndz9GKvR3TKpJuG3uNXtTqhVTZu5lvKFpQI4k4iWDuwlldVwkP
 sMPje9lOZ69S4BEzdB9JWzIWBKQXBR8Cvf40ovHqGbzUf7YEKx+TO62iaW3ACLtz
 wN7VGjmVLA8h4pN37Dfjr473K+LxAwIf3zWUnJ612gMorrEWj3h6kJY0aO8sC4QJ
 CEltPoLKHsE8+QZhnXTnPAiFgAi+AgEsD1sNBqYq/Iweq52RwqHRGNNLOkmm8NlW
 iObbm9F4Ubfda4h+fojDgNCijZK8b06OcjBSvAzfacn5DLiTRumb0EbXB1ljdojB
 sbN5fgpl1z+YBLiaN2bKPcwFhuiyQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hjtvxh0y8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:17:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7M/6xd+73Qe+7NlWyLz/0u3z1I3MpSK+4x3M2EJ71V1Q5kD4mcjBXzeHoEK1ZD4dOOa3DzFAdnU5b2pz+3XLJDRicdLnP5J4psb/coFyudRc2lShcqW8Okls0cqcnkzvdNRS8pHl5cM9RnHfYxh8jeISLnyhWg0ZOipigy6DPZuF/cI+xyFKd4oyUryGTBrjHDlnqXaAjmZHc4K+EOBgn/nM5V8W0gs7pGZjvAwxnEXhZb410VMhZn5caNWzorbgvt3PvydAG/lc5A/T+JtMH6WqBRPRYJcsEYjcfIQBjrwU1EyBCMJyQ/Qju71Wf4h141KwSqatdL9Gdy5qyE6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3ZI=;
 b=URqSQf5wPvdRvvh4zxDRaQuq3cl2VKvsWvpsgjRb6/RRz8vXVuE2Mrmm0L5Bong7bQh/vyJ5lFian8bbHScv4Ep4T3H+wiszgxw4vMw1Za9YWshVRS+UMnMyMxDVHsL7CwNRUDTqfvHzhdfRUtdOf3cOkVO3CwJDlN1HAQsxZfGYH0lpHcDDkFv3F6ZeMO8xxdEF29wqBFUZKr7pvTIgVvJenwxuY7AMzkPKaQWTqVmjVf9p1cO5sA0x4SokyXqCzKO5VMgdkQ2vKSFY3c7DamugRsMDz7ac/E1TCA1HKcJbtTH5zsw6hSTHXClJhcghFPIrpTei4sPrsEFArnjvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJjuZPNANOmGxnAypy8euHgSER8WvYrfh5odSljC3ZI=;
 b=j7IU/VordkelJ8Kq6zrod0hPqocprp1i0etEMz5qkswcuGN+ytp2s5uaxNJVwSEryZH58Hw8RWe6it9e1eJFyANtWz5T3g4TuyT1JsbGs0PqA12awXhsXR4rOwNIWTS28WsyJgYJnB6XHLajJvp99fPnPeBb0wRYtMnlno/Nzas=
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by PH8PR10MB6624.namprd10.prod.outlook.com (2603:10b6:510:220::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:17:33 +0000
Received: from BN3PEPF00022BD1.namprd03.prod.outlook.com
 (2603:10b6:610:e6:cafe::33) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 14:17:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BD1.mail.protection.outlook.com (10.167.248.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:17:32 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:16:33 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:16:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 09:16:32 -0500
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69REGUpH3002716;
 Tue, 27 Oct 2026 09:16:31 -0500
Message-ID: <32ae6810-b681-44b6-8734-8197652bcf6d@ti.com>
Date: Tue, 27 Oct 2026 19:46:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: omap: Hardcode control_status register for OMAP54xx
To: Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <afd@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.u-boot-project.org>
References: <20261026134848.1733598-1-b-padhi@ti.com>
 <20261026153138.GD624796@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20261026153138.GD624796@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD1:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 40711894-bfdc-487f-8992-08df34350a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|261022075727099003|261026140227099003|4143699003|56012099006|261022105027099003|261022115727099003|261021121427099003|10067099003|18002099003|22082099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ewnwf/BXAljyEVYwkSAgOqreLRy7Lxgoy8FmzbA+B6d1u4YV22JPUFwgPOrJkAOFYY7d1U8ocPh0FwtQoayi8veIydswTY6MHRlBP47Cns3TwTwQF5wg+kg6dkDoMSKkp7hchLGI5x4lir/7l/f3VIL4bFc+ygKZfSgUsCoN3V74yYpIs5IL7jF/ELyDMLpcLVlcql9/0n8Ev6cdhUiOGeBmNejlbxY0PiaGtsvr30JFIqWATPphV1wCAQXfqCoQTAQxPWBtGEbt/W+JaV8qwcZ0F2HbH0Nykq7d3nNFvZNz83g0haVuuCPigvuaSZJvaxzvAvKYIAFI7+ioUtZ0n+fRTx2MmUaoWrJ3gQfHo//kWvDDuonfPS54YWFRbVXnIQUbC5gxUFLOZCnneY8b0oxn1M9mW4p+9yugfmrE3jyyvfJtIwOzVNVUzk1ltuzZTCth9qGw1OA3WKLvRELIMEPVDxShHoCzbMayGTvscVriPc6TH7ukhGsuk15yBvn1I77sCgxt5OwGwghukF4rsz/SdMCsxpeyrXNjdTgjECpgpiB/JNSCYNG/N1v0s8W9T+vKhtj4nJpcu8dACIgpWID2qAfan8oz6lwL/ffIJpb5XsP5UURwW+CPzFjgNVw1+529TgAxbocBdhFPh68xT3yeOEsl1VaNm3xBM5Rr3UgXe3CXiINBNetAiu84CTK91SBIP0OEynYDhjTkqIBJMg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(261022075727099003)(261026140227099003)(4143699003)(56012099006)(261022105027099003)(261022115727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kfwNX1Lhm5CnJw5HaYu250ehDDBXQqBKVeArU4L85J/W7MEfWD2D4hdcmvRK7wPE2E50+8nZcr0lcezEs/jTMF5z23v/eZVd7yMe2FhVmg+4TInST9XMS/Rxd/rEhVWSUq3sh3VRx4uhuUsjFT+Hjea6/TY3xw8TrlsCVAcPKbxK1hdBS49jUpL8YC7xkEmmnCHCfH6134iPe6ab01qhLX3VJDnbXDCHYNdUHgObrtJj2EosvlgcdqkEIk9vgSqsgpiK/fhxV7wmHINOy16lA1uDs6UMGKkV5Hi7MEWu/yPntk16xmDGmxu4XUVLGzNMQWcgSHlYmoxgrK/PlmeC6gOxZuS1T7N+EMqTWobWdEgznq1IziFZxgIj5khBPEXQbApQa8X5kGe2qvSLJDMTwco2fvo2WAqQfrTt9XLrWbPk+96DvqSHj5ljyGXISI2K
X-Exchange-RoutingPolicyChecked: qGzJWXVnI9YQKsCoERcgZ2cDdE0bJ54/xhD6PmXZu7mSz9mgrrfA5TmBwwMxuapdhYHMEclTD0kFzuiYk/FFaSWEhDtVl60DLqCoRCG7HK2yuusSMr3KjHZhwKI/F6mrrZ97A+K9UN0cI71QZaNPSxDu9l2GbabbrVNrdXiOZDEdzYPlXpg5bc6Js+l87EFBawFJ/b0LBvr2brYuDjiGaFHKuGibw7SvUsr0LpC0Q4JnuTE7+f7ZjHEmJer6glD9AXv4Hqa5L9YMh75zeEevT14ayj6LafIcSEt4fXs9BAuA3Hh/qZO0dztrYvNqovZZx7fehF308ClJyR3uoaHGjw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:17:32.3039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40711894-bfdc-487f-8992-08df34350a82
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
X-Proofpoint-ORIG-GUID: TEoWp3kfD8XtYoZ6gaCEDLbPTKa03_1i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXy4wF0uP3VrJZ
 Bnm9V604KajcXnGDi9l9Jn7w0q15hbHnY1fu8gQQ3OKlNhNaqei4qA+bmGTngnNOweS9fbDdzKh
 umTVVyRZprSLnQV2rsVAqOEhlVSVAzg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX5E1dSUGVo7YQ
 yajxspsiU3SkXut+aY29UF+CeBIyZdEYQAwg7bo1zCixlwIO03NO3FofTsKun1rJR2QSFsUOePc
 W40E+yIj/xsVQ7G0KYEydm2dDlTdlqEo+POEOli5SKdGLilHVuM/6Kep4LmG62jeq4RnFZU88wY
 hvM+gX2BGCmKPrH+dtbZuWwW5Sde4ZrDpElVV/Sv6Ts29mS45aCOvnciWUbJ5Qcyzacj50Kxlc2
 k2ZMm1H7cZi+o25P1BJ33yKYlD8vYi+TuW70z0+R0ynPEknJbWsFj+1D7s7x45ApKT/s4eQlN0b
 3tcuDJVYYo4pju9WBACw2UDOIBR8Znltduhz0ddVUcfv5vk76fpnoHK0kPGXccaX/bj1ejwBltl
 J/Ru120k0u01YWe0faCj2gKz7xzUkFWPdMusOphhhpgUlnqyrZFs2DnuRr8Ieq5mvBESKruJNor
 U3+uaci+2tu3+B+C/HQ==
X-Proofpoint-GUID: TEoWp3kfD8XtYoZ6gaCEDLbPTKa03_1i
X-Authority-Analysis: v=2.4 cv=dOwzC+Zb c=1 sm=1 tr=0 ts=6ae0b285 cx=c_pps
 a=TcXP/BJ3gOSVg56PH7Z4Eg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=vgywbm6yWe9W_ujkPzwA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 26/10/26 21:01, Tom Rini wrote:
> On Mon, Oct 26, 2026 at 07:18:48PM +0530, Beleswar Padhi wrote:
>
>> Currently, the control status register address is obtained from the
>> ctrl global pointer which points to DDR address 0x8086XXXX. The kernel
>> section from the fitImage is loaded to address 0x80008000. So, a larger
>> kernel image (~8.4 MB) overwrites the value at the address (0x8086XXXX)
>> pointed by the ctrl pointer. This corrupts the (*ctrl) value and CPU
>> goes into a data abort when it tries to access the data at addr=(*ctrl)
> Why is the ctrl global pointer using a seemingly random point in DDR and
> not something in U-Boot itself and so relocated and safe?


Sorry, did some digging and found out the commit message is not
accurate. I will put up a correct commit message in v2.

Thanks,
Beleswar

