Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE228C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9957560D91;
	Fri, 25 Sep 2026 14:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOYkVVJIA3DJ; Fri, 25 Sep 2026 14:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 969C560D8A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346401;
	b=Qdam5jf3Q4G7e3Rukb5Ugnf3AcfZ/t4sSF2wqRx7qa3WN097YCDMDrXrY4oQnAP73tV/
	 5zOGzDDqHUAeGSYIPGdW9n63c9gwnm+zikgdK81Onx7E4DOsSg7Ssvtc8BLT8EHBp821l
	 ecGMDnlzIqR5Gwk5uX3IlY1qVq4j5fZz1p3es3/+pKNNzNZyyIb10r0HMzSPxfb55JUJs
	 N1oz5vXQeTHkF0Ruc/s8n8LLiWWcIHSiVI2HlfwaXb8iQymCb+0ZyRxK4Mj1oS2pvwkZU
	 itMMau7Hf+dzZYPiJySGyscvGXyDUfV0ahshm0Zb0Bsyex6yH49M9CRyi9zcj/dwGyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
	b=LVZGqZjuJGtOOM9Y3VcsVrIKfnhTYSiox6TNJfJCUBJn7m7RCx8J0/Pc2zCb923wIlJT
	 pLRKblPotu6Cvb+uvpK1nU3uh/BQ2a7nRUk5RY+znYCJoJxDVEOdDx8MpZ6LMNGbswsFx
	 RWgjy5v6dwUA8CsQQON5x1dJMypYVNCemqTI+iDe3IWILSsYJsYNncQkA7qyAJYhd4O6u
	 z53a6ZPgKTZN1FsSa28YBwvFMjoODPK7ExKJlU/bnnQ6kL4Jt0WjzidanknrGhkNZcwGu
	 sN0051qMy/wzZT42usJvYpqaP87IOrDr3NP/zYtwUqdPlfzYTLz7yI4D/dpIt1bM1QQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346401;
	bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bVG27bVG/T7AP3rpEHFZ4wVr2BmPJu3IRllAkwUAPiO23WzTOPOXD5hhm5StOgj8e
	 J/zmKymGn8STpja6pbXCsLwCd8MmcPoExHLJQgoyFHQxX5m0ri5QcoWS2XlZExEriB
	 qdV8z2jM6f5s1T51YRLCkpTNL1klYOfroJ0uN+sr1sJ0c0mfNpmuz4H9wB2RdHdbhL
	 eiMIgAV8GxB5Gl0d6BiyfRhUPIZAQVsWjV9GTJ1FecWnknjouYLfOJDGU8oFsIhoZh
	 x1mAgrq+uenfPmEzGdr6rL7+Gol+sphfHVfIohhQknl45hIGtur06wDBRHmCLp9u67
	 uY6ytwbCohXAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 969C560D8A;
	Fri, 25 Sep 2026 14:26:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ABB2355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C80640042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fASb1JK-0onv for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B3C8A40180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343498;
 b=F7fp9D+ADoqJGP/6uD+ZB+FehFxDj8ZQXTqAt+tA78acvyQj6FGM2UUePEB/A1y/Kdae
 kRKoVHQQ2cJRpO+l2h5mdSDDAfmQyhGBpGJzFQMz4/kY0L8DtlFpyQSLkXAMynRLOwOtq
 wN3m/TR/NPaWZz7Vqz5EOUkAYUUbjrWk6MLqT8QJcR+Doee0deRYln+27a7V4zAgrqm2H
 SovrSXirUb3S7SmRO6cEu0ltB5P0JpDmMJikRGXBatoSza6FFkf+e+JkXSyyh13dSPKQL
 RSvLscBG2jv+49qtCPnqEbBOhG37tvXmM4J0Z0wxb1xrareZ8Gx5+8WPf1IhcqRI7lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343498;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=jKEevmjFZv3i5ErD+qsddYUBcK/Z35xoZuaV80KBzcljqzvRTbDWqhgieS1L0FTmcfWS
 1t1NAAyxoxjNTCST3Ov0D3pCknC3qEGI+Fprkbvv2pVaSLeu/nO6VS+BSvZ7YH5xfOSoW
 3+PX03yY5Jz2bgAu0PnaKLMQLh+IvHG04OGdaQJZdTfJO+UNOBpSZnz84kPkxllxYKbY8
 bQVqFIQUzp36JhHtwYB4J+PPEWKIL/wuoxsv31hz8pw0v/YJdW0mGroMuVccwq0WzxwoC
 oQzw1q9z7SW2f3eowM2i1J40G2rvjbpRzqnwO9sqDy4z8A1sMDB4ZL/KJyCGx77Cv/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TsbqbIfZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RVZDgbYJ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TsbqbIfZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RVZDgbYJ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3C8A40180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5IvMX600642
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HUEk/lK88BZ
 hLN+JmNoD6V7EElU+fmTzH6h62AHalHU=; b=TsbqbIfZHvI32pGXyA80TKnXrfQ
 /A38ye7fT+BlHUaJBQW6GG+PsuadgM7N729FUwPOSgsISMOn6gHDJnfqOddhC/Np
 ySB1VfB9ixg/g/CL250PJjVf7HojKY9ToMUDrh0QnOO7bzO7/ZsSq4xBF7jOuuR2
 9k08zapjpStzh/nv58X9ff35NbGTGXKEun2tdYZN7IXygn1GlAIElJ6O+68Gtw3a
 kH6ggPIvLOTfobUJlzAzM9NvN8bCvA8guV1O8atgPmaMTTmFX/uLaAjbCU2kZYTN
 DQGKXsZ7b3MlBdEtZsMAMddUZKO0C3hYI1R/iUovgtSwisUHLkiWZCB8V/A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsgms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14371f7ba1eso1421075c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343496; x=1790948296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=RVZDgbYJOykPyJUgCaU06Cb546R0DqmiiDo/yI/keNMv1nI8yzRS72NmWq6UKvSVUX
 NqfHNJMzSekCiUXOCz20xLfUfJYfqDt8Ak4V9GQ8Ayjc/IVr+mw11iUNvuX1rRJ5nOWe
 1U4PHcl1A5OvXOH5N6kAjq0Ndpp+56yz0UD8cepH5tPrYH3Ebnse6HKFH5j7xy++Zsrn
 yV2V/B8J+fM8ELyiZeuMp+OrYuBJ9/+ria8Fi8XGhtWuspPBM88eWKVh/QfMV1BsjljR
 L8k4P3XJsxo05ieAsOoCwvFMaNwc+wToaZuxgmTcUwsYEjprm8LG3usExncsWXGfq6UF
 3vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343496; x=1790948296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=FSHg0h7xK7bSnSGxwEhYACHVfvpcY74wV0bHFn/Xfrur1fuiPJyPFvNN4RyfoWHDqX
 7alIN+4e/f4RpIP5V0DBOWXVy/jlQizTlkiSSx7gAF2EI2htzhmSUltomDziZu7kMeTM
 WbFJhj2zsgoXEZaMnNmqTpaKSrG4c4+L+Xzwx7Q3gE9JXOAEkqhmWNsZRclWVSe+zpsh
 3QMvVnTTlt9xa9VKzLBYK+xAYPYE3BuO/urWx9ZQ7yQj9QNCRFpjjgL8HFoHbp85VbBB
 rLv0GgYbpfO/qYw9co5sAqCGVLV0n9Kf3Zj4fxlgq776XILwU5gKcQ65jdbVq1nWZ8XZ
 XwZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfQbBaylO1JJ13OLr9+hotonVVQSd5k3UatYBKwe6Bs/d0KRW5v8Zbc0082TJHPSUqLwjjg7o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kwFUQQfsv36USqZHBX+uAqWQfkDdRJijEgBZtrNaqXgP0uT73B
 mso5Oq+Vo63BdJ7WHjHBq8DBjjBNow+irpFkJ5XIFVUbeNDSsP5KQ28EkdEzzXGEDWmwaBFLOwY
 +d8tdjiwhZ6JppvlrEFVcC7BiGuBOLOLwJQgPG3EU0oc6B0i3HZoWXnm28H9qsz/QgN0caKKMpq
 IyN7I=
