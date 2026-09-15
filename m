Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58251C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C03E406BC;
	Tue, 15 Sep 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIgSYSbh1LhW; Tue, 15 Sep 2026 13:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CB84406AF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789477324;
	b=jG0zGUYWkESMP1h2qnxJrUVhmgi1z1Au3lU7bcZH0/ZVwEKESeuudxuLLy94VXfNrxgw
	 3BepTnAS1pB9jeGtH+tGxYClTyNgInjwH5Od3xcu03U8z7TcmksuXtj0RSJvnn0hFUZKH
	 OFWlIQV7P1uWsdKyWN4gY3/woE6GF+BPuod+OQsKyHcvkM/5dG6jfPA8NuHeeNZwgmxQF
	 G6MEXeO2bHDVSfJ5Gj/tQSo3fJneMRsHlpmRQlp0nPnLjfQ3BV5L20ijW6IU45HnmM52k
	 BhV2suZ+a0my/tgaBT5IIvekmg6DuH38GaFs/x1cGtAeHPt0rogJo7I6eEeBwMHiX2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789477324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R20b4A++kCEZ5LAEiLoOiOMLZ1QuJqH1NXEYVHurYCc=;
	b=XxWXlNB20SVoyA1dozgzjSuUodjct9us5EfxlKugVT/78szlkqyuOMW8HNmzbOJLKdJv
	 oiTd/wpiFUTpnsSFhwu+dYOKMEOe9gnzDMKz8NLvMcbr7WB5nPJQsnClor3Ayzd/NPeeV
	 /jBhXGGjP4zTK+J2m6EGu55uu3zvXc6gfAoOkCTe5P3DCONswNukLPEKTlNh+FPMeZI+Q
	 DKAWctnETam1UKznd3RX9deXXV8uzv2X+uysUeKwukJUtcbaTAl964JWY89EewkU0JYw7
	 GDirIfAgiF0+2V2ap+LAy60aorU56sn2479EmyS48wyGrcY1bYncg2VyY8UZiSXE0Bw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789477324;
	bh=R20b4A++kCEZ5LAEiLoOiOMLZ1QuJqH1NXEYVHurYCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHrGDohoiEHu0HpodQ7J1XC8oCnSbBEoLA5oErlGfzRtjUNFU3AvgsA+JC96/N9nu
	 sbzFE/+07h/w/Ueuwx17SbP0Ir4ipk8XbgAMCGR1+d2yGrr7YyQiVXIUA3/IfMZVfZ
	 Pv2O9fo0rFPc10DHqoYxmeVrYcAOs2l4pwt8BFAr421eF07M90iigr83NC9L/YJqLr
	 siVxsEK/SVSR5KTiGCkNYRub9c/8q1CBXt4qMpgXDX4W3fKmMDo0EdZWU/WBh4HEb0
	 rFpZletneK3xzSQHwKjdOCrKbrX0nbbCBfXBodP1C+THDuFPM9sXQQ+bHbT8CKFwKW
	 z3ufza/1WwEDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CB84406AF;
	Tue, 15 Sep 2026 13:02:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 728E82E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6471940217
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6k_MJJ7zSGIC for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:02:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7CB2940212
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789477322;
 b=C7vTIPGDiovvfJeW0sGG9mCiI+1KVWyLFoTSUUcMHTXOPbtFWWIn3ULz0aOOWVIdwu99
 kNzf743SRTBnu6qPkT6VsRHTANv/23zjqnHZp//2oVrZ20Y+HmZRStTK1vJKzzBRByYJ0
 Z/etfiKm60HQZldyDVrc3VnbWqmX3XDqTqSYWjhGP+SFR8zeAf44rRxP2+rVij7TZsfe1
 rCV4ADzNdczTX7fXHtO9bJh8XeK29hcYHKO+i3+hiw0sMv0UWBdxVudM4VNKeKEDQZ6iR
 DNfknlAEzluO7b67RgMZYBU+RzhX/nXwaYCrnPxJrPAX2c/bmRVlqj80WoV6MNn9e9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789477322;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=R20b4A++kCEZ5LAEiLoOiOMLZ1QuJqH1NXEYVHurYCc=;
 b=CMy9YaMfeFtnM2O9TFwVPchkLXFlkw51VwByCZCIbefR/o+Qp0+Z92juzw6DcRA86hYy
 tKnVMSyscU5HRhcaborkbVSjdeo6uTvIb+I30YH+Ubd7TWiCw8+kM0E+SGzNPPwD/ZjX6
 u2i5EjM9O9r41RgzQY4aVthB2ndBQUrbA83YDCjbfDHBhE+1/IqxXfGuT7XbaKXwxmmPD
 ooHnwVVv0E+3bcXandJ3/j3Bctq7N6zIIPuvf05Dq9ReaB+NaVSdnSvdV4iQUP76yCFIe
 v48DP8Ir54CaIXYZWXgQCirI0HM6mFfADugw220fVGH+PwrBJRiubSOOTvmpJiyv6Vw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=n+s+mmcF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=n+s+mmcF
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CB2940212
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+6K5oZw68T5QRFk37sKLmSF+09P44RlEBFagQ7Z6o8jvih9MCznGnmyY7dKEPPLHnYOgeHJvLF8ZVo0eqX6gLyu6GkDDT5eae7KTjaBgIrtbmV6qT9NGFghhy2rgSDBpNVFUynESg1mW9pl/86fVt60mgAIVlqNpJuqpRqeR8kA0bcoCyo4vPt6KdZAEPU+L4Nlhn2ZpMDYCMj4z9P5qZMrN7nB7VMbh9pmcXLNvP81T3crDNumw2OzNBvDpodq2TcrQpqgyo0ebTFaYOCqrUhBRrkzVa3sfsoOY7C+iR+mQYHYfqsVYBWgmrtKUlgHT/1KtDWQNQPE+z4BXsVAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R20b4A++kCEZ5LAEiLoOiOMLZ1QuJqH1NXEYVHurYCc=;
 b=ELJZJPmbvQFn75MMH/XE54aM8djwz7o4z1PnSvToqgKt3impsgKfdYQttPVvkBeovobfoqPYbO457fXmw3zYOKw61lS2lNjLf+VLLlkpCg7ja/CIa/Ejrx99pYXOEV+T+CcTLWMYrwGddk2XdcwykAcSoFw2k+nRL4fDjzRS5UpgPns2tXbiVmMUwEERSjW037SXvz3U8JQJLyVHSI1LDIjoNODjyyA6JZWM9ipYRXTcTpX4P71iCcAZ8KquQAelQjebXnVoi8/yhO8LzloXOvtckwbpRNCjcp28TgkgJxol2zuhD/xgd/b0QVoTLneOWPz2+rvMyzoeu3j5MY/Raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R20b4A++kCEZ5LAEiLoOiOMLZ1QuJqH1NXEYVHurYCc=;
 b=n+s+mmcFbWzESZPaDB3qCTnROmmwQxyis8KpZmQ56GTTFzhG7QKsP8OmNRePEtbSkRD0Aru0r7lN1jjRbojuMY6taM1cxY8wDC4KwlnwfMf5DyL9rP+HbCBSBd/8u2fOpk8T327bxIEFAVUoOC7rmsF1J2Qeji71qlBtY5TVgxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:01:44 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:01:44 +0000
