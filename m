Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EA606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q9glaeg4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVAhb53C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LDO7Feea
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7951060AA1;
	Fri, 30 Oct 2026 05:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfslDUsRsOxs; Fri, 30 Oct 2026 05:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6248D60AA5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793338721;
	b=DyjcYwV6clr0cXrDyyRdvn7loj2ZQfqHlVPULfEKv4uJoq7SBnmpRQdfu+6b/Vmzdk2N
	 q02TxNMgSaO1fa8KjO9Th1t1PQg62jAPVQLvOoMuA2tXIPHKW0kIquslgudjSaGq5lbWL
	 V2Gj1poy5mrHexg135bxrrXF6PnFMv202twsqc7WkmGYImv4eGqJQlsrgWU4XAfBejit2
	 +GjGYrLKl/yBRhpeVyoBr2THnNLZzLvCslgPxPC4svLeUs3py84Wd9elCJvtVxi0tSBzu
	 7IdxoYwypS+usXMNnrhR4Se9YZLKSM2yaEJdfj9h7X81naIRrNrx6mQ3W2/Cfs2bCdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793338721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IACxnGFLi5v3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=;
	b=qfrQi9oXzWlD3YDPmBgACXDMkT9u0nwFRFsr6+BfUpH/YTK9kb5y2wbM/W9GRZYKZ2xI
	 D3tJ6nhDQQyl9/NRQzXtKnd1PP8tR7lUOwkpnOYaNqHo+sY9ZBEMt4gWw0ACYV2607jLT
	 CQqwSyBcCFFaQMh9MxUp0YH+8o1clty7c2UXBtzlXAQ7jzbSXDFlSLcMkcyHx/w1lZ6/k
	 WNjG58VHs58ndXDGa9L4D4I6ZppxGyf+S/5N+k8vZ3qnZkvSPIpNFSuoXpyPu/JQ50LZ5
	 ijcQt1HJSmbxzL/EYLKfGfGwcwyeejZYywn9T3qBbieMeE//d4NOa6nPjamuQ2HTazg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793338721;
	bh=IACxnGFLi5v3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9glaeg49sz+1pEdjndCZvG1j8Wi6qQM5xe4K/uXBfkIDQmmfr784IhOFqP1hJg0Q
	 xWD9/qdNUwAMzDQJj0QtcQQp2smunJvCPIiHEKh4rf2/YMw9e7Xt2djhHkvQqBO+jI
	 +YQCLkhF3xnww0PKot20B7CxNbSINzOAMKhsm8QOhXRURKtBYdC8nwjTYBnJWFMc+q
	 5cYTZ12+hSNvwDH3HYXJpm6NGaJE1LMxt+BmjktEDTRFI4jcnhjBc/u8iqMBzrPG50
	 uM25wrljg4ay7EmAu3pH4Vhjc4EzOUsQpdxB8IzG9X7JrLLRUwciBkuMxarscc4Rtb
	 QyuFrrE4PNayA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6248D60AA5;
	Fri, 30 Oct 2026 05:38:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E36FA2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8DED4051D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fh8TMnCjjzgd for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B1BA64051A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793338715;
 b=eRlLlWezjxXMcm/4bBSqdiU3bcd42fRfWpmF7xOf/Cg8m1Pxb/bX1XZh7OvSNIDQI3sc
 6dtVDE25miX6o0M9WBTkhyzwqQ3UQRsnvgvIYGgWupAM/XuQvRMMLb6L3HenGfSZnAKKj
 HjkotKPKBtc8II5aDrC7q/1h6la136xfQKc3ix8m5IgVwlLzuorLfjbJTGiYG1pOL6njN
 3dTHY423N98zGvDYW8Zx3IWldts4g4xhE1iwu5GY+IyMm28Wd/ayfZXbkinkvzRNpGRMf
 HH+lMOYskOUSmNkhXN1uX7H1AhCVnrFntep4+TaXuB6K2P+ehWuOeKlMOJ1eZADujyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793338715;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IACxnGFLi5v3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=;
 b=gOvPeak52yZ4vM2thKtoZHXeO5m+wjC0ZzSqOxAxzx6puzRTSVFkcF3Se9mUMBJzLNJ+
 Jrzk8na0qC/gws9SiEtl1zJ7CaRLiJtzFlLgar/yzcGf3kww438seBLpC70/gVxv1un0g
 1J2v0c5TLBIq4uo28Io0JZ9brLcsBORTANwsD0Z/C517SOj2r8PgGmlaKGxqU1HhcTbT7
 I/ZPk3FMRjz1Zl6lUNWg6+FUmo8k1o0SKWuCLkynkxroS9zxTjUYBlFObvsueRPOkGsJU
 DEpslibJyGb15XeJIb4qy6CQ6HxLHZ+wPiRsgt6GdBeC9GdXHksjOzDimm+kYFbD9rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EVAhb53C; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LDO7Feea; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EVAhb53C; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LDO7Feea
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1BA64051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5F8gN2913258
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IACxnGFLi5v
 3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=; b=EVAhb53CMaG9IRQEncsTxouTTOG
 itqhLoyJO0x04OiT9e5YWMeOBaUNH/jXElw0QWuckf/hBo3Fr2OPAo/719XZqDrU
 Bb/uJNPN2ircD0fE+grOlU7QSCpWj/TOslL1WDDpVHnesv4sa8S0FTN+jd5Nn39D
 e/amUtX9GajAq8+auww+kbizYrnlcUt3N6Grjdn0nQoVb3xc34fFJ3+PjtWxhnUz
 EpSQuR0ujLCgv7cUY7u/cLsa9onofIM8S699Hh7DKgOfUY4MizoYlM4P+KEF3uQm
 VuQ0ZbHih6EYjRhFG1IaOnVHWxBG+rk1l/j8sElRGe0M0HdlGu2vyFDpf5A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qscc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3692c5b061bso1197829eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793338712; x=1793943512;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IACxnGFLi5v3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=;
 b=LDO7Feeah9kkQP6I56ic1mkl+X/mDpHtFF4tdLuo00LOPud+jEzdvgCjLtzDrKhCqL
 05m3751tA+NHYZ6qACL9+IfJRZW4fl7oqupduD2L7v32tmh3fVHUZuq59vYR5el+9tbi
 kXNU7zYjTVCGkcdBvn3Syc3RkKfCmyz8yoFWTySh8roroj5XNMmjSUHWalUk/rhyPclc
 RcK5J8j/XMVtJTPCWwRcsJLYtUvabpqD9VbkVz+2CLIfJmk1rsiMxYtGlCOFc/gRjKAR
 D1xmkuVsdaP9vOauKUmGrTcA6GUCzjDAKoplIAhFbzK8Im1+V2Eoq+aiF84GxDQ7z6gN
 E7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793338712; x=1793943512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IACxnGFLi5v3Uv/tQwP4vu6l8zkRXHML84Z+vs4DPUo=;
 b=at21rm0n41mfQFqqbrC6TuWWsPE6S3/vPXO1xF8sEWa7Ud5ZRc+4EB3soAfcaWJIbF
 ifBf8Avr1aA4BlHqnt2dv9AUKeJn7pPZKWFNGCVw9V1hgbofoP8bfhlysPVuKT9sZX17
 ce7pvDfSI69xQWhdZJKzsRT4et8UQpnA0pCbCmtWXf/PMW6x3+Yfa3bpoXeY6GJwwLbd
 kzsBBKiDSPnWPJWiJhSZ8y4AmNfN1VNbhicQG+TJWukNmZxkpgmXTU+4h7ebp6PLPZvK
 RYKd6fREf0EQ+ZyNyCR3rO4gZc8QVPpkPCtwNeC6osodFp774NDG2kaA/Owb5ebu37yD
 OPWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoWVLNOXAE6YtYJ4dz2Z18xBvX1v6caDS3abzQJWsKQyqzlstRkBVP7VVda9JxcQgmjksJfgY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLWgrx7TADF6qeKJacS50PKRczGL+3Sc6YB+jxFB6au+IxhgeQk
 /j/3DeE8FFbXXENtS6CeZ+FnOg3OquC2a1LPsN0SOvQvy4tl6Db0BHTkFtyeZVc1UXHdEJj0mus
 Ji2pWg+QfcFP5LUHbwgL19Z11M9XHhRUaFsvIcrqK5luZ8OH2NphGNBtkwKuSeccohacaj1E=
