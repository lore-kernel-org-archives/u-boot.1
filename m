Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED43606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xBnXPAWE;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ECsp3yCu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z5TE1u1F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97D8F607BE;
	Tue,  3 Nov 2026 13:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSNjTOcZM6Ym; Tue,  3 Nov 2026 13:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03B036080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713472;
	b=nLjZPHLB+RWJjkyc6Y8a0DHvVeTliK3gF/Pn/wd2y3aZ4dVry8aaZbW3e5q5lw3cV4uB
	 g/3YEg37faq7Z456VPZs0RTD0VUfJOVtIdXynouhdJDZA7mTAN/ZEJG4E17fHL7gDLxKr
	 NnCu9t6A1HdhrEO5qTZiI+zRuYJYdlDaPVk2SlGA+Jm4uL+cPVqvqZL3jm4pGyJ03Lude
	 wEAgQxLKxVUMsCQQI2+5l29eRK8dbAO1Pc1lDPlxHGCU44ikAw7jkCBgSbWY4TB2LDb8t
	 +YiBwN2gibTp4//VTaHq8/RV8+dWrB4jn9etEeUXijgbFQvC578QoiFqQ3yw2aYoOPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Qz5xuF0ANQmeSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=;
	b=suyU21ENs+NxrcubcgCGf1HK0xNBhwe+gvaD/TM4axIWtT2UITGJEphSAAZ6B6vVdndo
	 jxcSjQH6tilfo9s7oI6H9bsx7PtOF47pAU2H2aTypqMgbTQYD8TFjdkb4YE7XtV/73tyF
	 Y/SVnUBSKxLvvtY/8MRGSAdAhvC+iojBCAfF0iTMNsPEhkF3VXUYV6BYrbfcpBlX7+RRg
	 yRZZhCoMne93a2z76i0qRjftgafA++qKWAkW5wJittulmMcJjSPJrcVo4Qvzh0EBSNiBq
	 8re8h1fCimcpRggyzVKP2yV/bW2dEj4l9fh170xMiqMzBsgw49h+kV36HmgssWYfiIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ECsp3yCu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z5TE1u1F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713472;
	bh=Qz5xuF0ANQmeSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBnXPAWEMMQW63qWgXedWzW6qMULklAyjwW2SjU9/gUkw0jGOKLSiIsnHOhD8D4IL
	 bRkbKSWJ5MiDO6TylIjSwZFG28J/M3B9mO1QXp7DMZSeFBztda9s3MO46tHZGZ/62J
	 DjBWhjdMr3364rCoWt4CE1mV3YhZjlJROu8XPhSOo+kZRU9Rxm2L42Og7xjAIvRJ1e
	 dHMfRPVLUVv+6WDJqty02kgv8hFiYNXPHWmks1AH1slpMklNDhF6PkqeXBD4VRr+HY
	 Yk4eeRLAgFmj+YzZho1P7Ri3lYsVMXp9kxn/jl7XLTCCt4TvVgFyFH5ChUXRxV4f/P
	 bD8NsGUe8PCKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03B036080C;
	Tue,  3 Nov 2026 13:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2F1DA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4990607BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqggyjf7ImHp for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6928E6080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713469;
 b=qxU4/nV61CLWBWYjNLIMoVutzd9MP9+1Vf/u5W3gjD48VsqV6JjW2D1TnwWdkc1tmFL+
 KcrGU0kASnFYo0LGkun19md3fTQvaH0dWOKgDSI+BwsNa9JbMjcqzPFjPJa2ib+jcVLfm
 aeatgkQE/h9aB96WTef3dZsyXFeYpsFjkaQDx2pLYCOU38wn98oQ3FQA8Pk86zwsN25ok
 hlTZAyZcCLWRmARCwz35I2POSKMyzDVNnxnghGcbtaq3TNDxw1TqMdMzrjULq32EQNUzD
 B8ERL0kAvX3At2Sszo2cbgzdT/y0stXpX8m1QFP825q2tavqYduVlJy3Q4h6TwONiHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713469;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Qz5xuF0ANQmeSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=;
 b=b1JQujeZss6rrpBCZCIDUJKhfTNwslFl7rpe0ajcGm53W0xuJL8FwxAIndZZ23+20/Fh
 kFXsjyA+yZ1NAryEhnD78dQ3IRGl68nuLMZgVGihfd/SfdZzpq7Rj99CTlYv9EFalmR35
 bHGxqTRNUrTtHeaeKcYKgub7o1KmI5LFimmApJl1qw0t7PrBAksxMWYeL/aemF48Ci7RN
 WjoImEQq8CLvBvjrzYbsrGvsk8irp/D04qIfzWzY10Z0VGez+tjloyI1sHP1KbSjkjtGR
 7ZZj3Nh0r5G0yumaoiOBwldx9aHBmlFysztIhAN3GefqrWtUNfar9Hqs39ihrXEOB8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ECsp3yCu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z5TE1u1F; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ECsp3yCu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z5TE1u1F
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6928E6080C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ96S2651040
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Qz5xuF0ANQm
 eSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=; b=ECsp3yCuT21KWcBR2UvJ7SoXqNj
 jIlf+Q5ZMDTxitzn4bbee8Je1T+TDhn1yKBv3Gu9uab42Tj+p08ZIT6BSGVRR4rz
 bRJpyJqXCc8rs1GX29kaisGNfSqv2EBEROhVl6QG1ATW4ec6vFiXfPXHcq4xtj1D
 NEWZNDvH5rJMP0jZvuxEOcP+s5ApH6IESgvFIkCgeVTmryYfLW4Ou4R34e8i0Eu4
 wdxViGBmAuq6waxHEzIq02cwzW5hsSV1tP/WzZ9oM7AjLGQ/uNiPfHpGVGQn8SUH
 KgoEaKNrWBFnmBVrItvfq2ynBCPNAeA/N57bJ8L8lE4HDsJgTSqU9mIog8A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r407f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-15c16792146so2604965c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713466; x=1794318266;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qz5xuF0ANQmeSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=;
 b=Z5TE1u1FGEgklFf/XlNmnzmBiV2D9VB5Md+1RnpfDHjmjHhieiYleuXRG1mB7BD6K3
 HgXT8ANX2rhkAv9zrBKONS7p6oyIL9YvcjIt3Q9A5HahAk5NeqHCjjR5fIwXWNMxJnDf
 cna/0z2KyTPhDORKGoJvc6LG6TVCrjnH8q6+VB2A4SP1oS1QqGFILjqxMKxzSUqxQMSt
 OqXvJmlCgW4W/qCoulsxzmSsjdu6x5oy0yWTkaih7GhOR1yDBoZyJVsCt/xL0TJzaQ/v
 kLA9TO8gKWUtyGRmgkKiMFTqxW2Pp1XbhKfTO00ThEsfvlLnB53fEYU68Ff3h+6NBMZj
 3d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713466; x=1794318266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qz5xuF0ANQmeSfCbNqWS2XGR0qNTHqdIg1MauNL41Qk=;
 b=GcfIZ3/4Nj7qB7RFJNvj2TEuhvTfkB4vNPmncojhkinGGBAYJ1BtkHvOHH5r/K7wz5
 CrLzwyk2gERGvhO829SS3e86jr6aqVOjV50NrFMziCI1Eg1U8vXTRp3gTpDIebm04vmI
 vz0JFGJ0rAfYtmMn+aU24W9VpG58LZcx5tOd+AJyLKTGi3ZsXYv+nKU2wMXxhOkB2JB7
 GDostUM6LVV5d0K11nmwONnlNSek2LrgkSe61KvU5RJ+TVhVUOT6EKmPrMyK9pifB5Kw
 mZnV9zQVu/vJUXM5/dFIRguzQ5qyobixmxL0WLrM2KQAKrayJ6/WlA4zzrmZFHM8rtha
 B3YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX98cpT4sKvgJ/KmNNktjuVa+uMt57CUmR21xv03tUlOYOyO+UaC5BFThxO9ofmHT0E9XWsQA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+vTJU0TbUrxqBjcQbnvtoLeWg2UtgdlV1YtqVmq1D4+ZKq9B6f
 Cfq0AsbWBh9fZ27FvS3BS0ymqn0mS+PehBMV/Fq09SObKacIGOAgdGhE8FWvEruJAXXUpLav9cz
 twYcrFrHaFglQG702YVUsBOVQn3dDRr3vjP3t75FSjlzGy5s7PXE4E+duaS7fQu2yOnJniDo=
