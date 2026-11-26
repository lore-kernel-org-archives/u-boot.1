Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C0606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ctPFqO4V;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZ0JjGVu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CWZuWLM5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 052D24088E;
	Thu, 26 Nov 2026 12:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KbwxuLQ2tQWq; Thu, 26 Nov 2026 12:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30C0340898
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695104;
	b=cHY9BFGxRep9s9HVDkAI9J4E1Sj5/wj93f4iZUM7p0VeCxgICDr8Tw5Jir65aRJHU7/M
	 er2CIxUiT8dW4HMlYTidkwE9uKPEnDqtHjaSxQgBsZnZeQimsqJvmFP8sRLtr2lluV/Qn
	 hb7ibjvTiYAT1UxOk3xl2s9m8i//QvtonywyuQDhbrJXtF829LqJHOG7ZNkt2zBri7oK9
	 CpL0X6kjfqLglLzwqPfoB/5Kkeix3XwO7vg8B8exgsJXkVLEg4aadGxlB4P45QJwFo4mv
	 +SYkdoXmd4XKJ3cOypKDzNwqX8brtFeFcg9FnUhuEbj2IRiU/SuNCMJv04JgOHshznQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nRHhhOCSTJg8ksCT9aukYAIbaaosmP32JvG1zvskMI4=;
	b=aDMkhEMiBaDPT9nIiOcaRPd/WlZgIqSU26SaH2rKZHxUqY+oQ/EszmzAYFyoTeFy7LUb
	 Uwt3u22eCQ2xhBxspBPjeOTLAiyIBVpN0Y7sADAoIXZkjQD0STrEf6MXOdrJR0zStv+9u
	 Id18zXQsHzvn3qbNmfoKI6vGxSEqfBXTwF/3KH5qSy1M/QBPzv6BhZIvhOa36O2yFhbUD
	 lrxpKAXOeS4x4AN82vf9r93Xoq1fMFhRNIeklGsSM0h7YhITT1UP2tFCHGkkbbu02QOgI
	 /jsYYTTueG0vDa+8VvjlOA7IA7VhLfQlzSwmudO0jmaVG+WMDuuQAG1TWVXROaDRUDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695104;
	bh=nRHhhOCSTJg8ksCT9aukYAIbaaosmP32JvG1zvskMI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ctPFqO4V0OukMMPC2NXglEqAUnXIrxbf4vCHageSLJbHkba9db+WYvKyQsSByN8Hs
	 hM+SUzg3PpzUVCXl4CN5HObWMORGdsGu0vG4hwkN7an3U3oZILtpykfLLfQO7IbmYC
	 g1sWAu+Qqn/3mQyEq3aTcnGMSd4V98uPh9LCMUMMIFSUL671OZrTmNA2iiySr8iQZl
	 cAM22NcKLIqXRSwIZMNbsFILD7Y7gBKbseI+XK+qByh5DPO4JD7O3MbVmGStbYKnQe
	 Mk8sgpQx8HxQqTs/DCc7e+u1ihfaniwXLiY3MICHELANbvD31crBzKYaAm3EVB7buQ
	 CFqOL/GotoH8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30C0340898;
	Thu, 26 Nov 2026 12:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B61E1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31980608E8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4tRUlnHaWgU for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51783608E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nZ0JjGVu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CWZuWLM5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51783608E6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:11:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVNit4128433
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nRHhhOCSTJg8ksCT9aukYAIbaaosmP32JvG1zvskMI4=; b=nZ0JjGVu/cErYhWz
 prYUW/8y+7Ybd2VkRUVfMyDm8GaB5snadAnvARF0c8JuTcf/mNkDUUVhfXgfqeVN
 REFt75dlJFgRQchwrrtyRcGCsbv7K174pGuMsRLtzUvXySkHOuvmvdbWTv24NTJ5
 4kc2h3lKKNBWUnzq+7Ucc9ChQsGnKcyeI+7cWgUj0MkviVo48Koh98/Bn65xO2gS
 9pNknBpKYXyg2l9ego6U2pk6IQZEZkSs5wNomWaTT0kBuYuFD8XYgnO+o38Hr6Wz
 H7FFmFfMgZVVIg8kfc+5i0A5Y+Lp8EYX6U34GnHZ3lQiLJBgtQVuSB5+zHp1Mr9I
 Ilwufg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vauuvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:11:38 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-677c4ca2265so10983877d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 04:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795695098; x=1796299898;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nRHhhOCSTJg8ksCT9aukYAIbaaosmP32JvG1zvskMI4=;
 b=CWZuWLM5uh7mfQYlmCzxDO4lbzlskG30jEBvL8C2a9rJ51RT/UqvuFlEa22paky/L3
 Ux6GYvrVWjmHnjOpCuD1t+vwy8NvF3ngp7OBqKax7zM+xxIwKySYRqdX+DCUDP9Gpd8w
 2XeB8I5nLW2u6t4bczXWKlBk0s3OUUHmGsSiPicA3ZUHgBlb/KPgQv4otqb4mTZra2AP
 s65h8TWl3WmNwb4YDgF5/lZ+u76rlnGFlsVmOpu93wYgW24ORmTjoEdElhODJ7BOgytX
 Q8SiPlPfcwC57Ev7cBorsQdYtsAKanoP2Yg7XvypLulwnq1l6Y9hl4kYsFboiQIZRJxs
 anAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695098; x=1796299898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nRHhhOCSTJg8ksCT9aukYAIbaaosmP32JvG1zvskMI4=;
 b=V9aSkm5djOpsBp/347yPRG1CItKsvC8Cdk4UU9bNcLCzqN+ko3mzmb7QE+hKIfkdXw
 onPpZIjcdhfVcotmV225Gss3Qh41npPhW8++OSIIAzbL2cjK5c1WJ/RN+hGggnypqbbx
 /IR6CHNnbqw4aM0L8Vcvqd8amNdSK67fHs47V7e9gwEBWtgDGBRk58EwyBgDKQZUc0oi
 /i5K40dzQTnxA3JDuvm2OEKGhzKa2DpnjI0hOPvbZsupdwT8xYIHOyIZjJqt6jfmnJIf
 sny+qZGNLdlUGz1dVamAHUjywAcAt3DNJQ/7phz8//+ZgehgSq8YgsjAggJbv48HIeWF
 qsHQ==
