Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14277606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yz5Z6fKc;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=aXn7rpSi;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=aXn7rpSi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5408405E8;
	Wed, 28 Oct 2026 09:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pcz2ro2ywPpJ; Wed, 28 Oct 2026 09:02:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D02C14060C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793178122;
	b=pCGGRvrL78hMVBh8lT8s4tBT6hFftbcERmovQXUKblDAS78DEMsvehxd4PDyk3mGOlfA
	 jd7SIG7rB8UvH/146JTMVR/EkZkwKpOabns9SUrT/s7x0KVnn13cpYZ0iWbv7Yt82VTTO
	 oSIy1J0PbrylhU8dSe+RWshhnqeI+yHB1/O/O5lR32pH3Oux9wrsb4VICkZywDcBvIOQC
	 DLS/E68v/D1BzMUtyOz+2NcUu9e6CjAIScKjWgS6zXA73NWX2juQp+9nh2HwVN0IwD/4I
	 xK1wQJ47in6sgwlIp8hHMVpNoe5aT8zaL4NQtFVrH7pOdGZgomoZkIfFmmtcOgFrz9Q==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793178122;
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
	bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
	b=gyjzEC4ERxazTYiXSrbXcZvVYyLjEWrwxbE15tkjCYuqHn1EbxR1mUB4cDEtGVZY6hOq
	 dLwjBfkx8Ez6ai8dlhDt5GI9C5Fe5PBXo4m72YMqt3auE5AT9Wh2e223YPuf7LZpQpZc7
	 G/oJjrlJ6o80BOAZ+arSl9rYo0n5TdMvRccAmomQzfvW177fFX9GOQLBF8wlg/ayOsVIr
	 ArqCS3FA4miIymCUDSmdymuLzvib7zo6D5rAwxwpKozoUqr6HwRzMriYYxZJqXoYbM3qx
	 JN7GUYgLwUug34j+jq2Jst5Kt2R6NXA1EDpTmZwRLeST8pF8bfTlLD9jNZbi+EA0CSw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793178121;
	bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yz5Z6fKc41fs1gMSLGRFjegs6pyfXKemiF6i+FH1Sw7vkgHKkvkPvlefd0pZ6/ohJ
	 0ifGsfKqpDdC5e/xczw+tWiQk/X8Y3euVi/7czB/F5ynujUlyRiijAIrDML17Th8KC
	 LsinkXJ1doDigZvYOuRM42yTRfly7UXOhB93zNKmVmlXuijMhwRWjad3uEj89stbQX
	 xMvMn04NpJHPvB5EuqSiDgsPNGIhQ5LPyhOvxZTIYW+jBPU7DWqqncYI92mIpXHlbZ
	 py6DY2MIeNqxHssnmrzXsxlmGR0b42GZwKXk9iYHCV4mBNwMLG3oN8pOLN13QgJLHp
	 +CcdaHRICa06w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D02C14060C;
	Wed, 28 Oct 2026 09:02:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19467473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ADA860658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfudGxjBo4VO for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C52260600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793178117;
 b=nyBDnxfB62PxKWtIeRQ6bZrJm9fPfbLXIxOiEPEoFqDON9OVYjyhFllbPNzaL0vFOA6x
 +fsuc03qjfBPtb+1mbpwRokRDrO1EdwW9vRPgoHKQtAvxqP8TO5togUygSrygUj4KXpSu
 AuZQLloFdNBmbjW052BYcHXo2K0gu2EKbqhrzzbBCPJvLuh+862BYFZ2Su6TZEyKf2cbj
 Ng49OY8uEZxjlbqMFUYtrnbSZpMylxrGCbXGDVMStVJHImSiOpoKB0JVKZvIiteq/OPLC
 ikz+3KiXHdlNGYBujcnuhIc68zd/kgrh6XZ61gEoE91asCDaHdbzJ6fKqg0cXT2R17g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793178117;
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
 bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
 b=HhlDnlq3BsmirQyxStK2bi4Uezi2fPfAij4ZM6uMX4XpwygFmkQt1xIeamLGK/QQmQ6r
 M+uk3b+0fAOGkRdOzTSOZpQOqwqFXGRIumkI4V01Li+lfIu2w83xO8E7KyUy8Mtl5ABVm
 OSZdxn4GZvM1J/94OgeOMnx6hUE0zlUQkdq7Zv2sGr9J2ZXnKw1qriCqZwBxxiZc5jpBe
 HP3rYIgd1ij9kzAJrAziIQk1jufpBn+tOtwAyNIkcAv96QonuPjRG/wSXxe84/K+DlsEL
 FLPJDEKQ4ja4CAD7jvnEbAB+Bsdjx62DeW2HE8+nGXJ2+5CRdNPp85tPeaI3EJCPFPA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=aXn7rpSi; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=aXn7rpSi; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=aXn7rpSi; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=aXn7rpSi
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C52260600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qeBDQZ1s5kYNg9G/IIthHCglFRnk5If6IkWFlhJw4ojsECXPASkxkGFdjW8e+swshHcvLfQisXDnpprdVQy4hlObbFm1XyW2NeekkloRryaxL6RH4ErH0V81AKJBUoVtH5xMskltI0du8iaWIqLdzMHG6axKNc8+cs89EVw0LR+m9IUNl4zZ9dcBtNwiL6zfa5oaHpozYv9g6ObRa9uLU1dk1B/lrD0slm4YBiN9iVfYxRDBgkKE9d8N9nVKy0aZZW9ihitXrofBYQBn8uJC0ovEx+Kjd3XKpW5kJAnXfH4surpGEOYsX7XzlRuv8WUarYUFxCFV1yd5pUa+I6Sehg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
 b=LI/qP25fESHz77bLStqdwLWD25hnkfukeYNtyXm6ifpuFZSM0yvptcfTAecCDflvhSdzFpPU4Mp33dxyzZSJWjIkNhaLEOPmpUhAeOpWsVfwp2VUN4tTLMm6FcQdLFndTQU1Nn/EIuAtVNpYSVLmvNsJwP6VOwWPuwpAbsmRBG3lG4PDafua/1Qe6apvDXq/Jv/kArRL0r2CmMzfycGfBNv0FaoZUvF4u3rrYxGbxt58GMfemcpETzuKEEEHOBKFZDhXzbTbnpcBrotoLWoNqSpR6nmVcN/zqxWYtyRYlQOdQNFTqzJfwESMHvwM0rFKkq2hsVOAO2RjgMLVcjsWVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
 b=aXn7rpSikelk1lsjmvm40QLrzj67NXmoLOpT3lQtYonOtUeunHSdJCgxhIuLuIB+l83d2wPFX8ZZ1Ws+Jx4KKoYp/mFNZfLtuv+ZRPeJ3hEkvDyTrsdef8gTPvzD5Bo6dAFDA1NjSyieQKe3Zwwa27/HBiVXxHzdYVu8N8seiPk=
