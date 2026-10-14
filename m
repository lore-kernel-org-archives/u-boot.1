Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC92C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29DE8407D1;
	Wed, 14 Oct 2026 16:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qm9TFaV92Ctr; Wed, 14 Oct 2026 16:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67616407C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996699;
	b=MlSS3HMRL89YwTiV+Az8qgHFaiFQHfS7MyicmEcHfydu/xD7YMcOkeEmAcg/kdGJBXBJ
	 9heIbfTk6hLLiHckKIAunga/ZuhJXjBQKCA3686MuctQ9UekhSfO9Ju7bp9yDBLRacDRp
	 KLbYojkr0QUvlUefyyzQTrQSeTCzqxQwu0l8xRgxHZErbhEclrlZ6N5q4U8pEwT8wlgf5
	 pn+UlRUkZMjQKT12Gq+6b0M4oQU6k+KjN8LLgLw4hwqZxX6IxW4GQAi/mbzPdTqeyEgx+
	 k8gINJJ6BwCrWUHpz1TyCYoajYpTmpBPlbHg9An6YhauG9vAaVIzINiqaUNCfcdTLFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	b=YakOUPDsoxZwWCkN7sjJ0NInuZ9y5+Ht3Ikp6HfWq3R5eAlOc7ZkVnJAfA8Hu86MC0DD
	 mZWTfYqsJfaGXQ3rXE5AzWhXypTMPh3HpEtcg+MSJExDO/Ouct0oila7icVNRQWmhTsZ6
	 uhaqqW2IWHtNItmdr+KP+VauZ9mGp5sQNmk3/IXsMVl3YgjQdzju6t7QsWVmICRXG9QdS
	 jjjxH5PCvP3IdXdHeVH+Pl5xI6we26nh+4Rt6HQQ106/Giym35v64w328QvV5bk8h2/P7
	 ha0D9KYFi1EfdZ1ZNRMN/ti1c5rfbyAhZEQr0VFBFFav5BYjtZBjyKJ6RUvRRGGj0tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996699;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOIVgGwwKDJx49priKoxcJeU+w6jT45rDekZ66joaFHDknZn3AIApITWkawDiSAHh
	 d5xuJmMjNIqhv2yGaHNGTQN3O80fN04JJo2NnSqOLalH+vT0vtpAU08bce4ViSRhSG
	 1j0k7w18+FGzuVHF6Ii+kk30IgqGAjtQSMyKeQrVoJZqi/RPTPKiHskqg3H+AsPjoU
	 cO3hoXTp9n1P8ahZetMEZSYZGJDVKA/30TFClKKtA4U0yyDAjd6mzhdA7Fce/ghodv
	 o29qnSFepF+UeQsrn1FEdAETxaPl4w7iauHiv+q0tYBPgk+H+jJa02XjhqJVh/xRSC
	 n1lkd8nQDckvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67616407C3;
	Wed, 14 Oct 2026 16:51:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B26A01DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 987DE80E7B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfBIpO0qouJA for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 671D080E1D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996697;
 b=m8+AH5UP7hojH/go60o/CaHG7UqykaSaVtROM8cN+K28TQ/R2q3tWNSSdmYEDgsrr8C5
 Ge8tVWOz76Xo2OOqGkBSqV2miCNw4QUEQtRwWBveXWhxTK5E7qpBrkTNudbIloRnUvNvY
 Uh9YXcBNOOLoPEzkRuqF1PosSxFhIKIPV332Rq6/R0s/n4vIBjtgfT/xItH6fMVVKgSv7
 fJITeYAXBdeVRvrMoQ12kg+Jv2H2Ip62w1qIgYnBbrlrC4C4qvCK0bsflgjnliDZALwrI
 ble2plMDiZIe5X1UAaJAom+qG7Nj1G2DZU9kVoSI06oVnzJ/chu3lTwlKznRrtcZpWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996697;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=LGZPKzl4DOgXipnrAKhDlhNnNJWz7yA25S2JhML6QYr8nqW4CBacOxvNMboM4dyRWGEC
 /IIgnyhPe0vDbx3nQFtMs8iUmCTC3b9SYTLncyTnYRd9qx/XxOT5QlxdmIb6w4I2MZgNR
 tAE/sSN4cNMBAz45QFKcnRuEYbiqyJgQt+Y0pq2TYMFn/j2p2KOHJoZX9Rf7Ijy1F0YJl
 WyoNmo7lMBrt5MKyhYD8h4QmIeE2wseVNJe3BlADSJxpI99/nggoLpFdNoAr5vis1hbte
 UrI2IhiUiT8Xk8Duax+z42kbfE1oi0owdPw93Uiir+9/1005fuEFoYg428CbnUFipqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cUF2HqoU; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="IytcsD6/"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cUF2HqoU; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IytcsD6/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 671D080E1D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbFxn301209
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=; b=cUF2HqoUa3YSrkCp
 /4SSUmwhlAuRz1h0hk5XLOfA5r76SVf9ujYsBVPv1ZOxUViTToi/SKRAu+4o444c
 RoSDvv6ZN8dgRk6w/wjNSjjfRYVFA14HvPkr+LYJtHmpFTc79qHo3fqQQ+MfM7So
 DsccE4fU2qwwKk9e1peRkZtNsb0TatL1emb882M0EW65VI4znOnlf6lQWEVHyKIa
 xK0w9lynCqibfBfaN/XKmru8xAz+Xqv/BONGz22/GR7qKxhWyUjITIVcesInIYDd
 qJnRJg40j4bJbgWfSbSgt9/k/iy1QvrLgy6MysNYuGZXWDDOZNaT/kbCvc2uWDtj
 fDoLOg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622mh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1663fb7e005so5596886c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996694; x=1792601494;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=IytcsD6/5IjDvk1VWHNFqOgv7XPWM6RsQFxpXyh2S3GFYxYUNkS+GeuEpVDTzSbZQN
 IVv4h9TtESNMVweur1BBenQ+lDfqJUH+undXH40NsQlzAMFbV2r42dpkzDS4tsWRYkFy
 FwgcF9T1SCoZXXQHnhVYAxf+FGUtbfo6wiVyb4SgrLDljLngsfWiu6dmFkczfj1XNbVu
 ClPz6ExmQ/RN5+44gl7GGWkv8Mgpt1qeuZN0bP8jZ3tL1KH/yw+PgL7gNxDP88cXyEcZ
 1G+D1bTstNLtP1jJUk/OxgAQZNXDMdKIPbJaGBS8+2p4Iju0ShhxHdzS6vf3NXA8fBqn
 qVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996694; x=1792601494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=ZN07j+O5pVOSShUUZoWLIld5z/Y+LR40iw4wGqfkhI0Ko0SLoBdoEayffNvT8ldj/Z
 bv54s7K1TmmBBQMoxWSLSCfPGF1N768C/a8/sfoVB91hbHDEheEPqBkMBVnVe8nhR9eA
 XHBmaX5Yfa7b/ybWppAl39W8BlOT2jGZQ7it26odjUHqC3Eel8INu9PEa2Pva9ewIt5C
 SKX/7ND/SEkBQg5dn8ayhSd2FZP22juqOxlsAPD2gXjPmOl5JE/3c6oLSxLRVj64j02m
 MqRoj2vyjDJY4zd4OLZSi+cDKlXmom49p/PDAOTnT2TWK7OLG61uv/7ufvKyMmdq37ya
 WM9w==
