Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB63606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oz45jXVR;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Z/nEhCzU;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Z/nEhCzU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 147CC80FA6;
	Wed, 28 Oct 2026 16:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qp9dCZeEyNt7; Wed, 28 Oct 2026 16:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40F0380F76
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793204644;
	b=a6CGJ0kogY+oQSafhLgj1ByjEAADgh57hp1M6F5D3ARVjWRpALo40X1t60IUvbYpB7yX
	 0HTot7LfVz7BgmG2zqxcEin2rQFyKEjxNaH3Kuox3GFQ+hKHRjPPAO9t8CHpEzSk+S5Hj
	 d9vwl8UDO5g3kf1kYglC9petgWq4z522Wxv3BawEtejqJRKhiHyPOf+jytmOto0PvJC1b
	 JIuNIowAeOvMQt8vorWDH87wvnF/eEHuXA9IBiI44nIMrzf9cvzHn2xGwhsmGx48p9WF1
	 e5hU+qcylHKW/fXDMcqHDfxvEP7kzh755HEUXLQwSw5yU3hsqCZfFywM98uij8PlG8w==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793204644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
	b=nAqe46TM069HNNwlpek0a59bqsfGcXQDJCw9Sw200TVR8eTbiJSvqcNil3ESVU/hSPRY
	 kcS91fot5wD1OwcdhHXNK6Fg4oP5A0BqctqGogRMVjChN48lv7wAyXmJ6j1H25rF3MBFn
	 aG/k8sQp4AMRrlwlvqyJFxgchnGR6ROoZ1MSfLGAEHJ10PQoeN1x/Lj2WTP4Dg2V7uiQW
	 jgiQPnkQ25tiVPSMUw+IPM+o6UPdAgipdvHEy1wcmp6KCpKFI4BstvEYZussIwxq21sjy
	 VEyYJwdNjWBv8MmvMe7aUAR3YoLHs0yQfn4nz35KisXDvh4gOA1C7365G/racFffJTA==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793204644;
	bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oz45jXVRasc0AWmElcc9V+yGsK6qCPZa1rN6LcZ30Ulr+hNhT7wstVOP6oZHJ3ugm
	 wnOSDU+4j20H6pN9y4YnH9zRYuR63OyUxM54TTdSkKQYD4IP631aEDDNDgVN+bp9SD
	 rHXTh/n8mV413o0tPL0YzLyKdix4/VIspW21ktvUJkX6nB1lyBf2mOeXPlWdcvkYq8
	 3QBImoVcQxy0PYUmdf/HHdNXL9flTdmyzVZAHe3KPe88WOR3jI4IkZuUAOvVYxWlYb
	 itGb/UtYlXFQwjQ1C30ZrW6OgDPtDhKxkFRQFlVcJAuj70J3r0In1IJnv1o39Ww4WT
	 q3/bTdaCDtFbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40F0380F76;
	Wed, 28 Oct 2026 16:24:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A70C4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10843400AD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbxedZ5ZIHZy for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:24:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D286240071
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793204641;
 b=epN1/KzrKGxqCU6QZ8a/9z4MhEVpv2qyI3klm3q1KcsjpsPPQNz83kWGEN5ge7c2quqz
 aGlWgWdJyTOQSnZL4IhCct8dbrkbEKTYikQyfSatytGR1JPmV7Qax5duY5iN4mGo+JYRn
 DpncmeSY3+ZGvbPRTpXe8VNFmX3oaDkq+FCaWxKYZJJYEPjCpsSxv8Ur8W2jk/kyRSx2f
 Sh5a/Llu2/eSxLUWkFqh2f6OLnys7zUxnCY9pvMDcNdImDDULlw3bvjoq19tExJd0sikF
 t+opaPQ17f8tQ9RbXonCQWqPWWJaU4+UiW8ebgNEW9e5YcXAYHmJTf9fmdI7NbM2j1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793204641;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
 b=JN1rEo2L5mErd9FFgLqLSMmOSKB6XPOuiZjm6WpDLls0k53NwZInzQ0Hc87BLvD5gxJG
 t0IeXnmYrovQuQDhshWtnrMEAo+pX9ylD9uJbh52i6VjmxKbdw+wiEx/gXEHLqL/ZQQ21
 rUxcfT/k84I8hqL85yDJd1B++EWbl1CEzYs0jKuenyYtwzP47jn2SBLcBvTcOsUro/d8j
 7x4JshsamW3mZtogxWsZcmoJI0roJE7VcHKPMziiz7DcNwdsvwGAO6QvItRQ4lT7kg1zX
 zGe9vqII/LiWczeSrjIERTW55ch0PYkFE7vMBfqP6YMAqI9OmYWV4yEH1fG0H41iJmA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="Z/nEhCzU"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="Z/nEhCzU"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Z/nEhCzU; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Z/nEhCzU
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D286240071
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:24:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oETYBefbpN/j+RAGXv+ol8TJu151mOE827RhsA9nJtsELFEAqG4kKBzZuUdZPqeG6w89BOwkZjdgdL7mGX8zn2jgt1OLku9S1jRZ/SfLzY2vHpdBG2PGIFOiyEMYReJ4WPYVeyJCLeGapWNX+IdgbN/SgfFj72uS3wm23TgoiIiV+IcTK/8niEj/S0DSjodSxX4VyZbd6IZlCTgbGuY9NiQgK/s+Bmx3mcafSdBJBlZ18JioH6y7zFxhFHmFGwrbqYYdGoQ42N5OpITc4+YUDy34GZj3N140scl+lE5yRJwuGQS3Ah6z2XsAhURI4ds1RD2E+u4fCXFM24MyMzBryQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
 b=hAhHsGvaYydZvsneKbhMjyQxvyc/9pxBcXCGf7CGWUsPloCzcjgxkOy4ozlZV8+yIk+g1/moT4OVdzcOnBD/HN/fabOm7jblt6vGueKSjfAfU525hMHdhJMFGfl92o174c93ovLwID3FyTephPQkzocT+DuBnr1DmkF+LKBBUT5mf+HuwA3Ibm37a8PpelXZmH86A+ghdUyZ98ITgdH1WlURH/iY+b0NfQQHyLcm/Gn1sNE/arT6Ou5Rkx3fsSVTnhDLPb+xzZ61D5IrrSdJ7c3m94sTAvp20gN9lg/TZYFHjZ/m0GPDjm5X1zIE54Iuk6BH81Mjp9Zrgx+vbfmHog==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
 b=Z/nEhCzUWhNNA2kYcGd/dxdE5NlwkpWO9whMzugGqug87Oavr+s+6KBPakwAUGrRhdw1RwOXW2xN/XxpCuqIf9Z4kqgzkewhzh9uhEelzLH0Q8SJvs3kth3QoRKereD/ZM0LhR7yzQklbJHf2/cw1wsj87CMM3wYxprROACYTCs=
