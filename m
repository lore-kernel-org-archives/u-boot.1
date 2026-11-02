Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702F606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XQwzTD48;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1KsP+np;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qfvz7b3t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50CCC406AB;
	Mon,  2 Nov 2026 05:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5NqH7rKLtVo; Mon,  2 Nov 2026 05:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6578D40663
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598579;
	b=T3rzNq7bCEH6BVIYvpGDeb7QCHQFyz8RfE3CWjrYRawLk+i4/gLft2jz2c2huno93qbX
	 Mj41psRcwqfT7BQQOZy93y9putTCWOTIEMic0ynFbuWP+DD8aqbXfCnG7RJ3wkAc78bVZ
	 /1tMBeHkbu5fGllh5aSRMqJVTQgEPXAscO08Z0WwyOLDr3JY2vVxrsuA1mY20bDA1ZUgg
	 TSeACoiNh8Z346U9JySEi2LRzpx/GIXNMdTIwCCaf6M8ttHNULL4rYfOMzKsAeKZIsNIs
	 tEENvsLvFYIJSx6ywpYmcsgDFCt16fqTiE31nR4vjcr3LU/Ea/kpEWRp3vWgXPKC+aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	b=TecBOEKWk1Mz8S9pRMG7gycNXv26OQwrMc601LheKrmM/1b/ZPSr4Acv6XkU+2b/3Fgv
	 mpJDzuTchPAEXR7N+v1m8NjB9MwZMnh/4OijsqCyauS/Ha0YaSzyNusmF0CW3iZWfG+X7
	 c2Zeikh0AGGLYbVwzG4fyZyHHNKmghO2jKXXOIwc6uU1Gw+KpVOPzmF8HsE1iKm2uqjw4
	 t9xInK8Q4i169qFvtIu4XLUTFQNRoMJr8k2CPiuvXR30n6lgkGzbV9rttPdyJOM+NgKW5
	 XMNW2noejRCiCfb/yfYXp4kJ/pDOajVL0OHaFa9OdDEZrL8H71tN5LVU1HnQHFtqUWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598579;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQwzTD48VAaLVfi9sKa1B0jZsX/390HpjE7EN1Oxts7kVrzazcbioAYe5xRvM0Str
	 wt5qnYtd7M6jF7bssrOWY5+311F8dYUbOkXHfopQaX/ku17YK7rFS9Rz/fbRMdD6WG
	 umJOcCikCc81LdMHayhCC9zWYgO8MCSsxo8zKxvVUycoYGae06l7rtDD6JL0+UXa0N
	 Kk/o7OELfMyjMiSCWdmu+4Lfk2Lx7nB3dPWju2dxGaqokOIxJSeQD2RIRZz2u4dz69
	 uKjgMwpf78aGNIxESTZVPQuS6o7stuXY8dq+oR1CIW5otFxDoRMs1ncJtXrjoHmkdw
	 dWxoRGnx+b/Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6578D40663;
	Mon,  2 Nov 2026 05:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 685AC2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65E2960681
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJyf5yhASHrC for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C5F5606EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598577;
 b=jG9bqpkwJc7eaCDt1LeczNandJm9gdMJRXlMdbzGPCJvP4gYRy7Ul9VtxAPdi4Yd6V/7
 y9NXLsW70JZHbMCQi9sS9/LgMetiRVJPlFOgzQvz2Bd7pdUtDayPzADZ3J0kTbvHDCin8
 UTgiq99ZxhXs64qXV4gZqVk1I5Ch1Rk422rSVQAHkr79SsEUiF6NZeMRcCxTkLDK0KAjB
 AwzRM/Du/xNXJ8cHxC/wcqUmktwI3xyTenjoU+d41LYaH2IJigk7JORgLq3TDHJCnRZ7G
 kG1MW6XtUFuGNToGKefRLYTePY0y6MfI7+KHEYoRHjWOWr+uEFRimy7kV4+uCuTTgBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598577;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=LsZNEtWFoDMCefNdLWUxFykpNwWHDT2OxUjj49DGBtcyGFSqF5fBzexXP0jSkBV560li
 /P9Jj8CEi1sQamYabkOG2TbtAsyxeAubpYqn1i30QM1fYIqYRhS59WgdfXOJy+8uS8YRe
 zoCA+qDXhrugCb7mPUTWSmWW+6myFckHljTcSuNtKw1GjH2WhHqj7c5kqqmGh7iECuETj
 Hlxn1yfaxFGKomzHm2Xm6FcgGYfIEgWPM/pGShHVOpx1qZyO9qVaY41sL8QBoAcIgnutJ
 goMgBeNeWHEUN6N9XutRy94lOSJeodTNtkQzvaFyn6RM8chODJ4KHkcQR/j4K6gHZFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=f1KsP+np; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qfvz7b3t; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=f1KsP+np; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qfvz7b3t
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C5F5606EA
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24DO4R2433826
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=; b=f1KsP+npZitaMXyv
 RagOdh4FLkM9e5quhRKMl+sHMZVCtDzfQWh/WNERej+sQFgGQhJkDg8HSnTNj9Ap
 PsBWYz+Bl8VZR9FdrLuIFtCnDLH6d90ljeYqrsNty1mA+7H6YJ6sY5urwgJYZO09
 wFnR7qzUY310QZ5ipsjw2sfP9axFE0Ukf5ZX25b8AkBSRFDdhJxqn7btYMoUGMHQ
 h7ZFlYGOROPEfe6lK5seb9Cbs8h+bXBWsTsqBizZb3mMni0AmCFoBW1y+wcK4Lvh
 BaFrhO79nqnv1/4v9SxYDu6wbG8fm7vf+DDbH8IufqtifZpT3FZ2S3vqU6uEuWUt
 PbB5Gg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka60886-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so9492008c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598575; x=1794203375;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=Qfvz7b3tbHTXSiOx3oYfDNoIzJX2k744O71WMwjvTNHV9wklHsdTZlDJgQmjdK0VkU
 aGUwPj/rLpPsCmbS/Pre/KppVbJD+CgtaOfo59Mc1vXTlS1qr1/fTxQBWNna3CUQ3s5e
 qn1J5RZmZbd4Ms0zQNAqnusZsIsxdZnJqpzdxqsF6GJKFACBZuKs5mTXw2Vyf85I5eHI
 VoMiUOZNxmQPRUx45PA8IRTiuDZFjOBz7r/WHFW+fN5GorAqKeDJZJf0FEPyt61BMGdm
 vpKVJ/RK337M4lGiWPXG/MOnGAs99YYLBdRilUvIsvCkUcZ80nyDanV/O7y5TPnnyyig
 y/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598575; x=1794203375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=i/cqIF9jonD/v3yKvf9iSU2JSz+OziUyk64Z8z0mgqckeFXmBbCf5iQA6J5Uyv4bNG
 d887cRKYAKIFpl/zl/aX0FA0USrUo+IKLLRVbFZK79j5+1nuotfVLPmQeKEY7zQLC3xw
 zvBf222dSo9HOXDNJsR5n22PQcOOMmMO9o8Qfd6eTfk1gycFs1i8sTX1XRO4TpMNKRYa
 BN1Bhmvd+cs88Eb9oh04UOi5VGvjXHa5pVcky08Rmc7d60w+xgdcyKV9GeMEJj6qlElR
 AfY7b+wSTMewnNPg0PABGKCmD5IrHpELhYoSsuCFaVIhIHefc8nA8eJzQpCcR50iEq9T
 z52A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWZZVBqlmeksiunmCXcxcyFFyyfF4aVT0N/AV7H5EpAlGMnFzGmsSyrOOLeLkdPiNY4whx6aE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIc0zkMKKRhILK9ypip/75bRI8sBkTtm+/Qui+4IznqcQ+ac1xx
 RH0Ssf186amK5nF0to+Ltir5Fihia4knkZXNjkWO/uANYQzxzTyK+lJQln0KJAGd9D6UxtFo9ay
 6VLdaDx8Y+R0EER5DDCLLZU7xLCpGpOOkbqyK/fgoeuSWC/AjZJhrhe4FktTydBUbhtmyb7M=
