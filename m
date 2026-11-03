Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF90606D82C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GzNEtQKO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F8a8m++s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D7jYUF0T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 209DB80DC9;
	Tue,  3 Nov 2026 08:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u07v_i9-FV7x; Tue,  3 Nov 2026 08:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EE1B80DE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793694940;
	b=jbcdGx3bqMt2XOq10SbUMO9Sx4gEaGsX5x7ps17B0i5tmreW30/hEFhb0Dc0/Md6ltZx
	 2vBXzC4/XcVH3fmC3TnQyZ7Gb95e+a3ezjO7uPrr0txLX33/xX3+L+DJtKfXIV5B4n8aa
	 tgLYOBTxzRhq5Z9blxKWZexeBDCm651ZJhzx0LoFf5iQIXXgkOEYIq3Wc5jo3iDzq2ozA
	 Sh/IpyRmmY1/p87/ubtK0dfeukt0+oC/lQlA0d6yTb3JXkRk/ouhRYUTaAW9fLJwBs2X2
	 GORG9/tgPiH5HE28ZD8ucTEurIvkGNU6U1hVjO6j8/vjfN8aHgojaJpXsfMXdmoi8iA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793694940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1jAlDMeMymRFyskbaKxPqnbqygCD4rbcW66OwLrOCWk=;
	b=VLEvcuclWtxTQujCa7wdDVnDXCbAnr47L8SThtdxfGjlylI7Mf6+6dKtyXqiKPfyKV67
	 mCA/XfAlYXsvzSCXSMTpWjV8zi4CS0c6nzKvli/NcxGsPtcZRST9OYxQslgndQuwpoCOw
	 Z51IuzfagUy/ntxpBtPRZj6cYEq5Iej+uCN4WwfQ1Qbk/TBpnUX7p376jSw4Bhp7tUkbq
	 MmfiVZhKw8XdFPKaZmSYmsoH+k5KGrrSsaAcT7Ll6DbEisqrSpb07fQ4h5vWgaJkF8e6i
	 mJoUnbTKmiEUYfwckiaHpvLmt+ROQ0UHIgalRxC4HeqaNU4VCDEN9bR2ofUdV35XEOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793694940;
	bh=1jAlDMeMymRFyskbaKxPqnbqygCD4rbcW66OwLrOCWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GzNEtQKOi3b6gBmqb4/ia6H9nSb/kt5pH1/tLs6orGWlT73/R9kkwtD0l7bSMuANT
	 BCpOv9vZSUtcNiWaxDZlkdAdUT7L+/vOF6aG+cxcFIvtIXbgWw/pi6S49S/9w79jL2
	 jaomS5iGuft3lWvZz4XhVWEX/VVcXxcHdfswpbw5lrwxMg1qXMV/w8liU/nZLfRTo4
	 gzueUWNz4NC7npUM72MAyuPT2Zsqq4ErW5PYZ3vOrtFcFdiAixpEQJGpNMBrNbh2wA
	 hZOOZtoRCBeesv68pNJx0u/Sh4TDX4/+/RwwmAfoE1L/OuHanq92ce9QoDPeVTMwb4
	 KSLJX62ujGq8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EE1B80DE2;
	Tue,  3 Nov 2026 08:35:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 86CE8356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61FAE405AD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vcxk3yzPIqQD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F5AA40598
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793694937;
 b=BSKt/3dZ9ITebd+maQUG+rnxjR2FIZBelISDUPzGmgd5lMXRnKx/+C2qWltm7iFnoVsD
 eex3RvpVAqZOBLeunYbax2kb+gMpSsTdu3R44ZbhqpxWeKQj/eeqFQ+h6rHOpRMQ/7U8D
 JUuJ2Uxz5ai8qa+GccQFxGwgmqz7iGChMCw4fs5gLHoJM4//ZDz149qwZbOFdHGO9K5/9
 PDOZwHYEr61GRIpJ80WG2Wx7nQ716jHL0a63jTTSAspATxcx8zZ8m5fMr/nf8R7tcNwSt
 efjKUMMBlByK6SAr31tEoq0sB06U/lZZEYLhzToGRcHZzEJa4DqJ1ZIDH0A1OplR2WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793694937;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=1jAlDMeMymRFyskbaKxPqnbqygCD4rbcW66OwLrOCWk=;
 b=dCyD6EnClqI6yKlGAJCARuM7WUog1CtKjnXbKkGx03waKlMcL7XX6j7B2RmAtNP1mP9f
 fG3BYj+DjejwYKuvsiZ1+7jLl5IugIoJFAn7Se3i/jBPy9lrY+gbGm1/+MhqjwoYmRLK7
 jGoffqulFdJyohCJn9EKPk45Y6AcwrmXvqR4+9nFd/CuxWQNZzrtG/WHk71w/UP1/uH/T
 U9kWcrFsjOUwy6QwPGYXV+bSc20u/XJ7BmwvKDfutb0qVpSZ9W1h3C9zfDxnMpebuJ0V2
 s5CilyiEx3FmeoZ60RF5ARNUUCsvJglfko02cgjTFEr+2yxndVeQM3Zya9gdK3Gv1jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=F8a8m++s; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D7jYUF0T; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=F8a8m++s; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D7jYUF0T
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F5AA40598
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:35:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A38G3uZ1434174
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 08:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1jAlDMeMymRFyskbaKxPqnbq
 ygCD4rbcW66OwLrOCWk=; b=F8a8m++sg7x9TiYdhkT6Bc6/+GAM3h8BntlNbTnB
 6FAKYN1LAN++tFm15lJ3DvFYtOwLBOic29Te0YZTYNBsbm2jnPoylsnxB7Jc2uYc
 EhslJbZxjE0Dr7ELxZ22hguIjLbRGLiJKby+igUpik6QhaFm9Z9tZS3lKUwzVX4f
 wb241doaq5yAhOobhQjNJYSXeiYxoIg/bs1j6OueByHSK6n3hAgSXm6elm861YfN
 KeqBv5i42hB9lz3B4ac7N8P7lxhopJ9F4XxoaCWVyPc6lxbnIAbzJCdh5Zfb9vJl
 PzYfBr70Yk9nLXjzEALwE68ePXCKMGp8PBy3olWBYqDJeg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acj6ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:35:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so15656914eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 00:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793694934; x=1794299734;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1jAlDMeMymRFyskbaKxPqnbqygCD4rbcW66OwLrOCWk=;
 b=D7jYUF0Tr0HUK0yvRDJcokouKbOkfOmkAtVn1PXLAT2M3eJKmSBMR28nqfDM2JJFn2
 Y2z5bsUF9fbf3Irwp+LRih+402lJgJ9LClzmJoi7g2COOVEz6XDTD6UA6d/Hq7+8Feoc
 4d87x3W5N7cBypZPo/q2IWkRp88ZM61ujCFKHP7MC6Gs8Lvq0NBary9/4/vQ0n+4SYAH
 ja2gw2RKqEg1qQ7eK62EYZm5ZmTTP91BX1gITMHpLrtzTqtpmobfArv62+FVOt9c5AwF
 Q+veYTxVUUfjRl2sBYmPx5xdsOgyWYs6kJYv5L5spPwVi92J8RLZf3FoGRp93OjXHsLk
 6ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793694934; x=1794299734;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1jAlDMeMymRFyskbaKxPqnbqygCD4rbcW66OwLrOCWk=;
 b=0EcJNP3Zwo4IOzBKOe2ZMeJnAtq1wFR6ctiM+FZS0gsRlNUy+Z5de3EsMocXcELpTn
 ul2FpZ16WCq7bgeCl4yrJvhDnB8EFmYWZPHG1vEh087+IsxJL7/zPSj3wDRuGfOgZsG1
 oU1W4ZOp9jB7DZidc4bv5hCJyjPIy8n/uk1ptWzJoSUV7tMKvAtGEoF4gGhWoqL9qaod
 uygK7lmWslBgN9FF/mRYJoXukNAUcOOyHrWpJpb5yyZoVOIUPp3CVrJk2tsGZqSbmCEt
 GW/cwE4ROJwhDyNwwLi6kN9wg3VtVU5T7u6yERi81IQ6RQP73jm89LNwBFRvH8J60L1p
 spbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvYu2kvfiL42D0nKKFUWE3eFOup2oZG8cz3Ys03wCW2s1SZZJtgdtFYjKoL6s1NQgRKLMCLzA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9oo9pq2bpZXLzTAPaZXP9oYAo6ziuwz7ljGRnCLeZA6MIwtwIe
 Ll7iDg72RyLu9C3O1obdH3m+OON8rBNjDEJa3Ramnv1Itu5x7k32WpiTJM7lf/KcvOHAzlEppJM
 OB7gVqGW+FGtUWMbfmOxPS5HX4oSeIp+p3QQcodEMrHHxUL3YunFZc6s8v2gJO2uMyBX+it0=
