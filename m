Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38D5C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 05:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD6760BB2;
	Fri,  4 Sep 2026 05:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fT4b-SUquMOj; Fri,  4 Sep 2026 05:06:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DAA5060BBD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788498411;
	b=jfriCe7gqVhOAfAKIXzVTdE0IZlotIh05x+DAvCBDbkMFntq+BIEXwZTWYDxKcaJ67Hj
	 i/eQCF0/BFA7csPl8yN5mJ72zCcctbpqC7rCHkK9bHBfoED8o8jjEGztmBAMZ3KSmtd6l
	 uF0TMl1S+3oAUDF3AprFjHVDrhMyxLhlpPvozsUU7I95QlmaglAx51T08b5rF9QYVGENz
	 QBimXMqeiLfWf2ToukrazVjiEihxpfZlIreC5GSWPZYBXBSsyqD7qZ3pBev20ONSW6v2C
	 /XmNbiNpRpLgAhtxK2lxThfA2BY9MhJ+2XyIpyk+1J5MhceRBbErVzNakw97K8aQCiA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788498411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=;
	b=PUcX7Yi2V3ZdWUR/ne7ePfOAwf5cxWVTr0BvCCLS0m3EFwpLckUU7k0oi1g5Dh3k6BWC
	 q6hABj5gQjEdSo9XLn53RDnqyKaoIJNH1HBJ/Pf+FZ0ANgN2FZ48m/lnwVMVwxuReiCMc
	 ODDxrx36avYXStfaOT2jXvH/OOmvYt1askt9JIMWpl99gOYt5909eAdStszJ+AKVegeFf
	 DA0TxFNp1wdRkssoqH4YQ0jMuUzFHGt0VjB1RHAiPHWllUBk9OZlRam1/9/g/2CDPl4EL
	 D9Vuf77SBpMXBQhIM7ApxNopy8IeQ7v/67Uy7J5UR1DuHk0MD7u1ZPHDuCMrZ5FgYUQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788498411;
	bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsZGL4w5vwZmzM6ajJencVKZOGdBlbH+uFZSmXly8kFE7bp02pGqsUrENvB76maxq
	 pR/xVE4Cj12tcSxb4Pej13xQmLG+AoNe9YehSqDqvG1+VYQX5++bgXrwXMUHY9pOWi
	 iwrGr+SG8bydRpn4HuDk6RkAMEpe5BCE7jsdZAx/7y0Qqx0e0TueKYsIL20XRtpSIX
	 ctrpBlYqFNSnaoL6Ig4WAr5WgvUGZS+5fVj2TSYEio+Fh/68qDkRy5p4EdT+tcG+R7
	 CBmyJH0GKr3BESgLA6+r1X1Z9ZUmaSM8cPOng+K3bK/5YmG3wOCQe49H1O4kfL9ssP
	 Vg/ndec0Z1HzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAA5060BBD;
	Fri,  4 Sep 2026 05:06:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E724B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3498D40B3A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1uC0fcK1UCm for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 04:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4224D40B38
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788495487;
 b=DAeSJJZ5yTgbnK2P/+BPF4EGxtQTa5vVDO5bmXuCMSW8pUIOxuE/FMZsECoeAlt1YPxS
 mDDr8hljGfcuJxRFMWVOwlpzQqIHP8VoiyX+Zmp0PhkuiltHa9ojQEA/CcbEQuocQfIDN
 0faSgOzgP81VDwJDHRulbV7dcTASVmOF6Orq8vVcUUvjsFeWuPWxDPK2BItOXorAx4Snu
 imrJLAk/ePteApBLo709crgpLpaY9bvyVl7dz53yS9ihhuWT9QQ+Hk4m5YQC4lCcx3SLK
 QQ/v/doPZvdUWlxeT02jFqYCNsNLPmcdJLipmSzFotn6zlrHQt1HECHY4yMHzQngATw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788495487;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:Received:DKIM-Signature:Received:Received:
 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=;
 b=G+cId0zRoobt6cvUDtnTIBKrOG67KEgaynT/nXvW0BzDZ4D5IFHa0v2/DVSqAWLcE7aa
 fzkO+DYXpZWc2YRBBJY8cpoXY5/ryaWq71zuTQh9fXBJiIa+QfkjntukgjEcTg3MxvHmP
 XbjyXHBc4WmDxm7zHjcl98KbxECqtfalmR6gqaJKhPObr94RZj3m3Yge0bpMDciGiP5v9
 V89IDKpeAm4gJ+nfcsMfGyzo1fEj0LOu5qi+raU3SGH3hIB6PvrnzWL12Mpb+485JJue7
 6pxdjihuKl5pllW1AkuOz26dO3EfLA8p/63Zmu8T6tC8fTxtauURa+r1h/YTOhrjdsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=synopsys.com; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=pfptdkimsnps header.b="Uxm7/4GT"; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=WrGduCaK; 
 dkim=fail reason="signature verification failed" header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1
 header.b=PTi7nosn; 
 arc=fail smtp.remote-ip=148.163.158.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=Uxm7/4GT; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=WrGduCaK; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=PTi7nosn
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4224D40B38
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:18:05 +0000 (UTC)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683NeEPB912291; Thu, 3 Sep 2026 19:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=; b=Uxm7/4GTOCGb
 B3dK5ulUG3c3bB0nyjtTJcfTVwwjWTir07Ou7RLBcpZmJxKqPetG9HL/To258rVh
 xQ2khEZvDFakkVboLySWxVyN4xESz/dWp4fR6kj5RbXeOz5tvj9veNwRRDzbX61z
 GeBQtFRglc4bhny3T1En+4cCc39hUmv7dS1PBQkDnHhfcvlzDKZnrOMv17lFP3Tr
 ZVYq5ob1zQ+15Dmzhvxf5+VezkhKugR5yxUIraPdsEpeWqRmlNxxFEudgfUJ4s0P
 FeCgA1j6bmlotTSQbnoClRbr/J6h/CK+t7Ytz7exe0FbXEmYfcrQ+tY9y5feYE6u
 sCVsSbOmRQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gf9gjpm7h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1788488971; bh=8X2gYRnllozhbIkgn9VgeexrwKZ7Uj9OH4CgXHiqYM0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=WrGduCaKimIt0Iqgdyb8666cbfq6a046nCMD9nGAUQ7xxndNTTvDIWHzjzEqek17T
 PHgDRj3LCNWIVGrjfzC9pTKLj676iAGdLwe2s98tBoPfZ6fV2KMnemArg6wyaarJN0
 fL0c2BG/ftRQ4twIVNRGjbQzHJhf9nQD8oKbHujjQm9bPDqhESwm/MmWG4Ho+hAEPH
 j9U93Xt209qi8y05thnsUXX5fjKrU5dHIFoWUH3BGCgR30xAJhrNSZEQT+9/+HogXf
 cXT5+azuIBU0sbguIFzUkbw/MO51aMU/WBBJRAOTPX6FONMoF7dAjv0u34OMtildn3
 UJNZYZ5EYvDMA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com
 [10.205.2.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A779B401E8;
 Fri,  4 Sep 2026 02:29:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 74A6CA0E6B;
 Fri,  4 Sep 2026 02:29:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=PTi7nosn; 
 dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com
 (mail-bl0pr07cu00102.outbound.protection.outlook.com [40.93.4.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (not verified))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 25A7B4011C;
 Fri,  4 Sep 2026 02:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNe0vl/vWGGY4+yuHzRelkZ4p/M86kWaxEbizSfIOQzUA/AIXR7wqAX4aR+QbRJGfd7PHrroU9hA3NhhwhsJf3oH8MAnJFysOzrBMvwP7zCHOuWIgCyVccB2BSf5/0cC6BDvC57UZTaxAe86Z+NQwQfdLBGVo4VIM6TUr9KCiX+0g2yR+if6djaIj6NhQ1MlFqMXIeJRpqnDGazCKdJDttojHub535IttCSRRXHMDew9V9gbtOhLD/lb6w1whtE9YC3ukCRy2pamgFBH+VO0FqQaudSysVqfoOjyiDX6R1hrzrtrWdy58dJL83iqnWay//13xByDdoMVEFGEAQsrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=;
 b=lkM+Ocx4N4W4Sk7pFLq6lA3q4XuoZ5l1BbcLGrrT9CoyDQttERBGCpyT115SGIZtruJJ+wJxWyspAmHMPUeHryzvg/kdHS1bJTQlwb6OQyROSo5SmOBpiHrBj8MFDizH+95KQDfpRdn9JL/tyIaBOUaJ0kVguY1tGCWnvDaeW/RJelgBq8C/4f+5RwJy4XBpiY0b7tmaWKUQoghakTbIFldlKBPyi4feKUIU2/qH1ZCylgQn/QEWccaEv9mrIC68HOjkLGlkvTiJEGrwWJWkfRi4QTwnPjz5Dd18RJQ3kkSMCHp8iBY3oN+/EJSgn86FhifI/jrNsxE4jrruYQVbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7cNcKL4TBvfOMheKKxFzKp8q/atmJLhThJV1N9bv5s=;
 b=PTi7nosnKBpPaKZWErh6Uk8tVSJPjjD/wZnkJ/7AsbN3BgUU8srQxDeS9JqoK0eku6LCmY8pEwSByMuDyKGcjEVFq7yqUWUrbPAZwxgYimCotvTXq84y4EAHIVFSSvGZO1wJb2i7eUkKqmDjf5xjc85IZPQMPxnPBc6lwVKKXZQ=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:29:28 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:29:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed descriptor
 support
Thread-Topic: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Index: AQHdPBU1i9VqyCinQ0qidgotC63alg==
Date: Fri, 4 Sep 2026 02:29:28 +0000
Message-ID: <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|EA3PR12MB828978:EE_
x-ms-office365-filtering-correlation-id: f3bbb85e-9afa-4fd9-2a37-08df0a2c5801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: FXe3WzLCOxlhOyjs0FO4oqMhsnDDDKnj7+RZ0ySnT39kWFMVyxXxaZHFMNy4ehlPsI5GI14tVtV3mr4/qobYIFwj1VD/l2s4tHmLhc+97UAhtVZgwb2913SA2Ab6j8YzE6fXvOv5hdOglkrndpIu3A+LXzd1fmW66qg/nI6Py1Lh7j3urjNanak/CiSsAOhw0vFFglK+r7mUzpncK2ZxWfhN4y0q58lRtVuKfAiFJNGYZhBQGYWhzbMhpw4ZsTyupVtLkorNOwmhgL1bBnO2KlKAtyWDoHRauuwvZy16qmBTKOpZF84nuAXRHnnSpWWYLOZKpM9YZ4l7xfglc42Xu4sGw5x67z9zJ9S2LOdteecZDdVFzkkxaei3x+607+c4NFwHmKJaHGSuyJqVVpca0AIJ766X5SOkdrQ8l18jZSJjkud8Tars5gNbmI8Ye5Cm+MqEctVJOJCksuZnZonIUh07XWaHxlz/0T15L+H6a8jkK/eaS9LtWlQDjYNY/Rjo99PeINaWPJ5/rdJ5amqnZbTqsSzv/lQjVfUeJJUl80VxPfEaKvkI0njxs9PyLkzMF2/uWiVY2YSCkDNJP3/R92fkspifuQH14Rj/UQEKOaMLqZss9nNjGFNO3ybrDNDwmD+AGLV2ucIgqvWh3w4NdG+iJYFB/pi/jDpWmiXPQPztg/FP4CMKVqtzAefUzusuVE9+wb+fhAkG8Zh9MzYYDuc49DhSuOl0XxMi8psLUlg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vWoVBDkKTpO0EYx/aMC9RjFUOKgVovjhTwjL1ftQOOiZmrOI/nOUVLv82h?=
 =?iso-8859-1?Q?gZ1JfUPB3AORFmkRBbgB3mBSi04ZMW3VgVYJsDwtGPTM3TfTimstZxN6DZ?=
 =?iso-8859-1?Q?PRTTVkPy06PtrkYcTiYCZbl2BBsvFPnjhalj/N0hWo7a26l57UOPwCFme5?=
 =?iso-8859-1?Q?x329Bqw4cUPAFxRzYfRarcCqLv8Hrb3694eO8KhfVmn9tFnJQDXSzvuSxl?=
 =?iso-8859-1?Q?c2XsDno77cTUBbkvuVtOA/O8/Ys120UwXCvlmaLEJmZkYpMuKFgBpjCfl9?=
 =?iso-8859-1?Q?349gKv97VfQzxXMxo0iVA2kRbPtOFmByZjns8XDFjiqiwoJWWlea7qLss0?=
 =?iso-8859-1?Q?GqBqRl21fKaZZKs9qQfF/cO8tXuhwn2nmmJR9TXR/EFJm1r+5Zphqg4vlJ?=
 =?iso-8859-1?Q?vk6G6MMO0ae1utRA1AHtnAmNEqKqsow2W1LfeHUFe4R24NKSvylnEYogT/?=
 =?iso-8859-1?Q?p8i2UQjo4QoT1arGOoqL9hjUhHx9yXQp1ChUsmAyTqKxv+pRJmMy0fxFLb?=
 =?iso-8859-1?Q?STAKqwBUCiG+kpuy4Do4jMS5Uz6SefFdih19L/7qd4OVGKwYDqTd5RWiVZ?=
 =?iso-8859-1?Q?LXYxBo2pFT05qoMiDD25NmGhWFSOK9Wb1i+sXmW+dpzhFFU99dc1qglcPH?=
 =?iso-8859-1?Q?RfQ9EgKbTjBLZfxNcPOxnLlxW8QG39LHCdy8rPonVhB5OcAuYq/gfLvvdm?=
 =?iso-8859-1?Q?juDpTW/3L+mty77wamZiCLLllGeYammwEraX0lHDatH5NyvsT1AC9sO6Bg?=
 =?iso-8859-1?Q?da6QU53f1LGDxYCs/BwYqtEkf6qd/OpCMpYo/ASoPAW2ngIjeHGTIK4W3c?=
 =?iso-8859-1?Q?0EEzVfXbYZrqGHG4iZcQz0SJzIUm3sTpJgtyS5UkewrPkJ2IXnrUYnUoWG?=
 =?iso-8859-1?Q?KPOXAMgwGEMq+4mWOm05gKdZeIfoM/YSjIWr9FqthjRv1TvUCc9M5F5mxm?=
 =?iso-8859-1?Q?vCgI8WpHl/x2xsc6F2yty+lXBUH8LZi/nHa8X+EWkaO9eJqb+U2D/YipxC?=
 =?iso-8859-1?Q?zqLryzqFdwv7Lrdcqjn5JHhUMm0YQcHxd4WM8PkrDFItcW9KeY9Wt8AfW9?=
 =?iso-8859-1?Q?E4SfCcvDLgW0631O9Pd8i71Hn50pih4UZIcWmwXEWtmv6ez3nS3Dvnh2s8?=
 =?iso-8859-1?Q?jLhJYtdUslw1dnUgVph5PW1casUqf7DLzHcd+A6LABAbNScE9PWLbA+0wQ?=
 =?iso-8859-1?Q?OlogN+vlnWa62Tjzlkpm0mFKF/3+YD+zgwHu05e0CRXvlirn90w1t8xXRS?=
 =?iso-8859-1?Q?MTqbIaCUdpL6gR/4CIGXCjd463tobq5qo6gdf4Ge4nIPgsyvKhLr/FeACk?=
 =?iso-8859-1?Q?U0n8dvvtvLvVJNaaMG4MNF8gDdU794sZ30phDGm48LlLGS/Bde2Abb2NnW?=
 =?iso-8859-1?Q?XiifcH6jBrETSMuJn40a0YXgBPMpXhsTvVkXzeVmTVJWNuwRpEQRMkuHRq?=
 =?iso-8859-1?Q?DHZ90kz1IPz2Yv5vgFsHIhYg+iiUQKC8DeXF5+8Cq8klF1L9areY+Nb5i/?=
 =?iso-8859-1?Q?nz+IueEURoIpQKOq0Q72evSF2SZODVQcliQsZXmDepH7DgeiA+3EfjPMpP?=
 =?iso-8859-1?Q?KH4wZajKHY/d384gbKpFIRYWFSUhZ/yi7FHSclWAVYjkaPdpcFrNB+aK8u?=
 =?iso-8859-1?Q?Re7+NmZ1EM58f/gj4KUHBGArE23F3TCmhUeRV2Qjhz87TmcqpZSSgT8WHc?=
 =?iso-8859-1?Q?OAfbStmwVnIHfvICDIDy+nM/OYWb63rPwvM+2IR3cFGAq+HRjzFtY3yxKr?=
 =?iso-8859-1?Q?cUfprmWXydgdVsmSGL4Ge22I09SN62c3wy05At0JqElGmVapmC2kiUFCZh?=
 =?iso-8859-1?Q?KOXe+tl7uA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SdGwmthoCRov0dIDwYsq6zW3dQd1thckA4jGTEiyHpMlTZsOcfgMDXGKzlIAsjHMseCLeL3001B+yW1SKbh9lVTi4qWgBUuVA/wkEQRS5yshKA/2dVCLtK1v+ViO/5Z4GlyjXpVc1WZwsv2oOhCi7fy1T1ViPk+LiMpy/tVv+ZVfLKEwpE5Fpp/eI19fr9nmNI7vSX1fZRjFBhSH79/yCgohcZvuQaahe3LxKxer2HwVUVDagL/J1b3SmZ0mrV1ZZzmHk6yG4n0dLQ1x4tVBE9BDkZ0lv1BMoxRxjL7mZ+wSdIaj4z3R9qwLIFJQQATvL1FyQ7K+RkvCPxB+MXlCnw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lu7xafo+htv4A1yTseycauXkp57THc0wFxczETJ0yjVqCFb38knL/8dhcOWgB3j++nEB0JhXtC/+35ruWQS/BJu4tkwanuUk4+/KMt2os1BARRqLe3L9urD4yP4dWEuUQcvHaEtzWfnKW5p0kCj8Cm5iC6OCAewF5Laa/Wswxh0vfHEQpzlaxylMervHeYS/5i47IxuvkwpJVmid4Gva00CJAMjsmrWdbXRfLnfLYySfkIUxhF41PYl0WhRmfKvFJq4HVgPAJ99zzM/GJ1KDSv6+nIgDhY9zFlcz4Ul2j/P3iCF7wkH1QrCR/amSp8ZQ0i8kh/NazXJLX3GeG67Xeug9WbB75l/pn8C16z0tvU8TvlB0qsmkl+N+APzMXQpi/vtIdZhkuce1lYkjVgcm5yY8Mnp8dP250QdFKynOP2qVargNJVEmxbH6ybdJUzVMHg7j9qS7aZH1LLtoky41eS2H56PfWmh7WnL4DXch6oFop6TIaW97FON84ONrPqLGXOviClLGuPFF3LlmoofGhZ/xVuXlp4qUXLzGxNvdEj8oIO1YR4iypn/DZqF5dY0t4120GbtcVgMo6DuseHqvOmBS1hIktG3e88qUu64Hn/oHb9ikAwzNpOM93ahXIkynQnjk7jBu6kRqghJt/Fnv1A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bbb85e-9afa-4fd9-2a37-08df0a2c5801
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:29:28.1017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTJZu8gAfEnVLw35qLhQndQF+8QnjMjoAAuv15jJDLEr49CP2vkdFZfDaWkEJ0qT89iA94VkrzZLn/YhgolIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
X-Proofpoint-ORIG-GUID: 1vuMRGukOfqdysyanQAiEkmA29k8Uxqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfXw6O7y6KMjtSf
 5zKrYU/JfV+YxPelgbet/Zt9rEM4hkvh/pVLG6IjLL3edLgf8W04kt5zL0mzOi/ACzfkLq4N4to
 jzxJCAdnPtE5FrKfH+NLTloeBpCAOIA/w1xwiONxWx9t1LiPWVvcCmOlvmbONT3ZFjMx66Rjdt9
 0UlSMJyz0PB5e+rhJ0HKbhS7Hd4gm/Y+7+neJl9bxaEv6xMSW3RUshcT+r86ndG6oZ2J2fBCSZh
 VnHI+BF3G91LUdR1rHu+FqvbkHpRGh/F4V0oDBPvld9Tj3tEW9rdwl5cKFfn5EOrGbzWvAhCjL1
 2/Fabj2b02yuzRixCwUon4wiIsz+BbPHhRYD2BWc5ZcvUKCzrYpkL+6VpBGAR0X/zTykXVrhBCM
 aQYopoGNaQ9tPWQ/gxq+bvEhUvNPbxgdgPtg/ag8u4oePC1ayX5HTNJMDDKc7fzIrhT/Y8nc9xd
 2KOO85CsSR0EAYsIGsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfX+r2ygBoG6M2z
 zCHZGXi27ivr/IVfuZgfVv13DcTzFIVnqY59ksZGFg05Ry636Wau1HbxZI9KW4AJkP3QpnYPgpK
 hqjido2ivwiCpPVRYWgKLuGBTqs1BvY=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a9a2d0c cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=UoMAnIRK8_7dL5_KUCQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 1vuMRGukOfqdysyanQAiEkmA29k8Uxqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
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

Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=3D15) to
storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
to select them when operating at SuperSpeed, and wire up ss_descriptors
in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.

Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v3:
 - Document and split the bMaxBurst calculation.
 - Require superspeed capability when selecting the SuperSpeed descriptor.

 Changes in v2:
 - Removed internal Reviewed-by tags

 drivers/usb/gadget/f_mass_storage.c | 28 ++++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mas=
s_storage.c
index 7eb667c130d2..baadb0d73785 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2226,14 +2226,16 @@ reset:
=20
 	/* Enable the endpoints */
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
+			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
+			&fsg_ss_bulk_in_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_in, d);
 	if (rc)
 		goto reset;
 	fsg->bulk_in_enabled =3D 1;
