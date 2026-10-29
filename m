Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FF606A321
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bLACaZ0z;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W7V86Yoa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b2srJ4o/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A884A607AD;
	Thu, 29 Oct 2026 10:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92IZjZzLsxuo; Thu, 29 Oct 2026 10:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5348607A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271500;
	b=jSJJHapeEGbzLrvaX+r7rk/6aYaR+iMA7gFsdf0tMCs+RY1k8hANdUXLhg2RmEZz+39t
	 /c21HXXnxk10Whx8e3fI97K05KmQSV/RmR6r9lqTJ6Ex+/V9VaxupemfYiBUoPcFv8k9k
	 x2CYtLb20pSjHtfbKU9tPBpvMikVtGyeVsN1e+pSSmNudIAXqGY+Josy70lJJPT0ZG5Op
	 qzyAeliUuOKXboWC0JriZrNQiMbLGuWB3pdPgBUA7mDA9x2jVqnzQkChIjKUIKkWcj0iq
	 Ub2lFiJwIEs9svdDY7w7PLcG+3/3yGJn9QvlLt30Flt54nCGUV/Nz0ryjz1ZCpWXMbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pkkbTQeUVl4Enj41JHmxSN5VemKhkapguxxsrJYUR7I=;
	b=s96DmqsuomACbItQArLdqEnJql3Pwk8W8J2XmrWOc5ZyWwdxNrUcka1iJXqejk2PjqbG
	 pjPO8/lEqb3P1SXEXYNEt9h/hlgZwfTHX8TwMi3irZEYwwBIFQkYGLm1umWZeRNxyi3JU
	 rQk45p668UTxPPrm24UvN2zWaHHja9t/jhFNUlNoHKl0cEKQ39wOKNjG9H5m/gyfwFrI8
	 mE/QMTo+vuTzwmAwLuIaOgLLWkfUlUrDRfEHDTyXKFS/eY1zpFpovLoJ5+31CObTWI3pA
	 LQ/fc2zFGyEB2kipootJ05wZV8uqcn0Cgj1ME72gP6k/N/kCSdZGX/v2DEG/1XTtuzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271500;
	bh=pkkbTQeUVl4Enj41JHmxSN5VemKhkapguxxsrJYUR7I=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bLACaZ0zm6HtLGt2S/6iX/ohuMKOPqjMVRDm7gi68KALQPNrCPGlD05Ihl4+VG/mu
	 vSuoC9Y9fGKqBtB3KHk6oip4JH62mjEUb0e0vM4ukh7u2HIJWIimp+ANjM8QNhlIRF
	 1KG24GvFKsFM4KUyok2VsC7aH+h2Ujb8B0OA6n8KiaxyXeOKcJ/xvxCsTaTVqCsyWT
	 ytSbU5HcNu314iPKqPwsy1rd9b74gEkFqn5qv0sAAezRpCEfbxphC2ksFWdOMXnPSx
	 TORrLcEpf540dhXV4R5zxiyYW4qJTx0CWYQUhJsLc5Hldngq8l9y67ixzxQZieTO++
	 VCbQ2ZkBaQ9MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5348607A8;
	Thu, 29 Oct 2026 10:58:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08809E89
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEAC54032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rcZlWLzh1bvH for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4648540024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271485;
 b=CGUkiBgxZ8NWeVUfV5Ky7S5fQyOdytSHHvmScIQUvb5wwVtFmuxTmvtib0SBDX0Olk5/
 qz50FPqHa6OHfYY6eJuprcUlv9RPiSIJvKmjJMbQ0rcnH1khK6mfqClvrEdSFNE3d18Js
 Lk3X2y/hqCsIDTzguN0jKRVUuhx9ajx7Ao2iJMQEMACKRxaNoHrrkdsJK7/BHNuN7/flK
 FD1qcsdKrW/hRzDrOV388U6ekzNTKOctMXux5ow7j0dmhlhxq0SSTctTuopYsIDbANGhO
 CVcyHgnUvUsIEFppDsX1bu8cAuQozyu5i7VaPXmPAqjefj01+2Tu1PTMYdrnX3Rn1cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271485;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=pkkbTQeUVl4Enj41JHmxSN5VemKhkapguxxsrJYUR7I=;
 b=YaBHroBlNzyDmmdtLlZoBdIl34qarr13ftYHwLfFnHpKriG/PnDCYxKDQLXcytUCkRHD
 LETMAkbWd++jVah0S2req9VADsgriNL5pIGonqYy/tijrVuiT4AH9Dk1A1aeDPM+Hamis
 wA7AH6pFVo59s+hGNFi6sLdAZa8za/kJALV6OTQ6cpzmKP/a7mlS55IoUrO+CJxP6l9OT
 NUcMvHUwDl21qe9Uc1y0QFC0YgjPGU7wOFbg+VQJu8RlxLXKaGEjGm4tqGLH64p3rNgQ/
 wBn6D9vs9Yzw640lzZXeGEIzvW+XZLY4695gh74pL0w64panUKgXX4BW5NykFIJEX/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=W7V86Yoa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="b2srJ4o/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=W7V86Yoa; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=b2srJ4o/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4648540024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vDAe3824960
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pkkbTQeUVl4
 Enj41JHmxSN5VemKhkapguxxsrJYUR7I=; b=W7V86YoaNjXq8LC5J9XHnPLaFav
 sgKyh8PvB9uejV1ANZaK4yEMxQRHTygXobaUvh3DCXR7StFCzQSC6L/7cA5g8zkS
 wsfbe+FiAmm1+leOkrOU3bfD0YXzBW03FPOyWgZpGgAfbUquH2xB8nDS/NauI6Ip
 qDz3X89rfE+VDcuhbw/gW1EqwG8F/cCjOsKhq3Y6v/Crx8vNbomfX4nTBrvRnhvg
 YZrgZ9Dne+cjaaGmx1aoa2Uykr+2Pq87AXGHBHLDo04iM3e6NDDE0vh3ODkHj44n
 8KFaIS1TkyjpPAxOPxcziSguJ8MZeuw7ShJy5K3YdIpS/ZxiIAoYc/BQPow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3j1hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso4327167eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271483; x=1793876283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pkkbTQeUVl4Enj41JHmxSN5VemKhkapguxxsrJYUR7I=;
 b=b2srJ4o/ZLpxZBD46ntQUBHUCE0EitiDSs29I4ae1hFMUwFUBg5sl8sBm1ykOfSyYC
 WXCSuhmCAqhD7EeXNrb92/lO4OnLZrk3YPStR0VgaeVqvILBV/WMa7iYwV5Ba81j9bIk
 WH7EzHBbsP2gsI+Mgw8795EiSeLPxKOobKVDNUKFBzjEhbFOSSoFlr2bE5BmFWP6nTWm
 bxpLaE2yfpy3WxLtZpP/9okq/MXHYOURJCZ/S6v34XLtWzkwZUzd3y1GOdTnZSgSNYWf
 pxNkDjd4fpIcAaT8zw5IGvEsx60PbPaT8OeyzMpp/1YmbJbdbqcXnTqIgIBII36xvy/3
 BrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271483; x=1793876283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pkkbTQeUVl4Enj41JHmxSN5VemKhkapguxxsrJYUR7I=;
 b=XGn16pkuKbQcoSHkR59Ooh/3PKMEe8NfpRtGEWRela1N2fFob7T5K14E68OSshSq6D
 BkyTVqO+160wD+r1wPcyUAnjOxWjR92BBA4nL8A81tB/SQuEqFWjYW1exuH1CA/YTZuh
 4PL/wj+kiOvZiCEAHisBGG6lkHMrQUZAVepCvyMMsRZfBnORFHLksrZHjZKz7K9+Q5XK
 0IxIisYVBnVnkL2SQioYoaLVPdsgI2ynQ8nElaLtaFltCjs3sQZoynwPFfmRAsH+095Q
 fuvEUasc1TTTK0tc8Hff0kp13VLeD6GllLg7Ae4aiavwJtBaFf1r6tKoS0djvjIdoceE
 dYYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJPrF10xOAOcaY2va8TKSSLX9fjtdgyFAS8RaP0eE9TYmOgNnjw2YgksYnKyKQPieNGyKLk5w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIuxpqdhuHb+WXcUyrAmfbeEvn9fzlQzLw2YSDK/rGHygiICFG6
 kHpgrWFRmmLnbH93/aX3AYisS8rtLvqj+LJP2+bgsf8Ua6dT5XVlQtkL2xXqC4n//dsO2xGVrIY
 1MChZmH/EJcjvFMrThG3uNfhyW35TPDRDRuAz2Dzhx8hdXbSnn6wZGxqQOF/Vhup5+iw6v8U=
