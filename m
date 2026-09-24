Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55010C98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B83A40D8F;
	Thu, 24 Sep 2026 10:25:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlfEPat6tCHb; Thu, 24 Sep 2026 10:25:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 975994084F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790245512;
	b=Ljc+g4mMBXCVGxZrNc+o7IoX4W5sxBMLJn+7mmEee7vLVKrbq+4K2E0rfBZFs6AtzpXm
	 yqx9GEJPjtocjh6lC+IQ0Ymvf5IApH7/qRYBNHh6yUUcBQNcJxFM0HbVIUuIr4Gb3cy8U
	 dFbuY9huKTqnsgB7EmVOG8tTM7gZHu9oFVFgGAXRwrmXFgyeKhRbLHX2clhoBOAnpOTRn
	 x3Qyw5Tu7/9aQMMucYklEXDJDzXpxQbcaRG7FRv1p+DwR4v5OGTSmkGLjld3AVcw2auFy
	 kav/UytcYDiy2rPqnJ/WbxyirV4Ixqx5iatFsBH4zcQkJB23He9X4fefapkqKHdQTJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790245512;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:X-Google-Original-From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=;
	b=Vu6v/mSc06RvcuUYY2pLrSJemw1FgXCMxPLyt/9012q8v7BCGohSKykQMEsY14oJjyLz
	 1gFM6ZtCoOXEwmPaa1OILN0WyNF7vJAJmmUZG/P7iDXTMYy1H8ITy8DHP0IKxMaRhF5UY
	 Fvh4+7S2KcQWCorzWudl/hIiiK4ZezCO03FhMLn9UIa+Cf2Ee0QYVS2iWBPbun5b7f5HL
	 wip4C2Ffb7AHSb8++uYE11QlqGP48lxAHf+hf1kjGl97ZyIAt4Hn5Jowtdf6WH7wgajjO
	 3aBOMwwRyX7UydpTAleGNuWBt+WP78eKDTPTt+3X7je7BjjjbDTZKxeHqAhsrk9QMRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790245512;
	bh=VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VtMhOZGj54JGOLZ8Qd1XCLVnKjFgC5l6tElCC4AH/J1Lqcz7FiKntbmgaLlJXOUkr
	 kudmfBwlXeZqcclRrom11etORHwJdLuFIErMpwZczb4TctA13xnHnewWNJEK9cD3GW
	 eBbESW0o38LF+ya4aNgEUevRes3RvvGEBifbKVXk3r3wUMMnBbVu48Yt/DRBv9/iUG
	 XKz5wq3lEb+HD8EZ9fCmSNnyd0R64ycbWv0b6OUEGVemsLCWlm9Q6CKUgr80hL5PtB
	 CamkowecijIXn0bMM7GZYtdeR7sdYnsDnrapUscRFnhLZRZbV7I2SPD1BPaBnIBV93
	 AFKad8DQpZFuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 975994084F;
	Thu, 24 Sep 2026 10:25:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7ADDD1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8AE760BAD
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_SQiRCeLimE for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CFCF660B97
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790245510;
 b=fbFCoe1VU2hJbwt6TZGyEKIMTl+mWEKBaZ98JMlqfmqVEqhFXNkW8dH6csLSZKi9Yoxa
 0CaIATg/KVlIYy9zBx8QW8addCqHZTkndw9i7NAgowfj/pj85cH+Qs/x7XOAohiQ/dVRc
 hligWSzoq4Y+9uK3JG8Pm71JETD2l3MEmxV3ezVz68RT+VRyMIPvJb/66t2X5Z5cQ0wrW
 WNIWmyXXandK++/TA7lFAZ9kqLbuLzXWXoWAimLFSWCID1GalISWCk+xQ5kThKeqAMrcG
 vZXdtqKoMhl5RBeKQsH88T0vnRiTaqMPL9TsnYYvwISMSEm/MmgqR3gRVxKQJvzLieQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790245510;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:X-Google-Original-From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=;
 b=mDPkICtCYI7FhNAWyvvwvYCu2Rv04+tc05vtuaCP91K5nmY5zZUJ9YId2o6jlIUJRfXI
 Sr/cyJCPp7EpMJroJuItwVE3XXSYXksWYx7Ex/ajfMUl96Q3dm/Vibq6YnM9I7zPUD8N3
 zOj4vnoE/3zo7JtJnJlzmSwohOWJciWF3sLlfMhr37lacf1ohhzoHKCpLpXY4C5OZ4gWo
 efouSt/BWjK3yMKbdyVicbE3RyE9CjRbNE9CLHC7JK7jzpHqrQu7cOugP8CzgYICaJtte
 fwcmqUPx48qAiHzBqeZqvE/nOwKI7ZLNrkhhZw4zeJ8Ahv0S0MgSh/Y1H6YUsReSVxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=csI5eBMc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="CtX/iOvG"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=csI5eBMc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CtX/iOvG
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFCF660B97
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OA5LTK1175599
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=; b=csI5eBMcgZMtOWw2
 3uDbmY7s13AdRv0amOvNAEhJ7F/H/2oJa8uC0XUJH/DTsbaJHYtlJT2PE0LBuXQO
 R1msyK4IN0A1MNkIPQGPkhRsvXQLtSSvt7ndCtveQAAD+idYoP6tdFW8pEQxWGJC
 xpHuYQfdVWt1gAmw0TiIhJh54rCUHqJ0ZhuW6JZ7AZlu9jojReNZEg9VM/XXBO5O
 Pvs++trNJi9GwDS7Rg8XPsPrioFF4hSFVkUPsE6N0fAFBZzMcXh7jMKFrFSSKsF1
 8AtU8w1usJLX199voybrm0UwSlniBOtDpXAnPJ4JeuskuhclBRVVb7gnPN8X05oK
 Sp8IBg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7r27e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2827506eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790245507; x=1790850307;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=;
 b=CtX/iOvGnYsSei8OmbUr6XmMO9qf7GJv55JSj2037Jicoi5afi0yiFrdCNQOicgd3I
 uTi5Kh03NhOIwr/zcgdwTObi1LtUCZD6prE6+Vb41L+PZfk4oWuYGKNrQBTmlXM4hpg/
 vCpp1c/ude+D75SyrepEq629RHj2Md4crLQqYlFuKg7uAjG89IS0VS/Tqw0+bU7FoQ59
 KBaMFVFXvZAF3OnoHtmo4I+hwIVXaLEE8KHWqD4DQKXpJnEJugruzZjm0Ichx3C3fYKS
 WZXbluheoQmS/s+2XUoAJsbPw7/QrEhNTvs9VGALEFE3yumkEV/tTtI3avOg8Btacm6s
 jwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790245507; x=1790850307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VWhNF/AsSEjVpun8yitVu1brMHlJEgUhgcEIV2uDBDc=;
 b=qFDNG06n0lZgene1bSEZqK+FZNE/jK+cqTrIh7+at9Ll2K+o3lvcrMV4S9d+ofKU8m
 Lm5a8UORPzPafCWUDFCbbHREr0I5BAckjxU7ADQgi4/Zoq9xvaUbVXh3LBZ+7kJdfTyl
 0f5DjZg0GOMIPfRj+cNnMAKRfFZnuXBimCQNXDtmzMv7/d6cqWVsI4bGBCbojXveAbUt
 P7dVFrS1aDhl7FZ++XF9v9oxx2ztcPa9xzSQC8znoC5Atlu3GUq4deKK+9HGn8Mzlol7
 n21LLfUlyPljISD8VdpGE/z0bbQunWm02lxGjUGh6eXRQVlA8itVfQPUuYIKFxLRh3f+
 ohxQ==
