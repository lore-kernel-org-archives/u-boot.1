Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5439CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E8F6810E2;
	Fri,  9 Oct 2026 18:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9scw2F_TjLJ; Fri,  9 Oct 2026 18:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99736813C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569655;
	b=j8MqyIvueDQV1AI/CxdKBBvkWJUBBYtNCWLN35JAAMFkgTf9WQgbAbo9ZPyH2BWPOBRn
	 HSZOfJnB2zD4qn7ZxSEEtL4INvxSOmuPF83r6zbBG9WAmb0C+gP9lug1HRWiLTnXYhBPr
	 9EslYEnJZAMvgJ2MhwHGBAftj24Ao/kaov58j0LrqQhutEAHdm+uUqlfhKdpmFxcFnMbR
	 6Oz5Nh5h7u7WaPlLnbHcmukHBK/BdxXruxekJWN5NDS0MJjHrhG1GPK9BN0dDicI6JL3L
	 WOZkzMBIghNa6pFMPd/aqWOFO6T+zDUe5VvDPUoofDD+gUHfU3g1D/tkzCZ9tQDphXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wKr+CVbzz7zZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=;
	b=Cc5KEXX1fLYQzihMcelcezRT3aVb9LRRr0RdNmvE5lYxCPx9G1DPjF3RYKK+C8cvfkkX
	 sFhTwb7qxgoBzXQo0j5TprRjdHjEUBeO87O5epw8B9c/4TjVtDEse170T9uVOZayeM0N7
	 EokE63f+tNmR+hsjq0x4syaUo54uxfPsN0rLty+xS2DVmYQ+fEsxaqP1Qv/eAF2lwSt2O
	 kaFjxWYEUJIx4TJqnsnHPRDvkA1gONSSqKOjHFa8edgErqeQ+WYaKLpxR9EeKw2mRFtD0
	 zDEqA21f1io9EVTyv8pXrzrI1TAZQy0CNRLG8Cspd2tfGuvfnMgdz542kYAQ93xT9CQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569655;
	bh=wKr+CVbzz7zZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFVBvwwxQvFG5z5w7eERzYjqCQfC+kY1ncayHGCNb2V5zin0vkZUwGpIQNnQ8pBPD
	 GAbWnC11/vK1f7GlU56OvMeozF5u5cojfbp9HK3/qs6bL6fB8hqYPb44zkqKh1jfYG
	 +OcnNFCRh142oenvUYVVo9znlCyGyVsTzd1r3GKZFFt4GH/ntEU8EFIjkihpdfyc7P
	 wBMvKndlLgNJ/a8mwz2gBExMZvOvYyco64MGVDcddCGsluyx6T4iW6z5+sQvFAAsmN
	 JLbaAJvxNFTFyu6Q4WZ1ou3HriPvlfAn7QyJ4IRfF1dOVonX1CnLUoOd4yKldCdiGo
	 taA/xb19/YdMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99736813C9;
	Fri,  9 Oct 2026 18:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5B491DE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A72C14016B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHsYJ64HJRUA for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D036E40053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569653;
 b=bnbZG6EmXrsLaGNngfgiPJhB48Hg9gyGLR9utoHapL2sw/sHa9jn4O621kQwNGp2s8R3
 pLUu8/R+JTphQnk4rvMke1/+52K2hH5aRkrXkwvPhYGTJipK0d6he6khx0fRzDkAkm5Fu
 InCEW1862zWSVR6z+YxC9ukaVjmIC4a0XPwlJ+cONpkq5dw/KOr9f/N/zNgt3kph+wf/z
 aJ+dHwzLh8CT1Jte+vqypT0nB/bZv2nJ8elaIxth+M1/u9IsesuAjRp5iskLpJgq0dgWu
 tq0ZR9VCpTGIjgHJhSETv/8zkMYYKRDLjQndAN3im4XM8NlypsVXUhilS7ni7y496Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569653;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=wKr+CVbzz7zZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=;
 b=naVooIbWFHLM6QvPT1c+yIXVYgty0/Aur6VY+7y5joHYQkohjBCKjye49UpkX48IShgz
 1wTYAIpYe4xecI0L1Tr4ZiJoZLtelc9TkgDmNJu4v7hKRzKC3MglB48TFpKXib8ZtRx1X
 43obUs1xEhPkkzc0+40VcaduadyzhcCA1uSZTdVDK2fZ1t3rLiEw4h+7GY/dHf6gGg4sD
 dZWcW+PfGtJhhl5MXV1kU1ev3VVMJ6j9iSWhPnhXmuBxurDNQBlMEVUcH8lKmSe8HHFBD
 9IEovIcm0MY0vqN5mSSZktR1+hbHAyR8F715enyWaHugUr8KoWgxsgopykRGu1hCvVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="W56aaOH/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hi2zOTyZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=W56aaOH/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hi2zOTyZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D036E40053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZQEV1620112
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wKr+CVbzz7z
 ZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=; b=W56aaOH/fc7Clr7hatpn7qQaszg
 pEpi08/WvirijJ+GkFV7eowRulLK4V2fVYH7t7d8RZirnLIIoCBTjChzfht7qghj
 meEp48DGnKHDreDFK9LkaqIZwVcOgf75Btpf4yKeQEDI0t89mZbAU/vUeDbwarqF
 Eb/smtJlltBk/LMGrKFoMkDcjp9C/vtj0rqaSHBLRqGz9uxrv4YhTXjRlCw6R1rz
 f+u4VXfZpcw6AJVphs7rm+LRXx7r8ln3+j2Z7i3zu8he0u6CN6QuTaVDtmaai6u/
 3aiYe5qolXOudjXBZNZcQkFtGAWA0MXz6Uk4gU6fdSKtXFjlSU3qsLD+GWw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70505-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:14:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so117015ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569651; x=1792174451;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wKr+CVbzz7zZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=;
 b=Hi2zOTyZcJBpWzBV8nTEtEkGN8nLfXGX00GaJJh6ygxHyNxgf69nvXtNmtSnPAmnXx
 arW7OpKTK7dQMQty/Y4QhLU/8GYKRMOe5vMBQKxpHRqewHUiEiNX+Bhk39uz2RodMvpt
 vKSTFbrC2E+Xd0NR1J/eF0IR7s1NEZPdtS9A7kZGWel12pHsPRy6wNuXorYCg8SsuU6v
 34RqYolNzJcc2psZRLY0JT5b543lOuNooJ/khcqizy4xlvZvdOClo+4RbGpXrHqS1/KN
 q2PGTX9bcMRtN6oW3CSnzZe3cNqOY0Kk+6wpXkRszkMMLCQIxztKBv0XN9AuawQWbzfe
 Oo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569651; x=1792174451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wKr+CVbzz7zZjfQFtIUuU4FfIqiGnMOs8PA2HAUWWok=;
 b=bLaH5r0DQOaWdEE0x0eScypl/Ggeew50R6F2S15DDUU7oTVeu1qgdccU2JqJGxb9yd
 9K/xxVEV9pfZYmPs+k5tB/qlBhaXJNjYww32OY9LIBCvLgDbnHBS0DrZJbqjBPeYsRYZ
 qTzLd1SLqEVsc7zAWlwCqUlQ9bP5pCuuyXUTG8EW4CVUeqqGWMdDIixO9WClAUzJQ8RW
 U+n8Fcxf/oKcjveNq9Sw1BCDJH+YVFVKZZkx/rBEStMQ0aOUpmiDL3BXhuKFSPc6KIke
 8rHdp6a4FKXsI9Ibuw6mo0S393xbiDHPQe+x7QMkUxuBEkIgSGpOmm2yKtG1+E4OHfOZ
 lbSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6WnOufbacZxAmZtCheK5NVa0MayfuwZIdCMdLlKS4fn15ICrAEmVhqr+NmmMeZoRVRrcRy+c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJ6MaN/AS9zJp5qYrSPfpjim0BUf9wXvq8XNRS6N0fkDrvEB6X
 sI71D8qi+gELinav4tvX8WqkVdupBd4YTOHDFJa0nzZZIU8TtjOKkEoTEIATBK8jN8aQgpaqABX
 cxi0JO7bJzoMPXe0K6AREY4v7HNCkSVSWzghA7jm3ySWDiSIt0NOD2d3V4DggEBKV2hSElhA=
