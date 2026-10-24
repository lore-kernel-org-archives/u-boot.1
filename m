Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E458606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HP4cFkN+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mL5XRJ2y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTomq/kF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 048EB81670;
	Sat, 24 Oct 2026 17:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g7Kh6ZcP7eBK; Sat, 24 Oct 2026 17:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E6B9816DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863513;
	b=m/CDj10bkiMLZeVZX1LYlvY7O35SkfB0U+28F0TN+c6DM92H9ZKjMlEvGTflOF92xpn8
	 F0R0zn1//KtlM4/EcZqXvagFvHTUsT5v20XFwg7Nz9WwX56ETob7LJSXt+ozSf4r1E6X0
	 ZuOFhXKxFlk0Yd1eLF+LzJdFWOoXEJ3w4G9Wx5CdWpcfjS9Auz2WfVQZIKMqc8gta8ZN1
	 T1G0GqqyYkmgi2vrIQv/eCNDIjMG2FNgD312YH/wHF05yohUGtF9c6qchWoqmCHqwIJTg
	 Chvmsj0j0VGnZQRFBX5/8p5N0/VkOCBNXsNNSabAd4CJyB7JRfFQCl7qTSbI7q6M2qQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
	b=j93T5vLGFKREvbcx8Frt2qcbPCgMIjU6rerJ5+yKlzVYifkMJnCIUiMv74CJdpl9cXPx
	 UYkzJrqXffcPitpEvrf3G5Z/47l5RH99EBp5jLb4AZQaMfvpWybK6azpmUZG6fHv+HEoe
	 9OD9AKbszT85mYldW9UFLfpR/Qa+BTOlQ2WkhAybbZMoz5k1GobrY9L2JKq4wkr/eNojp
	 PQUwj7XaodbGSMBC3X/696NFjNslA7XGV6TTb8UN4G+vB14nuFQVwCRjkvkn9gzzhvKm8
	 oy97xBAP4kZf6MKLioD++JXDjuuvcA6FCiXXX8oMnha82OlERSm4qcVBUCcJvaiPfjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863513;
	bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HP4cFkN+pv7as/Db7eWOnG79uHORCbpNCBIw9VCuPH63PHWWA6Q/11AODEFXr5YXN
	 8x2Xy1j0ygAC07p+CBlmMPrcy2szVIlozqEV/ER1Rej0dNH7KSosF7TRWjfWowaGVC
	 UcpXMF01J42MARcNUk/aO9+WsfLW7wh4IGlaSJ1eKJJ4VF4tIoJTv2gtFf21yFB8Fb
	 ItyvTHi2DCpcNEiLyNCSMMxAbTTIsLqY32dJ+9LmQ2aMI2w+y9cFMEC4NX+uV18a58
	 J4yjBtBJ1gkmDT1q7G7eXMJ4uRX07e2Gljc4PpzCm6PjqJIqRdj7THUNN47x9Wc5ra
	 Vk8bWCMD9HCPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E6B9816DF;
	Sat, 24 Oct 2026 17:38:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ACF2F43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EC6960640
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCR9Cr3LGoB7 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F1F26062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863511;
 b=knZpOnbRJKzo+AkXKeavYGgkUKfjvOoih4FAE2NF6XI9MS6L7v6LTZKk51vK2Ium3sVu
 N+UpgPVVDILJKsP16N+leMiv1nexOjrOM5ld65xK3V2mJ+eYtJM7BdvkZ3lrXx3YwaQ8h
 Z47tPTXZss/dBkMeUHjHyfe3rmoidIPfh9SCI2oAfZcdBTREOme3zu58GewnnI8dFV21b
 pL/tTJycV5yGGAOyENCECpwucuQSuj/jAtFSJE6+gMlhGhammuHT5sdA3KsjvGyO8z0rz
 kDRbyI7jpYBK3TaBRyUv5TD0SPHOi6yafWaVsuL/cn73hz+64mlvgKR7/SudGWX+elA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863511;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=Jg/19SdOmJJX79CHWTvAWRcLhKPMFnSz09rDyut5N0B2R94/RofF5RX5MQpCzPIa4tBu
 i2GlWNIEbC9YkWDXMut7SsP1Gf8wl25sDav7r3pZ6U4v/Jb0TV0hNvRZv/4RN6SSkj6xx
 QSrPgToxq89XBygL9cMulZwPdQYxfMUfnZkFe6PwRf9iVlWRGM+i7dULY2ainUFOB+RM9
 rfvDkS8nKe+pjgB4YmXM0dsGZKrZXfZnhCtuxaVEzf79xarjOReV9GJR4EhbRMAx5wGWK
 5lw6VFzB7RePoieSPGNhzDLXH6GFDlLafaQYEBJ+ivMq5sO1ouVGaWC3GgbV2lbQZVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mL5XRJ2y; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="NTomq/kF"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mL5XRJ2y; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NTomq/kF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F1F26062C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExqtE1353385
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KdZW2sS1n6n
 C7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=; b=mL5XRJ2yTNjH52+siDEX9A6F7Bj
 mV34/TNDAs6dgjzrno9tVvLmCFpGmt3QHBDAGFormUxB+SDPEmHPExl15xG7wuMP
 NLI2R7wLaBCeEYl+WNYiJxkBVmGtiNlz1tkxMy6BRAhD/tBe7ToA9oWdSi5cAXzj
 mIJZFJqi7bVC+LZrgsiwDLoMD4nnwuVTkuVBhHrLoeG29oGC35/iyqEQaX9lbz7s
 Jkrv/tgFERPFRtR6A032AtyDny7YzuIdLvfMdKUnFvJAYWTGft2RnxvLO77Jnzuo
 YzcaF8Ku3AdbnXG76F6YGYIRjKRsn//wJ3+jhan0X8D6c7PELsYEVsUelHA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhcaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-186c1aae818so6198775c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863509; x=1793468309;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=NTomq/kF6G60a5X7qw0BMsHVhdu5+v+DvXX/UgJ39mSEO8tqNaZ8FBYDQOMCOlCHRS
 lq8GvIMJ4DTpSvD8y0v59SROU6cIqdQylUhaLu249oocnUsH+IM0ZMzQ1rzGRNAeF6t9
 fWxQKSb1OJ4iyiR9YUzoCqH4e7wrbEeno1c83d2Xc4aJUr+LjKwrA8B5ILqiC1u7x6dh
 2DklCcx3++v2Rb9aVKZmpQh2TOb535Ots1TzDtMRSuaukaymxVGOU9fXC3Fp/IA6wWt2
 9jhn8xV+piWW3k9oDaDTGyYmfTLWOQzCQxhvkpgKy+IrJWvpy9UnASQ7iR1lobJe5fNC
 r+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863509; x=1793468309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=pYkK6B+hhoaAqTo/2X3wppwIeNMKo3Ppao+RS7kRut+BlhY+LbXcdw9THYgZxQp3bg
 vKq6no7aHwKh3NasWGqWrUqnUUQ/S8iydXCSsMo9m12uO8PccpYjhp5+QcRimfKeQpGJ
 WCTA7iimr6erbKnJbWrnPv199rBh2zuBwC1+SV+JdUV3qt4+qPuyl3/HDLfiLxWtLh+8
 GjpTjjqUUgvRLe6ycQdakkfchMfztwCy/MUuXfUcuSlzOEJKGhyfyCt5WJskzxPUvUsS
 wpgTY+ieUJ/lPQAGdC83axQ+FXjeKxXVVhA05s1f0lYovwU8ZZc6FPFzmSVgLjqADrAS
 nvtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCPKqVvc3LzvRUj2flDQEr1AWIWSDauq3780AqtYuMX4rPOgoOWEsupf/q6tD7Cc8eLPeLjKw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLnRM+LFZr2wDwvB3LAK+d2lQcaoKyoQUHzSPZzG8MyfZ6xBTOG
 tAHzg41fg2e8p/7zjpoqc1UGt7GaQJoF835fnKswuWG9SePKohnSmbgxN45pjdlck8lWP43l/uP
 YjCI8GzQgu9q0eyyDIPUYeEBZ5+Kdda1POzginjLq91/1f3y2XzlhSZWD+7woiX4aIq5QFpk=
