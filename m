Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC38606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kzEFh7w3;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9Hm414n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e3oD/SuG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADE8E81303;
	Fri, 23 Oct 2026 15:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8dsp0u0d5Qk; Fri, 23 Oct 2026 15:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AAC7812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768317;
	b=Xf7shMmR2K51wQNyaDxQliFT01TNsEm8lJshmAhM6RjapKn7NWRw620V+6DUBdhcdt5S
	 KdkczOGQxXnJ2X+bQH4PczLaXY1umB+T3we8JHiZ2qr4mMVgTY74sYACQxW6US+0IGJfx
	 +1j/tTTBxxXlQTGAs1xC7yCee249pFtTS/IduJ7iwqejmVDgZx4KnQxfo/hWlKGrt522t
	 YO3EoEFSpZReKPWVSSu2ZXdus6+PghPEASl+uGzVfr+r2py3Ml4Ai15vJUWnA2AWntw3K
	 LhkCy7/Vlpu2PVgiT5KoR+egfAxeMA+qNOhrKnSV4R3cNSQG+y75h71NPXOCcidWbFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g/YaPA0RhmeOWNkV0ksuNQkohNON2IlcJbs1U6AUkfk=;
	b=kZCSpsCgWWLn7/q5+D8L6x+sRWRk417xf6GXdF1C8yfjHu75WjmztCLH7PD0AZx2FmvD
	 7/147Ci7RydAb4w2NfV3jGsCRSXJ3XibEXIv4Mz3cXYZiUJHv03sPhA2qVLl1KxXWZePo
	 qtHUvg6IE719AEKHBZ7obEQPp9e0Coj3W2Edv4qehIENYOFEixOXZL31t22Ni7cdIGXMp
	 ulMrKKbpEtoV7N0wVSL50BC3oCITS/bgsngso0iYb5vw66/+UM+03ZRx5+YS5zMuBMmVe
	 PHOyh5szM5JA8uQ9VN/yxUa0M4S8cD9ky0f/Sbzwhn4rDDSfq0Y3a27EIwBgXhi5Y/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768317;
	bh=g/YaPA0RhmeOWNkV0ksuNQkohNON2IlcJbs1U6AUkfk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kzEFh7w3kFhO9NywQANbjJ8dRyITCiasGWcQGhWnANFlz/3QS8/L3jZ5x/+6UgPWw
	 yZG85aRPsvrrOme3E2L19V7FpjPa4xadR1c8GHDkh56hkXJ7wg7U74VePc/xnnFABP
	 ScSIy9opXEpGqghiY7S63g598nWuiQO9TIj2c7i4GMywGOFSGaEt33ugu+0uX7QITw
	 meJH6tGdYgkmNzAVhQnJJ4EERqw+90NqFIYykD4KHWuOrk/FttWBe8TDZf0t+etU0M
	 McYsgcMlvTJB6eow8EEEhoWBpVAi7XoLcl90ZZuqBruleIHKrkA5FlsltARv1ZyXBf
	 yJlwJRVfBWvmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AAC7812D3;
	Fri, 23 Oct 2026 15:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 102B5235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00EC240955
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXhcgDv6YlLi for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:11:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 828B440943
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768313;
 b=KkbapxjU0j/9EBtMGxqDwUBTV6r4ZfXtTUr++fXtSKyg0yfTBjSRMVdHyl6BkVJjQTjI
 KbA/qGc+kXpNGrP7K5b8X6gAJbCkTQb7PjlxryiO/A8pHkAFiXTXi11vLaPx4PWkSyRH4
 vuX4O0PRDSXcDNltkrkoDYxnQiR0JTmMwr3I5wALrKpGjJIh3ScVk6O+R3xHDdLRUwxNF
 g4BeJLoi7lePcHGwXkBzIdWgxw7dOg+p6IKfgkBPHIdu+NbEVUNziyFUS4wzl921L9NiY
 Umphv6vThJjcd3TUgsDAYHfl6ie5vsamwSq5eI4toM3RY/feUcOrxk8Bc5w2ujnJTZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768313;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=g/YaPA0RhmeOWNkV0ksuNQkohNON2IlcJbs1U6AUkfk=;
 b=kgGQqpMcQDEHBd4cOj4eqdvSiAVAlFACqe8CngzOildR5m7La5gvRJUheZv+I38z2T+0
 ftque0w2QZZ6KhY5WHmemdggTk/vElw2aCOIcuOpXqGJQSMj38TGslGtPkVEDIFuW6N9O
 7TKd/iggRXjm0dwkq7sHWRbFw0MByB1N6/vS3J6JRYDFGfrRyZUm6sL15WtaonS6M3O2e
 ++onshMfUx/u0n26AHbVWF7Tjz/6fGl14SMCamV0NuKBOb5L9pcATGbYbxtO0V0AEccAm
 KFOgt8HLci+cqu4un6dnp5ntudVAjDPyEqBBnXo+wxN4nf6I1DHcDxJFPaJvHIeDuFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=c9Hm414n; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="e3oD/SuG"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c9Hm414n; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e3oD/SuG
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 828B440943
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6ECA1955227
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=g/YaPA0RhmeOWNkV0ksuNQ
 kohNON2IlcJbs1U6AUkfk=; b=c9Hm414n13MBfNjzGUeeTx3aUNXcjS5b2lGhJd
 3P/VmbDn0c20Kz7QctF8TLA6vdAUFXCo/3I0O0mIeb6gfTNIkDm8/secpGsFmfZx
 2wkDMOahHGW0b2ibn3or0cwNLbt2mL02WUabLRfySyNwfD3fmNwOJ9h4beYPjsnQ
 8t5zQ+xd2PEWqejJ85tRApulravLMT4LR7xUjsaS8X/EaGzWnBByQqXU8BRiCm0k
 36XRz6hIxoUHL1M5NgSdiSurefe0oHf/TkC74l8bhvIH/xWcqXvgZKXdbUD0utHx
 5SE8tnNQeddawg3M5F98hfa4HqfxsLrJfFIrliScv1wIcMPw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbm9jd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:51 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso266319241.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768310; x=1793373110;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g/YaPA0RhmeOWNkV0ksuNQkohNON2IlcJbs1U6AUkfk=;
 b=e3oD/SuGBFu4Z0X2wJn7JfkhqPJaSyRlPaApWZ+lfVTUXtT6X2yWQOH8JbBq4L+wx8
 Yl6p+J6z1qyhRehcQaKxsu2Xtgt9kEvT7ckTCa25PA0ObBMBFVqpefIhBPQFbjhzzQlp
 G6urLslQ5KOqqSCGA6tOJ2xDqAxEyhuWjODF9gZ0USo5K8Hb1rmoKuX+Z9SIB0jKE+7Z
 F1zXobr/mkoHL9udQnzoREeq68ZUCHEpEXSdfV/N9CAnbq0RgW5rCXSWENdCtvNXBnxG
 LeSECi2+UzpII4KwtA2QkWN0YzqkuFqtIOu6IHY/TsjoOS3Pky7VP6woDHpVJyaJ5aYt
 FkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768310; x=1793373110;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g/YaPA0RhmeOWNkV0ksuNQkohNON2IlcJbs1U6AUkfk=;
 b=bbY/KV1lAnwu5TBKNjpFnAzoVswD3Xx90nWJmdnZDpqWhlMCMXhFfzvaCoCRUzW46G
 VGCI8bziDBN4fPayHaYwe5KayNxNFQUvwGEuoVJOb2JCAxyu9UPp4xTV37cj4jdqNHLZ
 XLfFUojFxNzvbqw4D+gz/tG6j0lJqF5buw4xk/U5UCHyJNMNlJX4HlBx+g4J+5LPMWld
 AsdDuoBgOsF3fJlmopH2xzaNr89ZetlSuhSG/krRAOtK9S7P+T53XtwnORH3Jq9rf4Gc
 ZnKbLJPLvXXRojglzeuV9IoNU/BYwT6K4AGHwM1LRGkpJ4WUzTor4NWbb6CQWLqU6xfT
 GllA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkjznsYGnzWZIFU8/0cFKN3oqFSb8GL4dvy59+NGMegJJf/ACi0Hp9U6+roTSvEGsMA7mfXmM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK9TBTHL4x0WIyyhrmZr6TZvztUCX9jEND2G8w4MxCTyNIEAcZA
 /HkMhX2p5q9FoGQTFdJ8PWOFLDv0Rvk2x1wQLd5dDC8KnLvAaU+3wI2TKkTpXVLzT3RrVAqmLH4
 5zX1CVPl1NnnG2ZeSQbU+4b7YlzJTUyF/HegNT71Y7Yv0s+RlhMtlEd6VVfjUsKKRXZE3oso=
