Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34420C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 055E260DBF;
	Fri, 25 Sep 2026 14:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3SZBk4aHeDP1; Fri, 25 Sep 2026 14:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 168EC60DA3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346414;
	b=U/vMR5uI3k/H/uC3tTJgE3F3FnJ/mCgmWO/cuG/BdPKWvsKERR10eR6vCliGRgFiqd/P
	 pbE5zgzge/UlG9smlJdHWEU7CY4xmrnOuAFng+7OgJxbLv6i24iKllBOygygvPo5JQ3E0
	 op/wEYPTRHnmCHsrmBwtgi+0/vzbGjfeF3Ud7YwfRnw096guzWgjX/7wESlbnsJtZNhfd
	 LMs4qRJR+RHCKTOrwVVXcJuoNmDmI7YlqpLQJDA/wqp8WSHQw/qjwp642wWuhp6SgZxR2
	 beSfj3wR+cxtwzze8P9E+3yc3WmrOK5iYOGuFmsPtpxteDDJRfueCgY5VlrhUZ6u5mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
	b=fhFqAACYA94wU8riNFKXkn6an4IaEmo0kLwLKxtr9na9sSww75+8GTADTHtNCIBOcz/9
	 0eNX0EWcIe29UNmZ9TL2elJTcLg6K5WfyLKkOuuVyrj0/3ynLgj9RNt3Kh0Lfj9NCNA7n
	 5sKEqDzlS+alW8CY7if9xTU4zTMtryZCtcMniLasN7pFep6lst+r4pdbCvy+ivNrR4D32
	 OgosyYoJRFtxYRJMqxg7daOYbfu32cM65zV5iCOvJNdcpxjeH+3Sswch1qAv7hAm4i/yC
	 mFCy6eJ7a+/zNILa4YCHYyxBIQUDlkcGQ8hYc+c4yocbNZSGfIaBTNUXrM3OXq+fjgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346414;
	bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keVRtiBdE2covJzFAyp3Ti3Yb2ImZsOhD4hEkzNIEfYLYzJMqXgyGInfTAQI6nrQZ
	 6cv/vF4ulWif0nIhSzmIxy3II668MDGb4GFY8LLijk/ZvnUl4QMOXKx3sCp7DdFew3
	 dcu2XhXOg56sgzUiL3jmGCSOy0glu1m36MOGfW48bmfSxkfjnWz95Z8txeATMS823X
	 U4QoHYKpASLKcrhhBBzJG5dvehNRfwsLzl41vmXTagVzydKEGvH4kv60WGmeU3fRWZ
	 fau3TIBk5AC2VB3zuWJP81/8sWVSV/PUKh6wyVzvQIppmcGb2L8SKY8m6a15ZMdX+7
	 OVCwJRvBRvM3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 168EC60DA3;
	Fri, 25 Sep 2026 14:26:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78A5735A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A3F581294
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McO5Mj7lQLdb for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BC30781202
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343503;
 b=l5smqPWF7CiyyjYlxQ8ugUpo7f9jZfMTwA1dxo3flFmkrODa1afzbULwx6NVrImxv9gx
 +XAdcPznLqp7hTR4hyllHW7nJVXpoRhnGbjBNjx+vx5tCNg8vRCgPgAig2dd+ZtQgFnuP
 yZsG9XaRY+hf7SXZWSA0UWb3Dj7jV0rqu7yVLZ1K9UaaCP0mhmmX9yoUCom5E+b5Xt19o
 xBR1T5ctYxqOqtrJ4kVVm6vzhV4/OfSsAYCbHU6UpE8V7PErXygg+5KhHGLWXzifZYtGU
 A7VzlOzkO3/8EBLFM7k+0Yibedy4bhsdLpESKnAgUFpwABNdvLj0HJB6xBMx8IZfj0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343503;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=NmDhytwjJsnLDwUwh6Zu1Tm8B+kILiGCGuWGAu/HJR2GGHZ5fYiF9AioLqyfhhnMlhZl
 YvSGm0JxAz89XAhPp7OsXOeeJjN5dtypT3dPCaTpcq8WzrYUsK8O9UGYgaahZdqWoH90N
 /zU9eTZ72zCbmddWWxcUppbK5g+BQuFh5+yD78DN8mYbG+71CUiDVuwezH1V7ZJZ9sWZP
 3FHBf4Mr9RBy1g9UT0HJA+wR73iZb3L6bxo82JXyp4ZaRIrhDXsxRB/2Pvsxr0k7b6L5v
 y7rImyVx9RGWbPBANQ1sdCzOU0v8k5Xh9Y8QhEcdmAjuLFtFITHFGBFK+AXufW+7qLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=db4dPtUf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XA9q1nQP; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=db4dPtUf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XA9q1nQP
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC30781202
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDGHAo2911727
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7b8tiny3sVC
 BL0ytncknXXZTGIx3H4GG7lffy1M6NUY=; b=db4dPtUfOwGKFpBlM+tEBz1TMVC
 E9oi3cPPEEhRw+DHNcn100my8ALjVKwIQ+hPaYbHghU9MQFw4RJCxV4Vb4T+iMgZ
 bK2KFMbJc2ZANH9MODFwJnecU3J4nci3RvIFiNKyYrgha7PlXMxyukORkbNgkAZ2
 v9Yx54w4POeGpEyrcIAB0sm7Ymizg8I77Y4LaIJsY8lhIHFykWogkILUVA8J8dDr
 ZkP9y4Z9nrdC1LiYINQXuaUBzGm8n9wwZwvl8DDyXvlBDV3ntmUOF3i+DhIS1Z7E
 O9yriqyz2xSUStSpAwe4pTeWIv3KK/6QlfYACDSCwB/97wXXaAA/f+0biUg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm51q88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1422619eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343502; x=1790948302;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=XA9q1nQPHMmFWQ5IVao9STGC8bF+4vn9+0YbIPh6Mzi8BVCbOd0vJ0i5MPZW3J3/gD
 dY+CyhLdIig5HPlpo8lHiuJwySH19/nQFYO3Da8mMwpDuBitBLctqYgeGFV+vGYtZMGD
 lqJgqe9OG5JCyC2xkW5YIunjAXPDgmL+h68bcGNelEdgmDytYW8Phs0DIppPzUgwz9VM
 ABGos167wdH84UJsjSUc3+06ptiIjSX8+6fbCMA/jHg2/NlDP16wZ5QwRI7N5SbYLpKB
 3Eo2kSIIUCB5eZyPv6d/IJ5mIAFa3SIU/KjHIftXuzx+A2ldxkmk9x7QervlIyYphjv3
 ahFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343502; x=1790948302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=Cr+aRil0q8VSBQi3ygChQumQi/5wqleBD7xxEGExqcHxYr7aNaG3VlpeSfrj4C6eID
 EtdVaHyJr0D9YkZM4fK0InDecSDKfx3mKcnRfDB8NYFooTq2vvZnhB332YrH+P+Uyz40
 64kufU3rXz1sLKNy8Ow3V60zSBwp97oBuYJy7tWOlvmZ1qBUYhD/bw9ZrZL39mk8dcyS
 Uv1hj1inrlHCmWyvvVouqxUUIwvKmHsd5+k1/AVEjSdW93b4XZLGnoW0TfUZa6tuedsK
 mJK+gGoMzTHJ4ueI+WeMrBk2UPrZqa8PFMKYggqd3Db7Z9nKRR/I3W6FyXYm1NyP/RJU
 NK8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNk9Op1dKzSdjUrlaP5aQJTfOOupIDqMNBs1WzhsXfqPkig+tqCLHGR8GshA7SvsMp9fJzijQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++moxyG5mlTtijy3Hwiay81vGl8fRZj5lc8vl0qzDbglyLwcaMKF
 isanWhb3ItTajBQ9bdWa9QKepKGDvzEI+KokcXP/MTJ9RK3PioOtEK0gm59z7oWMundcikseY8y
 CZr4JqGUVzYHNmXlVRX1kvU1uzK23SZmJDftSFuZXGbq5fFatKO4h6DkeTPDRcYgoEd1eL/c=
