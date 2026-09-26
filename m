Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F52EC98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 07:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C34BB60D8B;
	Sat, 26 Sep 2026 07:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHbHoSGW217N; Sat, 26 Sep 2026 07:27:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE03E60B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790407676;
	b=H4WrZZqKllCZc32LoH6jKAf5wsmxXN50F79fMU6jxgV7X/GuZ4CFIrT1RH/W9bYdybhi
	 h6t5JpRoc/86FkbMvS4kPhzwSLTlCAwGezBm0e9ZA3fgKddrsuF0NKMnQ0Y0b7VGvnLFU
	 l4BmmAQbo9KX5MkdOFjW1Z84KX1y2QgBKZuxzBQaOYCLD/GNsZgq/+5+np7guwtYiXFn4
	 JUUYHyJmndHR8g3BDNS9e/0mqkeFOPeDpBYhWe2ZSsyUdo5jfUJEzlYhJ26I3wBTjnjiO
	 oXTvicpIcaIGhKn99JdHZQQFQMEC1hPD7+74f3SjEHGtPEJe756ytSHBPL1bi5/f9VQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790407676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GHzG83FD5ax01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=;
	b=cEV1HHrRl3hi+neUb/lSRYhlcoVgrrMYW/Tg/vvXeVf7KPIltptjaB3leCm4ZgNNc7Qu
	 dWhOZ4PZwrOAlytO8G42BglWwIk5zPZLkj3OmrLrhobMCRodB01lVdh+hMh8niaPrXyOA
	 aXAhcBnE/CElSW5OX1Pbt3qkkglpSHtul7KrRByIJXRnwmkS9pX0IcWGa0vxOhlXl1uwN
	 SG7lMjdVs0d4QZPcR6Ogr9EH6f9pFcotAApz2xv4vKkjvrOIo7nyEzMunGJOQswE0f77G
	 i8NVXiP+/WoHx83KMiwWipirNFpxOkqjzzX3d6NaJUMTwAhRh9ezxtTI4CjiN0cS2xw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790407675;
	bh=GHzG83FD5ax01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBnSAQtWRgyflSq5dVXBCf8pS227ip1NBfH7ViVHbLKfPWMExOCbg7PwkbybO7lOa
	 gGx81VqJwZScRo0NT02cvbgjeiYuKpHrcNsVXsWg2w5LD9vkwQqM8AhvBhMeS6tC3G
	 uemrIggMei6YyPaf6+pF0X7PzrTPnPNV3Wd2en3Gs1n1+yD/dFQ7cBaMyZPTe2xrCv
	 qa1KrJtPuPZzCzZXBSr3T26oy9fnoF0mUOFXFukhuSpiZyNS67COGYdS7hOctzWM4G
	 hkCCtQPb5DZb/VrnPmNfZbkJZBNCZlNvkw4cDkGtx2wc37qE3WfgiAO3BheXIBAw5r
	 OT6Yp8mXOiOmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE03E60B66;
	Sat, 26 Sep 2026 07:27:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 004D522B
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E65844009C
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyqUQ_bUzjfW for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 07:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3516840062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790407673;
 b=MmU4KNJ9cXSNuL3VHSpAoOCXHcKTkN9HwWkV11aPhpOWFbhb+evfOXLu0jERy0MdiT2d
 zRHo8VWuV1rB9jamBKCxhpoBjYMAnNZlBI8ZdOPLf5vRhDK1roOByaIxf+VWCQ1OA0PZJ
 jtRHr9KqLrFHH/D1zQhwhAHSyUcDLIH8CC3XAhOkVLqX9vRiUOwGUnyFgQg6XxjR2GRLN
 tgINEqcrjqSbVwWLpO+f4ocfUZXTnWvHTNhxDVJy59OrMCNZKYf5t/oJd4boL54zfJSJH
 80+1tlx72QbMMSKmtC3mryosrvZCBBorOzxZ1kBurMEyvJdTh+iBR8Fgo2+liljeLvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790407673;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GHzG83FD5ax01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=;
 b=OXNueaBU/h8UAeeFy6j+PmyO74KEJ2h+oj/1OkUsNh/DooAmocieiEKvaIh4LBoLdWj+
 q8Jc8zQQU2+x5PCKGKZzCNf0gMgtVefU/4aML+IEbXpiEF50VWr+y2opLi3Ozkz1s+MNu
 wsR4SX4pAgvmylqRMAJkCUJFkJMGsZdnyzzqtS11xljIwOei42EcmUgzOUimOoHNJ0iaX
 C4PcWU3hMTL4MQ4P8lBLRD5o1XGYwGs9F/95EITraY4CIsL0aWnJA5HpbbEQHy+eiWVmF
 TyDZeSXSLrOV7VvSiQRXS2OHZf6ZKMMHarWJXO4auqiFwr4O5i7bD63ntv7emD8cCDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ntZsw63J; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RbYwZjjM; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntZsw63J; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RbYwZjjM
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3516840062
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6PQDZ1952298
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GHzG83FD5ax
 01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=; b=ntZsw63JziYJXAg3i1wTH+TIgxX
 WMwdX3nEsLXNX1qckMPscNCbwUUeJ9Ovud3YmZRyp1duK6E1vDyvx46sON4dQT4/
 4281Fkz9NkAq3KtLGvK+azgGDFbDIREX1WCHljx021OroLLgA5gK5Are825tzy9g
 1uvKMqOoOVYRyM8WeMsf0i9EJ+XII9LhwVbqfEq1UwCwmSme+hjhDMoywpq7v7OO
 jrSOLixMMOTxR3YEV1j1KO1CAGfP+DYxrdEOj8cl+ZCx3sZcnmvee+Yf4GdSGbX+
 8ux1pL3Gc/n46DXTE53BuBNqH6VVMzte+RffyY/O2NHGs0pYhmYfLTXdmNg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jr95q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2635547eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790407671; x=1791012471;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GHzG83FD5ax01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=;
 b=RbYwZjjM5BMffwurdreBhNrLIyRIsd85SQ8ScsB1Eq7hC57jvSH6FFr7tzpU0vSryU
 fpQu1dcuTt8hlnZfcwhENLuW0ls59P3AYNLlAn6UvkIEkeR5Xh67AqpfVz67YLVScyrM
 LMw/E0HFjwTShgHzS+a5qJ8M0hxfbpJyNLb1Rbvh49ywDDhNh3VMywjpzUMAKAuClonu
 orVw9G1ZlB2zf2kNqO2TIbtCTErYxNfOP5VzyWjrWzc3rstnxgNyZsDWxrnZPO5qqUDa
 G7RALYqL3UfrRwvz617BxCe2rjQYQ7gT5JqZo4DtuzYXjiANED+Z+GztaT0npkqha/eS
 NPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790407671; x=1791012471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GHzG83FD5ax01AaucDy8Hs5Mk4WZYyauyNOIy08xK3g=;
 b=ejemKOnNJzGE10A2+q3TCHoWl84NsbUva+jwXEjh78eH7K/dqKMj5bFRApOiSYCmEn
 dCB8h5r1uq+qTlHUnge6rtVLlgcX0gqI3VqdXiy1k0vthZkkTIvFDDaLGTjHeY2GeyvN
 7wjpyEoxxSToq6Qdptu2LPtQ/MJSlcqEvdncdeLTiTMnsmiest7MPym8mg22Kc8db/4j
 t27TZUpvWlAiR3fIqJwmLi41xTNswkVTtUUm0GLFCZpVhdC8R0nRagVWGJDWS0WknQpk
 T55Hy9eerRYUEu36dh2ZG4Q1sB1LHrV/bNF1kZd0FDUCwv64/RpQObUiA5NGVgTOndMY
 ohpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXZnTEhPQZDkIqmd3VNHKkwiw1EU8yo96G8RE4vB44IejMO7Op8tggsEJQZqPfu+KJjOdRpH0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nrCfdk9RA4EWn7gmDHmL7wkQmEIYx7KHoqWk6CNqaQ1sKSMN7w
 TPELnO36t+tF6NTe+WEBAw0NYGpbCYWD+pVwvSmcfQ1AP7rKfG3l0KBi3GwP1U23MP8MWs6PI/i
 3ZZUX4O2sj0x2mEPniXPiQoCeNgrM6IXQngYQ8KPx4i4s1rRhrX+/thwJcC+pP/ZG5qpMkAw=
