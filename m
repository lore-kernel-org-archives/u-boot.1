Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B275FCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A8BE40627;
	Mon, 12 Oct 2026 17:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WQgPp5_a61Q; Mon, 12 Oct 2026 17:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DD2040609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824918;
	b=WFuRmM1UYoDwdpV9Rc69Qbc88d7gg1BNqnmjiT3Yy7iuvapf48YedXLl5iTLVe/QuRMH
	 YfQWCBXXSnHx6rDS6lhbUsMXFA1vJmvbZWF46On5/cH/bK/ej5twliwrVrfGKWbhqKGwO
	 eHVIFOTdBMCPLBRuyJgPg9Ha4pwMG7UCNTK4jo4AADsr0R769B5xhZJES6IkEBJ2BEF43
	 QRQwtTjRTQLnu/JYjYKtxIEq164IVreW8QPw7rHz1uFmSn/83heSeSdmpkkds2P5iA3om
	 B9ghKsJNOO9aPDNwmQVVgFydf8fhFPHhhaA0Za0vk4YINs3Vw8XIM17bY/msxUAHu8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qfH8hx+1ub01NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=;
	b=pYWb8CioZOste/j1PpYE0pvTlc2bmGjY6YlK4sMz2JfxQTd7Xp6xsfR1pbQpr2G9vNUA
	 rSKw1RxyNNSlzXbEvZsZ256YbxNaF2SDlyxDg9cNsTGICBaZ3PjV/nStg7A6ZQof3RiNv
	 sxUOh++A1NUUGVcrvwkcxYcOoCIxgR++q5hao4DZLa12dk/qY1a7OXsYeraU2siXRfsZq
	 ysKKcAs1A3CbhH2IRyKbvCjhi5+7N2IWphpGS0JswEuX7m+PgonRWqLsUh+rmwSWf0Nut
	 19LTrOTuwacFBjIsQk+H1r0GoBSAw3pp7U+rE3H1o4RQGOMHEEH1BfZU5k3cajuSP4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824918;
	bh=qfH8hx+1ub01NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6LzvrSYh4HW+6NILmdE+uwrUaVgFb/mUNvnk74siIlRHCuXw27d/36gyioDyLZN8
	 YECaeSVkUhwAS6Uyj8mkkMnX24ik0E3CKIuGYiOISSfBoWM9AGjXLDCZuPwRMRzoTH
	 zkcxPtWx4rFRDqFBCBkLdm3wV9wMyOpugYkx+1pkqaRo37RsrvCKUcHcC5byU9s+rP
	 yNYMXjhqkq8r0y+ss4ta/YuoEBwSx90Ibr3qFIOu8b2H4kXPg7cnf/cpkWfgxTWvRn
	 SHb+aPRbc5TpwNFPL47sdRGg83f56F6sGcHYAqIgEbXPMkE3c5gfFtpgSoNaHAO6kZ
	 u6djL/Fi/1g+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DD2040609;
	Mon, 12 Oct 2026 17:08:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C5799CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E1F380DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1T6yAjmXsc4q for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88E2780DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824916;
 b=OUbLh9hLX4xn5Bsp3WPSNgM/9o9O7z5cofvEAslA2Rmh3ZivuuhhKG0h3/RMFGrz69V5
 hYeq9vNE4mUV7djSj4WdveO6quFfIstsWQOciDcU8P6IOSDcafFwotCIJNIfdtOLS61Uw
 UGkWHSUqX3qWXc68ylC5etSUKlPKTQLAoPpzD2OnMfCgtQdTw4cw83uqw3IZ8pCp8hSLZ
 TsJpLmOeMdlH7gslGHedniUUwVj/b23VBkIbzZ2EVIFeNZMTF/MGJLExzjif22WD/fmkm
 mpI70akj+q+2tVkD1tWww7FyuhK+cPba1HLmqwiGPU/HnVvjxb3K7xoLhCLb7rbfayw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824916;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qfH8hx+1ub01NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=;
 b=RKI3oJ5KDUWFeFqJuALO5nrXbq7NHv5HMhq/gM4UMaRSQbUvME4bhqq3nYGJUhDoqzJ7
 xHotp/M5xArC8aqNeLr2D4/Ey5K1Zl8szKGB/oV10vvIrITh0r9cvquReGyAi/CSqYbeO
 Ge3A9RanVomMkQf1iedkUenlDIfrjSLodOXJLgRJBryIemQkQKx/GQQvJXBpiy2KHd4Tp
 RDS2W8SRVHCRR6IABRT0y1Et170clhOEZJ3eo/4WiUskJYCvjIr+Ui0y+RV2JByOgmDRw
 zMCFAH8oDu31g17Y5xN1j57SE74yRZZmVy2xZ41+ZchLwmB37oVPJPOwv9IrOD2+5vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Prxn02eB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="d0kOUTi/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Prxn02eB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d0kOUTi/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88E2780DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFf0jr2175323
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qfH8hx+1ub0
 1NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=; b=Prxn02eB3ihg9mM+JVG+rpMhWhG
 1gaPEw2d38k83tHDgzu6/OO/wAp1x7ZzO0V7xJ2fOJ3jQFVPUHvBA/A7Z6w1FHFe
 +e8tETR4mFTSm/SkdCtv19QVlZsrpYBQ+R3yVEFe9Xdtxvqlwc9BfIu9n7tIGFhm
 ezuTV+ZrUvDe5pagTsgTncot51LWdF9iJKfQHtsi6iwH4TVrzaH8HuxLH3FkoaLA
 +3TLzW8xLGfNFxSCC6FMy1REjZpbrMfjNteAPaftosIP2kHQBxeIeRtw1facotpn
 1AN8fhs5tvfY25WRL0nipsTgDtbvDJgSIRaB6FH13hFqW7zetgpi5Vr6hoQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc1xvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5215606eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824915; x=1792429715;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qfH8hx+1ub01NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=;
 b=d0kOUTi/2+wU8eB9l10wAIe+8X3W3NAcm/1Y3VDaWpRnINLC3hpKqlDW/exi/wd/Qo
 8ma2c2ebeZHu3tnZtORzip51yFUHqQLCxvc6FEbXZMUM/x3ncjiOfsTCqx93PyGr3xsf
 nkfZv2PKuBTE4iXGAlRtsKakheWcnh7OIJa1DVxkG5xUa5S0PzOaNBty57nMNzCsudVU
 nnnGI7GU1QENA02/f/cFZn3sBgPYCuaggxpS82zLF2sSAqjdxAKL0JrL5tUF9otaGPe7
 Abzb1hvcXYJHE3nFDQotjSeSfZ6g499QL6tE5kFB6XeEpQ5ng8oAZFuY8Mrdvq1D4fwL
 +JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824915; x=1792429715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qfH8hx+1ub01NFU4zI2cFs2uXVxcnBmw6tVWdlUu89I=;
 b=Xv4bCzHaxBdvE4ks6VNgU1XgpKQzJvpeZFCPXWXDSXEzCYhuWekWqfHRdaK6auLFG/
 WbaxCONmo2vp87duVb7F+P6Epo92uHQvo/J1f96TEcyP1BVJ/9ebrenNldcfgFDcTz/I
 wY50FgfQFz7UvIvZUV1tK0PCMfNxzzFrvrvcsIHy5t9xlJAs0NVAwLHj7NYpis2peJe1
 BybFcy3F08bkO6ujFXvo5UOJxm/izp1w5HOjATfzvyjOaK7QxTkZrZEeKNEQs+Vx1uUn
 1CWVHEIkr2FawTeY/h1/NcCFbyka5K3BCnNbo4sFa58MI8c7CE5hfFJ9CQtlwDNfL8cS
 LPAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByu7bu2x5cOMIM13YfAalaKiPG1K8yWF2SvhSdE7f2RGyyYJjVwseIjV3az/Jfufwj3nbHh0zg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK7vJFbCGMCodnvZiC3f0k2uHSMxf5BEaXLQJTBllgxAfHiJvOl
 PX9xFEVULUUGn0Fu0dqpPJIOPo0XiOVeoPMmOV69hRyyliJZOkiCfXSXFuIyu210ePiaP0tx1Fd
 kgzzDWbNxDeBBcYjZM9PSzxTB9Hkq7aeshPaKd+D7so8ip4bt4kSH3jsLm52ueYeOzFQ7yu4=
