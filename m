Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F03CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E9AC80B33;
	Tue, 13 Oct 2026 11:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hj1T69wWsNNl; Tue, 13 Oct 2026 11:06:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B96A809CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889580;
	b=W25/e3tfvzxo36kLWKOmL1FhrmIBUxiiWlfSTb8hGPm5pdoKmNOrYFor+c1Tjd+LoFIm
	 Xi3PDPR4ZgDV2H6I2GbuThC/i2p35BXW6+zdF3/CbPT3Lk4Xs0asDxoQ0VJW1f+NfzLXJ
	 TQm0N+GePCnnv7ezTOedhVP4LOEXkCxVOL2Ot/DVfMUNVH9yWjqloZ4aMw8s2Abw5hpye
	 2nuwqOUscxjmP68jbeR6TNLkbexjuRk8eO/A25LTpTbQeD/mi0Q/85kGZjF9lE4FDNiV5
	 HZMwGTtQSv2anDS4qTe19r23MaAOJKXOIkRY7T7ltYRTnOsp0hyhlwylYNcvmDsuNOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rlsq5/7JODg=;
	b=evDl2VCcQ21LA/rmRaCfIHkM7IQNt6taGKALXU1MM64A/fpJtPPGXxmBdZQnmkX+221Z
	 HIuYOOLCuR2rJ/Ahg+ESg88nNK+H4wiiuyZWMkjtpedQJrX00K9j0uZ4OQAcsxgh8qzAF
	 MLlk5Yob0Goa5tAdPVl7owPxURFMfRMRps6kXehaLfDFuQcJQVb/ElRK8clQVStNFAQ9b
	 in9+bJ3Dl6Hg5MlXkukEdEv0FsJTcHePwDFXkLraBi8tpbNZwu+RYdqptR6YcaTi1gvBn
	 JO4PNsiyCsDctVdHr5oW4MxC91xW+ugfJPJa72GDk/hx5EkogPJ7K2EHjCJmWMPDDyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889580;
	bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rlsq5/7JODg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J0BMOhD+XpTc63M65nOou0ujjsBTC1w4LnI0Whk4q13zeKaB6NqAEU02DcwEAD5fl
	 2821CDl/ppTPNf1MVUAWYKNvyTlSpXEinKdW5HO/T3HHZbOoL7YKiBTplShw/Qw5to
	 oyjLCfvmMm2dsXnBW82MtxqZMHhih/WLO100ieP8oQriuqvxRppyhUsam4lFfb7QIC
	 0cvp4bkJ5QyoBfKXWbYFWWUw4rsFrz0DFg+5+wyjerj5JpRag9NdKwjdBeOi2CqVdd
	 sFS1DDWlpW25MLSkrTyHPrIw8Y1NZMAQeA88Vfo3JXXU+40YNSP955xoReYBk46Ba9
	 SPiwUah+26YuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B96A809CE;
	Tue, 13 Oct 2026 11:06:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2629A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3F1640277
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKgCLFgVE__V for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:06:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C5949400C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791889578;
 b=dsFlnCUvfg82Ctev/92hJf0faglX4eenUrj1LyXxc3rYGtfy+OjvnXVjJ2PpwMNUmd0y
 JAvzHRYJHv5BPPiJFfWlFpXlWwPeYGVEUDNGSLR8vzmP2ZT/W2Z0yM6ioIROv72SwlRbE
 ZOtWPMoBy49WBL0qIp3mCHejBFO7MdFswGjJ8Q4+lBayW6sVhRsyBqDFBHUjamI9yD+9d
 WAYaEu12k/LT0kdVMYkuJmTYJ+rj0jXE5LFLL4ty3/Uctt+oEIeRWsyjFarMDt3yjBQ4+
 pvJ4bkWUEsHBxAMvRuSvkDyvaY+hJBklozzd/PnW04xHmoLmfrixyjQDRhC67PQ9oDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889578;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rlsq5/7JODg=;
 b=nJCFd1Hx36oK5jXmg2rl3xe6vCwNWrT3oc6+tqqkxx8/5Xg+1UiHJnxbAaL0jaEdcLmo
 3yH8n0AGRXvjCINZQwTnZ+dbpCn/HX5kRBCX8jU15uOPzCoWi+z6CcYIJ8OYyROXCTm3H
 y+WVsKtB6h/KL1zeogaKkvBUiwImLuoAz+s0FPc8/3PyrC5UqPjdbZAZLQ7iDwzRNPU59
 0inr/DNkTLeOGB0W0MrZX2FsxhQdnioSzJ3e05nfiIu+4T1CYZqKeq2DzOasEeo8nlYK5
 XisKi6ryuvXD1zfRsJ926BfCmT0wS+Uqwu31c1yzjBhbZRpYQfR3Jkd2I/Td310Vb2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jyMZLI4t; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KWEevVE9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jyMZLI4t; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KWEevVE9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5949400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OWrI015194
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rls
 q5/7JODg=; b=jyMZLI4twCMMlFlS4uy1jpgYjzTLroR48bmjpNdecLLiIf5rNYq
 HNOFO+nEgZnUCxvSDtzVflkUU16y/rn8c+GrMW/bk4pCsUjD1oWknT70KJKgcQUO
 Bi0Esh8VG/mAGGEWGPf/u16pgL9qHzpuOQyNLVf1GYobcHRbqa9C9b3P9hEmGLMs
 50/f2qVIkcNT2NNos52wVuv8p2zMeH0tN4fhmHk6dZ78bIin7lpBD7fhNHEQjV5r
 hS+Kv5iOdHDPCnDEo4lO/eNUCIS/LzLH9lmThcf5vn8AkqXrYaH5ffRYPhLD6AJ3
 CUKAVnZe45ZzAeaUumeaxN+GhSOIktQartQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugx0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso4934894eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889576; x=1792494376;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rlsq5/7JODg=;
 b=KWEevVE9XsBXkQ9WKp3OFBkhJIRAqS6irVzTxNbz744eqElIRGG0UooMsJvW3n0rlF
 LS3LWn8/4N4MpXmIiH46/6JrkUw91zTiRtqda/UqufA0CcOyqJsDVGqdq68ApFmqvV59
 eFPKU+7YHPnsdr3fLDdtbro2VTL3ZVBkkJGB83xlLbFYyCWku9/29v8XjR0IwcoXey/N
 90OmYKhE3qk3oZxd1F5tACZp+FS7jvkIjGt//dEEhNnAHXlLSmxyGnL1TTPbAooWjUzg
 zs32Mxf3KwVDV6CUr996RuSd5M6mJJSXEFxUx6aOJq+cIp7/LkHzSEIi5vTotEA81mXY
 iskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889576; x=1792494376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B7t0UjMoLbe8segCaLsauRQRch88tW83rlsq5/7JODg=;
 b=vdH+nXeOtXBsLBtOuKw1iCaO2OfKXRf5KwjNPIwtAR+pHUPYp9FUWHi59b5o60q427
 VBFaUXhPgPsfMjPH7pDvy7vPgrLf4kIDLI75tklp7cb8WRDDVngscCG94p0oqmcAllNg
 4ozz0e6mqRpvhxSsXhogWYqN7+8CrPkJrM9h7ccTZLgk6dKhxVCqC/biK5QOp8JEuv/b
 jq0GcdkQtgM7MZol3QtuGzlcqdTt8mcrVie97pGivQL1YYfiYmMu4qFPgUQnHLJ1PRiB
 tyZYdxTb/8pFQh24cqVZPbjjaOS1UGWNK8m1yDlLAhjhWPkyizhQH1/6sBXjqF2/TyGC
 URdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBWfyUAgUkZVF7JqUTbfXgzmV73efMcY69AeGukKLfKuCfg+xJ0QP/A+lNzfFxgd5nNXoKFew=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEaZH/7K1XBVuGWqhMp6pCadtqkVsNmpy/U/O+EbTWshbt7FQr
 FxbgCcrIxM8emk2QQwAQgk0W5EOD+okSzoalwcrCNPaMcQ1fgN2yOUi6jR/9Q7soxelwxl3cCpy
 hivyCV9kmNmmzGAt7CrUkI1D9eb6AdD1SM4pr9Iepsa1UBA1yVMmy29BdygW1/TA0jW05qRc=
