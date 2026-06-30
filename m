Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524F3C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 14:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C138C84A51;
	Tue, 30 Jun 2026 16:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ao/MJUMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3EB84A67; Tue, 30 Jun 2026 16:29:47 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DB284A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 16:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3UCsWrUyZ61ctcLN0Q5CTBTjQ7Yzvmg1yaNg4beTWVh8qpmR3GPyoXjGva8ZJ8SY4cuTKtk1U6aku5BFlmw5aM8QLUY+gIS4Mhv2y2U5xDIlfWSSmQAB+sZr03xT+6ahU9B6JWzcvrIu23wmtJzSSVj8HT7pLmUDjwPY4DHdJjAIHYya/VOCbT28v3N6TOQvTn0bzswqIgwl2fDs3C8T3Et/53LZ2WfO6pFdgXqU4NOwQeJPYuxnaVMSRMU6mWbVfR1BisUv3C1YJhjzqsm8efLe4Z8SRabJFoRL4wimPqNYtDZvxP8QCbbX5giKn+KUBmRFagwMIjvDKaRZXpFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6rWTTSttdqBseMraX74CE9bSxQjSHWID2QL8DZ1dKE=;
 b=xceyBbTXpWqxa+95vw2VgDcT+/HMz5kT8ugWX+q3tJWUm33U0EcjlYr1c1O2mwWb99PFwLvOpFGwrSMRThphQv2ycXuEz5gh09EYvIOcbCGYV8DwhhH7WKbMVtSWc2iMyzkjmT2EYqYnpBH42sY5NRmW/EBS87ZCRhDl0GXgLdTQ2azLqCWEZEc3bhM947oecvA7YJPBsuhC46ZQYIgZxyfoKhWAVXZ+zurlmVjxkuDNOYU3xj5j2lyraTou+ZEr8JS87gqMGsym+oaxmGg+PQ/5ohZxM6keeHCrGbtjFIqi+ML9jpQhq2x6aa5ywRdUglrnUCn1qo0IydnhnF2o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6rWTTSttdqBseMraX74CE9bSxQjSHWID2QL8DZ1dKE=;
 b=ao/MJUMySq8XSxHDnl2cPWCEtU6KGMhbACwv3pGnV/Y2vVb4lIfs7r5GFiNUeiRXukSkBDWVYuVUpo4Byv68dkCJBoQUuGmFdRqGmnggxTo/nBiQ6IfX26S1spvnbpWecRWaBCD8XAI831tjBgWk2YUvNhTWp64z9HOQ2wqdc8Els+nT2A3XPEz/ftop0cmSmzB6LVTp/C1bqbEkqyN6eZMxXKuI9OLSfTkRW4ssRF9W518wM/3pRnJ9jqHEiQ2Sudb4ivjm8V1bKyvtqAI38+Ii9DwSATUfst0XrdkN09Soy0WYmTeeokxIJ/tBhrVU57EtvlddgFz5I4M+A1C3Hw==
