Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70ECC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A9146083F;
	Thu, 17 Sep 2026 07:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zy8WUNFy3jns; Thu, 17 Sep 2026 07:46:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD2EB6083B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631171;
	b=dFE64TAcJtz2iVYFXMDD6OU6d/YDzjVHnOo+fS0hFTz/uDUfFDs678CDGua0ufPDJ4Cg
	 yfd3QfEaUjf2c4LKJlqKVU72TJzPHuQl761KAnp7ovm0YPnff3QbG5eSkXS+00fF9WFjO
	 uH90cOGmnZuBr7r1L4je1BNfiwk7pOMyd+VRnSmpGXmAIEvUm5lQehK6YelnyPKR4RKWR
	 8XBpsprXzP9Uy23y59vFBP09XvQ8I0mXTxquthsN0q7EZ6v2pSqsQ1IIiMH35lyP25xJ0
	 AtWG2fM5UtSOOaRilWqi7iq27OiOcx4nWLvovfiyqJzeWCJlNqauL+zeNUb1vbfw9fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	b=FF+ZIy/ovhifoSE7D7jRv9goqfjtniFk4JFaKYK2kymeFAxthKngvDhD4jdT+MnkaBvh
	 A9MYeFmSSzBBII/6+RkFqdeZ1ICSWWRRas58nlMC+oqg1/2IavcPwN8kSRZ9lVft96Ivk
	 WEfgjK+5Fnmnjf7cdxLldLG9uoPWcyrXSNqMBV2rQShhFVau6E/+yyUzhSW7Tn2KcWVvj
	 hQ1C+rbDW6LQGt0FUdwX33Naj6mJYs7Xp5jTMXglzKS6v2VYipKxy3y8l4ZZxvO48fns1
	 mUN6Ae3K817L/FBrVTFnFSdXg3HsI56ePwusEAuURQ2sUTcopchls94y31Z1DyoAw2g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631171;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WfV+to2pJUvyxG5qnUZ2YEequPARzhLDpsnsA7aqX1vgMO6tsIj2whvf8gRJEIYKb
	 kf6xU3sRXc4WAkalDbVhh+gSw/FCcC8dMQLMZQrZcjEne3UWCIo20QfSkowiem/RNf
	 UsZiYqQYft3slTuAxnOPAO6kM/DgKku53l2Jr1CDXd6toxMCI0PHrEpslePc8iNOiH
	 S8DsuVsKEDL6wcanhvWILvtva4lgU5nGILAK1Yui3gDPtFgTTUSH+pQhot93jXb9hK
	 zvb+pX19768PsQ4cdz4QyNYMCQAHeibnrsA2qYzymmDJiUJI5AL19erhmXGgKawrTS
	 QSyQQG4uYqbZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD2EB6083B;
	Thu, 17 Sep 2026 07:46:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61D0124D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53A87407A0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KV7uRYpsAKGV for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B90A24079D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631169;
 b=VJzpNCliKF9Z5riFHTcA5cHFiarar3hj09iDrZbZM83Qsautm5uNgQyUkZ6J1EkmSQiB
 qbmlr1ZunOeF/bPspHeha105phPz1/j8a6g2vZfphSXCYLkQylq87PLTLfw2LbqT5ykk2
 NfuhUaPNqXN4+zNMaJUiwY8GzjMWSKI9lsAlTiSiNcBQ2dme+d0xKyxWjWsUxvE60rbhH
 AFFuE6drPZ2erdeNzZyS/Qu2yGtp2wPuASikaeTu8VuUSZJ7HSYIQnclEXQMoaq4eGFiu
 B4KbvS8nQ7M2ab4eHk6SLLS70jrbbzEkr0y7XBv7xA8/wixKX1UZpx6U2/Pp302y4XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631169;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=H3FYqpsyGvhin5/6/3MG5Kfhxq5+X+EE2uo2/Oo6uvqJV9yLEUbaFRBUC47TWAfD2xRa
 3HV0EJWs4GsDA7yXx69eIHOEQGC8QzZOzKkxDeirTBTJgAlgqQnTadebqNyG3s+6AZ8UE
 G0COy3mX48J5eEOMZg6j/sGR/nKVhLQLqEuVOrD52YrW+AHui9nWA/dThAGrJtdlUflPv
 l4MBqv6HIVbtePPRVDb5NbuHkfwVy3bHCP/Zd4iC/zA2l0QjbS8/3qFs3rYTwqIpT36H7
 n0QRybd3jubHxGuWYbsglU1KVtgpi+1mi5J3KAYozgSzBwhhG7mgwi2iwHRtkcxX4Jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HvOkBQQm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdhqmKZl; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HvOkBQQm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdhqmKZl
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B90A24079D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60IwU1924365
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=; b=HvOkBQQmkWNgt8Sd
 LwHyFjwsTdzdmWRMrDeI8AGG6cJn8S7iL100kMLGAVQtlBojJPrry7F+u5GwnyDk
 IbE5+3mYQlR3DaTIlA7cIdDzfBeBJWbgDardcEc/dNTdfNeO017ouoSXJnDC1fjd
 LnGm0bXo+xbmJBllbRPe6yHmigRyukaaN9yMC1vC8rdlP+b9II46Co9uwfrJ0S7X
 Kezvcff5xAz+mx/O+zeeyXVU6u9HUgHWj11zrFuXqzPtmA9jV8hfGlRjOEMNoMXc
 /JDDPX54sf5U0YkbB6UzyO0dUeJt+zOUqf3r85EGXks3JeZMLOU5EXApZ3dx1BWx
 MVm6CQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8u928-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso9159305ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631168; x=1790235968;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=kdhqmKZl+jp4H8jWxRsCTM8bNhks5LKPPTCfxCV+jD/VG4UyR/o47plV/DZbm2ZbVg
 pQ+EURqxEM0xTrgZRtZGoTVItIwsX/RBAU6Nb8VkyxoVC6ly4nbgjG4hfVA/x6fN8BVC
 xtWOOTE6FNzVrLme5kZ4CW9aq3Jb8YPwFGoePUi99GmIhvJx+RG1lqa5xFsWc9KLpkLP
 K29ngVHrmFooU5mGaYBw7tevp+3iJNi4is7OKJk+fgOpJn3coPiZV5EUFeC0OnjofeTg
 D58rtfk6zFpE5IzfYEKuDXDNtut8hVDxK6BIhU+G5tbNX/UkfObZwSLiVJX7wnxQGPZh
 dIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631168; x=1790235968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=Vkzft/X4Ttl2Fj17SmT7at1PkKuLhAuLpICQ7fEMQuJT0/1cKTalxMeM/+lUWFgvbe
 lSTHgxi5xqlfFwpnKlO4wsqzjA0pdejMIxn9GyxAh8K6lm4EBxslOJnoifl/n6u7O3Dv
 QZ1iVzeYAqDWMjyhFHcnczSOSuluHqrOEMql16qhAKnUPvibp0JJkGa6wen0Q7v2PGkq
 jcutr2zLheJLYnB+ZJ0w/LdSh7R6H5RXbTNBxLsFELWmgZEOXPKzDH1EX92KcGgkA2mG
 bDXojXBjLW2IYlS4245nAADVEcDcjqdVrgqu9Nhp/+uGn2bRvHyEFiw0Tv0cBe/urhqU
 PNew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT8CQIglNarUTYqc3/AbrtLYinaW8n5wPCQ4iUIiYsWvjNaq5QEfgnnzjPl9kYX71+rky1zG8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ncpJmLQg5iIPlIzq4SAm6N5tVdPydV/jjOPREKhkW1NFHPYQ/4
 ADZeavTpj5qQoujnDEjdsFL3gJQ6AGaJ4XEeRtoZoDa+OHBKbGkNTMC5lF1KsUtuDgrGefTm6/e
 ybniQMGX7cayCfxXOizyk4QzSGLLWtjRol8Lhpn4WLXMYy2B63b8gScG6f1IiY1EE0YYLYTw=
