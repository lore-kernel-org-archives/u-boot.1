Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A64C79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 19:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09C8E4050E;
	Mon,  7 Sep 2026 19:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmjkpF1luFvn; Mon,  7 Sep 2026 19:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D21FF40505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788808606;
	b=FQPD+LRDHvEMKkY7axzaHbuGdYU1moue3gRK9ul0lmGjQBz1rfu7cPsXETHy3xwzk03y
	 QyimPUp326ci6GrysVFzP6oLxzDXEHBP9C2DwGXugdgOHGi7Y9fAfuQI1abJo1+/3nuow
	 negdzjKyVc6N7ksiSTVtrpvKr2LvUrpImYuJgpFH+theQ4g+yNweWP3P4IOwGeoc5Rw3E
	 2mIFzV3zzs/V62RoFb9HDe/XKHuo9AVX1DTiqnyYqKrrUuQ40dWiaW2zGQHLGG3GzJURI
	 7E9T9RTUvB9td3K93Whxwfxd85NneV4jY+FdKjCdzNJD0XzjB3UU6rSfDu17ON0cE/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788808606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J9e/uO5JhoXZg4SjBVPzvsLpg1Z+Ilpxk8vw632xhGQ=;
	b=cmvymm+lLqc3YIuUV+40uI+U2GehhWp8qd7aBKpZ/mY6iKB7gYP5bFmaYpX+6cMtUW4l
	 lnI5FduVkaTrOT+aS21qKq0EqmA3cFoRQhwgT285AuAJfRyMAdEFl9v+KLWVEn3iZzTHL
	 EaU9bIawdd+Us/rEQ8bs8Hjn/GBKQbuL9bxJH+LBYF2pDv/rh/llQ8KQ8iODsvP9FIn4S
	 D1SekR16ycYvzd5epEX1Dfmats4sokvfVm82pkkKuUz2YmIpBt+7tQiqxOmk9YEY2I9Ge
	 s7MK+1P910crfmmBY0kHznwCERR3iacbcteBncJWKKG6PjI30PWUk4bWAn6+6S7Zdhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788808605;
	bh=J9e/uO5JhoXZg4SjBVPzvsLpg1Z+Ilpxk8vw632xhGQ=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZmZK8FtcPXnlfC16VJ/bRsQGYI2/LJqvxuuhAqwN7QDj7DuRMhl2AH1Dda2TFCUA
	 ZYvkttkht6/sr9iu0MJFPNq+roRda2dfU0TDFMxiG07A2mQNb5QAvtI9BELuYlIVqi
	 mups6Lqbu+8gtBaAOLq5O/BKjefNzFtHFkmxkmKmsHXux/gad81G/X04wNJMIe3WJ9
	 vZcTT3GURjrvL+CQmtuIMpjhsi5XqMmMfFH5CeVOT7LVfTwMazwXGA+Yp70a4bR13B
	 PqN6Yrm6FkU1IacxTAu4UXhMkJCWxJDPEcZv8pRRhjlJhOqAJvmnq/1EgWWfYrjpeO
	 o8wXJeFKELzjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D21FF40505;
	Mon,  7 Sep 2026 19:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FDC39CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50FE38083F
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 17pZCFt5dkY3 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 19:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 97DD5808AF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788808603;
 b=WKxyPCqphDl8kWQ1aoeC/bwDQ8SucEQ4HIILwHuw6pG1dayhOlcLtQPyTnzHBYFjxHQt
 37yhTzsBylWrmDF/PuqNSHYN9ghYT+3LVsP+o0Bc1i1UcPZKjUHGTIiyEgM5JjpxaZAT4
 38sLVLMdhH1JPVa98bg3kkWj7dxcM+XbUBljlbVUNTAl4RpK+tah5m+rA05CGZ6BTW8qX
 cURHnCyc2bj/6V31sBh4W4e5g0kjKtIXrsTPBW8/RQEdJM66NFw5WwEKsHE3C7QpzWa4H
 pDsuCAPPhGQnq+6Rg5pDfvxPtGuTXh6TRo9GpW9XOU4ET0iSLxkJfZyhXXmw8B9n/Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788808603;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=J9e/uO5JhoXZg4SjBVPzvsLpg1Z+Ilpxk8vw632xhGQ=;
 b=MyerW4fXobsRz58MHdxbY+lB15EUg2w3AfTuX6lcSUNvTXphpgmnNA7eE/kOFy3F73kS
 s5zDPgosoH4un3qMBK28Ig07Sk48wBbPdFhvxS2+kFvwIFCSkbETGrb8x63Ans5LzDawy
 Vx6YdKC7AqX34EyvirwRB8jm06EpdtkW26a1TxG8nDEeJWZyZcF9oj4OSVA/l8kYB+zWx
 qeRwduyXPwOcLH4AHckJLth0039fm3Z+O43ooU7NJ49RLKPYBdGUpSFw2rL3UwrNKXeTt
 h2+8DfUNcQjpbh46VNPnHX1pBYlJyG3FvWYCIIvLxM5Rnhe8bG/EgV3SG2ui3vnNTiA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="EI/uGqg0"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GPhJfCa8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EI/uGqg0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GPhJfCa8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97DD5808AF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:16:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687H7lBq1642059
 for <u-boot@lists.u-boot-project.org>; Mon, 7 Sep 2026 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J9e/uO5JhoXZg4SjBVPzvsLp
 g1Z+Ilpxk8vw632xhGQ=; b=EI/uGqg0I/Ie5GdLjf5lkYfVWySdNPVO6xEb9eIx
 ai8Mrp96yKoj2jWhANwMeDRblGa2aiLIAl5jO0OWwCutsUL52X4/PwbexmMOUcmZ
 gHyn5IJPeLF1HuLVydzj/lcUcw3BFV19jAB4pbxjZWDKecBVvnpq01Wk1r1pz3H7
 /UorFcQ7bBj1jD3JlUajSXJUehUd6GJdBiCiL91VLNPlBrcU1EHJ05B0fzHElxTP
 XJjKBl1JsHRGJixUsxtazkeTpiyoNCKuoR3co80lgou2tThHMBNXP5szuDXZJvsu
 wB7Ekooi5BJ3DTaRvEw/ttqFpbFFVzfZvbIPyBFQdGz9Bg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghruaardy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 19:16:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78d25a8ff32so76287137.2
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788808600; x=1789413400;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J9e/uO5JhoXZg4SjBVPzvsLpg1Z+Ilpxk8vw632xhGQ=;
 b=GPhJfCa8OYEYrmdqttCqYVByXPlNst6iRQ6OLK61QJAEX6E/a2DrN9H7GNGBzxHpz0
 gcMiwwgjidj/UkUHB82fjrLKb6brV/c56EmZCK2Q5euOVm6ngYCy3rP2ajttuZegIaha
 B1A7sB+I7pwVD8JcRgPpuqgVnSmrnx988rgkDgVTniaQpLP1nmSnjIjWHL0Wm7N0sRUC
 ihZi/qzK0WMlLjbcjydj0KyMYCpslA6Op59SVImOmXbGVd4ffVfQQL3PJRVuWa90fRMq
 kqRYhJifH+ihA8qgqgNuYGAqHx68S5svjt9XtF+1cd3ehXQnbQtyrdZeSAx7EbrjP9dK
 hRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788808600; x=1789413400;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9e/uO5JhoXZg4SjBVPzvsLpg1Z+Ilpxk8vw632xhGQ=;
 b=jQM7jB++Ud0//lvRcpOBf5to/YvwLz+6VF3GLs3kdjL9fMNjPnY4jJTe0JEv+eDpMV
 ElbJcdTW1IoJNt8OqcmqFfiCkzr/eHiUWMyqiPNSM7f95oI2PEL4riMUYweJvMjGXqM/
 Irq/dIWuRxBEiPS74/E3+YGO9wpUIdsy3xdKV4aRZEmgWl9ean89P1KoXV2k4MIotoSj
 vBuvWHrMTbmufojuM08838LzB/mgB5KI7rWQ5W7CobgdgO/CDIuqIvBVplXV0elVXEz5
 XlfQgUaLBABhe/gq2JE0Pj8VWlCYfCtUVaYZn7qENbA8kGRaqrCFwdi/J1Cd9TcdaGNr
 qGsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh49lLovylpAUK0Z8c4YX21sre95o3iXY9NilxtOtMxPRwy8407ZhdTQUK5j6zFa5G4ew7gbs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ndDkW5BbUWhA0Txgbnv3HBqQboFYLBeScFcKNEGK31WuP2U8rU
 /lnQ9ABdXfmmmfS3KP9TBPDN9cbgDqqIlEWEY/x4hxpftrq7biiiurStKUq0RMtYy669jf4qJF0
 jF+yk+vEmQS7bBK2UG6fuG/jwamNnovditiQYrbXMHPBLy5RXcR6ul9x9BcTL9YCZITA6wYY=
