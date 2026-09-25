Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A24C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B3FA60D86;
	Fri, 25 Sep 2026 14:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSPiTXGkYdm9; Fri, 25 Sep 2026 14:26:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C337160DD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346416;
	b=iHPGG5H5nvywm1wq6cMdZ+3I14MNuBvcyTiVkjnkTPOBpADHn6qlsVdqYhCFl8fLn1mN
	 dPObP9C70ZuqQleaSZIGvJZivvu03Rmvk7faStcVHA2o9gGBx9D6ltMWDTgjJbev6fWfi
	 eI44JQDjFEkCQFTVf8C9oSlP418feGUcrwI7k49j+Q/QyjBVXb8nYR8oy3FLqlZ6abhER
	 jEXmXBe23OGvPSx4+bax2wmwnGDctSZvjVlS4QQb6dKuH/syeEGfi4Y1kXg2sHCIVPPCp
	 xrCp82Hv6gHyLPGGE3hG0k7Ueh3z8pa371OwSmmXl5rA43JTs8uWRxno9qBe+UFbcrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
	b=stI8Fn6nG657dwP9khnhkpjRR+krwQZnIS7d9Gf5ISg5KWSZlZTmYbNqOLuMkWzmjLCp
	 Ri9RVDtQ6BtsCBQEDaoowZJlNH8pPgh0JNdFyCGt2CCx2sQSkvesIP2liCSFPqymVGdUJ
	 3F3VwCif/v/NRIeyQyDKwnrf5FFB2nEr4sXAC/RN5ykctgGiLFBDW1IN1LcOEwFHbx/Ck
	 0zVz41ChKKFpPXAQB69e5wOOW25bnv06DTRp4OqLA3I+L3sAcJXUxHQQX7H/TY/KY66Vy
	 pgrRhRlOYtk+n2k7GlKwPSUIW8+P4a05Zirz9GQM4h2rgTECh/OBDhretwW2A37kjoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hjUW3eoM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B7oS541s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346415;
	bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NffKpIApzX4RoRJeUoLRIFbYjtKF/jT61WT12utXu7DsmQCMHNGVESdv++5vh4aLR
	 XudVpCuAOwbStL9+EIUPyCo+5vGPEYim1H3288o54sf8epBKYg3iKjkc1hiQODmlSA
	 A8ml/V5Wcik4lqbL23UQyg5K1hI3xCq0QenEOb2KV5lDDlWahaXFDxBH6c+ImiCgum
	 LAkeII10mquPkdj0Vp/wVdUSgc5jm82ax5EVNEC26/7S+Qk6mxY5meIsyipi6xuokD
	 eOHJunOKY1wtEfcWphEYuMQ1xMBMoYKB7SnKYibFzsh0W+sERYiaBLZ6DWtREGuHTU
	 aEzuQuvJ1HPIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C337160DD8;
	Fri, 25 Sep 2026 14:26:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5063A33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BACD260B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4j-s4VU4Gh7 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 06D3E606E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343509;
 b=N2lMiY0DPZn17aB1xJIp6Oj/C+yL0dN0f7P5crGy4yqFB2Qlf4puEhC9MWzfOgWhiNle
 BISP2mO2r2obRQXI0cQBh+LRoUiSX4agf+kX7qKIsu7/4GA2JYeZtTwwVr94IN50K8kRO
 mUhZAROJqBOFXaxxgpfBqiWd0dUEP3IEhmvKgfC1OYzFM4typOSPsoXmvfa/dYZGA5n3q
 2rkUODlQuBilASKRIjdRXZ67X2inBO+tPRtwDUEkyrLNvOJ2/QRIV8oHP/8wqDQ9UJwzh
 +8CIdvjvyvdS8bNwjTf5LdhXxZecDqejTZUKUxU2Mo7uo3h8vxbNuzburSqNh1kJIGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343509;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=HRFHu47WxJsLFfuIzkcyziA+cbkGCCAYUBNVzTxAS4lfqAignKQhuR3bDJBNaaiLJdaI
 8RsMgDatelusZZMFW08v/2pvGD8EVVSdm9CJvhiqYJzfbQzli4eQ/nTca4eTEFF2JOVfN
 PHD4pc8+lDdzGlnfv/cLsvs9ZhM/GSR3hFqWw5wbgcJp0/bXbDA79Miw08xfrOfF5wcPA
 ym2CGiHZsmiRTK7IkaPJRZa0VQwOnabx30PwWnuR8nGScSERbzoscEG0AeqJUR6Gru7Rd
 YOufjmmHpfE+Lf12l8tixAYL/GAElHhcCuuGfu+JRRHtQgVAb8Gvb9zaCOsDlGugjNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hjUW3eoM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B7oS541s; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hjUW3eoM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B7oS541s
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06D3E606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCtNnW208828
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=G5VyBcsD3RA
 ZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=; b=hjUW3eoMVJL2klncO/dmysNFpmX
 4CpHsTSYTS3QkwptbMDkKJXu4xeB3j6SioLThvNocE782ToH4qSpDh38CI7GORuc
 qWP3pOhgWaxhbt97LzledhymS+w8/NIbdLvVPCm1L4il+kmoIVJieRTYPsuujAk9
 A4zBUn6mGuTg7gLxqWKLmtBy/oTCUhzM98bqoAvE6gPgUDazB1YJOKbpO5BLWeIN
 BQEbCUWjipho9vGLJP07NAOhjJqmq3ccj430aHFlQJ+olsyD6cvpFBX+l9+oOyb8
 ws8B3nD5/UcDK7Yrphit1B9JTWniYjEPdj7tP2I46Tu9XWSWg4OjQ83S5Pg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898upe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:28 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-143803143c4so2396912c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343507; x=1790948307;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=B7oS541sFqaFASwq0kzIVqB455m4MqBNPeTfbl+S+y0ky2dNyzZhS6nKQRQhFUIpMz
 OrMPflUFmqJ9dyBOt6AcM1MKJsI6OUL0tCmTfjwpvhSv+DF/JBhZzjrG0cR/2uEui0do
 D0SKyQJ9yjSf7OttpWMIWSJ71pNiUuiAHG7C4pvtFFHtH9XVv+aEJ5EghschX7YLJduY
 gkY2mb5Q6dbSsrK/yqiJKHGnoqp6NFhJ6QHX5HHXMyLJJv8zwMpS1ddZhklpEqu9FN9G
 QvK5tn8L/IMrgG7rZ1PVADLsjfcFY2WUJzz/3I4h873TDxmpg4RsAMVCb+zwil8tXM1W
 Grsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343507; x=1790948307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=UUhEIT+wa2bNry9zIzLy+B+O6u9vvQXQaZXsNfnut9CwI7cWETgdSNM60LeFos285b
 VJ10jnBFBxnbmdK/cUXMeaU3rBEdk12uSLMF3oHBCDbmxVV6/xb6yZGJelBf2LFDMnkf
 6vctnm9cdooPwRYxoi43eiapYFtWdw8SPaIV7R7yn7RkZlwVctofb34W7a2keA11zvgu
 ufAEN3OQcwrVGMGN2lirerc3QJlHOZupqON7mIGWCqlDo6kKBIGusDDpx0WIb3mIRJk6
 VphBPInEdjKOt9bNFIw907f/rSCxNF1ulL86RnvY7UMYpQr9PgDdMb+0oYMGkYbuX+Ed
 ezvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC9C4Ib/dDLVYXWq5F5m4BGstY6Tz3JR75CJt+qgWnVh7y7hZR32G3GsHUbOx7OZVhxhTyRIo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkzC2iwM09roDL4WynxnuJ2r8DbZfP8hHr2WV0qSh9WfO4w8vP
 xMCm6BxNa6jQDvpePGBXjHEmQcBYT1bua1gIoOwy3pWbo0eDGB0qWjLpEoFrc1r9/CYRmgfJ1HN
 H4g5lYJEWSGtH0HA8Fb504INDR1Sm6tVhjbVa7KHn7/uFBmeayD+95PxmQ0+L9yrIGO1BYYk=
