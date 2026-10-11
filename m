Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84140CA9ECE
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42B49606EF;
	Sun, 11 Oct 2026 14:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yAMNDKDZJit; Sun, 11 Oct 2026 14:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 851B060639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729579;
	b=lVazFh44ormjZsMJNUsgL+Q5HpE7XezvvqGrXS9Nnwo0Y3u4eCWZoreb2leQOgkxv8dB
	 KzVv2CsQLHnIkos8GuyCaLW8/xmKdtkH3Udxmv7rINqGXhuAp6uIM1MZ+Th/o8NbRCrPd
	 ouVvbCyU0ZKQHd6OCaPFiGKzc2wnbUAb1bJsygjk3yxJN5py9RfkpVheq3PoCovhJu2Ix
	 Az2zTokBMgQbqutGHIuxQHDzHLV6+AlEct4zUhxszvK7Hiiw+I1MJ3KI6xzuhdc9UcTsH
	 u+FetCuMrG+XE9bsbrn+TulLRyWm6c4N5VCvI5FKQ95OLQ8FMeRH/qx+zCvtHsVYHqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EoNjbpq8rnGnK9FW0n3K76Xz6NMwBWJ1lSYKrNiGVPo=;
	b=LxXyAlfkHpKzHqm1HPtejybEvkw9s4FiLW9/iAJs6Zbw5zzSFHZKL9eH+K2BT8I4UsOA
	 /4Myv6RqYs2gX2XRXn66ctmL8kGGVSWme3AhF0C9lfycWu6nLT9vdBbVIqpIm5yAFNWK3
	 dy4SlZT0/C+tRBxPyP0SWjNnf7obc3amfISLt3EGilY5sdK005N9We0O3Oq3pAoBJswy6
	 Laovj1DRk10Eoj7pdq+aHKQaCbmhfJuj0Lz2QAkVulM1xio8CWQ/0/7pkNqImyEfyVGfa
	 qRbWrCCn2UAKphZKAcdMjeOBBrcXbmlQrw2LDdNwUBEA+bTChAM7r9hih7/LRUE+BUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729579;
	bh=EoNjbpq8rnGnK9FW0n3K76Xz6NMwBWJ1lSYKrNiGVPo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KOWJcWHGi/gRX7c5hrCAULkyYWmP65DkhuVDAXjd++LgRtVGSKIMbPNS6Kt7D5uqP
	 Pz70GG1jy0tjEqkXvqqA3cJd09AM2RjvDfwC7zpF5YiZE5zlkokDYaVUmvwwyQk2uf
	 LD9Ltxc0yf8FClb/6KJx6+q8VlDdSDh7wuWOzpK0w2egY0cy8s8BjVFKnMAkrLgWdG
	 03leD6/r2RuCI8z3wa5wJhd6ekMmvQnvgFvXcFjNlGBaA8wCDzMeFndVyTaPYHJjNl
	 ybIiwoxSps7DIcf41yQ54Io4lTBW02j75Lp3TZibcogISVVZ2cupK5IdxQUsrNeUjo
	 1F8XnapSkI1Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 851B060639;
	Sun, 11 Oct 2026 14:39:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D9C02E0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5428C4008B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjgH8NFGcPgU for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 920C14002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724234;
 b=ouJl5xgzqLwCvvjG/WJ8vYJ4EZDeW7okkH+pTWmeM89sEGQwLMKRsO8ApyAJzac21kj7
 r4Vt5/rhyz2A010ynIOVuBqOphi4Mg5GaolWb3aUxhw42CHGfIAhRwTjBWFVxOtpP9nNC
 sgE2vjEUuYHxslVkjQZ0SseuqZW4tJZy54xnreCXDfYXrYT7gxvnv3bv3OHxCUwLI5kis
 ktg0XC99xVEhxRcEPtLKqjo5SN5LFygrp4YtxLN08NR6nuTs6I/wfZYCO5G9ovBFyc/kd
 rOLb1nrhzQEeI7ru9njBEWbL3gbIQRJeD3t31PSb6CVUussSC1aRzmCWslr5xplMuQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724234;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=EoNjbpq8rnGnK9FW0n3K76Xz6NMwBWJ1lSYKrNiGVPo=;
 b=PulPekPXqdgrNvhxwlx4CPPl6vQ/iBQQrIM4TGGpzcyW40Y9aKYmiuQsdmUNUQqEIn1R
 JIxRQwAh+nZJkMGnoj2+2LezVgLq3uvJ/HDvBjQbR0TgGzY/TuK8Nsksleb/Y0r0vFBx8
 RX63eStWOg/judHIkPu0xaaVB24sUXydCMGKRCWb6sZmoJxU9LvQ9klEAFvebbljOeYet
 LehSrBKT4iHaGXGwQMj6oLcW/qbX6gnv9YiZuAqKvkoMT7I1cJDNYl9xZbkyXzbIELHox
 thE640r1FaNKEQHcWsUCA3pxcjaoSU2mrAyfsz/6svJQ5PoZncm97OSL+xvJOyh5fTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BNf0HMx5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ojwv+LO8; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BNf0HMx5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ojwv+LO8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 920C14002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:10:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85DQS3491328
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EoNjbpq8rnGnK9FW0n3K76
 Xz6NMwBWJ1lSYKrNiGVPo=; b=BNf0HMx5QhFz1ZHY2YbMy7M83qSo0b7VFTP0f0
 0+ZsTisZkEsPtJER3ZAuqLZUREV1mtQaX3qaV0C2GA2A9rY4grGEAaO46n504zQE
 WYP4f4eiCJWWtYkRtkh55cCuthoGt+NGUP+vUtpSwA6NIIvxInB2HcCPXBN8SdVL
 hdH5gzUEa7sola/fUbMtHbl4VmfKvfivVavA/OdEHyuABFTOWOHh5TIgACTvz84a
 QiDqXxF7qG9uKlB7lDmzqWM53+FvjQXd4a89bsw9IyUUWx0/cnzKuzBHlpJJHKRR
 TbkTLmFJJWvd2q5wiL/XVyIcJuP0G5vUBYiPZi7YyMW/wxPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxk5wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:10:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc359d9easo199198985a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791724232; x=1792329032;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EoNjbpq8rnGnK9FW0n3K76Xz6NMwBWJ1lSYKrNiGVPo=;
 b=Ojwv+LO8hJeMakOzRxJvcvJgHBxfb7TcOJzL8YnaIZx5YoxII9/euPtX/EknsHf8sl
 6GoF7UlH5gv7h+tvCXMAv2qePW40FvEdA56/pc9MddIzcvAELhhU6FQMJpTTVAKYStUB
 1EW5NsmYiBfj7m3uUShEbUfmMth3/u5iyyavchAtONPutbb4FpDI6nWJil2CtUMpbBrz
 /aQRwv6Xa6IXXi32pGZ2cf9db0O3yV91kbQshgzkM5l7zHIiAIe3lY7xgWXCzmRhRIrA
 4ZzbWx2oE88UrLEmZvrH45YdFa97kb92a1Rv8Xx+JziTK4M0XqM1OwWfIcnYrgnlppB5
 40/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791724232; x=1792329032;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EoNjbpq8rnGnK9FW0n3K76Xz6NMwBWJ1lSYKrNiGVPo=;
 b=gZFgjgTORUedHduCF6DiB/njDXR8qWr05+ryArlHc917GU1GFT6+6CGTmG+uf8ARko
 j7emcIDcByBQN5rWs/TQEW96w0NiCMcDzWr7Nc+GrtKyxcSJ1prKM/8iWzZm0uEzffLJ
 OepXhTqUYYPTinasfHPl3Qn3/oUKbBUMZbQqpj0i9mDgvyt8UU+mOxJUm5NpRwZjHI3O
 TmXkvyz/ks06zqPdL1Oik2VG/INgw60QlhX52lOYhOmI8v28SMCxIBh95cmesUj8+rIW
 DCBZ9HPbE/KmDhvX8531q4WOGYJsdeosGbCaXIV8rHriZDMClbFrImkrx97JVqClFPwJ
 YH4w==
