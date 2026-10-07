Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8656BCA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 11:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 325514030A;
	Wed,  7 Oct 2026 11:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vXV1hjHyYUG; Wed,  7 Oct 2026 11:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 682FA40323
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791370954;
	b=gTByQgx8gGdcjyWp+tUWQl8mN0UqxcdsnyadJbm6oqz1MQhCG+Wp/6GIZNS//nYIxADn
	 a+Ey2EHh/zVcX8OkgQ6s7UVnpDuY3W/bf5wtDtumfMZm/EGQQDxokomhbsaWNuV8adiIY
	 25GVkMfQxcmIGa8Rn0jenCqtLmZ8DHHo1gX6UOOA6B6CHgFxwVprh19KYNToqB0Dm/5pL
	 d1J/fWkaGzDNVYANjzlKiERFg73qnu1046263WP51+5ONTSc9oCViAMzs8EBjTYqOiEWi
	 ruuLVpurG++/4FRn5jNHSeqVXnMSJvVBKmVrpUyTSaXo3ndoWMeTkD+wc3nOfSIVF1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791370954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dW720CMx/k6zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=;
	b=HN8fdBvQO64/Wp2Ct23CL98CBxFINuodBGciZ0472NbqTaF8U2zI4c15DUqyxyYt1xez
	 xZLQNJ64bP5InFRqJuJW3iwgAg5u56Tb7bzDVWveat7agXMsq3q3kOFpSd2P+MXoM3URt
	 PwW5hZQkOwcdzpjNwPFCh745RiWVqbOch3yqc0dG1976+0klvPe0hq9/q0b/+kWBGiTi/
	 eaCO1pYdtV6AGeiRTtFxs6GobvS0HCpe5h4F97uSduawh3k1uNOtCVvdNELKJ32La4WsN
	 WisspM8Rwc2cjyOMwiih+Ts09q6S6f62/sa34rBJtLS/memyHyz9vN2utLtIHQMWn1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791370954;
	bh=dW720CMx/k6zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KNQo+Q0KtDbIIUJ0XZ/mCJaYQIYzMd9EMc7ZKWuPAnRNGutMMOrdPAMBTj/HAhrmV
	 pvNgnBxfzeBrxx5vBtIIURmvRatzQxRAmyObvqFUvm7c3p9f1IO4PrGeZQ2Q7o6H8s
	 lUKDTwrsIgGImZiLooWN3vMPwVxUJV4g2z6yYlE7VRlehb9n57UtHE0azTmRN8H157
	 vDLdnrisMUZpug2LgvKqDmkb1WmjT/EV48VUHtKpTMoiTEvej61XzljWBKobWih4MY
	 EuJviiTDmZkzmDqnRMFf57gD38uQfh0HFvN0VU46ldv/eKkrW+b0itUHze+aeV1Mla
	 wK4XjOTgXTPXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 682FA40323;
	Wed,  7 Oct 2026 11:02:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0EF675
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B75BC40080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N921ygEKT6qk for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 10:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 02E7E40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791370329;
 b=F4dlDCeF/ajAyt2HyExgXTUXNRGzfyDd6fNn5FpjrDOocCoi04FL71twR9ughDNHIqGp
 iavCkBlyIZkzDCbzgxiuVR5d1WpMv5qACzVFuNL2YfKDnLh3qSkPoqZAA1lVAnqQ6dsS2
 0eUaRxXgx4je8xMASZMjziM2EfnqfVXmUNAOFjrpBO8k2pkn4XKy3MzziL1nJ4WM8CA55
 v/eoCiEmgcK1ODpLxutYlPlditJeH6Qi8jqOawhSks0v68ZPvgSc1Px7YOTn/2Ut0Q850
 CLdCYU+WokqpQ6EpS8d97oDmPYxXyMzSSfzibtgAgAFwiLwigo8omsA/yX93InY9LOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791370329;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=dW720CMx/k6zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=;
 b=eHklrIW5abx2Dny9cwG14gUz7kVsTQpPRHS/PLOUL6Dlmo8lmauIFfaBTN9iLfB4Reu6
 ne4HN5f+70REUw6QyLreDv2C4UrsQUrXfWVUNCelzL3i52zVJjHhJ/vXtBuFRIEgBD6vl
 9Qr/HUXseXEdWVr/ok24aLCFvKLb2uI6pxbDioBJ7/A0En4vtgxMsOhNJR77mdHDRH6ba
 KlTZXUSSrfHm1OPyNIgkqB65gGelu7EtMJ4HiKqzp7VMKTcuh8g4cPVRpPts/idV/FxCR
 Yc4DP8zhzaCU0aS041KAWHzIQ5AB/SIN/6jnRSarjEFXmPr3cVRzIRgmVeYkkdglrJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jXdcgM4w; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R5ITGxAz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jXdcgM4w; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R5ITGxAz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02E7E40057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:52:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jWe12481343
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 10:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dW720CMx/k6
 zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=; b=jXdcgM4wNp71FXH2uiHlI+nxJHV
 9JQM3ONiuO+miUBpuQKm9qLk0yVHivA762wiAXM99vIEroF5dZmRw+KnRZwOhSMC
 PQdEdcq5dDLiZdrZU+8+PH7IbXG86HTM6WhTLhluGVp38ZVvlgMN8Ao8X7Nkr67b
 sAz9pSS1Ot/qaHmaIfWmMrX7hVSRYPmRA5uWJY7l1RVQYr/YRDDBWl/DkKpbvKhR
 b4/50rpVB4mrwUpQZ5XaSukFJGXhFd7ANFSndw23C2Lz27U/4U5Mjd5YIGmmoaN4
 oyGwr3YnFN+SavjvVVzEz6/7rHYw1uDqpt5naarmYzLe1voWSlmzRmANIKw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1qvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:52:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438719cc1eso5841737c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791370327; x=1791975127;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dW720CMx/k6zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=;
 b=R5ITGxAz/HrBTgzcVLyXxHWRL1bHXJfi4Hi0sf8J+6WRatNeKG99W3Tw7rZG4kJCUD
 aH3x7oeqcyG/CkRcXb1rTMUwAPR4lmVffnqtf9VHqcF5M2bz549X4Cdu3nw9A+NXbG+Y
 fVOKnN1iw/I8mNKsddNuHH3dmdSaUOSG057Qk/o/cpaIskNnra7NXe23d3fxs8p9fGmi
 icU2krouj6fbr0dc7DCTTa4k/scnRQHnUvdiJIiVDHQvrRttK4Q53eeyQCaG4Pe1ROnB
 owF7lx2ToTsy40/ssTk2qZP8AUcPn6BGNsQZTac5s0CLmcqCebZkPWKGT4BkZSMDba+l
 xkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791370327; x=1791975127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dW720CMx/k6zbsIHbWrUp2pWHOHSRWqUcvCfVXu1Ohk=;
 b=Gezk11kHK9D5ZI3WOEanVp4r2gOenThrJSybQlS4/8yg10QB7shQMLxATGfbabgTmM
 OR3LG2rIm+lA6vmrEHlQTgneWTA+7U8fA8pyV8XxBmhD5pZAXOlyG6AqPPhyiscAw3LT
 uze5rxKGxrCt2P7Gw3M471eeg2d5xQAWvWeEaQUTe/B4Rt1aOTUvysS4GoCif5PshwuC
 gnZUlMg8yhDw37OjKFPlc3x+SswGTzjYQ4n/8yfFHUzwawGf0Q3U4al1A41B3qPWCKJx
 1XyAg9pfhhnG/90Moa1Rvqr/igJN/G+slNNHwj4rfm6ROIftlgQZerjVxX28Z9Jk9ZDy
 iOKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDLHX7hbWk/DI0xXhoI9xH7ZHYEoPnuMHYSnetQugj6bDG2s/DypCLBf4Z8/UOLO+2dPcO4yQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBHb6f8uVo4y4M1KTpM36ZN7RES+vWgMz1LPe+i8DPSEC7u8Pm
 DqEkQb3vMkvs14f5baTsJGrAZqUmE9tharsCB2m2PD6lx/f4URJK3vDAQ5JfWYjzRg0hhkIi97h
 acXNSjclXE7d6IlY98FN2Y53rlZcECVHivQHZcEgacR6OndgoIl0GWjnpfvr5LziUYUFYSv4=
