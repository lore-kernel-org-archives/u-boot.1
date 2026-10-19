Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E69CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BC7E80C25;
	Mon, 19 Oct 2026 10:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfsxvQJa8nIv; Mon, 19 Oct 2026 10:54:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61EBE80DAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407257;
	b=PVNfODlHmGZbzBcL0aJAJs0JYoIT1dzU4voz/Sk5MakqQf3GYRhqcdaSRmSp5Agj+JWP
	 xQOZjnWXl9I+hJFzWZIVjqLANiEHJuwN4hIrmVD7nwmrjTopevZrlP1KoEnEv8FudX4fa
	 6G0/CEpSzxQfpW+CLXZOCC60DoqrOz8axpSwsBSkE2C3cGY/mddJqz9gG93WGR6nMMMPf
	 VdqeeL2bfBS46GMm0UvPr9MY30HJ0lHfROjOWfFdyswlEymfB1wzPn8o3GwkOTeMD1KXV
	 WPXDjlnR8ar0PNIvQ6n6VIDNO7FbNiSgQtFwyRKQnupMKqknIsPEua38PHjTAyWHVyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=;
	b=qWmF11hTZNqVv24PX0VX/BTWZn9GghPPGE0C85EGJRvBFDvkZHKnhppZPHmK6zqj2+hA
	 mfVAz9IGVosOkmqo5hQXaS54M8Vc2xyizK/zU6AZt0CDZC0a2vjcA+2nTw4afmhae291u
	 HVWBH6Ix1Z1lhyByLlQq3Wq9lZ0bF28AlRIYOo0b9QZPSIks0q0fvrI8U1vvty5gIycsj
	 NgwEi20foOvRq4bCllA0X0NlFLfKbxh1oT7E/yCWirkmCeDrQnxlXuOoIjVFS4ijVtxx5
	 K6ctiM4miI494CGO8AiU+7G1zB18mrFXm44cq4GtfWGwx6siLxdZd1Z+uFU01M8GCZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407257;
	bh=mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWU14ir4ooWu+X58mwodu5209hXJ1p3ZqaDqhJLcKiC75mxmQKXPAMA2wb4po8ATF
	 YPyaSpgne9ZcNw2F+XIuk0nv1kBzNbvFc6IhUDEtQnMk0n/SMp1dVYfgxPezF0h6nW
	 wJubsAP3xOzPFthrEAzj/3SKDn1UFQcFyCyJm94rvnolbZMpY4DyAQbmi3M6exf9WZ
	 Pn1yIb6nrtX0CgvL4aBad1gBgpg91f+p2GHo0i7U5mingf+vETwl3x7B49BoPjksbs
	 DTxU7sFmsM1IWI0e4TZQKORo7OsHqmHbNaaLXfPhfs1sqESOLUfoL3N98ht2ZC9jzH
	 1YzuIduNIm3Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61EBE80DAF;
	Mon, 19 Oct 2026 10:54:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFA021DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E149440080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-GjUQ7YTbOK for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3681240079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407255;
 b=g2S32XBnlBfKoqwhY1y1flXs6eP+w8IPRzCRjPk8RTtnxkeouGe83nTYAt0s1FYABclk
 T+yVrzqjSZkFzWWzDT62mVoSb4mU20xJfoG7+uE8bCpKszU5gOLi4elawa2hqmsQEVYKM
 PhpIidKILHjlhwzxFIgAgaTx6uTPVN12zxCcPQZJ7Ylmssvneltz+gzs43swwMcYO+ZEk
 CmtjYo3eAwq0khBqBfevN5MJlhN5mlQUOY9wliibDrLmHXf/v1K5S8bK7uY0MX5H880jp
 JLD9U0EYX26Zse8Vo+RRJH9ZNE0ZM8nSGBudU3qcGSrx0hc952nL/086WWX1jUP1Q7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407255;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=;
 b=WZJgWY0h7cQxBpKcH/9/tKn81njcU/k81EhWm0aiTOUiGKww+zm+W3kIoIqSzSI5fh9c
 eaVFr42e93hjJOgr50+ap5fdPDdrx51etvLtiTk8pmED3Kba/RoqukrUrebygTp+SOQPQ
 uUAoQ9znIfHa67fCRWpIwtnoHbH9a10MXLl/yVp+V7YQHQiJpue/oi4nM26x3OkTUt6In
 WWIHu4+7K9PvN7ro4t6u3WhdVxLEsB26h2jG8L4+VIjY5wY/dfLTCsgWTF6lT/Q2hKhw5
 l9ZTdgguGT3LjMGtYZybHpiMqOy9yFGP0ufx+cqk1A33cZ2+r06I67oPfhBb76t0eYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oaoumC0D; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q+RGm4EE; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oaoumC0D; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q+RGm4EE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3681240079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ortg2234322
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=; b=oaoumC0DPWCi9nPj
 CVFIsipKpMzUQh7JS8T+GAMrgyR1T3yHCyptnUZ9itOP4QpZN0WCCvoMwbSinp/6
 8dKj2F5bLMYHIgH2UW+o5swT0MRbpXV5JAqld1KdKg8Vq/ZnLIFKhlRAvWxooM9Z
 3xm/mEndOqJdU3wPVI9PywTlgU8JMi1pmb+AOnsrEJn/2JfIOx8PamytE7psWlB/
 snQzhMADsxs/IozSkcAweTmn1WAg2TA2MBhWyhILKQQuVK/B1Djlywp0aiNc4gDJ
 tj3wf8iyF8ppj0/bKbGuiuWrxGpV7ndzL93Kf6z++t19h0Ixup5rxDwhsbckasDB
 5pKTXQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8qjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35d4538fd74so7102882eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407253; x=1793012053;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=;
 b=Q+RGm4EE8jgj2OcjcKwpMVc0+McIJwCjpgdoDbRC9KDb9i0lloi9DAuTJX4em5Jc+b
 fsmZrRj3iKpmAXw0h3rh2XIIcZmGwcyxyiBPmxf20zL061CD454L8oGSNv3njOJaNTrd
 ouz/xz35+r+UzfLkm5IQdpKEb+sh/yKIpoF7F5w0m+7dLlDxPLBI1YPxpye8hccRkSh7
 C1XKTnlLB0o2VpZgcVeG4SKh75MvzOcPuJCkpaUmeCfq43LWM5l0kpl3oTVqbfVKkhiE
 vR/WpTpTuBppaRGZN/8OmdnvAhpe17RlQT4AqZah9JanjuRpxsyUbBNVA8WSCKELiTRb
 ROjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407253; x=1793012053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mWuhP9WuN2fD2o0L64jemHvEbSb/spiEUL0LBxeZu30=;
 b=wqEVTnsrSUDo1bfiWWZYSMFfODnH82F4kLYs8RakjgLD+JJ75QR4G+hvR3u9hS7Dca
 AdISwAhJa0UgWHweM7SmmRvOB72LQFSSosgUpRc792g+5Wp7X/k+eyozIyxBuzC+q6U3
 GW9z81j7MjADgtpkj0paanEWQmbVFj0KfZae9DC1V5nbjgR06p2Uaj/2/MyFTb/wjOdm
 rPpwxY8aZinXoIyX/cy8631TOcisbBFjEqccHA0vKUFZr/iqU7C5j46mD2qYgAgsnKAq
 C/IqmSLKAd0URMLXazMTl3hVUoddvROmc5SArBMwCgxtnTPf33HuZ0GiCv9B1/BfuJH1
 3pvg==
