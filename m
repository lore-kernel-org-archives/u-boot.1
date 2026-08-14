Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A3C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 15:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B35C0814C6;
	Fri, 14 Aug 2026 15:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PH19GUz-P4kk; Fri, 14 Aug 2026 15:42:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 090ED814C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786722171;
	bh=NINAZh1mH1rwVwv18jvGOPI4yNxNKrHq6dHou349W7Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrqqVp2bz2Vf5BdlCJY8A82puFLm8M562HYGjX/EYCXxfE8SWdSKkVKBbgw08CObK
	 wDEGIYZzzD+Mzpnp2mmpCpNgzKggEaII+dAJDVqJrdaXBTrtPGUT2FQDwyABicCupE
	 2PqKGfO+puiL7GubdgV9aIY2mFg3x7PfCqQlS8hAQxNNhoq95cjqrVW86VnouP9OZk
	 fPKz2/IfKde2trQI4d7GDyBnOjMgG5+c9JsVVVI7cTE23GD2WIZLcDtNWRD8sVeq21
	 pKDRfgrGCqJvZLRxDlwt3goqfN13b8NGJ9IcAml41uGDBoGONiyvAlJj2m7UMIKoyO
	 K/3ECZ8bON3eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 090ED814C2;
	Fri, 14 Aug 2026 15:42:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C86E9361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4C08607CD
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXvXMJdRqxix for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 15:42:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D038A607DD
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D038A607DD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=EWHj2jju; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=EWHj2jju
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D038A607DD
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:42:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=udECNgLBKlfw6Dh7TYE3uTh1eVaKxS+dePRqW/n15VF0gzjPjDQMtp80SI+5qSWeIjlaDtq6ZXMkFPad2gPKkqqDSStRqOVxbwy9/7770BCkqGOZqdnb+HNviTqMTA2jNTKEzH/+NJLNRqYua/uW3YWtFStHlPcq8pGKHINi/qoZpSom/cvtPn6QG4TkUdCHrt+NAHKp26d5FOxAgc+LW2cXlPW9z/t4+pvIkNoWaAQ4sg9egsPtg8WbjFjk/AWKoOyXNPo2QDgukKVGbJY8LXXQ5ZdPPo2jWsaCZRXKaUYmVZUGvUsBga8AdVK+XSPqJFjpNDDlkB36VrLAB47SAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NINAZh1mH1rwVwv18jvGOPI4yNxNKrHq6dHou349W7Q=;
 b=U4qyvAN5SoG7WxwAfgli37MLyZjzTk8c4CZ6p03U9yCCPE77bxotHQMt5VLdG3JKJCBh/0Ikq0HwCKfpkavIzseVti2W27IbXj+XLqiMr/Ijvl0DVQPFHc/bRJDzHCc9rI17vkH2nrs5gOAFfFCEtGT9P6fP4GBYb0pRbsCgJT+1oQqQciNlnwVZyg62DMkJvSruYx4w/3u5Z1p6ojQaF/6Ep7Hsrd8LFgebnorRyQxyeyuY7xlvDYs6RFthZsFNkZda9t054jjhrAC6J38tuXq8OOuHRTUT0CuGeP5q2KeASCDjJvRGzzfCODuNMVy4Nkg7fQJYm9RjBz5JUdTUyw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NINAZh1mH1rwVwv18jvGOPI4yNxNKrHq6dHou349W7Q=;
 b=EWHj2jjuEBOkvjiYde0Q+7XdVOm5w2uNDzsobouHOptMEYZEXt7ZsCVRm7tYTOsepbBEan0cajvYcDGhxhFmhDCW/VNsIU2wpcLuOIdGN+qiA/dubWWWEfQGLUvGbTyQ6Ju9YW9Zra3+meuXu8zf+NB/X3Y31L6YhgqiNGm55Ng=
