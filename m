Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890CACA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 847E840911;
	Fri,  9 Oct 2026 16:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6xAcBd0Pzxp; Fri,  9 Oct 2026 16:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6E6A408D7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791561769;
	b=V4lH1A5McISVNmrJkZDtmRhIOVXyjF3CseOhldBmYEIGqSYgB1fbYJSYBx4jFLrIhrqm
	 EHPY4kf9zSE4WAxf9iPFwZweXy0pMyX51udnipYRnLqCOm8Cbf4Nstg1L59FRXslOdv2E
	 TW382xF1r3TMyXBwPF6/P93CTlmb0fQ//veCHn0VuzyQY4Bo4L5+mCqaMLyHxxdKlVepo
	 3EZkfr4X64BaagIs1W3cGM3rHbY6iTtTzCqdnv9hAH0EdCnki4OdQrfYP87cpAegWB5aV
	 3CjLDmv+/1nzfo5vhohal00byp+StScf26w2Z7SW+JQ53PIRYaAhxRCiPYN0CLbmKwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791561769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=;
	b=kKLCUfrs71W8F+hUYS4xJ+TrXl7lQ8IogFs5pFz46D41H9YUDvIk/R6x2ICQfC9WwSDd
	 v/q1+YPjuFRuMcdPcyK0U+CGnLLQ1v/atfcERPym0hfsST+QusjVIligbF2VVlQ4wYFU8
	 XZkvuwHyOVsy/d9JCDjurCA/Ftxb93qec0bUDtMuKGf2Y6GgPCfXi3xWOj7TswQ5J78bK
	 5iEhR8jGw0o+yS3pPOn0gBOhxlN2s/WoOLJK0p7r+ZIoEiR8ruJ5wy6a/HviLkdravXwS
	 sQ1Np4ialb6n04VxmV6EgzRtIKA74zfm/nG9oSDJy8zsN/X7RNeMMRyknMfDxc+vNMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791561769;
	bh=2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSgX6/P0VuomVmGei9+3t4zOXycs4evwUs66V4F8F9Nkxqultpc3mB7p5qkpR24X+
	 /TBM8FBPQtvFzTmE6/HWpu5on3qf1WukPOF+ElRxFwLaR5JvId37z5NrxWTbsRt8OD
	 c7qXgZGGWzTmtfZB80dRibzy/9J0+wqPh05dpt93ESdAgVsQMuGPvFwDh8DLingouS
	 aXCtKI0F2fJeuLz9jHCml6JyGIyaj5H/8rM0CJv2YVa0DiGXllkaENSLZ4Y9MTnEpN
	 lD+CBbUmAyva54KB7XUE9UIBk0kgT7/2s+yiLOA6LSOke0TARWFN8PGOalrMKKVsNb
	 UqDNbIbbbcs5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6E6A408D7;
	Fri,  9 Oct 2026 16:02:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DEBFB184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA41D60656
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MjVe6Kp4xJ7 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCA796062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791561767;
 b=I00ABj/VbtR92CZGlxEUt/ii0F5zCU8J3edyIKZ2gC95rYIRj7qkxhG5nqLFLAT1kF/4
 IWS9CNL4gdM5ZKb10NIOzi05K2CVwPF1hKDxNngZ8zxMez7A8XtjynYlUzZE0eqjXIbW3
 JWE1uZzyFXHhmPjaN9/BTySWAidDRaQE0Up8v5MW25zcdGtD+JABvA0xZ/n3Tg2qKIk+3
 CYocFsHIQ05kxrqUGMn8vfyRT9NWHciG4kCi6a1aRUbkdxvrerBKEhtxUWyrgFUe0m8gq
 mxp8DuyqGXNYkeJRomUM0nadG49M5XO1/Clx0Uf9TEC99/kF+EPGdABIn/wN1vbrtQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791561767;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=;
 b=OfLSvy+wa933zDG12+kKrFJUUItgSsXSW+3qcqWPsl9ZjZy01NmgrHuZ1MSSEBSFKgS2
 kJYuxw/8nAfr5Y8i3i2I8uf66AB6RnrvIRAhjW2iLGG2pV+ed5Ugqw5D3+cdZ8Z40fbF6
 uw/T0NswrYSIP+r6oNjPnWmIsO+aqZIAvO8MP4An2LcX97xI4KZyljl5NfWCj5/I8l7hq
 oDVkcCeHbRglpCPVw1Ca4jBpntLu24JCnHulaRUjLt0hv0DzrWgBnnQG0/cV5ljxUW+nF
 DvO56Ce78EXRUsNu1tR+A1t54ZRXFNicAv8OSSu4oV675zDnONHJEysoogZOYlEbEqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LTXOZYtG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z1rnrEsl; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LTXOZYtG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z1rnrEsl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCA796062A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:02:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DkpPS1956611
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 16:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=; b=LTXOZYtGMlSXY5Du
 rr2GipVpsLACSrv7uWHj2Lb5QrYL6ILAPFMRicTI5wzCuNasdZ55atsuSjSPdK3H
 LLsWXO48AJ+mb7z2mx3CxIyvGSoP6iTpXMozuV93sQsJZWdcQr+WlDlsreiXtTTa
 fV7L+Pm1DDdYWLUoQZrMJ+b22X/cVciC95VGxHhsh8jJ6Z9hbXXsPHMukSmwIHXB
 KACFcbqPgMoPdyttCVqyRYR3Pk1HOqRVsGA42Q8eWAyTO3V6BXi2T83B8kYkhgMJ
 C9fp0RU7pbBeJRm+cDSWoNflhbgteK0JmQhLV+t06rJMdqdQ7j3G4U9XzP12NCZ4
 VK9yNw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f28hbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 16:02:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso4226763a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791561764; x=1792166564;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=;
 b=Z1rnrEsl25MhipejzlWZsaMGcyzmRS0eRKjyY/R4hWSRz1A8nNUyUhpL7iy64HUsPB
 5GzJztD3VQYVZ+73j8MgSB9+2smW7IJwz5rPlM/rF68g4dsyfpGCVpyVvEhGebOxA4Fd
 3JMHUSFF4W7/HWl3pQ3bCQQtHr6+PExcdiNouSr0Pr/yiJojQHSb+13ObbfaAHWnyr17
 TWjWuK9NpP50iocQGa1E7qiQeOM5Yn4PefraNtQEuoRbQUJf0cNUSrIM6Onqov63mXMX
 FkcSNpTt3zY3Bj/se0xDpwdEK7ipLwQ8grbehGs5dF1ZR9uytpQZ554qJSiuCMKA5UBk
 Wwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791561764; x=1792166564;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2D8v1ZGqo0LymYhTLsJaEbkm4mw2C4+IgOyaZOMOxdg=;
 b=GCE7cU7xxkBNF4fpYV7WQwS0J7/CV1F2iRgCioXxodQke2735scXmQEYoac6v8AjEO
 P4ES+2Gl/gjkqFpBXHvBqcgx1tZF+I16b+nr7SADbpGJDMaEQ+gWHwYipqa5BbnQWJ4B
 f7mC11NaIQZYeMpaSG85czuxIQiHFBv5dvrJ5AUWowa12/BSIF+KtyhdiA24DJ9Ofsm1
 +pvi69Yf22Gp3AORhKOvSzWy/hvXw3LGDMtYLunRfimTKxg7ERbrvcpU1sK7ik9da3aY
 buuTMvTIW7v8EHMAi7lTKNzY9TOFbEnam8T1kprcNdRWBpdihOr8NrmXSJmYL5x8xCQp
 rUIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhZn4JORFyARtD0TW/LVSo3M2mkRWarPL8PmlcxE1YR2OlbJN9549foGLWVZKXoU9qzLqLTKc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIeuq+AwqOHUohI83Vp5KCYMgW1NmHTPsSMNNflw/EiyKYxUUl/
 o0SPNUOCtj9IMvC2ZUT3fNCEWGdaq97NACL7LHY1txZnHOjZthzV3e8s3fI5yCQw5SsJJc320gQ
 9skxLN2Lw/4h+eZu7tXGYA4GAfGnfZPV0WhcEjKHyuBZ1CscvFBoBWuQUEHu8Dn7nhslWM7s=
