Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D69FC98318
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54D9481294;
	Fri, 25 Sep 2026 02:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbVyQXxIGCRc; Fri, 25 Sep 2026 02:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BFB081297
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304105;
	b=cHMp2zqTfdQVdMf4mSfbHHUhxmaV/o4MIcjmOEb7wGasCG4v9M8xnsd4aYWLwEol+ZAE
	 gsmacWM+wnPPd7OcamaIvXUJwLf4QYVtY6eqb03d/hnFqBwMtmB6I/JOsOLaoI1uoboKg
	 jnj4yM/pc8JToA47mY+EHePztTJccWiwx9dU6hHwlbDoBkYReaXvym6VBzAD50rKu+Xl5
	 F/tDNT/32sX1GBV9Zhat8Rijfwvv62Zmao1Qzwy1ZqUDSHIvUtLT6lOsLczW2pyEg8QrV
	 qO4Vvnu6FdODWtsUZbv8kT511h6K7FdiFlkq8hW+334KiFqe9hCXH0yYs9NDedYnzVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=;
	b=gscHZBIc0/hY+9ftAI82L3ueroHML/iDXWzsVpIuvqxJC4909jKfeqTBjaPyrhjuf7Yl
	 u1PcbqUTllm+zKmdkocUzm5OwiJO+Su8t58x4M9wHtvkw1TbV7+2SRfW/Ue9pzXCWKqdU
	 2rofteCj5XnqBjClzAmedtZRJrw5Bc+FpvIiw07K5bYJjCUfycrv1xHot4fnMugYCLT75
	 nkcdtefr3jApxe+5TqrderLDRpsFoQdc+ibSVArggOlD5ahmrnSz1Be5D9ziWlAKbiV5V
	 /5kXRmwiz+UHtSQDZwxkNW1ek1GdLBEzjlrE6Qn7o2hEhXZ0Xc2WOnZiQlp5ZcbvZjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3AXKPnh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GOzXdIq0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304105;
	bh=8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hn/zQbsOs+Tvp9W9qfKVwuciVMFXifvvLpKcxgV9DLlp0UkMYjnygQqi16+rV8SwG
	 u/g3PxMedJ5beYhAy3UhiM16XC2PTvkL3TUS93xIteKQrWuBNCY7KsuWn5ofdonjjG
	 SOtQdg+HKA+mvKzKn7SpKESVaEJl2Oyzh40x/lQSUDi+hdXSMjsilW25j2nN2OvMVj
	 5urdVT0zQit+MgkSvB8MSwN1GT8yjl4jKEODU1WQFr8i4V9drJlGP3YfZjnbPJztKZ
	 DGKSBLlCrlAmkcfLn9ceO0R/g9zs6/AzbQSPMFHeQcbjc8o+DLeus/MgDKJwh/ZFCZ
	 XPeAlgV/tmhhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BFB081297;
	Fri, 25 Sep 2026 02:41:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D59A332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7BE8811F1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y66wBuu_MkoQ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 078BA811E1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293093;
 b=lfWWnmwToNJz8kuWHUfq0LrtKtulqvEkV12pbWIYYF8SlliLakCp8Kpiv6E/Jm7NvMbz
 XN8DgUrqZXcajKz1BVBAIp9XQpJG+WOzXIDWPFbXUynw4vhEDuK+tTpnfUwpAYGrt1UBP
 mNq2xwI+SXeAOVoQ3uodNbxl1DJHC9xvoIrswsQwFDEzffmJK9nhmrvCXDuTPY/buJGrT
 58cRK6AwsXlYOJmk53xUqCmTWQWT/Ynl6/iL34Cv1YqYJNFflcrTwAendgcWdemFxwHn/
 +Sr/juUXINxagw0nR+l+UynEBIULHxK9awcT+BGoQLtN+ymlsSZQWAKZbDwo0BvK35w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293093;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=;
 b=Gyk+P00Xp+Zyg3wBGdDpUrLpVeLPESR6dmp/FPwQFVtYB++Gb59J9vnIs1/BYw84Pzlr
 vyBem0aVcjXBmEckQkzOw+6eWE74XrBH3yLsAa+PdZwqCVem4Dgpz69SMkJHje8dVbb0K
 ZqAY9IYpkcBUowZbhogTGqV8S4M9EHBcAhyDWHFGI8/ZWvRENOH96XORbrFM+QS+k3tEP
 E5PwHS5lCfZv3C9RDi00bFn/N6RhLbFXZNaW6xnM5g5zA3dMX4jKS400Rl8eFAdzrHFH6
 LHUAmffUpHt6jlCKvIPWmV5ZAT5GQFhyzxzoY/Vu8oSKOou5/UQMeMrMTynnuwILsmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O3AXKPnh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GOzXdIq0; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=O3AXKPnh; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GOzXdIq0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 078BA811E1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMOxFO280396
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=; b=O3AXKPnhSOovRcnx
 uYvNIvddjxmBq/nl7HUF7z9HDrUmGnj99Yrw0bYVTTrg74StCSaEgkrOjUgcgXRs
 GUpbFQOxmjjpVg978yKDvAJpFJcWvEVkUFsrzCBSMlkWnf5d7d/4eUo2Dz1LywKk
 cxBD6RAoE8WQD1JNiSJHZr6RWNYRMYL3T7F7JyHNwYNzZ3RKooQsSqQU61u9VjCO
 OgElzKtXodU7n2hGfnY7Rrqff9nBWV20b9cZ5RQMOs4pYePTa+gaIWXmBPeRYshi
 CSgQFaulCPJ1aDnp4d9YDxkM0bgQ6wefn2ERY3U5fLpHaUTL8f6yaiNss5csReZp
 jPA+Pw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7871d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:11 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8865abf21fbso5212577b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293091; x=1790897891;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=;
 b=GOzXdIq0kCt2Ug/Uzs0E02xwQgBX6linrG3q0/Mfhjf/vDHi6UYfJgSJNi255Nl+NO
 xohPVz804Kr/SAbkMQ0oCRzuO0XXrltY2kg2FnQHIVv1o1N4ySkSnpYM7mPsGIlC7Ivc
 kg9SRY5fpSGWn6IGe6G97QK6MyUDPC6rYt5+8cb3cKCzqbjo5VkYmYdGA5ldzOvF1lf5
 jT45BqYz1PN+JDL0hgioheDMFQDHYpA3Fr3wTaVv+3MSXzWSnA/5M+cz8Eg3dx+NbMWE
 Ja+HTqe1hjUv6PK2cZ/zgpf0vOoVUJjMGuySzsFctY4AfRU2gBd7VI4rGtjMuS/K4S20
 3U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293091; x=1790897891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8hZRgfNw6D0tcY+Q5eQMo9Y+p3deGFzMOnSO4E4drGQ=;
 b=upMRlSaWZMv5c36jyGcSeQV6W2EHSpTWtEO+rf9pvGKgEZ9NLQmOr/lxTqMWU11yfc
 dR/QXVy5x2kJ14PP3aijWxgp+HpTgvoW3fGMTB2vs67uT40QEEDo/tWQp/gNcDdKIn20
 gWDCi1CysdeHDaHtTV95lp2qhuH/eynsC/tVSKVqxbeVIvU/0gfYr8EfWIek1V1hH71w
 mDrLJyBgAkW0bhTlS04Ug7yj/+igY/E6SBYJHVsD4d2vvbOtXe5Xl6nElkwWgtJp7bV0
 PYr7gUAxICQ6NBrUMmuvSb8TIOEwDwk+uulXZ3V5cm9vqcOyCYfPOnmPP3wpdsmVp2RT
 SJGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB4pu0KgJjY808ADB8yn2/Kl7a3o2MrDlrWdXr5Dmzna1QcQpvq7JvlWTfWCPpvQATsrdy1HA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmBNva+dW/L6i+RM1b3MDK81XdGpkEktNV6vrI0na9oomRrEy+
 ogp66lJ11MV/4CZxWcEB8nYmPXmQPs0BLohm6VZ38ayD4zFagwXYSnchtYLh2+Yzv14RBWBMxAY
 wPM6m3C2K4DCnmtAvijyHRWKNYKYV9w58ya227lAldUvpZhPCUSbVpscwcTvnYfMnSOUJSkc=
