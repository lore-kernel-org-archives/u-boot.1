Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12C0CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8650E606A5;
	Tue, 13 Oct 2026 11:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFgoxcup2gFT; Tue, 13 Oct 2026 11:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA53960652
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889585;
	b=KjaO1GdVmrtIgBtJRhBeEZ8W0knVfSmlmEDDc2EgHeZvaXkzg+rNeVla1PErSQNcIElO
	 KEYAHm5XyeKHD+3JA1vVcfbUDRbkZWYXGUbjp3+TJ11SIjjmGT+GF/kghRrgnZkKpz1u9
	 EZ9u7Z6um0JCQUy3sDR4z4E5gNUrjPkbiognwgGhYaoFVDKuUPKuKKLTXoBQ50MQYCofR
	 eF0pWNuvwaqmZi11g1CSkOkeZddgUHz3jWsiFkx6HOevCx6UfrFSUagtly68Gq0yZzRx7
	 iYft2irXKRQgVRj8vtqECH2tU4SVmq+OiLpLl1KDzDG27v+oDbf6yUIAGcnnMLr1IIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AJ+ob+gZs/TBo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=;
	b=mDRH3akcTyTh68CIiDG32oeDsu3oxygaO1Dk0Uab+ku19Yq77fUao0adKd9nDOHS9V5c
	 XcasxbX+Tj0ubA7KRe3AjUM4v2KMHlHL/zJUPCTnZwgwaVMLejuRzv0nri7/IoebVNr0g
	 9L9OIjMPmz+l2xW17TsgY4KstOGfUgUvM3TvbLU9k6oOzuePAt6XObk+ecN76j9bnbm1b
	 T0/WzReINZl0fSvzKgQQLHMS8EUWeLqEpgF00Bws4k0fyH51kKV0jPt4f4i3FK9Jyv10l
	 wHqi0eC25mPghWxCK2UJovkER8BRWrL5OxVusnkOc92F5dyjRNL4zkgeIPy2TZpKs7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889585;
	bh=AJ+ob+gZs/TBo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQFgmbqMsvPnZ18rFapNcMQwYUkLpu5EdWX6Q5w2PDIKeL7LL99SztBXlLLcZbMgQ
	 NhUWKFR9bAnf3a5lUvYCFy0FbNxFiSoIPy4RvGFN6wS1RW5vFspdH7R4rVwc8+8mac
	 200rqZcWjQ8UoL6GaYstkbSsZvhuND/simE5E7lPcMmivvfW8Knl2MDn9/eJ7Tz5hr
	 LbHRCrmlQzH8AUfWY1mun/vvtk6xDKkOvifRSPO3fteHnXUs/zNxg3YafPMY/yvwgh
	 l2Yi920ZUSds6OkBhA4XYWWJ/xLoIEbkH1ymiEGicrydeaLx4SntOuzHpvoWcap83R
	 3hyB7vW3nXdEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA53960652;
	Tue, 13 Oct 2026 11:06:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 037924DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3F4680AEF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeSlZoKosrqw for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:06:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18B9880C2A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791889583;
 b=ipLO5QGXKumMkB4vK7XHIqcJOqZMkNHgHDx9yxYsyLfC1tg2j0yfTYHUAxNYyVCMi4PW
 b1GChRc7X2kmbuHoPhJH8iQDP992kxJi64Oh2h5786Xh4pHd8LpCmpANaUzWK8YfPSdcZ
 8UyRzVFuX43C/kM5T/JTz0wZ6NfLgkDqcVohvmUKcLUeojiszYmIpLsWeax2FYecOu2yv
 IVo/qzlqwoTCJH/cQj4wbDMUAT6tWMqxq1JCZQTaWjjw7E8uFoKS94YxKJ52ZLjlyp5/u
 5jUiOyXCyawbmZeW0O83KOI+aLUTXe6cXtWhDLTCR6YMSleKAMqkYseemn7b90lL7zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889583;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=AJ+ob+gZs/TBo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=;
 b=pzuLUnM1P+3LptiG6ozdsp2fD50KhdNnmme7LHH1xpijIU7+XCI/5gHuFaC/C/GL9x+o
 TFjywXA7PhsV6UdcZ4eic/h6lifWqbn16iQhJqmzdmN8AQZGYWY7VlHvTyurxRhyNgdkA
 egdl5l42dtLu7FuIkWev9y748Ut6iDzuj4bmb3GvGF6yn8T09QHh4QhvKTgMHzkiaeX5Z
 gsHYlMXhNZA6BYUvjJBZZVIVl96KkP0HJllXdTNiq6SWd1MeLWvn54zDEDDUPKviazZNS
 BYcVp/J+Gt/4bdXdPF+bnrH+j3/wRoZARruP3fceSZSlQDS/N0YZ992TzKVVQrYnhVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Jm3ynUWj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iEDDgHe9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jm3ynUWj; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iEDDgHe9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18B9880C2A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8Vs263054911
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AJ+ob+gZs/T
 Bo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=; b=Jm3ynUWjLubcVHNxUC8JF/Y6DNR
 /i6LzNiSCjmz0nxY0wEDgyP2bW6jUxNgg34cEDRtY22nIWFSJaZIlC1T+0fGaI5+
 /Tdu5GQcJ7SxQa6MbVUvcxCi7v7VxZMAf0EcqSbK0H0CgDsJuVPrIySN1bqwv4Tn
 iqNmJChDI7tKmph+XSBVUw5J5jaFZ9tWkW5oDYiT+lxWGdo90oMNHpYh4DaHvoVd
 W2IntHjRzQ2ywJJqA3Z6WWwRU4NAtXpA5d0xRaRaaEoaNou/QkHQy9oM4bF0htUi
 PbIUqvc+kqmrqMWMrOfaxe2go4J36QwqWAKxPqqVjpbo598Xte9+5QE5cfA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeuy0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6701295eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889580; x=1792494380;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AJ+ob+gZs/TBo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=;
 b=iEDDgHe9U4iFBKSZ4AwCaNc3zdFasZLUSWmGVGVtOEm7yh9iB6uwEd1q8UqA7qXQWD
 ot9Mm8p5wlUC6lIkr6B9V5rKNPCVJQuEl2q2UsH70kexFy0kvjaNXSNy8fekx8zq05zE
 ZDK64pgUbs2oOM+r/kHEheQClM/DvDTyP7ZXC8YP4Uvww9yV63B940UKtJknbxWFTR9c
 QsutmdDXpOCHgeeK2IXRUAvvDiAFwQHb3FxUISW5zaEVPsKCVCVg69IlVeTiXOQSm986
 0r4jIcf8gmic3FyXBrLiZwltYMro4ecO8CviRq8cbYfdBJSTgeQMvGM/S+H24u41/EhG
 lVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889580; x=1792494380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AJ+ob+gZs/TBo3mF1o9n8ykbX07QdNllTkabCrIW0Z0=;
 b=KqfORlDKAOCxgPuf7PN4urH0BPM/HQqAUoedFpMauuNaqVt8IdsxtU43eleWF8e6aQ
 0r77FXpXkxrMCTBHGumemjoMhyeaa+lN9bSkZPfJ5OFj4owoE+CUfIHt33nDtUbuXQSy
 dVbilC3jT/z3rJSOllxgyd86C/NJbat50SbQ6baYDxVecIKgGVNGbD41wC0vhQX9fItI
 NobGnhk56vDXIdGtzOlagrh9mdtWNVbBsE1G29VSS7lFkt6Y32c3o5lL3EK4FP5ngpDD
 rlLNLRRSVuIyzqpnLZsmQhpuU1I6nrh+B4b8vpM17gdQ09+mTG1zjoPvzs0A8C8+3bZ/
 HjgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBze4RbiRlwWX2ss0UbKj8YZATzGzUhTZXRDBuMBa5O09Cgho9H8AUqNQJO7Up2qwrRcpbxkNVs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKqEA/9WUeezAuHT/5ToBBfYzySnEJ0fOxCdDSLZ37F71V6tl2d
 qlhCYo36+gjiFIOVrlkxc/vPlAlBUGCYe8RgySUNtx17ShbnLKcJjQpSokWAdX/ADaAiBRilZqP
 z8ghDujpsaiGmOd/wLr9g9OzTR80PX+2X/7xOvVtDPlv26oJJyPcKREFkPB+/9KuBHccbOS4=
