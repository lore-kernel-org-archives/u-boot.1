Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C77606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IO/L8KBx;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQ34l37N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C17Yy+Oj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 956F6408A1;
	Wed, 21 Oct 2026 16:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25j9eukzjfuS; Wed, 21 Oct 2026 16:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2446C406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598981;
	b=WJhH9jJ7xu8G3I1uIW0IIdZNktdp9ZB+zz66ke+3Ti+woqukGcu0SiCU+IIEQjL85/de
	 WWOiIHEvJFwap1IAeM7AxwUGN3X7XDPRp6Dp6D5KDIYJFM1oh4yBvnW0Nsx+ZZJEBqb6s
	 9vee1UWDccMKVETWFmWLFKrpx3niZ9RjhiJ8sJ7bKGygIsVF92wxwb+J5atRdID0B6A05
	 AWBD7kV7oaygj+Jy7EBJCDIKeySLo9vpm3eenZFdxlrCxgxT4DhR12aG/bHgYv91dLmwW
	 0wzlRsieYJir08b1T64cE7VMAuxqX/PqBNW8G2KTdMvF7rYcyLntYOOC2TUpzUrm+yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BewEsUkz9Zw3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=;
	b=TeN/nxjA8Hid8qlRKsByVh4uFY2lntO8tE2A9aZs2ELHCkgZc1uaiyYixwBwG8/SnQqa
	 C07OIi+DKAptrSv4xOEbHotxMh7Ysp+x8iAPOiHixFZBvmG+qQxkQG/zRHywSEkw937VE
	 9fXZdmTGxvsiADUs8/whJtC44z4dclNk6l4tbEH2Q8dADXtBFQG8vM4kEHO4o95rUxU+9
	 6X78k3NLE2lzasCjUoPEU4nrYzyqSxhrK4V+mMDQ3sQDWB4iKnF1+q27yZKyM1/2ylw7d
	 r/BWZ4FrZ5N2nKZltrxfe0NyCXgav/riF/YsUumQdouS83JvWXjdqKjmxTl9fWMUW9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598981;
	bh=BewEsUkz9Zw3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IO/L8KBx7jTUGTWiPThQe5tuhrkFFaMgahCjA4dmFIZibXdLp3C7sizMF2DwOlT6G
	 Oj249BOTPY2I20rJ2yeyzlp8wToI10OUJf7JPUOrmwMgP8LMY/UsTQ8tpuNS74CGw2
	 XWLAaB9n1zpyhmFAzhKPCfzwXw+xwuuDaEGxRidSb/6OLwQcpx/kkxf58CdHFxaoqz
	 M0ewLwHPh7+SXb1Z2ESpMeHkvRz4HEerkl5ih6n1U5IvM/lNArfl5hknDQAwl4mfaE
	 sUik5ygHgDnGZ04P26hu7ra48VO3Q6Hls6BQDGbN/PYEEVF6nshpsxxEoRZbA0asj2
	 gHyyI8lmtUlAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2446C406CF;
	Wed, 21 Oct 2026 16:09:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 883F4356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 857B54039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pva72HsImAZO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4AFFD40077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598978;
 b=ElGJfGJ+uVmNtg5WvemSc4d9nqcUoApLaUs0YqNAiXkvP+8hmYmRtEkp8lzr6UmQEmUb
 aKDtgwtGqhjWB+3tAHTlI7wUX61eGbK1UU64KvnI3a9yNxiUnb6qmQJVFOu0jXKvNbr3d
 ibF0YKecWMqYIpcj8+1ZE/Fr/dEQunbNC2bqT5tz3yXeFJJYdxQPiPKZbr4ZPTJZ0rn2P
 aynLK2/NUSP6NnWzt9kpI9K2+5ZGRnzsmOfF06DkS/i6LXZtoEI5mG4zRiobQIyNU0svF
 89uCouTF0SiwDquWcuVzxlVa0SJujn606zsNJmvzBWjC67nnF+kpS/TFPQ2qiGFlb+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598978;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=BewEsUkz9Zw3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=;
 b=L5hJPzfyLr3Vv8Xe1tqQlrcfsYK9G4ZqTwleIr8B4nFBY0SO+U5t9DMBHyY9Z3Q4wFuk
 67JZ++cKl7ntPpw+oIOwxOmTO8Ju1P3313Xw1YVDs12ZNBNqIGJvb50MzjA8xbO2U9WGC
 kbfTCk74zLQ5gyNOMZgg2NWyHbDqp7Mn3P/n6dAr+0EKFX/Po3CD95dEAgkHlK4FGScyu
 vNH+xmTcvrIj2oV2t8iKJoYsls9HeHRX3baoCWew7KeOYc4nu2A8nC6tfPhFj3aX+Frh3
 Dho3hAZbU8XdYGDLqIrnUBwwcgotKwecth6nj+EnLXTo9C13FK73blgNMSkvmeQqyJw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WQ34l37N; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C17Yy+Oj; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQ34l37N; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C17Yy+Oj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AFFD40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU0SF3726131
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BewEsUkz9Zw
 3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=; b=WQ34l37NP9QzopoBtlS8t5knh5o
 F/8d9owSPLXoFX3uALwoJpUYdpYcI24xImOAWUUNYXmwKeIHypeidB9DeF+LjnCE
 CfZ2m+fs8QTgVn7/qwIf+LRfv7TmJ7677TTrEYTGLdDmjrKGJy+WP+wiftWR/Rl+
 z3vZ/MDs3c6U7aAboroj1DOVu3ScUYChazcx8HBjW4zX1m+y9VZHnLitAIqOIvh1
 RyGrpPrJsTj8EvplZRqxp+8uIxd1KZRdJFRJmd0iuasoOFCEhjfzU1u/u1GB92PJ
 WUADv5OV5Nc66xfw8ILQX0intTwXSgjeKCyja7GvfoR9LaOw73kFPO1KNUQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79ymu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36696c9f55bso5295eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598974; x=1793203774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BewEsUkz9Zw3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=;
 b=C17Yy+Oj2hu9GgwxKie791eK0VegGvPVJTBD+7IIMyMyyXcq8ZCxbQ/U2ppabjCmL/
 dgJBQ/TqKQZilu24+PaaGHu+r3SuK7WOmSHpIaCW7keUpP2CkB0/DBgY2BdKk8lHuUt8
 KCkaz/+IPwUCaQ4uVWQmC1VVyj/GMefHqlcCpemDHKqDJi6JYIxf5+m+Nc6LmUEkDyWh
 hNUqu9cTzJeXRIkCi4xmXiOxwIwreJfTcJvCzSCoSeUV4dx4eTtW67YzygPxHjtNz8zR
 BCgwPqHbD98kkjOCshEK5gYaQenAD0OoPRrSqkn53nJQiBMfYfEWOXyOIEfiZuqK13OL
 499w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598974; x=1793203774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BewEsUkz9Zw3t4Cu6cdHKWIyeq+K02diA9v6Or96vxg=;
 b=wrwC4e+p+Y83dNvkyPZEfrppMrZi6W1sSFOERVRPUMWgj/YbYZoOWQpaEieOnAu1bW
 eVtzpHTtdaaBw7/Kp2aaME0EUdum4ECzFlvn3f05zSk1CIdWuifqn85MEE6XwQegyVMf
 3t2L/7hoxKgzTkFor2ticBWFDup2X19rndV7PKDAwahzTxxK0XW++kezGSnLO9CEPbnm
 +XcgOIvnkdwuS/fSHovHA/ZVtNNwq+iakXuXZX19E/XfzPYIednI1Miw9cO6cID7o1h0
 yWLvmbsvjaJBM0bZ1XWdxIP1Ks4ZVteUXzhohCSKFdkTLUJvbC3NsI8+wssw/9M5mNTS
 cgQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyt0bYlweQ871lxVWbrm6gusS8r1pcnhfTLT7VuOQ15DuCnSbW9hybv+WXPwpiIdV56qrSlkE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKkqzRMqo9n+V7J0kocX0GohgfYahysmBCyLiWrhYNSjxVqLmoJ
 uTm65n5lyDaIwGxtLgjZesDIaLUyq8wYCxI5GifLS45UfoU2yhj6VM4qun/XXOd+VNgr9AbQlUV
 LF6cuy8/EkVpOIVqNAVqEuH3HWX83MxvD2LBs2+YMfnYRvYfCqS661mDG+XpCVJoXrQt0u+0=
