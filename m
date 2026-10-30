Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81291606A327
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C6jlyX0T;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgyOzgtC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UvHw+kbF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FFA8810B5;
	Fri, 30 Oct 2026 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtouXCgnnnJv; Fri, 30 Oct 2026 08:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20BEC81082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350072;
	b=h5JiEpvfbccxQEhwjKVX5JfBQyMvhLENJmQm8FnaZXKT2eWAKXWxwZGBhoQ8LZIEF/1+
	 XDSlnzz330Nx7MkRbE0+H5KqMUc2L6KQeo0hLAOlJdXxXXnRyArwrkAthNJkmTDzQ0Gq7
	 vepuMOHdang0PDorW07sfz8cEJninIfNI20Ik1AtRBPqT7PwJxN9rXAJgImUz6e2imcaL
	 aX8tQ1J86McfA29tZwFDZpYyW9ifQc4kGtLNcifUX1ITwFCmdzfbRqiuw+pDDj9X0OtPt
	 CboH6bxM/vyqaL444Arb7IMiVEIESQ5syHukf7cu5fL25T7PqR2WvH4TXarMHcA3fjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=;
	b=ggvTSRcy/JBaIoJOHTPcHzZ1TcwC8QmWlZq3YSrNNOonvN0fzt+H3hA/gCZo4/XffrE4
	 Q5nKtsKvMKRh8JRL48SY1hv2unmDSJpAH7Uwnb77Un5qbqcFINe7Z+NWU1kUuZwuA4Uqq
	 XhjSqg9zF1bvoGxfOV5+NGWL/KbD7ShdrOKGNHjYO5dJV8PrCXqGsQ2L39gMEdQKuTGEo
	 VEtYhoCH+F5HcaPEY2w9jpBUYRHuV1NXezqZZt29eQjNVqjL79h6wKZxlmCt2/x9NygOx
	 8zcR6PttrhAhyyeGnbsVFg8UKwl6AcG5yce3SpiqTFReSFXiY35lXlCd2acyLY/j2+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793350072;
	bh=U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6jlyX0TMVKm7OuwPJH+oJtNsMi5CIXDjtTtxeqmVo/VZ09Ruxu3R+q1vuIUqd7EK
	 Suanr5lzz3nUq+Yz6X/1e57YUd1SJNCdDlFRG9CKFkFU9WjsmAJAntCE97kMppSawA
	 6n9lDYoNqjbBa0AXPGpWBxhP1Qtccr9HDfMBG0T/Itp2e/lCI2JSyQWqXZdw5Gg+4n
	 1IQnW7GLOx48E7ZBcb/EMIJKvzg3g7ZU7hmrOnvOF0MYnl6TQHlUZN5njMv69BSQcn
	 LCG2EXuEuUQuH+0AnCgxOiRX7awT1EVszbcVIGmQXv8J36BPGtPZzQ8Vhm4cCMVRwV
	 54JRpC1rejYgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20BEC81082;
	Fri, 30 Oct 2026 08:47:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86D332C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CCD74010C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cc7Lc0zSRxqH for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 745C2400EF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350069;
 b=ElbLgK3siQ8V5VQ5ZVqVh9MDk2YTtMg/9Z/h7yIKphuyVO14sfrvsuWufm/y5IBoMCWa
 b1MOwf3UeB2wl1WMQ8Z6pvpI5WVMx+iqcfdMx5+Ggz3a2XL7PJYZLZF6lkkB4jXJnmVlp
 Z8jwfJIhMYvLSozcz4ejRmumBc5aHTr8lpijac0LRxVJAOpeG6fx/0T9Qvg0TfVsIvYw1
 CBkqjqKOarJtuPKvBdEA08oEI4DrlNBAicJAGNUV7x+zfy89BgsUdwhhvjUXoRVUr8OJB
 eLTaM1ThssYaD1RTBKQUtF3G00CnVYoEqYEmM7Dquq33UROgJEmX/ObUKJz+dLFGg2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350069;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=;
 b=AxsvttUZLfVSKdLLCjrwcF7kwp2XCCkXZnzvmYfU/i1nmXJG4C/6+xevGFQUnhqhJ4eU
 6zRlqW2THK29Poki8Oo1/cWsfpOcT5LsXFTQ8KkXEReQB7O17iCdUsi8aoAc8sXMBQhRQ
 jSAM2/bKz5ywz76SZIfcPzR8eiwok+62FpZgWMnl+dN21q4ab3vMJeS4IcJB0JSYDjAfH
 VKkBOzO5TsPebxvNsIcmGPTM19ok4i/0togEd4o0pBS8U/mE+Uq4/CpMIrHJB1kWlcfLa
 6w1wrSv6AKViElNcVWs5JCVz/blKLAYDgiV+QM0hhFBFD64FukxIMlsD3bycOWLgpRg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NgyOzgtC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UvHw+kbF; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NgyOzgtC; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UvHw+kbF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 745C2400EF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:47:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8FhYg1666049
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=; b=NgyOzgtCGL4cm7tj
 Z/PS/CV8ZlYq3a/7t6dbAGuxVR8FwLstbtMZP0nljAuCcoOkoJSuFcbU2vNj2zX0
 uWGx7WJWYiT5AS6E7UMi2B/D1pk04+Y3us43oLPrieIphKyK5yiPBAgrJm2HwxFP
 njsIxHQqJGwLWjRKOePpnHxD6Lhc78lPKMGSc85EhA4qLfE3Ulge4n5aBm882akb
 cISanoo3+5C0WZ9/JD7FIz3kUB1etO32qQ3ox9WKPYKfFBi5mIAhyUXGkI2UAMoT
 4+WLoCLXBzirvGDAqPlk5UMWBoFGonMt6ub5RuKrqbWvgDCkEQqSlOdyaM2VyJlT
 A9biOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p24dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:47:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so1086052eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793350066; x=1793954866;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=;
 b=UvHw+kbFiR2ofQZAFDkuR/2vRkIPwSGZSl1PQah1OTnjgbjGijLK54Mghmi5bCjyvz
 fXDaY8Zj8pRH+/cscAe5+rX9+AmSvoRkz9syKSeq2PO26eXyWfvHCfEFq1AixQ009BBg
 AZgNaJHyB2U1GpEq2ItLAQCNtaHneq0fCDrG5/cYQq1xx5FrMLyuBwjdvpcaM6bgYD3e
 o0kWHQO9ryOrW2XBBX7HsHScEQT/QGNsX/LZT/k+/QchiRuI4yB0Ks6UIu2Aa46mLf2a
 D51abglP8x66vPZQyOCdGfbSodJaaZKzKB2s6u3DXQupljRCd/6+ltX7LK7+ZSb0ncV7
 Dmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350066; x=1793954866;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U70WA8jnzZ2PPk3gKeLLQmn19jPQHlsnHGONPeHuw1I=;
 b=lc6XZ85ieyLopbV6kdj4K3SEtFxdrag3+HrkTwT8NgonbNDi3pNph/yIluhe+tM5AE
 YHq0lKJrlyBONlWzNS9VK84NEop7mwm9cUmVJU6RHMmGMVfin+hF9Yso5VycV9uMApyC
 GIP659CZJ8e1elfZpaeIoVm4w1Du4ueH42xBbpJptoGpVQAkuMWIfeoe/vxs4yv/Zmkz
 IGQoEcAs/qqExEgx182svvL926j5gF68ErXvFgi8mggl3eqDfKk5fUlIGBwXobt3q+sg
 YnNzdu7qq5FN23/WZU6B+dWCd+PjIfiQ+4jspuGWJPEBqKUccLw84aVtPM9RykzIQKhg
 J+3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtxVYVAie+kHNAsXANqrcvuWn3kjOY5/3ynf0ZLS5VqTDHiah3enjKQu/JAJG8LtlbhDjoqcc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIPrVc7kmbqGkFRHN9R4C/AjgzQKXGbgZm+pIWxCKroQLavhw1T
 SeljfAAVl5uRYF96bkrms/bXH8Ws9JGqb9PHlmQL9WCyb9F96hM6MK6UbkIR/yxaJjg0Mq7hNKp
 KQiYKYwiu5dcWLcKF3t8WTGQ5DC4u3y6RuwTNNh0LANqd2LPG9BSKMp1gGyj/OHKebC5Pi4s=
