Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66515C982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1591A80DB5;
	Mon, 21 Sep 2026 04:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_oggtws7fD8; Mon, 21 Sep 2026 04:34:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4532080DAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789965263;
	b=R2t7BlONEkDs8CVFGq+k++D7tTDe08vZh0MjS1tC/ArdDqcRmAx4NM3w3XT87QxouqUN
	 cfQGDsj6Zq2pINfR8BaMCJzcyCw0hZRKy5enkI6xHxKRQBSD72hOahShNQri10oNHVims
	 QUJsL5g4dvA/7goa1g32ODKPQrtmtxTus749YpfhgRXp8N+SvygK3kpEbfMYAS6tNXlgY
	 gNHJpa6FnaBKKRL4Fjcjt3n22kUo4y+9k0cGV79LTNomvx+jqSUFPoTgDTARUoC1S7Pab
	 t/IO6engMeSWhNY+6bBWHCWOiJ5Qx3tmgapMx/9M0KbdTOh6B0OT4PxfX4cFjd/ontQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789965263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=;
	b=RTB1xr0bqrV8Ud5+5YF2v0sR2RqeXlWgEP2qi5VcYnQL9SUK2u2WJigyAd1+f8oPyhf2
	 cjuscR8Bzk8YFRFLuXpUKLSy0DY0di5NM6yUtI4YPq5o8uGJPuNVaX500+qgCCvA4LS6+
	 tJfwTYeLYBBgbZ882K7tg7KBDxb3aYjoyEra3FHy8IXnE/wiPBTB1t47muoBtDI7mMQG6
	 FHZiF6mIXobotKIuA51COYMegW+zFo7U604mF8A6TXSGBYY6iqmJ38qBArDX6emEAmJCm
	 d9Epi74/VkRLkOVBG9SARF3bX3ih8LOy1dALrHlYH1hFRFNGWxer6qld8Ujk1cA31cQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789965263;
	bh=Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYUEXveMV2YYbqVDtckWt3wMDKnQb6QVdbhDlFLNf96uw2OOHnK6zI+Yyxcnyvwmg
	 IawpkwYdAeIc7M08M/as/AjHdOvqaj2eJjs9AlgW/Jdm61e2gpnPfl3UV+8T4o6+6U
	 OY43Dxn8U2AjELybToLuYDZiVFxsZQeQKDiE0DjYkYSNWyZCsyTdghORJCNn4H3RxT
	 ULtHBb3YnKV5pLCyVzVqcWyPsGWuD4imzvR5Qmn+nQgyc7bMaz/Gk5e+9RnFCeRTZF
	 k3B5S1+1xthUFrvWZY6i3glvGjerA/xbj/Z3JFmILCJVBEG5DIN5UzzJddw1I6QGtp
	 dwEpgAPqowlQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4532080DAF;
	Mon, 21 Sep 2026 04:34:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 37E63380
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DCB540CB9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kk_oNu4Rd_6R for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 259EC40CB4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789965260;
 b=ekbMGc3jL7WUPNGhyK18lQQEWXXKBh0ils85NAMrxI9mIvRoanqEEJLuJb5f+fL55SNB
 94R7hP0LUPUgGgxOixC3IakHnB8k1WDvQ1faNpVoiiFyjL5rZEqJW+FISK1Z7JLFBIRrR
 6ErXkBd5hqu6OKdBjytLobRqKzc3LOoKocqDAu80RLoPnlzE5QRTwsgSutanQBOKVFz0i
 rF2VJRswfuD7z3RwgD12haCEP9mW4Ff6wJ8ut2GLozYqINHDvViQnvvTjFuRwuxTkTs6v
 /OYHuN74aK/OdB9jHTZEa62CL65UP7GzMk7sLvFj5scM8HDeoUPqkXlWHF7hr/Vx0pQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789965260;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=;
 b=b/zBubPXadxupm3W+BS7c2Lx1zhXu2vydsg0z0mT7MYCpKCt4pzOrbDMwZ5y8SapYNjy
 UiIPRu3w4g4uZRR3nafrgyQ1odtDAcQoExghg+6nbZWkAG8TuSZiy2cVyc0jjXcwc1PZl
 fTZ9ncRe0SdC7GOIQwcY7yG3SDMd4/XKK6uu3bu50eFUTH0AM0RLXgB2icfJy7oicbBfe
 bosUkKTC/Yqx4TPB9+lM/X1Uf7grIIHu0nejUWHO3bSnGmIfFdt17fmJ6CFyFO7MRV/4I
 Qxoxrpq7Encn5hq7FId/N7FgKwQW8v1G5nP2e+FzoUAmMR/kJlgbw2iumzdCKsjrMug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eodcPenu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hw8eNCT3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=eodcPenu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hw8eNCT3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 259EC40CB4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3Z9vY993525
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=; b=eodcPenuiphldhVI
 dwvEXHbszsoAcX5R5gNUfWutC1bi3DvEHjLjH3WisQGwGLutVwGI654j6VO/XZX0
 R6+BQDs/QQsYcGt3ynUMJq7khWudZ76bnI04A+xE/uu8s06dWHU99P6zWG6B3Cx6
 scld9tItgNd6KEKfZbPu7NYAotkaW3uZbg4P0/MTsS1xW/STeXGLXO/CVLB8nN+Z
 tkVh77HA9x70q+cePh/zuG/5zh5QGszFpCDlqYTrClAAYT0O2OaeqDZ4eHt9A2D7
 X0zDlowKICnSCyB4thRPb8Mw2p3pbaD729aJePcS8VtegAkoB3JU++huLMQ2CviX
 DCPjDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3v8k1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc42a07d04aso2198608a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789965258; x=1790570058;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=;
 b=Hw8eNCT3RZS1Y+P2EQxO50qBsbH2TWoUmN9gTwKBdirg0PgzbQUHwPvPkjHoCaKGq/
 Eb39hkQlMFGQezBWWnt2w+UAG1GZgR+cQQXoPVSOBzNZy0LygLyq1AHBHdQHyS06vCWF
 yRHnxacwmCTxIpegQZPw0alhQt95LnlP7/Va8wMxhtR3b1LgSmVS07x6G5Ue2SjumDiy
 lbVnwvLRUGxI65vmweuuZd+vBC0gWoP883QqaixFU9kumDuFSDqTY+E940tCbl/lezev
 k5tUm/h/RqXvbabjUvY5ZRRvfxBaH4FcGgONESb+y6uigu6YJDaoDivtln4w1wcBaKBp
 JPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789965258; x=1790570058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tk/Pa5f86EGXKqAa0cCDnAWpq66rjcSuzmMmZJu0Ezs=;
 b=jocfEQ5fkhFYHAnFz5BXbVLM2gOY+KlZ4tC7cG8LdG3H9H40TJV2JL3NQux2s6+4Se
 itPEFg5W53R3PydYdpu0KYQw65zfF3xxHbq+fC995ePVGquJwbG89MqhJvfR9zN2zx8P
 j/sDRk2Ij+sih9ZdK+OZFBaTiA3x7JHs5sOrhG4snC3P3tBHQc4GvSSRdnAe0LAtsrR0
 T9To4oBLKdCzPaVhMxNSAjRJ23BiKpJQofDfVPPgiQ0KmuwoCCT5WX5z2qj+aOYbGinl
 EacwGal10ECIVDGk9ju/ftY+/rGLDq0WfBe7wgmLGVwiGAaEfNkl42OvCUvXPs3tmOBg
 ZzzA==
