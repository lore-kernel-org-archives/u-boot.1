Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217B4CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C1180DC1;
	Mon, 19 Oct 2026 10:50:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLWZgVKdNWNe; Mon, 19 Oct 2026 10:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE67E80D2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407023;
	b=pH0PRqwxJgxYUu5f+/JejsIZewAFktemTiLqJejhvtjY7+eLhqygebVbQFQbsykGNiin
	 nsdi8sVgs6hx+v7ORtAsoYc0RCoLBYZo3ac0Ajp/WjflxFUvSg+cnyGD37Ldoh9oJB1HR
	 RxzyMtjC8Dr95V/jD7SvWH7xewgwWx0IAQtzX0Z9yYBJd2q7hR5tQL0ZGTmKroE2bUjwo
	 zr3ElHgjaGY7DbT6rt1JcxC/usQvr/aSxw+TO/3Ps66bzYwZCbvpZbSh4SSS7d91buLxO
	 nUjhOL5aWfvlxmOCH5tkTMpBzY1zPOGAz4XhPRqiEie2iFcSvsspv7bW43L02WxqRbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NOZbTNRuSWqAlQ6nhimMwJQiF9DvSI1N6Rq+TNDMAXc=;
	b=D+mktP0W03hwFpfCZBf9xZKF+8c73GWd8M9SC+n418NmqTp0bNn4gk1HcUE7buv23rW2
	 Bq4x2qh+hZ+kHPF9q9ZewLGs8U2CvDbmBC1o7ORPqEiNEC146DLHbNCaIP0UC1O80pCdS
	 Ldy8FUUc7jcl1zGSYQwC9ATG22Pqq5kg7kJSI8QbIcIdI9iwTmZWqykjKUUyqZWWvTIyV
	 yVyZkNliqSwJyVr9FeR28f2hduRoUtv0U/xjISGMhcKXIA2u1PR50wirgA1Xajv3So1bm
	 KRhfAIeZXBTzVYcmx6i8PAxWwYiACU/RmqZgHuSwmBpN0dKuh6enMMebk5kdccUhCOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407023;
	bh=NOZbTNRuSWqAlQ6nhimMwJQiF9DvSI1N6Rq+TNDMAXc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nKn87GxxhACUwA7OAS7fKSCD0kOv4pOyWVYGWpu8gvZDvePLqqrv2RPw6plyxB470
	 c1hV/HTtFHNgd2MuFMNsLGwfmxpks6/5aBiXCwiDxRrL79+98Yna4bIWno1CDkydUt
	 O9aIq4xUs49FlQRKw926DKZkQAawIS7sp29M+1cyMaulEfOHEinkFAC0JGHxb00XrI
	 9/+pprj4mbYExhhrOuv2JsbNu2bSQfQyZBroaOAvDdc8mPrmyU+Mj/YtkhC/10048M
	 H42yFgorwIbmoN01QExaXGT8srbq4Z8Hj6kco9TpNvm1e04PHWi4XQfu/m4r7R4NC8
	 E7uR5C/ehnk5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE67E80D2D;
	Mon, 19 Oct 2026 10:50:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B12263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14507406CA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCPKAMMo6eMN for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EFA5405CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407020;
 b=GOrafKn8oEe+zzQyiCJoq0Z2R3AgmgUMujeJ721BqkXxwty2pw+MAHFHQd7jvDS2Drh4
 qPytx16xywG1lJRQU8KM6yqzWKlr1Q0ihgdkCwT78DduVMxHenNSgky2y+kFIg1oQhq6K
 sKAUZqbFylUCbYhcyfafXlfFURptqeKojfPGflMwctCCz91Cp302XEFpRcp/6V4iQ62ek
 YiEXgPSQmefrZ9Cr6gJBY4JjqZU2VVcDTXH9R5rhU3UB83wYb7l0qXJjLvp5CFTmQJXRa
 YHKFHkNzSdM9NQskY8F/ES9AjsiSe8O1b7ZvOWntjjQUTqMeLMqH3KRonNZe2O9So5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407020;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NOZbTNRuSWqAlQ6nhimMwJQiF9DvSI1N6Rq+TNDMAXc=;
 b=Bg2GqK4ivUCc8jWKknIOyFZekQfP8HsnxchdxPNSWXuXsAwMM6J/7wyrCUcr2ht4S/3a
 suoGCnhFOQdFT3ZN3P5B+5ez4AXdkvE428/vYRphEwp4x8nJze80f/Iye7sb4F3h5VO/q
 Ud+ptWo+FFt4rY7pBMe4m+R3Ap1RlPhWAlDWh7E8RMDVkj74Wlo5PebiG9D0Z0j4RCkJm
 um9nZCmIDSyd7oy4rYNjAY0LiiNH5c4hQbjRPgKHTRijKknlV2pez2AvBjJUETgdMd9wC
 bHSi/tKEBpkVY22ES6y40JSc7Z+UtC3gLzv/6dUi/VEeNbOoH1d4QNrBNEPbfyAIIDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nGtSHaQ5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="G2/k07KG"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nGtSHaQ5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G2/k07KG
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EFA5405CE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Os221665658
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NOZbTNRuSWqAlQ6nhimMwJ
 QiF9DvSI1N6Rq+TNDMAXc=; b=nGtSHaQ5QdNwHeywv/4aeSYN7bKgFvCMUurJfd
 xvUZ3vPSYLeUQyssPLgrDgD+W+11I5md7r91xFUzgivSv/ruxW30xR+DuA8c2Qlh
 uphLlQA9W0EWUwqN+Wwii7rWYqnY4jkoTzXtMAId/pdSX7sfnRCqEbhsJdomTipl
 cgskTm1LaCrEQM0mVjz2+eipDvq7VjhwfcfXhWmhkvsrrZ4uuYo3N7QCYnMjjnAQ
 EFjwlaiKUMLfhZ9pn9Ti+xRL2JD6QaR8TIVRC6BOg/cg2a/4McL49Tt2/yuf6+jn
 /4QCzgBsOpIdqerMssToR6lPqYYCX/OjB/miThY16kR9EhSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0p8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso5422365eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407019; x=1793011819;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NOZbTNRuSWqAlQ6nhimMwJQiF9DvSI1N6Rq+TNDMAXc=;
 b=G2/k07KGPMA6xzeWkJGYtOjFeUBPuPI5vjJKpBX0D9lx0rRaROUPBGPu6XfNQHqPJ1
 fkaqUGFGgQZwHeOqu27SyOUNWnU1T38JGclVrXSHBDpCk8k23IwF5tPObDEJ5hxZbdjk
 m9Fotobrb2/q3k9HPa9V4d6MhcScXEdU9QVH/qLsvCCkA+hSrsiypLjwdwh4JojfnoDR
 LIRFAOUUDhWzw9FNcye8BfrTdN6JHlp7kYwYPlTZkXqTFAQkZcZn6tmheP+msOzyAGr0
 fE2PlYjmATZXAmvxCUi8XWQeqXfSMyXjYZ5GSKBwmDu+ACagQQbXqhrOwLne5xovWoS9
 bAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407019; x=1793011819;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NOZbTNRuSWqAlQ6nhimMwJQiF9DvSI1N6Rq+TNDMAXc=;
 b=sOjsIws50ZqYZCikHaeX6yJ2NKvXMIcIhES2TdidlHxAlf6Ko4Sx35kREokZqReseg
 /m8jeM+I/KHi3PJw1he0tV+gNu5wI/kwcKH0e0yQEdIFkWHlUUjSNipxO1Za6NUgIGW6
 D8JA1Yx3EnDk0Eh4WWISXV0y73+2DUiVaXh6qCTVBHr1Ci2Vx9uUYc2yN1oY9dW2Y0yq
 0rtREwWMdFj+sSgcMfRcXcVL+viyNUgqw0fWOQrrwEWOQS48Fle2EfGvsNRrnrRS8R35
 yXywjpWdXjECr5bkvuKSxe8Tp2gJZhqKensfCXbVJ4J0zVS+vwjxgM8hv+z0j3yxNL+o
 NmDg==
