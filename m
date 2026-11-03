Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63F606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jXc0vj7u;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iuAYU90n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gfL7UDe+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99F2580C88;
	Tue,  3 Nov 2026 13:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yT-iZG_AUNn2; Tue,  3 Nov 2026 13:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D570C81119
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713478;
	b=iHnRIhxq61Er8pa43FehVTctugipuHNbWu9Ph098X91P6og86+SlVjIUdFmkqdJ3NMqL
	 BRQokXlVjC2VZPrig2neFYs8jyhd6aKoPUyXYOsTr9G2HzclctxiegHZg8MHUA2nPEfiN
	 APDiKJopIOpqE2UkXFNBXF7xprX+9G6AYUyXgeA1b92VIhb6hOU42NopggOWYzelGBUwm
	 OZ2UjXI6djfjtJ6m+/QflCevuNl4uJTQT/7fHKT3IKKTIYyfu5JY0uNzEedpnjpl6eiIA
	 U/lKmnGZy6ctaCudzsoqLCZIidhv2MeRUBo//mFWVR2wkNHSlWZMQfQrdacxYd8wUCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
	b=WhnXGgWYEt5GFr9PGQ6UBN13HlwNk0CZSd8gj26URDYcVhVoE1yhpuhXCPhTm2zR3lpj
	 m6NeX15OXnbffdZZOR4JGgRgrHleSen0yV2/1XA1BdQwM5yRMTOkOjMRKfUC3Io1AHxfR
	 3d9slQjqy9dwVaapwum3KTN18weeoIi37kB9i66OmBu9OABvZgGQ5+Mmr4IdTri6pd4DR
	 sOMMmaCTYxZUaoAtE8SiG/12HIy+eUvdxKbr9HidcWCvDd0E2kMF5QAxc2cbjwOYAGdO0
	 XOJtIutI+Q5jyZVDWTFb4VZt7/XMbuSG6gdR4x7tpWEDNGGFAUYoOsFPEX9q24rb1bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713478;
	bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXc0vj7uxeY6EZXi+9zrTKKg+D5DRRBQ/AJgDKJJ07c9o38Z/McdVuTo8BwffIDGJ
	 c8+S+2B0w81Yg009vt88VAhMwnMO5qD+MW26Qs4sAt4CwBJaP+BdD33RkIhqS6HSjq
	 tpQ3/grhvMySwyHRf/Cnl0GEeUWVGb6Bkrwaiu0k8kTsDlFFyzNzNjJxonCW9Tl965
	 90Uw3UAsi/dvcrIb5e1yjQfnV1GIxv0lWjEXBGttfhkgl19oMbSRPZ15CSozIdcxBM
	 1aUOyXclN1aftjv2YevpJmZRIgJ+mRfvITPXj4bxzgm97+XMSzL/KPH7waDrTIHEKw
	 c/Q+tvh2FCfyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D570C81119;
	Tue,  3 Nov 2026 13:44:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE207D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF48240575
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Q3jucCq_uQe for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFE2C4054F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713475;
 b=l0qXF09dzNZOUIDDgOHsmwOgWHQY/mkLQy2l9XWDYnLWUeutM7xSAcfNvoyLIpUb6A4+
 JRui6TYR1mSCG7Rplj0WaxE96fSEEXmZ4JZG3RRbCpSedGvqMfX1J317WzifzmYs6332b
 e5QizYTOHcU05dCtlIVX0X5/888Hf005E4N5OKxSWd9VFPoN9xqbyhh7UXOhslfL6KxU4
 QhvkEuZyOP/gobcaSyDAqCWiy545APHhb03tqoWKN8B9V4u1rLMCo0C9j89ZGG11QvdRo
 iRdf6/+6reGxVU8mRHGM24LTI6cP6DTl3tlfA1PnogusOlN9LcRQdp9hrhOaYJr/cww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713475;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
 b=AVnczA1BKWrQib2HGYDEX0kZB6oMfmcbt35CdhHlXBWSNBl4z2InRQta2FF0fVG/sbsx
 gShVc5LJG/t3EdtyZYf237f67tKI4PYDsl8rEwqF9lMLQLVqaklvRi8IpGYsLO1gBzGsb
 ++hqk3/QNCSx9UhxVX86s1dYLJI8O7cHktk0XvAxjGUwBu1hxR3AfMq36jq1d4W6N6zhd
 14wVRm2bn1qfaZ7g+o1r9I5at7omamct0FguoxCfXr4TdnhZEnAguBAsxeQOxpJopWeRZ
 EQKSzlEAanHbZ++RDniJhLmSQCuHve+lsDFHY4TTbYWkA5IgAc63B5OKbDTmGuj6MSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=iuAYU90n; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gfL7UDe+; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iuAYU90n; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gfL7UDe+
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFE2C4054F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ8jE3581200
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XvLlN/mzfvC
 X5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=; b=iuAYU90no0ceWTlcZ+lWP/J8ZuT
 cw9xpU4evRFUs4UBzDm6X4fFf5+IFIQAyYC5UF7+FPelInV9NtgRBJYtvrwFnp8K
 ZgZRfJh0bCighDuu/EdHYWgN14Vu0nGSciUwJza4kW26jkOtukTs7PhGf/WVHpNq
 sZyE6Ms3Gt33wJt4V9iTU/Z+NkQvTMeQenzM+hhQkJS7BK0Fh2ZugL5ZqffqeJp7
 38icqjf1K0CC6XWc18xjh3w3NGMwFHboOHLr1ftUgBkjw9rJjfykLsJVma/S3IcO
 6rs3XjHC4siaDhX32B/kzTPBRo33W7IK8OJRYAbIodCckEPRLqMg4mg/GYQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94csy4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so10443249c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713472; x=1794318272;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
 b=gfL7UDe+Ka+6txEyUiqyEk0b4VhwS+xUJ7kg9K4Nui4SRzIkC2jsFEW3UltyyweyMC
 GAlkhUJrbeaA4PG78WhPr///0NIvZcM3lFA+OOyke/bmvNzKza/ah48w/qH0fZc04MtV
 fUS8erEuY8W2cLqKOuVcS0DIpxG4xgPOBCV9bchd64z74wge9HMSQGjPUjo99K8hpvpA
 /Ur1SKcQN8T6GpcVQzoo2tgV+Yb0l745q0kW5IeJ5oyiCjfDRQkCpa9fO6p7AYVvqqRB
 V/XLO7LlD7Iud2p7pX9OCN+G18FeJfRGvUEI7mZUsu3b6TCkrdDx0GTpAz43mm2yQu3J
 kgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713472; x=1794318272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
 b=GjWMUU1A/F5LsLMhjJK2/og2ki07HtI/Oad5sULETvzTo03VfLj11GN/JZ2YeL2Egh
 mewpPQKo50FWt11TapmIAPjvvRBndpSPSPBXP5/nxxquf0HZRe1LvlRCzqKuD3UOcF2H
 O4R2CcWm9kiHzNK0CmRrKzGHDFhJnTl6db/DmfmYCZ94BG2E3zjR5yi2WDdQwyA6HvEB
 q79jv3rqW4TyADvxaMApQ+nNVwMNI+pbK8ZhpJKatYaEupydqMFWcMZQBry8HV19YdPi
 CJOHd81P8u+8uJy/8XJx7ABCNSXdK0TKrA3nFvhqI7CyE4x7ekv0Flw0iOJeV/E6sYuX
 QmjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZZesYFoNawgiqKk+e6/CAhZXorpYTKaM50QNWDSsUoot+Y4uIN5Y2/MpepMrDsdcGcN5VQiw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/HDIPkm/kBl9v03BbY2mI5KqxhUzdySvVb315/8x3omwOABBWI
 KzilSePw97hIL5p8Jld0fYpYl2cURFREj4V4XyJWxvkbb3bWO1SwUEBd7m1tNOhjFZQXu7XWjvO
 MAr4HlEBRdBWYbOvsIhKMiLQ26anxPRYBHhOuW3+LLA6Kd6UtMR+G6CjCmzmLVFtL28MXSDg=
