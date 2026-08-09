Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0420C5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 18:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B04986066D;
	Sun,  9 Aug 2026 18:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEFxgTTFM6Pm; Sun,  9 Aug 2026 18:39:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C848605D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786300787;
	bh=xNjSW1Bi2dj0R+h7A2vPP+iMMhc4nz0t0T/giW1rT7k=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=RJkvxKrYXrxDoF+VM5gQ2MJLAXLxzzDbiQn3xja7jZxvES5ryzEmk3y9KWX+PF7te
	 u7pCU4V//3Y0zgAa4CTD1BOBbSyJ0Wr2FIwE/wqz1qQDdn444WxHvg4+yhTIfiiOF+
	 97tY6JYXrRyVIQ/qBfAW8JeRj6uJvHEneIGlvjszcNYQ/OoOeQthgws5quDKZqBNfo
	 VBuNUTZliJzXi/sVrVyVwU+qZt59ZXGOVb0FXBgSa5BKMQalabPt1/WM9JTheTFPGm
	 fBZT466v51UXIa3WVUH99mMcvB1tWfjc5QAj6xOdMNTQo1+ii58o2FpqAEDMqAxsSy
	 aGwOWB7P078XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C848605D7;
	Sun,  9 Aug 2026 18:39:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A55A4198
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96B184004B
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gC8VtyV_ZiL for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 18:39:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.143.241;
 helo=mx0b-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6B9AB40026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B9AB40026
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B9AB40026
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:39:37 +0000 (UTC)
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679IA1KZ1023344
 for <u-boot@lists.u-boot-project.org>; Sun, 9 Aug 2026 18:39:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4fxtk1grd3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 18:39:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDDDk8SjfZEjH1m6KtXh0fIs3QkZqliGYSViaiGKJjoMnw633v71UZA6VaALA99PafEXgfrbVSxOTrX5KlqHl+30AUAseS4ONGR5c0uvUAJunLC+uPHrACdrgyWCiXYiSqcXdSwsv5QdsFVuRI5Mj2ta/kcSH6OAzBHzhAaMYMm8MlhhjzjOSKD66AKUzOb/61Cz4o82OZ0m40LkXEm21sJMuxTVPEnTsGtNv3/b8HUBreS03W4sVZQ6+CzO7rzXhGLSdowhYYAjOu8gp2AmUeicWwDmb+Woi6v8NGTYj/irTv0M5pRx622IvtPjzpx6+LmJSQcA59hwSsvsL+HOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNjSW1Bi2dj0R+h7A2vPP+iMMhc4nz0t0T/giW1rT7k=;
 b=GM/six7Br5m2UKUXkN889gYyjIeLhUMVTCC2Vh2gftrtjTJsq6gKxI7hFh5nufWesOE984cniXlGHM+smy59c+njpkiZX1KxC2UZoccfAv3zWvJTaWTXEGoMzqIYZDdcslc0SpOJzU7/j6gaOXFmhTD0jnQnBEKuVGn4eKbZpV4v3tzsIicwRwYQ8p++E6xSbUKCdr1Ip47DEapft0ajbOI9b8gYgM8VL5hMkd1DUXFz/A5lNBWhdhO/fEU7e6QdpCpjl/I0brJdC4Htw7KUldLjgwUoyQX/bBN4zgQDcKaUH8G/7ypW86zxa1+pedNv4axB4Yw/WqVE37IW1EsDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by PH7PR16MB5592.namprd16.prod.outlook.com (2603:10b6:510:310::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 18:39:32 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::aa) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Sun, 9
 Aug 2026 18:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Sun, 9 Aug 2026 18:39:31 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679IDpci2024240
 for <u-boot@lists.u-boot-project.org>; Sun, 9 Aug 2026 14:39:30 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fxjw58m8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 14:39:30 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id t8Qhwoge1RJvqt8QiwZ8Ur; Sun, 09 Aug 2026 18:39:29 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: t8Qhwoge1RJvqt8QiwZ8Ur
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2] pytest: fix out of bounds access to bad_pattern_ids
Date: Sun,  9 Aug 2026 11:36:45 -0700
Message-ID: <20260809183643.4163840-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090169
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH7PR16MB5592:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c6c3a57-8ed8-422c-9426-08def6458d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|10067099003|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: hQBt/MPkVa+EFCBOjhD1TzNfpIvGwWSJJ3oH9ouxVtwOsqc+YhZGxZwEKhB6JexaxgS1bfZ/O1dGVW6SCgeBjwRFUCOLpvLHNRkiZNDJccLf2ng4ouPRuWX1TAZrboRcR1itg18smB16+lP2nPobxmOI5ZxFBcHNNfFgqQVMXHStE8bymxb0jtqE0Iuo6iB+NdTDpxWiZS1TKy26GzvIma8MvhF7iVjIe+8duVNcVyZyw/6trgG+Lb4JfZzSCOuCgE6QRbmpHjadP8hv10HCmG03aFeeR/7eUsHNC67RD78WKy5Xlkfo54ijU+2zAaDxqfMD107O9fKQP8krOKpJHT9GrTxnCtgoNA/GTaXwJuFlmG7qZmN40Lzdo8sndMGTC9vmrx8UV9UkFMfisX1UnSepGH2PeDKRVAgzEbYQWzoVVa6zeL2uHJ22XHxYjQ4r1+DKBAphuZwLAcFHF06p6tV5u+2vps9JEtESQFF36cI241mc/PmI91lmIXd05JiIz1Ej4poE3wTgqTlLBu7AWYD0vM2S5lH4InB3sewogwjZ3ugJ9ORByYDsnt3ByrIlENPdySoCU5dIZdbwSGIG+Yu7+K7HpvCedIbNpGdfsex5dyIteMnXSkk5Vw7PO9Hf5eECMRCQs2a3ISr8iheDOXp2fCyZ7jjEeH/elvjE1fqOACeWWXDxinEce3zyyLMr39bBl5+FFVgRIlja8dK/aA==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bEbDChzpP7BWDIang9q5zpA8vco9SJ+HBdroyzY6kS1gdP9tXPVTOwl1VWhvhECoLJ4EEmRbSUpJRTIQOp6ZQdukwRkXmt9W2AaOtHoy+3Cw9klBoGlS4Yo54TDP69VnnJsfftWY+hL7N+Q7j6dUOK6bmCIR824NF9hESSDG4BPy5QQlN017++2ykr+bszCsReB4/02XNuqg3miory+mqg4B8GBFnhJouCXhjldI7kvbhnywqzE0FhpcvcM3CiEViWREZUXuYhoLJFtWoSyt7Lfmcmgp0wnqBqtZA3LWdgcOaOAYpoPN/MRv5hv0HPpAYJoDjn0n+mEwUc8lU4QIGktlikRiE4MvjKaBFmHNcDbB6OPFzCZxpzidCYdeZmkgLLoc9Xk/r0NT/OUp7tQd5vJQKi8l4kTM51z9IdXzdO9kds3V9qQy/K4vb+zL9ey
X-Exchange-RoutingPolicyChecked: H7J+mtp9d5LziubnoVUwhEljYlUnwj5S5Ln1YF76NM8FDr404aLjzUGNL0+3JPnX0IpOaVPDFkmohroXxZY0m9GePe0dIU1d0tqodx9ADFb7Y9cN4Q3X6SgEY/vfVF2brO+F2AwpbB67s0ey5rEnvlnMQJ29SX28RNUVN6gq75Wcy6Xoeq4vOeSQcTrwwV/nPgdYub9cUY5lwba3lBIUaPXaFUZs7wcA9/G+uhpi2xhaR662L/hTOkRZs01XdGFV3Q9jk5oFlkWlXOXwtfky9FMFApg5bW1X6YaZnBleazxN8h5Hk7rFI/VfmbOhwuOuFrpY2TwBR3yfIxoVEucapQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JV+64ybFNi7yeHaYc45WkyGNJCwBziPU4Osfx4piJMWl70MxsYwuawOKRl1YgKcV959HsfWfEkWCSkm0jdWbj6J38P6J2U50He15MKUdm0kmu2L8vjauEsD0SkiyKFaOeuq4OXX9eQWxjqVhKAiooXgQaSbh1EqKbg4WD+VfqDYjvxcUVevnCTikp11HbB1sb3MxmSaZXimp9oJTEpQ4/rgmbPeodWKlPmms6rlMi5RRnyVNKWm3DFJiZdMTY8bnejqb7mlPlI2CvJyW7ytgb5dQ1tJYaqtSAkv0nT55WS6ZzHQqC8ANYhUKemiwOyMG/7DhaQ+8t/ExEf6vBqEobULZE6v/X/tWa7R1kBDA/VHUWl3aO6uO9Z9HAEqJ3RlGSrnw1geR8KSmJpwQQZ7e0lNboPmbKhFJaJakphN+yMrvuUBT8XhRueD/o8yW1qL9AaMNgsa1oiP/FmXZeCrTPSt11Bf42huBsXldkbUgjvQPz377057G+S4a5c4EbdMpHH+dHRjiJ0OGlA6i0J7X3Wxgvy7NlFCwylw+vNVsZpOurgO3hWVyQyvAhnb6og1fXwB6+ieXfbK4bVgC3TcQGz3uOHqzBYd1Naq9xfu+CEcpVIap8RvB+K0OSt8kE7r5
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 18:39:31.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6c3a57-8ed8-422c-9426-08def6458d61
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5592
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2OSBTYWx0ZWRfXxt06pd8BxvEy
 hYpr75h14wNKLcjAaFUt40KkXFmwjeLCFkfUCwuaOo7/pjCfb2CHLm2iz//O2y6x7rABOUrFTug
 pRI7PtLE6zaoQ92ROQXJSnjHjRf2+FkxKlGg8MgP4ThUOONNOC/3
