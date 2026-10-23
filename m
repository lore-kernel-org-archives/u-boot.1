Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16242606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YeqiqxpL;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0tKkuHl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TuAnspoH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A134860668;
	Fri, 23 Oct 2026 08:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTCmqyDE0sWH; Fri, 23 Oct 2026 08:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 939C36065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792744832;
	b=dPYqUbFzbpM5YnCrBkr/8vlprmhMQn2as2LmjBjm2zQxuJl6UCj1ympGsBhAaZBmM37z
	 lRZzw/BC8e6JT+CSAXZ2j9rLwdbXCQORq09/Dm1cfiX192HdnSM6MX5N3Kxd+Lyv+CL7z
	 YpSECkeyT/5/J+PJbwWBDpWyyQedPsftw+Kt/v2j4/CcwjJdkegHbXviotIXVD2k85R5n
	 Mu+Ij16rjxIYH9Gxb0GoUsVmMtgXU7emUMnZWhIeq3emznczSqZOPaANK/wD4PeMQqVyf
	 6SKCfXsGHqAMkVci6AK0GlokM3w8w78etr8jgCmyXxSRMy8rhIm0z+oKC1DEbRJqM3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792744832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wKnzWtkqo5Qbb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=;
	b=i2PLLLYvXIZrJiq7I9zwZOowgvAIOUIYU8R7am6pVvBIytzKuyQ5G4pf9ZCjX6O9LMpN
	 DaP2XM8tCPMCRLPPZFQYvpbNpZVS/09/q5o93WpqQ5cv132cxNhlahivzRQhZdGpZzFAJ
	 JxltjYoLnZoRlU0LX3IZK31bMLrWqHDakrfZuUjDruh6Nbq6EpUhAmub2wtA9PJp+R7vW
	 ir6ajIl0c7hMe7LSwtDTrMqWMQV1iMj1Xzl2gYtBZaPVIn0PzFJ6vuLvdDmuwjaMVWZhR
	 Hc0DmaIkA/1KylXlm/WI/IxRANuOW0QXVqoS+6lG1SqFKl8xbqESjRfbbaiJRGxUUvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0tKkuHl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TuAnspoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792744832;
	bh=wKnzWtkqo5Qbb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YeqiqxpLayNqQelcCvKyNHLbE+6bKUpii0I2UQQO4s8FqXrlyY9nVKyG5g5Lr4+2w
	 S8Af+hmXZQP/rzFIMhxkaaRbKEq1IQCMXEZPM26xkFQ386sQPbAb026Ms0Gfi2eTKG
	 FrPrIeDJPojcZNOggnTuod4fCxyNyFF+DG/EQXfNyWNuHsI/Vi9QTJx/hUdO/LJ9B0
	 NQYD+Ms3/23cb62o2E5EPiI7/yMc2SrR0S0rmgzJrqpyBQh9I/3HnpaXdTKgl7lXxx
	 +R/pIM22lDkFOWQ7/rofPOtwTVh2J1tUsIieEfIyCnlxQwFJpu8jk1Oo9x9ZwV4MPB
	 xRW6/2NOA/C7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 939C36065A;
	Fri, 23 Oct 2026 08:40:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58E3949D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 564816065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwnK7OqvCQtI for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 08:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6240660650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792744828;
 b=RQt/Pr9RT4c8/CmeXv7YrywnEULrzLqZRn0t2DtyPzIiItQ8W5yZyE/m15a63kSegY5E
 aesgD41bwq0t8AemHO+Ik+LcTRTCzMxKsMyOdiIbavtl5Iv+MF+sRIcXsboBVOF6nAxYL
 gGC2U3JwrtIjtIwylkdgX7sFz33NHQoIah9tVjUrx6yCXotyo/MIO/YuIVqMNly2pXj9E
 wNMwRz9Qku26OJuBwCRWo/SfCBN3ZtTo2JX/XjysmKqOdqKtEvIl/8ZvdH2FGEa8Mk9gn
 O59oL158i892+pdlFss2Hdpz7DuF7gYDjpoAs0yTiEXgTxhzXDlyUEQyjMT9fjo2HmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792744828;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=wKnzWtkqo5Qbb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=;
 b=RqtA2JGYfFi3YbwaWh/xHSlC+lFGpllRtxb5HTrYiIAirzFnDo9dLFr0OrWjXi7HxChM
 wPgrEF/fzYDM4dr/ugP39c4xLj39EvN3xn6R6+NMxsu3+lA2gMu4FaIAQnVyjza6I9KOl
 sQ6dY5d0BAcJLP04Da/jY54ceUEOGCU+tjNB/KMupgc7BsGxbENobYBQtEEb5b6TjJqKH
 CZRzOM7pOMjYUgmGFMcZQ08daOGupCXNkTA9sV0vWWVc/HyDKdZ5VCjChWaNX3N+VvlMr
 vUx1yt9AqnHRSYAD1kELgZ9F3ZFgWq9XO4SSiqnYdhug5f3ZvfBP8hPJoFyuIqA30cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=X0tKkuHl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TuAnspoH; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=X0tKkuHl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TuAnspoH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6240660650
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FNRI3168100
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wKnzWtkqo5Q
 bb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=; b=X0tKkuHlxe/hi+GHgJcY1rYNXl9
 PFXfVgzxqswAzzByQhBg5ZxgRT28wf8tPaPj6PcYAKhbdon0mAZ1BdtNcVuRYQtJ
 QSgylz3qDa0m1YVT2HUtc8Be32vrjhd9RnabNxgVEGN88RcHdcJ0o+Yn7J7kC/e4
 Ttt9voTJKi3tMxhWDMIOvGrw3TTPkem5/TDCawD6WFOHK5oCLoKyCYxqGl1exAUw
 GUmzPZjaO7uYDDwuaIo0IxpenE+gOLus3UxPSRt4h+jmKWiKjV3+sn2aoWOem+XN
 PeqkL0l21SwxyF3owQQPzkZM+AWD0F85tRs1hir4l/f/DeMo7Wsm62wEKHw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmpard9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:27 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1665200f4c2so865884c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792744827; x=1793349627;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wKnzWtkqo5Qbb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=;
 b=TuAnspoHLgg4nKw3cd+RYkAYykBN3Y1LYFrNB46e74Zd/9mK/irPA3PV5xK1tWh6NI
 Dg3MGOfLBwDjaCqi2dkQuuuqrGcGhvpIfxZGDxhDJzs7mrv1GhFZxGfexxNhJrNJXlPL
 QIWJBOEM9CZBCReggM64FC1khenj6GTILaqp/qQTBwjh6H4ZVvirNs7zc9+IWQOubOUA
 9JhsS4mPfRi+xY1BHx14263YI87cdR5BXyAgLU34P0XG7e9A+Vq8z7Bb94l8F4auvuTt
 6Wi8ZiMsLPmsjnXmlXWe/Oys/OGppSf9+8BfNZ7lmXTzCsrIK1AT0Pedxh4ubLMbNURt
 nC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744827; x=1793349627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wKnzWtkqo5Qbb8AXLQzJ/rTg/AAosE++69KbcJUUQhQ=;
 b=r71iUyihMQn1BiLwcNFtgRbY2kZO68GE2/IH7wtP58ylfgCkc5cNmbVlElY5XmY1wK
 s66FEDhxnGMy9mDJ/TK3LeNBa7XASmwUZraD1zMWBfka5F6JAQ991IoUHnsErLhrvmuB
 OD8jRf10qX6LcFT1QPb/iLJ4h3FfAYq5T5sPnEqMr8w6GuRylLieU1O5ADdFhH1vI5F8
 zsbJYIQrnjlmsNza9LWkwM/ZQYFPJpI5K7e7XJOeyd64P57rBIIHkl/BkSb++aXXagVO
 xgMkXAFYYrdsda9GdBbdmtnD2yTK3UuQqdqaIo8KqdPbNGYlw38F2B8zSzgXfINOu4o0
 djYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBjKD+Z2XzbVJfg+LIaYdyEwm+YSOUfHBBCx50AXvoiZUlTd0oNlP/tIp0ze5qvth9wnwPyfs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJwa2pW8Gm9Y5EMhu05XNN1UDr/yw6NwbV+rZ5Zeh1/0/jYCcKq
 6ZbA72bL94Fv+n9leQzisau19OuQn7V2016g4n5LhCA5C5GMEbDmfh5JJoHCXtqk7ZsiL+dH8/B
 M5bZYn6nAag+bM8Tz0ZOms43zgQn3RHMXVoD2jnezRW42OfsZpopQICfQ7SEmQ/vITxl4ai8=
