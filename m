Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52A606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ceZUPmyO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iUDYIUrN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YMCjKu1X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68D364089D;
	Wed, 21 Oct 2026 16:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IsQC05PTkQ7t; Wed, 21 Oct 2026 16:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CD97406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599023;
	b=mWBxl974uwqssWJg90XI5bSSMAocLlcuV0NmNp3E0iEGokHf2Tj/LzpVN0E0rLWYb10E
	 fLuEyJ4aXFpvc789+NVgOKMMCbnnNKQwBR3j9MmsNnNnjCthC2RszitJCLpTjt9oQhXUb
	 AlYJNmupblgifLvK9yWpR2XBqF78NPxiLvBp9gjRar/B2tPuglxTWqutSwrBuR/BTE0/a
	 RkkhIfrYGXV5sEx8AmwKY+PGvDU5v9/IuUHWPXBMDCpVsUwFXLLI+ow1/r5IT/K1CeRKJ
	 /1vNZHmnMi1rhQvSZ2Qrms7dTrA/vktgc9noa1Ri5XQwlVnyFv5CH5sfHEUNwe9GK/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	b=D7iTUf6uq5WM4BeOHv460WAMNb1H2a0WrY3wfcvf2Gkhgi9xeC3uVszms494FOAeFkWM
	 4Occ3WfBL8NXknt7c0XvYSWP6pu5crZs+2y0pUcbq4p3AvOm5VTPKnyS3KtbLDdr7IkWz
	 voZpk3AiYsBQsd2kCfVqXHHTCQFpskMoZOZnsqSgMP6xlQ7GNfSR0Y6NG0VhXwrxFSO7g
	 14j1jma/qADjUzQ5g6zfVVgBq95HL3LDbq6nbhsebdz+kNiSAlP1lHD1EH/+4MrD8ms54
	 ST0WSjrEAxzSJCS5xbTssiwx/9fanXtyjffNj1wFg1gm1hi9opny2Sn1gs+dNIOPMJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599023;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ceZUPmyOffqeVT02zY2Xk++n7Y4mdQOXfIHqmes4iDSn7fiR3Czksurr/pWk65UpY
	 9V2w699Kd7hMPQljxMvoHBiZYTxEYCh+l0BpWgbY1M15C1chICCI482Aoy/S/gNMYL
	 vVSuHfTFYzZLl4+2ospRQzYIlWC8uuVNtEtapxgcNVsqhaDOUzbBWAb4rHDcWxAYMY
	 kxregxteoStdsd7Yzhv57jQnbaXTHjrWoZsrsAWM8x86F4MOx6HD+SQG9dDOxGhXfo
	 LgRKHe5THMZYur+GRJRZK3Q5wEHHbxjlrNZVZ+seoks9DZjaBJO8NsDapOBQ6DTj2m
	 gCZnMUZNJNJog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CD97406CF;
	Wed, 21 Oct 2026 16:10:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1446595C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05A7781164
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCSdFslqyeN9 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33204811D5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599021;
 b=plUQXkAZTNK7p/rkcNJ2yh920Ri7JgO6ZoBQryeAlhBTkZW/UewYPBVlmDT/vlNhPIB2
 fExzCfUN1mAhCKMJGI9x/jQQOSm25aE+Wy/6TaLtRY3U6TmImoBuBHxKjn2i+CxzVBoYn
 p51xI1yHHnyzsth41aEVyr9RBUDrzxoSNagf9XDxBXIEjapHWzOZwbkrJerjfWh+K+r+V
 xmyBaIk22eVMetMuF0YZmaQpl6bDLW8AMKwIFhUpAVjBzuhP09xrgw1ZYRrhfH13zwJnc
 uo/sehPql1Djp9LC7IcFGnYBBFdAo74BQcBm0lmGNtIUvIMs0No/nFbYS7B7N+nz5Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599021;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=JH94U9qgPmvCfcqsfdPn2lEF9Iy0t/DRn28Uh5yeg/h+wLhlHPLJQPNRT54zhhJyLKif
 MJ8VV0U1bFLEfVeZEzUZMEkUJsoHC2PPM9q21FQYodb8EBUkvE7jxFnf5jHzvNyPgAyjA
 c8hXCuIrWQstqXMaQBkrej5/99j+eeVKuIGMHPQD7Y/7n8+SAT33qU72/kF4Tj+3oTQ9O
 9UZ1pBl3TgfsmNjsZ5PKKcqtiF2FVJMjdm/ABvNs8Q8TzlOZr2Z36MsTBOry25ISlET49
 PLmkYePopufHvJdWQ/UxWjq0ABwHcs1A57f9kZL177rnuMQJkHAvDJZgsNQeBfBKqpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=iUDYIUrN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YMCjKu1X; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iUDYIUrN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YMCjKu1X
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33204811D5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG3QA7900412
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6HJlZOyIZNy
 v1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=; b=iUDYIUrNw7FgG/WbUVxY9sUdF9S
 4fNgvy/aucs85ooXNaAQOfcWfZVv967kUPK0XAbofUb4OUc5p0e8uXVBAv7N4zdU
 XtEtclQ2AfKElOh6Q5m86VQnsymjZQ21e/bVikqLgGz/TR7WTVCWgqrMeiWNNmA8
 eP2wKCuxFRfAcAASLirArPEJhFp11mwGb5Bn+EMGKPlTKGMLRLZhrz+tR0Giqdzp
 c7X+4nI58zARYR8VqJd1Wr6bK73+60bGe5hDlHOjb/RxKPEnPdmlkYDr1NN9c9qb
 kQPv71ywDtConOExlYJbnJLmMDN4gjXZt4XX6wPxcwqCtx9gwnV91wl/4cA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2g19v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1540605eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599016; x=1793203816;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=YMCjKu1XoRc/YNwhhGN4va7nbsye0lv1l+cQ//laPQoqx19HNp0v1hYqZqKw8Tpzbh
 0zwx7K3tl1g6owgPcwqUrrwe8Q8C45kjyZXLcSsBDjZx3O5O+UamEHs/xvKb0x1zOmZO
 kB+bcwDDRAPUc89teDx7G4LsSE4810C83hP6tT2lEfvas+0qKfCY99ujI7Q9EbJ6o7ka
 nyqWz5/G5B819fX6kEFahwcAixc32oVeMb8NRruhGMcJ9fic3or2ScU/Q6pr7bbfGuJ0
 Axs4ccL1xYHaNs6QTIjoGkXXrVayYnZmYJX8JQx2X6tD1BPHYOgxU995zSXjfQYPPZBN
 Lu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599016; x=1793203816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=c3LW2fnmJ3Zi6C5SJvwpBTGNW82p2R4fRodJVQQIBNwNcKCa98WCyN0pg3q/nrRg1W
 KZcDD6ri3/wMo2sSPKsWPdATjXMxbpJikWM8uM3h31+BUnhJemRF80yHEpZx15gGE86/
 I8fMH+6DBuzs/zH6DKFOBvzdn3YcnuOmP4vjhjU4ZknTCRM0CLCwZEj5aNIiBl4x2QwN
 9hjp9yRnzUEaIm8y6m7RoGpe01/v5bAwtt7iOjNb4O5+Q8Dxk53RC1frZAxW2PIP4Kpu
 UCUPsuLFp/zUyqq6rK4WxvvRsv7iKIyXMUVYRHysi4W03EQTlrfnpKxp2cmocaijc4XY
 4Zmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzraBW8U+B9uLaRP0cvdHhwJIwIFA77xCMBegDynJ55zHDiObXbnRkysdGF70WG6PXDy2zRVuY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK957AYXLanPe6sqYtCpxLSsa8EavJ85s+e76DfsHeus9tflU6S
 zJaBnu7e/Ae8Ks7n32508QiBUl7iJjaqc3AQSCLcs928uoGQu6ocWLdNWR8yuLRpVM8Ht3oV+QO
 jpxByZ2GVjlbY91TiqrjzgajjUWXSk9YNE55ZDUoV1CBB+ZfjsgUX2gl3/EgH6WnqfvLWhlI=
