Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19D2CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80148606C5;
	Tue, 13 Oct 2026 10:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j8agWiwuTsTR; Tue, 13 Oct 2026 10:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AB9660629
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791889122;
	b=L+YfAu/gbQgvcCE6NBTiaVH4R4brxJsdUYYrufxhI2eJEL4RLS5LPuNimbJlNK0wn5Ue
	 ZqcDX3xXwopRtJFywhj7RlUtUpWy0Xc2TztuEDMLbYd5Bq+ytWr0I+NXUqcSMZsYiOQ2q
	 syIpwOMGORvrwqVODQn7n1HC3VpVO/N+YZLWSyolf3hsAL2AwNC5IFe0RpuVwi1S1vPX2
	 +CpNebV+EA/HbvnElCcV23CexLwn1LtArcVZhuQfOXIQGKYHnZGjyZVoythfvw1dAkuzj
	 EPZua/DRS1z7qPLAMOoREd4MGxqYjcymyrZ2YSB8YgIE+UI4zNYhbrF3Xjld4R4n5Lw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889122;
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
	bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
	b=KTcgRHg7qnQr+FIh4f9BIZ+fgksnCgViq4F1xPOVOe14YRruJKZaT5o+xbqJ++aO7YOc
	 tyyO9wLbB/8QA3mkb7GV6kZjdVTB98Kil5uJIan2pqJELVfWPjIsBIAcZyyR+rxdBKqbW
	 SbbIeZsQhi/sCqGUYUn0NCWtbf3Ib3PCMKgHWJW/ICnq1D6bFuqO/XjHF6PpJmaCLH//X
	 4mQI97ZXp1FaEeLarkodIrY8GG4wWLV+eLBrPL20oiFsu1pq5f5Bzn39xU8uHntnobQwc
	 izUVKpxJ/JEwTo9kO1N4JMvHxHsGFN3ChYh0RiNw+BVvnl9S9s2QmfkQRFH7K3mvC4A==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jmdlHhQ4;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jmdlHhQ4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889122;
	bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KakvccLpxvj3YjKPIS+wKCHLa4H+SwuJWx+iQSrW/M+m+TkwfnKNbqV2h2edn7ME+
	 0SRfE8Cnx1nEXkDnXU/NQjOHdvHU+CP17+mN9NrMzND7Z71zDx3biF+TzeKDPz4zDi
	 p+bKSj3MMw4LwPU8s1cbmvNt6k/854qGBPIfD8ya5+CVQa4G4dgnTGmrQxySHUvvLY
	 d4Vn6P7TPyF5b2Ef+UMN11k4+5vdFofgWOH7GfXVMcuSB/id9truBm0/r70FOcQtVr
	 Ca/IBCNhBxvAU2KeBmLjQWOhPcg6Jsle0NcG5IWBQ2kaIa1P0OhVYNPENaQJsVm4zh
	 KF+2FfeqWw7cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AB9660629;
	Tue, 13 Oct 2026 10:58:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95538A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86D4A605AD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4q6ZW4JBnZx for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8EFA60629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889120;
 b=Op+8ceqMnU1Zn6b8YqDpDIlec8CM5M3wgAEmsUirQklNvmavHZIhXmRVXJTgsA4TAY8c
 PYY/Ox9wgj3H4ImRDsLf5SmLB4OIj6QHE+tesKD6QXfsbcZ19yGPzv9ex8QzrlamA099X
 amr28igK0wtdBlLUKyLk6EDILLncE9dWWDFI6q5hBUp7tOmSSKMaYQEtE7H7xJ78uUJ0v
 IEXZVRko5S1QUqUm1oQB3VDf0OA2lzfZ+eAnOPkHyUf11WWCfwqKc1ZKFywkWN1xui/+R
 iM5PRriZ5L6oKgVgjGH0rYm/x4+1DjqYTYey+D76R8uH5SnN7jYfR2okMaSm0je99pw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889120;
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
 bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
 b=A6rE7srTDxbvT1+zAeMxZruvWWtxLKpViIrbaYSKAVQrA5aLrKnQ6LJ8FjPYKWbb8GFN
 wkQB0oK+rk2EkgczxBhRmFABRUCuJplRxaxOx63YHck9yXqGLY0NhCE5cpsDPtgnoe0qg
 V4WJxG+KSJW5x4prP2vsEoBbo4blfCM6J4kMvaAWqIqq/7ya9YoogeqaAfkWylIJr7tHX
 QBjb4vHj8N3qhyy88O/exwVzsrKVmAnUy25IBtp6OhsEGXlBWvEcXIqaM9cB9RbgAs8VB
 bmvFI+YndFTsqtdMCl4DisOVYJFhpFYuEH3M1ImcCTObcAe+0qEyBc9uhhmgHImWFAw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=jmdlHhQ4; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=jmdlHhQ4; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jmdlHhQ4; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jmdlHhQ4
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8EFA60629
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:58:38 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c7SCC0tbAuaOHz2IU/IVMREaIJsf0GhfhdwE46DiA4QVik/LycGhcBeRkspNxjg3rl7AdYXZTqxNKcg2K9z8Q2icleJJsoM9lW0yMyyeOiFrR6+utnnKM4XBwTdN1U0Yu3lNxEzJlqvMKDsoig2GLoeBm1sQ1Va3qukbbJQm63hIV5CBSD4oAgV1cM7v5OtedgzW+nv+R2Bvw4K51SS/vXLimWX2Lbspk+zh7VDoQZxdK7SBB/2XNbAjdijWGBHrPUcyZsXsVtPK3MPqHFqWk7y0oZ2+Syo6al8cKm+3ygsvlv1zr/pcc+sB1lgKF5SmTiwXpf9JXIxkpXWqa4ck3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
 b=Ng7jOjHkJFpFDwGRDw/A6rjpwhajrAeT58D2/gzgLxh+wQ9DLOuGSywO3Mmnh0I5IuJbDFliPGVRexZTt5w7mjYaQ9P5VEjaVe4lJH5hk9E/UMVNvxn37q7ut+VPHRBthrfUVQknF16ckeDhhApljEOrIP/lCKQrSCqgB337gFxKPYWkQbpys6onKV4MWygYJhclFa4Kp7x0r7uabJWYbZm9AyNWZoxM4I7+N4ZqRRW6YBc+Ao/HAc7ow0guCtziSZ/1DyIc15iOjevhlNffCdOM4kfHvdeQEc5H6GdPP5lRsxF9WZTsh0oDm3+mKafDHFq72xOAW/mZt3kGx4pZMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
 b=jmdlHhQ461qKFD2Fz0HGIb7QHGDKuRcdSzCDqPP3pLsp4TK3k2R4pcbyQNBRiLHvQ9DN0qd3M2twA/JEF+uOulKBpy/bc89ERyhD4m/NZAiebZluvl9Q01pVZtElu9bH51GPYxJpg8ccQsxJZEl8iWyFc8G64381+5UTvGD81RE=
