Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C7C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 04:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3B0D606C6;
	Fri, 24 Jul 2026 04:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MBes3z7EFJIm; Fri, 24 Jul 2026 04:44:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CE1460B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784868244;
	bh=Epx/xiSXxkXUnCcYbsW4RdbndxKcNKWGvG0dA7PY9gg=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=uM4dBaQ4Po7vZW52YH0YFcyjX7K0bOmWiwCW0Ma46nqIocuqg2RbE1/ODFzfzhgGi
	 bgucuCxGve2ZRsINW54+rjnPJXBalKjzYicDKenevmE+T0aZuG4naF6iEbnRhe55BT
	 ZNWUTXeGu2ciBx3+mU7dJCL2VQya5iAqWeNzy3DOgKlrJtcYKa2OVMjBvutgpxuk6V
	 CmXHhS3iZeZufRUi89/nlS8H6+CKCE4SQtHGtkAfKUbVRWuxJ8uC7dq+0Bx4aXZffp
	 ylSKCD1a6UhxKccPaenqA5RFNrJmEfPOyqtsWj3hSj3coCfLnYeO/Dnuzu7vhKJAa1
	 Nx6W92nbrukpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CE1460B10;
	Fri, 24 Jul 2026 04:44:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2C5F788
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0647607E6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LRllV3-8UfYo for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 00:34:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=chris.obbard@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1523A6071B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1523A6071B
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1523A6071B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:34:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeGMb1055198
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:34:14 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fknbmj4b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:34:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so24210231cf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784853254; x=1785458054;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Epx/xiSXxkXUnCcYbsW4RdbndxKcNKWGvG0dA7PY9gg=;
 b=VnT32OO1d+LDMhlmhTR5UA0jjwI+Wvh5CbGFzhWBZuM6foooXm6/+RHdJlG0xbAuaV
 VhDe5zRgKJYupKiEzX9GDHvQ8IdPP9hkiPPPR9qXvvPebHfoomstmDj9UXClj2qTE4xf
 GCj4ngUW8qfobl1PKVDZaiOKQG5hBiXSkL8qJpcgV/Kt2n4t1qT7yxF2WgjD4CzYkMNR
 nat+8+JPyYdzK5RtM5Jr1lkbILWxZxbvrXQ/57TqUmtSEqKxvG6/ew1JND9FH9Gv8P4W
 ZM4OVqRxUimZGZLbu55BUn4vyKCyKkR27xrNHGnlj1XH/Fd/gSLayeh1htqm25gkoJZ7
 IPxg==
X-Gm-Message-State: AOJu0Yy/WtAr3AytAPwCyyoH83K2oxi7JmrIUwgMDbJc3k9GhfbZE73Z
 RT2s+GWcmOSw/zmGpHi/fBrA4NNUd2XSKPUtK+AbR2gHFC5fN01JKaXtweZ3K3c2IW0qPqaLweL
 0FJyKXckRUb1EknZ6fdIypr+07nVOd83YoS3cSY/S7zoz5ARLzwLSBRN0IiMCD9wZCC0khVcqtw
 +hh28=
X-Gm-Gg: AR+sD12mf35tpycuR/aRpXQpzwTMHUFtqkBg3bdUr20t8y8R6fAL6JqlMYPGT7O4ZAu
 +3gPcP617ZRcyeUi3EyKSkOY6eIZabmAgjpWxSHwtE+RRZ95zSLXo+vx5aWuteG1a8iIzrg9i29
 Ts3Nqk+Mi8pTSXkxdTkIKPgGwBoE+7/aVEJQBj9s7WvvjnQujmNCtz38mQPxFiRTP9eF00yS7sm
 AOZ6q38ikuHDdzZLY/RcHWFIKgZcJgm/FquGgWg56+GhYn7Ed2SBaXhxAJkkYevpupFitmmOqnD
 lVG1HHfCXgHHWPJ0fAuFZAo9TO0TrkjrfHFyF5myRb9gS47rpoX8TQ550P78I65K6fnzisAYSYS
 BT4e0U0VRLdl6x9Kz0r7dpckCTyxH11ouof6/0BQJkAcrDfcfMBU1a2Q2WsOTTA==
