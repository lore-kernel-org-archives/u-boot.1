Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A7C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24AC160765;
	Thu, 27 Aug 2026 07:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_RqcU_3muti; Thu, 27 Aug 2026 07:34:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816093;
	bh=AnTviqh9hdTNhgl+YVpK8hMXNory7J7XF/iFko6ZBEQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TaVNPqYqNd/BIgQQWA4MmaQPtBii3/scHp9hMgWfNL1DJyLzsfjvl8mv89mVUCSCo
	 XZLkRkIYJoEsrMLK6+OFKLwxNr4SldEo+gNUVgpkjEiVU/eqawXZLp1vAkVjPjtt1/
	 ERL1oV+a0JJYnAfGuBlJLYbqlP86b3VvQczH1PJuMz+enFhkXVz9HWIQ8ubFt8+VWb
	 FLxXZ2uwsEA6PrFgvddkgsIiX2UL+sinmIlSpECGD5kAxIRxg4ubuinPCWUL4iF97Q
	 668dw+CbgY+0ITX5mcBqxAnF2HvQm7sypkukfWv+Oe7BGv4wi1bQvXrS0evgoTp6jZ
	 oUesKYKDIX+aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FC5E60761;
	Thu, 27 Aug 2026 07:34:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D1E334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 235E34025F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoqsin0C4ZOZ for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:34:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BKj14cII; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aoPxajTs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1165A4009C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RJLE2075189
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=AnTviqh9hdTNhgl+YVpK8hMXNory7J7XF/i
 Fko6ZBEQ=; b=BKj14cIINfIcwBUG5rgpTMfrOaD5azn+fHFXxqXlKAn+7m7lvtZ
 brMp5R2JHjzvGpinWp2Jy53lWJ4Lwwqwfil8ie6pjv+btKmA5oTeOQmRtjSXE/Rf
 c1YpXA6gzPScZm7Vx9ub1F6I8p4oYWdeNI8pDDo0AN0Au5fyDfG+FsWs0IZql9Tk
 RvjQ6Ie4/NNdqxOXdvaq0adI6tO6LWFt9cthZZJpsmvhXdCv2UWoblpdTZ+rD9PN
 0Ndi3SH4t+TvQhjFQ9lWGs4oWB0oxtL+pwQIH794c46UApeL+K83CGKjLtj/t9u2
 wxQUF2N+c/tCeq9O/BwH9kxM4YG2W1jJEOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhdbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfe48ca1efso29258735ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816087; x=1788420887;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AnTviqh9hdTNhgl+YVpK8hMXNory7J7XF/iFko6ZBEQ=;
 b=aoPxajTsKZScFE5/QQqzZ0T8XDGhPGpkh4479sn4/YAH2MK0bts2z8Tx35uuRyUz0C
 FnX5px8kb+8zD14S0OrOFZAUxWUh5XaX0dMwVBW3yn0AuyDl8YjkoSK/jgfbIBc+3Zph
 1uK8Kde97p/xrPl30CEGrqUwwRsedlqsxN3DpV4Fat2s6FQsR22MpOOd9z6TItQ40+4j
 hMmkVXCVrHbcw8hIA1ti2wj0tRk6qpmBrVPTr6WIj9fkKW3SZIsm8Pi0lY6zkJA3HmYj
 hDMtFBz1/WWNGmUTjnfRrDLqJ0A6oHSBoRLHd+8HLLJKcxB/PNEA0lVCl7nYiZLAWMML
 LiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816087; x=1788420887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AnTviqh9hdTNhgl+YVpK8hMXNory7J7XF/iFko6ZBEQ=;
 b=j9WwEWD21BhtDmG7UfK3rYnUBoLLeeg1zbL2FH4GUT6xYZ1eluySK303+uvd6j8V7h
 /3KsdLOIfX7KP7I6B7RDAVVloVXwISSRiZZObDao27GNi9vgMiNdgmW9fcrrDchnYXH9
 bXo9wy+UccTcqZB82GK/vwqrgZOyYDGaLNbCv81XTchxcWhg03jQCQrhM1sYv0/eOU5Z
 MxlU0N08dwWO8X/BWrqdbKkt4PGOL71O/CEWupTR5RR85PFZMQ1OdJn6kJEHddlQ7oIN
 +3qtgJTGIFIhM7DjfWhxT5/IEJmIn9AkHNF/YcQl6srFqq1l88e6S4xgCibZCayxB7MO
 gqow==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfdWWsJpKI6U03YHVfOW7yPno9Wl/PZlwY/dRosqGWlFTlUvaY6J5+ac2V6VLWxV985QLvpl0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ksZ3z0qqARlnLukaF+NGTJGFdT+YBJPKukDRqcNiHH1VNMQv/6
 3BXt3VjJxIUb/MC4BwHmm1G92SyHt5LcX5Dqq637RdXpOGVVjp9ibsJRWNIYyGUIgmK5j8EbojI
 zpKLwW7y10J5bUDky9gfY70NO0Zx85wEaklAjGJYnuwq04nDSl2EzwnSl3TNxRk3Gom2QW58=
