Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B187ECA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 677B9605F3;
	Mon,  5 Oct 2026 07:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3R9j5N2t04AB; Mon,  5 Oct 2026 07:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 042D160606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183875;
	b=aw2D8+4svSxUuJKT3ckwLZblvvSQ9mX4MllfoSL53zQU12J+egjbOGicvHvcHKDuzZpS
	 HmvM494qtPrHYFAu/tvh33BpGWuAtaYBFiJqYjhz7sKiY2XTOBZSywS0EPk3uqh+KDkan
	 ArfuRuQhgGbnhj2Zzk9gY49Ip/xge57qbg3Kt9v5lYpQU7gpwiZwbXknAo2vxL/Hz4X9P
	 IKh7k6Y046Efq0uIX3iOdW5gt8RYYhevici5i4kKDCjUBeXEDiDLCPo4VE/l1ItXZLgGn
	 OmK/jcRLzr//A5z3y1LQCazxx7J0gz5/dk6pVAysef7d8MWhVQhZ0GxDxnQSUSw16Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	b=UYL4o0s5PiWenm6ndY3Fawz8pyk0BajbSUH2AfzRbiFK3r60+4cT8StQAykn2zfOmkPe
	 ObV34mx64XxpT37V5lrOtVjgnfbW+X/iXRurpHQA5+gcg3TbL0hnbM8GcgY1C5phvJFqq
	 VGPsLMnKQB76DrhIOqtkKfIYbpe51xhuxj9ftbZB0lXRmFQ6SiYTn9KFaxjfiAYoaxTnW
	 sNyYCxlM4YsmzxCutz0WWzvrhCOAfHOZUI1iHS9f+i1BQbarL3G6kCRXluEKuqnUz6ZUK
	 StK+f4JYP3zLE1JC1w1xFj34ijN5BMVrT6D25q47xoC+HvKWw7IZxkv610WkG3ite3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KLHSaSyk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CBpfr0sx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183875;
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esY2feohZtiu3apnZhoSgXbeYUPAXd2Wd+mkTtKchXYt787t/lYHLxhZUYA1OSSLN
	 67iwjw73gyFEzKOHj2iJuPvKNx05U7S14cXDqqbeV5vSxE4PYonWhNlRXrYUn6j3Ae
	 q9zvTJfGsNG+odZ2gzTK5mpLt+VVB/A5dl6HZp5zXmYvwl0cJ+b00nWhlBqGcaxkfX
	 TS47k9WCnPuNP/qP/9R1UsZKKwrzbJTMXzdba+Kd4rc9o7ZiUnQ8Mhh9oenQ4j0J1t
	 e0kVNiDZV9Ow0nboZ3HgtfvicZEXaCVb4MHDoduCcCGutZtXL+DbGgkFDO7lYtKvwX
	 7D9E/691HLg4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 042D160606;
	Mon,  5 Oct 2026 07:04:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1BD1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D19C6605CF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evgSHpMWWTn9 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A902C605CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183764;
 b=nNvJ4iBkRRL39KiEoCiStVGSCLYMeFOyOneJO+LRa7QsGZZgz4hyvFb5kDlNTM2s1BzM
 FvPrbEg8f4qAsRxy0BanJQqLJmixdFRVngdhxYzbz8ga7Tz2HLS5JmNKuS5EnfdCCFwJp
 ZjOljx5pLg7Dm2m6eyli5HmbcGkMXOGRlI3EgsbwIMdqerES5gKSCHbnz5VBDV9OOkVS4
 FcbCjfF09Pbho8blJMWC0pahZ+Nw8OsjtnsvIc+pvefMBJkFU6FyFbNH/D3ZsiGQd91uW
 SsE5zfVoRNJZkcQYUB2TPtpvYIf+A+jBd+iT9uZtqFimqrO47hkPH2LiT/PujyCPj/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183764;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=Hm1KplEiyDGIfldz+tkk3bjeZN/r7DLPcqIfh1Hru23ahhC3EMsl+V6sXvFIyzPQx0l2
 Dp/ENX+mDy0V4C+NYtHsGBOEXokY9Up4HrFpxGKpHyX3KFCnasUO/nhayTkZceikTF9vc
 Jyap7BAaFJ6sFqcnjaHUMPS2Rzp5ZUD7tFpLeJxPMX2fLzE5ARCKbjiHXB6JT2EjRnu88
 amy1Uofzhhkepg3y5/RwfT8EiRxL6VRnQq6jFt+Th/S3g7TgH01Q1C2L8p5FpSQFiFZno
 gC94nOCvfeFXyl+gzqfOdJMB91uvgrPIKn3mPoDNubS1wIaOGNY8bYcxJc6F5rOvKrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KLHSaSyk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CBpfr0sx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KLHSaSyk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CBpfr0sx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A902C605CB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695101K5470483
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=; b=KLHSaSykLYiDGsYT
 MtJRFsqa2dSHf7oWLnMgvGyvHEwDqVF6FoOYUfx7YYAvoyZoe14aa4gA2/re7n83
 PfQ10s1FK7RKORUQ9Vn3KrtfW7mzkfApQt7RQVUTqwGczJENzGAIG1JNAkur6HXp
 DBN+HEQ3Js7NyL80Y7Moh6BUtCFyk3d0Q4qiWmF8sNknauWEuqJzTKHEAn0N+CNs
 VXYi4fvdEJh6iYVYjFGB00gfEs9BZZRPJeTEPGtgcAUoY7a63nA99Bl4EXvMUJ5Z
 BqgPJWFuE8zyH/BIhNXZP5zRckzv3S5b25/Kmmc1UCNZ4xR6/a3LopxYTAelC7xd
 hGAiNA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssuctxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:02:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313d1015161so4547114eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183762; x=1791788562;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=CBpfr0sxCCPWmMq3OV3cgOFImn8LmbaBs6RrrKA67lFEe0R2tYwvic823J6Z00JiJh
 paN7TfyCxHc6MLx2ZFivuuS3BvlGF03Ud+KoOQy40+sD9tDjxbYVAl5H5etak5fvslNe
 AheneYfL4AU/DdU46HKFmVriPAB1fRyPOoPpPOMfJc3Nb23HHiOjNWeo++bdqNS6XhQj
 qrrrLHMKehgjFm+Rwfb251E31bWkthVueQdaNuY0w6EAmguJd9EeUNqmcQx/YfldQ9aL
 quZaFnIDvNzVPOs7aXSOgVPnrGMNgJOHDszvD1wsc2EhiN2/hlKoHSeKK1z4lYwr0Gqf
 6YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183762; x=1791788562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=lOhCj0zJFuViUtwGygRW/JPqKE7P38TTTCK4fuYoOBCYiunrpXDCJb171H9d+huxeL
 X7S/3Rjwhbrqwu9BZqMtJtoM0H99+y6tJ1jmizMhQR0bEft+rbzR4OUNd7BWfh5h2d7y
 XVV0ParyNzhIDkJpuParg+d27l+cHrE0TqkljPt6OdDK/uMOcnI46ocd87booPu7e9Ar
 3YkTYf8OyKmiPkjSw9cFG3L4RbaRg4/8HtSdt1dvfVjU2WEFhpCFEg6Azks+HRAxYD4K
 Ab7axJXmwvRVls9DACxi5PLufXDE7vSetjJMXJsET5Vn8rsBPTEXiPbxk3QW4tlTOcS8
 Cf0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS2y1LOgqzzO5Bf0YmgNdY+08YIKkNw88mfOjcbeDJcJdMBVlZ7xH5prU75Rn4o+3dwNbMZH4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nthuNt8P8/zFb5b/lCQAofbRoG014KczSwwJ9wqxW3s1vc7sl+
 w0Emp9s6+wlbfvjG6AP8fQ0juEDlrBjVqf2ZmHgxODI/DIvSxohg5A9l+ViwEU+LqegIVBjLPtp
 porSz5Shfe+fr680S6c+lgd7yozMAv2yXNwatuJDOuLH6VjJy3rA4U235YDosGjzsIIxRmTE=
