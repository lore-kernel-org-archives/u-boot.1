Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687C606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=azGfi1Tm;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PPJ9fLwm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZu10QT9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E23B560628;
	Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hl6_KWwd6QVM; Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 393AF6062A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792712245;
	b=mbrHcHevD/KV4znVrj9GT0/PF+d/frrixrz8X62jciu9Mmz1ygVtqqLBOU7s9iOoKaEa
	 OxHWLLJjNPoDhUdXgOjKraQBadAe3c4N4Dr1dSK4irjgPCyqHxIWCwTuPZjujc28N3yUM
	 uuQCttPvSgO5U0Cu/nyKrQlLvc730ydeYCDfFUYqcBEXRw7ACdPmuG7qDHfnLBwbw4Gtx
	 Y93p2JTiVEr+qht97hrCr4wM/GQzIxwp5fbXtiytt6aerWcVlYhxs1HbEvxIoiEEq5k+e
	 xqJc/QuWD1HhDNcWPAS3UHca+jsTOTQDSImDrx41tpocMVaL1qOY0p1FVQkGJiELniw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792712245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=;
	b=pZJ2/OLhHwjD+OF7yb+ywlDlF8LvxHh2zcu3GGBX0i8frLrh2ceDUjAogJbBssJ5XrF9
	 9Z7Zcud1WdJ2feSDr/H5k41VEeK3UfUObgHbVyYlcbTHjSHGHyJmvmi5I8x3NQ2BUngE2
	 HP408kNgs7hdEb3Hbw0rKcGL8nWkvdVueBOyZrZqesmYgVsgP0iGNwmjkYURjYt9p/6Xh
	 GKC0zZ5q7qtxtv8JZI9yc4f1t+hLPMsyuTT9zdkcHOF75Cr2O100MuwVDg8LDCUpgvXmi
	 Zh7FT1fpcCTHR61YOsZeLio8k2yT8rU8SZ/1ONEBS0/pqwhOIQKvm1Nz1jfP6KwiyXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792712245;
	bh=m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azGfi1TmA8u3cUo4Pl6w6v//z8uxLdg7cRJWOIHvbmswKsSyu/QlLqGAQaALc4ar/
	 zj9GPS8y6wCBxBjYWvZuO65CucZdRGDLopXmOmzBa9q3kM9Du/QfMnRej6z+CZF7B0
	 KOpf2+SmY+OEgcEg5zAoKBEjWUYVzQONUd4ekH+m6f86LycNnT1L20Hnxk3nVuDbki
	 K8B073O4t0htcB6RQYj1K5s9z7oMnVFqU74kTf1Jfp6B8KllFoJSuQ7HSeqxaPgVq5
	 UVRj9kv2JhH0X4j6L3cGa0UQv3soytAamLuFaLZ4lR+AgGjivrwQkWtervvUxiOqeN
	 fH0Otp84RMyPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 393AF6062A;
	Thu, 22 Oct 2026 23:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E5B2356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BB1F400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNPGTBXlwFHQ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B155E400AC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792712242;
 b=Eb2jL+Q+WtMbMrpyvSXn9uX0+mBPBnaUTU+jVZuYySqN93OF0o+ukqCsopVtVQU90gSM
 BgfF1IG2MTFY0yAQ0RnEaiyLmq9j5yk5zFgDcD6aKMCouttUWxYJ5b9nS225h/Xa5KKSV
 gJuVUng7gJAHFHkG69cAI43UlaG6c0+80jCWKPvBxSpukl8uafLgOFSM1XmI+u71NKa/m
 spnnBCDz1w6Jk401ypSZv6EYzIPi+yPGjAs0gAyxR0ytUhknMWVd3Rlvrn3uNCUUtBObf
 cFoxYUvPJjI9+5NOBTSd9fH2DkyN6qcGWnhIaACyFW2D/AEm32S9mRn6f8sUA5tspHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792712242;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=;
 b=rQ4l0z0M/v8UHZ0Ye+fH3tyhgFvzNxfShqn85gwQ0J8zUsREbHBpQ4it5uWeu2jo3C2b
 vBkxU2ONvP1ZUUvIoaqW/me2uDRGFXRGJYVtfXQTjTp2tsUcrFX3fKtONghKJRovz0Vcx
 AZ9t3HwG1Bl5Wo7xdVJDrtbI5vkBRgXHCWJFw+txo8LlQEzUpZjWrTSRXubIf2AtQBm8k
 +XwSHF4crDtvfFbInevV+43Lw5X6LeGQsVEH9ICQ6acCKei1cjfrlY3wVd0kL6E4+bCiG
 PZuRePItXsJa84E4Sv6nyfNnVm0+BlGFcIPDy2X2V+cJ2wiqL4RWrgzkqGr1vyNhRVA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PPJ9fLwm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KZu10QT9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PPJ9fLwm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KZu10QT9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B155E400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:22 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF3Nk394038
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=; b=PPJ9fLwmn5QZNCUa
 iOF7SGX+04Eqmhy6O7nThBF4LArFO1JPd46l/hasAyYz7FClSA9eZrlis0Al1IC3
 qjIvKbhNVj4/RGZ9CdMM+iKjeJt3AuQWuLGsnahQhiDKWCWgm8Pq2p/Aun4Nc4bx
 lHDedhbep29Rzg+PmR5hh4isPZtUS1DGa/ygCokZlj5GhsiPWO3Bk0jDSxkmSnFF
 SzKP5qJnqNi3QeUm/vxdMOW3COmH9d+WliYz7e3QJtl4pHQRXF6D/nXkxSyRsFf7
 we77yvTSmR4m+TTVvdoUgKxuaWE1DsTQZwLBgCS1v0T09cboZLxVc/fJSCuEqonr
 zjYpVA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmts0g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:37:21 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67935d0ddcdso684264d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792712241; x=1793317041;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=;
 b=KZu10QT9x0Gv3RMrRnLQ8YPyTd8dz/anO17DSRNmfzpW8UdxjMXG39nD9L0g79Qga6
 Eu9XecaiJ2xefvOuGUyCqd8Um5r+558GdEZkAACBFXuLe/C/ZMKKX3mQNf1pZoh8C8i5
 kYrR/F4VBEs9cnNNkKdApvlvTJn8G4Q/oSHhVA8+ahLaEuPRen7dlO2/SO+XMEheXTIo
 DGg5BbVVSyw54eJ42/B+tQrZog6m4jTPf8K+VcfwSDp7PhncM3TiG2hD1Wee2eA9cHXz
 UYlHHxM7t3DiZpA0n9MGKocermauRnk56Kvyh8Hn2Q71eb497FXtgWccT0/7yWiZyRff
 iBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792712241; x=1793317041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m4R3hdhAo2E8yfQHVsKVKQmevZOSAb28HD52Jtzycd8=;
 b=IIuo7krIy7hqxAQQS8uTA2svWPWZ7RVOyGZHaelx/Q74IayjBSzzbLQ5FLvX/2ZRI3
 4nPKSwxyuvfSKPNNvG/+VNoAk0XMxUFENpBE3nbHejw6JSIDNlR0R+bcXQ5I4m+iBegd
 BQeNXxYTbfs84hvsSXtNf8BqZyzVcJ5ydRCJUSQHznGr5hZQbsMBB78pZYY2NBTAbVXa
 JSisfKhhiqg9Pqk+DX/uFDKLqsMf/rFR/sGqlHRiOGzp+RCmXcSsU5puI+Lmmtuxj73K
 lRtaibU0c/qKo3Z8ux086D3NBbY+nNXdPW3iG6wFmI//aO+RDOZsogMnMizDbPagFrMf
 2nAQ==