X-Gm-Gg: AYBFou0XGiY1jgAhErju0k4MtaQZfGjVW8KrjBNn52m5ZJENAoofhkVELFZcUBrGaQY
 KzwQaQdzlic5JecV+GKfplXVJeVl2FXKxL/wnoFEZRX00hH7P7FrC2YCFd7ZL4JMaLScZRCsMQo
 xk4zmXX4Zj9bFPo/0/3qWeVUu8RUc1hqVvgr821jgJgpSk6Ur0URgwQQ5aJga1T+N6B+RTXbBdV
 qpWlyMeDdpHMJad3UjrvG7IyaHmjUmKZXV8Z/PBqeRhnlcAyyZqjy1iHxz8KHiRtObzaw3E7J99
 Bbbtr5th6MUSbEbWNd83lo5+A8dlGx3UyDh7M6ZBFjCp556fBmFF+k4AfE1+8ya+hCxcihFUtWM
 PVENoAfPdKkjBrFr900GbhYkXBHHutW8P
X-Received: by 2002:a17:902:d2c8:b0:2e8:18aa:34e3 with SMTP id
 d9443c01a7336-2e842ab66femr23017665ad.11.1791561764296; 
 Fri, 09 Oct 2026 09:02:44 -0700 (PDT)
X-Received: by 2002:a17:902:d2c8:b0:2e8:18aa:34e3 with SMTP id
 d9443c01a7336-2e842ab66femr23017225ad.11.1791561763675; 
 Fri, 09 Oct 2026 09:02:43 -0700 (PDT)