X-Gm-Message-State: AFuF++kO5/gJIghiUL7Yg9OsmK+ck75/HjrJheCjanIxBn/ZrV41oGNV
 OuxLa/LW+aURSy3vvsEGwmjkBT+bT664XnNQpcxi/6HtWij5MBbtlEbSvhWk10TjcNvgf8ejYwG
 bQes+7mPeuZH6AD3VZqgfKVbiiUKQjZRZbAIcls0yRHXrt65LBKFquzk5gM7YWNigYGYyqOHSnF
 4K9Po=
X-Gm-Gg: AYBFou3ud0QYDcouF2mFzwlsX2ZZlQN6gdKE8xjHLeurt3Y+wBZc/7EoaqBpQNqzmG9
 gHNaQv6/Z3s76Z/6dpJI1JbSSk0GVpmvgugs0ROPMSNbyIpPmvtvevdkzYleW2wnmT/IX9Rw+Jm
 YH55FlRjhvw5S1Tr2OveCe1imrUOWSpvg5145XdLI1X1pdfonEORuiX1WNxIYndgWh1q11Rfiyp
 jOD+v6uzs0an2ghMF36BS9n4zGXV3oxZxE1k5JAyPyfCbvBVnFvvkHz6X/TYrLLES8EomUp1nqe
 W7HDc1Pkr1Lb4KFqsxXmKzihZHvKtS9MDew90e7WHOtNjR6hTnudIkj+mKLg6GMytDe/VasXzpB
 megcYfsnxMTwThfDcuN04UXboVNYVB+EZ1+t0f+vk2EBpRKaDg/hho48ZRyt6ihLaH3gm0AqZ0A
 ==
