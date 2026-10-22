Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B82606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gjvjKKfj;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mCWma8SC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HdqOKKeE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72ACF8116F;
	Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WlxUKlK7VMkL; Thu, 22 Oct 2026 19:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27DFC81136
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695895;
	b=rXzElU5N3WZgrgnQu+UU2g73NpivyCQx57cLp3Yre+uSlX/VD0xLFMpTDvh2eufaSisd
	 mgBP07rZk6guBy+vMnuldOqdqymLRk3lI86JU2NJMvz+ZksFZDHp8A6Ch7kGUHNJlGFvs
	 5R3QheJHRP1do3O2dR+AKQnJGZhmDa8kvE/79yrjbW3sjnxaybCucf3RUjrq5X3/Ju3Vh
	 Qwt6LgP4PdkD+eEljpKuXraDxiknF9DSwEjSITaX7OIbLn1ZTafzx34JNpBxAPufPAlDF
	 H+xjqkSLhNpET30u6Z1ouueaJLtW8SLuG6gIXN/B49qI/byv8ABkDbAYS+zOTFoMxEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bIYd0g6Wn5tfRi4h40Foltze1o8LlAH7CKVkbE7/OKM=;
	b=lQeZsD2zIwzEFJDo3xSl3uRNymeKNh27rZ2b+fTnbv1iy0MicDV3T25Pl4xeL4RnmqGr
	 haVxk8mBYUK30fZaM3GQLvFtnEZdN5rvXsK2oC+bEEZetU5YPpDrN6CqEa+yXuDp+hHq3
	 zN6wxMJdO9FPkq+3Pukz/fySeSYh3MARXbCcXcvpgGxm+vh5kCJ5+cQuwZsPnrNPXV0eS
	 S+KGOWF4MY0K6QDTxjprzRfwQ2FDuI8skE3s52r15GUniCFLrEw16esT02gmSd/aQIy9A
	 PDX8NTMWvCzhayzCWeTIDC10RAvgtpy33SyNQIx1lUx8vKOwAyCQDGJxMo1/4AM7NmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mCWma8SC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HdqOKKeE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695895;
	bh=bIYd0g6Wn5tfRi4h40Foltze1o8LlAH7CKVkbE7/OKM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gjvjKKfjp5dDv/0rCfZ5MwdhgRKPQcjc0h9qf+dVq7K6qWPJcfsZIBR3xbUr0uVkx
	 r//5NEa2s58myQe6FAsYS0/TC0sZYy4ymOpPqG9Q8U7TMt1T8tKiNu0FcM73DSUjCO
	 DV1fz+1fR/w5VKQAXA8zmtKB7fNEVuDzAJiA47ervvWovDNtYzJtymUk+e6sC6OtfO
	 W0+4j0x2JoETcZEwePgB7Q35qhRl0ngXAw2f4LDQXqmFT29h/Zn+FP1JwCQsMTfPWs
	 sm31dOYPfYA0BSu3USJtGeD2EvGHokbr4u+z9ZyKkHoPXmUVb3XOgoTobTQe8fhgnT
	 2BVCpwpGiltDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27DFC81136;
	Thu, 22 Oct 2026 19:04:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B2393C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D0B381136
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vu8wkhrpIN-T for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6937D81164
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695892;
 b=BTl/pv1DBDRpI45XoxN2nSQAZ2z3B2NzmpcoHs3TtJR0k4iRzGiuFmt1R3TKHKpE04ts
 QeI9lSsvbec1CXKVyX1s30eEld/fXlckmAdBLlc0DJmxJ+Sp1Gzx4pAKXxQD/GusCxeiL
 +se+Kq9o4dvpHOHjUAfu7S8aqhvU53PE9Alrv05hAZBOceiOnW7wgTeU7v6M7/hhTeDOv
 FroINZNNkzag/BcEox7Q0A/sYYjz1zUBHcRsmGtXtgcaZ+ngDvmyptcf+FT60SHF2mHvQ
 OnWT1Ftuw8A78+MW6QCT8Yx1P47LjEaVfwrSDfWq77vY+QYM4udSYOGWTxX8SQJEKEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695892;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=bIYd0g6Wn5tfRi4h40Foltze1o8LlAH7CKVkbE7/OKM=;
 b=SEn4XBy1DTnqqGHe++i6Cy3N+zm+a2LNH/dY5/0Zg9yC/mq8Q2/eIpuN2Nu/Ep+xc4gw
 dx6T+li/H0K7S33tmP1RdsL4mJeZHcHPlPXyqtkfLf66C7WzOHAiIGjvf+9lJbrSmGYpE
 s3HbXhg4fimJUIPg4+V9vBsXwtvVbPMhEw1NUCc8p4lLHXrOGQp+zAA2N+MKGT3rwRrBp
 j2Wai3dsfsB1MCJUM7oXap3VwZgXsJOo6aSQ6iz5r/U/dqUwLUqBgOtB4c/F0I99JEwWa
 4oQH2k6oUBHqYCUTEsRiUzIgQQhJ0AUZgfa0JJIgv7dB8J/8+c2xgQ0ynmSK4NZJDgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mCWma8SC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HdqOKKeE; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mCWma8SC; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HdqOKKeE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6937D81164
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHM4g3741970
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bIYd0g6Wn5tfRi4h40Folt
 ze1o8LlAH7CKVkbE7/OKM=; b=mCWma8SCWXjTPQeNR8ZwPYRFEQ0qxLINRxUDSJ
 vViD6h0XPi3CmyrKmceufeOMPj3TA+lK3shlpWm/kKMDLvqbHBzlqvq/TrNSy/bo
 0W85sdYck7iWzyzLl9P5eXAZXZpNwaxAfiNBoEf/pqeBhb1Vq8WnoKpajfo+WI8X
 +RD7J54ticsnbdehXUXxnHALlD3Hb7onTGM4BRt7Wv9XxyVsIfo4iKowELCohMEo
 1ZXTQ17nFQmnKeJbxxlTeG2+9m90aO/jXdpUxbEDdg1PvaZhPnZLDitfH+qhapZT
 7A6Yr6iwqRScliBfbmOmtPZptPw5VT1151V3eSlseWFQhEuA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms05ht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf6c528aso18191585a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695890; x=1793300690;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bIYd0g6Wn5tfRi4h40Foltze1o8LlAH7CKVkbE7/OKM=;
 b=HdqOKKeEj5gNTrKgcp6wkEcvsKlUMtZECn8NIdQuE6C165QBTK2XQot1hIeQtCV6+9
 gAzXFK6JVdkr1RbgZzcv5KB6tdDO3Yd9z0AuPwqY1ExX7bnU49GSq/M2qXRNs9MNx4VC
 84RTlTTLDBcp/lwx/90iRadA8TZuKI6zg3umhxXJVcqQz1swt4K6X8sMi2pztE0hE3D9
 ffG+UA5CxzJ02xtpydWtQrR7R3t786DEX992GCiVWGWHA9W71BMpZTy+z/hWqFj6f9H1
 5U0euMzHyu7Oi1AYicjlojtOoEUhRK3QYmtUHbWgZRnZ8+EpX+O2/I/EPi4s1E0lZW2K
 CmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695890; x=1793300690;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bIYd0g6Wn5tfRi4h40Foltze1o8LlAH7CKVkbE7/OKM=;
 b=XVKkaCUjiY/32v2Yfz5SKQpeQcbhStAKcTHuWmFAD7M33wEn5dRVYOaPzKdHuKaazH
 shXJ7BNeo/OE44etBzu8TTQbK8G/Myx2iQr7xhh1QN+dgjshIZHXQ8CebPZiK4jL6tTF
 4+QiETHFXrs+qx90SVWBCGaoGVP86uzOjpr3xD9bLvUIwsspTJct+dbJdFjQjXiB0zvG
 RNpk/3DftZW9kiWLcpI2TziuT1QSSerRqSNOMDI4g0lHWWrZFsM0QDiR5c8uvuulzcvh
 ddmf3GMLxR+1x7HVuv2js5WgBfL3TUXVBa4nPOb6ikWg8zE7qKWAIZLVwkvnALjyXdC0
 AioA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEb4owoQvbH9XyNeT/LyZCeOLUHKQNiAEsfx8P9ggAbSYP5vI4NOZmsCm+kp3MFL5Yo6nxJDM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJnbHfy3KmHG1PROXybiIdxbUvD4EVAIAKu4zVw52pz0GNsknOP
 TtUWRzUIs2JZgxD411+TgHyK4Q8O3ZA82SCKd+89q/3qQJWYszBEbGNNmaxMJ2KQvfbmV7jlknz
 diXGEu/vxgvBOich2iCtGAAPWndb8bar8QPJ47WqQwQwOxFlvY7Zz7V0hkXuus/TFf33vJDg=
