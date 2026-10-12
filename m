Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB80ACA9EDD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4700606DA;
	Mon, 12 Oct 2026 17:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqXcZIRazwih; Mon, 12 Oct 2026 17:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 146E4606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824914;
	b=X9FZ6PGXeng+ZhpDzGkfaQSYQYI3fDIbEwEDJ1dgrZLkw1olOL34qoHxhWeXuZL5FdLD
	 UdYA/WyA2U9pmYe/PoZ3RagbgdliGFKVdi9WJMn7H1UpvAnMP45X01CoW4nAQyMArOjr9
	 964trcmnVeRVdaL4m84hWF/YaZTIt1X+6z5IyAcsIi5IOmwVlpRgx1+t4sqVg4RitVHag
	 rqWpesmCUwVPxS5NXL2tXvNJRznwPUMM+6i3OxGemwRkMJfSRb2m1nX/PX5ennY4p/LNf
	 jrcNYsgLAS9YGBTiSv8cZT16li4L5ARMrjCyvokhHH5BKqDpXOmp/ruUktDVSlQkH3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tve+mayWY+7OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=;
	b=oyooV8RbottI1jqxPur8Eo4NLZOFrAidPbOa+gxISGyhj3pniG0U7eQHleWZPjSlrd36
	 crpGtHKwBWIO8oBx/AFjXp+ir3BC/UDJPTunkR+NWS91LRjdE/gl6bON5Z7hTbD0gOHV1
	 Rr0Atoh/ERGxc+GqqlG6XdksZXOcvPetMA/5z/c19yBoo9bfTkfFS7Q6JA7HgdwT0i1Sv
	 y9Hni7TTeSYCI6/nqr5zhw34Vgs4dXRiw4KNoVvL2zI5H3veyYNCt4B2s+Xuhf7rEedla
	 YOVp7Ztplbj/6eVf/fZ+vdyqr2UX44QByt5LtXtWN5fPukMr3IXSVnuXH0NTpKwOwMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824914;
	bh=Tve+mayWY+7OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SGUTkDggOEQUQ955MHMlriQf2cVKhUDrZ2CqzKiiCWX4am8DgtnrKtxTiMlNgewmG
	 ON4zezNdMjVEnF7rnQ8jxUAtGecBv6ODayw8pHWURwxzolegdzoM2UhvPW2yernnE/
	 FExWmF5X7XwdndBjT3Kx3x2C7vwiSRsrW2irKQsb7pjbLhOSC0nz32cL74uzUtOjAy
	 qoRekvPo245p22XC0SWw3TyXH8TtHZeHaI/rDe2vdgB13gvZauDLBz7qz0Q3fwX7IJ
	 SnBRXX46UtSsR8mRuFy2H9Udeufx2vCv5AlB5YavC6ARViQoMFIxQ56G7/QCYbvFbr
	 C1bwhnAmhkwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 146E4606FD;
	Mon, 12 Oct 2026 17:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE4422E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4B7A80DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7M8oMMJzQml for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1E2280DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824912;
 b=hPaM4ICa49ZLx1/1xf3eVE3dewxTDy5/l5ASJU3JGpvIAX+DCuKxZ4gbTAiZGAjkW2fs
 x//JgV5mLvr9IRfm/GufS0YHaivvCbiA6OwKCX5FgE5QAHsuMKQyDtrBog/xktc+JGrJO
 EzVDWZhBck0OT7jtuaXoeyor3UeZxM6IfUMxE3JcI9dMSV81PeClXvvOYz75SDO7nWBqu
 +rOd9rkprb/Tp+pItZJU2OgtgsRNz4XPqrDDPPyB2yTqDDoOhJgqu+kcNA2uwnJ0l8vXf
 ZkGrMgqTh0yQkadqKwWV4CtJLR3Bu2Rs9dSm7D1xH69enKcxIqqKdvJb5xAAR7yzhiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824912;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Tve+mayWY+7OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=;
 b=Uc0hDJwBKObgoYYNkbigvq2fvxs6WC623OovpZ9dMMtWrbpBLbjx5zwKt0DmTfwst3IE
 2mAgLhrpjKxi4EKNL7DyhCsI4gryXxR5ZU6DGuUanLSwRzmTQjL1DOocDhHffbUb35GfE
 KNmjn74tjFWvrKy91fanw+2+1WyZ64K091T4z2hXTy7QgA4FLjtpD7UNB/sDqoWpHOwaa
 784FbI7fvJba7UAbdT8PwPut06AoQYHydZQS8xNi2niSW6iEukWPlm30B+a+9kPhEZ3P6
 x0tR/JaV2Xs6ErZBtwRbhQKUG4rz2GKjc747pbzTDzzEGh8TbMzEXGbZBBauXosdMvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cek0WEWZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q4ShHh+e; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cek0WEWZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q4ShHh+e
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1E2280DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFf3TJ3163338
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Tve+mayWY+7
 OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=; b=cek0WEWZSluXIyoGW3BM4UMC7O8
 6UolopOpC4p/w9u36VYASnBookdbH3B5BHUy3SaeeEX16UjBR8OrsgZndA7KUcHb
 8MMfvQnbOYpn8ABZrxzeevaZfjCKRYna61vypvCzxHFiD4z5mKsqvCBuluv2p05f
 JsuxndHgHVeKgMKFoVcsRQiDCXDcIiGhujdR2ZXsL/hHuicBT2mSgMzJCRCoHJbN
 1yOb+mZ6wsXnV6ob5bQmGAkXhgGH/ylQ6Ibgkn5JrsKNEOxPXDyLCtmjG4XTaUsb
 VXJx45QqyzIdCR25E0SAukH3BE2AMTRrM9AlMiJg/zAmpPc4t5qjh6NhkpQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1u3p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a0c25def6so2620177eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824909; x=1792429709;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tve+mayWY+7OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=;
 b=Q4ShHh+ehiTE/zGw9pYplNlYYl8pUrpyJCuPF2Mudjd2rgv6MV9G5jBfesHw31X2tt
 qgLOO1NOiEl7VPYWvBMm2RCoasb0Sbnjy1YywRuGzfA9Knq8mIpVnHjtHlllIEc1+MoT
 QiG5pvJ2dcAUSLsK447hWDF/GcUGUDVM2NlHlpFR9vI07FPuc9QsGp+V+nutPF4NRMyu
 W8OIkKRAYeS6+1yKPHhTIWPkx6H/qOTaTGXoAEQIccn19wJdjOX5oGtNIoBRbW0LNPX1
 iWit6tE6PqBOEJvo5lTSQe+MonvjP6hGVbNeXrA2EqrC9LpXBOw1BQGhM/ZuWp83eIX+
 vBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824909; x=1792429709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tve+mayWY+7OAgKV/r7HS9Bbl8WCMiodtCK/ydx/clE=;
 b=UMxqZYFq/9BmMjA6MadPzNplcIilMIroFI9C7+YMvz5bxKjspnxSFVGwxd8bjnsqJN
 d5mSm3njrHpWFaGiScDobu+FH4CCNn85/icGyRwC30TYhHng9Se69NC1OQeitJ2LUihv
 cO9xeCP55WdvuhGTlGERgAL4mR0SGbMif0yY2hyMH4CRpZcscVtTZv0bYo3tCB6XeObw
 fTMUj+KkVOrfzfhDgfpnww15ZdkoY2t3aAfiymq1xGFX568KHp4JKcg5Y+zLhQi6rJkT
 gMBD1PjjStqTW92VVv6xccCU7bRojikJcvfBndE6SzvGRqiTMNzO9cvOsosY6TgC74Hy
 3eng==
