Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57707C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3C6581355;
	Fri, 18 Sep 2026 20:07:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHUhDVrPn7ze; Fri, 18 Sep 2026 20:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E2C398133A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762024;
	b=mGRXAqGXeKEVuyvtYe+GuIHuSqwZHJfA5+ge7Dwf5t7KDyOfInVFRoadyqr4iB+/VrOR
	 Sk1PFCwTi4CZBLCb+dxx8dVqheXZDZn6u6ufayXanLKNFOS1pWdHWN4rnmqJXJQ6yaZ80
	 xta+1OUE0mwsvxDAjqhBLrPqS8L6v/kv8UPKpe2r5Bdyt2kEhkyfsDhW/lZoRr6peRMAl
	 AHSXPi41JfSXcBOJ1nWApFIJ4XCtMCxFwn9BoqSvK2b+mV0cArqVHrdCbkRXkKV6/NxqD
	 HJalgM+1N2cIt/Wp6PdXx1umU6yYN1wGx1jmPTtS5MJel5PKeb8szqn9DGrdZyRDU0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/BWD+QvN/xHkU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=;
	b=EzXSJFWxJ1cUTLIGL7HJOhnmqkeA+9bOvG4C8JLlOeKxabWwiKrcQ5k/ChvPaZCTzt+W
	 QuCGf7cc0KXEC9Q7TzR8EiMI1wZ/Gk3Ol1Uc5RWpzfS6K8ypOycmGwRZE5MeedpS7hB2z
	 yj7SA4Fz55hpC8hk3gpNBh8hT+cTLqf+EUmNSwDDrNg+U9iD/Cqrz1z0sl+fZothj8PgB
	 u5a9EJXN0hynwVgU8g5+Xu/SVzz3/ei26FFOknefxTGByZdn3R0pgaAmAnwgKdCes5Izc
	 e1gnZNesoJkEhJthwnN/QOy8t/TqpUKAWHhlfNt1y8t5DHN8OoAoy+DnGAxqwDL+2zg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762024;
	bh=/BWD+QvN/xHkU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/ZOFFhy31uVE/Ko5vs3rMTCodsLQg/C59P3i0ok5Y7wd7Scbdf+H4wGz1cdjVFA2
	 NxNd7be0i0kr7g6crF16Mq1x2jZMidMhjCdI0r+UKDzuK89FVN5Tzn2YfdHNWtKVU7
	 aVNsZdLflGiSzC8LDCm1HsSevjDzVjaHE6GQfXVLpkeUPdPAyOnmlx6YdKOy/t535R
	 L5wOOEcJIAgWUVWd5m8fdR4Ufg159p2n2yKG6Rd8A9iSqTIAfONwCMMBRFlyM1JXUf
	 lBn9skL867NC4ajzdwKr3seozPdODbUN3yPkUxt6GcfvxUcNe/9leR9UxsxT40ybu7
	 GNlnLCP05IGIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C398133A;
	Fri, 18 Sep 2026 20:07:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 471A83B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FF1F400F8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j8DseAE_AwEX for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 85C7C400FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762018;
 b=lSLeeL/cpJdJ3GEM0apA3425wz4Qyfz80iGwz22uZ5RAaU1UbsrWkYTKsboT22begQx4
 gCHkYdDwkxr3i1bD+icQZyAFKr6p6T6tFxBbHP91Jsg8hyB9orMk131Fpv33D75OHZwhx
 oD4qExu97fYXFx46CtePCJnSL1VdFM/gi5i6Wa+IwksKgJoXx/eDfVm+zo2crQCMMLvHp
 n97gpCdxQFYtzRzyht9w7hs8sXaCv2JZNsDwFD9kXt16kPii9+p+y2RhQ3/CBjdggmO/2
 h9HkYGLUcA/rTlKDFO6BSIAe3VdlXwtq2HQcHq+AqgKu3o3KmMi68l84AM/Fuhm+FPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762018;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/BWD+QvN/xHkU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=;
 b=W9nUHDwFfmzxPkcVA2ALfMFjC09J1NY02HN1IhF1tWoByhcDTo0DwUwx3GJ1Mjzv3Lwk
 i7KOUpMTSq0HCVvg43ud56Elp36MGNb0XDduneK2kNb0Or4gp+HhAxGgoT6DJqHJgTFMf
 XrLmn+NwTv4nlhWWa4lJUCZiR7qrhXT0kpB7A+OG0GN9e0DhKJKWPFSB85RA/0uHLBpdq
 CVOKXl2vAiOFFNwY8pTjpnkWUCr6VVShy/PW5/GA8LFHOQLGInKIOF9HbN27Yph7eDyde
 M9x3hjNz/X1ukhSeWVFES7KjnEY6L6t0mAc+3MGdnW2ib63Wo6bHwxFUggyolc5vs7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MAaIEcve; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XKbeSZvU; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MAaIEcve; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XKbeSZvU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85C7C400FC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoBan1347067
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/BWD+QvN/xH
 kU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=; b=MAaIEcve/UzS9y042OOuG9gib1M
 6KIiJ/S6/KgIuEoHqK55IRXqG6Gqd4mlky8LYFtdh7/0Yukr3Q3x5674gLOCBmrb
 APYFWbyrD9tZeDekjKUf+x4e8ENOXtAgywzLeoM7UMD2AwC2V3g1upaexndLJNn0
 VxJguP60VbSP9FzEd3rorzvmehN3Ua6WEaUx3ETzver1fvFbxo+OoCUnXPhm1Knm
 IrjQ+5XnVbl488JUzkdk4lkJMrMWx1i/m1RKA+hMdZoYEMQdTaQ9B3GXIJc7b/hn
 SQ+ij1tdL7Pqn4TU0UF9mt9H7YHpEO+Q6MnRtSqKs1os36gFgXsnGdTSdRQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs72u1dyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53000c06184so31540471cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762011; x=1790366811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/BWD+QvN/xHkU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=;
 b=XKbeSZvUFOyNOEbiPioXm6EkS6T71ZZOhfZR/SHMFuCJGgQdNT/sZoTNRE/qb/U3xS
 beQCrCaTCE99QEnums5fcIgr/sQjr8zL8jZRDIICAPe/ICWcIk5BZ70kk8GEIF2Ewsih
 oiy/SSLyS4dZ0XuVKH7CAzKw5S7exixJibwFisvYX8JaAhltcPZKFTfSbAfy4HZG1U6v
 kV6gN6aN3sOsZjNn6ObRqf+C/tflD6mqzNqtj3KV2Wtav2N6onXxj0r3sTCuYxkQpMva
 4YzdlOAhavbkh6x8M2eeUsDrYx885odNg1bewZq/75wmzmPVC/0BbO0Yy8sZDWDrR7CY
 zePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762011; x=1790366811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BWD+QvN/xHkU6RX5CnRNKoFMRU/rKn1rgeyrDVmjzk=;
 b=kA85dvqVCK5QC3EibF8QKq8Xmop8KDBySKgHZbLlWphJYxIs55gA6MwY63lORo2IPy
 7de2Edmqcn1EI7oegqIzgJ+svK4sO9SL3EhsUpgzZrGJnoXlwR6PmN23jAGrU78jGEH5
 n+A8nshgx0OXwHPbRl6c5y5r/4Jw4Lo+NkAt8b3ug2SltHXu0uopqz4sjQ/fsqMD2MAq
 crd/imPqmyo3VwOoxYz1QaxNCaH7srg9nkHocuBzj7A35dJT7fxiwyitXhzhmJTlv2Qj
 E6K1/iEEbuHIKK+wcsjn1AAZhxfWm5hv7FsH/IZBB3UA6d9rr1jaR+H4RsK6dAtXVZvM
 Rwng==
