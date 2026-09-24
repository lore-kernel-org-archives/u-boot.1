Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E48C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B50A812A4;
	Fri, 25 Sep 2026 02:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBubGfKJYKRP; Fri, 25 Sep 2026 02:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3474981286
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304109;
	b=Wg55PEOG8q7zBlRjMfVU5mKfmTPPMXQscz6T5+sCJns6djlVyVoVQKRGf4l5UvT/JFt5
	 wtabem8b2tmXMPT9OhFgkGt4EGyUhjBEEev1nTJ2nB/2hHTUCYGWzB5wJPpeOi0cO/Lu7
	 +/6LWuFGyGxd9OPduG1fsq0XnN+Yf9VPlt3atooNInUHdQDtZ3WKuPUeljdLiA9a6vaUc
	 KS2YF8QGMdS+MV6bQ/M7JEUR9Oc+m1D18CiDNaHi1BWmiplOEdwH9AWMHdLanO8ejojAo
	 kkbx/jG2Gpad7fmaxvG2XE9+LY17wz8jGOo0daVvXBSuIvKW3B12w5m8H/9d0xsyucQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=;
	b=sMRBn3hJ7yfNQEBoes9e5M4LWdnAluqriv1X53THD+7Vpz1yYyBktgKlojrBqM3mMOds
	 FLVf6LVPObgQMkPtYnKdnD0CeErM0tr7jA9P1ynKnw3vNfzV0VkkSFYCrT3cmOMXEdH75
	 ymUQTS9ikFdRhLsrpxJUPU5bFaDcs3SlWUrofTuIYBaXWrP/2MiXSRGVXFyNFTCvjwUj6
	 MDqZfAyPbslJkFCmaFKsRG6lkOYn/iNaOPHv1yVq7y0xMaMFGMMg6tWx9iF+xJhrG29oo
	 9tsCoJow5WFuxSbeFlHXrfHW5Nqscfg6D5HDbrzm0kebvOizM3Xr3WDNUHiE+pAgSYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304109;
	bh=fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nt7m6yLxFXhqpuOuLsJ10VRDSobo+n8wLqCYjJShaqjHprzXn0VeEqi1VDsNW8br9
	 oaGrPn/VbxC8/D0wAdMvmbGeFKcpHcKlbDQDLu7+AaZjMmSEF2RJGDIqA/tfnxcFmW
	 N2Z24tUBoTMe+FRxK7/aPOPcxvhF8PZR66wbpqgFkmg959+fyR0fRe74sq61J8eGWp
	 abBszHdf4MZXGR3qUj7GosWSAiZSSMHStJMuXwWGstU2mTAzDBzFkXYtwvGFo2huLM
	 Yw+k0mSeKIvBARJWNi+FN5UgixKc2sd+Gd5gQ8+60notdZ2RCZFX8ylUfPaeFJ9VuS
	 4fnrdSkvVbvjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3474981286;
	Fri, 25 Sep 2026 02:41:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BE51355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61D374017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJDzUdwgPRok for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9D12140079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293094;
 b=H/G06NOuVOpChy+i20NbS+rwPDSkjUu6MkYHrZC5OFyel1KmwwZESRf6Gssg56qSQead
 eauDRoJIoazmq+GQaH0odCqklY7O5ld70WN8ny4P4eM9IbuOHa7jN2eJOvozNqc5YXasl
 9Mm+pJGblr4KfWqY7xm6liJwhg0Hk5boeijJlLBhrXbhFg8giqtSNtI5oteA388QkG+pj
 9wo1sVnpeQkeCuD74mamTnSX1LjCvhwb3aZmKx+9Q/fuWevZukpLlWz6MIE+Z7doBEeRI
 Fa9oZsZKDWD7tGQ4TwRC838w6gxTUBjqLOZNmkNNZl+aHukQ8atsDxGjr6hW/W5gEXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293094;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=;
 b=gBzAxheo2LsCIgk3ZejEelZbzlVESltoAvNlk90iQw0ZZ4QUtmx6n1JR6Ha336y6XVAJ
 StTZD2JMISg8cR65x60p2EEaVHmto1DWPgUOqAFdlgIk5tyIDLCdWtlWH8qB2iaKDU0ox
 oVc9zxfP1HMMejG8of9eVc+a8TRfBWDI5NjAxhRFAb8pGH3LYOZJV6VSCgv1NlwjfigT9
 A5RsQZ7RRbzl8rMx7MGsdZznL4SaUMZOmlvmDTvcDAzDHfUuK33rNMmqmsHANbKbhgPoH
 +IvpuGyme1Jt46HaQtW1f4XYH3XGlhNx0g1HT0+jexNKdRZTelp5I8ZdQugtrxgNyhA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Bxk8rr0N; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q5yvLRQz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bxk8rr0N; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q5yvLRQz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D12140079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:14 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMP2CL429566
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=; b=Bxk8rr0NfJq7sglg
 EkUWVCtWEkbKMir7zYtMWSExaM1h9ZLm1N/RYBpXh0RjjhmPzA+Y9xEISV3sDzyF
 rNUEtj2JA4lZ1/LzJg8NwGS9VUbnAtJX1hWW1m5FrM3wbDZVvv2gsu3tRt1kTVxB
 fOf9xNBAtbUYQUQelXbR/8gQEknH4PAKYwMCqXqYSdDsX7+OUeR5t9PEdIuoSfrN
 JzaUCXh+qtcZZU+DYqC3NWW7cCofcZnnkpOi3x/6qbwDzIr8XdGjTG7yeOSkA4b9
 Jt7FRa9Zoi+7EE+9UTp53KyTpOx/0nHL2W1KeYFBSDqdUwwNjedd1sceYNdbnRZn
 Jv7JiQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw874h8wc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:13 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8865abf21fbso5212807b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293093; x=1790897893;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=;
 b=Q5yvLRQztjvL4KaxJLVOgFMCqGiJ1PsyMIcivT+qqUXaAq4oOWaD36L6hgkRh0ByLq
 fjG1OT3wHEw1kfeRb1sYQoKk1LOOsLJEl3yWdjrtfaEdQLvq2f+2uURVk/tKIaoFvy2n
 CP2WEc3tg+YVVM34rrVN3HHysn8uJw6nrc6eV87kMXgc9jbWi87R0I6/xdSmP/Hit4e4
 BeME7LIOto2tm2plYXv5VDmiY4H2mAchwt1QsmirXFeX0y1vrbgRjW96RonZVOL9fJ7g
 7hDmiw7UGq+w9Btq5G6GtYhBTADImsfczZyPQiv7CiTyueXHodaVYDQiR+RqjqmDiD6w
 o07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293093; x=1790897893;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fYXawZvgJaytuWy0jgrBMlVVb30xPiL4VIQjbnnWKbU=;
 b=sb2Biu7jZd747wMgEH+iU111uIg5OXYHjWXxJT2rZA2+fsz94fjeXOle4cW0+Ck1hN
 /R4YRGWNtVpXZxOfWhgtFH0FzCwzkjERQyeQqrEz5eL2MkmHSM0Ql2JFd52Gz4IrcMAD
 3bbE8HovcitiMb4bX+c7QbRrIqI/Sqc/svrhRtNFDSToXaq8MaE9gvsnxl2of9UD1Ky5
 LeM+ti07F8Afor8+KyczsnJeqCslzSCxUYisBIW5SribQf3VonGUdAVTJ0nM7FGZQ3yg
 bBo1Huhey/cdMAfPAZBwlbai/2jKpI79bg8LwYSEweHSWqPIYSIqZqKHvVjhVBK5kR/g
 ivLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9hjnsg3Eda/7ISS5vXQ86EqC7GFv/IXsvGuqcD5syHf0igyfySeZ6q+tRmvWWmVONAwEDyic=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++maSQHAbZ2RauP+rPq4ehk9cgx7U3tmNbhUyWD+VDQk3+ye1cRI
 df8hpSph3odduHAfgLAZ0PmcRxUJqyu5oFELw5ZT6VJT8N9g/M2arQHUsROuAoo0Hl0vD51C4az
 /2tJQ7nQOW5m/zrzqYu2U/RUUjS078iOCRWawKnE8aWWf7//DKS4fS3w7cFrKybw7wVxrKgU=
