Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD9606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xujuYweX;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6VOLp79;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WX8kBXDB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79D58405F0;
	Fri, 30 Oct 2026 05:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdAvAkguxCNr; Fri, 30 Oct 2026 05:38:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC46B40596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793338717;
	b=qaltxJAgPq8/e27ipdET32YycEfTyMBarircJsULHbgApaQ76D2M4HXBxqJ23ZSFJxAS
	 dVNxI9KudkxQ1iuIAuDsHALo5pxuKw5QbKKpY6N8IR00Pb3dS6qjCIgrs0zgsnWcVG+DL
	 1onrtFf3EyuDzJ8ibgXwYv84Y5eqoNfbGpg3vN/UF71Ta7GOD+99OK9j1uErM537Ourt6
	 Gv4DhGzRqYHGJU9qq6U+tCg/kjLXPYg8lr5hU879u5tJmGnXqaYvhu88VbvmbFMrF1Ddu
	 AfkDHrvdgyPzB2ROlFDtUSDvN3jQNCNyJ1k0aFi5sZxru+ymnQyf/WsTvJ1uTM6s/nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793338717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
	b=Bw9Z0+NeIes2xpoLKxP0MFz5qsnoSygSPRZts63gHgwLKNIk7qzdr6k2YAB4tJvJa3ht
	 SqWXggpWIiICpDrbUvPZfWRde2yYdlddqAxINd0N/fPXu0azz2d+ilogdkeM3OS8Ayqpd
	 A3iQYEQ8fD65qyRu8XwzPMym0j/QGbmnLcdUMT3V1xpTYyVFXVUiHptJm4t3EreaXfB3p
	 dgtFB871JzL/Bu3kLrY5hAx0WybtexF0iyZg90TVd/GDNwNZl2l03mavnybgHZ/6Y8ZxN
	 RD/jjQXM19QrgmaBXKgCIfJ6vSiCQIxA1mMg47PkhH/Ic8j10EGl6zmWlGFgjVt+1iA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6VOLp79;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WX8kBXDB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793338717;
	bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xujuYweXax2lYvu0E8saTv5rlGbOr0p/WhGsM69pe0wrdmIN8ZuS1TpsCDKHhaHCE
	 eYnHn4zvSkbtilceD3GqnLQ+FYQoO//h/KcgH0aJUc3l2kWtM+mZ99mVtHkW+T/IGE
	 EVEAt3vTo2t563CbYcSED4r6KgjRu8ZiHgZehEVlLlXK2JMkS6ImcJVahhKdRQnqLQ
	 gN4L+lo5rxgxWWBQfDXejLdEdG3PkXQyKZVkSN//SHR9HHgbl/xvyx5f7AJxd0cgEe
	 4BZy+G7CvSjfLMO12pDcGV7L7WIEDvRqSmxyqTGi3VXXGLPZv+gjvIGeEm7wH7d0gq
	 qIYJaTtqYN2tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC46B40596;
	Fri, 30 Oct 2026 05:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91AF21DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DE754057E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5yYAS6pnCme for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D5FD40540
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793338713;
 b=FFg+0K6su7tMRVSAqhSKEWd4tt+1EcAx/Vg0alytf7iEKy/5dmeUVjm8yZGvyg81cMFy
 uVBRBzwZm/gz6+uGL3Dfz9XjO/D6fY9re+X2LwZuf0Al5h+FyH3TIcs4OSvNYTAGBaqvu
 SScgPCB2k1bc2Kg1Gi08V7ls1IpvQA+MZZ6EjWsxAROhH/8LbikF4IwbrLH5MOVNuxBKy
 gLlFno77/1Hc1bnPSmG7FPfmkf++0QorSk9yf7Wo8gTfEHhXorGy292CYFPXun8o4Vu3o
 UdLkdtoPEzpkW6WWyzsR18WsNf0vV8ax7zuk3jIPadfCln8eupmvcyWt5NIvmSGoF0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793338713;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=Su5hd8IDNDLxnDTgcn8SDKqqgG0Z9A8rZTzdGKF8wRCcnia5LFSWPLxayEIhZTllGI9B
 ds1i+7SSh/PXLP84zMyKJs4DHcLTo/pndPc6OUiR0zpL4BTJLyiS5AsJWAQdkFDha+3++
 Q4aV3F2Q6E1IhKpTkSli9Qm7aCA/GxqktJ9Grv1Q34pZ3hhz0JR+jNldwusumeLoSaOgg
 N5EoPumJ+eBYzUd/J4a6M8kjIevLH8FTT3KryFUgpruQ0gWfL8U8qMnEAf8yUbbrsfC+s
 dO66SeirPjOAyCmkhcxIlyv2E9QRNpMCfbH+DGP8Ryj7DoOnj1kTlK27pepwXKljFAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=o6VOLp79; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WX8kBXDB; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o6VOLp79; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WX8kBXDB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D5FD40540
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5F31d1367357
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DiIj1S8ICoQ
 XkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=; b=o6VOLp79WHtrqheOaMrcby/H285
 sTP4fJolfDsBmd5mjnT37J+/Bxp/eLRaNwXLjH+XLnD8N0iyXugWmXOaFOWxso9u
 EyZXxQx26Ysu6Pj/lN4mdmu3uruKfu2HQWLVYsmClLg0/QYVd4GK5KCWtP0Bo5oo
 e3/NP8Uqckcjl2/ba+Q8WcmPzFbNSDIOSao9ybPwBdiMAhgCB7ENXbQghzsCrzjA
 v18WiTVkgO3PzYj6sC5mQRddrohhlxwIU/3a4ilLyfW2bFX6TYIOpvDEITsxGATQ
 VYo2r1hgADaT2bDT/w57gktqi5TlR6uzsYqMjgBhjXOrTktXGCUFh+RbrEw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p9c1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:31 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1663fb7e005so492777c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793338711; x=1793943511;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=WX8kBXDB+KpFU2S+B9WhuGXfMj3JLrexJ1XuNcRsMpySvx6nK0ynYsBRMvp5+5cfnQ
 V2CgJnSFYyLMmtnf0IuY7P+EyIPWJ8v8kb5vFb2MTcNDwPPC9z4tQv46CM5Pz1qV5Hvu
 quOZ0vWp1WxIZTU8w/mVmz4goIorf5qPzdi5QSbOJEn+/mg3uo9kfzcVPF6XdrpJPDHs
 Gy7+zezt4Nz27lIPzAg6mlFbv9M+bTXzTzUlK5UDjgObmIrlzaktsPnJ2C/8RiLAfa6X
 DHmlPC7womIiEBS1gp9fSZ0ahXuXwPh5V9JwDczlOPf0z6g/L7BzrBDh/7hVAELPdVzK
 fREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793338711; x=1793943511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=U3w8Y6KgW0ICD0oLYB4tWp271px/VdACrmHjHSlelEHQjFefVukkLnoiA+pnviCdZ/
 832i0wY/utzumCM/HO5bI4ZgltHCyIgnrHz0mwImEvDj8z+PpLUDLFbD9pFpZV7UzZue
 n48Bul3Px3uFREWGYmI7d7hoVlB8M6LVD8j/SRiWGT85NMT/0JdsTy/lS8MoFE8mHNcX
 SHFgrRDmfhv9LBX7Qk/RsGBAuY8sO3uB1uzQajBu3U3xvEmSnG/NjPBYg9S9KAVgBLTl
 N9lfzXIbF0G4ea4vn6rIjvuljqFIci1RRypWAu1QbPvlDuXaNbGI2DgqDsJKa28ImmqI
 +EqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwF2gySKWDSgftIi5iDYO5RzuoOku14b27HVwLAcyvQynGTkIGbOYUe3KDw1GDlAo7TJg4YGlQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKeNyQ7GpGYvCADBKD217wWtuEKJBsy5ML5ZbCO/ybRsPFC60u5
 jo+M4/3Q0rW/uGDkrYKdr4hESF6dz8TIpCEsx3Mg7PkuzpGxC6Uclj2swHWV1HWw08MKJxcyp+K
 lWuGrTHp8T4V4XPjpSQZTrugS+mVsgjX/TaWurjNCFkK/fBURZUXjxERX7n36V7Riu9vxb10=
