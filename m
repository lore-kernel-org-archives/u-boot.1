Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ACACA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE271605E9;
	Mon, 28 Sep 2026 17:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCO2OfPK1UEK; Mon, 28 Sep 2026 17:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2783F606B0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615090;
	b=TUaZQ2FGaF4+8SpilAjx+yQuGzaaxwFwevB8sGbtt+bGmJRsg8oQC+oL0yha6Cb/V57A
	 gVFZE07Ga9Vxri+oC611hdf1S4FtkQsaw25R6OCk7J0LjQGN4sVPFNgnhu9OGvcQvIRpe
	 mu9T+tbkadJSFS3W+wQcIIusmKuAqDLLDglsIO4AqSwqyO6quFN3clpaNbO8V6ojbcMPZ
	 R+X0F6OHLAN1m901D0opvifS7/RO7y6FTXt66jsp7gPs2gy1OHAVMbc/WdcJTQOEHB/of
	 5hI3DRbjBY/cibttGeGtefCBLoQ7QVAx2qTSRRMuKEAVfQ7ohBJbbUDPUVqribrGVRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=x2tnv7fUbCYiTzw0o04Bivqg0o8bJzJjU4L3FneiKPQ=;
	b=ndHwxP9UlHfGqx0ShCjXkp/Gv73geyYMOBHHTMfK2o6g8XmJnNt2XjKJkczTBXJhFz3m
	 Ar8PAIJ7Ch+usHkSmfoRErtlEVSZOcS+xXk1O37BXsj9j/7MIid/148AfgjuvgdUNNHkA
	 Z0Aw+aS9Tb5Xy2FokjPWRJoL/LqzexriGUgeZGHZJ5IlZIIce4THL0lwB5rchHMErkCYa
	 bFjPRR36vXRiGN4CX6eL/EJcQUxDJwnlRrT8rSLxmZ+7TFNOEOuDwJOXLsueCWIFEwaJ1
	 fNsE+4nvUXzmDJcP53r9CMIWU+FBfX/eLTzoXPlOTu56Y51kEFQcG9oOJyiukoiheag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615090;
	bh=x2tnv7fUbCYiTzw0o04Bivqg0o8bJzJjU4L3FneiKPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fUg4j8FVMaRIVuosgedv6PTygiXTvad4THrODTQZqGnPugQkfWJcVuNbynoFXGs5L
	 74lnRA/2/JvKBp12KWiBMkkkW7Zrlc700/KXAXhitS0cOZxgEZxE6ubGSD5AoFVd6q
	 Q8Io5wyls5dubKuL0U4MDdkf9LGqRPOG2lOCnqQBzKp6oqc4YXawCGDexbqSn+O5V/
	 ns5YI2sVR3cqiUQ/FSLn9u2HqwjT1rEkP3ckKzZ8Zo2hBxfjsR/rfNTXhFXqPiQe14
	 d9SV4kLzXcJDLMDf71KKhnv8XlPveyhKvFYs9g5dRyxHnIUG+PbF96m+28Ld5bwpgW
	 s063dqjod1D7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2783F606B0;
	Mon, 28 Sep 2026 17:04:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9902361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A70A5401E9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aA2LptL0jEb4 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 13:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 692FF401C2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790603816;
 b=atKTIHcba+f3tbLWDumBSASdrTZkDBhy9yFSfUvUt6fRJ+PxmleBIx6t8tPjvoh+Ylq/
 +4ikbv1cwAaFkL1cY0er6moLsEO2QJ2MaclBLWFT/EbiHlQqcRO66cb9pzCGWJZmIxyEl
 1OurebNcpZ03BcCTnrnG7pP3LpzOm9c9zocIgl4t4PFohALAAJM+j+UeB0QgjpjFMQ2+k
 2DQA8DbxvsShHdpJsofPtBdq5vAKCUNaGAPsKqIxJ4mq+JKW1YNkOpVjN1HK3IA2hY/pg
 hIZ4jhBFNZ1Lc68XoOmxNWcD+5DFTFV3T5ai29dmcBt5btwO0DP0ocSZCzOjQHWFGAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790603816;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=x2tnv7fUbCYiTzw0o04Bivqg0o8bJzJjU4L3FneiKPQ=;
 b=Mu/5qP38wU29dgasvV1J60vdltlGkWVnlj1bN+YBcA28cmInVbFiyk1UKmBCdHTZlIGf
 tAUy1UWrNoWJDj0yCxMz1Bjl/JHiwZ3ft+wmDQLzp+WZDuISqRGkcxs81ZaBqKtaQYocM
 OwMNVBj7BGVRgHB9jMOfdeU5yE9tNIJTzJpjP+5/9t7ObNnfWOynht3t0PXPtQlpxa1sp
 LbmeYcrdoYNoGHrigFuw/ITnwWZ3o/o+mJGvxs8tArJhZ+kik6lHq38zcanW/Uw0VlHpd
 rmZa+Q3XF2N8KF9BZUrlm9gHh4DAM2blVrqIPBd0Q4ESqR3snLGL+GMMcR+ND62lckw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C1Zr7HBE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C1Zr7HBE
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 692FF401C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UobFwPZLcGfWnBDi4+5ZGXU2fhNnGhcm49xbdsaBdUlQ8EAsSjRlxuN2gxmUbWnS4zScPn44p20VqoQ9Z6dI7u42v6tHFhRWcilYsTH2a5E4anUdHbEvmCKVROkLXutmCHezTWAm09FIna/4NP0P/ydBJCWs5mtuHnKA4oRa3TXA3IAhTAVjaiMvEhYOgIyAC0GcTAwnBFye14mlQtO6ixjwdYRYo6PWgyH7UjMSiF9KsGfPnqwIU9HuKxwhCWyRP76RwBJR6T1PPt4UZCEXS2zFdbRglhrum+EU81ob2HzeGTjTWXspmrJuMpOy2H+9vYBFwh6fLXqGx5udzzL6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2tnv7fUbCYiTzw0o04Bivqg0o8bJzJjU4L3FneiKPQ=;
 b=UCR7+ZIYo/cfLVoh3X9xNWOYgu474RR19d/v5KSPg4n/unZi1ibK+v1roF9TcJNuh9A3/kyhgcE+4v0rMWcDtpp9aeHZMzvs+6pgBfvaXAUITZaAWSfe2/PhKHHPXe/1kqJSmwop8SSxLFXcTNdRmQIN/5Q+yv0C5lcZGC5YkMZVsF9Xrb8xi65vLCICeLljRt2g/ChqlMbEp8jRw6NvqFSd5UfOdmGDuOpx11BeWoH7uYcK5/2Hi3lx92GYsycW/UvTzM/ExJHE7WQ/rrQkwxRWCfXIGuO3O1Pg2ka8ZN11jxpq/EN5c2Btm50V7aeldcGQ7av1dj+jGKnaQM8o8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2tnv7fUbCYiTzw0o04Bivqg0o8bJzJjU4L3FneiKPQ=;
 b=C1Zr7HBEH03+WLWpZUCb5jgiyvgqpcUAZkooyuqCW7tnBcQ42CQtYJlvYByQoRSLfB1gWAEEtOgu+CeOGOLGsXE3ZXdwNglGfKpMhfycVwMa60vig1TsdgpmzYEwXym8iPBGmTukuEBCnZbEGlU1xa/0cK5oNC+XaAo4ZMdPOrs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:56:49 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:56:48 +0000