X-Gm-Gg: AYBFou0nuME7cWfXLQ5YJfZkZoXQS6T7svniH5Xod1iEK+vkXEsxnNFycM1Kx35DNZE
 3ZC6cf0a5AwyMC74Y8AwftH1+elvhRJwKAbZ16NUL7SO8jAOvQWn3ZYto5ZlKL/iXM52fKH4h7t
 T9DJ92eVMc+ENrSJjRXU17umTLmBMeZAudJtrPQEY95RQWZbyIjDVJmu49K6gQx/yjrznAZOCYu
 auEvwTUAf4prAZha+2KSa7bevk2fA7dga6X72bsf2of6weKEu37HZhLfU394RCnIBbYubXjcJXN
 mX6g1Gb6uXMaq2rVkAV+IrjEtajchyfNy0jxO7ND8u2tImH9zRdObbRlo5vZiH9yhIhjQ3uxdto
 bDcdLKlGrjBl5CaqLXZcDtDdKstmB4YTSVKelP5fidpJ92nCXF0UptkCNXDZtCT8fa7EsX6ErJI
 j/Eq5sVHnximjMyoRw5mKbEQ==
X-Received: by 2002:a05:693c:6382:20b0:366:f9c2:9b16 with SMTP id
 5a478bee46e88-36a423f5d7amr2270997eec.31.1793338711643; 
 Thu, 29 Oct 2026 22:38:31 -0700 (PDT)
