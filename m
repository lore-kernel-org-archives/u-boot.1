Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90029606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rJVF35LN;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OHqWGfVV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VHx69Xyo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13B13810CD;
	Tue, 20 Oct 2026 07:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXsl4csCXQaS; Tue, 20 Oct 2026 07:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B554810B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479725;
	b=bKjyj9TfJFn531LQQqAGyG5C9dzKRQvo78aiavmGnD+s71TL+HTSoEpfPFbp91WkdYSC
	 oHGAdtanonnj8f+ETjXC4t8cdXLUiRPjmf8CPiHXKSSfPlREb+2rfUe8Lmfs5D46OU2Lw
	 SZtCJER5BPVNpNOfi/M/SIAmUJX+PwTmsdSStI788CEzhV30zng+XbkujbbkFO9jvzi1p
	 /D5FTubcAum60Vqws2krhAgewMU5vJHpOTTDSsIK9ys3lHO5BYHCY+s47PBfHxePpOUtl
	 Arvsr45N6YfIfvO0VgeQMdoO4hqzMmYwz/GRnoL5hPu0Re8W63VVwfNdTf9v5ddMarg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=;
	b=itprDzoLDMwnqSJyKQXf0uRFsj4hhcflJU28vsrOMbM2857FzWjyWDMxrTFbKVd/BVbD
	 rOOx+tO5nGZKXhDN4SnC+1CLObPTxcQH6JN49+lWyRpDlQegRQtEFnSCCx0wf05DJ30J3
	 d6wTG++7MewU9m3pO0BOEAswBljGxkM7GTRN9DkCi09VUdJmiGsGM0tsjf6LwrbtgvnWZ
	 HG4RlAS2oIW3VFDkyJ85VSeZuSTASZiyFpBptOVCATFvQ9wgf3qXsvQwTbXP7fLj8HR43
	 CLCJnXdud25qMT4th9l63NYjg/f4/aXMlSg0Mefcss4QkscTFvb6GDCPhosMDGso5oA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792479725;
	bh=5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJVF35LNlcICUbNrzgY24Y/5WGmIliAbojHo/1ZVlDcAwL526Bn26cY+O5YsDO28P
	 p7s3xuihUgPiKYUXNJ49ES8nZxAXqclPsgeBms75lwK2Y8royWV99Oskjt+MIjozBa
	 nr8vP6bxWUZivfie4iGKyhhUzWD8XUS3K9ZlFvl+Dy/TyvrVGiPVnEGqkQwGQ4WgBb
	 HlB9CdXj05qkv/9MQnu170Da2oobwtBSNpKu9PVspMbnUOnvtgD4YPkzj8QmrsRmnx
	 BGxgiaD6mxlQbcMegfOjjOZ2nilWzop4uz4yPi0pallEnN4TEigfNLSBDPjy0r/P6a
	 MV4ltX8f/QU2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B554810B9;
	Tue, 20 Oct 2026 07:02:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0049C23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5A75607EA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmCXWs-LX1YO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11A4B606F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479723;
 b=hqClwFr7Ra1cM+0xxkIdf2VSw1w+7Kxtszl/rWAJ5AhTnSVDYYhlW0BxXtfa1LMgy1kT
 e0/ziJ7J43KZg3VwdPa1ZRbMo3LXr08N+AaxVXf9RgGO+42p+8AdK5izCWEQ3PonGHs5P
 jjG3hWF41wrT5DUZNDWXN6ePQ/XmUICssfpao9DRWa7YOc0pSeJnEqm13Dg+GtChhpotO
 dzhXf/CKvqzUCOU5dsspPDqhG8z58itG5nSyGHzYHGvVyjaLNaO/Y67VVF8WHWqFav0ly
 qBUbo4eQoxdCIzjuXoajeD6OjpEuuoGDuaYakEPrHR/IVPzFV7FJc54YnTD57vp9ddA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479723;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=;
 b=MOqcJqBJ0HVL7z0/e+/7SMEDGL3qi6rNioP3Wp4hBNMw5q0oRhYa21KkHv7tlCuyOJUN
 Kgw7Zilq+WZZ7CDeUTK0SAtx5iXFalNAmNoRXvGbuVumstDi4eB9/WZi0gV4RFoQya+ta
 msYkO0Hp/aWY9+bxRJxXsVXXlZBDLpwvL//RTqS4g7Ctc0K4ifaSOhkXmPRphzKTmiulR
 JpvNuG25biAWGBdyB2rwU2QEvybATqZUCXZyQdHSXZYbxtqpx8ergo7jlW7boSdLlGhDo
 YaLC8SosRQzh26nAE6wXiffBpPZjlUfknFDa1W8yigIIcRKdjdvuT79rLXQ5uL/3CLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OHqWGfVV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VHx69Xyo; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OHqWGfVV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VHx69Xyo
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11A4B606F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:02 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tGQA3486170
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=; b=OHqWGfVVOjklRHq9
 WJvI2VrHx1d9AdMmspb+B/KhV6NXQjZ5IwqdrmjUBRo3/Ehttq1F6LIABg8FzGuJ
 TFPOSQo0a8OQYngFo2IgENx6dxqwyoLJZK3HD+C93u4UOfV2aGSP93gFJYqq/ol6
 GkRvg26kAUL8SAvSTHfL2rh/TjF/J4o7iIEJ8TbVzAd6psz3/aekylIEqWVpa0np
 L7jY3eUufF+5toXPoCGDkams+sMhtbH4SNmGXghfVPV4HgfeLP2pjr5iHxL3wryP
 kNnFzPLIZFUyAS3qVklix7i/R/L3dsWx/ZkqJC428qBzdKdwWxc6NjPth7/3POLd
 NIt9sg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n199v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso7438179eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792479721; x=1793084521;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=;
 b=VHx69XyoitPJtklyx8/pg3m/hI3f1eKaKmi1WSoZ6d3zs/Jrthgc5uVuw0JAEN62bF
 8qsoryP9dCX7LHMDAIX9hvdOpaS4Wlqw+vj7jOhjoe7hEwR2B6qidGMLD4bAhRuNxx+X
 Qj6HvzZyepuDsvg54E+QqMY6fGRFrTkPwACsGiU+0VZpedcoU2w753ylkwMc73YXEUDT
 CcLmRRFLN8VD80mKicoj7asm1qOgWyxut4xAEI/VEqLbvGcuF8aJBhqr6oxsuy38caXg
 bOfMm4ISulOK4uOqigceb36bCi1HUSEoE2C3w1Se4gnDJN325dBjEqrTBD4XMXhxH6a3
 q1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479721; x=1793084521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5YHGF+Z7yg27ZpJ5otJc7kH2Txh1NJ/eA9LT5MxtUk0=;
 b=A1PaUtaxnxliGNeTSVA2gmYd5ZVbwEEc1oPXN5y09nCPJRLzY2NRrmO53ftvkYMNm3
 rwuQ0wlUb/+32HJjQDDvIdDehdphH3pwP1EOoOcfKli8ep8u4U0OWYtQuRrTsYVxISJx
 t71aRDV1xJ92uVXCL/YFd8pOvFNKFUcZqy6UbULpeyklWO1ottAuNOcj5Epuq243UDk8
 yh1smLJfrXmR9yfgqgmfyPT859AC/b84HYGWHlmFi6AzyyZ4918gvCQHuzR/Xx2rI/+e
 9qi4LavSJjY4fn8gxs0oDDPo5OjReNPm+xN8SRI/H8Ens6derELDYuYowsabTDL8Pm6j
 FbHg==
