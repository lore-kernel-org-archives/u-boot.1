Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57B2CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC41240694;
	Mon,  5 Oct 2026 07:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhzVUWmO4zCV; Mon,  5 Oct 2026 07:04:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BDD614066E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183881;
	b=T1IIqnbr7gy17saDXHABVEgXSzXh+Zqdo54b9GaPmQ5sZ0P6QCq4bS92uK+TP6H9bRHb
	 1RuydFvfDwdA1fOmDwsIxbpSdBqTb6ZM9F1+hV1arznxHXmKfPna/md38H8kXUrJKvuHU
	 xXVzuM3f8cGiy3C2apRL1eCQpTIXfrx+rTAlR64sWJAKg0/WmZMmUnlN1IxOyRuh6ahhg
	 VI2S+9+zpf2Ju0yqNQH55mwCGR5qsWGPSZjMHDLnTtmWvYetI84aBC7ezPq8Xu8kvpXg/
	 aRxbKfQAdsl5cCMp64lF1xYrkHN60psHL9mNs+sYIpcpVg9YCnVpPp2kXhjUmu9remg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	b=BMbsP7ICuWUel9iRzI/6RxLSDX2kWoPWXCEE/05a6Ye4xuMB55FcBP+3txw2Ti2txE5r
	 fEYHF0JgKCEi7TUMWicM9pQwtguSGqnL43iZIj4XXIex2TRxnvWfrs1NPQ7Dmcbi2RJ0k
	 fSjThwWF/Bf/w/RAJTnKjpLmqXRDUV7Fqd7rbXPRKjjnPn9ZWzfuN/1Nzlnto3z+VxrmX
	 O8cUxR2AB3QIrM76YpslpxNUT83bvuYKRRa2TEEBAFFHlXQ2KrtADF2c9rqLPOxuQ5JFg
	 w6DerVoifnJS53+1zeSGcPIc8GjSCplJWJOOnd+6I87g2rON2kCFrrTe9WXDQBIqH3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183881;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuqLQQeWbhzqUriF6j4+w3eK1hel4Ii3phZYkGhF23PItUfEGy15jGnFq7i1zEAhs
	 L5Lj+7vlrGchvobeYP1LIILKGaU0lAdS+886Ys+yKwm0IS1vGiQ6GOp/fg3W/5e+SV
	 7kCXH/PyeVCx4FKti0bBmIgiQ5km1ip1wWXa4pkT9jCzbHS2amS+qabL0uiK4o1ktt
	 cFZkfU4hKiGqJs5jus2WKdGD7fN2zarMdvjHP1lnGUD38lg10+h+C004DWxoNncoxY
	 ZESaZGc0AV08QP1eju0+GUvfqqXRujnrmUHcl+3FVtiRLUi3KnL8fGktxxjagOS1j/
	 y+pTCAYfJHIlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDD614066E;
	Mon,  5 Oct 2026 07:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCFB934D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C30FA400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErfavJuC5cxT for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C6F10400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183792;
 b=l6XCiHTFYJHyUme0Mn6aEHinpnbtOW3uk8fleBLLmS7VVEJvl9mHs0bHKz9GTFDzTNji
 rTl+fOn7NJFLCC1KeKtbLTEkm/DQlpLs8X3/ovOL04NkVULRiytuNq3DkQNhHQ7tV9S7Z
 p5Pd33xdDkZb+ZYqG2lKQqFGHb95N3IPKdRduozZ7yM9ltanVFfekUsz86Cmp/v28S6LZ
 gQlmXSIIpoTiaSZILdZI68IcmRDe3Y/XuxLsGwM2+MZDfqpCVrCttITXQIz2FwSvlHGHQ
 Z63vvohRuWomrKdihTB5Yh8EJDBqSM4oBX1OcJdHbGzP6lHKKsGI1pqniNVzQDiEqxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183792;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=q0me3RVdkMyDBfvZwdi21PBrrtIaQlyHwsk1QlBGSMUvgnmzaE70tGi15fuCNT8mHqsz
 0bDdxEKITQHteXHv/s6+iHqAYRBFAMFQMC6k8K2LGmaimXM+fAQRT/km5Fk8kpgyvMaPS
 1sgXoOMb9Jpq9tf07QKhXP2VXga166ZWwNR8AOtMOHQ/Rfx58AMdYHbuoGsWg9v0RhghC
 OD8M9tae8Acg2SknzzfNW18IM/mdAW3F8F/6nOEPeerF0fEKvJ4sSsNfg72c6nEXWaFpe
 65urRuP6dqdQcC8jj/zkqlG/p7jQ9a2JoXUEDeEG78V7UsyPSDOKXjyEkEBdFr850Rg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="pxXvhI0/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YAaMIubQ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pxXvhI0/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YAaMIubQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6F10400AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695105h83242494
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=; b=pxXvhI0/aTyaAEQk
 azcImqEUfyIBpOyKJxk0BGQBvmdPsPOVyitPKf1WewuWwaR52svfwbx6k6FFlfss
 RStmLQMwerIR3aM0K/qw1FlzrF7S366Z1DdXmPIPFsk47KesKHNwsZL9TOhjdZdY
 uRG3Hfix4977l0jfXhDKCatfBoHP8cqcPo0O8+Q6drpjAmgJ1ZZmI432xsm1mJVg
 5KXAjYi38O9bP5jdLlVMRWnYWdW+bYsyOyKGsswjICVnWH27Q90Ij2OomfozKA55
 WT8TKxRtuvh+k45AHMV5P9iBKUggfFkAYX2vqJ6UNO618wr3wscvRDTeAcjKZjZ7
 /gELTg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevp66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d80ca2184so1953761eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183789; x=1791788589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=YAaMIubQYcSm8EBmaw0V1QaBvwJrRvLkj7Ypkp5Z3Q4jM0PprzRhDF/V9bZ6mxr+UE
 Vg/pRjrtX81yrqJpwOqNpmcYmx2iXvT0TMSS3AP17U+KpvEYSuRoHMslvhdBdk0oYCZF
 ADtX6rYfrTuZwZYzMzNzf40YLXlk8gNAiaWFdtLez2JaTMWWNXg7W9aC9fnNN85JFaXi
 HnOnIneym72o04gDU90NBmkbifaSxjH+e4rn1pqtgkVBGRB+blUDVtObkT3Q7yJj8Kpp
 4stPrlPyd41A+Cp0crKnHFWMSbQ22M1CvdETr2Do+SHgUgVsZwY1/SUeVYTITonCpRAM
 IuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183789; x=1791788589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=Ka+cB4AV8ubyDa1wNRcugQL/Rl9aK0fy95hKl1m+sQxZtT66KhyJJm3F/GZVkwc2J2
 TmbGrz+hnyqQxxXXPovaJMMV5efke5Idq/DIvfq9XpkdeoQ/JvIDBHBs7voDL18WPcl9
 KyGsPfuTLOUwnO/yJYI0YLV8dhINW/reEM0wlCNMP08bflZFW74Od85GRmIlr8a6qt9F
 qZZ1tQHpPbkM/1N5pV+pUuWnk77iHs/UcCgF5MkG0g6ckEwBPnuEtkNaVzcofdPdJk6F
 6t82oPh/d6Q5ExB8CxNA+5Q4U2LQ4RTZzVbQWoFyAoW2pCQ1qZqPL0V0BHKgmubOOTQ2
 4tyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW+fH0oO2Ac8t9Hr5/4lAyd4EI1bbCdw24WP0mN4kc3IgxiyWgckp2F0St+bqt5nvRCa7PxvQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m28qKf4xIqptsQasojTXmZxY7HC6cZq8CFHHulxrcRqq1CxDHV
 PDmIIaCHaKyZS6oOZBe0HSk2Yb1IgjRp1uQfaKrDv/F2oledKh0VddTk8hMng/2EOvUt9skncdM
 rlChI4ba80Z9XF9zoRxEjzS1c/hqu+pt6lRwfl8jJX1Xtug42z328uIeIitvpUFJTj07Rj7jlg8
 aov7s=
