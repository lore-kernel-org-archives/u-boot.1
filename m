Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3671606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nlQgQQIS;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NEupdLu9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MNm+v2N+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 931E5607AE;
	Mon,  2 Nov 2026 09:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEkm1SR_YjP1; Mon,  2 Nov 2026 09:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBC2160778
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610723;
	b=J1CZzbuGA9xgbsXdeunZ6xTnWUyX4QCk315ob9LyEd3cyE42h8Hf5mTFoxnwsEId8jIk
	 zIX6WpN4h7AJ8d2sGBLhOdYMfbBZYWVhKFR1cMaG0P0jvVvCJxhYy9CyIC1PYCfG7WNk6
	 QNIUaTB5/FMr+r4F5ekcEuJWiQxrFibuk9pIiWUBMchmkZXQRXAx9pLo2bISwg2zBB6TV
	 MJKHTuo+cpdrOinZBvipUHt5J31izRWlBRNoMEtRJdaG1xfwvPFufjXFmdHNv+SC57uor
	 tmvxy4U/jelAH5HxXO4thdWe7x3CA9TKMGW/fq1o1rFXXfFkewfS2jZ6Kz/8MWSRlYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ru9+k9h6yilqeMUpeXzLowd8G1VLPetIACpir1tAIIA=;
	b=eJgHbk/Qkbx0Kf9HWq5NmAQ2lgK4jbkYCJJDWO8oYKWcTEl+Zjw5pYbd6XgGM2KaUq87
	 VW1GAErcoPXjuN7BF/04xt2rjTKnoP5oq8XRYYZbgYx/MS37Hi8wpdf9TSEQCNNSstTdl
	 YjKI3rwvX39T1kyDksrF1MlqyiqauZcY7MdWDUHGLiw+j2/POqXgpsTlu3UapHVBV5DPJ
	 pXNlDXdYYjy97sRywt++kz3yf9nwBU4hPqEUzz4Zwow2GOzeoNDSVstr/A8XR6Lg7xv1N
	 wtG25Qfh+d3E6s6rTPSYdvVowZ9wWYIyuTagH1LRrym/2KJTP9ePT2MGb4G3OsGWMrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610723;
	bh=ru9+k9h6yilqeMUpeXzLowd8G1VLPetIACpir1tAIIA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nlQgQQIShTZyxZwYQl+5YG6o/GNUi8KxGobk9t9n87MppyYtUvGjJlCC6zv21mdSJ
	 F4FHWwzF3Gkx3ysJW7c8IjivNiG0ZpwUwZ4WYe56JUxGw1nQp1pQXBY3pR7yJboAND
	 1cUGAsQdS3KxweHQWpjvmpXWNHpVlGHH4xcZw+QCZzqQ/Y1Mepx9C8NXa+7WJM4on6
	 SQqV3JhDFUbDYnaT8R2rUnAoYzm8SawX1kNQe9PZhbsyJJglDcCaUjU4ne+mRO3hzn
	 gRpWIVzrRXjUuLd9CQOhtWgTKd3fabYSh99HY3kjVUxQ17Sno6Y5TtEL/dr5J9YWf/
	 doIxFT5MmQieg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBC2160778;
	Mon,  2 Nov 2026 09:12:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93ED3323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7890E80F4D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t0rIlqNrctf9 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B580580F4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610720;
 b=Mk+nZvm3zT2jbgql6Ffi6bo0EvHaF3yy+Zpi1/jTBA50Uc3hw7/QIcG8THD6kIP7+Jtn
 4sKoxIMO0YvfEsR8YsTeYI+yJP905O4Aq3opdHNgC+7+7W28UAPfBMZsTGQDomGXtkCqY
 Zv+AosBaPiE3rsE+Ch3HbTFWi7XyHKMOsflElcVvDyMHX+XeW/tgcpdm8XMlX+C0gG7UK
 t9tTTWioqSopQIxRHaefLr6GGWQzcrX7463BGMdyHGV36PZ1pZtjVktg+UYr8IvulaKAe
 bCREHRnfSpwr8vzf3MuNOgsokiqXC1wAMc/E/lnNUvtTKHRqsMdoZlogschWmdnzCbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610720;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ru9+k9h6yilqeMUpeXzLowd8G1VLPetIACpir1tAIIA=;
 b=Emrk+4d7WBhtMYcbRvIxjDrzNgT9Pmu/dBbysD12DpoehdG0sLr0+8tDeOcWtiFymQOt
 nnBhA3+e65GqA1sI97GkJK3JL1skYNHxRPUMy+3VidbitnQFhsC2FULa2Om1ctbAar701
 gMeIoGeZEnPeqpnYPvHn+GcAV5GqkbyRyjv4jSwniX7QcRqgOeSlZXd1Vj34Rj0U4IqD8
 j5BCs2utgQRnXQ+MXaRs2CaSh5oT5hTGW/mQUk3Waz8l4pJoFyhNURz+kZHtNs5s43taP
 jTR6pxfNu3mQ72zCKXYfhc67mCqqx9Br6IupCQcR9EDWDvtFPF5OsKxm5X0TIj9jUkg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NEupdLu9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MNm+v2N+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NEupdLu9; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MNm+v2N+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B580580F4A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:11:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AScs2880918
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 09:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ru9+k9h6yilqeMUpeXzLow
 d8G1VLPetIACpir1tAIIA=; b=NEupdLu9t5paI3BZi5RDw0JQ/JRa+lw2gkMq3s
 EZcSuak84ghrnYu/bzcbiQKAffotAiPjajD/o7sXnCo+Ojtt8qyM5j1VBo7qO/0H
 +IUbMiWhE/Np0kqfVIaYPziqfSFOb7GOWE9sx9Rg6/V8mIw1p/b4XP/kfpbmUKdB
 pdjGA+Me0sOZuUQnHGeHJsO3IxjQP57zJh3tNBG+FMQqk+4OCqgPRqnv1x1gWT7y
 O4Mylrgvbhxftqceq+KQdFeaUWK7OlHkP45XWrqcXNbNV1nQ1m4nYrt2A5kizy9J
 c3ib4QXf6Ul30YFnx00nDFUb7y94ttWgB1Bo7ECTZIDvVYNQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrg227-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:11:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso534156185a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793610718; x=1794215518;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ru9+k9h6yilqeMUpeXzLowd8G1VLPetIACpir1tAIIA=;
 b=MNm+v2N+NUj93vPDTm2kABTvT/uK2LKAQ6RDwMOIg51xHaZjhoPnWkzuKcE+vLuEAz
 rn0KKWIOwXwn5G2PONN4+4oKGQnHCCIbmRiH7VLJR0sfwLs2RcPExEzmoAu/FAd1uMer
 mWLU+yITUHr5khLCzNS6/VD/VaFwO/P+aU38iL+G7g1f4oEsyEkLKd3GWH9Bg9j551ik
 ubnsJ72EVppxdicay77DgQVDJ3f3XRUGVei3fi5GEyQXUQaIjpyax8KPIv05kwxS9Kae
 Ys1yE+4yrFNKy03cE2bLQnGro/gIxqlsHNhfevWZ7x2M0J9g6QGOTElTKniYlVDzplbO
 NI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793610718; x=1794215518;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ru9+k9h6yilqeMUpeXzLowd8G1VLPetIACpir1tAIIA=;
 b=wZfXjxom9MI7ts2sMO1NPCYkHytTKQ6wr6UFY+JhyPpmqGnI5OYw8qQyLNFxXAaqrU
 QyaeOgcNEGIrPJ+8LkpQCU4FZmL8nwSApfj2mtIkhxAHsc6YJF+z9Z/orMu7cB8snh1/
 DNBIpgdiUvo9JBTUECqDUCGZbHtwoqNEXrUKkqJjUD+VjyMDjlIKQbYBkzAdUyXrNq37
 VQntjPMMPNE+//YQhZHuwTwzRtjzcm51phltdCo0wcD+wT/dFp6Vt2rohgp/08bhPzw2
 QHJRGZE/wFXWvDnVnHiQ/F9v2LAZytb+6JgPqq08t5giS1TKY7YxqzVaEDMIp2+25OQO
 oWnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC1QTzi/lfbiV8F4eimmCRIQDtSD5grZfzRR9kWD1Gbzm0z+9afuCjy76rv6wpKWNpBXg4VU4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKlck84LJJEmSpLw964tc05iVaOCnqK3qBfTlSwrm/i6WkSSNQ0
 ybXgOOKArunGe5HUMzsu2jz9SAUy5ztQvtz/dGEy8SZ/aC3MrMd60Opi1OIm9bJfNQNY4G/rOoY
 arsf94nc2golz8C8KjWKqpb6DYaiYLibZnIAvpO2IKTu9YhxtrJHacpc9O5DJ9vsrEUu7kjKSbF
 jk0nU=
