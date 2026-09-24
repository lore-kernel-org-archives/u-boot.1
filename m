Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8560C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E9BE60BA7;
	Thu, 24 Sep 2026 10:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2P4mv_9xZTSe; Thu, 24 Sep 2026 10:25:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A1C2C60B67
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790245518;
	b=jmX7C7TFU22jzPBVo8exonMcNS/qZuJicFOBU+M4Ew4hGnj/Qp8Jd2weTKPrMkXkpLyB
	 v5W3cYrq4g0moXTiWmQY74LFGhDb7Bkn6sjs7XU26U6N1hVY5lJlldVA/cjJB8ftv3ZAi
	 Kvczf2d2nrfML3VcJ5/fV1X5ra2c3380DoLiBNzgDHYQw+q2+lJFPVvDVbJM36JbS4QS2
	 lqR55/Y4oKoD8rd+HCcPzLEhPgTqD89PFpoFXHKBhmWIqfjvLxg+ED3dolYp+7LhCStn0
	 XcoiyI0TYwVC5d6Kl7KzWf37f2itoJqGynhKk3LUZLLE9vs1u+wDKgW92Vni2sSX81A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790245518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:X-Google-Original-From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=;
	b=lTXJ50JmJm2V11BocTUnKK+zgtKIBkHzdhLSUiL/L7AmaKYkwse2sfOnAJtk86JSfnZO
	 Bvxpvt18h5o/fnLDiZOrIQI0UgF+m2hHPRoyDjeGy6C98fPkW/1MpxWDb/zIlPB7ISXGt
	 v8eG//uoIaJXqR+dnQKzeTa+qUXqlBJsPJSo+2+dQAiJ9MVw+wLR9vM459zGCTm65dE9W
	 2Ki5ne1hG+59JPN1qCdLbL2vAmdA65ukYp+u95oAenXa+H3PAOJIOn3U2jI/39nO5xPUR
	 kis7YWZJFEcW7cSBV4Lw+llNUNzPKXxnu595ANLpZDg5PSLYaG0S9B+/0noYMxw0fEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790245518;
	bh=pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twivVPO9JfST6409X/vjPTXIvB2lcBRg3VFa1LcA533832XxrTeSR0gZIzimfe4jI
	 k0L1e3nM9Xhn79C8VmJ+XuxVIGUpY9twymSZ6T4pWa1PKx39oiPVEYBLKjXF6oSc/+
	 FEXGSxkPQD9QrTeYSKmHzCz5X4Zl/tzN6GpgMguTNxt/0+Jx4bDO1yHl1dG1t8SZdx
	 9G5xmYBVXNkne2eYoR4S4JiiJQhjr3dL17ZvPLFNGeJzQ/7sqL6UrG+oQV4nauaeNp
	 j6238x2w3G3mDg6uvX5diHu3vaXa7AKp9Zw0tLfXyDRo4qK9fUEiBVq/rlIguL8gic
	 xjcQg+PQ5dPEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1C2C60B67;
	Thu, 24 Sep 2026 10:25:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 984A2392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA4040DBB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gi85YCG7JKul for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:25:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1CF4B40DB6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790245515;
 b=b+kfzczum4B3DF6MtCkTaGINSySBBq36aRZ9Qkz1R3PI7PQnymQh28zUUochG2yFo4GM
 KWZw/KDtKnQGDYQ3bcH/9bQfjQFtF0spkcGGrsMLPJBKuLvnJDN8ukO6Uxv2KcFwXGEgA
 /VDL8r8piwvRD8Q3qtgU+Iua/Jsg2OAQf4EUVJSty01fdRwTgVODszFs+z8/Sp/yGmKwP
 j/5lb5mFiz00Wh7icHrVwj+sZH2VpZ6rzhQgL1C93zGNWd+DGA/Ov0FiGplRShxQSmsuq
 vG+BMcpTflX0mYIXxhdZI6Lwl69VAVu3jQOybJhTe5/87HdAYvBMBxKe0EH8Nos2VGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790245515;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:X-Google-Original-From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=;
 b=J/BFLXSFTzYDdSrh2f5rtbzlaWS9o3xLJGG3CEhOY8eYg2ESNVRs5uDoPwmwRTiu5Cl8
 uXdt7v0Q/08sO5WonSNoXZjZESeoSPQP2wn+dqnYn8Agp/PLfnP0nQXV1qI5Z23hAHiKA
 0bLZchYMVeh+aHU+8l+jrT00SZVvJQ90Ug7oy4gQnPNiqsUh0iDUr5hVmQEgPSjm6HVRP
 CeJgdEFoUkTqVpGeBUqHkDqn7RWUxEm9HNtNwFm1P+Fd6W3mbFcKnAIi2p9VsOwsQfya6
 oFU8AdrWynTkI/OMcVbetyAp2W3+4BESbTE0JS5RVIZe9T8zOiZ3hKmfEpW8sk+Kv+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ab3LZbKE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pfp39pda; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ab3LZbKE; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pfp39pda
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CF4B40DB6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O9QBfn1774038
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=; b=ab3LZbKEHfcZgxFY
 5IDC2rP0A4F64XikcP7KveJ+1B+wT7R4hMCwko9uDaFcOsndtGb5bnft961vmcDF
 U5ECsmqP9FfPVqmNEGNKjTKUe0gpYOzwpNxu3T75ClsMUrIdWIZvsccNmYV3mgUW
 4g8GGm6te0vo5vxAqBOra8oZ5Nj1tncxTcHtr9PEy1yJfEcvcX/QnuH6Xz88pMJs
 ZwKiVcia4Q9SqF3C1PRaGHktrOc/CRIpuaP5gtD6MmeLHiq/PI28SAwzMmQv1byg
 UWiax1awBDwWDBKOw4f70zwFzFmznEKHinAArgSeNgyVyQ4oxQpcn/+1tD5DQ1Dk
 gXm2EA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb3yar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:25:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-338c2e27430so1717575eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790245512; x=1790850312;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=;
 b=Pfp39pdavR1wxzxcOO3GAQPMgAQxLtYA5G/YHdFzz4ovbHZoxlUeKJEL1SSdchlZ0r
 Fb/3fsn+Wql2GdcZMdZB/JMlN14eCCm69/KnCGcXT3Stv9nlUUgl5i8+aAp9eQxUL6DO
 n5mU0bAVpxyyBjqk1nrttcf3hOZqYJoCPcLhWyS8AFPUCWZMBscGo0/Grua3tCuu12hU
 /zNV8e9uAueGyrg7zniikH7ty5h7S3Gp908dBJkINuccOS1f9keChCS/uYtnpCCFnQki
 xPzDwHVPAZH8cayPNYVHRhml8cjPupBCmDwdu5z/sATsdrruH1HipQ3BUMnmtd8oKdXl
 UgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790245512; x=1790850312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pKp13E9Kud9LeIOw1hx/qZgLI6HD/T5553VieBaSNZo=;
 b=Wbj55rHm2ZFYwpqIXXQHk2E+k88c2pmokGNSmr8sv7TkF3tYCFl8NKGD3cKpx8Td5f
 t4LnO57xqJuflcDWEvQq+BpnswgQU3lakDLS+UMzIfOIYsHPA0FV68DQ9EnbMNe92fwJ
 tjxPCnVe3HJqXHu0v9LfxxXDNeWZ7RWb6eViF2/mJtq2M4jmoz5ETgdbq+81OPu7dOBY
 I6oNsq99dZVtqAcZ2ypxX84+rQokqmybkmIlE3Rw9bRhm3b6qOxF08nYPXiU6lzyWeSQ
 dAN0h3kcb7Kl2L7znfgnDfL5+gRWXtcDYo5lD9hYkNgGh4AfJH70G0S3Wp7rdnaMQ+zk
 ui+w==
