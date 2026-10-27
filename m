Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040F606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BbOAKFxd;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AdwW5yhk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iKuUTgET
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C2B80BB6;
	Tue, 27 Oct 2026 11:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCTJ4c24GpAu; Tue, 27 Oct 2026 11:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 567B080BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101276;
	b=aArVCRnnv+eJZp2vTcs3LzCLHAt7UGCYTPgTBsCdN8Abbx2+eME88j+VNwfaMTyxv9lc
	 iv+1pH5Z4SVXk3CAS6zi7DK/I9M5r4uvDlfe8U5+3x2YU1m9eW8AvQDZtT7qahKMw7DFx
	 GPd0eJTIfuunssCDsAMbsg3BtiwG1/w1vVukvrr1AQtjQj9D7yPMrGUDLPIZGFYUitREv
	 AJbK5Vmo/LnWMBLL6RkGi+xzGEOOUadUVIwLqW9WTr3yxyIZJJhQXZkceN/z155bEScrE
	 +9NQA7u0MbUDrIu49IERrMuZmoXwInXrSODiHpLBQ43XZos3ui0XL6xIA898mkpeHcg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
	b=hSP9Vqj8QzN+8RYo2zHgjh/MoGJ7J6G6LxqnLhyoDDgniUpiGGusYjLAYOS5/uMzDhFr
	 Sfhk0XU7t/JIpovcbH1DQ1qu8nyhK9hCYxoMH1JOOehJKJVUqYE/f5ll4uidDNKOy9ksA
	 rBInPGPPC8QHZFlFaSrJTZVgjGXDMfGAljJCnAOZVpL6RkkK3SMTccGkfuAvRHsAyJl9h
	 BcNtUp+PA1DoXXtfYelD4lUuQ+wGcJ1/m5cAckoROX3janNNsDfwdpE2oglYHW6uvDrph
	 3MRC9efR6t7AsP6yC0gTBZfmGfMhLFhzFgTWN0GcJU6jmYcWySjG/PD0Qg5+QFKVLJQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793101276;
	bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BbOAKFxdARJLs0o9+CooBaWS1q1WtFifaxDop2J2LB1EKBlZ2PT5Fbl85l5QRWmVD
	 BYadX3zIQmMy+4RqAv5+zz+gN9n2MgcRcSAUnWrMGhczpGYNOifi1MVpa/W2VDCTM5
	 ot+x60UlNU/l9QfLB9SG2/s8K3xeXIoFZ3w2RP6R3sS/yMlQANlysUo/CdMN3NK1lf
	 SdwAPavPxm3wNoPT7erVJqywdIe6ex0ml+nZdjKjnecmKKubyey2vfMl3TclWsALGO
	 sfXkWAxpkzd/QvfSuncXXLRKGjBM30f6mxlq1lrqhdGMfKvcN0mUb5XgfayUXdLX/y
	 e1A/mxWWOSSMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 567B080BB8;
	Tue, 27 Oct 2026 11:41:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43093120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2916040689
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S678G5HkoLxg for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 11:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 582B540664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101274;
 b=sxgLkxwPGuRUEVpAVfkOh6RzBxLmAoy6Xl5BhtPEZTPsHWKDcIgRq/LIqjHxI62j4AR2
 6E7MKXEpgSedNEsVoyydjKzhbY7B82lqGY6VlgiZxzmOHwNDXpTwVVT6NeEffjswPrWG2
 C421IlIqwmk8Tbp///3sR/nCctjqjxXdCKfR96L08NYtsg/4IamRCWtdHYC92J04lzBmM
 R4ZOrMyoWC81ARiqBF+sfkXA9PzvgVE5tRCSh6bDT60BdX5460mTiFL0Bwura0kn3pdcv
 GPsGGLeREhgqH4DYA+Q9vadt4xRazbnm5Shg19E0zZHiTFMKlb9mQOtpaPH7kfgElZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793101274;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
 b=YpFqb3Y8+ytCl7SxyrURYJ5ZeqYeIBOBKESmznOx/T/xB0sj+VoObCc6HkFDEl5RjqXN
 exoaXe4161rglnsIwP18iMJ9CN4hDrMNemebnVhw3yGRLzPDtKZ7jDrZjIhNcXP9JT7JQ
 4EhYKrP1w1OI+nVJwT7iPNoDdXk2eG/tHqdXtdX2xxHfb22CSonT0Rio9ewCll17nn3Fq
 GBI6EyWb2RH1u5YqLUndNArx6jVKQ1TSUQZqaIjGB1Q68gVfCA2Qa/3RpP7dnbe/rcuUc
 Ck/oP8gozDXmH+SALpaxvgfb66uTy7+xAs+o2lAS/yU5cofmsRb2q7vIoojzskb5Q5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AdwW5yhk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iKuUTgET; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=AdwW5yhk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iKuUTgET
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 582B540664
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe34H1061340
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=; b=AdwW5yhkfpESD0aO
 c8K0V8ZeSPdXEcynBOR49kOP7ob6hWldoJFt2MXoxx0cFsNyTbuVwWEVX6/9u3SN
 3TcNYv/0f9p3c2uf8TWcELL2jh4s9+spB83oEV8fDxVWInOjoRAy0bw1sGJhnUEU
 SmmSx5X5Pgj5rdcaTOkwejPerOarHlmLx3TBk3fb/oqM8BmJZcEem7NpC9sk2Tv0
 KtV1FiGe2BveSBHOAK4+KED8W0XbtXdSJzN8xaCnBvVXJNYSoc2FR5OO7CZzVYfE
 ne+0U2K9aOGvbHATChw41lECP2n+uvhL29iFHul5zr+aup1C00KzB+ufIrkGoMa4
 PU6gGw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2t9aee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:12 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-679f81e0f96so6361666d50.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101272; cv=none;
 d=google.com; s=arc-20260327;
 b=JOxIVh2iluVY/yKbOYjZf7b/f+Htxq/Zl4DOWZF0VNwWRjsA0eANEtdjZz/osVYk3d
 Q8HuooamANoMdKeo2zgiszplvfplxXFSCk+kU0WsWKT3KarzW8YSBiJDTjhefkdm0TBH
 SVf/kOT9MvZ99WtQsuAhgL+n8uEN03EvHuMPiAPd5owc+MyJDDRdUyC/uUF3jyeeISuS
 PZIeNupO4kSUYxsn2Tcq0h6Xr5Ir8/Ik8DFoHi17tsfOBSQPme3kogJSJM2+Wb2wlh2X
 pUQPIs73fqo2Az8F6U86WdKYSCFNx4bnqOb94NDYlI/OYxLDrJ0Vijl/xYtnnvm2lG7H
 ymrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
 fh=ozcRsyzXQOVznmV2Y5ZQffHLduYVb8BRSU3XG/kvNfk=;
 b=MqNpvYrkvF+/iysthrvbdw/TUCm+bc+eYuGQ2bNgYW29OvKP1n06jf1n/oj5n5WIK8
 luRh4BIxIY05etkPHp+RplCmWRlrE256+2hcbfCnKEWpTx0h33NH4os4LeHcME1xJHaE
 lS3mWonDmPB87oIcUh/jo3/V89vCR4498BZhK/tzu0gsY3hMk+Ue9LFgLgr5MXHXw1q8
 dGGegkOLSzh9OjoMhJov6hGG8eWAKbyylfyAYleN/mpXbFqJUvUbj0e1B1AUphy1bS5n
 e68Vnp4Hf97l7+Rlvi/ejwZXyFoyXZov5sH8zn4oWp5vU5gDj59kdrXWzhvF1B9tbdCf
 ZPwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793101272; x=1793706072;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
 b=iKuUTgEThD/JF5XEJ2Nc0gQNuhjCRchUD5ejaL4OKZM423y98wKn5lVjLHQNC1gg0W
 /3+IeIq0oxAdMeX6LibuxiEu/c98Jw2UBlMR/d9nOYV+aTwDJxpWApX4l8BIJ0ihINAY
 scpc47AW5Y/E+MqG2cw8e7GbKJyH/zRzDHWM+iLpyHh0hYUxUm3TCRhlUPd7AEFRvKgU
 yMOrMRyO1PDsKCgUeC7RfdWiy2zYNskWurLZJAKfr2d9nHj/kvRRq+rHHnVDLDvNRD/r
 c4R41b9CdPK+eDXJ2ij4rgVhGsmFF3W+joTTAkQXB9rbbYBUGGfRa21jmocEFGtkNneO
 E+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101272; x=1793706072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WBDjq/PaRUevEyDZuKMQvEOmYu5HVJiAdd7uEApBZIw=;
 b=K3VHbBtulRFdpT4MUivFA/bngeiuOIXSyWHIP9pbwMZ3+MQgKqyGIia32WLTKPMHxl
 OsALgHsa0j9I0XS/o9feiz2LVVX1O94xNC/2PNYrzY3xfWItFZOfH/j2gBWCKAFm+cqP
 WqaLdF+5dh5YP1514FkZVIKNbe5dbR8WAqnjPiKZeS0+qWT/lZ5TBE3gMNhHGIr7wICt
 FHU5vr66QM8Jhej24cp6tRfnhZqbFaSHsyRLk+HLXkV+zn2YCKsL7ElRDMG10aU3T0E3
 vFmr22AkyfZKXh1cKWNq+spKC0pXijNHLT+c4DPb7hqACnrCsBcL/rVW4fbO0e08TjBA
 cLFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0Svq02YSFkyBaBaROLTT0pIpVX9ETANTXVA9gqzT0SNDmXWPloeB9fTY0kqkohYkI+xeXXSk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLvqU9CDHAJSBHw6PXBsoWpgYflMrP4L2b+IRetBdHuB86vt4IM
 SPde8y0FBDome3QcPUcKNVbn3bz8eOQpTFVviNQp4dEy8+/B8E3xy3ZUpLbxiTk5ZrwKgGs07Bl
 KozZcqOLL8/7MIKLm/fWlWY35ZXJ+MP05boRzXyTDC1B9uCgqxdViNdosTmzHE6kSSfYKa32N28
 eFLMszIJcqZt9+r5IjgccReVeNAdOLItwXG1dThnEsoXF1yDyqjbwcQw==
