Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D7606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LxcsyTot;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U06WfFHm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R/defK7/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C2B360851;
	Tue, 20 Oct 2026 07:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xvr6Mzxvbaa9; Tue, 20 Oct 2026 07:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10D5C60818
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792481604;
	b=LOnaeWVJDY/vFCPov8fagSi4qxbJRyK5kV6ZbE4Q6Ny7ZqGnrustnVpU8oWx9rAPJ60g
	 zke+EHMCGciMvYpoihxsMnRTo7NBlkNuSwMBQeUliy6Bp/mV6shIl57rH7f63PLPie+HG
	 5oAk6EX8jygwKF8Zcnwp8efyGQqGvQBpxemiHEGIElRO2kUF3A/dh+iAiuik6ozR4M9nC
	 j0/ZHRwYp12GyZhg/ZHsKTfHrwJ+5a/QfjoSxxrwE0zZKU9cSuw6qBGkRx+Qx7lneP+g4
	 +knccWMsiNgfkuSCfKeAMyPKYTRV8bbAzB+el/5Kwjch28+MhUrfNkvZYDTkSMwi25A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792481604;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qvpyFvLwIsIjLC2ejDIzlO26V2x9w0EiJhSKwDgOIBw=;
	b=dEEGPGzWGuv2JRZux5xNG+pXBMNcfWp5GcqblGJPpLQ1D7ufK3gnbEDg8kMXGTBfIW/o
	 XW9LNYzLrhiYhR26xrzW5xQlsLx7grMM2ruYgYiLQ2RumX3KLDPQmwaDV3JRSMTGLZ736
	 NaAK44+webVOfLNBZA8x590xfrOMhI6iKy7k0v/ARVIDdNKN8/L0jaUOk9X/m//XDTMCS
	 Sn60z+2Z7XWdo6Y0SR3exN22lPxQisVen4QhXIxjc8bdNeL+Z608Mj+zrr7EcD62w6nTV
	 vwBbUKnJ6JJquYyUK8GiWZuRbQdeufbNzKOD0Gxmz12/25h4odBXDjFqFhnzz7P/SSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792481604;
	bh=qvpyFvLwIsIjLC2ejDIzlO26V2x9w0EiJhSKwDgOIBw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LxcsyTotSoFkHSHff32hvZdzPI7Ascz0DsK4VLjvfZA26Lnew+C9fnXYs+VBVemTu
	 lULHJL8bJELLZlgI7a9Vtp5NqV21L2o3fTjuhggkUWnvOkH2ol3WO3Kf7RTpVG29E1
	 tBi6EADORs8wsLqyUlEr7XIOR++Q3fIOlmSKjTczMg/KIYDb2ZmRJsvnOh3m25GKkN
	 Iu4dDhim7s80lnbMwbJzbQJNxLrscrz34quReldT7G+dYllcpyuklirt/Lifv1CYdA
	 MQ6RVP0TOrHZifrm8mt16Y7xx4367+yxw5snoEYkWSAoJdvLxHqTGeTwnaX+BUV1t5
	 JwGofvMP5K8+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10D5C60818;
	Tue, 20 Oct 2026 07:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48768465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E849407F7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2BFv4A1QvhX for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5FC66407C0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792481601;
 b=ML7eSSp09jkfO3r4xhUkqRGkCk39kQUxMwEZH8XZHJPjoplwNka5ivXXEVbQ8D4J542k
 DXdxBPC9y9afPALlizLMUOU1djlSkm2PmfYUl9nfoyfR8a8/paL6tageFUXipHFVDqKyI
 En15JSZ1mW/5o0o+swdCyKLToS8s6jiz9PQUdf/+CLPlZN7vMAeizMVBwXTVVP6crirqB
 IavjrMhJOn8jAbiOUvwu4WEMZ+h2hIMakbjVcp+t7UgsPDN/GCrGLUxUKWOm6/aIgnY3U
 8IO78dMzlkLxlNu+0HVJFkR1hblEWohRDrrw+pFuk2wcx9mYtNmAOIEdSD6AfPdR0eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792481601;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qvpyFvLwIsIjLC2ejDIzlO26V2x9w0EiJhSKwDgOIBw=;
 b=mxNfGZs+h2Ixr5u9fS7CFDXXIKCf0NRR7307zLminob0wolVoTllZrKhCcCefbLternx
 z/ePSebe29eaRkkuEm19jCFXEURTKUj4MYXICUHyqeFuOGlqXGgCiD7wUbkPeY7WU4J3z
 tWKfUF44qqiMNiN6Kuyp+D6iDYkbbCLqueG37moHp7XoboCkhMGh3aOGssSmbbu3qxEYM
 iInun/sU/OObg/mHkgqurgtr3SgGlm1Eq9M9qmy+yIg44JZmLkQ0XaFKYi89IX1QhS+uY
 WbinIiZXSkYuuFgGuTTxCBbsOdmC+vx/wEmKy3DTIGvbMmJMMG3eE85q2g6LvCS4oLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=U06WfFHm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="R/defK7/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=U06WfFHm; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R/defK7/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FC66407C0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:33:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tGCo3807111
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qvpyFvLwIsIjLC2ejDIzlO
 26V2x9w0EiJhSKwDgOIBw=; b=U06WfFHmbPoUrEUjEkFVGdTBVi0azgPF/BiSh9
 TSNbDGiOnzb4dAuPe5apDL2k9FtZjywEOHxI4y5yYRqusY+DVxGBXL8nJQwOpa/u
 i6fvlrx3gcMqLmdZ6MRVEDMItf5XLg9wyrX0Iml8Ae3RW6gQJrHhUeOyilQVh6Lx
 bM74Ps5s/l/WCcnJf/qAEzaD5OAipUP97A7swJy/Qr+sR7RMFI7UzOYbSBxxppxp
 fzQ2LXY+vPeHLmk9HU7lyKGxp0Z7F4Zemo3ZkT3yLXsY6Mv0UPCGW+hXRLIZsV/8
 x0hubiYUuIAmTK30lTUBmUH4tLSPr0k6Ye728FKbY7vTZ2tQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p9ddm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:33:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6080302eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792481599; x=1793086399;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qvpyFvLwIsIjLC2ejDIzlO26V2x9w0EiJhSKwDgOIBw=;
 b=R/defK7/SCZIjJ/Iw4rNcmUe4/TdRM9Z5Oz8P8zzFcSOp4oSeGQkSbDwZiyu7ylMXI
 i/EI6nlFzB3DH04Tzy8a/CTTDMoLP1HsO1X1HPkTkkoIyy7gEfJT7ZcgWkNHD2qaZydT
 qNrHuqDlPBBeNLy7hSKs2Szy3PrdS0wi0vMfgYEsX8O5m1OanfMZcaMUe31HpwtDEUgh
 Q7eGk7qYWx0GX3VFF0GIiM9FEJFZD9ZyKxX1biB8+ucqhUmhrOTRFGBw67Cq1QccIguJ
 r8LwBQhVrG2qd6o/ROD8thDRTXeaPJ0GcOdaAltgaAMeJMkzE7otfAncSUXoin8VpbK2
 V/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481599; x=1793086399;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qvpyFvLwIsIjLC2ejDIzlO26V2x9w0EiJhSKwDgOIBw=;
 b=gLcyAp2MYAUagtaRsBCNZrzw1ZMf8wRdc3urjltaoZh9iM6BSf9ygf4wDIdktYmfzJ
 rq0mFtbZtDD8mbLg2Z1BL10ZDgm1qBARuOfkFSEhsh287HcFyGe2yRQEOIqqxKrQMpU2
 EzqlOFzI31q0Ja2RxrinAApD4nzxDjOmKoiOzLwpg0Yp0PMqxeB+7pzKl0xcfFABLs47
 IktJj4k88xqgGiufacpDr/7rcbVmkWXD3QPGnm2n+wR975KyTOBViZWkCsOL8Ndp0ZAD
 f/6lIeXCw0ii3Z0NxmlkFVN16KtB3p6qw/w1QQ28aWWRvKXpoe568KcK6KbUi8XMXW4h
 M0KQ==
