Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD93606A324
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SZZfxVZN;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SyPRFafQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XbKcdYPL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A736D40805;
	Thu, 29 Oct 2026 10:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1FOtay7IL2pu; Thu, 29 Oct 2026 10:58:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF7AE407C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271488;
	b=dTLuuuIutCJAa5dccN+hybSg4gBmWtwZuKAS3LD3elgHN93SwVfNp/E9tMbXa+kqWKQO
	 Z10+Hwe56EHOWpFXDzrKREOhn/Ecoj6cfXDD8NGGq2Dbo0yT+cO6nXiYzJsNkKb1/xB5g
	 VQPoPHBvFhhCT90wTtXdjF9Z7teQU5gRApHqhtqz3yYnUMTkmp8yiU0lPMRTadCfowLYl
	 IZ43n1BlMRlCzBaLIUFEwSCviGsHPMVKSrHvVHN301R4uAI6HzYBw4QTZeEXu0cPwFE7D
	 3t1TBriGzp4Pkrjl0kxkENPjp6pz9n7kJ9D7ryQWHI8e9JL5FYxT20tajwFv/Wp83Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
	b=kwCFsQga70dSu4rVILvf63pk0Xt97Yf5OVlQFCGXBDG7HSkZ+lg54qQdp0eLjUZ8RxM+
	 6G65nyXbc/9s/n2wlgiBjlpBKkvBEw148zCx4t44ZUgiZSC1dzJRkOAqZLuEb6HQ2oTpU
	 YnkwCnP1y4TcOvrOHH2zalS79pSU9TlikTxlbIX9rmx/W+84tT/E24RLdSu3rGubW1nRg
	 M+1Ddx7CUb0qRT2Tkg/iAmKDkZ6ketdBVgx8MM4W4hBX2u9dQXvF0Uczk8mSfV41ymVMb
	 zvWeGHPDL1AFgsKUxx4QW8EIlB1GbProxq2qwlF9mCax3FgJHkNdn+u+Un1sw1etT9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271488;
	bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZZfxVZNTkdXGfi/yzoSymn20qDqZvWuh7q6XVXfjRfHYVlvS/HdAlnM9F/fWgXKY
	 jNmvAiaaobwdou4EyKEm1MKCudubfH4LTX6vmz7pw7WAWrWIbJ6hmTCkzVhnZO3FtK
	 H2W+dd2lVSHt9XYXi4+UZiWecUxDXaNA0UPhUXzutfShtcQBQsOrV4qi3Wo63lM80i
	 PwEgLZIlmGHM4vuiL2KKVzyW+AWY72413xcziw5f8diG+LnRDEmmymF01sN7B1JXq7
	 9naOgFvL1Te1msX23lN/8xlT0SGUt3Tqt8NBOgGTjPDuMLHXQy9jfIE+T+BcFKeZqv
	 drBvIJlK08i7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF7AE407C8;
	Thu, 29 Oct 2026 10:58:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BE6A334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D5A780FA3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuYhBr_tuBjr for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAC8980F97
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271479;
 b=joAHrBKhJJMypfPHFoyRnwBFgWx+rg/BU5D6mzoolCNfVF3mQtXQkVdUAjtachQvEj3y
 G4HCilEdRjqMyQAmUjHVnVl7G3Mry0UMeSUk4IC44wAD/qfe2jMh5a3YLfFwyjLvdKCLR
 zyzje9qcD+EabfdsTNEVeZX/ZtxheHg5TVzicGNBWMFkt0nNS9Fj3ZfHGbBDgIUSRGyxk
 aCgFo4m0i41knE8CGJbOGefg3EIgU3nZSNMODjTCuUzqBGceWt6kC4vXr9TSVOih8OXnW
 U6hGDFYkl3nIC5XrWYy8UEVtNY8/hYw4130nArHz3bmirXu5UbsPrS9eON9P42alJFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271479;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=TViHDsKhBTypvY7gcHevhK7zr9xXstbYoxTCn/ISKzHLgD+ah3aybzE/iYBGBMq6DM17
 McpnStUVD66QBYsMNAVKRrB+uDIz+FPhnPhuRYRfcuw6c5Nzvv7+f3H9Vqj7BLIp6HD4E
 z6WYbDCb2HVHq5RcT2WRL0BFx0xTOZ5CWnutO7gTCveQcEylH5LGVqLxRwcJE5AypKW+W
 9Hb+CGS/wT81hSVahPBMoXgrkLfotBv3sH0J1dyP4NZfMxZ+CprqnXbmKR4qMk1QOQwx8
 TRsR4TlZSiVyHJ1TinP8tKOF8lzatYFNde7KbLHTQ//zpw+mwfZQjSf7JJNyhO8Z1Ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SyPRFafQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XbKcdYPL; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SyPRFafQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XbKcdYPL
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAC8980F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vDAb3824960
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JgRvNlIqWWQ
 EzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=; b=SyPRFafQSPOkAD/e6T6yUWpkIQT
 K9lTNfZ4bkavrccIoDPi+2GYnGKQGa5QvDLvYRsgLCbC+B8UoqjgHWcL3z9d+cO+
 UBPGjetV1CsGXodA0EArYEA1frSY5Q+/jFLicSrsLxHx/mfJVs6awjcw9MVRM6uu
 saP6+f54Om1x1Yk55A5gfRiWY7T9nkyaMQyyH3XmtwT5RqfK4jpyIEtArxJcCE2d
 A3eqBuvqzivWhbt1PfPqF7xwC4JxAH9tabs+ZrQ6nrK5URJLhZZGkwOgcVl8PP8h
 tBDcyTQdtYM2rekPzgW/kuELgUxO1XOEoSsBWxGuCwWIefuagDYDzFFe0+g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3j1hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:57 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1663fb7e005so2503957c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271477; x=1793876277;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=XbKcdYPLlNvc6bp/RoZX5QN9HVpqozBcrJG4oz4Uc3ZuGGaLBIIUeGE34oBLeLMeOD
 DUw1p/kUwhoYEizoCpWLfQRPx9BM4ZHZpxnhmcNrimTpiWaSdv8cEyC28VTlXM6rKGy1
 mponNjPe9Te7ieXrcW86Dk6TH16GxyL9wdt1saetoB4XMluIdcUAJfku+WU49LnYy5kV
 3eXPPJ5ImmUUXoDwGIteoOYPIQBxIFhoSD0Sp01szo8dQSMk606uLZlRziDvjWko7QgB
 6bs3wJHGWC8nneWvET/MTg61AKtRuH4iDaVjytK0vhrShTfPwZSTYblSxgzWCl39Q4fX
 20lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271477; x=1793876277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JgRvNlIqWWQEzaGALWdGg+zzkGeZm9W/y9TK8E77Sbo=;
 b=jt2Z0bMGhhHVrnC5TiJLPOgdzEqLBYDF6H+5iRUdN3hZxdwdxtYSsA0Rl1WOtud8B8
 /Oi9HyJuzYH4qXzJ/MnQoeTQGcSVg/Pot/e9DaLbJNF1v4lI+v8k8wsOdK6HU+yiZewJ
 YcrNbDhIXEfSjaLGtayb//SA8A98wPhEXJvCv/35dk7Pi1BEOzAXtdcYwtBH24Evhia0
 /Pmp4rmoLxrDw1VOpcgEgm2472kDAuElQPZ2R2pNxEo2VQs94Y58hyaKAIkQMkgl8Pqw
 TBzyVTSeHhiQvmlWrl/fWDysfvGFVW3/7OLwccxOD8/TF3UgGDDL0ER4mh7wJ9syqz4B
 T1zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwuaj4CV7QWeb8yfKd0q4Qd3jkoXeSlRb/YzjjB9ypYA8q8E9o2e0hyzqHEtcA/GYO0/pLDpc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdlsM3XLdsWoW2b5/PJvTAiK6yqmrcmE5cYObNvn798XeUuc9M
 ZFR3PnCPbqFdl0vSdC7hZsv7w2IkApx6YOidShz4gHycxrWFnyOK/UCSERRmomRcRymBcM1oVTW
 5K1vT/aUCfX24wKNsaZCxeXfI8E3c0ftBu4bY59CqQhC59/NlzmT7qqBTo98bnR+hZRwl1ws=
