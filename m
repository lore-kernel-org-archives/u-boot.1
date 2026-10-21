Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB51606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IFnyW53k;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vj7tW5uQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQx4vXhM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B726608F6;
	Wed, 21 Oct 2026 12:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1APd1naYFdPU; Wed, 21 Oct 2026 12:46:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B309C608C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586768;
	b=eAwGcNvQ2uUOAQSi+0y+aQefXKjPXXTtqiZE/wwdOdLqnq3qX2An+0oJYJXNHrn+mvYm
	 W/tcHMs6ztD3V2dxfchOClbY+HB4ch0l0S3uvlBCmAezAUhD5hLjZ0BhmOE715CP2pOo+
	 o6AYV/WnWbABMcXwYwL8czJGogdpKvXiFzDim4l2azLmqalHm28J8ETLMuRohoDshlOI3
	 hIiLb0PrAJnE//rMUKdhCDa3WUZh2n7EaEmomo2lbaUB1DF1VTYCTWOVoV09EWK2x+MbA
	 ZK6OTKCVPYWf/4NKY/LbwsACx/0zV3psRJNpIOFWLh1L6u3czkSpQ5vnYZaZ5ZAKT+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b0YckQbrZ/ji6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=;
	b=rFsOYVpgpI5U4s36qUsmel4eI3eZJPcdqkZELSJGjrdMJmfLgIYDDqKMc96zuKLuwNFl
	 Lvbe2eMlrEsRnkOeU/FmZ20a8uTDV1KKHVBh5iq1HA5qvop8rIBzoVme6nWiO9dxYQWV1
	 sVKa74kpjexvZhiSW537MdmMoSNCIMzzAyzOaPYYmWm8ORgiS7hSKZwstZKqk8uKNBHT1
	 luXys8YabVPRXjqLETDj3kIz50C0p+AmrIzq0AdVdwk/rytyU9Zp91EfaGuM7VW+KCnKa
	 SB/YjmZbM9OlXN9B83cgf7rndehIdn6JjCfPMFmuthuf6NByseW1ljJ5JQy803gOFhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586768;
	bh=b0YckQbrZ/ji6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IFnyW53k+LTCzKIcPwKmarshWfRO/r25n6RWbXDFTkLkveLAI64khGD4mQ9b1XW2v
	 vEiSpZuDH3nc1LENDT+4qOhK7wBrULmzVgfLINbuP78mdYGFgKym/XFMHqpttavC3L
	 StN+bM16xmotPsBUWu97IMMpnj5pZGjpOvNJ/83TmQ3NXhEi6zvwTXc/pEqyBE8deo
	 EMWBFUlZHh/RmpZ6ZopmQxNwoaugyW4wXaOwCEsPwVmyfGA7+2j3cKo8MZk1Dd1aaE
	 bKIztOtQsQbszmIJptqNCeax2ZnMyHAEVjXgbNZRRkHgFCEqbOrNZ5x9WlKVjmzqIA
	 UQX4Y4U5yehxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B309C608C2;
	Wed, 21 Oct 2026 12:46:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D715FE50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8DDB8100D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4X8oLsUGAwb for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0D2780E81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578644;
 b=aBXqPGIuHHBHIUXFOCJkqwcvP4qDbjxrXJf5X6Nm+3nJqfWz6tuI3uTioQNKeaugW35F
 UQLCgLKm5JsbGl422kuHtaYyjvm0Qemh5VJwC9n0s01OekZszzv42YDg+tPOWwRW88lp9
 N5r1MbZmzqP9rr1ek6hYem22YlKvOh5DNscFGKmGKyUesktst5GbKT3vuoW2w3Yx57eyY
 FSKllG68ijk3lB68/VcWqqaPukP7wKw1kXBFCDW4Ii6dxTaUaF4eo+vRrMxf5zwMcnFrK
 PyadG8RZ6mB2cWCL/pIlqD3YSLVQoZzELjMvMXtI/uP+oBlziLWs/vBnZ0i0E/aVkfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578644;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=b0YckQbrZ/ji6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=;
 b=SJyeJrs9KAKBGuMhqEknDuwkadZoMxIPz6V6qCKa4OtfZpdDUIi/LVPWGWATvmdwQgYT
 MZ35OUdmfVaeFHzvbYZhtve2QS2Lsl/iIjnhhm1c5J/KBkCrvHoAFTjRMWFeOyYGRUVEg
 XDhdUY/z28URtr+blNUrCkYPmbRpj9/n26yeHPAh82gSWFpuc9ax24dfWnMoH09KVkLtk
 MNRHqtncigG+dwI6EhatcWdLMZS8LYj2ISo+W+HjpjwzZ6kA5GN/ufizE/7JVeVG+b2Vq
 zH/JC/XmVaAWfCiGs0yIce8hizPhYNK7/7vAUa/LmHNkT9roAMuXSLv6WWQ1NH10Vig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Vj7tW5uQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aQx4vXhM; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Vj7tW5uQ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aQx4vXhM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0D2780E81
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA69Cn117878
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b0YckQbrZ/j
 i6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=; b=Vj7tW5uQNiV/JIFjwe4y+M4syzQ
 Q8A0gUk1vbfEdIEygEdAIiUdfRPG09jbZJN8+7OrCUq7/qad54cAyQtWUkTJYEfp
 3PycIKhg8bT0OAl7IihLkRh/8eu456Ii1vLp6+JDi0yJsby5rfnzUNnb7o5U69OO
 TzG3dLkYXhAEdYADGcSgnmO/Q0gJ/t3LvFZ9V6FDBDrHSk6ivao0QyYeWoALQvI4
 8n9wEg+7LKPdarwyKel0UJCe0kZFYVedLddWubctGbDyyRtxr8Rt5Xj8ofUgjEyR
 wA691jva4/ZmDMMcbVmbpa14jUVVMC079i59GfXyDSqhRH/ML2e6TXfPYOQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v3h9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so1008239eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792578641; x=1793183441;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b0YckQbrZ/ji6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=;
 b=aQx4vXhMKi+bip6I6cmZeNd14EETtBJ7wTxGlD9Q1BDz8wQq7kklb9WXKkDixyJlji
 g6NWZdoDVBa24FM4lUrdBmKIyGETCN2kOj3AhAHG1m2aa7X34s9uSJk7EyCwPt6etHOU
 Vo2dVoIzmnH71nxgj8xxXS6/xQZhGUhyBErTVFtyqM2Nwrwdky5J/NcbA8Lap+13RJzi
 0cThQW8xOEVZ7o9NiEpOKOOvYZ7EBxmqwu93qyhp7Vj8j3QbSXDqKHjr7uSHNNBtajaX
 0vxcVWDMgTTq1ltHhYKfC86QDAdi6bjblm/7gNuk+l2WLgTfQPMCoh1f5J0CqP06q+oW
 dY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792578641; x=1793183441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b0YckQbrZ/ji6j+fOagRYeHAhH1tF3OT2PwLuZ1wLxE=;
 b=IAYvu7HFWn4ocbYEicXgUOT0ofXfpBNSBAnR/uZiBZwZWIJYFtfFbx0gFDN5hyZk5K
 jghSjQP2srHRKrBrRJVJwDPWCWew09B7sM+0GcK2rsMv7f8PrLgfqc+45pyD7jq7VWao
 oaFsHsy10fZVNl3/cKg+fWygD0s9ujbABzNcIAamHFZnxpUr0QK3VtnjafrUaQl2uljd
 DtbWQqJ0ny9wZQQjscNE+DggpWmokXFVTpW18B94fxQb19TNhKqHjhqXk49rWejOkfrg
 Qn7eqISer7mDy2bMe1JVVdDgfVrjqCwdcIY91tn4iTk2cL8EERbZLGspj0CR5LiEPTCc
 arqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqbXGEIX8Zsk6ie/ukq0n7EPLiXE9k3mXBFU1L92/SFAeldvjb9m+kgsNNeXShhBlRH15rR+8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLE+C64CHU+JCAUNgBQvHikSi/HH4X1IqQI8JezyTr/VF9l0igc
 fC+AO3c4p1tWcdsDGRyoK/evw8b4vlGpyT4CqEkqqUwIH2q1ltMm8JQUsvtxmzmOKD08MyXjHd/
 vIYLQOuyR86Wo+VGAUTOlk/m1OBGeP0JkI41GqXrP6Hd05yCh6QyT1S6eoRlnpqb9xN/LZcM=