X-Gm-Gg: AYBFou0JU74IWItdZ2UqKBdUm5CazMJVJkfs3jJ7TynHSG96Q6GWHwnTy6G96RvJxYP
 mRUl7BnFn3ECePrGXCwmoPDp5Xcrit3//AdDyofipBQVYXHt7BN3unEXq+j6jjAmd+6NNKgEvFY
 aMdZQRNXnnKK7e0s5+uAYDinSUv+/b3FSPlVq2yNmsmswgSbM1GeOMZ7sRB4kzU981jDz/d4ovJ
 Zc5cuZeYqw+1a0ligirhbxWCBLiPwFX0rk5wPXC3p9TivG8ZfowhSbaznrde10ewJSD7mo3AODY
 5NsSScpiNzNghWWnpeu5D6hnoLYvpDVlF5FDSei2fOPNi4bMMn/oBrjot/jKuyl2uW2ZPntsXJI
 nnlXYzXctU73+nf45cDiP7u3L9T6V7DKWPXvCpXFy5vbLVbBiAXwdTgffenCC6+6KJYb5zY6ELd
 Yv0QqIaBef5/P7eGZavEbhQfvC2nMcZrVQv1i+ePkbSE5zVCejZo+y0WMMB0yh1AVL0xLK
X-Received: by 2002:a05:701b:2411:b0:1ac:75b9:f82c with SMTP id
 a92af1059eb24-1ac75b9f892mr16318092c88.34.1793713466010; 
 Tue, 03 Nov 2026 05:44:26 -0800 (PST)
