Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E121606A330
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vlMstdYI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O8Q59Y+H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LE3nySXb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BDB4606DA;
	Thu, 29 Oct 2026 10:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-NTx-AUlljL; Thu, 29 Oct 2026 10:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F04060710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271489;
	b=nPJdi8iJSayNYAtz0JuHxqrTxuTI/qDFgp/OAH7pO/5iTVUa5IH0TdREpRH0ES8FRNkG
	 zFeJZkWeb8WjOYNRcYyPJkob7BW+15uQS/ZphTJmVkfCAkn/CU9EZVF0eAv9U4uo+7sel
	 6jF31TXbLvE4paW8YeN+u2KjKyBRy9DN/7Y0FPbP/Y/VESNym/NVi1TdBUMgQVwKlG+5q
	 jAjELBAR/Asewxu9u0XKPFQceb6Pz4jqzKoFnsuGEihJSAtzXw5muUsq5+pOUBBrxQWJb
	 zVS1dFJNVEQ5fhOkNQsPcY2aIGLnl++q7rRsy9OhThvtcqToeW+9XRxoQTs/Re1+eJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	b=JhuRuQhfxsZOIobgdxbTX9Oz/FsB9GFHZ57ynk+JqD/pfC7WS/iecVwlC724KZfR3aOz
	 FLpkJ9c9JVjm3nsGZLv7fF8R6hyZoERLHBdi9bHQ8DiTk2ujBQhqxjwJHAU5HP3W6pndS
	 brqTb5iNEenDq22Qz1ydjd1tbGqIw2BK/kcfsUmIO3o4WIsCbwNKATmUOplbadmTQbC3d
	 kKU4vOCFV7HWq066c6k4cFIuZY7t+OHBC4v+2Uif4qad5ow3cVyCnJYWtCGIBrxGcsvMc
	 LZrPlEnnupgAtdeWXy3iwJtF2fB10GuX9VQlanG3v1qN8ldHLc74+lKv0893M9zXxWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271489;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vlMstdYI4QERFAGJqNzfLF6Me96/1dCGJiPgAE0gyUl+MiWhOu6MueoE12OGjhV3G
	 d20RnrN6NS4PKdLchWxigCLcYa0z6Wvov6n+CUTjeizYP2ippGxf0GEtH1JMUJoyS6
	 rKli0L55Sxp7VDGupBQIGyu4yoqo0DkmkX02l2gqMYfA2d1YBjtKB3+pG8LEcF+NuO
	 w2ZqlXTEZkH8jKA+1PyjxZN4n1EUtg1yv9RTEgtE/SD3cCbG6Dwa869+eVIIxZS97F
	 TAv/ZI3nJovUS9nSWgyiF3zJKHNQk7vwhosseRapiSoGm/95fnyqNGbXdJoAOYi9R+
	 WYzTV2xHvMiZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F04060710;
	Thu, 29 Oct 2026 10:58:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03AA1380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01A864032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tw3ysKGIkrEO for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 572FE40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271480;
 b=Dt3xAYppPJl2irVrFtHW1t8FIZsnmxzw9idQ1j2UxQvkXdVrbntgJn2+vdNEe/VDRjcH
 MNXFsnrEb4/gOw/pg/i72Natm1qicGZsALH+dThePG9BGJFJtcGvmA1aV8NCdR1rglKSm
 q9jHazwSayJczmEyWUMrsukxaufl0EOFObhOhZmNSu/cYUXIl3oELrbLyZlMflNTaz5hy
 G+H1TvyWwoBUilXKD91sI5dFEspPNSardytQVY4QJH4WgnJP+jmf2ZblAxL/wrLMtBLNC
 rJ4aEf3jTJgu8IcwLC70j1OOTYhzERtSVVCp8EMJV70OHne5DwhPA6a8k32k5cyo5hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271480;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=k26vjHrQV4pff3QpA915A7c6iSI86KkK/DVtB+LnmiYFka68xNOuPQ6VKK3zLnuYq3IT
 SA1hOu37mPU3MIdjf+7XuaUyQHDwmRomFzBJt8tHXIIWJthtoPXpPa7r3RudSkc8JqiMY
 OvuBEokB3Onv1CctNsTl/Jg/eYmJpMbvYpKLaG3xw/9fbvoJle7kKtQahExU18sK2CtG/
 LZ7XPelZgWdtKGSeTvtVNiNR1WSQVmfQ6/SX1qdhpxaxuIOr/wlPXdruKcQ+YFHVW0zX8
 Lp3s0U9C0lOOXX6WCdN2YQQMQsaj9Vmer3OhJ8CfU0LDuWnehgoS6/CepIGXEDJZQZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O8Q59Y+H; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LE3nySXb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=O8Q59Y+H; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LE3nySXb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 572FE40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vN6a2273446
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/O0iBQUnQd
 JzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=; b=O8Q59Y+HbPG8HBUDtvdrQJioAlE
 ErlLFRmjMyrFu+ukPnWM3135shSq3Vz5XDz2a2coIKCvq2k1fn1sMj5QWT97ajcZ
 fIwwQwBW3+nlZ9my/m+oUVVvgfk7XjsFaLxD0NrjmYqcMI/lPoDDJ0vRk99N9ivF
 8FZymDCH7Qhk/VGdxershj3Dh3FzJU0NvcKOB+/adibkeY724+eQuN1OXZOS9Qks
 f1IFE9cCBeeDinw0sbC9bTSil4NPSTmeGowlXIO3tW0+j2SIlch/5RSTQPefrN9h
 KqQ/1maTHTGA5pjBnetR0xOfR7vLao+7X8EHA+yiYLEScOzWWVomuHLAqPg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b0fmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-18eb2616974so1356578c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271479; x=1793876279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=LE3nySXbk3Yi5R8AKoclNQDxbNSK3PnHAlzBtVzLtUfLLzS6egA6oa9qkSO2t7Yl8q
 A18l+XNOmiBMOpWSI2OQDS6AzIvj1jbfYJP9M/y3cnka7M+H8maaS8y+zS6thnEnpcZC
 eRm/X/ckzYMRhqYaKBeYEMKiU8ovqpRL8VAL+xvUjVDLqSnSqn54cO6/lFBfTkwu/u/b
 cvridfAsd9jJ4hm+O1p5pri9hBMo78rcwIXP7Qu2n4i8aVPyptj66Y3/fJlqqUpfzkU7
 Td2hw6kUoolncb/hTJ1nTFHpQnknFdrYaIqGRPL0eD+Ne/IG24DfKJh37D4s+QEVfavQ
 JQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271479; x=1793876279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=I7Wrfe0SRu5gKKR2OcoNDaijQGDGrlO840Q2yUE1YtTl+60/cAKumq2vDt1fSpMD1h
 e9MHYMsYi8+TZ6Z7kvjU4DzI+Z3iPevvrV6jnXRxhbbo/YB+TGieKjTYCyRMvLyp+NKE
 r4H8mQ1mXB2VvHvi1984L7f1EOQaKgd6I4OW8wP0sQs4Lg7NH+OROhoCNNhkgaGficSZ
 CDKRwwqF+M+L1zCPoKnz3J9uleXvXAuo4sJS0z0orlAFpxxF4PeyJsUulczUdUG6sE+u
 M2RsuVtSLU1PAW1vqqo4Op4F2PwiQFL1msazyf0SDfhIkBS1TCPA7/PZXlWbNHVbmVFN
 /MRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZuxWQ09HDSKcLWb5df58I0FbcLAmE2eJldKVXZLGQzrvFXKd9IYwpqlAEEKsY4zTMOwhQLFo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLvSHuuKjmqpbC52R6jnB/W4oZa2i7BOadnpZ+f8U7KLDLKHng4
 gyR/c+zT8HHF8z1hIl6km9EHNC6h5g/iVYLnqGv66HDeIGtmm+U7MT8r4lwhANviDa4wIpgv+sm
 PdEkxTGYDYqFkR+OwLkvgZk0IlENFTcTXNIwBx06OdS6+Zf+840xZbYuK2m7ASDJ5aydNW1M=
