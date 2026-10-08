Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BC3CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA25B81208;
	Thu,  8 Oct 2026 10:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOxojGpJXFOR; Thu,  8 Oct 2026 10:32:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2AC6C811C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455527;
	b=FVvEGlJDcHxVoRcIU6bLCCwLMW8xhyTiGS2Q/A60ZHUrFFXvJngl4SfBq0h1YC07tzQJ
	 3Z0QN74nhY1NmvIIKDDKsq7tM0QYYVGOVpX/hZxfRTprWi7ElTw+RrkawbeMB3amm36B3
	 NA9ok4F4GgiSpWBF5HsadNMBUvtAZH4Ha1bp1wbuV+qNqgvcUQbtmgyYGUmv1FvP+Qzhs
	 yCGaCgn8syntJWrGwrvSwnTD5KK1lyiC6gXOYMp3JzYdGunzdsUxvfCTSRtgkfZ6Ftylh
	 6BqemNlTKwO5nm9JQB2NrfgoQZZTZzn5TH1ozalUjYsDHijxfQzc1/ZRCotb5AC7kgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
	b=HV+rImD7UcRm2eDjfNPJSDj3NTA4R8XZWftaOBHHh4JmW0W0+8P8YhhT9Ju0WSDVGAdu
	 wrdZrkeG81Mnc6Nzdninjo573S/myiMtWKljbrL8VTUGuiYw/mhmomfO7uwKYv4IADnmb
	 Yc4PHhPbNPVAjXAV4gMYk4yctPRXItUtg7bocEc0GqHk9zf1SPY0cP8Yf94B/PV+s78SX
	 Lk+lkcsglHcXXMCtuXvlFzJd1mKDn/HJbyHxuCa1joHRpyXOZ27edASalwGyHaZ0G4Acy
	 S6il0HD9LAYEjnUjiKB6JWRt03egEuHp6yytFpOMPhIzBVqe69S6y/v+PX7Su8WbhHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EHBi4amv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbIOQT+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455527;
	bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L8QcLS34zcmnOidA/1WSly2R3r9Z40+cunULEtg+EwzlZDA/hrVZu58C6NhzvG5GG
	 QV0o3IClxae9P/Ajcr/wK+VIOrtgbP+ZbvOUCQBiGS1V5O0vmONS523+0tCwNYKd/e
	 1G8cFmi8q50AbLbS8GOOaKJY5NjOpVPeRs8yirLOlM0hFm0mmSPFitOCwcEvluDASV
	 Rx2vLfc7V9JXauOA+MJWz/i0MCUjCjjBDzbsGlFUUBo3Jtr0sFs06XOLVsr1Q+Ic2t
	 WDgWTxPJV6B693xD07pqrvEwKPhkJROEg+AhNtdIhrHYBhIGWp2wwL/2WS5eCkOHvj
	 ESIBCPKjIfwig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AC6C811C8;
	Thu,  8 Oct 2026 10:32:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24CB72B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09F77811C8
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kT1db0KTaK33 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6481E810F9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791455525;
 b=ceAf5v5rsRqVJkUjN4IKE2OO5ENuRwLcJdvTqB4TfGVnra4Anwl1cxxCPXyv4ZiFJiv1
 AlBZPKeZ9GbiW3iToqrcxBtQm6+Fc3CKPJ9xJy1zlYlqieegp68TT+G0c3gqesk08nedI
 rJFkBzRqLpYjVUF7fXBHg4Hb/Gr4nfUZ6nK8IvXELKcgKqeTqhsS9y/6wuEDXKE/hJuu/
 qpHHCj9AVlFfdOcF4W8GYzdjv516JiFlmT63PD+QYJzhfV5gRSsoFggcZWL0hl1EFcw51
 7orO96Ifx7BysoAX8g1q9KCz2WYNCGaw05TSMLgPpNxNqgR5eNIt3dGB+IIlLi+aRQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455525;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
 b=hag7JKnFsh3dcEYyghh05nz5Vq5BFwxJNYklfBhg+0G11qQfm2B+MTjXVt8L7zExxeUY
 65xFGRcA3LQ5Z6FpQhxnvrxMZmVxaKOyDoBWB45Rxth91GA9VbaaYNHFLw3KT3AS2w3Vj
 qIUNsHLg4LFF6z1TIKDY1Cf29bl9Nlv3nz4Fv6PYaAA32yNr0lfr8PbEJj0pyM2m84EvD
 78aadKf512s4eGc159ZMm9hnqtk6zEcdqa+r1qpVINpD/5gh7Wa8IrS1ZnzuPFphoO1Vq
 V+8ASf37X99l9OUTekxKx7UaXzYjbr+hDeRiODJhXnt9Mp5F1VqL3jjw9G8Hwj+O/+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EHBi4amv; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AbIOQT+P; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EHBi4amv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AbIOQT+P
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6481E810F9
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K2Xg3190804
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 10:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7
 C3wNsVfY=; b=EHBi4amv33WJvg6S4EXbRobNzXf8mx/jiE/kHh/Gx7fbQV7Atwg
 pvlAPb9HVzz3OOcFzHcBsCrixDauQ0GIzTgXi7wAAMbjNgPkNs7+Fj8hs1v5ASaz
 TKpeYtN7pc045Lu5Pg/VVpSy4/KtXgEnxQC4dGad3xiaOZ1RZHstTRHQe6sjE7J2
 bjdzR5vvdNAq9m+XIrwWQEPDc4FaX/hcaa6/jyGKVRvzX9epOtYv5EvEXZVrdYq0
 R73TxSkTyLAB/PeTTfvhzmtvdF2J70Oa8LDHMvwXLwyLmeeHF1S/Ia0dIy7zpjrJ
 1JFHLqBwEEWPnEcH5xqf6luhBId8tYW66tA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe6agt2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 10:32:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510562ef98so7005501eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791455523; x=1792060323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
 b=AbIOQT+PN3MhrgSZXiTCnQNzU+tGXIaton7CuWBPgZFZ2b55HKcxNG9EVPGE6L6dsB
 55638YcET0vLhSW0M+bxZxxlYpDWUiM57Z2KIRhdISvKp5L1fGh3APWoEwLQ0kcNRU2t
 4RX246AqcBYVdRKW8kCt5sGSpfD8FnrRDGkmReZkxOAg5Nset1+FV84Vgg25thcBUhfa
 BA2x7344uoz1x7IJ4cUpuFk/qmYxL1YNZdk9VgCJ/58cw1MH+FU8PV1QNWrwZaBSlcFK
 x+x17BmPhVtg+lMjXm4aWXQKbyJsOPLDmcP9Y7ZbRpIxfBDL0RsFqllpmlj+OZes2nFi
 Dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455523; x=1792060323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
 b=oHVzOIHLPYJXE2BTA/xgiFPIEgUnTMcvV7kc6tLWl+1aZtxJDJQ987WInkhbJYMlo3
 VXzL215Il50BFioRrx2wJZUY+h/V/61Ab009jfONhcz4VCX4exreO65S5Aj4pAdg8ond
 eJsZVKTXdt6cOprSpkEnxHh1vWSxCRk/ZmjmvtwjSBGMXsd2cN97LxE1BcTzY1D34rym
 TUM/g5wS4ReGNmHJoADnVdztxF8rbFJTFYW4mkTFhT8OhWbKCPD3WI7kQNKAUUorim3u
 Bd6MyP4Xd37QDu9HiSpDcIWid/hsO3J3zeqILXvsGy9pth+Dl2N2ZDsroo+PN9GIgBeW
 peJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByy4JxJYo7K7z3MCwLK7+jbtpODyJL9stC6X/cPK2a5AJJRBRwPHM++KQA43CaRwIJ0AjS9Hco=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mV5e+cBxB733e60HYg1IeRgVRYNotI6IDZG6S5Xy20GQvfxIlJ
 zQEnF6dxl+n91jLO+gX5D53C8s2B0DR+lilM+anklRPkrxlVl4YYOlo1IIX922mSmbmlpNcWuQu
 SAz7HwE1U1eTR3PkHuP0CMuE5BRpdKlJ+IrEYJH6jxiDYu0tBaA9MRvTwVGCgOcM3goAHJb0=
