Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D40ACA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3241660715;
	Mon, 12 Oct 2026 20:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id donzsqdBK7Wh; Mon, 12 Oct 2026 20:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CA56606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836737;
	b=SxpQAiWOZSmgrUxYkv7tK1sUBuybYdNgsBgfcZBjj5gUsZl/TpzcF8JOwTx5TUqCNupk
	 4zqGo8EarBRvYMPA9zNM0aUJL92bm9Y1pLUr74rlXqU/JK6J8wZbiDd/hzl5mUtEfshrH
	 YTd4nA2p+2VLO9vLQq2GzysvPP31t+8HMc9TFPhMl8jm+qdElKWbYC/y4HLU4prsbVkLt
	 Iu4Q10DacBsab0taq9+bjJFL6Nob58szXNFcUGVAo0SvQrDdWqG2L+klwzWUI2rFAn3jG
	 WCuf1dyafjy5U9Afww0yRcaXMkj/Q3baJRBE0Sand9g/6brOMbKkt2Gty/GR4p+w1ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=;
	b=LVPoI9sr4STBSt+QQ948q2wOj8nQI1+lm31q8eHJAIu4cM4vBq3ZD39vG99yW2NQZ4u3
	 oOldWrZm/5aceFKnk9Uf+p/uhmEzA3r/tZuunNzcd0QGbZPJJzd2Q5qV5/X50fjnQxMTs
	 REi81xLquAChfhV/XsvYNR01DgEwj8ftaZyfRGihRHNebmY6+QsefuYqXHO2LTTtaUbVu
	 fsXw/qevIlln6FBLb0uFC8dUHyYeAIAD8FpWWeyFeRsC5k540Fhq6ZGSh/NQVH3NTcKkE
	 oy+honlPHNOB69kI/d5MioQruTyxRyDWvm1AEGTKgoLPO6hifqXgn9Q8xMhvbGAeUtw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CdLnxqOk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TkTGlCrN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836737;
	bh=eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hyeeKekQgsgh/32mrMDox/IZJw26xvAq5DpyF0TSm0Jl1ES8cTDEAPMh5L1LxuYUU
	 oNJMKSvyocCf30tRyjf4DuMjLAn/+I7aXGB5Rj2RF47d8L1B3wPDJdmJ5M/y6clUPl
	 VE5qwCKXVhfCU3U/QC60nW6aKgPtvpqmY3Itpm6dJVozPwW/KohLHCTcnq6KfPQ5Pz
	 VeUl3VLlqE/MJEN1KenpyOj5cVVZVyj37VpicUJ8AaIOQ7gUGl6bCUF6paZ7P94fNS
	 91IhDV5WbJgPgxESf4TNyLqkWTPlIxlq87KaX9kuFuXJWhpa5wFyRJyZGc6GZkJ9z3
	 g+DgH0caYjcKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CA56606FD;
	Mon, 12 Oct 2026 20:25:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E972A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 408DE60653
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqeVi-N-n8X2 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C19C606BE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836734;
 b=SD+jTeKvd8R+DuMkGl03SbUQH5ee5Jtb5R3INPIpxctYApwYajSvj7d0kxczea/01leH
 boziYw2fZ3NaKII8VmSER/WNLdYWLjwzGt4k+wEKnHxJatMk/b9IL+5Qtr3k467Kv0ZY4
 lbXUWl28vMafyHFZzBaoCFyqmlNpejiDkOQmZJIVFwgchD5fLJLtVT1qoGolWe8u3OAC2
 pbCjEemHhfWHz/lASbmAtzxGrl0zJIU3P//ofy59qAV6mIg5UdUUYcD7DoV4siz02TmgY
 7IMFsFeyhUkzcihxRAfOuX5rXAd/86BVrYQnFlv99+Aqyh9MRZpQf4nHQ4RAZy2fqDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836734;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=;
 b=tKHvmmfZJJ0y26Fcw9Ss3IduBcQEpmwE29qRQsZTRu5zv0iZcUK7Y1j3eoYVW8ZDUsAW
 WqtNrt0XD+ozdtblwjcwndrOTtFKDTX+D59qOXbn4XIyHTlINcIUA3te77/XvaV/IY0kI
 ifPjvjrv6k425IUwiTl2pOTCZ1IVW5tyIBTvxq0ZXVAdFAG4b/lsWBh7TIGi14xB5Xu1W
 FUm6KsGTFj70lQjy5ftnJ4Rw5xhg9+1epPLfoDIkGQlNxvr84Kl10YGx+nrKwfpKrsV0u
 WIVUnj+3XR5cQN9zv9YuMyOxYQYVfpLpVo4MYOf8lnxdysEl2lDH8XrqP4v75UlwjQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CdLnxqOk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TkTGlCrN; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CdLnxqOk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TkTGlCrN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C19C606BE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMluu079967
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=; b=CdLnxqOklYQ9evN9
 o1oI1QX6h6Gq55rwRK8WJU73ZtVjT1k17Bnug7csOP291xN70FULtSLrzBqCXQ/g
 eGSb10r41DwWpQoB+3/nBWR+vM2R7z8WIecfLJ2205UKJPfkI8UYIacklhMGlhXx
 UGwWD2cYgOr7Wm0YHJWdvPbG9wsfwOeezUWiRjYZVsUean1H9Hu0Rf1eDTQ8L26E
 WHBdH5poy318QF8Z3aM4pw8dotC2LJcaywbC2qDgtaLgb8YwJMIDRb6DnUYvloJq
 x7/urllaPRaLh6VUSeQ+kJD9ygzydwecZVpXhvvqV8nI3qJqm45oaTmfxC5KQUGz
 e/b+dQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3kapk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc40759b2so516405985a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836732; x=1792441532;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=;
 b=TkTGlCrN/vOrXE8NF5oVZipnZ0fMmfZ7sBqXmsJ+S5QNNf36x5MSeoNPsOp5AncZee
 O7DxbsIPWv/Z2pnhVTMbbfxAPmEZv4yoTVMynqn2dRY7ZGdtlsZQu+yljlEaxw0d1HVS
 oF2unw0QQuaYtvVDZZINrO6usC0EyvZ9/oiD8NAYXScEPp0+1pyHyhsK5+VQUxGJxGRX
 49OfKe4bZWiXUNIizKd3eAHiYmvNg1i2VPiEU5dnBrcpmLH85OSJ8pFBXRoMYhal/y3Y
 kwqucovOKrZtoLHbWca+RZSaz/HJtvXQfEhSQCDp+R9woN1oVZJ57qCIa83T8kOTlzHJ
 u2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836732; x=1792441532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQZutaVU6WILF35iPyQCw8qqjEf9RaZFl2zQ2xJvu8I=;
 b=syt85c2sEDqsRgYibbAgilfWPo5UV0kvzmXa8FDfSX+7bibueoDcOaV8E5IaaeryNq
 Du3p1ib0AEJmhjXmIiq8MX2oskGDMVzIXPhsv8OWiqqSF++Oyqrc76toR1sToDFL0FwB
 5C4J0/Aa0plpXhSGe560nz4DG5FZu+75f0OuxJMVpvRConAXNXWY+VaOx4iNKDMHMnv2
 Y6o//zXdvP3NayZNvmrJitusu5EMM2qt4fn/GCtN8BbPDvQp/KFhjcD46QWcy42m5D5u
 UebhFOHDIyjikgCiO4cD4ObRrr6hmUcu6SlQWNkwxw/VA7xeOyLyAAaxR7XLTVuD63Ug
 E6hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbOfWFNil1nXkjUM5etAFMnpXpkMpVQRZ8yrqJSR8ll4G6FVWYpBw6ff+dilCOoDqQ6CLKBsk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLzGe2Dc3v0GXuBwfDqCyZx6AcJ8hnTPrfHR2Wz/RdcLGiv7Ig5
 fWlp3XPM3/0G22cu2YGOf+puzojCclRKRayFmy4n83ktK3f6KqGn/e6boiin8giBkophv1xyS+x
 M2ZnXE59kiCwxXpetKxvfnxfRIAEm5Vcdu4SUTt7nuSf01eFapMkOFubrn9p1sqY/icN0MMiW3M
 V5JVdZabvG