X-Gm-Gg: AYBFou0/+HnmUnHvbuualGcLKIJa8wfBA7ZP7dsXOum2bQXSwzp5dVskDDrhrtLLtSO
 SGza+FoY7xKLN9EARuH3cZS45kK7jhhcpPznWvMzsZ756esSyon5T/DBbhSpGWRd175uIEMVhq1
 Y9+V/WBOeq3b4Pkd8QkdNn4EvO9vhqa9FX/DSf33GRPWGjlw6r7NryttjU5BZh5xBNi96UQL+r/
 RBpozvudTqYVhNLb3fXKpjr7zu8s8HwMFsCZrKuFKuKEN0HpGNXsXvSDY3A0I0WSm0nFtRsVGSN
 37bRw18U2nHTYUGR7cUDE9k3Ec49mvX6o/gk2E36fStRLdmLyCZ4149spr4JaLOD5lUF151qvTs
 0wbl5jl4VXxVNqUMFsBmI0p+k/vu+lDGTKqzHeGqhgCcJUTk=
X-Received: by 2002:a05:701b:241a:b0:13f:c85d:17bb with SMTP id
 a92af1059eb24-146ce1a8af3mr265345c88.1.1790343507193; 
 Fri, 25 Sep 2026 06:38:27 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:13f:c85d:17bb with SMTP id
 a92af1059eb24-146ce1a8af3mr265037c88.1.1790343500736; 
 Fri, 25 Sep 2026 06:38:20 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:20 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 12/12] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Fri, 25 Sep 2026 06:38:06 -0700
