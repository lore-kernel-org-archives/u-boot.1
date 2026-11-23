Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833E606A68C
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Op4rNX3a;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pdhrmgnt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RpvkwggU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACA8280D8C;
	Mon, 23 Nov 2026 04:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXupPHhr2VBE; Mon, 23 Nov 2026 04:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4F8880ADA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795409652;
	b=Owt0CmckLajIard4KxpesyUP9kbEdc4f+uTI9Nz7GSljTIOvW+X5Qmp5QBWbyFFK4u7t
	 zFFXDRbl89Jd9vlioo1J690KxVVaD/1wG+rxVGA9vy2QLv1JR2gTt+kk6X8fh+qRzcyRH
	 OnBnB4TYQhcBmVhujYuZnRzAyFTgeQyN0P5sNXETVkh7WrZdjUupIEtmvrayiN8jpyxDR
	 P2zXDgC8bgojLONG7bCFH9DDkWO9qcGnmPeU3ORv26URyMLX7zagMSqC+mgsBwqwseQQk
	 a+Tq7uGlTUcGOJKW5DsRtVmMM/fhNf6uPHZxNN73/DyN1JNm94/0BqcXhKQ+fx0Lkeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7X2L30mTD8DPhotiLCKk26OjlTKsS4jUVh1ULpx3MOE=;
	b=TSG61dRBuaHRT7ySC7oTgDSebYEs2Xp4VabNFfcf3pjeb8ENlYu1bCbFqjPdmZYvx3lh
	 VHYV9cOvOUUtJcrFehRJxCCLyEWoJeLT4JK4Kah+18kSWOCS0V3pWwGyxEatAazlxeA1S
	 VGVb1SbKPOFNGNT8x00zILqlL2+m+5N083IPUzgxehQNry8BaVHYS60tbGAHHHrglC+2r
	 ksvETO7ytvIagK23bs0w8gsBjbRlq3Wa4VleinaIwfE8r6bCMRe6CIkj8H4+QwpL51WyG
	 FMOT5qqpOSU4KPSDbwLzdbYp5uUWdw/mfvqd/HHmelf9FRarq7BXIKPTmwQqSdfnCHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795409652;
	bh=7X2L30mTD8DPhotiLCKk26OjlTKsS4jUVh1ULpx3MOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Op4rNX3aFGJLvI8Ph4ukk31YK5kTtGJeS+jK1AD4yiJsNFjRT8H1ceUnCH7k+IhMG
	 jSyL0dujbOb0h/Dh8LPQVxB2G5EoQ8hQ4m25D0XX0iM+WBNPDH9olE22qkGrw/pto6
	 LkyESlqLcdLc+zFPBemgrJgiPG51aY/UnqwaJsl085+0dYQC0lf94YRVjYS/rUFysB
	 lzS09UE9MDa9X2TA18NQWEgjVwGq8Aq6RIsAKaU6m+aeTlMmfL6A5mdBHC0jAXkAwW
	 ZD4FAWShEieu1wwjrVoXSNIVExbWpGQ2UvyEH7KDKlSIos5CCaV+hJsrpnEgRAhYkX
	 jd7Q76DVe9zHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F8880ADA;
	Mon, 23 Nov 2026 04:54:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56D77392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 482C040650
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6Rx7lwT5Xcq for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:54:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D18A84064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Pdhrmgnt; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RpvkwggU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D18A84064B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN40sSj3399880
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7X2L30mTD8DPhotiLCKk26OjlTKsS4jUVh1ULpx3MOE=; b=PdhrmgntwcASrdqK
 159wnAtuHWGBvm3B1h3/v5vACNux/ub21Yaucx5JGY4iT2/c5f3tNVzW9RZvYlSn
 L89svBaweJ9H5aqVEhRGyMDr0fbaZlDoiXO6BXBrBNaadc3IeVkwZwTA0P4R/BWW
 +mosr4YYvzYtOtQwbxtfrw/WhmDTjNNipv60hOPSU69wavKM9sIClUJH/Ne2z81x
 lmIVjwy7Tgmr3O9i8gR/LibGJNmfIQWGytU85S94R2JcI63Am+MPL//KzYwZg/3W
 aEUf0hz1gapxAp51wsRqUHmR3djWjwwyynog8d6eQ6cdVWgAdIhVrB55J0AXU1fX
 fgDRIw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j30nnwjqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so4824706eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795409646; x=1796014446;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7X2L30mTD8DPhotiLCKk26OjlTKsS4jUVh1ULpx3MOE=;
 b=RpvkwggUoaHxrdTg5XsI8Zd1d1H1wT365qCDHl9WVbhauhzAqWKhmdGvKxjo/RU7y9
 M2m9JmVPZg2mhen/F0Q5dg+JOQf6GH+3453gNpR4zsmy0lY/tflbMzJcNzHB93QewWUl
 91cGTtal89Z95bhPGvRIm99F/677EtQ26iCs0snJk+SIk5jVBWa4Ajmxplq5gS+siafJ
 vGPiJMt9/BfWnHcNF/2jooPAh41C31tD5ZeR6qXCuLmiLOjVcB88zInE1khsqQm6p6T5
 zr2jvf4prIIc7Ys+Y7f1BCh/yQrDidfhZbNTbdrezda0790liSmvSywAXAx79nAc4TlL
 dKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795409646; x=1796014446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7X2L30mTD8DPhotiLCKk26OjlTKsS4jUVh1ULpx3MOE=;
 b=nKfo91+p20UM7RV76hXV/ekm/t4qnk0ynpUzI7S2r9q3HAFkCk9eWEFd6yh5/rO9Wp
 IfDlpacSK/EL9HuVay7sdJDq4Hxc8kkjoM+ZzHOQuCzqgYQRnuVHDaY9Zkz5eItZGXti
 ggQBTNE0i3wXGgJm7sTv/ugrXuq7v1Xh1YCHgZd1Zbf0nZTQuN9giguTGp9fx5opKdBi
 x9IvUO9CoH1qDcF2nizT/xYvAI2u3wFw4l05ozupKXC22WwRacsbmknMJTwVq7NCDmFj
 f7F6ZJzu561z3+PdPFpgCNGJdj555E+VJgMb77wtbhATY2YMubxAw+Vtdc3ICQ+hfzcG
 pkpg==
