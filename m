Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B99606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NMXbqxvs;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BxzGyBIc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TVuWMcHI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E130E40A26;
	Thu, 22 Oct 2026 21:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5M7v1VVkkb2O; Thu, 22 Oct 2026 21:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C01164057E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704874;
	b=fPnb99k5Ry1Ioph3xj5UZbE0mwJM68NPweQGoJhKrjdzzvuxZ3Sfnjq/iNvXTviPckrW
	 vS9MWtIYeTocC/zA4AQTcY6h33JgfAlYCWPBjv0mm5a8DyXYDrdI5rtGballXpdS4KHHp
	 NcT65ec85c7IOieJduKUgJdZl5fi6QHSDu3ZJ6ZwLM72wwGCn85lR1L8ZB371MLaYkTZd
	 lhiGZ0XZLqkO+XjBfgWfZHdXnhhzuV6O+k2Aaq+nBXKNHNZgPWKcyW+HlIrE0NjL5o1BF
	 aevzspULtprDBD+9A5UxcNYzWPYP5vPN66Px6J+Aa9wa6Aw8NJcxP26D4eIhF7Gd1tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=;
	b=FbW7EiktkAsT70ATUxUAMZRjVmxCiotexAw9mI5xokJebsezS9crf6TAZ0AssRYJYZvf
	 kGS+aG4xBU6bhdSvq1SVVyB/j7PYdk+TJqi/ozWsyy1EPtgIoEfi7I0QYUy05Gw9HiAxN
	 7POT6gMgBd6FM3wVbfXdcblgaNk5B263OMD0reFaSPlC0JrggkDOzIa+5k13t4QC6ClVG
	 DDc6WDt09c2f/3JlemBljhwWd/bRSpqi1FQNs+9y9G5t6mCko2Na6UdS+0FA3Qpmr33wm
	 deG3kaZyKVtG9QuyvNJBNufouRx+zdBY4yykj8uPd5TWXElq3aoq1iQNnXfK3UWJPrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704874;
	bh=m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMXbqxvsCFZ+gZVuG68VKFN+ss3H9+JCySdZjtfbs/GjIvgPBkUujCCKfHxGqW/l6
	 Nc5TzvsGFkbsWitqPOCxinjGbq1kkO9Sv0fqDeKAVFT2KQeoOLQEiMKCDuZzOYVzBw
	 p0jVsvZrntsGzajDFQC2XqoDosqAtHv9xDjCdqSVo17CfaIXO8BUypmewU1IbOMn8f
	 Cp2qFFViwNChmlGBoYYFWVL14lG6YGK4MRlZHz8qudrKXCT/Px+3WU00qOflO+a6Hd
	 HKc85i35np9AqM3aZxa9DgGTY320UnElWjJZ+WTLLuB84OIPJjxhuY7r+/k1wnh29B
	 SvarOat5MaZ6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C01164057E;
	Thu, 22 Oct 2026 21:34:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC93D2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9337F608FC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCuyTp2lvwYY for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07A7B608F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704873;
 b=E8ZQqE5xFPB2P8oy0mnkpCFApspDqG69FBk1g3UTtPWCwDC1T7jHQGFGWo0A2qEe9C65
 4BIIONAPvg7zd37grEQsSbtXMs9/5Yq/tR9EF+7p6C8iP/tNbDxI9aGXAr4Q3gVX1gBLX
 KSmrml4aAR8fNh1/6ACm8VT3ECUtCzR0o0OseQJSMxaUM1w99LZ3q7mn3aDPMWMmKaPQP
 /rQfzKpVO1pZuF/OCwI3jMEBAMSszI/moS0p8+CxXchv+h4JnlDqbf9lJkmKYK63UfZtN
 4rQa+p2aSRu8hkZk+p9Q2rV6BpIBWDzIMB7rJCCUzmPZf718ubDtpJUCdiSes/rAIFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704873;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=;
 b=HbYJa3uDSV4vv2xkfa6P/7W4+LN33RgIFEJXRRzw6kYCc8tIQ7UPgrLbn7Iw9yfhI0gP
 H0t7Ia6RCJsdA+SLbFJhCoXqpliPIQCAU03Fe9ASS+4COfwy78CTvy82yzVVmAyTUaQSF
 hdnh/c1hysQGctgBjvMrSuxWtPdjfpGygCfrKb18lX9ZhknFIED1HAfYQjO8/UaG8GQnT
 iovSelbkB+7VElNFZ7TahV3mUlwrnOY7jdIYKyTq7DB5jJzWAlfAxYZkIwkChgTxFf093
 YeHVOhYPwv1LL7evpjVmgSCl9wGc3itkg5ny/S9efTsEdTO502U/EbKvIxNalxmowFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BxzGyBIc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TVuWMcHI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BxzGyBIc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TVuWMcHI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07A7B608F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKuqW8792308
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=; b=BxzGyBIcRgqpEmia
 LDZyqi+TTesDvp6fpsbPkxcZVAcTCLr7dBTO7nCVdm08tjmwRxrtK8VRu43551FB
 nLIiqQ/AYwYzOinEQC8JS98+7t+VeKB/sMly3u74BydxZMECH0NlZyfMs/OMYKyh
 w0qPRet8B7DQHEiCC9ZagEGwpAP2o1RfBW74InoNC2iAf3mUuBfFtMhA6G9Y1Z+W
 g5Ax2vazAkGyld3NFrY7SmxikBPD+f/Fc5PEjpfrzg9+s1UeqWp2PpWvvo8hCoLe
 y1id7cA3O3dZ6WpVt4dLvqPP8pilgMns8HFzys8l44iJXikMi2kQHGpPwATAruxR
 QZh7Gw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk83qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:32 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0f1c06332so5099547b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704871; x=1793309671;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=;
 b=TVuWMcHIFmY29YewdZWHvhaSAPI993aU007S9ztlSZdcIKdC7rv82g/G0gkPWzphnb
 jHPLpf+lQ2DB+HVBVaEF3/Dj8obdcYeHzqccWnCSXK6vx4++SkhsuTCbElvceqF/fetZ
 sgqplH8mdSxAMrhQaKA6Hc6/kzXlTjStkMzKPogAfx4QYp7aL320bXQMmUmUG5Jc6lE6
 ZGRwkWZxKXNcThFlDdVbZFkwRDq8x3A2xV1dkyMKQUaUp4Ga8/cE6y4cqfEiyOXbiyMd
 OHU6n4mLfZ62tHX4An/G1pU39KR6w/J2OR+elfYAN2l6u788lfwiqtXdMkieQHrg7Emu
 HQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704871; x=1793309671;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m7JdwxGqbwVP/0BEuZVSXo/4hrdcV/+Meu7mXbmuNEg=;
 b=eWWvexKYApUhkeIRe4twYgLpe1asX5dXfyOdEPUfQWVdeaBMgTaJt4X41i6/ZbGksQ
 w+dz7rJqpRaVpbfFPSauk/FHoaPR6tPOWrTtR9ba9OIvP7yLVG3k2X6WKm0hCRrxiT2r
 5Ir13uoiEg/3ZCpLRJAMv/NYL9XfEyeRSURhHNsqnF6EVBVP6lfScVV/DykK0TpURkjy
 FJPH8l7HyO/BU3cAoF5Poid5LhHaUyHOLKuJBmqu45bgAmxWtxnCGGheq6Isc5EBKJXa
 1uFQaJDVT7FC4a6JqW9WfNzHaKikcTxoD0HevNwM9XPb2k6cWKNK5EVx+kv2kxxTvieC
 1VJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWfJEqs+ykW8S00I0TYNMBfEPcMO0kXe7OzNCwof/LkPtP8yp5l5RFxP71NelyGpTsAflNnU8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJc6GtB9SNSr9agsf3N5YZpPvIAQbfh+vGGpbNMjJXxngFqX28Y
 PEhmj8Pd1sL+MTihAHD1J2/8Z8Wbz+bJkiHJjIi7/8Kpp3NDt1N/x7z0K9C7y/kNDSJ6pncaEU1
 TJnGBg8FwlpNajJbMSqmApYXEvnI5iaw6v0VVPABEghPrdtuYkePX8TJU7ls28ZWhNowcf+E=