X-Gm-Gg: AYBFou0JMpvgqKGWue+IeR1XliIKtxuYb6u1fQTpQsuxihoZuJmwkpm+3OBM5oBS2W3
 7TUlRgh/fnANLURFfFcqzgg8546bYFYPb3b717SpOTQKXrYOF1irACtrTXT0FGuV9mW8KeGwfYv
 tonTkvOU3xrrG48+0Vo5xhxMWnADwJ8lY8Lj/ZntupuwfpqkuMbhmPiHAxAsoPWfETQqA1UQH07
 qfn5u+yw/VI0ynW6ogeft5wunUsXG0KvdmUePfEF9jTH1AKNZHNzwHVnqXacbboIdhL0Q6Ub7tr
 lv830S4hn80xwVGC7Udb8cnW+hGzI+fJX7Mc1+qnZLXQO46XXNho32UIoSkk9dAXsQw65zTTNeA
 nIvRLKGaLIG0RcZjyKnAHayfIeAz472ADrA/MzKC4xuBkcxjSjMeWw9ZVXTSNQxxFVa6vo5eOkH
 gKRgSz0NtZdV4AHXkRN1pFjQ==
X-Received: by 2002:a05:7022:ed07:b0:1a5:1c15:9ea3 with SMTP id
 a92af1059eb24-1a6cc7238d3mr7125791c88.17.1793271478432; 
 Thu, 29 Oct 2026 03:57:58 -0700 (PDT)