X-Gm-Message-State: AFq9FYK0+5QWLmi9VkIhpKGb4uzNoDJbkxhAZ4SKn0u63NyKFcau1AR/
 f1HgNfBfVN2+x14kGHZTbEvCk7kU7HAB47jnm/Ic6exLvcTWIsTzyiagDPkBcVsNO/flE/VpYN9
 u/NmnuJu3cVz4TTpD64RXY8xScPome2vNoMr99thChwSfD4UkP/odptE2uINhjaGBKfYlm8c=
X-Gm-Gg: AYBFou0jI9ExAQMdEzs4E5WFtSZ/IZXuU1whygEA0b/Ps9UCe774aX/2bwiLUhzu9+T
 meRKylvaA83Mo6HoKwREvIxmKoilLq5URYMkBUhYB2kA/kNWzM9FzLkd/diRl5U7agdMeM5hIcf
 n38ST5y9ha6kzq1aNNe0mGty3AvY/j6QF8WykqqVGvbfKaFYaVeLKUkX29sL3OWMd5nMFnYNFnP
 TFKxVJT1fA0iJ68TTnwaOldd8GGujselEDot1fSc8AiOoAd9omAYznUtdESf2Ea7XdPoj+rMtrx
 TAMsSdR7Xd4Srb8uJTmuVgrS+IR1waSbFLZ6D+BNR/LWCDLm6Ee+xJ7TVD83mrhEM4javc4J+1S
 fpEWAGkLV2jxSm6Yd2rILX5epLn7TjbLkAdCblLaO0FOFCskGg7D6SNse5IDUrxG/rBPjyupDtE
 pLOMzeEN8sxUThH5lTh6j5i2VxrD6p
