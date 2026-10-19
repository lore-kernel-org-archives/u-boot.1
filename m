Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8EDCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B0940781;
	Mon, 19 Oct 2026 10:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7LbqkzMeEBM; Mon, 19 Oct 2026 10:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE8574071F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407064;
	b=V+kuM2m86KnYVjGhXmSXKlQDScJ6e7OPvahLSGzaBhFWX4f7zVH5sGlZYmPXjPd2OS7q
	 HbIpTv7iCJuIK0PkTiRHFGz7D+YNXTKCVLaSBa5SnMQG/LSDjW6AT4WD4zRV0KK26PeLW
	 +fll9vLH5Z7r34WZcVAkQFF/F3Q5QqZxVR1/hAhZPwRofaqqS9/+QSMzQcEzDHzKaK5VH
	 bo7HrWLZR/Uhm0b7lwFMynlbdojGa190CoUkJueOP6zlK6XPzfT/CLEjJE0jUErvf1AZf
	 LnfbCnHDIIDye2cPHvl3d7QZV1n63VzQR8e6YYZftfNss+S/NlFuuwZZlg5c2ZcngcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=;
	b=qHcKYYqbM0qo0KjXG8ZganjvROoyDhJjTqOiSZjR1KfDHAeyQFYTkLE/ET/k9TcXlQFV
	 HLetKjFpxvIDFZdqa9bUO1uMfS+T/ni4cK8d+UFd/gekORaKCiFbhnO9zndktHNBRIZPJ
	 5/R1Sd5++AlVNg13xIQID4p/pln/b2buC2UfFNxbfxj5+oQ5GEvCa4T8fQOC6HP7lbh3c
	 FxnWfHpASEW+aA75QGWM63eiIgois2P3xqRUFJv42Pkg0fDK1MCWghGHT3XA94psAwFLh
	 QvYeJCNnVTjGSOMEk4Adovrxl/Nh/CL4EkHkbiAVjuXDuDkJVxiNQj//3yYbtdG2rJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KKWQLAil;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vzt4ng1p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407064;
	bh=yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zO/2JcZv/kdnAIO0gleBzmx1Fo/aoIYKaocViSxcEgfk1A0ywciLpCFTvrWIpk3GF
	 1I+hxuodOCBnJZ0CFKWl0njoipVuVubmW5xq5WXhvyHFEveOFZBgeBRApLeg9MyhlA
	 VqT9kI66QOLZY0jEYBwT7IEE8PlbYVQpzAcWP+xm9N7LoDX5UyPmge0sJAWARoOWp/
	 5OY/lPJheg4t3Pn+UTpyCoNZzZeTTc5MGCOvswMFXgu1ndaHjB8wBMJXIRlMCo4Pdl
	 tcLF2Sdlmz8WGdUJIVCEG2Q7tgNfsZrOuhLL9n/ZQTy7azy3JAxpY8qea1u0Mma0vj
	 T8wTUNEJjkRtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE8574071F;
	Mon, 19 Oct 2026 10:51:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3A7A263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A66BB4071F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77cu3_-MBx7O for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E150C406CA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407062;
 b=boiJO/ClPnLDces4MT9PAejAdvG9xDVdgbSHEthQScl43FzT4oaPEB81hHTUTw4nm3Og
 Neh1s/HcTJd/QeDou0eN51XmuT9d63ci9UAtIcgX3orvB/GRhtsVWq91ZOcnm9K1ob6Q/
 wTKXTSpm4FkArKiNUJlN/+VsWPW6KXs0unwQcoY/JHIKgLMOkQ/pT+0HHFpwUTrjSRCzY
 HmvEvSjiRe2CXS/A4Y89V3iPVRUJZDQVEGSIAA7H9QQS3rlX1o222LBOZv7uNxXbKzzi1
 ciS+Vc/nZ5S0H7hxIExA81++zUenWlYXd3kfYQU8S8gDURCxkPbAGz3doMCbmzoHSJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407062;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=;
 b=QZTrLY8eqjgpRbHLYJZ/m1bwgIfaOSqLkVZNYcrebpHU9RLPUIzf7I3GPnYFztKysKMn
 WOAv2fZq2rrlf1zsmwPnelCJq7El7onG/+LEdo/8cCAIQ5IIXSY1VaZZh1bZmx97KJXmI
 a5ms49+jikpShKG3OKS/OZxhScQHLaGo0Ln7mYsZZm3DBWwOt20BsF5pfihbcRzoab4Y0
 F6sZXB9ydxTHjEYt1FGzBtMaBLyFRhDiHbWFX7qXJ6XOJCFtg3+TMpjAocSAlbCub2w/q
 cWIN97cywJjYa1f5JEoMvzZP05/ctDao6CYQMg1o6fwtB4yynanu+pbURO7PvfCqlLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KKWQLAil; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vzt4ng1p; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KKWQLAil; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vzt4ng1p
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E150C406CA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuVG2752281
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=; b=KKWQLAil36QrNwkI
 +8kNRRXGi5PUlFe07Q615Frli/kQ99lWnwTMc2cRnpHm8ljqXyIe/RonbLh3kuHu
 +siR1WSwIlLh8aKqdbxq0HHP3yd0qsc2QOkbT4n2wLEQAlRPe3EysfMGzt+9nYfL
 ZzaqUCvhPjeoeDf9UEW3VM6ymf9LIPrZ/hd7vzoL/+HkCfjVYGc6SlZF/PnT1vCb
 gMut8NZtqfWZh4ARuapdYwRVUNr7sCxma2JLnNy434FfrYFeKu/GqwP5P9Y5//UV
 3ryHHD3abH5lipOLbkPMqp8eKFgkM8JI2ubxgyjY9cbArtfJCO+tOMrch/VYozpY
 znCP2w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gpc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4267806eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407059; x=1793011859;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=;
 b=Vzt4ng1ptVpSD8W86V388CTXelARp5p54XLGNEyR53c+X1Y+QVUHQRiF8GLpiK+vpU
 HrQj6u89KeAf1Cmdf32FH4bids9Za7s58ZIyqtXxJ2GRNc91k7msTlBgBj+MOkI+XNj4
 Mbb3053/V2HNBSepPiTyYWPFQdtuCTuWnRqMi/ucSZpu7CAK6BbGAXun9nu75xmtCI8U
 45GY0XDMwL5bfUkZJG+qSaTgXyOUU+s6diSiZh/P4EgjK7Nx9PrcLfrV3PhEhYwFivR+
 kbd1r7J54DgXMxFNtEHIHeFJ7n1nrj+QDePkP4ryFEbU4IOn3RwlFkSYQ89/DZWX+G+N
 TaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407059; x=1793011859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yx+pPZOkPbl4u+SYI9vDO4YYKx80Scu6Ag1PC8rxRkw=;
 b=tfjZ4d2W1X+upVCtsxcBdEqDQ2tvKbnp1FmQleGMQzmnBkECuNsP/d2TiRUC2XPN8h
 k07os1SxbpqBdUgt5viFgK1dSH9uRA52Hr3MZmGtohMoidG+0Ncg76DbUCZ9k4nLJcB9
 Q8hVc1dbLb18VFTS8gPqgq0FiqDDNTuBibJT/JmKV3ELPRphUQRfk77GBAbx6HT5rsW4
 NErt2go/tdHa8/ocNH6jWWFtNjGWF8RAX07wX3OcLz4cT/70MkYgLw6HxeHiSJEB4KAU
 ipu4mm/S3pQAQD1AGKi52iMofIk6YHhnfQQSj1h/6nQmjy1TvV1JUngPejNr9G0PSWky
 r2Hg==