X-Gm-Gg: AYBFou1/BvsMqh2+WtlNfxof85nQFiYWcMDkP8JCJ2+wwbKMh+i+0wNjRr0hG8uWHfl
 y6O4IajX/rUpbqX8gwAcgjN3X/6MM5SduXg26pzVNb7wzUDA2AOurEjiMskWu08tKu3pqY2kI9L
 Ua2wdOAgP1wLa+dZjIDwSF3Xb+BHVbRF3xjx9vIxU66wY7amr3uY5FqnVqUSCVubTNPUyaCqe0z
 sNkzFis3NS8nhvpabJdUued8b47B1S0Jxx/8QU+ml25Am04tudTaMlv2W+CI4vMPi8Slb+4jMJ/
 MycfOcsfkIZ/PMiBgQJ97W6QgbRIMsgTBe/LHEia2YEjfMzl96gTNNzfU5fRhIASWhGp01pJhTa
 uFSt8KcLS5jIznbwNV4p0R5D+RsCmMRhrrCzrRWZkdKUyvhwo2BOpbRW83Nf9oexY7aTWwT6QoD
 KMIgom2Ln2a/Hn3b+BnfA=
X-Received: by 2002:a05:7301:6197:10b0:360:aeee:9b8a with SMTP id
 5a478bee46e88-365fa4906e4mr6691545eec.8.1792598974024; 
 Wed, 21 Oct 2026 09:09:34 -0700 (PDT)
