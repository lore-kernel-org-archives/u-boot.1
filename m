Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAD606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jvjqjtL6;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHfIL8Av;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5YiGnTM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0FE080F48;
	Sun,  1 Nov 2026 10:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duBPcUky3LT4; Sun,  1 Nov 2026 10:19:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4EAA80E73
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528386;
	b=IELZVlHuf4UbuHnESJm3mojirHQaqRHqlcspkGzWbZDFbzHiTdmNO7Kr1APHDBc+26rL
	 gi60iI1SpBUBraHzLNbl213DfX2nTnHuMz5fZHT7nRHl+sr5J57i/Lz6DMxMdWxJnJOas
	 dJznKlNz1NPTpA7yenc2qxiZ8BhAh+r0RI1bOqo6uElG4/EoiCcHuClUk6Kg2PePvIffH
	 FhQ9e9brBiwFIq3HBZpLeEj2wJT5y3JHF5eRgInotjmmWVK72I4INDaopW0NxODCkIDDD
	 LxS1iJN6e6Hy9kJkviqPoNwIL6qIKYcbom3fv6s1wWxmz36nwaTpPRPLB6S2UodNH3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	b=CPjWJCDHC77w07vnJsLWCOMQG9m8TNux87QSv0swUsPx1b7Qxul+4rjCq/U+RPWH5mht
	 3Otxi4i5MF4IBKGgt8fK7RYqxSo0MYokwp07XQYfOd4VfCYs7MY8EXQ6VS2tt/Vdjhl1z
	 njkQTAM//yUgmBwdKVe3S6XYnUvY/bfhJ9BZz7KBecs/p567cqnCNA86xDj44Wgv+yR4B
	 Yy21hRFu0uxaj0YFCa1SHOMi9XG9VCuAzcEF4FGoBLmnwq+lD1zcKLNujWOw+ZwzyLekZ
	 v4oPVZmaE9R2iMCUN9X9NU7OpwIF7N1hNikYVJHBsbbdCzfLs+T34WA3i4FRSFd1jMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528386;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jvjqjtL6FNMcGyOR60GjfVeEJavWHcvhD7kCGZ31P8G4WvfaP5paAF4CIr9ZEMqHM
	 V3awHi4u8pbVh08yNOGfHi2sx6/UO9j68EfPoTw4F154Moueo3C69WaxyOJW/ouXCg
	 5eEOYoVyM6jK2oq4kRbIAHspWMQAz//u2QlFMQ02X45uBJJf39agVnCPjDDdnJ2myG
	 RZbwnWtjO2uHESxSSRJSPv4MryDU4zvpOWubCaBQ+Gi1GilhJZJnPqmME+ajslYb4J
	 de+3IrRTAkO3++BozvljfUlnj/VXurYDqO3U53nL2i5WHNjJao0xDdLbNWCWNtvfFH
	 L/zCg3MXjes4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4EAA80E73;
	Sun,  1 Nov 2026 10:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4F3D323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB0CF40042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t45WixWTs_LB for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:19:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0EBFA4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528383;
 b=Xd12tP5lLdHJae4srxrT768dNmUIUpMGGY76RfWCXo4y0heIBAu4n6xRDYBiNrvfxKum
 xeJW/4BChamm+0N2QPX6+Ip8EfLsLtvT7DTkNM3IFOGOWNCoq0sBTvvd6mYKrrUBqBTzW
 QEfE55ZFMxHikj5I/nOVe9ZeMBnfnaKK0zJFYZJnuW4TiAQsdk3jsObn0dLgfG5EgOnrz
 HjNHoLaFgjYTjsGZLAXZoBN+hVyzxmkUJuqsyRkA5QoOARR9Nfv/g47Rper9UEQ9DXXIt
 RI7qjwkcDaAJRp+6SKWu4E8cCACxWuDQ9IFv9IopKsGdOJD26S+Gu8loIxtKXb++gew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528383;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=Xi5THvPkWZRJaZR3NJYiJb1m7B80FDAomnlM5SqDKOnNZl8xRtf1Df1MsFegm2svgUng
 5YQuorv7aLtGdb1SIY0DqkzM/Koq9peAr1ZKBg5NdoNQ5g01ziIAaEZw2V79W6yVYPgZH
 rdJ8W0hcIaRQ0Gtr9bFdr2ZY6t0aBdpwDZ0Ke+XONzqe5wmP1dKoXXix6rstf3WgcbX7D
 MdmjM8M0qQ09w6v05yWVUHC4lKcDRhzHCLkjQnczXLXTtvZzfMQk3kwbDm/3VAX74s49o
 6Ha205qUL79itdTv0W0xv2hpKW41jtm3e7xT9cpbbXo7ZGR5qsg1NUmm+1potSsIlSg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jHfIL8Av; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X5YiGnTM; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHfIL8Av; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X5YiGnTM
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EBFA4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K21e2929110
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=; b=jHfIL8AvDasxoO5Z
 ew9FRgk5j9Q/pbEh93J1L6I5SplnXxs0oijc1l5lyrEavTfWtH7yyPiJSj4kmbla
 JwiPOMYyO5oCqP9Ee8QH62e8KQ+WIX+WEq0MbEeOopfMFitS7kRtmzB2k5hNjSpN
 Y8+Mu89XJNBqwGHez0RZMVdRWtjdxlsbg8M+u8M2ic1/np9dNDvfTe2eLXsFEzHR
 LFy4nAeaXZHiOVpxiGLpuym92kg4UZykqTzLJKSpZGyWlUE3SDAH9ft8Z0HwVHPg
 Djzs6Y1huxKoBGh+XsJ2qofdHd37/4uYmsfqqPDT2WtLCatN82q49Uo3+VN70T8C
 WbbxSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk2xbk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:19:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so4244300eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528381; x=1794133181;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=X5YiGnTMYtuhDDHKusBgzgPJ6k19ne6SLZ1kWFnl0hMmmiVUrx/7ygA2ReUtT+GbMw
 jMcuSx7PktID+94cmR2gTmoKFGU0t5yrSi8tI2TMuMsay4VuAGFm70+ls4frVLU50x4A
 ORy3V7kV5Chbud86uoxz4n0pMom2mvTNpMRsi2fSebjT21yp2nix3GL3afCW51g4/kx0
 Rm8SLZ1KNaROKBfpxIJQt5alYlF6pmVRUYKSADJA5qz2EQBqHnratqhETEFvAElClHrl
 qCm4DqQ5r5nSOzOCmRz8onJrTVHlmLIjklk8vjI9dQQx2bOXQJe/aIF4oZxYrl5HSTps
 9lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528381; x=1794133181;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=GKinJO/rCZRmRw8xvhyztsQP+aFeEr+5Y8yqIu+ZPn/3mS4KLS6Ds5v+o3Ry99HZEa
 ynG6lBDMlAnG11lVNQ2DZSHqiqpqxd5xFfGVmhwQrRkDpLKeBDv50BeVKgtVaIGsE20B
 iolte6N0jhslJXWFvbuHIIviSBfThD2ybD0WqtxWIkeQ+3ilQDtj5ws7kcrkR6R7+Myb
 mRRqSam6Q3icdP/eIxXg/jRHiPTYfiyvFOASi02CIvtOgYezFAc7BQryNHpLlBqL0s6n
 HS9ujzTwpCjOwzdcSDZhwMPKXBzgZqW+4XtqH3T0HSE0gOCW9eEe1uMB0DLpJ8ZiYfer
 fU3w==
