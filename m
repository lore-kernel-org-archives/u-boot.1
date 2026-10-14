Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D751DCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D8A1407C5;
	Wed, 14 Oct 2026 16:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPDmBXl1oKAW; Wed, 14 Oct 2026 16:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA2C040776
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996694;
	b=XoKFKInibsAiEb5mF3AH9gZNgavEpCt0Z7fYrqB6IaeInK4T1lmzu1k4wMWOfMm9r0WJ
	 XeAAT9QEGRsNGsvlJ7umUQXZW0MDSJjq/oDGOVcp77DFNA4zcGmMEEUNwfx/Am/j73BB3
	 Lkmrh4O1yqyZIDa+nfd5dQflvB63V9TtodR/2b7rhDmXZ+jQi5g5R43yWEZzdAvTlU+YF
	 rDxBkov9MOUuWLTmE7Wg3mNjIDcDc2wsVmUKUMmQRfD7z7Hlx7JgKMfm72O+RdXo5izfQ
	 G2M9GmIGuYHH8rlDcH3yVFEOBA88b3g2ZAGP2vXzAwhsjgyxsS49MjBN/WO6uzFAing==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	b=CBIDt/JCDalavN3IdvRuVl0t+z8QjLe6w35rHiHVx2JrTSJx1nPNXYx3VpMrE505eXQt
	 l1hVgAjI0qwYNpDNYALq3gemawUhQT5zEmSDZYxuYJaynTe/0quKStUK231LR62Y+siUS
	 rlzKhB+cEJz5B82TEciuLt7hKc//AuXTgFnEjS4byCmFPG24C6SgB3u2++AA7zzqMhbFO
	 AZY8UyIS2abySh1H0CoRM9VoldVRVo8Y68RmCJGV3K9ETCOIfuqA2Sgf7a6q65hDttSfc
	 Tticcs32JmkGN+75Uz8p1bIuYtENq6B1soXSwgywNC963BZBqgEfyQqSHEwHH6R/pmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996694;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeFMW1icRNGcHM1k+grS1IMLbph0h6p/ea2zb8KZSnB7VsTENq+gcGFljanaBZMOf
	 NMrMbkDQUNFQ04cjO7J60WK0YgdCu/9hqMyWTOhQxob5UTLtDN6uwslGP5DsJLFwYU
	 ok3kMwe1zFQrSh4ZuTM1Q+2YuMu2BcuM5CRZa3AzjFoEp8xR4a7OnmmLHoSnspMuDR
	 EFtvNlpNh4SoFJxNPVu8koxxRM8qbuhhuvnKql8nVqY5CHy3/IdAx0IxKp+8GVePg9
	 sxX+xvM3QwzfF6kXOsi4rSD4lFubKjnT02s7vmEnz/ELq7z3h0zrkHAIOmwK/gRLu4
	 TQMiH6lfMhgng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA2C040776;
	Wed, 14 Oct 2026 16:51:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2D51255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D916440363
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEQDcmfoI22O for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 25BCD401A3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996691;
 b=NcLYGuyUTiPo5SWLO9Bek6LGzHZK/lS1QWpx+HeuVV3GXTKihlDrvRtzzQkYam9fnH/2
 Yr8CHD1BrJdHUXsFcfE321FDXMiARKRzOIvsBqt527Ay0rFwhQtP5FFaC8PPNK9b0zrGo
 qyX47mYE3GwyxoHXFivcwvFlnqToyuqC693yO/7YdLVsTZCCnF3MB6hk5dmbgMPHKWkdQ
 Zyhg59Pe7yEoGk0GTozUrmdvN3bz4PFsfZuNa6JMn/KLeAwPxd1cYHkijerNQ4+sh2ROv
 i0LSy2SMOImJ9eJiz0g6mP9ZxoKWRxYIAABw+N0fb0dx2sVHVm19jR2i7ODMF3wLmwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996691;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=excOaS6OuHGX2l820bWPGXJnWet7PGfILTz01f+pfd26+dYJ+RrEKsY/g+M8haHy+Sek
 fXsx/u/XIhGkptMjIoH4y+IOPw+Ll2XGeIXhHpONbOiecbJcOwOO+cFq2tZYf+UBO6OKN
 +wM1Z+zZtag/fHvQN10ANxH9fYmF3e4/q9sXSc4Uq0jM/AnhCJVlqlTD6iYA9DWDuGuOo
 SfMG8WIV72Bo97pTHzCIHb2OA1d0Iow9gDqFwMBovCiNHgmhmR4mJaf8wHrOwVBT+MQuT
 WpQSICqylYOl7KXEh8geK8a4CzuTgNvDjgs8cCV9R+RqWirzhGHekrdKsVxzjqD/oFA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=V6ZeQZ2z; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PnVJYkST; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=V6ZeQZ2z; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PnVJYkST
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25BCD401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbFxm301209
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=; b=V6ZeQZ2z+ZEIbi7V
 M7g5JRaVy0Kx/qNZ1D3H8wHABdWwvbBXqCHjUSuzKIMVVOhzyJq9O/TsNoJ8oavn
 NwhTMvES93AC5N55wK/svYSOWaolnk9M6ijEHxk9tpmxE2+8EnlCW4OxSaCzc6oC
 D/MwUlMY+hAOqo653v/Nc2xqolS/ypHccxN1lJr0BL1yMff0k0nKSTjOGYK+mgZP
 xMg+u0kt/WChQmrUVJAU45Ie5+yBQnGJUdF77AorWmfTNVnj90qDiCl9OlJJ9zjv
 3J4RIrt0WcFOUrT5r+OmJLF4I9vqd5olyf9Pa6QWZBVzn/UFZputkl2RuJD/hpB9
 58XZnA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622mgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6412329eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996688; x=1792601488;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=PnVJYkST9sBi1T6eOF3tZTsH/02Gw14fREqfRh0vO/1ObMxX9rHJXwdAVQsXNJHW0j
 14lGfz35Qn+B9nbU49tw2QbcwwbeUipuDuAPphLWGUTKG0srPGmlhCacDCuPJZjNUgfq
 wMkiC3t3SU/LH8uLbhGl0LJBhvj6NnZbvBi+42B3Py+234nCIi9V/sB9A0rJAyFGJxPH
 btrJMdlxIa6xEz77rgZaCDJWRUWv7Ag5BEcOeKgvwzeWWzFAeb+p7ao9zbGEkm3ReiBC
 1fXcb7EW/U+Y4YcveOjnC6/q+2sP6l0rbDLG7h384ST0ljlNK52ga7XPmrOaNxA/0/nz
 SVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996688; x=1792601488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=tBJnLiwvbIlYy7vO0g8qqksncp+ryE7lmRiVEUpl3mr3AmBPjPn6TwCB9h8Kc2XJij
 OrRVxcDqsUjL+bTOYNZBiXnD9Q5CYNUYobrpu0labwaWsvortGufWYJlp7Bgy5Pue9ZF
 cS5ZPfPtW2yzx6aD3FWHR/lTuZOmnZhqNPJsLRThdlPEZYOSJ2eq9gStHRT5glRpHi+f
 gUqK74TD4wOrBrhxYHLxaYq3WJglmW9sqG1/gU9HrzffY5q+YZdiTUUz79vZNQWPmz6Z
 4my23+foIiavn08EmOGR8WaFXPlERG/fndk6U5rgT9A/vgcOX+xrLjQKeJVjZtBNhxLM
 aTQA==
