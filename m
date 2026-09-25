Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799CEC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50BFB60D7A;
	Fri, 25 Sep 2026 14:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I03p1G0V0QWN; Fri, 25 Sep 2026 14:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8853360D99
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346404;
	b=IqGQRbnKTW/p2vr4l6IMfZpkKf2CFgxAXrI2uwDNF+XTvEkq+F8JzZoDZWrG7AacG1Tz
	 LdRbB7XMPIQLYAC9ubOHt9hj6xB0rLUkr73QmRXF4J4g3xmva/X/BJZ+C0kCKgn2NO0Nc
	 uD+5abWBQIrDUnu/CtkrnyI66dgzsYUgKdgakaKdyNtxesbKez0eIfBQpXsOcozT+vmnw
	 gbYr3gtPzNe2fzhp09YfDoWSXGw0pVUXT/j/Pgv3NnRomnQ248tBC6aF2Y9Ec6v/x8P+p
	 WHq1cHeMRMdOaGxIfgBri7h5Pynp4+Kat/s3gNC/3Mehml6MPfIAO3MT9NrDl346y9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
	b=aqpL7Z7UMLHBEb3+grX9vDrJCJmsqtUYbbPo48tDScw7pjSw+xD6Rj82Z6eZ8X1kTXcl
	 Qb4Wc753s5XyuFYmGv6/TwIQA1f3CY5TNs6uow9UiQUX4GvNhTGst5JvNOvQLb6LZKRQX
	 Q7dNBnh7U0mp9M5O9vHYqvHCxqdH+vAwplRikWX8+d4SuaYY1trk+UC3Ay5xim0KNBTu8
	 FfHAhwm5kTwf8eSKGOi37wjByVFvv240g2jFwk45EHq6kc360SXlByR90Hhxb+940n+jo
	 Y3RO5j7vH0f2NB8mcjqz//KhFxRPRPf5+g4ik9NUJy5+aoroAqOe4IVPtSSbRu3BRtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346403;
	bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HEoK/NZ175YNnudS+3CW8hVqjIohHBe2G3kzU12QSofrIYPka7dkSrNrcwgRFYoZm
	 jDVHf+GksO4wjrYJJ92453iMU5X9iIDirz7te3VncOK6meM+yCmCkLADgvNevN6Y7t
	 L/PSZTmtcjgw9nv/tQPBAIECddatMqDjOj/CxSxhCwzlkGSFtOdDLJuS7f84m0OaCO
	 r8DULfvjkkuyOGIA67GoCMuAnZm8yWT6TVZYx4DgLwKUh7xgUPZRLrMMByqO5yLRSd
	 sAjT9xwkiH3/KFD6eB5NW60r1YCtCHkwNsB0dYjR4ALj1/2c1gAUsIuzoD0t6kpusG
	 LkXyLkbcO8mJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8853360D99;
	Fri, 25 Sep 2026 14:26:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B33B35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2101381200
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z64JosPQYmRy for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8F39811FE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343499;
 b=XspnlK5CqMmELowhm0RaJ3o/BUVuPqD1+b/K6cZEPYShtNuN7BzRK3jgniEep8XUTEX5
 YG+v54rFbiemQhTIerJPDAKgik54Rp0MpQR3LmoSgnnvB16zt4q/95Xef1jFJWV+KP4Wo
 27EW91esQG/BavqQ31oOJpg5QU5nlTtu6TfmI7v/1YeKJHu4YdPQ0lCeF7VRfD/eoLhB9
 JZ+J1VFM3bDxoekmarEkRhY+MZPosFlg9+gyNCvCa6I3dghaz0KzetTCIiJYcMydG+CCp
 0UgeNHKVyCdchc1cUmwYP6Em/CmHfJM7rv5MjoG6l/wTWb0LORP3UF8AeT25WCEMyQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343499;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=RyEDI8oYecJ0G6lPjvqfQWD8JQXyelvIGetfPI+r9RVuApXyggHMef907b2Fk+lVuu6P
 zFm1sNqX9s1KgYCLRcAg97Z46X7vcqrA5pl9eEBHjfbgvpl2LMri0PO8fJLLQkwVe5s5f
 dTzUX4+w2KrScUX9JtCAmBisH8KHFsLXAW4aOXFRMdlk2i3LKlpiVpUfssieFyVvMDxwj
 Dp6NdkYlQOjFA3g0+JQqDw/opplP8KmN8rJ4r3hbqndSgGYvKV7a5UwVRD4qlzOi5p5i6
 TanrftAVjSklQKX57ahGSrMAmYR6nzCTo3SKEZK5JG1nSU4ek2tz6DIdaFdLuXodnpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Q5RBUhaP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NYM8WZfb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q5RBUhaP; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NYM8WZfb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8F39811FE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD7jNd208631
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qWc4aScmsAK
 E71ek+32oiTVtKgVbHdgDVol13RhDaV4=; b=Q5RBUhaPT5GQuUKiIuVgsNsBSUd
 +GM0YP4Y5moq4aNYH0ZK4KsKLhClXEPPyJaRGsUuAfx4p1cis4en3KQHVa5bYf2B
 q2sNRqjTalMdxBsLmeA/424QVpCzhrWEBWVf4VpGoO3zQQ8CBY/kwcvofd+0C/fZ
 7JVgElTsdqMRi+ClVTIN7PEgcHGOxsxNF/Lj+XyRo+gM5fHju7nvckBipo1UeMxy
 E/T9jjjJ9sAJRRY68WfMSyWWiCw30hAesnoo+f3+zM7/CGcAHT1EVAwVtGJ9z8C5
 6xcIClD2Mk/aF+Fn7FoAEzCrHAjnCYjrcyvmGblHL8KaSgFwmOIxKi5SRKw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898upd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3412efc2661so1182742eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343497; x=1790948297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=NYM8WZfbGtdGb2BrCvryex6Coe3EHAkboPjnvrzY8TnW5Ag0Ph332GGCYNTobVH1I4
 w3ACgI8dWuWwPZhfEm4150awQvn2Mc16DAC67BXvp0sAJ5qNsyE0VdmFo29NJhVOqYQa
 Tkjyf1n390AHE/NgHXu2eaXwFRU5vywOBUOCMVzdf5fdTDBXLPwNx8aGs0ZOlE5T6HHk
 lgrtHJ7Wdw5BY0e2G8seWLUgYu+6thxOHmDkB4qM+PhXDrBEPdXRgpIdgqP06nmYblRd
 nHo5AtLktJ9phS3OHPv4//c/2UG06iR/COYHqjMRaqWaJSuTpCFJsTozUkH1GuL0MVZg
 GgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343497; x=1790948297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=fUxATXQ1JIZEGyhvyx82hKsFLhKolAgEVvXx3vVPWsQ8U6dF6MoHtaG4cTvGHuNtiu
 QwKh8Zp3L+LeuZ5k5bmqxJgJiyXYH9y0hS/42dX5CBSElrfxQ7J/JbSS8SlR75W+nw39
 MPcvLJt4I6QeEbOS5FH33Myvn3IxSMO6OWCc0YE6rit8Q4wNzD9SezR+7LnVTd67D8oH
 GOGnPsC8e56LKlAbKorXk9DE13SW/Y8B5JtB+Y0DMony/7oazd75a0U4nsR2m7qmPsaP
 O1DjVqFgcaFwC4GLgFPKNv3tExkZlBqkiUk7qMnaxAzAv+f5u/LPXkBihrzR/ZbrzAG/
 qulQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt4fI91Gcd2gKPYNDoPnDlVKMT6bd6ycCt7TM5CXgsOGK4EFCgwkz0Qf7wCxP9TqTiTo3P6wM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++luMSUvop19nFPabNMtdcQnJx/Czslwz0Y4UmvorA7FnR4aO1Nu
 hr7nb+Tk+8ulT3evWR5BhneoEhCnNOz8ZUi0vxAaFpbghWLefMaCw3NfGqghZIiOO8R8xJ/vCwS
 FCtmFvYjEJAmqk058OcbTlxdq6EhF5mSF6RlfLaxqvEhpPcpzJexB29s7LOXYzHtekCLCMK0=