X-Gm-Gg: AYBFou25jrMu4YqIF+Ma0B7LX2pVvC23N5uhvhmLQko6/uj7maV0z5gVw4BxGuQXnv9
 sHm54PVEnKPZxiQ3aGs0J56lXE278WVriL2t4bxrUYMep3wQMXOhY1P7Ig8HAv84ECsssSiI36d
 lxUj9EV9qXeds0mmByugrSsq4ELvdUX8GBmETLYAnuL6vo+nRuAUXKjKRSsal0UWGYtHB0/qaeK
 Tun4+EvhNS7vX50gP3RUaJwRqALZKlAhcaZJ9LQwVkNn4jyjy1O3fCk8l7oNnwRO5SMccE/smG/
 TzV3WKVd44tdMTMpmNOgPAdIlVUtck3jZWFUkEMRmDljIRptOgz06IJg3+oBs+oo86diVu1fy3B
 HkyOAPyFhZA9/h4fLI2+gakoZsqfr1WSUl4MLV9DZaq6G8Ez32H8RM2i62neTBti5OB7g/+BRYr
 P/cA==
X-Received: by 2002:a05:693c:8105:b0:35f:2bc:82d3 with SMTP id
 5a478bee46e88-36a42378ce4mr2686762eec.15.1793350065442; 
 Fri, 30 Oct 2026 01:47:45 -0700 (PDT)
