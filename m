Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC491606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XMbY1j+3;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDRL6T53;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WD1ci5Eu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C657460A74;
	Wed, 21 Oct 2026 12:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q3urAW1DsqdD; Wed, 21 Oct 2026 12:50:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B48406085E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587029;
	b=kvthp6VkQnweDO0tnJ47MQD6YY5JrwGqO6qWVNgC9cHE0HVBq6q1lBMfHqreXM961v4U
	 EuTBQTNvmByTwuSPrT+28dT+9jsQan6DFhbjdcyXQqCMieIjYD6aDRRBvGDrbXIckdYrW
	 Pl5oRVHPGpeAeXqpyNVm1W05rlDXTqyn0L3iadarJHc/wZGmEOIu5cU9QabUfiHfzBLup
	 xjZc2ojAENE+wy1S8UD6WmNs3sZccnFeJpopBRLcp3eRlD9vDYUMQK3Sp6y2+TrnzX6xb
	 jx3PSod6FX6wugulj5ZfHNg3Wl6YamuNhGKAmukCVJ93VZGVt7qyCLeqYEmTRxXvX7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3zHQ8FpBHIai5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=;
	b=WQ+6SO05/pu2Kq7UgKRaKGzz3I3W6k8vmk+I5oxF9S6yDMrXtiUPAaDLBia0gpT49rQp
	 5KvrekqzdebIhSulwfgKnZ/FWnxDzHf7L/mDmiNUJYJss2Wnv6tVgkmivBXOU+87JokK6
	 Pv/q1Hx1cTsY2rpVH7eXxA/SEZNsu/ID3XlOKsPXLnzqW8nNhLyPbAERCrVnQQhUhO78P
	 Xrkn18pmBCEAf1zNMX05vG1T+7UgjO70CwJtQ9lE/BOoTsWMuMRw86lavaAJbyRj3mNiO
	 p8Fm81J2lW8wgIYL/wvgTBBrnL/+x9Q37a9PDN4kU5XlPec2RBXtcyTa4JUbLmCVk9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDRL6T53;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WD1ci5Eu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587029;
	bh=3zHQ8FpBHIai5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XMbY1j+3aJSQ5G1uP6i3Zmy0R/iUXSlTt6H5ktNfwimrbroTp3bInNKHA+QubUhLJ
	 Qx8XPaFVLA0Ts5V9u8dX/KQ7QLJnAPh4lPR1sXJpCDAYLiH1TMhr0sUNTdNEiguWB9
	 mDk7HSqREK4ydHF6tfqHtQ4Gk04tOdkxYiU3V8AqwE2g0w+HjetFWLX6hWGyZIzj7x
	 gegFU0uS11pz+RWnCD4UmVcl/9bXyMgmfaQnFdxpHlLpW4rnlmVtK9DWG3ABQlu+Ge
	 +0zFsG/1e4Lv6BVwb95OUe4RJZDbT1l9VjST54Af4+m2VtAruYxJXdZXKM+HASd/9+
	 q3sCEE6nEistQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48406085E;
	Wed, 21 Oct 2026 12:50:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E36FC23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBEED60A72
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tj9s2kNBzdFL for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71278608F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587026;
 b=Bvpea0YSjIiv3OENckyiVgJ22H5d0/KAOrh1BKaosAmgy1mBLL+cuD12woaN2RKlHaaE
 6JykerVR43EdA2t+wccTau6lRQ8X0FO4N7NyQ96tULrXVltfk/3Kpoxvp+plhFSfxtNS1
 LQcBlC1TVIWZpzZi3QFQ+xwDqUOnnL/z0rSHbdCxYmyjPhHX2/X1ZJvuNJHiKful5PcmE
 y99rlwHGeIYpyJw+1j/MJJEiBiviVUPmJcX+IcpoO8If68AIr1+Y9f9MYqXbKG3pQp3/h
 cmzttmvzDPA26M3HNTKclHXcXtzumGu3psP97Nzn56+AOxCVyvbcJjCB7Y5I9uYuqgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587026;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=3zHQ8FpBHIai5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=;
 b=cL3shd2oTZ3ShhAn019PaElUS9fA01/NKRP1nIw23e8rzFr7sCdIp+FyhYMVpKyzuW9v
 zgou2pyHGLQ133eyMOKxwe1V1PArCHW+JoFH2drTJzReXXGAd8M/A0VXtHM4Ya2B3Wp3V
 u5L+TjWLjsl2esH52PYnxSbrk25mFbXb4cO2XfvZ8b/FvSsJo5aCsd6bZ9KT/yjs3gL1Z
 VUiCziTSM53N9LIbS2k9BC2Cd7XyxphHB1c3SPIsYH4qhM4rmnu45FT/eH5Kh88chs4eE
 WlfYzOqctx75Cr6959HfzPNb3Tm0W08fZ8wfPC5IY2bO1mc/Wv6zeoHPe8QXHuhCzhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GDRL6T53; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WD1ci5Eu; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GDRL6T53; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WD1ci5Eu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71278608F5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBfxgt3829324
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3zHQ8FpBHIa
 i5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=; b=GDRL6T53T9fmythCOSFGeqsss3y
 H5YlXYNYunJCJpuTQuiz55henleVNS/UAf8l/CrW00PLx2OANtRs7Gf3CEf5trKv
 nYn7/C/XQmr4q3LzfbWu+63yTymv2uZn3j2sOnASiiAXtvVTgvUMn7RDgkM2D8n7
 /N7c39BdczabzYvKUMzvHX3IMzrGNmj/rT6CT7eNv1b1K2Sdez4KrGUsBVibeaYY
 TSpIwbqQk8lHW9Li7ytNYxSDnKbqqlWhPVBtt+TjS5bNXAgbzqpLU/uOKfHlxLc7
 SL2aW3vuyOa+hS3WUxfprI9ERboV/Zqrur+gv9DjVAsmTsEE47gSKkQdcjw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd4bdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so985577c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587025; x=1793191825;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3zHQ8FpBHIai5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=;
 b=WD1ci5EuzH2CU6LG99oMvZja/5a6d9e6OZk+pk93I1RVeoGkkhcNCCwtvOmlFjPut3
 Qkt7+BF4e7OcQVgEzsLjrik/qddHIF+2N4veRRR8e06Ud40USlqcGSbfOL5UNUoX/MFc
 fPRJgZVglDf14p9OcaQCJXD9nTqyS17B3al+FmGLKcVRsKjCDgi3526aBetIH0VLrnSE
 C5ub6xnFveYJHoYnDqH9VYrQOp9MAS5j4+qLmCu+B6dTv3b6oUGzCgO7vNrIv7YrDVA8
 DOxl2bYbpU04NI+vrkfXQCct05UMqFIgEZv+6STQo61YcwwfesuOT97SwEy5HVVWsdDX
 mGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587025; x=1793191825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3zHQ8FpBHIai5w+yDcVMTAPkM6PQFBaEPiaSXzOYJ1g=;
 b=HvumGKSZl83cmjMhcVdtVCs8Lyrf7uKIMF7edPpqAtEvHnQyjGn47ebn0Gk2lpVTvq
 dpyQZh4apmiywWn59mzupHL8javR3A3aofLYcZhvxySbm9n6CSwChMSRcm9mgYEf1F/p
 Lgg1Sk24340YNlt6zBCYEzeRq8zHOSVgsHW0LcY9KHH/bi6Vda4qlZSULOmmAt8Uc+ex
 /DOH4xLVtFhj1VhsJ4z8Sax/565fJ3zEzFY2ufGAh1dO9AgAuLOOyoV63vhTIdKMjlgq
 fXQma+XsvIbXuIZ+K/Hq33q0rXKa1+H35bWk9yBPgfY8CimP7nZoEaSklAUI2h7FGsLS
 RyjQ==