X-Gm-Gg: AYBFou3U7+opiuXaRenhn0D8DtBmpFUP/02BaReam6Qyd4GZ/UoXmqVOf7Zv/kgNYwt
 wt+DnJTmh/UrT3VDAMlIWAjzfJyrTOoP9aJeIKc03KmVAJRAhiJnw4V6IgH7l2D9+ZHXnhCz13h
 R5Q813s/9lapIezVYPpRABdGc3fDEq80koc/6gi5SifdGYwTzpXMhrq2dMQSh8SRL3rVxZgzQW8
 sC7qT42biUBhOPns/B4J0j8gb6LfNUzQ+tnT0ZASjC2RuIosxFmOTw5UkmPOkMReENCZLewzALG
 CfCPLyjNC3N+gGWKjs1a/usAcEK8D14US88VauqaUJwSS15U07mQyCaBPDLdyJ6xnkyxh/p55nb
 FYJyTVBFm02PEi4EcHNxNNNMGv7PlO90RQfxl7d7l1D5QPLLM9bpyS5LzP9/AXGEIdfrHcHum
X-Received: by 2002:a05:690c:ec9:b0:8a0:5c3d:baae with SMTP id
 00721157ae682-8a6461ba5b5mr27074267b3.3.1790293090823; 
 Thu, 24 Sep 2026 16:38:10 -0700 (PDT)
