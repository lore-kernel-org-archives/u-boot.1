Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A023FF9D0E2
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 16:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5B9838BB;
	Tue, 14 Apr 2026 18:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="q2oHU+Kp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q2oHU+Kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDD1841CD; Tue, 14 Apr 2026 18:03:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2A2783693
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 18:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SKFInbCptNLxDtkvey6OirUfFytkTBkssDX6V0Tbe9t9/OCJEBU6SeBMZRSY2Pe60U9rRUIlU3MbrOIeGZYofs3q1QAYfo9owSPfcwVlzwI+QoOgIGxqczAouJIq+NkBAppgArjphKOPMfkEvdMj/NUnGBpo/XNDTZ4T2OxtoyiLZ2uWErxlBxyZrXLsbZtXncsNk6A4GM9PzavW8LGMIdaf+KNpjHe/ullIAHVYIH03UUeOlNFPiJkcqt60ucS7rTpBwyjVoakJjmPmEq/4drn6G8Mmh4wkLK8jtMPaRH/XJqDgI1LN0X8yXymEwrvYlKWdQjSX0V/PMJO2m/ERSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjHmdJac7YFqaFLcGgZhI3gVvlxr8kPtZnsacGdjQ7A=;
 b=sMW2bKTfHa0AwTENiW/jhi200ZuZxgBFRWm6zfqwyLqwlWGLPe1U8KKST88thfbJ/StdjVDvZXJAV7mNT8Fkqnbsgk8PABOtmhGZWfpxr5fY5ASA3aWl4DTn6y4jvSoVm5uCBen3eTPjubhCfzzC4hXf3v9dC0lL1W+hlqKthuyAIKvV8Z5UDal0f2hWzPxd71+UtjaHu5NfnKka4yfjnb6LsTgHzgP9RzatH9PRuUClQHyLv8l4uoEQyKU+rG1A7J2vqMJPd7ceP2prFpslFtYEHs7KnTgh2SGQsoPcnxBLY7hP6XpZoMdX+XuHrhYxGb53tuaJEA4C8U3oCepvMg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjHmdJac7YFqaFLcGgZhI3gVvlxr8kPtZnsacGdjQ7A=;
 b=q2oHU+KpmBKBxB7+ZPA+wYWRNd5kFi6paY/lI/4laISbAtQmK2dw5m9eha2lSkER3sO59fSPREh6zYm/HNbVKbUXitQwrMhm7r227I36m60qgpVjq6Ko3/CoJ4PYIqkyfvpvlss/EW0aNhlfLDqjzLvsonG/hI7qIhyUY3QUTok=
