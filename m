Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F252CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45DAB6075D;
	Mon, 19 Oct 2026 09:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkjHs15p0z4C; Mon, 19 Oct 2026 09:44:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BA2A605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403082;
	b=dwXOFrvKx1yvtp+OTHoXadOzhEhJgTJbliZqCYVygl2KOsHl0x064Y70RIlqPHsiZiar
	 OyjEJUMUrSnWWQeozzqBh74UZf4Vmy9OSuvOnJYJ+L67tWb9xsZkTr5AjFlLKgj1IptW8
	 KZ88YWn5mQEInHloteg0DPL2H5qlxqu22adhkkrWWSVmy7lFqkZj3KV0DhE5jWxxa9Yoa
	 ODwWueJdAgVfXgkFCbDVK/+XmoepVsU6Ug65L58cMaazzjMukvRUmkQ4IqgzgyL6772OO
	 SR3XQ0WBDe65LuKyv8p18K159Weq9nEQ3/7TXxN4ayWfoJ6IYJBrtQabiTiU27UehOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792403082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
	b=rqlqMD18fKDtvtiwG+uryjzbEhR3aYUfQq9+lN2r1i+F4/IYlyxAt1ISpgQi4dpcfx4F
	 gYvuj57mZptKWpgYm84nlgWd9s6qrqIIRsnmDV8Y0+N9O87PZY9LnQorYItOacniseMEG
	 pAryEUoo7paHpA2UMfgq4lwqNGbgk2+byEkWc8g9UTgszSJjIakyoZa9LkHPWDiBlNZqK
	 cTvDtjphYY9F+xOtv92k2axxGgaOKuIEQjp+U2oohN7DCxjJIRcIBqrRO5sw7cQwUYG6v
	 jqO0LlE9fhyTsMwsPa7Piiz0oydA+/T6Xo6dQDcHvPBBWjXh1q2RzyV46b3wafC8M3A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792403082;
	bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PaZJ9jYbk0DzILMaaSyb1g3WL2wehNAhCixIIugFudwW5TMsnx5mFqMIu1i/Vh4fQ
	 7g3VbvQAn7b5yNKvWyPmplAExt08yWpWEsYQpa3QgmbiI6aHWRRJvaRrrsIZhqCM9P
	 GQDMbvjA+RSJtYWrbG67fmoYFEisp0vpszD9neHc5f6h/ur9yIhiji4IW7+mA1D4BJ
	 v+HezjGIEbzACgqWANw8sK9H2YMfvd5OvgBR2WWik0uhIzKRDb6m4hzg1rsimD/lBF
	 IJv7wbtZrYZZrg5SqZf1Wy/jLq8OUCkgZR1PZWUMu3t6etl5j0WyhoeHh4wCreNNEb
	 J7+eiwwxNSYvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BA2A605FA;
	Mon, 19 Oct 2026 09:44:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E8A21E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 003F680E1D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GlEzP5ajsW2 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A49180E17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403080;
 b=ddln6jAUEYPiXLzFPdBomwvgpC6jBbpysGnnJozsQ89TB06kj2iVlYCgz/G1cbEd7nB2
 ICJ0YPOi5rIF9T8kAlTQOdQ2xDCGPeeTQUmLogGZ6JWp3u5o4MVQ8tOuF9WEmrCk1YQUD
 xQjgKELzO1CjGr7EuJJlhsgU78fhJF+Xx5RgfzBwEEOM/uJr8U5UU8MK0X2KSKThBbrRg
 syN+urENnsfTIqAC7A/ygyx/wicGQ8JVmDDc3ZF1NWgq5PqWVbeYzAl05ryWCnbf344F+
 tsi+ir1Lgoj1tzIb3H0y8H3OLpD+qBCpiwr7xnFvEHS81VyCr5bxL1KEsA5MOrEVNog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792403080;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
 b=TDRqyiw9kaA6IJak4frUlz7arvPhNIJB/Jhq21CR6tcpfU+wBQkByrs459RXxV+8FgPG
 m+KX1WsqON2dLqWsecnvg6SOsPefujEx8SkibG5EHVSQHaT3bE+HKqyJLOx/5QK7iZevm
 mbPnMTXX81Itms0pJv+ObjQf1Eyoi2WkaEJa28yTZXUOyz8j/qax7xrESbze3FwbXVgkX
 KFnzt0RdG38Eh7WdOQ2Lu3bCwvCgCJ7rXbiYBYxi3qVMYEva0/J0lx7n8wLZqkA0VcJbK
 widkEha4fnf72JQiUE407adlq8xpC4asaILyn4rh/iHI+7dxrkAlFack8YCROilC0aA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IaPrbx2b; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="X/Wtm9hN"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IaPrbx2b; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X/Wtm9hN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A49180E17
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Oqpb1348117
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=; b=IaPrbx2bt9yWkkkn
 nTB5NJwz+3ZJzdSOoe/ML63GJc88VpewtQEWS6g6LVpp2/i39qfo6YHZWvpU7YSl
 w7T1N1MhAJTK+RZtDWt5Ry40R1QZKC23clIpUuPOdqVo5ZdH2SETIASKRBUNsA14
 ZIGJJftySGXHvUfhWMTdjdkefEcEIv+CCmG2FLpqsLp5MxL1U4rZ8WuFk1mVy5iQ
 dL+mLk11yZNNOAe0/qKDI3dO6nyi9ewsg7G3j0Wf0uUfRVoxA7rqce5t9OgphYW9
 z4+QmvbY5N8WHL5gB1m+SMkW1wjVv9H6DUSzhLSVp+dMS4r/15BYDBwY1onydmpJ
 lNA+nw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgeds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:38 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b0d36c1db7so24118937b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403078; cv=none;
 d=google.com; s=arc-20260327;
 b=sYO/pZvqm6MW9T1270/bdqH3PDVPqmeabUS2EZiOpfMHIUg8ab/xRhs4HdaKgtjw82
 VysFOeRXGmPfTmpir7e0XxK/k+gCu1P9PtPnZ3kW2Mxptaijoy7ntJemr5oAv+DbA6G5
 XtKCD1AnWLSXFRKyI0rFf141G7H2Q9aamiE3gwyPaMvnuSIahuNWF5zlnVLinAYAbGQS
 iGidrMwuHO2WHtLeQDYlkCE8cTjpQf5MOfvXZwM1Asa4bkmK6kbQNMm0qyJC4N7QdZiR
 BpEskgRbF+PsG09HsVskN0uc/Vp1V4Puosvr1XzmLWh3AOyGRt8zKvuJzyW+nKY1T0Co
 9Q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
 fh=o4m+3W1vRtzIm8wXmhLaF8pdrmGc0GYSZkn/xZOKFUo=;
 b=MuDKu1J38fLRhIl2lVUn2yY5/jjip9WzUZPJRTLXNsi0kagBrr+PSwYzqto4SS6MHm
 rmanNNYScpMwoTb015l4FH5+yd8NIAqs4gbKszZWqKaNWfSE7dQhxZ4IPmSnGNj2LxSK
 a/G9UIzzHqtE+/1rEfG/NOCk/6dMt1+UAohhVnlpqcjFmQc8rp+b71c3f8I2Ap09V6qU
 q4e6M2g88RRK65JPD5EV3d72Zy9bS9l/+LnHSIe8RYOmVnwMen4lDWX+6dfuP0P8Z35m
 vfLvWNxLaWr5y5V4sH2ieqhuOuCpl6gJ4fWdgcmxvjZCYDpwvgMcPeZ4DbBL5zDyPUen
 zVLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792403078; x=1793007878;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
 b=X/Wtm9hN/Na0lBVDRcObhoqeyDVMvUndi4/DrfmRGQQSujz7BZKuIB+/Cs0d1TEdeq
 L0g6dwt8/GUMMwsq2jcTu8ZHArD18yqIKPv/aW/1/UQqQz+pC68Wm36jokwVLrObTD94
 6xH2AaUNqST/lsVf3NvfFar+azrSPYDe8Ids9bx5Vp5SCTUrnZvb0aJ+qmnSNnbOzM9L
 4eGuV8fB2MpI4O6OyWmD2MmZx0NYXWMDoR5C2/RnlXYWKRqR32+nVDev+Y7Ykki7xOzX
 NNVF+PJKPD+wQJ6AqXr5d8E2KkZcVWVz3HQHY+RXrOmWmmzAy7C84yEyZcvBvbbyGSCj
 QemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403078; x=1793007878;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/5FHWUp6RaZyIvCut+B1ASw1+LnmcLaQcGM5/lILlc=;
 b=hxihlH5EAcpQ15vX+/sf03HKwtZqY+hAUwJxvQ4XnuAeQOoB0A9VZvvp3KrPXX3qBM
 /RUu147Mn92gXNRqdpD22Y5hd7+KU7/bX+Lh6DsaxGRi/d0Xt9quWskmhnk9ZUUQghbf
 0Yyxrf1NEU+BSH3Q/Ntj+tE684zn+Eqmaq3Z/NxQSYH8+59STb8K2yd+3xFTRvRZtLGa
 4oJQ0EtwyR7e0kImRp3oz71VMDMfTwjkuAzc93mpdexftgX7tgSoSXpmH/XmsP4bdhZ4
 p4Sa+8llJ4gd7j+KEH3B5gIPzQ6Y0i2MbIU1ZnQdG0WtGX9VRUqwuRLdecnaWWbin1TX
 BNeQ==