Received: from AM9P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::16)
 by DBBPR08MB6044.eurprd08.prod.outlook.com (2603:10a6:10:207::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:58:28 +0000
Received: from AMS1EPF00000099.eurprd02.prod.outlook.com
 (2603:10a6:20b:21d:cafe::44) by AM9P192CA0011.outlook.office365.com
 (2603:10a6:20b:21d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:58:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000099.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 10:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkdBTsz/nB/HAYQ0CRFmVbeKc0mFjvaXWATq/OyAmxG4WB5f6TRyVnLDfP/iZQjlIU/9WKVpWg9y1KR6PPGnuf/4uMmIgkTe8WLM9bxxlVlPBHGapDFzcsaT+wnJUGFXIEoTZwZseCV8sM5mR2ni2UtuGB8BTsCi3QKFlBfUgCcr2myqaJsHq1MdYsFuhAWefVXqjmfskFUESlVGkPRh0TD8tdZOpHxcF//p+R/EhpQKsXzzRXEfZqlPWbl4y9hWdYKAARfhJfPMrwwf0giU5/Zb9HcO9xhINhR0qwImIfGQ9Xq/mwjyPLGi+LhYa/VcxQL8n9qIjk0u4+VakI7rSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
 b=A6CRxY7NS299bqiMku2CQt0JbLyfLqu/mZID/dM4ztiYXYMqt1J50bBb+DD+C+PscA24ltkgXwC0gsbpIJgvVBralKYOoqklWinW2HmWU6Pt2Xoq35DCm4fFocQKnajZYDJT8+/qixyk8qr0sOZcnyfZcbkJzTx0ALlJSkwqJ3tgc+LC9KbJttRXD55PqHtO2k0riGqn3wDpc4NRzEUKxv3ffyOZrO9+x06ljgu3y3qWzyQMKdobogmw0cUvFHVXLGYg4LY5oMZdTXgSWZ2PcWJeh63v0GWfaq48Zi6gR7ZTTUiPk4O8psY11q8YuIXqOLDPEODheBE8QF+6ZDP9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBhDmGz1FpBxzDn4RhDoSOPyT8maOhePbbtJKRDUPr0=;
 b=jmdlHhQ461qKFD2Fz0HGIb7QHGDKuRcdSzCDqPP3pLsp4TK3k2R4pcbyQNBRiLHvQ9DN0qd3M2twA/JEF+uOulKBpy/bc89ERyhD4m/NZAiebZluvl9Q01pVZtElu9bH51GPYxJpg8ccQsxJZEl8iWyFc8G64381+5UTvGD81RE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by ZR6PR08MB999852.eurprd08.prod.outlook.com
 (2603:10a6:910:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:57:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 10:57:53 +0000
Message-ID: <596734b8-8ca1-4200-a95e-eea7ac75a454@arm.com>
Date: Tue, 13 Oct 2026 12:57:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] net: return -EAGAIN when no RX packet is ready
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, nd <nd@arm.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|ZR6PR08MB999852:EE_|AMS1EPF00000099:EE_|DBBPR08MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6fcc41-7566-48b9-505d-08df2918e9a5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: 4DY32rqUtkJdZdJlFSCBePTG636mEZFFTguN39nwc5Ku9rJoWDx5jP4ePlyUggY5NGYafDc250jn7ES1xBgpeeIJ9J5RucE1y1yAQoBr26P9Ctm2MBA3lcuLjoyIAgQj6uJCEahGhY9S/K2myHF7xD3C12kYGnlFxXDV18LrErrBFNCJcgHo0vIgXOJK9crou4YrTWCU4IOgSF4u0rr7UX5B1spOVTq0ayENexFX2i6IW6UZuhzf1RTbKHx49wQfq1HNHlFOkA0MSn0sasd6pvEATdy54znJqkBHuTU5L9xdUGCFl2Za/TLqdKbf0eLtwr9w6D1PSrK33cfWsk4fRNuDJQ6V1Bh61l6Ies1C+a1cKohEWHk+cI1mTXfZ9R81iK2WlYnpYF2tH4o1s0CbURdvSEswkQrUd3z7Q+I0QD9Dqi+XXdiWubDrfMVG2H00s31+0TVbLL7K1utqsJjnSq4SBFGZF72qdd4QDnCUYQy5w45HERnfi294N6m0qev7X/+Mjq1NX5+Ahyk8muaaIQEYDIBG9AQUUZk23O7xH9PG/EGUE8iZCcN4UVcVMMTO6HzmwLXoz+AeX5PJalMuBhayqHW4d//uV75pSFIQ51iW+ei50iFtf0/9Nv3KShNy
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: FJpo8X6Y+BB5GerPvpgcwdAjbGozEU7dHOPrM8cWHtGTq1re5TT8xW5Jooi3K80PC7+rqvHMAJ5M2n/C0TvWheobhe7/zakltKQTEqNliLaeXqSrSGSSy7+XQ+fYPZHj/FPJJxQNDK27qZ/PmSsVTOlmJMCCjZrnCP94zYQepWwojdmms6o/seY/E6h6dVkZqGg596Gmprw3QP2a/mYRy18iPBHqJmLTWvOuitvs2LjgyZXsze4BiP3ehN1+QfUsRkNdgsP+FQXaxgnGJsMnw4DBcMA0O5wARUgLSplMpiqGBVhDrqy5PmrmcNG3jpdfr6ZfEo/s/XHTrRCC88fhmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB999852
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000099.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 319624cc-faf9-411c-0dfe-08df2918d49f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|7416014|376014|14060799003|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: fnZuXLhGGFZjD4XfHoe6nnC0siPw2dWdc+HfNaIfSTDNv1rLI0ijFc1UN8qBb0AOAIysuH4rJfVg8dKHPrHrHqXtVibB+0UZXBu5AtFRxk1OtgT2dVzd7NyNEuWXxSZkxD6VtdpqiaotFG4ijIchXI3xgnVZhQy98ulEorkiCYWAXTFKKDMGXDt2diHwe38QX29pRXeocb42g2NMzPZsczsSVWTmp/y8YMBgYXGDUJNKA1NPq638KrdOYRFBCSH/hS6pu+HCdjmG6K0RkBNRv5j5HJCAVSi+ndjDHKzAcSubKLULDkMiWWgH/ja3BPBgEoQCN3poT5CZ7JdfAer0M5bfO5CvoRTv0tU78l5MKA0fVb0dPUlgFQkLJLtGEZS6s5rCEgT+/+kzL0kknaj5VQEhwAb3Eee0eJ1dfsyBRPQjiNpWDXeuoA+h0g6PanbE+ga4mSET5U2ObbJq5P9nYnTTSR3qKMvVjksx65DGGNiJ01NO4DMEhVRatqAlWtXm7f8ixgWPnxFQNHwyQHT69aAb6Cd8sO3h+Jt5kQcXofgbGjE+ov/doJ3JGPZvF1rtGdHwhXfYAZ15Cy4GYNlZH6Q9VfX4mmutjck9FgRRS1nuj7Ju1bBCcTvpu9RiS7vQqEsBqn6oFR+YtxwcyyNJ/1ioLtnuxPyaKcTMqmF/23Y=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(7416014)(376014)(14060799003)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pFlNselGdQjOsSTmRTQWjDsEnbHxRWgyj2L49u31aHl5dFka7XVpL+VE/U5m0UvGKT3adR77OopiIo6dgPX5kYwU4QqO8r6VSi/uT2w6gw9CgtW3qNGO5c/8Gr15w4odsfJsUfUEzrSDOkkkuYpg7jXGo9kJ6bZmEbN5Eys2vuzsmtLZB2ErLu7OkHtIbmEg93RfZpBvUjyyVcAifI8JZ7ZOMq01zbh4RT+3jaP0uZL4YT15TrWwTcJDu/cL7lshnEulL8tEOx676EsfQZfgP8dThX/SDILQ2d2mC049xnNItsoVg1fVjehp+qBvnTqg5+PCQ/7Zq6CO2Q8G3qFxaYlkjMT6RI1H5g+k0plEVFlMiItkJqqmL/8qSPGlLLAxzwtFcQk/2LFMQsSQoZeaQfIpG3iKvYkcepZ+lIu2zjHM3m2fVo9hJlIZxfwep8jm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:58:28.4927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6fcc41-7566-48b9-505d-08df2918e9a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000099.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6044
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

On 13/10/2026 00:27, James Hilliard wrote:
> DHCP now checks net_lwip_poll(), exposing Ethernet drivers which return
> fatal errors for an ordinary receive poll with no packet available.
> net_lwip_rx() treats -EAGAIN as an empty receive, as specified by the
> Ethernet driver interface.
> 
> Keep the CPSW fix from v1 and fix the same issue in seven more drivers:
> FMan, ColdFire FEC, Marvell GbE, TSEC, Xilinx EmacLite, Zynq GEM and
> HiSilicon GMAC, with one patch per driver. Change only their no-packet
> returns, preserving packet processing, actual error handling and polling
> limits. The driver fixes can be applied independently.
> 
> The additional cases were found by code inspection following the
> BeagleBone Black report. Cross-compiled the seven additional drivers
> with both lwIP and the legacy stack, and checked their receive functions
> with stubbed registers and descriptors, including negative controls
> against the old code. These additional drivers have not been tested on
> real hardware.
> 
> Based on u-boot-net/for-next.
> 
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Add separate fixes for empty receives in seven more Ethernet drivers.
> - Add Tom Rini's Tested-by to the otherwise unchanged CPSW patch.
> - Link to v1: https://patch.msgid.link/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com
> 
> ---
> James Hilliard (8):
>       net: ti: cpsw: return -EAGAIN when no RX packet is ready
>       net: fm: return -EAGAIN for empty receives
>       net: higmacv300: return -EAGAIN for empty receives
>       net: mcffec: return -EAGAIN for empty receives
>       net: mvgbe: return -EAGAIN for empty receives
>       net: tsec: return -EAGAIN for empty receives
>       net: xilinx_emaclite: return -EAGAIN for empty receives
>       net: zynq_gem: return -EAGAIN for empty receives
> 
>  drivers/net/fm/eth.c          | 2 +-
>  drivers/net/higmacv300.c      | 2 +-
>  drivers/net/mcffec.c          | 2 +-
>  drivers/net/mvgbe.c           | 2 +-
>  drivers/net/ti/cpsw.c         | 2 ++
>  drivers/net/tsec.c            | 2 ++
>  drivers/net/xilinx_emaclite.c | 6 +++---
>  drivers/net/zynq_gem.c        | 2 +-
>  8 files changed, 12 insertions(+), 8 deletions(-)
> ---
> base-commit: 28ddd369e2f7199539cdefe22ce014c592b890bd
> change-id: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

LGTM. For the series:

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
