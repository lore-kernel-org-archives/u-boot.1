Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA077606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JuygrnlF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F2NtvEeD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y+RLjIk+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44CFC81175;
	Thu, 22 Oct 2026 23:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9sHo0NPc4Hi; Thu, 22 Oct 2026 23:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04F1880DC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792712249;
	b=nasnmfYRzz4vbCjcECDKbKoCfPHnlDUEIbkW5SxgxtKvE0y+e4CwOaMw8GGFtYDcdGvP
	 AcmX9p/PRcFYZ7Xg+IpOe2S7Dr+CQWMKfea8ib9RJvL91oRlRVfuVzndjO50fwK4KjLDL
	 hnk9wXJnlcxNuOql6KIbQaq4DdLQCNBk0ne/PkOTF9klezjrc9DRaJq9ncjsC13wBBi8Z
	 0oiFtl+998whW+CYXsClanL9pz1nBA2rjQGv3Mmj8es5tJ5iBsOfC6n3xalxLo947RUW8
	 ws/imo/1ClktF5Tar869xpCCtQ7F3W4lzzh2GqQ97Mqj1gKbd2LgrzgjgH1C/JgmEVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792712249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=;
	b=c2pn7eGtWoVqny93clmSrs7gPuixAulWF4JvmZJPXqM28pUu3X/yk0+zX9Egnp1XYc9W
	 8YA3kB+0e3EFN8y6p1nKkv0+7h8+RjMZIvKp8P+b7Us9Mj9i1qzDtINxUfhlTMQGQSVxh
	 CLsEPd8QPMiepwj8H4DVfyrFqHmMaYyM/rD6SrkylJP/b8XWSG/SE0z32I41PhS9LKbps
	 vsUFcu06i6sOjX6iD4894zasTRADRb+aireMhkEGVfzFUUeaVUs4q8jzok5VeLhKxuIPx
	 NuMRCNbBYyu6vFYHSEFAPRbEfwJZkfNK2Cs85/lvMgDQOVMTu63es9xmTyoIDDWQ/nQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792712249;
	bh=mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuygrnlFxo5hfGU14uNRQ7q9C3rPSbvcfYHiW2wXqd3pFoTa1xHtdjSEweKP5cTHP
	 PgzwloY/va7BCPav1SAGB7is+HV/imhU4SJeNXiV8ErUIsMGcSdpM4EgHiad5GLrgz
	 OK8SiPBe6+dbrdunbMhRi+z6sJoFMNKpk8Lqx8iOUnfe3oeYwEXpmMwAg4v3QPrgix
	 +gOVth5CT5gtJxPZGxFKtM2Taj7wEpw/+aTXttikp6b9yV3TAFr1TzVd7qjJ2yxZO7
	 EpRSkUjy+1wVk+Rrf63rC4DRHiIsGkvnH4CFXyxLw5h57m9xM68dSf6X4imnqOdTj6
	 sY9RLfKBdnAiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04F1880DC4;
	Thu, 22 Oct 2026 23:37:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A1C49D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9463A60633
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C7E0vsqhVdyp for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E017F60627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792712245;
 b=HHGEoXcJ5lRvtZLVU1JSIWgUWzELfPcnPNuI9JgxbFNP7Cr91qSl7n7B71BRRwbcaMm1
 EwpQqgQNu8ETgLoPOLKOx7QW0qTVvvZs/4UubZf576Io+cYWI5qu6tQcqeLdkCqFlaIRU
 S705bMWUdUMala6OGab1IwmZddI4BkU+hIMoPAOEX9b9HMg8TjJGXb4A1769gMNOOuKE5
 I2wg/Yz1/Z/ptNIlkkasldr2mWwLta41eBQpOJWE0syvWa/5OQH7kMErIjo3L5XVTcMvs
 qUSHoq5lBWSHqYOpMcm7s9oSCNP62l8L4z9LBrq0tEtGLTlonClCQnd6BG5JVLeY95w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792712245;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=;
 b=bpKb/hE2iJgeZuyM0xbOtLUnxoJJW/dwrzVivYiKIij2kGndaGIauJQYxM0hgxEgHHlX
 FxpuW80Z+SRLQRfmo/8NV17VmNgPi1LtCESgssWA4fyIstOExnjIKL3HfyjozdOJAmV/r
 gcY6aHeWap72/HXOA/zd2QSV1zyxQO0vRBd2Ohnx8+ZDw89QQFnVmYapdbxxLvegVGRXE
 XPkOvA7oHOhGuVd7LrtDxa5iG67wZc/01UvKXe1Sr1vZX9H6wd+V6Kk1lhLJLCTG++fwN
 XarWRzJQ6ggiO0yb0ZXoQCbXl//r9RLoAY6lDTkL1poA8u5vRNhUQCMKF/h6hQbb8zg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=F2NtvEeD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y+RLjIk+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=F2NtvEeD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y+RLjIk+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E017F60627
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF135956124
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=; b=F2NtvEeDno/A5tvJ
 dILtzUJ7clG7v1xTU3URwbcjtl0QNQUdKW/pLc09AfsMnHaFnNEKc9/PERr/UvLC
 D5lSAbbVW32yG4zPQKfb+7Fr/uaa3iWULIZbCCU9kha/h2dk5xw5eI6fnfOrRw4z
 o1M9WIGYDUFVtMJWYP5wPXiXVOTv/8TDN4tBv/J03T02g3UcJtEl4FevWnfBYO80
 J4lJQfa6gOmIfnrbGu1xTeiHt9vPulW0Rw/mv8Vg3toBdo1HMDDoVGFiounVBbZL
 V4jFYG5EQAPj2HDNxwS+Ig2fC3mn7y2OAGS4GwXQczoYuIkTZnd4/3o1o55+CKKd
 rX/HPw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8f6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:24 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-836caf085e0so6051837b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792712243; x=1793317043;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=;
 b=Y+RLjIk+Iq/8kYo+4l1I+/BEzOqO9mhRZWzsIu0H5NAc4CjWzPE4IF9G7NrY8bmbff
 Kdd794cYgAxaog7f9HciIs8MRAf7yRcZH+we0T2ODuvSDkmYyE9pCN8xj5bs20KEaAoD
 eDLMVMMlC18ye0HFll/TRw0i0AIsoMXir/XSVo3QyRKH8nccxrzVSSZd87L7mRbCbpFA
 36RCJyrfe10Keg0HV5n2S2d54Q8gwaMXFkp139qQ6m9AX2098NGggLRPTf8hkr5lariu
 FxBeR0kFIdAYd2JcmSvMr6ryHxWp9wSi1vVR1UK0IQkd7ef8kT9IMf9l9Ml7sO8tq5kM
 /3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792712243; x=1793317043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQfNiuwOrRspifaqd2feTSlBCPQ0lfbPBXFWJ+nnDZ4=;
 b=tcB74+buJZ5Y6fSVCAHFNJAxRFNHgr4Xbd3mAveVZh7AlzWfKJx4XqtCsGLJSTfrq3
 Jy61a/XvFmyyEq/6hqh3Qkos5wEP46rCJWcHve4wey6JKi5qTT9p2Irpt3BvzH5j5eVg
 C7GptH8jkR5vYisDXCJdG8E1ICjvMRHKAJj/GBuXfWZ8hbKPXPnb7tm+EP4KYIrwnS81
 m7Z8G4FmtdZvKK9pgmKwnD08yAredQL74J4HOXsWSZgFbM1dqgiAih1VmNYzsJ4MOZ9C
 jf+iMAoSn12M1uDWGKYdKTNeIWgWguTx9bLcVhzI7eKl3JOSSFzwOTCQQyo0VHW7qOgs
 YWDQ==
