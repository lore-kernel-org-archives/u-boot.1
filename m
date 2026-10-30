Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wEZWINpg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZBKJuihj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Da6LfRf5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0146240ACF;
	Fri, 30 Oct 2026 12:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCZTgItRAuiG; Fri, 30 Oct 2026 12:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4235B406DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364272;
	b=MKkib9I3oqjusEq4gGYAaqlrPsEXdQuxPYXWLFl+r5GfYsDXrIUJwMumjp2Vv5xy6nJt
	 fyZXu95A2YPHm1wlrpHEOPoanZh3bx3VbWxiaV7N08flnkx/rnNFrpm2VOsyDO6EUHLjR
	 uYNJC05ZYIQXNhAjUrHi970hKvSYPsxmBea8UREqVmBztf3RyPJs2wARZQ8ZUFFJvfL7r
	 Qd6tpBM1RfYC3Er8MKVc9i6480BUBBRMZuQPg9L5039deLxReak2lPYZQkSL1L3IIgdkV
	 o5nrWZw7gUHKKd6aN0aYFA1VXxvtwqPDFXC0bhC8GW0cc0SVg3+6bpf8Zx+uBM/5LfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=;
	b=PpeidvhHjkJrntTW1LEdoMLxsjqhNthRc7wJiaZuTiQOfapsPU5AUcN0ppHkqMKEtXmO
	 ZhWwfv5Fw4Hi2g3DLrHrxC5csE46LoL1xXNgqPWiGBxEPC2hHNMayT7zfyCOnHfwcww61
	 MhwFUM3V5vnfwPV0Z0HtTu4WRHK8e9tAINMUGkVC7PY6aMoHw8O6W2yZmYUikBK2ni5Oi
	 Vz6Rw6OOMXn983tIC+l8JLUSKnDHyz7gaceX7PiLG20u0vqT1TthUIYJ2fc/utlN2p5qG
	 iumCmPSwX1x1HPsux4/OI0FBtYozWERt3tTP08qrExE+0BNuYncXyn0QRCLlkUsHN6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZBKJuihj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Da6LfRf5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364272;
	bh=VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wEZWINpgH4c+MzneB7Igs7KU7e6ebcxAmUhjHNMF+rk8s1W3Irc3pNugqaht/8ezH
	 AYd1ga9POcXPXryS4H7XUBpyUMjBtUPwWK8D8kOvsMlJimMcaz/cPO1nvGMtkIDDc7
	 Z32g4JZGiMUuDKjAKjAy+FADoaPanPipu1HNExQBk/c1rkvownrwF3KPBf2Rf8EERv
	 R6BfStRS+jBm91kgSVEUE7/Ad4KqCpK9i/iY05cMRKmqOak/MMOmC/QDTj10SqH+nv
	 QF20aehOXImOiLshx4RLwllvBcf0rGMI3RZ5RFvss4tUn9CLS7LS+q/gHdRwg9UBXU
	 J3CLsA6YIn27A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4235B406DF;
	Fri, 30 Oct 2026 12:44:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B4244BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C8BC406DF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbAgfJxHso5b for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99BB3406DD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793364269;
 b=KW8y4pfTGv71NaKuygQ68RJWf8cbn5s/YFOMhTuudCaCSKVLTNoVjxUeK4qT1IxsFUtI
 iVH7jYzF3Q8FRY5VYgYUPNpFqGwJ4SfnJd3CQ+df6fKx/cpMIOBi1me7ZDWVaKWsHJaJv
 xTmMRP22Gi/IF3ZyFEkwlWAVGr0avuppv4YMMJjqA8WCrcLYHSTlsrzkiW2th4+MqsxQS
 Kua53Eid0jq8jSR8f8OqNszV/a9C7lRYhOMjrBw6bQDIlBIQOXfq0SV5+vjB27bdnfCiy
 d50CvMZw0rWb8YvtzMgK12jueLIWPKrqSsQW3NBWosT1V6pSt7xAlAWrSI+3WKrtCyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364269;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=;
 b=eQzNV/K4c/2v9Fbh3MFFrLVCIpsPmzZfrC4s94vCCiRMkc29+oUIsrqQChY3Jt2AW96P
 ghORpy8sAuUzwgF5Yq9XqfMSTJTjVboiShoQjhRNuK5RI0r2lMQ3Rlw6TTPMtKHkS17je
 hV9Zzkcud5TJqSDwSXLndDXGBJ5aRWzKSWeCKBSRIFTS3gVxAavsrD0uyoy5kIaX9Nmi7
 sCXkZa1wmFWTMaZwuDVBfwbH3uS6Ewln8r5F6q4HtRpyRYjqChpzBoLpuV4KHIaKVJi9U
 2RRmqSuJ9uBmzty4eXZF83gDmSzjvjsgFbjOLxpIL7BMKfiY/UsYfSDroiiMx07Jz7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZBKJuihj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Da6LfRf5; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZBKJuihj; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Da6LfRf5
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99BB3406DD
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:44:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG9XW3719624
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=; b=ZBKJuihjrariYvkK
 dd66iGlsyU2LfvVJUaMVhDMTsORgBoBp0ZI/7b8SY8d4EaJGFZ9gBf4LDKQRMxyu
 4A1o3Ygd5nneldotI+eMPgNvyBDQgEpTFWxNoKRDIhljcWDId0I7lU7ncOXt04O1
 gRlknGTYcRnTKsMf5AFjLVqeH09UmwF8+Dref6ElNJoSjjtF/S6EL8Qw2VMMqmd6
 ptW4HhGWq/yayEo8Y8hYXoGU3Ba45dSI98z2bBQLbsQJGAJVgOvP/X0+v/CkSfYI
 ScoljrhwVKQyG2lXZF+P4nFu69F3mQWkErO8W/xfSe+AydSsXmgibVmY0e4vj4ZV
 kxg8uQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qu1f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:44:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b12b209c4dso7553807b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793364267; x=1793969067;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=;
 b=Da6LfRf5AkuGhy+OImeehRS6dQrARaHJUHY8Zshk+egzImhj03Bp6G6+MYqYMke28N
 1hyrSoaCwEsMACZJBC9iTMd0XBdua0r2jJ18qjqAPYgSo9r5T1h9m2BJYp1VbE+OAjIQ
 CmeQDVzmzdsw/mwyfvWNUl1STtZvxGnWAgcNynWBZxIcY8UzJk8tkuaz3SCTROc7uDNM
 m1KY1pl6i3QEoYcqexQfxv/SDNffVI/g/zI6nMqGrDuH7VJQnwTgAV/Zvp3VoEkUUgdz
 SBAvYHrErbpmsT5kS8JNXLMNdfHk75x+Lg+jiE5JeY2Y/BLLGE047rUTw27QuwXvem0Z
 ftqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364267; x=1793969067;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VyQktk/KjOtTnJYhXxTp/sp41CGdRYiiCXyYBE7YD4g=;
 b=hf4TgjIpnoCYLysypvNwWk2vM3GFOEuTe+DHA2y8UcyYcdIS9OoRIuK04fzxqMdKdu
 x/o8MgloXvlUHmk8ylQvAro4xqWTOQkVMJfV3MuQandvkw8kQGGzCDVf2ApzqHernV05
 GiPh4L5JUnOy2c0vl5EA3UMA0vEN988ea7fW/AMiAKlsDjc/ovflDAh3U7GGaw8tuBeM
 PBZDN/dqhJIKx5gmdt//yFafY6m1FJSxDTYhAARmBqBDzjf6acWufG0I1h5KQbdwPECE
 h7OBUPZyJ8IduwX0d0bkVKOsNMfENKzbEXu8haNZazpdlcmVnPT5+ZVZqjoyJOTIoCpq
 iC8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwl312qebp9s7/3ht2zVvL8ajZ+dihpw1FQDI2ZI/6yrtx+Oha7oDF8GrXs2OrRKtGM4dMGjEQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWULfJ9iUIGeabOqFYjv0t6LSzHw720MHvcasv3pqcGNVe+6z2
 6SrhtThPFNos8psZ+P9xwa0JtQaRHIgHfmd7zTJuGOp4JCSsLNdVh40jgAiRYMLqDoHO4an0VeC
 GYptwLfQ1RrfPXFc8WVQVSRkcPfASEwWElSnOV1F5zHY3SmY1m1rerpAxJMsflY/DkHYWN6Q=
