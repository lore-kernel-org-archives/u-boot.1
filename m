Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE4CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 906BC404F9;
	Tue, 13 Oct 2026 15:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vye4XA8Hy3KG; Tue, 13 Oct 2026 15:32:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6976E4031F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791905555;
	b=BY/CAjT76wBhZWm3b+7eKC5LtLCkmGHzRnYLmh6ZeSlULjK6RfuIYZpS/TlLUOA8D2tq
	 20rdEsbxD3qiOJHcC6kRgT7P3BJcJacFaO1b/dmj9cdH90uO88nCiRezp+RXF17sm0tcl
	 OzZ6/B2ggEyPfGJKWOL+WYPZUduCPJ/Xmt0GE/i4tlF+YXFluezN96dwTVQnACNitB368
	 QW8zLZyv0WKJDl4J+xrHjZzBxiuIIiFA2jdypiDvxuSXe9GaKobPRFaUJHFhzA7CcTb6u
	 nor84YwA2m4DpN4m7IKLwDlwM7N2N7ywq9lUtAz9E17XUbcuJvE5X015IH3Qk9tZFqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791905555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
	b=Dm44uWRSeHaAZ5oG7PCd+XLLkKcYYGpWuxCMz5n5EcZGphdPRPTrlCOb2c3h+KQ3Mban
	 JXBxK0Pczj5oNpy7RQ5K06ROgFBUBmSR8OjwWu6j55/afeN9meIbWWDj3DB/hiy9tWyys
	 nbNYXAenqBM9cbRlRWdvJRG166QYAX6p5/r25KzmzvJrZojDTKprfUS5Iub7bFuYo73Zn
	 TfVF/dtfXFcCzQ0xYb/+tVbIZONG00H+omf38+QLyRCzum33t+SRGots5VKSmdZpE/cZk
	 xef5WplpIpOJoPq4dgGqPTfnIcZ309JZ/3LiCNTgFOaHsbASJxkq8BS8tF9N5KUqgHA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791905555;
	bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OY9kgIbyKLJZsrqPSBteVFmGD4yMGtAe7FhWCH4PqDoAwTAM25460LpcRFYyJJLuc
	 f5KmVO6+jkzyPRWnR2SOo0Q560VIv99FIzL246S9wnln8Tn5H+XYEfJZvX44O+Zpip
	 e9+CuVkG4esndUXtKI/otH1pY4KCtN0sLdE/gi2a5XdCSmJCs6FZ1wiD91WRl1gP0t
	 /qhyJbUHpbxzUyI5Apkt4c2wen1JWZ4sxpxZlViXOK4NESZtGqpW+KW02c+4qO8swT
	 ac2bkxKX4fRLrfS3c9CrlxjZqKn0I3QeQ44gzbHg0eXCG1g6y0DqFUGZaYQtiTu2uQ
	 L3zCeMpySwU1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6976E4031F;
	Tue, 13 Oct 2026 15:32:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1690D788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08402402D3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57KY-KKpa58B for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:32:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2F3F402D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791905553;
 b=IYCc1oezMJ9f6OZptjdnhcTg+nQFN/KzxyjcjCmb7EganCZZhmAPpLrLsKjNViUzP4+m
 x3e5mbuQm05/xS/Tc1pm2GrtuYthDhuSWT/Qe39jusgj5KEVi3bA/KEYAVQ+5KKk6xbpX
 KRSWmppMYlXxAatGnwLlLRYqXwP+w7eFqbRskSCCuoDPM5CU28BrefoZoAil7sRwuk1RT
 hYmEbW8cEE4tCCpSbd81y3w/TXyypiSbgLfSOTikcQd5Qoh2l8hbG4hd8mC71V5rMlhob
 35elmHeuhrHmtC2gNqRmuw0T5vrHG4lq23aCrvyHCS9lNilUepzuL2STVyLekUxvSgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791905553;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
 b=NHiAl1nkn7egmzMNI9KTQkQLnsnftTliTIUwwnuSOX7TkHA2tEE4LczB8viZyO4a4A6s
 f539PMqIGvKyHn9o4W4OadXgugCtmgi3Bdl9WbqFcv/h2HLygSz3GS04YvnEELToaz/u0
 RalrLNgHGsfR55HluxuNCDDj7qJ4DBtQZCGRHuJNcgPBQnYtjUla5Aoq84/+DCWCyVuUI
 w9gQ4r8HhXCNCqswtH5JacVI/GdijDAVphQSPklqqB4hSCo9elJuxiD6tcNaLr/cOfLPC
 wiFtEjebvvsR+IIVc25VNFj5MWdJihEV9bAoCx4sTvaLWYy0syfloVBtfNOac6dxKpg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OnBUpQFj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=We1NHnCV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OnBUpQFj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=We1NHnCV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2F3F402D2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:32:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3fTl1143631
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=; b=OnBUpQFjOwtQ8i79
 KUpgirjJIEYD+h73yyrJDEz8DOj7jrD0IZtGnyPIcyKajEHiCJd3MOar5mlJg2gW
 EMYzPHRWsgSu/cE6tjwIcLUdii5Nz4ZIqTO5afp6Hpsgp7ga2zqbgMNSKg/R4E0N
 S8r/Z8Jx1Li7X7h6Of6+pJTO6epLSl9pt8kc4O7TYwTONOp+h1LVtQ0HMpnC1ryN
 gI4uwoIvrPmXfkP7a55fygCwGZxK9yiJwFN9Z5zMxbSJ+dG3SjjyBmLrDCuOAOHS
 G56jH3hl1g9FFmHi6tcOlBKYsXW0AD3mwUqMKNrpl4U15OIajcp5m6n6U+4E3tg6
 N6ym8g==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hpg9ns8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:32:30 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-837aaa9a3f6so35050447b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791905550; cv=none;
 d=google.com; s=arc-20260327;
 b=VSo32VUyasnxjGwdoFht6uBRm0LqBBD5AOWPKt+NZbSdSNRdGWdFgDFq/5ziRH7gAN
 vVrqgVG2WEw3tRW5AICSY8xQFff7YdN72aINweknI2UmFecXq42NQ+nkkPfKkd3V4rzw
 4/IeTiWwHDXQZ0c0qBgo11ucFuiOK1n4G69ThxdzuExxKM9myrqAxwsNJn+kqwHF+wvn
 IkuKahA/+Ia/PmpeTdwQG/N0i8wCfSWBs8B5qpW/e20jkcunFwv58oHTFnxkwVWgatI3
 ODO+o9AfMz9W30das8CwX+Oo+9ba2QCXdDPXA9HP4X2m1zM/BmBPYwpzs7AUBx917OME
 yTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
 fh=V/j6Ueum6vjVE9HmZZcWszPWP/Fm3sIbVCHpYxzP85s=;
 b=YrVTlbckihv5nMEYVutSM080xs17IgIcyH9PY1pD9Yiyhn2Xxu+szLY0Y3QFcsC4vH
 gAfkhBMzZCgsGKgs8szMpnWpWgGg7jdMq5Hqk7G1ILp0R/CQm2xPTS6Tr3RozG9FhD9I
 DaLiduiuE2NwSsCGKZsm8QAkrtZigUNr8vSfWpGzhGuCwOFL/h0ngqmV44Rxvl5BFbvk
 sxZhX4d9RgPCtLdkzD4r4VVKDKjPzu7199NwGFzLgtAci8Uec2CJPlnENljV04BDaOjZ
 K8QJ/MvsACM/VirxN9cvlOVx8mtqP7nS84I+7rD8/EH6YO7JNOthH91fkrCk7efvwUth
 2Z9g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791905550; x=1792510350;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
 b=We1NHnCVGiOW199k13Ubc7Q+vaVo8TztNqybuaI390Na9H58aFprCYx2HBuWFo/KPL
 9ebVaa1hkxizdHcbqSR47woy5G1QpHWxrdUk+ILB+R5/0YskjAtrOtwe0yu1ze2jYY6G
 9mpoHgdMmFbPRa8H/GGMYT29d6xnYqj6IMlRDpYRJFmoLib9XQ8Czf2jCRpIxfS4OIX4
 gjRF/lhjFnnw6UQX4yt+CHuJlqfhTVZ9ZcSNKnZvbC6bCvIeKnCxN2aYrEMZfus67s4p
 rt/bxTRD0c/nCsYMJHBqDdSrEcZ6Ht/GX06MHRPXvaW22GjtGKKSrBJK5iE8E7cqXiY9
 +QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905550; x=1792510350;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Tv/gccuxixoJlNSD4EsP7Qpom/UM01H8mUXQvT5HjA=;
 b=IwrIsirHHvhS45on23PMoB0sroZo0m/EExQuTJw/9ux5qluZpqPjDjcN0N26swgEKG
 SvdaT1cjBWLc8VTsV+QsU5AepYnqvllREI0XYoTYlzc+7GG0sPsu8MqIPcp5wKAbYi2D
 jR51SCvNXCI1XRgAIo7mmQCeCVC0YMl5RoCibM5frlQ/ip0hQknRG+LxWbmqEuqTx3QG
 zEbetlvrGkWMJZCV1/O1Pi+mi5XF/gjTYrLiwOwBeHlWZWAokKwyhJUo1knSssUMsqea
 VRii+xdJJT608/b8RQyG6o3CTi++pBVsydNdXBiYVBK91BBV7sqltI6PdEc8weUWyTY2
 c5GA==
