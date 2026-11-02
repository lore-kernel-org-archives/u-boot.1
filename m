Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C9606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xhdHJkR0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RdGw+vcZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MmYtz0rb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B4F40698;
	Mon,  2 Nov 2026 05:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwA-CovKChj5; Mon,  2 Nov 2026 05:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0877405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598636;
	b=Bx6eIrgoiIx7HRLzcSoZSgnaxG7eRzQI9cn0bSHI8xMbw3aTVjvfCFZngXbINiSLg8wC
	 NG1I1oYZNRY9ZHWDmkDTwyxm4RKMY3zCzqJ2bS2RyomLabtLVrjBZhscK23dbR2dlAbN7
	 ZpJUpSnsaKL/QkykAVRD3hHK9LgkTeN8xTSGJ+hBH/gJ6ZB1mqbOFJeogN7BZ+cV8zvzh
	 ECd6FWRz7j2/j1VpIbYQhJdfiHC5htWbBUBt5ZEQs5/HPe3oqzLHC2VLsTv/6RzTtr3Nc
	 NBlrX775+Lh+Ro+6Tvcd3umUkc0s5ptlZC1/gfSnFgZ77Pv4RaV2iCzGtyfEwwu7zhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	b=CnzCrpsAnsIS+QjdpVtJExO9UWlsM688dCq2sWunUGTMQxCrR4O2FxUTXRJadCaii7nd
	 9eE1f3uzF6GFAn5w/F+/tPV/gwbSzqWshqvTGtXxouNe9gxy0fla5ZNOEE5Z41WTeeHI0
	 DiB8jecf8gp1yXsLuMmXyC6QnltU8/CjmHoUZbR0dfUbuBtqBhTvRH5UZ0mafp17zxiyD
	 iZzYRHZXB+2WCSsCxb4rP6r2ysI9pH+DwK2drzeo2cR0ctbYNXx5Q+bMcHw+O8Sav2XwH
	 Icc6eA2szbmRfm9p/M4xspetjBVkl0csKzzgDGK0mQ6p66Zg3y7AMwZv8KkDLecvtPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598636;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xhdHJkR0c9mGbjnr2OcaPVuD47XbGxcVRzzXNcNU1YBWFs575429TbPO2iFiagcGK
	 5q+qNbcVFengE/0202SEa67jhF6pyn9sJihpNxWNhbyUnwQAYxlCsKtfsvSgcvq9Y4
	 D+CUCEkH9o3t9Y/x0dgmWAri0Iq0N99cfw6SoBn1C/HBfhVpQU7tccc8bn/Z24NfHr
	 d48p+OeVyvrNPXenxFBR+q46p3MEjhExCMrWhVae/xMvUsxMUbbiCLoAS24SRvGdFX
	 MJJ1dSFPeZicuiy8Ckr+HSrnrnlswQauOXfDXIbBKsPq9XOZA4/t1rY5gUBi1q9DNh
	 OcxFea7vCRdVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0877405C6;
	Mon,  2 Nov 2026 05:50:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82C624BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74E3D60681
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eq_9vDCUV0jJ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EE8B606C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598633;
 b=JZ3k7JSfR217u+D8r7E5bfBqRjraP4NxZYrsfMFqcMyEP8Pgm8WPX/ZuU7aK94R3w8Gp
 RnbTGSD5gpIgIwBNsoHaI9hzb51PNjfQsXi3gkSMkwB2+E5CMtSraF+MzrK3TJV5XYed5
 LJbyDG92BepZr/0AujTW2rcK0dbZpzWnGiENfANmUNmGAzTtlcyACvy3FpZK6NzXiqiLD
 uZeUrpl1TCh9Z9cAGIE6R4JoDcSNxnWSGvoJeCvRXl+McK8lg/SGQNeoawd0n3ih+joBR
 88Zo5n4YGRb2LBOP8sz1xQFt1qdBjwypdq/irzqr5LfjsBwzHf85eXti+wlfBP34cKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598633;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=cn2lZpaiDqcAjwM9lTvW7XiqACWks/Q/0W4ZV4m1TW4ugML7XfSwZDzopCMkENpH56ga
 M2lCsxj6fnNXY30M+YKkFGjGpdu1pEGXb8DcgpUC4SVeXHjhUZ5Q1HBGVjDZip/Og08SZ
 AAf6HFF6TQosprpUdL7CTRDgc0MzcUqd9Iik1etRiVmsrae6aRjs7CcgFw3kl4m2ZMsXZ
 7br3JVLNJeFDTL+e6jrOw74j5/JXofR/0WoHQLT5Zov/MPEId56xAdrkLGPzaOKT+agBH
 h11y1XZm1YswUWQIJIQH8LZA9kSDq59PlLtcIRfA+TT97iS6z+lCpOawIPIoW5k8lMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RdGw+vcZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MmYtz0rb; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RdGw+vcZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MmYtz0rb
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EE8B606C9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24DHQd2433620
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=; b=RdGw+vcZzG0MmODi
 QxC3VhKIkevCSo/y+cRV/LnBaWImr5cQOkAy574NfFwmhhDxQIAuIHPtKGFjw2OH
 osh3bZbcSba/Oj5d7EGeb6Nbx6jK2zpOflFZ1bgt2ALKnG0R3Xk7VFTroIjh4C/l
 lmD/2AUKrb/S5/mvjd+gi5b/tnC2HodKbP4lYrAkHqyQesaa2MeUxlV/sspY3X7+
 DczoMPrCtdfGEv2ryEDyf+I6Zxufx2kFqLNpsS5sVR9JvwrklBZRIxJb4Y4VL1m5
 oGnHA74LzyBzEk1e6QqZsGpw+PTEWr9bLqXjOcxw39xQa1pO7b+ljN26yu2mHFg3
 AUhs5Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka608ba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so6011102c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598631; x=1794203431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=MmYtz0rbwoDeJ+JJnTvfk6FYwgJamp+NqgQpFzpMCWfFGKk5tlWqKaWWVRHzMSMVa5
 0AYndSXKgGlCbQU2/hOTrgODdbk+Qh1hD7R9MP7d6GQHEA1SGBgibIvrZY5arguJBs+G
 Y4KpOSde8czaDIG/kUnTicfcpkA7uh82mozs2Ix6t2h7KR3gbHtB+/LuljlUto5aP1H6
 ei/Lk6rckJdm6cYsX/aFKDr67pQ0iK5E85kaZFAm9KTlRWyr/xMtBH7s1lUNfHPKsnSy
 kavYwVE38YvSdzeifi+gLf+HlOVLla/6oCyoR4w4wOELD3cfa669N0erDLET2iSj2VKY
 rhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598631; x=1794203431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=eVbXJ5BeUWqx7kqa2vjhdCCemEA6N9OI0jA0gqzoUB8SElgva9YQa0wJJdHVfo4A95
 X4n4Z7Il4FxSkJK4bshmZJjFOQICN/wZkPgjsbIiPdWTdCBIWFNFZIcAJF2z45Y0YpnS
 bZnKq3b4aAgULDFeKLDWcxfvTTKOb1VAGAhR/3W+5GTq/ygpSxHO4snVCEUmecse7IOI
 xYjQNGNmoRa5FmcZNi1UO6fI453V9TAmNl3IfcPnHnNQcAFL4BDgnLEWo5bPSje10cjr
 8CQeYHfvUDkNdXQdJBBVPqHgRYGL0MqZn3dEGn586mbiBknMxlEu+Mld/gV+kZ/omuOg
 apUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMQxZKBWzKYCSbUd34BftQIKolNwmg67NZXU09LTINDVMURfJWGTkvT0Fsl4VYhsqE9kRi1MA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIUqwwBATFmlimE9mQq/d/ZhHtGsMYKKpLgAaDT6Essdg23i3yg
 uf4xdQzo/e/+VPmWqp5zItt5ZrTuXPms50Np3DQ7O47mXTEKCb32WH0gbt9lmU2FAQPfc/SAgk2
 MnuKt++MiL7MKuuCw/ABTzqx8Yyg5pIFatS6oqSAOAaYhwY8Y0DkhqGHyC3+9AmGbi8zVT0Y=
