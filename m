Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA9CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BB5840655;
	Tue, 13 Oct 2026 05:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73uFMVnwwST1; Tue, 13 Oct 2026 05:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACD244065B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869591;
	b=XidSVq03djNBRBgolV4xZeobAFEbPSq5WMIZMsk1ZALCy7dgb2MnDBMu5lGh01fn/wPL
	 +7TwAZ2Frpozr2GwowSTubxWNoKSzyHmeFXeVBS9mNjvdgDvBrwiEiiilYs9h2SvEmHzL
	 UiY9HqxUALvjI6yn5NrfesVXd4mw/y43BXKQIGHzUMzUkYU8X1M/P8/1WYyUMtc1hNHlA
	 HgfuOBOglTNihdXiGJnqTERF0HS/LKn2UFX1xlIedDWK449dOmRloYZa+TxD+TzdcytqU
	 TC1feyezs7qrCoNdLsYLr3fagbllCpS3WB8X/8yyqPUiThTscGOt4qHUTkOV1jWmq0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	b=dlo/r57MJCrtG6DotMpFA8Lv6kuAkQK4W8caSvbGdbKC+WQ2PzD7vMBzZ/j37UH0uSc3
	 DvmJ0Fmv4LCbns6tKflXsnNQIDsJFUThMTVL0J74fAPVdqyKXqbYVifZItVi9YDvdcEa0
	 M7o+kW3e2iSMNDWEp6G8sE15py7TsgeYiB7BOjAveGh75DYaIxwAqsxm/JnLuYmcoaPl6
	 iVrHmf150q2OhP+NiCcWW5fuui2xsInKSJXIGR4Ht4NTvjl78i0Sb1s/S/ebM7kjXaLem
	 2Dbwq0UfcBTNc9tPTeUzc0kmx5olyUsJf/hQPvNKhzm7ojMQVLknf84p1cLgQeren8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869591;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBeysVcVCB7k2JzWUqC0/A1dFzj13374YJqQhbD3r302LWpyXEYE/25sAdEboWLkm
	 AHF8k6ZqkEVLXZipAQYc0blxNxvQzgv9EPGwZrZAXfisr9mvoVet6fqOtK2Uvcd57J
	 V8dHmE83ApL9U8+T9m72iKKxG7pkJ38VglbWgjdQQjJkze9z9TPUMT2S3MCLpm5Igg
	 +JxJ70lHnXaCtlGimoRybGplZQNS19k7ZhhPVdXggcCTlpgfeYme3U+rPYN5VTEAnu
	 2PxJNqHzf/ewluOvLb1fdqVHNuUTfXihNB8jGqgSnhzMJ1IkLsY5EnrutOrwpoNqH/
	 NzhKP3Wl2mU2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD244065B;
	Tue, 13 Oct 2026 05:33:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3422F4DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2279E60748
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nLHu_FXgW88 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92D0D6066F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869585;
 b=QS/nYV3GNYUbrf/nCUrC7VsVBHWH/Gg9Ap29FEVrBNYBB5tmi/a0JSGKz3Lx4G73Wu64
 FcMC2Sc1wiRp1arA2AHdMBytm/MbWy/iSjXuK9yNL8hjncjsy6lb/zX//JlTViiX0omrF
 t9+dCBKqcvH7BXCwH0Ozaw9OADC5KzJrWm+pPT20hT6InRz2irwKf5vaRVUMzfN9iKVe8
 P88hjNpCcaE03B4wW7SMgVCkdvYeSPw8phIBpWuim+AwCxK2S0GnXcy3qmuyg+mmBv4kO
 vsXms98+CGKQsfe5T8drK8w9/2rhpSSdACD+6KqzP+B8QUMQ5y3cwq+1Y1mvycVhZBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869585;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=sjWadNv2oHzlTK4O4YYFKWnZsoTGZFDjUt5dQkIvWRLp7TuVNufPUttvowTBKf57GCPK
 bDKYMVsMuhwrjbVM0HNioVFvESglWgXm1rat56axM2IrmkaL5alRZdBxv34Qe0hODtKsj
 nBvEgHjEPJ4vf78yhDn+uQwOW12tEHSt+IgmH3zVt+odsXZsxJ2yieqxAOrOs7ZFoXTuP
 Tk+GWPJVf9NlcHao8iNofTuNdK60hg37Uxm4xHyVI1gLRFfHNqaWsa3IQzDrjqDcd/Lwy
 XG7n14+sAOj39bE1Rls0dY1lTAeosWaoMdJLj1+J6nSW78Eu7sPImeTogK+naUZMPDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jV9IPDho; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcqhIaSH; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jV9IPDho; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcqhIaSH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92D0D6066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D3xIFB3476145
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/O0iBQUnQd
 JzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=; b=jV9IPDhohRohXb2lc6dYrHfApeh
 DUx7ujvt+4B7hb36DhXEQHh+8hXE3726qGrQWdWE8vNlrgyfDeojFuVuNbprrD4U
 K5AsUMfbTc4QdlMBuAH3kEeoyZ/STUiyP7jGu80qRmR0scDQmUySvAk/7j/57xvd
 MqXr1hzOx8zFnx9Hsh+P0BJpKwIIdogmjPm9tNDfC0rTtEQ9ODehlOQZGjXE0RZ1
 FLLKIqg6W6cqYipoG9zEMLXyrnbZsoX7xbGDpsM/bp7VGt7/L+S49g7XR/0d63sH
 4WR0Nhg33NYNO/hsKeI5tm6KMkb4XtQvw6CHPekkjBs1f+SNcg8TN5/cL5A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j89qg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so2296993eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869584; x=1792474384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=BcqhIaSH/KJW12ZrRjo9bGrwY5mW3eTzDsGP+e1nMr8ou0QNAzV3+XMgywTUEticB+
 If1gV53euSJcENfwpQEIrpQAHfqvqNQucqHvJj+8oRzvWFXlgdL6vLCvX+vPnGH77xN9
 gZkvYMA/3q/KLKOW9VawfqQkHu1+AVfq4T3GTEFrNaIEeXIEoJ6s7vIQ575nzlpuqxnE
 r5qZ9le96hDm/dblpptAMoz88F410EPlEI1pbYGhls9muoehMINE4RRLKn6a/PVGisl9
 qnOTBBh0CNRxnfsqfmUkWOvAnFvxnTQvQ+AY30t26pV68EVNjfSycOuMRknqePi/YwJO
 0fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869584; x=1792474384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=RqQdW7tneyJLI0y0AZtUoa2CydMEDw4HtTcOGqEcZKIaY1bpcgZxbgXrXCGZR0oWf1
 9MZDHufcFd9BSnfI2Fawb3PYZLtmmZ5xsorkom2OpNC1KCF/5dOJtulMS5C5XTcb7hl4
 M3i1kFjDozaUwxkKLkhLSxPfEXfptcVmRcEy+Phx6r9gEKpe01+Gs92/49X8fHO8hBPU
 fdD5dmQO1AZDphXeCqZS1Ga2ePq56UHLJZLqhzHXTZHBBYwjdQ/Qz9rvkBwlSx4wZtsD
 9E+meJqkbpQVKor8lB11CfrgJJ6HzV1AcYS7502sutPVcTDDzVrfHQ85ezxB7izPRGIp
 jz4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJzan+K6TnJmPrgG04PFE1FxKfDoq99AM9FVB8jYSqD1Sr0HjtAnqXCaQXCdBnVt9MSLkEm0o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK1HaZvuruq6MF4531T2HSHBp1WA1QiBQGskfPDlyhQHhPLfRsA
 NcaughzysoRl/uGxIYcw15hV89+e7hYFFVwegnP0R+qjj5/kpIdYrGLGnG83NUMQgSTxwi7CyEV
 zbdBBA7qjHCFkgvRqq7ZF937OpHrkeqHh9EzECtYgOL11yPZpT4wV/wyoaiwCDxfE6vX2uvo=