Received: from MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::25) by
 DB9PR08MB11363.eurprd08.prod.outlook.com (2603:10a6:10:60f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:23:53 +0000
Received: from CPH1EPF0000051F.eurprd04.prod.outlook.com
 (2603:10a6:190:8:cafe::9) by MM0P280CA0071.outlook.office365.com
 (2603:10a6:190:8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 16:23:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051F.mail.protection.outlook.com (10.167.241.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 16:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vslevFoKyekViRPubKQNtf8qFa2kL813EeDDo4o5J45iHswwg5kG1Na21kyDmJ1V7ZNTgRPvnHjet6O68fTguJKczuPToPb/q7X7LPpae+JdHKwjYTsWf8i0FaWJWprbYAToAaKQxNF1tvySdSJLWooak7TquAMNO47St4gy/pBezfGY5xHcQUDsfx/YEk+s7WcRICOjXFJs04WBjLbKi6Nk+oxBs4bFp9IBzcWE3KUA7ZdI0l63DVm0q3GaL9xq+pzMv2Q9dbbSGohVBkDlHwHn6fzxACJiVxIoWrCAbHGA2ligSMMseZIfy4FIHTIFf5eO9M5N/Hcy8qH5JPdFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
 b=iPnOhZoyD6uRGSsh/9RLOOZp5CF60On+uImUaQDKVl9SdXni5HO2Pqn4ivE/nVVCdZprbIgsHZVx57PRO8yUxMoQy7u5U60a36Ys0ca9qSIZ6BeFzqZkjUeA2cwxGYnxT6C6unoTLcoP72v4QDrz/d0QL/v0/Q1rZYbsmx06vnqyt4Zs/0VTEv41kUuAF6Fjm77sSTdyqw+NgVnzb4SmhtMsXThzaYqWRr3sYJ5d/2jmWSlmJVeyO5oZJOD7yWeYYr6uNFtC65ZWpSAWwO+2Mn6xSOrLvHcYK1czvPS1DJuGrzdukdlKQs76IPRornmYgzxI+pL9j34VwBkVo6fWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MnRV5SV6EWalPzhZz9j0U87T9SrvZWvqZJur/nBUWU=;
 b=Z/nEhCzUWhNNA2kYcGd/dxdE5NlwkpWO9whMzugGqug87Oavr+s+6KBPakwAUGrRhdw1RwOXW2xN/XxpCuqIf9Z4kqgzkewhzh9uhEelzLH0Q8SJvs3kth3QoRKereD/ZM0LhR7yzQklbJHf2/cw1wsj87CMM3wYxprROACYTCs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8671.eurprd08.prod.outlook.com
 (2603:10a6:20b:55e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 16:23:19 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 16:23:19 +0000
Message-ID: <1a8f4816-bae8-4fce-9189-4668f781ca58@arm.com>
Date: Wed, 28 Oct 2026 17:23:17 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH v2] x86: Handle unordered runtime relocations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8671:EE_|CPH1EPF0000051F:EE_|DB9PR08MB11363:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ee064a-5061-4b17-785c-08df350fdb81
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261022115727099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|10067099003|261021123027099003|261021121427099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: CRRlj7rV9MXfEuco4RTYBvzyLG0mxOdTiX8uBgXIarrKet/rxDwP3hHUS5CAKYpQBDtGqPQ2cyHWXZ3ukEZCtxYhOrcn1hZQ2SHNqXMfNxW7ZD6IEn3Aa+U9v7/yb5Uysj6aOTBhE0YLrHTBz842tSUdhFyulEoKxYf9/bWvlDNbcEkunjSxAG94GjctFfmZ/tqmVThH6/Ng15ZsE+rQFrf5ygYlJ44KibdaMWZbI/izFnXYghcTRQxyXTmy/XAeIh+zlPVAoFswnVy7SNgAGo0cvnpHUGlaFG7U27qeyxqyqGa4PUaybj5rEWUhmlHi2YnZXI7xp9zBiSNgKfh1fxI0vo8GxUN14lf+qN/4PleTPlTHE/2A9Kt+xtfwlNG68ZXCMiMVKyHXOKl8bCxYwGc5IV0BHevKG3HXVny/MPZauHIVzBVWFxYWt7Uq9C7d5oUadoyD38+NTCCZJruGeivgbO4rZ0AYk2Tpwj6hotOS2B0/hhDxUahoPrdJH8BdF+MzfwtdHLbF0rTunKxt5l9sez/veqKXFua9JZeJwl7oQnJtv1qvdWyZumFc5dA8D4gPGPs+69xT5KW3MN9JfKf+A0jllRAVzZGYsg7odUcEx+6kGc3LNthU9uBcrrHgw3XqMy3wXNsFPOnkXM4PFYrL60G9IDQVWEdT22ZZPQ0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lhsHAd8lgJps1uZF0ad02gWhohJ86iPs4QnJc3lfIoTKYF6870d7WblyehHuLct2nJw99OM44lpU/jZWQZcX1iSaaRTmSGwrussn7bafV4deBTCnboZnOEgs+t3xbRroP/xjlDY9LPoKrh6CiMc6ylXQk/OuObMuJT1RVnnTL+8fUW8uv7Y8H/rmxzTAoEkKltJHXTmGKqVGPUrF1M5uROwotOGjeEV9B0YDihCWnSujYFH+UO2QBz9uNC+FhpKu5lqvfFfVj1hG/Mb/D/5/KWKL0S7SxNPyO7deMInRxbAnbnZXuoyVI8L0EYwBeyfK7ucE1IILVX4Cc5ixgQ0XAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8671
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2af816a0-d2ae-4178-c171-08df350fc70b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|82310400026|23010399003|1800799024|14060799003|18002099003|6133799003|261028144727099003|261026140227099003|261022105027099003|56012099006|11063799006|261021123027099003|261009223027099003|261022115727099003|261026121527099003|10067099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: kdCYySzVz1it9KbhVPaeHtLYV9/6Odt5mnfWeDxLhrMZ4xvl8kMrzB87z3R6nFhOP2nACwdpADhuNGT4H2UCh9iRShOyTiYUSY8jlwfk0XNxl/yFVJSh9akWgRRhYmNbWpipeDAcck5E/5ioIzDUUjM7M1t0WEKt9IpXLWDFXBsXZRfUK35WYuhQEus08KcE2Rf1g2vzpg0R+frAxfFWbn2bVH+o9tyyz2JcgDbvnX3315tHcACnkeSRG2tmT6iw8vJ8lx47NHzmkuscEOacoIv93UOyfXn1nECSBO46DRQi4tR7AifFOdM/Km/rzfOWmgJAR/mh6iDBU14ppmKtdZQpqrT/Td/XKMnVSKaCaiYMu4sYprPreB336B7R2U7F9BBSjnpbhbPiRuEazVDPq86mMe+mu5QDrLg/zXUjeuuBE4r5SulqR0jPhvsBzOyXqkqN9VMNZfro1fQEGWt2u2KNHQMLTSEL+mBwmujnO3Z3AV6FTEnHnSgLTxZZ1jGSqlBY1fpDIjESIhQiKA7FH6TZ1Evnbm3x25TWA8atiwQvQk+vOMqCtk5qDPg+ycqz7D9kk1yqw3cllTL6xgg0pVgfWb5RE2NhDtHg9YE+Zz5uCdk3eLh4c9s6838zfmK5Zib2nBftC0KPoJx/w/0ri4+tBi3Pr47+uuzGBmPYBfVET8g+VR/Zlcl7Ou1ckhFZnb/RDkqPPulug2N47dKV4w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(14060799003)(18002099003)(6133799003)(261028144727099003)(261026140227099003)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261022115727099003)(261026121527099003)(10067099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B23EZmLNKOy1Xnhcaop52bHdTbmEc6KSSptliKQ27LHnefhtVse7Ar+d0l0wTFDhQNLgDOijmhSWukZD/dWRJ9V4cEsH1WS+JBAxjWzlD0gqbDkBOw90MkbF2WBeon7Rplial+LEvQ1A22yKppkLm7L/ZsPBZHsYY0FxXRJm4hRigAlgpEPLY3K1JpZ+mWPxHHSFwohB2m8dJTyHUGB5zg3M0k1jxKv+xiTj452VyVoD1hS44wsMRn0Srf9hJRtE7Tiu0zGI2I3FKUuTtoaQ/jPiUSWD5IgicOKCBgggZRkoigebUTMKRHBAnBvX351R2hFXRKpgzaKBLPt48i7cpbLazGiohI7ataZOk+JOpHFDQBEpByuadWxopgoc15R+2GRqn89yxTauVKRO7h/nkSPOijs4rIGVv0vPHbaXxh2un6QbmQwbPbku+SwAHBJz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:23:53.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ee064a-5061-4b17-785c-08df350fdb81
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11363
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Runtime relocation entries are not guaranteed to be sorted by target
address. This was observed with GNU ld 2.42 when linking qemu-x86 using
--emit-relocs and -pie: after an unrelated image-layout change, .rel.dyn
contained 450 address decreases. The old code skipped relocation of
mem_malloc_brk in sbrk(), causing allocation to fail and log_init() to
abort boot.

The ordering check was added as a cheap corruption guard because .bss
overlays __rel_dyn_start and may overwrite relocation entries before
relocation. Replace it with lower and upper image-bound checks. Together
with the existing type and target checks, these reject most corrupted
entries without requiring sorted input. A corrupted entry whose location
and target both happen to be in range may still be applied; the ordering
check likewise could not reject corruption that preserved increasing
addresses.

Apply the same correction to the 32-bit and 64-bit paths.

Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
---
 arch/x86/lib/relocate.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
index 9ce56062d2..461f6f8a52 100644
--- a/arch/x86/lib/relocate.c
+++ b/arch/x86/lib/relocate.c
@@ -52,7 +52,7 @@ int clear_bss(void)
 static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 				  Elf64_Rela *re_src, Elf64_Rela *re_end)
 {
-	Elf64_Addr *offset_ptr_rom, *last_offset = NULL;
+	Elf64_Addr *offset_ptr_rom;
 	Elf64_Addr *offset_ptr_ram;
 
 	do {
@@ -70,7 +70,7 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 
 		/* Check that the location of the relocation is in .text */
 		if (offset_ptr_rom >= (Elf64_Addr *)(uintptr_t)text_base &&
-		    offset_ptr_rom > last_offset) {
+		    offset_ptr_rom < (Elf64_Addr *)(text_base + size)) {
 			/* Switch to the in-RAM version */
 			offset_ptr_ram = (Elf64_Addr *)((ulong)offset_ptr_rom +
 							gd->reloc_off);
@@ -87,11 +87,9 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 				      (ulong)*offset_ptr_ram, text_base + size);
 			}
 		} else {
-			debug("   %p: %lx: rom reloc %lx, last %p\n", re_src,
-			      (ulong)re_src->r_info, (ulong)re_src->r_offset,
-			      last_offset);
+			debug("   %p: %lx: rom reloc %lx outside image\n", re_src,
+			      (ulong)re_src->r_info, (ulong)re_src->r_offset);
 		}
-		last_offset = offset_ptr_rom;
 
 	} while (++re_src < re_end);
 }
