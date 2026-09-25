Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B938AC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 327F760D8C;
	Fri, 25 Sep 2026 14:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MI45_foGdvjI; Fri, 25 Sep 2026 14:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6AF746081B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346395;
	b=jwh4KCsVFDBXzTVMVSgAnGvsNPiGndhgCnkLOGe2PRzmbDeEsAlSvGLX3xZR1dZlnsXm
	 5KIyBjmmPTJV+UEpPVa5roenEgOfKBEj0XhGch3IGHYnyCV9BkyBa5ixdK+wCL9pD7pMI
	 PHrXUWLqf3zjT9lkGjrJMV2IV5Ig+Ea5I8eWLciAWkS7FwGmn6PrVS/tZIVWybi5HzDg4
	 mtxCiC54GXHbZCz5YOvmBwGN9Jq7ULNuO+FAZpwzJzk1WweXtabmAf6yMzAZZ7zd0vZWo
	 aQzUHa4dQOIl2/3GZI+gUR+LaECetvHYmQm8tMZgFOSyhfihaoVVuILqCgXN1tul2lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
	b=kzEljvT+4IyYeq5Il3Ii7btDjgY8T/7xHlRSEKmSe0NloB7TYPbRXB/G+xNozVHsIkgT
	 w74gwgu6+pTYoAWuhL7ZSIG++tcQZsj237CNFRI70/WeneIxDfV3QDIbw1k2B8T3ceETj
	 qAJHyAWQH9WRDd2SdY/KfK8BM6Ew5MdXTAnDikbVAM4OTPtskuD1rlcrvGUGEs6V7+bNf
	 8kwtpjrfPos03d+ndRZaNKdOkSiCSXEo8vpuEtY92FjUIGtt778VZllp7z1nZSKdfTViW
	 fhk3ydIG2OAmgMnpsy+YrI+p1btVI1ewYtmypbiAPS6MWtd/FddHXhmRVGeh/8a3q/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoRzkDPt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTLomVAR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346395;
	bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wOM1lKkR8paVu8wGfJ3fxapM76WjNyW6ogSnZwRlJ6K7+QZXxQLoSwDn1GvgsN6SI
	 SFzHElkoUxLGmcpFMgcBxuY6j9XFwOQffuUgodjrPZPJgEfQvtQX/Bd36Dq9XJoiJB
	 BP2Jne1ElUqZdRwQ8JcFHx6kyw3Gs/kb0oDSpXMjM1cbgWtkmP+sWasoxzLW+Ei2BX
	 dVaFqbZqx8Shj0Za8JlgI8qQ3VQ/QofJI2sDEHSwUyZrRwD0begs0ComYu2jd7IJcu
	 HvcdRgcGnPP1UU0iqnbM2vDROVpMYxjStfG2c+epR0+/bRXukvaff4FPbBOgJxQJfN
	 41pUTIMA4vCwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AF746081B;
	Fri, 25 Sep 2026 14:26:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B982332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48A91606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CNy1d-ahmsjX for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B186C606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343494;
 b=ib18BAalPMhOubpa59A8j4jkH+bAgqte1+RtUTecN+LnIXK9FeoxSGgGzkdF04tsmObD
 czx6QIRHTjxy4CxKWy7zl22+fHClo6I9PuQ9dMUNLEnS7+yiPZFDw3u9hufbVZZyjQFay
 6q3t/XVqBRGy/8gZllj9dPGoMXVa+zuGF3MX2isS9thl1/u2Z1gP9+BHEiVg7qQAMBle6
 Qr+kXxwXesLGg23658MXwxsV8WqzOfh/BPm1BaAJfJ9JbwINgZOKaQpQEyaWyiFS413Gh
 4sCmu29vSCgaVzmR5qQVYTEpHcmXPEHrM4bnDJYF9sueAcx7jaXS0MbTeOc1JVlTMAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343494;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=mCPCD7BLl663OrdX/+SEeWnAwGkIbhdBVByCNAKMr8tJYhYB8zbK3W7NMp4Zq7nud0ZN
 Cvoo99j2LA5o+urcv5An0wU6G/Ck7xPl3MlrkZ5mqqYs6dSkcQ/B2VsSGT28+B48HeX9e
 ti7dc/MSWGEUD8A9ppleDfmKynltGYuN2gXgVTpYuqhOVEIVF4akmSaBIJElmWcXcWTrD
 v8s5EitNz99xYOgLpdvkoIlpb+pwgYZBe2SA8suiW6wkANZTfKXBziMhUQY1l8bRJ1pTY
 i1WOB1NPWjL/XhlBadeY6VbXVbiIo5T/szrPJv/KcbpEzNxsz0t5G0yo9eTmiB2ltkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QoRzkDPt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KTLomVAR; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoRzkDPt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KTLomVAR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B186C606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD7oO53532496
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QnaVAfsfJOm
 maWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=; b=QoRzkDPtW72HvB+3o4LcAXBqxhN
 Ap05UAFa1h03USJQp2NywOc1zIe7NaVt9ViDLzojRuraIiuGLOWz7mB9DOgzuill
 9tFAVwhk4wobm5fO6LmoIUQZkYwsY50U+KBiFJlJIcUOo4Rk6h9pFCFpD2AD9Olc
 MFFlwBB6kUIVS0IvoQuIpAcRwy+hfE3DillzoFRjE9Ceo+5XXdZs1ZfRix4HNsvj
 i5AhCD9PxP8EVG4pdP53iwB7wjMS3yM+Ydcg71gwxxAooXdjpXMSTNBOFl5fgTcG
 mzzZuCIH7oUg4l3MC1tgPOhM1DvxW82Fn/bbmSDguvR/8hl0OWU7hbvZ7RQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbcgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-143803143c4so2396419c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343493; x=1790948293;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=KTLomVAREDi0i4baklShKv/GJi2mplRu3c+TlBn8gGn2OS0NrYO7/sPLuGyGGSM0af
 EB51GYC1M7C8gmk2/tRCZPZ09/e2BjgZnHQo7M58x6RV85FTzR0KEygs88YO+fhR7w0S
 wVxT0OzbIPoPDHmM7oNUt3nchUF/n9IPDvXABAey9PNFh0X1M0rSf/TmAS2M06qNxF10
 2CoO0guRwVJMVbk0mKSvx4QqoojMRtYJsZHvTZ/2LI8CABM8H0njUMarcSpNuoNDdBcH
 Qey2H4QhrRTo4c1wI7dbfCSR2HnbtQKLnZAsUdhtfNTnEceCJZMJbu+r4lyIBFIGQfTN
 zyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343493; x=1790948293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=Tg71gTVXkzrkd4xyVUS3wAag2qEEBqVaRiO1uedJV8HDgm+YZxo2mMDTH4FWlnhH3U
 sxmjzGx54RaaJiNZCjmi1pltjXESJkadkbZx7C8UkTsWDVhiBZpy0UUBm5OopqkgNfkc
 c/1wY8VMhHHfrhHOh/i/2nGLbpQOiKt1zoQHVZ690vewriIX6uQ4/kU8nTc90xU7Vd4n
 zA2R76Qhve6YPmMNYElzYIQ/jD90sS/Qpv/hjQjd/ZMoZhCMd/jM8Myman+CvQMGVsp7
 mX1HcsuGWQN0IJTjP5wKeZYubRXnednV20KM7CorfLBdxgaTM7MtikL0liaoBIYKaHkN
 FVyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjVWUbW90Zc4oHbU7LSmPtC+PGqEp2NFcp0iUlIocu6HgDXORhaVAYZDTVqgEPhKevz8q74M0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nHSlwtpvq3kHMTwwYGH6SNzA37vA16dl0IRHSN4bboe6fKl1x1
 dfawg8msFrQtvV+ETqBGDMNHVcgE4UpgGRhEt+jW46bRTbe1tFtZFuyvxWzaV+a0zwl4/LCzxgB
 yVDU0qWL/d6rMFtpIiJZCpGef978kzy4LD4O3AMyxh/iYYntyHPlOacY50QQXJ0d610RNEsQ=
