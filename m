Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2E606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WFG9wa0n;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E509SZ50;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kkBymrGm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42A87405AA;
	Sun, 15 Nov 2026 10:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIDAtN-wAfrQ; Sun, 15 Nov 2026 10:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95DB74062C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794739787;
	b=kIYlTKgrpVkLJmLBwybe18q1VNAAe4HHyIe/lA/eDMx+sRwDhVWfvPREPUhbx1it0WxT
	 Lq9/t6Z83/DqItGa5Cug99xr6B5rk0a4aN90PwHBl3GAdyRWdZqwwr/X0RCyI+V8D39yE
	 BmW90Ny5Q7L4X2UtMy4WgfqL4+Lpr6XGZwQT/njpOH0vlYu95Ras//0m4mDY5KGgIY4bp
	 uJ75fhv9Vpopm7EDf9APb/LKlQVtC38LDnCF6SCRUeyJ0gvhyg5UIJDS94J7PthS8qAdr
	 B/pRHCSCieGjoIznu2thqia6quqcAFDQpDefSks1lHytm6uF4ohwfWgrCr/oFysClcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794739787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XkblUlrKDowtuuvvxsLxIV712/VK7MEYIfL5no6ElUg=;
	b=FXKAHLkBypbjKtE3ebfcrBOJxM34fzTzKiDd+oRnQWPOQLbwE5pfNkeAQi2M4CET5ASQ
	 GYvA1JM4ej1gHgRaK2Z/SPa9mc42DnGyiHNEY1unGPp4j01cGzBYU+VLpR/kqGAiOT1+O
	 ks/iL31D089bAgvgpwbIFcaZloELZecxbrG/6TvYxzv9yCvQldhen65PUcgkhToOuqmw1
	 pwE1sts6aeGwj7Hhp614QT4AUfN5DJIL711444pt+Lx6aEZFgppmBufBnAu409lMjtsVw
	 ozwL+1vyMu4uJcUZjWgtpha8iX2n/60R9yXmby3LqLGyjq5avrbJ41efaF1sWwdP3SA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E509SZ50;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kkBymrGm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794739787;
	bh=XkblUlrKDowtuuvvxsLxIV712/VK7MEYIfL5no6ElUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFG9wa0nkPp+T9rgrXQJUErscCTCsBLEuKGT3Z4sjr4IMDatisRd5jaMzxjzXJ7BU
	 6TLFxKi5wJeCdiPZ8L04/SqC568bbA+DdAf30hD+CVxR7oo2tKVTHL8gj3SM+E3N1G
	 hMjYYJ7//v4xLTfZUxo4z9bpl5eyQtItyedM5MInnNC6XiOFTqCNDpJTMbujHt42aI
	 edJ3KVqlTC8m6YT5smcdOYOxoqXVq2RmftRCWFK9J+Ba9ROoRlVUyLBMVBs16whupd
	 gTT1PbbW+p/v3iLTh5SW1zanUfomsiHwaApynaxhYCOqSPArzeGkLV7A9v28ywAzsP
	 Y1CyaU+QdzvTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95DB74062C;
	Sun, 15 Nov 2026 10:49:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B60312E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7B90405AA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XT41K7GOja-k for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:49:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A903D4062C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=E509SZ50; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kkBymrGm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A903D4062C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7whp41196882
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XkblUlrKDowtuuvvxsLxIV712/VK7MEYIfL5no6ElUg=; b=E509SZ50/RHkFSYX
 sTbItdmbkQCwyLlC/JnsTRpw6M3VOV99jS64d7V46tsW6snyj8sS3LMUNf0SXz0M
 9uNXAfzBU6eEjz/3cZ3e+woHPfgb/MJUkGQ6fp3TBVQZdHk8oDKeT/YZFu83qxUC
 n2bevdasnjosWkAurGYSMq0jJqVbE2AZ18ZsblEvBH8xT8UcFlxqdyOjp4Bv+7kz
 IPuyFbKvTf57OMbZULc6tFUuaBohxsj7sLhUddA4MCIbdbRpxQZNdXmNLfroXD4e
 SrtiU+ZOEp6uVuJuoSt3rLu/DdDzyiRdWr1N//tcHl9fIftoEjBxFGt5fRigzqms
 9GgWlg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhjscs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f20addba1so495278085a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794739782; x=1795344582;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XkblUlrKDowtuuvvxsLxIV712/VK7MEYIfL5no6ElUg=;
 b=kkBymrGmfjWVZatKZmOwZEMj0CSX3imhwmABZ8cIS1SJQex24B/RiqVD7iK+2/ILMS
 Y3DTWGIpvPLW+IYXdAOn0v8Nsih6nftEWu5NrXzDZ2hqG3h60UrEe2qDfJiGjdeRtlNG
 BpQ4TY6WubR2/oRR/uHAR/+sBXWSMaXFkXEPKt4LedYUtwIVRJB2YXwQX8sauzChZeqJ
 6aLXtTiImK/FsySj9aai32R80dtRMZ+xvH+dxgQnkmbvYsjKfHNprrAGZGaHKvZ0Yy/T
 iac8EfNlrohNt7PkykaykAZrZnDnFRs2xsy/BimwUM7Zj1jANX5M05PvObTEboU5t2rV
 BDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794739782; x=1795344582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XkblUlrKDowtuuvvxsLxIV712/VK7MEYIfL5no6ElUg=;
 b=fatcSYQ+sNKdw0iEg6rV/nZuEq4V9in4UUDr189Hij37oxZNiR6/xeHplNM+K3Ai+m
 n5ajJemqO2dFh/nA88RXTnfO6a+ALBstK5EewzDWW1hwD8KuYt1b8nk0eHTvmaHkK4kA
 pffAMIDbPH1acA+cf6AIGEvrIa1G5ks/SVD8qqNd2I1t2FdEfftPqY8OC2ThPnGIy6E5
 EgsNgVKzWe3Ii7KQ4KTwLc20v8d+6D/fLDf81DsDH4k8MMlxJBhK9YXr+jp8PZ1OLUUS
 dsnxbo5pN2sOFIKMzx+TkXgn/1IGTZ+6dygfmM0foMkQjyBY9QFi2xDTIFjOmZjU4RFI
 lbGg==