X-Gm-Gg: AYBFou3E9qs1CPU0WcK9h8fnpas9cHrFSU9wce8j8gQP2wx7AFFI0lIAS8FWqhM/GRl
 kRa7hLbajnBKKjdXornhXOVaBPJZ3KEs23coWv030cK7b9zHkk5NKKDxyIfDLCqGwCqt5cCMs5G
 Tr9HedyLaesaWmNVwS3mqpXPELy2SHlrMlIA7B27mXZmnKZVu5EBQHRwU=
X-Received: by 2002:a05:690e:148e:b0:679:9f7f:5671 with SMTP id
 956f58d0204a3-67a6c6f0d15mr1594702d50.64.1793101271983; 
 Tue, 27 Oct 2026 04:41:11 -0700 (PDT)
X-Received: by 2002:a05:690e:148e:b0:679:9f7f:5671 with SMTP id
 956f58d0204a3-67a6c6f0d15mr1594699d50.64.1793101271566; Tue, 27 Oct 2026
 04:41:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-upstream-optee_hello_b4-v1-1-c5359b290900@oss.qualcomm.com>
In-Reply-To: <20261022-upstream-optee_hello_b4-v1-1-c5359b290900@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:40:59 +0100
X-Gm-Features: AclHuK_7lIQg3ZRnpEfK2aKzvkNqQ4orm8TDFSIQ2h1ZRIXwh4v7aKCu5B7g5o4
Message-ID: <CAPzfCAaSO11qW64NH4z2dFnmkvtQg-b0pL6=Yp5LxXdtuom82Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: optee: report TEE errors of the hello world TA
To: Jens Wiklander <jenswi@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae08dd8 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=9J0ubPpGv5C2z7OnFOYA:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: 9V4PU--aWdnhnlj37TN1u31vvEtbyoM5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX9CDbJNqUltzy
 NHP5rgl0hN7zpQbZEJtYst9Tpjw4+M4/hY3R1pjXdUJ/jfeb3+eVLICn8Qxx0pR7A6fBa8Y/1Ei
 hLkujYkP62voSTbJNsKajydCIl0o4BA=
