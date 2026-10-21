Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100B606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D9oqE8hs;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LGQ69A1m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVFlSdMR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB62880EE8;
	Wed, 21 Oct 2026 16:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WI3qP3knCB8D; Wed, 21 Oct 2026 16:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7879680F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598976;
	b=F8APAjQ7cwhoy1v+dKj/Wb3A7dH0EaygrWcxip/t6FpnWS5KJAu0Ql87AbDauRoGUBUM
	 leF1lJRk9B//MkkuhJ8GkJhsCo2IULeZeBbj9f8C9lbMWcCocHG34j2ZEBg54L+VLFhXg
	 mUeEWRqa9XVEznBBpiX+k6PCW7geG6mLl2kuuWL2Ts+O/5yTZcqFp5GDfrCxO7ZNBfDNd
	 wZU+gmKnkoIbIZW0znXhuO9+88zFEjj/IHJ1nHIkevr4oZ2wfMoAoAcbVopqaI9XtsBjG
	 nbGGKHPsUxeGMyNzNZzPLXqI58zV4GChX0HM7QpXbpolCUkHQwfE7OyR8q7O4v2Q1aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkhgqhbXuPQ=;
	b=h6LivUZ70YHms1LRPIzlkm7r1Tu2ZdpOAYiYsppWUFwu1mQNRPv5riTNh/qmTF6z6fNf
	 d4rd3QTV2XmyUqPHJIJBVlnNu8b1CQ8/ih5KjCcb+ns1WboFgl7fRVFDYoFLUgdWysDyG
	 i+7eillJpBh1V+7BIsx8x06oy4RoyDL8Sxeb/utwtwSbq6kYkCv2vMa0dTQ4+RpYVGLJd
	 wE4DrJeyPwlfDjUEdb7/OnjX8YMtBViY7petZi1GCYjdDenD9k3VgDLhZuPY8+/GH0sOM
	 l7sA5TM0sMGIyyQjJF4cNCot6HVD/D8/+KDTV1B+GPKdeWUM+7i/mj7MuuABIj25JPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LGQ69A1m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVFlSdMR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598976;
	bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkhgqhbXuPQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D9oqE8hskpx/32UEVecyIbTdxd9kzNkCngd3NNnLzPxFBiWt+7FZw1ds24jugLmn4
	 eM1oIq2LvUpez6YiDfegxEj8nECqQ4qZsP+f9XDbz7iB0wgFnA/8N1E2AMFTKh967l
	 DlP33Ek4DjGMMno/wj3ROFJYAwTyEYnEmYPlfxaWe4X48YMA3X8NZVczF0YXLp63/r
	 D3KJizG/n9mGOFK82j8/a1Bw2yzyQwkyLkLlBOSFVDn/r6BGE3Eew5FS+7W9j8+ATe
	 WZrM0RRbR/PxYm2FD4977KWL+inZCFGFMH6xe+RA9kmrhtdIwFlAZJBzjWCfq7CNnf
	 DGcI8fvax/zJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7879680F88;
	Wed, 21 Oct 2026 16:09:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F871E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 691C680F88
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hr5ql7jw4wdq for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:09:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57FA280EE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598973;
 b=DQnxq42fq4trTBECLHYPOdzysscB55CJD/Kj35jEGUYQzSKHG6KX8GR8w3horhZr8J7i
 F5S7fUnwqryAo5W/8I22fAYAjuJsa2I86r9n+U2kjv+1VoeCgfqEPJ9DphSFEolxeuha7
 6onuUToyb+Zmq+HLGHvQSI6EiqIskuTLP5ugiUTtkJFD4Cmy8UtHiH858Kbc3AHfK2FdE
 1V7LBDyzR3Kt5GfBMHbh1nnnqUBo0Ec7bKPhUfb3GCPsAFnlpT1uLMkg2CBlKwtYX/Crb
 fBdmGaluYpb9iNkz0ZPLBOVBxKBU0eZ7mbRa6kX6s5ehjhzMhPpSy7FKb5WuGJneDjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598973;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkhgqhbXuPQ=;
 b=pU3XJg6kNBqVp5BtsgIvszZfy+R/rUS/65g0gNm0xEGP3gHTlm0cLjRfI1IrZkWnWn2d
 JHd0lEm/61xSHKbFwea1ovgEmh60zfkEf2PO3IkQ91EfmRGWIQlM4wFRVWFLPcgGV3RSq
 8RCo/a7D8C/wxI33NT1AdfIikcqGpTpWCXOyNgSTVBbo4ZQe0glQyI5tw6m/DJeSjR1iV
 LlkWi2MRsX2imIYvrUs6aSK0ktwpcSCutxWg4DHy/yZuNSqWXxOW9mV+h+9IH4t6jDLz4
 75qPof/HORWl4X/ksCeziLmk1KhI8iXRcb1UyzBQlrRnQH1MCftPsHKCSnBdst1Jvwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LGQ69A1m; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EVFlSdMR; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LGQ69A1m; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EVFlSdMR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57FA280EE8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU7gE1046543
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkh
 gqhbXuPQ=; b=LGQ69A1m0/UumvH+JyGxvnWK1BbT9jhTqWYKwhQYz5BIxM4Xwje
 PW3AasgU821+yYYO4cvjXDXU2kvyOyPAAmZAMQtRcKoRE67zyEOewq0uzVhaKxTg
 4aAD5FD1yiwjXRfA0Ij5aQgVuB2+khkEH67OVXULAohfwIJcYPKnz2B6SadvaxTc
 0aB3JJB9K110bRUeeZIKTe3fklt6G084a9kb1lKJOsBowBQkfh+CCxyNBaSqZq4P
 12cmpAo8cjo8qsnYcEAmcHJ4xlIPiMgDSUKOm0Z42e+yCxAjfmnMWr04kjUjbTa1
 I4bTA0nXdvMau2itu6gF6Pe9II1jWSo00hQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj49n38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so1538826eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598967; x=1793203767;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkhgqhbXuPQ=;
 b=EVFlSdMRU3WdSyrTQYOeUGr2nkJdCMNHoQSGTyh6mlaX3EsJncMsCVsqnyn2ZBEpPe
 d1f/E4gaaalLI6/oHRRRhF9Cvj53acNTfIg9Sio8iHp6Pfjv1O+7QYma7gGhldy+XyfE
 n5DCi/u2luPtb43oerBOovI6apQcY+cwTAIAhxj0EiEw1wP4LoMv88ERZE06HhDXUC1R
 oJpNv9KFubRmUsYU6gXoNEb2jsl+np15VVffq1eyMUNsFytHBwUzZjM0mxYJIjSoLtYQ
 j5ifE7EeEp4nF0QOHljblusOmY7pE5KZBzfenZ+Z108CG7hjw29yaRyXo/pA/mk0IgGm
 uM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598967; x=1793203767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iJGcUC0wbP1Z9eZm/GdIWw8iITGybvUDQkhgqhbXuPQ=;
 b=gNpHAySFIYYdU2QBkFrbXNJyDPcp12FQDoxblvdgQWM0f+pRya1hD4OlLjfEeeJJPI
 T5LlQmYWYgWl53yZaiPF1cxu44oeJu6TZnaXKiu9+p5GT79Z+WKWgdDGGFN1InqcoAOI
 FVlCNxnU9Yq8oq+MyHnp39/wOgy36zrG0eAcQ+OK6ZhAnBQweQjiYBQsUAETLdjhKI76
 QV2nMTusKBPDJ+Ir5JGPjUBghbcWN6fBZlxjEC3UMz7d/aubel/oe8ZUh+v+ObX5AVHA
 /HduBHCq654P1GOofDaUT5nVMYp4dZV0J0EtdiXZQW049I2ovW4g39KjB+i9K5+f9B0k
 pdwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZEn9mD5vkB3X+QECP7dWQMi1NN2d8Y5R7UE7zwj07zlEJ/PVMpLh3bxfDthJqHC+IP2M+3Qw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJuReTqVpCgx+Yuk2xHa4HYcltOmZTOFV0Mq9t+XS66cELX50sI
 IjMTB1mc4GiK8pzAjKioaKDstE5YfvtjvdxVk4bPC0DIrtyHCheSd/NjvZpgGZg/W99tmBnnRuI
 eiL51wv9XrS7n0UhDdUxGhtujQ3zdLah6GJ2mIAon5g5kDvJkwbTjRxGc01dg7Djp8sQLq84=
