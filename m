Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACA4C9831E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D25581285;
	Fri, 25 Sep 2026 02:41:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A4t9kqSdMrDz; Fri, 25 Sep 2026 02:41:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AEE881286
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304102;
	b=E55he6+nzNBIEOKsJII5cf5y5kZCrqye3sLv+d1SWYFNidNMwz4kP1znZNOLmhtoqHtf
	 vKdkPUJ7nw0IwGPTt2rpC4admevWFtI7lKUFm1KVjOMBDrlpH06G/xVQvAi6ajOCrmetC
	 hH9RePWmWa+6vlqftxr0VQ8gcqbQc1F5+WU82rcamtix/4N6aKxe+82Kt+ka1EMh0zyLJ
	 DBzKwbTpIGtwUdClQi/H5PptJyOmQIOoGelnzJpupA2m2K1a57rHKRxjQeNHPt1EP8pi+
	 PF1x/5evGsywbS21KHTNyVHkVUunhWr2uZTQnVTpU65o+hLFjqutUX6s3IDeTbnzxaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=;
	b=sQRpn6zK4+2wQbBAYDrZg5Js3OPPNnn4YnomVr02B8lXMml1QIod9dlFHyG3M7ObHxnB
	 4omGnsKsYV3vRX9LoAlniNs+uMMvupl9oRKq/TgrEF+AZXMt0YPOOxkosSWUlt/EfCozi
	 s72yRHo1nJ/xtQ1oBdE7+PzBYspucrcywLEF2mnlBvcBJNHjThgmP/6YAK1wGojEvMf67
	 1ISBcX6CXBBpW88hr59V6Xyc/ME/aGZtDCK0nkiwuslRAmpsDDptCr1yKfC6q2ZHNa4Vf
	 FzvRgdysfimSS/2lPkG6YXxH0wMlBuhaZbTgYKKsKYwx+A2YV4LJ1+tumFrEzJchLqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304102;
	bh=f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S2ygUOdgn29zT+Nf7RLkSvNLI+x6DEsa7rdY6UY8Sjz7xXG7tZnCMYo2U04ZLyDKt
	 AgEwm3Oy9KIjUjoOOLDSMXTAMB9SlhTDNkKmVY+jw5NeEMQXCLNbYthgIn6fMhWFKv
	 XZUVmgLN4sifdyYdjF8K+o27t8ORH5Sm5Z/8P26AMJ850TGKkxQleyWB7CO++riAyl
	 uFPIYCJ8hsZzLi6zBo+vFDFh0n+Xq7y/ftrzgUQxNT2tWi4H33djm3KaxQQb8rhAtP
	 pUDwnpnROzAVmKbzRc5S5AVFoSbRW4pwPgtDmHA0O+En3V2eDRE8vhpvJYh3lHOD+M
	 qN3fv9MSF5UUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AEE881286;
	Fri, 25 Sep 2026 02:41:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C628FA33
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5EF24017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoB5m4egAakm for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F82640079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293092;
 b=Cc63nC/sOYW0pvMDT662idSOqJfw2zc20Dl/uaLIaT2eq/9RvuDmT+Sr17XxDOoQrJY4
 i0mHff4bt9eUdnxdxmCYZ+AsziReK34jVxa5QHn6rFGPCiw5pgkzThDBXvDelY5Rmqhfo
 lvgsI0gAM0+2fj+TUa5PTUAyzadhFtga9fi1viLkuE0JinIzxdKAmihsgwi0Gr1H/hBO8
 +9QWKZ71+KpPJth/WaizDdIbiLaA7cuJKTFfuPHTMKO6jt3tkyn8iTv2tMZ2Fh4oYve2u
 1cc8KCVMEWLlLCnO1Q+2QFKxV1392mBeKvwzBd97DEuTC46yXUtSetm3z0h4U8oXW4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293092;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=;
 b=aHrjXYQRunOW2kVamH6WHoGa0UgxiQRx8rCehDIyF7Ih9BnljH2XFlJKvpwNlMd2jF+m
 trK0o7k41TkfwwUL/IpGaCngTSzVQz4ZK+u6Dg8U/wk3u50X2rFzRJH+i6UL4Chh5ujY9
 TtixqpEWCSMta5tHUfZ0XMFnpKvyX1fh0QdAQVtAQQ/75sC1XH6BLLPjkQ2idXCAn6ie6
 VK1Tff8OE7SQkW+r9ujlKDbGKWIdvdkjK1kpGJOKlqJhS2aOsis4zONuSv5atXWOOUMBj
 rjiIGZSChL0q4MaxsqHsxs8dztecRqJy1QVHHWfVDnvXL0AOXiHrKlUV5FJApuRddRw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nbEnU7ev; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aXlTfohk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nbEnU7ev; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aXlTfohk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F82640079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:11 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMOnAS2969259
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=; b=nbEnU7ev+tMckOEI
 Rd5RN2mIOagYDdbiLlDkMj4OhVcsn7vGl/shgLEAk+RMVgTzPRX094+3Xfp96qOI
 z5b1yHhobeL5eu6SBuHMq15/wXNxwf81dG9guDieyFbffXsI6QWT+JRGrTecNKQR
 /OP0OzOZd5vYK9aboEMjwSI9zt1fyxKW6feS2e9WHzHyPw0BjXrLSkOkUJhHjiEB
 YaABiw9U5k6jVF+ICUHzRrAKVMxMeRzd6IGDKDxjC07F9Mr1IbcJjjBfWea234Yn
 yWKewkkJHtD3BG2SB1LbWN+HjEwQJ0R20hTpdBnS5svz+OjPhT9soD+kDY6qf+pj
 NNtcng==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1wr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:10 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8a35310148aso8533807b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293090; x=1790897890;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=;
 b=aXlTfohkKj6xHh5IPQQnDSKPbC0l84Cs/sTfM92VdANiCaUWRVtSq/SnRwd6EZmkhX
 cy5t2KRYduYZpLp2YKfeAA6XiGBUPNAw4bbl0ZpYPfbT7cNJjE2KgqoH261KYl+h+jfa
 Lwwx+6VA1V7iHACAF7ykGvhiVrVIHd60VwYjGcK0QCJRQtWJqemuSSKhpWtt1xwh385F
 A6cUsna0jD1m6b1HvjqB00JRv1204HFp89RerDDVDtVpClLxHtP0U6UnBuoMUkdnAjOF
 gfO+ojA3YVqGpjkYMrxXWWao8nk2UgBUUMRz0k1ovAa7o463xgLYDDZBHx8IOaB2GEFk
 2+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293090; x=1790897890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f4K6l2PMjN/WEBy1wZuHSl8am0lWK8KN7yTfJYUTKc8=;
 b=DWrbpoe0yXgNlCO51dPGZvdxmquPVrD6YR4WpSQY2KYKiaXNDvmOpmFHbM3FKa1o0h
 XuJjNPM/eE/1V5ebjpLCI/HA5iF9jumYK24qbmL85UPGAEzE1h1UoNP7wqxXSgOo66iM
 0VfHcP0z5LYPyvFec+xE9+dRDY5wTiD2Oo6fL43JOwSHCJbGLCfXx4kZl1xAX+1JNWQ+
 Ducls7/TNDRHjcqCpiBJKR8hfDM5Jwfa0lklHSFBzW9cucMiUjfozxWFyYf1axZAP0ua
 FF+24UePl8OBYZXttp33GPvAdH6JZCKEPpBuYoANPKnmsElsc8S+tX+u3SGKzyfL73QG
 dBfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC1+lbVaCk5fY7BwiQG9t24Ygf4N4rTM7Q4lWud2MlrV5kM+jZ6CQ06XEAImKkWnR43ThKSeU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mDP2iyNq3GgxpNb/eRX06byyNEsv2DjqMCDw3tpw4y0qr6i2Ll
 xGCSAVTtH1ekNUa9Gog8U9eMU5mWEW3JLdBtnzSnj1Tq0Dt84rUGsaE7PkxnFnFR8i2Zmdaua+i
 eTH3m/rkEiwSRWNVqhNfihJJvPYJXf2IB4YwHUy9CZa61fFzUGti9IOuCOhSNLcVE8boxnl4=