X-Received: by 2002:a05:693c:8105:b0:35f:2bc:82d3 with SMTP id
 5a478bee46e88-36a42378ce4mr2686726eec.15.1793350064773; 
 Fri, 30 Oct 2026 01:47:44 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a96172sm5101841eec.27.2026.10.30.01.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:47:44 -0700 (PDT)
Message-ID: <0381371a-de30-4540-93de-6b1278092dd4@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:17:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cdt: enable CDT for Shikra SPL
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
 <20261014125125.711084-2-abhilash.v@oss.qualcomm.com>
 <atBe05SyavP+O9Gy@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <atBe05SyavP+O9Gy@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX8G1IOTzYJacM
 XxV31uZ7O3cwlguGAGg5+98ICpz5oUKuoMThHRyIo1FE4l7lZT7EsLZQce8Bk6533/yz2dQkA7/
 uHISnMicEoo1jDWr17OHC0Bx5ap5tXA2bCUb8nMzelyqZstE4FqXB0f0jTRu9N0ddlwdSA1P7PG
 Lw+2xjSNulCOLilwUxOYBkJFX1yEmkaCh6DUbmmccsiNB0F2F/fOa5EiMQlXEV+utuRe2Y0Cj2g
 V7ndopIdW8n5++foB0qf4VDEobSQ2EnMI16OCFsn34u327gozUnvfyUsL/EdSldavoLJp8FBhwY
 3dyEFaG7zyJvay3lfRdGajaIaZmGu0yR++C44MWKsHME4bP+ai45jUZL+2kjR3FUmpQurUj6SwT
 y4z47YyZ+TdZka7N2E9Wtd7wBFq0UoV/6cSh7yX/P0jSl7bTq/+APivIbb0EbW5qvVbaTz0nQu2
 EQ05le3Mod7+d6ensrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX0Tmsway0KZSj
 VfWvn6coI2mRqt6iUfeOgrgAN9KpMi77lQhJBoGe2URkMZL+UH5eG4VmMOyyuOFZXbRqIHxAWMI
 GUcv/ZePGtwH2Sy5L2T6hJIvKlvLdkU=
X-Proofpoint-ORIG-GUID: IrjiHjQZvTfe7Ri-bw8qDdHVM-iH65vR
X-Proofpoint-GUID: IrjiHjQZvTfe7Ri-bw8qDdHVM-iH65vR
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae459b2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-Rs4W8Khsz1jTnEtkpMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Varada,