X-Gm-Gg: AYBFou2C2DxxKhMBe98aSmJ6RK28DP90LAJbw3Ho4dZQoIirjcMp/qYMsAktc38X8Av
 uruu7X0dWIlO1Y/0laVCXeYHDR8S0BhOr6O1nKuEdU3Y3LTG8gmrApjyIj57ffXhzYiPufh6XK7
 WdJwk1kEdnX+VXn4cQ379zcFZHjLtob7VQDhr20oH/z8zoYBTGttKHWwEMNNDVHYztqI3ESgj3t
 OfZ2hKL9ktPTLR4InzBP5OvWSjVcTIiMbGOyyghdCqgbEfRMvsDnU2Eu6QWuTS1xpJ7gZ2w3y5J
 o3oUiJ1a0guPdi31TPw7jr5pFL0RCzlutzqJrkMM0+hd8a7Yd7Or9kLpbM2GWMp6iDO9JEl2FkO
 5zQ5zzvM2Glf/AV3L/54s6WsjnuMAkLQ0qIuv4HPLf3aqCrzTLeUMXUnLOv2FX73XVaHf9wf7bh
 EPPR1hnOSONY9elpc=
X-Received: by 2002:a05:7300:238b:b0:33c:e8f:5700 with SMTP id
 5a478bee46e88-34272c5729fmr3125675eec.33.1790407671168; 
 Sat, 26 Sep 2026 00:27:51 -0700 (PDT)
