Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC9EC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4078940709;
	Wed, 14 Oct 2026 16:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPhTC8PxHorx; Wed, 14 Oct 2026 16:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36ADA4070C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996681;
	b=c02D4fK+9BCs1WLqbHPTU/Jes63xTbog2hvmmxJfQG7gdOQYuANhiN2JbE7McWr9GjAz
	 JSxB6ArmAQvmCJOCnk/NC83eg3gKZgecGCZKSJPNT02NlOg2i/F9ZPisFVenrG1TrEfLK
	 f6qHD+4333B/WrE0wlmCUxHQMaT1cb1rSb94Xvlh76AriR4PYQ6cL7h8dxV7bhK0ilgPe
	 wuSsijTs2C0xXYD3GGYu7D0uUvtGQCkQEiZTh0E70N+z0WsyFH61Hx9dTxG33Jx/oz71J
	 qnYiDrkXnGVTK3eou6KVExEIRMvYDCTzqgIJRtLsjpTQ/Yi0VPa3u4/5Mswn3qMNNKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=axhidjxotISukow77eHqescPj4NEBWJ8+AAxRVORMnQ=;
	b=ns8tPsq64naoFHH6wljL3Ud+0+qeGFlu1eTt8VM7KYvo4UlMspYkxHpi3lNourSYPOis
	 Ey+fx5OTPsVQm7XXIW6oW3KVjza4ZDkt4QDiZn8G6F6wyuUaBef+TM3OIohlR7JV97yW5
	 SuENYOJQhifz2MpE4Vk+bcL94c3AbhZGfpfhcmjrW2KjM6zHQ8iB4Uiz8pBSQqjDyavlK
	 XTaVBipzh2rwS/xBNK7pQHGlTMEcKzQMSxEGox8XYbc91WBF0SNPHey+eJmMqZHqU4sFX
	 tGonn1SliZ2FZZWbKZIBrMoKkRI+XZOTf49Ccff9DhRiAaEEBSKVRsUQi14qtz5DwBw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JDvclYsC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bTDVMeLz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996681;
	bh=axhidjxotISukow77eHqescPj4NEBWJ8+AAxRVORMnQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WP1avZYoW2KTee0kiFJLU+xo/2rX4Ht9dvvgxyY06wuN5fI0BNIqafjRLiH09WEwh
	 u3jLEAZhXDU45bSAE/1ahu8GPWsvxc+3h+xBl5I7EHCstaE0DTvO4ukJIkHNlQQhKR
	 A7CRO354UunPkSQGlRiTDdPOQnz+KBO6BXgeafX7ktQtVp/hcq5kkrwzRmvPuBlC9c
	 kO3LwP87p5mQzgBmIasFA1oQXHL201rYeDzYtYfOdgil01THYJkv4ZEFuFZvnFu2xm
	 yJjH4TkKzYwe6VlzVs+DSwtSmDehNaInSVsoBx6o1gU7SIGy+5hfl8uD874ESLO8iA
	 oM+zWT+8621Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36ADA4070C;
	Wed, 14 Oct 2026 16:51:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAA73A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC3E74070C
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3IGz4Ajf_m0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF86440709
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996678;
 b=KjMK4ZUkgjY6KruQj9Som+zwGbjDCqLRqfmY+aqwFdARbzatXY8pmAR0qT283SMeenjo
 0S0As+8MYsPMZbecjfO6D0SXY1KpMk/6EvjURo87dAhypeFUYz3XW0tTNTH46KrxxbmN0
 WdorqxuefVHXNLxhgDVxba3au/0/ZFUi48JMxbokhuAa8vGISYOpFp6eoIuc4OB/F38SU
 Jepa5MkA55p6qr7mu7h9gNGYHHvSLRhCHYa90mn6zdyjEkWWP1YEl9dBmjUAQRocAJL3N
 t+L9QN053CM0MgU7wSZUsTrudlQrHIw59Bf3ba2JEySgafTt2aSc6xNmxb+3q4T+OsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996678;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=axhidjxotISukow77eHqescPj4NEBWJ8+AAxRVORMnQ=;
 b=l/rf9e7Z4TCoBKk86l8TjImrntAlhLo7KPA+lAYPB7rppogBjwX3SlV4KKA49bEKEYMm
 U5gLxu+qeCU2mjkH9SPhlzWwygDKFltCZfY+ouZFy5r0vevYKRJjB6N4yOEFowEJQ08cU
 GfDdT5fxtLa5hhUjYfpxDwO6vQnBTUv3OHNJ4qYO2twiSJMuBShAkzgXecsCwClY87mwy
 guBWr33uKg4cJF4nClunVZVAstCCBJn7K16qp0mF8G+KeEclnjGZSYr2wSL87UM9YdEs5
 fCpnB+rFWxYSrds9yWeUPT7PssYmKu2EeAYisXp3Q2qXJgJhaN6xmVcmi7FGwEUCX7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=JDvclYsC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bTDVMeLz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JDvclYsC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bTDVMeLz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF86440709
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZhG73468841
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=axhidjxotISukow77eHqes
 cPj4NEBWJ8+AAxRVORMnQ=; b=JDvclYsCZI+eKSmA2MNM2Ov/rhO0v8cjmUXUFw
 1t/w1cJf29FhAdCPSqZ2/TriXV8rHVO11DOzyRtWa6tyaicQU72izZnAV12tSPxT
 EYiN5Hm8EP2gwnUWdp45yZV/VI5bsZRzbfy50NmUUiCSsPs0iagZunsT3Mzp54xb
 ZVfjXvIjsyXC9w3JDFeVfRE/ql+uYoWL+orZtB6N3w1U6TlAPn2CIiUF+HArybyO
 6cjqftU/kvv52c5R2UNsdOAkh753o5e9WOIS0poPfmaJpBA44S56uwWkjLIgH83Q
 irso81YVFC3KLY/Y7uI/8pimOXTk9cF/l3T4DU3Faf25yCsg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd781xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-155a75f91e1so722806c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996676; x=1792601476;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=axhidjxotISukow77eHqescPj4NEBWJ8+AAxRVORMnQ=;
 b=bTDVMeLzLlQ9oIji/fy3q6eGxriHzU1h2/nx9cwhGoPsQURcMMNlbYd0O8EFK8eV/D
 9UfIwH6hRc1xh4DokIWelOFdZQFrZd/Dg5+UZxAciaOFH9SbDYudw51JdSEuMknZU9vz
 yyN5D1LRyPGNWKbFeIDZmtAHmB+9vj6afGKYG9k0siial8jBG4kEE4DWPNc5mGthA1qZ
 +LaN2+LnQnB3CEEKGdW2l3mTxY0eH6cb7zD1oHPEtPXLyZqkVR6Umnla2Mx1kOsM8Gpt
 W8fZ204o9Dtwr+Ho5G4sEBpWp40syiCTUhx0GNArslPDp7s4tTUMLITGgKR+O2nV5zib
 +irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996676; x=1792601476;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=axhidjxotISukow77eHqescPj4NEBWJ8+AAxRVORMnQ=;
 b=0inEtKEa1kF98EW8g0fg1Jhtyh9PhXIdw0scYux94581g7r0d7H7ZbMGeA8QxMbSzg
 1DCvt93zjyQgBhu2GZHqbKqaLokAmgBGH7Qmja+fWr6H0QaDeJPZ9a4GRk1VLF3sF/Ka
 hUj3fm2WFrCgxY6WwKi+O85ELrwo35NBubytRwxXDY850UZm0LOq0vjGokax8JpmrZuv
 +Nm83lJBSxkAH06xxUtI6tOz116XTQxrdllZ95WJi02XMNXg9gCs5npH0NZq3sg9g6Ry
 jbp+Mkr0cAVa8isyoaZWiFkuzTGyxkvqv0e5wVtWSN+i+QJTyKtgKR7CMNN0InzwLKbh
 e65Q==