X-Received: by 2002:a05:7022:ed07:b0:1a5:1c15:9ea3 with SMTP id
 a92af1059eb24-1a6cc7238d3mr7125752c88.17.1793271477694; 
 Thu, 29 Oct 2026 03:57:57 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:57 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 06/13] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Thu, 29 Oct 2026 03:57:39 -0700
Message-Id: <20261029105746.3487456-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX1Qk8heSXD0xV
 5jdyVOwY4MxV746hBoj0HbJ/KgNKU9ii6y161EeTiLTA+cWTWSMAnDi6jC3RComKbnbJHvOamF3
 6Maedwa4d9bnHWgKnz5OgOp7hbwm3mE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX93ujNPYk8ZLK
 ie+UyJEiZEJVa9Zf4mGdy6hJJ/gSvTgBHLknIAcU4988OgLSpxfDYjvX3Pdu9D0u/S/Kvb+HG2Y
 EnLruqbH2nf6PnmmflUh8a20nN1gtBCOwdwp67nlvESkSVnBBcAjRgIL1i3DG45FRiTAiJwQJKg
 SLDqBl7l+GLTAJaGhNX6nJkma/2cIS6SX+BJOZqvMh2n5jLB3+xMwZeLCFeBl6z7lpz5JM4AgpP
 80xA6KUBvnYlnJt8gapNPEKb1YMhMGOHrPjZy2PagQYCSTunoOq+rnJAFYsCvyz9po0VsoCOXo7
 0MFaqR5rzKDwti6QfivwrQEXk9zdHn8stxo1z5yWm9qS2M/6GWFNRTkN2z+zyTBUnKUhTENQAHa
 PrTB+KwmfVpdRSW7OXgdnv6oT5TA4oVde6qVKqbch3HGm9qV2hUwBm4rmSdWSBbnBiYtl0avSS8
 fSD74Vx6Es2CEZtHrrg==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae326b7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: wmejJZ1JUH65TgLq9gkLK1M4tDrcMhhF
X-Proofpoint-ORIG-GUID: wmejJZ1JUH65TgLq9gkLK1M4tDrcMhhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 2c3c5c9b4d8..94501b838fc 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