X-Gm-Message-State: AFq9FYLuEEF2YfMAaeUTLQidzmhuHRpQvmT2PdSp5Ik7XuWMYueDOU5Z
 LfjGqYByd621JgzGCXagRXFhC4bYFIaPR40oUgUcXAIPMP5S5ypKh8qbh5ax9uhgFfr2Pxkyto0
 HICSDisrFbAYLMtIGwXi3YSd/sPBPIgUDWaTEglbfYTlcFKxaMPPIK8jyqbeNoHyON2io6iUpRn
 P0UCtmxcrOVd9iuHUjQqmm4x6RY/24YW6RX8enL0ve/Eo5Jw==
X-Gm-Gg: AYBFou1cZDxL/JyXQqF917g+kniwUObMP2AAZ2mbh3Wt6ehoopX8cqYXj575dlG3uv+
 ifllJIBR56GX843FBTbsy2hIRzTC9hTwHwRiP2PL48QwDkT9Rysq144UHQ+xRx9JylUALo4JYGU
 RI8TaophW/xIGksFhDd9n+xU0jEPzvxQkHNKCVDNrIZZdAULgRacqWjT8OdQ==
X-Received: by 2002:a05:690c:3:b0:8a8:316e:5973 with SMTP id
 00721157ae682-8b07d3f4491mr48236347b3.14.1791905549799; 
 Tue, 13 Oct 2026 08:32:29 -0700 (PDT)
