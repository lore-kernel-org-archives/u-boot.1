Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC7606A328
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U7DVGJES;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kLbHs9fH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MHCHpmhz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B8C860905;
	Fri, 23 Oct 2026 17:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wog7wufJN3zR; Fri, 23 Oct 2026 17:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBB6D60652
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777504;
	b=hoT2HhEDDYdFaLayJGR61wUX+kTaPzwbCJ4d8+hUsh9EXFq6YYzrArMtVck2V9f6/4oC
	 dLwr/c5mnRalquqpRQTxtiWmR9aiUQ8zGOaevnep5CDO/KwJPe5OA2WBnArtkBvJ+turt
	 1RwZ5bw/x+jWR88uxcdQrVUbLuUVhM758OC/NulefpR7xPURa6B5w4Iy1nyYNE4vMRiHR
	 IM0FuAnhGgYkp3CvcPosO73JcNq8Ke7xH4bP3x4hlfeNmWyi+Ff24toJkyOVEpZPuZ9Ji
	 xYyzFPdASiGYcMY/87AhPAgERwsGSCRWNZUXz7FL65bwqOxgplQZSJtGX04EVZ/SXWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=;
	b=hYHUTvpllvpqQ/wpYLB62l6TfvJi+jjXMX9Dy49RK+clWqhoJNmnfNdmLcH8eDnQ9agY
	 NDME6Rj1TTkbeDCKAL4iOG92T38RHO2rN5qjFswFW3bHH2gZvF0wHBcml5xgmsfBADuMW
	 MWkUTs6PI+XqzECUhXanvGCbTiWPf8dCZCH8Wzozinj3ZUwHi6tEYRBLKrGxfAzdY89r6
	 wXgI6QuUiazTGVIR8q2ILLfWe6UmS4T8HgcWpnDKxupMCZcQ86VC4Qrg7lHqZ3h/zhhXQ
	 +JwfGQL0nZvPjibeAQCOlafV3uW2pVu2naANXsTOAg+Xjb1NknqP/di2sV5MmwWZ8Dw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777504;
	bh=muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U7DVGJESRPnzZ3NJzlWPJpUzEkbv08N07qzjmt2odHucfgMOzi+IBBYPFXABa5w8v
	 wYdnKvFAczu542Ox7i36sMkA9s1iDSJE42VOv7E5w8/nFL0FVpdraPwGCUgDrXkuMc
	 qx3BWy59JgCa0nTE/EUrfzN8w1CxDFLVg+SpCl10Bh35mxytnPs4AUC+Pk1Oh0/PN/
	 vKl0EAbtjGiMO5GuW2kDSguE0qZ6FjTNvpMrcLtOL4R386ppVgXzov583qrgV9CQLY
	 pQGH2C/F0wAtdSveVif6F1eTzFaBt3lCzgjlUNp2gcN09wCvgK8GCMQ3pN6m566Lak
	 oWOQf/n26xcDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBB6D60652;
	Fri, 23 Oct 2026 17:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E5EB23A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 900028153E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ancA9rEfkbgq for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B4BF81583
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777496;
 b=GAZjLyy0QhRngMk3Z+VVtFbcC5Sj8Pg67I0RGlC6Uomp74cQhbSPSvusFWYoSKecyt0b
 /eVKpM+N44gSjNVuIY1HZXQyioLON8OojJieUOG2IcydXhDGoiKE5EKAq0yQPzdmEvrwx
 wqDqq4ezyvX+H688c9WOzq/oNsbJysHAEH+HgTw5gCYlLUhrSNILmMFx+YYq57dHcdlyx
 39/Fco7gBKpREMl3uDhgzPKQ4U65J2BdK1c0iAyx73VoyuqtmOltlrye6a0ZVGHaqO9QQ
 GdVQhKVhyOK+GpUrfGRG+HjkdHuuRqmWg3DvNWAiANClk2nM4X1DfOpwtibRechCarQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777496;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=;
 b=kZOJyFcDXbH2yBerL0ObnhSIiks0dg5mBEW66buBWIBQbVHh3O45TWqAEyajuthmUF0w
 Cj0QZGUqiX7W+WDy7zycag8n+VPsL3146vRE0TW8DJwq54/mP4VEh9I3AIadAIvA9wziL
 AzohDMZJpxVzEYwGc9Z1tUID3FS3hQUqb3PEYhUDf/NDVSyWY7PVDI4CjOeffS/l/sktS
 4790ws8VITqOk9N32eQVz5U5M79fzddM0O3RK69YFHQ8v3KpU0BufUXnapN956Adi/8CZ
 iAHwOYiegKSGQfbmhiztcz6b+8Omq3gzlQoAvA1U70sGZjYT0vrDzof1/NYAC+yFE8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kLbHs9fH; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MHCHpmhz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kLbHs9fH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MHCHpmhz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B4BF81583
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG34813734767
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=; b=kLbHs9fHszTfYGMY
 U2ivYa/5fUuAAYfnc6xFA8GDXb2Q+svua8Nd1cABl9ywWr3kx9fGGv6WG+li6y3C
 ABCFLEuJfzqM12di8DZJjA0U8xVquVa+GCKlMpKWjaS/tm652PkxbN3rC110HzFw
 nLLE9n+UzFwfpLc6o54DiVnwJpEjLvNCTf34REa5wcfXNA892v5EAxKK+sHUZlpV
 Lbp4aPNRcyG+AZruf1+zkdqgUrrnNUR37NxOLca1dw17E6IDx8FtFu5q2+BQ+la+
 NNm06j8CBrqECB1p3d86F3Gofc3N+e0XBSXcQ7ssRua3c0cYhvrkNA5LQPWUG8ie
 Ed7BpA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarugcjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:53 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8ab43f7f5faso20596717b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777492; x=1793382292;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=;
 b=MHCHpmhzwdSczBGHq5KsdW1xiSiNkxJrpRkB14P1EggdkXjGvsyg8zY7J6aCYijKlO
 JaLSVoSnmCk9vZziAj0PeP2dIl61zM2F2upqcaxKAVO5G7TPKn0uAuULEfK00SqOu97E
 cHNG4kMnYwKpTgNmMR0nbkAxH9NXFwSV4Rp67RboOeriWPBFrJBQSnTNeTGFSUXUywWL
 j4/k+OXfLaGzWKMj1LgNADioDhMP/SinvGihh7KCWJrivN8ZaC6lgOleokyIac0/Dtwc
 x94ov+uHSZ5aH0L1ysADF1jdbxfPIJNTdfw74WNeZmUkU3saU63VMyBqisa5JPvPLETD
 BQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777492; x=1793382292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=muIJHgx+Qps46Y66+H0O6joRI/23VOeNZr3kS8CwMrY=;
 b=B5sRx0xMkbO2h3Yyl3xIP44Q/qQwj0eVSClC5cjITvorADYSmPziHGsC8vFPVAzGKX
 4d1Q1MShaP6OZxphbLEXVdwNTeKxVUQ4CcEaaHLFVryBlhlMOnXz41kNGW4qR7DeeKYQ
 LcdDE7YQv5SkzI87d0UXEBPxXJMqCbsTOXkDYITxyCfM4EPKqtcyOOOg8DcCwROhln4+
 04HOzI9dtfxNkUjf8Eeb1DvN+MwujjNctqi88rwTFX95wiiEOZyQKi8y3ZzamoIbwVap
 /3PHFceEnjK/gBaOM7CXOLTPGlxVEzL4pyWwilRfZ1eZpz5qnufV5AopaHgWsNemfGxK
 2rIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfugFFybhglKA2JNTnzIkE9YyBdAUIL2LblhiAS+MF9DdE/QCcTmU11nZkvXXgZLbX0bcfjBg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNQRSFirlZ9E7akmi6ef2UgOM0KJ3zewM8ekN6EdJ9/PkgBA9Q
 3sX41cxLU2A1G6jWKUBiEoLo5a9odgqcdFnFuj+nyafhNu3W2YsSrDBXaG9nVsF3EU7fa0H8zQ4
 1KF8Os/Vd65+8Isu+nthLM98qIj++hIIEUlu97Ftw7OerX0F/bJ7RB9k+pZyihMJMU6g9dJU=