X-Received: by 2002:a05:701b:2411:b0:1ac:75b9:f82c with SMTP id
 a92af1059eb24-1ac75b9f892mr16318040c88.34.1793713465188; 
 Tue, 03 Nov 2026 05:44:25 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:24 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v5 4/9] phy: qcom: add QMP USB3 PHY driver for Shikra
Date: Tue,  3 Nov 2026 19:13:46 +0530
Message-Id: <20261103134351.3532864-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PfDYui4hbbUZt16htVosWN3XVgXPioe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX6eMJQIvfsqGK
 rkDSlkp5sF86UTbRq60n0XeOUp2Mm0tt9WN7lqLQjIfGW/xsogvXtbnl9u6W+bj8UEwz1A6ABAK
 4JO8EWytCFvBPotyUaDTSiibwr6Xe9BBKP7wppjwa3M5TEVl3ZRuBwr7cKGQPw2ogQp3NXem4tT
 xFwTr7gDrmLLC7i4BVRWybeEPr17SrGUccensd6mvqkfNGXHB1vRPOxOkKpN34h7hS0f/O0BFsE
 eplcwamDZLwG/MZTMNi80eb2gaLz2kNXYRd07J6UNgDaDX8cqd9emLrlHmokL/2dFBYi3XQVfX5
 1KI9D6mPkvDEP0RDy/QXZDDY6qqk6UMn34W7cWDcSWLtXxS3thk29mN6+emFF4CnSgsnuYGwaHq
 tzHdFzd8xEr4NeSxbo+0LpxzP0yLugB+hjo017NaKVKjydwD0+fNlG1B+C1akvCalw5hgCbpNhj
 g+dezM42R3rVbbiFJFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX8ibpBMYjV6EF
 Fp2qwO3o7Ys2AWKwndLA0tLbh/EaFrKUXnMb3b2eZGQ74MHcBXPH/W/7VBfH0RUJTBbnt/uugRU
 2hO+810wbPzvtvKWMLhYDZKNh+LHO+0=
X-Proofpoint-GUID: PfDYui4hbbUZt16htVosWN3XVgXPioe1
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9e53b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9AdMxfjQAAAA:20
 a=EUspDBNiAAAA:8 a=E7ACQvf2dqk3oRFqq0AA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells = <0>),
which is not supported by the existing QMP combo PHY driver.

Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
initialization sequence and configuration tables from Linux
drivers/phy/qualcomm/phy-qcom-qmp-usbc.c[1]. The driver is a
stripped-down version of the Linux QMP USB-C/DP combo PHY driver,
retaining only the USB3 functionality and omitting the DP logic
that is not required.

The driver is selected through PHY_QCOM_QMP_USB3_LEGACY and enables
USB3 PHY bring-up on Shikra platforms.

[1]: https://github.com/torvalds/linux/blob/master/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/Kconfig             |   7 +
 drivers/phy/qcom/Makefile            |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usbc.c | 534 +++++++++++++++++++++++++++
 3 files changed, 542 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usbc.c

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..b1748055448 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config PHY_QCOM_QMP_USBC
+	bool "Qualcomm QMP USB-C PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the USB3-only QMP PHY (v3) found on
+	  Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
+
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..2e9d3b35294 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
 obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_PHY_QCOM_QMP_USBC) += phy-qcom-qmp-usbc.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-usbc.c b/drivers/phy/qcom/phy-qcom-qmp-usbc.c
