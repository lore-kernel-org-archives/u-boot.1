Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F474CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5046A60714;
	Mon, 12 Oct 2026 05:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Blt31YWI7Ry2; Mon, 12 Oct 2026 05:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9523606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781258;
	b=Cw3lFZDudA75yXGnZW9dJdM6R3BjA51e4z6DBoxm9U2twxzWsIl4NnBh2b8gK67FXWSO
	 H21V3zwTtqU8AceHvRklI8QLQPB60qYFwswk0z1v9ur1HKjnJQ9wnwAuWTlDXEdYx7XqF
	 ZgPgz3+jQ2KnKH5+tQmbFtEyY3WSiyCvYkCOWpdQpVuKyBrnVLNMaV0fgq0/SexY3ce+I
	 Jmpi0OUqt84WQmEg1At5NgGlCHoV0LwrLkRF+xHvxtSsJzVniqMRu6ZJYWGIU/rIN0FcW
	 nbQLn3Xpxgr8v7cRN36/htouuwS+dTPw+zYEzKeg97xlV7w3L37k7S3/ZVVL0Ha/S4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmjwT5OUrRM=;
	b=RBIHJRWdufsugcdtR07NVr8RMwSK/0VqrZuG09+69CBm0quOxLiy8TW4UKdSdR3gGu5d
	 53KBKB1RPMGSxegSGAkQeKVmszD1oFXZdLRn0mPnz1w+7DrJcmWFmzOVsRuLS4MMaiaYz
	 nVRw9xxz1IShYVqb+lv3uTCmdPBxGwJ6wkiMgmhay+MJnmqmoMGdl8ZhO8Rs8dTe+drQk
	 491yVhJyF1eMx1qiX4Tz4t0+dwRt5CfhF9u6oYk7sMvlcoua8kO3HpFrbuhv8trfuEHAW
	 qIUe/7Xldd5f5DUmgBqe5z7p8XiyWh74UbLi6+trhS0A4Z6ujIjI7AOk2LXqRaMVlTw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781258;
	bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmjwT5OUrRM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nv5vJOp7UoTXgywqUThdE/YV3Aqa2F3PB8EE1O4COEHrjgG9g6sKcYlof5YW1q+uD
	 mABmnGF2DPzyby/KXqkNaKIhAncowx5s67nV4sVdGGVM8+ObcgMGFTK5KRc7nenWeF
	 z5jKqBaRlF4NLhURhFYpMOyirWLws/ePEsp0Ro2r7k5zJ0uwDpalGgrTWNriBMyL4v
	 SMv5ZwBv0L8lkecL6tgtIX7Gy3xgyYtJwUXqBAKnP8KCupnywvFoqUdCEK4yYgB6Hx
	 Y/deZFTy/c6GkAJHGkisfjLDAtN26H7k1JZQu+HbLvUr1EyPOi4Wtb3CiSfk4BnW/m
	 qOpQfvCRxeZ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9523606A2;
	Mon, 12 Oct 2026 05:00:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF88E9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1946405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lz329xKAJvR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7F6A405F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781255;
 b=ZLTuIojMj3UaD1bZZj/QlKn6QEil4Waw9+V3L2SlBbGpV7GM1+Yjp9QUpRthOfD2ClOc
 fYy6J1HUsL3jK7UkHODzWjreVq7a0RpGTrCzSa6qdaxGLjnDBBMYrNxs2foMoEg0PrpmR
 Ekt6NEcKFiuz0m3CHbsctN+HjychLetUOoNdbmnZSDhxBKmIQonQBo3xrWpFPgopY5LbH
 tZiK2JXzVeOEUrUkAxSBc6o5aF+lkCIZRjOB0ED+sD66puU767WfzJece7OI5SiGqDavn
 YpzDSf92D6itZLzWylgUIM4DGIDjFYUWrc/D43a+5imG+X8jabPjpBL1wU3srTaiz3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781255;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmjwT5OUrRM=;
 b=ULCxIPKG9VLRppMhioPzWrXp5Dw+xddSouUPBmBN2CYQkIyFiOeXrKM/yHhqfW/YMHAA
 HnQemeu7V2OMAdFs9l/iEfD5NEc+s868ycpWEMOT1HCNzhlBijOwUF7CAXLI0El+12pyJ
 QXWQEE6Tjy4qXbUalA5XLKblnqWgoQNzrOZhkIS8/KNLmE/Clad9IpzRrfAmHBgWp01du
 nDzrALJAiKQ/FHAaW1dcWIwvXSl/IA+xlgX9uyjKg5sNUuHV/HEqO7sPKyKdEDiYH+oyq
 aREkgGVaXXRbBwyClbGioYX89gxhAFxT1xfvEydi+0/xi8R3wtmQHjXadCmxg4uc5Tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=g+buFjvN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VCxXq+sc; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=g+buFjvN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VCxXq+sc
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7F6A405F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lDtk915888
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmj
 wT5OUrRM=; b=g+buFjvNq0sEN5u1CLbFl0B5h+gd/geGNpo9tV8D8lE0HPBUInx
 GW1B79AeitTVJgkuBYH8iyqMt6El095D0+M621Aofm/4nnyx8VH8wCNARt1JC8sx
 H5yn5rTTwou8tZkMdggp3ET9FCGOfUeKSpdy11llIx2lv5nC+lJY2pOA60IHlHBZ
 IiyaMuG6iXR64tyAKw3zlU3EQsKSAu+670+DfQXH6bu73pIQZJEPb+c4763l6pCT
 dmXOBtj6v+IDGHciFWcHy0IhnwGDRf+6uF3YIySaNF5Q+9wMSjV/qOUKv+ixUmXs
 tjVJDDXT0WllGIJDbWW4OR9YeusaW6iGEkA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24rkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35b68bc1985so98082eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781253; x=1792386053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmjwT5OUrRM=;
 b=VCxXq+scNJse+krDp25jBfMxVsqQXUlodZv0yW3EGUfG/2EXVIrLZIWsWF6KTuyhLQ
 DNeAn2V3Sca9cEga/f5aaSdLlPoR8MXxn5BaQYf14V2KW7xHkkKr8g+31omvZ+OGPwVE
 BBsZy+nlkXgLrKIyoda9wPFLS67lOAqcB3W1HY2qcCk1pJmsSCYh1NFkwZB/LPwE3eEs
 eFgzp3z92Ter6n5OexYGmgeTBO75v3knZ1r5vD2TSu7ocSxqJLeNI1oqk17QS5yx/NmW
 OB5B26v7ttIahJetQ0hftrsFH8ovw+PbhTWuLyl8+vxkwyC8fq63NfkVDjG2VUV6BzKp
 rsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781253; x=1792386053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2LLMfEVdZUYs2WUD9BvTVibzJd/tCBdqMmjwT5OUrRM=;
 b=2mukc+r0pP0GIalhXaB4TfVQko9lYOyNoqfOm3KUU37fPKtKr21Wzkljr3JHolmYgo
 W6iHjULCtUdJHClgshjR/FMyyc+6kpm2dMn+MItAErjEd+nRCglAqBc2LfDjsP/y8kgX
 U6hZvtM6D+M7GrR88Bxj4o1m+Q9NXyyXnSV4w5+FGroCIg7y91M9qX16O95HJAsvAIV5
 4xenoOwH8pHeG2LDa1/wywuktQnSTXDJvhfll75O2tL6Ab1gb7qkVIpuv7mFm5E8RhO2
 WxoKxR6t6c//qERKBNVHjcYgMV7yKzDXtcuu1pKioQQtfFy134bcbaSP/5NhzFf+Zq76
 iSBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFAJRfx51s49BgKxVFenWEvxFu9FxkT//9RD1bgApwytZE9K7w8aGwp7k9Zrghz7dOo0ayZSo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLwfxSHiyZsLW5xar6AzxOA94PiOdyM2742PMKIX+YURuHuxuKV
 3Hzusoi0hjbosp4i9WYyw+1OWEmOQQjkjFg56kCGq3jHE80490rwobykEDWTzEVpaTn9anIzV4L
 7RuWAuwvnwm1WsUpRrPRJlUi+ukMwgKbgpvSAcV98KNhLmIzg5R7jZDHPOxpbZj9myyJBdGc=
