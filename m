Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAAFCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 06:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EB5480F65;
	Mon, 19 Oct 2026 06:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29qKc2iZZzlr; Mon, 19 Oct 2026 06:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC91D80F51
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392678;
	b=bu1YEyZ4W9WpPmfd3wJHmvvsNMsjZPHKdCH1Zb82w8Fpd5o+GHFonFSjqdfSzhVvpGMx
	 +cdybJum5ZBBiZiQp9czHDB8/UgiphxIsEQEsECErRrdcIv5yz/tvTd9QeX7AYkseeKoN
	 qN00L5LWVGq48+HxgWsKSYmzjd97pYAOafP6fwIAWr6aUIpiiWrQDBWlOnKSCivn65CmB
	 k5MrxCid3uRW+pjHocP+TwsoYflLBFEVvMQU0jCIS953HxzDZTPbr0DjEHU1stlUquEIo
	 XkCA0VE61UIJl62yJ9g2U0fVK0Leebw3LdsaSnERfcemaovLkOe6Hi/4SEqASWANIUQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792392678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
	b=qMdwWcp8oUFZUGk4C/nGrf9blmAnPC+RHfuzFXVNKF40FpqFx+ljiGDAZeldAsBAIsL7
	 8/W16G3OGMoiOR2BLGIQsVvk9puw7WZGW8zTEG5JMwq6FFDa/ZxWq5XPQqaAvRgRFIZyc
	 gW3NUWk9zyYXNuRSCg0maT2xtvDaQVLOntTuBAjKP54jR2tcpzgPPGqkGSY7wYIp+LzFu
	 DNpF5sURt43r7ITID1WaCKIpNnG9tNUawe1I/IdjsbO8JCXA0NeCtF+D1yDLrp60SK7ng
	 zn+qU9W4c03F1Cidw5rl0312eRyfzd/xnoH3RTAmFdJd5G1/y+f1OOgBES5CECv+umQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c4WrNLzp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EA1bAgs2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792392678;
	bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rH7ghOOmuhz8zDMPzOh6gWXCdn0HhJeF/08QIVN/zOdtV9Vqu7kD4OdIDaNTizdbq
	 mahwbaBe1lpm+dzj4864pyp8eEXhGiwloaDRlpK/8O03/IZeAeMNIyEKDsJAHiQ78K
	 FB2wcr+06cJQXp4aQrdP2+sgGg7r+jkl0/1NAbJYzBu4CkC0QmxLK4sxI5k1A55hTk
	 cn69lphOLEKC5veoeDRnIuREjsQpWKS8GrK+Vi0oiJM7i/bmRF42DUSZBP+Qr26GRt
	 o3+bRQkj+N8v02Qt2T8eYzPGyOn5v8XOYjB/GzShIl41e9ndkXu1vneT31X/3juHSf
	 blCIIdS+HK3ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC91D80F51;
	Mon, 19 Oct 2026 06:51:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 312741DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1751C80F51
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miwyID62UAfm for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 06:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBFE580F2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392674;
 b=Y27v6gQfXAJFL6QaVYZKkf+6JxGJsaRyPf8XfFhZgHdOoGtfP5NPYsuH3kGwyXVexbhR
 Fy7u6PHhtzSdkl+OE+CrkhnvKldKYlvmM1Nz+88eamEaa3xvhnY1R0O9heeNHLwMOAO51
 zHSU2LS/rH0A9GvgFA89dD28IMfLhbQHLdEhZOI6/+WRI3NJhFmgZH0sccKqM8ndyTxS9
 590ggiucUiQ+k0qjxeKOa9r6nk23b2WqXkiKIc+ZNvOWQ/SXIHu6kz3dmascGTsf3udJN
 npksmyA1gNI8UL1KFvirVxFvgd7rTLYFffd0B/63DcTp/tKERJGDSOIHSvbxhNds91Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792392674;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
 b=ikxslejI0a6a3yP9rY7Uyvhy3Q3aeJaJFDdqa7mfprWS/q8sBQKU6j65+2I+kWXrFopB
 /MzrSldQc8j6b8D3Pxjk7oFX2ixQ4giVKwlxickuqhKnFVLkselo9vmevmknD1rTqF44n
 mFPlgMrlfRjuzPeZ28PbfM9h9MQBWO/f0v8uY2Km1uCzLETxMplNTm2qS45xdB5uIp76M
 JfzVYzVfy8aML4lT7STFhOmMD4+bWAfDHsWlCiKpQO6/6HZeBuwEWEC/+GjR4c8DRkUj4
 gj3qNKFWkrqbq/245UppYbqz3TK/AJGu+6Z+d6NmGYEVL9TXHhq6wN1xkXmaSwqUc4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=c4WrNLzp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EA1bAgs2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c4WrNLzp; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EA1bAgs2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBFE580F2C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jDaT240196
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=; b=c4WrNLzpe9rtnSaK
 5Evf22NndPj0q0Q3Zoy83X+M1se7E/GMhOfuKfTRe66mUD6DQwwUkc7s9gKiukgz
 yGWhDZFIofyRQVbhkUODnn4HL4xoOSM6TI2psn/DO13aRfpORkXa5Bz1EEs4g8DN
 LXQSgk1GreCN8v/nU/kb9Kooseu1Lhtla4w0SSD8fa7iiCuAOfzQ0zRGkpq+5jYS
 Us31zQ+U29gMGo/KAkSMdTPq+RKrg4+earualSwTyLVxQ6YQC6vFqw+DI8SUxljN
 7ieJ8lcW+mnBt6KbbtWFt4SRjt4SvVFA40dzyQRqkqrywt9ZLt1R8y7U6nMHhCiW
 69VuHw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k55j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:51:10 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-679b96a1e29so2012950d50.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792392670; cv=none;
 d=google.com; s=arc-20260327;
 b=NMTWAcxPd1Nvr0SvOctt5z3isPxpDc2mKDbi+2VHhjoG82WsIkwDcFIMqdwOSG4dwx
 Elu94Bodgd83XOrcmQNXFclhxEvtSZtFIGOuo6D1lpMu2cV2Qh3d5dSrutjTNgf3ay9V
 hh+0JMkxzSsDiw5OjbYdQXSJa2Gbzx4ZPDNbk+isfZQ6x2fSbo2ZIqDX7wm/qo45eEsj
 U9MusfN4vi0y3D9Pq6hkLEDrqe9b4lBpDzpAkjl+jkzpbGB8EFw8C2AxZBr3BXMRxpZG
 NGru5mTXn+OBSB/puw5KB7nCqrxVMrzLfM4K4F4oPz5C3BzAnVks9KizzYbf7d29me+q
 uKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
 fh=pBRra0r6CeJ5jlhn1q0lLPxUOQUkbGO9Jc2Ec8hYJ/8=;
 b=O28bxn+72b4qZu+oNHl3MIx2Npn23MDvln3IT9Sg7pmwE87K5zea18jOu+UVcB5/j+
 4WAbVx9u+uWWUP7cIumQo9nWKS5Nw5kvTE78lPpIR0M/2+0ZM6Mr7hGL+ijNiW5eEvOt
 1Umq/tGKbmJwrrVNeIltEJPSTNm5GdDxZ61Sy+gJr9wqB8MJZGG8Bdv9ChrmrDz5ITy5
 06LnFWnV0L3NsqjHboabuDlNeTv/h4M7dIDYwt1M+Q8KBTtG61YKc128yWui4HcSCtMY
 nGEPjDJIR66asYWVA8eAsoDOn4rZ8nlYENGBan8Cz0FS/MmUiX7CRMxMsJKdfmPI2KWx
 bZ3g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792392670; x=1792997470;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
 b=EA1bAgs2dRDD73BDusopFYtlxDXgC3FdkF9dLg5pnsXovdDjQJO9CBSSK4xn2zdima
 wRS69pH54EK2DxwKSCVF5CcCX88/MdomWPIt3XvTX0McFOox224cWMRIIw8swaWm8zkD
 16FRWO1h+DsU+5Uu1Ct/7bCy1ieD7wnObYtRCI/dIa5PkYepPid46DwHPy3fHWmSWvuE
 eyPTTjL39dwo7bhjGYwVwREgKwKy0GmSsj3ZkosjiZnOXUqlTLBtoVfjKxvoE2AKakSo
 XF847PJUxUq4LbHPJaz17vDKooAz+KOuhKDuQze2/clDwNpU9+YOzOIA1zgd4cYDojZE
 9DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792392670; x=1792997470;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LyWZFoyLye5hhdAhyJj2+HyZsygooChjGVtl6T0DO8M=;
 b=IIms8Ev0PEkAyCdT+w44m4FLQfweOPcuhAHYK8vF/JGtKZ8qlQqd1ZnFSFHyXgHDJg
 SRrF6VVqQjHxsPJUeMNfphYF4eVrwgiIq6ESldnI3gMEpkQEz00Fgz3LKhG7DjgLGWQ0
 2yp/DGdyx7mOeaFEwMG3XV/hK1+VZAM24bCSSdAFXS/JxlfCz55oP2dwhKkEfk3b99JZ
 cvpw87M5kOYnZC48YBaTyY7Cjpr82uTGAqo64n25fcRF7FTLfJv9gFFh4iXgI5xGXdWK
 X95DxTQ35iR5auabfx1Z2lzNbXz3lk/gn4w46nuHUPtcQ+0MhyBm6KK/J8xK8HBd3ozP
 96SQ==