X-Gm-Message-State: AFq9FYILHNwhVK3LY33tKhTlcPWYfWwQHSCcQHwxLCfgfhrzUdgvK6Yr
 gFcGv3U5eRQqxl4y3gHAI483GiC3FVZTbDSuDMBfLI6X6UljcK1MRuFUZcQX/1WnOcRygIu01AS
 2KDUt3OhesVf7CNZdN0/LbuV4ccHokSexoSXqFeDbgtdmeF3h+Sancb9aXW7OXIRQzUS4UPTuh1
 BYAu0wTinQZRm3IG0GFeKRPsMzB9FrZ633HM22wMKlMh3FAvlTIlY5F6DX
X-Gm-Gg: AYBFou2RyjcSNJWs4ipOMcrzJjupZESONkHnQ5mWX76bFEKBGhAqE4TnTDbyNPJ0isF
 vVYArxgfV2WEx7O1bKYyS3TAbA0/p17LmWvQ3Lb9Jnm+XlorwwSCOBKOgFtGA6xr6nCHj0N3F8s
 8ZUW/Ag6ggwADbJOYsFqA4hUqR7JC5CKFxQETgPzO/Oc5dkaX8GOnh31SCsg==
X-Received: by 2002:a05:690e:16a1:b0:679:a74a:d3b7 with SMTP id
 956f58d0204a3-679ca7aa2ddmr2768512d50.39.1792403077735; 
 Mon, 19 Oct 2026 02:44:37 -0700 (PDT)
