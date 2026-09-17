Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4960C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA86C6081D;
	Thu, 17 Sep 2026 07:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlplBbpZKYZB; Thu, 17 Sep 2026 07:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5B5D060629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631164;
	b=Owbd0iCZoarDJNGUV6phocL12ctlECUc1sz5aPB/AvbYift6EUHuT3+MuEJ91QWnOJUk
	 G6aH5K5HsenQYxq/74F7gcSNMBtNTOQ/darKz66r24xcvSOqta0OI2jHERuMau2g83waB
	 22S3WVY0iNSL2Fh9oHa+7863OpsxKK2G+TGxaXh3pIlCprz6lMlaWvFRWbwwd7Mb/Kk5l
	 ejV4I5+QlJ2sob8wmB6n55Vh6dW7P6mjxGSdoxYwaC9kod08xVE9CnY5prcVCI5HvX64I
	 AOuK4acaNg1Z4SGeFpACDY2VTzwGeC4jgcLJJ5s+Ft3oqbXZunfk/MIX7RGt0M80hNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	b=Un7VvElCvVcGRA8rGYEynyJXgSOY47mZt+m+VO6RP+eHdLUv3/Cx7YcZuMvJYMxU4kbO
	 NFhKm/e2zB/H3AXFE4s3mmBeZABMlcPoXlx+/TbBaSWCG9HJdCrX37ZS/yyfWpNFSZ06Q
	 V53ksImgQWhUmo//wDCZe71D/uMzV12RVt18Jn/1zNNmDhVar6ANhtcIKrLHtI6GjHEYk
	 pB5qqtcqA4haAb8iFkOVlXz9+7jPjSa95ZRQGuUS31LXc2wabfF8CYL5ZJeZM4FDvr8CW
	 wLrYlKAOCURl5+TRQxVl35s23oN5Q2Oo1M6sSVVmizIrpM/XtDwp8iqPNENelLl0bBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631164;
	bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqBeEWr+604AUgAIT9kyCKAjr+RrEjXe8eucmE8fhriucjfHhtDznqP7U4hGi5EDk
	 QMLp+k5sSr62MmiTK3qKJwuQSKfY1z0y5vTE7RKXvpfcYVTTjN7iKaEOhV21v13qHR
	 st180VmepqECt9Fdaeng8cpjxpkaZ0e8BkB7p9lfRgVEFIl72mvpd7H5dP4AncULcg
	 N4nGYIUzQ7D4VatmDiAyjrAU/uYrUYRqhzhqu9TXmMjd4QOfyL3sWvVoooZVHm0w+u
	 TXMt4TrEM+IcKnXSSxs1Z+G339XLVq+jHrD2CwdImybpgGX8ffp+KRtH6zFGpQeyhP
	 2Cxj0hgoQiQCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B5D060629;
	Thu, 17 Sep 2026 07:46:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 570E024D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CFD380EF0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-Iv1ykHkQIM for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BAAD980EEF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631161;
 b=gYj3ponIoTjKjj3NtbapX8h9cme5xN9S39q073c3tFJBzHV1jpJxXDWsIr0FWLWGHlF2
 QiQS8DIdjTgXxfyNYKn2NCgpm0S8c4AdFKMBDobLU0jMGyFxxIHBX6J1t4T7jcuQ3DTeV
 mbLp53X4UIF1Pu6dx/gzKK3lmDLuNcbAuRzZ/75Vi87xjP0Wf58pM/WGcJvAu15TJ5/Yq
 W8dR6GiDjtS3Fw3xjpVL8G2ZskOTEucJeyzCBcamVEk3LWTgBIeEHXQbiWoaaFdEgXV6h
 nhugvH55MdO+KJWTsuyKaayKXnF6mCLX0wpue1K+5ILF0QaqfeFVjLRYXBKBP8IhhQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631161;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=T1xSYuQy5vbv4M0TZaWbtCgI8RYsJTikyLAkTbD6dcUvyA0BC++n821y0y9+Sf7nKltJ
 BCDP/vUWG2tBnm3XYPjYrhtRx9+vzUKLWiaZhFo6CWfdIr+o97O4eWEd8ozFnmLZ8e0T1
 NsPckhQxcWRWgZx/KSnS6hqTpcUrbKbd69GeLuAJEzLejvGW3CQdcDYS5jpowgmTyTTPq
 ZlPCV/FQTzmdscaCBnPOxz+R7Wi95RVgMHUZLyqxKn6z4ygl71Lv8/tfeGzZTR7MJe8yH
 dtdeIvqTQB3jM+Q2pWTL4SOgfSDhQoGa5AOz1Se2cupCLIwiQEUgWcnIerjfAnVTe9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AU55K180; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IT3K7vo0; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=AU55K180; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IT3K7vo0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAAD980EEF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61Jpu267977
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=; b=AU55K180CRhqIN41
 b/NZkyv3xTW8m6L5/zTv0pJCxrNWu1eA0lhMVC90qSfrPzKf8e0OHHVAOYcCI3mn
 7bXWmJQ3Z8nOdvU+8i7MHxCJDxV6DN1mhq+eO/18PRk5RF//cD/Ic7YWP8OvFWRO
 vrVeCiSh2VHpdgzFeZLHgxud2oXteH1X57Q+5vEdr9XnclIa+0ZB3v7B55dfwSu/
 0Ycx9KVt9uMV/6snyFadKOMP1j94mf0CgWHDQtLy5JP5TXzy0p9Gkd4NqsIhtBu6
 /XGTMdzJoilOeOk4Ujiwl8Tqiy3PwSiztjn7KPt6ISv90JXlxf0xm+LBf6mJo2mz
 lU6kIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb4773-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso9781855ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631159; x=1790235959;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=IT3K7vo0G3/v2Iw+6pUZQDK9rbl4sxEXzpHUpIIunoAyozmumDBXkp2xKe3Y35aWF2
 JCqbj3QY4cDtSKce1y/yD5KbBYEeeA0fT+P53N0N678V1HJMrmO2LyBkZldzPt8uTwi2
 /sq6jyn+C+G15wDd+Og1ruuStCA/IUAo5Dp55gDte99spmBygTt1QTfG0O+21xuoshq6
 7QV2gNpWof/VIxy9hYYmfHNTbnLTAa3X3cTVhL9ZQ/WMMul3B8lKBbCDnT2dkxRf+ykS
 Ffx868nC8omFkyL9iHgbvmG61uB/cSnZ9Flv6+JP/tvt9qqxtFRtO23aMw0iv9OseMfy
 kOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631159; x=1790235959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UTcxj9johuIpcwHQyrapKh+74/Yy5Rnv6OYbXL7NBLc=;
 b=ZYyvA/T6jaSm7Az2IfLD7Xag9cbw1IOP7ZPEcv95VCRHxYrl6Uf4tVFcgEy4soXrd3
 KIyLeNeT/xCi6JAsCdaxc0R3nlJaIMm2XYXWkETToHIADXl3cs+0NZYPGZa3XIjJSQq2
 X0QGElpMgAHzlynIIixtmrzC10FoluNgH6Xrgr8NImcSRlFKT6dEiPRmIGCGs52Evmzv
 vAjDWTT97FmNN0dRBJBo1ijqY0SNhRKbpIqA95C7myf9QisRpOcv12GNe4zX75bTXNAs
 ppREGibKNEUem6H+n8J41r4xaU7fizd2j5KUdOZZ034qXFU7/8wrVXKxqxyby5VlE+LL
 67vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDyZxfDq0SzQOI76i6XX1VxtSGGQ8uqSrMVXP8sVOPzeUMHVBnCI6JS+ZQuz2mnt60lNvZplM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1OysIk5BTlDSNIdmbCdDa58tVaK6WHsU55kFM/9dMaah8KksJ
 0oGOEf2/T8uvFSehKMfvqznF6FDlNS//IgYUuf5PBX7MGhEIGRFy347A14zN84HsLCRPs2MUOxo
 SUg+dbuBfXqfZhrCc9oPOuZ2dHc5j13DnTOvZs+GeaOpy9N/41ABaUSwaO5ZGh9+mi/TNFpk9PW
 bR25Y=
