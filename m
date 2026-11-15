Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8917606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xxtUH/+7;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oLK/0C7r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VqnHMT80
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77F3480F45;
	Sun, 15 Nov 2026 19:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5q1nBIW9G5S; Sun, 15 Nov 2026 19:00:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44AB680F27
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769247;
	b=H2RH7XRgs8R3/sRxpfX3L8vY+vaTg3xsq5AJ6cTWdfO5wZNy27t0+qWHe6Ihxc2IKbGQ
	 6Tm+c7lO32rz7wlRdfVxqVZLA2RQu2+/3vHuFyI6IvNZzHjJInCE8qG95qO0mGDVpmZYA
	 L3A7Uc+K4HE24OTK2zRGVWA/y8RfsnqpeCBjSMePkJT7fgS9LmCLWasddgTE/9htjKam5
	 R7CZuI33gFno6P2L7KgYlZoUiMDo20h09gBF+bNsjykjNeRNPkFCBiGt8Izn1Sv45SCvt
	 EWB2SJrIOjJgqWAWB4Ix7wIiwSwibBLG13iVWTe97U1WnVSlQuuczHqOB2aB3rWN9Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JbSg/ZRacsnc45pteIBSK/m25QGz7JKp0fcSHEeSHxs=;
	b=A1Q6kLgtfKr6eGNhlxiSlh9iQJDDYs8vp7EBfu4gIODgO8U3y3OyW2seGtgdt2uMP13O
	 mqxWGkoq5tAn+swmIhsoNPwDsIilFfqqCSU3hL340RQTvcCkyXZuhn/Jt4ca4aAMxVP2t
	 Gxa+egihILBAv+awy0G5ZqY6NR8Nwg0Lrkq5bMFDnREQ1sOgLAs6Z0v2FIep7t5JElkZH
	 xBkDe7aF7KE1c+BqEIvSBJde+lYXpDALRXF4E1l8Ot2lpGUo8Ohoj8/4cuMwWsoHADI9A
	 8IARBaYXjfetu1wBl4ppblkw3VOCOEtmhi9lPFDTlMSSl2mxPQaeL+g6RJcR5tvsGDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769247;
	bh=JbSg/ZRacsnc45pteIBSK/m25QGz7JKp0fcSHEeSHxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xxtUH/+7aDbZlaU4EH2+q2fam5yvCS0X2/HRxXvJbG+jgpl/FnzwCqZLLBcTnXfts
	 s+esS1SE/8hSZ9klApVHsLgmII7KBFtTGzul6pqjDRr198gfocFquIS+xI+cfIBkj3
	 o3O2JJrIAUVISsw7Oqgmmxjdey5MgMNti1yaqq/ok8Xwoxtfi5O2rlVG/9lixl86H2
	 h/1Goex8I8HqVkDBxRs5/J7q16SrompXxqOU3mGR46704MkEzmbS66ddR6kA/WaLJO
	 uSDXp2mDYnvj8b+iv0MjpnZyLE7LS66qjI2GlkBmYRoDruoVBBauHE7VRX5tn38Dt5
	 CbGop/2npKcNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44AB680F27;
	Sun, 15 Nov 2026 19:00:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0BFB28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D18040555
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z93WmGjk6xo for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FD75405AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oLK/0C7r; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VqnHMT80
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FD75405AE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFB3PY3219015
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JbSg/ZRacsnc45pteIBSK/m25QGz7JKp0fcSHEeSHxs=; b=oLK/0C7rQmGobDz2
 aEe9fb1zvENVTlsCTVR/NfgxAdS/KwkXe9ROMoU66TYcTwYiljJZtDu+Ba6djB3m
 Vp3Yvq2YhAkR981M5WZQMLY6ui6uNpRYJHeSjA5UGQJa34mxnVhQULfBMeP1+HQy
 +OAsfnlb8nyuVKGnZEE4mJbagUBNh9MYE+vx13Cb1Mkq1Y0zcFE5hu9QmcMaFux5
 YCrniQTYVYE/jQ43yY1vkjJdPWwMe6fcMte/oIi9F/Dazy39kWe+QRO4UtdTp/ra
 EVfnt45s3UquL41q8rzbEJ3FHXnbvmYI47YVrt5M9N2jkPA76f8F8045MJ5OhFaw
 PRqZlg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqkjf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:19:57 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b238436265so1345470c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766797; x=1795371597;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JbSg/ZRacsnc45pteIBSK/m25QGz7JKp0fcSHEeSHxs=;
 b=VqnHMT80vS6UJpxt0pbtWrh/P0rEDoICLD88aAnry2owaMk8MoBG1d8n7SEkbUWD2P
 p5zLwT6r8yR9/eQbV//uwWSsXuOo6yVObIlZNqrX9MS5lx1iEYKPk+2Uo0fm+k7QrR9e
 a9TZB03Gcg9DfV1+oPkO0DFB5p8WbrKmwLWOtHwHJj1jFfSVAEGIrklaaJgwqbmlRisd
 zHK0Qv3keZpmuWaY2Gpc9Xo5dOJIn9PnY/NdSzmQ2ROU4rHWnsl56X4uJo6k2uPX/sPu
 z1uly2dH/INd4PTFEGcpQYPCShQRzGkTJOU3LgeBOJzVPh0Q4WBQ2sngO+hpmrZxZMiu
 5fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766797; x=1795371597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JbSg/ZRacsnc45pteIBSK/m25QGz7JKp0fcSHEeSHxs=;
 b=f8YQqJSJbTdMgyL/i+m3/5LI6YttY7pI4lGkpgfTUUoaK2Ui0wDO9b2Wtq5SCwTvuL
 JrJ9LQb17bxnPzSY+bPXT1dtpjkki5307uc5ZggUxaUQclZrkd5ANRb2dKYgGiDJd/EC
 HA/koPdfJe4cna2sfR1Thzh1nh/WSHl/HIlQrGDQcgXnjc+vt4jGImJ8qHDZyLmvaE8Q
 a0ERPY7Vkbgsvp1ooKVPPzzomx26tlnEPLA3Nt3G9x3ZAwL4n92sEmU4h9W1YUgzTv0O
 KT8hvmmlmJoPsPCVIh7ogOap6RuL6THxxzykjcAm7KZCZ3jCNsqeU7iPIStY3O0frFcM
 l/bQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHAR+zYxJMKHQ+OUnfvDJZr8YoU70ROuce1+QgJF8dUW2UQtD1T02wEBjc5DowoXBIM9ArbtBk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/VOAyBabPuqHzBk0H7I4F+K9dBRP2DpR35ubUoWjhd5VwvC6Aw
 FeJN5ZUE4o15zLyJiwOA09v1iZucZOCW9fagzF+1nMojAut+llogHq3QeY0gWYZ0hL8VeX3e0rp
 wOZY4bCyZ1huQb/4uOgCc6AbmVcbJFfWhmjMf1U7sJ+cDZZRpeJNXwEeA0pX7skC2SCXCAd8=
