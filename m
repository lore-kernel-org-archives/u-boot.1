Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IkBy7Xm7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K3DZtV9m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jy9PBqjA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9659280EF1;
	Sun,  1 Nov 2026 10:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzO7GQWe74hU; Sun,  1 Nov 2026 10:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB43A80D30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793529625;
	b=Exf8NYnp7AXFeBjfOY0WasgmP+dPAkVyMeuXzysvsvvIgjt2kYGnaDo1wzucwfCvzxmY
	 jg1oqJTiVGXzuZ/O7zNvpUFYQdQe6C4Cmk0EH+EI9xJpz/FZh/bmp6pS8Uv+HcVW8ZMKB
	 n8gnFFH5nbkuAPNMLg5DNDLtl/m2eg+EnzdfJYtbmbvxMTp+cWtV2h8fmD/Q06JmBp+2/
	 ZlZIWUIYVhYvVwNNHR4Pyju7/EgPBDrBI5vdwAI5HqcgxrjN/WFdAuVvrQQHXMwHLe1Z1
	 IMS+OlwTRdjgkcrzy9aWbH1V8aidtiZEI+MFwK7Vvyw4JImOGSY5QNrJll81SJPKAgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793529625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=;
	b=TJym/fHF7MCHqQQcmI2J27BA+lhsgKN1Sevc9oUvXS5EJGvNvdHu+VdA+GZ5OcX06aQ/
	 lKFIeZgAVTCXVyf5S5OMbQoN8WcgmkVQS4zlDR69/d1CeQGI+eYmS61CmP+zKySRusDgA
	 d+yCsRkY/Yqm0DDIIVL7TvJy3cjTIUKuy6xxXyJuGDrDuTMj25Nfinj2oZVxH5OY3zLAa
	 8b0XRrUVPEPxbk679Pk1ha/t0yeZEBOy2EdnPm694K5Nf3R+UL586JfN3njn5wCkNGz2S
	 MIExd/+Td0HzJ36nLgf24t0A4JngFruepYgxU/KivJIi++BPamUfeMTRF2uKy06XpsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793529625;
	bh=Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IkBy7Xm7/TEkcghQRhFdP6gavD/ncVVP14CafMLI2pNGTGp3Mk03gC1e53CkvXKG+
	 doiykhI76NF1UhenZbx72EegFhP5Y9yI0WeQOaNd2FEEDFz7UcWW6P0G2RPPQqJtE7
	 vXdMmdTY1hsahzZZce/OfKr4bd9qg2Ho/lw24mJFqndvaIeQFMXPdh0LOhKxDIZdrU
	 wksnyILHVbunAICU6QCZDyblbP4YOFUwDhGtCczJYuTIf/IweCO7ivf2erdeZyQYd7
	 EtpxIlQP4zmYU0EHEA78u3Ln3y3gpy2JsIf0+XuFNDmrL7onWCT4FmSClCUnpayGEL
	 6+ivKN2qKZd/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB43A80D30;
	Sun,  1 Nov 2026 10:40:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 109372AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 025A160623
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgbdzBW6WWot for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 249D56061B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793529623;
 b=I01COZ3oNbcJdSZtROR3XnfXVaFHxlfTnkOQ69pQzgaso//0E5jWWRSf6FIeYbwiybKX
 nRhcEJPTkd7tQsReqInR+ivAs8vzD9DkB1QUXqmkXyvIJx/sbbvUAwS1RN5dh7c+lRt5R
 QgLY7246InUtW+rohZVlW+OsdVYy9uV3v9fseUdc94NMe9KDuoUJPJwcYpCoFJBiCKg1s
 wJX4bDUgkGEQQzFa715C6y6iDk6ZrK7Z8jlUrxSjMrGSYmE4YNdh3xJ4UiCqTp+bZBWjV
 oP7b9dAdjYrfEpD5MG64wCGNZB0vzxnuwi92mBPe/KeBDCc3uq80TESMLYqF1NbIxCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793529623;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=;
 b=jcKyV/YUR02Tfl35sP/Nrzs+lsVKlSVfmT5G6y7teA24uuooqpvXa7DD4nJfMFhFUysX
 z+pCey4T0sGWZRNN/5Y49zJo3R1D7OPsL1Kc99CO2TLGEUdyV+ouxe5+1lq5kNz4fNyLA
 gOmOf0pVqW9G13s3flcfCEEwuSKqDHWgXjWP6NXvfhykqiuNIqhxvydjI8Ck8otP5nb7O
 GTLIvG/H8COVoBSo9A/2pgLdQK86MpgZVr8I0ZzHlSzI0jpA5o5L/Bw0q6EdFLl9suJ/9
 eJibFSf+yKUQZ+srHmxgKXnBuJZGYKNy3S11IFDrI5G0SCU2ec8XeB6IKhT2MZb4vjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=K3DZtV9m; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jy9PBqjA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=K3DZtV9m; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jy9PBqjA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 249D56061B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KNPf916548
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=; b=K3DZtV9mI+CHlsWj
 vLGeg6xcvhgtsQAYj3HB+Mr16hkU+6pY7UJre93bnlSB8qeWBiDpSxxFNOwuCsg3
 14aHUPZRV5ifcUSLFRkqSTlDnVo0tYnnNahGF0bt1GgHea5r+TEiaQuAeX8R0UOT
 Frzz6OQwUwM5ooU40LUQWSCKQj9YWi2FxUXUHEo5D/ImkeulOXOXUYZ7tRNc4Rmm
 gIS1G84t2axYpJmylt/bqlbBgwMpJU6Nti3ywL0FsBRowbyNiHFBEknKuFXcOoZp
 TdpqeqGREdvz91KDC1yk9cxRaS/8tI59TGiyU50IFHayuA19CNgcbYmp+YeXBxEf
 DeC5cg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6k9pa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:40:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3698bd5392cso1896787eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793529620; x=1794134420;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=;
 b=Jy9PBqjAWD1hGL/zRqDsovhceSWfstmTeDiU3wbVGtngqnueTlQzvWSmJVsQM4lcxL
 UMuadZc1xWjNkQCt4sss9F5kpHmm/rYkXtUT1O8p34R0NBnOlPTwSSc7mkD4zCptsbgF
 y+Pmu4OkRXJxSSPSNne1Vt4aiZt/uCvUFjfIHkf76H5GNRgGuHe1BwmXsPMGnYtpTfKy
 xu2jaRoLWlkcqdqNvdABoSukWni+BHTUfziWeoEnjJKciPYiLLpsez4Phy/i1Spe2q0t
 1q+wi9AS0RPYJ/KlNE+mrgqeAwNas3Stoq7AN6NnDNpJAiKPeFt781fC1Cbdlv+virlU
 nPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793529620; x=1794134420;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vn6KILHetTm2KGt+GiHxPOUaf3VHEIGkb1pEoMIMvtQ=;
 b=2AW1wy7o3IlgLduFlAd2mPTW8H0vXmL9uI9HHuX0lvBD0NHu4h/9xyZi8JM0qAu++b
 pjRUPKa/TN9Zv2oAXELWIk9YD5Bg4TgMT6/8P7Gfl38Tm7u5UwJA2qKayBRjiQ6093fo
 hki0YZsYiwnO+rKTBPtxsg84IAjP5BZeJHX7lvI2oY1ffbc+eb2Sb8sB9nX/VHybOEDj
 rRE2rkQDVTxutDg6pKA/pzwkendEmjsTDS+vEz8EmBk1g00+a6S/g1s41QXnGOl2U/X6
 ewuF8zzKlHlhSytPW/+H5M71ZE6JUWf3YAgmxDIKmvdZ0XpxWwrTm32KYRlk+Qr+xsY5
 5U9A==