On 10/15/2026 10:34 AM, Varadarajan Narayanan wrote:
> On Wed, Oct 14, 2026 at 05:51:24AM -0700, Abhilash V wrote:
>> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>>
>> Add support for loading the Config/Chip Data Table (CDT) from eMMC
>> during the Shikra SPL boot flow and registering it with QCLIB via
>> the interface table.
>>
>> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> Add your signed off by.
>
>> ---
>>   arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>>   arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>>   arch/arm/mach-snapdragon/qclib.c            |  8 ++
>>   board/qualcomm/shikra/spl-shikra.c          | 15 ++++
>>   4 files changed, 120 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
>> index 31a06b1e002..725d0cfd1e6 100644
>> --- a/arch/arm/mach-snapdragon/board_spl.c
>> +++ b/arch/arm/mach-snapdragon/board_spl.c
>> @@ -10,6 +10,10 @@
>>   #include <dm/uclass.h>
>>   #include <hang.h>
>>   #include <init.h>
>> +#include <linux/kernel.h>
>> +#include <mach/spl.h>
>> +#include <memalign.h>
>> +#include <part.h>
>>   #include <linux/err.h>
>>   #include <mach/qclib.h>
>>   #include <spl.h>
>> @@ -38,6 +42,98 @@ void __weak qcom_spl_soc_rpm_reset(void)
>>   {
>>   }
>>
>> +#if IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)
>> +/**
>> + * qcom_spl_cdt_load() - Load the CDT from the boot medium.
>> + *
>> + * This functions read the boot medium for CDT information which gets saved
>> + * in IMEM location.
>> + *
>> + * Return: 0 on success, or a negative error code on failure.
>> + */
>> +int qcom_spl_cdt_load(void)
>> +{
>> +	struct blk_desc *desc;
>> +	struct disk_partition info;
>> +	lbaint_t blocks;
>> +	bool is_mmc;
>> +	int ret;
>> +
>> +	ret = qcom_spl_get_boot_blk_desc(&desc);
>> +	if (ret) {
>> +		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
>> +			 ret);
>> +		return ret;
>> +	}
>> +
>> +	is_mmc = desc->uclass_id == UCLASS_MMC;
>> +	if (is_mmc) {
>> +		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
>> +		if (ret)
>> +			return ret;
>> +
>> +		part_init(desc);
>> +	}
>> +
>> +#if defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_NAME)
>> +	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
>> +#elif defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_GUID)
>> +	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
>> +					 &info);
>> +#else
>> +	ret = -EINVAL;
>> +#endif
>> +	if (ret < 0) {
>> +		pr_err("CDT: partition not found (%d)\n", ret);
>> +		goto restore_hwpart;
>> +	}
>> +
>> +	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE, info.blksz);
>> +	if (blocks > info.size)
>> +		blocks = info.size;
>> +
>> +	{
>> +		ALLOC_CACHE_ALIGN_BUFFER(u8, blk_buf, blocks * info.blksz);
> Do you really want this? This will allocate the buffer on the stack.
> Can malloc_cache_aligned() be considered here?
>
>> +		size_t read_size = blocks * info.blksz;
>> +		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE,
>> +					 read_size);
>> +
>> +		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
>> +			pr_err("CDT: failed to read CDT partition\n");
>> +			ret = -EIO;
>> +			goto restore_hwpart;
>> +		}
>> +
>> +		memset((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, 0,
>> +		       CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);
> Is this needed? The next line will overwrite everything anyway (unless
> copy_size < CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE).
>
>> +		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
>> +	}
>> +
>> +	ret = 0;
>> +
>> +restore_hwpart:
>> +	/* Restore the default (user data) hardware partition, if eMMC. */
>> +	if (is_mmc) {
>> +		int rc = blk_dselect_hwpart(desc, 0);
>> +
>> +		if (rc) {
>> +			if (!ret)
>> +				ret = rc;
>> +			return ret;
>> +		}
>> +
>> +		part_init(desc);
>> +	}
>> +
>> +	return ret;
>> +}
>> +#else
>> +int qcom_spl_cdt_load(void)
>> +{
>> +	return -ENOSYS;
>> +}
>> +#endif /* IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED) */
>> +
>>   /**
>>    * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
>>    * @descp: Set to the resolved block device on success.
>> diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
>> index a32a85c48fd..ed3e5910e7a 100644
>> --- a/arch/arm/mach-snapdragon/include/mach/spl.h
>> +++ b/arch/arm/mach-snapdragon/include/mach/spl.h
>> @@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
>>   int qcom_spl_loader_pre_ddr(u8 boot_device);
>>   void qcom_spl_error_handler(void *arg);
>>   int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
>> +int qcom_spl_cdt_load(void);
>>
>>   #endif /* __SPL_H__ */
>> diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
>> index b9a74863c1c..16308e0e77f 100644
>> --- a/arch/arm/mach-snapdragon/qclib.c
>> +++ b/arch/arm/mach-snapdragon/qclib.c
>> @@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
>>   	if (ret)
>>   		return ret;
>>
>> +	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
>> +		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
>> +					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
>> +					    CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
>>   }
>>
>> diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
>> index c2a5d2d692b..98912493c88 100644
>> --- a/board/qualcomm/shikra/spl-shikra.c
>> +++ b/board/qualcomm/shikra/spl-shikra.c
>> @@ -12,6 +12,7 @@
>>   #include <dm/uclass.h>
>>   #include <init.h>
>>   #include <linux/err.h>
>> +#include <linux/kernel.h>
>>   #include <linux/sizes.h>
>>   #include <linux/string.h>
>>   #include <malloc.h>
>> @@ -333,6 +334,12 @@ fail:
>>   		reset_cpu();
>>   }
>>   #endif
>> +
>> +/**
>> + * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
>> + *
>> + * Adds Shikra-specific blobs/entries to the QCLIB interface table.
>> + */
>>   int qcom_spl_soc_qclib_override(struct interface_table *table,
>>   				const void *fit, int images_node)
>>   {
>> @@ -381,8 +388,16 @@ void qcom_spl_soc_shrm_reset(void)
>>
>>   int qcom_spl_soc_pre_qclib_routine(void)
>>   {
>> +	int ret;
>> +
>>   	qcom_spl_soc_shrm_reset();
>>
>> +	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
>> +		ret = qcom_spl_cdt_load();
>> +		if (ret)
>> +			return ret;
> Just 'return qcom_spl_cdt_load();' would suffice. Can remove 'ret'
> declaration also.
>
> -Varada
>
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> --
>> 2.34.1
>>
>> Addressed this comment in v3:
>> https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/ 
>>
>> Regards,
>> Abhilash V
