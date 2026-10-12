Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89DECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8C966073C;
	Mon, 12 Oct 2026 05:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wti-1NSD7jO4; Mon, 12 Oct 2026 05:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0A2D606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783315;
	b=drxRYyU5Io5daq4FPWOYyWuIsACSdCT3GSwaiUgNII9tLvjOVh/qyhVJ7pbliih7a1zj
	 Lq6+4JyO3/Tbh5+FdiB/60zLP+eYU1C97xrzj/DZ/MNAGzzaAQCkjGBCY7pyrFcBf9xAq
	 7SLVqbnqNK37Fccbmt2DwArEKovKu4v7gODTh6TGRQEnLzXCPpOwUutRN9yS8phkqRbia
	 ikxNXl7vafc89RDw/PPyRrC9Dgdqefdof0OPXRf51AjY4K7cPlR0yxozc7RZ3WVZseseN
	 BewH4lMT8s5Y/AW6bONnAbzDtND+xEQQeqLawHQnSWLGDOExPWzDlIE33PfOr0UyxEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783315;
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
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=NyevoaDdpt+0uzmArMCAPfdPLtSHlUCKF84YR0UlmThOYrrOYanaD9eIJfieT7PPJHLk
	 iVjRSeA/P45B9x3hmRHBXfzM1Nuxfb65CgssAfU0OxsjmcrHWbxsfp9K74eTTjX9jKt+X
	 tRrFYpydNgq9VkSF6U781F8GN3bi7bmshzWq3eXzyg888x8xmhWKLyWuzDfWf53byEmy+
	 +rQJzQzYGVLdIDBmuh9bCrmWZtZ++5/4kleqx6jqUyH0pVeMLDBsPTiL6Z2sHkPHXqQ0U
	 nChxt6+4w9wsnNet/7yO9Tf/3QpK1PNwGWGlup8LWqPre9ypyuBPi5LKmOal4wMRlgQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783315;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVa5CW4ZqwQVFuK79VzYb1IuLdsIEJ6UcfWVj7RAa6amC8/U+Si9xBiPD0/sB70Ic
	 tn2RdnUNrFU1dDT8dhSQZRiMEUff+/G+hb5z2i4Kvy7VTE9L+TVJmGcOX5/fAiRytQ
	 uuGcSny+I4dNhb+Ray0CU6p+Jk5fZ2oESkifp++CWVwEfJN0xoqtv5jWFkIriCTPmF
	 XloSGc/LC18kPbfVzfMwCh6mAaMbGHK3QBzNbiGgQ1GIbZlceSDBX3aceFvLw9KbHf
	 da8neoex8/Cof0y5vqz8BlR3YJSsul2jcwpVksSkmm8K6aEFGQSIOaQ9Y3/xij6Pry
	 pDdmmfA011WKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0A2D606EF;
	Mon, 12 Oct 2026 05:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3453D1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25B67400A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2W5xy9GHJ-EW for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 671BE4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783304;
 b=mxMpwxqd05saV68ANc+FPZQUmmPTnFxBMz//bg7dkujQHNfOPm1hbpP8xLZHKGqdg0H4
 ODdjuhxYbtSntttf4BDyfIwrPNLb3lziuvBDPKMQ5gkDCZmTEJVO4WQEdigMHLmcBn16+
 COh74KjCd4Sf9a5DJesImQELlhTwCBJaSNa94HvmGO1Xlq9VSAa8Vw6bDA2uXgV3N6dqN
 TAZbRZRqBIN5pcM+2j6XarpWIi7PMHoJwrf5H898hjyheS6IH4amBo+YBPihDUdl2xS/+
 3cZBEima0Cv3cz6AEpuowfqOKEQcTrjHf0dl98UqVY+qjKD1nD0PXTROXbL0QdoOpyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783304;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=i9tCDIrJ8W0qS3W/V91OUEQsn2u6Zcn8fRSaViGoFfq3eEVZLlKwx/8S+pctjkMX+V1f
 7sUpzc+TdN6I1LrEJAOym1weyfy9DhRlhWvEL+p4TLFadslLkG8Y8Kjxiwt4/WvA/UOPa
 g8z8virEKQW/xPg1OkKd3HfsgyQjtpzKjdL7csdvYGHVXq55kHaLu7dO9gRbePE5+ecUA
 7+k17gcyGUHDOITYYMudqKkC1la2SO99V7GKFuiFfMdfmnJrA/uQCDQ/BP7lgZcZtuXGH
 1RmN+DKcaNA8mOheOfrEtDwrorrqYM+Kd6APFOZ+eIgnN6JprRC4ZLRXs1A4KOpr+Zg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=p15633aX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="WEau5Kf/"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=p15633aX; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WEau5Kf/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 671BE4002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5XnIM1215595
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=p15633aXm0+9WNVE51CXWXbccM9
 yCf1hUfRWSmq0q3NglXG+EAk5ASqoKgEixewJVYYD+StIhYKIYKXQFij8IjZ9XnN
 vxGRC5g88Dzhxx1pJfXno1SCIbxZ3zHXYsqByce2T3vEEmOIKAgNQ0dGdMb4UZ60
 w7Ai5PTe5xdOupKt3N91Ok95+Hd5b7jw1459ZcfMVvqxN9hQIkxmYi4dpsoRokbN
 INtgULXXmzP9DcFhgG+jjD0rBa8GOux98s3vpT13Uq6VhMWgO0QCYwcwRfS7K6c2
 qbwkROUwLv53bS5aIodko1uai8GuK7USnBma+QUnembxhEWBEc+16reGlSA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu004f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so4856295eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783302; x=1792388102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=WEau5Kf/w9C6aye6Fd/Q9jwVbSZsNHfK/RtWhhaQ+cY/yTvwTUQvqvKC+b59/KBJy4
 DxcSgiGckfq8r/bujf8xYY0WlMx+PnaadycCL2jpM+ND5mx9LTjqQ+HGeC9AfAgW6sjJ
 +L/IHeE1qG78GxWzlmWXJzSKd/2Zdov7b08TMdETgU+zw4stqZ69QvXxUYo7IuCwiy2d
 Uho4Uz7/UtoNLoglswO7qPDek/RFsOcLSnXprj32Sfg9F/f6dexaAWPMbebdNwyttheF
 aCjdxiFLb9gx5j7TxE5dgaHV+OUtHE610Zu6041eokY1NG7FnhNGaoqcUdz6KIfj6BH9
 c1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783302; x=1792388102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=xO7SLWhQFdfJvaHFOb8Lzk5kiIfMjDRQNrHyfYyl+CJBb5Bq7l/2OSchxiBjGlPddA
 UgvYKTvl63bh5M68j590cXUKx13B+kd4tOCXuW5vpjjWmGSKbswtxeMIjl/lK9AYUJ9L
 zPxbH44SpYfM5F6F1fbuno+ErlZhLpM05rO/HMeaakgz/GT8R/006S5v5dd05KdMKiRf
 lChZuXu78m3rmXbu7EZDmbvkI3qO6mH0RVKVN8QQg73kCyRXjoksIJdQZU1/PzZxvcuf
 SB3YMNLYdiR2AxZVGzV4NefoLY/269FOBsJqz4jcfYrPPGN+mXu5g2uJMrfh4znj09wl
 Qu4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwixlWANN3JcxQ0pyq6jjQmtvnYxQ7i5w1aAAMvtQl55Dy3P1MngYfthcNusS4P6ni7su0CF7c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKWLoJTybI8VxDISoe3XUS0mZgBI4PJtSgcBBMwO6bCm2S82+EC
 snhxsyr/eXKOziMGXNZZKtXMsk+E4bAagp9cFujTj5iepcYp+JXAvWQk3UwlFoqU4E91le8Zc78
 yEvJFsav9AmuTlc9dcK4lCI7Y5vy8BKlSYQmVs+v9j8Gp8eG1tPJH0sogw9KFhgTd0BtI4FU=
