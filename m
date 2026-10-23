Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77902606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=knvCQ09e;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EdvwOtcm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jWNtzBeT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F4914094C;
	Fri, 23 Oct 2026 09:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHMP3uE4ILbJ; Fri, 23 Oct 2026 09:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B1754093F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792748853;
	b=TkKL2shuyHm+prs7ce/1VM4YV+4Rc0AjU0gWzeGRiJjKavS5q0sGdzGpTbANzu6CeuJY
	 ZoK+MNf31pyUGGTWGWUjhFJrUBYgRLwGbrlRbBbX2WLD+RLu9OTwpeDTAZWNXCcHb4nzE
	 RhM2AjQoMs3EZz0h6W412DyeNRNYFtgC5PAPJy6b4LzfMbVE56BFkkbxe6i6vHhP5YaLo
	 +WPhVwgkspnvD7UB4N/V8L2sGhb2jgfnn797kxnVmvodHqqBCd0QyuNO1jiZszQV2hAO6
	 uAllBG+79zVHgjLBmg35feW7Y42BMTeCmDAmZPwIuzIbQIapDWchAVlf5Rm6rDp6TNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=;
	b=qP4jrNFZZH/+hKP6X44D/0kgEpsjTycy1Fjjkdqn7gb46p7w9U8C88eVMolqX/ZxQtrb
	 7yz7QX1YhpV6HruSiTLlG2tlHmG0iVb3OwZVN2fo/PtnfZKl4XRL+ygGPv6D6emDmf0w6
	 ffzOFTYEB3TBlvUgbyXO6lmCyj+EkqopxJSoj/Flf8AznvpNBr4+GNz77HTxlCin+L6A2
	 TtCEd15GDR3hAQue4LOZfxHXEcZ2XD5RfDGJhugptxn5Z5ELnrbefKyV0428nFmFW4BG9
	 4WmlSXeE5bWSqe6ohQcgMi88Jt5grkZa03hNnTIkWEGu5Gd3xP7MiuOOAQaPl1oq7gQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792748853;
	bh=+KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knvCQ09eKt6N2uXrRJ6V9ONh7VT0DFnRgTS/9X1+aZsPGowxQVNd9szyYg7F+eycH
	 yE8bhLFMozmVPVHrDJlyBMG/0EWcJ/11QvLOVrfz43YhYrsJnorKggyMT35y8vMTzU
	 9pDNekkySFxspmPM8P78hpMXGoq+J5lX3HzNJyP2oOGNDL9QcmsLnGP30tlHEDawaD
	 MRFt7xq6TuCzJjUFEubuRn1gcndjMUvUgouc+KD18nLqaui53B1vlo+X07h2z1mL+j
	 NJ/x78ZrorFNz4MBEcC6P4N0NwGXz9LI+SbOyuAuplQKIn1d78/VdBemJl4YItX+Wm
	 nDKQJI3OY7vAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B1754093F;
	Fri, 23 Oct 2026 09:47:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2F82371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E534D6065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KA8jYSQ-9WY5 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 228226062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792748851;
 b=NhkW+TDSY4Bjs7ufVYPhWF3mC+Dm/AI2p4IIspiesteqW36Pb0HqLm4J7/18BiG7nM8P
 uDPqTJ6aC4pau6B5sY2vcCYJKxCJY/8Istd6Qq1CUjn4ECHH20927h4EIEX5FK0IhfMeg
 zWSwwd8FznMZs8H3zbpa3/IuBW+3d2LAHfRWp5J7GFwk43YvUOfmVx7XseiOUMgOrRwD8
 EbI27zm6UNlgcd9szHcc2vLIQf53N3c2f4MaZtn/AtNzSW1SRiSxH+3xZ2IyJ8KpLdmNQ
 JxPMub7ayQfhIobKj6aKPSUESt9H+spg9f3szKRPAGxI6mgYjuuhDSxRlOw/TWiGhJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792748851;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=+KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=;
 b=L0WlHBOm5IKpmd2Kqkdy/ONivT1oyJ8f4YzjaGs2yvZESXWRzB+raFtglOS2ICiUEIWo
 u8dCKhji1ynXQFOupWeP3/ap7wKuwFSyoI+hoGpPaupCcOzOe8Mps7YIM24CyCVjJrTf8
 h6tQS6JP4gx8s6+8ehqobrXoNlq+ZIxCJ97uIu+9ET7lM3Ar2RMCcVUhVXadEEfauPqad
 qDJ1O7r+bOt9NhRhw06TkuVltydzf81m3j1w6clbo6leQSsa1Tu1NBtgLBtb2LWLmjwlW
 KpFlZZIqKKHHTt2GY3BCOaRkZcGpSJH8iW2oD347j5IkDjO1FqLP/TnFrml855keuEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EdvwOtcm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jWNtzBeT; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EdvwOtcm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jWNtzBeT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 228226062A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FTdN587910
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=; b=EdvwOtcmmRnwbOX0
 LQm/unh+iV1sCv4+NIXAtV+WgZ/hPIyWTZmFg94GGxezggP9xyioYX0q5u/WnDMh
 TDuI2UWj6yiwJnfaM0JknMlY2ZWFvkGKD/czcPuFJfaM2J9yHpya9EGvSGw0ewcN
 hCkSN2yC0UzJFuT+m8HnssCUDomkCV5el9TstoL8Q197WtTYQznb+j1kDBr3ot5f
 HYDamWSo+pjuFUIRav0MIfOVUCDh1wHpH5AmJiHce6I0qAmHbMkH1C1squYlJM3v
 eMLjibFTV5QNBdrKb2u46BOKHkaWdVbNYZqb8KocVcwUUJ9YCJ6EXGgSp2Ez3vOA
 mnMFxQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmath9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so3037047eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792748849; x=1793353649;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=;
 b=jWNtzBeTd3P+I9CwNG/bvCHQQtDeBdKwwg9RwJjQ/qsLxMhyEwIMYGDLJjuAmB6/PF
 R5cao7HaP0Rf1/LoIUn0t/ZsdF1fyZWf6iYTxJO/tTMedYH1LWbbXYlkfqE3zdWUpnQG
 w+EQy1weJqWoaJk6CiiDTH99sU5GuPDu+DxQUabVv2jpdPCCDBBs+RFKsYcEb5JN90co
 iS043O2b0ejv40k6hA+8VKbwH9m2Xn6kQLGj0uHvm5Cl3pvBw47hPQ0SdAyUvUF9BgkS
 SnNQipK7xYK6oYKptXF+J1q6GfVpFQaq7EqzKocJnyVKhrXQxapWAV0oCscj7R3eap9l
 8UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748849; x=1793353649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+KhGl1tL7C6KebzyvtT8vA8V5Zf9UiRqtNGxcc8bjtg=;
 b=qDm1Mm7jFf2PNZFocRmrUUkCrfitnf+I+AXAlFDT4KPtwNXylGOESnzsak4uxVDjDW
 lwGqtcZToKvULPeNz2M+JN6VvMuZbiM8ILUa13OJoJge9AsWhJnK1GgeD1VGXOb98prA
 Y97MoV5ENz6pllL0ePfw4SKgfgbcy9ZIdsVlPXtt35g8w+VXVFthsei24ZCHzdyGaUhH
 7De9a+ewlj9F+faNu7gQhqIS05LG1dg9xlLK92CjIYl1EqOUbJG3e8kXh4kjI0n6QoiO
 9+JVarZa8svnz/TeIeSf3CiUkbamhOBv9d0AOQb9znSxebuNnmTdFq5kjui+EPR4567l
 gcog==