X-Gm-Gg: AYBFou36sbHiXLqO7vKvxW2l+ekQ2RoNlGOQ+NR7JFp4hEMbhSUgBbjTG3FAwvW4q+E
 jjEK/c+F5AlM75DUPGPo1iOr3SrNrg3kxoFE7P2RnSNSwWON4LMK4j7gmjeGQPntR8qQGbDCnen
 LYOWS+QhkjlV/xFzdD2xMPTGuSkRu91EuSeRZoGjkjXPKMGmB6bm4rGdFsWvL9DrumNfGbbPC0H
 JSnGxW43VP2DVlFEiS0uamzwMkvAMzdz+A/AGvZFiA5mF/axm5mMr+MOLCI1ttm8aTA29CmrBZn
 La45BXllq0ylXXsbybh0vnvCZCD8zNrN4VzJ5SeoojDoT7jcbi3HLP02/7iqKpcGrkd6IzMCgE2
 RmN9fDr/yRD5RGVzmvbbNYhASf7z6jPRQI64DSpGeE5QQOQhlWa8SDNSgANnJx9/ONuckgM3I0j
 y6bMvvhFLBLlLLJAwCWJo=
X-Received: by 2002:a05:7022:4381:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-16206f07244mr9231406c88.32.1791455523112; 
 Thu, 08 Oct 2026 03:32:03 -0700 (PDT)