X-Gm-Gg: AYBFou3nsE7L6DBeiHbCcoP0h6qpoyBZCMFXbeiL+oeVdTbq2sDYawACdl2gFZLld0y
 7vs18JK9vc4rE4g0tiCw7DUj5tCDcHrAEbiB21WcDjmH3oH3dHwICp28Fdc4Mts/RWxFY6rZsEn
 sBSwha7kgM8tMdTFEypeDF4PcbHIec7QIcvKU67n5eUsSVt6ZLBiM5iObZVbSN2rZTfW50HtaTF
 H0cMqtTnI7bT1glurxX9BN+IDf+h+v8Q6TrWb8R8VoZDKZK5/RNE078PbOGmwq23PTuOPy/LCGn
 pW5m5JxPl+S23UmZmWl2/2JVyCObIIAxPPHntTCPqk6D6CdH5CKY3c2z67hOYYhHWY5odOp29l6
 Vd1MzIXQhVrjEf1inOZMxp9YpMznhvnI=
X-Received: by 2002:a05:6102:b0f:b0:784:b9ec:910b with SMTP id
 ada2fe7eead31-78a4ab294c6mr9405268137.12.1788808600146; 
 Mon, 07 Sep 2026 12:16:40 -0700 (PDT)
X-Received: by 2002:a05:6102:b0f:b0:784:b9ec:910b with SMTP id
 ada2fe7eead31-78a4ab294c6mr9405244137.12.1788808599633; 
 Mon, 07 Sep 2026 12:16:39 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cc7sm333186765e9.4.2026.09.07.12.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 12:16:38 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Sep 2026 21:16:36 +0200