X-Gm-Message-State: AFuF++mj75CBMlvLr9z4WmlTiPR5jrw2sUQCV00WIwyPlq7vIm/uRLpP
 2ZJgJGEuFO50Oc8FiCnoLf79Gk3vduK8Qf2X+c9NLAFhRV28/zpQ1e2bJmFNRjO0vp7DPqbykVD
 3CnMogmzW61z2EcOn9qS+9h1rIqqa2Q4vOk5RUeiY4/r4lX/jI2wVJBzAgF6T1JAbH0e9k7A=
X-Gm-Gg: AYBFou3Oyqk/viqE6qpSEvtApiCMEwsZERCFD69oMiEIGq7fEnusbgomH68l+5Tdglm
 hGpNzgZ5ShXD2oqyFfsU7UeXKW4ZltTQ/oRuDidy96yrl36Xe/C8wllM/1KjOgYCb8yJ+qLgb7C
 b+xnN7JKSqtjIPNVswXh5N74j+vHhvTcQ6zCYYrANNKlVoJi2//KbwYVBiqi6xIe5NZOD9rYml5
 eZk6Qv0AzprZ+PyMQbAHOmeNBjXyQRduOY++Wvajm8AGPTX5F6dZb7nRCNHmd5T0z7wbW01zyJx
 F7kdmgDxK8cO1NNEB+ej2C4AQUMBvGq4RZbnfyFIhz7xxjkf4CD64JPMhvfXoO3Ixdz1DMTfsJj
 e1P1J2WgFuW1kToIYRanhh1FwFnZvtvBUAupdQmkhySGxHi4=