X-Gm-Message-State: AFq9FYL+oyvZzqZ+RJDPh554eHrabqKlG68cYX3+oaqoSiTMgAiofrB2
 qnVeaf6DIAOCCKskmV6yuQ4bzh1bufHMXeL9pMC+M+E3MLnMEoD7PGz53giJT/74eGH1DI+okwb
 M7rchCvTCmj9cMzDRbhO7YVpmL5lyxvp46Q1B0+dGpVJiHTTF71WhnPJ6eb2uPb/1/HBpO58=
X-Gm-Gg: AYBFou13JMX5sMGF1HvTtgS0MirvKB+VDbHh/qOGl4AAMhVyRCq/TVIhSLxVpTR7IiO
 ZcBV6iM7x1Gg5KY4WxW4qyRIg1HsImPZVs1HXJfYJCzHIq/+CGviRE9bCP3YnXxj6fXDNXZZx94
 OtZ8GBcoH4W7KiSt7U8DURb/c9VPGc9xYD7CVPdNBBfC0MMZIIcljehmjS1w/fe0kjcZ4C3xQYr
 af1MMNZ9bpDyk4wXfJ63gStG98XNHqKMEyXyPNfQC8IQocCLfBTAW9EsX6z9BrH6eb7VH+1nIME
 xRXhP1ZLsONrKh9FwwoKs6i8gPXBuLMZlsDs87QKzSYfW11y5NeTPJE9mWxyZdXdEnEA6KrxHRy
 AW2hgflXBdMsQB+x7/BEQP7LS8Ts52XEQgEIdWI5WRDIkk72ReCEmgDxzCNajB8b7LLhRCs9F5r
 AASZspG1oyCqFm9tQO4dI15XKtDMvK
