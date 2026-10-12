Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A6CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C76DA40576;
	Mon, 12 Oct 2026 16:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lE8-gSXlC0uq; Mon, 12 Oct 2026 16:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD0994052F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791823780;
	b=Ak/kFqG6nt1JIilVFLTCT3dG3ncGMRqMKMilrnRlTjXnN9GWE69vb6wPijIuHamSw//p
	 fKxpwqLeVpQbZernp/dv4c5ngXrcZG+klkpFw2/4mwRV3HHigdht0AF0d9IQzGSkXUcwa
	 R5O3rV9krAAOpjimYI5TZJnHM2B9t2Q1KX9+KNhLcWeR3Kyx4JD9aAFlLN+YjsC55sFvx
	 l/LXjQTRZ+WQxYGhcmgWJQtkWBp1Ic1vmnl7BNvmjg4CpQXEOVepBhUSnpebRLdSIZnN5
	 cSDt6R4T6oK8duKaBpopQyLwv+2Wp6eqMWfg+1pLZ6Fmx7za5RPADwBH53/FkRwFWTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791823780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
	b=EPoe6+UvYGSmD6Fi7WJr4D2Wl9ewIQ943FrZHISCiffmrtoD+6EAqBuRWOeLik+YRDzO
	 /JN0EkBPoHL5JMUgrlKy6IHBgudswZwq8SvzI2RGWpPuXpdkhbPWyDvAvBezjR3vtCZ8j
	 L37aGBc9XkggDElRHX1GILsL2g1Kd3ZAZDxiRBLtChJu/4XrT+RCIFn+fht0NRewo6Dzu
	 dW2ut7ja8zQHHCyzcw5TXG+cRvGdzlxUHiInC81fVD8QYe0fntAtbmTgnrO5rhNqr3QGA
	 ayLYlrFkjcQgtS59NnCtRUHehRKGVLe1Ye40BCZQByWY/2/yWPfpEbSXK6Q8uMR2CXQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791823780;
	bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KcefbST3j1lsHyOfFesLK80IWv2LWsKLCcfOs/7JbRc1np/vIiMgZNyPbAZ4dvQ4i
	 TCTqx5oRByAPNLGYimSIaDJ16tY6VgsxaK7XVb8OxQj99EbNbr8VhkXh4z8KnbEWHF
	 VgCKtEkVRB31bV2S+EwNwSYiXn/cU1BkQtAXCBb1gzkuhWnXToRLqeazY7cd4CmXuL
	 fbTYD13mM3iQ7gaLpsYTuFCDFBg1Ku1Byq0yNED4KCp+iEdtmPxcQEiAj2xVLCBGOt
	 wUGiCGwZoShqCxv+oXZISHvV3E7J/A4PiS2bHeTsXm9RgT0n+jFQwFuqYKvybsZZcv
	 UKE9rbzxo/5oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD0994052F;
	Mon, 12 Oct 2026 16:49:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9DF5156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C66B240201
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yO6j2TmqkXUC for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E962400D7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791823778;
 b=hUzHgPhKGxmLTvHxRlaOV6+SE6R60/zz6HhTk3i4r/S5rz0dzIcmVEIMJHn5lgfZfQSr
 Prb1rqZvtATc5rajUkl51s3BbTMQCXRKK36ENldkkSEzsZNERXnnfdWc7MHWi5Dx6Hm3z
 qnVp987Mbs0N+wewKQycbtsGEIJh7Q0kdSDeTuW8E4gHWKyDlaBxBYNerd8jfhmHLbzEk
 b0RLJoIU7zoy3u492hsylTtaBNJrS3Kn7lElCztsk9c2Rlle8dNi/VpyEBkU68PBnCfHh
 y1+j1n3aQ1PfZ0+vWv4m+amRcXrNcU55CDbXfGWHCgrbNrzYju+W39hS6onBjDElrFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791823778;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
 b=fVMu5aL163TcSStlcaQpafEpCKNDJVailGR7no4VWX+ATnNbvklM5e07mimLveWZxS2g
 +tbBV8bdBnuQFHGfLaOS3Twh3iYcx8K4ylm4pLKWELV//d9z2nF1sygHMuQN3ZUG1+exE
 eeIp2rzYqVQBDjO0ETKjDilaFSbCfQoLTPKHUNTZEhx1EHr2wfIIkqNxRkr7hDUHIS42c
 NNPhC+EhhQNaM5s1ed3zb8w2BTo5SjQ6SSrmeASUt6i5iv99FlwytZ4SWLZwxpSkVpOPP
 4sOPtiaMCdfkuFLQ9tQglX/hUUnp2633+918lBQhcyUC06I9ZF1m9JSZaCgmuRCBxjQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=i0XKSsxx; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vzk9QAAd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=i0XKSsxx; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vzk9QAAd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E962400D7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:49:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFeulO2575553
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=; b=i0XKSsxx6ubmQURe
 hwoBJ5pK0xeJW7OD6WQGV/Kj+7NqnHhCRevLV+1xxmFbqz1quTztMyhX/Nd4s71g
 FNCQDYkP20vrs3CNjwkS1EPapsP9iz4UHyAtt1aR8OaHnBZwozZ1EvJhrN3oeOOY
 z6IKcD7yK3eSUJKhASDgMzK+7lV56C94/Hfib34jc+sWjq/o+SV7cKcxsM10XEWv
 GBCh5KiVAlsvxjOetORM2jMdbctufzQGhOSh3N3GyamEnKVzGMoiPuSbKGx+Rtfc
 l7K9heQPikWwQ/6pXeLDq+qslZAa2QXy2kRFN+uBoTojDLERLsL1AAI3R4THS0CF
 frKsSA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu30ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:49:35 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-891f27da5c6so20916857b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791823775; cv=none;
 d=google.com; s=arc-20260327;
 b=G0C7gLxL5zjbQlm5sC5JV2X704CDzdygMOBPsEX42bA2dRhWeJbotFqAgzDKp7XNnX
 wJLS+WQWjB5+4bYTl4xOeXi2FUaF9in/8lvsxOQgB27n2iJakoqx7On+16YE0Z5q3yPM
 4xTy5WJPYH5kMRylPv+EV3PFLRI2fKHncNr6hrRdnri8zq3Hp3iWoCQ+Ln6GAf9HCU1k
 WJuGwb3Fidom4qjBKt6ayCZyg3/HIITGDN6ojjyhsvebHUvT/Sm57Xx5hf25443V1fro
 /f+zC6+oojG5KRdHm5xV86X7PZ36Xql1itnr+uUcQ8KGXz6qrOud0Oy3WpYbD0vKYCCV
 emrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
 fh=lBVJB3Y07zjzHtgZx+CaxLKeS87ZQ6TNlD6qo8xH1yM=;
 b=jfxCzhxd0IXCnat3mdEhkCMcfzy2++Qx3L1MRsRoHonnk/jQuiiEnYJMAHCYm0nLSE
 hfPM28zzVKHtNfG4kQR2R/Df+P7bpDMGFz92UrBWJ5P4Okjp2S8Qn3PR4XB1NWkQ+S9h
 20uC3kVo+FeBfzvAZi9r7EKbk1Y//c54HLaMTlb64MoiuocO/doz8IphaRz+ShRf8V+n
 zZieK/Z2Xs3IFPBtCauA5I+KjPtS9dEvfy/an5rZCKgyaFNUy2kGdStdJsyEgl1TD8bJ
 Mr7dqvFqv3T6RANp8NLNbkaax4PSkoZAnH7gnCiV0vHZnqe7gojYbTLlBIK1PiXoO951
 2Z7A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791823775; x=1792428575;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
 b=Vzk9QAAdNQKVICIKcBJsgYoatee9/K/H1hpAdmC6dyqwRAV+LTIPCLEVQ9HD6zSkNd
 8T5aAe7d7Gwn1+XDSgqRY6vN+pgBYCwa0ScFaO7Jl0WOwieeyy1PvkDjchTTyxiCkVyI
 LpKyAQr9RQnZU88QXhFBh3L02b1e5dT8oqnkO0k8zSeb8VFOHL7McCZACt6Syj9C/RmR
 m9/PNW+jLJc09nf/d+Sqvg2A63tcZBzKBFRliSEJy9ogpZHPmaqTWkeEqiZBa4uwxv/M
 4rmkP2l7+VaX9CSblyUQ/gpfKwgJBXH9/HM4dnQFCw+OlSObJ8vIP3MD2TIlp/3nAUYH
 SoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791823775; x=1792428575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1hGE4aob2dNVuCLgPvOkyipqStj7jlUSejILwGg2enE=;
 b=dmBj+IkfQkllRiKAOAffUKujDFY/5mkyvJOrKu+XF2fizO+JoQsWCXachIkv42xHwQ
 SSnVpQUYStORLLiwe6hEEjqfFL7CzrDGtTZzktAiKk4N4DCr6uckG36rix9dQ3o3P0RW
 /NQzVlv74LC1FIARKEFx9G79giPo7Z1iC6Q1mqxVuNciuNp7tm10pDfbpdbYIkLY2O7b
 Z9hDqgR8RUyXh/en3o+d8qnBq8CRIYAMRTKWKMjbM8FX+fg1OqCa5FHO/uhQXIgjf6Ek
 +mZSsJlOG0A+bb8mxwgcVxGkpv3B0LCGfXacOLjxOfOfIAelUU0O0GiB7IH2pU85yiZc
 83yA==
