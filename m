Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF623606D811
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mMNHG8Zn;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FfFYxpEM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KEQUQXTh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EADE81004;
	Fri,  6 Nov 2026 06:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRRFe1tv5lyf; Fri,  6 Nov 2026 06:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51AE480FB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945289;
	b=sqoh3u/fydRtt/+3bjweNIXs7P9+NOmtW+y0VHQX7gwm9dkBQAR494ty/FiYZQkh+tcD
	 oLzd7CQ+Om8/YbWrQnprCtuKbuC5PSO/QoCHOEyqDGP5CzGNfy7zVdEkD7HeIi/npNMOo
	 5PUQ9bZZlioCP47ej6/efxqp9ipAmZ5wRlSEPloPBX33toFH38kXk/6Q6Or20Z/KupDXi
	 xy9RSUEZPzoOcsAHo6Z2rw87soVw5vAdHNm/bdBWSBZy5qIYo/0RjSrNYWMZHa5IUb1r3
	 rv5RlNbvPEppQ8aVUB9osw/ds5hE7f0Q+AOKWNN2dXbGEubWCmhG4umvAuwt1odekfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PgHnwCuxZFLvVQw+sSArjczpoHdVCXQgtlkjBeHtPiQ=;
	b=X4Ah5dKh5xuKNNzJAaVnMDqN4HnCCSnqkWgyvQt70P/ufT8/PviRN2CZx4lPXhorGAHZ
	 dBsi+T8zthTdUsKYwEm9QAAu6i+I6jUR1I48UWsSy/cwnoZ90LktjfyEjQugRkWhW5R+o
	 /e8sFtipOvAFG92r28yRuWdQel2LB/oio/BLW0ufUfQgSgfnxHCei3x36+JuYi0NJyj7U
	 eoZbTO46lg0lEGeUgYmQ0SqrWu4oUka6gXLwf/dl+Kn2Hw8yVuFXM2GkXgPa6dlvaPmlk
	 3bwUhgI27bi4Z8TOw4G/LTWY1SuSnQhEYRU8DsKkLEpP1Cn2fGk+iyqi/DmxpOwhvEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945289;
	bh=PgHnwCuxZFLvVQw+sSArjczpoHdVCXQgtlkjBeHtPiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMNHG8Znt1RdLJPYBzUfI3XJa5nnf0vgNEsudndUxFDQjKGUIOeim2VY9NC8q/D6P
	 BM9O25dJpT8d34TfNTFK3n+GbnUKJxLvLsworEeRDFswIfIr5M4opZaCQvI3x1YeFW
	 7fewfokZp9DVyQvxQdGB0YB1Np24fz6uT+bHKSfscBvjeUt7D1YGanJhfbd0WJLMZy
	 QKL45BfI0vDNud2C8cVhSYMIAD0Jh1PX4PJ0H4zM3Y8OD2bliY33XWM9If167DR2hx
	 cXWs7McWHIrmssrndLFxlGU+RGAvxKp5eZbN7ZVAMQlgWPXu7VsMTmfiZeXkgprNZ5
	 NzY0vqaKAQpAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51AE480FB9;
	Fri,  6 Nov 2026 06:08:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8412232A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67BC56061E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDhdvDkSfSpO for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85EC060657
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FfFYxpEM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KEQUQXTh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85EC060657
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A63xvDl2779079
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PgHnwCuxZFLvVQw+sSArjczpoHdVCXQgtlkjBeHtPiQ=; b=FfFYxpEM5COAKekL
 IARZ1DAUuFdVZXGBZRx/Ks2dWJj3wpkEkPaGE/TKYc1prsR5NvCTBettMJtqvJ0O
 oD56MT4/6aoElccbwLhiZmFIGKktaKH2XgCIHIzpDo2zI+CZix2YAI4AOMxyZ5EG
 oWU5g1Kz7XXnXXsGVjxaOrqkNMLiazdwXdTWWct6FQDIeFd4BPHnesCIv1BDuU7L
 hU4v5j08hl+2Ti0UbSIshremlatZ0rEkRt8bOcWkwA7uWE2LjFxaRbryG9Gj4ygk
 GMcdBvso0iEsttWlfElBnBIuHN5Zd7w1DoKFSX41OKilhPr1g1IUd1HTcnfvd9fq
 Wk6qdg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa16kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:08:06 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1ac19c6bc71so404594c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945286; x=1794550086;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgHnwCuxZFLvVQw+sSArjczpoHdVCXQgtlkjBeHtPiQ=;
 b=KEQUQXThhhiixOxbIvYkOeQm3ZU+bpZX5eRfuwXLn5GOFZnMYmsP8nPq2AG5LEu2md
 03LVaVtcowLx89Aoz4hvKtBYIc5LT/hEZ0IXpTaNlrQDcpggj7XQe7CmrK5sITF9UMkX
 1a6cwrW/wF9vLetd8HlCPVNxRnoX/EqoRsFrGQ+tbmdToI4iBBcRazkBwkZMbll11iKg
 r3UcL5xsoDoSgoFajWsxm4hi4/gud7TbV7A9Bp2QGpfI/0tZ1ULERIYSu0lAmWXD6GVO
 RlyY8vRCyGjQrA7JBMI0glgVm5Rt44Hiywx71hhrFZXDpftiUe0deWJTrV9uclx/dUqu
 54sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945286; x=1794550086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PgHnwCuxZFLvVQw+sSArjczpoHdVCXQgtlkjBeHtPiQ=;
 b=AOOqGhuOkVCYGRChNau5jUu3ivoRET0Y2I/A1aLt+rmJi+sJP7ssEQKig33KBNwWiV
 XyQd4ADsF8Uezx1vT1diefOG2+kSNT0l8jhZrQPxhTnrXhoSp3PkOrr0Q/2Ox1uiGU+j
 6mXy6MSll/QsvMbWFXgk7n6TuSxmeCjh4vqqe8SPZf9/r/tPJk7WfVolWKZkaBA+D4tN
 1Mxyiv3RLSQJYYEFuLY0nZqBp2yd0JxRYcGvXCf3VCTmL5F2YmlghlIoyGNgTUTCZXJO
 HkCKO+n52E7VglVp+Kp+ODCsv/ZTG3Zn//nXxCfF5tYx9VmG4edL5PvPWuQgPb4lWoXG
 b3YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEXWfdc/YU87iPJwa/Z8u7W69r4ZX3LYh2lyNBfGoL5jaLeF4NPY0blkBnno2XHGJFNn+Agmc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8I8GBkNxJQbYxRNg+d3y14sD/TbQyy7RFjhLyn8pn/orXnpY7c
 uiyE3xUTgdSYUW1wsiunbYMqH/9pYdNBaxYdXGu6I7AWx0PMwQc3zohrVBpMStjKKMWUi7HRcaZ
 4t0ByI4D4A3kW0qIhgVKIuiJoOBbj6n67Asedif9vRUcBHePLSLJNLHd5eN2GOH+hmlGUiXg=
