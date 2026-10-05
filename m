Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC1DCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 877714040C;
	Mon,  5 Oct 2026 07:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mspOVE38NNp4; Mon,  5 Oct 2026 07:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D1EB4040F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183820;
	b=F70OEQNRQcY0SYgbOsSXtX+WR7wFGV0Joa3VxlpafZSSFgFyvbMdp4pkXlziJxIzqzzI
	 Kc40h7MHulYVpJ++YleDDm2eHDSe5sat3HmoGrEk/M9ec2II3+7TiLrbzYPN+epTZGsXH
	 x9krempwFP6bp8ubK0O+C85820WamfbTD4jj11VfRqZv3eDebst+m+iAz+FJFdjQ969Oo
	 jvQung3VyuP7dIlRrsCXIcUlUlM5OrbIeR80vJ3FB3gQAKqOzNO/ep1se9n7PmSD6APOw
	 WasTTrjDTCeH9ZROMUhDzXpOEJXaulh8vLZEIDHRWXSWDN6S/8hE78dDAGQ67781U+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	b=UnkZpLRLEK1d1T7YO72IOgdNzZe0vPahZFYGLaD0zwFrtHfxaQ+7pAXt8PMp5J9R1lNw
	 gAd0OwZFEswvQgrMLFAxuI0i9vAho0rIIi2yIJDKV2583oORYXlFsz5Y+W/r0l9VAFXOD
	 5t19TI1UQ7nCHB/6V2+uC92Hj+bBb4lbB26t6hHH38mi3sggSvqXjbUQbE/RqqNgfbMuV
	 IKdlsF5yEE2dGXSRh4nj7WFBl7cjirW9vjcmgMyL3WaaNB92P+xqEGaTf3rngQm3LclcK
	 D3mp3V3UWOCVgZ1dU3afoOqxY2AJCjWe1Bi8WqSCMgOgScEN8E5TJdnyd8C5v6udvDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183820;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uT8ncDGQa5aIpPAruVeeyGhqBqGZyNjpjb2I2opn+UGAzuTIIN7XuH7g+9sD4HN2s
	 EQC71g4dtjjeQUoLoJ+4Z0WgFagE0sX8+pm8LFhRendaXEw30Gl05bUfz9e/LXogM0
	 w+OSO9x+sVGhF+5VB723g8DgNOJufgpfOnQVBC+ICLk3xfPdLlQLWXGTlqf8FfD6tQ
	 UTe62UMPCTAH4c19sATYnxEajLHqUSyhoTA1N/xgD5n+uaRjnuSkZCEeF9Mr6vsGT7
	 TxT3xXYMd1pgmgyActgp5ghQ0MLAyEG9Ua8GVCjyOou0m0otb1xBhtWdLbee7NA2zu
	 VLonl/TjEGrjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D1EB4040F;
	Mon,  5 Oct 2026 07:03:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 360AB34D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2799B605CF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djEnoAoXU5qD for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E7603605CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183755;
 b=Lx/ktmR1lxULw/+Ogy16EEHpw6/FxonaphegnbuNo4zA2RPiB3N44S2g0sDAqjGbqk1/
 yybIJq9rSq772ypZMMAUK04UmHnUfvuG6iOHPF/wjC/x9jCVPdOWa0FBQS7Y3rU5W7FbC
 2q0gOyaiJ6Hjk4jI4B2BzFXrAXXUoU+Xzq1ixlQJY4XkYNWForr7SNaazJIf1B7yROaes
 6Un5wgWQfedlFxJrUrv3SJVG1ojJsiXyuwYBeq2OtF/iijsP24ZwECVvhwh3NDfQMRGLx
 WBZFVTjg8k4OlNKIjodd+c9rKXUqqfnIcaKB4fwOwhHbEv4pqAFyTmJ2/eDqMZrKvtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183755;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=M9QCozovcEEFDBC36cPXf4R79by6SSkT5rWBw5BvnbB+uGcM/8YCZITeyOwvALGxvcEg
 PQYpuof+QkZelhsIBD3/5uuomPUuSyWjcJbxQMR3fGqNQJUmUVnUy0NfCroTFCzjlwSa3
 pU+TeInjBIbJbF2uA2RGRPAbxHZYDLcdYI3IxSNSlFxCY2zJ2udSytiJD4Oq7HrixYDZI
 d9/ddwa56jCjeqBbAr1VpIZF8XGHhaSDxmsdZvmqGs1NS9auI9pHb5z5UspXpj2qyZSEb
 i6s81GYdq/I5UOSPpMDcIu/v1uHDRhunG1EjuPbfICPCH12JCLZJ5repOZYG9Ikos4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IHQc1sY9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="kdBV/nT+"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IHQc1sY9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdBV/nT+
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7603605CB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:02:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510Xix093933
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=B3BAWWuwvVM+YbLBq+arqo
 UrzzSN9fGg1B2GeTos2qU=; b=IHQc1sY9mTNdZh73BCmYJhOXTUbfi21qHVHEJG
 m31akCG2Nk/t0ZryuS7hP8PnNZH/eAEwF4wp7neCMGFkP2JWmss6yHbR/C4ExXE+
 ecay578/s7vzRhTqm1wymxwkkX+GIdxiCC7ZgpT1cq332pqgjNE+NciQZoHQKufj
 2Qqh2txdSAddROa5SQH2GmxE06yWIpBA1skn6tJ7R6ek3JdwOPhSAsq80eTPQut5
 e0acWKzLwUAFDtj94DG+bqfUUUK1bqTlWGLxinqtmlTpRXIOrJtlMecW90wnUWMl
 slgU7WEGxRfFq2c+vX0A7ARNdRcScClv6vScZ0lVlotOu/Sw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssu4t4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:02:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-313d1015161so4546800eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183752; x=1791788552;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=kdBV/nT+rU4Yip7+qTgk2ivJhRSWDuhHVUDCg25Htl65pOzWE7jlm28vmI+MOhF08Y
 am14WHOgzQxBEZGJYPwJyEejQM6pNmw/zKkOaI/Z1fIk77/mU+YMyJP76yg6a0w3jqtd
 9DV9QehuTQZVzNs/xBBzxhcC7S5/rEPdsN1j/pcYJ/AhKOov4yA/indCOk4a41blvxpY
 Hx0EBHplg1G1WJGftdZR9qhI8h1wfEP1JnJl9kdp7bOgxE8bwPo6e0QuyQ/yb3csPMgc
 UdjxUMS2uaydnp46UrYaCYEd0GXH6h6DeO48LY/Vw0RZzVzitxJjPD1720heU6IlNcH7
 KACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183752; x=1791788552;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=gI5RipzFe8s4VL8mI5iu3zmTEGp3cVC41NYnrz+8Vw/5PdzLw/87+0fMGQ8Qh21Ids
 vCzA6Tdf0RS/igFo/BHSY2FmsDS641V0QCrdwY7F+oQ6FOfra2I7SXkuNWA2uAdXKnYH
 /jzCGcxYgxN1uRTC4rAHtI93Iy1PETwnNNKp/OBgAy7MHiCL7n9nID3uc3mlZ0Yuq0ln
 PR2GSOtni0Ij8drv8R19q8kBvu0+UtyOA3hJmLQD1HMy+uWAhih0CdgXH9Trqc2nk3iC
 TXpGPlLARUtIRTCQazWgjhsprIB8jVKViCb5LxCC/ZDw8DeAV1SwSQkLDd4+WPo1O8IQ
 FkRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+rgKT7NytSNgOs86yzZY6tJbJb5oQtLWc3jjD/FtuZLcOFwKUOQ4oWQmn+NzPH5L0ofpuIlo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWr3BFgs6agkHfZgjm6IhzfDSBicn8aGfVpimiMC5UiPeSWrmX
 NQ9JA4941x4vCOBMX7Rgw+ytDRGRChG3rTKun1J4X/mCF1KW7MX4orPNrTSVH7ebQ/PlcK5w3+a
 iuAZXmy+m8cOnHG29V9NJXnA1ZEsVB3pxqt/mLsbRSDLgpDlUSES0+KUoiiRq1cjZUp3z5FI=
