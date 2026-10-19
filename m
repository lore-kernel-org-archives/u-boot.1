Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C372CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 250AB606F4;
	Mon, 19 Oct 2026 10:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwEUhsxt853K; Mon, 19 Oct 2026 10:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0ADC96067A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405589;
	b=X/gLKmCAp833QN8o2YG1ErAcxTT00Bl6cADmwLtELGOw2Vq/klb2nn+P4f+JVCd5T4wp
	 2/nDJBX/MUTbm81USV+6e7Z2l3xTQucvopRPiBXK/rpXVmwln7m6L5xfAcoF+kZI44Lgf
	 MBkZRVb0TR2q/zdbzX0xrLSLTEW1C4528GM032vYLcZ8V4DpGkQRz4RqgWfWwaDjhZail
	 9Yqn8+/BabUOSh3LiYBlKSdqUASd609AfkN34LxkK3cAKfblVih4NGnqqGVX/FdFSPyXT
	 Ci6Cw2sbmBCjyOh7Lsei5QA6wZszdgS1J+PKLVU+UudBIv3ylVi34HOCwv2AZtE9AbA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
	b=WHx/mKj6Aag2aWA/BWicKhcSO4JF7nbGiUJTqBdBby3CfL/WkGz4EBIF3jxwIYqaNCrY
	 0IOkQ6AzPyrx+xmj4Ux+q/bdStHsbdsEcHb0+BscFlohKWLRp4UKsSnY5Z5DGuA9ja3sJ
	 7j1zI9FvP/ODpd3ltH7bS4pogScjht+dN4PvjS+ZWhWqnQVSs/KTFec5RI/EYO9V6CHdE
	 HkCzADF/hTgDBAE+j8svHUaqCPUf3fKljg1+WgJtzbx5igYqMgdWWOr6zPdyAVpyO7NSV
	 So89NUeQhgZxbVtK7cbiB9rOy1oNEtA9GoX5Vxwpx6F5F/96b8Cy9PAgLD2ysCHpJRA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405589;
	bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RS3WFE/t4z7xAYMUUyf6NbJV7rEODzoh+aoD2DN/VNL1+Yv9g7U9ebrtLtGwoc+Cv
	 OGEI2EB3ujVgfZn9jaHmy81HGXUix6mmNVIE/L8TSVtuwbMmzrIEv9C3aHyUJVXFQE
	 JpfDRKPQxO7a1XnbYsSn+groRHwBMJH6drGwTSK7XzSPZ/aIuiWIIPwIDyeoJnLobh
	 mgbBkE8I0IbO+JLnAxwVyZzDXU4SRUmoO1+7EdJNLwiCKIi7kBib/zQmkMw9jBWBhH
	 EEEELd1fIaig/AzZx7Ydryrk0S1YhZVP3XQjkhmtrxMXqDHCjlsG6b7kYOh/+vloG3
	 flGNHod4NHD5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ADC96067A;
	Mon, 19 Oct 2026 10:26:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11AEA2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0210940080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SG2-fPbrk0BP for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B772B40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405587;
 b=fwPgGwuD4YL//cV/7rIHMQhjYWxm2Xq7ZbzjCF6vnsW4hYxU7Iw97NGkynWN9uWTH06t
 jcOW18MtHJkq0nRExCy7JKwAgPsKeQogiR15adem6QP99aQ5kgJ78qBkrwGl/3bg38qKT
 C6VmY1xqV7k6+hcdFW8gF6fBvMXP2GAuxsqG2d2p7OFRWhUJizkPud7zCSeriItWPfHvm
 RAaxoVIdZSBpESH9ebkZYqIknH3rEto57iaDYqEf0vUMlFS34hAuUBiQu0FDJXPrDhF4D
 HH7vKDhjrlRmAW/UFUJkgDaca+Q1NtyuFcIbzNfH4Xqn/UPMZkVHGOHW9KQV8KCALQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405587;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
 b=aeQW0PQ3x7pErEtM8Gs4osxyMrHBHKCZRzqQI/b3bsjH0k3DovHdbu8vbHw36ZHeZYxh
 7yG/5B35bWtvIiKIHhA7sUVGqM7KbcJ4xw1EPdfg44JlyOn7+7InV14l0HgIWY9+o0FKL
 cyizUbZMT6mGI8/ttWNqsa1JFj481pIXEFv1vCE4QGiGmfDvhLK1OfEeqYrlqW92WSxiP
 kVhsGTAjbqH+/Hee2Tb8R2NZr2odaS7YqnG06Wvp4wVo7XOLXhCqD8LYeAzZR4Wan5Qhz
 huKOBrqfZLTeNhIryv2t/qwvlp8TTdx6jxBZSVCywY6hf67MTb10+DdsxhowpXtbKlA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="n8xQg/MN"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QMSeeL2R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=n8xQg/MN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QMSeeL2R
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B772B40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PAxe1896752
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=; b=n8xQg/MNbafHBr++
 jZhP47CXnFDQaed/X8HerkoLXVeEw8sI6rYsalaSteu0Enarsey3OTPrl3lCKszw
 NZ63jas5oY41hcpn9PKSmvYjqhlBB8b8jE6YfvSQaLKvhrVAf+ms/vbp1AWuFatC
 mMit6JuyPMLKuxO2lVWCrKo9Fzxm3l7LLfxM3FrMcfSvyoQIYsDB7nABaAZpI/Q6
 KhXe2RYCY1ITgfTGb/coU72mnfOupXLUPKqnFo98WkZdlhVrvQczB6t4DLRHkkU+
 3P2I0ytGHFmKITag49wlvIuvpRw3KiKPHRLScwAAQnc1Qvx5/QAr/at2DHNWIccd
 LqNS0g==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr9dqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:24 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0f1c06332so23591197b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405581; cv=none;
 d=google.com; s=arc-20260327;
 b=nBNyg/Xy6RELnWUjzPihHd9gGoU/GQ/ErErtHHaBNAqN4EmIIxQDzOpfZBDOIAVQ6/
 qbJaOZPc4xxmnIHSO1cIDabG+fnPIO8ARwV0Nb8THRPoWd1FYJkC0l2E7Hwzq7TQkcHa
 38ZCiCgP32BcvSEh1ovGHq/1J7voGkxACwc4eKOzOgzoJRP2xL0Da8oYRIV58MhyBJNF
 q+yeN0Zai4mkJ6K1uDuW92m3KAgugVxK5ndFlKiWJpJYqVw2dy9z1CGs+j/41NFcML62
 B8auZr6tiDwHOFHVMCnl+MWHJgtLeXlEGsMk9KZvtWtJK6Pckw8xqqKi3VG7AhjT1U1M
 aANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
 fh=EYFwrZ6XaXiESV0TDP6JugSzvG/MiL7tYaop8MmFpYY=;
 b=jx30wWhan7mSMXwx6FW8AvfdHSDaajIzvqjwXf1MX31TVW4rLY/o3TmeDgsYEqBCtK
 aRToU4z4xLwKY5UIb1q4D0F2HI5d3rO6mtBZrFW9DRdCHmo+/yOy9GBTtNZsWan1SK4z
 QuuNcqVe9erzIZK8YzRg8xzWJyBHiOAj9ZqfoYJ+e1DzHIMGHkwTJQ3l9pYmGwqpJhpF
 h57yPaBeLGm0hHGtv2UrED/lqJlkJPMhjkDigaPM0jiinanqnEiS7/C1eFrRJMAuomZK
 GXt3iF0E8NCzcNVzL7kWmAQKlpMXoOGMOMs4ubFutO/cKHynizquV4JurKFaS2heyEux
 LsUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405581; x=1793010381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
 b=QMSeeL2RovcIbcyEi3q1JJI2gHyrRdooHVGa9d9mCO3AgABIKY8EnCHZNaEjl/4dOF
 8fmHwp4EykyFE8HMr3Qf+854YmQG3lv8OB7FoDbFuAMWnAAQ+Jy3/gOWdEM00XDL7V18
 9AQx1V6p/0ZHz0QhL2MITWC0JfM2fUvtz0dtdPz6/Gnmm7MjN8MsP8IuoH3NRB3jwijn
 oYLnC36pnghSmn52JwVcQxSvqey/ayAOkg5BlaoKM6I64C4j+EOHJjb8SPJvsGumyZko
 WKoIpS3PIFdLxVieuiy/CN3w6xDK47KI51uK2sM5yeQfXj3jR03SlSkL2p0e4ZzHOwnp
 cBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405581; x=1793010381;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XQK0zhomXUwGJqLTMypg3D/lU0kmr0/F7JV79DobesU=;
 b=orB5bpgTY/ymAwD3sIDlF82a1f7UyYETvTkIw6SL4CnNWOYCA3bex0Dfp5T116k6Q4
 /FoOY89e5m/B9J9yfqI6HCSS0mPFIGOzv5Kf86KyL4mJRjEBTlVWjlT5jMy+6Tu3u9UP
 vW1aM6r8cxOGqV+sinx+3MvCLeM7WNbmiEiZwKDq/Iwgo4GkWOMpSte97KN6i1PgC8xQ
 IlXxRYUefIIk/lFujzLNdEwjnV878iwcgRBBhiZZdUjf3Fif7z3DqrJbwn8lUeLXuWZB
 F6ARWxk4xi/X16QT/ZCNsZK9XrkmlwPHop53PD649530Rjcui9msrK0fjCEZd/vXb7/A
 VGSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxra/HWotw8wMpheMoomfyLmvJL6uEszRFkWEzga+F03EBaBzC8U2m2Ntk8irr6ZsBAlMfWwLE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLces8jfbmj7ruoZpUzLpZvZSV1KYTKK7CAK+Zm1H2p+21lDF1e
 3euPfr0vKTO5iZ2yH6+vJ8pRn73VJEpLjfV1knFx3hy4IB+QL9zzh9HS3zOW5Hfq/uPntF8nzyd
 woDUQUpTFePAP/JH0h5bqeIrcmXmwCGTD3Eq3xLgFu9FCB1N9i/GbXL8U4VQs70JGlR9hCjbVGD
 1rvgSPR/pA1cJIR18wOQvgTwaKXMZ1ZW0DoOAiZW+qW5NXZA==