X-Gm-Gg: AYBFou3sl6bBEFozsb6/mGyOFScIKiUKXKAmDoj8htrrR5gZJiZ52hDwcw5tPydOzwX
 7xdWe7gWJ+LQuoI+PRsa+DqeQZgoO4+WDl3qQOhdJf1lTs5od/AFFNzWQZQWMP1g7HyhmKOP2Kh
 mXri4PHLMebLIhDkocDZxiZR7kCKYJsyrewGgtFnGewG3399uQb5K2E634Y3LnJGCNKS7EJJfMp
 5S/hVoOtWuyge0KCJjElOZ/omvL8XfM+yc4q4eDQUVmxt3oNsKvXz7J6Y9DN2BxErfySL4jgWx0
 c/iEzSpWqHobTA0y8h+jV9WueJIxlf/9obfwEsXJS78D4QsUJORdcGKlX4vh0eOTBlr6pp6ePuH
 XtNpFP2ukoleu+wQo+asMwBU4jcorNcCn0YTeAilJmkOWR4LUhK6I9iQfPQWwlkucgnhCsp9eh9
 MI/rkp9kw4aLtqqUe04A==
X-Received: by 2002:a17:902:f790:b0:2df:a4d8:57ad with SMTP id
 d9443c01a7336-2e842f20c98mr22600635ad.72.1791569651175; 
 Fri, 09 Oct 2026 11:14:11 -0700 (PDT)
