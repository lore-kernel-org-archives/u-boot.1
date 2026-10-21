Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664D606A321
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ix2r9uWS;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZvBNQ1gT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmXDlVuP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5D96608CB;
	Wed, 21 Oct 2026 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmICoVawVyP5; Wed, 21 Oct 2026 12:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF8D860A6B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587038;
	b=QMGERF6m1K8eXWCuyAmeSHnSdJnqFVbvZ6Ksy2u5FanrDhNKt6NGuMq7TC1Xd9x4HEEB
	 xUpAC2V+d+EoEI4H7eRIWn3JngbaVyoEAP/mZoQw1Qqqd5Dh7gdbbyMC6o4b1ELHXoxbF
	 u5Gm5vpD558hr2a1amg+yAglSXM88P19d/zNjHkdW44Qf7HxDt3YyLi9K6JhORANrCybb
	 M/gTEU2ISA9TTLCfMD+FzCcOZf4V/0yrmi8tuVzk1pnZJjs5c+oOdfr5Bafb52CcEj0WO
	 i0nyNrj8UdIOBdkZC1dcMXOLz+AR3lVzmBId6PyxtmN/64x0eWWfCtd7JEz/dL+n+BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7n6WSbUWzvYy8OLSjV+A3a6preJcZGjyETkZirS+lFs=;
	b=nVfjwVEjr3fFKW47VrodvBp3hOzL0GrId0nDP3/jkgkfSPafR3ttO5oAYZ6jV7jj+Sqf
	 TxBMj2uynWNdAA5wVWOM2uMixUc/LILkDDUg5mmDKhLDc3r4KlWeu4oXWzsaHdLAZ11oN
	 pjDcl8Y6ikjzIlI0UPOUz6ppXNv2tEujZBJtoCgt4UpDeCI9Ps0nZEzNy/4D3fa2znEiY
	 Vu3lUOPDXhfmFFanLes2B732t5DLUnVkm6dgiQbCnHUDdB5oCmlAhxVoHzIiqzJSAq0Fb
	 oYONfhv9RMkw9+SthepYiF6N09q33k/KvOudXbupjYcA0f8aLwRdRBdIothXKLn6nDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587038;
	bh=7n6WSbUWzvYy8OLSjV+A3a6preJcZGjyETkZirS+lFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ix2r9uWSoUwpaqqX4xmnd21Y/vUdOKtI13SoH2uMTIq08t9w9X5hIf6J3bnUOpZVV
	 hopemqZ2Ht4Rm1Nr9nlcBsu9YtVuOxDG+2b+v8TucKCc8MXH6zJkQD8HGfz4gtChtU
	 +66SUtWla7RKbq5IswonnCYy/vtOwuWiIY5Hc3oSadlTeZFd/bmSAB/a5vtKGNSnEZ
	 mU/t8mMySUFQQccj8qEXBBMT6GgJ8Vui4wVrF3bYFBYjGIMnbVSJ3N1W6snWgNmQDX
	 s2HpZh9oWhLrNF3jZGDjEGUnLyA7FjchRPWWmVOup+LiOuc7PRm4cypUxtodIgwcB2
	 KVlQu1CU4+uvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF8D860A6B;
	Wed, 21 Oct 2026 12:50:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2097323A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06D57403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAUX-qgTg4Kw for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 58F3B40399
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587035;
 b=RFdOkUcutkCJ4Pk359xkSADtTAq6XbMrbA9EvVHYKlyrcraBPuSe0AwaBnEcHkcmw5S6
 hIiM2WDWyz5J7jntaUn5yBERmhYxN2OKkQTTAxkbhMONHygwU2i17RIOx4ad7RJRgmd6V
 FLZpOpdOhx0iM7B55bZxAC9sLgaF8nNXlsCG+/RBQWWg8K9i3EqgKcbOsFTndzlPEzh9Z
 CTAuVL3z4gD8YxWySq9RezdEYEweXJhKmCMwmjIdd3OaltA450JWbXmOInrCD3lz+tPyL
 SAtIssgunLyxU6QlporSuaMg+xjO0D6fqybIJT1swIQVrXJvLXIJRPztSqmclXoCoRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587035;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7n6WSbUWzvYy8OLSjV+A3a6preJcZGjyETkZirS+lFs=;
 b=NtnQlyKgQbjdA1YhmrJgO5TnlKFU8DLC3pTFgWhWuZMSNfOqS/FVTsc3RcqVQr1o+fYc
 yWo5pa6p34q7NMli+blLp245MVfC0WhFg8ywGwmhBG+ePHihbD/nlPpUkwqlJayrpEHmC
 uHLj++aU+xoF03oKR4j+WF6l0Ky7FdoXCHlrnlGfEZ/lePD1/NGKAZHfdDCwHgRS21onM
 FXCa1zxF3qi/gL/acvao+tyaYkVOUGlwwQszTLv1yGPvKMP85tVj0PvjbPsHjqvFu2vmM
 y7uLMx7C0ipJb5ERbLXiU5eq85rXJHpRvDraSXPdAbkZrqaaJ182SR+q0p5uT6KTBwg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZvBNQ1gT; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RmXDlVuP; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZvBNQ1gT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RmXDlVuP
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58F3B40399
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg8u11568316
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7n6WSbUWzvY
 y8OLSjV+A3a6preJcZGjyETkZirS+lFs=; b=ZvBNQ1gTXreQMveig5Xa7Kfh/q0
 n9rGsGoz8X2FiEqFnFfYIy4vzh4GbOiG4H26iGKl1bCmLKEE+49s0EVDHA6T5vK9
 1u9QRKbJlPMVMvxt8kTZRFyzq9qjnWwlPIV1MwPrWb7FynlorqQn5jYygMq2zuk4
 g009f/QBbDBGv+8MTcO1/MpY1nA7fAfjj8j97O23bGlBI622g+qCEhNUM0TMstFX
 1EbAjYGPeTmV38DyKM+CgffiXMIBZ0VqL45YvOqC4HYLn0dV2kvElJHeA1tp1t/+
 zBHF5+V03uJkeZ7L+EGH3BUnljEYXLd3pb1Gne+aJQug3Sc5Rbt+R9QLfCg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4ux5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so2335149c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587034; x=1793191834;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7n6WSbUWzvYy8OLSjV+A3a6preJcZGjyETkZirS+lFs=;
 b=RmXDlVuPSe7BQldb5oJNTY1Jxf5ItaE52BJmidx0b9SCqWdasYdfnLPTCRAB4hOFKe
 g/1dCCP+uWluRN6TN+5KITVtoEKZMqnZexNf519zg0gsn78hU1FiPftAurkl8vqoh1xg
 taZiIdiaGepIstYNIkf0X5FN9KurfZB4fvO8GlVUfBSnys2mp028d9gIQjoh4rNgiZbh
 WG785AzFglz80zG7sYXK6Y7yRESyij47jzqhfRCq4iNhn4Ppm14nMXTKV7gaDYBYwqTh
 4HHEe03VMiyL2bai//8mczTkohpy7+cDYvew87eO5WnZEpeo1ZZ1a6zaMTZ1Nv7h27Jb
 Adqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587034; x=1793191834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7n6WSbUWzvYy8OLSjV+A3a6preJcZGjyETkZirS+lFs=;
 b=2aD0jrUkSM6vB4ZCqiHV0zMSuTjtq3tnjk2PHmvxMAi1rmjjN6OeLfrVW8fV3SUGCh
 7r0voAUeEyuGdLB7+ANSSldLjnerVHzWhm4wYqqNe2lDBgD4AhwvGfgh3ZCz1s6JyKOT
 QIsFu+exLOV4ZcJ41M+VfmUMKWNO3qXEw/KC39JuSl+IV+F6LpNGSwEqs5zK6tTM3Wyu
 bQqwqJhY6GSMULKLMaESTpUbfEl5OkHE1QH0H7nDCxD9oYbP3hfcCFKbkncN7miLSTrL
 nKYYEnB7xcEeQeY1QC1Ht38UFve59h0H7AbaqQiZSaED12z6ey/wBJm+uyaJPowGaCZx
 whMg==