X-Gm-Message-State: AFq9FYLvnJgG6pbXAOnXh1UIMA7LM21IIORPtg6fL3wfchO5Ac57BPYG
 J/x9O44h7QFU4hodeav2BJOzrvYNvic0TCWnT6pkHwfFiVHBDs+bcje5rfuRu9f+7wwKF2e2mIe
 2xCaN7p59JkAURh5UvvSh8jkp2gCTAR782gMsGUB44T0BplJ5jvSQsvGVfrIUiU12EZtX0Jc=
X-Gm-Gg: AYBFou2ktIQHx4Nzioja++29E7yIsmj8kb+nueBcaaLR84+zMokPUlPH4iw/zTNqZf/
 wPTpEw6o+TFZxR43eZpganDDrpgm5VJfkGSTRPVCCsa/umJUpE7uR1Ve1lDB8OUwuCX5oSHt365
 WZWFncYT+i23GopX8xmfVzwUK59FiDY7WxrlfrWDD5hUcCBhjxjsdQUa9Xu7EY1lN8AarZt9SN4
 E7UEoPfPi8vtibUMZdNRyUMl0OUiiucr6Z5b46rFhH0XXaRv2cCMi/4vNxTInCcTkDE9gPHVpc/
 MUklkXLrqkXoqHNnA60JqRzQ5xCr5xXQdluLJudasJEWAqT/J397qxACxyafkt8W/kXPQNOVb8r
 ekmJq5FPUPCArdik8sR0XqWAKGCOO5ze0IB01e12FPMLKyYqJzUxMhLTYVzlX+JPsHyuQK2ZSlK
 20TvAdtEva/LhbOKLy/kLG8DStq4w=
