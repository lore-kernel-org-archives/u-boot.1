Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F60CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFC3280DC4;
	Mon, 12 Oct 2026 13:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vevsfWsj69vu; Mon, 12 Oct 2026 13:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31BC580D59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812208;
	b=X5GdU9lfNfo27O9HNQ5RUnxYlURms5aQd/sGYGk4Q8nHMLWPHcmvdARssajKzKoyO1g7
	 nRzewxQwNmSfWoBecpZY9UIxxeU3vgWZkRGgZKDttxN6hSDiK0HpxDOruhqWAKx6ngH2Z
	 jBoiZ5PsQCezuOq+lnJdjJwE2bm0SjV6YqoYorBXW9lg2LYIMtO5qdmd1iHlfCl9f7H6k
	 ZWJYGY0QUNUXhiCCvwkpGFvEt89lhCRUgPnTEGKohKXk04hD+ibKuKQICThWYxEjZNRUd
	 qAUVRvTay4LYwcNmD7ktcj3hQDUiTcSOx8dQQLot8w8OLjJuZlwyHOpynj1BeNunnzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TxsWi0zql94uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=;
	b=OL91jdMfB8eVja2wNUaQL29Nc0u8TG6B9bwBe5Jq9tAt7lCh/XXVPepfeDe+SRy1Re7+
	 B/zAlDnqJcyXzfCWnOnf8V8pw2VzFZqyxu6FyPGLqhwbGeCr5i/ewCp33VLwpDspPcIwS
	 S6T/g4gNbyt6MorV/JmIf8jjltLdCBCx+0yvW1MCqk2FSLx/1fuxaIvLHT+uG/SBV0j11
	 pERcR1hEuOg3/tSn2mXWCEjU5ghWExmJ+Qlr+ddcngF+cuZ7Nu4Kb4DB+ciaUw+HIKL2I
	 F/6IsVqo1RJh+XDlSQ1sPqBEBl1GmN9eUwXYvQ4mB2LPhSd1Eh5qRtSjgb7KDti+xRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UaxaVM3+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h8o3vgXc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812208;
	bh=TxsWi0zql94uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U77Yfz3+8tDq/3m4jpZdrYzFVjIeQYZ8V+NtuDvcNbGt7E7PTRYKDhPm2+U16TDvl
	 572yboFFBEJInxq0hHn3q4sfLFGcEfTKsyZ2Qu6UG0uacrKRS4NkV6v+QGATZw2Z+S
	 RLV3GzoeeS4xNWSqb6tbvELV7JVh46v1fMT4maJXn77p+8jEhy7YtQyjim/+Hx80A7
	 GzZ/QqnIT90eXY+uzqXvPY7UCbMuQejD6RUh4zz9KRUJ+66rtwcuYQwLkx9wk10Jqj
	 /GTdivv3LpRvNphI8BxVuTqZIL6VGkhvYzV+vH50i+v6K0ZHLCMvwEt3WBd/QekUqB
	 MvGQB50zPnrQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31BC580D59;
	Mon, 12 Oct 2026 13:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7974179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDC5180851
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEenmY0CAc-H for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CD6480C72
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812206;
 b=tH7A07beXbUMTgyOZa+gI9rdBhRJlgTGS1PshZelnbXKPQv7qEoyYgHlaJj8zqh9t059
 hw4HG56e2fOiX1kkDBeqfn9IBbBrGwH4nxKafyuV0Ozt3k/r44Pr0wiRfDCBP9LLphjlb
 Tja1iFIf7wdHzxzrDFgT6lMMJgBLToD16UeR4/4dwiyxMnEgYEEw/hEB+tgsQMSpXUmC4
 e6Fr0Ti5V8UnZ5VCvX/mKkuHqer9hdGtOWSiR3OOGVS3jmOXVyXI0n7L8x9TyZRmnrLTk
 GxPlTJp3ePIMaQDTLAocbV9ukaO3VDKUNaGWdc9amnhEkFii6mC7IjXUDTfJS7L8kAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812206;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=TxsWi0zql94uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=;
 b=WF4R+EC5cKlKs8H4d0+VulM8pUw4r4xYe+kd5kSwiFO9yUhzeCGWaDZOzwXEuDHPJh1o
 7ZzZlyILisLRmt5nHXBybqsBOcXj4mnmpR+TTzOhBfjEf1A7o2xU5ZFRE8ugUPaZkhw4V
 6ktGv2K9FUhi3bB4mJlGuzIIxCdiff6GlPJLXtxVi9YDjw55/CUTbnJWC82FNPtLY0IkW
 e1zKMqTdjmtP80B39C2shZsHuPKrw+1Vw0olykmejG74Pcw6SQ1kEcOvOiC+24m15p3Em
 JHm9Ogs+/KKDMmefXGlJfCbqfNXkh70StlZt6Er6NdJqAn0GY73RU71dGRipWmlKbvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UaxaVM3+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h8o3vgXc; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UaxaVM3+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h8o3vgXc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CD6480C72
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0JuO1236677
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TxsWi0zql94
 uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=; b=UaxaVM3+npRCulNOeiE4RmK50NM
 KhQ9bBTfJwatblpZKMGjQPLNjE8YcpwQIRXVa5bDs+qoM9cerHRAuZAYMOJK/kaM
 1AfRS4YiZeDGC/7lCoxiBWZMjP0EFRqnajKzaRtpg7hiDxD2XNxh+mbbncjGkhTQ
 0KldNjaomz9BFnj2Zj1DownF30+t4MU0rSOd7NytJSA4390mqkOI/QrbQdX8EFLt
 UCHNTZRbdRRFp/v7Cikh8TW6qmiN5JGiXJ1rMVExSrde93KBUe6EP8incUW/uOnT
 J/Q/hYAXhx5VHBLEdO/84MgxXWXXenDTqDnjcP1rOlQdflmfY/SFcZakyKQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dk6v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3515266f6eeso3635032eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812202; x=1792417002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TxsWi0zql94uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=;
 b=h8o3vgXcDXHBXWYNVldvRMU5PPKBbDv6n6MiYpK9LJ0qNHMeqlHjOY5kmtPeteR/u3
 dW0uqPc+3JHQpYnxlmpMeHi11UVQz2flDR/ZJ0SzXI+kRHK/zuWE7ogswm7udey2sA6b
 iz0LoqVyeNev/gEqmiQgJM7pJeFtDZsF13BYyJ4TVIZRHI0DnoMs7k6AOuWHcWgLo/L5
 ZkD7k4Q+iFSaF90Q1c3VeMR4qwrOEXqwFc+WlVdbIcHi0MLIES9FVPQAfsgZe7OKiaYN
 NcLifXZu3MAjRwMh3D931emW3aTSilLJpRnLHqdoAthHH5XWRjzO08Uyxo6IuKEMBPJv
 nQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812202; x=1792417002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TxsWi0zql94uo7XtzH5w4gdaonECfpo6XQ5hjGOV23Q=;
 b=G9y6hnEqsVMP5hyrJTb/335FflfgpRishNrrsx5U0psH/b/fCYg1WeZead79U5VWUs
 C90iw9a7SNgmrKEyizwrB3g8mG1U+FxtINnaG/P+gG+Ah8q1ZHGuCFuI6gIFO3HSNaT/
 BfdJQ/R7S2gBVX/e8kj2axo45Sqzyi9Mn/aWoAFK/xk5PhYJXliP7J1CE6gfMqQyrg1i
 qpERQzmHH7cMNyevUCnhjLeuiw1AKMsoPZwBmbSvmBXw2sn0OZQUJ7vGhd9wUAzXJ0iC
 btB2wP5GjEdNecvA3fLyrOKUbouiUwzOFf6SYYPlJ+czGc8sJoTy3NlY8VopP4kR69Dt
 UP9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUGMNhaZvXJu1xeJIqXmtHOy/T3wWBNwknuNSI9qDu72Nk1TakXW5dunVtXWQnmX+0EUbCsjE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYITbSZLFRXwbK+cuOD28bTpxp6lVLmQqAiPZ4G1uqU2da3UP+nb
 TzSQy2LH/nt6OmW3Kodwhs666n7opqZ8eHuqyve0QcfEknMo228ANq9CCcFC7TY68AIMJszDDIM
 oBfQioYGHT57+HJKZV6VOG//aYbsDU6fHF2laE4W4VIZqSxXqFdF4qL2sinysoHN8L4ISTN8=
