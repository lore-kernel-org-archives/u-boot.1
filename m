Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE945CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A5176069A;
	Mon,  5 Oct 2026 07:01:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFV8ev1tfVA9; Mon,  5 Oct 2026 07:01:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C8C8660613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183669;
	b=GZz3qo9gEFU7KbqpLRVNruKJrM4gyQjYSIgHuZn9QcmG1t4OwrczVvkPH7WGAq/0UCCe
	 9bUiWY+b9jAk4h75LjbVnOGLPx2bW300deZhkDAvlmYsFLDAwJBz6cAxUB7kEeI1Z3Dc4
	 Dw2H8NVLE3wRaqfRK24j2XBO+743szQpOD5sf4SU/REAzoIEiJycW0/pLK7L/bTfUcdod
	 a/6o9A6rEItRftx8jEcbS73HafejyS2DEvCLd8neTzyVA7ff92HJXkkZ2hch1CrUt1Uft
	 JGrGB3xa58R9eNRheCkYSiJEwayEYvAIT0zSqGaRd2fWHaiXIiSKgC//e56+EC1nS+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=RehdnTNw10FdSmQ1SbOGmTxa7fjU/BsTWtQose8kYnMS/d08KcwMoK+Rz7enUTkg/Cu9
	 +MKhhk0J2t1r4RQ4ALjkJEOpNv8q6IVmvG2ijrSGwa83ZWQPQzdbtgu5CaPKGrFGK/Rj5
	 LyX6gjQ2ROTmNomy8HnZsrUGZQiIxqC6753buYenSeycPsSmzM+FY/izlxT54f5E8JwzJ
	 u2FnM4Q+wY1/nVo/6yFZoISxlkCySA5f7O4yzqXf93zvztiajiTTYCsyGASaDaw+UCoWB
	 W5ztWStkXPRXu+9g2hxE+ugZbGoSsbIjNpDBAhlp3bzTjk9H0lGsH2J+fiL3rAe/gkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183668;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VcWDsf+dYtI43ZPFIOQjYMUVqNMbEil/CdhAmvcpYWA57qKkAcaWdXUbJPH0vrHJ8
	 uq4l8+jKcldqbJHXt2Yywd6pKegNbcHhBitE4jN119USupk+G6wtkmf0nr6N5iub3D
	 1OLdWU0dW40V9QAHEUgH57UiWDNSn+3E+exkRiqi89llIA0hSWQXIP/0x+Cn6/34oH
	 UfAOA3A9r4aOMlsps9LpZmJfIk2I79zfv8TIe17sZ5tzZrcRnNTSFUJKUP17MDPBQs
	 Wx5FDJ0lZst3jhqdRBK8i3VvJpMw+yuaWDZ1ERSK2hTapXh4ujR8dsqrtbTQzxJQ3X
	 /WPpUcEAYJJ/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8C8660613;
	Mon,  5 Oct 2026 07:01:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3025775
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21997405A7
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZrlnzrOhD1a for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1826B40638
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183612;
 b=cGFQOhU6KmcyfbyHWQuDVXfMP2s7BjH6HQvUsRcOqNFyQlh8glOkOZB2vdIFkYDEgeii
 k3FYIZZ1wErdqWLLxE5dJArnbjVMK5o7PtQlMxuNpLd2nxNB+UKMopxxqn8JW3LOFe14M
 iBVv37DjQtHe03206ZWnatqVnTNlazWaQjNDl16CwNYpOsq2yxlUFKAE1KFrsYXNRKweq
 NfOJj77w7ew6zlzaqsz3lDRhWrq5wdZxGQSzbFk0ZWAawz5qX8bs8XthIkw6Lpffggjf4
 qQpdYVxMjee/L/VJnRGVhbI7FeSpqtTqSwuFP5cuGJvsQmcINVeuOWrT8hRn/UXtA+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183612;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=ao08KhJqks/6aVYgHnTl06Fx3VSHEmGs9LGNvlN9v2pvLxAMDh7eh6CCmf6KgN3jjnFK
 iSaQogt09NCRPjLEjpZcbhXKPfk5JQ641iEgzMxVckHsLlXgpmfQb/D6bmZSQ/tRtgBTZ
 OOKBvrYCL3aiZYG1GAW1w7REz7askqONAp+YH07PNrApcr1erTUQad5GEOot1Fs40ae70
 xId7z1Ii/pW6zWeJMW9w4NRf5Bf2S8TnsVzCoWikD/uJceqg+UVW22m7KU5wLKvaaJbwv
 MRkGmxo3GESUuQ+o6LpVpd01h+HmJ9H0j9D78Oyyz2nXDk/SSwWQFqWptw+CjsAay6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aQGSlucZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=So5sgygc; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aQGSlucZ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=So5sgygc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1826B40638
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103Zp3688176
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=aQGSlucZWYmfrieV
 LywVLj1NCkV8kkph9eKoZ1wLQs9AxHr7AZHgWHuyykOvLc+85eZUCMQGuaXAVlzS
 rTrkj/yh/41Z48t/pEzkkHbGGFtg12iSq6lZYh+ItFZIX3lZe8ww7Et5DfLeIEAH
 VolgEP89H+Mf4mjjk50mjRmHEr0UKrVMAMpTJZbgofJ74ueewa23yE09aBZZYjvt
 TZV3TbZUIbt7z0feX7l5N2OPhfEIvAjUhGf7TlQ8W13ifaqxeRhsZsOW+4yGp0mV
 iRhbVhQfxTH6OPgdXOE80IEqMSEQVZtrT3EntbUn3W9tuB6uyJeRBC5DAyR+30aD
 exjDXQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3chfjpv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:00:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so6622185eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183609; x=1791788409;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=So5sgygcBnSivhLS3tNme0hwII1V2ym/8x3rQe+G0IeNNk+8qRYjjrc9Yo5q8SD0K+
 HzmPNFTSbAsk/A5BTEujnUhS54cK7atFh8d8QqeJlbXTJZI7cyUkXfUU5Xhj/rWo7GiM
 ybm1Rd0zuxyLxwYgPmgOoknGq6yp1jWwRgdnd2f+OTXY4Ppmzgz4gbuONxjCcjFSW3R3
 DS/ONF1HAwkIrXEYsJnrW6y4fr6G1rzfduVlx4P8uGx3X1sJ8YPG/HswVlzhehxSz5WL
 TSpYGJDe+ocPIhjmgeaVfXlJfxFAsJCC1Gt6K3s9qAMwz/t7M1JtCD+k03RcHlSDjk4x
 lYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183609; x=1791788409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=rfUTF0jqxUa7+ycO8CAVpkQOhabLgjTkUha6JGGe7/BvASE8xuzXlyMov/eucIk6LL
 kZ9BvnOU89oWRwdbkRA4yYmBMDlgCMX+VYf00Qqqwgw4MXR3CXQKFu1juGNXo2jnI2/R
 /hAc9gwZ/sV6ZgVP2Au0GQY3xFhj0nuo44GxdLs+qaelo6uPHHK2/e+q5Loe/KaDnnxD
 /ZRAwhrtkFrgYwmiNTraRgA30xM47oUIc6sTnBZJHNf/f/1YlYv5T8/ZlSaA7V9s0Xrx
 3SndXTYvdK9bQMibXmcOqeL8p99zswAhtpXNrJHLisLTvBtkBVBMqIkVGf8tAqeXzfJ1
 jioA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwI/KaVMLF8TVc4gZhagCdEpX2GH7Puq9kegfm1pR74GYysyVjlfSZUowMIwwkwbFlRlEM98Bc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mH5VbDfErysuJdthDVLYX58JABXI+mJIFvyoJSoFyIFx3Ai8ct
 4oYMqHYbHHmaE7ShxqyrVhjRsW4Hl1R9iK4DvSzTxMRD7Ct1M9lkhnsy5N/QXCoASNwSNeJ3dP2
 3sUoVKH8VZkBufJe3KK4EUgRb4AxYtFNc+gSLiGIlxxB+un1KDqnnZ1gOPjBYvU/EuZpeQFRYqI
 5EUs0=
