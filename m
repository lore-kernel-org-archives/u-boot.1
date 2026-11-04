Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350B606A337
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gATYvLZR;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BS9oZMxI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Erq9nM9Z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E39C380E03;
	Wed,  4 Nov 2026 16:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5ETm-FxGxtR; Wed,  4 Nov 2026 16:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A80280DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810255;
	b=rgX8UX2ca0zTqtwvIxr3pqvEiRuI4JtudwNZ4jnU3jSRRgckqipMCFLt+el4E0W/HvIz
	 9/T385YbqHIKByoQL7VWFgi9nAzdViciAwim0cfyMFfNvnmQqwCsjLufFE3AoI6qTtGkK
	 bmn8IoXp9Hyr+iz3wvS6veUKl3KAb0e2fODAIqNqXDFvmTVu7lB7VOhWtQ2DIcmsJP6qw
	 EqR8qxn/ux8E21OrAZUKZKW1aR2J+DI/VfFINTnJ2PxEa6ggCwmk2/UZAm/CZqiZNLX/U
	 5AnB9CU8m0DxpVXOo3NOwpf/9Ab0PaaKm632AZ62MIcPPHvumrnbqJ4Gdj4fe68YAHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l0373ATTrH6vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=;
	b=quHfuXDQKTSSFXk71qRBCtWRmmmmLZ57lboBJHg/SAnpNE73k6RLEQ74VWnOoXFrfTfq
	 Vt5agFoIUYsinZH25VAOMwbFN1K245dNLXPrwkjPi3RJxhXUl8F+QSAELEV0mrPmGcU8F
	 Xe7rlEUWJBHwxngkjUtC68lc+VAZZcc95kMQkfykwhIu+uE/WGMikEMHyW+/FXbu65wsz
	 vwk7dCpUER7pUw3Vy2fhYQl9RuRM8IEzrxBtJgrWvYPbQIyHUEaW4JuGkdXPjmoRnN/h9
	 ZnPaq77YjCllMkMHdVapxoiNTP6Fh7Qminp6wgo1gAIIqc8YhEod+Wl9THGMBMEM1Wg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810255;
	bh=l0373ATTrH6vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gATYvLZRMBXmvcAcXCNERoB45JW1z/jSnOdSer0XlSmhq3+qMIgHG37Ybe83B2LX9
	 LlAcKTNGrWOoGETNjydqWiEodFwg2ATL4zLcYbLyYbae7tRoorADk9XCDkT3hr3aev
	 xH0glh6JokO7+pdKeFFlxGd89spJrsIcVlALlz4IlrD2EFi8y77jOroRdG6POZVW/C
	 R9MiyMC4pzplt1t5vAeSp3/ixZL4SRDpYRSyUhsKbD8M8vGUrvvn280D7iZ7hOcjK+
	 SVOmOK2uF2mKEPvN1L9a6gNKdSeU+ndOT3U3vfeVrsJ4tl/aBPnSqIQf8PixyuK58G
	 8mh2SdOliFEQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A80280DB0;
	Wed,  4 Nov 2026 16:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41EE532A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3314141BD6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5bj2cDNI7eA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9288641C07
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808267;
 b=a4BmX5Za7mzB4jXKgGvox4MRtvqyXMchusfV3b/KZf6LkrHkhY0uNK6NXJXxSh6y7SiO
 1jIFabg81bN8HLWnSVHxLREk2SIxETgv/6lQ96maZqekNYYgtGchzc2VbgMpObUtl1GgU
 9Cu3McJwtgMOcewa87jJ1FJBM1WiSst0KKmpyZrWCZFKqWydSd6HNo1xKurxdrB/PTL+f
 xeQR24h8B/fv6he9v81x7QJCmON2Z3nK+d2oTavHKOiGQY6MaMEfU+Oe26I5umt5vEE8R
 qOH1SQcLxfMvIPwFImcubw6lMP/5o+fUVMJsLr7wHkkn4qWBzzme0AvDOfsFpiX2ZrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808267;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=l0373ATTrH6vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=;
 b=hzjiWkxGn+XfL6dqzUWYwNIim+CQfVgLzRha72XXNSIVFvRfIH0uZBhS+hBPrb8J62R/
 OHEc0PkyWIFj92Y5A+26mi5yXfHboBKH5E4Ty+pYOLObZRexyy+sVGndVYcKM9mOGTFTx
 fhVFTTNGxWm4dfxCPDSofNHCdggIgx4MS/wLjsFlsR9Z7/OvF3w45u6Gc944jbVnYCGcK
 0q92qFhmgfQcPJU9/7SKY4TSPB5DUP3jPN8tiPwILm475nA/z+fz11VTPFNY01YaRRCwq
 qrPP9dBlg74Z70oBlwAsQY4XybtZA15r+ykhqyKQuLAIHeajkn8YKLcDUXC+qhoYqdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BS9oZMxI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Erq9nM9Z; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BS9oZMxI; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Erq9nM9Z
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9288641C07
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj8bp2251434
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l0373ATTrH6
 vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=; b=BS9oZMxIRWzVqPgamFX+pc7u6AI
 dkIxdhEaOdO9uA91lEki+w2gGFstB9IIe9T+7Xm5RSs0pwgqSTnbflvk2y1t0hhe
 D2yoHszrXPI7NYnS5G9vyprkjvFUubecnspkLo9W3btym2WGjaEBmGJ29aBKMQ9J
 Dz/nS+h5kH1vA2szJsAeLRGDFMBubFeClYhPhpaU2XpZmQrzpMd5JsPd1pt6U01J
 1VLwSnAyWfYE0lrNzdBWfNrQ6lny0mXCKSl2ax3egqVH95DcWztegXi2UL1jmUB/
 g0f+PhFmUDnVdXRqhsi11J7KjR5y7LVNAlDojZmDCLjh62lD/j+dNSYU7GQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn0y3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so1037015c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808264; x=1794413064;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l0373ATTrH6vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=;
 b=Erq9nM9ZYCETb8UQzFiauX67tCwz7YkN7HX5EgvPdZqJJWq8Yz2+bjDPntmSFt8Yw2
 0/wRfVN6SWhCCqS9AZU01e582thygZraG9ecZc8IouzeaspqpGkMMhslFKhx6zLEQwS8
 Xmm/FOwGOr8EGfwO/6JDsn593AN6GD0Dw6EaLzo5I/7yzZg6YY834QPu8sYX030+ijRR
 AW/0j18IzMZuLjD6qQMmwUHZLR+/DE8B+9hJEWPlz+x7+YMgEOd77cNR4OK/OLo1UiD6
 GwLvG0zP+ndnAvdfaQMbxMHhIlj+mTEY1LhOix0Pp6KMwwzZ5zm0Jz5fP1/u7ztZUxw6
 SfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808264; x=1794413064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l0373ATTrH6vgYCISBoBGEPuZCdM+9HAI6ZZK85t+aw=;
 b=ta/igbkVh0sS/TCCEW5lrPX5b3izgiBpEGYYuRehAOSTC7Yx387UvxbxLg/p9CfPhM
 m4NSPDX3TGUygV0PeAV7otkTLw5WW26Z0MGNkFAuCSeG/QLqdYNtUvcqVQXUT8gixWGI
 PDHRjLgHS4O30424f5athdT5exg//Jv6hGUHaGlK7a/EavEa8GFjgT4IVPOoEPX7lDCg
 7JOC963/DNmnScviQA53bb/2pcuVv7pTWxjz83fuoyP9mV1/uE01wfyxF1ZEMj5DFPbw
 dY8ZF4u6/IkAJ6vJOjj+lTNG2hpZo7D7c0BZXOAJx8n1nqBi478hxTRRw2+cJCW22eFV
 76+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByUnbyclRASr0H+3GcoOaNTk+VlEyb9EA9j2fEaOIqJHXSVugVgyCPyXzP64ERkPx2jcxggfCU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8hnpeuVkGyE+NgIY2g4V6Zahn+ns3uuht967QyzPhmvrlS3lat
 pte99bC7VC2IbV4csylUUF0xvbj8sTOPqZvM2Syg5c7Iix1WSDodFee9vjHkM4S4DnAWKoCmq+R
 iMbuAKOfADMh2+QXIt+DLMRnEC8L7qduWvjTc8EvcMKYeiAQMnJU+e8ygEs/9g89x+k8Iqi8=
