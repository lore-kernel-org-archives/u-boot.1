Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C08C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 893EB60840;
	Thu, 17 Sep 2026 09:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNBaLRhlvrv7; Thu, 17 Sep 2026 09:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5422660822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789635677;
	b=RXsYq2hlI222iGtrfPJBGpSR0o2K/TJlsmIvt7S/136Gyrx/kysqmanRBCxLEKQPReUY
	 QqZC+z2HKTmBDU7EYVvScGdo6DoPX2gb5jGSHE3zTWUYn6fCBERXYchFuzX4tK776P4Y/
	 E4Ik+kDOZftZTary3skJKhBk76ZIB0KYfgW+mqR0xcJrBSX5oN34DJ2qDQy3aS7A1sqNW
	 6dLMzeM1US/0WxqQcLICOaQzNa3gNvoPTh+aDMn1Xo3HcHp0+Q5IdfD6cXzD41dh+yDPZ
	 U7ZRTvFXWdzDv4QUmQSOTz7oKvYRcw+7ueAW3JKIhz01+j5JeIfciKFHXatiD31lc7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789635677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XOoUliR4rYNyxhaSl2V8gjWb7itUr1cIVqtVsxq78tk=;
	b=Rn7R/4jxQ0VEbDnx6MlMAGQ6X01su3HqqJ7QBoGwTFpiV783r3kKD8gNQkNXnrWNE4Wn
	 lAz/lyYcl0N3RqKsldECWCTMDIRPVQ19I6Y+fOHOLlTfDUqwf1jhV+J14Nm2fcOhi+Sxu
	 GXxHQb0lkIIxJbTR2wQL6pp8Y6TT3Z6c8BuikhmkvnbmJK86S55RfvSNHec45eWgpHulU
	 77gfe0QborwxnCP8fivXO57prqjO9Mj1ppSP0AQeSxlwTfLU3h6jOCyGYVRfrPIyMYpWK
	 DailcclOzkYFWSSlkQZv5kNkre4lSDre4QFrE8t6khFK+ab7R2DlHBdWdq2CJtIg3+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789635677;
	bh=XOoUliR4rYNyxhaSl2V8gjWb7itUr1cIVqtVsxq78tk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YzC8EQ4vL6iEti21gBZMLmAxLix9Q5tvuI+N1tq9CAjyU3XABvkxBtYS1ys71/EH1
	 tlSu3WQ8pk8fuLAwfbQ07NICKS3ZIxiUF4TQ955b5twFofvms2r+Z9mU8K5QGt+cmE
	 tmt/XKKMzU9cpatFtfxJjR/2VIsJw7N/JXyK2oAEchfRrCYJ6lKC0Dk0fhFvRU73x4
	 CmXjCGImSJb83mvXLwsNt9aVawRG7BbrZs13kcKKjwT/7wJflnvHG1ZAszBJS4tpfY
	 4vmAzZY7EG6RU8INXiNAQvilkJlIzVyFBQhlUHuQBBpndgS2vSdCZ8oszZreehuQQd
	 qDgai+rWmQ08Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5422660822;
	Thu, 17 Sep 2026 09:01:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D679C42D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAF2A407A2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUphiTGaZpSF for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D6FE407C2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789635674;
 b=Zcc/BsuuS5fKvaKTI7dAjsqkaUdvSwgeTmUeEsATD2ryvcFALOeVz0oMcklG6XW3aGGB
 pXrsqQfjwsAfcSdcvIKoP2fPtEqewUCpz84dIdFLMAp51gyvEwfAHF5tlApAOu/6OAEOu
 wdfi7Lt22ZFXPD3titGwoVcDRpcGZtDRetHO20+wL9KeQalrPk5k2jbxgQdYzaLX4mRgE
 JxkPK+EkH3yfKNX8L9wRZtsNvSPAt0R240iR8DxSHlfarZECHkiGzs3h9rk9D0cD4bJDQ
 kxfgEfMX225LGWUiXp5QaHcriok0D3+QkQHxFGHTjnN+AgOKSgj1WuFi4EcWqHAQq2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789635674;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=XOoUliR4rYNyxhaSl2V8gjWb7itUr1cIVqtVsxq78tk=;
 b=Wc0iEPJUvSZIJVDrois6DPAFmoMuQVZ6ZYLjWgXaz+s9KvUAznubhDSX8X9HiytDsp+P
 pH1/dWx8Cx1fFRoOyff5p01NhYRqfM3T4oagAubYr2T2w17IKCLO4wIcLhC+AgTqazCNP
 VyCDYzC1DnFUQeXw3JbKOfhUSvKFuEnVAHqqoOSPLTD1lRgk3fLzJeqX9+ju1ZvA4b3JI
 k2LRr4vYwChpHM15RvGN0oc8O+9+LJOVYs4+F4BrhGQ/epWAn+TsGs/6VmGOBrxc1Xn9Y
 2gMeLhW+AeroVsfvyHj2ldYqYSjdiEFMU8EzfljKSfZ1+ZsKb1ebgytVdsiqKzOUkpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Q+d3TZO0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ae1MFGqD; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Q+d3TZO0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ae1MFGqD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D6FE407C2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H7xMH0396679
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XOoUliR4rYNyxhaSl2V8gj
 Wb7itUr1cIVqtVsxq78tk=; b=Q+d3TZO0Y/PtQ4329nwcl6iCu2gWSnXBsgPyFw
 HGdMK/VV28hqyD2ER36E5z17MfpDG5M4gQ5XwC5Wb+Ub82CdwnnhB6Jgyyq80YM2
 QhPggqgCc/O0bUdmeQkcSawmv5Sm1js7GSRVA4jjRRRKQEVW7jt4GSNetrD0h7kh
 51nuLT9iq3eQBCycrP3Ez3vBgd5oLKXSJ121YBeKNLQzMWph8KV6qeM6onEtm8bU
 67SDipgmQOECiYaOsgRK3xZ5rkvmzwyupdw7k1qPMrLStBMeNSeDp1F1URewWZWm
 VRU075AvUsTs4hwnKdCkL6kEjrpzIpwkV4f4T5t1ghPgvCqQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grca0r7s2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:12 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4cb254da90eso871910b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789635672; x=1790240472;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XOoUliR4rYNyxhaSl2V8gjWb7itUr1cIVqtVsxq78tk=;
 b=Ae1MFGqDElr5vRM2cQuYb+DbQNbliBt2RbKYVl8QvC2fajTv2gSEstJDwbrzSI8kkx
 qZ7qLv9xPeFFw+4pTcXfxtduqdeMBY/DCCBCz9YRORLwdjaOrb8p/VQZelqMtzKGN898
 K5pegt54rWyrJXsPR4mCuxQkfMQyQNSxIzHT071A8jvuIZc0Mf0IDAHqXszJB6ylaUXJ
 Cdq9HkjWMWI77LCDe7Ivi7dSmQTIlEUQvxiYSJiYD53lz1y2QwFXaoSkfkRNS73qnp6l
 16fTq+t64DmdllUJfdL4uDR0OqCJAA4VYTmMeoyps58Fs4FzuBztpWnKcM/dT7+T8cHa
 xgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789635672; x=1790240472;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XOoUliR4rYNyxhaSl2V8gjWb7itUr1cIVqtVsxq78tk=;
 b=bPGidWBmg0kDPSzbSopHJn9I+xIiwaDWmfvpVudqyOWeJLN7G1gA2AbogrCPLLwTQH
 bZ6hzWLG2UfuJYdwygPnXfnm8z9ZMpSsOmFVmFn/nd7/jMXMe9XyR5HEB5XpjfPPUcg9
 oTalK0wRSzRBGVL9kWgbAhypjsuAnv7b7UkvH0X+59TkozqEOg/G2WIXKvWZrUAR+F6v
 z82n194julMuH2HXjbYghGCW/ie6ZJRJqDAbbGHqXfkyvJccZ3g0nP01NHk4GjvJN3Bz
 yf16L2kS8zn4jMz6TBlvU7Ms4WsVevXBKwpBJ7Zk3b1ab9ZFnyXpJrAMBzBnBbrOdSrT
 /6ig==
