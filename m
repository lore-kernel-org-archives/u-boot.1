Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB588C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 21:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1837340527;
	Mon,  7 Sep 2026 21:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7hv0TbrVVop; Mon,  7 Sep 2026 21:28:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DC6B7404E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816536;
	b=r/WkwljtTIxgk1YJlAe69ND+LSX6SQyN8EsaNABm1YxVFP9a2Zi2JOzwdW6mNYzPEvKT
	 s/J99tXMpS9eSogHd1oXLD4BQIb65f7KU6MC03l0CywxKNkAqWJRk0gvAafBif1A9z9Gf
	 hp8lQaXpTI+PS/1sbmF9+o3b5LxKELl8rOqFVd3nIxsFsMQbAafj9O4Gy2wTyk7ao+sqc
	 ScrnevRSFoUVleuBUvk1jz7WumYcGvcylhsa7Pwakf7bpm9NidZLMsSszTKr97MYxaS6c
	 6gVQPRW0e586NTYzjo0FS0KxkFg8U6nb+QS38O7fW70h7z/eB0zo35tUcvP51zD7i9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788816536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8oc84xxszl649wcqEJiBSapWcw6iImX399wmmEZ75qM=;
	b=RlHRq4z/829pEr59nCl+XbQalb+HLl/KnYf4hdRP1nQyRKi1MAF6ei9Uvh//gom9RnS7
	 9ddGTjFVmVkSXjDj7LAMl3xrBz/DkPDJFLrsq2AATiOpqWmkEFcI+C5FfQtws7J4Y1Z9o
	 J58F1v3OX5oe/3EQz4ZFd5BhVlqjKHMYxbQEJd0lBeOtFO5oE5hyVkd9AlIGUF6kbl8rY
	 F1cESzFlLJ2f9fc3CzyMP1o3RcUen7m8BEf0xpqLUG1cbBK8DlnMlN10QiGX6PVAGBWoH
	 DbQvFwOm6tZUmdhOBqmHbWMMFsoFAC7YV/N1Bf/mBdPPH4lxgmq7bAKyFLfisuC3FBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788816536;
	bh=8oc84xxszl649wcqEJiBSapWcw6iImX399wmmEZ75qM=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OoUWog9rsnKYOzNZwAfy6JzNomcksvLsaIaq2kYO79v7VsSBqlB+jM2kolMyQXOGI
	 C9ie3QuuP1LuGL8NZID1YytFQKJZTe3tMSG2M1iX1Vmw+eWsL/G0p8tpCBRL9mncHK
	 lf+0i8oT2p2uh6d2C5NLK8yfqYau2ScfrVY8ICwPaGakSzdUsIuntcshFWUYSLdRxm
	 MEmZrgnuTy5E92bgRYQ1WSUfhfyGHmf2t/OQxWlg2ZD3euEIFV5HNHcXMPowftw/P6
	 vB7TCIh2//NoGCPWyv5J8vVX6piI2x3dOYxmdpxarCeNUMBxIte2wEsJNnWvQR6IaX
	 H38bmMP/vh3TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC6B7404E8;
	Mon,  7 Sep 2026 21:28:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A120349D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 932DF40099
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVsM1Gf8zEQq for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C70974005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788816533;
 b=ef/7vzVOCXi9kSo7dcaK3wAWcfajc74Y5/cVOL784IDUnO4wEKzgKYBCCBIS0u/KLoBQ
 zLgIdDlWEb4omLXPRARFz4JO3MwtRyg+yeoEDBq5rfGlZJvHeKtxU7AlSyaZKK9AIIQRI
 eOFfMcBg0UhFONxxHpgbMduDLNH+X5nXdJVFg9EeZug2pCjgMGMTATPIFiGuWhZ95ZefW
 Psvmqt3SvoZvSA6sSk/zf0tWubCW7lGg83uiYGlilTXU5dcd3qZY9ugW02rGnxRtWxNT2
 e3Lh8LiXERYR+aDF3aeqvGZP4cSQoVRA6evVQnhO6UKdRe2HIvEUvfj1vfln8tbfuLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816533;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8oc84xxszl649wcqEJiBSapWcw6iImX399wmmEZ75qM=;
 b=GenXcPR0SpkZGWSBidUrBNAzuVda9UoJxPmWJMs989vjqKslE5+J1hW7Yq9h11K8EXcs
 +mo8+h3egIEqnPGgoJwj/uFK6IPa/naNt0U9QZMBXUmEW2B1NU9i5bb1W1+OLZarL22oH
 YKGU87xoRAX3ermr8GKHIlt/ElnVn6FCaX+NJZxlM2ElHdk7ko8wicarpdx7zsTU2yiX9
 uI3XTkRrceo+pxGoBJh1w5+LolskTBppdiYoqp/iclg51JLL86vecpHT1zA7UGuOQau63
 wLz+wuY4NPdahsjD+daZ+dJywG6LzdOvusbuLWBOO0jiNeLfpx6Ease8OcerR19kfnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BxagLKvR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JB+sTKSm; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BxagLKvR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JB+sTKSm
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C70974005A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:28:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Kl0so866907
 for <u-boot@lists.u-boot-project.org>; Mon, 7 Sep 2026 21:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8oc84xxszl649wcqEJiBSapW
 cw6iImX399wmmEZ75qM=; b=BxagLKvRgOgiT5Jnjt7CGq22F2EAGxs0UruBFeMW
 2bsBur4O3XQ6yI7/g4zcpfPdx5sNllbY1XsJJhmCI1gYPWevpw6GCTMkxk45ZOok
 49WOHhL3NggVcLuuN+KYqLwRlVLMrnbj5Hl2c6i2RHYJuKYh1gfmEmInKVf4wUkp
 BnoggCMfWutZYcGaK62++dKpQFdYd7kuzkPLjnn20fBrvTaKbFg9p19sPEIgeq/g
 jbO3Eq9+ZHJnLP0qpM8WATqUenLPRVzdJX32YYQnX1NKclEqqtDOfk+SnlDF2CTr
 qOXAFT9kABKJ6TRvnOzl8N5df1uLDf7oVaz1KuUhmNkJmQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyjqv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 21:28:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93915f50a5cso970177085a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788816530; x=1789421330;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8oc84xxszl649wcqEJiBSapWcw6iImX399wmmEZ75qM=;
 b=JB+sTKSmn0b+EkMMHMRLfMd8/Ib8CsPk0nVpGEw4ZdbCRmuLAKYCO4HknfiS2tsUOj
 iC+LEcdZqzz++C3uHGEmSFOm2m0C6y8hy3OIFHMNrcxmxhUYdx1M2CZiigS/Wqv6iRLl
 vxfkqN9Ft1ZPXISA2nRL4JZmRRscSDpIsNGUNo0mXrHWyhJ06D4AJS/8ye6fGV/QhnX9
 Yy8/VupJHcN1MarwZvBQveT3KviNnTr32n4UKF08j8wwDMbXjJP2BV5AJdlbSYyt614x
 /DYIzuBD9Fi7AD6oJuqbqlOONaoEZBMMBcFMni7evNCkDtG39sfLnXwBVqpuWJv5FzRj
 9poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788816530; x=1789421330;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8oc84xxszl649wcqEJiBSapWcw6iImX399wmmEZ75qM=;
 b=N0eAjsBNMRD0KBZBuJYLl3/K6t42OPKJnrNeL+nkbedpXQQ+r2OTF1e2Q7bn1T/UlG
 EWA9lfEHhJRn/ayPA7DEEv8FmcmPur2xC7vwod9PJzVW8ql198XnLLnLYBX2dIq+ocXl
 /+ZkLRz3oMhRRb8pH9gmO512KGdevR6gJ7G0w6wBA4BYSfJbDY7Wn7H2vZ9TNMSnjwI8
 ha5HZOtAh7tQzO22WHbLoOmKXjHAv4OiG0TISNtgxu4HO2vkIa8sNwz+ZNyp4tH9RVTO
 wZM2N0+18F6W1aC9y//W1m/F/1YNZ5kLSX7C62thqHgVYu2yZ6xgIWMFx2mhFcV5ti3J
 Oyqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNmj8mIrTmqtBqx8GI1BniqgV8H4HUq875sxQ+K0B5AIgFaGv4L6U+z+7QkwOapkHVaS+u4Ys=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kC52GbBxZfP5zUFZ5tgjCFhEsWa0aEcP66y51o+3KBV2QYlzZx
 an8QGKr6HxHNVQXmKMBT4kIqH86mgvTCAF+vEOrnhEVbEECvQoAN1XCtPEAIt9w+6VFs0eb4igU
 DFDOd9yHaJHyrUQhXt2SRSwKuoDn78bpix8b9dSsmKwyxlXJW8E+/blUZSzYjtU28eLKldag=
