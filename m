Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D9CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8642A60626;
	Mon, 12 Oct 2026 05:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_eAnVE_28i1; Mon, 12 Oct 2026 05:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32A66606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783308;
	b=RcvLvDB7zb3bYtYGnI6Jz3OlOfkKr5oX8hrW1oculZx0+nZ1YcT6oy5gZ6Ve6dN1XWGf
	 pyjJUwRK6bYCm0tKUgMu5yz7i1QrPV5wspualZdJO9HrfikRrNM7BiJiJpWrAF1189Luz
	 WAT77RmArFByNTjkYovN6gl5JibUcLecOgLrLmW5u4UCEigBYhzNTuevmGdBd/4HN7T4W
	 nc4/ieU8+9e6ZCwCSRASPpxB2rYSWQi/GWTbvbPXkyuwWWZR0E2JZLqJvawzpMrxqfIPm
	 +iX0yTNaAFOGzJYhQLW4P8GlDNGAqVLf4s2nx+RHcTzTpKJm0w9kN2htvzXQroAQ6kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	b=IVebNiimssMgfyfQhS+emNmBwPqwDpr9DXgtppEDth89Jl893X3nn5nOk++9zdoRKRUi
	 WFHJ87rbXT++5E3sseIPH2g3PMIGPBkchNygPlRv0VF7t98QtJiNrjtGrwCj3SQnU4ch8
	 QBSVGP5GOJeVFfwbJFt80MLiTytoDArxhCrEb488EfnAKqDAfeiIm4rGQS0cXqtMtx/G+
	 Q6RC3axDomZ412IQdkKm1HW30hihqJ98pJIPMkQ1WUeFqViL7FX+ovitD0AQhY1MzUq1t
	 wk6kJqUvSGpZpwIDYPXx5T8PrckpbyRksXulfzD/T7wSwa8ifQQeLJn5OnZsHb63Eyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783308;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6a3P+cLUpQ6H/qLljls/tX0RmPCwEuS5YiH5u8UpJEn3IqL+Ph+MOTjE5wgJNzAp
	 YI5oMuKUzOx9CEDxhm4+6fSVlsLInWS1v1/U0awQ5631pNP6SKlsZTucZTOoCuYxXl
	 Sq1+Y+klgDNJRvQoRklLlrOYYkS0QQ2gwVkiethvj+SpDRrAU0r5cBV/CF1+gSloie
	 SiKHxn+cUt+2InzYiNySx+UgC5vWr50r6oxACKZmD4AXJ3RI3/GYGp688UaDXMB7Kg
	 EyFn7fn5MC4bIaexMJW2BYCHYtU6UnsbrMAWRk6vCcL9tYLQwksfG6157pFyZli5r7
	 yEUoM2D5svkNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32A66606CE;
	Mon, 12 Oct 2026 05:35:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 383061DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35D26405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2p_Uu5iQN99 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DB20405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783303;
 b=WzxPjQ0Xno3pme3hAwmsxiTj/v57cR6br2k5Jly4HTEH9GIpQi4LB8jV3FqEoOlLSr0E
 adEkJGVYRu4NPxrYUcPQDgxAG48o8Zikhb0DDw3PKmxocMsrDxMVRCmYndrVeFlLVBMSm
 ze/jRRIdhv7nplLivKnvhwo4YNFz9msdx2Loc9zCZX4dTywuxtikvQSvcLzIOMYIbbeDy
 bsxtYz/KF47NHLawcpZxY8uvud1OzM81mHruD6z0ilim1MvIXjkmBt7N6dvXCmg/GRBga
 c0f8g+asY6eQNqDOrtytCak9xGA6iJrN5DKLRV+rz86uEhAAA3qYzs355D3q1Kr882Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783303;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=a4pPJiM9fG5mC3wKuWcrpUkzbCkYpXXGCFWEerRrsuNlUC4FM3s4yiuYUVK5a+RrILNg
 fdXR+aqdUYD7iY+Ut2BlRMzkLhfK94zfBx7wMqo29pLCOgxUUwL2jNHlt26p7GRobdegM
 DMSC4CEk21GlLxrqp6QX5hMb20AuLCqAS7EUvAE2B6haLmxskeGfhnLESRv4FvXI4Jz5W
 ofxdz/fl1/pQ4qbHf8SzVsuG4H4fHGYS1seLmS1chlvkiZx1BFtQmlZkj2gqsuxG6mmzc
 L3DpR0C3vsLcRYMNaZIT6XIDPkCXvWTjHP0hf9dksrBTQDkPW4YlJwQ8y4R2tPaMIrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oBZm9NGe; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iLoWtan6; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oBZm9NGe; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iLoWtan6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DB20405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5YELZ1216140
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dw0YQ9AdyH0
 093F4CAXrS1D6HzWf0L9XIPmFuwc7410=; b=oBZm9NGeCSWJyz/9/R3xcd0kSJw
 zfKNOdpnbC9ePM8ylUMG7PUmkeXzpY8JZThCMWt1VZpx6CavljX/cNbT4vEYVBhO
 DP+o6Q4aJQ6OdNUllWVQ//lZJ9DcvnH03EJC7EZTUGUXh4KHfr3ciXAqpSN1V+dz
 +GwHKV+/PiPE3pGuGd3kqXUXEH2lNXUKMza7YrXbeWo/AUC0c+n1T5Yk6dHE1sQm
 kWd61KtkpXIvRlLtwk7eeZtuoMjWiBm4HHvi5VSY5Z8MNvHHie8PMOV8d+0TMWiC
 QliyhX+Ql3iJbY3BvhZdk3R4Hnv4Koqg1JaE7X1NnQw+RRjKzpyP7rqI2Bw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu0045-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a04491c56so757863eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783300; x=1792388100;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=iLoWtan6R2pndVTWs6btK1HdNRJaCJQY2eghHFQmVB1O2e/gjsPQ0ZA7i2iq+iYqSf
 4WV3WfPamgttepJf4viDe5FfdW5t2kEmOsfpuT36J/2jbEP0hMsvp3NSq69HOdOejhZS
 oko410bYlK4UvkWzouUwL+RjEABEW3GhrzO+7+yCaqMFnkirB9wSUwLOrHnfvHzb1NcI
 36+dZcWWPKTKE9fxPV1PQj6HvzMsNMT0V149YpkAhcDThqo1aJjCB798YNEfiD3DWb5f
 QuyUx8AGSzGkST93P1IGih9SH7XHpvT59ArPpZ0UlRK2xiGtvh7HKw7fk578xdtiktRA
 jTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783300; x=1792388100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=0PTkq4XE8hPL4mqcM5x8jvBNp9Xd2V1jLWSSzQ9v14i1rIAW0y3KWXvl/HYwDGltDk
 Si1LnGflUAft6XPoP/cqeqv82ZVqKANkyF+VJv02vE5q/S4iNftcsUWHSqYuwS+mGIMP
 LXwnsG93y2ahBfmUQ7O8hyP85ef5pwcQZG0KNtaJomYnOhm6+HGwVfvOkoduVSwv/1PS
 GqYj5BIfvW24xRWvVrEm6NVMcxeuwcFtFRwY0bLPprbL3nE+YTXE+824f5WMIO7d++ku
 ptxH3GfK+bvNgDw3SMT13L/rouIhhzDmjieg+/O/ZL9f9jjWjDJywhthqX7YhwFE5KMF
 24RA==