X-Proofpoint-ORIG-GUID: 9V4PU--aWdnhnlj37TN1u31vvEtbyoM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXxTIrIiTTqHJp
 YKasQYkTtXfJnsRu7lcgKKjJ9NEp35cSgDCXs0QvmDI+PgYQ/XAKCsJpGX/19uMBXRZ4kv/JhZR
 DAMi3oaEP8GhxCjq+68wJD68srWpbFeFoReCRyw/cJhv2g5N7koso3NXI+k1fOJH01aD69N5baI
 2nJ469+qNJRLzPM4UhQo4QXdAPJ5UZxC6QTbICrtrrpUmWiPHv1PWiJq9n26uvNWSe21gdKHFLm
 M14Tutx5jbFCfJxpJ3oYo18kjxqqrzJ6VWGUZvfkVmJaMEjTMLdJzrQ4UDTc64OFDJhmcWbp4LY
 EbodTtc+BaC35rEe16mJYpaXmFPuL2tHdC+I2HBBq8fRLnUbJRQFJkC0FuIk0HEW679ERlA40Kh
 ThAz5WDrcnvRNVIS7h02WwVvhmVpvYyaqIE++lYSyQsbpZBsr3rPaMui0Qu6gCaSRaXo0gbMmt4
 WUHUQ3XMW0UQxJ1x+PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Thu, Oct 22, 2026 at 12:37=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> tee_open_session() and tee_invoke_func() return 0 when the call reached