Message-Id: <20260925133806.1403713-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX0e1kizkxlLEx
 +DsZo2bsbR+yVxFq/35UeJJcEEDd/L8fqx4A1jMt2inkmlT/zjbJ77hHfs82taIm4kUdbV8/WWe
 crf9pTDZPoS2OevnXbCOVMDgFS1qUwo8vSOfje7vUdEzfi8vtipX4gJSJqaiKORPaI0wyGUF3Zy
 em/t0hbSbqthXjnNFOcjRQmtTit2hcZDbfYs8VZvFjUdn0jscJQkI5+po41eEBFl7hyPEUBTWLy
 tCQllt/EO+8+oa39sK9CIkemlWgaznVIT++Hgy24pPhJiculK/GL3vuFb8QXYfCJYmBj+7wMg5b
 cK9YSHzwyk/MWUUwkCKPLJazuJHB6v7K8X94oFPeKOZWvIHzgTFR3iyROksDdKTzTVPjh1cdTuT
 mTgZTSjxBnBmkOy74QdKJICnRie37Li9hiRru1QK7K+Ta6npQSJOylMIbJM/0r0/SYdM1aLeLOv
 uoO2bzQPJKi8AmN9DSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXziEWK6bysoX2
 ocOFYHc+ynibnFRTdSEchYpU+L2x3Z/G3gZ310dEtit21EE+45+AS7t8DV4ZuN1+EyLux7KzAs+
 K4G43zQukd/wKO2+up64psb0fgWP8iM=
X-Proofpoint-GUID: mbnkqIi30HcASAW-vh5qBZ16ig_moeYt
X-Proofpoint-ORIG-GUID: mbnkqIi30HcASAW-vh5qBZ16ig_moeYt
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab67954 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=l66fMvErkfCIGnPQoeAA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 configs/qcom_shikra_spl_defconfig             |  1 +
 4 files changed, 67 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index b9c0362117a..ceebd679651 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -135,6 +135,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
index 7bcb3e21a15..1d997510c77 100644
--- a/configs/qcom_shikra_spl_defconfig
+++ b/configs/qcom_shikra_spl_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_STACK=0x0C294800
 # CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
 CONFIG_SPL_REMAKE_ELF=y
 CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_XBL_SEC_ELF="qc_sec_local_signed.mbn"
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
 CONFIG_SYS_BOARD="shikra"
-- 
2.34.1