X-Gm-Message-State: AFq9FYJeD3wwp6JYmmWVm8Nk81tPx3nDkn9ksiNuCkD17yWRTaDlHKfs
 nKzaLWgU7VvcWbaBQ06m8NxqEdAEt5iu5Pu7uMuVWrb1k9SdHyM1wpv0ywWGCXSYz6KKtBytCb6
 uBEfg680yuwwNBFuL7preuhY9hJSy7uSBvS44IOky52NB1KOgcXr2wOPst8N8AV1ayloPusg=
X-Gm-Gg: AYBFou1SN5He+NV+x1xBUxa6Nbx4DgfPh0UjRev7khilRt+MByoxRemdNctQ+iblJID
 opqiduEBepjnYRr3aKFZaJDC5/BHBCL++QkDUrYjmyHKinixssAx646HDQX8vDK9TSzHDz+Hj34
 lvjrAOgXuyil4ba8pDrDv/b8q50D5QP53z9RtMsxExS0fU7p/Z74eFed1T83ijrkVIcW0tW/EMd
 Iixfc9fCteESVro26L2+lm1KQo+MSQFUxxVNWAULJcEwwsb1eUzarvffv6X4DWPet4Sylds3PV0
 PN5kVHkofqaC3OJ2vGZVGt54aaQfPyat93v0GbZWy0jdn63AyGE35FAglV2dkG8qF+i0Mj7leQ6
 iwJxWPzP4vJa/RfN7QIcdEFHKQxSmyRSzOnDsDmLLkR9j/P94LvKy/K4HafEoQ7Mej8mMIznOSv
 D2ET2dc5HtUCy7dQQ/YEQVTq1b5Xo=
