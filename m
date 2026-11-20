Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50C60A261F
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JjhAm4x9;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=mp1cJVRM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C23226062B;
	Fri, 20 Nov 2026 18:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0iK-y_zeFcb; Fri, 20 Nov 2026 18:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19E786066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795200291;
	b=sMib54wsO8Ictp5saEEzjSFWfT1nECx1HuJT16mZOh9lGHkyFbzGRDH99zt4d9k3o6DC
	 wtcsmC1eF5to0WWULscCjfUmcI+7Oj18joqpH3gjxVMswxU0wYEvOi7w7d28R4FXnwVgu
	 1L0XB7JJPHMV3s0VENg00v69FRsGalxrIbDebK5LF2AUCtmhSEOnPmYgNUq2ZeFQH1Xiv
	 BEs8S33nZZhCqjDXbEVgNNx6DNzJCkbAHOhnLd90uNIvZlJvGM0kDPWz69jnTOEZj5xI6
	 ZDZ6lsw2SpAOguksqUz/D8OHnaKFKCUo13LDzPGbdT3M4Ta9+Sk2U/rd9RUJGDqu//Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795200291;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4TjwaOJu/AYctq3qtJpIPyzta6hlTgmjRKdFhtVJnKE=;
	b=Mag9963kPLvq1jeuIaAOW9wUaPa5Q483Yo+UfyH0IRq79q5RuMeqz5sMph7LxJsp5U2O
	 sQfTdZjNY5Gr5Aum4RB1a61oHUOvEjC1Fh1sZyHAFktYwjRIAjR7wkMrL0GAMJLZzeOmb
	 HzJdFM44b4bUcRzVlWoirV1fSnuLkvL2Iy0DoqDyOx8NOblbLJSA7/vXKy/zYthVoTcMw
	 fnnYHkV5CA7t6RKKcm4xNqTxK4Farn843d3wXaLR4ExbZ9prLp3wusRm8D3sUmJVir8yF
	 oz7wjTixfhaPyVQ0MjE3dsjFVSJDTnnvloU6rTPYZ/3RpXamS5mvJqI1q9FF1C2LStw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795200291;
	bh=4TjwaOJu/AYctq3qtJpIPyzta6hlTgmjRKdFhtVJnKE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JjhAm4x9tImWLAR9CsIhTYsuAy2BD9b/5KDgbrjvXXIJVGoYq+r216/mLcfTBeMI5
	 b2NgAOIi/Dh+rbFVim6yVjZJ7M8Kxd78rl5WojnMqZW4i9/dZEXX0WXlLh8G1ict5+
	 NIK6Ncx8pDmcEROmDO8zxlyxzdkYr6GeqE1kOcHOkEmeCpsv/tgLuhn+fZolqn4KPq
	 NopqtdJxSqNfq/MUXbZjoivKmLhN3h8Wqp9XUFUyFdzwk6vfteGx4MFHeL+XsB7iVt
	 RPcFxon/vDJ8tj5EJD48Pn0mqW6UA6GQqTaF50TviBnDLLoTT2mmkh9NHUvX+oKZc8
	 I63kD0IDvz1zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19E786066C;
	Fri, 20 Nov 2026 18:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17D08E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1527440098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hEsSJkxTWyq for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:47:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D52D40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=mp1cJVRM
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D52D40050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TjwaOJu/AYctq3qtJpIPyzta6hlTgmjRKdFhtVJnKE=;
 b=mp1cJVRMXOHmtwZqVCUpuQee7rjfkAT8SZqJSZ46b/0n5kyLHCVnEbTCqUa4KRzX9M1YZi9gp7icKA2AwEqrl1DflLtJtx3Zan2tcK0LWfrc9bhbIi4S/1uZlvFQpN3gto+qNakltNXyte/DZCxXw2r+JKu60cvIg4KeBqIdBouZmK/A1LuW+mCINHt31pfKYqYP9JLsYqOX0uE83G5hY+oQ28KGxxPpgl3mnq1VErNKFbegQsR/Qh3sMrumcV56rwcJVa5Elp4meNvvB9JahXS+wHuILRPL5X6e+uXTP7CZ7OqQKKysIemH+9Gf53bwN/pyMR71rildAGnNLiSJTg==