X-Gm-Gg: AYBFou2ZZu560C45YQVLmKNNATCd00/VMO7yNXxnFJK0K6ZY/WMvjbCcBvSpYixoPqT
 FAnOwXUYVBeLNU37sOEOC7GMRVgqMnP2i7HWYhj0CMy2j/aiiYX+/ONJI+hTnofdQXE1/R4Iu0C
 qXFHj4UkORMntD+w6jJ8t2fFH2oN4hjqvleLr0xbadxgC8eTlWzx3uaxJQIg/gIn5TrBkkOl2GW
 1PM5w3UwH3VZYUHEh+N+8hoWLJpDd4JMH3BkvlyYIkQmC7j4y/HIcgpXZ6xsMXnaOVWUHSVvVNw
 zvdrYI++w1CmViP61lWoaagggSrjI58zSg0egcyg6k7W8RXfcHBWVa5QuNNhZth90y8G9PVjryL
 SJNcLOl/QmhpqG6F0RjcmoInEa0fmNdL+rv0ZXqhVVXc8uZTSovncylSvCDEEpKuwEKM+nvlydM
 C+q8kdZw7/K/FKpgqMmdI4hKol38jlxTYgyA==
X-Received: by 2002:a05:690c:ec3:b0:8b0:d978:db65 with SMTP id
 00721157ae682-8b2b6703057mr13272737b3.25.1793364267475; 
 Fri, 30 Oct 2026 05:44:27 -0700 (PDT)