X-Gm-Gg: AYBFou2uW+nLsmy2cFrYd2Wj8Aojv8p31uVgYUjuAw40IVZXgCBYiKqZLUcq76hb0BB
 Q47eU7w/SY/2DguUtuZlrfh3+RWLC3pTO6Q+IVhPKiI19nyB4bFQrnT+aeuXA/0qGUgH6iilU0o
 TnBYgeMc8B6Q+7rj4YfTbYxArRmw1VgqAY0ym45aKsj3mfhX72pXRO+KL10K0KAc6Eis44Y1nXL
 8gErsFY6WbMfDRjNDenRmnk+ODqKpCajO785hGr3nlvniqci7AMOl14jqUUNKDvLX5JOO+qVpLy
 diYAT0dVpCtPzP0yOruR4Mn6SP7iS0WxF8RU9DavMfYtXDZNsr0mGXEk46264z6CldO5qFl0dmD
 LlG4m6GSsccZlydcThDFVIst655DHY+UMkJtumFbsGXf5fpyYBcQhbSeI+Z5TsW5kOK2M3oRp0T
 A3cdIcPY0JHULNAx6zrrc=
X-Received: by 2002:a05:7301:1527:b0:35c:2986:35ab with SMTP id
 5a478bee46e88-3674d54de68mr3734726eec.13.1792598967453; 
 Wed, 21 Oct 2026 09:09:27 -0700 (PDT)