X-Gm-Gg: AYBFou0urpkOAP3Ul1Dksgi0vGIemLI2m9Jrv88kXSc78PsOCEYOsp8lyAHjinYQpNT
 Y+kZ7nB9JzWvj8FpkEYcnBSk7qUJC0uq/qnklBpt7SnIJLhGePlLaHgFEiZORoi7ysL3zW0DvRM
 9YXCulA6QvDJ0pTf1CKzEhQdFzbabxll/P94ZxCMOy64aQGkpYD0EKuOTZvPObF+T8yzp6FlCYn
 irk3ZODCeN6RRujmMy1DdgHdvi4I3re0gGc0v417Nq1bdPsmaYLghOpFiBuuBMZRK1OD1jXfVbN
 /ySqv2r/7YYbF54mhUHlnfwxH2VmJS2fUSy54d5y+6mQ1oZ8DpQIer6dfsqI41UMSm5JttfuBU7
 BuFx1fuFMNJnLQEsZFczKa84qafpMsrMIdsBlKWUvN4AiiG3Ho+UkwYa8lj8nYJcP31rea8WjD0
 jOQMetsW0Z2uiU2tiNzjA=
X-Received: by 2002:a05:7022:607:b0:15a:9834:73f2 with SMTP id
 a92af1059eb24-19937bb20afmr4967468c88.38.1792863509009; 
 Sat, 24 Oct 2026 10:38:29 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:15a:9834:73f2 with SMTP id
 a92af1059eb24-19937bb20afmr4967432c88.38.1792863508438; 
 Sat, 24 Oct 2026 10:38:28 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm10714248c88.6.2026.10.24.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:38:27 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, aristo.chen@canonical.com,
 jorge.ramirez@oss.qualcomm.com, smoser@brickies.net,
 ccaione@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 4/4] mach-snapdragon: rescan only newly added SCSI devices
 for capsule update
