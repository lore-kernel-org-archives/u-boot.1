Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2CBCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72B876070A;
	Mon, 12 Oct 2026 05:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlQHIAVH_y8K; Mon, 12 Oct 2026 05:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8633860601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783320;
	b=JgWpDNXF5qTBPSDv9A/9/P4Jk1m3vDrgC5muS1rErOOIPVrjed25it6cWnIkGLA2WBmn
	 nBxvhxozePye8ypuRcLnV9c08ZeNsQLOgxe1rPBdGSmmyRhNeYodSaFyBkYIaA2LYPEsX
	 QKU/Qk9o7qefUdAgO9LEnjMLuSABHwEvIbk58v+XVQspuLWi45d6wVUG08qzvvSxJmnMZ
	 fF9dBQUMv7F5mQ1rWufyBztah9Ch5Z5z4yNDC54fs1KGBjdDzcuv3/2RNKW/L/N4DX08j
	 x03M8qn2KRUSWseM3dGtlx6l9G0/njUpg67PMb0mHTp+4gETAHOAryLtZcVNAiyW4iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	b=XPqzNJS4aX1qRGQ6yvSh8/yoVP491KB8OMngCkjp8qg/BmcFqbd7JxfUiOtXIhlWk9CT
	 GFwv/CZ/cdyZ3HTZpzY5nnmAmWbzX3mmNrWsEv5obAA5mXDF4xoN+lsHZ2ywkdGvELEtn
	 do0njAIid90Jrpq4aAhvRqP/t2W/9akdcUBGL6N7mR4XSBD49qmhv1CCyZQ8jHNkATHTP
	 J6+0VXeBV5TUGm+RKkN0lESN9ZMe/fs6xIOMzDgZ73+39Gng2qdttBycSo+VzQfWXwA8/
	 DhebEYfFMYca9B7UDrhN5ghmIs+Z36EGl1TJQ/8xXI9XtA2QrRkjjVwgopgp4m19T4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783320;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A43+W2Kf11P1L8Bch8Z5GG0+ipHMGEhBnSs/tfXRsfSe439QmnUNNaREZcY5eD7ES
	 OBiaTtHQ8uG4qmVwEhmttERyvXZyAj6xwELwc86uw4qKH/+hPr+EWcYu2db+GCt339
	 v5DMsC3vQCojMX+1nvZ/qRGmzEVd+QwxsopT38CQl2QFxFVCq2A8rV6Y4lKliUnNw8
	 vbCD2shVapP9MD5R9qzjmkBQCyoDl7akYw7y+UuACLUTTs4es1iR2EUt1gmzo6Iclm
	 P946HjLYHqcsXvtWz7nCBWbRRooh/i80rPOvQ1cF2qw8MZnGDPdLQ5bmFhIKpPjC+x
	 pNavVXSFTvs6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8633860601;
	Mon, 12 Oct 2026 05:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D397F2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B97C1405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYavNf22m6rp for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0343A405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783306;
 b=StSr5jKRGwryLnpOdA4qhfrAEyWrkau1BbvOgLC2dT14hHKx5u8QEkZAT8jxk1zqSlgO
 2g+0E0tyJhxbXkUjlVkAGOgIaLgRqFsEMWmXJtCLBEkY4+UztwgXWNqoJZZsdKDDNBYtp
 GgdRmcFrP46e4KVijBTwdcCHwHeKNmder8nzhurDCdrmU0fLrUvq/qQg2c96sLDvIdYb3
 cQvgTz6ICkqcmgVU1gu3Z5Tw2TMDAsqnSe9EL7retNSMxkCt+/vzUGSiYTrcRZRWbX8AE
 DypcUkOc0tze464y6jno31KOo3UTRvqQmj5eljzb9TGO6zw9qlJzpAzELw6h51LQIFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783306;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=Nv+8S9SS1kkFZw0g8P70loYnhJD73W2GYFaOOeKuKZCT2i1kANf3wFb4tyLFd/JIRLmK
 chOrIyPVXCImBcGcGLc1oKLEbeKzWBla6P3DStQq5gLG7Atdyp07+f9kQ1qdUN3ccoOe3
 b8bW8j8pINlMVOfiVYquzVEQMhUVFUxQkrRMlxFawoIDXVjkgF6tf8LSjl1ezrqceRjML
 sVlGfCt/1KSN45fMjp5ETtyBJxlKcE7Dbbtdf7WB0FHWittOcU8NPZsRGXcdADgH/TNOH
 +OVtTt9QSFfvFagQrSuxPTcQwwXNRwtnI+RPVrFUQVz8jUjkRi4MjsQpLsHR/Bq5YTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TwR3AJz1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SLImSzpC; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TwR3AJz1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SLImSzpC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0343A405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55chu1314446
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/O0iBQUnQd
 JzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=; b=TwR3AJz1aBzYoQM5JTH3U25UEe3
 p/043TKMzg2qnYRfq+2fQ8IFEQlCKyokqFTkp9PpoY3IJzDD88DHQoaCzf2fU8YG
 jf/iPASLiA7bO00GVXZ1z9TaG74O5i71dECt+0uhk/hSN96H/Njp19uok1C6/Mrw
 mwzrY92jojlUJGsxicxNb1uf4YtPWjAfX/NQJguATbs3GYnlW+5jQgzF1W94Qcc1
 nEtROAjO6t3aO9r/Yg++efYqJ36Du4mhJvGUJ+B1pEDPxEdz1qxcSVxLuFcYtbJV
 fCyYLz39RmBIY3gxa5zu5N/0jHVdepMmOiAzYnQkGhEhY0CVN37vt1hxaxw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j7112y2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so2894810eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783304; x=1792388104;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=SLImSzpCysihneVgLyKSdgNgKUFbiMOBRxcAdyVKLOdTgSm3BXLWU0i53Se5yZ+2hY
 sDmHIfGGz8Up4DnEF0qsfjcBHEcwggV/PWCm8NPHpk5QcKHvbLU1GKgKweIzia91KJiC
 cAU9PDlFwT6GCuF883Mwbfr/RyAjgW6flv9bT+Qe7FyTvvCAkgKxzXM9x+GS3zvr3kst
 9c8yusfPdQfsvp5FdXxj0x2VwPDoQ/32CbRCp5RrfJ7iIA9eR8Y/xn4rUYP04KqYxFFn
 IQc3UwHTMxE1L3g50UdTMfCQ3gdBuuGQmyUnE04a5JCJ0IKY3BQ5tpy9RMx11Q99w4GL
 eOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783304; x=1792388104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=EXPb571IOFD8U0WunDvyPWSH98hiyKQrEMG8qFD7HAYP3HEns+HfA1cKd8nZf1wMy7
 Gh7JtkkA9bmg3fRqAchhhHlbskykVnkPjJKsTdfaV5eL6euwxfsdIJjN8vTvsUIAvP/A
 Wvg98Gv8hc+dxljLOsjmCrI5UdcZnQc+Blx48vMziSqNq9tmrTSbOTsp98zXSLe430Xu
 09uzQfc18NMfKbDG4ZzCbp8+zvzW/rOEXHxeN7/wTEA1e2p7OHcHQA42BXTJMDPutFHq
 estTIfz35cVOlsB/gQN18K/TGqPwS+7eBkTAvO4cVijz/1zHb40axcD+QQOwAb+uQrbP
 DoMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzavrkKVMdolPIuYyFsWdpAfskwiz8JfVfNEU3nn9MC2+STPUkLh4i2gIaIUM8euKHxCL1YlhU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZ9K6eWhitdh6ED3reo9hA/4osEIhPHu9vDhUz2yIoEwXloU9Y
 2UHVzxnUNfZQHozJwIyRML0i7zxCm1Zu3uOfoR2BYDtYe0Cu9MRUu/Fii/cor6EVAgSSE4O2mL+
 r+t76F+123mG3LqDa7ZFXZK4zk/YguOS3iBjhibFK54rOpu/9Ram1wVvcroCr5TqrG8rk1Z4=