X-Gm-Gg: AYBFou1+U0KIDk1xG/6xa2smYW/AyHIRaeLuBQBHO9rXbox+mpYI1YIOE2zXLmlXYFO
 A/Szzz0/dcHCbYv3vXs6xTcY1SugEk8lVpqsgc8x3iTX2RXS47TanIMrYqFW4sQI3YhhvQMaCDI
 lo8KCYasoCjovTldyxiTkY/JWbOn7+I1RQkzUE5H8MQrH6Fvt9lQ8oTMUHfdKst5PcW3islbmO+
 Y1Otny7ckdMGCgCGIygqj0FWiAbmwy92A4WHWTBXGHyvzH9tiLNuW8p1RcVk0y5UoX477r7Ba5F
 /BcVFzV3YyWv5XynbkfmZ5FNH0F8Pe609PyvBE18Oe8eujsadEnUyKosJFuTi/cnp/Z9bgmIaY6
 5VcT/yScdJW+7KWq/imhhh21mzjc1rjtcORnTyZVVvF/GzbI=
X-Received: by 2002:a05:701b:4518:20b0:15e:9126:c60f with SMTP id
 a92af1059eb24-195c693c753mr2198019c88.29.1792744826437; 
 Fri, 23 Oct 2026 01:40:26 -0700 (PDT)