X-Received: by 2002:a05:693c:810b:b0:351:dbc:b663 with SMTP id
 5a478bee46e88-361a204daedmr14262372eec.31.1792481599244; 
 Tue, 20 Oct 2026 00:33:19 -0700 (PDT)
X-Received: by 2002:a05:693c:810b:b0:351:dbc:b663 with SMTP id
 5a478bee46e88-361a204daedmr14262342eec.31.1792481598621; 
 Tue, 20 Oct 2026 00:33:18 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm63566339eec.28.2026.10.20.00.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:33:18 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 13:03:14 +0530
Subject: [PATCH] reboot-mode: update env from every reboot-mode device on boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-reboot-mode-env-update-all-devices-v1-1-62f428488321@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADkZ12oC/x2NzQqDMBAGX0X23IUkWgt9ldJDfj7rgk0kURHEd
 zd4nMPMHFSQBYXezUEZmxRJsYJ+NORHG39gCZXJKNNrZRRnuJQW/qcARtx4nYNdwHaaOFTfo7B
 xTnfPF1rbeqqhOWOQ/Z58vud5AS6C+pV0AAAA
X-Change-ID: 20261020-reboot-mode-env-update-all-devices-2bb1457e3a3c
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792481596; l=2932;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8MNg6EnbCxs+knI6LHMxj8nrKwn45cabY6HwlbLV1sY=;
 b=eJte0tT+h0NtUMTtSF3OzjY4UQYMQW6HDE6zHmue8LdCf+z/uL+XANVAjVNqpuKyPQT4UDtYn
 EQqpbIDb9RYClBbP8/bBNd0NW8JeFYgmBhU62mHF8y0JQFeZENMjxMr
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Tf-O_rMA_8FT_DKMa_SOMZdP085tBcTz
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad71940 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FxWIY0KCr9FLoerE040A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX0DAo3rJ7/k2f
 0F7gq8AgrCFVcXpjolFD7KGQuRK+gdd2QQjpKmGCpul9ZBPIBnz1lDU+RFKeCtAx9CCk/Dv7Tsa
 +yWeJY8mpZY5f44ogrfz4Hb+iut0FPaGOj/ZAbrp54RTompdEeUjFqaweMwSW3B0trVlDndoKcX
 fGD5q/AFZgVwanRnYpHuy12AMpUciVX2O3Rq/QAe4PPJlO4bIVjQrCmj1xUQyF/QX3HKnLwj3YP
 oiBNB+I/UAO1PrSk5nFawuT0lknvLgRa3eIt/efuIMzV1ny7NaAe+988Zk94yPyfwJpBUNLs7cZ
 8dUoykHwBZ4nHxm/oTVxTlzgfDnZxUEtOH4PItt0geNhiKw9fISIAWiOT+oQKACkhFH57KE8bKu
 /mMHh2Hmjj7s+s3kFNcps9TrW2KfADnHYedTkxg2suQrN41upOuWfhNKbODar7pRF6cZmFc+AtU
 E7kalU2Bb369whwQ6QQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX/G1LiPaDCjBr
 iZqX2WPnWX6qUy1Th0S+X+nNL637R0arjEN4oQT0OBuo0kCTQ6jfno4C58Gl/iRG0LYw6xR4QC1
 Dtq20JTirNt92y+foG4AwUB3R9aMmqU=
