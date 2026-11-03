Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE73606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cMaOcr+d;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=is4vUm37;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DYEp/Mi4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C6D340663;
	Tue,  3 Nov 2026 12:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4AIFmt9TcJe; Tue,  3 Nov 2026 12:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EC07E40633
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793707733;
	b=dpLaHMMlTU7MifGMBRsO1gwudLCQtDqJGDM27XK0dG53m7Xv8aKwHIAekWMrdtLJWGyA
	 zh6Fl+Pd3kKXGtnfN20Aw4kr5xpxWYIyU/4nf2L6H7umLvdhBCPmUETMPOSykl5MQgRs8
	 mWVAd1OwnpyMj/of9mW9/97v3NI+7OKd8olZISO6KTXOjUaA21UXsxOJsIj+TtOpncepX
	 //G1NPmj+VctbTE1mUmAacl9fcDPgWA16xEJyXLql5zKwgK/NIHxSQyOhOI9G2zn0rtdr
	 3gsw8O6HGrmkO1awox7FTS2nNU9wB+hleeWizXQY6yfElnS14P+UWepZceZeRMyOU3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793707733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pxicqYZxYgEfPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=;
	b=XGqG2TCejy59MCvwBvCCZlHHvyfMKO+uaxbTPRKcWhCRVxn2gwV2frKFY4OczJiPQe/t
	 HK7hUMZjp1pBVPN5kKSfLRqyIReoa/eYckZdbSu97TldoOecUIybzj2Txz+ioubiiWVOU
	 ztO4MvGl03pjZvsnXI4ucgkIdbMkDyYTxsAAgGnSWjPneCK/QrtD5X4tn+V7Fs9fbxZd+
	 g1bcg2Vfn1xH/SPbTEJxG5DT4aqYy7XoRaZ1rCnd0mKaJGEVlMefOuRSgPit+PA3jQah+
	 dcHixOcgMBp/EhOz4a+ShScg97PNRSm6IPEs9AQNupY2bfT4WPIPw9m9Igpdm6fIohw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793707733;
	bh=pxicqYZxYgEfPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMaOcr+d9Uf/5z0nyq3DnNc4UBduZqsHyF4Fk2CTwpuR7Y11R38R2zz2mIMxE1flq
	 mSMX7rWPZk2pAriErxMAwfyeQ0t9U/alqtcotNUdEYvWI0WbQ0AtuEc5ki+I7omGey
	 3qrMV3NuWvn0e71ODMU9u9AwL4PC1Kb1tP9j6JffNdSxMm/WEfxPSzAp/gJE5FIwoz
	 TATkbeam50WPdcHCy12R8PmECwWNcdBZvo3dDMqdJfBSn7fLH3fgcE6jy2hBaPZp0x
	 J0pFNbDWz1SmG5xXrnZuvLT1vnfUrD8j79W5wGTu78nwismMuQ1mgFqm/ieG92MUbL
	 tjogvhQKi4i5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC07E40633;
	Tue,  3 Nov 2026 12:08:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 479CA2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39310402C5
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mrOgqfNDWzcD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 20E48402B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793707729;
 b=FvBOwKgC60//0yWIP7B7oLJX9BpcgEF5PvBJu7p8pG26vzdGQmEmyMLLtogsR90kSe6e
 nXuFfLwJ1bg8uP/jhzyHDPkfBc1KMguDGZX0GkOrF/G3r0X7JG/Uv/RBbAmmebyjvJiDJ
 QSQliKvjxaBehFD4ceM0BKz63opvSHowigPjyJS9x0cSoc4DEzTILxAs8Xd87HYOxrbzp
 hmCKegh9jLeW/ObbMQTgeaeSLd/8ris4jYBD2eaEObHENHcT95YiGWH4wQOnrjPHd/jZU
 FBZYr6B7HJIdsNOgQqZY+kSqarR4y5+K+7do388S/2gCa2qbYiwwSWiUZR8W/O0FoGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793707729;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=pxicqYZxYgEfPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=;
 b=fx5KtApXSUAqXSqWIBSI51Nyxv9LIkK8ak6yzrXihZ8TtmU+FiRJfOz4YWUJPXqi563J
 t7YUGo1vgEnZw7+1IIbsl1G24MiUsLwKGhbEYohB+P+st1jYOpP7TG/3x+uR45WTYonmD
 y5O65eITc+2zZiqA1TYAizXlp4FAjX9ZsA6XHKob6GPLPfKgFGo3TSUSP++lZZEalPBZs
 waSBjn6aKdDmqsAodwDg3RP5z6klbfshxD0irUY8xfnB9UJVDl/CrnU0V1e0G1rhE3iCd
 kIY9zNtAE2Og6PgVHmTm+dvhlkQkpeKV7drj2Kkr8j6Xl+X9SfojIaqLaRCCP2ByzNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=is4vUm37; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="DYEp/Mi4"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=is4vUm37; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DYEp/Mi4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20E48402B0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAU6D2201884
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 12:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pxicqYZxYgE
 fPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=; b=is4vUm37nuKcsJtyynUSzGD/7Co
 a2ioWOyxTNrHNUivZHePvk01rcSq03wOAPxl9QS5ONs1BviHauAs4+VTVlqJokWw
 W28nPrqixjznYpm7HWaTpvJBos6Zc1R9ExYqTzDUSZnTZZnT+9/xMDx6L81OLeKS
 IL77uqRVFSc1qIMI3Oa14Ab+nehz6Qy1abLDH39V2CSqMXTxJLHGR8s5tEBoudT4
 qdyEzXIz+cYfyWj9QSZKC6HCRuYqKwQUxsTHY2UyZyxfMgpQWylOxa3lstpgAB3T
 eJlkuiY7MeSh/Akb8IChlU4PMpT/jVnepfaghQtwHcdqKJ7lbQ15Qsytl3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3mv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:08:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso925919eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793707726; x=1794312526;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pxicqYZxYgEfPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=;
 b=DYEp/Mi4me9DGhlsuiWSvCoBZdF+xUibfIV+NV4/pNunPo9tbHBZX9/eBI1AvGLg0z
 9KIpRvWijcb0Qpmx2UlRun3x2KF3XdqkRRlDf6qbUrmF5MLegutya5qr6yc3DFoBEHG2
 adi1kCRwH1s+35QQ9wFXWLeK2ca0otyvdLTjVFVyb1oKV+ReXIbxHM0LsjcIsG9+y906
 tykGbBoferaqJQGqxo44hIjE4+H8lF6b/z3sqqmgBKg7tfdd61G2f59a88TnnJoMzvIi
 1TodO0G06d6uGE2Wluz43mJHAzURA4nplh4HgI7uVEfN8mWMwLs4rhzNN9FKTl1fQ/hc
 CYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793707726; x=1794312526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pxicqYZxYgEfPZ4T97dc+e5Z1q6qZ3ra8D1OZ3gteL4=;
 b=nS5BPbOhYr4PX0GNKAX8q06y9PkYua6amidIToJNo3D3b5Edbvt3Ig8T+aybveDXbo
 lDzlVJBl4A2RBJMmv56oSJmlk9btUoaY4fpLLdYDtGrhTBDIPm0Wqb2c0En9qxmRZCwR
 lS+PHx42Ag4Uv0gVzUCmvfeHxe0cKMYtkAsq7n7s+GaRzqmqz0tJBKEtwS5ZZoaDiXjD
 HCXoavyq+4g0wpgfXOccsUjVMCorni2dpEpNANq5nwK6rH3jD4TIGrRTle6F50X9tyuP
 1l4YpWMtl56W2SGzF8jn67/ITlilRnVE4irLpmy5Bx0fnRMhMyNtNe44yQ0VcNezAUgA
 p1sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNnByDtz8SQ27Yhz0Ir+syyoW7ijkUbgXOfu3L4Hc5YeWTPtRZBnY2cLZRqfWfOY2kmFxgJEY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z85JfUou5HRjdlNHAUTXnei50CYAyluFT4ZxGIdre4BRGTRRRCf
 lgyo5hDERyV70cvFK9/M9C3jtLLv24OaUqVxGhMLaov0hq1jjA3+4CyjfiIQTWpgyUY2FAASY2e
 oID5Ym3UKCKxrF+t/3rPNWlEWxDOaZXpb2CwVXXeJL94qxQSXahgDir37LzfaeOLACs1cGHE=
