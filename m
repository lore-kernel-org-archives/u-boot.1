Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E02ECA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B941F812A4;
	Fri,  9 Oct 2026 12:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nH2O9yQmY3HI; Fri,  9 Oct 2026 12:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C59681255
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548884;
	b=P+6vZYws5XM/xGNuhyAQEaJXi99EmpvBpeJFO4r9YuuQsE66+nNbjv0AMRtZQtz1K5id
	 cPHjuPF2D6NvLgX5QqwB6ifJOxTvto4n4fYdYhf9FwbOVc2OFbJLus0/RQgyoIMGHcB5y
	 WHTY8gm7uqWwxGgJ4/KDoNV27aEgg8uuGRZYpwuCyXlnhxYvH1t/CVYlho1ztMEUeZwPz
	 ueaKdrP+p74nVmErtLhTXwvlpKb2Zlh0/xs+fMHXkJhgkwEsXRdt3GYiUNND8MqeVmquF
	 LOGjFNJEtMI/JzGQ7lKxnXPBypn16fsbsbTL7eogidmAucvyKy+dxhe7PRXqdz3U2gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JSe8ffzPSFJOisXHACSbxvsnyx8+L9TGyL269EitKvU=;
	b=Fd4JAHkuZMraqmU8aBOf9tKsXk0aZKmXfeTXEpbNNNJNZbqMO0SOzd5c/NA9T4kmy510
	 nV0IVB0ysK0N1NKhQeS2ugVHpY+Y2wCI8QkSoqCjZJC5aD9sWIzHTwyWtHKqlsS+7I7rL
	 PbEyi59B7RQ3EFL42L81c/K8cjoI98pMymuwFM2GyfnWeMhFv1t9oV9qRPfks2i9OvR2L
	 lr03AojTIkXMjmWlz2Syw66/qjodWq7IFwMFbBf0dzwgxIFmMc+CgMHOLrx24E6acUshd
	 JY+CANY9DOnWKQyCT0Yyjp+V/QhfBnkY/P6xcILxm9pMrh0jOPjLVvd7MLwuPjdSNgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548884;
	bh=JSe8ffzPSFJOisXHACSbxvsnyx8+L9TGyL269EitKvU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LcDGyUHTl/EhSCPLKkdqNpcqQD2UPLHYNqEObWebQyx0yU/3XJ1qBE0PdxcGEp6HP
	 g96t5zsIXXpS+kNFNgGgc7jMHaFUb5KlmsE4QPKQRmUtQs4WD7Kmo4PVv4pn4LbDRO
	 acm560Rn6FSJuhU35+Gn76v+5G0PBQ3TTgXRwqss6ckMKhEILiKvamXePxFBfkSJ/Q
	 YGRM2fyoyHQV0yZGnvdwxWqebPNomnj/tWfAx0moLxUAaCkwapAICs+IzAKnV+zpB8
	 OxYaM7gsA/VOMaE3ZaiBl6OcCBcZybb2bH+2uJREe9E4NbaEl2tjrfDB+1fAJ5bSQm
	 h2V8boQQGKWFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C59681255;
	Fri,  9 Oct 2026 12:28:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CE85422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EFCA40098
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djBlVnNPgJyo for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B37D040061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548882;
 b=mEQLvNy9UPjJOHg6RhQHhvML9xfuxdVNTv9ehYHngpoypYn8Tt3v6lDWdQeDHvoQsCuF
 SYFZtZ3e0ALLq1pR6GVzfwjS3mLACioybdqdf6Lm9oj0vl+8pJ502ang4lPGOWbYew990
 Li0BkWIYKZSf1FMCY0J6y5+IHm8S8F3iAfavHC0L0aGnHvIqn8sZEJDHlb0DE3lgrziH+
 IHYuGqjfqJ4NH48346Q9Cidt4E9fxdtGShHuFSh/KV1TVQphbctSwSOiLGlf+NCyfAONc
 EGH9G/77V7onzy2Gz471333lHMSSwkXUZc6WNe9+7xltHPbiImgmwCRTwg9byooyU+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548882;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JSe8ffzPSFJOisXHACSbxvsnyx8+L9TGyL269EitKvU=;
 b=D4G7qT6Uz8qEdBo7A1eLoe/ZZpuvN8SZLjLip66QNoQOkC7tJ7Up2Vh8bPWj6j/QwIkS
 7lBpWsh8p7OACmbfPSky5oTP2GqZNJxjgijr7hXuRk7MNYEE4MUf0JdZp4Rh3HnsLgZA4
 anrPsXdi6glHS0YF+Vub1ULGdnUYaTSIHrWieh4fhygDKeacD7xPMxEM0aUWUwOQuPKn8
 YBciy1aDEi3tZTZ9yGXS+INyoU4zy4SggKulkFqwUu7D+usmdI5BMI3njGxkdltnt+CHj
 5AVdEyR8+TcT7cmL/NjyLVCr8GgnsLM2+k/xPYkFLXCAYGuPVPMYtiILJywd3ddcSlg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NwXZRxd6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GfuGUG6a; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NwXZRxd6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GfuGUG6a
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B37D040061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KNnK1223216
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JSe8ffzPSFJ
 OisXHACSbxvsnyx8+L9TGyL269EitKvU=; b=NwXZRxd6p/G9SUJGSmPS9oFVRv/
 hce7jq3GI4W9TA/+FAIO/ZYjKA7CqWbNUVb4eo1hYYdftl796+nDiZ1JDfFymbvz
 +szjjRGImDBnfIKbGXPccMfOLH0nX6l4lf4f3rZnnVkTUzW23tkPT8AH4dKso2T0
 Tix9gle9dzKbRVBFqkMou7zkJNLSHBZBwKItl7NzLntPSOH+3jFPX6BGbGfaWMVM
 Q6SDtM/kAr/ThqHqPSTBa2xNJ5wrMPNewpAtJisaAVrf+igbSiuNPvLZxND+4mzq
 S44CSWanWJQjeNOlnGtkQW1p+A4fl1FwFbjx+xqCwLP+6A9l/Rwfa+sT9DA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkbe8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:27:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a813204f87so4757160a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791548878; x=1792153678;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JSe8ffzPSFJOisXHACSbxvsnyx8+L9TGyL269EitKvU=;
 b=GfuGUG6a0x6t+jiUHRdQcHF/y9u3BErCP9EWlQK3BCO8yBh9PwpJMEg5SU4qtBbK0s
 yIesvW9UE6gwlaitGUpxggsvznIgkdHuDPybg6xMivsF8Pg4qOpfngHGBiFA448izVUi
 I5/8Xd4Vgy6ErD0jcYfjJ93U7VCsNagJo0c+DtFdSIF6wbyhH8lERX9X79ImQCh7tKhH
 gt+unRxE6KsML3BylGRY99jkTXIVFLJZlL8cVJy3Uq8jxLn3gZ6XaQSds4pPNcj0Vz7G
 +bfursJQcW7lmCMSS8CqR8nwYUjs8AKj0DqA6Bq/YuVodsToR298r93AbwWghBvjMfSI
 wCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548878; x=1792153678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JSe8ffzPSFJOisXHACSbxvsnyx8+L9TGyL269EitKvU=;
 b=JiXpdx2ETbKQaAgkHM5nzLHWLKMX6TydP1QFsUD6FTnri5uIW+1lKBx1rIfFPUNb0T
 uW3ufYD//bCBCq6J//pFjvStdLKK3K41y48nK8ANsve3H9AXIsKL6rFb96f+JE9L27NC
 a80+ddshYoRj0P/mjF0VvkRx1x3+InzBmCAoRUHmJLMWP9K90chgH2pn0NXqXAZ6P5PB
 X6aTtd9cuhMWL3+QhgWxeLjIuQ7gIJum4tq5MmzQ0yKMCb/DPd9aOqKJkoxA2HaBenka
 W1WDWAftSr7HH1RGRYMlj9rn84qV+e4eJ++E9rvADluTGTjSVVk4FEFVV9LsjKTToZcJ
 HDMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUKJCDSEra69VNK5S8YVSN0/ftRpz4oOekTkJ7wUXUFo5xi+Quu8Gxc7EGH3tiK36BinmWH1o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOdkbMfddeo8vS/LFKQZzJ43m+hEYTk73d1vdH31HAzK+lj1cz
 uUkO84HcpcqqOcP2LHVRS4WmXO2skg59p5tlgaMxt9Zxv5PW32qzJECZJK7Mdki2YdmY2ykvUT1
 Y91dY73IpEDqEcq9OfNaVmHy+8bgZ9C8bPySw1lBFafSbx0Qllo2HPCPwu3JDC+nnDv12bMY=
