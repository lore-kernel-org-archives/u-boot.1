Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADA60A4AC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=osBGZS6V;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUBVc+jZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPHJPcsZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 508D24081C;
	Tue, 20 Oct 2026 16:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5AB8waezzAq; Tue, 20 Oct 2026 16:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A241D408B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514854;
	b=Q4dKU/aix+hTUb5ogX9xBCwnZPIGkwzSPPSvMgDX5o2QIQDNud4XrnxI0YB3nStCZeOd
	 azTOWoykduTLnmY+grgNSEgC/2sMMB+gULmwPn5rudZkmy/hnGEVtVebKhFYS6MfO50cq
	 ohrouITfsu2oSgsWRBX314xt9KxC+VgdEcDUvy3RnXBdcbKUqvyriXJP9+pCAKQ2lqte7
	 wuxzXA1JcTcj1myvtSOUF8/7GEzGHHjXk9bWPN1h4uFZuHk4MsjuoQzg0P6O/NMv+RH4Y
	 xuTb4rVsoU+S7X0P1xmsDKTWXbdSousl7xiYZZh4StAJeHX3TpbpY1mOuT1bW57+23g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=;
	b=N9syxp/9+BppeiP2UJbdA+YpfwHwPub/1rRxtBxVrwt+Qdw3/QhbZ1HEwrM1CbvfA3h/
	 EsLiRN0NtSS9dPIGght+Gqrtqdcw8KI6+CTHtu+39wcQ7fN6f5p3V3iDZca1UiQdHpiA2
	 m7nBtGLVGOoALS+4GQfJo/bjod4dPuGPEyvv6OOTLavy1YHK7kaOAdTRxWtOZveHF+G9Y
	 93UDG6MSM9QQ6ZaWlebqLb67XXwcq/GkhsDMbVIqZ5uPesBaBdZRdqQatoRP5desiYt3C
	 ArDOiEn+w83YDwf+2Va+MmlHzzP8ELcn7uL6vCvTF1nDEAZEUGk5u8JCzGsE+LlZYlg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUBVc+jZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPHJPcsZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514854;
	bh=3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=osBGZS6VFriea+RN4tWcV4/QurSQrLew8plcSqrpnSKtouXgiSzOnG3eEphioYg3P
	 tMFLsqkREsaLwKwu4AS6BYM+FqRPIL56FXqYefTHEWIWJTrUEEXnvRIJ2fqmRV24RX
	 e3aQrA3kmn72JMweAeMIUuXFgGOUcUYBANaWXaJEWTw+jyHSBoWt4SQU66wT1Uvaep
	 LfVAdKd56aGDhXB/dJkDgqxCl5g+23h30z2ezsFEsk0Aa9x7KNZMIj1xpFCEm6XzcB
	 Ckw9ZJR11HMvCe/GvmHz3aTAU7EqG1BT/XPR+4mJygBXRuLouYAUz0hGW/JAf1biMb
	 TomIi2xruFWqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A241D408B3;
	Tue, 20 Oct 2026 16:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D2A769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ED6C408B3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2uL8m0UA7DgO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C2F34080C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514851;
 b=h1uyBCuKwIWISHfcB7b6fnKxHSdapiyU5Sd+E9U4zqYTDyO7dbkNMYlQY3ID0+8vT5T0
 t5nGMCMmkoe57v7mDjefPufTkQ3wGQSg+BZL/CkRjX4oqyFQQoLYpYM/UvEYQT2tD/dIK
 Y+epWzdIaFxFWtrDyRfQyH/gpzavAMB1zTlJ8gFHIK7hCB0Ll3WWF26mjTxexeYSeqDWP
 Syl31vCAOJAfL7laz4xL/0wJWgm+tz+0P8knZlW+Xf36tGviEGBCaj8CEPMPy8VW2OZz/
 JnIjCSqD6OwQ1WMpm+8vlndzTZY+rfSjere9yeDuJRVwBUZ4TI2UP9Ez3LGeG0h8Xow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514851;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=;
 b=Rc/3JtsVWb1ZLYXgO3En4SSUX8oUQuFy7H8hAhWPl8SbCHynyXoqn+44BwZvIFAuY5G4
 aZpiNTGjru8Jdk/ISaol8is9Js5v70d4pgoUDdOcse/0eU38Z7q7iq5g2FCpJ7AEBV1A1
 k9s6oeOmhvX4L2+JzhjXih8101NiCp//fDCtncUAkyTbgh9Y8mYvm6utPjPIoJuY+jl5C
 kwuhxOpVwOwfnzhV/ALq07cLyovd6BHy2CEo4R8QdvNvTpzUYMPkTnYzlTOoy+IMEEnw3
 79iGnkDVwwXPHSMlJn04AWUE0KNJt8coJOkFrOVNLGaNc5L5qwOi2tJnSPckZWNKVTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dUBVc+jZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fPHJPcsZ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUBVc+jZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fPHJPcsZ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C2F34080C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAOC12214815
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=; b=dUBVc+jZIsZYWriG
 YyT/DOBBu62wIaO+AImDv0jwbZroClo2Km4Td6P/Jn+OkMOv6CLiIH2+BTFqRtU1
 +ZIP4gXI5UayAcjqMB+UR6qSVDG/6P73AaxNxjkqOE8cIDySYWp0F8SpWV5/DVZZ
 jJ9SroxUdrlFnX0/vElScmsHGGkwjFIDD0Bxp+XTjlKpd6kWvU8wifGMm3qRjabD
 mkEcX8dztSQP2bTZk/vQxazrsfAUCjvRUmbWqOf7DcTi49kNaWQ3I7QhP6JQ1NFD
 quWUTlwWWCErC36DbTuVhIWRGE6Kc/oTUM7dEEMxTlVtEepgiebA02tmMrBgVefj
 T5oLjg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nudpp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so8419811eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514848; x=1793119648;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=;
 b=fPHJPcsZDXUFFDgtbY/uCfU4wqhoJ2KLd0EWRpZJkz9FHBVmxUuBPUy0zcIvtlwBTy
 PWU4qiPhj0pNBxELcZnikcAb67T4xHahHJPbVuO+Rx/88sop1cApAki6Pl/sERoQX59z
 5kwMbzm71Ms4W7Zat5WU4M2zRlCJsQawI0Cs7bwo4/y/DuekiBiPPx00ijtDxpk6Hepf
 s0zVQcKSFpTWuQGZBIIeDPGuHBc3OXx+x3YMsviD+3WNd0rXWIz3kJ1ApFbHXa1RJAbq
 t4L/Qtjihw32Uudwhh/Yp1kO/EERk10f25sE8h/lFrh21ACLJLV7yUgqyHrNPHgjqouM
 8Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514848; x=1793119648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ar1vavuZZhsIvy45k2gSq9gX1HXW4onGVwiY1xGxgo=;
 b=2QrGbMR+R4FNeoVWjXveORkLdR32wNWvTFnvOoQ2gTGKx44qjL21NtOB51Huk7BmC6
 aAS5XHJS+W34hy5YtZmtDFTIW4MJSNaXax+Y1x1TayWQOBBqAIRmGXWh6kC89oGXZFxa
 Y3Lu8KyYMy+Zn6KEIdRyO1Hh0IC6WM5w+39zPhy3QZdSz6btdhPmWOA+0vJmWcQ24htw
 to0VAvsvChWfCMY86QomA5kagMzxOoZnxTumxMnk5BxZmOU0Fd4KAMAVfxqbbIUhEbMP
 u3DLdS9J3T3wRQUTDBLGXVg1daiF/LR+U4POR7FFOdnkHtjAtPvDSN2ijgXnAVfQmFY6
 DWBg==
