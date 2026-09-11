Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBB2C88E41
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 06:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B3CD80F64;
	Fri, 11 Sep 2026 06:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8bzwsgw05BN; Fri, 11 Sep 2026 06:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FC3780F65
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789107550;
	b=DRH4t6pUOeHX9KD2XZawY1C6VJ73YZUoSap8z8D4i1YJx12YP5FWR1CcWW/VNS9mmN2j
	 F9k4yXMs+GDpd1eAOW67Lek7sV3Qmb4gd5jE3aiJqhjekndoNCYtQDqA+Am3J1pwvS3uy
	 d/FLzqRVncGGISFEkuggv3E/pP7aTcTsNo2qnEDdKvoWvE9dbshatJyLrcbPA7gJrlRaG
	 cXfUh/QPsgW7Nc1StXl852cQFmHbEEqOF/57u47l1hl6nPm1ipYTFdbu82eBxKOlAqxKs
	 Ec2P4jnYN/yVIWvUclLlGnDP0mFGImay7wXEuFwO7id8BYiinzjQTYYDr2Y4S/uswZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789107550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=;
	b=D5V6k5JF3gC3jj7mSwdocw2/ApsK9y8Xf81Rpus30OyENCjiRNn5Eev7UZEAHUqAigv2
	 mtKatM/YQTWEqHRoXC5dXjcy83hsOVZKfYnGdVrjGIc1GK+nou7ktjzuTSNLf9T6RyWqC
	 qtHOg4iTyoFGZ2OOzV0O5PxpbxjkSMtVixADGyE9tRk6+lF7+3B6CGRcBibswHHvS+lDI
	 wD1yqUhMLS2DqzmDDcc2Evrii7ysFDGKZ6QQWEaj/+A0APhzgNoIDgiRIoVut1PB8xg3i
	 UaYJMqpiRqkk3XYt+iB3hV2f7mRMmalsgVDk5hFAroESF4Q9QA2flytvXoN8ewzd2xw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789107550;
	bh=o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JdSC7RD+WAvbw7PE2EPwQ9+A95Cqaj9vmQZPsWG9e2GFJ34+HYWpnYfEIIHfEFrGA
	 xmt+Re1/jO6H0PIHjYfMeCdz2ET1PpWGVaBPoiO53VWoCtA2x9p0KVVJW+JfV0UCog
	 HefTkTVJgysGuQYpqWdkiPd/ra/uskBl5onsH9QmUlvpAV9dwU9th6pRek2POqodyG
	 nxRFgJLS81wF14f2nXww0u5Os+VS3mMVucko3Ba/vYhrwUT1ngRa3+okW08FzasWUl
	 ziqMY1Zr/++g2m90WRsspGTQucVtpSzOAykIp9tquRjXgCRK3WAlnQYk3+HjyD7ZUR
	 TSwudeGjvkCwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FC3780F65;
	Fri, 11 Sep 2026 06:19:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7335649D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59A06607E8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2FZ4X3M2qJ4 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 06:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 97CB26080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789107547;
 b=pwzczXP3cKhQ5xm7DH9B4fxq3mc0EsuTUQLqWpNc/YuIJD3KUVG1vGSBzcVInh+WwoHL
 KG7fcKhNUoDv1y4e5qKUIhbyrms2g0msyzGJx1VjFwSkGwHmKy7N1yN3P29B29d3uZz2y
 uXGnPE3dzkL/LAa8wVbHZTpOND81eHOAUQsPTeaRL1yTm2rjoQG78OLCyroBIWI9izKUQ
 3vn3YkYrx0rqF9dKcDZ09NIPrAR+7WOnqNdWH1shnYhjN5jOF7TSyLoPC7er3YUlvkzQ3
 yiTokVWxxvUGqRZi6mNycuZgDzY+2bPMPfIGUnwL1WwGRCcYBe9eqilckSyOwl5cakQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789107547;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=;
 b=Iw+OMxLxBYlL8WwXaDKcrYKNHS1o6wg7WDTkkUBybAH0U1+MgqFM5YrtTTv2az1B3B/k
 N1EA6Pb+ZniJNnXgxmLrbOz8AxUYzfugWY09UAJuD4fSXkJLMziM1/BRKcl5TFPyCS0tU
 vfbw8dcHC7H1+39GExD2sAvQnZkWU+LlAwYVM73iYM0i4r6TSjqTLp3pPWy5xkoyyQtVX
 cs2wRulmdHD4dYUqtAFwOEGq27KnQf5hBPq0dIMnRsTLyv0itHQqHrnbc7jzIaZQhf6+u
 OmyJp0ZbJk51qjyjqW58j/Tt+uvkG+d9Vf7rweSdJhPN0cRpXaVn3VFnA7Xd3Ebj5tg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jkmc7NhY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sj2ac7eX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jkmc7NhY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sj2ac7eX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97CB26080C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:19:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B5NqP4099834
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=; b=jkmc7NhYv77S8OMW
 RLE70bQUj5OcfKYU05PZXE27esi1Nqar6nJzquwhqd/kbbI3NuSeCYlHXW4O5tJo
 VPkPWZPNopGbHbTLAULoA8cUQGWwgJ5Vg0v5Y0w4ipcgmZ4XW7QCirRWcZIDPQhH
 V58MehjHTaUHZM50kmb7LDoOw74chW7dIkYWsZDF2iAvwompLNPDXoJxbX8GaeTI
 nDoeqRTBgL0VKd9kvT9XRP5TG2Bs5HWiaglRGbNEE56GzHNIbdIK0U4t8PxvKegP
 yXQMild2gwFYEx6HHOUMOSUB4Jsj2ABHYT9mNXeoBP3lOyl27Cy8tU6Rq8XAYCxA
 OowzSw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8g6mn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:19:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso713243a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789107546; x=1789712346;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=;
 b=Sj2ac7eXrexpw+RJIevPLAKVALnQUVndJrQUAFN16OOW+fPAoCpVB8eM189Mz6f6dX
 VBk3oVuO81fWkufvoi1/S5UwaIoE/QIIqHR5yVwtYNOuvs4Z0yIlfcZd4rxc1KJPQDSj
 qX2Skv9M6BuF1xVvJ7QFC4PoyXKe1KPpzyca7uJRyGe2cas+4TyttBX26BpGogeWTYLh
 re8xarrUHeU++TVhO7iHiziOBnhniTQ+tqOXogJgJ4uEH0m5x0F1hMpl5P8dL/BcKxYv
 NMrTZE5tWZrkQYW7vn2vJH+NmcHEDqCGZg6K6F5KZq3aNkfVWyljJyajp6+fmgIWyXia
 kDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789107546; x=1789712346;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1Rka0yt1df2vCcsovngWi1sKADdlfGXW7cSb3nUAM0=;
 b=JB29RtTvwamt8j3ZKpWhsoHO0eG+u/4uTnTS85lTaLJHs48PSKhFQlde9v+xqYpvNy
 HJuhSfl4H/JSKYGCKg15TkJ3Z+ZbyKuEIIh8sIUA0z31WAda7aGjiVT+DoYTbPAMFxi5
 L+uCWf8rsGY5Cq6XDUp7u7l8AgQftpXoOVxBVXd5NxJafXCYtYDAg45TZWL2LpH8eLxj
 jIE9PiuxqposhS+eJJXOgK5nSRt3hKFUN3qnTiBd0Va0eJloJZGP2Xt0xvpNkmxfZl8f
 5/Bc57/kfT2RT2ju/4ioSpDq00WH6DUdh/l0bxyZ5k24PFWqsouBDlRBLYphiFVfugDT
 oKMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7Z0WV3cSL5UxQFs+8CwXdXisKX7VyvTwZemYePmfHsS1ejo6mda/vM91TSIsr1ICm6mVd5H0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++niWeM/o9gZvfCH1nZzySTEO/XBmsbYGUZV9Zbmln7KoH0IW1kd
 h/QKMgZTXgjQCmcpmXBToDsH+K3CkOTeOqPszwSLQOeDUq86sKFx1F5g4DQnxPsxYIqdatiHByq
 9d9U5+1bT9+LQ9VhEoeXIkp0Fw6RfZmL0nlYV1epRV+gO9H5tdOn5q7yDW2apVtzpX0Oqq6k=
