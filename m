Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FEC7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 12:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE61F82977;
	Wed, 25 Jun 2025 14:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWJUHSmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5939582CBC; Wed, 25 Jun 2025 13:16:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5002A803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gopinath.sekar@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P4mSfD014580
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 11:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwUV6cqQw2EnuMRXePfqgg9vjVZ3baZZttDmUi+Vh48=; b=iWJUHSmE0JbbRLfO
 /cvgZXvZPe908ccy6GwWx10NgiPoRggshGQshMzl2Hd2DBWsV58Ak+ldp9JvZeaH
 jUHajjifym02C0e5w485fpBDw6DrKgFCebFE58KXbdRHYgI+MV4puhLUUmZ5ts8r
 jzde4bJVR00kBt32Wh063tgnhjiLLwb8uin7qRNg1TL7CIdxIPzHSoXL94H//bg4
 DZH5vnVa/G0GmWpMdneYLMOhbC2sxrxEe8w9pwacMYAQc4Au+efDXxeWoDffFG+r
 I6V7e2+oDuibNFNFA6yIaTlC8hHn88WlhF7NRnZCZkSqz5VKbf1QIisuvAXVxGA7
 ychfpQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5rqd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 11:16:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-74951713860so244068b3a.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750850202; x=1751455002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DwUV6cqQw2EnuMRXePfqgg9vjVZ3baZZttDmUi+Vh48=;
 b=EXpeeTpeX3+V84gh60Ze7qEkaspnzsEZB8GdQqGAGPmOoMGIgcuUiMjwEcXYbtEokv
 N5u0ksW+jrqW0dIXdEU6obEKDXhMc2ambER93QCYYm1qZ6qlvdHbLcA0igZLNRR5KWRJ
 Sxa3rBGLMlXIpf3p1b/TH88BLtNPfNj3QDs1hDrq/LFr5987k5C9aJ6+NTfZem93ol2K
 cQUUaE0wDgiY99Fbe4rSB+S4g1mk9tv8eZ9U1Jqz0fvnneQ2yZxYZjrKkhmYkiVsn4i/
 RNVDUBT8O0h3ToCqn59rUNdLLfxGgisk1zuuWpWn/eHMtixzNdkaRRc1iwd1f+M5SqjU
 CuVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdzclzBoWNuUpEeCkOFsX22ZzhuaWaGWFb2y5mYzt5kE8ZH3JfcHh9L9KLJf+kDDYqVHtNeRc=@lists.denx.de
X-Gm-Message-State: AOJu0YwVUOOLFDLh9p2XrV6+b01id4kb8FugaYZj9LVbavsNQb4MetBW
 phBR2gEougxSpzHqvjt/z0I4tRk1HyCdxMaxRORThGvDVtqdobDVNrF5dHysm56grZBaGY6gWvy
 ODUC7uUDp1Y7dzBnNVEuMZw+TfNgyg4GXVcfxZo/1aTYFcyFU7hQHer3U
X-Gm-Gg: ASbGncs3J4eky9O3JsILM916WKu/PTO5j/Ep/9aKYVvpOBLffe9plrwt2W3nonSdpgB
 bqHylWP6mz8s82801gRFA0qppukgTti0VxKhX1/FeOWPxSOw/El/4f7cQPwmCzUJfMdqB38uRAv
 togLsVMLefRPtdZibc6vvvb3WsreiCVifWuhPvI8YjzTxM5qM1ErBnIvQtODDdq1QhCu5/1FIT5
 qvbusBGK6KssETqmelRKPnYFL4DDhCV0bbHU35qp0UdM7TOH5+JI+6gmq/cifMHBEcdQiOxgVCH
 gcdW+8Hm+aum71bNkZ2IDnB7jmivlf3hX+4vz3QF4Xl4KWfATBXw3tc=
X-Received: by 2002:a05:6a21:9991:b0:1ee:e99a:469f with SMTP id
 adf61e73a8af0-2207f29eb07mr1903238637.9.1750850201640; 
 Wed, 25 Jun 2025 04:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmMoL0zZeWqBkfZApjmvqSHho6N3ye9tFY+eIpiqRiuAJ8KRz0Am4/sUJr6Tg1BiA24IPa0Q==
X-Received: by 2002:a05:6a21:9991:b0:1ee:e99a:469f with SMTP id
 adf61e73a8af0-2207f29eb07mr1903213637.9.1750850201183; 
 Wed, 25 Jun 2025 04:16:41 -0700 (PDT)
Received: from [10.151.41.215] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f126b62asm10395557a12.72.2025.06.25.04.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 04:16:40 -0700 (PDT)
Message-ID: <67b1013c-4f75-448d-849d-225949e134c6@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 16:46:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] watchdog: qcom: Add max timeout check to prevent
 overflow
To: Stefan Roese <sr@denx.de>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 hello@paulsajna.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com>
 <822ba813-2a9e-4a40-821d-ed72c10a78b2@denx.de>
Content-Language: en-US
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
In-Reply-To: <822ba813-2a9e-4a40-821d-ed72c10a78b2@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iiBPVZM9_CQxg6nkzMp3cHvGxFpazBYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NCBTYWx0ZWRfX5kpqP8+XHv2Z
 IqlLPOQzEv9BoNE7DzXoNxVzs8LEz1mlh9DaNrwOcExfdkiRJ0/2zLvZu+MVbBU6oeIVXiMYqoc
 X4F8aP+e9qgQGGjv2C86UPhc+G9/9PgxyWjNrws8FIUcnUd9w4LO3GyZC/vlBNl6q2qhdva363q
 I2G5CHHPu7pZpgR5gRbEwPwdwhtkXCIQ1bXu4YzQn8a4fkEJJSjp3udNC5K/KG1AfupH1g+ANhs
 pGqLv7GxxxpI9YX7glePZQqwhJj/wCkQQdVVhMsuyU4YimZmJo2rp3V8pr8vYIcQGIvhux2aAst
 bxsiv5gZxqnDKEABPC8EYdP4PHypxmpQpC698/EA2HsOT3CaYjg+xpwiOdTSNhkmQBO4tpU8/S8
 n4zzHqFcnDmC2UHOzWQ85uDcQScj8C682hYKKmEurv5THElzdrv47OzSzEJnXsCY7DKCk0i7
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685bda9a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ugF0j0f3TclqYSwlPgIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: iiBPVZM9_CQxg6nkzMp3cHvGxFpazBYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=991 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250084
X-Mailman-Approved-At: Wed, 25 Jun 2025 14:54:31 +0200
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

I have incorporated this change in 
https://lore.kernel.org/u-boot/20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com/

Thanks,

Gopinath S

On 6/24/2025 1:52 PM, Stefan Roese wrote:
> Not sure, but wouldn't it be better to use this max timeout value in
> this case instead of returning with error? Best with a changed dev_err
> or dev_warn explaining this changed behavior. 
