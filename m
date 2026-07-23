Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA28C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 917766071A;
	Thu, 23 Jul 2026 08:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXMjof11QNGA; Thu, 23 Jul 2026 08:35:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C01FA606A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784795724;
	bh=+xUNXM6cXfSmBRRQGrB23GacbcDxA+qY5ilRqAedrdk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Sibyo8FsBWzwsHPRHFqSYptASCj5VNo2Cc/ZOdglMDXgDWlY4ZiFMo1t3FqgiVi6i
	 UxgQwQZ+Tq9qLk5jZpjOM9GPwhJrZJF+4x4h/sSEAJ6f/H1Jl8VSY90twr6vLI59q0
	 bpT9plSpJMgkdkJsZmViro8Z8IeumxO6c1NH5PGZ1dGjFpY3dml5VpqIdoAvMTGsH7
	 f5TH/EYCFyTvhSiIH1eDOw91usiXwjvuBdMaYzvy5qcmO41FY2/1aQLWel4zWe4vaj
	 cGIXxkW6YToACVwCrlIScX5qzSFSi3l9VHHzrYyRcoxa+kBeR+XoRsKJK8fM9ZWE4E
	 pLjrzXB3fnbSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C01FA606A6;
	Thu, 23 Jul 2026 08:35:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3362A786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 194616069A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0VX0GVZsaOg for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:35:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 493A760681
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 493A760681
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 493A760681
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7Bamd3372249
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:21 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qgbfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so510274a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795720; x=1785400520;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+xUNXM6cXfSmBRRQGrB23GacbcDxA+qY5ilRqAedrdk=;
 b=lGTDKzNLqJPmID+H4i8uyqVDS8xhtZACg+oqr33gjnXtm1hET1NCIgqIA06KkSuhJv
 sWDwZdcPgCXkbHxchS933R6G5VSxash/HN/2zLdDwGtTFT3b3tzCJ4JNNLnjkGNG87d9
 zPSBWW+Ml9U688e13Jz5XJm5SYOynV7G3j5cS9Runbi0DMCmnAkPqINSztSaTSXK/v3r
 PiTJlIwwnFGe/PzLr19cXP9nUKPa/4Y9q6sMhZ6KjLnB1vfDpztLbRQsvqZMeX9XhE3q
 B/t7+ndlnMKscjTVMNeEf1czab+AR50EkRk+rzLjoRF7D1s4Pr5Ms6TCuv65v1/nXp3H
 6yLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCPedBdJMTefwOLpOi7ffG8H3GuJibh5zWIwPx7paYwrJiY20ayn4Ml9cGUPX4slL+V/MCIB4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzYIYKtE9U/9YO0zOZvAkGdoiUhzfuYaUeFXW3V20BNulHWLyjG
 GyfsyavTiejBPbraGHZvUR8A6d+FvhQlrLKJk+puxqil4VrCetcL/LuQWIGh4ZVmmw0wFIWMiQF
 2hahZGCQo0PCAFNOhONXhKlLOQcVOb/lTL0P1xHRJMyBy6NzA66Z/yEMLodTtL9mMmsfSOkU=
X-Gm-Gg: AR+sD11dT6/AR44hXGiLk7ghnagjSLlLgov9W9Dc/Vcs8j9RTOx6iXsanOSs6DMf+R3
 eUkg5PztP2HEkxGsxaJOeX9erP6ps78dNLpovNSrYcu+9JAOLgHE9+MSrPpLQMALxknwlF25FDg
 gk0E9NUq/JAy2uU9A114hmnxrBql2YF8uzRNAheIXt0uxm1wIcv7sV1gDk2FTsoVlHtJ+bKtcv1
 7g4PTDCUcVNixGRAUWGtSSnFElSJ2B5U110ERfOWC7bb9qiXavYJ1ZA1CFie1sqFFRot/9OjpcA
 +wRS8kJTzhTU62CujGY7mH0uv894BbeGluqt8YLVmYohBTHhUkWkndKZv5ynYbFRw17Bl8p/vf9
 9Fakr0uTqS0N/uTWtwxy/A2pZhTV+wWV5mGUv6YIwh/DM2Q9f+xwQZkPoAq8l3xy0VJOXqWTfX/
 YdAmoqw0z5HG6Hx/U6XGJoTOPBw4D5KQ==
