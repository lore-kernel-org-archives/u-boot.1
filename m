Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC4BCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 989C980DDC;
	Mon, 28 Sep 2026 12:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1u0a8bMpIVA; Mon, 28 Sep 2026 12:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F0B180DA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596966;
	b=Uqkjn85AZp4+oWBO+HT63vR0GDbCWL1GeJrDnqcXwdQjOnuTJf32VwTPemM+fL0fmopV
	 L/oYRNDXqGqR3VZizVonbkiRVMIf15q+r5KXwoGcwW0xoST8QUvOu0UozKzg7YZd4O2Rn
	 NfEVJ7Kq7d6iNPJetGbnhsp7PbTwjCdJwLqu2Fa/Oxu34AveStcoqQJE5YqfpxQhhdwVU
	 rF2XjdWZydd2BgubGKmK4Umlvj0cVBJ+1KF+BhF6ziM4j+y3ho62ZzCzbyjOzwLRfCMy2
	 sTdsTeoScLhodWp0Um0FkQhF3L9dBcRlqo1M7JgFlG20WpECP/X/3M5YfVRjDotIJlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=;
	b=G/WXTvQEdwDUaQnZIcPsd+MNp21shtoaTXH8zFf/2Twf8DOvzHfg0AJncuEfMqYEoV0m
	 E6xjFYxXjgQLZF/jQW2yVTMHFPmfT4egTWDa2KqqIAImqTMCn0+ytbVT2yO46tTy5LE9S
	 A9i2gL3hP/PUzOlQfR7rfq/kfFSpbMSz0e/ScPg4UJEX8aH2AvhSxX0HwaQvKSNXV6lyS
	 OCPj8BUmtObEFxZbV6tvYtcNuP13/o13odKXnCDaoD+F4F32aSGCRtAveNjJ7KCcqRPMJ
	 OK9PQZOyqhTn2MjIoMi7ZHLCbUft+C7bb+1M4GmMk2XZ9KbAhQCF+iy6wBO6lTBw/zg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="oQJ/dGBm";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SbQwfj4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596966;
	bh=D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fk4sqFOAqocSUmLPVctsY+gPU7CItbtYHecqQu5vTUFiyAt8pPgktoUOd73uVyU4d
	 2n8sgJcihvejp4lqFZlAVncRwVL5i5ZF0wVZ4/lPxrgw5LWJK8gmcJFHh3MfuFlRy4
	 hQk5zX0/U+iHBFhnp8n9ItsWqdElQDclQEcGRs1i69WJNZdqTuOfid230qXSd/01IB
	 3FeMaUUhb7k2nt6LXlMoffD6SKYJf4ubg7I7Cr7JVnVWCvfCn6e8IY6cZSilyAWE1j
	 ADpwkiBbASC2CQefjx3Nw/llJMlGVqAv4sb3mhTEdCgRRXwkEEB3oK8JPzknptvSZj
	 Kfmu6x9wRVatA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F0B180DA9;
	Mon, 28 Sep 2026 12:02:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82D242B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 684F980989
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJInrvYBOUes for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8179880DE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596964;
 b=eL32EhOI3lhBt4ALEA8p+OiMr8CG2YkTrM/J41rXC4zvwZ+IQEFM0WuKwsiEUWYRP84T
 ONBCBrCKTuwfyKdp4oWefDpf+e6ZAOJTItqhsZmT1HLP4Kxs1II10TU883anwNeFpf+U3
 /V7LRdqgIjJa9yfWkmFaFxv41leVaYr07nWtNv8ZEJ5BQSXo0jSfMEBoOECi3I5IEILgp
 AxQV7VV0xzEYSqdpn3S6UF7JE2s9ULHUncKipS+Hby3725izUL/t1BjSnQBwtwWw+9p+Y
 mS5bBDOrpBgDLFxc4oKaN9vxM0SVllWpRGlfjnrJtDhhedHNGLqt8hwUmfLDEsM5lgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596964;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=;
 b=kAqv6+V9+E7xY1KQPzqjP9M3yl91CcDZMZ18BT6oVl4+Eoh2r4Q67mlgosnGUrstON5o
 BZcYBMnsfpRE1WxS1nyMO/VMdnCNMDGP1TAe2YWr98vtnp1rnuIsGyZatvcsmnv9ISVOy
 R7wvuhb+bARNf7GclFLjSE9XQwOXRGp4/PcG/C/O3UutC59JwwLRV/UbWKFL28UYbWJPR
 JdQuKXEc2dqwB9Nkx0L8jCDpwtgGtfIJb7Z4HwwjWQO6E5TobDSXVstbUeKvZREjG+9AX
 G63V0MuwOuc+vf9Etsdyc42oHKFw6JsoL7MfaWyToUfpXVxOM4gHVyggq3ISwu3i5vA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="oQJ/dGBm"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SbQwfj4k; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oQJ/dGBm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SbQwfj4k
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8179880DE8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAWp7782859
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=; b=oQJ/dGBmMQjqcOAJ
 fJYyCaELNuLn9CGzxCy8L7gdo+FawlAjwbzYEnjM19pGKOZQXZFAFjLs5pyMT+P/
 02SxwerFp8h3PwUHSM9cbu7g1G9DKbRnIXkJDZEj1s+F+q1QKHCMa4hTDLm0A8gc
 1KJPT32I/7OyjHtbKsIdE3jiIs8ihms2Lp5xCJI6oDIO8gcLA5CoZDK9IlekQH3K
 7Oy3spHhHDlqEQfTtVKYhmkvzvixIPWoAZspeEKxm1sPbSO0xd2YoOiB+ugCnImS
 ql36zJuiavpzJV5h6WSqF71LdkXzeAruxHw6+8kS9loFoX0dmBQj99t/sEfUIKE6
 hRaB9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4abea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so5001945eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596960; x=1791201760;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=;
 b=SbQwfj4kCEE5LFk6omfyDvWBYCon9QMi+NZ3SbHNAUb0CRGVEEg69SBgjrYYUjxQ2k
 oDgJuTUq2EPJbFhx1ymhdCniPFQssKRt/t8OdD788lOvVqynYRMlkBnL6leA8p5K7rO9
 MeKPMRaslIErdHcq05KoPI2ZaOKxFsRuFjk0n1YqAHM4mxRwl7YKb9Cqk41sbIY572Tk
 Y8+AauQVXQ2lwJOYBqO9PRdMVs6Q9Q+60DMnhv0d2vmugh/JuOBOORm64qdqVRyuO5Sc
 L7LhVj2UYbW1nn0C7SU1v3R1OiySupEXVEW+1fXxGou6eelnprMXIc7u1V3Yrl6C0Tos
 S+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596960; x=1791201760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D89YgUYiQMfx6JD7qrDI6sj1o50FLVGdcUn3WY04PNE=;
 b=QUlq4zViWxAo/s6fE6DYY+F22TLjUNoZiYP5Bh6LC2fZTteR/segWKm5smwKM+rTKV
 tf+/y18ysY7OIFY2aXa1ClROoG+mhWDMoYTWMK2UQf1Zg17vYYPoKYRHUzUhYl3M5EBz
 7kzeOXxxNc+l9GyfvDiQCg8OWWMUglz9rCuW2+XBJAs5qnFwO/x2l0zXWuUh1xK9JoIf
 PpWkZ/fjPc9dPZnM+PsWFli7YZ3FKGYqa8H69LbjosxQcqVZG5RM/3W1uUyxy50Ex2pm
 bAAq4OZcfyKmlPjju+MetH9aohMN5xg2hLKD0xIpkxS2zNU9O/jTgePmsesC5axuNBwe
 +iag==
