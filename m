Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2DACA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6C9780DE7;
	Sun, 11 Oct 2026 14:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJJZeaAdDzZM; Sun, 11 Oct 2026 14:39:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 741A180E15
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729576;
	b=R0tpyZHtlMA0J5NUeRWLW7QDrRr/v9Sivxi6M+bw6ZJo084qROUS1A4ilBmA+djBVu3G
	 YzU7+bGUBYFeJai6Z20b6fOkr1aBbNxv39uCEdtLht2XUH7DpQ3cSmovQ+t2RByL/XaRk
	 8K78LT3Kj8Lkwt20qHOaeIkes7XowjA6hMNZd4Ehq47FTGfKRFTSBbsTFHsycldX3cVw3
	 uTdB/eyt/zhHM3NRHbMV78T91d6VhX3eip9LKPWVkssSkxmynCqQSbYO3H9ZY16HO7bnW
	 4XY9CvmKueXXkgtwdwiT6fHn5TFqvb6CEYVbjsv4rC7N4/7x1VDQDK3EKuAw0uPhu4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=;
	b=s/qhsSoFztJdqqAiN2zZZ7EXE7JgLIfYehvtz/BK9k7OVHFQu3MPIuc31/Dhp6JjsoP/
	 Pu/qMffIP+cQaKhAt3b8V2vHafge9vkf95mbEysfUHBfeP3Yv1pW2mT2RXyyIJ/35YAms
	 YtuuThXB1qUy8awPxYrvXUQhiiKKWe7LAzLx1PpOPlOgKprTAfGOl2HBDggih7MF6iuWi
	 w1aCJ2MSoDjsFJKUmc0FxTSTaJE/y8mesltYcZ5Fvk4yWc1WZGaqam72IJ/wPo6HOSBxL
	 jIeoSxLNvd7SR9sL5g1vAZ12J/Nt+o/gLt5s4liCuBIK48DxYEgSGzpbH42wCmnLPOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729576;
	bh=5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nlzsdqHdipRMawO7qIeAxpXRUZyHBX4UpQtMnVriK4ewDU2eqNqgzyq45J8mRKF4e
	 ShSMTEt0L4t9HxKgx1/B2qtZpkSma8d5bGxvh6YDL+IaJ7Gf1iBC8JSLsaV3tpD5X8
	 lnpwFLL1ZEtD4aoO1HC39i85SMzf1aSVastG16qZPkA/kBsikCE7+IJNLHeLh1JYTV
	 m/umTmnoZ+LNbPfXChP6owgP00/Z+nyOCm2TZBM2M/1G8lsLCsui8Sgn9g1a5RrnGO
	 XOYgCrFDU7HFcf/Q9argCNSYs9avm7EVLlItevRgXmm68sPtzB5UY+75CrJ9OR5ocV
	 FG2kpvS0K3nbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 741A180E15;
	Sun, 11 Oct 2026 14:39:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38FBC1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A77C605F1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cA_XXxP9N8SD for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C6D860616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724075;
 b=SH64HNL+sEVA3rb3xRplKW3PeU+h1dG5AJaAHlr0O7Rosj9jEAiPzvdJFFRhrZbM+99z
 PW7Ow499OrGrAmsnHQHb42+g4QBXuWfNKVgzjjxYLl2xxiWEQlYTIOqeLDRXyCKDmnP0m
 SekfRswHSOot4Tc0iCa4bcYsuUCP8WKMG74bUmbjOJJgTgKqtb2s4qwrEnAfonVFUoEpe
 hWV+a/8pJltEOpYi0bRmPfSOin3VPJUhmlTIuEOHTIGSMF7OeZ9ItNIriYwnQaGF6t3kf
 DjWyXHsqLTWiNiAciDOeI1/ze042zm6ywTfj/XzimY33r7n9FpOdcBimhh3IJD7zXZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724075;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=;
 b=dWmvCzzbIQm5G8q6KdhMvuD05zGCJGQ4/zSlJ3zsg32ikiMX9jqhv3afzzB5ni77EcV8
 o9ffDgsAdnuZr97ezaSBfCvefh86QU+kN80OaIdpBox2l71pizPyEbbnVGi4ueKMKmzza
 +m1bdj5WIbwDBMd1r4EGRkQo5ZKzrz5wMbSJUsbXcgdzZ2Cd2zr9+7om4XN0IGL0Iuby7
 NPAdES2Fn2MgB4nf3sbBL0bGLns89jRMlchw3OR9Bf+mwVlWXuoJELDyOT2W0vxlSs+AN
 rWr8mRljaFomw1xvrV6rUXxan8qXCnPUVKVumnC1cnCIwAsC2aT0BQbJT95uurhaYkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LknWwCbC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XWQ1yhQp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LknWwCbC; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XWQ1yhQp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C6D860616
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B857q82381410
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=; b=LknWwCbCgwSal6Bl
 IFG/YW22Sg0aGF+6JAhjzngLWbuu6h/h+BNSgVZkdJVJ23UT9krHkH7Ki3JTvctt
 XCVBP+s21oIf5hPlRw3v2v8bUvIcumiLUr6p2DciQI9NkaR5aAJpUCv1eXNmEZPw
 XpOjXXzyz7eLBshzJtM52rx8qBgIjtVdaCS1AisfWUFAxvpnydLx+g6cQr3F1MQC
 e+1l2gvQ7qh39nIhFjRfxS2mtFjhBWiPaAeVKTGmX4P+OSG+o16UzfPM73XK5PSV
 m+NG8gc4lAdjh+CddoMoLzREjwpotKmXQLcabzh4Cdjcy4KOjcg//QDXWYmUl6cv
 Z+8udg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4eawja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:54 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5e93f79ac54so826190e0c.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791724073; x=1792328873;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=;
 b=XWQ1yhQpif1ZU0FT3NVT0OviP3BE8jGRFYteW3rLhTKKIA/F9bbESgoRV6E3zvvZik
 GBIrZUsyFnn5gAgjikolA44HsUrYQWEfad8UY/BE5U+nPaEoqvINl77pG378xQn3luyd
 iep9GInfqgA/GCY6pbLEymOf5gYqH5FpQDKZtzsyAf9HKTN+PPMhQIWSamuuL30NiKlv
 cFo0v76hZGz+pKpWPXltdwBezZ4Iit/CLt3GFoVoFfit8GR7fVFQ4hhjHeevDLTLxarY
 V0Ojmi2erzBiF4wZVy1br8ifWcaCr0ZYGBrmm4z8vi09MLHU42O061w8vKZYkydgZWSA
 9X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791724073; x=1792328873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5oMlF9mEfwoQoh4TSEcLVfpHGC/XPbp4vDlXoWdRfxM=;
 b=nDKAfPtYCCOyfZ0TtvMpfrzrR3aBFLmRjUpXRffeTIMtmAsUfARqCkD+psSICOaxtg
 u5InbmfZGTCpakCUe9AcIarGzRlS4iOTrlg1D6Py27rjdVGaT0vesNU6SWi4qEIG7Lk0
 iJfHEEyC2MXoMUw+y6R1rUyqd4WcIXKYdnP7cecIUemgJ6/a37fLsR2rAgV4fVY171x9
 TeRhl+oNyXxl7JheurzVBdkO9ulAyNn6aWI+JxUqOn179Dzl3+TG+xk/f+IiGJ0PXbgD
 /O4uK8EmCErlb8dU5WzPHVQlz2Ho+sUwowuH3fgiPbJbkoGeUyzTeEFOjtzXyPjO7zxN
 ZRuA==