X-Gm-Gg: AYBFou1y035F6T9VKIAfkwfAAqBkdz20FCoaFqpHUjwmW8IHKMxxHF68j/W6Z6OgH2o
 9Gk+wX+DjFkdnbcKkcQ0wLTfyaDEKprI2h9xZV9N0DMePsfe6FmmIwLC5dIqGNHzPt2CseW7LyB
 qSt5qKIQxcWQwr6ufA296qbPnPZJ6SXzQqM5g/WDlGxoej8NyZU3H/flvFRgexkaWjHDYKpkgwK
 eNgC8KQB0twsTT07nyfVb02ksBOnGLJkM7kFx12TvR8SjzBxUhhd4QlpdTFs9rFlzA1m2CFm0pn
 gvme5JBWx4yefbXg/E3O7JC6yiNYu3M2PCvS8a7v+HqlNkoLJg15ZguiRC3vbu63GlagM4YOQU4
 y2XFLcirzX9r91DzB5F7B51V0Vl/kXC2kCJHvGqcZ37dPHJbHdzo+vnHyZEa/4k/B9O5HwDqcI7
 1AQh63uhbY3nXhjKlr6XVweA==
X-Received: by 2002:a05:701a:ca8a:b0:1a6:887b:16e5 with SMTP id
 a92af1059eb24-1ac5e31f9a1mr1974358c88.27.1793338710841; 
 Thu, 29 Oct 2026 22:38:30 -0700 (PDT)