X-Received: by 2002:a05:7300:238b:b0:33c:e8f:5700 with SMTP id
 5a478bee46e88-34272c5729fmr3125636eec.33.1790407670611; 
 Sat, 26 Sep 2026 00:27:50 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757747sm13370186eec.13.2026.09.26.00.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:27:50 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 sumit.dhami@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/2] sysreset: qcom-pshold: configure PON reset type before
 deasserting PS_HOLD
Date: Sat, 26 Sep 2026 12:57:35 +0530
Message-ID: <20260926072736.3351143-2-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926072736.3351143-1-sumit.dhami@oss.qualcomm.com>
References: <20260926072736.3351143-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfX2fY1zas0V1E+
 +SK6b1lyh/O1FDr5OGnIPxVqcDTAs2kTCR0oY3Y+RT/bhitzsl2bC9gyXhIuutCl8myGhWHQ3M7
 pksCTXrnvNX7EbINu7AVlO6gySlZ+NI=
X-Proofpoint-GUID: dBz3GTDrJUFf3YK29NsouqUAksJ4bw9b
X-Proofpoint-ORIG-GUID: dBz3GTDrJUFf3YK29NsouqUAksJ4bw9b
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab773f7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bT2intKGcJ7E_v4CT48A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfXyJ9MPns2FeES
 1xk1fac25hyZhwiIm3wMCQA8l5dxIbQWOAjk4H2ckcOggzM6ls5zTu6WudVMhH0taGHv8ZfRT7L
 f7befGxhQEvGlZhy95l0yQ+9F4YzBWH4YUq2v9/4C6MYHOFfb6S6uGzN7HvhbbpMPQ40nyw39/K
 ppKRbBa810WwtHx1PwThcQmkNetIMzgtjA8u6IKDRlqPBhOprK5Bl7bYxfYkXQ+rlsK7LCA/nMI
 H7oL5wztFiStRrvA1CtAJO6JRHlvtknqDqMw1PeuiayRxpRauVdjyZ17Xri09gUoviF++Akc+i1
 kbXIHOcYha58i7ORhpfQiTKfVuXSP9z3Xc1RIRPU+EiF9mPrSRjLbFa4YXSHIczyLIZFUoRiHlf
 Ix6H//HZv7xMsdpNKxED0TR4GXFUxrkiBNolo6NA4rpgrEFCwyMHqDTGojyJNfM9K7rsfhLKQr9
 8oNQ9fDNWlVSFHuQsxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260029
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

Reset types defines behavior of the PMIC during a reset or shutdown
event (e.g. hard reset event). The type of reset event is determined by
configuration register PON_PBS_PS_HOLD_SW_CTL in the PON module.
PON_PBS_PS_HOLD_RESET_CTL2 register contains the field S2_RESET_EN that
enables reset. To configure PON_PBS_PS_HOLD_SW_CTL, the register
PON_PBS_PS_HOLD_RESET_CTL2.S2_RESET_EN needs to be disabled before
re-enabling it again.