X-Gm-Gg: AYBFou1VHfQ8kdKUepK6VryqTYnlPsoySsYI7kXkCSB2wps9Pof9en3F+MHHMgMGDTN
 hR59Yb3ue3eh7XPjSlr0cKPc5ieV8dfRWcr6pkdwVrufnWhURavKT/ZmhO0v3yfl8JogLhxLEeX
 sILFmxC4LRIzAZ48aC1WvYEQz6SnRtUrjhEnRDLAyoF9ve6VSnABk2XlcMJApURKsqKbcm7MKCF
 5PuIvZNu4jt4T0g9r0PW8pYeAgpa/2M8Tw00LfjoQ/zE3h+V9Vytf+QYfKFXT5IeKvEZrdpgFHQ
 TJ6pB1lsjkpZNv2OrHGZR3qjYVkAxABRWNY/uL2UatMlRYdQDKZm3A9QaSY/hXxzn6UDEa3aGrJ
 Y2olh/1ty2biP3mjydF1MnYybuR3CSH/O3LQWyttVVoyOtH1fkwIk40Omh5To9pThBBLaMlWmH9
 WHjcU/UZMcwahGVpoVvoY=
X-Received: by 2002:a17:90a:e70c:b0:3ab:311e:97bd with SMTP id
 98e67ed59e1d1-3ab3ac626a3mr1702870a91.49.1791548878049; 
 Fri, 09 Oct 2026 05:27:58 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:3ab:311e:97bd with SMTP id
 98e67ed59e1d1-3ab3ac626a3mr1702831a91.49.1791548877398; 
 Fri, 09 Oct 2026 05:27:57 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm3399497a91.15.2026.10.09.05.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:27:57 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, badhrinath.s@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 xerikasxx@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v7 2/4] pinctrl: qcom: Add ipq9650 pinctrl driver