X-Received: by 2002:a05:7022:1605:b0:14d:baf5:c412 with SMTP id
 a92af1059eb24-16a5fc91757mr25948783c88.8.1791996693333; 
 Wed, 14 Oct 2026 09:51:33 -0700 (PDT)
X-Received: by 2002:a05:7022:1605:b0:14d:baf5:c412 with SMTP id
 a92af1059eb24-16a5fc91757mr25948718c88.8.1791996692569; 
 Wed, 14 Oct 2026 09:51:32 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:20:57 +0530
Subject: [PATCH v8 3/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-3-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=2642;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kMXybNKBvme0kpiWoN1dRGVfV37kdSGtEZM3Wklaoi8=;
 b=spaOtvWRvfQwV5uxlyG/ZMwo4r5vFeclwYPQBEZBJXdAtVCT/9lURGQsiQzqE2VusuRUjmByE
 saaXb1bN9+hDtpk5DKyCKDTBfqxO5Wn81ek6/UXXF3xgmf/SyTK6U+Y
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: va4LQRqAV9KVaWTrolsXDeC-XEXT9721
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX2Xv5d4TKGd0A
 srnWoi/AyvB7LC2YLc50kTtzl1+TW5ABXgA0W1rGmdzpYL892wgjlUnQCW2ZUvJzaRystcnrE5f
 4cvRuEiCxcMkxfVQyqmKBdE3cLQ1dlqMWoxDmjunIEynhHmG3uPpR8pmYjAugr9f6kgqI/LtvOe
 zVEYmv/FMtYsTeftIaQA7i3vNjcQIn6D6u+Pdf45FRmXVdo0SzZh0VQIhs0AFuHumkFa+gjLaZO
 7WRnxWICawz4TNVWf708RNl1KFZiNYT36mD+6X0hyPnquUn5Ngb0NOdQjJUZC1fyZiKpnrFuN/V
 MVVOSxASoTA/j0zV2oNy5lYB6glYoytTLsGkiRLdiXN53CJQPuBEjbMXphjpZJd6iHtFWO9UNWK
 z11Etdb5IllSpQJjFjPV7nLX+7YaXdUQAjZXCPJRlDJbzQtxnnsOkKX2UM4dKeq+ZgJXC2Oy46O
 g2CJaUOx4XWfrAyVTqg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb316 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+712s+V/RGYC
 qXW0vAzhJjEDBf7MtKDJUXvj1GkTAnWkFjiqpDv0Qpyohpebi4UXpsG7vaJKgCbeB4XyEyAxvdb
 HtlkrcK2nRQ7zVBu5vBWKnCMNCG4V0g=
X-Proofpoint-GUID: va4LQRqAV9KVaWTrolsXDeC-XEXT9721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes iv v5:
- Clear C bit (Dcache enable) also during MMU disable

Changes iv v4:
- Remove handling for EL1 or EL2 entry as for Snagboot we would
  only enter U-Boot in EL3 from previous bootloader

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f44..ecef094629b 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..f82ee87c9b9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point for EL3 entry.
+ * Snagboot mode always enters U-Boot at EL3.
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* Verify EL3 entry */
+	b.ne	reset		/* Unexpected: not at EL3 */
+
+	/* Disable MMU at EL3 */
+	mrs	x0, sctlr_el3
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	bic	x0, x0, #(1 << 2)   /* Clear C bit (Dcache enable) */
+	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
+	msr	sctlr_el3, x0
+	isb
+	/* Invalidate entire TLB for all ELs */
+	tlbi	alle3
+	dsb	sy
+	isb
+	b	reset
\ No newline at end of file

-- 
2.34.1

