Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD88C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 09:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59E7860BE0;
	Fri, 11 Sep 2026 09:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8Jd4Wzfgjrm; Fri, 11 Sep 2026 09:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5209460807
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789119109;
	b=oAWXOvvtiie3sGr2e6PSKD5YWxsIOrdbhGd0oJcMDa7xcrwCdUr2FTWeN7TjlCCPiKs1
	 yVCERw4C0bo5X/wMlBAqoHXCjU9j/N/J4y1Jdo9+FLF1ydZUERGHVqM4+JQTqF2tZu1MN
	 XGb1R1vbt1u0LtE5Bivv4NzdKzTGcz0dRFCdgTHLrU8/sLBygYlXLxKoJhBiUNvAwfI2X
	 i7jyyGHz0RvMQ2ZvsR+lECJTfXmb42Vk0ZJbHpstyMHnlyiQviUde40P2vTN348B4T2wc
	 T4ysLJ3Is/vpAQhkkZzgihdlv3DTaAyXyZJu6BSGG27huCu5VqWaAyI/63sF9PQmo9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789119109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L2TxClt2sCQUnonvsnh+VW3t3xDhX12DLhTF9t7Ril4=;
	b=oR7PORg+qc86ah6U3uDiziR9AjYtWq0fykFvb79ktf2PkqdGNBIKmPQ2YrArFNGTSmzc
	 1LIkl2OsJkBKtznXJCumfUo7ftE/mjZwK/Zb+diQl94eqflO3cHRgYSYdCQ2lF0PquYlO
	 5ZbCNjy8eGuJ2jlQo44k0RN81nO2Dk0ibwMVWNUOzwzTjSOZU1fc5+W5KYRuC0txH9Vpd
	 ZPbTmewMGKT6gl+j8GfjCz/Vip5+YA58nIsM/QbqD0PbqLIHPXDn/stWzVM5nZevlq5RF
	 S4eMZs9I1/bEpoKnTS08CfN4KVC0mlAyTgcWDiUXDA1te3hh9UcZqKsFZA+kAktecSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789119109;
	bh=L2TxClt2sCQUnonvsnh+VW3t3xDhX12DLhTF9t7Ril4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WEUYtb8PgFlkCheHi0L9uOEdv2LjxD4TNBqkFM0tqYORUnyOmjW+6Cdj547CHJENc
	 z7+RN6i6G136Ybs4QOik5DDnQarRTZ81wnoSCz3aDXMPYNKBfq0L1fo0taVSRKErUD
	 +GP4+qFKyaKXJ9umYZ6Ekqk8ur9YKWbe98kKDHpIylC4G5ZwHHadSxBWqlnVNm9MX9
	 oYS+5C07HKFLJoqZS26qkNnosH7WB2wgaVqngmmethkGj6W2rG35KGc4hsM/oCJIOu
	 R/T1kUZlF0m/OouzrEOefBVcXBWU5m9AX2mUNMJDKPFC0K8PUgfUPz8a/H0+qX4YoT
	 xjzKlDJa9Lj6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5209460807;
	Fri, 11 Sep 2026 09:31:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1817C29B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF0CA400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jkNS6SFN1wwz for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 09:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7769C40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789119107;
 b=KZy57dviW4qNIEZe2JCoeaAfBe8GPcT+DEqVLemtA1wcLc32FeCX8b3J72VkvysJNYce
 oyK0mbYBARWODrYDQo4nhVDplt9LFPdC4I0GT9arG/yEiTpXlmfUhHRjAxm6uln/RpuhL
 eSDH6CME3gXUX+OgD1/I0O7FH8Xq2EtdG75ctZvZExb8vl8XO+ERtghcGUyEpIJJyQrDe
 SxDgQ783lWtV5UOaP1McY9dvovpGnkhBxkK1eBDTnmhtur9gj3XkBHiXvwLc4GycqyBr8
 kGDfEVM2ZfsiZrlXE0qnKVQG4B+hIERVtvSf9Z380B62E26DTl5xW0tcuRhy1GScDAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789119107;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=L2TxClt2sCQUnonvsnh+VW3t3xDhX12DLhTF9t7Ril4=;
 b=bE9SjmIkxiPYYS1tQz/agLGrUY0/abXILW3hVOeBS+HUY+GXGUnDbB0BzFpb+kADQIeE
 eiccESw7Na4R5fr2/pmgQHn2ah9TVxWekVhUAFrG/TT0votncMztyE2Hc7Yj6pfU4IfdD
 As4knn6e7xiGyxznnVY04WHcYE+nYk9/9K0760+e07GuMjY8RwxYF1J22A8cYKL6CLxsG
 qaho9PBfGC7B3I1ENUpCyudHv7qHi5VknPDPvKmQUfvOpqkSPgsXGPfqxfZszccjJ75fk
 diKNBPFvhrl0LyLnEaU927U+817YWEqodHZAdFjIUq4K0aGnA/IB681b67Feahucq3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gK6O+0F+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ee986juZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gK6O+0F+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ee986juZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7769C40050
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:31:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kr9B423715
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=L2TxClt2sCQUnonvsnh+VW
 3t3xDhX12DLhTF9t7Ril4=; b=gK6O+0F+oGJNd7ZaUXVT2pcQ7bTnjLBElCw3Fo
 e/NOg+neHq+KozHUF0g8au4yyakhCRnG2L2/ykuxrTLAj/FB469cvlEPI6u8sFF/
 fZFTUzOZY7wJLD6LLvVFKGqA23CmmgRI/xSwmF8fz//TDHLhUDPvaMwQsfwhGqOn
 XsWexJII2FyrcUZEAeBihOmia+2kLknjbzZIeQ+yZ9YAgli3gZoLnSOpVAF8Vqt0
 /A4pZe0PJmo4w9daL8Y7+v3cztiXsEvi5SDLbvn6iN++wqt4gUW3+d/f1889JcHQ
 BR0YoPEcNGXdK9haw4C9dXMetgOBEeskhil3r9SZTsPlsjpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8gypj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:31:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so2141990a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789119103; x=1789723903;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L2TxClt2sCQUnonvsnh+VW3t3xDhX12DLhTF9t7Ril4=;
 b=ee986juZDa41CXcikJHPnXGVDclTb3n2590L+0159vMgOjSX9LRccQcjDcQn2FlUY4
 JavEfOxkHX+8xIlkOM8K1263wdlWhCBKhmuUmhXD6nH4BURJ8bgX4UhdcBe3Z70a9gK7
 UGTaClSCYvq223wSKQsTrkVrmCtwMiA/UzRLDsH54bONJuBLTnddQoy+EXccF1ywbYxU
 cgURBf+JRF49dXY95wnaCAozLjVUsnXN+fqCxHq/B/zMpLw6a/3ges1BL2Cd8z60vGHq
 D4tH75TTlZXQRYZPdbr0TP1a5e/FgIEQ+mcHIrYwAL/eDSGXQC9KASaXZKBJlK/iF2tD
 kcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789119103; x=1789723903;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L2TxClt2sCQUnonvsnh+VW3t3xDhX12DLhTF9t7Ril4=;
 b=HPhmw8UqarCkN7KvghKhU72rIuEowq5ocOwTkbzobSzyzUVLoD5V8aLPRbtwRpBtoY
 3MbecSwhaPA+wzqsMGRW+Uv7jk9TTBNosjB566UioD/4cZw21XH3ppunX7bn3RzW2hqK
 QsabZsCkKYXqfZMRSHTqjXmoJjkmbbOJrkV5fJHacOvVcoIKo538/gqQ0M2ScWSyhnYi
 rYfBSGKPLz+mduKDzZt6z5UnanbkaVES63tKMBfZOiOhaS81ZXKCw/vFQmKkON4H4kfY
 BPWVmrUuyV/YXDvTZmqzCR97RiV9SI74FwmTjMEbjFknYRkglwNrSaEmvhAp2eBGV7wW
 sakg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfKwEqDR8fWRUPhQ34SGusaxzk1oOpEL22HjvymkYnWx4ZM0NodvBpQm4cAsBpXF1FfUX6BEU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m/uLVwjB/dDH5Dfj67U6DtNmsON4Df2sJnVUn3GrvHJbl8t1/q
 qPk+DQXf8v/si99LvCpLRbZKbKGqDmxX0+frfE6kSdDLGviPNI7t3P0thLPCA3gQ2A754aHZ3yP
 bPbuvRL/cOEGSC3t49+bdohuLSHZjiMyvOyWGcEi+xSdfKYcb0gtel6PvDUIHkYpf7ZoBMdM=