X-Gm-Message-State: AFq9FYIVJRJnuFxLIXi2y9I7aLMAfN3yGTB/JgPFfR9DkiRE5nctSFnN
 DmrZ/M3ijGLWOLeOJHeXJGJ5qy3zVm3atBl0BQESFZlPnhndxPepSuDEFTnz2Q1GgL2Tn43+aVa
 LI63SU8UDf0Ux5mPEZ/bv9THOd0yG8/ZDAJN0hKlMvfrFXQNoFRflkRFmhnXHi0HR5kKqrN4=
X-Gm-Gg: AYBFou0ZiDAjf4kU0XDXtF+wpnlpyrrv5OhKf0oxO+8QyXHc3YNXke1Mpt/AMoYrz7Y
 BBr8tEP7tM+h+naHJrbupGV1Ldef1VvxxAbxVXTBBBMdrUDfZ+ejdDZxc0rF+BGdMe56jpmCqMk
 E3rLGHB8ad4mE0fEq7MOwli61/MjIav5TF2Csy9GeG1xv0gekXvAkUWaTJMIy24ChCWuDD+dccv
 edHUNAs9LzNkh/XBqX5owq7Bz5F9yG7XX4ci+aOeo1P8/08fa2v4BDxM5jUMN+rVTVWXuS0PCv1
 711+aWegHZS/f/PBpzKAMlEpNfkER87UoVkvVkRakIOHLL49xUlYOwAtB9WB147eludJo6zDHM0
 VHVz1pwTZ2UJ4wA3Bh2KXcXDFpk5JHQ/TtiqLFFgrgdHkD7n6rIt1y4wnFNBgCzWR+AM2B85Vin
 jyjz+Vvx5EubDCBtMkEgwNGA0TKYw=