X-Gm-Gg: AYBFou39lhio7tl5J/ivbsjwXZRWo3NJnyRa/kY2z/YxrWZ4fUqofe0JlUwFlAVS0Bz
 iW2EzjLYz77X1Zb8eLdPJtQMjcFc10KxhH8BwAKC12RIj6ZCE5OL8xpWFTUWP/P2MpQFMtYrGsJ
 n4aclaAtMsnpIWMzSOAAAN57vPlzmS3zG2eF4Z3mJtfYeC1QjB71lfC+JWAZ5EtQbFlAESPhHOK
 ITypM5GsctxO8IIJsG2JDKkpSkaX9fwQaAbX9Dwv61Jnk6j/iuG+Gv1awuedbQpLgqnnJo9q6dZ
 PyDgo5of2ezQIY5AHu0WwLUI8Q2m1sZ4Nkt+YRNi80FDubGgNz3tskoRLpB8HwxzZtRctz47f3k
 BPOvJS4DL8MMSVGcqY0WW7CtK8eUQx/HmTn8akpQA9q0rE6Ci
X-Received: by 2002:a05:7301:78c9:b0:34e:e7f4:cc78 with SMTP id
 5a478bee46e88-3537de1cfd3mr11653035eec.5.1791783301812; 
 Sun, 11 Oct 2026 22:35:01 -0700 (PDT)