X-Gm-Gg: AYBFou3IHnoxj8TY7B5k6v6gyt81s0u1Q2eTGg8/E98gxGLXgoPJM8BOFkXy+EoT3lM
 9L/DxdUsA75dzzkj8TPeR8B8+V4O6rOyHk8/8wChY87mj9iZbQFOxhuIk8CQ8x/02ml5Piq9k3g
 y8WsK+fTrIlbpSVZU0AYKWYFKDtwSBQVLuV0VG4VTmRs1n0jbmm6t0O7Qa7T8zGFI8btt3j0PUq
 OELdCtwy7cvDZTwsLafOzIrv5iE3byMr8CdFK3+mAK8DujLujp6Lg68vbMex3S7yBTQEyIk7kpF
 yaSE11GidtvEi8qTt7l58jSL/PxLrQReCT2xkjjcPNug/FhzwStq1roBvtM+3O62xU27ue2MTQz
 ReFNHkA82o+GgQTyeQshoFJnnN9RCIPZ/uUs+LWnKhdw+v3Z3JxoNLvW+KE18QRoD6uo0D0Vt22
 rRDQ3TYZ7QZgM8oUfbMUmcrAnGdz1z
X-Received: by 2002:a05:7301:c009:b0:351:2f07:1e89 with SMTP id
 5a478bee46e88-3512f072015mr2960206eec.38.1791183761594; 
 Mon, 05 Oct 2026 00:02:41 -0700 (PDT)