X-Gm-Message-State: APuU4Z9zhJoMnq5GRcFtLKeLkE9JEoKePtpk0EqlTidFOqQ6QYthFTJB
 AAjdizzSNJSINlXGF7PJymVWxL029PyYejWM8vY/Txo1AUWqpC/1STXdUK7DxP+KP+PyEV3hYSC
 Ii6bb1LPQEf5DlAx7NHVBUXEEf/usPmVxcgbxoHHJkrD+obItOSapU3zLtyK9kI7WyhrPhrk=
X-Gm-Gg: AZFdTZd+VWAYGcmQ4/SY+wHqM1ZTxCa/7H73hc4H4MQxDmPt0ngTUIZrOsv68ivP07n
 5P+HJQku7WvpNKcWPGahp0jJyMAlk07xYk5WlKpQ6s8QRHVw5UcgKnpij5paSWW2rtA6mY30j2N
 qNBkLv1hRhhrX4c5eFafnXj4LD8tiAtlCgmIDwHNQFXFGDcnHlxzVhbfGgOg3v2rYlUEfx5deKW
 +npYRWj9zdmLPQeVPjAWC1ExDkm4mbdkOTFAFpc+DrBawyb5PY8OdUD5Y0qUfjoh5CEkJOyVhmz
 6PUFCVwUI7I/PFZhkn+iAeaxxH5AJaoVyufVUgtGl924BtFovWZnDZjZagN4SfYXyz1vfc6lwkU
 hVozG3jH8oQ9NnBZ9gpOJkjdZ04wjs4zoGoCVHlMf8K6ufgLChWWdrxSEKm04667obBR/02i1JL
 fo5uNJf5kkE09mybA8AY25NJm78thC6qsdcSLEQOF7iJWn8q1U8N4KGL0n3/byeZg+liVFFYXB/
 AZ7
X-Received: by 2002:a05:7022:e0b:b0:1a3:8d5f:6f93 with SMTP id
 a92af1059eb24-1b556882ac7mr17286544c88.17.1795409645531; 
 Sun, 22 Nov 2026 20:54:05 -0800 (PST)
X-Received: by 2002:a05:7022:e0b:b0:1a3:8d5f:6f93 with SMTP id
 a92af1059eb24-1b556882ac7mr17286503c88.17.1795409644772; 
 Sun, 22 Nov 2026 20:54:04 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556847fdasm28245170c88.13.2026.11.22.20.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 20:54:04 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:23:41 +0530
Subject: [PATCH v3 2/2] qcom: capsule: build fw_images[] dynamically from
 the partition table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-qcom-capsule-dynamic-fw-images-v3-2-b665b48e0de2@oss.qualcomm.com>
References: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
In-Reply-To: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409628; l=30470;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0UcIx9QgMBwphlQyVm5hNyfEQ1pjiLh+AyzIMfYLihA=;
 b=gwiVyTH9jcBPuBS4EU7K06XPylHK6ddvoyhWQwtU6MuslZzvJ9mTU4YYdcwkbMftTfhosMNqo
 Ua6+fuEWgJ4DndkfrawaY/ZEKhOBwDRVCRgOz2OEdnWH6vGGNIf1Oov
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX0rCshHPoP3PH
 GRjKt9QDP2bZN3HBlffHmPJHdPc7oMS3GCW0/o9cyo3IryR0RGxvxtSSDxZSIg6VsNbnfJNrCKc
 vO/IqS7E5NXmOAN5lKz02GKs0hSWLtANjphHOn5JmP2sXdv4NT84mvJ3CdfqSK8yoicE+I/xeOq
 1/W0VqaugS7++cSfGN+oFxy56PcKiZVw5mtFhqmC/3q4PaSE2EZgElfiBZAyPO2QxtGnlUcsbKc
 4tkCADxkSHR1TketMD7LIhTFCEDeicdrvaLz7VHtSLaQduasLzEcD5oj67MTGoRBThCVo7Ir13Z
 dK8m96ftrfSZuZNt2N9kIIz2wGr4Cx8G10Ydv0h54NbJzc8Fs+nczls5PopRguMav/E1CsZ9uh+
 EKZBrOjaxFJzSq4A7+vLReDC8Fo6NYXgwcrg+Ze4Eb0BO+6L8wCu7zgkDFCBfKRXW2kIscve4v/
 neX7oBQBLli+Gqp9+zQ==
X-Proofpoint-ORIG-GUID: CzZ_mvN3yj7pu7FFG87g7PgiSHo9Dcqk
X-Authority-Analysis: v=2.4 cv=LITz05W9 c=1 sm=1 tr=0 ts=6b03c6ef cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=4z5lR4mAReDXjoAoSi4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX8EhG4MGCx66F
 CsLHxtN7NVUWYg+JdyNgHhe8XFSpnAHhyJZLHwDg6KhQKzYg8Qw5Xtbpiubjb/rfHFGSy/PjFRO
 T2ISgtaaoKFaqmHaEXqZrcowIWhkGBY=