X-Received: by 2002:a05:7022:4381:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-16206f07244mr9230994c88.32.1791455520047; 
 Thu, 08 Oct 2026 03:32:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16352800ed6sm10045156c88.9.2026.10.08.03.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:31:59 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, nathbappai@gmail.com,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1 0/2] qcom: Enable CONFIG_SKIP_EARLY_DM for Faster
 Boot
Date: Thu,  8 Oct 2026 16:01:44 +0530
Message-Id: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6U915N-swBp-F6gxr6v6aM42oB4hsxxS
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac77123 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NTirQ9JaotmcfQ2UD4wA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 6U915N-swBp-F6gxr6v6aM42oB4hsxxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX1jCgoJJK1/Yr
 nHQL3B0F74u8BUdvw059/HNN3PEGs3nAib49QY6fUq4nvMZEeKhKPurbOdSR6cq88Vu8cKz8VNs
 L2AMonqboU/d3o8k6olJ2vhpmeBXTDFAlpXmJUfAS+PyMwT4CipYWYgIhti0YH3Nupz6yMxlMKV
 dyuOjZj3P5XBbPpfcNYkZabOLxCugasEwTpgmUDJ0Bcxk2IyJk91HNysc92UZtM1D/K5LAErLCF
 KyyCdYP0ZcFJKAwldXZ5dSobpW0S/yitMY24aT/WjK/IREgwTFs3zw/JF/R76WbFkbpEuNVW21B
 t4ooRtfbgplbPVkrO3HLxvMY2MpphAieOflEgrb7SIHKaYPnZudV5Lfl7gXeTOZ7pFj/IFGdLwj
 n9RMDbtiEqSKKBhsFlYKsmnlxP6mFB5y6mqtRJsCGUHHTbCWzg8/KOTbANICXkT5UFbp+KkjIOB
 bAyqUs7PaHnZKg3sVLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX1BH+dL/9OqGh
 kKIjiStdlxUBWsl8S5I9XsoNmZrvm6G1isVniEgpWuVBQaQks97XK4X3y04FvYI9fHNqSaWmjho
 /DYVF7LcqnAx6APjDBOzNzDGQGj+aCw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080041
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

Enable CONFIG_SKIP_EARLY_DM on Qualcomm platforms to improve
boot time by approximately 50%. Address a serial driver
crash seen with CONFIG_SKIP_EARLY_DM enabled by properly
handling error pointers returned from clock operations
during early boot.

Aswin Murugan (2):
  configs: qcom_defconfig: Enable CONFIG_SKIP_EARLY_DM
  serial: msm_geni: Fix clock enable on error pointer

 configs/qcom_defconfig           | 1 +
 drivers/serial/serial_msm_geni.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