X-Received: by 2002:a05:690c:ec3:b0:8b0:d978:db65 with SMTP id
 00721157ae682-8b2b6703057mr13272497b3.25.1793364266783; 
 Fri, 30 Oct 2026 05:44:26 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71bd543sm7530667b3.45.2026.10.30.05.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:44:26 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v2] armv8: mmu: sync emergency page table attribute updates
Date: Fri, 30 Oct 2026 08:44:24 -0400
Message-ID: <20261030124425.455316-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
References: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IubbXxFN1bePoa4lO3zZWvruYOvL5sgm
X-Proofpoint-ORIG-GUID: IubbXxFN1bePoa4lO3zZWvruYOvL5sgm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX50ipOcMjpBR2
 oFVLvnrEHfinR3x/fMHBrm+IS/Lo/q21XoKAEbsNLeDeNCyN+UDfxMFasHg0gaFqfygH8NG/C5S
 QL1jd+W1BK5azCxxV/je/sqWnpumQDNn7Hr8wLyR/pWLS2Kf26K4GwhqzvfRPqjKJeMf+oYLx3e
 J5cmRTZ2Ywpgrjyi+737SPD/uQmiMZj4lwqkxUAm1R629SvyhnESdIPS0mFv91dBlqsbz0d+tyr
 Y9Xtp44QcZ0NaETMCPHrzutJJvUk5LpkFYQN9Qn24R7NdQFZyhjXMIr0wQE0BYNmFQCr7psTiGm
 g2ZfuLfAVpFBVhrALKvCNfwHPByaoSOgfsWGvnAXcKb7r4b7GGgVK9V1+6p3LYHGqy/QgSaKrmT
 2iD+L/rMd5pFKTi9OLPoKSs+agdwfvtNnRB1OQ5QVi/oVCrOKHCWYAiyFLcFINUI8rqZ9FNkMAB
 QpGMl16dYTmrky/vdjA==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4912b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KSd4FLL6wG3oBfiDDXgA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXyvkIqZJ54KcW
 77fEdkEBJCfb2Qy6XF73VHyM2nkIGfg91KAhCVm1qcfB7tiz/2Es8N7CXU/9OyLTKlyosLg9jO3
 YPx/MldW7EbElSdxjvkUqV5+ff7ZGlM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 at 23:10, Aswin Murugan wrote:
[...]
> Update both primary and emergency page tables when modifying
> region attributes to keep mappings consistent regardless of the
> active translation table.

nit: mmu_set_region_dcache_behaviour() still only updates the primary table.

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