X-Gm-Gg: AYBFou3UIiCN7Rp1Pg5mIwQO/tnShMMnEXPwiOnV0k8ZcQlJXECSrqIrx45HjHi7B2Q
 d8huosiAa9B07LXV5af/lyzoHFx4pz5cNVHFyVP6dyqWJSc7k58zBITYotnALKfNlMnlKmYLeHQ
 1ohDINjF+v1xpuiE1n3dmE889x7wltayhUVBLO9eW/irXrgwh3hQxJLMj5MSpDw4DjYgxK0HE0h
 daY+Vz9W1r3e9rZc7pY4QP5jniqpsyvvE6Y2mXSpTOn++ezTigHBaG6AaShPq/cxp4rMiRRVxMz
 NVQELMWEEIkGpaEer+vLNtS5dAm+zvVyordD/e1Z/aF5L2L9iUwROxKjgK/b38jMQHc+oB7Rh0L
 UsUsmBHmg+X8NLvucQNTtnnhXvyBj6gGP30iBr5juK/JA1DW1Te5b7h+0/z+Q1+i3byZ79UwtUO
 susLdfVDLZMClimwGgJ4NGyQ==
X-Received: by 2002:a05:7022:c85:b0:14e:d0ba:75af with SMTP id
 a92af1059eb24-1ac599f5132mr19118858c88.6.1793707726295; 
 Tue, 03 Nov 2026 04:08:46 -0800 (PST)