X-Gm-Gg: AYBFou0DkIN4jUWek3vgD3C6h0D1/Fc+tysOETRliVVzcRL9wwWrwsuWLYy2Pw4gnv7
 OXpsDT5HHdQHU0oVjye44pq647ooCpzxsiVXiTqm7kBe9UHrEyFaaiVnGK8zgr23Y4JHaESQ+Hz
 qxXSLykmIZJqxVtboG2jwvzwHF9g1DHRvNEe702nC/2AdOj40FuneYcQb/QDq31XPWTcWejv/Z4
 CHgaYAYOmnbBp+W27GkW654L1F0QbZwPoiZr95VDaLCTMa59+cwKncfbC486njU7lbjwSE7HrTK
 yDf01HfXBRz6zg++9lEgs0bvnrDLtdqHWm152OMyoqUJ3LuGAYoQ71iPnhz5fo5vw42o/l1B6ql
 tKmn6qduqYFZX8GIWGpfJAyHwWDFhQeytUyvMeIgh++Ou
X-Received: by 2002:a05:620a:2906:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-93f6f9e7e3emr62545685a.66.1792695889581; 
 Thu, 22 Oct 2026 12:04:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-93f6f9e7e3emr62538085a.66.1792695888943; 
 Thu, 22 Oct 2026 12:04:48 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:48 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v4 0/5] avb: device lock state, root key provisioning and
 in-place verification