X-Gm-Gg: AYBFou2h6JaOPPPu/v5SMw3o3I+JqcsgkemHgqFLb7Vt3XrQco3/w1d+2W6JBvP2NXk
 XWIEJspg7Uh0b9nEjy3c6FaHT9L0NC4i69pzQjGWNWJOntuNcVEC9CitoTqq4usmvet6Cmbouu4
 TgUBLGQkpXkLTFXgEg518dGpHomMSzdYZBOb++dnLwOEy7aD1YGPoSr32U3M8Yd1HTz4fnqRxLg
 deMFF0eBbQNhB/JySbfKHMeHgSTa+Qp67kNI44tyYJeE1EptBNobIx4y30qzG1Qs9il5VN5q67W
 ZfCBKGl0clBCy4g9ESEnN8LrZSPQxW9myCd+FiwGYfEZHUJFhkO3Ti4QmPw3wIn6x5QQOfUAfzy
 Sdk9+hUHUMhcJWwo7Y0d9s9zy//12aSLHL1S7p/zyXadIyDIqua53AlOhk4NHn2BLryeGe4DF
X-Received: by 2002:a05:690c:dc7:b0:89b:689d:3a76 with SMTP id
 00721157ae682-8a649d6880dmr27819827b3.45.1790293092568; 
 Thu, 24 Sep 2026 16:38:12 -0700 (PDT)