X-Gm-Message-State: AFq9FYIkJHsG22C/s5+52Ksav9MxxtsrCQNTiNSOVbaBIr95HrGp3UND
 8gYTZ6Td7NuevpAwUPexJgo3itlbGlp7y6yTE96ZVFOsiTEm8Ui3elf0Gl0vIPiLvq3wTZolGYm
 73zGoi8Fh/kj8TAa3Rph1TS8A/QHRMNtyHtLmC3CvIlTB+9bM4TmDpszFK+e4OeBZvY3ieCM=
X-Gm-Gg: AYBFou2r2uFD/0xDffvkRtmFDd9z+jMxxdQlWGv6Wnm+MwRNIU2DkaJdH2dfIYsuDde
 FbXIwVDbb7K6IMJEhoT0ZzA5fQcTxAFwnLppbebRgbycQ/jv2J3mR7LZKv4B5I3jn2RTMrakwoX
 j0WSwD1/HJabH7iIdaRIGQB7sZEOiUiMnjcHeul5IHiQ8okEaMNJdyQsuYdVMbaq6dwDyuNdbRu
 jCRc84vRpWjIiIsvw5YQ/nnmRwIxJ5Fbg3+xgeKZA9lpcGFb7HAQ/EcOISjoNiJcVs7cri/WUkN
 oTSWfleSH3KohCyXro7VvaDHNqpWFcssfrxIOYtaNymdWTKLjEGKM6o1gjUlE1uJninjJD0Z3eF
 RVpPBa6eruQpmKM7UAYHeHx+RrMSxVSSW2aWkO+CvC4pUnMcyVRd47JyZvLjB9YhaX1W00jCal2
 Ad6ydVD8dO
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1ac5b027fbfmr8893156c88.13.1793529620435; 
 Sun, 01 Nov 2026 02:40:20 -0800 (PST)
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1ac5b027fbfmr8893134c88.13.1793529619788; 
 Sun, 01 Nov 2026 02:40:19 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1b0a628bsm24916265c88.22.2026.11.01.02.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:40:19 -0800 (PST)