X-Gm-Gg: AYBFou0s9sDjCiIdOOui7RuC0oDRmgXTjmWTSYrOBfrlQ1+vie29rNZMBi7+Bq3n8Q1
 /K5SFU7E+F/ozPcnz1OiKRrlAuO6jVcGRCpGnWfuf0iuVzc/WJQxHH5D7LnJAhsMYBxeZYlDT0d
 XuzF8K3QGqFDZMu+UH5LGfCV7de8VvseaI5pP6UpJHZL2B6gZtchArdoTkTfAsZmZ97fa96WawU
 S1bqug3dPFmANQARkqq9NwdTm0UlqiPRfLcC0D+mB+COGwZ7yWmEuBnZB9OJDn1Rc0d6HkY/V36
 jARhXCTWP3uv1GTBt8mH0wevcubfuE2GlCdXaWrqJ9MwS6T96TBYfX/ArHJeeyP1eAlFwsD4DfX
 j7DN4YWi+TfEBwhesdOE0hV+WpozsM7Y8QlZa0H2g/1uK3mk=
X-Received: by 2002:a05:701b:2401:b0:14e:61bb:ec3d with SMTP id
 a92af1059eb24-16a5d63d0a2mr12302274c88.16.1791781252721; 
 Sun, 11 Oct 2026 22:00:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2401:b0:14e:61bb:ec3d with SMTP id
 a92af1059eb24-16a5d63d0a2mr12302234c88.16.1791781251950; 
 Sun, 11 Oct 2026 22:00:51 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm24317909c88.4.2026.10.11.22.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:00:51 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v5 0/3] arm: qcom: shikra: add SPL SD-card boot support