X-Gm-Message-State: AFq9FYJyYEO6evCdaOdf7YWZNiM+zxVecr7oSKJrBWHliBVQUUUFnRwX
 NPsHgiIqV82J8HDaGeLeprVBj8sJC9em9ESiOk3zDAPcZDPSJm/IayzdZsEnjFCYdl/JrAkajGC
 OOhTqngG2G8JbNJRuMLBCUWIl59IrxJ3x8FYoHbZe+Evkahf47CM0Jgeos3NPbrPbeot2Z1s=
X-Gm-Gg: AYBFou2+tL7S5V2msMjzR2Jb5ZhuSwSb73Tl2FcA4qUBdt26+Zf0iJSD+QDvBM9xBxB
 G+BCcvI/biXaJYkwYOurrIS3KUGmDvQXuCzYJipKc7D1+WxJA5OyICBENnQgk/Oscp1Winoehlu
 XIu/fnY3c1Pgs4PDdnMPdm7fr4+JpLJnGk1Ab2ndoMWek/nxpdrlGp6OIsh2cgX0461tZB43a7+
 hyg2X7T6/YwSEyN/gYF5zMk27yI0ZzsMwxAsfjiT1RLxVbNvDJ3MKDOgzk0vH5rySpkdulfVsoS
 Edy9G1K7mbLQ35VzjUFyrW6HJLM7g7M+gHqcBaAT/ZLnJYxiYRaGfr4lQjPxlZYO0aINVumOJNN
 kSsxujGZSJvS2SRYaFe3iLo/NmTpRBfOIjya+dO+6H1CB5Ziuo8DWtLLmG8Mw