X-Proofpoint-GUID: CzZ_mvN3yj7pu7FFG87g7PgiSHo9Dcqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230019
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

Capsule update on Qualcomm boards only handles U-Boot itself, found by
find_target_partition() and hardcoded as the sole fw_images[] entry.
There is no way to update other firmware components.

Add qcom_image_map[], which maps a partition base name to a firmware
name. Scan every partition on the probed block devices and add an entry
to fw_images[] and to the dfu_alt_info string for each map row that has
a matching partition. num_images is whatever was found, so a component
missing on a board is left out.

U-Boot's own image stays first. It is expressed as three rows gated on
the boot source, so the uefi-over-xbl priority and A/B slot selection of
find_target_partition() come out of the same scan.

Each component has a fixed image type GUID  so one capsule applies to
every board. image_index is assigned in order from 1, which keeps it
within 1..DescriptorCount and equal to the DFU alt number plus one.
The index in a capsule can then differ from it, so implement
efi_capsule_resolve_image_index() to find the image by its type GUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- Assign image_index in order instead of using the per-component index
- Look up the image by GUID with efi_capsule_resolve_image_index()
- Use a fixed image type GUID per component
- Drop efi_firmware_get_dfu_alt_num() and the dfu_alt_num member
- Replace apdp with multiimgqti in qcom_image_map[]
---
 arch/arm/mach-snapdragon/capsule_update.c | 747 +++++++++++++++++++++---------
 1 file changed, 524 insertions(+), 223 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 33cb614782a..2c0aee6d177 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -20,35 +20,134 @@
 #include "qcom-priv.h"
 
 /*
- * To handle different variants like chainloaded U-Boot here we need to
- * build the fw_images array dynamically at runtime. These are the possible
- * implementations:
+ * fw_images[] and update_info are built at runtime from the board's GPT, as the
+ * updatable components and U-Boot's own partition vary per board.
  *
- * - Devices with U-Boot on the uefi_a/b partition
- * - Devices with U-Boot on the boot (a/b) partition
- * - Devices with U-Boot on the xbl (a/b) partition
+ * qcom_image_map[] maps partition base names to firmware names. image_index in
+ * fw_images[] is assigned in order and capsules are matched by image type GUID.
+ * U-Boot's own image is split into rows gated on the boot source: uefi/xbl (or
+ * the legacy "aboot" alias) when flashed as XBL, boot when chainloaded from ABL.
+ */
+
+/**
+ * struct qcom_image_map - maps a GPT partition to a capsule FMP image
+ * @partition_base: base partition name, without the _a/_b slot suffix
+ * @fw_name_base: slot-independent firmware name
+ * @image_index: identifies the row, one partition is selected per index. Index 1
+ *               is U-Boot's own image (the three rows below, one per boot)
+ * @boot_source: if non-zero, the row is only used for this qcom_boot_source
+ * @alias_base: optional second base name the row matches, slotted or bare
+ * @match_nonslotted: also match the bare @partition_base, for boards without A/B
+ *                    on U-Boot's partition
+ * @image_type_id: fixed image type GUID, so a capsule applies to every board
  *
- * Which partition actually has U-Boot on it is determined based on the
- * qcom_boot_source variable and additional logic in find_target_partition().
+ * Every row matches "<partition_base>_a" and "<partition_base>_b".
  */
