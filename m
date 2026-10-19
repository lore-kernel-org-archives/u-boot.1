Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076B1CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 06:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54AA2606CF;
	Mon, 19 Oct 2026 06:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WV1yI0wYxSvD; Mon, 19 Oct 2026 06:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2796560612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392721;
	b=q988iWOCd7VBWjAac4P7h+een+mPoZB6eau+sEaT15PHRdddqicpFBMzPwxu7hxtWGyK
	 igP62v7U7HNQXnUJwmXmmrBkAcm9GtGJAsOa/lk29ZFTLuzV2ZMpAacA1Z2plRY2AUfiF
	 cpdl4MhcQaKTWzr0zVzu0eSkD60ZQUol2gi+NlLO/OQiDsmZt1zVi6MvPzEi8eT0r5t9+
	 V4G0qHXq5J7IN6LxaYJ+BrPBubHGSjCJ0LzqUg/GcFEOR0oEfHgogzSTwcmEzlYmZBhI8
	 KkMPv2MFVqSR7aXzpA5kufmiCYeHjJCaNH+h2dtfR1Yi4RjEmHgFbkSY1AjaPM4BYeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792392721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
	b=TmDtmF0vKX8gmHXh0igjgjQG414hoSgqYz6z2Dx7AkHBqC0kwOC1lyZVWMRuFFZuGoEI
	 EtzjpPHYFUXHCu2r1kGjDC2oXpeYvKWJRGPALtSG5qGFZN2I1XkyaFHWc6zTHqqw1bQFX
	 f6hqY4FT0wNbcOvmreI4qDVhxHElnxUHFrV3Lk4nHEPHFw2JhWCMuTL2sIS05K6E5UOD/
	 SFjhs7GafVVeXwRzF0hOIH7wFBuWXwwexH9Fn8qNbp7D+Y1VLmCC/yUMxwLu6mJUV3MPm
	 SHSYooYTPpTDvv1hiZ12MSXmm5a4/g/a8MTsACuChjwhod/p2weOxHEbk2CdKGkGh2g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792392721;
	bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ywlxLzphD+K/tnQUbXANV8NclGFWngLU4irU+99Zb3ddcynPK3043LGsYsvyVrFeZ
	 QN83VcjrFu5j/gxDr6n2LdTuM0Qm1/VXS+M7nKl07Mg8C5X0zYl8iq0Z+DXipgS1nU
	 wdMP3Hiok5ICY9KD5V0kBVSa2Ct00UlpLzWr3Mzl73WrP8zVJo62VudiDswM2PmSB/
	 9UoLcK6kJj+Vh+DiNnXGzdorzQzB4fGgxA5V440pvgP6/cFe9SkxLeQjxNz+vyGf+V
	 n7oabn9OckgVRS/jBFBadAg5SDkq6Gr4qYPpnlu3AgA0HsDZLCSlQQh0xrol39i+P8
	 5ZVuAa5NylPnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2796560612;
	Mon, 19 Oct 2026 06:52:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0B242A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6B54400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOZAoPMVm6ac for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 06:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 838A540062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392718;
 b=rsPQ31IOO+Y0rtnMT5GJge96WZB/f/9hxk1ErJ/cquMcA8N/R8WfeioYz7wOxqeMajML
 9XwlkpIBlgLrnOBHqPKuDE5tqBvzra6kNet5/rjlId8TBrkj2MSfG1MqnKEPrcv92oulU
 q/WjUJZUBeJF1f7Mojlb9UL1FL7ucVaiXZBoPw5+O4iMXnCxWMFhNZxSiCkDilOvIFpou
 BvsrqAeoyAqp2GErJi5asZ5O0e1dISP6dlwyDwhXNnTz22zfctbHWFpb7hSamWB+07S08
 Q0FMf4Y5NFWrQ4/gxF4EhQHcLxSS/bNIMwoQ0tiZHuSKU1uSdGDD+gOoJcPYcBWXcmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792392718;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
 b=GL7+gnsiKRtnjUeh/Zd+8kwFcy5oWuL3H1IHRZSqofogJ4Kbhp0N19Kj8igDhEbDQLqF
 ijL6LQCazvWTYitMVMbZ+Uc/iKKg8GPbNNmDO7Q54gwARvN1DMrj3UNMov20pyvT4v3Nu
 h1V8dnU7yLIqXd6IhnU8XxSy85jwFckuyiX7I6vRZTh371Dw3cWFvvrPiNrehY4za/RwJ
 qqU8EL6a2iTPA8Tze8VvmoeAnVvD/ah9Ykl2B5wB6qzT4P0qDR9r2MhtDWFtsBeTfBUrw
 AwZkX78vSIvwup62lfsgECKVD8NN/GEP+FSV5gNl7qLvvIw2zpPMZDQgG4NwnnB8Isw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EiWWnxBR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="afz3dWc/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EiWWnxBR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=afz3dWc/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 838A540062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j2qw2768563
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=; b=EiWWnxBR4YdaHbAl
 F0GLIdZFwZCjBo9PYttbVJEkrH8aCfvXgx498sUS83PRfs41D0nXGdUn9O9cIGih
 oYhqiLhKokJVGKElkKNXehOSidEYvW33XsF16JWqASM8u0YIYEFYue4Znffnpf3C
 nRg4XIGRnDnT1oVBLcGQA7uookV6uo5Sey1rtRWTtP6F3/u64X9rduo+y3yXzI36
 kOGOYY0BE2WMOOTLndO8LVumZmvX3wA/YVYz+V3eUTYVDEjV3tWW41JGFuuFy8Op
 yLF8z8iWWAvf0ZOkwQFX8c23RaUT6zGLoXt1FbpQf06K2xzL8hII8d9KSbK/jHf9
 Im9eOQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys5dth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:57 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67994010b21so2852805d50.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792392716; cv=none;
 d=google.com; s=arc-20260327;
 b=LUE4Yk/PvFtQp85biJGmxJ0FqH9c6D7yfrCiZou//H4bfDsnUz9cMQDv8zq3jaWcc0
 u/JSvcB1v5ROkuZYxDb2YOHau0TPfnQOZuhq6my0L0L08fso8XwyrbvHVJAmZdKVyjRP
 EgIOfLMOhJF4FBA15yBVaKLI8PU6+W+D9c0Q68VB9Tx/b/Zo9+xgUGc/0ycztEdilF9M
 TLAUatxAYEAJ5xXAttphnuQW0oPl9LUsWBL7ILbWgYjwY6rtN3eMGx8G8A1q8pwmAzUz
 x2S1ucROHSwtIYvSBO6IkaEbWWLwfjH86fyyvbCytBn7ucwOiVwovsYHxFMvPq0nJc1Q
 1fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
 fh=Ef34te88OsNt5zsjOmRphdvCiYwvjGWzKhXFDskzWH8=;
 b=gc63vNR7YHFvugehWJVzOIgQ2YqezdCyMTdEOz7NNvITtj6PmIa1gu1tlFfffP1VRl
 s+nf44icaVbj3CvoBSaprMO9o2YlHlexNQkntkCAF5+Mun5ptXX15fHQlOIZojqwpn3D
 kvhsGBzwoM3peU5mkXUoScZWNMx5yTTEQrGwZ07PkMzl2UWyQPj2EB3qhuVw+u/31/Md
 BPsyXyH/FRqA5Fr3kGE5Fn4NQbJlagKGL1jdi8C9NVW9jEHI2jAairdUqmK4zLqoLkNu
 HclqmI9lJMfS8Z76NPm9HD2syouQufjPbA8gVgYDqAEjBr134WuhTLdfKJzJJSncnR9e
 pxhQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792392716; x=1792997516;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
 b=afz3dWc/awHwnee7Wsh6cASsmhoqV5PKymPVKnQ2YJ5o8UorSPF2EKnCOWFQJcytA8
 4WXTJoO4rY0PEyjpH4EoJrDx3Kc1AoK8gpqrSfroMPBHRvSzS2f9ffPfh/n7S2eDp3U+
 jgYghqZ9YAGd9gHKXDrnPOl3YXmbOIX/pE63mGlmhflIm/m1jp+mExlotSvubKxufoes
 jDn7cvJh5K7IKlonI1qR7At63UJdr3It3hU5jHMgBhWTD14+PFxjCroz4ovtSXDLrlZP
 j+SO1wBwqEDbSS+wjfUX/KZX7IkATmidCl/RPNZ4AnpIL4dnpn2HrHAR3SupeLQgToij
 IKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792392716; x=1792997516;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NzNvEPsIzMk86GqgBtKZtdZUhl2uJOOH5xlIW4fMP6Q=;
 b=GrodAMdJOwpLJXVhFXZ8zDFK1+ZgGlkDqqpdi54cQJS6deAFIYSzzrT6bfSTP0Cqio
 p+4QriLCzwRLi7XYgaTBUsqafWyKpeEO0/8JGHM9O5p9cmtMIoza1g8Eh2dnslqcJnKt
 W5qitiFHu12X1VHIycVOnmQZxIcB6GkgNLB+QJ6flTTb9r1l/bsmM4B733YqtDb78Cr6
 qW9qMsJfxlQS1MA1YfuSWos2Q2DMMIDojw9+Ukg5MJZciauFCZ26/IQF5wtFB0cxBA2+
 lajTWFpk+uD/bU6B6fG7d9ZteHJHOdttuVUGb+h6FrbSHm69gnJtWCEUdrubrsi+q3Vm
 PnpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbfOiWuhGwD0bD0BACCh26SplTajecJVgsbSHObTivA1m8dVxd+zp6j7ExhUCguAxetfsK4Cs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ06aVwbr90TCS+tAvudbsEiprio6eqVBenvOy8qdV1yqjsmMiW
 xFJERD+FJGNQhaN2o/+x/5WhOba+S1ofB98jGbNgHwt0fmmN0BqKsoHvXI77Gh4Hq3I5USxD2NE
 L20f+hyq7CYJxdvgx8JRynZ3Gl7Gy8nQSXChfJVdjJ946bWlUnp4vnWejng4r25RZkoBNF+sU1L
 tdVcAr/o+qqGlQV7c/ykrhGiKu5UJWJW6bCS/HYEuJTFRViQ==