X-Received: by 2002:a05:690c:fc2:b0:882:b4b2:c49 with SMTP id
 00721157ae682-8b157da9e39mr5195017b3.18.1792712243096; 
 Thu, 22 Oct 2026 16:37:23 -0700 (PDT)
X-Received: by 2002:a05:690c:fc2:b0:882:b4b2:c49 with SMTP id
 00721157ae682-8b157da9e39mr5194787b3.18.1792712242685; 
 Thu, 22 Oct 2026 16:37:22 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1561803b0sm5687367b3.29.2026.10.22.16.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:37:22 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/2] qcom: capsule: build fw_images[] dynamically from
 the partition table
Date: Thu, 22 Oct 2026 19:37:19 -0400
Message-ID: <20261022233719.858880-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020-qcom-capsule-dynamic-fw-images-v2-2-3824f7a66e1e@oss.qualcomm.com>
References: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
 <20261020-qcom-capsule-dynamic-fw-images-v2-2-3824f7a66e1e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NCBTYWx0ZWRfX9YnbqkCiFfXw
 qzsd7A6omvFDuBwi9HkPaFmvvLZ1SNxluqmUNkRwZg2cOhukCZB1szgdp1ElZqkdDeyCqV5kCw6
 /uqpskPn3GjVfZDwmuKhOMuD7otJliH8G4tuZiUss1ZmR8ld2E0ggqt9QvGlg8FBEkAo8kbAwAW
 FV4Fr/g+OLAb/MDW1FkMzcfhMjrJ9mPY0TCUE1WFgfwzO35AsjrywLqeYcLZXX5ivF+x7M73S68
 zIXjSrotA8+sKlgLEBktdU/Ux1apHyZ8FlqAHe3u7MXR7AqPCCW9KMe4NzQLlBtCLZfKqzIMPrG
 VnCyNYMv8f4oXjjg40Ce954+kQ3gpclNeT1MgRcuDZIyvwqsLpkNFS/aAAD8sz44whzBuePpRIq
 E5czxBBqRGzTZnyz3PILXcJUapKks35nZ3myH/S7rd5lCfA1hUIkTLmcV8DloJstcMG9KvmDlL3
 ZauhhiqBythe1RBCtbQ==
X-Proofpoint-ORIG-GUID: MiBrhYu03QCj1Voa9JmWiFkyzIScm6zs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NCBTYWx0ZWRfX3CDMNeE6Fnyq
 jfSqrEpADhOQKEjaEtDELwnTuKcm4tYOvbm90lnMX9PYcvs+Cwp8KU4HcAN2pnptap+aoBCVaBW
 j440lzygnb3Rhvx6dxqLHG0W2dNDuiM=
X-Proofpoint-GUID: MiBrhYu03QCj1Voa9JmWiFkyzIScm6zs
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada9e34 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=uAcrCBltSt7Ij3L1wJIA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220094
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 12:31, Balaji Selvanathan wrote:
[...]
> Each component has a fixed image type GUID  so one capsule applies to

Could this keep the per-board GUIDs efi_gen_capsule_guids() makes?
With the same GUID on every SoC and no capsule authentication in
qcom_defconfig, an xbl capsule for one board would flash on any other,
and LVFS couldn't target a specific board.