X-Gm-Message-State: AFuF++nXc5TRxFSttbnYum+InrMZvhxeMxAvhUAiSqR7LNwmOq1vJ+y2
 usp6qd18igM1LMTVedA9UA4c7XgGRp+PH/k3YqPdKcN23amh9u4X1wgYLrj6Rif061MX0BhEuHh
 SZD0KaJnabQa5QeAh/F68stuV/fxls5nzvCJBNfqGnr8dh2WyvOoZrcE42LWvLX8H3V5P0DA=
X-Gm-Gg: AYBFou0PwVQCJRC9wXkAMu76Gg7G3YJkfD4ZNwP1kOZuTPknY7WQeAW3w7MQwR+Q9W/
 uRGXk57UuOiu+NpKxckVAludGN9nJXZlqjXl1YBMdfwl/lpdCLnf+Edl96LjOAW2il7Nnl+9bzs
 B+BYayTRclXXOKqtYvbxD/4rMl2nC7KJB2aoOK6sGSP4UTRvAs0bhBrmJYwuXAeJ1UuLQhZPIR0
 FiA3I8B0UOUtVsMhTR1JQqS4V7APrYahg7yXAYdjsJeBbfG0nrDFStUl9wc8v0qeUUSIIAJafsZ
 MOwKNaNJqAvGJpc+BYSz3fSgrVBZVFYzSnDKmX8Rtm5JyrxvAUv7Guns0LKcuyWQb19hZ5xsbRe
 cRebwgtTlGreRs6WAeJgbuZ/RQ67O0JyhPlkHOxwIEoCnrjfWWrWAbxupqpo2qzqUOdPHtlt+rx
 xqBWvmUjjFxI2KIFwKSk/eDa7B4pRwI/43AofZ0OY=