X-Gm-Message-State: AFuF++nxCZe4M0c5nAvFEw+5YWhDXqpCcVrxl83mvI/l3nSNWo0E+bNP
 WHwrZnQlSWuNYMBjeZ7R9YCBebS7trSsgytLejNNm7ikAiUooa8EAZ0+X6vglMPpx7dxs0P4SuK
 dOTWRoMiu6azlAog2AhbVXxqfJBaSpXiLhFwjIBAbNENRHgF17Sy3KFbdcO/JKXdVStPC+/KryI
 ZgpnI=
X-Gm-Gg: AYBFou3diJ9HLV3k/u1dlIQjA3RXIROIGwwrx99XRmhlXNBkFOiojdA5BGZCMceg0k1
 arJvXh7pF+UvxynRXyZS/+r2iVrjXr+01PTTvWO8g8Lm0KrmQ4KltjncPykllqa3Q4GYo2w27zo
 gq7UGKIzyVnyuJH35/kJGjPlUcjpJneqJG9GLbPGndcNEyAoUWA6VdS+APWY7TjJVeDYjUR8hf1
 9e3+byYFt1PbbR4U7x6HQOU9qNZPLh6XgBIjs/a+faWhcc/r+6GH6WdrOie532gG5dXiTQxAmKG
 0A8GSenTZ5bwX5cXe/oE20JtWTsEKiNoZhC1AUr2fyb2uLRjvnLZq+QtvA8lVzKJQbZQpbLVUYG
 wREqrbRE9IQFp3myKnvGUgGdc6NhEf6wndVjLR8zyNEctvAyI1GFixvXUR2ycA1jAX85TprxZsQ
 ==