X-Received: by 2002:a05:7300:7b0d:b0:33b:a4e3:9958 with SMTP id
 5a478bee46e88-33ffe44d299mr1616084eec.2.1790245506727; 
 Thu, 24 Sep 2026 03:25:06 -0700 (PDT)
X-Received: by 2002:a05:7300:7b0d:b0:33b:a4e3:9958 with SMTP id
 5a478bee46e88-33ffe44d299mr1616052eec.2.1790245506120; 
 Thu, 24 Sep 2026 03:25:06 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96f47d52sm14374789eec.28.2026.09.24.03.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:25:05 -0700 (PDT)
From: test <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Google-Original-From: test <test@test.com>
Date: Thu, 24 Sep 2026 15:54:54 +0530
Subject: [PATCH v2 1/2] misc: qcom_geni: fix NULL pointer dereference in
 qcom_geni_load_firmware()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-series3-oem-spi-nor-init-v2-1-fd8ac27e7057@test.com>
References: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
In-Reply-To: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790245495; l=1161;
 i=test@test.com; s=20260817; h=from:subject:message-id;
 bh=Cfb/XkPFsxJRGjiVdaQVAk1QPRPMhXAaSfceEzW6ZwY=;
 b=IYuVXN9DyLROW7rUc5+B7hY7IQQsEY6JB4hg/w3mqpxiRhDHvyTVMPckthNGlXcySMMa5F7Gz
 o4Z0W4ktgOiAqjKogxSF9LOd11+IPlZXDSQ09Zs9W1oiGiN9SdZ448h
X-Developer-Key: i=test@test.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: C03De_Rod9lbSJHi-XJmmQyr_eotbLDS
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab4fa83 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=M4dTc-2S2o3kxq7vbtYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX7TI3MB/ry/it
 3DgPxvedTfR8TKm8JAzaPh/PY84v3gMk2Ektg+P7FKhEDsO7SdQ2T1BCXOWbU9NWgUTpcVn7TMm
 pg9dwQv2PSFDb/KAMOMZuLF5uJdUujlH2iEWtZx9zA7SY6IULxFmBKMm/D0C34yh5ubbc0tl5Gj
 YYQQE0yQUtw2Ma6Kc0/KNGyxlwrkTb6eIUTiSKuW3nEXuqTr+2YsEmThNENtiA4S3s6+1viofsN
 zmbUKnLvjbf7dWXVXiVuBusGzEaziHa3eurtruYWmNtwkakwQfmGSD+MrPjCiikfte0QLcwx+sN
 /fbg20mGPJCRXrldQ2ZlrO74YtA+kWLsaKh35WTce0A0KVtrKcnDjiTfHXZULJgR+PWzKUsoN6s
 f3ijovCEBk84abU0xBjez2d1lzbQh15i0WgQcmbt63zQK5qDJb3f9MSMzSKjyd5Xoi9t4JLhI2B
 lqYUzvbQ81XvsrSyFsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX8eqZ+e5JlTNV
 zzBZanFPDieYfBNjHVqyTuYHMxCW9DZeEa6FFaZky4+acLPIZHNkiRupsXugFVSItFcrBVZknfG
 ZTbRfL3+hoDKlmbWPGaujT+nH4vpJAQ=
X-Proofpoint-ORIG-GUID: C03De_Rod9lbSJHi-XJmmQyr_eotbLDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240043
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

From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

qcom_geni_fw_initialise() only populates the GENI wrapper's private
data (fw) if it finds a firmware partition at EVT_LAST_STAGE_INIT. On
a board with no MMC/UFS storage and an unprovisioned SPI-NOR (before
any image has been flashed), it leaves fw NULL, and a later GENI
peripheral probe crashes dereferencing it in
qcom_geni_load_firmware().

Add a NULL check that returns -ENOENT instead, matching how the SPI
caller already handles a nonzero return from this function.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..2e8f72d5c8e 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -376,6 +376,10 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
+	if (!fw) {
+		dev_err(dev, "QUP firmware not available\n");
+		return -ENOENT;
+	}
 
 	ret = read_elf(&rsc, fw, &hdr);
 	if (ret) {

-- 
2.34.1