X-Received: by 2002:a05:690c:ec9:b0:8a0:5c3d:baae with SMTP id
 00721157ae682-8a6461ba5b5mr27074137b3.3.1790293090354; 
 Thu, 24 Sep 2026 16:38:10 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:09 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:06 -0400
Subject: [PATCH 5/7] mach-snapdragon: add a boot0 hook to run U-Boot on a
 selected CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-5-290b6a4d10c0@oss.qualcomm.com>
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
X-Proofpoint-GUID: cIdF2ek9bXDTH_HKFvv1g28f89Ji-NOV
X-Proofpoint-ORIG-GUID: cIdF2ek9bXDTH_HKFvv1g28f89Ji-NOV
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5b463 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=u_VYNAqGXo6OSSAA:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sGWNpmU6r5_OR72EW9oA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfXyJtkR4PCYjBR
 ijZ4BPgwwcjcXu3GmfxYK3WL4CuMoxndpv6AChedL09ek1UNtvuknmTCoZ6AIMnDKEt2IwA8YaA
 qqehPRefk5GvAkAs/5AMsiSNQ9c6BycJjaVHEPfpbDgbffwJhgSPy0ekfVkbxJ1DdMILXURnMHS
 ExHou/cinE6Y41/JKepvGNAB2IvNh5vOvranbWq3Kj/rG06Y+RDXr6G6QYnVr49T3gy/rnc1i+C
 BIlMepgE7ZIY4ishW6nVP7W+NjVnC6GPiJyK2ZU+48fDTysW2uLbslSh9wMMlJB40Z5Z9Gn+3r/
 e6NJZL57wtICRjgGDon0Fth1eDIdXAn+SM/epwgVsJEuM+l1TC0/bROTcL+anbrdDxg/Kf19WT5
 lHfn77cxkd8phk/ZGSizmvGDwPD/y0zJOEiJ9wWCKzS35h5ua5/Hqe7ILApC2WZpahzYyZ58DDT
 6DCd3K79/3K0qoyTKow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfXyMRWLqbYCbYK
 MNcLqw+6hz8Rf+pR4V9+mNHXb3CsHGYPoy37a8zwTEt3Espa0/VmSKwvEIx1Hu2R5T83fciBgxE
 LWRwHjyNYcR+o90eug31hi1eq/IQvQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
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