X-Gm-Message-State: AFq9FYIMugxmpEmUVj1oZwFECLh6mqXg1XoYLo787Cuq2mHEC1AXpkAv
 1vvttl+hQKTy4issRCuZDy3DT1hD2qBAXDluey0KW0zH4xqdb5ELeW0BpnXmV9uWtEhmhnZT3Jl
 lRZ8HYvNetYUX6URlDkAc6XXUfdJGVF8iXd5X1h+3TeEDKvqDYfyFhaARNHIxjOGGamd4A7Y=
X-Gm-Gg: AYBFou3yywnCLffR16ueFwC+BgdRnUCkaggtlbmIlnrmx/xbSuRs8kJGv4O90O07kTl
 01vLuIbLTtCTfgnJdaUmyPkk5zFTc8ft2Z6LS+EB2A4pBNFUPkIp3MnBaiTb474mdc5HzdQVx3h
 P0/05MIIRZkMG+7PiWtiQf4fp34vHoIARAAAhWJ+tyjzOpkZx4aYNwH2D0pD8UALSjZWIfVU0nu
 SzcRAFQw0ADIjuXv0Lz9SOMuEwumfyb/Yue1TpdMsXVgKq+qwZMQ3V3KONjXDrQei/zS/8u0auq
 XtLAnaBpE56w7Q8h2Ac+8sXTwhrOpnHCXycMrtwI+X9J8dIJCAmK6sdjTT8sfLYfSJWzHsMnzKO
 BeiQ94iquFKCEtXPGgeupFlt5sAThrXOvZSM52JWUT/q89FarrICJrIho1ge90fJkErivyFRBCj
 /h3ec2d+aMJSk8pdqjfmdcA/QufuQ=