X-Gm-Message-State: AFq9FYJhpgf1coiluFLaWso3A4zNIpGPsDgVxOT1Cy05HoEYC7lGsIWN
 hFAW79JPXaJtUYshCSledirNTgX4r0UWAypdfl8B8Ofmp5E5cw1EGHHZvxDfVy2XQgFZyWZCaKQ
 XsjHiCL6sb5K1BErMtqAnGJB3wae2AlFGi7ueC1ngv1O5rWh7/OP2Ygep76uGfjQ6Us2rKsLDjv
 ZBiUxtKBvTHD+FL/uuUxcnTC3SX0/+tnhgPK3zP4sFhaZjwKAIq/UoTuFl
X-Gm-Gg: AYBFou2hP+qA0z4uwecEhffHkjXPFjfv//SKK/lYU1bGuRinBDH47oHlZXZlZFZ1X92
 7QtaMp5gTDLrXvHvYjnEC4zG7hGL+uAjxn4uEpQW9HD6AY+ob0Ms/rthLKDNJfKZSmHu5Lq3e2A
 53zi+Yefhdt8dWArJ/G6582F83WgAiMh07J8W+K1F6jDFMZ2naFniIE1uJeQ==
X-Received: by 2002:a05:690e:1486:b0:679:985a:3fc3 with SMTP id
 956f58d0204a3-679ca8c48f0mr2586166d50.85.1792392669744; 
 Sun, 18 Oct 2026 23:51:09 -0700 (PDT)