X-Received: by 2002:a05:7301:c009:b0:351:2f07:1e89 with SMTP id
 5a478bee46e88-3512f072015mr2960165eec.38.1791183760986; 
 Mon, 05 Oct 2026 00:02:40 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:02:40 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:17 +0530
Subject: [PATCH RESEND v10 01/15] misc: qcom_geni: Add minicore support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX/XnLCHS7BrdQ
 paFXTLWl318eGXlE6dclH8MwWzcO6kBHtTyzkgVvqDWeIPUS23mFK1EcD6YgMOoWND0PdQzDqoO
 OC+rP2M58PyXCuuEWCKOpHGV6XTvc6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX5AIbEB0gDmMc
 aN4Zv0ASg51l/eXUDk2AXBNcrV4/BM1j/LtciBpvLOnYxPBJqRQp2VU4bJpMPNvAl60owD0K2jg
 5LZ3EktdBlh3HK+j6YHlsJvvB5POkDj1vagwLksnsPYUrcVblv+9n6ktvT/TmndmIIQV4/Es2XX
 9i+Y414r2suZi4NWopfueB8AntE/DcIM2YMb8p5Y5OSXUkw4bStdgHDOniIjeSYSAD50kWZfxhL
 ip1IRaaclgQK6/q+KPZ/D2ThHO77T6tlFER65dscOasmJa1CLnOaJI96E2GO9l4jpLGVhOE8y75
 OuM9xUroTSx3AqcIbJ0FrYKNhsTKIHdBn64gKUAqxcXrLxxoY5LLu8SZ2G0KLSK8PEdtNOdJIT1
 BdOfnQOIQCk8uS+U/gKkEK2v3mhPilVUXinASUcSZfeY67hSDecBSsLwaq0nwWdnno5mPi5Gek0
 co6aDYo9stLBAYyp/Fg==
X-Proofpoint-GUID: BBQlfVwGdqGNTEXH9hRHSzsqTQwPLc2d
X-Proofpoint-ORIG-GUID: BBQlfVwGdqGNTEXH9hRHSzsqTQwPLc2d
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac34b92 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OeJ7P-MtQltDYP48I0AA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

The qcom_geni driver reads an ELF from storage and configures a set of
registers and programs the firmware to the GENI Serial Engine (GENI-SE)
wrapper device for the expected functionality.

Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
wrapper is pre-configured for one of the functions defined in 'enum
geni_se_protocol_type'. Hence, the firmware download is not needed.
Only the register configuration part is needed.