X-Received: by 2002:a05:7301:1527:b0:35c:2986:35ab with SMTP id
 5a478bee46e88-3674d54de68mr3734689eec.13.1792598966697; 
 Wed, 21 Oct 2026 09:09:26 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:09:26 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 00/12] arm64: qcom: Add initial support for Shikra SoC
Date: Wed, 21 Oct 2026 21:39:04 +0530
Message-Id: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: khf2HfqtOL4Uh4SqSc0UMstxINaaMSgZ
X-Proofpoint-GUID: khf2HfqtOL4Uh4SqSc0UMstxINaaMSgZ
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8e3ba cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=gu6fZOg2AAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XM3drYV-cKaoLeI7bekA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX+t5zCTk0QGwn
 QYMN+RjrnES9J4HIYX7Lf+LK9A0wxmmDZKYGw7fGhtFeZ8vnRTEZRzpTlF68jX5qDDplae1HwDf
 +Jt2EX/C5JOVdSunkDHkzTlYbpfDJoqDRBmZf0FhU2lf/xRBNIkniEntS6C1minJ4Ek00jc58hV
 R0tYZTf1t60Qf+wJuVKkuu5FbJNgE1fzIN8LbkYDaEO1oqvCjyGTQPkaARxQm2/PVneQ/I/1UpM
 WLBUBgiw79/JQHSqIeVGuVCEldRaMNaKt3oSTAgJ2nNCwfzeOxYAxqnAf33tvwl7UOwPBdfsBpG
 WgCOHbJRupUwQzegcAkDmPDh6yFACH8qPz7G5XDg99PVwyquiU/rzOphsKTNc2x7gK91pbglwdN
 6h6RAMpijEPBfA8aBJjp0/GOdpSMNGj9qAC/hjS3rF+OFYMd3GTEHZkYFV2UgglA/KaEzNyU2YQ
 p5aZ7Imo+UhUAzbCikw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXwx7zNe82kJZP
 i5x+ZgBB8hlxNeMf2Qy24MeTSWEHsJqjY61SYmk2tSrZYI3WRTBiJ0FmJpcop2Zs5zIItU6fqJ9
 mY2ySEJVbkrtSAYs1dz3y2fv+wzmZg0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial support for the Qualcomm Shikra SoC in U-Boot,
