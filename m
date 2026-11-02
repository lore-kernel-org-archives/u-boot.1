Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21666606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B89uZcQg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F+wGzQ9l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UJrtMnzS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E81A3606FF;
	Mon,  2 Nov 2026 05:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCW0pAyQCd1A; Mon,  2 Nov 2026 05:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29BC9606C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598626;
	b=D4+hqM0d7Z9ftpVqHpzLGnnkjhzYdGNlmDtFYDLFYdVCz9yAq78mzv4UHHLZG9X5C7P3
	 +gtfnr1eDTM+nf4NA12I3SNhjOK3wibd1E1Kf2+5P/FOF8tKIWSeT8Ycfl61O3Zx11q5g
	 uWhMzRTqQzTsd/lD+dqsDzW7/6Cstt3Wc2W25utgbT1m5bY2lZbqg5PsctNPu1Vl2I1KU
	 P0Yityk4V9nn7vHHJO1R1AWelXX6+BcVR9yLEmafvcx/VOZ318aXyMHI2OnQ9HKoFtvD3
	 MkAVJrQCCXHxPkxgHdF9VBv6T5vtUM1KRuehAWkYm3Q1CXZ0Bfku3cSNbWea7x1FV7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	b=AO+ysTzgafKz24+8mUJUTr2VKetkEgkWFbEBNb4iqgKBPDCzlecWI1CWcJwkqymzVPW4
	 vcJTiv9YbsOZbM92Xb5Btp1vNyZXGqi4Uu23FMjlfuspj+OHPgiljXDslTeYEFPxZjDzA
	 z3dQZ/TDFCHdaWXAo1UYTryMbMP6hguucK6mgLS6Bvc+WqIw8ZjRCIDqg2phRznyO1ndG
	 F4bf6lihpR/e4EcJrkYu1i+kKCJqKHszJHw27JyUndiulgHGgcZ3djXI/KscuOC6yW5n/
	 EjAaXagrEVIffFrIZ+jMV6CMeHhlHY7/CFfvrf0uUb+s4OahcdRgd5wiyqiSYHgQ0xw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598626;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B89uZcQg5nv+C7sVGccoz69KViIcTi13PuSWWGxfzpNYYUYkIy74ckAfxG/NunsUx
	 +2BM0M/+ej24DfSmmHYiVN/1IMIzIr2WD4G3fGEbVzj1IHWond7vG/GBnonkSmmfAe
	 P/AvRpBqHydVzdX6ZjJARrpr+XbtubG3dm5WhlZIrL3QZrKrLzHqL+jNSppzMTM80R
	 GKHR4ihoMSkMm+nJQILcSw1soIdzPEqblerhBAT1WgQpdP+EG67/XzphaXQHoTGVIw
	 Q8KM9MSciVT9Yj6rUPMPj/3J5Lu45VWWP3uXr0WRgTlkelS2KRvx8jAgGwsEw+T+Ia
	 +jd9Uhu3s+/yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29BC9606C9;
	Mon,  2 Nov 2026 05:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFA7A323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0FDE400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCPAxT6RdsUQ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 26D73400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598624;
 b=CUPOTp3iFFDb8xXLvw4m297X/8URS64r9mo/747/W06eCjNK/lklNNsjxUKIGxvc/oia
 7SoRcdlF1T8shv7ELiYWbT9/Q+I29MmBNBywjfuRhCxcN8UlfSvyluLpzaUNMOQlQuVCa
 tf1K43z7a6fnw4q25zhC2lFvuR9Tvjk5PlwI1qJEXi+i4U8L/lKdEUvwNkGhzSyB0eVqx
 gA8FLyvNesGaX1pZ6QbUnXteKXZ+XrIijoOeSAzv7fsVYqWPhXtpvSKk1mt3QzX4o+Od0
 BdLBnoPAiwF8U4IovZF1aG8TcfVnm2bv4TP4u74Bs351jjLaXAclM26FjiiQTlS0ggg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598624;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=OggiCWWFMWDybZOaQ+v6pt7YoGnY29XFCwKEFaYsMaQlH4p2wYIWVXkN55ae7WHT9gPn
 wFs8cST6fN8EK0ie13NodC4JfBLHhRqe9PeCDH1u+6APe98PTv2TlBdHB+2GlrUrjO+aO
 YwdQnpXDFWwKp62b+y9p7HadPu+LUwp4YF+17Y6D/6Ji9zC8Rwc7J9hrs3hrJtHLWFo79
 Jqs9mkgT6LmSow3su1Ek+P+zwLav3XtXnuUG+2lllYdiFxwfsROmpSsEOCKDuobJ8HLar
 cBr6eDc/PIcL64+OuzfSTl7nginQ72aSZ1DeD8fkA10D7dx2S33OBVU/oPM0Z10Lkqg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=F+wGzQ9l; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UJrtMnzS; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=F+wGzQ9l; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UJrtMnzS
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26D73400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vJ7f3324691
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=; b=F+wGzQ9lG7QkmOD/
 0isV8wHYGex4DRxiPtbEdlQMCrZE4PH9FdjqzmyC0xK1WSfvmekXIR8COVztKdgl
 z7EQ8//RFqf3lHAonDpWVwHghbbxQJ5OXR8WzeKQFkaOFWDLKFVcYBJ3v+tiupWn
 excFbcmOZ6aTr14EeBt/LTGBt6Ook8jdtbzO8D3B88Zo4N8z8daihS5LromU5+8d
 Vv49ZHbNg+QwwAYXK4hCteG7tJ5WWoT00moTD0c4O2MvOJx4vXFQeceNIxxPF4kl
 lHyIAp+d+pAbEJjd3CN8lx/l3DV9uC1QqjRts1n93HEibB7xsOMZEWb5XDhCvyML
 DSvmCw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6nfq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so5318719c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598621; x=1794203421;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=UJrtMnzSD3KlldxvjuPHLJ56MJh4VnUrk7iAHu6GqMQgs4WwS9qkezwL5FZdJPpFSX
 eYi62ONH3kouW79yjUVt6ezRHPClVsbxsKDOMVxUfnubAsbmYkH6uywYdJV1dPWyjjxn
 OClEf6Jm87m5sYcJSeQVIlfVvOV9opXpcVgtJAHg2Bzx1YGyZffOwAe5rAGKncFp90L7
 nUG313jdW09n9QKwFh8qo1qkmEMWab5rKLZciP9Tmdui68+w5d+JvVlEYmDd2bSDjYbV
 mN8dAiBbjsG8XEuP4idzbOX8PECew4Gb82kTf45gJwqlxVd4OH2wxnfLg9Ke3yYblV4U
 VjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598621; x=1794203421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=XPfjb2xBjm46gCRlFZl8RQvYnvFTMsCn7mKZ01DyIOAlCXZHAZxOW1p3n8ttFBZVG+
 jv6DZegVoEMpFxYqxLjVihZ7cvk1X6rLmX76Tbnby4XDhtEkFocm24VOfJcTR3uPo1Jj
 EDFLBhdzs6nhOuK/5CNk/fPyINLwvACQ/plV/gVWbMCqJt7wXJSnIpsbDE3hZPyaMJ4g
 uQtQgwys/CeFbrry+4M2dZSdmd1wAtRcdaPqS/7bfk/wbJtMWsypRQxa15Sc0mjrncRx
 izGNyjTkkQbSFkgVSPmfPXRswufVdFGNxYLAxqgF6P7pZfB5ruY62J59UX9q/vtkC8RM
 jHlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlF7o4AkwJT0omXCqVmtfodeBMo5fqE2fO/2Xxrh5iCrUN/vA0SEEAamlC6WmJswWkFUO8ICY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLLx+vyAThD7euN1JH1Qs24RYnnEcvOeLbzhfacYFSRnSVcRXB7
 s7Ptbeha4eyQ6XV/bxulPa3Hs97kEWEo3rtUZfNN0tzGqDJ8l62CCmfod1hwPsdbu1n3BPkFojs
 C+UNvhVt1GGirUm589nU1bMWobRLXi3mkbkhTiJ/SV5vIM4odigKeyhnJIjKI0vmdZhktMq4=