Received: from CH0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:610:11a::32)
 by MW4PR22MB2975.namprd22.prod.outlook.com (2603:10b6:303:183::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:29:37 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::99) by CH0PR03CA0346.outlook.office365.com
 (2603:10b6:610:11a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 14:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:29:36 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id E733A1290D;
 Tue, 30 Jun 2026 17:29:34 +0300 (EEST)
Date: Tue, 30 Jun 2026 17:29:34 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: u-boot@lists.denx.de, HuanWang@gehealthcare.com
Subject: Re: [PATCH] ge: common: vpd_reader: fix errloc array size in
 verify_bch()
Message-ID: <akPSzixRRmLF22lx@zeus>
References: <20260630133939.1472106-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630133939.1472106-1-shofiqtest@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MW4PR22MB2975:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cde2d6-cb58-4161-6415-08ded6b40327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OI+vjbIuswhLM+WKUsDKMbRANY7zNSZe4CPiEHEbAIoLuj0WBXsPDXugberp64Gj8zvPCg4945qMl7kGvgtkWQ/PhvVoKnevTvZzIhahUdf6Fl4vl6T8Q+cOWtbfOCYKFNCsvOmdVP69r9GOSZ6a++79SFEbc8raaWEMe22glI13Q1RpQGIz2HhlJ21LXVf0CPbtXskP9aZDxBahMiV/9JM5YwvaPe2G6GLO5dc5Un0tzSp4C57Jk1h1SOj5OWs3DBCtu5hFnTm0MxfMZaRy27oibDgn5rlyyJKLsbCmUxilkgzD5J/KOpN69QjM5+eWEV+A5Q9+w7hG73gjqAm6hgfjj/NcV7cpd/ZarOt/rq9pCWs+xUCuD9llNvILdAHojtQSxduJBbpwFnHCD7YOTlRxkUrCuXWDH6V8jL0SuNfaIAYobVh9OkoaifEUWNNnTVtlEsmRAifQZ6T44k8JkkeCz79nZ/6IN/VDFr7P9nuDMx1a8gac3cldPU/Ypdc6NuskcJNDDanU2BX+Yft0H2v/d4MCFtTS2ToGlYFLqog0Wngmx9vdLB8qzTJMJ7IXxdoHXG6IH0gZAD+0B+cQRMnfbidYghKfRBN1lnqqnGKBDAb0oZyMMV2GLMjg9JWp9Oea1QCwsq7820W0GA6KaN5xvCpN8rGHJ8JlvjzYURB4e2t/uXuPKrbnfcwD71S6Pi3sYSX7+LM6KhCLq0Ih7w==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +PVx/ixV7YQV3++Fohu47Rxr5ccW9XRAA+x2Sl2PizV6pkJqNg0H+bstKYB9kidS6GA30sKCzlN+Xdt5ggvLICaf7OSsx3FFiZvwZOZ8NUy/AGSTRnfWc27nRwfPJ+5Q5iJPiCGt+6Bkg/iHDSTq6o405xJR3z0pjE5Rce9YmyPatj+BNueNFZWcgMBUZ2iT4e42YSSzZyo+dSf+WKFGt4FCl832Jr85XwfzprFBCkeRI+iheFD7+lRjfKGOaNWVvj/wOD2xaAlcOzqbFaudhOEnpvkw7Qtbd71g8Vt7hLrgF2HgtocJ5XmYscoY0yD7h2umlpFuR5FO3bWIQl/A+psaT0TPNCYAtOoXWYoNKMfR/URCPFT/IOVHZVcp09m1AWviGjlglpJvLqyoHGRtD347SKgpd9sbGx2r/guj+5mNaed8woJZIBRfsgtNlhny
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:29:36.7347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cde2d6-cb58-4161-6415-08ded6b40327
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB2975
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

On Tue, Jun 30, 2026 at 04:39:39PM +0300, Md Shofiqul Islam wrote:
> errloc stores bit positions of errors returned by decode_bch().
> The maximum number of correctable errors is ecc_bits, so errloc
> must have ecc_bits entries.  The array was allocated with data_length
> entries instead, which is the number of EEPROM data bytes -- orders
> of magnitude larger than needed and incorrect.

Good catch, thanks for fixing this.

> 
> Fixes: b418dfe16e62 ("board: ge: make VPD code common")
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  board/ge/common/vpd_reader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/ge/common/vpd_reader.c b/board/ge/common/vpd_reader.c
> index 2422db38013..b3f9e96615d 100644
> --- a/board/ge/common/vpd_reader.c
> +++ b/board/ge/common/vpd_reader.c
> @@ -66,7 +66,7 @@ static int verify_bch(int ecc_bits, unsigned int prim_poly, u8 *data,
>                 return -1;
>         }
> 
> -       unsigned int *errloc = (unsigned int *)calloc(data_length,
> +       unsigned int *errloc = (unsigned int *)calloc(ecc_bits,
>                                                       sizeof(unsigned int));
>         int errors = decode_bch(bch, data, data_length, ecc, NULL, NULL,
>                                 errloc);
> --
> 2.51.1
> 
