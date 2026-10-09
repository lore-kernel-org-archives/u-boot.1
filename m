Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81430CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 08:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5A2840935;
	Fri,  9 Oct 2026 08:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfoTpub7-Q5b; Fri,  9 Oct 2026 08:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA1914087C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791535630;
	b=UmhbxtT5bBTCSKv4uEjp9gaxQvshtLL9RBUrLHDow+t3wVrRaekN6vlgvugbsat00BH7
	 SokF2eK6v1KtMpW8vyOtOzqu/me6Hkh498PTAk2UCbrwCqPM0M/hMOZvht2WExbfdU6+A
	 uy235zPZlcF9/z2pVx7VBHQWRvkRIkH3FZmFgYuT24fnYzxioGHZggGsVS9K8Zw0QkRuc
	 dEd2fyFwomh8x2vfv9DSE4/p9WMleFZujQ1RAYtIa6Fx3cgvHUaaO3EZfZCE79QK4MO2m
	 rk5paBHl+idheO1CoA93Vdv8qmzU7AtXji0BD6Mmpn7DKSQrUWiDXT2mOqOo0I2BYxA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791535630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
	b=Mqy8+1HLpOJACRIuaH0HjRY1vM2zuqDkAm7cuh+jYh4a+1ThuNtN+AgJZRnkfot8KFZr
	 IX20ckIiBKamH+BtbIVHpM5vOBjo9eTmzthAAJj+3jWOGkWgx7QbijnFZDknZVamg1Vfm
	 Hb8lupXODtqsFxg0YDrPAa7RF2JF2iVVAX/HJ/ldFLw7RFvMe097NjnhToeMdgMAdk9tQ
	 G8N8CMwgwmQ4rMBetDHzllI9gwpFWtKzEIS/rejplFAMwp5a9mq7M4+1MhCh5T6xtyc8C
	 fxP61T4Lqm9G4pHoHYlcWYB/unKqZ1fS4Fua5OzykPOvaLnB3CDE6rj0sUAYLKFbe4g==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Q3P7Ae97;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Q3P7Ae97;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791535630;
	bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0r9Dm5SpKGUiJ6H5flw7LSAhKgkm01/yIqhAwMQu33n7MQ9F6wbc1VWEaIQu0ECf
	 LWGBFvKgrbT1g0qatn/VPR0aFfdtxn23MBLlBr0WwYGnV6Ug66FR0Q1t8Dza7HFkea
	 k1rhsr2gyehsnrD3kp47Yu+aWSO9nj2WIE5kSbXu27K4R7gshmATlgBvCw9YHRJb9G
	 uID6cEDZLGuE/0bvFM43DjgjpiV4m5S0AX+VQjqssl4Rx8cqTbc8vWGIaPmVL6rE69
	 RstXdx4frmBliTp1huXIyIzpj9jr/7T2Lh/WZeUgQu8G18GgEqc7yJ74jgr99Ketru
	 oS0cEmPE9XUHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA1914087C;
	Fri,  9 Oct 2026 08:47:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF00B1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 949D74087D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xAYRHDloo-N for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE4324087B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791535626;
 b=DamtR4dKgkwPF5GLDdXJs9IxNRBQ40l1GYtQ+U4KZLGKRKfqxq4M2fQY/KB/kvl2S8+s
 5hruaxewhDAbxlAyy27rdCf2Nk+dLd/7n9tbWD6b2dZr3w8uWTCGVkz3Zv1xWpaKgBcl0
 xj+a/1D5SyWr14QTNTn4+ga++32brFTiQy0T01ZD1GJWRS7rGB3VRXXC4AXkUdJ8RRYy7
 YtQU/B3PceMcu8q3Z84LA+MCJfPHFs/shTXVGfSFEAwwXHLgTlPhDAqEbXHnMc/HrK68L
 8rGkr08TvN+D+YHwwn05CDN9KijBFtRTkXgRLG2na3oOjjfZXI1qBNbNye91r3E6nkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791535626;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
 b=D9tBXNX2m/nGgy3R0uT/wngzt3qBllZ8DIa8q80++PUnRt3mMvg9OlNs2fGSV8bfROmh
 llXUrxs4VHMxJxXfCxmM76Ny0YkqVROvEBBfiCcJDuXXjCkinQcbHb8WbnMXd8KjjLn/7
 yXpaZPwppIfbENHZ5I4ZyQsgeKhfrzsOK/XTw08H4tFlIrcxlDA8tHu/R79lS4KFr0vc7
 JyfkgZ7ZaJaGd68XSYWXkWFIgiJ+oT7y6279lLjsaLz+x2vUBiPtfYt5Tk8l6c+59sBZb
 4phHZOR7eKRla9NAPggCnjyFmNsLeE4L8dUw+JK76Ev9lrsVPSPfOQOOygT2J76ztRg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Q3P7Ae97; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Q3P7Ae97; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Q3P7Ae97; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Q3P7Ae97
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE4324087B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:47:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sTqZLBmmTpnHxdEUI79rKwXI2hWkg3uP4j3++vseUKa3wm/B1KQOTxekU6/TmfQDaINBqNMxOpyT7Q5MoJNzv+LphwexVQyrjVSyo4G5bPavzpswW82JxIS4CkA4/vGajp62GQfo8S/Ws7UCweuxh+xPhFZpaRSAZNZ4Ov+Ykl52FRCQwkyD0yvx2TrMsdKGjcaNcS3qpvrN9RhyeSgkZlQhhHZ9MnF95L37fxCZWhmDZ6/StyLk6o8oWZiDTpS4npvebhypAE2yqJ85UGnBQBFGekHUP2b13C0NYCirNgQCn+hjX05e42h6F6w2F5fo4EnMf1dFONh0zLHysp8NqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
 b=UgQR5lGlD+qrIuwm0nCLp5e/PhY3MewiubF7UXzc/xd/ImesPpvQ5YqGYGNU3Ewf/M5YiBYBMFpKpg+gFjiwQIsRgQX1GIEQCnaKYc8b+7tv4oAiqBEcFvhK/lxYbF7Gb1KKP3ATJd3uMFQMFh1OxZhqVCbqmVTCOY6gS+VHQGp6jZQ6QAHbweJSCXBoeq9XjaXYJKNIrVlbGESvu+2jYH9zYFhrnL+KF1xsnE7pokOSt6qIeLk7kketa6+JzDHVTOwK+QJ4xN8B1G9BuxtwFHvKsGYXh5VMfJjhteACvVSpnlauuZ3R7WihZb99MvRSuIgY2FVNwyzsEvg1yLshnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
 b=Q3P7Ae97gdzCbkVvUHiIdbF86tJh7g2Gb6pGaUqmG0cf629ZyWgS3RZ9DEAanaR+mViJaN5qPyk02qPGID7WVcSsdD4pcMZt+mEyTso3Tj+KrfD7wZ+RaRePUOJv8fJm4hm521AzYCQ5NXcwIUbtgOokIzR5r8fdNFDxm9uJt5o=