X-Gm-Message-State: AFq9FYJiMbCPEOVUgZwP6inaPMJg6ADu+AGVLa3n1a1H1QHSTnqGhKjA
 4GGEXXunqaD19Gr3URC0t2tb6Cf46rTc5CK9OASLJUDM0+WJqZRMB/a/sGdzbQvNkdcAMAv2Ior
 3xJ1fwvA7cOPHROM/hiy6i1o5mUGTsJK3rRmoEUQNMFuXMY3f6NT02rT9mDIH9aO2qwxFEUO2r6
 8LY+qn5Q==
X-Gm-Gg: AYBFou0tFeEZwtusWzdH25EgKBcHxb2s4kYhMARmqwnxD0en5Tjf5TkwIPEJwpK+atq
 0QPLcw0jAQwG59irsSROCYQJJH6Z5QUDNpVMGD/RYGq67LF06RD4h7486iGpvKxt+UuXL5kc7bt
 tmNni5fkG9wmTBpGUDegfhjA4gPk0ekVfAKNvvpXOexexghpiY4LCxLZ8K9P+7yC/YiKnDKjGea
 ROlZRBG52EW3kR8sceDQA/Dv9KwC5NgE8Z64jjqwoITEUW90wjMFiscetx5oIr8iBHcq1kSob5N
 fNj24KIH/ZBJwR+klE+5vuFlzQz+uzYj0W4EChtIX18Bqq+1Xp+EHvaSDOts1xINjh/j6SgDlS4
 6dlMHaqCS7m3BeXjFJSl9yvMg4N5iJW8EbTJhXy5DDLNC
