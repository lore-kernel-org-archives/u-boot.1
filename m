Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48774C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FF4480AE3;
	Tue,  8 Sep 2026 14:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3coGjqrSfiB; Tue,  8 Sep 2026 14:56:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 77455808BD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788879364;
	b=TROvrvHiX9ASKvfbbs2Y5ZQIPFMoDmZaNoMOL/pp1wRThp5erWTV+qZUwXWlkdEBtPqk
	 8CUhI74LaqHZ66Wnv7nIVxDCChKu1G622E+SqfZRbtHA1p5NMqhPPs+8cId+Pf++3lvKT
	 mL4cAbdljiI8nf6yy7Fr3Es+soxvTYboCySC5QQwmSt6FshGSLa+2EHiQn2k4A6Rqtz6J
	 IvspCatsyKwIOD9LzQFu666Rl0pFVbWlmf5G5kwq5/HuygcddLWxO09brz5vzcxat+FOW
	 1FSvCy2ZtfdyAItyRd4irjmbfqXodkQPtIu7RGT8cp4PUP1daxShwk2c9qLLw7OYGHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4mM2tCqnXNW3mxVSd/P+8sJ/kiQOrVJ7k8voxPmJ+Og=;
	b=j6uMLxnoLQ/tfN0RKoMWd1ZtKMeGxrWgwbw6x2eN0aZtIYJiaPGcAMJQFrJAxiBBmWVq
	 /gvXyIaj8okwgVYnNyZ1i/QB6gA0ASCFGwCMiDjrxBaYmRJFcx7SHiTFJwnRAQW66hbNy
	 RQytby6xWe/bRDcFA69H8su2OdVAlNAhGCYow8tgsOqd8WCKblzC/dXEKvO75yg5YbuB3
	 QZVXgiGCret9fc7L86p74zbv8nPa5nsl6pbP89CRkVhGOuDfnLjpkGpHn4Eu/IJgDDsp8
	 4uJMH30Y1EM3sDZBnpENaUPlW1JQ+It730r+zFldxURESdPMTeFuv4Andqzd0ti/32A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879364;
	bh=4mM2tCqnXNW3mxVSd/P+8sJ/kiQOrVJ7k8voxPmJ+Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NewFpxXDCPgMvWUis1nKef9isneW7K8za9PNvmpJlP3qGxDZIzJ/JVjkfhvID2VcK
	 4bQV5k1Vp+/PKAab6uh+TskAzNIgl7uDVtuP5mXOkfDUlTCrAIAiirdD++k6Dg8jNZ
	 T2Mj1irPJ7IsVhWz9Xmf8EkJWJBqmrAowP8+a9m0wE1nQZRyJfC8ow5LsgdbeP+Jlh
	 8g5VQvD9WubGb7MpmVr2uWeQNB7fc5EeVjVyVqsFSc6MMVrYkeE4aUR+f86cOxlHc3
	 wAVfXbxZRbu+agPg9cCffFk53YdMwmpLmoUrBlvWlG+ZihTXABOiLBDXUu0INAKNeq
	 eOrzyUAZ6kR4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77455808BD;
	Tue,  8 Sep 2026 14:56:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE65C49D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 00:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E026560609
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 00:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjwWGIqjKOQ8 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 00:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BB64A605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:d10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788826728;
 b=lo/1Wp3kYPtQpf76x16Bw2RZ47X/VqqaPxipTT/FiiJ54yJIL+bPI2smKkPUPrtlRGG+
 DKHNTailm9h22LBlwUxboXcNDaGgvBbPlPJz7RizycT2UzMBA5x5+SX5KTTkVc/JUSSXo
 6l577MtqJ//3KVtQrVDXq9zekJWqd5b0Ct232zOMUqw3owj/LhABkAcsXhEcLGCu2BNjK
 6z11z4RhGZG8Y/s04fFJtWbp+kGIz7V/YVE2QRxryT8/eO90PlOdZSYYvLZzG/8MKS3Jk
 ZV8gQ53NaUDeZFMzCqW3ZUSjXYOEOHbz1Hlb5kJJnbCN4L9apDyvloGG+wk1OvJsh1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788826728;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=4mM2tCqnXNW3mxVSd/P+8sJ/kiQOrVJ7k8voxPmJ+Og=;
 b=Pa5YTovVRZ23oFNWQCi4su6M6bLERLQEmh8wt/JfGO0Qj8LXlH6D1dU546+LSw7IiS2r
 CpQpC4gx9dW4xUAOOmVcwAkNisi9GVNEpCgPGDh6Yd1X1i5IhXDoQBVf+aXZUDScz285T
 gS7dzwrRAGqfRCMGtxX5WFf6cOoBswuKtlhOWoXPeHdGpfPb/MVUF5kaR3Hl2A7oDLJmu
 clDNJD3HIAsVOOTLV6P+5fgWyGbEyDs8Tf/0LM4IuSCids5t0aJuxOwHcWKhZPSnGhCe2
 bmqj5b/P43k0P07T8SWC+RfTHMKIxU0ne62HHRfuFv8e+ixmSQgpcUjV59xTMpr+ehA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=hotmail.com; 
 dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=TawsLxzF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:d10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d10c::1;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=TawsLxzF
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB64A605DA
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 00:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+4iGCFW3k70xpd2GTlQbtEospwBxDxYk1zjceBRvB+R7SWZMHrRBYW2KbAYecleyq4RfABTVP4o58qDOxMW+EeinM8fHpDmoU98JHtESljMNam/S9NZWH/bBoieBRVZA62O+eid3TcD/aYmlHh+oJ39xh/YgqzupMNyJbHrZu+Ra8/9/ebpLkBX99SXlzj3XMHx2xiepe858r06Eld8oMPdb8uwP/Lg+sbtwEqVYZqaVHDGXeUD6LM0PyN7vKVAliRJCztRHxp3f+zS1FLy1nYG/jO8PlE2svXbVzPwaTR4DXs4CytIJMsma4WcNtmza5hx3oJOCoiRNPxNA0zz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mM2tCqnXNW3mxVSd/P+8sJ/kiQOrVJ7k8voxPmJ+Og=;
 b=zWttPNKn11JD+ptzUE6EqpL5AIzaJD0iS8aBMv0+p25YvgTiRvAOWdlB+/qTp9sv6maaThMUC0lFZvG9fr8oY2pwfkRSmvAJnlTJtr5GTztx2To9eDirwIxZwKTJF0HtsygYRyTX2jAzSP/ZWBwlSEx9Sx8MxXn+Wt/UihMgP3NjIXdlO0699JI4qY4UQGPnFvpN7nbliaCFGr8A/EYazX1lqv9Oi9P0H5HDhAY8+8ivqSmPvEHwPiIAc+u7Bep/MEDeLXbbrDG5hqpeIb06mV+LQ+t/8emaAHFL6ZZ1bU9F1+H8RBeIZ0Mw9Q+vzmEdbZtUEkDwSfd/gf0K95Yz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mM2tCqnXNW3mxVSd/P+8sJ/kiQOrVJ7k8voxPmJ+Og=;
 b=TawsLxzF6iFgCPL4wVpWkhiHj12nu5Q9iGz4JNECHOIGUtQIqGLNunjoqz1bwyq3zLW2WaX28IaMeUCyFhaor+bFu40aAYoh/o8Gvn85iPP59kerzHc/C5GmO17+7yPvhXPfmnuO4pLMU9TAxMfuBnQTmIn4RbESWOpadzcbwiMpBSprrDy7bCRki2aY/IlgrEUaJOKP+GCeyuJQIjZ/IG3p9AWECb3SA8vzLWdpUxHMyeOP1LGQj3d6GnUmp/MLygYuTpe33K72EOlkTdNy/XtyooALPyTfc1oE9dyx6LP0z+nsYt8OIdr6nWAgQ3s5cRcFRPicCoNoQbX+bdUsdg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS7PR19MB8933.namprd19.prod.outlook.com
 (2603:10b6:8:254::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 00:18:36 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 00:18:36 +0000
Date: Mon, 7 Sep 2026 19:18:33 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] board: anbernic: Fix the RG-DS Kconfig target guard
Message-ID: <PH0PR19MB9973384783FF81E4C82D39DA8BA5B12@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260906044845.27801-1-hppiscas@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906044845.27801-1-hppiscas@163.com>
X-ClientProxiedBy: DS1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::6)
 To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ap9UWcX_kMi3XPfz@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS7PR19MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5d1b8a-ccd8-425d-2c9d-08df0d3eb990
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|22141099003|8060799015|23021999003|25031999004|15080799012|37011999003|39105399006|24021099003|6090799003|25010399006|5072599009|4140399003|40105399003|1602099012|10035399007|2607281247196008|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?10c6flkoREiGch85Exm2TApG6t72KrWRcdyjYnnnzTsIbLOVtGvPn7O9wxZa?=
 =?us-ascii?Q?2UnVx+SaUVYXA76ceTtgT0fFQXCGgZSrZs1rwqgrnUjmxVWpRPvFZdXfQ82R?=
 =?us-ascii?Q?jTkp08ci7CNTFmP5uVFCOaHydCc1XxxhF+0j8FXKa0gIGZstqbYxr9i6WfdW?=
 =?us-ascii?Q?xJthazMAU5uKzOCXiBpgyIEhbBBhLG3j4GcpZevcudRz4qhqpdilNRwMcKl1?=
 =?us-ascii?Q?2tJQVngB3AqBAw5bTU31klL1nTYpjFFnEyCsZPnMnUZWax545PNZuw3jbE9y?=
 =?us-ascii?Q?4nH1s2W88PUujrmygLXU/rdMRGYSdjU/h/C69asWAshBWJK/TjwdyaGydxQo?=
 =?us-ascii?Q?ZORyJXLsFIYWTyywd0IxzabenXNlBK49Ru15bhgORH9UxVu9dN5Dn/9o3PY0?=
 =?us-ascii?Q?tgARdm/cJbrMaF7k/uHG9gkHf0oVXZN3HUfQJm53zxchk1WT6IXEonZ5PUdC?=
 =?us-ascii?Q?Rp7UqTyOzJaTWHX8nji1f0fMxxIoWBzVyW4TAyWle7BOTaTkVmQLLSD65lW/?=
 =?us-ascii?Q?/qMNig30b8ldX7mPHh/XBLDz/yZRNcpHgglopuZhRxtjxIBnDWAtO5LcUAj6?=
 =?us-ascii?Q?mFyjC8W848w8fmRubLP5fQH543aW2hQwp7fwCShJCrdacoml3sd5AlI4dqnd?=
 =?us-ascii?Q?RpL3VO6AsnkEy/FGRg6+elIMr75D8luKp/d8OtWZ1lvOEZ+I00AF06LgEFAC?=
 =?us-ascii?Q?WVQMbxXPKn4LwhXXsQeA+8ry6NggFJuaQIgkS9hd/rAGXbw6PsFgI91pMGLE?=
 =?us-ascii?Q?lZvgVMVXsqreFO81SqxIXhIy8VpuOmTb+Qzm3RSuoq9/ZP7ltt+we6Q8BNA4?=
 =?us-ascii?Q?RgKFmB5Ae4t/bZy/LarQRdfYQo3Pn9YFPETsPKoOlWeIy7syE6GWhCdZINdZ?=
 =?us-ascii?Q?CDXrsPjoUcd7zohm0hEBksMUPSYMf5nbtPU+FzjFlq8pZ4l+utTp8f6AXtTN?=
 =?us-ascii?Q?3U3zy/wn4Y0umy3ioZua8qQYOAjzvpOS7cxr7X1Z3FbthRIEG3x8Bv7m8cBE?=
 =?us-ascii?Q?GegJMQvQL3RBaV/0V6SBYFP+uaHyyVSXm2Vvu2ip/anlTgQYyDwWB51sjEYa?=
 =?us-ascii?Q?mNtV9E1Sc1vet4aAkibdVZNA6DkbKAHjrsWzAX0tGSgNv/FdRWAxkILbBYN+?=
 =?us-ascii?Q?evNDw7wVwzpuVn0/IGc5YfFED4QIfHFi8Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFMcHP1HyhpGtvpMlePmGtDl+SsigzqCEmQDJvR7VkyJjDUBYxflxoM1dR7V?=
 =?us-ascii?Q?WURAaxiBhJzBLNrYXCpV0dNnJVhMqzyGsnYn49BlOBpM2xQ6Dm0ET5G7klaw?=
 =?us-ascii?Q?uADAaynMUoO00XoiaLYO9nTNT4mFN3lJVFl/enBaYvsLAeIMh+9R/ognoOW/?=
 =?us-ascii?Q?YgcqSwRSxAbVDJKedqFdpMVOiah+LYpNkqGCKAgg3s1UBUqyzjSfn6mxOAPl?=
 =?us-ascii?Q?7gwB1pKfQNRLhrJZYomkOXNMzTei05xYZeVMKn3gKswBAq5lBr7+D06ADlZP?=
 =?us-ascii?Q?AxbL9P5rV1BwbtwGWd0502vwimSX4RlhkHGBdlGvs+ulv8tZo+XQ5fRncAOk?=
 =?us-ascii?Q?1+uI5rpvSCxh5YCY0yC1i2OVEI5ROyTLkvDEHhXpPim9NlWNRcQU7v3XfGMC?=
 =?us-ascii?Q?r6nUMNFx50Phi9YkdPJwzF+P/HCsRhrPO7fSW7+HZzcI7PtpNsRoMvyDBOLE?=
 =?us-ascii?Q?O1YWujZqhxFE06cu5Lm2za70PVq9YDMc6YC8+tbwGDcXen6Q+lPadMwEoR8j?=
 =?us-ascii?Q?G0GRkh37yHA8oLrVtvuCu4+GajWzqfbsp4BumAt2EMjdupAZ11fE8XOKsJ52?=
 =?us-ascii?Q?pBIypcbLgs4mIM+r90B8PQEL07WWHnsi52yZXvMavrwAAsfxUYNK+qHMpU2o?=
 =?us-ascii?Q?mKxA3wKnt7gg3HBmSAh+13ST8REvH5OgR4P3BT98oXLzA7GYYcA9/urNVhQr?=
 =?us-ascii?Q?WxKBigad/7t4OOM4SLVZiyYhypsJz4g74xI8JJYe9yEjp1uaD3HeoM2Btf+h?=
 =?us-ascii?Q?FeASaCbqcHxVeAx9BZt+pIckTp7BaW7sLh67HyZ9Nk/QNPLM/TA51PmcTuoC?=
 =?us-ascii?Q?pkhGIbgGJ42Wyt4LP+AjBVmViCJQsd6inC9FyYisn8LVW9240w8LfYnAdwqG?=
 =?us-ascii?Q?X3vIIJYdhJtnHGQa9KdVelXW72ccNj3zBaVw3nUswLO+7cGzL6Yu9c1R31mu?=
 =?us-ascii?Q?ZMhINZKCJp3gSg1thiZQCIV49O75DXpcqSxEDfB1AK/6Pr5BEIJ6Pxsz5+hW?=
 =?us-ascii?Q?/2VnRcCSpSixIomk8LE78FIasbxNs2zo18v6Kh7nzYy4GWmlvn/qsr9J1iUM?=
 =?us-ascii?Q?UHgqK45H6jm50fEXSdQ1eZ+7GqniZ5X4+kSRflqW8gISQQ3YqKcJY4j4Qzcs?=
 =?us-ascii?Q?Kct95ez2Z1R5HCwN9o63kKreh/sGVtLf2l/9JGqqeT4EqPUglpJ7CxaSCmjB?=
 =?us-ascii?Q?oOXZ72iK3/wYKlalooV0yUCPipsQ0zeOH0/VMWgsJ1xVdGu3kY9T3vGy1MKn?=
 =?us-ascii?Q?4uGRKPAv3Zrvd/Coe/+zIK3WY2WuTnuBMYvQBeejiQdzq+hT6RlViQ01Z828?=
 =?us-ascii?Q?H9QfHM0lqpxH1UdM6cYraV2k8Dd+Z+c8qc9+YI82JeOmkAbadnLuYyh5/qfx?=
 =?us-ascii?Q?6amwKckujTy5RQwsP28DIV8477NS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5d1b8a-ccd8-425d-2c9d-08df0d3eb990
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 00:18:36.4960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8933
X-Mailman-Approved-At: Tue, 08 Sep 2026 14:56:03 +0000
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

