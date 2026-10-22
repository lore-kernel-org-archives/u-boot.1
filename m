Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD567606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zDHEVVQE;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WeO2pHwd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=avcayP1l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DFDA40577;
	Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjBTt8YcPY9O; Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A47CA4053D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704845;
	b=W2CbuGTsNb//yz8SzcVIykNLOMacEzQLav+ht5dtwe7AmX403sAcUaD41sKGTJsvEaps
	 QluUEA/Bd7eN1TAVDpLmAx1RMl8VpQGtwuV6hzrvyfUyH3/227QdPoR47KLxV7z5IDbz0
	 LEpxBcyNp1bicIdox8JF5t8UvXvJLGn6xFgdihyiq3gih+I5CJetEbyi8urlApZ2pTG+V
	 iw6AxyOy1gAjWPHPhZbi4pUTOdnvl6/G8yIGPBS1OFEmbnGOsD6xrS6OmtC+P6sUV05+a
	 Agxpwl1GApL4MTsrcd8W73KSuMCrGw33++tOSoFVg02rZtcAKCbXs7axhV3N2kBmc6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=;
	b=qv3gWKcmXk7gj6TyH2HpqwTP/oNmpT0VLoVFGRfKFbBpDIVIM4t0O6gyeBZ+tosGqmgp
	 JNs1s/4zc1Mf5B05Y4euF+CLJNvUAALiX0RIN+soeF+UKBKC5QghWef1L72CRHqN0cb14
	 dqTjVJbEqMk4xhiS4GfZRF5Vvz9239Qb9P5kYuAATSYrR4d5XYAFLPqu5EXfKAEAeD+yZ
	 /uCmomu/dq6hmDc4IJP1mtMo7ESHfmdjbOI8YGVKVst9YUM4v/e9zU2c/JA2LehQBEdUe
	 WbQFOXEY6B6r0GWNJlWcwB6vjtUaUPjtdzVCVvT3drIwomJT2VSvV/podxvr4ZegpdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704845;
	bh=4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zDHEVVQEik45mzUfS9YUQ+7cLg85RaBk8ro+7ZHXrnw5X0jZSUH2lJsqst0H5OwoD
	 mm6AE6FS7Tr4B/HxHIWeCzxR6FnRyS4fBGtCcKKXqlhgU2+hlsTbuOEfyHC1LsWpu3
	 2SKm3ecKdrFh9Q4o0vnB+bOVzJglxcWixGD3Qzbkgodtor9RV6ulPYX4Px6pZHUe3T
	 /wRFbgcheF4Eg3NX00wUqqin68FKUGhJvrWzhwXTEg3XPJqfGy5Lkg4j01HhWae7tF
	 sVjz9TZc9+CTwGg8ghoAD351eDr/vQu6/up5nQJySFvSzQriJafJQa1iwiN67uFZfU
	 hFaMyYfkE9pDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A47CA4053D;
	Thu, 22 Oct 2026 21:34:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C2F43A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51ED680D44
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vovTKm-fNdgS for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BEFA80D1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704843;
 b=M/CP25rWegAAHIwPGZ32GmOAg5A3FoVe8ajgGIIzt7NIef36Q4w7DH/gHe1/5VyK7MPB
 IHP6oFkzuXV1c3LGfLuOrFwKHzvBRtRm4pcVU+IzMhe511PbuHUgVigbnXebSktBmCV4c
 tNJdoTIz53LY2NQXgS/QfmSaG806nEAgMwlb5ocMXmffhux/aeZcyRPhnj3nSLB+FCAnU
 Q3/lUjjwIpiL4STx0CIHEaan0geKUScYz+2Qc7Ag/eXpZCrSLUFlYejITm8etYHZfIR5u
 /SxANKLPpi0gx3VtSIOSL5T5aow3yvj2qXg99Y3p0vV+dJPCpxLfXcOkG/DWrU2vSxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704843;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=;
 b=XpMlH/jJqdbwPRNz7/yQL9//NAzKDLzpFT07xeeJm2VMIGri8h3DUiy1k68o7kjzjsbs
 wAYp1NOcUXkJdjoEOhKW3yFkhw0xREF/GaUjdVn02FCHVw1Ee571GiJph54/Ec4nIvugH
 6nkK0S0lAz2pWpIGXhBE3VScFf/g3ejVg3Kq2Q8bYV3QeIwBcJdx0MQp1U81A9S78fkB9
 t2lXjSAkuNYJx8pKXUgfmY4UyooI6Hv18L++Lg51kjJ56PmTkYDw78vAbZwMAfmTa0R1H
 RrGVuWZJLMi02k0qco4eAkBCBzA8Kob9uXataE60eXzkODq20LFciRYMuprq/EYGnsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WeO2pHwd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=avcayP1l; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WeO2pHwd; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=avcayP1l
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BEFA80D1B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:02 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBt03741656
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=; b=WeO2pHwd5I8Ronq6
 U3+WjLO2X99IbhHrXdI5Q04q8zNMai/UL6ae2vifcipi3ZDAGjcjHjeCDIY7G8Gq
 lLlCPW4sKR8zKnHmalOK4fB3BnU3Vn/g3xbINIb2BIfehbqJB7UOBwrUfVfyKoBN
 KZ0xSvLTt5z2rCXfLrwc+NgJIbKsFtI4kmBZBZcDjIgbu1KV/nm0eUXT19XeSrTG
 yUxZijuedBW7R8bPMVDL3j1Xa7i1E0UMTtG6ARV9UUUGhEa6VJhiqVDz4lDJDXTd
 hpUammYC5UmHQFyCqJo15iuyiOdp7xOeUfwvyXGHlmaavG8nfRT0yWSgfJ8ll5IL
 ChSsBg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0my4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:01 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0d978e4faso5674497b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704841; x=1793309641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=;
 b=avcayP1lhEJ4vgZqKcMyT8i1R6g8qtm7wi4i99HEK3beA+5B8a/6l7v/iTGqIqN3dH
 rEt/OA2/KUVmNQ7QvUFgjearyWBYbu/1fqbcPpYJnHUnleIKi1361LaAHYyMR0QmmTgE
 PZFTkqwW82RDzgBQRUPZfDdP6DccKS0P2Jio98y/Ri3XSj5HmAh46vvV6r2BkceiLL6N
 Tv8H7Y1YHsc6B6zGxFfpKfyZO7hhPzomI7S6ekk7kqjbQ2tCL4E5Fb5kX+0Qm+X9Rrcn
 RwXS/SgX2bs0XbMzeTDwd5hN9Eww5OdbAbFdc4fWSFzpSeLkCsHHa5eVuxtVABBPQZqR
 etmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704841; x=1793309641;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4g4ihzQUiVbyKwb0BmrNYbFDf/YR8tVxqB8isLRuSd8=;
 b=OU9U8nXM9d4OytwlLttI5Fce2Y46b44rr8k9Xz3s6GjoydY6r1dDCgO0Gxd1HotBLZ
 t0LafaPt5BzJz6gbtyXOQP7yNR/1/sDWOwDImNZ7WN6oB5gKKxzh1w4r8W4L0gTfj4pV
 bGVkij3isLdAIZfKwetxYESg1FohVmAng0kWT3PgAIt5wJ/W9KGPnAnQG1dP5UOgLBEz
 HZElLuTiJyeoOHQYCdCcNM3JY16xh4vZR+YjjJLoM/u0m9Oj/DdXx1ZIAp1cnXbTgBla
 hFN5ut+SamlpBUefSMkv1Gj0TKAf0XUbv286LXIiamX4433cMiFliVEKzV2JWakrP5NH
 NaRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsRidrpuOBUrgRIABLAYYjSsf/07miH/vQgIrKGwxq1mMnCYU81fLjRA2Qou+S/sxtmOuJnJo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjtCYm+F5kB7Y9B85CPym65dHCitFsPuU2cMMjv2HZ7DsPY8Mr
 cfHENONr1eQk2ZW4SsdPojIv+EYv0sKtb4YuzB9N0lasuu/n6PnhfeREUuqY2d3zJYx6Joaf/B4
 LIneiqlWHvA0+8WqIiqSoDoyYMI65i7+dGPU8MOKIefTjarhZhWFhMfRYvliLMsru8r+2brU=
