Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC596C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 09:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 677B981244;
	Fri, 18 Sep 2026 09:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGjs58pDK6vj; Fri, 18 Sep 2026 09:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1C03811CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789725004;
	b=av16xKtCTyB/AmuLmf+cSaGv6esXSzyCCgFnrO3TrRSIDYxpfzIXNurwZ2Pn8IORWV9Y
	 MVDNCmP/MFb7s7Nnoj+h6obgegiVknbaPVUCa6v77ub1NbRwHmUXSmXH3/egJ10spEdL3
	 RNj12wx4qcK6TO6txBU7Ym9elQq+CdY+SwOfNcxwUw8IWwLF+q6We4tCJ/xlgkjLoa/aX
	 lo0oktOGklXMOTe/TnAy2n0sOZQS3hQDaOJQkJCCWT/P4z0a5F1l0pdJVLywjkJwYRG/M
	 nWB4oISEG+ScHqCRCl+ZtN0QUIJWAgaEUE/NCKgOLeDEm3gweYtUGnnWX5p7peS+wQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789725004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+nEyFs1Nuw=;
	b=FZqLVQcKfd5z+nzQshRFq6PXNg2A2cLKYCRQEKpvdxgqeEIvca0YoNI+/2lOlZ5NHRsh
	 ImI73nxpdbztxjgXu60EuK84kHox9Y78qygdrmENvFYgEgwNbyQKuUWOloL/Kuug5O3+4
	 rhFwcPfZhSzL5VUukY9PeBq4p9zPRYHiKJ1MBrmyg7mC9SzRrJFoLC98cGqTZI868dbIu
	 mDrK1ko7+B6dV7lYSWYa1fRsMaqeP+ddRLmT7x7jq7xp1sH6k7h3eMQag7jaiWf1CbO+e
	 HZsb4A7m/P1ekj2rddC7iisAH6h6SUMUfiFZSJdHJ/nhdbR9j9IadXZALQI7sGqBMHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789725004;
	bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+nEyFs1Nuw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SZO8un5CafQYEK+6KhhEPLUaBXvbSINtya2QKiwemadf9bALmTr1ZltYt6WOO1Yjb
	 2nkghEIy5kz8HppEG7V2IBwHG7Zujg4ZTFy31dU96EyB1OYspCX6TCo7RrH1PGsjfM
	 e21xKbdaR+B4NoJRqkGDCr5qp/4Ot41fiuJ36lyLIN9BrEzVFuW55r6rKSHolcYliG
	 fOFuRwvIFoB+qPIl72V00k/okQnpEy29IdEDPXUCcaCEF4Sz050tP15exXfteXwWpS
	 3EbxnxclEpnTchlR+dYe6eJeHIVOnxwpbDJRi31PUuXRql1qmG2cDjv5+uZW08/QTL
	 4AwlYr5SDhyzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1C03811CE;
	Fri, 18 Sep 2026 09:50:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48001422
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45BDC40506
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFwkXBQOEu2f for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 09:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 31206404E6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789725002;
 b=q1LWNzPBdbnBGxS+VzmX6ZOm5Yht/P3Sq6f3k924iopvLZW9hul9lbJQuUBs0gwctIDm
 Fcx6f7fl2UdBRJW1v8N3x7cWvCX4RO/GJ4fOdC9pB1sJK6Nx9O3v3DWY0ay6KorYiZZFe
 YmZLgDoJQUW/Ek8DTkIY46vBMAkFcbce19B/qR422M01fUxhoAkdm/n8DG76n9WhY5B/6
 bqbeD5yBNrtFVEFj7pxT7Tev29/Finqs5FRwSxi0pAbtbwlL+DlvZ0eLYqBEM8wwh9Yyq
 vvIuPaqSzV6qOvj6TInst23gXuSpc+nHvyb+qsysh1fjVUmUhSxotzA5kSxpyV4Wweg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789725002;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+nEyFs1Nuw=;
 b=tb3xn8GQ1JnfBpIucvNevXHXz2mBCwXaUm3+oBFbPF7MaVn2jEDwS6Xg7/MI4FI4GLOt
 4g1zq3TKI4bvTemi8CLejaNjL54J7gb4nSyt8R5YtJrCV3i/95Vw62nLZAdvHi9RQCiu4
 uLapFXF75jjT48yALGcTZRMfjPixpz0BpXmikvxmxNBqTr9q3bAsf712sH+J82mFJObj1
 P5C1GqGgq0IdNb/1WvGcf+OrRB4pW2php7O4bxAq7Kvezqnv5TUzFJbtMIXfhoM4S+pWd
 oYXOmh9ozkSHoVVwbUPfA45fnPAefUMzS77gtFIWiRxeX/iyQg8fpUN6coAgrnxW0hw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Uz6hSv1Y; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FPih8e9H; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Uz6hSv1Y; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FPih8e9H
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31206404E6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dhbl1213782
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+n
 EyFs1Nuw=; b=Uz6hSv1YotOkqwioL6dVUOyaTSrbxcVw1+pYNeqDjeKZAdHKJTi
 inqzWp8NuGq5tkn87dcxJBeV2h+MrnUoRMWud8Bj9rS42Nt8OuNVS6zE+mp/w6bA
 tVPJ5CsHoPBs6PHndeTykQtniT8/uG0QQTXrzeWN6BgUco2GIFzLH4TthlPzCLFD
 q9amE4+5/XMAaf1GcsUi0ezNdDS6eJBpyYkZnkvDSWLa06FFZ1GD3PxV3plgGght
 jBc82//K8IuTsIZactFfd7m0nlxL6GSZT+PHj73Mg1wOgSptr99vO0nKfUu7pj5Y
 8ffakFj06NC6oLpEOVqy6KhIMukBORrWyXQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg42j0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so1071919a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789725000; x=1790329800;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+nEyFs1Nuw=;
 b=FPih8e9H/e5kPu6Wf8ohcSfigrgeFYDDMJ0NE1KXsuRr/9TnfKojtVvgKgH+yxdxXI
 aLyoeDY8FdQ5C+0pcbqpUifMR+8P5XmMvJvAtyZR94MeyqEboWpKnyBbpR92uVFKTi5S
 +8MKDxAy62h4h7eDng2q48Hc3Di9BzK97/ZhoXGOt01UdYEE3IK5XHBV6Qi5sMYuzSID
 pcv/jsPPnj07sYEbSrWhmspURoC4Rlh/qtPKU4zaqzOHLuYFBI1V+4Dlwxj9tjTwrrDz
 ZzBd1SGNCv657g5xUc4ekb31yFZwUfo2uWcdqsfbq//SsHFgWrKeFTFupjUZFfRZ47Zu
 779g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789725000; x=1790329800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o/wjzuhbOHDNiyhHd67KYRXNghjoGOh0D+nEyFs1Nuw=;
 b=ehUWBaPmfOrjL6qlNnTiaLwqKn0W5s1vVJcPT90I7cDZVHdTB3bn+TOrqsJg+krlGV
 tEHg4y1OpP54QK8LysG1HUAmnZ0KjTi2AtBeREec+ZfVuaTgKbW1jWDZeuJIydKHZwU1
 I17zuTYrKtfvrNW3p1GgeL9sTk9OSvuza/Sht8dA+oLObi+EgqSwNqmF630yK/mIpgi/
 V6dqbLIc+wvCQicNwV+oz3UhTfTpIzntyioGd0uMIVgM1ka/rc/J3hPDzW+w7bOpArt6
 jXaH5jZxKHs6k/yPMWsNHsevkHPII1VhT9iPPQnY8qhNT+U3k58VrwEJ60KZsWvgu0uS
 j/YA==