X-Gm-Gg: AYBFou32EKS1aMFHlvTIFaXsL9eGuyQQcUUDx3saUFytIL83Nmi3wvBDN9suy2yt6mf
 fwDO66yoEe9dpl5UPbgSXie9IRxeVmw0uzGRqRar71tUcCyKcUEsbCwPfShz/EHQ/3JEjZvT/0g
 +698mYu+EcpWa4fap35QTnX+xB+ruz+5B5lKeFDxC9hfAP2McbiZ1Wq573wG9ITC7PdstlZtTGw
 zh249FCk0bO5xrLq+UMBRDbF5lL3zxGEuVU41D3bdeqinow3z34nyTU5CDW01xIo6NkmlLE7RC8
 l2N4YqGAV1zfzUv68dTKjc2RuZ41nm/lrf7WnAQ7+hbj2tfmMWqzcQmoSiGlVdwNwvLBuSCZyhU
 yAxkqo1Zvvvsm18VtIfJip8rrE5kbxjTQ3qtwnYM5t+bm+EQ=
X-Received: by 2002:a05:7301:4694:b0:351:694d:9ca1 with SMTP id
 5a478bee46e88-3537b3c7ed1mr16704511eec.27.1791869583814; 
 Mon, 12 Oct 2026 22:33:03 -0700 (PDT)
X-Received: by 2002:a05:7301:4694:b0:351:694d:9ca1 with SMTP id
 5a478bee46e88-3537b3c7ed1mr16704458eec.27.1791869583069; 
 Mon, 12 Oct 2026 22:33:03 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:02 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 06/13] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Mon, 12 Oct 2026 22:32:37 -0700
Message-Id: <20261013053244.2954876-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 45jlhEitMCmWxBHAwxAXDpJZZxfrHUW5
X-Proofpoint-ORIG-GUID: 45jlhEitMCmWxBHAwxAXDpJZZxfrHUW5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXw9Gs+Vun0NDG
 vV04h769J1w972axuxLo1qc1aoADhQlCN9EWSgMONI2UjAUQlhfoEGzwbkHTYfu6Gnp0he6FEV7
 Q1r7ODBC80BVdiw9/5IaUhYJqkmG/nU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX0nKAI3QhFXZ4
 MMrE95YP7h1vr2fJ3MoaLYiK/X8/7R8pwYzwmKXkHo1KK4PoUbsv54Brq1td89VnR9wI1CVz5Yb
 KReupvuanaJGaji5ncT+Yv0SRaObshuGK7Zcw8hmcerYAD0EckjgIqOeQVvYUWYeLeFkSXNHdrc
 Hs0USTSehw6NOvDzHKN2HE/KSiAwD/DxWfnXoZy/aAYDOiujU0PIiLDNKN/DUV0L/3GqggWseKl
 cCLaV25DafbAdd6cw7/DOkbE0wzp5mOUsz2tKjTZpr09A8rqkNrAPsFdLCkJLTPymb0iIBx/bL2
 C/XDbqNUYw3vrkZW2QM+1obZCnN4LQvynZjhJwRBmI2uXYKhx60J9o/KbrAOV5dgdiRoT6q+xD4
 ilQx5nw9Woua3JICg8ydhGaVzK/i0fNe/IzlUK2ZMUxhIqoA4RxnKIkIrg+WQXV9S15Ha7A43sW
 FxPD1/feryifrWx513Q==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6acdc290 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130021
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 2c3c5c9b4d8..94501b838fc 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