Received: from FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:b3::10)
 by DU5PR08MB10399.eurprd08.prod.outlook.com (2603:10a6:10:520::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 08:46:53 +0000
Received: from ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
 (2603:10a6:d10:b3:cafe::87) by FR0P281CA0156.outlook.office365.com
 (2603:10a6:d10:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 08:46:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 08:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oej35kHGs8eybLNU1v/AnCiG9Va10/U40qxUSD/6En7BcDLs3GcM4pHv+LvAhwtgwpSTtxk0S6p5Ak1jid4Cap4ExGOkk5QpbY3508BR1qqr5o6OzkVv7F2Zao5Qvf737NO9dEY9+9U8WfjK+YEGkndi9vdfehtv0HesmwJl5ogQcZ2pkndS3bz/nbJoxVzwBFcwegj5sTJy6pMce07mbtlSa6z2cldIBQtKpAE2f62f88qzRxHFwtdN7jbNq/v351nRx9Az89scUdqpRisqKcn2Of42Ka2mC99806nJxJZsluJBWgU424BpkL2rddv903H5eoLm/Swo5nCoD777JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
 b=lZFlyUP+gpCCDyg5LL2TOXZBcLWxJlvwc3lkkBLL03ayK0lRAJyeQSKdOUFZ4i35FwDNNzp0ZY8yZHGUZ73JSAmC/4iXnF7Zrx3y41DlsM8egun2oj4imAK6WSTktnhcFOoM4K5Lem1k+PztbWof9AFzd3FyBfROyEiyJyW34bbkckayeuNmlvGutl0+LB962sFudRBRqQnmVA+aGhuGm1DlUnTFgn1rKUbgYGXBG8Re2F9+PXGW1LYtP+t7Jxxh9PiFukY/razxlgGvDHzC2FT8uqudS4E3HYttEOM4L/Td5qgblNYUY6EWmQXqgk1f+Tn/PYy2Eb1YQFVsoun+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwUoppLoqySGQeSEQiG5yB+PbQOpHYnTKT7aF3wMv54=;
 b=Q3P7Ae97gdzCbkVvUHiIdbF86tJh7g2Gb6pGaUqmG0cf629ZyWgS3RZ9DEAanaR+mViJaN5qPyk02qPGID7WVcSsdD4pcMZt+mEyTso3Tj+KrfD7wZ+RaRePUOJv8fJm4hm521AzYCQ5NXcwIUbtgOokIzR5r8fdNFDxm9uJt5o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB10104.eurprd08.prod.outlook.com
 (2603:10a6:800:1bc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 08:46:16 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 08:46:16 +0000
Message-ID: <6f065a4f-d71b-445c-b0ab-4061cdeb9c0a@arm.com>
Date: Fri, 9 Oct 2026 10:46:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dwc_eth_qos: spacemit: add support for K3 SoC
To: Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>, E Shattow <e@freeshell.de>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
 <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
 <20261009070324-GKF2005@kernel.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261009070324-GKF2005@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB10104:EE_|ZR1PEPF0000E6B6:EE_|DU5PR08MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a44847-8a04-47f4-429c-08df25e1dda9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: 5GFVq4QCkto7zPPhNmcF3roNalrQRfe3A0uBGL/3Rf2icK1zRqAA0+AeiQ4lGPnQ5KwzmamkoFMdoCnVnrjxzSjv9re87cKxrW4YGn4pto4lNb5MF9aA5BRWQ/UKZjj7JsOgjgZlPdH+o6uSp7dPNCiAX9rmOVX/iUn0lQYV0MzJOOwES7k9v04rK45tW1WJFg7OsPjyMvu/0eVbrt91RxmugcbkGkacMn+3hEWpp4cJ6c+F1GShXMvjgIfyltVkY4dyQxbFtYwilrubdtoTo0W9jFkw//qMjaS2IqD0K3ofrFf3b9CtHQ/kiE6lNTFOOqPqOWy17uvK84GiqT/Olu8VRY3aDx4GhnrLNUkDQaIq/26JjmTC9+Yj7zFSctYL0FJWyNLuwWhO6Ihfs99888QTnPhB/6d+hAs6hyaVLgDhlMUW1lq84jL/MRyAcS4G2odPioOGFbO0Ilowz4HbGWhjdc3rKGXCYPiN19VMbpjjEw+QnH6NoN2dpcsgYD5bHDQbRDb/ZoauI1rCWR/5Ov462aZZDGojvNn/sxgPosoFfpXnwxDXSYzWSIV5mXuGeTyJPjxTX7cQMaKrCjZ7rQ1IEaj9qP9yBhJZ6ohPaonjD7JJNmuAZiwSg4oAxhk9csMP/ZhJw8lltgNCRpbTTgsKBkuER6JUYxUS8DCZX7g=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: qkCQZ86Ta7x1A06vsrfTfwKOO32DKa+6c7s1dYBfXtv45XoS2cXp0AcERqlKPNmk9wraatbzhgTu2sf9Hq3LUZoGzDDTUxVBqIamYKML0cZ/Y4WFY6riEhGQbGa4H5LRpkgj4ssoXh3uMSrIJF1Y9aAxZrQJN8P2bR5SuiH+3kkT+tYXh8pEPpg6rLFNLez6V6rXY/ys18cK0tYHxd3e5NXyY32UrWxVd7x8adTVPh/oyDjrqmTNuCWF9CljmdRgi1Wo6OLe67SevFEup8BoOs01cIeFIFvGwl9l3x18WVFMlYa/xyQtk75g8uuA+odYCMhFJVz3X2/y3bCcC0bcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10104
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c9e8817-b2df-4566-9845-08df25e1c7f2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|1800799024|82310400026|376014|7416014|35042699022|36860700016|10067099003|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ksTOnEQ2YoZCVvmBpNez+H7U3LUMiEtN0s1lbQxzgvsX5iUSIjJFcLSAfd0wUNWo0wmq8zYn1uzbRmi87L5yUiIqbI4/XUBqsCb5i0/x9TAj4Hy4OOHxr4wYkI9NyfLCWIHoephlEojsUANZHmxDcTPsPjq+GmFR37YRwG4A+9od7/+lhSfWv969hVP345gRNCy55tqxjMBHELnxHMFy4VVaWenHBIyehuNfSbU+lz8f9LspaUsmUPWwEz8rTwnkbg7CRRSjMnUjooLzqdyX8osWCK0prDa4W+q6Gf2Hs9peHSI6uOIdf2ILKiB9hYo5J1RHxuK0gKG5RhZMZsO7sTmKwYqUN1yLbVygdbhYv/22rD2fbk+mbNGw6AgflP3Jv3GVxSyW0wyjEc1NN6xI5iyylki3cJSABCbK4MJeajwN3zccx+nUA+/G8mnypI006Iw1eh8k+C9u5O5VDzhyt2jyBy/urVsTtJo4+zDSJnYkUuZbpdfglFoOaj01bCTH7ChU2+Z3K8F0S23qAu14xYCgh3O4mG89+5762zoGYifjp5wwaC7uMP3uHN9yeLmd4zQgqTqmvY0V2pKMacwmMPYR6DZH42ficT0DI/nRdTvYL0WEi/lu6JRb0lHWTy1iTvxmkGZeoenk+Ar3dfvqmtCYp8/A32qx5SzKuMYQGm9b5jgHjMNhUiN9UA1sXRGH3NWT3TXhw1eHI49IFIbWnw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(1800799024)(82310400026)(376014)(7416014)(35042699022)(36860700016)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: erq1iijy5fPzh197c333rq9+Wv7do1cijbYotzct8q+0hjJTejC6vz4Pp8IL0nH66HQ9fgbzhZGTV84LPJKQF1874hz5MYnofFVkMoWQ24ieQ9yaHvsvbfSRw/h/YGoCL3abW5vQEnqBAKozc0O7Y17ypAK5zdDnVlqPq37ZZymBvx9kB8GvVzR4wkYB+Nld0jE36s9Ett6nMeS5PTpJ7H0NGoBI4z/h0da0Xaf/eJj4fUiyQRkXjoBnA0J2D+9z0PJYgVr6GexQYockp7Ml7R0el8QMaLSv7OGJCSxXJow9Tmnd3xyKKStT5KC3CFXvFoJMFzcPLMyQ78WgJYCM0/AlmuXTH5Vgb4kluZ/VrpSE9LJQF5zjv5/4SUoRXtzEx1tZgm3SXFFSplpeFHjguKvhsAGBw7H23A24TWXAkB/VWnbSnXtMMaSCTkqvMsDq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:46:52.5089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a44847-8a04-47f4-429c-08df25e1dda9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10399
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

Hi Yixun,

On 09/10/2026 09:03, Yixun Lan wrote:
> Hi Jerome Forissier,
> 
> On 01:53 Thu 24 Sep     , Yixun Lan wrote:
>> The SpacemiT K3 integrates a Synopsys DWMAC 5.40a Ethernet controller.
>> Add the platform glue for selecting the MII, RMII or RGMII interface,
>> configuring the internal RGMII delay lines through the APMU, and
>> managing the controller clocks and reset.
>>
>> Signed-off-by: Yixun Lan <dlan@kernel.org>
>> ---
>>  drivers/net/Kconfig                |   8 +
>>  drivers/net/Makefile               |   1 +
>>  drivers/net/dwc_eth_qos.c          |   6 +
>>  drivers/net/dwc_eth_qos.h          |   1 +
>>  drivers/net/dwc_eth_qos_spacemit.c | 313 +++++++++++++++++++++++++++++++++++++
>>  5 files changed, 329 insertions(+)
>>
> 
> Ping for this..
> 
> Would you have some time to take a look at this patch?
> and let me know if you want to take it via net tree?
> 

I'll take this one via my tree. Please rework the Kconfig changes ([2/2]) as
requested by E.

Thanks,
-- 
Jerome
