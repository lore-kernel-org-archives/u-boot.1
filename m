Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180BDC61DD3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 05:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEC5A60BB3;
	Fri,  4 Sep 2026 05:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olDTuj3VpfmF; Fri,  4 Sep 2026 05:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E969E60B43
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788498409;
	b=UlIXCHopvAuM8JFh77uolgsDtY6XGQ9rLEShgvHXHrlExLMWRGQgp03FwGmHmKZhHT60
	 tMNAsES9eir1pnDY3hK8O4p0h74LUU2nSBKEQnL9uRQWQgtXA1XA9LeqgDcA+Kx4iAxWK
	 vhb0mViwOSKz12OkujTAvrO9DV99beqs0W6lu5YVZOkT3R+VWAnjtmE9NCHfsdRreEgWJ
	 nnvaqaFGyWwYPJoqWZDfcaWXk6nzZx9xYuq11RKPrO+yqitnW3xlaAYa72kgtgI4048dQ
	 g6dALn4K4KZCZjzJeWiILs6zkFL+lC7baX6co11iJQPza3C4Sirlr/H2Ad/WNojdJ6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788498409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 Received:DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=;
	b=IDLEnJGXU8EGi5Ht/iBo5EZa2aYmfa8GkhdSvf8RxeBr404jlPhmIqxNNpB7+gh/DEiM
	 tGAYaxHJuGxcWPHLAkIf4wDGQTVJ8W0gLWp0kMJr7xmkSxnp/dUXJ7aQ2Ud70lmh5oXzc
	 15kvKQ8iEU37kkwsMD6vVMUYhx/kJQDBKQFklCACNNQ0MpNt55P1KcKv2quQ0s2HyR52H
	 +pS3pHYNqgd2olMSihJo5XBRxkWVRQuJAsE7Oxg3UZFi9Nwdec2iQXG+Jv416/CfDsp9w
	 Mon35z+NAcdi4aMtBiYkm1t/NARtLjbx+L7HooESKhYFZQsdBWabn1pUhRlbgGeF94w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788498409;
	bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wlbW0RwUbMGBWlqM27m5CLDt5ms/IHPWeEi9TkI4vc1xvBt0HZekxBf5H/1vclutz
	 JaCvfsKYXlIRfa/Y+XIO4ezEdZzj2cqezuIpWtldXLicNovVA6AMmvhtOW3SaobGXc
	 4P9uxevNcypYTaPGkLSJX6E6mu+fphMeHH6kEKGzApIDdLAW33/aqvbtQFfRgFrUUl
	 DXf3HP5VBmr4+ItO0Ci1hgWDxmRxUjR7QolpcO7l8ge0TkDq5mM5YJVtr8dENQ6TJx
	 nDxcnxrG91KbEchwnHjsJmkTLziCPlbETLXUDvMiIM0pQTCf/+6SgZio0MWLTzzOQh
	 2dQ4puW5S+0ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E969E60B43;
	Fri,  4 Sep 2026 05:06:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4261F77F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33B7E81115
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exAu77oOQjT0 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 04:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D42C78110E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788494937;
 b=tAf1LdqKDIWBDWoSXyb8yo1ajlMHBwNL5tW14mcuLO6ZxR9LLLH4jV8bdpcnXsr7RK+B
 NoUAlbMOh6GDtkJTdm5zOOxTKMbumgA6jrJ3BEYTbDitJSAKmCPUsPJEHRrZi8FU1LVbA
 OmDCThFlMs/F+4x/bxQhb+Wfmlkwv62inDldZIsFFgT00zFfTXYCfJozMrZKiJSzGb2KM
 0HjLbv/J6POYbo65NBIRr74hIBKg5d+oGPorWF9SEevuBfXkIkoabaGi2YD+NYuxQURDX
 4TAhz7kyOMbGQRl1juZy86HtSWGxudpNqIyyj8N5cmk1ISjvNOhMRFrCV7uK7+gWtsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788494937;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 DKIM-Signature:Received:Received:Received:DKIM-Signature:Received:
 Received:X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=;
 b=krG3qKKCQ+xp1Ka7sg0mvnWpzGwKNOOMwOV/NyHEqsJ+qg615GtZ/vvhShK4eJhSYNtF
 Ln3oAAvYtXvnNGJo0RMOZcUUlNpH7nxhEObKJbe5SH7DwBCpbYCUMMHTB3M62GGtaiNAU
 pBkHD2DAaVp4TNjrYotR+ukeJin56qlxAJjKSmeqb04oi1auXnhlsHLxzFWoy/Glv4TWd
 dyp0zpBYwHdjRJSaEOPSmkej+M8TykqmYGeceOWaWw1aMydUhlxHxRajmGLpLRdsS+Qnr
 xpkCGaCJZKl3NybMF93Q6GDNgPxWUICRF0OR/TWTWSaDC46yb+mlIidtGpvAoGUhb1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=synopsys.com; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=pfptdkimsnps header.b=fZFLl6NE; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=JoF+BrZa; 
 dkim=fail reason="signature verification failed" header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1
 header.b=rOmPy+yE; 
 arc=fail smtp.remote-ip=148.163.158.9