X-Gm-Message-State: APuU4Z8bb9XSN9hFjizcjzA1tXePWRzpUrlduNutUefHi9yFwjgcU/jQ
 5cMRhRP5jGuKHkxJtGworKuPZsKgmEhjpMk0+q3il8hv6GLqEAROC83Rp91PvnV0FwTfSeBM1jJ
 JO4y/IIFq112lC1zrU4MPYfF68oQafDvypgu6ZlkilmMf5ynmks2v8sh7wQcRVaPw1Dpm2MP2O5
 O/rzniTqusNGxz8tj2t3CnCbmHQlpuNFC5NAte5zTVgR+/pw==
X-Gm-Gg: AZFdTZfZSNyE4mc+xSt/V7GhM9MHOcS0pDZ365T8qhn2KxIZxoYMzrh/Yn+fyQz8as1
 9eMx3WVp6IsllOwAUC1wBSvsJI2gTeI6+FfgbmDN5iLkyzgCV18ShH0AzilsMvdtpVHqMj0l01N
 D1AwFIf2dueA8RfXhDQeFpfhQAqV8aoMJXhqWPQNIVMJekueDwJEidh3M=
X-Received: by 2002:a05:690e:1685:b0:67d:f50b:d84a with SMTP id
 956f58d0204a3-67df50be200mr7456876d50.57.1795695097868; 
 Thu, 26 Nov 2026 04:11:37 -0800 (PST)
X-Received: by 2002:a05:690e:1685:b0:67d:f50b:d84a with SMTP id
 956f58d0204a3-67df50be200mr7456873d50.57.1795695097539; Thu, 26 Nov 2026
 04:11:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126-libsparse-fastboot-v1-1-fa1f13f5cb95@kernel.org>