X-Gm-Gg: AYBFou2Y1Jzm0tcCyMDfWd8A03u8q70XbjlnpW1sJsbgR9h8EHSFmOZ9DSP+H56/haR
 5MZlPTpbrQz6VkJ3a4Mt1EMPEt6kZytVzyLYPUk4e1d6TGYDD+9xamm0/Wuqd+tA7lSS/TY3Qb3
 Tgli495SFJCoAUUBRNWk9n6y2J2pPO/7Yx9lAANBu97R/d2arj2+q+1AMBEXFhPxrXWf8Nfk4CK
 LOKrkoBtZnLdr8MzdCCBEQP0WQ8ZNnkx4s6yzlSXyLOSSdyDOvmR6RqRzRi+3l0bItdMjPWWQ1v
 iAgKs+ooTE3Z+3qoHs4SlkOqyAWVJy6ddJRV+PxmnbYtjM7L2jJBIa/ixcTMmnXYIbQ0dEtx7JE
 5MqyOfIQya173KSbDybf79Chf11anvTQre0CjL//XoTJMppQ=
X-Received: by 2002:a05:701b:450f:20b0:144:c11b:6de7 with SMTP id
 a92af1059eb24-146d00bb340mr202101c88.28.1790343500761; 
 Fri, 25 Sep 2026 06:38:20 -0700 (PDT)
