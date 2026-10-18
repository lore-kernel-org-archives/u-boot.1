Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB887CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A32260688;
	Sun, 18 Oct 2026 20:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vnPqCNKWQ5nS; Sun, 18 Oct 2026 20:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 101706061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356672;
	b=AwIEtTnsgl4twQs97koZCCyV/MHDwbnbcAlYGrDm9mY56pmnuT3cLrITall3Bg59UaAs
	 fIfknUUWqeMJxl5ctFhmK1AgrCpx2oEUZ26b8+3EXdPxCe0aOuNAFEYp9Rf1w/gJuW0KT
	 zf/p0jG539Od5czP7n9L0rKywFXMYQqswcgHRafAygUjfdxuxYO55U9R6lyIIsLV6OV7G
	 MqrM0KNaKfZZb+OGV3ObFcoGGas/PsDCllZPw683XliDl2gYjnGUihFUiLPRciGPLfxmX
	 OQVIl11tjAIKDotZuKO0PuLE96yp7yXUpK2bwHxxlxAiCoMnxxr/U6ei9Q1iyltIuDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOBWTOozkvE=;
	b=mMVWemQCi8SQ3bWCQ77XAMn4+A+kQD8k0bDJBuSa4C6dMFXAq6vaf959HCi5i1o+l3Jd
	 dd7/OI/cEbkf01dNGmYNiI9e4BnzLLtyyU50N0Oyg9tfYG3rdGEwhycG5jMYyjL9zaoZH
	 4mmd/VfDiqiDgOEUVNfYbyy5rpYIk9x+R0nTH04KnsybvWUb77XwXnU/OvQk0Pr1S/R6K
	 VsbzfGDuzqx+9mpb267kkHTnvjwiqbYi/z5v/zAFpgRs/2gs/TclB6Eq8ZrDN5VHNgLHS
	 eCCgt0H9/KOuLjPeMM/2mJ/qVR4WDN0UbYVSY4iD9JZrYQCKopO5A4Usrt7tCQeUtrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356672;
	bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOBWTOozkvE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0SlfBNzQus3jUfCoKGGY12kpeCvAGdZaVgR+AZGcQeoybRxflXWXato5I8hVSPftG
	 /8rQZR9Qs1Y7xV8mtX/GHUdmSdy/jm/VOmGb+W9lSxBgWyRVvDdWB/tONzjazB8xNE
	 xYIG+WbzwJeWuBjdDEp1qAOLkMY80CZ486H/YuE4beOOeUSPnukl8ZPMVnQwAPtOa4
	 CfTIcYf0AREP296g26mtjwaPGA3pVrArUENwhKN/lbeQDS+VR+Yj4pPYzwsma1AXUB
	 wxpLvsXql0L9y8sAS7Bb2yFI1bAgrJVNvbzGnOwL8yCSrNeSqKzfWZb3D4odQaUKkg
	 q82UPld3XYw1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 101706061D;
	Sun, 18 Oct 2026 20:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD7CE1AB
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94206406CC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSEl-Fq2sw02 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F20A34060C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356669;
 b=HWYN0gfuJ38eh2eMYbBzO2wRcF78mwHYzKK5cWiTLzUDkl9XcpveW1+97k76xLkkGFXn
 U02OPHWAhULAjx45X1wzGeXJAwIwW7YioUr16uhT1c+2qoF0bjXELRUk1uKjIcPrydCVS
 nf/MVuy2yRVASHdaeBpZqkyax2UhbPdEju2WtV8lvRKHjWPVwY9EQLuxLXf5AeZa7gpcv
 +io0M/LApAPgWmd1XMiKEhDSeCt1f7Toc5KxFN/MuBG8AmB7qjGDQFQKk9pqZhsYL4dvc
 VcoBAU8ck7JwyPHda5OZqoLdMVD1BCcm+smZJb+Llz6BJMz2fJo5xSccWAvMl+WqgMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356669;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOBWTOozkvE=;
 b=CvNdQJxoGfLSKT3TZR/vREem0n+UWlguvScwBg0jsOZKy7yKmDU9FuXMslWtzOJxKXs/
 Gw/iaIvLVBCjtUrG0IJqwYMDQTJKc305tU4knbt4TqY3suLI3wftcwblCakJUHF0cm8Ee
 GPaIHFpSzwxSF8kHiOoiy3UcO6b7QQ2mC9mKAvNDgQobOgHkcmIfL/nu3LFLy7c0/SZPd
 yQMgcfVR6rYDYpep+tBuOoDrPdOqza66IaEuJHloMozdM+jKKbjHkQpx1lA/YpICRiw+Q
 SuldVn4OWBaBkmmnKSakyNQ0PnSEwBzRrhSHHZjEqs6jHj0m+4kppyfWfMFXwT4cKAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Kpsq2Ker; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MoMuhAxW; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Kpsq2Ker; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MoMuhAxW
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F20A34060C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:08 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKB2gm3380592
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOB
 WTOozkvE=; b=Kpsq2KerJNcaZn3jRvU8fAyx9nqRav8Gk1/KIT2bvzy4nMZ/P5j
 JJL1gUHCvEZPQxIOGm8H764/FbeDsjjL2sNrA8ePj/LXDI3UUef2Ym9WWCN4hIDt
 YPpBdpxkdd4bdnbtl8crLwA3G5KQixq5pXhH0J3i2KOCrDlJ715Dkvw9iZpVlOgt
 9erRO8bJA877Ch139MIat7F6GRw0qLgVsVgOzJq1R2dKUxaziI+yHfyd3abBz/IX
 mt55urh7caLx1kfRI9V2SrxGRlhj+x+naCn5yDcezTpkewQpXsTYUgZjrEPIvaB2
 c9bQ7LOo+CfgUyYpRo8Bz3EJEv/zQTT2yDQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k3rh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91430af782dso52435476d6.2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356666; x=1792961466;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOBWTOozkvE=;
 b=MoMuhAxWENhFlHlVQ70Yxw0+sBe6oUpiMMKzQLwXQmoajB3b6oT9don60Vfsg9KBC6
 Ypz74JtFqX5uI+pixASyR50YK565bL4BgXva7nTJobsMcUdi7FVwFiEPqmfI0FB258I+
 l6Ifo1JkUK4goxi0jDMiUv5qen7q5JJR6Mi1XjcU0GmHcRSa8SoBpOZMxHizJIY9IZfp
 nBgmoewM0iBwljsQFvMwxRwxlAwinqo9qzYN+/yqXqzB6iVHndunr5YqdLPge6DxlwcT
 oeoMP7hn4NNi/Zf2nUtLXWBkXGhAGp5QpwedTQEW36+Ci9y16Av3sBU8iebkksM+cHtw
 rkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356666; x=1792961466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q4lztsAg2mcPGgRXTap5BjIHeMBMk1h0aOBWTOozkvE=;
 b=XYp6PsgbcVuAlThdu0CGzMcMWjPtV+k6/KpyyX9nyeB14xPLHrBp0YgcNmslaBfJxP
 pHldj0wNKp0fqBoBLoJqGQ8U/kg257KgMrQMtYdxXNF6QjO5BykHbketMzjRzfbJtoqa
 i37QmJgr0aXWraqRQfj9iBHXAFOWcah8IcBU6tmKhxVfeCvil9nHfgj1y8924Lh866mq
 08zmKv6h+PI8tlpMSnh1CtjvCXdvbpFOifCspv8Dhb+00HNHe71UWJjK22jOTy2RGeCL
 4gk7eOmmSSr2anTsy8f7f9fBUHvxXXnx4igPW6UxugfLWB8QfqRLHjV+F8nR7ZcDnoaz
 O4vg==