X-Gm-Message-State: AFq9FYKLxVla6jdkswqvVDolTiWvAo0+qNs+Ad+NTSwlbS/qV7WTPQS2
 OS5NSOPb/mip9CWP9PcG3+sZ8KNWtZNzwY5BFepmxdpuwctrpYtd18/Pxz6xniq/1SxzZfsjwQb
 XhpeMplw/Rfv+jl8JGyYVtXjqaHYdNkOEBbNMFLjfdYG7sz2ytC4L45bqgY4MK5PMbWhR7TLQIp
 dvGts=
X-Gm-Gg: AYBFou3sE6ti4vdIRQD6XI8S1JSLbcjAefjqOFRJwG291/JP87CVT3NOXCx4X9tzyC+
 3gIUhkbJ3U4MFxYZfpDCrLCRwTXFCrI7+m3VtCuVrQ73+cnZlmjntX4+hhXxX755DZHtpLZ4a6k
 btHFdnBAhhlgDPfBr1cbuFKAg9sWYD6iUIN0iCCsCO2SCy8uU60uMnFNwDntokAktZZiMGlnAYt
 zzUdZvJxb0dU4T9DU2YQMgnjXKcZdK9nXdeOnMvWRil1nCw8M6E6pB7+U8ex3FSFcMdaCY1Rqzd
 epnhPUIAxjdtbJ4p1xgDG8kcjK3VIugYj9oHOzDFk8zhhMsRrtODwTVyp+VMscP6CrMWjPFvfUx
 UIfuvZqB49GgGQ3Tl/cRJ5KgJsgD26FH0uh9YnmtXMlTLETsniry3Gto8BLLi8fxxeYqvC5NiV2
 dH6xRXH68pHd82uZVffJlZU53IsH1YSjxbRzg=