X-Received: by 2002:a05:7022:b0c6:b0:16c:d83b:a72d with SMTP id
 a92af1059eb24-16cd83ba76bmr16931328c88.0.1791996676066; 
 Wed, 14 Oct 2026 09:51:16 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c6:b0:16c:d83b:a72d with SMTP id
 a92af1059eb24-16cd83ba76bmr16931296c88.0.1791996675492; 
 Wed, 14 Oct 2026 09:51:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v8 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Wed, 14 Oct 2026 22:20:54 +0530
Message-Id: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6yz2oC/3XM0Q6CIBTG8VdpXIc7AgJ21Xu0LlAPypZSYq7mf
 PfQtuoib9g+dn7/iQTsHQZy2E2kx9EF57s49H5HysZ0NVJXxU0YMAmKpzR0pi68H6jA3EppgWW
 sIvH82qN1jzV1OsfduDD4/rmWx2z5fUc08G9kzChQALQiEyznAo8+hOR2N5fSt20SH7K0RrnlZ
 fSoC6uMtCUYseHVx6eQ/noVvS1ZLg1nmkvzx8/z/ALb85VvJwEAAA==
X-Change-ID: 20260731-snagboot-4e9f66f0252d
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=5668;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=fpXzZWcLzVgqO3wUIcLEpFH+ZIOaVM7+VvgBziMp3JY=;
 b=eAtk4WrrXWUk3hKLqqkmjCX8eH7/2xGTQNzNacsItOpqdCA070gkjcLfvHfhtk5R6oSTbh1nn
 HFWBAfUZMkdAHofJoNuUB6H/xrPZV2pZhZMIQzFaxrB/oD3Z0urNLqX
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfb305 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8
 a=4GZlKNTyZuL0fuDD4_0A:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: d5ASAnvlDVXWOvjmjCsXZUQEgPg8cGpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX/uK2WhBmhgHR
 CA7aDIVfVuVe1T/60ZP+/w52gDcevgFECZLYGCmmp1V6dA6X75YSOt43jvc1U1E2s8SYkYlojZy
 HGIvy95i0cDsBSTNQhe/rW5vGwHA7U8+J8RiD0m/h7d7SDjBRDTfNgkhAFw0OLq/+PQjEFZhMMc
 dFEwSNUglKP4rYaTYeM8Na7uU6WX4RqX5eWXEHxlRWk3k2u88cGqIw26aamM5Go3QJt5jI2xz2X
 4GNRE5Me5Wo4KLk22hRj18I8We94HSMFWqJSfP9Bda8mDww2L3Fon4ziHusZQxSqsTsiyV8DXta
 xlZTYDhTmC1EE0fyWmU+VIEOlNOXNjvDcqaZ5p6fOvSFCnGU8CFMosC6+sgRf+eZoFo9iBGnOO2
 sG2YoBRgKdEAPIWHT+TRpKuuR6a4p59o86nYHzjxvHBiIkyEauSpj4hO78MQACPQ0LKlxsZNjVt
 /8RZ6lAaB3dFviv1P5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX2LYFyx26cLQn
 XyZYkXMpAuR3coYUApagpjKxBtSU1ylCuB9Ero5J1GhoTBlcqy8Y7f6CSPtGLn6RyKcsv6VgLg/
 iCgMY4PQccMfnw3EGiJUSs/+aiQstkw=
X-Proofpoint-ORIG-GUID: d5ASAnvlDVXWOvjmjCsXZUQEgPg8cGpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
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

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is available in
https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which 
populates CMD DB data).

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v8:
- Make changes in documentation
- Link to v7: https://lore.kernel.org/r/20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com

Changes in v7:
- Rebased on top of latest main branch
- Link to v6: https://lore.kernel.org/r/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com

Changes in v6:
- Forget to send summary in v5 cover letter, no other changes
  in v6
- Link to v5: https://marc.info/?l=u-boot&m=178577208345353&w=2

Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on 
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot 
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection 
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |  2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                | 19 -----
 arch/arm/mach-snapdragon/Kconfig                   | 20 ++++++
 arch/arm/mach-snapdragon/board.c                   |  6 ++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++
 configs/qcom-snagboot.config                       | 46 +++++++++++++
 configs/qcom_lemans_snagboot_defconfig             | 18 +++++
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/snagboot.rst                    | 80 ++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                          | 15 +++-
 11 files changed, 214 insertions(+), 22 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