@@ -99,7 +97,7 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 				  Elf32_Rel *re_src, Elf32_Rel *re_end)
 {
-	Elf32_Addr *offset_ptr_rom, *last_offset = NULL;
+	Elf32_Addr *offset_ptr_rom;
 	Elf32_Addr *offset_ptr_ram;
 
 	do {
@@ -117,7 +115,7 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 
 		/* Check that the location of the relocation is in .text */
 		if (offset_ptr_rom >= (Elf32_Addr *)(uintptr_t)text_base &&
-		    offset_ptr_rom > last_offset) {
+		    offset_ptr_rom < (Elf32_Addr *)(text_base + size)) {
 
 			/* Switch to the in-RAM version */
 			offset_ptr_ram = (Elf32_Addr *)((ulong)offset_ptr_rom +
@@ -133,18 +131,18 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 				      *offset_ptr_ram, text_base + size);
 			}
 		} else {
-			debug("   %p: rom reloc %x, last %p\n", re_src,
-			       re_src->r_offset, last_offset);
+			debug("   %p: rom reloc %x outside image\n", re_src,
+			      re_src->r_offset);
 		}
-		last_offset = offset_ptr_rom;
 
 	} while (++re_src < re_end);
 }
 #endif
 
 /*
- * This function has more error checking than you might expect. Please see
- * this commit message for more information:
+ * The relocation table can be corrupted by .bss writes before relocation.
+ * Validate types, locations and targets to reject most corrupted entries.
+ * Please see this commit message for more information:
  *    62f7970a x86: Add error checking to x86 relocation code
  */
 int do_elf_reloc_fixups(void)