X-Gm-Gg: AYBFou2CmtOAR8nfJgYPf3siBZr1mGoO7lg9RXF4rNl8t++r0OpVNXCMfwbrTRY0ZXu
 KWqbniOeyNNks7POEFlWLwVedLCeSEAI2VODybLCO73bG606xCZpRKjc5n6tThr1oR+gS2rYRwY
 /CtrC/LWo+wFurSVfsK3wssYT6BY1D3mjJSuu+mTX3p+stitA2A9UwGxHIbyezXioTCyousGfRl
 73+94t2PVtj1af4xqVdtz/lci0XLChyjQ/JYKbHXUs5qG0LF++McTp9gPGW6SZLOVgzbTtftisu
 KUMwUU8cnVKqZ1FatrDJ7e8QVN5ecuojlcu/wQ65F9WHc2l9nN3zG+Q9YeSiEE8BSkt2Fr63eOg
 0h3DqDJTWY7ExoSaaL866gh8nGWV1bRTNC97jNsLrkNqHfwo7bvgADJOrWvuc7Z1FjYte8R0fl/
 ++
X-Received: by 2002:a05:7022:c44:b0:1b2:558a:d777 with SMTP id
 a92af1059eb24-1b50302b6e4mr7509903c88.2.1794766796716; 
 Sun, 15 Nov 2026 10:19:56 -0800 (PST)
