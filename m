Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CA7C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1411360B83;
	Thu, 17 Sep 2026 17:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBBTWul9A4Bk; Thu, 17 Sep 2026 17:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 633C060B2D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789664493;
	b=kKL3diUSgJ65a3ZwgRl+TCmnhOOzG4k1mpariHFgwFxbgO9nKeN2meFBABLlbAThh41d
	 rrxkVhhDZcBBrDqSuhuEQaxyvf6v332Pt63s7/WjyU6uSqBFQxuQTV5iKhny5RaoZyd7Z
	 LiOsF3xzHqf85tzjhq2tYevUPN/5HDarxb6FxK+Zo+uoIOwqx2YAEn9TPVBTbTq1yUmL0
	 taR28aMxbH2/OEMyIhP8D3AjanP9oE3WKexzqsZemC1s07ZvPpucPvPmqiR2VjTmSnr1h
	 ZJIADKyC02XKOIauptbhazxkj3TeMBB1eLkjOU0901AbsQAyLQQTvEp+JE0FrlHLRag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789664493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=;
	b=ri2ZZafzxO99tsowNC/mGv6ELWz6kvl1JYa0/pw9ytArIshS8epYhus/s4sU0vLQYYh7
	 9rygTW/Aig72yeU9qujIWwFOIsRb5x5gLeOoCqGC/jB6sXZtkFOdXpH+AoN216vgszbZe
	 d5iodqhxrI1ZpbMPluLnyZHpL2hwyVJsraS5kV1uhtQ+ImkCpTuhP5XqFxEkDhh8hrKGr
	 stWFQhK4XWo8ZMmjIb6YlHrA8TlSbrED+/PN0T5FvkQbFACG0IXZu730NvuMRgXTpQgUw
	 E0vljdJr/wZpa0nBAjal9VaTGFmMJFwY0/U4pqoFgv8UGyjwoHMFOyIs+OhsE4p+a4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789664493;
	bh=GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJVpobgU9dOQoJHSIYf1uFJbWb0GJTC7arez8e6HVn4M8fB5NjVsUxBAaDVCUyjGJ
	 R1Hv693VkNE/xLcQzeG/LxIViTKw1m1kVOdVls3H48y5FVXhYDDPv5KaajMzNmOjw4
	 DS2FvG8xUBSqEfj1u2DfyVJIZsjOsutHC6Tc3Y1ldZUJNAD8UaYRXnZatvpQL37Kmb
	 kAq1XG8dBSyTE4tVenVl5LKu4S4HZ+jzxzxZ5iMUnAVqO+p1BNyzVzqhjZOrHNhE4O
	 Vp0MmOBHjW/BG2jQznnXEi/pJ9GKKNMF8vxpMPLkQooOVGxm4Nhuy1pg/YYq5OUIDZ
	 bD2w7s+hmHuwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 633C060B2D;
	Thu, 17 Sep 2026 17:01:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 934F3422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7923A40857
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsZiPPSYPXMs for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A1DF4081A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789664491;
 b=BWZ7CfHneslNnOu5jpU/2m9GLRn6q/yo5I2m4Zo7NpfJk1uK8ynEDk8GweVO3DQkFwya
 V7YJZ0NreR0ODLIwzkpG99x7W2FMkYaFC5Xy2adbD59qIGShIC8ejM6LSI2QLAl+OdHit
 xAn7YNXQ3HinJvlcNbjWlHD74lSrNjh6QrasXOkyRIvJD+E6x+iLWPgTMnX0J2cqJ58Ug
 EhSRITb5ZYrFlBO8Hggq5Wy/py9Y6mz91JZ1EJzaTf3E8RGtCapdlXN381KRKCLRkR5zN
 DAyso/T57jYzMvzkGlxeVgB52k5xzUETbHS8Prq5QE2y7hEFwcp1jnNK7Ggr/xPktMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789664491;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=;
 b=Y/1S91TrkHKfv0VJpOGx4FicCQol8P3sDgFvBwNzT8iYk64c8GZ51thWvVqd1KMVS3WX
 OYaVZJO8SA6XNj+kZ7MBb++IDlj2yYZP7bEat7sPq8JE1rekihj9nzCuqu0HEod1s1F9b
 15siyobmdi+V7YfU7rigVA9yzI64gNjO/k1aggXnm7CEPq5xo3iD26kLnlQI5D0gOH2Pc
 CqBarE33kkEnFENduz3FtTzBgKvZ4TWPFbAW7TdokkVgm7uq59JkdnISbkOxDguCseFaz
 xX5NMFyFnfTuN0y8GRVMvTrW0ZHiI6JaZGbDkgnrehNmDQwcfNGkL6FTXoL9/lkPqaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HZvlGNqo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S6fzDn9v; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HZvlGNqo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S6fzDn9v
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A1DF4081A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDiUCX2974879
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=; b=HZvlGNqo+Z5j2L0N
 3M5fK6WA03kJhfU0rNNVD9BksHhXI3i5r3YzNa0vLudjpHcETada9anJyakTGEdE
 7FHq8Yj406Wyz3uxyHxTRWwghRE/XXtUJf6ZKTMJTYUmgX+Hp2W8PrYI1hiDOQ3U
 yyCf52uSOZjF5N/1MKItEfBeo1PaU7STphFaxZx+o3/3/FcGl1GGNJUFlyBeeZzl
 OiQqTymh0LyUbuVngT20ZceGf1IUZ8D7VUF4+BLKoPsamoGlr65vkgiNMeF717p3
 xTAyaOMHO6sYPh2oN+TAcN7j1K1Sy2cq+Xu/bTcXF5lPqnkYvgiiKarBnw/vavTz
 KfUJjA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grdd6j4se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db8c152622so12172285ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664490; x=1790269290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=;
 b=S6fzDn9vIxxExKlYAKFEBfh7xMVpsdkxsl+HS9ru0BlKMfEQQnQDrwmISSD6ghWW7K
 w0vt6UP5G6jVMmgBttZr2Y9EqpGrtE8XfYChh80HArzmX7QKJJU7GGMUdfejqU5g8z+R
 vX+9y63HPCDYTHz8T7T7/kKNte8RlbPTwOoSkNWpBXMuVFp2BGc6NVAQu78ZdZN1TnaS
 5wAkjKrhCGz2PIUuEE1LTkAZTziwnoKqpbN5krcCpuL8jUfu/0ydoWMz2zhHkrZwvWZp
 T2fGyeVAFok1R65NU55TVNYKzSny7sYuLaskV3mFWGdR5Iv8ZWA/uYKeP1VqgQWG6Beh
 nSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664490; x=1790269290;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GRmeOZA5PcjF1z37u22J+PUjGozOiPIvXuctTqWkYZg=;
 b=ayOMcro0Dh5bt7c+VU6uVpl+WqUiaiiojoa9d4d40CmXSISX05wqUL2mlHXb074DGw
 UKabAH7X3Co+SReSKfThShmYYdeO6gb2/ukqvTS9yVhGlHa0nKXRfPJ41T9tLjXzsLXN
 XrspCorHjPSp7/oDZNNF+8P9MEL6zM1lUy4lbmB3kQ+zmlitxpdkdta82UtuCN3+1Q55
 bVZzd2NgN3ZV3zpl9vxN4Xm7skUtjj5P/bM1u8LISvfhc9xuhm9/V5oEpRn532T7hhTL
 bwVSXX5a62mXZbM8M/8PDt0HymIBYRUbMYJQokRWbQAJw5xkQuDR2ZlFpnkWI+M+B/95
 R9BA==