X-Gm-Gg: AYBFou2BStodR8O6tr+A33UZ/mvKGbE2ZvDYzDcs5FYStETMS+LmY45HB05/tIJHDRL
 lnVzn3jwFaBv6yyY/wtvmCC3X/tNuYm961wxGlsiq3Sb1MmCZY6MSSBTrd451OX3u9kZyoBk9Xk
 x+UUBi/2HiIfBUupKa2a1+UEiiylZ5QX4a6C2Xlx74vCD4SarFvKbo9h296nmHZPOIyafOxxFjN
 sYjmvh8XUeFtwZ07nK+VQCPzmEW+7MHDL/NWRJMiXNymJPtmM+GH6/xKkbDEG+NwrFhC2Tr6VQK
 4cccruN7IvO8unn2A1OoXzzMfaSHrygdQzTeqMPylUhd7rand4yLpDqo/HKjo4vtPfZjQSWXtmR
 Cfk5xNtKmaOGQkxNec/UsMysUpaI1tdY3pFzcFKhBJMqwio24at+STGqVffN877GaAdrMlQ1bbX
 fRc8I5C5aHRUq1GnAgrlo=
X-Received: by 2002:a05:7301:9a8d:b0:356:23dd:3c72 with SMTP id
 5a478bee46e88-3674a517fe4mr3652221eec.4.1792599016149; 
 Wed, 21 Oct 2026 09:10:16 -0700 (PDT)