X-Gm-Message-State: AFq9FYIeoGqWmh5DrZoo5f63DHcD3JPc8noj3SgBDf1ky/ZAZI9iGpAV
 Ml2eL5cvDTRu5NeVJ1U6OKnLv521ElkVAzJ7KhV3zC/gsuSZrGc1zr5qGyDDbsDKMNGz6Ig7wxj
 Ey3Knpgf/EMF2x4VAmTmoeh/ttjYhXeEHQXeuraflKY1zRSmcddHmU/fCnL7Ul7On5N5Zl2Q=
X-Gm-Gg: AYBFou24xlnvssspmD8EGNJfaQlUqtqAAkqVGvi8QVDp6vI7CeFykohWPVRq+LyK1kO
 Ra5neKT3ZZmeVm5u9znzKx28v7HHHSliFoMdhQ9Ihhhm5U6Vi7RExt1r9weW53gpNs6DVNgGV9M
 +XsUyIi6FK+ywBaDxaLwZSuxcEX7bVzX52EbYxaC4wNyLkHPi9vgb1b46sxEwMgaMctt49Bd2N8
 6ygHYwtUyri7xMqMlOCew0R3nmbFpLLdYViWbgE3IgHvr5kp5gXckX2x5efbDNpCOc+1QHwFyxF
 aAK5sJu6FxIE9WgyHqqJBl0+o1u5mz8pQ0U0aSv95AiHT6UKPJ9W2dqAnUNXzMstsfidY1f29hX
 2HwJSQofhipHvzlNW0vnZXxOsATCE2M7/1bG/NGMIBARSR2i7hCaPzvgMbl6s7drKsTMD0yfwu8
 NLsLH+x0iXimwkJt2+7nZrNbW6+PeD