X-Gm-Gg: AYBFou3bedUUMtUBpluZBUMen2OivyzWSCRnGVgDHzj5m5hlQwMDsxlS7YblbCcRa7B
 g09EOehNmghYY9oMoOfQMauinLYpYRLlQGbfLFfIx/GSS34Rsxj5QFbbdnYxCIx9GtktWUb064e
 gafjts6Zz2Fn5a93EvBXplxKD6jQzkMgCp53jq8E04c3uORPc1V9Tbj07MVCry4BGZm2L38A5h7
 RZy8BR+dncAMN4uVZ5rbLWNNlRyjXLBdNw+QZYbodgU5rT1DgkRI64gBbOPB0ryWo2bkXb58wTs
 83mtsLooh9kYPNmaY9Y42S0VN8U8PHHjuIJIRbZKgrPzn0wiaLaqQ7R2a6RTjOIyLAqArFISYOX
 zQwoA22Z4vvOyUjUpOTp4BmUNfNYGdzn4vGxX9NBgclwu9bUymkJn6EKR9jGX
X-Received: by 2002:a05:690c:e0c6:20b0:8ab:4c8f:2844 with SMTP id
 00721157ae682-8b157e3429bmr2230647b3.39.1792704871089; 
 Thu, 22 Oct 2026 14:34:31 -0700 (PDT)