X-Gm-Message-State: APuU4Z+Z1fWhno8d1gjitqhJhcxCylw5eLB7v376zPwq4c+J44Uq0PWf
 NJG0xcNd9q+oknEUoTIiVMAAgZlLkk3QuuPdX8lsw/LGp/0c0ZlX8/5Y+u/+eOdlZdtm/EQAndK
 nqXkzYYTDX/Ay04CtE+BjXMnMFRiH+SDg3QXoneHJnV7L0hMsqY0X2qFC0qaD1vL2YMJcblU=
X-Gm-Gg: AYBFou1CdtPPQ/BZHxEXfgtG7iQHJlxDvcBhj9wWxTyXdQDg0aetYXpK4AcAcsBzlkI
 /vly/jIMTK8CWog5oNKhvV2lgM6q53D3cyFIMGj0S/ORmWn+rfs5P7k/7hF4lIxwO0qgnPDxEjq
 5tFgNsGkRTxYR2Dtg0m0j8fK8n5RcIzpNHVImEkIxefpnE5TYCrKR2MVP0A9rWsIpauczC8oXHx
 L7hUlO0d8gyo1w+ac63jYxHKoQCAjVk1pDC+IEGZ8X+EobooJGN7F6eLNb/QLzjMwLr3o2m7nmT
 six+zlJolA72eT0F2xb2xITva5RKAap0rONYSMLFCANozGInBlVzoRn729G7ol2a7xsmW+o/cwC
 ePHurHaKlLwvCVILzgE/n/W0UdbvU9aMLUd72xqAxmk1ajeHVcxVHJ/pfDnPAD+TqMmUUauRsKB
 7LbB6Q5jr4ZRKJvIOL2ei/J01R0rBIBWqDzrF7EheEgWg79Ws4edidcPMZseVfcDRqaUG0+jJPq
 mU9fA==