X-Gm-Gg: AYBFou3NPJ8IpYG+5wgCpL+I2r17Yp9QUJiUxVwi7qo1ED/SV8x+p7KdwQ9Iuu4u1EO
 ZTPjp37siXhtGA0HKoQz+8TUtStkKs+dDZlpuCYoVs9AGSrgFH3c37Uv0zuJsZIh+ZRhzWEl80I
 CpfEz3HpDuKSA+COeQXAZJFZ4rAU+aH+HXrr0AFcv7B3pdbjGjfbjLRQNmw8VrOKgvGqx9EqimY
 oeiD36WJTV6cM9AWFoozsT4uZLwHd50fRtL7pluiO/PHLBUMFto5CvmL34AjBurMxdK2+DqUuu6
 WhsC0LXcXhWDxElVPUCVLcQIDilSh6eF4uPzuboZr3/1Ek4fMRfQwld41XdcQ9XDNm6kJUBzKv2
 EIYA9V4E6uteRvS+QL1m/W6ZqFRNsFatg5WdCvI2R02fVPSbl/N7KTexDO6dmsIe+n93wM5EJ+Y
 1BxgndmE7FX71wR4w+Th0wUw==
X-Received: by 2002:a05:701a:c945:b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-1a6ce01d2c1mr5535336c88.16.1793271483179; 
 Thu, 29 Oct 2026 03:58:03 -0700 (PDT)