X-Received: by 2002:a05:701b:260d:b0:188:ea93:6d2d with SMTP id
 a92af1059eb24-188ea937323mr7750764c88.38.1792479720992; 
 Tue, 20 Oct 2026 00:02:00 -0700 (PDT)
X-Received: by 2002:a05:701b:260d:b0:188:ea93:6d2d with SMTP id
 a92af1059eb24-188ea937323mr7750729c88.38.1792479720367; 
 Tue, 20 Oct 2026 00:02:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm38294225c88.4.2026.10.20.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:02:00 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:31:48 +0530
Subject: [PATCH v2 1/2] efi_loader: capsule: allow platforms to map a
 capsule to an image index
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-qcom-capsule-dynamic-fw-images-v2-1-3824f7a66e1e@oss.qualcomm.com>
References: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
In-Reply-To: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792479710; l=7492;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=9MgrH0i3F34lAZjiK+SRpNdL1pY/8wrD+P/iC3g9qdA=;
 b=RXgIOPRPUAbyjvrwPRwQOg/igwYDXqKUTbeMzLVgK+uygRS7g5WXVjd1+3mXHAbCf7bKZJswe
 1Gl/zVYjX7VBqGsB51EWH2u4kvz6URNsJyiq8WjZhnVTXodSNe9hhbY
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad711e9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vfRFTl3raSCaEq12aQMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfX71ZxMoU5C8KK
 i9Xjl7vEfdyp+z7XciHM5i6OCWrBuvIj8kLOTC8it5Baz1Hzm97E1hF/fKH+ZOvwwfuwkfS5dPs
 bKu4PjqwHlW5hRchEk2Ru1wm5jgQeOY=
X-Proofpoint-GUID: QLpASDZ58Gat_8jm1eh4p2Z7_t_YhXaY
X-Proofpoint-ORIG-GUID: QLpASDZ58Gat_8jm1eh4p2Z7_t_YhXaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfX4Vdh4jrr7tm3
 AZjdGiXz/XG9IuqCta49Ncb5s6gKoR9btCOIdYPKAYeKYehsG8VqxJllgmVcLdnhIauG0EYvtnL
 WvxoY+hIqsgAzWZARwzPmgUMY7Eql8Ch7nimH3N51O2UcoZVPTcbYomjbd+DYWcooth3+A4uLaR
 PHjMxpuSaR2sACT3X3U5o7L2HdixM0PTAlVxokuNK78FAgJrpF6qJNOV/rvUbkb6Thh9AxWndds
 JfpN+JtXrlNFIhA+6X5OhyxpAhSphzpc2cRT8Dh8JjCVdRwTxyfhdIDRczYT/zwkMU06bXEDGCg
 tt/+8h4uhTuTMQMeqYWfKaz9KrAnAuT8B+CYLKNfI43rTutF0Z9ulpKTZuYyoaOA3NZ+crk9X6D
 T7unPJYi1C3M/G/OfMLx5b1Or8ugQ2SGYReab6jJJ4TZujCXW6lGw6poILWneLg3QjWWHgQdtHO
 X80dE14oSlQFDYcnAYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200027
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

efi_capsule_update_firmware() passes the UpdateImageIndex from the
capsule to efi_fmp_find() and set_image(). This only works if the
platform's image_index values are fixed when the capsule is built.

Add a weak efi_capsule_resolve_image_index() that returns the index to
use, defaulting to the one in the capsule. A platform that discovers
its images at run time can override it to find the image by type GUID.
The lookup happens before efi_fmp_find().

