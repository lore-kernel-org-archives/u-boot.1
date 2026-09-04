Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DACC61DD3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 05:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7D6560BE1;
	Fri,  4 Sep 2026 05:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeXnc9BDNijj; Fri,  4 Sep 2026 05:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7014B60BCE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788498413;
	b=LZX1/mdAbKYbWf+W2jps0e7WUKdlqS4NLo+WjqN1w8v9WBh7LHI3FTztDxuOjOXdrSu1
	 6kwvwG8tt5JDac36lS/00Gh8QOF0c+d3+X8g8rSQ4mRWfz/lce71D+C1lVH9giozuD7j0
	 FNC3+IymiTzqd4zNbwxJ6HXGqucEiKg4T7fBVk82UkDbo3EkrPdIDE+9Wj3eoMrNTYq3s
	 89elOTXpLIWom6x1tfy3hOhYOXifqRWhLvVIfpZ3GQ9uaQiqWqQVsXJcOdxK3VGlNN8pz
	 I60EF3tOBc8JuoBVqs7+ddhOq+3AlNubcKiCF03nR0+v475rV+ygZ8acvh7KhAOwu8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788498413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MJXVW+wQ/FKC2O5AXw8tB/TgSu88EAHiKe9VAEvLYKA=;
	b=EO+Sydiz0k0QguAvhOBScSt9mPp2P14dQP4FyEIt+osRw3VqZUhovSLfQ1/XZwRjcNX7
	 Ywxu1K7dZk2WKR7+8Wo/IV4pznb9FjxWLZPs1PR6I0M4Y5XKnMiy/UVTji6P+f+lwh3qa
	 mN4pNhNxfrRGfavBTDVJF3N2UEf7ImayCcJ4r3bxTspOeXkIfl1RVKXNnn1qXFB5Wre3Q
	 led8iJKR+F1OdMfh00FBkAbRCV6dfFAxq2FzT4ddsJtRPO6SBzLxnw/kdAjt7SvwHddvN
	 q42TV8adlQ3ltQSCCZVm4fiZMEMxnLxRRTljHV+OPV5TOLVg2zUacF6IF9pKX0QpCbw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=K49dIwdH;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=gooDj3t4;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bpMN8ybw;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788498413;
	bh=MJXVW+wQ/FKC2O5AXw8tB/TgSu88EAHiKe9VAEvLYKA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R7AkS3LRNZSKGBrYGqJtuiCSNbDQbNELOiHqsRlODr+XCKspUFg5j7bPKarFZCSnf
	 USfED3jP+eipVLFwk3W2wU5m7jG9zS8JN2izVnuGXGS0l7CUqfx1b16t/WD3zAGM3p
	 CCb6RmsaR4k7EUAKiYb+GDhTT2jpBUh9ee0+NItOFIE2PmIauJiVNR3gvJ9HWfIwm1
	 hE3tY+yA0QGTmA0P2b7Y6KtFMqp/NzgCBeqJ32amSNYm7a+wGTuCFvIcnPug8B1gn/
	 BzGr37zvd906CqtF4wR9VanTWWBJBclJYQX5857qEjG94OkU33SxwvHGaMBuYHRut/
	 gZVZ31XYiaKVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7014B60BCE;
	Fri,  4 Sep 2026 05:06:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4A722FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA3ED607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdEhrHo0YCs0 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 04:28:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1BD8B6078B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788496135;
 b=sz9gC6Zj9y/4xn/X5GdbXbuR3/o1+WKhMeqZXfyjw/WZvK/Pm942vcC3hpynOaS+Idyn
 rwowUB+sXDi/2Bc2pe8ITT+NwIM1mfkuzUQ+tmdF2w4WdCf3YENFk8jg2CgCwJt99hXas
 UN/PZElb7g40WawzUBGxjqHg2yfua/gFvIsQIUEdYqwWCPhchiMw4W+fvs5a5E7IVumsz
 AkEBF8NzWFvhoeSz5Cn53dS3VnO4xT/e6vpdEyNelBuuvPuvezp+6/6abwetZc3nxlzZI
 X4cGb4dyChaLkSHGxpVrqTUM2y9bfWpBwW2s2LT6hLacuZUqyH4CIegRy0MlOwWUJiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788496135;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:Received:DKIM-Signature:Received:Received:
 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=MJXVW+wQ/FKC2O5AXw8tB/TgSu88EAHiKe9VAEvLYKA=;
 b=UDhV6CIbu1BuvsZoDsKViNoj7K2Mka+1qjxvJNeFE1ViU7ALQ8bwHxn6x2IXBXL0NZmo
 ymjJRXfIjJ+nx4HJMgX4K6qTRNLvUh6RoBuacOuptLd4QphSrqwMt6wAVZggYxXnBWj4Z
 b/NbLyl3za7nFQwbM9z8XVEQ55HfYcYs9to1lqDP6xaDEjPaFH22QgyPZUil1FxR19k8a
 ZxuQq52bkVMMc7n0FH4MKnxmLWscHC7hSYXXLQpHU0+BM+b7H/gfhSSfZrN/xiBUzDj8p
 6sxLDA2w3swyyo+SBAnz2U3qZBDIQ83S2KM1eS/0Nu3AP7J7w0NnGZ1zv2ayhIpOy4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=synopsys.com; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=pfptdkimsnps header.b=K49dIwdH; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=gooDj3t4; 
 dkim=fail reason="signature verification failed" header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1
 header.b=bpMN8ybw; 
 arc=fail smtp.remote-ip=148.163.158.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=K49dIwdH; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=gooDj3t4; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=bpMN8ybw
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BD8B6078B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 04:28:52 +0000 (UTC)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683NeBgx912168; Thu, 3 Sep 2026 19:29:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfptdkimsnps; bh=MJXVW+wQ/FKC2O5AXw8
 tB/TgSu88EAHiKe9VAEvLYKA=; b=K49dIwdHXne3VFlf4onixaRyK6DFk+H5D8B
 drpN8JRx4kZ75Z5ExMh/CF04UVT0Sq+3JoQYL5BNz5O80KR+416gBPV3DK4AZonD
 lmVDdpLFxtiJPjY+iRlkb3j8O55TBCxmTtYd6BXH4K5iL7ic+R54VpjO4wfreWlb
 YpFzSl1cHKxozwmrABpSTw57ixSwJVgOn/BweuO9DlIbrMXdDI4f5qL+7UkSKnnH
 pcZG0D3zzo8XhzZDB7a/xD43OcE2QfT2RfyHdwStC2r3oM7SqGSsvPL5FHczFz+p
 D7Tom6/nvDsPaEIm4gbjAr+m2ZaHcPJT4+yiD4mWrWSwnRbgM7Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gf9gjpm7b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1788488968; bh=qvJlH92ACWNTPCGndauHnr3RT8JF+Z3QKBPbYtqcuK4=;
 h=From:To:CC:Subject:Date:From;
 b=gooDj3t4NdKJk4LcYp/LgMj4Yxaez9gkhQPgpTkm6MMxg4zyPBnZPF2ypu3bzs+Tb
 N2Vx958Vr3mXPbwUMKC3bz0qqVkNzOMdHzEFWm8cQwC9TnHh6GUCSB3Le0A2tUXUFP
 I2BSqFKWQmoZmzG7NYA7lvnVSF7rk5nCsG8uZ4PodoWSHOjpdKwvLd5SPK1aNLs/qV
 EELNpkuRGZN1WpbvT0wI+Qm+PBVz4i8RdTiRnvRmEqfbGdst6jce8TFbi1SatoqUyF
 gKd2JJ2bYHfO46ZFC2B0Ol9BZtzWQvQofdRTa2MwXQXYsWdeWWBHAUOouXpOr7A0Ng
 96Rx6hFiI6VDQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com
 [10.205.2.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1C9C401E8;
 Fri,  4 Sep 2026 02:29:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 511F7A0E6B;
 Fri,  4 Sep 2026 02:29:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=bpMN8ybw; 
 dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com
 (mail-bl0pr07cu00102.outbound.protection.outlook.com [40.93.4.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (not verified))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 079BC4011C;
 Fri,  4 Sep 2026 02:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Agr0SsOg4DSzP/wIjfu3VQgFyzdoLONfwNP36XgXk7Q7DHnM7ImMs4TPhHv7oJb6C3jIV+ABoN3wrwuC3DAl2KjF3xf1HQk0vd/iXhUFnnQnrJhqCFOjykWGx3FCKnvQfVRvo8Kwc7OHHQnzsA+Zuu8u8dRe2adqs7ofbteACuDDs8EhWUfs5FbiB+Qj6JgEUrrF4qJUaoM1T6Ik0fkkVdCd41fnFa+CJwBcDzXHYzIGgCqguLg10Pn+TRiIUOKbBMj3UR1nUTeyCqWqaaiTQJXxr2prbQaYT6K4zBQv0HhYvYNa/CeM/STIKfApcyVmTqvH4Wi03ATPtFq47zUAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJXVW+wQ/FKC2O5AXw8tB/TgSu88EAHiKe9VAEvLYKA=;
 b=wWzn0F9cR5sk6a6dVePOXNkAUma/ms3XiRbvHFB53a663HgexHakJL1xV+u57Jq1a/e8w4M9OVFH1PbkQCTY8Z5kxlG8ORqegjJ7Ei5eDKdj62OfaB2w3uAgJie/gNJOENwHQ7+rUkJ1Zkto1r5f0q4lzhtygQoDC/wwaLVcp7r10Eofmn75KQLXpPy4+qIphsqPbzgUL2B2wqDAjsVXmbjx08nvUln8yl4E+5mJPpqNublYLS10jgoSa/fyQqeauuNRS52d0+OiQfUa3ceZtK/UnncZHCYXokAHRqy8OaOU+togzczpONugvhHQx/2mqParZHzRtAP3MOpvK5khFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJXVW+wQ/FKC2O5AXw8tB/TgSu88EAHiKe9VAEvLYKA=;
 b=bpMN8ybw2qtGymz2eu2aeAfG0DJAXkDsnzmlDz1IGcXviHlR+cavVJ5M4bYpsaurdmzzvPdzNmRFgcfQRp2KqKA+wy94Jot+8r5atQJavkyDRupnS8ItoYtSINJPfAvvCbp/SdLGDWQRyPEmqz/CPrsi2okWBq4QM2oXwL0PXXs=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:29:22 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:29:22 +0000
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
Subject: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Topic: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Index: AQHdPBUy4ti99ufG6E6pK0/WcV446w==
Date: Fri, 4 Sep 2026 02:29:22 +0000
Message-ID: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|EA3PR12MB828978:EE_
x-ms-office365-filtering-correlation-id: acbed167-c3fb-42a6-e6a6-08df0a2c54a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|6133799003|18002099003;
x-microsoft-antispam-message-info: zdPcMkG6sx9TSiYos6p+8w4xUGTHGbi3l8A1EZBHzAVtrqpuBG/z/hMxSLbUjzifn6kAxhjfqEihsDQhfEgzTJJqn4ptZVz4Q5efnKcT9iEQ377HmBMGLEXPYp8O/DCGsPE8hLyCpxD/IRPVFf16MYI1hO/h8118mpXGjq7fJwU+eHoLi0caB93Qds+dnraMNJGvjBJn+nURMgBXsjMHvEi2QVK6xm4e4ewJ02iNatAS8Ps0Zvc6VuwB71ijMJNXnbFNm4j/dKSIjmnD8NJfQ2DzB8dlExwLv7TUGwM/N1YYgm1RJIRCz7Wxin1aNbYpRYncQbgsV4yTdSoaMH4GLNDG5FLbqkPiOMMXiohHaZPu901fyLX6H7qNy9iPe8YXbvuzjMd8D2ngs9YYh0PkB7bqhJqXEEV4uC7bMq0dlhWIoAyvB/0gFKT51KpZcJHCSjWE92Rr1kP9NzRxF2itS8/Cv6N0i7P3M5J3CGKgdX0hxYmjnO2uCTZAMlZY/+VO0o6m+9h+qG12BfvzBl+pko7qdgUVRJX1C17pJDt2JlnGH8fcXQAHoKuKa8bi/oN/yncHUzqw/PR/ImUSAi9E/tMzD8ZA/FUouRvxW663WBwhDMlvlMkKXWefd5Xp5LjOjl+p+/wF7bNN+qyh2AWBsax3KffblEZzoeF9SOjSqo5tUgor/cCtI226CTtnRrrKyncJwud8KQN778tazwmGskWMn7FGhw6+rX4fDKv7Ukg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zW7lI6Vqub5f5yLuxMr8xZPnWI5rkNq2wAJe5P32vA+VJMFOHneJnE1jRd?=
 =?iso-8859-1?Q?nuquLKhN+QcQihTKeTo7ds9rnL/4YwjoxxbSjFJFSyAUy1TrEQDWOAWoLA?=
 =?iso-8859-1?Q?5wLrYFgP0fGJ6kRkFg2UxvuBXQYDq7eWyiWuE467oEYDhWo8Y2TrQmAaPH?=
 =?iso-8859-1?Q?9oYMiauZQ4qM5DLQc94sCvaj/K5v39HZQCsYvieVqyXKshdOjypMJXJvs7?=
 =?iso-8859-1?Q?xuZNGB/DHGe4WNv7HzoJjTFW9pXj+4AIy0JRbCk8Q7skmj5YPcZwTrOcgg?=
 =?iso-8859-1?Q?HdJ1z7olEahg72DSm1l2E6DsKKh6wADLXh0+e3lFzT+E+fpfpHgC+OkrJo?=
 =?iso-8859-1?Q?crTygsoGlEpCOyEKL40/GjSAe4rzL9/gj1IkPehv+5kBstVC2XRpEk26rq?=
 =?iso-8859-1?Q?FuiApUgvYDGHAGKwdm8RsSNZ3uc5WD/2LBKzMu9FjVdSBXzMEXPgMDKrUr?=
 =?iso-8859-1?Q?NSPfBgqm85fQSy4J1WQ4raMagkw0KMiPRZ3gHXviyLHopDhrDsnuOsauHb?=
 =?iso-8859-1?Q?NB6/Xxz8HCqm0BFZNVoKUEbf9gY3n4ucGx2OdrQC8ew0VhBDZo8HkMCmJO?=
 =?iso-8859-1?Q?3xXTLZje3Qq7mTWBAvNjXQyt21cq9bb8jUz2ffY9qQF1Bnb05w5jUPGQ9V?=
 =?iso-8859-1?Q?eHhSfOUJtDi9rUA/SxTtQ1nrOojVGaWaGVgaKPvUp1rTM0Oy65+NmtCbCu?=
 =?iso-8859-1?Q?LqoIzlwlrUikSqgLd6I1KuKf4pgWSEdKga/CLLFDtMX1qTKuNaio6Z1S9N?=
 =?iso-8859-1?Q?ovdpi5x99NtPxgX278jlxRRFCAcPqCAzVtyvl0dZN5XnsfSikr0KU3LW5L?=
 =?iso-8859-1?Q?6VnZzfIWh9H1B69Wa25af/KLxrNv8AJR0l0gVy1j7G0cFGyEhItkM+AbK/?=
 =?iso-8859-1?Q?1CJpMUrYvcC6aDUEqzxyoLmCVO+cLnRg/T2S8Iu3LB/+BwTyzaL82qh+P2?=
 =?iso-8859-1?Q?IZxczHs3cdrZ10hIAmt1sRVHbJdLimERazCafKXPIndJ0DjuscMKeONKdc?=
 =?iso-8859-1?Q?iWuqoA8avJEMnqQPsdDRXY/+Mm1B+T2iDJFJNk7IxUhdvXb+S26hB1MZg1?=
 =?iso-8859-1?Q?CpHNkyM6V8PTl74gECrnmV+7GK206R3Q0Ey0zbv137ubeyfknBklnrl5rc?=
 =?iso-8859-1?Q?AkmpvJuPCBXNuYhad3zS2DbcWpQyjHEvJHdKrrWE/c2f77WRJQigDh+SZr?=
 =?iso-8859-1?Q?UCOEM7/lW2AIwmwRLSfkYVTq8SjC3pWlXxXw3DYHNfddiFNGSGD04ZysU+?=
 =?iso-8859-1?Q?BFw2Kl2x+gCYjWQ+hH/YbLlb4hXSS44yST7VmJZRX6+gd9dM4M9LeX3hKl?=
 =?iso-8859-1?Q?u55WXXfX7+cJ2gu9fb8Owz62c1uJ0Cm5UEHrlvNRfp7Oysig/b8FRjWvjJ?=
 =?iso-8859-1?Q?yHi0LV/QpL0E3JSS52h6MwgeQ5dCa5MMMg2hhDbl+HGkEQffBpDBP10TjH?=
 =?iso-8859-1?Q?EkZTN2d6JJEdmqYV1wzYr1ftcrld1WcFKF2apWJxGFk6TsvnxdUBeYengm?=
 =?iso-8859-1?Q?vxRxybrUm4dJmVbc/3YSbfC1hjwCuvVc9nzczwXFVVkaPLf6bHx2ePbz+o?=
 =?iso-8859-1?Q?Rg/aVJ3NlyjnD5BkEJeDOLrOq7UF0DN/CmWdcVC2gGA/SIBTo208I0YlQo?=
 =?iso-8859-1?Q?FQ3EY7Gm6S3H0pcAt6k9/YIpLNuvyW9/etQNS7tKGywgtE2Dqf26ncuDEo?=
 =?iso-8859-1?Q?Vw3WUn/bpRjnsL1zNam3lfezcBw/vhxpOe7V0HU/W9pYrMWvSJdKPoc2Zj?=
 =?iso-8859-1?Q?eWdmWdmZI94TQ1goj8zqpJacWLmiwUTuJfpDybNM4y0vyCvGOjp6JpqWeF?=
 =?iso-8859-1?Q?pIPAj06JmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QhfwmJF3iYOL8LpSf++H3CnKhOPpvmXg+ZxNO4BN3OclUPk+Ew0ACk0hMEt7jX+5usGOOtAWQdAoEQjIZSI7Ddas9f6GKuIT7wcneQXDtI1kM4xI7xbDBIfcVkbpKI9pSRuOGfuO1pebQHJtKHfgcjcN1/AeErR6Py16B4kQvOL9g+f/8RalJ/S/jVQmXBxjG91WBTBEZLuRMbE1xfpfNyimxVC9shJBNA17u/tatj9I5NQSvD769+5B6oAu3UyQTK4Q53pCps9kEQ5oSzsG8kjorJlAbeMomfMGJ3wyKO7wjKQ10jDzy1C0YEVNkWTplbFubQjJz4Yg3o6tOSdTyA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ocASH++44u1/7H1JQFRvovGFRq3tzYm24WOrjLkQIeObhtTscdZXFf02L7J5Tna1iabzh9uQfEkoLgJpmmm78fb+o2YCiM/AgCS6vi52IGVvMvZGM4SS371DLacPlkoWbEVFpivNSq/zZhDAxYQgBMrJVcmMG8JOTHQ/vYoNbBt7Lgqfxw/1ycUSnsu+xpJsDm8K+F9NwMRWUL/7vWozF4IOCnDv/MsKF+LFG/gy0jZFFz7jCSDlNSXXEz7oUURIp1KyPVEbinLlPjq00K+MnTv4wMPs4uIT/LPKLk8PFMVvXYq3n5LL+jsSWLnzwhMIN2wPjs7oYI82I5doLO31Bsp+J1YG7CXcpyvnSvdWsuf3FNCluUcanAYDfD6Q3wzZW66uy4VkFhkcc+VQ5oO9v5rreJuwQgdoKx3Lg9R3gppca60APqNetqxHjRpjryzOZeO2kUtPgbykHXure8+gsyTOmpNrKCtCjIf0dzi4M7Ms2XqFfD42eXBAheRytHI7ok8Qf3ivbscE3XUBVmveENy6hJ6wyrOV7R0d2Qr50LLBmAz/0fN5jDNmw8WqhiF/1ndQuSoBzwPuLXSrLplkg7u3dONR4oXuqSU0YAZcH64vy4sj1BLMHqrYxGNJxcjqq3QRVCb87K+fnPzB4GsshA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbed167-c3fb-42a6-e6a6-08df0a2c54a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:29:22.4212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ky8Ed1WWhYVAiAMMWMjp9jYxvrn5HvL+mRecEZVbSzQRfVYr5Jo6Zulx6KDY6S1kg0JXseGY91mPwQzt00gLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
X-Proofpoint-ORIG-GUID: WaUo6LsreLegLFP1nILBShH3goUY8y0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfX4mrk1LXySPQH
 J2Lrb4EfU/OaqS1kKtnkzBisLkaeGclZu+R+0eIrAt1DdNUEmGx/J5dcgJsAGfSMq49MfDPFho+
 2evb9GoEJZlGrvxNCPm4TB3xKBFYG67uuVVcVs//aEFWDD7aVaele/XinEiyaCjDu9DgcJRfKR8
 ErNiTChtSq2uHlpiiRhcPTSQRF8Ze+HFPoycIqeButKNcQlFlQdaaBOhzUXa1t6vhRNE10Swa3i
 vYZ2eadVWET+pMD/W981OQPow3knGdzCwh0zp4E6eTCZ6z1L/zBavb7MkpIItxyXi/0n8t+iq/5
 lLs/7w0v3VtGMzmHpxEX6QilXK7HBG4reXQMMTWKqmon9SN0nMThbsiS9rpYOmHdrAz0q54OfSY
 nDz8H0kaZDNmCBv7GJMTmN5f5xQ3alnpHCP6eQfgZzOccQLxSzE+1aXOUi5+139ZW2wChPIa+NW
 Lh04cqw2108192vehJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyMCBTYWx0ZWRfX17OGdW/UrM2x
 D2praDTFUKTgSjZB7E4sK6psIWCpFQP65LVAMDgK8bCsYicFZX5FR3kgH3qwF/ifNFC35RNLZke
 056L2/yJlhVr9xDDwJ11b7OHGpED09U=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a9a2d09 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=3FhGs3WUeaINx9rcAAoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: WaUo6LsreLegLFP1nILBShH3goUY8y0H
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

This series adds SuperSpeed descriptor support for the mass_storage and DFU
gadget functions so they can operate correctly at SuperSpeed.


Dan Tran (2):
  usb: gadget: mass_storage: add SuperSpeed descriptor support
  usb: gadget: dfu: add SuperSpeed descriptor support

 drivers/usb/gadget/f_dfu.c          |  3 ++
 drivers/usb/gadget/f_mass_storage.c | 28 ++++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)


base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
--=20
2.53.0