X-Received: by 2002:a05:701a:ca8a:b0:1a6:887b:16e5 with SMTP id
 a92af1059eb24-1ac5e31f9a1mr1974314c88.27.1793338710143; 
 Thu, 29 Oct 2026 22:38:30 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428aed76sm4174107eec.9.2026.10.29.22.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 22:38:29 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 1/2] clk: qcom: shikra: gate PLLs by clock source
Date: Thu, 29 Oct 2026 22:38:23 -0700
Message-Id: <20261030053824.447668-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
References: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX6Mr1qQuR1psF
 p6p7BqqakRQN7VP9Q6g74stwGOIrowNuO6CYmz9MYq93hWPd15///C2mRHkcuCXUGPbGVTH5ecO
 68iheGsPEI8Demf4odey5rfi1bJseY82HR9lpf366E4PP0x4g/CbioXcuuqV/xdc7GhJXkNKsLh
 cbnHxU+nZf/ZrkF3lM8KOBioeDj3yQ5vvPswtfFdc/xAi0nux2OIJdCpaZVZv81J/CbCxlCOV2J
 pk7uemICuCKxd4ItE+SQCWFJYiBAn7j7lNGTWVDA6nYd/53MWWgm0NS5zFniuE1HDgvhFcm+26C
 3WjMOLNZXCRSY1JwYHN1M/h+9VkjLFMvPVTtqM1C/4HN3+umSmIeuZ4Za6pYzRLnSYzocpPss89
 M2IqWRAEP8XSL44g6OiserOP1B6eHG3eBcvAwTr9xepj4pclktoc6/hKxqdnKXmZoKqNfZpto6R
 7BaOkr5EafqeziiVoeA==
X-Proofpoint-GUID: MaxAxY18rLXKO_a_8d1VN0gjSb6ULNay
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae42d57 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=cbElVB0p0K_n_hLG8QkA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: MaxAxY18rLXKO_a_8d1VN0gjSb6ULNay
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX6l78ULFHw8Cn
 I/zb8kwEpiOfGiM9DegGm0ebeRSCQ/slesoUFVv4KB9hAOySnXazEVHrR3X1/yveaF8ibLveG+2
 5C5d2z3VtfUC15/84wd1zCc1ewC59FU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300021
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

Select the QUP and SDCC2 source table entry before
enabling its PLL.

UART rates from GPLL0_AUX2 must not vote GPLL6. SDCC2
needs a GPLL7 vote only for its GPLL7 table entry. This
avoids enabling unrelated PLLs during SPL clock setup.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a74d529f4cf..ae360894082 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -152,8 +152,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