X-Gm-Gg: AYBFou2KqtHieyf1o0PaNZB2Wai/q/71yz+IZQJVEZOOwLEbvG596u91r02KNwbWn1F
 wnDwGYBk+LSton8KcFxMgdC6PuoISLsrxHDf5jARXEWXiUrcnvY4mjipkpDZNNO0V7ExzVzv1xs
 oOObDVLjUQ0DwvRW4LEjSu/FhhwWrROu5y/UZZrxhjHnMTStKVFK/qCV6xaLUdXkBu+sROI85dp
 xywzjsnqZAV5YX3AUk6t2iAQLFpy9gACYScJ+Hja7xrCyDbXx5oy3/LjPngZ7ZZZbcNzss6WF5W
 NlAyoP56ULy4zFYuK+Ov/k+8DQNqrK00XQhAbI3vB9ONpSciJ+5TCd7XYjKZ9H+WCpaY93COCXn
 fULk6xDfKmnW6g+isLQ+SKq/rcTJGE/ixjZT+s76tOwONWjVAJgRhd2IxDhFxS5v+3qvK2V+Jh7
 25t1QBSJ/wlUEFMePwlKXSxjM5ezvJwWkonTkD9Jzbv3/PuKdUzgD1bm9l3uGIUldIrNQ6MlYaq
 b1lXg==