X-Gm-Gg: AYBFou1N1HX8tR4CC5q50ux2HiYuhEZJulOg8YtjxBtl3JeEf+UhEjQpFLXkNg3E1+j
 //7Hgk70fcMMeo0ZOfMkBGfC2iXcKmk0q78tXVMkrA8GGX/x4ZjOPlaOkIEXtWhF/urX4GYNfOP
 4TiM/EJIt5QqKKDiuNMPbL6J0sbZLUTjSOQ+GakSl6HYJ9ig8A6w0tLnKbWx2lcjqBTqDPqdvr+
 d5TngN2/42pWAesWF2Vq5BHzoNTwnCoR8h0wbcfRXnuWXyeoa2uIlf2sSvTHbRiXVZ+azvdYfRD
 y3MQPoRDNAyAde1LPTV54SAP2W4xLoeVRduqmd8apnuTCiOllZRc2vwW1Sqlv3nTz0hlA9JDlAa
 qhlvVN8G2nwfpaCHG3eYQuIhhdcBLYEBZ+x40OGCioFUsG3I/mpGNNsz3SixTemtmg6egTrpyPJ
 7MklaUhQRLaizkoDTnWhT3y4UMpqgRbQPawaDKZBV5A64QxJ3gOqOqEOSFwTUtbjpRSCl1+of3W
 ZQJ6+o=