X-Gm-Gg: AYBFou2EBjOoOzFPBW7bj/AAZaDk7ujQN9w8zMUhk29F+hjELdGnZcJP9bLPktzaqzY
 UdSFOjdoYELeNOcCyXFVw6agOhsu6iQE3kaB/WX5FtagQSQWG09KrIynFvDDc4lyThlEd2j530Z
 FKzxXYHUNzXA5wnEjg08uADUrLWV+ERW2D55pQdW9+yynIYLzJqQ0cgn/BxG3UqbbSEaFQ0yV9A
 SbxULd0Xj7uppZ+2KRFe7w6W4ViqnCcKU6BTo9c2X4csvtDFtPtBxoa+RHid6K7hbVkAag859gO
 V7e4KPROvBas2EZ9IVwQqz+kxdAcWCaD14dBDfZse4AMHXv87v+/A9/LF1wQbnNhSrz18p8rwgY
 XscQsWZsg8LwJ6nwGJAl9N8NVbRw+A8U2nmy/hUw0q2N5wZ7jrXpRHKQN4iIsu47EGhMfIhRHVD
 9yQ3rpXeroQIXp
X-Received: by 2002:a05:620a:439f:b0:93f:6375:aaa0 with SMTP id
 af79cd13be357-9442172dcf4mr1414912885a.80.1793610718230; 
 Mon, 02 Nov 2026 01:11:58 -0800 (PST)