X-Received: by 2002:a05:7300:fa17:b0:36c:3b8a:8089 with SMTP id
 5a478bee46e88-36c3b8a8474mr1316704eec.36.1793694934211; 
 Tue, 03 Nov 2026 00:35:34 -0800 (PST)
X-Received: by 2002:a05:7300:fa17:b0:36c:3b8a:8089 with SMTP id
 5a478bee46e88-36c3b8a8474mr1316650eec.36.1793694933472; 
 Tue, 03 Nov 2026 00:35:33 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428fa380sm41725082eec.12.2026.11.03.00.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:35:32 -0800 (PST)
Date: Tue, 3 Nov 2026 14:05:27 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and
 debug fragment
Message-ID: <aumczyxGU6jw/IiJ@hu-varada-blr.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
 <20261102172155.GE3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102172155.GE3309461@bill-the-cat>
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae99cd7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6U9UWCNB6B3WDRcPzk4A:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX/+HzfVSbwcwc
 +MX0U2UfBkxmwv4VPu3BQY2ugxjlC7PWNW+xcb6Eck7g1Zkx0LT7zxz58KEGk0XOgx517hAGb2W
 xsOm+ICWQvXVimBz8EB45tEGln4UC73N9ANyIJDx/F73x8XEO0xWbd2r3udAMnqoRnTUXwLFB+H
 dvlEOYawvb5E3l0GfmjoyTxZ1/f3WtSYYJAfwEMjBQb1iQrCN9Y8cZodYsxLwSghlyWb5AX4Hme
 0+FMRPCnxH4XuBQuTF3VULzoFXaS9Ahu4VdAVy/uMt6Aj7e2RfW3AS78Xokz47sbW/WaiymjAMP
 4wWm2WJTN/x65YkBmiXes3RK6tbTHNhsLtxXa/9Qzo7lhntGyqyERBbCAV0q9qEYD+dpnomIWEC
 0jXdXtCf2HaCetB58X/SoSPKKR9qZl/NDxQ5+lvvE/Q7cpl1o39o7lj5asgNAPR0klYvGwbbakF
 5d184vFJ6gIcl/FhndQ==
X-Proofpoint-GUID: oa9Y8T-EBTXm7Yij3Dor_P7FFRbCwJOn
X-Proofpoint-ORIG-GUID: oa9Y8T-EBTXm7Yij3Dor_P7FFRbCwJOn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX7zJ0bFVfWGig
 vQh4+ot45c3MVHrDoYGaVMBGZMu4LJYBq9Bhw4z5nRtrw+kkbpwl+CRxUz0DZtDB4oL9kaHvxAG
 3erxypCXfeVRk8E0Q+52xBS7RU3TZ+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 11:21:55AM -0600, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 11:22:27AM +0530, Varadarajan Narayanan wrote:
>
> > Add a defconfig for running on sm8550 as the first stage bootloader and
> > associated debug config fragment.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
> > new file mode 100644
> > index 00000000000..40f7c857007
> > --- /dev/null
> > +++ b/configs/qcom_sm8550_defconfig
> > @@ -0,0 +1,16 @@
> > +# Configuration for building U-Boot to be flashed
> > +# to the uefi partition of QCM6490 dev boards with
> > +# the "Linux Embedded" partition layout (which have
> > +# a dedicated "uefi" partition for edk2/U-Boot)
> > +
> > +#include "qcom_defconfig"
> > +
> > +# Otherwise buildman thinks this isn't an ARM platform
> > +CONFIG_ARM=y
> > +
> > +# Address where U-Boot will be loaded
> > +CONFIG_TEXT_BASE=0xa7000000
> > +CONFIG_REMAKE_ELF=y
> > +
> > +CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
> > +CONFIG_QCOM_GENERATE_MBN=y
>
> Commit message doesn't match the contents,

Will fix the commit message.

> and maybe this should be done similar to some of the tegra platforms
> where it's just and only a fooboard.config and documentation update
> rather than a full defconfig.

Added a full defconfig since the script needs CONFIG_TEXT_BASE of every SoC
in the MbnData table.

Thanks
Varada