X-Gm-Gg: AYBFou164Zzm2aD9Y+Vj6laTRwNuG/HKZxwecFs1FPO0vCzyUAyxPGota1mUMmhorGB
 xYoVjNudIxOihZ2zXFsKxB0eNdocSejtB4M1S/ahb1ODUSTnR42uY0HbXhyN3JF5Qi2JcBVf4gf
 9yhjLgnKQwah4uwYGIHP0F12l/RSlVbbKk21aFRHT9jGEvUy5lheLm07K+H6ihMH8IYBCD/Vjx+
 Nxyba1/YAmkTPp9PDD5MoY3KUme0E4GHBNWXjHsWosUMyW4OYVcPVnF8QiBSzweDC6veQ1LCudu
 dR1eYWI8ym+SGn98ohW8iTjijsYiZavIj9iBBwluYCGFi6r0G+C0zqHVCraepr2kYC/dTncf5/a
 tC+WNKM0GFf2YOVlwfRcg0b9v1J+uuOKnqXZco2aqT5QY1zPW/sYacLJLn6wlBQtbCJhHOgS4XD
 3d8ViKFp5cp6pt924Ys6WdI5t4+mANYA==
X-Received: by 2002:a05:6a21:6e4c:b0:3d1:7238:33d9 with SMTP id
 adf61e73a8af0-3dd5f405815mr15147922637.3.1789631158538; 
 Thu, 17 Sep 2026 00:45:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e4c:b0:3d1:7238:33d9 with SMTP id
 adf61e73a8af0-3dd5f405815mr15147872637.3.1789631158066; 
 Thu, 17 Sep 2026 00:45:58 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:45:57 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:30 +0530