X-Received: by 2002:a05:7301:6197:10b0:360:aeee:9b8a with SMTP id
 5a478bee46e88-365fa4906e4mr6691508eec.8.1792598973337; 
 Wed, 21 Oct 2026 09:09:33 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:09:32 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 01/12] clk: qcom: add GCC clock driver support for shikra
 SoC
Date: Wed, 21 Oct 2026 21:39:05 +0530
Message-Id: <20261021160916.3894471-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ppNIDr1-ewwKnJzLvyxBOJsSO-rNRSfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX/VWBFyEnx+Nv
 Cob7H8s7xPgjRI4b+mB3zpuiYZyJMa43imx1mm7vNGGpiY1bQyuUF+a7wVMIDu5VnHeacV2yqDd
 91M9oMuamCl3z0VeCfR19j8WvyajQ30Kzl4qAQ7PaPzHcOGd4Zp2BQDtcRKMoxbdsHusza/hvWV
 qdAz8Kti5Wg5nTqdwqjISQZkMcmQPGV2xbU+neFtfcqH4h/LBazb96QFrH60p37Xb7brwWXJKYs
 Z40JKHT5D8Sf2F52Syp4iOXpeeAZjM6yi12AWTdT6QYxkjLYc4/5F0mC6r7GxGBhbVec9BkyHtO
 cZLsWrIpp216AKsk1brsSXu3XpJ7RELMZ5Ax4kaUesdJsGB4GOT3CGtZZ3G7EKJ/aywHMb5LdTS
 X0YomhkZC/ITUoYfMNueGgr005VwGqqKgPfhKbGE1tzrs6lRLyIha0b38HA0LG1EePPMgsQq5Dt
 MfteSHguMwJJL7EOvzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX6mFUp9h2fTp6
 wo1sQqu9wtnx8CfGzR04mutLkNGyyl50iXJLsYc2WyuzdVgmKzYj2o2vWaKOZRMxnbr3Ebh/7ei
 128TMjYJkhiHXfpisX91CQdJKkV3qrY=
X-Proofpoint-ORIG-GUID: ppNIDr1-ewwKnJzLvyxBOJsSO-rNRSfy
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e3c1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=3UmjldmXXATIH-n5mg8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Add initial support for the Global Clock Controller (GCC) on
Qualcomm Shikra SoC.

This introduces a new clock driver (clock-shikra.c) implementing
the required clocks for early boot and peripheral enablement.
Update Kconfig and Makefile to include the Shikra GCC clock
driver in the build.

