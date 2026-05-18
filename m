Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F94CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 19:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B120B84119;
	Mon, 18 May 2026 21:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OELlQfIv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HdM/F4oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC8A8460E; Mon, 18 May 2026 21:16:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D128880433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 21:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ricardo.salveti@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IE0BKv353001
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 19:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l7+aTHGCh4JRyBylY63VVsot5H2zJk7w9I2BOppjJm4=; b=OELlQfIv1raBHz4x
 zh9JL9MJVxAHynrHvoxikjoVZDdMQWdkcqTH9sAanXHX8349+PbHcF4/MtqPwZFM
 BbGLbk8c1WSnn1uTNVXsmqSvpuJ5z4OkNRYSQgdoagOwMYkXoYiNV7n6q4tD065X
 U6nMof/pstwHuUMw+7GNrOba9PkQlJK33t0UjlUQ98+b/EUu0qsFTjwH027gmPfe
 jeA5kpTLbbaSiEnM4zPQIxFwDgjjwLjmjFcop+9jzF2MbxAU04elqQiV3VjwdprA
 /4VlLtQCUHlzoNdl8c+zB6L5CO2am9q/Df7D4yHQPy82TrcSzpk8W3x1p5ZNuOCu
 nVzk6A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjajrbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 19:16:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-365d4d2fa04so2458215a91.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779131777; cv=none;
 d=google.com; s=arc-20240605;
 b=irir6w9iWVPyuWwVPG/IrwLqG5Gz33qyOs/kCyUst/OGBI8mXlaut412u0vhBozyvK
 J+CRkh3v6aTy/A8RM17abi2WAvgZbbORMZ4orVURHTVjkBT5emVzvdpfOEZHJHvs3tRH
 YoRyQ6Ffmn7NhAANTZLu+7DLVedACaBmD9P/9rTBbVhzRXYAVqvjcxJZe2Oba11nHODx
 pzjPwlsd0eLZY1IpvZWqWHPADY/cU2FfqxURXZQiyDmCF8G1zIDE1t0k5wMHPupj2fsw
 QbFAdLt+zjMcQAkLLs4jxhWRwiP7LG8np0KF5rc8sCOpTBKNs997PZBWF67NTn/yP5hc
 sR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l7+aTHGCh4JRyBylY63VVsot5H2zJk7w9I2BOppjJm4=;
 fh=3iNYg88dhW19GjVaCIU4619aPJN79/mDd+Kso3tHAOM=;
 b=jIvgFh3AYCN4nDfIXbfKe3FP4cMfg3vjHYrpxpR9SB2m6xWUK9vtrlUqM5DCSpZHPJ
 T6sSCzWM49c6OSbEBgn5/8samQNj32KYMwaDvEMTUzX86gkY0++huPYQEfqNeDOMkrBT
 cVlrNcqUR/28BLxm/jFfRElMkIObPV1tB9uE8kL7M6AtxwwGzfvSkGDNocnndTKw2FhH
 KqEBtQr8Rv/l48PbAvZ19J8SY/1uFHd2FF/YHhG/JjZabEfYsKSKrsVdnzv4D+N93yz0
 kZJqICBsq0mvvPeK7odWxH6cUYjzTJN+ja9Z3plZD5Oyg4GoyyCOsxIhli3/wgaX2YLF
 x34Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131777; x=1779736577; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7+aTHGCh4JRyBylY63VVsot5H2zJk7w9I2BOppjJm4=;
 b=HdM/F4ocnxIRGB0g9vNY/BPchl/FuAvOcnIyqeq/8nXux9LKlCW3+Qc+Y0pB/jFJBU
 vpwPk1Vo33Vsujvwiqtpt+Efse99dfUsg8ga2IpCS5fLc4t2o5bTVnYhO+hGzhC2EJx5
 EfzqGhIujeKcO7zvV5yDU5LlKIdOnf4tztk+/7DRYyngD23tGZSIqeVbgRO1dQxiSRAb
 CGq51jW7ShKT9He3BlvUgEGNAp6NMorUyr56QUSL4aNboSmdaUONug6jhl5f3SGjJxAX
 HLa1AncYUf3bOtb8ZgTBAbnmrMpPzjjp/ukjxD3EyipXLS/NWi6HQIzrAJV9iXpopRGu
 acGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131777; x=1779736577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l7+aTHGCh4JRyBylY63VVsot5H2zJk7w9I2BOppjJm4=;
 b=WUh9UgzctwPdsm3tZTTX4b1/ckjUDY+9YrBokhRfLMXVqeX+w44OWSwJ55r9JWE+AP
 XMv08i0zxt5ny3Mj4dYVDp/m9q9A1O5xcgpBlTZjjNfL/xh+NcVlVVW91kx+i22iVfD+
 VMthhOE24pCHp/VSTIwEPD6ayuoAWa+Hns9aIk/E9c9vtbzbtxlibPMQ7vktjniyGFix
 EYoBuG2+J/+DoNuBsp9i059WIqnm9y9PlK7GVqa/J6AsMy/kEVz5w1De2vmX0r+3FdVN
 lZBm0PyJh4bgz3A+BWKj3oKibN2kAsl6vhTDFsjQHjhdUubjzms0RzNmCGAYJerLBEFF
 4NwQ==