X-Gm-Gg: AYBFou3INqshWlmhsHty2KYfRBD3bZvwx/KOcGI4mhaSfYVpVM7iyxTFA9Yw2wszOXZ
 UXQrTqs5qk5jG+wqtq4Jluyvq1YoCl9eyjnVCt/jxRumfqwVHf/r5/j5z9wKaM369QHeLFzjsF/
 ECERXvrW3qUNP4U6t3idEpVs2tWPriiybiKlgQCTr1lb2qr6jKA4LU10YRr23k55SbuCDdBGAVo
 XvzGn8bWcJLu4Er/TBE3pkJeJAXDHsZB50gcBSxx3bXTPLsNMGLocryQTMmF0uKmSSzBTt8dV7F
 RhiONnCF+UmLDKL7CPItdbsk3nAVG5R/TkZfwef9jUsNkDmASUxC4X3lNr1dHGVnXkB55MtaEh2
 u13UHu0LLbpCM+j8cuJ+yZP/CzMEI6ohGKM+tWfDgx1MSN6FiiS5CSOE6j1tWh2M1IznKkqJihk
 NqzBCpk4FfKVWTKG9LY/0r
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr18548751eec.14.1791812202322; 
 Mon, 12 Oct 2026 06:36:42 -0700 (PDT)
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr18548707eec.14.1791812201749; 
 Mon, 12 Oct 2026 06:36:41 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm18323802eec.20.2026.10.12.06.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:41 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 badhrinath.s@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 1/4] clk: qcom: ipq9650: Add USB clock support