> OP-TEE and leave the result of the operation in arg->ret, like the TEE
> Client API. "optee hello" only checked the return value, so with a TA
> that OP-TEE could not load it printed "Value before"/"Value after" with
> the same number as if the TA had answered, hiding the failure.
>
> Check the TEE result of the open session and of the invocation, print it
> with its origin and close the session on an invocation error.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Gentle ping on this patch, let me know if you have any questions/objections=
.

Thank you!
> ---
>  cmd/optee.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/optee.c b/cmd/optee.c
> index 155c9f1bb73..2cbc345973e 100644
> --- a/cmd/optee.c
> +++ b/cmd/optee.c
> @@ -34,6 +34,11 @@ static int hello_world_ta(unsigned int value)
>                 printf("tee_open_session(): failed(%d)\n", rc);
>                 return rc;
>         }
> +       if (session_arg.ret) {
> +               printf("tee_open_session(): TEE error 0x%x (origin %u)\n"=
,
> +                      session_arg.ret, session_arg.ret_origin);
> +               return -EIO;
> +       }
>
>         arg.func =3D TA_HELLO_WORLD_CMD_INC_VALUE;
>         arg.session =3D session_arg.session;
> @@ -43,7 +48,13 @@ static int hello_world_ta(unsigned int value)
>
>         printf("Value before: 0x%x\n", (int)param[0].u.value.a);
>         printf("Calling TA\n");
> -       tee_invoke_func(tee, &arg, 1, param);
> +       rc =3D tee_invoke_func(tee, &arg, 1, param);
> +       if (rc || arg.ret) {
> +               printf("tee_invoke_func(): failed(%d), TEE error 0x%x (or=
igin %u)\n",
> +                      rc, arg.ret, arg.ret_origin);
> +               tee_close_session(tee, session_arg.session);
> +               return rc ? rc : -EIO;
> +       }
>
>         printf("Value after: 0x%x\n", (int)param[0].u.value.a);
>         return tee_close_session(tee, session_arg.session);
>
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261022-upstream-optee_hello_b4-9c41e7b2d8f3
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
