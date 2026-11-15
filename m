Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65A606A32C
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D18pDL3b;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y60sLstJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F33hCfxz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9B1E607B8;
	Sun, 15 Nov 2026 19:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPrQWmnPC6SN; Sun, 15 Nov 2026 19:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AADE5607B3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769245;
	b=bgRwxlHPy5FYzm3y26r6o9dB9I7AxUXtxhKXlm0KrUZQT9aRb1dm8q83hLGcQdVjJnmu
	 MEme1GPrHjeLaLqBV7pg/DwggmQstIljQb2pHZa4AT+Gzzu5ffPAZMjfSXswsuVR+XV5B
	 FJ8E4hFsc3l5KO7HNwkqkvSA/TUW+D5IpW/Y66YcoeosEXr79sTYKGNdMXtMpeKRZlS69
	 BvHWRSdk/j+AhJwRQgFzcXx4soksgnI4OZEEDgESbDikf5tbumCtzPtpr7i6M5iFmQPel
	 1QrXtJgU8vUx73uf9qFAy8ZwatfwE2XfNbX9uEzC0795D1myocZzfAWWbd/prUGm7fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aFyzN18jVq8hHAKWtgAH49ObmX1B+IN7Qk4QaTzzA6E=;
	b=M5gEB3XE/cUtlED+pxZnUEo/OyUGujt1TgND+C2kdz0xGQeLN0vOIO8sfDjiQVF9jmhW
	 if7P24EbEGNSXr61gKoIqhNe4WEY2BKcQ1G28edoBdSiMht5bndcOJkDaM64cNcq90cNa
	 +5sRC3hwRsqhMwJ630i8ovDJOpN0NAsO0hTFJTlLc0tGpXpRum8SIb1hS0+lca6VoyzPU
	 4l/bYLUcrwSpjoJFBk2tlfF3++omM+g8TazJc0ngU1Zl4gyNh1S97XWrl2k6sgR21SLf/
	 aS6ALSdmdjalLxE9//eR/PtNo+M65EyoAPC1YXTcfnUfbbsW08OGlpeEKmWc8s+PAHw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769245;
	bh=aFyzN18jVq8hHAKWtgAH49ObmX1B+IN7Qk4QaTzzA6E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D18pDL3bJqhWQh3KRlv2S6T1qLMoyAsOKSGNj1Pia6WXwOJFWEC1I+zFPL412AHLq
	 3fHzk6QvI61kL0UBFR3iOcQLzTHeirXKjC5kXY94r+U0b9f+MFFDm6vVn0B+WM2rVp
	 x28DDxOBaA5MPfGPk//hQN1NuabrYyfiEFWD0Ee+OoRuPJr2GetcXvjfI57AmeqLuM
	 Mj0wVQnettT//dnQVnztRGL8qPymZ5qsh91Uq4ubtx1eo2bOL65XYjRBXMOLUuqtTW
	 2PrmT7rfogbKH2W60oscDfI1Q1JLcq1ej1Ko2y8VG4aRyAErnBgWJUjtr8kbwlNozC
	 rUOVhaH6ItpMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AADE5607B3;
	Sun, 15 Nov 2026 19:00:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5A9928C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB5BE405AE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZspbLvsyvHYm for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74A4A40555
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Y60sLstJ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=F33hCfxz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74A4A40555
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:49 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFB7Yg3219059
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=aFyzN18jVq8hHAKWtgAH49ObmX1B+IN7Qk4
 QaTzzA6E=; b=Y60sLstJXD034FzylwOqT9ImRYp1xwiBgjR4ZZAHYA1SQMyG2TB
 awxZASESFEegak71C7J3x5RR9xZ19GkWa4bHyb8aja3XQ9M0oXoUubBWunSLmi9f
 wjUrBk4y9fFuNnRoMZDsVX8Y8/xyq3qRVcZ76puLNBOKDMs8339YFvAkuic06LVH
 YGeA38uNfjT/ApPZwhIL1CwZ65dyyecoyysu55xfK+1tH25Mg5zraGblmoMak1yH
 jux/7XgcS140dm/e16m3HqWeBU2Rpzs/cyvfBI7ZD1VMw7bBo/E6TyplPkbhT3cv
 sbXwpT1xHqw8CP43un5FXeoWOKIzavHcuFA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqkjek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so1071396eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766788; x=1795371588;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aFyzN18jVq8hHAKWtgAH49ObmX1B+IN7Qk4QaTzzA6E=;
 b=F33hCfxz/owK7xzkorczFHcaTzSW3bgOBQsaOaJ7I1lzqGqpOn8K2fCtx6w6BadmBp
 Xy6bJ9/g66hLfAJVo7iIGxNvBJG5rSsmDxJ0WWX7uen+h5TSS4WiY41qAWesl8GedjRz
 /xNLK8cT74jxw7Avoz226BwPAb4Mtw8zP799Pd4UHuYyD0nBU2kxa7stTvP8BeP2h/zN
 FpIZLrrmzOlZIesLITneEnW2c01pqZeSjtuZLnuT84UAeqYYFWHAmds6XDhUxifxQHaW
 8E09JLFCTfjRWVg3nzuTmbPOAT5yz7oBP0TPuMqQ/ZgQoI9i1+NyQM57HjGzHCpq0sGL
 u1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766788; x=1795371588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aFyzN18jVq8hHAKWtgAH49ObmX1B+IN7Qk4QaTzzA6E=;
 b=ZMlLiJIsRsJgzqsv6cxl7T0vAQ9Nk8tvPyudCP8EKQzXLuIifqk2M/27rxefzgu2b3
 Z682vshTmMVvHc7Xx4FWEvymFbCA3ieuhBhnfcSDHIh1prZwxN4YhxazRf/0Vh00tNsp
 7qXr+vfoD0xjRR+K/Zh2s0AxXlzp5QUA5qpocnMx2k0ug1mbM9qLFAEGmNJqFnmKJXut
 PupwPKhr97gZZw2ktP7sef0MxufZNWOQn/yPNjEa2bpswC3tBydPM5pcDZzuRzQA4un5
 1Am3lqkzIB4ENeZIgk52nvenrhGhBtCZcpWNnnAJPgr+D5aR20snZ0RF4S9c52v/LCwB
 D/gQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGVvoZ9lRbkqRVHugbTMGVbifVlxVoKEsxoHxQIn0TyVmjLK5aizxCsr2FGaIQRkOX5mWWtTGM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z82QLALjddtTa1H63oclKNDVOYH1TNhrW3Kr7j4gPOSjrIap5zl
 oGaQ1H9B6lFxF5OPS+s5m5NbGcxr/rV4R7JiAQnSkm/tE4DZPS4+gxTHbHkjWjquPjUQWgnox0y
 XmtoACMH1kKdLwRGH5HtELUi3luyzVrie+RVkFEZQWX7ZEZGQ+uJdicdYldlPPbLfqRG3WeI=