-struct efi_fw_image fw_images[] = {
-	{
-		.image_index = 1,
-	},
+struct qcom_image_map {
+	const char *partition_base;
+	const u16 *fw_name_base;
+	u8 image_index;
+	enum qcom_boot_source boot_source;
+	const char *alias_base;
+	bool match_nonslotted;
+	efi_guid_t image_type_id;
 };
 
+/*
+ * image_type_id of each component.
+ * The three U-Boot rows share one GUID since only one is selected per boot.
+ */
+#define QCOM_UBOOT_IMAGE_TYPE_GUID \
+	EFI_GUID(0x400ffdcd, 0x22e0, 0x47e7, 0x9a, 0x23, 0xf1, 0x6e, 0xd9, 0x38, 0x23, 0x88)
+#define QCOM_XBL_IMAGE_TYPE_GUID \
+	EFI_GUID(0xdea0ba2c, 0xcbdd, 0x4805, 0xb4, 0xf9, 0xf4, 0x28, 0x25, 0x1c, 0x3e, 0x98)
+#define QCOM_XBL_CONFIG_IMAGE_TYPE_GUID \
+	EFI_GUID(0x5a325ae4, 0x4276, 0xb66d, 0x0a, 0xdd, 0x34, 0x94, 0xdf, 0x27, 0x70, 0x6a)
+#define QCOM_UEFI_SECAPP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xbe8a7e08, 0x1b7a, 0x4cae, 0x99, 0x3a, 0xd5, 0xb7, 0xfb, 0x55, 0xb3, 0xc2)
+#define QCOM_TZ_IMAGE_TYPE_GUID \
+	EFI_GUID(0xa053aa7f, 0x40b8, 0x4b1c, 0xba, 0x08, 0x2f, 0x68, 0xac, 0x71, 0xa4, 0xf4)
+#define QCOM_HYP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xe1a6a689, 0x0c8d, 0x4cc6, 0xb4, 0xe8, 0x55, 0xa4, 0x32, 0x0f, 0xbd, 0x8a)
+#define QCOM_AOP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xd69e90a5, 0x4cab, 0x0071, 0xf6, 0xdf, 0xab, 0x97, 0x7f, 0x14, 0x1a, 0x7f)
+#define QCOM_DEVCFG_IMAGE_TYPE_GUID \
+	EFI_GUID(0xf65d4b16, 0x343d, 0x4e25, 0xaa, 0xfc, 0xbe, 0x99, 0xb6, 0x55, 0x6a, 0x6d)
+#define QCOM_QUPFW_IMAGE_TYPE_GUID \
+	EFI_GUID(0x21d1219f, 0x2ed1, 0x4ab4, 0x93, 0x0a, 0x41, 0xa1, 0x6a, 0xe7, 0x5f, 0x7f)
+#define QCOM_XBL_RAMDUMP_IMAGE_TYPE_GUID \
+	EFI_GUID(0x0382f197, 0xe41f, 0x4e84, 0xb1, 0x8b, 0x0b, 0x56, 0x4a, 0xea, 0xd8, 0x75)
+#define QCOM_CPUCP_IMAGE_TYPE_GUID \
+	EFI_GUID(0x1e8615bd, 0x6d8c, 0x41ad, 0xb3, 0xea, 0x50, 0xe8, 0xbf, 0x40, 0xe4, 0x3f)
+#define QCOM_SHRM_IMAGE_TYPE_GUID \
+	EFI_GUID(0xcb74ca22, 0x2f0d, 0x4b82, 0xa1, 0xd6, 0xc4, 0x21, 0x3f, 0x34, 0x8d, 0x73)
+#define QCOM_IMAGEFV_IMAGE_TYPE_GUID \
+	EFI_GUID(0x17911177, 0xc9e6, 0x4372, 0x93, 0x3c, 0x80, 0x4b, 0x67, 0x8e, 0x66, 0x6f)
+#define QCOM_MULTIIMGOEM_IMAGE_TYPE_GUID \
+	EFI_GUID(0xe126a436, 0x757e, 0x42d0, 0x8d, 0x19, 0x0f, 0x36, 0x2f, 0x7a, 0x62, 0xb8)
+#define QCOM_RPM_IMAGE_TYPE_GUID \
+	EFI_GUID(0x098df793, 0xd712, 0x413d, 0x9d, 0x4e, 0x89, 0xd7, 0x11, 0x77, 0x22, 0x28)
+#define QCOM_MULTIIMGQTI_IMAGE_TYPE_GUID \
+	EFI_GUID(0x846c6f05, 0xeb46, 0x4c0a, 0xa1, 0xa3, 0x36, 0x48, 0xef, 0x3f, 0x9d, 0x0e)
+
+static const struct qcom_image_map qcom_image_map[] = {
+	/*
+	 * U-Boot's own image (image_index 1), only one row is selected per boot:
+	 *  - boot_source gating separates the uefi/xbl rows from the boot row;
+	 *  - uefi is listed before xbl, so it wins when both partitions exist;
+	 *  - with no uefi, the xbl row claims the xbl partition before the
+	 *    component row below, as a partition can't be two images.
+	 * All rows share one image_type_id, so one capsule updates whichever
+	 * partition U-Boot booted from.
+	 */
+	{ "uefi", u"UBOOT_UEFI_PARTITION", 1, QCOM_BOOT_SOURCE_XBL,     NULL,    false,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+	{ "xbl",  u"UBOOT_XBL_PARTITION",  1, QCOM_BOOT_SOURCE_XBL,     "aboot", false,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+	{ "boot", u"UBOOT_BOOT_PARTITION", 1, QCOM_BOOT_SOURCE_ANDROID, NULL,    true,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+
+	{ "xbl",         u"QCOM-XBL",          2, 0, NULL, false,
+	  QCOM_XBL_IMAGE_TYPE_GUID },
+	{ "xbl_config",  u"QCOM-XBL-CONFIG",   3, 0, NULL, false,
+	  QCOM_XBL_CONFIG_IMAGE_TYPE_GUID },
+	{ "uefisecapp",  u"QCOM-UEFI-SECAPP",  4, 0, NULL, false,
+	  QCOM_UEFI_SECAPP_IMAGE_TYPE_GUID },
+	{ "tz",          u"QCOM-TZ",           5, 0, NULL, false,
+	  QCOM_TZ_IMAGE_TYPE_GUID },
+	{ "hyp",         u"QCOM-HYP",          6, 0, NULL, false,
+	  QCOM_HYP_IMAGE_TYPE_GUID },
+	{ "aop",         u"QCOM-AOP",          7, 0, NULL, false,
+	  QCOM_AOP_IMAGE_TYPE_GUID },
+	{ "devcfg",      u"QCOM-DEVCFG",       8, 0, NULL, false,
+	  QCOM_DEVCFG_IMAGE_TYPE_GUID },
+	{ "qupfw",       u"QCOM-QUPFW",        9, 0, NULL, false,
+	  QCOM_QUPFW_IMAGE_TYPE_GUID },
+	{ "xbl_ramdump", u"QCOM-XBL-RAMDUMP", 10, 0, NULL, false,
+	  QCOM_XBL_RAMDUMP_IMAGE_TYPE_GUID },
+	{ "cpucp",       u"QCOM-CPUCP",       11, 0, NULL, false,
+	  QCOM_CPUCP_IMAGE_TYPE_GUID },
+	{ "shrm",        u"QCOM-SHRM",        12, 0, NULL, false,
+	  QCOM_SHRM_IMAGE_TYPE_GUID },
+	{ "imagefv",     u"QCOM-IMAGEFV",     13, 0, NULL, false,
+	  QCOM_IMAGEFV_IMAGE_TYPE_GUID },
+	{ "multiimgoem", u"QCOM-MULTIIMGOEM", 14, 0, NULL, false,
+	  QCOM_MULTIIMGOEM_IMAGE_TYPE_GUID },
+	{ "multiimgqti", u"QCOM-MULTIIMGQTI", 15, 0, NULL, false,
+	  QCOM_MULTIIMGQTI_IMAGE_TYPE_GUID },
+	{ "rpm",         u"QCOM-RPM",         16, 0, NULL, false,
+	  QCOM_RPM_IMAGE_TYPE_GUID },
+};
+
+static struct efi_fw_image fw_images[ARRAY_SIZE(qcom_image_map)];
+
 struct efi_capsule_update_info update_info = {
-	/* Filled in by configure_dfu_string() */
 	.dfu_string = NULL,
-	.num_images = ARRAY_SIZE(fw_images),
+	.num_images = 0,
 	.images = fw_images,
 };
 
-enum target_part_type {
-	TARGET_PART_UEFI = 1,
-	TARGET_PART_XBL,
-	TARGET_PART_BOOT,
-};
+#define QCOM_DFU_STRING_LEN	(64 * ARRAY_SIZE(qcom_image_map))
 
 /* LSB first */
 struct part_slot_status {
@@ -66,21 +165,6 @@ enum ab_slot {
 	SLOT_B,
 };
 
-static enum ab_slot get_part_slot(const char *partname)
-{
-	int len = strlen(partname);
-
-	if (partname[len - 2] != '_')
-		return SLOT_NONE;
-	if (partname[len - 1] == 'a')
-		return SLOT_A;
-	if (partname[len - 1] == 'b')
-		return SLOT_B;
-
-	return SLOT_NONE;
-}
-
-/* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
 /*
  * Determine if an MMC device is an SD card.
  *
@@ -97,25 +181,391 @@ static bool is_sd(struct blk_desc *desc)
 	return IS_SD(mmc) != 0U;
 }
 
+/**
+ * struct qcom_partition_info - a selected partition for one component
+ * @name: partition name as found on disk, e.g. "tz_a"
+ * @part_num: partition number on the block device
+ * @devnum: block device number @name lives on
+ * @uclass_id: uclass (UCLASS_SCSI/UCLASS_MMC) of @devnum. Used with @devnum to
+ *             group partitions on different LUNs in the DFU string
+ * @fw_name: slot-independent FMP name (from the matched map row)
+ * @image_index: index of the matched map row
+ * @image_type_id: image type GUID of the matched map row
+ */
+struct qcom_partition_info {
+	char name[32];
+	u32 part_num;
+	int devnum;
+	enum uclass_id uclass_id;
+	const u16 *fw_name;
+	u8 image_index;
+	efi_guid_t image_type_id;
+};
+
+static struct qcom_partition_info qcom_partitions[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * struct qcom_slot_cand - one candidate partition for a map row's slot
+ * @part_num: partition number, or -1 if no partition filled this slot
+ * @active: A/B "active" flag from the partition's slot status
+ * @devnum: block device number the partition was found on
+ * @uclass_id: uclass of that block device
+ * @name: partition name as found on disk
+ */
+struct qcom_slot_cand {
+	int part_num;
+	bool active;
+	int devnum;
+	enum uclass_id uclass_id;
+	char name[32];
+};
+
+/**
+ * struct qcom_row_cand - candidate partitions for one qcom_image_map[] row
+ * @slot: indexed by enum ab_slot (SLOT_NONE for a non-slotted/alias-bare match)
+ */
+struct qcom_row_cand {
+	struct qcom_slot_cand slot[3];
+};
+
 /*
- * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
- * the slot status, and prioritizing the uefi partition over xbl if found.
+ * Candidates for every scanned block device, one entry per qcom_image_map[] row.
+ */
+static struct qcom_row_cand qcom_cands[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * qcom_match_partition() - test a partition name against a map row
+ * @name: partition name as found on disk
+ * @map: candidate map row
+ * @slot: output, which A/B slot (SLOT_NONE for a non-slotted / bare-alias match)
+ *
+ * Every row matches "<partition_base>_a"/"<partition_base>_b". U-Boot's rows
+ * may also match a bare non-slotted name (@match_nonslotted) and a legacy alias
+ * base (@alias_base, both slotted and bare).
+ *
+ * Return: true if @name belongs to @map
+ */
+static bool qcom_match_partition(const char *name,
+				 const struct qcom_image_map *map,
+				 enum ab_slot *slot)
+{
+	char cand[36];
+
+	snprintf(cand, sizeof(cand), "%s_a", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_A;
+		return true;
+	}
+	snprintf(cand, sizeof(cand), "%s_b", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_B;
+		return true;
+	}
+	if (map->match_nonslotted && !strcmp(name, map->partition_base)) {
+		*slot = SLOT_NONE;
+		return true;
+	}
+
+	if (map->alias_base) {
+		snprintf(cand, sizeof(cand), "%s_a", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_A;
+			return true;
+		}
+		snprintf(cand, sizeof(cand), "%s_b", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_B;
+			return true;
+		}
+		if (!strcmp(name, map->alias_base)) {
+			*slot = SLOT_NONE;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * qcom_scan_device() - record candidate partitions on one block device
+ * @desc: block device to scan
+ * @cands: candidate table, one entry per qcom_image_map[] row
+ *
+ * Each partition on @desc is checked against every eligible row (those whose
+ * boot_source matches qcom_boot_source) and recorded in that row's slot. One
+ * partition can match several rows, e.g. "xbl_a" matches both the U-Boot xbl
+ * row and the xbl component row.
+ *
+ * The first device wins if a partition table is exposed more than once, e.g.
+ * mirrored UFS boot LUNs. The table is global so qcom_resolve_images() can apply
+ * the uefi-over-xbl priority across LUNs.
  */
-static int find_target_partition(int *devnum, enum uclass_id *uclass,
-				 enum target_part_type *target_part_type)
+static void qcom_scan_device(struct blk_desc *desc, struct qcom_row_cand *cands)
 {
-	int ret;
-	int partnum, uefi_partnum = -1, xbl_partnum = -1;
 	struct disk_partition info;
 	struct part_slot_status *slot_status;
-	struct udevice *dev = NULL;
-	struct blk_desc *desc = NULL, *xbl_desc = NULL;
-	uchar ptn_name[32] = { 0 };
+	int partnum, i;
+
+	for (partnum = 1; !part_get_info(desc, partnum, &info); partnum++) {
+		slot_status = (struct part_slot_status *)&info.type_flags;
+
+		for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+			const struct qcom_image_map *m = &qcom_image_map[i];
+			struct qcom_slot_cand *c;
+			enum ab_slot slot;
+
+			if (m->boot_source && m->boot_source != qcom_boot_source)
+				continue;
+			if (!qcom_match_partition((char *)info.name, m, &slot))
+				continue;
+
+			c = &cands[i].slot[slot];
+			if (c->part_num >= 0)	/* first device wins */
+				continue;
+
+			c->part_num = partnum;
+			c->active = !!slot_status->active;
+			c->devnum = desc->devnum;
+			c->uclass_id = desc->uclass_id;
+			strlcpy(c->name, (char *)info.name, sizeof(c->name));
+		}
+	}
+}
+
+/**
+ * qcom_pick_slot() - choose the best candidate slot for a map row
+ * @rc: candidate slots for one row
+ *
+ * Priority: active A > active B > non-slotted > inactive A > inactive B.
+ *
+ * Return: the chosen enum ab_slot, or -1 if no candidate was recorded
+ */
+static int qcom_pick_slot(const struct qcom_row_cand *rc)
+{
+	if (rc->slot[SLOT_A].part_num >= 0 && rc->slot[SLOT_A].active)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0 && rc->slot[SLOT_B].active)
+		return SLOT_B;
+	if (rc->slot[SLOT_NONE].part_num >= 0)
+		return SLOT_NONE;
+	if (rc->slot[SLOT_A].part_num >= 0)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0)
+		return SLOT_B;
+
+	return -1;
+}
+
+/**
+ * qcom_resolve_images() - pick one partition per map row from the candidates
+ * @cands: candidate table filled by qcom_scan_device() across every device
+ * @partitions: output array; room for ARRAY_SIZE(qcom_image_map) entries
+ *
+ * Walks qcom_image_map[] in order, so U-Boot's own image lands in partitions[0].
+ * Two dedup rules:
+ *
+ *  1. One partition per image_index. The U-Boot rows share index 1, so the first
+ *     one with a candidate wins (uefi before xbl).
+ *  2. A physical partition is claimed once. With U-Boot on xbl and no uefi, the
+ *     U-Boot xbl row takes the partition and the xbl component row is skipped.
+ *
+ * A row with no candidate is left out, so num_images varies per board.
+ *
+ * Return: number of partitions written to @partitions
+ */
+static u32 qcom_resolve_images(struct qcom_row_cand *cands,
+			       struct qcom_partition_info *partitions)
+{
+	u32 count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		const struct qcom_image_map *m = &qcom_image_map[i];
+		struct qcom_slot_cand *c;
+		struct qcom_partition_info *p;
+		bool dup = false;
+		int sel;
+		u32 j;
+
+		if (m->boot_source && m->boot_source != qcom_boot_source)
+			continue;
+
+		sel = qcom_pick_slot(&cands[i]);
+		if (sel < 0)
+			continue;
+		c = &cands[i].slot[sel];
+
+		/* rule 1: one selected partition per image_index */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].image_index == m->image_index) {
+				dup = true;
+				break;
+			}
+		}
+		if (dup)
+			continue;
+
+		/* rule 2: never claim the same physical partition twice */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].devnum == c->devnum &&
+			    partitions[j].uclass_id == c->uclass_id &&
+			    partitions[j].part_num == (u32)c->part_num) {
+				dup = true;
+				break;
+			}
+		}
+		if (dup)
+			continue;
+
+		p = &partitions[count++];
+		strlcpy(p->name, c->name, sizeof(p->name));
+		p->part_num = c->part_num;
+		p->devnum = c->devnum;
+		p->uclass_id = c->uclass_id;
+		p->fw_name = m->fw_name_base;
+		p->image_index = m->image_index;
+		guidcpy(&p->image_type_id, &m->image_type_id);
+
+		log_debug("qcom capsule: %s -> image %u (part %u, dev %d)\n",
+			  p->name, p->image_index, p->part_num, p->devnum);
+	}
+
+	return count;
+}
+
+/**
+ * qcom_build_fw_images() - populate fw_images[] from the discovered partitions
+ * @partitions: partitions from qcom_resolve_images(); entry 0 is U-Boot's own
+ *              image (image_index 1), the rest are components
+ * @num_partitions: number of valid entries in @partitions
+ *
+ * One fw_images[] entry per partition, in the same order, so fw_images[] and
+ * @partitions stay index-aligned. .image_index is assigned sequentially
+ * (1..@num_partitions) as UEFI requires 1 <= ImageIndex <= DescriptorCount.
+ * .image_type_id is copied from the map row. As entry 0 is then non-zero,
+ * efi_gen_capsule_guids() leaves the table alone.
+ *
+ * Return: number of images written (equal to @num_partitions)
+ */
+static u32 qcom_build_fw_images(const struct qcom_partition_info *partitions,
+				u32 num_partitions)
+{
+	u32 i;
+
+	for (i = 0; i < num_partitions; i++) {
+		fw_images[i].fw_name = (u16 *)partitions[i].fw_name;
+		fw_images[i].image_index = i + 1;
+		guidcpy(&fw_images[i].image_type_id, &partitions[i].image_type_id);
+	}
+
+	return num_partitions;
+}
+
+/**
+ * qcom_build_dfu_string() - build the dfu_alt_info string for the partitions
+ * @partitions: partitions accumulated across every scanned block device
+ * @num_partitions: number of valid entries in @partitions; also the number of
+ *                  valid fw_images[] entries, with matching indices
+ * @buf: output buffer
+ * @buf_size: size of @buf
+ *
+ * Builds an "interface devstring=alt;alt&interface devstring=alt" string (see
+ * dfu_config_interfaces()), with '&' between devices. efi_firmware_raw_set_image()
+ * passes a NULL interface, which forces this multi-interface parser, so a
+ * single-group string would drop every partition after the first LUN.
+ *
+ * Tokens are appended in @partitions order, so the DFU alt number of each
+ * image is its image_index - 1, as efi_firmware_raw_set_image() expects.
+ *
+ * Return: true on success, false if @buf was too small
+ */
+static bool qcom_build_dfu_string(struct qcom_partition_info *partitions,
+				  u32 num_partitions, char *buf, size_t buf_size)
+{
+	int prev_devnum = -1;
+	enum uclass_id prev_uclass_id = UCLASS_INVALID;
+	u32 i;
+	size_t len;
+
+	buf[0] = '\0';
+	len = 0;
+
+	for (i = 0; i < num_partitions; i++) {
+		struct qcom_partition_info *p = &partitions[i];
+		char token[48];
+		bool new_group = p->devnum != prev_devnum ||
+				  p->uclass_id != prev_uclass_id;
+
+		if (new_group) {
+			char prefix[24];
+
+			if (i != 0)
+				len = strlcat(buf, "&", buf_size);
+
+			switch (p->uclass_id) {
+			case UCLASS_SCSI:
+				snprintf(prefix, sizeof(prefix), "scsi %d=", p->devnum);
+				break;
+			case UCLASS_MMC:
+				snprintf(prefix, sizeof(prefix), "mmc %d=", p->devnum);
+				break;
+			default:
+				log_err("qcom capsule: unsupported storage uclass %d for %s\n",
+					p->uclass_id, p->name);
+				return false;
+			}
+			len = strlcat(buf, prefix, buf_size);
+		} else {
+			len = strlcat(buf, ";", buf_size);
+		}
+
+		if (p->uclass_id == UCLASS_MMC)
+			snprintf(token, sizeof(token), "%s part %u %u",
+				 p->name, p->devnum, p->part_num);
+		else
+			snprintf(token, sizeof(token), "%s part %u",
+				 p->name, p->part_num);
+		len = strlcat(buf, token, buf_size);
+
+		if (len >= buf_size) {
+			log_err("qcom capsule: dfu_alt_info string truncated\n");
+			return false;
+		}
+
+		prev_devnum = p->devnum;
+		prev_uclass_id = p->uclass_id;
+	}
+
+	return true;
+}
+
+/**
+ * qcom_configure_capsule_updates() - Configure the DFU string and fw_images[]
+ * for capsule updates
+ *
+ * Scans every probed block device and builds fw_images[] and the matching
+ * dfu_alt_info string.
+ */
+void qcom_configure_capsule_updates(void)
+{
+	static char dfu_string[QCOM_DFU_STRING_LEN];
+	struct qcom_partition_info *partitions = qcom_partitions;
+	u32 num_partitions;
+	struct udevice *dev;
 	bool have_ufs = false;
+	int i;
+
+	memset(qcom_cands, 0, sizeof(qcom_cands));
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		qcom_cands[i].slot[SLOT_NONE].part_num = -1;
+		qcom_cands[i].slot[SLOT_A].part_num = -1;
+		qcom_cands[i].slot[SLOT_B].part_num = -1;
+	}
+	memset(partitions, 0, sizeof(qcom_partitions));
 
 	/*
-	 * Check to see if we have UFS storage, if so U-Boot MUST be on it and we can skip
-	 * all non-UFS block devices
+	 * Check to see if we have UFS storage, if so firmware MUST be on it and
+	 * we can skip all non-UFS block devices.
 	 */
 	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
 		have_ufs = true;