X-Gm-Gg: AYBFou2VP0HiFBoNayg2UFplcV5h5vBicjPjKcR6cuFcKDmM7dWWUiO6hZgANOhtAMP
 qixfhg/dSqrwJPQFRW4tAfe8Jg9XlgiQZquptiASD7D6XDlq+L7HySyzEt3BO4z9tbI3QueaBER
 yP4w0kFABDv00fOkWP9IBOLdr9kpwUULhfgH1baMdyNuGQJsvFjjHZGJmC4HLwveEIZYu/uTNFl
 BtbQxV1JH+j4qwAQBXSxeEfm/7lM8pwnjw+AUrTlCFeQxH5nYxgKAOoA9jozKnwX+vQaBNLCcKU
 X8v1Yv6mb0NKRW62qVQ+VxIHu/8jx4MbPaHL6f1R3NGOeOQvqgGbAzXash7KjjUkHfho2wB91W9
 P6RHkKr2dkoZKuIwghVZIWPg/bIzm6dW5cd0HLGZfWali3X0lRpGQbE3xUHWJAqI31TCnYQXfXg
 WgXPkgNmHkAnBvO70=
X-Received: by 2002:a05:7022:ec88:b0:13b:3132:6e99 with SMTP id
 a92af1059eb24-1620665f54bmr2738681c88.20.1791370326571; 
 Wed, 07 Oct 2026 03:52:06 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:13b:3132:6e99 with SMTP id
 a92af1059eb24-1620665f54bmr2738621c88.20.1791370325985; 
 Wed, 07 Oct 2026 03:52:05 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-161684ba3fdsm6598053c88.12.2026.10.07.03.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:52:05 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: mkorpershoek@kernel.org
