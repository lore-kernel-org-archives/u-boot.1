Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xynABDUq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gg6Oe2iT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dOXKazZT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9804E60640;
	Fri,  6 Nov 2026 07:02:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ly2hHw3TnQnS; Fri,  6 Nov 2026 07:02:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F1E06061E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793948531;
	b=RHiWfmW2B0jxHbXvoi78QrDpB8iwM6GkDtDkkxhlB03PMhybQVE9JIfAIG6KCp3KeTZD
	 YIBSED1Gr+jclo0p6YaJodzuzw11RGIABNdcA6u29WJ1dB/uv3D56gk51S0KD/1Q4puvx
	 IJEXOWN+vGdj1iwvcLIU2iFj8T5DctqQAMNZShNCE2EKEocVKbJXxOSDPDxaeaMSJ303A
	 f/BW93thn0UVMh8nT7Q6VEaoXLpkeXiy99keTPH9HkyAL75phto6/PXw3NzV4PfSMpwoM
	 po7YQrd+kUhmz5Q+yLGObOVbJzVMwvQEWHgJXjzz6667cJG7SbVxzKNICXtZYzCDVmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793948531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=euxX9PT69rxQLJbBFmyi3EWFXMM1JEI20FjyVxTPbBg=;
	b=nqrlpV6/QvquDbvPOS1sqckoESJ9AVPCdQSuEMOpwTXt5bBpOvFQAdvTrEiGanQEEAeb
	 LlGPB9W+6V0PNSH46iwv1GYM8t0GAuXNe5dZvSBZP8okujhIbaOF9Kbha9gAjBlG68S+j
	 yH+5fxfTakjj4OjFtfyA9b/n+IlUZv724EDM/BBiZ6ezW4PsHfthfBPQCW1fabLHp08Im
	 OWfd1iSuyc5cY5rJAMrGWA54I0XULrzWFptHYMd2dp6N2E/TnoJMyUYoiNAvj3aN/r6Yc
	 oiEWScYg8uokCKybDcXSj4IoPXyTcxJR0uSVgiYyHoNmiIu2nS1OZGBgahBxp6/Rd6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gg6Oe2iT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dOXKazZT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793948531;
	bh=euxX9PT69rxQLJbBFmyi3EWFXMM1JEI20FjyVxTPbBg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xynABDUqtFkBHQydi2U7IQrwujemsdT0ypGHMuYMcbGDqFj32dH0LmO4fNlQ9He0k
	 5VnaJWSSS6L22MM+9Rn80T+IMde+pWpjUjmuM58EIA4wF37ZQ6YnUCykQEYO2YLpwm
	 JcouL093Bl0QoM1sz79Ythrd/8nz7XbiySOZLJwr+JZlMoFfA8YT+faGsR5Jjpj8Vd
	 m21YGb7vW3euDdLBq9KJxGO2+vaVlTgVwd0g3xx08sycysHOc5KV+pwhcQgBCIPKCQ
	 zvhAHUQspbznd7JsQm86XFrZnZJKfR59Qm00yxUi9g6lJhcuj5cGHh/uN6WsmSIAPr
	 ojgRH63LEOe2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F1E06061E;
	Fri,  6 Nov 2026 07:02:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46D3E235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C0516061E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_pVxC1gkt9o for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04430605D5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gg6Oe2iT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dOXKazZT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04430605D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A641LHf2473899
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 07:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=euxX9PT69rxQLJbBFmyi3E
 WFXMM1JEI20FjyVxTPbBg=; b=gg6Oe2iTQw/iMflggq/MIyeYtbpTGEsVtCeliH
 BDpVx+J5mEyz3tP9RC+9IyWgiW6MDTy6Y5/8RhV+xlspB9TGiwq1XOiY4c5oAuMH
 7iHnJRSEAE3j1yFmPqKU/jl7EhOZ1b2X8ulwXot6/FqdL+TFbdH9jSFcnQq/Pwi8
 /1o9rbhr1pjHNPX03fuwIaTAoNNHHJ7sXUKniCwykwFQPTRLIniJ1lEe10m+pytO
 VGRc03wUCxg/aGtrYrZqgW22Ww8Xy5gGZsatq45e1g/vzxKOfP4qCF0/L23o0eW0
 e6GiRXaBLQPokIy22Dx0UYaZHx2x7SU4tccTPBeXYVr5SVwg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1g8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:02:06 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso789915c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793948526; x=1794553326;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=euxX9PT69rxQLJbBFmyi3EWFXMM1JEI20FjyVxTPbBg=;
 b=dOXKazZT30nO8SKiSqbSrll8UYGC0qAiepgxwVmv9mbKQWANGE4E+lSXlbd7qDlTZA
 9fhULXlIYr5MoZG9zEyQkmti+wBwFmKamtPFfHw/9zVCE3M1VCYxmXRLQZG0aFlY+Msc
 HtkyfijFeKe5RvPTKlu6YxGabOcGzRbV66sFCMuKVntS3j2L8Vvl82ckul9rdmEAdeu4
 eURUC03lGD1Yh9801duMzpFqUFYMdoWdCQMtiNM9B/Ic+yQf2LJeTjiGZPS8eP144nUs
 ziE+oL2BP9xwyuhZnOAY4AoVDgJ1ldr2vYCe1xjs+DnOdnQuw1k5Z7z7fB5ecYTX0S5q
 xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793948526; x=1794553326;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=euxX9PT69rxQLJbBFmyi3EWFXMM1JEI20FjyVxTPbBg=;
 b=a0LeKBXVdyfKUrbcio7FHwBNu4krtTP8Gro8YA87pPWjdzM28296VmP6dt4R50OMtP
 jZWnx8cYwgre8LP35HQQlHcri8nyqgQU9LndY5vBf+f+JBA6DfgurgKG3ciKW+VQfbNT
 6dw/9zCq8fT0yq+rIg3nkgKCU7rwKq3Ml3d7d407GWHu3vbapC49lhk+Vf+fBkAeA6zK
 KMvK/Tjj05E40HEz28O3pZ7nTl0cE3k+6+/bCinOZ5AI3XkwbgFN60sjFgAkM0bAM5wT
 9ANiUzctDONpovkIIK1oDy/lhOL8keLLv51CBgHVzn4Rfgr0tJhDyjf3cmEehqdOwTk3
 aRlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpxPHFoV/3rK1GUcs2ZQ3tEON9blkmCHXkaL3OU9JTE5IqcmSMHJIvonxA0k3iUKk6ow9zDR4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/D/9EHi3w4klrrPSuxkkLoVfyTa8+JC2V3DOWYr2bn1Mesu2p9
 pYc7eacN+I21bKN4h0ahIVcum1UHb8R+CxvsBZWNUxRL8Ms4SPchTLfl6QKsC+7uVNL3BpdHR8T
 WU0SMl6w7qpWMNkGh64XgHme8CgmYwynjYxsnWmtKxl3glFX5eQoHGkhl4VOci+mtvAZbu9w=