Received: from PAZP264CA0038.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::20)
 by MR1PPF338BE521A.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::218)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:47:44 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc:cafe::a2) by PAZP264CA0038.outlook.office365.com
 (2603:10a6:102:1fc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:47:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:47:43 +0000
Received: from sah2lpt245.softathome.com (unknown [192.168.72.196])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5622C1FE78;
 Fri, 20 Nov 2026 16:47:43 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.u-boot-project.org
Cc: alpernebiyasak@gmail.com, trini@konsulko.com,
 philippe.reynes@softathome.com, paul.henrys_ext@softathome.com
Subject: [PATCH 0/1] binman: fit: skip empty data property for
 externally-provided images
Date: Fri, 20 Nov 2026 16:47:36 +0100
Message-ID: <20261120154737.110128-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR1PPF338BE521A:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 925a9aff-884d-4825-ce8c-08df471d9de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|6133799003|56012099006|10067099003|261102123227099003|261021123027099003|261022115727099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ixBS7Q30ecBDGaR9leWHUfSfE8XAtuNa1akU/YCB0dbZ9zjOLwwg0XWVqnjHOAo/1Ufh+7DA6xj80Ly2ia627JqrKmbTwhPC0R4rm1lHlO/y1E/bTvK9h8ITExdeiLBDF+odpb7zLVYv4uljKMDChEej02AMeQUwvfo2vRRtwOTDpZRaZ2RM5RWIXJZhqsPNCVVnxsfwvw9wSDgxcG9fIeLESDrXJCg6gl+mLqGx7iIkzwXK7kdxWgl0JrQgasy2nW8GpyVOnjCRQh5EOG6zk8ZmlvYO8Q8A9syPIYFMXy/1wICXhah8YB69gQvyMVbUtWsHJJsTrN8I0BotGeqDu693COycLYTGg6UKd6NfKYDHWDxdtQk90TarC9MWiHN1P2gMY5kvVZ2lcNWxfV6YoLNfv9VqeEDacBx5u/BAU3U+qouPKPxtiMzVVzSZgSZF/8lgddebhpH2CmEfnUaRgN7oClN/33P3UbRydSmHnd/weFacJvgutHsaRoAjBHTbF4WCw7PjioZyYpxFpZ5GzQUODfXCIVnp/aw9tBLB88mgjP22C3jEXqOKO5wVTqyr+eOF9g021YBfVFjSfawe3qCQbxCfPiDxAwR6kXI9mweEXzZRz6RsLqVf6kgqDd7n6ST2Ado3KMyO01LtC7zJAtQPbh5aItLeekp+SLS1d63WZRTRWd/PCEUYrcddEOfAOKBy4ahxNAy7YwcHoH7gIQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261022115727099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4FMy0/5LB9soJNX+BuxPiYIhBKOhIZse4U7w1CapYudUW/7EjSejmIQf5JPuREp/Bfx1MG9HzCStsSK6vqW+oPeEgZmGgPcS3fhA0EAuvO7CeQLqGdE+C2UhWVs58w8P9uQTOw+S8p0yX1sbKXmEsuQlggaMmrp/SbThm2gQ86SC12xQpp0L7FVSIXDAiBEer4Hea5QXiqTsHUigLElbjbttgO6ehuRUof2Kf56HvxCCwq5KOyd9kgnEwyCjpCHcx5DayvybZLXkKgEeuJUodwe3b4LTAzYwGJ1XsA/xeW23XSzToCtXR5ZigN0DHTVJzrwR0MgONW/YBoZywVjP1cFweDzx6RHZsuxly4PT4oBsMvier4ZLDCYIudBxR6+/BdD7o1hvg8+4YyckX/4lC7ohQgHFNpBPLDKHioTsn1l+priQJ2HIsog4oOmNxk8m
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:47:43.7848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925a9aff-884d-4825-ce8c-08df471d9de1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF338BE521A
X-Mailman-Approved-At: Fri, 20 Nov 2026 18:44:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When generating a FIT image with binman and storing its data externally to the
FIT, an empty data property is still present in the FIT header, alongside the
data-position and data-size properties.
This patch prevents the data property from being added when the image data is
stored externally to the FIT.

The current implementation produces the following FIT structure with an empty
data property:

/ {
    timestamp = <0x6b00252a>;
    description = "Kernel FIT";
    label = "kernel";
    phandle = <0x00000001>;
    images {
        kernel-1 {
            data-size = <0x0096f890>;
            data-position = <0x00001000>;
            description = "Linux kernel";
            type = "kernel";
            os = "linux";
            arch = "arm64";
	    data;
            compression = "lzo";
            load = <0x02f00000>;
            entry = <0x02f00000>;
            hash {
                value = <0x8a206366 0xe4a74eb6 0xe0e65630 0x31543640 0xc999a554 0x0b446c28 0xbc23a525 0xb7459f15>;
                algo = "sha256";
            };
        };
    ...

Paul HENRYS (1):
  binman: fit: skip empty data property for externally-provided images

 tools/binman/etype/fit.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