X-Gm-Gg: AYBFou2qSgYiRW/jsrIS7otkhzeoFyuCHJFOez26nQqONnYJhN0a8qgqb/5tHhac8N6
 zeXzDJ3Ohg/FdMuIzA7qwLncPgg4kPjkCeH7HLBjlP4FKtVUGiKpoK5mmA9BZBsHGZJtvE4TVoA
 PNTTFhy6Ehk1fYtSydiaGbO46KZuWP4x2McKV0LHEGA1AA4snmsPjhN0OCkw==
X-Received: by 2002:a05:690e:43cc:20b0:677:c18f:7257 with SMTP id
 956f58d0204a3-679ca7031f5mr1148749d50.23.1792405580991; 
 Mon, 19 Oct 2026 03:26:20 -0700 (PDT)
X-Received: by 2002:a05:690e:43cc:20b0:677:c18f:7257 with SMTP id
 956f58d0204a3-679ca7031f5mr1148745d50.23.1792405580503; Mon, 19 Oct 2026
 03:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-9-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-9-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:26:09 +0200
X-Gm-Features: AclHuK_wEH-c1LqXg1NusHoKoW6z7_vdCRmIFffak3W5QxV5xtHzLutkNxWcwM0
Message-ID: <CAPzfCAZwPj7Y123Bf1CNmDZPB1qDtRNvTh_0LkOaCG4ZKQB6CA@mail.gmail.com>
Subject: Re: [PATCH 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX1e8taj58had/
 rBXH57NNB4a/mcg+rzXKxV7XaRFnuMqRHC75oOvPh1WFFFskBgNfOuTQdCwMz5CkNKXcI0i1NLP
 HLJkdKmWsb/Zg4ab5aEw3l9N/83nwCW0hrw/FhmY/o+io26UkPYoVH/xKQJW90iwYR3GWTFzy1I
 MtHboB3Llq3iv8GleIG2YEizG4n+Y7fdBP9S0bEGmyDbs8AYXcAfw1vxXol231Id75IVly/wRO/
 QPAGHQL+9rjtp885Qa5+/KVnt8ewDwn3cyZnsBFVrJVnFRHsC0JgS2wB594rusT1+NKP8br1pU2
 +x9uJJpdjqBTzTq3nEs+L8x9vy+JXOO1RE19QqrvEdCWLw2flZHo/7YNyq0enZ3Ez5ydpjBAQg8
 7ZmNWJ0QgY2Qu+JDeiVDfvg32WBMxrMKOXblIawbPD+Glni+xt9kswRiMmTKhvysA4DqL/NuJ6D
 duBB5wsUwjxIedOAWAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX+BlCTr8u2QgD
 8mn59MRImDe9jfUemUSHUeapY5+NV6Y8BUMN64JG4HZor3OJirlQrUX96HqkOCI0m56B9UXhPso
 l9IzoSTC0I8TRbYGaW2E8bwVmlJy0eU=
X-Proofpoint-GUID: Ka-KoSYpowGpfH2I0SsAfEcutQs3Cszo
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5f050 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=eGLVX4enk6scTve1SfUA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: Ka-KoSYpowGpfH2I0SsAfEcutQs3Cszo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Right now, sandbox runs the AVB tests using mmc1.img, which contains a
> fedora image.
> This does not really make sense. We should test on an mmc device which
> has a proper vbmeta partition instead.
>
> Add a new mmc12 in sandbox which contains all required partitions for
> proper AVB testing.
> Use the mmc12 device in the avb tests only when running in sandbox.
> The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
> is available.
>
> Note: the vbmeta.img has been generated using:
>
>     $ ./avbtool.py add_hash_footer \
>                    --image boot.img \
>                    --partition_name boot \
>                    --partition_size 4194304
>
>     $ ./avbtool.py make_vbmeta_image \
>                    --key test/data/testkey_rsa4096.pem \
>                    --algorithm SHA256_RSA4096 \
>                    --include_descriptors_from_image boot.img \
>                    --padding_size 4096 --flags 1 \
>                    --output vbmeta.img
>
>      $ gzip -9 vbmeta.img
>      $ xxd -p vbmeta.img.gz > vbmeta.img.gz.hex
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  arch/sandbox/dts/test.dts                   |  8 +++
>  test/py/tests/test_android/android_image.py | 15 ++++++
>  test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++=
++++++
>  test/py/tests/test_android/test_avb.py      | 20 ++++++++
>  4 files changed, 120 insertions(+)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 25c99ef81472..80f505083cd9 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -50,6 +50,7 @@
>                 mmc9 =3D "/mmc9";
>                 mmc10 =3D "/mmc10";
>                 mmc11 =3D "/mmc11";
> +               mmc12 =3D "/mmc12";
>                 pci0 =3D &pci0;
>                 pci1 =3D &pci1;
>                 pci2 =3D &pci2;
> @@ -1398,6 +1399,13 @@
>                 filename =3D "mmc11.img";
>         };
>
> +       /* This is used for Android AVB tests */
> +       mmc12 {
> +               status =3D "disabled";
> +               compatible =3D "sandbox,mmc";
> +               filename =3D "mmc12.img";
> +       };
> +
>         pch {
>                 compatible =3D "sandbox,pch";
>         };
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> index abdc6cd28744..72725ac9044c 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -83,7 +83,22 @@ def setup_android_v2_image(ubman):
>      ]
>      create_gpt_image(ubman, 8, required_parts, images)
>
> +def setup_android_avb_image(ubman):
> +    """Create mmc12.img: boot image v2 with vbmeta.img."""
> +
> +    required_parts =3D [
> +        {'num': 1, 'label':'boot', 'size': '4M'},
> +        {'num': 2, 'label':'system', 'size': '4M'},
> +        {'num': 3, 'label':'vbmeta', 'size': '4M'},
> +    ]
> +    images =3D [
> +        (1, 'boot.img', test_abootimg.img_hex),
> +        (3, 'vbmeta.img', test_abootimg.vbmeta_img_hex),
> +    ]
> +    create_gpt_image(ubman, 12, required_parts, images)
> +
>  def setup_android_image(ubman):
>      """Create disk images with Android partitions."""
>      setup_android_v4_image(ubman)
>      setup_android_v2_image(ubman)
> +    setup_android_avb_image(ubman)
> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/=
test_android/test_abootimg.py
> index ff54a8318a12..a54e09bb09ba 100644
> --- a/test/py/tests/test_android/test_abootimg.py
> +++ b/test/py/tests/test_android/test_abootimg.py
> @@ -49,6 +49,18 @@ using the same steps above :
>                  --pagesize 4096  --vendor_ramdisk ./ramdisk.img \
>                  --header_version 4 --vendor_boot ./vboot.img \
>
> +3- vbmeta.img
> +    $ ./avbtool.py add_hash_footer \
> +                   --image boot.img \
> +                   --partition_name boot \
> +                   --partition_size 4194304
> +
> +    $ ./avbtool.py make_vbmeta_image \
> +                   --key test/data/testkey_rsa4096.pem \
> +                   --algorithm SHA256_RSA4096 \
> +                   --include_descriptors_from_image boot.img \
> +                   --padding_size 4096 --flags 1 \
> +                   --output vbmeta.img
>  """
>
>  # boot.img.gz hex dump
> @@ -81,6 +93,71 @@ fae68747835d6dec42bc0df6d74d1fc5a0bfac6e89331797b95649=
26663a
>  000080fa912fcae854c55adbeb2769d4ab34c9ad4d16963f010000000000
>  a88d2fb468951800500000"""
>
> +vbmeta_img_hex =3D """
> +1f8b0808f36fcf6a020376626d6574612e696d6700edd369301bea1a07f0
> +7062dfb758521a55b4b650722807572d41ab2d5a6a4b90a225b64aad69c5
> +d67063b968a9725b91632bb12fb11faa45c4762c8928557b7a6c557b0fee
> +ccd9e69e993b77eecc9db91feef87df9bfcfbcf3cefbe5f99b385cd10400
> +006c803fb0ffe5d7e4f86500fc19e4cff9c775efaf01e4fe2d8701ff5aef
> +3f9d7ff9d323d413131888866869e8686802fef7025c122d02b16f9c05b1
> +3fd89904c6054cb993631550b20e3d36f0fc97a5fab3e3ab1813c7059894
> +3024ec1e6a4c412f9d71de37ebb3132b8f25858b29e0a98d19820724a8ad
> +11ef74e93b156edc57630f18b6788530b0de2f661a5f755bda6b28cc5367
> +f41f67dc7c008db14b0f961539b149a94adc44317ab0f55f257d50addbb2
> +6ca967eb2f0240832e33ad34f0165457652a752b30e1a9ea60bb64458785
> +4d17bf22cc1fc07b777210d3f3e139b0377020d02b59ac2d84ccb5f3ac4a
> +eeb60e1322f9445a259a6b3c79f2a563e7e16a9c54886ac6323659f8ef85
> +82e36fd1b7728f1d645495422df053249da0d2c58fe44b24a250cb8f7306
> +faa26fb8231abdb6ce657cf416e183cb4a111de2a8363c1d8a61b5673f86
> +01ef83ddc1059b3a370c8a23a5560bd9433d664dde352db09412cab2272f
> +5a145b363c347439a13b1ecc535e95f53ea79c401b48efa277065eb21467
> +6f104b19d15d8f4790cce128dd673132db7edc29bb63b0899e25ab1778ce
> +f14622bd6d9ff0e486336968f432b3c107e9e0fa75044c19e8474936cfec
> +c85b0a1cad94ac579b390a995d312280a6d3b0dc2224da514ef5965f2749
> +4733a4324d40ec6bb8b8c7ec2d0bbad1a8ffdbf3743231b1125be6ffe07d
> +bbf14e2e7c3c7cba09be7b0486e22b708b40cc39d88176eb190bcbb9905c
> +09cf1c8dbd282817c483f5b7f7b1cc6147f935fb65c5b7d42ad70b5cb49a
> +667f3d51fd70d38a5dcb017c8df917df58c27485c47fb846bf1781f27b3d
> +42ee795c827dfb6fdf007feb11e4bfdd61cfc0404cc5d6f032473f5cc44e
> +f49025bc09950a607ad7114cf1da446413f27b3fc1c875231c6ba6c5d629
> +179c169fd52add2237fc48f17ee770a9b15ca6ade3094e1c001006dc9e04
> +9219c0caf9d178f4638124c3aee451d1db2ccfbecf42081ae841991956cd
> +cbfa693d4815d0c2b921c6657fede06ed3854870fcf34486cff70a07c557
> +df5b0bede94b55dc2a9138ae2297c3980664e5d6ca9551a8aece84ad2ada
> +59999ec559e947c1510f35ebaa136a6d5ebf7e03d291a12cf71c1ef08495
> +6567fe6456310469ddc4894c29f0c3839bfc27a2dce1789043666397ca8b
> +aa6b6cfc9a8c4cfce65a00a15dd365b7a8721a873547a4a56722cc8e29b1
> +5ceb11d40ead10cf3bf303ddad5d22b244eb8e63e547c45d1809417def08
> +35daec737be2bb5fe95dbc36405923229b731364c6792a9e5e3718ea77ed
> +8bc0edd18aac4b7c19a35a2207bbec281519f511196f30c8a4ad6dcfe607
> +eb45652b64f49d7965f5c53e6f413b3d90de57d04ff6c64b47ac0284a213
> +23c2fce49b6b4a0500e7d42e5ba2c441d4b66b4cae141cc650e760918560
> +1809522a81a6ccc4ba2d1c024739f89af56baccca1f01e0113e36c9c8d71
> +677d4b10b258b7d2f29ca8b9c68e103e632e9eed4054485ce2fc6052ce7a
> +53b7645090c4a7f677e8b39eb5dbea20fc570739f3b28a4b0b88f4357b6f
> +44db1a7949f4b2405cdf8a1f5abd70bddbd9bb22399b2e80b6ead9e9ced0
> +22f0ac6b334b751baca4f605ddcd7bb5d337208ec2ede1ea714a13548f03
> +e86c0787a69db3e81940b11b0dabf1f6198164b069aa8198064c09d4eae6
> +940ee4359aeec1cce4bb6283cb525ed79988accaa5fc2c1e9b713dce97d7
> +0f867063b9d292672e8f58bb2051a5776779fbf928ced8377c4bedc704a1
> +473aa9ecde18363435b41cebc30d3596295273af3d61a65044f901d1b49b
> +44d7bbc439e425afbebcf6095e31fc772ae6707eea95d8c324afe5a4bab4
> +3db92585c26127dd880cfaa0e1d13c916f089d90eff5c5f59d350a19a0af
> +af42f06d80b6ecd75cf56c954957f49ebf4f75b7e2dbfd6bbb51a87d5764
> +0950f2e1e72fdf7882136aaa3670120d63d73f04974fa900c7eae49bbd1c
> +1c570ee30b1e890956d25fdc5121c5c4a7f0e4fb76b64cee3c296f7be8c1
> +b3946c1856b3a6095900c866af74f400c0f2d5a065131f8d55bdd645701d
> +a78256f019ab8150ebd06f53484904ebc86d7caf8490eee55d7f9cf4866b
> +89f720181421ff81aea5d92d3fade3f2a38caa91dbde272a476a63bf9546
> +fefc76b1a5b4701eb078fb02a637100551b538af242d3ba2a6e5ef7cb180
> +b3a8c684c6ab9cc593550ef70abf67fb7c8251a49e3fb43a87d98a9dcf9e
> +7c3cb6cf17646a581d958d9be8a74bb7a2f88e6c128f7dca29b49b8df76a
> +5d26e4147f467e9752ad8dadb562330ebe2d68dbeca174f869b17ee5f5d0
> +40d6ab894ea47d3a996306b26ccb7479e6b3b6bd7ec52b488c2f48fc4cdf
> +ac3415b9231b7415cd8959add708fb88219272f2135e7e2e673c069c3a75
> +ead4a953a7feeffd03523602d400100000
> +"""
> +
>  # Expected response for "abootimg dtb_dump" command
>  dtb_dump_resp=3D"""## DTB area contents (concat format):
>   - DTB #0:
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_=
android/test_avb.py
> index 34cddc485ebc..75abf5d1b1c7 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -13,8 +13,10 @@ For configuration verification:
>  - Corrupt boot partition and check for failure
>  - Corrupt vbmeta partition and check for failure
I know that it existed before, but nothing implements this
functionality (can be a follow-up series)

I tried iflipping one byte in the boot payload of mmc12.img makes
sandbox report:

avb_slot_verify.c:423: ERROR: boot: Hash of data does not match digest
in descriptor.
Verification failed, reason: Digest didn't match or signature checks failed

>  """
> +import os
>
>  import pytest
> +from android_image import setup_android_avb_image
>
>  temp_addr =3D 0x90000000
>  temp_addr2 =3D 0x90002000
> @@ -22,7 +24,25 @@ temp_addr2 =3D 0x90002000
>  @pytest.fixture(scope=3D'function')
>  def avb_device_id(ubman):
>      """Returns the device id number for AVB
> +
> +    On sandbox, creates mmc12.img and binds the disabled mmc12 DT node.
> +    On other boards, defaults to device 1.
>      """
> +    if ubman.config.buildconfig.get('config_sandbox'):
> +        if not ubman.config.buildconfig.get('config_cmd_bind'):
> +            pytest.skip('CMD_BIND required for AVB on sandbox')
> +
> +        mmc_dev =3D 0xc
> +        fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.i=
mg')
> +        if not os.path.exists(fname):
> +            setup_android_avb_image(ubman)
> +            ubman.restart_uboot()

If setup_android_avb_image() fails part way (e.g. cgpt not installed,
this was my case :) ),
qemu-img has already created a 20MiB mmc12.img without partitions. The
next run then skips the setup and fails with "can't find partition
'vbmeta'", which hides the real cause.

Could the image be created under
a temporary name and renamed on success, or removed on error? Since
test_avb.py did not need any host tool on sandbox before, a
pytest.skip() when cgpt is not found (like the CMD_BIND one above) would
also help people running the suite locally.

> +
> +        ubman.run_command(f'bind /mmc{mmc_dev} mmc_sandbox')
> +        # Run mmc list to ensure that mmc_sandbox driver is probed
> +        ubman.run_command('mmc list')
> +
> +        return mmc_dev
>
>      # default mmc id
>      return 1
>
> --
> 2.56.0
>