X-Gm-Gg: AYBFou2T0iz63nXo4HN4gfMhaYJAAbgWRhEzjiutFVxZ6KTI0b8Vq2WZL5EHU1Wp1Ra
 uyAMSBv+FVs0vTdN94w36ECLpri0PPJLxtKQQ8dlKSVruLn87JL9xOz8S6VYJJa7+j8jXdR9+fs
 9EXC7h188Zwyk6e8fuLwxlpKd+6NzRa2SI5daBSGS+uBZKwnDGfyD8e91VTeWKbsBghqhSmqVfZ
 wgOecn5M2/9IulNQcre0LYAxglI+K5e6Ql17owIuEjy9Snr9G+CisArqfAY4hVmubPm3K7g/R2v
 7fAqzxaVFsiDstt2XOvYqQwTtV6bTvYJsOnobXoLv7ztKGrWnwS5vlOaAaIroGVrh9GVJARSKTY
 M+YJ7/EjXUSH/Hp0E/N5/ek2/BdDE5fLxGBIaeWlNvjrPwfB+
X-Received: by 2002:a05:7300:7fa3:b0:352:2e10:10c3 with SMTP id
 5a478bee46e88-3537e0858edmr18947934eec.36.1791783303536; 
 Sun, 11 Oct 2026 22:35:03 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa3:b0:352:2e10:10c3 with SMTP id
 5a478bee46e88-3537e0858edmr18947885eec.36.1791783302994; 
 Sun, 11 Oct 2026 22:35:02 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:02 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 06/13] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Sun, 11 Oct 2026 22:34:45 -0700
Message-Id: <20261012053452.1567885-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX7OA/TCUHsDSC
 EGsu88ENb+/KNk4Cw5+4LpW5x8hmV3oKAZCxKwTPM5LsveRzU4Ysz4vDHaGmHjeg6Lslm0zt1S+
 qZTjoW1lGWNt0FSHpltku8yeWKRbfKs=
X-Proofpoint-GUID: n1nt9dt5fwNpP9aJ3JNISZ9LUj4nanDL
X-Proofpoint-ORIG-GUID: n1nt9dt5fwNpP9aJ3JNISZ9LUj4nanDL
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6acc7188 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX9cTK3DcrUlf6
 /vd8tF9S5nkwza3DzBzSBmvlenSVCWeKGFnHa1s2UXl3naIEVxs3xUQBa8DC4zK32w0//QzQzYS
 dpK0YUL0NGteNKwsb0za/nwIzEPZ8VOBZzJB6NR5X0xNpQ0oOq/b6R2SO8F7ol+0MkG2GjHU8eq
 KWj9SVe/OtPrA8l5HH7O0ubBb4XaMnJozHS1MvsiG9ZsWgtRf8g+v/b5zfOPSyOfSmaPcPG4AU9
 bxWtlYSfGj3ZtXXIYa5/nKFdA/45A2An4A/1U0QRUvzQoPl8phGq/wVVuz5uY+JhMoulA+zYI2Z
 V353+b2+T2vI2gUNoboG2YqgYqVYxjyqFRPm0KyU6WTBM7dCXls7SZDS69iJj6SgyQwJ3YcQ0MI
 hbNQjZu2ZFJawP78v9K4kUbpH6OQuSQ77pLfjokXAQtR56S2ZL0qMNN9zNw95j1V8XrAnN8V/7o
 c/lMpIBdr/Xgqc26tkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 2c3c5c9b4d8..94501b838fc 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

