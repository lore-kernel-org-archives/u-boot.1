Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DE606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xqdWhU7A;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnXtQrXd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JFtPbtNU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2046360DD5;
	Fri, 20 Nov 2026 14:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbJNsVWLiV7X; Fri, 20 Nov 2026 14:07:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6724060B8C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795183653;
	b=Jx3yO6nQKGHZUqVMtxKOo2Gz7zIOtUwvzkDqx+NZTV0jjcyzSEaGog8ZXTL3M1cRb5Zz
	 Ql8A/2uV0AzhtbdIMNu2/r9qWw32TAMKnsSVzFRG5VEAP4EYvTshTN6cvWcXL3XvLqQgT
	 ST6FB50LXXFj4sAOZz5jrkoefOjVoHdjBnVFlf8BOsgMdmjWtYqRttLPfpSo6Q5O2wESX
	 jSLTqgTJTcG6Ya2i4Ls+zevPW7S00sweSxUhBTg25hz8mRhNmVgfawTkNhDKunBXuR6iP
	 TZ43DmOrNrqEd5atzHvD+KxAiiPxoNG38S6H+05u3CedKexkkw/zd9oaioCpYhZp04w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795183653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wOfDnXZv4hlHYUa01TxxdoQIv4m87MUZ5k/lahea1Go=;
	b=C6F7BjPhwv1/JRt9NlaK3wvJkiDuSwRbbo/jlck1jtBObcWoODOSg7ntkr2AkgmJnlTi
	 SHfshulWE44+lLfD+xn3u8csLOeSK8kxcHXnuH4ac3tleFNzWxHGOGuinJf/k347a7uWN
	 99Ozd7yNOl2QMKhmm4Yhh8y0MxZg3Izi7BaNi3vrNgEvEImZSbdAsnsYdmITyjsWF9fhV
	 BVLDL2Ml82obzVqMLS+nBb9s50gHOp6M66vQytrC8yKVEzietgT1XsyYiOwmKqWLpdqLC
	 naa85+PMAm1wltHnJ61F6Q5whrFlOT8xSDwx3vO7D3COIPmxhDDV2JQuZwfBSVisY5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795183653;
	bh=wOfDnXZv4hlHYUa01TxxdoQIv4m87MUZ5k/lahea1Go=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xqdWhU7AkY+iARON9fmOQXGbGYavhg1z4FVGnvDF9m/vEjWBpQAzz2kJpWCXexEhf
	 +TpBYx8xfKwFDCM4MpvZl1vOXIwC5ZYMg70fTBIj6bLYihnamJYo24TGFJb4MgncmZ
	 GXrwka55jckGrSW++cBkzNiWQvpC9vWJXsddcvytYCz5h3/ltGjw61TTDkEzF8QOXJ
	 F1kb1xFtRDtTQ4n+83oGH5D9A9Iq4UNamtXjVObZcHLG3QA2fw+1vMsK7Q3THsUV0a
	 UWzLfUIkWl8eyjpJ/kkJN7tzAZXambIar9E2roAGIN2LaywC9WKZR8zfwHQ6PE46bt
	 BEqDsNppsqPOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6724060B8C;
	Fri, 20 Nov 2026 14:07:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ECC415D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8E9681698
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XSnXOzDAggi for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A544181542
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=gopinath.sekar@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cnXtQrXd; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JFtPbtNU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A544181542
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:30 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAjq081681896
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wOfDnXZv4hlHYUa01TxxdoQIv4m87MUZ5k/
 lahea1Go=; b=cnXtQrXd1PBwm/yD8CLMeNMlAOrv5/BYBxtofCssplS5Yrrmd+R
 bGApASvP8CtxsNuPr2lAdc5oaaMYAuC1ZH8Z6u4qoKVEAo7T/Eloi73Ey5Uevmms
 fmZfS23A9fZfq31m2rhj4EuUVtQsw+2lZ+EAI5nIXlv/2tlJy2YSh2V0RPLKOHt4
 XhmeWw8LIoZrt7b+gbLz+n1HS5ZHH6Df3Fq0hE0BKqR4F6ZIOWgZ7ql5fyRxqbJj
 gUid+YFIhck3jGqwSbWsQw0u7DFj90X8XSLIdc1ZRzIu3ocxc60es2KA249grwKh
 8jRYkCIimQr+PJ9gC/ZVeuRcbEEVEXe4nhQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1tt9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-385507d6e0bso102197eec.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795183649; x=1795788449;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wOfDnXZv4hlHYUa01TxxdoQIv4m87MUZ5k/lahea1Go=;
 b=JFtPbtNUlu0HsCqLGAFkNHjkF/W9FxIgDghUSJax0h0tkAApw9y8tTdNm4YUnlPBTC
 SutJbmCnNgDAGcwFmiFs+0Bu199bMmpsXPUl/IOuGy05s9htP60aECwgEs7T//PPZkPi
 mpC0QqvSEgY5Wx6D0rvgMZERF6i7YUk0q7WC4PE3QV30qPB1EMW7CGMl+wj8+jCKqKzB
 5CAOKdBq7n/B3OFdo+7kZ/OAS7U5ZlNfW7D6ocFQaJYnciE/1oj4gGr0G85hEXqzpe1X
 soz7bnie2olimoDVVOobaNFA90qW1U3Mlv9aOoUfqZxyzwqHoXM6R/MkeNXutgYeviEN
 zpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183649; x=1795788449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wOfDnXZv4hlHYUa01TxxdoQIv4m87MUZ5k/lahea1Go=;
 b=Xg+Um/DarxRfYd5zXiA/zDYxZsseG9b7tta2nDmzdnzAbkjoAdTn7YdWd9v0XGKP3G
 tQU62RjRLzIH53vGJBOIZmPi6C3IwCfiep9x7hnYWfY9gajUESnlGpwrLCJrokeHdLI7
 Of1MnjHXRgr+FRvLzbAUYgSQjR97rVqtfJC/5ARLS8cMiY3cp23DXwECf+2Sg+D4hZUe
 FppbHTeFA2+dI2JUmOugO8jNsl1WYc9YYaao/pG2TlgBgvGy2nt9Am9KskP3Y2HXdVpb
 EwrKGllJuEQVn+aF4D3glpQ0gKDXOc3ccYHz7oDzj2dHB9ib0vn3FZfcKIH/m+eTH7FK
 lREw==