X-Received: by 2002:a05:6122:e16b:b0:5c5:db2b:5baa with SMTP id
 71dfb90a1353d-5e91f4495e1mr2294318e0c.6.1791724073223; 
 Sun, 11 Oct 2026 06:07:53 -0700 (PDT)
X-Received: by 2002:a05:6122:e16b:b0:5c5:db2b:5baa with SMTP id
 71dfb90a1353d-5e91f4495e1mr2294289e0c.6.1791724072743; 
 Sun, 11 Oct 2026 06:07:52 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c346637b997sm53774266b.30.2026.10.11.06.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:07:49 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 15:07:37 +0200
Subject: [PATCH 2/2] optee: do not announce RPMB from within a supplicant RPC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX4PEnbVNChY6q
 7BPf8Jl+pq2Xc4azI5tUA+bjTI58Sxn7tUJixlvZJ1XF6JYxLl5+yZ5yenVMswWyf4O5QSHly8j
 3OFpVCJeAGPQkUJT+43ztd8n7K38710q3CgFLkW9ylGFmAk7E84bATokhmI7ciadPX1PA0Nj/a1
 qIWPaxWpGtI6OWbbVX0pE2r0fi9b1JlT3WDYAEPYy79vO5JU7L4HjdxYYSDEtSW/v82uvEcPwbC
 ngx4PhEw14HeejtM97O6VAsbiPb3/Vg5HU+FMe9IFS1/LVmsQ72odzFWT4rLCZ16IhbR1lIW48X
 rY2EAB7sIQY1TgQL5z5vSLh/mmX0hPMxQnm+dPXyKkdl8nMMeSxxT6TLbH9dsrhdS0x+VHfnbtl
 B0trqy6IgTlIc9EeN1uhk6lxIDrdB/go4k38OOp5ZDYUMWRA0cSIMqVuIgcHOeJa43WQa/1MKFN
 icy87FRjPcqX7pusPsg==
X-Proofpoint-ORIG-GUID: x6yTvlUnnB_W7bPh9pnt3m7CmCE42XvG
X-Proofpoint-GUID: x6yTvlUnnB_W7bPh9pnt3m7CmCE42XvG
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acb8a2a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=m6vmaEoSmGBd1Jr9uloA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX+qjVW3ZnzgOh
 4EIYzF6uCZLRrg7V8wMuji0Q4ZkOzl7P/KC6csRErB+ZHPY4UdlbNQnYIxOj0+jt7q86UN+itGJ
 SyzQ7uO3yYClpZI4bLpQuEFhN51+KCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110052
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

mmc_init() calls optee_rpmb_available() once the card has been set up.
When the first initialisation of the eMMC is triggered by the RPMB
supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
mutex, the announcement opens a nested session and OP-TEE's second thread
spins forever waiting for the mutex (U-Boot has no notification support
to put it to sleep). This happens whenever a TA touches its RPMB secure
storage before anything else in U-Boot has initialised the eMMC, for
example a TA call issued from the shell right after reset.

Track whether a supplicant RPC is being serviced and skip the
announcement in that case: OP-TEE is using the RPMB already.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/core.c          | 3 +++
 drivers/tee/optee/optee_private.h | 2 ++
 drivers/tee/optee/rpmb.c          | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a47c76811cd..b61f907a3ff 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
 static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		       void *page_list)
 {
+	struct optee_private *priv = dev_get_priv(dev);
 	struct tee_shm *shm;
 
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
@@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		break;
 	case OPTEE_SMC_RPC_FUNC_CMD:
 		shm = reg_pair_to_ptr(param->a1, param->a2);
+		priv->in_supplicant++;
 		optee_suppl_cmd(dev, shm, page_list);
+		priv->in_supplicant--;
 		break;
 	default:
 		break;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index daff3e04493..92e3b3bea10 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -42,6 +42,8 @@ struct optee_private {
 	struct mmc *rpmb_mmc;
 	int rpmb_dev_id;
 	int rpmb_original_part;
+	/* Non-zero while a supplicant RPC from OP-TEE is being serviced */
+	int in_supplicant;
 };
 
 struct optee_msg_arg;
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index ea5507af086..cc82fcead0e 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -224,6 +224,15 @@ void optee_rpmb_available(void)
 		    !device_active(dev))
 			continue;
 
+		/*
+		 * mmc_init() may run from the RPMB supplicant itself, while
+		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
+		 * nested call would then deadlock, and OP-TEE is about to use
+		 * the device anyway.
+		 */
+		if (((struct optee_private *)dev_get_priv(dev))->in_supplicant)
+			continue;
+
 		if (optee_open_enum_session(dev, &tee_sess) != 0)
 			continue;
 

-- 
2.53.0

