Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA6606A7D4
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M7PdoQrp;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ccFRsXVa;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=I3u/KO5a;
	dkim=neutral header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PJyeMAKR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2415F812B1;
	Tue, 10 Nov 2026 13:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qm6b9jTqYIa; Tue, 10 Nov 2026 13:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DF8A81287
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315937;
	b=lfZvm2bxNsoFD1ktcw6sh/FffN6BGHth9tPLVhyueep5IfJxOiNOpJV4B//oagsgxKhQ
	 xCBo4k/i4OHV5eXeF3Ai14zoJLhS40+BYooN5t5Fv44lht/z2PyaaSBV0wXYmn/s4RXtu
	 3YRASwX77cJfYY/nkqP3i/3oMEJdHe9fnOI8qNctj3TCV1KFQ9tgODlZAxPbfzjXQMGHZ
	 SexUgl5XMYFTLLELOufJdBaodP4bsWacAEoTBallBPh3phFTg/JXOJXylNqSqgsbxRasO
	 gLdKCV45gPtW8lX1PA4snqacsOdFDL6mZO8Sa9WO1jW3d7zwCZ9HIC4JLe9m1XacUzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315937;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CgcgKhKf/2IcxFurxYu4QMQM9Ux+hgy0VviEXvGzDfU=;
	b=S2j+J8iGAshnrp0lj4X1Nimo1D+A1RExaaT4QP6Fk2UkjvNZHLUb9RXvu3D3b+34v10O
	 oIbdCBzMlyDppnf6m0cs6D/QyaJLkMu10PFwdnl6s8bA2lD1aDUUP1AWNt+3abuZKiO5O
	 k+8LwbChGoxpZNLgDy8RURPe7sjlRUm/HILGfk0jbwMFipto+FOtnIwP4gPpRRD4cgXEy
	 HrkQHhYj9fzujvp2SpsuRyzHBXt0mdaHRdsaGDANdwsdL833Xl9WRxImfM2Kgd6ikt5GZ
	 af3wlaaHxWyfuZxq6hnWhAxcpGZlYKjYMwAQrK0fLDRtcsiF8tqVNhzAnwMrh2cIUCA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315937;
	bh=CgcgKhKf/2IcxFurxYu4QMQM9Ux+hgy0VviEXvGzDfU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M7PdoQrp/QEq46P8oyymow+mpBbAyTjvs8MBWf/E+aU1Xr8TCnM9LbAKMNo05ni7r
	 VDWgfRZA7XKt5Wh5cFjO0mPv8qkKOjXutHVfXGyY03Squ7hbWXip8MT9SGwuLnYTtx
	 FZxl7ShAwZi7PzlpDOobFTjF/X5czSt/NMgkNlDseoiCWHUxJ+Lt7VeJfigKNwwjLQ
	 9iW4lyMEKlqtKw+FOAOtyIr816YzmPqXXxUNRRBw9XMZvHZVxvNNOipHgpiTL38sBc
	 fd6sYsxtRmWPBqkaO189nGo6lBU5WN/wNYXv9rR0chovvYLBPjRJLifzaFcdnWI1eY
	 VEIhUGid12KUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DF8A81287;
	Tue, 10 Nov 2026 13:05:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 808ABD7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71DFB6070F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOSBFoHkuTok for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 02:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1828C6069A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=148.163.158.9