X-Forwarded-Encrypted: i=1;
 AKwUvByVm/M1Qz1GFTfk/MHWQJWQjqR/jHrKd7Shdl6ULVXZtP+t4Mshol72CJITQZavPpY5VZUONqA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI017YAUR/st998/nrXW8nlDzKwF75Oc+BAl8tUJsw7nsbCGKGr
 ma3t6N5CuzDtf6oIAOR06M0ioIbpoUHOCZ6CeTEKnREZAIDS0cRk95mLabuCPXCNJKWNuiaXOyk
 DAu5aQqKl2vFRQkIjVb2YETRqccZ0Sb/z2Zhd6yWulMn2IqTzJMJ+LM7wH4/tc6YAPtVoSeI=
X-Gm-Gg: AYBFou1G4dVnWVc2hKijEVyDMGmvJpmXNQrNnJqiOAzrtQcug8Q0M4MEpIRZk1jXPsL
 9YTUbseGmW+6FOZ4dK5GNtfPMGoAbsNmY/8/0IKhb7f2UskD5HIxa3ObZfTJ4sSBpyRed1Clg+t
 TKVaPofPAYOsNELW5XG8tKoOss0DAEjvbDODZDYE6oWjQx+zX7nx5kKMsM00Judse8A3FCNTWpr
 jzWC1n5cbmbMk26lcVCJMIE48uwB9Rm0uJ3E8qODelrW35CxJIoLpvR+qyZdI0eEzZ/luyLyOZl
 8BnOxlqK6w3rYQaq+w0PS0XSN7FIfNrSzakpxTynhxKuw9vpwwCcNa5yIpCu4xnzTSAx7nV4L+c
 RlKWVtr90EVyZQ/EFpbK5VBmiUjOP4ytYnCnXREByD7vLc9bWcGnHDJ6X7pA+7pqpfEWtOx9pSQ
 EtBnrrSIMAfemRCvj97g==