X-Gm-Gg: AYBFou2q7Q9t4bYxVL9hLQuY7pc9uNooXTOsZgUInYYZEDUCDjhJZYS0rEqQSWYCSVu
 7QkdbomAxv9tRNWTpqRU4JyL9kWfqh2Eynz3v/zgsUeVs0NFv8Pz1dju0QFX9TsVvhD7S9Cnj7V
 1AmmvLf6T6ZLUYTEOFsEs1wH10hZB87Tzudzk52XoL50NMLeHL7yyRWo9TmtjNAPu8e/5TD+1W2
 dv8pTqcYWdvqoqnseL8cLHbaUXkjQ621xXu9z3xQzs7C4TWULi1Ml9uzijhQKiPEhGuMmcraOvO
 LB2/7OrZguN1BonuP0m1LNo0YshzGi1YY2j1Lt0H9+jrsV0vJLLWN5yiUCjJXgoh6uVe+I4mLbW
 DvZlCAjB+vJHmigs3hUIsKfLcE0MEbWJ9XsGm3yRhwqdVNCE=
X-Received: by 2002:a05:7022:ea8b:b0:144:eaa7:2765 with SMTP id
 a92af1059eb24-146ce67f3c1mr280236c88.18.1790343493024; 
 Fri, 25 Sep 2026 06:38:13 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8b:b0:144:eaa7:2765 with SMTP id
 a92af1059eb24-146ce67f3c1mr280189c88.18.1790343492281; 
 Fri, 25 Sep 2026 06:38:12 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:12 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 03/12] board: qualcomm: shikra: add SPL board support