X-Received: by 2002:a05:620a:439f:b0:93f:6375:aaa0 with SMTP id
 af79cd13be357-9442172dcf4mr1414910185a.80.1793610717759; 
 Mon, 02 Nov 2026 01:11:57 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b523152169sm614771a12.30.2026.11.02.01.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:11:56 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 10:11:47 +0100
Subject: [PATCH] usb: dwc3: gadget: make Set Endpoint Configuration macros safe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAMAxA0atI1gZMnKhXERelTTULB1pQQby7x
 eVb/P9AkqiSYCgeiHJq0n3LoLIAt9htFlSfDVxxR1Qx+svV6OVwYcbVurgnZOqp5caYYDzk8Ig
 S9P6n4/S+Hzp9MUBkAAAA
X-Change-ID: 20261102-dwc3-depcfg-macros-217152499f9d
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae853df cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kkQ8xf5MS9C9YOm1cowA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: g-JnhLQYxDaYdx2fRTF5IlgpNYehT2rj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNiBTYWx0ZWRfXzu9AVCHP3X65
 EPd79bd3QJYQV/sz4aQmALGqkXsn/dcqIM5VdiQiR5ZwcYmVWti2PSF++q1Dyuu4ndzga8D+fXK
 9nOEBRqoSu+plmBemwoZNWLx8Ct2xA4=