On Sun, Sep 06, 2026 at 12:48:45PM +0800, Pengpeng Hou wrote:
> The RG-DS target is named TARGET_ANBERNIC_RG_DS_RK3568, but the board
> Kconfig tests the undefined TARGET_RG_DS_RK3568 symbol.  The board
> specific defaults therefore never apply.
> 
> In particular, SYS_CONFIG_NAME falls back to rk3568_common instead of
> selecting anbernic-rg-ds-rk3568.  This omits the board header which adds
> the serial and video console settings.
> 
> Use the actual RG-DS target symbol.  Keep it distinct from the RGXX3
> target as discussed during review of the original board support.
> 
> Fixes: 1998fe69f7e1 ("board: rockchip: add Anbernic RG-DS")
> Link: https://lore.kernel.org/u-boot/3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com/
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
> Testing:
> - Generated anbernic-rg-ds-rk3568_defconfig and verified that
>   CONFIG_SYS_CONFIG_NAME selects anbernic-rg-ds-rk3568.
> 
>  board/anbernic/rg-ds_rk3568/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/anbernic/rg-ds_rk3568/Kconfig b/board/anbernic/rg-ds_rk3568/Kconfig
> index 867694065..1d1043f8c 100644
> --- a/board/anbernic/rg-ds_rk3568/Kconfig
> +++ b/board/anbernic/rg-ds_rk3568/Kconfig
> @@ -1,4 +1,4 @@
> -if TARGET_RG_DS_RK3568
> +if TARGET_ANBERNIC_RG_DS_RK3568
>  
>  config SYS_BOARD
>  	default "rg-ds_rk3568"
> 

Somehow I missed this on the upstream, but it is on my local branch.
Good catch and thank you.

-Chris