X-Gm-Gg: AYBFou34LZ1c5smA6W7gKKxst/NVNJKACdZ2d7586KsZ4gBuIDvL2a9aZ3RHBHZ6xyc
 TOqR0+Xkvs4ipJDCNXBs5gs/xqqqBWYq4TyGYqJ7ffqdtSH5c84ncfKA0Lrn4i57eojYw1AzFp4
 AdQjsMX9C0DaSm2pPZbOFFjhXgBn+Rgv6E1xfFZ9CfFXpP/dBK9jaBAbB77aIBB1KlH7Wto9aLG
 zOItmjbN2lNWwkcY772Gti0DQg3dzxWpY0HVcQo18mb7wrhC6b7vj6X1RYX2DHaX+VwoGuWZHyA
 nVDbZIT0d6dLR1lTv8fJuI9yLfKOpiFBSed54W2X9qlZwYX/ZD+EQx91RdiFBF+UUbu5wubNNiE
 zkyGh5d1RekR+nupr8NxLBOw8pdeFUMtfCqMsJrtsKiFqdt2h/LJ5GW2LuMTrpUJ76/+cFeSJDB
 bcx8M7I3cJogov3f12
X-Received: by 2002:a05:7300:e9cf:20b0:351:4d03:c6a with SMTP id
 5a478bee46e88-3674d54de5cmr2930258eec.12.1792578640683; 
 Wed, 21 Oct 2026 03:30:40 -0700 (PDT)