Configure PON_PBS_PS_HOLD_SW_CTL and PON_PBS_PS_HOLD_RESET_CTL2
registers before dropping PS_HOLD.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/sysreset/sysreset_qcom-pshold.c | 122 +++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
index 45290478536..c7251551c04 100644
--- a/drivers/sysreset/sysreset_qcom-pshold.c
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -13,15 +13,92 @@
 #include <sysreset.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
+#include <power/pmic.h>
+
+#define PON_PBS_RESET_TYPE_SHUTDOWN		0x04
+#define PON_PBS_RESET_TYPE_HARD			0x07
+
+#define PON_PBS_RESET_CTL2_S2_RESET_EN_BMSK		0x80
+
+struct qcom_pshold_pon_data {
+	const char *pon_compatible;
+	u32 pbs_base;
+	u8 sw_ctl_offset;
+	u8 reset_ctl2_offset;
+};
+
+static const struct qcom_pshold_pon_data qcom_pshold_pon_data_table[] = {
+	{
+		.pon_compatible = "qcom,pmk8350-pon",
+		.pbs_base = 0x800,
+		.sw_ctl_offset = 0x52,
+		.reset_ctl2_offset = 0x53,
+	},
+};
 
 struct qcom_pshold_priv {
 	phys_addr_t base;
+	bool have_pon;
+	struct udevice *pmic;
+	const struct qcom_pshold_pon_data *pon_data;
 };
 
+static int qcom_pshold_pon_cfg(struct qcom_pshold_priv *priv, u8 reset_type)
+{
+	u32 sw_ctl = priv->pon_data->pbs_base + priv->pon_data->sw_ctl_offset;
+	u32 reset_ctl2 = priv->pon_data->pbs_base +
+			  priv->pon_data->reset_ctl2_offset;
+	int ret;
+
+	ret = pmic_reg_write(priv->pmic, reset_ctl2, 0x0);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	ret = pmic_reg_write(priv->pmic, sw_ctl, reset_type);
+	if (ret)
+		return ret;
+
+	udelay(300);
+
+	ret = pmic_reg_write(priv->pmic, reset_ctl2,
+			     PON_PBS_RESET_CTL2_S2_RESET_EN_BMSK);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	return 0;
+}
+
 static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
 
+	if (priv->have_pon) {
+		u8 reset_type;
+		int ret;
+
+		switch (type) {
+		case SYSRESET_COLD:
+		case SYSRESET_POWER:
+			reset_type = PON_PBS_RESET_TYPE_HARD;
+			break;
+		case SYSRESET_POWER_OFF:
+			reset_type = PON_PBS_RESET_TYPE_SHUTDOWN;
+			break;
+		default:
+			return -EPROTONOSUPPORT;
+		}
+
+		ret = qcom_pshold_pon_cfg(priv, reset_type);
+		if (ret)
+			debug("%s: failed to configure PON reset type: %d\n",
+			      dev->name, ret);
+	}
+
 	writel(0, priv->base);
 	mdelay(10000);
 
@@ -32,12 +109,55 @@ static struct sysreset_ops qcom_pshold_ops = {
 	.request = qcom_pshold_request,
 };
 
+static ofnode qcom_pshold_find_pon(struct qcom_pshold_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_pshold_pon_data_table); i++) {
+		ofnode node;
+
+		node = ofnode_by_compatible(ofnode_null(),
+					    qcom_pshold_pon_data_table[i].pon_compatible);
+		if (ofnode_valid(node)) {
+			priv->pon_data = &qcom_pshold_pon_data_table[i];
+			return node;
+		}
+	}
+
+	return ofnode_null();
+}
+
 static int qcom_pshold_probe(struct udevice *dev)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
+	ofnode pon_node, pmic_node;
+	int ret;
+
+	priv->have_pon = false;
 
 	priv->base = dev_read_addr(dev);
-	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	pon_node = qcom_pshold_find_pon(priv);
+	if (!ofnode_valid(pon_node))
+		return 0;
+
+	pmic_node = ofnode_get_parent(pon_node);
+	if (!ofnode_valid(pmic_node)) {
+		debug("%s: failed to get PON's parent PMIC node\n", dev->name);
+		return 0;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PMIC, pmic_node, &priv->pmic);
+	if (ret) {
+		debug("%s: failed to get PMIC device: %d\n", dev->name, ret);
+		return 0;
+	}
+
+	priv->have_pon = true;
+
+	return 0;
 }
 
 static const struct udevice_id qcom_pshold_ids[] = {
-- 
2.55.0