Message-ID: <b860db83-1e31-4531-a7e3-3a49011d5c97@cherry.de>
Date: Mon, 28 Sep 2026 15:56:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in
 SPL if enabled
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::48) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: d58af95d-64a7-41a0-ec54-08df1d685734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: WZkJvqL0lDTpBDKkbDumKNKU4suthg1GdOabC89Glr17pBwzd8uxX/Yq6dmFjfEVNQ81865U7YtN/LJ3wNLFKAXoK1pQLnSkTEJDEp8hWHy0i0zpQ5WlrEBOAzLNrjKwa6TcHt9Jy9JYSOiqxi6RLpL0Qco6J09Ip0cGTIfuiYdmrdp7vUanle32VYbK/5SxUwOy5PcR0HIr1+7uWFQQ6h+Jauyoyy3l9gUTSSCvkjUlzlgC6uwSnGc7UVQXyCGVSyt86r2UvXJXkwfUEHTJYboCLMnXT5bN8LiQANZav47j7bTV0XgjikEElpY1U+YbNzifMrIbExu6CiA6oZxa+J3azcHm4WGMf3gN1M+WoIDmttQNPaaVmcyymrJ2y5TeEowaLVWs/pU/hd3bRpg8u5u/jrD/YlZmkuPHTkWuOp7N9IQT8Q8GVXqMUdOV99wfbSEHqEEcOZPbjM8L3qYcPjqbOWdS63S306BSQIngOjMmQEyJlOmddLtfmsFolhmZtj8QrUbIsZIQeXacgW0IKYSyaQvJEQADVxWWALjUnaEJqeR0aBc31o0SvTBguGSrvHXGHbfG6n1Ie6HWK6yUPR5K1X0LkYRlNG4I7t8n3ZL3x0lKGDbfYnL4xYMHsnerNPlxgVsGc/VNaf4bpDBrA1IeqAb2vhcUFkDX4jq5XGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVzajhWQkEvZDNHbEVjZytFdDlxWHFLVFBnbGRwRW5SUUIvQmhpbkFKUTMw?=
 =?utf-8?B?c2NtenJBRGRrNWFsN0c3cUtXSVNIemF0OFdWaXJNd3FxNE5FQ3c3L2NTR2RB?=
 =?utf-8?B?ei9HdmpHelFic1MxcEFJVW1rc3F3cnkyeHhJNXRVUWt4K1lvNTMvYUVBQlQz?=
 =?utf-8?B?dGRjVGFIOTR0MGhqdXZncWk2TTd4b2l3NWEwTlZkZVIySURTYm1Fai9zUzhB?=
 =?utf-8?B?WW5FVVN5bVFOdnh2QllXS1BvU1VDc0YvdzRaTS9xSHpjSzFuS0VkcG8yM0Fy?=
 =?utf-8?B?dzFXRDdET2Rvck1KSUt0alBXM2NFTDdTbGpFY3RhY2Rqd2RQYkk5OHA4dUN0?=
 =?utf-8?B?K0k4Rktubkc0NUI0N2k2c3ZTVW5xNTlLTkdrUGI5ZlNSZjQ3MmNlbGhXckwz?=
 =?utf-8?B?Qkg2d0s1eUZXRXQ3MTlzSytxN0xZc01CYWIzWm5tdGJEWXlScjZsRWNzZnVj?=
 =?utf-8?B?ZCtGR0hodkZjRkNsRDhMZU8zZ3dIOEUrYUVQUFJSU3RreTZQUFRRY0JCQloy?=
 =?utf-8?B?ZEJBeXQzTFJtMTFSbGVQWTE0Y0h1cEdaWXlYcTlFd1BqNS9NR1JxV2xVTVNy?=
 =?utf-8?B?eTNIVHRGRGFINmRwT3cxVDZNdFcxd2I0NlZOR0tTZVljeDRSZDVWOWQrd3h5?=
 =?utf-8?B?UWN0SkVNUklPV0Z1V0hMOUVwNFNSMS9laHFSMkw1NXpHaWlKeEdRRDV4dm1Y?=
 =?utf-8?B?OElMcENmaE1ONGZjb3J6Um5jVTdacm9RWHp6YktFTElPK1lxWUFvY2xMUDlN?=
 =?utf-8?B?ZnB3NXRlRVRTVHIzQWZCWkc1L1NuUWVidjA1dWpYT29FUVdaRWR5cC8yN2Nn?=
 =?utf-8?B?enlPTFRFRjEzMk9zSk9XRVQzTUI2YVJ3QllaaWRzRHVrWUtvR3RUUFFUOS81?=
 =?utf-8?B?Rm9HRXZQVEFBeFZDdDAzUWFuQ3E5SlNiTXBqenJSWG1TdnAxRkdwOXk5UFQy?=
 =?utf-8?B?M3h2Zys2QWpCTVVpQkd1ZFZCRmhUcmQzZ2gvQnJjdHNtQVRBQW05SmR5NXcr?=
 =?utf-8?B?dCtqSWppQnJZTEhjS3h6K3IzbmxwcjBJVEZaTGpoQTVEdmw3a1RqUW4vN1kr?=
 =?utf-8?B?dTNmclpaQ0s5bnQ1ZU95K29XR3BudElSZVJKemcwbWRaN2pYY3lzY2ZYVDFC?=
 =?utf-8?B?ZTR0cy8xamRTTU5hZG5VcWQ5aXFnRitYbWZuclFGSXJkc2t3Z0ZOUFB0ZlVK?=
 =?utf-8?B?RzFSY2c2NE1IcDhMSkxIMVlwWjhndFQyM1A0UkFHV1l2Tmt2cWowNXc3SVVa?=
 =?utf-8?B?RVJKdi9kcDAranlwOGhMeUN2b2FId1dtUjJ4K0hQeTAybDBqbjJiODY0Mm1Q?=
 =?utf-8?B?cCtuSXNMRkNXOEh5ai9MSlUyZEV2ZVRVbjVjd2FDRTZSTVlIYUIwWFoweE9n?=
 =?utf-8?B?K0V3am9mVzNxcmV2SjVocE9DOCswMmdleHNPbVUzaUZsSXlhWHpPWWxLUWJJ?=
 =?utf-8?B?cGkrdHN6U1JtZDlRWFdpSk9Fb0ozSXlCbzgzcStoa096Z2RIbmtBWjByc01j?=
 =?utf-8?B?SUI5NlN6WkJ4VDdySHRoUHFhaGdxV29RNUJIUisxTC9iUG92T2hocGxvR3Bs?=
 =?utf-8?B?Ky9MUHdLV1dHQTg1clJxUWpLVjVzdVN5U3gwVEZ6UHBLeGtEcnMwK1hWTnBk?=
 =?utf-8?B?VnVmUGx5dm9kRU5UYVZLcWhKSkt6KzlNKytCWGpXY0ZjTlcyQm9RQnUzOGVD?=
 =?utf-8?B?dFlWRVAvdXNzeUpMVno3OUxJbjhrMnQvY2c2Rm0xa0VlVUdKZkswTUl2cWRJ?=
 =?utf-8?B?MHlSeTRBZnoyK0VxdmRYT2hmV01RaXFCWUN1K0ZoZUZBZC90Q1lseFpHU2JR?=
 =?utf-8?B?WVBNSUZXb2ZQMlFUMkVROUlPeVhnUzdtdm5vLzRkL0h4NW5zVTBldkJkRUlz?=
 =?utf-8?B?V2V6UitPS253YVVST3E2c2M0dmc1L2h2ekNQVWM4czJsZFYzVEVISDI0czc4?=
 =?utf-8?B?aDVlU2xYZzhlTHdSTDBpWTQ0MTVGcThhSER4ZzU5dVZoOVRNaGVpRG5HUENw?=
 =?utf-8?B?bTJjS3libnAvMWdOUzF2dTRRVnVyZStpVUpaWElzZFJQMzMwamtFNkxvOTFw?=
 =?utf-8?B?U1BDazdHNC9Zd1FoTnRjUVg4REVwU2NoUDhhc05vZk56WnBRUjl0VnlLb2NO?=
 =?utf-8?B?R0ovSHU3SWZjaUorMitXd0ErYXBVNEVxOGxndHlDTUhGcUVUU3FiaEtIYjJa?=
 =?utf-8?B?eUxsbzNIazJsaEN4WWhrbW5FZGZwTjVXN2REbHNvYkg4UnZUZlBwQ2ZjM3U2?=
 =?utf-8?B?dzhISllpbUpjekE2NEYwTzRONGROZVU0UURmTzlYdjQzK01JMXBRSXVZalRX?=
 =?utf-8?B?L2hjRE1yajQrL2twMWJVMTNQQXRLTG1tSHNZNjJzQStDaDZSdkczdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d58af95d-64a7-41a0-ec54-08df1d685734
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:56:48.8000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgkBGXIkpI5h6RgyHbj26TF96NVfDf/RvXkzZObxZ3N9L2flPlsGd+dJZCEsSicnB/wAgM8NT5WfKLIJg1tMb+PE2eJHsH/8z7Fu9HwBu14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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