X-Gm-Gg: AYBFou3T8MdrPxe8Q/pnkLWq/KRBqa4eLpk8qsK7Rue4tHa7HuuJNMbrLH9lCCargnP
 GkBhOuDzTrmaoSIH5mngp9HSSLTHcTwdz+HzedYkxem1Ol7CtI/d8jys1muQ9mhVQb3jDTXC/SF
 f743PaqFNrOLsxlSsssT5DxdfO9mqEtqcNlDpmZ7KAq7p0412GmFDNZ/i6j/Ryqbvr3HlVtF4v9
 mJ8kg9fyzZny1pXBZpUET+RifFJTCNx2yd8sfaZp0KJ81vayR2ARpLvS2BTBQ3o7WoR/Xn5X6eW
 gSF8jz3jR/atBMVQNffIodr8ziI1X3yBfLwhAvEvZMTm4CZAIlqFzgTvYLRlB+ern9OzlPGgR4i
 VUO6QSWceIKgrZbFww6bX2ONONHZ804LLNKxmKnuE1e4QXrUvVnCxciPMFjg834bLOB6DwW2RRq
 yduBteA9f7tVGJWl3wLn6CZZCxW43p
X-Received: by 2002:a05:693c:639c:10b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3511bdbe7ffmr6121622eec.15.1791183789462; 
 Mon, 05 Oct 2026 00:03:09 -0700 (PDT)