X-Received: by 2002:a05:7301:f89:b0:35d:a0cd:e4e9 with SMTP id
 5a478bee46e88-361a18639dcmr14800896eec.17.1792514848399; 
 Tue, 20 Oct 2026 09:47:28 -0700 (PDT)
X-Received: by 2002:a05:7301:f89:b0:35d:a0cd:e4e9 with SMTP id
 5a478bee46e88-361a18639dcmr14800808eec.17.1792514847155; 
 Tue, 20 Oct 2026 09:47:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:25 +0530
Subject: [PATCH v2 6/8] configs: qcom: enable PSCI reboot-mode framework
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-6-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=909;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=3svIPja+eJ+KjZBa3S7P2xue3buMD+etLFf+EpfR6X8=;
 b=k4TeZ8/OTWvy5/oLJ5vfeYkaSzamTHHV6o+JvpS8Szgm+qD6L+PUu8AAlu7AgBNkYXUcTfMpU
 50H6sr9AliWBsiXm1WcVwnobbHVsBOn1n1W0bM0Q+XPRogCqLT+rXua
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX0yEk7pD4ILOt
 hA9C+jF7tV7heHmEtN3EY4eyJwae1R/F9tns9oRDEUE7G1CeaSETUkF9v8mvXChgYLAobXPjseO
 PJXX60raU0Am9eZpO9tcU/l/440Uqq4=
X-Proofpoint-GUID: W1llee3u_YUf7c-oYuaHUpIq9Vz5z3kB
X-Proofpoint-ORIG-GUID: W1llee3u_YUf7c-oYuaHUpIq9Vz5z3kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX65T9sAGLSLOL
 AzWRiSr1UfLmDzrp76YjUhQVPIeEtJM9ejEVN9eXOuEXekHu/vY/ODKUwtRiTRWpxxLCdfvb8eB
 XcgTZekbNTbr2mTI0oZ9eDkRybQm51ypwZ1r3SeNEhSO3+QUVn2leAvSEQSZEPsodDPQ7TXb0ld
 v/AHp9cUatwcgaBOg6ZkMCPA7XBDrDoRk0NWiqK5V+wm/meV2VTJEFxa4apKvF3Kn8QZISv9mgG
 +CarJVcgsfLos30uFX2cEwkR76dyznqqZdb5sFdCOpTIgVtDKhROELIAIty2exUoggzmxt50nvj
 b9lGQ8lV73rL1aYvdk7YqRoa1CJ4cUthZBYAOs5bjsHuN6DRlHU0Fx3m0L0IR+RIy3EbrgkQU9r
 qeHs6JGzlJyPvkXj3cxHauUOCeA+1FTUPjdfq3/ucE6AO8ogQBumG1MDnJeVeD5QLPp3wL/J9y7
 s3V/B/NfYlqnMNaDgkw==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad79b21 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=uqFMpbG4MC8BjM4yXrYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
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

Enable CONFIG_DM_REBOOT_MODE and CONFIG_REBOOT_MODE_PSCI in the shared
qcom_defconfig so the "reset -m <mode>" command can trigger the reset modes
declared under the psci "reboot-mode" device tree subnode (for example
"reset -m edl").

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Refer to the new "reset -m <mode>" syntax
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a1d21fbad60..20a88ed350c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -126,6 +126,8 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_REBOOT_MODE=y
+CONFIG_REBOOT_MODE_PSCI=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_MSM=y
 CONFIG_SCSI=y

-- 
2.34.1

