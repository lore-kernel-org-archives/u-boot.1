Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF32606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M48rqYJG;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LClXY+0W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWW3+o98
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1CBE80BC0;
	Tue, 17 Nov 2026 15:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pXOcTAzQDidx; Tue, 17 Nov 2026 15:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36D1880AE8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794930498;
	b=owwcYIwBkckDmZnu2NA+jpjL07E0jmoKJ44TzI1x6AF652F8fFLfmQA7e8gOVqLIBc2q
	 WwrBqCwn06naAan6qQXvh4IFUmgde79Vy3LAYQI1wkPN/Xn8Qop3a5ye2yxw9SufOU+cW
	 J0Y5whhPfMvcPtWj/T/SBnlJXPjJyucVtvv3gZ/QpUSdEtGR/YNgdXipGVNQlZYO/ciBp
	 xrGp9yWnYij4VFxU4+oDeaAZEX+y1DbyImd5QGwpRGA7tzkCt/2lJP8G2ZwHye9m3awMC
	 weHheKjJxQ7DgKWzysMelF3/n8QaWBMkqIjucUBHRhbVQq7S5vuM3zmKLDxoonVQyAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794930498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xFkSLSBD5xvaHjn1IUSjgWA3ENGy62vPwLb7MANFQxI=;
	b=JxQpMAYAj2Wayh2ImpKTZmJ2Xq6YuJis8E7Ujd7bYo8n5p2pmE3ZMj4iE20JL50vlGUk
	 9cuI4a82xj1e01HNjlO/NDBoDOVXhCv665E2PMnSaIrD4Nrvi3XNLwQo8jdIscj2lroy3
	 oRQwPPp/Knfc6KR7rgIT2+x66HlOs5IRwds/FI9LR9GrAFlnRNqSVM4MwJigqEhadMRxL
	 5nUpSzeo7z4aVbiVijA/dQiwHiWMSUwx6hGURpfQ/i4sJAWKFSeR7dyhKcKPXWDgh4xuS
	 03BxVWalxR8w0MJwDhIu1AMqevjeiFMEvzFp8aW9bnJxz06pA8fbse/hOUlkSEsdJ8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794930498;
	bh=xFkSLSBD5xvaHjn1IUSjgWA3ENGy62vPwLb7MANFQxI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M48rqYJGHKX1sux3FtgQXnivd7XYKsCJ9ztzdJL6Bmlt3VaqtRO/nFQPpNOb60kmq
	 IoIcuMlHzcncfWnoJ9WtsVdQJU5gYmyrgqzeEscs2AT/f5U9uwMBAQCMF5hEt2XCpG
	 QAIyXWL1Qyk/duo0KDP9CP0/QfC11iXEh+MIQxiOkOXKHgJSimDNb2rDcN0rb7w/EC
	 GDBVmm+BvHqSfuY/iQjjmac5nGLhiL+/nfnVvdrdUzvHudt6yKAtgWG9CYNAuyIYco
	 fM6naCTyYYpf35eO2tiSiB31evCR8OCm9lATuoYzraJZBk1dWvSunXsW/tN75HtpfY
	 5O6zJzBq4tj7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D1880AE8;
	Tue, 17 Nov 2026 15:48:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 723BB105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 578CC4059E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJ4TplRwX8JZ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C6EF40606
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LClXY+0W; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AWW3+o98
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C6EF40606
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:48:11 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQZ3I4169706
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xFkSLSBD5xvaHjn1IUSjgW
 A3ENGy62vPwLb7MANFQxI=; b=LClXY+0W/KwOX6TbMk9pET5T0Mv5WgJr0ZJY+K
 ZqN7YbOe42mUMUai3WsTyeDwS43rKi6EwaT7OqYdsb1FhnaO4mD/9Ifdr7th97Sl
 3HOdVlwlh0NK5Gy9V5yTXfRBmmqwvO76oTZ31yNvNixipTCY6Kov6632aKjrHN6M
 hbTB59/2iMWGKZdswd+gIQr4rDYwZI/ylm5syJH6J5TUCiI6LkM5Vrl1D6e5+PsL
 FGhNznUtd2TaXpgugBzDjkKb0yOszID7fDzUwq6RogGE4YuqP4NjmapmDj6QPJc6
 2wab8yAnZmAj0ZqnxW/aAfHEwdXuhgq+I6pRGRQCRj80vpUg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve2923-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:48:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso3708453c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794930490; x=1795535290;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xFkSLSBD5xvaHjn1IUSjgWA3ENGy62vPwLb7MANFQxI=;
 b=AWW3+o98POmb8ZVOvcvfQCviPmiz1eDiIvs1HbpyD/FlyD8vZntQm4FIF5zPRppYXl
 a17ezkJJKvYIh75n02ry4UYQHQVM+4+u2WUp4prHtKR1KUPrijmOw4eZGo4jM2OmHLdb
 HU+L+umxLGuSYmJ0HHQ82YT+Vw9OzGqkCVtsl6X3xGarYC6bIlDC06Vw4SmvCl45mDPu
 +PdqGHIi1IsZ/Z5sckiCY7jG8PVUCIWQLgYzvsGniDBcKb6W87gavIEQ9xIAtyUXcvma
 7GtHMhUfIsLZHIj6OkHXA3xe2xcIVYemRRL1Jkz0JtNnP/3y+3d1L8J56jSSon8iDhps
 LmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930490; x=1795535290;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xFkSLSBD5xvaHjn1IUSjgWA3ENGy62vPwLb7MANFQxI=;
 b=UTVDpHrcsqyP2ZowO6+43s0Eb69hr+CK+PddEM+5aQDuUMTu/+FPHc/h0H5vpwvxks
 0l07pOXk8oavaRzORA2VGe2G8qZEq3kLKszovphluG0kAGDOMsbFCBzo2ucFMqm0c5Hb
 T5AU86f/Q02G7/gaod0qylcJ/MPu3BnMB6rWlO2K/b8eAc1NsKQD6FipTouecaAaeD51
 NfonQmv7WrPNukXOC1EAH4kgYsWAi6qWakobUQ4n94kLyh1LcjyV10zZjbYWn/PzrBq6
 29IdKar2V8c1+SyTr5zai21/4H95883E5bFmyYYRCyxpmCq+e7Ml4OZ0TKG3f7Xv5NLV
 LMAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGBUyyf4kiQdBITH2hMTjHkHgAU+DKXfUHt+ulQBhFjLRVaCfT/emEDduF5mt2hhaHO6nVn+RU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9WRvt+IOi32efYbTp52qUv5dKD4YTTtnmAX29C0eDQmdrGoWGW
 5hNEv9rMU9zsp0YDIgZ7/CPErXE4Z99TAjUNx4bmr6QQpYTsKST/S8khtcqHL4RRI/jiLvNlmci
 DGKooW2+HF7+NPXOj0aKTGMmTcrwMRX4SDn+8J9cKaKstqJumJtN9voei/ptPpD9tIAG168w=