X-Gm-Gg: AYBFou0bzbabp5N9UnmIU59AJW6TababZAmEcGiPZebeH6EXBzse9WJ6tcNEz75VmDv
 qR+0IEdWDEjNMyQo/+u3hlzEecNdFxBcNEepOa47ZzP9uIGXVdtiTp/Q6grTkVbOpmXepZV4jBg
 pbDNBwQlSn0tl9kY1aIijHu0xTQinhO8xJAR2BnB/FFJL7Rk4Q96OzhI+lm9noKcHrGwBSpt3kk
 y7RkGK9HflClmwf6GTKUqJAjnFYrF9RTcDvjMUtPTA/bh0Qzq8umQPxb0k8mUlZ95OBcQLe4Qn8
 sMO5OOsmDDocBbjikGof/sIXkeTzZApNQ0mpi6dUC3I50U3szbfNQylHwFl6cdxNdUeNX6dSwMP
 FzyoFUJqXmVIVOpCo6+LJlF36WrffKqHG2NAd+rw/XR7mFHiElumX+EzXJZE3xQC05b0kbjzfjJ
 jb1Zk5qwXPaLs+gUehRA==
X-Received: by 2002:a05:701b:2806:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-16a6043ce94mr17875316c88.30.1791889580188; 
 Tue, 13 Oct 2026 04:06:20 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-16a6043ce94mr17875265c88.30.1791889579446; 
 Tue, 13 Oct 2026 04:06:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm37460642c88.3.2026.10.13.04.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:06:19 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v5 1/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Date: Tue, 13 Oct 2026 16:35:23 +0530
