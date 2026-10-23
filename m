Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AC606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lkl7m/JK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJ9lGNXi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EsMiu4TO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC85E811CB;
	Fri, 23 Oct 2026 08:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAXEpresZCzy; Fri, 23 Oct 2026 08:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5C77811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792744828;
	b=PJCNxcZZ1goTy0V9m8AS2tEGkz/tGtX5IVp2yL7jApj3qJKNUYCZbYejvW4REPLYl31q
	 9yfHRFZBvqnJDnhKCyPaE7v1ish2mfH1TuxH5Q4UFh0gxnizNVJ8rKBXo2nH/kBHHMgpB
	 5NqldT5Wkbg/BXEVUOq+o/hHXwOH7T8Lafrj82L9Pxt5EzNrCNMfD7FTXtmNqCVYevnLB
	 R+Z3LvzU52rb6zc/2ascSvlvl74k5R7fSSkV4vuEkJRWUVqBus3buE1AfYF7tBDXDYfho
	 uPq097qwUEfsNB76rgOHtFAJiAFfsZqR6gJux8Nkbtquehaakzl5Drm7ZnJbLTj3e+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792744828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4Ta6N93NU=;
	b=KaeWH0dafLU3H/KPRVTRaWl7cGvxUZv8IZP7bynrMr3J8fMOaUJdC2ZNhngyylwJ2Qqh
	 ZTf0fAS0TysyFQgvrZYiWhon+00fPhx5j/tkNrmZJhkwMMNEZ45SiM30tcm204DdhkTrr
	 5270Epuwxroo1e7A6vz4PCnEqbhGS94r5ZdDEkLcV+libkFrpqibQQmZNpRgGyk0SAr2D
	 N6Gs8ldKy93YZKGDME3snMIzARIRkL8hZmxylDcBpvCs17bdoLuDfY1hhXev+1o6D4zat
	 qw993Kj2gw6rLdofJmebe0Np+m/Nm9Vkuz1SMhUawCzin3Ej3J6Uz9opq8nXkTaBb4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792744828;
	bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4Ta6N93NU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lkl7m/JKzNNmlmaoC7Et7NqXGLtqAVLzcnhwX7+AtDheSxVIXqilhkBT+RuCm4M2z
	 I93E0WqbFN3lylocJse8pxmqm1MRXwvq9STveOdIb0KkrNOKwrm5Ky3hV0pyoeV7TY
	 qsnWfSrnhcsHi0f5fT3EJtdFczxkRIGaQLrs0OkSQN+2I9wbvhzCgOChhi1AL45Mfq
	 X0JqmgomySyvdFABLZMaD8K2zrDzatZcwdR9PAhwZON/8NKjBuyttswg8NpQnRkScv
	 hSuVRmosBlgEyMVtCBXkIDPhHpwpJRHPfB8NyNHYn7FNV3sM8Z0uhYQbiP4YYk/PQd
	 yx4mxyNO3Liig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5C77811BF;
	Fri, 23 Oct 2026 08:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF54E4D1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0C63400B5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQpGQUpN2iT2 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 08:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6CC74008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792744827;
 b=DBdaAdMTXrDiiKCN2hsHIiGmWuv7e6a0Mdjbfp70g4Elr+9r4tduBByLOsFOjk+GWI3n
 xCJYZqGm3Q/pMeLeWu021SACCRrvz0STSEcdXMPF3+eO7r6wO2ip5m/9bWIzotZrVtRjS
 0kDirSRXkdFFhgj7Z1af53pwHX9c7ITderMMs1FNXhHiQkuBZhREOCQc0AHl6bXZDLRG+
 Hu9MpzoNIjliWfh2ai9D7w/tP2C/a33MgVGQ+QK7lChFfW2H6NdLq/bG7SnGugjX52uEG
 pmZiMimIpsBlEJz3AWSg/T3uJTMp9UCWdXVi/bWrkbJ+G8HOiGVyTFNPqiUckJTuO8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792744827;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4Ta6N93NU=;
 b=bjH0+ulRh9YRg73sZiXgfs3zJU19pMQhoBIGYYJ3y6wQde/t5to692WhGoU7C5V2Im4f
 WM/waR1YNdUGSROlWEx0m2iAx/CTOX5Epe28UmM5mrGJRxoiJ3nVGrfp1C5kA1oNKudEJ
 2OcuYni0t3R8P4/tfGyVGeNVryhljxXUirNHz2fWHYRebsnhYk1NU+MbqsmkuKmhgwrWM
 vQQQ4JRiANATmNh+gPrBpRObReHgFFLX+4Wg6Sq7haJ71nAuzh76+zGoJOm4ZE64jI+v/
 FREfzgZO/na5ffQEJmSC/Z/kDMYzoXMHpFfQggXGPvKLmzD5GZlQfHzsu/pVBbzI6tg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oJ9lGNXi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EsMiu4TO; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oJ9lGNXi; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EsMiu4TO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6CC74008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F9tT2112120
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4
 Ta6N93NU=; b=oJ9lGNXiJ7DD8C7CFlMvzmkXjgwO98FFGApgOHvosK+49thTFbu
 tsxyD6BEEbMJpxl9VxoftYWPNXiQekYrEUFroZ3+IgQUD+GtCHk6MU6/luXN7pPS
 StBmCEj37wmK93IyN5Z8taN/4JvDveFR9Pa/kNi9vqPLyNwbL3HgYqZPGtZVZjnd
 RiFB/jmV3a2vQLtJhPDYJ1SSD2u0otWEes6I9BdLkJVS14T+nyx+fuqTJKCYJIMS
 1M6RNbyhy0qm5TWiv7CS/u0NXqSj4wYE2MBPAwE0vkMb+9AK73mwHcIavQUO8ShM
 31NFJfuGV/oN1pfCE0vialBsHOahMsG7NIQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyka76w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151dcfb1569so785165c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792744825; x=1793349625;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4Ta6N93NU=;
 b=EsMiu4TObf8Ahft2vaD+Ly/ITyf9aHxLom0qMlQDPLdNtHupp2zVAmUVqx9B+Tjj10
 o1drI9B2u+RCG4VtxWbrlufM3wekouBh2k2gQHVwG85TY+GCY6JzLYt3BVnGFKvCeJKV
 Ib1vPYwU9B5I3sJZ0OZ7DBsUfmK2rHjNuQQPuib1sHbSsO3qFHx18YN2otCGqjrNk5WC
 X72nsyffpzljGz4mlXlEO1oScZjckgSgosrnCDf/0OneYq1rrEuoewOrlAxy3nLjzkiX
 D7HEsOe4BAlR4FfCQhTsIvDVIJnELV/Tc729wQiLGOtpddk3DdEhkGHbDdXEPMj/QLye
 lZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744825; x=1793349625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1CAUkLqLis4Tfie811HywLWwZ5z2hV/6HM4Ta6N93NU=;
 b=cSwkluF0zOLdpFQAvhlbLhf92T7szgtos6SL5weeAPYvdmCXkU5G/4ss4wNmlLdtVo
 WN7dWPLeIpKcxjTzT8ElYkGcinNN25RGgtHcm0kh3BZji9FzB6feBVCRGpDSKTxIxOr7
 mFw8h6eCHChFtX9kPHDslNefD1tR2XgD69YsRbrovEFRmQHmU71QrDq1XYEMQqYdJXn4
 fhQGf6kF/kOtcnawwaxzpnGO0iCioIZTLzHtSt+cJhGE5ogN8UicyjgXVU8J71up6kGI
 akw5jWM8dnkTkBigKUcNmMgNMVR0fpaFWZqk21OZdCrv0p4UTfESkL//hXZm2VKhiiUg
 LwXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn7DLd/MbP7z8bhfb3yErBkTpMJzhZGcyalcSeIIzq1npTO5shPQyFTi9+ygP1ieJ7GqCWU+E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLi4P6Zx3IZk5E8caHz1oAeyuZi3/ozctX1LCdJYv0sGD5MCZrC
 qFF+GTrl0rMPWN72Qa9BMscx1wcVdSpHLGDwE4qH+jD6wzl9xdA5tSwT/ZHVP3zpilB08Co5/KI
 vreiFFHeP36Hs/MK6VesPMc7pp6HtO/PUQVRqRFqCRogFwPyBSiR6ZmVCu0M5sBRiuxtmwvI=