X-Forwarded-Encrypted: i=1;
 AKwUvByL6B83zu/iRyUrCnUkRS05B0vuCvXiBOfShOT+Zcyl7AVDw4rbwpNK/hAz6Xi555S4TC/PUrs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l998dQ0dlFX31v5e5UB2DwUcuAJ0kQ5e9mLuAliiaS2W3/iVLA
 tqcUGTqrM0NzhdKGTO8cAjAQ6g/T/SkUCIxpHEYH6Spza0QhqWnQFZ0xvx6a2Dj6oti/2z6g0Zr
 98RLbxqI0592OpSqOQRTfAlzYyEEipqvHUyDpF7yhPQ+oONEoac1bUbweYiy5QMSY0ius3V4=
X-Gm-Gg: AYBFou3dxe69mEhwYIksLNsxxfFgXSZApbm6iFvTFBKH6Xl0YR1GiV7yvXNRaS9NhNz
 xY/CA8S1uNd1dhLJ+V6HXkAI7M7Hq2Mki2OmRYM6+OQYDC1MRj8hUrcPFC1wNb/nc+RYcY6KbU1
 7aArZEzc41+XiEMgxuqv0wvcnHdKj2O8C1aVncuwP/X6tXEk0ptRs4Clmfmxxe9btupRTPJokBk
 Y71dCQerwi94gtyEVv4JNBiwVU513qEIxsYlCgUhN+YMXMXU6Ttek3qY1IgCIoQpIIOfK7f8+SY
 xWRjEHKOZWqvZa1JIciXX4M4e2P5N3GvHkPgnRJTQwRI+PvxF2CHE95dRmjs3GToZuFReFCmYm5
 zFx30jQkgyI6iBOecl3/2+CrwF9NvnlxPzRUbv7088iGmPajaqcJcHPu2G8JZP+OU2It+E06kyv
 PiJr8Gf1RaPqv58RybXP4=
