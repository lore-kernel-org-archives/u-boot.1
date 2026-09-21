Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C2FC982DA
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 939FD80D87;
	Mon, 21 Sep 2026 04:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kt2mSS80l4zi; Mon, 21 Sep 2026 04:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8915080AEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789965258;
	b=KdamMckoRbKhnsEayIaZlLsx+jTEr/leUsJbO0g4ngclwl+NYtpnERxK/rU4DmeUOn63
	 0Q997yPYMSf3RsoUBdYnw9pWAfxxpKsdUQMwLBSt/ChICLIISAZbFvqF3eqGzIr6aBwTJ
	 8ASjdGMzkDX3bJuXuLC9+u1EY+JpVpLEutgKAN6F+eaTeleXwlcQqT4fLrl2IzqSekulV
	 efyKN4exEyqAeg8ePYWuuQwDi3ErsOt0z8akzGDuFXG8UE42DgbsP/OR9RKKN4clF4afm
	 i9w4MEUkxhoEsL8dhKiehnyWWqjJab2Mi6/X/gFNW0ZA9I1BbfZpnc8xRGfwhFRQ6uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789965258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FQR3HuKRa6MvaAXp6kLXnM/X/JOdkbIueLYtgWCIatM=;
	b=oEwkgGx25PSje+c0JMDpOysjZ4Oq+CIEP5SCO0H+IxqdoKYC0DIoww2/AMHCwETOpNTr
	 pARGfiZRKBHm80RYdcVljHKRfX5Z4wvFM7SJ37kYQToTyyYqmOniyHALy+Ej6TG7tVAsY
	 4P6KxUg7f24pZh6GyVhfUoIBsMUmEEbxd8aSHp2HTrqIiKoOvKLjUnf+xxgDCWzl8mARc
	 MYlxCHPDsPC7ErZtgeYTEPn//8yqET33alQErObz830NEZsFR/ixIGax63b1i3d2401/i
	 +l3zwc2KxqOu/FMZeJmvjoHea29/BaQNHIC2ElcoLK6ImiyciRqIx6It8SYnChkvb7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0qUYQno;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YPTGD9CA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789965258;
	bh=FQR3HuKRa6MvaAXp6kLXnM/X/JOdkbIueLYtgWCIatM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C20La+XnWopI9IhN8cEcm+BZiun7AiBgcH/OfdZE7qLeA0TZybORwo7ZhfYieCQJN
	 Vkl6IO9N7nUI0ittwQpjka26LwKVuJQcmN6KdWVHSgquhDHme/lotStAVGzju1JPjW
	 dKPzb4xDnfRoHCqRL1Z8Sm54GMgl79wTsoZK0bIICQEMWydDX4/aYmOexscBGUrVsj
	 DccKBbsoER+1RrsF1yy6nWpmwS6CMzbLRIb8R8Gc7YCdFcEDIUv5PsT7PFTZJU9fXu
	 5i7MTTF+NgSw3hzfedHJcqicjhYwVYDrrY2kVPDUVtcR5qiSRPSG4aCP+TzJ5H50K3
	 SwXp6f/JGUF4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8915080AEF;
	Mon, 21 Sep 2026 04:34:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E33EA386
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF42780AEF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6axTwJwMSFi for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7291180AE3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789965257;
 b=aHTXkcqX5Uru4W/gyVtfklzBtWcaskMTb1jLy0EswmsytTmGh1a3NuUDEZPGY3LLbp6Q
 ZGp55MAB8mBcgV3omWWZmf50oDnR69qQjtXxmhOCXYGbUK1meXT57zGx5y48jGItWxO1u
 71tLSYQ/xXWvCjTrZbEZ+LzzFVQxqJEzOD9gFIzKdX2pYEjWT6Xby/3YCees76N769AF1
 laKC17nmvzyE16R5jE2nvZ6Ay8N6nvvZ1eKIahTP8fVsoEuPyKJUhKJkdQNtSRl/7neOl
 ANbVxE1Ecpa4ijMXF6eFsIzfVLU4SdrFjjUnYqlpyI+1AsXrLW1CYkjFgNgNSoAl1nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789965257;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FQR3HuKRa6MvaAXp6kLXnM/X/JOdkbIueLYtgWCIatM=;
 b=Ho20mYT7FU1GUKugZXdf27OORlFT+1SR9mOwYugXrLvPn0ZHHLEIa79DDz4DgOeU3T1E
 U+d5TsDJKNQDsDLKsQboN/HggZ8q8JG7C37e7Mmbz380ThVh4m4zhWxJJijKHWfAKWFNa
 XmDM7eU05bMq8/nMqYAXGmD2nQrl0fmc0jR2WEmiyI6p2g3QN0L4OGZUATCjGW3oxfwQW
 WKT1+fibZm/LyTuGtt0lJUlqE7a/RSNM7f3/kTVE6WYT3ktHXDTEMxck9gG5vsg787I31
 Jj3wlUg15u3ix/p2DkCHK2PA++ThoeMYYLQ//mprfEqAjU0haj7ydHuuclftOLaUXyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=X0qUYQno; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YPTGD9CA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=X0qUYQno; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YPTGD9CA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7291180AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3ZULr007152
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FQR3HuKRa6MvaAXp6kLXnM
 /X/JOdkbIueLYtgWCIatM=; b=X0qUYQnocQEf9wVkY3/FDBgvkbGTkaSHVlGHN8
 p2hjkdPycjVdfEuXrh2qh/Mzur43ndwQWrHxgmkqd/tuTBhnOdiymiIPhBBXXpEA
 /8q4uYAQe1SG3wdaWAMkGB0/x9ayToLJmrs68n2aC4d9FI1EjkrkPW8AGxw4D+ue
 W0hZIT85PKsi0oSI3xni96Xf7wFhvaFaF/CNjOUlw4taEWa/usEfSZBzl6m2b+Ab
 JsWmYkNUa9ODLvAczKFfFmMreDzoDMy/fo3RiBeAaeMrx0ju6jQfgStbndoNW5EG
 r68YcXbE+6U5iaI3pqjg1OKkrN7+8f1sJOFpl5+GHHjqRBUA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b8usq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so5184771a91.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 21:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789965254; x=1790570054;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FQR3HuKRa6MvaAXp6kLXnM/X/JOdkbIueLYtgWCIatM=;
 b=YPTGD9CAHYdk7CwOgDoCHHHq+7kiRyUa2ns+PlsN2WwRRSmd4U2fYw0qLhmeDxJe4x
 Jtf2osczHghfjq2kj3ksvg8rtOxf1T2M3BQTLZ178xhO3Ra+r2qddFJSO+cVfyklNVQx
 BhksE2dzH8/X5XrvmWPDOSMin25ArmmJi5W/mcOeEcIZkZxsl7t60RSLkVy5FX/uTA3Z
 XVuu1JeWlx/0GZQKWoSQ3RhfSje+aulk2KUBZzJjTfCkDkGh0DLC8N53ksytAzn/DLgT
 EyDgtZKgZ8cZ9slP5Xx36nEfARXBzpekeK9GrgcYt1CEyhEak7nAUwVeWSO+sszy6abH
 kuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789965254; x=1790570054;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FQR3HuKRa6MvaAXp6kLXnM/X/JOdkbIueLYtgWCIatM=;
 b=QaykQTgK2n9HA2XBPHxw5Sx2/W6v9XS+WPL+LIW7ORCItRv4bckRrpp4KoIFkJU+HH
 n9t0nogCrveod/Ke8fNsPxldPJraaiLUWWvE6EzpM89M7p/MyaQAP0r6YMT62iZVNDj/
 irEcXiM6ZsvLan/+VEJlCxrNvkoZQdXJa3BrD9VmQzDDhesApCqu7M5VJgFq0Kw1AQ2B
 TYKUWagKp7ScV9ggWMqbTMO5prrGRLz3OnqFNqf2R8qFnF77xqeWfE1H1CcWBhw/Adru
 QkkNNZWyKOag9i8Nfxok8LS8gz0sfgN2DaFTHo2/nuvB2COH48b1rxDzhBVdyQPV/fjI
 U5IA==