X-Gm-Gg: AYBFou1RlcJNn9qdOtz3mdw9QmsyFkhseGeokwUT6Ozi49BfYOB4/dZkArst1kNETGm
 sehhkQZ1xoROWeUuhaTJO+JoNwSIZjGO2NOV01z0SB24jlJtjMD4ugKhTmDTngLf9rOIBsJQzG3
 ZO1VZ/CXcvG7fZJXvmzqgG6ms+eXk41+1MWO+JeqGODYjrn4cmhSawXOyYmJ9HwwQ5owqiPXzOB
 mCWtjJ1ns/CHVsAlLE5HDuWKF/jNa8HQ1nVsp86duTcpW545fF7uQQ0qhFZ4N7l16TI53o+IUf6
 nrdwBdSvOoDeV+AIaFg835NiCtIybciYwO72R+T14UwlHo+1LQYMOYzulA9I7XJO27ZGpe4yq5W
 Knx+MLKzo+aSMhuxiDeUVQH2MroB7feExcKrD
X-Received: by 2002:a17:90b:3a44:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-39d9bd923aamr4657238a91.10.1789107545294; 
 Thu, 10 Sep 2026 23:19:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3a44:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-39d9bd923aamr4657197a91.10.1789107544858; 
 Thu, 10 Sep 2026 23:19:04 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm3926548eec.28.2026.09.10.23.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 23:19:04 -0700 (PDT)