Received: from [192.168.1.10] ([106.222.221.165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422fa91asm12176345ad.81.2026.10.09.09.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 09:02:43 -0700 (PDT)
Message-ID: <70e53c3e-6ef7-4d15-b3eb-41342b6749ef@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 21:32:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: msm: bound the CMD_DONE poll with a timeout
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rqk5UfgQG663PmYAiNxAVcSWzAv6ICef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX65OLRgPSGBzb
 PQBl+tRf+Fru55LSEKk2xedoipUKSN29Xm/3qMQfYnG+0GqHfjHL5xKXHQ1UyD5Mo+hqupUwOn5
 5FZYi/231qUzwO2eVK0UDT9WfjYqpkYPkges0/3KXDyOGzlW6J0QEjX1+zu2qiTUVZxAe9TUQ3Q
 OHQyJ3fiBYbHoAl5cxCxFd1mNGMl7vstJGkZT5G51ut+zzCGxBp1naDnP79bHmJ+GEti3wni3xA
 7RdhmN7swH+L3EbTQqr81uf9ouZkznDUdnEJg1zmzhBi2auNvKrsy7tSe0JGGp//iJJx7q3cHQC
 5XgNsrCaaBexIVCE1XNb0pxj5jvorVasRqfg0LM9Tb1sd28uQB5BSq2D9rIqwh1Dpramu1ZNB7O
 6CKIW1sU9sf+uAm03N2vjupT9FVRYJ0Wij7cwV2SBQlQQQm6hMmTeaWEXvewIzzR9He2EEUTnGi
 kzmbiH8MaxReJNvkrfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxPMQZ2wrp/g5
 hupUbPlITjd4n5u/Fj5qpAPIPLctfGWXtP+u2hgI95Lkz4/RpSumcb6tl72Ir+6oaJM0c/KKNql
 wJKN4c4FnvptctxRKtqwVY0DfirLn3c=
X-Authority-Analysis: v=2.4 cv=B8ksQ+tM c=1 sm=1 tr=0 ts=6ac91025 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=bFRRxX18LbU5lqfmm7P34w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=dG_cZb-kSgFIE5o2tQYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: rqk5UfgQG663PmYAiNxAVcSWzAv6ICef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090063
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


On 10/3/2026 3:06 AM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
>
> msm_spmi_write()/msm_spmi_read() busy-wait in inifinte loop.
> Bound the wait with readl_poll_timeout() and return -ETIMEDOUT on
> failure when the PMIC peripheral does not respond.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
Reviewed-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