X-Received: by 2002:a05:7023:a82:b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-190a4c1fa39mr2538662c88.15.1792587024735; 
 Wed, 21 Oct 2026 05:50:24 -0700 (PDT)
X-Received: by 2002:a05:7023:a82:b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-190a4c1fa39mr2538602c88.15.1792587023921; 
 Wed, 21 Oct 2026 05:50:23 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:23 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 3/7] i2c: geni: Fix 19.2MHz timing values
Date: Wed, 21 Oct 2026 18:19:59 +0530
Message-Id: <20261021125003.2948090-4-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXzY62hcRJQIwQ
 JgstNN0DDLsmi4NpU6EEunAQIYhHJq7Or9PFZaNxdy+vbvvztBt30UZIhnKo2OCMOwakY4fMVJ/
 v1a+LWwBKI0VJDe6VxV9X7hmCdpFSjmnyjTFWmYZ3ApzucVft90bkRKK8qqsCDwBKpm0QBJ8sc5
 isUcvTKiuqteYqN8fkvIal//CzmGCkNADWNvoY4zHXFy/FSgCQGpxVsqURYMkH7oVanZ4rDIBet
 CmktYXkhqdKLCTEHI7iUIdw7lTo/v5CXucv+OX5UpOTn8960fy/fIReXVwfbYGTgqdtg+KHtd4C
 BcYgp/la5Sfm7A+6aIwEEbG/U3bGotSVVk3rj6HhAYzW5oUfpA32lT8uu+Zq6AA66MytWt6uiSb
 cUuywm8vh9hq5GS20XVZROP6hBt8ncxoDgufbH7+N5OGaL7qAo/TzRZN6EAhv5Kq1wfy+Gn2XdO
 Y0R2V5+YbFXGXldTBPg==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad8b511 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8-gi3_K1_7cy-jEHe60A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: q9S2GT5jU7CczyaBhPSf4Lh0eNEiuhBk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX/K6lGKGuQ0Dt
 5sz/lB42uIlFloKgHUxbkld2MjLDT8dF1esTFv8xe23UYlPBzNpm9cftTPwegNp3T4Obw57izZ8
 /TCS8N7T60eV8fIsHHe1Bq765oVlDOY=
X-Proofpoint-GUID: q9S2GT5jU7CczyaBhPSf4Lh0eNEiuhBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210051
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

Align the 19.2MHz GENI I2C timing matrix with the Linux upstream driver.

Link: https://lore.kernel.org/all/20250505221419.2672473-56-sashal@kernel.org/

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 7498cbcb41a..c6d0d4f206d 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -97,9 +97,9 @@ struct geni_i2c_priv {
  * source_clock = 19.2 MHz
  */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
-	{I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
-	{I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
-	{I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
+	{I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
+	{I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
+	{I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
 };
 
 static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, unsigned int clk_freq)
-- 
2.34.1