X-Received: by 2002:a17:90b:2f8f:b0:39e:d2a:e272 with SMTP id
 98e67ed59e1d1-39e54b63752mr5104287a91.5.1789725000333; 
 Fri, 18 Sep 2026 02:50:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8f:b0:39e:d2a:e272 with SMTP id
 98e67ed59e1d1-39e54b63752mr5104241a91.5.1789724999888; 
 Fri, 18 Sep 2026 02:49:59 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c28723bafsm4087405eec.15.2026.09.18.02.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 02:49:59 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 quentin.schulz@cherry.de, jbx6244@gmail.com, anshuld@ti.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] misc: qcom_geni: gate late firmware loading behind Kconfig
 option
Date: Fri, 18 Sep 2026 15:19:50 +0530
Message-Id: <20260918094950.1186434-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VzSVDWnK4FvRdDJJgKorFnALbG1tLBHs
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aad0949 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jnpNO12NntmmbGWXndkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VzSVDWnK4FvRdDJJgKorFnALbG1tLBHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzNiBTYWx0ZWRfX7pVsgE20LX0j
 AVOyqCLpvNgEr8U3N5hySISKn6k1cXvvhk0LeEWSa9Culh/v1bQwT+yI+ZWVDIz6GQNMNPWoFbW
 bxOmwPuod5IEPLyrci0ZAxIOK3Tvj9RT39mnYGSEB4mz2/Tpr+f84z8zsP+h7ghglm/sqJVCztd
 OUgMPussemoC4pjy/KRBAGrJEMrLvPYVdjrj6ruaS8TX0SsrW5iFkh6Z9uANJGwTWIH384Ryo9F
 Y7NITRcRF77MrgN8Kf4t+12wJImZd+XnESwUVEVI4KELsdnouqSLtO06bROBDbIiQFtU3Z5xqKO
 qH5FeDzop6VivYHeGAyQsPT8qCIVfZ/PiJO0xH2sJb7fK/W6ASEl0wApT7UFtDk8hp4+WfUxS6p
 337G1MlxCtM9dgXMsSqAButVgYfn0yStcD4HGvpCONmjqTYUwJUTWHOvSatedG7Xy8KzGk14qrm
 9aelGkIDCbD18pElk3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzNiBTYWx0ZWRfXy3l6Oe8CWCS9
 KDjO+3Chqj0yxyBzZmYFuPoq9PIUwVaQxonUaDC70zJ4Y+BsZuS69hMdAWxYSNXY5FXmY5g+m5D
 iDkNlAmwOFZwe/MTjEHdgb1foJUtXI4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180136
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

GENI QUP firmware loading is normally expected to be completed by a
previous boot stage and is not required in production U-Boot builds.
Add CONFIG_QCOM_GENI_FW_LOAD to make the late firmware loading path
optional and disable it by default.

The option can be enabled for engineering and bring-up builds where
loading GENI firmware from U-Boot is required.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig   | 1 +
 drivers/misc/Kconfig     | 9 +++++++++
 drivers/misc/qcom_geni.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..9498583b97c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -99,6 +99,7 @@ CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
+# CONFIG_QCOM_GENI_FW_LOAD is not set
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 44415f24ae1..8320fbe28e0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,15 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_FW_LOAD
+	bool "Load Qualcomm GENI peripheral firmware at late init"
+	depends on QCOM_GENI
+	default y
+	help
+	  Load firmware for GENI peripherals from the firmware partition
+	  at late init. Disable if no GENI peripheral needs firmware
+	  loading.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..b5c2a511ae7 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -563,7 +563,9 @@ static int qcom_geni_fw_initialise(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_QCOM_GENI_FW_LOAD)
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
+#endif
 
 static const struct udevice_id geni_ids[] = {
 	{ .compatible = "qcom,geni-se-qup" },
-- 
2.34.1