X-Gm-Message-State: AFuF++kXjZiBpZk6Bh3TX6qVa8JAvi+PdHzAXhzY5z/KN7F8jTuX2jjJ
 bA/a4GFdIB8fLFZpVXGb4q5mGf2Lrmf07JPgtSlJbeVXdBDs/am1JgdhVSvE7R2Xese9DwF2KeG
 Jy7VdG6oIJZopsxzMRYMvZMuyut/gXKK7InpJIIQrMbo2N8EKgeUm24HqCRp6soaf4TGt7vs=
X-Gm-Gg: AYBFou3+ClkKYLmovsEvBOcJgDcTd+p7h4Z3d5knxKQhPF3Xn7LFKpFZglIfwEFFa5T
 nGnFek1nLrCp8JFnYYxX4LpO6nMFLqNvAV2tWj7pUWZJ0OfWzaf7Puf3vyYx8FKh4YCWeSYGw8i
 Fyvk3DACj0mRbW6n8JuVQ3UKbUM87HJ3c/VDGABtxs5GrpIF64Zwp3EMfwlwhByURivnAO7szjf
 VCQWyrHSSEvyd6asTPDiq62EVYYNqYtWNKHFaasg6p0R/LuZERd/lal9SqvyXMZA6z/dA70tnLP
 BDPHYfq3AJh07jVBJMxFl4ijvKY2VKiGUx3Dv3PNV5B29AZlQ7fzLq09k9rxjYbXdbRngGAnHEs
 7dJs6bIFMRUE9AnYJZGUMHWAnpf3dGZ8M66yxRa4LiiOiyUx0yB0RevMyLUmZFjF5V74aQbn79v
 AULETxC4PjHCJOFERZWgI59iW/Dhia