X-Gm-Gg: AYBFou1w0F1De+ZRot1e2o+ObvQkO66JW/bZI1PKxEcTr0KfA6AgiRdBYgKLrLQGt0s
 ilQ9w3t9fMz7AoSB3q14x65f8cBBFf0qC3eL13NUfZ7H634rohIrPF/P3WKQF+GkzKI6ESUjI3r
 vNTm8E/dHGDzluBO5NCSzIKdFCk0nFPB1zA4jYtcA6HJPTmeFyD/Y+0AmODcuno5zW9+/VhshG+
 Gjz43c/Hv7IGNwF1n96J22YDKQu7ELNx7BKDCF6ajfwibrkW2ZaRU2Bur3YyGUdrjnhQ+Lgjrcn
 9scCB3peHywbZzjsR4/sQ/Xuqs42AieAubqmA6qvug84lcVwL8phTyII5Rg5b8yAGr9QmI8yREx
 MJ+TQ1vu4Z86eVxnRc3DykdcpQzXqsrdp6oOytT4FnIOgX6LhQUe8zzOxclUVJ56yHmE0hh9xnk
 wPEZRwgwSSKiIS/viMx8vtICh+rujH
X-Received: by 2002:a05:701b:428d:20b0:144:f47b:58b0 with SMTP id
 a92af1059eb24-151c4f00821mr9311273c88.47.1791183609232; 
 Mon, 05 Oct 2026 00:00:09 -0700 (PDT)