X-Forwarded-Encrypted: i=1;
 AKwUvByy0HIao1Aua7JpoZX18ewBOaKHnbDXa2p4c1cDCxMHFHXz+jvozvk1LU67k/LaP6u1n/b0o4I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJLbTSiAvmYrwfPCvuS4dqad5XlM5NGn9esumSrOFKSAhWo59T3
 tH3PFzoMMcWnsVy7q9OrrnDLfFekJyU4g+Vb6dlxJuWQE794soYZ8inSFTZvCcQjzd7tL2B09Gb
 Ivg+nKWftcDZMM186Yg0Uqk/C233TkBL5LJsoRHPKke0kEHyBchfdAchhYE0gUsahj0+KwPho80
 xQ7js=
X-Gm-Gg: AYBFou3mVDtrH+abVFf4clKY32VTaDjTS/JhWfRY7Lc6AeRb1sqx7ss1ETjwUkNuIpf
 YVwy+A7SBgMQChR1XVNKeWGq2+NpgAB91rCiIGo6rCnYocnnL3UZYt9n8warZCnMy8DhbWblwqb
 Ufh7Nqqm4am+z5t9yhJ+pJ86HlCDqNka8KqlCP62lojdTrrqS6s1hKVEdf0HxssOkA59DSKjCJO
 aqfwxThfdGseJcIiwQ3PwueSlrcVeREl/HbDSAUUOncK3+Z2ZPsCv2KhaIqavhAn3JYTZ9uktRa
 FxU4dVYALuJFXdrL8AieUyWBmUxciMQBMyorA1VNVWZq+oQa+svLUj1NFjnrazmPcwS3A/nA0GA
 1zP0m2rClc5JXMpK/T0Cql0YmL4OxyivGLBChRL93zG1L
