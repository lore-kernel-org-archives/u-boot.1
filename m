Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD8606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wy5Mlihs;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fGzN7tQ2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 740F06078A;
	Wed, 21 Oct 2026 02:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXWcM8IzEUIr; Wed, 21 Oct 2026 02:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95CF36074D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792548987;
	b=IIFPU6HuuZFWV6sOp1znF3Dm4Z0a+0UE3PbS6L4iTUZr74kUS/4nzhPWHtyCR7gCupI2
	 v1HS1ZoG/lVAaOPK5GO4ZUXLHO+OippRNQLyoDFEOJS3uxL3RQ+q9PsmQdZIL2o2qDCDL
	 /CiMgpOSa4K2i2bG44rAqC/4wmSexOkzDe6wf7MoegyDkhs2JED1UBI05eCaI05C59kQw
	 D0a2noaAOM7aTcro2LxiSXDS6xp2TfXU/ssRkoE0DZ8lYH0Jy+SB1VojNU5OLEPWaztxb
	 5fgS7M0gAiSL6/14elSK9tFxQ3a0eMvHLsw9obmTFIdYjsNpQZ7/cNwJ+ijlQEKm9TA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792548987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YnBw3v/JAyFUC/7vqnoWXJ+If3esB1YgJlFFkJfh1i8=;
	b=Jbuw+FPdSEjMcxUwMJYMtuVS60kIhxhhC1NimnaoFM8Uk7pgpGHSa2MXvq8hG32ozgkt
	 ts2UOF+3U5zduIou55Ww6NL1GL71/fYNZkb47y7N6D66l5Ho+ztcmYAQ4URlM9vMfW1i/
	 U0pxZUG76OcGnyFMFkKv549B93aSXvQh7FzUyPjYsgJ3yfQAgF4pcz8KS4KckKmS1qe2C
	 uXb6xYLFWOG3b7eAyKm28xArRS3PVZUp8CKW4vEIdMf2S+b4/4N9CciWctWU6ReVUumA4
	 voeoVEK3tn6SMIjwwEfAq6XICzaudhqLzeQO2we+KjgkZL9adz3ku3FUj4bkr45+/CA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fGzN7tQ2;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792548987;
	bh=YnBw3v/JAyFUC/7vqnoWXJ+If3esB1YgJlFFkJfh1i8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wy5MlihsWl7B46x/MvuUtjvZpQ7uKlNupYOe6LhpIJ0aLikJfaUgWdlQj5UDn47Ln
	 EwUhNieXA4zKVTUhpakEcRSI68AF0NIExnWjcbmZPJWFpLiErlebF9O1vtUyHXJMfl
	 HtsWwQTJCGAsqja3yx6jRjIy7AQK6/Ylexbn7rWRH1Qs9sFIagEeVOJSoZ4b7bTohe
	 j6onFXzvrwwgkcIibSX9V0Z7xxW3C/Hvl2FWEIwdpL2E/HPfQYRuU/prfKT8pl1xNd
	 nAL80xyyXHnMjmPVyxsg9BtNDptAyrTTNwVu8ZMqy3ePnhWz9jHXKOC/pWKKBWg3Np
	 H8oiSlz+4yb0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95CF36074D;
	Wed, 21 Oct 2026 02:16:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9914B1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9659360755
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44lz-o6a4AwQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5CEB6074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792548985;
 b=VlZ07a4REzejuWoq5ReutaPzM7L/erdbHcu63/C7AmKf9hoxtJhDr/smyIdHMcPhHIER
 X4r1z/hccgU46b9mFKzkANNyStqYQ502p5YuOUTHUk/LHMiZcvqRcUu1VewTg0Qzig34a
 1muvlRWxfRSI3LXR/RORbOXtW6mm5wAlOZo5MJOsfjnLhq7/AbpboR0IRQ/2P4l3g3J96
 gV8NvgrIq+TnUxv8ZkUka0+deh6r+Yfgj5Zsa8dRoHZWMHUQRVGSBUTXV4ROKLgZLEVVE
 3XpIfYPZ2W5IFn56i/DesBZHcYxy2cGlc0qSQYKvUS3zkuwId6awDQtEJe3yXQTCXlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792548985;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=YnBw3v/JAyFUC/7vqnoWXJ+If3esB1YgJlFFkJfh1i8=;
 b=q3LfMaGxFr0qm1TTVoVC8Jxf4htiWFfYKvDvruSGeBFqF5A/PnQRTJ5L9qc+xR4F1zQf
 u/aqqfDW8LKVEx2GNJKfsG/JA4q0ofeZOijqqjFJhfgmXHKypAcg4MFmeSDbo1uZ22sjt
 vDKis8AJDaUYxOvSG7tMVYfXD0QgZPO37Xc3rFJNytJPmf6KI+WlbKmNMJKgi+gLX1/5N
 z7S+q0+nkGlu7o05pqM+ptvqIbVzy4dy1+KlhHtBfl2LcL3xndgogzQTUKjZHoc7+MIUg
 PrXTzAR1NsQ1hys85xlA1kwoTgpP/obiOz8V/zpPbPLSeMsdMwyuYz2/wKg+0LgkA1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fGzN7tQ2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fGzN7tQ2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5CEB6074D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:16:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B203844F6; Wed, 21 Oct 2026 04:16:22 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473FF8056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfmYSen+gQpZykgsAJFSlrBXYDgjfcNw8EM00JT69kHUQMZvmRZaMR+vBYsDo8HrImNi8B0AQi06w9NiF/Hf51LX78xp19wGSGpT9R8sMJ3uwPVuAL3F4u/crzKgaWUxm7qBnAx7T1xBKo/kKEtFvexgkdPfrzF2Ye4qmyTqt3QgLVsKrIo9gDkFRwSttD44hhJnJzRWlMxvvALGgjui1pTSQ1dcFluMjQ470NkPcZSQUxJezB2Lr88uGgfmLwhT6fYNSVpa8SpZftSO5iDQ/bjkPuJHUJk2nPF3T2jPCtb2JyZjENy8pQBMR8+jxdJ3uviY1jdJXuEdZpEWL8wyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnBw3v/JAyFUC/7vqnoWXJ+If3esB1YgJlFFkJfh1i8=;
 b=Jbzch1lgl1eK+mwZ3++d0i/IX7oV9A/kPb0Gv1F/Z/dNYA2uO6Kp6sLq1x3CbD0k0qhy0jD26Idih+RDlK16sqEJkAKSjd+IUjibmjgZDBhzh8thVwURJJ8C+NA8tQDdWbabEBYn1wFZryeSeiZ06XmQJgTI9s1CI1Af9KRiEbyGqfUYXZpiCTfTuFTreqWBiZPTqhy4VYM89LZtvnb2Nw5xiH0dPoQBIghN1HwoxpYHF0y/1SbJlnR+N4krtCh73iXxFnXKvHifaJ1dA5hoaHNqyxi7oWYawJxaISVeoM3NdG967b48i/g9XHa4dItChUqpwaJBGKu9wCMbTZ+9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnBw3v/JAyFUC/7vqnoWXJ+If3esB1YgJlFFkJfh1i8=;
 b=fGzN7tQ2BkT1DpPqogbQeDruOY9iBB5KPHxSMU+63xpVxjCr8qMF1CDuVeZh6aBITS5oLz7+2e/IIROZfBgmOKf+pMDyPcib/WNv1bkDHoBSlxWF4aByzULoRUIJx9lK55P8mOOjbGfmM1rckMEI3+GpKcf+Sds19v9JSgsM/AnEeb5yw7UxkKKLjrP/3mDVtNw3l+xXYZ2GUFW421iAH250158eXv1Nwrf+WhCiBlglHhoFD1cRG7jbOZBndcPlA9L5WedmhPtGpDfs5+n8vQslPolY2+dWAxqjhRDR7FZu1bkmy5cRko6uVOlGEB7Rxmwz/fgMJxxNHoSQTp4Sjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by LV4PR03MB8257.namprd03.prod.outlook.com
 (2603:10b6:408:2e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:16:12 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:16:12 +0000
Message-ID: <20bad023-51b4-42b0-b3fd-240bf0661f1a@altera.com>
Date: Wed, 21 Oct 2026 10:16:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] configs: socfpga: n5x: enable required configs
 for DDR retention
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-6-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-6-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::8) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|LV4PR03MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f779e16-683c-4dcf-ac4a-08df2f1946d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|55112099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: YPu4YrEVtuRwqylO5V1dOXcaerPcUxkcaY+IGl6Ij6jUi0mOO+TRFWRHu6Y20LkAue84AA3F4Uj99n09xZnRZTzhz15Sm3rZTHArI7C3r+7wD24HMl3hL5I7Bd+LnFy4hagytBVFphHWrUcYhnvBRQm24JTqIZTjwixR9gQV/7Hp6sq5jRtFgutg+16tp1K71KlAvE8+dvbF+R42hgrMyAM+5J1h85dm7s/r5/sy4ICTBBr7SYY2W3FAg9DE5ukAd5dzQe4rniE7pWdsrwPEOdUefnqiuAVQSuaGfgS+MV54l122DhjSnW6Yd6BoW8ee7QUqpNCn0y0fSL1rnXcQ3aYxRavmWWZ1AC/di6rqHD20e7PVzS1jjIGFWGysZBpDy7xo4QJ1BoLjeBNjlGiQrApYUtgkjcf9Bpp0jCs+yf+MElrm/o28+oG8tRjptG9EcuFimsJXpWhSjGMoMUQjmZktdcj53MirJqYuT49w1bjojW/ywoW/H6pJ2dWbaZuzNNOzf6nEZU5b//mnPdb0oDxT6Ui0wQmzagaWPDuvfwl60KDGc97TbEMG/nUhNFoc2aBC114El3Sr7bypNrCkOeWd9a7gVMObA5hGKbA+MXAFgxZIuUpeUD9rOAwH5nVp5mScKrJXdRUjEwODVW6Dy4bQc3tawbWkn1bB0K99DME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BkSis4MiswdndEclR4RTl1cHhidHVsSDZuK2tTWlVVblhUQnl0KzdZYnN1?=
 =?utf-8?B?QzI1K2lYT1FDNU1YdTBuSVBuRG9STFlubHpiQmVFNWlyalJRR2tWMEtpZTZ5?=
 =?utf-8?B?SkxyRHFycjdhcXh5ZGJFZldhenRDeElKaWVKWmk0QlR0ZlpjeW9Rd0hyaFB1?=
 =?utf-8?B?YVFsdHg1RkRpZWVYNzBOeWFNOW5RMVpYVmlXbzZjU0VRNGFaUU5SZFNwNXRR?=
 =?utf-8?B?NFZzTHE4c0FDVnBrREg4c0hUVUpZUmY5dzNpbFVndWFxOUNpS2RyMTlQTGxp?=
 =?utf-8?B?S3drWEFqYlFVU1l5WFhVdnNGcmhRN2xHOG5VN1g4dFcyd1IydEhvdzVKQzNw?=
 =?utf-8?B?VnFBVFRNcW5DdkJsWFJrMDQxelhhMm4wUHV0akVvWVh6N1FmdkQrWXVjN1Yz?=
 =?utf-8?B?bURUb0Y2RVdnMGhwejQvUTN5UUF4YWdQSFFFdHFmanhLVVpKNGFySC9xSWJS?=
 =?utf-8?B?SG5JUGpkYVFSMWZ5Z2sxOThjWGlQdzE4ZE80L3Roc2xBK2NqQ1l2S1NCWlAv?=
 =?utf-8?B?TlBDL01qb1lSUWJvR1FBRnBIbW9yRldCd3F4VjZyandGZU9KSkNPMHRqMDRs?=
 =?utf-8?B?MTJ3VDBtUHgyY29vdDkvYWhEMXp6TWVoQkRwK2c5aXY0ZDFTcEN6SUtPWlNz?=
 =?utf-8?B?TTVPbjlLRTFIejBMdGZKQm5Mb1liWmJDbm9mU3JGWElCSkU2Y2pqL1pCQkoz?=
 =?utf-8?B?WVZxckd0RnJId1pqaWkrSkJMNnVqUFdiN3pCR1ZGeWU0WEJlTTEzNFcyNTRN?=
 =?utf-8?B?RmRGTFNlS3A4bzVjVUpnVGNQaFNMS3BrUGtUTVoydVBJMEpIekpoajFsNExs?=
 =?utf-8?B?Sk5YNm9qMDdKR2s5NmFFL25yVjJxNjdudFZIL0taSUVaZjdlQWRWSGthU1Bl?=
 =?utf-8?B?OHM0Y0NFMTRGRDdzY1AwVWlmRWJWOXdTNTJHVktXNE5ZNXZaaDMybm1INnlk?=
 =?utf-8?B?Q0ZPRTFVSGhaRWd3N0drb0Q2aUUzR1RXU2xoZ1JHMjhXWnJYaTJyL2pMMk10?=
 =?utf-8?B?K09lRmhkQlVIeE5KaktEWG4vbUhXOHVVSXROS3RyR05nTHdjMmRkUDBDSnhK?=
 =?utf-8?B?S0lJRHRveHRLdm1tTkFWSXVrbVFzeVJqd1hzeDF1ZENyNU5hUHZubnpmQUlu?=
 =?utf-8?B?Tm1vUmVQV1k3VnVmNlFCQzN3YStzRzgwQzVESkcwelUrSndmWGw0QzViUFdT?=
 =?utf-8?B?OG1GZ3JUM3IzWEVCTW1salZvRWwxaHNEMWs4UnRibGl4cGRPNmF4UjhtT0s2?=
 =?utf-8?B?a25EZFBadStwNnp5WS9XZ3M3eGJpOFRYbWZHajBTeWNYNnQwWHBQMDhXTHNm?=
 =?utf-8?B?Wi9nLzV0LzRhUVFFdFFmc0pIU1RBUHV6VWt1WjNMR3B4d3oyWWxFZnNYQ3A1?=
 =?utf-8?B?OU1GOWlBQk5rZGk4OHQwUExKQ2FndnJJSmhmRlhaT0VabmNNVlZMbXpNWDZJ?=
 =?utf-8?B?NFJPWGtDZ1hhZUpJS2U4NHRVRzdyRW9Qck5HalNBRmhlaFJlbGoxMWROWENP?=
 =?utf-8?B?QTJTTC90ZW4zb3NxcnhhNHdjRUtJWVJVYkloU2hLWGRmM3A5ekluaTNiWmV0?=
 =?utf-8?B?UG85ZFN1aVoxKzNlc29odTFvZlc0bUNMc1BsVUJXaFl3eThjVEtDMGhPQVkv?=
 =?utf-8?B?aVZpQ3orZTM0a1c4T1dpMCt2dEZzUE5lQVRjNE5aQVZtZHpQSUh1V0tmaUY2?=
 =?utf-8?B?bU5zV1FXdzlEdm5qdmZuSWdaVHpJUll5alZNNVhoREgvcllDaTVMYXNmeUQr?=
 =?utf-8?B?alJQUW1kL2RFaW03VGZPbjBjZ2JxN2s0aXVSdXdyVFhZRXdqNENlc0R4NlhI?=
 =?utf-8?B?QVBLdjlEK3J4M3M2MEZLdnFlN3laa25Da0NzWXB5bkswaUV6Wnd0VC9abmZy?=
 =?utf-8?B?NUNuQWtHMGJCTUZpdjdhM1dYM2F6eGtiVXZuaVlNVGVYY0pqdUFTVDF5Zndq?=
 =?utf-8?B?SUM4T0R0NEw4WUVkTGJiS2REZXdUYmJRb2VPR3JWV0lsYkMzeEhIRFNESVFU?=
 =?utf-8?B?KzNnNU5QYU42cU5LcHNqSVpFR1Y4bnd6c3pPUUZUTENxRkJ3NldMY3lVNlFD?=
 =?utf-8?B?TlJjSy9DcTFTa1N4bzd6R0RYZ2VkM0RwbjBiREhkd2ExZVo2d3pHZCs0UnU0?=
 =?utf-8?B?cG9MbUhsNnBRbisrdFdDV2Q4TWVpZ1g5WnZKclg0UDVld1FkYUJsS2lMVVJU?=
 =?utf-8?B?TnFnUW1xNGFrU3VYajUzMlNIQzQxZWRXT0tZOHZEdzI3OHBJUmhNcWVOZnpn?=
 =?utf-8?B?cjFKejBMZmhIT0VZaGZRVW1JVlVvVnBZd1FLbnFBVkxNeU5wYUJWdTlOSzhk?=
 =?utf-8?B?UEFqTFhNNko0Q003MjYrejYrTDk4VXpqSXJ1dmdRS1dVdGVlUEkwQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f779e16-683c-4dcf-ac4a-08df2f1946d7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:16:12.1901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q18R9tUMVnpIR5ouqt4/7jiAltQh5gy83/Pk5dlyCPr4ua5KHTkUKqIycqrbs89nLcYiPCcmhr9pUEtWNslzcUzeDWQojdWkVjjKX5PIj6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8257
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> DDR retention lets N5X skip a full DDR re-calibration across a
> configuration reset by reusing previously calibrated PHY data, which
> significantly shortens bring-up time. To do this the SPL must, early in
> boot and before DRAM is usable, locate a known-good backup of the
> calibration data, verify it, and replay it into the DDR PHY before
> handoff. Enable the configs that this restore path depends on:
>
> - CONFIG_FS_LOADER / CONFIG_SPL_FS_LOADER: the generic firmware loader is
>    used by the DDR driver (request_firmware_into_buf()) to pull the backup
>    calibration header and data from the QSPI/NAND RAW partition into the
>    OCRAM scratch buffer (SOC64_OCRAM_PHY_BACKUP_BASE). The loader device is
>    resolved through the "firmware-loader" phandle on the DDR node, falling
>    back to /chosen. SPL_FS_LOADER is required because the restore runs in
>    SPL, before DRAM is available. The N5X RAW path binds SPI flash from DT
>    (sfconfig), so CONFIG_SPL_ENV_SUPPORT is not required.
>
> - CONFIG_SPL_CRC32: the retention path checksums the calibration payload
>    with crc32_wd_buf() when storing and validating the QSPI backup. SPL
>    must build lib/crc32.c (obj-$(CONFIG_SPL_CRC32)), which is not selected
>    by SHA384.
>
> - CONFIG_SHA384: the calibration backup is bound to the current DDR
>    configuration with a SHA-384 digest (sha384_csum_wd() over the DDR
>    handoff image and the mem-clk table). On store the digest is written
>    into the backup header; on restore it is recomputed and compared
>    (is_ddrconfig_hash_match()), so a backup that no longer matches the
>    running DDR / mem-clk configuration is rejected. Enabling SHA384 selects
>    the SHA-512 implementation it is built on, so CONFIG_SHA512_ALGO does
>    not need to be listed explicitly.
>
> Init order and failure modes: the restore is best-effort and fully
> guarded. The buffer load is bounds-checked against the HPS handoff region
> (SOC64_HANDOFF_BASE) to prevent overflow, the header magic must match, a
> CRC32 over the data must match, and finally the SHA-384 config hash must
> match. If any check fails (missing loader, read error, bad magic, CRC or
> hash mismatch) the backup is discarded and DDR falls back to a normal
> full calibration, so an invalid or stale backup never corrupts bring-up.
>
> These symbols are enabled only after the fs_loader RAW-partition support
> and the N5X self-refresh / retention restore code that consume them, so
> the series stays bisectable. The defconfig is kept in canonical
> savedefconfig order.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   configs/socfpga_n5x_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index 2d9456ef435..2119d8f4f4f 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -72,6 +72,8 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y
> +CONFIG_FS_LOADER=y
> +CONFIG_SPL_FS_LOADER=y
>   CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>   CONFIG_MMC_DW=y
>   CONFIG_SPI_FLASH_ISSI=y
> @@ -93,4 +95,5 @@ CONFIG_WDT=y
>   # CONFIG_SPL_USE_TINY_PRINTF is not set
>   CONFIG_PANIC_HANG=y
>   CONFIG_SPL_CRC32=y
> +CONFIG_SHA384=y
>   # CONFIG_TOOLS_MKEFICAPSULE is not set


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