X-Gm-Gg: AYBFou3bIeuModvcw5pzT20t0ONY3dltfepyzAnTmzMz190fpn5z2SNGW1DbNgevk1F
 NLYiQNN79NtlY5H1LE5Q0tpRC4qvAJNgB+YZKBElOMjlqXh8kwh6NnOQkk8EGmbw+OP56odYJgJ
 QDtF5LVu4dt6vwSSAi7ooybKoK2YRl9R03zlkB77ERgQhOqyHNTwTwrZvEXF3/OkqxXn0TwluwG
 lzfelSBogWUnbCezirhJXn2dhUI0JUSin+xOvhew8DK8hiT+pcGVc/Rnl1oHr2wGgZo4YbXtnPZ
 8Huvj+5re2uVH9I7+DigfdGDYmOJhXLRqDAFYFt0lzVmJLY8MGL7/y4FGogUszOYRkC7vZ3lwsR
 PG2FMZeUai8tGheVGXzuozj8PtgRVDYRwcx0b0Gi0a0Lrv8s=
X-Received: by 2002:a05:7022:4081:b0:195:8fa1:b447 with SMTP id
 a92af1059eb24-1958fa1b4c4mr1940056c88.12.1792744824880; 
 Fri, 23 Oct 2026 01:40:24 -0700 (PDT)