Hi Alexey,

Forgot something else.

On 7/31/26 7:10 PM, Alexey Charkov wrote:
> Common code calls into a platform specific function to determine whether
> to attempt OS boot in Falcon mode.
> 
> There is currently no platform logic to drive that decision on Rockchip,
> so attempt Falcon mode boot whenever it is enabled in the configuration.
> 
> This can be overridden by board code if needed with appropriate logic, such
> as checking for a button state to skip Falcon mode boot when pressed.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079a..54dec06737e1 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
>   	cleanup_before_linux();
>   }
>   
> +#if CONFIG_IS_ENABLED(OS_BOOT)
> +/**
> + * board_spl_start_uboot() - decides whether to boot the OS or U-Boot proper
> + *
> + * If Falcon mode (direct Linux boot via TF-A from SPL) is selected via config,
> + * try booting to Linux first, with automatic fallback to U-Boot if it fails to

Only if CONFIG_SPL_OS_BOOT_SECURE is not set (which is a bit of a 
confusing name I must admit). Except for SATA I believe, which does not 
use that symbol, though I don't think it actually works since err is 
never set when spl_load_image_fat_os() is called so it'll always error 
out if that function (or spl_start_uboot()) returns 0. Except for USB, 
which doesn't read CONFIG_SPL_OS_BOOT_SECURE so always falls back, it 
however doesn't suffer from the same shortcoming as SATA as err = 0 upon 
entering the condition. Except XIP, which doesn't fall back.

I'm not sure how to word this better though. I'm guessing we should say 
that it depends on how the various SPL_LOAD_IMAGE_METHOD are implemented 
and we can hint that they *may* and probably do provide fallback in some 
cases.

Cheers,
Quentin
