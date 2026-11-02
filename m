Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A7606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QPsxQ50S;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MFEBcGs+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KionUqzh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 681A1606B6;
	Mon,  2 Nov 2026 05:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DuiROw1LFcl; Mon,  2 Nov 2026 05:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AAEA606BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598569;
	b=Hc1YGgLsVRF/q3fMMbue/8yW5fnx+zVq5RElKuSHM0JUr7SgVSrOYUF+PPYqXsHKx4fc
	 GAyikyms3ar7b29ePC+5Ztb8CgDD7HU45rS6KoL/vbaQRMB0XDsgyTFsAae6R0cXMOWrI
	 6UoGnR4WJnKz6fp5f2jgNHamsPFWIyZ+DiJAG6Wiil97tV29NG31LtggPvN977g9u8k45
	 8lF8GnCXmyXrALZJS7fS4gj8BS19rklowPcr7uyueRl84fB5uaQhx0PzfN+0EHSEOxnMt
	 RKV1cPFaP7aJ/aW47qKTSMz61Sctuy6AiN50ZmrbWFVvcZkHazys7MsScstufdP1YAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	b=HCt64yxQTwPTutv4tplrAFNpfPJGCEvxN5PW8lLQFg/9AnLC6HqnfznJN+HvQ6H9F0nb
	 9ESRE4S1QLJdtvAdjHbSlz0RCUZ0DABeBI1yvVPBA9FAOJS8u3kSIPjDd8xvhdMgE26kW
	 gwdTQW3EICPWxVhsD7cR0xF2u2DUVLKFdEG+JlHTB3vnJq7Px2vcPC3DY+eEDkYy2/SxB
	 +v56CefhFxes7YD5RcFYmDd0gzf9DvdE5dzWfzFdO/4b+Vi3YwY9h6punT3yJpJ6UlEPF
	 5re1s65RPzpDWABx/h5v+KjVojZGRjBfvYeTr92rlHxH/QUWwym6POpx+wsj31U6B7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598569;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPsxQ50SAvGP5VcmoMCfi6MwEXMFiijxIJS0dBmLdL0DasR0i20/e77hU5h72bzgU
	 B1zTUZJHi0fFSsnmZO+INVhB5d9RlTCY9htn2b8tJy3KuaQXmeVKAUTq9OBQJttApq
	 NdjId41ON/7J7wukvvGanS5v9CU0xjAGc2oG5yUY+yQHy0ZN1Sdqeft8tydiiOxpAg
	 mvjCZPWtPQIcxgX5rJp5854TRTD8iXLx6sU+Yf67bGWfzMjVEoew43F8laS8yFJt7w
	 6ly9IoocYGJw+MoI6hcmZpoIFzQLj80T7ye+wjGsltjy6G2ez9qGr86o1MjfVFqb+R
	 Nw3c8LMvscRnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AAEA606BA;
	Mon,  2 Nov 2026 05:49:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D761435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EC2B4069F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRIm-N23ymfa for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86C9B405A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598567;
 b=l+zavARw2TdSS11p+nswD5Kh7fQIwaF9Eb1MSm5FGu2nzID0Bj4q8dpNS73Ptm0Tmsge
 AxfwQKmd+qnNDBBumFwZbwAxnZRTEO3ClKbC2QHVCwFfZ/M3xBlTtFXM7dqCaKk4nKY2O
 vbP4XwpqbascZ0W1hlFZ2GdufJPnSJLnNjjCfG0X5eG/HbLS4goJnAeGJh1aZbZoYP4/Q
 ioZyq/bJi2ZoZ4bpDk3cXjnXEjdRCdKSHgyR4Rvh0b+7IkCKfgcvId4TImqUsWOIUAWpW
 AMrS7ggr7uX8n9oikZ9GkONckJBobSh/61dDAVK5TqtRNtsuQhtSFA9lXmoh6EOeleg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598567;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=Viy5O4qV1mz+GeXZ/hP2CPE7BXvGeBURN7NB0C6YoDmouKofL3TgoFdtUvsugeXn1t1u
 EhknQArnC55HbzyfiNGofaCCQUsDqY7EUQ3A6g3Dh5GooEglYQE03VWwn/EFyL87t6877
 4xRzE5eLRD6/CJFlJTbK2SHTGuv3J2YMkReheC9xh11LPKbJkoEldCrhr4jtSVnn/HjPz
 FQy58qxNw0Fv4PRhc58AK0RNohUXioYXvQgZqRwn5wXc0SpkXOO0cg42PH+551ZNbbZ1w
 m7/7ZI+EIG//r6SpB9QvdBH0CrE7oIkyUrv/NITBiwr+LOvbtQAHccdU81A4xLkqc1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MFEBcGs+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KionUqzh; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MFEBcGs+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KionUqzh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86C9B405A5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A25VrsJ3924162
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=; b=MFEBcGs+I71hqm3m
 2kwv3dAJK5PERbFtnXQSyuBiSOXDYxJHodox6wmK9rdy0qrssJELJNoqQlR3SHBP
 aCmna24dlCbIEmkhI76/J8SE+3oGIRBqGnpXI0fCgFy5IQpcbRlG2P1CHnV43odO
 7GfPYllAFYOVvISqC0K4Fn4HkXilGWzM0aqp59PjuGyRKV1XUoiBHBKn9nQUxlWh
 emLiJiD1dZ0lMQ4W9EQr7N/qHmL0WCDPHI/wM4gDpbsiiYhhwNB3mpwfIsfSDAkI
 jaCN4VWZpc86X/fri0z2X2aRgsRTrU6hPg//jx/5vg1K2yVMcB/vMTNebJYjCQ+A
 W+fzRA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1r1jw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1af203073e0so2352639c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598566; x=1794203366;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=KionUqzhHphIIQ0UZQzDhX6A9NR+/Wm7ZdxCEcFirP0dMiM1kMLZ9LjKOUNG20h3F5
 RSXMJe7kk3+iiiZSX2g+6opk9SxsskFzeOxiu7drYEskuPK4/J9/qiFsrivv1NCSZxVG
 F6FcEpZxbWELuj147+BIp7/poEjDdLxBI2AlbeQJgWe68GiOTV0GXaTOLlisgVreYt7v
 R/+X9Tji4Iky0uu08PsdebfAfa3LXaCkXgmEAOtaP89uZTjpROX+PVx9fvqepjLp0eC3
 y1/6DD6U3qOHAT0Kg1CpJVDp2IcZpB87F6mSRwS+BVEsQVVG7BNHXWufb8rRwcWaJ7eB
 rWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598566; x=1794203366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=lRBbXV1IPL9ofTxhaiu5oGakUA710Aes4UPvHdcp0koPyHHZhx/jbXYe7G2nkDSNSQ
 P+sT1p81eZ6a7zQOC2C4FHk72BxscsIN2/imH2FQor0y6H74SWdJEYnbjguNZvNLpOvo
 csF0EeQ69PULp4YyNfJRk7HZltXr7I2ZQIaqJtsYCFHtihM45qZJYsJ/AtquT9RLzIIa
 MSQDbTPJiI37moJzaP8prOZyqiHUKtQghb8CjMtdKlVbhWyNMiLn5Mf0WV/+asoNIbue
 wQH6nL+6ku8FKNlFUpYZp4c9Pd0UgBtG3d5D/zs8B7IsiNS8KBVPMWQCbBBC0mFKKvcT
 zkEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTDtmpHJYXh8GcKF3BpOCbYioa+gQSsuwsvZYLrJzDmqnyggB4LVeheqEiZkqnAK/N8kE8xQ0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL7XyWf1+wtUIDG4CQdyvKZZBdg/B9+oAYofY0dbzgc4OmbX8J/
 CR4bIAkbquPS4wLGU4hIgauF1DwPReKcrPpQON9qLKcS8jrgJyZtfbyzCBGHeD5Ok58Rs75QV57
 cY/BD4NvqLXtaVFeyPYGaVPvJz5Q2Q1H+ZfhPVLghXzJVe5/kAUH5iyc8HQ9bhKKRMM/+rKQ=
