Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC68C88E41
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 06:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 352ED811DA;
	Fri, 11 Sep 2026 06:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aaLMPYIDP3nW; Fri, 11 Sep 2026 06:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40020811D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789106770;
	b=oL7yn4NniosgMyHtUz4Mnlya9dPh5AmIl5a8v3iwUViv74MB87uecItR/NQilYeuLD5/
	 ins1MJOv29UnekB2VLFIQumDH/ulouGMaciDF/GAhTh4IUX1Q7q+8QZ3q4KyK2uY5I9DG
	 7UpfU2BFx5qDajKiH2/AEAAoWQZEIPMGmU1xA5EDH0m+r4pUx1LOP3lj2gUZMI5GuvQQK
	 LAS/O+2/Dy3YIpqeS3K0rHgd2QA7lFxKnZsWR6BLWl6apl2+WtUBW/WlJPH7RG4jDkHUU
	 l2wdiEZlHER5gfDwZ2qsvO1hrIj9JNNKF/RFdsG3pcd7MOSnkwbVP9bNY3Wk+v4RmsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789106770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=;
	b=nWEn97wBA5whfm1hxJoUWt/QhKh2rtMmxggTEoP11XWp5VQxlLQ3iejOG+nPr/JPoHV0
	 JSjZo1DvKXWt4DH/LXxZsA1g/lHagujuiWzGAUw9yIBIa9FUICca/+niWYHXu5ilOw8oQ
	 oeEY37WbRaEpYdpLJ0g6txsK2vzMnD6ikiwYCI+F3RzO/tlDZwPJvCocM1ZR4aVQujvrx
	 8Z9G2UhBurip2rERHV0oif4QyAIWitCDFonQRr0MzrkloZbX9XunhgXsJrPvP92KNbxb1
	 9nyjIdvJWryk8JZifkyNhie7ONwM+Krv5iBcVbbZo4K3LKuzSbm5JV2c4T/j88L8bEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789106770;
	bh=n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBiZJIH3RDoUNV6ggC9kDhkoABRvgoF99I6kM3BaYIcZHZQF4by0KFZD+ONH4a+e2
	 9sKKSz9QALPGo4n3Obj8wbcOw6k3Cc/1jSZWtLmu/OpHRRP3buh7R0I7nSnq/bMgwc
	 2JZp05rG9/NKV7DcPc2NjGWyDoVE+/8QnQsucat20k0MXhjYE/li35bM54qw45HTtM
	 EZAs8bdb5ddiYfx3xuoRCxPlxJ9ai69f52ls/cCF7ruF6/rNuUgczI0y5urQ/zlQj9
	 2+8j9+7Ff98FB/dhOPy+gOACbWNp/g6S8WveKav1s9ttyY2xHRsQPVSHfCRBBTD0Mw
	 1/U3pro+7eOZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40020811D0;
	Fri, 11 Sep 2026 06:06:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81DDD2D0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72616607F8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFcrMvlRIr0V for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 06:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BEBDC607ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789106767;
 b=A2Lb57fOBR+MMhjnjeULFZ6+RjhOJRhsDU4s0MLFP73Bj21H5kr8R+mCrWQCtwEByck4
 cNm9Ed4FDd8SE/3db+yH/i2Vcnu1AgoY7wvn4FWjTHpg0+NgSi3z9oqHYb22Ry0+LCg16
 p4b8RHk7MYsTF63dZCh08u9KeMqAmdSG8tg+KDZpBuNXSIBeHTZ5oIUfoe0jU9YOleZC2
 qioQ+WvPxLuWf2KVqO9I2DMSjjuD9z78V5nLLd2rmcsj7e1QgXT3PsjY+ZmLlGjZalVqN
 OmAS/8opT21uwlqly1iUGIw0YNlT1wH1WS5XBMR7VIEoKRWhgBZDcNmfFFsPz9FzuTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789106767;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=;
 b=JvAgCqngn+oc3ugvJ5OMT+rAJeeyPv9hROHWHPbXmnDwQir6RhqgIRPYlZ1QPGajgUPS
 v0GAPcHYESBrdJGB9GPz6XZ6bhn0A2GKHgnoYbecn3qaddetpNt0FuYsZXGvUeaO9RD9A
 QNDHlhgAUcKx9tk0FEjjeTWRtsTUlqCj0y/AGBpB2ETvewiy1qdr1PpoeISbDSc2q20n3
 2HmyoDYDgI7B/FeIeNIZFE5FT73M9fVzJVw/+a5+V56NMtsLomtlvO/QyJdjFGVyJZ73A
 82+aMH2W842C1BSAKwEy073KBi6TdokWbj/bR7pN2TMvOWrQYSk8506xy1lY182qggA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KPf56HxS; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=df6RZ03u; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=KPf56HxS; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=df6RZ03u
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEBDC607ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:06:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B4vYDJ2634893
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=; b=KPf56HxShol3Ts8K
 j+VtnsV4eaU3f3kqQYh2KFbtptay5Ige5E8pdFuUy7g4pTvRFCXKK4agBpGKWHUc
 cR6tIoIbKXEaJTwGMYd7LnzU5jvfZiXdO17hNhO8puX8Ghih9hirMFeegJlaEd1h
 v2/Rd2F9fk62E1/xKWfHwt/u9o/LXEUJVE1j/Zy9b4fu3hiAOqAK2BcoPvlRnJwY
 QxoSJE4OAVood2eAs/pVBfj+lX64eO+b/RjoNI3ZgYimlUFrJKZ+O+IX36rLo/c4
 qqE/rBdARPBlGZrhoC9VSxXCtAI8Ubi+zKiI+SKzZ+GwqBR+3qWULfaIuTi2x70/
 pvSR9Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx3n9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:06:05 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b28deb7ee3so965227b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789106765; x=1789711565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=;
 b=df6RZ03ultrzRdMg1A/iswysxpCf3OkirTvP+1TXczCPyIG3gmY6r9EtkDp+Up+ZXV
 u74XapzN0uI1gGSMxAcz/1uA4+1/A9FskybxRNFCRFlM7FVlqfFKvty0ds9cmupT7Brb
 6CKIAeE6zxmhY+yG+IBq+WIdqHtQzYuSPFoELU/1CthTWYbkzxGeH5+zoo709puxqnUf
 zA8TzbEdk+aTreawlnKOshhglAGaypfB0ZpBIBZJ0Cscgw0Bs7xxMh6kGmM+ZLI8BE0g
 H4B15nzXOL0oVkLhHnKG6gNhIhs0Uup0bwPe6PqjMv07WFAtqRbmxQOGHdQN6AFOj+VU
 fV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789106765; x=1789711565;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6nG2MGYFZcj7oDnDMbM1cXk3vhwD30qxSRaf6eCf/c=;
 b=js85gVDVmr8WiEaZS3obLNPxUT54T5xJziT/S2/EbTwAo+SfwuJUtUEenHDd4dd/Ig
 hHA+UC8LTlaXVxYXt/mDHpz06ysmEvRMsjVR6aZeH7uky4P5G1QxtgessF6T3z4RoHt4
 sBSwzVUzKBdVlS3pFYtib1oRfXbqD3A8qEUwsr0hfjEdPl/YCeYys7QfaiTz+8QmJgq1
 FRqpMJxhra/d66pd8Mq93NNIrXEPeZsFOl2dodgSnZJAEbXgXuoy6GAei5OoqvK2Y59i
 avgoKGderIMrTP51LP1kSIcvEx0NGlK04mPz91wAuekLJTot3mEts4iz2Vj/JOSVcbPi
 kchQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDzmpqNkCjOqBsze7er0PqoB0KlbPs2ngwLyIN9SJrQ0UmQPt5/fbvAiKHCB1t2hKsrkqYLDc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m0oS0YBwfYhBmsDKaxNmTPxBM5hDzyXuOcnsT7wmJPGnYosnMB
 8sCikqquZfQxDdPbZH7iIT2/MACUPsG/FtDjyl+9v2P8+tpsp/ba+JzhvQZFUfQfWL9bQY7kXdD
 9+wrDsBl+23U19Bp7Y+3BM5Q6nRlAxIUte9IthGHuyab61nbtNjH26bcO8CDmwwWmx2zyH7A=