X-Received: by 2002:a05:701a:c945:b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-1a6ce01d2c1mr5535287c88.16.1793271482410; 
 Thu, 29 Oct 2026 03:58:02 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:58:01 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 10/13] board: qualcomm: shikra: prepare QUP firmware in SPL
Date: Thu, 29 Oct 2026 03:57:43 -0700
Message-Id: <20261029105746.3487456-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXzLNxxJCpLFxS
 QrNY/FQ7n7+UtOdQyxBP/P3mjHaG3Rux+eMnGPXAQ7RSni/awtYo8NGYlDBY4MWYEuZ2zTaT3av
 /iF8vNDZPsLiW1e/9WbnNwb23PhmxEs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX+v6aPIcYwtfb
 wbDao5AGUjNyOpJvC91/Vm5tsjrpStSQyjRUp6HUt/10d341sdF6E+XgK2yOojVwuYzJAgWx7wv
 f9gpjSWvObiC/Nt5W8pNjcuJ7VdNGUIZiOppFiactqlMDlQzglz1yim7c2cFm4ARzJlB6M4eFH3
 iU4xmsLAj8pnaFkquog7Ojqv6UX5gwuH+tP3n5a8Wym64T3P3aJoM0LTh+78PtvxCLJc+9Ryyhk
 NX4OFiZwUTQFhw/MiiLcHtAFT7J+tPLW9QL4AWtMky2NhlIX8VkT3HkbLh9GeL8VJpyAEtEYqd/
 Sjt+BlIdHYXiaoUzqH6fl0SKnXpxaNeD2Fy/VXB7unhMDPXmaHGf4vGsBYW/4VkPQZzcA36Q9wr
 Lk6V+iTvECJYybQPF1eTk6blAXxhHms72ke+38CUrwoYCkzYT9I/O8OIUqY5rm1aK6Lwwqz2O1/
 cIHQpe+NmQB5RNwgkGw==