X-Received: by 2002:a17:902:f790:b0:2df:a4d8:57ad with SMTP id
 d9443c01a7336-2e842f20c98mr22600185ad.72.1791569650631; 
 Fri, 09 Oct 2026 11:14:10 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:14:10 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 6/7] test: dm: add comprehensive tests for NVMEM bit
 field operations
Date: Fri,  9 Oct 2026 23:42:51 +0530
Message-Id: <20261009181252.2334254-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXxDl2lXUjd+Bn
 3xyUxED6u4Cixc95qT7ntzSBt/s66rUeTg19Ae1lZZe0xJb36nrt0GCtkXxCo5MZJQhkiXAExZj
 FNqo+vYQWPAaUahvCDDjS5T/noYAG+8c0WXKB0hjOBTVmPmh7lpOZLIvtsZ9YBuZwUlvuk4CKa8
 orKFSkBoftO+bb+JokW4Tw5m/Ne7Xi4nETBR49LK47CBlG6M610HnRnxC/I++OMjz4QxuycdsM7
 tw0bnFFxGLbGp1Jk7DEZk77uUNtQCEEOU62edBeGgXDe1l9JfqDeG7v9Rpy8Pd8woWQDgEjy2sX
 G0KM6k6IgG1nBwb4GEefoIMoL5bNAd2wiWldA1TQpZKUmgYgcsfHSiLcLeGfI/C7NZU0AfvUX/W
 70LDRsxIBbDKcuvmqewKH39CthuYtIRrce8GjZ0d3jHuOxGgKVuha4CTyI6iwSOzW8hKYl7sQ2h
 UTqsrkAWcS2RxlR3EXA==
X-Authority-Analysis: v=2.4 cv=Zt94uN7G c=1 sm=1 tr=0 ts=6ac92ef3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=W1BiHNyAc7_2oUjjS0wA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXyps/vU/nQ42q
 pDP7RkFiFg4NyRzY2ArE0WYYOBpnnK0alSh2aA1Bb9XgFIF9y9mWZcL1HXd7IOBVNLquM2hOwW8
 2/Z4CT9jUNnTe0EnvMQ4isLFvImZYXQ=
X-Proofpoint-GUID: wPnzUww3YW1FKUplIU0l0kZ39m02Pvt-
X-Proofpoint-ORIG-GUID: wPnzUww3YW1FKUplIU0l0kZ39m02Pvt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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

Add a mock I2C EEPROM device (nvmem-test@50) to the sandbox device tree
to support NVMEM bit field operation testing.

Add test coverage for NVMEM bit field read and write operations to
validate the new bit field support in the NVMEM subsystem.

Test cases include:
- 1-byte cell with 7-bit field (Qualcomm SDAM reboot reason use case)
- 2-byte cell with 12-bit field spanning a byte boundary
- 4-byte cell without a bit field (legacy byte-level access)
- 4-byte cell with a 16-bit field in the upper 2 bytes

Error validation tests cover:
- Bit field exceeding the cell size
- Bit field exceeding the 32-bit maximum
- Invalid bit_offset and nbits combinations
- Buffer size mismatch in non-bit-field mode

The tests verify:
- Correct bit extraction during read operations
- Read-modify-write behavior preserving unrelated bits
- Proper error handling for invalid configurations

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/sandbox/dts/test.dts |  12 +++
 test/dm/Makefile          |   1 +
 test/dm/nvmem.c           | 160 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 test/dm/nvmem.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef8147..9d1a450d09c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1054,6 +1054,11 @@
 				sandbox,filename = "i2c.bin";
 				sandbox,size = <256>;
 			};
+			emul_nvmem_test: emul-nvmem-test {
+				compatible = "sandbox,i2c-eeprom";
+				sandbox,filename = "nvmem-test.bin";
+				sandbox,size = <256>;
+			};
 			emul0: emul0 {
 				compatible = "sandbox,i2c-rtc-emul";
 			};