To: Tom Rini <trini@konsulko.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 Neha Malcom Francis <n-francis@ti.com>, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, xypron.glpk@gmx.de,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <ap8NlN6n2lOWTUW4@trex>
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex>
 <ao_89VbNNE1QTX6a@trex> <ap5i9edBJ7sNVmax@trex>
 <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux> <20260907161339.GX1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907161339.GX1764417@bill-the-cat>
X-Proofpoint-ORIG-GUID: 2J1zelAjW2YT3wJhgFAMivu9Eby9Msm6
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9f0d99 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8
 a=KKAkSRfTAAAA:8 a=k-42gJp3AAAA:8 a=HVDqmiFXc1qDffsDObsA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=cvBusfyB2V15izCimMoJ:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: 2J1zelAjW2YT3wJhgFAMivu9Eby9Msm6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIxNCBTYWx0ZWRfXzRj/qxUy4MgW
 oQtSchon2f8LZd76kDvF316DP4vAAZrhRKwcSTPLdhgkhJCsfgQKADjYM2FA/ENLUvIWQz1eeyL
 yJuONAbuMWfgw2jSa27tZv5oZIIzMwo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIxNCBTYWx0ZWRfX0/whmq9uIVIF
 xM+2n+/kiEshYIfg8LIYrlPzeuEzC7HqLgF3QrseJvv6PdEVCYWmi6TOPoSu7KRwU+MEwmN0HvQ
 51RZJ7FO63Hna1I7d4+SqqZFBAtwkvoei7nt/EyGQxY72H+pIoi8fZliSzX51WAWa3i8DfUmD3l
 nrl2BjXj2gnVQt0AkedETUhdU5Q4dBZprm/nx2rJNOtTPg7BDCjnidAnj+7n7jyRnOfY3RxdhbH
 9PzZX6lFmyQh5yPe5Ya+ZOuu3CQrBOcOnucAHhCFfAwl+vRubv+a/LGancawCD1Cu8k9m5WgfVH
 Uem0Uz4RCGJP/mLfPM2TMmCMigzZKPenoEXuEoJqUjUUb0zPYcdI5f+B3Y7uU9ksh/AKfydpr6d
 sOINX23grH6/NFFUOVHwLzDP2TQMTVlXmuhyelWKWQ9j/ik1l1Xhc1WowvqcNGUqaaaansZE8hE
 njd33oh4j/c3vy5PnOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070214
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