X-Gm-Message-State: AFuF++kzqwGtoOYKU7k6rNBX9IFhPUUqr/SeTPeEr1YQggZk1CaJAxEg
 salXEkjPuid3xYQjQRABMAiNkP4E9sYW16m8qeaJej+3VeN1FJL3KGctUUF66PHeZonLnwmcXqP
 IfnyT6O65gaA7vj5snRzRJuoR3rS/jJ8MChqDoDHYzuticpRAfNkhJmWuGpCh8pSU9bJMDYdm6u
 WP6mY=
X-Gm-Gg: AYBFou2tm/7RqdROpJTDevezgcAB7DMpAX2t24Di1wWW5mfTdfwXf03+sBL9DVIQ/+u
 a3vu/R+AFuu7zVf5cJ8ms9bgBU11vzni8nqrNreQoEfRWh4Vr6jamlGBS168ECZi22XG6FMf5et
 RCsOAmRri5NHOY4vgKh3DAgiH1oLkiVt1tNkMXON1a5echaVW99dwpGmP6Heb4gtMj4CNL9xqUU
 8MUf4MahYmg7/KOODjV+mPIPKWzU3kFt1aVN7+3ft7rC1xHztCAg2uRvwZYQpWh0ET5xelMQByp
 Payn78EL2T2q3dhVmc54ACw0rfERUFpaXe6Cn6q5sF8D5ZIlo0+84hFtYOnh36MCLLVcexbKeVb
 Mfxbzue2d9TndtmyKYCFojAWAYHsJO50eCM4BZUZomvzem3/m
X-Received: by 2002:a17:902:8308:b0:2dd:ad74:ac34 with SMTP id
 d9443c01a7336-2ddad74add6mr11754685ad.29.1789664489436; 
 Thu, 17 Sep 2026 10:01:29 -0700 (PDT)
X-Received: by 2002:a17:902:8308:b0:2dd:ad74:ac34 with SMTP id
 d9443c01a7336-2ddad74add6mr11754285ad.29.1789664488826; 
 Thu, 17 Sep 2026 10:01:28 -0700 (PDT)