X-Forwarded-Encrypted: i=1;
 AKwUvBye4L70xUEgGA8atjzEOgNUz0LXvTtWuiVP8ItLjsA9kjzY9smywnZV9+qo9j5oXj0PCA0Kutk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIwTjEzV0S1c6/wjLB8NtvkBNY8Gtgeo98fjQ06CjYvcGMveMbM
 SiX+JOkKZCbvGjouYXLk53CuGnNKndHQxR/pcnjLuY1lpY4iV2xvK70AhT+7AthmC1KV/7JRRjf
 XjPTyPvsIIjpTA5ahNAJdkddKSlYHCNRG9S1iMKcp3ujzS7VLhZ4pa7bB00u4jRLeTMVBWS4=
X-Gm-Gg: AYBFou0+lWnv4Z0mMrS65yGuEne3GCGod66t+M9xemSGyD6PoXbJ5vnypHX5HGBT/wy
 jM3BLMp0yfGhUQ8SZJvimV56VXv2eaa6Z6YSopI05ZQjlBfUS7I2+OIKy4trK499yjAiJyDkFOt
 3UEdcIHfZA8IQgAD2ImRiu5NWg/Ao7S+svPQKgiSsV28jnqg9OtuxeRwcoKGIo3aFXY7OO7xOKS
 Hw0c1ldjMY+IcFvL/dtMymNh+eRAP7gviAA6wHIAeTdqtpZhbYePKujgf0FWlJQ9FNxUKZmfE42
 hqCNt+Na0czgB5Jo2ntHRgw08mWv7XSFaP8wHZSLCaOkdupv69y8K4EoBaytTDmjMURxc0dn9TF
 QwtWYKh1t1x6B5WDBhfncUsKgzgNqDr4GrYvkGEln8Zi7ELbRrN2vf39ZeJmoE2GMB3T0oCqHpu
 yjO+GPuOUzgtVgdOXXuA==