Date: Thu, 22 Oct 2026 21:04:41 +0200
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WRQW6DMBBFr4JY18gYYwyr3COqosFMi5NgEhtQq
 4i713aiKosmitSVNaP5b/58X1KHVqNLm+SSWly006PxBX9LUtWD+USiO1+njDKR0zwn88lNFmE
 gsLS746gOu9nEp+WkK4AJoSStO556wsnih/6K9O37tXZzu0c1BWSYaMEhaS0Y1YfWHgxZChK6N
 73F8+xNTVfIdV6Nw6CnJsFOilqKQlVxekDnIBpukptdQSsmOM2qitWCE0b8guyAvUWzwWHyp0P
 maa+pi3+p+SN1CKbXbhrtd/yFJY+XvhT4khNKgJeACkrud25G57LzDMeQ0S9+YfdI9hzJPFJWX
 FBgHMuyfoAs7pCMPkcWHolM0qouoZZK/YFc1/UH8GnwR4wCAAA=
X-Change-ID: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX1l1nfJMjBrj6
 KfpBbTp339AUxJfJPbuH7+9UTJmrAoVi8s3ndzxFrbbs50YRlDiohq1ctr9C/pbJhAZXGK0ADTI
 Cf7McB31rTxJKfGkml9C1dK4g+QCm9M5zJF81q9vayT/rVJRDz3kwgG2pc+7RjZc6tiEfxaCz5G
 9m4m7MjxljV5Q0+QZ7AGYAMVwfGfNnLD8uy0eEf96kcRQe1Qv9JqvYSuWiGuikWOlJjuRedeyiI
 5rXf06zn874kxlgglEQkqKGOMYwjxrRG3w1Po0R7lyQfZjKiJa9Yd9C6I91CEColIMAhMc85PWt
 YL2Pf1BDNqmFrYv9FmSDSWPhNurfuQDMkrA4gDe66CHZsUDMYLjsin6sXeRQAtXtDEGu+qAbsPE
 xdLz5SYc+RQArz8ZhHAQnkQWC4JFyGnaJVicfmT5j721VHwO2TDezk0DtcelulWswlniFhAgbqy
 I/GIjfy4CpvQWxHRzZg==