X-Gm-Message-State: AFq9FYJ1FOPhQJD5iF5/9mRe19zREXG4VJgTp+AComlVMsiWhfJwX1Vy
 wF0BZGoevzTNpgnXlyefxPpbyZlyvuQzLpMFAf3fKnqHe73Pd2dVGDx2Y1wb1YjT5Hb05s0sh76
 vtApNb3AAHbJ+NpOVbXCod9SQI6qF7FIMHyajs8LcyKzam/fgHzGcLBGuD6AiYXViaRDj6a3hVf
 aeodJBOAZ90oe8IOQ9WfWB/f4utnEzmVz79cFvmslTh1iurg==
X-Gm-Gg: AYBFou1g25GALKEPqQqRi71KhBI/mYKOnofxhLks98626yeOmUMdkt7bfiQ85Dh7T6n
 nFQqT+QKKh3nS+kCp2zUE///usmde/8jeRTNCSsWUz2tOWlD9n4RL78mmSKxzFoFKP+1TU9uRo+
 bie+GsTrAZwsPQytbeFuDFsKzFk1kLXpp5dx/6G3+nzd6nHo7prcL+z4JQfQ==
X-Received: by 2002:a05:690c:4d47:b0:8b0:702f:3554 with SMTP id
 00721157ae682-8b07ec014eemr36656997b3.8.1791823774952; 
 Mon, 12 Oct 2026 09:49:34 -0700 (PDT)