X-Received: by 2002:a05:690c:3:b0:8a8:316e:5973 with SMTP id
 00721157ae682-8b07d3f4491mr48236157b3.14.1791905549083; Tue, 13 Oct 2026
 08:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-2-jan.kehren@emteria.com>
In-Reply-To: <20261006092732.3577974-2-jan.kehren@emteria.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 17:32:17 +0200
X-Gm-Features: AclHuK8fFYJGwchqkgBzzPAvIv8pLLO_ePHfALgM1Z12wEa9EJOHQNFIvlZ9gM8
Message-ID: <CAPzfCAZp+gjiCNvS1gz5ouELvD4=zoTp8nyUG+dWyDOs3=C_ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] avb: Drop the mmc naming from the block IO helpers
To: Jan Kehren <jan.kehren@emteria.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: SdXZGwg0FFYqH1G1h_LSRL6Ze4KlkRps
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfX/0QOuu6vMUVk
 YQPvrjkJTrCtV9XhC6tpzObpg8s4xDTp5r8i3HuPOjQSSA415PgLF5ePZj0rLUJfgsAZwkY7hR1
 xQS6UXmBEfIXrhCx1PQkKJfMrB3BqYQ=
X-Proofpoint-ORIG-GUID: SdXZGwg0FFYqH1G1h_LSRL6Ze4KlkRps
X-Authority-Analysis: v=2.4 cv=Z4Z5j3RA c=1 sm=1 tr=0 ts=6ace4f0e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=HAEnkh90AAAA:8 a=EUspDBNiAAAA:8
 a=e0XDPsRHzy03Rgelu4cA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=LzkeyO55kmtmzvcb4Ayl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfX4tNP8EJHVkYC
 pv9tOiDTbp6JJWV3q/V7CW/QZg5NEYtZahfjYRutO7+GmwGHF+KM/clsmioip5s/4eRF7IGzksk
 bNPezohf1XBZMuKOv8luIBFO5m1D9bP6QRl0Z37vHxlc979LiAcYmzKpf+SyZlb2Cx0pt2NIfHG
 qfd8CbDhjKdvbOBqAuHHdVrE3XGsA0/f+fOe+fxk3zPB7vpGmnpcLjWVgSgrU+ZH14m1F8iJNG5
 /BmpUAm2cloc6RQzDkyN7WAc4q/uf0ZJHHhzEnsIsfnm2ft6cICp/HlwZXo/o6tU9drPT27YT6T
 2UDKdxLnr+PV26/QjhDIWyISmC8HOVKaDca93QMBLOfMNFO3Kgoug3vdpQ+s7FwlrmjlbiogDsB
 d23xh6tXJHyCFgwpnl4m3h+3AsfdO65dUXYU0c6xnrwoD/WgdU3zZRsBjhrSyJsg28BOiyIihPC
 5SRJ4AQ7n+3oLNUq/SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130061
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