@@ -123,6 +573,8 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
 	}
 
 	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		struct blk_desc *desc;
+
 		if (device_get_uclass_id(dev) != UCLASS_BLK)
 			continue;
 
@@ -132,204 +584,53 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
 		if (have_ufs) {
 			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
 				continue;
-		}
-		/*
-		 * If we don't have UFS, then U-Boot must be on the eMMC
-		 */
-		else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
+		} else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
+			/* If we don't have UFS, then firmware is on the eMMC */
 			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
 			continue;
 		}
 
 		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
 			continue;
-		for (partnum = 1;; partnum++) {
-			ret = part_get_info(desc, partnum, &info);
-			if (ret)
-				break;
 
-			slot_status = (struct part_slot_status *)&info.type_flags;
-
-			/*
-			 * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
-			 * flags might not be set so we assume the A partition unless the B
-			 * partition is active.
-			 */
-			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
-				/*
-				 * If U-Boot was chainloaded somehow we can't be flashed to
-				 * the uefi partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				*target_part_type = TARGET_PART_UEFI;
-				/*
-				 * Found an active UEFI partition, this is where U-Boot is
-				 * flashed.
-				 */
-				if (slot_status->active)
-					goto found;
-
-				/* Prefer A slot if it's not marked active */
-				if (get_part_slot(info.name) == SLOT_A) {
-					/*
-					 * If we found the A slot after the B slot (both
-					 * inactive) then we assume U-Boot is on the A slot.
-					 */
-					if (uefi_partnum >= 0)
-						goto found;
-
-					/* Didn't find the B slot yet */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				} else {
-					/*
-					 * Found inactive B slot after inactive A slot, return
-					 * the A slot
-					 */
-					if (uefi_partnum >= 0) {
-						partnum = uefi_partnum;
-						goto found;
-					}
-
-					/*
-					 * Didn't find the A slot yet. Record that we found the
-					 * B slot
-					 */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				}
-				/* xbl and aboot are effectively the same */
-			} else if ((!strncmp(info.name, "xbl", strlen("xbl")) &&
-				    strlen(info.name) == 5) ||
-				    !strncmp(info.name, "aboot", strlen("aboot"))) {
-				/*
-				 * If U-Boot was booted via ABL, we can't be flashed to the
-				 * XBL partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				/*
-				 * ignore xbl partition if we have uefi partitions, U-Boot will
-				 * always be on the UEFI partition in this case.
-				 */
-				if (*target_part_type == TARGET_PART_UEFI)
-					continue;
-
-				/* Either non-A/B or find the active XBL partition */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					/*
-					 * No quick return since we might find a uefi partition
-					 * later
-					 */
-					xbl_partnum = partnum;
-					*target_part_type = TARGET_PART_XBL;
-					xbl_desc = desc;
-					strlcpy(ptn_name, info.name, 32);
-				}
-
-				/*
-				 * No fast return since we might also have a uefi partition which
-				 * will take priority.
-				 */
-			} else if (!strncmp(info.name, "boot", strlen("boot"))) {
-				/* We can only be flashed to boot if we were chainloaded */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_ANDROID)
-					continue;
-
-				/*
-				 * Either non-A/B or find the active partition. We can return
-				 * immediately here since we've narrowed it down to a single option
-				 */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					*target_part_type = TARGET_PART_BOOT;
-					goto found;
-				}
-			}
-		}
+		qcom_scan_device(desc, qcom_cands);
 	}
 
