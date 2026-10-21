Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B0606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jqs4fknV;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BL/ajBLH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKYhSIg3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51E1060852;
	Wed, 21 Oct 2026 15:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1q1RHhVkvber; Wed, 21 Oct 2026 15:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C69860846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598280;
	b=Stw2GSzsOtGBU5oCUVaXivpI7Fz7G1ufJPp3JWXwkYzzu4Ye3nwHFIQV98+BGfKzsJxN
	 a4pv7blMspHNkP+qnpMm4yVBgA/3IH9ytxwQmEB+6Z27sEyv/RfcH7UeTInZJ3hJJ20dh
	 x8yn+0peqo00U8YtCz4sXqsDUokUDtXenrle4leFtY6RxZUH0KE9Ig9WtWqr7sn4mNKoQ
	 hzS6wKubISk0UloD6ATfbFk4I8h5JGe7OgbzOx56FxlPvwG5jD9bEQxJOQQtW/MfBbBLv
	 TzVaAtxAPC86hpUxbSMohXHBllPdSl9Uu1sxe1/EN6rNA/UlYtfhC6m2kRB8SsSfpjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=;
	b=cXt0Fhxjx5xm71cpkb5kOh+ONzh50MHUi5tYYCFDLZKrSR1mA9Itv8o5x3ZG8ng+XHfh
	 JjNGjqmUfnjtlXIayqIXd1TkY/AdKuuc8zyQzIwWBw89QLVVG3Q+ZQEEJFoZ4c65/VmkS
	 RZ19LxrSku4yVHyZ50MR1Qs2Qp8vR7p8tA7yCXB+Mujwb/AQKCqmnwE0dEOqYjUlKBGVz
	 BENsogxC8MXl7pvlmT3f8P91pFkpqAi9wRqzVYBHf6uzWjmw66kTIKM92BvcF2faGU+a3
	 bdJz3EHyOt1+FgEkCM7aevyG8eGhO2UgVYqalMjecWlgSYjBP0XvIUSAeSGRS2Mi1QQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598280;
	bh=yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jqs4fknVx6BLiISibQ6LREakRWE3oKj29ObCR3u/rMDxJhcfT8c6eThri+GjagoWE
	 kqbDznKJZTflqyuEb+tlaG7lH/1yCS/GS8jl3X1ztk/tetWL0nXqq9AxPPlF8/cJ8B
	 u5UuZY/rvknXLvUW1HDMvG5kf5QYe97XchQCtISWBKIym1UtQg243oLIVejfqQZsjH
	 PW47WHSNR/lsX2Y6WscNU0hja9TCOBiX811x011IKN4pf8E2zQFK4H2fRuxFR/yDJ5
	 18WsQ3NNYVHSxEj1xf212v3viOvzIEeZGOLNmtKB3mCB2LCD53a1sQfc6QnMtSXsBh
	 IFyiok6gM/fUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C69860846;
	Wed, 21 Oct 2026 15:58:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C93161E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF0C74039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJd5GMPk9l6l for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B428C40077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598279;
 b=KEasRyB/TnvdfVLxZ7zO5wDMY6zNgkLgOlF6HJyn5TNw9iZFV864in0qJS3VZOHJYwmp
 8ycHne1wByoVsIox30iMj8LG5pooTzNRIMNkq1G1fS/aJcM9Fj7PB6uDy75A3pENclj3l
 jGnwLVSv24W/0j/jtJs/tJ6U24xKm44CA0V+L4P9jEFzE2kRevDz+2cpzCr+N9UcVFD6O
 0sq2UpMQ8a56SCPxKl7l6wRBwB5Nb7I/JAxFTr7e28sQhNgzvUXfUOMiCnWaUNlnDb7Uv
 YMuBLVCOvLAGY+GYqAcdjZAtWMmKEdcrKecystche7VeRNcWsw++3GcUYel31iA9J2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598279;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=;
 b=ceQOgsArGajuj2HYanEp7l0klpoOctTS5sbkTUFkkMguyc7vLEYUvgQnQp86gx6+6W7V
 hIxgbKYk8m2dbh+wIO3nkhbxM2yyX8N1ctclH/39JS9B6zQg+OAivHyj5yryQZ3zkTW1/
 4Bh1GGCHOnGrZt47lIUD4ScaWY919pR835EvELsorWdmNt8t1qFCfecYwI+o8QKTw7fNg
 eFh29M6F7DqHkb6kurSEszreivvYje6ParO7v/FEDDCT5VQaIxmsMjwGJcPuPzwU3rRkW
 UM0RPKCWKNkTThk23us+++EGC2wB9gNzBk8UENrMa1ZP41Fm1Lw5AYsRxm79pv0fd8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="BL/ajBLH"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DKYhSIg3; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BL/ajBLH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DKYhSIg3
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B428C40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU0mw991821
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=; b=BL/ajBLHkYqId147
 1Hya+Vi4pX6M4Hd8NiwXMavLgexX51awU/W0XobI68At6twJv7BgySj6zq/lgwG1
 jTDVyIOcEP2j/EnaV9NHZj55/l4cCzGOW+HggWdB3PM1ipn14TUW3wWtV71ogI1x
 IWUe0rzRb39Z9tDOzA2u+jrRx3+5IE6Js+6JRQQDvzzqEocaQdvMJFZZ/F+Eyuw9
 cF/1fF3FAfnZOO8tbAomESi9h+r/bWG/FzB2FZZnTcuA/PdLNDHEHyhxjytOzayu
 SLUS+cwptpRSLRoGG913u18AG6PI+B0Ye0qMHh9FoDqoXl/OLTk3ipAymuEmyWLz
 paYTEg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3vvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c3c370b17so1382262eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598274; x=1793203074;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=;
 b=DKYhSIg3f5ZuSDLE5Y+S3TauwChnVt+0OA/iC4V1ldgZes/+MATXBn86aigvN/m/iS
 OIXkwkXwqprhAiqP6NC9C9rJxY1wEvxVnYSaXVvEIiK3kB4jyyoE1kuLEydwSPQO+i+K
 prvgim1f/q6quhvYvgdubJGcbE/LqrznEVECFQF7BXf9kXzwY+fCOoWKUtXBYka656Ig
 R+zLF+Xmk/+gIi1LEKH52W5/EyeKAKNRKa0xoWXpj0rO/YoK4DECw6+NdFfvxa6XaKHU
 NlBiiQu4LiA2lT0r4ERoJKxvzSSyP87lsC+GIe0TuY6qsyHdeLdjq+TobdGsuiiZVh9h
 81/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598274; x=1793203074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yvSkResPuvV9bo95TQbYBiNwS4aRy9EfjIBrZIPTQdo=;
 b=smyIQmuP7w0PB9VUfZh7yEP1EgTWSjE4t1/SKz+JlJDt9RuDhFe9wx4p1FAqY/u/3J
 GGB95mkaumWWOPF7RpTjJGKvz9lg8s+ar0lAGfaGfcPp/2ZCl4tylUlG3xuljygz8Apu
 b21Bmg5JIeH0VdG7cLHlx9Yao35eSV5o2VrJfRUql/T5r4x0SBoOJUyI7aQgLj/0qwJo
 IM9iHC5cHt3GksuFVozftfqbNeaw74cHsO1ok/YZhzPy67Nrn2yNOdwP5xBdE+KBsYJa
 fJmy02Gu5YaFdCgQYTPdUgyjxuWbBQ7UmW0DnBw3ZcSqVCDfBDJcWWKfoTBBN6jrcoDP
 CbHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxielfzqnxD6+q0pn+AktrWhdJ1j5HgJur+z1dT2RDWo1Zx5JoNcXBtrAhUZFhb4wNRdDnfrQc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ4oYM61o+leOnfEfuc9a5Z9jhgiEv8PPGZQr3AkZiOqiApTigJ
 QYjm2PZ7HXS9RlY4w2e9Qa3u4P4+yQ1vSuJ8+984XLD5W7HIq4EMrpYNEY550pXOoBuq5mouipm
 QjNx7Y/pk5X0IO519iBTPxnjbCocInViXAZey5SYN9s+4stIKR2gKRFtO4tbxTdjcdYi9Mt8=