X-Received: by 2002:a05:690c:dc7:b0:89b:689d:3a76 with SMTP id
 00721157ae682-8a649d6880dmr27819707b3.45.1790293092120; 
 Thu, 24 Sep 2026 16:38:12 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:11 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:07 -0400
Subject: [PATCH 6/7] board: qualcomm: add Arduino VENTUNO Q config fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-6-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: T3QjvbU4g8ruMHm4XzgigY-mus9aGRZa
X-Authority-Analysis: v=2.4 cv=MI71C8Zl c=1 sm=1 tr=0 ts=6ab5b465 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5u0P9Ep7puccAvQJcFgA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX+ersN74Iaz6M
 tWPtgUinE/OttFk4PgFgaxuhJ9kv/qOwWBS2JUDJlt970v1TH0j2EJlS+ml9biq/bAmnXJXTAbe
 EtxpquwdDX5wM9jhBKCeG4+h0n8xvlv+CiF7oWg+6dQiUfYAR7ngnvP2d3Q+B4sAYVaREeid3iP
 zw9arV6CNWbZEiVGxoXCGZ9u2pGrvT9VEmlLIna5Hcv9KBMoOp4AtnJUFmdCMu307x3PdlK0CUl
 hNCxnJb9Gy+YQfmue/Yo+XuRg70ITGnJhsaIHT+mV8SaJqLPPfbdYgQ4fK4Pxu0g1FaCiJ8OQAW
 Vno8xf9drarSHjn/nQCC5GFSVfiFY8OyTOkDb2yOjZyxWpBPebJu+iap65KeBLUQ7eK6wQ80h1Y
 KlcTEwFvDxyIo6r7oOTWgUbH+LTK9Rdaxipc/lMYn6txS9tVUnvi4+bzYLuK4bEO9E92eYtmJj6
 CSohVdYbYyG5+jXtHnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX4ZJTf4flpEDt
 qiiqRp4YBYCm0mujtQ4WBcGyHWyNmGoShWB5JskbQPHG6zbwOMpkm7UCxBOBGd9C80kSlHrQZvT
 UdC0BBwNS/+JVqCw5bFknYR6AAN4WdU=
X-Proofpoint-GUID: T3QjvbU4g8ruMHm4XzgigY-mus9aGRZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

Add a config fragment for the Arduino VENTUNO Q (QCS8275, Monaco) with
TF-A and OP-TEE, to be combined with qcom_defconfig and
tfa-optee.config. It selects the board device tree and moves the boot
to the first Cortex-A55 (MPIDR 0x10000) with BOOT0_QCOM_BOOT_CPU.

SMEM describes all of DDR, including memory the Qualcomm boot firmware
keeps for itself. Add a /memory node to the board -u-boot.dtsi that
leaves those regions out, as qcs8300-ride-u-boot.dtsi does: the SAIL
safety island memory, the XBL DDR training checksum, the SAIL mailboxes
and OTA area, the pIMEM vault and DBI dump, the TZ statistics region and
the CPUCP firmware. Writes to the TZ statistics region raise an
asynchronous external abort; a memtest=1 boot with this map tests all
memory Linux gets without errors.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 arch/arm/dts/monaco-arduino-monza-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 board/qualcomm/arduino-ventuno-q.config       |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
new file mode 100644
index 0000000000..7a4b58e3f2
--- /dev/null
+++ b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/*
+	 * SMEM describes all of DDR. The banks below leave out what the
+	 * Qualcomm boot firmware keeps for itself:
+	 *   0x80000000  SAIL safety island memory
+	 *   0x908c0000  XBL DDR training checksum
+	 *   0x90c00000  SAIL mailboxes and SAIL OTA
+	 *   0xd0100000  pIMEM vault (tags, secure OS, TAs) and DBI dump
+	 *   0xdb100000  TZ statistics (access-controlled; writes abort)
+	 *   0xdb200000  CPUCP firmware
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x90000000 0x0 0x008c0000>,
+		      <0x0 0x908c1000 0x0 0x0033f000>,
+		      <0x0 0x91100000 0x0 0x3f000000>,
+		      <0x0 0xd4400000 0x0 0x06d00000>,
+		      <0x0 0xdb300000 0x0 0x24d00000>,
+		      <0xa 0x00000000 0x2 0x00000000>,
+		      <0xe 0x00000000 0x1 0x80000000>;
+	};
+};
diff --git a/board/qualcomm/arduino-ventuno-q.config b/board/qualcomm/arduino-ventuno-q.config
new file mode 100644
index 0000000000..24c07e4162
--- /dev/null
+++ b/board/qualcomm/arduino-ventuno-q.config
@@ -0,0 +1,6 @@
+# Arduino VENTUNO Q (QCS8275, Monaco) as BL33 of TF-A and OP-TEE; combine
+# with qcom_defconfig and tfa-optee.config.
+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-arduino-monza"
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_BOOT0_QCOM_BOOT_CPU=y
+CONFIG_QCOM_BOOT_CPU_MPIDR=0x10000

-- 
2.47.3