X-Gm-Gg: AYBFou2m5N3Dimbxi/9JGqYYSaIKsNEt2X0XypsaTSEm9fHxESouu6+SgkXide3otkG
 FLrTQ0McbuTBdX1s06X075r1Arh0YfDk9fNPpedoSQ3RLHJocfuw4rhcVJyV9nkqj0T04cFLv7X
 yiALs3hONJxKj+zLpoTVhKpiwpIpzHM7duZA455wyzfCLux/TJuXSyf7P1Yc8XB2RofPU1wPby3
 h0Iee1ygTxCmTDBGgfWXe9WY18ctPe/4QJfJocnyzJteW5aUGaY30CLNn7rLNvaALUrqAuceca1
 HTmKFFLhbhODyyITE0m5PUBFAKKasJRFbETwpISv8oRgRjoEEpyjt7owFoC5+YKUZnmTRgDod45
 6I+dYRA/hMdh6Ovbt6v+32Tbi6tq3qW+jsZ6MMzGiF9Nl4FqAgqAiUv998ycDCGm7iQZgMV0bjo
 xig+PE9qAMv4KiD+JL4g==
X-Received: by 2002:a05:701b:42c2:10b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-16a63757d80mr19998843c88.39.1791889575701; 
 Tue, 13 Oct 2026 04:06:15 -0700 (PDT)