X-Received: by 2002:a05:690e:16a1:b0:679:a74a:d3b7 with SMTP id
 956f58d0204a3-679ca7aa2ddmr2768500d50.39.1792403077352; Mon, 19 Oct 2026
 02:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <179240024782.806974.13238424938859043833.b4-review@b4>
In-Reply-To: <179240024782.806974.13238424938859043833.b4-review@b4>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:44:25 +0200
X-Gm-Features: AclHuK_5S6FzfENa7Sc4rwJk5Qlb0fl2lNtWMhBaFjqvO9iW2zk15sL7zG1Lonw
Message-ID: <CAPzfCAaQOWHO_MsqGOw3it-Eci97zshb+WVuKiPAPG9Afugjsg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fix AVB pytest suite for sandbox
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Jan Kehren <jan.kehren@emteria.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: TVChwN_2w60ijF3d6hcB3RLRWIobrU7r
X-Proofpoint-GUID: TVChwN_2w60ijF3d6hcB3RLRWIobrU7r
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad5e686 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rXjUZikZY-Zm6Q6JeegA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXzN6ysIZMJ69S
 39qzRQPK1M3DdQGhtPjK2oSyDqNl4DqPDEtKU37RUYgrFWALUic9dUSpRqXP6RlE45OIBBO/XeV
 aqlwvy+7MirKPrJwXiPyc2Yn9YjdCd/YEvQz+PX+1K6QJHx5SmF6EsHYcZAk7V2AzHX1ROxfD3Z
 sMFWC4GZMpKnnpaZPpqhpMp7Fn7LagDQhRKHw8R7MBEW7vTSnl9nkDLFeRvXxXSlylPnaLviDC0
 tReuEEVU0EmQhkHTAXJJj4gFwyUuOgFmS6ZLunO0vv9Wbdu0Qwe7oN5Nrn1RERLD9T4Iknv6XY7
 gLDwnzLwMKSIgBhdInkEf/QwTmg+G+dKp/T8HPuoRdZuJKmVd3wk0hCtd3CGJ+u6NKwIsx+OCi2
 ctQ+3jYzV6JLeqcolB9+/PuHwC1lwIrZeL1k3fTjNRZcvXO2z9jn9bIQV2nKdBHTjkGxGY9BtKO
 ZqUOjnCuvoFBK0EEwlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX+THYhVkFnNGA
 I5m+SoRrgZhEFPeUy9HiOzXinObWzsXW1yXOpaetUdy08Iv8lyrapYPtniPfx+HkCA9f608IiXS
 xRrdJeMc287oeAq/NrA+8waN0eoufOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190038
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

Hi,

On Mon, Oct 19, 2026 at 10:57=E2=80=AFAM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> On Thu, 15 Oct 2026 15:54:50 +0200, Mattijs Korpershoek <mkorpershoek@ker=
nel.org> wrote:
> > Fix AVB pytest suite for sandbox
> >
> > The AVB tests have the following limitations on sandbox:
> >
> > * The mmc1.img required by sandbox is not created when the avb test run=
s
> > * mmc1.img contains a Fedora image, so avb verification cannot be done
> > * The tests silently pass due to bad usage of string.find()
> >
> > [...]
>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>
> --
> Guillaume La Roque <glaroque@baylibre.com>

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