Subject: [PATCH v10 01/15] misc: qcom_geni: Add minicore support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-1-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab9ab7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OeJ7P-MtQltDYP48I0AA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: tpnttFH3cwljSwfPKYI9mPEnEPoPRaGT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX93tQWWGZyOYX
 Djv6j0GCiqDyhNyXsEa96jxDWw0ZCz9hfHfld5yTwkhyr3ODrthbn/Oa9SsHlrkXj30x0dJSDZf
 mkOOjhksppDCP+XnquC4LU6epigh7Bxm4nRjKLa12l+RI4n41bigsOAXLIrkeLZ3ewZ8pkq76oS
 ppqVtq45z6TdjGE/ZbVXfJ7U2GrTPO1TWnbbMudzM1kGrQ12hEmgeTI2JM5tDT+Kef8CzI8IXV7
 8IM/WT/F5/nXieKwPqqedlkrdPWlqC/X2wKuQJsysVw4aUD7cggRFP3/Q8LsS6fCqAONyLwq1XO
 hvFWFKGP8jjOFuPZ+2wZm5nDz5thuAkTmqABzFoCdxg4jUbSb5JTnyhkOqBK4y/brw5wmbmGaoc
 4ogYW1jtL7ZDL3LlZx/UgKsAMEBdFyKm3cTJILo874xhZ5/kffE07N/tA6xuk1NfEVmgPIBYWNK
 QPUomKWpt182ewkQfIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXzjV48OZ02tRr
 nfRgnvIZLHBpZlDHRDD2wvLAfmGaY5QlRabBcm4OIeSts7uyEH5ps7oHVILOVgNChFsDrFwTvLh
 oIjA09ftPkWxx5YzPvbbFkR3DFUhLC4=
X-Proofpoint-ORIG-GUID: tpnttFH3cwljSwfPKYI9mPEnEPoPRaGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