X-Received: by 2002:a17:90b:5650:b0:38e:cb1:8ec9 with SMTP id
 98e67ed59e1d1-38ec661b520mr2129391a91.42.1784795720098; 
 Thu, 23 Jul 2026 01:35:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5650:b0:38e:cb1:8ec9 with SMTP id
 98e67ed59e1d1-38ec661b520mr2129355a91.42.1784795719640; 
 Thu, 23 Jul 2026 01:35:19 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm22805401c88.2.2026.07.23.01.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:35:19 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:05:12 +0530
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] clk: qcom: sa8775p: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
Message-ID: <amHSQIp9C5sxGxpW@hu-varada-blr.qualcomm.com>
References: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
 <20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX/bV6EklgErE5
 r1DmP+b3g7T/FJYQR2lIulzzWiDBUtuQgMLBzuTO3rwqN1FqdXCE3+GJtjUlU11zGwbenXrXc/Z
 3yFv3cGBinIgnBRdfx87L6M6nMZhy4c=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a61d249 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kK-LisVwv4V8z5IJHdIA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: LgoNUbZ-Elm3l_uNZUyv9Lq9NYxnNtIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX6C/vNzh+C2jO
 dmumq2h2mjka49/0iQggfPc+YfwkkhnyaPGRt6zvd1lIcZSu6bgL1E7nKEEUQUwzT5HYYcVG/ZC
 1OctCDL+/Z1Acrv81u5q2LvTmk08y0WaxzpnwGmupDrdnjGFO2fSyzIeBHHi50/cFmKko1d79sP
 fVEchze4ZXzZ9xEc8bbBT2x1WA9WRlKDTTnpYXY8dpJSn7hJEYgKuadqPd6GjPlR85xVqSEuIBu
 dGnMoVHi6rmC1OTuJf8dRsa+eDP89eRlM+BgQiBlAU0H6WPUSSaItTg1L2P+t6LnW4ZaQ+thLXK
 MbmqGP58p2H7MCUbtGKYz4WRN/tzRsevDrVQuJ2Wqy6cC2xC43lN1yx2xnOG2Aw4/u63j1t+YiC
 vCwlxxnJdGU0xAoVq44O9BmZ/APftoeLL3MHgYH/QEQ7P1/DISrmWmFwD+9NXl7WblRxD+/uejH
 uYkDzJwc7eia3mlM9Rg==
X-Proofpoint-ORIG-GUID: LgoNUbZ-Elm3l_uNZUyv9Lq9NYxnNtIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230085
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+xUNXM6cXfSmBRRQGrB23Gac
 bcDxA+qY5ilRqAedrdk=; b=L3j07mprME1mofHY2skg7Z9pIGaMyFmj4RZxBOsT
 UWZd0HUef9pDe2xrXeStBzKW0wu7Bbe33engID5lA6U7DVjtZDvnP8PgFz4FjMTB
 L9x2OThLXlOvrdOjeQXrgODbzZ2KUNZ74xhp3pwOmsyrddoLnGtQTojVyXvMY3QN
 hpheDaijS3hjhjlkkQU5fjb9V2rLYNbQL67/8xF31GVDWmqAcqrYGF1ydTvUz3lV
 xf2yb1cRtFnwz3WAmumsKqGfdAWwBIOkaJmb0zjLM3XE+6gRl/tf6Ln45Ze9p7YD
 GYHtSbs61dQkRHzTgXoxF4xbJJvi18lff07mqp3cf6yYlA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795720; x=1785400520;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+xUNXM6cXfSmBRRQGrB23GacbcDxA+qY5ilRqAedrdk=;
 b=AxwfPmb42QgLPzUPReckCH3/QFVVLdkdXcXdZXKfcsv6GhguCuRDP1mTLk8iXtccyU
 6v+qw/y9LYkMTCobqTgrwQWRdO9ZHM+kJSshaMQlebah5rhjHls6rG/Lxfw44VuyI27g
 gZkJ6s7XnZ2YheWBnotkxvWPbBepNHrjcA3tCvvFsNQhYg5O8JUjUJMATnuRuG0TpLd1
 zAD9Ji1tudpHkv+DxkWiaRfLDtYMtpcFt0mYvvNdARcj0FdV9er594Mp6cX2tg2xXEdv
 Evrn0tKQsWDJHmkdDz+mkaqr3fvyHWOeUmcX56j9xfdebhY9VYFxDy1l+UOQzrgIpA3t
 OpdA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=L3j07mpr; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AxwfPmb4
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 12:09:46PM +0530, Balaji Selvanathan via U-Boot wrote:
> Convert the USB3 and UFS PHY reference clocks in the sa8775p gate
> clock table from GATE_CLK() to GATE_CLK_POLLED(), so their enable
> status is polled against the per-clock CBCR register instead of
> assuming the enable write completed immediately.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