X-Gm-Message-State: AFq9FYLFoW5DA7Io2eHDqidfoL5yOZl2fhpldQr9wBsyQUlrVX4SPU7o
 Zt8YF6f0h0RspCbaySMsabeAnd0WYPEtzL72U/kb5DjCCyfh1hnhtAKgsbCaD3Ytyz2PbJIQ01X
 GnNtrZKpNUYSo6QNlUmBW/g2cH7g8fUUJYa/p36wYx752sbltjt9n6i9SV6QY3dxItlqhIgs=
X-Gm-Gg: AYBFou1VzbtW/EzG2hID1563V+MSyka7KmQCcrtQgoBnHJfYxHch4Hs/EehRyTmVCRf
 i+qZmiKBpjW6TNS4MmHhayd2bNwNr4BtBVQ0WAB2BXZ0MVISwD1d74wtN+L1OYHSmrbsh4IYRy/
 inoIe/cLMS+5ZRoxQJa9hi8yhO3EZ6o3XOY/lWqgTzWvyJhkZe7JVmeocEpgHQdoWMGTLC6+6xr
 eyacOI9Mbkv82xm+KbAsU+bWopj4cMlSjv5iw696ANSnsbBsSEtScFjklkoLtYz5c8t5wBWNpmu
 vF3sA1zEvULtznmzrmvkJpAEhNPDvey46wacFrmVUM7n8m3yaeUwyISi0tOtSfwnm4oRSGIvBv/
 v+tsWBoTnX2NRTfMoj8j6mdFe2JGBQ6D3300A5AvkAkbLsGwufVoVglWxxntw+0kWiaG22HXofV
 4I8ZFb8iYYkRo2jXgE68drs35z92UWkdK5ZMv1vlQ=