X-Proofpoint-ORIG-GUID: XcDu-rQjzP_ZdpvmCbzJEP3OEKO8dKuJ
X-Proofpoint-GUID: XcDu-rQjzP_ZdpvmCbzJEP3OEKO8dKuJ
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae326bc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=NFnmx9rPS3rPVepk0rYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare QUP firmware support before serial-engine children
are probed during SPL initialization.

Enable QUP wrapper clocks before firmware detection. Resolve
the selected MMC boot source once and initialize it before
last-stage init, so QUPFW media preparation and pre-DDR
loading use the same source.

Make QUP firmware available from the selected boot medium.
Release the firmware buffer after children are probed so SPL
can reserve memory for the MMU page table.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 144 ++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c6327a14767..000571d32a1 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
+#include <mmc.h>
 #include <part.h>
 #include <spl.h>
 
@@ -144,8 +146,129 @@ enum {
 };
 
 #if defined(CONFIG_SPL_BUILD)
+/**
+ * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
+ *
+ * Enable wrapper clocks before detecting the QUP firmware state.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_qup_clocks(void)
+{
+	struct clk_bulk clks;
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		ret = clk_get_bulk(dev, &clks);
+		if (ret)
+			return ret;
+
+		ret = clk_enable_bulk(&clks);
+		if (ret)
+			clk_release_bulk(&clks);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * shikra_prepare_mmc() - Initialize the selected MMC boot device.
+ *
+ * Make the boot MMC device available before loading QUP firmware.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_mmc(u32 boot_device)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int seq, ret;
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		seq = 0;
+		break;
+	case BOOT_DEVICE_MMC2:
+		seq = 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	return mmc_init(mmc);
+}
+
+/**
+ * qcom_spl_prepare_qupfw_media() - Prepare media for QUPFW loading.
+ * @boot_device: U-Boot boot-device identifier.
+ *
+ * Prepare media that must be initialized before QUP firmware loading.
+ * Media without an early-preparation requirement are intentionally left as
+ * placeholders and are handled by their SPL image loader later in the flow.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int qcom_spl_prepare_qupfw_media(u32 boot_device)
+{
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+		return shikra_prepare_mmc(boot_device);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * shikra_release_qupfw() - Free the QUP firmware buffer.
+ *
+ * Free the dynamic QUPFW buffer before allocating the MMU table.
+ */
+static void shikra_release_qupfw(void)
+{
+#if !IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	struct uclass *uc;
+	struct udevice *dev;
+	void *fw;
+
+	if (uclass_get(UCLASS_MISC, &uc))
+		return;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		fw = dev_get_priv(dev);
+		if (fw)
+			free(fw);
+		return;
+	}
+#endif
+}
+
 void board_init_f(ulong dummy)
 {
+	int boot_device;
 	int ret = 0;
 
 	memset(__bss_start, 0, __bss_end - __bss_start);
@@ -158,7 +281,26 @@ void board_init_f(ulong dummy)
 		goto fail;
 	}
 
+	ret = shikra_prepare_qup_clocks();
+	if (ret) {
+		pr_debug("failed to prepare QUP clocks (%d)\n", ret);
+		goto fail;
+	}
+
+	boot_device = (int)spl_boot_device();
+	if (boot_device < 0) {
+		ret = boot_device;
+		goto fail;
+	}
+
+	ret = qcom_spl_prepare_qupfw_media(boot_device);
+	if (ret) {
+		pr_debug("failed to prepare QUPFW media (%d)\n", ret);
+		goto fail;
+	}
+
 	event_notify_null(EVT_LAST_STAGE_INIT);
+	shikra_release_qupfw();
 
 	preloader_console_init();
 
@@ -172,7 +314,7 @@ void board_init_f(ulong dummy)
 	enable_caches();
 #endif
 
-	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	ret = qcom_spl_loader_pre_ddr(boot_device);
 	if (ret) {
 		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
 		goto fail;
-- 
2.34.1