X-Forwarded-Encrypted: i=1;
 AKwUvByyC30Y1CBoJQjPuP/JD51+pLWNrP2pnquVQYqItGJ2JwRVgqYTTaof4ZX2rqkuqYgLj6U3jA8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXonSD+xBL9Jr/A2MgxynQNEoY5td+wLN8/JG7sHJCEd7vGibQ
 Z8hgXMfIKQLYCExrPZs36iqLuFcQDKuGAl7R671r2VF5zAa6x2bAckW//FA1XOdjkI9cZxcUTSD
 U/K071gaSdJoQWNE1FAL9tmdDhNxWHXfj2lRMIOlDtvy8sf8U28Ud1bzZwlipRhqZ7IYCW1E=
X-Gm-Gg: AYBFou1dzijX1I9bCd+XZ+tcawsDMlQYlzoXouRstUpRBSTp9kCKTDuSFOszxSXZl3D
 SJCpYpsLkZjONS4uenWgK3vj4/2f7fqRQvgpROqEyxbYQFmpvdRaVc+crwSiDX4sioenBQ+vEIM
 f0vRssykRSoVOUUbrUIZ/aAp+lrb71mArh+teSgDeyetRFV9boqTXEbJk6XsAWjCQUABBtHA9gq
 miwvhXHtW5L7LsEFUW7+ZwdPVOkWh2JccSNz9oOoI7F3v6i1x6jaUye4gPdsVJzNL286fFCgo4Y
 TD8kbVvb2FmUYHw4CSJhXYwIeNrDeffIS4wCbCQDDo5wxMivZ+zlqCutuOxtJjQu52Yr7Nm29q5
 o9UecgB+Z2PPSgoIqZ8elHhm6WMqV7ozUzWKTBJmkznwsUd56