X-Proofpoint-GUID: -ic8Cedjw4l6RWsVCHCAZmEBQIpPBgxe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfXwvPzllWNXwpU
 P2bmsSXbE53jV03Lra0VGkMIpxTEAoyHd8jPKnPkZyMxFUDWe+LEEiZtMEiLP+PvczdrK9XAIv/
 rY+ogc4Jhg1iQFoQvYW2SUxHI0nWpzs=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada5e52 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=HAEnkh90AAAA:8 a=W_CgBUorZULjrePn3qgA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=LzkeyO55kmtmzvcb4Ayl:22
X-Proofpoint-ORIG-GUID: -ic8Cedjw4l6RWsVCHCAZmEBQIpPBgxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220075
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

This series completes the device state handling of the AVB 2.0
implementation when the state is kept by the OP-TEE AVB TA, and fixes
the way the Android bootmeth hands the boot images to libavb.

Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
"avb write_pvalue_hex" provision binary persistent values such as the
SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
consumes, and "avb lock"/"avb unlock" set the lock state through a new
avb_write_lock_state() helper. Until now U-Boot could only read the
lock state, so a device backed by the TA could never leave the unlocked
(orange) state.

Patch 3 makes bootmeth_android verify the boot images in the buffers it
boots them from, via AvbOps.get_preloaded_partition(), instead of
letting libavb read, hash and free its own copies and then reading the
partitions a second time for booting. This closes the TOCTOU window
reported on the list and halves the amount of data read from storage.

Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
"unlocked" variable, so the state can be changed with the Android
fastboot tool, and makes the state matter to fastboot: the commands
that change the storage or run code ("flash", "erase", "boot", the oem
commands, UCmd/ACmd) are refused while the device is locked, and
unlocking follows the "OEM unlocking" setting the way Android's
PersistentDataBlockService stores it in the frp partition (digest
checked, last byte non-zero). Both transitions erase userdata and
metadata before the state changes, as AVB requires, and are refused
when the device is already in the requested state.

Patch 5 documents the root key sources, the provisioning of the TEE
digest and the lock state in doc/android/avb2.rst.

The series is based on Jan Kehren's "avb: Support verified boot from
non-mmc storage" v3 (avb_ops_alloc() takes the storage interface
there), as agreed in that thread.

Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
17 images: the chain boots locked (green) to sys.boot_completed, a
modified kernel is refused, "fastboot flashing unlock/lock" over
"fastboot tcp" erase the partitions and flip the state reported by
"getvar unlocked" and "avb is_unlocked", flash/erase are refused while
locked, unlock is refused while the OEM unlocking byte in frp is clear,
and the sandbox AVB tests pass. Build-tested with sandbox (in tree,
per patch), sandbox64 (out of tree), khadas-vim3_android_ab, sei510 and
am57xx_evm.

