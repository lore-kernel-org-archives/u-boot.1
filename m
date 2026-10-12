Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F22CA9ED6
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21F0C60725;
	Mon, 12 Oct 2026 05:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57WdlNoGF5Ap; Mon, 12 Oct 2026 05:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54DA060724
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781264;
	b=UFjyldpsHWLj3fEXMWhVa2Mdxp5zfDlMvtMFdXku0T+BrCyIoFruFhp3Naxta7lI3Moc
	 HP0GOgzIfTmh8VT1tl41UNcvjk/o6TTbAoh6+q3kgXL3DWEmXUcCh2uBukfU9Yl7WCHDa
	 YMe5dCukXoPUZJwaF4kcO2D8tfPRlohPwKqpkzv4XGF5MIvIQmKAwwWANKT/GK3d2Eawp
	 Xro4rwAseM/KGZHJeEf1/ITgsifmB66WXDFBiRsH+qEyxcqwuk5ypj6AgJvSDMyl/NxQ3
	 YxTe0BT2judOLfgTwI3kPYO89EgrFsa3om+IRI4B9kiagYfIk9Yx3Bq4n5AYkL2Dn2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	b=Rp/17OZob63kcmJQCvUGekMs0JuF9bbBKkni5Sz5pyCoifEqb2oAtz3u+pgEWZvMwHbN
	 toyf/Dt1BF97H+q0CDflMVaxIcXTer9lFfS+yxJ3ZrQqKH4WfahOy2EyUmR7P0gGtSH9K
	 ur0vJiWEGX4x7y7if6Ro33/ZsI48a3ENbierzxpNK5OGe9ijDYn0oI4JIqmyum8n+llkz
	 IdI/cZJ3VHpH8y9Bm40ftMWT0DPvOx6x+wsUwubwOmbN5OQR5xvt76k545z2vbq3dfx4I
	 i9DhcYSABoz/OzJVZqkIfcurskAzbbf+v4vqDGLMyzJxKKI38bszevcue9bXrYtZykQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781264;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ox0bqBIYSbFKHz94TaFzC2zNWWf06mFPSLF9caLhh0vdhNSCm6uv39xOe8tWptNQj
	 YERERd8pkHZJdAV3LXN0NAah0L+20BTnJqqFImOAQ+5my5KYfEG5n3S9ETiCU002Oe
	 1PDCDh57watq4y9pCyzt6f3StXlbM29QumeTWUdOrn87iTZdlQgLoDSjoiQELPzGIF
	 mv3UqE6GvxMwH/iQ4yiHFEoTXyhkYnYDl/SlBLLjIrNOF9ZuEUzEhiErCxndZ6jHcU
	 jHv+fpsXbNxEWrHP7fcGMCphwK2Z0FdcyPjK5VMZmaId5EU2ZWRKbWB6n985Uo8uB/
	 TE3F7BbG0Zu4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54DA060724;
	Mon, 12 Oct 2026 05:01:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CCE9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03B81400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qui1VhJzytUl for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 329DC4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781257;
 b=DC1gnxwvfHHxfZHoIgbZA86FoHsRin8+JNwKNkxAiVpo3YdYTtbCzX1nfIjjF2cHHE5F
 hZuobgtzMxHiNE6wKDToMOzmpYCHoqOKdWjBYiTipofrp1ClRQpURCHXSsIHza4N+GI8M
 Kdix5nWSHQHMW9keGGwwl7akMkP0RKLgRuKLTuY5n+OmvQQGC3NV4Niu8vE5W3zZ9eZdG
 pmekYNeZ5iIAmYcvil4wWEgkqzvWpU0YA5GRm6Wb1ClQ1OCf5jJN4JFletgVn6MrzrTuc
 8Qza3Xw9DDy7xOXBE3unYVZwfRm99Mcs8ATmmImxZ0l89Bo3+oua/dM+qLUel/XH8ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781257;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=W+IxL7blTdLK7PslffBndBwVVs4AQMiJwYnKI5JQUmOi+rUpxyEcckzMWmkhN9GWACE2
 mdGBQusjTrQO71HKUd1v7CGLbuOfzHTlTkhvsl169RSg/iSzaS/Z3Y21Q1EV5fSzj1hH4
 bIrXHvbnnQ0mHamvlcxeIpO9/rQnI7qu41EDNj6OFqx5wjghJM07nhis8VfLF4W7H9gUT
 IUno7R02Y3s0Jo306Qzyh3t6/eQmsZjoBOkMWvS77Kd/JaGyXa/7JTjiRMCt3aOycYIvj
 Hw65M3u6u1GXiWXxraRBGrm6M/EHJBT8ce+9/KV8rzhz+Yw5MM+hr6Rio6HLSEoVeDg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dlylP2Nw; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bjo5qPg4; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dlylP2Nw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bjo5qPg4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 329DC4002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lKem2015624
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VWuDDnKQ/kx
 wdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=; b=dlylP2Nwz2EVlch7/5fG85vlWCw
 kHx/ZGjLg5sTMTg+IfLd4JmuFMl1rOHm2k+pvGMe+8XliI+eGZ1fGZP2zYO8e31A
 nwchJbyqu7Wa8AOU4gwPBbioL/dElCa2tIHEzRFdNFW/Xw0eVnKAfS6wJMHaoHE0
 t5Fg+e32NMq9d0CtboZx/bUtL6s+l3ebGNGNQmSsMNoPFmTnZx2GHiIHICrIbBnN
 UCEapt52isShD4vpUKGajZhpzl+O49iT+EDmbNyfXL4hYjXGYLb/fTqvv5MjqYeV
 0L/7CIUKNuWFErWJkjDFjB4ivxNGjvwJ7vJkxo+P90AoqgOrFhOc/S7QyCQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2fd3um-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so4792100eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781256; x=1792386056;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=bjo5qPg4pnvaRiGp6u9z+I+QcyqWwZmkT2BesMkHT7xW6Z/avZHsimXdTqzv82VMCj
 Ho5SOp2DnU/N0P9wBqGC3PYfvgTHiDlLbRU+KxNqpVg0J8zeFEcU2a+cnYKiJi0rOcFq
 fCP53jNxAqFavWQfJJL8A6QyqoYw4kla+K9YuK5zXu3d/2vso5VVAENmAgcnlvT/yW8+
 lyHmFiXdz8dfvdnFqFPUdVNUbKlt5+DzTnGLQECbVkd5sydwak/y8GfCXOGO54By47Wp
 PQkRidjgjzxXUBZvKK+d+GDaenGPh8jhpZOLx/AqSB1/GJYvlSEIkRtxAoGfolpfIzRR
 wJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781256; x=1792386056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=qbJ2xh6wtr3iis8OD0b2nES6/Z7vYiOMMwoLD3OHVJxNmoc4UGvDpZjnEk0PvjPi19
 VPncU+/PBaaPAO33guXS8dbyKBuOGd9uHFidj7x0/ngqO8Fkuj/029ByfLBOlR5KdJrO
 k5yGs2NeVmR7IY+sa0nc4EuaosOQjDOBF6QS+HSIUmLws52Om726KDcPe5kkd5a2xziU
 JM1A+vmpA9BzN6oHW0i8KQpfixb5FMfkooxK/BOaWv0x3Y4XaGUIdA2FrU0xjO/UtN3D
 rOZz2muCRkfLgAVfpo7jFI/k+QsRB9MoZZQmzmywxuqDQBOdd+qMWgMCoCdLa+ctz2AQ
 v4dQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyjTqWVQe1I4IYKow+EbSICNklRKoHoKsxWNy3ax3Fcw0UEUbw5DWOiGPEbgd9dQOOJYJA8nY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLkriVwdSzbESo09eWrA9hEIAluo2wODyuZDUIQRSZs3P7+CQLl
 T7hVq37kZ+vahrTajRuABPFl0wZggM+X65VOdQzXgopkFV1BRjeQfhVM/kZkcR4x+yn7zIEan8i
 tokmQjWSHLbct2+WfC74hVoszGEeMDTDqdXaMPsO5f1lCXQnJUSxKWYQirxVrSIq9+BDU9Rc=