X-Received: by 2002:a05:7022:c44:b0:1b2:558a:d777 with SMTP id
 a92af1059eb24-1b50302b6e4mr7509881c88.2.1794766796088; 
 Sun, 15 Nov 2026 10:19:56 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:19:55 -0800 (PST)
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
Subject: [PATCH 1/6] net: dwc_eth_qos: allow platform-specific DMA channel and
 MTL offsets
Date: Sun, 15 Nov 2026 23:49:31 +0530
Message-Id: <20261115181936.1750625-2-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KAgHLzpivT8A9DrXoeyniSM16KzSgWFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX7YLxkC7bpeaS
 1sF1+Q5Kw0TpQRuKOXX2S9sxNuOejP0PkOBYWXC/LZ8ZaSdqp0mNz2VXNjBJRQ1fciw8DGikD+U
 1LXTYpFdT+wJAvDDfqLJXVL19ejZwyHEKvN3iiAKJ0Xxp+KqIwshuK+qvFdFPbtl3YGyNBNwk4M
 1brt72f3fLt/X96aDnY+YqS9ZeVz7K//Gw+rBG5GaDUXuH8uf7+IVfikB8Bj9ak975JR8UeEYTf
 YyRBQk8fKtP1w+cme9ghj90A3I0HPrEAhUd24j6u8hFVIkMCZh5i92KwvT1MKaRXWrnP7T40Tob
 NEYAlJ4J5iOArdHn4FbCesilrruLTOFqbaH/BRZXa5QfhWRxQBxCQ03v7NSSHSt6tiZCz3aB76M
 /efINQPCTy9tBW5qGubszjqG9wTc87a7hG0kofZuAyzS71XjU7k7Wq+9vStKyp8Mtn3uMHi+yVo
 0qW69I2vGSpKK9Rj+2Q==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af9f7cd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2-k0SVyLfpYsC9YwG1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: KAgHLzpivT8A9DrXoeyniSM16KzSgWFi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfXzeQZPolAW0g5
 tM2gWfIhpBvtmcCUBUrMqc3qb7xvhiSmqchPbEyK22CidKiz35nrQ48IkrcsO3qv3iO/tnd2eEm
 H9eWKJ9HQ+Bef7Eldi+QoCofmG9xD9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The EQOS driver currently assumes that the global DMA registers start at
offset 0x1000, the channel-0 DMA registers start at 0x1100 and the MTL
queue registers start at 0x0d00.

This layout is not shared by all EQOS revisions. On SA8775P, the global
DMA registers remain at 0x1000, while the MTL queue and channel-0 DMA
register blocks are located at 0x8000 and 0x8100 respectively.

Split the global DMA and channel DMA register structures and add optional
platform-data offsets for the channel DMA and MTL register blocks.

Keep 0x1100 and 0x0d00 as the defaults when a platform does not provide
the new offsets. Existing platforms, including QCS404, therefore retain
their current register layout.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
 drivers/net/dwc_eth_qos.c | 43 +++++++++++++++++---------------
 drivers/net/dwc_eth_qos.h | 52 ++++++++++++++++++++++++++++-----------
 2 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 565bda088b0..6f158202124 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -936,11 +936,11 @@ static int eqos_start(struct udevice *dev)
 	/* Configure DMA */
 
 	/* Enable OSP mode */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_OSP);
 
 	/* RX buffer size. Must be a multiple of bus width */
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_SHIFT,
 			EQOS_MAX_PACKET_SIZE <<