X-Gm-Gg: AYBFou1KxrjNAu1rvmE46/H+/GcX6CJQ6kGgFktEZ7BI3OCk1mUytZwCZ3p4ogbbgG+
 F8TTQ34WxbHdz7rGy9ODugoEpxTA0+PCbfigUZvwcUIuog9L1JSeJkJrAO2gClI3gZjPenLVavb
 tS0oPMFFUaI4h6+AZOKNv6ju1AdjvjeZopJHBq/Mj6ZiNmhgBMK7vreK4veghY8izU/esCQ8y4c
 mkEi03sHahoXukt3qwtnCW8rJVDrPmUV+4nWpELs1fhLKeJ6VQugFyxr9ZmQGWFM1vJO9XywJRq
 79toOYKV7RRrYAf5eNkkzFzO72++gR0FaAcvU3S5J5wO6OBd3h87D5agwQAaqpRfPuYwviY4GKK
 ZIbgY8wy2O43o2KKvTi0lu56b8S3XR1eb73djA5ncMnB1lOPmT3kuAapFYaq56KtoiX884BiYyB
 wgt+TohzKYmi/6HjKBsEQAmMeRyNXrDQ==
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39e1e4d39damr20674938a91.17.1789631168056; 
 Thu, 17 Sep 2026 00:46:08 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39e1e4d39damr20674815a91.17.1789631167560; 
 Thu, 17 Sep 2026 00:46:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:07 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:31 +0530