X-Forwarded-Encrypted: i=1;
 AL+hErGzEO1/bz44Mu3RoBG9ajHKt4EnF5O3PaYZN7Rc+Z62wENs9TvwPjbII4TlFtbkdAb3MemKu9Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9TaIQBv6rXhV6bqbKQ3DXTue3RYfqculpZXTds58g1AAAge3Ae
 dUGuI472LutFElQKy8hT28bTrdCew4zc4iOhfcH3Ewg2YYfPTWqJqbhc2Vq5fZYcjPgFu1HjHAd
 Mwzng5yUK8LiExjFUQ4PWpztKmlYoVJWC4vuaJ3P7T9kO2Y7V21tLBWZke2dmy+kuaWbbD0w=
X-Gm-Gg: AYBFou2XYtgvGw7CC8q7eyq6l86PyZ3XoXuh2nc1l82vn1dWhn0Z7x/XHZIexyQr2x6
 ktXUWhvKjB1utP3BFwce7CKitDK9J3SNmdpH8+Ae1H0lSCcbxSBEZUb6b5JI+uLVUkIf/fcX2+l
 yGz9N8oNa2uFSRrj+f2u9pceYI9U0XBi7YNqm+/XxuDcXUhKit9aJChReX+TJ7qq8A2tiPoApa1
 1WjPQJP8EiSrSmGDCjvHG99XLJc52HmRHDocTh4Cvv70hA1lKuPhm0xDbeIlpdGLY4+mu478PXL
 JFHQKOtBTETwv6jetuaum3JCuMkobFxFT/hLKSYsoWv/wvD/f4jN8p7dsQkbtyhyDgWv1UPXmrV
 EQ7onGCG7FDGm8r0T3jcz8tikzxVC5ryky0+ls5yVfCthREK1EG+6jTiNubBDU1lUlCAcjtMQhR
 7XsZQUQ9TQFiQV
X-Received: by 2002:a05:620a:6e99:10b0:949:6d95:f62c with SMTP id
 af79cd13be357-9496d960033mr298290485a.72.1794739781658; 
 Sun, 15 Nov 2026 02:49:41 -0800 (PST)
X-Received: by 2002:a05:620a:6e99:10b0:949:6d95:f62c with SMTP id
 af79cd13be357-9496d960033mr298289485a.72.1794739781245; 
 Sun, 15 Nov 2026 02:49:41 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c24e7714sm3099358a12.28.2026.11.15.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 02:49:39 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:49:26 +0100
Subject: [PATCH 2/2] i2c: geni: do not report a missing clock disable operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-geni-mixed-minicore-v1-2-bce20aa8f4cf@oss.qualcomm.com>
References: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: i7nLtvuArkFeXOED2eZJmTn6zNZYgXOM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX5mty0evEVlbw
 4dlhzDEyG6waVI49Sf+Y8wH61N38rD0RIyC0BLI5yAvRNIhS3Gi9JMEob42sAXZYRrh3UrujovQ
 GeWkQDY8BVpfLMz0RF5W95rIAvMVli0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX4EStDimJP3bN
 wwWu6/9A/An/7rgWNjAF1u6KNvOWNdLnrysuAIXOM/sc1b0NShqoMEZDPOIPim26A4S8Els45Eq
 HJT5PFmpmzUVJSf8v307eE4NIfsFf9FYUhAzp8v8Ly+TmjcRX54kjWNOl481/aL6OpKi5CxXO3J
 MkNUfL597OhNt6HGMRKCcEsCYKoHIkVaHf8/rIz2oIVGFASru9g7fnM+70a1L/xRy87NErjHvdQ
 ozJFMxIbUX/VRGMMDz5i5x/p9ea1fLxc79T+gnq1A4gCIz1cTH7h4kYImrk7wmcbEYCkYH9mLho
 XIQeiaN5UEeK4o1/Thi7hVmlJ41eagvoFMuPTY5O83kTrvLXmwzC5DoYSNVZDuGsljjyF0+CMjz
 REzoD0QSiufMfv1bslBvtcWqy2nHjAFmfRQqE9Hz0zOWIDEPKpCbPugs+glThyxexI1KhDzWlFm
 W1V08+bRxC+6RgoNx3A==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af98e46 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NXVH2vJESF5G1wsgjtQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: i7nLtvuArkFeXOED2eZJmTn6zNZYgXOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150042
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

clk_disable() returns -ENOSYS when the clock driver has no disable
operation, as with the Qualcomm clock drivers, so the probe error path
prints "clk_disable se failed -38" although nothing failed. Ignore
-ENOSYS, as clk_disable_bulk() does.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 7498cbcb41a..b4a351b124c 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -329,17 +329,16 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 {
 	int ret;
 
+	/* -ENOSYS: the clock driver has no disable operation */
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
-		if (ret) {
+		if (ret && ret != -ENOSYS)
 			dev_err(dev, "clk_disable core failed %d\n", ret);
-		}
 	}
 
 	ret = clk_disable(&geni->se);
-	if (ret) {
+	if (ret && ret != -ENOSYS)
 		dev_err(dev, "clk_disable se failed %d\n", ret);
-	}
 
 	return 0;
 }

-- 
2.53.0