X-Gm-Gg: AYBFou3/zXAmGRACUeJ7AiHnjViaZlCuZpMZ5A1uzCsIDfjIHZZpjyuwxUBVkRfx4ZR
 9DSTLrUNb5+PB2s1bCrBzQS8zXnKDZrXxm0FaRID2g/bxATS1SicIBIIRf9Jt+e9MV7Cj8vYkR/
 5nkWD7O7naT776dUdWkVxEcxO1eJGiavVOws9KJZMnz/jUgkrNH9R03eQGinvM8Nxo/XwBI4J97
 JpKE3VdYPG4zsdtDtk6RvVm4N2dXSUjKny8ThnpNEM22+7qyWMhe2p3CKBB+3+L6zbBPyWuDDJb
 jNi0H3vYofmUEsK9Vt0tVOsvT7JBjRoStStKhojglpjhjOTmpT3FWJ0wH3lIntkQO7KtEhwC8PR
 kRTsJbqXMjI2Kb7G/7YiprLtxdjt4CyDNhK9oPaMfauky
X-Received: by 2002:a05:620a:6489:b0:93e:7583:3518 with SMTP id
 af79cd13be357-93ebd207988mr1673548785a.33.1791836732126; 
 Mon, 12 Oct 2026 13:25:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93e:7583:3518 with SMTP id
 af79cd13be357-93ebd207988mr1673544485a.33.1791836731335; 
 Mon, 12 Oct 2026 13:25:31 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:29 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:25:06 +0200