X-Gm-Gg: AYBFou1pFsp/iWqRMksNLWpTfIv5WnkNOZDpf7DIPqsK5DZ/rwRWILMR7J1ZH4cFiyp
 60wzFW9b4hhMCN6aKwP4yz9Z1q0P0UotFd2wcZpH7NmZoMpNVu7DV0hRNU45SgFzos3qH0EKdhJ
 iYiMpzeWmfw8jK3gUCTsCFPuJ78c8SeFLTBJQ0yit71yztR5oV17CjzVANx7znxNucHie4tmwb3
 /rSpnTS8xmKt0mll/Mu6Pda1LLSkP43vf1emLKCc5EL1gssDx0FobJPH/niEUEewLQQjzlTu9rd
 gXXk6iQkz3OthHvgQtDw6+nRHkW6agTpZW+/eCHyrYMUH2+ZuqK0ZQf9HV6nM22PbCgzfnDHG64
 RXG77ecFusoejwFVUAigRqOQxtAQAuJp6DMH/htX67g2BjBk=
X-Received: by 2002:a05:6102:570d:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7ccc33a2d26mr901353137.21.1792768310082; 
 Fri, 23 Oct 2026 08:11:50 -0700 (PDT)
X-Received: by 2002:a05:6102:570d:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7ccc33a2d26mr901325137.21.1792768309388; 
 Fri, 23 Oct 2026 08:11:49 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:48 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v5 0/5] avb: device lock state, root key provisioning and
 in-place verification