X-Gm-Gg: AYBFou3ZXnJYKv4ryMJ8K9fTBQcraITcI2zANagkMEkG5WTdlistLPZb8MtXavcJYLz
 miazEVq3JVkJoBJMMD6ilxMvhyQlkqbedS3yT0xD6A8jBs6zX/HUSbKii/JcNTm3DbXXlRG3KDG
 ADjpj8+2hNMghP5f6m+eAKCyVomCBji4QSZcEC0gg0aiwgYb7Hat1ab0eLPLyEVx/HvOR1Ww3w9
 FKuvqFogV87uLxEpg2wW20KOnMYl91y295rAoO1m8/bGy1Fx7vQhwj2AH1+hmUvwwPJ7KNcjLkZ
 tDcBWJQpGLkChvCRulbG8lsPlXZToCwyEDrJt/kVs0Ok1H3yiT/8SmpgrUqrlBf2Xr0NQJe3Bjp
 qDdQS8KgUSCAjxqw6Io8bXlBmdlYaZKvVB8hjfz1xFowp0qSHZX9NffsEd3Uc+ymyUkCQS7r0zh
 kRqfiOI0MW3ZIpWvNhELMQnR7nZpMn8Ig44qKU2ibBLR4K4wOxITpEKbaL1uF6Jo7VOXk4A5UF0
 Fya3Q==