X-Proofpoint-ORIG-GUID: g-JnhLQYxDaYdx2fRTF5IlgpNYehT2rj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNiBTYWx0ZWRfX4Hdg0HK4ZtQ0
 LmBO0mdgfodtZsvqp4rYyXtvTPohUTm6jE+FFOC7vAeNlpqcOJLcnVCFOYDoVP2vNnX2X1us1dr
 stkrxK/Pmnwlpye7VfpayZMqs2bZ67AglpR8SvarWVTXk/boSq/mGSBz1J0vss9G4KnAPWAFahN
 hpOPbHA0J4PQor43364aIZ2hYyw+ByMc/uq7dsMeqchBGtRudVobKd8rK4TMV+s0rx63MOp09zr
 cY2jUoqBSiYZ5xp3xkicD2MUC1+equUqKUJs7jwvUy/94BDt6/Sj4SS2ziLDN4LsgeKzoLhaR8F
 vxQd93Fzvj63c8IcwhvXWeFMCySlwEL9mJYFoXQU0uaWznXVEoYKCNRFRD9vaXIR7htdPoGX91h
 XYLtly9AhTJHH9JdJEwQ6M3d934EsUgz+EdM2LNzm9B0nwAnBBI7rLqLeoSB9tOEs3O7qTpOkX6
 2y7KPixlSd0JGUPvQQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020036
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DEPCFG field macros shift their argument without masking it, so an
out-of-range value spills into the neighbouring fields. This happens
on every SuperSpeed bulk endpoint: no gadget function sets
usb_ep.maxburst, dwc3_gadget_set_ep_config() programs maxburst - 1 =
0xffffffff as the burst size, and DWC3_DEPCFG_BURST_SIZE() sets bits
31:22 of parameter 0 - the data sequence number and the configuration
action as well as the burst size. The fastboot bulk-out endpoint, for
example, is configured with parameter 0 0xffc02004 instead of
0x03c02004.

Mask each field to its width, as Linux does since commit 7369090a9fb5
("usb: dwc3: gadget: make Set Endpoint Configuration macros safe").
A maxburst of 0 still yields the burst size of 16 the endpoints get
today, so only the fields beyond the burst size change.

Fixes: 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to u-boot")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Tested at SuperSpeed on QCM2290 (DWC3), host Linux 7.0, with fastboot
and with the mass storage SuperSpeed support from u-boot-dfu next:
parameter 0 of the bulk endpoints goes from 0xffc02004/0xffc22004 to
0x03c02004/0x03c22004, the burst size stays 16 and the throughput is
unchanged (fastboot download of 100 MiB in 1.76 s).
---
 drivers/usb/dwc3/gadget.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index e4f5a096956..2e864adf53d 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -27,23 +27,23 @@ struct dwc3;
 #define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
 
 /* DEPCFG parameter 1 */
-#define DWC3_DEPCFG_INT_NUM(n)		((n) << 0)
+#define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
 #define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
 #define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
-#define DWC3_DEPCFG_BINTERVAL_M1(n)	((n) << 16)
+#define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
-#define DWC3_DEPCFG_EP_NUMBER(n)	((n) << 25)
+#define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
 #define DWC3_DEPCFG_BULK_BASED		(1 << 30)
 #define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
 
 /* DEPCFG parameter 0 */
-#define DWC3_DEPCFG_EP_TYPE(n)		((n) << 1)
-#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	((n) << 3)
-#define DWC3_DEPCFG_FIFO_NUMBER(n)	((n) << 17)
-#define DWC3_DEPCFG_BURST_SIZE(n)	((n) << 22)
+#define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
+#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	(((n) & 0x7ff) << 3)
+#define DWC3_DEPCFG_FIFO_NUMBER(n)	(((n) & 0x1f) << 17)
+#define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
 #define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261102-dwc3-depcfg-macros-217152499f9d

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