Date: Fri, 23 Oct 2026 17:11:39 +0200
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QUU/DIBAH8K+y9FkmXIGWPfk9jGkOenXVtd0Kb
 TTLvrvQmriHTX0BjsDv/rlz5mlsyWe7zTkbaW59O/SxUA+bzO2xfyXW1rHOgIMWXAg2HX0YCTu
 Gs60Og3uvpn7ZrGR1jqC1K7mpZRaF40hN+7Hozy9r7Sf7Ri4kMr2w6InZEXu3T1d1Mz1OzA5DY
 PH4TYx0mmKusDrrFzd0XRt2G24anWvIoXDpdUfe45J5t1kTA/wkbtCHZFfBHasYLEWeBROxlxL
 WGjIFuKfB++1pwkNqsY1LlpLvWx+G8XMZ0yyWHP+aSOQ5Q6mQHCrJhb7Nz3BNwu8kRLIspOYIk
 pQyd8j8igT+O5lHkqDkhVFoSndnCLO8Jv9IKSPZSAPaoQFFxQ3ycrl8ASEvu3KAAgAA
X-Change-ID: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXygq9Csibwbra
 aCk/0A3aJu9gCvuFAXMZ1snI+AVoSV4Px4CEWS8r0J+8Qg+z5Oe0ao8rQwLDmZ50oeOSDWLgWTL
 +OMaoj54ZE5Ym3kkfRNjvcIaWUjsaR0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX5Mup0HJx/Hud
 1FcWF82sKy/Bw8u8uOyJfw1HB+ik6ihYyf6YlG4AAB3hgJlEuIA6TXwJOQCmO0Y103Bp3a8VhO7
 NkooIsnfWWl4XSwu62gay+GvGkiN46vOuBr1TaBmfQbj/el7duC4gK5SploBs+NOqu6m109yrBd
 zws30vo9E1p5yz9Vy9iGQ0mIw0wycb2YkAcu1+UG3fXir5UUuBJKKu3xou64KLGvhCQN+WCIR1z
 krkC8j3EIV5O5Egl4YbZa36KKe4xs4OI+6qziCieQPUpFNjSomJ7QWaYoLK6TbAraB/2moQukvA
 Pve9rN0sJby1Pno7UHBb9b42d47U5i8E3Ng7R+0RaFFEAE5Nw4BGmNXQjfNop/ePsC3mh7dLgo2
 OaBd+/eH4dyXsA+R5OUqrWveo+rXc+hKBCc5vPRTVsmsOzDDPBEo8qCfnS8m2XVPyDm7IRPlpnw
 IN2HBlh4MAr4Um5Y8gA==