X-Received: by 2002:a05:701b:4511:10b0:160:6a5b:7edf with SMTP id
 a92af1059eb24-1ac5fd0852amr13128402c88.44.1793598565446; 
 Sun, 01 Nov 2026 21:49:25 -0800 (PST)
X-Received: by 2002:a05:701b:4511:10b0:160:6a5b:7edf with SMTP id
 a92af1059eb24-1ac5fd0852amr13128372c88.44.1793598564920; 
 Sun, 01 Nov 2026 21:49:24 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:24 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:36 +0530
Subject: [PATCH RESEND v10 04/15] mach-snapdragon: spl: Update boot device
 information in SMEM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-4-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: q6XI1iVnauINNCniLVaS_gtog2Ap2G3W
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae82466 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=DQyr3D7bF9Lo941LOacA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX+FuZrFo9aA3e
 sL3MsH7vCloWvp9rWMDNqRk1wdQDci7rAUr+VWAmaoGH1kurZqlvAsaqaHc/yrBwVfHF1h8pPUI
 4wLuoysqW/XP0UHm6npLTNKFano9TATc5IEZ7hgRT9oqnWYnjjyNHJPrWrcgKDfcM3S1E3gbLH7
 aogMCFW0YXYWb4jDyqDglYgVv6mxWAeTkJ03xe2WVbVuxv5Qhmjac/O2kZToReuMcEk2xIakzMT
 cvi1CnJujmzezmYRHnO9TcnrDBZ4hzOUn1aUozO9JPRN9n3e6LCwYub/xyyJwUIuBGBfQrZEUJI
 qo/ID5JnhoehLTx+SQmJm+8IRmScXY9ckMp+PtmUv8jjR9Ssdqhv5i5yV75qJnmFErDy9QXfcl2
 QIDYs2WTih07116N+VDcDS5MLsmMrxWZXAHL+duN12l6yScKvdVLcRKCeRwuqbtEVovEQ4iVnCI
 xVt53iiPidCuoBcKCFg==
X-Proofpoint-GUID: q6XI1iVnauINNCniLVaS_gtog2Ap2G3W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfXwas8izKDvDDw
 9Wg0Ap+5x3ZqxCQlBHjl9UEBtQMT00RSDI/vvnwCQSw3jJxGSsIhOLJCgqLm+5/6tFvo2CaRb46
 dIMAecVdIkhP9ogEdhF/vvBGFQW1XdI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
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

Update the SMEM with the boot device information got from the boot rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 41d8789a002..460d07ef0a3 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -21,3 +21,45 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = qcom_smem_init();
+	if (ret) {
+		pr_err("Failed init SMEM (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+
+	fltype = (u32 *)smem_get(-1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		*fltype = SMEM_BOOT_MMC_FLASH;
+		wmb();
+		return 0;
+	}
+
+	pr_err("Boot medium not specified\n");
+
+	return -ENOENT;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */

-- 
2.34.1