X-Received: by 2002:a05:693c:6382:20b0:366:f9c2:9b16 with SMTP id
 5a478bee46e88-36a423f5d7amr2270962eec.31.1793338710976; 
 Thu, 29 Oct 2026 22:38:30 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428aed76sm4174107eec.9.2026.10.29.22.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 22:38:30 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 2/2] arm: dts: shikra: enable IQS SPL SD boot
Date: Thu, 29 Oct 2026 22:38:24 -0700
Message-Id: <20261030053824.447668-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
References: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YtoKy36-sd6iiooQFAsMM_JelQRP7nB7
X-Proofpoint-ORIG-GUID: YtoKy36-sd6iiooQFAsMM_JelQRP7nB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfXyAlIOfwiEWYk
 LIERu7hPEs0KPAhzI4TJ1g+mnFG787K5CZ3tP9IzalizH/Yq3E5OCf9GTGpUe5mcM0lX5U1V8gK
 sCKVAox6gMuZeA68jkrOdVBxubzj1GSf7Hopl2MY/oCea8IVpB+SO3+NvEui6Ze0y78GZyLzZrR
 TjkLHnWiJ+Wx+AzJWuebAPKoNmdOAra9cs8u4WksfrRCym+DQQnkgBN8s5ZTtY+1OquSFasvQI/
 cLhHA5vXtmi7dImw8ukKhJYoT8+SwHqRU/qp7vY4JB+MRF+mSPuxxqIbXYiKapJm6oug/FGyamF
 FaWgRV9CCmujFWNxQx+I1qQva11msmyZXfKZIAw9XwDeqr5BlPmkGJr94oMOOGa1JMgVXtidtoP
 uJGRQHaWra0vTBKa0vglVwLkajNyOr7Gp1D/J7p6MuT9lBu/iQFhJdUiu40Om3gI25PWwlAePqf
 lLXrmKqz/nJ4fwxX5nQ==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae42d58 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Gup79MABdndFUvl8AiEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX0Bg+xeRK/+hb
 BXH5QWZDHuouWsCRIfXDWN0qO0QDpjDiWSrzi2sd9FdTkF1hVFXYHIqMeW82bXlPnchahAjb6EV
 vP+6SiuOj4iSql8itroms0Ts7mE/Gj0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300021
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the IQS device tree for SD card boot in SPL.
Retain the SDHC2 and power dependencies required by the SPL
boot flow and configure the controller for SD operation.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 drivers/gpio/msm_gpio.c                 |  3 +--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index a1e506f7dff..f2265c741bd 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -46,6 +46,25 @@
 	bootph-all;
 };
 
+&sdc2_default {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_sleep {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_card_det_n { bootph-all; };
+&sdhc_2 { bootph-all; };
+&pm8150_l10 { bootph-all; };
+&pm8150_l2 { bootph-all; };
+
 &qupv3_0 {
 	bootph-all;
 };
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7de332c66ae..affbbe5c880 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -274,8 +274,7 @@ static int msm_gpio_of_to_plat(struct udevice *dev)
 
 	/* Get the pin count from the pinctrl driver */
 	uc_priv->gpio_count = pin_data->pin_count;
-	uc_priv->bank_name = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
-					 "gpio-bank-name", NULL);
+	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 	if (uc_priv->bank_name == NULL)
 		uc_priv->bank_name = "soc";
 
-- 
2.34.1