X-Gm-Gg: AYBFou32eXRwKWG5leU03xohaKrmhpef3Cd6iavmlXeqEXL3gOnhq6pmFSKGzr7UoM9
 ir2pUoC8stXl8RnHntiWFkeT3Ih9QG+QDm5L6pOr2pE9nJF+C7qtF8kw9KtfdBJ8gCD7Ld0+gCq
 FGUzkVmWBQBdFjMsYm7Lh4tTcDfrW2hQJp3X7qfH5VEA2NAkME7ylY3hJ6RBGd2k90NZQIDnK3w
 Oei1/8vDoFJTASVqi2YnbWm8hCN38tmrxF4FNkF7xrkqlcTDjCgUtTLPrgFF0pkXpH8Zxxea3WV
 FqkrAyN2aBHeggJAB5miVraW7Rw/hujMbCgSx4v0lGXrBkJwowTDz1QG6mzeXxUZdW0A9x34Ojo
 8F8FKmMx9KiTFiHqgw8Tm9qdBebjYNlwhdmnXUsiuImkE/BJFmydm8bBosC+i/FKpPrGydDWe2b
 8C7MmDZTIo3IV7157LtbQkZzvOSsag
X-Received: by 2002:a05:7300:e5cb:b0:34c:8c69:529d with SMTP id
 5a478bee46e88-34f150d878dmr12534278eec.26.1791183752070; 
 Mon, 05 Oct 2026 00:02:32 -0700 (PDT)
