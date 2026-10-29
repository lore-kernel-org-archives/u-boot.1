Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9D606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B7t1OvAv;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OFWo0g0U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AhCZVccq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3D244082A;
	Thu, 29 Oct 2026 10:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRNbEEets3Gu; Thu, 29 Oct 2026 10:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D84534082F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271504;
	b=KPyeh/y27IDPmCku1ELVsW6nBd/7YR9f7AotGp3qfCftX5vzE1wvJz+OLxZY+netinbq
	 mediNlaIOfxX3ZAWFfnare/FnXGgzKvqdvPTdjXaU/7guwtKRaGxM/95JxS3YI+0l4gve
	 skCTmC6CeAYSnwYl9Svw5ro4MuMe/dFIiBG8o2KbsIbgGuEm609yH0R0ggNDM4N5U5Wev
	 ippFwbzYkYkxMNof/MqU64tT8QBnf3gM6wdEf8v73nhaMn8/IwrCKT14tC99UJTxJWWg3
	 paQHFHHCdJXJnzJ4eo3EpoETUkqnl0ZI3T70BjJxCR3Bd55JUVoxZDCABpscbTozO9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	b=NEPs3lKfcKgRPhJHMCBDl2i3Jye1JzAkJWYiFHWn5B02dq/oMyrtncYAGoZF02kEn4Mb
	 qXsquFm/Ilep8gMXF4ZWLcwvx9R71CoeSj21JjbPQ0tpdkY/5Pcoa/KW4VRguEqFBemEb
	 hIlyHaJtJx4ORr/Navm1zkv8zI32NPTnJ6UVpm3jngM3H22PK9zW6rlddoyy4Ps0mFvz4
	 y4kolpSjsnZHf1mqCl4BCPiS4adGtQkeDFUAy1Im2WDlGFCsZHZ1Kt5gYLjUDsJl4IbcB
	 kVGqtHTECxVO+bROV4sUExpRpfVlYMl2f3CAAejDqBjX1w3dXYfu+ukQuq3eOXlad0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OFWo0g0U;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AhCZVccq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271504;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7t1OvAvTL6sh+PCLm6Zis919rTwPBzQ4fL82SOECwgWsIkkpTo3ZCMSLFuziObXM
	 ENujprORnDzS56O2qCPw/QQVA9rLUZZ9gxDjH/i9N+f1xk3zmP9PkgPREktzrGkJOQ
	 QhH43Fl9OKJG/9iiXRqr0irmuYzOPzafMyGV9wldd/zFAIgft3feGyov57zwZtgmpx
	 8PIIsy5aDjtru7e+9La4plzznEwklMgWGZY73y8rzJdh4F571R2IiMDn3stHUznRBd
	 zhAlVVenFjZT+Bqnwn3ZxfIDOGWFyaEsVpNEgKo4nVDUqXf5oq/5rEygrlYbv+/rEN
	 cNs2V6N1WnHyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D84534082F;
	Thu, 29 Oct 2026 10:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 72B5CE89
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 569A94081A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sp6o_6pDh7bJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95A7F40811
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271489;
 b=dXCNQagUHr3HJ27xHayAzkpmp2btgbiElittMiO21vXlV/YTW4UrHR5Yk0nBpNbVcaUn
 N8sp34Zg8vvpmcr5kNSnBJYwDXP7tVtlSRyaxdTEb6r4QLv6OwpWapgl27HKoFKrq6hVA
 tTGu+hz6HVIfplrVBeAPLwTv6w13kPiszHxh4D9T/ldkhV1Z1vVIQhIbw6xfH74IUxtYC
 qhdqeH6XBld37j13O4aHO6j1BJerolHFM2oy/8/GbcCyPCeWlE7+uzXmo74p6yXVFGlve
 TEq8pZy6o4tgd8IkkSGnLbEbFcRo+umUmMyYGLbwpPEt8HWce3todOfVvtHlK7EZdPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271489;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=tfebbQpSWeh8x/qyUNHwKTDYQYOzCHW2puA2TEuOrJd0lOz0fGIG5sPKIcW5EqAetaXj
 8iMlURkMAHxfr8ibi1Gk1WFccja14ZhKlIoqIumzk7L9E6ONL9qwBo2tsq5Bx5IIqVxLC
 WwdibWsFlUrtpB4hsntKs+TJFMY8H0rTGoPFJQL/I5dasUleilaKU0KRxcqIrmHmbOk5M
 8WsJkzrx6o7GjXZrbmUE6r2a9TpH2Bnr67VqBsLgeY4GBcHdf2bBXT04cmbhFbAZMza9g
 U3l5Ab4xGLMDgMwFTylWb8HkBONgukAqoH+gfkm20Ft9japkU7teobEzkjq03iDsJGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OFWo0g0U; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AhCZVccq; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OFWo0g0U; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AhCZVccq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95A7F40811
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:09 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vtbm3279765
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0lxLpCVJYJ
 Jhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=; b=OFWo0g0UAEhSxfkyk5NYhpNP3RP
 +F0F1PPbyJfSPQqkb1YiQSEnNfj46Jns7D6WcRQzfM/cCq5d4n77dlCbh/lhX3n2
 i4EjhK+xkNlK2Xe6BNF+D4mKPRdIuIUvTIHSOqZJlxt+iW/ndIX0DO/nPAt92RK8
 htxyFzXrKMOXW1yjKYZ/xxDRNA1rbAwBqV+nZAowfX3beJsnZ2wu3SsXlfIPs171
 Dr/aEgOgiMArwvWOtETPpWYThhtm70uEVCk6cws4UWuRmWsSI9xpP5EHTzzv7S1J
 RyYGS6RQayfl3cZUfkrrBuk7EapK5yvw/WE7jHEEJaOTLB6Y92/Of6GlxTQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nan9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so8039892eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271488; x=1793876288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=AhCZVccq3EFNPBwEsjjs9GQVIK4LpYmhjKqwR80JlPdTFsQLZh8s7hElC44kkL6k8H
 AjE1UAJ3kKznzqaWP70hcUy08tgz3zk0iT/CY15N0uCHxwqHasHGP4MFhH2xJ9OIPyla
 G975KV506M60m0rt3MtQq9tiF6KhKLlxbdYL9bX4JYZsLbhLSckflSb+McNs2ddJlIdx
 RTS9V5rwm3UPW+AvJTQw9i4+nLra2F4KoXFUrNG61Sp7kdJS/tIhSsA3W9S5agfPqPAA
 MTjxTLVIQnnOEkqwsCJBWSCOwTgxz+XhQFIOJUr4K+BrnCw6Sy2TN28IS/R7SMnkwyeO
 7s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271488; x=1793876288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=yDlNBgg33U0iLlCocVSVjNjYwHtyfHhXzRHtGkQIenyLrDrqawaVMNNfznQH4FEJy5
 RWeqEJ/VfSnKG040qpEsnnQIwLDFO05IJZXvb10y6xc4G0tjx6OH4fh2XYL3EtrasN40
 lvohiAvFmPy342DPteSRW400f/7xJDwnQoFw3lZaMJ20d2CcRT3zoXTfaMmkM1LPqRFZ
 eSEpbSXqHeE8iHrlB8zJ3mmN6+vUmVVkypjWyMomsh0qe4lfsC3AVQ5zy+q/eYIxEg3h
 A9JH9m3/SCo/OdmMRpjn384+9A6HO3Cdcex6LqP1PG1kvAeL0DvkMHKVRmqAGvZaEI1x
 1B5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU2GIFdxL32hE2LgpMTdgJQ9oXx4X58PSxbExUK6naAn+YtSYfRNRdwop7FfLN4JUiOm0rKlo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIb0UBkIcQLORViLyD5Y2OdX0WCiJP1KEz8HqtrDbjzwTqPzqGL
 BHBKaa4k/iA7RnAH7+nrZKtDpfsZYVopcMoTlYIhs1wmwpOTP3E0gm9e1WoZU4W5V9eYEZNn6CS
 RjhkoFaLqC1BxLCSZykktJ300DLgsJeoxq0jKwmGqOph3xJHGjjiqzcj5tcPxq6fpKwkIOHI=
