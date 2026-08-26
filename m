Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005C5C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 09:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D72D840591;
	Wed, 26 Aug 2026 09:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJnwPPVLGeU1; Wed, 26 Aug 2026 09:17:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787735879;
	bh=0aGeMVtFp9e7p3a79YyHD1k4KnWxzbt9nmSJ57MpC7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWkIwrz7Mm+1GUqhzYRbnAs95Xre4rQvIq5Iq2Rzff24LD+lpOzSuYZtgPX06XinL
	 rjQZNxDciZa5vo002l5RJ/jlAjquE0rf+7crccGXbYeY52QiIaUefks3qe4/nvDr5J
	 OJ8S1189nqkw5DcgNiGH8hqJEAqR4wxI6tE2nCeJnDTi8sSRwMViUs7wpxFmnP3Jbt
	 9Yi65eOJnRBpvffRlnPbmflXB8u7lOf5qZ/z7FpFQd7RZN5cxNFdvYXdtVVEwjyTR1
	 xcR+sXyic2aL2qt8H12Lc2B62ju8wNE3S/2ByUdsGR0ro8P62TTJKo5m+AXIp1SKBR
	 60DxLoPDMpM9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EB3C40545;
	Wed, 26 Aug 2026 09:17:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52B3E3AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5048C40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAxEX8lNWH0y for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 09:17:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LlI1R4SK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aJdsdIOO
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63D4A400F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q9Cgek4157845
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0aGeMVtFp9e7p3a79YyHD1k4KnWxzbt9nmSJ57MpC7A=; b=LlI1R4SKw/FMgXa5
 InTkWZ6hneFBNMXopFrQ3k4hbM+c5H76Tf/CGWB0xRPJNGIXCWP22KG1K3MtmLm4
 7oHhOXn92+ACFrkKrmLXLV6zoNcf6jSHvb8TackkqRSpxZZj4YuG7BKtiwMyEze8
 VZFnO+1wUZuWe8xq67H2QW/19jhu0owYAavm74KTMxhmBFLU+i5jzXj5tFesBIdB
 SeZlbv4K45IgzQBzQjgkmgjw/Gxxw/912dmtW6nCfQsfFbRYy/xIK6v4JUUf4oJQ
 bVf8ojWdAhNY+mlEgzk9s/PHJx5YVR/+SzECXA4aw7uq1unhm6bhD13sRbo+bozT
 DvEW/g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9g93a3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso1160310a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787735874; x=1788340674;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0aGeMVtFp9e7p3a79YyHD1k4KnWxzbt9nmSJ57MpC7A=;
 b=aJdsdIOOI/Zjoa066Hyrg2/77nmLPyhRiD0mkfhls+fUimPd/hZE/27c/qa4TkrbnR
 DT6s+ITup1AwLv/MHQwYoq33vGamD4TsRSYQsNmEFzTUOu5cyewU1jgUXUKzhvWGUXsm
 kqlI/01fblU6j9RzHumaSUr7AkC23hl4qbbkPilvLFa3mMn8GfwD9aS3VAlQj3NfQnma
 ayMUn3yz91Cf/sjbWlkQTss2EL7UD4lutVopppw7FC7gac0mpE44n2vAWCY1q2s1V/VR
 r07goW9++SHB7P7aF2K2F+amoqDB9bmWZGkDjq6RVq/XTOwEApSVEp93DPhACRiX4Ft+
 nkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787735874; x=1788340674;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0aGeMVtFp9e7p3a79YyHD1k4KnWxzbt9nmSJ57MpC7A=;
 b=YJ2ZDgrT23mMrwOoM85Glw0jN9TDtKDCTTWCj8e1ZO80050PeEvwCqR8b8ke6bhqIu
 JzB+Z0VzvSPyEAtaqiPdePVuKZI/d9wY+eapTcA+Bqz/1bWtThvyPfH1atpd5cRUiXac
 DsTrX2KebUu3BXFrUGGyVIOcXbG4/zG1JJEsOR7hvv7E0R/X+80aw0GyyYHgzhvC9RUv
 spuZIkpg7LoexeVaQOjEx42LvNqKs8zhtZAwKUJ4SNG+TULlpo/P46UCJt4CkxqxwZui
 G2ErBmpbCZJ4roG/0l09g5Kt9Rt0bHstmLJWY1cCu1a0qjEvoBR1Sslcq0qyggT1HraA
 BCsg==
X-Gm-Message-State: AFuF++lGO5v4iwaKSNdQ+mmotKi4yIT49FceQz+dYvDEkG7+j5MGbRpx
 0uSPM09gnbLypcxn/q+JBfXsj3a3wD+uKccDMSoFd4YwWrxrhJBa0ZpXB/ST7ZTD3a5Q6vp+4mF
 g7O90q21Y3pNx/IEi4VhE2DORJ7kaUtBDbXofDdxh1fIm8Fzw9VSFxufCW0drZuFmCqOsDhsSWE
 FWx0c=