X-Gm-Message-State: AFuF++ntaAHSphFPKRKPIDo6POTahBq32zaywu+uXL+itYVCo/OUfUBn
 UurymZY54HFM2WuJ4AmBe8NtdMlRQgYxTz+ueXNNEcJfGFtIeHi1FYlM3Sd6rHEXZsWo+z67rby
 STI6Y7AsQZ4uF/+OFOjmYxDHbxNCzqJCHFWaCPjiR/Bskd3pFM3AB5CxGZU4BYaQypqUWGdrIwB
 b7TZc=
X-Gm-Gg: AYBFou2h19vjMrgyHdXLezmkf1GAFz9Gw+PeV/A5TCOXyap2MTTmIENovPtT4Y18NFX
 NB99fIkFd4gnv5NqozrXx+arUOMXJEQwA3yIIf4xzqkmNfI/AIZebJXlaKUXahLZVivroRSv06X
 KE2/wDoauw2uubBjqKGYXPwYJDwOkIopo8N5nQJAtN6zvb0/UPtqxvwVJJjZdNyUQieIFkXG9AO
 cTjzhN5cmJ2yuSDSKHwyYmtlkEufdMHL7nWiOPyhf230zHvhse/L06oQdgG+zBgS5UFRgnGK7no
 BwWrHflZIppPK0EfAu6bYnkiMAYSQsYQSY3mKPQKwVxoAymElkSmD4m7zFFinCcSvlJ31NsLOt5
 Ueob04/OhF3pApTjQmOeKxlgtc3m03fJGqge+l46tJ3CYlKCfWEofM316cqgfx5NqLBXmSY+EYV
 MQpCSXumgrjnUvmfDf6SlNFkaUDAo+