X-Gm-Gg: AYBFou1qaAoR5XbIOjeiBryQsqxNhfrENGuUF2JOxDrV5VVlKKqCPEO9/KG1jxALV33
 vJgaCagfsZA8t4AfR4YuUiaZkuCj9LjuaVQ9Yxe/957WPsWqpC/OxVtdIKeAz8dXNV8jjDRWREg
 0JxeEFDZ/sYeR1AWrrfw/Zjw9qpsQi0CKaKgfmUq8wOj5j5wsQqSK42S5UCw==
X-Received: by 2002:a05:690e:11c8:b0:677:d251:cce5 with SMTP id
 956f58d0204a3-679ca7909a0mr2010324d50.43.1792392716366; 
 Sun, 18 Oct 2026 23:51:56 -0700 (PDT)
X-Received: by 2002:a05:690e:11c8:b0:677:d251:cce5 with SMTP id
 956f58d0204a3-679ca7909a0mr2010315d50.43.1792392715921; Sun, 18 Oct 2026
 23:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:51:45 +0200
X-Gm-Features: AclHuK-QSi3sBKxfunLog2DELmBxUab2lOTCPMbKp13EXzvmUm-mcrnxdSi-pus
Message-ID: <CAPzfCAbFO-FqDyE223Zr3GZ4V8B8gULcxkD4p1L+PNGWGy7-Uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] avb: device lock state, root key provisioning and
 in-place verification
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNyBTYWx0ZWRfX3hqYiS5mnR6o
 OMdItxyiI4YppEmB3nClvY7QrfFRq/+G5Z9aXPzKmObMk6bBnVy+GSVO2yK4SsyEuHnEfCGvlSF
 RzKkYorsqh+pfosVyKZzqogv8W9XspqGXqXNwNeav7qvUPnIiM4TK/fq5x/NL/KkISGxmVLx5VE
 JNo4DDVpyKCwpHUF2c3wiUOTa7Cpm4Snooo3+uLSV8LCuoNhOQ8Sj6PhKC8xDjZ+IxClaVi82bY
 bt1X57NSzu7kj50VDNSfAGkeC23X9j4x7F9arPHjMgaDjhQuKXJOoFImspBcfmtU5bVAZUMNk2P
 L5cKoOVJdb17EDZQfgphRN8Ffd8AG99P/NudgSkJ6sQQbDnHVeytarBYpdFZUXhQArW+9zvB4G6
 jMThCvtn2Axn16GyuSF7IAvRqangNpxXTn0ocs3e0rqQAbe0e6FsAQBUoF1mQZNlnZQwSG2zB8n
 bJa9xtsF8Ie4CVSZNEQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad5be0d cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=MvLPCTjVzJYr7j5C4DUA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 7iylMKBdg2OZb122DUy_qMoI5V625-OO
