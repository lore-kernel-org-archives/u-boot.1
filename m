Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD6CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C713D4069D;
	Mon, 28 Sep 2026 18:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIzhb96bds6Y; Mon, 28 Sep 2026 18:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0757D40525
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790618823;
	b=gz34q2EzGFkpfrRwwalYwlZvTW7xdkQbundRYN5y9BZl8GcTWROwDaUEJHGeeKs906V/
	 w0eqd+3wGJGMJ2Zn5iOxDIG5xT2M5KpHUy9gBJLcuPgcS5GAOki793BTfCtGj1ulsU9KR
	 /gjTee0ATl9AENkhILyQ2zfOP0AxJAwIhVbmrveQOnXmv1cUC4KzXvDeYjBpW/+rsfiP+
	 ovE5j+YJAb4eOxCl7zbSm681oGj7EV2wQ4naUe0lJFnwov0VR3NR7g8WKXuh/daJbc7EJ
	 nyRZcY0mhHjtrepk5ZL4pQMQNSzuFR4+tVtz6hsMWw51NmbY2yz0VXyBaCv6BIKxD/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790618823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=;
	b=LAARZTErsQI+6XOWmibYna7JxkoujUqhgS9JajHpD/NdoOUNxLb7fzhGYQp/Bcbm7pLj
	 qXnTlsFqrYIOee5NMcDvwD8zQr2rrGnbgfnkRc5/3vmKCmFDPjMHRm+ZffJV3tTGTMShF
	 YiWGBuB6sbWR8BManzvMzsOIuQUIJBS+/x+qkPvNywis9tqeDWchk3ITHw4lk8h1u4Cv+
	 xzRt8E4oZzyxIl0mIksZJYh/xj/8B120Oi+ap0J1HaZI0zpMf0ygUCrK+iRa2H4OjvscZ
	 P1wh/rnOaWFlut0Lo30NxNecnisGzqg7VtUr8ubO8Iiu80f/CTby18T4qcLZCe6sXJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790618823;
	bh=XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ox3wzEE6ShKtz5FI6rgv9s5In4Z2nUZze+nZSIi46Ufz2PtZlLHLRGMx8oWfyH5zL
	 1eehoSd0ar50+T/zgBYuAWcofoW5ehvwb1M7eu3FovBU7cGOn9AAJKRQMfITxmy3ND
	 T/enZspLijc4GGq94MjiBNC5GST02MOaLKNDIrIx4in6T6ez3FH/0P90tgYH1jlkjj
	 13XnWuNeZjeJd8ieFNaLjvksdfj4PM+c2vWuCHqOSAM+TqIFWgAVTJi/0tQq+Jkg44
	 oD79ia065SQiH0ielfX4ocHWs0hb3ij1O04E+QOwdQAsFHDStanin2GjOL2Wqi+BW8
	 SMGPOZKhJXvzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0757D40525;
	Mon, 28 Sep 2026 18:07:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A664431
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 357A480C6F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOJx9VuoEgEu for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4528E80BFF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790618818;
 b=oVjGg2LaQFoJxIpyG7CyuibG+3xk6baUZfYJFpAxZSFcORvnGnFXeEs8LfiLenWb1t2n
 FBoscPdfyjVCKrj9L8rh5KP4qOyGKszrxPYG6JAIEKLdazKqGN1cjM057h/Oa1zoSov6o
 8uJBI3zJ0Y19jHUHSuK3/G9YhADaPyCf+L61Z//A/Ve/rtOxWQzB8TaZYI9QNULdOZpef
 g6BZv1RBspowytkVflDvQHg3t7gUDCO2pYdmY7DCTaezezyG7i9ALdaTNQWn/HyngtmJR
 HoC3UMhqrrE4v2zoOLpxcdXbNMVszpIOFGiXZaucQKf6VuYN65xJYnQO2RDzjMv1LOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790618818;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=;
 b=LeaLrSDpSx+1eHgvnhjEBf4C+E7MS84PhReNrdhhxM/qqBAbA+NngmNbcYtCtwsk+7sv
 e63U+xVzSAUth/0h/JN+BECk+OwbiwapMd+enxlj5VYqWFG9pjJzOb6mFwZXbSpiBqE5D
 atPpgGAV09t5nZJrLI5r4UXYgpqGhSaFS3yz3sD8sKD8l9DkvdxLdboUAHFAIBK+yDKbj
 3T5TlOWgHiuGj8VlGRGZ4BEM31c1xPVuxX7Oir2FK6z2v+H4ZmrQe86XkIdSRwOeitRWr
 7U1lnUMqPh/+tk3WvG+rEnlLaYfcCc0PR2FZY4ylmNMWKNL9zsTbLIICdHQdpCYC7Ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LqgfC71m; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZN25y9y9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LqgfC71m; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZN25y9y9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4528E80BFF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHwkev2740633
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=; b=LqgfC71moeDlm8f2
 z8cPrx6ov/fflwViJhFn2MgfKMzJYxb28RHa1CCBmm2aJvzAm1jProJmB/XhMnc1
 321I6lJGNnz2tCsTrY26XGlEkL8imX/H2lDc/UoaNcyYt3qsQUe7OWR32Le6XqL5
 2ugCdNq7TvqbpWTkP+2u9NIdBF6sxpRfXBalaTPTqaXt9LzEiVUDiM4M0zBZ5yus
 hM+XyDMtPbug8EFlGhgcX615Iji5jlBv17M/rlYLfkdHORiFJDAJcA1IckhRLBLv
 ZnNqcc9Tn0B53TeJwUZfPgaxejq9cCCPmDB0CAoAUatsMtq4sa5XcLlf7OKxDMJv
 9gSIxg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6j695-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-869553205a7so41803757b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790618816; x=1791223616;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=;
 b=ZN25y9y9zpJe3WkP/HpFd1fY1yLQzBk7K3TxPkyn82famP0frUez1m79wXrlaXqToR
 uvEwnsAG1jiuVdEj4zgECTrwAP/Xe5O4HGZg6ZO+LNu1kLBIX8Bc56GPiNyRf5YPxDcD
 +1q65psbgXCMBTvtDy/AN/yjdHQFLvRus4D6UH1FtJwLpVSqUZhJ7jV3c3Zq7hYjPvSE
 F4jdoPYpAtDOHv96DcdNcCmCma/9op9FY4+v2wfSaCAuhpdZb0m/jIYM892R19575YIq
 Sgw5XXZmPn5LyH6zmuS7OtiuI2i1k3RlJZ08dKSbrrbeJ6vNRaLGh151aiwpBJKU3H+3
 16GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618816; x=1791223616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XYSsH5SGCxlQU5nB93SVkYjUMYf33JFi5RNUCaGDtnU=;
 b=hJLWHEdUI8rtaHB6sjM4PIwtBukrep3xqSCKnM4kqGaWbR2hAyjnUWuKEWuBnLRo/t
 QWnWw29IDXQV/PgEDSe24PwU9L6WLt7X77q51weVOQJM77ZDono0qq45oi9CyMSpI6Nn
 n6czj+fZdCScEP9r5u/Qbt2pVeX7zsiiQsHjYEE7WOgmxtd7OVybOUQTQzpKKz1NG1s2
 ePZ2M9jHWxitWNqkW0avd9aFTguYt8wBDrQ68SXYhPRxAvIfDu8i1mrsbwAK1lErBZeA
 rGUUmmB0EtY9YfK+sKU8zALZYGSJfoEDay/Vvjumi3ApyChUETtCzBqMHnjnHLsJVO6V
 g9LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZIhxKsE4LUkte1AmyWkcIaf4lveaskVSU+27CMmZaYGiHuCOMN6mpVKLbnWDKHDgmA2dwKaQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKtAHKZqDZp69aSVhuV8sHQ4zF+BnWAyoxs/I89ySmaPPl3ivrb
 osyJ9geII3iXHO+BZi1PctkVyqkdOZfHZ/aHuEpBj5SwSTKefdsd9CFeTcD7MjsNge3Ql/Si3Pj
 SIMq/CL3b9VWCSht/DL4PsgmfItMTh6uPPKfFAJysyxUgwHnVlQPbXvDTLPrzbp9zHW8ef8fSMa
 hx00s=