X-Proofpoint-ORIG-GUID: 1t713uUyXogTbl7jqFcu8HTSnXO_pF7U
X-Authority-Analysis: v=2.4 cv=N+4Z0W9B c=1 sm=1 tr=0 ts=6a78c968 cx=c_pps
 a=3TwBhgzW/NSYP80ElIqEIA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=WP5zsaevAAAA:8 a=XUzn5iZ1LH6S630AskQA:9
 a=3whSkbs7g9Me0DR5EJEX:22 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: 1t713uUyXogTbl7jqFcu8HTSnXO_pF7U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2OSBTYWx0ZWRfX0cWk8Xx/HKYz
 vpfEHm5oUW9iLqAgex2SU2KaSSC3LyT40vkfZD+BYtErfPvykFiNKiHCXRtbD8v18dBkjsWeB0B
 HctsztGOgrhvFIvQ1fy0dnWzKGqrQcKcMVCpvSuhBVWvlioo4J15tacOXIX3hPhs8q9ijMCQCMW
 uGMNPpxdihBhfeNf57mHOhTlZOgtgbM40dIQbGPfQGdXlOT7a7C0KC9HJMEvte1kzNTcw5p0agA
 LqKVd9rYN9sKnW/i5NTuj93KNmqtAQzwUR+eDx6vR0WJzve0IsSNewyyUg0raGyNUXpNG9x5NQ1
 A+XIJKHEYsSG6wAyBiD3+vFV/d3C+wfi6GG0fXPDJxChUuVFLYK6oI0urWgE2AnBQQumzo2LTbZ
 6gBXLbQw9/HFR3LkHCdHZQx8ILMFeY6o7nw152wuLcayi5hUqguuzjTULA82GUqoFML3Y+9ddjB
 myWC7bNfEyUjpXBSjUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090169
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=xNjSW1Bi2dj0R+h7A2vPP+iMM
 hc4nz0t0T/giW1rT7k=; b=t6lJz2nTiMhj/gAUBToDOWUmVKE1E1E7u0ufEd/0F
 BLcvpzc4E2WZ15H6ouDE9nhQAKZPqyAR1A+GnKrwxK+h7N2OrlIf1VCphW2Wj4fD
 LyRwvFrX8htESbBx4CkYXq6FAvEJZcPEwq0cCew/MQ6stZhnE8j0HkkyTigmElah
 0Bxnv8tKYU0v1ElWNyJAP7zwJEDvLMwTJlVv9oeetCsPpGxeLzIg+ZGXOzd6psBH
 ZFbZ2rSmQEIcJaAEtqF5IQwaT0G6T1bKxd+VBfBXI27Fzs61/W+G2NGZGdMMxh0o
 eRjaqkWbjFy8MqamX/FpnwCYjPsdN7ysH3GlstXz+g1TQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNjSW1Bi2dj0R+h7A2vPP+iMMhc4nz0t0T/giW1rT7k=;
 b=GvsQFXOs3SuM3MFc6Yre4ITE2/JCWfvUAzdU+Uk5uhqXqMNAgazg3vo87fEm38xaCT02lLHMKrAI51ht9WzuuXRF48ZdUgw4Nzy3aDpVD6fCWlvRBZUFPoXZ2nI7pmSgU6Vesopaxyfgd4xMX9vBAwxQMNqCbII1hEmQw/j+cdY=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=xNjSW1B
 i2dj0R+h7A2vPP+iMMhc4nz0t0T/giW1rT7k=; b=mctC7BcnnEufKpXegXKVaxF
 XfMM0bVcs4esHpjbzlFJYmDCj2mp8ulapw7Qwc2XrRK6Lyxu+ErK2hFYuSPZ7VMy
 uLfCsyatuHMHrbhdqYtr9DDRgwgVLW0OuF2/PX5cntUPJM5wLiWnrpPQiCXBlvAn
 CX5ADBxrqLKSHgDswFuSOXYwRFfBvYGJlvjHtJL8n51bg0DfAbvpCUMeDfxm6ObG
 i1vgLyFwuXQ9iLV5CkfY8KiNP8SSjVJYrr6CIHCeb2olTb3Xzq5FK8aKJwW+0TFL
 cR54+KFxE+q/GhVy2AvizbZycRKz3W3m5ALREp6cUM0a+B5mk/gunUGfW22HkMg=
 =
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=xNjSW1Bi2dj0R+h7A2vPP+iMMhc4nz0
 t0T/giW1rT7k=; b=hDB2FAIYKs6CqoC0ykcYElitrAUcq/qd0/2WJhNSZDhAaKX
 1W1BBof+aJR0WAzVPKf2h0cTHI3Dq3OX5+/7FoQsF7yPZF+Dwq+o1G/0HfY7snk+
 xDOaw/JcGhoZKml3r3J85xLmH+56Wd7PKC8dtyeLa/j7LNqvQ5iyVDuw01DftA3r
 nOFzmEaqaegiNqFiW+x0jB3G4Qu3uSUWYMvRWq+3HKzhQgxaCsS34sCy41kqElgL
 5ZXNIeHT/LVrbkzEhwjLaFdKZfY9dj7qAMjG57FvujF2JTdhUwa4/w012rPFiIip
 swOyKnohuA2mxOyYO+l9Daq14ia6v3ux0hzKY5Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=t6lJz2nT; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=GvsQFXOs; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=mctC7Bcn; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=hDB2FAIY
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