including device tree, clock, pinctrl, SMEM updates, USB and configuration
changes required to enable early boot on Shikra-based platforms.

The device tree support is ported from a Linux linux-next branch

The series includes:
  - GCC clock driver support
  - Pinctrl driver for Shikra TLMM
  - USB hsphy & ssphy support
  - SMEM update to support higher host count required by Shikra
  - Defconfig updates and Shikra-specific defconfig
  - MAINTAINERS entry for Shikra platforms
  - Documentation for Shikra platform

Thanks,
Aswin

Changes in v4:
- Drop DTS files already present upstream.
- Keep only the IQS board variant defconfig, remove the CQS board variant defconfig.
- Add documentation for the board.

Link to v3: https://marc.info/?l=u-boot&m=178668446732727&w=2

Changes in v3:
- Added USB3 support
- Created defconfigs for IQS & CQS variants
- Added WDT & fastboot configs in the shikra defconfig

Link to v2: https://marc.info/?l=u-boot&m=178595470886921&w=2

Changes in v2:
- Added USB hsphy support
- Ported Shikra dts files from Linux linux-next branch
- Created config fragment for debug UART

Link to v1: https://lore.kernel.org/u-boot/20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (12):
  clk: qcom: add GCC clock driver support for shikra SoC
  pinctrl: qcom: add driver for shikra SoC
  qcom_defconfig: Enable Shikra clock driver
  phy: qcom: qusb2: add Shikra PHY configuration
  phy: qcom: add QMP USB3 PHY driver for Shikra
  configs: qcom: enable PHY_QCOM_QMP_USB3_LEGACY
  configs: qcom: add debug UART config fragment for shikra-evk
  tools: qcom: mkmbn: add Shikra board mappings
  configs: add shikra defconfig for IQS board
  qcom: smem: increase SMEM_HOST_COUNT for newer SMEM versions
  board: qualcomm: add MAINTAINERS entries for Shikra platforms
  doc: board: qualcomm: document Shikra IQS (IQ2)

 board/qualcomm/MAINTAINERS                  |   5 +
 board/qualcomm/debug-shikra-evk.config      |   5 +
 configs/qcom_defconfig                      |   2 +
 configs/qcom_shikra_iqs_defconfig           |  31 ++
 doc/board/qualcomm/dragonwing.rst           |   9 +-
 drivers/clk/qcom/Kconfig                    |   8 +
 drivers/clk/qcom/Makefile                   |   1 +
 drivers/clk/qcom/clock-shikra.c             | 344 +++++++++++++
 drivers/phy/qcom/Kconfig                    |   7 +
 drivers/phy/qcom/Makefile                   |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c | 534 ++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qusb2.c           |  14 +
 drivers/pinctrl/qcom/Kconfig                |   8 +
 drivers/pinctrl/qcom/Makefile               |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c       | 478 ++++++++++++++++++
 drivers/soc/qcom/smem.c                     |   2 +-
 tools/qcom/mkmbn/mkmbn.py                   |   2 +
 17 files changed, 1447 insertions(+), 5 deletions(-)
 create mode 100644 board/qualcomm/debug-shikra-evk.config
 create mode 100644 configs/qcom_shikra_iqs_defconfig
 create mode 100644 drivers/clk/qcom/clock-shikra.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c

-- 
2.34.1