X-Gm-Gg: AYBFou0pPUHr4fkV79EksF7NfjFvUwi/csmRlHTKDE+e5TcyoeJw57tntBsFLRGpBAq
 UUo3VdMhaaa93paDVt4s/JatNoZJFbw+PK/0nz8UCxvQTN9Xw19Z6uxEvth/meHB7NOiPWsBlRT
 AMzOB8oXrLU0nc51x5PMxT5KRPxTUus7KZ7uc7iadNYSAccJAeMTfpr02Kaqhe69OhjS3TJU6kn
 yqK0rjuR/9z5NyLtjqWEHqzjJkxJ7NeBBd7ESSOLTN0VD7M6LmzSWtJbpWwCbXTHz/SOcz1fPN+
 F1lS5VJCje4imz7r9WieZsDfo4aEiF1O6cwjBXqlf0plf0e9b5iiQGeEubtiBp+xF+EAN9MigSb
 YTUFYvU+M+S4z7r+BZ8vH5n5BSVSf0OwkRioF0PPnuTdgEarPhc3NMKkNND1x
X-Received: by 2002:a05:690c:6e85:b0:8ab:36db:e2fc with SMTP id
 00721157ae682-8b157e84e9bmr19351497b3.58.1792777492416; 
 Fri, 23 Oct 2026 10:44:52 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:8ab:36db:e2fc with SMTP id
 00721157ae682-8b157e84e9bmr19351347b3.58.1792777491956; 
 Fri, 23 Oct 2026 10:44:51 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163dbf92esm2823357b3.32.2026.10.23.10.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:44:51 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 10/12] qcom: smem: increase SMEM_HOST_COUNT for newer
 SMEM versions