X-Gm-Gg: AYBFou2BcQ5NCmMTHahPrH6FCLZXexc3Bo6mJ/FZyJDXhX5fNyWnmqJjhQBqzx66R/k
 jpUV5o5njFMO3wwTOA0/gF9JIzoSshRi0rVyOwEP+nnzd+ACldYzmksGYi5T4XfEqzQ4Lw0dgBp
 UF1WEhU0+EF4RrOULuJbCrdUmAnK/UNfgSYyzJPX6ecWeYXNDggg/yufPJ4cuo3RTCDrsRbz0nl
 NhHg9LagtawUSrzpDO87CAPGRrp03EB1ALqCvLL3VZCseWKqiLO5YwMyJjJYo2zOxfOxC05dAql
 Vw7uPCjSFwtef0uXL7oBF5ZQhy6R/2A0cNS12RuxBWj5jTtLbREs5udxeMQgoDrmGsCaRp8Zl9K
 naoK69WKwdt1J508sShUb2PwGxT31S2Eu3IrHAS8H7V2OAt7GDT+F4z9AAAwzXBQWyIUotbE5O/
 +O
X-Received: by 2002:a05:7300:c01c:20b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-37967dd6078mr8050132eec.30.1794766788145; 
 Sun, 15 Nov 2026 10:19:48 -0800 (PST)