X-Received: by 2002:a05:7301:78c9:b0:34e:e7f4:cc78 with SMTP id
 5a478bee46e88-3537de1cfd3mr11653006eec.5.1791783301217; 
 Sun, 11 Oct 2026 22:35:01 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:00 -0700 (PDT)
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
Subject: [PATCH v1 04/13] clk: qcom: add configurable FSM-voted PLL helper
Date: Sun, 11 Oct 2026 22:34:43 -0700
Message-Id: <20261012053452.1567885-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acc7186 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfX+hH52RSfll/S
 tDDutfS5HbYnZB25a+ix//cB0Nnpv6PMtoMlcQGM1UEEJn2EiNAflGgaGj75XcZ1awiRVtt6fqE
 dNtHxb1aBYs7n3SPxti0V+ZhZMRdz7QIV5y8ZiTEuc4CAMUACVl25XM5CFgTPPb6+dy2lyrm6n9
 ahU9tCIzVgqDZS8nbZqRTWdbewtkDyvJBk22dinmPcvTzM6Q1t3TMmSJj3+iSIrj/l77iseIFEy
 XJ/S0HAk2O7Ir60cvc8GbpRin+Bl9MAmuxcW+GO+cf6ubilhLCD8X7CiM73CPOjBwh9MmbpY4rv
 paEBRpigJH4xZVrZ7spNTbrYbZKrNH2yQz8pHJHuUPshq+IPMjisI7LVqKOLHSYjE84ZwBbtX4R
 aB+XHMrKb2XZgi353g034o8N97Yoh21Vpd9szl5iyuUJdxbX1xp+4OYsDvoie6bvd+apGmKFT/x
 FAR/H0SNpv3crvdZuqA==
X-Proofpoint-ORIG-GUID: ZGW_aJShLsuGgMf8V4SUdk9PG3xbBVFu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfX67j6wuKJ378R
 po1mq7QZs1NqMAduWiFHawvd5YT7yonnXYTv8BNHcWMSYFmyCAvfkX92X6XxUtzVWKDfDoUsZaF
 TtrvV0Uhjr+qlvXy97MXWeEuoZIKJG0=
X-Proofpoint-GUID: ZGW_aJShLsuGgMf8V4SUdk9PG3xbBVFu
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