X-Received: by 2002:a05:7300:f283:b0:368:2548:c078 with SMTP id
 5a478bee46e88-369d97823c6mr2148510eec.17.1792748849030; 
 Fri, 23 Oct 2026 02:47:29 -0700 (PDT)
X-Received: by 2002:a05:7300:f283:b0:368:2548:c078 with SMTP id
 5a478bee46e88-369d97823c6mr2148463eec.17.1792748848307; 
 Fri, 23 Oct 2026 02:47:28 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm6071291eec.10.2026.10.23.02.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:47:27 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:17:16 +0530
Subject: [PATCH v2 2/4] mtd: spi: sf_probe: bind SPI-NOR into MTD block
 subsystem
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-series1-spinor-mtd-gpt-v2-2-5d29d32c1289@oss.qualcomm.com>
References: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
In-Reply-To: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748836; l=4349;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=OLZUBSBOxjjovlOQkvIRruMOU+XuGzM2yHBvfOy/52M=;
 b=d2Zj3sUqyMqyQMJKh3s60gxebz5MeISm1WUnAF8xwZHV5dGGxcUlMYRx3gbT5Y9xhVfjLI0yE
 euTGXvZ/dmoABjuyqscTfiBkmPkynIMvTZZDJrNZgPOu19zCwQSflWM
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb2d32 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LsVtK8FelWNE_LftsPcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfXxFeof3r1MkG4
 S1jKhNFs3MdQfFww1JWaZXxIfe0OmNFoP2mv+nI0iTKW5NHwYHB0XYsvJeIXiat2C3+q1G9Q7Eq
 nBl0NSoJ5akP4uIdAwy6JisIyLVOQW4=
X-Proofpoint-GUID: q-ZRHHnwm6eIvapK0HsfuWYUWOqlvdJf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX+rVR0uhBm2WI
 GfHU/gqV5OK0/e3i4truOq6h++6WGHJ8GqPlaWxduwbRDCYefj/ue2+BaZHdAdeY+kobRmHEfTK
 M9wway+5Aw3znqCmNMVjN+WC8uRxDEeYDmpGVP1f49f6AFb0m6p6d0JfZjSnk6dRQoemP/Cl6Yk
 nTbKecO8GfOLcTXA09njrKYYbZL4n643N5BhWlXA0lwuF+kN0EEO0onhQm/S4jp6oJax7PbeckR
 Jn3RciduPhCdWOXBH9Ki1MND32n+JDPEOtqlPgt8Nn2EzwpQh4j0TvRHwJVXbSovzoIkqXuhstn
 0o+MkwnvrK2vqBVIUHseB9gNKGW5sOaUHcOEBdkJBFjLosv7HwC7WARLPAVrUxP6qIzpMGQyKPe
 5deci9uVnqU8UQV1sHWX1lUwd/no67FaY+2qBs+axUxV08rhU/c/gGOX21hu/2FlScGAFiMOZRG
 +3uc+kDkwnahoLXW2vQ==
X-Proofpoint-ORIG-GUID: q-ZRHHnwm6eIvapK0HsfuWYUWOqlvdJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038
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

Bind the SPI-NOR jedec_spi_nor device into the MTD block subsystem
from a new jedec_spi_nor_bind() .bind() hook, matching the
spinand_bind()/mmc_bind() precedent of creating blk children once at
bind time rather than on every probe. Set the block descriptor's
logical block size, log2blksz, and lba from a new
CONFIG_MTD_BLOCK_SIZE Kconfig value (default 4 KB) instead of a DT
property, matching the sector size GPT images are generated with.

