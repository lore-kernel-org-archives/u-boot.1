Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78200CC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCCF060746;
	Tue, 13 Oct 2026 07:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPJ3P5B9yvLn; Tue, 13 Oct 2026 07:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF8C0606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791876056;
	b=AvaVfn41CiANoWg+mMDgqL6A9/Lnd5oidP9aPYGyt9wZCxE+OLp5LYqeI8QwmVpq1ANl
	 /tpAhM8oO8VUSy71DnMZJK6TfxXbJ9Q+P2YqIKtht4zziRGOAWwpq9Pr+Hxd69gZtcLSR
	 rw6ElNnDYbEFeNUjwXBntTEKXAAEadQGqj/5bqAydEDDSxB+kgxoa2B16QH3JI52WsS5i
	 XML6oW72KphrikpBF8rRny9CspDSFcbh2o9hlH41PoXIWPlwO3kLsCI7xomInUyIDx6nW
	 /Gvp8D05KUTPQwXeX+NZzZVxypThpkBTJz3beZCb4IOxXP/tD20SYY7hDaOBymGrLvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791876056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=;
	b=IkRwcOieZuGIwN4HkvQhNHV49zyHgNdNpQlAFBOcztYXBJWB/OO2mTbBLfT40HeNjG5V
	 eJa24po//XzIoTwIbyPijru3vg/upXgzakohNNhP1A19QhBo+5BvB9yRInOm2wtr879v6
	 5I0CpfEmE7LTDIjSmVrhWlqT3v035Px+acB35eJUbk8pniEoum/DktCZtsaMeJn29lQke
	 PG2uU+BY1szHHIRWMy/bljrkUydp0Mea4eTHqyETFDf50oAc4otsItQgTnbmPLzA1GMpX
	 NvnRLZ6UtalkRuIoCsQdCegKwFpuPLSdrsZ6DR0GtSb61vSUj7Y90nnykOdfnuAUJTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791876056;
	bh=IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/ZrGsP5vmUoR4TFqvBykZamGazYnaL1ubJcN9WG12f9WEv+x7nfph1SwA41sAMBc
	 zG6sU9TsXJZ0uZF87jSZ11o+F16d3hJmFx8Dkte4BKD7/UardVK4dtIzMA0NDyPC26
	 NvjWvmfXoMD99b/cRDgBYeXB8JzYYHaD0FZhLPzr8EqKNIOK2eaZoOoqCpU//PUAca
	 BMKo/u2gst3m6E+r+WE/Tv36zSRw+XhkzKcZ7Tk7v+kkk4lxd3a31MvZMisS9Un6Ge
	 B2i4iMYFGexGBA7PJzsheLb/2LVI+xx6wYQw+3S9MGVwFdJxvxlHuBvJ4k03mrH6og
	 XpM9g2WPUfKLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF8C0606EB;
	Tue, 13 Oct 2026 07:20:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C40444DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A460E80BEC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrnG31YXLPrx for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C7CAB80BB8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791876053;
 b=ik+UC2vaCd6oABqCkKBx4qSvg5xsAk+wVh1Pqx+m9PLN25has0trj/F++ybnk0+R/mkl
 jJLdp9kPLBcdQHUpsDJESA7HmMMyb1vl6hoqgs1tkCWjqe6Mxm6P87UOm8jdlRNjyzuJ9
 Kw+doD6PAyrtCh/hoItvG1bs1Rlw2tk/0ubHT8DXzzxDymfxaYhLcn5UpekrT3HbRPpgb
 8UJNy9amTaTOnh5cy9ulVt98UrL8IXMkeWYVJCrVCWUJTSoj38Ts2ugVfoOoofdyUMaL6
 pHwwlO3Wyq7sd6BnBE1EC9h6aTtL/1WBh/KMXZOd/bCTlZGt3QFnlyYntmWWrdsMepA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791876053;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=;
 b=hVcQ3mEX/EhOSTuLBbRKbUpPDp/+ks370NG4Rjwl6q5EHT7UhASKNBqvmmUoXMBvHuKE
 Hwc8rDX2abdIkvXMhkAzT11Y6JVoeVv26ZQEmhNrKa9N6N0I+W9rHEsdHWHCC2pb7su3R
 5HnVMYDDI5xy44m3NeMflBcbu69zbUCZ9UXdrFe4e4uHNWP3j6UzTnXylCvQubohsO2DA
 JwohepH6+9zDugfSfuygR3hgHIRPT7+ejMPrj2l2nrq+MJ2e2mIuyMSn1HhC7YPU/YiOR
 TjggwfsLB138nxD/uv/o5k4zU7nmeiUrdKPSyEHX6pmUbknEfeiEIlIJBgFkbc4oo3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OORkpuU7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FSR+GXf+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OORkpuU7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FSR+GXf+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7CAB80BB8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:20:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D215GU924255
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=; b=OORkpuU7K4GxhuTQ
 DO1rMD8jHz6FpuH2ftUux7sgszXFg7+RAF63NiYQQWOJW5kLO6lq1pYJHzv6XtTp
 zxd7WCW/YdICUKPRAJDJCtoM7WKW7NnKMO32DxGrt0xklcUER+Ch01Gg0z6S/LIy
 0ysARp6yDaZ0yEX8Mjymhk0tnECAtVasZAtLpVryWstlNUWdo7itbhxBzsHQDH0F
 03w0GjzH6EorEtB/o0xXen7vZ3oVUocjPYj0P3JD5iFRrdmclFzcJzRBz01fwEYf
 ne4l2cG7L0lUb5ecynSWmA0F2JYM41o3/f2y53pDsXkNhIbdNIVZ1Gtl5dn1rSbG
 jMzQLQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1snna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:20:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so346259eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791876052; x=1792480852;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=;
 b=FSR+GXf+Qx7IbWj7APB5zIC7jkVualm3/LkFY+yDDB4rqvoWqXdorFJqeFdikltsYl
 Va3epNwDG7tw/Fd1zEsxbADHnlAlh/AGqQYa5h2DAY16S9JV6H4ISJLkCFS++IgkOsBf
 niwIMJqzwZx0Yv20Gel/AbtWBwEhO2YqP8hYzLjebWfuV9z96H2/dSAVy3Ky+/fxXzzy
 ho/he9mYhKcfBgwBgws+rMt3vZ/hAW2k8C/WkVjXU8b517H7ABLqkrHJiQCBw0hP2flY
 8es103p5HT4WrECFcsS4FARgnQOxbj/lLYs8VIDJCuwLm7xhv4oZjY1mnGXtx+4oWD0L
 /ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791876052; x=1792480852;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IZu4pEJzht0jJKaQ/DMBPYW0GweUZF4FD8VQLjGNcCE=;
 b=jO57i4RY2k2v0aw3CCXpfdX7ZOD6DLFK5lrI+TPIXXMe0Aw0+Sf7g+zsA9yiLVgFoi
 7a7/V8cBIK2oxFS36s+ErWwTVPQySk33d7JFuUSOcTCZiyKusyTtGCyD2KiTv/BeCjnb
 y9tEAPhk1nCfENWDn9iHkAV0GoscmF3q5eY8qDSGpEjTT0qgxLS3U06eyPhyUf9zvxPL
 6WYLtquUygT6N0LoheNB/0QsgSt5tNZQCwGXjay9E8g87H3bTOA5ZQltGSXsitpQ3xnn
 mUIgK3xA99kdYSsJ4SgD7epZb4TZM48EJELd8PzFh9iR+pnFgqVmktuC0iUoPLAISISa
 D6Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxQJavTPdS1jXB87E1khZEw8LEW6afnO0Bm8T/eI3KEX6gXN8yJTtXaAAXUWcxPYeY4DtE/Ws=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIt5tBUvopTTjDbzvI09WL9DwnZTToOcbKasdlNx6ahQYgfRAWd
 xYTHNzcCxH4vknw0hLyznNa9ALbfAtUIdzhAQVpE4ZZ7QuVkxWcYQyz/6iJ79K25GYzB0Hvr1w9
 q3lvU2vd/tCYGFc2iKfGDZ0BQSr0ZXzes3VoC65ojDvO5FZ0ILRAhCa/aUWBvV0ckv72NcxI=
