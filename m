Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F0606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HX9ZRB43;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g6XJrp8f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hMJGmKX1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84EB1406AF;
	Tue, 27 Oct 2026 10:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pXNQoyc8sOmL; Tue, 27 Oct 2026 10:25:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7515540575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793096707;
	b=SdvjgXoIsP7+dhnUy1ngSmzpQCmqserwGY9+wM1vNAivXRmLXKCT4nV4IMJ4FtQx92Le
	 bakAGwmj8VUjgWdXUK4Ok/I7NvWv5Ts1l/PJ/tAUhM/JXh4kBtkD3PSvAWmeb4ghW9Wzr
	 k4Xhx0QiC3Z2TT15v49iVjp+0f+I9oa13xtD44paPfjMcYFek+l9dunHtNKYSO0chaaRF
	 c6zq7ScKi6sE3NKFJbm4BRQlr6I8S97ftyd+diMEKU8nJHQwplRONFFJn2z23tdu+2YRL
	 NuH15q+rDWUXFEaQzcfTyhAEAovCcZuSvdkLSbqfXvkSvLfrB+nW9bWX50OSdO3gKng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793096707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
	b=mKrw2cJPtg6ZnVKPxx++lBLvZsnXkhrhPi7Qa4nAHgQ1OPmi/PrwD5v/+KFC1mhPvXCk
	 y/7+GqE7gO3LBxTNnTOUa95m8RMp9Y53CgpRQBYTxF+I4R0gvhsbjDpn/3aXL6CgdPPsU
	 j6dB0ND60EnlHFtO1DD0lG0Owp9UHYvikjkps6nQhiYneJJad/JO0X95rm3naB697q5tv
	 svJCeK/+u1HVWnbo7JfVXGQfiOdlyh++2QjYotnpU41KnOLoTBM7oOEsOc32+toq162SJ
	 /TjWEg+jjVyG4bocxDwkKFYJQfdJ7UNSUAZ+fm2qUXiTP7+ErjXact+6UvhxRGd0g4w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793096707;
	bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HX9ZRB43BBraGlRd7EWpyNMh4LE1jfU5MFvuOAKoPzc6/6jUmIrop71N7J7eXZ8nD
	 D+Lf9wSjXlkZgRDqFmiDcwtzELOJYCYm9OkG3XhFinWt/7Ey+5DuaqyYGCvb5TpIKd
	 oE4PgNsuCUiYyiJLcfULIQRfvVdBat28qOzBGXc+I0cQM8UzmrzK7KZbAZ76RVqWyP
	 em7aoyD3JDRtE899oOhFZ01EhY5XaftUyd80cFDbyKo7H7EVv4cOO4/sOEIjfW9RMw
	 MAge4kekMpKmsLwszOk3FblK5Paj7rD6kVhdO8RRbJrCxX0vIAYniD2PYe7NhfvgX/
	 O7P3GodIDlvtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7515540575;
	Tue, 27 Oct 2026 10:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D3D9235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6348680B97
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOPAQXdAdfxZ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 830C980AA0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793096705;
 b=ouAasXCtFEi5pYtMR+ckpuBCVbeT+I2Wdq33wvwY7z5gmPuTX2Lbky4Rq2Bs+C2vYIQH
 fQJfIbVOiTKSoJM3PfBV5u0Vst9aPdqvMU488i1Vc45bljlb/2xyfniyDxhgKStQ31BpH
 peWAYgtUvtIP1TQ5o6h+cD4omVDjZ9j3h3ivA2Ryyz5TiceBVAQfIS0t3GXNopTlFDdXB
 YIzL2OwQMH5KiW/AK4Hfx/oqyhYSyXJ6IeJB0hZxTLLfMVynY0Y2GRZrqLwUeMjG6vE75
 ftXvW6kfIU59hfENLc18FxBLMu5CfagTSv3aAUJfid8nyIat5S/hPO3yJJi/8ozoNeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793096705;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
 b=r8h+Gm2Zc5FKxcPebqQAjpj1Vdf8+6zs/cEolAo5GTP3ghI/SAPSL8hDY37SmQLzKONh
 H0XeY8y1DJ6WSFFVDw/lqU4CsGoivSbbo8XbUWvRw+xMyK3x9+PEv8vdADmU4w6wjy7oG
 X2sLWoOUEdPrBOKA9J0G1sbBPhhH1p+FLyvcVCC5v4/BRH4LM6omZxXi5z70pcMP//fd6
 IrPCEylhmxvOgXBcn1Wpp4RAdG9DkTuoIvSK/JRFGFLJkNP9+8PRKCmQ4OTbyrHLDTZVJ
 XEBZA2WpMD83x85DpXSKrRvrfqOJK2/xjTD44f+QgxBjSVVnuAUXDtmuyMpuGw5ixaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=g6XJrp8f; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hMJGmKX1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=g6XJrp8f; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hMJGmKX1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 830C980AA0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:25:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R8g6pl2761018
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=; b=g6XJrp8fBsXef0tN
 0kFT+Y22fNWvXYu1aoF3f5wSI7W44XSx9qW/WppWX85WCAEcsjB+6Zr2kpzbPks2
 BpuyfUMV0V0HurJwzxSWjeHmregnQ+3jiwNT6JeYKPigZqd97moVFV7i+LKNUeTQ
 ZiYn/K+/dgu/152hJ2bJe3QbABuH0aKtaw7PJBJefe3oSF87iXH8SBXz1RVP1jfg
 e5h6CX3sNdT5Lu45My5t0uqj/ekI0tC17NvebXGGdnmSUt2ndNFDSTjxcdYTqi5k
 kv1InN576ETIk5pIgn8idF+Wg/O8w2We/eHBiXjgUQeBhN+/u+gEPVW6YgHnBoqF
 KAO3fA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh919yn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:25:01 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b1a3d8a752so5767627b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096700; cv=none;
 d=google.com; s=arc-20260327;
 b=TXYf1iAeZfhPX+xL1SLkwaK80QaZrV4/H1KpFSrtoBgbektef4PusaOvIu9PZwVsh/
 NnLwSSQYc4LwawAX8q3hY+GXg8I44cZelsC56J54WUqPesbSe2m35zZhuLlwAzSN/Ye6
 t25t0d7PDqsHDixmztp4IhmNHyPeSZUyfGdDDwDThFecUUpwUVvCj9VkXYV8wCM9zrXU
 70CyEu+cSzwesM3/g4HZubMA9nbW6BfPD+mkearpJfhxwaAV3zsgzA5C760Ly9QMzXl3
 tPUgt3Gp4JE7oVd41xnq6VaoCgJXR5cvg9EBlQgWAk9FOr6JbxlZ32isKA+ykLEPHKTG
 5khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
 fh=pGZ1MwVBuoJ967DyVtRz0zee01iDAvwOkaiykVsqr9w=;
 b=EinW8/dmyCDeIvEt4UEi8xmUBnxSS9uKIZfGysDN2HeA6MVT8xay23L0WuiVzqaR07
 9SY52ILRMYq6nFKMj5p/WPscu258SK2dHGFugFwIu50J2LFejo5ERd+NC+VYwP6oW9z1
 Ad4qDRYwRJsDzMR6xsCxXysp1RnAvjILemRaXqHxD48Ecsqxo97bBm0DjOaDlq9DPt1i
 434UyF5hNsg88I/cs1sQbiTItH0Ibm271a/9wbDqj3JWYr46l/5DrvoZSwk05eH/KI7H
 BFu2MbD6YUcJiWl8wnvOTUxaUdyE5bpXk334z6xf/nOtHxKTYjLNrKw3sdbGo/hMPNFi
 S5xw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793096700; x=1793701500;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
 b=hMJGmKX1Q9wMQMsOic2ez0CBX0ErGmjTLXrkBN43nkQyaWPK0pSnaaiKACoXbYo6at
 lAQ+qlN7sJkjg8HAz0gmg+qwoLjc+o0o8smkGpYWuNsNCnjuCA+IPwrgOKoO+Ai7XxBf
 x/LBzOyC6pgVAsIcwuLMA2p92xUY3Pvh7HQwsTkbnKmpchZ0S2kToAT1ImgJPmJAI9aQ
 bqd84aHaAF4iUS1+ZrUtKzhDYmMT5ht0ue4135ElfQgI5X+etWadQflJN+q9qGYUgxUa
 hxzXpC07JINm75hSzxeDKt+frPDTacINCmzx+wK0knYlME1IFsaAMq0KU5xXUs0H5j/I
 HL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096700; x=1793701500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XhJrnL5SEFQekGsGGnxTjkZ7KAhpmfEMuIdMTCaJT9A=;
 b=IGQslJqez0PZTwHPI1Hv9ZLgib8dolBMFHZCQICKmsjQqvrLf0e/49od65bmmh2ueO
 7K0tTNzIieExebEXOpYJJ2IaiuauCVRC29x5hIpKkdVsXmQ1I9J7Mi5SNhjMDlMqGHpH
 icIqN4kjUfrx9C9AXiRKaV1lnXAmrhMQQNMcpTaZx3OQyvK/VXDue5oMdeMguhoSblF0
 hAxuj3lDLsrixPzhcQurrO57jblmmTFjhc1Vh/tfqiJIoVBQrL1epW/nDCXGs1x/aRLP
 SRWgAGmT9ucFlguiDceD5d/ZYgLtRTgb2pmfZjO5UgUCwpI5Ado6FaKpTScsr3QXZxya
 zGmA==