X-Received: by 2002:a05:7301:192c:b0:334:8fb7:1e55 with SMTP id
 5a478bee46e88-33fff652acdmr1618063eec.17.1790245511828; 
 Thu, 24 Sep 2026 03:25:11 -0700 (PDT)
X-Received: by 2002:a05:7301:192c:b0:334:8fb7:1e55 with SMTP id
 5a478bee46e88-33fff652acdmr1618040eec.17.1790245511210; 
 Thu, 24 Sep 2026 03:25:11 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96f47d52sm14374789eec.28.2026.09.24.03.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:25:10 -0700 (PDT)
From: test <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Google-Original-From: test <test@test.com>
Date: Thu, 24 Sep 2026 15:54:55 +0530
Subject: [PATCH v2 2/2] cmd: qcom_geni: add idempotent qcom_geni fw init
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-series3-oem-spi-nor-init-v2-2-fd8ac27e7057@test.com>
References: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
In-Reply-To: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790245495; l=6530;
 i=test@test.com; s=20260817; h=from:subject:message-id;
 bh=fIn8wNgr23WB2kNacST4smVCk51K7oDSZ1zvdBd/3ow=;
 b=ZJmGClqtOypac9lvJv/vfeyXDr4FCaU2K6A/245q9ZE8YQy3vmg1lTb+kP6AHA/087m2nx+cz
 XovQDJSURZ/CpQe/OPoFSskq2iupIyQFaEn69Yn1a8AUmseujSAsQU9
X-Developer-Key: i=test@test.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: nuiyA9xLdkIXa4qKmU90GcfFI9uTyUx4
X-Proofpoint-ORIG-GUID: nuiyA9xLdkIXa4qKmU90GcfFI9uTyUx4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX0ky/1CM6l/+6
 cc3HSF8PPT4VSMz1ocB5YDKbh14BWMBhMbeZoYY2fPTC9UNnnbkwqWhPyKStTFXPic2Tqp4nrqu
 R2KHVItr0n258gZDwsQt9ibfXx5zl1TSFznZij3iiAG/yWToBndoU6nmFxWLTeB0x6tjtAxuQT0
 iCIUxyuXD71bMElbDesT9clFhHDGSFs93SH2UlOU5r9bYNKDc/omBqoVqh2duVJlpNZCmN6QA+R
 PtdU+degzJP8OC+s9kmfPamI1U1IcxfdAqNfYe4+S0kmhQi+JypYtS9xvwzdbz3hsGU1PtGV/Vt
 cX6m5VjTALO+2eQPYgJSRehKuejPE6yJ0KVU1H9NfQB1y6HEpk0nCv0wRod9G8BeqS4d+ZQQqS8
 9u3ckEy4FI0Z162ATdQUMsqd//juHVqUVTdi51Sjz4Mb7hAHXr1HAA3I5byT3Ga5nkJAyx++UJi
 zA81jZPiUSfUjaQlz+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX0qpNh5Q2ROMI
 hKF6JwdW2vMPP8JifmhrCizPK6PElzJjJgaQ8XRwfVjRDdEkzny62cPe60mAnlEvUUC1hCRtwfN
 xSJimPcK7TjW9QZe1VYmuY4Zf6emqek=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4fa89 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=k1z-pLZrHwV9F0tga-EA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240043
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

From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

geni_se_of_to_plat() caches need_firmware_load once at bind time by
scanning each child's FW_REVISION_RO register. qcom_geni_fw_initialise()
only ever consults that cached flag, so it cannot detect firmware that
was loaded after bind time, and a second call cannot pick up a wrapper
that still needs firmware if storage became available later in boot
(e.g. after a fastboot-triggered re-probe).

Extract the scan into geni_se_needs_firmware() and re-run it inside
qcom_geni_fw_initialise() against live hardware state instead of only
trusting the cached flag, so repeated calls are safe: a call with
nothing left to load is a no-op that returns success.

Expose qcom_geni_fw_initialise() and add the 'qcom_geni fw init'
command so a retry can be triggered manually or from other subsystems
without hardcoding SoC-specific calls into generic code.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 cmd/Kconfig                    |  9 +++++++++
 cmd/Makefile                   |  1 +
 cmd/qcom_geni.c                | 26 ++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c       | 24 ++++++++++++++++--------
 include/soc/qcom/qup-fw-load.h |  7 +++++++
 5 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..453ee94f6f5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2884,6 +2884,15 @@ config CMD_SCMI
 	  This command provides user interfaces to several SCMI (System
 	  Control and Management Interface) protocols available on Arm
 	  platforms to manage system resources.