X-Received: by 2002:a05:6a21:b8b:b0:3d1:3c2:85b6 with SMTP id
 adf61e73a8af0-3dd8c3fcd32mr17634105637.5.1789965253613; 
 Sun, 20 Sep 2026 21:34:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8b:b0:3d1:3c2:85b6 with SMTP id
 adf61e73a8af0-3dd8c3fcd32mr17634075637.5.1789965253167; 
 Sun, 20 Sep 2026 21:34:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm19427279eec.30.2026.09.20.21.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 21:34:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Enable U-Boot SPL support for Lemans EVK
Date: Mon, 21 Sep 2026 10:04:04 +0530
Message-Id: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyzsGoC/yWNywqDMBBFf0WybiQPjcZV/6O4GM3YBnxmVAriv
 zfVzcA5cM8cjDB4JFYlBwu4e/LTGEE/EtZ+YHwj9y4yU0IZYZXgNPe8xwFG4oB51lhpQGrD4mA
 O2PnvFXvVNwdctthcb8kGJIKrWSV3URZXcZeCC66x1K51SttOPCeidNmgb6dhSOP5f2iAkP+FX
 6vEysw51eVOlqChtBixMU46WzSqyLSJHnNEVp/nD8HtGyzoAAAA
X-Change-ID: 20260920-spl-lemans-ae54b916a136
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789965248; l=3657;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Frem/f66RqEpw5lO6zVQNSrbAR/8eeL7fmRs7DIZaEE=;
 b=HhBVqHcWPoZw/P6mHzgyLeAyIsQFavhLKbIPmT/4IGuixbYLJffDoHP/01sPGEanQg0g2VESk
 PCqSJHlbcAeAWeNDTOczqiuwQcD2WQaWEk4CbOAdsOlKVhPCWGNcda1
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX4n5aPsWwK4Wc
 7u87urKrY3uX2UaC8LUrdMLqa/wlg0HOcA9fCQBuOl+GmNcbY05KcAmAsJKJElG0rRHXaINkYtC
 z003f56a6B7tCq+arSOzYI2/cGfx/bPY0JTYz2gLXVbsrnk32iwuFryDbbnk3b7/sGBL0ChgXMU
 7bb7xYnafkoVVi0KBKM1QBD6mnW3pbZJG6eK6eCjyWe4lHgl1J0J/gQc4XDj2/IJm/TYtEsgP4n
 6p0uDbTR02gKT7Ag/6568DL2IZK1rOrRrNrrA2936mDjEUYwVKt0nwUGxy6E5ufqsQR0LeP3mT4
 xq43vqGhUe3JrnRPd5CbOJX+dhHmY3SoCYvhEPYUCsvlMQB9DOps59Orc47qfdLVP5ncEwIZZ3n
 bu9QJTz800EMws1fXR9fj1+zHewy3mWBik1kdtSAnlmthnNYG5qzT7mi1CrzvsmG5fkPxprmgjw
 iTUQHMCUjQirQFg/6QA==