X-Received: by 2002:a05:7022:c85:b0:14e:d0ba:75af with SMTP id
 a92af1059eb24-1ac599f5132mr19118824c88.6.1793707725634; 
 Tue, 03 Nov 2026 04:08:45 -0800 (PST)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a13652csm48198640c88.17.2026.11.03.04.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:08:45 -0800 (PST)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot@lists.u-boot-project.org,
 kr.sowmiya@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io
Subject: [PATCH v4 1/1] cdt: enable CDT for Shikra SPL
Date: Tue,  3 Nov 2026 04:08:40 -0800
Message-Id: <20261103120840.1575918-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103120840.1575918-1-abhilash.v@oss.qualcomm.com>
References: <20261103120840.1575918-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MCDLb5mSy4F44lurrjROwHPLcDq0xuSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX3gk1PIIXTUQI
 pidX+GZ7kQtJsB89AwpLaUpjQNi73kb8aNNocWUpisbavqQXPhUDGy9BFmsEFIHDBXxybYxhlKU
 pO15MKu1A4ggugYbk2U9eioF5AT8qNUFBbva2BxthIUNfs/3o7oV+uSWuHnzyIjwfXwpWbNqyUM
 Rg9/pGn9yNujSHttTKExh/pJ6bEWuQmeFRg1ezHIMhEnasPotcVV0ZnCC5MP7brkADG0EtqhNZV
 JPG8OMVx6xRgVBpc0kVxccged5/YYl45qXGaIDyaAWoI9k91+Hnmrmnr1h9Uhgsgi3NEG4Cvukh
 p0h3LZAObRjXrJsXIO+Q+vRJwiVv8aagoVDdPfIeJ7NujiH9W0B8JEGXxYQc/ubZzMoEUKpOeio
 sLolMW9IJ5Tpdg0d2YuTLW5ch1IBNBocbEzyCgZg3B4gouFrSkgcAK0GTci8HwP8diXrOnlioJe
 HBeNpDfoyW/PFzviIpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfXy7VflUj5gdhs
 90zj8AEyfbKS67YL2GCdm4t5hoG2ZWTEpZuXvL24TRy4Hv8j/xctX26AbVrY3+XZzzJsGp4k5OT
 M5/th8HRIB/MiesTa57zvIaWQlWTucc=
X-Proofpoint-GUID: MCDLb5mSy4F44lurrjROwHPLcDq0xuSf
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9cecf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=DVBLV-CCxDFiMD-CaSEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030048
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig            | 73 +++++++++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 98 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 10 +++
 5 files changed, 190 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..7efdc5d6dfe 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -76,6 +76,79 @@ config QCOM_HWDETECT
 	  Hardware parameter detection from SMEM and TCSR for
 	  DTB selection and other platform subsystems.
 