X-Gm-Gg: AYBFou32VFiLeV70jHza3d/nDlvnSby3yCCfn8L6XsSX0XwwahzgdjqY4YHs34FLuNN
 eCJAGddIpM46HbtA9WC2fYc4IgN6cbWWh5/juDMBr7RjJJPV6oHy6k0GpuyZ0gJtVFOw7exGW3W
 U2RsXNzfzrbFo5GXimN1zcbTJwXdYedODY+c3PHyPLQfGFMSIyaRPIgVRIGtaYplo56PZssUMDp
 pOT9IUnFHTevMcf7ksdiH7gw1WK2JWp68Yn9wAl6zaowsjZjitOwB2FCCVsM3abeUWsrjBWua6y
 HAAlxluw3vfR72gGZfkxOLh+qo38NBsQnda30KU1/IUYSFVovBHm+4ByAe79PiqRs5sGUMCrWzF
 5TifU/+NC2BGzqhyHym4pN61h8OtvxALUVVTnCRYDYljKGHaXdOJHFuElsecG/frN0VcIIV2Lg/
 Bd7kwz8QuGKx6Nk16aLN6U633R3/8=
X-Received: by 2002:a05:7022:1703:b0:185:4ad4:3d15 with SMTP id
 a92af1059eb24-190a109fdb6mr2712662c88.1.1792598274317; 
 Wed, 21 Oct 2026 08:57:54 -0700 (PDT)