X-Gm-Gg: AYBFou1ahZQzjqRuW7gMKd4jmkc8IpjOU86/CWNwpYC+3e998T7stW7JL4/8dvsTgYr
 0NS7SMIEJjLso77rWJx4SR8X+PBM0TTtv2fsxq8EDjt1OrkgOVCZPPAlYhIm1Iv7zNdgi01FRIX
 LuttuYe/o2C8wHPy8mZlH1nQeJELmH7negglCGfjvTSDQ+pO4bnpMfgz5CPcTcvv/LrNuJSZ22G
 K8rwwYwuivgjALDVCpOBou7y8x/6rklv5HeRG5JwLs8S2QFa2nfUvPUomztoceywFMEhhJr+VZQ
 RP/MtpE0QVtCT7nh1hs6bEffatCz6yNVADIBuvJubd+45IvLCsXoU0Ri1cWWKc/BzUwxMkah9Mc
 OJL6lWoqrFCd1R91FfnvpPxbDErj+kVbL+nVlGp+bf+u/tq5v6hW+v6qV5w1v9G7qjCBei2EF7v
 ge9+Degd/m8KSAmRsKw10wIPVLey4c
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-39d7795b9aemr11488627a91.8.1789119102492; 
 Fri, 11 Sep 2026 02:31:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-39d7795b9aemr11488577a91.8.1789119101899; 
 Fri, 11 Sep 2026 02:31:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b345a4sm4996972c88.5.2026.09.11.02.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:31:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 15:01:36 +0530