X-Gm-Message-State: AFq9FYJ757dNjc/ra0Y4FtmFxlDKgahmEUTmD5gSRvMSMZrgeTkd44FL
 mwMst+vdkRvN441R/lQhE4zBumrZNu5vTvVlOKTRo2ZrBUap2jDrFtJjpE9v9PPAq8kcbRX2vrx
 sL5NgJfZdlCrm/vaMkLNiNVp82yu5GlXcyyksGDh95fmDni3sL2GqQKeH4q+5giRYjbAI/HI=
X-Gm-Gg: AYBFou1tpkuNmShDKhBZxl2UPwA/y1iBlR76aNzP+z5tKkOwAM6CTZ9og/sB83+YK/b
 FJ4NKvJewp/MFeK9H3O6bM6vPPnhpdLGFx2NaUd41K0ZqEsonMAG0QviRRp8Xqt7J3skvf06mRc
 St/4jz62vF3vrVpQfarkFkIe89HLzoOhT8Np2NrDHyZ14194ExVpbFK3kcXvulhtAdhQRF7XGS/
 EpCqAMJfAlTmft/b3eDV0k9SuPUc4kRb/telElXLj2yumRhVTv4nZL9q9UbW2IubWGEc3RDkS9J
 EyEKEKpimyUhvj2Qw/w1tRcVum89eWv4EuNQwt/UcTIfHqes4azkwr+CPW3DcWjKmB4xuDry7xS
 fHfGAQTdov/Bj3hK3C8nqGVxWrE8iCEi8LnQuL3xsuB5n0zNdXAudvFfbldSF