Date: Fri, 23 Oct 2026 13:44:43 -0400
Message-ID: <20261023174443.1552137-5-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160916.3894471-11-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-11-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX4xX1HdzG0Ugg
 Z+ROLPRHXfwB40NlN6I1pKZhhb/ii8KBZvvPlNN8AxKbXoVXPPmYWQT/5c8vohgXdd6q6oh4nih
 7k9EI08wMWL3VgqhIegX8ZteMTU5unU=
X-Proofpoint-GUID: w9w1pt3jZR9hZSvH9POHcngNFfCeoHlo
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb9d15 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NRB48c-BKnA9K5xCEYwA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: w9w1pt3jZR9hZSvH9POHcngNFfCeoHlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX+Yk3AIF9ikAS
 qr2Gj9eh24+mSUy0LVpey5934h2K1SI6KeHqiMmrkpvNbwgU6iygV4SPrWdK3l6GXPUTgb+TqVf
 e1Ovkoqqw2eCJH0tApjCAS3zWx/B5BTUgCLetu1mVc8UnB7xBmK79+4llbYqpe7dTgpyTvCScam
 NPjt4vJb3PqZrmbQYnvPD8frZeEIY9RcivNMGN7DyZeNdBKf5CWhFd4O7/E0JEGRIpCd9w1Re6+
 0cp45cmyg8lizS799620AHr+b5nRLxLXwtzA+1KgxnVs2bFDHaxcnw+C0leRQbCz19+G/eAEH0J
 gSpIBLXpFcQQT/PGeeqz4KcCDgt4gOv1WbdM0Ld2gw5ZXKjiQwYpNEdv9+IZZTdRZtJG3wYxJgE
 c9ktuTm7xZBLiT9nvDdRwLgapQbWk/ihfe2f/jk9TixDOfw4OU/HIW3a6XHJSYVsldOZP5tHDry
 xpzkgj7TJYMOW6+NLCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:39, Aswin Murugan wrote:
[...]
> -#define SMEM_HOST_COUNT		20
> +#define SMEM_HOST_COUNT		256

Which host id does Shikra need? 256 grows __smem by ~7.5 KiB on every
qcom image, and we only use the global and APPS partitions here. Could we
skip hosts past the table instead?