X-Gm-Message-State: AFq9FYIrx+cJ4tSrMkhj64H06tSIQrgzYTfY3LmtC0vHtgcRfHSlWz91
 6En1BaUw3pvXNQSbXLRVAs5GWkDuUUZ/pZojDqL61LIlJ+3Bzqz4jVSCj/0Rwjo/Ze1ARmifmVm
 lZrzLIrVKtkk94I8L8wUfkMmG5foUEDn6xgeKaxfz4IlSBJ10YR/BYxLXXTWU0t3p5l3yyWc=
X-Gm-Gg: AYBFou3ekD7DUtWaMMeWodRKSTi02FxvCG6Nh0/L5j1FBtYBpIgZYkeTsLSXO0fZqGX
 XbHpzh72uORK5Jv18BnqaIqhpEatqYEFdjVorov3rwMKRTYRoiqqSRrgobU8IC6SkV3orxstV6s
 0iYGAAuMfLCycjQa5ab5RuMXN/hc5QZChwZ3pA2oa/uc7E4Ohp0k84vTMU4pEapbMDyGLxlpQKf
 +pObG267Xiq7i8xLBAjMQk5C/AlSrwDjRsAOpApbA79r6U6PhtSCZkno5CMv5j6lXBtiqZaGz+V
 Y9co+sCMvq+iaDT1ufDtZwV/vNNBMEIDv11nBLMK3rvf6OvR04/iGIQM6FMsyHkg/UH73F+r/uv
 URxPI7NewLRA3ae6+tmVQGljJxDFtFKEfV+UeatRBxz3d8p/aYrBqIsZW756Ebs0yqXaIMtscaI
 dV63PngZTargFW4Jtprq/m6UOtY/c=