X-Gm-Gg: AYBFou0pvDKkrv/BIofWJRkpdj4Ne1e+QsI+775p5ddPLfulChEAX59uVnLcyy8DaSj
 gt7HJ3Yy96uIf7pPsBsodJvsKnlZERzvsCs26Xhce6XQhjeudwM2mBnPKcGOXYul8HIu8Sl29bo
 L7k25AwN0qAjcQJ5qorILBCO4ERXd2BtkzJetsYfduSBCn2Dl/ZzavnKYcRjjH7Bla2XOvLJ00f
 UILGy0MYb0PrmR6is+okiIwW87++Xi7J6Af38uwTx/Re6hfA09SmPS33e/AUgCRuI62LzZtCvcr
 YifJvO82dZSYIsZ1Fd6y0Hn0QEoKKnjOeQUGs1Ijda3gEhWiozTdx7sVFJPkkAhPq14DqIc1NV3
 itPobbb9/mP8c8OlzbZy11N7V5r3ojAY=
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr2798946985a.21.1788816530304; 
 Mon, 07 Sep 2026 14:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr2798942185a.21.1788816529831; 
 Mon, 07 Sep 2026 14:28:49 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm29430238f8f.36.2026.09.07.14.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:28:48 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Sep 2026 23:28:46 +0200
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
Message-ID: <ap8sjuP9or2gbuNg@trex>
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex>
 <ao_89VbNNE1QTX6a@trex> <ap5i9edBJ7sNVmax@trex>
 <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux> <20260907161339.GX1764417@bill-the-cat>
 <ap8NlN6n2lOWTUW4@trex> <20260907193608.GZ1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907193608.GZ1764417@bill-the-cat>