X-Received: by 2002:a05:701b:42c2:10b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-16a63757d80mr19998800c88.39.1791889575036; 
 Tue, 13 Oct 2026 04:06:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm37460642c88.3.2026.10.13.04.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:06:14 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Date: Tue, 13 Oct 2026 16:35:22 +0530
Message-Id: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX2FGgzX2rIUy1
 NuVduc/LJex62Rw1Uz2Q2YIls20GQJSWlS6DwApA+FP7f2IT6xgRn5BWh8/7YoGvQYxJVcNZIEx
 CuxSTrs8pxrV2KZr55sni80FmyiTKkxIsUw/n0bcT8Qu/WrJZK3VGN2bmaeJWjqYKFJ8v6KsUgm
 6buHi50YCfQnw+y+KxnI8unOAnwhY+kQr2uP9WI5DFCchS3VimEC1jJqE77o7wkumvuE9axT7kT
 aGAdwbVJk6TDQxf1g0WaE5Fe9PwF0o7DRxwcXTVkWlFB5/vzSJoPSIzhZeXD3Lm+HugcrjkvXKA
 kEmPlUJcXQV77Fj+kO5qvUI9dxql32MKgwUiUFwf01vvDIdQqMGVeHQ9W6riF8CZ2xiDFK+opV4
 HaommpimnRPXJvq9kfVNAflaQcQm/uGsnViqTA7m6gL99NlowCFeIoQyUAv67nVWDunYDrJ+kO8
 ADSF2pBAb3twgJamfJw==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace10a8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8S4Ko0p2hYbYe84NMw8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Wjiwl1mU4y3YnpqwcznDoDmN_CQ5oom3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX7kKeZDV+9Au5
 NGyiukHKyVGUX9pJ63RDOSrm9C9dTkzZ3SdRksv41GSpG82awOyGdNj5WKWzM3AKHl8DpHP5Eir
 zDf05NWjxdKwXtSNXHGJU3UX+WmhzyA=
X-Proofpoint-GUID: Wjiwl1mU4y3YnpqwcznDoDmN_CQ5oom3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130044
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

This series adds support for exiting Gunyah hypervisor and switching to
EL2 during early boot on Qualcomm Dragonwing family platforms. This
enables U-Boot to run at EL2, which is required for supporting
hypervisors that need EL2 privilege level.

- Adds early boot0.h infrastructure to exit Gunyah via TrustZone SMC
- Creates a reusable config fragment for easy platform enablement
- Enables the feature on QCS9100 platform

Changes in v5:
- No code changes, rebased onto the latest main branch.
Link to v4: https://lore.kernel.org/u-boot/20260703172634.140515-1-aswin.murugan@oss.qualcomm.com/

Changes in v4:
- Updated Kconfig and gunyah_exit_boot0.h header comments for better clarity on platform support
- Split config changes into reusable fragment and qcs9100 platform enablement
Link to v3: https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/

Change in v3:
- Corrected the logic to accurately detect the current Exception Level (EL)
  and fuction properly when U-Boot enters either EL2 or EL1.
Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/

Change in v2:
- EL2 switch is made at early stage instead of doing at the very last stage in
  the previous version
- This change is based on the patch [1]
Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (3):
  mach-snapdragon: Add early EL2 hypervisor switch support
  configs: qualcomm: Add Gunyah exit config fragment
  configs: qcom_qcs9100: Enable Gunyah exit support

 arch/arm/mach-snapdragon/Kconfig              |  8 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  2 ++
 .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
 board/qualcomm/exit-gunyah.config             |  4 +++
 configs/qcom_qcs9100_defconfig                |  1 +
 5 files changed, 51 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
 create mode 100644 board/qualcomm/exit-gunyah.config

-- 
2.34.1

