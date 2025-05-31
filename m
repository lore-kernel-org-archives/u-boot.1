Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BD6C5AD49
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DFC82AAF;
	Sat, 31 May 2025 05:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="acOmTd7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49DE82B7E; Sat, 31 May 2025 05:25:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A66682012
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V2YG2g019565
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JqOxNOfQDtjDaezTaL+5aKpkF93cQLtAUWVLRXVE2mY=; b=acOmTd7vaAm8yplk
 pOU/WYp0+5hjN5V0IpVnQI0qUUfiAmCykp2h3TZfsMf/H/Gy6YanoFAr4IprtL2J
 VoIWn5ZO60AKNrZi3GOgjfkCvHqgOeYROQ8GOV/6pI9ZbK/FNi7LIP+/V3Ft6IaR
 Ij2+/Xit4rE25cjKwPbzpXtYRoVsxiYpHmPrabbcEBM2ZhkvslYREo3G91ZHvhJQ
 y0SowH2RuAE6H209dK4/lDejCNnnSiAID+KAdB5tMs4B1ceg4B0BREYm8vaMNb85
 n2UFY1YVyrQarowE6uXH/RFuXW2dOVGpM6r/UbY0myEzjvdjaEL1aANqk0UpUCmI
 WcYmwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46ys3jg239-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:25:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23494a515e3so21535805ad.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661938; x=1749266738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JqOxNOfQDtjDaezTaL+5aKpkF93cQLtAUWVLRXVE2mY=;
 b=lakCCcqc9GaAsOOA0JcQMOkwk2X5q4Tv7+XGlR1DHAtpCQmgI4Y8mwZYpl74MyjP7l
 2GSu0v3uIjPCes+X6LvZZFb28bKkTYmQPXVEApSfpCds4DdWsXHucXvH6tlDPgHEx+jy
 BQ6ey4MeyhesbjBIEMKF5mcm3My0cwXVpLaSFA8HGIQgzRm6FUJHfQTQTGdfvTziQ+j/
 38SU1VZA83WPGs8DmNmLFfhdAzBzI0p1KSPKPnhMOgrLOI4jXdHl5vnqIyG2POw3F7CP
 Fr0bo9SMWEsVwgfzYwSxm+vBHoinhTfqJ8i60k/RJbvQtQIhj5UTofqLRTDGZQ01B3TX
 6vfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSWclX4Otj2739qXhgZ1SfJ4gpvZug6PkhI2Xcy9THn26N8SeYk95zOFjLsoFa2w6ldNi5Z+I=@lists.denx.de
X-Gm-Message-State: AOJu0YxlI5468safxuJBNHDaWm9z8jLOiX1HYuuaxUCrmW2vz0W6MQPW
 XP/2eTsPl6MizmmN24W6BIiQblQj0I+EpSsIAFdPRbVhUlQ+QvAlwjt7ouxyqp3DSYihbZ6GQaH
 Jp6N6/P7vEMi1PVA8hx9or6EiiFJ93CmIgC2qx7hdNQGjM9nCpblcz4Vu
X-Gm-Gg: ASbGncvox34JOS6XLoDhsHLj9JFjSVq4CDzQ3cGIWMwW0CuVeq+L7TQ6Ns29dw5kcUi
 Qv1vuXzuIuz14VJ020G6MKrahAMqg6A0rwYA3oUazioHWyMAho0etA5Q2HMo/YwcKkK+k3el03d
 kUbSiDK9Pu0W7zKDnhcGJC2lDrLHhiZtouGCx9Uob+30Rgldy/bQFaTxlxvAEuEFkLDYrNKLwmc
 axKjtX0gnYlyvlFWZOxqqeRabLtp81o1ZS/UA3CjSq18qFEzR6N75XXzew1RD4s29CPU5LA9YGb
 eYBsZENaCbw3IE4LkUP3sud+DSOKqj/Y1Z6XLtyeVnuC
X-Received: by 2002:a17:902:c407:b0:234:8ed6:2761 with SMTP id
 d9443c01a7336-23529a18005mr89195775ad.32.1748661937711; 
 Fri, 30 May 2025 20:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA3Hs/ljk4igNrXpRAVwqXLcvR/lPbYfLGMIJd65gv3OpaoXmm/Wn8RKDGQY0ME4vjzdRzbg==
X-Received: by 2002:a17:902:c407:b0:234:8ed6:2761 with SMTP id
 d9443c01a7336-23529a18005mr89195525ad.32.1748661937366; 
 Fri, 30 May 2025 20:25:37 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d2180dsm35017175ad.255.2025.05.30.20.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 20:25:36 -0700 (PDT)
Message-ID: <09f9ec31-63cd-47c2-9ecb-7f3d5fd40215@oss.qualcomm.com>
Date: Sat, 31 May 2025 08:55:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] doc: board/qualcomm: document iq9 building and
 flashing
To: Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, quic_varada@quicinc.com,
 avromanov@salutedevices.com, michael@amarulasolutions.com,
 sjg@chromium.org, hs@denx.de, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, venkatesh.abbarapu@amd.com,
 ansuelsmth@gmail.com, cniedermaier@dh-electronics.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
 <20250513091710.3719292-5-quic_varada@quicinc.com>
 <95052b49-dfdd-4a27-9c63-1f086d3bf23e@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <95052b49-dfdd-4a27-9c63-1f086d3bf23e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i7zJvmnsaDrXZBqamX97rmkdzvpU8LR6
X-Authority-Analysis: v=2.4 cv=X5pSKHTe c=1 sm=1 tr=0 ts=683a76b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oXciZSQBPm1k6E2TByk1nA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4f0wrZKBhHzd_4hDvzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: i7zJvmnsaDrXZBqamX97rmkdzvpU8LR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNyBTYWx0ZWRfXzxtYbYV80TC1
 aSK9MRC1Q6v5LUHdaLK+VWVcrBgVRGP2Ssr+D7wlVJ2coxEP5S7RoUb/HE1ge/N5ZX3mgIziQVb
 /VmBcHBB+LLkXyPq0TKK8LI9UqsxXrWJiwSihbkpNkg+OdmZaSlSe99TfcEzD/EP8uVUfLFKv33
 ukxAWWfOiTl+ILUEhdYE4iltrQSdAGX1siA+ZVqi/zLzcipOlmTAayq9mr1xjSqy+qJvwGe01F1
 XMCI6GZhTt+1hIIQUyvkimjeWfLVjb9UvTUHdEKg8XSBK4yzLb0mPahXqYFv00B7NhPh8qUifrx
 Tm8IH84bpXtL666o56LoMuNOXy2JOSsplIUDPsIOsRKxv7N767gKu8OPaNI8fhoURjRR4gsHlTP
 jHxqAzAGFiI5+obDNayJY6mJgQf51jA80JwkDlAgYfHiz3VarDt7U0gnfAZgAdELZN9r8HkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=735 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310027
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Casey,

  I missed that there is a seperate doc for IQ9. So, have created a 
seperate doc for IQ8 (instead of having a generic doc for Dragonwing) 
here: 
https://lore.kernel.org/u-boot/20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com/

On 5/30/2025 12:32 AM, Casey Connolly wrote:
> This is superseded by 
> https://lore.kernel.org/u-boot/20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com 
> I guess. 