X-Gm-Gg: AYBFou3i0kwWwhjH6NYmD+WhLicGHWr8hGPPrHCfL6t44qObm6RLlTgxWEcGmqrCJb4
 rLx3q4U0Hscd64FYDzYGXvR+CkGuTw+KDEw8nw+Puwl5fxA0jhOTkZ8C8g+CpeQl5+GQ1rCa10x
 mmA7d13lI2VQurz2lia3aA3QaJgXGMqgjuRGotbcDUjg9ypl4HILioFJRCP13oI5TqIHj7PJJtc
 ZCBR8l2xxVQ8dRZfP/BhUnN/jqdhk2v4esaf5SOPiKic0D5QOhSbLQQLmC0rZ7elanIAS5+XbYK
 skLYvio2vwsSCnZnI8sI6rj/Szrggddd1kORBPNEGpmzetBRhy6PaaIlOlRFE6Rwa/EkOsQhxls
 mSXnJmm8lFd2i2Nm1boan5Bc+V18dYyEybR4pKTRtH3KfVvme31AqZZkoYxZDoks5ThMlMhtXAq
 jnxE4o58MNW23Ni7yVpnqbBg==
X-Received: by 2002:a05:7022:f412:b0:188:9ae5:162e with SMTP id
 a92af1059eb24-1a6ce20983emr8976748c88.40.1793271487131; 
 Thu, 29 Oct 2026 03:58:07 -0700 (PDT)
