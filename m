Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A35CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB5BC4092A;
	Fri,  9 Oct 2026 01:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkWAN5OiHV4S; Fri,  9 Oct 2026 01:48:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9D8540887
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791510511;
	b=HBJZhR0SDSThLmDCxifPoSBc75kQrOb2vCT1/guYEzCM/hXUHGo38ZackFRKBV6bTwYD
	 HyGheg6HTnAClvvjnU3ZdLZA1+sbenYGf33sk2TLQdUarVESqMGPh0ia7DDHBiSy5Jy19
	 UEMMY8u7oM+IEP9yoQuwiIWBtIK9VVLY0h3XSfus5g9p4actuNsJelJm8iFULf0yH+v11
	 OdG/LIo9Lfg8f4teGAAqRe2CBK4Ds/2SCvQS6cgJ/PVQuJuo7+TjTxzhAp74KqctovR8i
	 i1mEsXSMb6l3HIeek//feJVsybVKAla1DFRH0Pv1o0D/R+xgqZHWzrnzRQSxKfrRDgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791510511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pCBwvpkhfR2X8OGLdL0QoSjBDCgUeREBars5ihZR1As=;
	b=JXtpLOJOhu+AIAebr9A2Bh4Z86rqbWXAR/5U4mI6NPuS/3ak0Qo50gv7m8HXAtJu6zJX
	 brNzCEwJZPYRPG4zXcOOB0RRM0RV+PYVudSo3YtaWtFy94S6fBk3sdP+gMpPG9proxC7c
	 Y015YuYyZaeQoB4UMrD8Qb6uBZncgMMfK7lp8NJ92QJoZfS9wMjNymMo4YpWNHUnr6RNO
	 yKG5O2sBc5LoaNn3IgXtZYE4ZseQnIZTIu7zNT9gKGQEUDpTdlkIoCq8IME5WNCe/O/+2
	 m7ll9WVbhOitfAFS3sOwPn/sEBSdgsiNlJLcM/pp67q0ZpN929RgKUXvs8pSvqXD9rA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791510511;
	bh=pCBwvpkhfR2X8OGLdL0QoSjBDCgUeREBars5ihZR1As=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vp88SDw48B8SHxuRlczZNuuwVfz6TS9hCD9gnuryoR1Redt6V5JHBHVZhUIjBEJlQ
	 q5uTD4iwRQmnGNCfuMtRTW7uekeX0RHR8c+/8LilQkEnkTmWldH2HEUZo77OGwWltm
	 WQsgpifBn9NBB7KTqlaQTrSrtMK1yX8Ogk2Mt7+leZlTGoSPI0/fXuMhB9C5Mmpkme
	 BsHTUCyUKM/SsIP9/UOqItuSXfBz4oonybKzrc0XKHsu9XnV/a2tHyb684k8PUOo6B
	 Zpxki+h+3GU8TSgQNDv0qMlqViLo3xJV6x/W+/4XQGhPaBgrAMukw5NizXhrXcgT0r
	 ZIDBdC4onSlGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9D8540887;
	Fri,  9 Oct 2026 01:48:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBAC81A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCF166069C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yL1Pt68Om2eU for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A1D460601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791510509;
 b=nHYKICIrs1SdKlV+KiCFuua+sB6wo2cyKAnoLZGYV8AcjZwJHEDypKw2poBDBSA/yUJX
 aJBSp4Kj/3q0y1wqGytkPCyGkoKqDzCme4QErPD613iHnSX3oQAJ9wjhe4RgLNSP4WmUa
 Nh0a18tnQpXIpfD7DFJzFWPSPTqaKkgrFW8BxmBC2Hh5wJdW0CS/CGNbX/jJHg2Qh7ok0
 0+KqFmdmo5UZ3CYRoGnua1u355O4EQg5tCDTtj1vcbXrHAfnUeCoZBJ/wjwuP6lgMe/qj
 1hmssrhwUnkiNivL5kgMTfpSivP8Eh0gzpDOL9NTBVCXSY3GMa402pwoYd0yHuAjvSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791510509;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=pCBwvpkhfR2X8OGLdL0QoSjBDCgUeREBars5ihZR1As=;
 b=JecxiATRVGamX5tYce8zqHiQBgqN7X1FstW6TfbR2NUJcsN4UWbrlOJAmIG2LMPD9KQs
 xggNjzCvCf+2HkoLxKn7mwf2Wc9gWFep0SrboFkNYQ5ZJkd/sXnoh4LLmFaBRgca3ULQr
 lLfzNpKLQBU8Ii84xEBJ7wkkgZ8+Cu8wxSFRSG8ho/oT6ADOk9tSY78DTm9NJZcgKmTFI
 DzTPUh2X7D9/ClSezMJ6OO7TvSFhCgqEJSAWpVTS127K7YQCtM41U95xUWDqDGaaptWHM
 7M1QRmPd4Enm4tR8UanQytDvzqFDBVjNdxkamS0iF9Lleaw9ggUEsMuJ+MUZgy2ZDNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HAlUziJn; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jtk64n5y; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HAlUziJn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jtk64n5y
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A1D460601
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:48:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990ZA6x1255209
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 01:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pCBwvpkhfR2X8OGLdL0QoS
 jBDCgUeREBars5ihZR1As=; b=HAlUziJnOtQTSzLQ1OxslCqKTPZlRY2LK4HHbv
 XCEz+IjHMDliHdcwvxp+QMdk2ArlOgYHFIIkSF9LDrESHfhxcbXjoxirFMim5yVu
 3Ab5hxve/XYqQxjgt/MADp3fkDje04o2y6v4pB2ZvS+GL5+LX7Cjd6oMd60FHDGH
 SAtE987zc5ZbWxXcAb/JLsarwzt9xk8fJKM0RR8nLgDdHUBkR628zncnCPBx4JwN
 MWxYBxDNiPfRBAQpgWnQzZGSWDi3nqCfjInyMUun5R/ZcF/9Ext+2C5lg8g+2oN+
 1sXeym4al9c5tVIjIriCZfGqhwnQuEtW3mwhjgRt9tvGf9MA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufr62t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:48:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so8445638a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791510508; x=1792115308;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pCBwvpkhfR2X8OGLdL0QoSjBDCgUeREBars5ihZR1As=;
 b=jtk64n5y+Ph0zI5M5lDMe367SOgRw4/UccxrwUZNiwR4T6JtC1N+37rh7d5m9LehTI
 2r2taUkr4bmmGGsvPbOR+3zWxpJ3/6cBpc3CZMDkJrVL6azR6zN+OLxG+6ljDC3zFCTU
 3cfsMrv+XsJAQHnc3ZURk0okR3CY/pX6md6+H9wB/GqlZ56jBuFRZKe0DeqZzJjKpsXd
 Pj6hSFaPzpyAoOkUJjPQcMFJLvSDqD1pUEOOTKw0k13eZyQ8ArfW8F+xDxUOgX6rn5UJ
 eXnWqoh+n21TqYYGFZzWzSiWxLwlX+r/jEnzoThdoyI6H2hQxwv1FVObL8SxTAOE4jWW
 PoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791510508; x=1792115308;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pCBwvpkhfR2X8OGLdL0QoSjBDCgUeREBars5ihZR1As=;
 b=tBOM0idyCBlHrbBrsX4UFD02Bord8khN3e4+nN/MWEndfL3UVizk6JzAnRTOafCkSq
 ozSYLZSCz/suvXyuzuYc7yshw5hUwX/YHJQjO9adM6xI6eGZijD7wFA1mXT9Ixibc63I
 sjsy9bFCM1Pj7Ur+pCj6XlddJXShkGO6dYkT7HS33HXZrgxm1FTioq45LavErzF1LFJX
 rZcPdNhAMP2JFO3q+TekdowlhL2dw1cp45Mlrb4U3xxy9wwdmcYcA2QXTsT/efE8s2hE
 dyNwREGwSTGbQmlMFYJrse6yyLxvzCvF8Z6k71eCoHGIPV+Sd71+Kf53ykvTqX4AmKeJ
 1ycQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwo6uk7KP7JqYChDVZS9P2R0lW565I9WqxpJhHc/e4QuX+c/0Zm20p5XiRxgR1nbYrha1T+fWQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdT6bvp5mPkbD2u8knf810BIvs6v/1vdy+bhcoe49BVnRTeBIf
 EGzxJCvJq6U3oGeVs7KnE+GDeC4waZzF3uzBR54YgmXA3/jtR7EpXBzFKHD9J66aKXdAmA5sCD2
 fw5eqMrH0gyXx8jEkaVEY1GiMlEWjYltGA+Z4+n3UgTcrOpGp9t/tFUTERfpdBrz3gO1NRho=