X-Received: by 2002:a05:7023:a86:b0:1b2:557a:aa12 with SMTP id
 a92af1059eb24-1b25d315d44mr2494113c88.15.1793945285748; 
 Thu, 05 Nov 2026 22:08:05 -0800 (PST)
X-Received: by 2002:a05:7023:a86:b0:1b2:557a:aa12 with SMTP id
 a92af1059eb24-1b25d315d44mr2494060c88.15.1793945285188; 
 Thu, 05 Nov 2026 22:08:05 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2341373c88.11.2026.11.05.22.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:08:04 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 11:37:43 +0530
Subject: [PATCH v4 2/4] board: qualcomm: introduce sm8550 config
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq5210-v4-2-5af12cc2b601@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
In-Reply-To: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aed6ec6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Y0uh3DNGVa-rAVr28QMA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX25g2+zUehtNJ
 SvZZpUjyd20+sODXU66OhZ966T3KDTxQzlUpyGxpcll1Md8YdHH5Auip+0quQ2bqEay44qbFSBM
 IB3yNcZcyfNyLwd7srivXFrGUQaHup8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX5HGiGDL5WlPm
 +GS8Aq63U1bJTJ2fcTBysQQL7fYL/XHu6L1QkhZfIN/fFfjKyKAp93hzaQp+2AQZ1gKQeA1DDYq
 qWm6aBZU2QBHHSAQ2n5o6XQpTPu8ZAIcJacEzTzovxX3bNs9yVlRZQgNGsBtg0tD3C2u6mULK7K
 mKMzoob3w8CifNwat0UguC0WLmHD99cbH62kTSHBQI0LTMACvnJO2Rp7A/oBD+tUrFiKeHN2SZV
 1clXhjzBLbhXZ1yFnLBmEjHcPQEa/vnZjtKKxReJUx57FIkc8N1tMLYMSZW3sQia8UBx53R6UG2
 jfXkU1uCqcp/u1Cq2rqTa6pa2fOZESj4nsnVC8WnxcEa6lV8AgvOUfrB9SYJfgtMnSySB/TWFm0
 4vIoWVhRkytHIJfnzs8JVe+BDOOliQdpffMflzl+3sNqUoxmZCKthRnMzaS1FlBtC5KQBEZjG13
 UeeUimvGsmcSjBj54YQ==
X-Proofpoint-GUID: PPDcFR5ryMr3zaT0owNlC00acFoNZDmt
X-Proofpoint-ORIG-GUID: PPDcFR5ryMr3zaT0owNlC00acFoNZDmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
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

Add a defconfig snippet to build for sm8550 and update the documentation.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/sm8550.config |  5 +++++
 doc/board/qualcomm/board.rst | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/board/qualcomm/sm8550.config b/board/qualcomm/sm8550.config
new file mode 100644
index 00000000000..bb5d7930af2
--- /dev/null
+++ b/board/qualcomm/sm8550.config
@@ -0,0 +1,5 @@
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_BUILD_TARGET="u-boot.mbn"
diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 18119cec5b1..05d21307d05 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -90,6 +90,18 @@ This device is supported by the common qcom_defconfig
 
 The DTB is called "qcs404-evb-4000.dtb"
 
+sm8550-hdk
+^^^^^^^^^^
+These devices use the common qcom_defconfig with the sm8550.config fragment for configuration.
+
+Use the following commands::
+
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig sm8550.config
+
+The DTB is called:
+
+ - "sm8550-hdk.dtb"
+
 Building steps
 --------------
 

-- 
2.34.1