X-Received: by 2002:ac8:7f8d:0:b0:51c:24e7:95f5 with SMTP id
 d75a77b69052e-5283df95808mr52789861cf.69.1784853253780; 
 Thu, 23 Jul 2026 17:34:13 -0700 (PDT)
X-Received: by 2002:ac8:7f8d:0:b0:51c:24e7:95f5 with SMTP id
 d75a77b69052e-5283df95808mr52789611cf.69.1784853253306; 
 Thu, 23 Jul 2026 17:34:13 -0700 (PDT)
Received: from localhost (host86-170-11-80.range86-170.btcentralplus.com.
 [86.170.11.80]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78845sm27464695e9.8.2026.07.23.17.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:34:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 01:34:02 +0100
Subject: [PATCH] mailmap: update entry for Christopher Obbard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-update-mail-oss-qualcomm-v1-1-bf9d3193add3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3dKClMSSVN3cxMwc3fziYt3C0sSc5PzcXF1zC1PzJGMDS0uT1CQ
 loPaCotS0zAqw0dGxtbUAVFUFi2oAAAA=
X-Change-ID: 20260724-update-mail-oss-qualcomm-7857b30994eb
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>,
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=YWyZLLKoVTXUkPSbZ6meommPVAIE8ree7xkrwWMqTds=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBqYrL+fZfYwn+ApG7dTCZQiXhhcF8IIjiariG4P
 OrpjpbzwD2JAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCamKy/gAKCRBjTcTwaHBG
 +IAuEACO0sTdkTZ6ViB2roPohLDV9/Vq8sXxjsVVhlh9llzEPTHxIAqHlDeROBQcSrZKWnTEzlw
 1i2DS17/TduSggHMh2N8vQQYw+CRBYrfmuhI4dvjVDK1CJNFwTSjidD9IEHetH/OxruE8HptbEO
 f8rT9It0axR7Mg5SZe+uDB4w9FQtp3LCT+Cp7RV3anWwRx3vitmQNoksxPvhJxbVoOqvhAfoV5c
 TY/6iPEfPdSZ2fDffSZAe5PKxswEEsMPB0bsB69ayzz5sPbdCea+xwbu49bhkRT9a+aW439wVYp
 o8H5NO+mCbECfGWLYXPqYlYrWwpo8vx3MWvrZO/GqN9ZTqSiJEPJygGT+8MWPY2pn4Oxdpz/H2M
 NXKenHlXw35QXjZcfX2S94Or9QKvodH6EYTFGe0KkCmX8qq1L2Kr7ptRL7XnSF2eNlHM2TynHzV
 Lf5ciTfOKN0De4Um9ZLBeNOUjtOmunitGjsGWKkpAlpL0xx8425j9XuXIxReVnSvIRwT8whkoxH
 q7kyXWGM9j1w+RVpvLJVPRU0WanHp0pZDrFTnnd2YxjLP1tTwWy5qdQ7jd8DhhAL6eIDb1ErqRw
 arCh5C+IyKsFIDTA9rIJ4cG6TJoG3FoNKD4s23OK5UJ8zv7cXUuhRM//TMdFlBRc0pmQV4r1Haj
 iW4sZuM4v9UNJ0w==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Authority-Analysis: v=2.4 cv=e742j6p/ c=1 sm=1 tr=0 ts=6a62b306 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=m0u0x3Iavk+4c1ingEBp/w==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=uP1ucDPQAAAA:8 a=KKAkSRfTAAAA:8
 a=zu6OG0ZhAAAA:8 a=zd2uoN0lAAAA:8 a=Am4ss40yAAAA:8 a=QX4gbG5DAAAA:8
 a=mK_AVkanAAAA:8 a=B7FWZfKwpMBTBuYAiawA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=9a9ggB8z3XFZH39hjkD6:22 a=cvBusfyB2V15izCimMoJ:22
 a=pAN39diAhXWuPx0-Vjn3:22 a=lf-hbUz_c89dky27wAWH:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=3gWm3jAn84ENXaBijsEo:22
X-Proofpoint-ORIG-GUID: JurPPpdHxa46-8dfoPfmXNnPJoc6C2H9
X-Proofpoint-GUID: JurPPpdHxa46-8dfoPfmXNnPJoc6C2H9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAwMyBTYWx0ZWRfX1wpNGQhY/BG9
 OxD9L/U/W3DHanSCenoYyAuxMR9TFvdzVDL2YX2oCYTPO0ivr6fY7F+Ji9MZaODNRGUk0MDCRqk
 aioszxoxM5zocvy9E8wa58y3IQNQ0ZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAwMyBTYWx0ZWRfX442In898i/2p
 gkCmGEC9ujkB+R4lvrgsY6Seuixyns1lUasg4L7EdqGVNP6TY6LLzw1ix/VOK9b1PDvMZkvp/AZ
 7BfUqK+QWJPLDTrMxuR60wf0EIOfY4n3v9odIBFzdjQqXW+Ct95nvFN4shw+bchh7mOjFl49nhF
 B0eeswM8WF3Rq+ylUIndrmk4UbNKMRCBPUo6xkMlnokwnsswRKAvU2KC+4/xUvu7f2LVuagj2Bx
 DaZqmu0JxIenbYRLawHmYQBUeAmBDcNNiTIpapn/1Yv2oRx7eOMOkmHXEqFQmeztNJBQAnpwk1F
 QyvuRLq5/wRggsMyWc0JqUTSfrUezNYNkdMEF7J+yOeKSwQL0JAI5sKTOpd5pbmgBcstN2uBHQX
 GD84Tf0+p481Osrm1xOtO4FN+tlyGL+jfnxuFqNEVMKSqtAUA9DDqD5XDtP3euqEerIY7akoBOx
 R0BoBcLrL9Rt1jv6j7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240003
X-Mailman-Approved-At: Fri, 24 Jul 2026 04:44:02 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Epx/xiSXxkXUnCcYbsW4Rd
 bndxKcNKWGvG0dA7PY9gg=; b=oP0Lu+DE0f/KzOXzYY74xDw06VxS1TItyS7/2C
 LAZkpNzQneHssqomCsk7hptBp0hjS9Y2UIhawvE+ZK42zwW5ggnycbsp/uqo2TCC
 AZE4t8T2PS8sNzjClUxFnYJDlhi5z1wKqZ8oKNsx/Pb0U0yPH3bDTABi7qrYiWMI
 DuOtuE/0+ooEsGalOlLp8fc49rFPNoYjWqjgOu/SCYdtflgk+ISFPRPI0+WMPHz3
 38REesG4Pl4z1QTDX69Rz7TOQo0ILhNGHYAqtY0DbO1tKwRyJOpT7pQlKfEGJQTf
 hY0AuONFTb7PYkr//aibEarZKneSv+SAIk5GNS1Q3xzH8kPw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784853254; x=1785458054;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Epx/xiSXxkXUnCcYbsW4RdbndxKcNKWGvG0dA7PY9gg=;
 b=ZUmArTQEGUISdp4cJ21xmw4iabW1gLfehR7TckYTE4O2iwIHWQdKf8GzL+pg+mb1C6
 8bcXtL177P8syuc+5JHr0P7aseKZl1Z5JeoiA/Ze97eB+MoIQ0laLHl6AOhy/er9qyuT
 FM2IQvQGqPdqsHCCue36YUopsuWxmnD580IpszZSaA2ra3pkpEFcJmR6FDTQ4isHThHt
 r28O07d/SQ3/o1Cv9/HhLMTRsHBES5SPTVL7Cj457C0S12/xKsBmOUz6T+BKSzxQs60r
 9jp0CIkVQCe1vQ+65OdELEth2IxNLZlBZSkI40IKPB/FqAddvpL/ThUgiRoAJrlDJzMY
 E8gg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oP0Lu+DE; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZUmArTQE
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
From: Christopher Obbard via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Christopher Obbard <chris.obbard@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

I have changed employer; update my mailmap entry to point at my new
email address.

Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea3..8f8b834b13d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -41,7 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
-Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
+Christopher Obbard <chris.obbard@oss.qualcomm.com> <chris.obbard@collabora.com>
+Christopher Obbard <chris.obbard@oss.qualcomm.com> <christopher.obbard@linaro.org>
 Dirk Behme <dirk.behme@googlemail.com>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@collabora.com>

---
base-commit: 88226db737b258c36141b66dabe5542b2407f5cd
change-id: 20260724-update-mail-oss-qualcomm-7857b30994eb

Best regards,
-- 
Christopher Obbard <chris.obbard@oss.qualcomm.com>