X-Gm-Message-State: AOJu0Yw0G3N7fTCvPKSii9ii8nB5LpuNKSVr5wWt13coqul2XjRkM3WU
 sbRPp5Jvp9AWUZHHppttXJtRCXO8q4aIakCAxAerhXN8cuUdW5Hu+J3dFY2eTuk/Z98n6WBIVtZ
 AvqYa35u3wDgXBz5U72KNuV3uXFa7ftFWNeUtQlL3XsC9d8VH/up5LpjkfLAqpYUkocqwdSX0Yb
 vzFxDOMRZEOEVKf9sllStCZS3gQpdz1Oo=
X-Gm-Gg: Acq92OGUscxJ5fRv7LZ61ppzJEv1uoRUsspWJrS88vVoKLJ4zZjo3qk6k7u2t9IgHMq
 eBfwBFUhyAn4OHzQA3PKxV1eFCu7iqO36Pf/GRwDlsh16h9YO9WR9oWWGi2URzTOO7XToYdohpN
 ZULDCGkmshsobUe2LhbK8mQYxlytp4/+dJ4mwiDP4RT8+Le6B0Zlxl7zxZ+lZcXJebDNZjfrqVG
 RGx
X-Received: by 2002:a17:90a:a81:b0:369:73a:3266 with SMTP id
 98e67ed59e1d1-369519e40bbmr10917760a91.10.1779131776592; 
 Mon, 18 May 2026 12:16:16 -0700 (PDT)
X-Received: by 2002:a17:90a:a81:b0:369:73a:3266 with SMTP id
 98e67ed59e1d1-369519e40bbmr10917740a91.10.1779131776094; Mon, 18 May 2026
 12:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
In-Reply-To: <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
From: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Date: Mon, 18 May 2026 16:15:38 -0300
X-Gm-Features: AVHnY4ILcIwzXuk4riUZesHw6r56PoA2U-4XKMU6Y1zKaJNlTPeV88ebrKoyMJI
Message-ID: <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE5MSBTYWx0ZWRfX6r62QqIur+GC
 LpwPNOzPV9JNNVqpenpWnTgDU8phHhZED7MUF2V6xWeDpWUz+2e1lI9IAquo9tgRY7eqztZJu4B
 d2iLX1sEtigOoVDig9ArReLT2ITqBRHyxopFiBGsB8SJWFi/bMoNqrkX0eqPnMS7B0UbH8JOmVd
 X5ZY/MDvA19eEoWuf2xxCIXJkGnW/bvwcphyTjisumui7uGmjSQV9FhB75LrRycIGvK02M2TJUk
 PfVrdHbaP6AoctxihnNINKt/lQRry7z70kC1edFWAKvZ68LAhJHojnBEXv2+JbzPEHjq5lMJRg2
 uQH26hOXoO1xM8maHO1QOe9mpK9dZFJvmF9sQ2fggzxTGNCeZgb65ocb7n9DW8CG9lyq+m5wY8z
 kH/Ltdk60P/2xdRzZGE999VURkzA540OSRLWaxw71aeCLCXt+5bUD/w/J/jhm4OkNqpUWfFeVm8
 LFmxQkvIAI/MYY3qZZQ==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0b6581 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8 a=xBF4swCVksbP6Ffjn8QA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nYLo1EtTz0VfN5DKxkHWEer2_oO9H-AA
X-Proofpoint-GUID: nYLo1EtTz0VfN5DKxkHWEer2_oO9H-AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180191
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

On Mon, May 18, 2026 at 4:59=E2=80=AFAM Casey Connolly
<casey.connolly@linaro.org> wrote:
>
> Hi Ricardo,
>
> On 14/05/2026 22:57, Ricardo Salveti wrote:
> > The Qualcomm default environment currently boots only with
> > 'bootefi bootmgr'. This bypasses the standard boot flow used to
> > discover extlinux and script boot entries, which are commonly used
> > for FIT-based Linux boots.
>
> We intentionally don't support these alternative boot methods upstream
> as they aren't standardised or supported by typical distros. There are
> also plenty of inconsistencies in Linux userspace depending on if SMBIOS
> (DMI data) is provide or not as well as EFI runtime services.
>
> Could you explain a bit more why you want to support extlinux and custom
> scripts?

My main use case is for the target to automatically find and load fit
images by default (based on the config used), which is a quite common
use case for embedded distributions and products (see that it is also
enabled by default on several other platforms in u-boot).

As u-boot provides support for bootflow, supporting several mechanisms
which are probed at runtime (including EFI boot), I believe it is a
better default as it supports a wider range of use cases.

Thanks,

Ricardo