X-Received: by 2002:a05:701b:4551:20b0:143:5cb4:30 with SMTP id
 a92af1059eb24-1850c40d8c5mr9933414c88.3.1792407018324; 
 Mon, 19 Oct 2026 03:50:18 -0700 (PDT)
X-Received: by 2002:a05:701b:4551:20b0:143:5cb4:30 with SMTP id
 a92af1059eb24-1850c40d8c5mr9933338c88.3.1792407017402; 
 Mon, 19 Oct 2026 03:50:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:16 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/9] spl: ufs: add UFS boot support for Qualcomm
 Snapdragon in SPL
Date: Mon, 19 Oct 2026 16:18:55 +0530
Message-Id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJf11WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NT3eKCnPjStGJd02SjZJPUJGMj88REJaDqgqLUtMwKsEnRsbW1AIa
 bMs5ZAAAA
X-Change-ID: 20260615-spl_ufs-5c2c4eb327aa
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=3699;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=bZDWvD632U0QhD5CGi0/iDr+Lfx/WI38vYchxTuOW9c=;
 b=utKrIi7d5Q5MKneSd6Soti1XoKSAX1CfhD6ksuWoTtI5bDqhV2+F57u8S0G7lvJPM5d6Nfj0G
 HKBLC+p7BBwCcrymfpbpQApWaB2+fFApbXATwDT4G5o7RXgg/5j8Apc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX1aq5GyWoDpZg
 vK/1Xkq8/fFKpiXKr41C0FkQ6gfNCKBRbYvZLS1nWw4tSxoddajpglO8nEST2/yv2LaKv3mu3RO
 eJJ2EPR0r9sLUQJpYnydVe01BrqNFMo=
X-Proofpoint-ORIG-GUID: 43mWqo4IdrxJCJHrOMtVU1ZbmY4ZHDyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX/NiL0PjJXaEW
 W9HTimXuxstkq/s6BzSsqKt4dHaP3PkGjbCzeCUOUTMeEx/qopb9caJscuJaYF96iLJmt8CWB3R
 xuDx22tX/k6At6poNr5UiERg7ooHwMd/1Xjqqx+Pe+rJpuGvpt/+VPOKJjMHcBgrCgHlho/pXQs
 xC+ZOWZeEub7BlgAA+vn0yhDNilG3nmu8MCauNyIYYlD89l1VPc6Jn1MPAlQczLalMDlMAQbFpc
 ob4CMggwqvtRN+Ab6wRDvkj5irDa3Jc7cGoqunB4FrMaQ2Tu9G1J/enlCxqeho9Tp5kCQyoca8q
 vhHxqtSLFEBTi0Wuk61OqZmt/mL1yJvIlQqxZoHVlxR2quwl5WpNixYOlhk3BtYhGw/7OnjMbOo
 wfFRw4inOp2+EsICrGcu7ygIoY6DChIpS+/TWF+e9CaMfb3hm/vEkirUvu/DLFBmPdjNxcDtkiA
 cMnroLaC+k4megPVzIA==