X-Received: by 2002:a05:6820:827:b0:6b8:1306:8567 with SMTP id
 006d021491bc7-6c7d3fde3cbmr5551574eaf.57.1789635671836; 
 Thu, 17 Sep 2026 02:01:11 -0700 (PDT)
X-Received: by 2002:a05:6820:827:b0:6b8:1306:8567 with SMTP id
 006d021491bc7-6c7d3fde3cbmr5551536eaf.57.1789635671255; 
 Thu, 17 Sep 2026 02:01:11 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a1a5sm14965977eec.5.2026.09.17.02.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:01:09 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 14:31:04 +0530
Subject: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAE+sq2oC/yXM0QrCMAxA0V8ZeTawlTGqvyI+NF06o7JKk4kw9
 u+r7vHA5a6gXIQVLs0KhT+ikueK7tRAvId5YpSxGlzrhta7Ho/eYQpqlLMhvXJ8ooUysWH0fO4
 7T4HGBPXxLpzk+/9fb4d1oQdH+01h23arVL8agQAAAA==
X-Change-ID: 20260824-series2-fastboot-block-target-c8e9418babdf
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789635665; l=11720;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=TSlKo4xLOYJU/+PtWfHr/FqNW4/pBWslbVHfE/N6yRQ=;
 b=lbvI3IFLZ3H/8NfJZZbjxWeFzueep/eJw3qbgNOCa8a0M/BJe7tesBQ5tsBfsG8/kZYYNZ/FN
 s8C2KjFdSqQAEwG06kLajOowQZFa2e31ej2yAEHoHV6LdqwQPl0+lQj
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-ORIG-GUID: jjACmm-g-AOXyG55tqgdgOL3FdTmamER
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEyMiBTYWx0ZWRfXxPbJfm+1goek
 sqe8ezVaQ6ZKzG5wYsIEQZtOgoxrlOMTwS5cNI6Lf7wRIAoFi40rjv8843rarcScGj6OWemi1i1
 6ljxB57waDNHyl+k8EzcENSI6ldC/5M=