X-Received: by 2002:a05:690e:4081:b0:679:42b4:affd with SMTP id
 956f58d0204a3-67a35bb8c75mr496865d50.21.1792712240955; 
 Thu, 22 Oct 2026 16:37:20 -0700 (PDT)
X-Received: by 2002:a05:690e:4081:b0:679:42b4:affd with SMTP id
 956f58d0204a3-67a35bb8c75mr496847d50.21.1792712240414; 
 Thu, 22 Oct 2026 16:37:20 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a34009197sm474505d50.12.2026.10.22.16.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:37:19 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/2] efi_loader: capsule: allow platforms to map a
 capsule to an image index
Date: Thu, 22 Oct 2026 19:37:16 -0400
Message-ID: <20261022233716.858787-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020-qcom-capsule-dynamic-fw-images-v2-1-3824f7a66e1e@oss.qualcomm.com>
References: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
 <20261020-qcom-capsule-dynamic-fw-images-v2-1-3824f7a66e1e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada9e31 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=mZwSs3dG05N-8cdlfacA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: 1DY7zOx-MMHGI6RJGtbrugrz98csmcIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NCBTYWx0ZWRfX3Z/Q0XXGClkx
 OM1aXn2Q1v1KGr6OtaSY9wltj4lWfNxhD+pzjbV9fQ0rrfIrg/+Esm29mPLx+qbwbqv0bKLx7Ol
 17b8mefVVc8k7D55aFZi6UGmyLKSQI1E6Id1+V7VEeBhpofYo3NgwXUfu1iFzBJQ4YGeWfqAcWn
 yiZYcr33o8OSxDjDozCaGa9KRbWhgpQ9jDqB7zcEdM+XY8MEcbMIcgRHFRWlUItnQ8rguWbQ94N
 zWBGn+NgeMqzs/zQA4wHFfiKYYCtUP1dvyqEil4xHOOI6BhLMpbVLyuTxB7aHSATJxzJjEVEgaE
 M23KoysaiGtayBOnR2Gf44Y4Y1qbw3g/0qp6Q9m2igb55qrDNwd7lN96XTYS+5rxkSZscANph/K
 c2sgHw2nhrjpbHwJI4udYmPfEyryTt1V6IIo9VufyALg5QbzJOooUPJ/mWch5dDQhEw/hc3GT8C
 M9Gq+JpAHoYAlG/sYLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NCBTYWx0ZWRfXwRnBOUeLJODz
 WMlheigmFVJM/yrw4vyPks+PR/7kg7ULHfI3zaCC90rr7iA1tLgLIgdYsItAWmaRjHJroW8/xXQ
 rYAEBSxQJl1Hy3CbObbUare+wX/D2ac=
X-Proofpoint-ORIG-GUID: 1DY7zOx-MMHGI6RJGtbrugrz98csmcIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220094
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 12:31, Balaji Selvanathan wrote:
[...]
> +		filename = "Test13";

Test13 is already the signed FIT capsule in capsule_gen_binman.dts, and
conftest copies build_dir/Test* over it, so the flattree FIT auth test
fails (the CI failure Ilias saw). Could this use an unused name?