X-Proofpoint-GUID: GBe314ado8raI3k0kzbZsKJJW4Up0x_f
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0b3c6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9XLSUFgA6YLrDrtVgY8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: GBe314ado8raI3k0kzbZsKJJW4Up0x_f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX4xW9Kmo7HlVC
 gvXMw8ai2xj3F0F8x0uzPv9GfF1BBig+G1ulL1nsUzucKMl/Hqvx6Frv/E4Aqzg0fO2dlLYV8Oo
 djxvadcE34LjYozh4BbjXsIycRl7U48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210063
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

This series adds U-Boot SPL support for the Lemans EVK.

In the Lemans SPL boot flow, the sequence is as follows:

PBL -> XBL -> U-Boot SPL

XBL initializes DDR and then hands control over to SPL. SPL loads the
TFA-OPTEE-U-Boot proper FIT image from a UFS partition.

This differs from the generic flow assumed by the new Qualcomm SPL
architecture, where PBL loads SPL directly. SPL initializes DDR using
QCLIB and then loads the TFA-OPTEE-U-Boot proper FIT image.

This work is part of enabling SPL support on Qualcomm platforms,
specifically targeting the Lemans EVK board.

This series depends on Varadarajan Narayanan's "Qualcomm ipq5210 SoC
bringup" series, which introduces the mach-snapdragon SPL architecture
used here:
https://lore.kernel.org/u-boot/20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Rework the series on the new mach-snapdragon SPL architecture
  (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), replacing
  the monolithic arch/arm/mach-snapdragon/spl.c and the
  SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
  Lemans SPL support is now a board file with strong overrides of the
  new architecture's __weak extension points. 
- Add board/qualcomm/lemans/spl-lemans.c and include/configs/lemans.h,
  replacing the earlier SPL_QCOM_BOOT_FROM_PBL-gated code path.
- Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F from the defconfig as now the
  framework board_init_f support is removed.
- Link to v2: https://lore.kernel.org/u-boot/20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com/

Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
- Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com/

---
Balaji Selvanathan (3):
      arm: dts: lemans-evk: enable SPL support for UFS and dependencies
      board: qualcomm: lemans: add SPL support
      configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK

 arch/arm/dts/lemans-evk-u-boot.dtsi |  42 ++++++++++++++
 board/qualcomm/lemans/Makefile      |   2 +
 board/qualcomm/lemans/spl-lemans.c  |  64 +++++++++++++++++++++
 configs/qcom_lemans_spl_defconfig   | 109 ++++++++++++++++++++++++++++++++++++
 include/configs/lemans.h            |  11 ++++
 5 files changed, 228 insertions(+)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260920-spl-lemans-ae54b916a136
prerequisite-message-id: 20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com
prerequisite-patch-id: e06f4f15b24c0a2b5999530d2bd810e8d5d25bc4
prerequisite-patch-id: e44b5daee156032f7c09082f5fa518ac2005dd9b
prerequisite-patch-id: 9da742167a0d265cc05d7d27bade9449856c0c89
prerequisite-patch-id: 61167bf309ffdf04460e71ead424508841ebd67d
prerequisite-patch-id: fd4a66734fcabb946480e13f2cef6e0a3d70516c
prerequisite-patch-id: a638b4c9d1805ff7ee27c5e18779ffc8717f7e5b
prerequisite-patch-id: d99a300fe20ef118d03f410ec7eb443b8945a118
prerequisite-patch-id: 863cfb8a300848c0277db5ac41532eaa5450f140
prerequisite-patch-id: 9fda09462a103a1406ae09d07e5f35fb4567f9bd
prerequisite-patch-id: 0c9aed41b91dbced80e5263545f1be091f496b48
prerequisite-patch-id: a91c3133fc4e3ae5662224be4eb0741fbd9ab1ef
prerequisite-patch-id: 928d89375bc60946614fa929c3bd26c0c3a68658
prerequisite-patch-id: c734691ae9518d1d628ee1f50ab94e2bca8d510d
prerequisite-patch-id: e1dc400a4a02effd9adb3d2c28fb44c52615d5b2
prerequisite-patch-id: 8db09fe5d3a46be90ebdf67d57ceae0779c5a8cc

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