X-Gm-Gg: AYBFou3o5bf77sLvCPfCXnG/BLjPYb45xt/R0NDkfPf2b6QaWtTRIKSdixCObv7t70b
 dcEa92IcLxCaww6yF017vP1K4bmeLVnixtSryudYdd9UobTbNWc2ddfWSlmw57PWVgIepuoSWsE
 P274iifyfJqpzzpsl0f0OpMPRROXyElUtwXQZCNRqevmh58it6HJzlpVtc8WT3yjO1QYbGII6+W
 JWc1VrP/rqk626yGxQYW/jkfr+8QxJ27XloM0XSAPcWEI9JraQN6JZdHx0Rodc3aXUVWj0ayugD
 +9eNq7U1DO95x0jU9rF+mBwBsT6NGO7pmP5eVJ4Iz67UwTloZIMtFQaXlnL6fpZ2rkTNMpe7Miv
 3NGOWR5EegqCbYs7AqFeIKbuTnqsvODHNVOztuqzGQoFN6TyLpIWZXkqBmNSMM1vPje6hXTFV
X-Received: by 2002:a05:690c:6d82:b0:873:5c0f:28c with SMTP id
 00721157ae682-8a64be54149mr78099167b3.54.1790618816053; 
 Mon, 28 Sep 2026 11:06:56 -0700 (PDT)
