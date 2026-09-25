Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9F0C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 911066060A;
	Fri, 25 Sep 2026 14:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuBPEP3uPeBD; Fri, 25 Sep 2026 14:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D7ED1606BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346392;
	b=ZX33weUc5qZahJnWgBb4JVzylX8J3Z7WhppEWtKMPPRXhio46JzVguCqpX0drSCXXdv0
	 pkSNoEdLNRLmBSN/aBDx1363MXuVT+y108pwa0Nkp1PAt45jBY2LDzIVRSDcnZ5c8juy4
	 xMSDai/96iClyTLobZs6WmTQWiaiyOJYhT8q09XkjybijihqeJrHnT30WWM6tkLDEob4b
	 dQ14DipSjdYoroKteNMK/QREhvoq0pkYYbxC8K3U9alHHuspTbghrwro6+BiQJETvPXZ3
	 O1wz4UXV5wnEOvq9vmxzJVKOMuA0f5+LPbbhVQuzqftKp3IU2nFIkLXWETFZcOLZMHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxSj0Ldl5FM=;
	b=UeA1WxX4Tt+owWTDIi/m08WDFFWYn4jMsuK/UXl1AiD+/vL44JunTn/LMjIQ/+WjO6tf
	 FBp5iiQ6uw9VtuZ6AA1IQCjsCRjs0LIMxZbMoR0e6XX2ILN8ihfUxsTPV5YrZXoB8sULw
	 f4Wr3myCrK6XbU1Zg3xxhWSbGQE599ljzYPZuYJaC3gENe2CaCAlZZNGx+QPS62zkYcLK
	 M5QWp6/CruIahkw9B1byV4clWTmIDJtIhVvwzTSI8VuHx+SX5CN5t1w9En91iqDCyxQ5w
	 Ez937ShjLjbRCdxy2cj+JcNPD4EAn5IcA+kC+yB4HmsTYiW+ymvGxudr4/9KXrjolhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkN2ohLy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FVXhsEnB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346392;
	bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxSj0Ldl5FM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Scu3Im1E8NrUQmZ/XPm5kA3sJ9CV2mSHot/bzT84yUTwMciliCDa0j0e42wFg3L+N
	 AiXMWfitwmm9wAdd3XnXvvxWBY1qFWQNSPvRP+UCLlrheyXqTcvwAtMMDNNSqPrvC6
	 jHDxQcJT2N9ix+fj7kbQW5SbNmUdGxDQ3Kqm3HQoSnhIaRPFOe+VDiDmhL+UpUKKGW
	 yyjyduETeEz+TyUUuTMBKksrX80jRFUGb7zvI/bitHt/uBpR0rkpb9+Gs0BVzRGF2Y
	 JjvUSTjsdsVg0dyQPwK0Cryd8qa7gwypLxyFzRLTe09oXGeVZC8P9na45Gj8aNd76x
	 F50reXab3Y6Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7ED1606BF;
	Fri, 25 Sep 2026 14:26:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9233F35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83455606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRXwZ4yrKVbD for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 450E1606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343493;
 b=Z8B7nhWKbU3iAJN/frBT2W1TKH6S6igT0JRvxBteSWRWDjLhOyNGlkpP8eJUUdamAFKC
 xSlbAd7KXTlLV9kVGYfRq3/P9fvRrlGrnhh9KGLZfUAiJDIHsBLHbdr18yuOvzoJIEtim
 +1dq8jg3DHVekTtmLOsR1P4iUhbIbthSOF+1zjc4+pAWdnfR/+9WnYQ1FoZ6h7xcWgoSu
 DYYmergXrdLM+p8SO/vX0bwwwrIEUu8xk54ptFB69pquo9wjz6dEt9BdD+GbOkPr5jc+P
 PilxEIEfXyOndKqzPwMGKB9M2yYYwi7ttnvUsPLntIRZtczVscee5bMXtYMheuMAL2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343493;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxSj0Ldl5FM=;
 b=TP2b/IWRPrU3sDXBj9ZDuRumeLxfI9sp+GqwuG++BX7YPb8Bc6Y2Dpwj/iivzL/6kdqd
 ykHWsFbtTfkD5rzUGd4+Kq7ceFk9IE9IvVOrlvlV3B70PxS4ebX/dzqdoQ7jQcHc6F0BX
 7i9Oz7Bzm8sBqwgPedTlZv18lYbzoEK80L70+3dpNij9lXSIyYkItlt0TGiD1yMPRRxpV
 xIgrt6/0TkrYAp3fF3zDbpwQqi//XwZivQpDJZdtY6j6Up35MJsZgFCR0UsCpkl4xjsQa
 jkjEqSBeJbiqijZOYh7/cfin1ivXu97yEM6B7LqVDSIOehVoMpkoBnKbAtUhMqSAerQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WkN2ohLy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVXhsEnB; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkN2ohLy; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVXhsEnB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 450E1606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PBV87u425743
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxS
 j0Ldl5FM=; b=WkN2ohLyiZg53P+hc9rep4j14FXfnQMs6B9o5UQtgBJRm4xhlYK
 3F/37faspQGhzkAbaRugtzgH+NXHSU77Hhc2KDDMwtLqMrj8uhgetN9jNBuIeMvB
 KgM/vtTQWL9S1UL7XbI0Dy2pZlDXt/kxpxOCyVv+gTg0EdiXWnXm1/bwRNbh1TMc
 Hy4ufZ9TFCf6Xv7eLkJpohgjKx+8iCzHfunYDdvcOLZUUjP3nc1Y48aQp4FdNPlv
 44JyXhPjH4MGgXTf7mXqDbOGIqpzn+SYL83i13yKgM0uHLuWaMW9wnysYo/pVk/t
 CBu7NVdt1zkWaEHE1k4E1yheXbixVLHlfcg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e8cx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1473007eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343491; x=1790948291;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxSj0Ldl5FM=;
 b=FVXhsEnBwWIeIwvXedIbZ2ISxKXLO0AnoZBg90+eX7RV1tdMDqEMxOM91wi9HIT0XQ
 uOZv3axatCelIhdiZkqPuEPjzEqMtKRT7IYEVZU+nZ/4OQWV4as0iBTNySoCnfJRFKVn
 FBca33c8XTMvWK22RQ33YwvgpV7dXQzvDoSFDwyczWVYi0Oz+qmwxMl+cIeTDyXRz/vI
 Skl7cx00wqAUY3QwkFrdpkjxdCCGX5T1zQ/QQCTes3i2l58DkEebV3wO/wqQn6UAZjSQ
 fyYpTKKO9Y3TLaRaXRZE5h/2h1ZqdVK/mHXVZGyzNsJdPyJ2hqjtPAFwCpR27AfA2wKe
 KDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343491; x=1790948291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uoc5Len+/0Ydopx8QGk5DYWG4MpvZrGVfxSj0Ldl5FM=;
 b=M/CtmAsl4tamNUyh7rWicOMlky+aJQvE46zwbZZBn+TCh7SKhphiU6/yEuJk1Ia2Kt
 B0/pWpCmjHHUlMJO7YuPHRig+ZUpPhT6r7+tEyEAsv9wJ3y8F0kgsl+76n2wPI0jjsPX
 060O2xkM3nPnmkJtWVI8sDo/vmDxHqNCyn++9EfXprIfqxyPnL09v+beLQXv6V+4QduB
 EMibXn9AoQQatuFxLLVUowoFruOxMsyu3QoxG4/+ybn8k0aEgSSAuflnlwyVqsaucujQ
 D4CmosJfmRn88XLEaHul9Wd6OevDl5NWLhlnH3411wf9wBr+z31i80twvFg1aPFJy0eE
 lpcg==