On 07/09/26 10:13:39, Tom Rini wrote:
> On Mon, Sep 07, 2026 at 10:40:59AM +0200, Jorge Ramirez wrote:
> > On 07/09/26 12:47:39, Neha Malcom Francis wrote:
> > > Hi Jorge
> > >
> > > On 07/09/26 12:38, Jorge Ramirez wrote:
> > > > On 27/08/26 11:01:41, Jorge Ramirez wrote:
> > > >> On 21/08/26 16:02:18, Jorge Ramirez wrote:
> > > >>> On 17/08/26 16:38:40, Jorge Ramirez wrote:
> > > >>>> On 07/08/26 16:01:05, Jorge Ramirez-Ortiz wrote:
> > > >>>>> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> > > >>>>> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> > > >>>>> interface, which is bound to eMMC. SoCs that are UFS-only and have no
> > > >>>>> eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> > > >>>>> secure storage from U-Boot today. This series adds that support.
> > > >>>>>
> > > >>>>> It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> > > >>>>> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> > > >>>>> the RPMB device and reports its kind, size and CID, then carries the
> > > >>>>> signed frames. The legacy eMMC supplicant is preserved unchanged, only
> > > >>>>> renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> > > >>>>> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> > > >>>>> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> > > >>>>> single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> > > >>>>> can be migrated onto it later as the legacy path is retired.
> > > >>>>>
> > > >>>>> On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
> > > >>>>> to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
> > > >>>>> The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > > >>>>> device-id string the Linux kernel builds (ufshcd_create_device_id()
> > > >>>>> plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> > > >>>>> the one Linux would use.
> > > >>>>>
> > > >>>>> The first patch is a standalone UFS descriptor fix the RPMB path depends
> > > >>>>> on (UTF-16BE string decoding); the transport patches also include a
> > > >>>>> power-on UNIT ATTENTION retry and a DMA-alignment bounce for the RPMB
> > > >>>>> WLUN.
> > > >>>>>
> > > >>>>> Note: reading UFS descriptors reliably also requires the descriptor
> > > >>>>> data-segment cache-invalidation fix, which has already been posted and
> > > >>>>> merged separately, so this series is based on top of it.
> > > >>>>>
> > > >>>>> Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> > > >>>>> programs the RPMB key through U-Boot and reads/writes secure-storage
> > > >>>>> objects, with the derived CID matching the Linux UFS device_id ABI.
> > > >>>>>
> > > >>>>> Dependencies:
> > > >>>>> Linux kernel:
> > > >>>>>  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
> > > >>>>> Op-tee
> > > >>>>>  https://github.com/OP-TEE/optee_os/pull/7881
> > > >>>>>
> > > >>>>> v4:
> > > >>>>>  - ufs: decode string descriptors: dropped the in-place
> > > >>>>>    ufshcd_str_desc_to_cpu() byte-swap helper; instead added an endian
> > > >>>>>    argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and decode
> > > >>>>>    with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s().
> > > >>>>>    Existing EFI callers pass UTF16_HOST_ENDIAN.
> > > >>>>>  - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
> > > >>>>>    put_unaligned_be16()/put_unaligned_be32(); drop the
> > > >>>>>    rpmb_frame_request() helper in favour of get_unaligned_be16(); move
> > > >>>>>    ufs_rpmb_read_geometry() to the patch that first uses it so it is not
> > > >>>>>    an unused static function during git bisect.
> > > >>>>>  - ufs: per-region CID/size: reject an out-of-range device-reported
> > > >>>>>    logical block size before shifting and split the size computation into
> > > >>>>>    separate statements for readability; order <u-boot/...> after
> > > >>>>>    <linux/...>; note that the serial hex encoding matches the kernel
> > > >>>>>    device-id ABI.
> > > >>>>>
> > > >>>>
> > > >>>> any further comments, is it ok to merge?
> > > >>>>
> > > >>>
> > > >>> EOW reminder - this has been pending for a long while
> > > >>
> > > >>
> > > >> anyone care to comment please?
> > > >
> > > >
> > > > kernel changes accepted and op-tee changes merged.
> > > > Just this one pending with no comments for nearly a month.
> > > >
> > > > maybe we can merge?
> > > >
> > > > thanks
> > > > Jorge
> > > >
> > > >
> > > >
> > >
> > > Looks like you're sending to the old mailing list instead of
> > > u-boot@lists.u-boot-project.org
> > >
> > 
> > hi Neah,
> > 
> > ah interesting, maybe that explains it depending on people'w workflows: I see it hasnt landed on u-boot lore's.
> > 
> > I just run get_maintainers.pl and the recommended list is
> > 
> > jramirez@trex:u-boot (ufs-rpmb.v4 $) $ ./scripts/get_maintainer.pl drivers/tee/optee/Makefile
> > Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE)
> > Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:TEE,commit_signer:2/3=67%)
> > Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:1/3=33%,added_lines:1/3=33%,removed_lines:1/2=50%)
> > Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> (commit_signer:2/3=67%,authored:2/3=67%,added_lines:2/3=67%,removed_lines:1/2=50%)
> > u-boot@lists.denx.de (open list)...
> > 
> > still I can see it on patchworks with Neil being the gatekeeper.
> 
> Is your tree out of date? That's not what it shows here, we updated that
> a while ago.

not as long as this series apparently.. plus maintainers were in copy
and actively reviewing v1/v2/v3

but yeah, These patches were developed on top of "ece349ade29 Prepare
v2026.07" when the development started (so before the list was
updated). 

anyway, so what is the next step. resend posting as v5 on top of
v2026.10-x ?


> 
> -- 
> Tom