X-Received: by 2002:a05:690c:4d47:b0:8b0:702f:3554 with SMTP id
 00721157ae682-8b07ec014eemr36656887b3.8.1791823774469; Mon, 12 Oct 2026
 09:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-bootm_android_b4-v1-1-3e82462ac206@oss.qualcomm.com>
 <CAFLszTgcEmk_pTufiP06dLzRfG938FoPa_60WRyaQ72QOQRYYg@mail.gmail.com>
In-Reply-To: <CAFLszTgcEmk_pTufiP06dLzRfG938FoPa_60WRyaQ72QOQRYYg@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:49:22 +0200
X-Gm-Features: AclHuK_O8zr2ve6p5J9TThAIzREOKqHX5dOL0IwvRV2fW9ZC8Jce1tQnBnDthaw
Message-ID: <CAPzfCAaGzAjYjZ8df_32H9TR+Bpy2y0Jpq75Xx2-_bmagsdKyQ@mail.gmail.com>
Subject: Re: [PATCH] bootm: set os.arch for Android boot images
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acd0f9f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8
 a=V_cl12Xj7qB7ECqdeGIA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX/+mhwqsCUOhO
 f3MdXTgizx9reJi/4Q4ep0tSTGr6PIwGQ9IaCUmdIg2aO3QTHv09mEdGBboVvvFWvJMDNyxD3HV
 2rgLkAATgZIUyo5VkDHznGXJG2uksbiPvgGCr28pwviuhBiOOd3alU7/AzogtWZbddrtDaibGFL
 XxDjRUmRuCfkhR/ThH0FNpAjUo4ey8dEsf0huY9ntPoyIiRWh7YSPFKucU8JZVOm4yqDt6Q/s3i
 VdovN/TG7sc4xw2INix4ie/9dy864Wynrnbx1nLtTYzsl1AEy9e30exyyncg5HCvrJSrdDOaf8S
 OXV7JOnD6CLsBX0AvIUAQLkNUUhpryM0kUH1dTa5iLTpCzXb9FYT7Bn8XQA4S6tIeZE1kf8JI2M
 oe8LTPp6Lx0teE9EOhJYLAV3Bi4LzJlFUHdqn+xx6BeBavMJbPtmjhOKhqtNdBl+aPxZd7GigRM
 Ci6HD7GXw2FwPv5EubA==
X-Proofpoint-ORIG-GUID: 1fkMga_BwNkASuzZcFik4NxfPz2iejq4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfXwSwN2y9FRrTq
 nPGO0Tdf3Qm84ouPIZau+MNMvhZXnX0rzu/txXL2bZaM1jLY96QOZwztTPLtmzweTsnMxgGAXMF
 EC91BfDygvnoOrdsfpST2TfYbvioNh0=