=20
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
+			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
+			&fsg_ss_bulk_out_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_out, d);
 	if (rc)
 		goto reset;
@@ -2654,6 +2656,7 @@ static void fsg_unbind(struct usb_configuration *c, s=
truct usb_function *f)
 	fsg_common_release(fsg->common);
 	free(fsg->function.descriptors);
 	free(fsg->function.hs_descriptors);
+	free(fsg->function.ss_descriptors);
 	kfree(fsg);
 }
=20
@@ -2709,6 +2712,27 @@ static int fsg_bind(struct usb_configuration *c, str=
uct usb_function *f)
 			return -ENOMEM;
 		}
 	}
+
+	if (gadget_is_superspeed(gadget)) {
+		unsigned int max_burst;
+
+		/* Calculate bMaxBurst, we know packet size is 1024 */
+		max_burst =3D min_t(unsigned int, FSG_BUFLEN / 1024, 15);
+
+		fsg_ss_bulk_in_desc.bEndpointAddress =3D
+			fsg_fs_bulk_in_desc.bEndpointAddress;
+		fsg_ss_bulk_in_comp_desc.bMaxBurst =3D max_burst;
+		fsg_ss_bulk_out_desc.bEndpointAddress =3D
+			fsg_fs_bulk_out_desc.bEndpointAddress;
+		fsg_ss_bulk_out_comp_desc.bMaxBurst =3D max_burst;
+		f->ss_descriptors =3D usb_copy_descriptors(fsg_ss_function);
+		if (unlikely(!f->ss_descriptors)) {
+			free(f->hs_descriptors);
+			free(f->descriptors);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
=20
 autoconf_fail:
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/stora=
ge_common.c
index 7e4b542f7ce5..75223fd9d518 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -531,11 +531,61 @@ static struct usb_descriptor_header *fsg_hs_function[=
] =3D {
 	NULL,
 };
=20
+/*
+ * USB 3.0 requires SuperSpeed descriptors
+ */
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_in_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_in_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_in_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_in_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_out_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_out_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_out_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_out_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_descriptor_header *fsg_ss_function[] =3D {
+#ifndef FSG_NO_OTG
+	(struct usb_descriptor_header *)&fsg_otg_desc,
+#endif
+	(struct usb_descriptor_header *)&fsg_intf_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_comp_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_comp_desc,
+	NULL,
+};
+
 /* Maxpacket and other transfer characteristics vary by speed. */
 static struct usb_endpoint_descriptor *
 fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
-		struct usb_endpoint_descriptor *hs)
+		struct usb_endpoint_descriptor *hs,
+		struct usb_endpoint_descriptor *ss)
 {
+	if (gadget_is_superspeed(g) && g->speed >=3D USB_SPEED_SUPER)
+		return ss;
 	if (gadget_is_dualspeed(g) && g->speed =3D=3D USB_SPEED_HIGH)
 		return hs;
 	return fs;
--=20
2.53.0