X-Gm-Gg: AYBFou2WDkXClEIu+iQBgNaiVDnKzbCv8jyNgfibNp6AXeJOxjZJ5+MISwvxSiR0ehN
 TzZFKI3ONeKBJP59oB/Vzt43atQIYDAFgkUU4OeR+dAGI8U3lX9RsKHIpg1wHnoS9VmPT9s3cRX
 bHVyzypXVrNARlghVZyVOOaZnSHECPWE+OZ5dcBqXjhwLVgGOCYLld6dDBDptp90OQXh2E0ndIU
 AkcrN1hRZXcak8WoEvAcoOHu3panPkTNhCMnKt539CJfiV+YNRVJmDCZP1C8jJ0bXtGYbxnjPBS
 w4mUZMcA2jTK7U2myS2cA/cZJNyEX4UZCQMRZwz4Xm5Vk1IgCAUhln92DYWJSn01mIg2wh5TWla
 0EcFF27eU1aZqRdG2uzxzw6Wr2SOXZHkidoIV/w9Rn/v/eCLkVStLF9rqaf1Boas5tK2QEWIUhg
 qawRG37WGO7VcRDkpWurzt2tqaMvMewUTP+EcJNeuFnmfH7daQskJFQ5m48xyW8X4lF+kY/5ma/
 F4vCA==