X-Gm-Message-State: AFq9FYKL5zSK42Ha/wO9r8jp3Mw4RtAerGSC2ewcNicMZ278OxLZxUqc
 YpILqJWqewVas8J0Df252esYA7GA1Ynixtenvj6+3hnUrdq1BQXRrl1w2VRCEcUc018Mdxtob95
 ggRU5PWLbE2Wwuyud2DmTVK2QKw/mmA+P3311pyQn8Xp6AXPAc+uzyApBGsISQICn0RhHASFoNd
 N8ITdP/oXt0WJ4ZdzX4F4WGgCJrvQ7qS3YRb3CSwiyySrTeaC5P8Udx0/Y
X-Gm-Gg: AYBFou2oNnsX0t06xY6yy40apqBB5wbIsBR8MLtyBWieVEQm3+LGHA7lkC9XtR6Ezj1
 MvepTwzw52bNWrv7pYiP2JATS5kVUX1DzwpPjAkR0+Gv9mFX4h9UWCfWa5tTEgcI75C1gygnUi9
 upO77YUA5bPKjR94ZOMs+gyH2FvdY452/DoZ/zhMIlAY2f6IxCObJu6zA=
X-Received: by 2002:a05:690c:4028:b0:8b0:c673:9958 with SMTP id
 00721157ae682-8b1669cb3a2mr55244297b3.3.1793096700500; 
 Tue, 27 Oct 2026 03:25:00 -0700 (PDT)