Date: Mon, 12 Oct 2026 19:06:25 +0530
Message-Id: <20261012133628.1569010-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
References: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX58oI3lay4Oqp
 B3BXNu+ezEVnzV4YZajbji11BpvcA+G1Y34QPmPILWLlCiBH3yGMD8bckBfrYiAIY2lYfdrnWWB
 eWjS0UqK6e61YFEm4frQRGa8EM4GYDzP/Qix4tYL7MPL59flwAuuPnNYO0RL6q0sgmYlN9rpVX9
 hSuJnb1gW4d9J5eL3r/1YCQ1Z3KCJz0bfPfhMKoK0ITnRoKQYz29o/13b9dildyfW9zp5iZBwOk
 27yGrKfoVzgRs0CoCBiY+EHWZ5lHmHFIUjjWk3+EKmsbxnAo05Pk2MMPyvgWRJaEnUTKuGiEZTp
 86Z9q1uSEdZn/KKEBbIPlnkSDEckpugxjqGkq4tGJqEAMPEG+Ho3lvATc5WgzF8wFviG5Up6yaq
 Mka1tJKOoFspU2OptmotHOpwIIJBeSrLHQAgVYo9YaKGnlFetekNPdUhzswgNWF3sMkqHRBerSc
 fgRDwUj1qY+ebB4DD+Q==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acce26b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=wyLTL-UVn0PPJoXLPpEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: drHFXZhWak6ScfFkHdGGutZ8tsJYmhxe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX79ILTlqA26Bp
 HCFcURYV8L8SQu9ojgiARP2KHkOl3q62t0XPKMUIlWvA0u2/5hIjJ9uwxdEfNcVPA9BfDsqG0D6
 4o7ojlttc0ShvUL+s2NqOREWu3238ww=
X-Proofpoint-ORIG-GUID: drHFXZhWak6ScfFkHdGGutZ8tsJYmhxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054
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

Add GCC_USB1 gate clocks, resets and the mock_utmi rate-set
handler needed to bring up the USB1 (HS) controller on IPQ9650.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-ipq9650.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
index 29c0c3fdf49f..52fd373625b1 100644
--- a/drivers/clk/qcom/clock-ipq9650.c
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -20,6 +20,9 @@
 
 #define GCC_IM_SLEEP_CBCR			0x1834020u
 
+#define GCC_USB1_MOCK_UTMI_CMD_RCGR		0x3C004
+#define GCC_USB1_MOCK_UTMI_DIV_CDIVR		0x3C018
+
 static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -33,6 +36,12 @@ static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
 				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
 		return rate;
+	case GCC_USB1_MOCK_UTMI_CLK:
+		/* Default: 24MHz */
+		writel(0, priv->base + GCC_USB1_MOCK_UTMI_DIV_CDIVR);
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB1_MOCK_UTMI_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_CXO, 8);
+		return rate;
 	}
 	return 0;
 }
@@ -41,6 +50,11 @@ static const struct gate_clk ipq9650_clks[] = {
 	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0), 0x3303c),
 	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x3302c, BIT(0), 0x33004),
 	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE6_CLK, 0x04018, BIT(0), 0x04004),
+	GATE_CLK(GCC_USB1_PHY_CFG_AHB_CLK, 0x3C01C, BIT(0)),
+	GATE_CLK(GCC_USB1_SLEEP_CLK, 0x3C020, BIT(0)),
+	GATE_CLK(GCC_USB1_MOCK_UTMI_CLK, 0x3C024, BIT(0)),
+	GATE_CLK(GCC_USB1_MASTER_CLK, 0x3C028, BIT(0)),
+	GATE_CLK(GCC_SNOC_USB_CLK, 0x2E0C4, BIT(0)),
 };
 
 static int ipq9650_enable(struct clk *clk)
@@ -55,6 +69,9 @@ static int ipq9650_enable(struct clk *clk)
 
 static const struct qcom_reset_map ipq9650_gcc_resets[] = {
 	[GCC_SDCC_BCR] = { 0x33000 },
+	[GCC_USB_BCR] = { 0x2C000 },
+	[GCC_USB1_BCR] = { 0x3C000 },
+	[GCC_QUSB2_1_PHY_BCR] = { 0x3C030 },
 };
 
 static struct msm_clk_data ipq9650_gcc_data = {
-- 
2.34.1