X-Proofpoint-ORIG-GUID: NlSM8SKFJFCh0y8CsmH6PnXdgFOkPIuc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIzNiBTYWx0ZWRfX5EGy2ru+/9vo
 2d8wr2KHMmNlJOmxYlKZoruLzG314aAmofKCewZTOe89SEwqtCEIsDOgazyhQqgPosLdrVlv0tm
 0o3dOQxWgFZQATMRs3IIahZYByX8jiyFP7xih0AQ6WeBNu3OOW9Cf1jmM9KPtq0cu4F/dVD8v31
 Jm9ZjF5YRsuomhSIKQ/kUDE5xWxUpAMGMEFvui3NXs5o1rVMUtHXhl/VffDLPj4/siYMpSeylbO
 PYCA32ExxPSAR/SYyRgxVfjb4ozFmqc81lr7pPe7jZXQ+W/BYB/Sjt8HMga4Fom2PKB6OMFhzkC
 kG00NUhW++QpVNxBdt0EYm4G7d7kmU77Gn8zAMDPrj6EvRo1qw43kwocbRUIEIjCcawlBH4WQcA
 Z3EcMAW/gP6KOfWHRDewULV5fB0P+Da+5sNMJioXgnPkEUp1E63J33LvZo0M0IOCSs5NFgIkJyS
 PxN7TxmgK9uINCjvNIg==
X-Proofpoint-GUID: NlSM8SKFJFCh0y8CsmH6PnXdgFOkPIuc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIzNiBTYWx0ZWRfXxoeNxFr7P3SB
 rWimUh/DPrnEPOOPoiwwI41lhiRcoHBduuWfdsm70YBSt3IVbxxiNw4Dl7oJCzv56PfUBVFrnIC
 TQm8KyvVVnPN3JComKFAQnuJNCPs360=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9f2c93 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8
 a=KKAkSRfTAAAA:8 a=k-42gJp3AAAA:8 a=JDRM32G84p5NggNQevoA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=cvBusfyB2V15izCimMoJ:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_06,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070236
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