X-Received: by 2002:a05:7300:d10e:b0:35b:6d90:fdf0 with SMTP id
 5a478bee46e88-35b6d90ffa0mr334682eec.6.1791783299959; 
 Sun, 11 Oct 2026 22:34:59 -0700 (PDT)
X-Received: by 2002:a05:7300:d10e:b0:35b:6d90:fdf0 with SMTP id
 5a478bee46e88-35b6d90ffa0mr334640eec.6.1791783299357; 
 Sun, 11 Oct 2026 22:34:59 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:34:58 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 02/13] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Sun, 11 Oct 2026 22:34:41 -0700
Message-Id: <20261012053452.1567885-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acc7184 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=6lju1O6RD8AOoBC9Ya0A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfX4RYjuzguhyoE
 wqpeLRFdKEBsptaNQYfbdpmrm8l+dk/5t7jSGYu2yEkqvt8kxi4GVMlTKDADlFltI9qGvRtwJLQ
 SVBWatS8xNp3Wv0S8xGNjDS26P08sFm9hCP5sMdEV5q7LsyPkYjJ5Pj8fhMiUpU8+rzYCSATbhk
 8cFuQbLOvKTb2d/jSFutUCl4kg4f9NhN2+qWMoe/Dwyxu4fV8kax4FXyR9OiGAF8DPaFrZSxu/2
 ZoBnU8CLSX+91EQPo/mmUkWokkO0knh29Wbot/yWvWLzHeZjdZmz3RUkweQ5MhPQ0hUrwdplyhG
 1X0wDxWyW5vR0YUJHZvntMAC+dfhS70QVPk8rb91Ssp17Yt4O7NidDD7uUkePs9gpDtwUl+T0G1
 eC7oDqNM5dT/edRZisy082BuXL9YojvNfmgLhxKkWjVWcT6WNDFdfqOQAV2iSlskh9HVqfOsLbL
 mgBSlBWTQXizT/3h6GA==
X-Proofpoint-ORIG-GUID: 7I1aIGzmaD2SRO8kg607s5LZY65Tzx6f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfXzopdl8jpLl4s
 0TuE0RvT/+i0+04Ts+wh6MzKQv8ufNb6n/7U71d/4ECyhTNgcrM3V42rdLau7qWlr+JNd6Fzi8l
 bfRBrMLt7D/kDDPWXIkXh8qcpy5rlyU=
X-Proofpoint-GUID: 7I1aIGzmaD2SRO8kg607s5LZY65Tzx6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120021
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
 drivers/pinctrl/qcom/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index bb12e93853d..ac0103631ad 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -116,6 +116,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
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
-- 
2.34.1