X-Received: by 2002:a05:622a:956:10b0:533:31b5:bec5 with SMTP id
 d75a77b69052e-53645e6aa92mr58315211cf.17.1792356666279; 
 Sun, 18 Oct 2026 13:51:06 -0700 (PDT)
X-Received: by 2002:a05:622a:956:10b0:533:31b5:bec5 with SMTP id
 d75a77b69052e-53645e6aa92mr58315011cf.17.1792356665756; 
 Sun, 18 Oct 2026 13:51:05 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:04 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over UFS
Date: Sun, 18 Oct 2026 22:50:50 +0200
Message-ID: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX8eEJhiNMYeVO
 7TO0yTNju2kBL6iJIR1C1HZkoTH8EYejRAT3LkqI6im2Cfw3IjKviaPa3GBo5F9QqssXOC4OSq9
 HAy7O6ce/Ylas9+eFxpphWvztH8pi7LXChGRO9qf7BGQw6bzhKNVnj45bM1MUjWNCLljngOEhqB
 tcoqlIRTYLVfghcGTbglEuTw1LleyTF52/bvQbMab3EfxTPJWwtnYDCw2bcKpMls1IbFdx3R16X
 b8VCb5msCK2aWw6OyGrzIGCybDbP44UR2BP5lUaKc8+NCzaxJSaD2PNwciwTaazYG+idrH/Q4Lu
 QXRGHZP+gibRL+jAawk+2/lEE1Qi8GHuyuhd2+90Jgcn+c/CuZazit6F3Znb4bJeejZIqN5P2pm
 tOX463Uw2EBx+B/WXev9U4eNgkRtXUbyzERrxb4TcpPcxowoB+U6s2bPPdzT10sSSFp8rd/9+Kl
 N8XTztcaVp+G6tVZWmg==
X-Proofpoint-GUID: Q-mYxpLBrXd5oL_tULZw4gNeS9Wu6gWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfXy3zpaBBD3y/y
 JNt1ddmW81Sqj5yVyH21hgldGwoGAqHB6BkcmjHL/tvbX6k4CNhEMi9zIRls/7KPse+K8iC8+GV
 a5XAPZbncMs1EhJdO8LShhS9PhUxN1E=