Date: Sat, 24 Oct 2026 23:07:49 +0530
Message-Id: <20261024173749.3509050-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
References: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX4UY2ECvxKjy4
 XLH3oEeDc9udlzJL77Z2OQv1wtwAACz3/tt+NlrH2p09H9v0YoOGAXvJ3P7uexHEptQiotaACzV
 K5Sg2ieZOLWCKqGTa3ciwD/ALq5Wv9U=
X-Proofpoint-ORIG-GUID: _9Fy6ChHOZirbK0MThpp2Eb_jrN_PcE7
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adced15 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Xv2cfri5XwcvWjDntoIA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/y9hw3KFljdU
 wgAkN7GVvXihsTsIEbmrWz7O36Nv6ISf8XLS95qOuBOCaajMZ0Xf4JJC9Vu1yhnAgqYddGSHatp
 oRdWyKqtf42pr08ftBjEx9O5d/2trZcxiOaZkYQ8T/sz9/FQCi5CL04S+EKUN6csvQDzbZbnEL+
 KxV0Qhwu28IhMxAdRt6Wgof8+tVInh0XePiOnO4zjzVJwtiVVlGSx0524+9lQUemc0szOxDwTNz
 5/mQusbBCQ0jFyl2FZFjdjOj3MDqyO/rRyILSOC7ghqOZbSPgTzzrq2+nJKvA9Nr/GC9KijkMwE
 3x3uUtj3RZLoJa1LqvhBChqIXRypACJFs89mjfPuJwpriOjO7U5U/jhO4ODWaaL9Rg49LXyVtII
 BLMpaGr1j3pfOZhftQoc4ZvVnzuB3AtrFdpCyA4s5nl8Dwa0FltJUmnM14vG57oRQCuWeTO63aF
 uWZf7C6KugYxZMhgSRw==
X-Proofpoint-GUID: _9Fy6ChHOZirbK0MThpp2Eb_jrN_PcE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Capsule update may miss newly attached SCSI storage when SCSI has
already been scanned earlier in boot.

Use scsi_scan_new() to detect newly added devices while avoiding
rescanning controllers that already have enumerated block devices.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/capsule_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 586682434b7..353969a3cc0 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -298,7 +298,7 @@ void qcom_configure_capsule_updates(void)
 
 	if (IS_ENABLED(CONFIG_SCSI)) {
 		/* Scan for SCSI devices */
-		ret = scsi_scan(false);
+		ret = scsi_scan_new(false);
 		if (ret) {
 			debug("Failed to scan SCSI devices: %d\n", ret);
 			return;
-- 
2.34.1