X-Forwarded-Encrypted: i=1;
 AL+hErGQlgHT3XiLCk1YvnnB70htu6+/s5n4GB5/sKokWfLhIEbX2e0zSvPL0igh5Fuve20DOWrs1u4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9hf2DD7/23lc24DrRV+IUItZXdiz7+63V5M1Mp9HhEI95BqFjr
 /eFpafPGwK5rBGr5bgyt9yINNuoL5qUwYB8ZiG0RMpROeF2fMzzER2d8fvGAtKbOoLPoNSyzgcS
 LdW9PQ62fzyelkauKcUDdF797ciI25Dgm6cgWMa3Bw6eKAhwV6bis7Dqm3xFi/6TRQl1Wyls=
X-Gm-Gg: AZFdTZd2vBtQImR8b3lkNdlnnmf+dc/tuwkkCj95KgkrRMUcC0QcPh7Od+aUmko/o86
 CNrAQl1zVfjQIzw7MpW4SmykLC7IlavmsrqfYI/Xx3AorjZPM52ysl6n+hztWPtyLunFiFsYII6
 jMp6nrw1kTjj0p+NT4sxkYimK1132LpzB5aTCBlAL6AiY6zGG1DtaXTmOAVZgyzgOS+8nuaEfPK
 cLd0KsTcD9ZRAUMezG1B5rw5OWZKufKxkkiNjSbL7kwx3q4ADcWfKOXEQapVcECHfmbrywqw86t
 QMUKm+PH4kK7SUERdKm1L4uFHPTjQQxgLSBdw/huKMrkzZ3NqDMZA3h9GY+1Af+bEAhke7yS/x/
 JFW4/oQ1wvr7OKBmtHqo2Kr3aW+zSvoUroSvIvBxI/JjO/OE+ISAFmZ0spirrJff5GwW/HDPo9L
 UWMDd7EkySt0ATllkJulL9T8eKFVLk9bqw73oiqCRcL2kfDdGhE/m720UuXY8Tx/1jSHqi