X-Forwarded-Encrypted: i=1;
 AKwUvByGtQdUGFrAHlj/YvcDAZ2+9ASvCNLwkm7CCVDecmUiruP/6jK41i1ZyT29nHyL/bmXu2IFFk8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lV1lEydD4l5eLwI336vmvyKOgiHiKo5dMvGm+dACvyCiMiybXD
 Dum+xHLmoXSZ3qW0ghXinA2tJLttG8D7o/g0I8DTPe0cFa0N+PB7WbzMnOoHaF4HCAsaeNtQeTR
 ngZ/wxrGhsfpw+Jr7paT5OyEKVOxGlaS0a6JJ/76M7Rv6IuaeU6EYjiV0ZmqvshfJx3bBsng=
X-Gm-Gg: AYBFou3sZw+kz89odoe4UJ/aw4rUbUQ6G2QkCyZAQt9tkmCxWwmcKbjeVoS/PyK/xzL
 flzr3D3XkMdAFGdfJKxsCxV3cBgLGzPQfUH9j3MdHV/NDxKm4fdFyJO2rgmWyQphRV4wooii/aq
 66woKViC6yikg7m0kjs2nRRP942k/Pz0/zaupNgiBGcCR+suebxAPyCOh5klGtiaqrRjxSv9ugo
 CpPjOLdnsLUTIvWHH4u57pL252Y0DMDNzEatDkidebU99MjMzAbl3+VyNlx/Dbv7+XZFuuDLQPD
 o190ObxXzenSNYFiE+Zv37LLBHawl5pYYqQOaL1pd9xi9IgaTyTlWjCdiVwQVWKF/+/2JRxioW3
 /esyNKsKgNcdYxzgZsoxGfXhIOogST0fgyqSSm1wW1lxlC+8=