X-Gm-Gg: AYBFou0oRIiwXw5m08p28mkMjASiqx74QefoQHSONzquDStEEz4tZtslmofeRs5puj9
 UHpJAxBkz5270Pltn65UrqFyzUAYW7TR2MR4fAyKe9xO32HqV+UP4B33fNZ93Ci9u1ROeEy/Frx
 15Llucv28Jdka+vPJXbIVUePwFE+eABYcENj9CCRtwEJceJu79up5B6ZhoAyqKF6U1Ak300D4KJ
 6nYL0sNeUJkbD9XEIfxGOtcPSSsSNWVYbOddG9/CveBNwBulEe6pEEMH7ugJXPJYytDfwvPCTdf
 bSV9iBOcphk4XhN6K4oJQMIe/27rCNtY+m6TxfDROJKFfvc8rdK4I5ZY5lH7rKW2wmvUCY+upVb
 nB0Fj/TspPnNMXA3lVBwXIvsKnKN6ZdFtWhIwBfn6Oho9wxge5+nGIxjHu+KwoKIIDFKN9ubHpU
 vgn6l2q8fx3840h3gR/LGntA==
X-Received: by 2002:a05:701b:2304:b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1a8b5668212mr4069809c88.17.1793271477120; 
 Thu, 29 Oct 2026 03:57:57 -0700 (PDT)