X-Gm-Gg: AYBFou3vu68TvEjhPHep4zNrg0wCq+QAs0MqntOvmae6CXIf+USaetBt0H7/KQHzGL9
 7MkahiD7v2PzLhJaP0e6SRd24oLhKDeplJI20O9OROJn7pU4OrFAvtvcjn4C833qttn/p6Rpuid
 T4oGLhLH67SqdVhMiNlSR9+WMdlXaE3YPA/1npNZoz8nup/k3yN6E5/H7nBb5Q8dakS+SwT+nPL
 OzFPtn/5WzcPabb/FXsegC6jMV6XGtUJ/s+88vcRv5QyDcd7AUgMne/kt4gf5iAAzTK0Nv758Nt
 S1IUqzASGj/QrlCcQCpCsu+2vdjILnjfht7mnT5tthuFqvoDuxGW2Go73/4s4CkuZil/fTa+Jx7
 gWHAacrHFDqb0dzAnuy5kbdPInppKpY1KjKUZ/xD6NiVXFnE=
X-Received: by 2002:a05:7022:2525:b0:144:f096:4dda with SMTP id
 a92af1059eb24-146d096d302mr343428c88.43.1790343495678; 
 Fri, 25 Sep 2026 06:38:15 -0700 (PDT)
X-Received: by 2002:a05:7022:2525:b0:144:f096:4dda with SMTP id
 a92af1059eb24-146d096d302mr343373c88.43.1790343494684; 
 Fri, 25 Sep 2026 06:38:14 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:14 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 06/12] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Fri, 25 Sep 2026 06:38:00 -0700