X-Gm-Message-State: AFq9FYIImFurYxa7vlx/dilBygMvba52Sc7sZK3s16cBlAdWjVDkswv8
 8VWXsVPU+H3hyyY6MUvJFSE1GqUjuj8ow9SNYwmL+pbYu6e2pghxEPL/DzLPAc2uk8nCNOgkuNL
 WFONJPo4bLiKkdD3U13U/x0C1BRM3SD0LrUaeF8AHqlQqGl8L+r8DbqmN5u7aeKG045pDh4s=
X-Gm-Gg: AYBFou3JKcU6FuYWXGwwd13r1JmlYv4H+u6RAF2AQ+bKsRviELLYbt9cFaW20ApfMl8
 LYB+bZeZOOaTtEiUsdN2OFXIh1T5EMyt6Xqf+3/BFaRne7hG8UNNN3eAaKi0xKXWJodF08zrXq2
 Q0ia1BupB9WIbKVkidhA5mRkrEoEtUaLcx6nCsphxtypSzdFYM7tPTlWcaFeOXvj2WpQvx7Ssz3
 TeExoemT9acpysyZ2UScI96H5CQN6OIspzBpfyPb3pB43/Y5Z9UUY5ydJ1SHfA4p0FEtRz68n1B
 5UtFP3W7kciAI0GH3OamGVpVFLnmBpthy2xuTcwdaeLpb1NqJGSdq3benEvO4aaUsvRq9/8EU/4
 XlsDni/ik431gS6ct6L7lmfWXix37WzG/ym2w2lMAvuVfxlqrKjhx0xhPzMsXokYM65CsrUgNuB
 kxhnG0ktw8PptTxwBzVbsnY9L3YVL+