X-Greylist: delayed 6828 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Nov 2026 02:46:27 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=ccFRsXVa; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=I3u/KO5a; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=PJyeMAKR
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1828C6069A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:46:26 +0000 (UTC)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0gwkp1322855; Mon, 9 Nov 2026 16:52:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pfptdkimsnps; bh=CgcgKhKf/2IcxFurxYu4QMQM9Ux+hgy0VviEXvGzDfU=; b=
 ccFRsXVaHcZdG4ADKu/z1d7SQWZwl5dO3BiPJXL04WZ3WqBvHtU5OwxXqGP15IjT
 VGI5GwWWyPftMGKkwBlC0GeJvnowBASj1INln8E2QKDTd10Y1ULtcM5YQvhV5dtQ
 fLyOJJB/sPk+diDIfp5yUMQCLbAScT06XAV98srBh9GSzLmgm4PkNC2Y6K8bGNMu
 beJiWYfQbJv1LXKv7DWlXRhKdrtP7Owy96Fx4UQqMlqosWMYt+Jfl7zJkqgm4s5o
 17FceEhrU54Ml2uEMB1B/dyEwoMFHB97P8EvU3NRIe+Mof6dMRKnyaUB4I4jkwol
 f4vkzFHjzetHcMhD0OrxrQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4huhs7tw31-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1794271940; bh=CgcgKhKf/2IcxFurxYu4QMQM9Ux+hgy0VviEXvGzDfU=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=I3u/KO5aZ88bwqAtWmlaUuUYpzI7uZVVoZpb3b5o1Q6T8DPE/F05AtpFs05roGkCK
 dBXYrGNMG31guswomyYDRIVQY5wF+4faYKVMqer84wia40jYRm4de6OtlZKOGIZSRp
 liV0b/0y2e/HUkCf/BAScJFYMahzgfPE90y1UD+D2t3PE7sBwOF4dPhCFNguPXtBtP
 Q2WFlSpv2Mtv2KZ9bY1f3yYB8KZEEibnuPoYja8C7S4gdY7CvyHr87I8s3+BxR1Ers
 u8joCTUyHryD3+GIFhuFWAHZHAZFgx3NqiRA1Ps6nUfiglhUrj5mMqwC1h5N8RuOa/
 IlDCc0pvekwpg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B8F0540408;
 Tue, 10 Nov 2026 00:52:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com
 [10.4.161.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id D2CCBA0070;
 Tue, 10 Nov 2026 00:52:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=PJyeMAKR; 
 dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com
 (mail-dm5pr08cu00404.outbound.protection.outlook.com [40.93.13.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (not verified))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7CF1340ACA;
 Tue, 10 Nov 2026 00:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgcgKhKf/2IcxFurxYu4QMQM9Ux+hgy0VviEXvGzDfU=;
 b=PJyeMAKRHZORM44jssi1+h61jNbHVl8io45dv7CvvSt8Wp4ttk19Ae+z6ruW1j9J2AxO51i71qs4a8sXC4/xHU9Txau11Oq0wznHMQSD08QxaVzwP094X4VOEa9ua2hnU9S+DDJlLYOuENXtwPocYTElPpQgEv0CK+ZohkcaL/8=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 00:52:09 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 00:52:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: Dan Tran <Dan.Tran1@synopsys.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Topic: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Index: AQHdPBUy4ti99ufG6E6pK0/WcV4467bJJu+AgF28T4A=
Date: Tue, 10 Nov 2026 00:52:09 +0000
Message-ID: <avJpVgg6Jh_6Fuzu@vbox>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <178911875744.102286.17132958660285497598.b4-ty@kernel.org>
In-Reply-To: <178911875744.102286.17132958660285497598.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|MW6PR12MB7085:EE_
x-ms-office365-filtering-correlation-id: 77f0b713-6c97-419f-7471-08df3ec4d95c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|10067099003|4133799003|38070700021|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261022113327099003|261022115727099003|261022075727099003|56012099006|261021135927099003|261021121427099003|261021133027099003|261021123027099003|261021130227099003|261026135527099003|261026140227099003|261009223027099003|261026130827099003|4143699003;
x-microsoft-antispam-message-info: J+5g86vkTFTroAcKR2E47Bcr4Oo9dlEMOYTIx0zGxpC3l66tEXRqQydilIqFfag7EA9SmF22XSLegFwO5JJdntAEX4covmJHFpzB8plmwSvLunCo0Sc0dqIFJ4SQz+5Cd9ZAxqHB84wRyUG+Pook+Nrn0q0uyPg4iEc5NRv/vbWf9uHaaJtrgo+iuYys+cPaGPHW23DYPjjbd8yPthAziXyluhBNtQzt/LC0KiPKIUBqEwUCUmsvODsf7NJAfLpFqV94lds8pRNYvV59smibtvyRUWPAtLHFJOlNj1w1k/su63Rdne+zJj0rLl9qh49Gfq+eeRnzzfBdkpputa4HjXdeuf47rtpC6TRBjoEnhKg3Gtk3APDlD2yGH+8dLojqRd6dR9LTwMJRw73Nk/bO02QnSZ6Bich8ZcLJKBHisD2a9LM66jE8oSSFJemC59TSquUZeMirfXQbBABJMWD8Sxv84z8f/PXs1t7AzvaEh9iXVenBfbIWMPMGOYxYx9annRzCl+TbTYddnk7nrpUrACjTvImKuKQMosbN4E8RgnvX1Qv6mkSMF82j0RHbbYTNI/n9QWW8Ho2+IAMUNNDYLCstcZ5qzc+fYju5AdzzcoHETb06RI5SY8Qp6yflIi+s0iknUZFJdmGhMYLpWVeFvG1X4OYQ5CJM47z5lZkkDj4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(4133799003)(38070700021)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261022113327099003)(261022115727099003)(261022075727099003)(56012099006)(261021135927099003)(261021121427099003)(261021133027099003)(261021123027099003)(261021130227099003)(261026135527099003)(261026140227099003)(261009223027099003)(261026130827099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlBQbmFrdkpHQ0ErdDhuUmNMelpBQ0d3dExqQ0hxVUxoVnBUNG9ua0szQmxw?=
 =?utf-8?B?V0FTZTZzeGtkVmE2UStmUytWRW5DWVdRZlJZc3RWMDZRYkVoaDM4N3YzWXJO?=
 =?utf-8?B?YncxRUk4SlJzZlFpNGtpR3pqTEcwcHVJeUMxOEQ3RzhPVGlhL3NhNmtwak52?=
 =?utf-8?B?MDlVaVVHemJHSDhwNUVobDRHSWd2VStxRFg4NTE3ZjM5S25qYStIU2p0WTBR?=
 =?utf-8?B?WFgySHgxUDMxdndzUmI1MnVLSHA5TUMxZDZEemNqc214cnRObjY4d3BBTmRC?=
 =?utf-8?B?UG9PWFYyODhtYjdmam5qZTVmeUdVenV1d0R6Z05GajRSdEpBQzZCa1RxV0Uw?=
 =?utf-8?B?ajZyWGFDQjNSTTMxRisydWZNSlZubTU2VUMvQ1pRYVU0NTlFS2ZOdUNydm8v?=
 =?utf-8?B?NEUyYmhXd2IwTzhmN1B2V2M3RzVXNCtNNmFQZTEvNlorenRWN01hUWxlYVor?=
 =?utf-8?B?TUpZS2dxTWE2MElEL0dxWlFoeW1FSlM4TDZzVjVmWGxTaWxZeEQxV1NmL3da?=
 =?utf-8?B?TjNCRHl0cUxVOE52anRXMkRwMnFDMHJNMHloNjVSU2ZmSkxNUTJoV2dqQTZu?=
 =?utf-8?B?U2dCdmppWjF5YzZPV2JhdERqZUFNelI4SWR2WWFKTGFnNnlkbUtnVCsyMUtn?=
 =?utf-8?B?S2tFY3Mrb1FNcllReGZGSEUwZTlIdUhFQVp5WVZidWh1OVBFN2huSUNuSXJw?=
 =?utf-8?B?WGZIVEY4TDg0b0RUSG9UODBCemRHNkdySklzLzJMbnlKeU9iY1lxbXQzRnor?=
 =?utf-8?B?RFZWT1VDTDB1bU9XR3dQNlJPNjFQbkdjemNyWm1xTHZyWVJSbXJlODRjcFV1?=
 =?utf-8?B?Tk9NaXNCWEdLdzdXVzVScjMwZ1lWWjJ0TUZ6TWdoRkwwamZXbEhQaVFRUXV1?=
 =?utf-8?B?WkVROUhWMUUxQjFMTzJuUlpjMWg1a0V0U2RRUG5CUi9kclJPaW5BRm5VY3NF?=
 =?utf-8?B?QzJLZnJNYjJ6b2NWSlJ1NGlONkVwY1A1ODMxczFlSlEwbkxxYzhxb1dNZE9x?=
 =?utf-8?B?YnlHajVLamN5a0FiSkNzeFJQc0ZGZHo4RU5pL2NQbHJsWXpYb0dEWTdoZ3lw?=
 =?utf-8?B?RzYwM2gwU1IzblZUNXZtRGJ2dzcwYXNkNnZZckJrK2pJS3BkZVkyMUJmSHFM?=
 =?utf-8?B?aTAwMHIxd0dud1N2Y2lHaVpTVmFLc1hJKzdZYzZpcGg3Wms5RzVRRTFlN1NW?=
 =?utf-8?B?aUEzcVFQS3JUdlhmVTNjbnZsTmtLMDNlK1lMWEdOL09JNEJkOVBGbDB3M2hh?=
 =?utf-8?B?UDlsTDdaVzY3WHBlTWoxWHQ4VHZkVlAydXB4YmhtaElzMU1XUmNNcnlUa1JS?=
 =?utf-8?B?V25QSkdkeGZBeURMTFNhdEQyU1p3cVBlSXQ3dGgybitJNTRsenJFZFV4Q2s0?=
 =?utf-8?B?OUt6RnJ4NUNReUdSdlJJUkZNR0s5Q0MxZ2FRMUZOUlpOUXVPOERZbngwTXFM?=
 =?utf-8?B?Q2FwTEVDdTZRZG9BVVZjNGZ0d0d5Y0dTaDVuVXBteW5TdVNqQVBRUnVmUFRG?=
 =?utf-8?B?VGtLcFM5MFJRNHMyajVEU2RRb3NoWFYzZEo2K2V5eTBUcnQ3SmRnWDlad1c2?=
 =?utf-8?B?VVhQNSt2VUwydFNOT05KWU9GWkZ5SldXaVFYODQySE8xTE5mVlFCd2N3a1dH?=
 =?utf-8?B?NU5kdndUTGYwV0ZxYjZPWkYxQjFWYjhXQVpieTZWS1JxR08rUXJKRUZaUlU2?=
 =?utf-8?B?NTBSbzNIYVRXeGpvaGxhR1hrdDlnSW02N3ZENXZhdW5kb0JiUExHdkhvVVZP?=
 =?utf-8?B?eUpjWEJoYXB4SHFXYjZlZ0FicmVnR0xlN1hzZ29OakRyME0vQVFVclpFTC9o?=
 =?utf-8?B?QkhDaGhxRlNvMjM5bG5pV3lGT3JadE5xWEZ6Y1VacmVBYnJhbERmdEczRmd2?=
 =?utf-8?B?aUZtcjNHdnlmNFRTaHdIdEdHdXBSdXlZaWdNYXE0QjlFWlNGYXVobmFBdllr?=
 =?utf-8?B?NkYrNmlBdGpLK0pPRjdrQ01aUCtORk52QTNpY1FQVExXa2Npd0c1RjVSbFpx?=
 =?utf-8?B?NzlSS2xVRTdWZ3F0TmFJZnlwT0lVL0YxZ2pUSG5LOHc3V2grRHdqWFpkOWhB?=
 =?utf-8?B?dDgxYzFmTEwwdE0yUVA3Ym5SbnlpRWRUcVFiNS8rVHh1MW85dEpXeS9YbTgr?=
 =?utf-8?B?WllZalp6VU01bHppeVhmRm43aTFQSm9vV08vdmZ4cnYvaFp4Y2lBTCtPajVV?=
 =?utf-8?B?U3RzT1AwdEliQjVsUHNHMDdXTEtPeEpDVlN0UHdHUW9IbzdPTVBSMllBMjFW?=
 =?utf-8?B?UXpIUHhDME56dlhqRzZNb3pYYTFzVEpwTURld3ZnZFQ0cWNkUmhuRFI1NWFZ?=
 =?utf-8?B?Zk0wd2k1Vm9NdFkvVnM5OStyRVZSUzR1OWRCU3UvNTlPa3doQjJTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A1DED2F3AA5044284E433DFE51D1E2E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pE53FGvEMymhBlgQ6L+BSeLU/0Zyekx5Ud8utFaQ3EFsKLPKrIQs07+wpmd125XP4g5BcKzhQTjgwK1q1NKB80psa8s1nuhdx5cXAt89nxsyHkb/eFaUlD6qJPTM0Fr+f8SIkfE+Mvh2AQc7UQYPydhscZSKtm/LyqbDsA6bJaV/eeEguWFYkIWXPmiXTpun+dr4ov2Cz8GFeYj+mOKXihZn00dx6R1w8XNJvnu2nXZArBAXitvtofhHF0rcgFmzMYVcTh4xCJQL0GWjaJiE8n+b/B8G/BQGiK2bqnKJMotBD5EOPjCNksPfcX9eBOKV6S97X8gViIRjDTJpfqdy0A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q6GIvefyXYQOzfMOduxIta9Pcq0RFCjZSSraBG80INWfish5Zez2ewHqnQmuKP1T8egxUw2WNTxguKhPmBVRSDRMXnYNCVVJ3hB0jvEN837fVZVGHVFPCI7tYl8BinXXRYqGZKA76gjoAq681LOzzwyENKpIRQ4r3RT0DKVzqeRQdm8xF9ijGqGAvAMlvvmXl7szOcatgM2npjv+FQPQBMLDKKBkBug18BZjcqA4YdtpGwfswuJFT5jtq2wtOcrBfYYqqolCalQUJ+HsOwr6bqKptMNL7+zLECHqcLrg2WIp/m0Vh7hlfz3jjkdwLOiUTZqR0SVWh2pMoYcuWgKH18+IUBxZryAYh0wx7YdAkTcnMrLGdP52ZNA3AcHN69JlUwWiGRDsHXizOHftli2+bNQXRHYlf+szgSmhMjCx+yG2tsppAeZDMMbW0RqSrOAII7ivRE8QOsm9tI8740zgWhs74ZIu/1dGjK4jOhSvhz2LXtYzxWVFRKYGP8egTmth5b/xmjR5VLn3OXQD9v/cKAJH/zS4lVsfs19BZKamoizftcZe7rbg8c+YYgQledZ95Ik5RTr23N4CTmB59HFxXhlcF0i4/VnlXEEat/dTfRgyzzO32s3iESDn0CcaMgkBYan9SrgzP8U1cj7/CcZXRA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f0b713-6c97-419f-7471-08df3ec4d95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 00:52:09.0926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTY4qOc6RYI/80WjmT37gJCZCT9S3wOl1FL3IbLeylHBSyb/RUTF+QGWNxe654BxWZO9MvCOegFkSd16Lweihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Proofpoint-ORIG-GUID: IuR9-x3PKD1dwPahisATwhCgQSjm4Gz5
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6af26ac4 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=1VxDqnHFAAAA:8 a=ZwIp0sn5CNpsRLgdvBEA:9 a=QEXdDO2ut3YA:10
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwMyBTYWx0ZWRfX4Q4lonpbcszL
 kY52VtO1ML/SfXyH2OalzToFVzTfVJeNX2UurrAnJSxsl7pVDtL2R6J3uLgvnhiQU78rUeO/D6Y
 4yKZ/9JCgNJB7aWxP/tTJPoGpQE2+PvWTDvAlW42a48jTEiGhXIMu7QeZyecGWJpgz/oHYHTeWf
 7uZwFlJDf7fc4/a53Uwbse7L2fqu08ILPQL5TInaubg5oWwD0VVMcmtZmDFRdMJLd3dQfUDPpjz
 YnQ/tO64g7lQF+2Rn0L6PX/nfwecN4wPq0RgT9SFjtdy5MEwHEJuxcb17tjDQ4JCdKLcTRAQXkw
 eCcF2gzhehr2zzhCVXlsNe13llPa/+dKkJE9c6PtHXpXaHdM2D+2xoCwcqxysXxTCVNas1GK645
 SrEHuZunSNO6xWVpIov3CO/pB1ohtQhPQnQdZuxgD1Fa7ADDkJxFaBm0DZ/l9maM/1ASA9+zAqJ
 3jShPHB7tTGsQphq/mg==
X-Proofpoint-GUID: IuR9-x3PKD1dwPahisATwhCgQSjm4Gz5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwMyBTYWx0ZWRfX12eJ8T8aI85L
 c8I9dbW5R8fJ80xNWCm2/iEb5zZtxi17g6d0rA1Vedeh5TI8ReqC//J5E41OPJl8YcFcGqrqHh4
 HbbjwnXGNE5mThhGySMKmxORnA/qnyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611100003
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTWF0dGlqcywgTWFyZWssDQoNCk9uIEZyaSwgU2VwIDExLCAyMDI2LCBNYXR0aWpzIEtvcnBl
cnNob2VrIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIEZyaSwgMDQgU2VwIDIwMjYgMDI6Mjk6MjIg
KzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBUaGlzIHNlcmllcyBhZGRzIFN1cGVyU3Bl
ZWQgZGVzY3JpcHRvciBzdXBwb3J0IGZvciB0aGUgbWFzc19zdG9yYWdlIGFuZCBERlUNCj4gPiBn
YWRnZXQgZnVuY3Rpb25zIHNvIHRoZXkgY2FuIG9wZXJhdGUgY29ycmVjdGx5IGF0IFN1cGVyU3Bl
ZWQuDQo+ID4gDQo+ID4gDQo+ID4gRGFuIFRyYW4gKDIpOg0KPiA+ICAgdXNiOiBnYWRnZXQ6IG1h
c3Nfc3RvcmFnZTogYWRkIFN1cGVyU3BlZWQgZGVzY3JpcHRvciBzdXBwb3J0DQo+ID4gICB1c2I6
IGdhZGdldDogZGZ1OiBhZGQgU3VwZXJTcGVlZCBkZXNjcmlwdG9yIHN1cHBvcnQNCj4gPiANCj4g
PiBbLi4uXQ0KPiANCj4gVGhhbmtzLCBBcHBsaWVkIHRvIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2dpdC51LWJvb3QtcHJvamVjdC5vcmcvdS1ib290L2N1c3RvZGlhbnMvdS1i
b290LWRmdV9fOyEhQTRGMlI5R19wZyFlUW1FTXZ6VkJFa2FiUHd5cG1ZbmJkcnAzbXNvbm1HS2h4
R1p5d1BCNzlvbzhzcE5Da2E2UDllR0FhZTZ5cC1DZTc0MlZJem1pcTl6VFNGLWNBZ293QUtTbXFj
VSQgICh1LWJvb3QtZGZ1LW5leHQpDQo+IA0KPiBbMS8yXSB1c2I6IGdhZGdldDogbWFzc19zdG9y
YWdlOiBhZGQgU3VwZXJTcGVlZCBkZXNjcmlwdG9yIHN1cHBvcnQNCj4gICAgICAgaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0LnUtYm9vdC1wcm9qZWN0Lm9yZy91LWJvb3Qv
Y3VzdG9kaWFucy91LWJvb3QtZGZ1Ly0vY29tbWl0L2JjNmYzZjRiMzg4MmZlYzNlYjIxNDU3Y2Nh
ZWQ5OTNiNDA3NDM3MjVfXzshIUE0RjJSOUdfcGchZVFtRU12elZCRWthYlB3eXBtWW5iZHJwM21z
b25tR0toeEdaeXdQQjc5b284c3BOQ2thNlA5ZUdBYWU2eXAtQ2U3NDJWSXptaXE5elRTRi1jQWdv
d0hoUDNFdUwkIA0KPiBbMi8yXSB1c2I6IGdhZGdldDogZGZ1OiBhZGQgU3VwZXJTcGVlZCBkZXNj
cmlwdG9yIHN1cHBvcnQNCj4gICAgICAgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vZ2l0LnUtYm9vdC1wcm9qZWN0Lm9yZy91LWJvb3QvY3VzdG9kaWFucy91LWJvb3QtZGZ1Ly0v
Y29tbWl0LzZlM2Y1NzRlNTc2NTg1YjAyNTBhYzM4NzQ3NWQ1OWU1ODFiYjVkOWZfXzshIUE0RjJS
OUdfcGchZVFtRU12elZCRWthYlB3eXBtWW5iZHJwM21zb25tR0toeEdaeXdQQjc5b284c3BOQ2th
NlA5ZUdBYWU2eXAtQ2U3NDJWSXptaXE5elRTRi1jQWdvd0hQR3Q4aGokIA0KPiANCj4gLS0NCj4g
TWF0dGlqcw0KDQpKdXN0IGZvbGxvd2luZyB1cCBvbiB0aGVzZSBwYXRjaGVzLiBUaGV5IHdlcmUg
cHJldmlvdXNseSBhcHBsaWVkIHRvDQp1LWJvb3QtZGZ1LW5leHQsIGJ1dCBJIGRvbid0IHNlZSB0
aGVtIHRoZXJlIGFueW1vcmUgb3IgaW4gbWFpbmxpbmUuDQoNCkRvIHlvdSBrbm93IHdoYXQgaGFw
cGVuZWQgdG8gdGhlbSwgb3Igd2hldGhlciB0aGV5IHN0aWxsIG5lZWQgdG8gYmUNCnBpY2tlZCB1
cD8NCg0KVGhhbmtzLA0KVGhpbmg=