X-Received: by 2002:a05:701b:4202:10b0:138:4e43:6399 with SMTP id
 a92af1059eb24-146ce491e90mr272049c88.11.1790343490496; 
 Fri, 25 Sep 2026 06:38:10 -0700 (PDT)
X-Received: by 2002:a05:701b:4202:10b0:138:4e43:6399 with SMTP id
 a92af1059eb24-146ce491e90mr272016c88.11.1790343489706; 
 Fri, 25 Sep 2026 06:38:09 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:09 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 00/12] qcom: shikra: add eMMC SPL boot support
Date: Fri, 25 Sep 2026 06:37:54 -0700
Message-Id: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX93L2VV4PfWe9
 WJHwpc5TgGrLcYs/cvbO34UPyTc6kAfOBxiiCVFf1A7gLGSGVQJfICMIdeDCQEv1aDRnIybJBTF
 ksrla+YjU6EFZQBD9wgLgKgG4cJQyWw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX42PikKik04tb
 nSgRHICgfyM84Hy5WkPO5k841Ki078GGp2zPB5aArjhlj2vYdyyf38S0AEqgb0HrQRY/Vz0blDO
 vZJmVkWGCuZOQffHzZXLGWWOV5WTnUizW86egik4yMnAQmx+N+HjMpyA9L1IDxvbtsr0UXRKgBz
 w5Hs/RKEBF9nrfBaaCkjrap3OVP9W14ALeSXjxYxDsmnBBC22rD1PIouJa5qjLjh19RkpDEiFuh
 bOGLjd2p+y/E/DZ3kSyqDalw7CTnjsICFrImIrE9lu9dBhVOgGY7Ds1bRxzqbpuDxxs8ZhlWJ1K
 9FfRYVacA1sW/FUCEE8jjsdaKUjdVYi4YNjoBNoXGzCrVGiIqZhzyfg7Bf4281EYOUQvACOLVtg
 +67PWDXEjDrxx3rRc/ARgXeTx+3+MxN8sRxcHXqr2LtDDCvW/tfKuYVcSFij2BDB/mDZHcCeohP
 pqzoeqaCOlXZExW9XDQ==
X-Proofpoint-GUID: IIDvQjqfCqKMucguPDchLX-vimoUH0Oi
X-Proofpoint-ORIG-GUID: IIDvQjqfCqKMucguPDchLX-vimoUH0Oi
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab67943 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=YwgyGQ_rmKvcxYo6NmUA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

---
Changes in v2:
- Updated the email-id
---

Abhilash V (12):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP firmware dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  misc: qcom_geni: load firmware from declared storage
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  configs: qcom: add Shikra SPL defconfig
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  43 +++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |   8 +
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/mem_map.c            |  24 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 +++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 ++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 342 ++++++++++++++++++
 configs/qcom_shikra_spl_defconfig             | 110 ++++++
 drivers/clk/qcom/clock-qcom.c                 |  48 +++
 drivers/clk/qcom/clock-qcom.h                 |  24 ++
 drivers/clk/qcom/clock-shikra.c               |  73 +++-
 drivers/misc/qcom_geni.c                      |  98 ++++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   9 +-
 include/configs/shikra.h                      |  11 +
 19 files changed, 922 insertions(+), 46 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 configs/qcom_shikra_spl_defconfig
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