On 07/09/26 13:36:08, Tom Rini wrote:
> On Mon, Sep 07, 2026 at 09:16:36PM +0200, Jorge Ramirez wrote:
> > On 07/09/26 10:13:39, Tom Rini wrote:
> > > On Mon, Sep 07, 2026 at 10:40:59AM +0200, Jorge Ramirez wrote:
> > > > On 07/09/26 12:47:39, Neha Malcom Francis wrote:
> > > > > Hi Jorge
> > > > >
> > > > > On 07/09/26 12:38, Jorge Ramirez wrote:
> > > > > > On 27/08/26 11:01:41, Jorge Ramirez wrote:
> > > > > >> On 21/08/26 16:02:18, Jorge Ramirez wrote:
> > > > > >>> On 17/08/26 16:38:40, Jorge Ramirez wrote:
> > > > > >>>> On 07/08/26 16:01:05, Jorge Ramirez-Ortiz wrote:
> > > > > >>>>> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> > > > > >>>>> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> > > > > >>>>> interface, which is bound to eMMC. SoCs that are UFS-only and have no
> > > > > >>>>> eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> > > > > >>>>> secure storage from U-Boot today. This series adds that support.
> > > > > >>>>>
> > > > > >>>>> It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> > > > > >>>>> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> > > > > >>>>> the RPMB device and reports its kind, size and CID, then carries the
> > > > > >>>>> signed frames. The legacy eMMC supplicant is preserved unchanged, only
> > > > > >>>>> renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> > > > > >>>>> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> > > > > >>>>> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> > > > > >>>>> single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> > > > > >>>>> can be migrated onto it later as the legacy path is retired.
> > > > > >>>>>
> > > > > >>>>> On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
> > > > > >>>>> to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
> > > > > >>>>> The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > > > > >>>>> device-id string the Linux kernel builds (ufshcd_create_device_id()
> > > > > >>>>> plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> > > > > >>>>> the one Linux would use.
> > > > > >>>>>
> > > > > >>>>> The first patch is a standalone UFS descriptor fix the RPMB path depends
> > > > > >>>>> on (UTF-16BE string decoding); the transport patches also include a
> > > > > >>>>> power-on UNIT ATTENTION retry and a DMA-alignment bounce for the RPMB
> > > > > >>>>> WLUN.
> > > > > >>>>>
> > > > > >>>>> Note: reading UFS descriptors reliably also requires the descriptor
> > > > > >>>>> data-segment cache-invalidation fix, which has already been posted and
> > > > > >>>>> merged separately, so this series is based on top of it.
> > > > > >>>>>
> > > > > >>>>> Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> > > > > >>>>> programs the RPMB key through U-Boot and reads/writes secure-storage
> > > > > >>>>> objects, with the derived CID matching the Linux UFS device_id ABI.
> > > > > >>>>>
> > > > > >>>>> Dependencies:
> > > > > >>>>> Linux kernel:
> > > > > >>>>>  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
> > > > > >>>>> Op-tee
> > > > > >>>>>  https://github.com/OP-TEE/optee_os/pull/7881
> > > > > >>>>>
> > > > > >>>>> v4:
> > > > > >>>>>  - ufs: decode string descriptors: dropped the in-place
> > > > > >>>>>    ufshcd_str_desc_to_cpu() byte-swap helper; instead added an endian
> > > > > >>>>>    argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and decode
> > > > > >>>>>    with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s().
> > > > > >>>>>    Existing EFI callers pass UTF16_HOST_ENDIAN.
> > > > > >>>>>  - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
> > > > > >>>>>    put_unaligned_be16()/put_unaligned_be32(); drop the
> > > > > >>>>>    rpmb_frame_request() helper in favour of get_unaligned_be16(); move
> > > > > >>>>>    ufs_rpmb_read_geometry() to the patch that first uses it so it is not
> > > > > >>>>>    an unused static function during git bisect.
> > > > > >>>>>  - ufs: per-region CID/size: reject an out-of-range device-reported
> > > > > >>>>>    logical block size before shifting and split the size computation into
> > > > > >>>>>    separate statements for readability; order <u-boot/...> after
> > > > > >>>>>    <linux/...>; note that the serial hex encoding matches the kernel
> > > > > >>>>>    device-id ABI.
> > > > > >>>>>
> > > > > >>>>
> > > > > >>>> any further comments, is it ok to merge?
> > > > > >>>>
> > > > > >>>
> > > > > >>> EOW reminder - this has been pending for a long while
> > > > > >>
> > > > > >>
> > > > > >> anyone care to comment please?
> > > > > >
> > > > > >
> > > > > > kernel changes accepted and op-tee changes merged.
> > > > > > Just this one pending with no comments for nearly a month.
> > > > > >
> > > > > > maybe we can merge?
> > > > > >
> > > > > > thanks
> > > > > > Jorge
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > > Looks like you're sending to the old mailing list instead of
> > > > > u-boot@lists.u-boot-project.org
> > > > >
> > > > 
> > > > hi Neah,
> > > > 
> > > > ah interesting, maybe that explains it depending on people'w workflows: I see it hasnt landed on u-boot lore's.
> > > > 
> > > > I just run get_maintainers.pl and the recommended list is
> > > > 
> > > > jramirez@trex:u-boot (ufs-rpmb.v4 $) $ ./scripts/get_maintainer.pl drivers/tee/optee/Makefile
> > > > Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE)
> > > > Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:TEE,commit_signer:2/3=67%)
> > > > Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:1/3=33%,added_lines:1/3=33%,removed_lines:1/2=50%)
> > > > Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> (commit_signer:2/3=67%,authored:2/3=67%,added_lines:2/3=67%,removed_lines:1/2=50%)
> > > > u-boot@lists.denx.de (open list)...
> > > > 
> > > > still I can see it on patchworks with Neil being the gatekeeper.
> > > 
> > > Is your tree out of date? That's not what it shows here, we updated that
> > > a while ago.
> > 
> > not as long as this series apparently.. plus maintainers were in copy
> > and actively reviewing v1/v2/v3
> > 
> > but yeah, These patches were developed on top of "ece349ade29 Prepare
> > v2026.07" when the development started (so before the list was
> > updated). 
> > 
> > anyway, so what is the next step. resend posting as v5 on top of
> > v2026.10-x ?
> 
> Does v4 apply cleanly to the current next branch?
>

yes it does

> -- 
> Tom