With 'pattern_lab_mode' at index 1, every bad-pattern index is off by
one, so the wrong id is reported and a match on the final bad pattern
indexes past the end of 'bad_pattern_ids'.

Ensure out of bound access to 'bad_pattern_ids' is handled correctly
while processing test console output.

Also, uniform accesses to 'bad_pattern_ids' throughout the module.

Fixes: 8308a5eed6e6 ("test: Introduce lab mode")
Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- updated commit message
- unified access to bad_pattern_ids

v1: https://lore.kernel.org/u-boot/20260729082350.2276234-2-dmukhin@ford.com/ 
CI: https://github.com/u-boot/u-boot/pull/1035
---
 test/py/console_base.py | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/test/py/console_base.py b/test/py/console_base.py
index 88d444b44b88..164a31a9f712 100644
--- a/test/py/console_base.py
+++ b/test/py/console_base.py
@@ -212,29 +212,33 @@ class ConsoleBase(object):
             while not self.lab_mode and loop_num > 0:
                 loop_num -= 1
                 while config_spl_serial and not env_spl_skipped and env_spl_banner_times > 0:
-                    m = self.p.expect([pattern_u_boot_spl_signon,
-                                       pattern_lab_mode] + self.bad_patterns)
+                    extra_patterns = [pattern_u_boot_spl_signon, pattern_lab_mode]
+                    base = len(extra_patterns)
+                    m = self.p.expect(extra_patterns + self.bad_patterns)
                     if m == 1:
                         self.set_lab_mode()
                         break
                     elif m != 0:
                         raise BootFail('Bad pattern found on SPL console: ' +
-                                       self.bad_pattern_ids[m - 1])
+                                       self.bad_pattern_ids[m - base])
                     env_spl_banner_times -= 1
 
                 if not self.lab_mode:
-                    m = self.p.expect([pattern_u_boot_main_signon,
-                                       pattern_lab_mode] + self.bad_patterns)
+                    extra_patterns = [pattern_u_boot_main_signon, pattern_lab_mode]
+                    base = len(extra_patterns)
+                    m = self.p.expect(extra_patterns + self.bad_patterns)
                     if m == 1:
                         self.set_lab_mode()
                     elif m != 0:
                         raise BootFail('Bad pattern found on console: ' +
-                                       self.bad_pattern_ids[m - 1])
+                                       self.bad_pattern_ids[m - base])
             if not self.lab_mode:
                 self.u_boot_version_string = self.p.after
             while True:
-                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
-                    pattern_stop_autoboot_prompt] + self.bad_patterns)
+                extra_patterns = [self.prompt_compiled, pattern_ready_prompt,
+                                  pattern_stop_autoboot_prompt]
+                base = len(extra_patterns)
+                m = self.p.expect(extra_patterns + self.bad_patterns)
                 if m == 0:
                     self.log.info(f'Found ready prompt {m}')
                     break
@@ -250,7 +254,7 @@ class ConsoleBase(object):
                     continue
                 if not self.lab_mode:
                     raise BootFail('Missing prompt / ready message on console: ' +
-                                   self.bad_pattern_ids[m - 3])
+                                   self.bad_pattern_ids[m - base])
             self.log.info(f'U-Boot is ready')
 
         finally:
@@ -321,21 +325,25 @@ class ConsoleBase(object):
                         continue
                     chunk = re.escape(chunk)
                     chunk = chunk.replace('\\\n', '[\r\n]')
-                    m = self.p.expect([chunk] + self.bad_patterns)
+                    extra_patterns = [chunk]
+                    base = len(extra_patterns)
+                    m = self.p.expect(extra_patterns + self.bad_patterns)
                     if m != 0:
                         self.at_prompt = False
                         raise BootFail(f"Failed to get echo on console (cmd '{cmd}':rem '{rem}'): " +
-                                        self.bad_pattern_ids[m - 1])
+                                        self.bad_pattern_ids[m - base])
             if not wait_for_prompt:
                 return
             if wait_for_reboot:
                 self.wait_for_boot_prompt()
             else:
-                m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
+                extra_patterns = [self.prompt_compiled]
+                base = len(extra_patterns)
+                m = self.p.expect(extra_patterns + self.bad_patterns)
                 if m != 0:
                     self.at_prompt = False
                     raise BootFail('Missing prompt on console: ' +
-                                    self.bad_pattern_ids[m - 1])
+                                    self.bad_pattern_ids[m - base])
             self.at_prompt = True
             self.at_prompt_logevt = self.logstream.logfile.cur_evt
             # Only strip \r\n; space/TAB might be significant if testing
@@ -412,11 +420,13 @@ class ConsoleBase(object):
 
         if type(text) == type(''):
             text = re.escape(text)
-        m = self.p.expect([text] + self.bad_patterns)
+        extra_patterns = [text]
+        base = len(extra_patterns)
+        m = self.p.expect(extra_patterns + self.bad_patterns)
         if m != 0:
             raise Unexpected(
                 "Unexpected pattern found on console (exp '{text}': " +
-                self.bad_pattern_ids[m - 1])
+                self.bad_pattern_ids[m - base])
 
     def drain_console(self):
         """Read from and log the U-Boot console for a short time.
-- 
2.54.0