X-Received: by 2002:a05:690c:4028:b0:8b0:c673:9958 with SMTP id
 00721157ae682-8b1669cb3a2mr55244217b3.3.1793096699880; Tue, 27 Oct 2026
 03:24:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 11:24:49 +0100
X-Gm-Features: AclHuK9FoV2FWbLbXOeWCNUytQ6T96fa_3PudcEZddTP_o1HKPMsklBcia_dAP4
Message-ID: <CAPzfCAYLOOgRBDgBo589J=Tt-DD6c77-HGmYTEav0MStfQVrfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
To: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jenswi@kernel.org>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MImgxrJiJunO8Xo_O6ar9SigxkwQK6Ui
X-Proofpoint-GUID: MImgxrJiJunO8Xo_O6ar9SigxkwQK6Ui
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae07bfd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=PuJkxpu8uDOPrBvbuXIA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfXy4G0gwnAhn1q
 g3Ti95/2Kk93qkh4P8OTZXEp9CSE9uQ6Iu1uCwX6ceu+GG5//j49qhAMrJH7Mrc+RhYTqMI2HZq
 1x0CzWeALKFGGJsD7Bh98aSlQRAolFKwPsw3/7vNf2XoaC2PRc0wDtGjFL1wYnW1ROpTa3TWmgh
 h9ZdTVSvLNhv4tRmHDz9GYIMyeSZ8zLN9TTZRVUm8I1bV/AETEmAeobZoDJiXduEnbKpUImdz2W
 91rWWXAqktjoHCojisk69YOGCVJF2uNGRoO31gSZqC7em9Dsng6B7t1myKb2k3SCEog7yI8YBZ3
 c7nD/mjXq/CfMXn/1ZU4jHC9v+gTczVv6ayP9O+11vV6mqfUR/owHwrQzHfVyeAxezfmQ/igJQC
 4F/nlF+cZ4+4EAgZBQsw7L7ElqxbK5m42a705BKmWg8ThWI4BtQ5YCNtMjbKqcUaAU7RDTdENfI
 Y1tH/mI35PQdKbLJMRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfX++c3651IoR3x
 dVZ8ONX8X7YNgTXfmved0kcNmj01paLItxeT190a6h5DsgDql97ye2f25QHcYGRiAQGrhMTgqqA
 TKE4qDaA0sl/9/ysxaN7OEvMMg62S3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270041
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Mon, Oct 19, 2026 at 2:10=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> When U-Boot serves OP-TEE's RPMB requests itself (CONFIG_SUPPORT_EMMC_RPM=
B,
> drivers/tee/optee/rpmb.c), two problems show up as soon as a TA uses RPMB
> secure storage while other code is using the same eMMC. Both were found
> running the OP-TEE AVB TA from the Android bootmeth on QEMU virt with
> QEMU's eMMC/RPMB model, but neither is specific to QEMU.
>
> The first patch makes the supplicant select the RPMB hardware partition
> around every data request and restore the previously selected partition
> afterwards. It used to switch to RPMB on first use and switch back only
> when the OP-TEE session was released, so between two RPMB requests other
> users of the device (libavb reading partitions, the bootmeth loading
> boot images) switched the eMMC back to the user area, and the next RPMB
> frames were routed to whatever partition was selected at the time,
> ending in status timeouts and I/O errors.
>
> The second patch stops optee_rpmb_available() from announcing the RPMB
> device while a supplicant RPC is being serviced. When the first eMMC
> initialisation is triggered by an RPMB request, OP-TEE is blocked in that
> RPC holding its RPMB mutex; the announcement opens a nested session and
> OP-TEE's second thread spins on the mutex forever, since U-Boot has no
> notification support to put it to sleep.
>
> Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
> with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
> writes rollback indexes and the lock state while libavb verifies a
> vbmeta chain, and a TA call that is the first eMMC access after reset
> no longer hangs.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Changes in v3:
> - patch 1: select the RPMB partition inside get_mmc() on every call
>   instead of in a separate helper, dropping the dead store of the
>   original partition on the first lookup (Ilias Apalodimas)
> - patch 2: keep the supplicant counter in handle_rpc() as in v1, not in
>   optee_suppl_cmd(): the sandbox TEE driver calls optee_suppl_cmd() with
>   its own private data, so the v2 placement wrote into
>   sandbox_tee_state (Ilias Apalodimas); explained in the commit message
> - Link to v2: https://patch.msgid.link/20261012-upstream-optee_rpmb_b4-v2=
-0-85d76a54273b@oss.qualcomm.com

Gentle ping on this patch series, let me know if there are any
objections/comments.
Thanks!

>
> Changes in v2:
> - track the supplicant request inside optee_suppl_cmd() instead of
>   handle_rpc(), and use a local variable for the private data in
>   optee_rpmb_available() (Jan Kiszka)
> - explain in the commit message of patch 2 how the hang is triggered,
>   which TAs reproduce it, and why Linux does not need the check
> - Link to v1: https://patch.msgid.link/20261011-upstream-optee_rpmb_b4-v1=
-0-7c63edca4b92@oss.qualcomm.com
>
> ---
> Igor Opaniuk (2):
>       optee: rpmb: select the RPMB partition per request
>       optee: do not announce RPMB from within a supplicant RPC
>
>  drivers/tee/optee/core.c          |  7 +++
>  drivers/tee/optee/optee_private.h |  2 +
>  drivers/tee/optee/rpmb.c          | 99 +++++++++++++++++++++++++--------=
------
>  3 files changed, 72 insertions(+), 36 deletions(-)
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