X-Gm-Gg: AYBFou32LpBXSbUzKzNTkIV4dcJ72/TBIerGEVUIpKYxh98sV3WM7s7Pkwp1yjMl3YP
 2zIXUD77+XQ82cgJuPnCJ8V17qWrTSi6E8yPsfKDGaZMeuBKKer3ejP4SY8Jwic8NpL9DEnj06N
 ujoqdWHDcoEbMicC2lgaGxdjWXC5wHuT36Ow7BV1QqCpvfxqRRz96mLltZWkZRTDYc8/wzn6Pjp
 M1A5XunVQtOZm4EvVHACjVXiN5IFlHg8x2oC2dLBImI6SwNmda74JmMgH6iZpIWFABkE7iT+8WN
 es8cFA0dgpkLl7hM6XWYyUDi9OHB6F6CF/PVy+BrU+LDIrF1YbFhQdXNYU5aXfZ6Al00BFNLXOM
 4/vyEt1VYhR/m0X7NA6RlpzRfBkDfmJseRHUS+cQ9B7Emnb7ckDPEDKr5rVqg50Lw/CNPhO+CBS
 TCkxQNMeUkrPKI07s7Tg==
X-Received: by 2002:a05:7300:d10b:b0:34e:e479:723 with SMTP id
 5a478bee46e88-3537dedaa75mr13370383eec.5.1791824914983; 
 Mon, 12 Oct 2026 10:08:34 -0700 (PDT)