X-Gm-Gg: AYBFou3+Pg9vmJOcYMjhBDhcQVeLp7x8Pnh6BlNqX0xPmnqEv/mmmd7erAatYgT6Wwn
 G10uTpAgAo07gpi/PyQ/aOFQJVQ+vPB4gngpWQLQp6FNGNEURE8y8vFqp9nnZ47bhojyXE1xk2U
 Eiz6DltzcrU7NC/DuQvtZmePfjBmaDyH3QHHIHOSHrk64kHeomXBLgR01WZeSNOOMWZkfbEDm94
 S8PczTqaB8QQMy9fB16DeHQBvE7WT2M5XDjmj8vC0g0l0wiViMqrIjPMWiD++kQSw59+cN1VWTQ
 pEEPn92249Kr+mlP6DW+WffD69VVvQDeuJZYBIagM4vYjjzDL6FcqwwV5WG9+XQZKRGGG9Fje6h
 awpKna/DpQRYhFipG3k5gZ/q6LODB+7VR4LaGVr6AiXy7sg8z0L86DgOwhjyWkMwp/BIGCNNzZ+
 LpQGTLTDQJbEHp8jkPj81Oaazonc3Nc9WyVwRb8Xbz/M4XSXvuzCufU8qp9m8YQemE6g==