X-Received: by 2002:a05:693c:639c:10b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3511bdbe7ffmr6121568eec.15.1791183788892; 
 Mon, 05 Oct 2026 00:03:08 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:08 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:20 +0530
Subject: [PATCH RESEND v10 04/15] mach-snapdragon: spl: Update boot device
 information in SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-4-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: gX4nJXKTLBfDRLIGoVDas7tlZyIAzmqP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1DRjnhkJwNih
 mjly8+eQ9T9OhnOcxYKQVm7+8lZo7p4HibN7vqtnK8hI1vMWsdtP1M5QiwHV5ZAkvHEb6M2ByOA
 0EAIftpq+wXMdrFufcvr19niq1S7a8w=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34bae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=DQyr3D7bF9Lo941LOacA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX06zMC1vP57G8
 u6HGWrQP+LH4GuZMmk1UtJqr+Oc6AoVJmBkAabKl3kp42nEDFWmvRD7hTYl7DGGJ7wOx/WbQd1P
 7QqtAq/DAzVRaeiczfdK6btP07TWW/79VsqK5SZoS1DQPisadc9kngb8tJ6MdsEkR4IPzK2kZSu
 mhilzo5itk8MwNLY7s5nJyJ4uqIi8P1ri0wSFgBapSTpgSA0ctYobFHZhGMmXjjp3CCV+Td8ymh
 j53i20aqG+mgeIf4Wd/O2JwC3n8ysptJLfuf1paKA/FWMEMgNvTKs8g7OehheDZWl0TpBwWtsnz
 ijb2LR+FgoHa5riG3JIKc7DeKZmc7ONd75Q6UOH+R7mwhnwoelMXYyKE08B/GbviTgGqm3ZIQjI
 VQfx4nYFQ3bd0F4Sma7Og0BH+mbxbHU2DkH/ySJrt/wV4uKuKsMR5WUPAHz/VOJL2+mG2mW6pGa
 /RzpOEvApxMyPZNW99g==
X-Proofpoint-GUID: gX4nJXKTLBfDRLIGoVDas7tlZyIAzmqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Update the SMEM with the boot device information got from the boot rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 41d8789a002..460d07ef0a3 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -21,3 +21,45 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = qcom_smem_init();
+	if (ret) {
+		pr_err("Failed init SMEM (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+
+	fltype = (u32 *)smem_get(-1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		*fltype = SMEM_BOOT_MMC_FLASH;
+		wmb();
+		return 0;
+	}
+
+	pr_err("Boot medium not specified\n");
+
+	return -ENOENT;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */

-- 
2.34.1

