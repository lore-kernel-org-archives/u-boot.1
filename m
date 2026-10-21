Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F6606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bdtaSggk;
	dkim=pass (2048-bit key, unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256 header.s=selector1 header.b=UTW9sdna
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C58C608F1;
	Wed, 21 Oct 2026 17:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7GlmvIJM9Ng; Wed, 21 Oct 2026 17:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E897160892
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792605411;
	b=QrZbuTyGRxQMWFSIrRn27GYGfoLd9kfKYO566H+lBk0ObNw8Dy9TeRzdTArySGm967O5
	 aJJlIqPFSwcz+xwL9Jj0veVTWhpNgtqeMFZug1jEFVjA9iIrJ3jbceeLX/yyagjgBduhe
	 REIj2o8UWZIJbnJrQrporEofynZWWMtKqvHO/y0xOLg/xYndkU+i2kdpYpZxtXCKX6VBM
	 Aifmrf5szASwKYpFcJJcIAvgN0ElB34SuWzoR+OOiW+Xz8Ec6j2YQ+980BQ5QsGbqXWcM
	 VM6AoZ00LgyoIsPg6//Rx06I8auar7+RhMjl0nNO+34/14iDvwWijrazJlqjwagaWXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792605411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9jajUAicMGpmdxgbCLiHfT8l7ONyeCzYVMJemMoerSI=;
	b=fhqRa2X87mjcXAl1NSAttJp62I6Pgf48I4ff1P7iPy3qAs/rFGpe7Ngx3i1jZo+/S9E2
	 s+a5a4y8jcQxkb1iDp20KdS6S27k5CD+HtBahbJ7P03GWcdJpjXpTsEKx98eDR7eXf1EX
	 Frbc9ngGadVbql9tYm89Rrw8db+wpFjhKh4V43xY7/SsGisj3EVPNRcKa3rgKXCOBZ7c+
	 EbNO4eOVYa+2mkThTNf2NYUtuueoWrMIh1G5ccwiRUWD+8OXKrMZ+XUDenYXSa3rXph9b
	 40XOLDlsTJkLUlIH0j9j8nqDFw7bhDAcJvgIuwnsxxO9PfSOdbdL6IlHqpDrzOKMjkw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=pa.msu.edu;
	dkim=pass header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256 header.s=selector1 header.b=UTW9sdna;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792605411;
	bh=9jajUAicMGpmdxgbCLiHfT8l7ONyeCzYVMJemMoerSI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bdtaSggkr7BLOJyGiLlEPapNq9Nta2yjIYm/GLKqHGLULFkN6IAPKzE7FQ58lTEqH
	 g4cWyMQElIykEJL06k4f1UxJGBuZqVvD1gEOBYK82w5olg739s2E+Sp5sN+gBnJvMx
	 UfB8VyadzXbzD9umu1a15qwkeTYtdKa9gGgyprFQ6igLlJVIuHZQLdwOZHZLmkjAvV
	 c0ip28zi26o0CvmNW/qQYQpH/esfe1R4W9yEceAb4WyRO+bgqQmywV+3fAhgJcnzfW
	 Hyg51S0cQcXrj7uNRyiIqk0qcNmVq4K8X40HkwrL5D8cgCyXXG9NnSU+aWKl4trnkG
	 JvsHpdACpoayA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E897160892;
	Wed, 21 Oct 2026 17:56:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2247235
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D71F760A69
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTgvrPGQAREr for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0098F60A62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792603557;
 b=VMJZ2Tr2oCzfNfbCaWsRDGnAe2z1Lrv+joKWL1iITl0iiS3Mcr1WV3iXqEOrM1hAjuh5
 Zf1C232hyEuQryaBfto4lZhj/OC17P6JeMXh9te/qJwl3kDh6v4fNhUHwwdh97u9ebD/o
 MML6lDQVUOKQlXs1qxUsjbbdnHEs/j5UsKKGioeeMbWAa5a/sdELRcBtYYr0Xi5ZU5XMx
 WABPS8Y0TVrOLfAjDXZ4D50nsy4Vpg+BgR/8w9/3vflopcM14D4SzC8G1m9KzpF03S7jO
 gvhtp4I35UxsLS1WPj7wWmhjthCr1egz+YVtQgkvgOMDowo1gWyFRPSXol2RU47cPNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792603557;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=9jajUAicMGpmdxgbCLiHfT8l7ONyeCzYVMJemMoerSI=;
 b=mCqG5sCKZIVZKiE+hI5YktWBnJuZeLwNMiRsRp0IirdZ/YmgTnwzHiPQqbaOV0MTHORU
 ufCVklogT959nfCZ9hb12lS5VngGBpjo6Go6sYuHgbFCsYeosmaGdWh5sehROt/GQsVP8
 wEdybMJq502IJdMUBjKE7Xfn1+a+PKH1b2mOik4gbclCYQ5fN6FhsVAOEXYhHc4km+TM6
 BRH/h+c/Q4wlxgA6EMOgYQdoyl1Q0sRmNCq+Ff4AxMTrT+RVmKiicKg/zWF+K9j65dWbv
 uA7WziCRIpWjtMGYQHI7skCdylZ+m90Q0sJlgz0IpYwOjDbwXqJKuTG8pMtM2aMRR8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=UTW9sdna; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=UTW9sdna
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0098F60A62
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvtWazo+U4PhTOMSQH70LNMRt76gwRh9/crxy0SvqgAsun62qiSCKjC0k+cLaVXHp6j+j/QH6TGg0oLwf94sknCtlUdkOb9uXc7/W5ne+OrSm44xyWicoOFmv4R9luyhQTeLFNOtQU6AElaui/eMcJWvhU5zjDzY1pzuQDdllyqWohsCEwIg6RPHZ1XQEik8zGzSFndHNMZfdvHRkJnmAZUT+Um/KJPd+UL3EvPsQLKs7ggk0r7yj5PFuAada6Lc6bwwqg/kb0RX0Gs4Sd6OwQai8HRbtn2TB9h/lXnZHK2tEt0ynOrLpIsqdOiICqCDMJ1kV6Qw4jyMTHcxF/ZvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jajUAicMGpmdxgbCLiHfT8l7ONyeCzYVMJemMoerSI=;
 b=Lk50pcBWS7UZsJWpoisbZXB/4NFTe65/sNz/bOr24o/fUCEaFXS+JiHGU9vUyCBYgZKk+9m02NpqsyD2XWq2P6gyday/q0P4HDYqqXBM2fjhLhepMptS3uy5GxBtuss/PJM3xBT/HghOe3RmWmtI9KtzFrUSmZaLh5wNbeADHkddrmEuLmtzKFoG12gZf6Q3Zo44KlWWt7cZJ4iTn+7Gmb1ZCcBq0HTy1I4AQCngQGsrBApXU4Vr96l37ju+3hR7QHwjRDr+rB1dKK7KQlMHDhC3U0PoUu0ezsJlPMBrVV3KfkOYpgrdH6yq/axp/ow/87tje/9yzN7/an+gNLgVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jajUAicMGpmdxgbCLiHfT8l7ONyeCzYVMJemMoerSI=;
 b=UTW9sdna9V61r8li0LoZo+ZpfNu9TV3jZ+1mU2XYTsqFS2c1xMq1p/HO2ULjef/HL60Twd6IrWvzM4r3MmO/+zxNA05Za2ZsGTXsECVZSgOfEdHWyJO5vQgn3HNzuWosA7diazfytWdWE3sKTRHeKTFHJqHyNGsCc6EiNLIQo2RHVvmym5nKSA9mNEtnlWQ2zPGLCAQJ73W8uMSctEM7spSFZnVqUwvZOl1zIOOTelZKxhZ3QDaSLgzhg90lsKZ4d1eWDewcsahxLCGEm8ovPNnFarILE4TBkG4XD6cFiPDHujWZHT+C9+mKbbx/tJDH/cbRsfQwhtiMncyk6h3RDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Wed, 21 Oct
 2026 17:25:47 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 17:25:46 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, Conor.Dooley@microchip.com,
 Jamie.Gibbons@microchip.com, Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [RESEND PATCH v3] riscv: mpfs: Read and store FPGA design information
 on MPFS hardware.
Date: Wed, 21 Oct 2026 13:25:32 -0400
Message-ID: <20261021172532.81413-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0166.namprd02.prod.outlook.com
 (2603:10b6:5:332::33) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c44f24-6106-4c7d-847c-08df2f9857ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|786006|1800799024|11063799006|261021130227099003|261021121427099003|56012099006|261021135927099003|261021123027099003|261009223027099003|261021133027099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: QKZr6p0V9ZNqu0bl8NhToFkixaeoHg4WfCQEayU9xRhXAUT7dwkTg32yZckShIb7I6f1eRaAc3RFfxL+Sk4xVkT154xBiqDK6ZeTv+0dat/cKMEQY8TwuSIUAsU2zJ1bzWEcYy0D5PM5avXlVPHyPeEKhAlj6iniqG9sxibQcdYKqpEgzIVDRx3ml+zSA+TgEExThkKluwliXGrplIVvL7hpCaDpfD/O4pENC8JqUh251tWXjnbGbt8szUcHIBubIj/ouScbEB/qmRxIDdoniLcsDRgx1N5Axw7Fy/x9QAt7OKn1QhvK3slXGXGP0fRcNEPT864C8LCZmnVTM9G7KyYPiKVEql14UMQeCjPQDWnQW8VxrTmviVb60Lx6JUldlPu9CDmOFJJDJvnoyRlhSOI88o1C0yUkVLRvGM7gtClswdiXr5v6QX8D7pNePcSuzeqNofpaLzj9bleIXSe8Uo7y6REiwWQ5CZd+LPHQOGwY924D5Q7kaGDOVFGbRebuOspUI0daalxNKtKkNAZuyK0eUYcwJQPpnJPCl1UTaNLfxwMTnDayip0u3Ldsi3MDVLJ4WPdSkifQtWDoPibge6HIXI7Iy0YGGR6q6JFuG9RyTRZ8WigKu0c7CiKf2ptK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(786006)(1800799024)(11063799006)(261021130227099003)(261021121427099003)(56012099006)(261021135927099003)(261021123027099003)(261009223027099003)(261021133027099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKOICdVyBaOEzIqubrWFw40hlIsWUvfzY41LrQPdWcPwSA/41N2NOrgkqg4G?=
 =?us-ascii?Q?eSrF6zfnFD5YzkfO33AGBr1DMf41e9l55oYii8JznfSBByXnFTH1RZjQFhpV?=
 =?us-ascii?Q?+ApFaSNKSm59oqknSYDLJgGQjTBk4AmXSn6HbgFOwPetx0j9TqF3lgCD5XmY?=
 =?us-ascii?Q?2imP1AhT8Wd7IQb5LCrpvOPYnZ4e24WGVXVw5K6mFj4+rleT8W2TijCh7Itx?=
 =?us-ascii?Q?8qJwiQsVVF/Q0a60rLpTT+YII/GJ8tCNXZphQDnopeZQTcL+smdSHjbq6ZmW?=
 =?us-ascii?Q?nQdmT09R4IJbrN8+SaKqHNKbN/xL6NvBSClm8xkFP6qVOOprj8rKsbfXqV7G?=
 =?us-ascii?Q?9caXoUIZTCG9yoRAmPLwZVVLwEsaNvl8bz8IuqsQqDJLUpTg6fVQDQxVogye?=
 =?us-ascii?Q?zKtqAQMUoq5TczUaYVwbHPWgAGPe0P6H0V5qPRjrwy+BEfZata9E8yYbQ9gy?=
 =?us-ascii?Q?fSEQuD8vA2s1xAKaE3bwX2kpE/oSx3dXaSbHbljDi6Obf1nAR49VGb59iVW2?=
 =?us-ascii?Q?vcP242CYfWmCeltJWssK+OEF9zgzJKE1D4pVZ2ZQrpa4XXapbl2uR87iWoEA?=
 =?us-ascii?Q?PxC/eobxYsCr6ahTCtMIv1faj5oRs2fIz9ouS3ANj0v+20o53R7S/9lLQeYY?=
 =?us-ascii?Q?Edo8mu5L1GyeT8mrttNQZoX8cBLyJ00LcNKK09ILob+Qx9eqr4/+3jT1a/Rp?=
 =?us-ascii?Q?Uy5BxIiDwdDxEeic4nKu927TcLOAnyXLWpoOFArHmG8ZBHk+crKLLNL2q+oD?=
 =?us-ascii?Q?guMTUA9y8PbCYVqM9t2Aq8CugKnks2c0e6aRFrrNihJkL3mI8ZRqUVoUKy+A?=
 =?us-ascii?Q?+gxOGudIRRK78LYm/lA57Jm4GF8oOHnuGooGlWYidWHzDTh43YX70rEYHxzD?=
 =?us-ascii?Q?8DcjZwKg4mChoN8ANbo/3TyvIjWg32mOhxz5d2yXAoEZCsu/SLiNl0nF2Qln?=
 =?us-ascii?Q?rqIhKo378X4btD/XoI0FkJAqyfdSPm60z3Euri5GAGN/9VeJ+jnejVRayhye?=
 =?us-ascii?Q?aSK7NfBlz5gAGvRgIXrlnVFLgYqR0hZpg75xTNA57bdcgNu6I+ZXOTClIQPV?=
 =?us-ascii?Q?neV+Z6nL0O9jl/+CrK8te/O95GATYk81EOENFowwllawq0CW7A7U8UZHX8fc?=
 =?us-ascii?Q?mjpS2+yn7p4jP84KHKcOE/Ne32lVf3tIr4lmZpzcoiNi2GZIgU1fPR84ED7L?=
 =?us-ascii?Q?jwsW0+1kz/z2PGbR6rh/E4E4RXjpeXVzkUN2Ek1AdFG5su6ctaNrLW6/ehc9?=
 =?us-ascii?Q?xnK3AzpoUE0sPHyD4f62UqhZwLvjpo0CG8I3r44+XdT0nefApzxsg458LbuA?=
 =?us-ascii?Q?RhFMpb2MY6lhM5ZJ3ysvmu/WYqzbWJ9kcdL4Ng85oaEEzxJ3W2T3vIVdHxcO?=
 =?us-ascii?Q?41UMcq0p+VX2V4oznL277ShsuQeWuu94FKhXfE8lwZEFCDNEcX1/mjzrjeNe?=
 =?us-ascii?Q?e6aNeWLWSB/15zzI4gwtsrLN18QmH+vXuHQ5SbguomGsZ9IAuX8isT+6waik?=
 =?us-ascii?Q?gFaItRJxoPMasFg8UZIdHihdT4h+SfwvGkmhbCKv5E8scx5TKeJ60eLl5s6w?=
 =?us-ascii?Q?a+NkEBCh03qKNSYXKnAvC6CzCN1a5AFN+DkUa+xSVIPeYUpNL3rK6LJyJu2C?=
 =?us-ascii?Q?wFXbM8KlBAPcowZURpXqPcgbrmUZD34P8+kX9pk0ZEJdGbc5L8i6/PiGQvXt?=
 =?us-ascii?Q?2VcxHgRg6N8rueO7he9711CUwpqwimI3hKMLahDefFu0y8naUt/10pqv5lb8?=
 =?us-ascii?Q?+srVtcLKUQ=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c44f24-6106-4c7d-847c-08df2f9857ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:25:46.8233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El7QCS86N2fI+ZlDCY2KenXsZiFb6rIFMYMVCHG1O5lqa5ZQaTgorkJcHJr8SLIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
X-Mailman-Approved-At: Wed, 21 Oct 2026 17:56:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When working with systems with multiple FPGA firmwares, it is sometimes
useful to be able to use the same U-Boot and script conditional behavior
based on the FPGA firmware ID and version number. This, allows, for
example, flashing new FPGA images without flashing the bootloader and
letting U-Boot and the Linux kernel adapt appropriately.

This does two things with the information:
1. Prints the FPGA design ID and version to the console as part of U-Boot
   startup, which is helpful to a human working with the board.
2. Stores the same information, plus the already-acquired FPGA serial
   number, in a new set of environment variables (serial_number,
   design_id, design_ver [the version], and design_backlevel
   [minimum-version backlevel]). These can be used in a U-Boot script to
   load different kernels, device trees, etc. depending on the currently
   installed firmware, which allows U-Boot and the kernel to adapt
   cleanly to FPGA firmware updates that change accessible peripherals
   etc.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Acked-by: Jamie Gibbons <Jamie.Gibbons@microchip.com>
Reviewed-by: Conor Dooley <Conor.Dooley@microchip.com>
---
v1:
- Link: https://lists.u-boot-project.org/pipermail/u-boot/2026-July/626133.html

Changes for v2:
- Rename environment variables to remove the pf_ prefix
- Remove portions of the patch that added properties to the device tree
- Style changes
- Rebase after a5f93037f28624c612288e2d97604d73e03af5a3
- Link: https://lists.u-boot-project.org/pipermail/u-boot/2026-August/628811.html

Changes for v3:
- Formatting changes suggested by Conor Dooley
- Add #define for CMD_DESIGN_INFO instead of using a numerical opcode,
  as suggested by Jamie Gibbons
- Rebase after 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc

Thanks to Conor Dooley, Tim Ouyang, and Jamie Gibbons for helpful suggestions.

 board/microchip/mpfs_generic/mpfs_generic.c | 26 ++++++++++
 drivers/misc/mpfs_syscontroller.c           | 55 +++++++++++++++++++++
 include/mpfs-mailbox.h                      |  2 +
 3 files changed, 83 insertions(+)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index f57f5f4046b..fe9ce249b36 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -114,7 +114,10 @@ int board_late_init(void)
 {
 	u32 ret;
 	int node;
+	int idx;
 	u8 device_serial_number[16] = {0};
+	char serialstring[33], designid[33];
+	u16 designver, designbacklevel;
 	void *blob = (void *)gd->fdt_blob;
 	struct udevice *dev;
 	struct mpfs_sys_serv *sys_serv_priv;
@@ -144,6 +147,29 @@ int board_late_init(void)
 		return -EINVAL;
 	}
 
+	/* Store design info and serial number in environment */
+	memset(designid, 0, sizeof(designid));
+	memset(serialstring, 0, sizeof(serialstring));
+
+	ret = mpfs_syscontroller_read_design_info(sys_serv_priv, designid,
+						  &designver, &designbacklevel);
+	if (ret) {
+		printf("Cannot read device design information\n");
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < 16; idx++)
+		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
+
+	env_set("serial_number", serialstring);
+	env_set("design_id", designid);
+	env_set_ulong("design_ver", designver);
+	env_set_ulong("design_backlevel", designbacklevel);
+
+	printf("FPGA Design name: %s\n", designid);
+	printf("FPGA Serial: %s\n", serialstring);
+	printf("Design version number %d (backlevel %d)\n", designver, designbacklevel);
+
 	/* Update MAC address with device serial number */
 	mac_addr[0] = 0x00;
 	mac_addr[1] = 0x04;
diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index b9aea7e1181..8c1980faeb5 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -45,6 +45,7 @@
 #define DESIGN_MAGIC_3					0x50 /* 'P'*/
 
 #define CMD_OPCODE						0x0u
+#define CMD_DESIGN_INFO						0x2u
 #define CMD_DATA_SIZE					0U
 #define CMD_DATA						NULL
 #define MBOX_OFFSET						0x0
@@ -152,6 +153,60 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 }
 EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
 
+/**
+ * mpfs_syscontroller_read_design_info() - Use system service to read FPGA design info
+ * @sys_serv_priv:	system service private data
+ * @designid:		30-byte string name of top module in FPGA logic design
+ * 			NB: null termination is not guaranteed
+ * @designver:		version number of the FPGA design
+ * @backlevel:		programmed minimum allowed FPGA design version
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel)
+{
+	unsigned long timeoutsecs = 300;
+	u8 data[36];
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)data,
+		.resp_size = sizeof(data)};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_DESIGN_INFO,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
+		return ret;
+	}
+
+	/* Receive the response */
+	ret = mpfs_syscontroller_recv_response(sys_serv_priv->sys_controller, &msg, timeoutsecs);
+	if (ret)
+		return ret;
+
+	debug("%s: Read successful %s\n",
+	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
+
+	if (designid != NULL)
+		memcpy(designid, &data[2], 30);
+	if (designver != NULL)
+		memcpy(designver, &data[32], 2);
+	if (backlevel != NULL)
+		memcpy(backlevel, &data[34], 2);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
+
 static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
 {
 	int ret;
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
index 39c998e4c8d..bb9a162fb20 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -61,6 +61,8 @@ int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controlle
 int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv
 	*sys_controller, struct mpfs_mss_msg *msg, unsigned long timeout_ms);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
 
-- 
2.43.0