X-Gm-Gg: AYBFou1wp8nrQBC/1bNulWROHiKDLuDypFsVHn/6YdcgnTllFYVO/6gUM/cZbyJk1uG
 bqydzwdeHjE2u1w84wu/3DwhbfsvoAOo3NMAKruLEsjT/SPEEzN47tieztApOwl6YbDpTDcE9mM
 Wms81OOhpFVM6+/yNnVveNdm2C9qy3fUWA0P40WzvagyXQpiPltobtZJEGFZHOmnWdEjEbk38M7
 5sGkr+RZzOdCvq41+lC0p+HcSxnvsrxWsB6PjImK6MmkU0XVpj5J69FXM4EpnolzSOORIkXXZqq
 j5uQpQCn7L/PL8yTI9F7TQqzZnpIAGRnDYr0MUCplScZbhVeKWRxtYd11zMNLmd4pUemsIdo5Va
 TMi3lVPhMpX24tVf7yRGt+6Hlh4aaYl+TgaZmUd1DavQCFJTtYz++rwE34R42GpzO5/Jknj+3lu
 lO6s+xr2RnExmbrLrMil7yL/XEVZS1
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id
 98e67ed59e1d1-3ab3a2fe039mr499694a91.2.1791510507584; 
 Thu, 08 Oct 2026 18:48:27 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id
 98e67ed59e1d1-3ab3a2fe039mr499687a91.2.1791510507060; 
 Thu, 08 Oct 2026 18:48:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab339684f0sm686346a91.1.2026.10.08.18.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 18:48:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 07:18:18 +0530