X-Proofpoint-ORIG-GUID: Tf-O_rMA_8FT_DKMa_SOMZdP085tBcTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200029
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

REBOOT_MODE_ENV_UPDATE only updates the reboot-mode env variable from
the first reboot-mode device found at last stage init. A board can
register more than one reboot-mode device, and if the first one has no
get() op, dm_reboot_mode_update() returns -ENOSYS and the others are
never read.

Iterate over every UCLASS_REBOOT_MODE device instead. Devices without a
get() op are skipped, so the result no longer depends on probe order.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on this series: https://lore.kernel.org/u-boot/20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com/
---
 drivers/reboot-mode/Kconfig              |  6 ++++--
 drivers/reboot-mode/reboot-mode-uclass.c | 15 +++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 35f12e1bdfc..710baf85200 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -44,7 +44,9 @@ config REBOOT_MODE_ENV_UPDATE
 	depends on DM_REBOOT_MODE
 	help
 	  When enabled, the reboot-mode uclass will automatically call
-	  dm_reboot_mode_update() on the first reboot-mode device at last
-	  stage init.
+	  dm_reboot_mode_update() on every reboot-mode device at last stage
+	  init. Devices without a get() op have no backing store to read and
+	  are skipped, so only devices with a get() op update the env
+	  variable.
 
 endmenu
diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 976544d2810..dc8dc754c25 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -122,8 +122,9 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
  * stage init.
  *
  * Called via EVT_LAST_STAGE_INIT, which fires after the environment is fully
- * initialized.
- *
+ * initialized. Every reboot-mode device is offered the chance to update the
+ * env variable from its backing store. Devices without a get() op return
+ * -ENOSYS and are skipped, so probe order does not matter.
  */
 static int reboot_mode_last_stage_init(void)
 {
@@ -133,11 +134,13 @@ static int reboot_mode_last_stage_init(void)
 	if (!CONFIG_IS_ENABLED(REBOOT_MODE_ENV_UPDATE))
 		return 0;
 
-	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &dev);
-	if (ret)
-		return 0;
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
+		ret = dm_reboot_mode_update(dev);
+		if (ret && ret != -ENOSYS)
+			dev_dbg(dev, "reboot-mode update failed: %d\n", ret);
+	}
 
-	return dm_reboot_mode_update(dev);
+	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, reboot_mode_last_stage_init);
 

---
base-commit: e6af0ff0a6e884320938f9c698efad3e217b4e99
change-id: 20261020-reboot-mode-env-update-all-devices-2bb1457e3a3c

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