X-Gm-Gg: AYBFou1amSYbvERwTdO0PhZiuYqfKvrYAHvDkWoPl1nDdZ+fjh0CtpSzkHZlz5x3GwZ
 TIc/C54wYv2yiaX4qWFi71fVwDJHuGoU0+RSHzDtQukq2BeToy5tGUteapNxzfyfjvKqAdh6NS0
 n4nrV34LxXZTiuK9sPR5zvnDO/dPtypNYRRdJSP9FZO4kpJVEh+0AVRGBrdfx6Sb5yl6f2tc1VC
 +xvCw2GDBcQbeJX/hB1jaw7W8PiLUYsyqXL6tGs42wza7Ngvf0T9zCxCDOk0vSRQqx9RTFhRMBx
 ALOQP76F4gy6oNrsH03bueKkQUqfkc42IaFP7iptjsl9ZT0lKkpx89sXu6COBPIVcIjs3JMojhr
 nsMY2ewo/UQENkHa+u+xWvdeeSqz+UBr1qQfkUcrJZ58NByB2SNt9OKS3i/1LKetmDrgalsS+5U
 kAxbEAAdGLsIM7kLCxQetAV2QnCfGLr5/9sdPYf2cT0JyCvbvKP72eaG9rRnVTNBsXLVy7KZBUx
 C9OHK1VhDLO/mg=
X-Received: by 2002:a05:701a:844a:20b0:1b5:2717:61df with SMTP id
 a92af1059eb24-1b52717691emr7638127c88.41.1794930489512; 
 Tue, 17 Nov 2026 07:48:09 -0800 (PST)
X-Received: by 2002:a05:701a:844a:20b0:1b5:2717:61df with SMTP id
 a92af1059eb24-1b52717691emr7638078c88.41.1794930488404; 
 Tue, 17 Nov 2026 07:48:08 -0800 (PST)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm60380823c88.9.2026.11.17.07.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:48:07 -0800 (PST)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:18:02 +0530
Subject: [PATCH v7] spi: Add Qualcomm GENI QUPv3 SPI controller driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-spi-v6-v7-1-8115894d8285@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADF3/GoC/zWNQQqDMBBFryKzbiQGOg1d9R7FRYxjTanGZjS0i
 HdvYnEz8OD9NyswBUcM12KFQNGx82OCy6kA25vxQcK1iUFJhZWUKHhyIqKorDEKtapaNJDkKVD
 nPnvoXv+Zl+ZJds7rbPSOZx+++6eI2Tui+ojmrlBGd2jlmZpG3zxz+V7My/phKNOBetu2H5ThK
 1i1AAAA
X-Change-ID: 20261006-spi-v6-1caa26821d6a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794930483; l=32010;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=Trfl05tdPfVSFIwLKMyA8adyMrIEhcle0g0Cv1mEaPk=;
 b=6nUP8uejPPIk7eflVS+h+WHGun1T+g4pnZahVUhfYAmgCgYyIHGE3mTJBKnriu9KhNMq0JrD0
 BNvMqWcvyBNCAXhDd2HunMD7o3ZaYGvqcII3erXpjWtDBk9DVz0LZVf
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX3pYe8TRzNL7+
 HPEquSBgIgRqD0QY7Asb9WxN+/o+331/JhrotI/5+D0392fMr6Wb5YpyUP+EmWXQbhZd8F0ugDb
 MZISqKaOCTOZgIyE3qpbnBdvzjRco0k=
X-Proofpoint-GUID: Qe2jD1dakKlV2OObok-mCy_amgdnuf_u
X-Proofpoint-ORIG-GUID: Qe2jD1dakKlV2OObok-mCy_amgdnuf_u
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc773b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=1VxDqnHFAAAA:8
 a=nU8kNh3lQCPuFx7OGCUA:9 a=zVMRWV0EdB3lQLTH:21 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX0l756noNcyl7
 5rqmBst3C+P2z0pP5d1WExmnO0bgG0q6LLF+HLiXLzvcZyUP03cZyX6bleAkLmteyuPg+f9LIJZ
 5do9g+Wf9sdQNF1KcxjmUe9ADw2WoX4OkmRqQ4MhrIevkFCcnaRzhAD4v5Yo5b/5uMxdTjJQIDy
 BCIje0R6OrzMdYy2Sy/++bHhRcDExLMYLWebDhlJSNdMUxuXBIOmxMIv8PjsK18rQKtgfQvN/mm
 KNwg3JXTU2gb/96+CtcpKkRn5B8CrBJwiQUkaMC7kBn1hs6yoVNGl5zwNZyQo/W2+GjOphgVYxA
 YJko3HsZr7728IhN8AYVlfGg669BAqaoaor4tZMOQmQbcrbKc6z8Dv9DuOMaCEcMnDC8pr8iWMc
 aSTfHY/iUi86eCOL054A5bBuviSgUbKZGLj88IlQICgl6KR+rVMA3RJH1h/gpsbuHI+bOHT5ROx
 gZ2EnNrXg+mkYayagMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170062
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DM_SPI driver for the SPI protocol of the Qualcomm GENI Serial
Engine found in QUPv3 wrappers on Qualcomm SoCs such as SDM845, SM8250
and SA8775P. It is based on the Linux driver
drivers/spi/spi-geni-qcom.c. The Serial Engine firmware is loaded with
the existing qcom_geni_load_firmware() helper.