X-Received: by 2002:a05:7300:e5cb:b0:34c:8c69:529d with SMTP id
 5a478bee46e88-34f150d878dmr12534257eec.26.1791183751577; 
 Mon, 05 Oct 2026 00:02:31 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:02:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH RESEND v10 00/15] Qualcomm IPQ5210 SoC bringup
Date: Mon, 05 Oct 2026 12:32:16 +0530
Message-Id: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX50VzPj8JD0ca
 aoEepv+BFA98azUxUMjxduYmJHR5LpCosysF6ymCONriltU15BwpeCICt9RM59L2m4Kw6Y+26bd
 vpxYpBb4PC7ZkIfmn+ZMVKxhXJ1Q1f0xb8yzOcmXvxoAhOco7Hp9e3FIwahex3X0PyyllbHiRY0
 sUMPTc1cUD3tclUHL/7gFE76dNyl3nTVUZ22ov/6hYFm+y6/oVU9nXyniST1pWGRhbrHs0/y57F
 hr+1k06Vpw6Vpw44dPDOwFc+dF3w3l+U0EvcTzBcg1qUXzhGE4YzwggxWV3IeQ1WftvR0BzGEfR
 kLYIy6phCc+y6OMdMsIkotgXwlnNJfG/pnMuevH48BR55wiF0GjhJa2SI3LIA7mnKwh6Cjm+T3g
 d+QSjtmveSTLSsivrHWK6xu288SXk6Xl/hgvv3VhxOtfpRFJGr+33rHh8+0h7lGQagdWx2MQA4u
 UhE8oVYf2WeaWLie1UA==
X-Proofpoint-ORIG-GUID: Q5A2_iimzrF1Pik-uDNP3du5LiM9FlaF
X-Proofpoint-GUID: Q5A2_iimzrF1Pik-uDNP3du5LiM9FlaF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX/CrS9YTXTktk
 JkXsvEP6TatF5Cu/YWs69KxNJvpuMRLlx3KllPoOzlLs+uwxlvRTykphyJ0w8a0JBE0PgnKmWqa
 9A5j1yh9cRc8aVTjWgjfieveVON2pjM=