@@ -949,7 +949,7 @@ static int eqos_start(struct udevice *dev)
 	desc_pad = (eqos->desc_size - sizeof(struct eqos_desc)) /
 		   eqos->config->axi_bus_width;
 
-	setbits_le32(&eqos->dma_regs->ch0_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_control,
 		     EQOS_DMA_CH0_CONTROL_PBLX8 |
 		     (desc_pad << EQOS_DMA_CH0_CONTROL_DSL_SHIFT));
 
@@ -962,12 +962,12 @@ static int eqos_start(struct udevice *dev)
 	pbl = tqs + 1;
 	if (pbl > 32)
 		pbl = 32;
-	clrsetbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_MASK <<
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT,
 			pbl << EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT);
 
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT,
 			8 << EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT);
@@ -1001,16 +1001,16 @@ static int eqos_start(struct udevice *dev)
 	}
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_address);
 	writel(EQOS_DESCRIPTORS_TX - 1,
-	       &eqos->dma_regs->ch0_txdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_txdesc_ring_length);
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, true);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_address);
 	writel(EQOS_DESCRIPTORS_RX - 1,
-	       &eqos->dma_regs->ch0_rxdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_rxdesc_ring_length);
 
 	/*
 	 * Point TX tail pointer at the first descriptor, implying no descriptor
@@ -1018,19 +1018,19 @@ static int eqos_start(struct udevice *dev)
 	 * a packet in eqos_send().
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	/*
 	 * Point RX tail pointer at the last descriptor, implying all
 	 * descriptors are owned by the DMA.
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 
 	/* Enable everything */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