X-Gm-Gg: AR+sD123RxTej/nGLVb9Thn8fOjJgcuEbuBpHUb0XBzJHcHtEWHX2C2UNkUryagT6YH
 MfSYQSsdTpJo5r5KRRYidYON8QPTkRiFTAiy8qatnku0nxjdG16MXEPUXz0g+BIK8NHs/jNd8VG
 Z3JAexSBTd5H+ddo2pBqV9AY6rSf1wBXWBhXrHxEbNb75OnnTJk1oJ4F4rVWDxJl02h0WFclvtv
 iY0Dqm6rg3CyLlpQmExETjQKY+LC3plCdcZoP00lbPM8eDDYLkYbK8LLUDCb3MALxADtg8HyEVz
 73Mt6GPNhoQSw4qDaQHJfa9sGq0JMgK3ni04eHJIatWQLPyc5eGeOYYsqW0msYGdWD9zzvyCvYn
 e/uCsN19DGM0jeDk9V5CMfiyAk0ldBvNDt0pFKV0ccPfQRw6ZwdwrQpajXrkN1c5VIdrkrcEJ7v
 zaC/CidO6OCtY+0dWOa1M=
X-Received: by 2002:a17:902:d581:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2d707a0190cmr245783335ad.2.1787816087496; 
 Thu, 27 Aug 2026 00:34:47 -0700 (PDT)
X-Received: by 2002:a17:902:d581:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2d707a0190cmr245782615ad.2.1787816087069; 
 Thu, 27 Aug 2026 00:34:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d886256sm17981719eec.16.2026.08.27.00.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:34:46 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org, xypron.glpk@gmx.de,
 jbx6244@gmail.com, hehongbo918@gmail.com, quic_timple@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/2] serial: msm_geni: Suppress UART TX when debug cable is
 disconnected
Date: Thu, 27 Aug 2026 13:04:34 +0530
Message-Id: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX5Ox2eVhZBRBs
 g4CsSSgOgwcFTItzEqOVUMP3jw8bZqxunp10l/XEISrFAVQO/ms1NjdaeeC9OXJI09aqaajfD8r
 1nHeWXg9oIPmGrIrjPOZzqUfuGPF+bxkD6SL/Ibz+w5qJB+FHzspu+dPFYmPXxEA6hGDxVnxlUd
 WeNlqetUQUNA5djKndHXbUX79Nk9/XwV+DXzXeKy8hdxMZgc2HZlZkPvp3LreUpvwVtOaebelV7
 m5aSn1QNUtopt032mFcsbH3CHt7L6fPL3CTec7aFcQbiUWvII+SmL+KkkH7hGx8ufyLEgeF72kp
 vu45WN7EcCTdOnlVKHQFlughQ94Juv4uIru2Sn0XPgTH6qOs10jzNtnOteN1DbrcittvPLcE4Zq
 adceM3YeTm650NJxiU/oT3iU6nopNNN+t522HY2LzduZZLCYod+6MJQ4lK6lH3jEFccKc1ZNgn9
 9xeqtkTYb46Xr0MeMxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX3rTnlL3JOWDw
 KQD/sGl2nf6okJ5hMs5Jpv2W0Nb/ozq08WwmQEvg8JIfLWe99tqFLAm9MB9n5QG2S1Xlh9CxCP3
 RoV8I2mzTADbvQKTwGwyjfKk/tJLfwc=
X-Proofpoint-ORIG-GUID: _6IdqcatfGa-7Bdv0VgENksIfZXoRUxa
X-Proofpoint-GUID: _6IdqcatfGa-7Bdv0VgENksIfZXoRUxa
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8fe898 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=AtmvOS_uDGeO_hc5ckEA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061
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

This series adds support for detecting a disconnected debug UART cable
on Qualcomm platforms and suppressing serial transmission when no cable
is present.

Aswin Murugan (2):
  serial: msm_geni: Skip UART TX when no cable is connected
  configs: qcom: enable CONFIG_MSM_GENI_SERIAL_CABLE_DETECT

 configs/qcom_defconfig           |  1 +
 drivers/serial/Kconfig           |  9 +++++++
 drivers/serial/serial_msm_geni.c | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

-- 
2.34.1