X-Received: by 2002:a05:7022:628a:b0:1ac:1343:fa54 with SMTP id
 a92af1059eb24-1ac5bbb4863mr33011638c88.14.1793808264128; 
 Wed, 04 Nov 2026 08:04:24 -0800 (PST)
X-Received: by 2002:a05:7022:628a:b0:1ac:1343:fa54 with SMTP id
 a92af1059eb24-1ac5bbb4863mr33011587c88.14.1793808263355; 
 Wed, 04 Nov 2026 08:04:23 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:22 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 2/6] board: qualcomm: nord: add chainloaded SPL support
Date: Wed,  4 Nov 2026 21:33:54 +0530
Message-ID: <20261104160358.1131694-3-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX34w4g1uLTUkZ
 POw5bofEe5kS4GsQb8yizHwj/MjVVi8pzggz8/J3HBxYUmU/jVsPKKpeImAW8+NlEDQysQ2X15S
 3Crs8tEHVrs1adEEeStwZ7efiYYnvOiBSzgd/Ijc3OSJFoV8lIIDr5dNWpoKVNPsc5pt779mn1S
 sK+c4mHXIQw+2H7mvplUxqjowr2WHC1X3ZWhnUmO6dLlNE+tZqF4hEq3Je0PXzb1eWpHNbWxDvE
 znMyQq5gHr+7xaQ2Sms60bAUTD2DMcuu9lBIIOI8d79TSF91GpldD8dnOZcKGuk3aGzQToMiYtQ
 xmVL6cobbknddWPZge0yakY9fDevarUyiF1VzGfMDGdJJytf3vGcmpmTcD2yQ2MH83o+d/2vsOP
 mDobkJrssKIbbL+2OjuaeO8vn9bXyaDLvIy1dN86sVr4fefnlHenxvNFupb+balBPvdP2nMRSiz
 DK3jAnWjK3D1uw8Kp9g==
X-Proofpoint-GUID: I8eLaRejhodps1BXfVyU-IaEVYYW9y9u
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb5789 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=NcgTXU-0Dm-f6bLw6dwA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX8qmOh5ZcvmN6
 5i/mMPuuiCSs2TLxmbNcJ7R+muz8jnkASyaRtdQXRI83WckDRYxRJ4pPMCNYpy6Lcm2V7TdhtWf
 5Z+DBNUn/JUH+FeqYFOJ4LmVzVT65/s=
X-Proofpoint-ORIG-GUID: I8eLaRejhodps1BXfVyU-IaEVYYW9y9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040063
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
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

Add the Nord Ride SPL entry points for the XBL-to-SPL boot
flow. XBL has already initialized DDR, so Nord skips the
generic pre-DDR and QCLIB path, reports UFS as the boot
device, and proceeds directly to board_init_r.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 board/qualcomm/nord/Makefile   |   3 +
 board/qualcomm/nord/spl-nord.c | 121 +++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 board/qualcomm/nord/Makefile
 create mode 100644 board/qualcomm/nord/spl-nord.c