Subject: [PATCH] clk: qcom: qcs615: add SDCC2 apps clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pll-sdcc-talos-v1-1-403f61254a19@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHfKo2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0ND3YKcHN3ilORk3ZLEnPxi3RQzwxSzxGQTM+M0UyWgpoKi1LTMCrC
 B0bG1tQAGc2G4YAAAAA==
X-Change-ID: 20260911-pll-sdcc-talos-d61d6ac463f5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789119098; l=1895;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RWgVqxv6oCLl80PzmsFjQ2AopIbKtTA6aNvHHMM3t1w=;
 b=tshjtMLJY9IjbHnEh7P6GjE3lAUmoLSkzrhRcXCQ4Jb/EP/Ke+vIzlduDdkbe3wW0kHEVYMa3
 TzzT0kAnj9uBPMTLQ1yBEycksz/rskyEt3UF/tTWKxzHM8LpvscmXsh
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: C_eJhyrzoj9-NPBytwpmdFJPyoufnykF
X-Proofpoint-ORIG-GUID: C_eJhyrzoj9-NPBytwpmdFJPyoufnykF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX4R6LIoTgyOMT
 u6sw1pNyuKE9r3B0Tr20XvD2RvP9U//FRTJjjxWl2wBCNzTq5JR6QZKRvEmmrYEk11jTlCcCCRi
 F6HhDY4EkWgdU9LFULnwZO3Vvfj7Bb6e4RplhmsX/c0FABuSPzbu2M5mK/PIxsLLbJ3SPLpP0he
 W0iI5eoRMC2PE9RDrZBuRG5pDjqmH1JvALP7NYcw6gRJ17sqKcGCLOJ5hQgwQd9L3618USmUist
 Ta/Vam+9+60Os77l2UJZQmCnYHMlU+N2avhS0LRmiELGo9TbX9V7HfX2BhaShJ/JCXw3vRW1vCX
 7REBWo1LAUyIch6ebTYqp0LVLyppK0JBme/POvru5dAPMWWC4kLQbF5GXyQqcJDEFuI3/m7C4Dm
 WuCt2m65ujtFPFGT4uIxMU553dJ+N4pKvM6IR2j/4JuxR02wcSlU17hZVtNT4OQYa7nLIFV//5X
 +Ls+jY4K5lUmiQX9ZQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX9iJano/5R33d
 wFLi90gw1GiP+diEc7mLpHU3MJJynfQqNcRKgGH1/YCzCyFn24abDicBgeb3Yb/ovDE/miN18aT
 tfzkP50IXL5MRZmPN2zk5g2ys/eqUNE=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3ca80 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_BFbkWWjj6b3YnzefJgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110132
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

Add the SDCC2 apps clock used by the external SD card port on qcs615.
The frequency table covers the standard SD rates up to 202 MHz.

The 202 MHz rate sources from GPLL8 which is currently disabled.
Vote GPLL8 on before programming the RCG whenever the selected
frequency uses it.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch is dependent on this previous submission:
https://lore.kernel.org/u-boot/20260721-emmc-v3-1-35cebc036994@oss.qualcomm.com/
---
 drivers/clk/qcom/clock-qcs615.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index e9572951e7d..8113effae77 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -52,6 +52,16 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	{ }
 };
 
+#define GPLL8_STATUS 0x1b000
+#define GPLL8_ENA_VOTE 0x52000
+
+static const struct pll_vote_clk gpll8_vote_clk = {
+	.status = GPLL8_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = GPLL8_ENA_VOTE,
+	.vote_bit = BIT(8),
+};
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -140,6 +150,8 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL8)
+			clk_enable_gpll0(priv->base, &gpll8_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;

---
base-commit: c325d05e486ffc7298796ef1aa22c5a1196b8113
change-id: 20260911-pll-sdcc-talos-d61d6ac463f5

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