X-Gm-Gg: AYBFou0t2xohPOugjpMwRotrtyXToT+sGYpK3VpgP3V/C2jUpEvj9uLdOo2wPJejpxB
 pzLJeZr2KUODFh/xAMMZxwHLWiwAuB1nxt8c+youlkHD5nES9XaUwB6MdL+4wRCU0ZtABMnea6n
 2din6sSG2KUQGtg2pJwPPA5Vse0UY7V6fHIypGhFoqcb0FC7mwQRkJDhyS/ps1593s2acOx+FRO
 tGFRiNxDZ3KppJCzaQkJRLFIY8dCgZzUNJx62/IinVXhUij5Hy7kxA8X1EdRM1NuQaL1Vp/FsMB
 dRPwTSHvuoZHnIVWj88QgfCJaZSkode06i2DowuWiQV/nGaW9DReO1R08F1bT16xFgKCx6kdLXC
 sjsQB/uZlIT53zzyQO4ZjwZh2wPn2BPpvKeP8BPV3mIaqVFcSOTeaS9WBx/K1KSuMi9FVB4mREG
 +jpL1NPegiNStuEC9Cu/D4Yife6Vy8SYwdpdxI/I8fVn6XK91r0Ds3SpkC9A7QRFlXDRjY
X-Received: by 2002:a05:7022:1507:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-1ac5d4b1972mr20327597c88.27.1793713471426; 
 Tue, 03 Nov 2026 05:44:31 -0800 (PST)