X-Received: by 2002:a05:7022:1703:b0:185:4ad4:3d15 with SMTP id
 a92af1059eb24-190a109fdb6mr2712634c88.1.1792598273617; 
 Wed, 21 Oct 2026 08:57:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926035sm6521745c88.1.2026.10.21.08.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:57:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:27:20 +0530
Subject: [PATCH v2 2/2] board: qualcomm: drop preboot from the default
 environment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-qcom-env-drop-scsi-scan-v2-2-0880a06974c5@oss.qualcomm.com>
References: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
In-Reply-To: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792598262; l=829;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=GVa1Y7pHc1xshERDhXA4E7PELUds3+2K4ORF3C451Q0=;
 b=06IyWpZJZfPi84HHnT5cl3TwyH4wG3DhOVGEBbat1KIE8K9v9ogLEBzFdOebA3BOe1z6XO+uw
 WbvO4qsFcpuC9CBlQziI7WbSePq22COsGEDJcgaKVpnNsAI4BEDjO8c
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e104 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ORBxkv-RD4xgxDG41gQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Gojpe1CTt5DAncbJdWaJ0pQaSgWw-gNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX7BpMj9obY8XQ
 DB2n1APZrGT6JF2vXvilLy5pu7dEI8p00g/y3jqlNbfSmIvYMvY+fAljDufinizxJojVe0EywAK
 kYE7L8An/HCxSFaYXvF3WSfNE7hVny3XEqOGpx5YHtdAJxgzV2ybIyEDzBGT/mo3UOkA6ZlWfOg
 +fCIr/MxT13ZDJV4JG6xTlZlb7poDqCpTEoazHTh05MZwJe+bRHG2omGDhhhIdifJ5lNpnGUS7L
 zOv73N/5gobmXHxye/4SIqdR3IIBVa/N6OC1j7OVJyzMTZNEo8YYIPTa96ZSur/NpL2JF+0tuQc
 DgMlBS4wEHWK7NwSHdonzuvM1iYEmHfs7o8ltB7JntGMNzrmndah6piVWwiKuf032aFzVSm6Ioi
 oiVPODhnYq4x4d0HKzERN0mWJ5GIpRbujQ/rxIJZd08IMHGqP6g1t0ai7AkTLjhAyqU49HnN1u/
 GEdD+SquqkAdOw6iQFg==
X-Proofpoint-GUID: Gojpe1CTt5DAncbJdWaJ0pQaSgWw-gNZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX6T4y3kWKc7mQ
 hjKPDF0/t047OXavaxsBMqhv5kebu3TQsloqc0ZoqZU5gKh98L9qcO1IERECJs3rMxUyhwYtl6S
 MNgZMHWrbbdRZrhoNkmtSDNzcJjC8FY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The default preboot runs 'scsi scan; usb start' on every boot. On
eMMC-only platforms without CONFIG_CMD_SCSI, this prints "Unknown
command 'scsi' - try 'help'", and 'usb start' adds to boot time even
when no USB device is needed.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 board/qualcomm/default.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..4f5d3854501 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -1,7 +1,6 @@
 stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-preboot=scsi scan; usb start
 fastboot=fastboot -l $fastboot_addr_r usb 0
 do_boot=bootefi bootmgr
 bootmenu_0=Boot first available device=run do_boot

-- 
2.34.1