-	/*
-	 * Now we've exhausted all options, if we didn't find a uefi partition
-	 * then we are indeed flashed to the xbl partition.
-	 */
-	if (*target_part_type == TARGET_PART_XBL) {
-		partnum = xbl_partnum;
-		desc = xbl_desc;
-		goto found;
+	num_partitions = qcom_resolve_images(qcom_cands, partitions);
+	if (!num_partitions) {
+		log_err("qcom capsule: no updatable partitions found\n");
+		return;
 	}
+	if (partitions[0].image_index != 1)
+		log_warning("qcom capsule: U-Boot's own partition not found; configuring components only\n");
 
-	/* Found no candidate partitions */
-	return -1;
+	qcom_build_fw_images(partitions, num_partitions);
+	if (!qcom_build_dfu_string(partitions, num_partitions, dfu_string,
+				   sizeof(dfu_string)))
+		return;
 
-found:
-	if (desc) {
-		*devnum = desc->devnum;
-		*uclass = desc->uclass_id;
-	}
+	log_debug("dfu_alt_info: %s\n", dfu_string);
 
-	/* info won't match for XBL hence the copy. */
-	log_info("Capsule update target: %s (disk %d:%d)\n",
-		 *target_part_type == TARGET_PART_BOOT ? info.name : ptn_name,
-		 *devnum, partnum);
-	return partnum;
+	update_info.num_images = num_partitions;
+	update_info.dfu_string = dfu_string;
 }
 
 /**
- * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
+ * efi_capsule_resolve_image_index() - find the fw_images[] index for a capsule
+ * @image_type: image type GUID from the capsule
+ * @capsule_index: image index from the capsule
  *
- * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
- * are two boot partitions, boot_a and boot_b. As we don't currently support doing
- * full A/B updates, we only support updating the currently active boot partition.
- *
- * So we need to find the current slot suffix and the associated boot partition.
- * We do this by looking for the boot partition that has the 'active' flag set
- * in the GPT partition vendor attribute bits.
+ * Return: image_index of the entry matching @image_type, else @capsule_index
  */