X-Gm-Gg: AYBFou1juIvEt7bIyCL0V074R2OQFFTqpnKlBEPuCWAS3fYxz5JlluMuYCyXRfrBNct
 +h6KB2uHd3eTZY3G1QKU3rQPnjczyyo097+Zi628AHFbo0fXDeQQtyttI1a1qquzeeo50MOWU4Y
 S5UkJfRz1BXwNoMYAXtI8/onPAkgQH8UGArj3QlQckSN9KaDi4iReQUHspg0leUpyfIvhfbhmsK
 2ytb+MBl7hZzeXQvfDlfJRjtPJp+kkrKECaKyfrWG2HraEnXAIanYQa0FASpyR2YjABmIRWL5vA
 MXUcFTzFQ2YOFv1s59WS/6+91jRTF4INgWBW2xp8JwnbKM2k9S5614OBU2JCPYq/NH9Iknvb9nQ
 tIQxZDF+h0j29i87qN90npfNzpvdYo4StD8GBysaPXy5ai1I=
X-Received: by 2002:a05:701b:4305:b0:13b:3bee:1e2e with SMTP id
 a92af1059eb24-146ce77543dmr343333c88.18.1790343492167; 
 Fri, 25 Sep 2026 06:38:12 -0700 (PDT)
X-Received: by 2002:a05:701b:4305:b0:13b:3bee:1e2e with SMTP id
 a92af1059eb24-146ce77543dmr343297c88.18.1790343491470; 
 Fri, 25 Sep 2026 06:38:11 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:11 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 02/12] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Fri, 25 Sep 2026 06:37:56 -0700