X-Received: by 2002:a05:7022:1507:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-1ac5d4b1972mr20327570c88.27.1793713470901; 
 Tue, 03 Nov 2026 05:44:30 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:30 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 5/9] qcom: smem: ignore partition entries with unsupported
 host IDs
Date: Tue,  3 Nov 2026 19:13:47 +0530
Message-Id: <20261103134351.3532864-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6ae9e540 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=LocVffI35S0ainJqWQMA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 1mEBuHbo281hNf6G_GypUQg9eGk2Vgvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX5bny4qJ9tPbQ
 T+UPEbneJpUbxXMlslbHkdPJzuOjrwImDnRuBX/u8ySUlzIoEeahZ80d8yLTQJyQdIDXwEPoFxC
 GRGMW9N/+QvaiVf6gqUNJhNvE/hpe1z6zNI7vHp9wm9FHDUxwuvvMr2JC0siXVl5DLVa58IGJvl
 Eus3tJTyW4EFpATWlEFiJ4C/zHAbgmdC+fyGA9KF/Eh0hCzGf3mkhCo1xeCMxV5ZUuqvqB89gNU
 YA0Mg94R7KwmXuxA+SrgDtjEbBHkDdxoM3MFVH3MTOLbrEhfy25NGnvCy7BygiyM4nVqpjnUtK2
 vLCdI0qWupQOiivIX8m9gCn5iZv0oW3xucaPHMlL2TXqb46KkuXADubQavWidHHFhapREEUWiNE
 ohDQ3J+W++7aRyibxE018t9UvfQvzNhpIDv23+aiQ+/JSHEOQZ4aavX2wf50HIzZqJlPz9JBp8+
 NSP0icY9uE1HlNCm28Q==
X-Proofpoint-GUID: 1mEBuHbo281hNf6G_GypUQg9eGk2Vgvi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXy10nismYPkCF
 zyZ9+WXX8pIALEbV9jI5PWw9tHKT6hOX7vWst/1HRuvMylgB22BuhkXc4qvW3wVeuDLVSxBxphw
 JrYSHh2C28mPNUWUYzz+oJm4XnRPDcM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
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

Shikra and other newer Qualcomm SoCs report remote processor/host
IDs in SMEM's partition table that exceed SMEM_HOST_COUNT. The
current code treats such entries as an error and aborts partition
enumeration, preventing SMEM initialization from completing.

U-Boot does not use these remote partitions, as all current SMEM
consumers access items through QCOM_SMEM_HOST_ANY, which resolves to
the global partition. Supporting the larger host IDs by increasing
SMEM_HOST_COUNT would unnecessarily increase the size of the
statically allocated partitions[] array.

Skip partition entries with unsupported host IDs and continue
enumeration of the remaining entries.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e20523e2cec..7a5a43e1274 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -936,9 +936,10 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 		else
 			continue;
 
+		/* Skip hosts we don't track; other entries may still be valid */
 		if (remote_host >= SMEM_HOST_COUNT) {
-			log_err("bad host %u\n", remote_host);
-			return -EINVAL;
+			log_debug("skipping out-of-range host %u\n", remote_host);
+			continue;
 		}
 
 		if (smem->partitions[remote_host].virt_base) {
-- 
2.34.1