X-Received: by 2002:a05:690c:6d82:b0:873:5c0f:28c with SMTP id
 00721157ae682-8a64be54149mr78099027b3.54.1790618815455; 
 Mon, 28 Sep 2026 11:06:55 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm49390177b3.11.2026.09.28.11.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:54 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:06:53 -0400
Subject: [PATCH v2 3/4] board: qualcomm: add Arduino VENTUNO Q support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-monaco-ventuno-q-v2-3-0e046c8242be@oss.qualcomm.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
In-Reply-To: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX+c0rhOptk8+h
 pULiiaUCMTHgi7MbaApm8uvgDo5co37C8CPAxERH2P8EHPFW4kAj+mpx0DUsv5u7Nvr2m5oKk8S
 JQ9xJbsBnRpdcAbvP5tiQHI1Q+rNGYbd4Xgw7SeWHcOLdeZWmBSu0q5smB9HMs85DNkCq4FsSDC
 0xfsaLP09HMm/JBr/rOUnMt1kFnkHBJQnOBNNEk4UyOI5smEJaz21rqyofLHnxIwGkyjJIJWsk8
 uGYU6nWWqxyXU9w7pm9IpFPEfvgkyKQQCt+1kINF4R6R7JezB0qEsviF+Ghq7P6hET1SeJ4E8sC
 x74SiKdxh1dss9YRKxmGrFKxKH6WyDkd9BuLK+MN9iKBauQdylrvQqSZMs+VYTbmokYx5c/JDll
 lHEywKbrP7tg2ACUihSVLq6APmdaQ740fYdeLAMYFiLhwr86uUsU+fvBZ+SmlGY8dPTa36win2n
 XfIuXVSgED0QbS5a8lw==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6abaacc0 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IqWjb9_ZHaboN1VMQpEA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfXw+kmUg5dFHh+
 TsCQgJT/SQr80O3KEk9n/8jbogn4kxyrlStpB8iIViu9VQ/aca0F4ypqYJD71dxtWUeSUJ1Xkm6
 j6uB2hHIEKNE0Viiz0xKmaQ184YRqJk=
X-Proofpoint-ORIG-GUID: 9jihna8CamrCmFOwL0MpEDS_6COP2NRA
X-Proofpoint-GUID: 9jihna8CamrCmFOwL0MpEDS_6COP2NRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280072
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

Add a configuration fragment and memory map for the Arduino VENTUNO Q
(QCS8275), running U-Boot after TF-A and OP-TEE.

Boot on a Cortex-A55 and exclude memory reserved by the boot firmware
from the RAM map.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Changes in v2:
- Renamed from "board: qualcomm: add Arduino VENTUNO Q config fragment".
- Reworded the commit message and comments.
---
 arch/arm/dts/monaco-arduino-monza-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 board/qualcomm/arduino-ventuno-q.config       |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
new file mode 100644
index 0000000000..e6ba8ba486
--- /dev/null
+++ b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/*
+	 * Boot firmware regions left out:
+	 *   0x80000000  SAIL
+	 *   0x908c0000  DDR training
+	 *   0x90c00000  SAIL mailbox and OTA
+	 *   0xd0100000  TZ carveouts and DBI dump
+	 *   0xdb100000  TZ statistics
+	 *   0xdb200000  CPUCP
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
index 0000000000..a8041cbe9d
--- /dev/null
+++ b/board/qualcomm/arduino-ventuno-q.config
@@ -0,0 +1,5 @@
+# Arduino VENTUNO Q; use with qcom_defconfig and tfa-optee.config.
+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-arduino-monza"
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_BOOT0_QCOM_BOOT_CPU=y
+CONFIG_QCOM_BOOT_CPU_MPIDR=0x10000

-- 
2.47.3