X-Gm-Message-State: AFq9FYKqnmEPUQgfIGsB6CExYPRcW+KBfTXGhfslvUAFqwed9o5i0p7l
 tP98XgZZSymHyT4Cfvx4iev9WoEF0GMkERr4tZDKgOV6CwSa1GSlxDmMxBwP0fKgXEAPX1ZRx02
 v3AOs+7HWVcH6BNl+ma5noBm+XJ4KZR9d9fuOKMixuxQAkoHdnUbWpiA7L8HFTqkM9eA4MONfUf
 4mVM9Thw==
X-Gm-Gg: AYBFou0N3qjSHiexVejzBq1hhxWut40WfgOdrWDFEI+qJ6ZOKKO8pXqOqkoUBa70cRC
 GxgMrRTyFcp9Kunap5fTqk+cp4yDifKLidzdaNOR/eeJXiTDR03W361I9pkI75Pn+C34MAecWxE
 rijrFIb/0gYlwtvZQp1RTg0Cx4mDPd4BTLGmyI09/vTxSV/imYXnK5KVQufm4mwOer9j9fS90Dl
 TS38MS7ftGFOX6R58U0aY8uvioXGntSGrweUQkvWtJGezK26W2ZPz277GaUJwhYrDJUk9OXlOob
 KRBkun0luFM1StxKEwz8BTzpOTUvi49ih3P997lARtA8PqOpYVaO09by1gXqrCPZWfQHm7fP01t
 haoyddw49YNM4kSNp3ronm5v4/nLMhhVg6rUGpiyv21fm