X-Gm-Gg: AYBFou0hpURfbxHq8e0e8j4fUrk23cwSnCe6VmGIpgDrl8/ySoqbuTbfv2Q/x+EtVTr
 XjPhOdgFB0SLY3nWWTDK2FNpjLxuUGXS4UeDoB1CuyFEO2/eDnnk93j7GrwTpoiEJDtZ/537w2S
 raLZKXCP9fPXh2/Vh1aif6kt2ssR22/jnJkvNdMqeFSlfC6u+bF0ft4T4EuL9sAqQjFylsJpGJn
 jHu8KmbZHxvCUR7yDJwX/PYfZrHjgIbLxwQI9NWJ+WSeD4RLbM+WNEMmQhdI/E7k+qck94txb5w
 fzC8VCaM+VH5dGS9xLEkjfh1uaQatuOxfCLqhSB3dT2hCw3PvJjdcXZBXkxEzPC0S0KWv1DPEBN
 yZtRi1YMXB9bKA7/JI7YsMqTXfE6iApykIWnB1Xd74Mpjgb9o93JXm/9uEwzrDq5FEVObXDai2S
 Rap48f+Ew=
X-Received: by 2002:a05:690c:83:b0:873:5c7b:c0ff with SMTP id
 00721157ae682-8a64bb281e8mr28464097b3.55.1790293089963; 
 Thu, 24 Sep 2026 16:38:09 -0700 (PDT)