X-Gm-Gg: AYBFou1n0cMHqiTwrkZ+5zf23W/3MaFHQ63RSMiIKGilp6I1lMi3bo6hN34kLVBA67H
 U71hgMIrXDOTKOtsA/toIVJrx+fQnDvH7TeQYqFpU6HBR8Exkg+w0B469lSksY5LGQQhPhX17YG
 0+NvV68FfiQqUV9toXUCJFV2mzamVIzNhwt3F9mytBfyI33cgJQGHqSmwZvgN7xqJ8u+jCvH3ZI
 BQUDboZ/vg9ntpxs0mfgG9w5ZV6kxj7AJoUHpwE+S6/GBEsLGQ6v5zEHlKi3j6+Bns7qFALeNEE
 81nDE3ayWTRxOfnBMH7bxKLxJZAyu8S+hF9SCnKwfuKgfQqkLJYPjbVukn242LnDZwxzgaORs7o
 N8P9G1MB+Ct7Z438JMjWttVr9PDxC/af4ySbwA6tP2dRlMG3+C4MmQ3HfQsZwKONPOEeQ3RAohF
 YVrf90ToTY5aE56N4xQL5itR4b8Q29UM1QEAFNQ53mevARkOqBTCi5nj7i1l/wyknhLER5zktjW
 GnLWA==