X-Gm-Gg: AYBFou2pVprmSBBxsZRsE3mxd9Hn4mev3EOWOLSTAGj8B2LzLoPlTYZaOph7Vq/Gsg/
 hIMF/mzsEcH+jEl00OaZH9RGPDceL+pow9dI86CfeuUgBAMhhGeyOHwhaTPf5dWF5kwnRx6L5QQ
 JkSNVDW7i784wel+BYbz290SPx7KwlqSSFEs0iVQufVOAOqdjqs9eTATpI3pBiQQyAJaCIZrLXW
 nhYVctX87fhymC5T8iZbXDUX51cgbhVmhiLbt7YCH2GQR8QsZ3mnvS2yxo1Mbhn2r3C/0tBkYIy
 jVDUbjg9XezHCJueKUWBUsOUCo5qZ6GrASKaaqYbEk2Uj0YjoolzVzytV3UZ0mCAFpOENKP9AjJ
 Mn4rcktmub44tvwdzBxXg7qnVmrZfOeZfs/j7nTXXWuD/mmk=
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id
 a92af1059eb24-16a57b0c43cmr12287294c88.4.1791781255528; 
 Sun, 11 Oct 2026 22:00:55 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id
 a92af1059eb24-16a57b0c43cmr12287258c88.4.1791781254838; 
 Sun, 11 Oct 2026 22:00:54 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm24317909c88.4.2026.10.11.22.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:00:54 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v5 3/3] clk: qcom: shikra: gate PLLs by clock source