Subject: [PATCH v2 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-4-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX697+Dyy0U6mz
 PKkDTbHftuXlq46rlfw7VocX+0+37DG3T2UyYp8HqtjXup4ax4/L9nJ6IoOK2hAqLjVdbBiUNBl
 NSnVbSuN675f/P4SMbuw/PsYNJuwiCOckcKweOthUsNTcwrEsK/gap/gDeJ25qdAedb5Of8AlWH
 JPquuB9Q3VFHCqYY1qMOB4m3LkprIY7b3/RCjYONpeQS2BOCykjkCEt6HvgubYkePaQftwxlviL
 D6uVHB55hTBPP3gqirR/hVni2g2J+Tl9Aitf4/hffEo66tuOzeZW/to3Gkt3jZg072tJK6S7s+e
 rbR4rC9VITw678X7h4ab8ijUiSzUjONoeARs+gWAjuysHCCz8NJGjxT7ABslCOAB+SW8sbvQziv
 RjczxmNOTyi8Tp5zMZ3b5fA74u3t6biiC5L8zLM5JoKHn4zEmZ6BFRYx0n5cctUxua0ZlP5UxCY
 8CtBs1kDLHCnodvBKJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX4gDhCCRiZi57
 eu5GRDCyHzRf1d2ow2nV4kux2PM8VtQ2jP8s9kC97zYQA3ONXsWkubjcfiCRZi9QVoy5Y6b8fxt
 8pQSCW1x0csNj6PSdmDs4LBWUAnQ1Nk=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd423d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QXJ5I8zeXNOPBeAt2n4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: nu1bH0Ir9NXLkqAl0704uizGjNuBXwnB
X-Proofpoint-GUID: nu1bH0Ir9NXLkqAl0704uizGjNuBXwnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120081
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

Android's fastboot client changes the device lock state with
"fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
the "avb lock/unlock" shell commands) but no fastboot front end for it, so
a device could only be unlocked from the serial console.