X-Received: by 2002:a05:701b:4518:20b0:15e:9126:c60f with SMTP id
 a92af1059eb24-195c693c753mr2197967c88.29.1792744825631; 
 Fri, 23 Oct 2026 01:40:25 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195ecee637csm4748516c88.21.2026.10.23.01.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:40:25 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/2] cdt: enable CDT for Shikra SPL
Date: Fri, 23 Oct 2026 01:40:18 -0700
Message-Id: <20261023084019.3722376-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX6wsznwnBTx0a
 heBZCOrV/QlVGKwPHDRRNzhElTWXLr3FD9XYoXSh9yv6OHLFRLX48z6186t9o8EqKkzv5F2lypb
 egNNUstQsBe1zCuoGcKqo82Lh+RcpVI=
X-Proofpoint-GUID: Dd-v4uFokntchEh1Pkg1KEMVTcCa9BUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfXydDbKrd7eWId
 jbeAaHdXenyNUEeU5JZir425sKYUD8xBKx61EWooEHmqH0V1OpPyo0is7bv9XAOKX/RLa6Xk+nn
 YWN2AFATaGsdZWEU8wF4B50gkF6+jQJ76n3WC9Hrqcy4XWxBi0tIQFEcQg7xYxFaFmZ3s0fUCce
 yl564gkMea4zq4EYt8ac1nQwLOMuzx4nnzAjAkQtskDmtLXIzcxC9dRSe0u4cZqpa2arHErbUSG
 72nDkfrN562j1QBMtBhlJPMubPklnhdwSI2YeGAv6TU5D843PUJWnmKsqEBAChC0EM4aYZlYGCF
 CxHspoTZwXv5Gn6BgReGKRyVjFtQUkODbUW2y0avtdiAwoJ6f30dW4AUj0UVFwFvIzv2TXX8kc4
 zYDzUkiqc6E+yxPlo3b5f6kjsYGoX3bSLw1bUSBbpKMZTvWWOyNs3WaRisEmhFFhjcEXOF2oHyF
 +QzC8j2p0EYOhdFWsCw==
X-Proofpoint-ORIG-GUID: Dd-v4uFokntchEh1Pkg1KEMVTcCa9BUI
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adb1d7b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=T4TYj3DXmppAdwKbj14A:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230034
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

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c        | 103 ++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |   1 +
 arch/arm/mach-snapdragon/qclib.c            |   8 ++
 board/qualcomm/shikra/spl-shikra.c          |  11 +++
 4 files changed, 123 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..9b9d98bf8fb 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -10,8 +10,12 @@
 #include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/kernel.h>
 #include <linux/err.h>
 #include <mach/qclib.h>
+#include <mach/spl.h>
+#include <memalign.h>
+#include <part.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
@@ -38,6 +42,105 @@ void __weak qcom_spl_soc_rpm_reset(void)
 {
 }
 
+#if IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)
+/**
+ * qcom_spl_cdt_load() - Load the CDT from the boot medium.
+ *
+ * This functions read the boot medium for CDT information which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_cdt_load(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	bool is_mmc;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
+			 ret);
+		return ret;
+	}
+
+	is_mmc = desc->uclass_id == UCLASS_MMC;
+	if (is_mmc) {
+		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
+		if (ret)
+			return ret;
+
+		part_init(desc);
+	}
+
+#if defined(CONFIG_QCOM_SPL_CDT_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
+#elif defined(CONFIG_QCOM_SPL_CDT_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("CDT: partition not found (%d)\n", ret);
+		goto restore_hwpart;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE, info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			ret = -ENOMEM;
+			goto restore_hwpart;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
+			pr_err("CDT: failed to read CDT partition\n");
+			ret = -EIO;
+			goto restore_hwpart;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
+	}
+
+	ret = 0;
+
+restore_hwpart:
+	free(blk_buf);
+
+	/* Restore the default hardware partition, if eMMC. */
+	if (is_mmc) {
+		int rc = blk_dselect_hwpart(desc, 0);
+
+		if (rc) {
+			if (!ret)
+				ret = rc;
+			return ret;
+		}
+
+		part_init(desc);
+	}
+
+	return ret;
+}
+#else
+int qcom_spl_cdt_load(void)
+{
+	return -ENOSYS;
+}
+#endif /* IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED) */
+
 /**
  * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
  * @descp: Set to the resolved block device on success.
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..ed3e5910e7a 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_cdt_load(void);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index b9a74863c1c..5466fb3754f 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
+		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
 
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..09943f946b9 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -12,6 +12,7 @@
 #include <dm/uclass.h>
 #include <init.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <malloc.h>
@@ -333,6 +334,12 @@ fail:
 		reset_cpu();
 }
 #endif
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
+ *
+ * Adds Shikra-specific blobs/entries to the QCLIB interface table.
+ */
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
@@ -383,6 +390,10 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
+		return qcom_spl_cdt_load();
+	}
+
 	return 0;
 }
 
-- 
2.34.1