Date: Fri,  9 Oct 2026 17:57:34 +0530
Message-Id: <20261009122736.1185878-3-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
References: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s1soPBWSp7uySnmpbNta1YVFqmHT2YuK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfXzEksTYknfpdM
 rKXBp929ZJcKyhqEjoHXms5iV6fwoDChOpl5b5aSw4lQ7lVxG1WgjXIW8nmArLA2rO6qGTF3xDM
 3Qh88K0G9a6UgwFtaWPRyOT+iW+v+no=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8ddcf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=sqB9GGOAUEJllpBDIggA:9 a=O8hF6Hzn-FEA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX5ifmxVBtlO3o
 2oBcJTKDdvH8ff4eOVe+Cio/U8rqlNIkgul0UR7t+Axio4wkU4wEN4XxYtlMxB7Jpw5EgpXchrL
 WUT7lbSmYb6h8dT06UbgVWMXcR3468wYi6NtRzRrvhZQMKekL5Ox7pGuMPT3mcKoDtJvJm1s6RG
 IhOJk+a6NMr2vPV7H3Lk1tK81xTKO3Td3kzkkzoTl63jtkW2ouhwRn0nBWRCoHrqCyvnvriBI5W
 X+KHf8e7Ho54KapeqBDMPsePTOxoUJaCOwV1zo0hXq4JEEr+efevX1aptcawGdmfOw+spN9GbRX
 cCimHWn3uPkKgEfuvqDwNHkcAlOJI0yMlcmM4q/yyxlBLe1bcNgDomlZNeG75X+rI6khy2w3zI8
 pB+1qQ/0klZ/ECIffQClSrJywUZuWWY2L18nH3z7+JE0ofT6lzFsHQs6EtTyAdcIcWCbQGaeuV7
 U5GZDDfek9iAnfou/Pw==