X-Proofpoint-GUID: 7iylMKBdg2OZb122DUy_qMoI5V625-OO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNyBTYWx0ZWRfX+oZLZHheNtue
 SXf8E+OI6uuBELu3/wmnDv44ln7ajeM8IFP3VRAvyTfEC3CmQBx/mxIHRRI6ukK3x0gbMIHfkgP
 qegKxKgAljC67DjLLfFSykLn+wpEp90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190027
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

On Mon, Oct 12, 2026 at 10:25=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> This series completes the device state handling of the AVB 2.0
> implementation when the state is kept by the OP-TEE AVB TA, and fixes
> the way the Android bootmeth hands the boot images to libavb.
>
> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
> "avb write_pvalue_hex" provision binary persistent values such as the
> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
> consumes, and "avb lock"/"avb unlock" set the lock state through a new
> avb_write_lock_state() helper. Until now U-Boot could only read the
> lock state, so a device backed by the TA could never leave the unlocked
> (orange) state.
>
> Patch 3 makes bootmeth_android verify the boot images in the buffers it
> boots them from, via AvbOps.get_preloaded_partition(), instead of
> letting libavb read, hash and free its own copies and then reading the
> partitions a second time for booting. This closes the TOCTOU window
> reported on the list and halves the amount of data read from storage.
>
> Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
> "unlocked" variable, so the state can be changed with the Android
> fastboot tool. Both transitions erase userdata and metadata before the
> state changes, as AVB requires.
>
> Patch 5 documents the root key sources, the provisioning of the TEE
> digest and the lock state in doc/android/avb2.rst.
>
> Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
> 17 images: the chain boots locked (green) to sys.boot_completed, a
> modified kernel is refused, "fastboot flashing unlock/lock" over
> "fastboot tcp" erase the partitions and flip the state reported by
> "getvar unlocked" and "avb is_unlocked", and QEMU's SD card block trace
> shows every sector of boot and vendor_boot read exactly once.
>
> The lock state is stored in RPMB by the TA; on boards where U-Boot
> serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
> RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
> There is no build dependency.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Changes in v2:
> - fastboot: guard the flashing_lock/unlock/get_unlock_ability prototypes
>   with FASTBOOT_CMD_FLASHING. They were declared unconditionally while
>   their definitions sit under that option, so every configuration with
>   fastboot but without the flashing commands (sandbox, sei510, ...)
>   failed with "declared 'static' but never defined" under -Werror. v1
>   was only build-tested on configurations that enable the option; the
>   sandbox CI jobs caught it. The series is now also build-tested with
>   sandbox, sandbox64 (out of tree) and the arm64/arm32 boards that
>   enable AVB or fastboot flashing, and the 107-column dispatch line is
>   wrapped.
> - Link to v1: https://patch.msgid.link/20261011-upstream-avb_lock_unlock_=
b4-v1-0-a45aeca54016@oss.qualcomm.com
>
> ---
> Igor Opaniuk (5):
>       cmd: avb: add read_pvalue_hex/write_pvalue_hex
>       cmd: avb: add lock/unlock commands
>       avb: verify the boot images in the buffers they are booted from
>       fastboot: add flashing lock/unlock/get_unlock_ability
>       doc: android/avb2: document the root key provisioning and lock stat=
e
>
>  boot/bootmeth_android.c       |  73 ++++++++++++++++++----
>  cmd/avb.c                     | 141 ++++++++++++++++++++++++++++++++++++=
++++++
>  common/avb_verify.c           | 103 ++++++++++++++++++++++++++++++
>  doc/android/avb2.rst          |  69 +++++++++++++++++++++
>  drivers/fastboot/Kconfig      |  11 ++++
>  drivers/fastboot/fb_command.c | 119 +++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_getvar.c  |  34 ++++++++++
>  include/avb_verify.h          |  39 ++++++++++++
>  include/fastboot.h            |   3 +
>  9 files changed, 580 insertions(+), 12 deletions(-)
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>

Gentle ping on this patch series. Please let me know if anyone has any
feedback or objections.