Received: from [192.168.1.2] ([106.219.183.89])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a182sm17753685eec.8.2026.09.17.10.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 10:01:28 -0700 (PDT)
Message-ID: <4c172538-8ac5-419e-98c6-aeaeafa13aea@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 22:31:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
 <aquwqGzPns7S28eG@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
In-Reply-To: <aquwqGzPns7S28eG@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WfjI_59GXbpawa-4KzLHr8AynIftg8GU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX7F++PvjC3U/Z
 IdjGkiL0LmqnTkMkfg3c9DfRtcAe0smQLVb5cd9cE97owMdDNl/FCufN8cKHf8etoZ5hD+lFIFE
 XXMCTSUJ0+97BDXJamH8AanxCtm81kKhaQBjLltD7QN1yxAShQa3sEI5+iHvjIkkN7S5qrnuPg0
 pya1vBqEF6rcraLygGn8eDrJ0MfIbHdFph9cUD5tPVSCGar5CDSCYfqy3+9agMSoX8gxRnK4cKS
 tB/nndi/i5afDmrnKODQEYgSzt2/OdGpKAzzAXY3C9md1LRtzTofngcXjVh+CzNYgwiZujFMiaP
 UGwxzfAPvTrfKl7WFAKX/ClYB5zlfBQptCbkLZQiBSaouYq5fnBkCTllbyjjSM5dRG5JsogciWF
 rlsngrm/eKacBcv9HmNeSJhHBJcYKcewV84ag3/tmEJUZHWfYjtnznTfTqA+6u5Gwn7XVtjSUGN
 uvlCPTQdeW2osm6JDsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX7OBwF+73wEgS
 2lI3hj+lUw5+WSGAm3nkPiP077T8vfFPXFoTsqV3z/fUoMMWHTk8EpQpeNhVMfov/iRHXK4sgmn
 sIdPdS/wi92ScVligGK5cZu11eg9CcQ=
X-Authority-Analysis: v=2.4 cv=GeOCDgXL c=1 sm=1 tr=0 ts=6aac1cea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=0Aw5K/wcCdqPyoy4oKtDDg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=08hMLmvfN_2J64nZNxYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: WfjI_59GXbpawa-4KzLHr8AynIftg8GU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170242
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

Hi Varada,

On 9/17/2026 2:49 PM, Varadarajan Narayanan wrote:
> [...]
>
>> +static const char *fb_block_interface(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> +		return NULL;
>> +
>> +	if (block_interface_override[0])
>> +		return block_interface_override;
>> +
>> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
> If CONFIG_FASTBOOT_FLASH_BLOCK was not enabled, the code wouldn't have
> reached here. The first if check would have caught it. So a plain return
> CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME would suffice.
I've removed the redundant IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
guards as suggested.

However, I kept config_opt_enabled() in the return path. While the
helpers are only called from CONFIG_FASTBOOT_FLASH_BLOCK-gated call
sites, fb_block.c is also built when CONFIG_FASTBOOT_FLASH_MMC is
enabled:

obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o

In an MMC-only build,
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME and
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID are not defined, so replacing
config_opt_enabled() with a direct return of those symbols causes a
compile failure.

config_opt_enabled() keeps the code compile-safe in that configuration,
while the redundant runtime guard can still be removed.
>> +}
>> +
>> +/**
>> + * fb_block_device() - Resolve the block device number to use
>> + *
>> + * Returns the runtime override set via fastboot_block_set_target() if one
>> + * is active, otherwise falls back to the build-time config default.
>> + */
>> +static int fb_block_device(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> +		return -1;
>> +
>> +	if (block_device_override >= 0)
>> +		return block_device_override;
>> +
>> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>> +}
> Same as above.
>
> [...]
>
>> +static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *response)
>> +{
>> +	char interface[16] = { 0 };
>> +	int device = -1;
>> +	char *space;
>> +
>> +	if (!cmd_parameter) {
>> +		fastboot_fail("Expected command parameter", response);
>> +		return;
>> +	}
>> +
>> +	space = strchr(cmd_parameter, ' ');
>> +	if (space) {
>> +		size_t len = space - cmd_parameter;
>> +
>> +		if (len >= sizeof(interface)) {
>> +			fastboot_fail("interface name too long", response);
>> +			return;
>> +		}
>> +		memcpy(interface, cmd_parameter, len);
>> +		interface[len] = '\0';
>> +		device = simple_strtoul(space + 1, NULL, 10);
> simple_strtol since device is int?

Use simple_strtol() instead of simple_strtoul() when parsing the device ID.

Reject malformed and negative device IDs


Thanks,

Vandhiadevan

>
> Thanks
> Varada
>
> [...]