Received: from DU6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::6) by
 AMDPR08MB11675.eurprd08.prod.outlook.com (2603:10a6:20b:739::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 15:42:40 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::32) by DU6P191CA0034.outlook.office365.com
 (2603:10a6:10:53f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 15:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Fri, 14 Aug 2026 15:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSjzYOjw4Jr/SblrDudrBilTonT+wNo03iqsNUWr5EY7YTJ5ICFapoGqEOl6rOrOWwrGnmtFz2pL/UD/604brkj+7kQbcuvXdAAGNfmHT3k0rSFlXzMLPCd+aneJiTWT/HryOn/nLWGmIRhWb2zdXwI/pIr3jC6DdX+nx9uD2M3uvvKCwDDsJTtSGk2BCwIwntxRVGv+p7dT7k3gfan1bzCxMpyvYub3Lss1r9iKOADXyD2MqNgu8ZKPfmS2N9qMUGNwbtikIcQfGVwkhfcRZqPrKNOWl6QySn/qAXN7A2OTSgr+MOClfpnRyWu2lhWxGJWiRMIEOI4q4YAY6vTMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NINAZh1mH1rwVwv18jvGOPI4yNxNKrHq6dHou349W7Q=;
 b=ecSUxKMFjcesb7s76ayQFgpc0DCwZsNgBw3AtqETliMW0GAZAKfjjLgtudC3Nz8eAYH58nIBTsh8bxcPK0+/4zkXOSt8vMbkXqBme3BxxD7AfYGM3ERGZV18xlB48/6AaV4Cde1aojyqTqZHz4O4Jjyqmu/BTTV7Zq49jqjVP0jMMlhljJjT/dJiozouhCtdjqF/01y94waq4tz2mou4jlXX9HOUElewWFoIw9ARYMzHyIDW9ZoL4LPqQFP0CVsvXcDUpNlqv5UiOyTN6owhVe5px31dym+D6gt0fACUgyTNUm29uLbmlI/i635up2JMgEQHNvKWEWkyGj0ismpN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NINAZh1mH1rwVwv18jvGOPI4yNxNKrHq6dHou349W7Q=;
 b=EWHj2jjuEBOkvjiYde0Q+7XdVOm5w2uNDzsobouHOptMEYZEXt7ZsCVRm7tYTOsepbBEan0cajvYcDGhxhFmhDCW/VNsIU2wpcLuOIdGN+qiA/dubWWWEfQGLUvGbTyQ6Ju9YW9Zra3+meuXu8zf+NB/X3Y31L6YhgqiNGm55Ng=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXPR08MB7527.eurprd08.prod.outlook.com
 (2603:10a6:102:24d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 15:42:06 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:42:06 +0000
Message-ID: <8a5d910f-2451-48e0-a59f-38a0278b7124@arm.com>
Date: Fri, 14 Aug 2026 17:42:05 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/2] net: dhcp6: fix out-of-bounds access in the option
 parser
To: Sean Edmond <seanedmond@microsoft.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.u-boot-project.org,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Argus <argus@byteray.co.uk>, Tom Rini <trini@konsulko.com>,
 Francois Berder <fberder@outlook.fr>, nd <nd@arm.com>
References: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
Content-Language: en-US
In-Reply-To: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXPR08MB7527:EE_|DU2PEPF00028CFE:EE_|AMDPR08MB11675:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ac8992-0e76-496b-0019-08defa1aac81
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: UVb21AXtGIM8XakIBNYdpj3Qfk4lJxIJ2vaslkfNRvMTZH2WvK8TajTAtOS1/GxHSST3K9iKrgGg3KlCX+uiiQuVCRns4LXCISUz5a8+ShgbI7KyxhYXjGlhD6Ngh/X+CcqerGS7dzWXaf0L/7Wan5YFF9nOJr46Xmt5eJmCyykYqD7l56b3Rm44uYi9z3phnH7V4RXyApZun6Vp8wAp13tI/kvvj/WGo8RWGl1g9OFse4c0hHUw+TsZeglTw33GdL199+dbPXxxFtrnAEh6ktPaHKj+e6g/S1Z8/vcQg3hZDPxawHs6UjaxL4jMOvEvhMV4b7Ls9fePSuBtHEipV8Z10PJOGUf3K55mBu/jZTvqKucOfeTli+k6soUnlstGxNZqpXdA/Ebp/Adl3eRJKZfc8BNV0k7fPA86THT15+jfnaA9GEGNGyGv0Vju3zwV3t4NSpYyWXVNBsZiQzHeepl6z9u/3bzBAU3296mxTLBqoO/TOZZsxUJ/3XdzTqcGO9DecBKxvDAYEt51a20zihLTjAhGPe+hI9QMy+AecXsTBiVVEhHAVfQd+ltLOEuBJFo3JSS0BLDUdCVOV3ayxVE3oBeQJDLAVas5eDdpUPypZ/EqwkrUuAl2/g+/T0Owru+/5zuhFSzDLW14BhIWe7o+kQKwJmmDt55TfdIvZKU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: AZ6unvOPhOASvpY0uFqDSfSF3ElAjInl6pP90HmIBEgQflWVv7EF++3DK6I9JFqbqOnkufBvD5zcHqPsmRiq4rXDS/Z4nLePcV7C0n+xIO4zuaOs+O0RuUbERP6ABs0cFrllrKUlj7bJgUI+iZiel6qHleuqakv+cz2hwkrosW9gDnD3aHz1MSD/+wtuejUQuR/OAjPoFxC1BdKPESCCDvnC62xm9VTG8GfmUcb4OjKcDifs9iIVTh3Co4DFFhBmRXm+H0Fw5+vmltt42SW0Hx+pWyvfttwm/mFAmGHUE4hvWvPGly1VoXIp1Ui9lZH754IE7HjjK7Td9WqB/Mt+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7527
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9b8c4ac4-0163-4695-c942-08defa1a9875
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|14060799003|82310400026|23010399003|35042699022|32650700020|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: hKw3mR+lAwPjy2nkpMTNs859kS+uS/Cpet2ABV5ktoMZfXGQa7YBoHAy4dvwgO3IkS+iucUvgMGFXnFfGFORha7bgPq3H0zpVuBfO2h/FuGfdDMSv+Tz7YAneANSu8KTW82xnWiUNKV7z4ZoVWfiXUdpzVobblIJk6lKCiElY0BQ+el22Sj3TDehms8mIb4X53fUqDcmbVQRPXFwEtPMVKWd4oqi+zHadb5Y8Fwfb5aEkiEWvsUB9fwNv/Mc0b1kxfa5tUNlapEKZdV/wSUSwRjZ4H6OacsGjUcOBfopFFfJ6rpTHhsboWBdm+J51JNbvP6En4SjkXTNz/+qc8vEuKen3OwmKOjDCafQ2K0OsD2gKXASJb4URuAl/NI5Y/sAkF4iXa77qSanF91uBmgH1jsj+lAOCH2IAOlgDzjD1AGOeClNYSvcSM9B9UcCcdxrSB8didWYpTVvm9dwxDmQIdwRGc5oGUKw4pKbKgYERbjCO8IaCeOZu721yQ5x3A2sJ9EFmBhNJFcc/Gt61t+lgRafBh9Eqmd/fnLzFp2Vz4DneoAyyhTZMbvm6vMYshnnre2Drbe8/7yzdzRRzzmi8p+sFAgA8cmUgRSPO6U9/3T9EMWRHYwfdowAJcZntxMW0zoL0YU3hZaSDkB4kCXAP/afEuB3xDdtI5jTVvATRiCDB11fW2IWWE3kqu3k9cbY824hnn0Lws6eKlHxZg3+Sw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(14060799003)(82310400026)(23010399003)(35042699022)(32650700020)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UBM5rjZ48QcLUpmgPNPeEkYiDwfsbqEOJuShoh3qEe9WlrRypwWlzr/tROWJ5Qc7k5kzbpxliwbv4VviaLOer0gmdy9mdR7hQ2yJ0AeV32rUknUAQscPdTKzJnGbgfP0Kkm1FmitfR0qJIQNXC0sFIVE9dRMLgGfYwojSQYFs5beXtZRcNDACxv5gwmDHElIYk0nMfYOLJctP5XS66VJGyfxAQE1nrX/X0Z7w0BqLnT3W+Cmlwr9T82TmA+RlD3ek5CvI4KdUT2mYiJYNMBRFWtYDSduynRRCHfg2PW5s1yT+VEr56G9wV7J6ieIg8m/nk/e6zEQ8pudtDuNVChjk8A+B1S9QX4ciQDrMB01B4nGdG/HoyDFpxGnRvC2KIViKltRAgYgVSpEjozIN/XJxirBY5sqSCh6nK1tDh3CyIVO02CgV2q1HzTFV7Wnnsae
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 15:42:40.2447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ac8992-0e76-496b-0019-08defa1aac81
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11675
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 06 Aug 2026 20:37:49 +0200, Shahriyar Jalayeri wrote:
> The DHCPv6 client takes the SERVERID and CLIENTID option lengths from a
> received ADVERTISE/REPLY without bounding them. The SERVERID length is
> later copied unbounded into the fixed net_tx_packet buffer when the
> REQUEST is built (an out-of-bounds write), and the CLIENTID length
> drives a memcmp against the fixed client-DUID buffer (an out-of-bounds
> read).
> Both are reachable by any on-link attacker that answers a DHCPv6 SOLICIT
> during netboot.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/2] net: dhcp6: bound received DUID option lengths
      commit: 806a22de450c945db76a1eb4c96aaa2c0e8b2a21
[2/2] test: dm: eth: add DHCPv6 oversized option regression tests
      commit: bee6e6485868342de8ef5de528cf1e2a7b741ce7

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