X-Received: by 2002:a05:690e:1486:b0:679:985a:3fc3 with SMTP id
 956f58d0204a3-679ca8c48f0mr2586157d50.85.1792392669262; Sun, 18 Oct 2026
 23:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:50:58 +0200
X-Gm-Features: AclHuK94UWxiunXVlaMiNqKeWM6ianGNmAQMFCTMg8Sd6lbucfW3_eDMVuAxXeU
Message-ID: <CAPzfCAbt5sOVa2pG=LOGbhx0aSJ9UegKdGK5VW0ORkEy737Omg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNyBTYWx0ZWRfX4yjQWpNLmGue
 ZpTyEetknjTuBg1+TCW/AQNrPncwTDuLDeFSjxmjSuJJRR/9RHm4Xdbql3GnL9OAt6eZpvl2KDW
 j6fLLyEOOhpz/jAD0V5t5ypYGiifBW6P5G4EFj5XjVo8Q8IQnJwAJVN7p4QNBNYs7Nj8jCTWBIu
 23AJEh9HQm2ZpuEyuqUce70IH/M3kl36b7so6u9Uvx3c6UfZQODXVkCj+vseJW3XXN3e0FM7vjI
 059ZNEStjAA6uc9/nUPVvL26ohGIh942YkRegtCvvSImLfsPH5P/0zFVsRjRmOkOTq1Icm2Uv8g
 Jg/zgASnUPjxdsp7o5Z+wz1e8QF6F+v46w+JP5w2F5tfuyog9X4j562LNPbYOP9G5qmgs1YetkV
 QiRkB66Iwf0i8VX9z3RvA4UT5eUL7L/x0Dge4755aNayNIz8o6hOaB9MH69D96hAUvtCCw5izc2
 e7rdOudqNhmlBbWQ+5Q==