X-Received: by 2002:a05:690c:e0c6:20b0:8ab:4c8f:2844 with SMTP id
 00721157ae682-8b157e3429bmr2230357b3.39.1792704870654; 
 Thu, 22 Oct 2026 14:34:30 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b156156d27sm4419367b3.26.2026.10.22.14.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:30 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 4/8] clk: qcom: add NWGCC driver for nord
Date: Thu, 22 Oct 2026 17:34:23 -0400
Message-ID: <20261022213423.765885-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-5-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-5-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX4FMRcBa0UfwD
 itVmw5aH34cIcS7NRKwqdfdhXyedb1Fe+/ayapWileOs8o4lvd85i2CzW9srF1LSfQnntWaTfDi
 AhkuSqJlrAsOxsR/1xN0av85/f8Cr6gVsKRnJxcLzutGjUMs3zKeNII4kSGcKID0XjtNLAWKMyk
 UHkhjY5ZNKRB5Fn5MaDIVxpeBk+Ppi3tNd2diy5c9P1HYLf5eXvF3LLDO4FA5Jv/iHTD+xq+Y8x
 wp83K9ATa+VmQHQjqqhP5WAf4w1vh2aSVHYevfAWCDd7E5xnESWAAYJDaa+czWXIX1YuRMPwpqM
 JnTWwKduL6Dwm34B+ILvRRLhIJVUIhq5vfa2Ph6eQX1KhuV3PgnTmVJ3f4npHTVgtb6zAcjsqws
 7BSq9ZDtGn9/vabF3lOb3EV9zsE83imBFs74jB+erFVwUWGG5W8Xskdzd6IOtsMIiK+z5NkxKXj
 ZE/wRSzJ2/cNaTIKdHg==
X-Proofpoint-ORIG-GUID: HOKWOy8QO6ceLfaWMR0AkzPscRDgjj_e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX9Rog3NMuvp/r
 /3UMf6AwsXK5zGEHH2UumvRNGIrm0j5L0Uc/gRN066C43gRPRLDNC4ovtAw96Go5XDsI7e7nC/4
 A1Yb167JrKHrUzRVe19+Zs77V6q57Iw=
X-Proofpoint-GUID: HOKWOy8QO6ceLfaWMR0AkzPscRDgjj_e
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada8168 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=vha28Hh_mLtyhlenCxIA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220085
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
> Add support for the nord NW Global Clock Controller (NWGCC).

Nothing in U-Boot uses these clocks. Drop it until something does.