X-Received: by 2002:a05:693c:8951:10b0:36a:32ac:ad89 with SMTP id
 5a478bee46e88-36a42225807mr10816203eec.2.1793528381138; 
 Sun, 01 Nov 2026 02:19:41 -0800 (PST)
X-Received: by 2002:a05:693c:8951:10b0:36a:32ac:ad89 with SMTP id
 5a478bee46e88-36a42225807mr10816153eec.2.1793528380354; 
 Sun, 01 Nov 2026 02:19:40 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:19:40 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:39 +0530
Subject: [PATCH v10 1/7] arm: snapdragon: Make SYSRESET_PSCI optional
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-1-e73d5cfedb8a@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=1142;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TfHvwBncGiGT5hjC8HrtPimKPWS1PylfevaI2V49eds=;
 b=29kF8aP+7X0QWuvE75D6Psgo7nJLh3SbcBKSUBr0xNdXMuqzs5SqV2kppoL5altnrp63CYNBm
 sVapm4RXzvKDbtSDz3sNfej7O2gjIpO+LkTKesvNJ1gTRJ+Fx+t8qbv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: wihi0Wb3Pvlbi1X895z9KYVMi2AZlYWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX/cs6bwPZ69qQ
 IEofdF86nk/BIz6LhzuxVdjcKUQxg5L8Q8CRMFBpus+DbP4d4Aq8RhLO3pTAj/fORPoJpK0eVRc
 PL6NoFC7yql34B/DG30V+LW8820soYH9AgNeWz+Zx7g4ZDxFJKmwi7RRJhnaY59wwRdKyqEHRJB
 /y7rvFxSMsEpLhUZ7oSCnMeIl/Bop9BNbQzofpTt1F7WHajtXNu/AocmiEfy51xL4Hmi8N8v1nn
 XeHfuXGA++2I5pa5KXjaC6wxiDUKDP0dm2wQGae+WLzArlF88BXat1pBN7VUby3yehd7Ya547Hx
 Bw/8xInvS0ETVB+WIP0Nim8AdMxhR5PU5YrQGV7P10rZ9RwTjTmDZ89mWrXE2COuJSWyewFm62U
 lnRkFiQYeBkGsUOoyR+roMmm55CHiqCxIO2DFUtH4VetNtpqt9F2OBgabQUn30Qu+Du/eQA3f+2
 BxrIo9SZDkMnOzkW6fg==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae7123d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX139hmCIwXAF+
 h8EH5QCR6oJxB/wyPsHBvih/V9Nddl8N7g9Thkz6/3Ocfr2wVg2EIHvp7lvtk5QxAnGyTWkm2rs
 gELKmtTUl+UdgmyyGX/iTkc6T1+Ik7c=
X-Proofpoint-ORIG-GUID: wihi0Wb3Pvlbi1X895z9KYVMi2AZlYWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Make id dependent on both !QCOM_SNAGBOOT_MODE && !SPL

Changes in v5:
- No changes

Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..b438f0b9c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI if !SPL
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE && !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	select SUPPORT_SPL

-- 
2.34.1