Add a sandbox override and a signed capsule test whose image index
doesn't match any fw_images entry.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added newly in v2
---
 arch/sandbox/dts/sandbox_capsule.dtsi              | 15 ++++++++++++
 board/sandbox/sandbox.c                            | 13 +++++++++++
 doc/develop/uefi/uefi.rst                          |  5 ++++
 include/efi_loader.h                               | 14 +++++++++++
 lib/efi_loader/efi_capsule.c                       | 14 +++++++++--
 .../test_capsule_firmware_signed_raw.py            | 27 ++++++++++++++++++++++
 6 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
index 34d29916b30..cb85bd99b68 100644
--- a/arch/sandbox/dts/sandbox_capsule.dtsi
+++ b/arch/sandbox/dts/sandbox_capsule.dtsi
@@ -104,6 +104,21 @@
 		};
 	};
 
+	capsule7a {
+		filename = "Test13";
+		efi-capsule {
+			image-index = <0x7>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
 	capsule8 {
 		filename = "Test12";
 		efi-capsule {
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 13006a0ffc2..8844f59e4c5 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -57,6 +57,19 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index)
+{
+	int i;
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&update_info.images[i].image_type_id, image_type))
+			return update_info.images[i].image_index;
+	}
+
+	return capsule_index;
+}
+
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
 #if !CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..0e1641122dd 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -503,6 +503,11 @@ on the FWU Multi Bank Update feature, please refer to
 When using the FMP for FIT images, the image index value needs to be
 set to 1.
 
+A platform that builds fw_images at run time can override
+efi_capsule_resolve_image_index() to map the capsule's image type GUID to
+the image_index of the matching fw_images entry. By default the
+UpdateImageIndex from the capsule is used as is.
+
 Finally, the capsule update can be initiated by rebooting the board.
 
 An example of setting the values in the struct efi_fw_image and
diff --git a/include/efi_loader.h b/include/efi_loader.h
index ef25124fd84..10030af8954 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1235,6 +1235,20 @@ efi_status_t efi_ecpt_register(void);
 efi_status_t efi_esrt_populate(void);
 efi_status_t efi_load_capsule_drivers(void);
 
+/**
+ * efi_capsule_resolve_image_index() - get the FMP image index for a capsule
+ * @image_type:		image type GUID from the capsule
+ * @capsule_index:	image index from the capsule
+ *
+ * The default returns @capsule_index. A platform whose image indices are
+ * not fixed at build time can override this to look the image up by
+ * @image_type.
+ *
+ * Return:		image index to pass to efi_fmp_find() and set_image()
+ */
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index);
+
 efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *sz);
 
 efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type search_type,
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index a77810fa15c..f5f4cab3613 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -517,6 +517,12 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 	return ret;
 }
 
+u8 __weak efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+					  u8 capsule_index)
+{
+	return capsule_index;
+}
+
 /**
  * efi_capsule_update_firmware - update firmware from capsule
  * @capsule_data:	Capsule
@@ -543,6 +549,7 @@ static efi_status_t efi_capsule_update_firmware(
 	int status;
 	uint update_index;
 	bool fw_accept_os;
+	u8 image_index;
 
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		if (fwu_empty_capsule(capsule_data)) {
@@ -615,9 +622,12 @@ static efi_status_t efi_capsule_update_firmware(
 			goto out;
 		}
 
+		image_index = efi_capsule_resolve_image_index(&image->update_image_type_id,
+							      image->update_image_index);
+
 		/* find a device for update firmware */
 		fmp = efi_fmp_find(&image->update_image_type_id,
-				   image->update_image_index,
+				   image_index,
 				   image->update_hardware_instance,
 				   handles, no_handles);
 		if (!fmp) {
@@ -650,7 +660,7 @@ static efi_status_t efi_capsule_update_firmware(
 		}
 
 		abort_reason = NULL;
-		ret = EFI_CALL(fmp->set_image(fmp, image->update_image_index,
+		ret = EFI_CALL(fmp->set_image(fmp, image_index,
 					      image_binary,
 					      image_binary_size,
 					      vendor_code, NULL,
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index a500c499bb9..005fcd7ef0e 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -190,3 +190,30 @@ class TestEfiCapsuleFirmwareSignedRaw():
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_auth6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """Test Case 6 - Update U-Boot on SPI Flash, raw image format
+        0x100000-0x150000: U-Boot binary (but dummy)
+
+        The capsule image index does not match any fw_images entry.
+        The image is found by its GUID and the firmware is updated.
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test13']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:New')

-- 
2.34.1