X-Gm-Gg: AYBFou3rUcL4oBOuYA9/+XTtZG3plNHr+YXOoFu9TxdDpTKWDmtJTAY82rs29VYYWoH
 J7Sx5fyIVPx4qLPMxEsoGBaS1oJnn5QTk6u2dJsEw4Sd/FzclxNGPUFMdizw9hOG6FNB7QTbd6b
 3pv/PIWLQlCJf5q1muuorJO+Rjgo0hGDrFxDfWnLZs3dJOv3b4NdPGaEnUPbGEM59z9GF0++/LE
 I4qbHK6UDPj+2mSG1hNgtNo5EZ+hJK4eGHfSE3KBymhe377N8VNAB2+dNUi+UmSHcSuaSx2NgmE
 GthL9Gie3qXdv8PpQtEKUsjZ5e0IsA3bVZ7tjLrmDG/F80XGC5GLa91qiKfCJaMHldUaa3n74AF
 YdpNntMy3g9De9hhz6b84z95QnrvaepOVw3watQfYZ6rIfK4JSvPcFmY2sf51dToamfMKcb1CHU
 0aU/3S9BN5uvwS9neVV/Ol9lqWk9rEOVB9lg7fI6YbdZCqgXngdaaCGTIf7lkdDGTF7+uGTYnHN
 3PYyg==