Message-Id: <20260925133806.1403713-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab67945 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=w3U0zNvCpQhp3vIinEQA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: AFi3pD4roN1bGL7KRK1AfhTO5QfMp1kS
X-Proofpoint-ORIG-GUID: AFi3pD4roN1bGL7KRK1AfhTO5QfMp1kS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX0fJamvzXRiru
 ITYUce5g/CmAc1z2Di4hKbcuGnB90oj2abMW0oJxXSuOnIQYBEmlu7ubh7LtDMllJDCtbmxlN8B
 WfpmahQpcItZvEaelIqXeM1CluU4BuCBgyeAlslhXRgw5Nvq5U8pnLzkUBAmX7677O5b9PVKo7D
 QV9tf1tP61coHvGng0Uuar1OxmeZFGjrJoei/e+OVGhJo9SbboXXxGHUUqmJnPDPF9X3yZexx6V
 WO5sES+ttNgSScpj8tsCwpR2jg1DxtpULK7foZrZSrWuynG08TIxmc0Bb2BK4YXED4aGawyKOT5
 xSclUByw0weMf9BCmLd7MjNzr9TW19qcib03zcsbsyc8IyzlKDcQAlpU5dktNJmAWXSNtSpVyN4
 g0ejXJx7Mq2bWbglFSTY6AmyXw3r4SS0FFJ1PpwvLYtRbv55yvZRQD520HzKLY4tsfORPD0Crsy
 ICg7rodKzn/wYWawr6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX8YrmDDE+W8js
 x0gDovaycxl6wqhNGMTNMJ9/GtJWlM1NWwkWS2hMjTGgT50wzkBzsA60dHJPLDsN4s3CWNKiq5G
 beQKaqskG9xjFBwbxL7hGc51qk4cERQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index ba866b5b6b2..0317489a3da 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -235,6 +235,14 @@ config PINCTRL_QCOM_SHIKRA
 	  Say Y here to enable support for pinctrl on the Snapdragon Shikra SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -421,4 +429,3 @@ config SPL_PINCTRL_QCOM_X1E80100
 endmenu
 
 endif
-
-- 
2.34.1