X-Proofpoint-GUID: jjACmm-g-AOXyG55tqgdgOL3FdTmamER
X-Authority-Analysis: v=2.4 cv=dOQzC+Zb c=1 sm=1 tr=0 ts=6aabac58 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=a_U1oVfrAAAA:8 a=p-LfKV-GAAAA:8
 a=-Yep7ivrQWAXgz-edyQA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22
 a=97BuGM4RKn6GwmfqMd6i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEyMiBTYWx0ZWRfX6eIx6VJH8e5J
 vTF25bvroXAhCMOUM3YpplUuxCImxdoFCaM3M7Y4JMVCOOVgrbvK+BKuTqsWi1hijrNyJCLp2M6
 nByMRbPGw+GjXfkXWGmTkPkSooJ/+I4XZ/mdVBUBeC8BkbtksvHN1f906Hc/kMv89EZGFMQKujD
 TbRpur+vL9TKNXDN6nqC/4/6vAwHLozlFmEYrPIel/h+/iLQEiYFwLrn6pBXv6pTA/Rj4zN9g5D
 pGONC2wTvIcX9gjuawrNl78TvwwzUCraVYMZtO/N6RP1DU4ybOLIJ5kc45Jc5ZRuxd62BotF9KP
 IDrsOkPuIIvOFx2ghKY79SUZY+xt6F7Yl3yUfLgFf7z8hmKLXOWyelVhqIYtcnnWfs7b4KypAiz
 JUKT1kcxVYtlcnfiqMQawRS42MyOEkD+H5qJb715Z7McUwoOp57IufcyGND7hEIspHVc5RaEFwE
 lg8aeCBCp3iMZ0stglg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170122
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

Add fastboot_block_set_target() so an OEM command can point the
generic block fastboot backend at a different interface/device at
runtime, without requiring a rebuild. Falls back to the existing
build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
set.

Expose this to fastboot clients via a new "oem set-block-target
<interface> [device]" command, gated behind
CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
CONFIG_FASTBOOT_FLASH_BLOCK).

This is needed to target storage devices, such as SPI-NOR exposed
through the MTD block uclass, that aren't known until runtime or
that coexist with another default block interface on the same
board.

To: u-boot@lists.u-boot-project.org
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
This series lets a fastboot client redirect the generic block
fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
interface/device at runtime, instead of being fixed to the
build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.

