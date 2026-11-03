Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E601606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GTqcHT0J;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zzhftZaK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12FB080D84;
	Tue,  3 Nov 2026 06:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pL8fTVLVflrp; Tue,  3 Nov 2026 06:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 602FE80DB0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793688975;
	b=H3q9ZHbAZopkj9IRAR5KEyN1TYvUdJopYHLpbHMIMqrxXikyBHHf3l6g3Qar2GxjIJMI
	 z76AlrMMtV7T3T0mApvKhDvBBZhF1W80BEa9KF/ERkqRD4iFEYMMK7JDqgK9AXsun0Dxh
	 iw++MOA9iiNSjXXJu4PsFDoo/KvH4/Hal6SR2RT5kg8Ic9mzfRg08WVm6ISqAX1BfOwqm
	 QgWUNlyRsFUwLhc6UsKjFECuMv0YapIviYa06A2jLx8xruxTnkdUJhRjWSdsLypfTWqEN
	 CSmQ7k/07o0mwTZ0Z+0kzYN+7dOisr99PBVSw/GDYiyg3i+4wT2JWF5mSOuRwTk172Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793688975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
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
	bh=p1OFxhXo/gj9zKf/knrCTsuhX4oAZ0G7ZD6mq1SCNss=;
	b=dGVNBIKddSBgBLAUpbCMlzRh9CIveJfsACfvYDiMdjvmhAyxWlxfV+EfGtxVAdkCDUuo
	 S0U8MQGcTXYMk38JKuEqfXaIT0Ba4C+FLNtYORiNcvZyOV7UC0CPbjA3Zg0AMCJOz2DrD
	 KBF96fnsNIGfJ1507fis33Sg9r/ljlSGZzBrVsxhNs4rbfMWTwMzqWm46RA60LDlKUJ34
	 pbd4LjqIP4jxmHhUAEkOq0Y5/mUZ0u6iBf665d5tXRO4GnAri8uXCX9vzNNMAiUPh4zIu
	 rsHNZQX2HLhVU24qrMq2G/9GkUqUGLttqlaPxjZopTeqTo5u1ZRBx5/QYcnp8NHFSXA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793688975;
	bh=p1OFxhXo/gj9zKf/knrCTsuhX4oAZ0G7ZD6mq1SCNss=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GTqcHT0JtAPxJWeP1c2E/wLewNCNZ4v1ai5IGotfDCvPCZJBB8z0QHg3Ao+MB1gNI
	 EZYM08kSwr5WoBeAXUBYN6EPstEzHsUJIYcpfxkR9P6UBx8FC/cn6B7ROSVWLqr6e2
	 6k5R/vhkflTur9NJ97SrawlDjxinUrkKXk4XfOZr3F+5u9/0iwJV3ANnBCodd+tuz8
	 gIGeA/IUBahUiiXwLyg++mJhOtRklMF+JJcBJUNiZ/FUSmFyl9ERerAzTC4/LRrofx
	 bqjLz10e9TM2t0X0iAWjH4VqeJSac7dI4FQQKXtSxFqYCKMC3v46VEUEtQr4DMNcl1
	 aE1nQ/zQLClBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 602FE80DB0;
	Tue,  3 Nov 2026 06:56:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80E274BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6399340589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lw_EBdknd-FD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C35C1404A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793688972;
 b=ECTzT9yoPkdeuBYADxDtEqia5fPp/rgiO7bfS69xVp5p6me/kTKYMnaC8bJf7JxE6E3L
 xwBIJFG4Ay5Iyt32tjlumTg6BnNyappcXFWKH/GeVH4VoIRqhVJGtvxEX/nN1I33Ax23m
 SEqvqVM5KFI7STwAYXIgtTXo//9yT0oAmMRVyVwkExLp+2GEUoweCp/KyRvF/+MXW6HBK
 OZe25jXs+/h8FYMpS3FDSp3+/boIFJfS/7Ihi3WjuYPVfnPmo2ZVIhv8Mme6gd3ARPNsE
 fZUIwHZs5wG1nu7RF1l5i1jdAGbIZ6+1OrPJw11D0vvv7YLzyZi1KN4ElD92WCXhglQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793688972;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
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
 bh=p1OFxhXo/gj9zKf/knrCTsuhX4oAZ0G7ZD6mq1SCNss=;
 b=Na0J7lMCKEM9NRAPZqv1qR1z1la7t/LHmycBXY5/kbpwEEiCPB5hCf4W615CpxMR59nX
 NuBIliBfntLtgQ2TDvBWmh51rbZDQdemMm3McF5tK0nlYLp2zH2GVyr7+xxNzc7Q5usQs
 IckASxtKRReJDm7VGOrVrt5hwgkDjEpWyjC1w9+ZSmnVv6Rh3xx6E0uNZdzvSnqnHk3uo
 H9Qs81+PcoLeD+bdhhPHnd8Cvksflm6WAp5LnF2cOgIMY4Ea9oZgKWmNoQ3lRew1cJtZT
 4T5N8SFd8Q6ePZUX58QIjay9GR5ZFpdplh5Ni69wtGwshpRi3m2Tpi9cUkXPc+9YVXw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zzhftZaK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zzhftZaK
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C35C1404A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL3OZqzD9naWMquRAthv7TU0SYahOb+wdjMkOkVpKQwmddIwhBH6t3ttRIBN/ZqahRoc+f7YOgplB6IGJyUoEyVZbG52wOZ1FSNTs8A1IAWvNNyDmacw4AaOsV06BBFkrYVSrFUn/c0dcYgr0OZ5AAvaLSVjcHmwNOsYwiv0Mq10cZUX3E900QFaUMVCUNE747neyXW9jnuqLFiyl6FxEUh3UCzeFGnDHv6kYxtcx+MtJfqP9USqTAHmzgSps5De4yHmtKTdSsJ91sAloDkP4m0Tvk6mn3dhXpr8yd4yxJGXMSbwkMkh04JMOONDU+Vgk3gH/47DrM1+zPPvTIgY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1OFxhXo/gj9zKf/knrCTsuhX4oAZ0G7ZD6mq1SCNss=;
 b=lyN4KI3bcH/zKA9CtUz++RybtxUT1x+/0cUXK6scTTWb4I9GL1aPEJ+2xL6GkiE8kwOmr0tHADYxEDU1Tq/vMza95ziQB7LDnU5ogA1cCF/muBve5C0FocYe+hcha9qG0zUmWsz5eF4S8KiL6N8nKWUImYFls6+FcXrGvI+6RENLiDbOXlEaQeoy3WQRPTA5yXwUuZmdG1OJA8lwsmyukLIe6X0R4S0bJbHfxashNDQvSVx1msMCr7eE3N3OPqr1V4uDOxfzpfztwIzp2euR5SJQ6VYNQvZ7Qy29M7eF5vN01SZvJihA9kzNAe0WdunKrTchSQ7eG7eZYAYHwNp8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1OFxhXo/gj9zKf/knrCTsuhX4oAZ0G7ZD6mq1SCNss=;
 b=zzhftZaKJpwij/ucuOPG/UbKUKG7Wd5eOJCAtXuH4+LlsFrJAizAhN3eLl2XgZpPXpTlyCgI3EJ12PCASo1Z2gmYNCr03VScw6Th2XGDyB1vFeW9Mb0KZlyij5LEGvQib+35zfJ8/cBdLNZR8H4NLx+Ppb+E+jRbfDEvpFBvpHI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:56:04 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:56:03 +0000