X-Proofpoint-GUID: UCu8L7H2bx8Cm8KcEFUXxlZEr7nXhL6a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNyBTYWx0ZWRfXxen6ai7OchfS
 Q7Wa1NyL5Zv5vFHVhx2JsDLv55+5wFjmJDq554sKrDIQ7/fnpWvWBI/cH2v3MFmyliHorhjld8F
 4PqZGn8iMbyEdxbHbujIZ4xptCtmCWU=
X-Proofpoint-ORIG-GUID: UCu8L7H2bx8Cm8KcEFUXxlZEr7nXhL6a
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5bdde cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=oXbUKOD6SgNmpOQbbXsA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190027
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

On Mon, Oct 12, 2026 at 9:56=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> When U-Boot serves OP-TEE's RPMB requests itself (CONFIG_SUPPORT_EMMC_RPM=
B,
> drivers/tee/optee/rpmb.c), two problems show up as soon as a TA uses RPMB
> secure storage while other code is using the same eMMC. Both were found
> running the OP-TEE AVB TA from the Android bootmeth on QEMU virt with
> QEMU's eMMC/RPMB model, but neither is specific to QEMU.
>
> The first patch makes the supplicant select the RPMB hardware partition
> around every data request and restore the previously selected partition
> afterwards. It used to switch to RPMB on first use and switch back only
> when the OP-TEE session was released, so between two RPMB requests other
> users of the device (libavb reading partitions, the bootmeth loading
> boot images) switched the eMMC back to the user area, and the next RPMB
> frames were routed to whatever partition was selected at the time,
> ending in status timeouts and I/O errors.
>
> The second patch stops optee_rpmb_available() from announcing the RPMB
> device while a supplicant RPC is being serviced. When the first eMMC
> initialisation is triggered by an RPMB request, OP-TEE is blocked in that
> RPC holding its RPMB mutex; the announcement opens a nested session and
> OP-TEE's second thread spins on the mutex forever, since U-Boot has no
> notification support to put it to sleep.
>
> Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
> with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
> writes rollback indexes and the lock state while libavb verifies a
> vbmeta chain, and a TA call that is the first eMMC access after reset
> no longer hangs.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Changes in v2:
> - track the supplicant request inside optee_suppl_cmd() instead of
>   handle_rpc(), and use a local variable for the private data in
>   optee_rpmb_available() (Jan Kiszka)
> - explain in the commit message of patch 2 how the hang is triggered,
>   which TAs reproduce it, and why Linux does not need the check
> - Link to v1: https://patch.msgid.link/20261011-upstream-optee_rpmb_b4-v1=
-0-7c63edca4b92@oss.qualcomm.com
>
> ---
> Igor Opaniuk (2):
>       optee: rpmb: select the RPMB partition per request
>       optee: do not announce RPMB from within a supplicant RPC
>
>  drivers/tee/optee/optee_private.h |  2 ++
>  drivers/tee/optee/rpmb.c          | 72 ++++++++++++++++++++++++++++-----=
------
>  drivers/tee/optee/supplicant.c    |  4 +++
>  3 files changed, 58 insertions(+), 20 deletions(-)
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>

Gentle ping on this patch series. Please let me know if anyone has any
feedback or
objections.