Received: from AM6PR10CA0047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::24)
 by VI0PR08MB10758.eurprd08.prod.outlook.com (2603:10a6:800:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:03:14 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:209:80:cafe::44) by AM6PR10CA0047.outlook.office365.com
 (2603:10a6:209:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 16:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.0
 via Frontend Transport; Tue, 14 Apr 2026 16:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmj+Zpkzz2xqaXeuiCP4IsnHrYjLCwS2pRqcPyuczrPJ3haZJpDBVO3g+/Wunhv9yiz2LnO1trw8ovcytipNztQ0QurCfC9ViMxK47lfz+z1U2aRy6mH2prxFKpOSuH+8HdsTgp7qiRhSvCxl6ZfIS6WOQaxp+xFK/+jgnVJ324Fyjd8RpxnAPGErcxZQvh67n8SDvSUaKjosxreGKnP0rxWrDKFCHOvimwFRRXh5DN8CNaZO9OqGLljStdbxjsbFXrlIumb3P1yDNlsuzcoxgZcBmx1hPgeFQHJ6YVz64byJGh+c3L603/SlAfyTjDhVQ8ZY2xYpHrLvlZRLdMkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjHmdJac7YFqaFLcGgZhI3gVvlxr8kPtZnsacGdjQ7A=;
 b=KhvNUevOtXeEbASFhN2GLpIIoY/2Ni26mGEnh/qHI89+seB/KFEqdNl3c9ZIsTV4kcFUjXFhZcHwWyfRPXyc6j08PYNXSLhvo6P/S9bwJn+xK9qroFoNS+dhVO4u8dlp2E0HpZMU+HkqZGZ2avDn4g7UmGOr2Evv75M/sDjClPhjXUExQXGo+qPcikg6uNK6Xf9c1mtfKKNbO/fR2c5T9RlDgcSKpOHLBERJBJ82qkq01IhajGbaaSrMFkfKmyQW/0vzXZFoWY6f3zbPwTKQUWbPxpUrEVpXzJbaft1WoUuYji/vBViNPkIHkUPLEEdDiooBZiX1V0uSfFlGgjgFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjHmdJac7YFqaFLcGgZhI3gVvlxr8kPtZnsacGdjQ7A=;
 b=q2oHU+KpmBKBxB7+ZPA+wYWRNd5kFi6paY/lI/4laISbAtQmK2dw5m9eha2lSkER3sO59fSPREh6zYm/HNbVKbUXitQwrMhm7r227I36m60qgpVjq6Ko3/CoJ4PYIqkyfvpvlss/EW0aNhlfLDqjzLvsonG/hI7qIhyUY3QUTok=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11711.eurprd08.prod.outlook.com
 (2603:10a6:800:312::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:02:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 16:02:08 +0000
Message-ID: <2a90ad52-4a9f-451b-acb9-b9b576fb348a@arm.com>
Date: Tue, 14 Apr 2026 18:02:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
To: Sebastian Alba Vives <sebasjosue84@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, jerome.forissier@linaro.org, stable@vger.kernel.org,
 nd@arm.com
References: <20260409164440.323405-1-sebasjosue84@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260409164440.323405-1-sebasjosue84@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11711:EE_|AM4PEPF00025F9C:EE_|VI0PR08MB10758:EE_
X-MS-Office365-Filtering-Correlation-Id: 68387a9d-6da0-4bd2-7999-08de9a3f5576
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: oahiRIAkzS2CBxes1MjfT/0QshgMO1bw3JnmQYC1ZSoejPxrM2HTPSigT5323WStbAZnp6Mp64SVf3ac+EU58FnCcrbUBdPuqIF4SUAkuV/f353W5nvN5d2UHgetQ0cBPHMPFvOoCZmE3sSK3mTPdPRgx8a2tKt6DbjW461g90UhNrC1YpJ2GrpN7mN23X2WMQMuCLosZZYENW44tF5FxgTh9puAjDISlhqdNhF/xP65Cp9R21VgfBrcrAF7/EmUL7A+3x9tWmcyq/a6BpDi8QwjJTbnEVdKWZ7GvZ+zhtojGTdkXnYP7Pi6Qfn0/HSFmpg8yv3xUjpUJxj/TmJYDJI5XR8d58I2s9/Oqauhu+OvAlmlHRMTCRdhY0JtQKZ66k+6UwDcVDbnlnOK9BY2MZPaug/gsCxdAIcVtXZ/A9ZufCH5YlfJB0dRK3qJEXCCfy+VjOiT2RMR3MGiXnk0wnm72ONpLClrVXEvmWSw+A2VGCdSaPciMkQAqXPzYozAIPAZf/bJPrT9sL7yMvhrIOhXX6y5iBpWDwn39ix+45jW7WG8iAW+kjUrBL7LZy754VnyfmESNOrBcBoTj/kbOEfU86gAOgjzhZv0D0XB3osWenkY59mAPBnzStTvJwB6IVtmYEkq2epjAnDiN50Xbl7VlCaldXKIZ0ymIJk2FiX3IzbizgLWBW5n/16BOaZE+SjjWHudzXxF3XWezC+d84Dqzjpy6VDnJ+NBZkNuVn4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: IAYz8jgCufXBKxclH0we3LNr2Dt8DYTo1RmaEP0rkdXIglKHlOKE5lTgkUgDWtWhsZv0gjku32qCpoT0eNTAVRVTGs6pgOdrHCnl1mi8/zi6dwDAwcKCfAGlNAy4o2rXs3nI9czpornPeaJhJRMRxL4SxtNtEg1z2sJNbFPxjjH/2Qdg2zWEWAfQxzepvnU9ZtvV7HiRZuYh9Hj4WjGlt8e1/7XnLxRJwbHSChKYmu2eTQ9VWm/Eu+tPzTFdiEdNxLsjtBZgGBhogjveAopj2KvWobU96OW0/vMB2csk96xuze4OcLqarvFCZLuLfUwxqccdyt4Z3B2nMgMsaqArKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11711
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: daff798e-bd35-426a-964b-08de9a3f2e5c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|36860700016|82310400026|14060799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mkkQDXjp5VPDIM0lpGYGuS6A7S/MJi6rADZSiy1S+3XKoUMqp2k6hCALpbtGQebH9+E41hxluSAO5/fd6RxwvZcj371TzHHA4B9xGIpK0UNYa/JxDUuf85SM+ZjCoX7KV/fJ+2M1odLDa/IHIO9b02MBv9e/e4Ps83OYBzFw65EwJ5czLJW09ltK+AT/+jiUl6nWyh0Nv6Mogn9yBfEghLbtkPrEugYdJO0UYEC8cGKZ97o9N1NzAL6wjH80fa+5j2DOzKXvNPxBpF+IUObtU/fLw9wjbBTFZXiTE2+9cM1Kx1xmXuIFipGn0eYKnm2PwTs0FhqMTDvc2EIkrcM2qgQPTiRGL0XTL9NV1ADSzQ46+syH2hCa4WzuZNxXApL5qf52j3vSHf4pTaR0IPeM1nsVZTtZStDYLXZQrppRnqAH3llkPYBbtpGHUlqMMjcShMyQir554+KprwnpknO1FwSeqYqUre8Bz4Jey7uJKZIfJreTr4U5WlxPqq1SVmITWSOAb6c6+ZUmgXFoP4PHEp0yldVsZaYBV+tezJLCcBXKboPOoySA1m3Agv+KeI4nG/feLIDgrivIqCahhqOucZEOlO3nEcn4dQPaVrXyxpUAkaUPoYPQhGUJ6IW7hbVlxpi/XCbzoNUm84rEtLWotbOh8daPd+erAbUGBcp8StkdY+gAs6Giujgt2sAd/u9EJWxAedl1hd+gqikMUnX/QI4+TrQySfEX7Z/d8LfhMk87WNi6nURe7iIagOD8Ay7qViXnER5nVMwMejDmc1PENQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(36860700016)(82310400026)(14060799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R+3sRaB0fjGQfefzp7BkDRK/6C5Z950fpU8SQgKcm/ervzVYKUGUMHE4aCqXS8BMrn1JuNGiV70uX/DhVKYvHyeGhBFlFukKgcRWGU/vM9jJzmOCMcaGq9+HXlbp2UXybZv8wjj9lpp00QiAI57JeZunJW5gEbn6W8+lkrbc0UW+v3xiDw7F+II+Nt9i2a5VIdtxYW366Ios06Fg5NvXLsE9ltglrfAC+NtwPwGOlWm4BQ46/LxilXuK2i2aBtxJiaee3+KQ/4tDnF8U6B8Zre155hgZZIZvtoLzgt2fRvg/vuB1bKkxhs6w4h2gWzuv8cy5Qa0uF54DeGfzx07tetsAwAI1GK10/cBiHzouHEw1NtMS9HiwyvVRqdMgBckCmMO/lbf7FJM9X6bPEVoab/ZS4aiiOfBhrKm0y0qJlcuxcky+KF8ERQh/VLgOwIby
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:03:13.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68387a9d-6da0-4bd2-7999-08de9a3f5576
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10758
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

On 09/04/2026 18:44, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> nfs_readlink_reply() validates rlen only against the incoming packet
> length (inherited from CVE-2019-14195), but not against the destination
> buffer nfs_path_buff[2048]. A malicious NFS server can send a valid
> READLINK reply where pathlen + rlen exceeds sizeof(nfs_path_buff),
> overflowing the BSS buffer into adjacent memory.
> 
> The recent fix in fd6e3d34097f addressed the same overflow class in
> net/lwip/nfs.c but left the legacy path in net/nfs-common.c unpatched.
> 
> Add bounds checks before both memcpy calls in nfs_readlink_reply():
> - relative path branch: reject if pathlen + rlen >= sizeof(nfs_path_buff)
> - absolute path branch: reject if rlen >= sizeof(nfs_path_buff)
> 
> Fixes: cf3a4f1e86 ("net: nfs: Fix CVE-2019-14195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  net/nfs-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/nfs-common.c b/net/nfs-common.c
> index 4fbde67a..72d8fd82 100644
> --- a/net/nfs-common.c
> +++ b/net/nfs-common.c
> @@ -674,11 +674,15 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
>  
>  		strcat(nfs_path, "/");
>  		pathlen = strlen(nfs_path);
> +		if (pathlen + rlen >= sizeof(nfs_path_buff))
> +			return -NFS_RPC_DROP;
>  		memcpy(nfs_path + pathlen,
>  		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>  		       rlen);
>  		nfs_path[pathlen + rlen] = 0;
>  	} else {
> +		if (rlen >= sizeof(nfs_path_buff))
> +			return -NFS_RPC_DROP;
>  		memcpy(nfs_path,
>  		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>  		       rlen);

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Added to my net queue, thanks!

-- 
Jerome