X-Received: by 2002:a05:7301:9a8d:b0:356:23dd:3c72 with SMTP id
 5a478bee46e88-3674a517fe4mr3652176eec.4.1792599015583; 
 Wed, 21 Oct 2026 09:10:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:14 -0700 (PDT)
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
Subject: [PATCH v4 07/12] configs: qcom: add debug UART config fragment for
 shikra-evk
Date: Wed, 21 Oct 2026 21:39:11 +0530
Message-Id: <20261021160916.3894471-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX1wKsZMx+yI3W
 i0J6eaPOLHgZZ0vZKupfVLvHHBmfEeB429o1QJiZuUoZmLvzHLkK/Za+uUzE1UgfLhhq4yNkYAm
 8skUu87d1Z3E/dnTJ4r4qDHzxdV01PI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX4jcABZiJ5lUX
 yg/CuRfvDb2tphSQUhzow3uS+hKwdArTNsPx8gIyZRsaWaaNPEEStyFSpkkTkkElVpHUO0E0dKK
 GEcA0G9Fbiu6FP0X4xSe5WhSHLTz/dnLtHLiFhwyBL6aZBgnVUSQuj/dp62azJHvp5DiZidARiG
 vsYsd90tmd7stayF/8F3Rstj/9tdsbLOa4L2JOdWqBopYcLahHeZ/lCtXUqlXfUyI1YMSzmW5vI
 MI8eY4i0iTJknRMdq4Z82A88Tk7AZgeSxlCmGGHIG4v/Z4H0L1IvwX5NDKbcwnytlUVUiplTkGK
 sL44BRE35VA1gSOkgMI49p3AXxufzhEwlsUSO7syi/EoWlkgHDT4+NEKJa4cMcgTcNI7tpJMEF/
 Ycor45bd0t6hxKi4p8sCwVCRivD78dGT6f2oEibyOtBqXu94/wdjql/CrYmOyWapuEJvLq2mqZK
 3pwwzZa0Qr1vsW3MC3A==
X-Proofpoint-ORIG-GUID: wcQbcMJhWnetpY_1Dij83Tl0AQDxBYxi
X-Proofpoint-GUID: wcQbcMJhWnetpY_1Dij83Tl0AQDxBYxi
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad8e3eb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3Z-LdhOq5Ikn1NNAXfgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063
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

Enable early debug UART support for Shikra

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/debug-shikra-evk.config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/qualcomm/debug-shikra-evk.config

diff --git a/board/qualcomm/debug-shikra-evk.config b/board/qualcomm/debug-shikra-evk.config
new file mode 100644
index 00000000000..034ab3249cd
--- /dev/null
+++ b/board/qualcomm/debug-shikra-evk.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART_MSM_GENI=y
-- 
2.34.1