Message-Id: <20261013110525.2465737-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7W96wA54Us3kWC4E-379KXC5WRfGM1vZ
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace10ad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=aHHwf1IshyYoWWdMeKcA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX5y6TL5bi7R+E
 q0JYt3bHYNc1j+X8g63YSvwRzyQFIw0f4kDdh9YLzHF459emDL6SMhUuraoeqguxSj8WDUOOSZe
 Mqd18xquS99+4v+DjcoBfQdMRkX2P0M=
X-Proofpoint-ORIG-GUID: 7W96wA54Us3kWC4E-379KXC5WRfGM1vZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX7XBwItciA0+l
 3upjjtQZYObdGRhjcyIri0VpmLTARVZQE+cLwWEjbib4m5DbR9oYuK9S6RsaJRE8s1mqDVFbvGx
 dj6gxT7lvYgNKCY4D664CzKyj/LXQLVEF9JHOCF9jzGcfOYNKsL7ZfEksIwzU0F8kWXda3Mi/6/
 xoxXKAQ4evKi3GxAYN8TaLLZ4Q7QxORTNQfWqdCM/yeIgc4EmnMcoXqZUH2kjXDIUvYEq5Pd494
 GPjmv14U+g7ys33eGOKMpt+QGWfPRzWvsI26mTBLUJAstu/aecZfKwKr0Z7/JLFNQaNcU0EZG8B
 EIwAc3K+pbOEhpWUtp4E247DNWzX/NhnDoNzdd5vsJBsOgQSjRUm9JYDT+gaDHAXN7rnihnnkbO
 kVkleFZS5Ke9Ffk7XKY5ZDLflI2M6Mw6k+o6+uiyagU9GHxTvZ2+O8klNB5HvZwJ4/zmxq0+D5r
 DKlSE/rlkwAzKCzIIfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130044
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

Exit Gunyah hypervisor and switch to EL2 during early boot on
Qualcomm Dragonwing family platforms. This must happen before EL
register configuration in start.S so that U-Boot can run properly
at EL2 to support hypervisors requiring EL2 privilege level.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  8 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  2 ++
 .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..2c182c7b974 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -80,6 +80,14 @@ config BOOT0_SDM845_WORKAROUND
 	help
 	  Select this if you are building U-Boot SPL for sdm845.
 
+config QCOM_EL2_GUNYAH_EXIT_SUPPORT
+	bool "Enable early EL2 switch by exiting Gunyah"
+	help
+	  Exit Gunyah hypervisor and switch to EL2 during early boot on
+	  Qualcomm Dragonwing family platforms. This must happen before EL
+	  register configuration in start.S so that U-Boot can run properly
+	  at EL2 to support hypervisors requiring EL2 privilege level.
+
 endchoice
 
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f44..c34627cf62c 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
+#include "gunyah_exit_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
new file mode 100644
index 00000000000..80b9f7effa5
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Early Gunyah Hypervisor Exit for Dragonwing Family Platforms
+ *
+ * Exit Gunyah hypervisor and switch to EL2 during early boot on Qualcomm
+ * Dragonwing family platforms. This must happen before EL register
+ * configuration in start.S so that U-Boot can run properly at EL2 to
+ * support hypervisors requiring EL2 privilege level.
+ */
+
+#include <asm/macro.h>
+#include <linux/arm-smccc.h>
+
+/* TrustZone SMC IDs for hypervisor configuration */
+#define TZ_EL2_SWITCH_SMC_ID			0x02000121
+#define TZ_EL2_SWITCH_PARAM_ID			0x00000023
+#define TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH	0x1
+
+	/* Only perform hypervisor switch if we're at EL1 */
+	switch_el x9, 3f, 2f, 1f
+
+	/* Save FDT address before we modify x0 */
+1:	mov	x9, x0
+
+	/* Switch to EL2 (exit Gunyah) */
+	ldr	w0, =TZ_EL2_SWITCH_SMC_ID
+	ldr	w1, =TZ_EL2_SWITCH_PARAM_ID
+	mov	w2, wzr
+	mov	w3, wzr
+	ldr	w4, =TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH
+	smc	#0
+
+	/* Restore FDT address */
+	mov	x0, x9
+2:
+3:	b	reset
-- 
2.34.1