The driver currently provides basic clock definitions required
for system initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-shikra.c | 344 ++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-shikra.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..1a7957e2201 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -103,6 +103,14 @@ config CLK_QCOM_SDM845
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Shikra SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SM6115
 	bool "Qualcomm SM6115 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..58d8166072d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
 obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
new file mode 100644
index 00000000000..2c3c5c9b4d8
--- /dev/null
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+#include "clock-qcom.h"
+
+#define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
+#define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
+#define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
+#define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
+#define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
+
+static const struct pll_vote_clk gpll6_vote_clk = {
+	.status = 0x6024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(6),
+};
+
+static const struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(7),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static ulong shikra_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		/*
+		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
+		 * GPLL6-sourced; vote defensively even though this port's
+		 * only requested rate (debug_uart_clock, 14745600) resolves
+		 * to the GPLL0-sourced entry.
+		 */
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000,
+		     "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk shikra_clks[] = {
+	GATE_CLK(GCC_AHB2PHY_CSI_CLK, 0x1d004, BIT(0)),
+	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x7900c, BIT(1), 0x23004),
+	GATE_CLK(GCC_CAMSS_AXI_CLK, 0x58044, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CAMNOC_ATB_CLK, 0x5804c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CAMNOC_DRAGONLINK_ATB_CLK, 0x58060, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CAMNOC_NTS_XO_CLK, 0x58050, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CCI_0_CLK, 0x56018, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CPHY_0_CLK, 0x52088, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CPHY_1_CLK, 0x5208c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CSI0PHYTIMER_CLK, 0x45018, BIT(0)),
+	GATE_CLK(GCC_CAMSS_CSI1PHYTIMER_CLK, 0x45034, BIT(0)),
+	GATE_CLK(GCC_CAMSS_MCLK0_CLK, 0x51018, BIT(0)),
+	GATE_CLK(GCC_CAMSS_MCLK1_CLK, 0x51034, BIT(0)),
+	GATE_CLK(GCC_CAMSS_MCLK2_CLK, 0x51050, BIT(0)),
+	GATE_CLK(GCC_CAMSS_MCLK3_CLK, 0x5106c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_NRT_AXI_CLK, 0x58054, BIT(0)),
+	GATE_CLK(GCC_CAMSS_OPE_AHB_CLK, 0x5503c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_OPE_CLK, 0x5501c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_RT_AXI_CLK, 0x5805c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_0_CLK, 0x5201c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_0_CPHY_RX_CLK, 0x5207c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_0_CSID_CLK, 0x520ac, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_1_CLK, 0x5203c, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_1_CPHY_RX_CLK, 0x52080, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TFE_1_CSID_CLK, 0x520cc, BIT(0)),
+	GATE_CLK(GCC_CAMSS_TOP_AHB_CLK, 0x58028, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_NRT_CLK, 0x79004, BIT(16), 0x17070),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_RT_CLK, 0x79004, BIT(15), 0x1706c),
+	GATE_CLK(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x111c4, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a07c, BIT(0)),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK, 0x71000, BIT(0)),
+	GATE_CLK(GCC_DDRSS_MEMNOC_PCIE_SF_CLK, 0x29044, BIT(0)),
+	GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC, 0x79004, BIT(11)),
+	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0x17020, BIT(0)),
+	GATE_CLK_POLLED(GCC_DISP_THROTTLE_CORE_CLK, 0x79004, BIT(13), 0x17064),
+	GATE_CLK(GCC_EMAC0_AHB_CLK, 0xad010, BIT(0)),
+	GATE_CLK(GCC_EMAC0_AXI_CLK, 0xad014, BIT(0)),
+	GATE_CLK(GCC_EMAC0_AXI_SYS_NOC_CLK, 0x109d4, BIT(0)),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_RX_CLK, 0xad044, BIT(0)),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_TX_CLK, 0xad03c, BIT(0)),
+	GATE_CLK(GCC_EMAC0_PHY_AUX_CLK, 0xad018, BIT(0)),
+	GATE_CLK(GCC_EMAC0_PTP_CLK, 0xad034, BIT(0)),
+	GATE_CLK(GCC_EMAC0_RGMII_CLK, 0xad038, BIT(0)),
+	GATE_CLK(GCC_EMAC1_AHB_CLK, 0xae010, BIT(0)),
+	GATE_CLK(GCC_EMAC1_AXI_CLK, 0xae014, BIT(0)),
+	GATE_CLK(GCC_EMAC1_AXI_SYS_NOC_CLK, 0x109f4, BIT(0)),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_RX_CLK, 0xae044, BIT(0)),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_TX_CLK, 0xae03c, BIT(0)),
+	GATE_CLK(GCC_EMAC1_PHY_AUX_CLK, 0xae018, BIT(0)),
+	GATE_CLK(GCC_EMAC1_PTP_CLK, 0xae034, BIT(0)),
+	GATE_CLK(GCC_EMAC1_RGMII_CLK, 0xae038, BIT(0)),
+	GATE_CLK(GCC_GP1_CLK, 0x4d000, BIT(0)),
+	GATE_CLK(GCC_GP2_CLK, 0x4e000, BIT(0)),
+	GATE_CLK(GCC_GP3_CLK, 0x4f000, BIT(0)),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x7900c, BIT(18)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x7900c, BIT(19)),
+	GATE_CLK(GCC_GPU_MEMNOC_GFX_CLK, 0x3600c, BIT(0)),
+	GATE_CLK(GCC_GPU_SMMU_VOTE_CLK, 0x7d000, BIT(0)),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x36018, BIT(0)),
+	GATE_CLK_POLLED(GCC_GPU_THROTTLE_CORE_CLK, 0x7900c, BIT(21), 0x36048),
+	GATE_CLK(GCC_MMU_TCU_VOTE_CLK, 0x7d06c, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_AUX_CLK, 0x79018, BIT(0), 0xaf044),
+	GATE_CLK_POLLED(GCC_PCIE_CFG_AHB_CLK, 0x7900c, BIT(27), 0xaf010),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0xb8000, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_MSTR_AXI_CLK, 0x7900c, BIT(30), 0xaf020),
+	GATE_CLK_POLLED(GCC_PCIE_PIPE_CLK, 0x79018, BIT(2), 0xaf050),
+	GATE_CLK_POLLED(GCC_PCIE_RCHNG_PHY_CLK, 0x7900c, BIT(31), 0xaf040),
+	GATE_CLK_POLLED(GCC_PCIE_SLEEP_CLK, 0x79018, BIT(1), 0xaf04c),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_AXI_CLK, 0x7900c, BIT(29), 0xaf018),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_Q2A_AXI_CLK, 0x7900c, BIT(28), 0xaf014),
+	GATE_CLK_POLLED(GCC_PCIE_TBU_CLK, 0x79018, BIT(6), 0xaf098),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CORE_CLK, 0x79018, BIT(5), 0xaf094),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_XO_CLK, 0x79018, BIT(4), 0xaf090),
+	GATE_CLK(GCC_PCIE_TILE_AXI_SYS_NOC_CLK, 0x10f2c, BIT(0)),
+	GATE_CLK(GCC_PDM2_CLK, 0x2000c, BIT(0)),
+	GATE_CLK(GCC_PDM_AHB_CLK, 0x20004, BIT(0)),
+	GATE_CLK(GCC_PDM_XO4_CLK, 0x20008, BIT(0)),
+	GATE_CLK(GCC_PWM0_XO512_CLK, 0x2002c, BIT(0)),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x79004, BIT(9), 0x17014),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x79004, BIT(12), 0x17060),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x79004, BIT(10), 0x17018),
+	GATE_CLK_POLLED(GCC_QMIP_GPU_CFG_AHB_CLK, 0x7900c, BIT(20), 0x36040),
+	GATE_CLK_POLLED(GCC_QMIP_PCIE_CFG_AHB_CLK, 0x79018, BIT(3), 0xaf08c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x79004, BIT(8), 0x17010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x79004, BIT(21), 0x1f014),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x79004, BIT(20), 0x1f00c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x79004, BIT(22), 0x1f144),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x79004, BIT(23), 0x1f274),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x79004, BIT(24), 0x1f3a4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x79004, BIT(25), 0x1f4d4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x79004, BIT(26), 0x1f604),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x79004, BIT(27), 0x1f734),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x79004, BIT(28), 0x1f864),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x79004, BIT(29), 0x1f994),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S8_CLK, 0x79004, BIT(30), 0x1fac4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S9_CLK, 0x79004, BIT(31), 0x1fbf4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x79004, BIT(18), 0x1f004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x79004, BIT(19), 0x1f008),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0)),
+	GATE_CLK(GCC_SYS_NOC_USB2_PRIM_AXI_CLK, 0x10a14, BIT(0)),
+	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a078, BIT(0)),
+	GATE_CLK(GCC_TSCSS_AHB_CLK, 0xac024, BIT(0)),
+	GATE_CLK(GCC_TSCSS_CNTR_CLK, 0xac020, BIT(0)),
+	GATE_CLK(GCC_TSCSS_ETU_CLK, 0xac01c, BIT(0)),
+	GATE_CLK(GCC_UFS_CLKREF_EN, 0x8c000, BIT(0)),
+	GATE_CLK(GCC_USB20_MASTER_CLK, 0xb0010, BIT(0)),
+	GATE_CLK(GCC_USB20_MOCK_UTMI_CLK, 0xb001c, BIT(0)),
+	GATE_CLK(GCC_USB20_SLEEP_CLK, 0xb0018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_EN, 0x9f000, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
+	GATE_CLK(GCC_VCODEC0_AXI_CLK, 0x6e008, BIT(0)),
+	GATE_CLK(GCC_VENUS_AHB_CLK, 0x6e010, BIT(0)),
+	GATE_CLK(GCC_VENUS_CTL_AXI_CLK, 0x6e004, BIT(0)),
+	GATE_CLK(GCC_VIDEO_AXI0_CLK, 0x1701c, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_THROTTLE_CORE_CLK, 0x79004, BIT(14), 0x17068),
+	GATE_CLK(GCC_VIDEO_VCODEC0_SYS_CLK, 0x6d044, BIT(0)),
+	GATE_CLK(GCC_VIDEO_VENUS_CTL_CLK, 0x6d02c, BIT(0)),
+};
+
+static int shikra_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map shikra_gcc_resets[] = {
+	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
+	[GCC_CAMSS_TFE_BCR] = { 0x52000 },
+	[GCC_CAMSS_TOP_BCR] = { 0x58000 },
+	[GCC_EMAC0_BCR] = { 0xad000 },
+	[GCC_EMAC1_BCR] = { 0xae000 },
+	[GCC_GPU_BCR] = { 0x36000 },
+	[GCC_MMSS_BCR] = { 0x17000 },
+	[GCC_PCIE_BCR] = { 0xaf000 },
+	[GCC_PCIE_PHY_BCR] = { 0xb1000 },
+	[GCC_PDM_BCR] = { 0x20000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_TSCSS_BCR] = { 0xac000 },
+	[GCC_USB20_BCR] = { 0xb0000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1b020 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+	[GCC_VCODEC0_BCR] = { 0x6d034 },
+	[GCC_VENUS_BCR] = { 0x6d018 },
+	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
+};
+
+static const struct qcom_power_map shikra_gdscs[] = {
+	[GCC_CAMSS_TOP_GDSC] = { 0x58004 },
+	[GCC_EMAC0_GDSC] = { 0xad004 },
+	[GCC_EMAC1_GDSC] = { 0xae004 },
+	[GCC_PCIE_GDSC] = { 0xaf004 },
+	[GCC_USB20_GDSC] = { 0xb0004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+	[GCC_VCODEC0_GDSC] = { 0x6d038 },
+	[GCC_VENUS_GDSC] = { 0x6d01c },
+};
+
+static struct msm_clk_data shikra_gcc_data = {
+	.resets = shikra_gcc_resets,
+	.num_resets = ARRAY_SIZE(shikra_gcc_resets),
+	.clks = shikra_clks,
+	.num_clks = ARRAY_SIZE(shikra_clks),
+
+	.power_domains = shikra_gdscs,
+	.num_power_domains = ARRAY_SIZE(shikra_gdscs),
+
+	.enable = shikra_enable,
+	.set_rate = shikra_set_rate,
+};
+
+static const struct udevice_id gcc_shikra_of_match[] = {
+	{
+		.compatible = "qcom,shikra-gcc",
+		.data = (ulong)&shikra_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_shikra) = {
+	.name		= "gcc_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_shikra_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