X-Gm-Gg: AYBFou0a6guJ0fA6IKlkuJGSCR5xYYXPwx2sTfhv3BWI3ruIN5wfOkDmVnasGfCR7xt
 IBiEzNOTn0hf9fiRkK8JPQX5XxR48J2vnucs5sa342Br6YPrKcuMjJJYbmDlbbrl7/Tkt12a0UZ
 oPTW3Zsnh73QLhmWSxIaoan0fJf1bVdT7Obmxdmtp5sOoETCtECEK6a+4rpL/bZTEBU0XPDbmPo
 /NBY2j+o5ha/OqPMVof7TeKZfXH2YSN3idVnuzI1GDyeEuxX9fYUl+Zi5Tmw2XA1ZATkTNEXFJ3
 R9Y1p57CO/RCJ3+nn/Q9RjxfdPGvC+IiBoWODdPi7tyDFBNgYrLtJ91UGFO0YSkgOBRlN61ZVw4
 st0oxI+fCWtY1MFaZCMV6PhaIML9VWFxoHCnDzaHMLkHESBW239aswUocD20Wrod+BFmKrrTTUN
 WQ4BCvWylpZ4FjVCjqxBNPHuxpTodEiucoUWjfjmmcLZK+X72iQVKQTSboK0A9pVVag4+npg==
X-Received: by 2002:a05:7022:1201:b0:144:fb42:52 with SMTP id
 a92af1059eb24-1b25d31e166mr1646661c88.28.1793948525638; 
 Thu, 05 Nov 2026 23:02:05 -0800 (PST)
X-Received: by 2002:a05:7022:1201:b0:144:fb42:52 with SMTP id
 a92af1059eb24-1b25d31e166mr1646636c88.28.1793948525040; 
 Thu, 05 Nov 2026 23:02:05 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2735554c88.11.2026.11.05.23.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:02:04 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Subject: [PATCH v9 0/3] clk/pinctrl/config: Add initial IPQ9650 RDP488 support
Date: Fri, 06 Nov 2026 12:31:57 +0530
Message-Id: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGV77WoC/yXMTQqAIBBA4avIrBNMVKqrRIvSqaZFP1oRSHfPa
 vkt3osQ0BMGqFgEjycFWuaEMmNgx3YekJNLBimkyXNhOK1babTgZ8F74bRyyrYONaRg9djT9c3
 q5nc4ugnt/h7gvh/2zyKfbgAAAA==