Transfers use either the CPU-driven FIFO path or the Serial Engine DMA
(SE-DMA). FIFO is chosen for small transfers when the hardware reports
it as available, SE-DMA otherwise. The SPI clock is set in set_speed()
from the Serial Engine source clock instead of relying on the rate left
by earlier boot stages. The optional "qup-memory" interconnect path
is looked up when the device tree describes one.

Add the register offsets used by the driver to include/soc/qcom/geni-se.h
and the Kconfig entry and Makefile rule.

Validated in both FIFO and DMA modes on IPQ5424 and LeMans platforms.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Depends-on: https://lore.kernel.org/u-boot/20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com/

Changes in v7:
- Set SE clock rate in set_speed() instead of using clk_get_rate()
- Pick the closest source rate not above the requested speed
- Fail set_speed() if no source rate fits
- Base the transfer timeout on the programmed SPI clock
- Rename dout/din to txbuf/rxbuf
- Look up the optional qup-memory interconnect path
- Shorten commit message, add Linux origin
- Link to v6: https://lore.kernel.org/u-boot/20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com/

Changes in v6:
- Update Depends-on to the RX_RFR_WATERMARK fix v3 posting (v5 pointed
  at v2); it still provides geni_se_fifo_depth_mask() used by this driver
- Fix stale u-boot@lists.denx.de recipient to u-boot@lists.u-boot-project.org
- Drop stale Link/Message-Id trailers carried over from the v5 posting
- Link to v5: https://lore.kernel.org/u-boot/20260913-geni-spi-v2-review-v5-1-b80cef576afa@oss.qualcomm.com/

Changes in v5:
- Drop the geni_se_fifo_depth_mask() helper addition from this patch;
  it is now provided by the RX_RFR_WATERMARK fix patch this one
  depends on, avoiding duplicated fifo-depth decoding logic between
  the two patches.
- Link to v4: https://patch.msgid.link/20260828-geni-spi-v2-review-v4-1-8045ff1d7563@oss.qualcomm.com

Changes in v4:
- Replace the per-transfer malloc_cache_aligned() RX bounce buffer
  with a fixed-size, stack-allocated head/mid/tail split, removing
  any heap or LMB dependency for unaligned SPI transfers.
- Lower the "firmware not loaded" message from dev_info() to dev_dbg().
- Link to v3: https://patch.msgid.link/20260828-geni-spi-v2-review-v3-1-228729b62381@oss.qualcomm.com

Changes in v3:
- Use GPL-2.0-only SPDX identifier
- Drop "Based on the Linux GENI SPI driver..." blurb
- Fix RX DMA cache-invalidate alignment bug via bounce buffer
- Abort on any transfer error, not just timeout
- Log DMA TX/RX FSM reset timeouts in the abort path
- Link to v2: https://lore.kernel.org/u-boot/20260817-geni-spi-v2-v2-1-78a7a4f4a20e@oss.qualcomm.com/

Changes in v2:
- Drop cover letter
- Drop DT property
- Drop plain-text binding doc
- Link to v1:
https://lore.kernel.org/u-boot/20260814104520.3384723-2-vandhiadevan.karunamoorthy@oss.qualcomm.com/
---
 drivers/spi/Kconfig         |   9 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/qcom_geni_spi.c | 871 ++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/geni-se.h  |   8 +
 4 files changed, 889 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..691b317a9fe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -463,6 +463,15 @@ config SPI_QUP
 	  mode supports up to 50MHz, up to four chip selects, programmable
 	  data path from 4 bits to 32 bits and numerous protocol variants.
 
+config SPI_GENI_QCOM
+	bool "Qualcomm GENI SPI controller"
+	depends on DM_SPI && QCOM_GENI
+	help
+	  Enable support for the SPI Serial Engine of the Qualcomm Generic
+	  Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper.
+	  Used to access SPI devices such as SPI-NOR flash on Qualcomm SoCs
+	  that have a GENI/QUPv3 wrapper, e.g. SDM845, SM8250, SA8775P.
+
 config RENESAS_RPC_SPI
 	bool "Renesas RPC SPI driver"
 	depends on RCAR_64 || RZA1
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 13d9c5dce80..c1ade77c75a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
 obj-$(CONFIG_PIC32_SPI) += pic32_spi.o
 obj-$(CONFIG_PL022_SPI) += pl022_spi.o
 obj-$(CONFIG_SPI_QUP) += spi-qup.o
+obj-$(CONFIG_SPI_GENI_QCOM) += qcom_geni_spi.o
 obj-$(CONFIG_SPI_MXIC) += spi-mxic.o
 obj-$(CONFIG_RENESAS_RPC_SPI) += renesas_rpc_spi.o
 obj-$(CONFIG_ROCKCHIP_SFC) += rockchip_sfc.o