In-Reply-To: <20261126-libsparse-fastboot-v1-1-fa1f13f5cb95@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 13:11:26 +0100
X-Gm-Features: Aa3M54pHhrqW52ZRuamJvwoDrCM9XWPzz79CZqs5Sw3-PeT6kFmuMRjjhiMwIx4
Message-ID: <CAPzfCAYOdSSu0ye=FFN63ckA4Db9aVaXMP+f-G2LeRo9wQPc8Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add lib/image-sparse to FASTBOOT entry
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Guillaume La Roque <glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NyBTYWx0ZWRfX3MwFuqxVXlm9
 QBDbN1KcKCgZciA4SrB80iXs8FP5+YoNbUAabHtO1coXN47nE+rAFqnjLYEBmRVG1W8eO0HcRU0
 42HztjPOh3umdcl3aC9CKD/WoD9UU8Q=
X-Proofpoint-ORIG-GUID: rfHln_CABWa6-UisCbHEjfQQ1JVuAJQH
X-Proofpoint-GUID: rfHln_CABWa6-UisCbHEjfQQ1JVuAJQH
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0821fa cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=1VxDqnHFAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WJXOnqOy8Il8-wyadeoA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NyBTYWx0ZWRfXxMqU0qxqOBiy
 1CnoCNtkkbwzZW0db9+gzxxCaL9+8iiozdm5Na2gstSdbbjBGFl9S5wkRP2IjPqXS8RPv3ZUsxt
 v9ifbTMX6m3cjcL6jM4K81ip+DEVW7DuYWSaBlu9KnWsZPBVVK0pUvFqCyktkNAUQ8tqfBhUDDs
 33ewy/8NIkZrEEfNaVy+iZbtEFxCGj4BXiuBVetBekfzjhMlTJ93Ee1OnOtIKnTk516LqGnokkP
 XcYc9WsSnQYxS22FyiRj5orNFdLTRrHfRncxVZwHMprMRNZazHsvFmmVPvq+ELeawHjQlJ854OQ
 95WhGl8SkM5L1sTTBR18MpsCglh7lU8d1Fm1gyFpaZKY3uw5nCDNk8mjHNjFUsCAwItOyQ0qQjW
 W8ykFAItvV87+fd7Rb/ss69s1qyHTVu+XcDAGad5P7YQSQp8UiBJOlJ3e90mBc7lx4Xx+v8DY3i
 ZTcQBbpgkt1sclIuFXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260047
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On Thu, Nov 26, 2026 at 12:19=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> lib/image-sparse is mostly used by fastboot commands and I'm getting
> assigned on patchwork on reviews for this already.
>
> Add image-sparse to FASTBOOT to make sure that I receive patches
> for this topic
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

> ---
> Note: this generates the following checkpatch warning:
> checkpatch.pl: :1037: WARNING: A patch subject line should describe the c=
hange not the tool that found it
>
> I believe it's an invalid warning, because checkpatch looks
> for 'sparse' in the commit title.
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6edf740a9ceb..5e02730e1821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1038,10 +1038,12 @@ F:      cmd/fastboot.c
>  F:     doc/android/fastboot*.rst
>  F:     include/fastboot.h
>  F:     include/fastboot-internal.h
> +F:     include/image-sparse.h
>  F:     include/net/fastboot_tcp.h
>  F:     include/net/fastboot_udp.h
>  F:     drivers/fastboot/
>  F:     drivers/usb/gadget/f_fastboot.c
> +F:     lib/image-sparse.c
>  F:     net/fastboot_tcp.c
>  F:     net/fastboot_udp.c
>  F:     test/dm/fastboot.c
>
> ---
> base-commit: 9d67454e920b3908529c9fc642a8c911db040896
> base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.gi=
t u-boot-dfu
> change-id: 20261126-libsparse-fastboot-85d282b78f6d
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@kernel.org>
>