Earlier, the boot stages before U-Boot would configure the GENI-SE (to
access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
(i.e. boot ROM) doesn't do that modify the driver to do the register
configuration part alone without reading an ELF from the storage.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/misc/Kconfig              |   6 +++
 drivers/misc/Makefile             |   1 +
 drivers/misc/qcom_geni-minicore.c | 103 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c          |  85 +++++++++++++++++++++++++++----
 include/soc/qcom/geni-se.h        |   5 ++
 include/soc/qcom/minicore.h       |  25 +++++++++
 include/soc/qcom/qup-fw-load.h    |   1 +
 7 files changed, 215 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bde5c640de8..0b7894f131e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,12 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_MINICORE
+	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
+	depends on QCOM_GENI
+	help
+	  Enable support for minicores in Qualcomm GENI and its peripherals.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2daccbba74d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
new file mode 100644
index 00000000000..12c57bdd8b2
--- /dev/null
+++ b/drivers/misc/qcom_geni-minicore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
+
+/*
+ * Register configuration for the QUP minicores to setup the corresponding
+ * functionality of SPI/I2C/UART.
+ */
+static u8 cfg_reg_idx[] = {
+	/* 0 to 18 */
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	/* 64 to 113 */
+	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
+	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113,
+};
+
+static u32 spi_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
+	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
+	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
+	0x00004000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
+	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 uart_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
+	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
+	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
+	0x00000B00,
+	/* 64 to 113 */
+	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
+	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
+	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
+	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 i2c_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
+	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
+	0x00000000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+struct qup_mini_core_info qup_mini_cores[] = {
+	{
+		.serial_protocol = GENI_SE_SPI,
+		.fw_version = 0xb02,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(spi_cfg_val),
+		.cfg_val = spi_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_UART,
+		.fw_version = 0x405,
+		.cfg_version = 0xa,
+		.cfg_count = ARRAY_SIZE(uart_cfg_val),
+		.cfg_val = uart_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_I2C,
+		.fw_version = 0x204,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
+		.cfg_val = i2c_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_INVALID_PROTO,
+	},
+};
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3133f85885 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -21,6 +21,7 @@
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
 #include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
 #include <dm/device_compat.h>
 
 struct qup_se_rsc {
@@ -34,8 +35,11 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+	bool is_mini_core;
 };
 
+static int qcom_geni_fw_initialise(void);
+
 /**
  * geni_enable_interrupts() Enable interrupts.
  * @rsc: Pointer to a structure representing SE-related resources.
@@ -163,16 +167,54 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 {
+	struct geni_se_plat *plat = dev_get_plat(rsc->dev->parent);
+	struct elf_se_hdr *hdr, tmp_hdr;
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
 	int ret;
 
-	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
-	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
-	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	if (elf) {
+		hdr = info;
+		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	} else if (plat->is_mini_core) {
+		/*
+		 * Minicore controllers come with pre-configured functionality
+		 * and don't need a firmware download and just need the register
+		 * configuration. Hence, skipping the firmware part and setting
+		 * up just the register configuration related information.
+		 */
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		if (qmc->serial_protocol == GENI_SE_INVALID_PROTO) {
+			dev_err(rsc->dev, "Invalid MINICORE protocol (%d)\n",
+				rsc->protocol);
+			return -EINVAL;
+		}
+
+		tmp_hdr.magic = MAGIC_NUM_SE;
+		tmp_hdr.version = 1;
+		tmp_hdr.serial_protocol = rsc->protocol;
+		tmp_hdr.fw_version = qmc->fw_version;
+		tmp_hdr.cfg_version = qmc->cfg_version;
+		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
+		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
+		hdr = &tmp_hdr;
+		fw_val_arr = (const u32 *)qmc->cfg_ram;
+		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
+		cfg_val_arr = (const u32 *)qmc->cfg_val;
+	} else {
+		dev_err(rsc->dev, "Neither fw nor register settings found\n");
+		return -EINVAL;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +392,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
+	bool elf;
 	int ret;
-	void *fw;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +420,26 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
 
-	ret = read_elf(&rsc, fw, &hdr);
-	if (ret) {
-		dev_err(dev, "Failed to read ELF: %d\n", ret);
-		return ret;
+	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
+		ret = read_elf(&rsc, fw, &hdr);
+		if (ret) {
+			dev_err(dev, "Failed to read ELF: %d\n", ret);
+			return ret;
+		}
+		elf = true;
+		info = hdr;
+	} else {
+		elf = false;
+		info = fw;
+		if (!IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
+			dev_err(dev, "Error: f/w ELF not found and minicore support disabled\n");
+			return -EINVAL;
+		}
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
+			plat->is_mini_core = true;
 	}
 
 	return 0;
@@ -473,7 +530,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -518,6 +575,11 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+	if (plat->is_mini_core) {
+		fw_buf = qup_mini_cores;
+		goto mini_core;
+	}
+
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
@@ -544,6 +606,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+mini_core:
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..3063b37010d 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,8 +77,12 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
+/* SE_HW_PARAM_2 fields */
+#define GENI_USE_MINICORES		BIT(12)
+
 /* GENI_DFS_IF_CFG fields */
 #define DFS_IF_EN BIT(0)
 
@@ -248,6 +252,7 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
new file mode 100644
index 00000000000..9f2071ed86b
--- /dev/null
+++ b/include/soc/qcom/minicore.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _SOC_QCOM_MINI_CORE
+#define _SOC_QCOM_MINI_CORE
+
+struct qup_mini_core_info {
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 cfg_count;
+	u32 *cfg_val;
+	u8 *cfg_idx;
+	u32 *cfg_ram;
+	u32 cfg_ram_count;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+extern struct qup_mini_core_info qup_mini_cores[];
+#else
+struct qup_mini_core_info *qup_mini_cores;
+#endif
+
+#endif /* _SOC_QCOM_MINI_CORE */
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..df8a615b46b 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -14,6 +14,7 @@
 #define GENI_INIT_CFG_REVISION		0x0
 #define GENI_S_INIT_CFG_REVISION	0x4
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define GENI_CGC_CTRL			0x28
 #define GENI_CFG_REG0			0x100
 

-- 
2.34.1