Message-ID: <1e2e5102-3d20-4bf5-ba7d-ab71189ddd79@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 16:10:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] arch: arm: dts: remove Lemans EVK override DTS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-6-18ce3e431320@oss.qualcomm.com>
 <20261021174856.GE3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021174856.GE3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YKeRun28jnXsZl5RBNuTYuw5UzWEvs-B
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae71715 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BI0E-5PRPzxc588QxK8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YKeRun28jnXsZl5RBNuTYuw5UzWEvs-B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfX5MfKofzNOLW6
 yBY6eLRSIclsVbVkl3XH0bRoCbf5OtEV1h5HS2iU/8gDLEnVHsWizwhENivWdgfMEC80pd+bVFe
 SHY6PoS0z04VVo29YKa3ptCwLY2jkEc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfXwdVL83euMIYm
 5OkTPLwoWu0nXNIoEF9ZkiAShoDQWC9fcleJCmQZ0LA6Tgnj+77WDIIXt1ZSPes67Q0hO7UwZGG
 CavzFtUKuEKBQxgkQkgsRtgXpisDzTugrCq0CVjNHnIQuiXvvKsi/ATLGdiXTja+obFRJhmREEM
 A9mgCign5R4OAjNj/f6fqikGypvGA55dBMhBHi3gDot/r6fxSp69YL/mOug/jbGElBqqXe1EoX7
 reEKLBarr+cyWiMqTpmDuhnbfSJibMkpKlamETP5rOWbxdyJO+bLCT2dGUubH+aoc96tl0xxqfg
 iBaiAwV47hBFwbZLu/idCr5koVYvwR/cRvWT5NlR3gmCASQYtEW0NxUzAJNqDJSMNbGpucRAjME
 Pk/vYeqVqfZJzVA2RNI2NYSTQt/zvvAAruS0w4Z96l4fe0L7xqDdbawQyFcbF/ZTmPh7gDO2/bs
 1jrLR7d9Y1TXr9RxTMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/21/2026 11:18 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:25PM +0530, Balaji Selvanathan wrote:
>
>> Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
>> provided the following SMEM modernize series is picked:
>> https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/
>>
>> Memory node is not required as we can read the memory info from SMEM.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> The series should say it depends on the other series. That other series
> should probably be deleting this file, too, yes?

That SMEM series (that got merged in main) didnt delete this file. Hence 
deleting it here.

Regards,

Balaji

>