Cc: balaji.selvanathan@oss.qualcomm.com, casey.connolly@linaro.org,
 dario.binacchi@amarulasolutions.com, jbx6244@gmail.com, lukma@denx.de,
 marex@denx.de, neil.armstrong@linaro.org, pbrobinson@gmail.com,
 quentin.schulz@cherry.de, sjg@chromium.org,
 sumit.dhami@oss.qualcomm.com, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 vandhiadevan.karunamoorthy@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com
Subject: Re: [PATCH v1 0/8] gpt: enable writing a full-featured GPT via 'gpt
 write' over fastboot
Date: Wed,  7 Oct 2026 16:21:58 +0530
Message-ID: <20261007105158.4125250-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xhkdbtsn8qly2.fsf@mkorpers-koolstof.csb>
References: <xhkdbtsn8qly2.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfX/4UAF7ZXpKxE
 dX57tvcZfJHA+SYTeYO/EflbdjT2tw9RoJEQEIejaTfXISODVE3AoiTT9wBgo78xyZoSRTptf25
 4nfEBdbDtmcKux4J/0AYAdiZYCEXBIA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfXwomO6f4Ac+XH
 17Y/8wO4eY+2RXXB4XVVrNR81g704Z5myCF1SCOUun+wxNJdGMtcfIh0F+ZWOTTq/Q/O5dPPFEg
 PhX7qa94ptJSGEXv4E6RVTEaTEoOHayRfK4jYqayyDBo/G/IWHGLsgpQMb6fqrulqhnoaX6hMI4
 sow4y9Gf6LDVa6qoOliUaNXPrGusMKCBWi1SprVPVClYdSd9gc6eTNs00sdnfnJMtPNnJnvgp2V
 uK3YmI3wyAwPtjcwXYv0jVM913G+IzDcX0fb7briD5OLSBWyXELe4CmIGkpDwbR8dSSxDfTKyWf
 tTFi+9bXi3q88SMBDGfIDdpDBaq+HKPU959wylUouZjfxehFOkSKLDGsKk0wnjonAcsBoPuTv3M
 4wXFWY6r0/fYuLCCbhIju/cq0DyOXwsCxiwV+wCAzqFgxeazMFl1oAiChmZnZ2Ddl3aHXH2ArYB
 ue2GWQ1bvzYLbOBO73A==
X-Proofpoint-ORIG-GUID: 1YrO_ZWtIHPNgfMMMUE8vN8SXM4CLXSP
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac62457 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=PvILG7sLYrTHUmIzSu8A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 1YrO_ZWtIHPNgfMMMUE8vN8SXM4CLXSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070043
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

Hi Mattijs,

On Tue, 29 Sep 2026 14:30, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

>I've not looked that much into detail in this series, but enabling
>"fastboot oem run" feels wrong to me. "oem run" is a debug command. I
>don't recommend shipping any board by default with it.
>
>Also, more generally, I don't see to understand why it needs to be
>implemented this way? (Sending "gpt write" via "fastboot oem run")
>
>It seems to me that we already handle gpt flashing in fastboot.
>See: drivers/fastboot/fb_mmc.c
...
>Can we explain how this is any different please ?

Thanks for pointing out the existing GPT handling in fb_mmc.c.

Our use case is recovery through Snagboot. Instead of flashing a GPT image
pre-built on host, we need to construct the GPT on the target during
recovery because some GPT header fields (for ex. LastUsableLBA) depend on
the actual disk size which may not be available when a GPT image is 
prepared on the host.

For this reason, we use the already available u-boot's 'gpt write' command.
The host passes the partition information to u-boot, and 'gpt write' 
constructs the corresponding GPT at runtime using the disk size reported
by the device. This also allows final partition to use 'size=-', so that its
size is calculated dyanmically from the remaining space.

Fastboot 'oem run' is enabled for Snagboot recovery build only, so that a
script running on host such as Snagboot's Snagfactory module, can pass the 
'gpt write' command along with partition info to u-boot to construct GPT 
in the recovery process.

Best regards
Sumit Singh Dhami