diff --git a/board/qualcomm/nord/Makefile b/board/qualcomm/nord/Makefile
new file mode 100644
index 00000000000..98cab0b6b9c
--- /dev/null
+++ b/board/qualcomm/nord/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPL) := spl-nord.o
\ No newline at end of file
diff --git a/board/qualcomm/nord/spl-nord.c b/board/qualcomm/nord/spl-nord.c
new file mode 100644
index 00000000000..2571a56755c
--- /dev/null
+++ b/board/qualcomm/nord/spl-nord.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <atf_common.h>
+#include <cpu_func.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <mach/spl.h>
+
+#if defined(CONFIG_SPL_BUILD)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define NORD_BOOT_CONFIG_ADDR		0x360d4700
+#define NORD_BOOT_CONFIG_FAST_BOOT_MASK	0x3e
+#define NORD_BOOT_CONFIG_FAST_SHIFT	1
+
+enum nord_boot_option {
+	NORD_BOOT_UFS = 0x0,
+	NORD_BOOT_SPI = 0x3,
+};
+
+/**
+ * board_init_f() - SPL entry point for Nord Ride.
+ * @dummy: Unused.
+ *
+ * XBL has already initialised DDR before handing control to SPL. Nord
+ * therefore follows the Lemans chainloaded-SPL flow and skips the generic
+ * pre-DDR/QCLIB path.
+ */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	preloader_console_init();
+
+	board_init_r(NULL, 0);
+
+	return;
+
+fail:
+	reset_cpu();
+}
+
+/**
+ * spl_boot_device() - Determine the SPL boot device for Nord Ride.
+ *
+ * Nord is chainloaded by XBL, so PBL shared data in r0 is not
+ * available here. Read the boot option selected by XBL from
+ * BOOT_CONFIG instead.
+ *
+ * Return: The primary SPL boot device selected by BOOT_CONFIG.
+ *
+ * BOOT_CONFIG describes fallback paths as well, but spl_boot_device() can
+ * return only one device. Return the primary device and reject boot options
+ * that do not have a corresponding SPL boot-device type.
+ */
+u32 spl_boot_device(void)
+{
+	u32 boot_config;
+	u32 boot_option;
+
+	boot_config = readl((void *)NORD_BOOT_CONFIG_ADDR);
+	boot_option = (boot_config & NORD_BOOT_CONFIG_FAST_BOOT_MASK) >>
+		      NORD_BOOT_CONFIG_FAST_SHIFT;
+
+	switch (boot_option) {
+	case NORD_BOOT_UFS:
+		printf("Selected boot device: UFS\n");
+		return BOOT_DEVICE_UFS;
+	case NORD_BOOT_SPI:
+		printf("Selected boot device: SPI\n");
+		return BOOT_DEVICE_SPI;
+	default:
+		printf("Unsupported boot option: %u\n", boot_option);
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+/**
+ * qcom_spl_board_fixup_bl31_params_v2() - Apply Nord's BL31 parameter fixups.
+ * @bl_params: BL31 parameters populated by the Snapdragon implementation.
+ *
+ * The Snapdragon implementation handles the QCSDI-to-BL31 handoff. Nord
+ * additionally passes the optional TOC FDT address to BL32.
+ */
+void qcom_spl_board_fixup_bl31_params_v2(struct bl_params *bl_params)
+{
+	struct bl_params_node *node;
+	u64 toc_fdt_address;
+
+	toc_fdt_address = qcom_spl_get_toc_fdt_address();
+
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL32_IMAGE_ID) {
+			if (toc_fdt_address == 0)
+				pr_debug("TOC FDT address not set, BL32 will get arg0=0\n");
+
+			node->ep_info->args.arg0 = toc_fdt_address;
+			printf("TOC FDT address passed to BL32 (arg0): 0x%lx\n",
+			       (unsigned long)node->ep_info->args.arg0);
+		}
+	}
+}
+
+#endif /* CONFIG_SPL_BUILD */
\ No newline at end of file
-- 
2.43.0