X-Gm-Gg: AYBFou1jU3XHSGZtJlQ4/qMQfdSt/sQ2SVt4zjULvUHlhi3508YCnPS3L5HgKRfnAmb
 rEp3jK+kbww3byImRrpAHUZyY0e25PmMylw74RAXWUG3nRMqTbWLQursYqHJdsBQt2SmAefjSlC
 D+GN5zC04FLZRmKeh/rxdrhGw5YN0Tgg8PlNp6NldVA8fGZtk9iO/+tJb4+fMTiGZUal2bS8pMV
 QSRw6umlbCa//onePhebtUqDlpQ+FUv1EwRe6c0unGWH2Wx5LRS/u1nVkizxsRNDHK+D8892hz6
 ahS50/g5PIBZlpcITzTvos+CEcAxxIpV9zGxfWjpvAhcDHSyPQpYnZ1NDK158Ao5B3Qz6pabbLl
 Q8paiKA0BIEidMlhbNqto5ifjJ+5rrUKPM3x3itqbnrmxe3ep5LiP5lClSZUB
X-Received: by 2002:a05:690c:e1d9:20b0:88f:73b0:fa87 with SMTP id
 00721157ae682-8b157cf4ea6mr2068977b3.11.1792704841095; 
 Thu, 22 Oct 2026 14:34:01 -0700 (PDT)