X-Received: by 2002:a05:693c:88c9:20b0:351:7444:8bfd with SMTP id
 5a478bee46e88-361a2e2fe01mr10602285eec.39.1792407253067; 
 Mon, 19 Oct 2026 03:54:13 -0700 (PDT)
X-Received: by 2002:a05:693c:88c9:20b0:351:7444:8bfd with SMTP id
 5a478bee46e88-361a2e2fe01mr10602259eec.39.1792407252489; 
 Mon, 19 Oct 2026 03:54:12 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:11 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:23:55 +0530
Subject: [PATCH 1/6] misc: qcom_geni: add SPL support for Qualcomm GENI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-1-2d8f7a1e6730@oss.qualcomm.com>
References: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
In-Reply-To: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=1709;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=nAXQvlz8NzXKAtTBBF4n9rmH8YhqLXpOLXhBfJLYACc=;
 b=vEmA3DIkQgej/VJjUnDFOnXe3j5ACjJLbJIa/GCLr5tyBeDEWdeaAuOEbHOFMqwzkYKP7akGX
 3esO0aSFRtUCaYwUkiR7YCDZXGI93A9mSPf0/nbytkr3cCc+Ra42ZDF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: I05vu232vgHd2Rq1l0JYi3cPsn6rmlgh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX9iDiwfYVfbuh
 omL0h7aiJpGuj/Epf7Hc6PMe7lZH1Li+MlZbpIUWgm3JU90ulSfmD95+nqXvdrqy6VdclZ+F0kU
 hP+tM9EFde+eaP2uEtgHs4qMz9Px28M=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad5f6d5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ydkT0emSJiMV-jbtYrMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: I05vu232vgHd2Rq1l0JYi3cPsn6rmlgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX7LgiIMpfvCiA
 +UXYvHMo/JTlio7SrMMjktsLgRuVa2WOYzLiRnof3EeGDpV3iIhTHTJosWnuR8pEcr9B/X4YuRV
 8UC4liw8r3Z5aUl4r5SXg7gIibXflr9qOGPRlSH8oaRILfDlWrA5Rd90jLPijGbGeyuNl/skD/O
 D7NbYwWFdYHI8rxyvDrcHDHoeVNSSDnVbBcCbGTBzXuHspHFjSOfpUnxEODbAwQNC4Z1k+7brae
 JI60VmFMsGidtt6jC+jdH9TSMs3QBf9zUZh/S3Qa18kXDdwbWqe1xw+ZEBAQaQZSRhi/aacpb6E
 4U/HtJOOwHax6gRCuBfDMxvab2ee2x/f/oAmykJNDLZCgOcsDQE/pdg5B8QdCNr2jUZ/Z4IHBso
 DXXAUv20w/yGjdJGIruJ0TIc/czaHM3CoRomWcnp8W9G3Ib/5fBkTdLDJgfrzYNgxFrzOLQ2cGS
 T5f0hXsbdg8O3hBhPsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190043
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

Add a new SPL_QCOM_GENI Kconfig symbol to enable the driver in SPL, and
update the Makefile to use the $(PHASE_) macro so qcom_geni.o is
built for both SPL and non-SPL phases

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/misc/Kconfig  | 10 ++++++++++
 drivers/misc/Makefile |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a7e86c2ee5a..3dda4ea024b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -102,6 +102,16 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config SPL_QCOM_GENI
+	bool "Qualcomm Generic Interface (GENI) driver in SPL"
+	depends on SPL_MISC
+	select SPL_EFI_PARTITION
+	select SPL_PARTITION_TYPE_GUID
+	help
+	  Enable support for Qualcomm GENI and it's peripherals in SPL. GENI is responseible
+	  for providing a common interface for various peripherals like UART, I2C, SPI,
+	  etc.
+
 config QCOM_SPMI_SDAM
 	bool "Qualcomm SPMI SDAM NVMEM driver"
 	depends on MISC && NVMEM && SPMI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e920b8637eb..837d73ad23f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,7 +66,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
-obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_$(PHASE_)QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_QCOM_SPMI_SDAM) += qcom-spmi-sdam.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o

-- 
2.34.1