X-Received: by 2002:a05:7300:c01c:20b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-37967dd6078mr8050113eec.30.1794766787644; 
 Sun, 15 Nov 2026 10:19:47 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:19:47 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 0/6] net: add Qualcomm SA8775P EQOS support
Date: Sun, 15 Nov 2026 23:49:30 +0530
Message-Id: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fNv55AEO6tQmD_cZG-2VRjDONoMemYvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX4bwoUswEjLXQ
 ylJBrHy3QzAt+5soUn04azfrsW2opjB955tGh6CTKQ4biyfKeg8F18WNeVzMcUZTB2rK1SRPMa2
 faTUDoVT5tQCuioSK3GcN/OfJ3Q8T1Yq+A9iUy8rd7EpAvMHUnTKRHiKzMMoNgMrTvnOR1fBdau
 8JsLybL+atYel7eSrmVLzDr0Cb+FdkbNudFma0S6QEtIPZFLib6YeZmwqJnMTUhOA3hc7ZvNcSb
 zxAb+eavmXaoMawNa4hF1JQEXOOnC8qCLhJyLKkJe2+kwOwMa4L7k4mngbZv+4jJ0FKpBwhILJV
 nep1slWIF+O0yrEiiWRhMFjEI2EImuI+RP6LjNAgg4MgGbox8HDbSe/NU5IA6oJxUKiXwyRe5Hg
 MqzwxR/SjF9m/CYryv3MfiHeS0MvKVj6kFe1JdTNAWngtTIzRL+ywSXSkrNNpmcEoCWXylIVv2V
 E0Cv2Nm4RNomKdUELow==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af9f7c5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6uDTiTxmXAtv9Da-m80A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: fNv55AEO6tQmD_cZG-2VRjDONoMemYvJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX0Rybq431NkWF
 QaIOfjrtjolT93OvRVSGe4+ViStV8Bf2D+hlcYLoRsfRTuaI2tH6IN8/2gG/cXhPZU+hCtcVLru
 cnCQORmKB5SjGWyD1vZrG8h5CX8PfxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150072
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

Add support for the DWMAC Ethernet controller and QMP SGMII
SerDes used on Qualcomm SA8775P based lemans platforms.

The series adds the required DWMAC EQOS support, including
platform-specific DMA channel and MTL register offsets and
2.5 Gbps link speed support. It also adds the QMP SGMII
SerDes driver and completes the Ethernet configuration for
the SA8775P-based Lemans EVK.

Dependencies:
https://lore.kernel.org/all/20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com/
https://lore.kernel.org/all/20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com/
https://lore.kernel.org/all/20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com/

Manikanta Mylavarapu (6):
  net: dwc_eth_qos: allow platform-specific DMA channel and MTL offsets
  net: dwc_eth_qos: support 2.5Gbps link speed
  phy: qcom: add SA8775P DWMAC SGMII SerDes driver
  net: dwc_eth_qos: qcom: add SA8775P support
  arm64: dts: qcom: lemans-evk: complete Ethernet configuration
  clk: qcom: sa8775p: add SGMI reference clock

 configs/qcom_qcs9100_defconfig             |   1 +
 drivers/clk/qcom/clock-sa8775p.c           |   3 +-
 drivers/net/dwc_eth_qos.c                  |  51 ++-
 drivers/net/dwc_eth_qos.h                  |  58 ++-
 drivers/net/dwc_eth_qos_qcom.c             | 296 ++++++++++++
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h  |  21 +
 drivers/phy/qcom/phy-qcom-sgmii-eth.c      | 504 +++++++++++++++++++++
 dts/upstream/src/arm64/qcom/lemans-evk.dts |   2 +
 10 files changed, 910 insertions(+), 35 deletions(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
 create mode 100644 drivers/phy/qcom/phy-qcom-sgmii-eth.c


base-commit: 990319a87e60fbc2ac26a386f2ec940e4f97978f
-- 
2.34.1