Received: from PAZP264CA0207.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::25)
 by MMZPR08MB948819.eurprd08.prod.outlook.com (2603:10a6:190:53::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:01:50 +0000
Received: from MI3PEPF00008485.eurprd02.prod.outlook.com
 (2603:10a6:102:237:cafe::e) by PAZP264CA0207.outlook.office365.com
 (2603:10a6:102:237::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 09:01:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008485.mail.protection.outlook.com (10.167.240.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 09:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0L8oXQKGlWyM0atQcq8jjgvnK01jHKcM9ehqRmHeSqrffe4xiSu8wL6vGYhyT9ItylM/T7asHBSxFb3quPbNXujgm3QTN2uOiBBHNvXGCqS2Kp7yfoPr2w3svsZ8B7/ZT8uJPIT1rluYY5jUGR2ICj6yOb99mJuADor5eNWUZel2Wg3PGAd32oAAfj6oy8IghA3O5YzivTYw02LMYNxvTOQELJLt+CAoqSg0zdV0d9D12i4F41w5fiXfoMcmVXE2kb0muQnmsHYHXwLV1/eUrs45FjCP6UlMh41WlO/EftpMKKLGakmY9vL0zsvdWb/91P99Smkb3blh3xIg4l8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
 b=kJ/AdJ8OcxSZPFmdJZD1Mv+2ErgxzW4SNb+t5+9usduKvWx6xo3wq2yzea0R+ZyZjeS9GpV+cMniE3DcqBetz+tiPo6VkWIlRGS3ue5BrvO+t+Lw8LxtEFLNFV4Be26zfJwe+cw7SKYIs2pyBswSd7tbhPSgRUrgnfTGNeJo7K5s5t/lmpi3rMCuCAgOG0ZgFJCwWqmNPqQ2NN1lfDJXyvb22BkYg6xstrhi5CeVH6PEsoEYof4iklt9yHQpcEKAKwmWexZ+gI6F8zVm1v9JGLe12cg1FXpn7lefD0HvE1jQMcbh+kctUE1mOSzMzbMg7cvHX32P805OnmmG88Xlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcBsYRpoIqlJRI1pBaaKUQDpX5e45Lh3G/U9Gjf4bM0=;
 b=aXn7rpSikelk1lsjmvm40QLrzj67NXmoLOpT3lQtYonOtUeunHSdJCgxhIuLuIB+l83d2wPFX8ZZ1Ws+Jx4KKoYp/mFNZfLtuv+ZRPeJ3hEkvDyTrsdef8gTPvzD5Bo6dAFDA1NjSyieQKe3Zwwa27/HBiVXxHzdYVu8N8seiPk=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB10305.eurprd08.prod.outlook.com
 (2603:10a6:102:367::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:01:12 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 09:01:11 +0000
Message-ID: <d5057c79-7e37-469c-a2e7-b14ec4f18f2f@arm.com>
Date: Wed, 28 Oct 2026 10:01:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
 <20261027173348.GG2177077@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261027173348.GG2177077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB10305:EE_|MI3PEPF00008485:EE_|MMZPR08MB948819:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d0e8d4-7fb0-4ba1-72ec-08df34d21a61
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|4143699003|56012099006|261026140227099003|22082099003|6133799003|18002099003|10067099003|261022075727099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info-Original: zWgW367PKKCXAn5lWMibRHVnBlMXiesxeqCjEI04/cQa5zQA+vg8lvZMX3Pac+BL9/HGMSUJalj4tCviB0ydSCpTfzwm2NHk4lpHUPyVsvfMCQxCAmZ3AsgnlSWVqH9URLEiBk04FsykZ+YpTdvFxMGDk5h51+AcIKWn1NGaZairBQljjk9iooOHCcaC8zzsyjeza4yBWtfLUjV9NCND2Sd6GlYcJD2f8qfvC8fvrQUgDvogCT/ZyUc4U0oTTCngDy5YNY9bJ/KOGDqjzf44pS1x/y9dTF5norlE/pRVGLHW0H+o2N46j7+qQlWCnH0i8JFQeICgq/FpE0VTuTV5kCuW9PetS15bw9bMLG2cP+ckITgoA3TdmpUeZT5L5i3Dvm3+s8aVroQd7tQUT3+wowTmir/iEMhR3vQurlzjrYjqGznM2lJoo045dy39EUcRkjJ+NwPCL5tWaedRqnPkPi/paAjcRraW3edvaJqVkq1FWjlj9OHG3Wcai/rTKeFb3yjpIe1HL07Go5fnmGtJbNzQqij5RQ0EP2Ss7obnqSCybROcdjZvQf2Nlp9ftJr/aDhoSRZp3MB86NHU9Wf2AV3MYe/pBzfqps4Kc6Q/wtOEqO+rvNzrRjNkylZKaW3J
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(261026140227099003)(22082099003)(6133799003)(18002099003)(10067099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bltadH4enA+hWJUdSoAb9MEx6kNukFt30O7WyUkOgUO1vidF/ML1DRN9raUnB3jsIkjaMni+jmT97XSvE9D4lKOYzOxkWFmItyFu/Drud3dnUZKnNjOBOGujix4FttqL7v3B2tzqPyk1A2OBvRpZbMFiFnaLJZ0msUkMNpW5iCvJ9rk+bQCFy1G+NgecDfwXysZSAkbd/1yv9WBJrTDyi0C9qh/l/AD8WgoI1s2wfRK+ki9e8Qb/uCCPXKDlSfxOaV4hd/uIRm/lPmq54JCK+jsfeCNL7unQ1pOSGPVcMXpYA95Oy69faUNym9l6XAKahoQUkxAAW+v8cm/rpP28FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10305
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a315eb8-48b3-483f-0ac8-08df34d2038a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|14060799003|376014|23010399003|35042699022|1800799024|6133799003|22082099003|18002099003|261026140227099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: X/C0p0f7h1Fk+Mtw+cQazIgYbW/leYBI1PBkC1bkhXy+qk7158Wg/quGTppSwI759Nav1YkWo1oQVBWXuTfpftwkXaYZyQ5LNEhwT3hNCQGaVfvaKg/z/K1IZD2XR1optchA5Pt5lpDJ6+bZEUjf09VLcy4hyPBY3kdGSoh9YnJUXD/RHMpK3Kk0fQ9b7EIhS8ZX1/Xa/HhjCbTfSNzAFEbhT4OsE3kcpd6t6SJH3LXBqZyUPnVRHvSesbYd8aAPK5sdnQH7X/5BAht1FYCR0yy0xxIydshNYIcg7VrKZjv7Zv1/O2RIGtXLsjgIjA1okw6enmGyMRc8aLmds+oShI62AapUXUtkXeFGae7bOp47Un49egJBzuToTRH94SxnsJb6iQhZuY3IiPQ9X5e5I9dYo6rclf1dHPspnJNYnq5g0mitMP8HzpxT7UW2uUqWK4luymwE/hHIHWfrRl5QjwXG4HSLLBC09C4XsMrkB2w2u9dxV89jGA4YsZ7XQYMXi871/f0ZlupPdLpf/BQjOO3rZqE8e8625neAg/E+MQVRheODjRHhg1rGEp1gZLARcvLO4OzgfbzZLrRCnCIez+99V9H4e5hMCrTjKXO7NELzwamU4cWI0XsAkviojh7BEqyUMsimMCoqahNQuhWHEuQ/a6HbMO4JfmsBAyaQAGI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(14060799003)(376014)(23010399003)(35042699022)(1800799024)(6133799003)(22082099003)(18002099003)(261026140227099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bpHtXt31D7Sxs5/JbyABSimYdvgkvz9VrapZQEVBYpPLzVxrVDUurNSEQjOH8WXXH5Wp8nMNo6iYcUbHt9ds7/FWcZjnuQa4isC9pDHawiJ8DFJo2mK5kWJAamKIbHrA10t4sbX+s3EjzoszoO4kbWdae6emgdabsHYK7wSOwL0aR6uC4//CpXbIDG0Q8zdlAGsNCdtRxae0e/B/v7pZ+ru02ikJ3D6hLNfbdwi9rkm3NcZ6TpBt+AJjr2sqPD3t0aAY0btwSiR3d3wunKkbKfgRtH2PA/h95a3rcs1yRxUapS7w0zUUgfDGhqmTsR5zfaFMbhOOSK6ef7Fylw7/+ZRThXvkY5/oVQlUvqFuAfUJQEmYpWRK2QL4LjgicUiWtu9qj/smYwWHwamtL596dYnlR6HOt+2Bf9UStlTTXH1LdkSOKBfLhDYyFZownh/N
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:01:49.6675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d0e8d4-7fb0-4ba1-72ec-08df34d21a61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB948819
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 27/10/2026 18:33, Tom Rini wrote:
> On Tue, Oct 27, 2026 at 05:02:12PM +0100, Jerome Forissier wrote:
> 
>> Some tests intentionally trigger diagnostics that the Python console
>> parser treats as unexpected errors.
>>
>> Add helpers that silence these diagnostics while preserving the previous
>> console state, allowing tests to hide expected errors without accessing
>> global data directly.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>> ---
>>  include/test/ut.h | 17 +++++++++++++++++
>>  test/ut.c         | 15 +++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> I am proposing this patch as a prerequisite to merging the series "net:
>> lwip: restore TFTP client and command parity" by James H. [1] which would
>> otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
>> [3].
>>
>> [1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
>> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/128187#L3716
>> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1762
> 
> Sorry, what's the unexpected error line(s) in 2?
> 

The failed test is tftp_test_protected_autostart(). The unexpected
error is:

  ## Error: !

The test marks "autostart" read-only and then calls the TFTP download
helpers, expecting them to fail [4]. The helpers reach netboot_run(),
which tries to set "autostart" to "no" [5]. The environment code [6]
consequently starts printing:

  ## Error: Can't overwrite "autostart"

The Python console parser defines "## Error: " as an error pattern [7].
It registers that pattern in the list of bad console patterns [8].
While waiting for the U-Boot prompt, run_command() matches the bad
patterns and raises BootFail [9]. The match occurs as soon as the
"## Error: " prefix is received, hence the truncated diagnostic followed
by pytest's "!" failure marker.

The amended test fixes this by silencing the console only around the
calls expected to fail and restoring its previous state afterwards [10].

[4] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/test/dm/tftp.c#L1021-1038
[5] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/net/net-common.c#L77-87
[6] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/env/flags.c#L580-583
[7] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/test/py/console_base.py#L24
[8] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/test/py/console_base.py#L43-49
[9] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/af860eb6/test/py/console_base.py#L340-346
[10] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/blob/85f0eff82bd7117b062167e0a37b7a235e7485a2/test/dm/tftp.c#L837-850

Thanks,
Jerome