X-Gm-Message-State: AFq9FYKEGEAKKw5azNiZWHAs7KqvJkALdMIh6+kP0729IcP2DcYCEyV0
 5p3UP9IYDoqFUZLSHIB5IJi2xzPvTkm/1/GqLjspV8AdwufupOE2uHR2YaFD9hpX71qDjr7MJ4N
 6R5AC+qAh85nLgq8HUnchlpVQFuu2wBc0U3p9ztq2k5d1Z4NkZWgfP31svboSStwKMD/u1DouFX
 uVKFU=
X-Gm-Gg: AYBFou1V2cRkowHuP0HjuSczb9ntjXmg6M64F1TJL9pXkBZSXLfleu8OZAew/4YTb01
 fTRZLwcpWBWlVOzw/mM/D56HOpBQtm6a1mUxPHl3Un1MGajR7NYPaaMMfts00NtAU3MwiGrK6/U
 QpRkecWBqLo4hFVEpjJAvYTTwSSsjB2x/M4jPTpqELgyDoRDd5KaDtq+eZwGyx1TlT7UAHiVykh
 w3dxgDhcA8ymJVW6dDnhw5RZ7fi7VxbWo1p1In6kbzUqqLppPCj9GXEqrveV4C8E8gpc3p7EBmj
 7aCABNS6s7rWPee099EsAsSA2si+8x1ZD8pdykCJKhif6ZdwgGmS3TgtNHZPJAJJVmn/UMs860E
 1/u+0PbIc6UVvV/GmloYkNZCbUDxVL/lTYI9hVzMWL8KVAUwAxYhJ9dU2cvXp19GPMereJowxBv
 03/9M5COQd0kJ18cDkDskIw6/uBXWMwu+QtLw=