X-Received: by 2002:a05:7300:e9cf:20b0:351:4d03:c6a with SMTP id
 5a478bee46e88-3674d54de5cmr2930213eec.12.1792578639916; 
 Wed, 21 Oct 2026 03:30:39 -0700 (PDT)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405edd7bsm6147480eec.6.2026.10.21.03.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:30:39 -0700 (PDT)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot@lists.u-boot-project.org, kr.sowmiya@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 abhilash.v@oss.qualcomm.com, u-boot-qcom@groups.io
Subject: [PATCH v1 2/2] DDR training: enabled DDR training for Shikra SPL
Date: Wed, 21 Oct 2026 15:56:02 +0530
Message-ID: <20261021102602.3815107-3-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021102602.3815107-1-kr.sowmiya@oss.qualcomm.com>
References: <20261021102602.3815107-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX8UKkQjEtstKp
 oIMUxBFVbSmmK+Y3mQDW9ypAasT6OXFYAkiECcKsun4qnKzgrItsRbpD7TI7aWy7k9mTfjbsTnF
 p8lwT4s2SzR3voJFlFu5X6gu7AYVcBg=
X-Proofpoint-ORIG-GUID: Tjcc-psOoVSrriKRe2Fn0kVhrjpOjhGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX8K3CaZfNzM3c
 +S+f7Ld19AbCzW15avqvnWJmSL3+YuHUcXjXsMpJyAJXU1U/Hrbx/fVDepnfagEG5BRMo5RspN+
 jpoSnJ3vmiUD+3pCmH2COLG8XUB+OeHQMLUCIEPaHDDD/eb3EHV4MOCsntxiXcZIqsPcoBchW01
 yeu0RD45CKEmvPJXlEmIxp3NANbHG5q/HQei/95wBNnhSZlWBQboenRc9VtgmbmsmgbxCAqzidi
 9bTqidq5dB6hSljcjoAd9Y5y1zIWHPGS7qHp/BDkSqo+vQI1bAIwysUlQwNWt8T6pbBR/WaExEW
 rNqiq3FU+N672i7fQnibmrthpvmKEBDAFuvp02djUsomog0AW2lgG6PC5UTuQR42G8uyhWKJwr2
 SaFeSEC1EgWP/7t37oJdNGh5GUpahNf4xI4uoic6I+PqOs79YqV3Nn1eQ9eq1UT7nCSm0wFh+i6
 dZAfLJOeOBcVLhCgPtA==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad89451 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8nHA0I2GNxhoUVEgoR8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Tjcc-psOoVSrriKRe2Fn0kVhrjpOjhGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210041
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
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

Add support for:

Reading DDR training data from eMMC during Shikra boot flow and sending it to
QcLIB via interface table.