Message-ID: <4c19bc1b-d0df-4342-bd3a-ecffc842de2f@amd.com>
Date: Tue, 15 Sep 2026 15:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <20260914203931.GA631895@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260914203931.GA631895@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: c639dffc-b222-41d3-295b-08df13297e2a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RdQddJcZdbq7GHydcN5ItzmZaZ2gZF6gLBLUTlwswhQ68sl6g1TL58IZZ4fZ4KE6ugpuvLzspJeO2C536Rr2YHMzVWPjGYLPN6vJJZ1gdqN/se3rDmd1qqe13PbqFaNlQpPPvoEpyqrPrE6rFV3ALEQ5Y6TJ03BVyovcsuHuoVVuguteo9hOkoyX1SeJoyCf8MTXQiZO5cZJ1rO9EIwohhifGihGKDYBHvJKEDO9sMRQGbfjY8qmVi7LgE+HFj3NLIDZSIEWgoO+5QZotTnaieEhZMUed2VfrABB5SO9fZp/LcIgPkGce7KHFA+xybVKmwXGZFXMAhvZiAApclJXOWLj83+4Nd9VY+QoW4FHDbtm13hxaU5ozSsU1E0JhZVOfC7xQFfom8lJT2ptRGXuYlEogW01eYiEOUFxMIXmUb/osqvUSIMYz2j9oen7osFLKJcMLpNDiBl/ERRvA36QbsmDnWT3VqtUSk4JWHefNbmFeffp75BzgrjJGKFVS4JoCVJ5cGBE7GH+3WCs4n8h0GvSVpfUwdxY52Pxl7x04mgj+TBTfnp0UNEJ2E1X0SIxo2SKxa7lvkyN/h9zeSD7NxZ3kqtZG8AY4V8XI8LQUb3JVpr1YBtLgpTSyeC9fCjQPF41ttIuhXhAqlqUTuDc7mosiV05GnbmEEGTjGDgEv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlk4VnU4RjFVdVlMaTUyNUxmcllGRWxXNmw1ZlgxWTJWeVA2bVg0bWI3cW5z?=
 =?utf-8?B?N3A0NFJ2UWNnalBMNWR0QkRrR3hHUTFNSVFKendiZUVocEpRQzR3aTdHbTht?=
 =?utf-8?B?aDlNT2Y2cEZpcjdGRUE5cmdsVGFmVE1kd2FHRkdHTGxCVnVvMHpmdllibEEv?=
 =?utf-8?B?UnlPcVVrTklhZWVWaGR3ZnhHRzZPck1XbkNqczdPTUkyWDBvOFNVZmdGZVUx?=
 =?utf-8?B?bWc5SFp2ZWdOWWtBU2Z0K1NjOXhPZFcySHdBRDFvbDdwQ081cHdERjdhdldi?=
 =?utf-8?B?ODNQZnJlOEFpdlBEUzB1OStYK25rOUs0WVZGbDRGbmhnUEZhK1d6L2Y4VHpj?=
 =?utf-8?B?UEE3VnkzR1oybkFYcXlOeWNWc2dDRU5QVHhoeG5pd2RkdU5zakMrYkZBSmY4?=
 =?utf-8?B?dHlRSzRFMGtEblRNSFNWbHpxWHZPQ3lNTGVBVFRXdTNmUmtuYXpweVRIN0Rn?=
 =?utf-8?B?Y2UvaENoV2IrdG9oNmNGQ0M0MmpsRHg3blhtZVp1Yi9tYUd3RWR1WUd5YXdU?=
 =?utf-8?B?cnZFa0xRcmpPSGU1N1RxT01uMndYODcvcUtBNmt4aHBqa21kMzJ1U0dHUWgw?=
 =?utf-8?B?amR5ZjQvZ3g4enhsZElCZHRaOGs4eGhab1RPS3NvL2R6ZW1KRDRKR0taa1lh?=
 =?utf-8?B?Y0pNMlluV2dlRXBMSkM2cWZEcDRROEVlNHk0S0txMTYvemxBRWhFYithMUM5?=
 =?utf-8?B?UWE5cGxESUlBcmtwY29UY09ZSjJRb2Z1V3dlZW1BZFJvc3hsTzU5VTdrWUZZ?=
 =?utf-8?B?MVFpUUZza1JRc0ZhVFEzeDJJTUdscFdlcitlRDhrWkNGcnVNU2lsN3BGZ3FQ?=
 =?utf-8?B?Z0QxUnhWdHRVWG9uSHdKNVJrYzlwa1BEb3h6SnY2T1FDUXRaZlU0UXA0UVMx?=
 =?utf-8?B?UlVibnhjUzNDaUc2eVJyM3dFTGZxL3J4Vi9MZk5EcHFqN0tSQjhaUnQ0TEJJ?=
 =?utf-8?B?aWpoc3kvOHM0TXJtUDF3L3Z4bHpZVGN0K1VLS2llZVNLdHBocFNkMU1wOTVj?=
 =?utf-8?B?MUpZUG40VnZKektGK2lxVFZSSGI3ZXRlK0I2c3JiSlRNTmx6N1hYcUJFLytH?=
 =?utf-8?B?aHFrclkvVWlTMlY5UjJzMTk2MTRUMUZ6MkZHS2tpZXgwZ3BlTW5UcXY3blZ6?=
 =?utf-8?B?YXpCYkFzcTM4KytUTEJjMkpsbU5HTkluKzd1OHFPbWFZVWQwSDROL3RPN25D?=
 =?utf-8?B?bTVueXBVNmZMY3Q2OWdyV21WdzREYlFPb3VDa0dCdTFzUDhSRlhhcVF5S3d0?=
 =?utf-8?B?RHdEUGQzOTh6M3UzL2g4WGl6V2Zvbk1KbDFmMEMxY3daTjBhOWYwNkNvOXF4?=
 =?utf-8?B?WElHZTArUG1saTFYUzlycXJaN3dYU1NvKzg1OVFNNm9MUEJ1OXdPVFh0VHNN?=
 =?utf-8?B?RHZuNzE2czI0ZCtPMFVrOXJpOWxMOFVSRlBmdlNaU3B1Y1JPeFUzczEyaFMv?=
 =?utf-8?B?UFpiQVA3YjlHNWU4SjJkMmovOUpRNkwwSEd2YThVYWh6eW5tdVAzMElYc2JH?=
 =?utf-8?B?em1LeW10UTFZTjc2bmJ0TVJEMFJURlJzR21iVmZqZkd6MXROZUp3ejNnV0hM?=
 =?utf-8?B?ZzVWQkF6L21aNmRBMXM4UG5kWU50eExCUEpmcEE5aEE1Q0FadDFMVW00eEtQ?=
 =?utf-8?B?Z1c5UnRodlAxa01kTnVVRUE5ZnVLeFJPN1Z3VU1Cd3FIVWJaWEZIUHo3Wkhu?=
 =?utf-8?B?U20xUnFqSWtZMk9TaHhtN2xmYXQ5cUgyd2NhRklXYXNYa1pMeU1nUGtQWjZL?=
 =?utf-8?B?WFFxOGo2T1U5WUo3bk9WakorZmxNWTd1L2twQjBkelNQR0FOZU5YcGcvam1W?=
 =?utf-8?B?SDNaeHdNTWl4Q3I0SE9keGsvMjNFSTVXcWVSUXoyYlNBK1UzNG9zTDA0QXVn?=
 =?utf-8?B?dGcwQ1NUMHVVQ3pOYm5BMTAzNjB5bldNemN0YWpnMVRWYWR0UGJMMnVjYkJ2?=
 =?utf-8?B?UFpraXZwbFJFL21lTThiU0FLVnlVdFBhN1dMZ2JKR292Yk10ZEpaN3NmcnEx?=
 =?utf-8?B?NnZCMk5QWTRGQkI2c0FGZ3J0TzFONjVETWRDT2hiVDVWS3RRRm5hRzZVZUNH?=
 =?utf-8?B?Zm5lakN6dXZUM2hFZDNmTFlaNFdaQWFxUFdoSFQ5dkx1RGxQVmF0Q0hJbS9t?=
 =?utf-8?B?VDR6N2RtbFplNVYxM09kK21vVUZaWHZIQkQ1bmtLbDJiUUlCZ3ZudWsvNkts?=
 =?utf-8?B?RUFOdTRDUjBKSEgvcDBHSFdIckFhbHBYNDdYUUFGcWRsL215R1NORXBvS014?=
 =?utf-8?B?TGRjaGNwTkZvVXEwUy85OEh5NHpVK1ZmMXVYVHVsRUFiUTlnQlBLN3pKNm50?=
 =?utf-8?Q?nhthaQOOg2jpHi0V+F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c639dffc-b222-41d3-295b-08df13297e2a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:01:44.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nokGq++CHKQo1FHeDfeAoXWAQTl8skvMPM64Vjk+ZgPyiB5OTc0UHfIeWkSAs3PB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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



On 9/14/26 22:39, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:
> 
>> There are 5 domains which no longer exist. Remove all email addresses that
>> reference them. Where such an address was the board's only maintainer, mark
>> the board as Orphan.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> This was the way how to find if domain doesn't exist.
>>
>> git ls-files '*MAINTAINERS' 'MAINTAINERS' \
>>    | xargs grep -hoE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' \
>>    | sed 's/.*@//' | tr 'A-Z' 'a-z' | sort -u \
>>    | while IFS= read -r dom; do
>>        if [ -z "$(dig +short MX "$dom")" ] && [ -z "$(dig +short A "$dom")" ]; then
>>          echo "$dom"
>>        fi
>>      done
> 
> With Angelo's email being fixed, can you please v2 this patch? Thanks.
> 

Done. I found that rosinson.com is not working too. Added to v2.

Thanks,
Michal