Hi Jan,

On Tue, Oct 6, 2026 at 3:00=E2=80=AFPM Jan Kehren <jan.kehren@emteria.com> =
wrote:
>
> The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
> nothing in them is mmc-specific. The names say otherwise, which makes the
> mmc assumption in AVB look wider than it is.
>
> Rename them after what they do, in the AVB namespace rather than the bloc=
k
> layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
> struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
> The block descriptor field loses its mmc_ prefix for the same reason.
>
> No functional change.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

> ---
> Changes in v2:
> - New patch: split out of "avb: Take a storage interface in the AVB
>   operations" so the rename lands on its own, with no functional change
> - Keep the _and_flush suffix on avb_blk_read_and_flush(), it still flushe=
s
>   the cache after reading
> - Re-align continuation lines that the longer helper names had broken
>
>  common/avb_verify.c  | 106 +++++++++++++++++++++----------------------
>  include/avb_verify.h |  12 ++---
>  2 files changed, 59 insertions(+), 59 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index b96cd1ebd7..fc29433c3c 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -304,13 +304,13 @@ char *avb_set_enforce_verity(const char *cmdline)
>
>  /**
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> - * IO(mmc) auxiliary functions
> + * Block IO auxiliary functions
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>   */
> -static unsigned long mmc_read_and_flush(struct mmc_part *part,
> -                                       lbaint_t start,
> -                                       lbaint_t sectors,
> -                                       void *buffer)
> +static unsigned long avb_blk_read_and_flush(struct avb_blk_part *part,
> +                                           lbaint_t start,
> +                                           lbaint_t sectors,
> +                                           void *buffer)
>  {
>         unsigned long blks;
>         void *tmp_buf;
> @@ -342,7 +342,7 @@ static unsigned long mmc_read_and_flush(struct mmc_pa=
rt *part,
>                 tmp_buf =3D buffer;
>         }
>
> -       blks =3D blk_dread(part->mmc_blk,
> +       blks =3D blk_dread(part->blk,
>                          start, sectors, tmp_buf);
>         /* flush cache after read */
>         flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
> @@ -353,8 +353,8 @@ static unsigned long mmc_read_and_flush(struct mmc_pa=
rt *part,
>         return blks;
>  }
>
> -static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
> -                              lbaint_t sectors, void *buffer)
> +static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t s=
tart,
> +                                  lbaint_t sectors, void *buffer)
>  {
>         void *tmp_buf;
>         size_t buf_size;
> @@ -382,19 +382,19 @@ static unsigned long mmc_write(struct mmc_part *par=
t, lbaint_t start,
>                 tmp_buf =3D buffer;
>         }
>
> -       return blk_dwrite(part->mmc_blk,
> +       return blk_dwrite(part->blk,
>                           start, sectors, tmp_buf);
>  }
>
> -static struct mmc_part *get_partition(AvbOps *ops, const char *partition=
)
> +static struct avb_blk_part *get_partition(AvbOps *ops, const char *parti=
tion)
>  {
>         int ret;
>         u8 dev_num;
>         int part_num =3D 0;
> -       struct mmc_part *part;
> -       struct blk_desc *mmc_blk;
> +       struct avb_blk_part *part;
> +       struct blk_desc *blk;
>
> -       part =3D malloc(sizeof(struct mmc_part));
> +       part =3D malloc(sizeof(struct avb_blk_part));
>         if (!part)
>                 return NULL;
>
> @@ -421,20 +421,20 @@ static struct mmc_part *get_partition(AvbOps *ops, =
const char *partition)
>                 }
>         }
>
> -       mmc_blk =3D mmc_get_blk_desc(part->mmc);
> -       if (!mmc_blk) {
> +       blk =3D mmc_get_blk_desc(part->mmc);
> +       if (!blk) {
>                 printf("%s: failed to obtain block descriptor\n", __func_=
_);
>                 goto err;
>         }
>
> -       ret =3D part_get_info_by_name(mmc_blk, partition, &part->info);
> +       ret =3D part_get_info_by_name(blk, partition, &part->info);
>         if (ret < 0) {
>                 printf("%s: can't find partition '%s'\n", __func__, parti=
tion);
>                 goto err;
>         }
>
>         part->dev_num =3D dev_num;
> -       part->mmc_blk =3D mmc_blk;
> +       part->blk =3D blk;
>
>         return part;
>  err:
> @@ -442,22 +442,22 @@ err:
>         return NULL;
>  }
>
> -static AvbIOResult mmc_byte_io(AvbOps *ops,
> -                              const char *partition,
> -                              s64 offset,
> -                              size_t num_bytes,
> -                              void *buffer,
> -                              size_t *out_num_read,
> -                              enum mmc_io_type io_type)
> +static AvbIOResult avb_blk_byte_io(AvbOps *ops,
> +                                  const char *partition,
> +                                  s64 offset,
> +                                  size_t num_bytes,
> +                                  void *buffer,
> +                                  size_t *out_num_read,
> +                                  enum avb_io_type io_type)
>  {
>         ulong ret;
> -       struct mmc_part *part;
> +       struct avb_blk_part *part;
>         u64 start_offset, start_sector, sectors, residue;
>         u8 *tmp_buf;
>         size_t io_cnt =3D 0;
>         AvbIOResult io_ret =3D AVB_IO_RESULT_OK;
>
> -       if (!partition || !buffer || io_type > IO_WRITE)
> +       if (!partition || !buffer || io_type > AVB_IO_WRITE)
>                 return AVB_IO_RESULT_ERROR_IO;
>
>         part =3D get_partition(ops, partition);
> @@ -486,11 +486,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>                                 residue =3D num_bytes;
>                         }
>
> -                       if (io_type =3D=3D IO_READ) {
> -                               ret =3D mmc_read_and_flush(part,
> -                                                        part->info.start=
 +
> -                                                        start_sector,
> -                                                        1, tmp_buf);
> +                       if (io_type =3D=3D AVB_IO_READ) {
> +                               ret =3D avb_blk_read_and_flush(part,
> +                                                            part->info.s=
tart +
> +                                                            start_sector=
,
> +                                                            1, tmp_buf);
>
>                                 if (ret !=3D 1) {
>                                         printf("%s: read error (%ld, %lld=
)\n",
> @@ -505,10 +505,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>                                 tmp_buf +=3D (start_offset % part->info.b=
lksz);
>                                 memcpy(buffer, (void *)tmp_buf, residue);
>                         } else {
> -                               ret =3D mmc_read_and_flush(part,
> -                                                        part->info.start=
 +
> -                                                        start_sector,
> -                                                        1, tmp_buf);
> +                               ret =3D avb_blk_read_and_flush(part,
> +                                                            part->info.s=
tart +
> +                                                            start_sector=
,
> +                                                            1, tmp_buf);
>
>                                 if (ret !=3D 1) {
>                                         printf("%s: read error (%ld, %lld=
)\n",
> @@ -520,8 +520,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>                                         start_offset % part->info.blksz,
>                                         buffer, residue);
>
> -                               ret =3D mmc_write(part, part->info.start =
+
> -                                               start_sector, 1, tmp_buf)=
;
> +                               ret =3D avb_blk_write(part, part->info.st=
art +
> +                                                   start_sector, 1, tmp_=
buf);
>                                 if (ret !=3D 1) {
>                                         printf("%s: write error (%ld, %ll=
d)\n",
>                                                __func__, ret, start_secto=
r);
> @@ -538,16 +538,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>                 }
>
>                 if (sectors) {
> -                       if (io_type =3D=3D IO_READ) {
> -                               ret =3D mmc_read_and_flush(part,
> -                                                        part->info.start=
 +
> -                                                        start_sector,
> -                                                        sectors, buffer)=
;
> +                       if (io_type =3D=3D AVB_IO_READ) {
> +                               ret =3D avb_blk_read_and_flush(part,
> +                                                            part->info.s=
tart +
> +                                                            start_sector=
,
> +                                                            sectors, buf=
fer);
>                         } else {
> -                               ret =3D mmc_write(part,
> -                                               part->info.start +
> -                                               start_sector,
> -                                               sectors, buffer);
> +                               ret =3D avb_blk_write(part,
> +                                                   part->info.start +
> +                                                   start_sector,
> +                                                   sectors, buffer);
>                         }
>
>                         if (!ret) {
> @@ -564,7 +564,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>         }
>
>         /* Set counter for read operation */
> -       if (io_type =3D=3D IO_READ && out_num_read)
> +       if (io_type =3D=3D AVB_IO_READ && out_num_read)
>                 *out_num_read =3D io_cnt;
>
>  out:
> @@ -603,8 +603,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
>                                        void *buffer,
>                                        size_t *out_num_read)
>  {
> -       return mmc_byte_io(ops, partition_name, offset_from_partition,
> -                          num_bytes, buffer, out_num_read, IO_READ);
> +       return avb_blk_byte_io(ops, partition_name, offset_from_partition=
,
> +                              num_bytes, buffer, out_num_read, AVB_IO_RE=
AD);
>  }
>
>  /**
> @@ -630,8 +630,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
>                                       size_t num_bytes,
>                                       const void *buffer)
>  {
> -       return mmc_byte_io(ops, partition_name, offset_from_partition,
> -                          num_bytes, (void *)buffer, NULL, IO_WRITE);
> +       return avb_blk_byte_io(ops, partition_name, offset_from_partition=
,
> +                              num_bytes, (void *)buffer, NULL, AVB_IO_WR=
ITE);
>  }
>
>  /**
> @@ -883,7 +883,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbO=
ps *ops,
>                                                  char *guid_buf,
>                                                  size_t guid_buf_size)
>  {
> -       struct mmc_part *part;
> +       struct avb_blk_part *part;
>         size_t uuid_size;
>
>         part =3D get_partition(ops, partition);
> @@ -920,7 +920,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
>                                          const char *partition,
>                                          u64 *out_size_num_bytes)
>  {
> -       struct mmc_part *part;
> +       struct avb_blk_part *part;
>
>         if (!out_size_num_bytes)
>                 return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 66655aab87..8c97adbfbf 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -32,16 +32,16 @@ struct AvbOpsData {
>  #endif
>  };
>
> -struct mmc_part {
> +struct avb_blk_part {
>         int dev_num;
>         struct mmc *mmc;
> -       struct blk_desc *mmc_blk;
> +       struct blk_desc *blk;
>         struct disk_partition info;
>  };
>
> -enum mmc_io_type {
> -       IO_READ,
> -       IO_WRITE
> +enum avb_io_type {
> +       AVB_IO_READ,
> +       AVB_IO_WRITE
>  };
>
>  AvbOps *avb_ops_alloc(int boot_device);
> @@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res)=
;
>   * I/O helper inline functions
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>   */
> -static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset=
)
> +static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t of=
fset)
>  {
>         u64 part_size =3D part->info.size * part->info.blksz;
>
> --
> 2.43.0
>