X-Received: by 2002:a05:701b:450f:20b0:144:c11b:6de7 with SMTP id
 a92af1059eb24-146d00bb340mr202070c88.28.1790343499888; 
 Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 11/12] configs: qcom: add Shikra SPL defconfig
Date: Fri, 25 Sep 2026 06:38:05 -0700
Message-Id: <20260925133806.1403713-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6tVSIThP-OWAwLpt8EUPxUdaFXj7TsXN
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab6794e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX7IKU+bNz9bgb
 a50kQHLG7sbOddbLOahg2R2NZRKUnHCH8R9MGf/26vL7iUQvOowZRRbuJOZQK3Rily72DgcnsGZ
 UbOt7nKwAEQkXAo+UyMCU1Y21yf1zhrg8vqY6ub+eFmROoapYJXWQnXRsdICm7VYXHESU7NDl9W
 eH8Zfjlo2jzNcrvspfQ3yidoqGJoUsMNh5bIZYvKpJPL4Vcb4CPC5C+TcE1ArPDasArRJdj6hy+
 KN3Sqe3k7cKyWNmlBd+vmDBH1zucDFr8apVUHsAuGCzy20c9K/4Xwurh9BqTDFzZwf15WpGUvgb
 xKXHA/6na7qOCDD1o23Uf+SZeFUTju6zGUEo5n5mtf1dyYNx+2rJUo9K6JVMoDhtdl3+jqaobET
 CFXpQktpEdOEPAz7kiZ86tDaISc0D7i2/qNAR1uYRcwdkcX2hjlF8ndeUCe9rqKlBLVOWOJLXIN
 iL1XzmJYmYQaSb8Aj1A==
X-Proofpoint-ORIG-GUID: 6tVSIThP-OWAwLpt8EUPxUdaFXj7TsXN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX0Sc5+poQXVUz
 3Se0Fgkz+94j4hYqciEJaUvTgNtDIc6ZuNc4P7MGC2lyAB0essXRhLkIfAg6GGGheoImFq/6tKe
 nn/ik+VrHTdU7ib/FEpZ0AnUFHSBX1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
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

Add the Shikra SPL defconfig with the early serial, eMMC,
pinctrl, SMEM, QCLIB, FIT-loading, and memory-layout options
required for the SPL boot flow.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 configs/qcom_shikra_spl_defconfig | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 configs/qcom_shikra_spl_defconfig

diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
new file mode 100644
index 00000000000..7bcb3e21a15
--- /dev/null
+++ b/configs/qcom_shikra_spl_defconfig
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_DEFAULT_DEVICE_TREE="shikra-cqs-evk"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_SHIKRA=y
+CONFIG_MSM_GPIO=y
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM=y
+CONFIG_PINCTRL_QCOM_SHIKRA=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_GENERIC=y
+CONFIG_SPL_PINCTRL_QCOM=y
+CONFIG_SPL_PINCTRL_QCOM_SHIKRA=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x48000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x0C219000
+CONFIG_SPL_MAX_SIZE=0x7B800
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0C2C1800
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x0C294800
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
+CONFIG_SYS_BOARD="shikra"
-- 
2.34.1