X-Gm-Gg: AYBFou3ZLaDoLkSrZQ7KgL0sRBhN9iTnqfzxTwiMbsR1h/UOr4y9d0oobJwHQMNGeRx
 KVh+XHIZtasjyVWxhkR+/S83NR+F2Vc4HAaI4y1JQXEcbLR7OrMgAFb8Atl3Me6ZNJEMSGAe0lk
 ZEqMYNwmuF3NqukP4pCxBph7FYQf3xtCIIHE62xKTYBwEIJFIEYCYuhcgIOB9IckfJtd6/RyTDN
 ZUQwWQTx/+gFkt7HKpwTJo9dmjFEkUGPlaScJh3sCqrrIfM5FevZoDa3YGhmfyHwOFijGYz7nlT
 vNFN0LI8YwsfnzrLpgoJ5ruK/xnrwBjGjxiLfrwQeotg1tIPiqRCWodIhe+v7uTe73DZKNUuyLv
 uatMmpDgRkWqfhoGcEcxLNO+DF6w/RjU=
X-Received: by 2002:a05:693c:834d:b0:35c:8ce0:63dc with SMTP id
 5a478bee46e88-35c8ce065d9mr1260025eec.20.1791876051439; 
 Tue, 13 Oct 2026 00:20:51 -0700 (PDT)
X-Received: by 2002:a05:693c:834d:b0:35c:8ce0:63dc with SMTP id
 5a478bee46e88-35c8ce065d9mr1259963eec.20.1791876050245; 
 Tue, 13 Oct 2026 00:20:50 -0700 (PDT)