+config QCOM_SPL_CDT_SUPPORTED
+	bool "Enable CDT support in SPL"
+	depends on SPL && (SPL_PARTITIONS || SPL_PARTITION_TYPE_GUID)
+	help
+	  Enable support for reading the CDT off the boot medium during
+	  SPL and staging it in IMEM, so that QCLIB can pick it up via
+	  the interface table.
+
+if QCOM_SPL_CDT_SUPPORTED
+
+choice
+	prompt "CDT partition lookup method"
+	default QCOM_SPL_CDT_USE_PARTITION_NAME
+	help
+	  Locate the CDT partition on the boot media either using partition
+	  name or partition type GUID.
+
+config QCOM_SPL_CDT_USE_PARTITION_NAME
+	bool "Look up the CDT partition by GPT partition name"
+	depends on SPL_PARTITIONS
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  name (CONFIG_QCOM_SPL_CDT_PARTITION_NAME).
+
+config QCOM_SPL_CDT_USE_PARTITION_GUID
+	bool "Look up the CDT partition by GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  type GUID (CONFIG_QCOM_SPL_CDT_PARTITION_GUID).
+
+endchoice
+
+config QCOM_SPL_CDT_PARTITION_NAME
+	string "CDT GPT partition name"
+	depends on QCOM_SPL_CDT_USE_PARTITION_NAME
+	default "cdt"
+	help
+	  Name of the GPT partition on the boot medium containing the CDT
+	  (Config/Chip Data Table) data.
+
+config QCOM_SPL_CDT_PARTITION_GUID
+	string "CDT GPT partition type GUID"
+	depends on QCOM_SPL_CDT_USE_PARTITION_GUID
+	default "a19f205f-ccd8-4b6d-8f1e-2d9bc24cffb1"
+	help
+	  GPT partition type GUID identifying the CDT (Config/Chip Data
+	  Table) partition on the boot medium.
+
+config QCOM_SPL_CDT_MMC_PARTITION_NUM
+	int "eMMC hardware partition containing the CDT partition"
+	default 0
+	help
+	  eMMC hardware partition number (0 = default user data area) on
+	  which the CDT GPT partition is located. Ignored for non-MMC boot
+	  media.
+
+config QCOM_SPL_BOOTIMEM_CDT_BASE
+	hex "IMEM address to stage the CDT contents at"
+	help
+	  Address within BOOTIMEM where the CDT contents read from the boot
+	  medium are staged, to be consumed by QCLIB via the interface
+	  table.
+
+config QCOM_SPL_BOOTIMEM_CDT_SIZE
+	hex "Maximum number of bytes to stage for the CDT"
+	default 0x200
+	help
+	  Maximum number of bytes read from the CDT partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
+
+endif # QCOM_SPL_CDT_SUPPORTED
+
 config QCOM_TMEL_ELF
 	string "TME Elf to concatenate with U-Boot SPL MBN image"
 	depends on SPL && QCOM_GENERATE_MBN
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..f1f91bf09c9 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -10,8 +10,12 @@
 #include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/kernel.h>
 #include <linux/err.h>
 #include <mach/qclib.h>
+#include <mach/spl.h>
+#include <memalign.h>
+#include <part.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
@@ -38,6 +42,100 @@ void __weak qcom_spl_soc_rpm_reset(void)
 {
 }
 
+if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED))
+/**
+ * qcom_spl_cdt_load() - Load the CDT from the boot medium.
+ *
+ * This functions read the boot medium for CDT information which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_cdt_load(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	bool is_mmc;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
+			 ret);
+		return ret;
+	}
+
+	is_mmc = desc->uclass_id == UCLASS_MMC;
+	if (is_mmc) {
+		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
+		if (ret)
+			return ret;
+
+		part_init(desc);
+	}
+
+#if defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
+#elif defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("CDT: partition not found (%d)\n", ret);
+		goto restore_hwpart;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE, info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			ret = -ENOMEM;
+			goto restore_hwpart;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
+			pr_err("CDT: failed to read CDT partition\n");
+			ret = -EIO;
+			goto restore_hwpart;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
+	}
+
+	ret = 0;
+
+restore_hwpart:
+	free(blk_buf);
+
+	/* Restore the default hardware partition, if eMMC. */
+	if (is_mmc) {
+		int rc = blk_dselect_hwpart(desc, 0);
+
+		if (rc) {
+			if (!ret)
+				ret = rc;
+			return ret;
+		}
+
+		part_init(desc);
+	}
+
+	return ret;
+}
+#endif
+
 /**
  * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
  * @descp: Set to the resolved block device on success.
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..ed3e5910e7a 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_cdt_load(void);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index b9a74863c1c..1c03df7ef77 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)
+		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE);
+		if (ret)
+			return ret;
+#endif
+
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
 
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..94d005f65ea 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -12,6 +12,7 @@
 #include <dm/uclass.h>
 #include <init.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <malloc.h>
@@ -333,6 +334,12 @@ fail:
 		reset_cpu();
 }
 #endif
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
+ *
+ * Adds Shikra-specific blobs/entries to the QCLIB interface table.
+ */
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
@@ -383,6 +390,9 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED))
+		return qcom_spl_cdt_load();
+
 	return 0;
 }
 
-- 
2.34.1