X-Received: by 2002:a05:701b:47ac:b0:151:d6e5:596b with SMTP id
 a92af1059eb24-1ac59dd35a2mr15965086c88.9.1793598574707; 
 Sun, 01 Nov 2026 21:49:34 -0800 (PST)
X-Received: by 2002:a05:701b:47ac:b0:151:d6e5:596b with SMTP id
 a92af1059eb24-1ac59dd35a2mr15965013c88.9.1793598574149; 
 Sun, 01 Nov 2026 21:49:34 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:33 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:37 +0530
Subject: [PATCH RESEND v10 05/15] mach-snapdragon: spl: Add support for MMC
 booting in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-5-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: ncBelSI8zf4LHLxdknQuLcKgOIpIWGwb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX3YGGcdJOuh2o
 bzI1U+KhJe3LA7InYTn3eFt/eCw/TFhBJfxKc8itOtvc0e6tt3o3+yxOfFO9bUBEoYw6BNpK4vP
 fNlFRFxmV+Viq+d6rJ8H9dI4V3YRt2U=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae8246f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=FyIKYYy4Oh7Up_33twMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX+lotsFxDeHoz
 m+dgdw2PnkIO+G4OvfCF9YpMy8vK8c10KgfTWd6p1rbtqUTfPqNx35fvE8FVPfBC0qkwNegUPbO
 pceP0qBFUXV3YaV3ZurmvaprV7acJN1OiQc6IqsMwy3/XYttD8hmu9lWSSFfiP/mf1Gjp4CvZ4Z
 kFcT6CzbuYA9myBR3nvZj6L0XeDjO/djYahhquzXPLfctMACN3wo81eg8FRTiEITHu49co2E+Oo
 kCx1LUAgeMoREoEsRCuRaXqh2BosUvScWDGiNdgHUn7mIwbEh10jnof2e9vkSt6cQUAyPEKvjuD
 JsZNmrK7AexDPpa8dtON53Zt/G0ykoCVimw+kyEx/uJgwluvtYgllD8JDabb7nbxJhQffnQ5c7a
 aBfI3swikWXrKas4L9zkBDfRBkw9NfNhk7hZ/RzJ69RlBdpy8RrHm6BP8J6sZpbVvHx7hoYo8ec
 TMLx05pjEqyhmgJZ9bQ==
X-Proofpoint-GUID: ncBelSI8zf4LHLxdknQuLcKgOIpIWGwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020022
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

Add routines to enable U-Boot SPL to be able to proceed with the boot from
MMC partitions.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 460d07ef0a3..2445ae8b17d 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -63,3 +63,60 @@ static int qcom_spl_populate_smem(void *ctx)
 	return -ENOENT;
 }
 #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
+#if CONFIG_IS_ENABLED(MMC)
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
+
+/**
+ * spl_mmc_boot_mode() - Determine the boot mode for MMC
+ * @mmc:	Pointer to the MMC device
+ * @boot_device:	Boot device ID
+ *
+ * Return: MMCSD_MODE_RAW to use raw partition access
+ */
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return MMCSD_MODE_RAW;
+}
+
+/**
+ * spl_mmc_boot_partition() - Determine which partition to boot from
+ * @boot_device:	Boot device ID
+ *
+ * Return: Partition number to boot from, or default partition on error
+ */
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	int p_no;
+	struct blk_desc *desc;
+	struct disk_partition info;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc) {
+		pr_err("%s: Block device not found\n", __func__);
+		return -ENODEV;
+	}
+
+	p_no = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION, &info);
+	if (p_no < 0) {
+		pr_err("Partition " QCOM_SPL_FIT_IMG_PARTITION " not found\n");
+		return -ENOENT;
+	}
+
+	pr_debug("Found " QCOM_SPL_FIT_IMG_PARTITION " at %d\n", p_no);
+
+	if (p_no < 0) {
+		printf("Using default MMC partition %d\n",
+		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
+		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+	}
+
+	return p_no;
+}
+
+unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
+{
+	return 0;
+}
+#endif /* CONFIG_IS_ENABLED(MMC) */

-- 
2.34.1