X-Change-ID: 20261106-ipq9650-v8-f0d54d4cade5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Badhrinath S <badhrinath.s@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793948519; l=3340;
 i=badhrinath.s@oss.qualcomm.com; s=20261106; h=from:subject:message-id;
 bh=qb9wUZoNe3MwMr162gBHku+VqbsISNpKnvMtKxg16rw=;
 b=rxJLZlVuy+1bVjliMBc/DOnBjtoC4Ssk/TPWITZpEW1AlKrj1fj+rN+YDB5L2iVav4eNTPRae
 X6FK4EaPlsABYZe7DSsWPH9089O45mnoIpgL+Jmmlm0S24V513ZZErP
X-Developer-Key: i=badhrinath.s@oss.qualcomm.com; a=ed25519;
 pk=ZJCDwDnSPTkkqcC32xlBRlzhvdSO5FnWlOjVr6IVBGQ=
X-Proofpoint-GUID: pikLUqbgopcGzp5-lqyW0d4_faxY08A6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX8F4fyskYl4ZK
 Yw2G42GhS7O2W7XDXPqzC5+WgwGYtEh3UpckCNEXYwEl61gujMkTH8GqVB+SBmPv59ndSOFHtzo
 HTWSmM8QEJcT98ly6PkBku+HwlMWzwgCj1BVX+FjPyBiwZR7/FSaFij8VoY45N71Sf7hrzEQfD3
 miKppxWJ3hxQzhd6wlitAH7/Y4tiIt+pxRX4u+dU052V60Xva7Se6tmu1ohYpu4lVQM1i2+9Xu0
 h3pQou6804bHqyb7hMR6CUHWAezynPx4cnNv9kr7gfTHrJuuQUp/9H+n2D6HXfn3RmMGng8P/86
 xRZOPLY7DkouhxpIg0pvzEIi2mfZI57caq7lXUqgxFUtuF1fHtGauDm7NEKKOcansF78YzdccW3
 K96/VE21YBDbiszT13hXtWY1E52AmSIUZ+qYgCooIZnx4gAgJHP4A9jrxvNyENmgMGeVXv0esQO
 SK5hUNQY1D54fsobASA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX9paoC/ui1Knf
 GCq1xWcaHUnWeRFgl9R+Sf6Db5L281sQFCnMcAmHEEzSXt/OKmK/eGkL0HBDYZSEREUGI+QAnNd
 RXk7qjYtU0R9DN7Hu3TfVbb5eiiaGz8=
X-Proofpoint-ORIG-GUID: pikLUqbgopcGzp5-lqyW0d4_faxY08A6
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aed7b6e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=BA_-LPzDovLyT3sFK5IA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060027
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds U-Boot support for the Qualcomm IPQ9650 SoC

This series enables:
- Clock control via GCC
- Pin multiplexing via TLMM
- eMMC boot support via SDHCI
- Serial console via GENI UART

The relevant DT files are available in linux-next [1].

Testing:
- Successfully boots to U-Boot prompt on IPQ9650 RDP488 board
- Serial console functional at 115200 baud
- eMMC detection and read/write operations verified

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq9650-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq9650-gcc.h

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
Changes in v2:
- Fix SPDX license identifiers to GPL-2.0-only across multiple patches
- Address review comment from Ferass
- Link to v1 https://lore.kernel.org/u-boot/20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com/

Changes in v3:
- Removed the sdhc node from this patch as requested. The SDHC-related changes will be upstreamed
  separately by the kernel team.
- For the defconfigs, the common IPQ settings have been moved to qcom_ipqdefconfig, while
  qcom_ipq9650_mmc_defconfig contains only board-specific options.
- Link to v2 https://lore.kernel.org/u-boot/20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com/

Changes in v4:
- Renamed qcom_ipqdefconfig to qcom_ipq.config
- Removed optional DEBUG_UART configs
- Link to v3 https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Changes in v5:
- Replaced deprecated GATE_CLK with GATE_CLK_POLLED in clock driver
- Return qcom_gate_clk_en() result directly in ipq9650_enable()
- Link to v4 https://marc.info/?l=u-boot&m=178471712422519&w=2

no changes in v6, just respin

Changes in V7:
- Rebased to latest top of tree

Changes in V8:
- Updated clock driver
- Link to V7 https://lore.kernel.org/u-boot/20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com/

Changes in v9:
- Carry Reviewed-by from v8 for pinctrl and defconfig patches
- Remove deprecated GATE_CLK, use GATE_CLK_POLLED
- Link to v8: https://lore.kernel.org/u-boot/20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com/

---
Badhrinath S (3):
      clk: qcom: Add initial Clock driver for ipq9650
      pinctrl: qcom: Add ipq9650 pinctrl driver
      configs: Add defconfig for ipq9650 RDP488

 configs/qcom_ipq.config                |  36 +++
 configs/qcom_ipq9650_mmc_defconfig     |  18 ++
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-ipq9650.c       | 150 ++++++++++++
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c | 430 +++++++++++++++++++++++++++++++++
 8 files changed, 652 insertions(+)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261106-ipq9650-v8-f0d54d4cade5

Best regards,
--  
Badhrinath S <badhrinath.s@oss.qualcomm.com>