X-Proofpoint-ORIG-GUID: Q-mYxpLBrXd5oL_tULZw4gNeS9Wu6gWJ
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5313b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=BFbeOP-xGShA_2JvaIUA:9 a=O8hF6Hzn-FEA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180083
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

OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
interface, which is bound to eMMC. SoCs that are UFS-only and have no
eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
secure storage from U-Boot today. This series adds that support.

It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
(PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
the RPMB device and reports its kind, size and CID, then carries the
signed frames. The legacy eMMC supplicant is preserved unchanged, only
renamed to rpmb_emmc.c, with the new UFS backend added as a separate
rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
single RPMB transport. The subsystem interface is UFS-only for now; eMMC
can be migrated onto it later as the legacy path is retired.

On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
device-id string the Linux kernel builds (ufshcd_create_device_id()
plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
the one Linux would use.

The first patch is a standalone UFS descriptor fix the RPMB path depends
on (UTF-16BE string decoding). A small preparatory patch surfaces the
RESPONSE UPIU sense data from ufs_scsi_exec() so the transport can retry
only on a power-on UNIT ATTENTION; the transport patch also bounces
unaligned frames through a DMA-aligned buffer for the RPMB WLUN.

Note: reading UFS descriptors reliably also requires the descriptor
data-segment cache-invalidation fix, which has already been posted and
merged separately, so this series is based on top of it.

Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
programs the RPMB key through U-Boot and reads/writes secure-storage
objects, with the derived CID matching the Linux UFS device_id ABI.

On the CID derivation (patch 4/6): the BLAKE2b / 16-byte scheme is kept
as-is because it mirrors mainline Linux's ufshcd_create_device_id() and
OP-TEE's HUK-based key derivation (an OP-TEE ABI, not a GP/JEDEC spec).
Per the v5 list discussion, this does not preclude vendor-specific CID
backends: they can be added on top later via Kconfig or weak per-platform
hooks without changing this series.

Dependencies:
Linux kernel (merged):
 https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
OP-TEE (merged):
 https://github.com/OP-TEE/optee_os/pull/7881
 https://github.com/OP-TEE/optee_os/pull/8007

v6:
 - Rebased onto current master (was v2026.10-rc4-479); resolved the
   optee_private.h overlap with the new OP-TEE service-enumeration code
   (PTA_CMD_GET_DEVICES_RPMB).
 - ufs: RPMB transport (3/6): retry the SECURITY PROTOCOL only on a
   power-on/reset UNIT ATTENTION (ASC 29h, any ASCQ) instead of on any
   UNIT ATTENTION sense key, so transient conditions such as 2Ah MODE
   PARAMETERS CHANGED are no longer retried. Matches the Linux UFS RPMB
   WLUN retry (commit a8a34238e5e6). Reported-by Stanley Jhu.
 - optee: RPMB subsystem (6/6): drop the duplicate OPTEE_RPC_SHM_TYPE_APPL
   define and use the existing OPTEE_MSG_RPC_SHM_TYPE_APPL from
   optee_msg.h (the PROBE_RESET/PROBE_NEXT/FRAMES command IDs and
   OPTEE_RPC_RPMB_UFS are new and kept). Per Ilias.
 - Collected tags: Acked-by Neil Armstrong (1, 2), Reviewed-by Ilias
   Apalodimas (5), Acked-by Ilias Apalodimas (6).

v5:
 - ufs: decode string descriptors: added a Fixes: tag; the EFI
   file_open() callers now pass UTF16_LITTLE_ENDIAN (UEFI CHAR16 / FAT
   paths are little-endian by origin) instead of UTF16_HOST_ENDIAN.
   UTF16_HOST_ENDIAN is kept in the enum to mirror the kernel's
   utf16s_to_utf8s().
 - ufs: new patch "surface sense data from ufs_scsi_exec()": copy the
   RESPONSE UPIU sense data into the SCSI command so callers can read the
   sense key. No current caller inspects it, so behaviour is unchanged.
 - ufs: RPMB transport: retry the SECURITY PROTOCOL only on a UNIT
   ATTENTION sense key (using the surfaced sense data) rather than on any
   error; build the status frame with put_unaligned_be16(); move
   GEOMETRY_DESC_RPMB_RW_SIZE to the per-region CID patch that first uses
   it.
 - Series is now 6 patches (was 5).

v4:
 - ufs: decode string descriptors: dropped the in-place
   ufshcd_str_desc_to_cpu() byte-swap helper; instead added an endian
   argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and decode
   with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s().
   Existing EFI callers pass UTF16_HOST_ENDIAN.
 - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
   put_unaligned_be16()/put_unaligned_be32(); drop the
   rpmb_frame_request() helper in favour of get_unaligned_be16(); move
   ufs_rpmb_read_geometry() to the patch that first uses it so it is not
   an unused static function during git bisect.
 - ufs: per-region CID/size: reject an out-of-range device-reported
   logical block size before shifting and split the size computation into
   separate statements for readability; order <u-boot/...> after
   <linux/...>; note that the serial hex encoding matches the kernel
   device-id ABI.

v3:
 - Renamed the legacy eMMC supplicant to rpmb_emmc.c (was rpmb_legacy.c)
   and kept it as a pure 100% rename: the UFS RPMB subsystem backend now
   lives in its own rpmb_ufs.c instead of being folded into rpmb.c, so
   the eMMC path is left byte-for-byte unchanged.
 - Added CONFIG_UFS_RPMB_CONTROLLER to select the RPMB-owning UFS
   controller on boards with more than one UFS controller.
 - Reworked the commit messages to lead with the motivation rather than
   the implementation detail.

v2:
 - Squashed the standalone "retry SECURITY PROTOCOL on power-on UNIT
   ATTENTION" and "bounce unaligned frames through a DMA-aligned buffer"
   patches into the UFS RPMB transport patch; the series is now 5 patches.
 - Reused the existing ufshcd_read_desc_param() (now exported) for all
   descriptor reads instead of adding a new ufshcd_read_descriptor()
   wrapper.
 - Moved the SECURITY PROTOCOL IN/OUT opcodes to the generic SCSI header
   as SCSI_SECURITY_PROTOCOL_IN/OUT instead of private UFS defines.
 - Factored the UTF-16BE string-descriptor byte-swap into a
   ufshcd_str_desc_to_cpu() helper.
 - Dropped the ufs_rpmb_get_scsi_dev() wrapper; callers now use
   uclass_get_device(UCLASS_SCSI, ...) directly.

Jorge Ramirez-Ortiz (6):
  ufs: decode string descriptors as UTF-16 big-endian
  ufs: surface sense data from ufs_scsi_exec()
  ufs: add RPMB transport over SCSI SECURITY PROTOCOL
  ufs: derive the per-region RPMB CID and size for OP-TEE
  optee: rename rpmb.c to rpmb_emmc.c
  optee: implement the RPMB subsystem interface for UFS

 drivers/tee/optee/Makefile                |   3 +-
 drivers/tee/optee/optee_msg_supplicant.h  |   6 +
 drivers/tee/optee/optee_private.h         |  41 +++
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} |   0
 drivers/tee/optee/rpmb_ufs.c              | 141 +++++++++
 drivers/tee/optee/supplicant.c            |   9 +
 drivers/ufs/Kconfig                       |  21 ++
 drivers/ufs/Makefile                      |   1 +
 drivers/ufs/ufs-rpmb.c                    | 367 ++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c                  |  38 ++-
 drivers/ufs/ufs.h                         |   7 +
 include/charset.h                         |  17 +-
 include/scsi.h                            |   2 +
 include/ufs.h                             |  10 +
 lib/charset.c                             |  15 +-
 lib/efi_loader/efi_file.c                 |   4 +-
 16 files changed, 670 insertions(+), 12 deletions(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c
 create mode 100644 drivers/ufs/ufs-rpmb.c


base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
-- 
2.54.0