X-Proofpoint-ORIG-GUID: 92tuRQuP8ItPqxQ_qDFEJ-Pl1gVnCpkf
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb7937 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=5p_tG3gqAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=W_CgBUorZULjrePn3qgA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 92tuRQuP8ItPqxQ_qDFEJ-Pl1gVnCpkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059
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

This series completes the device state handling of the AVB 2.0
implementation when the state is kept by the OP-TEE AVB TA, and fixes
the way the Android bootmeth hands the boot images to libavb.

Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
"avb write_pvalue_hex" provision binary persistent values such as the
SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
consumes, and "avb lock"/"avb unlock" set the lock state through a new
avb_write_lock_state() helper. Until now U-Boot could only read the
lock state, so a device backed by the TA could never leave the unlocked
(orange) state.

Patch 3 makes bootmeth_android verify the boot images in the buffers it
boots them from, via AvbOps.get_preloaded_partition(), instead of
letting libavb read, hash and free its own copies and then reading the
partitions a second time for booting. This closes the TOCTOU window
reported on the list and halves the amount of data read from storage.

Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
"unlocked" variable, so the state can be changed with the Android
fastboot tool, and makes the state matter to fastboot: the commands
that change the storage or run code ("flash", "erase", "boot", the oem
commands, UCmd/ACmd) are refused while the device is locked, and
unlocking follows the "OEM unlocking" setting the way Android's
PersistentDataBlockService stores it in the frp partition (digest
checked, last byte non-zero). Both transitions erase userdata and
metadata before the state changes, as AVB requires, and are refused
when the device is already in the requested state.

Patch 5 documents the root key sources, the provisioning of the TEE
digest and the lock state in doc/android/avb2.rst.

The series is based on u-boot-dfu, which carries Jan Kehren's "avb:
Support verified boot from non-mmc storage" (avb_ops_alloc() takes the
storage interface there).

Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
17 images: the chain boots locked (green) to sys.boot_completed, a
modified kernel is refused, "fastboot flashing unlock/lock" over
"fastboot tcp" erase the partitions and flip the state reported by
"getvar unlocked" and "avb is_unlocked", flash/erase are refused while
locked, unlock is refused while the OEM unlocking byte in frp is clear,
and the sandbox AVB tests pass. Build-tested with sandbox (in tree,
per patch), sandbox64 (out of tree), khadas-vim3_android_ab, sei510 and
am57xx_evm.

The lock state is stored in RPMB by the TA; on boards where U-Boot
serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
There is no build dependency on them.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v5:
- Rebased on u-boot-dfu (Mattijs): patch 4 follows "fastboot: make
  shared configuration checks phase-aware" and uses CONFIG_IS_ENABLED()
  and CONFIG_VAL() for the flash back end checks, which removes the
  conflicts when applying it.
- Patch 4: mark boot_image() __maybe_unused. Since "fastboot: add SPL
  support" the SPL command table has no "boot" entry, so sandbox_spl
  failed with -Werror=unused-function (Mattijs).
- Jan Kehren's storage interface series is in u-boot-dfu now, so the
  series no longer lists it as a prerequisite.
- Collected Guillaume's Reviewed-by.
- Azure CI results: https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=48&view=results
- Link to v4: https://patch.msgid.link/20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com