X-Gm-Gg: AYBFou13EC1uRL2RskTftnBWrnX9N5QrvlfXCwnf2rSNtZ29nHnUhXqcEXmqQ7OMy/m
 KS+qzjg5BjmDc82t0CWE9/rEBKbsjAVPhYiK/4Pnf+jqRmJ2FREMfBUI6Vcjs56bHLxpqprUkZb
 cxRu7VMDBEMrrdejZCNCzO8K4RsLP+TubOw3pngny3DfWSdy5BPyQLgi1qf6/JSyPuO+zEA/L+v
 OyV/nGPTLR/9akFmoddlaebPJk14LH8BJfouXtnatbO8U8A45BYAKxKXNrakeULgydq1+F0Zx82
 rcNXbrjXVR8FkkwJ4UIS9AwrSYkb9KgnSC1A+tC6BaEOCyXtiQ6E4eyMgSsBjbaEMOMyEnim1Fq
 hTlFHIZrqIZgu1XGeQo/7bO8ZRi51KPtp/NDp
X-Received: by 2002:a05:6808:23c1:b0:4c1:4e18:85e1 with SMTP id
 5614622812f47-4c31c30c1c9mr2437075b6e.32.1789106764491; 
 Thu, 10 Sep 2026 23:06:04 -0700 (PDT)
X-Received: by 2002:a05:6808:23c1:b0:4c1:4e18:85e1 with SMTP id
 5614622812f47-4c31c30c1c9mr2437043b6e.32.1789106763972; 
 Thu, 10 Sep 2026 23:06:03 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba729dsm5003814c88.14.2026.09.10.23.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 23:06:03 -0700 (PDT)
Message-ID: <d625293d-1ce2-42a5-b7f3-7ebef0c9484c@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:35:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pinctrl: qcom: Add pinctrl driver for MSM8917
To: Reza Kurniawan <imkyufie@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
References: <20260910095339.110427-1-imkyufie@gmail.com>
 <20260910095339.110427-3-imkyufie@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910095339.110427-3-imkyufie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA4MyBTYWx0ZWRfXzznm9SxpK7ii
 2ggEvNjC0+uJrPLvRjG5Dq8DTFMo9UiVAakT2LRw91tpq8Y8qGXauJzvWLy6SBVyA/P257Klxq3
 UJAlhGgimRoS+VBRgVFv0IOmA/Tx3RFWcLzCuBo5hC+8dmTgKUwky+bxchhf+nVyz1Igj84Rl1l
 ZV7q9x8qzWwR8V3FAakNfdaB9AG+bhzS3yjdCc1V9KIOTeV1DZSkw+pl5hMAYBEJr7zAzjbnmvo
 TkD+QGnyHKdJoGmBA19O/K3zZ4FaWfTVpMiOFDU8STSrhxXb1ZeDx+jzvuKW7CkntLd94iapOWQ
 WTXKwRUnq5iQAFCePfXuBej0EaolG5Z2dkAKumU64G2IEC9HJTBJdC3N8jUeuMxPbvErKVUrd93
 FpoJjMwzEP+5ayFKnn9poj7ULt7Dp89eB0yAa9DUP1+x3HswYMWZ+uYL2rnTY0qmkSkv3MxjsWY
 DUAs6qY14mHFvsb6Xlw==
X-Proofpoint-ORIG-GUID: xj4DqEXp-1hU2EE91sVetLKZL-v04RfV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA4MyBTYWx0ZWRfX07A4t9mEPJA5
 /C1UYZWDU0GfHxq9GdlGpLIPRcxBy5S4J9moxHBZl8tT/12p/F11vGEvghrsxUx3gWRRkbKC6zI
 o0lbn6WdMHa2yAgfmDpmJt1RyMA75Js=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa39a4d cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=-X-MNLHj3zF03-EV9_8A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: xj4DqEXp-1hU2EE91sVetLKZL-v04RfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110083
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
> Add pinctrl driver to configure pin parameters and managing GPIOs
> necessary for certain peripherals.