Add the three commands and the "unlocked" variable behind
CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
userdata (and metadata, which holds the file based encryption keys) before
the state changes and are refused when userdata cannot be erased; the TA
resets the rollback indexes on a state change. get_unlock_ability always
reports 1 since U-Boot does not evaluate the "OEM unlocking" setting
Android keeps in the frp partition.

Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
erase the partitions and flip the state reported by getvar unlocked and
"avb is_unlocked".

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      |  11 ++++
 drivers/fastboot/fb_command.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  34 ++++++++++++
 include/fastboot.h            |   3 ++
 4 files changed, 167 insertions(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1887f78bcec..b5ca8c8dcb5 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -248,6 +248,17 @@ config FASTBOOT_MBR_NAME
 	  specified on the "fastboot flash" command line matches the value
 	  defined here. The default target name for updating MBR is "mbr".
 
+config FASTBOOT_CMD_FLASHING
+	bool "Enable the 'flashing lock/unlock/get_unlock_ability' commands"
+	depends on FASTBOOT_FLASH_MMC && AVB_VERIFY && OPTEE_TA_AVB
+	help
+	  Add the Android "flashing lock", "flashing unlock" and "flashing
+	  get_unlock_ability" commands and the "unlocked" variable. The device
+	  lock state is the one AVB enforces, kept by the OP-TEE AVB TA. As
+	  required by AVB, the userdata (and metadata) partition is erased
+	  before the state changes in either direction, and the TA resets the
+	  rollback indexes on a state change.
+
 config FASTBOOT_CMD_OEM_FORMAT
 	bool "Enable the 'oem format' command"
 	depends on FASTBOOT_FLASH_MMC && CMD_GPT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..9bf012645ef 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -16,6 +16,9 @@
 #include <stdlib.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+#endif
 
 /**
  * image_size - final fastboot image size
@@ -47,6 +50,11 @@ static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
+#endif
 
 static const struct {
 	const char *command;
@@ -128,6 +136,20 @@ static const struct {
 		.command = "ACmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING,
+					      (flashing_get_unlock_ability),
+					      (NULL))
+	},
 };
 
 /**
@@ -589,3 +611,100 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/**
+ * flashing_set_lock() - set the AVB device lock state through the AVB TA
+ *
+ * @locked: new state
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+static int flashing_set_lock(bool locked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		fastboot_fail("cannot allocate AVB ops", response);
+		return -1;
+	}
+
+	rc = avb_write_lock_state(ops, locked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot change the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_wipe_userdata() - erase userdata and metadata
+ *
+ * AVB requires user data to be wiped on every change of the device state,
+ * in either direction, so userdata (and metadata, which holds the file
+ * based encryption keys) are erased before the state changes.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 when userdata could not be erased
+ */
+static int flashing_wipe_userdata(char *response)
+{
+	fastboot_mmc_erase("userdata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	/* metadata is optional on older layouts */
+	fastboot_mmc_erase("metadata", response);
+
+	return 0;
+}
+
+/**
+ * flashing_lock() - lock the device
+ *
+ * Verification errors stop the boot afterwards. The AVB TA resets the
+ * rollback indexes on a state change.
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(true, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_unlock() - unlock the device
+ *
+ * The unlock is refused if userdata cannot be erased.
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(false, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_get_unlock_ability() - report whether unlocking is allowed
+ *
+ * Android gates this on the "OEM unlocking" developer setting, stored by
+ * the OS in the frp partition; there is no policy for it in U-Boot, so
+ * unlocking is always possible.
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	fastboot_okay("1", response);
+}
+#endif /* FASTBOOT_CMD_FLASHING */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..92c8e702a0b 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -28,6 +28,7 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+static void getvar_unlocked(char *var_parameter, char *response);
 
 static const struct {
 	const char *variable;
@@ -88,6 +89,10 @@ static const struct {
 		.dispatch = getvar_partition_size,
 		.list = false
 #endif
+	}, {
+		.variable = "unlocked",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (getvar_unlocked), (NULL)),
+		.list = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
 	}, {
 		.variable = "is-userspace",
 		.dispatch = getvar_is_userspace,
@@ -346,3 +351,32 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 		fastboot_fail("Variable not implemented", response);
 	}
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+
+/* "yes" when the device is unlocked according to the AVB TA, else "no" */
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	AvbOps *ops;
+	bool unlocked = false;
+	AvbIOResult rc;
+
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		fastboot_fail("cannot allocate AVB ops", response);
+		return;
+	}
+	rc = ops->read_is_device_unlocked(ops, &unlocked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot read the device lock state", response);
+		return;
+	}
+	fastboot_okay(unlocked ? "yes" : "no", response);
+}
+#else
+static void __maybe_unused getvar_unlocked(char *var_parameter, char *response)
+{
+}
+#endif
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..e8b6e293173 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -53,6 +53,9 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_COUNT
 };
 

-- 
2.53.0