X-Received: by 2002:a05:690c:e1d9:20b0:88f:73b0:fa87 with SMTP id
 00721157ae682-8b157cf4ea6mr2068907b3.11.1792704840773; 
 Thu, 22 Oct 2026 14:34:00 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1560cd2dbsm4455247b3.7.2026.10.22.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:00 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/8] arm64: qcom: Add initial support for Nord SoC
Date: Thu, 22 Oct 2026 17:33:56 -0400
Message-ID: <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfXxAsZPMydYTiX
 MlIPYbvvBWy0zSbmlnFdjYlRCvQEKJFAHOAq6EHd0L9BqM3Vi9AlOB++L1Tr8p9RhGvknpBjLQD
 cr0HQtSYvic2bXriEI5Q+jtNoHTp0bzNyKv7vYq68s5MW8M7FjN0DItd2G7EoIvQ/BcWIXndnrd
 TSLEkJ40ulV9baLvqQ6/C6tGMC+VKL988gMX1IVaaZxcATX0ycTenbWZeTbUKzRixQdEqoP1q43
 uErVMhzLI3WcAzJEFu9SK8RzhYo5nXl16ZJQFNiIRPNjWN3S2ANIiXg93cfbBWOKJzOk07MohZk
 M/izjFXsOZQOUWZM6oFc3MA0QMPILhV6r8zniq2I1AeYLk3xkXt/+iDADLBetuSTpsjd74mwXhN
 yQq7s/EwQ8U0cfZAZJUxYa4/UJiW0JGMKeexzaDf5zFzFty1RPFOhgHSnr4CIzfJW7Y9SnkK0bf
 sYqH8fsK8IXWIRe+TAQ==
X-Proofpoint-GUID: fTyrLc0bsrqje9rLBT9W8AEGWdkgw4zR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfXwuxhgYY8CmFq
 92Xqqd9G/nM98enReg6SyNN5z4oDliAxTG2GIqLXZzNlQzwy7Y7FObEvLoCIBZZKtj/xPxwjj2G
 8wi6MiYYxw/wimM4vSnVsdjkh8C7ZxY=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada8149 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bHe2IFQwpek75aG6VhIA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: fTyrLc0bsrqje9rLBT9W8AEGWdkgw4zR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220085
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

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
> This series adds foundational support for the Qualcomm Nord SoC in
> U-Boot, including clock, pinctrl, USB HS PHY, and configuration updates

There's no Nord DT in dts/upstream and nothing builds a Nord board, so
none of this is used or tested in tree. Please send it with the board
enablement.

The commit messages only restate the subjects. Say what U-Boot needs
each controller for.