+
+config CMD_QCOM_GENI
+	bool "qcom_geni - Qualcomm GENI SE firmware control"
+	depends on QCOM_GENI
+	help
+	  Provides the 'qcom_geni fw init' command, which (re)loads firmware
+	  for Qualcomm GENI SE wrappers that still need it and probes their
+	  dependent children (SPI/I2C/UART). Useful to retry firmware loading
+	  once it was previously skipped.
 endmenu
 
 menu "Filesystem commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index bbbdfcc4ded..1db96718938 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
 obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
 obj-$(CONFIG_CMD_ROCKUSB) += rockusb.o
 obj-$(CONFIG_CMD_RTC) += rtc.o
+obj-$(CONFIG_CMD_QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_CMD_SATA) += sata.o
 obj-$(CONFIG_CMD_NVME) += nvme.o
diff --git a/cmd/qcom_geni.c b/cmd/qcom_geni.c
new file mode 100644
index 00000000000..31cb3f454d4
--- /dev/null
+++ b/cmd/qcom_geni.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <command.h>
+#include <linux/string.h>
+#include <soc/qcom/qup-fw-load.h>
+
+static int do_qcom_geni(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc != 3 || strcmp(argv[1], "fw") || strcmp(argv[2], "init"))
+		return CMD_RET_USAGE;
+
+	if (qcom_geni_fw_initialise())
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(qcom_geni, 3, 1, do_qcom_geni,
+	   "Qualcomm GENI SE firmware control",
+	   "fw init\tLoad QUP firmware for GENI SE wrappers that still need it and\n"
+	   "\t\tprobe their dependent children (SPI/I2C/UART). Safe to run again\n"
+	   "\t\tonce firmware is already loaded.\n"
+);
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index 2e8f72d5c8e..41a6fd153a3 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -396,14 +396,11 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
  * We need to determine if firmware loading is necessary. Best way to do that is to check the FW
  * revision of each QUP and see if it has already been loaded.
  */
-static int geni_se_of_to_plat(struct udevice *dev)
+static bool geni_se_needs_firmware(struct udevice *dev)
 {
 	ofnode child;
 	struct resource res;
 	u32 proto;
-	struct geni_se_plat *plat = dev_get_plat(dev);
-
-	plat->need_firmware_load = false;
 
 	dev_for_each_subnode(child, dev) {
 		if (!ofnode_is_enabled(child))
@@ -417,9 +414,18 @@ static int geni_se_of_to_plat(struct udevice *dev)
 		proto >>= FW_REV_PROTOCOL_SHFT;
 
 		if (proto == GENI_SE_INVALID_PROTO)
-			plat->need_firmware_load = true;
+			return true;
 	}
 
+	return false;
+}
+
+static int geni_se_of_to_plat(struct udevice *dev)
+{
+	struct geni_se_plat *plat = dev_get_plat(dev);
+
+	plat->need_firmware_load = geni_se_needs_firmware(dev);
+
 	return 0;
 }
 
@@ -496,7 +502,7 @@ static int probe_children_load_firmware(struct udevice *dev)
  * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
  * all the peripheral devices that need firmware to be loaded.
  */
-static int qcom_geni_fw_initialise(void)
+int qcom_geni_fw_initialise(void)
 {
 	debug("Loading firmware for QCOM GENI SE\n");
 	struct udevice *geni_wrapper, *blk_dev;
@@ -506,19 +512,21 @@ static int qcom_geni_fw_initialise(void)
 	size_t fw_size = MAX_FW_BUF_SIZE;
 	struct geni_se_plat *plat;
 
-	/* Find the first GENI SE wrapper that needs fw loading */
+	/* Find the first GENI SE wrapper that still needs fw loading */
 	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
 	     geni_wrapper;
 	     uclass_next_device(&geni_wrapper)) {
 		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
 		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
 			plat = dev_get_plat(geni_wrapper);
+			/* Refresh against live hardware state for repeated calls. */
+			plat->need_firmware_load = geni_se_needs_firmware(geni_wrapper);
 			if (plat->need_firmware_load)
 				break;
 		}
 	}
 	if (!geni_wrapper) {
-		pr_err("GENI SE wrapper not found\n");
+		debug("GENI firmware is already initialized\n");
 		return 0;
 	}
 
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..f4417fc1baf 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -175,4 +175,11 @@ struct udevice;
 
 int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
 
+/*
+ * Load firmware for QCOM GENI SE wrappers that still need it and probe
+ * their dependent children. Idempotent: a call with nothing left to load
+ * is a no-op that returns success.
+ */
+int qcom_geni_fw_initialise(void);
+
 #endif /* _LINUX_QCOM_QUP_FW_LOAD */

-- 
2.34.1