The lock state is stored in RPMB by the TA; on boards where U-Boot
serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
There is no build dependency on them.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v4:
- Patches 1-3 unchanged. Patch 4 (all from Guillaume's review):
  "boot", "oem format", "oem partconf", "oem bootbus", "oem run",
  "UCmd" and "ACmd" are refused on a locked device like flash/erase;
  the OEM unlocking check follows PersistentDataBlockService: the frp
  partition must exist on the fastboot flash device, carry a valid
  SHA-256 digest in its first 32 bytes and a non-zero last byte, and
  everything else (no frp, unreadable, bad digest, zero byte) refuses,
  so a device without frp can only be unlocked from the U-Boot shell;
  lock/unlock on a device already in that state fail without wiping
  userdata; the metadata erase is checked when the partition exists.
- Patch 5: the doc follows.
- Over "fastboot tcp", the refusal of "boot" on a locked device needs
  "net: fastboot_tcp: act on a command that succeeded, not on one that
  failed", sent separately: without it the TCP transport starts the
  downloaded image after a FAIL reply. USB and UDP are not affected.
- Link to v3: https://patch.msgid.link/20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com

Changes in v3:
- Rebased on Jan Kehren's "avb: Support verified boot from non-mmc
  storage" v3; the fastboot code calls the new two-argument
  avb_ops_alloc(UCLASS_MMC, dev).
- Patch 3 (Guillaume): drop the "if (priv->boot_addr)" check, boot is
  always loaded by then; register the vendor_boot buffer on the boot
  image header version instead of the recorded address, which was
  never initialised for header v2 images; allocate the bootmeth
  private data with calloc(). Add the Fixes: tag (Mattijs).
- Patch 4 (Mattijs): the "unlocked" getvar entry is now inside
  #if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING), like has-slot, instead
  of a NULL dispatch.
- Patch 4 (Guillaume): "flash" and "erase" are refused while the
  device is locked; the userdata/metadata wipe goes through the same
  back-end dispatch as "erase" instead of calling fastboot_mmc_erase()
  directly, so FASTBOOT_CMD_FLASHING now only depends on
  FASTBOOT_FLASH; "flashing unlock" honours get_unlock_ability, which
  reads Android's "OEM unlocking" flag from the last byte of the frp
  partition (always allowed without an frp partition). The flashing
  code has no mmc specifics left: the frp lookup and the AVB ops use
  the fastboot flash device of whichever block based back end is
  configured, and getvar "unlocked" goes through a small
  fastboot_flashing_is_unlocked() helper, so fb_getvar.c no longer
  includes avb_verify.h.
- Patch 5: document the lock enforcement and the OEM unlocking policy.
- Collected the Reviewed-by/Tested-by tags on patches 1, 2, 3 and 5.
  Patch 3 and the doc changed slightly after the review (see above),
  shout if you want the tags dropped.
- Link to v2: https://patch.msgid.link/20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com

Changes in v2:
- fastboot: guard the flashing_lock/unlock/get_unlock_ability prototypes
  with FASTBOOT_CMD_FLASHING. They were declared unconditionally while
  their definitions sit under that option, so every configuration with
  fastboot but without the flashing commands (sandbox, sei510, ...)
  failed with "declared 'static' but never defined" under -Werror. v1
  was only build-tested on configurations that enable the option; the
  sandbox CI jobs caught it. The series is now also build-tested with
  sandbox, sandbox64 (out of tree) and the arm64/arm32 boards that
  enable AVB or fastboot flashing, and the 107-column dispatch line is
  wrapped.
- Link to v1: https://patch.msgid.link/20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com

---
Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

 boot/bootmeth_android.c       |  73 +++++++--
 cmd/avb.c                     | 141 ++++++++++++++++
 common/avb_verify.c           | 102 ++++++++++++
 doc/android/avb2.rst          |  79 +++++++++
 drivers/fastboot/Kconfig      |  19 +++
 drivers/fastboot/fb_command.c | 362 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 +++
 include/avb_verify.h          |  39 +++++
 include/fastboot.h            |  14 ++
 9 files changed, 832 insertions(+), 19 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
prerequisite-message-id: 20261016072640.772964-2-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be
prerequisite-message-id: 20261016072640.772964-3-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be
prerequisite-message-id: 20261016072640.772964-4-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