On QCS8275 (Monaco) the boot firmware enters U-Boot on a Cortex-A78C
core. The Cortex-A78C cores have pointer authentication and the
Cortex-A55 cores do not, and Linux only brings up CPUs that match its
boot CPU in that respect, so booting it from a Cortex-A78C leaves the
four Cortex-A55 cores offline.

Add BOOT0_QCOM_BOOT_CPU. On any CPU other than QCOM_BOOT_CPU_MPIDR it
powers that CPU on at _start with PSCI CPU_ON, passing x0 on as the
context ID, and turns the entering CPU off. If CPU_ON fails, U-Boot
carries on where it was entered.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig                   | 21 ++++++++++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/boot_cpu_boot0.h  | 33 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029e..6770f5070a 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -80,6 +80,27 @@ config BOOT0_SDM845_WORKAROUND
 	help
 	  Select this if you are building U-Boot SPL for sdm845.
 
+config BOOT0_QCOM_BOOT_CPU
+	bool "boot0.h hook to run U-Boot on a selected CPU"
+	help
+	  At entry, if U-Boot runs on any CPU other than the one given by
+	  QCOM_BOOT_CPU_MPIDR, power that CPU on at the U-Boot entry point
+	  with PSCI CPU_ON and turn the entering CPU off, so U-Boot and the OS
+	  it boots run on the selected CPU. PSCI is called through SMC.
+
+	  On QCS8275 (Monaco) the boot firmware enters on a Cortex-A78C core,
+	  which has pointer authentication, while the Cortex-A55 cores do not.
+	  Linux only brings up CPUs that match its boot CPU's pointer
+	  authentication support, so it has to boot on a Cortex-A55.
+
 endchoice
 
+config QCOM_BOOT_CPU_MPIDR
+	hex "MPIDR affinity of the CPU to run U-Boot on"
+	depends on BOOT0_QCOM_BOOT_CPU
+	default 0x0
+	help
+	  Affinity fields (Aff3..Aff0) of the MPIDR of the CPU that U-Boot moves
+	  to at entry.
+
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f4..2f6b724fe8 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_BOOT0_QCOM_BOOT_CPU)
+#include "boot_cpu_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h b/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h
new file mode 100644
index 0000000000..0b9cc0bd58
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Move the boot to the CPU selected by CONFIG_QCOM_BOOT_CPU_MPIDR: power it
+ * on at _start with PSCI CPU_ON (over SMC), passing x0 on as the context ID,
+ * then power the entering CPU off. On SoCs with mixed CPU types the boot
+ * firmware may enter U-Boot on a CPU the OS cannot boot from.
+ */
+#include <asm/psci.h>
+
+	mrs	x9, mpidr_el1
+	ldr	x10, =0xff00ffffff		/* Aff3..Aff0 */
+	and	x9, x9, x10
+	ldr	x1, =CONFIG_QCOM_BOOT_CPU_MPIDR
+	cmp	x9, x1
+	b.eq	reset
+
+	mov	x9, x0
+	adr	x2, _start
+	mov	x3, x9
+	ldr	x0, =ARM_PSCI_0_2_FN64_CPU_ON
+	smc	#0
+	cbnz	x0, 2f
+
+	/* U-Boot now runs on the selected CPU; this one must not go on. */
+	ldr	x0, =ARM_PSCI_0_2_FN_CPU_OFF
+	smc	#0
+1:	wfi
+	b	1b
+
+	/* CPU_ON failed: stay on this CPU. */
+2:	mov	x0, x9
+	b	reset
+	.ltorg

-- 
2.47.3