X-Received: by 2002:a05:7022:170a:b0:141:51fa:e609 with SMTP id
 a92af1059eb24-16a4c33923emr20747010c88.0.1791996687646; 
 Wed, 14 Oct 2026 09:51:27 -0700 (PDT)
X-Received: by 2002:a05:7022:170a:b0:141:51fa:e609 with SMTP id
 a92af1059eb24-16a4c33923emr20746979c88.0.1791996687089; 
 Wed, 14 Oct 2026 09:51:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:20:56 +0530
Subject: [PATCH v8 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-2-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=1447;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LB4JLdu0EwvljUsiEw/wbtHkBd6leAp7LUyhNhIrloc=;
 b=/b5nHu95TpE+nX8i3/QxEYX5VRqMo088VrmmAXno5+RM9FTF/+Dp9xptRHjehAGRAI8Px58Hy
 2DGIcVUVC14ADfOvHuon3jcYPkvHHyf5J5zHjlKfUkV3FPaeiq4cvGd
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: Y_ljkeF8GKY4BuA_kpJ0N_YFmUUBPwjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+O1jgBOd1NcX
 ELIMmnrNz8SNv2TMhn5qGVzWI+/daQyGOBbw/jUc7fyB2sH8j/MkuTA1cbgH77DcmxRLsEHNq9w
 5a7XJXbIA4vLK8G5uQdAXJhTjBSov3+prVB1Go7VsMjUybI3o07eFOgmE49MNpEG8ryb6rulbWL
 VPOoO/LIp+NCWA6GLIGgIKmbQK1npf6Vp+nQl9hr1g6j+UW8yKv5MUJgND8OvXxHYHpqCfGDFXQ
 CZs79e1MfGl5oGqXTHWkEOAiit3Rdsx+HPDYmy4RfoXEaGJO7RhvauuODMD6cN4MTTTXREHsGA3
 EHmwEoG4Y3tovUQ8YaXROGktGS5K6OjaKJFeDw99aaSAr57zjzF90nMx6B/FxkcycoDsIqHtyn5
 49/ASFM7dT7wGTBTD5WNiJmliuYH3tYbPNPhZwCjIb50rpCukPIrZZh8T700KoFewI9mbo/GMix
 BUprfIi7kJRbsLsNflw==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb311 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+k2VpuvOZbUE
 uxIX05owdrSr1r2iFymkSfRQmWuciV4G4d/bL/uaDucxi0SvzOsd7/OD8iTuGed63k5bSMopjmf
 uh/8hxsXgyPjHhNaeRpxZjVDimXooUU=
X-Proofpoint-GUID: Y_ljkeF8GKY4BuA_kpJ0N_YFmUUBPwjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- No changes

Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..daee2ed4fa0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -35,6 +35,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