Saving DDR training data in eMMC when QcLIB performs DDR training and
sends the data via interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          | 138 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 4 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..86f6d80d405 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -77,6 +77,144 @@ int qcom_spl_get_boot_blk_desc(struct blk_desc **descp)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)
+/**
+ * qcom_spl_ddr_training_load() - Load the DDR training data from the boot
+ * medium.
+ *
+ * This function reads the boot medium for DDR training data which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_load(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("DDR training: boot device not supported (%d)\n", ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_debug("DDR training: partition not found (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+			      info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			return -ENOMEM;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks,
+			     (void *)blk_buf) != blocks) {
+			pr_err("DDR training: failed to read partition '%s'\n",
+			       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+			free(blk_buf);
+			return -EIO;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE, blk_buf, copy_size);
+		free(blk_buf);
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_spl_ddr_training_save() - Persist DDR training data QCLIB asked to
+ * save.
+ * @address:	Address of the blob to save (as updated by QCLIB on return).
+ * @size:	Size of the blob to save, in bytes.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_save(u64 address, u32 size)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+
+	if (!address || !size) {
+		pr_err("DDR training: QCLIB requested save with no data\n");
+		return -EINVAL;
+	}
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_err("DDR training: boot device not supported for save (%d)\n",
+		       ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("DDR training: partition not found for save (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(size, info.blksz);
+	if (blocks > info.size) {
+		pr_err("DDR training: data (%u bytes) too large for partition\n",
+		       size);
+		return -ENOSPC;
+	}
+
+	if (blk_dwrite(desc, info.start, blocks,
+		      (void *)(uintptr_t)address) != blocks) {
+		pr_err("DDR training: failed to write partition '%s'\n",
+		       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+		return -EIO;
+	}
+
+	return 0;
+}
+#else
+int qcom_spl_ddr_training_load(void)
+{
+	return -ENOSYS;
+}
+
+int qcom_spl_ddr_training_save(u64 address, u32 size)
+{
+	return -ENOSYS;
+}
+#endif /* IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED) */
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index 10865b03ea1..a643f3240c5 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -15,6 +15,9 @@
 /* interface_table.global_attributes bits */
 #define QCLIB_GA_ENABLE_UART_LOGGING	BIT(0)
 
+/* interface_table per entry attribute bit */
+#define QCLIB_ATTR_SAVE_TO_STORAGE		BIT(0)
+
 /**
  * struct interface_table_entry - Meta data for blobs in QCLIB interface
  * @entry_name:	Name of the data blob (e.g., "dcb_settings").
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..a1c773572a4 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,7 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_ddr_training_load(void);
+int qcom_spl_ddr_training_save(u64 address, u32 size);
 
 #endif /* __SPL_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..448923e1b96 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -119,8 +119,6 @@ int arm_reserve_mmu(void)
 #define SHIKRA_DCB_LP5			"dcb_lp5"
 #define SHIKRA_ECC			"ecc"
 
-#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
-#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
 #define SHIKRA_PMIC_COCOS_SIZE		0xbc00
 #define SHIKRA_PMIC_WAILUA_SIZE	0x6000
 #define SHIKRA_DCB_LP4_SIZE		0x4800
@@ -357,11 +355,14 @@ int qcom_spl_soc_qclib_override(struct interface_table *table,
 			return ret;
 	}
 
-	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
-				    SHIKRA_DDR_TRAINING_DATA_ADDR,
-				    SHIKRA_DDR_TRAINING_DATA_SIZE);
-	if (ret)
-		return ret;
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
+		ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
 	if (ret)
 		return ret;
@@ -383,7 +384,11 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))
+		return qcom_spl_ddr_training_load();
+
 	return 0;
+
 }
 
 void qcom_spl_soc_rpm_reset(void)
@@ -417,6 +422,22 @@ int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
 		return ret;
 
 	qclib_set_ddr_sr_exit_address(entry.address);
+
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
+		ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_TRAINING_DATA,
+						       &entry);
+		if (ret)
+			return ret;
+
+		if (entry.attributes & QCLIB_ATTR_SAVE_TO_STORAGE) {
+			ret = qcom_spl_ddr_training_save(entry.address, entry.size);
+			if (ret) {
+				pr_err("DDR training: save failed (%d)\n", ret);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