Can you mention the linux commit you ported this from? in following format:

"Taken from Linux commit <short_sha> ("<kernel_commit_summary>")"


> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>
>   drivers/pinctrl/qcom/Kconfig           |   8 +
>   drivers/pinctrl/qcom/Makefile          |   1 +
>   drivers/pinctrl/qcom/pinctrl-msm8917.c | 642 +++++++++++++++++++++++++
>   3 files changed, 651 insertions(+)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8917.c
>
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 7dd3782c1..10737b5e2 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -62,6 +62,14 @@ config PINCTRL_QCOM_MILOS
>   	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_MSM8917
> +	bool "Qualcomm MSM8917 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon MSM8917 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 Pinctrl"
>   	default y if PINCTRL_QCOM_GENERIC
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index a7a9ad035..df445ef09 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
>   obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
>   obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>   obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
> +obj-$(CONFIG_PINCTRL_QCOM_MSM8917) += pinctrl-msm8917.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8917.c b/drivers/pinctrl/qcom/pinctrl-msm8917.c
> new file mode 100644
> index 000000000..78edd653a
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-msm8917.c
> @@ -0,0 +1,642 @@
> +// SPDX-License-Identifier: GPL-2.0+
This should be GPL-2.0-only i guess.
> +/*
> + * Qualcomm MSM8917 pinctrl
> + *
> + * (C) Copyright 2026 Reza Kurniawan <imkyufie@gmail.com>
> + *
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +typedef unsigned int msm_pin_function[10];
> +
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)\
> +	[id] = {					\
> +		msm_mux_gpio, /* gpio mode */		\
> +		msm_mux_##f1,				\
> +		msm_mux_##f2,				\
> +		msm_mux_##f3,				\
> +		msm_mux_##f4,				\
> +		msm_mux_##f5,				\
> +		msm_mux_##f6,				\
> +		msm_mux_##f7,				\
> +		msm_mux_##f8,				\
> +		msm_mux_##f9				\
> +	}
> +
> +#define SDC_PINGROUP(pg_name, ctl, pull, drv)	\
> +	{						\
> +		.name = pg_name,			\
> +		.ctl_reg = ctl,				\
> +		.io_reg = 0,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +	}
> +
> +enum msm8917_functions {
> +	msm_mux_accel_int,
> +	msm_mux_adsp_ext,
> +	msm_mux_alsp_int,
> +	msm_mux_atest_bbrx0,
> +	msm_mux_atest_bbrx1,
> +	msm_mux_atest_char,
> +	msm_mux_atest_char0,
> +	msm_mux_atest_char1,
> +	msm_mux_atest_char2,
> +	msm_mux_atest_char3,
> +	msm_mux_atest_combodac_to_gpio_native,
> +	msm_mux_atest_gpsadc_dtest0_native,
> +	msm_mux_atest_gpsadc_dtest1_native,
> +	msm_mux_atest_tsens,
> +	msm_mux_atest_wlan0,
> +	msm_mux_atest_wlan1,
> +	msm_mux_audio_ref,
> +	msm_mux_audio_reset,
> +	msm_mux_bimc_dte0,
> +	msm_mux_bimc_dte1,
> +	msm_mux_blsp6_spi,
> +	msm_mux_blsp8_spi,
> +	msm_mux_blsp_i2c1,
> +	msm_mux_blsp_i2c2,
> +	msm_mux_blsp_i2c3,
> +	msm_mux_blsp_i2c4,
> +	msm_mux_blsp_i2c5,
> +	msm_mux_blsp_i2c6,
> +	msm_mux_blsp_i2c7,
> +	msm_mux_blsp_i2c8,
> +	msm_mux_blsp_spi1,
> +	msm_mux_blsp_spi2,
> +	msm_mux_blsp_spi3,
> +	msm_mux_blsp_spi4,
> +	msm_mux_blsp_spi5,
> +	msm_mux_blsp_spi6,
> +	msm_mux_blsp_spi7,
> +	msm_mux_blsp_spi8,
> +	msm_mux_blsp_uart1,
> +	msm_mux_blsp_uart2,
> +	msm_mux_blsp_uart3,
> +	msm_mux_blsp_uart4,
> +	msm_mux_blsp_uart5,
> +	msm_mux_blsp_uart6,
> +	msm_mux_blsp_uart7,
> +	msm_mux_blsp_uart8,
> +	msm_mux_cam0_ldo,
> +	msm_mux_cam1_rst,
> +	msm_mux_cam1_standby,
> +	msm_mux_cam2_rst,
> +	msm_mux_cam2_standby,
> +	msm_mux_cam_mclk,
> +	msm_mux_cci_async,
> +	msm_mux_cci_i2c,
> +	msm_mux_cci_timer0,
> +	msm_mux_cci_timer1,
> +	msm_mux_cdc_pdm0,
> +	msm_mux_codec_int1,
> +	msm_mux_codec_int2,
> +	msm_mux_codec_mad,
> +	msm_mux_coex_uart,
> +	msm_mux_cri_trng,
> +	msm_mux_cri_trng0,
> +	msm_mux_cri_trng1,
> +	msm_mux_dbg_out,
> +	msm_mux_dmic0_clk,
> +	msm_mux_dmic0_data,
> +	msm_mux_ebi_cdc,
> +	msm_mux_ebi_ch0,
> +	msm_mux_ext_lpass,
> +	msm_mux_forced_usb,
> +	msm_mux_fp_gpio,
> +	msm_mux_fp_int,
> +	msm_mux_gcc_gp1_clk_a,
> +	msm_mux_gcc_gp1_clk_b,
> +	msm_mux_gcc_gp2_clk_a,
> +	msm_mux_gcc_gp2_clk_b,
> +	msm_mux_gcc_gp3_clk_a,
> +	msm_mux_gcc_gp3_clk_b,
> +	msm_mux_gcc_plltest,
> +	msm_mux_gcc_tlmm,
> +	msm_mux_gpio,
> +	msm_mux_gsm0_tx,
> +	msm_mux_key_focus,
> +	msm_mux_key_snapshot,
> +	msm_mux_key_volp,
> +	msm_mux_ldo_en,
> +	msm_mux_ldo_update,
> +	msm_mux_lpass_slimbus,
> +	msm_mux_lpass_slimbus0,
> +	msm_mux_lpass_slimbus1,
> +	msm_mux_m_voc,
> +	msm_mux_mag_int,
> +	msm_mux_mdp_vsync,
> +	msm_mux_mipi_dsi0,
> +	msm_mux_modem_tsync,
> +	msm_mux_nav_pps,
> +	msm_mux_nav_pps_in_a,
> +	msm_mux_nav_pps_in_b,
> +	msm_mux_nav_tsync,
> +	msm_mux_nfc_pwr,
> +	msm_mux_ov_ldo,
> +	msm_mux_pa_indicator,
> +	msm_mux_pbs0,
> +	msm_mux_pbs1,
> +	msm_mux_pbs2,
> +	msm_mux_pri_mi2s,
> +	msm_mux_pri_mi2s_mclk_a,
> +	msm_mux_pri_mi2s_mclk_b,
> +	msm_mux_pri_mi2s_ws,
> +	msm_mux_prng_rosc,
> +	msm_mux_pwr_crypto_enabled_a,
> +	msm_mux_pwr_crypto_enabled_b,
> +	msm_mux_pwr_modem_enabled_a,
> +	msm_mux_pwr_modem_enabled_b,
> +	msm_mux_pwr_nav_enabled_a,
> +	msm_mux_pwr_nav_enabled_b,
> +	msm_mux_qdss_cti_trig_in_a0,
> +	msm_mux_qdss_cti_trig_in_a1,
> +	msm_mux_qdss_cti_trig_in_b0,
> +	msm_mux_qdss_cti_trig_in_b1,
> +	msm_mux_qdss_cti_trig_out_a0,
> +	msm_mux_qdss_cti_trig_out_a1,
> +	msm_mux_qdss_cti_trig_out_b0,
> +	msm_mux_qdss_cti_trig_out_b1,
> +	msm_mux_qdss_traceclk_a,
> +	msm_mux_qdss_traceclk_b,
> +	msm_mux_qdss_tracectl_a,
> +	msm_mux_qdss_tracectl_b,
> +	msm_mux_qdss_tracedata_a,
> +	msm_mux_qdss_tracedata_b,
> +	msm_mux_sd_write,
> +	msm_mux_sdcard_det,
> +	msm_mux_sec_mi2s,
> +	msm_mux_sec_mi2s_mclk_a,
> +	msm_mux_sec_mi2s_mclk_b,
> +	msm_mux_sensor_rst,
> +	msm_mux_smb_int,
> +	msm_mux_ssbi_wtr1,
> +	msm_mux_ts_resout,
> +	msm_mux_ts_sample,
> +	msm_mux_uim1_clk,
> +	msm_mux_uim1_data,
> +	msm_mux_uim1_present,
> +	msm_mux_uim1_reset,
> +	msm_mux_uim2_clk,
> +	msm_mux_uim2_data,
> +	msm_mux_uim2_present,
> +	msm_mux_uim2_reset,
> +	msm_mux_uim_batt,
> +	msm_mux_us_emitter,
> +	msm_mux_us_euro,
> +	msm_mux_wcss_bt,
> +	msm_mux_wcss_fm,
> +	msm_mux_wcss_wlan,
> +	msm_mux_wcss_wlan0,
> +	msm_mux_wcss_wlan1,
> +	msm_mux_wcss_wlan2,
> +	msm_mux_webcam_rst,
> +	msm_mux_webcam_standby,
> +	msm_mux_wsa_io,
> +	msm_mux_wsa_irq,
> +	msm_mux_wsa_reset,
> +	msm_mux__,
> +};
> +
> +#define MSM_PIN_FUNCTION(fname)                         \
> +	[msm_mux_##fname] = {#fname, msm_mux_##fname}
> +
> +static const struct pinctrl_function msm8917_pinctrl_functions[] = {
> +	MSM_PIN_FUNCTION(accel_int),
> +	MSM_PIN_FUNCTION(adsp_ext),
> +	MSM_PIN_FUNCTION(alsp_int),
> +	MSM_PIN_FUNCTION(atest_bbrx0),
> +	MSM_PIN_FUNCTION(atest_bbrx1),
> +	MSM_PIN_FUNCTION(atest_char),
> +	MSM_PIN_FUNCTION(atest_char0),
> +	MSM_PIN_FUNCTION(atest_char1),
> +	MSM_PIN_FUNCTION(atest_char2),
> +	MSM_PIN_FUNCTION(atest_char3),
> +	MSM_PIN_FUNCTION(atest_combodac_to_gpio_native),
> +	MSM_PIN_FUNCTION(atest_gpsadc_dtest0_native),
> +	MSM_PIN_FUNCTION(atest_gpsadc_dtest1_native),
> +	MSM_PIN_FUNCTION(atest_tsens),
> +	MSM_PIN_FUNCTION(atest_wlan0),
> +	MSM_PIN_FUNCTION(atest_wlan1),
> +	MSM_PIN_FUNCTION(audio_ref),
> +	MSM_PIN_FUNCTION(audio_reset),
> +	MSM_PIN_FUNCTION(bimc_dte0),
> +	MSM_PIN_FUNCTION(bimc_dte1),
> +	MSM_PIN_FUNCTION(blsp6_spi),
> +	MSM_PIN_FUNCTION(blsp8_spi),
> +	MSM_PIN_FUNCTION(blsp_i2c1),
> +	MSM_PIN_FUNCTION(blsp_i2c2),
> +	MSM_PIN_FUNCTION(blsp_i2c3),
> +	MSM_PIN_FUNCTION(blsp_i2c4),
> +	MSM_PIN_FUNCTION(blsp_i2c5),
> +	MSM_PIN_FUNCTION(blsp_i2c6),
> +	MSM_PIN_FUNCTION(blsp_i2c7),
> +	MSM_PIN_FUNCTION(blsp_i2c8),
> +	MSM_PIN_FUNCTION(blsp_spi1),
> +	MSM_PIN_FUNCTION(blsp_spi2),
> +	MSM_PIN_FUNCTION(blsp_spi3),
> +	MSM_PIN_FUNCTION(blsp_spi4),
> +	MSM_PIN_FUNCTION(blsp_spi5),
> +	MSM_PIN_FUNCTION(blsp_spi6),
> +	MSM_PIN_FUNCTION(blsp_spi7),
> +	MSM_PIN_FUNCTION(blsp_spi8),
> +	MSM_PIN_FUNCTION(blsp_uart1),
> +	MSM_PIN_FUNCTION(blsp_uart2),
> +	MSM_PIN_FUNCTION(blsp_uart3),
> +	MSM_PIN_FUNCTION(blsp_uart4),
> +	MSM_PIN_FUNCTION(blsp_uart5),
> +	MSM_PIN_FUNCTION(blsp_uart6),
> +	MSM_PIN_FUNCTION(blsp_uart7),
> +	MSM_PIN_FUNCTION(blsp_uart8),
> +	MSM_PIN_FUNCTION(cam0_ldo),
> +	MSM_PIN_FUNCTION(cam1_rst),
> +	MSM_PIN_FUNCTION(cam1_standby),
> +	MSM_PIN_FUNCTION(cam2_rst),
> +	MSM_PIN_FUNCTION(cam2_standby),
> +	MSM_PIN_FUNCTION(cam_mclk),
> +	MSM_PIN_FUNCTION(cci_async),
> +	MSM_PIN_FUNCTION(cci_i2c),
> +	MSM_PIN_FUNCTION(cci_timer0),
> +	MSM_PIN_FUNCTION(cci_timer1),
> +	MSM_PIN_FUNCTION(cdc_pdm0),
> +	MSM_PIN_FUNCTION(codec_int1),
> +	MSM_PIN_FUNCTION(codec_int2),
> +	MSM_PIN_FUNCTION(codec_mad),
> +	MSM_PIN_FUNCTION(coex_uart),
> +	MSM_PIN_FUNCTION(cri_trng),
> +	MSM_PIN_FUNCTION(cri_trng0),
> +	MSM_PIN_FUNCTION(cri_trng1),
> +	MSM_PIN_FUNCTION(dbg_out),
> +	MSM_PIN_FUNCTION(dmic0_clk),
> +	MSM_PIN_FUNCTION(dmic0_data),
> +	MSM_PIN_FUNCTION(ebi_cdc),
> +	MSM_PIN_FUNCTION(ebi_ch0),
> +	MSM_PIN_FUNCTION(ext_lpass),
> +	MSM_PIN_FUNCTION(forced_usb),
> +	MSM_PIN_FUNCTION(fp_gpio),
> +	MSM_PIN_FUNCTION(fp_int),
> +	MSM_PIN_FUNCTION(gcc_gp1_clk_a),
> +	MSM_PIN_FUNCTION(gcc_gp1_clk_b),
> +	MSM_PIN_FUNCTION(gcc_gp2_clk_a),
> +	MSM_PIN_FUNCTION(gcc_gp2_clk_b),
> +	MSM_PIN_FUNCTION(gcc_gp3_clk_a),
> +	MSM_PIN_FUNCTION(gcc_gp3_clk_b),
> +	MSM_PIN_FUNCTION(gcc_plltest),
> +	MSM_PIN_FUNCTION(gcc_tlmm),
> +	MSM_PIN_FUNCTION(gpio),
> +	MSM_PIN_FUNCTION(gsm0_tx),
> +	MSM_PIN_FUNCTION(key_focus),
> +	MSM_PIN_FUNCTION(key_snapshot),
> +	MSM_PIN_FUNCTION(key_volp),
> +	MSM_PIN_FUNCTION(ldo_en),
> +	MSM_PIN_FUNCTION(ldo_update),
> +	MSM_PIN_FUNCTION(lpass_slimbus),
> +	MSM_PIN_FUNCTION(lpass_slimbus0),
> +	MSM_PIN_FUNCTION(lpass_slimbus1),
> +	MSM_PIN_FUNCTION(m_voc),
> +	MSM_PIN_FUNCTION(mag_int),
> +	MSM_PIN_FUNCTION(mdp_vsync),
> +	MSM_PIN_FUNCTION(mipi_dsi0),
> +	MSM_PIN_FUNCTION(modem_tsync),
> +	MSM_PIN_FUNCTION(nav_pps),
> +	MSM_PIN_FUNCTION(nav_pps_in_a),
> +	MSM_PIN_FUNCTION(nav_pps_in_b),
> +	MSM_PIN_FUNCTION(nav_tsync),
> +	MSM_PIN_FUNCTION(nfc_pwr),
> +	MSM_PIN_FUNCTION(ov_ldo),
> +	MSM_PIN_FUNCTION(pa_indicator),
> +	MSM_PIN_FUNCTION(pbs0),
> +	MSM_PIN_FUNCTION(pbs1),
> +	MSM_PIN_FUNCTION(pbs2),
> +	MSM_PIN_FUNCTION(pri_mi2s),
> +	MSM_PIN_FUNCTION(pri_mi2s_mclk_a),
> +	MSM_PIN_FUNCTION(pri_mi2s_mclk_b),
> +	MSM_PIN_FUNCTION(pri_mi2s_ws),
> +	MSM_PIN_FUNCTION(prng_rosc),
> +	MSM_PIN_FUNCTION(pwr_crypto_enabled_a),
> +	MSM_PIN_FUNCTION(pwr_crypto_enabled_b),
> +	MSM_PIN_FUNCTION(pwr_modem_enabled_a),
> +	MSM_PIN_FUNCTION(pwr_modem_enabled_b),
> +	MSM_PIN_FUNCTION(pwr_nav_enabled_a),
> +	MSM_PIN_FUNCTION(pwr_nav_enabled_b),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
> +	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
> +	MSM_PIN_FUNCTION(qdss_traceclk_a),
> +	MSM_PIN_FUNCTION(qdss_traceclk_b),
> +	MSM_PIN_FUNCTION(qdss_tracectl_a),
> +	MSM_PIN_FUNCTION(qdss_tracectl_b),
> +	MSM_PIN_FUNCTION(qdss_tracedata_a),
> +	MSM_PIN_FUNCTION(qdss_tracedata_b),
> +	MSM_PIN_FUNCTION(sd_write),
> +	MSM_PIN_FUNCTION(sdcard_det),
> +	MSM_PIN_FUNCTION(sec_mi2s),
> +	MSM_PIN_FUNCTION(sec_mi2s_mclk_a),
> +	MSM_PIN_FUNCTION(sec_mi2s_mclk_b),
> +	MSM_PIN_FUNCTION(sensor_rst),
> +	MSM_PIN_FUNCTION(smb_int),
> +	MSM_PIN_FUNCTION(ssbi_wtr1),
> +	MSM_PIN_FUNCTION(ts_resout),
> +	MSM_PIN_FUNCTION(ts_sample),
> +	MSM_PIN_FUNCTION(uim1_clk),
> +	MSM_PIN_FUNCTION(uim1_data),
> +	MSM_PIN_FUNCTION(uim1_present),
> +	MSM_PIN_FUNCTION(uim1_reset),
> +	MSM_PIN_FUNCTION(uim2_clk),
> +	MSM_PIN_FUNCTION(uim2_data),
> +	MSM_PIN_FUNCTION(uim2_present),
> +	MSM_PIN_FUNCTION(uim2_reset),
> +	MSM_PIN_FUNCTION(uim_batt),
> +	MSM_PIN_FUNCTION(us_emitter),
> +	MSM_PIN_FUNCTION(us_euro),
> +	MSM_PIN_FUNCTION(wcss_bt),
> +	MSM_PIN_FUNCTION(wcss_fm),
> +	MSM_PIN_FUNCTION(wcss_wlan),
> +	MSM_PIN_FUNCTION(wcss_wlan0),
> +	MSM_PIN_FUNCTION(wcss_wlan1),
> +	MSM_PIN_FUNCTION(wcss_wlan2),
> +	MSM_PIN_FUNCTION(webcam_rst),
> +	MSM_PIN_FUNCTION(webcam_standby),
> +	MSM_PIN_FUNCTION(wsa_io),
> +	MSM_PIN_FUNCTION(wsa_irq),
> +	MSM_PIN_FUNCTION(wsa_reset),
> +};
> +
> +static const msm_pin_function msm8917_pin_functions[] = {
> +	PINGROUP(0, blsp_spi1, blsp_uart1, qdss_tracedata_b, _, _, _, _,
> +		 _, _),
> +	PINGROUP(1, blsp_spi1, blsp_uart1, adsp_ext, _, _, _, _, _,
> +		 qdss_tracedata_b),
> +	PINGROUP(2, blsp_spi1, blsp_uart1, blsp_i2c1, prng_rosc, _, _, _,
> +		 _, _),
> +	PINGROUP(3, blsp_spi1, blsp_uart1, blsp_i2c1, _, _, _, _, _, _),
> +	PINGROUP(4, blsp_spi2, blsp_uart2, ldo_update, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _),
> +	PINGROUP(5, blsp_spi2, blsp_uart2, ldo_en, _, _, _, _, _, _),
> +	PINGROUP(6, blsp_spi2, blsp_uart2, blsp_i2c2, gcc_gp1_clk_b,
> +		 qdss_tracedata_b, _, _, _, _),
> +	PINGROUP(7, blsp_spi2, blsp_uart2, blsp_i2c2, pbs2, _,
> +		 qdss_tracedata_b, _, atest_gpsadc_dtest0_native, _),
> +	PINGROUP(8, blsp_spi3, blsp_uart3, pbs0, _, _, _, _, _, _),
> +	PINGROUP(9, blsp_spi3, blsp_uart3, pbs1, pwr_modem_enabled_b, _, _,
> +		 _, _, _),
> +	PINGROUP(10, blsp_spi3, blsp_uart3, blsp_i2c3, gcc_gp2_clk_b, _, _,
> +		 _, _, _),
> +	PINGROUP(11, blsp_spi3, blsp_uart3, blsp_i2c3, gcc_gp3_clk_b, _, _,
> +		 _, _, _),
> +	PINGROUP(12, blsp_spi4, blsp_uart4, sec_mi2s, pwr_nav_enabled_b, _,
> +		 _, _, _, _),
> +	PINGROUP(13, blsp_spi4, blsp_uart4, sec_mi2s, pwr_crypto_enabled_b, _,
> +		 _, _, _, _),
> +	PINGROUP(14, blsp_spi4, blsp_uart4, blsp_i2c4, _, _, _, _, _, _),
> +	PINGROUP(15, blsp_spi4, blsp_uart4, blsp_i2c4, _, _, _, _, _, _),
> +	PINGROUP(16, blsp_spi5, blsp_uart5, _, _, _, _, qdss_traceclk_a,
> +		 _, atest_bbrx1),
> +	PINGROUP(17, blsp_spi5, blsp_uart5, m_voc, qdss_cti_trig_in_a0, _,
> +		 atest_bbrx0, _, _, _),
> +	PINGROUP(18, blsp_spi5, blsp_uart5, blsp_i2c5, qdss_tracectl_a, _,
> +		 atest_gpsadc_dtest1_native, _, _, _),
> +	PINGROUP(19, blsp_spi5, blsp_uart5, blsp_i2c5, qdss_tracedata_a, _,
> +		 _, _, _, _),
> +	PINGROUP(20, blsp_spi6, blsp_uart6, _, _, _, _, _, _,
> +		 qdss_tracectl_b),
> +	PINGROUP(21, blsp_spi6, blsp_uart6, m_voc, _, _, _, _, _,
> +		 qdss_cti_trig_in_b0),
> +	PINGROUP(22, blsp_spi6, blsp_uart6, blsp_i2c6, qdss_traceclk_b, _,
> +		 atest_wlan0, _, _, _),
> +	PINGROUP(23, blsp_spi6, blsp_uart6, blsp_i2c6, qdss_tracedata_b, _,
> +		 atest_wlan1, _, _, _),
> +	PINGROUP(24, mdp_vsync, _, _, _, _, _, _, _, _),
> +	PINGROUP(25, mdp_vsync, pri_mi2s_mclk_a, sec_mi2s_mclk_a, _, _, _,
> +		 _, _, _),
> +	PINGROUP(26, cam_mclk, _, _, _, _, _, qdss_tracedata_a, _, _),
> +	PINGROUP(27, cam_mclk, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(28, cam_mclk, _, _, _, _, _, qdss_tracedata_a, _,
> +		 atest_combodac_to_gpio_native),
> +	PINGROUP(29, cci_i2c, pwr_modem_enabled_a, _, _, _, _, _,
> +		 qdss_tracedata_a, _),
> +	PINGROUP(30, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(31, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(32, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(33, cci_timer0, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(34, cci_timer1, _, _, _, _, _, _, _, qdss_tracedata_a),
> +	PINGROUP(35, pwr_nav_enabled_a, _, _, _, _, _, _, _,
> +		 qdss_tracedata_a),
> +	PINGROUP(36, pwr_crypto_enabled_a, _, _, _, _, _, _, _,
> +		 qdss_tracedata_a),
> +	PINGROUP(37, _, _, _, _, _, qdss_cti_trig_out_b1, _, _, _),
> +	PINGROUP(38, _, qdss_tracedata_a, _, _, _, _, _, _, _),
> +	PINGROUP(39, cci_async, _, _, _, _, _, qdss_tracedata_a, _,
> +		 atest_combodac_to_gpio_native),
> +	PINGROUP(40, _, _, _, _, qdss_tracedata_a, _,
> +		 atest_combodac_to_gpio_native, _, _),
> +	PINGROUP(41, sd_write, _, _, _, _, _, _, _,
> +		 atest_combodac_to_gpio_native),
> +	PINGROUP(42, gcc_gp1_clk_a, qdss_tracedata_b, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _, _),
> +	PINGROUP(43, gcc_gp2_clk_a, qdss_tracedata_b, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _, _),
> +	PINGROUP(44, gcc_gp3_clk_a, qdss_tracedata_b, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _, _),
> +	PINGROUP(45, _, _, atest_combodac_to_gpio_native, _, _, _, _, _,
> +		 _),
> +	PINGROUP(46, _, _, atest_combodac_to_gpio_native, _, _, _, _, _,
> +		 _),
> +	PINGROUP(47, blsp6_spi, _, qdss_tracedata_b, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _),
> +	PINGROUP(48, _, qdss_cti_trig_in_b1, _,
> +		 atest_combodac_to_gpio_native, _, _, _, _, _),
> +	PINGROUP(49, uim_batt, _, _, _, _, _, _, _, _),
> +	PINGROUP(50, qdss_tracedata_a, _, _, _, _, _, _, _, _),
> +	PINGROUP(51, uim1_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(52, uim1_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(53, uim1_reset, _, _, _, _, _, _, _, _),
> +	PINGROUP(54, uim1_present, _, _, _, _, _, _, _, _),
> +	PINGROUP(55, uim2_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(56, uim2_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(57, uim2_reset, _, _, _, _, _, _, _, _),
> +	PINGROUP(58, uim2_present, _, _, _, _, _, _, _, _),
> +	PINGROUP(59, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(60, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(61, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(62, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(63, atest_char3, dbg_out, bimc_dte0, _, _, _, _, _, _),
> +	PINGROUP(64, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(65, bimc_dte0, _, _, _, _, _, _, _, _),
> +	PINGROUP(66, sec_mi2s_mclk_b, pri_mi2s, _, qdss_tracedata_b, _, _,
> +		 _, _, _),
> +	PINGROUP(67, atest_char1, ebi_cdc, _, atest_combodac_to_gpio_native,
> +		 _, _, _, _, _),
> +	PINGROUP(68, atest_char0, _, _, _, _, _, _, _, _),
> +	PINGROUP(69, audio_ref, cdc_pdm0, pri_mi2s_mclk_b, ebi_cdc, _, _, _,
> +		 _, _),
> +	PINGROUP(70, lpass_slimbus, cdc_pdm0, _, _, _, _, _, _, _),
> +	PINGROUP(71, lpass_slimbus0, cdc_pdm0, _, _, _, _, _, _, _),
> +	PINGROUP(72, lpass_slimbus1, cdc_pdm0, _, _, _, _, _, _, _),
> +	PINGROUP(73, cdc_pdm0, _, _, _, _, _, _, _, _),
> +	PINGROUP(74, cdc_pdm0, _, _, _, _, _, _, _, _),
> +	PINGROUP(75, wcss_bt, atest_char2, _, ebi_ch0, _, _, _, _, _),
> +	PINGROUP(76, wcss_wlan2, _, _, _, _, _, _, _, _),
> +	PINGROUP(77, wcss_wlan1, _, _, _, _, _, _, _, _),
> +	PINGROUP(78, wcss_wlan0, _, _, _, _, _, _, _, _),
> +	PINGROUP(79, wcss_wlan, _, _, _, _, _, _, _, _),
> +	PINGROUP(80, wcss_wlan, _, _, _, _, _, _, _, _),
> +	PINGROUP(81, wcss_fm, ext_lpass, _, _, _, _, _, _, _),
> +	PINGROUP(82, wcss_fm, cri_trng, _, _, _, _, _, _, _),
> +	PINGROUP(83, wcss_bt, cri_trng1, _, _, _, _, _, _, _),
> +	PINGROUP(84, wcss_bt, cri_trng0, _, _, _, _, _, _, _),
> +	PINGROUP(85, pri_mi2s, blsp_spi7, blsp_uart7, _, _, _, _, _, _),
> +	PINGROUP(86, pri_mi2s, blsp_spi7, blsp_uart7, qdss_tracedata_b, _, _,
> +		 _, _, _),
> +	PINGROUP(87, pri_mi2s_ws, blsp_spi7, blsp_uart7, blsp_i2c7,
> +		 qdss_tracedata_b, gcc_tlmm, _, _, _),
> +	PINGROUP(88, pri_mi2s, blsp_spi7, blsp_uart7, blsp_i2c7, _, _, _,
> +		 _, _),
> +	PINGROUP(89, dmic0_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(90, dmic0_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(91, _, _, _, _, _, qdss_cti_trig_in_a1, _, _, _),
> +	PINGROUP(92, _, _, _, _, _, qdss_tracedata_b, _, _, _),
> +	PINGROUP(93, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(94, wsa_io, sec_mi2s, pri_mi2s, _, _, _, _, _, _),
> +	PINGROUP(95, wsa_io, sec_mi2s, pri_mi2s, _, _, _, _, _, _),
> +	PINGROUP(96, blsp_spi8, blsp_uart8, _, _, _, _, _, _, _),
> +	PINGROUP(97, blsp_spi8, blsp_uart8, _, _, _, _, _, _, _),
> +	PINGROUP(98, blsp_spi8, blsp_uart8, blsp_i2c8, gcc_plltest, _, _, _,
> +		 _, _),
> +	PINGROUP(99, blsp_spi8, blsp_uart8, blsp_i2c8, gcc_plltest, _, _, _,
> +		 _, _),
> +	PINGROUP(100, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(101, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(102, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(103, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(104, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(105, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(106, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(107, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(108, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(109, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(110, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(111, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(112, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(113, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(114, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(115, _, _, nav_pps_in_a, _, atest_combodac_to_gpio_native,
> +		 _, _, _, _),
> +	PINGROUP(116, _, pa_indicator, _, _, _, _, _, _, _),
> +	PINGROUP(117, _, modem_tsync, nav_tsync, nav_pps_in_b, nav_pps, _,
> +		 _, _, _),
> +	PINGROUP(118, _, ebi_cdc, _, _, _, _, _, _, _),
> +	PINGROUP(119, gsm0_tx, _, ebi_cdc, _, _, _, _, _, _),
> +	PINGROUP(120, _, atest_char, ebi_cdc, _, atest_tsens, _, _, _, _),
> +	PINGROUP(121, _, _, _, bimc_dte1, _, _, _, _, _),
> +	PINGROUP(122, _, ssbi_wtr1, _, _, bimc_dte1, _, _, _, _),
> +	PINGROUP(123, _, ssbi_wtr1, ebi_cdc, _, _, _, _, _, _),
> +	PINGROUP(124, coex_uart, _, _, _, _, _, _, _, _),
> +	PINGROUP(125, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(126, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(127, coex_uart, _, _, _, _, _, _, _, _),
> +	PINGROUP(128, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(129, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(130, blsp8_spi, _, _, _, _, _, _, _, _),
> +	PINGROUP(131, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(132, qdss_cti_trig_out_a0, _, _, _, _, _, _, _, _),
> +	PINGROUP(133, qdss_cti_trig_out_a1, _, _, _, _, _, _, _, _)
> +};
> +
> +static const struct msm_special_pin_data msm8917_special_pins_data[] = {
> +	SDC_PINGROUP("sdc1_clk", 0x10a000, 13, 6),
> +	SDC_PINGROUP("sdc1_cmd", 0x10a000, 11, 3),
> +	SDC_PINGROUP("sdc1_data", 0x10a000, 9, 0),
> +	SDC_PINGROUP("sdc1_rclk", 0x10a000, 15, 0),
> +	SDC_PINGROUP("sdc2_clk", 0x109000, 14, 6),
> +	SDC_PINGROUP("sdc2_cmd", 0x109000, 11, 3),
> +	SDC_PINGROUP("sdc2_data", 0x109000, 9, 0),
> +	SDC_PINGROUP("qdsd_clk", 0x19c000, 3, 0),
> +	SDC_PINGROUP("qdsd_cmd", 0x19c000, 8, 5),
> +	SDC_PINGROUP("qdsd_data0", 0x19c000, 13, 10),
> +	SDC_PINGROUP("qdsd_data1", 0x19c000, 18, 15),
> +	SDC_PINGROUP("qdsd_data2", 0x19c000, 23, 20),
> +	SDC_PINGROUP("qdsd_data3", 0x19c000, 28, 25),
> +};
> +
> +#define N_GPIO		ARRAY_SIZE(msm8917_pin_functions)
> +#define N_SPECIAL	ARRAY_SIZE(msm8917_special_pins_data)
> +
> +static int msm8917_get_function_mux(unsigned int pin, unsigned int selector)
> +{
> +	unsigned int i;
> +	const msm_pin_function *func;
> +
> +	if (pin >= N_GPIO)
> +		return -EINVAL;
> +
> +	func = msm8917_pin_functions + pin;
> +
> +	for (i = 0; i < 10; i++)
> +		if ((*func)[i] == selector)
> +			return i;
> +
> +	pr_err("Can't find requested function for pin %u\n", pin);
> +
> +	return -EINVAL;
> +}
> +
> +static const char *msm8917_get_function_name(struct udevice *dev,
> +					     unsigned int selector)
> +{
> +	return msm8917_pinctrl_functions[selector].name;
> +}
> +
> +static const char *msm8917_get_pin_name(struct udevice *dev,
> +					unsigned int selector)
> +{
> +	if (selector >= N_GPIO)
> +		return msm8917_special_pins_data[selector - N_GPIO].name;

Can we have an error check in case selector >= N_GPIO + N_SPECIAL?

Regards,

Balaji

> +
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static const struct msm_pinctrl_data msm8917_data = {
> +	.pin_data = {
> +		.pin_count = N_GPIO + N_SPECIAL,
> +		.special_pins_start = N_GPIO,
> +		.special_pins_data = msm8917_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(msm8917_pinctrl_functions),
> +	.get_function_name = msm8917_get_function_name,
> +	.get_function_mux = msm8917_get_function_mux,
> +	.get_pin_name = msm8917_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{
> +		.compatible = "qcom,msm8917-pinctrl",
> +		.data = (ulong)&msm8917_data
> +	},
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_msm8917) = {
> +	.name		= "pinctrl_msm8917",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.bind		= msm_pinctrl_bind,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};