X-Proofpoint-ORIG-GUID: s1soPBWSp7uySnmpbNta1YVFqmHT2YuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090049
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

Add pinctrl driver for TLMM block found in the Qualcomm IPQ9650 SoC.

This driver supports 54 GPIO pins with various pin functions including
UART, SPI, I2C, SDCC, PCIe, and other peripherals.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c | 430 +++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14be..91406b51403d 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -54,6 +54,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ9650 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_MILOS
 	bool "Qualcomm Milos Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad035695..1855dc40aef4 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ9650) += pinctrl-ipq9650.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9650.c b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
new file mode 100644
index 000000000000..6496405ae32d
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq9650_functions {
+	msm_mux_gpio,
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri0,
+	msm_mux_audio_pri1,
+	msm_mux_audio_pri_d0,
+	msm_mux_audio_pri_d1,
+	msm_mux_audio_pri_fsync,
+	msm_mux_audio_pri_pclk,
+	msm_mux_audio_sec0,
+	msm_mux_audio_sec1,
+	msm_mux_audio_sec_d0,
+	msm_mux_audio_sec_d1,
+	msm_mux_audio_sec_fsync,
+	msm_mux_audio_sec_pclk,
+	msm_mux_core_voltage_0,
+	msm_mux_core_voltage_1,
+	msm_mux_core_voltage_2,
+	msm_mux_core_voltage_3,
+	msm_mux_core_voltage_4,
+	msm_mux_cri_rng0,
+	msm_mux_cri_rng1,
+	msm_mux_cri_rng2,
+	msm_mux_dbg_out_clk,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pcie2_clk_req_n,
+	msm_mux_pcie2_wake,
+	msm_mux_pcie3_clk_req_n,
+	msm_mux_pcie3_wake,
+	msm_mux_pcie4_clk_req_n,
+	msm_mux_pcie4_wake,
+	msm_mux_pll_bist_sync,
+	msm_mux_pll_test,
+	msm_mux_pwm_out00,
+	msm_mux_pwm_out01,
+	msm_mux_pwm_out02,
+	msm_mux_pwm_out10,
+	msm_mux_pwm_out11,
+	msm_mux_pwm_out12,
+	msm_mux_pwm_out20,
+	msm_mux_pwm_out21,
+	msm_mux_pwm_out22,
+	msm_mux_pwm_out30,
+	msm_mux_pwm_out31,
+	msm_mux_pwm_out32,
+	msm_mux_pwm_out40,
+	msm_mux_pwm_out41,
+	msm_mux_pwm_out42,
+	msm_mux_pwm_out50,
+	msm_mux_pwm_out51,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_qup_se0_l0,
+	msm_mux_qup_se0_l1,
+	msm_mux_qup_se0_l2,
+	msm_mux_qup_se0_l3,
+	msm_mux_qup_se0_l4,
+	msm_mux_qup_se0_l5,
+	msm_mux_qup_se1_l0,
+	msm_mux_qup_se1_l1,
+	msm_mux_qup_se1_l2,
+	msm_mux_qup_se1_l3,
+	msm_mux_qup_se1_l4,
+	msm_mux_qup_se1_l5,
+	msm_mux_qup_se2_l0,
+	msm_mux_qup_se2_l1,
+	msm_mux_qup_se2_l2,
+	msm_mux_qup_se2_l3,
+	msm_mux_qup_se3_l0,
+	msm_mux_qup_se3_l1,
+	msm_mux_qup_se3_l2,
+	msm_mux_qup_se3_l3,
+	msm_mux_qup_se4_l0,
+	msm_mux_qup_se4_l1,
+	msm_mux_qup_se4_l2,
+	msm_mux_qup_se4_l3,
+	msm_mux_qup_se4_l4,
+	msm_mux_qup_se4_l5,
+	msm_mux_qup_se5_l0,
+	msm_mux_qup_se5_l1,
+	msm_mux_qup_se5_l2,
+	msm_mux_qup_se5_l3,
+	msm_mux_qup_se5_l4,
+	msm_mux_qup_se5_l5,
+	msm_mux_qup_se6,
+	msm_mux_qup_se6_l0,
+	msm_mux_qup_se6_l1,
+	msm_mux_qup_se6_l2,
+	msm_mux_qup_se6_l3,
+	msm_mux_qup_se7_l0,
+	msm_mux_qup_se7_l1,
+	msm_mux_qup_se7_l2,
+	msm_mux_qup_se7_l3,
+	msm_mux_resout,
+	msm_mux_rx_los00,
+	msm_mux_rx_los01,
+	msm_mux_rx_los02,
+	msm_mux_rx_los10,
+	msm_mux_rx_los11,
+	msm_mux_rx_los20,
+	msm_mux_rx_los21,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux_tsn,
+
+	msm_mux_NA,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri0),
+	MSM_PIN_FUNCTION(audio_pri1),
+	MSM_PIN_FUNCTION(audio_pri_d0),
+	MSM_PIN_FUNCTION(audio_pri_d1),
+	MSM_PIN_FUNCTION(audio_pri_fsync),
+	MSM_PIN_FUNCTION(audio_pri_pclk),
+	MSM_PIN_FUNCTION(audio_sec0),
+	MSM_PIN_FUNCTION(audio_sec1),
+	MSM_PIN_FUNCTION(audio_sec_d0),
+	MSM_PIN_FUNCTION(audio_sec_d1),
+	MSM_PIN_FUNCTION(audio_sec_fsync),
+	MSM_PIN_FUNCTION(audio_sec_pclk),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(core_voltage_1),
+	MSM_PIN_FUNCTION(core_voltage_2),
+	MSM_PIN_FUNCTION(core_voltage_3),
+	MSM_PIN_FUNCTION(core_voltage_4),
+	MSM_PIN_FUNCTION(cri_rng0),
+	MSM_PIN_FUNCTION(cri_rng1),
+	MSM_PIN_FUNCTION(cri_rng2),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pcie2_clk_req_n),
+	MSM_PIN_FUNCTION(pcie2_wake),
+	MSM_PIN_FUNCTION(pcie3_clk_req_n),
+	MSM_PIN_FUNCTION(pcie3_wake),
+	MSM_PIN_FUNCTION(pcie4_clk_req_n),
+	MSM_PIN_FUNCTION(pcie4_wake),
+	MSM_PIN_FUNCTION(pll_bist_sync),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pwm_out00),
+	MSM_PIN_FUNCTION(pwm_out01),
+	MSM_PIN_FUNCTION(pwm_out02),
+	MSM_PIN_FUNCTION(pwm_out10),
+	MSM_PIN_FUNCTION(pwm_out11),
+	MSM_PIN_FUNCTION(pwm_out12),
+	MSM_PIN_FUNCTION(pwm_out20),
+	MSM_PIN_FUNCTION(pwm_out21),
+	MSM_PIN_FUNCTION(pwm_out22),
+	MSM_PIN_FUNCTION(pwm_out30),
+	MSM_PIN_FUNCTION(pwm_out31),
+	MSM_PIN_FUNCTION(pwm_out32),
+	MSM_PIN_FUNCTION(pwm_out40),
+	MSM_PIN_FUNCTION(pwm_out41),
+	MSM_PIN_FUNCTION(pwm_out42),
+	MSM_PIN_FUNCTION(pwm_out50),
+	MSM_PIN_FUNCTION(pwm_out51),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs),
+	MSM_PIN_FUNCTION(qup_se0_l0),
+	MSM_PIN_FUNCTION(qup_se0_l1),
+	MSM_PIN_FUNCTION(qup_se0_l2),
+	MSM_PIN_FUNCTION(qup_se0_l3),
+	MSM_PIN_FUNCTION(qup_se0_l4),
+	MSM_PIN_FUNCTION(qup_se0_l5),
+	MSM_PIN_FUNCTION(qup_se1_l0),
+	MSM_PIN_FUNCTION(qup_se1_l1),
+	MSM_PIN_FUNCTION(qup_se1_l2),
+	MSM_PIN_FUNCTION(qup_se1_l3),
+	MSM_PIN_FUNCTION(qup_se1_l4),
+	MSM_PIN_FUNCTION(qup_se1_l5),
+	MSM_PIN_FUNCTION(qup_se2_l0),
+	MSM_PIN_FUNCTION(qup_se2_l1),
+	MSM_PIN_FUNCTION(qup_se2_l2),
+	MSM_PIN_FUNCTION(qup_se2_l3),
+	MSM_PIN_FUNCTION(qup_se3_l0),
+	MSM_PIN_FUNCTION(qup_se3_l1),
+	MSM_PIN_FUNCTION(qup_se3_l2),
+	MSM_PIN_FUNCTION(qup_se3_l3),
+	MSM_PIN_FUNCTION(qup_se4_l0),
+	MSM_PIN_FUNCTION(qup_se4_l1),
+	MSM_PIN_FUNCTION(qup_se4_l2),
+	MSM_PIN_FUNCTION(qup_se4_l3),
+	MSM_PIN_FUNCTION(qup_se4_l4),
+	MSM_PIN_FUNCTION(qup_se4_l5),
+	MSM_PIN_FUNCTION(qup_se5_l0),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(qup_se5_l2),
+	MSM_PIN_FUNCTION(qup_se5_l3),
+	MSM_PIN_FUNCTION(qup_se5_l4),
+	MSM_PIN_FUNCTION(qup_se5_l5),
+	MSM_PIN_FUNCTION(qup_se6),
+	MSM_PIN_FUNCTION(qup_se6_l0),
+	MSM_PIN_FUNCTION(qup_se6_l1),
+	MSM_PIN_FUNCTION(qup_se6_l2),
+	MSM_PIN_FUNCTION(qup_se6_l3),
+	MSM_PIN_FUNCTION(qup_se7_l0),
+	MSM_PIN_FUNCTION(qup_se7_l1),
+	MSM_PIN_FUNCTION(qup_se7_l2),
+	MSM_PIN_FUNCTION(qup_se7_l3),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los00),
+	MSM_PIN_FUNCTION(rx_los01),
+	MSM_PIN_FUNCTION(rx_los02),
+	MSM_PIN_FUNCTION(rx_los10),
+	MSM_PIN_FUNCTION(rx_los11),
+	MSM_PIN_FUNCTION(rx_los20),
+	MSM_PIN_FUNCTION(rx_los21),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+	MSM_PIN_FUNCTION(tsn),
+
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq9650_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(1, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(2, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(3, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, sdc_cmd, qspi_cs, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, sdc_clk, qspi_clk, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(6, qup_se0_l2, pwm_out51, NA, cri_rng0, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(7, qup_se0_l3, pwm_out41, NA, cri_rng1, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(8, qup_se0_l0, pwm_out31, NA, cri_rng2, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(9, qup_se0_l1, pwm_out21, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(10, qup_se1_l1, pwm_out11, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(11, qup_se1_l0, pwm_out01, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(12, qup_se1_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(13, qup_se1_l2, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(14, qup_se4_l1, mdc_slv1, tsens_max, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(15, qup_se4_l0, mdio_slv1, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(16, core_voltage_0, qup_se3_l1, pwm_out02, NA, NA, NA, NA, NA, NA),
+	PINGROUP(17, core_voltage_1, qup_se3_l0, pwm_out12, NA, NA, NA, NA, NA, NA),
+	PINGROUP(18, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(19, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, mdc_slv0, qup_se3_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(21, mdio_slv0, qup_se3_l2, atest_char_start, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(22, mdc_mst, atest_char_status2, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(23, mdio_mst, atest_char_status3, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(24, pcie0_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(25, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(26, pcie0_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, pcie1_clk_req_n, qup_se2_l3, qup_se1_l4,
+		 NA, qdss_cti_trig_out_a1, NA, NA, NA, NA),
+	PINGROUP(28, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, pcie1_wake, qup_se2_l2, qup_se1_l5, NA, qdss_cti_trig_in_a1, NA, NA, NA, NA),
+	PINGROUP(30, pcie4_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, pcie4_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(33, core_voltage_2, qup_se2_l1, gcc_plltest_bypassnl,
+		 pwm_out22, atest_char_status0, NA, NA, NA, NA),
+	PINGROUP(34, core_voltage_3, qup_se2_l0, gcc_tlmm, pwm_out32, NA, NA, NA, NA, NA),
+	PINGROUP(35, core_voltage_4, gcc_plltest_resetn, pwm_out42,
+		 atest_char_status1, NA, NA, NA, NA, NA),
+	PINGROUP(36, audio_pri_d0, qup_se7_l2, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(37, audio_pri_d1, qup_se7_l3, audio_sec0,
+		 audio_sec0, rx_los21, qdss_tracedata_a, NA, NA, NA),
+	PINGROUP(38, audio_pri_fsync, qup_se7_l0, rx_los11, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(39, audio_pri_pclk, qup_se7_l1, audio_sec1,
+		 audio_sec1, pll_test, rx_los01, NA, qdss_tracedata_a, NA),
+	PINGROUP(40, pcie3_clk_req_n, qup_se5_l4, qup_se4_l4,
+		 NA, qdss_cti_trig_out_b0, NA, NA, NA, NA),
+	PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(42, pcie3_wake, qup_se5_l5, qup_se4_l5,
+		 NA, qdss_cti_trig_in_b0, NA, NA, NA, NA),
+	PINGROUP(43, qup_se4_l3, qup_se6, pwm_out50, NA, qdss_cti_trig_in_b1, NA, NA, NA, NA),
+	PINGROUP(44, qup_se4_l2, qup_se6, pwm_out40, NA, qdss_cti_trig_out_b1, NA, NA, NA, NA),
+	PINGROUP(45, qup_se5_l2, rx_los20, audio_sec_fsync,
+		 pwm_out30, NA, qdss_traceclk_a, NA, NA, NA),
+	PINGROUP(46, qup_se5_l3, rx_los10, audio_sec_pclk,
+		 mdio_slv, pwm_out20, dbg_out_clk, qdss_tracectl_a, NA, NA),
+	PINGROUP(47, qup_se5_l0, rx_los00, audio_sec_d1,
+		 mdio_slv, pll_bist_sync, pwm_out10, NA, NA, NA),
+	PINGROUP(48, qup_se5_l1, audio_sec_d0, pwm_out00, NA, NA, NA, NA, NA, NA),
+	PINGROUP(49, resout, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, tsn, rx_los02, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(51, pcie2_clk_req_n, qup_se6_l0, qup_se0_l4,
+		 audio_pri1, audio_pri1, qdss_cti_trig_out_a0, NA, NA, NA),
+	PINGROUP(52, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(53, pcie2_wake, qup_se6_l1, qup_se0_l5,
+		 audio_pri0, audio_pri0, qdss_cti_trig_in_a0, NA, atest_tic_en, NA),
+};
+
+static const char *ipq9650_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq9650_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq9650_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq9650_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	debug("Can't find requested function for pin:selector %u:%u\n",
+	      pin, selector);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq9650_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq9650_get_function_name,
+	.get_function_mux = ipq9650_get_function_mux,
+	.get_pin_name = ipq9650_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq9650-tlmm", .data = (ulong)&ipq9650_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq9650) = {
+	.name		= "pinctrl_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