Message-ID: <b127d4ec-a8ce-4dd5-8382-12e8b1c75b8c@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:48:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: Reza Kurniawan <imkyufie@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
References: <20260910095339.110427-1-imkyufie@gmail.com>
 <20260910095339.110427-4-imkyufie@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910095339.110427-4-imkyufie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eMJK5-zjXE-p64lI7HxxrXSeBlpa3DKR
X-Proofpoint-ORIG-GUID: eMJK5-zjXE-p64lI7HxxrXSeBlpa3DKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA4NSBTYWx0ZWRfX1jUvqjeyRWvO
 OS4rhsIi3IhEzbetjeqAOZOGQlRawfhJ5wWRdT6W1V9nSK0NogSO+uuxH7/6NsDAiGFAZR8xQEy
 H8cuUBQKcfJqyY+Y0XtsGIHxHa+0AjnEahL+StE5b7KErGqp/qzUvC1MoQl3sPdkBiQ1lsctRQ3
 LhVqdjXx9bAQAgttB7DldUs3YmcEJ6lzJNK2x/Opm1Ccosay6NXD13TOkIGzcP3Nk/umyxLcrBC
 8wz/ENsxNGY+gA/8RTiOkFVmRdudOfvPA3zpw9uIokcDgbNzsM7jDiH2eTVROZgFFGowjTTprWB
 x68cmhf5YB+WrR/S2yeOdmV7M1myiHLkjLttZLdGBlgmWHVIjWRpupnddyxdLB4O5T5iumG9C3T
 FkAQb1N87qR49mdgV2Fpl6yqqWMYRnhw5PCc6YtGHtgaBvEWwBtCyBinr5r0eUGTtbRuc0xsekA
 taov7BG/seNNSoxwcXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA4NSBTYWx0ZWRfX4MUAEdU+QP21
 XrQK8JjyKDP3pCkwti3zrZDgvWkSGZEYnik2dpCV99So6fwNkS6Ox/H5MYgM4IRzymr2/BbboBr
 ow1SOTjeWmK19+/a9xGClSERv1P1S4s=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa39d5a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7hwhKKvj7wuNyXN3tagA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110085
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

Hi Reza,

On 9/10/2026 3:11 PM, Reza Kurniawan wrote:
> Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
> directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
> Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs.
>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>
>   drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
>   drivers/clk/qcom/clock-qcom.h |  1 +
>   2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 6b46d9db7..754ff4ff4 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) = {
>   static int qcom_power_set(struct power_domain *pwr, bool on)
>   {
>   	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> -	void __iomem *base = dev_get_priv(pwr->dev);
> +	void __iomem *base = dev_get_priv(pwr->dev), *poll_addr;
>   	const struct qcom_power_map *map;
> -	u32 value;
> +	u32 value, mask;
>   	int ret;
>   
>   	if (pwr->id >= data->num_power_domains)
> @@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>   
>   	writel(value, base + map->reg);
>   
> -	if (on)
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +	poll_addr = base + map->reg;
> +	if (map->poll_gdscr) {
> +		/* Some SOCs such as MSM8917 poll at GDSCR */
> +		ret = readl_poll_timeout(poll_addr,
>   					 value,
> -					 (value & GDSC_POWER_UP_COMPLETE) ||
> -					 (value & GDSC_PWR_ON_MASK),
> +					 (!!(value & GDSC_PWR_ON_MASK) == on),
>   					 GDSC_STATUS_POLL_TIMEOUT_US);
> -
> -	else
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +	} else {
> +		mask = on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_COMPLETE;
> +		ret = readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
>   					 value,
> -					 (value & GDSC_POWER_DOWN_COMPLETE) ||
> -					 !(value & GDSC_PWR_ON_MASK),
> +					 (value & mask) ||
> +					 !!(value & GDSC_PWR_ON_MASK) == on,
>   					 GDSC_STATUS_POLL_TIMEOUT_US);
> +	}
>   
>   	if (ret == -ETIMEDOUT)
>   		printf("WARNING: GDSC %lu is stuck during power on/off\n",
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 3a4550d85..0b514cc1f 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -76,6 +76,7 @@ struct qcom_reset_map {
>   
>   struct qcom_power_map {
>   	unsigned int reg;
> +	bool poll_gdscr;
>   };
>   
>   struct clk;