X-Received: by 2002:a05:7022:eb50:10b0:1ac:9da7:e881 with SMTP id
 a92af1059eb24-1ac9dc67142mr14529299c88.36.1793598621457; 
 Sun, 01 Nov 2026 21:50:21 -0800 (PST)
X-Received: by 2002:a05:7022:eb50:10b0:1ac:9da7:e881 with SMTP id
 a92af1059eb24-1ac9dc67142mr14529235c88.36.1793598620817; 
 Sun, 01 Nov 2026 21:50:20 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:20 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:42 +0530
Subject: [PATCH RESEND v10 10/15] dts: ipq5210-rdp504-u-boot: add override dtsi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-10-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: oQskwJJ5rdH-qs2Nu6l4AF5hsrKNxCt0
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae8249e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=t4X9H54Ucq2VsXYocbkA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: oQskwJJ5rdH-qs2Nu6l4AF5hsrKNxCt0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfXyj+9PrSKyQEc
 oi43V9mjWeH9WjfrgH3oPwzbmJ+niDRFkT7Vb/vgFvsef+Kahoc35facp/pvT+QgblvdjgHWpS0
 abSJET3shHo1Od/I21rLwDvg65rSwKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX9/73J82FxZsI
 uKLYwisrMjwqtRHxrx/XfQKCvOGBXqmBoCKdWPaS7xho68jqBVvK+ljfZTv5yp+AiWnXCsqj2Cs
 Mv2jyTaDsaH9jIEjaMCS0HCObPbSGIoCQJI49Jl5ZZljvDRvgVxPG2IF8NAAMN8zYd9xPDwtMyP
 RNx4iCbTM29uugAe+zFtWNhvJpG9N7j2wHwRz/945UZkiiqjivZ3mO2Ja6ucjk/4t8vEoG3hUou
 5uSrdpnrV31bBcj+R12PO0c2cqhvnP/R8C1sSyZ2SezWRLgejLT/Ib0PgvjfyguhptdYHGFWtDf
 cafViZ/kcFNx7Bnsh2ekFZMgqgHkSJ5fJOWMLDt76IslLha8Dl0T00AcodsIZs+VUz+W1kXhnS0
 +xg5DQ0+k8bVfQwVFKPM9c50KXW9s8SvaBEqG5MQDfRTpmLT4qN1vWW+hK1i44R31XQCXBV7Z5f
 KkfBFvIGlFFRZAFq6Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5582de9bebb
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	reserved-memory {
+		/delete-node/ bootloader@87800000;
+	};
+};

-- 
2.34.1