X-Received: by 2002:a05:7022:3b81:b0:1a3:f515:9c64 with SMTP id
 a92af1059eb24-1ac557770cdmr15436050c88.6.1793598630641; 
 Sun, 01 Nov 2026 21:50:30 -0800 (PST)
X-Received: by 2002:a05:7022:3b81:b0:1a3:f515:9c64 with SMTP id
 a92af1059eb24-1ac557770cdmr15436007c88.6.1793598630109; 
 Sun, 01 Nov 2026 21:50:30 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:29 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:43 +0530
Subject: [PATCH RESEND v10 11/15] clk/qcom: add clock driver for ipq5210
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-11-224d421c6201@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 1pIdWNtJMPzQrlWInt3mJrgAs2G11RF2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX2IA1InLgKO31
 JCZxDHqmYcGRiU3YSPY0l7hXf6BoGGOZNWKmrcbc3jrx7rflMdNilou9hIEDGUMglGndYcWcc++
 XEarzS3w5GkKjPdc6gVQ8nxr2urxGhA=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae824a7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=kETcTEvuJSViBEbj:21 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX4IH2vRZrYUsp
 G7DBH4PJGt0jtXzyM2ISDN924mnfWtp/KD1wEXMFn4vzSyIP0NBcYvCLFiDQrdrmWpVki1Xm5Em
 m8at085axrtFZ9Qo+B4+rby9ll5xJgfAdhrMNzQ4A7TqMscFMsXJ//j8NA8JOnJf4+Eb930foP4
 QfmMtlK8cjDHOmGNDNORUxnN8FLY4MhoLTHF93y6q+c9UVlYN8ZrCrYbrsWbhbUdlhXHVFogZQ3
 nJxTkA1J0rWdAcXx6E4T0UFYLG0Hp05hafvEGu41mjStBzt+ELAiMRJKX7gjQ1eDiuH1gCxkQiE
 iYkx+EaoQRag/WVuibTpQK1KRRVNNiCDrcA5wfeKo/4QcTY+dEoM7qeHbBNcscAFwcwrRq9LrmB
 aG1UiZnG8DvsLNrhQmteP+mu1ln6vCZn0LvLXXyktAQU8lNTPm5F2eMIM1DVX5mMKSVo/0dVkLd
 HOOWrb+G+pbjnIoNBmg==
X-Proofpoint-GUID: 1pIdWNtJMPzQrlWInt3mJrgAs2G11RF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020023
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

Add clocks and resets for enabling U-Boot on ipq5210 based RDP platforms.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 ++++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 93 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..a142890acdd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..8934635fb48 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..cd82b238bea
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm IPQ5210
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rate;
+}
+
+static const struct gate_clk ipq5210_clks[] = {
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
+};
+
+static int ipq5210_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq5210_gcc_resets[] = {
+	[GCC_SDCC_BCR]			= {0x33000, 0},
+	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
+	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
+	[GCC_USB_BCR]			= {0x2c000, 0},
+};
+
+static struct msm_clk_data ipq5210_gcc_data = {
+	.resets = ipq5210_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
+	.clks = ipq5210_clks,
+	.num_clks = ARRAY_SIZE(ipq5210_clks),
+	.enable = ipq5210_enable,
+	.set_rate = ipq5210_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5210_of_match[] = {
+	{
+		.compatible = "qcom,ipq5210-gcc",
+		.data = (ulong)&ipq5210_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq5210) = {
+	.name		= "gcc_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5210_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