Message-ID: <12352ecf-215e-468f-966c-340ba6bdf5df@amd.com>
Date: Tue, 3 Nov 2026 07:55:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] xilinx: fru: harden FRU parsing against malformed data
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Akshay Belsare <akshay.belsare@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1792503883.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <cover.1792503883.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 47549b79-2c81-4fd5-0800-08df397786bf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|260925021911599003|260925022911599003|260925021311599003|11063799006|261009223027099003|261021123027099003|56012099006|261021121427099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uB6+XW/7zfn5APZTqQBGIQ6dRsa+oHLLZ9dJhrtQcIMN6lSSx0OHCZ+i1St4BSXilbk9PpGLxDpfmeRKyvHrDfGQPImYgsbx7O5hH/oGzaHr0fJsQtemzcgQM5vzuI8wKxP7sv6E9qSskNYGzdNz4+wr1im3k/VhJxWLVBdAV+RmuH9JRXsZjJ0mVlsgXNcqLI8V7fWJshStabZg/F04S5bYH/5ehJnatjg3/639kndpO5O4jNdQoGFqNmDP+5LjFFUphipf9XwU0nrK7ozHM9x0DwdRbxJ++z3CkpKPnUbovLpzD3e/NNUshB+xV5yS2VXvzbJ951TqKznYhwJedv1M0VxfITFLHbNUJU2jGZH5D8eImJUs/BdAkI6plqenFgycoDZF5USsl2azXMccws8bh9mj5KaCiP5cC1ZUpnEazDpfCZIh4aCdYK3U+TWsNVJg7Pm+XGEOBL5S5idsEWUiOtLvD5y4pgng+iqv0nLIuV+ETAJ+3/Qev+eFkR9FYK51wBvbsFeg6Yn+d6dDjuBG+PiqR4TkPXw4hcTrPczd9mDfDiiIocGWR0o1MkMPrmRHdK2pYOfTn56sKobFckNhKM8vKZoNLwbxQN2CenpgI/R92Gtn6a6u7OxWAK0zqaHgWa65IwzgYrVUoiJt7kzb4KiTtf7B4BOYCz1B2Vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cis3MFZzb0RWQ1BRV3Nrekp2UyswcDFQU0x0VnVOSFF5ckhLS3dWYXVCcG9N?=
 =?utf-8?B?WURQMjBkS3k1SmwvaFNnQUhUVUtoazBFWVpnM0I0UmhXQXpOVVBRQld0OTRs?=
 =?utf-8?B?OWhxWkxLcklvdTRyZS8xVTdVQVcwaFliZHc1UnlURlhvbVhkdFV0cUg1SzQr?=
 =?utf-8?B?YnZVYXNPSGxKRkpERno0NnpjdmJLYWE5ZkQxTWR2WnVMOHZEZlFFWUE5eVZT?=
 =?utf-8?B?YXBBcnVqWnc2YWNXS2ZZSjJYMGNQKzQva2ZWeGpGTms0eXBtQVdQNzl0WEtp?=
 =?utf-8?B?SDN6dWpJcWNHK1cvbUZTOGF5R1RIaC9xSGFFUWhaMFR4S0lVUENhd21pTTlI?=
 =?utf-8?B?V3J3YnpadGNrT1hSVXJwaTZ6THpoODNTK1BlYzJBbUFZN2NzSzdFb3hGbmRr?=
 =?utf-8?B?ckx0TEgwZDhnUFYxelcrRGdodzRxTEpMYlBwYTBCYlNaQUpTY2lPTlU3OTcx?=
 =?utf-8?B?ZGxOMFk0V1NoRUF4RGRHNU1PMUNYNVo1RklaZjJ3T01oUFlacFdyL0p2SnhJ?=
 =?utf-8?B?WlNFVW5HTmY1cmkrc1drUU1pSmpKVUpld0RRU1VIeXVWTi9JU2YzZzJ1VkdX?=
 =?utf-8?B?bXNJbEdUVy9zZ3k5K3p0Y0VMNHZMU043MklXcS8vdlp4UEVKVjh2cGpuRk54?=
 =?utf-8?B?MkdseVVyWFRUY0hlVC9BT0huVi83blNEcThwTGpsSEhNSkhNbnN3T0dxRkww?=
 =?utf-8?B?Z3pzMzRERUpmaXQ5aGFvRFFCNzF3Qk1KdElUNkVwcTZybk41NnBHNzJwTi9t?=
 =?utf-8?B?TEM5NHNPRUpFcUVpVzdTZUdNcXk5eFpJeTgvaTVvMVAvZkU2V0Y5UFJkZ2xn?=
 =?utf-8?B?bkZWczhJOHpnVUpzSFlGYzdSRkYvQmlHQktlcU4vSDl0Z1JWNi9DcnJkdng2?=
 =?utf-8?B?YjBPTWl4YnhRMWp5Zkw0OHhVWDhVVlVVTk1iS2NMUVJUaGJZTDJvL3YzbW5M?=
 =?utf-8?B?bGU1MGMwUEZHVzBJYjJSM2I3K1E2ZXIvSFBxMkFtbTUvcDZzRmVPOXVFYWwz?=
 =?utf-8?B?VTAwdTloTXRYSkFsdjFmUTNkcU1pNUhORVdnSXZkS0FzZHBNTENLanJ4RTVq?=
 =?utf-8?B?OXQ0dVAwVjYxZVZaaUFmN28xUy92UHNDRTNFaUs2RjNGNE9KV1pXeVdQOU1G?=
 =?utf-8?B?Y2J6ZUFTWE84TkIzT2VMYUVQRmVLL2gxclliWnNFSk5ZbWdjZEpjT3hCVnE4?=
 =?utf-8?B?TFZIRmZuNEw0bkN1US9xcVJtdDRVMFloUGlIL2FYVTl5bFNYRmZvTFoyc09n?=
 =?utf-8?B?dFlpaHIvMkd2MzFmajd1MUhTekIvekpjQVpDZVpaR2hGN3FNR3VyVlQ3Sm5v?=
 =?utf-8?B?MThwR2hlZGwzdHg2R3I1TmVoc3JOODlVMllrTm9UUy82V0FrWDVqWmZza0FJ?=
 =?utf-8?B?dm5BRlFlZmEwZmFUMmNOWGY4WmRPWVZGTWh4OXR2aUVuZXUzWVR2c1E2RGlJ?=
 =?utf-8?B?akkvTnJuRHhWQ3FWZlJ6cTg1R0M4RkhLZHFVWDlzSG9JU1hOODNyeHcwVi80?=
 =?utf-8?B?eE1lOE0zc1RwUmdWaU9idWNIWHJLY3ZlemVQK1l0VkhnVEdQSzRyTUpRazJI?=
 =?utf-8?B?eFVJWnEwV2gweGJUZGRWMUdFaGk2SXFxdXNOOUkvOHA3ZWlmREJiSjhvZU1w?=
 =?utf-8?B?VlY3c3crNDZ4Y0RjRmVOUDZyVFVyVEtYeitzdnFTOStyUjdSZkRtUG54OTZC?=
 =?utf-8?B?cVlvaGNEZGRTeVY2SHJFVUoyMUxPb0RMcnQ0WkhjMEtKbGhXTjNGNEJWTFI4?=
 =?utf-8?B?ZXhqYVY1SGhCbGkyaS8rKzJaekpZQmNVT1dHWUh6bEwwc1d4cytNRjV6L1FN?=
 =?utf-8?B?UjE1cnJ4Q1pvOTBzMVkxMU9GbnE3aUVFdDZRNG1rdVZuYjFXMVJmVVVDbGlq?=
 =?utf-8?B?S3Z0aDBLUzRZbnpBYWIzQ1hKWkZteTNnSXdUOXV3UlVDUDY1cjZnVC9yV3lv?=
 =?utf-8?B?ZkdyK3pVU3RJTnovZjlGbUlKVjJlMVc4akh3THdFTXNsazE0Q2c4STVxM0lZ?=
 =?utf-8?B?ODUxZ3cyZFhWVHdiVitzRDlSRmlwS3FFR3FnQWZRQitVSmI0ZzduTkNRTlV0?=
 =?utf-8?B?WlA4RWtMcTJzNmROdFlGajhTcHhkbE9uMWxCNDVwWjA5dW9aRmhIZWpFOGRq?=
 =?utf-8?B?azJCbFFTTGNrQWoxZWpPSWREOE4veFZLQXpTd1dUK2NFOWxaSGVMZWNVQVFI?=
 =?utf-8?B?dmVDNjlLZEg1dCt5Y0FXZ21nem4yVGRXcWdqMGUyL1NXNzRaUnZLaEVqd09M?=
 =?utf-8?B?RTZSZnFSWVlqUlFHU1k0TGRNbHR2L3l2RDhPQ2o0L09lM21UeHhsMFlxRHRF?=
 =?utf-8?B?OFhvaDMvQlVibzdOWkg0cUdXWS9ON3I2amxCVlRYMTUwUjlhd20xZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47549b79-2c81-4fd5-0800-08df397786bf
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:56:03.5835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz6gv3+bVS+1Rn0GN5wgYzQxwMY3pQ9l5B3rZCmGYKfuBlZNIELqW/fk0PFT0yK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 15:44, Michal Simek wrote:
> Hi,
> 
> this series fixes out-of-bounds reads in FRU parsing when handling
> malformed or corrupted FRU data.
> 
> Thanks,
> Michal
> 
> 
> Pranav Tilak (3):
>    xilinx: fru: Add bounds checks when parsing FRU data
>    xilinx: fru: Fix wrong argv index in do_fru_capture() addr check
>    xilinx: fru: Use sizeof() for board header size
> 
>   board/xilinx/common/board.c   |   7 ++-
>   board/xilinx/common/fru.c     |  14 +++--
>   board/xilinx/common/fru.h     |   5 +-
>   board/xilinx/common/fru_ops.c | 103 +++++++++++++++++++++++++++-------
>   4 files changed, 102 insertions(+), 27 deletions(-)
> 
> ---
> base-commit: c859517f0606595da489b5762844292e28c948fa
> 

Applied.

M