X-Received: by 2002:a05:7023:a47:10b0:14c:fb3f:bedb with SMTP id
 a92af1059eb24-185136cad08mr10563096c88.18.1792407058613; 
 Mon, 19 Oct 2026 03:50:58 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:14c:fb3f:bedb with SMTP id
 a92af1059eb24-185136cad08mr10563049c88.18.1792407057967; 
 Mon, 19 Oct 2026 03:50:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:57 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:19:00 +0530
Subject: [PATCH v4 5/9] phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS
 boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-5-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=2160;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=QYQ2mz8pxIOe6mVJQQ7ZVyj6i6wF0biomY5hi1jPQcg=;
 b=rVATvQHEXBgPCA+7VmeQT/fP4dFRfO3aRk0//Dg0UWwjRSNC4kNbdOqLqoS6BXxn/mrIsMBD2
 WEjhTC2iwvjCVR3L8hDpgWc+eicpFyS2Tulch4Gy3zBs85LdZ9+aqLv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX0DVO0xoSxarN
 KOnagLBUf9YUCm5+ehkBM3ujSMS43/jgTukWJq0LuOhfOY25wTPuWyyNVYKniypP7mnX24mlsEs
 YkgJnUfDxnwb4JAM7hZYxWuwD2jEkjasVf6H3fn/XNiTNVzl2VFOO7PxZcvXzNSZddD4KbCdsdH
 9fShV7PeBXV73QShUVvtLxWIVeSArDEwgZFPdz4Bzs2B1Apcli/84PwPl19m2J0XlYELt8m4fyk
 yNkm0IrVVk3rxXlXSAhImJNiF95bvk+PKF/nc61nGdV2tRLbU4dAvQqsjsNh+n90oHHjAUoaZ6l
 iY41Yo3Jmzrc1uQiyWBVCIPWZFr7DlfRmhABnuSo7J8YM6kTjc/LPLnJtyQcUysstTJlQmafvwI
 dzmHq0dwZ/IvZJj9PCCoJbDqpgQJ8lpRARDq/yeQAX06HEOqDDlXYtkeyXExdD+NT3KWEWg55TM
 DlV781x9rCgqRchi98g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXz82NViZZblFn
 V0pCggzqMnlxcnK4AVRylqExE7ShEeqCCdEoyvu/Q+TXkr69S3UmTU7OS8wKGvjrisEl3ZMjbxD
 w0heGIrm6otIG3WJNCqCtvz61dzP2fM=
X-Proofpoint-ORIG-GUID: SUmAwhI0e0Uz1-LiKq1rHGnXhtko81xG
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5f613 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2JwEUUrR8hw5j8-u2NYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: SUmAwhI0e0Uz1-LiKq1rHGnXhtko81xG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Add a new SPL_PHY_QCOM_QMP_UFS Kconfig option to enable the
Qualcomm QMP UFS PHY driver in SPL on Snapdragon platforms.
This is a prerequisite for UFS boot support in SPL.

Switch the phy-qcom-qmp-ufs.o Makefile rule to use the $(PHASE_)
prefix so the correct config symbol is selected automatically
for both SPL and U-Boot proper builds.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes in v4

Changes in v3:
- No changes in v3
---
 drivers/phy/qcom/Kconfig  | 7 +++++++
 drivers/phy/qcom/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..8890854f3f0 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config SPL_PHY_QCOM_QMP_UFS
+	bool "Qualcomm QMP UFS PHY driver in SPL"
+	depends on SPL_PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the UFS QMP PHY in SPL on various Qualcomm chipsets.
+	  This is required for UFS boot support in SPL.
+
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..ec99fab4468 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
-obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_$(PHASE_)PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o

-- 
2.34.1