X-Greylist: delayed 5952 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 04:08:55 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=fZFLl6NE; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=JoF+BrZa; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=rOmPy+yE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D42C78110E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:08:55 +0000 (UTC)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683NelPf2396136; Thu, 3 Sep 2026 19:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=; b=fZFLl6NEHVIv
 BbUWSPLput9crlCAANGjVmy8z8OBjYUvxmWj/OA3FsrAPhUvW0mR3L8doIgE/ZGm
 irRjlcUqF21JKV5GTGhxOvvk5uafkoQuEgiRfDuRf8buxLi3pH+CKo1xlGTWKoPH
 FejYW8TV9Uyn0K7iL+YL4cormBQiEO6NXQq25YuTtoDawTiFyvD81lMQ1Jib6U8E
 J8l7mPtLATh85DvxrZ4y6hTCdjNGPt0fbldvUuKIMqhi5UDNjWkQPIOAtUs4Xi0r
 mxXQgZfsmZJdFaxtBF1uYY1X6Wohc7BupCle0Y8XUhkaSI2pwXJhjLK3nn6GdfgR
 5dysVmdRZw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gf7ctqs4m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1788488978; bh=nTlU14cN8gFHPEY2sxi+pLi1sTw5pTUEov3UU5I6EsM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=JoF+BrZaLW+lc4JG/YkNM+RCJx0zxc1Cvtq3H/rTVIxoxD+VrZ4f3m+36kkcIEGUb
 d0XmTfD9hlo8LtRatS+KlXenkWDN34mZFIGbWqNGP153nY4OL90wFPrytz57GpUoCu
 /xtmRFobT15Rr6en+fRIaKnVar2wh8vdyxQ4NEn3VIbXd5W3XgE7Wlbb6cyDwNCXFC
 29j0ggD/uodo5R9PNoOotMoFjz99Ya0KaAy1LiO+z4ZDpuHPgvFwua3LRXV/RVfEKr
 GglfNDv/x3X5fq7B9ZggSp1KOOFK4gQm6VP7EmMQrOcdetgqnRXSrPlhNsQ3AK3cx2
 dcG7VSglTtxlQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 583E84014A;
 Fri,  4 Sep 2026 02:29:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id BCDFDA0070;
 Fri,  4 Sep 2026 02:29:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=rOmPy+yE; 
 dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com
 (mail-bl0pr07cu00102.outbound.protection.outlook.com [40.93.4.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (not verified))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 80F6B401F1;
 Fri,  4 Sep 2026 02:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwjiedxYdqtVuVsp0vFHUMKxeFZDblhjpLfbHq1T2Aw0tJMQU+0X/Veg0hNf1k15+EsL+U+5xcpIHHDt5niJPzkBGnlU+YCeGadPTIwABvQkmiz1obpJ5upfAdRXAVPneiS9voTNFAu92mAvjcwtnAmln/BdBFQBXKbkSxA8SpfWtxfdaRZnySp8733on8ttrlXwX841ZPmlse4CiA7W+GpvxoMOcSM4/rXyFX/M27sfO8T5BDXVoB8Pn7MreitK0iij0PabwLYacOwokg8DB8UuUbRmc479QhCEpe0vu6hmV1WqfXat6RryDHRghTNEVDXCZxL5KgF0QeuSlEJ9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=;
 b=k2tprw3aszrj72Ilv0b3IHnigghCGGtY7rY/ZBVLEEofncQKd6Ohzv77a7BNqQ0oh3Pk8YVI1bEVWFhBRxsaD7D9QkqeJybjmo9TPQLo9JVSAA+as0z+jSVf4Dyi9PrvJ0aed618NdEAYIQC/EtWUhjb2xrxo1QEj0/HB9bK1dwO+9qzk6eThIXbIsBiCIAcDNP0CN0q4KmFX/+Zq5t2B7P+Fm7SFaT+bVTfLGC8b86/655JTWIZsIx98mUoLZo0WeaRDz9Y/PFkqbQJfGkPcyDuRzZUcCaRgSQkOO+ml4Up7nXWhOPVj5Q/n6bmazxynOy3LCYvaRbOvRKvcWKkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDpMLeqTGMhRgKRceOmgl6KwPtVpt5dncGFqMcDYDPs=;
 b=rOmPy+yEGEZhWFx6VnBZREOAZKUe3Vni1NJfL35DBR7znJX+z/OxfQ655Y4J+tz0L4lly/4luImeWdZiI5j/tiYF+po1nUTt18M6lxv82KqisDWya8SusifNPEMxmBzKXL0qmcNztY5yEo/aV3QaUWgh8zUI6rilJoCxNV1G2dY=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:29:33 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:29:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
Thread-Topic: [PATCH v3 2/2] usb: gadget: dfu: add SuperSpeed descriptor
 support
Thread-Index: AQHdPBU4usnYibttlEiVIAkNwjP9FA==
Date: Fri, 4 Sep 2026 02:29:33 +0000
Message-ID: <bd88dea53446158d6f1bdd63b0f76fc1e1b62ee0.1788488867.git.Thinh.Nguyen@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|EA3PR12MB828978:EE_
x-ms-office365-filtering-correlation-id: da4f4faf-0bd5-4776-8946-08df0a2c5b5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: zwyzgy4En1V/RxAia5vadkRWv6rCo3bLecEhqQyjIUM35/lZw4zMA3lchnko3R1ovjO3uDk8aCDXTCdOq1l35M8LOsuTpR4fSEJBLtOju+O4piTF9cXCHuwzTTUjFKAHosVXi+hAEZQ66KCpvN+7wjO+0PnnBoMv5ru1JikuNOZCdNm6a+QW0XC8kBsurYGwh30/9pvpWOS05yZ0BZw7NrA8Kg73ICJAuZyjuoMD47GoAwikcAnoXRixyL8PwXfFfKu4hhb48oSCbK2R15ZszfqTgiWJE4iASO07kh/QCOhlvNEVxzw1x3CAAMxrja5OtMWz1lYU61GciVayVQEGjCeTI+cS4B7Jl+4/h+ph6GxfMgTk7hPyImAWv+AsMmFTaFGm9exKKcp8QHEIN8ZUybcN7vatyiK7u9V7/zK4MAhhqX/ffJxlaP19DFm8Sg/FQmOh7nKtSC+7jVf8+30qGM0SSjbbyXQfBc0cJz9k1BbNyy24Hocrr9Lt9DgQ0jxHBZ7RBchG81+lfbYQyFvJGxgWW2+kxBu6e1dP0VfeV5f0eAsvnT3WdM931CKjzdJ1kfFCliFfYLVXenpTAo9wYCXIAqlpjX+rvPyEfuWeTvN1tmyQbF6efzt7FEpGtAmzYLs19W6EBrMy719gy22pOGQ8XpGXRCw45bog8XqOzkGpXkhAMfy1ebBaA02ux3ghbnOr82MM9jO6E5hJ0+ccdjgDrVPYX8SEH5ZY3gi67rQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?22IIY+HhK0q7yoeg+pUowFftInEhwiCkJ+UGcX6gOszQPNzcRJHkx2/FCF?=
 =?iso-8859-1?Q?yv9G5gO7tEmBRpXrDnDtyHsCll1r7HfuYrY5hzMCbC6IrAl8GRCCNb+hah?=
 =?iso-8859-1?Q?355tpLozS+KGJHyNmn4QczulvRwXc8JNeLw4TR/8+cf2dXpZgoo2OmNulK?=
 =?iso-8859-1?Q?O2CzIrD87JH0eQHnX58YXdZwu4nfNLD7VwYS4sb8JKBlCY7vYElEmGCdWU?=
 =?iso-8859-1?Q?CSTg0MJpHBiPxN0fNXh2aWzKzivwdAsNF/1RDKJ8iUS/Zqd1cwnlmPb8jo?=
 =?iso-8859-1?Q?wql/15bKCk35sGQkvKMDhjbSlQ4teAzcz9d2Igy7+W/QaG9j06R0PtkrvE?=
 =?iso-8859-1?Q?oS14JFVAwEtusvJdT13WsLEhgPTI6iJOp9Njh3zVkeB371BSJAOQ1oI7iO?=
 =?iso-8859-1?Q?JpZyyLq5cQzQCe8gyfVI2wwzG+oJWzBxGwL95gUjwZC+UwfvsMAAh+/a4v?=
 =?iso-8859-1?Q?fwdRoi8ZjDmXq8qa6IF3gDEvP6RxM6JUguDvEsEjaBRn0Ndl4LrxSQr8/X?=
 =?iso-8859-1?Q?NvabMuQGS1uQ3jiqs9IPrlN7Cvs6cA9xhjI7hEMXBP3/ZVoydsJcyePVpk?=
 =?iso-8859-1?Q?J2hqvMmkGncNYU+Nmtuu24JlHznFW2hoVCDl2O1vyGUWPCCPWJcy08EmbQ?=
 =?iso-8859-1?Q?dhH6TmqBrtPZJD/oe53reWI6H3ZVlA9HeCNceh3/uLLWNRvyMkGCkkFR86?=
 =?iso-8859-1?Q?fCCmPAqg4xy2e7sqMKROnG0KiA6/70DDzi3yvNQqilaA7J/3C92xs1P8r3?=
 =?iso-8859-1?Q?UncGu7VIvIfkbaXo6LBF/Azb6IhqJRjzW+4oa2HP8vZpvbdbQbkCBhLVWR?=
 =?iso-8859-1?Q?+F+aN/hGe57LDZfjxaSOM9kXftdGzmtSIEheIbAoQayUrFyPnbAIAwd9E4?=
 =?iso-8859-1?Q?SkX4EjeScghMtMaqK9wfbGecR3e5efsJT4GMimINMQGvvGKhnSZJn03514?=
 =?iso-8859-1?Q?DTSIp7GOooi05H3HPrIo2TkuLOiV7RRfBeQVEBhDkHDVHMVPlB2vFpYq6c?=
 =?iso-8859-1?Q?/RFeY6MqlZEQzy06UEeibavrJCCKS6ymyBnCq9+BDbMGIzn7WI/KvTxnN7?=
 =?iso-8859-1?Q?r7FUsbIVRiYXC66n+DGjUariByLboel6m/mda2AEh5kA/jojoTzSkBZfN3?=
 =?iso-8859-1?Q?EGqo3qPYL3o896HlI8eXTnyWcNJLNbw7dOdqGu6v/dhPZg5Ddk2KYQXi/l?=
 =?iso-8859-1?Q?1dCBCFjMk2jxgDABcixf8cVMV0Po1yNoIkswKDALQYKrmQmxYjOKrl94jt?=
 =?iso-8859-1?Q?bQr4/UcUXOGFaTVXZSO/gF60I+0K4JRMahMhkBTU6mLKkDSe4xx2hX5Mox?=
 =?iso-8859-1?Q?SkJ0aGqnHMd9VusC012McncwnCZ1u6Nflu8BKbHRaidvFyREeIdQXUf2kG?=
 =?iso-8859-1?Q?FrVfcqrkKOq8A9yn5NuvhYiii15xI2kxbUn7LYA/KJfbOVoeeX1OTJL7Xx?=
 =?iso-8859-1?Q?YeUNHd7uVLCVMXcLAtimFBCJWfeE1+KyybRZ/irtFEfb0CxnRot5PtLk2J?=
 =?iso-8859-1?Q?ln4y5pFrrmLm5J233sXoZbEa6YZhdqfn3uJQT5riXX7qZsuKEW4PxAUxJe?=
 =?iso-8859-1?Q?va0EmLi4zOe7O7C2rqddR4B2CkRRca8SDn96POgYx5FOZbDoY4FPG0uXZy?=
 =?iso-8859-1?Q?J/Cb2GLUQYH0UZ9y3wEiJpMFi0LTnWN7ypIK9jHNb19Ik3yhx/0mPvrq53?=
 =?iso-8859-1?Q?00g5X63U2qGSatreL9SVYHNan3igv2ks2pjjftrsZ4vA3CPbzjqDx6wUnd?=
 =?iso-8859-1?Q?x1Ym9/HDJZcJuawI0kq+SU7TM6MwkH78j98N8oNAvwqMr1QnOqdleqgaCS?=
 =?iso-8859-1?Q?oIeuzCWPcg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C8w6jPvDuzUJ36leAuNnzko5aCauE1DcejUvLOPkt/pRoFovliKZSF5ENfumGPb/F/C0/QoSBWuOLBE+JOLONsnmB8BTDkYs+0t3PUcXi8ZJG2lxGm8uGABHsuJk4Rr9Cc36WBAPcsE2dZY2MEzjJMs63so9BgHazcLS41tycBHGInl964X+Qlft+sdUbi7RCXn8tfze0z8PL2hq7v/Q/9h4tw7b0lrAblLsBGAAF5VPqFeZbHFfJ9Kzi/JsIn6+CpOj20twD/lFI0vNpAaryy493IJuFbnSMz35jWKysTxuOHM/oizX7NYDcpjXGgyYFfvDiE7GDVLrpLOrNBRReQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sJ+uQrBUE4ca1Xv1LSOdCiwx0RzN5NinlNs6OdQup+H21ylDYRAZzc9fCuil63xfwEbbJH3wnNq15YfFldOYOBDxCZGR8vijrN7A6IcLnfQ7VQMrinaeHiPCURpTdJ+Gi/mMvxRUGP5YC45e47UQ1/fJcsBw1CsvSK7BKHKOTh40U4r1W6UOKIw8Ww40+fa2JeNUTSHBHrvCI2HOWWVEtJrBtvhl80APb/qer5s8m3IPj6jaPpQAos7LipQFKiAJv3HQ7iiVV92hhRlJvF6n/JJzPb8IytRjiB8SyL7actLzUFqaQ8d8Etb6d3Fhf5mL0kgXMQQm3I97bSf+WETzcquGwDp954stgrxcELAfqIkcCWTqEpBGDqUigiCgG9CItbmezoDyGHPXubJBVmhRQtEV6LUoHvU5eb4dNUTg/bPExTUj3rRkYvEnuS+p6mJqw779wZLG4TGQLmVHgjrJdadTmV+7APTdM5l25ba3UXRmKVTWtOLOoNhLBAJgYpkyezjxEqEbeH4wWXfpA7R287ypqtum6MvXukfJElmkzAaifRhmJLMpG1zW210lWiMTvkU8oBbOv65TluO/6sImo48ExXD6GIOIDqC0Y088Xut+vFDYfKack62R9iUEPC/xfr/E3EakElwA49kBztzTyQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4f4faf-0bd5-4776-8946-08df0a2c5b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:29:33.7553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5O7P2rQ84nXSaV5bZEXAlYjYKRXlhlOEiYKr88V7JDUuUMQuBoVeACp1snAdbd55KT+f/96yqEQODCO6y/qVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfX3WeHyNl1Q6wP
 iqxogDKZiY4O1Fqk/Vj4/0BV98qpCwGDowTXj/MRoGYbmYMAMdxsyZ5nNj3Fkf5JZ6wxg/LTE/V
 Qel4+dUwQvnaqMXD40rPqeQojONRDI/mP51q/QiEjKegfImpTIrceDUNtFvDF0PNO61ycdf58pj
 FNnHKaT4H7n3BM+KmfEyL3cKBBjn99u4Teb/zy45U6G0+vdl+cHaDtlggBEC665QwCX/Xe/8Jjl
 ghZ2XIvioGtXjUnysz2DZI5+3/8X5oU9KHBjzmkzwhzRuDRC95blScZz0sT7+9iLz9rla1toOBz
 bDOYRt69wCDcdb5nH1/jdMr01gQiaZ+vV7Ybq2KMVdfwvpJSfzRYyZf7fXAxBuVwTozGioEgugg
 KM23+RO9qRJjTTwtiO+KN63CBqg6Arl9Niiv/xsF0h83UdmuWd4w3KIxfIkCHKBjFFuFjaQvR25
 QqhJnqV/al0n87F8ERg==
X-Proofpoint-GUID: rEeLH_HavbkgGLbHh0DuYafy18g6fBJT
X-Proofpoint-ORIG-GUID: rEeLH_HavbkgGLbHh0DuYafy18g6fBJT
X-Authority-Analysis: v=2.4 cv=PY3PQChd c=1 sm=1 tr=0 ts=6a9a2d13 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=jIQo8A4GAAAA:8 a=s0PobUhQxtb2yrBSvdQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfXxMoUQWnennW+
 EfXTZ55/ESJoSH8gEh1kDf09WEY2jDM1MhDOgY+S4n4ZjenbXQbDJygn+bpF33u4oNcATt0f8H8
 H4KOq/xShUpdWxvXvsP2OgBDaFXneFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609040020
X-Mailman-Approved-At: Fri, 04 Sep 2026 05:06:48 +0000
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

From: Dan Tran <trandan@synopsys.com>

Populate ss_descriptors to support SuperSpeed connections. DFU is
control-only so no separate SS descriptor set is needed; reuse the
same descriptors across all speeds.

Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v3:
 - Remove the superspeed descriptor assignment from `dfu_bind`.

 Changes in v2:
 - Removed internal Reviewed-by tags

 drivers/usb/gadget/f_dfu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
index ca8b36e077bc..b1bdb865d3d7 100644
--- a/drivers/usb/gadget/f_dfu.c
+++ b/drivers/usb/gadget/f_dfu.c
@@ -227,6 +227,7 @@ static inline void to_dfu_mode(struct f_dfu *f_dfu)
 	f_dfu->usb_function.strings =3D dfu_strings;
 	f_dfu->usb_function.hs_descriptors =3D f_dfu->function;
 	f_dfu->usb_function.descriptors =3D f_dfu->function;
+	f_dfu->usb_function.ss_descriptors =3D f_dfu->function;
 	f_dfu->dfu_state =3D DFU_STATE_dfuIDLE;
 }
=20
@@ -235,6 +236,7 @@ static inline void to_runtime_mode(struct f_dfu *f_dfu)
 	f_dfu->usb_function.strings =3D NULL;
 	f_dfu->usb_function.hs_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.descriptors =3D dfu_runtime_descs;
+	f_dfu->usb_function.ss_descriptors =3D dfu_runtime_descs;
 }
=20
 static int handle_upload(struct usb_request *req, u16 len)
@@ -826,6 +828,7 @@ static int dfu_bind_config(struct usb_configuration *c)
 	f_dfu->usb_function.name =3D "dfu";
 	f_dfu->usb_function.hs_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.descriptors =3D dfu_runtime_descs;
+	f_dfu->usb_function.ss_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.bind =3D dfu_bind;
 	f_dfu->usb_function.unbind =3D dfu_unbind;
 	f_dfu->usb_function.set_alt =3D dfu_set_alt;
--=20
2.53.0