Date: Sun, 11 Oct 2026 22:00:39 -0700
Message-Id: <20261012050039.1527083-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
References: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX3oK2JIjK6oyR
 GrD9cE3XyZpUQuMuVufiDxezZTscHGgK/PkmBwdiGkdJ1gwYTtWhLnp78mjIxeSF4umOvx/dbEG
 5zW3DTcLw1YTvZ+D7DLxVT9SVa2zYQU=
X-Proofpoint-GUID: VKh8OFY6qOU302jLyiqKCmYCIBTyVn_b
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acc6988 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=cbElVB0p0K_n_hLG8QkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX4UlOJCFC2SnI
 qswMziXaOFTqO/sZnL6Fle2ua4IqWDqWrwPcCYR9QSOYmCI6X9y6+V1MceajttFUkJt4odKQ8wX
 9iyfUNZEQ+VoVF7I77m5gzPYhNeXS7gqqIn7dXWl6bOG8z41Z40DizlQWEVzIZrRjYRfG5C3x5N
 Bovfrw+TV4LEPfLiecc4nywm2NWwFQa77bp19SDpuvP4Wv46p9/I8zqOn0djdLLnF1UTVzs+nS0
 rKTBS1bGwXAWIdRll4r0cUtnbFBPeDmFMUO6lYyFfWtm6spMIH6LIRHNH1fYS9xWHElU6CIoUK/
 lVcJV1u2Sd6JDlPcvcgala6fgtjtzJiEz7x99XNbaP0EMWh8c5CD4QnzYpy+4hlqo1zTqfSMdPd
 3VNResBALAlOdYS5PE9BhP38Foo8g2Zz+d8aaKA9T+EYowjO2zGBQC/Kox0qq3fqfoRUYMQfn+S
 YMORtEIpAiUGhswqGew==
X-Proofpoint-ORIG-GUID: VKh8OFY6qOU302jLyiqKCmYCIBTyVn_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120019
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

Select the QUP and SDCC2 source table entry before
enabling its PLL.

UART rates from GPLL0_AUX2 must not vote GPLL6. SDCC2
needs a GPLL7 vote only for its GPLL7 table entry. This
avoids enabling unrelated PLLs during SPL clock setup.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a74d529f4cf..72b6696127a 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -138,9 +138,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/* The QUP clock table includes a GPLL6 source. */
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
@@ -152,8 +152,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