X-Received: by 2002:a05:7301:239e:b0:372:c0ee:875b with SMTP id
 5a478bee46e88-38569160c44mr4907551eec.0.1795183648827; 
 Fri, 20 Nov 2026 06:07:28 -0800 (PST)
X-Received: by 2002:a05:7301:239e:b0:372:c0ee:875b with SMTP id
 5a478bee46e88-38569160c44mr4907503eec.0.1795183648254; 
 Fri, 20 Nov 2026 06:07:28 -0800 (PST)
Received: from hu-gsekar-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm9565582eec.14.2026.11.20.06.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:07:27 -0800 (PST)
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, gopinath.sekar@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] board: qualcomm: add Volume Down fastboot shortcut
Date: Fri, 20 Nov 2026 19:37:06 +0530
Message-Id: <20261120140706.3184114-1-gopinath.sekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b005421 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=IZfmboan6Hwv_WtaVyoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ThSnM_PP6C5bFYTSsRyurtJndYxVr8DF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NiBTYWx0ZWRfXy4OZ2VVYSXed
 4Rh659orsQA4aBNKY/AzWJJv6OZwCTZXR6aJUKs0Rf5c0F65fVhzVujuf6t8rpjlQSUgHOTIS2v
 cyGtHVZxHr7Sz+q4xniOOzoZLTRAkSnlTm6SyAmzLKbMfaM67tRGPZfD+t/DZ/XxYOIWGf3sMRr
 nitinJmHd/4Mi9juZrcfmAFkeqRMkoGcg6K0I6jlulsu7qBUpCKCjnQBLtS4vMRXvlQX16eNNGX
 4ud7bLyjfk9jYTCZzuo03VZjufraHG+2TQwJi4JaFHqrHokVLGdzX4QzjYjcUj+fuRpyQ1NfWYv
 87YdYhFfL4Qlkvbj9s0VkBVN68lEmzSp4NgWeAerCVPcJQSEeV+iSxbpR6AB4hvQ3g7Hap/6/SD
 1PwflH2JbQx9ScZ8QdqFp54XLPIr83RyUfheitxCGrBuYKFi2tp5TLsnQewVqOU2/yDxslE/h2U
 9Vm8JsCaFjaw66UaT+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NiBTYWx0ZWRfXx+rSbi8891kf
 lachdpmeNfejaG6tL1NlZ4FySLbXws1lMPr7Qt1QMhYj85KWDSbo2Xbev9J98PawiAvn9t8Cq1O
 3OHGZ9tagKtBQKfQhh4EbU2OmxiuVgo=
X-Proofpoint-ORIG-GUID: ThSnM_PP6C5bFYTSsRyurtJndYxVr8DF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200056
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

Map the Volume Down button to the fastboot command. On platforms where
the key is configured through the PON RESIN button node in the device
tree, holding Volume Down during U-Boot startup enters fastboot mode.

Signed-off-by: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
---
 board/qualcomm/default.env | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index 4f5d3854501..b7b3388d62c 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -8,3 +8,5 @@ bootmenu_1=Enable fastboot mode=run fastboot
 bootmenu_2=Reset device=reset
 menucmd=bootmenu
 bootcmd=run do_boot
+button_cmd_0_name=Volume Down
+button_cmd_0=run fastboot
-- 
2.34.1