Received: from [10.151.40.133] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm39522297eec.13.2026.10.13.00.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 00:20:49 -0700 (PDT)
Message-ID: <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:50:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
 <20261012175042.GD3722450@bill-the-cat>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261012175042.GD3722450@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acddbd4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=cSziVDP4AAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=E2XaP98lQnNnkuzOwmEA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: yy9cgJrZpMSJu29jkS9IdNpKr2gzqavf
X-Proofpoint-ORIG-GUID: yy9cgJrZpMSJu29jkS9IdNpKr2gzqavf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfXzqN0pXFzdbIa
 Q+qkCEMrqF7QCvRjlr5t+z1PztHxLODnvyFRYx4+Ct0VxQQaWweFEDxy00Iw4EwbfDj66yPlsHl
 ygkm1/JJKk1MD+f6BCD++496t7kw040=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfX0NE/bZBEfDbG
 pg9XdAVJ+y8lD+rzx5ZrWJh59ya5JLCoF/URfB6kuWTjaVEeBobg/83oKP25N1cfjZDmniJ1ipX
 ttMAI2qOvBMh8Yo7dwU9LvByV2/guleG9T4HUxkTUqLFGq0IPYEqnF940uGofRKwiJr3By0OoG3
 SEcBH9BLbZAKPU3J5exrDMu54bSYNYXN7FtGfAigFc7efjlpyks4swG0Of7DBFxM0GzdjCuwofO
 k6GI/yPMTre0pxrvNtKVZdLTRLeSR27T1nXLLQJRByU6p+41u5pH+WLuHqlnCE8e/MI6zUiWzZH
 auW94XgiMGEKg69KV5l+HNE/ulF4HYu1DeoXY92dmKJs7FPCV6dLs7/g0llr+MpvMRB3iYg4+xL
 vso2u3BadoGDurarXYWHpGxqq9bHAiADy5K05FpjvI4dMfx/gQwbnwufAzoTMPAtiQtuK6EPZkN
 OWBSsKzOITUu5XXkOtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130029
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


On 10/12/2026 11:20 PM, Tom Rini wrote:
Hi Tom,
> On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
>> This series adds dynamic device tree selection from FIT images for
>> Qualcomm Snapdragon platforms, enabling U-Boot to select the
>> appropriate DTB based on hardware parameters detected at boot.
>>
>> Qualcomm FIT-based DTB format is documented in [1].
>>
>> The FIT image contains only DTBs, while the kernel is provided
>> separately as part of a UKI image.
>>
>> The implementation consists of:
>>
>> 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
>>     driver and qcom_hwdetect helper to collect hardware identification
>>     data from SMEM, IMEM and TCSR into a single qcom_hw_params
>>     structure for consumers such as FIT multi-DTB selection.
>>
>> 2. FIT multi-DTB selection: Implements DTB selection based on the
>>     aggregated hardware information. The code parses metadata DTBs,
>>     matches FIT configurations against detected hardware attributes,
>>     applies overlays, and loads the selected DTB for EFI boot.
>>
>> [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
>>      Documentation.md
>>
>> ---
>>
>> Changes in v4:
> ... which was sent as v5, and this is a re-send of?
Yes, this is a resend of v4, which was sent as v5
>> 1. Drop the SMEM cache infrastructure.
>>
>> 2. misc: qcom: add qcom,hwinfo driver to provide a common interface
>>     for reading IMEM boot cookie and TCSR SOC version information.
>>
>> 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
>>     information from SMEM, IMEM and TCSR into a single
>>     struct qcom_hw_params.
>>
>> 4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
>>     of accessing SMEM, IMEM and TCSR data directly.
>>
>> 5. Separate hardware discovery from FIT parsing and DTB matching
>>     logic, reducing complexity and improving code organization.
>>
>> 6. Load FIT images directly from a raw GPT partition and remove the
>>     FAT filesystem image based loading approach.
>>
>> 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
>>     related documentation updates.
>>
>> 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
>>     qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
>>     board-specific offsets.
>>
>> Link to v3:
>> https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com/
> The FAT comments in v3 were addressed. I'm not really sure the discussion about if
> this approach makes sense as really was addressed however?

Yes, the FAT-related comments from v3 were addressed in this
revision by dropping the FAT filesystem image-based loading
approach and loading FIT image directly from a raw GPT
partition.
Regarding the broader design, the reasoning for using a
DTB-only FIT was discussed in the v3 thread [1]. The intention
is to support firmware-side DT selection while keeping DTB
management independent of kernel packaging, matching existing
Qualcomm deployment models. This is intended to coexist with,
rather than replace, approaches such as UKI DT bundling.

[1]: https://lore.kernel.org/u-boot/afSXa7q7hJC_ZW07@sumit-xelite/

Thanks,

Aswin