X-Received: by 2002:a05:690c:83:b0:873:5c7b:c0ff with SMTP id
 00721157ae682-8a64bb281e8mr28463997b3.55.1790293089530; 
 Thu, 24 Sep 2026 16:38:09 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:08 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:05 -0400
Subject: [PATCH 4/7] board: qualcomm: tfa-optee: enable the OP-TEE library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-4-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfXxsWwgd+CUHsZ
 RtrKKWp+U6+qispYi6h9jPgBUX4UpFWKHM3Fw8gj77I8qnswqGqXKGtUJWRZ+ng5MwCUCmCpffv
 xhYw1AwxuVBTAgFnVdQDEzqzXT5b0VxeeGZzrgfdg9QxNSM/aB5tNrTjYK+60JnBZ2GgwH4Mv2L
 Sq3jcjgvBz4UxIe6PUxkJeXqvtdwM8ktmpw8k3WQ173K94u6fCCh/yyzzN+CliqXBFydvrm1iAP
 QcJGWvSYr8SZkXo2GW1yKnketYoqaRe2CnoxflPRTihjQ2+c+En38GgiMPo9cqiA7Wc/YmEG7Jh
 LhimgackwvCMRWi63s5YaJEUXqKwXyhxKPdD79Pi6xMPgdqMMlO792VtmQOuZrqIKVF+sMwGQD4
 uonxcisgIthy4N6Gdm1gtdx9a7RAMwIYamifGRLdMxNFuaGLPVNSFdSBlZd2ryXpLOZD+BJ9nO6
 3/wGcOjhPX0V4EogwkQ==
X-Proofpoint-GUID: R_nalGyzEGzJw1OnfezQBVNT2wZ7zN0W
X-Proofpoint-ORIG-GUID: R_nalGyzEGzJw1OnfezQBVNT2wZ7zN0W
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab5b462 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YUhB0A-GhYANCUzyIsMA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX3vDnD8XCXmyb
 qATMoZ4wSojVBO+nqCO0cbKzowwycuj1Uo+oAIh+9yasf6JrQmy2e8aaY3ESSkGWb/CzdIYkBWO
 ngYR75whuett3EkfKkbM4XMFRIPAjig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

tfa-optee.config is merged after qcom_defconfig, which leaves
"# CONFIG_OPTEE_LIB is not set" in .config, so the "default y if OPTEE"
of OPTEE_LIB never applies and optee_copy_fdt_nodes() is the empty
stub. The /firmware/optee node mach-snapdragon adds at runtime then
never reaches the OS device tree, and Linux does not bind OP-TEE: on an
Arduino VENTUNO Q the U-Boot OP-TEE driver probes and the EFI device
tree fixup runs (/chosen/u-boot,version is present), but /firmware only
holds scm.

Enable OPTEE_LIB in the fragment.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 board/qualcomm/tfa-optee.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/qualcomm/tfa-optee.config b/board/qualcomm/tfa-optee.config
index 1e8364c114..43ee5df812 100644
--- a/board/qualcomm/tfa-optee.config
+++ b/board/qualcomm/tfa-optee.config
@@ -2,3 +2,6 @@
 # source TrustZone stack on Qcom platforms
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# qcom_defconfig already sets OPTEE_LIB=n, so its "default y if OPTEE"
+# never applies. The library copies the OP-TEE node into the OS DT.
+CONFIG_OPTEE_LIB=y

-- 
2.47.3