-void qcom_configure_capsule_updates(void)
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index)
 {
-	int partnum = -1, devnum;
-	static char dfu_string[32] = { 0 };
-	enum target_part_type target_part_type = 0;
-	enum uclass_id dev_uclass;
-
-	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
-	if (partnum < 0) {
-		log_err("Failed to find boot partition\n");
-		return;
-	}
+	int i;
 
-	/*
-	 * Set the fw_name based on the partition type. This causes the GUID to be different
-	 * so we will never accidentally flash a U-Boot image intended for XBL to the boot
-	 * partition.
-	 */
-	switch (target_part_type) {
-	case TARGET_PART_UEFI:
-		fw_images[0].fw_name = u"UBOOT_UEFI_PARTITION";
-		break;
-	case TARGET_PART_XBL:
-		fw_images[0].fw_name = u"UBOOT_XBL_PARTITION";
-		break;
-	case TARGET_PART_BOOT:
-		fw_images[0].fw_name = u"UBOOT_BOOT_PARTITION";
-		break;
-	}
-
-	switch (dev_uclass) {
-	case UCLASS_SCSI:
-		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
-		break;
-	case UCLASS_MMC:
-		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
-		break;
-	default:
-		debug("Unsupported storage uclass: %d\n", dev_uclass);
-		return;
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&update_info.images[i].image_type_id, image_type))
+			return update_info.images[i].image_index;
 	}
-	log_debug("DFU string: '%s'\n", dfu_string);
 
-	update_info.dfu_string = dfu_string;
+	return capsule_index;
 }

-- 
2.34.1