No changes to mtd_bind()'s signature or behavior for existing
callers.

.bind() runs exactly once per device lifetime, so the mtdblock child
is created unconditionally there. Probe-time only looks the child up
via blk_find_from_parent() to refresh the mtd_info pointer and block
geometry (blksz, log2blksz, lba, part_type), which must still happen
on every probe since flash->mtd is only valid after spi_nor_scan()
succeeds. If the lookup fails, that is a real error (the child
failed to bind), reported via dev_err() and unwound through the
existing err_read_id path, which is a generic post-spi_claim_bus()
cleanup and not specific to ID-read failures.

Wrap the block in a preprocessor '#if CONFIG_IS_ENABLED(MTD_BLOCK)'
guard instead of a runtime check, since CONFIG_MTD_BLOCK_SIZE is only
emitted to autoconf.h when MTD_BLOCK is enabled; referencing it
unconditionally fails to build with MTD_BLOCK disabled.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/mtd/Kconfig        |  9 +++++++++
 drivers/mtd/spi/sf_probe.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..c3142c470d5 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -39,6 +39,15 @@ config MTD_BLOCK
 	  Enable support for block device access to MTD devices
 	  using blk_ops abstraction.
 
+config MTD_BLOCK_SIZE
+	hex "MTD logical block size"
+	depends on MTD_BLOCK
+	default 0x1000
+	help
+	  Logical block size exposed by mtdblock/ubiblock devices to the
+	  block layer. This is the sector size used for GPT partitioning,
+	  not the underlying flash erase size.
+
 config SYS_MTDPARTS_RUNTIME
 	bool "Allow MTDPARTS to be configured at runtime"
 	depends on !COMPILE_TEST
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index dee03662d45..1540dfdb617 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -9,12 +9,15 @@
 
 #include <dm.h>
 #include <errno.h>
+#include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 #include <log.h>
 #include <malloc.h>
+#include <part.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <spi-mem.h>
+#include <dm/device_compat.h>
 
 #include "sf_internal.h"
 
@@ -100,6 +103,28 @@ static int spi_flash_probe_slave(struct spi_flash *flash)
 	if (ret)
 		goto err_read_id;
 
+#if CONFIG_IS_ENABLED(MTD_BLOCK)
+	if (CONFIG_IS_ENABLED(DM_SPI_FLASH)) {
+		struct mtd_info **plat = dev_get_plat(flash->dev);
+		struct udevice *bdev;
+		struct blk_desc *bdesc;
+
+		/* The mtdblock child is created by jedec_spi_nor_bind(). */
+		ret = blk_find_from_parent(flash->dev, &bdev);
+		if (ret) {
+			dev_err(flash->dev, "mtdblock child not found: %d\n", ret);
+			goto err_read_id;
+		}
+
+		bdesc = dev_get_uclass_plat(bdev);
+		*plat = &flash->mtd;
+		bdesc->blksz = CONFIG_MTD_BLOCK_SIZE;
+		bdesc->log2blksz = LOG2(bdesc->blksz);
+		bdesc->lba = lldiv(flash->mtd.size, bdesc->blksz);
+		bdesc->part_type = PART_TYPE_UNKNOWN;
+	}
+#endif
+
 	if (CONFIG_IS_ENABLED(SPI_DIRMAP)) {
 		ret = spi_nor_create_read_dirmap(flash);
 		if (ret)
@@ -253,13 +278,23 @@ static const struct udevice_id spi_flash_std_ids[] = {
 	{ }
 };
 
+static int jedec_spi_nor_bind(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(MTD_BLOCK))
+		return 0;
+
+	return mtd_bind(dev, dev_get_plat(dev));
+}
+
 U_BOOT_DRIVER(jedec_spi_nor) = {
 	.name		= "jedec_spi_nor",
 	.id		= UCLASS_SPI_FLASH,
 	.of_match	= spi_flash_std_ids,
+	.bind		= jedec_spi_nor_bind,
 	.probe		= spi_flash_std_probe,
 	.remove		= spi_flash_std_remove,
 	.priv_auto	= sizeof(struct spi_nor),
+	.plat_auto	= sizeof(struct mtd_info *),
 	.ops		= &spi_flash_std_ops,
 	.flags		= DM_FLAG_OS_PREPARE,
 };

-- 
2.34.1