X-Received: by 2002:a05:701b:2059:10b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-190a83cdb63mr2605693c88.27.1792587033431; 
 Wed, 21 Oct 2026 05:50:33 -0700 (PDT)
X-Received: by 2002:a05:701b:2059:10b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-190a83cdb63mr2605669c88.27.1792587032814; 
 Wed, 21 Oct 2026 05:50:32 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:32 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 5/7] i2c: geni: Add chip probing support
Date: Wed, 21 Oct 2026 18:20:01 +0530
Message-Id: <20261021125003.2948090-6-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0j1e7dXIdO31a-K7rp_WrV0RNUGAyXoV
X-Proofpoint-GUID: 0j1e7dXIdO31a-K7rp_WrV0RNUGAyXoV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX8M7zKbCqdbrQ
 of3o2dAy5y3TfAeT7t6JMjJfSA+Y8jQeAfZZ28geW5Ez+zM2AtlSezaZG8InYhxT4VCOber2Quj
 uWw+fuG/XVX5rF5Mg8lKwgw60rNdlQA=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8b51a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6kYWyZcUu3lQk9GmsLkA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX03F3fflZvz05
 K5AGZnxD0vA1imgQ1+IP5SVf7Bkbh3cIE4sC5PtUn0h05/5g8mqeAFSP/8YlMfs4FvQv3nRoQvl
 SQ3kIB7qKWs2lrzFANfR376djRqG2pzv59t4xE8fBgURKkxrHSHGCi/qJ8bc9zYRGRqBQXVWYNQ
 mX5oL7XCnzJj1gi1QaIyPlwrrnnk1E8G7LcEuS58V9jiCYu3+79Aa+wlerrIB7QaanGh9Apb1bT
 zRLGP8yrH3C7XRekYs19s1TojQwdIDiJayjCoPcbWAkE7txnqhvDYWZqDSWKaoWBpVqvCR7qTIZ
 jqo8zBel4A2noX0Rl3bZqlSgh180YiwpjFksFU2n2CZG2/k3bwwBwP2vCaSs5Mu8Y5WhpMzdbjV
 K90XUFWQ4W+GoFZtZsiB1OaasuEnFaz7IOGxdQPewkedbau2S/D523pxaaHEXEI8ZVEecq92TBZ
 aHyuTOWtyQnrXFMKGvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210051
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for probing I2C devices using the GENI address-only command.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 15bfe640f59..30652df9bf6 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -282,6 +282,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32
 	return geni_i2c_fifo_rx_drain(geni, msg);
 }
 
+/* Probe to see if a chip is present. */
+static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
+			       uint chip_flags)
+{
+	struct geni_i2c_priv *geni = dev_get_priv(dev);
+	u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
+	u32 status;
+	ulong start;
+
+	(void)chip_flags;
+
+	/* Add delay before chip detect to prevent the bus going undefined. */
+	mdelay(1);
+
+	qcom_geni_i2c_conf(geni);
+	writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
+	geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
+	writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
+
+	start = get_timer(0);
+	while (get_timer(start) < I2C_TIMEOUT_MS) {
+		status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
+		if (status & M_CMD_DONE_EN) {
+			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
+			return (status & SE_I2C_ERR) ? -ENODEV : 0;
+		}
+		udelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
 {
 	struct geni_i2c_priv *geni = dev_get_priv(bus);
@@ -571,6 +603,7 @@ static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned int clk_freq)
 
 static const struct dm_i2c_ops geni_i2c_ops = {
 	.xfer		= geni_i2c_xfer,
+	.probe_chip	= geni_i2c_probe_chip,
 	.set_bus_speed	= geni_i2c_set_bus_speed,
 };
 
-- 
2.34.1