X-Received: by 2002:a05:7300:d10b:b0:34e:e479:723 with SMTP id
 5a478bee46e88-3537dedaa75mr13370345eec.5.1791824914205; 
 Mon, 12 Oct 2026 10:08:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:33 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 5/5] arm: dts: Enable qcom, hwinfo on qcs9100-ride-r3,
 qcs615-ride and qcs6490-rb3gen2
Date: Mon, 12 Oct 2026 22:37:54 +0530
Message-Id: <20261012170754.1606314-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX/rjGKDR5cBqj
 BRsSVvs5z/zUQNyti7AC5UPUGb/zjmzQ4PmzUUY0lUNN3TwvPQ8jBf2urEABUQrFFGOExNeZUL0
 YJ3+HKb8NfC5yQDUrTZv3naUIMwqdL4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfXyMJB3AdGdEQh
 f5v4xQwkxVZBWw5PvPunkdCTyxiQ8rsW1WqMUsETPfAnwALz3vSwu9BOhC8qhEmwWrCgE5ki6tL
 Z+tVNRbsr1ucr9IwKiVXhlhxbGGNGxMNVc37m7aHPCoR2f6lQ6fRb9ypjA1oDIsVUQ7qbKA9BbL
 pgdmg+4SD03wtalx7mC7rmU2eC4pvUeUdpb/R0hY90e67y+jf/64FqPGnzf4cYm0BDG2Bxg2tnd
 vROWCtvPM0xP07fIee+mhQs6EjqVldqfFmuomVsHX9pBCkF549t5MGrMckn4xHmzIHtZ4tHYoBU
 HbqbzCoDrv51RK+7JinYQRqrBJYYOm8ER65tUz7BJO/qOTFPGVawptqNNBW3Aru3OCDu6EtZdPB
 DnFRDb9w0nGAxY9f+bgot7EDzajWYdhmkyFRoQOjlkTvm5kPVagOVtn17LLf1F0lbKIZ/8yHOab
 HMZwZYrlJFauGLO0Fqg==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acd1413 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1VxDqnHFAAAA:8
 a=EUspDBNiAAAA:8 a=wMZhFbl-m1XNx4iGRucA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: yn7DV9WyF_XO-LnOvkeAa5pMx754lEe9
X-Proofpoint-GUID: yn7DV9WyF_XO-LnOvkeAa5pMx754lEe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

Add the "qcom,hwinfo" DT node with the appropriate IMEM boot-cookie
and TCSR HW-version offsets for each board, enabling FIT multi-DTB
selection (CONFIG_QCOM_FIT_MULTIDTB) to detect hardware parameters
at boot time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi     | 10 ++++++++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 10 ++++++++++
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..8400b786f4d 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,14 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&{/soc@0/sram@14680000}>;
+		imem-boot-cookie-offset = <0x2a000>;
+
+		tcsr = <&tcsr>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7..ffcc2b3d47f 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -15,6 +15,16 @@
 		      <0 0xC3400000 0 0x3CC00000>,
 		      <1 0x00000000 1 0x00000000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&{/soc@0/sram@146a5000}>;
+		imem-boot-cookie-offset = <0x5000>;
+
+		tcsr = <&tcsr_2>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
 
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
diff --git a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
index 5905dfad18f..ab10ec37056 100644
--- a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
+++ b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
@@ -17,4 +17,14 @@
 		      <0x0 0xd3500000 0x0 0x07c00000>,
 		      <0x0 0xdb300000 0x0 0x24d00000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&sram>;
+		imem-boot-cookie-offset = <0x0>;
+
+		tcsr = <&tcsr>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
-- 
2.34.1