@@ -1081,6 +1086,13 @@
 			regulator-name = "sandbox-pmbus-vout";
 			sandbox,emul = <&emul_pmbus>;
 		};
+
+		/* Mock NVMEM device for bit field testing */
+		nvmem-test@50 {
+			reg = <0x50>;
+			compatible = "i2c-eeprom";
+			sandbox,emul = <&emul_nvmem_test>;
+		};
 	};
 
 	i3c0 {
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5dd6b57bbe8..cfe1d24fcc9 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_CMD_MUX) += mux-cmd.o
 obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
+obj-$(CONFIG_NVMEM) += nvmem.o
 obj-$(CONFIG_MTD_RAW_NAND) += nand.o
 obj-$(CONFIG_IP_DEFRAG) += net_defrag.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
diff --git a/test/dm/nvmem.c b/test/dm/nvmem.c
new file mode 100644
index 00000000000..dd8d0151d2b
--- /dev/null
+++ b/test/dm/nvmem.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for NVMEM bit field support
+ */
+
+#include <dm.h>
+#include <i2c_eeprom.h>
+#include <nvmem.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int nvmem_test_write_raw(struct udevice *dev, uint offset,
+				const void *buf, uint size)
+{
+	return i2c_eeprom_write(dev, offset, buf, size);
+}
+
+static int nvmem_test_read_raw(struct udevice *dev, uint offset,
+			       void *buf, uint size)
+{
+	return i2c_eeprom_read(dev, offset, buf, size);
+}
+
+/* Test NVMEM bit field operations */
+static int dm_test_nvmem_bitfield(struct unit_test_state *uts)
+{
+	struct udevice *nvmem_dev;
+	struct nvmem_cell cell;
+	u32 value;
+	u8 hw_value_u8;
+	u32 hw_value_u32;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_I2C_EEPROM,
+					      "nvmem-test@50", &nvmem_dev));
+
+	cell.nvmem = nvmem_dev;
+
+	/* Test reg = <0x0 0x1>; bits = <1 7>: */
+	cell.offset = 0x0;
+	cell.size = 1;
+	cell.bit_offset = 1;
+	cell.nbits = 7;
+	hw_value_u8 = 0x01;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, &hw_value_u8, 1));
+	value = 0x7f;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0x7f, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, &hw_value_u8, 1));
+	ut_asserteq(0xff, hw_value_u8);
+
+	/* Test reg = <0x18 0x4>; bits = <4 12>: Spanning byte boundary */
+	cell.offset = 0x18;
+	cell.size = 4;
+	cell.bit_offset = 4;
+	cell.nbits = 12;
+	hw_value_u32 = 0x0000000f;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	value = 0xfff;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0xfff, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	ut_asserteq(0x0000ffff, hw_value_u32);
+
+	/* Test reg = <0x9 0x4>: Full 4-byte access without bit field */
+	cell.offset = 0x9;
+	cell.bit_offset = 0;
+	cell.nbits = 0;
+	value = 0x12345678;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0x12345678, value);
+
+	/* Test reg = <0xc 0x4>; bits = <16 16>: Upper 2 bytes */
+	cell.offset = 0xc;
+	cell.bit_offset = 16;
+	cell.nbits = 16;
+	hw_value_u32 = 0x0000ffff;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	value = 0xffff;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0xffff, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	ut_asserteq(0xffffffff, hw_value_u32);
+
+	return 0;
+}
+DM_TEST(dm_test_nvmem_bitfield,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* Test NVMEM error handling for invalid configurations */
+static int dm_test_nvmem_bitfield_errors(struct unit_test_state *uts)
+{
+	struct udevice *nvmem_dev;
+	struct nvmem_cell cell;
+	u32 value;
+	int ret;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_I2C_EEPROM,
+					      "nvmem-test@50", &nvmem_dev));
+
+	/* Test bit field exceeding cell size */
+	cell.nvmem = nvmem_dev;
+	cell.offset = 0xd;
+	cell.size = 1;
+	cell.bit_offset = 0;
+	cell.nbits = 9;
+
+	value = 0xff;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test bit field exceeding 32 bits */
+	cell.size = 4;
+	cell.bit_offset = 0;
+	cell.nbits = 33;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test invalid bit_offset + nbits */
+	cell.size = 1;
+	cell.bit_offset = 7;
+	cell.nbits = 2;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test nbits=0 requires buffer size == cell size */
+	cell.size = 1;
+	cell.bit_offset = 0;
+	cell.nbits = 0;
+
+	value = 0xff;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_nvmem_bitfield_errors,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
-- 
2.34.1