new file mode 100644
index 00000000000..286ef331a6e
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-usbc.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/uclass.h>
+#include <generic-phy.h>
+#include <reset.h>
+#include <power/regulator.h>
+#include <usb/tcpm.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+
+#include "phy-qcom-qmp-common.h"
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-misc-v3.h"
+
+/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, USB3-only PHY */
+#define SW_PORTSELECT_MUX			BIT(1)
+#define SW_PORTSELECT_VAL			BIT(0)
+
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
+
+#define RESET_SETTLE_DELAY_US			10
+
+struct qmp_usbc_offsets {
+	u16 serdes;
+	u16 tx;
+	u16 rx;
+	u16 tx2;
+	u16 rx2;
+	u16 pcs;
+	u16 pcs_misc;
+};
+
+static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
+	.serdes		= 0x000,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+	.pcs_misc	= 0xa00,
+	.pcs		= 0xc00,
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
+};
+
+/* Per-compatible config; add a new instance here to support another SoC */
+struct qmp_phy_cfg {
+	const struct qmp_usbc_offsets *offsets;
+
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+
+	/* clock names fetched by clk_get_by_name(); "pipe" is fetched separately */
+	const char * const *clk_list;
+	int num_clks;
+
+	const char * const *vreg_list;
+	int num_vregs;
+};
+
+static const char * const shikra_usb3_clk_l[] = {
+	"cfg_ahb", "ref", "aux",
+};
+
+static const struct qmp_phy_cfg shikra_usb3phy_cfg = {
+	.offsets	= &qmp_usbc_offsets_v3_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= shikra_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(shikra_usb3_clk_l),
+	.vreg_list	= NULL,
+	.num_vregs	= 0,
+};
+
+static const char * const talos_usb3_clk_l[] = {
+	"aux", "ref", "cfg_ahb",
+};
+
+static const char * const talos_usb3_vreg_l[] = {
+	"vdda-phy-supply", "vdda-pll-supply",
+};
+
+static const struct qmp_phy_cfg talos_usb3phy_cfg = {
+	.offsets	= &qmp_usbc_offsets_v3_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= talos_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(talos_usb3_clk_l),
+	.vreg_list	= talos_usb3_vreg_l,
+	.num_vregs	= ARRAY_SIZE(talos_usb3_vreg_l),
+};
+
+struct qmp_usbc {
+	struct udevice *dev;
+	void __iomem *serdes;
+	void __iomem *tx;
+	void __iomem *rx;
+	void __iomem *tx2;
+	void __iomem *rx2;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
+	struct clk *clks;
+	struct clk pipe_clk;
+	int num_clks;
+	struct reset_ctl_bulk resets;
+	struct udevice **vregs;
+	int num_vregs;
+	const struct qmp_phy_cfg *cfg;
+};
+
+static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+/* Quiesce the PHY; shared by power_off() and power_on()'s error path */
+static void qmp_usbc_quiesce(struct qmp_usbc *qmp)
+{
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+}
+
+/* Fixed orientation by default; use TCPM orientation if available */
+static u32 qmp_usbc_get_portselect(struct qmp_usbc *qmp)
+{
+	u32 val = SW_PORTSELECT_MUX;
+
+	if (IS_ENABLED(CONFIG_TYPEC_TCPM)) {
+		struct udevice *tcpm_dev;
+		enum typec_orientation orientation;
+		int ret;
+
+		ret = uclass_first_device_check(UCLASS_TCPM, &tcpm_dev);
+		if (!ret && tcpm_dev) {
+			orientation = tcpm_get_orientation(tcpm_dev);
+			if (orientation == TYPEC_ORIENTATION_REVERSE)
+				val |= SW_PORTSELECT_VAL;
+		}
+	}
+
+	return val;
+}
+
+static int qmp_usbc_usb_power_on(struct phy *phy)
+{
+	struct qmp_usbc *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *status;
+	u32 val;
+	int ret;
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+
+	writel(qmp_usbc_get_portselect(qmp), qmp->pcs_misc);
+
+	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
+
+	ret = clk_enable(&qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+
+	qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+	qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+
+	qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+
+	status = qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
+				 PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(qmp->dev, "phy initialization timed-out\n");
+		clk_disable(&qmp->pipe_clk);
+		qmp_usbc_quiesce(qmp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usbc_usb_power_off(struct phy *phy)
+{
+	struct qmp_usbc *qmp = dev_get_priv(phy->dev);
+
+	clk_disable(&qmp->pipe_clk);
+	qmp_usbc_quiesce(qmp);
+
+	return 0;
+}
+
+static void qmp_usbc_clk_disable_upto(struct qmp_usbc *qmp, int upto)
+{
+	int i;
+
+	for (i = 0; i < upto; i++)
+		clk_disable(&qmp->clks[i]);
+}
+
+static int qmp_usbc_clk_init(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int num = cfg->num_clks;
+	int i, ret;
+
+	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
+	if (!qmp->clks)
+		return -ENOMEM;
+
+	qmp->num_clks = 0;
+
+	for (i = 0; i < num; i++) {
+		ret = clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to get %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usbc_clk_disable_upto(qmp, i);
+			return ret;
+		}
+
+		ret = clk_enable(&qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to enable %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usbc_clk_disable_upto(qmp, i);
+			return ret;
+		}
+	}
+	qmp->num_clks = num;
+
+	ret = clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
+	if (ret) {
+		dev_err(dev, "failed to get pipe clock: %d\n", ret);
+		qmp_usbc_clk_disable_upto(qmp, qmp->num_clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usbc_vreg_init(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int i, ret;
+
+	qmp->num_vregs = 0;
+
+	if (!cfg->num_vregs)
+		return 0;
+
+	qmp->vregs = devm_kcalloc(dev, cfg->num_vregs, sizeof(*qmp->vregs), GFP_KERNEL);
+	if (!qmp->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->num_vregs; i++) {
+		ret = device_get_supply_regulator(dev, cfg->vreg_list[i], &qmp->vregs[i]);
+		if (ret) {
+			dev_err(dev, "failed to get regulator %s: %d\n",
+				cfg->vreg_list[i], ret);
+			return ret;
+		}
+	}
+
+	qmp->num_vregs = cfg->num_vregs;
+	return 0;
+}
+
+static int qmp_usbc_vreg_enable(struct qmp_usbc *qmp)
+{
+	int i, ret;
+
+	for (i = 0; i < qmp->num_vregs; i++) {
+		ret = regulator_set_enable(qmp->vregs[i], true);
+		if (ret) {
+			dev_err(qmp->dev, "failed to enable regulator %d: %d\n", i, ret);
+			while (--i >= 0)
+				regulator_set_enable(qmp->vregs[i], false);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void qmp_usbc_vreg_disable(struct qmp_usbc *qmp)
+{
+	int i;
+
+	for (i = qmp->num_vregs - 1; i >= 0; i--)
+		regulator_set_enable(qmp->vregs[i], false);
+}
+
+static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_usbc_offsets *offs = cfg->offsets;
+	struct udevice *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->serdes = base + offs->serdes;
+	qmp->tx = base + offs->tx;
+	qmp->rx = base + offs->rx;
+	qmp->tx2 = base + offs->tx2;
+	qmp->rx2 = base + offs->rx2;
+	qmp->pcs = base + offs->pcs;
+	qmp->pcs_misc = base + offs->pcs_misc;
+
+	ret = qmp_usbc_vreg_init(qmp);
+	if (ret)
+		return ret;
+
+	ret = qmp_usbc_vreg_enable(qmp);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(dev, &qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	ret = reset_assert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to assert resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	udelay(RESET_SETTLE_DELAY_US);
+
+	ret = reset_deassert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = qmp_usbc_clk_init(qmp);
+	if (ret)
+		goto err_assert_resets;
+
+	return 0;
+
+err_assert_resets:
+	reset_assert_bulk(&qmp->resets);
+err_disable_vregs:
+	qmp_usbc_vreg_disable(qmp);
+
+	return ret;
+}
+
+static int qmp_usbc_probe(struct udevice *dev)
+{
+	struct qmp_usbc *qmp = dev_get_priv(dev);
+
+	qmp->dev = dev;
+	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg) {
+		dev_err(dev, "failed to get PHY configuration\n");
+		return -EINVAL;
+	}
+
+	return qmp_usbc_parse_dt(qmp);
+}
+
+static struct phy_ops qmp_usbc_usb_phy_ops = {
+	.power_on = qmp_usbc_usb_power_on,
+	.power_off = qmp_usbc_usb_power_off,
+};
+
+static const struct udevice_id qmp_usbc_of_match_table[] = {
+	{
+		.compatible = "qcom,shikra-qmp-usb3-dp-phy",
+		.data = (ulong)&shikra_usb3phy_cfg,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_qmp_usbc_phy) = {
+	.name = "qcom-qmp-usbc-phy",
+	.id = UCLASS_PHY,
+	.of_match = qmp_usbc_of_match_table,
+	.ops = &qmp_usbc_usb_phy_ops,
+	.probe = qmp_usbc_probe,
+	.priv_auto = sizeof(struct qmp_usbc),
+};
-- 
2.34.1