X-Proofpoint-GUID: 1fkMga_BwNkASuzZcFik4NxfPz2iejq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120067
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

Hi Simon,

On Mon, Oct 12, 2026 at 4:04=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Igor,
>
> On 2026-10-11T13:10:26, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrot=
e:
> > bootm: set os.arch for Android boot images
> >
> > bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android bo=
ot
> > images, so the arm64 Image relocation in bootm_load_os() (booti_setup()=
) is
> > skipped. An uncompressed kernel from a v3/v4 boot image is then execute=
d in
> > place at boot.img + page size, which is not 2 MiB aligned. The kernel
> > reports "Kernel image misaligned at boot, please fix your bootloader!" =
and
> > dies early (observed as a stack overflow in start_kernel() with a GKI 6=
.12
> > kernel on QEMU virt).
> >
> > Mark the kernel with the default architecture, like the legacy and FIT
> > paths effectively do, so booti_setup() moves it to a properly aligned
> > address.
>
> The legacy and FIT paths read the arch from the image header rather
> than using a default. Please can you say that the Android header has
> no arch field, so IH_ARCH_DEFAULT is the best we can do? Also, the
> in-place case is not specific to v3/v4:
> android_image_get_kernel_addr() returns kernel_ptr for any
> uncompressed kernel with the default kernel address, or with
> ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR set.

the Android boot image header carries no explicit architecture field, so
IH_ARCH_DEFAULT is the only value avaliable, and the in-place execution
happens for any uncompressed kernel whose header holds the
default kernel address (or with ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR),
whatever the header version. The v3/v4 mention came from my test setup, whe=
re
the kernel sits at boot.img + 4096 and nothing else can move it.
I can reword the commit message and add this information for v2.

>
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> >
> > boot/bootm.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > @@ -432,6 +432,7 @@ static int bootm_find_os(const char *cmd_name, cons=
t char *addr_fit)
> > +             images.os.arch =3D IH_ARCH_DEFAULT;
>
> Just to check, have you looked beyond arm64? Perhaps it would be safer
> to limit this to arm64 with IS_ENABLED(CONFIG_ARM64), or explain in
> the commit message why it is safe. What do you think?

I went through the readers of images.os.arch field after bootm_find_os():
* bootm_load_os(): the booti relocation, only for IH_ARCH_ARM64, and
  booti_setup() checks the Image magic first, so anything that is not an
  arm64 Image fails cleanly instead of being moved.
* arch/arm/lib/bootm.c: the AArch32-kernel-on-AArch64 switch only
  triggers for IH_ARCH_ARM, so an Android image keeps taking the
  AArch64 path exactly as with IH_ARCH_INVALID today. The other reader
  is update_os_arch_secondary_cores(): the Layerscape implementation
  marks the spin table entries OS_ARCH_SAME when os_arch equals
  IH_ARCH_DEFAULT and OS_ARCH_DIFF otherwise, so with
  IH_ARCH_INVALID an Android boot currently releases the secondary
  cores as if the kernel were a different architecture. That is a second th=
ing
  this fixes.
* bootm.c: the setup.bin lookup for IH_ARCH_I386/X86_64, only reachable
  on an x86 U-Boot, where the Android format is not bootable through
  bootm anyway (the kernel is expected to be an Image/zImage and x86
  goes through zboot).
* ARM32 and RISC-V do not read os.arch after bootm_find_os().

So I would keep it unconditional: IH_ARCH_DEFAULT is by definition the
one architecture this U-Boot can boot, and the legacy path refuses
anything else through image_check_target_arch() anyway. I will put the
above in the commit message. If you still prefer the IS_ENABLED(ARM64)
guard I am fine with that too, it covers both the relocation and the
Layerscape case.

> BTW, for a v0-v2 image whose ramdisk is used in place, booti_setup()
> can now move the kernel forward by up to 2 MiB. The memmove() copies
> image_size bytes, which includes BSS, so it overwrites the start of
> the ramdisk that follows the kernel in boot.img. Executing in place
> already has a similar problem, since the kernel clears its BSS early,
> so this is not a regression, but it may be worth a note. The following
> LMB reservation also still covers the old load range rather than the
> relocated one, but that already happens with FIT.

Good point, I will add a note. The proper fix for both is to stop
executing the kernel in place, i.e. load it to kernel_addr_r like the
a compressed case does, which is a separate change.

The ramdisk is relocated by the ramdisk_high logic anyway when it is in
use.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks. v2 will only change the commit message (and the guard, if you
want it), so I will keep your tag unless you object.

>
> Regards,
> Simon