This is useful for storage devices that aren't known until runtime,
or that coexist with another default block interface on the same
board -- for example, SPI-NOR exposed through the MTD block uclass
(see the companion "mtd: spi: Expose SPI-NOR as a GPT-capable MTD
block device" series).

The patch adds fastboot_block_set_target() to the generic block
backend, plus a new "oem set-block-target <interface> [device]"
fastboot command (gated behind
CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
---
Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for Lemans-EVK
Link: https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device selection
Link: https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
---
 drivers/fastboot/Kconfig      | 11 +++++++
 drivers/fastboot/fb_block.c   | 75 ++++++++++++++++++++++++++++++++++++-------
 drivers/fastboot/fb_command.c | 51 +++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 include/fb_block.h            |  9 ++++++
 5 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index a4539844d89..c7e0509eaad 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
 	  Device identifiers are numbered starting from 0 and the most
 	  common case is to use the first controller on the system.
 
+config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
+	bool "Enable the 'oem set-block-target' command"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  Add support for the "oem set-block-target" command from a client.
+	  This allows switching the block interface (e.g. scsi, mtd) and
+	  device number used by the fastboot "flash"/"erase" commands at
+	  runtime, instead of relying solely on the
+	  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
+	  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index a8c74e35d0d..d3e5f6ed1f3 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -125,6 +125,66 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
 	return blkcnt;
 }
 
+/**
+ * block_interface_override - runtime-set block interface name, empty if unset
+ */
+static char block_interface_override[16];
+/**
+ * block_device_override - runtime-set block device number, -1 if unset
+ */
+static int block_device_override = -1;
+
+/**
+ * fb_block_interface() - Resolve the block interface name to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static const char *fb_block_interface(void)
+{
+	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		return NULL;
+
+	if (block_interface_override[0])
+		return block_interface_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
+}
+
+/**
+ * fb_block_device() - Resolve the block device number to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static int fb_block_device(void)
+{
+	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		return -1;
+
+	if (block_device_override >= 0)
+		return block_device_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+}
+
+int fastboot_block_set_target(const char *interface, int device)
+{
+	if (interface) {
+		if (strlen(interface) >= sizeof(block_interface_override))
+			return -EINVAL;
+		strlcpy(block_interface_override, interface,
+			sizeof(block_interface_override));
+	}
+
+	if (device >= 0)
+		block_device_override = device;
+
+	return 0;
+}
+
 /**
  * parse_device_partition() - Parse and validate device:partition format
  * @part_name: Input string in format "N:partition" or "partition"
@@ -140,8 +200,7 @@ static int parse_device_partition(const char *part_name, int *device,
 {
 	const char *colon_pos;
 
-	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	*device = fb_block_device();
 
 	/* Check for colon in partition name */
 	colon_pos = strchr(part_name, ':');
@@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
+	const char *interface = fb_block_interface();
 	int device;
 	const char *partition_name;
 
@@ -385,9 +442,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
 	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
 		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
+		const char *interface = fb_block_interface();
 
 		parse_device_partition(part_name, &device, NULL);
 		fastboot_flash_gpt_partition_table(interface, device,
@@ -399,9 +454,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
 		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
+		const char *interface = fb_block_interface();
 
 		parse_device_partition(part_name, &device, NULL);
 		fastboot_flash_mbr_partition_table(interface, device,
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..235fae74fee 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
 static void oem_console(char *, char *);
 static void oem_board(char *, char *);
+static void oem_set_block_target(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -120,6 +121,11 @@ static const struct {
 		.command = "oem board",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
+		.command = "oem set-block-target",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
+					      (oem_set_block_target), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -589,3 +595,48 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+/**
+ * oem_set_block_target() - Execute the OEM set-block-target command
+ *
+ * @cmd_parameter: Pointer to "<interface> [device]" command parameter
+ * @response: Pointer to fastboot response buffer
+ *
+ * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
+ * device number used by the fastboot block backend at runtime.
+ */
+static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *response)
+{
+	char interface[16] = { 0 };
+	int device = -1;
+	char *space;
+
+	if (!cmd_parameter) {
+		fastboot_fail("Expected command parameter", response);
+		return;
+	}
+
+	space = strchr(cmd_parameter, ' ');
+	if (space) {
+		size_t len = space - cmd_parameter;
+
+		if (len >= sizeof(interface)) {
+			fastboot_fail("interface name too long", response);
+			return;
+		}
+		memcpy(interface, cmd_parameter, len);
+		interface[len] = '\0';
+		device = simple_strtoul(space + 1, NULL, 10);
+	} else {
+		if (strlen(cmd_parameter) >= sizeof(interface)) {
+			fastboot_fail("interface name too long", response);
+			return;
+		}
+		strlcpy(interface, cmd_parameter, sizeof(interface));
+	}
+
+	if (fastboot_block_set_target(interface, device))
+		fastboot_fail("invalid interface name", response);
+	else
+		fastboot_okay(NULL, response);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..13dcdf919bc 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -51,6 +51,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_RUN,
 	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_OEM_BOARD,
+	FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
diff --git a/include/fb_block.h b/include/fb_block.h
index 189c708e2f0..fd981d95316 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 				u32 download_bytes, char *response);
 
+/**
+ * fastboot_block_set_target() - Override block interface/device at runtime
+ *
+ * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to leave unchanged
+ * @device: New device number, or -1 to leave unchanged
+ * Return: 0 on success, -EINVAL if interface name too long
+ */
+int fastboot_block_set_target(const char *interface, int device);
+
 #endif // _FB_BLOCK_H_

---
base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
change-id: 20260824-series2-fastboot-block-target-c8e9418babdf

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