Date: Sun, 11 Oct 2026 22:00:36 -0700
Message-Id: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ymj3mvZL704bgJn7bHfz5tX6OsUsMX0h
X-Proofpoint-GUID: Ymj3mvZL704bgJn7bHfz5tX6OsUsMX0h
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc6985 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1JgvKvgw2bANhRT6bu8A:9 a=zgiPjhLxNE0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX9VaEXL7yK+xu
 XJ/sb8ZSuxYeiBhtnnF4IX3WReE2cc3aswEq6eceSndk3i8vH78rckMP6MZ1BL0JeL8T133BqB8
 CAw4hULL4iN6Cba3T6fV2AEBcOD2cdncjVmNZXHiXOS1VcL1gHg9SyF7Rc47c/Y1wM7536RTfFE
 I/yDg0/MYwXQnVZjAAK1Ch620weTMsq+6DC3Pb/12RI5eJ3ycpt6Ea54tXJyNyfqlpGeDTh4zRL
 eqAXeUfKSPct3l4bXrQFnYk/aUAkkpYme1qHg7kXQb4rZK2VlwYeIIvPK5kduN6PIod1Zh8FG8e
 7CnLqFJV8z6XR2H0c0ylqUyuWvTEAw6sKvYWgn6hmA2RnRs1AxBp9vfVoEfr64gAugIbFFyZ6tZ
 K2LfrFRFi3rdENlw1OOF+AzqTN6yBw4gxgSwgC8juL3Db92J3YK+DKE56JSCZIFqcsfuCHZFfDg
 rwjWguRu+ROR4dnKxnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX3eH5JgJdGT3m
 ZOus0avDJVq3fcEuVrLH9gQFl/YYNNKo2qI2dPGqo89AP4E6eqMjIy3r/OM4yHOBcwjpo579brf
 B4f9BxVBr2EKtdg3zBH6nT4Kas4T7M4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120019
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

  Add the required SDHC2 device-tree support and select the eMMC or SD
  boot device. Update clock handling so only the PLLs required by the
  selected clock source are enabled during early boot.

Depends on:
  https://lore.kernel.org/u-boot/20261008094912.419090-1-abhilash.v@oss.qualcomm.com/

Abhilash V (3):
  arm: dts: shikra: enable SPL SD card boot
  board: shikra: select SPL MMC boot source
  clk: qcom: shikra: gate PLLs by clock source

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++
 board/qualcomm/shikra/spl-shikra.c      | 99 +++++++++++++++----------
 drivers/clk/qcom/clock-shikra.c         |  7 +-
 4 files changed, 98 insertions(+), 41 deletions(-)

-- 
2.34.1