X-Received: by 2002:a05:620a:46a9:b0:93e:746e:235c with SMTP id
 af79cd13be357-93ebd1dc75dmr1162416785a.15.1791724232338; 
 Sun, 11 Oct 2026 06:10:32 -0700 (PDT)
X-Received: by 2002:a05:620a:46a9:b0:93e:746e:235c with SMTP id
 af79cd13be357-93ebd1dc75dmr1162411885a.15.1791724231886; 
 Sun, 11 Oct 2026 06:10:31 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a74c48sm360312866b.43.2026.10.11.06.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:10:31 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 15:10:26 +0200
Subject: [PATCH] bootm: set os.arch for Android boot images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-bootm_android_b4-v1-1-3e82462ac206@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wqDMBAFf0X2uaEmRKH9lVIkl23dgolkowTEf
 2/SPs7hzBzAmAgZ7t0BCXdiiqGCvHTgZhPeKMhXBtWrUfZSim3lnNAswsaYl8kEnyL5yWqh8aa
 9M4Ma7QDVXxO+qPzaj+efebMfdLkF28MaRmGTCW5uk8dQrgFLhvP8Ajj2f3OZAAAA
X-Change-ID: 20261011-upstream-bootm_android_b4-4e94dca526b5
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: uJukyO1GmKDhGJNPv7kRd5asH9q9pFa3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX7PMWAKYLZDQP
 pjfBgYS860cCFW7gLDULnC6GXEWgezFXdYNqyzFj7acwEIf9pAVIQQozaO8Ikl86vsEj8c8FcMJ
 awICZfU8bQCVbEkFOthJHnTa2cu0z8M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX2f0qK/ythspL
 bl+PJetLA3Jl6fD+4QKOPWSwBMcUV54K+mccrMI/zol+OL3bOqXeJJrwifA4Dk8zxt1mmZcCs5d
 YiRTcQD2gEsj6765LD352c6s1gULYZ1npmPaJqkJ+BrUn5KzmgOk2xRPYkCxtFF8YiThawJj2zC
 GVZs9hFDRNo58wEk8/JdfzePCiE7iW/zaGWJ2vTYXHs1Mxb67QDlbasO+mqfPhXi0HXc5bllUmc
 dG72DPz3480GFxRtnZu2JGmyxgEZAk2CaOGiNTxg/YccebHDcjhFH0CH6WIVc1iiAWe9W84WMGA
 r1JcXGpzcKpzCfRjwAXby8xFWMbpvTTtRkGPegl/0zJXD/8IsBlRzupuz1itSnCe6d9NjxTSFbp
 aZ341DfwOxSfwX1zmfBrtiV8q3vkvq1APVLnhGcNbvh5BLFq3CHS7Em1BVs7s6Lj/j6pBTGJ6qw
 HHgq9G4VMSddBbUy2OA==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acb8ac9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=w5FTZlosNbwMT6eLVQAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: uJukyO1GmKDhGJNPv7kRd5asH9q9pFa3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110052
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android boot
images, so the arm64 Image relocation in bootm_load_os() (booti_setup()) is
skipped. An uncompressed kernel from a v3/v4 boot image is then executed in
place at boot.img + page size, which is not 2 MiB aligned. The kernel
reports "Kernel image misaligned at boot, please fix your bootloader!" and
dies early (observed as a stack overflow in start_kernel() with a GKI 6.12
kernel on QEMU virt).

Mark the kernel with the default architecture, like the legacy and FIT
paths effectively do, so booti_setup() moves it to a properly aligned
address.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index b6ae0163b27..75b34f39cca 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -432,6 +432,7 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		images.os.type = IH_TYPE_KERNEL;
 		images.os.comp = android_image_get_kcomp(boot_img, vendor_boot_img);
 		images.os.os = IH_OS_LINUX;
+		images.os.arch = IH_ARCH_DEFAULT;
 		images.os.end = android_image_get_end(boot_img, vendor_boot_img);
 		images.os.load = android_image_get_kload(boot_img, vendor_boot_img);
 		images.ep = images.os.load;

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-bootm_android_b4-4e94dca526b5

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