X-Received: by 2002:a05:7301:dd8f:b0:340:9d9f:a5c with SMTP id
 5a478bee46e88-34273550304mr8198790eec.36.1790596959175; 
 Mon, 28 Sep 2026 05:02:39 -0700 (PDT)
X-Received: by 2002:a05:7301:dd8f:b0:340:9d9f:a5c with SMTP id
 5a478bee46e88-34273550304mr8198745eec.36.1790596958319; 
 Mon, 28 Sep 2026 05:02:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:37 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/9] clk: qcom: add NEGCC driver for nord
Date: Mon, 28 Sep 2026 17:32:03 +0530
Message-Id: <20260928120209.1064781-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SudJtt6VkqIe2DLamwhn7uGnPBrp4TDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX52ib8oOwYF9O
 NqTK++aFGrKyvb9MCo2XH3fIkYWrIixyOSqsBIWgKIB4Nmkk4lZIPAK2rS6h5PYT+zbm7SRrKAY
 pFjc+hVLH5FHUBHpLnVUJ+Lv3qSmZgjhP4ANvyTgWrBDeG9mEap1mSQMQ9rk3Weqti7T49OxbO7
 g4GuwHXG1nNWkqxMohMlFS0t9Rl5cQOF4t3VI1zQpwtmTkeU7+wxw0xhnwqu0QR+tJ1RUNcVDLQ
 SnHChS/sWA3aNfF8e+WEgWnm/hpByERTpFr9VNwH+oRxA0MHe+ki3OhRPsJGVd7O+azt7DIBzUR
 TAsEqu4yQ9JMvrfqEoqqIMMOc9KhgYtdXabf8wOSsUfH2sEgBAQs6w0Ly93BbPGhQZ7dmyNgXNO
 G9DQanU2fPuUFqzHtd6ZITGqmil2NqRouVSJqu2rNwnzTcThBPbrr5La3cM463i9tQeyX91wNjA
 FuomKG7+ilrDjKg+gxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX3d/cYVLoNenT
 av10GlEqzTACOVKD6nDrorA7njYFf/PYEmIHQZbQbzVHn3IolcK2Mmp9nTdAKcXsK//vYY5oaRx
 2cijw5DD/rDD1ZMyxL9Z0N/33EXbdxI=
X-Proofpoint-ORIG-GUID: SudJtt6VkqIe2DLamwhn7uGnPBrp4TDW
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba5761 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ZbK5yrU8Lf4ruc1qkoAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add support for the nord NE Global Clock Controller (NEGCC).

Implement the qcom,nord-negcc driver to provide clocks, resets and
power domains required by nord peripherals during initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |   9 ++
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-negcc.c | 186 ++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 2eb0354d487..4dff30928ca 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -63,6 +63,15 @@ config CLK_QCOM_NORD
 	  on the Snapdragon Nord SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_NORD_NEGCC