X-Received: by 2002:a05:7300:c3a8:b0:358:ec5c:bef1 with SMTP id
 5a478bee46e88-358ec5cbfadmr9609264eec.39.1791824909422; 
 Mon, 12 Oct 2026 10:08:29 -0700 (PDT)
X-Received: by 2002:a05:7300:c3a8:b0:358:ec5c:bef1 with SMTP id
 5a478bee46e88-358ec5cbfadmr9609230eec.39.1791824908701; 
 Mon, 12 Oct 2026 10:08:28 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:28 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND v5 4/5] configs: qcom_defconfig: Enable
 QCOM_FIT_MULTIDTB
Date: Mon, 12 Oct 2026 22:37:53 +0530
Message-Id: <20261012170754.1606314-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QUW5EVsO-6eQ5HsN1ELJvPRsGQsvkAJi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX5M3viQPkOjxf
 mZOwU6eKt7HXdrss7EYTA5WqTBFaT/mDj6NXSJ9DZ84kN/1A1e8fVLRuOfUGYBZkMoH/gZgxIwQ
 +gCn3DHMrHP8EVhZnMXva0MXYN5xMog=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acd140e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=1VxDqnHFAAAA:8
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=uqFMpbG4MC8BjM4yXrYA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-GUID: QUW5EVsO-6eQ5HsN1ELJvPRsGQsvkAJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX7fwtNRzdtc6Q
 tm6H6nIpUjJrhOJbYJqAahq+LHWOwQMSBpV0Bw6T+NsLEGxV6cML6Gp9fnbdKEea/uOFEiD8p6d
 l8pmM3tWQUZz1aW46FafyF1Vwo/v1ldYbKWvX69Ao0Ejg1xKhLz7A6DN4bc+OzvZr2v0r5kYxHz
 XDiN5seoX6FBHKquNAgVUVwtCBC7s7XTN2M4x3CoIeJM6aigulpXnL/xX9nj7BvwmfsI2AS9VMA
 CxASWlcU3Pt8sfHznN0CuBigJyaVHQE0N08vcO2fQf5eVyZv/hr/eFqfmDzr8lG1XjKlV0f/1eg
 7aoos3Eyl6JrTNJuGX5WxgMnaQ20R0CE8KA9VpLEpTkScycxGEPaxOe8yBMooP4DB07ovsZghQD
 ZIxIr6HqmmKToqITMPaSdfQhIggda4vYCPL7xGbaUiV/+3RoNClGisB7w08awjOcu6DSpzoMCbG
 DyZpchmqoHkWAd79m3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120068
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

Enable FIT multi-DTB selection and its OF_LIBFDT_OVERLAY dependency
by default.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589aa..a152ac6708f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -13,6 +13,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_QCOM_FIT_MULTIDTB=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
@@ -48,6 +49,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
-- 
2.34.1