-	setbits_le32(&eqos->dma_regs->ch0_rx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 	setbits_le32(&eqos->mac_regs->configuration,
 		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
@@ -1062,7 +1062,7 @@ static void eqos_stop(struct udevice *dev)
 	eqos->reg_access_ok = false;
 
 	/* Disable TX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
 
 	/* Wait for TX all packets to drain out of MTL */
@@ -1091,7 +1091,7 @@ static void eqos_stop(struct udevice *dev)
 	}
 
 	/* Turn off RX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 
 	if (eqos->phy) {
@@ -1130,7 +1130,7 @@ static int eqos_send(struct udevice *dev, void *packet, int length)
 	eqos->config->ops->eqos_flush_desc(tx_desc);
 
 	writel(lower_32_bits((ulong)eqos_get_desc(eqos, eqos->tx_desc_idx, false)),
-	       &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	       &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	for (i = 0; i < 1000000; i++) {
 		eqos->config->ops->eqos_inval_desc(tx_desc);
@@ -1212,7 +1212,7 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 			eqos->config->ops->eqos_flush_desc(rx_desc);
 		}
 		writel(lower_32_bits((ulong)rx_desc),
-		       &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+		       &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 	}
 
 	eqos->rx_desc_idx++;
@@ -1435,8 +1435,11 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
 
 	eqos->regs = addr;
 	eqos->mac_regs = (void *)(addr + EQOS_MAC_REGS_BASE);
-	eqos->mtl_regs = (void *)(addr + EQOS_MTL_REGS_BASE);
+	eqos->mtl_regs = (void *)(addr + (eqos->config->mtl_regs_base ?:
+					   EQOS_MTL_REGS_BASE));
 	eqos->dma_regs = (void *)(addr + EQOS_DMA_REGS_BASE);
+	eqos->dma_ch_regs = (void *)(addr + (eqos->config->dma_ch_regs_base ?:
+					      EQOS_DMA_CH_REGS_BASE));
 
 	return 0;
 }
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ef07660a765..51ab5469c28 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -151,24 +151,34 @@ struct eqos_mtl_regs {
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_SHIFT		4
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_MASK			3
 
+/*
+ * mode/sysbus_mode are global DMA registers that stay at this fixed offset
+ * on every EQOS revision. The per-channel block below (ch0_*) is relocated
+ * on newer EQOS revisions (Linux: has_emac_ge_3, e.g. SA8775P) — its base is
+ * configurable via eqos_config::dma_ch_regs_base and lives in a separate
+ * struct/pointer so it can move independently of mode/sysbus_mode.
+ */
 #define EQOS_DMA_REGS_BASE 0x1000
 struct eqos_dma_regs {
 	u32 mode;					/* 0x1000 */
 	u32 sysbus_mode;				/* 0x1004 */
-	u32 unused_1008[(0x1100 - 0x1008) / 4];	/* 0x1008 */
-	u32 ch0_control;				/* 0x1100 */
-	u32 ch0_tx_control;			/* 0x1104 */
-	u32 ch0_rx_control;			/* 0x1108 */
-	u32 unused_110c;				/* 0x110c */
-	u32 ch0_txdesc_list_haddress;		/* 0x1110 */
-	u32 ch0_txdesc_list_address;		/* 0x1114 */
-	u32 ch0_rxdesc_list_haddress;		/* 0x1118 */
-	u32 ch0_rxdesc_list_address;		/* 0x111c */
-	u32 ch0_txdesc_tail_pointer;		/* 0x1120 */
-	u32 unused_1124;				/* 0x1124 */
-	u32 ch0_rxdesc_tail_pointer;		/* 0x1128 */
-	u32 ch0_txdesc_ring_length;		/* 0x112c */
-	u32 ch0_rxdesc_ring_length;		/* 0x1130 */
+};
+
+#define EQOS_DMA_CH_REGS_BASE 0x1100
+struct eqos_dma_ch_regs {
+	u32 ch0_control;				/* +0x00 */
+	u32 ch0_tx_control;			/* +0x04 */
+	u32 ch0_rx_control;			/* +0x08 */
+	u32 unused_0c;				/* +0x0c */
+	u32 ch0_txdesc_list_haddress;		/* +0x10 */
+	u32 ch0_txdesc_list_address;		/* +0x14 */
+	u32 ch0_rxdesc_list_haddress;		/* +0x18 */
+	u32 ch0_rxdesc_list_address;		/* +0x1c */
+	u32 ch0_txdesc_tail_pointer;		/* +0x20 */
+	u32 unused_24;				/* +0x24 */
+	u32 ch0_rxdesc_tail_pointer;		/* +0x28 */
+	u32 ch0_txdesc_ring_length;		/* +0x2c */
+	u32 ch0_rxdesc_ring_length;		/* +0x30 */
 };
 
 #define EQOS_DMA_MODE_SWR				BIT(0)
@@ -242,6 +252,19 @@ struct eqos_config {
 	int config_mac;
 	int config_mac_mdio;
 	unsigned int axi_bus_width;
+	/*
+	 * Base offset of the per-channel DMA register block (ch0_*).
+	 * 0 means "use the default EQOS_DMA_CH_REGS_BASE". Newer EQOS
+	 * revisions (Linux: has_emac_ge_3) relocate this block, e.g. to
+	 * 0x8100 on SA8775P, while mode/sysbus_mode stay at EQOS_DMA_REGS_BASE.
+	 */
+	fdt_addr_t dma_ch_regs_base;
+	/*
+	 * Base offset of the per-queue MTL register block (txq0_x/rxq0_x).
+	 * 0 means "use the default EQOS_MTL_REGS_BASE". Relocated to 0x8000
+	 * on SA8775P, same has_emac_ge_3 relocation as dma_ch_regs_base.
+	 */
+	fdt_addr_t mtl_regs_base;
 	phy_interface_t (*interface)(const struct udevice *dev);
 	struct eqos_ops *ops;
 };
@@ -272,6 +295,7 @@ struct eqos_priv {
 	struct eqos_mac_regs *mac_regs;
 	struct eqos_mtl_regs *mtl_regs;
 	struct eqos_dma_regs *dma_regs;
+	struct eqos_dma_ch_regs *dma_ch_regs;
 	struct eqos_tegra186_regs *tegra186_regs;
 	void *eqos_qcom_rgmii_regs;
 	struct reset_ctl reset_ctl;
-- 
2.34.1