+	bool "Qualcomm Nord NEGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the North-East Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  UFS, USB, and QUPv3 clocks and resets exposed by the NEGCC
+	  hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fef48fc324c..03bf25cbcc2 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-negcc.c b/drivers/clk/qcom/clock-nord-negcc.c
new file mode 100644
index 00000000000..82340749ffa
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-negcc.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-negcc.h>
+#include "clock-qcom.h"
+
+#define NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR		0x382a8
+#define NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR		0x2a038
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x2a050
+#define NE_GCC_USB20_MASTER_CLK_CMD_RCGR		0x31030
+#define NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR		0x31048
+
+/*
+ * negcc-nord.c calls qcom_branch_set_force_mem_core() on
+ * NE_GCC_UFS_PHY_ICE_CORE_CLK and NE_GCC_UFS_PHY_AXI_CLK. This U-Boot clock
+ * framework has no FORCE_MEM_CORE_ON primitive (confirmed absent from
+ * clock-qcom.h/.c) — flagged as a YELLOW residual risk, not worked around.
+ */
+
+static ulong nord_negcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case NE_GCC_QUPV3_WRAP2_S1_CLK:
+		WARN(rate != 14745600,
+		     "Unexpected rate for NE_GCC_QUPV3_WRAP2_S1_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR,
+				     1, 384, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	case NE_GCC_USB31_PRIM_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR,
+				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB31_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_CXO, 0);
+		return rate;
+	case NE_GCC_USB20_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB20_MASTER_CLK_CMD_RCGR,
+				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB20_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_CXO, 0);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_negcc_clks[] = {
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_UFS_PHY_AXI_CLK,  0x330f4, BIT(0),  0x330f4),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB2_AXI_CLK,     0x31068, BIT(0),  0x31068),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_PRIM_AXI_CLK, 0x2a098, BIT(0),  0x2a098),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_SEC_AXI_CLK, 0x2c098, BIT(0),  0x2c098),
+	GATE_CLK_POLLED(NE_GCC_AHB2PHY_CLK,                0x30004, BIT(0),  0x30004),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB2_AXI_CLK,          0x31064, BIT(0),  0x31064),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_PRIM_AXI_CLK,     0x2a094, BIT(0),  0x2a094),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_SEC_AXI_CLK,      0x2c094, BIT(0),  0x2c094),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_HSCNOC_GFX_CLK,       0x34014, BIT(0),  0x34014),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_SMMU_VOTE_CLK,        0x57028, BIT(0),  0x57028),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_2X_CLK,    0x57008, BIT(1),  0x38020),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_CLK,       0x57008, BIT(0),  0x3800c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_M_AHB_CLK,      0x57000, BIT(30), 0x38004),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S0_CLK,         0x57008, BIT(2),  0x3815c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S1_CLK,         0x57008, BIT(3),  0x38298),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S2_CLK,         0x57008, BIT(4),  0x383d4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S3_CLK,         0x57008, BIT(5),  0x38510),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S4_CLK,         0x57008, BIT(6),  0x3864c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S5_CLK,         0x57008, BIT(7),  0x38788),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S6_CLK,         0x57008, BIT(8),  0x388c4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S_AHB_CLK,      0x57000, BIT(31), 0x38008),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AHB_CLK,            0x33028, BIT(0),  0x33028),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AXI_CLK,            0x33018, BIT(0),  0x33018),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_ICE_CORE_CLK,       0x3307c, BIT(0),  0x3307c),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_PHY_AUX_CLK,        0x330bc, BIT(0),  0x330bc),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_UNIPRO_CORE_CLK,    0x3306c, BIT(0),  0x3306c),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_ATB_CLK,         0x2a018, BIT(0),  0x2a018),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_EUD_AHB_CLK,     0x2a02c, BIT(0),  0x2a02c),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_ATB_CLK,          0x2c018, BIT(0),  0x2c018),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_EUD_AHB_CLK,      0x2c02c, BIT(0),  0x2c02c),
+
+	GATE_CLK(NE_GCC_FRQ_MEASURE_REF_CLK,      0x20008, BIT(0)),
+	GATE_CLK(NE_GCC_GP1_CLK,                  0x21000, BIT(0)),
+	GATE_CLK(NE_GCC_GP2_CLK,                  0x22000, BIT(0)),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_CLK_SRC,      0x57000, BIT(19)),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_DIV_CLK_SRC,  0x57000, BIT(20)),
+	GATE_CLK(NE_GCC_SDCC4_APPS_CLK,           0x18004, BIT(0)),
+	GATE_CLK(NE_GCC_SDCC4_AXI_CLK,            0x18014, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_0_CLK,  0x33030, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_1_CLK,  0x330d8, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_TX_SYMBOL_0_CLK,  0x3302c, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_MASTER_CLK,         0x31018, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_MOCK_UTMI_CLK,      0x3102c, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_SLEEP_CLK,          0x31028, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_MASTER_CLK,    0x2a01c, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_MOCK_UTMI_CLK, 0x2a034, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_SLEEP_CLK,     0x2a030, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_MASTER_CLK,     0x2c01c, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_MOCK_UTMI_CLK,  0x2c034, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_SLEEP_CLK,      0x2c030, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_AUX_CLK,    0x2a06c, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x2a070, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_PIPE_CLK,   0x2a074, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_AUX_CLK,     0x2c06c, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x2c070, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_PIPE_CLK,    0x2c074, BIT(0)),
+};
+
+static int nord_negcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_negcc_resets[] = {
+	[NE_GCC_GPU_2_BCR] = { 0x34000 },
+	[NE_GCC_QUPV3_WRAPPER_2_BCR] = { 0x38000 },
+	[NE_GCC_SDCC4_BCR] = { 0x18000 },
+	[NE_GCC_UFS_PHY_BCR] = { 0x33000 },
+	[NE_GCC_USB20_PRIM_BCR] = { 0x31000 },
+	[NE_GCC_USB31_PRIM_BCR] = { 0x2a000 },
+	[NE_GCC_USB31_SEC_BCR] = { 0x2c000 },
+	[NE_GCC_USB3_DP_PHY_PRIM_BCR] = { 0x2b008 },
+	[NE_GCC_USB3_DP_PHY_SEC_BCR] = { 0x2d008 },
+	[NE_GCC_USB3_PHY_PRIM_BCR] = { 0x2b000 },
+	[NE_GCC_USB3_PHY_SEC_BCR] = { 0x2d000 },
+	[NE_GCC_USB3PHY_PHY_PRIM_BCR] = { 0x2b004 },
+	[NE_GCC_USB3PHY_PHY_SEC_BCR] = { 0x2d004 },
+	[NE_GCC_QUSB2PHY_PRIM_BCR] = { 0x2e000 },
+};
+
+static const struct qcom_power_map nord_negcc_gdscs[] = {
+	[NE_GCC_UFS_MEM_PHY_GDSC] = { 0x32000 },
+	[NE_GCC_UFS_PHY_GDSC] = { 0x33004 },
+	[NE_GCC_USB20_PRIM_GDSC] = { 0x31004 },
+	[NE_GCC_USB31_PRIM_GDSC] = { 0x2a004 },
+	[NE_GCC_USB31_SEC_GDSC] = { 0x2c004 },
+	[NE_GCC_USB3_PHY_GDSC] = { 0x2b00c },
+	[NE_GCC_USB3_SEC_PHY_GDSC] = { 0x2d00c },
+};
+
+static struct msm_clk_data nord_negcc_data = {
+	.resets = nord_negcc_resets,
+	.num_resets = ARRAY_SIZE(nord_negcc_resets),
+	.clks = nord_negcc_clks,
+	.num_clks = ARRAY_SIZE(nord_negcc_clks),
+
+	.power_domains = nord_negcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_negcc_gdscs),
+
+	.enable = nord_negcc_enable,
+	.set_rate = nord_negcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_negcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-negcc",
+		.data = (ulong)&nord_negcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_negcc) = {
+	.name		= "gcc_nord_negcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_negcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