X-Received: by 2002:a17:903:2f0f:b0:2db:31d5:1448 with SMTP id
 d9443c01a7336-2ddb1b993d7mr143576965ad.22.1789965258148; 
 Sun, 20 Sep 2026 21:34:18 -0700 (PDT)
X-Received: by 2002:a17:903:2f0f:b0:2db:31d5:1448 with SMTP id
 d9443c01a7336-2ddb1b993d7mr143576725ad.22.1789965257716; 
 Sun, 20 Sep 2026 21:34:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm19427279eec.30.2026.09.20.21.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 21:34:17 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:04:05 +0530
Subject: [PATCH v3 1/3] arm: dts: lemans-evk: enable SPL support for UFS
 and dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spl-lemans-v3-1-de4b54320c71@oss.qualcomm.com>
References: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
In-Reply-To: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789965248; l=1388;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KBu/Ku124e29jJwlmcyqqxNmwAcWJrjNmI7gYfE/8m8=;
 b=2GmXzhCACSrV6RaY0w9gR3a3+i/vZraZBj9n6nddNEqIHpTLFju7CkWtp9LavW6SWQQ3dy7Zy
 qLwrSWxM6COCqY8TuJlcnOPqN+IDzBCCgB9vl+LEhvLmt39w0A2pyUZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab0b3ca cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nQCtNUuqFeM5Ofb-tqoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: XGnWCVG2Lz3_GAa8o3kfbA-MA315k3ap
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX70zFflLZ1XEb
 LsoIOQkvyGuDKIwxPUvYZ+9IhraJiM/yw7Ul5ekxdT2vm5l0vqbdSdToY7z0j7jUT72zCjh/jhV
 YjmJ3PlOUWZTMjEd/m10iNUxvKjGVe8=
X-Proofpoint-GUID: XGnWCVG2Lz3_GAa8o3kfbA-MA315k3ap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX+eM2neRuoEdl
 vcVU/l6Qb3ziLqtDd/xVJCTI3EyAwYeJ+tvK/Rcc2LLuuNrEAd3DH4DL6uf8JCZL/JSS7Bbl5kI
 JAj4Oz2iFhBtXRPXNnZJ5rEpFwzTORCit1XXUc/i35WCm3zgCVKmJmjz+TbPViZ4TnQ8DuZKCzD
 oRkjy5u5o/U/MKQ0Fo4fQ6U6iKjdYpTYThi2bbEllqooaq22LEzhdjoz5W3+MT6+qxSL8liAH5d
 Cp8xK4gPQLEgiTlf/txAvtrhumQsHeMaEk55lTvOK+MxaqxGj5yORXYWWGjYKQvXjKIVSHzh2DV
 agzSaBmSXhNvA6pCJ5wn1CWV6sqXzztj3iyR2B2YkW0b6l2Iv/aZVKiHUx+Qp4LqnjcQ3pQOVgZ
 eXc9VyA22TEaQsov6d5wc0FT1e6MW6CbI5tHjtzmLY8ePBd+MFzelMDf9Vpw1PahunNGH+fjMyb
 8SWujcFKQ3KVKNNEYhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210063
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

Add bootph-all properties to device tree nodes required for SPL
boot on Lemans EVK.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..586f96522fb 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -16,4 +16,46 @@
 		      <0x0 0xd0000000 0x0 0x01900000>,
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
+
+	clocks {
+		/* Fixed clocks needed by GCC */
+		xo_board_clk {
+			bootph-all;
+		};
+
+		sleep_clk {
+			bootph-all;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	bootph-all; /* Enable UFS for SPL */
+};
+
+&ufs_mem_phy {
+	bootph-all;
+};
+
+&gcc {
+	bootph-all; /* Enable GCC for SPL */
+};
+
+/* RPMH clock controller - required by GCC */
+&rpmhcc {
+	bootph-all;
+};
+
+/* Apps RSC - parent of rpmhcc and rpmhpd */
+&apps_rsc {
+	bootph-all;
+};
+
+/* UART10 - console serial port */
+&uart10 {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;   /* Make TLMM GPIO controller available in SPL */
 };

-- 
2.34.1