Message-Id: <20260925133806.1403713-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BDo3Xbbtjelq6qqohURmabSQqmoGZdv9
X-Proofpoint-ORIG-GUID: BDo3Xbbtjelq6qqohURmabSQqmoGZdv9
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab67948 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX4/iPpNrAX2Zp
 nEsr9DGbd5OkhEiM/W3qU+XSOuAeUroehdU1eoyxPqAYWInhqpgRODg8739GIjSFeTzJpG7Zza4
 wwHNAaZFOXZ2dEw0AaVdAfdG9ReobiI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX6PGKVMUvfkCn
 F1iHdk3wvN24QLCaRF+CP5PCg+lrfJlZILWape5Oy1qD/f1MolgIDA+yl+jnUlySrl3K3P/xCii
 Cy5tOmS7RuF9vaQrDwnr8KazgqZCx5rOet7MTMTaOUB6HJ+ja1QMX1fUAlYrz6i6KNHXGY7cJNh
 NxHuhZtzTbXjcSRclK87xEaruNtLSfQLkdCKe1dTW7/n3NA9ox9ckZb7naVd9IKoKh0O0wfRdqK
 72LlILUlQwOrfVYcDuA7heHoszvkO0gwiF3Sninz8XBJKJxrhUJEGLA3irP/jlqDWz8IMvdYUj8
 7sCY12KopTiGBQa/BQaR86X5kTGVo3QJxf9rpdPL/ZtAUeV0He2wX1RTCHCZrv4P+9jHWW++cuQ
 fqfMsK+Sl3culj7Q9ntYQz7avXY04cYf/RoE1alslComWy0FgtXdKefmj+Zhq2BLIjRoimbyPvH
 eWo6Ow5N4cZuclbZuTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a563e85cb02..9c803e6c181 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