Subject: [PATCH v10 02/15] mach-snapdragon: Kconfig: Auto select options
 based on configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-2-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 3IM1d9LGElm1Mj2RnPknOjmi5rZMvtQC
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aab9ac0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=BYZ-A9fJ0MEHusibbq4A:9 a=RW3EtsfI09ntgIjO:21
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX2ee3cXT5OM6D
 K3so0kHOx2jZfaIxny1+gUeuFwZvw8vPB1iELEJEsysvpRC+X0+9vC0MhGQ43FyKWYqMSWjJlkH
 5lJPJ5/A9vm3a21/2bJbwoGg9NcC8Zs=
X-Proofpoint-ORIG-GUID: 3IM1d9LGElm1Mj2RnPknOjmi5rZMvtQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX6nkOml4LJZri
 BHcqDsMprMCyKfz4WFNfVoHkaTYRn5bJdb7eQHvJys88PmnGG3XyyTL0GvIQIVdMt6vNW71HBcq
 tE+WhwqqdWKBoZsMhYFwhYUGP+2hu4dj5w28K2xOLUj9amg8R1LIKMrabvxBLms4/PH+5Xj5SJs
 YEIEQ8Dl2xDWZYtkPZx/UrPXtM92V9iW0oT9dIuws/OKBWWu2qgmsjBx017r7lT9g99+cQVoEA7
 oSd+WDrvae45QjXbya6o9ifgy1Nk+qMJUomMJtnNJ4qJj3aoqszxfWxFWH7c6NGLu2PKNHz4IOA
 /suqwB9+LCVOXov0L/gTXe5Oe/FSGWKNSnk4ESLLiYUNZnl0gsffGvG4bbU3K0kP4GvvyabjopN
 cDZqFbxCsIIdpj54lVrWTc8okPs9Q9gF0evr4mK/4T1ybkQDBI8f6UClNoWEPGVspbq4Ylw5Cin
 DdQJ7DykW0h1MhLv/1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to
support SPL") auto selects options that may not be applicable to all
platforms. This results in warning messages during make xxx_defconfig
and/or waiting for user input for on/off or values for certain configs.
So auto select options based on the enabled configs in xxx_defconfig.

Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to support SPL")

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f307340e3aa..51d60ef65fe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
 	select SYSRESET
 	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
@@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
 	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_GPIO if SPL
-	select SPL_DM_PMIC if SPL
-	select SPL_DM_USB_GADGET if SPL
+	select SPL_DM_PMIC if SPL && DM_PMIC
+	select SPL_DM_USB_GADGET if SPL && USB
 	select SPL_ENV_SUPPORT if SPL
 	select SPL_EVENT if SPL
 	select SPL_GPIO if SPL
-	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
 	select SPL_LIBCOMMON_SUPPORT if SPL
 	select SPL_LIBDISK_SUPPORT if SPL
 	select SPL_LIBGENERIC_SUPPORT if SPL
@@ -1181,7 +1181,7 @@ config ARCH_SNAPDRAGON
 	select SPL_SPMI_MSM if SPL
 	select SPL_SPRINTF if SPL
 	select SPL_STRTO if SPL
-	select SPL_USB_GADGET if SPL
+	select SPL_USB_GADGET if SPL && USB
 	imply SPL_MMC if SPL
 	imply OF_UPSTREAM
 	imply CMD_DM

-- 
2.34.1