X-Received: by 2002:a05:620a:280e:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93bdc6975fcmr600733785a.16.1789762011285; 
 Fri, 18 Sep 2026 13:06:51 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93bdc6975fcmr600727185a.16.1789762010806; 
 Fri, 18 Sep 2026 13:06:50 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:50 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
Date: Fri, 18 Sep 2026 22:06:34 +0200
Message-ID: <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BILUTw9Mpq39cvOwWcRqgasBqub1gK9N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX+z/BmFcOmyJs
 AAUbUq3bbCtXAWVAW706Mw3ygGbeCTiLYkUdqmJKzL0DTlpz3RHEpdCz3jAEvI23t4FpejbmLP0
 YCJ5lBB9+NC76NajsXzUpTuPcAv2c4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX9Jh1x/hZh9BJ
 ffKRn1QX4SzjTGcWxF2h10Rgguf4TznkZtBSSVjOlXeREUummMaWdTvaYAlHWRTBVkxDBdJogxu
 vJ/18Tv+sHV8OsT3nZafmyI5dh19fnsd13bmaXDMTIZYu//7Mba7g891ALjSdGzmmhFNFBoZoUM
 kAzZg5sCLqxnahACmvqTYZ+bePYbTtsVmGEiR8X5rVDDSXXVUgQXEsldLYWnBPVAX8P72X0VaU2
 8y2KwJzA0UuzEm+/dMReo0Yqu45etc8fb0vl2/oQJobVvWhN7GW+kS3szmO0nbQwjegSmTY7gaR
 yBHMHGVtQnv0hb2ytLlq+aWfNvRwNEh4wBBTepiZ8FVf4Dgpal8pJ3hli6PkC4uTbdXlcisvwvC
 o+cwlDXnarGNmTCJ1BJhLQ2uM4Fqq21aVOLk1F3Gc/FEwQwCh5B+Q9Nc/AR/t2qgsZwBs9QRCRf
 5aDzbjIYYXDjN6uV8TQ==
X-Proofpoint-GUID: BILUTw9Mpq39cvOwWcRqgasBqub1gK9N
X-Authority-Analysis: v=2.4 cv=DO8acCNb c=1 sm=1 tr=0 ts=6aad99e1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=OKVFKRVrtuEbveMjFjUA:9 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180290
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

On a CHECK CONDITION the UFS device returns SCSI sense data inline in the
RESPONSE UPIU, but ufs_scsi_exec() discarded it and reported every
failure as a bare -EINVAL, leaving callers unable to tell a transient
condition such as a power-on UNIT ATTENTION from a hard error.

Preserve the sense data and SCSI status in the scsi_cmd. No caller
inspects them yet, so behaviour is unchanged.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 21aed9f97bd..3d96a05281c 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1657,6 +1657,22 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
+/*
+ * On a CHECK CONDITION the sense data is returned inline in the RESPONSE
+ * UPIU; copy it into the SCSI command so callers can inspect the sense key
+ * (for example to tell a transient UNIT ATTENTION from a hard error).
+ */
+static void ufs_scsi_copy_sense(struct ufs_hba *hba, struct scsi_cmd *pccb)
+{
+	u16 len = be16_to_cpu(hba->ucd_rsp_ptr->sr.sense_data_len);
+
+	if (len > RESPONSE_UPIU_SENSE_DATA_LENGTH)
+		len = RESPONSE_UPIU_SENSE_DATA_LENGTH;
+
+	memcpy(pccb->sense_buf, hba->ucd_rsp_ptr->sr.sense_data, len);
+	pccb->sensedatalen = len;
+}
+
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
@@ -1664,6 +1680,9 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 	int ocs, result = 0;
 	u8 scsi_status;
 
+	pccb->status = 0;
+	pccb->sensedatalen = 0;
+
 	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
@@ -1683,8 +1702,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
 
 			scsi_status = result & MASK_SCSI_STATUS;
-			if (scsi_status)
+			if (scsi_status) {
+				pccb->status = scsi_status;
+				if (scsi_status == S_CHECK_COND)
+					ufs_scsi_copy_sense(hba, pccb);
 				return -EINVAL;
+			}
 
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:
-- 
2.54.0