Changes in v4:
- Patches 1-3 unchanged. Patch 4 (all from Guillaume's review):
  "boot", "oem format", "oem partconf", "oem bootbus", "oem run",
  "UCmd" and "ACmd" are refused on a locked device like flash/erase;
  the OEM unlocking check follows PersistentDataBlockService: the frp
  partition must exist on the fastboot flash device, carry a valid
  SHA-256 digest in its first 32 bytes and a non-zero last byte, and
  everything else (no frp, unreadable, bad digest, zero byte) refuses,
  so a device without frp can only be unlocked from the U-Boot shell;
  lock/unlock on a device already in that state fail without wiping
  userdata; the metadata erase is checked when the partition exists.
- Patch 5: the doc follows.
- Over "fastboot tcp", the refusal of "boot" on a locked device needs
  "net: fastboot_tcp: act on a command that succeeded, not on one that
  failed", sent separately: without it the TCP transport starts the
  downloaded image after a FAIL reply. USB and UDP are not affected.
- Link to v3: https://patch.msgid.link/20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com

Changes in v3:
- Rebased on Jan Kehren's "avb: Support verified boot from non-mmc
  storage" v3; the fastboot code calls the new two-argument
  avb_ops_alloc(UCLASS_MMC, dev).
- Patch 3 (Guillaume): drop the "if (priv->boot_addr)" check, boot is
  always loaded by then; register the vendor_boot buffer on the boot
  image header version instead of the recorded address, which was
  never initialised for header v2 images; allocate the bootmeth
  private data with calloc(). Add the Fixes: tag (Mattijs).
- Patch 4 (Mattijs): the "unlocked" getvar entry is now inside
  #if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING), like has-slot, instead
  of a NULL dispatch.
- Patch 4 (Guillaume): "flash" and "erase" are refused while the
  device is locked; the userdata/metadata wipe goes through the same
  back-end dispatch as "erase" instead of calling fastboot_mmc_erase()
  directly, so FASTBOOT_CMD_FLASHING now only depends on
  FASTBOOT_FLASH; "flashing unlock" honours get_unlock_ability, which
  reads Android's "OEM unlocking" flag from the last byte of the frp
  partition (always allowed without an frp partition). The flashing
  code has no mmc specifics left: the frp lookup and the AVB ops use
  the fastboot flash device of whichever block based back end is
  configured, and getvar "unlocked" goes through a small
  fastboot_flashing_is_unlocked() helper, so fb_getvar.c no longer
  includes avb_verify.h.
- Patch 5: document the lock enforcement and the OEM unlocking policy.
- Collected the Reviewed-by/Tested-by tags on patches 1, 2, 3 and 5.
  Patch 3 and the doc changed slightly after the review (see above),
  shout if you want the tags dropped.
- Link to v2: https://patch.msgid.link/20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com

Changes in v2:
- fastboot: guard the flashing_lock/unlock/get_unlock_ability prototypes
  with FASTBOOT_CMD_FLASHING. They were declared unconditionally while
  their definitions sit under that option, so every configuration with
  fastboot but without the flashing commands (sandbox, sei510, ...)
  failed with "declared 'static' but never defined" under -Werror. v1
  was only build-tested on configurations that enable the option; the
  sandbox CI jobs caught it. The series is now also build-tested with
  sandbox, sandbox64 (out of tree) and the arm64/arm32 boards that
  enable AVB or fastboot flashing, and the 107-column dispatch line is
  wrapped.
- Link to v1: https://patch.msgid.link/20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com

---
Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

 boot/bootmeth_android.c       |  73 +++++++--
 cmd/avb.c                     | 141 ++++++++++++++++
 common/avb_verify.c           | 102 ++++++++++++
 doc/android/avb2.rst          |  79 +++++++++
 drivers/fastboot/Kconfig      |  19 +++
 drivers/fastboot/fb_command.c | 363 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 +++
 include/avb_verify.h          |  39 +++++
 include/fastboot.h            |  14 ++
 9 files changed, 833 insertions(+), 19 deletions(-)
---
base-commit: 09f6362327c0f69e3d32d55d3b01f0f48f6d8a33
change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
prerequisite-message-id: 20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com
prerequisite-patch-id: 3be96ccc02c5eb9024ee784abcece741d1bf4ab2

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