X-Received: by 2002:a05:701b:2304:b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1a8b5668212mr4069763c88.17.1793271476412; 
 Thu, 29 Oct 2026 03:57:56 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:55 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 05/13] arm: dts: shikra: retain QUP SPL dependencies
Date: Thu, 29 Oct 2026 03:57:38 -0700
Message-Id: <20261029105746.3487456-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX54vNysS3zSRa
 9sh+D50AU0n/3evE9Te5rTUHYRPB773c58qRtc5hDQ/HTGe7awon4wOHbWNLWJQvSh6aadS0a7e
 y0pKIt9yWF2ka9LyHIJgjVJ/nXhmIJ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXw9RleXtJUDKu
 aIXRKTfuG52ae0gav2YY4Z0TmullfS+rNLv/qlDj1W7VxJL27dje7F4No0hBUOEBVH/Aofsk5Cn
 zvBmJXTTfaJsnIi06TShqiGRZQGJSQB6nM1Od+vL+24ZwVmUZa9dnkTkxJSjY59uUzyIR3kegBa
 v0qWwzc3Wb88gYhsJiPLpImM6IMJ4W8SKNU781aIffF8Gtfu1ZnBI9LoChe20YvNB5xgUGEVFE0
 fmbtkVn7XS749Z7B0vH+gZGYEKaUv/XpXHFAuyM6FkY1DATe4lV/v9ikKPGttwgIpyu+rMkvtGy
 JmqB96R7Oni4i3r4VCt10sSJFhj9h7a/c+lGRPHhYKUYUaEOiBu5AUGOTbiyNVfG7Pga//nWCFY
 7NNhqW7BH/vghOqMVAakbBITsMEfKHKgrpy4bJhCM8gpVKSaH/tuyFWccm/rKDYH0dYCQ8edTXr
 jnvcL3msu7PH+5O0emw==
X-Proofpoint-ORIG-GUID: iYbkWhQtEonSnl3wI4oDZCbj6nC9D5Gb
X-Proofpoint-GUID: iYbkWhQtEonSnl3wI4oDZCbj6nC9D5Gb
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae326b5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=mHJ2qds8thx7DnZp6SoA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Retain QUP, console, pinctrl, clock, power-domain, RPM,
and MMC dependencies in the SPL device tree so the firmware
loader can use the boot medium once probed in SPL.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e807b91ef1f..c79c63ad732 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -20,3 +20,47 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/*
+ * Keep SPL console and QUP dependencies.
+ */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