X-Authority-Analysis: v=2.4 cv=XPSl2ghE c=1 sm=1 tr=0 ts=6ac34b89 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=YfCOm-DyAAAA:8
 a=7l9ilokc8PBLwnsvYBYA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=IC2XNlieTeVoXbcui8wp:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1] & [2]

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h
2 - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Changes in v10:
- Update board/qualcomm/config.mk to work with v3 of mkmbn series
  (https://lore.kernel.org/u-boot/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com/)
- Fix mailing list e-mail id problem
- Since v9 was sent to old denx mailing list, lore URL is not available.
  Please use the patchwork link below. Apologies for the inconvenience.
- Link to v9: https://patchwork.ozlabs.org/project/uboot/list/?series=523494

v9:	- RESENd because sent to old denx mailing list
	- Address review feedback
	- Move qclib handling to separate file with some functionality as
	  'weak' functions to allow SoC implementations to override it
	- Link to v8: https://lore.kernel.org/u-boot/20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com/

v8:	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	- Address Casey's review comments on v6
	- Spin off GENI Minicore support and mkmbn support as separate patches
		[PATCH] misc: qcom_geni: Add minicore support - [a]
		[PATCH 0/3] tools: qcom: mkmbn: Updates to support ipq5210 - [b]
	- Re-organize the functions from spl.c into board_spl.c and fit-handler.c
	  and remove spl.c
	- Retained R-b tags since the code just moved
	- Removed references to MBN and multi-elf creation steps in rdp.rst since
	  mkmbn.py takes care of it
	- Add details about the interface table in doc/board/qualcomm/spl-qclib.rst
	- May need to update config.mk based on the final shape of mkmbn patches [b]

	a - https://patchwork.ozlabs.org/project/uboot/list/?series=514770
	b - https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

v7:	- Fix inadvertant typo in doc/board/qualcomm/rdp.rst
	- Pick multiple R-b tags
	- No code changes

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now
	- https://lore.kernel.org/u-boot/20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com/

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes
	- https://lore.kernel.org/u-boot/20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com/

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

---
Varadarajan Narayanan (15):
      misc: qcom_geni: Add minicore support
      mach-snapdragon: Kconfig: Auto select options based on configs
      mach-snapdragon: Add PBL shared data defines
      mach-snapdragon: spl: Update boot device information in SMEM
      mach-snapdragon: spl: Add support for MMC booting in SPL
      mach-snapdragon: Kconfig: Add rules to create SPL images
      mach-snapdragon: spl: Load next stage FIT image
      mach-snapdragon: spl: Add DDR initialization support
      mach-snapdragon: Add Qclib handling support
      dts: ipq5210-rdp504-u-boot: add override dtsi
      clk/qcom: add clock driver for ipq5210
      pinctrl: qcom: Add ipq5210 pinctrl driver
      mach-snapdragon: spl: ipq5210: Add SPL support
      configs: Add qcom_ipq5210_mmc_defconfig
      doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                                |  12 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi         |  12 +
 arch/arm/mach-snapdragon/Kconfig                |   7 +
 arch/arm/mach-snapdragon/Makefile               |   3 +
 arch/arm/mach-snapdragon/board_spl.c            | 255 ++++++++++++++++-
 arch/arm/mach-snapdragon/fit-handler.c          | 131 +++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h   |  82 ++++++
 arch/arm/mach-snapdragon/include/mach/spl.h     |  13 +
 arch/arm/mach-snapdragon/pbl-shared-data.c      | 125 +++++++++
 arch/arm/mach-snapdragon/qclib.c                | 160 +++++++++++
 board/qualcomm/config.mk                        |  25 +-
 board/qualcomm/ipq5210/Makefile                 |   3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds |  18 ++
 board/qualcomm/ipq5210/spl-ipq5210.c            |  99 +++++++
 configs/qcom_ipq5210_mmc_defconfig              | 113 ++++++++
 doc/board/qualcomm/rdp.rst                      |  96 ++++++-
 drivers/clk/qcom/Kconfig                        |   8 +
 drivers/clk/qcom/Makefile                       |   1 +
 drivers/clk/qcom/clock-ipq5210.c                |  93 +++++++
 drivers/misc/Kconfig                            |   6 +
 drivers/misc/Makefile                           |   1 +
 drivers/misc/qcom_geni-minicore.c               | 103 +++++++
 drivers/misc/qcom_geni.c                        |  85 +++++-
 drivers/pinctrl/qcom/Kconfig                    |   8 +
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c          | 349 ++++++++++++++++++++++++
 include/configs/ipq5210.h                       |  11 +
 include/soc/qcom/geni-se.h                      |   5 +
 include/soc/qcom/minicore.h                     |  25 ++
 include/soc/qcom/qup-fw-load.h                  |   1 +
 30 files changed, 1824 insertions(+), 27 deletions(-)
---
base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8
change-id: 20260825-spl-55fcb0c72ebd

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