X-Proofpoint-GUID: 43mWqo4IdrxJCJHrOMtVU1ZbmY4ZHDyy
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5f5eb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NAZ9W7uj078rnQaPQBEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

On Lemans EVK, XBL hands over to U-Boot SPL, which loads the
TFA-OPTEE-U-Boot FIT image from a UFS partition. SPL_UFS
currently only works on the RK3576 boards, which load U-Boot from a
fixed sector.

This series builds the UFS/SCSI core in SPL whenever SPL_UFS is set,
adds the Qualcomm UFS host controller and QMP PHY drivers for SPL, and
lets the SPL UFS loader find U-Boot by partition name or number.

This series does not depend on my other SPL series. It is
build tested on rock-4d-rk3576 and nanopi-m5-rk3576, the two existing
SPL_UFS users.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Drop the five non-UFS patches (GENI, pinctrl, serial,
  PMIC/SPMI) to be sent separately
- Rewrite the cover letter
- Build scsi/ and ufs/ with CONFIG_$(PHASE_)UFS and drop the
  unconditional "obj-y += ufs/"
- Add a SPL_PARTITION_GET_INFO symbol, selected by its users, instead
  of extending the defined() chain in part.h
- Move the Makefile/Kconfig patches ahead of the loader changes
- Link to v3: https://lore.kernel.org/u-boot/20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com/

Changes in v3:
- Simplified partition selection logic in ufs_load_image_raw_partition
- Removed spl: ufs: add SPL_UFS_FS Kconfig and filesystem boot stub
- Link to v2: https://lore.kernel.org/u-boot/20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com/

Changes in v2:
- Renamed SPL_UFS_SUPPORT to SPL_UFS for naming consistency.
- Added SPL_UFS_RAW_U_BOOT_USE_SECTOR config to clearly choose between
  sector or partition
- Refactored the codes in common/spl/spl_ufs.c to use helper functions
  to make the codes readable and clear
- Add the filesystem support in SPL UFS as a seperate patch
- Correct SPL_UFS_SUPPORT config name in lib/Makefile
- Added SPL_QCOM_GENI Kconfig and $(PHASE_) support for GENI
- Added SPL_PINCTRL_QCOM_* symbols and $(PHASE_) Makefile
- Added SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig
- Updated Qualcomm PMIC and SPMI Makefiles to use $(PHASE_)
- Link to v1: https://lore.kernel.org/u-boot/20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com/

---
Balaji Selvanathan (9):
      spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
      lib: update charset.o build rule to use SPL_UFS
      configs: rename SPL_UFS_SUPPORT to SPL_UFS
      ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build support
      phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS boot
      spl: ufs: add Kconfig choice for U-Boot location method
      part: introduce SPL_PARTITION_GET_INFO and select it from consumers
      spl: add UFS boot mode defines to spl.h
      spl: ufs: add partition-based U-Boot loading support

 common/spl/Kconfig                 |  57 ++++++++++++--
 common/spl/Makefile                |   2 +-
 common/spl/spl_ufs.c               | 153 ++++++++++++++++++++++++++++++++-----
 configs/nanopi-m5-rk3576_defconfig |   2 +-
 configs/rock-4d-rk3576_defconfig   |   2 +-
 disk/Kconfig                       |   8 ++
 drivers/Makefile                   |   3 +-
 drivers/phy/qcom/Kconfig           |   7 ++
 drivers/phy/qcom/Makefile          |   2 +-
 drivers/scsi/Makefile              |   2 +-
 drivers/ufs/Kconfig                |  12 ++-
 drivers/ufs/Makefile               |   4 +-
 include/part.h                     |   4 +-
 include/spl.h                      |   4 +
 lib/Makefile                       |   2 +-
 15 files changed, 224 insertions(+), 40 deletions(-)
---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20260615-spl_ufs-5c2c4eb327aa

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