X-Received: by 2002:a05:7022:f412:b0:188:9ae5:162e with SMTP id
 a92af1059eb24-1a6ce20983emr8976688c88.40.1793271486404; 
 Thu, 29 Oct 2026 03:58:06 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:58:04 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 12/13] arm: dts: shikra: retain SPL dependencies in IQS
 overlay
Date: Thu, 29 Oct 2026 03:57:45 -0700
Message-Id: <20261029105746.3487456-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GO4ogjgm9qoZInVWTKJvBiFTS9l0mK2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX3qXGptti315O
 hjwLlc8ndYEVg2rqWgLDeTRNnAiUqWQw5ycPOv/Ico8ZtOehdAZ3WBrR9by7CO8wboZCZa1aau4
 cupXx2xXpaMO5000iq7/G7XeoIEc0BZTqGwRlAUlgGiHGwrHqfDxxZxjTUqZxoj5GVgAbiohnMC
 6fObUK9yS+wBmfBpJaDNEcjx0imU6vjA9jCrydbJ52hgC7yfHHBeVKmlCA+6YADQS7t1EHy0nAv
 NDBan+GDf3LtCjmFSur3DpqtC0i4oXYFEGyAGmJ1FTUYggbxN3z9UPhveHX/flJ5azb/G0kyXOX
 XYW9yKxJBxU6RmUIPljKY4WQvaTKeSjs9u4WSm+x614xI0VbfCFIlKlFqSXa6GteBMdZrT1gzbX
 KqiAkvcIy/raLX44LCeH0eSMa7axioGiqEL7iahMHBc4uwJ6oxPjGpbXGJsCE/AG7w51sehVRl9
 3MMrpsEB1fdfSnrEDKw==
X-Proofpoint-GUID: GO4ogjgm9qoZInVWTKJvBiFTS9l0mK2Z
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae326c0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qkSexMeQyOevtdx1QFIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX4tbUk+e9YWcr
 glyySj7g26Ke/YQ9+ZFtWG5tXPg/WJKsv/1KrvzgdSYNVTSOCVLvh8ZwJaUjEbCA9Mtattnvcyf
 gkuttU7jayeB5qs7HrJ9qP0Fkso1gHQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

U-Boot proper uses the IQS device tree on Shikra. Retain the SPL console,
QUP firmware storage, MMC, clock, pinctrl, and power dependencies in the
same overlay.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index e807b91ef1f..a1e506f7dff 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -20,3 +20,45 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Keep the console and QUPFW storage paths in the SPL device tree. */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