Date: Fri, 25 Sep 2026 06:37:57 -0700
Message-Id: <20260925133806.1403713-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX5PpgkwAA43Xa
 U1y1GlvELKZ5x0vKFW9LfXajLdTX3Yxue5pZFrbhJnh0r6BohMVoaEgnBQZy9w2qqZ833t2WomB
 0zEDNc1vqjj3Ei/eV7VhvyydDaK67qZH+H6KeqUMG53q7VQH6V22RiyErHlb3aR8xObDHF2G8lN
 68vICuK2Wpr8WKp27Gi4vt4Fk9zzjLi9S8THzyJ39Qi6jCzKgYHmaCumAy2G4l7tVpNlPV71N1n
 oOKfyiNYDqyVXaESJUBCrKGKbt68qEYoWlhpoMozHfLQD7OAkWmpOJjsxCT6hFRHqXIzWS92zJO
 YaXAPEtc76KobmGFhZ+3+Jdvh/CQ0S5OlZ07FoV5q6K+QkdH1F08mCZYo1leFXFDlnWi1t/qBcD
 ISLkhljCcIbZzrYe5STiLNdxC1cMVpfgeqavVHjsCuYngBWVe7qOPesTjPB6Hxgltc7HS3SYwiP
 yuIq3DlHD7lQTb9SdJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXyo28R4WVm/wk
 SbkIphF8bL1IP1sBHhymCgFiGrJcXAu8UCm9PJKDQ+RzieOY1034Tw1LOVItQkdShu/djrya9rJ
 GlbuUM22RRZ+ttORQKR1l2PkVJ215G0=
X-Proofpoint-GUID: ysI37rZywdWQ4M-92AHRgxc8hmSGYOdP
X-Proofpoint-ORIG-GUID: ysI37rZywdWQ4M-92AHRgxc8hmSGYOdP
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab67949 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=U7ebsduSVgTrIjsT4N8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Add the Shikra SPL board implementation, build rules, linker
wrapper, and board configuration header. Configure QCLIB
handoff data, early reset handling, and MMC boot-device and
partition selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 202 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 4 files changed, 234 insertions(+)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..b967b0137b1
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+	IPQ_SPL_BOOTCFG_DEV_EDL		= 0x2,
+	IPQ_SPL_BOOTCFG_DEV_NAND	= 0x3,
+	IPQ_SPL_BOOTCFG_DEV_EMMC_SD		= 0x4,
+	IPQ_SPL_BOOTCFG_DEV_MAX
+};
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc)
+		return -ENODEV;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	u8 boot_device_cfg =
+	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+	IPQ_SPL_BOOTCFG_DEV_SHFT;
+	u32 boot_device_smem;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		boot_device_smem = BOOT_DEVICE_MMC1;
+		printf("Selected boot device: MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		boot_device_smem = BOOT_DEVICE_MMC2;
+		printf("Selected boot device: SD MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		boot_device_smem = BOOT_DEVICE_USB;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		boot_device_smem = BOOT_DEVICE_NAND;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	default:
+		pr_err("Invalid boot device configured: %d\n",
+		       boot_device_cfg);
+		return -EINVAL;
+	}
+
+	return boot_device_smem;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