Subject: [PATCH RESEND] mach-snapdragon: skip serial# env set if already
 present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-serial-set-v1-1-38494e894580@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOFHyGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNLXZD6xBwgVaKbZJ6YmJaUZJCSaJamBNRQUJSallkBNixaKcg12NX
 PRSm2thYAwT+W7mQAAAA=
X-Change-ID: 20261009-serial-set-b7aafbb0da6f
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791510503; l=1149;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yl8LE8vasLEm8CYj2KncLTr0N6u7lk2VAK8liFKmQXg=;
 b=XlUuS3+mmKUTq0Wez2R8zuiMMGPRiDxfYU3uv3Ib6WxZSPH0mEX55gXB8RdNwHwiXrF8/Ulrf
 M9/WGpMGmtMATg2SaBYTAtX5QZ7pAXG0VDEa4zmzKSl4gk+DTWJ5B0T
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac847ec cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_88XgHV3C0jJQcHoMkAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfX+2e8i6iXM7rm
 ykFK9eO4xox8pu2JC94NYISvn030fXZ+/9NIzJnMP/HiCtIs/EE10GggKCZhv3Ry7o3QHNZiSmz
 0ZZ0Kv0HdTaO+YV3baP87Oyej/fWYz8=
X-Proofpoint-GUID: ODmoNfV33k7DNWJX_w3hcN6kvrHEkMtf
X-Proofpoint-ORIG-GUID: ODmoNfV33k7DNWJX_w3hcN6kvrHEkMtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfX2N+HzrUCl1kD
 f0rkzsd+ROhcDsqdYN6ZwD3wMSVn2mKnnWdrzhTPmi3xldZr6KO5I3BefV6jhr/QlSirxL7cDMe
 PAlPETZbuCbcEKpHwf5p3GrrtOd2wWXe37/MGPIt8h4npkVBp3TRoKSa76OPX+LgjbhB79/LzmM
 fLDngYlfDWAVUvmRGcQ8FrYrzmIVdE5Qzzv+QplYPP9ni4iz2IzieHM6onkf6yCTSl91UJufkBk
 KgfFepxrm2a0JFfOOUA3b1yboye1uU+LJ1x+aVQo2v5uONHRFn/6Xdjy/iELR5+LWeeh1ui7531
 d1MFEUaADSomQBqnHi62DEZicA5oxJw8E9M/E+KyexNQbkvdW2g6hHp/ImSLC7PAqaEcXwQHCom
 1m9XMT/NSxPc8sLy/Wgz2dXwgMDJeSd7bjbi3rWjV195f9pv9uT0w8LBqWGYOJcpJPJ9HJRoeUE
 XEIeEhEzn8HlfaodFnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090006
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

serial# is flagged write-once (ENV_FLAGS_VARACCESS_PREVENT_OVERWR), so
setting it again after it has been loaded from a saved environment
gives following unnecessary error logs, which can be avoided.

  ## Error: Can't overwrite "serial#"
  ## Error inserting "serial#" variable, errno=1

Return early from qcom_set_serialno() if serial# is already set.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..cb8a27dc8a5 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -208,6 +208,9 @@ void qcom_set_serialno(void)
 	const char *cmdline;
 	char serial[32];
 
+	if (env_get("serial#"))
+		return;
+
 	if (!qcom_socinfo_init())
 		return;
 

---
base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
change-id: 20261009-serial-set-b7aafbb0da6f

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