X-Received: by 2002:a05:701b:428d:20b0:144:f47b:58b0 with SMTP id
 a92af1059eb24-151c4f00821mr9311233c88.47.1791183608663; 
 Mon, 05 Oct 2026 00:00:08 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm27963498c88.10.2026.10.05.00.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:00:08 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:29:54 +0530
Subject: [PATCH RESEND v3 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ipq5210-v3-1-e0ec14fb5796@oss.qualcomm.com>
References: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
In-Reply-To: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: kevzrYs9yzuTnnx_zmxhtFjf3UqaB_EF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXwDq8uf2UAekp
 4EsPCV9pq0TioIzi+UCOA7mO/+rjq2g8UTDfzUsRRbRWBFCVUYN5rlJHmvp5rBigaD4ocFAYEYm
 O6iyrHypH5OIXMscxMdUDgwtP0vzKSs=
X-Authority-Analysis: v=2.4 cv=eZSo7LEH c=1 sm=1 tr=0 ts=6ac34afa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: kevzrYs9yzuTnnx_zmxhtFjf3UqaB_EF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1UEGxMVJxXQs
 Myp2csSxi6upDBUYeDwPEBvIyM8h1Xo3Z2KD0OleoKHGDrY803ritDtDwY6enlWOGJyuchIfBDJ
 dQhiiweczTDvmZfKUeXSSHgt9nic8nRci5vYcYrRJvcmxDZUbBHYe8qOqvCoo5LNzyD8RbhgAKP
 CD5+ZdL0V5OEQVglvPBocLpLqrYVRudUnthkoaVaFh9yhJV9d+6v3PbUE9ZfLnLsX28Bk4iNRBv
 pM1HBqPFRl2dlqYGGfOJPx2j/bUlq3XV8nHHibq4m+w8zSMFoONSb6k/O2cRyKNmmyqylv8XOLA
 7Yr5QAhChlvI4Xd8Bav8xg7aIb9xEP6+7Hir8yBH9eU8XeSdqXOe5EN1oicygOvY3Ugt8zRfs19
 Jzc0FQg6+LLm4haMWNVq/ynWoNh/K3ne/H+C7BxI25QyflkdGhnZSi9H4bj3+DoT2EyvN8iEvO6
 DLC6F/GCkiqVJ4i+aRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050027
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