X-Gm-Gg: AR+sD13gvlleSeGts+9VI0H7CWsf8jmk3ACKv/OHkGs9Q7bKjp/MNrcyCoFNfy9gG6t
 JlN4IIDL50ml+ljSmgCXBBVj31pzureGFD5R9+8id1sEKBXnKSmsBV+1LeOHZzPp3XJBcUIOKYH
 If71fan4Hckg1/Yl2j4Xm2yxz6hrEtJI7zTDS9CN+oZhXl0c1+nIt+rT1LcGnB+6GzfM2dP2QGM
 05YtTO/WigqXCZKnhJxwcGcxjLclDyauMkOLnB5wSg61mYnMwSZkjftwrykpwDCA5HK8tNJt522
 ybdWIyDD+jQinRwVThjyJN341tx8ZLsL+jfI5AfJeY0BEN9c99jxmkzM1qZl+IclvfhOSa8Bdtq
 30nP3oYIEilJs+yglGZ0al+C6AcXwra8nAwc=
X-Received: by 2002:a05:6a21:7002:b0:3cc:9162:6bfe with SMTP id
 adf61e73a8af0-3cf667407ffmr10976218637.0.1787735874480; 
 Wed, 26 Aug 2026 02:17:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:7002:b0:3cc:9162:6bfe with SMTP id
 adf61e73a8af0-3cf667407ffmr10976137637.0.1787735874008; 
 Wed, 26 Aug 2026 02:17:54 -0700 (PDT)
Received: from [192.168.0.7] ([49.206.98.18]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8f47d8csm6311886c88.8.2026.08.26.02.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 02:17:53 -0700 (PDT)
Message-ID: <4e0138b9-0105-4736-8c68-a913c0b7a502@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:47:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] efi_loader: firmware: decouple dfu_alt_num from
 image_index
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
References: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: foH_lydRQnAQWa9dYo_S0QlHQjks5b70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3NiBTYWx0ZWRfX0tC/sj1r2LhF
 VMQqgPhSvU+mrE4mVBtD5Uex77NHMXlzkbIivRJQoUUVwuDVNvLEUUCAEoTVnXHNiqwxwZh3SOu
 sZr4pm1UJ9dXS0OrsPVTU7JBha4PhRuCk2AiMPsa0mJwksiYsgj9PRgJRz3AXxkxtpvasCKf5KY
 ZXMj5v0snUe5cwbW/Y1+gcNmFc/CXyX/N9P7RvrZJruoZPbiSZqs+Z9gzSs1LgR6/tZlL65PZSG
 DORjUwmBHbYs9d9fvSdvzWQpA5xBhdhDeeWaCj7eIgGm64WizBApuVfzUnHHIC422Cd9C8JERsF
 HhCFgrBCdAyG5hnMV67+R1BFR/jcD7qU0KaH937bXOsm3FWRU9eA4Xa1UxRiPZpwS90ElBbyz/K
 /rxLuNF2Q2kDiuE49CrtANHmsT4vEqXjwGSeQDieZZrHoeDWI/giLfFreK6occlRe4CnCFvnZmf
 MT/XnVmWkyEKOJI4ASA==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8eaf43 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ixBiRExtVUu8ZU8EgKly7w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=94nzaaMePdrSc8wTbkwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3NiBTYWx0ZWRfX9eZ/HNci1wZs
 IGMozD6/03WamClnuJkR8hgxndzswIQEauzN7x7875HXLUdFlhI1nlQ0Df5+qaEOTwTDE3gggf8
 iGLo7bgdLZSrYFmgXlihctZBqcJFrQI=
X-Proofpoint-ORIG-GUID: foH_lydRQnAQWa9dYo_S0QlHQjks5b70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260076
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

Hi Ilias,

Request your opinion on this series.

Regards,

Balaji

On 8/13/2026 11:23 AM, Balaji Selvanathan wrote:
> RAW capsule updates hardcode dfu_alt_num = image_index - 1, which
> assumes every board's fw_images[] table is a positionally
> ordered mirror of its dfu_alt_info string. That's true for every
> board that hand-writes fw_images[], but it breaks down for a platform
> that builds the table by scanning its partition layout at boot: the
> set of images and their indices can vary per board, with gaps where a
> component isn't present, so image_index and dfu_alt_num can't be
> assumed to stay in lockstep.
>
> This series moves that calculation into a __weak
> efi_firmware_get_dfu_alt_num() a platform can override, the same
> pattern already used for efi_firmware_get_image_type_id() and the
> efi_reset_system()/efi_get_time() hooks. The default implementation is
> the same image_index - 1 every existing board relies on today, so
> nothing needs to change anywhere else.
>
> This is infrastructure for a follow-on series that builds fw_images[]
> dynamically on Qualcomm boards, which needs this hook to keep
> dfu_alt_num correct once the table stops being static.
>
> This work is part of multi-image capsule update support for
> Qualcomm boards.
>
> Balaji Selvanathan (2):
>
> efi_loader: firmware: decouple dfu_alt_num from image_index
> test: efi_capsule: add sandbox coverage for dfu_alt_num override
> ---
> Balaji Selvanathan (2):
>        efi_loader: firmware: decouple dfu_alt_num from image_index
>        test: efi_capsule: add sandbox coverage for dfu_alt_num override
>
>   arch/sandbox/dts/sandbox_capsule.dtsi              | 12 ++++++
>   board/sandbox/sandbox.c                            | 18 +++++++++
>   include/efi_loader.h                               | 17 ++++++++
>   include/sandbox_efi_capsule.h                      |  1 +
>   lib/efi_loader/efi_firmware.c                      | 21 +++++++++-
>   .../test_efi_capsule/test_capsule_firmware_raw.py  | 45 ++++++++++++++++++++++
>   6 files changed, 112 insertions(+), 2 deletions(-)
> ---
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
> change-id: 20260811-efi-firmware-dfu-alt-num-1289dae96490
>
> Best regards,