X-Received: by 2002:a05:7022:4081:b0:195:8fa1:b447 with SMTP id
 a92af1059eb24-1958fa1b4c4mr1940024c88.12.1792744824093; 
 Fri, 23 Oct 2026 01:40:24 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195ecee637csm4748516c88.21.2026.10.23.01.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:40:23 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/2] qcom: spl: enable CDT for shikra
Date: Fri, 23 Oct 2026 01:40:17 -0700
Message-Id: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX8W3kY4lQCvBF
 l/vWkzn4NwcWsturTZgeQxxAOZe0cXPrIzDmjgZL/ChH7vRJH3LrrKbCXzkGxxHFHRjClhFYMpr
 FBrXEYztQcKLOkdVCt4DSo8SKiZaLcTaTIDKBSI44mVt0i7dXCb9vS/rjTsLagdYm3ghXbeeS4L
 9+NDajHPvbbiQtEZHxwTx/dyMLgnrccQbJAexDW04WQMcNV1+5+5Ut7NrZ0qu/AnIldf7ZJ4kJd
 4L8YeN1GmxYfWj4pGXxIG2RTZYFej1Y04eFhDk73so4IeDLDi7NiMoZ82KTbsVjB6YyAR8teWCm
 LwZpB3e0Js18k1knHNQuvyrMAWadrif8HR7BhD0WGiS7LRLVfYRthobwtXAPPuDt1+6SKNeo1nR
 RIs0l8F877NwisrPAmSDtIYHLfAlv4FbgArXYL9jzSAfU8Q7+2ZJTYRRC6foVOdrXOJL8hGJBat
 4W8nIKc4zQuIzoV15aQ==
X-Proofpoint-ORIG-GUID: iS_S0ViURqpsrd03ui9tytGu94rK3sQz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX10fGgJ22EfHK
 7XGemfS1VCVGw+maFtkOVI4gcitMXFzqd2mDm1RqMY0Ui/7PTY1wjOiQiKRLSIXCsljNgkcUuIk
 5+BwlB+UNX0UUyugwVtRxg2htFtqAEg=
X-Proofpoint-GUID: iS_S0ViURqpsrd03ui9tytGu94rK3sQz
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb1d79 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ccmAHKitp5jFJfsW8VwA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Depends on:

 - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/ 

KR Sowmiya (2):
  cdt: enable CDT for Shikra SPL
  mach-snapdragon: Kconfig: add CDT configs

 arch/arm/mach-snapdragon/Kconfig            |  47 +++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 103 ++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |   1 +
 arch/arm/mach-snapdragon/qclib.c            |   8 ++
 board/qualcomm/shikra/spl-shikra.c          |  11 +++
 5 files changed, 170 insertions(+)

-- 
2.34.1