diff --git a/drivers/spi/qcom_geni_spi.c b/drivers/spi/qcom_geni_spi.c
new file mode 100644
index 00000000000..beed14ba838
--- /dev/null
+++ b/drivers/spi/qcom_geni_spi.c
@@ -0,0 +1,871 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm GENI QUPv3 SPI controller driver
+ *
+ * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <log.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/read.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <cpu_func.h>
+#include <spi.h>
+#include <clk.h>
+#include <interconnect.h>
+#include <time.h>
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+
+/* SPI-protocol-specific SE registers, on top of the generic ones in geni-se.h */
+#define SE_SPI_CPHA			0x224
+#define SE_SPI_LOOPBACK		0x22c
+#define SE_SPI_CPOL			0x230
+#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
+#define SE_SPI_DEMUX_SEL		0x250
+#define SE_SPI_TRANS_CFG		0x25c
+#define SE_SPI_DELAYS_COUNTERS		0x278
+#define SE_SPI_WORD_LEN		0x268
+#define SE_SPI_TX_TRANS_LEN		0x26c
+#define SE_SPI_RX_TRANS_LEN		0x270
+
+/* Maximum number of source rates probed from the clock provider */
+#define MAX_CLK_PERF_LEVEL		32
+
+#define CPHA				BIT(0)
+
+#define LOOPBACK_ENABLE			0x1
+#define LOOPBACK_MSK			GENMASK(1, 0)
+
+#define CPOL				BIT(2)
+
+/* SE_SPI_TRANS_CFG */
+#define CS_TOGGLE			BIT(1)
+
+#define WORD_LEN_MSK			GENMASK(9, 0)
+#define SPI_WORD_LEN_BITS		8
+#define MIN_WORD_LEN			4
+
+#define SPI_TX_ONLY			1
+#define SPI_RX_ONLY			2
+#define SPI_TX_RX			7
+#define FRAGMENTATION			BIT(2)
+
+#define SPI_ERR	(M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN | \
+		  M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN | \
+		  M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)
+
+#define SPI_XFER_TIMEOUT_MS		250
+
+/* SPI-NOR reads/writes are page/sector sized; skip DMA setup below this */
+#define SPI_DMA_MIN_XFER_BYTES		64
+
+struct qcom_geni_spi_priv {
+	phys_addr_t wrapper;
+	phys_addr_t base;
+	struct clk se;
+	u32 tx_wm;
+	u32 tx_fifo_depth;
+	u32 bpw;
+	u32 bytes_per_fifo_word;
+	u32 oversampling;
+	ulong sclk_hz;
+	bool fifo_capable;
+};
+
+/* Bytes packed into each 32-bit FIFO word, based on word length */
+static unsigned int qcom_geni_spi_bytes_per_fifo_word(unsigned int bpw)
+{
+	if (bpw <= 8)
+		return 4;
+	else if (bpw <= 16)
+		return 2;
+	return 1;
+}
+
+/* Scale the wait budget with transfer size instead of a flat constant */
+static ulong qcom_geni_spi_xfer_timeout_ms(struct qcom_geni_spi_priv *priv,
+					   unsigned int len)
+{
+	/* Use the programmed SPI clock, the SE clock is not the bit rate */
+	ulong rate = priv->sclk_hz;
+	ulong ms;
+
+	if (IS_ERR_VALUE(rate) || !rate)
+		return SPI_XFER_TIMEOUT_MS + len / 1000;
+
+	/* len is in bytes; add generous margin for controller/DMA overhead */
+	ms = DIV_ROUND_UP_ULL((u64)len * 8 * 1000, rate) * 4;
+
+	return max_t(ulong, ms, SPI_XFER_TIMEOUT_MS);
+}
+
+#define NUM_PACKING_VECTORS		4
+#define PACKING_START_SHIFT		5
+#define PACKING_DIR_SHIFT		4
+#define PACKING_LEN_SHIFT		1
+#define PACKING_STOP_BIT		BIT(0)
+#define PACKING_VECTOR_SHIFT		10
+
+/* Configure how the SE packs/unpacks "bpw"-bit words into 32-bit FIFO entries */
+static void qcom_geni_spi_config_packing(struct qcom_geni_spi_priv *priv, int bpw,
+					 bool msb_to_lsb)
+{
+	u32 cfg0, cfg1, cfg[NUM_PACKING_VECTORS] = {0};
+	int len, temp_bpw = bpw;
+	int idx_start = msb_to_lsb ? bpw - 1 : 0;
+	int idx = idx_start;
+	int idx_delta = msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE;
+	int i, iter, pack_words;
+	unsigned int ceil_bpw;
+
+	if (bpw <= 8)
+		pack_words = 4;
+	else if (bpw <= 16)
+		pack_words = 2;
+	else
+		pack_words = 1;
+
+	ceil_bpw = (bpw & (BITS_PER_BYTE - 1)) ?
+		((bpw & ~(BITS_PER_BYTE - 1)) + BITS_PER_BYTE) : bpw;
+
+	iter = (ceil_bpw * pack_words) >> 3;
+	if (iter <= 0 || iter > NUM_PACKING_VECTORS)
+		return;
+
+	for (i = 0; i < iter; i++) {
+		len = min_t(int, temp_bpw, BITS_PER_BYTE) - 1;
+		cfg[i] = idx << PACKING_START_SHIFT;
+		cfg[i] |= msb_to_lsb << PACKING_DIR_SHIFT;
+		cfg[i] |= len << PACKING_LEN_SHIFT;
+
+		if (temp_bpw <= BITS_PER_BYTE) {
+			idx = ((i + 1) * BITS_PER_BYTE) + idx_start;
+			temp_bpw = bpw;
+		} else {
+			idx = idx + idx_delta;
+			temp_bpw = temp_bpw - BITS_PER_BYTE;
+		}
+	}
+	cfg[iter - 1] |= PACKING_STOP_BIT;
+	cfg0 = cfg[0] | (cfg[1] << PACKING_VECTOR_SHIFT);
+	cfg1 = cfg[2] | (cfg[3] << PACKING_VECTOR_SHIFT);
+
+	writel(cfg0, priv->base + SE_GENI_TX_PACKING_CFG0);
+	writel(cfg1, priv->base + SE_GENI_TX_PACKING_CFG1);
+	writel(cfg0, priv->base + SE_GENI_RX_PACKING_CFG0);
+	writel(cfg1, priv->base + SE_GENI_RX_PACKING_CFG1);
+
+	writel(bpw / 16, priv->base + SE_GENI_BYTE_GRAN);
+}
+
+static int qcom_geni_spi_fifo_xfer(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				   u8 *rx, unsigned int len, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	unsigned int tx_cur = 0, rx_cur = 0;
+
+	while (get_timer(start) < timeout_ms) {
+		u32 status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
+		unsigned int i;
+
+		if (status & SPI_ERR) {
+			writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+			if (tx)
+				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
+			return -EIO;
+		}
+
+		if (tx && (status & M_TX_FIFO_WATERMARK_EN)) {
+			for (i = 0; i < priv->tx_wm && tx_cur < len; i++) {
+				u32 word = 0;
+				unsigned int p;
+
+				for (p = 0; p < priv->bytes_per_fifo_word && tx_cur < len; p++)
+					word |= tx[tx_cur++] << (p * 8);
+
+				writel(word, priv->base + SE_GENI_TX_FIFOn);
+			}
+
+			if (tx_cur == len)
+				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
+		}
+
+		if (status & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
+			u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+			u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
+
+			if (rx) {
+				for (i = 0; rx_cur < len && i < rxcnt; i++) {
+					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
+					unsigned int p;
+
+					for (p = 0; p < priv->bytes_per_fifo_word &&
+					     rx_cur < len; p++) {
+						rx[rx_cur++] = word & 0xff;
+						word >>= 8;
+					}
+				}
+			} else {
+				for (i = 0; i < rxcnt; i++)
+					readl(priv->base + SE_GENI_RX_FIFOn);
+			}
+		}
+
+		writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+		if (status & M_CMD_DONE_EN) {
+			/* Drain any residual RX words after CMD_DONE */
+			if (rx && rx_cur < len) {
+				u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+				u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
+				unsigned int i;
+
+				for (i = 0; rx_cur < len && i < rxcnt; i++) {
+					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
+					unsigned int p;
+
+					for (p = 0; p < priv->bytes_per_fifo_word &&
+					     rx_cur < len; p++) {
+						rx[rx_cur++] = word & 0xff;
+						word >>= 8;
+					}
+				}
+			}
+			return 0;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_abort(struct udevice *dev, struct qcom_geni_spi_priv *priv)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	writel(M_GENI_CMD_ABORT, priv->base + SE_GENI_M_CMD_CTRL_REG);
+
+	do {
+		status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	} while (!(status & M_CMD_ABORT_EN));
+
+	writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	/* Reset TX/RX DMA FSMs so the next transfer starts clean */
+	start = get_timer(0);
+	writel(1, priv->base + SE_DMA_TX_FSM_RST);
+	do {
+		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
+			dev_err(dev, "DMA TX RESET failed\n");
+			break;
+		}
+	} while (!(status & TX_RESET_DONE));
+	writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
+
+	start = get_timer(0);
+	writel(1, priv->base + SE_DMA_RX_FSM_RST);
+	do {
+		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
+			dev_err(dev, "DMA RX RESET failed\n");
+			break;
+		}
+	} while (!(status & RX_RESET_DONE));
+	writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
+
+	return 0;
+}
+
+/* SE-DMA: the SE moves data directly to/from a physical buffer */
+static void qcom_geni_spi_dma_tx_start(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				       unsigned int len)
+{
+	phys_addr_t buf = (phys_addr_t)(uintptr_t)tx;
+
+	flush_dcache_range(ALIGN_DOWN((ulong)tx, ARCH_DMA_MINALIGN),
+			   ALIGN((ulong)tx + len, ARCH_DMA_MINALIGN));
+
+	writel(lower_32_bits(buf), priv->base + SE_DMA_TX_PTR_L);
+	writel(upper_32_bits(buf), priv->base + SE_DMA_TX_PTR_H);
+	writel(GENI_SE_DMA_EOT_BUF, priv->base + SE_DMA_TX_ATTR);
+	writel(len, priv->base + SE_DMA_TX_LEN);
+}
+
+static void qcom_geni_spi_dma_rx_start(struct qcom_geni_spi_priv *priv, u8 *rx,
+				       unsigned int len)
+{
+	phys_addr_t buf = (phys_addr_t)(uintptr_t)rx;
+
+	/* Discard stale dirty cache lines before the DMA write lands */
+	invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
+				ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
+
+	writel(lower_32_bits(buf), priv->base + SE_DMA_RX_PTR_L);
+	writel(upper_32_bits(buf), priv->base + SE_DMA_RX_PTR_H);
+	writel(0, priv->base + SE_DMA_RX_ATTR);
+	writel(len, priv->base + SE_DMA_RX_LEN);
+}
+
+static int qcom_geni_spi_dma_wait_tx(struct qcom_geni_spi_priv *priv, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	while (get_timer(start) < timeout_ms) {
+		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
+		if (!status) {
+			udelay(1);
+			continue;
+		}
+
+		writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
+
+		if (status & TX_SBE)
+			return -EIO;
+		if (status & TX_DMA_DONE)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_dma_wait_rx(struct qcom_geni_spi_priv *priv, u8 *rx,
+				     unsigned int len, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	while (get_timer(start) < timeout_ms) {
+		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
+		if (!status) {
+			udelay(1);
+			continue;
+		}
+
+		writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
+
+		if (status & RX_SBE)
+			return -EIO;
+		if (status & RX_DMA_DONE) {
+			/* Force the AXI write to retire before trusting the buffer */
+			readl(priv->base + SE_DMA_RX_LEN);
+			invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
+						ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
+			return 0;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_dma_xfer_wait(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				       u8 *rx, unsigned int len, ulong timeout_ms)
+{
+	int ret;
+
+	if (tx) {
+		ret = qcom_geni_spi_dma_wait_tx(priv, timeout_ms);
+		if (ret)
+			return ret;
+	}
+
+	if (rx) {
+		ret = qcom_geni_spi_dma_wait_rx(priv, rx, len, timeout_ms);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* TX/RX_TRANS_LEN and DMA_TX/RX_LEN are 24-bit HW fields; split large transfers */
+#define SPI_GENI_MAX_XFER_BYTES		0xFFFFFF
+
+/* RX DMA requires a cache-line-aligned start and length to invalidate safely */
+static bool qcom_geni_spi_rx_needs_bounce(const void *rx, unsigned int len)
+{
+	return !IS_ALIGNED((ulong)rx, ARCH_DMA_MINALIGN) ||
+	       !IS_ALIGNED(len, ARCH_DMA_MINALIGN);
+}
+
+static int qcom_geni_spi_xfer_chunk(struct udevice *dev, struct qcom_geni_spi_priv *priv,
+				    unsigned int len, const void *txbuf, void *rxbuf,
+				    bool use_dma, bool last_chunk, ulong timeout_ms)
+{
+	u32 cmd, m_param = 0;
+	int ret;
+
+	writel(txbuf ? len : 0, priv->base + SE_SPI_TX_TRANS_LEN);
+	writel(rxbuf ? len : 0, priv->base + SE_SPI_RX_TRANS_LEN);
+
+	/* SPI_TX_ONLY | SPI_RX_ONLY is not a valid opcode, use SPI_TX_RX instead */
+	if (txbuf && rxbuf)
+		cmd = SPI_TX_RX;
+	else if (rxbuf)
+		cmd = SPI_RX_ONLY;
+	else if (txbuf)
+		cmd = SPI_TX_ONLY;
+	else
+		cmd = 0;
+
+	if (!last_chunk)
+		m_param |= FRAGMENTATION;
+
+	if (use_dma) {
+		setbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
+
+		/* DMA: issue M_CMD0 first, then arm DMA descriptors */
+		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
+		       priv->base + SE_GENI_M_CMD0);
+		if (rxbuf)
+			qcom_geni_spi_dma_rx_start(priv, rxbuf, len);
+		if (txbuf)
+			qcom_geni_spi_dma_tx_start(priv, txbuf, len);
+
+		ret = qcom_geni_spi_dma_xfer_wait(priv, txbuf, rxbuf, len, timeout_ms);
+
+		/* Clear M_CMD_DONE so status doesn't accumulate across transfers */
+		writel(readl(priv->base + SE_GENI_M_IRQ_STATUS),
+		       priv->base + SE_GENI_M_IRQ_CLEAR);
+	} else {
+		clrbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
+
+		/*
+		 * Set watermarks before M_CMD0. Only set TX_WATERMARK when
+		 * we have TX data, since SPI_RX_ONLY doesn't use the TX FIFO.
+		 */
+		if (txbuf)
+			writel(1, priv->base + SE_GENI_TX_WATERMARK_REG);
+		/* RX_WATERMARK=0: SE fires RX_FIFO_LAST at end of transfer */
+		if (rxbuf)
+			writel(0, priv->base + SE_GENI_RX_WATERMARK_REG);
+
+		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
+		       priv->base + SE_GENI_M_CMD0);
+
+		ret = qcom_geni_spi_fifo_xfer(priv, txbuf, rxbuf, len, timeout_ms);
+	}
+
+	return ret;
+}
+
+static int qcom_geni_spi_xfer_once(struct udevice *dev, unsigned int len,
+				   const void *txbuf, void *rxbuf, bool xfer_end)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	ulong timeout_ms = qcom_geni_spi_xfer_timeout_ms(priv, len);
+	bool use_dma = !priv->fifo_capable || len >= SPI_DMA_MIN_XFER_BYTES;
+	u8 edge_buf[2][ARCH_DMA_MINALIGN] __aligned(ARCH_DMA_MINALIGN);
+	unsigned int head_len = 0, tail_len = 0, mid_len = len, done = 0;
+	int ret = 0;
+
+	if (rxbuf && use_dma && qcom_geni_spi_rx_needs_bounce(rxbuf, len)) {
+		head_len = min_t(unsigned int,
+				 ALIGN((ulong)rxbuf, ARCH_DMA_MINALIGN) - (ulong)rxbuf,
+				 len);
+		tail_len = (len - head_len) % ARCH_DMA_MINALIGN;
+		mid_len = len - head_len - tail_len;
+	}
+
+	if (head_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, head_len, txbuf, edge_buf[0],
+					       use_dma, xfer_end && !mid_len && !tail_len,
+					       timeout_ms);
+		if (!ret)
+			memcpy(rxbuf, edge_buf[0], head_len);
+		done += head_len;
+	}
+
+	if (!ret && mid_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, mid_len,
+					       txbuf ? (const u8 *)txbuf + done : NULL,
+					       rxbuf ? (u8 *)rxbuf + done : NULL,
+					       use_dma, xfer_end && !tail_len, timeout_ms);
+		done += mid_len;
+	}
+
+	if (!ret && tail_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, tail_len,
+					       txbuf ? (const u8 *)txbuf + done : NULL,
+					       edge_buf[1], use_dma, xfer_end, timeout_ms);
+		if (!ret)
+			memcpy((u8 *)rxbuf + done, edge_buf[1], tail_len);
+	}
+
+	if (ret) {
+		int abort_ret = qcom_geni_spi_abort(dev, priv);
+
+		if (abort_ret)
+			dev_err(dev, "abort failed: %d\n", abort_ret);
+	}
+
+	return ret;
+}
+
+static int qcom_geni_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			      const void *txbuf, void *rxbuf, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	unsigned int len = DIV_ROUND_UP(bitlen, 8);
+	unsigned int done = 0;
+	int ret;
+
+	if (flags & SPI_XFER_BEGIN)
+		writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	while (done < len) {
+		unsigned int chunk = min_t(unsigned int, len - done,
+					    SPI_GENI_MAX_XFER_BYTES);
+		bool xfer_end = (flags & SPI_XFER_END) && (done + chunk == len);
+
+		ret = qcom_geni_spi_xfer_once(dev,
+					      chunk,
+					  txbuf ? (const u8 *)txbuf + done : NULL,
+					  rxbuf ? (u8 *)rxbuf + done : NULL,
+					  xfer_end);
+		if (ret)
+			return ret;
+
+		done += chunk;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_geni_spi_set_speed() - Set the SPI clock for a bus speed
+ * @bus:	SPI controller device
+ * @speed:	Requested SPI clock in Hz
+ *
+ * The Serial Engine source clock is shared by every protocol on the QUP
+ * wrapper, so the rate left by earlier boot stages cannot be assumed.
+ *
+ * This relies on the clock provider implementing the SE clock in
+ * clk_set_rate() and returning the rate it granted. .round_rate is not
+ * used because the Qualcomm clock provider does not implement it.
+ *
+ * The exact rate (oversampling * @speed) is tried first and used if the
+ * provider grants it. Otherwise the source rates are enumerated by
+ * requesting rate + 1 repeatedly, which assumes the provider grants the
+ * first rate that is >= the request, as qcom_find_freq() does. This walks
+ * the source rates in ascending order, as geni_se_clk_tbl_get() does in
+ * Linux. The source rate whose divided output is closest to, and not
+ * above, @speed is kept and the divider is derived from it.
+ *
+ * Return: 0 on success, -EINVAL if @speed is 0 or no source rate can
+ * reach it, or the error from clk_set_rate()
+ */
+static int qcom_geni_spi_set_speed(struct udevice *bus, uint speed)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	ulong req, rate, next = 1, prev = 0, best_rate = 0, best_delta = ULONG_MAX;
+	u32 div, best_div = 1;
+	int i;
+
+	if (!speed)
+		return -EINVAL;
+
+	req = (ulong)priv->oversampling * speed;
+
+	/* A provider that can make the exact rate needs no search */
+	rate = clk_set_rate(&priv->se, req);
+	if (!IS_ERR_VALUE(rate) && rate == req) {
+		best_rate = rate;
+		goto program;
+	}
+
+	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
+		ulong delta;
+
+		rate = clk_set_rate(&priv->se, next);
+		if (IS_ERR_VALUE(rate) || !rate) {
+			if (best_rate)
+				break;
+			dev_err(bus, "failed to set SE clock for %u Hz: %ld\n",
+				speed, (long)rate);
+			return IS_ERR_VALUE(rate) ? (int)rate : -EINVAL;
+		}
+
+		/* Same rate again: the provider has no higher source rate */
+		if (rate <= prev)
+			break;
+		prev = rate;
+
+		div = DIV_ROUND_UP(rate, req);
+		if (div > (CLK_DIV_MSK >> CLK_DIV_SHFT)) {
+			/* Higher source rates only need a larger divider */
+			break;
+		}
+
+		delta = abs_diff(req, rate / div);
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_rate = rate;
+			best_div = div;
+		}
+
+		if (!delta)
+			break;
+
+		next = rate + 1;
+	}
+
+	if (!best_rate) {
+		dev_err(bus, "no SE clock rate for %u Hz\n", speed);
+		return -EINVAL;
+	}
+
+	/* The last probed rate may not be the best one */
+	if (rate != best_rate) {
+		rate = clk_set_rate(&priv->se, best_rate);
+		if (IS_ERR_VALUE(rate) || rate != best_rate) {
+			dev_err(bus, "failed to set SE clock for %u Hz\n", speed);
+			return -EINVAL;
+		}
+	}
+
+program:
+	priv->sclk_hz = best_rate / (best_div * priv->oversampling);
+
+	writel(0, priv->base + SE_GENI_CLK_SEL);
+	writel((best_div << CLK_DIV_SHFT) | SER_CLK_EN, priv->base + GENI_SER_M_CLK_CFG);
+
+	return 0;
+}
+
+static int qcom_geni_spi_set_mode(struct udevice *bus, uint mode)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	u32 val;
+
+	val = readl(priv->base + SE_SPI_LOOPBACK);
+	val &= ~LOOPBACK_MSK;
+	if (mode & SPI_LOOP)
+		val |= LOOPBACK_ENABLE;
+	writel(val, priv->base + SE_SPI_LOOPBACK);
+
+	val = readl(priv->base + SE_SPI_CPHA);
+	if (mode & SPI_CPHA)
+		val |= CPHA;
+	else
+		val &= ~CPHA;
+	writel(val, priv->base + SE_SPI_CPHA);
+
+	val = readl(priv->base + SE_SPI_CPOL);
+	if (mode & SPI_CPOL)
+		val |= CPOL;
+	else
+		val &= ~CPOL;
+	writel(val, priv->base + SE_SPI_CPOL);
+
+	return 0;
+}
+
+static int qcom_geni_spi_claim_bus(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	unsigned int cs = slave_plat->cs[0];
+	unsigned int bpw = slave_plat->wordlen ? slave_plat->wordlen : SPI_WORD_LEN_BITS;
+
+	priv->bpw = bpw;
+	priv->bytes_per_fifo_word = qcom_geni_spi_bytes_per_fifo_word(bpw);
+
+	writel((bpw - MIN_WORD_LEN) & WORD_LEN_MSK, priv->base + SE_SPI_WORD_LEN);
+	writel(cs, priv->base + SE_SPI_DEMUX_SEL);
+	writel(slave_plat->mode & SPI_CS_HIGH ? BIT(cs) : 0,
+	       priv->base + SE_SPI_DEMUX_OUTPUT_INV);
+
+	qcom_geni_spi_config_packing(priv, bpw, true);
+
+	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	return 0;
+}
+
+static int qcom_geni_spi_release_bus(struct udevice *dev)
+{
+	return 0;
+}
+
+static u32 qcom_geni_spi_get_tx_fifo_depth(struct qcom_geni_spi_priv *priv)
+{
+	u32 val, hw_version, depth_mask;
+
+	hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
+	depth_mask = geni_se_fifo_depth_mask(hw_version, TX_FIFO_DEPTH_MSK_256_BYTES,
+					     TX_FIFO_DEPTH_MSK);
+
+	val = readl(priv->base + SE_HW_PARAM_0);
+
+	return (val & depth_mask) >> TX_FIFO_DEPTH_SHFT;
+}
+
+/* QUP v1.0 undersamples the SPI clock and needs 2x the requested bit rate */
+static u32 qcom_geni_spi_get_oversampling(struct qcom_geni_spi_priv *priv)
+{
+	u32 hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
+	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if (hw_major == 1 && hw_minor == 0)
+		return 2;
+
+	return 1;
+}
+
+static void qcom_geni_spi_hw_init(struct qcom_geni_spi_priv *priv)
+{
+	u32 val;
+
+	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	val = readl(priv->base + GENI_CGC_CTRL);
+	val |= DEFAULT_CGC_EN;
+	writel(val, priv->base + GENI_CGC_CTRL);
+
+	writel(DEFAULT_IO_OUTPUT_CTRL_MSK, priv->base + GENI_OUTPUT_CTRL);
+	writel(FORCE_DEFAULT, priv->base + GENI_FORCE_DEFAULT_REG);
+
+	val = readl(priv->base + SE_IRQ_EN);
+	val |= GENI_M_IRQ_EN;
+	writel(val, priv->base + SE_IRQ_EN);
+
+	writel(priv->tx_wm, priv->base + SE_GENI_TX_WATERMARK_REG);
+
+	val = readl(priv->base + SE_GENI_M_IRQ_EN);
+	val |= M_COMMON_GENI_M_IRQ_EN | M_CMD_DONE_EN | SPI_ERR;
+	writel(val, priv->base + SE_GENI_M_IRQ_EN);
+
+	writel(0xffffffff, priv->base + SE_DMA_TX_IRQ_CLR);
+	writel(0xffffffff, priv->base + SE_DMA_RX_IRQ_CLR);
+	writel(TX_DMA_DONE | TX_SBE, priv->base + SE_DMA_TX_IRQ_EN_SET);
+	writel(RX_DMA_DONE | RX_SBE, priv->base + SE_DMA_RX_IRQ_EN_SET);
+
+	/* We always control CS manually, don't let the SE auto-toggle it */
+	val = readl(priv->base + SE_SPI_TRANS_CFG);
+	val &= ~CS_TOGGLE;
+	writel(val, priv->base + SE_SPI_TRANS_CFG);
+}
+
+static int qcom_geni_spi_probe(struct udevice *dev)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(dev);
+	struct icc_path *icc;
+	u32 proto;
+	int ret;
+
+	priv->wrapper = dev_read_addr(dev->parent);
+	if (priv->wrapper == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* NULL (no interconnects property) is not an error, only report failures */
+	icc = of_icc_get(dev, "qup-memory");
+	if (IS_ERR(icc))
+		dev_err(dev, "qup-memory path failed: %ld\n", PTR_ERR(icc));
+
+	ret = clk_get_by_name(dev, "se", &priv->se);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(se) failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&priv->se);
+	if (ret) {
+		dev_err(dev, "clk_enable(se) failed: %d\n", ret);
+		return ret;
+	}
+
+	proto = readl(priv->base + GENI_FW_REVISION_RO);
+	proto &= FW_REV_PROTOCOL_MSK;
+	proto >>= FW_REV_PROTOCOL_SHFT;
+
+	if (proto == GENI_SE_INVALID_PROTO) {
+		dev_dbg(dev, "firmware not loaded, loading now\n");
+		ret = qcom_geni_load_firmware(priv->base, dev);
+		if (ret) {
+			dev_err(dev, "firmware load failed: %d\n", ret);
+			clk_disable(&priv->se);
+			return ret;
+		}
+		proto = readl(priv->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+		dev_info(dev, "firmware loaded, proto=0x%x\n", proto);
+	} else {
+		dev_info(dev, "firmware already loaded, proto=0x%x\n", proto);
+	}
+
+	if (proto != GENI_SE_SPI) {
+		dev_err(dev, "Invalid proto %d\n", proto);
+		clk_disable(&priv->se);
+		return -ENXIO;
+	}
+
+	/*
+	 * SE-DMA is an inherent capability of the GENI SE core (mirrors
+	 * upstream Linux's spi-geni-qcom.c, which never gates SE-DMA by DT
+	 * or hardware version). Only FIFO availability needs checking here.
+	 */
+	priv->fifo_capable = !(readl(priv->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE);
+
+	priv->tx_fifo_depth = qcom_geni_spi_get_tx_fifo_depth(priv);
+	if (!priv->tx_fifo_depth) {
+		dev_err(dev, "Invalid TX FIFO depth\n");
+		clk_disable(&priv->se);
+		return -ENXIO;
+	}
+	priv->tx_wm = priv->tx_fifo_depth - 1;
+	priv->oversampling = qcom_geni_spi_get_oversampling(priv);
+
+	qcom_geni_spi_hw_init(priv);
+
+	return 0;
+}
+
+static const struct dm_spi_ops qcom_geni_spi_ops = {
+	.claim_bus	= qcom_geni_spi_claim_bus,
+	.release_bus	= qcom_geni_spi_release_bus,
+	.xfer		= qcom_geni_spi_xfer,
+	.set_speed	= qcom_geni_spi_set_speed,
+	.set_mode	= qcom_geni_spi_set_mode,
+	/*
+	 * cs_info is not needed, since we require all chip selects to be
+	 * in the device tree explicitly
+	 */
+};
+
+static const struct udevice_id qcom_geni_spi_ids[] = {
+	{ .compatible = "qcom,geni-spi" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_geni_spi) = {
+	.name	= "qcom_geni_spi",
+	.id	= UCLASS_SPI,
+	.of_match = qcom_geni_spi_ids,
+	.probe	= qcom_geni_spi_probe,
+	.priv_auto = sizeof(struct qcom_geni_spi_priv),
+	.ops	= &qcom_geni_spi_ops,
+};
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index 3063b37010d..7abdc76a6ed 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -64,10 +64,18 @@ enum geni_se_protocol_type {
 #define SE_GENI_RX_WATERMARK_REG	0x810
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
+#define SE_DMA_TX_PTR_L			0xc30
+#define SE_DMA_TX_PTR_H			0xc34
+#define SE_DMA_TX_ATTR			0xc38
+#define SE_DMA_TX_LEN			0xc3c
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
 #define SE_DMA_TX_IRQ_EN_SET		0xc4c
 #define SE_DMA_TX_FSM_RST		0xc58
+#define SE_DMA_RX_PTR_L			0xd30
+#define SE_DMA_RX_PTR_H			0xd34
+#define SE_DMA_RX_ATTR			0xd38
+#define SE_DMA_RX_LEN			0xd3c
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
 #define SE_DMA_RX_IRQ_EN_SET		0xd4c

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261006-spi-v6-1caa26821d6a

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

