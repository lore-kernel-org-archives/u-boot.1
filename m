Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2532EC79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 05:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31801406D4;
	Wed,  9 Sep 2026 05:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvR7d6_JVCGg; Wed,  9 Sep 2026 05:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E590A406E1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788930659;
	b=eDiVKKSCIbu1QrAtI+6+Xmqgl0RjeDkmh7TApKkRch775ox3SPYJR9WqO9vK5Wd14ZAM
	 unEj8lzmDuD0JsraMRHX/o3IeaAaTXxb8PvT+2rCWl2Mr7nL5dldBnl7ErSYKgGoU4xZd
	 h4vDhh8EHOcy5gKJZD2q0Sa2RuvpoiWB38D6gg6B4nAAaAlm/38PvWgAgCSJh5Y48sxr6
	 WuITfnryzQA47MLeLL96uFsmXTLJz+T942lc/7AxIQkfEkm3NPp0Op1qdS5jjnCtqFQcK
	 MUOZaFrj4l3TdtaSYz0Qiywd9hHPl0L7YbX1bYXV9CkDzR9foIBWC4jZUe/EdpaEY/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788930659;
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
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
	b=ockXzZtkYBQjHkVOOn2Luko6Fy2stGqDyCkq8EolMARHdT8JA14DsOzW0FTSYq8fywcc
	 DeV/KeQsUvZSdAxO8n1Q8LbZCMKsThTpEoEhoSrA3nS662SS6BgDyrRKYsxbjjt3gJUCQ
	 EHRjL6z/AiWR1yQD00Xh8GnA8NByUZ6myBmJWnq68Q9QaLm5WeoGtWr6sGxl54XMVb9XX
	 xw7L67+bxDheR9iVvvVcyjTbZ7AC++k+ds3z6Zi+/4io+YsOtezxzcdPOiZ4AGVnNMHQw
	 Isv6XcDoTLHAgzwVXlpOzCoEhixfdqmr3Gi6Vbzx+pgDLBJo3WQ2mY23Q+Ey9S/2C0A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788930659;
	bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHqigAD94+oUYU+mREDpYyTzHBaJPTmklzqjJIZDZ64E4shiqSt4hNeXW0Z06ZLj5
	 h1O7vR5GTEXpBiOcCOUiy9I6332qr0fwUw+ETlDwxm8n8HLh2BXjhJERo5NPSR5XH5
	 tGk7h0YuEvTZvBdzHmtR8U1fe1m1mwoIO3x5NlGRxNZsn4mqjq55lldqLtlDCcqaBn
	 dQW0OxHyhnQSkb1DvQcUirQguRRAkY+aqKYUsA5K2H8ov5pS0epsvc/53u7Ak5HAxb
	 Wff8tveA+LZAXy6BrccV5UacnJOlfLuTtsEVFfDFozsSgMTu3i6XrAxRyBijYnbZgF
	 si2tDAoaLLcEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E590A406E1;
	Wed,  9 Sep 2026 05:10:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA7D2D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 01:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 503D940059
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 01:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZizYT20KH9W for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 01:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 64AD640055
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788919143;
 b=oh8QAaMEahchwl53sxiGsFLS+bU6cvsydsX6r0WaoMc2teouXbKgvKenW4p2P2j2dHIL
 dHMMkCPmQ+v8Q2lS1bvo/PbCwjxVWPAjUvt12JZVUd6HKEBjCboNqtUWgK/jl9ubt1fxX
 /B1olzYJaQUbHB9zzzsoTDqjnBtTlYLp3i7hVuemDGNUlH+yhW7Ycg59D2Q2NLAldQoMr
 GwksIGdMPteAEU7w5flGxSRo20LNn6yoXnRfNs4HhRicOoMthukTBArYFZwQTozR36YJp
 7QN4klk7kxQOo9JdJxZDA+AUkq8VwdrxbZWnrcs+oFTqwuqNI5hB8FXOhOwK3jRIyrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788919143;
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
 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
 b=FkABJ+MepOtVbvq8bv3l2qGr6Ef+yNBa3ToTp2y/i9V5yGRryXlHK+l7iRcQgASWD3ny
 iczxrXT+Rs4fnYbnVsag2r4cVSnEnUUsmkITVXGda3MNSJE6qaXmQ9kokmut5LQNrh890
 Bmh2oirwJlWH8e0RyReiygkN0fvCsbI2y+qgaTUjLhJzdOVklLKAzqEmbBOCi9zuUX4jU
 zUtwdwL5fBNQGWrLu4zXtUmy2mp6ISzbq6DPaEzQAb40C67V8pQ3t/dG5gz7oSkTFex1d
 owCRdD4qM+kw2iy5yzZn1rEOp7tu9F20sMrCLaA31fBa/LUIG24lO9/Un2+AdcqimzQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=synopsys.com; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=pfptdkimsnps header.b=Gr0gqcsk; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=I43K4Vwr; 
 dkim=fail reason="signature verification failed" header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1
 header.b=MrXL4+Rk; 
 arc=fail smtp.remote-ip=148.163.158.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=Gr0gqcsk; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=I43K4Vwr; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=MrXL4+Rk
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64AD640055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 01:59:01 +0000 (UTC)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688NkaZF3944692; Tue, 8 Sep 2026 18:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pfptdkimsnps; bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=; b=
 Gr0gqcskPoYAoogR0zCv4n6v73Q4RBhaMXlzNoCHvQaqDpjok1XZNnZj9jDmxJPx
 solTgQDX81mWxndhd7IUM5+vmcnAADVb8Lxf9dFQw2S16cASgmpKuQH2g7x3WSkG
 LN48jWfJR9dQxPfLfWvXS3mdSJOzX1YfH/s/aSH5CJ4LOay34X9F5PCJnbEUino+
 2i6g7SCpEwILcdOTtDyGq1Il086FBYkDGRIlzLPQb2WyGIOR205esjjcYmQoK2xR
 fg4OkoeqooDj9nHct6bJBQCJt/GFztonf04iH1zg22RQyI9XJ4Qfy8Yy/F38/Gul
 iMCRMELWQVNcZRXSRGvauw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gjmxkctj5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1788919127; bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=I43K4Vwr32YNYTTrQZQ1v1ldlcmjo3SeIFrn+pCYtzam31mLFXQ1eaXoA9xe1bRfI
 HIT2uI4xBwH7JK/517xSt0XRsQo/sKQ8i5/cg1e6xibC9Y3VdwtDQ5GXm2+aXJ/9rY
 eKwpA5JNFNthPL5ZwQpx8Vg8I2QUjpDUmNNMX/8Mwr3OSyeNd1YQRFLMIOiGm+gnXc
 2xfkK9ZH1r+p06jB81bzWQxOt55y5YVadImiLmgEMPzHP7Q3V/PjRsinXuVRv+TvB3
 3Bbfc3yLiTreKS9j33WQcRlQ4Qt4O4Yh6jW5YlORccUtL6uaZWFcJ29riY0FsumW6f
 LVIeOrVXqxlUg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com
 [10.192.0.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB15A40213;
 Wed,  9 Sep 2026 01:58:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com
 [10.202.1.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 1B144A0087;
 Wed,  9 Sep 2026 01:58:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=MrXL4+Rk; 
 dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com
 (mail-sj0pr08cu00107.outbound.protection.outlook.com [40.93.1.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (not verified))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0F441404CF;
 Wed,  9 Sep 2026 01:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVmUuxqkQPTo7GqlhNBPKJkwYYAP77tV7f9RQsDG5GRIZNl3Q92m1i5vHKxcY3W5mM6cRWZTRZiDfq6KousnOcslhPQPtKkZwpPpxSR/Mw3/8UpRtpuam2yeSAzRSDh/EEc038xVB/1sIY0liyaXYoDxk0UZkOZKbnY99DwQ5llqA/0s/7JfdeCegKXLiVuiwlLVfA/d+p3/hOoKApEUafqRp57T0SpW0jxNHu1CxNRHLRUbYhjltf4norSieeLJ2OpLWxTIoPQHw5CgvJK5nMQx0w9U0ZO6QVKMSPHn+tMAI8JGOyKPXbZrOMr7/t3iFFLS+L9D8+fo8yFcv/9RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
 b=rDzq0BXsXZipKJ76NR8lOlYPDULp2frSQAuf0wjLm3adEwDZwaaBe+34pT5BbBc6VN4Kk8BBBtQEg0ljrehgMWJL6wPo3pkb9qFBGXh9yf8jj4JymF2vYsxWDisvwG3S2k9T7t+KEd/vVd1ASPUjTx8UgTJPkS+nP5qP5ao3ytvGE2SZr71ur9hk5fG0teW4n1aTp9NXn5x1JcFBG1K+ns+QIZX1aqLH8v6AhwMUTvYrrP7hDO6FV0zrfHhQWLiwRzL7VUyvADOZFnWUbymiyM3syIRJIFacHLPFumfqfTQ2AVgw7EW1TCQbj+iXdUaiKOQJ0Y9OKln9n4JrKzDndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhBG/4SqYQOOOEYJIfwaibLi4SuFtdq+2U//BzvAVn4=;
 b=MrXL4+RkpFLZ3Ci13z3pMqbIuzHaRr0l+RHyW5Ixb2xywEVtbiubYg5mGcSjTZHJ/Aoqtt4+XdR62alGyRrLF6xcy4GqoLRE1XbBADkY/b2hZXTcW/ueMY0CBdOw2Q1flvNpKXTYfkWbhVAYUKSn7laeFfNzVNIu+ayS2ndMPzI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 01:58:37 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 01:58:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 =?utf-8?B?xYF1a2FzeiBNYWpld3NraQ==?= <lukma@nabladev.com>,
 Dan Tran <Dan.Tran1@synopsys.com>
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Topic: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Index: AQHdPBU1i9VqyCinQ0qidgotC63alra9tksAgAfO+oA=
Date: Wed, 9 Sep 2026 01:58:34 +0000
Message-ID: <aqC8hnAHrQ8Cv3iR@vbox>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
 <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org>
In-Reply-To: <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|SJ0PR12MB7008:EE_
x-ms-office365-filtering-correlation-id: daf3036f-60af-4082-3331-08df0e15db08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|4143699003|5023799004|11063799006|10067099003;
x-microsoft-antispam-message-info: CxYNWsam63W8bM2w7oTzMvsEe2hCygli77YMMFs47aMxn0og26UFsC8YE6E7CYgnP50NGu5taZeLD/m+ogPq3yzOVYs7tUDgr+X3sHc7SPxyZY5+2aLq+GOWBQ5Q84K2sz75CjRHSMSCvvbo8+eOg6RkIwmIPPlYdcdWSRVPOETJMQvMqi/OhW5l8qJmpDmzcpbzXHWYI4q2t82GLus9DaGaypNb5+IPwGZ/b+4TckpVlFOptUtfnTMcPHIe6GaeKP1nQ6u2zMpocSEFTHLjARgpBvo0c/L4cok+jVrFfUcU4S1f0p5Zshw3VteEviukEwxs8WwIq73Q0Aql/ABWzO7cQO++rxbG4ZRWtz+l4Pgz/A4H9RrFPcJs8qRi2AqSJH4Tl01W3Sy3/ktzY7+8hKB1W9Rbzl2w1yF2GVZJhmwaOvbxaI5CSd5Zn/ApHM34zB7basGtosFv5vr6vwv6JXmKZPi9SGo+jgNGl7+/io+oZg/VCG4ER56h7GTUI0VAan6iQOXpE5oa9sG8KcrDQEm6hVG9pLz1WrC5k4+5/LJo5noW1brUaQlyvLsnlVfQeN0AwNt2otKh8JKYgM67w9hCPBu66tj3ZnaUXEgLmsxKQA5ar/wK014mwaDFh4qweOYgYLoI2GkDbYR9Dbbrmp/Um7nXxDYuEWDQmQkv5+yExqCEp/MqxCe3xWmAc8yETK/WVc0504CoyydhRK+NRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVV4UlF3U25ycXVxY1hicXRkN2xRNktxVEZKQjByMThIM0t6S1h2U3NEUCtR?=
 =?utf-8?B?Tk9kZTVPTVVMTWpRSTVTMVFWeEUyN2RDT0M1TklMdE9idmxCR1I2dXRrZVh4?=
 =?utf-8?B?YmRHcUNjM0RMRXhRU0R0ODlicHVVcUNSbDlLYUF4cmtkNDQyMThrWEpmenBt?=
 =?utf-8?B?aVpTK3c3SnRFSi9yNnZCRnhjMjd5cUlHNGd3YVpIcVJvSTBPMG82aFgvWGVM?=
 =?utf-8?B?ZlIydVNIRy9rK1RTWmhvSkZmTEkxUG5LUWM0QXkxZFB0RDEvcmxpaHlqN1lY?=
 =?utf-8?B?eXFWTmoxWDdCY1ljd0l6WGk5U1JjR01wT2RBN1hIWTBXWldnU0NqdHpaa3NR?=
 =?utf-8?B?dnVDNW11WVovTjZSUVRKZUloVXZvN0twcVJ1SE92T2VMK2YwcU9vZmRQU01l?=
 =?utf-8?B?SElCRWJzL09wTU8yUllWTXFJc1JmL0JucFBkWkR3aHl2bkFaUVdMRnN3dTRY?=
 =?utf-8?B?YUx3UTFGbUNnaURnVXdnd05yVGUzQlFqZlZqN1JnVG85eUZGbExBMkwyWEtn?=
 =?utf-8?B?M3NDR0o4RW1ZMFk0RDgySGduMnRXeXBnVDBWWGl5RWt5UllTM1lDRjNNNFdX?=
 =?utf-8?B?TUdQWjNHZFdxT3pUOWpaWVhDTzVYQWVHcEE2cG9VdGVQUUEwS0p4TUlyck9W?=
 =?utf-8?B?cnRpbFBzd1pBNVhWanhaRHViNDQvTW02eEVWeUMyc3JPZ0xvdlVNcXNvQUdU?=
 =?utf-8?B?VHRYenZHTUdtRklFY0wrNmg2aTN4UXR6U2RQUFNnUVhIZ01kaFVOVzhrTFZU?=
 =?utf-8?B?ZHVacTNtOWlUTWs1b1l2dzhKVTltVVhURkNONU1QSjVvSGttNHRnWmhQQ0hK?=
 =?utf-8?B?OVdsOUxva0dpZ2xZOEdtTmtoMGVhaU5EN2NnY1hvNk1EM3R4b1dBekdRd0Jz?=
 =?utf-8?B?RHpSUXZ4L3ZVN0wzVDFNNGpFNHRLRzF3akFsbzMxVXBDUUdEWFNlUUF3aHdI?=
 =?utf-8?B?TmdvN0ZTckxDTjZVaS9JdTMvbTR2aDR0ZEFURXF0aUh2YlNyYnlwTEEvT1gv?=
 =?utf-8?B?NkZVT1QwcHVHajZjR0FOb0pYcERjU1pCNE5pZ1c1cHFGaUlBdVB5b29zUjZp?=
 =?utf-8?B?SmpPQVU3WFd2RGE1ZE1EcjQ3QlMwVkh6VG5DQTNhbzJmcm5ZVWRMdXhFMG15?=
 =?utf-8?B?K083SGIxU2ZoZDR0T0NpT0dWaUVtdkhEZit0WGY1Q09wR2VKM0lXeU40dEVv?=
 =?utf-8?B?MjdnWG5OcTVhNFpobzFCVkNhMlRnQlpxV1Q5VDhOM1p4YUkvQWcwL3lIRFVn?=
 =?utf-8?B?d0daM3dKL2ZqNVZJRmN4MXNhQXgxRFpQRUd1SmVCOEpQMW5jb0l0d0JKL0dZ?=
 =?utf-8?B?QWZyYTBpcE5SQzRMVVU0Q3VTZ1VUWEtwNFkzUXFOY0FwYm9BSnh1RVJabmxy?=
 =?utf-8?B?blB3U0JjQThiUit0TVVubmRlSE51RmlMaXZla295RytWbmJ3dXA3RHRiWUhs?=
 =?utf-8?B?dWVKNTRWWjZMVTBlMXV5Y2hDRDJPYlFuc2VHUXoyRzVRQW01d2g0ZlV2M25Z?=
 =?utf-8?B?VkxOcGhvd252bEgvcWpSdXR4NG9QQkxwZDNNSXZRYWplSFNCZE9zMnBTaWU0?=
 =?utf-8?B?UEx5OWpwRVFOSmFtM3dDT09DT2h6anJTWjJQaWlhanQrb3N6allkTzgranhl?=
 =?utf-8?B?Nm93dTRlSXc4M1hpcFpienUraVE1ejlMbjBxVXJHTDZ5ZHBCckRGVGR2OGNT?=
 =?utf-8?B?WjBOSGJBakh2QisxcWI3amZOMzhBY0ZCSVJ1REw4Tmt5U3RlVXZuSDVYQlVL?=
 =?utf-8?B?cjFJTzBMQmh3bStEM0VWUmg1b3ArcVlzbXgwTXkvVklpYy9kL284RUIwV21P?=
 =?utf-8?B?bGZFYTY1MkNiVGdXa0NhNzBRSk91K0tDbE9tdGxHS2VrSWY1Ry80YUhPNUZN?=
 =?utf-8?B?M2V0MUdqVlN0alppaURqMzVSMHNsbGJVUkNwdmM1M1pZcjUrNmEvZFJ4TnBp?=
 =?utf-8?B?RU5MeDJEZDJjMm83U1VDbU9vTUxVT2J6VnFqcWRhZTgxUEc5elNwMFdwMGlC?=
 =?utf-8?B?cWR2b3plMzUzY2VtM0JwZXZ3TlkvQ21nMnFycGhDcUphU3JwNUFIQ1lHSlFz?=
 =?utf-8?B?QXJLZkNMUjROSHI1cFh2bjNKNXExZ1VneHp3bHJIS0o4VFdWa0svRXlmWEY2?=
 =?utf-8?B?UmtQSG1RRE5QNmFXN1AzOTdkaVF2Q2xGQjB6R3UrSmVTRGlTeFRHdkZ4aFdv?=
 =?utf-8?B?SVRpcDN1Vkl5Y1M0S09RRkpwV2ZLU3plak9iNmlkaXdBNEhKSmdEdFh3a2Vi?=
 =?utf-8?B?T3Y1Y1hqNmdNZ1g3Ny9IUy9XQzdjZng4T24vK2I4N0NTOVQzNXdiVHZMTzZa?=
 =?utf-8?B?ZHVLMjdMVVVXNlFpT2t0eXQ5dDMzaDl4M1VxNWVUU3hINjNYV3E0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9000CDFB194C0C43AF90A8101B4F4C8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vVbtB6oqsJ3uRXvAhp00EjDdw5P8c0j2EObzWlaJ/0fwFiBBUVh7No/FWhtkVUolPKHKi6T6/sXFcRz3gHuf+QruqvSOCgR7gGKU6O4JYp+Mnol5yUMl4/VgKKwDxw86XfVvLVFEWEp42LHrl+GXSn1PltDxve0UD9D5r9tDJXKLMtgNfXQZ9W22+8g/Wu2VNxKayhZYdTbDQnxMrng8EhLwv4pa1auFxpH6oh4X21TbD1bB5UacMvSl+Jti4NJRXq7e74idSTWjXsynbK1idHdB7aKqgxjv5fcy+lfJrTXLptdmJ713CGPYZvH71yeamNdR/WPTY9MqvlBztnaVbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SzkXT9vMgmi6BuXemkf9YT3urq5hskSRgwB/x4PUjm1mzUppT82ZMmycLt6k7AkTgejdX3YOfGoVha4rsoCHhhT1P5uATURUOMLtCS47bMyREXKmjK1Ng41pFnilSNFng3KGQvyNiNZDR2Xdg4n4j8NMJqtxobQCaU5yMvcBIMco+LAN0EIq7PA3K5bO8qjgx2Ta0RaN8rIZhGTAVZP94NGZi8VvwL/QKy4pnggeoZZP8IPQOZfVj5my3TWQu15loR7OMumpNc1V+Cn/0I9XTDLUeBmQPoI7soDTxWEjjXRIYRaifzKdsQ1XIjr/JwDHfDa5kPv4mzW90jdNsN/IyCtR3A8nOb7pPrLUcZ6Q432sVdLegs6xyznYhzT6cFqFT6S6Uks0Ia3E1MDT5R91IZ4FgGtwUqbfJBPhT+rYedYgG4/yuHNNaOjowhQZ4w3kD2Pts/v5o4TornJMcA4WOgLdOXqxnqolS79xHxfrKLWEk2l/PwpdUcc0bXXVX05R44yW4rPE7HZzXlz7/xPKgCULwFWu1yI9kYqlG+AYPmnFl4jDrN5oZ49u15yMjd9Z0slo7uPotnwabI27QsBoFK4LsrdXhVsREu7/QLx3VOAF+pMXUx2QeRjO1pqWQRLIR8WC8rjaIaB6+KfnKPKGFQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf3036f-60af-4082-3331-08df0e15db08
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 01:58:34.1492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzAdyL/0YWxz4lCg+OsxLLE5nseHZlmLR+EmEYZronmO04p9YG2r2vZ5XRhvP+IFfaETW5W9+7S7H79yu8Ncpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAxOSBTYWx0ZWRfX86nS0jauJOZA
 QKb7VT0IvFr/N2U+cf52DLlfXfex3xe+UVzwXqRAlI0E3PTkZFPAHyBHSLDBanyIQC5b5dklpY+
 XK+QmiS4/7TYkdZ2SM9NJQjDG8UsHvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAxOSBTYWx0ZWRfX9+ON/r10tM96
 p0PIpceoVrU48qV2dLH1Kn7mC8eGGddREg0OKnZM8J8ln2BzRtui10NzgNVJWSB58Y0u1cDiuU/
 jEvalq5ee8kqFugy18jCiwGgCpzf6kQa9D5RNRvByAAs2jXk6wBBc9YaczFWyG9ZV8UhD33pYGC
 YVcSL+7DHqUWdxh5Ta0gDpJIpgPwnnueNpxEh2PAEF2V/EGYxsVa9mG5HJnjgx0EnMUWGy/p0kf
 XvPSAqyTFd87MjRmR9Z2EGPI2ekWk0ymIj6I5nfW0FbqUuJcXQwZvuEQZGeL/nzo68wOGk3DoCX
 KXiMlXso3xhvcpJClnScTBSbKIZg4+Kc1gPxal+m858jP4QGmV5fbXUh+0+LDgaFM6IiQ4HmwTs
 rgoD60wAwnixen8AEGPjDvosZRYZ7R6farN+xwtAK+w5sGqM8c19gwC1IaZyHhBz1KywT4kMSZK
 KoVsi0fAm0y4g9yqJ8Q==
X-Authority-Analysis: v=2.4 cv=b7KCJNGx c=1 sm=1 tr=0 ts=6aa0bd58 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=kLBKcaOOJJMHJN7zS-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C2g22ewdonRsarqAmD4r6tc7wiITgW2H
X-Proofpoint-GUID: C2g22ewdonRsarqAmD4r6tc7wiITgW2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 clxscore=1011 phishscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609090019
X-Mailman-Approved-At: Wed, 09 Sep 2026 05:10:53 +0000
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

T24gRnJpLCBTZXAgMDQsIDIwMjYsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiA5LzQvMjYgNDoy
OSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiANCj4gSGVsbG8gVGhpbmgsDQo+IA0KPiA+IEBA
IC0yNzA5LDYgKzI3MTIsMjcgQEAgc3RhdGljIGludCBmc2dfYmluZChzdHJ1Y3QgdXNiX2NvbmZp
Z3VyYXRpb24gKmMsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gICAJCQlyZXR1cm4gLUVO
T01FTTsNCj4gPiAgIAkJfQ0KPiA+ICAgCX0NCj4gPiArDQo+ID4gKwlpZiAoZ2FkZ2V0X2lzX3N1
cGVyc3BlZWQoZ2FkZ2V0KSkgew0KPiANCj4gTml0cGljayAtLSB5b3UgY291bGQgaW52ZXJ0IHRo
ZSBjb25kaXRpb25hbCBoZXJlIGFuZCByZWR1Y2UgaW5kZW50Og0KPiANCj4gaWYgKCFnYWRnZXRf
aXNfc3VwZXJzcGVlZChnYWRnZXQpKQ0KPiAJcmV0dXJuIDA7DQo+IA0KPiAuLi4NCj4gDQoNCkJ1
dCB3b3VsZG4ndCB0aGF0IGRldmlhdGUgZnVydGhlciBmcm9tIHRoZSBvcmlnaW5hbCBMaW51eA0K
Y2hhbmdlPyBTZWU6DQoNCjRiYjk5YjdjODJiYSAoInVzYjogZ2FkZ2V0OiBzdG9yYWdlOiBhZGQg
c3VwZXJzcGVlZCBzdXBwb3J0IikNCg0KQlIsDQpUaGluaA==
